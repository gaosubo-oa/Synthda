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
    <script type="text/javascript" src="../js/xoajq/xoajq1.11.1.js"></script>
    <script type="text/javascript" src="../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>
    <title>管理群组</title>
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
        body{
            background-color: #f3f6f9;
        }
        #body{
            min-width:980px;
            height:100%;
        }
        .table{
            width: 990px;
            margin: 0 auto;
            margin-top: 30px;
            border-collapse: collapse;
            text-align: center;

        }
        td{
            padding: 15px 0px;
            border: 1px solid #cacaca;
            letter-spacing: 1px;
        }
        thead td{
            font-weight:600;
            font-size:16px;
            color: #333333;
        }
        .tbody{
            background-color: #fff;
        }
        .tbody td{
            color: #444;
            font-size:15px;
        }
        .edit_closeBox{
            float: left;
            width: 50px;
            position: relative;
            cursor: pointer;
        }
        .box_img{
            position: absolute;
            left: 0;
            top: 3px;
        }
        .spans{
            float: right;
        }
        .spans:hover{
            color: #008ae7;
        }
        .left_box{
            margin-left: 18px;
            margin-right: 36px;
        }
        .soso{
            padding: 15px 10px;
        }
        .jsonstring{
            display: none;
        }

    </style>
</head>
<body>
        <div id="body">
            <table class="table">
                <thead style="background-color: #ebf1f6">
                    <td style="width: 190px;">讨论群组名称</td>
                    <td style="width: 280px;">讨论群组成员</td>
                    <td style="width: 150px;">创建人</td>
                    <td style="width: 190px;">创建时间</td>
                    <td style="">操作</td>
                </thead>
                <tbody class="tbody">
                    <tr>
                        <td>设计讨论组</td>
                        <td class="soso">王德亮，李青，梁红，李立峰</td>
                        <td>王德亮</td>
                        <td>2017-09-22</td>
                        <td>
                            <div class="edit_closeBox left_box">
                                <img src="../img/spirit/managegroup_edit.png" alt="" class="box_img">
                                <span class="spans">编辑</span>
                            </div>
                            <div class="edit_closeBox">
                                <img src="../img/spirit/managegroup_close.png" alt="" class="box_img">
                                <span class="spans">解散</span>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td>设计讨论组</td>
                        <td class="soso">王德亮，李青，梁红，李立峰，王德亮，李青，梁红，李立峰，王德亮，李青，梁红，李立峰</td>
                        <td>王德亮</td>
                        <td>2017-09-22</td>
                        <td>
                            <div class="edit_closeBox left_box">
                                <img src="../img/spirit/managegroup_edit.png" alt="" class="box_img">
                                <span class="spans">编辑</span>
                            </div>
                            <div class="edit_closeBox">
                                <img src="../img/spirit/managegroup_close.png" alt="" class="box_img">
                                <span class="spans">解散</span>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <script>
            function doQtPer(uid){
                console.log(uid);
                new QWebChannel(qt.webChannelTransport, function(channel) {
                    var content = channel.objects.interface;
                    content.xoa_sms(uid,'',"SEND_MSG");
                });
            }
            function getLocalTime(e) {
                var now = new Date();
                now.setTime(e * 1000);
                return now.toLocaleDateString();
            }
            function edit(e){
                var uid = e.find('.jsonstring').text();
                doQtPer(uid);
            }
            function closes(e){
                var btID = e.attr('btID');
                $.ajax({
                    url:'/im/getOutPerson',
                    type:'get',
                    dataType:'json',
                    data:{
                        flag:11,
                        room_id:btID,
                        opt:2
                    },
                    success:function(data){
                        alert('删除成功!');
                        e.parents('tr').remove();
                    }

                })
            }
            $(function(){
                $.ajax({
                    url:'/user/userCookie',
                    type:'get',
                    dataType:'json',
                    data:{},
                    success:function(data){
                        console.log(data);
                        var uid = data.object.uid;
                        $.ajax({
                            url:'/im/getAllRoom',
                            type:'get',
                            dataType:'json',
                            data:{
                                uid:uid
                            },
                            success:function(data){
                                console.log(data);
                                var str ='';
                                for(var i=0;i<data.length;i++){
                                    var stime = getLocalTime(data[i].rtime);
                                    var str_json = JSON.stringify(data[i]);
                                    console.log(stime);
                                    str +=  '<tr>'+
                                               '<td>'+data[i].rname+'</td>'+
                                                '<td class="soso">'+data[i].rmemberUidName+'</td>'+
                                                '<td>'+data[i].rsetUidName+'</td>'+
                                                '<td>'+stime+'</td>'+
                                                '<td>'+
                                                    '<div class="edit_closeBox left_box" onclick="edit($(this))">'+
                                                        '<img src="../img/spirit/managegroup_edit.png" alt="" class="box_img">'+
                                                        '<span class="spans">编辑</span>'+
                                                    '</div>'+
                                                    '<div class="edit_closeBox" onclick="closes($(this))" btID="'+data[i].btID+'">'+
                                                        '<img src="../img/spirit/managegroup_close.png" alt="" class="box_img">'+
                                                        '<span class="spans">解散</span>'+
                                                        '<div class="jsonstring">'+ str_json +'</div>'+
                                                    '</div>'+
                                                '</td>'+
                                            '</tr>'
                                }
                                $('.tbody').html(str);
                            }

                        })
                    }

                })



            })
        </script>
</body>
</html>