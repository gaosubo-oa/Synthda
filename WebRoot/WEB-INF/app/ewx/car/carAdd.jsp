<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String corpId = (String)request.getAttribute("corpId");
    String corpSecret = (String)request.getAttribute("corpSecret");
%>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>车辆申请新建</title>
    <link rel="stylesheet" href="../../css/email/m/jquery.mobile.css" />
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>

    <link rel="stylesheet" href="../../css/email/m/styles.css" />
    <link rel="stylesheet" href="../../css/email/m/style.css">
    <link rel="stylesheet" href="../../css/email/m/mail.css">
    <script type="text/javascript" src="../../js/notes/jquery-2.1.2.min.js" ></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <%--<script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>--%>
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <script type="text/javascript" src="../../js/diary/m/simbaJs.js" ></script>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/base.js?20190927.1"></script>


    <link rel="stylesheet" href="../../lib/mui/mui/mui.picker.min.css" />
    <script type="text/javascript" src="../../lib/mui/mui/mui.picker.min.js" ></script>
    <style>
        #header h1{
            color: #fff;
        }
        .navc{
            background-color: #00a0e9;
            color: #fff;
            border-radius: 10px;
        }
        .mui-content {
            height: calc(100% - 45px);
            background: #fff;
        }
        .mui-input-row span{
            /*float: right;*/
            line-height: 40px;
        }
        .mui-bar-nav~.mui-content {
            height: 100%;
            background: #fff;
            overflow: auto;
        }
        .mui-bar{
            height: 100px;
        }
        .must{
            color: red;
        }
        .mui-input-row label {
            padding-left: 0;
            font-family: 'microsoft yahei';
            width: 96px;
            font-size: 13px;
        }
        .nav span{
            width: 48%;
            display: inline-block;
            text-align: center;
        }
        .navc{
            background-color: #00a0e9;
            color: #fff;
            border-radius: 10px;
        }

        .result,.result1{
            color:#00a0e9;
            padding-left: 17px;
        }
        .mui-input-row label{
            padding-left: 0;
            font-family:'microsoft yahei';
            width: 96px;
        }
        .mui-input-row label~input{
            float: left;
            padding: 10px 0;
            width: calc(100% - 120px);
        }
        #forms label,#forms1 label,#forms3 label,#forms4 label{
            width: 400px;
        }
        #forms , #forms1 ,#forms3 ,#forms4{
            margin-top: 100px;
        }

        .mui-content {
            height: 100%;
            background: #fff;
            overflow: auto;
        }
        .radio_inline label{
            width: 20%;
            padding-left: 40px;
            padding-right: 40px;
        }
        .radio_inline input[type=radio]{
            width: 15%;
            right:auto;
        }
        .sure{
            width: 60px;
            height: 30px;
            margin-bottom: 20px;
            margin-top: 12px;
        }
    </style>
</head>

<body data-role="page">
<div class="mui-content" id="aaa" style="overflow: auto;">
    <ul>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left" style="margin-top: .9rem">
            <span class="must">*</span>车牌号：</label>
            <select  name="vId" id="vId" class="test_null" style=" margin-top: 1.7rem;font-size: 15px;">
                <option value="">请选择</option>
            </select>
        </li>
        <li class="mui-table-view-cell mui-input-row">
            <label class="mui-left" style="padding:11px 0px;margin-top: .2rem;">用车部门：</label>
            <input type="text" placeholder="选择用车部门" id="cname"  value="" class="mui-input-clear" />
            <input value="" type="hidden" id="copyreciever"/>
            <span id="Popover_1" class='mui-icon mui-icon-plus'></span>
        </li>
        <li class="mui-table-view-cell mui-input-row">
            <label class="mui-left" style="margin-top: .7rem;">用车人：</label>
            <input type="text" placeholder="选择用车人" style="margin-top: 10px;"  value="" id="tname"/>
            <input value="" type="hidden" id="reciever"/>
            <span id="Popover_0" class='mui-icon mui-icon-plus'  style="margin-top: 8px;" ></span>
        </li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left" style="margin-top: 1.2rem;">跟随人员：</label>
            <input type="text" placeholder="选择跟随人员" style="margin-top: 17px;" value="" class="mui-input-clear attendee" id="inName" />
            <input value="" type="hidden" id="Inreciever"/>
            <span id="Popover_2" class='mui-icon mui-icon-plus' style="margin-top: 17px;" ></span>
        </li>
        <li class="mui-table-view-cell mui-input-row" id="demo"><span class="must">*</span>开始时间：<span class="result test_nullSpan name='vuStart'" id="beginTime">选择时间</span></li>
        <li class="mui-table-view-cell mui-input-row"id="demo1"><span class="must">*</span>结束时间：<span class="result1 test_nullSpan 'vuEnd'" id="endTime">选择时间</span></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left" style="margin-top: .8rem">目的地：</label>
            <input type="text" placeholder="请输入目的地" name="vuDestination" class="mui-input-clear vuDestination " style="margin-top: 10px;" value="" />
        </li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left" style="margin-top: .8rem">里程：</label>
            <input type="text" placeholder="请输入里程" name="vuMileage"oninput = "value=value.replace(/[^\d]/g,'')" class="mui-input-clear meetName " style="margin-top: 10px;" value="" />
        </li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left" style="margin-top: .8rem;width:99px"><span class="must">*</span>部门审批人：</label>
            <input type="text" placeholder="选择部门审批人" name="deptManager" value=""  class="mui-input-clear equipmentId test_null"   id="equipmentName" style="margin-top: 0.6rem;width:50%"/>
            <input value="" type="hidden" id="equipment"/>
            <span id="Popover_3" class='mui-icon mui-icon-plus' style="margin-top: 0.6rem;"></span></li>
        <li class="mui-table-view-cell mui-input-row">
            <label class="mui-left" style="margin-top: .8rem"><span class="must">*</span>调度员：</label>
            <select name="vuOperator" id="vuOperator" class="test_null" style=" margin-top: 1.7rem;font-size: 15px;">
                <option value="">请选择</option>
            </select>
        </li>
    </ul>

    <label class="mui-left" style="margin-left: 1.5rem;">事由：</label>
    <textarea name="vuReason" class="meetDesc vuReason" placeholder="输入事由" style="padding: 6px 0 0 6px;width: 70%;height: 10%;margin-left: 5%;vertical-align: middle;margin-top: 10px;"></textarea>

    <label class="mui-left" style="margin-left: 1.5rem;">备注：</label>
    <textarea name="vuRemark" class="meetDesc vuRemark" placeholder="输入备注" style="padding: 6px 0 0 6px;width: 70%;height: 10%;vertical-align: middle;margin-left: 5%;margin-top: 10px;"></textarea>
    <div class="mui-button-row">
        <button type="button" class=" mui-btn-primary sure" id="add" >确认</button>
    </div>
</div>

<%--选择用车人--%>
<div class="mui-content" style="display: none" id="ccc">
    <div class="mui-bar mui-bar-nav" id="headerApply">
        <a class="mui-icon mui-icon-close mui-pull-left" href="#modal1" id="app"></a>
        <h1 class="mui-title">选择人员</h1>
        <a class="mui-btn-link mui-pull-right" id="re_mailApply">确认</a>
        <div style="margin-top: 45px;">
            <span>姓名</span>
            <input type="text" name="userName" style="width: 73%;height: 36px;border-radius: 10px">
            <button type="button" class="mui-btn mui-btn-primary username" style="vertical-align: text-bottom;border-radius: 10px">搜索</button>
        </div>
    </div>
    <div  style="height: 100%;">
        <div id="forms">

        </div>
    </div>
</div>
<%--选择用车部门--%>
<div class="mui-content"  style="display: none" id="bbb">
    <div class="mui-bar mui-bar-nav" id="header1" style="height: 100px;">
        <a class="mui-icon mui-icon-close mui-pull-left" href="#modal1"  id="app1"></a>
        <h1 class="mui-title">选择用车部门</h1>
        <a class="mui-btn-link mui-pull-right" id="re_mail1">确认</a>
        <div style="margin-top: 45px;">
            <span>部门名称</span>
            <input type="text" name="deptName" style="width: 60%;height: 36px;border-radius: 10px">
            <button type="button" class="mui-btn mui-btn-primary deptSeach" style="vertical-align: text-bottom;border-radius: 10px">搜索</button>
        </div>
    </div>
    <div  style="height: 100%;">
        <div id="forms1" style="margin-top: 100px">

        </div>
    </div>
</div>
<%--跟随人员--%>
<div class="mui-content"  style="display: none" id="ddd">
    <div class="mui-bar mui-bar-nav" id="header3">
        <a class="mui-icon mui-icon-close mui-pull-left" href="#modal1"  id="app3"></a>
        <h1 class="mui-title">选择人员</h1>
        <a class="mui-btn-link mui-pull-right" id="re_mail3">确认</a>
        <div style="margin-top: 45px;">
            <span>姓名</span>
            <input type="text" name="username" style="width: 73%;height: 36px;border-radius: 10px" class="c">
            <button type="button" class="mui-btn mui-btn-primary userNames" style="vertical-align: text-bottom;border-radius: 10px">搜索</button>
        </div>
    </div>
    <div  style="height: 100%;">
        <div id="forms3">

        </div>
    </div>
</div>
<%--部门审批人---%>
<div class="mui-content"  style="display: none" id="eee">
    <div class="mui-bar mui-bar-nav" id="header4">
        <a class="mui-icon mui-icon-close mui-pull-left" href="#modal1"  id="app4"></a>
        <h1 class="mui-title">选择部门审批人</h1>
        <a class="mui-btn-link mui-pull-right" id="re_mail4">确认</a>
        <div style="margin-top: 45px;">
            <span>姓名</span>
            <input type="text" name="user" style="width: 73%;height: 36px;border-radius: 10px">
            <button type="button" class="mui-btn mui-btn-primary user" style="vertical-align: text-bottom;border-radius: 10px">搜索</button>
        </div>
    </div>
    <div  style="height: 100%;">
        <div id="forms4">

        </div>
    </div>
</div>

<script>
    var con=''
    var conid
    //车牌号
    $.ajax({
        type:'post',
        url:'/veHicle/getDropDownBox',
        dataType:'json',
        success:function(result){
            var data =result.obj;
            var str="<option value=''><fmt:message  code="hr.th.PleaseSelect"/></option>";
            if(data.length>0){
                for(var i=0;i<data.length;i++){
                    str=str+ '<option value="' + data[i].vId + '">' + data[i].vNum + '</option>'
                }
            }
            $('#vId').html(str);
        }
    })
    //调度员
    $.ajax({
        url: '/syspara/getOperator',
        type: 'get',
        dataType: 'json',
        data: {
            paraName:"OPERATOR_NAME"
        },
        success: function (obj) {
            var data=obj.object;
            var str="<option value=''><fmt:message  code="hr.th.PleaseSelect"/></option>";
            if(data!=null){
                for(var i=0;i<data.eduUserList.length;i++){
                    str+='<option value="'+data.eduUserList[i].userId+'">'+data.eduUserList[i].userName+'</option>';
                }
            }
            var managerNameArray=data.userName.split(",");
            $("#vuOperator").html(str);
        }
    });
    //用车人
    $('#tname,#Popover_0').on('tap', function() {
        document.activeElement.blur();
        var bt111 = document.getElementById("aaa");
        var bt = document.getElementById("ccc");
        bt111.style.display= "none";
        bt.style.display= "block";
        var deptId = "";
        if($('#cname').attr("deptid")!=undefined){
            deptId = $('#cname').attr("deptid")
        }
        mui.ajax('/user/getAlluser', {
            dataType: 'json',//服务器返回json格式数据
            type: 'get',//HTTP请求类型
            data:{
                notLogin:0,
                deptId:deptId
            },
            success: function (data) {
                //服务器返回响应，根据响应结果，分析是否登录成功；
                if (data.flag) {
                    var str='';
                    var arr=data.obj
                    for(var i=0;i<arr.length;i++){
                        str+='<div class="mui-input-row  mui-radio mui-left">'+
                            '<label style="line-height: 34px">'+arr[i].userName+'</label>'+
                            '<input style="width: 70px;height: 70px;" class="checkbox1" name="checkbox1" value="'+arr[i].userName+'" type="radio" ids="'+arr[i].userId+'">'+
                            '</div>'
                    }

                }

                $("#forms")[0].innerHTML = str;
            }
        });
        $('.username').on('tap', function() {
            mui.ajax('/user/getAlluser', {
                dataType: 'json',//服务器返回json格式数据
                type: 'get',//HTTP请求类型
                data:{
                    notLogin:0,
                    userName:$('input[name="userName"]').val(),
                    deptId: $('#cname').attr("deptid")
                },
                success: function (data) {
                    console.log(data)
                    // 服务器返回响应，根据响应结果，分析是否登录成功；
                    if (data.flag) {
                        var str='';
                        var arr=data.obj
                        for(var i=0;i<arr.length;i++){
                            str+='<div class="mui-input-row  mui-radio mui-left">'+
                                '<label style="line-height: 34px">'+arr[i].userName+'</label>'+
                                '<input style="width: 70px;height: 70px;" class="checkbox1" name="checkbox1" value="'+arr[i].userName+'" type="radio" ids="'+arr[i].userId+'">'+
                                '</div>'
                        }

                    }
                    $("#forms")[0].innerHTML = str;
                }
            });
            $('input[name="userName"]').val('')
        })

        mui("#headerApply").on('tap', '#re_mailApply', function () {
            var rdsObj   = document.getElementsByClassName('checkbox1');
            var checkVal = new Array();
            var k        = 0;
            for(i = 0; i < rdsObj.length; i++){
                if(rdsObj[i].checked){
                    checkVal[k] = rdsObj[i].value;
                    // k++;
                }
            }

            var rdsObj   = document.getElementsByClassName('checkbox1');
            checkVals = new Array();

            var k = 0;
            for(i = 0; i < rdsObj.length; i++){
                if(rdsObj[i].checked){
                    checkVals[k] = rdsObj[i].getAttribute('ids');
                    // k++;
                }
            }
            bt111.style.display= "block";
            bt.style.display= "none";
            // header.style.display= "block";
            document.getElementById("tname").setAttribute('value',checkVal);
            document.getElementById("tname").setAttribute('ids',checkVals);
        });
    });
    $('#app').click(function(){
        // var header = document.getElementById("header");
        var bt111 = document.getElementById("aaa");
        var bt = document.getElementById("ccc");
        bt111.style.display= "block";
        // header.style.display= "block";
        bt.style.display= "none";
    })
    $("#tname,#Popover_0").focus(function(){
        document.activeElement.blur();
    });

        //用车部门
    $('#cname,#Popover_1').on('tap', function() {
        document.activeElement.blur();
        var bt111 = document.getElementById("aaa");
        var bt = document.getElementById("bbb");
        bt111.style.display= "none";
        // header.style.display= "none";
        bt.style.display= "block";
        mui.ajax('/department/getAlldept', {
            dataType: 'json',//服务器返回json格式数据
            type: 'get',//HTTP请求类型
            success: function (data) {
                //服务器返回响应，根据响应结果，分析是否登录成功；
                if (data.flag) {
                    var str='';
                    var arr=data.obj
                    for(var i=0;i<arr.length;i++){
                        str+='<div class="mui-input-row mui-radio mui-left">'+
                            '<label style="line-height: 34px">'+arr[i].deptName+'</label>'+
                            '<input style="width: 70px;height: 70px;" class="checkbox2" name="checkbox2" value="'+arr[i].deptName+'" type="radio" deptId="'+arr[i].deptId+'">'+
                            '</div>'
                    }
                }

                $("#forms1")[0].innerHTML = str;
            }
        });
        $('.deptSeach').on('tap', function() {
            mui.ajax('/department/selByLikeDeptName', {
                dataType: 'json',//服务器返回json格式数据
                type: 'get',//HTTP请求类型
                data:{
                    deptName:$('input[name="deptName"]').val()
                },
                success: function (data) {
                    //服务器返回响应，根据响应结果，分析是否登录成功；
                    if (data.flag) {
                        var str='';
                        var arr=data.obj
                        for(var i=0;i<arr.length;i++){
                            str+='<div class="mui-input-row mui-radio mui-left">'+
                                '<label style="line-height: 34px">'+arr[i].deptName+'</label>'+
                                '<input style="width: 70px;height: 70px;" class="checkbox2" name="checkbox2" value="'+arr[i].deptName+'" type="radio" deptId="'+arr[i].deptId+'">'+
                                '</div>'
                        }
                    }

                    $("#forms1")[0].innerHTML = str;
                }
            });
        })
        mui("#header1").on('tap', '#re_mail1', function () {

            var rdsObj   = document.getElementsByClassName('checkbox2');
            var checkVal = new Array();
            var k        = 0;
            for(i = 0; i < rdsObj.length; i++){
                if(rdsObj[i].checked){
                    checkVal[k] = rdsObj[i].value;
                    k++;
                }
            }
            var rdsObj   = document.getElementsByClassName('checkbox2');
            checkVals1 = new Array();
            var k = 0;
            for(i = 0; i < rdsObj.length; i++){
                if(rdsObj[i].checked){
                    checkVals1[k] = rdsObj[i].getAttribute('deptId');
                    k++;
                }
            }


            bt111.style.display= "block";
            bt.style.display= "none";
            // header.style.display= "block";
            document.getElementById("cname").setAttribute('value',checkVal);
            document.getElementById("cname").setAttribute('deptId',checkVals1);
        });
    });
    $('#app1').click(function(){
        var bt111 = document.getElementById("aaa");
        var bt = document.getElementById("bbb");
        bt111.style.display= "block";
        // header.style.display= "block";
        bt.style.display= "none";

    })
    $("#cname,#Popover_1").focus(function(){
        document.activeElement.blur();
    });

    // 跟随人员
    $('#inName,#Popover_2').on('tap', function() {
        document.activeElement.blur();
        var bt111 = document.getElementById("aaa");
        var bt = document.getElementById("ddd");
        bt111.style.display= "none";
        // header.style.display= "none";
        bt.style.display= "block";
        mui.ajax('/user/getAlluser', {
            dataType: 'json',//服务器返回json格式数据
            type: 'get',//HTTP请求类型
            data:{
                notLogin:0,
            },
            success: function (data) {
                //服务器返回响应，根据响应结果，分析是否登录成功；
                if (data.flag) {
                    var str='';
                    var arr=data.obj
                    for(var i=0;i<arr.length;i++){
                        str+='<div class="mui-input-row mui-checkbox mui-left">'+
                            '<label style="line-height: 34px">'+arr[i].userName+'</label>'+
                            '<input style="width: 70px;height: 70px;" class="checkbox3" name="checkbox3" value="'+arr[i].userName+'" type="checkbox" ids="'+arr[i].uid+'">'+
                            '</div>'
                    }

                }

                $("#forms3")[0].innerHTML = str;
            },
            error: function (xhr, type, errorThrown) {
                //异常处理；
                //console.log(type);
            }
        });
        $('.userNames').on('tap', function() {
            mui.ajax('/user/getAlluser', {
                dataType: 'json',//服务器返回json格式数据
                type: 'get',//HTTP请求类型
                data:{
                    notLogin:0,
                    userName:$('input[name="username"]') .val()
                },
                success: function (data) {
                    //服务器返回响应，根据响应结果，分析是否登录成功；
                    if (data.flag) {
                        var str='';
                        var arr=data.obj
                        for(var i=0;i<arr.length;i++){
                            str+='<div class="mui-input-row mui-checkbox mui-left">'+
                                '<label style="line-height: 34px">'+arr[i].userName+'</label>'+
                                '<input style="width: 70px;height: 70px;" class="checkbox3" name="checkbox3" value="'+arr[i].userName+'" type="checkbox" ids="'+arr[i].uid+'">'+
                                '</div>'
                        }

                    }

                    $("#forms3")[0].innerHTML = str;
                },
                error: function (xhr, type, errorThrown) {
                    //异常处理；
                    //console.log(type);
                }
            });
            $('input[name="username"]') .val('')
        })

        mui("#header3").on('tap', '#re_mail3', function () {

            var rdsObj   = document.getElementsByClassName('checkbox3');
            var checkVal = new Array();
            var k        = 0;
            for(i = 0; i < rdsObj.length; i++){
                if(rdsObj[i].checked){
                    checkVal[k] = rdsObj[i].value;
                    k++;
                }
            }
            var rdsObj   = document.getElementsByClassName('checkbox3');
            checkVals1 = new Array();
            var k = 0;
            for(i = 0; i < rdsObj.length; i++){
                if(rdsObj[i].checked){
                    checkVals1[k] = rdsObj[i].getAttribute('ids');
                    k++;
                }
            }


            bt111.style.display= "block";
            bt.style.display= "none";
            // header.style.display= "block";
            document.getElementById("inName").setAttribute('value',checkVal);
            document.getElementById("inName").setAttribute('ids',checkVals1);
        });
    });
    $('#app3').click(function(){
        // var header = document.getElementById("header");
        var bt111 = document.getElementById("aaa");
        var bt = document.getElementById("ddd");
        bt111.style.display= "block";
        // header.style.display= "block";
        bt.style.display= "none";

    })
    $("#inName,#Popover_2").focus(function(){
        document.activeElement.blur();
    });
    //部门审批人
    $('#equipmentName,#Popover_3').on('tap', function() {
        document.activeElement.blur();
    var bt111 = document.getElementById("aaa");
    var bt = document.getElementById("eee");
    bt111.style.display= "none";
    // header.style.display= "none";
    bt.style.display= "block";
    mui.ajax('/user/getAlluser', {
        dataType: 'json',//服务器返回json格式数据
        type: 'get',//HTTP请求类型
        data:{
            notLogin:0,
        },
        success: function (data) {
            //服务器返回响应，根据响应结果，分析是否登录成功；
            if (data.flag) {
                var str='';
                var arr=data.obj
                for(var i=0;i<arr.length;i++){
                    str+='<div class="mui-input-row mui-radio mui-left">'+
                        '<label style="line-height: 34px">'+arr[i].userName+'</label>'+
                        '<input style="width: 70px;height: 70px;" class="checkbox4" name="checkbox4" value="'+arr[i].userName+'" type="radio" ids="'+arr[i].userId+'">'+
                        '</div>'
                }

            }

            $("#forms4")[0].innerHTML = str;
        },
        error: function (xhr, type, errorThrown) {
            //异常处理；
            //console.log(type);
        }
    });
        $('.user').on('tap', function() {
            mui.ajax('/user/getAlluser', {
                dataType: 'json',//服务器返回json格式数据
                type: 'get',//HTTP请求类型
                data:{
                    notLogin:0,
                    userName:$('input[name="user"]').val()
                },
                success: function (data) {
                    //服务器返回响应，根据响应结果，分析是否登录成功；
                    if (data.flag) {
                        var str='';
                        var arr=data.obj
                        for(var i=0;i<arr.length;i++){
                            str+='<div class="mui-input-row mui-radio mui-left">'+
                                '<label style="line-height: 34px">'+arr[i].userName+'</label>'+
                                '<input style="width: 70px;height: 70px;" class="checkbox4" name="checkbox4" value="'+arr[i].userName+'" type="radio" ids="'+arr[i].userId+'">'+
                                '</div>'
                        }

                    }

                    $("#forms4")[0].innerHTML = str;
                }
            });
            $('input[name="user"]').val('')
        })
    mui("#header4").on('tap', '#re_mail4', function () {

        var rdsObj   = document.getElementsByClassName('checkbox4');
        var checkVal = new Array();
        var k        = 0;
        for(i = 0; i < rdsObj.length; i++){
            if(rdsObj[i].checked){
                checkVal[k] = rdsObj[i].value;
                k++;
            }
        }
        var rdsObj   = document.getElementsByClassName('checkbox4');
        checkVals1 = new Array();
        var k = 0;
        for(i = 0; i < rdsObj.length; i++){
            if(rdsObj[i].checked){
                checkVals1[k] = rdsObj[i].getAttribute('ids');
                k++;
            }
        }


        bt111.style.display= "block";
        bt.style.display= "none";
        // header.style.display= "block";
        document.getElementById("equipmentName").setAttribute('value',checkVal);
        document.getElementById("equipmentName").setAttribute('ids',checkVals1);
    });
});
    $('#app4').click(function(){
        // var header = document.getElementById("header");
        var bt111 = document.getElementById("aaa");
        var bt = document.getElementById("eee");
        bt111.style.display= "block";
        // header.style.display= "block";
        bt.style.display= "none";

    })
    $("#equipmentName,#Popover_3").focus(function(){
        document.activeElement.blur();
    });
    function mustWrite() {
        if($('.result').text()=='选择时间') {
            mui.toast("请选择开始时间！");
            return false;
        }
        if($('.result1').text()=='选择时间') {
            mui.toast("请选择结束时间！");
            return false;
        }
        if($('#cont').val()=='') {
            mui.toast("请填写内容！");
            return false;
        }
        if($('.result').text()==$('.result1').text()){
            mui.toast("请选择不同时间！");
            return false;
        }
    }
    //取cooke代码

    function getCookie(name)
    {
        var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
        if(arr=document.cookie.match(reg))
            return unescape(arr[2]);
        else
            return null;
    }
    var userId=getCookie('userId')

    $('.nav').on('click','span',function(){
        $('span').removeClass('navc')
        $(this).addClass('navc')
    })
    $('#mailtype').on('click','li',function(){
        $('li').removeClass('navc')
        $(this).addClass('navc')
        con=$(this).text()
        conid=$(this).attr('data-type')
    })
    $('#re_mail').on('click',function(){
        $('#yspan').text(con)
        $('#yspan').attr('data-type',conid)
        $('#modal').removeClass('mui-active')
    })
    $('#mailtypeAdmin').on('click','li',function(){
        $('li').removeClass('navc')
        $(this).addClass('navc')
        con=$(this).text()
        conid=$(this).attr('data-type')
    })
    $('#re_mailAdmin').on('click',function(){
        $('#managerId').text(con)
        $('#managerId').attr('data-type',conid)
        $('#modalAdmin').removeClass('mui-active')
    })

    var year=new Date().getFullYear() ;
    var  month=new Date().getMonth();
    var day=new Date().getDate();
    $("#demo").click(function(){
        var picker = new mui.DtPicker({
            type: "datetime",//设置日历初始视图模式
            beginDate: new Date(year, month, day),//设置开始日期
            endDate: new Date(2222, 04, 25),//设置结束日期
            labels: ['年', '月', '日', '时', '分'],//设置默认标签区域提示语
        })
        picker.show(function(rs) {
//
            $(".result").html(  rs.text);  //rs.text.split(' ')[0]只获取年。下标改成1，只获取月，以此类推
//
//            //return false;    //这是阻止对话框关闭的
//
            picker.dispose();  //释放组件资源，释放后将将不能再操作组件.所以每次用完便立即调用 dispose 进行释放，下次用时再创建新实例
        })
        $('.mui-btn').html('取消');
        $('.mui-btn-blue').html('确定');
    })
    $("#demo1").click(function(){
        var picker = new mui.DtPicker({
            type: "datetime",//设置日历初始视图模式
            beginDate: new Date(year, month, day),//设置开始日期
            endDate: new Date(2222, 04, 25),//设置结束日期
            labels: ['年', '月', '日', '时', '分'],//设置默认标签区域提示语
        })
        picker.show(function(rs) {
//
            $(".result1").html(  rs.text);  //rs.text.split(' ')[0]只获取年。下标改成1，只获取月，以此类推
//
//            //return false;    //这是阻止对话框关闭的
//
            picker.dispose();  //释放组件资源，释放后将将不能再操作组件.所以每次用完便立即调用 dispose 进行释放，下次用时再创建新实例

        })
        $('.mui-btn').html('取消');
        $('.mui-btn-blue').html('确定');

    })
    $('#add').click(function(){
        var array=$(".test_null");
        for(var i=0;i<array.length;i++){
            if(array[i].value==""){
                $.layerMsg({content:"<fmt:message code="sup.th.With*" />",icon:2},function(){
                });
                return;
            }
        }
        var arraySpan=$(".test_nullSpan");
        for(var i=0;i<arraySpan.length;i++){
            if(arraySpan.eq(i).html()=="选择时间" || arraySpan.eq(i).html()=="未指定" ){
                $.layerMsg({content:"<fmt:message code="sup.th.With*" />",icon:2},function(){
                });
                return;
            }
        }

        if($('#isWriteCalendar').is(':checked')){
            isWriteCalednar=1;
        }
        var recorderId=$('#cname').attr('ids')
        if(recorderId==undefined){
            recorderId=''
        }
        var equipmentIds=$(".equipmentId").attr("data-type")
        if(equipmentIds==undefined){
            equipmentIds=''
        }
        $.ajax({
            url:'/veHicleUsage/addVeHicle',
            type:'post',
            dataType: 'json',
            data:{
                vId: $("#vId").val(),
                vuUser: $('#tname').attr('ids'),
                vuDept: $('#cname').attr('deptId'),
                vuSuite:$('#inName').attr('ids'),
                vuStart: $("#beginTime").html()+':00',
                vuEnd: $("#endTime").html()+':00',
                vuDestination:$('.vuDestination').val(),
                vuMileage:$('input[name="vuMileage"]').val(),
                deptManager:$('#equipmentName').attr('ids'),
                vuOperator:$('#vuOperator').val(),
                vuReason:$('.vuReason').val(),
                vuRemark:$('.vuRemark').val(),
            },
            success:function(data){
                if(data.flag){
                    var btnArray = ['确认'];
                    mui.confirm('保存成功', ' ', btnArray, function(e) {
                        mui.openWindow({
                            url: '/ewx/carList'
                        })
                    })
                }else{
                    var btnArray = ['确认'];
                    mui.confirm('保存失败！', ' ', btnArray, function(e) {
                    })
                }
            }

        })
    })
</script>
</body>
</html>
