//%attributes = {}
  //  ST_get_styleTag
  // Written by: Kirk as Designer, Created: 04/20/18, 11:28:13
  // ------------------
  // Method: ST_get_styleTag (obj) -> text
  // $1 is object: {
  //   font-family: , color: , etc...
  //  }
  // $0 is opening style tag: <span style="">
  // Purpose: 
  //  see:  http://doc.4d.com/4Dv16R6/4D/16-R6/Supported-tags.300-3547539.en.html


Err_check_methodParams (0;Count parameters:C259;Current method name:C684)

C_OBJECT:C1216($obj;$1)
C_TEXT:C284($tag;$0)
C_LONGINT:C283($i;$n)


$tag:="<span style=\""

ARRAY TEXT:C222($aKeys;0)
OB GET PROPERTY NAMES:C1232($1;$aKeys)

For ($i;1;Size of array:C274($aKeys))
	
	Case of 
		: ($aKeys{$i}="font-family")
			$tag:=$tag+$aKeys{$i}+":'"+$1[$aKeys{$i}]+"'"
		Else 
			$tag:=$tag+$aKeys{$i}+":"+$1[$aKeys{$i}]
	End case 
	
	  // --------------------------------------------------------
	If ($i=Size of array:C274($aKeys))
		$tag:=$tag+""
	Else 
		$tag:=$tag+";"
	End if 
	
End for 

$tag:=$tag+"\">"

$0:=$tag
