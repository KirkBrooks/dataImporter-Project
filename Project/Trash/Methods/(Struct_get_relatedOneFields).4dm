//%attributes = {"invisible":true}
  //  Struct_get_relatedOneFields
  // Written by: Kirk as Designer, Created: 02/19/18, 09:09:04
  // ------------------
  // Method: Struct_get_relatedOneFields (ptr; ptr; ptr{;ptr}) -> bool
  // $1 is ptr to source field
  // $2 ptr to table array - long
  // $3 ptr to field array - long
  // $4 is optional text array - labels
  // $0 is TRUE if succesful
  // Purpose: populate $2 & $3 with numbers of tables and fields 
  // pointing at by $1

Err_check_methodParams (3;Count parameters:C259;Current method name:C684)

C_POINTER:C301($1;$2;$3;$4)
C_BOOLEAN:C305($ok;$0)
C_LONGINT:C283($i;$n;$j;$t)
C_TEXT:C284($errMsg)
C_OBJECT:C1216($obj)

Case of 
	: (Count parameters:C259<3)
	: (Is nil pointer:C315($1)) | (Is nil pointer:C315($2)) | (Is nil pointer:C315($3))
		
	Else 
		
		$obj:=New object:C1471
		$obj:=Struct_get_tableRelationObj ($1)
		
		ARRAY LONGINT:C221($aTable;0)
		ARRAY LONGINT:C221($aField;0)
		ARRAY TEXT:C222($aLabel;0)
		
		ARRAY TEXT:C222($aKeys;0)
		OBJ_ListKeys($obj;"one";->$aKeys)
		
		For ($i;1;Size of array:C274($aKeys))
			ARRAY LONGINT:C221($af;0)
			OBJ_Get_Array($obj;"many."+$aKeys{$i};->$af)
			
			For ($j;1;Size of array:C274($af))
				$t:=Num:C11($aKeys{$i})
				APPEND TO ARRAY:C911($aTable;$t)
				APPEND TO ARRAY:C911($aField;$af{$j})
				APPEND TO ARRAY:C911($aLabel;"["+Table name:C256($t)+"]"+Field name:C257($t;$af{$j}))
				$0:=True:C214
			End for 
			
		End for 
		
		COPY ARRAY:C226($aTable;$2->)
		COPY ARRAY:C226($aField;$3->)
		If (Count parameters:C259>3)
			COPY ARRAY:C226($aLabel;$4->)
		End if 
End case 
