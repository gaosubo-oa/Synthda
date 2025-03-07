
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
    <title><fmt:message code="notice.title.unreadannouncement"/></title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/common/language.js"></script>


    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>
        html{
            background: #fff;
        }
        table tbody td{
            text-align: left!important;
        }
        input{
            float: none;
        }
        .editAndDelete3{
            color: red;
        }
        label input[type=text]{
            width: 150px;
            height: 28px;
            line-height: 28px;
            border-radius: 4px;
            padding-left: 10px;
            box-sizing: border-box;
        }
        .page-top-inner-layer{
            padding-right:0px!important;
        }
        .page-bottom-outer-layer,.page-bottom-inner-layer{
            width:100%;
        }
        .layui-layer-btn .layui-layer-btn0 {
            margin-right: 600px;
        }
    </style>

</head>
<body>
<div class="navigation">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/weidugonggao.png" alt="">
    <h2><fmt:message code="notice.th.unreadNotifications" /></h2>
    <label>
        <select name="type">
            <%--<option value="0"><fmt:message code="notice.type.alltype"/></option>--%>
            <option value="0"><fmt:message code="notice.th.selectTheNotificationType" /></option>
        </select>
    </label>
    <label style="margin-left: 3px;">
        <fmt:message code="notice.th.effectivedate" />：<input type="text" placeholder="<fmt:message code="doc.th.enterDate"/>"
                    readonly="readonly"
                    onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" name="sendTime" style="margin-right: 5px">
        <a href="javascript:;" class="submit"><fmt:message code="global.lang.query"/></a>
    </label>
</div>
<div id="pagediv">

</div>
</body>
</html>
<script type="text/javascript" src="/js/base/tablePage.js"></script>
<script type="text/javascript" src="/js/base/base.js"></script>
<script type="text/javascript" src="/lib/laydate/laydate.js"></script>
<script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
<script>
    function GetDropDownBox(fn) {
        $.ajax({
            url: "/code/GetDropDownBox",
            type:'get',
            dataType:"JSON",
            data : {"CodeNos":"NOTIFY"},
            success:function(data){
                // var str='<option value="">'+notice_type_alltype+'</option>';
                var str='<option value=""><fmt:message code="notice.th.selectTheNotificationType" /></option>';
                for (var proId in data){
                    console.log(data[proId])
                    // if(){
                    //
                    // }
                    for(var i=0;i<data[proId].length;i++){
                        if(data[proId][i].codeNo !=="LDZSJS"){
                            str += '<option value="'+data[proId][i].codeNo+'">'+data[proId][i].codeName+'</option>'
                        }
                    }
                }
                $('[name="type"]').html(str)
                if(fn!=undefined){
                    fn()
                }
            }

        })
    }
    $(function () {
        GetDropDownBox()
//表格初始化
        var pageObj=$.tablePage('#pagediv','100%',[
            {
                width:'15%',
                title:'<fmt:message code="notice.th.publisher" />',
                name:'s',
                selectFun:function (n,obj) {
                    return obj.users.userName
                }
            },
            {
                width:'50%',
                title:'<fmt:message code="notice.th.title" />',
                name:'subject',
                selectFun:function (name,obj,i) {
                    if(obj.top=='1'){
                        return '<div style="width: 100%;text-align: left">' +
                            '<span style="    color: #fff;\
         background: #ef7559;\
         font-size: 12px;\
         padding: 2px 5px;\
         margin-right: 3px;\
         border-radius: 3px;">'+notice_th_top+'</span>'+
                            '<a onclick="detail('+obj.notifyId+')" href="javascript:;" ' +
                            'class="windowOpen" title="'+name+'">'+name+'</a>' +
                            '</div>'
                    }else {
                        return '<div style="width: 100%;text-align: left">' +
                            '<a onclick="detail('+obj.notifyId+')" href="javascript:;" ' +
                            'class="windowOpen" title="'+name+'">'+name+'</a>' +
                            '</div>'
                    }
                }
            },
            {
                width:'20%',
                title:'<fmt:message code="notice.th.effectivedate" />',
                name:'begin'
            },
            {
                width:'15%',
                title:'<fmt:message code="notice.th.type" />',
                name:'typeName',
                selectFun:function (name,obj,i) {
                    if(name==''){
                        // return notice_type_alltype
                        return '';
                    }else {
                        return name
                    }
                }
            }
        ],function (me) {
            me.data.typeId=$('[name="type"]').val();
            me.data.read='0';
            me.data.sendTime=$('[name="sendTime"]').val();
            me.data.pageSize=10;
            //1显示  // 2不显示  //不写fn这个属性就是全显示
            me.init("/notice/notifyManage",[{name:'s',fn:function (obj) {
                    if(obj.typeName==''){
                        // return '<span style="color: #000;">'+notice_type_alltype+'</span>'
                        return '<span style="color: #000;"></span>'
                    }else {
                        return '<span style="color: #000;">'+obj.typeName+'</span>'
                    }
                }}],function (json) {
                if(!json.flag){
                    $.layerMsg({
                        content:noUnread_announcements,
                        icon:1
                    },function () {
                        $((parent.$('.head-top li'))[2]).trigger('click')
                    })
                }
            })
        })





        $('.submit').click(function () {
            pageObj.data.read='0';
            pageObj.data.sendTime=$('[name="sendTime"]').val();
            pageObj.data.typeId=$('[name="type"]').val();
            pageObj.init()
        })

        $('#pagediv').on('mouseover','.toTypeName',function () {
            var obi=pageObj.arrs[$(this).attr('data-i')];

            layer.tips(userManagement_th_department +':'+obi.deprange+'<br/>' +
                journal_th_user +':'+obi.userrange+'<br/>' +
                userManagement_th_role +':'+obi.rolerange+'',this, {
                tips: [1, '#3595CC'],
                time: 1000
            });
        })



    })

    function detail(nid) {
        layer.open({
            type: 2,
            title: '<fmt:message code="notice.th.queryDetail" />',
            area: ['1200px', '600px'],
            shadeClose: true,
            // btn: ['打印']
            // ,yes: function(){
            //     //alert(111111111111)
            //     window.print();
            // },
            content:'/notice/detail?notifyId='+nid,
            cancel: function(){
                window.location.reload();
            }
        });

    }
</script>