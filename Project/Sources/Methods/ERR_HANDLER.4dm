//%attributes = {}
  //  ERR_HANDLER
  // Written by: Kirk as Designer, Created: 04/15/18, 10:36:26
  // ------------------
  // Method: ERR_HANDLER ()
  // Purpose: component error handler
  // note: ERR_IGNORE doesn't invoke any other error methods

C_TEXT:C284($text;$path)
C_LONGINT:C283($window)

Err_set_object 

Case of 
	: (Method called on error:C704="ERR_CHECK")
		ProsObj .error:=New object:C1471  // clear the error object
		
	: (OB Is defined:C1231(Storage:C1525;"hostErrMethod"))
		EXECUTE METHOD:C1007(Storage:C1525.hostErrMethod;*;ProsObj .error)
		
		ProsObj .error:=New object:C1471  // clear the error object
		ProsObj .error:=New object:C1471  // clear the error object
		
	: (Application type:C494=4D Server:K5:6)  // don't stop on the server
		ERR_write_logFile 
		
		ProsObj .error:=New object:C1471  // clear the error object
		ProsObj .error:=New object:C1471  // clear the error object
		
	Else 
		  // write to the log file in the host
		ERR_write_logFile 
		
		If (Not:C34(Is compiled mode:C492(*))) | (Method called on error:C704="ERR_LOG_ONLY")
			  // show the local error dialog if host is uncompiled
			  // this is developer only
			$window:=Open form window:C675("Dev_error_dlog")
			DIALOG:C40("Dev_error_dlog")
			CLOSE WINDOW:C154
		End if 
		
		  // --------------------------------------------------------
		ProsObj .error:=New object:C1471  // clear the error object
		ProsObj .$err:=New object:C1471  //  clear the error vars
		
End case 

