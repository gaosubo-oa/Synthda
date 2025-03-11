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
    <title>固定资产维修明细</title>
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
    #userDuser,#sender{
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
                固定资产维修明细
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
                    <th class="th">时间</th>
                    <th class="th">当前使用者</th>
                    <th class="th" >问题描述</th>
                    <th class="th titleOne">维修商家</th>
                    <th class="th">商家联系人</th>
                    <th class="th">商家电话</th>
                    <th class="th">商家地址</th>
                    <th class="th">送修人</th>
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
    //判断电话号码
//    function test(value) {
//        var regTel1 = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/.test(value);//带区号的固定电话
//        var regTel2 = /^(\d{7,8})(-(\d{3,}))?$/.test(value);//不带区号的固定电话
//        if (value != "") {
//            if (!regTel1 && !regTel2) {
//                $.layerMsg({content: '请输入正确手机号', icon: 2});
//                $("input[name='telephone']").val("")
//                return false;
//            }
//        }
//        else {
//            $.layerMsg({content: '请输入正确手机号', icon: 2});
//            $("input[name='telephone']").val("")
//            return false;
//        }
//
//        return true;
//    }
    //删除
    $("#tr_td").on("click",".del_btn",function () {
        var id= $(this).attr("id");
        layer.confirm('<fmt:message code="workflow.th.que" />？', {
            btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'], //按钮
            title: "<fmt:message code="event.th.DeleteAssets" />"
        }, function () {
            //确定删除，调接口
            $.ajax({
                url: '/Maintain/deleteByPrimaryKey',
                type: 'get',
                data: {
                    id: id,
                },
                dataType: 'json',
                success: function (json) {
                    if (json.flag) {
                        $.layerMsg({content: '<fmt:message code="workflow.th.delsucess" />！', icon: 1}, function () {
                            $.ajax({
                                url:"/Maintain/selectByExample",
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
                                                '<td>'+turn(data[i].user)+'</td>' +
                                                '<td>'+turn(data[i].description)+'</td>' +
                                                '<td>'+turn(data[i].business)+'</td>' +
                                                '<td>'+turn(data[i].contact)+'</td>' +
                                                '<td>'+turn(data[i].phone)+'</td>' +
                                                '<td>'+turn(data[i].address)+'</td>'+
                                                '<td>'+turn(data[i].send)+'</td>' ;
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

    layer.open({
        type: 1,
        title:['新建维修明细', 'background-color:#2b7fe0;color:#fff;'],
        area: ['600px', '500px'],
        shadeClose: true, //点击遮罩关闭
        btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
        btnAlign: 'c',
        content: '<div class="div_table" style="margin-left: 35px;margin-top: 38px;">' +
        '<div class="div_tr"><span class="fl">时间：</span><span class="right"><input type="text" style="width: 220px;" name="beginTime" class="inputTd" value="" onclick="laydate({istime: true, format: \'YYYY-MM-DD\'})" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>'+
        '<div class="div_tr"><span class="fl">当前使用者：</span><span class="inblock fl right"><div class="inPole"><input name="user" id="userDuser" user_id="" value="" disabled /><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearUser" class="clearUser "><fmt:message code="global.lang.empty" /></a></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div></span></div>'+
        '<div class="div_tr"><span class="fl">问题描述：</span><span class="right" style="display:inline-block"><textarea type="text"  rows="3" cols="20"name="question" class="inputTd" value=""  style="min-width: 300px;min-height:80px;"></textarea></span></div>'+
        '<div class="div_tr"><span class="fl">维修商家：</span><span class="right"><input type="text" style="width: 220px;" name="business" class="inputTd" value="" /></span></div>'+
        '<div class="div_tr"><span class="fl">商家联系人：</span><span class="right"><input type="text" style="width: 220px;" name="linkman" class="inputTd" value="" /></span></div>'+
        '<div class="div_tr"><span class="fl">商家电话：</span><span class="right"><input  type="tel" maxlength="11" style="width: 220px;" name="telephone" class="inputTd" value="" /></span></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>'+
        '<div class="div_tr"><span class="fl">商家地址：</span><span class="right"><input type="text" style="width: 220px;" name="address" class="inputTd" value="" /></span></div>'+
        '<div class="div_tr"><span class="fl ">送修人：</span><span class="inblock right"><div class="inPole"><input name="sender" id="sender" user_id="" value=""  disabled /><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser1" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearUser1" class="clearUser "><fmt:message code="global.lang.empty" /></a></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div></span></div>'+
        '</div>',
        yes:function(index){

            var createTime = $("input[name='beginTime']").val();//创建时间
            var user = $('#userDuser').attr('user_id');;//当前使用者
            var description = $("textarea[name='question']").val();//问题描述
            var business = $("input[name='business']").val();//维修商家
            var contact = $("input[name='linkman']").val();//商家联系人
            var phone = $("input[name='telephone']").val();//商家电话
            var address  = $("input[name='address']").val();//商家地址
            var send = $('#sender').attr('user_id');;//送修人
            if(createTime==""||user==""||send==""||phone==""){
                $.layerMsg({content: '请输入必填项', icon: 2});
            }else{

                $.ajax({
                    url: "/Maintain/insertSelective",
                    type: "post",
                    data: {
                        createTime: createTime,
                        uid:mid,
                        user: user,
                        description: description,
                        business: business,
                        contact: contact,
                        phone: phone,
                        address: address,
                        send: send
                    },
                    dataType: "json",
                    success: function (res) {

                        if (res.flag) {

                            $.layerMsg({content: '新建成功', icon: 1});
                            $.ajax({
                                url:"/Maintain/selectByExample",
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
                                                '<td>'+turn(data[i].user)+'</td>' +
                                                '<td>'+turn(data[i].description)+'</td>' +
                                                '<td>'+turn(data[i].business)+'</td>' +
                                                '<td>'+turn(data[i].contact)+'</td>' +
                                                '<td>'+turn(data[i].phone)+'</td>' +
                                                '<td>'+turn(data[i].address)+'</td>'+
                                                '<td>'+turn(data[i].send)+'</td>' ;
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
    $("#selectUser1").on("click",function(){//选人员控件
        user_id='sender';
        $.popWindow("../common/selectUser?0");
    });
    //清除数据
    $('#clearUser1').on("click",function(){ //清空人员
        $('#sender').attr('user_id','');
        $('#sender').val('');
    });
}),

//编辑维修明细
        $("#tr_td").on("click",".edit_btn",function(){
            var id= $(this).attr("id");
            $.ajax({
                url:"/Maintain/selectByPrimaryKey",
                data:{
                    id:id
                },
                type:"get",
                dataType:"json",
                success:function(obj){

                    var str="";
                    var data=obj.object;
                    layer.open({
                        type: 1,
                        title:['维修明细修改', 'background-color:#2b7fe0;color:#fff;'],
                        area: ['600px', '500px'],
                        shadeClose: true, //点击遮罩关闭
                        btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
                        btnAlign: 'c',
                        content: '<div class="div_table" style="margin-left: 35px;margin-top: 38px;">' +
                        '<div class="div_tr"><span class="fl">时间：</span><span class="right"><input type="text" style="width: 220px;" name="beginTime" class="inputTd" value="'+turn(data.createTime)+'" onclick="laydate({istime: true, format: \'YYYY-MM-DD\'})" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>'+
                        '<div class="div_tr"><span class="fl">当前使用者：</span><span class="inblock fl right"><div class="inPole"><input name="user" id="userDuser" user_id="'+turn(data.user)+'" value="'+turn(data.users)+'" disabled /><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearUser" class="clearUser "><fmt:message code="global.lang.empty" /></a><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></span></div></span></div>'+
                        '<div class="div_tr"><span class="fl">问题描述：</span><span class="right" style="display:inline-block"><textarea type="text"  rows="3" cols="20"name="question" class="inputTd" value="'+turn(data.description)+'"  style="min-width: 300px;min-height:80px;">'+turn(data.description)+'</textarea></span></div>'+
                        '<div class="div_tr"><span class="fl">维修商家：</span><span class="right"><input type="text" style="width: 220px;" name="business" class="inputTd" value="'+turn(data.business)+'" /></span></div>'+
                        '<div class="div_tr"><span class="fl">商家联系人：</span><span class="right"><input type="text" style="width: 220px;" name="linkman" class="inputTd" value="'+turn(data.contact)+'" /></span></div>'+
                        '<div class="div_tr"><span class="fl">商家电话：</span><span class="right"><input  type="tel" maxlength="11" style="width: 220px;" name="telephone" class="inputTd" value="'+turn(data.phone)+'" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>'+
                        '<div class="div_tr"><span class="fl">商家地址：</span><span class="right"><input type="text" style="width: 220px;" name="address" class="inputTd" value="'+turn(data.address)+'" /></span></div>'+
                        '<div class="div_tr"><span class="fl ">送修人：</span><span class="inblock right"><div class="inPole"><input name="sender" id="sender" user_id="'+turn(data.send)+'" value="'+turn(data.sender)+'"  disabled /><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser1" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearUser1" class="clearUser "><fmt:message code="global.lang.empty" /></a><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></span></div></span></div>'+
                        '</div>',
                        yes:function(index){

                            var createTime = $("input[name='beginTime']").val();//创建时间
                            var user = $('#userDuser').attr('user_id').replace(",","");;//当前使用者
                            var description = $("textarea[name='question']").val();//问题描述
                            var business = $("input[name='business']").val();//维修商家
                            var contact = $("input[name='linkman']").val();//商家联系人
                            var phone = $("input[name='telephone']").val();//商家电话
                            var address  = $("input[name='address']").val();//商家地址
                            var send = $('#sender').attr('user_id');;//送修人


                            if(createTime==""||user==""||send==""||phone==""){
                                $.layerMsg({content: '请输入必填项', icon: 2});
                            }else{

                                    $.ajax({
                                        url: "/Maintain/updateByPrimaryKeySelective",
                                        type: "post",
                                        data: {
                                            id:id,
                                            uid:mid,
                                            createTime: createTime,
                                            user: user,
                                            description: description,
                                            business: business,
                                            contact: contact,
                                            phone: phone,
                                            address: address,
                                            send: send
                                        },
                                        dataType: "json",
                                        success: function (res) {

                                            if (res.flag) {
                                                $.layerMsg({content: '保存成功', icon: 1});
                                                $.ajax({
                                                    url:"/Maintain/selectByExample",
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
                                                                    '<td>'+turn(data[i].user)+'</td>' +
                                                                    '<td>'+turn(data[i].description)+'</td>' +
                                                                    '<td>'+turn(data[i].business)+'</td>' +
                                                                    '<td>'+turn(data[i].contact)+'</td>' +
                                                                    '<td>'+turn(data[i].phone)+'</td>' +
                                                                    '<td>'+turn(data[i].address)+'</td>'+
                                                                    '<td>'+turn(data[i].send)+'</td>' ;
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
                                                $.layerMsg({content: '保存失败', icon: 2});
                                            }

                                        }
                                    })
                                    layer.close(index);
                                }
                        },


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
                    $("#selectUser1").on("click",function(){//选人员控件
                        user_id='sender';
                        $.popWindow("../common/selectUser?0");
                    });
                    //清除数据
                    $('#clearUser1').on("click",function(){ //清空人员
                        $('#sender').attr('user_id','');
                        $('#sender').val('');
                    });

                }
            })
        }),
  //列表查询全部//初始化

 $.ajax({
        url:"/Maintain/selectByExample",
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
                        '<td>'+turn(data[i].user)+'</td>' +
                        '<td>'+turn(data[i].description)+'</td>' +
                        '<td>'+turn(data[i].business)+'</td>' +
                        '<td>'+turn(data[i].contact)+'</td>' +
                        '<td>'+turn(data[i].phone)+'</td>' +
                        '<td>'+turn(data[i].address)+'</td>'+
                        '<td>'+turn(data[i].send)+'</td>' ;
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






    //查询
    $(".submit").on("click",function(){
        var id = $("#assetsName").val();
        $.ajax({
            url:"/Maintain/selectByPrimaryKey",
            data:{
                id:id
            },
            type:"get",
            dataType:"json",
            success:function(obj){
                $("#tr_td tbody").html("");
                var str="";
                var data=obj.object;
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
                            '<td>'+turn(data[i].user)+'</td>' +
                            '<td>'+turn(data[i].description)+'</td>' +
                            '<td>'+turn(data[i].business)+'</td>' +
                            '<td>'+turn(data[i].contact)+'</td>' +
                            '<td>'+turn(data[i].phone)+'</td>' +
                            '<td>'+turn(data[i].address)+'</td>'+
                            '<td>'+turn(data[i].send)+'</td>' ;
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
    })

</script>
</body>
</html>
