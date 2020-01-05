//%attributes = {}
  //  Import_form_controller ()
  // Written by: Kirk as Designer, Created: 10/13/19, 09:54:01
  // ------------------
  // Purpose: form controller for the 'import_form'


C_TEXT:C284($1;$2;$action;$errMsg)
C_POINTER:C301($ptrCurrent;$ptrObj;$nil)
C_OBJECT:C1216($newMap_obj)
C_COLLECTION:C1488($dataMap_col;$map_col)
C_TEXT:C284($header_str)
C_LONGINT:C283($j)
C_TEXT:C284($menu;$result)


$ptrCurrent:=OBJECT Get pointer:C1124(Object current:K67:2)
If (Count parameters:C259=0)
	$action:=OBJECT Get name:C1087(Object current:K67:2)
Else
	$action:=$1
End if
  // ------------------------------------------
  // $obj:=new object


  // ------------------------------------------
Case of
	: (False:C215)  ///// buttons /////
	: ($action="btn_runImport")
		  // what to do with the parsed data?
		$menu:=""

		If (Form:C1466.updateObj.table#"")
			$menu:="Write records to "+Form:C1466.updateObj.table+";---;"
		End if

		$menu:=$menu+""

		$result:=TPL_get_element ($menu;Pop up menu:C542($menu);";")

		Case of
			: ($result="")

			Else
				$errMsg:=Import_RUN (Form:C1466.paramObj;Form:C1466.updateObj)
		End case


	: ($action="")
	: ($action="")
	: (False:C215)  ///// form objects /////
	: ($action="tabControl")
		Case of
			: ($ptrCurrent->=1)
				OBJECT SET SUBFORM:C1138(*;"subform";"import_sub_1")

			: ($ptrCurrent->=2)
				If (Length:C16(import_text)>0)
					OBJECT SET SUBFORM:C1138(*;"subform";"import_sub_2")

				Else
					$errMsg:="No text has been specified yet."
					$ptrCurrent->:=1
				End if

			: ($ptrCurrent->=3)
				OBJECT SET SUBFORM:C1138(*;"subform";"import_sub_2")

		End case

	: ($action="subform")

		Case of
			: (Form event code:C388=-99)

		End case

	: ($action="")
	: ($action="")
	: (False:C215)  ///// form actions /////
	: ($action="")
	: ($action="")
	: ($action="formEvents")
		Case of
			: (Form event code:C388=On Load:K2:1)
				Form:C1466.subformData:=Form:C1466.paramObj

				OBJECT SET SUBFORM:C1138(*;"subform";"import_sub_1")

				ARRAY TEXT:C222(tab_list_array;0)
				COLLECTION TO ARRAY:C1562(Form:C1466.tab_list;tab_list_array)

				If (Form:C1466.paramObj.fileObj#"")
					Form:C1466.paramObj.fileSize:=String:C10(Round:C94(Get document size:C479(Form:C1466.paramObj.fileObj)/1000000;2))+" MB"
					Parser_read_importFile (Form:C1466.paramObj;->import_text)
				End if

			: (Form event code:C388=On Outside Call:K2:11)
				CANCEL:C270
		End case
	Else
		$errMsg:="Unknown action or object: "+$action  // +"\r\rForm Event: "+4D_FormEvent_text+"  {"+Current method name+"}"
End case

  // ------------------------------------------
If ($errMsg#"")
	ALERT:C41($errMsg;"Close")
End if
