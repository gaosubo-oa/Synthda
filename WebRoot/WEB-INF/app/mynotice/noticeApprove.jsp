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
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title id="noticeTitle"></title>
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1" />
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>



    <!-- 新闻管理  -->
    <script src="/js/xoajq/xoajq1.js"></script>
    <script src="../js/news/page.js"></script>

    <script src="../lib/laydate/laydate.js"></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>


    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="/js/base/tablePage.js"></script>

</head>
<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
<body>
<div class="head-top">
    <ul class="clearfix">
        <li class="fl head-top-li active" data-type="">待审批</li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li" data-type="0">已审批</li>
    </ul>
</div>
<br>
<br>
<div class="navigation" style="margin-top: 46px;">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/daishen.png" alt="">
    <h2>待审批</h2>
</div>
<div id="pagediv">

</div>
<script>
    var specifyTable= $.GetRequest()['notice_type'] || '';
    var objs=null;
    $(function(){
        $.get("/myNotifyConfig/getNotifyType?noticeType="+specifyTable,function(res){
            $('#noticeTitle').text(res.data.mynotice_menu3_name)
        })
    })
    function check(name){
        if(name == ''||name == undefined){
            return '无'
        }else{
            return name
        }
    }
    function daishen() {
        var screenwidth = document.documentElement.clientWidth;
        if(screenwidth > 1320){
            var nums = screenwidth*0.97;
            var sumwidth = screenwidth*0.97+'px';
        }else{
            var nums = 1280;
            var sumwidth = '1280px';
        }
        var width0=nums*0.0625 + 'px';
        var width1=nums*0.078125 + 'px';
        var width2=nums*0.078125 + 'px';
        var width3=nums*0.15625 + 'px';
        var width4=nums*0.1953125 + 'px';
        var width5=nums*0.125 + 'px';
        var width6=nums*0.09375 + 'px';
        var width7=nums*0.09375 + 'px';
        var width8=nums*0.1171875 + 'px';
        var arr=[
            {
                title:'<fmt:message code="workflow.th.Serial" />',
                name:'',
                width:width0,
                selectFun:function (name,obj,i) {
                    return i+1
                }
            },
            {
                title:'<fmt:message code="notice.th.publisher" />',
                name:'name',
                width:width1
            },
            {
                title:'<fmt:message code="notice.th.type" />',
                name:'typeName',
                width:width2,
                selectFun:function (name) {
                    if(name==''){
                        return '';
                    }else {
                        return name
                    }
                }
            },
            {
                title:'<fmt:message code="notice.th.releasescope" />',
                name:'deprange',
                width:width3,
                selectFun:function (data,obj) {
                    return '<div title="部门：'+check(obj.deprange)+'">部门：'+check(obj.deprange)+'</div><div title="角色：'+check(obj.rolerange)+'">角色：'+check(obj.rolerange)+'</div><div title="人员：'+check(obj.userrange)+'">人员：'+check(obj.userrange)+'</div>'
                }
            },
            {
                title:'<fmt:message code="notice.th.title" />',
                name:'subject',
                width:width4,
                selectFun:function (name,obj) {
                    if(obj.top=='1'){
                        return '<div style="width: 100%;text-align: left">' +
                            '<span style="    color: #fff;\
background: #ef7559;\
font-size: 12px;\
padding: 2px 5px;\
margin-right: 3px;\
border-radius: 3px;"><fmt:message code="notice.th.top" /></span>'+
                            '<a href="javascript:;" ' +
                            'target="_blank" data-id="'+obj.notifyId+'" class="windowOpen">'+name+'</a>' +
                            '</div>'
                    }else {
                        return '<div style="width: 100%;text-align: left">' +
                            '<a href="javascript:;" ' +
                            ' data-id="'+obj.notifyId+'" class="windowOpen">'+name+'</a>' +
                            '</div>'
                    }
                }
            },
            {
                title:'<fmt:message code="notice.th.createTime" />',
                name:'sendTime',
                width:width5
            },
            {
                title:'<fmt:message code="notice.th.effectivedate" />',
                name:'begin',
                width:width6
            },
            {
                title:'<fmt:message code="notice.th.endDate" />',
                name:'end',
                width:width7
            },

            {
                title:'<fmt:message code="menuSSetting.th.menuSetting" />',
                name:'',
                width:width8
            }
        ]
        $('.navigation h2').html('待审批');
        $('.navigation img').prop('src','/img/commonTheme/${sessionScope.InterfaceModel}/daishen.png')
        objs=$.tablePage('#pagediv',sumwidth,arr,function (me) {
            me.init('/mySys/getPendingNotifyList?specifyTable='+specifyTable,[{name:'<fmt:message code="global.lang.edit" />'},{name:'<fmt:message code="meet.th.Approval" />'},{name:'<fmt:message code="meet.th.unratified" />'}])
        })
    }
    function yishen() {
        $('.navigation h2').html('已审批');
        $('.navigation img').attr('src','/img/commonTheme/${sessionScope.InterfaceModel}/yishen.png')
        var screenwidth = document.documentElement.clientWidth;
        if(screenwidth > 1372){
            var nums = screenwidth*0.97;
            var sumwidth = screenwidth*0.97+'px';
        }else{
            var nums = 1330;
            var sumwidth = '1330px';
        }
        var width0=nums*0.05263158 + 'px';
        var width1=nums*0.07518797 + 'px';
        var width2=nums*0.07518797 + 'px';
        var width3=nums*0.15037594 + 'px';
        var width4=nums*0.18045113 + 'px';
        var width5=nums*0.12030075 + 'px';
        var width6=nums*0.09022556 + 'px';
        var width7=nums*0.09022556 + 'px';
        var width8=nums*0.07518797 + 'px';
        var width9=nums*0.09022556 + 'px';
        var arr=[
            {
                title:'<fmt:message code="workflow.th.Serial" />',
                name:'',
                width:width0,
                selectFun:function (name,obj,i) {
                    return i+1
                }
            },
            {
                title:'<fmt:message code="notice.th.publisher" />',
                name:'name',
                width:width1
            },
            {
                title:'<fmt:message code="notice.th.type" />',
                name:'typeName',
                width:width2,
                selectFun:function (name) {
                    if(name==''){
                        return ''
                    }else {
                        return name
                    }
                }
            },
            {
                title:'<fmt:message code="notice.th.releasescope" />',
                name:'deprange',
                width:width3,
                selectFun:function(data,obj){
                    return '<div title="部门：'+check(obj.deprange)+'">部门：'+check(obj.deprange)+'</div><div title="角色：'+check(obj.rolerange)+'">角色：'+check(obj.rolerange)+'</div><div title="人员：'+check(obj.userrange)+'">人员：'+check(obj.userrange)+'</div>'
                }
            },
            {
                title:'<fmt:message code="notice.th.title" />',
                name:'subject',
                width:width4,
                selectFun:function (name,obj) {
                    if(obj.top=='1'){
                        return '<div style="width: 100%;text-align: left">' +
                            '<span style="    color: #fff;\
background: #ef7559;\
font-size: 12px;\
padding: 2px 5px;\
margin-right: 3px;\
border-radius: 3px;"><fmt:message code="notice.th.top" /></span>'+
                            '<a href="javascript:;" ' +
                            ' data-id="'+obj.notifyId+'" class="windowOpen">'+name+'</a>' +
                            '</div>'
                    }else {
                        return '<div style="width: 100%;text-align: left">' +
                            '<a href="javascript:;" ' +
                            ' data-id="'+obj.notifyId+'" class="windowOpen">'+name+'</a>' +
                            '</div>'
                    }
                }

            },
            {
                title:'<fmt:message code="notice.th.createTime" />',
                name:'sendTime',
                width:width5
            },
            {
                title:'<fmt:message code="notice.th.effectivedate" />',
                name:'begin',
                width:width6
            },
            {
                title:'<fmt:message code="notice.th.endDate" />',
                name:'end',
                width:width7
            },
            {
                title:'<fmt:message code="notice.th.state" />',
                name:'publish',
                width:width8,
                selectFun:function (data) {
                    if(data==1 || data==4 || data==5){
                        return '<fmt:message code="meet.th.Approval" />'
                    }else if(data==3){
                        return '<fmt:message code="meet.th.unratified" />'
                    }else {
                        return ''
                    }
                }
            },   {
                title:'<fmt:message code="event.th.currentState" />',
                name:'publish',
                width:width9,
                selectFun:function (name) {
                    switch(name)
                    {
                        <%--case '0':--%>
                        <%--return '<span class="red"><fmt:message code="notice.th.unposted" /></span>'--%>
                        <%--break;--%>
                        <%--case '1':--%>
                        <%--return '<span class="green"><fmt:message code="notice.state.effective" /></span>'--%>
                        <%--break;--%>
                        <%--case '2':--%>
                        <%--return '<span class="blue"><fmt:message code="meet.th.PendingApproval" /></span>'--%>
                        <%--break;--%>
                        <%--case '3':--%>
                        <%--return '<span class="red">未通过</span>'--%>
                        <%--break;--%>
                        <%--default:--%>
                        <%--return '<span class="red">已终止</span>'--%>
                        case '0':
                            return '<span class="red">'+notice_th_unposted+'</span>'
                            break;
                        case '1':
                            return '<span class="green">'+notice_state_effective+'</span>'
                            break;
                        case '2':
                            return '<span class="blue">'+meet_th_PendingApproval+'</span>'
                            break;
                        case '3':
                            return '<span class="red">'+meet_th_noGuo+'</span>'
                            break;
                        case '4':
                            return '<span class="red">待生效</span>'
                            break;
                        default:
                            return '<span class="red">'+notice_state_end+'</span>'

                    }
                }
            },

        ]
        objs=$.tablePage('#pagediv',sumwidth,arr,function (me) {
            me.init('/mySys/getApprovedNotifyList?specifyTable='+specifyTable)
        })
    }



    $('.head-top li').click(function () {
        $(this).siblings('li').removeClass('active')
        $(this).addClass('active')
        if($(this).attr('data-type')==''){
            daishen()
        }else if($(this).attr('data-type')=='0'){
            yishen()
        }
    })

    daishen()

    $(document).on('click','.editAndDelete0',function () {  //编辑
        var notifyId=objs.arrs[$(this).attr('data-i')].notifyId;
        $.popWindow('/myNotice/newAndEdit?approve=true&type=edit&notifyId='+notifyId+"&specifyTable="+specifyTable,'编辑公告','50','30','1200px','600px')

    })

    $(document).on('click','.editAndDelete1',function () {

        var obj=objs.arrs[$(this).attr('data-i')];

        $.get('/myNotice/updateNotify',{notifyId:obj.notifyId,publish:1,typeId:obj.typeId,approve:1,howRenind:obj.howRenind,specifyTable:specifyTable},function (json) {
            if(json.flag){
                $.layerMsg({content:'<fmt:message code="vote.th.Approval" />',icon:1},function () {
                    objs.init()
                })
            }else {
                $.layerMsg({content:'<fmt:message code="workflow.th.networkError" />',icon:2})
            }
        },'json')
    })

    $(document).on('click','.editAndDelete2',function () {
        var obj=objs.arrs[$(this).attr('data-i')]
        $.get('/myNotice/updateNotify',{notifyId:obj.notifyId,publish:3,typeId:obj.typeId,approve:1,specifyTable:specifyTable},function (json) {
            if(json.flag){
                $.layerMsg({content:'<fmt:message code="vote.th.ReviseUnapprovedSuccess" />',icon:1},function () {
                    objs.init()
                })
            }else {
                $.layerMsg({content:'<fmt:message code="workflow.th.networkError" />',icon:2})
            }
        },'json')
    })
    //公告详情
    $('#pagediv').on('click','.windowOpen',function () {
        var notifyId=$(this).attr('data-id');
        $.popWindow('/myNotice/detail?notifyId='+notifyId+'&changId=1'+'&specifyTable='+specifyTable,'公告详情','20','150','1200px','500px')
    })
</script>

</body>
</html>
