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
    <title><fmt:message code="mian.panel" /></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/sys/userInfor.css"/>
    <link rel="stylesheet" type="text/css" href="/css/sys/url.css"/>

<%--    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <%--<script src="../js/sys/userInfor.js" type="text/javascript" charset="utf-8"></script>--%>

    <style>
        #new {
            display: block;
            float: right;
            width: 90px;
            height: 28px;
            background: url("../img/file/cabinet01.png") no-repeat;
            margin: 18px;
            color: #fff;

            line-height: 28px;
            cursor: pointer;
        }
        #new span{
            font-size: 14px;
            line-height: 28px;
            margin-left: 26px;
        }
        .content{
            background-color: #ffffff;
        }
        .content .right{
            float: left;
            width: 100%;
            font-size: 14px;
            overflow-y: auto;
            height: 100%;
        }
        .title{
            height:35px;
            line-height:35px;
        }
        .title span{
            margin-left:0px;
            font-size:22px;
            line-height:35px;
        }
        .title img{
            margin-left:15px;
            vertical-align: middle;
            width:24px;
            height:26px;
            padding-bottom:8px;
        }
        #new{
            margin:6px 15px 0px 0px;
        }
        .tab table tr th, .tab table tr td{
            text-align:left;
            padding-left:10px;
        }
        .tab table tr th {
            font-size: 13pt;
        }
        .tbody td{
            font-size: 11pt;
        }
    </style>
</head>
<body>
<div class="content">
    <div class="right">
        <div class="outPerson" style="">
            <div class="title">
                <img src="../img/person.png" >
                <span><fmt:message code="url.th.address" /></span>
                <a href="javascript:void (0)" class="new" id="new" style=""><span><fmt:message code="url.th.NewURL" /></span></a>
            </div>
            <div class="tab" style="">
                <table cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
                    <thead>
                    <tr class='tr_befor'>
                        <th class="th">
                            <fmt:message code="workflow.th.Serial" />
                        </th>
                        <th class="th" style="text-align: center">
                            <fmt:message code="roleAuthorization.th.Explain" />
                        </th>
                        <th class="th" style="text-align: center">
                            <fmt:message code="url.th.http" />
                        </th>
                        <th class="th">
                            <fmt:message code="notice.th.type" />
                        </th>
                        <th class="th">
                            <fmt:message code="notice.th.operation" />
                        </th>
                    </tr>
                    </thead>
                    <tbody class="tbody">


                    </tbody>

                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script>
    var userId;
    $('#new').on('click',function(){
       /* parent.urlHref('urlAdress')*/
        window.location.href = '/controlpanel/urlAdress';
    });
    //展示列表
    $.get('/controlpanel/selectUrl',function (json) {
        if(json.flag){
            var str='';
            for(var i=0;i<json.obj.length;i++){
                str+='<tr uId="'+json.obj[i].urlId+'">' +
                    '<td>'+(i+1)+'</td>' +
                    '<td style="text-align: center">'+json.obj[i].urlDesc+'</td>' +
                    '<td style="text-align: center"><a href='+json.obj[i].url+' target="_blank">'+json.obj[i].url+'</a></td>' +
                    '<td>'+function () {
                        if(json.obj[i].urlType==0){
                            return '<fmt:message code="url.th.commen" />'
                        } else if(json.obj[i].urlType==1){
                            return '<fmt:message code="url.th.Subscribe" />'
                        }
                    }()+'</td>' +
                    '<td><a href="javascript:;"  style="margin-right:10px" id="edit"><fmt:message code="global.lang.edit" /></a>' +
                    '<a href="javascript:;" class="delone" uId="'+json.obj[i].urlId+'"><fmt:message code="global.lang.delete" /></a>' +
                    '</td>' +
                    '</tr>'
            }
            $('.tbody').html(str)

        }
    },'json')
    //点击编辑，根据urlId查出信息再进行修改
    $('.tab').on('click','#edit',function(){
        var userId=$(this).parents('tr').attr('uId');
        $.popWindow('editAdress?userId='+ userId+'' ,'<fmt:message code="global.lang.edit" />','100','300','800px','600px');
        window.location.reload();
    })

    $(function(){
        $('.tab').on('click','.delone',function () {
            var uId=$(this).attr('uId');
            layer.confirm('<fmt:message code="sup.th.Delete" />？', {
                btn: ['<fmt:message code="menuSSetting.th.menusetsure" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
                title:"<fmt:message code="notice.th.DeleteFile" />"
            }, function(){
                //确定删除，调接口
                $.ajax({
                    type:'post',
                    url:'/controlpanel/deleteUrl',
                    dataType:'json',
                    data:{'urlId':uId},
                    success:function(){
                        layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});
                        location.reload();
                    }
                });
            }, function(){
                layer.closeAll();
            });
        })
    })

    /* $(function () {
     $.ajax({
     type:'post',
     url:'/controlpanel/deleteUrl',
     dataType:'json',
     data:{'urlId':urlId},
     success:function(){
     layer.msg(' <fmt:message  code="workflow.th.delsucess"/>', { icon:6});
     /!* init(4,id,1);*!/
     window.location.reload();
     }
     })
     })*/





</script>

    <%--
    var kkkk=20;
    var sex='女';
    var str='<li>姓名</li>' +
    '<span>'+kkkk+'</span>' +
    '<li>性别</li>' +
    '<span>'+sex+'</span>'--%>
