//%attributes = {}
  //  4Dalert_form_controller
  // Written by: Kirk as Designer, Created: 04/19/18, 18:54:03
  // ------------------
  // Method: 4Dalert_form_controller ()
  // Purpose: 

C_TEXT:C284($1;$2;$action;$errMsg)
C_LONGINT:C283($0;$form_return)
C_POINTER:C301($ptrCurrent;$ptrObj)
C_OBJECT:C1216($obj)

$ptrCurrent:=OBJECT Get pointer:C1124(Object current:K67:2)
If (Count parameters:C259=0)
	$action:=OBJECT Get name:C1087(Object current:K67:2)
Else 
	$action:=$1
End if 
  // ------------------------------------------
$obj:=New object:C1471


  // ------------------------------------------
Case of 
	: (False:C215)  ///// buttons /////
	: ($action="")
	: ($action="")
	: (False:C215)  ///// fields /////
	: (False:C215)  // ($action="message")
		C_TEXT:C284($menu;$menuResult_str;$subMenu)
		
		$menu:=Create menu:C408
		$subMenu:=Create menu:C408
		
		  // create list of font sizes
		APPEND MENU ITEM:C411($subMenu;"10pt")
		SET MENU ITEM PARAMETER:C1004($subMenu;-1;"10pt")
		
		APPEND MENU ITEM:C411($subMenu;"12pt")
		SET MENU ITEM PARAMETER:C1004($subMenu;-1;"12pt")
		
		APPEND MENU ITEM:C411($subMenu;"14pt")
		SET MENU ITEM PARAMETER:C1004($subMenu;-1;"14pt")
		
		APPEND MENU ITEM:C411($subMenu;"16pt")
		SET MENU ITEM PARAMETER:C1004($subMenu;-1;"16pt")
		
		  // --------------------------------------------------------
		
		APPEND MENU ITEM:C411($menu;"Save text to clipboard")
		SET MENU ITEM PARAMETER:C1004($menu;-1;"save")
		
		APPEND MENU ITEM:C411($menu;"---")  // line
		
		APPEND MENU ITEM:C411($menu;"Font size";$subMenu)
		
		  // display the menu, get the result
		$menuResult_str:=Dynamic pop up menu:C1006($menu)
		
		RELEASE MENU:C978($menu)
		
		  ///////////////////////////////////////////////////////////
		
		Case of 
			: ($menuResult_str="")  // drag off
				
			: ($menuResult_str="save")
				  // save the plain text in event it's formatted
				SET TEXT TO PASTEBOARD:C523(ST Get plain text:C1092(*;"message"))
				
			Else   // set the font size
				  // 1) save it
				C_TEXT:C284($path;$size)
				C_BLOB:C604($blob)
				
				$path:=Get 4D folder:C485(Current resources folder:K5:16)+"fontsize.txt"
				
				TEXT TO BLOB:C554($menuResult_str;$blob;UTF8 text without length:K22:17)
				BLOB TO DOCUMENT:C526($path;$blob)
				
				  // 2) set the form
				OBJECT SET FONT SIZE:C165(*;"message";Num:C11($menuResult_str))
				
		End case 
		
	: ($action="")
	: ($action="")
	: ($action="")
	: (False:C215)  ///// form objects /////
	: ($action="")
	: (False:C215)  ///// form actions /////
	: ($action="")
	: ($action="formEvents")
		
		Case of 
			: (Form event code:C388=On Load:K2:1)
				  // Modified by: Kirk Brooks (10/10/14)
				  // set the font size
				OBJECT SET FONT SIZE:C165(*;"message";Font_get_size )
				
				  //OBJECT Get pointer(Object named;"message")Form.text)
				  // OBJECT_SET_TEXT("message2";Form.text2)
				
				If (Form:C1466.title=Null:C1517)
					Form:C1466.title:="ALERT"
				End if 
				
				  // --------------------------------------------------------
				Resize_window ("message")
				
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

  // ------------------------------------------
  // $0:=$form_return
If ($errMsg#"")
	ALERT:C41($errMsg)
End if 

