//%attributes = {}
  //  Resize_window
  // Written by: Kirk Brooks as Designer, Created: 01/27/14, 09:02:59
  // ------------------
  // Method: Resize_window (text)
  // $1 is the main text object on the form
  // Purpose: manage resizing a window based on the form object passed

C_TEXT:C284($1;$object)

$object:=$1

If ($object#"")
	  // --------------------------------------------------------
	  // .......... resize the window to fit the text ..........
	  // --------------------------------------------------------
	C_LONGINT:C283($l;$t;$r;$b;$width;$height;$maxWidth;$sLeft;$sTop;$sRight;$sBottom;$d)
	
	  // we don't want to open something larger than the screen
	  // constrain to 1/3 the screen width
	$maxWidth:=Int:C8(Screen width:C187*0.33)
	
	  // current text size
	OBJECT GET COORDINATES:C663(*;$object;$l;$t;$r;$b)
	
	  // get the best size
	OBJECT GET BEST SIZE:C717(*;$object;$width;$height;$maxWidth)
	
	  // how much taller do we need to make it?
	$width:=$width-($r-$l)
	$height:=$height-($b-$t)
	
	
	  // we don't want to go off the screen
	If ($height>(Screen height:C188*0.75))
		$height:=(Screen height:C188*0.75)
	End if 
	
	  // finally - I want a minimum window size, which is the size of the window
	  //  when it was designed
	ARRAY LONGINT:C221($aNum;2)
	$aNum{1}:=$width
	$aNum{2}:=0
	$width:=Max:C3($aNum)
	
	$aNum{1}:=$height
	$aNum{2}:=0
	$height:=Max:C3($aNum)
	
	RESIZE FORM WINDOW:C890($width;$height)
	
	  // --------------------------------------------------------
	  // .......... now make sure it's all on the screen ..........
	  // --------------------------------------------------------
	
	GET WINDOW RECT:C443($l;$t;$r;$b)
	SCREEN COORDINATES:C438($sLeft;$sTop;$sRight;$sBottom)
	
	$d:=$sBottom-$b
	
	If ($d<0)  // need to move it up
		
		SET WINDOW RECT:C444($l;$t+$d;$r;$b+$d)
		
	End if 
End if 
  //[End Resize_window ]
