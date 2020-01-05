//%attributes = {}
  //  Struct_get_tableObj (long{;text}) -> object
  // $1: table number
  // $2: table name - $1=0
  // $0: object
  // Written by: Kirk as Designer, Created: 10/13/19, 22:52:12
  // ------------------
  // Purpose: 

C_LONGINT:C283($1)
C_TEXT:C284($2;$tableName)
C_OBJECT:C1216($0;$this_table)
C_COLLECTION:C1488($fields_col)
C_OBJECT:C1216($this_field)
C_LONGINT:C283($table_number;$i;$j)
C_BOOLEAN:C305($invisible)

$table_number:=$1

If (Count parameters:C259>1)
	$tableName:=$2
	
	For ($i;1;Get last table number:C254)
		Case of 
			: (Not:C34(Is table number valid:C999($i)))
				
			: (Table name:C256($i)=$tableName)
				$table_number:=$i
				$i:=1000
		End case 
	End for 
	
End if 
  // --------------------------------------------------------

If (Is table number valid:C999($table_number))
	$fields_col:=New collection:C1472
	
	For ($j;1;Get last field number:C255($table_number))
		$this_field:=Struct_get_fieldObj ($table_number;$j)
		
		If ($this_field#Null:C1517)
			$fields_col.push($this_field)
		End if 
	End for 
	
	GET TABLE PROPERTIES:C687($table_number;$invisible)
	
	$this_table:=New object:C1471(\
		"name";Table name:C256($table_number);\
		"number";$table_number;\
		"invisible";$Invisible;\
		"ref";Lowercase:C14(Generate UUID:C1066);\
		"fields";$fields_col.orderBy(" name asc"))
	
	$0:=$this_table
	
End if 

