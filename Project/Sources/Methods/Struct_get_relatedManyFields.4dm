//%attributes = {}
  // Struct_get_relatedManyFields (ptr) -> col
  // $1 is ptr to source field
  //      this doesn't have to be the primary key
  // $0: collection
  // Written by: Kirk as Designer, Created: 02/19/18, 09:09:04
  // Modified by: Kirk (10/17/19) 
  // ------------------
  // Purpose: build collection related fields POINTING TO $1

Err_check_methodParams (1;Count parameters:C259;Current method name:C684)

C_POINTER:C301($1)
C_COLLECTION:C1488($0;$related_field_col)
C_LONGINT:C283($field_n;$table_n;$oneTable;$oneField;$source_table_n;$source_field_n)
C_OBJECT:C1216($many_obj)

$related_field_col:=New collection:C1472
$source_table_n:=Table:C252($1)
$source_field_n:=Field:C253($1)

  // --------------------------------------------------------
For ($table_n;1;Get last table number:C254)
	
	If (Is table number valid:C999($table_n))
		
		For ($field_n;1;Get last field number:C255($table_n))
			If (Is field number valid:C1000($table_n;$field_n))
				  //  get the field the relation points to
				GET RELATION PROPERTIES:C686($table_n;$field_n;$oneTable;$oneField)
				
				If ($oneTable=$source_table_n) & ($oneField=$source_field_n)
					$many_obj:=New object:C1471
					$many_obj.table:=Table name:C256($table_n)
					$many_obj.field:=Field name:C257($table_n;$field_n)
					$related_field_col.push($many_obj)
				End if 
			End if 
			
		End for 
	End if 
End for 
  // --------------------------------------------------------

$0:=$related_field_col
