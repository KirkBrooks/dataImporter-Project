//%attributes = {}
  //  TPL_get_element (text; long) -> text
  // $1; string of elements delimited by ;
  // $2: number of element to get
  // $0:element
  // Written by: Kirk as Designer, Created: 10/21/19, 08:26:13
  // ------------------
  // Purpose: split string and return element

C_TEXT:C284($1)
C_LONGINT:C283($2)
C_TEXT:C284($0)
C_COLLECTION:C1488($elements)

$elements:=Split string:C1554($1;";")

Case of 
	: ($2<1)
	: ($2>$elements.length)
	Else 
		$0:=$elements[$2-1]
End case 