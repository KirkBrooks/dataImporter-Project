//%attributes = {"shared":true}
  // Text_parse_toCollection (object{;ptr}) -> object
  // $1 : object {
  //  delim:  field delimiter
  //  eol:    record delimeter
  //  encoding:    https://doc.4d.com/4Dv17/4D/17.3/TEXT-TO-BLOB.301-4621162.en.html
  //            default = UTF8 text without length  (6)
  //  dblQtEscaped: bool  true = double quote escaping
  //  hasHeader: bool,    true = use the first row of data as header names
  // .fileObj:  full system path to the file to parse
  // $2 : ptr to text
  // Written by: Kirk Brooks,
  // ------------------
  // Purpose: parses the text into the collection
  // ** Default is to parse CSV **
  // Note: Only single character delimters are supported
  // Double Quotes:
  // if fDelim = comma: double quotes in fields must be escaped
  // if fDelim = tab:   double quotes aren't escaped by default
  //                    override this with dblQtEscaped:=TRUE
  //                    in which case double quotes must be escaped inside of field text

C_OBJECT:C1216($1;$params_obj)
C_POINTER:C301($2;$text_ptr)
C_TEXT:C284(import_text)

ASSERT:C1129($1#Null:C1517)

$params_obj:=$1
$params_obj.method:=Current method name:C684

If (Count parameters:C259=2)
	import_text:=$2->
End if
  // --------------------------------------------------------
  // Parse_text_to_collection ($text_ptr;$params_obj)
Parser_init ($params_obj)

