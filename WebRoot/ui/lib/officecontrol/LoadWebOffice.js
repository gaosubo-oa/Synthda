 //�Ƿ�Ϊie ie6~11
isIE = function()
{
  return !!(window.ActiveXObject || "ActiveXObject" in window);
}
 
if ( isIE() ) {
     var s = ""
     s += "<object id=WebOffice height='100%' width='100%' style='LEFT: 0px; TOP: 0px'   codebase='/lib/officecontrol/WebOffice.cab#Version=7,0,3,0' classid='clsid:E77E049B-23FC-4DB8-B756-60529A35FAD5'>"
     s +="<param name='_ExtentX' value='6350'><param name='_ExtentY' value='6350'><param name='wmode' value='transparent'>"
     s +="</object>"
}
else
{
	
	 var s = ""
     s += "<object id=WebOffice height='100%' width='100%' style='LEFT: 0px; TOP: 0px'   TYPE='application/x-itst-activex' event_NotifyCtrlReady='NotifyCtrlReady' progid='' clsid='{E77E049B-23FC-4DB8-B756-60529A35FAD5}' codebase='/lib/officecontrol/WebOffice.cab#Version=7,0,3,0'>"
     s +="<param name='_ExtentX' value='6350'><param name='_ExtentY' value='6350'><param name='wmode' value='transparent'>"
     s +="</object>"
}
		
document.write(s);
