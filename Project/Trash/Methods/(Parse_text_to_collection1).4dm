//%attributes = {"invisible":true,"preemptive":"incapable"}
  //  Parse_text_to_collection (pointer; object)
  // $1: ptr to text
  // $2: params object {
  //  delim:  field delimiter
  //  eol:    record delimeter
  //  encoding:    https://doc.4d.com/4Dv17/4D/17.3/TEXT-TO-BLOB.301-4621162.en.html
  //            default = UTF8 text without length  (6)
  //  hasHeader: bool,    true = use the first row of data as header names
  //  dblQtEscaped: bool  true = double quote escaping
  // Written by: Kirk as Designer, Created: 10/12/19, 16:17:25
  // ------------------
  // Purpose: parses the text into collections
  // Each 'record' is a separate collection with each 'field' as a scalar element
  // *** This is the primary text parsing engine. ***
  //  DEFAULTS are set by   Parser_init

C_POINTER:C301($1)
C_OBJECT:C1216($2;$params_obj)
C_LONGINT:C283($ms;$i;$n;$c;$fDelim;$rDelim;$encoding_l;$max_number_recs)
C_TEXT:C284($errMsg;$text;$thisField)
C_COLLECTION:C1488($theData;$thisRecord)
C_BLOB:C604($blob)
C_BOOLEAN:C305($esc;$inQt;$dblQtEscaped)

$text:=$1->
$params_obj:=$2

$params_obj.success:=False:C215
$params_obj.error:=""
$params_obj.data:=Null:C1517
$max_number_recs:=OB Get:C1224($params_obj;"maxRecords";Is longint:K8:6)  // >0 is the max number of records to import
  // --------------------------------------------------------
$fDelim:=Character code:C91($params_obj.delim)
$rDelim:=Carriage return:K15:38
$dblQtEscaped:=$params_obj.dblQtEscaped

$text:=Replace string:C233($text;"\r\n";"\r")  // replace CrLf
$text:=Replace string:C233($text;"\n";"\r")  //  replace Lf
TEXT TO BLOB:C554($text;$blob;UTF8 text without length:K22:17)
$text:=""

$inQt:=False:C215  //    TRUE while inside quoted string
$esc:=False:C215

ARRAY TEXT:C222($aField;0)

  // --------------------------------------------------------
$theData:=New collection:C1472
$thisField:=""

$ms:=Milliseconds:C459
  // --------------------------------------------------------
C_LONGINT:C283($progress_id)
$progress_id:=Progress New 
Progress SET TITLE ($progress_id;"Parsing the text...";-1;"")
  // --------------------------------------------------------
$n:=BLOB size:C605($blob)-1

For ($i;0;$n)
	If ($i%1000=0)  //  update progress evey 1k chars
		Progress SET PROGRESS ($progress_id;$i/$n)
	End if 
	
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
			
			Case of 
				: ($max_number_recs=0)  // import all
				: ($max_number_recs=($theData.length-Num:C11($params_obj.hasHeader))  //  we're done
					$i:=$n+1
			End case 
			  //----------------------
			ARRAY TEXT:C222($aField;0)
			$thisField:=""
			
		Else   //   add to the data
			
			
			
			$thisField:=$thisField+Char:C90($c)
	End case 
	
End for 
  // --------------------------------------------------------
Progress QUIT ($progress_id)
  // --------------------------------------------------------

SET BLOB SIZE:C606($blob;0)

$ms:=Milliseconds:C459-$ms
$params_obj.ms:=$ms

$params_obj.data:=$theData
$params_obj.success:=$theData#Null:C1517
$params_obj.error:=""

  //  create a header map
Case of 
	: ($theData.length=0)
		
	: (OB Get:C1224($params_obj;"hasHeader";Is boolean:K8:9)=True:C214)
		$params_obj.map:=$theData.shift()  //  the first record used as map of the collection
		
	Else   // use 'field_'
		$params_obj.hasHeader:=False:C215
		$params_obj.map:=New collection:C1472
		
		For ($i;1;$theData[0].length)
			$params_obj.map.push("field_"+String:C10($i))
		End for 
		
End case 

