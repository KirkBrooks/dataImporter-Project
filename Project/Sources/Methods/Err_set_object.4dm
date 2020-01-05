//%attributes = {}
  //  Err_set_object
  //  ***  THIS METHOD CLEARS 4D ERROR VARS  ***
  // sets  prosObj.error with details and current error stack
  // sets  prosObj.$err  is the 4D error variables

C_LONGINT:C283(error;error line;$i)
C_TEXT:C284(error method)
C_TEXT:C284($procName)  // Initialize the variables
C_LONGINT:C283($procState)
C_LONGINT:C283($procTime)


  // always write the 4D error vars to prosObj
ProsObj .$err:=New object:C1471
ProsObj .$err.number:=error
ProsObj .$err.line:=error line
ProsObj .$err.method:=error method

  // --------------------------------------------------------
ProsObj .error:=New object:C1471

Case of 
	: (error=-10518)  // skip asserts
	: (Method called on error:C704="ERR_CHECK")  // don't need the rest
		
	Else   // write the object
		ProsObj .error.scope:=app_name_verison 
		ProsObj .error.errMethod:=Method called on error:C704
		
		  //  capture the environment
		PROCESS PROPERTIES:C336(Current process:C322;$procName;$procState;$procTime)
		
		ProsObj .error.time:=Timestamp:C1445
		ProsObj .error.user:=Current user:C182
		ProsObj .error.applicationType:=4D_get_applicationTypeString 
		ProsObj .error.compiled:=Is compiled mode:C492
		ProsObj .error.isWindows:=Folder separator:K24:12#":"
		
		  // --------------------------------------------------------
		ProsObj .error.errStack:=Err_get_errStackCol 
		
End case 

Err_CLEAR_4Dvars 

  //[End Err_set_object ]
