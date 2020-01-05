//%attributes = {"preemptive":"incapable"}
  // 4D_REQUEST
  // Written By: Kirk Brooks
  // Modified by: Kirk (4/27/18) 
  // ----------------------------------------------------
  // Method: 4D_REQUEST (object) -> text
  // $1 : params {
  //   message: "",      //  text to display
  //   userInput: "",    //  text inserted in the userInput
  //   title: "",        //  the title - default is REQUEST
  //   entryFilter: "",  //  4D input filter that's applied to the input area
  //   success: bool     //  true if accepted
  //  }
  // $0 : user input
  // Purpose : the purpose of this method is to display the request box if:
  //  -  we are not running on the server
  //  -  $1 actually has something to display
  // message text to display
  //    if $1≤1≥ = * first line will be in Bold & red
  //    if $1≤1≥ = ! first line will be in bold
  //    if $1≤1≥ = # show raw text
  // Don't open if On Server, 
  // Don't open for several form events which can lock the database into
  // a loop it's impossible to break out of. 

C_OBJECT:C1216($1;$form_obj)
C_TEXT:C284($curWinTitle)
C_LONGINT:C283($window;$pos)
C_BOOLEAN:C305($resetTitle)

ASSERT:C1129(Count parameters:C259>0)

  // check all possible in-admissiable events & situations
Case of 
	: (Application type:C494=4D Server:K5:6)
	: (Not:C34(OB Is defined:C1231($1)))
	: (Form event code:C388=On Resize:K2:27)
	: (Form event code:C388=On Timer:K2:25)
	: (Form event code:C388=On Activate:K2:9)
	: (Form event code:C388=On After Edit:K2:43)
	: (Form event code:C388=On After Keystroke:K2:26)
	: (Form event code:C388=On Before Data Entry:K2:39)
	: (Form event code:C388=On Before Keystroke:K2:6)
	: (Form event code:C388=On Deactivate:K2:10)
	: (Form event code:C388=On Scroll:K2:57)
	Else   // it's ok to open a dialog
		
		OK:=1
		  // =================================================================
		  // if the window we are opening from is a modal window use the 4D alert
		  // otherise the window will open behind the modal window
		  // =================================================================
		$curWinTitle:=Get window title:C450(Current form window:C827)
		
		If (Window kind:C445(Frontmost window:C447)=Modal dialog:K27:2)\
			 | (Window kind:C445(Frontmost window:C447)=Modal dialog box:K34:2)\
			 | (Window kind:C445(Frontmost window:C447)=Modal form dialog box:K39:7)\
			 | (Window kind:C445(Frontmost window:C447)=Floating window:K27:4)
			
			$resetTitle:=True:C214
			  // open the alert as a modal window
			  // $window:=WIN_open_inCurrentWindow (430;90;45;Modal dialog;45)
			
		Else   // open it in a plain form
			  // $window:=Open form window("My_alert_dlog";Plain form window)
			$window:=WIN_open_inCurrentWindow (430;185;100;Plain form window:K39:10)
		End if 
		
		$form_obj:=$1
		
		SET WINDOW TITLE:C213("REQUEST")
		DIALOG:C40("My_request_dlog";$1)
		CLOSE WINDOW:C154
		
		If ($resetTitle)
			SET WINDOW TITLE:C213($curWinTitle)
		End if 
		
End case 

  //</ 4D_ALERT >
