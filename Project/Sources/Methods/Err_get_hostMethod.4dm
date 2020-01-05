//%attributes = {}
  //  Err_get_hostMethod
  // Written by: Kirk as Designer, Created: 04/15/18, 09:52:50
  // ------------------
  // Method: Err_get_hostMethod () -> text
  // $0 : host method to call on err
  // Purpose: 

C_TEXT:C284($0;$method)

$method:=appObj .errorMethod

Case of 
	: ($method="")
	: (Not:C34(app_method_exists ($method)))
	Else 
		$0:=$method
End case 
