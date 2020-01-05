//%attributes = {}
  //  OBJECT_GET_bestSize
  // Written by: Kirk as Designer, Created: 07/11/18, 11:46:59
  // ------------------
  // Method: OBJECT_GET_bestSize (object{;long})
  // $1: see  OBJECT_GET_CoordObj
  // $2 = maxWidth
  //  bestsize = $1.x[3]  &  $1.y[3]
  // Purpose: get the best size based on current object settings

C_OBJECT:C1216($1)
C_LONGINT:C283($2)
C_LONGINT:C283($xBest;$yBest)

If (Not:C34(OB Is defined:C1231($1;"x"))) | (Not:C34(OB Is defined:C1231($1;"y")))
	OBJECT_GET_CoordObj ($1)
End if 


If (Count parameters:C259=2)
	OBJECT GET BEST SIZE:C717(*;$1.name;$xBest;$yBest;$2)
Else 
	OBJECT GET BEST SIZE:C717(*;$1.name;$xBest;$yBest)
End if 

$1.x[3]:=$xBest
$1.y[3]:=$yBest
