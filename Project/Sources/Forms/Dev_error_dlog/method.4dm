  //  Dev_error_dlog
  // Written by: Kirk as Designer, Created: 04/15/18, 10:56:41
  // ------------------
  // Method: Dev_error_dlog ()
  // Purpose: this is the component error dialog
  // just show the prosObject data

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284($text)
		C_OBJECT:C1216($obj)
		
		$text:="4D err vars:\r"+JSON Stringify:C1217(ProsObj .$err;*)
		
		$text:=$text+"\r\rERROR:\r"+JSON Stringify:C1217(ProsObj .error;*)
		
		OBJECT Get pointer:C1124(Object named:K67:5;"errorText")->:=$text
		
End case 


