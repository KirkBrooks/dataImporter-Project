//%attributes = {}
  //  Import_match_headerToField (object)
  // $1: update object
  // Written by: Kirk as Designer, Created: 10/13/19, 22:42:19
  // ------------------
  // Purpose: call in context of "import_sub_2"

C_OBJECT:C1216($1;$updateObj)
C_TEXT:C284($tableName)
C_COLLECTION:C1488($temp_col;$fields_col;$dataMap)
C_OBJECT:C1216($map_obj)
C_LONGINT:C283($i)

$updateObj:=$1
$dataMap:=$updateObj.dataMap
$tableName:=$updateObj.table

  //  get the list of fields for the table
$fields_col:=Struct_get_tableObj (0;$tableName).fields

For each ($map_obj;$dataMap)
	$temp_col:=$fields_col.query(" name = :1 ";$map_obj.impField)
	
	If ($temp_col.length=1)
		$map_obj.targetField.name:=$temp_col[0].name
		$map_obj.targetField.table:=$tableName
		
		$map_obj.import:=True:C214  //  assume we want to import a matched field
	End if 
	
End for each 

