//%attributes = {}
  //  4D_get_applicationTypeString
  // Written by: Kirk as Designer, Created: 04/15/18, 10:04:31
  // ------------------
  // Method: 4D_get_applicationTypeString ({long}) -> text
  // $1 is application type - default is application type
  // $0 is string
  // Purpose: 


C_LONGINT:C283($type;$1)
C_TEXT:C284($0)

If (Count parameters:C259>0)
	$type:=$1
Else 
	$type:=Application type:C494
End if 


Case of 
	: ($type=4D Local mode:K5:1)
		$0:="4D Local mode"
	: ($type=4D Server:K5:6)
		$0:="4D Server"
	: ($type=4D Remote mode:K5:5)
		$0:="4D Remote mode"
	: ($type=4D Volume desktop:K5:2)
		$0:="4D Volume desktop"
		
	Else 
		$0:="Unknown 4D type"
		
End case 


