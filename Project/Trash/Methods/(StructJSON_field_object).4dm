//%attributes = {"invisible":true}
  //  StructJSON_field_object
  // Written by: Kirk as Designer, Created: 01/19/18, 15:26:28
  // ------------------
  // Method: StructJSON_field_object (long; long) -> c-obj
  // $1 is the table
  // $2 is the field 
  // $0 is c-obj
  // Purpose: return a field object

Err_check_methodParams (2;Count parameters:C259;Current method name:C684)

C_LONGINT:C283($1;$2)
C_OBJECT:C1216($obj;$0)
C_LONGINT:C283($i;$n)
C_TEXT:C284($errMsg)

$obj:=New object:C1471

Case of 
	: (Not:C34(Is table number valid:C999($1)))
	: (Not:C34(Is field number valid:C1000($1;$2)))
	Else 
		OB SET:C1220($obj;\
			"n";$2;\
			"name";Field name:C257($1;$2);\
			"type";Type:C295(Field:C253($1;$2)->))
End case 

$0:=$obj

