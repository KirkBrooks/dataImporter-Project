//%attributes = {"invisible":true}
  //  StructJSON_table_object
  // Written by: Kirk as Designer, Created: 01/19/18, 15:32:02
  // ------------------
  // Method: StructJSON_table_object (long) -> c-obj
  // $1 is table number
  // $0 is table object
  // Purpose: 

Err_check_methodParams (1;Count parameters:C259;Current method name:C684)

C_LONGINT:C283($1)
C_LONGINT:C283($i;$n)
C_TEXT:C284($errMsg)
C_OBJECT:C1216($obj)

$obj:=New object:C1471

If (Is table number valid:C999($1))
	ARRAY OBJECT:C1221($aFields;0)
	
	For ($i;1;Get last field number:C255($1))
		
		If (Is field number valid:C1000($1;$i))
			APPEND TO ARRAY:C911($aFields;StructJSON_field_object ($1;$i))
		End if 
	End for 
	
	OB SET:C1220($obj;\
		"n";$1;\
		"name";Table name:C256($1);\
		"n_fields";Size of array:C274($aFields))
	
	OB SET ARRAY:C1227($obj;"fields";$aFields)
	
End if 

$0:=$obj
