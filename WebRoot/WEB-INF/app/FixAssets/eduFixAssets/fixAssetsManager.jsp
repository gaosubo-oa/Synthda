<%--
  Created by IntelliJ IDEA.
  User: 牛江丽
  Date: 2017/9/11
  Time: 17:00
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
<html>
<head>
    <title><fmt:message code="main.assetmanage" /></title>
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <%-- <link rel="stylesheet" type="text/css" href="../css/base.css" />
     <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
     <script src="../../lib/layer/layer.js?20201106"></script>--%>

    <link rel="stylesheet" type="text/css" href="../css/news/center.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css" />
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <script type="text/javascript" src="../../lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="../../lib/layui/layui/layui.all.js"></script>
    <script src="../js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../../lib/layui/layui/global.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/news/new_news.css"/>
    <!-- word文本编辑器 -->
    <script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="../js/jquery/jquery.cookie.js" type="text/javascript" charset="utf-8"></script>


</head>
<style>
    body,html{
        width:98%;
        height:100%;
    }
    .th{
        font-size: 13pt;
        width:10%;
    }
    td{
        width:10%;
        font-size: 11pt;
    }
    .navigation{
        margin-left: 30px;
        position: relative;
    }
    .del_btn {
        color: #E01919;
        cursor: pointer;
    }
    .edit_btn,.Handover_btn,.Maintain_btn,.detail_btn,.allocation_btn,.scrap_btn{
        color: #1772C0;
        cursor: pointer;
    }
    #tr_td td{
        text-align: center;
    }
    .exportsss {
        width: 80px;
        height: 30px;
        cursor: pointer;
        background-image: url(../../img/import.png);
        padding-left: 25px;
        font-size: 13px;
        background-repeat: no-repeat;
        border-width: initial;
        border-style: none;
        border-color: initial;
        border-image: initial;
    }
    .fileload {
        position: absolute;
        opacity: 0;
        width: 80px;
        right: 520px;
        height: 29px;
        top: 21px;
    }
    .newClass{
        float: right;
        width: 90px;
        height: 28px;
        background: url(../../img/file/cabinet01.png) no-repeat;
        color: #fff;
        font-size: 14px;
        line-height: 28px;
        margin: 2% 4% 0 0;
        cursor: pointer;
    }
    .notice_do{
        width:16%;
    }
    td.assetName a{
        display: block;
        width:100%;
        max-width: 138px;
        color: #1772C0;
        cursor: pointer;
        overflow: hidden;
        text-overflow:ellipsis;
        white-space: nowrap;
    }
    .imgDiv{
        text-align: center;
        display: none;
        margin-top: 60px;
    }
    .cl{
        clear: both;
    }
    .inp{
        border-radius: 4px;
        border: 1px solid #ccc;
        font-size: 12px;
        margin: 0;
        font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
    }
    .newsAdd tr{
        border-radius: 10px;
    }
    .bottom div{
        float: left;
        height: 85%;
        font-size: 14px;
        font-weight: normal;
        text-align: center;
        margin-top: 10px;
    }
    .bottom .dispatchAll {
        width: 110px;
        height: 30px;
        background-color: #2d7de0;
        color: white;
        text-align: center;
        cursor: pointer;
        border-radius: 14px;
        margin-top: 5px;
        line-height: 30px;
        margin-left: 30px;
    }
    .layui-layer .layuiDiv {
        margin-top: 20px;
        text-align: center;
    }

    .layuiDiv span {
        font-size: 11pt;
    }

    .layuiDiv select {
        width: 300px;
        height: 40px;
        font-size: 11pt;
    }
    .layui-form-item {
        margin-bottom: 8px;
    }
    .layui-btn {
        background-color: #2b7fe0;
    }
    /*.layui-layer{*/
    /*top:100px!important;*/
    /*}*/
</style>

<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
<body style="font-family: 微软雅黑;">
<div>
    <div class="navigation  clearfix">
        <p style="margin:10px 0 0 10px">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/fixAssetsManage.png" style="display: block;float: left">
            <span style="font-size: 18px;margin: 2px 0 10px 5px;color: black;display: block;float: left">资产管理</span>
        </p>
        <div class="left">
            <form class="layui-form" action style="margin-top: 20px;">
                <div class="layui-form-item oneDiv">
                    <div class="layui-inline">
                        <label class="layui-form-label">资产编号:</label>
                        <div class="layui-input-inline">
                            <input  type="text" class="layui-input" autocomplete="off" name="assetsId" id="assetsId" style="width: 150px;">
                        </div>
                    </div>
                    <div class="layui-inline" style="margin-left: -30px" >
                        <label class="layui-form-label">资产名称:</label>
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input" autocomplete="off" name="assetsName" id="assetsName" style="width: 150px;" >
                        </div>
                    </div>
                    <div class="layui-inline"style="margin-left: -30px">
                        <label class="layui-form-label" style="width: 110px">是否是固定资产:</label>
                        <div class="layui-input-inline">
                            <select  name="isAssets" id="isAssets" lay-search="" style="width: 150px;display: block">
                                <option value="">请选择...</option>
                                <option value="1">是</option>
                                <option value="0">否</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item oneDiv">
                    <div class="layui-inline">
                        <label class="layui-form-label">所在位置:</label>
                        <div class="layui-input-inline">
                            <select name="currrntLocation" id="currrntLocation" lay-verify="required" lay-search="" style="width: 150px;display: block">
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline">
                        <%--<label class="layui-form-label">所在部门:</label>
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input"  name="" id="deptment" user_id="" value="点击右侧添加" oninput="alert(1)"  disabled>
                        </div>
                        <a href="javascript:;" id="selectDept" style="color:#1772c0"><fmt:message code="global.lang.add"/></a>
                        <a href="javascript:;" id="clearDept" style="color:#1772c0"><fmt:message code="global.lang.empty"/></a>--%>
                        <button type="button" class="layui-btn layui-btn-sm submit" id="cx" style="margin-left: -20px;margin-top: -10px;">
                            <i class="layui-icon layui-icon-search" ></i> 查询
                        </button>
                    </div>
                </div>
            </form>

        <div class="newClass" id="newClass" style="position: absolute;right: -5%;top: 2px">
            <span style="margin-left: 30px;">
                <img style="margin-right: 10px;margin-left: 15px;margin-top: 8px;" src="../../img/mywork/newbuildworjk.png" alt="">
                <span style="float: left">新建</span>
            </span>
        </div>
        <div class="newClass" id="printCode" style="position: absolute;right: 3%;top: 2px;">
            <span style="margin-left: 10px;">
                <%--<img style="margin-right: 4px;margin-left: -11px;margin-bottom: -2px;" src="../../img/mywork/newbuildworjk.png" alt="">--%>
                打印二维码
            </span>
        </div>

    </div>

    <div class="cl"></div>
    <div>
        <div>
            <div class="imgDiv"><img class="noneImg" src="/img/main_img/shouyekong.png" alt="">
                <div>暂无数据</div>
            </div>
            <table id="tr_td" style="margin-left: 1%;width: 98%;" >
                <thead>
                <tr>
                    <td colspan="10" class="th" style="text-align: left">
                        <div class="bottom">
                            <div class="allTrue"><input type="checkbox" id="allChoose" style="margin-left: 22px;"/>全选</div>
                            <div class="dispatchAll">
                                批量调度
                            </div>
                            <div class="dispatchAll" onclick="equipment(1)">
                                设为应急设备
                            </div>
                            <div class="dispatchAll" onclick="equipment(0)">
                                取消应急设备
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="th"><fmt:message code="notice.th.chose"/></td>
                    <td class="th" ><fmt:message code="event.th.FixedAssetNumber" /></td>
                    <td class="th"><fmt:message code="event.th.AssetName" /></td>
                    <td class="th titleOne">品牌型号</td>
                    <td class="th">项目名称</td>
                    <td class="th">所属部门</td>
                    <td class="th" >所在位置</td>
                    <td class="th">类型</td>
                    <td class="th"><fmt:message code="event.th.ArticleStatus" /></td>
                    <%--<td class="th"><fmt:message code="event.th.FixedAssetsPicture" /></td>--%>
                    <td class="th notice_do"><fmt:message code="notice.th.operation" /></td>
                </tr>
                </thead>
                <tbody id="j_tb"></tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--分页按钮--%>
    <div id="dbgz_page" class="M-box3 fr" style="margin-right: 6%;margin-top: 2%">

    </div>
</div>
<script>
    var form
    var treeSelect
    (function dep_user_select() {
        $("#selectDept").on("click", function () {
            dept_id = 'deptment';
            $.popWindow("../../common/selectDept?allDept=1");
        });

        /*$(document).on("click", '#adduser',function () {
            user_id = 'userDept';
            $.popWindow("../../common/selectUser");
        });*/

        /*$(document).on("click", '#clearadduser',function () {
            $('#userDept').attr('user_id', '');
            $('#userDept').attr('userprivname', '');
            $('#userDept').removeAttr('dataid');
            $('#userDept').val('');
        });*/


        function clearDept() {
            $('#deptment').removeAttr('deptid');
            $('#deptment').attr('dataid', '');
            $('#deptment').removeAttr('deptno');
            $('#deptment').val('');
        }

        $('#clearDept').on("click",function () {
            clearDept();
        });
        $("#selectUser").on("click", function () {
            user_id = 'userDuser';
            $.popWindow("../../common/selectUser");
        });

        function clearUser() {
            $('#userDuser').attr('user_id', '');
            $('#userDuser').attr('userprivname', '');
            $('#userDuser').removeAttr('dataid');
            $('#userDuser').val('');
        }

        $('#clearUser').on("click",function () {
            clearUser();
        });
    })();
    layui.use([ 'layer', 'form', 'treeSelect'], function () {
         var layer = layui.layer;
         form = layui.form;
        treeSelect = layui.treeSelect;
    })
    //打印二维码
    $("#printCode").on("click",function(){
        window.open ("/eduFixAssets/fixAssetsCodePrint")
    })
    //新建
    $("#newClass").on("click",function(){
        window.location.href="/eduFixAssets/fixAssetsEdit?editFlag=0&id=0";
    })
    //删除
    $("#tr_td").on("click",".del_btn",function () {
        var id= $(this).attr("id");
        layer.confirm('<fmt:message code="workflow.th.que" />？', {
            btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'], //按钮
            title: "<fmt:message code="event.th.DeleteAssets" />"
        }, function () {
            //确定删除，调接口
            $.ajax({
                url: '/eduFixAssets/deleteFixAssetsById',
                type: 'post',
                data: {
                    id: id,
                },
                dataType: 'json',
                success: function (json) {
                    if (json.flag) {
                        $.layerMsg({content: '<fmt:message code="workflow.th.delsucess" />！', icon: 1}, function () {
                            window.location.href = '/eduFixAssets/fixAssetsManager';
                        });
                    }
                }
            })
        }, function () {
            layer.closeAll();
        });
    })

    //点击标题查看详情
    $("#tr_td").on("click",".assetName",function () {
        var id = $(this).attr("id");
        $.popWindow("../../eduFixAssets/fixAssetsDetail?id="+id,"固定资产详情",100,100,1200,500)

    })
    $("#tr_td").on("click",".detail_btn",function () {
        var id = $(this).attr("id");
        $.popWindow("../../eduFixAssets/fixAssetsDetail?id="+id,"固定资产详情",100,100,1200,500)

    })
    function isNull(str) {
        if (str){
            return str;
        }else {
            return '';
        }
    }
    //进行条件查询方法，并在列表中显示
    var ajaxPage={
        data:{
            page:1,//当前处于第几页
            pageSize:20,//一页显示几条
            useFlag:true,
        },
        init:function () {
        },
        page:function () {
            var me=this;
            $.get('/eduFixAssets/selectEduFixAssets',me.data,function (obj) {
                $("#tr_td tbody").html("");
                var str="";
                var data=obj.obj;
                if(obj.flag){
                    if(data.length==0){
                        $(".imgDiv").css("display","block");
                        $("#tr_td").css("display","none");
                        $("#dbgz_page").css("display","none");
                        return
                    }
                    $(".imgDiv").css("display","none");
                    $("#tr_td").css("display","block");
                    $("#dbgz_page").css("display","block");
                    for(var i=0;i<data.length;i++){
                        str+='<tr >' +
                            '<td class="checkWrap"><input type="checkbox" name="chkItem" class="childCheck"> </td>' +
                            '<td style="min-width:166px" rescueType="'+data[i].rescueType+'">'+data[i].id+'</td>' +
                            '<td class="assetName" id="'+data[i].id+'" title="'+data[i].assetsName+'"><a >'+isNull(data[i].assetsName)+'</a></td>' +
                            '<td>'+isNull(data[i].info)+'</td>' +
                            '<td>'+isNull(data[i].projectName)+'</td>' +
                            '<td>'+isNull(data[i].deptName)+'</td>' +
                            '<td style="min-width:120px">'+isNull(data[i].currutLocation)+'</td>' +
                            '<td>'+isNull(data[i].typeName)+'</td>';
                        if(data[i].status==1){
                            str+='<td><fmt:message code="event.th.notUsed" /></td>';
                        }else if(data[i].status==2){
                            str+='<td><fmt:message code="evvent.th.Use" /></td>';
                        }else if(data[i].status==3){
                            str+='<td><fmt:message code="event.th.damage" /></td>';
                        }else if(data[i].status==4){
                            str+='<td><fmt:message code="event.th.Lose" /></td>';
                        }else if(data[i].status==5){
                            str+='<td><fmt:message code="event.th.Scrap" /></td>';
                        }else {
                            str+='<td></td>';
                        }

//                        if(data[i].image!='' && data[i].image!='undefined'){
//                            str += '<td>' + '<img src="/img/edu/eduFixAssets/' + data[i].image + '" style="height: 70px;width: 110px;"/>' + '</td>';
//                        }else{
//                            str += '<td></td>';
//                        }
                        str+= '<td style="min-width:100px;">' +
                            //                            '<a class="detail_btn"  id="'+data[i].id+'" >查看详情</a>' +
                            '<a class="edit_btn"  href="../../eduFixAssets/fixAssetsEdit?editFlag=1&apex=1&id='+data[i].id+'"><fmt:message code="global.lang.edit" /></a>' +
                            '<a class="Handover_btn"  style="padding: 0px 5px;"href="../../Atab/fixAssetsAtab?uid='+data[i].id+'&type=1">交接明细</a><a class="allocation_btn" style="display: none;">调拨</a>'+
                            '<a class="scrap_btn" style="display: none;">报废</a><a class="Maintain_btn" style="padding: 0px 5px;" href="../../Maintain/fixAssetsMaintain?uid='+data[i].id+'&type=1">维修明细</a>'+
                            '<span class="del_btn" id="'+data[i].id+'" style=""><fmt:message code="global.lang.delete" /></span></td>' +
                            '</tr>';
                    }
                    $("#tr_td tbody").html(str);
                    $("#allChoose").prop("checked", false);
                    $('.allocation_btn').on("click",function(){
                        var nnn = new Date($.ajax({async: false}).getResponseHeader("Date"));
                        var currentYear = nnn.getFullYear();
                        var currentMonth = nnn.getMonth();
                        var currentDay;
                        if(nnn.getDate()<10){
                            currentDay = '0'+nnn.getDate()
                        }else{
                            currentDay = nnn.getDate();
                        }
                        var nowTime = currentYear+"-"+currentMonth+"-"+currentDay;
                        // var flowId=$('#DATA').attr('flowId');
                        layer.open({
                            type: 1,
                            title:['新建调拨', 'background-color:#2b7fe0;color:#fff;'],
                            area: ['520px', '280px'],
                            shadeClose: true, //点击遮罩关闭
                            btn: ['创建', '关闭'],
                            content: '<div class="newsAdd" style="padding-left: 5px;">' +
                                '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 100%;margin-top: 20px;">' +
                                '<tr class="applicant">' +
                                '<td style="width: 95px;padding-left: 105px;">&nbsp;&nbsp;&nbsp;'+'申请人'+'：</td>' +
                                '<td style="padding-right:60px ;">' +
                                '<input type="text" class="inp" name="userName" style="width: 180px;" value="  '+$.cookie('userName')+'" id="leaveUser" readonly="readonly" userId="'+$.cookie('userId')+'" >' +
                                '</td>' +
                                '</tr>' +
                                '<tr>' +
                                '<td style="width: 95px;padding-left: 105px;">'+'登记时间'+'：</td>' +
                                '<td style="padding-right:60px ;">' +
                                '<input type="text" class="inp"  style="width: 180px;" name="begainTime" id="leaveTime" class="inputTd" readonly="readonly" value="  '+nowTime+'" />' +
                                '</td>' +
                                '</tr>' +
                                '</table>' +
                                '</div>',
                            yes:function(index){
                                $.ajax({
                                    type:'post',
                                    url:'/eduFixAssets/addGoToFixAssets',
                                    dataType:'json',
                                    async:false,
                                    data:{
                                        userId:$('#leaveUser').attr('userId'),
                                        recordTime:$('#leaveTime').val()

                                    },
                                    async:false,
                                    success:function(res){
                                        if(res.flag){
                                            $.popWindow('../workflow/work/workform?flowId='+res.object['flowTypeModel']['flowId']+'&flowStep=1&prcsId=1&runId='+res.object['flowRun']['runId'],'快速新建页面','0','0','1500px','800px');
                                        }
                                    }
                                });
                                layer.close(index);

                            },
                        });
                    })
                    $('.scrap_btn').on("click",function(){
                        var nnn = new Date($.ajax({async: false}).getResponseHeader("Date"));
                        var currentYear = nnn.getFullYear();
                        var currentMonth = nnn.getMonth();
                        var currentDay;
                        if(nnn.getDate()<10){
                            currentDay = '0'+nnn.getDate()
                        }else{
                            currentDay = nnn.getDate();
                        }
                        var nowTime = currentYear+"-"+currentMonth+"-"+currentDay;
                        // var flowId=$('#DATA').attr('flowId');
                        layer.open({
                            type: 1,
                            title:['新建报废', 'background-color:#2b7fe0;color:#fff;'],
                            area: ['520px', '280px'],
                            shadeClose: true, //点击遮罩关闭
                            btn: ['创建', '关闭'],
                            content: '<div class="newsAdd" style="padding-left: 5px;">' +
                                '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 100%;margin-top: 20px;">' +
                                '<tr class="applicant">' +
                                '<td style="width: 95px;padding-left: 105px;">&nbsp;&nbsp;&nbsp;'+'申请人'+'：</td>' +
                                '<td style="padding-right:60px ;">' +
                                '<input type="text" class="inp" name="userName" style="width: 180px;" value="  '+$.cookie('userName')+'" id="leaveUser" readonly="readonly" userId="'+$.cookie('userId')+'" >' +
                                '</td>' +
                                '</tr>' +
                                '<tr>' +
                                '<td style="width: 95px;padding-left: 105px;">'+'登记时间'+'：</td>' +
                                '<td style="padding-right:60px ;">' +
                                '<input type="text" class="inp"  style="width: 180px;" name="begainTime" id="leaveTime" class="inputTd" readonly="readonly" value="  '+nowTime+'" />' +
                                '</td>' +
                                '</tr>' +
                                '</table>' +
                                '</div>',
                            yes:function(index){
                                $.ajax({
                                    type:'post',
                                    url:'/eduFixAssets/addGoToFixAssets',
                                    dataType:'json',
                                    async:false,
                                    data:{
                                        userId:$('#leaveUser').attr('userId'),
                                        recordTime:$('#leaveTime').val(),
                                        type:"固定资产报废"

                                    },
                                    success:function(res){
                                        if(res.flag){
                                            $.popWindow('../workflow/work/workform?flowId='+res.object['flowTypeModel']['flowId']+'&flowStep=1&prcsId=1&runId='+res.object['flowRun']['runId'],'快速新建页面','0','0','1500px','800px');
                                        }
                                    }
                                });
                                layer.close(index);

                            },
                        });
                    })
                }
                me.pageTwo(obj.totleNum,me.data.pageSize,me.data.page)
            },'json')
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
    ajaxPage.init()
    ajaxPage.page()
    $('#allChoose').on("click",function () {
        var state = $(this).prop('checked');
        if (state == true) {
            $(this).prop('checked', true);
            $('.childCheck').prop('checked', true);
        } else {
            $(this).prop('checked', false);
            $('.childCheck').prop('checked', false);
        }
    })
    var dispatchAll = document.getElementsByClassName("dispatchAll")[0];
    dispatchAll.onclick = function () {
        var Arr1 = [];
        for (var x = 0; x < $(".childCheck").length; x++) {
            if ($(".childCheck").eq(x).prop("checked")) {
                Arr1.push(x);
            }
        }
        if (Arr1.length == 0) {
            layer.confirm('请至少选择一项调度！', {
                btn: ['确定'],//按钮
                // area: ['285px', '707px'],
                title: '提示'
            }, function () {
                layer.closeAll();
            });
        } else {
            layer.open({
                type: 1,
                title: ['批量调度', 'background-color:#2b7fe0;color:#fff;'],
                area: ['900px', '80%'],
                shadeClose: true, //点击遮罩关闭
                btn: ['确定', '关闭'],
                content:
                    "<div class='layuiDiv'>\n" +
                    "        <span style='margin-left: 52px;'>资产名称：</span>\n" +
                    "<textarea name='txt' id='assetsNames' assetsId='' value='' disabled='' style='min-width: 400px;min-height:280px;font-size:18px'></textarea>\n" +
                    "<a id='addAssetsNames' href='javascript:;' style='color:#1772c0'>添加</a><a id='clearAssetsNames' href='javascript:;' style='color:#f00;margin-left: 5px'>清空</a></div>\n" +
                    "    <div class='layuiDiv'>\n" +
                    "        <span style='margin-left: 28px'>类型：</span><select id='typeId' style='width:400px;'><option value=''>请选择..</option></select>\n" +
                    "    </div>\n" +
                    "    <div class='layuiDiv'>\n" +
                    "        <span style='margin-left: 53px;'>所在部门：</span>\n" +
                    "<textarea name=\"deptId\" id=\"deptId\" class=\"deptId\" deptid=\"\" cols=\"22\" disabled readonly style='width:400px;'></textarea>" +
                    "<a href='javascript:;' class=\"addDeptId\" style=\"color:#207bd6;margin-left:5px;text-decoration:none\">添加</a>" +
                    "<a href=\"javascript:;\" class=\"clearDeptId\" style=\"color:#f00;margin-left:5px;text-decoration:none\">清空</a>" +
                    "    </div>\n" +
                    "    <div class='layuiDiv'>\n" +
                    "        <span>所在位置：</span><select id='currutLocation' style='width:400px;'><option value=''>请选择..</option></select>\n" +
                    "    </div>\n" +
                    "    <div class='layuiDiv'>\n" +
                    "        <span>物品状态：</span><select id='status' style='width:400px;'><option value=''>请选择..</option></select>\n" +
                    "\n" +
                    "    </div>" +
                    // "<div class='layuiDiv'>\n" +
                    // "<span >项目名称：</span><select id='otherDept' style='width:178px;'><option value=''>请选择..</option></select>" +
                    // '<select name="otherDept1" id="otherDept1" style="width: 178px;margin-left:5%"></select>'+
                    // "</div>"+
                    '<div class="layuiDiv" ><div class="layui-form" style="margin: 20px 0;"><label class="layui-form-label" style="width: 249px;">项目名称：</label><div class="layui-input-inline" id="tre" style="width: 200px;margin-left:-46%">' +
                    '<input type="text" id="tree" lay-filter="tree" class="layui-input">'+
                    '<input name="client" type="hidden" class="client" id="client"></div></div></div>'+
                    "<div class='layuiDiv'>\n" +
                    " <span style='margin-left: 70px;'>保管人：<span style='color:red'>*</span></span>\n" +
                    "<textarea name=\"scheduler\" id=\"scheduler\" class=\"scheduler\" deptid=\"\" cols=\"22\" disabled readonly style='width:400px;'></textarea>" +
                    "<a href='javascript:;' class=\"addScheduler\" style=\"color:#207bd6;margin-left:5px;text-decoration:none\">添加</a>" +
                    "<a href=\"javascript:;\" class=\"clearScheduler\" style=\"color:#f00;margin-left:5px;text-decoration:none\">清空</a>" +
                    "</div>\n",
                success:function(){
                    treeSelect.render({
                        // 选择器
                        elem: '#tree',
                        // 数据
                        data:'/crashParent/showAllTree',
                        // 异步加载方式：get/post，默认get
                        type: 'get',
                        // 占位符
                        placeholder: '请选择',
                        // 是否开启搜索功能：true/false，默认false
                        search: true,
                        // 一些可定制的样式
                        style: {
                            folder: {
                                enable: true
                            },
                            line: {
                                enable: true
                            }
                        },
                        // 点击回调
                        click: function(d){
                            console.log(d);
                            $('#client').val(d.current.id);
                        },
                        // 加载完成后的回调函数
                        success: function (d) {
                            console.log(d);
                            var treeId = $('.layui-treeSelect-body').attr('id')
                            var treeObj = $.fn.zTree.getZTreeObj(treeId)
                            var nodes = treeObj.transformToArray(treeObj.getNodes());
                            for (var i=0, l=nodes.length; i < l; i++) {
                                console.log(nodes[i])
                                if (nodes[i].isParent){
                                    treeObj.setChkDisabled(nodes[i], true);
                                }
                            }
                        }
                    });

                    $.ajax({
                        type: 'get',
                        url: "/code/getCode",
                        data: {"parentNo": "LOCATION_ADDRESS"},
                        success: function (data) {
                            $('#currutLocation').html('');
                            $("#currutLocation").append("<option value=''>请选择..</optionid>")
                            for (var x = 0; x < data.obj.length; x++) {
                                $("#currutLocation").append("<option value=" + data.obj[x]["codeNo"] + ">" + data.obj[x]["codeName"] + "</option>")
                            }
                        }
                    });
                    $('#clearAssetsNames').on("click",function () {
                        $('#assetsNames').html('');
                        $('#assetsNames').attr('assetsId','');
                        $('#assetsNames').attr('value','');
                    });
                    $('#addAssetsNames').on("click",function () {
                        layer.open({
                            type: 1,
                            title: ['查询资产名称', 'background-color:#2b7fe0;color:#fff;'],
                            area: ['900px', '450px'],
                            shadeClose: true, //点击遮罩关闭
                            btn: ['查询', '关闭'],
                            content:
                                "    <div class='layuiDiv'>\n" +
                                "        <span>资产名称：</span><input type='text' id='assetsNamess' style='width:400px;height: 40px;font-size: 18px;'/>\n" +
                                "    </div>\n" +
                                "    <div class='layuiDiv'>\n" +
                                "        <span style='margin-left: 40px'>类型：</span><select id='typeIds' style='width:400px;'><option value=''>请选择..</option></select>\n" +
                                "    </div>\n" +
                                "    <div class='layuiDiv'>\n" +
                                "        <span style='margin-left: 40px;'>所在部门：</span>\n" +
                                "<textarea name=\"deptIds\" id=\"deptIds\" class=\"deptIds\" deptid=\"\" cols=\"22\" disabled readonly style='width:400px;'></textarea>" +
                                "<a href='javascript:;' class=\"addDeptIds\" style=\"color:#207bd6;text-decoration:none\">添加</a>" +
                                "<a href=\"javascript:;\" class=\"clearDeptIds\" style=\"color:#f00;text-decoration:none\">清空</a>" +
                                "    </div>\n" +
                                "    <div class='layuiDiv'>\n" +
                                "        <span>所在位置：</span><select id='currutLocations' style='width:400px;'><option value=''>请选择..</option></select>\n" +
                                "    </div>\n" +
                                "    <div class='layuiDiv'>\n" +
                                "        <span>物品状态：</span><select id='statuss' style='width:400px;'><option value=''>请选择..</option></select>\n" +
                                "\n" +
                                "    </div>" +
                                "<div class='layuiDiv'>\n" +
                                "<span>项目名称：</span><select id='otherDepts' style='width:400px;'><option value=''>请选择..</option></select>" +
                                "</div>"+
                                "<div class='layuiDiv'>\n" ,
                            success:function(){
                                $.ajax({
                                    type: 'get',
                                    url: "/code/getCode",
                                    data: {"parentNo": "PROJECT_NAME"},
                                    success: function (data) {
                                        $('#otherDept').html('');
                                        $("#otherDept").append("<option value=''>请选择..</optionid>")
                                        for (var x = 0; x < data.obj.length; x++) {
                                            $("#otherDept").append("<option value=" + data.obj[x]["codeId"] + ">" + data.obj[x]["codeName"] + "</option>")
                                        }
                                    }
                                });
                                $.ajax({
                                    type: 'get',
                                    url: "/code/getCode",
                                    data: {"parentNo": "LOCATION_ADDRESS"},
                                    success: function (data) {
                                        $('#currutLocations').html('');
                                        $("#currutLocations").append("<option value=''>请选择..</optionid>")
                                        for (var x = 0; x < data.obj.length; x++) {
                                            $("#currutLocations").append("<option value=" + data.obj[x]["codeNo"] + ">" + data.obj[x]["codeName"] + "</option>")
                                        }
                                    }
                                });
                                $('#statuss').append('<option value="1"><fmt:message code="event.th.notUsed" /></option>\n' +
                                    '                        <option value="2"><fmt:message code="evvent.th.Use" /></option>\n' +
                                    '                        <option value="3"><fmt:message code="event.th.damage" /></option>\n' +
                                    '                        <option value="4"><fmt:message code="event.th.Lose" /></option>\n' +
                                    '                        <option value="5"><fmt:message code="event.th.Scrap" /></option>');
                                $.ajax({
                                    url:'/eduFixAssets/getFixAssetstypeName',
                                    type:'json',
                                    success:function (res) {
                                        var data = res.object;
                                        var len = data.length;
                                        for (var i = 0; i < len; i++) {
                                            $("#typeIds").append("<option value='"+data[i]['typeId']+"'>"+data[i]['typeName']+"</option>");
                                        }
                                    }
                                });
                                //清空部门控件
                                $(".clearDeptIds").on("click",function(){
                                    $("#deptIds").val("");
                                    $("#deptIds").attr("deptid","");
                                });

                                /!* 选部门控件 *!/
                                $(".addDeptIds").on("click",function(){
                                    dept_id = "deptIds";
                                    $.popWindow("../../common/selectDept?0");
                                });


                            },
                            yes: function (index) {
                                var assetsName = $('#assetsNamess').val();
                                var typeId = $('#typeIds option:selected').val();
                                var deptId = $('#deptIds').attr('deptid');
                                var currutLocation = $('#currutLocations').val();
                                var status = $('#statuss option:selected').val();
                                var otherDept = $('#otherDepts option:selected').val();
                                $.ajax({
                                    url:'/eduFixAssets/selEduFixAssets',
                                    type:'get',
                                    data:{
                                        assetsName:assetsName,
                                        typeId:typeId,
                                        deptId:deptId,
                                        currutLocation:currutLocation,
                                        status:status,
                                        otherDept:otherDept
                                    },
                                    dataType:'json',
                                    success:function (res) {

                                        $('#assetsNames').html('');
                                        $('#assetsNames').attr('value','');
                                        $('#assetsNames').attr('assetsId','');
                                        var data = res.obj;
                                        var id = '';
                                        var name = '';
                                        for (var i = 0; i < data.length; i++) {
                                            id += data[i]['id'] + ',';
                                            name += data[i]['assetsName'] + '，';
                                        }
                                        $('#assetsNames').html(name);
                                        $('#assetsNames').attr('value',name);
                                        $('#assetsNames').attr('assetsId',id);
                                        $.layerMsg({content: '查询成功！', icon: 1});
                                    }
                                });
                                layer.close(index);
                            }
                        });
                    });
                    /*    $.ajax({
                            type: 'get',
                            url: "/code/getCode",
                            data: {"parentNo": "PROJECT_NAME"},
                            success: function (data) {
                                $('#otherDept').html('');
                                $("#otherDept").append("<option value=''>请选择..</optionid>")
                                for (var x = 0; x < data.obj.length; x++) {
                                    $("#otherDept").append("<option value=" + data.obj[x]["codeId"] + ">" + data.obj[x]["codeName"] + "</optionid>")
                                }
                            }
                        });*/

                    //项目名称1
                    $.ajax({
                        type: 'get',
                        url: "/crashParent/selectAll",
                        success: function (res) {
                            // console.log(res)
                            $('#otherDept').html('');
                            $("#otherDept").append("<option value=''>请选择</optionid>")
                            for (var x = 0; x < res.data.length; x++) {
                                $("#otherDept").append("<option value=" + res.data[x]["crasPareId"] + ">" + res.data[x]["eventName"] + "</option>")
                            }
                        }
                    });

                    //项目名称2根据项目名称1下拉
                    $("#otherDept").change(function(){
                        var crasPareId=$(this).val()
                        $.ajax({
                            type: 'get',
                            url: "/crashParent/showCrashDispById",
                            data: {crasPareId: crasPareId},
                            success: function (res) {
                                console.log(res)
                                $('#otherDept1').html('');
                                $("#otherDept1").append("<option value=''>请选择</optionid>")
                                for (var x = 0; x < res.data.length; x++) {
                                    $("#otherDept1").append("<option value=" + res.data[x]["crasId"] + ">" + res.data[x]["eventName"] + "</option>")
                                }
                            }
                        });
                    });
                    var id = "";
                    var name = "";
                    $('.childCheck').each(function(i,v){
                        if($(this).is(':checked')){
                            name += $(this).parents('tr').find('td').eq(2).attr('title')+"，";
                            id += $(this).parents('tr').find('td').eq(1).text()+",";
                        }
                    });

                    $('#assetsNames').html(name);
                    $('#assetsNames').attr('value',name);
                    $('#assetsNames').attr('assetsId',id);
                    $('#status').append('<option value="1"><fmt:message code="event.th.notUsed" /></option>\n' +
                        '                        <option value="2"><fmt:message code="evvent.th.Use" /></option>\n' +
                        '                        <option value="3"><fmt:message code="event.th.damage" /></option>\n' +
                        '                        <option value="4"><fmt:message code="event.th.Lose" /></option>\n' +
                        '                        <option value="5"><fmt:message code="event.th.Scrap" /></option>');
                    $.ajax({
                        url:'/eduFixAssets/getFixAssetstypeName',
                        type:'json',
                        success:function (res) {
                            var data = res.object;
                            var len = data.length;
                            for (var i = 0; i < len; i++) {
                                $("#typeId").append("<option value='"+data[i]['typeId']+"'>"+data[i]['typeName']+"</option>");
                            }
                        }
                    });
                    //清空部门控件
                    $(".clearDeptId").on("click",function(){
                        $("#deptId").val("");
                        $("#deptId").attr("deptid","");
                    });

                    /* 选部门控件 */
                    $(".addDeptId").on("click",function(){
                        dept_id = "deptId";
                        $.popWindow("../../common/selectDept?0");
                    });

                    $(".addScheduler").on("click",function(){
                        user_id = "scheduler";
                        $.popWindow("../common/selectUser?0");
                    });
                    $(".clearScheduler").on("click",function(){
                        $("#scheduler").val("");
                        $("#scheduler").attr("dataid","");
                        $("#scheduler").attr("user_id","");
                        $("#scheduler").attr("userprivname","");
                    });
                },
                yes: function (index) {

                    var assetsName = $('#assetsNames').attr('assetsId');
                    var typeId = $('#typeId option:selected').val();
                    var deptId = $('#deptId').attr('deptid');
                    var currutLocation = $('#currutLocation').val();
                    var status = $('#status option:selected').val();
                    var otherDept1 = $('#client').val();
                    var scheduler=$("#scheduler").attr("user_id");
                    if($("#scheduler").val()==''){
                        $.layerMsg({content: '请填写保管人！', icon: 6});
                    } else {
                        $.ajax({
                            url:'/eduFixAssets/updateEduFixAssetsModifyById',
                            type:'get',
                            data:{
                                id:assetsName,
                                typeId:typeId,
                                deptId:deptId,
                                currutLocation:currutLocation,
                                status:status,
                                otherDept:otherDept1,
                                scheduler:scheduler
                            },
                            dataType:'json',
                            success:function (res) {
                                ajaxPage.page();
                                $.layerMsg({content: '调度成功！', icon: 1});
                            }
                        });
                        layer.close(index);
                    }

                }
            });
        }
    };

    //所在位置
    $.ajax({
        type: 'get',
        url: "/code/getCode",
        data: {"parentNo": "LOCATION_ADDRESS"},
        success: function (data) {
            $('#currrntLocation').html('');
            $("#currrntLocation").append("<option value=''>请选择..</optionid>")
            for (var x = 0; x < data.obj.length; x++) {
                $("#currrntLocation").append("<option value=" + data.obj[x]["codeNo"] + ">" + data.obj[x]["codeName"] + "</option>")
            }
        }
    });
    $(".submit").on("click",function(){
        ajaxPage.data.assetsName=$("#assetsName").val();
        ajaxPage.data.isAssets=$("#isAssets option:selected").val();
        ajaxPage.data.deptId=$('#deptment').attr('deptid');
        ajaxPage.data.currrntLocation=$("#currrntLocation").val();
        ajaxPage.data.assetsId=$("#assetsId").val();
        ajaxPage.data.page=1;
        ajaxPage.page();
    });
    function filechang() {
        $.upload($('#fileload'),function (c) {
            $.layerMsg({content:'<fmt:message code="menuSSetting.th.importSuccess" />'+c.inputSuccess+'<fmt:message code="event.th.StripData" />,<fmt:message code="event.th.fail" />'+c.inputFail+'<fmt:message code="event.th.StripData" />，<fmt:message code="event.th.FailureReason" />：'+c.faillReason+'<fmt:message code="event.th.AlreadyExists" />',icon:1})
            var file = $("#fileload");
            file.after(file.clone().val(""));
            file.remove();
        })
    }
    function equipment(type) {
        var id = "";
        var url;
        $('.childCheck').each(function(i,v){
            if (i){
                $.layerMsg({content: '请选择对应的设备！', icon: 2});
                return
            }
            if($(this).is(':checked')){
                if($(this).parents('tr').find('td').eq(1).attr('rescuetype') == type){
                    if(type == 0){
                    $.layerMsg({content: '该设备已取消应急设备！', icon: 2});
                    return false;
                    }
                    else{
                        $.layerMsg({content: '该设备已设置应急设备！', icon: 2});
                        return false
                    }
                }
                else{id += $(this).parents('tr').find('td').eq(1).text()+",";}
                $.ajax({
                    type: 'post',
                    url: "/eduFixAssets/updateDispatchAsserts",
                    data: {
                        type:type,
                        assetIds:id
                    },
                    success: function (data) {
                        $.layerMsg({content: '设置成功！', icon: 1});
                        location.reload();
                    }
                });
            }
        });


    }
</script>
</body>
</html>
