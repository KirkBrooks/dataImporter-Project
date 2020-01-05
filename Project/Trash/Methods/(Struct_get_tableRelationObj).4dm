//%attributes = {"invisible":true}
  //  Struct_get_tableRelationObj
  // Written by: Kirk as Designer, Created: 02/19/18, 08:55:26
  // ------------------
  // Method: Struct_get_tableRelationObj (ptr) -> c-obj
  // $1 is ptr to table or source field
  // $0 is c-obj
  // Purpose: return object of relations to the record
  //{
  //  "many": {
  //    "43": [2]
  //  },
  //  "one": {
  //    "15": {
  //      "34": 1
  //    },
  //    "16": {
  //      "88": 1
  //    }}}
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

$obj:=New object:C1471



RESOLVE POINTER:C394($1;$varName;$q_table;$q_field)

If ($q_table>0)
	OB SET:C1220($obj;"table_n";$q_table)
	
	$pkPtr:=Table_get_PKpointer (Table:C252($q_table))
	
	If (Not:C34(Is nil pointer:C315($pkPtr)))
		OB SET:C1220($obj;"pk";Field:C253($pkPtr))
	End if 
	
	
	For ($t;1;Get last table number:C254)
		If (Is table number valid:C999($t)) & ($q_table#$t)
			$n:=0  // counter for number of fields in this table
			
			
			
			For ($f;1;Get last field number:C255($t))
				If (Is field number valid:C1000($t;$f))
					
					GET RELATION PROPERTIES:C686($t;$f;$oneTable;$oneField)
					
					If ($oneTable=$q_table)
						$n:=$n+1
						If ($obj.many=Null:C1517)
							$obj.many[Table name:C256($t)]:=New collection:C1472(Field name:C257($t;$f))
						End if 
						
						  // OBJ_Set_Long($obj;"many."+String($t)+"["+String($n)+"]";$f)
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
				OBJ_Set_Long($obj;"one."+String:C10($f)+"."+String:C10($oneTable);$oneField)
			End if 
		End if 
	End for 
	
End if 
  // --------------------------------------------------------
$0:=$obj