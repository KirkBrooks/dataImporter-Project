//%attributes = {}
/*




















*/

C_OBJECT:C1216($obj1;$obj2)
$obj1:=New object:C1471("key1";1)
$obj2:=New object:C1471("key1";1;"key2";OB Get:C1224($obj1;"key2";Is text:K8:3))

SHOW ON DISK:C922(Structure file:C489)

  // REQUIRED ELEMENTS
  // 1) the import source
  // --------------------------------------------------------
  //  for the time being only files

  // 2) the mapping key
  // --------------------------------------------------------
  //   This will be either:
  // a   collection of text strings
  // b   collection of objects
  // c   object
  // d   text string

  //  A) scalar collection of text strings. Each element is a resulting
  //    data field.
  //  B) collection of objects
  //    Each element is an object consisting of:
  //  { name: "",           // required
  //   sourceStr: "",      // optional - header name of the imported data
  //   sourceIndex: 0,     // optional - column number of the imported data
  //   formula:  Formula() // opitonal - formula each imported value will be passed to. Value will be imported as string.
  //  }
  //  C) object - property names will be used as column headers
  //     property value may be the header name or the column number
  //  D) text string. Use same delimiters as the data

  // 3) output format
  // --------------------------------------------------------
  //    types of output:
  //    a) JSON:  Each record will be written to an object. Objects will be written to a collection.
  //              Object properties will be the field name
  //    b) 2D text array: each field will be in a separate array. $array{columns}{row} *
  //    c) 2D text array: each record will be in a separate array. $array{row}{column}
  //    d) collection:  each field will be in a separate collection. $col[field1[...], field2[...], ...] **
  //                    fieldn values are scalar
  // *  can be displayed in array based listbox
  // ** can be displayed in collection based listbox


  // --------------------------------------------------------
  //  DEFINITIONS
  // --------------------------------------------------------
  //  data: a matrix of data where each row is a 'record' and each column is a 'field'
  //  header row: optional - first row of data, values are the header names
  //  header name:  source name of the 'field' in that column
  //  record: a row of data (fields)
  //  field: a column of data
  //  cell: a specific field in a given record.

C_TEXT:C284($text;$fileObj;$name;$rename)
C_OBJECT:C1216($params_obj;$result_obj;$req_obj)
C_LONGINT:C283($i;$j;$n)

$fileObj:="Macintosh HD:Users:kirk:4D Workspace:Summit & 4D stuff:Smummit_2020:fakeNames.csv"

  // -- [new importer ]
If (True:C214)
	$params_obj:=New object:C1471(\
		"format";1;\
		.fileObj";"Macintosh HD:Users:kirk:4D Workspace:Summit & 4D stuff:Summit_2020:fakeNames.csv")"
	
	IMPORTER_METHOD ($params_obj)
	
End if 



  //$text:=Document to text(.fileObj)
  // $params_obj:=New object(

  // -- unit test for Text_parse_to2Darray
If (False:C215)
	ARRAY TEXT:C222($a2dText;0;0)
	$params_obj:=New object:C1471(\
		"fileObj";Null:C1517;\
		"map";New collection:C1472("col1";"col2";"col3";"col4";"col5";"col6";"col7"))
	
	Text_parse_to2Darray ($params_obj;->$text;->$a2dText)  //  ;->$text)
	
End if 


  // -- unit test for Text_parse_toCollection
If (False:C215)
	$params_obj:=New object:C1471(\
		.fileObj";.fileObj)"
	
	Text_parse_toCollection ($params_obj)  //  ;->$text)
	
End if 

  // -- unit test for Text_parse_toCollection
If (False:C215)
	$params_obj:=New object:C1471(\
		.fileObj";.fileObj)"
	
	Text_parse_toFieldCollections ($params_obj)  //  ;->$text)
	
End if 

  //  unit test for Text_parse_toJSONcollection
If (False:C215)
	$params_obj:=New object:C1471(\
		.fileObj";.fileObj;\t\t"\
		map";New collection:C1472("col1";"col2";"col3";"col4";"col5";"col6";"col7"))"
	
	Text_parse_toJSONcollection ($params_obj)
	
End if 


  // -- [describe this test]
If (False:C215)
	C_BLOB:C604($blob)
	C_COLLECTION:C1488($chars)
	$name:="Frédérique\tSmith"
	$rename:=""
	
	$chars:=New collection:C1472
	$chars:=Split string:C1554($name;"")
	
	
	For ($i;1;Length:C16($name))
		$chars.push(Character code:C91($name[[$i]]))
		$rename:=$rename+Char:C90(Character code:C91($name[[$i]]))
	End for 
	
	TEXT TO BLOB:C554($name;$blob)
	
	
	
End if 
