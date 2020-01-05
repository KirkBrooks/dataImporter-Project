//%attributes = {"shared":true}
  //  app_name_verison
  // Written by: Kirk as Designer
  // ------------------
  // Method: app_get_name () -> text
  // $0 is app name  and version
  // Purpose: return name of application
  // hard code or return name of file structure

C_TEXT:C284($0;$name_t)
$name_t:=Path to object:C1547(Structure file:C489).name

$name_t:=$name_t+",  1.2.1"
  // broke up the import process
  //  added import_text process variable
  //  option to paste text for import


  // $name_t:=$name_t+",  1.0.2"  // Modified by: Kirk (10/21/19) 
  // compiled and working

  // $name_t:=$name_t+",  1.0.1"  // Modified by: Kirk (10/20/19) 
  // changed parsing to use split string 
  // several improvements to field mapping

  // $name_t:=$name_t+",  1.0.0"  // Modified by: Kirk (10/16/19) 
  // --------------------------------------------------------
$0:=$name_t

