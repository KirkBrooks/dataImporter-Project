//%attributes = {}
  //  Parser_read_importFile (object; pointer)
  // $1: param object
  // $2: pointer to text object
  // Written by: Kirk as Designer, Created: 10/20/19, 07:34:07
  // ------------------
  // Purpose: if a file is specified and the text ptr is null
  // import the text file if none is passed in by user.

C_OBJECT:C1216($1;$params_obj)
C_POINTER:C301($2;$text_ptr)
C_TEXT:C284($file_path;$text_in)
C_BOOLEAN:C305($doImport)

$params_obj:=$1
$text_ptr:=$2

  // --------------------------------------------------------
Case of
	: ($text_ptr=Null:C1517) & ($params_obj.fileObj="")
		$params_obj.success:=False:C215
		$params_obj.error:="No user text and no import file."

	: (Length:C16($text_ptr->)>0)  //  user supplied text trumps the file

	: (Not:C34(File_exists ($params_obj.fileObj)))
		$params_obj.success:=False:C215
		$params_obj.error:="Can't locate the import file: "+$params_obj.fileObj

	Else

		  // --------------------------------------------------------
		C_LONGINT:C283($progress_id)
		$progress_id:=Progress New
		Progress SET TITLE ($progress_id;"Importing the file...";-1;$params_obj.fileObj)
		  // --------------------------------------------------------

		ERR_INSTALL_HANDLER ("ERR_IGNORE")
		$text_ptr->:=Document to text:C1236($params_obj.fileObj)
		ERR_INSTALL_HANDLER

		  // --------------------------------------------------------
		Progress QUIT ($progress_id)
		  // --------------------------------------------------------
End case

