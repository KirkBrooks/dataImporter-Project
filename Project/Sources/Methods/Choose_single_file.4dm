//%attributes = {}
  //  Choose_single_file ({object}) -> object
  // $1: options: 
  //      folder: path to folder to default to
  //      type:   string of doc types to allow
  //      message: 
  // $0: file object selected
  // Written by: Kirk as Designer, Created: 10/13/19, 09:59:55
  // ------------------
  // Purpose: allow user to choose a single file

C_OBJECT:C1216($1;$params_obj)
C_OBJECT:C1216($0;$file_obj)
C_TEXT:C284($doc;$DocType;$folder;$message)
ARRAY TEXT:C222($aDocs;0)

If (Count parameters:C259>0)
	$params_obj:=$1
End if 

$message:="Select the document:"
$folder:=System folder:C487(Desktop:K41:16)
$DocType:=".pdf;.jpg;.jpeg;.txt;.text;.csv;.json"

If (Count parameters:C259>0)
	
	If (OB Get:C1224($params_obj;"folder";Is text:K8:3)#"")
		$folder:=$params_obj.folder
	End if 
	
	If (OB Get:C1224($params_obj;"message";Is text:K8:3)#"")
		$message:=$params_obj.message
	End if 
	
	If (OB Get:C1224($params_obj;"type";Is text:K8:3)#"")
		$DocType:=$params_obj.type
	End if 
	
End if 

$Doc:=Select document:C905($folder;$DocType;$message;Alias selection:K24:10+Use sheet window:K24:11;$aDocs)

If (isOK ) & (Size of array:C274($aDocs)>0)
	$file_obj:=File:C1566($aDocs{1};fk platform path:K87:2)
End if 

$0:=$file_obj
