<%--
  Created by IntelliJ IDEA.
  User: CY
  Date: 2017/12/21
  Time: 18:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title><fmt:message code="main.addressbookset" /></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <%--<link rel="stylesheet" type="text/css" href="../../css/dept/deptManagement.css"/>--%>
    <%--<link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/easyui.css"/>--%>
    <%--<link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/icon.css"/>--%>
    <%--<link rel="stylesheet" href="/lib/layer/skin/default/layer.css">--%>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <%--<link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>--%>
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">
    <%--<link rel="stylesheet" type="text/css" href="../../css/dept/new_news.css"/>--%>
<%--    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <%--<script src="../../lib/laydate.js"></script>--%>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/leader/jquery.form.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <style>
        .head{
            width:100%;
            height:45px;
            border-bottom:1px solid #9E9E9E;
            position:fixed;
            top:0px;
            z-index: 100;
            background: #fff;
        }
        .nav{
            overflow:hidden;
        }
        .nav li{
            height:28px;
            line-height:28px;
            float:left;
            font-size:14px;
            margin-left:20px;
            margin-top:6px;
            cursor:pointer;
        }
        .space{
            width:2px;
            margin-left:16px;
        }
        .pad{
            padding:0px 10px;
            line-height:28px;
        }
        .select{
            background-color:#2F8AE3;
            color:#fff;
            border-radius:20px;
            -webkit-border-radius:20px;
            -moz-border-radius:20px;
            -o-border-radius:20px;;
            -ms-border-radius:20px;
        }
        .headRight{
            float:right;
            background: url("../img/file/cabinet01.jpg") no-repeat;
            width: 124px;
            height: 30px;
            margin-top: -27px;
            margin-right: 20px;
            color:#fff;
            font-size:14px;
            cursor:pointer;
        }
        .headRight span{
            padding:5px 0px 0px 36px;
        }
        .title span{
            font-size:22px;
            color:#494d59;
            padding-left:20px;
        }
        .title{
            margin-bottom:20px;
            margin-top:60px;
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
        th{
            background-color: #fff;
            font-size: 15px;
            color: #2F5C8F;
            font-weight: bold;
            border: 0px;
            line-height:45px;
            padding-left: 10px;
        }
    </style>
</head>
<body>
    <div class="content">
        <div class="head">
            <ul class="nav">
                <li>
                    <span class="select pad"><fmt:message code="address.th.publicAddressBook" /></span>
                    <%--<img class="space" src="../../img/twoth.png" alt="">--%>
                </li>
            </ul>
            <div class="headRight choose" data-type="0">
                <span><fmt:message code="user.th.NewPacket" /></span>
            </div>
        </div>
        <div class="title">
            <img src="../../img/vote/manage.png" alt="" style="padding-left:20px">
            <span style="padding-left:0px"><fmt:message code="address.th.managementGroup" /></span>
        </div>
        <div style="margin: -60px auto 0px;height:50px;width: 97%;" class="clearfix">

        </div>
        <div class="table">
            <table style="width: 95%;margin:0 auto">
                <thead>
                    <tr>
                        <th><fmt:message code="address.th.groupName" /></th>
                        <th><fmt:message code="event.th.OpenSector" /></th>
                        <th><fmt:message code="address.th.openRole" /></th>
                        <th><fmt:message code="event.th.OpenPersonnel" /></th>
                        <th><fmt:message code="notice.th.operation" /></th>
                    </tr>
                </thead>
                <tbody class="list">

                </tbody>
            </table>
        </div>
    </div>
    <div id="dbgz_page" class="M-box3" style="margin-right: 30px;">

    </div>
    <script>
        <%--分页列表--%>
        var ajaxPageLe={
            data:{
                page:1,//当前处于第几页
                pageSize:5,//一页显示几条
                useFlag:true
            },
            page:function () {
                var me=this;
                $.ajax({
                    url:'/addressGroup/getPublicGroups',
                    type:'get',
                    data:me.data,
                    dataType:'json',
                    success:function(reg){
                        var datas=reg.obj;
                        var str="";
                        for(var i=0;i<datas.length;i++){
                            str+=' <tr id="'+datas[i].groupId+'">' +
                                '                        <td>'+datas[i].groupName+'</td>' +
                                '                        <td title='+datas[i].deptRange+'>'+function(){
                                    if(datas[i].deptRange==undefined){
                                        return ''
                                    }else{
                                        if(datas[i].deptRange.length>15){
                                            var sub=datas[i].deptRange.substring(0,14);
                                            return sub+"...";
                                        }
                                        return datas[i].deptRange
                                    }
                                }()+'</td>' +
                                '                        <td title='+datas[i].roleRange+'>'+function(){
                                        if(datas[i].roleRange==undefined){
                                            return '';
                                        }else{
                                            if(datas[i].roleRange.length>15){
                                                var sub=datas[i].roleRange.substring(0,14);
                                                return sub+"...";
                                            }
                                            return datas[i].roleRange
                                        }
                                }()+'</td>' +
                                '                        <td title='+datas[i].userRange+'>'+function(){
                                            if(datas[i].userRange==undefined){
                                                return ''
                                            }else{
                                                if(datas[i].userRange.length>15){
                                                    var sub=datas[i].userRange.substring(0,14);
                                                    return sub+"...";
                                                }
                                                return datas[i].userRange
                                            }
                                }()+'</td>' +
                                '                        <td>' +
                                '                            <a href="javascript:;" class="edit choose" data-type="1"><fmt:message code="global.lang.edit" /></a>' +
                                '                            <a href="javascript:;" class="import"><fmt:message code="workflow.th.Import" /></a>' +
                                '                            <a href="javascript:;" class="del"><fmt:message code="global.lang.delete" /></a>' +
                                '                            <a href="javascript:;" class="update"><fmt:message code="address.th.maintenancePermissions" /></a>' +
                                '                        </td>' +
                                '                    </tr>'
                        }
                        $('.list').html(str);
                        me.pageTwo(reg.totleNum,me.data.pageSize,me.data.page)
                    }
                })

            },
            pageTwo:function (totalData, pageSize,indexs) {
                var mes=this;
                $('#dbgz_page').pagination({
                    totalData: totalData,
                    showData: pageSize,
                    jump: true,
                    coping: true,
                    homePage:'',
                    endPage: '',
                    current:indexs||1,
                    callback: function (index) {
                        mes.data.page=index.getCurrent();
                        mes.page();
                    }
                });
            }
        }
        ajaxPageLe.page();

    <%--点击新建--%>
        $(document).on('click','.choose',function() {
            var type=$(this).attr('data-type');
            var me=$(this);
            var title='';
            if(type==0){
                title="<fmt:message code="user.th.NewPacket" />";
            }else{
                title="<fmt:message code="user.th.EditGroup" />";
            }
            layer.open({
                title: [title, 'background-color:#2b7fe0;color:#fff;'],
                area: ['600px', '400px'],
                type: 1,
                btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="depatement.th.quxiao" />'],
                content: '<form action="" id="ajaxdata">' +
                '<ul class="formUl" data-type="people">' +
                '<li class="clearfix" style="background: #00a0e9;margin-top: 12px;">' +
                '<input type="hidden" >' +
                '<input type="hidden" >' +
                '<li class="clearfix">' +
                '<label><fmt:message code="vote.th.SortNumber" /></label>' +
                '<input type="text" name="orderNo">' +
                '</li>' +
                '<li class="clearfix lessee">' +
                '<label><b>*</b> <fmt:message code="address.th.groupName" /></label>' +
                '<input type="text" name="groupName">' +
                '</li>' +
                '<li class="clearfix">' +
                '<label><fmt:message code="address.th.publicationScopeDepartment" /></label>' +
                '<input type="text"  id="dept" disabled>' +
                '<input type="hidden" name="privDept" id="depthid">' +
                '<a href="javascript:;"  style="margin-right:5px;margin-left:5px" class="dept"><fmt:message code="global.lang.select" /></a>' +
                '<a href="javascript:;" class="delDept"><fmt:message code="global.lang.empty" /></a>' +
                '</li>' +
                '<li class="clearfix">' +
                '<label><fmt:message code="address.th.publicationScopeRole" /></label>' +
                '<input type="text"  id="priv" disabled>' +
                '<input type="hidden" name="privRole" id="privhid">' +
                '<a href="javascript:;"  style="margin-right:5px;margin-left:5px" class="priv"><fmt:message code="global.lang.select" /></a>' +
                '<a href="javascript:;" class="delPriv"><fmt:message code="global.lang.empty" /></a>' +
                '</li>' +
                '<li class="clearfix">' +
                '<label><fmt:message code="address.th.publicationScopePersonnel" /></label>' +
                '<input type="text"  id="user" disabled>' +
                '<input type="hidden" name="privUser" id="userhid">' +
                '<a href="javascript:;"  style="margin-right:5px;margin-left:5px" class="user"><fmt:message code="global.lang.select" /></a>' +
                '<a href="javascript:;" class="delUser"><fmt:message code="global.lang.empty" /></a>' +
                '</li>' +
                '</ul>' +
                '</form>',
                yes: function () {
                    $('input[name="privDept"]').val($('#dept').attr('deptid'));
                    $('input[name="privRole"]').val($('#priv').attr('userpriv'));
                    $('input[name="privUser"]').val($('#user').attr('user_id'));
                    if(type==0){
                        $('#ajaxdata').ajaxSubmit({
                            type:'post',
                            dataType:'json',
                            success:function(res){
                                if(res.flag){
                                    $.layerMsg({content:'<fmt:message code="diary.th.modify" />',icon:1});
                                    window.location.reload()
                                    layer.closeAll();
                                }else{
                                    $.layerMsg({content:res.msg,icon:2});
                                }
                            }
                        })
                    }else{
                        var groupId=me.parents('tr').attr('id')
                        $('#ajaxdata').ajaxSubmit({
                            type:'post',
                            dataType:'json',
                            data:{groupId:groupId},
                            success:function(res){
                                if(res.flag){
                                    $.layerMsg({content:'<fmt:message code="diary.th.modify" />',icon:1});
                                    window.location.reload()
                                    layer.closeAll();
                                }else{
                                    $.layerMsg({content:res.msg,icon:2});
                                }
                            }
                        })
                    }

                },
                btn1: function (index) {
                    layer.close(index)
                },
                success: function () {
                    if(type==0){
                        $('#ajaxdata').attr('action','/addressGroup/addPublicGroup')
                    }else{
                        $('#ajaxdata').attr('action','/addressGroup/updatePublicGroup');
                        var groupId=me.parents('tr').attr('id');
                        $.ajax({
                            url:'/addressGroup/selectPublicGroupInfo',
                            data:{groupId:groupId},
                            type:'get',
                            dataType:'json',
                            success:function(res){
                                var data=res.object;
                                $('input[name="orderNo"]').val(data.orderNo);
                                $('input[name="groupName"]').val(data.groupName);
                                $('input[name="privDept "]').val(data.deptRange);
                                $('input[name="privRole"]').val(data.roleRange);
                                $('input[name="privUser"]').val(data.userRange);
                                $("#dept").val(data.deptRange); //部门
                                $("#dept").attr("deptid",data.privDept);
                                $("#priv").val(data.roleRange); //角色
                                $("#priv").attr("userpriv",data.privRole);
                                $("#user").val(data.userRange); //人员
                                $("#user").attr("user_id",data.privUser);
                            }
                        })
                    }
                    $(".user").on("click", function () {//选人员控件
                        user_id = 'user';
                        $.popWindow("../../common/selectUser");
                    });
                    $(".priv").on("click", function () {//选角色控件
                        priv_id = 'priv';
                        $.popWindow("../../common/selectPriv");
                    });
                    $(".dept").on("click", function () {//选部门控件
                        dept_id = 'dept';
                        $.popWindow("../../common/selectDept");
                    });
                    $('.delUser').on('click',function () { //清空人员
                        clearUser();
                    });
                    $('.delPriv').on('click',function () { //清空角色
                        clearRole();
                    });
                    $('.delDept').on('click',function () { //清空部门
                        clearDept();
                    });
                }

            })
        })
        function clearUser(){
            $('#user').attr('user_id', '');
            $('#user').attr('userprivname', '');
            $('#user').attr('username', '');
            $('#user').removeAttr('dataid');
            $('#user').val('');
        }
        function clearRole(){
            $('#priv').removeAttr('userpriv');
            $('#priv').removeAttr('privid');
            $('#priv').attr('dataid', '');
            $('#priv').val('');
        }
        function clearDept(){
            $('#dept').removeAttr('deptid');
            $('#dept').attr('deptno', '');
            $('#dept').removeAttr('deptname');
            $('#dept').val('');
        }
//        点击删除
        $('.list').on('click','.del',function(){
            var groupId=$(this).parents('tr').attr('id');
            layer.confirm(' 确定要删除吗', {
                btn: ['<fmt:message code="global.lang.ok" />', ' <fmt:message code="depatement.th.quxiao" />'],//按钮
                title: " <fmt:message code="global.lang.delete" />"
            },function(){
                $.ajax({
                    url:'/addressGroup/deleteGroups ',
                    type:'post',
                    dataType:'json',
                    data:{groupId:groupId},
                    success:function(){
                        $.layerMsg(' <fmt:message  code="workflow.th.delsucess"/>', {icon: 6});
                        window.location.reload();
                    }
                })
            }, function () {
                layer.closeAll();
            })
        })
        //点击维护权限 lr
        $(document).on('click','.update',function() {
            var groupId=$(this).parents('tr').attr('id');
            layer.open({
                title: ['<fmt:message code="address.th.permission" />', 'background-color:#2b7fe0;color:#fff;'],
                area: ['600px', '400px'],
                type: 1,
                btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="depatement.th.quxiao" />'],
                content: '<form action="" id="ajaxdata">' +
                '<ul class="formUl" data-type="people">' +
                '<li class="clearfix" style="background: #00a0e9;margin-top: 12px;">' +
                '<input type="hidden" >' +
                '<input type="hidden" >' +
                /*'<li class="clearfix">' +
                '<label>排序号</label>' +
                '<input type="text" name="orderNo">' +
                '</li>' +*/
                '<li class="clearfix lessee">' +
                '<label><b>*</b> <fmt:message code="address.th.groupName" /></label>' +
                '<input type="text" name="groupName" readonly>' +
                '</li>' +
                '<li class="clearfix">' +
                '<label><fmt:message code="address.th.maintenanceScopeDepartment" /></label>' +
                '<input type="text"  id="dept" disabled>' +
                '<input type="hidden" name="supportDept" id="depthid">' +
                '<a href="javascript:;"  style="margin-right:5px;margin-left:5px" class="dept"><fmt:message code="global.lang.select" /></a>' +
                '<a href="javascript:;" class="delDept"><fmt:message code="global.lang.empty" /></a>' +
                '</li>' +
                /*'<li class="clearfix">' +
                '<label>公布范围（角色）</label>' +
                '<input type="text"  id="priv" disabled>' +
                '<input type="hidden" name="privRole" id="privhid">' +
                '<a href="javascript:;"  style="margin-right:5px;margin-left:5px" class="priv">选择</a>' +
                '<a href="javascript:;" class="delPriv">清空</a>' +
                '</li>' +*/
                '<li class="clearfix">' +
                '<label><fmt:message code="address.th.maintenanceScopePersonnel" /></label>' +
                '<input type="text"  id="user" disabled>' +
                '<input type="hidden" name="supportUser" id="userhid">' +
                '<a href="javascript:;"  style="margin-right:5px;margin-left:5px" class="user"><fmt:message code="global.lang.select" /></a>' +
                '<a href="javascript:;" class="delUser"><fmt:message code="global.lang.empty" /></a>' +
                '</li>' +
                '</ul>' +
                '</form>',
                yes: function () {
                    $('input[name="supportDept"]').val($('#dept').attr('deptid'));
                    $('input[name="supportUser"]').val($('#user').attr('user_id'));
                        $('#ajaxdata').ajaxSubmit({
                            type:'post',
                            dataType:'json',
                            data:{"groupId":groupId},
                            success:function(res){
                                if(res.flag){
                                    $.layerMsg({content:'<fmt:message code="diary.th.modify" />',icon:1});
                                    window.location.reload()
                                    layer.closeAll();
                                }else{
                                    $.layerMsg({content:res.msg,icon:2});
                                }
                            }
                        })

                },
                btn1: function (index) {
                    layer.close(index)
                },
                success: function () {
                        $('#ajaxdata').attr('action','/addressGroup/stickPublicGroup')
                        $.ajax({
                            url:'/addressGroup/selectPublicGroupInfo',
                            data:{"groupId":groupId},
                            type:'get',
                            dataType:'json',
                            success:function(res){
                                var data=res.object;
                                $('input[name="groupName"]').val(data.groupName);
                                $("#dept").val(data.supportDeptName); //部门
                                $("#dept").attr("deptid",data.supportDept);
                               /* $("#priv").val(data.roleRange); //角色
                                $("#priv").attr("userpriv",data.privRole);*/
                                $("#user").val(data.supportUserName); //人员
                                $("#user").attr("user_id",data.supportUser);
                            }
                        })
                    $(".user").on("click", function () {//选人员控件
                        user_id = 'user';
                        $.popWindow("../../common/selectUser");
                    });
                    $(".priv").on("click", function () {//选角色控件
                        priv_id = 'priv';
                        $.popWindow("../../common/selectPriv");
                    });
                    $(".dept").on("click", function () {//选部门控件
                        dept_id = 'dept';
                        $.popWindow("../../common/selectDept");
                    });
                    $('.delUser').on('click',function () { //清空人员
                        clearUser();
                    });
                    $('.delPriv').on('click',function () { //清空角色
                        clearRole();
                    });
                    $('.delDept').on('click',function () { //清空部门
                        clearDept();
                    });
                }

            })
        })
//        点击导入
          $('.list').on('click','.import',function(){
              var groupId=$(this).parents('tr').attr('id');
              layer.open({
                  type:1,
                  title: ['<fmt:message code="address.th.groupImport" />', 'background-color:#2b7fe0;color:#fff;'],
                  area: ['600px', '420px'],
                  btn: ['<fmt:message code="workflow.th.Import" />', '<fmt:message code="depatement.th.quxiao" />'],
                  content:'<div>' +
                  '<form class="form1" name="form1" id="uploadForm" method="post" action="/address/importPublicAddressWithBLOBs?groupId="'+groupId+' enctype="multipart/form-data">' +
                  '<table class="importTable" style="margin-top:20px;">' +
                  '<tr><td style="width: 100px;"><fmt:message code="hr.th.DownloadImportTemplates" />：</td><td style="text-align: left;"><a id="model"><fmt:message code="address.th.downloadOfTheGroupManagementInformationTemplate" /></a></td></tr>' +
                  '<tr> <td><fmt:message code="hr.th.SelectImportfile" />：</td> <td><input style="width: auto" type="file" name="file"/><input type="hidden" name="groupId" id="groupId" value="'+groupId+'"/></td> </tr>' +
                  '<tr>' +
                  '<td><fmt:message code="hr.th.Explain" />：</td>'+
                  '<td style="text-align: left;"><p>1、<fmt:message code="hr.th.Import.XlsFile" />。</p>'+
//                  '<p>2、请填写网格信息中已有网格。</p>'+
                  '</td> ' +

                  '</tr>' +
                  '</table>' +
                  '</form>' +
                  '</div>',
                  success:function(){
                      $('#model').on('click',function () {
                          window.location.href = encodeURI("/file/address/<fmt:message code="address.th.publicAddress" />.xls");
                      });
                  },
                  yes:function(){
                      var flag = CheckForm();
                      if (flag) {
                          layer.msg("<fmt:message code="down.th.2" />", {icon: 1});
                          $.upload($('#uploadForm'), function (res) {
                              if (res.flag) {
                                  layer.msg("<fmt:message code="down.th.3" />" + res.totleNum +"<fmt:message code="sys.th.date2" />!", {icon: 1});
                              } else {
                                  layer.msg(res.msg, {icon: 2});
                              }
                          });
                      }
                  }
              })
          })




        function CheckForm() {
            if (document.form1.file.value == "") {
                layer.msg("<fmt:message code="user.th.selectImport" />！", {icon: 2});
                return (false);
            }

            return (true);
        }





    </script>
</body>
</html>
