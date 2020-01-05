//%attributes = {}
  //  Import_sub_form_controller ()
  // Written by: Kirk as Designer, Created: 10/30/19, 07:37:39
  // ------------------
  // Purpose: this form is for selecting text to parsed and/or imported


C_TEXT:C284($1;$2;$action;$errMsg)
C_LONGINT:C283($0;$form_return)
C_POINTER:C301($ptrCurrent;$ptrObj)
C_OBJECT:C1216($obj)
C_COLLECTION:C1488(import_data_col;$data_col)

$ptrCurrent:=OBJECT Get pointer:C1124(Object current:K67:2)
If (Count parameters:C259=0)
	$action:=OBJECT Get name:C1087(Object current:K67:2)
Else 
	$action:=$1
End if 
  // ------------------------------------------
$obj:=New object:C1471
$data_col:=import_data_col

  // ------------------------------------------
Case of 
	: (False:C215)  ///// buttons /////
	: ($action="btn_chooseFile")  //  choose an import file
		Case of 
			: (Form:C1466.fileObj=Null:C1517)
				OK:=0
			: (Form:C1466.fileObj.exists=True:C214)
				CONFIRM:C162("Reimport the selected file?";"Yes";"Select a new one")
			Else 
				OK=0
		End case 
		
		If (isOK )  //  reimport
			$newFile_obj:=Form:C1466.fileObj
		Else   //  choose new
			$newFile_obj:=Choose_single_file (New object:C1471("type";".txt;.text;.csv;.tsv"))
			Form:C1466.fileObj:=$newFile_obj
		End if 
		
		If ($newFile_obj#Null:C1517)
			OBJECT Get pointer:C1124(Object named:K67:5;"import_text")->:=Document to text:C1236($newFile_obj.platformPath)
		End if 
		
	: ($action="")
	: ($action="")
	: (False:C215)  ///// fields /////
	: ($action="import_text")
		
		
	: ($action="")
	: ($action="")
	: ($action="")
	: (False:C215)  ///// form objects /////
	: ($action="")
	: ($action="")
	: ($action="")
	: ($action="")
	: (False:C215)  ///// form actions /////
	: ($action="")
	: ($action="")
	: ($action="")
	: ($action="")
	: ($action="formEvents")
		Case of 
			: (Form event code:C388=On Load:K2:1)  //  fires each time the form is loaded
				  // what goes in 'import_text'?
				Case of 
					: ($data_col.length>0)
						
						If (dataCol_to_text (OBJECT Get pointer:C1124(Object named:K67:5;"import_text"))=0)
							$errMsg:="Couldn't read the data collection."
						End if 
						
					: (Form:C1466.filePath#Null:C1517)  //  file is defined
						Case of 
							: (Not:C34(Form:C1466.fileObj.exists))
								$errMsg:="This file doesn't exist."
								
							Else 
								OBJECT Get pointer:C1124(Object named:K67:5;"import_text")->:=Form:C1466.filePath.getText()
								
								If (Length:C16(OBJECT Get pointer:C1124(Object named:K67:5;"import_text")->)=0)
									$errMsg:="Couldn't read the data collection."
								End if 
						End case 
						
					Else 
						
				End case 
				
		End case 
	Else 
		$errMsg:="Unknown action or object: "+$action+"\r\rForm Event: "+4D_FormEvent_text +"  {"+Current method name:C684+"}"
End case 
  // --------------------------------------------------------

Form:C1466.fileSize:=String:C10(Round:C94(Length:C16(OBJECT Get pointer:C1124(Object named:K67:5;"import_text")->)/1000000;2))+" MB"



  // ------------------------------------------
  // $0:=$form_return
4D_ALERT ($errMsg;Current method name:C684)

