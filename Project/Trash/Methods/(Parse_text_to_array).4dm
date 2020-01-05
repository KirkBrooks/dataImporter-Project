//%attributes = {"invisible":true}
  //  Parse_text_to_array (pointer; pointer{;object})
  // $1: ptr to text
  // $2: ptr to array
  // 3: params obj
  // Written by: Kirk as Designer, Created: 10/12/19, 16:08:50
  // ------------------
  // Purpose: 

C_POINTER:C301($1)
C_POINTER:C301($2)
C_OBJECT:C1216($3)
ARRAY TEXT:C222($a2Dtext;0;0)

$text:=Replace string:C233($1->;"\r\n";"\r")  // replace CrLf
$text:=Replace string:C233($text;"\n";"\r")  //  replace Lf
TEXT TO BLOB:C554($text;$blob;UTF8 text without length:K22:17)
$text:=""
  // --------------------------------------------------------

$fDelim:=Character code:C91(",")  //   comma
$rDelim:=Carriage return:K15:38
$dblQtEscaped:=True:C214

If (Count parameters:C259=3)
	If (OB Is defined:C1231($3;"fDelim"))
		$fDelim:=$3.fDelim
		$dblQtEscaped:=$fDelim=44  //  comma
	End if 
	
	If (OB Is defined:C1231($3;"rDelim"))
		$rDelim:=$3.rDelim
	End if 
	
	If (OB Is defined:C1231($3;"dblQtEscaped"))
		$dblQtEscaped:=$3.dblQtEscaped
	End if 
	
End if 

$inQt:=False:C215  //    TRUE while inside quoted string
$esc:=False:C215
  // --------------------------------------------------------
ARRAY TEXT:C222($aField;0)
$thisField:=""

For ($i;0;BLOB size:C605($blob)-1)
	$c:=$blob{$i}
	
	Case of 
		: ($esc)  //           this char is escaped
			$esc:=False:C215
		: ($c=Escape key:K12:25)  //  next char is escaped
			$esc:=True:C214
		: ($c=Double quote:K15:41) & ($inQt)  //          close quoted block
			$inQt:=False:C215
		: ($c=Double quote:K15:41) & ($dblQtEscaped)  //  start quoted block
			$inQt:=True:C214
		: ($inQt)  //          this char is part of the quoted block
			$thisField:=$thisField+Char:C90($c)
		: ($c=$fDelim)  //     completed this field
			APPEND TO ARRAY:C911($aField;$thisField)
			
			$thisField:=""
		: ($c=$rDelim)  //     completed this record
			APPEND TO ARRAY:C911($aField;$thisField)
			
			$thisRecord:=New collection:C1472
			ARRAY TO COLLECTION:C1563($thisRecord;$aField)
			
			$theData.push($thisRecord)
			
			  //----------------------
			ARRAY TEXT:C222($aField;0)
			$thisField:=""
			
		Else   //   add to the data
			$thisField:=$thisField+Char:C90($c)
	End case 
	
End for 

SET BLOB SIZE:C606($blob;0)
  // --------------------------------------------------------
$2->:=$a2Dtext
