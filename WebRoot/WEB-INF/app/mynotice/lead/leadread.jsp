
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
<%--    <title>问题清单公示</title>--%>
    <title>领导指示精神</title>
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
    </style>

</head>
<body>
<div class="navigation">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/weidugonggao.png" alt="">
    <h2><fmt:message code="notice.title.unreadannouncement"/></h2>
<%--    <h2>未读问题清单</h2>--%>
    <label>
        <select name="type">
            <%--<option value="0"><fmt:message code="notice.type.alltype"/></option>--%>
                <option value="0">选择公告类型</option>
        </select>
    </label>
    <label style="margin-left: 3px;">
        生效日期：<input type="text" placeholder="<fmt:message code="doc.th.enterDate"/>"
                  readonly="readonly"
                  onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" name="sendTime" style="margin-right: 5px">
        <a href="javascript:;" class="submit"><fmt:message code="global.lang.query"/></a>
    </label>
</div>
<div id="pagediv">

</div>
<script type="text/javascript" src="/js/base/tablePage.js"></script>
<script type="text/javascript" src="/js/base/base.js"></script>
<script type="text/javascript" src="/lib/laydate/laydate.js"></script>
<script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
<%--<script src="/js/notice/unread.js"></script>--%>
<script>
    function GetDropDownBox(fn) {
        $.ajax({
            url: "/code/GetDropDownBox",
            type:'get',
            dataType:"JSON",
            data : {"CodeNos":"NOTIFY"},
            success:function(data){
                // var str='<option value="">'+notice_type_alltype+'</option>';
                // var str='<option value="">选择公告类型</option>';
                var str
                var typeId;

                for (var proId in data){
                    for(var i=0;i<data[proId].length;i++){
                        typeId=data[proId][i].codeNo=="LDZSJS";
                        if(data[proId][i].codeNo=="LDZSJS"){
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
                title:notice_th_publisher,
                name:'s',
                selectFun:function (n,obj) {
                    return obj.users.userName
                }
            },
            {
                width:'50%',
                title:notice_th_title,
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
                title:notice_th_effectivedate,
                name:'begin'
            },
            // {
            //     width:'350px',
            //     title:notice_th_releasescope,
            //     name:'deprange',
            //     selectFun:function (name,obj,i) {
            //         return '<span class="toTypeName" data-i="'+i+'" style="cursor: pointer">'+name+obj.rolerange+obj.userrange+'</span>'
            //     }
            // },
            {
                width:'15%',
                title:notice_th_type,
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
            me.data.typeId='LDZSJS';
            // me.data.typeId=$('[name="type"]').val();
            me.data.read='0';
            me.data.sendTime=$('[name="sendTime"]').val();
            me.data.pageSize=10;
            //1显示  // 2不显示  //不写fn这个属性就是全显示
            me.init("/myNotice/notifyManage",[{name:'s',fn:function (obj) {
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
            title: '公告详情',
            area: ['1200px', '600px'],
            shadeClose: true,
            content:'/mynotice/detail?notifyId='+nid,
            cancel: function(){
                window.location.reload();
            }
        });

    }
</script>
</body>
</html>