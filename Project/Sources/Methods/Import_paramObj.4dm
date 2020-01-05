//%attributes = {}
  //  Import_paramObj ({object}) -> object
  // $0: an empty paramObj
  // Written by: Kirk as Designer, Created: 10/14/19, 09:46:14
  // ------------------
  // Purpose:

C_OBJECT:C1216($0;$paramObj;$1)


  //  paramObj holds the details for the import data
$paramObj:=New object:C1471

  // assign an id for identifying the import
$paramObj.id:=Substring:C12(Lowercase:C14(Generate UUID:C1066);1;8)
$paramObj.timeStamp:=Timestamp:C1445

  // --------------------------------------------------------
$paramObj.format:=2  //  this is the native, default import format
$paramObj.fileObj:=""  //      full system path to import file

If (Count parameters:C259>0)
	If (OB Is defined:C1231($1;"format"))
		$paramObj.format:=$1.format
	End if

	If (OB Is defined:C1231($1;.fileObj"))
		$paramObj.fileObj:=$1.fileObj
	End if

End if

$paramObj.fileSize:=""  //     desc of file size

$paramObj.hasHeader:=False:C215  //  true to treat first row as header
$paramObj.maxRecords:=0  // max record to parse. 0=all

$paramObj.delim:=","
$paramObj.delimCode:="44"

$paramObj.eol:="\r"
$paramObj.eolCode:="13"

$paramObj.dblQtEscaped:=False:C215

  //  these properties are set when the file is parsed
$paramObj.data:=Null:C1517  //  will be a collection of imported data
$paramObj.map:=Null:C1517  //   will be collection of 'field' names of imported data
$paramObj.method:=""  //  name of method used to parse file
$paramObj.ms:=0  //   parse time

$paramObj.success:=True:C214
$paramObj.error:=""

  // --------------------------------------------------------
$0:=$paramObj
