//%attributes = {}
  //  Struct_get_fieldObj (long; long) -> obj
  // $1: table number
  // $2: field number
  // $0: object
  // Written by: Kirk as Designer, Created: 10/13/19, 22:47:36
  // ------------------
  // Purpose: 

C_LONGINT:C283($1;$2)
C_OBJECT:C1216($0;$this_field)
C_BOOLEAN:C305($Index;$Unique;$Invisible)
C_LONGINT:C283($i;$j;$Type;$Length)

If (Is field number valid:C1000($1;$2))
	GET FIELD PROPERTIES:C258(Field:C253($1;$2);$Type;$Length;$Index;$Unique;$Invisible)
	
	$this_field:=New object:C1471(\
		"name";Field name:C257($1;$2);\
		"table";Table name:C256($1);\
		"prop";"";\
		"number";$2;\
		"type";$type;\
		"invisible";$Invisible;\
		"ref";Lowercase:C14(Generate UUID:C1066))
	
	$0:=$this_field
End if 