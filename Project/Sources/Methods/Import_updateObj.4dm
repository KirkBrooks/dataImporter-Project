//%attributes = {}
  //  Import_updateObj ()
  // Written by: Kirk as Designer, Created: 10/14/19, 09:52:28
  // ------------------
  // Purpose: 

C_OBJECT:C1216($1;$updateObj)

  // the update data
  // This object contains informatin about mapping the imported data to the ds
$updateObj:=New object:C1471

$updateObj.table:=""  //  the name of the main table data is imported into

$updateObj.currentItem:=Null:C1517  //  selected update item

$updateObj.dataMap:=New collection:C1472
  // the dataMap is a collection of objects: 

  // --------------------------------------------------------
  // this could be a formula in v18...
$updateObj.dataMapTemplate:=New object:C1471
  // impField:    name of import field - copied from paramObj.map
$updateObj.dataMapTemplate.impField:=""
  // targetField. 
  //       object: see  Struct_collection
  //         name: name of field data is written to
  //         prop: property data is written to if targetField is Object
  //              targetField = this_field
$updateObj.dataMapTemplate.targetField:=New object:C1471(\
"title";"";\
"name";"";\
"prop";"";\
"fieldType";Null:C1517)
$updateObj.dataMapTemplate.import:=False:C215
  // import: bool  true if this field should be imported

  // --------------------------------------------------------

$0:=$updateObj

