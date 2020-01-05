//%attributes = {}
  //  OBJECT_SET_CoordByObj
  // Written by: Kirk as Designer, Created: 04/27/18, 15:55:06
  // ------------------
  // Method: OBJECT_SET_CoordByObj (object)
  // $1: { name:  ,  // object name
  //  see:  OBJECT_GET_CoordObj
  // Purpose: set the dimensions of the object referenced
  // to the dimension collections 


Err_check_methodParams (1;Count parameters:C259;Current method name:C684)

C_OBJECT:C1216($1)
C_TEXT:C284($name)
C_COLLECTION:C1488($x;$y)

$name:=$1.name

Case of 
	: (Not:C34(Object_exists ($name)))
		
	Else 
		
		OBJECT SET COORDINATES:C1248(*;\
			$name;\
			$1.x[1];\
			$1.y[1];\
			$1.x[2];\
			$1.y[2])
		
		OBJECT_GET_CoordObj ($1)
		
End case 


