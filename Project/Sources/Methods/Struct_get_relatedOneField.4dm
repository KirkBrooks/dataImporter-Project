//%attributes = {}
  //  Struct_get_relatedOneField (ptr) -> obj
  // $1: ptr to source field
  // $0: { table: <table name>, field: <field name> }
  // Written by: Kirk as Designer, Created: 10/17/19, 15:04:49
  // ------------------
  // Purpose:
  // build collection of related fields POINTING FROM $1

C_POINTER:C301($1)
C_OBJECT:C1216($0;$many_obj)
C_LONGINT:C283($source_field_n;$source_table_n;$table_n;$field_n)


$source_table_n:=Table:C252($1)
$source_field_n:=Field:C253($1)

GET RELATION PROPERTIES:C686($source_table_n;$source_field_n;$table_n;$field_n)

If ($table_n>0)
	$many_obj:=New object:C1471
	$many_obj.table:=Table name:C256($table_n)
	$many_obj.field:=Field name:C257($table_n;$field_n)
End if 

  // --------------------------------------------------------
$0:=$many_obj
