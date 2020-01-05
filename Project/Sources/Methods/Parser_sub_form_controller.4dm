//%attributes = {}
  //  Parser_sub_form_controller ()
  // Written by: Kirk as Designer, Created: 10/30/19, 08:23:54
  // ------------------
  // Purpose: 


C_TEXT:C284($1;$2;$action;$errMsg)
C_LONGINT:C283($0;$form_return)
C_POINTER:C301($ptrCurrent;$ptrObj)
C_OBJECT:C1216($obj;$paramObj;$newMap_obj;$field_obj)
C_COLLECTION:C1488(import_data_col;$dataMap_col;$map_col)
C_TEXT:C284($header_str)
C_LONGINT:C283($i;$j;$column;$row)

$ptrCurrent:=OBJECT Get pointer:C1124(Object current:K67:2)
If (Count parameters:C259=0)
	$action:=OBJECT Get name:C1087(Object current:K67:2)
Else 
	$action:=$1
End if 
  // ------------------------------------------
$obj:=New object:C1471


  // ------------------------------------------
Case of 
	: (False:C215)  ///// buttons /////
	: ($action="btn_parse")  //       subform 1
		
		Case of 
			: (import_data_col.length<10)
				$errMsg:="I'm not sure how this happend but there is no data to parse."
				
			Else 
				dataCol_parse_to_records (Form:C1466)  // parse the text file
				
				If (OB_success (Form:C1466))
					  //  populate the listbox
					LISTBOX DELETE COLUMN:C830(*;"listbox";1;100)
					  //
					$map_col:=Form:C1466.map
					$dataMap_col:=New collection:C1472
					
					$j:=0
					For each ($header_str;$map_col)
						LISTBOX INSERT COLUMN FORMULA:C970(*;\
							"listbox";\
							100;\
							"col_"+$header_str;\
							"This.value["+String:C10($j)+"]";\
							Is text:K8:3;\
							"hdr_"+$header_str;\
							$nil)
						OBJECT SET TITLE:C194(*;"hdr_"+$header_str;$header_str)
						  // --------------------------------------------------------
						  //  build the field map collection
						  //$newMap_obj:=OB Copy(Form.updateObj.dataMapTemplate)
						  //$newMap_obj.impField:=$header_str
						  //$dataMap_col.push($newMap_obj)
						  // --------------------------------------------------------
						$j:=$j+1
					End for each 
					
					  // Form.updateObj.dataMap:=$dataMap_col
				End if 
				
		End case 
		
	: ($action="")
	: (False:C215)  ///// form objects /////
	: ($action="ListBox")
		
		
		
	: ($action="")
	: (False:C215)  ///// form actions /////
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
				
			: ($ptrCurrent->=2)  // other
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
	: ($action="")
	: ($action="formEvents")
		Case of 
			: (Form event code:C388=On Load:K2:1)
				
				
		End case 
	Else 
		$errMsg:="Unknown action or object: "+$action+"\r\rForm Event: "+4D_FormEvent_text +"  {"+Current method name:C684+"}"
End case 

  // ------------------------------------------

4D_ALERT ($errMsg;Current method name:C684)

