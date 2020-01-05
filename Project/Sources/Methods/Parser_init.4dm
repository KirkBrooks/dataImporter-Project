//%attributes = {}
  //  Parser_init (object; pointer)
  // $1: params obj
  // $2: pointer to text var
  // Written by: Kirk as Designer, Created: 10/12/19, 18:11:57
  // ------------------
  // Purpose: all the parse methods take the same 2 params to start: 
  //   param_obj  and the optional pointer to a text var
  // This method will look at the values of the param obj and validate
  // user supplied settings or set defaults. 
  // If the user supplied a file path parse it and return the text
  // Modified by: Kirk (10/21/19) import_text

C_OBJECT:C1216($1;$params_obj)
  // C_POINTER($2;$text_ptr)
C_TEXT:C284(import_text)

$params_obj:=$1
  //$text_ptr:=$2

  //import_text:=$text_ptr->

$params_obj.success:=True:C214
$params_obj.error:=""


If ($params_obj.delim=Null:C1517)
	$params_obj.delim:=","
End if 

If ($params_obj.eol=Null:C1517)
	$params_obj.eol:="\r"
End if 

If ($params_obj.encoding=Null:C1517)
	$params_obj.encoding:=UTF8 text without length:K22:17
End if 

If ($params_obj.dblQtEscaped=Null:C1517)
	$params_obj.dblQtEscaped:=$params_obj.delim=","
End if 
  // --------------------------------------------------------

If (OB_success ($params_obj))
	Parse_text_to_collection (->import_text;$params_obj)
End if 
