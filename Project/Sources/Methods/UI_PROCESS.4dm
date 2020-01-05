//%attributes = {}
  //  UI_PROCESS ()
  // Written by: Kirk as Designer, Created: 10/29/19, 10:04:37
  // ------------------
  // Purpose: open the UI dialog

C_LONGINT:C283($1)
C_LONGINT:C283($id;$i;$window)
C_TEXT:C284($procName)
C_COLLECTION:C1488(import_data_col)
C_OBJECT:C1216($form_obj)

$procName:=Current method name:C684

Case of 
	: (Count parameters:C259=0)
		$id:=Process number:C372($procName)
		
		If ($id=0)
			$id:=New process:C317(Current method name:C684;0;$procName;Current process:C322)
		Else 
			BRING TO FRONT:C326($id)
		End if 
		
	: (Count parameters:C259=1)  //     new process
		
		import_data_col:=New collection:C1472()
		
		$form_obj:=New object:C1471
		$form_obj.subform:=Null:C1517  //  will be a reference to the specific form displayed
		$form_obj.display_form:="import_sub"  //  the subform to display
		
		  // specific subforms
		  // INPUT  - user pastes text or selects a file, split into import_data_col
		$form_obj.import_sub:=New object:C1471
		$form_obj.import_sub.fileObj:=Null:C1517  //  null = user input (paste)
		
		
		  // PARSER - user specifies how to process the data
		  //   data is either imported or copied to clipboard
		$form_obj.parser_sub:=New object:C1471
		$form_obj.parser_sub.data:=Null:C1517  //  will be the data parsed from import_data_col
		$form_obj.parser_sub.maxRecords:=0  //   0=all records
		
		
		  // MAPPING  - user maps records to table and fields.
		$form_obj.map:=New object:C1471
		
		
		$window:=Open form window:C675("UI_form")
		SET WINDOW TITLE:C213("data importer")
		
		$form_obj.subform:=$form_obj.input
		$form_obj.ui_window:=$window
		
		DIALOG:C40("UI_form";$form_obj)
		
		
End case 

