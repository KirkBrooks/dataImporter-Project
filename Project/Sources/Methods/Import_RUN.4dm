//%attributes = {}
  //  Import_RUN (object; object) -> text
  // $1: paramObj  -- see: Import_paramObj
  // $2: updateObj -- see: Import_updateObj
  // $0: result text
  // Written by: Kirk as Designer, Created: 10/14/19, 09:38:29
  // ------------------
  // Purpose: write the imported data to disk. 
  // 

C_OBJECT:C1216($1;$paramObj)
C_OBJECT:C1216($2;$updateObj)
C_TEXT:C284($0;$result_t)
C_BOOLEAN:C305($ok)
C_LONGINT:C283($i;$n;$n_records)
C_COLLECTION:C1488($data;$dataMap;$rec_col)
C_OBJECT:C1216($ds;$newRec;$map_obj)
C_TEXT:C284($thisField)

$ds:=ds:C1482

$paramObj:=$1
$updateObj:=$2

$data:=$paramObj.data
  // the data collection contains collection of values
$dataMap:=$updateObj.dataMap

  // --------------------------------------------------------
  //  we need the field type of each field written to
  // also check there is at least 1 field to import
  // --------------------------------------------------------
$ok:=False:C215

For each ($map_obj;$dataMap)
	
	Case of 
		: (Not:C34($map_obj.import))
			
		: ($ds[$map_obj.targetField.table][$map_obj.targetField.name].kind="storage")
			$ok:=True:C214
			$map_obj.targetField.fieldType:=$ds[$map_obj.targetField.table][$map_obj.targetField.name].fieldType
			
		Else 
			$map_obj.import:=False:C215
	End case 
	
End for each 
  // --------------------------------------------------------

If ($ok)
	$n:=0  //  number records created
	$n_records:=$data.length  //  number records in import data
	
	  // --------------------------------------------------------
	C_LONGINT:C283($progress_id)
	$progress_id:=Progress New 
	Progress SET TITLE ($progress_id;"Writing data...";-1)
	  // --------------------------------------------------------
	ERR_INSTALL_HANDLER ("ERR_IGNORE")
	
	For each ($rec_col;$data)
		
		If ($i%100=0)
			Progress SET PROGRESS ($progress_id;$i/$n_records)
		End if 
		
		$newRec:=$ds[$updateObj.table].new()
		
		$i:=0
		For each ($map_obj;$dataMap)
			$thisField:=$map_obj.targetField.name
			
			Case of 
				: ($map_obj.import=False:C215)  // ignore
					
				: ($map_obj.targetField.fieldType=Is object:K8:27)
					  // initialize the object field?
					If ($newRec[$thisField]=Null:C1517)
						$newRec[$thisField]:=New object:C1471
					End if 
					
					If (OB Get:C1224($map_obj.targetField;"prop";Is text:K8:3)#"")  //  write as a property to object field
						$newRec[$thisField][$map_obj.targetField.prop]:=$rec_col[$i]
					End if 
					
				: ($map_obj.targetField.fieldType=Is text:K8:3) | ($map_obj.targetField.fieldType=Is alpha field:K8:1)  //  write as text
					$newRec[$thisField]:=$rec_col[$i]
					
				: ($map_obj.targetField.fieldType=Is real:K8:4) | ($map_obj.targetField.fieldType=Is longint:K8:6)  //  write as a number
					$newRec[$thisField]:=Num:C11($rec_col[$i])
					
				: ($map_obj.targetField.fieldType=Is boolean:K8:9)
					  // accomodate different ways of indicating 'true'
					$newRec[$thisField]:=($rec_col[$i]="t@") | ($rec_col[$i]="1") | ($rec_col[$i]="yes")
					
				: ($map_obj.targetField.fieldType=Is date:K8:7)
					$newRec[$thisField]:=Date:C102($rec_col[$i])
					
				: ($map_obj.targetField.fieldType=Is time:K8:8)
					$newRec[$thisField]:=Time:C179($rec_col[$i])
					
				: (False:C215)  // 
					
				Else   // 
					
			End case 
			
			$i:=$i+1
		End for each 
		
		$ok:=$newRec.save().success
		
		If ($ok)
			$n:=$n+1
		Else 
			TRACE:C157
		End if 
	End for each 
	
	ERR_INSTALL_HANDLER 
	  // --------------------------------------------------------
	Progress QUIT ($progress_id)
	  // --------------------------------------------------------
	
	$result_t:=String:C10($n)+" records created."
Else 
	$result_t:="No records created."
End if 
  // --------------------------------------------------------
$0:=$result_t


