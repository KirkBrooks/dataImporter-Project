//%attributes = {}
  //  Text_parse_toJSONcollection (object{;pointer})
  // $1 : object {
  //  delim:  field delimiter
  //  eol:    record delimeter
  //  map:    collection of field names
  //  encoding:    https://doc.4d.com/4Dv17/4D/17.3/TEXT-TO-BLOB.301-4621162.en.html
  //            default = UTF8 text without length  (6)
  //  dblQtEscaped: bool  true = double quote escaping
  //  hasHeader: bool,    true = use the first row of data as header names
  // .fileObj:  full system path to the file to parse
  // $2: pointer to text var
  // Written by: Kirk as Designer, Created: 10/12/19, 17:19:05
  // ------------------
  // Purpose: parses the text into a collection of objects
  // if $1 includes a map collection all the 'records' are mapped to fields named there
  // if there is no map supplied the first 'record' is used as the field names

C_OBJECT:C1216($1;$params_obj)
C_POINTER:C301($2;$text_ptr)
C_COLLECTION:C1488($data_col;$fields_col)
C_LONGINT:C283($i;$j;$map_len)
C_TEXT:C284($errMsg;$value_t;$text_in)
C_OBJECT:C1216($thisRecord)
C_COLLECTION:C1488($rec_col;$data_col)

ASSERT:C1129($1#Null:C1517)

$params_obj:=$1

If (Count parameters:C259=2)
	$text_ptr:=$2
End if

$params_obj.method:=Current method name:C684
  // --------------------------------------------------------
  // Parse_text_to_collection ($text_ptr;$params_obj)
Parser_init ($params_obj;$text_ptr)

If (OB_success ($params_obj))
	$data_col:=$params_obj.data

	$fields_col:=$params_obj.map
	If ($fields_col=Null:C1517)
		$fields_col:=$data_col.shift()  //  the first record used as map of the collection
		$params_obj.map:=$fields_col
	End if

	$map_len:=$fields_col.length-1


	$i:=0
	For each ($rec_col;$data_col)

		$j:=0
		$thisRecord:=New object:C1471
		For each ($value_t;$rec_col)

			If ($j<=$map_len)
				$thisRecord[$fields_col[$j]]:=$value_t
			Else
				$thisRecord["$"+String:C10($j+1)]:=$value_t
			End if

			$j:=$j+1
		End for each

		$data_col[$i]:=$thisRecord

		$i:=$i+1
	End for each
	  // --------------------------------------------------------
End if

