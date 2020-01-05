//%attributes = {"preemptive":"incapable"}
  // < 4D_ALERT >
  // Written By: Kirk Brooks
  // Created:  08/30/10, 10:35:16
  // ----------------------------------------------------
  // Method: 4D_ALERT (text{;text{;text}})
  // $1 is the primary text to display
  //    if $1≤1≥ = * first line will be in Bold & red
  //    if $1≤1≥ = ! first line will be in bold
  //    if $1≤1≥ = # show raw text
  // $2 is secondary information - this will not display unless $1 # ""
  // $3 : alt title:  default = "ALERT"
  // Purpose : the purpose of this method is to display the alert box if:
  //  -  we are not running on the server
  //  -  $1 actually has something to display
  // Don't open if On Server, 
  // Don't open for several form events which can lock the database into
  // a loop it's impossible to break out of. 
  // Modified by: Kirk (2/12/18)
  // mod to use prosObject

C_TEXT:C284($1;$2;$3;$form_title;$formName;$text;$text2)
C_LONGINT:C283($window;$pos)
C_BOOLEAN:C305($resetTitle)

ASSERT:C1129(Count parameters:C259>0)

  // check all possible in-admissiable events & situations
Case of 
	: (Application type:C494=4D Server:K5:6)
	: ($1="")
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
		
		$form_title:="ALERT"
		If (Count parameters:C259>1)  // put this in gray
			$text2:=$2
			If (Count parameters:C259>2)
				$form_title:=$3
			End if 
		End if 
		
		$text:=4D_alert_Format_text ($1)
		
		OK:=1
		
		  // =================================================================
		  // if the window we are opening from is a modal window use the 4D alert
		  // otherise the window will open behind the modal window
		  // =================================================================
		
		If (Window kind:C445(Frontmost window:C447)=Modal dialog:K27:2)\
			 | (Window kind:C445(Frontmost window:C447)=Modal dialog box:K34:2)\
			 | (Window kind:C445(Frontmost window:C447)=Modal form dialog box:K39:7)\
			 | (Window kind:C445(Frontmost window:C447)=Floating window:K27:4)
			
			$resetTitle:=True:C214
			  // open the alert as a modal window
			  // $window:=WIN_open_inCurrentWindow (430;90;45;Modal dialog;45)
			
		Else   // open it in a plain form
			  // $window:=Open form window("My_alert_dlog";Plain form window)
			$window:=WIN_open_inCurrentWindow (430;110;100;Plain form window:K39:10)
		End if 
		C_OBJECT:C1216($form_obj)
		
		$form_obj:=New object:C1471(\
			"text";$text;\
			"text2";$text2;\
			"curWinNumber";Current form window:C827;\
			"curWinTitle:";Get window title:C450(Current form window:C827);\
			"title";$form_title)
		
		
		SET WINDOW TITLE:C213("ALERT")
		
		DIALOG:C40("My_alert_dlog";$form_obj;*)
		
		CLOSE WINDOW:C154
		
		If ($resetTitle)
			SET WINDOW TITLE:C213(ProsObj .alertMsg.curWinTitle)
		End if 
		
		ProsObj .alertMsg:=New object:C1471
		
End case 

  //</ 4D_ALERT >
