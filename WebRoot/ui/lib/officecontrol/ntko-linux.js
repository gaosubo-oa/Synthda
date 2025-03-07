'use strict';
var vActiveOfficeObject = {};


ntkoLinuxOfficeControl.prototype = {
 init:function( tagID, codes, ntkoID )
{
    if( ( 'undefined' === typeof tagID ) || 
		( 'undefined' === typeof codes ) || 
		( 'undefined' === typeof ntkoID ) )
			return( null );

	if( ( ( null === tagID ) || ( "" === tagID ) ) || 
		( ( null === codes ) || ( "" === codes ) ) || 
		( ( null === ntkoID ) || ( "" === ntkoID ) ))
		return ( null );

	var vPageIframe = document.getElementById(tagID);
	vPageIframe.innerHTML = codes.join("");

	this.vNtkoOfficeObject = null;
	this.vNtkoOfficeObject = document.getElementById(ntkoID);
    if( null === this.vNtkoOfficeObject )
		return ( null );

	window.onbeforeunload = function() { 
	   	this.vNtkoOfficeObject.quit(); 
     };
	
	window.onresize = function() {
  var obj=document.getElementsByTagName("embed");
		this.vNtkoOfficeObject.sltReleaseKeyboard();
	}; 
},

createDocument:function( vType )
{
	if( 'undefined' === typeof vType )
		return( false );
	
	return( createnew(vType) );
},

opendocument:function( strFileName, bReadOnly )
{
	if( ( 'undefined' === typeof strFileName ) || ( null === strFileName ) || ( "" === strFileName ) )
		return( false );

	return( openlocalfile( strFileName, bReadOnly ) );
},

opendocumentremote:function( strUrl, bReadOnly )
{
	return( openfromurl( strUrl, bReadOnly ) );
},

createnew:function( vType ) 
{ 
	if( 'undefined' === typeof vType )
		return( false );

	if( null != this.vNtkoOfficeObject )
	{
	 	var vDocType = this.vNtkoOfficeObject.doctype;
        
        if(( null != vType ) && ( "" != vType ))
		{
			var vDocOpenType = vType.toLowerCase();
			var varNeedDocType = 100;
			if( ( "wps.document" === vDocOpenType ) || ( "word.document" === vDocOpenType ) || ( "uot" === vDocOpenType ) )    
			{
				varNeedDocType = 6;
			}
			else if( ( "excel.sheet" === vDocOpenType ) || ( "et.workbook" === vDocOpenType ) || ( "uos" === vDocOpenType ) )           
			{
				varNeedDocType = 7;
			}
			else if ( ( "powerpoint.show" === vDocOpenType ) || ( "uop" === vDocOpenType ) )          
			{
				varNeedDocType = 8;
			}
			else
				return( false );
			
			if( ( 100 != vDocType ) && ( vDocType != varNeedDocType ) )
			{
				this.close();
			}
			
			return(this.vNtkoOfficeObject.CreateNew( varNeedDocType ));
		}
		return ( false );
	}
   	return ( false );
},

close:function()
{
	if( null != this.vNtkoOfficeObject )
		this.vNtkoOfficeObject.ntkoClose(false);
}, 


openlocalfile:function( strFilePath, bReadOnly, strWpsType )
{
	if( null != this.vNtkoOfficeObject )
	{
		var varOpenFilePath;
		var varNeedDocType = 100;
		var vDocType = this.vNtkoOfficeObject.doctype;

		// 如果传的路径为空，则需要弹出对话框让用户选择
		if( ( 'undefined' === typeof strFilePath ) || ( null === strFilePath ) || ( "" === strFilePath ) )
		{
			varOpenFilePath = this.vNtkoOfficeObject.GetLocalFile();
			if( ( null === varOpenFilePath ) || ( "" === varOpenFilePath ) )
				return( false );
		}
		else
			varOpenFilePath = strFilePath;
		
		// 首先根据文件的后缀名来判断，如果能够判断，则打开文档，如果不能判断，则根据第三个参数来进行判断
		var vIndex = varOpenFilePath.lastIndexOf(".");
		if( -1 != vIndex )
		{
			var varFileSuffix = varOpenFilePath.substring(vIndex + 1 );
			if( ( "doc" === varFileSuffix ) || ( "docx" === varFileSuffix ) || ("docm" === varFileSuffix ) || 	("dot" === varFileSuffix )	
				|| ( "wps"=== varFileSuffix ) || ("wpt" === varFileSuffix) || ("odt" === varFileSuffix)) 																
			{
				varNeedDocType = 6;
			}																	
			else if( ( "xls" === varFileSuffix ) || ( "xlsx" === varFileSuffix ) || ("xlsm" === varFileSuffix ) 	
				|| ( "et"=== varFileSuffix ) || ( "ods" === varFileSuffix ) || ( "csv" === varFileSuffix ))
			{
				varNeedDocType = 7;
			}
			else if( ( "ppt" === varFileSuffix ) || ( "pptx" === varFileSuffix ) || ("pptm" === varFileSuffix ) 		
				|| ( "dps"=== varFileSuffix ) || ("dpt" === varFileSuffix) || ("pot" === varFileSuffix)|| ("odp" === varFileSuffix)  )
			{
				varNeedDocType = 8;
			}	// 其他的类型，例如pdf/ofd暂不处理
			else
				return( false );
		}
		else
			return( false );

		// 判断文件是否存在
		var bHaveExist = this.vNtkoOfficeObject.IsLocalFileExists( varOpenFilePath );
		if( bHaveExist )
		{
			// 有可能需要重新初始化插件
			if( ( 100 != vDocType ) && ( vDocType != varNeedDocType ) )
			{ 
			       this.close();
			}
		
			if( 'undefined' === typeof bReadOnly )
				return( this.vNtkoOfficeObject.OpenLocalFile( varNeedDocType, varOpenFilePath ) );
			else
				return( this.vNtkoOfficeObject.OpenLocalFile( varNeedDocType, varOpenFilePath, bReadOnly ) );
		}
		else
			return( false );
	}
	return( false );
},

openfromurl:function( strUrl, bReadOnly, strWpsType )
{
	if( null != this.vNtkoOfficeObject )
	{
		var varOpenFilePath;
		var varNeedDocType = 100;
		var vDocType = this.vNtkoOfficeObject.doctype;

		varOpenFilePath = strUrl;
		
		// 首先根据文件的后缀名来判断，如果能够判断，则打开文档，如果不能判断，则根据第三个参数来进行判断
		var vIndex = varOpenFilePath.lastIndexOf(".");
		if( -1 != vIndex )
		{
			var varFileSuffix = varOpenFilePath.substring(vIndex + 1 );
			if( ( "doc" === varFileSuffix ) || ( "docx" === varFileSuffix ) || ("docm" === varFileSuffix ) || 	("dot" === varFileSuffix )	
				|| ( "wps"=== varFileSuffix ) || ("wpt" === varFileSuffix) ) 																
			{
				varNeedDocType = 6;
			}																	
			else if( ( "xls" === varFileSuffix ) || ( "xlsx" === varFileSuffix ) || ("xlsm" === varFileSuffix ) 	
				|| ( "et"=== varFileSuffix ) || ( "ods" === varFileSuffix ) )
			{
				varNeedDocType = 7;
			}
			else if( ( "ppt" === varFileSuffix ) || ( "pptx" === varFileSuffix ) || ("pptm" === varFileSuffix ) 		
				|| ( "dps"=== varFileSuffix ) || ("dpt" === varFileSuffix) || ("pot" === varFileSuffix)  )
			{
				varNeedDocType = 8;
			}	// 其他的类型，例如pdf/ofd暂不处理
			else{
				if( ( "wps.document" === strWpsType ) || ( "word.document" === strWpsType ) )    
				{
					varNeedDocType = 6;
					
				}
				else if( ( "excel.sheet" === strWpsType ) || ( "et.workbook" === strWpsType ) )           
				{
					varNeedDocType = 7;
				}
				else if ( ( "powerpoint.show" === strWpsType ) )          
				{
					varNeedDocType = 8;
				}
				else
					return( false );
				
			}
		}
		else		// 有可能是流，则根据第三个参数来进行处理
		{
			if( ( "wps.document" === strWpsType ) || ( "word.document" === strWpsType ) )    
				{
					varNeedDocType = 6;
					
				}
				else if( ( "excel.sheet" === strWpsType ) || ( "et.workbook" === strWpsType ) )           
				{
					varNeedDocType = 7;
				}
				else if ( ( "powerpoint.show" === strWpsType ) )          
				{
					varNeedDocType = 8;
				}
				else
					return( false );
		}

		// 有可能需要重新初始化插件
		if( ( 100 != vDocType ) && ( vDocType != varNeedDocType ) )
		{ 
 			this.close();
		}
		
		if( 'undefined' === typeof bReadOnly )
			return( this.vNtkoOfficeObject.OpenFromURL( varNeedDocType, varOpenFilePath ) );
		else
			return( this.vNtkoOfficeObject.OpenFromURL( varNeedDocType, varOpenFilePath, bReadOnly ) );
	}
	return( false );
},

beginopenfromurl:function( strURL, bIsShowProgress, bReadOnly, strWpsType )
{
	return( this.openfromurl( strURL, bReadOnly, strWpsType ) );
},

putbase64value:function( strVarValue, strProgId )
{
	if( ( 'undefined' === typeof strProgId ) || ( 'undefined' === typeof strVarValue ) )
		return( false );

	if( null != this.vNtkoOfficeObject )
	{
	 	var vDocType = this.vNtkoOfficeObject.doctype;
        
        if(( null != strProgId ) && ( "" != strProgId ))
		{
			var vDocOpenType = strProgId.toLowerCase();
			var varNeedDocType = 100;
			if( ( "wps.document" === vDocOpenType ) || ( "word.document" === vDocOpenType ) )    
			{
				varNeedDocType = 6;
			}
			else if( ( "excel.sheet" === vDocOpenType ) || ( "et.workbook" === vDocOpenType ) )           
			{
				varNeedDocType = 7;
			}
			else if ( ( "powerpoint.show" === vDocOpenType ) )          
			{
				varNeedDocType = 8;
			}
			else
				return( false );
			
			if( ( 100 != vDocOpenType ) && ( vDocOpenType != varNeedDocType ) )
			{
				this.close();
			}
			
			return(this.vNtkoOfficeObject.PutBase64Value( varNeedDocType, strVarValue ));
		}
		return ( false );
	}
   	return ( false );
},

sltReleaseKeyboard:function()
{
	this.vNtkoOfficeObject.sltReleaseKeyboard();
},
};

 function ntkoLinuxOfficeControl() 
{
  this.vNtkoOfficeObject = null;
  this.vNtkoTagID = null;
  this.vNtkoCodes = null;
  this.vNtkoOfficeID = null;
}

function init( tagID, codes, ntkoID )
{
	if( ( null === tagID ) || ( "" === tagID ) || ( null === codes ) || ( "" === codes ) )
		return null;

	var varLinuxOffficeContorl = new ntkoLinuxOfficeControl();

	var vPageIframe = document.getElementById(tagID);
	vPageIframe.innerHTML = codes.join("");

	varLinuxOffficeContorl.vNtkoOfficeObject = document.getElementById(ntkoID);
    if( null === varLinuxOffficeContorl.vNtkoOfficeObject )
		return null;

	window.onbeforeunload = function() { 
	   	varLinuxOffficeContorl.vNtkoOfficeObject.quit(); 
     };

	
	window.onresize = function() {
		varLinuxOffficeContorl.vNtkoOfficeObject.sltReleaseKeyboard();
	}; 
	
	varLinuxOffficeContorl.vNtkoTagID = tagID;
	varLinuxOffficeContorl.vNtkoCodes = codes;
	varLinuxOffficeContorl.vNtkoOfficeID = ntkoID;

	varLinuxOffficeContorl = new Proxy( varLinuxOffficeContorl, {
		set: function( target, key, value, proxy ) {
			target.vNtkoOfficeObject.setAttribute( key, value );
		},
		get: function( target, key, proxy ) { 
			// 将key的值转换为小写
			var varKey = key.toLowerCase();
			var varValue = target[varKey];
			if( typeof varValue === 'function' )
			{
				return ( function() { return( Reflect.apply( varValue, target, arguments) );});
			}
			else
			{   
				if( 'vntkoofficeobject' === varKey )
				{
					return( target.vNtkoOfficeObject );
				}
				if( 'activedocument' === varKey )
				{
					return( target.vNtkoOfficeObject.getAttribute(varKey) );
				}
                var vOfficeValue = target.vNtkoOfficeObject[varKey];
				if( 'undefined' != typeof vOfficeValue  )
				{
					var vOfficeValueString = vOfficeValue.toString();
					if( 'undefined' != typeof vOfficeValueString )
					{	
						if( '[object NPObject JS wrapper class]' === vOfficeValue.toString() )
							return( vOfficeValue );
					}

		            if( typeof vOfficeValue === 'function' )
					{
					   return ( function() { return( Reflect.apply( vOfficeValue, target.vNtkoOfficeObject, arguments) );});
					}else{
						if( 'vNtkoOfficeObject' === key )
						{
							return( target[key] );

						}else{
							return( vOfficeValue );
						}
					}
				}else{
					
					window.onerror = function(errorMessage, scriptURI, lineNumber,columnNumber,errorObj) {
   						return true;
					}
					
				}
			}
		}
	});
	vActiveOfficeObject[ntkoID] = varLinuxOffficeContorl;
	return ( varLinuxOffficeContorl );
}


function ntkooffice_createnew( id, vData )
{
    if( 'undefined' != typeof vActiveOfficeObject[id] )
			vActiveOfficeObject[id].createnew( vData );
}

function ntkooffice_openlocalfile( id, vFilePath, vReadOnly )
{
    if( 'undefined' != typeof vActiveOfficeObject[id] )
		vActiveOfficeObject[id].openlocalfile( vFilePath,  vReadOnly );
}

function ntkooffice_close( id )
{
    if( 'undefined' != typeof vActiveOfficeObject[id] )
{
		vActiveOfficeObject[id].close();
}
}


