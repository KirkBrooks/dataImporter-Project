//%attributes = {}
  //  IMPORT_TO_RECORDS ()
  // Written by: Kirk as Designer, Created: 10/22/19, 14:36:58
  // ------------------
  // Purpose: 

C_OBJECT:C1216($1;$param_obj)
C_LONGINT:C283($id;$i;$window)
C_TEXT:C284(import_text)
C_OBJECT:C1216($formData)

ERR_INSTALL_HANDLER 

$param_obj:=Import_paramObj ($1)
$param_obj.updateObj:=Import_updateObj 

$formData:=New object:C1471

If ($param_obj.format=0)
	$formData.tab_list:=New collection:C1472("Input";"Parse";"Map")
	  // the update object
Else 
	$formData.tab_list:=New collection:C1472("Input";"Parse")
End if 

  //  paramObj holds the details for the import data
$formData.paramObj:=$param_obj

  // Its contents are available to the subform Form. 
$formData.subformData:=New object:C1471

import_text:=""  //  clear variable

$window:=Open form window:C675("import_form";Plain form window:K39:10;Horizontally centered:K39:1;At the top:K39:5)
SET WINDOW TITLE:C213("IMPORTER")
DIALOG:C40("import_form";$formData)

  // --------------------------------------------------------
$1.data:=$param_obj.data
$1.data:=$param_obj.success
$1.data:=$param_obj.error
