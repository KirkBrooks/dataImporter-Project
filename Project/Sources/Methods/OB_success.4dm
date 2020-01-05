//%attributes = {}
  //  OB_success (object) -> bool
  // $1: some object
  // $0: true if the 'success' property is true
  // Written by: Kirk as Designer, Created: 10/12/19, 19:23:32
  // ------------------
  // Purpose: 
C_OBJECT:C1216($1)
C_BOOLEAN:C305($0)
$0:=OB Get:C1224($1;"success";Is boolean:K8:9)