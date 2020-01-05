//%attributes = {}
  //  dataCol_to_2DtextArray (pointer)
  // $1: ptr to 2D text array
  // Written by: Kirk as Designer, Created: 10/30/19, 10:30:49
  // ------------------
  // Purpose: parse the data colleciton to a 2D text array

C_POINTER:C301($1)

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