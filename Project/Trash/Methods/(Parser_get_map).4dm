//%attributes = {"invisible":true}
  //  Parser_get_map (object) -> collection
  // $1: params_obj
  // $0: scalar collection of values
  // Written by: Kirk as Designer, Created: 10/13/19, 08:46:43
  // ------------------
  // Purpose: returns the $1.map collection. 
  // If the map is not defined it's created from the first 'row' of data

C_OBJECT:C1216($1;$params_obj)
C_COLLECTION:C1488($0;$map)

$params_obj:=$1

  // is the map already defined?
  // If not create it based ont he type of data in the params object

Case of 
	: ($params_obj.map#Null:C1517)  // yes
		$map:=$params_obj.map
		
	: ($params_obj.data.length=0)  //  no data
		
	: ($params_obj.method="Text_parse_toJSONcollection")
		
		$fields_col:=$data_col.shift()  //  the first record used as map of the collection
		$params_obj.map:=$fields_col
		
	Else 
		
End case 

$0:=$map