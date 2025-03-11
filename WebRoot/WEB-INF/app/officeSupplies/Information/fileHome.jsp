<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><fmt:message code="vote.th.OfficeManagement" /></title>
<style>
	html {
		height:100%;
	}
	body {
		height:100%;
	}
	.cabinet_left { 
		    width: 20%; 
		    float: left;  
		    /*overflow: auto ;*/
            overflow-x: hidden;
            overflow-y: auto;
		    height: 100%;
		    background-color: #F0F4F7;
		    border:1px solid #d9d9d9;
	}
	.cabinet_right {
		 width:79.8%;
		 height:100%;
		 border-left-width: 0px;
		 border-right-width: 0px;
		 border-top-width: 0px;
	}
    .cabinet_info{
        width:79.8%;
        height:100%;
        float: left;
    }
    .noData{
        width: 100%;
    }
    .noData .bgImg{
        width: 360px;
        height: 150px;
        margin: 100px auto;
        background-color: #357ece;
        border-radius: 10px;
        box-shadow: 3px 3px 3px #2F5C8F;
        overflow: hidden;
    }
    .noData .bgImg .IMG{
        float: left;
        width: 75px;
        height: 75px;
        margin-top: 37px;
        margin-left: 30px;
    }
    .noData .bgImg .IMG img{
        width: 100%;
    }
    .noData .bgImg .TXT{
        float: left;
        color: #fff;
        font-size: 14px;
        margin-top: 60px;
        margin-left: 20px;
    }
    .noData .bgImg .TXTa{
        color: #fff;
        font-size: 14px;
        margin-top: 60px;
        margin-left: 20px;
        text-align: center;
    }
    /*定义滚动条宽高及背景，宽高分别对应横竖滚动条的尺寸*/
    .cabinet_left ::-webkit-scrollbar{
        width: 4px;
        height: 16px;
        background-color: #f5f5f5;
    }
    /*定义滚动条的轨道，内阴影及圆角*/
    .cabinet_left ::-webkit-scrollbar-track{
        -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
        border-radius: 10px;
        background-color: #f5f5f5;
    }
    /*定义滑块，内阴影及圆角*/
    .cabinet_left ::-webkit-scrollbar-thumb{
        /*width: 10px;*/
        height: 20px;
        border-radius: 10px;
        -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
        background-color: #555;
    }
    .div_Img{
        float: left;
        width: 23px;
        height: 100%;
        margin-left: 30px;
    }
    .div_Img img{
        width: 23px;
        height: 23px;
        margin-top: 11px;
    }
    .divP{
        float: left;
        height: 40px;
        line-height: 40px;
        font-size: 22px;
        margin-left: 10px;
        color:#494d59;
    }
    .tree-title{
        color:#333;
        font-size: 14px;
    }

</style>
<link rel="stylesheet" type="text/css" href="../css/easyui/easyui.css">
<link rel="stylesheet" type="text/css" href="../css/easyui/icon.css">
<link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
<link rel="stylesheet" type="text/css" href="../css/cabinet.css?20201106.1">
<script type="text/javascript" src="../js/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
<script type="text/javascript" src="../js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../js/easyui/easyui-lang-zh_CN.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/laydate/laydate.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/jquery/jquery.form.min.js" type="text/javascript" charset="utf-8"></script>

    <style>
        input {border: none;outline: none;display: inline-block;background: #fff;}
        /*input:hover {background: #eaf2ff;padding: 5px;}*/
        .ss{margin-top:9px;position: relative;}
        .ss a{font-size: 14px;display: block;font-family: 微软雅黑;letter-spacing: 1px;position: absolute;left: 25px;top: 1px;color: #fff;}
        .one{width:90px;height: 28px;background: url("../img/file/cabinet01.png") no-repeat;}
        .one a{height: 28px;  line-height: 28px;}
        .two{width:90px;height: 28px;background: url("../img/file/cabinet02.png") no-repeat;}
        .two a{height: 28px;  line-height: 28px;}
        .three{width: 70px;height: 28px;background: url("../img/file/cabinet03.png") no-repeat;}
        .three a{height: 28px;  line-height: 26px;color:#000;left:30px;}
        .four{width: 90px;height: 28px;background: url("../img/file/cabinet04.png") no-repeat;}
        .four a{height: 28px;  line-height: 26px;color:#000;}
        .editBtn{margin-right: 10px;}
        .boto{margin-top: 8px;}
        .boto a{display:inline-block;width: 56px;height:24px;position: relative;}
        .boto a span{position:absolute;display:block;height:24px;top:0px;left:22px;line-height:24px;text-align: center;letter-spacing: 2px;}
        .boto a.ONE{background: url("../img/file/cabinet07.png") no-repeat;}
        .boto a.TWO{background: url("../img/file/cabinet09.png") no-repeat;}
        .boto a.THREE{background: url("../img/file/cabinet10.png") no-repeat;}
        .boto a.FOURs{background: url("../img/file/cabinet12.png") no-repeat;}
        .boto a.FiveOne{background: url("../img/file/cabinet11.png") no-repeat;}
        .boto a.SIX{background: url("../img/file/icon_paste.png") no-repeat;}

        .TITLE{margin-left: 10px;color: #2B7FE0;}
        .attach{margin-top: 20px;padding-left: 5px;}
        .remind,.share,.inPole{margin-top: 20px;}
        .divBtn{margin-top: 10px;width: 100%;overflow: hidden;}
        .start,.cancle{float: left;width: 50px;border:#ccc 1px solid;padding: 5px;border-radius: 5px;color:#000;margin-left: 10px;cursor: pointer;}
        .floderOperation{width:100%;}
        .selected{margin-top: 10px;width: 80px;height: 26px;position: relative;}
        .selected .doTitle{width:126px;height: 28px;line-height: 28px;cursor: pointer;background: url("../img/file/icon_setfiles_07.png") no-repeat;}

         .tree-title{
             color:#333;
             font-size: 14px;
         }
        .span_1{
            font-size: 16px;
            color: #333;
        }
        .span_2{
            margin-left: 5%;
        }
        .div_1{
            height: 40px;
            width:100%;
            font-size:16px;
            text-align: left;
            color: #333;
            cursor: pointer;
            line-height:40px;
            border-bottom: #ddd 1px solid;
        }
        .span_left{
            margin-left: 5%;
        }
        img{
            float: right;
            margin-right: 10%;
            margin-top: 5%;
        }
    </style>
</head>
<body>
<div style="height: 100%">

    <div  class="cabinet_left" style="background: #fff;">
        <div id="fileTransTop" class="div_1">
            <span class="span_left"><fmt:message code="work.th.workList" /></span>
         <img src="../img/sys/icon_rightarrow_03.png">
        </div>
        <div id="fileTransfor" style="cursor: pointer; width: 100%;border-bottom: #ddd 1px solid;line-height:40px;">
            <span class='span_2 tree-icon tree-folder' style="display: inline-block;margin-top: 10px;"></span>
            <span class="span_1"><fmt:message code="work.th.workList" /></span>
            <ul class="depository">

            </ul>
        </div>
        <div id="fileTransNews" class="div_1">
            <span class="span_left"><fmt:message code="vote.th.New" /></span>
            <img src="../img/sys/icon_rightarrow_03.png">
        </div>
        <div id="fileTransImport" class="div_1">
            <span class="span_left"><fmt:message code="vote.th.OfficeInquiries" /></span>
            <img src="../img/sys/icon_rightarrow_03.png">
        </div>
        <div id="fileTransQuery"class="div_1">
            <span class="span_left"><fmt:message code="vote.th.OfficeImport" /></span>
            <img src="../img/sys/icon_rightarrow_03.png">
        </div>
    </div>
    <div class="cabinet_info">
        <iframe class="iframe_1" src="/officeSupplies/newProduct?editFlag=0&proId=0" style="width: 100%;height: 100%;" frameborder="0">

        </iframe>
    </div>
</div>
<script>
    var type=0;
    var pro=0;
    var protypeid=0;
    var depositoryid=0;
    $(function () {
        //加载左侧树形结构（办公用品库）
        $.ajax({
            type: 'post',
            url: "/officeDepository/getAllDeposttoryTree",
            dataType: 'json',
            success: function (res) {
                var data = res.obj;
                var str = "";
                if (res.flag == true) {
                    if (data != undefined) {
                        for (var i = 0; i < data.length; i++) {
                            str += "<li class='depositoryId' depositoryId='" + data[i].id + "'>" +
                                        "<div class='tree-node' node-id='" + data[i].id + "' style='cursor: pointer'>" +
                                            "<span class='tree-hit tree-collapsed'></span>" +
                                            "<span class='tree-icon tree-folder'></span>" +
                                            "<span class='tree-title'>" + data[i].depositoryName + "</span>" +
                                        "</div>" +
                                        "<div style='margin-left: 20px;'>"+
                                            "<ul class='proType' style='display: none'>" +
                                            "</ul>" +
                                        "</div>"+
                                "</li>";
                        }
                    }
                    $('.depository').html(str);
                }
            }
        })
    })
        //点击办公用品库显示办公用品类别
        $(".depository").on('click','.depositoryId',function (e) {
            e.stopPropagation();
            var depositoryid = $(this).attr('depositoryid');
            $('.iframe_1').attr('depositoryid', depositoryid);
            var that=$(this);
            if(type==0){
                //第二层
                $.ajax({
                    type:'post',
                    url:"/officetransHistory/getDownObjects",
                    dataType:'json',
                    data:{
                        typeDepository:$(this).attr("depositoryId")
                    },
                    success:function(res) {
                        var data = res.obj;
                        var str = "";
                        if (res.flag == true) {
                            for (var i = 0; i < data.length; i++) {
                                str += "<li class='proTypeId' url='/officeSupplies/goOfficeList?typeId="+data[i].id+"' proTypeId='" + data[i].id + "'>" +
                                            "<div class='tree-node' node-id='" + data[i].id + "' style='cursor: pointer'>" +
                                                "<span class='tree-hit tree-collapsed'></span>" +
                                                "<span class='tree-icon tree-folder'></span>" +
                                                "<span class='tree-title'>" + data[i].typeName + "</span>" +
                                            "</div>" +
                                            "<div style='margin-left: 20px;'>"+
                                                "<ul class='pro' style='display: none'>" +
                                                "</ul>" +
                                            "</div>"+
                                    "</li>";
                            }
                            that.find('.proType').html(str);
                            that.find(".proType").show();
                            type=1;
                        }
                    }
                })
            }else{
                that.find(".proType").hide();
                type=0;
            }

        })

            //点击办公用品类别显示办公用品
            $(".depository").on('click','.proTypeId',function (e) {
                e.stopPropagation();
                var that=$(this);
                //第三层
                if(pro==0){
                    $.ajax({
                        type:'post',
                        url:"/officetransHistory/getDownObjects",
                        dataType:'json',
                        data:{
                            officeProductType:that.attr("proTypeId")
                        },
                        success:function(res){
                            var data=res.obj;
                            var str="";
                            if(res.flag==true){
                                if(data!=undefined){
                                    for(var i=0;i<data.length;i++){
                                        str+="<li class='proId' url='/officeSupplies/newProduct?editFlag=1&proId="+data[i].proId+"'>" +
                                                "<div class='tree-node' node-id='"+data[i].proId+"' style='cursor: pointer'>" +
                                                    "<span class='tree-hit tree-collapsed'></span>"+
                                                    "<span class='tree-icon tree-folder'></span>"+
                                                    "<span class='tree-title'>"+data[i].proName+"</span>"+
                                                "</div>" +
                                            "</li>";
                                    }
                                }
                                that.find('.pro').html(str);
                                that.find(".pro").show();
                                pro=1;
                            }
                        }
                    })
                }else{
                    that.find(".pro").hide();
                    pro=0;
                }
             })
    //点击办公用品分类显示对应的新建界面
    $(".depository").on('click','.proTypeId',function (e) {
        e.stopPropagation();
        $('.iframe_1').attr('protypeid', protypeid);
        var depositoryid =$('.iframe_1').attr('depositoryid')
        var protypeid = $(this).attr('protypeid');
        var url = $(this).attr('url');
        var urls = url+'&depositoryid='+depositoryid+'&protypeid='+protypeid+'';
        $('.iframe_1').attr('src', urls);

    })
    //点击办公用品分类显示对应的申请界面
    $(".depository").on('click','.proId',function (e) {
        e.stopPropagation();
        var url = $(this).attr('url');
        var that=$(this);
        $('.iframe_1').attr('src', url);

    })
    $('#fileTransNews').on('click',function(){
        var url= "/officeSupplies/newProduct?editFlag=0&proId=0";
        $('.iframe_1').attr('src', url);
    })
    $('#fileTransQuery').on('click',function(){
        var url= "/officeSupplies/goimport";
        $('.iframe_1').attr('src', url);
    })
    $('#fileTransImport').on('click',function(){
        var url= "/officeSupplies/goOfficeQuery";
        $('.iframe_1').attr('src', url);
    })
</script>
</body>
</html>