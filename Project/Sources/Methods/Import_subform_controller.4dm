//%attributes = {}
  //  Import_subform_controller ()
  // Written by: Kirk as Designer, Created: 10/13/19, 12:07:11
  // ------------------
  // Purpose: this is the immport controller for the subforms
  //  "import_sub_1"  Form  = $param_obj
  //  "import_sub_2"  Form  = $param_obj
  // Modified by: Kirk (10/21/19)   import_text

C_TEXT:C284($1;$2;$action;$errMsg)
C_LONGINT:C283($0;$form_return)
C_POINTER:C301($ptrCurrent;$ptrObj)
C_OBJECT:C1216($obj;$newFile_obj;$this_item;$paramObj;$field_obj)
C_LONGINT:C283($row;$column)
C_COLLECTION:C1488($selFields;import_data_col)
C_TEXT:C284($import_text)


$ptrCurrent:=OBJECT Get pointer:C1124(Object current:K67:2)
If (Count parameters:C259=0)
	$action:=OBJECT Get name:C1087(Object current:K67:2)
Else 
	$action:=$1
End if 
  // ------------------------------------------
  // Form is the $param_obj from IMPORT_TO_RECORDS


  // ------------------------------------------
Case of 
	: (False:C215)  ///// buttons /////
		
		
	: ($action="btn_setTable")  //    set the default import table
		$paramObj:=New object:C1471
		$paramObj.chooseWhat:="table"
		  // $paramObj.fieldType:=New collection(Is object;Is text;Is alpha field)
		  // $paramObj.tableList:=New collection("Order@")
		$obj:=Struct_choose_byMenu ($paramObj)
		If ($obj=Null:C1517)
			$errMsg:="Hmm, it doesn't look like there are any tables in this database."
		Else 
			Form:C1466.table:=$obj.name
		End if 
		
	: ($action="btn_match")  //       attempt to match the import fields to the table
		Case of 
			: (Form:C1466.table="")
				$errMsg:="Identify the import table first."
				
			: (Form:C1466.dataMap.length=0)
				$errMsg:="Import the data document first."
				
			Else 
				Import_match_headerToField (Form:C1466)
				Form:C1466.dataMap:=Form:C1466.dataMap
		End case 
		
		
	: ($action="")
	: ($action="")
	: ($action="")
	: (False:C215)  ///// form objects /////
		
	: ($action="fieldDelims")
		OBJECT SET VISIBLE:C603(*;"recDelim_code";False:C215)
		
		Case of 
			: ($ptrCurrent->=0)
			: ($ptrCurrent->=1)  // comma
				Form:C1466.delim:=","
				Form:C1466.delimCode:=String:C10(Character code:C91(","))
				
			: ($ptrCurrent->=2)  // tab
				Form:C1466.delim:="\\9"
				Form:C1466.delimCode:=String:C10(Character code:C91("\t"))
				
			: ($ptrCurrent->=3)  // space
				Form:C1466.delim:=" "
				Form:C1466.delimCode:=String:C10(Character code:C91(" "))
				
			: ($ptrCurrent->=4)  // other
				OBJECT SET VISIBLE:C603(*;"recDelim_code";True:C214)
		End case 
		
	: ($action="recDelims")
		OBJECT SET VISIBLE:C603(*;"eolDelim_code";False:C215)
		
		Case of 
			: ($ptrCurrent->=0)
			: ($ptrCurrent->=1)  // return
				Form:C1466.eol:="\r"
				Form:C1466.eolCode:=String:C10(Character code:C91("\r"))
				
			: ($ptrCurrent->=2)  // return/line feed
				Form:C1466.eol:="\r\n"
				Form:C1466.eolCode:=String:C10(Character code:C91("\r"))
				
			: ($ptrCurrent->=3)  // line feed
				Form:C1466.eol:="\n"
				Form:C1466.eolCode:=String:C10(Character code:C91("\n"))
				
			: ($ptrCurrent->=4)  // other
				OBJECT SET VISIBLE:C603(*;"eolDelim_code";True:C214)
		End case 
		
	: ($action="mapListbox")  //  subform 2
		LISTBOX GET CELL POSITION:C971(*;"mapListbox";$column;$row)  //  just to know which column we're on
		
		$selFields:=Form:C1466.selectedFields
		
		
		Case of 
			: ($column<2)  //  import checkbox
				  // only valid to change if table & field is set
				If ($this_item.targetField.table="")
					$this_item.import:=False:C215
				Else   // whatever the user wants
					
				End if 
				
			: (Form:C1466.table="")
				$errMsg:="Select the import table first."
				
			: ($column<5)  //  popup menu to select field
				  //  we offer a different menu depending on this being on a single or multiple fields
				
				Case of 
					: (Not:C34(Contextual click:C713))
						
					: ($selFields.length>0)
						  // pop up the field selection menu for the table
						$paramObj:=New object:C1471
						$paramObj.chooseWhat:="field"
						$paramObj.tableList:=New collection:C1472(Form:C1466.table)
						
						If ($selFields.length>1)
							  // in this case we only want to present object fields
							$paramObj.fieldType:=New collection:C1472(Is object:K8:27)
						End if 
						
						$obj:=Struct_choose_byMenu ($paramObj)
						
						If ($obj#Null:C1517)
							  //  apply this choice to the selected fields
							For each ($field_obj;$selFields)
								$field_obj.import:=True:C214
								$field_obj.targetField:=OB Copy:C1225($obj)  //
								  //  if an object field suggest the import field name as the property name
								If ($obj.type=Is object:K8:27)
									$field_obj.targetField.prop:=Lowercase:C14($field_obj.impField)
								End if 
								
							End for each 
							
						End if 
						
						Form:C1466.dataMap:=Form:C1466.dataMap  //  force redraw
						
				End case 
				
				
			: (Form event code:C388=On Data Change:K2:15)  //  updating the property of the objet field
				  //  this can only happen if the field is an object field
				If ($this_item.targetField.type#Is object:K8:27)
					$this_item.targetField.prop:=""
					$errMsg:="You may only set the property for object fields. "
				End if 
		End case 
		
	: ($action="")
	: (False:C215)  //  handle the form event calls from the subform methods
	: ($action="formEvent_subform1")
		  // this is the UI for the paramObj
		Case of 
			: (Form event code:C388=On Load:K2:1)
				
				
		End case 
		
	: ($action="formEvent_subform2")
		Case of 
			: (Form event code:C388=On Load:K2:1)
				OBJECT SET HELP TIP:C1181(*;"btn_setTable";"Click to set Import Table.")
				OBJECT SET HELP TIP:C1181(*;"mapListbox";"Right-click to set field.")
				
		End case 
	Else 
		$errMsg:="Unknown action or object: "+$action  // +"\r\rForm Event: "+4D_FormEvent_text+"  {"+Current method name+"}"
End case 

  // ------------------------------------------
If ($errMsg#"")
	ALERT:C41($errMsg;"Close")
End if 

