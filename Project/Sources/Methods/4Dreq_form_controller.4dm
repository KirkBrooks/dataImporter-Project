//%attributes = {}
  //  4Dreq_form_controller
  // Written by: Kirk as Designer, Created: 04/27/18, 11:52:41
  // ------------------
  // Method: 4Dreq_form_controller ()
  // Purpose: 


C_TEXT:C284($1;$2;$action;$errMsg;$text)
C_LONGINT:C283($0;$form_return;$formWidth;$formHeight)
C_LONGINT:C283($l;$t;$r;$b)
C_POINTER:C301($ptrCurrent;$ptrObj)
C_OBJECT:C1216($obj)
C_REAL:C285($xBest;$yBest)


$ptrCurrent:=OBJECT Get pointer:C1124(Object current:K67:2)
If (Count parameters:C259=0)
	$action:=OBJECT Get name:C1087(Object current:K67:2)
Else 
	$action:=$1
End if 
  // ------------------------------------------



  // ------------------------------------------
Case of 
	: (False:C215)  ///// buttons /////
	: ($action="btn_accept")
		If (Length:C16(Form:C1466.userInput)>0)
			Form:C1466.success:=True:C214
			ACCEPT:C269
		Else 
			$errMsg:="You must enter something first."
		End if 
		
	: ($action="")
	: (False:C215)  ///// fields /////
	: ($action="userInput")
	: ($action="")
	: (False:C215)  ///// form actions /////
	: ($action="")
	: ($action="formEvents")
		Case of 
			: (Form event code:C388=On Load:K2:1)
				FORM GET PROPERTIES:C674("My_request_dlog";$formWidth;$formHeight)
				
				OBJECT SET FONT SIZE:C165(*;"message";Font_get_size )
				
				$text:=4D_alert_Format_text (Form:C1466.message)
				
				If (OB Is defined:C1231(Form:C1466;"entryFilter"))
					OBJECT SET FILTER:C235(*;"userInput";Form:C1466.entryFilter)
				End if 
				
				  // --------------------------------------------------------
				C_OBJECT:C1216($msg_o;$input_o;$bg_o)
				$msg_o:=New object:C1471("name";"message")
				$input_o:=New object:C1471("name";"userInput")
				$bg_o:=New object:C1471("name";"backgroundRect")
				
				OBJECT_GET_CoordObj ($msg_o)
				OBJECT_GET_CoordObj ($input_o)
				OBJECT_GET_CoordObj ($bg_o)
				
				OBJECT_GET_bestSize ($msg_o;$msg_o.x[0])
				OBJECT_GET_bestSize ($input_o;$input_o.x[0])
				
				
				  // --------------------------------------------------------
				  // figure out the best coords for each object
				  // don't need to worry about best width because it's fixed on this form
				
				$yBest:=$msg_o.y[1]+$msg_o.y[3]
				$msg_o.y[2]:=$yBest
				OBJECT_SET_CoordByObj ($msg_o)
				
				$yBest:=$yBest+10  //   space the white boarder down
				$input_o.y[1]:=$yBest
				$input_o.y[2]:=$yBest+$input_o.y[3]
				OBJECT_SET_CoordByObj ($input_o)
				
				  //  the back ground rect
				$bg_o.y[1]:=$input_o.y[1]-5
				$bg_o.y[2]:=$input_o.y[2]+5
				OBJECT_SET_CoordByObj ($bg_o)
				
				  // move the buttons 
				OBJECT MOVE:C664(*;"btn_@";0;($input_o.y[2]+10)-152)
				
				$formHeight:=$input_o.y[2]+40
				
				RESIZE FORM WINDOW:C890($formWidth;$formHeight)
				
				GET WINDOW RECT:C443($l;$t;$r;$b)
				SET WINDOW RECT:C444($l;$t;$l+$formWidth;$t+$formHeight)
				
			: (Form event code:C388=On Deactivate:K2:10)
				  // this keeps the dialog from getting hidden behind another window
				  // But it also creates a death race if the front window is some sort of modal
				
				BRING TO FRONT:C326(Current process:C322)
				
			: (Form event code:C388=On Outside Call:K2:11)
				CANCEL:C270
				
		End case 
	Else 
		$errMsg:="Unknown action or object: "+$action+"\r\rForm Event: "+4D_FormEvent_text +"  {"+Current method name:C684+"}"
End case 

  // OBJECT SET ENABLED(*;"btn_accept";Length(Object_get_text ("userImpout"))>0)


  // ------------------------------------------
  // $0:=$form_return
4D_ALERT ($errMsg;Current method name:C684)


