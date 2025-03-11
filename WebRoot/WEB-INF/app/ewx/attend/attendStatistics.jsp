<%--
  Created by IntelliJ IDEA.
  User: gaoran
  Date: 2020/3/27
  Time: 14:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>考勤统计详情</title>
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
            height: 100%;
            background: #fff;
            overflow: auto;
        }
        #beginTime{
            display: block;
            width: 48%;
            margin: 0 auto;
        }
        .attendance{
            color: #ccc;
            font-size: 14px;
            margin-top: .6rem;
            font-size: 15px;
        }
        .radiu{
            width: 2.5rem;
            height: 2.5rem;
            font-size: 1rem;
            line-height: 2.5rem;
            text-align: center;
            color: #00CCFF;
            border-radius: 50%;
            border: 1px solid #00CCFF;
            float: left;
            margin-top: .8rem;
            margin-left: 0.8rem;
            overflow: hidden;
        }
        .list{
            display: block;
            height: 4.2rem;
        }
    </style>
</head>
<body>
<div class="mui-content" id="aaa" style="overflow: auto">
    <div style="margin-top: 15px;">
        <span style="margin-left: 12px;">姓名</span>
        <input type="text" name="userName" style="width: 70%;height: 36px;border-radius: 10px;margin-bottom: 0;">
        <button type="button" class="mui-btn mui-btn-primary username" style="vertical-align: middle;border-radius: 10px">搜索</button>
    </div>
    <ul class="c_con_ul">

    </ul>
</div>
</body>
</html>
<script>
    var uid
    mui.ajax('/user/getAlluser', {
        dataType: 'json',//服务器返回json格式数据
        type: 'post',//HTTP请求类型
        data:{
            notLogin:0
        },
        success: function (data) {
            if(data.flag){
                var str=""
                var arr = data.obj
                for(var i=0;i<arr.length;i++){
                    var user = arr[i].userName.substr(0,1)
                    var username = arr[i].userName
                    var deptName=  arr[i].deptName
                    str+='<li style="height: 4.2rem; border-bottom: 1px solid #c8c7cc;">\n'+
                        // '<a class="list" href="/ewx/AttendStatistics?uid='+arr[i].uid+'">\n' +
                        '<a class="list" href=/ewx/attendStatisticsDetail?uid='+arr[i].uid+'&username='+username+'>\n' +
                        '<div class="radiu" style="overflow: hidden">'+user+'</div>\n'+
                        '<div style="font-size: 15px;width: 17rem; padding-top: .8rem;margin-left: 4rem;box-sizing: border-box">\n'+
                        '<div style="line-height: 2.5rem;font-size: 18px;color: #000;">\n'+
                        '<span style="display: inline-block">'+kong(username)+'</span><span style="display: inline-block">('+dept(deptName)+')</span>\n'+
                        '</div>\n'+
                        '</div>\n'+
                        '</a>'
                    '</li>'
                }
                $('.c_con_ul').html(str)
            }else{
                var app=' <li style=" height: 3rem;font-size: 20px;text-align: center;line-height: 3rem;border-bottom: 1px solid #ccc;">暂无数据</li>'
                $('.c_con_ul').html(app)
            }

        }
    });
    $('.username').on('tap', function() {
        mui.ajax('/user/getAlluser', {
            dataType: 'json',//服务器返回json格式数据
            type: 'get',//HTTP请求类型
            data:{
                notLogin:0,
                userName:$('input[name="userName"]').val()
            },
            success: function (data) {
                if(data.obj==undefined || data.obj== ""){
                    var app=' <li style=" height: 3rem;font-size: 20px;text-align: center;line-height: 3rem;border-bottom: 1px solid #ccc;">暂无数据</li>'
                    $('.c_con_ul').html(app)
                }else{
                    var str=""
                    var arr = data.obj
                    for(var i=0;i<arr.length;i++){
                        var user = arr[i].userName.substr(0,1)
                        var username = arr[i].userName
                        var deptName=  arr[i].deptName
                        str+='<li style="height: 4.2rem; border-bottom: 1px solid #c8c7cc;">\n'+
                            // '<a class="list" href="/ewx/AttendStatistics?uid='+arr[i].uid+'">\n' +
                            '<a class="list" href=/ewx/attendStatisticsDetail?uid='+arr[i].uid+'&username='+username+'>\n' +
                            '<div class="radiu" style="overflow: hidden">'+user+'</div>\n'+
                            '<div style="font-size: 15px;width: 17rem; padding-top: .8rem;margin-left: 4rem;box-sizing: border-box">\n'+
                            '<div style="line-height: 2.5rem;font-size: 18px;color: #000;">\n'+
                            '<span style="display: inline-block">'+kong(username)+'</span><span style="display: inline-block">('+dept(deptName)+')</span>\n'+
                            '</div>\n'+
                            '</div>\n'+
                            '</a>'
                        '</li>'
                    }
                    $('.c_con_ul').html(str)
                }
            }
        });
    })
    function kong(username){
        if(username==undefined||username==""){
            return "暂无人员"
        }else{
            return username
        };
    }
    function dept(deptName){
        if(deptName==undefined||deptName==""){
            return "暂无部门"
        }else{
            return deptName
        };
    }
</script>
