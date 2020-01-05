//%attributes = {}
  // [ WIN_open_inCurrentWinByObj ]
  // Written (OS): Kirk Brooks  Created: 11/16/12, 15:41:56
  // ------------------
  // Method: WIN_open_inCurrentWinByObj (c-obj) -> longint
  // $1 is c-obj of params:
  //  { window: 0, `    default is FrontMost
  //    width: 0, `     default is 3/4 window
  //    height: 0, `    default is 3/4 window
  //    type: 0, `      default is Modal form dialog box
  //    padTop, padLeft:  pix spaced from top or left border
  //    title: "", `    window title 
  //    closeBox: "", ` method to set for closebox
  // Purpose:  open a window within a window. 
  // 

C_OBJECT:C1216($1;$obj)
C_LONGINT:C283($0)
C_LONGINT:C283($left;$top;$right;$bottom;$height;$width;$type;$padTop;$padLeft;$window)
C_TEXT:C284($title;$closeBox)

$obj:=New object:C1471
$obj:=$1

  // --------------------------------------------------------
If (OB Is defined:C1231($obj;"window"))
	$window:=OB Get:C1224($obj;"window";Is longint:K8:6)
Else 
	$window:=Frontmost window:C447
End if 

GET WINDOW RECT:C443($left;$top;$right;$bottom;$window)

  // --------------------------------------------------------
$width:=OB Get:C1224($obj;"width";Is longint:K8:6)
If ($width=0)
	$width:=($right-$left)*0.75
End if 


$height:=OB Get:C1224($obj;"height";Is longint:K8:6)
If ($height=0)
	$height:=($bottom-$top)*0.75
End if 


If (OB Is defined:C1231($obj;"type"))
	$type:=OB Get:C1224($obj;"type";Is longint:K8:6)
Else 
	$type:=Modal form dialog box:K39:7
End if 


$padTop:=OB Get:C1224($obj;"padTop";Is longint:K8:6)
$padLeft:=OB Get:C1224($obj;"padLeft";Is longint:K8:6)

If (OB Is defined:C1231($obj;"title"))
	$title:=OB Get:C1224($obj;"title";Is text:K8:3)
End if 

If (OB Is defined:C1231($obj;"closeBox"))
	$closeBox:=OB Get:C1224($obj;"closeBox";Is text:K8:3)
End if 

  // --------------------------------------------------------
$top:=$top+$padTop
$left:=$left+$padLeft

$right:=$left+$width
$bottom:=$top+$height

  // --------------------------------------------------------

Case of 
	: ($type=Modal dialog:K27:2) | ($type=Modal dialog box:K34:2) | ($type=Modal form dialog box:K39:7) | (($closeBox="") & ($title=""))
		$0:=Open window:C153($left;$top;$right;$bottom;$type)
	: ($closeBox="")
		$0:=Open window:C153($left;$top;$right;$bottom;$type;$title)
	Else 
		$0:=Open window:C153($left;$top;$right;$bottom;$type;$title;$closeBox)
End case 

