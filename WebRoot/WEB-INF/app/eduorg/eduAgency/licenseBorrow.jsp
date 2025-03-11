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
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>证照借阅</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.config.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js?20201221.1" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js?20201221.1" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
</head>
<style>


    #box .layui-from {
        width: 100%;
    }
    .layui-table-page>div{
        float: right;
    }
    .layui-table-body{overflow-x: hidden;}
    #box .layui-table {
        width: 90%;
        margin: 0 auto;
    }

    .asd {
        font-weight: bold;
        font-size: 18px;
        margin-left: 30px;
    }

    .zxc {
        font-weight: bold;
        font-size: 18px;
        margin-left: 30px;
    }

    .evaluation span {
        font-weight: bold;
        font-size: 18px;
        margin-left: 55px;
    }

    /*#box th {*/
    /*    text-align: center;*/
    /*}*/

    /*#box tr {*/
    /*    height: 40px;*/
    /*}*/

    #box button {
        right: -14px;
        z-index: 999;
        top:77px
    }
    #btn{
        margin-right: 35px;
        position: absolute;
        right: 30px;
        z-index: 999;
        top:77px
    }
    #from {
        width: 100%;
        margin: 0 auto;
        padding-top: 20px;
    }

    #from .new {
        font-weight: bold;
        font-size: 18px;
        margin-left: 30px;
    }

    .people {
        width: 100%;
        overflow: hidden;
        margin-bottom: 15px;
    }

    .people1 {
        width: 44%;
        float: left;
        overflow: hidden;
    }

    .people2 {
        float: right;
        overflow: hidden;
        margin-right: 61px;
    }

    .tbtn {
        text-align: center;
    }

    .tbtn button {
        margin-bottom: 20px;
        width: 100px;
    }

    .annex {
        font-size: 14px;
        margin-left: 30px;
    }

    #test3 {
        margin-left: 68px;
    }

    .layui-form-label {
        width: 100px;
    }

    .layui-table-view .layui-form-checkbox[lay-skin=primary] i {
        margin-top: 5px;
    }

    .layui-form {
        margin-left: 10px;
        margin-top: 35px;
        display: block;
        margin-right: 10px;
    }

    .layui-table-cell laytable-cell-1-0-5 {
        width: 268px;
    }

    /*.layui-table-page{*/
    /*    width: 1054px;*/
    /*}*/
    .layui-laypage-btn{
        display: none;
    }
    .layui-box layui-laypage layui-laypage-default{
        margin-left: 1060px;
    }
    .thHeight1 td {
        height: 80px;
    }

    .thHeight2 td {
        height: 120px;
        letter-spacing: 7px;
    }

    .layui-form input[type=checkbox], .layui-form input[type=radio], .layui-form select {
    }

    .layui-form select {

    }
    a {
        cursor: hand;
    }

    .evaluation {
        width: 800px;
        padding-top: 10px;
    }

    tr {
        text-align: center;
    }

    td {
        text-align: center;
    }

    #asd {
        width: 10px;
    }

    .layui-table td, .layui-table th {
        padding: 10px 9px;
    }

    .layui-form-checkbox {
        display: none;
    }

    .layui-table-view .layui-table td, .layui-table-view .layui-table th {
        text-align: center;
    }

    .layui-table-tool {
        display: none;
    }
    .layui-unselect{
        width: 300px;
    }
    .layui-input{
        width: 300px;
    }
    .box1 {
        overflow: hidden;
        margin-left: 55px;
        margin-bottom: 50px;
    }

    .top1 {
        width: 199px;
        height: 39px;
        background-color: rgb(204 204 204);
        display: block;
        font-weight: bold;
        font-size: 18px;
        float: left;
        text-align: center;
        line-height: 39px;
        border: 1px solid rgba(121, 121, 121, 1);
    }

    .top2 {
        width: 228px;
        height: 39px;
        background-color: rgba(121, 121, 121, 1);
        display: block;
        font-weight: bold;
        font-size: 18px;
        float: left;
        text-align: center;
        line-height: 39px;
    }

    #meeting {
        width: 84px;
    }

    #textarea {
        width: 73%;
        height: 100px;
    }

    #party {
        float: right;
        position: absolute;
        left: 1000px;
        top: 75px;
    }

    #year {
        float: right;
        position: absolute;
        left: 1320px;
        top: 75px;
    }
    .layui-tab-content{
        margin-top: 20px;
    }
    .laytable-cell-1-0-6{
        maxWidth: 220px;

    }
    .niuma{
        width: 1000px;
        position: relative;
    }
</style>
<body>
<div id="box" style="display: block">




    <div class="box2">


    </div>
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <ul class="layui-tab-title">
            <li class="layui-this" id="shan1">我的借阅</li>
            <li id="shan2">证照借阅 </li>
        </ul>
        <div class="layui-tab-content">

            <div class="layui-tab-item layui-show ">

                <div>
                    <span class="zxc">我的借阅</span>
                </div>
                <form class="layui-form" action="">
                    <div>
                        <div class="layui-inline">
                            <label class="layui-form-label">借阅标题</label>
                            <div class="layui-input-inline">
                                <input  style="width: 200px" id="borrowSubject1" name="borrowSubject1" class="layui-input" type="text">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <label class="layui-form-label">借阅时间</label>
                            <div class="layui-input-inline">
                                <input  style="width: 200px" id="borrowTime1" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" name="borrowTime1" class="layui-input" type="text">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <label class="layui-form-label" >审批状态</label>
                            <div class="layui-input-inline">
                                <select id="approveStatus1"  name="approveStatus1" lay-verify="orgDeptId">
                                    <option value="" class="layui-this">请选择</option>
                                    <option value="3">未提交</option>
                                    <option value="0">待审批</option>
                                    <option value="1">同意</option>
                                    <option value="2">不同意</option>

                                </select>
                            </div>
                        </div>
                        &nbsp&nbsp&nbsp&nbsp&nbsp
                        <button type="button" class="layui-btn layui-btn-sm" id="search" lay-event="search" style="height: 30px;line-height: 30px;">查询</button>
                    </div>


                </form>

                <table class="layui-hide" id="test1" lay-filter="test1"></table>
            </div>



            <div class="layui-tab-item two">
                <span class="asd">证照借阅</span>
                <div>
                    <form class="layui-form" action="">
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">申请人</label>
                            <div class="layui-input-inline" style="display: flex" >
                                <input id="applicant" disabled="disabled" name="applicant" class="layui-input" type="text">
                                <div style="width: 30px;line-height: 40px;">
                                    <span style="color: red;margin-left: 10px;font-size: 25px">*</span>
                                    <input type="hidden" name="userId">
                                </div>
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 7%">
                            <label class="layui-form-label">申请人所在部门</label>
                            <div class="layui-input-inline" style="display: flex">
                                <input id="applicanDept" disabled="disabled" name="applicanDept" class="layui-input" type="text">
                                <div style="width: 30px;line-height: 40px;">
                                    <span style="color: red;margin-left: 10px;font-size: 25px">*</span>
                                    <input type="hidden" name="userId">
                                </div>
                            </div>
                        </div>
                    </form></div>
                <div>

                    <form class="layui-form" action="" style="display: flex;height: 40px;">
                        <div class="layui-form-item" style="margin-left: 5%">
                                   <label class="layui-form-label" >借阅机构</label>
                                   <div class="layui-input-block" style="width: 430px">
                                            <input type="text" disabled="disabled"  lay-filter="borrowOragn" name="borrowOragn" id="borrowOragn" style="display: inline-block;width: 300px"  lay-verify="borrowOragn" autocomplete="off" placeholder="" class="layui-input borrowOragn">
                                       <span style="color: red;margin-left: 10px;font-size: 25px">*</span><a class="deptAdd" style="display: inline-block;">添加</a>&nbsp&nbsp<a class="deptClear" style="display: inline-block">清空</a>
                                     </div>
                              </div>
                        <div class="layui-form-item" style="display:flex; margin-left: 1%">
                            <label class="layui-form-label" >借阅证照</label>
                            <div class="layui-input-inline"  style="display: flex">
                                <select id="licenceId" name="licenceId" class="licenceId" lay-verify="licenceId" lay-filter="licenceId">
                                    <option value="">请选择</option>
                                </select>
                            </div>
                        </div>
                        <a id="pics" style="line-height: 40px;
    margin-left: 100px;"><span style="color: red;margin-left: 10px;font-size: 25px">*</span>
                            刷新借阅证照
                        </a>
                    </form></div>
                <div>
                    <form class="layui-form" style="display: flex;height: 40px;" action="">
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">借阅时间</label>
                            <div class="layui-input-inline" style="display: flex">
                                <input id="borrowTime" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" name="borrowTime" class="layui-input" type="text">
                                <div style="width: 30px;line-height: 40px;">
                                    <span style="color: red;margin-left: 10px;font-size: 25px">*</span>
                                    <input type="hidden" name="userId">
                                </div>
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 7%">
                            <label class="layui-form-label">计划归还时间</label>
                            <div class="layui-input-inline" style="display: flex">
                                <input id="returnTime" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" name="returnTime" class="layui-input" type="text">
                                <div style="width: 30px;line-height: 40px;">
                                    <span style="color: red;margin-left: 10px;font-size: 25px">*</span>
                                    <input type="hidden" name="userId">
                                </div>
                            </div>
                        </div>
                    </form></div>
                <div>
                    <form class="layui-form"  action="">
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">借阅标题</label>
                            <div class="layui-input-inline" style="display: flex" >
                                <input id="borrowSubject" name="borrowSubject" class="layui-input" type="text">
                                <div style="width: 30px;line-height: 40px;">
                                    <span style="color: red;margin-left: 10px;font-size: 25px">*</span>
                                    <input type="hidden" name="userId">
                                </div>
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 7%">
                            <label class="layui-form-label">审核人</label>
                            <div class="layui-input-inline" style="display: flex">
                                <input id="approver" disabled="disabled" name="approver" class="layui-input" type="text">
                                <div style="width: 30px;line-height: 40px;">
                                    <span style="color: red;margin-left: 10px;font-size: 25px">*</span>
                                    <input type="hidden" name="userId">
                                </div>
                                <div style="width: 70px;line-height: 35px;">
                                    <a href="javascript:;" class="addControls" data-type="3">添加</a>
                                    <a href="javascript:;" class="cleardate">清空</a>
                                    <input type="hidden" name="userId">
                                </div>
                            </div>
                        </div>
                    </form></div>
                <div>
                    <form class="layui-form" action="">
                        <label class="layui-form-label" style="margin-left: 5%">借阅理由</label>
                        <div class="layui-input-block" style="display: flex">
                            <textarea id="borrowReason" name="borrowReason" class="layui-textarea"  style="width:60%"></textarea>
                            <div style="width: 30px;line-height: 40px;">
                                <span style="color: red;margin-left: 10px;font-size: 25px">*</span>
                                <input type="hidden" name="userId">
                            </div>
                        </div>
                    </form></div>
                <div style="margin-top: 30px;text-align: center">
                    <button class="layui-btn" id="submit" type="button">提交审批</button>&nbsp&nbsp&nbsp&nbsp&nbsp
                    <button class="layui-btn" id="save" type="button">保存</button>&nbsp&nbsp&nbsp&nbsp&nbsp
<%--                    <button class="layui-btn" id="return" type="button">返回</button>--%>
                </div>
            </div>
        </div>
    </div>

</div>


</table>
<script id="barDemos" type="text/html">
    {{#  if(d.approveStatus == '未提交'  ||  d.approveStatus == ''){ }}
        <a class="NONE" id="detail1"  lay-event="detail1"  style="color: blue;cursor:pointer; text-decoration:underline">提交审批</a>
        <a id="detail11" lay-event="detail11" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">查看</a>
        <a id="detail2" lay-event="detail2" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">编辑</a>
        <a id="detail3" lay-event="detail3"  data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">删除</a>
    {{#  }else if(d.approveStatus == '待审批'){ }}
        <a id="detail4" lay-event="detail4"  data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">查看</a>
    {{#  }else if(d.approveStatus == '同意'){ }}
    <a id="detail4" lay-event="detail4"  data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">查看</a>
    {{#  }else if(d.approveStatus == '不同意'){ }}
    <a id="detail4" lay-event="detail4"  data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">查看</a>
    {{#  } }}
</script>

</body>
<script>
    var c=''
    var b=''
    var a=''


    $(".deptAdd").on("click",function(){
        priv_id="borrowOragn";
        $.popWindow("../EduorgMessage/selectOrg?0");
    });
    // 清空部门信息
    $('.deptClear').click(function () {
        $('#borrowOragn').attr("privid","");
        $('#borrowOragn').attr("userpriv","");
        $('#borrowOragn').val("");
    });

    var borrowOragn= $('#borrowOragn').attr('priv_id');


    $('.addControls').click(function () {
        var type=$(this).attr('data-type');
          if(type==3){
            user_id = "approver";
            $.ajax({
                url:'/imfriends/getIsFriends',
                type:'get',
                dataType:'json',
                data:{},
                success:function(obj){
                    if(obj.object == 1){
                        $.popWindow("../common/selectUserIMAddGroup?0");

                    }else{
                        $.popWindow("../common/selectUser?0");
                    }
                },
                error:function(res){
                    $.popWindow("../common/selectUser?0");
                }
            })

        }
    });
    // 清空角色信息
    $('.cleardate').click(function () {
        $('#approver').attr("dataid","");
        $('#approver').attr("user_id","");
        $('#approver').val("");
    });






    layui.use(['form', 'table', 'element', 'layedit','eleTree'], function () {
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var layedit = layui.layedit
        var eleTree = layui.eleTree;
        form.render()

    $('#pics').click(function () {
        var deptName=$('#borrowOragn').val();
        var orgId = $('#borrowOragn').attr('privid');
        $.ajax({
            url:'/EduorgBorrow/selectByOrgId?orgId='+orgId,
            type:'post',
            dataType:'json',
            data:{
            },
            success:function(res){

                var arr=[];
                var str
                for(var i=0;i<res.obj.length;i++){

                    // arr1=res.obj[i].orgFullname;
                    str+='<option value="'+res.obj[i].licenceId+'">'+res.obj[i].licenceName+'</option>'
                    // arr.push(arr1);
                }

                $('select[name="licenceId"]').append(str);
                form.render('select');
                return false;
            }
        })
    })
        form.render();
    // $.ajax({
    //     url:'/EduorgBorrow/selectAll',
    //     type:'post',
    //     dataType:'json',
    //     async:false,
    //     data:{
    //     },
    //     success:function(obj){
    //         for (var i = 0; i <obj.obj.length; i++) {
    //             if(obj.obj[i].approveStatus=="待审批"){
    //                 $('.long').hide();
    //             }
    //         }
    //
    //
    //     }
    // })

    $(document).on("click",function() {
        $(".ele2").slideUp();
    })
    //节点点击事件
    layui.eleTree.on("nodeClick(data2)",function(d) {
        var parData1 = d.data.currentData;
        $("[name='orgDeptId']").val(parData1.deptName);
        $("#orgDeptName").attr("pid",parData1.deptId);
    })


    $('#submit').click(function () {
        if ($("#applicant").val()==''||$("#applicant").val()==undefined){
            layer.msg('申请人不能为空！',{icon:0});
            return false;
        }
        if ($("#applicanDept").val()==''||$("#applicanDept").val()==undefined){
            layer.msg('申请人所在部门不能为空！',{icon:0});
            return false;
        }
        if ($("#borrowOragn").val()==''||$("#borrowOragn").val()==undefined){
            layer.msg('请选择借阅机构！',{icon:0});
            return false;
        }
        if ($("#licenceId").val()==''||$("#licenceId").val()==undefined){
            layer.msg('请选择借阅证照！',{icon:0});
            return false;
        }
        if ($("#borrowTime").val()==''||$("#borrowTime").val()==undefined){
            layer.msg('请选择借阅时间！',{icon:0});
            return false;
        }
        if ($("#returnTime").val()==''||$("#returnTime").val()==undefined){
            layer.msg('请选择计划归还时间！',{icon:0});
            return false;
        }
        if ($("#borrowSubject").val()==''||$("#borrowSubject").val()==undefined){
            layer.msg('请选择借阅标题！',{icon:0});
            return false;
        }
        if ($("#approver").val()==''||$("#approver").val()==undefined){
            layer.msg('请选择审核人！',{icon:0});
            return false;
        }
        if ($("#borrowReason").val()==''||$("#borrowReason").val()==undefined){
            layer.msg('请选择借阅理由！',{icon:0});
            return false;
        }
        var approveStatus='0'
        // var approveStatus1=''
        // if(approveStatus=='0'){
        //     approveStatus1="待审批"
        // }else if(approveStatus=='1'){
        //     approveStatus1="同意"
        // }else if(approveStatus=='2'){
        //     approveStatus1="不同意"
        // }
        b= $('#approver').attr('user_id')
        $.ajax({
            type: 'post',
            url: '/EduorgBorrow/insert',
            dataType: 'json',
            data: {
                borrowTime: $("#borrowTime").val(),
                returnTime: $("#returnTime").val(),
                applicantId: c,
                approverId: b,
                applicant: $("#applicant").val(),
                borrowReason: $("#borrowReason").val(),
                borrowOragn: $("#borrowOragn").val(),
                applicanDept: $("#applicanDept").val(),
                approver: $("#approver").val(),
                licenceId: $("#licenceId").val(),
                borrowSubject: $("#borrowSubject").val(),
                approveStatus: approveStatus

            },
            success: function (json) {
                if(json.flag){
                    layer.msg('提交成功！',{icon:1},function () {
                        location.reload();
                    });
                }else{
                    layer.msg('提交失败！',{icon:2});
                }
            }
        })

    })



    $('#save').click(function () {
        if ($("#applicant").val()==''||$("#applicant").val()==undefined){
            layer.msg('申请人不能为空！',{icon:0});
            return false;
        }
        if ($("#applicanDept").val()==''||$("#applicanDept").val()==undefined){
            layer.msg('申请人所在部门不能为空！',{icon:0});
            return false;
        }
        if ($("#borrowOragn").val()==''||$("#borrowOragn").val()==undefined){
            layer.msg('请选择借阅机构！',{icon:0});
            return false;
        }
        if ($("#licenceId").val()==''||$("#licenceId").val()==undefined){
            layer.msg('请选择借阅证照！',{icon:0});
            return false;
        }
        if ($("#borrowTime").val()==''||$("#borrowTime").val()==undefined){
            layer.msg('请选择借阅时间！',{icon:0});
            return false;
        }
        if ($("#returnTime").val()==''||$("#returnTime").val()==undefined){
            layer.msg('请选择计划归还时间！',{icon:0});
            return false;
        }
        if ($("#borrowSubject").val()==''||$("#borrowSubject").val()==undefined){
            layer.msg('请选择借阅标题！',{icon:0});
            return false;
        }
        if ($("#approver").val()==''||$("#approver").val()==undefined){
            layer.msg('请选择审核人！',{icon:0});
            return false;
        }
        if ($("#borrowReason").val()==''||$("#borrowReason").val()==undefined){
            layer.msg('请选择借阅理由！',{icon:0});
            return false;
        }
        var approveStatus1='3'
        // if(approveStatus=='0'){
        //     approveStatus1="待审批"
        // }else if(approveStatus=='1'){
        //     approveStatus1="同意"
        // }else if(approveStatus=='2'){
        //     approveStatus1="不同意"
        // }
        b= $('#approver').attr('user_id');
        $.ajax({
            type: 'post',
            url: '/EduorgBorrow/insert',
            dataType: 'json',
            data: {
                orgId:borrowOragn,
                borrowTime: $("#borrowTime").val(),
                returnTime: $("#returnTime").val(),
                applicant: $("#applicant").val(),
                borrowReason: $("#borrowReason").val(),
                borrowOragn: $("#borrowOragn").val(),
                applicanDept: $("#applicanDept").val(),
                approver: $("#approver").val(),
                approverId: b,
                applicantId: c,
                licenceId: $("#licenceId").val(),
                borrowSubject: $("#borrowSubject").val(),
                approveStatus: approveStatus1,


            },
            success: function (json) {
                if(json.flag){
                    layer.msg('保存成功！',{icon:1},function () {
                        location.reload();
                    });
                }else{
                    layer.msg('保存失败！',{icon:2});
                }
            }
        })
    })

    $('#search').click(function () {
        var approveStatus = $("#approveStatus1").val()
        var borrowTime = $("#borrowTime1").val()
        var borrowSubject = $("#borrowSubject1").val()
        table.render({
            elem: '#test1'
            , url:'/EduorgBorrow/selectAll?pageSize='+'10'+'&useflag=true&borrowSubject='+borrowSubject+'&borrowTime='+borrowTime+'&approveStatus='+approveStatus
            , page: true
            ,cols:[[
                {field: 'borrowSubject', title: '借阅标题',  }
                , {field: 'borrowReason', title: '借阅理由',}
                , {field: 'returnTime', title: '借阅到期时间',}
                , {field: 'approver', title: '审批人', }
                , {field: 'approveStatus', title: '审批状态',}
                , {field: 'approverComment', title: '审批人意见', },
                {field: 'submitterName', title: '附件', templet: function (d) {
                        var strr = ''
                        var object=d
                        if(d.attUrl==undefined){
                            return ''
                        }else{
                            for(var i=0;i<object.attUrl.length;i++){
                                var str1 = ""
                                if( object.attUrl[i].attUrl != undefined ){
                                    str1 = '' +
                                        '<div class="dech" deurl="' +object.attUrl[i].attUrl + '">' +
                                        '<a href="/download?' + object.attUrl[i].attUrl + '" name="'+object.attUrl[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                        '<img src="/img/attachment_icon.png">' + object.attUrl[i].attachName + '</a>' +
                                        '' +
                                        '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png">' +
                                        '<input type="hidden" class="inHidden" value="' + object.attUrl[i].aid + '@' + object.attUrl[i].ym + '_' + object.attUrl[i].attachId +',">' +
                                        '<a onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                        '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                        '<a style="padding-left: 5px" href="/download?' + object.attUrl[i].attUrl + '">' +
                                        '<img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">下载</a>\n' +
                                        '</div>' +
                                        '</div>'
                                }else{
                                    str1 = '';
                                }
                                strr += str1;
                            }
                            return str1
                        }
                    }},
                {title:'操作',toolbar:'#barDemos',width:'15%',minWidth:200,align:'center'},
            ]]
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code":0,
                    "count":res.totleNum,
                    "data": res.obj //解析数据列表
                };
            }
        });
    });

    table.render({
        elem: '#test1'
        , url: '/EduorgBorrow/selectAll?pageSize='+'10'+'&useflag='+true
        , toolbar: '#barDemos' //开启头部工具栏，并为其绑定左侧模板
        , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            title: '提示'
            , layEvent: 'LAYTABLE_TIPS'
            , icon: 'layui-icon-tips'
        }]
        , title: '用户数据表'
        , cols: [[
            // , {field: 'id', title: 'ID', width: 80, fixed: 'left', unresize: true, sort: true}
            {field: 'borrowSubject', title: '借阅标题',  }
            , {field: 'borrowReason', title: '借阅理由',}
            , {field: 'returnTime', title: '借阅到期时间',}
            , {field: 'approver', title: '审批人', }
            , {field: 'approveStatus', title: '审批状态',}
            , {field: 'approverComment', title: '审批人意见', }
            , {field: 'submitterName', title: '附件', templet: function (d) {
                        var strr = ''
                        var object=d
                    if(d.attUrl==undefined){
                        return ''
                    }else{
                        for(var i=0;i<object.attUrl.length;i++){
                            var str1 = ""
                            if( object.attUrl[i].attUrl != undefined ){
                                str1 = '' +
                                    '<div class="dech" deurl="' +object.attUrl[i].attUrl + '">' +
                                    '<a href="/download?' + object.attUrl[i].attUrl + '" name="'+object.attUrl[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                    '<img src="/img/attachment_icon.png">' + object.attUrl[i].attachName + '</a>' +
                                    '' +
                                    '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png">' +
                                    '<input type="hidden" class="inHidden" value="' + object.attUrl[i].aid + '@' + object.attUrl[i].ym + '_' + object.attUrl[i].attachId +',">' +
                                    '<a onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                    '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                    '<a style="padding-left: 5px" href="/download?' + object.attUrl[i].attUrl + '">' +
                                    '<img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">下载</a>\n' +
                                    '</div>' +
                                    '</div>'
                            }else{
                                str1 = '';
                            }
                            strr += str1;
                        }
                    return str1
                    }
                }}
            , {field: '', title: '操作',width:'15%', toolbar: '#barDemos',}
        ]]
        , parseData: function (res) { //res 即为原始返回的数据
            return {
                "code": 0, //解析接口状态
                "msg": res.msg, //解析提示文本
                "count": res.totleNum, //解析数据长度
                "data": res.obj, //解析数据列表
            };
        }
        , page: true
    })
    var applicanDept1=''

    $('#shan2').click(function () {
        $.ajax({
            url:'/EduorgBorrow/selectUser',
            type:'post',
            dataType:'json',
            data:{
            },
            success:function(obj){
                $('#applicant').val(obj.object.userName);
                $('#applicanDept').val(obj.object.deptName);
                 c =obj.object.userId;
                applicanDept1=obj.object.deptName;
            }
        })


    })

    table.on('tool(test1)', function (obj) {

        data = obj.data;
        var data = obj.data;
        var dataObj = obj.data;
        var layEvent = obj.event;
        if (obj.event === 'detail1') {
            layer.confirm('确定提交该条数据吗？', {
                btn: ['确定','取消'], //按钮
                title:"提交审批"
            }, function() {
                $.ajax({
                    type: 'post',
                    url: '/EduorgBorrow/update',
                    dataType: 'json',
                    data: {
                        approveStatus: '待审批',
                        borrowId: data.borrowId
                    },
                    success: function (json) {
                        data.approveStatus = '待审批'
                        $.layerMsg({content: '提交成功！', icon: 1}, function () {
                            location.reload();
                        })
                    }
                })
            })
        }else if (obj.event === 'detail11') {
            layer.open({
                type: 1
                , title: '查看'
                , area: ['80%', '90%'],
                content: '<div class="layui-tab-item layui-show">\n' +
                    '                <div>\n' +
                    '                    <form class="layui-form" action="">\n' +
                    '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                    '                            <label class="layui-form-label">借阅机构</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input id="borrowOragn4" disabled="disabled" name="borrowOragn4" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                        <div class="layui-inline" style="margin-left: 10%">\n' +
                    '                            <label class="layui-form-label">借阅证件</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input id="licenceId4" disabled="disabled" name="licenceId4" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </form></div>\n' +
                    '                <div>\n' +
                    '                    <form class="layui-form" action="">\n' +
                    '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                    '                            <label class="layui-form-label">借阅时间</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input id="borrowTime4" disabled="disabled" name="borrowTime4" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                        <div class="layui-inline" style="margin-left: 10%">\n' +
                    '                            <label class="layui-form-label">计划归还时间</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input id="returnTime4" disabled="disabled" name="returnTime4" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </form></div>\n' +
                    '                <div>\n' +
                    '                    <form class="layui-form" action="">\n' +
                    '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                    '                            <label class="layui-form-label">申请人</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input id="applicant4" disabled="disabled" name="applicant4" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                        <div class="layui-inline" style="margin-left: 10%">\n' +
                    '                            <label class="layui-form-label">申请人所在部门</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input id="applicanDept4" disabled="disabled" name="applicanDept4" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </form></div>\n' +
                    '                <div>\n' +
                    '                    <form class="layui-form" action="">\n' +
                    '                        <label class="layui-form-label" style="margin-left: 5%">借阅理由</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <textarea id="borrowReason4" name="borrowReason4" class="layui-textarea" disabled="disabled" style="width:500px"></textarea>\n' +
                    '                        </div>\n' +
                    '                    </form></div>\n' +
                    '                <div style="margin-top: 30px;text-align: center">\n' +
                    '                    <button class="layui-btn" id="return" type="button">返回</button>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-tab-item two">\n' +
                    '                <div>\n' +
                    '                    <span class="zxc">我的借阅</span>\n' +
                    '                </div>\n' +
                    '                <form class="layui-form" action="">\n' +
                    '                    <div>\n' +
                    '                        <div class="layui-inline">\n' +
                    '                            <label class="layui-form-label">借阅标题</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input  style="width: 200px" id="lendtitle" name="lendtitle" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '\n' +
                    '                        <div class="layui-inline">\n' +
                    '                            <label class="layui-form-label">借阅时间</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input  style="width: 200px" id="borrowTime" name="borrowTime" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '\n' +
                    '                        <div class="layui-inline">\n' +
                    '                            <label class="layui-form-label" >审批状态</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <select  style="width: 200px" id="approveStatus" name="approveStatus" lay-verify="orgDeptId">\n' +
                    '                                    <option value="" class="layui-this">请选择</option>\n' +
                    '                                </select>\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                        &nbsp&nbsp&nbsp&nbsp&nbsp\n' +
                    '                        <button type="button" class="layui-btn layui-btn-sm" id="search" lay-event="search" style="height: 30px;line-height: 30px;">查询</button>\n' +
                    '                    </div>\n' +
                    '\n' +
                    '\n' +
                    '                </form>\n' +
                    '\n' +
                    '                <table class="layui-hide" id="test1" lay-filter="test1"></table>\n' +
                    '            </div>\n' +
                    '        </div>'
                ,
                success: function () {
                    $("#return").click(function() {
                        layer.closeAll();
                    })
                    form.render()
                    $.ajax({
                        type: 'post',
                        url: '/EduorgBorrow/selectById',
                        dataType: 'json',
                        data:{
                            borrowId:data.borrowId
                        },
                        success: function (json) {
                            if(json.flag){
                                $('#returnTime4').val(json.object.returnTime);
                                $('#applicant4').val(json.object.applicant);
                                $('#borrowTime4').val(json.object.borrowTime);
                                $('#borrowReason4').val(json.object.borrowReason);
                                $('#approver').val(json.object.approver);
                                $('#applicanDept4').val(json.object.applicanDept);
                                $('#borrowOragn4').val(json.object.borrowOragn);
                                $('#licenceId4').val(json.object.licenceName);
                                $('#borrowSubject').val(json.object.borrowSubject);
                                form.render();
                            }
                        }
                    })
                },

            })
        }else if(obj.event == 'detail2'){
            layer.open({
                type: 1 //此处以iframe举例
                , title: '编辑'
                , area: ['80%', '90%'],
                offset:'20',
                btn: ['确定', '取消'],
                content: '' +
                    '                <div>\n' +
                    '                    <form class="layui-form" action="">\n' +
                    '                        <div class="layui-inline" >\n' +
                    '                            <label class="layui-form-label">申请人</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input id="applicant1" disabled="disabled" style="width: 300px" name="applicant1" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                       <div class="layui-inline" >\n' +
                    '                            <label class="layui-form-label">申请人所在部门</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input id="applicanDept2" disabled="disabled" style="width: 300px" name="applicanDept2" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </form></div>\n' +
                    '<div><form class="layui-form" action="" style="display: flex;height: 40;">\n' +
                    '                                      <div class="layui-form-item">\n' +
                    '        <label class="layui-form-label">借阅机构</label>\n' +
                    '        <div class="layui-input-block" style="width: 350px">\n' +
                    '            <input type="text" disabled="disabled" name="borrowOragn2" id="borrowOragn2" style="display: inline-block;width: 300px"  lay-verify="borrowOragn" autocomplete="off" placeholder="" class="layui-input">\n' +
                    '            <div><a class="deptAdds" style="display: inline-block;    margin-left: 20px;">添加</a>&nbsp&nbsp<a class="deptClears" style="display: inline-block">清空</a></div>\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '                                        <div class="layui-form-item" >\n' +
                    '                                            <div class="layui-inline" >\n' +
                    '                                                <label class="layui-form-label" style="width: 80px" >借阅证照</label>\n' +
                    '                                                <div class="layui-input-inline">\n' +
                    '                                                    <select  id="licenceId1" name="licenceId1" class="deptAvenue noEdit" lay-verify="licenceId1" lay-filter="deptAvenue">\n' +
                    '                                                        <option value="">请选择</option>\n' +
                    '                                                    </select>\n' +
                    '<a id="pics1"  style="display: inline-block;margin-left: 20px;">刷新借阅证照</a>' +
                    '                                                </div>\n' +
                    '                                            </div>\n' +
                    '                                        </div>\n' +

                    '                    </form></div>\n' +
                    '                <div>\n' +
                    '                    <form class="layui-form" action="">\n' +
                    '                        <div class="layui-inline" >\n' +
                    '                            <label class="layui-form-label">借阅时间</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input id="borrowTime2" style="width: 300px" onclick="laydate({istime: true, format: \'YYYY-MM-DD\'})" name="borrowTime2" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                        <div class="layui-inline">\n' +
                    '                            <label class="layui-form-label">计划归还时间</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input id="returnTime1" style="width: 300px;margin-left:3%" onclick="laydate({istime: true, format: \'YYYY-MM-DD\'})" name="returnTime1" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </form></div>\n' +
                    '                <div>\n' +
                    '                    <form class="layui-form" action="">' +
                    '<div class="layui-inline">\n' +
                    '                            <label class="layui-form-label">借阅标题</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input id="borrowSubject2" name="borrowSubject2" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                        <div class="layui-inline" >\n' +
                    '                            <label class="layui-form-label">审核人</label>\n' +
                    '                            <div class="layui-input-inline" style="display: flex">\n' +
                    '                                <input id="approver1" disabled="disabled" style="width: 300px" name="approver1" class="layui-input" type="text">' +
                    '<div style="width: 70px;line-height: 35px;">\n' +
                    '                                    <a href="javascript:;" class="addControls1" data-type="3">添加</a>\n' +
                    '                                    <a href="javascript:;" class="cleardate1">清空</a>\n' +
                    '                                </div>\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </form></div>\n' +
                    '                <div>\n' +
                    '                    <form class="layui-form" action="">\n' +
                    '                        <label class="layui-form-label">借阅理由</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <textarea style="width: 50%"  id="borrowReason1" name="borrowReason1" class="layui-textarea"  "></textarea>\n' +
                    '                        </div>\n' +
                    '                    </form>\n' +
                    '                    <form class="layui-form" action="">\n' +
                '                                <div class="layui-row">' +
                        '                                    <div class="layui-col-xs12" style="padding: 0 5px;">\n' +
                    '                                        <div class="layui-form-item" >\n' +
                    '                                            <div class="layui-inline" style="width:100%">\n' +
                    '                                                <label class="layui-form-label">附件</label>\n' +
                    '                                               <div class="layui-input-block" style="padding-top: 9px;style="display: flex"">\n' +
                    '                                                   <div id="fileAllAgenda" style="text-align: left;"></div>\n' +
                    '                                                   <a href="javascript:;" class="openFile" style="float: left;position:relative;margin-top:9px">\n' +
                    '                                                   </a>\n' +
                    '                                                </div>' +
                    '                                            </div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                </div>\n' +
                '                    </form>'
                ,
                success: function (json) {
                    $('#pics1').click(function () {
                        var deptName2=$('#borrowOragn2').val();
                        $.ajax({
                            url:'/EduorgBorrow/selectByDeptId?deptName='+deptName2,
                            type:'post',
                            dataType:'json',
                            data:{
                            },
                            success:function(res){

                                var arr=[];
                                var str
                                for(var i=0;i<res.obj.length;i++){

                                    // arr1=res.obj[i].orgFullname;
                                    str+='<option value="'+res.obj[i].licenceId+'">'+res.obj[i].licenceName+'</option>'
                                    // arr.push(arr1);
                                }

                                $('select[name="licenceId"]').append(str);
                                form.render('select');
                                return false;
                            }
                        })
                    })

                    form.render();
                    $(".deptAdds").on("click",function(){
                        priv_id="borrowOragn2";
                        $.popWindow("../EduorgMessage/selectOrg?0");
                    });
                    // 清空部门信息
                    $('.deptClears').click(function () {
                        $('#borrowOragn2').attr("privid","");
                        $('#borrowOragn2').attr("privid","");
                        $('#borrowOragn2').val("");
                    });

                    var borrowOragn=data.borrowOragn
                    $.ajax({
                        url:'/EduorgBorrow/selectUser',
                        type:'post',
                        dataType:'json',
                        data:{
                        },
                        success:function(obj){
                            $('#applicant').val(obj.object.userName);
                            $('#applicanDept').val(obj.object.deptName);
                            c =obj.object.userId;
                            applicanDept1=obj.object.deptName;
                        }
                    })


                    $('.addControls1').click(function () {
                        var type=$(this).attr('data-type');
                        if(type==3){
                            user_id = "approver1";
                            $.ajax({
                                url:'/imfriends/getIsFriends',
                                type:'get',
                                dataType:'json',
                                data:{},
                                success:function(obj){
                                    if(obj.object == 1){
                                        $.popWindow("../common/selectUserIMAddGroup");

                                    }else{
                                        $.popWindow("../common/selectUser");
                                    }
                                },
                                error:function(res){
                                    $.popWindow("../common/selectUser");
                                }
                            })

                        }
                    });

                    $('.cleardate1').click(function () {
                        $('#approver1').attr("privid","");
                        $('#approver1').attr("userpriv","");
                        $('#approver1').val("");
                    });
                    $.ajax({
                        type: 'post',
                        url: '/EduorgBorrow/selectById',
                        dataType: 'json',
                        data:{
                            borrowId:data.borrowId
                        },
                        success: function (json) {
                            var licenceId1=data.licenceId
                            if(json.flag){
                                $('#borrowSubject2').val(json.object.borrowSubject);
                                $('#returnTime1').val(json.object.returnTime);
                                $('#applicant1').val(json.object.applicant);
                                $('#borrowTime2').val(json.object.borrowTime);
                                $('#borrowReason1').val(json.object.borrowReason);
                                $('#approver1').val(json.object.approver);
                                $('#applicanDept2').val(json.object.applicanDept);
                                $('#borrowOragn2').val(json.object.borrowOragn);
                                var deid= $('#borrowOragn2').val();
                                $.ajax({
                                    url:'/EduorgBorrow/selectByDeptId?deptName='+deid,
                                    type:'post',
                                    dataType:'json',
                                    data:{
                                    },
                                    success:function(res){

                                        var arr=[];
                                        var str
                                        for(var i=0;i<res.obj.length;i++){
                                            // arr1=res.obj[i].orgFullname;
                                            str+='<option value="'+res.obj[i].licenceId+'">'+res.obj[i].licenceName+'</option>'
                                            // arr.push(arr1);
                                        }
                                        $('select[name="licenceId1"]').append(str);
                                        form.render('select');
                                        $('#licenceId1').find('option[value="'+json.object.licenceId+'"]').prop('selected',true);
                                        form.render();
                                    }

                                })

                                var optionItem = $("select[name='licenceId1']").find("option")
                                for(var i=0;i<$("select[name='licenceId1']").find("option").length;i++){
                                    if(licenceId1==$(optionItem[i]).val()){
                                        $("#licenceId1").find('option[value="'+licenceId1+'"]').attr('selected','selected');
                                        form.render('select');
                                    }
                                }
                                form.render();
                            }
                        }
                    })

                    // form.render();

                }, yes: function () {
                    $.ajax({
                        type: 'post',
                        url: '/EduorgBorrow/update',
                        dataType: 'json',
                        data: {
                            borrowId:data.borrowId,
                            borrowTime: $("#borrowTime2").val(),
                            returnTime: $("#returnTime1").val(),
                            applicant: $("#applicant1").val(),
                            borrowReason: $("#borrowReason1").val(),
                            borrowOragn: $("#borrowOragn1").val(),
                            applicanDept: $("#applicanDept2").val(),
                            approver: $("#approver1").val(),
                            licenceId: $("#licenceId1").val(),
                            borrowSubject: $('#borrowSubject2').val(),



                        },
                        success: function (json) {
                         layer.closeAll()
                            $.layerMsg({content: '修改成功！', icon: 1}, function () {
                                location.reload();
                            })
                        }
                    })
                }
            })
        }else if(obj.event == 'detail3'){
            layer.confirm('确定删除该条数据吗？', {
                btn: ['确定','取消'], //按钮
                title:"删除"
            }, function(){
                $.ajax({
                    type: 'post',
                    url: '/EduorgBorrow/delById',
                    dataType: 'json',
                    data: {
                        borrowId:data.borrowId
                    },
                    success: function (json) {
                        if(json.flag){
                            layer.closeAll();
                            $.layerMsg({content: '删除成功！', icon: 1}, function () {
                                location.reload();
                            })
                        }
                    }
                })
            })

        }else if(obj.event == 'detail4'){
            layer.open({
                type: 1 //此处以iframe举例
                , title: '查看'
                , area: ['80%', '90%'],
                offset:'20',
                btn: ['取消'],
                content: '' +
                    '                <div>\n' +
                    '                    <form class="layui-form" action="">\n' +
                    '                        <div class="layui-inline" >\n' +
                    '                            <label class="layui-form-label">申请人</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input id="applicant1" disabled="disabled" style="width: 300px" name="applicant1" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                       <div class="layui-inline" >\n' +
                    '                            <label class="layui-form-label">申请人所在部门</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input id="applicanDept2" disabled="disabled" style="width: 300px" name="applicanDept2" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </form></div>\n' +
                    '<div><form class="layui-form" action="" style="display: flex;height: 40;">\n' +
                    '                                      <div class="layui-form-item">\n' +
                    '        <label class="layui-form-label">借阅机构</label>\n' +
                    '        <div class="layui-input-inline" style="width: 300px">\n' +
                    '            <input type="text" disabled="disabled" name="borrowOragn2" id="borrowOragn2" style="display: inline-block;width: 300px"  lay-verify="borrowOragn" autocomplete="off" placeholder="" class="layui-input">\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '                                      <div class="layui-form-item">\n' +
                    '        <label class="layui-form-label">借阅证照</label>\n' +
                    '        <div class="layui-input-inline" style="width: 350px">\n' +
                    '            <input type="text" disabled="disabled" name="licenceId1" id="licenceId1" style="display: inline-block;width: 300px"  lay-verify="borrowOragn" autocomplete="off" placeholder="" class="layui-input">\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '                    </form></div>\n' +
                    '                <div>\n' +
                    '                    <form class="layui-form" action="">\n' +
                    '                        <div class="layui-inline" >\n' +
                    '                            <label class="layui-form-label">借阅时间</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input disabled="disabled" id="borrowTime2" style="width: 300px" onclick="laydate({istime: true, format: \'YYYY-MM-DD\'})" name="borrowTime2" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                        <div class="layui-inline">\n' +
                    '                            <label class="layui-form-label">计划归还时间</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input disabled="disabled" id="returnTime1" style="width: 300px;margin-left:3%" onclick="laydate({istime: true, format: \'YYYY-MM-DD\'})" name="returnTime1" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </form></div>\n' +
                    '                <div>\n' +
                    '                    <form class="layui-form" action="">' +
                    '<div class="layui-inline">\n' +
                    '                            <label class="layui-form-label">借阅标题</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input disabled="disabled" id="borrowSubject2" name="borrowSubject2" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                        <div class="layui-inline" >\n' +
                    '                            <label class="layui-form-label">审核人</label>\n' +
                    '                            <div class="layui-input-inline" style="display: flex">\n' +
                    '                                <input id="approver1" disabled="disabled" style="width: 300px" name="approver1" class="layui-input" type="text">' +
                    '<div style="width: 70px;line-height: 35px;">\n' +
                    '                                </div>\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </form></div>\n' +
                    '                <div>\n' +
                    '                    <form class="layui-form" action="">\n' +
                    '                        <label class="layui-form-label">借阅理由</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <textarea style="width: 50%"  id="borrowReason1" name="borrowReason1" class="layui-textarea"  "></textarea>\n' +
                    '                        </div>\n' +
                    '                    </form>\n' +
                    '                    <form class="layui-form" action="">\n' +
                    '                                <div class="layui-row">' +
                    '                                    <div class="layui-col-xs12" style="padding: 0 5px;">\n' +
                    '                                        <div class="layui-form-item" >\n' +
                    '                                            <div class="layui-inline" style="width:100%">\n' +
                    '                                                <label class="layui-form-label">附件</label>\n' +
                    '                                               <div class="layui-input-block" style="padding-top: 9px;style="display: flex"">\n' +
                    '                                                   <div id="fileAllAgenda" style="text-align: left;"></div>\n' +
                    '                                                   <a href="javascript:;" class="openFile" style="float: left;position:relative;margin-top:9px">\n' +
                    '                                                   </a>\n' +
                    '                                                </div>' +
                    '                                            </div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                </div>\n' +
                    '                    </form>'
                ,
                success: function (json) {
                    var borrowOragn=data.borrowOragn
                    // $.ajax({
                    //     url:'/EduorgBorrow/selectAll',
                    //     type:'post',
                    //     dataType:'json',
                    //     data:{
                    //     },
                    //     success:function(obj){
                    //         $('#applicant').val(obj.object.userName);
                    //         $('#applicanDept').val(obj.object.deptName);
                    //         c =obj.object.userId;
                    //         applicanDept1=obj.object.deptName;
                    //     }
                    // })


                    $('.addControls1').click(function () {
                        var type=$(this).attr('data-type');
                        if(type==3){
                            user_id = "approver1";
                            $.ajax({
                                url:'/imfriends/getIsFriends',
                                type:'get',
                                dataType:'json',
                                data:{},
                                success:function(obj){
                                    if(obj.object == 1){
                                        $.popWindow("../common/selectUserIMAddGroup");

                                    }else{
                                        $.popWindow("../common/selectUser");
                                    }
                                },
                                error:function(res){
                                    $.popWindow("../common/selectUser");
                                }
                            })

                        }
                    });

                    $('.cleardate1').click(function () {
                        $('#approver1').attr("privid","");
                        $('#approver1').attr("userpriv","");
                        $('#approver1').val("");
                    });
                    $.ajax({
                        type: 'post',
                        url: '/EduorgBorrow/selectById',
                        dataType: 'json',
                        data:{
                            borrowId:data.borrowId
                        },
                        success: function (json) {
                            var object = json.object;
                            var licTypeName = object.licenceName;
                            var licTypeVal = object.licenceId;
                            form.val("formTest2",object);
                            if(licTypeName != undefined && licTypeName != null ){
                                var strEdit = ''
                                for(var i=0; i<licTypeName.length; i++){
                                    if(licTypeName[i] != ''){
                                        strEdit +=  '     <div class="layui-row" style="margin-top: 10px">\n' +
                                            '                 <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                                            '                        <div class="layui-form-item" >\n' +
                                            '                             <div class="layui-inline">\n' +
                                            '                                  <label class="layui-form-label" >' + licTypeName[i] + '</label>\n' +
                                            '                                  <div class="layui-input-inline">\n' +
                                            '                                        <input type="text" lay-verify="required|phone" autocomplete="off" class="layui-input jinyong" value="'+ licTypeVal[i] + '">\n' +
                                            '                                  </div>\n' +
                                            '                             </div>\n' +
                                            '                        </div>\n' +
                                            '                 </div>\n' +
                                            '          </div>\n';
                                    }
                                }
                                $('.customize').html(strEdit)
                                form.render();
                                // if(type2 == '2'){
                                //     $('.jinyong').attr('disabled','disabled')
                                // }
                            }
                            var strr = ''
                            if(object.attUrl != undefined){
                                if((object.attUrl[0] != undefined && object.attUrl.length>0)){
                                    for(var i=0;i<object.attUrl.length;i++){
                                        var str1 = ""
                                        if( object.attUrl[i].attUrl != undefined ){
                                            str1 = '<div class="dech" deurl="' +object.attUrl[i].attUrl + '">' +
                                                '<a href="/download?' + object.attUrl[i].attUrl + '" name="'+object.attUrl[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                                '<img src="/img/attachment_icon.png">' + object.attUrl[i].attachName + '</a>' +
                                                '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png">' +
                                                '<input type="hidden" class="inHidden" value="' + object.attUrl[i].aid + '@' + object.attUrl[i].ym + '_' + object.attUrl[i].attachId +',">' +
                                                '<a onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                                '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                                '<a style="padding-left: 5px" href="/download?' + object.attUrl[i].attUrl + '">' +
                                                '<img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">下载</a>\n' +
                                                '</div>' +
                                                '</div>'
                                        }else{
                                            str1 = '';
                                        }
                                        strr += str1;
                                    }
                                }else {
                                    strr='';
                                }
                            }else {
                                strr='';
                            }

                            $('#fileAllAgenda').html(strr);
                            var licenceId1=data.licenceId
                            if(json.flag){
                                $('#borrowSubject2').val(json.object.borrowSubject);
                                $('#returnTime1').val(json.object.returnTime);
                                $('#applicant1').val(json.object.applicant);
                                $('#borrowTime2').val(json.object.borrowTime);
                                $('#borrowReason1').val(json.object.borrowReason);
                                $('#approver1').val(json.object.approver);
                                $('#licenceId1').val(json.object.licenceName);
                                $('#applicanDept2').val(json.object.applicanDept);
                                $('#borrowOragn2').val(json.object.borrowOragn);
                                var deid= $('#borrowOragn2').val();
                                // $.ajax({
                                //     url:'/EduorgBorrow/selectByDeptId?deptName='+deid,
                                //     type:'post',
                                //     dataType:'json',
                                //     data:{
                                //     },
                                //     success:function(res){
                                //
                                //         var arr=[];
                                //         var str
                                //         for(var i=0;i<res.obj.length;i++){
                                //             // arr1=res.obj[i].orgFullname;
                                //             str+='<option value="'+res.obj[i].licenceId+'">'+res.obj[i].licenceName+'</option>'
                                //             // arr.push(arr1);
                                //         }
                                //         $('select[name="licenceId1"]').append(str);
                                //         form.render('select');
                                //         $('#licenceId1').find('option[value="'+json.object.licenceId+'"]').prop('selected',true);
                                //         form.render();
                                //     }
                                //
                                // })

                                var optionItem = $("select[name='licenceId1']").find("option")
                                for(var i=0;i<$("select[name='licenceId1']").find("option").length;i++){
                                    if(licenceId1==$(optionItem[i]).val()){
                                        $("#licenceId1").find('option[value="'+licenceId1+'"]').attr('selected','selected');
                                        form.render('select');
                                    }
                                }
                                form.render();
                            }
                        }
                    })


                },
            })
        }

    })



});


</script>
</html>
