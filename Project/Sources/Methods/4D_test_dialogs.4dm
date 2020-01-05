//%attributes = {}
  //  4D_test_dialogs
  // Written by: Kirk as Designer, Created: 07/11/18, 12:02:57
  // ------------------
  // Method: 4D_test_dialogs ()
  // Purpose: 


4D_ALERT ("test")

C_OBJECT:C1216($obj)
$obj:=New object:C1471(\
"message";"This is a request";\
"userInput";"Default input";\
"title";"Request Title")

4D_request ($obj)

4D_ALERT (JSON Stringify:C1217(->$obj;*))


