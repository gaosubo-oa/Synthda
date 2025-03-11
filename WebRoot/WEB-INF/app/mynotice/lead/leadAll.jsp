
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
    <title>领导指示精神</title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>
        html{
            background: #fff;
        }
        table tbody td{
            text-align: left;
            padding: 10px;
            box-sizing: border-box;
        }
        table tbody td.color{
            padding:10px 10px 10px 50px;
        }
        input{
            float: none;
        }
        .editAndDelete3{
            color: red;
        }
        .color{
            /*font-size: 14px;*/
            font-size: 11pt;
            color: #2a588c;
            font-weight: bold;
        }
        table tbody td textarea{
            width: 281px;
            height: 34px;
            line-height:34px;
            padding-left:10px;
            outline: none;
            border-radius: 4px;
            vertical-align: middle;
            font-family:"Microsoft Yahei";
        }
        table tbody td a{
            vertical-align: middle;
            font-size: 10pt;
        }
        table tbody td select{
            width: 119px;
            height: 28px;
            border-radius: 4px;
        }
        table tbody td input[type=text]{
            width: 288px;
            height: 32px;
            border-radius: 4px;
            padding-left: 10px;
            box-sizing: border-box;
        }
        .btnsava{
            padding:5px 15px;
            border-radius: 4px;
            background: #2F8AE3;
            color: #fff;
        }
        #pageTbody tr td{
            text-align: left;
        }
        .page-top-inner-layer{
            padding-right:0px!important;
        }
        .page-bottom-outer-layer,.page-bottom-inner-layer{
            width:100%;
        }
    </style>
<%--    <script src="/js/notice/queryAll.js"></script>--%>
</head>
<body>
<div class="navigation">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/gonggaochaxun.png" alt="">
    <h2><fmt:message code="notice.title.announcementquery"/></h2>
<%--    <h2>问题清单查询</h2>--%>
</div>
<div class="query" style="width: 560px;">
    <div class="header"><fmt:message code="event.th.PleaseCriteria"/></div>
    <form id="ajaxform" action="">
        <input type="hidden" name="read">
        <input type="hidden" name="sendTime">
        <table style="width: 100%">
            <tbody>
            <tr class="borderNone">
                <td width="30%" class="color"><fmt:message code="notice.th.publisher"/>：</td>
                <td width="70%">

                    <textarea name="" placeholder="<fmt:message code="addiing.th.Publisher"/>" class="theControlData" readonly="readonly" id="reles" cols="30" rows="10"></textarea>
                    <a href="javascript:;" class="addroles"><fmt:message code="global.lang.add"/></a>
                    <a href="javascript:;" class="delete"><fmt:message code="global.lang.empty"/></a>

                    <input type="hidden" name="fromId">
                </td>
            </tr>
            <tr class="borderNone">
                <td width="30%" class="color"><fmt:message code="notice.th.title"/>：</td>
                <td width="70%">
                    <input type="text" placeholder="<fmt:message code="main.th.ContentSearch"/>" name="subject">
                </td>
            </tr>
            <tr class="borderNone">
                <td width="30%" class="color"><fmt:message code="notice.title.Releasedate"/>：</td>
                <td width="70%">
                    <input type="text" placeholder="<fmt:message code="doc.th.startDate"/>" name="beginDate" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" readonly="readonly" style="width: 128px">
                    <span><fmt:message code="global.lang.to"/></span>
                    <input type="text" placeholder="<fmt:message code="doc.th.endDate"/>" name="endDate" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})"  style="width: 128px" readonly="readonly">
                </td>
            </tr>
            <tr class="borderNone">
                <td width="30%" class="color"><fmt:message code="notice.th.type"/>：</td>
                <td width="70%">
                    <select name="typeId" id="">
                        <%--<option value=""><fmt:message code="notice.type.alltype"/></option>--%>
                        <option value="">选择公告类型</option>

                    </select>
                </td>
            </tr>
            <tr class="borderNone">
                <td width="30%" class="color"><fmt:message code="notice.th.content"/>：</td>
                <td width="70%">
                    <input type="text" placeholder="<fmt:message code="new.th.putcontent"/>" name="content">
                </td>
            </tr>
            <tr class="borderNone">
                <td colspan="2" style="text-align: center">
                    <a href="javascript:;" class="btnsava" onclick="ajaxforms(1)"><fmt:message code="global.lang.query"/></a>
                    <a href="javascript:;" style="margin-left: 10px" class="btnsava chongtian"  ><fmt:message code="global.lang.refillings"/></a>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
<div id="pagediv" style="visibility:hidden;">

</div>
<script>
    function GetDropDownBox(fn) {
        $.ajax({
            url: "/code/GetDropDownBox",
            type:'get',
            dataType:"JSON",
            data : {"CodeNos":"NOTIFY"},
            success:function(data){
                // var str='<option value="">'+notice_type_alltype+'</option>';
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
                $('[name="typeId"]').html(str)
                if(fn!=undefined){
                    fn()
                }
            }

        })
    }
    function ajaxforms(type) {
        $('.theControlData').each(function () {
            if($(this).attr('user_id')!=undefined) {
                $(this).siblings('input[type=hidden]').val($(this).attr('user_id'))
                return true;
            }
            if($(this).attr('userpriv')!=undefined){
                $(this).siblings('input[type=hidden]').val($(this).attr('userpriv'))
                return true
            }
            if($(this).attr('deptid')!=undefined){
                $(this).siblings('input[type=hidden]').val($(this).attr('deptid'))
            }
        })
        var arrs=$('#ajaxform').serializeArray()
        for(var i=0;i<arrs.length;i++){
            pageObj.data[arrs[i].name]=arrs[i].value;
        }
        //1显示  // 2不显示  //不写fn这个属性就是全显示
        pageObj.init("/myNotice/notifyManage",[{name:'s',fn:function (obj) {
                if(obj.typeName==''){
                    // return '<span style="color: #000;">'+notice_type_alltype+'</span>'
                    return '<span style="color: #000;"></span>'
                }else {
                    return '<span style="color: #000">'+obj.typeName+'</span>'
                }
            }}],function () {
            $('#pagediv').css('visibility','visible')
            $('.query').hide();
            $('#pagediv').show();
            $('.page-bottom-inner-layer').height(308);
        })
    }
    var user_id=null;
    var pageObj=null;
    $(function () {
        GetDropDownBox()
        $('.addroles').click(function () {
            user_id = $(this).siblings('textarea').prop('id');
            $.popWindow("../common/selectUser");
        })
        pageObj=$.tablePage('#pagediv','100%',[
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
                            'class="windowOpen">'+name+'</a>' +
                            '</div>'
                    }else {
                        return '<div style="width: 100%;text-align: left">' +
                            '<a onclick="detail('+obj.notifyId+')" href="javascript:;" ' +
                            'class="windowOpen">'+name+'</a>' +
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
            //
            //     title:notice_th_releasescope,
            //     name:'deprange',
            //     selectFun:function (name,obj,i) {
            //         return '<span class="toTypeName" data-i="'+i+'" style="cursor: pointer">'+name+obj.rolerange+obj.userrange+'</span>'
            //
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
            me.data.pageSize=10;
        })

        $('#pagediv').on('mouseover','.toTypeName',function () {
            var obi=pageObj.arrs[$(this).attr('data-i')];

            layer.tips(userManagement_th_department+'：'+obi.deprange+'<br/>' +
                journal_th_user+'：'+obi.userrange+'<br/>' +
                userManagement_th_role+'：'+obi.rolerange+'',this, {
                tips: [1, '#3595CC'],
                time: 1000
            });
        })
        $(document).on('click','.chongtian',function () {
            $(':input','#ajaxform')

                .not(':button,:submit,:reset,:hidden')   //将myform表单中input元素type为button、submit、reset、hidden排除

                .val('')  //将input元素的value设为空值

                .removeAttr('checked')

                .removeAttr('checked') // 如果任何radio/checkbox/select inputs有checked or selected 属性，将其移除
        })


    })

    function detail(nid) {
        $.popWindow('/mynotice/detail?notifyId='+nid,'公告详情','20','150','1200px','600px')

    }
</script>
<script>
    $(function(){
        $('.delete').click(function(){
            $('#reles').attr('username','').attr('dataid','').attr('user_id','').attr('userprivname','');
            $('#reles').val('');
        })
    })
</script>
</body>
</html>