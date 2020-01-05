//%attributes = {"shared":true}
  //  Text_parse_to2Darray (obj;pointer;pointer)
  // $1 c-obj of params:
  //  delim:  field delimiter
  //  eol:    record delimeter
  //  encoding:    https://doc.4d.com/4Dv17/4D/17.3/TEXT-TO-BLOB.301-4621162.en.html
  //            default = UTF8 text without length  (6)
  //  dblQtEscaped: bool  true = double quote escaping
  //  hasHeader: bool,    true = use the first row of data as header names
  // .fileObj:  full system path to the file to parse
  // $2 is ptr to text var. Pass null if.fileObj is defined
  // $3 is ptr to 2D text array
  // $0 is number of rows parsed
  // Written by: Kirk as Designer, Created: 10/12/19, 18:10:24
  // ------------------
  // Purpose: parse text to 2D text array
  //.fileObj - if defined text is read from there
  //  if not defined $3 is used
  // Defaults are for a CSV doc.


C_OBJECT:C1216($1;$params_obj)
C_POINTER:C301($2;$text_ptr)
C_POINTER:C301($3)
C_COLLECTION:C1488($rec_col;$data_col)
C_LONGINT:C283($n;$n_columns;$n_rows;$j;$i)
C_TEXT:C284($value_t)

ASSERT:C1129($1#Null:C1517)
ASSERT:C1129(Count parameters:C259=3)
ASSERT:C1129(Type:C295($3->)=Array 2D:K8:24)
ASSERT:C1129(Type:C295($3->{0})=Text array:K8:16)


$params_obj:=$1
$text_ptr:=$2
$params_obj.method:=Current method name:C684

Parser_init ($params_obj;$text_ptr)

If (OB_success ($params_obj))
	  //  1st dimension is the field (ready for ARRAY TO SELECTION)
	  //  2nd dimension is the row
	$data_col:=$params_obj.data
	$n_columns:=$data_col[0].length
	$n_rows:=$data_col.length

	ARRAY TEXT:C222($a2Dtext;$n_columns;$n_rows)

	$i:=0
	For each ($rec_col;$data_col)
		$i:=$i+1

		$j:=0
		For each ($value_t;$rec_col)
			$j:=$j+1
			$a2Dtext{$j}{$i}:=$value_t
		End for each
	End for each
End if

  // --------------------------------------------------------

COPY ARRAY:C226($a2Dtext;$3->)
