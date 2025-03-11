
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
    <title><fmt:message code="notice.th.notificationQuery" /></title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <script src="/js/common/language.js"></script>

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>
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
            font-size: 11pt;
            color: #2a588c;
            font-weight: bold;
        }
        table tbody td textarea{
            width: 229px;
            height: 34px;
            line-height: 34px;
            padding-left: 10px;
            outline: none;
            border-radius: 4px;
            vertical-align: middle;
            font-family:"Microsoft Yahei";
        }
        table tbody td a{
            vertical-align: middle;
            font-size: 11pt;
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
        .pagediv .page-bottom-outer-layer table td{
            text-align: left;
        }
        /*table tr.borderNone{*/
        /*border:none;*/
        /*}*/
        .pagediv{
            width: 98% !important;
            overflow: hidden !important;
        }
        .pagediv .page-bottom-outer-layer table td{
            font-size: 11pt !important;
        }
        .pagediv .page-top-inner-layer table th{
            font-size: 12pt !important;
        }
        .navigation{
            position: relative;
        }
        .daochuwork {
            display: none;
            border: 1px solid #0cae32;
            color: #fff;
            background-color: #0cae32;
            cursor: pointer;
            background-image: -moz-linear-gradient(top, #0cae32, #0cae32);
            background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#0cae32), to(#0cae32));
            background-image: -webkit-linear-gradient(top, #0cae32, #0cae32);
            background-image: -o-linear-gradient(top, #0cae32, #0cae32);
            background-image: linear-gradient(to bottom, #0cae32, #0cae32);
            background-repeat: repeat-x;
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#0cae32',endColorstr='#0cae32',GradientType=0);
            filter: progid:DXImageTransform.Microsoft.gradient(enabled = false);
            width: 130px;
            height: 30px;
            border-radius: 6px;
            font-size: 10pt;
            margin-left: 700px;
            position: absolute;
            right: 50px;
            top: 15px;
            line-height: 30px;
        }
    </style>
    <script src="/js/notice/theQuery.js"></script>
</head>
<body>
<div class="navigation">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/gonggaochaxun.png" alt="">
    <h2><fmt:message code="notice.th.notificationQuery" /></h2>
    <div id="export" class="btn btn-info daochuwork" onclick="clicked1();" style="margin-right: 10pt;"><img src="../../img/mywork/dclist1.png" style="margin: 0 8px 2px 10px"><fmt:message code="notice.th.exportTheAnnouncementList" /></div>
</div>
<div class="query">
    <div class="header"><fmt:message code="global.lang.inputquerycondition"/></div>
    <form id="ajaxform" action="">
        <input type="hidden" name="changeId" value="1">
        <input type="hidden" name="exportId" value="">
        <table style="width: 100%;    border: 1px solid #c0c0c0;
    border-top: none;">
            <tbody>
            <tr class="borderNone pubilsher">
                <td width="30%" class="color"><fmt:message code="notice.th.publisher"/>：</td>
                <td width="70%">
                    <textarea name="" placeholder="<fmt:message code="addiing.th.Publisher"/>" class="theControlData" readonly="readonly" id="reles" cols="30" rows="10"></textarea>
                    <a href="javascript:;" class="addroles"><fmt:message code="global.lang.add"/></a>
                    <a href="javascript:;" class="cleardate"><fmt:message code="global.lang.empty"/></a>
                    <input type="hidden" name="fromId">
                </td>
            </tr>

            <tr class="borderNone">
                <td width="30%" class="color"><fmt:message code="notice.th.type"/>： <input type="hidden" name="format" value="0"></td>
                <td width="70%">
                    <select name="typeId" id="">
                        <%--<option value=""><fmt:message code="addiing.th.bulletin"/></option>--%>
                        <option value=""><fmt:message code="notice.th.selectTheNotificationType" /></option>
                    </select>
                </td>
            </tr>
            <tr class="borderNone">
                <td width="30%" class="color"><fmt:message code="notice.th.postedType"/>：</td>
                <td width="70%">
                    <select name="publish" id="">
                        <option value=""><fmt:message code="notice.th.all"/></option>
                        <option value="0"><fmt:message code="notice.th.unposted"/></option>
                        <option value="1"><fmt:message code="notice.th.posted"/></option>
                    </select>
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
                    <input type="text" placeholder="<fmt:message code="adding.th.Start"/>" name="beginDate" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" readonly="readonly" style="width: 128px">
                    <span><fmt:message code="global.lang.to"/></span>
                    <input type="text" placeholder="<fmt:message code="adding.th.end"/>" name="endDate" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})"  style="width: 128px" readonly="readonly">
                </td>
            </tr>
            <tr class="borderNone">
                <td width="30%" class="color"><fmt:message code="notice.th.effectiveType"/>：</td>
                <td width="70%">
                    <select name="publish" id="">
                        <option value=""><fmt:message code="notice.th.all"/></option>
                        <option value="4"><fmt:message code="notice.th.uneffective"/></option>
                        <option value="1"><fmt:message code="notice.th.effectived"/></option>
                        <option value="5"><fmt:message code="notice.th.hasEnd"/></option>
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
                    <a href="javascript:;" style="margin-left: 10px" class="btnsava"  onclick="ajaxforms(2)"><fmt:message code="global.lang.report"/></a>
                    <a href="javascript:;" style="margin-left: 10px" class="btnsava chongtian"  ><fmt:message code="global.lang.refillings"/></a>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
<div id="pagediv" style="visibility:hidden;">

</div>
</body>
</html>
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
                    for(var i=0;i<data[proId].length;i++){
                        str += '<option value="'+data[proId][i].codeNo+'">'+data[proId][i].codeName+'</option>'

                    }
                }
                $('[name="typeId"]').html(str)
                if(fn!=undefined){
                    fn()
                }
            }

        })
    }

    function clicked1(){
        ajaxforms(2);
    }
    function ajaxforms(type) {
        $('[name="exportId"]').val(type)
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

        if(type==2){
            // console.log('/notice/notifyList?'+$('#ajaxform').serialize()+'&page=1&pageSize=15&useFlag=true')
            window.location.href='/notice/notifyList?'+$('#ajaxform').serialize()+'&page=1&pageSize=15&useFlag=false';
            return;
        }
        var arrs=$('#ajaxform').serializeArray()
        for(var i=0;i<arrs.length;i++){
            pageObj.data[arrs[i].name]=arrs[i].value;
        }
        //1显示  // 2不显示  //不写fn这个属性就是全显示
        pageObj.init("/notice/notifyList",[
            {name:notice_th_QueryStatus,fn:function (obj) {
                    if(obj.publish==2){
                        return 2
                    }else {
                        return notice_th_QueryStatus
                    }
                }},
            {name:notice_state_end,fn:function (obj) {
                    if(obj.publish==1){
                        return '<span data-type="stop">'+notice_state_end+'</span>'
                    }else if(obj.publish==4 || obj.publish==5){
                        return '<span data-type="effective">'+notice_state_effective+'</span>'
                    }else if(obj.publish==2){
                        return 2
                    }
                }},
            {name:edit1},
            {name:del}
        ],function () {
            $('#pagediv').css('visibility','visible')
            $('.query').hide();
            $('#pagediv').show();
            $('#export').show();
            $('.page-bottom-inner-layer').height(279);
            var str='<tr>' +
                '<td style="width: 400px;text-align: center"><input type="checkbox" name="all"><span>'+notice_th_allchose+'</span></td>' +
                '<td colspan="9" style="text-align: left">' +
                '<a class="notice_top"><span style="margin-left: 23px;">'+notice_th_top+'</span></a>' +
                '<a class="notice_notop"><span style="margin-left:25px;">'+news_th_quittop+'</span></a>' +
                '<a class="delete_check"><span style="margin-left: 27px;">'+notice_th_DeleteSelectedBulletin+'</span></a>' +
                // '<a class="delete_all"><span style="margin-left:27px;">'+notice_th_DeleteAllAnnouncements+'</span></a>' +
                '</td>' +
                '</tr>'
            $('#operation').html(str)
        })
    }
    var user_id=null;
    var pageObj=null;
    $(function () {
        var userPriv=$.cookie('userPriv');
        if(userPriv == '1'){
            $('.pubilsher').show();
        }else{
            $('.pubilsher').hide();
        }
        GetDropDownBox()
        var bodyWidth=$('body').width();
        var width0=bodyWidth*0.05 + 'px';
        var width1=bodyWidth*0.08 + 'px';
        var width2=bodyWidth*0.09 + 'px';
        var width3=bodyWidth*0.21 + 'px';
        var width4=bodyWidth*0.15 + 'px';
        var width5=bodyWidth*0.09 + 'px';
        var width6=bodyWidth*0.09 + 'px';
        var width7=bodyWidth*0.05 + 'px';
        var width8=bodyWidth*0.19 + 'px';
        $('.addroles').click(function () {
            user_id = $(this).siblings('textarea').prop('id');
            $.popWindow("../common/selectUser");
        })
        pageObj=$.tablePage('#pagediv',bodyWidth+'px',[
            {
                width:width0,
                title:ggghhhh,
                name:'',
                selectFun:function (n,obj) {
                    return '<input type="checkbox" class="choose" data-id="'+obj.notifyId+'">'
                }
            },
            {
                width:width1,
                title:notice_th_publisher,
                name:'name'
            },
            {
                width:width2,
                title:notice_th_type,
                name:'typeName',
                selectFun:function (name,obj) {
                    if(name==''){
                        // return notice_type_alltype
                        return '';
                    }else {
                        return name;
                    }
                }
            },
            // {
            //     width:'140px',
            //     title:notice_th_releasescope,
            //     name:'deprange',
            //     selectFun:function (name,obj,i) {
            //         return '<span class="toTypeName" data-i="'+i+'" style="cursor: pointer">'+name+obj.rolerange+obj.userrange+'</span>'
            //
            //     }
            // },
            {
                width:width3,
                title:notice_th_title,
                name:'subject',
                selectFun:function (name,obj,i) {
                    if(obj.top=='1'){
                        return '<div style="width: 100%;text-align: left" title="'+name+'">' +
                            '<span style="    color: #fff;\
           background: #ef7559;\
           font-size: 12px;\
           padding: 2px 5px;\
           margin-right: 3px;\
           border-radius: 3px;"><fmt:message code="notice.th.top" /></span>'+
                            '<a onclick="detail('+obj.notifyId+')" href="javascript:;"' +
                            'class="windowOpen">'+name+'</a>' +
                            '</div>'
                    }else {
                        return '<div style="width: 100%;text-align: left" title="'+name+'">' +
                            '<a href="/notice/detail?notifyId='+obj.notifyId+'" ' +
                            'target="_blank" class="windowOpen">'+name+'</a>' +
                            '</div>'
                    }
                }
            },
            {
                width:width4,
                title:notice_th_CreationTime,
                name:'notifyDateTime'
            },
            {
                width:width5,
                title:notice_th_effectivedate,
                name:'begin',
                selectFun:function (name) {
                    return name.split(' ')[0]
                }
            },
            {
                width:width6,
                title:notice_th_endDate,
                name:'end',
                selectFun:function (name) {
                    return name.split(' ')[0]
                }
            },
            {
                width:width7,
                title:type1,
                name:'publish',
                selectFun:function (name,obj,i) {// 发布标识(0-未发布,1-已发布,2-待审批,3-未通过,4-已终止)
                    switch(name)
                    {
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
                            return '<span class="red">'+notice_state_pending_effectiveness+'</span>'
                            break;
                        default:
                            return '<span class="red">'+notice_state_end+'</span>'

                    }
                }
            },
            {
                width:width8,
                title:option
            },
        ],function (me) {
            me.data.pageSize=10;
        })




        // 事件绑定处理
        $('#pagediv').on('click','[name="all"]',function(){//全选
            if($(this).is(':checked')){
                $('#pageTbody').find('input[type=checkbox]').prop('checked',true)
            }else {
                $('#pageTbody').find('input[type=checkbox]').removeProp('checked')
            }
        })

        $(document).on('click','.cleardate',function () {
            $(this).siblings('textarea').val('')
            $(this).siblings('textarea').attr('user_id','');
            $(this).siblings('textarea').attr('deptid','');
            $(this).siblings('textarea').attr('deptname','');
            $(this).siblings('textarea').attr('privid','');
            $(this).siblings('textarea').attr('userpriv','');
            $(this).siblings('textarea').attr('username','');
            $(this).siblings('textarea').attr('dataid','');
            $(this).siblings('textarea').attr('userprivname','');
        })

        $(document).on('click','.chongtian',function () {
            $(':input','#ajaxform')

                .not(':button,:submit,:reset,:hidden')   //将myform表单中input元素type为button、submit、reset、hidden排除

                .val('')  //将input元素的value设为空值

                .removeAttr('checked')

                .removeAttr('checked') // 如果任何radio/checkbox/select inputs有checked or selected 属性，将其移除
        })




        $('#pagediv').on('click','.delete_check',function(){//删除公告
            if($('#pageTbody').find('input[type=checkbox]:checked').length==0){
                $.layerMsg({content:notice_th_dj,icon:2});
                return;
            }
            var fileId=[];
            $('#pageTbody').find('input[type=checkbox]:checked').each(function(){
                var conId=$(this).attr("data-id");
                fileId.push(conId);
            })
            layer.confirm(queding, {
                btn: [sure,cancel], //按钮
                title:queding
            }, function(){
                $.ajax({
                    type:'post',
                    url:'/notice/deleteByIds',
                    dataType:'json',
                    data:{'notifyIds':fileId},
                    success:function(json){
                        if (json.code == '100066'){
                            $.layerMsg({content: '<fmt:message code="notice.th.noticeDeleteByIdsPrompt" />', icon: 4}, function () {
                                pageObj.init()
                            })
                        } else if(json.flag){
                            $.layerMsg({
                                content:delc,
                                icon:1
                            },function () {
                                pageObj.init()
                            })
                        }else {
                            $.layerMsg({
                                content:delf, icon:2
                            })
                        }
                    }
                })

            });
        })


        $('#pagediv').on('mouseover','.toTypeName',function () {
            var obi=pageObj.arrs[$(this).attr('data-i')];

            layer.tips('<fmt:message code="userManagement.th.department" />：'+obi.deprange+'<br/>' +
                '用户：'+obi.userrange+'<br/>' +
                '<fmt:message code="userManagement.th.role" />：'+obi.rolerange+'',this, {
                tips: [1, '#3595CC'],
                time: 1000
            });
        })


        $('#pagediv').on('click','.notice_top',function(){//置顶
            if($('#pageTbody').find('input[type=checkbox]:checked').length==0){
                $.layerMsg({content:notice_th_dj,icon:2});
                return;
            }
            var fileId=[];
            $('#pageTbody').find('input[type=checkbox]:checked').each(function(){
                var conId=$(this).attr("data-id");
                fileId.push(conId);
            })
            layer.confirm(ConfirmTop, {
                btn: [sure,cancel], //按钮
                title:SetTop
            }, function(){

                $.ajax({
                    type:'post',
                    url:'/notice/updateByIds',
                    dataType:'json',
                    data:{
                        notifyIds:fileId,
                        top:'1'
                    },
                    success:function(json){
                        if(json.flag) {
                            $.layerMsg({content: TopSuccess, icon: 1}, function () {
                                pageObj.init();
                            })
                        }else {
                            $.layerMsg({content: TopFailure, icon: 2})
                        }

                    }
                })

            });
        })



        $('#pagediv').on('click','.notice_notop',function(){//取消置顶
            if($('#pageTbody').find('input[type=checkbox]:checked').length==0){
                $.layerMsg({content:notice_th_dj,icon:2});
                return;
            }
            var fileId=[];
            $('#pageTbody').find('input[type=checkbox]:checked').each(function(){
                var conId=$(this).attr("data-id");
                fileId.push(conId);
            })
            layer.confirm(notice_th_dd, {
                btn: [sure,cancel], //按钮
                title:notice_th_Determine
            }, function(){
                $.ajax({
                    type:'post',
                    url:'/notice/updateByIds',
                    dataType:'json',
                    data:{
                        notifyIds:fileId,
                        top:'0'
                    },
                    success:function(json){
                        if(json.flag) {
                            $.layerMsg({content: notice_th_CancelTopSuccess, icon: 1}, function () {
                                pageObj.init();
                            })
                        }else {
                            $.layerMsg({content: notice_th_CancelTopF, icon: 2})
                        }

                    }
                })

            });
        })









        $('#pagediv').on('click','.editAndDelete0',function(){
            var notifyId=pageObj.arrs[$(this).attr('data-i')].notifyId;
            $.popWindow("finddetail?notifyId="+notifyId,'<fmt:message code="news.th.querysituation" />','0','0','1200px','600px');
        })

        $('#pagediv').on('click','.editAndDelete2',function(){
            var notifyId=pageObj.arrs[$(this).attr('data-i')].notifyId;
            parent.$('[name="notices"]').attr('src','../../notice/newAndEdit?type=edit&notifyId='+notifyId)
        })


        $('#pagediv').on('click','.editAndDelete1',function(){
            var me=this;
            var data={
                "notifyId":pageObj.arrs[$(this).attr('data-i')].notifyId
            };
            if($(this).find('span').attr('data-type')=='stop'){
                data.publish=4;  // 发布标识(0-未发布,1-已发布,2-待审批,3-未通过,4-已终止)
            }else if($(this).find('span').attr('data-type')=='effective'){
                data.publish=1;
            }
            $.post('updateNotify',data,function (json) {
                if(json.flag){
                    if($(me).find('span').attr('data-type')=='stop'){
                        $(me).find('span').attr('data-type','effective');
                        $(me).find('span').text('<fmt:message code="notice.state.effective" />');
                        $(me).parent().prev().find('span').text('<fmt:message code="notice.state.end" />')
                        $(me).parent().prev().find('span').removeClass('green')
                        $(me).parent().prev().find('span').addClass('red')
                    }else if($(me).find('span').attr('data-type')=='effective'){
                        $(me).find('span').attr('data-type','stop');
                        $(me).find('span').text('<fmt:message code="notice.state.end" />');
                        $(me).parent().prev().find('span').text('<fmt:message code="notice.state.effective" />')
                        $(me).parent().prev().find('span').addClass('green')
                        $(me).parent().prev().find('span').removeClass('red')
                    }
                    pageObj.init()
                }
            },'json')
        })


        $('#pagediv').on('click','.editAndDelete3',function(){
            var tid=pageObj.arrs[$(this).attr('data-i')].notifyId;
            layer.confirm(qued, {
                btn: [sure,cancel] ,//按钮
                title:ifDelete
            }, function(){
                //确定删除，调接口
                $.ajax({
                    url: "/notice/deleteById",
                    type: "get",
                    data:{
                        notifyId:tid
                    },
                    dataType: 'json',
                    success: function (json) {
                        if (json.code == '100066'){
                            $.layerMsg({content: '<fmt:message code="notice.th.noticeDeleteByIdsPrompt" />', icon: 4}, function () {
                                pageObj.init()
                            })
                        } else if (json.flag) {
                            $.layerMsg({content: delc, icon: 1}, function () {
                                pageObj.init()
                            })
                        }
                    }
                })

            }, function(){
                layer.closeAll();
            });
        })

    })

    function detail(nid) {
        $.popWindow('/notice/detail?notifyId='+nid,'<fmt:message code="notice.th.queryDetail" />','20','150','1200px','600px')

    }
</script>