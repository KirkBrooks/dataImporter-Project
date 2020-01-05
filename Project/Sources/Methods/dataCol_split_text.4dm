//%attributes = {}
  //  dataCol_split_text (ptr) -> bool
  // $1: ptr to text 
  // $0: length text = collection length
  // Written by: Kirk as Designer, Created: 10/30/19, 06:23:02
  // ------------------
  // Purpose: split the text into the import_data_col collection

C_POINTER:C301($1)
C_LONGINT:C283($0;$progress_id)
C_TEXT:C284($text)
C_COLLECTION:C1488(import_data_col)

ASSERT:C1129($1#Null:C1517;"The pointer to the text variable is nil.")
ASSERT:C1129(Length:C16($1->)>0;"There is nothing to parse.")

import_data_col:=New collection:C1472

$progress_id:=Progress New 
Progress SET TITLE ($progress_id;"Splitting the text...";-1;"")
  // split the string into characters
$text:=$1->

$n:=Position:C15("\r";$1->)

import_data_col:=Split string:C1554($text;"")
$text:=""
Progress QUIT ($progress_id)

$0:=import_data_col.length  // =Length($1->)

