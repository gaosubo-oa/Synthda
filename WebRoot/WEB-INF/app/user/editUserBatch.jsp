<%--
  Created by IntelliJ IDEA.
  User: gsb
  Date: 2017/7/11
  Time: 17:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>


<html>
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <title><fmt:message code="userManagement.th.Batch" /></title>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>


    <script type="text/javascript" src="../js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="../js/news/page.js"></script>
    <script type="text/javascript" src="../lib/laydate/laydate.js"></script>
    <script type="text/javascript" src="../js/base/base.js" charset="utf-8"></script>
    <script type="text/javascript" src="../lib/pagination/js/jquery.pagination.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="../lib/layer/layer.js?20201106"></script>
    <script src="https://cdn.bootcss.com/jquery.form/4.2.1/jquery.form.js"></script>
</head>
<style type="text/css">
    * {
        margin: 0 auto;
    }

    .top {
        margin-top: 20px;
        margin-left: 20px;
    }

    .tableDiv {
        margin-top: 20px;
        padding-bottom: 45px;
    }

    .tableDiv table {
        width: 88%;
    }

    input {
        width: 150px;
    }

    select {
        width: 195px;
    }

    a {
        text-decoration: none;
        color: #3eb1f0;
    }

    .blue {
        color: blue;
    }
    .TableList tr {
        text-align: center;
    }
    /*定义滚动条宽高及背景，宽高分别对应横竖滚动条的尺寸*/
    ::-webkit-scrollbar{
        width: 2px;
        height: 16px;
        background-color: #f5f5f5;
    }
    /*定义滚动条的轨道，内阴影及圆角*/
    ::-webkit-scrollbar-track{
        -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
        border-radius: 10px;
        background-color: #f5f5f5;
    }
    /*定义滑块，内阴影及圆角*/
    ::-webkit-scrollbar-thumb{
        /*width: 10px;*/
        height: 20px;
        border-radius: 10px;
        -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
        background-color: #555;
    }
    .subBtn{
        cursor:pointer;
        background-color: #0A5FA2;
        color: #ffffff;
        line-height: 1px;
    }
    .layui-layer{
        top:200px!important;
    }
    .checkAll{
        width: 13px;
    }
    .checkChild{
        width: 13px;
    }
    .TableList tr td{
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        cursor: pointer;
    }
</style>
<body>
<table border="0" width="100%" cellspacing="0" cellpadding="3" class="small">
    <tr>
        <td class="Big"><img src="../img/sys/icon_batchUserSettings.png"
                             style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="<fmt:message code="userManagement.th.Batch" />"><span
                class="big3"> <fmt:message code="userManagement.th.Batch" /></span>
            <div id="Confidential" style="display: inline-block"></div>
        </td>
    </tr>
</table>

<form action="set_update.php" method="post" name="form1" onSubmit="return CheckForm();">
    <table class="TableBlock" width="100%" align="center">
        <tr>
            <td nowrap class="TableData" width="150"><fmt:message code="user.th.dep" />：<span style='color:red;'>*</span></td>
            <td class="TableData">
                <textarea cols=38 name=TO_NAME id="deptInput" rows=2 class="BigStatic" wrap="yes" readonly></textarea>
                <a href="javascript:;" class="deptAdd" ><fmt:message code="global.lang.add" /></a>
                <a href="javascript:;" class="deptClear" ><fmt:message code="global.lang.empty" /></a>
            </td>
        </tr>
        <tr>
            <td nowrap class="TableData"><fmt:message code="user.th.role" />：<span style='color:red;'>*</span></td>
            <td class="TableData">
                <textarea cols=38 name="PRIV_NAME" id="userPrivsInput" rows=2 class="BigStatic" wrap="yes" readonly></textarea>
                <a href="javascript:;" class="userPrivsAdd" ><fmt:message code="global.lang.add" /></a>
                <a href="javascript:;" class="userPrivsClear" ><fmt:message code="global.lang.empty" /></a>
            </td>
        </tr>

        <tr>
            <td nowrap class="TableData"><fmt:message code="user.th.pson" />：<span style='color:red;'>*</span></td>
            <td class="TableData">
                <textarea cols=38 name="COPY_TO_NAME" id="usersInput" rows=2 class="BigStatic" wrap="yes" readonly></textarea>
                <a href="javascript:;" class="usersAdd" ><fmt:message code="global.lang.add" /></a>
                <a href="javascript:;" class="usersClear" ><fmt:message code="global.lang.empty" /></a>
                <%--<br><a href="javascript:no_pass_user();">空密码用户</a>&nbsp;
                <a href="javascript:;" class="outUserAdd" >添加离职人员</a>--%>
            </td>
        </tr>


        <%--<tr>
            <td nowrap class="TableData">桌面模块(左侧)：</td>
            <td class="TableData">
                <select name="mytableLeft" class="" multiple="multiple">
                    <option id="mytableLeftDefulat">请选择左侧桌面模块</option>

                </select>

            </td>
        </tr>--%>

        <%--<tr>
            <td nowrap class="TableData">桌面模块(右侧)：</td>
            <td class="TableData">
                <input type="hidden" name="MYTABLE_RIGHT" value="">
                <textarea cols=38 name="MYTABLE_RIGHT_DESC" rows=2 class="BigStatic" wrap="yes" readonly></textarea>
                <a href="javascript:;" class="orgAdd" >选择</a>
                <a href="javascript:;" class="orgClear" >清空</a>
            </td>
        </tr>

        <tr>
            <td nowrap class="TableData">登录打开门户：</td>
            <td class="TableData">
                <input type="hidden" name="PORTAL" value="">
                <textarea cols=38 name="PORTAL_DESC" rows=2 class="BigStatic" wrap="yes" readonly></textarea>
                <a href="javascript:;" class="orgAdd" >选择</a>
                <a href="javascript:;" class="orgClear" >清空</a>
            </td>
        </tr>

        <tr>
            <td nowrap class="TableData">菜单快捷组：</td>
            <td class="TableData">
                <input type="hidden" name="SHORTCUT" value="">
                <textarea cols=38 name="SHORTCUT_DESC" rows=2 class="BigStatic" wrap="yes" readonly></textarea>
                <a href="javascript:;" class="orgAdd" >选择</a>
                <a href="javascript:;" class="orgClear">清空</a>
            </td>
        </tr>--%>

        <tr>
            <td nowrap class="TableData"><fmt:message code="user.th.WhiteList" />：</td>
            <td class="TableData">
                <textarea cols=38 name="modulePrivIds" id="userPrivmInput" rows=2 class="BigStatic" wrap="yes" readonly></textarea>
                <a href="javascript:;" class="userPrivmAdd"><fmt:message code="global.lang.add" /></a>
                <a href="javascript:;" class="userPrivmClear"><fmt:message code="global.lang.empty" /></a>
                <br><fmt:message code="sys.th.roleUser" />
            </td>
        </tr>

        <tr>
            <td nowrap class="TableData" width="120"><fmt:message code="userManagement.th.ManagementScope" />：
            <td nowrap class="TableData">
                <select name="postPriv" class="postPrivSelect">
                    <option value="" selected><fmt:message code="sys.th.chooseMana" /></option>
                    <option value="0"><fmt:message code="sys.th.ThisDepartment" /></option>
                    <option value="1"><fmt:message code="url.th.all" /></option>
                    <option value="2"><fmt:message code="sys.th.DesignatedDepartment" /></option>
                </select>
            </td>
        </tr>

        <tr id="postDeptTr" class="TableData" width="120" style="display:none;">
            <td nowrap class="TableData"><fmt:message code="sys.th.managerDept" />：</td>
            <td class="TableData">
                <textarea cols=38 name="postDept" id="postDeptInput" rows=2 class="BigStatic" wrap="yes" readonly></textarea>
                <a href="javascript:;" class="postDeptAdd" ><fmt:message code="global.lang.add" /></a>
                <a href="javascript:;" class="postDeptClear" ><fmt:message code="global.lang.empty" /></a>
            </td>
        </tr>

        <tr>
            <td nowrap class="TableData"><fmt:message code="url.th.Leading" />：<span class='blue'>*</span></td>
            <td nowrap class="TableData">
                <span style="position: relative;">
                    <input type="text" name="userPriv" userpriv="," id="userPrivInput" class="" value="" style="width: 195px;" readonly>
                    <a href="javascript:;" class="userPrivAdd" name="orgAdd" ><fmt:message code="global.lang.add" /></a>
                    <a href="javascript:;" class="userPrivClear" name="orgClear"><fmt:message code="global.lang.empty" /></a>
                </span>&nbsp;&nbsp;
            </td>
        </tr>
        <tr>
            <td nowrap class="TableData"><fmt:message code="userManagement.th.department" />：<span class='blue'>*</span></td>
            <td nowrap class="TableData">
                <select name="deptId" class="deptSelect">

                </select><!--如设置为离职人员/外部人员，将对其他用户不可见-->
            </td>
        </tr>
        <tr>
            <td nowrap class="TableData"><fmt:message code="interfaceSetting.th.InterfaceTopics" />：<span class='blue'>*</span></td>
            <td class="TableData">
                <select name="theme" class="">
                    <option value="20">时尚全能</option>
                    <option value="6"><fmt:message code="controller.th.er" /></option>
                    <option value="7"><fmt:message code="controller.th.san" /></option>
                    <option value="3"><fmt:message code="controller.th.si" /></option>
                    <option value="4"><fmt:message code="controller.th.gm" /></option>
                    <option value="5"><fmt:message code="controller.th.dge" /></option>
                </select><%--需重新登录才能生效 &nbsp;<a href="javascript:" onClick="set_theme_same_with_me();">设置为我的界面主题</a>--%>
            </td>
        </tr>

        <tr>
            <td nowrap class="TableData" width="20%"><fmt:message code="url.th.Default" />：</td>
            <td class="TableData">
                <select name="menuExpand" class="">
                    <option id="defultSelect" value=""><fmt:message code="sys.th.chooseDefault" /></option>
                </select>
            </td>
        </tr>
        <tr  style="display: none">
            <td nowrap class="TableData"><fmt:message code="url.th.Background" />：</td>
            <td class="TableData">
                <select name="bkground" class="" >
                    <option value=""><fmt:message code="sys.th.chooseBack" /></option>
                    <option value="0"><fmt:message code="url.th.SystemDefaults" /></option>
                </select>&nbsp;
                <a id="bk_preview" href="" target="_blank" style="display:none;"><fmt:message code="global.lang.view" /></a>
            </td>
        </tr>
        <tr style="display: none">
            <td nowrap class="TableData"><fmt:message code="url.th.loginType" />：<span class='blue'>*</span></td>
            <td class="TableData">
                <select name="menuType" class="">
                    <option value=""><fmt:message code="sys.th.chooseLogin" /></option>
                    <option value="1"><fmt:message code="url.th.OpenWindow" /></option>
                    <option value="2"><fmt:message code="url.th.OpenNew" /></option>
                    <option value="3"><fmt:message code="sys.th.window" /></option>
                </select> <fmt:message code="sys.th.login" />
            </td>
        </tr>
        <tr style="display: none">
            <td nowrap class="TableData"><fmt:message code="sys.th.alert" />：<span class='blue'>*</span></td>
            <td class="TableData">
                <select name="smsOn" class="">
                    <option value=""><fmt:message code="sys.th.choose" /></option>
                    <option value="1"><fmt:message code="sys.th.zidong" /></option>
                    <option value="0"><fmt:message code="sys.th.hand" /></option>
                </select>
            </td>
        </tr>
        <tr  style="display: none">
            <td nowrap class="TableData"><fmt:message code="url.th.Message" />：</td>
            <td class="TableData">
                <select name="callSound" class="" onChange="select_sound()">
                    <option value=""><fmt:message code="sys.th.chooseMessage" /></option>
                    <option value="1"><fmt:message code="sys.th.voice1" /></option>
                    <option value="8"><fmt:message code="sys.th.voice1" /></option>
                    <option value="2"><fmt:message code="url.th.laser" /></option>
                    <option value="3"><fmt:message code="url.th.Drops" /></option>
                    <option value="4"><fmt:message code="userDetails.th.MobilePhone" /></option>
                    <option value="5"><fmt:message code="depatement.th.Telephone" /></option>
                    <option value="6"><fmt:message code="sys.th.checken" /></option>
                    <option value="7">OICQ</option>
                    <option value="0"><fmt:message code="event.th.nothing" /></option>
                </select>
                <div align="right" id="sms_sound"></div>
            </td>
        </tr>
        <%--<tr> 登录后显示的左侧面板：
            <td nowrap class="TableData"><fmt:message code="user.th.delu" />：<span class='blue'>*</span></td>
            <td class="TableData">
                <select name="panel" class="">
                    <option value=""><fmt:message code="sys.th.pane" /></option>
                    <option value="1"><fmt:message code="url.th.Navigation" /></option>
                    <option value="2"><fmt:message code="global.lang.tissue" /></option>
                    <option value="3"><fmt:message code="url.th.MicroNews" /></option>
                    <option value="4"><fmt:message code="workflow.th.sousuo" /></option>
                </select>
                <fmt:message code="sys.th.login" />
            </td>
        </tr>--%>
        <%--<tr>
            <td nowrap class="TableData">考勤类型：</td>
            <td class="TableData">
                <select name="dutyType" class="">
                    <option value="">请选择考勤类型</option>
                </select>
            </td>
        </tr>--%>
        <tr>
            <td nowrap class="TableData" width="60"><fmt:message code="passWord" />：<span class='blue'>*</span></td>
            <td nowrap class="TableData">
                <input type="password" name="password" class="" size="20"  value=""   />
               <span class="passWordRuleSpan">8-20</span> <span class="mimaText"><fmt:message code="sys.th.zimu" /></span>
                <span>
                    <input type="checkbox" name="" id="check" style="    width: 16px;margin-left:10px">
                    <fmt:message code="userManagement.th.Emptypassword" />
                </span>
            </td>
        </tr>
        <%--<tr>
            <td nowrap class="TableData" width="60">确认密码：</td>
            <td nowrap class="TableData">
                <input type="password" name="password2" class="" size="20" maxlength="20" value="">
                8-20位，必须同时包含字母和数字
            </td>
        </tr>--%>
        <tr>
            <td nowrap class="TableData"><fmt:message code="user.th.InternalMailboxCapacity" />：</td>
            <td nowrap class="TableData">
                <input type="text" name="emailCapacity" class="" size="5" maxlength="11" value="">&nbsp;MB
                <fmt:message code="sys.th.xianzhi" />
            </td>
        </tr>
        <tr>
            <td nowrap class="TableData"><fmt:message code="url.th.PersonalCapacity" />：</td>
            <td nowrap class="TableData">
                <input type="text" name="folderCapacity" class="" size="5" maxlength="11" value="">&nbsp;MB
                <fmt:message code="sys.th.xianzhi" />
            </td>
        </tr>
        <tr style="display: none">
            <td nowrap class="TableData"><fmt:message code="user.th.inter" />：<span class='blue'>*</span></td>
            <td nowrap class="TableData">
                <select name="isWebmail" class="" >
                    <option value=""><fmt:message code="sys.th.jin" /></option>
                    <option value="0"><fmt:message code="user.th.AllowUse" /></option>
                    <option value="1"><fmt:message code="user.th.stopU" /></option>
                </select>&nbsp;
            </td>
        </tr>
        <tr id="internet1" style="display: none">
            <td nowrap class="TableData"><fmt:message code="user.th.Internet" />：<span class='blue'>*</span></td>
            <td nowrap class="TableData">
                <input type="text" name="webmailNum" class="" size="5" maxlength="11" value="">&nbsp;  <fmt:message code="sys.th.xianzhi" />
            </td>
        </tr>
        <tr id="internet2" style="display: none">
            <td nowrap class="TableData"><fmt:message code="user.th.PerMailbox" />：<span class='blue'>*</span></td>
            <td nowrap class="TableData">
                <input type="text" name="webmailCapacity" class="" size="5" maxlength="11" value="">&nbsp;MB
                <fmt:message code="sys.th.xianzhi" />
            </td>
        </tr>
        <tr style="display: none">
            <td nowrap class="TableData"><fmt:message code="user.th.InstantAccess" />：</td>
            <td nowrap class="TableData">
                <select name="imRange" class="">
                    <option value=""><fmt:message code="sys.th.jishi" /></option>
                    <option value="1"><fmt:message code="user.th.AllowUse" /></option>
                    <option value="2"><fmt:message code="user.th.stopU" /></option>
                </select>&nbsp;
            </td>
        </tr>
        <tr style="display: none">
            <td nowrap class="TableData"><fmt:message code="user.th.enablePOP3" />：</td>
            <td nowrap class="TableData">
                <select name="usePop3" class="">
                    <option value=""><fmt:message code="sys.th.pop3" /></option>
                    <option value="1"><fmt:message code="user.th.kjnf" /></option>
                    <option value="2"><fmt:message code="userManagement.th.AllowJinzhi" /></option>
                </select>&nbsp;
            </td>
        </tr>
        <tr style="display: none">
            <td nowrap class="TableData"><fmt:message code="user.th.MailEnable" />：</td>
            <td nowrap class="TableData">
                <select name="useEmail" class="">
                    <option value=""><fmt:message code="sys.th.email" /></option>
                    <option value="1"><fmt:message code="user.th.kjnf" /></option>
                    <option value="2"><fmt:message code="userManagement.th.AllowJinzhi" /></option>
                </select>&nbsp;
            </td>
        </tr>
        <tr>
            <td nowrap class="TableData"><fmt:message code="user.th.logn" />：</td>
            <td class="TableData">
                <select name="notLogin" class="">
                    <option value=""><fmt:message code="sys.th.chooseOa" /></option>
                    <option value="0"><fmt:message code="user.th.kjnf" /></option>
                    <option value="1"><fmt:message code="userManagement.th.AllowJinzhi" /></option>
                </select>&nbsp;
            </td>
        </tr>
        <tr>
            <td nowrap class="TableData"><fmt:message code="user.th.ghj" />：</td>
            <td class="TableData">
                <select name="notMobileLogin" class="">
                    <option value=""><fmt:message code="sys.th.loginPhone" /></option>
                    <option value="0"><fmt:message code="user.th.kjnf" /></option>
                    <option value="1"><fmt:message code="userManagement.th.AllowJinzhi" /></option>
                </select>&nbsp;
            </td>
        </tr>
        <tr>
            <td class="TableData" width="15%"><fmt:message code="url.th.contactListViewingPermissions" />：</td>
            <td class="TableData" width="70%" id="lookAdress">
            </td>
        </tr>
        <tr>
            <td nowrap="" class="TableData"><fmt:message code="user.th.BoundIPAddress" />：</td>
            <td nowrap="" class="TableData">
                <textarea name="bindIp" class="" cols="50" rows="2"></textarea><br>
                <fmt:message code="sys.th.kong" /><br><fmt:message code="sys.th.bang" /><br><fmt:message code="sys.th.biao" />
            </td>
        </tr>
        <tr>
            <td nowrap class="TableControl" colspan="2" align="center">
                <input type="button" value='<fmt:message code="netdisk.th.BatchSettings" />' class="subBtn">
                <font color='red'>&nbsp;&nbsp;<fmt:message code="sys.th.red" /></font>
            </td>
        </tr>

    </table>
</form>
<br>
<table border="0" width="95%" cellspacing="0" cellpadding="3" class="small">
    <tr>
        <td class="Big">
            <span class="big3"> <fmt:message code="user.th.sdf" /></span><br>
        </td>
    </tr>
</table>
<table class="TableList" width="95%" align="center" style="table-layout:fixed">
    <tr class="TableHeader">
        <td align="center"><fmt:message code="journal.th.user" /></td>
        <td align="center"><fmt:message code="email.th.time" /></td>
        <td align="center"><fmt:message code="journal.th.IPaddress" /></td>
        <td align="center"><fmt:message code="notice.th.type" /></td>
        <td align="center"><fmt:message code="journal.th.Remarks" /></td>
    </tr>

</table>


<script type="text/javascript">
    var priv_id;
    var dept_id;
    var user_id;
    var flag
    var data;
    function Evaluate(word) {
        var low =/^[0-9]*$/;
        var mid=/^[A-Za-z0-9]+$/
        var big=/[0-9a-zA-Z\._\$%&\*\!]/


//        var low = /^(?:\d+|[a-zA-Z]+|[,.:;!@#$%^&*]+)$/  //密码强度为弱 纯数字，纯字母，纯特殊字符
//        var mid = /^(?![^a-zA-Z]+$)(?!\D+$).*$/  //密码强度为中 字母+数字，字母+特殊字符，数字+特殊字符
//        var big = /^.*(?=.*)(?=.*\d)(?=.*[A-Za-z])(?=.*[,.:;!@#$%^&*? ]).*$/  //密码强度为强 字母+数字+特殊字符


        if(low.exec(word)){
            return 1;
        }else if(mid.exec(word)){
            return 2;
        }else if(big.exec(word)){
            return 3;
        }else {
            return 1;
        }
    }
    function ValidateInput(element, value) {
//验证密码

        var reg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{1,}$/

        if(flag == 1 && !reg.test(value)){
            $.layerMsg({content:'密码必须包含大写字母、小写字母和数字',icon:6})
            return;
        }else if(flag == 0 && Evaluate(value) != 2){
            $.layerMsg({content:'密码必须包含字母和数字',icon:6})
            return;
        }

        if (element == "password") {
            if (value.toString().length < start) {
                $.layerMsg({content:'您的密码不到'+start+'位',icon:6})
//                 alert("您的密码不到6位")
                return;
            }
        }


    }
    //选择分级机构下部门
    var classDept = '';
    //选择分级机构下角色
    var classHierarchicalPriv = '1';

    buildDeptTree();

    function buildDeptTree(){
        $.ajax({
            url: '/hierarchical/getClassifyOrgByAdmin',
            type: 'get',
            dataType: "JSON",
            data: '',
            success: function (obj) {
                buildChild(obj.obj);
            }
        })
    }

    function buildChild(data){
        data.forEach(function(v,i){
            if(v.child && v.child.length>0){
                classDept+=v.deptId+',';
            }
        });
    }

    $(function () {
        // 查询密码限制长度
        var passWordMin=6,passWordMax=20;
        var start="";
        var end="";
        $.ajax({
            url:"/user/getPwRule",
            type:"get",
            dataType: 'json',
            success:function (res) {
                if(res.flag){
                    var obj = res.object;
                    passWordMin = obj.secPassMin;
                    passWordMax = obj.secPassMax;
                    start = passWordMin;
                    end = passWordMax;
                    $('.passWordRuleSpan').html(passWordMin+"-"+passWordMax);
                }
            }
        });

        $.ajax({
            url:'/sysTasks/selectAll',
            dataType:'json',
            type:'get',
            success:function (res) {
                var data = res.obj;
                for(var i=0;i<data.length;i++){
                    if(data[i].paraName=='SEC_PASS_SAFE'){
                        if(data[i].paraValue == 0){
                            flag = 0
                            $('.passWordRuleSpan').next().html('')
                        }else if(data[i].paraValue == 1){
                            flag = 1
                            $('.passWordRuleSpan').next().html('<fmt:message code="sys.th.zimu" />')
                        }else if(data[i].paraValue == 2){
                            flag = 2
                            $('.passWordRuleSpan').next().html('<fmt:message code="sys.th.zimu2" />')
                        }else if(data[i].paraValue == 3){
                            flag = 3
                            $('.passWordRuleSpan').next().html('<fmt:message code="sys.th.zimu3" />')
                        }else if(data[i].paraValue == 4){
                            flag = 4
                            $('.passWordRuleSpan').next().html('<fmt:message code="sys.th.zimu4" />')
                        }
                    }
                }

            }
        })


        // 查询所有考勤类型
        $.ajax({
            url: "/attendSet/selsectAttendSet",
            type:'get',
            dataType:"JSON",
            success:function(data){
                var data = data.obj;
                var str='';
                for(var i=0;i<data.length;i++){
                    str+='<option value="'+data[i].sid+'">'+data[i].title+'</option>'
                }
                $('select[name="dutyType"]').append(str);
            }
        });

        // 获取角色信息控件
        $(".userPrivAdd").on("click",function(){
            priv_id="userPrivInput";
            $.popWindow("../common/selectPriv?0");
        });
        // 清空角色信息
        $('.userPrivClear').on("click",function () {
            $('#userPrivInput').attr("privid","");
            $('#userPrivInput').attr("userpriv","");
            $('#userPrivInput').val("");
        });

        // 获取角色信息控件
        $(".userPrivsAdd").on("click",function(){
            priv_id="userPrivsInput";
            $.popWindow("../common/selectPriv?allType=1");
        });
        // 清空角色信息
        $('.userPrivsClear').on("click",function () {
            $('#userPrivsInput').attr("privid","");
            $('#userPrivsInput').attr("userpriv","");
            $('#userPrivsInput').val("");
        });

        // 获取角色信息控件
        $(".userPrivmAdd").on("click",function(){
            priv_id="userPrivmInput";
            $.popWindow("../common/selectPriv");
        });
        // 清空角色信息
        $('.userPrivmClear').on("click",function () {
            $('#userPrivmInput').attr("privid","");
            $('#userPrivmInput').attr("userpriv","");
            $('#userPrivmInput').val("");
        });

        // 获取部门信息控件
        $(".deptAdd").on("click",function(){
            dept_id="deptInput";
            $.popWindow("../common/selectDept?allType=1");
        });
        // 清空信息
        $('.deptClear').on("click",function () {
            $('#deptInput').attr("deptid","");
            $('#deptInput').attr("deptno","");
            $('#deptInput').val("");
        });

        // 获取部门信息控件
        $(".postDeptAdd").on("click",function(){
            dept_id="postDeptInput";
            $.popWindow("../common/selectDept");
        });
        // 清空信息
        $('.postDeptClear').on("click",function () {
            $('#postDeptInput').attr("deptid","");
            $('#postDeptInput').attr("deptno","");
            $('#postDeptInput').val("");
        });

        // 获取人员信息控件
        $('.usersAdd').on("click",function(){
            user_id="usersInput";
            $.popWindow("../common/selectUser");
        });
        // 清空
        $('.usersClear').on("click",function(){
            $('#usersInput').attr("dataid","");
            $('#usersInput').attr("user_id","");
            $('#usersInput').val("");
        });

        // 获取部门信息
        $('.deptSelect').deptSelect(function (me) {
            $.get('/department/selectUnallocated', function(res){
                $(me).append('<option value="0"><fmt:message code="userManagement.th.Outgoing" /></option>')
                if (res.flag && res.msg != 'false'){
                    $(me).append('<option value="'+res.object.deptId+'">'+res.object.deptName+'</option>')
                }
            })
        });

        // 获取菜单信息
        $.get('/showMenu',function (res) {
            var menuList = res.obj;
            var str = '';
            for(var i=0;i<menuList.length;i++){
                str+='<option value='+menuList[i].id+'>'+menuList[i].name+'</option>';
            }
            $('#defultSelect').after(str);
        },'json');

        // 选择指定部门
        $('.postPrivSelect').on("change",function () {
            if($(this).val()==2){
                $('#postDeptTr').css('display','table-row')
            }else{
                $('#postDeptTr').css('display','none')
            }
        });

        $('select[name="isWebmail"]').on("change",function () {
            if($(this).val()==1){
                $('#internet1').css('display','none');
                $('#internet2').css('display','none');
                $('input[name="webmailNum"]').val("-1");
            }else{
                $('#internet1').css('display','table-row');
                $('#internet2').css('display','table-row');
                $('input[name="webmailNum"]').val("");
            }
        });

        $('.subBtn').on("click",function () {
            // 红色*号数据
            var deptIds =$('#deptInput').attr('deptid');
            var privIds= $('#userPrivsInput').attr('userpriv');
            var uids=$('#usersInput').attr('dataid');
            // 蓝色*号数据
            var userPriv = $('#userPrivInput').attr('userpriv').replace(/,/g,'');
            var deptId = $('select[name="deptId"] option:checked').val();
            var theme = $('select[name="theme"] option:checked').val();
            var menuType = $('select[name="menuType"] option:checked').val();
            var smsOn= $('select[name="smsOn"] option:checked').val();
            var panel = $('select[name="panel"] option:checked').val();
            var password =$('input[name="password"]').val();
            var webmailNum = $('[name="webmailNum"]').val();
            var webmailCapacity = $('[name="webmailCapacity"]').val();

            // 通信录权限
            var deptYj = "";
            var deptYj1 = $("input[name='deptYj']:checked").each(function (j) {
                if (j >= 0) {
                    deptYj += $(this).val() + ","
                }
            });

            var reg =/^[0-9]*$/; //数字
            var reg1=/^(?![^a-zA-Z]+$)(?!\D+$).{1,}$/  //字母和数字
            var reg2 = /^.*(?=.{1,})(?=.*\d)(?=.*[A-Za-z])(?=.*[,.:;!@#$%^&*? ]).*$/; //字母、数字、特殊字符
            var reg3 = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{1,}$/  //大写字母、小写字母、数字
            var reg4 = /^.*(?=.{1,})(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[,.:;!@#$%^&*? ]).*$/;  //大写字母、小写字母、数字、特殊字符
//                    var reg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{1,}$/;
            var values = $('input[name="password"]').val()
            if(values != '' && !$('#check').is(':checked')){
                if(flag == 0){
                    if(values.toString().length < start){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位',icon:6,time:3000})
                        return false;
                    }else if(values.toString().length > end){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位',icon:6,time:3000})
                        return false;
                    }
                }else if(flag == 1 ){
                    if(!reg1.test(values)){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字',icon:6,time:3000})
                        return false;
                    }else if(values.toString().length < start){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字',icon:6,time:3000})
                        return false;
                    }else if(values.toString().length > end){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字',icon:6,time:3000})
                        return false;
                    }
                }else if(flag == 2 ){
                    if(!reg2.test(values)){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字 和 特殊字符',icon:6,time:3000})
                        return false;
                    }else if(values.toString().length < start){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字 和 特殊字符',icon:6,time:3000})
                        return false;
                    }else if(values.toString().length > end){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字 和 特殊字符',icon:6,time:3000})
                        return false;
                    }
                }else if(flag == 3 ){
                    if(!reg3.test(values)){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字',icon:6,time:3000})
                        return false;
                    }else if(values.toString().length < start){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字',icon:6,time:3000})
                        return false;
                    }else if(values.toString().length > end){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字',icon:6,time:3000})
                        return false;
                    }
                }else if(flag == 4 ){
                    if(!reg4.test(values)){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符',icon:6,time:3000})
                        return false;
                    }else if(values.toString().length < start){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符',icon:6,time:3000})
                        return false;
                    }else if(values.toString().length > end){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符',icon:6,time:3000})
                        return false;
                    }
                }
            }
            if((deptIds!=undefined&&deptIds!="")||(privIds!=undefined&&privIds!="")||(uids!=undefined&&uids!="")){
                if((userPriv!=undefined&&userPriv!="")||(deptId!=undefined&&deptId!="-1")||(theme!=undefined&&theme!="")||(menuType!=undefined&&menuType!="")||(smsOn!=undefined&&smsOn!="")||(panel!=undefined&&panel!="")||(password!=undefined&&password!="")||(webmailNum!=undefined&&webmailNum!="")||(webmailCapacity!=undefined&&webmailCapacity!="")) {
                     if(!$('#check').is(':checked')){
                         var data = {
                            'deptIds': deptIds,
                            'privIds': privIds,
                            'uids': uids,
                            'postPriv': $('select[name="postPriv"] option:checked').val(),
                            'postDept': $('#postDeptInput').attr('deptid'),
                            'userPriv': userPriv,
                            'deptId': deptId,
                            'theme': theme,
                            'menuExpand': $('select[name="menuExpand"] option:checked').val(),
                            'bkground': $('select[name="bkground"] option:checked').val(),
                            'menuType': menuType,
                            'smsOn': smsOn,
                            'callSound': $('select[name="callSound"] option:checked').val(),
                            'panel': panel,
                            'dutyType': $('select[name="dutyType"] option:checked').val(),
                            // 'password': password,
                            'emailCapacity': $('input[name="emailCapacity"]').val(),
                            'folderCapacity': $('[name="folderCapacity"]').val(),
                            'webmailNum': webmailNum,
                            'webmailCapacity': webmailCapacity,
                            'imRange': $('select[name="imRange"] option:checked').val(),
                            'usePop3': $('select[name="usePop3"] option:checked').val(),
                            'useEmail': $('select[name="useEmail"] option:checked').val(),
                            'notLogin': $('select[name="notLogin"] option:checked').val(),
                            'notMobileLogin': $('select[name="notMobileLogin"] option:checked').val(),
                            'bindIp': $("textarea[name='bindIp']").val(),
                            'modulePrivIds': $('#userPrivmInput').attr('userpriv'),
                            'deptYj':deptYj
                         }
                     }else{
                         var data = {
                            'deptIds': deptIds,
                            'privIds': privIds,
                            'uids': uids,
                            'postPriv': $('select[name="postPriv"] option:checked').val(),
                            'postDept': $('#postDeptInput').attr('deptid'),
                            'userPriv': userPriv,
                            'deptId': deptId,
                            'theme': theme,
                            'menuExpand': $('select[name="menuExpand"] option:checked').val(),
                            'bkground': $('select[name="bkground"] option:checked').val(),
                            'menuType': menuType,
                            'smsOn': smsOn,
                            'callSound': $('select[name="callSound"] option:checked').val(),
                            'panel': panel,
                            'dutyType': $('select[name="dutyType"] option:checked').val(),
                            'emailCapacity': $('input[name="emailCapacity"]').val(),
                            'folderCapacity': $('[name="folderCapacity"]').val(),
                            'webmailNum': webmailNum,
                            'webmailCapacity': webmailCapacity,
                            'imRange': $('select[name="imRange"] option:checked').val(),
                            'usePop3': $('select[name="usePop3"] option:checked').val(),
                            'useEmail': $('select[name="useEmail"] option:checked').val(),
                            'notLogin': $('select[name="notLogin"] option:checked').val(),
                            'notMobileLogin': $('select[name="notMobileLogin"] option:checked').val(),
                            'bindIp': $("textarea[name='bindIp']").val(),
                            'modulePrivIds': $('#userPrivmInput').attr('userpriv'),
                            'deptYj':deptYj
                            // 'password': ""
                         }
                    }
                     if(password!=''&&password.length>0){
                         data["password"] = password;
                     }
                    $.ajax({
                        type: 'post',
                        url: '/user/editUserBatch',
                        dataType: 'json',
                        data: data,
                        success: function (rsp) {
                            if (rsp.flag == true) {
                                parent.layer.msg('<fmt:message code="sys.th.piSuccess" />',{icon:1});
                            } else {
                                parent.layer.msg('<fmt:message code="sys.th.piFile" />',{icon:2});
                            }
                        }
                    })
                }else{
                    parent.layer.msg('<fmt:message code="sys.th.blue" />',{icon:2});
                }
            }else{
                parent.layer.msg('<fmt:message code="sys.th.redDate" />',{icon:2});
            }


        })

        // 获取日志操作信息
        $.get('/sys/getTenBatchSetLog',function (res) {
            var logList = res.obj;
            var str = '';
            for(var i=0;i<logList.length;i++){
                str+='<tr><td>'+logList[i].userName+'</td>'
                    +'<td>'+logList[i].time+'</td>'
                    +'<td>'+logList[i].ip+'</td>'
                    +'<td>'+logList[i].typeName+'</td>'
                    +'<td title="' + logList[i].remark +'">'+logList[i].remark+'</td><tr>'
            }
            $('.TableHeader').after(str);
        },'json');

        // 获取通讯录权限选项
        $.ajax({
            url: "/department/getDepartmentYj",
            type: "get",
            dataType: "json",
            success: function (res) {
                var str = '<label style="margin-right: 10px;"><input type="checkbox" class="checkAll" value="">全选</input></label>';
                if (res.flag) {
                    var data = res.obj;
                    for (var i = 0; i < data.length; i++) {
                        str += '<label style="margin-right: 10px;"><input name="deptYj" class="checkChild" type="checkbox" value="' + data[i].deptId + '">' + data[i].deptName + '</input></label>'
                    }
                    $("#lookAdress").append(str)
                }
            }
        });
        $('body').on('click', '.checkAll', function () {
            if ($(this).is(':checked')) {
                $('.checkChild').prop('checked', true)
            } else {
                $('.checkChild').prop('checked', false)
            }
        });
    });
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
            var data=res.object[0]
            if (data.paraValue!=0){
                $('#Confidential').append('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </span>')
            }
        }
    })
</script>
</body>
</html>
