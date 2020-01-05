//%attributes = {}
  //  app_method_exists
  // Written by: Kirk as Designer, Created: 04/15/18, 09:43:44
  // ------------------
  // Method: app_method_exists (text) -> bool
  // $1 : method name
  // $0 : true if the method is available to the app
  // Purpose: 

C_TEXT:C284($1)
C_BOOLEAN:C305($0)

ARRAY TEXT:C222($aMethods;0)
METHOD GET NAMES:C1166($aMethods;$1)
$0:=Size of array:C274($aMethods)=1
