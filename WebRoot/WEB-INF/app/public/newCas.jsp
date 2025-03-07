<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
    <link rel="stylesheet" type="text/css" href="../lib/laydate/skins/default/laydate.css"/>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" type="text/css" href="../../css/dept/deptManagement.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/dept/new_news.css"/>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <title>单点登录配置</title>
    <style>

        #search{
            margin-left: 360px;
            font-size: 16px;
        }
        #export{
            font-size: 16px;
        }
        .newNew tr td{
            border:none;
        }
        .newNew .tableHead tr td{
            border:1px solid #c0c0c0;
        }
        .ban{
            width: 80px;
            height: 28px;
            padding-left: 10px;
        }
        .left{
            float:left;
        }
        .new_but{
            width:130px;
            background:#2F8AE3;
            height: 28px;
            line-height: 28px;
            border-radius: 4px;
            margin-left: 0px;
            padding-left: 4px;
            cursor: pointer;
            color:#fff;
        }
        .close_but{
            width:50px;
            height: 37px;
            margin-left:0px;
            line-height: 28px;
            border-radius: 4px;
            padding-left: 4px;
            cursor: pointer;
            /*color:#fff;*/
        }
        .box{
            width:300px;
            height:150px;
            text-align:center;
            font-size:20px;
            color:#fff;
            background:#2F8AE3;
            margin:0 auto;
            line-height:150px;
        }
        .success{
            text-align:center;
            display:none;
        }
        .box{
            margin-bottom:30px;
        }
        .success span{
            width: 132px;
            height: 35px;
            background-color: rgba(224, 224, 224, 0.61);
            font-size: 16px;
            border-radius: 5px;
            padding-left:8px;
            cursor:pointer;

            line-height: 30px;
            display: inline-block;
        }
        #clearSave{
            background:url(../../img/vote/clearsave.png) no-repeat;
            background-size: 181px;
            color:#fff;
            width:181px;
            font-size:16px;
            height:30px;
            cursor: pointer;
            line-height:30px;
            padding-left: 22px;
        }
        #save{
            background:url(../../img/vote/saveBlue.png) no-repeat;
            color:#fff;
            line-height:30px;
            font-size:16px;
            width:91px;
            height: 30px;
            cursor: pointer;
            padding-left: 11px;

        }
        #refull{
            color:#000;
            width: 87px;
            line-height:30px;
            height: 30px;
            cursor: pointer;
            font-size:16px;
            background: url("../../img/vote/new.png") no-repeat;
            padding-left: 12px;

        }
        #addItem,#addChild{
            background:url(../../img/vote/save.png) no-repeat;
            color:#fff;
            width: 142px;
        }
        #addChild{
            background:url(../../img/vote/save.png) no-repeat;
            color:#fff;
        }

        #back {
            display: inline-block;
            width: 78px;
            height: 38px;
            line-height: 30px;
            cursor: pointer;
            border-radius: 3px;
            background: url(../../img/edu/eduSchoolCalendar/back.png) no-repeat;
            padding-left: 7px;
            font-size: 14px;
        }
        .laydate-footer-btns{
            position: absolute;
            right: 69px;
            top: 10px;
        }
        .layui-laydate-content{
            margin-left: 33px;
        }
        table tbody tr td{
            font-size: 11pt !important;
        }
        .header {
            height: 43px;
            border-bottom: 1px solid #9E9E9E;
            overflow: hidden;
            margin-bottom: 10px;
            position: fixed;
            top: 0px;
            width: 100%;
            background-color: #fff;
            z-index: 1099;
        }
        .nav li {
            height: 33px;
            line-height: 32px;
            float: left;
            font-size: 14px;
            margin-left: 20px;
            margin-top: 6px;
            cursor: pointer;
        }
        .select {
            background-color: #2F8AE3;
            color: #fff;
            border-radius: 20px;
            -webkit-border-radius: 20px;
            -moz-border-radius: 20px;
            -o-border-radius: 20px;
            -ms-border-radius: 20px;
        }
        .pad {
            padding: 6px 14px;
            line-height: 28px;
        }
        .space {
            width: 2px;
            margin-left: 16px;
        }
        #save2 {
            background: url(../../img/vote/saveBlue.png) no-repeat;
            color: #fff;
            line-height: 30px;
            font-size: 16px;
            width: 91px;
            height: 30px;
            cursor: pointer;
            padding-left: 11px;
        }
    </style>
</head>
<body style="overflow:scroll;overflow-y: auto;overflow-x:hidden;">

<%--学生信息列表--%>

<div class="step1" style="display: block;margin-left: 10px;">
    <div class="header">
        <ul class="nav">
            <li data-type="0" class="select"><span class="pad">CAS单点登录设置</span></li>
            <li><img class="space" src="../../img/twoth.png" alt=""></li>
            <li data-type="1" ><span  class="pad">域登录设置</span></li>
        </ul>
    </div>
    <div class="dandianLogin">
        <div class="nav_box clearfix" style="margin-top: 50px;">
            <%--<div class="nav_t1"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/xinjiantoupiao.png"></div>--%>
            <div class="nav_t2" class="news">CAS单点登录配置</div>
        </div>
        <table class="newNews">
            <tbody>
            <tr>
                <td class="blue_text">
                    启用CAS单点登录:
                </td>
                <td>
                    <select class="td_title1" style="box-sizing: border-box;" id="casStatus" name="casStatus">
                        <option value="0" selected>关闭</option>
                        <option value="1">开启</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="ttd_w blue_tex">
                    单点名称：
                </td>
                <td>
                    <span class="required" style="color: red">*</span>
                    <input class="td_title1" type="text" placeholder="" id="casName"/>
                </td>
            </tr>
            <tr>
                <td class="td_w blue_text">
                    CAS服务器地址：
                </td>
                <td>
                    <span class="required" style="color: red">*</span>
                    <input class="td_title1" type="text" placeholder="" id="casAddress"/>
                </td>
            </tr>

            <tr>
                <td class="td_w blue_text">
                    OA单点登录接口地址：
                </td>
                <td>
                    <span class="required" style="color: red">*</span>
                    <input class="td_title1" type="text" placeholder="" id="casInterface" value="xoaCas/login"/>
                </td>
            </tr>


            <tr>
                <td class="blue_text">
                    默认登录组织：
                </td>
                <td>
                    <select class="td_title1" style="box-sizing: border-box;" id="departs" name="departs">

                    </select>
                </td>
            </tr>
            </tbody>

            <tr>
                <td class="td_w blue_text">
                    最近一次操作时间：
                </td>
                <td>
                    <input class="td_title1" style="background: #e3e2e2" type="text" placeholder="" id="casTime" disabled/>
                </td>
            </tr>
            <tr>
                <td class="td_w blue_text">
                    最近一次操作人员：
                </td>
                <td>
                    <input class="td_title1" style="background: #e3e2e2" type="text" placeholder="" id="casUser" disabled/>
                </td>
            </tr>

            <div>
                <tr style="text-align:center">
                    <td colspan="2">
                        <button type="button" class="close_but" id="save"><fmt:message code="global.lang.save" /></button>
                    </td>
                </tr>
            </div>
        </table>
    </div>
    <div class="yuLogin" style="display: none">
        <div class="nav_box clearfix" style="margin-top: 50px;">
            <div class="nav_t2" class="news">域登录设置</div>
        </div>
        <table class="newNews">
            <tbody>
            <tr>
                <td class="blue_text">
                    启用域登录：
                </td>
                <td>
                    <select class="td_title1" style="box-sizing: border-box;" id="yuStatus" name="">
                        <option value="0" selected>关闭</option>
                        <option value="1">开启</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="ttd_w blue_text">
                    域名称：
                </td>
                <td>
                    <span class="required" >如：domain.8oa.cn</span>
                    <input class="td_title1" type="text" placeholder="" id="domainName"/>
                </td>
            </tr>
            <tr>
                <td class="td_w blue_text">
                    域控制器地址：
                </td>
                <td>
                    <span class="required" > 如：192.168.0.10</span>
                    <input class="td_title1" type="text" placeholder="" id="domainControllers"/>
                </td>
            </tr>

            <tr>
                <td class="td_w blue_text">
                    域管理员账号：
                </td>
                <td>
                    <input class="td_title1" type="text" placeholder="" id="adUser" value=""/>
                </td>
            </tr>


            <tr>
                <td class="blue_text">
                    域管理员密码：
                </td>
                <td>
                    <input class="td_title1" type="text" placeholder="" id="adPwd" value=""/>
                </td>
            </tr>
            </tbody>

            <tr>
                <td class="td_w blue_text">
                    其他属性：
                </td>
                <td>
                    <input type="checkbox" name="" id="disabled" value="1">
                    <label class="" style="display: inline-block;">同步被禁用的域用户</label>
                </td>
            </tr>
            <tr>
                <td class="td_w blue_text">
                    角色：
                </td>
                <td>
                    <select id="userPriv">

                    </select>
                </td>
            </tr>
            <tr>
                <td class="td_w blue_text">
                    默认密码：
                </td>
                <td>
                    <input class="td_title1" type="text" placeholder="" id="userPwd" value=""/>
                </td>
            </tr>
            <tr>
                <td class="blue_text">
                    是否允许登录OA系统：
                </td>
                <td>
                    <select class="td_title1" style="box-sizing: border-box;" id="notLogin" name="">
                        <option value="0" selected>允许</option>
                        <option value="1">禁止</option>
                    </select>
                </td>
            </tr>

            <div>
                <tr style="text-align:center">
                    <td colspan="2">
                        <button type="button" class="close_but" id="save2"><fmt:message code="global.lang.save" /></button>
                    </td>
                </tr>
            </div>
        </table>
    </div>
</div>

</body>

<script type="text/javascript">
    $('.header li').click(function () {
        $(this).siblings('li').removeClass('select')
        $(this).addClass('select')
        if($(this).attr('data-type')=='0'){
            $('.dandianLogin').show();
            $('.yuLogin').hide();
        }else if($(this).attr('data-type')=='1'){
            $('.dandianLogin').hide();
            $('.yuLogin').show();
        }
    })
    //组织选择
    departmentAll();
    function departmentAll() {
        $.ajax({
            type: 'get',
            url: '/getCompanyAll',
            dataType: 'json',
            success: function (res) {
                var data = res.obj;
                var str = '';
                for (var i = 0; i < data.length; i++) {
                    str += '<option value="' + data[i].oid + '">' + data[i].name + '</option>';
                }
                $('select[name="departs"]').append(str);
            }
        })
    }
    //角色选择
    privAll();
    function privAll() {
        $.ajax({
            type: 'get',
            url: '/userPriv/getAllPriv',
            dataType: 'json',
            success: function (res) {
                var data = res.obj;
                var str = '';
                for (var i = 0; i < data.length; i++) {
                    str += '<option value="' + data[i].userPriv + '">' + data[i].privName + '</option>';
                }
                $('#userPriv').append(str);
            }
        })
    }
    $(function () {
        //回显
        showCas();
        //保存
        function save(){
            var $required=$(".required").next();
            for(var i=0;i<$required.length;i++){
                var required=$required.eq(i).val();
                if(required==undefined||required.trim().length==0){
                    layer.msg('带红色*号为必填',{time:1500,icon:2},function () {
                    });
                    return false;
                }
            }
            var data={
                casName:$("#casName").val(),
                casAddress:$("#casAddress").val(),
                casLoginOrg:$("#departs").val(),
                casInterface:$('#casInterface').val(),
                casStatus:$('#casStatus').val()
            };
            $.ajax({
                type: 'post',
                url: '/xoaCas/saveCas',
                dataType: 'json',
                data: data,
                success: function (res) {
                    if(res.flag){
                        layer.msg(res.msg,{time:1000,icon:1},function () {
                            //刷新
                            window.location.reload();
                        });
                    }else{
                        layer.msg(res.msg,{time:1500,icon:1});
                    }

                }
            })


        }

        function showCas(){
            $.ajax({
                type: 'post',
                url: '/xoaCas/showCas',
                dataType: 'json',
                success: function (res) {
                    if(res.flag){
                        var o=res.object;
                        if(o!=undefined){
                            $("#casName").val(o.casName);
                            $("#casAddress").val(o.casAddress);
                            $("#departs").val(o.casLoginOrg);
                            $("#casTime").val(o.casTimeStr);
                            $("#casUser").val(o.casUser);
                            $('#casInterface').val(o.casInterface);
                            $('#casStatus').val(o.casStatus)
                        }
                    }
                }
            })
        }

        $('#save').click(function () {
            save();
        });
        // 域登录保存
        $('#save2').click(function () {
            if($('#disabled').is(":checked")){
                var disabeld = 1
            }else{
                var disabeld = 0
            }
            var arr = {
                    domainName: $('#domainName').val(),
                    domainControllers: $('#domainControllers').val(),
                    adUser: $('#adUser').val(),
                    adPwd: $('#adPwd').val(),
                    disabled: disabeld,
                    userPriv: $('#userPriv').val(),
                    notLogin: $('#notLogin').val(),
                    userPwd:$('#userPwd').val(),
                }
            var data={
                status: $("#yuStatus").val(),
                config: JSON.stringify(arr)
            };
            $.ajax({
                type: 'post',
                url: '/ad/configAdServer',
                dataType: 'json',
                data: data,
                success: function (res) {
                    if(res.flag){
                        layer.msg('保存成功',{time:1000,icon:1},function () {
                        });
                    }else{
                        layer.msg('保存失败',{time:1500,icon:1});
                    }

                }
            })
        });
        //域登录回显
        showAd()
        function showAd(){
            $.ajax({
                type: 'post',
                url: '/ad/queryAdServer',
                dataType: 'json',
                success: function (res) {
                    if(res.flag){
                        var obj = res.datas;
                        if(obj != undefined){
                            var para = $.parseJSON(obj[0].paraValue);
                            $("#domainName").val(para.domainName);
                            $("#domainControllers").val(para.domainControllers);
                            $("#adUser").val(para.adUser);
                            $("#adPwd").val(para.adPwd);
                            $("#notLogin").val(para.notLogin);
                            $('#userPwd').val(para.userPwd);
                            if(para.disabled == '1'){
                                $('#disabled').prop('checked',true)
                            }else{
                                $('#disabled').prop('checked',false)
                            }
                            $.ajax({
                                type: 'get',
                                url: '/userPriv/getAllPriv',
                                dataType: 'json',
                                success: function (res) {
                                    $('#userPriv').html('');
                                    var data = res.obj;
                                    var str = '';
                                    for (var i = 0; i < data.length; i++) {
                                        str += '<option value="' + data[i].userPriv + '">' + data[i].privName + '</option>';
                                    }
                                    $('#userPriv').append(str);
                                    var all_select = $('#userPriv option');
                                    for(var i=0;i<all_select.length;i++){
                                        var svalue=all_select[i].value;
                                        if(para.userPriv == svalue){
                                            $("#userPriv option[value='"+svalue+"']").attr("selected","selected");
                                        }
                                    }
                                }
                            })
                            $("#yuStatus").val(obj[1].paraValue);
                        }
                    }
                }
            })
        }
    });



</script>
</html>
