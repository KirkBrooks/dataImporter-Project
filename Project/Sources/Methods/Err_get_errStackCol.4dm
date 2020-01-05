//%attributes = {}
  //  Err_get_errStackCol
  // Written by: Kirk as Designer, Created: 12/12/17, 11:12:12
  // ------------------
  // Method: Err_get_errStackCol () -> collection
  // $0 is collection  - 
  // Purpose: $0 is collection of "errStack" :[object array] 
  // Modified by: Kirk (4/28/18) --  changed to collection & renamed

C_COLLECTION:C1488($errCol;$0)
C_LONGINT:C283($i)

  // get the error stack
ARRAY LONGINT:C221($aErrNum;0)
ARRAY TEXT:C222($aIntComps;0)
ARRAY TEXT:C222($aErrText;0)
GET LAST ERROR STACK:C1015($aErrNum;$aIntComps;$aErrText)

$errCol:=New collection:C1472

For ($i;1;Size of array:C274($aErrNum))
	$errCol.push(New object:C1471(\
		"error";$aErrNum{$i};\
		"ic";$aIntComps{$i};\
		"text";$aErrText{$i}))
	
End for 

  // --------------------------------------------------------
$0:=$errCol
