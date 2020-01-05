//%attributes = {"invisible":true,"preemptive":"incapable"}
  //  Parse_text_to_collection (pointer; object)
  // $1: ptr to text
  // $2: params object {
  //  delim:  field delimiter string (0 - 3 chars)
  //  eol:    record delimeter       (1 - 3 chars)
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
C_LONGINT:C283($ms;$i;$n;$c;$fDelim;$rDelim;$encoding_l;$max_number_recs;$c_next)
C_TEXT:C284($errMsg;$text;$thisField)
C_COLLECTION:C1488($theData;$thisRecord;$text_col;import_data_col)
C_BOOLEAN:C305($esc;$inQt;$dblQtEscaped;$new_field)
C_LONGINT:C283($progress_id)


$text:=$1->
$params_obj:=$2

$params_obj.success:=False:C215
$params_obj.error:=""
$params_obj.data:=Null:C1517
$max_number_recs:=OB Get:C1224($params_obj;"maxRecords";Is longint:K8:6)  // >0 is the max number of records to import
  // --------------------------------------------------------
$fDelim:=Num:C11($params_obj.delimCode)
$rDelim:=Num:C11($params_obj.eolCode)
$dblQtEscaped:=$params_obj.dblQtEscaped

$text:=Replace string:C233($text;"\r\n";Char:C90($rDelim))  // replace CrLf
  // $text:=Replace string($text;"\n";"\r")  //  replace Lf

$progress_id:=Progress New 
Progress SET TITLE ($progress_id;"Splitting the text...";-1;"")
  // split the string into characters
$text_col:=Split string:C1554($text;"")
$text:=""
Progress QUIT ($progress_id)


$inQt:=False:C215  //    TRUE while inside quoted string
$esc:=False:C215

  // --------------------------------------------------------
$theData:=New collection:C1472
$thisField:=""

$ms:=Milliseconds:C459
  // --------------------------------------------------------

$progress_id:=Progress New 
Progress SET TITLE ($progress_id;"Parsing the text...";-1;"")
  // --------------------------------------------------------
$n:=$text_col.length
$thisRecord:=New collection:C1472
$c_next:=Character code:C91($text_col[0])
$new_field:=True:C214  //  1st char of new field

For ($i;0;$n-2)
	If ($i%1000=0)  //  update progress evey 1k chars
		Progress SET PROGRESS ($progress_id;$i/$n)
	End if 
	
	$c:=$c_next  //   this char
	$c_next:=Character code:C91($text_col[$i+1])  //  the next char
	
	Case of 
		: ($esc)  //           this char is escaped - ignore
			$esc:=False:C215
			
		: ($c=Escape:K15:39)  //  next char is escaped
			$esc:=True:C214
			$new_field:=False:C215
			
		: ($c=Double quote:K15:41) & ($new_field)  //    this field is quoted
			$inQt:=True:C214
			$new_field:=False:C215
			
		: ($c=Double quote:K15:41) & ($inQt) & (($c_next=$fDelim) | ($c_next=$rDelim))  //          close quoted field
			$inQt:=False:C215
			
		: ($c=Double quote:K15:41) & ($c_next=Double quote:K15:41) & ($dblQtEscaped)  //  read "" as escaped double quote
			  // $inQt:=True
			
		: ($inQt)  //          this char is part of the quoted block
			$thisField:=$thisField+$text_col[$i]
			$new_field:=False:C215
			
		: ($c=$fDelim)  //     completed this field
			$thisRecord.push($thisField)
			  // APPEND TO ARRAY($aField;$thisField)
			$thisField:=""
			$new_field:=True:C214
			
		: ($c=$rDelim)  //     completed this record
			$thisRecord.push($thisField)
			$theData.push($thisRecord)
			$thisRecord:=New collection:C1472
			
			$thisField:=""
			$new_field:=True:C214
			  //----------------------
			Case of 
				: ($max_number_recs=0)  // import all
				: ($max_number_recs=($theData.length-Num:C11($params_obj.hasHeader)))  //  we're done
					$i:=$n+1
			End case 
			
		Else   //   add to the data
			$thisField:=$thisField+$text_col[$i]
			$new_field:=False:C215
	End case 
	
End for 
  // --------------------------------------------------------
Progress QUIT ($progress_id)
  // --------------------------------------------------------

$ms:=Milliseconds:C459-$ms
$params_obj.ms:=$ms

$params_obj.data:=$theData
$params_obj.success:=$theData#Null:C1517
$params_obj.error:=""

  // --------------------------------------------------------
  //  create a header map
  // --------------------------------------------------------
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

