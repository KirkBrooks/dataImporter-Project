//%attributes = {}
  //  appObj
  // Written by: Kirk as Designer, Created: 04/15/18, 09:24:05
  // ------------------
  // Method: appObj ()
  // Purpose: initialize the component IP object: appObject

C_OBJECT:C1216(<>appObject;$0)

If (Not:C34(OB Is defined:C1231(<>appObject)))
	<>appObject:=New object:C1471(\
		"startedAt";Timestamp:C1445;\
		"errorMethod";"";\
		"prog";New object:C1471)
	
End if 

$0:=<>appObject
