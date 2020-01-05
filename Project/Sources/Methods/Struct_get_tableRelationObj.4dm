//%attributes = {}
  //  Struct_get_tableRelationObj
  // Written by: Kirk as Designer, Created: 02/19/18, 08:55:26
  // ------------------
  // Method: Struct_get_tableRelationObj (ptr) -> c-obj
  // $1 is ptr to table or source field
  // $0 is c-obj
  // Purpose: return object of relations to the record
  //{
  //  "many": [
  //    { table: "", field: "" },...],
  //
  // 'many': (table):[{field}, ...]
  //  each key is a table / field where the relation begins at that 
  //       field and goes to the source field
  //  each array element is a field in that table
  // 'one':  the object keys are fields in the source table
  //          the relation begins at this field
  //       one.(table):field 
  //         table is the table and field is the id field


C_POINTER:C301($1;$pkPtr)
C_LONGINT:C283($q_field;$q_table;$t;$f;$n;$oneField;$oneTable)
C_TEXT:C284($errMsg)
C_TEXT:C284($varName)
C_LONGINT:C283($table_n;$field_n)
C_OBJECT:C1216($obj;$0)
C_OBJECT:C1216($many_obj)

$obj:=New object:C1471

RESOLVE POINTER:C394($1;$varName;$q_table;$q_field)

If ($q_table>0)
	$obj.table:=Table name:C256($q_table)
	OB SET:C1220($obj;"table_n";$q_table)
	
	$pkPtr:=Table_get_PKpointer (Table:C252($q_table))
	
	If (Not:C34(Is nil pointer:C315($pkPtr)))
		$obj.pkName:=Field name:C257($pkPtr)
		$obj.pk:=Field:C253($pkPtr)
	End if 
	
	
	For ($t;1;Get last table number:C254)
		If (Is table number valid:C999($t)) & ($q_table#$t)
			$n:=0  // counter for number of fields in this table
			
			For ($f;1;Get last field number:C255($t))
				If (Is field number valid:C1000($t;$f))
					
					GET RELATION PROPERTIES:C686($t;$f;$oneTable;$oneField)  //  get the field the relation points to
					
					If ($oneTable=$q_table)
						If ($obj.many=Null:C1517)
							$obj.many:=New collection:C1472
						End if 
						  //  ----------------
						$many_obj:=New object:C1471
						$many_obj.table:=Table name:C256($t)
						$many_obj.field:=Field name:C257($t;$f)
						$obj.many.push($many_obj)
						
					End if 
				End if 
				
			End for 
		End if 
	End for 
	
	  // --------------------------------------------------------
	$t:=$q_table
	
	For ($f;1;Get last field number:C255($t))
		If (Is field number valid:C1000($t;$f))
			
			GET RELATION PROPERTIES:C686($t;$f;$oneTable;$oneField)
			
			If ($oneTable>0)
				  // OBJ_Set_Long ($obj;"one."+String($f)+"."+String($oneTable);$oneField)
				
				If ($obj.one=Null:C1517)
					$obj.one:=New collection:C1472
				End if 
				  //  ----------------
				$many_obj:=New object:C1471
				$many_obj.table:=Table name:C256($oneTable)
				$many_obj.field:=Field name:C257($oneTable;$oneField)
				$obj.one.push($many_obj)
			End if 
		End if 
	End for 
	
End if 
  // --------------------------------------------------------
$0:=$obj