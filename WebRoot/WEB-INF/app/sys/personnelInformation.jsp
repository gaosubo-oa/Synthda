<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/4/23
  Time: 10:27
  To change this template use File | Settings | File Templates.
--%>
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
    <title>人事信息同步</title>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta name="renderer" content="ie-comp">
    <meta name="renderer" content="ie-stand">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7; IE=EmulateIE9">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">

    <link rel="stylesheet" type="text/css" href="/css/sys/userManagement.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base.css"/>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <link rel="stylesheet" type="text/css" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" type="text/css" href="/lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="/lib/laydate/need/laydate.css">

    <script src="/js/xoajq/xoajq1.js" charset="utf-8"></script>
    <script src="/js/base/base.js?20200119.1" charset="utf-8"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/lib/laydate/laydate.js"></script>

    <style>
        .bottom .boto div {
            cursor: pointer;
            color: #2B7FE0;
            font-size: 14px;
            display: block;
            border: #ccc 1px solid;
            padding: 2px 4px;
            border-radius: 3px;
            margin-top: 0;
            margin-left: 0;
        }
        .dept_order_box th{
            padding: 10px;
            font-size: 11pt;
            text-align: center;
        }
        .dept_order_box td {
            padding: 5px;
            text-align: center;
        }
        .dept_order_box table input {
            width: 40px;
            height: 20px;
        }
        .dept_order_box table select {
            height: 20px;
            padding: 2px;
            box-sizing: content-box;
        }
    </style>
</head>
<body>
    <div class="content clearfix" style="padding-bottom: 20px;overflow:hidden;">
        <%-- 头部信息 --%>
        <div class="headDiv" style="background-color: #fff">
            <div class="div_Img">
                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_userManagement1.png" style="vertical-align: middle;" alt="用户管理-管理范围（全体）">
            </div>
            <div class="divP">人事信息同步</div>
        </div>
            <div class="title" style="padding: 5px 0 0 30px;margin-top: 46px;">
                <span class="USER"><fmt:message code="main.usermanage" /></span><span class="post currentDept"></span>
                <select name="allUser" id="allSelUser">
                    <option value=""><fmt:message code="userManagement.th.AllUser" /></option>
                    <option value="0"><fmt:message code="userManagement.th.AllowIogonUser" /></option>
                    <option value="1"><fmt:message code="userManagement.th.NoIogonUser" /></option>
                </select>
                <span class="explain"><fmt:message code="userManagement.th.Explanation" /></span>
            </div>

            <div class="tab">
                <table cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
                    <thead>
                        <tr class='tr_befor'>
                            <th></th>
                            <th><fmt:message code="userName" /></th>
                            <th><fmt:message code="userManagement.th.Realname" /></th>
                            <th><fmt:message code="userManagement.th.department" /></th>
                            <th><fmt:message code="userManagement.th.role" /></th>
                            <th>状态</th>
                            <th>职务</th>
                            <th><fmt:message code="userManagement.th.LastAccess" /></th>
                            <th><fmt:message code="userManagement.th.idle" /></th>
                            <th><fmt:message code="notice.th.operation" /></th>
                        </tr>
                    </thead>
                    <tbody class="tab_tbody"></tbody>
                </table>
            </div>
            <div class="bottom w clearfix">
                <div class="checkALL">
                    <input id="checkedAll" type="checkbox" name="" value="" >
                    <label for="checkedAll" style="font-size: 14px;"><fmt:message code="notice.th.allchose" /></label>
                </div>
                <div class="boto">
                    <div class="ONE" href="javascript:void(0)"><span><fmt:message code="global.lang.delete" /></span></div>
                </div>
                <div class="boto">
                    <div class="TWO" href="javascript:void(0)"><span><fmt:message code="userManagement.th.Emptylong" /></span></div>
                </div>
                <div class="boto">
                    <div class="THREE" href="javascript:void(0)"><span><fmt:message code="userManagement.th.Emptypassword" /></span></div>
                </div>
                <div class="boto">
                    <div class="FOUR" href="javascript:void(0)"><span><fmt:message code="userManangement.th.Nologin" /></span></div>
                </div>
                <%--<div class="boto">
                    <div class="FIVE" href="javascript:void(0)"><span><fmt:message code="userManagement.th.Remind" /></span></a>
                </div>--%>
                <div class="boto">
                    <div class="SIX" href="javascript:void(0)"><span><fmt:message code="userManagement.th.BatchExchangeDepartment" /></span></div>
                </div>

            </div>
    </div>

    <script>
        var USER_DEPT_ORDER = false

        var searchData = {}
        // 判断是否开启用户部门排序功能
        $.get('/department/order', function(res){
            if (res.flag) {
                USER_DEPT_ORDER = res.code == 1
            }
        });

        var user_id = ''
        $(function(){

            $.get('/department/selectUnallocated', function(res){
                if (res.flag){
                    searchData.deptId = res.object.deptId
                    deptById()
                }
            })

            //全选点击事件
            $('#checkedAll').click(function(){
                var state =$(this).prop("checked");
                if(state==true){
                    $(this).prop("checked",true);
                    $(".checkChild").prop("checked",true);
                    $(".userData").addClass('bgcolor');
                }else{
                    $(this).prop("checked",false);
                    $(".checkChild").prop("checked",false);
                    $('.userData').removeClass('bgcolor');
                }
            })

            //删除人员按钮
            $('.ONE').click(function(){
                if($('.tab table input[type="checkbox"]:checked').length==0){
                    $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:1})
                    return
                }
                buttonInterface('../user/deleteUser','<fmt:message code="sys.th.MakeSureDelete" />？');
            })
            //清空在线时长按钮
            $('.TWO').click(function(){
                if($('.tab table input[type="checkbox"]:checked').length==0){
                    $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:1})
                    return
                }
                buttonInterface('../user/clearOnLine','<fmt:message code="sys.th.MakeSureEmpty" />？');
            })
            //清空密码按钮
            $('.THREE').click(function(){
                if($('.tab table input[type="checkbox"]:checked').length==0){
                    $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:1})
                    return
                }
                buttonInterface('../user/clearPassword','<fmt:message code="sys.th.VerifyPassword" />？');
            })
            //禁止登录按钮
            $('.FOUR').click(function(){
                if($('.tab table input[type="checkbox"]:checked').length==0){
                    $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:1})
                    return
                }
                buttonInterface('../user/setNotLogin','<fmt:message code="sys.th.MakeSure" />？');
            })
            // 提醒空密码用户按钮
            $('.FIVE').click(function(){
                $.layerMsg({content:'<fmt:message code="lang.th.Upcoming" />',icon:1})
                return
            })
            // 批量修改部门按钮
            $('.SIX').click(function(){
                if($('.tab table input[type="checkbox"]:checked').length==0){
                    $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:1})
                    return
                }
                layer.open({
                    title:'<fmt:message code="sys.th.BatchModification" />',
                    content:'<div>' +
                        '<table>' +
                        '<tr><td style="border-right: 1px solid #ddd"><fmt:message code="main.usermanage" />:</td><td><textarea style="margin-right: 10px;" name="" id="textareaopen"></textarea><a href="javascript:void(0)" class="addopens"><fmt:message code="global.lang.add" /></a></td></tr>' +
                        '<tr><td style="border-right: 1px solid #ddd"><fmt:message code="sys.th.NewSector" />:</td><td><select style="width: 139px;" name="" id="newselectrrole"></select></td></tr>' +
                        '<tr><td style="border-right: 1px solid #ddd"><fmt:message code="sys.th.ReminderDepartment" />:</td><td><label style="margin-right: 10px;"><input name="checktit" type="checkbox"><fmt:message code="notice.th.remindermessage" /></label>' +
                        '<label><input name="checktit" type="checkbox"><fmt:message code="sys.th.SendReminderMessage" /></label></td></tr></table></div>',
                    area:['500px','300px'],
                    btn:['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'],
                    yes:function (index) {
                        var obj={
                            'deptId':$('#newselectrrole').val(),
                            'uids':$('#textareaopen').attr('dataid'),
                            'nowDeptId':$('.userData').eq(0).find('td').eq(3).attr('data-deptid')
                        }
                        $.post('/user/editUsersDeptId',obj,function (json) {
                            if(json.flag){
                                $.layerMsg({content:'<fmt:message code="sys.th.SwapComplete" />',icon:1},function () {
                                    location.reload()
                                })
                            }
                        },'json')
                    },
                    success:function () {
                        $('#newselectrrole').deptSelect(function (me) {//me是传过来的this，newselectrrole
                            $.get('/department/selectUnallocated', function(res){
                                $(me).append('<option value="0"><fmt:message code="userManagement.th.Outgoing" /></option>')
                                if (res.flag && res.msg != 'false') {
                                    $(me).append('<option value="'+res.object.deptId+'">'+res.object.deptName+'</option>')
                                }
                                $('#newselectrrole').val($('.tab table tbody [type="checkbox"]:checked').parent().parent().find('td').eq(3).attr('data-deptid'))
                            })
                        })
                        var strcheck='',struserId='',struid='';
                        $('.tab table tbody [type="checkbox"]:checked').each(function(){
                            strcheck+=$(this).parent().parent().find('td').eq(2).text()+',';
                            struserId+=$(this).parent().parent().find('td').eq(1).attr('userid')+',';
                            struid+=$(this).parent().parent().attr('uid')+',';
                        })
                        $('#textareaopen').val(strcheck)
                        $('#textareaopen').attr('user_id',struserId)
                        $('#textareaopen').attr('dataid',struid)
                        $('.addopens').click(function(){
                            user_id=$(this).prev().prop('id')
                            $.popWindow("../common/selectUser");
                        })
                    }
                })
            })

            $('#allSelUser ').on('change',function () {

                searchData.notLogin = $(this).val();

                if($(this).val()==''){
                    delete searchData.notLogin;
                }

                deptById(searchData)

            });

        })

        //列表功能按钮
        function buttonInterface(URL,txt){
            var string='';

            $('.tab table input[type="checkbox"]:checked').each(function(i,n){
                string+=$(this).parent().parent().attr('uId')+',';
            })

            var msg=txt;

            $.layerConfirm({title:msg,content:msg,icon:0,offset:"200px"},function(){
                $.ajax({
                    type:'post',
                    url:URL,
                    dataType:'json',
                    data:{'uids':string},
                    success:function(res){

                        if(res.flag){

                            if(msg == '确认禁止选中人员登录？'){

                                deptById()

                                $.layerConfirm({title:'信息',content:'是否禁止登录后调整至离职部门?',icon:0,offset:"200px"},function(){
                                    $.ajax({
                                        url:'/user/editUsersDeptId',
                                        type:'get',
                                        data:{deptId:0,uids:string},
                                        success:function(ress){
                                            if(ress.flag){
                                                $.layerMsg({content:'调整成功',icon:0});
                                                window.location.reload()
                                            }else{
                                                $.layerMsg({content:'调整失败',icon:1})
                                            }
                                        }
                                    })
                                })
                            }
                        }
                    }
                })
            })
        }

        function deptById(){

            $.get('/getSpecialUsers', searchData, function(res){
                if (!res.flag) {
                    var data = res.obj
                    var str= '';

                    for(var i = 0; i < data.length; i++){
                        var colorNum='';
                        var lastVisitTime='';
                        if(data[i].password=='') {
                            colorNum = 'colorRed'
                        }
                        if(data[i].notLogin==1){
                            colorNum='colorddd'
                        }
                        if(data[i].lastVisitTime!=undefined){
                            lastVisitTime=data[i].lastVisitTime
                        }

                        str += '<tr class="userData '+colorNum+'" uId="' + data[i].uid + '">' +
                            '<td>'+function(){if(data[i].byname=="admin"){
                                return ''
                            }else{
                                return '<input type="checkbox" class="checkChild" name="checkbox" value=""  style="width:13px;height:13px;" />'
                            }}()+'</td>' +
                            '<td userid="'+ data[i].userId +'">' + data[i].byname + '</td>' +
                            '<td>' + data[i].userName + '</td>' +
                            '<td data-deptid="'+data[i].deptId+'">' + (data[i].deptName || '') + '</td>' +
                            '<td>' + data[i].userPrivName + '</td>' +
                            '<td>' + data[i].remark + '</td>' +
                            '<td>' + function () {
                                if(data[i].postName!=undefined){
                                    return data[i].postName
                                }else{
                                    return ''
                                }
                            }() + '</td>' +
                            '<td>' + lastVisitTime + '</td>' +
                            '<td>' + data[i].idleTime + '</td>' +
                            '<td>'+function(){
                                if(data[i].byname==''){
                                    return '';
                                }else{
                                    var str = '<a href="javascript:void(0)" onclick="clickrenwu('+data[i].uid+',this)" style="margin-right: 5px;"><fmt:message code="global.lang.edit" /></a>'

                                    if (USER_DEPT_ORDER) {
                                        str += '<a href="javascript:;" userid="'+data[i].userId+'" name="'+data[i].userName+'" onclick="userDeptOrder(this)">部门排序</a>'
                                    }

                                    return str
                                }
                            }()+'</td>' +
                            '</tr>';
                        $("#checkedAll").removeAttr("checked");
                    }

                    $('.tab_tbody').html(str);
                }
            })
        }

        function clickrenwu(deptId,me) {
            userstr=$(me).text();
            window.open('../addUsers?'+deptId,'<fmt:message code="sys.th.EditUser" />');
        }

        function userDeptOrder(ele){
            var loadIndex = layer.load(2);
            var userId = $(ele).attr('userid');
            var layerIndex = layer.open({
                title: $(ele).attr('name')+'的部门排序',
                type: 1,
                area: ['600px', '500px'],
                btn: ['确认', '取消'],
                content: '<div class="dept_order_box" style="padding: 8px"><table><thead><tr><th>部门</th><th>排序</th><th>职务</th></tr></thead><tbody id="deptOrderTable"></tbody></table></div>',
                success: function (){
                    var option = '<option value="0">请选择</option>'
                    $.ajax({
                        url: '/duties/selectUserPostList',
                        type: 'GET',
                        async:false,
                        success: function(res){
                            if (res.flag && res.obj.length > 0) {
                                res.obj.forEach(function(post){
                                    option += '<option value="'+post.postId+'">'+post.postName+'</option>'
                                })
                            }
                        }
                    });

                    $.get('/department/deptOrder', {userId: userId}, function(res){
                        if (res.object.length > 0) {
                            res.object.forEach(function(order){
                                $str = $('<tr orderId="'+order.orderId+'" deptId="'+order.deptId+'" userId="'+userId+'"><td>'+order.deptName+'</td><td><input class="layui-input order_no" type="text" value="'+order.orderNo+'"></td><td><select>'+option+'<select></td></tr>')
                                $str.find('select').val(order.postId)
                                $('#deptOrderTable').append($str)
                            })
                        }
                    });
                    layer.close(loadIndex)
                },
                yes: function(){
                    var userDeptOrders = []
                    var $tr = $('#deptOrderTable tr')
                    $tr.each(function(){
                        var orderId = parseInt($(this).attr('orderId'))
                        var deptId = parseInt($(this).attr('deptId'))
                        var userId = $(this).attr('userId')
                        var orderNo = parseInt($(this).find('input').val().trim() || 0)
                        var postId = parseInt($(this).find('select').val() || 0)
                        var item = {orderId: orderId, deptId: deptId, userId: userId, orderNo: orderNo, postId: postId}
                        userDeptOrders.push(item)
                    })
                    $.ajax({
                        url: '/department/updeptOrder',
                        type: 'post',
                        data: {userDeptOrders: JSON.stringify(userDeptOrders)},
                        success: function(res){
                            if (res.flag) {
                                layer.msg('保存成功')
                                layer.close(layerIndex)
                            } else {
                                layer.msg('保存失败')
                            }
                        }
                    })
                }
            })
        }

        //监听键盘事件，部门排序只能输入数字
        $(document).on('keypress', '.order_no', function (e) {
            var key = window.event ? e.keyCode : e.which

            if (!((key > 95 && key < 106) || (key > 47 && key < 58) || key == 8 || key == 9 || key == 13 || key == 37 || key == 39)) {
                return false
            }
        })
        // 监听输入内容
        $(document).on('input propertychange', '.order_no', function (event) {
            var value = parseInt($(this).val())
            if (isNaN(value)) {
                $(this).val('')
            } else {
                $(this).val(value)
            }
        });

    </script>
</body>
</html>
