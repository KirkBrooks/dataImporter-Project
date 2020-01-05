//%attributes = {}
  //  ERR_set_hostMethod
  // Written by: Kirk as Designer, Created: 04/15/18, 09:36:21
  // ------------------
  // Method: ERR_set_hostMethod (text)
  // $1 : host db method to call on error
  // Purpose: allow logging component errors in host
  // The host method must have the "Shared by components and host database" 
  // attribute set. 
  // It will recieve an error object as $1
  //   Storage.hostErrMethod

C_TEXT:C284($1)

Case of 
	: (Count parameters:C259=0)  // clear 
		Use (Storage:C1525)
			Storage:C1525.hostErrMethod:=""
		End use 
		
	: ($1="")
		Use (Storage:C1525)
			Storage:C1525.hostErrMethod:=""
		End use 
		
	Else   // set this method
		Use (Storage:C1525)
			Storage:C1525.hostErrMethod:=$1
		End use 
		
End case 
