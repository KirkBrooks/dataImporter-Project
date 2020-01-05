//%attributes = {}
  //  OBJECT_GET_CoordObj
  // Written by: Kirk as Designer, Created: 04/16/18, 15:47:30
  // ------------------
  // Method: OBJECT_GET_CoordObj (object)
  // $1 { name:  ,   // object name
  //       x: [ width, left, right, left-screen coord, right-screen coord]
  //       y: [ height, top, bottom, top-screen coord, bottom-screen coord]
  // Purpose: populate the collections with dimensions of the object named
  // the dimension collectons are formed as: 
  //  $x[0]:=new object((object name): width)
  //  $x[1]:=new object((object name): left)
  //  $x[2]:=new object((object name): right)
  //  $x[3]:=new object((object name): left-screen coord)
  //  $x[4]:=new object((object name): right-screen coord)
  //  
  //  $y[0]:=new object((object name): height)
  //  $y[1]:=new object((object name): top)
  //  $y[2]:=new object((object name): bottom)
  //  $y[3]:=new object((object name): top-screen coord)
  //  $y[4]:=new object((object name): bottom-screen coord)


Err_check_methodParams (1;Count parameters:C259;Current method name:C684)

C_OBJECT:C1216($1)
C_TEXT:C284($name)
C_LONGINT:C283($left;$top;$right;$top;$winLeft;$winTop;$r;$b)

$name:=$1.name

If (Object_exists ($name))  //  does the object exist?
	
	GET WINDOW RECT:C443($winLeft;$winTop;$r;$b)
	OBJECT GET COORDINATES:C663(*;$name;$left;$top;$right;$bottom)
	  // --------------------------------------------------------
	
	$1.x:=New collection:C1472(\
		$right-$left;\
		$left;\
		$right;\
		$left+$winLeft;\
		$right+$winLeft)
	
	$1.y:=New collection:C1472(\
		$bottom-$top;\
		$top;\
		$bottom;\
		$top+$winTop;\
		$bottom+$winTop)
	
Else 
	$1.error:="No form object found."
	
End if 