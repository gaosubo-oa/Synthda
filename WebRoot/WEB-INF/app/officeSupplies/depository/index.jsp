<%--
  Created by IntelliJ IDEA.
  User: 高亚峰
  Date: 2017/10/9
  Time: 15:290
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title><fmt:message code="vote.th.warehouse" /></title>

    <style>
        .news{
            cursor: pointer;
        }
        .div_tr input {
            float: none;
            height: 28px;
            border-width: 1px;
            border-style: solid;
            border-color: rgb(153, 153, 153);
            border-image: initial;
        }
        .span_td{
            display: inline-block;
            width: 150px;
            text-align: right;
        }
        .inputlayout>ul ul>li.active {
            background: #4898d5;
            color: #fff;
        }
        .inPole{
            display: inline-block;
        }
        a{
            color: #2e8ded;
        }
        .newsBtn{

        }
        input.jump-ipt{
            float: left;
            width: 30px;
            height: 30px;
            border: 1px solid #bdbdbd;
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

    </style>
    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/css/office/depository/index.css">
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body style="background: #fff">
<div class="maintop clearfix" style="margin-top: 4px;border-bottom: #999 1px solid;" >
    <p style="margin-left: 10px">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/bgglk.png" style="width: 25px;height: 24px;vertical-align: text-bottom;" alt="">
        <label><fmt:message code="vote.th.warehouse" /></label>
    </p>
    <a  class="newsBtn newsBtntwo" style="padding: 0px 23px 0px 32px; float: right;margin-right: 3%;margin-top: 5px;" href="javascript:void (0)" data-num="0"><img style="margin-right: 4px;margin-left: -12px;margin-bottom: 3px;" src="../../img/mywork/newbuildworjk.png" alt=""><fmt:message code="global.lang.new" /></a>
</div>



<div class="mainBottom" style="margin-top: 10px;">
    <table>
        <thead>
        <tr>
            <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="workflow.th.Serial" /></th><%--序号--%>
            <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="vote.th.OfficeStorehouse" /></th><%--业务模块--%>
            <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="vote.th.OfficeCategory" /></th><%--名称--%>
            <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="workflow.th.sector" /></th><%--数据方向--%>
            <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="vote.th.GODOWN" /></th><%--流程--%>
            <th class="th" style="color: #2F5C8F;" width="20%" align="center"><fmt:message code="vote.th.GoodsDispatcher" /></th><%--数据映射--%>
            <th class="th" style="color: #2F5C8F;" width="20%" align="center"><fmt:message code="menuSSetting.th.menuSetting" /></th><%--操作--%>
        </tr>
        </thead>
        <tbody>
        <tr>

        </tr>
        </tbody>
    </table>
    <div id="dbgz_page" class="M-box3 fr" style="float: right; margin-top: 1%">

    </div>
</div>
</body>
<script>
    var user_id="";
    var deptid="";
    var priv_id="";

    $(function(){
     init();
    })
    function init(){
        var ajaxPageLe = {
            data: {
                page: 1,//当前处于第几页
                pageSize: 10,//一页显示几条
                useFlag: true,
                borrower:$("#borrower").attr("user_id"),
                grantStatus:$("#grantStatus").val(),
                transBeginDate:$("#transBeginDate").val(),
                transEndDate:$("#transEndDate").val()
                // computationNumber:null
            },
            page: function () {
                var me = this;
                $.ajax({
                    url: '/officeDepository/selAllDepositoryPage',
                    type: 'get',
                    dataType: 'json',
                    data:me.data,
                    success: function (result) {
                        var str="";
                        var arr =result.obj;
                        for(var i=0;i<arr.length;i++){
                            str+='<tr>'+
                                '<td>'+(i+1)+'</td>'+
                                '<td>'+arr[i].depositoryName+'</td>'+
                                '<td>'+arr[i].officeTypeName+'</td>'+
                                '<td>'+arr[i].deptName+'</td>'+
                                '<td>'+arr[i].managerName+'</td>'+
                                '<td>'+arr[i].proKeeperName+'</td>'+
                                '<td>'+
                                ' <a href="javascript:;" class="details" onclick="edit('+arr[i].id+');">'+"<fmt:message code="global.lang.edit" />"+'</a>&nbsp'+
                                '<a href="javascript:;" onclick="deleteone('+arr[i].id+')" style="color: red"><fmt:message code="global.lang.delete" /></a>&nbsp'+
                                '<a href="javascript:;" onclick="manage('+arr[i].id+')"><fmt:message code="vote.th.ClassificationManagement" /></a>&nbsp'+
                                '</td>'+
                                '</tr>';
                        }
                        $('.mainBottom table tbody').html(str);
                        me.pageTwo(result.totleNum, me.data.pageSize, me.data.page)
                    }
                })
            },
            pageTwo: function (totalData, pageSize, indexs) {
                var mes = this;
                $('#dbgz_page').pagination({
                    totalData: totalData,
                    showData: pageSize,
                    jump: true,
                    coping: true,
                    homePage: '',
                    endPage: '',
                    current: indexs || 1,
                    callback: function (index) {
                        mes.data.page = index.getCurrent();
                        mes.page();
                    }
                });
            }
        }
        ajaxPageLe.page();
    }
    $('.newsBtn').on("click",function(){
        console.log('aaa')
        layer.open({
            type: 1,
            title: ['<fmt:message code="vote.th.NewSorehouse" />', 'background-color:#2b7fe0;color:#fff;'],
            area: ['573px', '480px'],
            offset: ['100px', '350px'],
            shadeClose: true, //点击遮罩关闭
            btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
            content: '<div class="div_table" style="height: 100px;width: 250px; margin-top: 10px; margin-left: 10px;">'+

            '<div class="div_tr" style="width:473px;margin:10px;line-height: 18px; ">'+'<span class="span_td"><fmt:message code="vote.th.OfficeNames" />：</span><span><input type="text" style="width: 220px;" id="depositoryName" name="depositoryName"  value="" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>' +
            '<div class="div_tr" style="width:473px;margin:10px;line-height: 18px; ">'+'<span class="span_td" style="float:left;"><fmt:message code="workflow.th.sector" />：</span><span><div class="inPole"><textarea name="txt" class="userDept test_null" id="userDept" deptid="" deptid="" value="" disabled style="min-width:220px;min-height:60px;"></textarea><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectDept" style="color: #2e8ded;" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;"  style="color: red;" id="clearDept" class="clearDept "><fmt:message code="global.lang.empty" /></a></span></div></span></div>'+
            '<div class="div_tr" style="width:473px;margin:10px;line-height: 18px; ">'+'<span class="span_td" style="float:left;"><fmt:message code="vote.th.GODOWN" />：</span><span><div class="inPole"><textarea name="txt" class="manager test_null" id="manager" user_id="" dataid="" value="" disabled style="min-width:220px;min-height:60px;"></textarea><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" style="color: #2e8ded;" id="selectUser" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;"  style="color: red;" id="clearUser" class="clearUser "><fmt:message code="global.lang.empty" /></a></span></div></span></div>'+
            '<div class="div_tr" style="width:473px;margin:10px;line-height: 18px; ">'+'<span class="span_td" style="float:left;"><fmt:message code="vote.th.LibraryRole" />：</span><span><div class="inPole"><textarea name="txt" class="privId test_null" id="privId" priv_id="" dataid="" value="" disabled style="min-width:220px;min-height:60px;"></textarea><span class="add_img" style="margin-left: 27px"><a href="javascript:;" id="selectPriv" style="color: #2e8ded;" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;"  style="color: red;" id="clearPriv" class="clearUser "><fmt:message code="global.lang.empty" /></a></span></div></span></div>'+
            '<div class="div_tr" style="width:473px;margin:10px;line-height: 18px; ">'+'<span class="span_td" style="float:left;"><fmt:message code="vote.th.GoodsDispatcher" />：</span><span><div class="inPole"><textarea name="txt" class="proKeeper test_null" id="proKeeper" user_id="" dataid="" value="" disabled style="min-width:220px;min-height:60px;"></textarea><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" style="color: #2e8ded;" id="selectproKeeper" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearproKeeper"  style="color: red;" class="clearproKeeper "><fmt:message code="global.lang.empty" /></a></span></div></span></div>'+ '<div class="div_tr" style="width:473px;margin:10px;line-height: 18px; ">'+'<span class="span_td" style="float:left;"><fmt:message code="event.th.DepartmentApprover" />：</span><span><div class="inPole"><textarea name="txt" class="proKeeper test_null" id="returnReason2" user_id="" dataid="" value="" disabled style="min-width:220px;min-height:60px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;"  style="color: #2e8ded;" id="returnReason" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="returnReason3"  style="color: red;" class="returnReason3"><fmt:message code="global.lang.empty" /></a></span></div></span></div>'+
            '</div>',
            yes: function (index) {
                var data = {
                    depositoryName: $('input[name="depositoryName"]').val(),
                    deptId:  $('#userDept').attr('deptid'),
                    manager: $('#manager').attr('user_id'),
                    privId: $('#privId').attr('userpriv'),
                    proKeeper: $('#proKeeper').attr('user_id'),
                    returnReason: $('#proKeeper').attr('user_id')
                }
                if(checkForm()){
                    newClassification(data);
                    layer.close(index);
                }
            },
        });

        $("#returnReason").on("click",function(){
            user_id='returnReason2';
            $.popWindow("../common/selectUser?0");
        });

        $('#returnReason3').on("click",function(){ //清空人员
            $('#returnReason2').attr('user_id','');
            $('#returnReason2').attr('dataid','');
            $('#returnReason2').val('');
        });
        //选部门控件
        $('#selectDept').on("click",function(){
            dept_id='userDept';
             $.popWindow("../common/selectDept");
        });
        $('#clearDept').on("click",function(){ //清
            $('#userDept').attr('deptid','');
            $('#userDept').val('');
        });
           //库管理员
         $("#selectUser").on("click",function(){
         user_id='manager';
         $.popWindow("../common/selectUser");
         });

         $('#clearUser').on("click",function(){ //清空人员
         $('#manager').attr('user_id','');
         $('#manager').attr('dataid','');
         $('#manager').val('');
         });
         //选角色控件
         $("#selectPriv").on("click",function(){
         priv_id='privId';
         $.popWindow("../common/selectPriv");
         });

         $('#clearPriv').on("click",function(){ //清空人员
         $('#privId').attr('privid','');
         $('#privId').attr('userpriv','');
         $('#privId').val('');
         });
         //选物品调度员控件
         $("#selectproKeeper").on("click",function(){
         user_id='proKeeper';
         $.popWindow("../common/selectUser");
         });

         $('#clearproKeeper').on("click",function(){ //清空人员
         $('#proKeeper').attr('user_id','');
         $('#proKeeper').attr('dataid','');
         $('#proKeeper').val('');
         });
    })

    //新建分类接口
    function newClassification(data){
        $.ajax({
            type:'post',
            url:'/officeDepository/insertDepository',
            dataType:'json',
            data:data,
            success:function(res){
                init();
                if(res.flag){
                    $.layerMsg({content:'<fmt:message code="url.th.addSuccess" />！',icon:1});
                }else{
                    $.layerMsg({content:'<fmt:message code="hr.th.AddFailed" />！',icon:2});
                }
            }
        })
    }

    //编辑分类处理
    function editClassification(data){
        $.ajax({
            type:'post',
            url:'/officeDepository/updateDepositoryById',
            dataType:'json',
            data:data,
            success:function(res){
                init();
                if(res.flag){
                    $.layerMsg({content:'<fmt:message code="vote.th.UpdateSuccess" />！',icon:1});
                }else{
                    $.layerMsg({content:'<fmt:message code="vote.th.UpdateFailure" />！',icon:2});
                }
            }
        })
    }




    function deleteone(e){
        layer.confirm('<fmt:message code="sup.th.Delete1" />？', {
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
            title:"<fmt:message code="vote.th.DeletSupplies" />",
            offset: ['100px', '300px']
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'post',
                url:'/officeDepository/delDepositoryById',
                dataType:'json',
                data:{'id':e},
                success:function(res){
                    if(res.flag){
                        layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});
                        init();

                    }else{
                        layer.msg('<fmt:message code="lang.th.deleSucess" />', { icon:2});
                        init();
                    }

                }
            })
        }, function(){
            layer.closeAll();
        });
    }

    function edit(e){
        layer.open({
            type: 1,
            title: ['<fmt:message code="vote.th.Edited" />', 'background-color:#2b7fe0;color:#fff;'],
            area: ['600px', '500px'],
            offset: ['100px', '300px'],
            shadeClose: true, //点击遮罩关闭
            btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
            content: '<div class="div_table" style="height: 100px;width: 250px; margin-top: 10px; margin-left: 10px;">'+
                '<div class="id" id="id" type="hidden"></div>'+
            '<div class="div_tr" style="width:473px;margin:10px;line-height: 18px; ">'+'<span class="span_td"><fmt:message code="vote.th.OfficeNames" />：</span><span><input type="text" style="width: 220px;" id="depositoryName" name="depositoryName"  value="" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>' +
            '<div class="div_tr" style="width:473px;margin:10px;line-height: 18px; ">'+'<span class="span_td" style="float:left;"><fmt:message code="workflow.th.sector" />：</span><span><div class="inPole"><textarea name="txt" class="userDept test_null" id="userDept1" deptid="" deptid="" value="" disabled style="min-width:220px;min-height:60px;"></textarea><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span><span class="add_img" style="margin-left: 10px"><a href="javascript:;"  style="color: #2e8ded;" id="selectDept1" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearDept1"  style="color: red;" class="clearDept "><fmt:message code="global.lang.empty" /></a></span></div></span></div>'+
            '<div class="div_tr" style="width:473px;margin:10px;line-height: 18px; ">'+'<span class="span_td" style="float:left;"><fmt:message code="vote.th.GODOWN" />：</span><span><div class="inPole"><textarea name="txt" class="manager test_null" id="manager1" user_id="" dataid="" value="" disabled style="min-width:220px;min-height:60px;"></textarea><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span><span class="add_img" style="margin-left: 10px"><a href="javascript:;"  style="color: #2e8ded;" id="selectUser1" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;"  style="color: red;" id="clearUser1" class="clearUser "><fmt:message code="global.lang.empty" /></a></span></div></span></div>'+
            '<div class="div_tr" style="width:473px;margin:10px;line-height: 18px; ">'+'<span class="span_td" style="float:left;"><fmt:message code="vote.th.LibraryRole" />：</span><span><div class="inPole"><textarea name="txt" class="privId test_null" id="privId1" priv_id="" dataid="" value="" disabled style="min-width:220px;min-height:60px;"></textarea><span class="add_img" style="margin-left: 27px"><a href="javascript:;" id="selectPriv1"  style="color: #2e8ded;" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearPriv1"  style="color: red" class="clearUser "><fmt:message code="global.lang.empty" /></a></span></div></span></div>'+
            '<div class="div_tr" style="width:473px;margin:10px;line-height: 18px; ">'+'<span class="span_td" style="float:left;"><fmt:message code="vote.th.GoodsDispatcher" />：</span><span><div class="inPole"><textarea name="txt" class="proKeeper test_null" id="proKeeper1" user_id="" dataid="" value="" disabled style="min-width:220px;min-height:60px;"></textarea><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span><span class="add_img" style="margin-left: 10px"><a href="javascript:;"  style="color: #2e8ded;" id="selectproKeeper1" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearproKeeper1"  style="color: red;" class="clearproKeeper "><fmt:message code="global.lang.empty" /></a></span></div></span></div>'+
            '<div class="div_tr" style="width:473px;margin:10px;line-height: 18px; ">'+'<span class="span_td" style="float:left;"><fmt:message code="event.th.DepartmentApprover" />：</span><span><div class="inPole"><textarea name="txt" class="proKeeper test_null" id="returnReason2" user_id="" dataid="" value="" disabled style="min-width:220px;min-height:60px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;"  style="color: #2e8ded;" id="returnReason" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="returnReason3"  style="color: red;" class="returnReason3"><fmt:message code="global.lang.empty" /></a></span></div></span></div>'+
            '<p class="div_tr" style="width:540px;margin:10px;line-height: 18px; "><fmt:message code="interfaceSetting.th.description" />：<br/>1、<fmt:message code="office.text1" />；<br/>2、<fmt:message code="office.text2" />；<br/>3、<fmt:message code="office.text3" />；<br/>4、<fmt:message code="office.text4" />；<br/>5、<fmt:message code="office.text5" />；<br/>6、<fmt:message code="office.text6" />；</p>'+
            '</div>',
            success:function(){
                //选物品调度员控件
                $("#returnReason").on("click",function(){
                    user_id='returnReason2';
                    $.popWindow("../common/selectUser?0");
                });

                $('#returnReason3').on("click",function(){ //清空人员
                    $('#returnReason2').attr('user_id','');
                    $('#returnReason2').attr('dataid','');
                    $('#returnReason2').val('');
                });
                $.ajax({
                    type: 'get',
                    url: '/officeDepository/selDepositoryById',
                    data: {id: e},
                    dataType: 'json',
                    success: function (res) {
                        var datas = res.object;
                        $('#id').val(datas.id);
                        $('input[name="depositoryName"]').val(datas.depositoryName);
                        $('#userDept1').attr('deptid',datas.deptId);
                        $('#userDept1').val(datas.deptName);
                        $('#manager1').attr('user_id',datas.manager);
                        $('#manager1').val(datas.managerName);
                        $('#privId1').attr('userpriv',datas.privId);
                        $('#privId1').val(datas.privName);
                        $('#proKeeper1').attr('user_id',datas.proKeeper);
                        $('#proKeeper1').val(datas.proKeeperName);
                        $('#returnReason2').attr('user_id',datas.returnReason);
                        $('#returnReason2').val(datas.returnReasonName);
                    }
                })
            },
            yes: function (index) {
                var data = {
                    id:$('#id').val(),
                    depositoryName: $('input[name="depositoryName"]').val(),
                    deptId:  $('#userDept1').attr('deptid'),
                    manager: $('#manager1').attr('user_id'),
                    privId: $('#privId1').attr('userpriv'),
                    proKeeper: $('#proKeeper1').attr('user_id'),
                    returnReason: $('#returnReason2').attr('user_id')
                }
                if(editcheckForm()){
                    editClassification(data);
                    layer.close(index);
                }
            },
        });
        //选部门控件
        $('#selectDept1').on("click",function(){
            dept_id='userDept1';
            $.popWindow("../common/selectDept");
        });
        $('#clearDept1').on("click",function(){ //清
            $('#userDept1').attr('deptid','');
            $('#userDept1').val('');
        });
        //库管理员
        $("#selectUser1").on("click",function(){
            user_id='manager1';
            $.popWindow("../common/selectUser");
        });

        $('#clearUser1').on("click",function(){ //清空人员
            $('#manager1').attr('user_id','');
            $('#manager1').attr('dataid','');
            $('#manager1').val('');
        });
        //选角色控件
        $("#selectPriv1").on("click",function(){
            priv_id='privId1';
            $.popWindow("../common/selectPriv");
        });

        $('#clearPriv1').on("click",function(){ //清空人员
            $('#privId1').attr('privid','');
            $('#privId1').attr('userpriv','');
            $('#privId1').val('');
        });
        //选物品调度员控件
        $("#selectproKeeper1").on("click",function(){
            user_id='proKeeper1';
            $.popWindow("../common/selectUser");
        });

        $('#clearproKeeper1').on("click",function(){ //清空人员
            $('#proKeeper1').attr('user_id','');
            $('#proKeeper1').attr('dataid','');
            $('#proKeeper1').val('');
        });
    }
    function checkForm(){
        if($('#depositoryName').val()==""){
            layer.msg('<fmt:message code="vote.th.SuppliesLibrary" />', { icon:2});
            return false;
        }
        if($('#userDept').attr('deptid')==""){
            layer.msg('<fmt:message code="vote.th.department" />', { icon:2});
            return false;
        }
        if($('#manager').attr('user_id')==""){
            layer.msg('<fmt:message code="vote.th.Storekeeper" />', { icon:2});
            return false;
        }
        if($('#proKeeper').attr('user_id')==""){
            layer.msg('<fmt:message code="vote.th.dispatcher" />', { icon:2});
            return false;
        }
        return true;
    }
    function editcheckForm(){
        if($('#depositoryName').val()==""){
            layer.msg('<fmt:message code="vote.th.SuppliesLibrary" />', { icon:2});
            return false;
        }
        if($('#userDept1').attr('deptid')==""){
            layer.msg('<fmt:message code="vote.th.department" />', { icon:2});
            return false;
        }
        if($('#manager1').attr('user_id')==""){
            layer.msg('<fmt:message code="vote.th.Storekeeper" />', { icon:2});
            return false;
        }
        if($('#proKeeper1').attr('user_id')==""){
            layer.msg('<fmt:message code="vote.th.dispatcher" />', { icon:2});
            return false;
        }
        return true;
    }
    function manage(e){
         window.location.href="/officeSupplies/goOfficeTypeList?typeDepository="+e;
    }
</script>
</html>
