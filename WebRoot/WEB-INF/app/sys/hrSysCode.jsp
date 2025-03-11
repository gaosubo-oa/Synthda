<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><fmt:message code="main.systemcodeset" /></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" type="text/css" href="../css/sys/addUser.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script>

    </script>
    <style type="text/css">
        .bodycolor {
            padding-top: 5px;
        }
        .small {
            font-size: 9pt;
            width: 100%;
            margin-top: 14px;
        }
        .head {
            font-size: 22px;
            margin-top: -1px;
            border-bottom: #999 1px solid;
            line-height: 42px;
            padding-left: 30px;
        }
        .menuList {
            display: block;
            width: 100%;
            font-size: 14px;
            height: 40px;
            line-height: 40px;
            border-bottom: #ddd 1px solid;
            cursor: pointer;
            background-image: url(../../img/sys/icon_rightarrow_03.png);
            background-repeat:no-repeat;
            background-position: 91% center;
        }
        .menuList_hide {
            display: block;
            width: 100%;
            font-size: 14px;
            height: 40px;
            line-height: 40px;
            border-bottom: #ddd 1px solid;
            cursor: pointer;
            border-right: #ddd 1px solid;
            background-image:url(../../img/sys/icon_rightarrow_03.png);
            background-repeat:no-repeat;
            background-position: 91% center;
        }
        .menuList span {
            color:black;
            margin-left: 11px;
        }
        .menuList_hide span{
            color:black;
            margin-left: 11px;
        }
        #bodycolor{
            margin-top: 10px;
            border-bottom: #999 1px solid;
            height:31px;
        }
        .TableBlock {
            border: 1px #dddddd solid;
            line-height: 20px;
            font-size: 9pt;
            border-collapse: collapse;
            width:34%;
        }
        .TableBlock_sub {
            width: 32%;
            margin: 0 auto;
            font-size: 14px;
            margin-top: 10px;
        }
        .TableHeader {
            COLOR: #383838;
            FONT-WEIGHT: bold;
            FONT-SIZE: 9pt;
            background: #fff;
            line-height: 40px;
            border-bottom: 1px #dddddd solid;
        }
        .TableBlock .TableFooter td, .TableBlock .TableControl td, .TableBlock td.TableFooter, .TableBlock td.TableControl {
            background: #FFFFFF;
            border: 1px #dddddd solid;
            padding: 3px;
            height: 30px;
            font-size: 11pt;
        }
        .TableControl {
            background: #FFFFFF;
            border-top: 1px #dddddd solid;
        }
        .TableData {
            BACKGROUND: #FFFFFF;
            COLOR: #000000;
        }
        tr {
            display: table-row;
            vertical-align: inherit;
            border-color: inherit;
        }
        .TableBlock .TableData td, .TableBlock td.TableData {
            background: #FFFFFF;
            border-bottom: 1px #dddddd solid;
            border-top: 1px #dddddd solid;
            border-right: 1px #dddddd solid;
            padding: 3px;
            height: 30px;
        }
        .TableBlock {
            border: 1px #cccccc solid;
            line-height: 20px;
            font-size: 9pt;
            border-collapse: collapse;
        }
        .TableBlock .TableContent td, .TableBlock td.TableContent {
            background: #f2f2f2;
            border-bottom: 1px #cccccc solid;
            border-right: 1px #cccccc solid;
            padding: 3px;
            height: 30px;
        }
        .TableContent {
            /* BACKGROUND: #4897e8; */
        }
        .TableBlock .TableData td, .TableBlock td.TableData {
            background: #FFFFFF;
            border-bottom: 1px #cccccc solid;
            border-right: 1px #cccccc solid;
            padding: 3px;
            height: 30px;
        }
        .TableData {
            BACKGROUND: #FFFFFF;
            COLOR: #000000;
        }
        td, th {
            display: table-cell;
            vertical-align: inherit;
        }
        tr {
            display: table-row;
            vertical-align: inherit;
            border-color: inherit;
        }
        #west {
            width: 23%;
            position: absolute;
            top: 0;
            left: 0;
            bottom: 0;
            overflow: auto;
            overflow-x:hidden;
            border-right: #ccc 1px solid;
            border-left: #ccc 1px solid;
        }
        #center {
            position: absolute;
            top: 0px;
            bottom: 0;
            width:77%;
            right: 0;
            overflow: scroll;
        }
        li a:link span, li a:visited span {
            display: block;
            line-height: 35px;
            padding-left: 16px;
            cursor: pointer;
        }
        tbody {
            display: table-row-group;
            vertical-align: middle;
            border-color: inherit;
        }
        /*定义滚动条宽高及背景，宽高分别对应横竖滚动条的尺寸*/
        .west::-webkit-scrollbar{
            width: 2px;
            height: 2px;
            background-color: #f5f5f5;
        }
        /*定义滚动条的轨道，内阴影及圆角*/
        .west::-webkit-scrollbar-track{
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
            border-radius: 10px;
            background-color: #f5f5f5;
        }
        /*定义滑块，内阴影及圆角*/
        .west::-webkit-scrollbar-thumb{
            /*width: 10px;*/
            height: 20px;
            border-radius: 10px;
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
            background-color: #555;
        }

        .head::-webkit-scrollbar{
            width: 2px;
            height: 2px;
            background-color: #f5f5f5;
        }
        /*定义滚动条的轨道，内阴影及圆角*/
        .head::-webkit-scrollbar-track{
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
            border-radius: 10px;
            background-color: #f5f5f5;
        }
        /*定义滑块，内阴影及圆角*/
        .head::-webkit-scrollbar-thumb{
            /*width: 10px;*/
            height: 20px;
            border-radius: 10px;
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
            background-color: #555;
        }
        .head_line::-webkit-scrollbar{
            width: 2px;
            height: 2px;
            background-color: #f5f5f5;
        }
        /*定义滚动条的轨道，内阴影及圆角*/
        .head_line::-webkit-scrollbar-track{
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
            border-radius: 10px;
            background-color: #f5f5f5;
        }
        /*定义滑块，内阴影及圆角*/
        .head_line::-webkit-scrollbar-thumb{
            /*width: 10px;*/
            height: 20px;
            border-radius: 10px;
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
            background-color: #555;
        }

        .west table{
            width: 100%;
            margin: 0 auto;
            font-size: 12px;
            border-right: 0px  !important;
        }
        .Big {
            border-bottom: 1px solid #c0c0c0;
        }
        .big3{
            font-size: 22px;
            padding-left: 62px;
        }
        a {cursor: pointer;}
        input {
            border: 1px solid #ccc;
            width: 51px;
            cursor: pointer;
        }
        .TableBlock_sub {
            width: 65%;
            margin: 0 auto;
            font-size: 14px;
            margin-top: 10px;
        }
       #module_1{
           padding:2px;
       }
        .backgroundcolor {background-color: rgb(173, 210, 248);}
        .backimg {background-image:url(../../img/confirm.png); width:70px;height: 28px;}
        .reimg {background-image:url(../../img/sys/return.png); width:70px;height: 28px;}
        .TableBlock .TableData .tabletd{
            padding-left: 15px !important;
        }
        .addcodebut {
            background-image:url(../../img/addcodebut1.png); width:102px;height: 28px;
        }
        .BigButton {font-size: 14px;}
        .TableHeader b {
            color: #2a588c;
        }
        .ziti{
            color:#1772c0;
            margin-left: 10px;
        }
        .scziti{
            color:#e01919;
        }
        .errorCodeLists th{
            padding: 5px;
            background-color: #fff;
            font-size: 11pt;
            color: #2F5C8F;
            font-weight: bold;
        }
        td{
            font-size: 11pt;
        }
    </style>
</head>
<body marginwidth="0" marginheight="0" class="bodycolor">
<div id="west" class="west">
    <div class="head"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/mainfenlei.png" style="margin-right: 12px;"><fmt:message code="sysCode.th.CodeCategory" /></div>
    <ul class="head_line">
        <li class="menuList backgroundcolor" id="menuList">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/addcodemain.png" style="margin-left: 35px;">
            <a onclick="showMain();" target="code_edit" title="<fmt:message code="sysCode.th.AddCode" />" id="link_1"><span><fmt:message code="sysCode.th.AddCode" /></span></a>
        </li>
        <div id="module_1" class="moduleContainer" style="">
            <table class="TableBlock" width="100%" id="TableBlock">
            </table>
        </div>
        <li class="hidden menuList_hide" id="codeerror">
            <img src="../../img/errorcode.png" style="margin-left: 35px;">
            <a  onclick="showbg1();" target="code_edit" title="<fmt:message code="sysCode.th.ErrorCode" />" id="link_3"><span><fmt:message code="sysCode.th.ErrorCode" /></span></a>
        </li>
      <%--  <li class="hidden menuList_hide" id="codecopy">
            <img src="../../img/codecopy.png" style="margin-left: 13px;">
            <a  onclick="showbg2()" target="code_edit" title="代码备份/恢复" id="link_2"><span><fmt:message code="sysCode.th.CodeBackup-restore" /></span></a>
        </li>--%>
    </ul>
</div>
<div id="center">
    <!--<iframe src="new.php" id="code_edit" name="code_edit" frameborder="0"></iframe>-->
    <div  id="bodycolor" style="display:block;">
        <div class="small">
            <img src="../../img/addcodemain.png" style="position: absolute;left: 30px;"><span class="big3"> <fmt:message code="sysCode.th.AddCode" /></span>
        </div>
        <br>
        <table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 55%;" id="TableBlock_center" style="display:block">
            <tbody>
            <tr>
                <%--代码编号--%>
                <td nowrap="" class="TableData" width="120"><fmt:message code="sysCode.th.CodeNumber" /><span style="color:red">*</span>：</td>
                <td nowrap="" class="TableData">
                    <input type="text" id="BigInput_codeNo" class="BigInput" size="20" maxlength="100" value="">&nbsp;
                </td>
            </tr>
            <tr>
                <%--序号--%>
                <td nowrap="" class="TableData" width="120"><fmt:message code="file.th.Sort" />：</td>
                <td nowrap="" class="TableData">
                    <input type="text" id="BigInput_codeOrder" class="BigInput" size="20" maxlength="100" value="">
                </td>
            </tr>
            <tr>
                <%--代码名称：(简体中文)--%>
                <td nowrap="" class="TableData"><fmt:message code="sysCode.th.CodeName" /></td>
                <td nowrap="" class="TableData">
                    <input type="text" id="BigInput_codeName" class="BigInput" size="20" maxlength="100" value="">&nbsp;
                </td>
            </tr>
            <tr>
                <td nowrap="" class="TableControl" colspan="2" align="center">
                    <input type="button" value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="global.lang.ok" />" class="BigButton backimg" onclick="addMainClassify();"/>
                    <!--<input type="button" value="返回" class="BigButton" onclick="location='blank.php'">-->
                    <%--queding--%>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="ErrCodeClass" style="display: none; margin-top: 5px;">
            <div class="header" style=" margin-top: 14px;">
                <span class="divP" style="font-size: 22px;padding-left: 30px;"><img src="../../img/errorcode.png" style="margin-right: 12px;"><fmt:message code="sysCode.th.ErrorCode"/></span>
            </div>
            <table class="errtable" border="0" cellspacing="0" cellpadding="0"
                   style="border-collapse:collapse;background-color: #fff; width: 70%; margin-top: 40px;border: #c0c0c0 1px solid; ">
                <tr class="errorCodeList">
                    <th><fmt:message code="sysCode.th.number" /></th>
                    <th><fmt:message code="sysCode.th.name" /></th>
                    <th><fmt:message code="notice.th.operation" /></th>
                </tr>
            </table>
        </div>
        <div class="baksqlClass" style="display:none; margin-top: 14px;">
            <div class="header">
                <span class="divP" style="font-size: 20px;"><fmt:message code="sysCode.th.CodeBackup-restore"/></span>
            </div>
            <div class="tab" style="margin-top: 20px;">
                <table class="table" cellspacing="0" cellpadding="0"
                       style="border-collapse:collapse;background-color: #fff; width: 90%; ">

                    <tr class="colo" align="center" style="background: #3791DA" color="white">
                        <td>
                            <fmt:message code="sysCode.th.CodeBackup"/>
                        </td>
                    </tr>
                    <tr class="colo" align="center" style="background: #fff" color="white">
                        <td>
                            <input id="exportSqlId" type="button" align="center"
                                   value="<fmt:message code="sysCode.th.ExportSQLFile" />" style="width: 150px;">
                        </td>
                    </tr>
                </table>
            </div>
            <%--导出菜单sql结束--%>
            <div class="tab">
                <form action="../hrCode/ImportCode" method="post" id="myform" enctype="multipart/form-data">
                    <table class="table" cellspacing="0" cellpadding="0"
                           style="border-collapse:collapse;background-color: #fff; width: 90%;">

                        <tr class="colo" align="center" style="background: #3791DA" color="white">
                            <td colspan="2">
                                <%--代码恢复--%>
                                <fmt:message code="sysCode.th.CodeRestore"/>
                            </td>
                        </tr>
                        <tr class="colo" align="center" style="background: #fff" color="white">
                            <td>
                                <input type="file" name="sqlFile" id="filename" align="center" style="width:150px;">

                            </td>

                            <td>
                                <input id="recoverySqlId" type="button" align="center"
                                       <%--恢复--%>
                                       value="<fmt:message code="sysCode.th.Restore" />">

                            </td>
                        </tr>

                    </table>
                </form>
            </div>
            <%--sql导入结束--%>
        </div>
        <%--系统代码备份恢复结束--%>
    </div>
    <table cellspacing="0" cellpadding="0" class="tab TableBlock_sub" style="border-collapse:collapse;background-color: #fff;width: 55%;" align="center" id="TableBlock_sub" ></table>
    <%-- <div class="hideDome" style="display: none;height:98%;border: none;">
         <iframe src="/email/development" width="100%" height="100%;" style="border: none;"></iframe>
     </div>--%><%--正在开发中--%>
</div>
<script type="text/javascript">
    function sort(data){
        var sort_length=data.length;
        var sort_obj=data;
        for(var a=0;a<sort_length-1;a++)
            for(var s=0;s<sort_length-1;s++){
                if(data[s+1].codeorder<data[s].codeorder){
                    var temp;
                    temp=data[s];
                    data[s]=data[s+1];
                    data[s+1]=temp;
                }
            }
        return sort_obj;
    }

    //加载左侧菜单
    $.ajax({
        url:'../../hrCode/syscode/getAllSysCode',
        type:'get',
        dataType:'json',
        //data:datas,
        success:function(data){
            //console.log(data);
            //var obj_tmp=sort(data.obj);
            var length=data.obj.length;
            var str_classify ='<tbody>';
            for(var i=0;i<length;i++){
                var name=data.obj[i].codeName;
                var status=data.obj[i].codeNo;
                if(data.obj[i].codeFlag==0){
                    //console.log(data.obj[i].codeFlag);
                    var str_classify= str_classify+'<tr class="TableData" title="'+data.obj[i].codeName+'">'+
                        '<td class="tabletd">'+data.obj[i].codeName+'</td>'+
                        '<td nowrap="">'+
                        '<a onclick="mainMenuedit(this)" target="user_main"'+
                        'codeId='+data.obj[i].codeId+' codeorder='+data.obj[i].codeOrder+' codeName='+data.obj[i].codeName+' codeNo='+data.obj[i].codeNo+' class="ziti">'+
//                        编辑
                        '<fmt:message code="global.lang.edit" /></a>&nbsp;'+
                        '<a onclick=\'getLevelData("'+status+'","'+name+'");\' target="code_edit" class="ziti"> <fmt:message code="global.lang.next" /></a>&nbsp;'+//下一级
                        '</td></tr>';
                }else if(data.obj[i].codeFlag==1){
                    var str_classify= str_classify+'<tr class="TableData" title="'+data.obj[i].codeName+'">'+
                        '<td class="tabletd">'+data.obj[i].codeName+'</td>'+
                        '<td nowrap="">'+
                        '<a onclick="mainMenuedit(this)" target="user_main"'+
                        'codeId='+data.obj[i].codeId+' codeorder='+data.obj[i].codeOrder+' codeName='+data.obj[i].codeName+' codeNo='+data.obj[i].codeNo+' class="ziti">'+
                        '<fmt:message code="global.lang.edit" /></a>&nbsp;'+
                        '<a onclick=\'getLevelData("'+status+'","'+name+'");\' target="code_edit" class="ziti"> <fmt:message code="global.lang.next" /></a>&nbsp;'+
                        '<a onclick="delete_form(this);" codeId='+data.obj[i].codeId+' codeNo='+status+' class="scziti"> <fmt:message code="global.lang.delete" /></a>'+
                        '</td></tr>';

                }
                //$('#dbgz').html(str);
            }
            var str_classify=str_classify+'</tbody>'
            //$(".hidden").hide();
            $('.hideDome').hide();
            $("#bodycolor").show();
            $('#TableBlock').html(str_classify);
        }
    })
    //-->
    //获得下一级的菜单
    function getLevelData(status,name){
        var datas ={
            parentNo:status,
        };
        $.ajax({
            url:'../../hrCode/getCode',
            //http://192.168.0.21/code/getCode?parentNo=SYS_LOG
            type:'get',
            data:datas,
            dataType:'json',
            //data:datas,
            success:function(data){
                //console.log(data);
                $("#TableBlock_center").css("display","none");
                $(".big3").text('<fmt:message code="global.lang.classification" />');
                var str_sublevel='<tbody><tr class="TableHeader" align="center">'+
                    '<td nowrap="" title="'+name+'" colspan="2" id="next_name">&nbsp;&nbsp;<b>'+name+'</b>&nbsp;&nbsp;'+
                    '</td></tr>'+
                    '<tr><td class="TableControl" align="center" colspan="2"><input type="button" value="<fmt:message code="global.lang.dmx" />" style="padding-left:15px;color:#404060" class="BigButton addcodebut" onclick="mainMenuedit_add(this)" parentCode="'+status+'" name_next="'+name+'"></td></tr>';
                if(data.obj != undefined){
                    var str_length=data.obj.length;
                    for(var i=0;i<str_length;i++){
                        if(data.obj[i].codeFlag==0){
                            str_sublevel=str_sublevel+'<tr class="TableData"><td nowrap="" title="'+data.obj[i].codeName+'">'+
                                data.obj[i].codeNo+'&nbsp;&nbsp;&nbsp;'+data.obj[i].codeName+'&nbsp;'+
                                '</td><td nowrap="">&nbsp;'+
                                '<a onclick="mainMenuedit_sub(this)" codeId='+data.obj[i].codeId+' codeorder='+data.obj[i].codeOrder+' codeName='+data.obj[i].codeName+' codeNo='+data.obj[i].codeNo+' parentNo="'+status+'" class="ziti">'+
                                '<fmt:message code="global.lang.edit" /></a>&nbsp;&nbsp;</td></tr>';
                        }else if(data.obj[i].codeFlag==1){
                            str_sublevel=str_sublevel+'<tr class="TableData"><td nowrap="" title="'+data.obj[i].codeName+'">'+
                                data.obj[i].codeNo+'&nbsp;&nbsp;&nbsp;'+data.obj[i].codeName+'&nbsp;'+
                                '</td><td nowrap="">&nbsp;'+
                                '<a onclick="mainMenuedit_sub(this)" codeId='+data.obj[i].codeId+' codeorder='+data.obj[i].codeOrder+' codeName='+data.obj[i].codeName+' codeNo='+data.obj[i].codeNo+' parentNo="'+status+'" class="ziti">'+
                                '<fmt:message code="global.lang.edit" /></a>&nbsp;&nbsp;'+
                                '<a onclick="delete_next_form(this);" codeId='+data.obj[i].codeId+' codeNo='+data.obj[i].codeNo+' codeName="'+data.obj[i].codeName+'" parentNo_sub="'+status+'" class="scziti"> <fmt:message code="global.lang.delete" /> </a>'+
                                '</td></tr>';
                        }
                    }
                }
                str_sublevel=str_sublevel+'</tbody>';
                $(".big3").text('<fmt:message code="global.lang.item" />');
                $('.hideDome').hide();
                $("#bodycolor").show();
                $("#TableBlock_sub").show().html(str_sublevel);
                //$('.small').css("display", "none");
                $('.ErrCodeClass').css("display", "none");
                $('.baksqlClass').css("display", "none");
            }
        });
    }
    function mainMenuedit(e){
        //$('.small').css("display", "none");
        $('.ErrCodeClass').css("display", "none");
        $('.baksqlClass').css("display", "none");
        var codeId=$(e).attr('codeId'),
            codeorder=$(e).attr('codeorder'),
            codeName=$(e).attr('codeName'),
            codeNo=$(e).attr('codeNo');
        //codeNo=$(e).attr('codeNo');
        $(".big3").text('<fmt:message code="global.lang.classification" />');
        var str_edit=''+
            '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 55%;">'+
            '<tbody><tr><td nowrap="" class="TableData" width="120"><fmt:message code="sysCode.th.CodeNumber" /><span style="color:red">*</span>：</td>'+
            '<td nowrap="" class="TableData">'+
            '<input type="text" name="CODE_NO" class="BigInput" size="20" id="BigInput_num" value="'+codeNo+'" readonly="readonly">&nbsp;'+
            '</td></tr><tr>'+
            '<td nowrap="" class="TableData"><fmt:message code="vote.th.SortNumber" />：</td><td nowrap="" class="TableData">'+
            '<input type="text" name="" class="BigInput" size="20" id="BigInput_order" value="'+codeorder+'">&nbsp;'+
            '</td></tr><tr><td nowrap="" class="TableData"><fmt:message code="sysCode.th.CodeName" /></td>'+
            '<td nowrap="" class="TableData">'+
            '<input type="text"name="" class="BigInput" size="20" id="BigInput" value="'+function(){if(codeName==undefined){return codeorder.split('=')[1]}else{return codeName;}}()+'">&nbsp;'+
            '</td></tr><tr>'+
            '<td nowrap="" class="TableControl" colspan="2" align="center">'+
            '<input type="button" value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="menuSSetting.th.menusetsure" />" class="BigButton backimg" onclick="submit_form(this);" codeId="'+codeId+'" codeNo="'+codeNo+'">&nbsp;&nbsp;'+
            '</td>'+
            '</tr></tbody></table>'+
            '';
        $('.hideDome').hide();
        $("#bodycolor").show();
        $("#TableBlock_center").hide();
        $('#TableBlock_sub').show().html(str_edit);
    }
    function submit_form(me){
        if($('#BigInput').val()==''){
            $.layerMsg({content:'请填写代码名称',icon:2})
            return
        }
        if($('#BigInput_order').val()==''){
            $.layerMsg({content:'请填写排序号',icon:2})
            return
        }
        var form_num=$("#BigInput_num").val();
        var	form_order=$("#BigInput_order").val();
        var	form_name=$("#BigInput").val();
        var form_Id=$(me).attr("codeId");
        //var form_codeNo=$(me).attr("codeNo");
        var datas={
            //代码ID
            codeId:form_Id,
            //代码编号
            codeNo:form_num,
            //代码名称
            codeName:form_name,
            //排序号
            codeOrder:form_order
        }
        var codeNoData={codeNo:form_num};
        $.ajax({
            url:"../../hrCode/iseditCodeNoExits",
            type:"get",
            data:codeNoData,
            dataType:"json",
            success:function (data){
                if(data.flag==true){
                    $.layerMsg({content:'<fmt:message code="menuSSetting.th.repeat" />',icon:2},function(){});
                }else{
                    $.ajax({
                        url:'../../hrCode/syscode/update',
                        type:'get',
                        data:datas,
                        dataType:'json',
                        //data:datas,
                        success:function(){
                            //alert("代码编辑成功");
                            //location.onload();
                            $.ajax({
                                url:'../../hrCode/syscode/getAllSysCode',
                                type:'get',
                                dataType:'json',
                                //data:datas,
                                success:function(data){
                                    //console.log(data);
                                    //var obj_tmp=sort(data.obj);
                                    var length=data.obj.length;
                                    var str_classify ='<tbody>';
                                    for(var i=0;i<length;i++){
                                        var name=data.obj[i].codeName;
                                        var status=data.obj[i].codeNo;
                                        if(data.obj[i].codeFlag==0){
                                            //console.log(data.obj[i].codeFlag);
                                            var str_classify= str_classify+'<tr class="TableData" title="'+data.obj[i].codeName+'">'+
                                                '<td class="tabletd">'+data.obj[i].codeName+'</td>'+
                                                '<td nowrap="">'+
                                                '<a onclick="mainMenuedit(this)" target="user_main"'+
                                                'codeId='+data.obj[i].codeId+' codeorder='+data.obj[i].codeOrder+' codeName='+data.obj[i].codeName+' codeNo='+data.obj[i].codeNo+' class="ziti">'+
                                                '<fmt:message code="global.lang.edit" /></a>&nbsp;'+
                                                '<a onclick=\'getLevelData("'+status+'","'+name+'");\' target="code_edit" class="ziti"> <fmt:message code="global.lang.next" /></a>&nbsp;'+
                                                '</td></tr>';
                                        }else if(data.obj[i].codeFlag==1){
                                            var str_classify= str_classify+'<tr class="TableData" title="'+data.obj[i].codeName+'">'+
                                                '<td class="tabletd">'+data.obj[i].codeName+'</td>'+
                                                '<td nowrap="">'+
                                                '<a onclick="mainMenuedit(this)" target="user_main"'+
                                                'codeId='+data.obj[i].codeId+' codeorder='+data.obj[i].codeOrder+' codeName='+data.obj[i].codeName+' codeNo='+data.obj[i].codeNo+' class="ziti">'+
                                                '<fmt:message code="global.lang.edit" /></a>&nbsp;'+
                                                '<a onclick=\'getLevelData("'+status+'","'+name+'");\' target="code_edit" class="ziti"> <fmt:message code="global.lang.next" /></a>&nbsp;'+
                                                '<a onclick="delete_form(this);" codeId='+data.obj[i].codeId+' codeNo='+status+' class="scziti"> <fmt:message code="global.lang.delete" /></a>'+
                                                '</td></tr>';
                                        }
                                        //$('#dbgz').html(str);
                                    }
                                    var str_classify=str_classify+'</tbody>'
                                    //$(".hidden").hide();
                                    $('.hideDome').hide();
                                    //$("#bodycolor").show();
                                    $('#TableBlock').html(str_classify);
                                    //$("#TableBlock_center").css("display","block");
                                    // alert("您已编辑成功");
                                    $.layerMsg({content:'<fmt:message code="global.lang.changed" />',icon:1},function(){
                                        location.reload();
                                    });
                                }
                            })
                        }
                    })
                }
            }
        })

    }
    //增加主菜单分类
    function addMainClassify(){
        var	codeNo=$("#BigInput_codeNo").val(),
            codeOrder=$("#BigInput_codeOrder").val(),
            codeName=$("#BigInput_codeName").val();

        var codeNoData={codeNo:codeNo};
        var codeOrderData={codeOrder:codeOrder};
        var addData={
            codeNo:codeNo,
            codeOrder:codeOrder,
            codeName:codeName,
            codeFlag:1,
        };
        if(codeNo==""){
            $.layerMsg({content:'<fmt:message code="global.lang.notEmpty" />',icon:0},function(){
//                location.reload();
            });
            //alert("代码编号不能为空");
            return false;
        }else{
            if(codeName !=''){
                $.ajax({
                    url:'../../hrCode/isCodeNoExits',
                    type:'get',
                    dataType:'json',
                    data:codeNoData,
                    success:function (data){
                        if(data.flag==true){
                            $.layerMsg({content:'<fmt:message code="global.lang.reenter" />',icon:0},function(){});

                        }else{
                            $.ajax({
                                url:'../../hrCode/addSysMainCode',
                                type:'get',
                                dataType:'json',
                                data:addData,
                                success:function(data){
                                    //console.log(data);
                                    var length=data.obj.length;
                                    //var name=data.obj[i].codeName;
                                    //var status=data.obj[i].codeNo;
                                    var str_classify ='<tbody>';
                                    for(var i=0;i<length;i++){
                                        var status=data.obj[i].codeNo;
                                        var name=data.obj[i].codeName;
                                        if(data.obj[i].codeFlag==0){
                                            var str_classify= str_classify+'<tr class="TableData" title="'+data.obj[i].codeName+'">'+
                                                '<td class="tabletd">'+data.obj[i].codeName+'</td>'+
                                                '<td nowrap="">'+
                                                '<a onclick="mainMenuedit(this)" target="user_main"'+
                                                'codeId='+data.obj[i].codeId+' codeorder='+data.obj[i].codeOrder+' codeName='+data.obj[i].codeName+' class="ziti">'+
                                                '<fmt:message code="global.lang.edit" /></a>&nbsp;'+
                                                '<a onclick=\'getLevelData("'+status+','+name+'");\' target="code_edit class="ziti""> <fmt:message code="global.lang.next" /></a>&nbsp;'+
                                                '</td></tr>';
                                        }else if(data.obj[i].codeFlag==1){
                                            var str_classify= str_classify+'<tr class="TableData" title="'+data.obj[i].codeName+'">'+
                                                '<td class="tabletd">'+data.obj[i].codeName+'</td>'+
                                                '<td nowrap="">'+
                                                '<a onclick="mainMenuedit(this)" target="user_main"'+
                                                'codeId='+data.obj[i].codeId+' codeorder='+data.obj[i].codeOrder+' codeName='+data.obj[i].codeName+' class="ziti">'+
                                                '<fmt:message code="global.lang.edit" /></a>&nbsp;'+
                                                '<a onclick=\'getLevelData("'+status+','+name+'");\' target="code_edit" class="ziti"> <fmt:message code="global.lang.next" /></a>&nbsp;'+
                                                '<a onclick="delete_form(this);" codeid='+data.obj[i].codeId+' codeno='+status+' class="scziti"> <fmt:message code="global.lang.delete" /></a>'+
                                                '</td></tr>';
                                        }
                                        //$('#dbgz').html(str);
                                    }
                                    var str_classify=str_classify+'</tbody>'
                                    $('.hideDome').hide();
                                    $("#bodycolor").show();
                                    $('#TableBlock').html(str_classify);

                                    //alert("您已新建成功");
                                    $.layerMsg({content:'<fmt:message code="depatement.th.Newsuccessfully" />',icon:1},function(){
                                        location.reload();
                                    });
                                }
                            })
                        }
                    }
                })
            }else{
                $.layerMsg({content:'请填写代码名称!',icon:0},function(){
//                    location.reload();
                })
            }

        }
    }
    function showMain(){
        $(".small").show();
        $(".big3").text("<fmt:message code="sysCode.th.AddCode" />");
        $("#TableBlock_sub").hide();
        //$("#TableBlock_center").show();
        $("#TableBlock_center").css("display","block");
        $("#TableBlock_center").css("margin-top","32px");
        $("#bodycolor").show();
        $('.hideDome').hide();
        $('#menuList').addClass('backgroundcolor');
        $('#codeerror').removeClass('backgroundcolor');
        $('#codecopy').removeClass('backgroundcolor');
        $('.ErrCodeClass').hide();
        $('.baksqlClass').hide();

    }
    function delete_form(e){
        var parentNo=$(e).attr("parentNo");
        var codeDelete={
            codeId:$(e).attr("codeid"),
            codeNo:$(e).attr("codeno"),
        };
        console.log($(this).attr("codeid"));
        console.log($(this).attr("codeno"));
        //var confirm=confirm("确定要删除吗？")

        layer.confirm('<fmt:message code="sup.th.Delete" />？', {
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
            title:["<fmt:message code="notice.th.DeleteFile" />","background-color:rgb(43, 127, 224);color:#fff;"]
        }, function(){
            $.ajax({
                url:'../../hrCode/deleteSysCode',
                type:'get',
                dataType:'json',
                data:codeDelete,
                success:function(){
                    $.ajax({
                        url:'../../hrCode/syscode/getAllSysCode',
                        type:'get',
                        dataType:'json',
                        //data:datas,
                        success:function(data){
                            //console.log(data);
                            //var obj_tmp=sort(data.obj);
                            var length=data.obj.length;
                            var str_classify ='<tbody>';
                            for(var i=0;i<length;i++){
                                var name=data.obj[i].codeName;
                                var status=data.obj[i].codeNo;
                                if(data.obj[i].codeFlag==0){
                                    //console.log(data.obj[i].codeFlag);
                                    var str_classify= str_classify+'<tr class="TableData" title="'+data.obj[i].codeName+'">'+
                                        '<td class="tabletd">'+data.obj[i].codeName+'</td>'+
                                        '<td nowrap="">'+
                                        '<a onclick="mainMenuedit(this)" target="user_main"'+
                                        'codeId='+data.obj[i].codeId+' codeorder='+data.obj[i].codeOrder+' codeName='+data.obj[i].codeName+' codeNo='+data.obj[i].codeNo+' class="ziti">'+
                                        '<fmt:message code="global.lang.edit" /></a>&nbsp;'+
                                        '<a onclick=\'getLevelData("'+status+'","'+name+'");\' target="code_edit" class="ziti"> <fmt:message code="global.lang.next" /></a>&nbsp;'+
                                        '</td></tr>';
                                }else if(data.obj[i].codeFlag==1){
                                    var str_classify= str_classify+'<tr class="TableData" title="'+data.obj[i].codeName+'">'+
                                        '<td class="tabletd">'+data.obj[i].codeName+'</td>'+
                                        '<td nowrap="">'+
                                        '<a onclick="mainMenuedit(this)" target="user_main"'+
                                        'codeId='+data.obj[i].codeId+' codeorder='+data.obj[i].codeOrder+' codeName='+data.obj[i].codeName+' codeNo='+data.obj[i].codeNo+' class="ziti">'+
                                        '<fmt:message code="global.lang.edit" /></a>&nbsp;'+
                                        '<a onclick=\'getLevelData("'+status+'","'+name+'");\' target="code_edit" class="ziti"> <fmt:message code="global.lang.next" /></a>&nbsp;'+
                                        '<a onclick="delete_form(this);" codeId='+data.obj[i].codeId+' codeNo='+status+' class="scziti"> <fmt:message code="global.lang.delete" /></a>'+
                                        '</td></tr>';

                                }
                                //$('#dbgz').html(str);
                            }
                            var str_classify=str_classify+'</tbody>'
                            //$(".hidden").hide();
                            $('.hideDome').hide();
                            $("#bodycolor").show();
                            $('#TableBlock').html(str_classify);

                            $.layerMsg({content:'<fmt:message code="workflow.th.delsucess" />！',icon:1},function(){
                                location.reload();
                            });
                        }
                    })
                }
            })
        }, function(){
            layer.closeAll();
        });
    }
    $('#link_3').on('click',function(){
        //$.layerMsg({content:'即将上线此功能 ，敬请期待！',icon:6},function(){});
        //$('.small').hide();
        $('#TableBlock_sub').hide();
        $('#TableBlock_center').hide();
        $('.ErrCodeClass').show().siblings().hide();
        $('.baksqlClass').hide();
        $.ajax({
            url: "../../hrCode/getErrCode",
            //data:"",
            dataType: "json",
            type: "get",
            success: function (res) {
                var str = '<tr class="errorCodeLists"><th><fmt:message code="sysCode.th.number" /></th><th><fmt:message code="sysCode.th.name" /></th><th><fmt:message code="notice.th.operation" /></th><tr>';
                var data1 = res.object;
                if(data1==''){
                    str +='<tr><td colspan="3" style="text-align:center; font-family:"微软雅黑", "宋体";"><fmt:message code="doc.th.NoData" /></td></tr>';
                }
                for (var i = 0; i < data1.length; i++) {
                    if (data1[i].codeFlag == 0) {
                        str += '<tr class="AllData"><td>' + data1[i].codeId + '</td><td>' + data1[i].name + '</td><td>' + '<a href="javascript:;" onclick="editErrCode(' + data1[i].codeId + ')"><fmt:message code="depatement.th.modify" /></a>&nbsp;&nbsp;&nbsp;&nbsp;' + '</td></tr>';
                    } else if (data1[i].codeFlag == 1) {
                        str += '<tr class="AllData"><td>' + data1[i].codeId + '</td><td>' + data1[i].codeName + '</td><td>' + '<a href="javascript:;" onclick="editErrCode(' + data1[i].codeId + ')"><fmt:message code="depatement.th.modify" /></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="javascript:;" onclick="deleteErrCode(' + data1[i].codeId + ')"><fmt:message code="menuSSetting.th.deleteMenu" /></a>' + '</td></tr>';
                    }
                }
                $('.errorCodeList').after(str);
                $('.errorCodeList').remove();
                $('.ErrCodeClass').show().siblings().hide();
            }
        });
    })
    $('#link_2').on('click',function(){
        //$.layerMsg({content:'即将上线此功能 ，敬请期待！',icon:6},function(){});
        //$('.small').hide();
        $('#TableBlock_sub').hide();
        $('#TableBlock_center').hide();
        $('.baksqlClass').show().siblings().hide();
        $('.ErrCodeClass').hide();
    })

    function mainMenuedit_add(e){
        // var codeId=$(e).attr('codeId'),
        // codeorder=$(e).attr('codeorder'),
        //codeName=$(e).attr('codeName');
        //codeNo=$(e).attr('codeNo');
        //codeNo=$(e).attr('codeNo');
        var parentcode=$(e).attr("parentCode");
        console.log(parentcode);
        var paerentCodeName = $(e).attr('name_next');
        var name_next_1=$(e).attr("name_next");
        $(".big3").text('<fmt:message code="global.lang.dmx" />');
        //$("#bodycolor").empty();
        $("#TableBlock_center").hide();
        //var parentcode=$(e).val('codeparent');
        //console(parentcode);
        //$('#TableBlock_sub').show().html(str_edit);
        //$("#TableBlock_sub").show().html(str_sublevel);
        //$('#TableBlock_sub').empty().html(str_edit);
        $.ajax({
            url:"../../hrCode/syscode/getAllSysCode",
            //data:"",
            dataType:"json",
            type:"get",
            success:function(data){
                var str_i='<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 55%;"><tbody><tr><td class="TableData"><fmt:message code="global.lang.class" /></td><td class="TableData"><select id="select">';
                var length=data.obj.length;
                for(var k=0;k<length;k++){
                    if(data.obj[k].codeNo == parentcode){
                        var str_i=str_i+'<option selected parentNo='+data.obj[k].codeNo+'>'+data.obj[k].codeName+'</option>';
                    }else{
                        var str_i=str_i+'<option parentNo='+data.obj[k].codeNo+'>'+data.obj[k].codeName+'</option>';
                    }

                }
                var str_i=str_i+'</td></tr></select><tr><td nowrap="" class="TableData" width="120"><fmt:message code="sysCode.th.CodeNumber" />：</td><td nowrap="" class="TableData"><input type="text" name="CODE_NO" class="BigInput" size="20" id="add_codeNo" value="">&nbsp;</td></tr><tr><td nowrap="" class="TableData"><fmt:message code="vote.th.SortNumber" />：</td><td nowrap="" class="TableData"><input type="text" name="" class="BigInput" size="20" id="add_codeOrder" value="">&nbsp;</td></tr><tr><td nowrap="" class="TableData"><fmt:message code="sysCode.th.CodeName" /></td><td nowrap="" class="TableData"><input type="text"name="" class="BigInput" size="20" id="add_codeName" value="">&nbsp;</td></tr><tr><td nowrap="" class="TableControl" colspan="2" align="center"><input type="button" value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="menuSSetting.th.menusetsure" />" class="BigButton backimg" onclick="addSubCode(this)" parentCodeName="'+paerentCodeName+'" parentNo="'+parentcode+'">&nbsp;&nbsp;<input type="button" value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="notice.th.return" />" class="BigButton reimg" onclick="back(this)" codeId="" codeName="" codeNo="'+parentcode+'" name_next_1="'+name_next_1+'"></td></tr></tbody></table>';
                $('.hideDome').hide();
                $("#bodycolor").show();
                $("#TableBlock_sub").html(str_i);
            },
        });
    }

    function addSubCode(e){
        var	codeNo=$("#add_codeNo").val(),
            codeOrder=$("#add_codeOrder").val(),
            codeName=$("#add_codeName").val();
        //var parentNo=$(e).attr("parentNo");
        var parentNo=$("#select option:selected").attr("parentNo");
        var parentCodeName = $(e).attr('parentcodename')
        var addcodeNoData={codeNo:codeNo,parentNo:parentNo};
        var addcodeOrderData={codeOrder:codeOrder};
        var addData={
            codeNo:codeNo,
            codeOrder:codeOrder,
            codeName:codeName,
            codeFlag:1,
        };
        var datas={
            parentNo:parentNo,
            codeNo:codeNo,
            codeOrder:codeOrder,
            codeName:codeName

        }
//        var data={
//            parentNo:,
//            codeNo:,
//            codeOrder:,
//            codeName:
//        }
        if(codeNo==""){
            $.layerMsg({content:'<fmt:message code="global.lang.notEmpty" />！',icon:0},function(){
                location.reload();
            });
            //alert("代码编号不能为空");
        }else{
            $.ajax
            ({
                url:'../../hrCode/ChildisCodeNoExits',
                type:'get',
                dataType:'json',
                data:addcodeNoData,
                success:function (data){
                    if(data.flag==true){
                        //alert('代码编号已存在请重新输入');
                        $.layerMsg({content:'<fmt:message code="global.lang.reenter" />！',icon:0},function(){

                        });
                    }else{
                        $.ajax({
                            url:'../../hrCode/addChildSysCode',
                            data:datas,
                            type:'get',
                            dataType:'json',
                            success:function(data){
                                //alert("您新增代码成功");
                                $.layerMsg({content:'<fmt:message code="global.lang.sgsed" />！',icon:1},function(){
                                    //location.reload();
                                    getLevelData(parentNo,parentCodeName);
                                });
                            }
                        })

                    }
                }
            })
        }
        //$.ajax({
        //url:'../../code/addChildSysCode',
        //data:data,
        //type:'get',
        //dataType:'json',
        //success:function(){

        //}
        //})
    }
    function mainMenuedit_sub(e){
        var next_name=$("#next_name").text();
        var codeNo=$(e).attr("codeNo");
        var codeOrder=$(e).attr("codeOrder");
        var codeName=$(e).attr("codeName");
        var codeId=$(e).attr("codeId");
        var parentNo=$(e).attr("parentNo");
        var str_s='<table><tbody><tr><td class="TableData"><fmt:message code="global.lang.class" /></td><td class="TableData">'+next_name+'</td></tr><tr><td nowrap="" class="TableData" width="120"><fmt:message code="sysCode.th.CodeNumber" />：</td>'+
            '<td nowrap="" class="TableData">'+
            '<input type="text" name="CODE_NO" class="BigInput" size="20" id="BigInput_num" value="'+codeNo+'">&nbsp;'+
            '</td></tr><tr>'+
            '<td nowrap="" class="TableData"><fmt:message code="vote.th.SortNumber" />：</td><td nowrap="" class="TableData">'+
            '<input type="text" name="" class="BigInput" size="20" id="BigInput_order" value="'+codeOrder+'">&nbsp;'+
            '</td></tr><tr><td nowrap="" class="TableData"><fmt:message code="sysCode.th.CodeName" /></td>'+
            '<td nowrap="" class="TableData">'+
            '<input type="text"name="" class="BigInput" size="20" id="BigInput" value="'+codeName+'">&nbsp;'+
            '</td></tr><tr>'+
            '<td nowrap="" class="TableControl" colspan="2" align="center">'+
            '<input type="button" value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="menuSSetting.th.menusetsure" />" class="BigButton backimg" onclick="editerrcode(this);" codeId="'+codeId+'" codeNo="'+codeNo+'" parentNo="'+parentNo+'" form_oldname="'+parentNo+'" next_name="'+next_name+'">&nbsp;&nbsp;'+
            '</td>'+
            '</tr></tbody></table>'+
            '';
        $('.hideDome').hide();
        $("#bodycolor").show();
        $(".big3").text('<fmt:message code="menuSSetting.th.argrae" />');
        $('#TableBlock_sub').html(str_s);

    }
    function back(e){
        var name=$(e).attr("name_next_1");
        var status=$(e).attr("codeNo");
        getLevelData(status,name);
    }
    function delete_next_form(e){
        //var parentNo=$(e).attr("parentNo");
        var codeDelete={
            codeId:$(e).attr("codeid"),
            codeNo:$(e).attr("codeno"),
        };
        console.log($(this).attr("codeid"));
        console.log($(this).attr("codeno"));
        //var confirm=confirm("确定要删除吗？")
        layer.confirm('<fmt:message code="sup.th.Delete" />？', {
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
            title:["<fmt:message code="notice.th.DeleteFile" />","background-color:rgb(43, 127, 224);color:#fff;"]
        }, function(){
            $.ajax({
                url:'../../hrCode/deleteSysCode',
                type:'get',
                dataType:'json',
                data:codeDelete,
                success:function(){
                    var status=$(e).attr("parentNo_sub");
                    var name=$("#next_name").text();
                    getLevelData(status,name);
                }
            })
            layer.closeAll();
        }, function(){
            layer.closeAll();
        });
    }
    $('.hidden').on("click",function(){
        //alert('123');
        $('.hideDome').show().siblings().hide();
    })
    function showbg1(){
        $('#codeerror').addClass('backgroundcolor');
        $('#codecopy').removeClass('backgroundcolor');
        $('#menuList').removeClass('backgroundcolor');
    }
    function showbg2(){
        $('#codecopy').addClass('backgroundcolor');
        $('#codeerror').removeClass('backgroundcolor');
        $('#menuList').removeClass('backgroundcolor');
    }
    function sub_edit_menu(me){
        var form_num=$("#BigInput_num").val();
        var	form_order=$("#BigInput_order").val();
        var	form_name=$("#BigInput").val();
        var form_Id=$(me).attr("codeId");
        var parentNo=$(me).attr("parentNo");
        var oldcodeNo=$(me).attr("codeNo");
        var form_oldname=$(me).attr("form_oldname");
        var next_name=$(me).attr("next_name");
        var codeNoData={
            codeNo:form_num,
            parentNo:parentNo,
            oldCodeNo:oldcodeNo
        }
        var  datas={
            //代码ID
            codeId:form_Id,
            //代码编号
            codeNo:form_num,
            //代码名称
            codeName:form_name,
            //排序号
            codeOrder:form_order
        }

        if(form_num==""){
            alert("<fmt:message code="global.lang.notEmpty" />");
            $.layerMsg({content:'<fmt:message code="global.lang.notEmpty" />！',icon:0},function(){

            });
        }else{
            $.ajax({
                url:"../../hrCode/editisCodeNoExits",
                type:"get",
                dataType:"json",
                data:codeNoData,
                success:function(data){
                    if(data.flag==true){
                        //alert("编号重复请重新输入");
                        $.layerMsg({content:'<fmt:message code="menuSSetting.th.repeat" />！',icon:0},function(){

                        });
                    }else{
                        $.ajax({
                            url:'../../hrCode/syscode/update',
                            type:'get',
                            data:datas,
                            dataType:'json',
                            //data:datas,
                            success:function(){
                                //alert("代码编辑成功");
                                $.layerMsg({content:'<fmt:message code="depatement.th.Modifysuccessfully" />！',icon:1},function(){

                                });
                                getLevelData(form_oldname,next_name);
                            }
                        })
                    }
                }
            })
        }
    }
    $('#exportSqlId').on("click",function () {
       /* window.location.href = '../code/ExportCode';*/
        $.layerMsg({content:'<fmt:message code="sup.th.UnderDeve" />',icon:6});
    });
    //恢复按钮
    $('#recoverySqlId').on("click",function(){

     /*  if($('#filename').val()!=''){
           var form = new FormData(document.getElementById("myform"));
           $.ajax({
               cache: true,
               type: "POST",
               url: '../code/ImportCode',
               data:form,
               async: false,
               dataType:'json',
               processData:false,
               contentType:false,
               error: function(request) {
                   alert("Connection error");
               },
               success: function(data) {
                   if(data.flag==true){
                       $.layerMsg({content:'恢复成功！',icon:1});
                   }
               }
           });
       }
       else{
           $.layerMsg({content:'请选择文件！',icon:2});
       }*/
        $.layerMsg({content:'<fmt:message code="sup.th.UnderDeve" />',icon:6});

    })
    function editErrCode(e) {
        var data = {'CodeId':e};
        $.ajax({
            url: '../hrCode/getErrInfo',
            type: 'get',
            data:data,
            dataType: 'json',
            success: function (res){
                var data1 =res.object;
                var next_name=$("#next_name").text();
                var codeNo=$(data1).attr("codeNo");
                var codeOrder=$(data1).attr("codeOrder");
                var codeName=$(data1).attr("codeName");
                var codeId=$(data1).attr("codeId");
                var parentNo=$(data1).attr("parentNo");
                var str_s='<table><tbody><tr><td nowrap="" class="TableData" width="120"><fmt:message code="global.lang.class" />：</td><td><select id="select" style="width:120px;"><option id="opt1"></option><c:forEach items=""></c:forEach></select></td></tr><tr><td nowrap="" class="TableData" width="120"><fmt:message code="sysCode.th.CodeNumber" />：</td>'+
                    '<td nowrap="" class="TableData">'+
                    '<input type="text" name="CODE_NO" class="BigInput" size="20" id="BigInput_num" value="'+data1.codeNo+'">&nbsp;'+
                    '</td></tr><tr>'+
                    '<td nowrap="" class="TableData"><fmt:message code="vote.th.SortNumber" />：</td><td nowrap="" class="TableData">'+
                    '<input type="text" name="" class="BigInput" size="20" id="BigInput_order" value="'+data1.codeOrder+'">&nbsp;'+
                    '</td></tr><tr><td nowrap="" class="TableData"><fmt:message code="sysCode.th.CodeName" /></td>'+
                    '<td nowrap="" class="TableData">'+
                    '<input type="text"name="" class="BigInput" size="20" id="BigInput" value="'+data1.codeName+'">&nbsp;'+
                    '</td></tr><tr>'+
                    '<td nowrap="" class="TableControl" colspan="2" align="center">'+
                    '<input type="button" value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="menuSSetting.th.menusetsure" />" class="BigButton backimg" onclick="editerrcode(this);" codeId="'+data1.codeId+'" codeNo="'+data1.codeNo+'" parentNo="'+data1.parentNo+'" form_oldname="'+data1.parentNo+'" next_name="'+data1.next_name+'">&nbsp;&nbsp;'+
                    '</td>'+
                    '</tr></tbody></table>'+
                    '';
                //获取下拉框数据
                $.ajax({
                    url: '../hrCode/getAllCode',
                    type: 'get',
                    dataType: 'json',
                    success:function(data){
                        var str="";
                        for(var i=0;i<data.object.length;i++){
                            str+='<option value="'+data.object[i].codeNo+ '">'+data.object[i].codeName+'</option>';
                        }
                        $('#opt1').after(str);
                    }
                });
                $('.hideDome').hide();
                $("#bodycolor").show();
                $(".big3").text('<fmt:message code="menuSSetting.th.argrae" />');
                $('#TableBlock_sub').html(str_s);
                $('#TableBlock_sub').show();
                $('.ErrCodeClass').hide();
                $('#TableBlock_center').hide();
                $('.baksqlClass').hide();

            }
        })


    };
    function deleteErrCode(e) {

        layer.confirm('<fmt:message code="sup.th.Delete" />？', {
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
            title:["<fmt:message code="notice.th.DeleteFile" />","background-color:rgb(43, 127, 224);color:#fff;"]
        }, function(){
            $.ajax({
                type: 'get',
                url: '../hrCode/deleteErrCode',
                dataType: 'json',
                data: {'CodeId': e},
                success: function () {
                    $.ajax({
                        type: 'get',
                        url: '../hrCode/getErrCode',
                        dataType: 'json',
                        success: function (res) {
                            var str = '<tr><td><fmt:message code="sysCode.th.number" /></td><td><fmt:message code="sysCode.th.name" /></td><td><fmt:message code="notice.th.operation" /></td><tr>';
                            var data1 = res.object;
                            if(data1==''){
                                str +='<tr><td colspan="3" style="text-align:center; font-family:"微软雅黑", "宋体";"><fmt:message code="doc.th.NoData" /></td></tr>';
                            }
                            else{
                                for (var i = 0; i < data1.length; i++) {
                                    if (data1[i].codeFlag == 0) {
                                        str += '<tr class="AllData"><td>' + data1[i].codeId + '</td><td>' + data1[i].name + '</td><td>' + '<a href="javascript:;" onclick="editErrCode(' + data1[i].codeId + ')"><fmt:message code="depatement.th.modify" /></a>&nbsp;&nbsp;&nbsp;&nbsp;' + '</td></tr>';
                                    } else if (data1[i].codeFlag == 1) {
                                        str += '<tr class="AllData"><td>' + data1[i].codeId + '</td><td>' + data1[i].codeName + '</td><td>' + '<a href="javascript:;" onclick="editErrCode(' + data1[i].codeId + ')"><fmt:message code="depatement.th.modify" /></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="javascript:;" onclick="deleteErrCode(' + data1[i].codeId + ')"><fmt:message code="menuSSetting.th.deleteMenu" /></a>' + '</td></tr>';
                                    }
                                }
                            }
                            $('.errtable').html(str);
                            $('.errorCodeList').remove();
                            $('.ErrCodeClass').show();
                            $('#TableBlock_sub').hide();
                            $('#TableData').hide();
                        }
                    })

                }
            })
        }, function(){
            layer.closeAll();
        });
    };

    function editerrcode(me){
        var form_num=$("#BigInput_num").val();
        var	form_order=$("#BigInput_order").val();
        var	form_name=$("#BigInput").val();
        var form_parentNo=$('#select option:selected').val();
        var form_Id=$(me).attr("codeId");
        var parentNo=$(me).attr("parentNo");
        var oldcodeNo=$(me).attr("codeNo");
        var form_oldname=$(me).attr("form_oldname");
        var next_name=$(me).attr("next_name");
        var codeNoData={
            codeNo:form_num,
            parentNo:parentNo,
            oldCodeNo:oldcodeNo
        }
        var  datas={
            //代码ID
            codeId:form_Id,
            //代码编号
            codeNo:form_num,
            //代码名称
            codeName:form_name,
            //排序号
            codeOrder:form_order,
            //父类
            parentNo:form_parentNo
        }

        if(form_num==""){
            alert("<fmt:message code="global.lang.notEmpty" />");
            $.layerMsg({content:'<fmt:message code="global.lang.notEmpty" />！',icon:0},function(){
            });
        }else{
            
            $.ajax({
                url:"../../hrCode/editisCodeNoExits",
                type:"get",
                dataType:"json",
                data:codeNoData,
                success:function(data){
                    if(data.flag==true){
                        //alert("编号重复请重新输入");
                        $.layerMsg({content:'<fmt:message code="menuSSetting.th.repeat" />！',icon:0},function(){

                        });
                    }else{
                        $.ajax({
                            url:'../../hrCode/syscode/update',
                            type:'get',
                            data:datas,
                            dataType:'json',
                            //data:datas,
                            success:function(){
                                $.layerMsg({content:'<fmt:message code="depatement.th.Modifysuccessfully" />！',icon:1},function(){
                                    $.ajax({
                                        url: "../../hrCode/getErrCode",
                                        //data:"",
                                        dataType: "json",
                                        type: "get",
                                        success: function (res) {
                                            getLevelData(parentNo,form_oldname);
                                         /*   var str = '<tr><td>错误代码编号</td><td>错误代码名称</td><td>操作</td><tr>';
                                            var data1 = res.object;
                                            if(data1==''){
                                                str +='<tr><td colspan="3" style="text-align:center; font-family:"微软雅黑", "宋体";">暂无数据</td></tr>';
                                            }
                                            for (var i = 0; i < data1.length; i++) {
                                                if (data1[i].codeFlag == 0) {
                                                    str += '<tr class="AllData"><td>' + data1[i].codeId + '</td><td>' + data1[i].name + '</td><td>' + '<a href="javascript:;" onclick="editErrCode(' + data1[i].codeId + ')">修改</a>&nbsp;&nbsp;&nbsp;&nbsp;' + '</td></tr>';
                                                } else if (data1[i].codeFlag == 1) {
                                                    str += '<tr class="AllData"><td>' + data1[i].codeId + '</td><td>' + data1[i].codeName + '</td><td>' + '<a href="javascript:;" onclick="editErrCode(' + data1[i].codeId + ')">修改</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="javascript:;" onclick="deleteErrCode(' + data1[i].codeId + ')">删除</a>' + '</td></tr>';
                                                }
                                            }
                                            $('.errtable').html(str);
                                            $('.errorCodeList').remove();
                                            $('.ErrCodeClass').show();
                                            $('#TableBlock_sub').hide();
                                            $('#TableData').hide();*/
                                        }
                                    });
                                });
                            }
                        })
                    }
                }
            })
        }
    }

</script>
</body>
</html>