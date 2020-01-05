//%attributes = {}
  //  4D_alert_Format_text
  // Written by: Kirk Brooks as Designer, Created: 07/31/14, 08:09:11
  // ------------------
  // Method: 4D_alert_Format_text (text) -> text
  // $1 is text to format
  // $0 is formatted text
  // Purpose: used by the custom dialogs to insert styled text
  // into a message text

C_TEXT:C284($1;$0)
C_TEXT:C284($text;$tag)
C_LONGINT:C283($pos)
C_OBJECT:C1216($obj)

  // --------------------------------------------------------
  // any formatting defined? ..........
  // --------------------------------------------------------
  // where is the 1st CR

$text:=$1
$pos:=Position:C15("\r";$text)

Case of 
	: (Length:C16($text)=0)
	: ($text[[1]]="!")  // make first line bold
		$text:=Str_encode_forStyledText (Substring:C12($text;2))
		
		If ($pos>0)
			$pos:=$pos-1
		Else 
			$pos:=Length:C16($text)+1
		End if 
		
		$obj:=New object:C1471(\
			"font-size";"14pt";\
			"font-family";"Helvetica";\
			"font-weight";"bold")
		
		$tag:=ST_get_styleTag ($obj)
		$text:="<span>"+$tag+Insert string:C231($text;"</span>";$pos)+"</span>"
		
		
	: ($text[[1]]="*")  // make first line bold & red
		$text:=Str_encode_forStyledText (Substring:C12($text;2))
		
		If ($pos>0)
			$pos:=$pos-1
		Else 
			$pos:=Length:C16($text)+1
		End if 
		
		$obj:=New object:C1471(\
			"font-size";"14pt";\
			"font-family";"Helvetica";\
			"font-weight";"bold";\
			"color";"#ff0000")
		
		$tag:=ST_get_styleTag ($obj)
		$text:="<span>"+$tag+Insert string:C231($text;"</span>";$pos)+"</span>"
		
End case 

$0:=$text

  // --------------------------------------------------------
  //  the window info 
  // --------------------------------------------------------
  //If (OB Is defined(ProsObj .alertMsg;"title"))
  //$text:=$text+"\r\r"+ProsObj .alertMsg.title
  //End if 
  //[End Format_text ]
