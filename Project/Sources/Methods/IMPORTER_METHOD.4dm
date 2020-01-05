//%attributes = {"shared":true,"preemptive":"incapable"}
  //  IMPORTER_METHOD (object)
  // $1: param_obj: {  //  this is a subset of Import_paramObj
  //      format: long,     * required: 0 = records, 1 = JSON, 2 = collection, 3= collection 2
  //     .fileObj: "",     optional - path to data doc to start with
  //       data: []          output -
  // Written by: Kirk as Designer, Created: 10/13/19, 09:46:22
  // ------------------
  // Purpose:

C_OBJECT:C1216($1;$param_obj)
C_LONGINT:C283($id)
C_TEXT:C284(import_text)

ASSERT:C1129(Count parameters:C259>0)

$param_obj:=$1

If ($param_obj.format=0)  //  import to records - run in new process
	$id:=Process number:C372("IMPORT_TO_RECORDS")

	Case of
		: ($id#0)
			BRING TO FRONT:C326($id)
		Else
			$id:=New process:C317("IMPORT_TO_RECORDS";0;"IMPORT_TO_RECORDS";$param_obj)
	End case

Else   //  run in this process

	IMPORT_TO_RECORDS ($param_obj)

End if


