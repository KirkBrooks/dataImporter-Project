//%attributes = {}
/*  __UI ()
   Written by: Kirk as Designer, Created: 10/29/19, 10:03:15
   ------------------
 Purpose: UI deals with opening a dialog for user input. 
Without UI everything is done directly with the methods

The UI all takes place in the UI window on the UI_outline form. 
Various import and parsing tasks are handled by dedicated subforms. 



PARTS OF AN IMPORT
  IMPORT TEXT
    User pasted in text or opens a data file. Data file is read to text.
    The text is a brief intermediary stage. The data is split into a collection of 
    characters for parsing.
  
  PARSING
    Once the text is split into the collection it is parsed into records and fields. 

  MAPPING
    Once fields are identified the data map can be created if the goal is to update
    the database. 

  WRITE DATA
    Create records based on the data. 

  RETURN DATA
    If the goal is simply to parse the data choose the return format. 


and starts with the ImpText_form
Don't use multiple page forms. Simply close and open 






*/


