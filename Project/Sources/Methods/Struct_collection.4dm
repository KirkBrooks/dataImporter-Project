//%attributes = {}
  //  Struct_collection ()
  // Written by: Kirk as Designer, Created: 10/13/19, 14:22:03
  // ------------------
  // Purpose: sorted collection of tables & fields
  // 'ref' is a random uuid added for identification by menu

C_COLLECTION:C1488($0;$struct_col)
C_LONGINT:C283($i;$j;$Type;$Length)
C_COLLECTION:C1488($fields_col)
C_OBJECT:C1216($this_field;$this_table)
C_BOOLEAN:C305($Index;$Unique;$Invisible)
C_TEXT:C284($table_name)

$struct_col:=New collection:C1472

For ($i;1;Get last table number:C254)
	
	If (Is table number valid:C999($i))
		$table_name:=Table name:C256($i)
		$fields_col:=New collection:C1472
		
		For ($j;1;Get last field number:C255($i))
			If (Is field number valid:C1000($i;$j))
				GET FIELD PROPERTIES:C258(Field:C253($i;$j);$Type;$Length;$Index;$Unique;$Invisible)
				
				$this_field:=New object:C1471(\
					"name";Field name:C257($i;$j);\
					"table";$table_name;\
					"number";$j;\
					"type";$type;\
					"invisible";$Invisible;\
					"ref";Lowercase:C14(Generate UUID:C1066))
				
				$fields_col.push($this_field)
			End if 
		End for 
		
		GET TABLE PROPERTIES:C687($i;$invisible)
		
		$this_table:=New object:C1471(\
			"name";$table_name;\
			"number";$i;\
			"invisible";$Invisible;\
			"ref";Lowercase:C14(Generate UUID:C1066);\
			"fields";$fields_col.orderBy(" name asc"))
		
		$struct_col.push($this_table)
	End if 
	
End for 

$struct_col:=$struct_col.orderBy(" name asc ")

$0:=$struct_col
