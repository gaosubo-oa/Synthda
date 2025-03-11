<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" src="js/jquery/jquery-1.9.1.js"></script>
    <script src="js/base/base.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <title><fmt:message code="main.th.Intranet"/></title><%--内网门户--%>
    <style>
        body,html{
            width:100%;
            height:100%
        }
        .content{
            width:100%;
            /*height:100%;*/
            background: #d4dce8;
            position: relative;
        }
        .row{
            width: calc(100% - 100px);
            margin-left:20px;
        }
        .list{
            width:47%;
            height: 250px;
            background-color: #f5f5f5;
            box-shadow: 5px 4px 1px #969ca5;
            border-radius: 10px;
            float:left;
            margin-right:20px;
            margin-top:20px;
        }
        .top{
            width:100%;
        }
        .top{
            height: 40px;
            border-bottom: 1px solid #e4e4e4;
        }
        .imgs{
            background: url(/img/zgcxt/pxzq.png);
            width: 17px;
            height: 20px;
            display: inline-block;
            float: left;
            margin-left: 20px;
            margin-top: 10px;
            vertical-align: middle;
        }
        .title{
            float: left;
            height: 30px;
            line-height: 30px;
            margin-left: 12px;
            margin-top: 4px;
            width: 180px;
            color: #2797d5;
            font-size: 17px;
            font-weight: bold;
            font-family: 'Microsoft Yahei';
        }
        .more{
            font-size: 13px;
            color: #585858;
            margin-top: 10px;
            /*margin-right: 20px;*/
            float: right;
            cursor:pointer
        }
        .demoList{
            padding-right: 15px;
            padding-left: 15px;
            margin-right: auto;
            margin-left: auto;
            margin-top: 18px;
        }
        .con{
            margin-right: -15px;
            margin-left: -15px;
        }
        .text:hover{
            color:#2898d6;
            text-decoration:#2898d6 ;
        }
        .leftImg{
            width:10%;
            text-align: center;
            float:left;
        }
        .imgcircle{
            margin-top: 4px;
            margin-left: 10px;
            vertical-align: middle;

        }
        .text{
            font-size: 14px;
            font-family: 微软雅黑;
            color: #333333;
            white-space: nowrap;
            text-overflow: ellipsis;
            width:52%;
            overflow: hidden;
            float:left;
        }
        .divPadding{
            height: 28px;
            line-height: 28px;
            padding-left: 5px;
            padding-right: 0px;
        }
        .date{
            float:right;
            width:28%;
            text-align: center;
        }
        .auxiliaryTool{
            font-size: 14px;
            width: 76px;
            position: absolute;
            right: 20px;
            margin-left: -38px;
            top: 20px;
            z-index: 2147483640;
        }
        .toolList{
            width:76px;
            margin:0;
        }
        .slidelifirst{
            height: 69px;
            background: url(/img/zgcxt/TOP2.png);
        }
        .slideli{
            height: 69px;
            background: url(/img/zgcxt/middle2.png);
        }
        .slidelilast{
            height: 74px;
            background: url(/img/zgcxt/FOOT.png);
        }
        .slidediv{
            width: 75px;
            height: 74px;
            text-align: center;
            cursor: pointer;
        }
        .slideimg{
            margin-top: 11px;
            vertical-align: middle;
        }
        .slidespan{
            display: block;
            margin-top: 5px;
        }
        .hide{
            visibility: hidden;
        }



    </style>
</head>
<body>
<div class="content">
    <div class="auxiliaryTool">
        <ul class="toolList">
            <li class="slidelifirst">
                <div class="slidediv" onclick="parent.getMenuOpen(this)"  menu_tid="1" data-url="/imDemo" onmouseover="slidediv_mouseover('wlxh',this)" onmouseout="slidediv_mouseout('wlxh',this)">
                    <img id="wlxh" class="slideimg" src="/img/zgcxt/wlxh.png">
                    <div class="slidespan" >网络寻呼<h2 class="hide">网络寻呼</h2></div>
                </div>
            </li>
            <li class="slideli">
                <div class="slidediv" onclick="parent.getMenuOpen(this)"  menu_tid="0138" data-url="sms/index" onmouseover="slidediv_mouseover('dbsx',this)" onmouseout="slidediv_mouseout('dbsx',this)">
                    <img id="dbsx" class="slideimg" src="/img/zgcxt/dbsx.png">
                    <div class="slidespan" >待办任务<h2 class="hide">待办任务</h2></div>
                </div>
            </li>
            <li class="slideli">
                <div class="slidediv" onclick="parent.getMenuOpen(this)"  menu_tid="3" data-url="/mailDemo" onmouseover="slidediv_mouseover('qfdx',this)" onmouseout="slidediv_mouseout('qfdx',this)">
                    <img id="qfdx" class="slideimg" src="/img/zgcxt/qfdx.png">
                    <div class="slidespan" >群发短信<h2 class="hide">群发短信</h2></div>
                </div>
            </li>
            <li class="slidelilast">
                <div class="slidediv">
                    <img id="add" class="slideimg" src="/img/zgcxt/add.png">
                    <div class="slidespan">添加</div>
                </div>
            </li>
        </ul>
    </div>
       <ul class="row">
           <li class="list">
               <div class="top">
                   <div class="left">
                       <span class="imgs"></span>
                       <span class="title">工作信息</span>
                       <div  class="more" onclick="parent.getMenuOpen(this)"  menu_tid="0116" data-url="notify/show">更多 >><h2 class="hide">工作信息</h2></div>
                   </div>
               </div>
               <ul class="demoList" id="data1">
                   <%--<li class="con">--%>
                       <%--<div class="leftImg"><img class="imgcircle" src="/img/zgcxt/1.png"></div>--%>
                       <%--<div class="text divPadding">啊的叫法是地方捷顺的拉法基打扫房间士大夫金大福</div>--%>
                       <%--<div class="date divPadding">2019-01-22</div>--%>
                   <%--</li>--%>
               </ul>
           </li>
           <li class="list">
               <div class="top">
                   <div class="left">
                       <span class="imgs"></span>
                       <span class="title">通知公告</span>
                       <div  class="more" onclick="parent.getMenuOpen(this)"  menu_tid="0117" data-url="notify/show">更多 >><h2 class="hide">通知公告</h2></div>
                   </div>
               </div>
               <ul class="demoList" id="data2">
                   <%--<li class="con">--%>
                       <%--<div class="leftImg"><img class="imgcircle" src="/img/zgcxt/1.png"></div>--%>
                       <%--<div class="text divPadding">啊的叫法是地方捷顺的拉法基打扫房间士大夫金大福</div>--%>
                       <%--<div class="date divPadding">2019-01-22</div>--%>
                   <%--</li>--%>
               </ul>
           </li>
           <li class="list">
               <div class="top">
                   <div class="left">
                       <span class="imgs"></span>
                       <span class="title">财务制度</span>
                       <div  class="more" onclick="parent.getMenuOpen(this)"  menu_tid="0118" data-url="notify/show">更多 >><h2 class="hide">财务制度</h2></div>
                   </div>
               </div>
               <ul class="demoList" id="data3">
                   <%--<li class="con">--%>
                       <%--<div class="leftImg"><img class="imgcircle" src="/img/zgcxt/1.png"></div>--%>
                       <%--<div class="text divPadding">啊的叫法是地方捷顺的拉法基打扫房间士大夫金大福</div>--%>
                       <%--<div class="date divPadding">2019-01-22</div>--%>
                   <%--</li>--%>
               </ul>
           </li>
           <li class="list">
               <div class="top">
                   <div class="left">
                       <span class="imgs"></span>
                       <span class="title">培训专区</span>
                       <div  class="more" onclick="parent.getMenuOpen(this)"  menu_tid="0119" data-url="notify/show">更多 >><h2 class="hide">培训专区</h2></div>
                   </div>
               </div>
               <ul class="demoList" id="data4">
                   <%--<li class="con">--%>
                       <%--<div class="leftImg"><img class="imgcircle" src="/img/zgcxt/1.png"></div>--%>
                       <%--<div class="text divPadding">啊的叫法是地方捷顺的拉法基打扫房间士大夫金大福</div>--%>
                       <%--<div class="date divPadding">2019-01-22</div>--%>
                   <%--</li>--%>
               </ul>
           </li>
           <li class="list">
               <div class="top">
                   <div class="left">
                       <span class="imgs"></span>
                       <span class="title">业务模板</span>
                       <div  class="more" onclick="parent.getMenuOpen(this)"  menu_tid="0120" data-url="notify/show">更多 >><h2 class="hide">业务模板</h2></div>
                   </div>
               </div>
               <ul class="demoList" id="data5">
                   <%--<li class="con">--%>
                       <%--<div class="leftImg"><img class="imgcircle" src="/img/zgcxt/1.png"></div>--%>
                       <%--<div class="text divPadding">啊的叫法是地方捷顺的拉法基打扫房间士大夫金大福</div>--%>
                       <%--<div class="date divPadding">2019-01-22</div>--%>
                   <%--</li>--%>
               </ul>
           </li>
           <li class="list">
               <div class="top">
                   <div class="left">
                       <span class="imgs"></span>
                       <span class="title">智慧科协建设工作专区</span>
                       <div  class="more" style="margin-right: -113px;" onclick="parent.getMenuOpen(this)"  menu_tid="0121" data-url="notify/show">更多 >><h2 class="hide">智慧科协建设工作专区</h2></div>
                   </div>
               </div>
               <ul class="demoList" id="data6">
                   <%--<li class="con">--%>
                       <%--<div class="leftImg"><img class="imgcircle" src="/img/zgcxt/1.png"></div>--%>
                       <%--<div class="text divPadding">啊的叫法是地方捷顺的拉法基打扫房间士大夫金大福</div>--%>
                       <%--<div class="date divPadding">2019-01-22</div>--%>
                   <%--</li>--%>
               </ul>
           </li>
       </ul>
</div>
<script>



    $(function () {
        var height = $(document).height();
        $('.content').height(height)
        getPicApplication('01','#data1');
        getPicApplication('02','#data2');
        getPicApplication('03','#data3');
        getPicApplication('04','#data4');
        getPicApplication('05','#data5');
        getPicApplication('06','#data6');


    })

    function slidediv_mouseover(imgid,e){

        $(e).find('img').attr('src','/img/zgcxt/'+imgid+"02.png")
        if(imgid == 'wlxh'){
            $(e).parent().css('background','url(/img/zgcxt/TOP.png)')
        }else{
            $(e).parent().css('background','url(/img/zgcxt/middle.png)')
        }
        $(e).find('.slidespan').css('color','#fff')
    }
    function slidediv_mouseout(imgid,e){
        $(e).find('img').attr('src','/img/zgcxt/'+imgid+".png")
        if(imgid == 'wlxh'){
            $(e).parent().css('background','url(/img/zgcxt/TOP2.png)')
        }else{
            $(e).parent().css('background','url(/img/zgcxt/middle2.png)')
        }
        $(e).find('.slidespan').css('color','#000')

    }
    function getPicApplication(type,element) {
        var typeName="";
        if(type == '01'){
            typeName = '工作信息'
        }else if(type == '02'){
            typeName = '通知公告'
        }else if(type == '03'){
            typeName = '财务制度'
        }else if(type == '04'){
            typeName = '培训专区'
        }else if(type == '05'){
            typeName = '业务模板'
        }else if(type == '06'){
            typeName = '智慧科协建设工作专区'
        }
        $.ajax({
            type:'get',
            url:'/notice/notifyList',
            data:{
                page: 1,
                pageSize: 6 ,
                useFlag: true,
                typeId: type,
                changeId: 1,
                exportId: 1,
                read:""
            },
            dataType:'json',
            success:function (res) {
                var data=res.obj;
                if(res.obj.length > 0){
                    var str='';
                    for(var i = 0;i<data.length;i++){
                        str += ' <li class="con">\n' +
                            '                       <div class="leftImg"><img class="imgcircle" src="/img/zgcxt/1.png"></div>\n' +
                            '                       <div class="text divPadding" onclick="parent.getMenuOpen(this)" menu_tid="'+typeName+i+'" data-url="/detailDemo?notifyId='+data[i].notifyId+'">'+data[i].subject+'<h2 class="hide">'+typeName+'</h2></div>\n' +
                            '                       <div class="date divPadding">'+data[i].sendTime.split(' ')[0]+'</div>\n' +
                            '                   </li>'
                    }

                    $(element).html(str);
                }
            }
        })
    }

</script>
</body>
</html>
