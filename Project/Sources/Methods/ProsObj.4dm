//%attributes = {}
  //  ProsObj
  // Written by: Kirk as Designer, Created: 04/15/18, 08:44:23
  // ------------------
  // Method: ProsObj() -> obj
  // Purpose: return reference for the prosObject
  // This method can be referenced directly 
  // This method is the defacto 'new process' method.  

C_OBJECT:C1216(prosObject;$0)

If (Not:C34(OB Is defined:C1231(prosObject)))
	
	prosObject:=New object:C1471(\
		"startedAt";Timestamp:C1445;\
		"process";New object:C1471;\
		"$err";New object:C1471;\
		"error";New object:C1471;\
		"user";New object:C1471)
	
	prosObject.process.number:=Current process:C322
	prosObject.process.UUID:=Lowercase:C14(Generate UUID:C1066)
	prosObject.user.current:=Current user:C182
	
	  // --------------------------------------------------------
	prosObject.errMethod:=New collection:C1472("ERR_HANDLER")  // the default 
	
	Case of 
		: (Method called on error:C704="")
			ON ERR CALL:C155("ERR_HANDLER")
			
		: (Method called on error:C704#"ERR_HANDLER")
			prosObject.errMethod[0]:=Method called on error:C704
			
	End case 
	
End if 

$0:=prosObject