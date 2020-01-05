  //  On Startup ()
  // Written by: Kirk as Designer, Created: 10/30/19, 07:11:07
  // ------------------
  // Purpose: 





If (Num:C11(Substring:C12(Application version:C493;1;2))<18)
	ALERT:C41("This database is for 4D verison 18+. ")
	QUIT 4D:C291
End if 


