<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><fmt:message code="notice.th.queryDetail" /></title>
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style type="text/css">
        body{padding: 0;margin: 0;font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;width: 100%;}
        .detailsContent{width: 80%;overflow: hidden;margin:0 auto}
        .detailsContent .title{
            width: 100%;
            text-align: center;
            height: 60px;
            line-height: 60px;
            color: #2a588c;


            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;

            font-family: 微软雅黑;
            font-size: 24px;
            text-align: center;
            color: #2898d6;
        }
        .headMsg{
            color:#2898d6;
            font-size: 13px;
            text-align: center;
            border-bottom: 1px solid grey;
            line-height: 20px;
        }
        .infor{width: 100%;overflow: hidden;height: 40px;background-color: #d3e7fa;}
        .infor ul{list-style: none;overflow: hidden;float: right;margin-top: 10px;}
        .infor ul li{float: left;margin-right: 20px;}
        .infor ul li span{font-size: 14px;}
        .divContent{width: 100%;}
        .divContent .divTxt{margin: 30px 20px;}
        .divContent .divTxt p{font-size: 14px;color: #444;line-height:25px;}
        .divContent .keyWord{margin: 0 0 10px 50px;}
        .divContent .keyWord span{margin-right: 10px;color: #2b7fe0;}
        .btnImg{width: 100%;}
        .btnImg .margin{width: 370px;margin: 20px auto;}
        .btnImg .margin a{margin-right: 20px;}

    </style>
    <script type="text/javascript">
        $(function () {
            var height = $(document).height();
            $('html').height(height+20).css('background','#fff')

            var nid=$.GetRequest().notifyId;

            $.ajax({
                type:'get',
                url:'/notice/getOneById',
                dataType:'json',
                data:{'notifyId':nid},
                success:function(rsp){
                    var data1=rsp.object;
                    var str='';
                    $('.title').text(data1.subject);
                    str='<li><span>'+data1.fromId+'</span></li><li><span><fmt:message code="notice.th.postedto" />：</span><span>'+data1.sendTime+'</span></li>';
                    $('ul').append(str);
                    $('.divTxt').append('<p>'+data1.content+'</p>');
                }
            });

        }) ;
    </script>
</head>
<body>
<div class="detailsContent">
    <div class="title"></div>
    <div class="headMsg">
        <span>
            发布时间： <span>2019-01-30 14:30:21</span>   发布部门： <span>办公室</span>   点击量： <span>84</span>
        </span>
    </div>
    <%--<div class="infor">--%>
        <%--<ul>--%>
            <%--<!-- <li><span>高波</span></li> -->--%>
            <%--<!-- <li><span>发布于：</span><span>2017-03-23 10:17</span></li> -->--%>
            <%--<!-- <li><span>点击次数<span>92</span>次</span></li> -->--%>
        <%--</ul>--%>
    <%--</div>--%>
    <div class="divContent">
        <div class="divTxt">
            <!-- <p>最近招聘的几位员工都和我反映原来公司加班太多，还有的常加班到半夜，我认为：作为公司主管，一方面应根据发展需要保障用人需求；另一方面要强化团队的时间成本意识，改进工作方法，提高时间管理水平。</p>
            <p>我常和员工说，你们在公司的时间不仅是你们自己的，更是企业付费买来的，企业不允许任何一个人浪费时间。我自己也这样要求自己，虽然每天只工作4个多小时，但工作目标明确，力求每日有所成。</p>
            <p>我总结了几个团队提高效率的方法与大家分享：</p>
            <p>1、团队人员要实现高效沟通，如果协作不畅、信息错误会浪费大量团队时间，根据我的经验，浪费比例可能高达30%。</p>
            <p>2、团队主管要善于合理分工，及时调度，有一双能发现不和谐因素的慧眼，发现并消除影响整体前进的绊马索。</p>
            <p>3、每个成员都要勤于思考，行动前做好计划，不要盲目开动。做事不能拼体力要动脑子。</p>
            <p>4、改善效率工具，特别对于重复性工作，找到或自己开发效率工具，尽量减少核心人员的低层次时间消耗。另外，通过OA等协作软件也可有效提升组织内部效率。</p>
            <p>5、善于利用碎片时间取得进展，牛顿在花园散步，看到苹果落地引发联想，就说明了长期伏案工作未必就有成果。有时换个环境换个脑筋可能就开窍了。</p>
            <p>总结：工作是永远干不完的，追求健康与精神愉快比追求物质回报更有价值。找到合适的方法，减少无谓的时间消耗，或许就可以让你少加班，多些休息娱乐时间，心情好、身体好最重要！</p> -->
        </div>
        <!-- <div class="keyWord">
            <b>本文关键词：</b><span>时间</span><span>团队</span><span>效率</span><span>浪费</span><span>方法</span>
        </div> -->
    </div>
</div>
<!-- <div class="btnImg">
    <div class="margin">
        <a href="javascript:;"><img src="../img/forward_btn.png"/></a>
        <a href="javascript:;"><img src="../img/up_btn.png"/></a>
        <a href="javascript:;"><img src="../img/next_btn.png"/></a>
        <a href="javascript:;"><img src="../img/close_btn.png"/></a>
    </div>
</div> -->
</body>
</html>

