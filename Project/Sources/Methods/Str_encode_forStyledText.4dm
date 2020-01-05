//%attributes = {}
  //  Str_encode_forStyledText
  // Written by: Kirk as Designer, Created: 04/20/18, 10:01:31
  // ------------------
  // Method: Str_encode_forStyledText (text) -> text
  // $1 is raw text in
  // $0 is $1 with special chars escaped
  // Purpose: prepare text for inclusion in Styled Text block


C_TEXT:C284($1;$text;$0)
C_LONGINT:C283($i;$n)
C_TEXT:C284($errMsg)

$text:=$1

$text:=Replace string:C233($text;"&";"&amp;")

$text:=Replace string:C233($text;"<";"&lt;")
$text:=Replace string:C233($text;">";"&gt;")

$text:=Replace string:C233($text;"[";"&#91;")
$text:=Replace string:C233($text;"]";"&#93;")

$text:=Replace string:C233($text;Char:C90(13);"<br/>")

$0:=$text
