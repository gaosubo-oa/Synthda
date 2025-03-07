	var userAgent = navigator.userAgent,
				rMsie = /(msie\s|trident.*rv:)([\w.]+)/, 
				rFirefox = /(firefox)\/([\w.]+)/, 
				rOpera = /(opera).+version\/([\w.]+)/, 
				rChrome = /(chrome)\/([\w.]+)/, 
				rSafari = /version\/([\w.]+).*(safari)/;
				var browser;
				var version;
				var ua = userAgent.toLowerCase();
				function uaMatch(ua) {
					var match = rMsie.exec(ua);
					if (match != null) {
						return { browser : "IE", version : match[2] || "0" };
					}
					var match = rFirefox.exec(ua);
					if (match != null) {
						return { browser : match[1] || "", version : match[2] || "0" };
					}
					var match = rOpera.exec(ua);
					if (match != null) {
						return { browser : match[1] || "", version : match[2] || "0" };
					}
					var match = rChrome.exec(ua);
					if (match != null) {
						return { browser : match[1] || "", version : match[2] || "0" };
					}
					var match = rSafari.exec(ua);
					if (match != null) {
						return { browser : match[2] || "", version : match[1] || "0" };
					}
					if (match != null) {
						return { browser : "", version : "0" };
					}
				}
				var browserMatch = uaMatch(userAgent.toLowerCase());
				if (browserMatch.browser) {
					browser = browserMatch.browser;
					version = browserMatch.version;
				}
				//document.write(browser);
/*
谷歌浏览器事件接管
*/
function OnComplete2(type,code,html)
{
	//alert(type);
	//alert(code);
	//alert(html);
	//alert("SaveToURL成功回调");
}
function OnComplete(type,code,html)
{
	//alert(type);
	//alert(code);
	//alert(html);
	//alert("BeginOpenFromURL成功回调");
}
function OnComplete3(str,doc)
{
	TANGER_OCX_OBJ.activeDocument.saved=true;//saved属性用来判断文档是否被修改过,文档打开的时候设置成ture,当文档被修改,自动被设置为false,该属性由office提供.
	//	TANGER_OCX_OBJ.SetReadOnly(true,"");
		//TANGER_OCX_OBJ.ActiveDocument.Protect(1,true,"123");
		//获取文档控件中打开的文档的文档类型
		switch (TANGER_OCX_OBJ.doctype)
		{
			case 1:
				fileType = "Word.Document";
				fileTypeSimple = "wrod";
				break;
			case 2:
				fileType = "Excel.Sheet";
				fileTypeSimple="excel";
				break;
			case 3:
				fileType = "PowerPoint.Show";
				fileTypeSimple = "ppt";
				break;
			case 4:
				fileType = "Visio.Drawing";
				break;
			case 5:
				fileType = "MSProject.Project";
				break;
			case 6:
				fileType = "WPS Doc";
				fileTypeSimple="wps";
				break;
			case 7:
				fileType = "Kingsoft Sheet";
				fileTypeSimple="et";
				break;
			default :
				fileType = "unkownfiletype";
				fileTypeSimple="unkownfiletype";
		}
									
	//alert("ondocumentopened成功回调");
}
function publishashtml(type,code,html){
	//alert(html);
	//alert("Onpublishashtmltourl成功回调");
}
function publishaspdf(type,code,html){
//alert(html);
//alert("Onpublishaspdftourl成功回调");
}
function saveasotherurl(type,code,html){
//alert(html);
//alert("SaveAsOtherformattourl成功回调");
}
function dowebget(type,code,html){
//alert(html);
//alert("OnDoWebGet成功回调");
}
function webExecute(type,code,html){
//alert(html);
//alert("OnDoWebExecute成功回调");
}
function webExecute2(type,code,html){
//alert(html);
//alert("OnDoWebExecute2成功回调");
}
function FileCommand(TANGER_OCX_str,TANGER_OCX_obj){
	if (TANGER_OCX_str == 3) 
	{
		alert("不能保存！");
		TANGER_OCX_OBJ.CancelLastCommand = true;
	}
}
    function OnDocumentOpened( path, object )
    {
        var data = object.path;
         obj.Activate(true);
         // obj.Menubar=false;
        // obj.ToolBars = false
        // TANGER_OCX_OBJ.MenuBar=false;


    }
    function OnBeginOpenFromURL( uEnEIFT, uStateCode, returndata )
    {
        // alert("OnBeginOpenFromURL 事件" + uEnEIFT + uStateCode + returndata );
    }
    function OnAfterOpenFromURLCallBack( object, uStateCode )
    {
        // alert("AfterOpenFromURL 事件"  + uStateCode + object.FullName );
    }
    function OnDocumentClosed()
    {
        //alert("OnDocumentClosed 事件");
    }
    function OnCustomMenuCmd2( menuPos, submenuPos, subsubmenuPos, menuCaption, myMenuID )
    {
        alert("选择了[" + menuPos + "   " + submenuPos + "  " + subsubmenuPos + "     " + menuCaption + "  " + myMenuID + "]菜单项。在此你可以调用自己的JS函数");
    }
    function OnCustomToolBarCommand( menuPos )
    {
        alert("CustomToolBarCommand" + menuPos );
        if( 1 == menuPos )
            ntkoCreateNew('wps.document');
        else if( 2 == menuPos )
            obj.OpenLocAlFile("" );
        else if( 3 == menuPos )
            saveAs();
        else if( 4 == menuPos )
            obj.PrintOut(true);
        else if( 5 == menuPos )
            obj.PrintPreview();
        else if( 6 == menuPos )
            obj.Close();
    }
    function OnFileCommand( item, calcel )
    {
//alert("选择了[" + item + "   " + calcel  + "]菜单项。在此你可以调用自己的JS函数");
//obj.CancelLastCommand = true;
    }
    function OnCustomButtonOnMenuCmd( menuPos, menuCaption, myMenuID )
    {
        alert( "选择了[" + menuPos +  "     " + menuCaption + "  " + myMenuID + "]菜单项。在此你可以调用自己的JS函数");
    }
    function OnCustomFileMenuCmd( menuPos, menuCaption, myMenuID )
    {
        alert("选择了[" + menuPos + "     " + menuCaption + "    " + myMenuID + "]文件菜单项。在此你可以调用自己的JS函数");
    }
    function OnScreenModeChanged(IsActivated)
    {
//	alert("OnScreenModeChanged 事件" + IsActivated );
    }
    function CustomMenuCmd(menuPos,submenuPos,subsubmenuPos,menuCaption,menuID){
//alert("第" + menuPos +","+ submenuPos +","+ subsubmenuPos +"个菜单项,menuID="+menuID+",菜单标题为\""+menuCaption+"\"的命令被执行.");
}

    var obj;
    var isLinux = (String(navigator.platform).indexOf("Linux") > -1);

    var codes=[];
    //查询NTKO授权信息
    var paraValue;
    $.ajax({
        url:'/syspara/selectNtkoLicense',
        dataType:'json',
        type:'get',
        async: false,
        success:function(res){
            paraValue = res.obj1;
        }
    })
    if(isLinux){
        var codes=[];
        codes.push("<object  name='webwps' id='TANGER_OCX' type='application/ntko-plug'  height='600' width='100%' ForOnDocumentOpened = 'OnDocumentOpened' ForOnBeginOpenFromURL = 'OnBeginOpenFromURL' ForAfterOpenFromURL = 'OnAfterOpenFromURLCallBack' ForOnDocumentClosed = 'OnDocumentClosed' ForOnCustomMenuCmd2 = 'OnCustomMenuCmd2'  ForOnCustomToolBarCommand = 'OnCustomToolBarCommand' ForOnFileCommand = 'OnFileCommand'  ForOnCustomButtonOnMenuCmd = 'OnCustomButtonOnMenuCmd' ForOnCustomFileMenuCmd = 'OnCustomFileMenuCmd' ForOnScreenModeChanged = 'OnScreenModeChanged'  >   </object>");

        obj = init( "wordFormDiv", codes, "TANGER_OCX" );
    }else{
        //买断授权密钥如果不是买断可以不用写
        var MakerCaption="";
        //买断授权密钥如果不是买断可以不用写
        var MakerKey="";
        //文档控件解除时间限制密钥
        var NoExpireKey="";
        if(paraValue != undefined){
            if(paraValue.classid != undefined && paraValue.classid != null){
                var classid= paraValue.classid;
            }
            if(paraValue.classid64 != undefined && paraValue.classid64 != null){
                var classidx64 = paraValue.classid64;
            }
            if(paraValue.ProductCaption != undefined && paraValue.ProductCaption != null){
                var ProductCaption= paraValue.ProductCaption;
            }
            if(paraValue.ProductKey != undefined && paraValue.ProductKey != null){
                var ProductKey= paraValue.ProductKey;
            }
            if(paraValue.codebase != undefined && paraValue.codebase != null){
                var codebase= paraValue.codebase;
            }
            if(paraValue.codebase64 != undefined && paraValue.codebase64 != null){
                var codebase64= paraValue.codebase64;
            }
            if(paraValue.ntkopdfcodebase != undefined && paraValue.ntkopdfcodebase != null){
                var pdfbase= paraValue.ntkopdfcodebase;
            }
            if(paraValue.ntkopdfcodebase64 != undefined && paraValue.ntkopdfcodebase64 != null){
                var pdfbase64= paraValue.ntkopdfcodebase64;
            }
            if(paraValue.ntkopdfVersion != undefined && paraValue.ntkopdfVersion != null){
                var pdfbaseversion= paraValue.ntkopdfVersion;
                var pdfbase64version = paraValue.ntkopdfVersion;
            }
        }else{
            var classid="A64E3073-2016-4baf-A89D-FFE1FAA10EC0";
            var classidx64="A64E3073-2016-4baf-A89D-FFE1FAA10EE0";
            //密钥
            var ProductCaption='中电建水环境治理技术有限公司';
            var ProductKey='6C9BA65E40CE7074C145AC68868FD47B89290E15';
            var codebase="/lib/officecontrol/OfficeControl.cab#version=5,0,4,0";
            var codebase64="/lib/officecontrol/OfficeControl.cab#version=5,0,4,0";
            var pdfbase = '/lib/officecontrol/ntkooledocall.cab';
            var pdfbase64 = '/lib/officecontrol/ntkooledocallx64.cab';
            var pdfbaseversion = '4.0.1.0';
            var pdfbase64version = '4.0.1.0';
        }

	//32位控件的classid  平台版控件是32位控件
	// var classid="A64E3073-2016-4baf-A89D-FFE1FAA10EC0";
	//
	// //32位控件包的路径
	// var codebase="/lib/officecontrol/OfficeControl.cab#version=6.0.1.0";
	// var codebase64="/lib/officecontrol/OfficeControl.cab#version=6,0,1,0";
	// var pdfbase = '/lib/officecontrol/ntkooledocall.cab';
	// var pdfbase64 = '/lib/officecontrol/ntkooledocallx64.cab';
	// var pdfbaseversion = '4.0.2.0';
	// var pdfbase64version = '4.0.1.0';
	// //设置高度
	//
	// var height="800px";
	// //设置宽度
	// var width="100%";
	// //买断授权密钥如果不是买断可以不用写
	// var MakerCaption="";
	// //买断授权密钥如果不是买断可以不用写
	// var MakerKey="";
	// //密钥
	// var ProductCaption="中国人民解放军95948部队";
	// //密钥
	// var ProductKey="BC7734B0F0E4DEBBC14994C37D62B1F280DEA5A0";
	// //文档控件解除时间限制密钥
	// var NoExpireKey="";
        var userName = $('#userNameBox').val();
        console.log(browser)
        if (browser=="IE"){
            //alert(window.navigator.platform);
            if(window.navigator.platform=="Win32"){
                document.write('<!-- 用来产生编辑状态的ActiveX控件的JS脚本-->   ');
                document.write('<!-- 因为微软的ActiveX新机制，需要一个外部引入的js-->   ');
                document.write('<object id="TANGER_OCX" classid="clsid:'+classid+'"');
                document.write('codebase="'+codebase+'" width="100%" height="'+((document.documentElement.clientHeight || document.body.clientHeight))+'px">   ');
				document.write('<param name="MakerCaption" value="'+MakerCaption+'">   ');
				document.write('<param name="MakerKey" value="'+MakerKey+'">   ');
                document.write('<param name="IsUseUTF8URL" value="-1">   ');
                document.write('<param name="IsUseUTF8Data" value="-1">   ');
                document.write('<param name="BorderStyle" value="1">   ');
                document.write('<param name="BorderColor" value="14402205">   ');
                document.write('<param name="TitlebarColor" value="15658734">   ');
                document.write('<param name="ekeytype" value="14">   ');

				document.write('<param name="ProductCaption" value="'+ ProductCaption +'"> ');
				document.write('<param name="ProductKey" value="'+ ProductKey +'">');
				document.write('<param name="NoExpireKey" value="'+NoExpireKey+'">   ');

                document.write('<param name="TitlebarTextColor" value="0">   ');
                document.write('<param name="MenubarColor" value="14402205">   ');
                document.write('<param name="MenuButtonColor" VALUE="16180947">   ');
                document.write('<param name="MenuBarStyle" value="3">   ');
                document.write('<param name="MenuButtonStyle" value="7">   ');
                document.write('<param name="WebUserName" value="'+userName+'">   ');
                document.write('<param name="Caption" value="OFFICE文档">   ');
                document.write('<SPAN STYLE="color:red">不能装载文档控件。请在检查浏览器的选项中检查浏览器的安全设置，关闭IE保护模式，将本站点添加到信任站点。</SPAN>   ');
                document.write('</object>');
            }
            if(window.navigator.platform=="Win64"){

                document.write('<!-- 用来产生编辑状态的ActiveX控件的JS脚本-->   ');
                document.write('<!-- 因为微软的ActiveX新机制，需要一个外部引入的js-->   ');
                document.write('<object id="TANGER_OCX" classid="clsid:'+classidx64+'"');
                document.write('codebase="'+codebase64+'" width="100%" height="100%">   ');
				document.write('<param name="MakerCaption" value="'+MakerCaption+'">   ');
				document.write('<param name="MakerKey" value="'+MakerKey+'">   ');
                document.write('<param name="IsUseUTF8URL" value="-1">   ');
                document.write('<param name="IsUseUTF8Data" value="-1">   ');
                document.write('<param name="BorderStyle" value="1">   ');
                document.write('<param name="BorderColor" value="14402205">   ');
                document.write('<param name="TitlebarColor" value="15658734">   ');
				document.write('<param name="ekeytype" value="14">   ');

				document.write('<param name="ProductCaption" value="'+ ProductCaption +'"> ');
				document.write('<param name="ProductKey" value="'+ ProductKey +'">');
				document.write('<param name="NoExpireKey" value="'+NoExpireKey+'">   ');

                document.write('<param name="TitlebarTextColor" value="0">   ');
                document.write('<param name="MenubarColor" value="14402205">   ');
                document.write('<param name="MenuButtonColor" VALUE="16180947">   ');
                document.write('<param name="MenuBarStyle" value="3">   ');
                document.write('<param name="MenuButtonStyle" value="7">   ');
                document.write('<param name="WebUserName" value="NTKO">   ');
                document.write('<param name="Caption" value="OFFICE文档">   ');
                document.write('<SPAN STYLE="color:red">不能装载文档控件。请在检查浏览器的选项中检查浏览器的安全设置，关闭IE保护模式，将本站点添加到信任站点。</SPAN>   ');
                document.write('</object>');

            }

        }
        else if (browser=="firefox"){
            document.write('<object id="TANGER_OCX" type="application/ntko-plug"  codebase="'+codebase+'" width="100%" height="100%" ForOnSaveToURL="OnComplete2" ForOnBeginOpenFromURL="OnComplete" ForOndocumentopened="OnComplete3"');

            document.write('ForOnpublishAshtmltourl="publishashtml"');
            document.write('ForOnpublishAspdftourl="publishaspdf"');
            document.write('ForOnSaveAsOtherFormatToUrl="saveasotherurl"');
            document.write('ForOnDoWebGet="dowebget"');
            document.write('ForOnDoWebExecute="webExecute"');
            document.write('ForOnDoWebExecute2="webExecute2"');
            document.write('ForOnFileCommand="FileCommand"');
            document.write('ForOnCustomMenuCmd2="CustomMenuCmd"');
            document.write('_IsUseUTF8URL="-1"   ');



			document.write('_ProductCaption="'+ ProductCaption +'" ');
			document.write('_ProductKey="'+ ProductKey +'"');



            document.write('_IsUseUTF8Data="-1"   ');
            document.write('_BorderStyle="1"   ');
            document.write('_BorderColor="14402205"   ');
            document.write('_MenubarColor="14402205"   ');
            document.write('_MenuButtonColor="16180947"   ');
            document.write('_MenuBarStyle="3"  ');
            document.write('_MenuButtonStyle="7"   ');
            document.write('_WebUserName="'+userName+'"   ');
            document.write('clsid="{'+classid+'}" >');
            document.write('<div class="no-control-msg"><img src="/img/document/word_aip/icon_err_msg_03.png" ><SPAN>请使用IE浏览器进行在线查阅编辑</SPAN></div>   ');
            document.write('</object>   ');

            // document.write('<object id="TANGER_OCX" type="application/ntko-plug"  codebase="'+codebase+'" width="100%" height="100%" ForOnSaveToURL="OnComplete2" ForOnBeginOpenFromURL="OnComplete" ForOndocumentopened="OnComplete3"');
            // document.write('ForOnDocumentClosed="onClosed"');
            // document.write('ForOnDocActivated="onActivated"');
            // document.write('ForOnpublishAshtmltourl="publishashtml"');
            // document.write('ForOnBeforeDoSecSignFromEkey="OnComplete4"');
            // document.write('ForOnpublishAspdftourl="publishaspdf"');
            // document.write('ForOnSaveAsOtherFormatToUrl="saveasotherurl"');
            // document.write('ForOnAddTemplateFromURL="addtemplatefromurl"');
            // document.write('ForAfterControlCreateFinished="AfterControlCreateFinished"');
            // document.write('ForOnDoWebGet="dowebget" ');
            // document.write('ForOnDoWebExecute="webExecute" ');
            // document.write('ForOnDoWebExecute2="webExecute2" ');
            // document.write('ForOnFileCommand="FileCommand" ');
            // document.write('ForOnCustomMenuCmd2="CustomMenuCmd" ');
            // document.write('ForOnCustomFileMenuCmd="CustomFileMenuCmd" ');
            //
            // document.write('_ProductCaption="中电建水环境治理技术有限公司" ');
            // document.write('_ProductKey="6C9BA65E40CE7074C145AC68868FD47B89290E15"');
            //
            // document.write('_IsUseUTF8URL="-1"   ');
            // document.write('_IsUseUTF8Data="-1"   ');
            // document.write('_BorderStyle="1"   ');
            // document.write('_BorderColor="14402205"   ');
            // document.write('_MenubarColor="14402205"   ');
            // document.write('_MenuButtonColor="16180947"   ');
            // document.write('_MenuBarStyle="3"  ');
            // document.write('_MenuButtonStyle="7"   ');
            // document.write('_WebUserName="NTKO"   ');
            // document.write('clsid="{'+classid+'}" >');
            // document.write('<SPAN STYLE="color:red">尚未安装NTKO Web FireFox跨浏览器插件。请点击<a href="ntkopluginsetup20170912.exe">安装组1件</a></SPAN>   ');
            // document.write('</object>   ');


        }else if(browser=="chrome"){
            document.write('<object id="TANGER_OCX" clsid="{'+classid+'}"  ForOnSaveToURL="OnComplete2" ForOnBeginOpenFromURL="OnComplete" ForOndocumentopened="OnComplete3"');
            document.write('ForOnpublishAshtmltourl="publishashtml"');
            document.write('ForOnpublishAspdftourl="publishaspdf"');
            document.write('ForOnSaveAsOtherFormatToUrl="saveasotherurl"');
            document.write('ForOnDoWebGet="dowebget"');
            document.write('ForOnDoWebExecute="webExecute"');
            document.write('ForOnDoWebExecute2="webExecute2"');
            document.write('ForOnFileCommand="FileCommand"');


			document.write('_ProductCaption="'+ ProductCaption +'" ');
			document.write('_ProductKey="'+ ProductKey +'"');


            document.write('ForOnCustomMenuCmd2="CustomMenuCmd"');
            document.write('codebase="'+codebase+'" width="100%" height="100%" type="application/ntko-plug" ');
            document.write('_IsUseUTF8URL="-1"   ');
            document.write('_IsUseUTF8Data="-1"   ');
            document.write('_BorderStyle="1"   ');
            document.write('_BorderColor="14402205"   ');
            document.write('_MenubarColor="14402205"   ');
            document.write('_MenuButtonColor="16180947"   ');
            document.write('_MenuBarStyle="3"  ');
            document.write('_MenuButtonStyle="7"   ');
            document.write('_WebUserName="'+userName+'"   ');
            document.write('_Caption="OFFICE文档">    ');
            document.write('<div class="no-control-msg"><img src="/img/document/word_aip/icon_err_msg_03.png" ><SPAN>office文档在线阅读、编辑功能需要安装浏览器插件，请<a href="../lib/officecontrol/OfficeOnlineTools.msi">下载安装插件</a>，安装后刷新本页面</SPAN></div>   ');
            document.write('</object>');
        }else if (Sys.opera){
            alert("sorry,ntko web印章暂时不支持opera!");
        }else if (Sys.safari){
            alert("sorry,ntko web印章暂时不支持safari!");
        }
	}
