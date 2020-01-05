//%attributes = {}
  // [ WIN_open_inCurrentWindow ]
  // Written (OS): Kirk Brooks  Created: 11/16/12, 15:41:56
  // ------------------
  // Method: WIN_open_inCurrentWindow (longint; longint{;longint{;longint{;longint}}}) -> longint
  // $1 is the Width
  // $2 is the height
  // $3 is the # pix to space down from top
  //   - default is 45
  // $4 is the type 
  //   - default is Modal
  // $5 is the # pix to space from the left
  //   - default is 0


C_LONGINT:C283($1;$2;$3;$4;$0;$5)
C_OBJECT:C1216($obj)


OB SET:C1220($obj;\
"width";$1;\
"height";$2;\
"type";Modal form dialog box:K39:7;\
"window";Frontmost window:C447)


If (Count parameters:C259>2)
	OB SET:C1220($obj;"padTop";$3)
	If (Count parameters:C259>3)
		OB SET:C1220($obj;"type";$4)
		If (Count parameters:C259>4)
			OB SET:C1220($obj;"padLeft";$5)
		End if 
	End if 
End if 

$0:=WIN_open_inCurrentWinByObj ($obj)

