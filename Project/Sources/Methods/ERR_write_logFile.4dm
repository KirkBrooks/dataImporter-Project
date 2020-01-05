//%attributes = {}
  //  ERR_write_logFile
  // Written by: Kirk as Designer, Created: 04/28/18, 09:31:10
  // ------------------
  // Method: ERR_write_logFile ()
  // Purpose: the log file is in Logs/(app name__error.json on HOST
  // the document will be a collection
  // each entry is a collection of : [ Timestamp, prosObj.$err, prosObj.error]
  // [
  //  ["2018-04-28T16:57:11.817Z",{},{}],
  //  ["2018-04-28T16:57:11.230Z",{},{}],
  //  ["2018-04-28T16:57:10.108Z",{},{}],
  // ]

C_TEXT:C284($text;$path)
C_COLLECTION:C1488($myCol)

If (Semaphore:C143("$errLog";60*10))
	
Else 
	$myCol:=New collection:C1472(Timestamp:C1445;ProsObj .$err;ProsObj .error)
	  // --------------------------------------------------------
	
	  // write to the log file in the host
	$path:=Get 4D folder:C485(Logs folder:K5:19;*)+app_name_verison +"_errors.json"
	
	$text:=""
	If (Test path name:C476($path)=Is a document:K24:1)
		$text:=Document to text:C1236($path;"UTF-8")
	End if 
	
	If (Length:C16($text)=0)
		$text:="["+JSON Stringify:C1217($myCol)+"]"
	Else 
		$text:=Insert string:C231($text;JSON Stringify:C1217($myCol)+",";2)
	End if 
	
	TEXT TO DOCUMENT:C1237($path;$text)
	
	CLEAR SEMAPHORE:C144("$errLog")
	
End if 

