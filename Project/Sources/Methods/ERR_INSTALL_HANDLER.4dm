//%attributes = {}
  //  Err_install_handler
  // Written by: Kirk as Designer, Created: 04/16/18, 07:42:58
  // ------------------
  // Method: Err_install_handler ({text})
  // $1 : method to install  - default is ERR_HANDLER
  //  pass "*"  to install 4D error handling
  //  pass "" to install previous handler
  // Purpose: manages installing a new err handler


C_TEXT:C284($1;$errMethod)

If (Count parameters:C259=1)
	$errMethod:=$1
Else 
	$errMethod:="ERR_HANDLER"
End if 

  // --------------------------------------------------------

Case of 
	: ($errMethod="*")  //       install 4D error handling
		$errMethod:=""
		
	: (Length:C16($errMethod)>0)
		  // install $errMethod and push current method
		ProsObj .errMethod.push(Method called on error:C704)
		
	: (ProsObj .errMethod.length=1)  //  set by proObj to ERR_HANDLER
		$errMethod:=ProsObj .errMethod[0]
		
	: ($errMethod="")  //  pop the last error handler
		$errMethod:=ProsObj .errMethod.pop()
		
End case 

  // --------------------------------------------------------
ON ERR CALL:C155($errMethod)
