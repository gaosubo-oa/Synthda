<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" type="text/css" href="../../css/dept/deptManagement.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/icon.css"/>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/dept/new_news.css"/>
    <%--    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>

    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
<%--    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">--%>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>

    <title><fmt:message code="main.votemanage" /></title>
    <style>
        .title span{
            font-size:22px;
            color:#494d59;
            padding-left:20px;
        }
        .title{
            margin-bottom:20px;
        }
        document,body{
            width:100%;
            height:100%;
        }

        .content{
            margin:20px auto 0px;
            width:100%;
            height:100%;
        }
        .table table{
            width: 97%;
            margin:0 auto;
        }
        th{
            background-color: #fff;
            font-size: 15px;
            color: #2F5C8F;
            font-weight: bold;
            border: 0px;
            line-height:45px;
            padding-left: 10px;
        }
        .titleName{
            cursor:pointer;
            text-align: left;
        }
        tfoot div{
            float:left;
        }
        #del{
            background:url(../../img/news/btn_delete_min_03.png) 0px 0px no-repeat;
            background-size: 62px;
            font-size: 12px;
            width: 50px;
            height: 28px;
            line-height: 25px;
            padding-left: 23px;
            margin-left:20px;
            cursor:pointer;
        }
        #allDel{
            background:url(../../img/news/btn_delete_fourfont_07.png) 0px 0px no-repeat;
            font-size: 12px;
            width: 72px;
            height: 28px;
            line-height: 25px;
            padding-left: 24px;
            margin-left:10px;
            cursor:pointer;
        }
        #empty{
            background:url(../../img/news/empty.png) 0px 0px no-repeat;
            font-size: 12px;
            width: 100px;
            height: 28px;
            line-height: 25px;
            padding-left: 25px;
            margin-left:10px;
            cursor:pointer;
        }
        #cancle{
            background:url(../../img/news/btn_canceltop_11.png) 0px 0px no-repeat;
            font-size: 12px;
            width: 94px;
            height: 28px;
            line-height: 25px;
            padding-left: 25px;
            margin-left:10px;
            cursor:pointer;
        }

        .success{
            text-align:center;
            display:none;
        }
        .box{
            margin-bottom:30px;
        }
        .success span{
            width: 132px;
            height: 35px;
            background-color: rgba(224, 224, 224, 0.61);
            font-size: 16px;
            border-radius: 5px;
            padding-left:8px;
            cursor:pointer;

            line-height: 30px;
            display: inline-block;
        }
        .ellipsis{
            width:150px;
            overflow:hidden;
            text-overflow: ellipsis;
            white-space:nowrap;
            display: block;
        }
        .ellipsis1{
            /*width:100%;*/
            height:100%;
            overflow:hidden;
            text-overflow: ellipsis;
            white-space:nowrap;
            /*display: block;*/
        }
        .box{
            width:500px;
            height:150px;
            text-align:center;
            font-size:20px;
            color:#fff;
            background:#2F8AE3;
            margin:0 auto;
            line-height:150px;
            margin-bottom:30px;
            margin-top:50px;
        }
        #addItem{
            background:url(../../img/vote/save.png) no-repeat;
            color:#fff;
            width: 142px;
        }
        #addChild{
            background:url(../../img/vote/save.png) no-repeat;
            color:#fff;
        }
        .M-box3 .active{
            margin: 0px 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            background: #2b7fe0;
            font-size: 12px;
            border: 1px solid #2b7fe0;
            color:#fff;
            text-align:center;
            display: inline-block;
        }
        .M-box3 a{
            margin: 0 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            font-size: 12px;
            display: inline-block;
            text-align:center;
            background: #fff;
            border: 1px solid #ebebeb;
            color: #bdbdbd;
            text-decoration: none;
        }
        table thead tr th{
            font-size: 13pt;
            text-align: center;
        }
        table tbody tr td{
            font-size: 11pt;
            text-align: center;
        }
        .displaynone{
            display:none;
        }


        .ellipsis1{
            /*投票管理样式居中*/
            text-align: left;
        }
        table tbody tr  .range{
            text-align: left;
        }
        .pagediv td{
            padding: 1px;
        }
        .parent{
            width: 112px;
            display: block;
            margin: 0 auto;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body style="overflow:scroll;overflow-y: auto;overflow-x:hidden;">

<%--管理已发布的投票--%>

<div class="content" style="width:100%;height:100%">
    <div class="title">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/toupiaoguanli.png" alt="" style="padding-left:20px;margin-top: -7px;">
        <span style="padding-left:0px"><fmt:message code="main.votemanage" /></span>
    </div>
    <div style="margin: -60px auto 0px;height:50px;width: 97%;" class="clearfix">

    </div>
    <div class="table">
        <table>
            <thead>
            <tr style="text-align: left;">
                <th style="width: 2%;"></th>
                <th style="width:12%;text-align: left"><fmt:message code="notice.th.title" /></th>
                <th style="width: 8%;"><fmt:message code="notice.th.publisher" /></th>
                <th style="width: 15%;text-align: left"><fmt:message code="news.th.postdept" /></th>
                <th style="width:6%;"><fmt:message code="notice.th.type" /></th>
                <th style="width:5%;"><fmt:message code="vote.th.anonymous" /></th>
                <th style="width:7%;text-align: center"><fmt:message code="vote.th.VotingDescription" /></th>
                <th style="width:8%;"><fmt:message code="vote.th.HaveVoted" /></th>
                <th style="width:10%;"><fmt:message code="notice.th.effectivedate" /></th>
                <th style="width: 10%;"><fmt:message code="notice.th.endDate" /></th>
                <th style="width:6%;"><fmt:message code="notice.th.state" /></th>
                <%--<th style="width: 11%"><fmt:message code="vote.th.HaveVoted" /></th>--%>
                <th style="width: 20%;"><fmt:message code="notice.th.operation" /></th>
            </tr>
            </thead>
            <tbody class="list">

            </tbody>
            <tfoot>
            <tr>
                <td colspan="12">
                    <div style="margin-left: 0.56%;">
                        <input id="allChoose" type="checkbox">
                        <span><fmt:message code="notice.th.allchose" /></span>
                    </div>
                    <div id="del">
                        <fmt:message code="global.lang.delete" />
                    </div>
                    <div id="allDel">
                        <fmt:message code="meet.th.DeleteAll" />
                    </div>
                    <%-- <div id="empty">
                         <fmt:message code="notice.th.wipeData" />
                     </div>--%>
                </td>
            </tr>
            </tfoot>
        </table>
    </div>
    <div id="dbgz_page" style="margin-right: 1.3%" class="fr">

    </div>
</div>
<div class="success">
    <div class="box"><fmt:message code="event.th.Released" />！</div>
    <div>
        <span id="addItem"><fmt:message code="vote.th.AddVotingItems" /></span>
    </div>
</div>
<script type="text/javascript">
    var laypage;
    layui.use('laypage', function(){
        laypage = layui.laypage;
    });
    function setTop(top){
        if(top==1){
            return '<span  style="color: #fff;background: #ef7559;font-size: 12px;padding: 0px 5px;margin-right: 3px;border-radius: 3px;">置顶</span>'
        }else{
            return ''
        }
    }
    //点击查询后，查询列表展示
    $(function () {
//        列表带分页
        var ajaxPageLe={
            data:{
                page:1,//当前处于第几页
                pageSize:'5',//一页显示几条
                useFlag:true
                // computationNumber:null
            },
            page:function () {
                var me=this;
                $.ajax({
                    url:'/vote/manage/getVoteTitleList',
                    type:'get',
                    data:me.data,
                    dataType:'json',
                    success:function(reg){
                        var datas=reg.obj;
                        var str="";
                        for(var i=0;i<datas.length;i++){
                            var sub = datas[i].subject;
                            var subs = sub.substr(0,20)
                            str+='<tr class="pagediv" id='+datas[i].voteId+'>' +
                                '<td> ' +
                                '<input type="checkbox" class="childCheck"> ' +
                                '</td> ' +'<td class="titleName ellipsis1" data-priv="'+datas[i].viewPriv+'">'+setTop(datas[i].top)+'<a href="javascript:;" style="vertical-align:center;color:#1772c0;text-align:left;" class="ellipsis1" title="'+datas[i].subject+'">'+subs+'</a></td> ' +
                                '<td>'+datas[i].userName+'</td> ' +
                                '<td class="range ellipsis" ><div><span style="font-weight:bold"><fmt:message code="userManagement.th.department" />:</span>'+function(){
                                    return datas[i].toDeptName;
                                }()+'</div>' +
                                '<div class="ellipsis"><span style="font-weight:bold"><fmt:message code="userManagement.th.role" />:</span>'+function(){
                                    return datas[i].toPrivName;
                                }()+'</div>' +
                                '<div class="ellipsis"><span style="font-weight:bold"><fmt:message code="diary.th.body" />:</span>'+function(){
                                    return datas[i].toUserName;
                                }()+'</div></td> ' +

                                '<td>'+function(){
                                    if(datas[i].type==0){
                                        return "<fmt:message code="vote.th.Radio" />";
                                    }else if(datas[i].type==1){
                                        return "<fmt:message code="vote.th.Multiselect" />";
                                    }else{
                                        return '<fmt:message code="vote.th.TextEntry" />'
                                    }
                                }()+'</td> ' +
                                '<td>'+function(){
                                    if(datas[i].anonymity==0){
                                        return "<fmt:message code="workflow.th.NotAllowed" />";
                                    }else{
                                        return "<fmt:message code="workflow.th.Allowed" />";
                                    }
                                }()+'</td> ' +
                                '<td class="ellipsis voteDescription"><div>&nbsp;</div>'+datas[i].content +'</td>'+
                                '<td>'+datas[i].count +'  /  '+datas[i].sum+'</td> ' +
                                '<td>'+datas[i].sendTime+'</td> ' +
                                '<td>'+function(){
                                    if(datas[i].endDate==undefined||datas[i].endDate=="0000-00-00 00:00:00"){
                                        return ""
                                    }else{
                                        return datas[i].endDate;
                                    }
                                }()+'</td> ' +
                                '<td>'+function(){
                                    if(datas[i].publish==0){
                                        return "<fmt:message code="notice.th.unposted" />"
                                    }else if(datas[i].publish==1){
                                        return "<fmt:message code="notice.state.effective" />";
                                    }else{
                                        return "<fmt:message code="notice.state.end" />"
                                    }
                                }()+'</td> ' +
                                '<td class="parent" id="'+datas[i].voteId+'"> ' +
                                '<span class="children" style="color:#1772c0;cursor: pointer;"><fmt:message code="vote.th.SubVoting" /></span> ' +
                                function(){
                                    if(datas[i].type == 2){
                                        return ''
                                    }else{
                                        return '<span class="item" style="color:#1772c0;cursor: pointer;"><fmt:message code="vote.th.VotingItems" /></span> '
                                    }
                                }()+
                                '<span class="editd" style="color:#1772c0;cursor: pointer;"><fmt:message code="depatement.th.modify" /></span> ' +
                                //                                    '<a class="out" href="javascript:;">导出</a> ' +
                                '<span class="end" style="color:#1772c0;cursor: pointer;">'+function(){
                                    if(datas[i].publish==0){
                                        return "<fmt:message code="event.th.ImmediateRelease" />";
                                    }else if(datas[i].publish==1){
                                        return "<fmt:message code="vote.th.ImmediateTermination" />";
                                    }else if(datas[i].publish==2){
                                        return "<fmt:message code="event.th.EffectiveRecovery" />";
                                    }
                                }()+'</span> ' +
                                '</td> ' +
                                '</tr>'
                        }
                        $('.list').html(str);
                        me.pageTwo(reg.totleNum,me.data.pageSize,me.data.page)
                    }
                })

            },

            pageTwo: function (totalData, pageSize, indexs) {
                var mes = this;
                laypage.render({
                    elem: 'dbgz_page'
                    ,count: totalData
                    ,limit: pageSize
                    ,curr: mes.data.page
                    ,limits: [5,10, 20, 30, 40, 50]
                    ,layout: ['prev', 'page', 'next', 'skip', 'count', 'limit']
                    ,jump: function (index,first) {
                        if (!first) {
                            mes.data.page = index.curr;
                            mes.data.pageSize = index.limit;
                            mes.page();
                        }
                    }
                });
            }
        }
        ajaxPageLe.page();



//        管理投票查询列表



//        点击添加子投票
        $('#addChild').on('click',function(){
            self.parent.document.getElementById('iframe').src='/vote/manage/newChildVote';
        })
//   子投票点击
        $('.list').on('click','.children',function(){
            var sId=$(this).parent().attr('id');
            self.parent.document.getElementById("iframe").src='/vote/manage/voteChild';
            document.cookie="childId="+sId;
        })
//   投票项目
        $('.list').on('click','.item',function(){
            var sId=$(this).parent().attr('id');
            self.parent.document.getElementById("iframe").src='/vote/manage/updateVote?ItemId='+sId;
        })
//        点击修改
        $('.list').on('click','.editd',function(){
            self.parent.document.getElementById("iframe").src='/vote/manage/editVote';
        })

//        hover显示数据
//         $('.table').on('mouseover ','.ellipsis',function(){
//             var textLength=$(this)[0].scrollWidth-20;
//             var width=$(this).width();
//             if(textLength>width){
//                 layer.tips($(this).text(),$(this),{tips:[3,'#2b7fe0']})
//             }
//         })
        $('.table').on('mouseenter', '.range', function () {
            var that = $(this);
            var str = '<pre>'+that[0].innerText+'</pre>'
            layer.tips(str, that, {
                tips: [1, '#3595CC'],
                time: 10000
            });
        });
        $('.table').on('mouseleave', '.range', function () {
            layer.closeAll();

        });

        $('.list').on('click','.end',function(){
            var text=$(this).html();
            var sId=$(this).parent().attr('id');
            if(text=="<fmt:message code="vote.th.ImmediateTermination" />"){
                $.ajax({
                    type:'post',
                    data:{
                        voteId:sId,
                        publish:2
                    },
                    url:'/vote/manage/updateVoteTitle',
                    dataType:'json',
                    success:function(res){
                        if (res.flag) {
                            $.layerMsg({content: '<fmt:message code="event.th.TerminationSuccess" />！', icon: 1});
                            ajaxPageLe.page();
                        } else {
                            $.layerMsg({content: '<fmt:message code="event.th.TerminationFailure" />！', icon: 2});
                        }

                    }
                })
            }else if(text=="<fmt:message code="event.th.EffectiveRecovery" />"){

                $.ajax({
                    type:'post',
                    url:'/vote/manage/updateVoteTitle',
                    dataType:'json',
                    data:{
                        voteId:sId,
                        publish:1
                    },
                    success:function(res){
                        if (res.flag) {
                            $.layerMsg({content: '<fmt:message code="event.th.recoverySuccessful" />！', icon: 1});
                            ajaxPageLe.page();
                        } else {
                            $.layerMsg({content: '<fmt:message code="event.th.restoreFailed" />！', icon: 2});
                        }

                    }
                })
            }else if(text=="<fmt:message code="event.th.ImmediateRelease" />"){
                layer.confirm(' <fmt:message  code="event.th.issueVote"/>？', {
                    btn: [' <fmt:message  code="global.lang.ok"/>', ' <fmt:message  code="depatement.th.quxiao"/>'], //按钮
                    title: " <fmt:message code="common.th.prompt" />"
                },function(){

                    $.ajax({
                        url:'/vote/manage/statusUpdate',
                        type:'post',
                        data:{voteId:sId},
                        dataType:'json',
                        success:function(res){
                            if(res.flag){
                                ajaxPageLe.page();
                            }else{
                                $('.success').show();
                                $('.content').hide();
                                //        点击添加投票项目
                                $('#addItem').on('click',function(){
                                    self.parent.document.getElementById('iframe').src='/vote/manage/updateVote?ItemId='+sId;
                                })
                            }
                        }
                    })
                    layer.closeAll();
                }, function () {
                    layer.closeAll();
                })
            }
        })
//        点击全选
        $('#allChoose').on('click',function(){
            var state=$(this).prop('checked');
            if(state == true){
                $(this).prop('checked',true);
                $('.childCheck').prop('checked',true);
            }else{
                $(this).prop('checked',false);
                $('.childCheck').prop('checked',false);
            }
        })
//        点击删除
        $('#del').on('click',function(){
            var checkL=$('.childCheck:checkbox:checked').length;
            var arr=[];
            var str="";
            if(checkL != 0){
                $('.childCheck:checkbox:checked').each(function(){
                    if(this.checked){
                        var sId=$(this).parent().parent().attr('id');
                        arr.push(sId);
                    }
                })
                var str=arr.join();
                layer.confirm(' <fmt:message  code="workflow.th.que"/>', {
                    btn: [' <fmt:message  code="global.lang.ok"/>', ' <fmt:message  code="depatement.th.quxiao"/>'], //按钮
                    title: " <fmt:message code="common.th.prompt" />"
                },function(){
                    $.ajax({
                        url:'/vote/manage/deleteByVoteId',
                        type:'post',
                        dataType:'json',
                        data:{voteIds:str},
                        success:function(){
                            layer.msg(' <fmt:message  code="workflow.th.delsucess"/>', {icon: 6});
                            window.location.reload();
                        }
                    })
                }, function () {
                    layer.closeAll();
                })

            }
        })
//        点击标题
        $('.list').on('click','.titleName',function(){
            var sId=$(this).parent().attr('id');
//            var piv = $(this).attr('data-priv')
//            if(piv==0){
//                $.layerMsg({content:'请投票后在查看',icon:7})
//                return false;
//            }
//            if(piv==2){
//                $.layerMsg({content:'不可查看',icon:2})
//                return false;
//            }
//            var title=$(this).find('a').html();

            window.open ("/vote/manage/voteResult?resultId="+sId+"&type=0", "newwindow", "height=500, width=800, top=100, left=300, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no")
        })

//        点击全部删除
        $('#allDel').on('click',function(){
//            $('.childCheck').prop('checked',true);
            var checkL=$('.childCheck:checkbox').length;
            var arr=[];
            if(checkL != 0){
                $('.childCheck:checkbox').each(function(){

                    var sId=$(this).parent().parent().attr('id');
                    arr.push(sId);
                })
                var str=arr.join();
                layer.confirm(' <fmt:message code="event.th.allDeleted" />？', {
                    btn: [' <fmt:message  code="global.lang.ok"/>', ' <fmt:message  code="depatement.th.quxiao"/>'], //按钮
                    title: " <fmt:message code="common.th.prompt" />"
                },function(){
                    $.ajax({
                        url:'/vote/manage/deleteByVoteId',
                        type:'post',
                        dataType:'json',
                        data:{voteIds:str},
                        success:function(){
                            layer.msg(' <fmt:message  code="workflow.th.delsucess"/>', {icon: 6});
                            window.location.reload();
                        }
                    })
                }, function () {
                    layer.closeAll();
                })

            }
        })
//        点击清空数据
        $('#empty').on('click',function(){
            $('.list').empty();
        })

//        点击修改
        $('.table').on('click','.editd',function(){
            var sId=$(this).parent().attr('id');
            self.parent.document.getElementById('iframe').src='/vote/manage/editVote?editId='+sId;
        })

    })



</script>
</body>


</html>
