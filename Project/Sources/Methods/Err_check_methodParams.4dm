//%attributes = {}
  //  Err_check_methodParams
  // Written by: Kirk as Designer, Created: 09/08/17, 11:51:48
  // ------------------
  // Method: Err_check_methodParams (long ; long; text)
  // $1 is the number of required params
  // $2 is number actually found
  // $3 is method name
  // Purpose: 


C_LONGINT:C283($1;$2)
C_TEXT:C284($3)
C_LONGINT:C283($i;$n)


Case of 
	: (Application type:C494=4D Server:K5:6)
		  // don't stop here!
		
	: (Count parameters:C259<3)
		TRACE:C157
	: ($2>=$1)  // ok
		
	Else 
		ALERT:C41(String:C10($1)+" paramters are required for "+$3)
		TRACE:C157
End case 


