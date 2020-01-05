//%attributes = {}
  //  Object_exists
  // Written by: Kirk Brooks as Designer, Created: 05/01/16, 10:39:35
  // ------------------
  // Method: Object_exists (text) -> boolean
  // Purpose: test if form object named $1 exists

C_TEXT:C284($1)
C_BOOLEAN:C305($0)

  //  this is fast
$0:=Not:C34(Is nil pointer:C315(OBJECT Get pointer:C1124(Object named:K67:5;$1)))

If (Not:C34($0))  // don't give up yet - check the object names
	ARRAY TEXT:C222($aObjArray;0)
	FORM GET OBJECTS:C898($aObjArray)
	
	$0:=Find in array:C230($aObjArray;$1)>-1
End if 

  //[End Object_exists ]
