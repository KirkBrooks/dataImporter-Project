//%attributes = {"preemptive":"capable"}
  //  File_exists
  // Written by: Kirk as Designer, Created: 12/06/17, 14:48:05
  // ------------------
  // Method: File_exists (text) -> bool
  // $1 is path to file
  // $0 is TRUE if the file exists
  // Purpose: tests the filename 

C_TEXT:C284($1)
C_BOOLEAN:C305($0)

$0:=Test path name:C476($1)=Is a document:K24:1

