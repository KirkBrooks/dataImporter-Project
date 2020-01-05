//%attributes = {}
  // 4D_Formevent_text
  // Written By: Kirk Brooks
  // Created:  12/02/09, 11:47:25
  // Modified by: Kirk Brooks (9/1/11)
  // 9/1/11: updated to v12 - new events

  // ----------------------------------------------------
  // Method: 4D_Formevent_text ({longint}) -> text
  //$1 is the form event
  // Purpose : return a text desc of the current form event

  // Scope : 
C_LONGINT:C283($evt;$1)
C_TEXT:C284($text)

If (Count parameters:C259>0)
	$evt:=$1
Else 
	$evt:=Form event code:C388
End if 
  //
Case of 
	: ($evt<0)  //an inverted form action?
		$text:="** Custom ** : "+4D_FormEvent_text (Abs:C99($evt))
		
	: ($evt=On Activate:K2:9)
		$text:="On Activate"
	: ($evt=On After Edit:K2:43)
		$text:="On After Edit"
	: ($evt=On After Keystroke:K2:26)
		$text:="On After Keystroke"
	: ($evt=On After Sort:K2:28)
		$text:="On After Sort"
	: ($evt=On Alternative Click:K2:36)
		$text:="On Arrow Click"
	: ($evt=On Before Data Entry:K2:39)
		$text:="On Before Data Entry"
	: ($evt=On Before Keystroke:K2:6)
		$text:="On Before Keystroke"
	: ($evt=On Begin Drag Over:K2:44)
		$text:="On Begin Drag Over"
	: ($evt=On Begin URL Loading:K2:45)
		$text:="On Begin URL Loading"
	: ($evt=On Bound Variable Change:K2:52)
		$text:="On bound variable change"
	: ($evt=On Clicked:K2:4)
		$text:="On Clicked"
		
		If (Contextual click:C713)
			$text:=$text+" - contextual click"
		End if 
		
	: ($evt=On Close Box:K2:21)
		$text:="On Close Box"
	: ($evt=On Close Detail:K2:24)
		$text:="On Close Detail"
	: ($evt=On Collapse:K2:42)
		$text:="On Collapse"
	: ($evt=On Column Moved:K2:30)
		$text:="On Column Moved"
	: ($evt=On Column Resize:K2:31)
		$text:="On Column Resize"
	: ($evt=On Data Change:K2:15)
		$text:="On Data Change"
	: ($evt=On Deactivate:K2:10)
		$text:="On Deactivate"
	: ($evt=On Display Detail:K2:22)
		$text:="On Display Detail"
	: ($evt=On Double Clicked:K2:5)
		$text:="On Double Clicked"
	: ($evt=On Drag Over:K2:13)
		$text:="On Drag Over"
	: ($evt=On Drop:K2:12)
		$text:="On Drop"
	: ($evt=On End URL Loading:K2:47)
		$text:="On End URL Loading"
	: ($evt=On Expand:K2:41)
		$text:="On Expand"
	: ($evt=On Getting Focus:K2:7)
		$text:="On Getting Focus"
	: ($evt=On Header:K2:17)
		$text:="On Header"
	: ($evt=On Header Click:K2:40)
		$text:="On Header Click"
	: ($evt=On Load:K2:1)
		$text:="On Load"
	: ($evt=On Load Record:K2:38)
		$text:="On Load Record"
	: ($evt=On Long Click:K2:37)
		$text:="On Long Click"
	: ($evt=On Losing Focus:K2:8)
		$text:="On Losing Focus"
	: ($evt=_o_On Mac Toolbar Button:K2:53)
		$text:="On Mac toolbar button"
	: ($evt=On Menu Selected:K2:14)
		$text:="On Menu Selected"
	: ($evt=On Mouse Enter:K2:33)
		$text:="On Mouse Enter"
	: ($evt=On Mouse Leave:K2:34)
		$text:="On Mouse Leave"
	: ($evt=On Mouse Move:K2:35)
		$text:="On Mouse Move"
	: ($evt=On Open Detail:K2:23)
		$text:="On Open Detail"
	: ($evt=On Open External Link:K2:50)
		$text:="On Open External Link"
	: ($evt=On Outside Call:K2:11)
		$text:="On Outside Call"
	: ($evt=On Plug in Area:K2:16)
		$text:="On Plug in Area"
	: ($evt=On Printing Break:K2:19)
		$text:="On Printing Break"
	: ($evt=On Printing Detail:K2:18)
		$text:="On Printing Detail"
	: ($evt=On Printing Footer:K2:20)
		$text:="On Printing Footer"
	: ($evt=On Resize:K2:27)
		$text:="On Resize"
	: ($evt=On Row Moved:K2:32)
		$text:="On Row Moved"
	: ($evt=On Selection Change:K2:29)
		$text:="On Selection Change"
	: ($evt=On Timer:K2:25)
		$text:="On Timer"
	: ($evt=On Unload:K2:2)
		$text:="On Unload"
	: ($evt=On URL Filtering:K2:49)
		$text:="On URL Filtering"
	: ($evt=On URL Loading Error:K2:48)
		$text:="On URL Loading Error"
	: ($evt=On URL Resource Loading:K2:46)
		$text:="On URL Resource Loading"
	: ($evt=On Validate:K2:3)
		$text:="On Validate"
	: ($evt=On Window Opening Denied:K2:51)
		$text:="On Window Opening Denied"
	: ($evt=On Page Change:K2:54)
		$text:="On page change"
	Else 
		$text:="Unkown event : "+String:C10($evt)
End case 
  //
$0:=$text
  //