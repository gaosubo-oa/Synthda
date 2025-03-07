
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
    <title>部门号码管理</title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <script src="/js/common/language.js"></script>

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>
        table tbody td{
            text-align: left!important;
        }
        input{
            float: none;
        }
        .editAndDelete3{
            color: red;
        }
        .newClass{
            float: right;
            width: 90px;
            height: 28px;
            background: url(../../img/file/cabinet01.png) no-repeat;
            color: #fff;
            font-size: 14px;
            line-height: 28px;
            margin: 2%  3% 0 0;
            cursor: pointer;
        }
        .delete_check {
            display: inline-block;
            width: 70px;
            height: 28px;
            position: relative;
            color: #ffffff;
            border-radius: 3px;
            background: #2b7fe0;
            text-align: center;
            line-height: 28px;
            margin-left: 20px;
        }
        .editAndDelete2{
            color: red;
        }
        .pagediv .page-bottom-outer-layer table td:last-child{
            border-right: 1px #dddddd solid;
        }
        .page-top-inner-layer{
            padding: 0!important;
        }
        table tr td,table tr th{
            text-align: center !important;
        }
        table tr td:last-child{
            width:150px !important;
        }
        table tfoot tr td:last-child{
            text-align: left !important;
        }
        table tr th:last-child{
            width:150px !important;
        }
        .pagediv{
            width: 80% !important;
        }
    </style>
</head>
<body>
<div class="navigation">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/gonggaoguanli.png" alt="">
    <h2>部门号码管理</h2>

</div>
<div id="pagediv">

</div>
</body>
<script>
    $(function () {

//表格初始化
        var pageObj=$.tablePage('#pagediv','100%',[
            {
                width:'5%',
                title:ggghhhh,
                name:'',
                selectFun:function (n,obj) {
                    return '<input type="checkbox" class="choose" data-id="'+obj.deptId+'">'
                }
            },
            {
                width:'24%',
                title:'部门名称',
                name:'deptName',
                selectFun:function (name,obj,i) {
                    if(name){
                        return name;
                    } else {
                        return '(<span class="red">用户已删除</span>)'
                    }
                }
            },
            {
                width:'28%',
                title:'部门号码',
                name:'smsGateAccount'
            },
            {
                width:'15%',
                title:option
            },
        ],function (me) {
//            me.data.typeId=$('[name="type"]').val();
//            me.data.changeId='1';
//            me.data.exportId='1';

            //1显示  // 2不显示  //不写fn这个属性就是全显示
            me.init("/department/infoList",[
                // {name:notice_th_QueryStatus,fn:function (obj) {
                //     if(obj.publish==2||obj.publish==0){
                //         return 2
                //     }else {
                //         return notice_th_QueryStatus
                //     }
                // }},
                // {name:notice_state_end,fn:function (obj) {
                //     if(obj.publish==1){
                //         return '<span data-type="stop">'+notice_state_end+'</span>'
                //     }else if(obj.publish==4 || obj.publish==5){
                //         return '<span data-type="effective">'+notice_state_effective+'</span>'
                //     }else if(obj.publish==2||obj.publish==0){
                //         return 2
                //     }
                // }},
//                {name:'详细信息'},
//                {name:'修改'},
                {name:del}
            ],function () {
                var str='<tr>' +
                    '<td style="width: 400px;padding-left: 5px"><input type="checkbox" name="all"><span>'+notice_th_allchose+'</span></td>' +
                    '<td colspan="4" style="text-align: left">' +
                    '<a href="javascript:;" class="delete_check"><img src="/img/file/icon_fileDelete.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt="">删除</a>' +
                    // '<a class="delete_all"><span style="margin-left:27px;">删除全部内容</span></a>' +
                    '</td>' +
                    '</tr>'
                $('#operation').html(str)
            })
        })



        // 事件绑定处理
        $('#pagediv').on('click','[name="all"]',function(){//全选
            if($(this).is(':checked')){
                $('#pageTbody').find('input[type=checkbox]').prop('checked',true)
            }else {
                $('#pageTbody').find('input[type=checkbox]').removeProp('checked')
            }
        })



        $('#pagediv').on('click','.delete_check',function(){//删除公告
            if($('#pageTbody').find('input[type=checkbox]:checked').length==0){
                $.layerMsg({content:'请先选择内容',icon:2});
                return;
            }
            var fileId=[];
            $('#pageTbody').find('input[type=checkbox]:checked').each(function(){
                var conId=$(this).attr("data-id");
                fileId.push(conId);
            })

            console.log()
            layer.confirm(qued, {
                btn: [sure,cancel], //按钮
                title:queding
            }, function(){
                $.ajax({
                    type:'post',
                    url:'/department/infoDel',
                    dataType:'json',
                    data:{'deptId':fileId.join()},
                    success:function(json){
                        if(json.flag){
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









//        $('#pagediv').on('click','.editAndDelete0',function(){
//            var ids=pageObj.arrs[$(this).attr('data-i')].id;
//            $.popWindow("learningExperienceDetail?ids="+ids,'学习经历详细信息','0','0','1150px','700px');
//        })

        $('#pagediv').on('click','.editAndDelete0',function(){
            var delid = [];
            var deptId=pageObj.arrs[$(this).attr('data-i')].deptId;
            delid.push(deptId)
            // parent.$('[name="notices"]').attr('src','../../notice/newAndEdit?type=edit&notifyId='+notifyId)
            layer.confirm(qued, {
                btn: [sure,cancel] ,//按钮
                title:ifDelete
            }, function(){
                //确定删除，调接口
                $.ajax({
                    url: "/department/infoDel",
                    type: "get",
                    data:{
                        'deptId':deptId
                    },
                    dataType: 'json',
                    success: function (json) {
                        if (json.flag) {
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


        $('#pagediv').on('click','.editAndDelete1',function(){
            var me=this;
            var id=pageObj.arrs[$(this).attr('data-i')].id;
            console.log(id)
            parent.$('[name="notices"]').attr('src','/learningExperience/newLearningExperience?id='+id)

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
                            $.layerMsg({content: '进入删除审批，审批通过后删除', icon: 4}, function () {
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

        $('.submit').click(function () {
            pageObj.data.read='';
            pageObj.data.typeId=$('[name="type"]').val();
            pageObj.data.changeId='1';
            pageObj.data.exportId='1';
            pageObj.init()
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


    })
</script>
</html>
