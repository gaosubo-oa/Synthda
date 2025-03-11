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
    <title>日程详情</title>
    <link rel="stylesheet" href="../../css/email/m/jquery.mobile.css" />
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>

    <link rel="stylesheet" href="../../css/email/m/styles.css" />
    <link rel="stylesheet" href="../../css/email/m/style.css">
    <link rel="stylesheet" href="../../css/email/m/mail.css">
    <script type="text/javascript" src="../../js/notes/jquery-2.1.2.min.js" ></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <script type="text/javascript" src="../../js/diary/m/simbaJs.js" ></script>


    <link rel="stylesheet" href="../../lib/mui/mui/mui.picker.min.css" />
    <script type="text/javascript" src="../../lib/mui/mui/mui.picker.min.js" ></script>
    <style>
        #header{
            background-color: #3984ff;
            box-shadow: 1px 1px 7px rgba(0, 0, 0, .85);
        }
        #header a{
            color: #fff;
        }
        #header h1{
            color: #fff;
            margin: 0px 60px;
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
        #yspan{
            padding: 4px 10px;
            background-color: #00a0e9;
            color: #fff;
            border-radius: 5px;
            margin-left: 14px;
        }
        .result,.result1{
            color:#00a0e9;
            padding-left: 17px;
        }
        #forms label{
            width: 400px;
        }
        #forms{
            margin-top: 10px;
        }
        /*超出加滚动条*/
        .mui-bar-nav~.mui-content {
            height: 100%;
            background: #fff;
            overflow: auto;
        }
    </style>
</head>

<body data-role="page">
<header data-role="header" class="mui-bar mui-bar-nav" id="header">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" ></a>
    <h1 class="mui-title" id="mtitle">日程详情</h1>
    <a href="javascript:;" id="addes" class="mui-pull-right " style="padding-top: 14px;padding-right: 5px;" >删除</a>
    <a href="javascript:;" id="add1" class="mui-pull-right " style="padding-top: 14px;padding-right: 22px;" >编辑</a>
</header>
<div class="mui-content" id="aaa" style="overflow: auto;">
    <ul>
        <li class="ulli">
            <div class="fl" style="height: 50px">日程安排：</div>
            <div class="nav fr">
                <span class="fl fl1">工作事务</span>
                <span  class="fr fr1">个人事务</span>
            </div>
        </li>
        <li class="ulli">优先级别：<a  href="#modals" style="border-right: 1px solid #e2e2e2;" id="ass"><span id="yspan">未指定</span></a></li>
        <li class="ulli" id="demo">开始时间：<span class="result">选择时间</span></li>
        <li class="ulli"id="demo1">结束时间：<span class="result1">选择时间</span></li>
        <li class="ulli">
            <label class="mui-left" style="margin-top: .7rem;">分享人：</label>
            <input type="text" placeholder="选择分享人" disabled="true" style="width: 72%;border:none"  value="" id="tname"/>
            <span id="Popover_0" class='mui-icon mui-icon-plus'  style="margin-top: 8px;display: none" ></span>
        </li>
    </ul>
    <textarea name="" id="cont" disabled="true"  placeholder="输入日程内容" style="padding: 6px 0 0 6px;width: 90%;height: 45%;margin-left: 5%;margin-top: 10px;"></textarea>
</div>

<div id="modal" class="mui-modal">
    <header class="mui-bar mui-bar-nav" id="header2">
        <a class="mui-icon mui-icon-close mui-pull-left" href="#modal"></a>
        <h1 class="mui-title">请选择优先级</h1>
        <a class="mui-btn-link mui-pull-right" id="re_mail" href="javascript:;">确定</a>
    </header>
    <div class="mui-content" style="height: 100%;">
        <ul class="mui-table-view" id="mailtype">
            <li class="mui-table-view-cell" data-type=""><a href="#">未指定</a>
            </li>
            <li class="mui-table-view-cell" data-type="1"><a href="#">重要/紧急</a>
            </li>
            <li class="mui-table-view-cell" data-type="2"><a href="#" >重要/不紧急</a>
            </li>
            <li class="mui-table-view-cell" data-type="3"><a href="#">不重要/紧急</a>
            </li>
            <li class="mui-table-view-cell" data-type="4"><a href="#">不重要/不紧急</a>
            </li>
        </ul>
    </div>
</div>
<%--分享人--%>
<div class="mui-content" style="display: none" id="ccc">
    <div class="mui-bar mui-bar-nav" id="headerApply">
        <a class="mui-icon mui-icon-close mui-pull-left" href="#modal1" id="app"></a>
        <h1 class="mui-title">选择人员</h1>
        <a class="mui-btn-link mui-pull-right" id="re_mailApply">确认</a>
    </div>
    <div  style="height: 100%;">
        <div id="forms">

        </div>
    </div>
</div>
<script>
    $(function(){
        var takeName = sessionStorage.getItem("takeName");
        var content = sessionStorage.getItem("content");
        var stim = sessionStorage.getItem("stim");
        var etim = sessionStorage.getItem("etim");
        var calType = sessionStorage.getItem("calType");
        var calLevel = sessionStorage.getItem("calLevel");
        var calId = $.GetRequest().calId;
        $.ajax({
            url:'/schedule/selCalenderById',
            dataType:'json',
            type:'get',
            data:{
                calId:calId
            },
            success:function(res){
                if(res.object.edit==false){
                    $('#add1,#addes').hide()
                }else {
                    $('#add1,#addes').show()
                }
                if(res.object.calType==1){
                    $('.fl1').addClass('navc')
                }else {
                    $('.fr1').addClass('navc')
                }
                if(res.object.calLevel==1){
                    calLevel="重要/紧急";
                }else if(res.object.calLevel==2){
                    calLevel="重要/不紧急";
                }else if(res.object.calLevel==3){
                    calLevel="不重要/紧急";
                }else if(res.object.calLevel==4){
                    calLevel="不重要/不紧急";
                }else{
                    calLevel="未指定";
                }
                $('#yspan').text(calLevel);
                $('.result').text(new Date(res.object.calTime*1000).Format('yyyy-MM-dd hh:mm'));
                $('.result1').text(new Date(res.object.endTime*1000).Format('yyyy-MM-dd hh:mm'));
                $('#cont').val(res.object.content);
                $('#tname').val(res.object.takeName)
            }
        })

        // if(calType==1){
        //     $('.fl1').addClass('navc')
        // }else {
        //     $('.fr1').addClass('navc')
        // }
        // if(calLevel==1){
        //     calLevel="重要/紧急";
        // }else if(calLevel==2){
        //     calLevel="重要/不紧急";
        // }else if(calLevel==3){
        //     calLevel="不重要/紧急";
        // }else if(calLevel==4){
        //     calLevel="不重要/不紧急";
        // }else{
        //     calLevel="未指定";
        // }
        // $('#yspan').text(calLevel);
        // $('.result').text(stim);
        // $('.result1').text(etim);
        // $('#cont').val(content);

        mui("#header").on('tap', '#addes', function(event){
            var btnArray = ['确认','取消'];
            mui.confirm('确认删除吗！', ' ', btnArray, function (e) {
                if(e.index==0){
                    mui.ajax('/schedule/delete',{
                        data:{
                            'calId':calId
                        },
                        dataType:'json',//服务器返回json格式数据
                        type:'post',//HTTP请求类型
                        success:function(data){
                            if(data.flag){
                                var btnArray = ['确认'];
                                mui.confirm('删除成功', ' ', btnArray, function(e) {
//                                mui.back(e);
                                    mui.openWindow({
                                        url: '/ewx/calendar'
                                    })
                                })
                            }else{
                                mui.toast("删除成功！");
                            }
                        }
                    })
                }else {
                    mui.toast("已取消！");
                }

            })
        })

    })
    //分享人
    $('#tname,#Popover_0').on('tap', function() {
        document.activeElement.blur();
        var bt111 = document.getElementById("aaa");
        var bt = document.getElementById("ccc");
        bt111.style.display= "none";
        header.style.display= "block";
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
                        str+='<div class="mui-input-row  mui-checkbox mui-left">'+
                            '<label style="line-height: 24px">'+arr[i].userName+'</label>'+
                            '<input style="width: 70px;height: 70px;" class="checkbox1" name="checkbox1" value="'+arr[i].userName+'" type="checkbox" userId="'+arr[i].userId+'">'+
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
                    checkVals[k] = rdsObj[i].getAttribute('userId');
                    k++;
                }
            }
            bt111.style.display= "block";
            bt.style.display= "none";
            // header.style.display= "block";
            $('#tname').val(checkVal.join());
            $('#tname').attr('userId',checkVals);
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
    mui("#header").on('tap', '#add1', function(event){
        $("#cont").attr('disabled',false)
        $("#tname").attr('disabled',false)
        $('#Popover_0').show()
        var calId = sessionStorage.getItem("calId");
        $("#addes").remove();
        $("#add1").remove();
        $('#ass').attr('href','#modal')
        $("#header").append('<a href="javascript:;" id="add2" class="mui-pull-right " style="padding-top: 14px;padding-right: 5px;" >保存</a>')
        var con=''
        var conid
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
        mui("#header").on('tap', '#add2', function(event){
            if(mustWrite()==false) {
                return;
            }
            var content=$('#cont').val();
            var takeName=$('#share').val()
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
            mui.ajax('/schedule/editCalender',{
                data:{
                    'calTime':calTime,
                    'endTime':endTime,
                    'content':content,
                    'calType':calType,
                    'calLevel':calLevel,
                    'userId':userId,
                    'calId':calId,
                    taker:$('#tname').attr('userid')
                },
                dataType:'json',//服务器返回json格式数据
                type:'post',//HTTP请求类型
                success:function(data){
                    if(data.flag){
                        var btnArray = ['确认'];
                        mui.confirm('编辑成功', ' ', btnArray, function(e) {
                            mui.openWindow({
                                url: '/ewx/calendar'
                            })
                        })
                    }else{
                        var btnArray = ['确认'];
                        mui.confirm('编辑失败！', ' ', btnArray, function(e) {
                        })
                    }
                }
            })
        })
    });
</script>
</body>
</html>
