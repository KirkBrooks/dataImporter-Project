//%attributes = {}
  //  Struct_choose_byMenu (object) -> object
  // $1: { chooseWhat:""  table or field   - what to select
  //       invisible: bool,    show only visible or invisible tables & fields
  //       fieldType: scalar collection; valid field types
  //       tableList: scalar collection of table names
  // $0: either the table or field object
  // Written by: Kirk as Designer, Created: 10/13/19, 14:46:29
  // ------------------
  // Purpose: pop up a menu and choose a field or table

C_OBJECT:C1216($1)
C_OBJECT:C1216($0)
C_BOOLEAN:C305($invisible)
C_COLLECTION:C1488($fieldType;$tableList)
C_TEXT:C284($menu;$result;$chooseWhat;$submenu)
C_OBJECT:C1216($table_obj;$field_obj;$return_obj)
C_COLLECTION:C1488($struct_col;$result_col)

$chooseWhat:=$1.chooseWhat  // $1
If ($1.fieldType#Null:C1517)
	$fieldType:=$1.fieldType
End if 



If (ProsObj .struct_col=Null:C1517)
	$struct_col:=Struct_collection 
	ProsObj .struct_col:=$struct_col
Else 
	$struct_col:=ProsObj .struct_col
End if 

  //  this allows us to filter the list of tables
If ($1.tableList#Null:C1517)
	$tableList:=$struct_col.query(" name IN :1 ";$1.tableList)
Else 
	$tableList:=$struct_col
End if 
  // --------------------------------------------------------

$menu:=Create menu:C408

If ($chooseWhat="field")
	
	For each ($table_obj;$tableList)
		If ($table_obj.invisible=$invisible)
			$submenu:=Create menu:C408
			
			For each ($field_obj;$table_obj.fields)
				
				Case of 
					: ($field_obj.invisible#$invisible)
					: ($fieldType=Null:C1517)
						APPEND MENU ITEM:C411($submenu;$field_obj.name)
						SET MENU ITEM PARAMETER:C1004($submenu;-1;$field_obj.ref)
						
					: ($fieldType.indexOf($field_obj.type)=-1)
						
					Else 
						APPEND MENU ITEM:C411($submenu;$field_obj.name)
						SET MENU ITEM PARAMETER:C1004($submenu;-1;$field_obj.ref)
				End case 
				
			End for each 
			
			If (Count menu items:C405($submenu)>0)
				APPEND MENU ITEM:C411($menu;$table_obj.name;$submenu)
			End if 
			
			RELEASE MENU:C978($submenu)
			
		End if 
	End for each 
	
Else 
	
	For each ($table_obj;$tableList)
		If ($table_obj.invisible=$invisible)
			APPEND MENU ITEM:C411($menu;$table_obj.name)
			SET MENU ITEM PARAMETER:C1004($menu;-1;$table_obj.ref)
		End if 
	End for each 
End if 

  // --------------------------------------------------------
  // display the menu, get the result
$result:=Dynamic pop up menu:C1006($menu)
RELEASE MENU:C978($menu)
  // --------------------------------------------------------


Case of 
	: ($result="")
		
	: ($chooseWhat="field")
		$result_col:=$struct_col.query(" fields[].ref = :1 ";$result)  // result_col is the table the field belongs to
		$result_col:=$result_col[0].fields.query(" ref = :1 ";$result)  // get the field object
		$return_obj:=$result_col[0]
		
	Else 
		$result_col:=$struct_col.query(" ref = :1 ";$result)
		$return_obj:=$result_col[0]
End case 

  // --------------------------------------------------------
$0:=$return_obj
