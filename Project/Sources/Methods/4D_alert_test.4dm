//%attributes = {}
  //  4D_alert_test
  // Written by: Kirk as Designer, Created: 04/27/18, 11:17:44
  // ------------------
  // Method: 4D_alert_test ()
  // Purpose: 


ALERT:C41("A series of custom alert boxes follow.")

4D_ALERT ("This is a simple alert.")

4D_ALERT ("This is a simple alert with secondary text.";\
"This is secondary text")

4D_ALERT ("This is a simple alert with secondary text and custom title.";\
"This is secondary text";\
"My Special Title")

4D_ALERT (\
"This is a long text block.\r\rSed ut perspiciatis\r\rUnde [omnis] & {iste} natus %error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo."+"\r\rNemo enim ipsam voluptate"+"m quia "+"vol"+"uptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempor"+"a incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea volu"+"ptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?";\
Current method name:C684)


4D_ALERT ("!This line should be in bold.\r\rThis line should be plain text.";\
Current method name:C684)

4D_ALERT ("*This line should be in bold and red.\r\rThis line should be plain text.";\
Current method name:C684)

