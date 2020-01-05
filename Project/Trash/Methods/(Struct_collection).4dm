//%attributes = {"invisible":true}
  //  Struct_collection ()
  // Written by: Kirk as Designer, Created: 10/13/19, 14:22:03
  // ------------------
  // Purpose: sorted collection of tables & fields
  // 'ref' is a random uuid added for identification by menu
  // thisField object is optimized for use here. 
  //   table = the name of the table
  //   prop  = name of the property when field is object type

C_COLLECTION:C1488($0;$struct_col)
C_LONGINT:C283($i;$j;$Type;$Length)
C_COLLECTION:C1488($fields_col)
C_OBJECT:C1216($this_field;$this_table)
C_BOOLEAN:C305($Index;$Unique;$Invisible)
C_TEXT:C284($tableName)

$struct_col:=New collection:C1472

For ($i;1;Get last table number:C254)
	
	$this_table:=Struct_get_tableObj ($i)
	
	If ($this_table#Null:C1517)
		$struct_col.push($this_table)
	End if 
	
End for 

$struct_col:=$struct_col.orderBy(" name asc ")

$0:=$struct_col
