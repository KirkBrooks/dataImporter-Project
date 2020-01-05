//%attributes = {}
  //  Font_get_size
  // Written by: Kirk Brooks as Designer, Created: 10/10/14, 10:23:50
  // ------------------
  // Method: Font_get_size () -> longint
  // 
  // Purpose: return the font size for  display
C_LONGINT:C283($0)
C_TEXT:C284($path;$size)
C_BLOB:C604($blob)


$path:=Get 4D folder:C485(Current resources folder:K5:16)+"fontsize.txt"

If (Not:C34(File_exists ($path)))  // need to create it
	TEXT TO BLOB:C554("12";$blob;UTF8 text without length:K22:17)
	BLOB TO DOCUMENT:C526($path;$blob)
	$size:="12pt"
	
Else   // read it
	DOCUMENT TO BLOB:C525($path;$blob)
	$size:=BLOB to text:C555($blob;UTF8 text without length:K22:17)
	
End if 



$0:=Num:C11($size)

  //[End Font_get_size ]
