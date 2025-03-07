<%--
  Created by IntelliJ IDEA.
  User: lanqiutong
  Date: 2018/7/12
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
    <title>固定资产交接明细</title>
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <%-- <link rel="stylesheet" type="text/css" href="../css/base.css" />
     <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
     <script src="../../lib/layer/layer.js?20201106"></script>--%>

    <link rel="stylesheet" type="text/css" href="../css/news/center.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css" />
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <script src="../js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="../css/news/new_news.css"/>
    <!-- word文本编辑器 -->
    <script src="../../js/base/base.js"></script>
    <script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
</head>
<style>
    .th{
        font-size: 13pt;
        width:10%;
    }
    .remark{
        width:30%;
    }
    td{

        font-size: 11pt;
    }
    .navigation{
        margin-left: 30px;
    }
    .del_btn {
        color: #E01919;
        cursor: pointer;
    }
    .edit_btn {
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
          margin: 2% 3% 0 0;
          cursor: pointer;
      }
    .div_tr input{
        float: none;
        height: 28px;
        border: #999 1px solid;
    }
    .fl{
        float: left;
        width:100px;
    }
    .div_tr{
        overflow: hidden;
        padding:5px;
    }
    .inblock{
        display: inline-block;


    }
    .inPole{
        float: left;
        width:400px;
    }
    #userDuser,#userDept{
        width:180px;
    }
    .imgDiv{
        text-align: center;
        display: none;
        margin-top: 60px;
    }
    .cl{
        clear: both;
    }

</style>

<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
<body style="font-family: 微软雅黑;">
<div>
    <div class="navigation  clearfix">
        <div class="left">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/fixAssetsManage.png">
            <div class="news">
                固定资产交接明细
            </div>
            <div style="height:70px;line-height:70px">
                <%--<input name="assetsName" id="assetsName" class="button1 nav_type">--%>
                <%--<div id="cx" class="submit">--%>
                    <%--<fmt:message code="global.lang.query" />--%>
                <%--</div>--%>

                <%-- <div style="margin-top: 20px">
                     <form action="/eduFixAssets/inputFixAsserts" id="fileload" enctype="multipart/form-data" method ="post">
                         <input type="button" value="<fmt:message code="workflow.th.Import" />" class="exportsss"  title="导入固定资产" >&nbsp;&nbsp;
                         <input type="file" name="file" class="fileload" onchange="filechang()">
                     </form>
                 </div>--%>

            </div>
        </div>
        <div class="newClass" id="newClass">
            <span style="margin-left: 30px;">
                <img style="margin-right: 4px;margin-left: -11px;margin-bottom: -2px;" src="../../img/mywork/newbuildworjk.png" alt="">
                新建
            </span>
        </div>
        <div class="newClass" id="turn">

            <span style="margin-left: 30px;">
                <img style="margin-right: 4px;margin-left: -11px;margin-bottom: -2px;" src="../../img/mywork/newbuildworjk.png" alt="">
                返回
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
                    <%--<td class="th"><fmt:message code="notice.th.chose"/></td>--%>
                    <th class="th">领用时间</th>
                    <th class="th">领用部门</th>
                    <th class="th" >领用人</th>
                    <th class="th">是否归还</th>
                    <th class="th">归还时间</th>
                    <th class="th remark">备注</th>
                    <th class="th">操作</th>
                </tr>
                </thead>
                <tbody id="j_tb"></tbody>
            </table>
        </div>
    </div>
</div>
<script>
    var mid = $.GetRequest(window.location.href).uid;//固定资产id
    var type = $.GetRequest(window.location.href).type;//1表示上级页面为固定资产管理0上级页面固定资产查询

    //undefined转换
    function turn(data){
        if(data==undefined){
            return "";
        }else{
            return data;
        }
    }
    //返回上级页面
    $("#turn").on("click",function () {
        if(type==1) {
            window.location.href = "/eduFixAssets/fixAssetsManager";
        }else{
            window.location.href = "/eduFixAssets/fixAssetsQuery";
        }

    })

    //删除
    $("#tr_td").on("click",".del_btn",function () {
        console.log(this)
        var id= $(this).attr("id");
        layer.confirm('<fmt:message code="workflow.th.que" />？', {
            btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'], //按钮
            title: "<fmt:message code="event.th.DeleteAssets" />"
        }, function () {
            //确定删除，调接口
            $.ajax({
                url: '/Atab/deleteByPrimaryKey',
                type: 'get',
                data: {
                    id: id,
                },
                dataType: 'json',
                success: function (json) {
                    if (json.flag) {
                        $.layerMsg({content: '<fmt:message code="workflow.th.delsucess" />！', icon: 1}, function () {
                            $.ajax({
                                url:"/Atab/selectByExampleWithBLOBs",
                                type:"get",
                                data:{
                                    uid:mid
                                },
                                dataType:"json",
                                success:function(obj){
                                    $("#tr_td tbody").html("");
                                    var str="";
                                    var data=obj.obj;
                                    if(obj.flag){
                                        if(data.length==0){
                                            $(".imgDiv").css("display","block");
                                            $("#tr_td").css("display","none");

                                            return
                                        }
                                        $(".imgDiv").css("display","none");
                                        $("#tr_td").css("display","block");

                                        for(var i=0;i<data.length;i++){
                                            str+='<tr id="'+data[i].id+'">' +
                                                '<td>'+turn(data[i].createTime)+'</td>' +
                                                '<td>'+turn(data[i].depart)+'</td>' +
                                                '<td>'+turn(data[i].recipient)+'</td>' +
                                                '<td>'+turn(data[i].conditions)+'</td>' +
                                                '<td>'+turn(data[i].endtime)+'</td>' +
                                                '<td>'+turn(data[i].remarks)+'</td>';
                                            str+= '<td>' +
                                                '<a class="edit_btn" id="'+data[i].id+'"><fmt:message code="global.lang.edit" /></a>' +
                                                ' &nbsp;' +
                                                '<span class="del_btn" id="'+data[i].id+'"><fmt:message code="global.lang.delete" /></span></td>' +
                                                '</tr>';
                                        }
                                        $("#tr_td tbody").html(str);
                                    }

                                }
                            })
                        });
                    }
                }
            })
        }, function () {
            layer.closeAll();
        });
    })
    //新建
    $("#newClass").on("click",function(){

        $("#textType").change(function(){
            if (ss == "0") {
                alert("1212"+$(this).children('option:selected').val());
            } else if (ss == "1") {
                $('.endTime').attr("disabled",'disabled');
            }

        });


        layer.open({
            type: 1,
            title:['新建交接明细', 'background-color:#2b7fe0;color:#fff;'],
            area: ['600px', '500px'],
            shadeClose: true, //点击遮罩关闭
            btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
            btnAlign: 'c',
            content: '<div class="div_table" style="margin-left: 35px;margin-top: 38px;">' +
            '<div class="div_tr"><span class="fl">领用时间：</span><span class="right"><input type="text" style="width: 220px;" name="beginTime" class="inputTd" value="" onclick="laydate({istime: true, format: \'YYYY-MM-DD\'})" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>'+
            '<div class="div_tr"><span class="fl">领用部门：</span><span class="inblock fl right"><div class="inPole"><input name="dept" id="userDept" deptId="" value="" disabled ></input><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectDept" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearDept" class="clearDept "><fmt:message code="global.lang.empty" /></a></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div></span></div>' +
            '<div class="div_tr"><span class="fl">领用人：</span><span class="inblock fl right"><div class="inPole"><input name="user" id="userDuser" user_id="" value="" disabled /><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearUser" class="clearUser "><fmt:message code="global.lang.empty" /></a></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div></span></div>'+
            '<div class="div_tr"><span class="fl">是否归还：</span><span class="right" style="display:inline-block"><select name="textType" id="textType" style="width: 180px;"><option value="0" selected = "selected">是</option><option value="1">否</option></select></span></div>'+
            '<div class="div_tr"><span class="fl">归还时间：</span><span class="right"><input type="text" style="width: 220px;" name="endTime" class="endTime" value="" onclick="laydate({istime: true, format: \'YYYY-MM-DD\'})" /></div>'+
            '<div class="div_tr"><span class="fl">备注：</span><span class="right" style="display:inline-block"><textarea type="text"  rows="3" cols="20"name="remark" class="inputTd" value=""  style="min-width: 300px;min-height:80px;"></textarea></span></div>'+
            '</div>',
            yes:function(index){
                var createTime = $("input[name='beginTime']").val();//领用时间
                var depart = $("#userDept").attr("deptId");//领用部门
                var recipient = $("#userDuser").attr("user_id");//领用人
                var conditions = $("select[name='textType'] option:selected").val();//是否归还

                var endtime = $("input[name='endTime']").val();//归还时间
                var remarks = $("textarea[name='remark']").val();//备注
                if(createTime==""||depart==""||recipient==""){
                    $.layerMsg({content: '请输入必填项', icon: 2});
                } else if(endtime<createTime && endtime!=''){
                    $.layerMsg({content: '归还时间不可小于领用时间', icon: 2});
                }else{

                        $.ajax({
                            url: "/Atab/insertSelective ",
                            type: "post",
                            data: {
                                uid:mid,
                                createTime: createTime,
                                depart: depart,
                                recipient: recipient,
                                conditions: conditions,
                                endtime: endtime,
                                remarks: remarks
                            },
                            dataType: "json",
                            success: function (res) {
                                if (res.flag) {
                                    $.layerMsg({content: '新建成功', icon: 1});
                                    $.ajax({
                                        url:"/Atab/selectByExampleWithBLOBs",
                                        type:"get",
                                        data:{
                                            uid:mid
                                        },
                                        dataType:"json",
                                        success:function(obj){
                                            $("#tr_td tbody").html("");
                                            var str="";
                                            var data=obj.obj;
                                            if(obj.flag){
                                                if(data.length==0){
                                                    $(".imgDiv").css("display","block");
                                                    $("#tr_td").css("display","none");

                                                    return
                                                }
                                                $(".imgDiv").css("display","none");
                                                $("#tr_td").css("display","block");

                                                for(var i=0;i<data.length;i++){
                                                    str+='<tr id="'+data[i].id+'">' +
                                                        '<td>'+turn(data[i].createTime)+'</td>' +
                                                        '<td>'+turn(data[i].depart)+'</td>' +
                                                        '<td>'+turn(data[i].recipient)+'</td>' +
                                                        '<td>'+turn(data[i].conditions)+'</td>' +
                                                        '<td>'+turn(data[i].endtime)+'</td>' +
                                                        '<td>'+turn(data[i].remarks)+'</td>';
                                                    str+= '<td>' +
                                                        '<a class="edit_btn" id="'+data[i].id+'"><fmt:message code="global.lang.edit" /></a>' +
                                                        ' &nbsp;' +
                                                        '<span class="del_btn" id="'+data[i].id+'"><fmt:message code="global.lang.delete" /></span></td>' +
                                                        '</tr>';
                                                }
                                                $("#tr_td tbody").html(str);
                                            }

                                        }
                                    })

                                } else {
                                    $.layerMsg({content: '新建失败', icon: 2});
                                }

                            }
                        })
                        layer.close(index);
                    }
            },
            success:function(){

                if( $("#textType").find('option:selected').val() == 1){
                    $('.endTime').prop('disabled',true);
                }
                $("#textType").on('change',(function(){

                    var flag = $(this).find('option:selected').val();
                    if(flag == 1){
                        $('.endTime').prop('disabled',true);
                        $("input[name='endTime']").val('')
                    }else{
                        $('.endTime').prop('disabled',false);
                    }

                }));
            }


        });
        $("#selectUser").on("click",function(){//选人员控件
            user_id='userDuser';
            $.popWindow("../common/selectUser?0");
        });
        //清除数据
        $('#clearUser').on("click",function(){ //清空人员
            $('#userDuser').attr('user_id','');
            $('#userDuser').val('');
        });
        $("#selectDept").on("click",function(){//选部门控件
            dept_id='userDept';
            $.popWindow("../common/selectDept?0");
        });
        //清除数据
        $('#clearDept').on("click",function(){ //清空部门
            $('#userDept').attr('deptId','');
            $('#userDept').val('');
        });
    }),

//编辑维修明细
        $("#tr_td").on("click",".edit_btn",function(){


            var id= $(this).attr("id");
            $.ajax({
                url:"/Atab/selectByPrimaryKey",
                data:{
                    id:id
                },
                type:"get",
                dataType:"json",
                success:function(obj) {

                    var str = "";
                    var data = obj.object;
                    if (obj.flag) {



                        function yesno(data){
                            console.log(data)
                            if(data==0){
                                return '<option value="0" selected = "selected">是</option><option value="1">否</option>'
                            }else{
                                return '<option value="0">是</option><option value="1"  selected = "selected">否</option>'
                            }
                        }


                        layer.open({
                            type: 1,
                            title: ['交接明细编辑', 'background-color:#2b7fe0;color:#fff;'],
                            area: ['600px', '500px'],
                            shadeClose: true, //点击遮罩关闭
                            btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
                            btnAlign: 'c',
                            content: '<div class="div_table" style="margin-left: 35px;margin-top: 38px;">' +
                            '<div class="div_tr"><span class="fl">领用时间：</span><span class="right"><input type="text" style="width: 220px;" name="beginTime" class="inputTd" value="'+turn(data.createTime)+'" onclick="laydate({istime: true, format: \'YYYY-MM-DD\'})" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>' +
                            '<div class="div_tr"><span class="fl">领用部门：</span><span class="inblock fl right"><div class="inPole"><input name="dept" id="userDept" deptId="'+turn(data.depart)+'" value="'+turn(data.department)+'" disabled ></input><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectDept" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearDept" class="clearDept "><fmt:message code="global.lang.empty" /></a></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></span></div></span></div>' +
                            '<div class="div_tr"><span class="fl">领用人：</span><span class="inblock fl right"><div class="inPole"><input name="user" id="userDuser" user_id="'+turn(data.recipient)+'" value="'+turn(data.users)+'" disabled /><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearUser" class="clearUser "><fmt:message code="global.lang.empty" /></a></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div></span></div>' +
                            '<div class="div_tr"><span class="fl">是否归还：</span><span class="right" style="display:inline-block"><select name="textType" id="textType" style="width: 180px;">'+yesno(data.conditions)+'</select></span></div>' +
                            '<div class="div_tr"><span class="fl">归还时间：</span><span class="right"><input type="text" style="width: 220px;" name="endTime" class="endTime" value="'+turn(data.endtime)+'" onclick="laydate({istime: true, format: \'YYYY-MM-DD\'})" /></div>' +
                            '<div class="div_tr"><span class="fl">备注：</span><span class="right" style="display:inline-block"><textarea type="text"  rows="3" cols="20"name="remark" class="inputTd" value="'+turn(data.remarks)+'"  style="min-width: 300px;min-height:80px;">'+turn(data.remarks)+'</textarea></span></div>' +
                            '</div>',
                            yes: function (index) {
                                var createTime = $("input[name='beginTime']").val();//领用时间
                                var depart = $("#userDept").attr("deptId").replace(",","");//领用部门
                                var recipient = $("#userDuser").attr("user_id").replace(",","");//领用人
                                var conditions = $("select[name='textType'] option:selected").val();//是否归还
                                var endtime = $("input[name='endTime']").val();//归还时间
                                var remarks = $("textarea[name='remark']").val();//备注
                                if (createTime == "" || depart == "" || recipient == "") {
                                    $.layerMsg({content: '请输入必填项', icon: 2});
                                } else if(endtime < createTime && endtime!=''){
                                    $.layerMsg({content: '归还时间不可小于领用时间', icon: 2});
                                } else {

                                    $.ajax({
                                        url: "/Atab/updateByPrimaryKeySelective",
                                        type: "post",
                                        data: {
                                            id:id,
                                            uid:mid,
                                            createTime: createTime,
                                            depart: depart,
                                            recipient: recipient,
                                            conditions: conditions,
                                            endtime: endtime,
                                            remarks:remarks
                                        },
                                        dataType: "json",
                                        success: function (res) {

                                            if (res.flag) {
                                                $.layerMsg({content: '修改成功', icon: 1});
                                                $.ajax({
                                                    url:"/Atab/selectByExampleWithBLOBs",
                                                    type:"get",
                                                    data:{
                                                        uid:mid
                                                    },
                                                    dataType:"json",
                                                    success:function(obj){
                                                        $("#tr_td tbody").html("");
                                                        var str="";
                                                        var data=obj.obj;
                                                        if(obj.flag){
                                                            for(var i=0;i<data.length;i++){
                                                                str+='<tr id="'+data[i].id+'">' +
                                                                    '<td>'+turn(data[i].createTime)+'</td>' +
                                                                    '<td>'+turn(data[i].depart)+'</td>' +
                                                                    '<td>'+turn(data[i].recipient)+'</td>' +
                                                                    '<td>'+turn(data[i].conditions)+'</td>' +
                                                                    '<td>'+turn(data[i].endtime)+'</td>' +
                                                                    '<td>'+turn(data[i].remarks)+'</td>';
                                                                str+= '<td>' +
                                                                    '<a class="edit_btn" id="'+data[i].id+'"><fmt:message code="global.lang.edit" /></a>' +
                                                                    ' &nbsp;' +
                                                                    '<span class="del_btn" id="'+data[i].id+'"><fmt:message code="global.lang.delete" /></span></td>' +
                                                                    '</tr>';
                                                            }
                                                            $("#tr_td tbody").html(str);
                                                        }

                                                    }
                                                })

                                            } else {
                                                $.layerMsg({content: '修改失败', icon: 2});
                                            }

                                        }
                                    })
                                    layer.close(index);
                                }
                            },
                            success:function(){
                                if( $("#textType").find('option:selected').val() == 1){
                                    $('.endTime').prop('disabled',true);
                                }
                                $("#textType").on('change',(function(){

                                    var flag = $(this).find('option:selected').val();
                                    if(flag == 1){
                                        $('.endTime').prop('disabled',true);
                                        $("input[name='endTime']").val('')
                                    }else{
                                        $('.endTime').prop('disabled',false);
                                    }

                                }));
                            }


                        });
                        $("#selectUser").on("click", function () {//选人员控件
                            user_id = 'userDuser';
                            $.popWindow("../common/selectUser?0");
                        });
                        //清除数据
                        $('#clearUser').on("click",function () { //清空人员
                            $('#userDuser').attr('user_id', '');
                            $('#userDuser').val('');
                        });
                        $("#selectDept").on("click", function () {//选部门控件
                            dept_id = 'userDept';
                            $.popWindow("../common/selectDept?0");
                        });
                        //清除数据
                        $('#clearDept').on("click",function () { //清空部门
                            $('#userDept').attr('deptId', '');
                            $('#userDept').val('');
                        });
                    }
                }
            })



        }),

        //列表查询全部//初始化

        $.ajax({
            url:"/Atab/selectByExampleWithBLOBs",
            type:"get",
            data:{
                uid:mid
            },
            dataType:"json",
            success:function(obj){
                $("#tr_td tbody").html("");
                var str="";
                var data=obj.obj;
                if(obj.flag){
                    if(data.length==0){
                        $(".imgDiv").css("display","block");
                        $("#tr_td").css("display","none");

                        return
                    }
                    $(".imgDiv").css("display","none");
                    $("#tr_td").css("display","block");

                    for(var i=0;i<data.length;i++){
                        str+='<tr id="'+data[i].id+'">' +
                            '<td>'+turn(data[i].createTime)+'</td>' +
                            '<td>'+turn(data[i].depart)+'</td>' +
                            '<td>'+turn(data[i].recipient)+'</td>' +
                            '<td>'+turn(data[i].conditions)+'</td>' +
                            '<td>'+turn(data[i].endtime)+'</td>' +
                            '<td>'+turn(data[i].remarks)+'</td>';
                        str+= '<td>' +
                            '<a class="edit_btn" id="'+data[i].id+'"><fmt:message code="global.lang.edit" /></a>' +
                            ' &nbsp;' +
                            '<span class="del_btn" id="'+data[i].id+'"><fmt:message code="global.lang.delete" /></span></td>' +
                            '</tr>';
                    }
                    $("#tr_td tbody").html(str);
                }

            }
        });




    //查询
    <%--$(".submit").click(function(){--%>
        <%--var id = $("#assetsName").val();--%>
        <%--$.ajax({--%>
            <%--url:"/Atab/selectByExampleWithBLOBs",--%>
            <%--data:{--%>
                <%--id:id--%>
            <%--},--%>
            <%--type:"get",--%>
            <%--dataType:"json",--%>
            <%--success:function(obj){--%>
                <%--$("#tr_td tbody").html("");--%>
                <%--var str="";--%>
                <%--var data=obj.object;--%>
                <%--if(obj.flag){--%>
                    <%--for(var i=0;i<data.length;i++){--%>
                        <%--str+='<tr id="'+data[i].id+'">' +--%>
                            <%--'<td>'+data[i].createTime+'</td>' +--%>
                            <%--'<td>'+data[i].depart+'</td>' +--%>
                            <%--'<td>'+data[i].recipient+'</td>' +--%>
                            <%--'<td>'+data[i].conditions+'</td>' +--%>
                            <%--'<td>'+data[i].endtime+'</td>' +--%>
                            <%--'<td>'+data[i].remarks+'</td>';--%>
                        <%--str+= '<td>' +--%>
                            <%--'<a class="edit_btn" href="../../eduFixAssets/fixAssetsEdit?editFlag=1&id='+data[i].id+'"><fmt:message code="global.lang.edit" /></a>' +--%>
                            <%--' &nbsp;' +--%>
                            <%--'<span class="del_btn" id="'+data[i].id+'"><fmt:message code="global.lang.delete" /></span></td>' +--%>
                            <%--'</tr>';--%>
                    <%--}--%>
                    <%--$("#tr_td tbody").html(str);--%>
                <%--}--%>

            <%--}--%>
        <%--})--%>
    <%--})--%>

</script>
</body>
</html>
