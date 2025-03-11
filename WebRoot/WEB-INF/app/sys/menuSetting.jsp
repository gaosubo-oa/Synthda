<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <%--<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">--%>
    <%--<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=0.5, minimum-scale=0.3, maximum-scale=1.0, user-scalable=no"/>--%>
    <meta http-equiv="Content-Type" content="text/html;">
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title><fmt:message code="main.meunset"/></title>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" type="text/css" href="../css/sys/menuSetting.css"/>
    <script src="/js/common/language.js"></script>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/common/language.js"></script>
    <script src="../js/sys/menuSetting.js?20230426.2" type="text/javascript" charset="utf-8"></script>
    <script src="../js/jquery/jquery.ocupload-1.1.2.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <style>
        body{
            overflow-y:hidden !important;
        }

        .trTextP p {
            margin-bottom: 15px;
        }

        .colo {
            font-size: 13px;
            background: #3791DA;
            color: white;
        }

        .tabfont {
            font-size: 13px;
        }

        .oldtable {
            font-size: 13px;
            background-color: #F6F7F9;
        }

        .eventable {
            font-size: 13px;
            background-color: #FFFFFF;
        }
        #errtable td{
            padding: 5px;
            background-color: #fff;
            font-size: 11pt;
            color: #2F5C8F;
            font-weight: bold;
        }
        .divBtn{
            width: 70px;
            height: 28px;
            background: url("/img/confirm.png") no-repeat;
            line-height: 28px;
            cursor: pointer;
            margin: 10px auto;
        }
        .tabTwo1 td{
            padding: 5px;
            background-color: #fff;
            font-size: 11pt;
            color: #2F5C8F;
            font-weight: bold;
        }
        .content .left{
            overflow-y: auto;
        }
        .content .right{
            overflow-y: auto;
        }
        iframe{
            overflow:none;
        }

    </style>
    <script>
        function showMenus(element){
            $.ajax({
                type:'get',
                url:'../showNewWithEmpty',
                dataType:'json',
                success:function(rsp){
                    var data=rsp.obj;
                    var str='';
                    for(var i=0;i<data.length;i++){
                        str+='<tr childId="'+data[i].id+'"><td width="50%"><span style="margin-left: 12px;"><img class="one_logo" src="../img/main_img/theme6/'+data[i].img+'.png"></span><span class="margspan">'+data[i].id+'</span><span>'+data[i].name+'</span></td><td width="49.5%"><a href="javascript:;" class="editOne"><fmt:message code="global.lang.edit"/></a><a href="javascript:;" class="nextRank"  dataType="'+function(){
                            var type=$.cookie('language');
                            if(type=='en_US'){
                                return data[i].name1
                            }else if(type == 'zh_CN'){
                                return data[i].name
                            }else {
                                return data[i].name2
                            }
                        }()+'"><fmt:message code="global.lang.next"/></a><a href="javascript:;" class="deleteMenu"><fmt:message code="global.lang.delete"/></a></td></tr>'
                    }
                    element.append(str);
                }
            })
        }
    </script>
</head>
<body scroll="no">
<div class="content">
    <div class="left">
        <div class="header">
            <div class="div_Img">
                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_menuSettings.png" style="vertical-align: middle;"
                     alt="<fmt:message code="journal.th.MenuMain" />">
            </div>
            <div class="divP" style="font-size: 15px" ><fmt:message code="journal.th.MenuMain"/></div>
        </div>
        <div class="collect">
            <div id="incum" class="divUP">
                <span class="spanUP liUp on" id="Addspan"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_addMainMenuCate.png"  style="vertical-align: middle;width: 19px;margin-right: 10px;"  alt="<fmt:message code="menuSetting.th.AddMenu" />"><fmt:message code="menuSetting.th.AddMenu"/></span>
                <div id="ulList">
                    <table cellspacing="0" cellpadding="0" class="tab"  style="border-collapse:collapse;background-color: #fff">

                    </table>
                </div>
                <div class="hidden">
                    <span class="spanUP liUp" id="cuowu"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_errorSubmenuList.png"
                                                              style="vertical-align: middle;width: 15px;margin-right: 10px;"
                                                              alt="<fmt:message code="menuSetting.th.ErrorList" />"><fmt:message
                            code="menuSetting.th.ErrorList"/></span>
                </div>
          <%--      <div>
                    <span class="spanUP liUp" id="beifen"><img src="../img/sys/icon_menuBackuo.png"
                                                               style="vertical-align: middle;width: 19px;margin-right: 10px;"
                                                               alt="菜单备份/恢复"><fmt:message
                            code="menuSetting.th.MenuBackup-restore"/></span>
                </div>--%>
                <div class="hidden">
                    <span class="spanUP liUp" id="shezhi"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_menuSet.png"
                                                               style="vertical-align: middle;width: 19px;margin-right: 10px;"
                                                               alt="<fmt:message code="menuSSetting.th.menuset" />"><fmt:message code="main.meunset"/></span>
                </div>
            </div>
        </div>
    </div>
    <div class="right" style="display: block;width: 74%;float:left;min-height: 500px;">
        <div class="addClass" style="display: block;">
            <div class="header">
                <span class="divP" style="margin-left: 30px"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_addMainMenuCate.png" style="vertical-align: middle;margin-bottom: 3px;margin-right: 12px;" alt="<fmt:message code="menuSetting.th.AddMenu" />"><fmt:message code="menuSetting.th.AddMenu"/></span>
            </div>
            <div class="tab">
                <table cellspacing="0" cellpadding="0" class="tab"
                       style="border-collapse:collapse;background-color: #fff;width: 55%;">
                    <tr>
                        <td><fmt:message code="menuSetting.th.MainMenuClassification"/>：</td>
                        <td>
                            <input type="text" style="width: 80px;" name="id" class="inputTd" value=""/>
                            <span><fmt:message code="menuSetting.th.jiange2"/></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="menuSetting.th.MenuChinese"/></td>
                        <td>
                            <input type="text" name="name" class="inputTd" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="menuSetting.th.MenuEnglish"/></td>
                        <td>
                            <input type="text" name="name1" class="inputTd" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="menuSetting.th.Menufanti"/></td>
                        <td>
                            <input type="text" name="name2" class="inputTd" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="menuSetting.th.ExtensionOne"/></td>
                        <td>
                            <input type="text" name="name3" class="inputTd" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="menuSetting.th.extensionTwo"/></td>
                        <td>
                            <input type="text" name="name4" class="inputTd" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="menuSetting.th.extensionThree"/></td>
                        <td>
                            <input type="text" name="name5" class="inputTd" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="menuSetting.th.PictureName"/>：</td>
                        <td>
                            <input type="text" name="img" class="inputTd" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="div_btn">
                                <input type="button" class="inpuBtn backOkBtn" id="addBtn" value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="global.lang.ok" />"/>
                                <%--<input type="button" class="inpuBtn backCanBtn" id="backBtn" value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="notice.th.return" />"/>--%>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <%--增加菜单主分类--%>
        <div class="editClass" style="display:none;">
            <div class="header">
                <span class="divP" style="margin-left: 30px">
                    <img src="../img/sys/icon_addMainMenuCate.png" style="vertical-align: middle;margin-bottom: 3px;margin-right: 12px;" alt="<fmt:message code="menuSetting.th.EditMenu"/>" />

                </span>
            </div>
           <div class="tab">
                <table cellspacing="0" cellpadding="0" class="tab"
                       style="border-collapse:collapse;background-color: #fff;width: 60%">
                    <tr>
                        <td><fmt:message code="menuSetting.th.MainMenuClassification"/>：</td>
                        <td>
                            <input type="text" name="mainId" class="inputTd" value="01" />
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="menuSetting.th.MenuChinese"/>：</td>
                        <td>
                            <input type="text" name="mainName" class="inputTd"
                                   value="<fmt:message code="main.affairs" />"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="menuSetting.th.MenuEnglish"/></td>
                        <td>
                            <input type="text" name="mainName1" class="inputTd" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="menuSetting.th.Menufanti"/></td>
                        <td>
                            <input type="text" name="mainName2" class="inputTd" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="menuSetting.th.ExtensionOne"/></td>
                        <td>
                            <input type="text" name="mainName3" class="inputTd" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="menuSetting.th.extensionTwo"/></td>
                        <td>
                            <input type="text" name="mainName4" class="inputTd" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="menuSetting.th.extensionThree"/></td>
                        <td>
                            <input type="text" name="mainName5" class="inputTd" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="menuSetting.th.PictureName"/>：</td>
                        <td>
                            <input type="text" name="mainImg" class="inputTd" value="mytable"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="div_btn">
                                <input type="button" class="inpuBtn backOkBtn" id="btn1"
                                       value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="global.lang.ok" />"/>
                                <input type="button" class="inpuBtn backCanBtn" id="btn2"
                                       value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="notice.th.return" />"/>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>

        </div>
        <div class="monoidalSet" style="display:none;">
            <div class="header">
                <span class="divP" style="margin-left: 30px"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_addMainMenuCate.png" style="vertical-align: middle;margin-bottom: 3px;margin-right: 12px;" alt="<fmt:message code="menuSetting.th.subMenu" />"> <fmt:message code="menuSetting.th.Submenu"/></span>
            </div>
            <div class="tab">
                <table cellspacing="0" cellpadding="0" class="tab"
                       style="border-collapse:collapse;background-color: #fff;width: 50%">
                    <tr>
                        <td colspan="2" class="menuTitle"><fmt:message code="main.affairs"/>：</td>
                    </tr>
                    <tr class="childMenu">
                        <td colspan="2" class="blue_text">
                            <div class="childBtn">
                                <%--<input type="button" name="childBtn" id="childBtn" value="<fmt:message code="menuSSetting.th.AddSubmenu" />" />--%>
                                <div id="childBtn"><span style="margin-left: 27px;"><fmt:message code="menuSSetting.th.AddSubmenu"/></span></div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="blue_text">
                            <div class="childrenBtn">
                                <input type="button" class="backOkBtn" name="childrenBtn" id="childrenBtn"
                                       value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="notice.th.return" />"/>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <%--子菜单项设置--%>
        <%--<div class="superPassword" style="display: none">
            <div class="header">
                <span class="divP"> 输入超级密码</span>
            </div>
            <div class="tab">
                <table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width:60%;">
                    <tr>
                        <td colspan="2">说明：第一次进入时密码为空，可在“系统管理-组织机构设置-角色与权限管理”中找到“超级密码设置”</td>
                    </tr>
                    <tr>
                        <td width="35%">请输入超级密码：</td>
                        <td width="63%">
                            <input type="text" name="userId" value="">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="blue_text">
                            <div class="passBtn">
                                <input type="button" name="passBtn" id="passwSure" value="<fmt:message code="global.lang.ok" />" />
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>--%><%--超级密码结束--%>
        <div class="AddChild" style="display:none;">
            <div class="header">
                <span class="divP" style="margin-left: 30px"><img src="../img/sys/icon_addMainMenuCate.png" style="vertical-align: middle;margin-bottom: 3px;margin-right: 12px;" alt="<fmt:message code="menuSetting.th.AddMenu" />"> <fmt:message code="menuSetting.th.addmu" /></span>
            </div>
            <div class="tab">
                <table cellspacing="0" cellpadding="0" class="tab"
                       style="border-collapse:collapse;background-color: #fff;width:75%;">
                    <tr>
                        <td width="25%"><fmt:message code="menuSetting.th.ID" />：</td>
                        <td width="70%">
                            <input type="text" name="addfId" value="">

                            <p style="font-size: 12px;"><fmt:message code="menuSetting.th.description1" /></p>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%"><fmt:message code="menuSetting.th.menud" />：</td>
                        <td width="70%">
                            <select name="addParentId" id="menuTree" style="width: 204px;">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%"><fmt:message code="menuSetting.th.itemCode" />：</td>
                        <td width="70%">
                            <input type="text" name="addId" value=""  onblur="checkAddId()">
                            <span id="checkAddIdspan"></span>
                            <p style="font-size: 12px;"><fmt:message code="workflow.th.description2" /></p>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%"><fmt:message code="workflow.th.descdrg" /></td>
                        <td width="70%">
                            <input type="text" name="addName" value="">
                        </td>
                    </tr>
                    <tr>
                        <td width="25%"><fmt:message code="workflow.th.module" />：</td>
                        <td width="70%">
                            <input type="text" name="addUrl" value="">
                            <input type="checkbox" name="check" id="newChecked" value="0">
                            <span style="font-size: 12px;"><fmt:message code="workflow.th.mode" /></span>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%">传递加密后的用户信息：</td>
                        <td width="70%">
                            <select name="addSendUser" id="addSendUser">
                                <option value="0">关闭</option>
                                <option value="1">开启</option>
                            </select>
                            <%--<span style="font-size: 12px;">如果选择开启,子菜单模块路径必须包含http</span>--%>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%">密钥：</td>
                        <td width="70%">
                            <input type="text" name="addSendKey" value="">
                            <%--<span style="font-size: 12px;">开启后生效</span>--%>
                        </td>
                    </tr>
                    <tr id="showAppMenu">
                        <td width="25%">是否在app中显示本菜单：</td>
                        <td width="70%">
                            <input type="radio" name="addisShowFunc" value="0" checked>
                            <span style="font-size: 12px;">是</span>
                            <input type="radio" name="addisShowFunc" value="1" >
                            <span style="font-size: 12px;">否</span>
                        </td>
                    </tr>
                    <tr class="trTextP">
                        <td colspan="2">
                            <p style="font-size: 12px;font-weight: bold;"><fmt:message code="workflow.th.definition" />:</p>

                            <p><span style="font-size: 12px;font-weight: bold;"><fmt:message code="workflow.th.defi" />：</span><span
                                    style="font-size: 12px;"><fmt:message code="workflow.th.dscrib" />。</span>
                            </p>

                            <p><span style="font-size: 12px;font-weight: bold;"><fmt:message code="workflow.th.numu" />：</span><span
                                    style="font-size: 12px;"><fmt:message code="workflow.th.hyui" /></span>

                            </p>
<%--
                            <p><span style="font-size: 12px;font-weight: bold;">情况三，此菜单外部的B/S结构的系统：</span><span
                                    style="font-size: 12px;">则填写该系统网址，格式如：http://TD_MYOA_WEB_SITE，注意：请一定要以http://开头</span>
                            </p>

                            <p><span style="font-size: 12px;font-weight: bold;">类型四，此菜单挂接外部的C/S结构或单机版系统：</span><span
                                    style="font-size: 12px;">则填写可执行文件路径，格式如：file://c:/abc.exe，注意：请一定要以file://开头，后面的程序路径用斜杠或反斜杠均可,对应的图片是：OA安装目录/webroot/static/images/menu/abc.gif </span>
                            </p>--%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="div_btn">
                                <input type="button" class="inpuBtn backOkBtn" id="btn_sure"
                                       value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="global.lang.ok" />"/>
                                <input type="button" class="inpuBtn backCanBtn" id="btn_back"
                                       value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="notice.th.return" />"/>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <%--新建子菜单结束--%>
        <div class="editChild" style="display:none;">
            <div class="header">
                <span class="divP" style="margin-left: 30px"><img src="../img/sys/icon_addMainMenuCate.png" style="vertical-align: middle;margin-bottom: 3px;margin-right: 12px;" alt="<fmt:message code="menuSetting.th.AddMenu" />"> <fmt:message code="sys.th.dolf" /></span>
            </div>
            <div class="tab">
                <table cellspacing="0" cellpadding="0" class="tab"
                       style="border-collapse:collapse;background-color: #fff;width:65%;">
                    <tr>
                        <td width="25%"><fmt:message code="menuSetting.th.ID" />：</td>
                        <td width="70%">
                            <input type="text" name="editfId" value="">
                        </td>
                    </tr>
                    <tr>
                        <td width="25%"><fmt:message code="menuSetting.th.menud" />：</td>
                        <td width="70%">
                            <select name="editParentId" id="menuTrees">

                            </select>
                            <span style="font-size: 12px;"><fmt:message code="user.th.PlayRole" /></span>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%"><fmt:message code="menuSetting.th.itemCode" />：</td>
                        <td width="70%">
                            <input type="text" name="editId" value="">

                            <p style="font-size: 12px;"><fmt:message code="depatement.th.description3" /></p>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%"><fmt:message code="workflow.th.descdrg" /></td>
                        <td width="70%">
                            <input type="text" name="editName" value="">
                        </td>
                    </tr>
                    <tr>
                        <td width="25%"><fmt:message code="workflow.th.module" />：</td>
                        <td width="70%">
                            <input type="text" name="editUrl" value="">
                            <input type="checkbox" name="check" id="editChecked" value="0">
                            <span style="font-size: 12px;"><fmt:message code="workflow.th.mode" /></span>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%">传递加密后的用户信息：</td>
                        <td width="70%">
                            <select name="editSendUser" id="editSendUser">
                                <option value="0">关闭</option>
                                <option value="1">开启</option>
                            </select>
                            <%--<span style="font-size: 12px;">如果选择开启,子菜单模块路径必须包含http</span>--%>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%">密钥：</td>
                        <td width="70%">
                            <input type="text" name="editSendKey" value="">
                            <%--<span style="font-size: 12px;">开启后生效</span>--%>
                        </td>
                    </tr>
                    <tr id="isAppShow">
                        <td width="25%">是否在app中显示本菜单：</td>
                        <td width="70%">
                            <input type="radio" name="isShowFunc" value="0" checked>
                            <span style="font-size: 12px;">是</span>
                            <input type="radio" name="isShowFunc" value="1" >
                            <span style="font-size: 12px;">否</span>
                        </td>
                    </tr>
                    <tr class="trTextP">
                        <td colspan="2">
                            <p style="font-size: 12px;font-weight: bold;"><fmt:message code="workflow.th.definition" />:</p>

                            <p><span style="font-size: 12px;font-weight: bold;"><fmt:message code="workflow.th.defi" />：</span><span
                                    style="font-size: 12px;"><fmt:message code="workflow.th.dscrib" />。</span>
                            </p>

                            <p><span style="font-size: 12px;font-weight: bold;"><fmt:message code="workflow.th.numu" />：</span><span
                                    style="font-size: 12px;"><fmt:message code="depatement.th.description4" /></span>

                            </p>
                            <%--
                                                        <p><span style="font-size: 12px;font-weight: bold;">情况三，此菜单外部的B/S结构的系统：</span><span
                                                                style="font-size: 12px;">则填写该系统网址，格式如：http://TD_MYOA_WEB_SITE，注意：请一定要以http://开头</span>
                                                        </p>

                                                        <p><span style="font-size: 12px;font-weight: bold;">类型四，此菜单挂接外部的C/S结构或单机版系统：</span><span
                                                                style="font-size: 12px;">则填写可执行文件路径，格式如：file://c:/abc.exe，注意：请一定要以file://开头，后面的程序路径用斜杠或反斜杠均可,对应的图片是：OA安装目录/webroot/static/images/menu/abc.gif </span>
                                                        </p>--%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="div_btn">
                                <input type="button" class="inpuBtn backOkBtn" id="edBtn_sure"
                                       value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="global.lang.ok" />"/>
                                <input type="button" class="inpuBtn backCanBtn" id="edBtn_back"
                                       value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="notice.th.return" />"/>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <%--编辑子菜单项结束--%>
        <div class="addJurisd" style="display: none">
            <input type="hidden" name="addJurisd" value="">

            <div class="tab">
                <table cellspacing="0" cellpadding="0" class="tab"
                       style="border-collapse:collapse;background-color: #fff;width:80%;">
                    <tr>
                        <th colspan="2" class="oneTd"><fmt:message code="depatement.th.permissions" /></th>
                    </tr>
                    <tr>
                        <td><fmt:message code="depatement.th.perm" />：</td>
                        <td id="PRIV"></td>
                    </tr>
                    <tr>
                        <td><fmt:message code="depatement.th.addmunu" />：</td>
                        <td>
                            <div class="inPole">
                                <textarea name="txt" id="privDuser" user_id='id' value="admin" disabled
                                          style="min-width: 300px;min-height:50px;"></textarea>
                                <span class="add_img" style="margin-left: 10px">
                                    <a href="javascript:;" id="selectPriv" class="Add "><fmt:message code="global.lang.add" /></a>
                                </span>
                                <span class="add_img">
                                    <a href="javascript:;" class="clearPriv"><fmt:message code="notice.th.delete1" /></a>
                                </span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><fmt:message code="notice.th.renyuan" />：</td>
                        <td id="USER"></td>
                    </tr>
                    <tr>
                        <td><fmt:message code="notice.th.addrenyuan" />：</td>
                        <td>
                            <div class="inPole">
                                <textarea name="txt" id="senduser" user_id='id' value="admin" disabled
                                          style="min-width: 300px;min-height:50px;"></textarea>
                                <span class="add_img" style="margin-left: 10px">
                                    <a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add" /></a>
                                </span>
                                <span class="add_img">
                                    <a href="javascript:;" class="clearUser"><fmt:message code="notice.th.delete1" /></a>
                                </span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="div_btn">
                                <input type="button" class="inpuBtn backOkBtn" id="addBtn_sure"
                                       value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="global.lang.ok" />"/>
                                <input type="button" class="inpuBtn backCanBtn" id="addBtn_back"
                                       value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="notice.th.return" />"/>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <%--添加权限结束--%>
        <div class="deleteJurisd" style="display: none">
            <input type="hidden" name="deleteJurisd" value="">

            <div class="tab">
                <table cellspacing="0" cellpadding="0" class="tab"
                       style="border-collapse:collapse;background-color: #fff;width:80%;">
                    <tr>
                        <th colspan="2" class="oneTd"><fmt:message code="notice.th.deleMu" /></th>
                    </tr>
                    <tr>
                        <td><fmt:message code="depatement.th.perm" />：</td>
                        <td id="deletePRIV"></td>
                    </tr>
                    <tr>
                        <td>
                            <fmt:message code="depatement.th.deleJs" />：
                        </td>
                        <td>
                            <div class="inPole">
                                <textarea name="txt" id="deletePrivDuser" user_id='id' value="admin" disabled
                                          style="min-width: 300px;min-height:50px;"></textarea>
                                <span class="add_img" style="margin-left: 10px">
                                    <a href="javascript:;" id="deleteSelectPriv" class="Add "><fmt:message code="global.lang.add" /></a>
                                </span>
                                <span class="add_img">
                                    <a href="javascript:;" class="deClearPriv"><fmt:message code="notice.th.delete1" /></a>
                                </span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><fmt:message code="notice.th.renyuan" />：</td>
                        <td id="deleteUSER"></td>
                    </tr>
                    <tr>
                        <td><fmt:message code="notice.th.personnel" />：</td>
                        <td>
                            <div class="inPole">
                                <textarea name="txt" id="deleteSenduser" user_id='id' value="admin" disabled
                                          style="min-width: 300px;min-height:50px;"></textarea>
                                <span class="add_img" style="margin-left: 10px">
                                    <a href="javascript:;" id="deleteSelectUser" class="Add "><fmt:message code="global.lang.add" /></a>
                                </span>
                                <span class="add_img">
                                    <a href="javascript:;" class="deClearUser"><fmt:message code="notice.th.delete1" /></a>
                                </span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="div_btn">
                                <input type="button" class="inpuBtn backOkBtn" id="deleteBtn_sure"
                                       value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="global.lang.ok" />"/>
                                <input type="button" class="inpuBtn backCanBtn" id="deleteBtn_back"
                                       value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="notice.th.return" />"/>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <%--删除权限结束--%>
        <%--<div class="hideDome" style="display: none;height:98%;border: none;">
            <iframe src="/email/development" width="100%" height="100%;" style="border: none;"></iframe>
        </div>&lt;%&ndash;正在开发中&ndash;%&gt;--%>


        <div align="center" class="errMenuListClass" style="display:none;">
            <div class="header">
                <span class="divP" style="margin-left: 30px"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_addMainMenuCate.png" style="vertical-align: middle;margin-bottom: 3px;margin-right: 12px;" alt="<fmt:message code="menuSetting.th.AddMenu" />"><fmt:message code="menuSSetting.th.errChildMenu" /></span>
            </div>
            <div class="tabTwo">
                <table cellspacing="0" id="errtable" cellpadding="0" class="tab"
                       style="border-collapse:collapse;background-color: #fff;width: 50%;">

                    <tr class="colo" align="center" style="background: #3791DA" color="white">
                        <td colspan="3">
                            <span style="font-weight: bold;"><fmt:message code="menuSSetting.th.errChildMenuList" /></span>
                        </td>
                    </tr>

                    <tr class="errorMenuList">
                        <td><fmt:message code="menuSSetting.th.errChildMenuId" /></td>
                        <td><fmt:message code="menuSSetting.th.menuName" /></td>
                        <td><fmt:message code="menuSSetting.th.menuSetting" /></td>
                    </tr>
                </table>
            </div>
        </div>
        <%--错误菜单结束--%>
        <%--编辑错误子菜单开始--%>
        <div class="errEditChild" style="display:none;">
            <div class="header">
                <span class="divP" style="margin-left: 30px"><img src="../img/sys/icon_addMainMenuCate.png" style="vertical-align: middle;margin-bottom: 3px;margin-right: 12px;" alt="<fmt:message code="menuSetting.th.AddMenu" />"> <fmt:message code="sys.th.dolf" /></span>
            </div>
            <div class="tab">
                <table cellspacing="0" cellpadding="0" class="tab"
                       style="border-collapse:collapse;background-color: #fff;width:65%;">
                    <tr>
                        <td width="25%"><fmt:message code="menuSetting.th.ID" />：</td>
                        <td width="70%">
                            <input type="text" name="editfId" value="">
                        </td>
                    </tr>
                    <tr>
                        <td width="25%"><fmt:message code="menuSetting.th.menud" />：</td>
                        <td width="70%">
                            <select name="editParentId" id="errMenuTrees">

                            </select>
                            <span style="font-size: 12px;"><fmt:message code="user.th.PlayRole" /></span>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%"><fmt:message code="menuSetting.th.itemCode" />：</td>
                        <td width="70%">
                            <input type="text" name="editId" value="">

                            <p style="font-size: 12px;"><fmt:message code="depatement.th.description3" /></p>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%"><fmt:message code="workflow.th.descdrg" /></td>
                        <td width="70%">
                            <input type="text" name="editName" value="">
                        </td>
                    </tr>
                    <tr>
                        <td width="25%"><fmt:message code="workflow.th.module" />：</td>
                        <td width="70%">
                            <input type="text" name="editUrl" value="">
                            <input type="checkbox" name="check" id="errorChecked" value="0">
                            <span style="font-size: 12px;"><fmt:message code="workflow.th.mode" /></span>
                        </td>
                    </tr>
                    <tr class="trTextP">
                        <td colspan="2">
                            <p style="font-size: 12px;font-weight: bold;"><fmt:message code="workflow.th.definition" />:</p>

                            <p><span style="font-size: 12px;font-weight: bold;"><fmt:message code="workflow.th.defi" />：</span><span
                                    style="font-size: 12px;"><fmt:message code="workflow.th.dscrib" />。</span>
                            </p>

                            <p><span style="font-size: 12px;font-weight: bold;"><fmt:message code="workflow.th.numu" />：</span><span
                                    style="font-size: 12px;"><fmt:message code="depatement.th.description4" /></span>

                            </p>

                           <%-- <p><span style="font-size: 12px;font-weight: bold;">类型三，此菜单挂接外部的B/S结构的系统：</span><span
                                    style="font-size: 12px;">则填写该系统网址，格式如：http://TD_MYOA_WEB_SITE，注意：请一定要以http://开头</span>
                            </p>

                            <p><span style="font-size: 12px;font-weight: bold;">类型四，此菜单挂接外部的C/S结构或单机版系统：</span><span
                                    style="font-size: 12px;">则填写可执行文件路径，格式如：file://c:/abc.exe，注意：请一定要以file://开头，后面的程序路径用斜杠或反斜杠均可,对应的图片是：OA安装目录/webroot/static/images/menu/abc.gif </span>
                            </p>--%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="div_btn">
                                <input type="button" class="inpuBtn backOkBtn" id="errEdBtn_sure"
                                       value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="global.lang.ok" />"/>
                                <input type="button" class="inpuBtn backCanBtn" id="errEdBtn_back"
                                       value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="notice.th.return" />"/>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <%--编辑错误子菜单项结束--%>

        <div class="baksqlClass" style="display:none;">
            <div class="header">
                <span class="divP" style="margin-left: 30px"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_addMainMenuCate.png" style="vertical-align: middle;margin-bottom: 3px;margin-right: 12px;" alt="<fmt:message code="menuSetting.th.AddMenu" />"><fmt:message code="menuSSetting.th.bakMenuSql"/></span>
            </div>
            <div class="tab">
                <table class="table" cellspacing="0" cellpadding="0"
                       style="border-collapse:collapse;background-color: #fff">

                    <tr class="colo" align="center" style="background: #3791DA" color="white">
                        <td>
                            <fmt:message code="menuSSetting.th.menuBak"/>
                        </td>
                    </tr>
                    <tr class="colo" align="center" style="background: #fff" color="white">
                        <td>
                            <input id="exportSqlId" type="button" align="center"
                                   value="<fmt:message code="menuSSetting.th.exportMenuSql" />">
                        </td>
                    </tr>
                </table>
            </div>
            <%--导出菜单sql结束--%>

            <div class="tab">
                <form action="../ImportMenu" method="post" enctype="multipart/form-data">
                    <table class="table" cellspacing="0" cellpadding="0"
                           style="border-collapse:collapse;background-color: #fff">

                        <tr class="colo" align="center" style="background: #3791DA" color="white">
                            <td colspan="2">
                                <fmt:message code="menuSSetting.th.MenuRecovery"/>
                            </td>
                        </tr>
                        <tr class="colo" align="center" style="background: #fff" color="white">

                            <td colspan="2">
                                <input id="recoverySqlId" type="button" onclick="submitSql()" align="center"
                                       value="<fmt:message code="menuSSetting.th.inportMenuSql" />">

                            </td>
                        </tr>

                    </table>
                </form>
            </div>
            <%--sql导入结束--%>
        </div>
        <%--菜单备份恢复结束--%>

        <div align="center" class="menusetClass" style="display:none;">
            <div class="header">
                <span class="divP" style="margin-left: 30px"><img src="../img/sys/icon_addMainMenuCate.png" style="vertical-align: middle;margin-bottom: 3px;margin-right: 12px;" alt="<fmt:message code="menuSetting.th.AddMenu" />"><fmt:message code="menuSetting.th.subMenu" /></span>
            </div>
            <div class="tabTwo1" align="center">
                <table cellspacing="0" cellpadding="0" class="tab" align="center"
                       style="border-collapse:collapse;background-color: #fff;width: 90%;">
                    <%--<tr class="colo" align="center">--%>
                        <%--<td>--%>
                            <%--<span style="font-weight: bold"><fmt:message code="menuSSetting.th.parm" /></span>--%>
                        <%--</td>--%>
                        <%--<td>--%>
                            <%--<span style="font-weight: bold"><fmt:message code="menuSSetting.th.value" /></span>--%>

                        <%--</td>--%>
                        <%--<td>--%>
                            <%--<span style="font-weight: bold"><fmt:message code="menuSSetting.th.remark" /></span>--%>
                        <%--</td>--%>
                    <%--</tr>--%>

                    <br>

                    <td class="tabfont">
                        <fmt:message code="menuSSetting.th.showMenucount" />
                    </td>
                    <td>
                        <input type="text" id="topMenuNum" name="">&nbsp;&nbsp;
                    </td>
                    <br>
                    <td class="tabfont">
                        <br/>
                        &nbsp;&nbsp;<fmt:message code="menuSSetting.th.menusettiogData1" /></br>
                        &nbsp;&nbsp;<fmt:message code="menuSSetting.th.menusettiogData2" /></br>
                        &nbsp;&nbsp;<fmt:message code="menuSSetting.th.menusettiogData3" /><br/>

                    </td>

                    </tr>
                    <tr>

                        <td class="tabfont">
                            <fmt:message code="menuSSetting.th.geoMenu" />
                        </td>
                        <td class="tabfont">
                            &nbsp;&nbsp;&nbsp;&nbsp; <p><input type="checkbox" id="menuQuickGroup"><fmt:message code="menuSSetting.th.menusettioggeoData1" /> </p>&nbsp;&nbsp;
                            &nbsp;&nbsp; &nbsp;&nbsp;<p><input type="checkbox" id="menuWinexe"/><fmt:message code="menuSSetting.th.menusettioggeoData2" /></p>&nbsp;&nbsp;
                            &nbsp;&nbsp; &nbsp;&nbsp;<p><input type="checkbox" id="menuUrl"/><fmt:message code="menuSSetting.th.menusettioggeoData3" /></p>&nbsp;&nbsp;
                            &nbsp;&nbsp; &nbsp;&nbsp;<p><input type="checkbox" id="menuExpandSingle" style="display: none"/></p>
                            <%--<fmt:message code="menuSSetting.th.menusettioggeoData4" />--%>
                            &nbsp;&nbsp;
                        </td>
                        <td class="tabfont">
                            &nbsp;&nbsp;<fmt:message code="menuSSetting.th.leftMenuisShow" />
                        </td>

                    </tr>
                    <tr>
                        <td colspan="3" align="center">
                            <%--<input onclick="menuset()" type="button" align="center"--%>
                                   <%--value="<fmt:message code="menuSSetting.th.menusetsure" />">--%>
                            <div onclick="menuset()" class="divBtn"><span style="margin-left: 20px;"><fmt:message code="menuSSetting.th.menusetsure" /></span></div>
                        </td>
                    </tr>

                </table>
            </div>
        </div>
        <%--菜单设置结束--%>
    </div>


</div>
</div>
<script type="text/javascript">
    var user_id = 'senduser';
    var priv_id = 'privDuser';
    var user_id = 'deleteSenduser';
    var priv_id = 'deletePrivDuser';
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_USE_APP',
        dataType:'json',
        success:function (res) {
            var data = res.object[0];
            if(data.paraValue != 0) {
                $("#showAppMenu").hide();
                $("#isAppShow").hide();
            }
        }
    })
    //左侧
    var height = $(window).height();
    $('.content .left').height(height - 20);
    //右侧
    var height = $(window).height();
    $('.content .right').height(height - 10);

    $(function () {
        //$('#menuTree').deptSelect();
        selectMenu($('#menuTrees'));
        selectMenu($('#menuTree'));

        //错误子菜单
        selectMenu($('#errMenuTrees'));

        $("#selectUser").on("click", function () {
            user_id = 'senduser';
            $.popWindow("../common/selectUser");
        });
        $("#selectPriv").on("click", function () {
            priv_id = 'privDuser';
            $.popWindow("../common/selectPriv");
        });
        $("#deleteSelectUser").on("click", function () {
            user_id = 'deleteSenduser';
            $.popWindow("../common/selectUser");
        });
        $("#deleteSelectPriv").on("click", function () {
            priv_id = 'deletePrivDuser';
            $.popWindow("../common/selectPriv");
        });
        $('.clearPriv').click(function () {
            $('#privDuser').val('');
            $('#privDuser').attr('privid','');
            $('#privDuser').attr('userpriv','');

        })
        $('.clearUser').click(function () {
            $('#senduser').val('');
            $('#senduser').attr('user_id','');
            $('#senduser').attr('username','');
            $('#senduser').attr('dataid','');
            $('#senduser').attr('userprivname','');

        })
        $('.deClearPriv').click(function () {
            $('#deletePrivDuser').val('');
            $('#deletePrivDuser').attr('privid','');
            $('#deletePrivDuser').attr('userpriv','');
        })
        $('.deClearUser').click(function () {
            $('#deleteSenduser').val('');
            $('#deleteSenduser').attr('user_id','');
            $('#deleteSenduser').attr('username','');
            $('#deleteSenduser').attr('dataid','');
            $('#deleteSenduser').attr('userprivname','');
        })


        //编辑新窗口打开复选框点击事件
        $('#editChecked').click(function(){
            var state =$(this).prop("checked");
            if(state == true){
                $(this).prop("checked",true);
                $(this).val('1');
            }else{
                $(this).prop("checked",false);
                $(this).val('0');
            }
        })

        //错误编辑新窗口打开复选框点击事件
        $('#errorChecked').click(function(){
            var state =$(this).prop("checked");
            if(state == true){
                $(this).prop("checked",true);
                $(this).val('1');
            }else{
                $(this).prop("checked",false);
                $(this).val('0');
            }
        })

        //新建新窗口打开复选框点击事件
        $('#newChecked').click(function(){
            var state =$(this).prop("checked");
            if(state == true){
                $(this).prop("checked",true);
                $(this).val('1');
            }else{
                $(this).prop("checked",false);
                $(this).val('0');
            }
        })

    });
    function selectMenu(element) {
        $.ajax({
            type: 'get',
            url: '../showNewMenu',
            dataType: 'json',
            success: function (rsp) {
                var data = rsp.datas;
                var str = '';
                str = queryMenuT(data, str)
                element.append(str);
            }
        })
    }
    function queryMenuT(data, str) {
        for (var i = 0; i < data.length; i++) {
            if (data[i].id.length==2){
                str += '<option value="' + data[i].id + '">' + data[i].name + '</option>';
            }else{
                str += '<option value="' + data[i].id + '">' +"&nbsp;&nbsp;├"+data[i].name + '</option>';
            }

            if (data[i].child) {
                if (data[i].child.length > 0) {
                    str = queryMenuT(data[i].child, str);
                }
            }

        }
        return str;
    }
    $('#cuowu').on('click', function () {
        findErrorMenu();

    });


    function findErrorMenu() {
        $.ajax({
            type: 'get',
            url: '../getErrMenu?date=' + new Date(),
            dataType: 'json',
            success: function (res) {
                var data1 = res.object;
                var str = '<tr class="colo"> <td><fmt:message code="menuSSetting.th.errChildMenuId" /></td> <td><fmt:message code="menuSSetting.th.menuName" /></td> <td><fmt:message code="menuSSetting.th.menuSetting" /></td> </tr>';
                for (var i = 0; i < data1.length; i++) {

                    //隔行变色
                    if ((i / 2) == 0) {

                        str += '<tr class="eventable" ><td>' + data1[i].fId + '</td><td>' + data1[i].name + '</td><td>' + '<a href="javascript:;" onclick="editErrMenu(' + data1[i].fId + ')"><fmt:message code="menuSSetting.th.editMenu" /></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="javascript:;" onclick="deleteErrMenu(' + data1[i].id + ')"><fmt:message code="menuSSetting.th.deleteMenu" /></a>' + '</td></tr>';
                    } else {
                        str += '<tr class="oldtable"><td>' + data1[i].fId + '</td><td>' + data1[i].name + '</td><td>' + '<a href="javascript:;" onclick="editErrMenu(' + data1[i].fId + ')"><fmt:message code="menuSSetting.th.editMenu" /></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="javascript:;" onclick="deleteErrMenu(' + data1[i].id + ')"><fmt:message code="menuSSetting.th.deleteMenu" /></a>' + '</td></tr>';
                    }
                }

                $('#errtable').html(str);

                $('.errMenuListClass').show().siblings().hide();
            }

        });

    }


    function deleteErrMenu(menuId) {

        $.layerConfirm({content: '<fmt:message code="menuSSetting.th.isdeleteMenu" />', title: '<fmt:message code="menuSSetting.th.suredeleteMenu" />', icon: 0}, function () {
            $.ajax({
                type: 'get',
                url: '../deleteSysMenu',
                dataType: 'json',
                data: {'id': menuId},
                success: function () {
                    findErrorMenu();

                }
            })
            return true;
            // }else{
        }, function () {
            return false;
        });

    }


    function editErrMenu(fid) {
        $.ajax({
            type: 'get',
            url: '../getSysFunctionByFid',
            data: {'fid': fid},
            success: function (data) {
                $('.errEditChild').show().siblings().hide();
                $('.errEditChild input[name="editfId"]').val(data.object.fId);
                $('.errEditChild input[name="editId"]').val(data.object.id.substr(-2));
                $('.errEditChild input[name="editName"]').val(data.object.name);
                $('.errEditChild input[name="editUrl"]').val(data.object.url);

                //子菜单编辑确定按钮
                $('#errEdBtn_sure').click(function () {
                    // var id = $('.refresh').parents('tr').attr('childId');

                    saveErrChildEdit();
                })
                //子菜单编辑返回按钮
                $('#errEdBtn_back').click(function () {
                    findErrorMenu();
                })

            }
        })
    }


    function saveErrChildEdit() {

        var data = {
            'fId': $('.errEditChild input[name="editfId"]').val(),
            'parentId': $('.errEditChild select[name="editParentId"] option:checked').val(),
            'id': $('.errEditChild input[name="editId"]').val(),
            'name': $('.errEditChild input[name="editName"]').val(),
            'url': $('.errEditChild input[name="editUrl"]').val(),
            'isopenNew':$('#errorChecked').val()
        };
        $.ajax({
            type: 'post',
            url: '../editSysFunction',
            dataType: 'json',
            data: data,
            success: function (rsp) {
                if (rsp.flag == true) {
                    $.layerMsg({content: '<fmt:message code="menuSSetting.th.editSuccess" />', icon: 1}, function () {
                        findErrorMenu();
                    });
                } else {
                    $.layerMsg({content: '<fmt:message code="menuSSetting.th.editFail" />', icon: 2}, function () {
                        findErrorMenu();

                    });
                }

            }

        })

    }


    //备份菜单
    $('#beifen').on('click', function () {


        $('.baksqlClass').show().siblings().hide();
        // var id = $(this).parents('tr').attr('childId');


        // $.layerMsg({content:'即将上线此功能 ，敬请期待！',icon:6},function(){});
    })
    $('#shezhi').on('click', function () {

        $('.menusetClass').show().siblings().hide();
        makeParam();


    })


</script>

<script>


    function submitSql() {

        $("#recoverySqlId").upload({
            action: '../ImportMenu',
            name: 'sqlFile',
            dataType: 'json',
            onComplete: function (data, self, element) {
                var jsonData = JSON.parse(data);

                if (jsonData.flag) {
                    $.layerMsg({content: '<fmt:message code="menuSSetting.th.importSuccess" />', icon: 1}, function () {
                        $('.baksqlClass').show().siblings().hide();
                    });
                } else {
                    $.layerMsg({content: '<fmt:message code="menuSSetting.th.importFail" />', icon: 1}, function () {
                        $('.baksqlClass').show().siblings().hide();
                    });
                }
            }
        })


    }


</script>


<script>
    function check(name, spanid, reg, okinfo, errorinfo) {
        //获取用户输入的内容
        var val = document.getElementsByName(name)[0].value;
        //获取sapn节点对象
        var oSpan = document.getElementById(spanid);
        //判断用户输入的值是否为空
        if (val == null || val == "") {
            oSpan.innerHTML = "子菜单项代码不能为空".fontcolor("red");
        } else {
            if (reg.test(val)) {
                oSpan.innerHTML = "";
            } else {
                oSpan.innerHTML = errorinfo.fontcolor("red");
            }
        }
    }
    //验证输入代码
    function checkAddId() {
        var reg = /^\d{2}$/;  //1df
        check("addId", "checkAddIdspan", reg, "", "输入格式有误！");
    }
    $(function () {
        $("#exportSqlId").click(function () {
           /* window.location.href = '../ExportMenu';*/
            $.layerMsg({content:'<fmt:message code="sup.th.UnderDeve" />',icon:6});
        });
    })

    var data;
    function menuset() {
        var topMenuNum = $("#topMenuNum").val();


        var isMenuGroupSel = $("#menuQuickGroup").is(":checked");
        var menuGroup = "";
        if (isMenuGroupSel) {
            menuGroup = "menuQuickGroup";
        }


        var isMenuUrl = $("#menuUrl").is(":checked");
        var menuUrl = "";
        if (isMenuUrl) {
            menuUrl = "menuUrl";
        }
        var isMenuWinexe = $("#menuWinexe").is(":checked");
        var menuWinexe = "";
        if (isMenuWinexe) {
            menuWinexe = "menuWinexe";
        }
        var isMenuExpandSingle = $("#menuExpandSingle").is(":checked");
        var menuExpandSingle = "";
        if (isMenuExpandSingle) {
            menuExpandSingle = "menuExpandSingle";
        }

        data = {
            'topMenuNum': topMenuNum,
            'menuQuickGroup': menuGroup,
            'menuUrl': menuUrl,
            'menuExpandSingle': menuExpandSingle,
            'menuWinexe': menuWinexe
        };


        $.ajax({
            type: 'get',
            url: '../EditMenuPara',
            dataType: 'json',
            data: data,
            success: function (rsp) {


                if (rsp.flag) {
                    $.layerMsg({content: '<fmt:message code="menuSSetting.th.editSuccess" />', icon: 1}, function () {

                    });
                } else {
                    $.layerMsg({content: '<fmt:message code="menuSSetting.th.editFail" />', icon: 1}, function () {

                    });
                }

            }
        })


    }

    $(function () {

        makeParam();


    })

    function makeParam() {

        $.ajax({
            type: 'get',
            url: '../getMenuPara',
            dataType: 'json',
            data: data,
            success: function (rsp) {
                if (rsp.flag) {
                    $("#topMenuNum").val(rsp.object.topMenuNum);
                    if (rsp.object.menuUrl == "menuUrl") {
                        $("#menuUrl").attr("checked", "true");
                    }
                    if (rsp.object.menuQuickGroup == "menuQuickGroup") {
                        $("#menuQuickGroup").attr("checked", "true");
                    }
                    if (rsp.object.menuExpandSingle == "menuExpandSingle") {
                        $("#menuExpandSingle").attr("checked", "true");
                    }
                    if (rsp.object.menuWinexe == "menuWinexe") {
                        $("#menuWinexe").attr("checked", "true");
                    }


                }
            }
        })


    }
</script>

</body>
</html>

