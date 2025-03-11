<%--<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String corpId = (String)request.getAttribute("corpId");
    String corpSecret = (String)request.getAttribute("corpSecret");
%>--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>新建会议</title>
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
        /*.nav{*/
        /*width: 70%;*/
        /*overflow: hidden;*/
        /*text-overflow: ellipsis;*/
        /*white-space: nowrap;*/
        /*height: 22px;*/
        /*line-height: 22px;*/
        /*margin-top: 15px;*/
        /*}*/
        #header{
            background-color: #3984ff;
            box-shadow: 1px 1px 7px rgba(0, 0, 0, .85);
        }
        #header a{
            color: #fff;
        }
        #header h1{
            color: #fff;
        }
        .ulli{
            margin: 0 20px;
            border-bottom: 1px solid #c8c7cc;
            height: 50px;
            line-height: 58px;
        }

        .nav{
            height: 31px;
            line-height: 28px;
            border: 1px solid #e1dddd;
            border-radius: 10px;
            width: 66%;
            margin-top: 13px;
            margin-right: 27px;
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
        .fl{
            float: left;
        }
        .fr{
            float: right;
        }
        .spanc{
            background-color: #00a0e9;
            width: 40px;
            display: inline-block;
            text-align: center;
            height: 22px;
            line-height: 21px;
            border-radius: 6px;
            color: #fff;
        }
        #yspan ,#managerId{
            padding: 4px 10px;
            background-color: #00a0e9;
            color: #fff;
            border-radius: 5px;
            /*margin-left: 14px;*/
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
        .mui-content {
            height: calc(100% - 45px);
            background: #fff;
        }
        #forms label,#forms1 label,#forms3 label,#forms4 label{
            width: 400px;
        }
        #forms , #forms1 ,#forms3 ,#forms4{
            margin-top: 50px;
        }
        .mui-input-row span{
            /*float: right;*/
            line-height: 40px;
        }
        .mui-content {
            height: 100%;
            background: #fff;
            overflow: auto;
        }
        .radio_inline{
            display: inline-block;
            width: 65%;
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
        .must{
            color: red;
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
<%--<header data-role="header" class="mui-bar mui-bar-nav" id="header">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" ></a>
    <h1 class="mui-title" id="mtitle">新建会议</h1>
    <a href="javascript:;" id="add" class="mui-pull-right " style="padding-top: 14px;padding-right: 5px;" >保存</a>
</header>--%>
<div class="mui-content" id="aaa" style="overflow: auto;">
    <ul>
        <%--<li class="ulli">
            <div class="fl" style="height: 50px">日程安排：</div>
            <div class="nav fr">
                <span class="navc fl">工作事务</span>
                <span  class="fr">个人事务</span>
            </div>
        </li>--%>
            <li class="mui-table-view-cell mui-input-row"><label class="mui-left"><span class="must">*</span>名称：</label><input type="text" placeholder="请输入名称" class="meetName  test_null" style="margin-top: 10px;" value="" /></li>
            <li class="mui-table-view-cell mui-input-row"><label class="mui-left"><span class="must">*</span>主题：</label><input type="text" placeholder="请输入主题" class=" subject test_null" style="margin-top: 10px;"  value="" /></li>
            <li class="mui-table-view-cell mui-input-row"><label class="mui-left"><span class="must">*</span>申请人：</label><input type="text" placeholder="选择申请人" style="margin-top: 10px;"  value="" class=" test_null" id="tname"/><input value="" type="hidden" id="reciever"/><span id="Popover_0" class='mui-icon mui-icon-plus'  style="margin-top: 8px;" ></span></li>
            <li class="mui-table-view-cell mui-input-row"><label class="mui-left" style="width: 100px;"><span class="must">*</span>联系电话：</label><input type="text" placeholder="请输入联系电话" style="margin-top: 10px;"  class=" mobileNo test_null" value="" /></li>
            <li class="mui-table-view-cell mui-input-row"><label class="mui-left" style="padding:11px 0px">会议纪要员：</label><input type="text" placeholder="选择会议纪要员" value=""  id="cname"/><input value="" type="hidden" id="copyreciever"/><span id="Popover_1" class='mui-icon mui-icon-plus'  ></span></li>
           <%-- <li class="mui-table-view-cell mui-input-row mui-radio"><label class="mui-left" style="padding:11px 0px">是否是周期性事务：</label>
               <span class="radio_inline mui-radio"><input name="isCycle" type="radio" class="isCycle" checked value="1"><label for="radio_man">是</label><input name="isCycle" type="radio" class="isCycle" value="0" style="margin-top: -10px;"><label for="radio_woman">否</label></span>  
            </li>--%>
            <li class="mui-table-view-cell mui-input-row" id="demo"><span class="must">*</span>开始时间：<span class="result test_nullSpan" id="beginTime">选择时间</span></li>
            <li class="mui-table-view-cell mui-input-row"id="demo1"><span class="must">*</span>结束时间：<span class="result1 test_nullSpan " id="endTime">选择时间</span></li>
            <li class="mui-table-view-cell mui-input-row"><label class="mui-left "><span class="must">*</span>会议室：</label><a  href="#modal" style="display: inline-block;margin-top: 0px;"><span id="yspan" class="test_nullSpan">未指定</span></a></li>
          <%--  <li class="mui-table-view-cell mui-input-row mui-radio"><label class="mui-left" style="padding:11px 4px">是否是视频会议：</label>
                <span class="radio_inline mui-radio"><input name="radio2" type="radio" class="isVideo" checked value="1"><label for="radio_man">是</label><input name="radio2" type="radio" class="isVideo"  value="0" style="margin-top: -10px;"><label for="radio_woman">否</label></span>  
            </li>--%>
            <li class="mui-table-view-cell mui-input-row"><label class="mui-left"><span class="must">*</span>审批管理员：</label><a  href="#modalAdmin" style="display: inline-block;margin-top: 0px;"><span id="managerId" class="test_nullSpan">未指定</span></a></li>
            <li class="mui-table-view-cell mui-input-row"><label class="mui-left">出席人员（外部）：</label><input type="text" placeholder="请输入出席人员（外部）" style="margin-top: 5px;" class=" attendeeOut" value="" /></li>
            <li class="mui-table-view-cell mui-input-row"><label class="mui-left" ><span class="must">*</span>出席人员（内部）：</label><input type="text" placeholder="选择出席人员（内部）" style="margin-top: 17px;" value="" class=" attendee test_null" id="inName" /><input value="" type="hidden" id="Inreciever"/><span id="Popover_2" class='mui-icon mui-icon-plus' style="margin-top: 17px;" ></span></li>
            <li class="mui-table-view-cell mui-input-row"><label class="mui-left" >会议室设备：</label><input type="text" placeholder="选择会议室设备" value="" class=" equipmentId"   id="equipmentName" /><input value="" type="hidden" id="equipment"/><span id="Popover_3" class='mui-icon mui-icon-plus' ></span></li>
            <li class="mui-table-view-cell mui-input-row "><label class="mui-left" style="padding:11px 4px">写入日程安排：</label>
                <div class="radio_inline mui-checkbox mui-left" style="margin-left: -9%"><input name="anpai" type="checkbox" checked value="1"  id="isWriteCalendar"><label for="radio_man" style="width: 320px;">是（会议通过审批后写入日程安排）</label></div>  
            </li>
            <li class="mui-table-view-cell">
                <div class="new_type">附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件：
                    <span class='mui-icon mui-icon-plus mui-pull-right' onclick="" id="uploadimg">
                        <form id="uploadimgform" target="uploadiframe" action="../upload?module=email" enctype="multipart/form-data" method="post">
                            <input type="file" multiple="multiple" name="file" id="uploadinputimg" class="w-icon5" style="position: absolute;top:6px;opacity: 0;width: 70px;
                            filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                            <a id="" style="cursor: pointer;"></a>
                        </form>
                    </span>
                </div>
                <div class="log_share">
                    <ul id="files" style="text-align:left;width: 85%;display: inline-block;">
                        <%--<p id="empty" style="font-size:12px;color:#C6C6C6;">无上传文件</p>--%>
                        <div style="font-size:12px;color:#C6C6C6;" id="query_uploadArr" style="display:block;">
                        </div>
                    </ul>
                </div>
            </li>
    </ul>
    <textarea name="" class="meetDesc" placeholder="输入会议描述" style="padding: 6px 0 0 6px;width: 90%;height: 45%;margin-left: 5%;margin-top: 10px;"></textarea>
    <div class="mui-button-row">
        <button type="button" class=" mui-btn-primary sure" id="add" >确认</button>
    </div>
</div>
<%--下拉框--%>
<%--会议室--%>
<div id="modal" class="mui-modal">
    <header class="mui-bar mui-bar-nav" id="header2">
        <a class="mui-icon mui-icon-close mui-pull-left" href="#modal"></a>
        <h1 class="mui-title">请选择会议室</h1>
        <a class="mui-btn-link mui-pull-right" id="re_mail" href="javascript:;">确定</a>
    </header>
    <div class="mui-content" style="height: 100%;">
        <ul class="mui-table-view" id="mailtype">
          <%--  <li class="mui-table-view-cell" data-type=""><a href="#">未指定</a>
            </li>
            <li class="mui-table-view-cell" data-type="1"><a href="#">重要/紧急</a>
            </li>
            <li class="mui-table-view-cell" data-type="2"><a href="#" >重要/不紧急</a>
            </li>
            <li class="mui-table-view-cell" data-type="3"><a href="#">不重要/紧急</a>
            </li>
            <li class="mui-table-view-cell" data-type="4"><a href="#">不重要/不紧急</a>
            </li>--%>
        </ul>
    </div>
</div>
<%--管理员--%>
<div id="modalAdmin" class="mui-modal">
    <header class="mui-bar mui-bar-nav" id="headerAdmin">
        <a class="mui-icon mui-icon-close mui-pull-left" href="#modalAdmin"></a>
        <h1 class="mui-title">请选择审批管理员</h1>
        <a class="mui-btn-link mui-pull-right" id="re_mailAdmin" href="javascript:;">确定</a>
    </header>
    <div class="mui-content" style="height: 100%;">
        <ul class="mui-table-view" id="mailtypeAdmin">
            <%--  <li class="mui-table-view-cell" data-type=""><a href="#">未指定</a>
              </li>
              <li class="mui-table-view-cell" data-type="1"><a href="#">重要/紧急</a>
              </li>
              <li class="mui-table-view-cell" data-type="2"><a href="#" >重要/不紧急</a>
              </li>
              <li class="mui-table-view-cell" data-type="3"><a href="#">不重要/紧急</a>
              </li>
              <li class="mui-table-view-cell" data-type="4"><a href="#">不重要/不紧急</a>
              </li>--%>
        </ul>
    </div>
</div>
<%--选择申请人--%>
<div class="mui-content" style="display: none" id="ccc">
    <div class="mui-bar mui-bar-nav" id="headerApply" style="height: 100px" >
        <a class="mui-icon mui-icon-close mui-pull-left" href="#modal1" id="app"></a>
        <h1 class="mui-title">选择人员</h1>
        <a class="mui-btn-link mui-pull-right" id="re_mailApply">确认</a>
        <div style="margin-top: 45px;">
            <span>姓名</span>
            <input type="text" name="username" style="width: 73%;height: 36px;border-radius: 10px" class="c">
            <button type="button" class="mui-btn mui-btn-primary userNames" style="vertical-align: text-bottom;border-radius: 10px">搜索</button>
        </div>
    </div>
    <div  style="height: 100%;">
        <div id="forms" style="margin-top: 100px;">

        </div>
    </div>
</div>
<%--选择会议纪要员--%>
<div class="mui-content"  style="display: none" id="bbb">
    <div class="mui-bar mui-bar-nav" id="header1" style="height: 100px">
        <a class="mui-icon mui-icon-close mui-pull-left" href="#modal1"  id="app1"></a>
        <h1 class="mui-title">选择人员</h1>
        <a class="mui-btn-link mui-pull-right" id="re_mail1">确认</a>
        <div style="margin-top: 45px;">
            <span>姓名</span>
            <input type="text" name="userName" style="width: 73%;height: 36px;border-radius: 10px" class="c" id="jiyao">
            <button type="button" class="mui-btn mui-btn-primary" id="minutes" style="vertical-align: text-bottom;border-radius: 10px">搜索</button>
        </div>
    </div>
    <div  style="height: 100%;">
        <div id="forms1" style="margin-top: 100px;">

        </div>
    </div>
</div>
<%--出席人员（内部）--%>
<div class="mui-content"  style="display: none" id="ddd">
    <div class="mui-bar mui-bar-nav" id="header3" style="height:100px;">
        <a class="mui-icon mui-icon-close mui-pull-left" href="#modal1"  id="app3"></a>
        <h1 class="mui-title">选择人员</h1>
        <a class="mui-btn-link mui-pull-right" id="re_mail3">确认</a>
        <div style="margin-top: 45px;">
            <span>姓名</span>
            <input type="text" name="names" style="width: 73%;height: 36px;border-radius: 10px" class="c" id="names">
            <button type="button" class="mui-btn mui-btn-primary" id="butt" style="vertical-align: text-bottom;border-radius: 10px">搜索</button>
        </div>
    </div>
    <div  style="height: 100%;">
        <div id="forms3" style="margin-top: 100px">

        </div>
    </div>
</div>
<%--会议室设备---%>
<div class="mui-content"  style="display: none" id="eee">
    <div class="mui-bar mui-bar-nav" id="header4">
        <a class="mui-icon mui-icon-close mui-pull-left" href="#modal1"  id="app4"></a>
        <h1 class="mui-title">选择会议室设备</h1>
        <a class="mui-btn-link mui-pull-right" id="re_mail4">确认</a>
    </div>
    <div  style="height: 100%;">
        <div id="forms4">

        </div>
    </div>
</div>

<script>
    var con=''
    var conid
    var attachmentId=''
    var attachmentName=''
    //默认申请人是当前登录人
    $.ajax({
        url: '/Meetequipment/getuser',
        type: 'get',
        dataType: 'json',
        success: function (res) {
            // console.log(res)
            $('#tname').attr('user_id',res.object.userId+',');
            $('#tname').attr('dataid',res.object.uid+',');
            $('#tname').val(res.object.userName+',');
        }
    })
    //会议室
    $.ajax({
        url: '../../meetingRoom/getAllMeetRoom',
        type: 'get',
        dataType: 'json',
        success: function (obj) {
            var data=obj.obj;
            var str="";
            // var firstRoomId;
            for(var i=0;i<data.length;i++){
                // str+='<option value="'+data[i].sid+'">'+data[i].mrName+'</option>';
                str+=' <li class="mui-table-view-cell" data-type="'+data[i].sid+'"><a href="#">'+data[i].mrName+'</a></li>';
               /* if(i==0){
                    firstRoomId = data[i].sid;
                }*/
            }
           /* if (str===''){
                $("input[name='isVideo']").each(function(index,item){
                    $(this).prop("disabled",true);
                    if(index===0){
                        $(this).prop("checked",true);
                    }
                });
            }*/
            // str+="<option value='0'>视频会议</option>";
            $("#mailtype").html(str);
            //initManager(firstRoomId);
        }
    });
    //审批管理员
    $.ajax({
        url: '/meeting/getManagers',
        type: 'get',
        dataType: 'json',
        data: {
            paraName:"MEETING_MANAGER_TYPE",
            roomId:$("#mailtype").attr('data-type')
        },
        success: function (obj) {
            var data=obj.object;
            var managerArray=data.usersList;
            var str="";
            for(var i=0;i<managerArray.length;i++){
                /*if(managerId==undefined){
                    str+='<option value="'+managerArray[i].uid+'">'+managerArray[i].userName+'</option>';
                }else if(managerId==managerArray[i].uid){
                    str+='<option value="'+managerArray[i].uid+'" selected>'+managerArray[i].userName+'</option>';
                }*/
                str+=' <li class="mui-table-view-cell" data-type="'+managerArray[i].uid+'"><a href="#">'+managerArray[i].userName+'</a></li>';
            }
            $("#mailtypeAdmin").html(str);
        }
    });
    //选择申请人
    // var btn0 = document.getElementById("Popover_0");
    $('#tname,#Popover_0').on('tap', function() {
        // var header = document.getElementById("header")
        var bt111 = document.getElementById("aaa");
        var bt = document.getElementById("ccc");
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
                        // console.log(arr[i].userName)
                        str+='<div class="mui-input-row mui-checkbox mui-left">'+
                            '<label style="line-height: 34px">'+arr[i].userName+'</label>'+
                            '<input style="width: 70px;height: 70px;" class="checkbox1" name="checkbox1" value="'+arr[i].userName+'" type="checkbox" ids="'+arr[i].uid+'">'+
                            '</div>'
                    }

                }

                $("#forms")[0].innerHTML = str;
            },
            error: function (xhr, type, errorThrown) {
                //异常处理；
                //console.log(type);
            }
        });
        //点击搜索的界面
        $('.userNames').on('tap', function() {
            mui.ajax('/user/getAlluser', {
                dataType: 'json',//服务器返回json格式数据
                type: 'get',//HTTP请求类型
                data:{
                    notLogin:0,
                    userName:$('input[name="username"]').val()
                },
                success: function (data) {
                    if(data.obj==undefined || data.obj== ""){
                        var app='<div class="mui-input-row mui-checkbox mui-left" style="margin-top: 110px;font-size: 25px;text-align: center;">暂无数据</div>'
                        $("#forms")[0].innerHTML = app;
                    }else{
                        var str='';
                        var arr=data.obj
                        for(var i=0;i<arr.length;i++){
                            str+='<div class="mui-input-row  mui-radio mui-left">'+
                                '<label style="line-height: 34px">'+arr[i].userName+'</label>'+
                                '<input style="width: 70px;height: 70px;" class="checkbox1" name="checkbox1" value="'+arr[i].userName+'" type="radio" ids="'+arr[i].userId+'">'+
                                '</div>'
                        }
                        $("#forms")[0].innerHTML = str;
                    }
                }
            });
            $('input[name="username"]').val('')
        })
        mui("#headerApply").on('tap', '#re_mailApply', function () {
            var rdsObj   = document.getElementsByClassName('checkbox1');
            var checkVal = new Array();
            var k        = 0;
            for(i = 0; i < rdsObj.length; i++){
                if(rdsObj[i].checked){
                    checkVal[k] = rdsObj[i].value;
                    k++;
                }
            }

            var rdsObj   = document.getElementsByClassName('checkbox1');
            checkVals = new Array();

            var k = 0;
            for(i = 0; i < rdsObj.length; i++){
                if(rdsObj[i].checked){
                    checkVals[k] = rdsObj[i].getAttribute('ids');
                    k++;
                }
            }
            bt111.style.display= "block";
            bt.style.display= "none";
            // header.style.display= "block";
            // document.getElementById("tname").setAttribute('value',checkVal);
            $('#tname').val(checkVal.join());
            $('#tname').attr('dataid',checkVals);
            // document.getElementById("tname").setAttribute('ids',checkVals);
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
    // 选择会议纪要员
    // var btn1 = document.getElementById("Popover_1");
    $('#cname,#Popover_1').on('tap', function() {
        var bt111 = document.getElementById("aaa");
        var bt = document.getElementById("bbb");
        bt111.style.display= "none";
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
                            '<input style="width: 70px;height: 70px;" class="checkbox2" name="checkbox2" value="'+arr[i].userName+'" type="checkbox" ids="'+arr[i].uid+'">'+
                            '</div>'
                    }

                }

                $("#forms1")[0].innerHTML = str;
            },
            error: function (xhr, type, errorThrown) {
                //异常处理；
                //console.log(type);
            }
        });
        $('#minutes').click(function () {
            mui.ajax('/user/getAlluser', {
                dataType: 'json',//服务器返回json格式数据
                type: 'get',//HTTP请求类型
                    data:{
                        notLogin:0,
                        userName:$('#jiyao').val()
                    },
                success: function (data) {
                    //服务器返回响应，根据响应结果，分析是否登录成功；
                    if(data.obj==undefined || data.obj== ""){
                        var app='<div class="mui-input-row mui-checkbox mui-left" style="margin-top: 110px;font-size: 25px;text-align: center;">暂无数据</div>'
                        $("#forms1")[0].innerHTML = app;
                    }else{
                        var str='';
                        var arr=data.obj
                        for(var i=0;i<arr.length;i++){
                            str+='<div class="mui-input-row mui-checkbox mui-left">'+
                                '<label style="line-height: 34px">'+arr[i].userName+'</label>'+
                                '<input style="width: 70px;height: 70px;" class="checkbox2" name="checkbox2" value="'+arr[i].userName+'" type="checkbox" ids="'+arr[i].uid+'">'+
                                '</div>'
                        }
                        $("#forms1")[0].innerHTML = str;
                    }
                }
            });
            $('#jiyao').val('')
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
                    checkVals1[k] = rdsObj[i].getAttribute('ids');
                    k++;
                }
            }


            bt111.style.display= "block";
            bt.style.display= "none";
            // header.style.display= "block";
            document.getElementById("cname").setAttribute('value',checkVal);
            document.getElementById("cname").setAttribute('ids',checkVals1);
        });

    });
    $('#app1').click(function(){
        // var header = document.getElementById("header");
        var bt111 = document.getElementById("aaa");
        var bt = document.getElementById("bbb");
        bt111.style.display= "block";
        // header.style.display= "block";
        bt.style.display= "none";

    })

    // 出席人员（内部）
    $('#inName,#Popover_2').on('tap', function() {
        var bt111 = document.getElementById("aaa");
        var bt = document.getElementById("ddd");
        bt111.style.display= "none";
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
        $('#butt').on('tap', function() {
            mui.ajax('/user/getAlluser', {
                dataType: 'json',//服务器返回json格式数据
                type: 'get',//HTTP请求类型
                data:{
                    notLogin:0,
                    userName:$('#names').val()
                },
                success: function (data) {
                    if(data.obj==undefined || data.obj== ""){
                        var app='<div class="mui-input-row mui-checkbox mui-left" style="margin-top: 110px;font-size: 25px;text-align: center;">暂无数据</div>'
                        $("#forms3")[0].innerHTML = app;
                    }else{
                        var str='';
                        var arr=data.obj
                        for(var i=0;i<arr.length;i++){
                            str+='<div class="mui-input-row mui-checkbox mui-left">'+
                                '<label style="line-height: 34px">'+arr[i].userName+'</label>'+
                                '<input style="width: 70px;height: 70px;" class="checkbox3" name="checkbox3" value="'+arr[i].userName+'" type="checkbox" ids="'+arr[i].uid+'">'+
                                '</div>'
                        }
                        $("#forms3")[0].innerHTML = str;
                    }
                },
            });
            $('#names').val('')
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
    //会议室设备
    // var btn3 = document.getElementById("Popover_3");
    $('#equipmentName,#Popover_3').on('tap', function() {
        // var header = document.getElementById("header");
        var bt111 = document.getElementById("aaa");
        var bt = document.getElementById("eee");
        bt111.style.display= "none";
        // header.style.display= "none";
        bt.style.display= "block";
        mui.ajax('/Meetequipment/getAllEquiet', {
            dataType: 'json',//服务器返回json格式数据
            type: 'get',//HTTP请求类型
            success: function (data) {
                //服务器返回响应，根据响应结果，分析是否登录成功；
                if (data.flag) {
                    var str='';
                    var arr=data.obj
                    for(var i=0;i<arr.length;i++){
                        str+='<div class="mui-input-row mui-checkbox mui-left">'+
                            '<label style="line-height: 34px">'+arr[i].equipmentName+'</label>'+
                            '<input style="width: 70px;height: 70px;" class="checkbox4" name="checkbox4" value="'+arr[i].equipmentName+'" type="checkbox" ids="'+arr[i].sid+'">'+
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

    //附件
    $('#uploadinputimg').fileupload({
        dataType:'json',
        done: function (e, data) {
            if(data.result.obj != ''){
                var data = data.result.obj;
                var str = '';
                var str1 = '';
                for (var i = 0; i < data.length; i++) {
                    var gs = data[i].attachName.split('.')[1];
                    if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){
                        str += '';
                        layer.alert('jsp、css、js、html、java文件禁止上传!',{},function(){
                            layer.closeAll();
                        });
                    }else{
                        var attname = data[i].aid+'@'+data[i].ym+'_'+data[i].attachId
                        attachmentId+=attname+','
                        attachmentName+=data[i].attachName+'*'

                        str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" NAME="'+data[i].attachName+'*" href="/download?'+encodeURI(data[i].attUrl)+'">'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';
                    }
                }
                $('#query_uploadArr').append(str);
            }else{
                //alert('添加附件大小不能为空!');
                layer.alert('添加附件大小不能为空!',{},function(){
                    layer.closeAll();
                });
            }
        }
    });
    //删除附件
    $(document).on('click','.deImgs',function(){
        var data=$(this).parents('.dech').attr('deUrl');
        var dome=$(this).parents('.dech');
        deleteChatment(data,dome);
    })
    //附件删除
    function deleteChatment(data,element){

        layer.confirm('<fmt:message code="sup.th.Delete" />？', {
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
            title:"<fmt:message code="notice.th.DeleteFile" />"
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'get',
                url:'../delete',
                dataType:'json',
                data:data,
                success:function(res){

                    if(res.flag == true){
                        layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});
                        element.remove();
                    }else{
                        layer.msg('<fmt:message code="lang.th.deleSucess" />', { icon:6});
                    }
                }
            });

        }, function(index){
            layer.close(index);
        });
    }

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
        var isWriteCalednar=0;
        if($('#isWriteCalendar').is(':checked')){
            isWriteCalednar=1;
        }
        var recorderId=$('#cname').attr('ids')
        if(recorderId==undefined){
            recorderId=''
        }
        var equipmentIds=$(".equipmentId").attr("ids")
        if(equipmentIds==undefined){
            equipmentIds=''
        }
        var managerId=$("#managerId").attr('data-type')
        if(managerId==undefined){
            managerId=''
        }
        mui.ajax('/meeting/insertMeeting',{
            data:{
                mobileNo:$('.mobileNo').val(),
                cycle:'0',
                cycleStartDate:'',
                cycleEndDate:'',
                cycleStartTime:'',
                cycleEndTime:'',
                cycleWeek:'',
                meetName: $(".meetName").val(),
                subject: $(".subject").val(),
                uid: $('#tname').attr('dataid').substr(0,$('#tname').attr('dataid').length-1),
                recorderId:recorderId,
                startTime: $("#beginTime").html(),
                endTime: $("#endTime").html(),
                attendeeOut: $(".attendeeOut").val(),
                attendee: $(".attendee").attr("ids"),
                isWriteCalednar: isWriteCalednar,
                smsRemind: '',
                sms2Remind:'' ,
                resendHour: '',
                resendMinute: '',
                meetDesc: $(".meetDesc").val(),
                managerId: managerId,
                meetRoomId: $("#yspan").attr('data-type'),
                equipmentNames: $(".equipmentId").val(),
                equipmentIds: equipmentIds,
                attachmentId:attachmentId,
                attachmentName:attachmentName,
                // videoConfFlag:$('.isVideo:checked').val()
            },
            dataType:'json',//服务器返回json格式数据
            type:'post',//HTTP请求类型
            success:function(data){
                if(data.flag){
                    var btnArray = ['确认'];
                    mui.confirm('保存成功', ' ', btnArray, function(e) {
                        mui.openWindow({
                            url: '/ewx/meetingList'
                        })
                    })
                }else{
                    var btnArray = ['确认'];
                    mui.confirm('保存失败！', ' ', btnArray, function(e) {
                    })
                }
            }
        })
        /*if(mustWrite()==false) {
            return;
        }
        var content=$('#cont').val();
        var calTime=Date.parse(new Date($('.result').text().replace(/-/g,"/")))/1000;
        var endTime=Date.parse(new Date($('.result1').text().replace(/-/g,"/")))/1000;
        var calType
        if($('.fl').hasClass('navc')){
            calType=1
        }
        if($('.fr').hasClass('navc')){
            calType=2
        }
        var calLevel=$('#yspan').attr('data-type')
        if(calLevel==undefined){
            calLevel=''
        }
        mui.ajax('/schedule/addCalender',{
            data:{
                'calTime':calTime,
                'endTime':endTime,
                'content':content,
                'calType':calType,
                'calLevel':calLevel,
                'userId':userId,
            },
            dataType:'json',//服务器返回json格式数据
            type:'post',//HTTP请求类型
            success:function(data){
                if(data.flag){
                    var btnArray = ['确认'];
                    mui.confirm('保存成功', ' ', btnArray, function(e) {
                        mui.openWindow({
                            url: '/ewx/calendar'
                        })
                    })
                }else{
                    var btnArray = ['确认'];
                    mui.confirm('保存失败！', ' ', btnArray, function(e) {
                    })
                }
            }
        })*/
    })



    //    var mtype='inbox'
    //
    //    //    function plusReady(){
    //    //        // 在这里调用plus api
    //    //    }
    //    //    if(window.plus){
    //    //        plusReady();
    //    //    }else{
    //    //        document.addEventListener('plusready',plusReady,false);
    //    //    }
    //    window.addEventListener('refresh',function(e){
    //        location.reload();
    //    });
    //    (function($, doc) {
    ////        mui.init({
    ////            swipeBack:true, //启用右滑关闭功能
    ////            preloadPages:[{
    ////                id:'detailh5',
    ////                url:'detailh5'
    ////            }]
    ////        });
    ////        $.back=function(){
    ////            plus.SimbaPlugin.quitApp();
    ////        };
    //        var rmail='rmail';
    //        get_data(rmail);
    ////        var detailPage=null;
    //        mui('#ul_calendar').on('tap', 'a.mui-navigate-right', function() {
    ////            mtype=event.target.getAttribute('data-type');
    //            var bodyId = this.getAttribute('bodyId');
    //            var href = this.href;
    ////            var mid = this.getAttribute('data-did');
    ////            var mtype=this.getAttribute('mtype');
    ////            var type = this.getAttribute("open-type");
    ////            if(!detailPage){
    ////                detailPage = plus.webview.getWebviewById('detailh5');
    ////            }
    ////            mui.fire(detailPage,'newsId',{
    ////                mid:mid,
    ////                mtype:mtype
    ////            });
    //
    //            if( mtype == "inbox"|| mtype =="recycle"){
    //                mui.openWindow({
    //                    url: 'detailh5?flag='+mtype+'&emailID='+bodyId
    //                });
    //            }else {
    //                mui.openWindow({
    //                    url: 'detailh5?flag='+mtype+'&bodyId='+bodyId
    //                });
    //            }
    //
    //
    //        });
    //        //向左侧滑删除本条数据
    //        mui('#ul_calendar').on('tap', '.mui-btn', function(event) {
    //            var btnArray = ['确认', '取消'];
    //            var elem = this;
    //            var li = elem.parentNode.parentNode;
    //            var bodyId = elem.getAttribute('bodyId');
    //            mui.confirm('确认删除该条记录？', ' ', btnArray, function(e) {
    ////                var mtype=elem.parentNode.parentNode.lastChild.firstChild.getAttribute('mtype');
    //                var mid=elem.parentNode.parentNode.lastChild.firstChild.getAttribute('data-did');
    //                if (e.index == 0) {
    //                    console.log(mtype);
    //                    if(mtype=="drafts") {
    //                        mui.ajax('/email/deleteDraftsEmail',{
    //                            data:{
    //                                bodyId:bodyId
    //                            },
    //                            dataType:'json',//服务器返回json格式数据
    //                            type:'get',//HTTP请求类型
    //                            success:function(data){
    //                                if(data.flag == true){
    //                                    mui.toast("删除成功！");
    //                                    li.parentNode.removeChild(li);
    //                                }else{
    //                                    mui.toast("删除失败！");
    //                                }
    //                            }
    //                        });
    //                    } else {
    //                        mui.ajax('/email/deleteEmail',{
    //                            data:{
    //                                flag:mtype,
    //                                emailID:bodyId,
    //                                deleteFlag:0
    //                            },
    //                            dataType:'json',//服务器返回json格式数据
    //                            type:'get',//HTTP请求类型
    //                            success:function(data){
    //                                if(data.flag == true){
    //                                    mui.toast("删除成功！");
    //                                    li.parentNode.removeChild(li);
    //                                }else{
    //                                    mui.toast("删除失败！");
    //                                }
    //                            }
    //                        });
    //
    //                    }
    //                } else {
    //                    setTimeout(function() {
    //                        $.swipeoutClose(li);
    //                    }, 0);
    //                }
    //            });
    //        });
    //        /*收件箱，发件箱，油标箱，草稿等切换*/
    //        mui('#mailtype').on('tap', 'a', function() {
    //            mtype=event.target.getAttribute('data-type');
    //            var title=event.target.text;
    //            document.getElementById('mtitle').innerHTML= title;
    //            mui('#Popover_0').popover('hide');
    //            mui.ajax('/email/showEmail?flag='+mtype+'&page=1&pageSize=3&useFlag=false',{
    //                dataType:'json',//服务器返回json格式数据
    //                type:'get',//HTTP请求类型
    //                success:function(data){
    //                    var cal='';
    //
    //
    //                    $("#ul_calendar")[0].innerHTML='';
    //                    if( data.obj.length != 0){
    //                        for(var i=0;i<data.obj.length;i++){
    //                            var ics
    //                            if( mtype == "inbox"|| mtype =="recycle"){
    //
    //                                ics=data.obj[i].emailList[0].emailId
    //                                console.log(ics)
    //
    //                            }else {
    //                                ics=data.obj[i].bodyId
    //                            }
    //
    //                            cal+='<li class="mui-table-view-cell mui-transitioning">' +
    //                                '<div class="mui-slider-right mui-disabled">' +
    //                                '<a class="mui-btn mui-btn-red" bodyId="'+ics+'">删除</a>' +
    //                                '</div>' +
    //                                '<div class="mui-slider-handle">' +
    //                                '<a class="mui-navigate-right" href="/detail" bodyId="'+ics+'" >' +
    //                                '<p style="color:#333;font-size:1.1em">'+data.obj[i].users.userName+'<span style="font-size: 12px;color:#ccc;width: 65%;display: inline-block;text-align: right;">'+data.obj[i].probablyDate+'</span></p>' +
    //                                '<p class="nav">ReAll:<span >'+data.obj[i].subject+'</span></p>' +
    //                                '<div class="nav">'+data.obj[i].content+'</div>'+
    //                                '</a>' +
    //                                '</div>' +
    //                                '</li>';
    //                        }
    //                        $("#ul_calendar")[0].innerHTML = cal;
    //                    }else{
    //                        $("#ul_calendar")[0].innerHTML = '<li class="mui-table-view-cell">暂无内容</li>';
    //                    }
    //                }
    //            });
    //        });
    //        /*点击写邮箱*/
    //        var btn = document.getElementById("Popover_1");
    //        btn.addEventListener('tap', function() {
    //            mui.openWindow({
    //                url: 'addMailh5',
    //                id:'add'
    //            });
    //        });
    //    })(mui, document);
    //    function get_data(m){
    //        var cal='';
    //        mui.ajax('/email/showEmail?flag=inbox&page=1&pageSize=3&useFlag=false',{
    //            data:{
    ////                mtype:m,
    ////                flag:'loadlist',
    ////                ftype:'refresh'
    //            },
    //            dataType:'json',//服务器返回json格式数据
    //            type:'get',//HTTP请求类型
    //            success:function(data){
    //                if( data.obj.length != 0){
    //                    for(var i=0;i<data.obj.length;i++){
    //                        cal+='<li class="mui-table-view-cell mui-transitioning">' +
    //                            '<div class="mui-slider-right mui-disabled">' +
    //                            '<a class="mui-btn mui-btn-red" bodyId="'+data.obj[i].emailList[0].emailId+'">删除</a>' +
    //                            '</div>' +
    //                            '<div class="mui-slider-handle">' +
    //                            '<a class="mui-navigate-right" href="/detailh5" bodyId="'+data.obj[i].emailList[0].emailId+'">' +
    //                            '<p style="color:#333;font-size:1.1em;height: 22px;line-height: 22px;"><span style="display: inline-block;float: left">'+data.obj[i].users.userName+'</span><span style="font-size: 12px;color:#ccc;display: inline-block;float: right;padding-right: 10px;">'+data.obj[i].probablyDate+'</span></p>' +
    //                            '<p class="nav">ReAll:<span >'+data.obj[i].subject+'</span></p>' +
    //                            '<div class="nav">'+data.obj[i].content+'</div>'+
    //                            '</a>' +
    //                            '</div>' +
    //                            '</li>';
    //                    }
    //                    $("#ul_calendar")[0].innerHTML = cal;
    //                }else{
    //                    $("#ul_calendar")[0].innerHTML = '<li class="mui-table-view-cell">暂无内容</li>';
    //                }
    //            }
    //        });
    //    }
</script>
</body>
</html>
