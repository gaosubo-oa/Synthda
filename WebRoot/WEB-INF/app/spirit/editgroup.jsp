<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>编辑群组</title>
    <script type="text/javascript" src="../js/xoajq/xoajq1.11.1.js"></script>
    <script type="text/javascript" src="../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>
    <style>
        *{
            padding: 0;
            margin: 0;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }
        span{
            font-size:14px;
            color: #666666;
        }
        ul, ol ,li{
            list-style: none;
        }
        td{
            padding: 10px 0;
            font-size: 15px;
        }
        input,textarea{
            border: 1px solid #d6d7d8;
            border-radius: 2px;
        }
        body{
            background-color: #f3f6f9;
        }
        #body{
            min-width:600px;
            height:100%;
        }
        .table{
            width: 580px;
            margin: 0 auto;
            margin-top: 50px;
        }
        .tlname{
            width: 110px;
        }
        /*************input里面字体颜色************************/
        input::-webkit-input-placeholder { /* WebKit browsers */
            color:    #000;

        }
        input:-moz-placeholder { /* Mozilla Firefox 4 to 18 */
            color:    #000;
        }
        input::-moz-placeholder { /* Mozilla Firefox 19+ */
            color:    #000;
        }
        input:-ms-input-placeholder { /* Internet Explorer 10+ */
            color:    #000;
        }
        /*************textarea里面字体颜色************************/
        textarea::-webkit-input-placeholder { /* WebKit browsers */
            color:    #a1a1a1;

        }
        textarea:-moz-placeholder { /* Mozilla Firefox 4 to 18 */
            color:    #a1a1a1;
        }
        textarea::-moz-placeholder { /* Mozilla Firefox 19+ */
            color:    #a1a1a1;
        }
        textarea:-ms-input-placeholder { /* Internet Explorer 10+ */
            color:    #a1a1a1;
        }
        .btn{
            cursor: pointer;
            padding: 4px 10px;
            border: none;
            border-radius: 2px;
        }
        .add{
            background-color: #4ca1d1;
            color: #fff;
            border:1px solid #4ca1d1;
        }
        .delete{
            background-color: #fff;
            margin-left: 8px;
            border:1px solid #a7a7a7
        }
        .btnbox{
            position: absolute;
            bottom: 25px;
            right: 20px;
        }
        .btn1{
            cursor: pointer;
            padding: 5px 15px;
            border: none;
            border-radius: 2px;
        }
        .save{
            background-color: #1193eb;
            color: #fff;
        }
        .close{
            margin-left: 8px;
        }
    </style>
</head>
<body>
<div id="body">
    <table class="table">
        <tr>
            <td class="tlname">讨论组名称：</td>
            <td><input type="text" placeholder="设计讨论群" style="text-indent: 5px;width: 160px;height: 25px;" class="name"></td>
        </tr>
        <tr>
            <td class="tlname" valign="top">讨论组成员：</td>
            <td style="position:relative;">
                <textarea name="" id="" cols="30" rows="10" placeholder="请选择讨论组成员" style="text-indent: 5px;padding-top: 2px;width: 100%;"></textarea>
                <div class="btnbox">
                    <button class="btn add" >添加</button>
                    <button class="btn delete" >删除</button>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="position:relative;">
                <div style="position:absolute;right: -20px;">
                    <button class="btn1 save" onclick="save()">保存</button>
                    <button class="btn1 close" >取消</button>
                </div>
            </td>
        </tr>
    </table>

</div>

<script>
    function GetQueryString(name)
    {
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }

    function save(){
        var timestamp = Date.parse(new Date())/1000;
        var name = $('.name').val();
        var set_uid = GetQueryString('set_uid');
        var eid = GetQueryString('eid');
        var set_of = eid + 'pq' + set_uid + '@gsubo';
        var room_of = timestamp + '@gsrooms.gsubo';
        console.log(timestamp,name);
//            $.ajax({
//                url:'/im/insertRoom',
//                type:'get',
//                dataType:'json',
//                data:{
//                    name:name,
//                    set_uid:set_uid,
//                    set_of:set_of,
//                    member_uid:,
//                    stime:timestamp,
//                    room_of:set_of
//                },
//                success:function(data){
//
//                }
//            })
    }
    $(function(){

    })

</script>
</body>
</html>