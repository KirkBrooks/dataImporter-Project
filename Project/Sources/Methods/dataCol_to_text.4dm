//%attributes = {}
  //  dataCol_to_text (ptr) -> bool
  // $1: pointer to text var
  // $0: length text = collection length
  // Written by: Kirk as Designer, Created: 10/30/19, 06:27:59
  // ------------------
  // Purpose: cleears the text var and 
  // concatenates the collection into it. 
  // Basically reverses   dataCol_split_text ()

C_POINTER:C301($1)
C_LONGINT:C283($0)
C_COLLECTION:C1488(import_data_col)
C_TEXT:C284($char)

ASSERT:C1129($1#Null:C1517;"The pointer to the text variable is nil.")

$1->:=""

For each ($char;import_data_col)
	$1->:=$1->+$char
End for each 

$0:=import_data_col.length  // =Length($1->)

