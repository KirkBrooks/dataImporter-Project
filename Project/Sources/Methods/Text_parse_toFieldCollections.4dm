//%attributes = {"shared":true}
  //  Text_parse_toFieldCollections (object{;ptr}) -> object
  // $1 : object {
  //  delim:  field delimiter
  //  eol:    record delimeter
  //  encoding:    https://doc.4d.com/4Dv17/4D/17.3/TEXT-TO-BLOB.301-4621162.en.html
  //            default = UTF8 text without length  (6)
  //  dblQtEscaped: bool  true = double quote escaping
  //  hasHeader: bool,    true = use the first row of data as header names
  // .fileObj:  full system path to the file to parse
  // $2 : ptr to text
  // Written by: Kirk as Designer, Created: 10/12/19, 19:36:38
  // ------------------
  // Purpose: parses the text into collections such that each field is a separate collection
  // This is the same layout you get if you parse to a 2D array
  // The benefit is this collection can be displayed in a listbox

C_OBJECT:C1216($1;$params_obj)
C_POINTER:C301($2;$text_ptr)
C_COLLECTION:C1488($data_col;$newData_col;$rec_col)
C_LONGINT:C283($j;$n_columns;$n_rows)
C_TEXT:C284($value_t)

ASSERT:C1129($1#Null:C1517)

$params_obj:=$1
$params_obj.method:=Current method name:C684

If (Count parameters:C259=2)
	$text_ptr:=$2
End if
  // --------------------------------------------------------
  // Parse_text_to_collection ($text_ptr;$params_obj)
Parser_init ($params_obj;$text_ptr)

If (OB_success ($params_obj))
	  // now need to transpose the collection values
	$data_col:=$params_obj.data
	$n_columns:=$data_col[0].length
	$n_rows:=$data_col.length

	$newData_col:=New collection:C1472
	For ($j;1;$n_columns)
		$newData_col.push(New collection:C1472)
	End for


	For each ($rec_col;$data_col)

		$j:=0
		For each ($value_t;$rec_col)
			$newData_col[$j].push($value_t)
			$j:=$j+1
		End for each
	End for each

	$params_obj.data:=$newData_col

End if
