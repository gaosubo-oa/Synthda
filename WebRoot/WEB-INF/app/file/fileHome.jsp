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
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title><fmt:message code="main.public"/></title>
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
        width:79.7%;
        height:100%;
        float: right;
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
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../js/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/easyui/easyui-lang-zh_CN.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/laydate/laydate.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/jquery/jquery.form.min.js"></script>

    <style>
        input {border: none;outline: none;display: inline-block;background: #fff;}
        /*input:hover {background: #eaf2ff;padding: 5px;}*/
        .ss{margin-top:9px;position: relative;}
        .ss a{font-size: 12px;display: block;font-family: 微软雅黑;letter-spacing: 1px;position: absolute;left: 25px;top: 1px;color: #fff;}
        .one{width:90px;height: 28px;background: url("../img/file/cabinet01.png") no-repeat;}
        .one a{height: 28px;  line-height: 28px;}
        .two{width:90px;height: 28px;background: url("../img/file/cabinet02.png") no-repeat;}
        .two a{height: 28px;  line-height: 28px;}
        .three{width: 70px;height: 28px;background: url("../img/file/cabinet03.png") no-repeat;}
        .three a{height: 28px;  line-height: 26px;color:#000;left:26px;}
        .four{width: 90px;height: 28px;background: url("../img/file/cabinet04.png") no-repeat;}
        .four a{height: 28px;  line-height: 26px;color:#000;}
        .editBtn{margin-right: 10px;}
        .boto{margin-top: 8px;}
        .boto a{display:inline-block;width: 56px;height:24px;position: relative;}
        .boto a span{position:absolute;display:block;height:24px;top:0px;left:22px;line-height:24px;text-align: center;letter-spacing: 0px;}
        .boto a.ONE{background: url("../img/file/cabinet07.png") no-repeat;}
        .boto a.TWO{background: url("../img/file/cabinet09.png") no-repeat;}
        .boto a.THREE{background: url("../img/file/cabinet10.png") no-repeat;}
        .boto a.FOURs{background: url("../img/file/cabinet12.png") no-repeat;}
        .boto a.FiveOne{background: url("../img/file/cabinet11.png") no-repeat;}
        .boto a.SIX{background: url("../img/file/icon_paste.png") no-repeat;}

        .TITLE{margin-left: 10px;color: #2B7FE0;}
        .attach{margin-top: 20px;padding-left: 5px;}
        .remind,.share,.inPole{margin-top: 5px;}
        .divBtns{margin-top: 10px;width: 100%;overflow: hidden;}
        .start,.cancle{float: left;width: 50px;border:#ccc 1px solid;padding: 5px;border-radius: 5px;color:#000;margin-left: 10px;cursor: pointer;}
        .floderOperation{width:100%;}
        .selected{margin-top: 10px;width: 80px;height: 26px;position: relative;}
        .selected .doTitle{width:135px;height: 28px;line-height: 28px;cursor: pointer;background: url("../img/file/icon_setfiles_07.png") no-repeat;}

         .tree-title{
             color:#333;
             font-size: 14px;
         }

    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
<script type="text/javascript">
    var user_id='userDuser';
    var ireaeders;
    var editdatas;
$(function(){
    reloadTree();
    var Height=$('body').height()-2;
    $('.cabinet_left').height(Height);
    //新建文件
    $('#contentAdd').click(function(){
        var sortId=$('input[name="folderId"]').val();
        var sortText=$('input[name="sortTxt"]').val();
        $.popWindow('${pageContext.request.contextPath }/file/contentAdd?sortId='+sortId+'&text='+encodeURI(sortText),'<fmt:message code="global.lang.new"/>','100','300','1200px','600px');
    })
    //全选点击事件
    $('#checkedAll').click(function(){
        var state =$(this).prop("checked");
        if(state==true){
            $(this).prop("checked",true);
            $(".checkChild").prop("checked",true);
            $(".contentTr").addClass('bgcolor');
        }else{
            $(this).prop("checked",false);
            $(".checkChild").prop("checked",false);;
            $('.contentTr').removeClass('bgcolor');
        }
    })
    $('#checkedAlls').click(function(){
        var state =$(this).prop("checked");
        if(state==true){
            $(this).prop("checked",true);
            $(".checkChildren").prop("checked",true);
            $(".contentTrs").addClass('bgcolor');
        }else{
            $(this).prop("checked",false);
            $(".checkChildren").prop("checked",false);;
            $('.contentTrs').removeClass('bgcolor');
        }
    })
    $('#checkedAllY').click(function(){
        var state =$(this).prop("checked");
        if(state==true){
            $(this).prop("checked",true);
            $(".checkChildren").prop("checked",true);
            $(".contentT").addClass('bgcolor');
        }else{
            $(this).prop("checked",false);
            $(".checkChildren").prop("checked",false);;
            $('.contentT').removeClass('bgcolor');
        }
    })
    //删除点击事件
    $('.FOURs').click(function(){
        //var TYPE=$('.w .trBtn').attr('TYPE');
        var id=$('.w .contentTr').attr('sortId');
        var idea=$('input[name="folderId"]').attr('ireader');
        var fileId=[];
        $(".checkChild:checkbox:checked").each(function(){
            var conId=$(this).attr("conId")
            fileId.push(conId);
        })
        if(fileId == ''){
            $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
        }else{
            dataDelete(fileId,id,idea)
        }
    })
    //查询列表删除事件
    $('#queryDelete').click(function(){
        var sortId=$('.w .contentTr').attr('sortId');
        var userId=$('#userDuser').attr('user_id');
        var fileId=[];
        $(".checkChildren:checkbox:checked").each(function(){
            var conId=$(this).attr("conId")
            fileId.push(conId);
        })
        if(fileId == ''){
            $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
        }else{
            $('.details').show().siblings().hide();
            dataDeleteOne(fileId,sortId,userId)
        }
    })
    //全局搜索列表删除事件
    $('#deleteAll').click(function(){
        var userId=$('#userDuser').attr('user_id');
        var fileId=[];
        $(".checkChildren:checkbox:checked").each(function(){
            var conId=$(this).attr("conId")
            fileId.push(conId);
        })
        if(fileId == ''){
            $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
        }else{
            $('.queryDetail').show().siblings().hide();
            dataDeleteAll(fileId,userId)
        }
    })
    //文件详情点击事件
    $('.wenfile').on('click','.TITLE',function(){
        var idT=$(this).parents('tr').attr('contentId');
        var sortId=$(this).parents('tr').attr('sortId');
        var deleteNum=$('input[name="deleteQuanxian"]').val();
        var exportNum=$('input[name="exportQuanxian"]').val();
        var editNum=$('input[name="editQuanxian"]').val();
        $.popWindow('/file/toFileDetails?contentId='+idT+'&sortId='+sortId+'&deleteNum='+deleteNum+'&exportNum='+exportNum+'&editNum='+editNum,'<fmt:message code="file.th.detail"/>','100','300','800px','500px');
    })
    //编辑点击事件
    $('.w').on('click','.editBtn',function(){
        var idT=$(this).parents('tr').attr('contentId');
        var sortId=$(this).parents('tr').attr('sortId');
        var contype=$(this).parents('tr').attr('conType');
        var idea=$('input[name="folderId"]').attr('ireader');
        $.popWindow('/file/contentAdd?contentId='+idT+'&sortId='+sortId+'&contype='+contype+'&idea='+idea,'<fmt:message code="global.lang.edit"/>','0','0','1200px','600px');
    })
    //签阅情况点击事件
    $('.wenfile').on('click','.signReading',function(){
        var idT=$(this).parents('tr').attr('contentId');
        $.popWindow('/file/signReading?contentId='+idT,'<fmt:message code="global.lang.edit"/>','50','100','1200px','600px');
    })

    //弹出一个页面层，查询点击事件
    $('.SEARCH').on('click', function(event){
        event.stopPropagation();
        var sortId=$('.contentTr').attr('sortId');
        var idea=$('input[name="folderId"]').attr('ireader');
        layer.open({
            type: 1,
            title:['<fmt:message code="global.lang.query"/>', 'background-color:#2b7fe0;color:#fff;'],
            area: ['700px', '460px'],
            shadeClose: true, //点击遮罩关闭
            btn: ['<fmt:message code="global.lang.query"/>', '<fmt:message code="global.lang.close"/>'],
            content: '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 98%;">' +
            '<tr><td><fmt:message code="file.th.TitleContainsText"/>：</td><td><input type="text" style="width: 150px;" name="subjectName" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.Sort"/>：</td><td><input type="text" style="width: 150px;" name="contentNo" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.builder"/>：</td><td><div class="inPole"><textarea name="txt" id="userDuser" user_id="id" value="admin" disabled style="min-width: 300px;min-height:50px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add"/></a></span></div></td></tr>'+
            '<tr><td><fmt:message code="file.th.Keywords1"/>：</td><td><input type="text" style="width: 150px;" name="contentValue1" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.keyword2"/>：</td><td><input type="text" style="width: 150px;" name="contentValue2" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.keyword3"/>：</td><td><input type="text" style="width: 150px;" name="contentValue3" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.text"/>：</td><td><input type="text" style="width: 150px;" name="atiachmentDesc" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.fileName"/>：</td><td><input type="text" style="width: 150px;" name="atiachmentName" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.containsText"/>：</td><td><input type="text" style="width: 150px;" name="atiachmentCont" class="inputTd" value="" /><span style="margin-left: 10px;color:#999;font-size:9pt;"><fmt:message code="file.th.Only"/></span></td></tr>'+
            '<tr><td><fmt:message code="global.lang.date"/>：</td><td><input type="text" style="width: 150px;" name="crStartDate" id="start" class="inputTd" value="" onclick="laydate(start)" /><span style="font-size:9pt;margin:0 5px;"><fmt:message code="global.lang.to"/></span><input type="text" style="width: 150px;" name="crEndDate" id="end" class="inputTd" value="" onclick="laydate(end)" /></td></tr>'+
            '</table>',
            yes:function(index){
                var userId=$('#userDuser').attr('user_id');
                if(userId=='id'){
                    userId='';
                }
                queryOneData(sortId,userId,idea);
                layer.close(index);
                $('.mainContent').hide();
                $('.details').show();
            },
        });
        $('#selectUser').click(function(){
            user_id='userDuser';
            $.popWindow("../common/selectUser");
        })

    });

    //点击全局搜索按钮
    $('#overall').on('click', function(event){
        event.stopPropagation();
        var sortId=$('.contentTr').attr('sortId');
        layer.open({
            type: 1,
            title:['<fmt:message code="Email.th.global"/>', 'background-color:#2b7fe0;color:#fff;'],
            area: ['600px', '460px'],
            shadeClose: true, //点击遮罩关闭
            btn: ['<fmt:message code="global.lang.query"/>', '<fmt:message code="global.lang.close"/>'],
            content: '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 94%;">' +
            '<tr><td><fmt:message code="file.th.TitleContainsText"/>：</td><td><input type="text" style="width: 150px;" name="subject" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.Sort"/>：</td><td><input type="text" style="width: 150px;" name="sort_no" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.builder"/>：</td><td><div class="inPole"><textarea name="txt" id="userDuser" user_id="id" value="admin" disabled style="min-width: 300px;min-height:50px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add"/></a></span></div></td></tr>'+
            '<tr><td><fmt:message code="file.th.Keywords1"/>：</td><td><input type="text" style="width: 150px;" name="keyword1" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.keyword2"/>：</td><td><input type="text" style="width: 150px;" name="keyword2" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.keyword3"/>：</td><td><input type="text" style="width: 150px;" name="keyword3" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.text"/>：</td><td><input type="text" style="width: 150px;" name="attScript" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.fileName"/>：</td><td><input type="text" style="width: 150px;" name="attName" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.containsText"/>：</td><td><input type="text" style="width: 150px;" name="attContain" class="inputTd" value="" /><span style="margin-left: 10px;color:#999;font-size:9pt;"><fmt:message code="file.th.Only"/></span></td></tr>'+
            '<tr><td><fmt:message code="global.lang.date"/>：</td><td><input type="text" style="width: 150px;" name="begainTime" id="start" class="inputTd" value="" onclick="laydate(start)" /><span style="font-size:9pt;margin:0 5px;"><fmt:message code="global.lang.to"/></span><input type="text" style="width: 150px;" name="endTime" id="end" class="inputTd" value="" onclick="laydate(end)" /></td></tr>'+
            '</table>',
            yes:function(index){
                var userId=$('#userDuser').attr('user_id');
                if(userId=='id'){
                    userId='';
                }
                queryAllData(userId);
                layer.close(index);
                $('.mainContent').hide();
                $('.queryDetail').show();
            },
        });
        $('#selectUser').click(function(){
            user_id='userDuser';
            $.popWindow("../common/selectUser");
        })

    });
    //数据列表返回点击事件
    $('.backBtn').click(function(){
        $('.contentTrs').remove();
        $('.mainContent').show();
        $('.details').hide();
        $('.queryDetail').hide();
        $('#noFile').hide();
    })
    var conId;
    var data={};
    //复制点击事件
    $('#copy').click(function(){
        conId=""
        conId=$('.bgcolor').attr('contentid');
        $('#copyAndShear').attr('sortId','1');
        if(conId == undefined){
            $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
        }else{
            $.layerMsg({content:'<fmt:message code="doc.th.SelectedFile"/>！',icon:1});
            $('#paste').show();
        }
     })
    //剪切点击事件
    var fileIds=[];
    $('#shear').click(function(){
        conId=$('.bgcolor').attr('contentid');
        $('#copyAndShear').attr('sortId','2');
        $(".checkChild:checkbox:checked").each(function(){
            var conId=$(this).attr("conId")
            fileIds.push(conId);
        })
        if(conId == undefined){
            $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
        }else{
            $.layerMsg({content:'<fmt:message code="doc.th.SelectedFile"/>！',icon:1});
            $('#paste').show();
        }
    })
     //粘贴点击事件
     $('#paste').click(function(){
         var tId=$('#copyAndShear').attr('sortId');
         var sortId=$('.tree-node-selected').attr('node-id');
         var idea=$('input[name="folderId"]').attr('ireader');
         if(tId == '1'){
             data={
                 'witchSortId':sortId,
                 'copyId':conId
             }
             copyData('../file/copyAndParse',data,sortId,idea);
         }else if(tId == '2'){
             data={
                 'sortId':sortId,
                 'contentId':fileIds
             }
             console.log(fileIds)
             copyData('../file/fileCut',data,sortId,idea);
         }
     })
    //签阅点击事件
    $('#singReading').click(function(){
        var contId=$('.bgcolor').attr('contentid');
        var sortId=$('.tree-node-selected').attr('node-id');
        var idea=$('input[name="folderId"]').attr('ireader');
        if(contId == undefined){
            $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
        }else {
            $.ajax({
                type:'post',
                url:'../file/getContentById',
                dataType:'json',
                data:{'contentId':contId},
                success:function(){
                    init(5,sortId,1,idea);
                }
            })
        }
    })
    //下载点击事件
//    $('.FIVE').click(function(){
//        var text=$('input[name="sortTxt"]').val();
//        var conId=$('.bgcolor').attr('contentId');
//        if(conId == undefined){
//            $.layerMsg({content:'请选择文件！',icon:1});
//        }else{
//            window.location.href='../file/downFileContent?contentId='+conId+'&sortName='+text;
//        }
//    })
    //下载点击事件
    $('.FiveOne').click(function(){
        var text=$('input[name="sortTxt"]').val();
        var fileId=[];
        $(".checkChild:checkbox:checked").each(function(){
            var conId=$(this).attr("conId");
            fileId.push(conId);
        })
        if(fileId == ''){
            $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:1});
            return false;
        }else{
            window.location.href='../file/downFileContent?contentId='+fileId+'&sortName='+text;
        }
    })
    //
    $('#TitleOne').click(function(e){
        e.stopPropagation();
        var pid=$('input[name="paid"]').val();
        $('#classA').toggle();
        if(pid == 0){
            $('.second').hide();
        }else{
            $('.second').show();
        }
    })
    $(document).on('click',function(){
        if($('#classA').css('display')=='block'){
            $('#classA').css('display','none');
        }
    })
    //新建子文件夹页面显示
    $('#newChild').click(function(){
        $('.newAddFolder').show().siblings().hide();
    })
    //新建子文件夹页面确定按钮
    $('#btnSure').click(function(){
        var sortParent=$('input[name="folderId"]').val();
        var idea=$('input[name="folderId"]').attr('ireader');
        var editData=$('input[name="folderId"]').attr('editdata');
        var data={
            'sortType':5,
            'sortParent':sortParent,
            'sortNo':$('input[name="serial"]').val(),
            'sortName':$('input[name="polderName"]').val()
        }
        if($('input[name="serial"]').val() == '' || $('input[name="polderName"]').val() == ''){
            $.layerMsg({content:'<fmt:message code="doc.th.sortNumber"/>！',icon:2});
            return false;
        }
        if (isNaN($('input[name="serial"]').val())) {
            $.layerMsg({content:'<fmt:message code="doc.th.number"/>！',icon:2});
            $('input[name="serial"]').focus();
            return false;
        }
        $.ajax({
            type:'post',
            url:'../file/add',
            dataType:'json',
            data:data,
            success:function(res){
                if(res==1){
                    $.layerMsg({content:'<fmt:message code="depatement.th.Newsuccessfully"/>！',icon:1},function(){
                        $('input[name="serial"]').val('');
                        $('input[name="polderName"]').val('');
                        $('.mainContent').show();
                        $('.newAddFolder').hide();
                        init(5,sortParent,1,idea,editData);
                        reloadTree();
                    });
                }else {
                    $.layerMsg({content:'<fmt:message code="depatement.th.Newfailed"/>！',icon:2},function(){
                        console.log('<fmt:message code="depatement.th.Newfailed"/>');
                    });
                }
            }
        })
    })

    /*------------------------------------------------------------------*/
    //查询列表删除
    function dataDeleteOne(fileId,sortId,id){
        layer.confirm('<fmt:message code="sup.th.Delete"/>？', {
            btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'], //按钮
            title:"<fmt:message code="notice.th.DeleteFile"/>"
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'post',
                url:'${pageContext.request.contextPath }/file/batchDeleteConId',
                dataType:'json',
                data:{'fileId':fileId},
                success:function(){
                    layer.msg('<fmt:message code="workflow.th.delsucess"/>', { icon:6});
                    queryOneData(sortId,id);
                }
            })

        }, function(){
            layer.closeAll();
        });
    }
    //查询列表方法
    function queryOneData(sortId,id,iReder){
        var data={
            'sortId':sortId,
            'pageNo':0,
            'pageSize':10,
            'subjectName':$('input[name="subjectName"]').val(),
            'contentNo':$('input[name="contentNo"]').val(),
            'creater':id,
            'contentValue1':$('input[name="contentValue1"]').val(),
            'contentValue2':$('input[name="contentValue2"]').val(),
            'contentValue3':$('input[name="contentValue3"]').val(),
            'atiachmentDesc':$('input[name="atiachmentDesc"]').val(),
            'atiachmentName':$('input[name="atiachmentName"]').val(),
            'atiachmentCont':$('input[name="atiachmentCont"]').val(),
            'crStartDate':$('input[name="crStartDate"]').val(),
            'crEndDate':$('input[name="crEndDate"]').val(),
            'sortType':'5'
        }
        $.ajax({
            type:'post',
            url:'../file/queryBySearchValue',
            dataType:'json',
            data:data,
            success:function(res){
                $('#file_Tachrs').find('tr').remove();
                var data1=res.datas;
                var str = '';
                var files = '';
                var downUser=$('input[name="down-user"]').val();
                for(var i=0;i<data1.length;i++){

                    if(data1[i].attachmentList!=''){
                        var arr=data1[i].attachmentList;
                        var str1='';
                        for(var j=0;j<arr.length;j++){
                            if(downUser == '1'){
                                str1+='<a href="/download?'+encodeURI(arr[j].attUrl)+'" style="display:block;width:170px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;" title="'+arr[j].attachName+'"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+arr[j].attachName+'</a>';
                            }else{
                                str1+='<a href="javascript:;" style="display:block;color:#000;width:170px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;" title="'+arr[j].attachName+'"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+arr[j].attachName+'</a>';
                            }
                        }
                        str+="  <tr class='contentTrs' sortId='"+data1[i].sortId+"' contentId='"+data1[i].contentId+"' conType='2'><td><input class='checkChildren' type='checkbox' conId='"+data1[i].contentId+"' name='check' value='' > <a class='TITLE' style='color:#54b6fe;' href='javascript:;'>"+data1[i].subject+ "  </a></td>  <td>"+str1+"</td> <td> "+data1[i].sendTime+ "  </td><td> "+data1[i].contentNo+ "  </td><td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a>";
                        if(iReder == '1'){
                            str+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"
                        }
                        str+="</td></tr>"
                    }else{
                        str+="  <tr class='contentTrs' sortId='"+data1[i].sortId+"' contentId='"+data1[i].contentId+"' conType='2'><td><input class='checkChildren' type='checkbox' conId='"+data1[i].contentId+"' name='check' value='' > <a class='TITLE' style='color:#54b6fe;' href='javascript:;'>"+data1[i].subject+ "  </a></td>  <td></td> <td> "+data1[i].sendTime+ "  </td><td> "+data1[i].contentNo+ "  </td><td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a>";
                        if(iReder == '1'){
                            str+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"
                        }
                        str+="</td></tr>"
                    }
                }
                $('#file_Tachrs').append(str);
                $(".contentTrs").click(function () {
                    var state=$(this).find('.checkChildren').prop("checked");
                    if(state==true){
                        $(this).find('.checkChildren').prop("checked",true);
                        $(this).addClass('bgcolor');
                    }else{
                        $('#checkedAlls').prop("checked",false);
                        $(this).find('.checkChildren').prop("checked",false);
                        $(this).removeClass('bgcolor');
                    }
                    var child =   $(".checkChildren");
                    for(var i=0;i<child.length;i++){
                        var childstate= $(child[i]).prop("checked");
                        if(state!=childstate){
                            return
                        }
                    }
                    $('#checkedAlls').prop("checked",state);
                })

                $('#checkedAlls').prop("checked",false);
            }
        })
    }
    /*-----------------------------------------------------------------------------------*/
    //全局搜索删除列表
    function dataDeleteAll(fileId,id){
        layer.confirm('<fmt:message code="sup.th.Delete"/>？', {
            btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'], //按钮
            title:"<fmt:message code="notice.th.DeleteFile"/>"
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'post',
                url:'${pageContext.request.contextPath }/file/batchDeleteConId',
                dataType:'json',
                data:{'fileId':fileId},
                success:function(){
                    layer.msg('<fmt:message code="workflow.th.delsucess"/>', { icon:6});
                    queryAllData(id);
                }
            })

        }, function(){
            layer.closeAll();
        });

    }
    //全局搜索列表方法
    function queryAllData(id){
        var data={
            'serachType':'2',
            'subject':$('input[name="subject"]').val(),
            'sort_no':$('input[name="sort_no"]').val(),
            'creater':id,
            'keyword1':$('input[name="keyword1"]').val(),
            'keyword2':$('input[name="keyword2"]').val(),
            'keyword3':$('input[name="keyword3"]').val(),
            'attScript':$('input[name="attScript"]').val(),
            'attName':$('input[name="attName"]').val(),
            'attContain':$('input[name="attContain"]').val(),
            'begainTime':$('input[name="begainTime"]').val(),
            'endTime':$('input[name="endTime"]').val(),
        }
        $.ajax({
            type:'post',
            url:'../file/serachAll',
            dataType:'json',
            data:data,
            success:function(res){
                $('#file_Tach').find('tr').remove();
                var data1=res.obj;
                var str='';
                var arr=new Array();
                for(var i=0;i<data1.length;i++){
                    var stra='';
                    arr=data1[i].attachmentList;
                    if(data1[i].attachmentName!=''){
                        for(var j=0;j<arr.length;j++){
                            stra+='<a href="/download?'+encodeURI(arr[j].attUrl)+'" style="display:block;"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+arr[j].attachName+'</a>';
                        }
                        str+='<tr class="contentT" contentId="'+data1[i].contentId+'" conType="3"><td><input class="checkChildren" conId="'+data1[i].contentId+'" type="checkbox" name="check" value="" style="margin-right:15px;" >'+data1[i].filePath+'</td><td><a class="TITLE" href="javascript:;" style="color:#54b6fe;margin-left:0;">'+data1[i].subject+'</a></td><td>'+stra+'</td><td>'+function () {
                                if(data1[i].attachmentDesc != undefined){
                                    return data1[i].attachmentDesc;
                                }else {
                                    return '';
                                }
                            }()+'</td><td>'+data1[i].sendTime+'</td><td>';
                        if(data1[i].mapPriv.MANAGE_USER == 1){
                            str+='<a href="javascript:;" class="editBtn"><fmt:message code="global.lang.edit"/></a>';
                        }
                        if(data1[i].mapPriv.SIGN_USER == 1){
                            str+='<a href="javascript:;" class="signReading"><fmt:message code="meet.th.ReadingStatus"/></a>';
                        }
                        str+='</td></tr>';
                    }else {
                        str+='<tr class="contentT" contentId="'+data1[i].contentId+'" conType="3"><td><input class="checkChildren" conId="'+data1[i].contentId+'" type="checkbox" name="check" value="" style="margin-right:15px;" >'+data1[i].filePath+'</td><td><a class="TITLE" href="javascript:;" style="color:#54b6fe;margin-left:0;">'+data1[i].subject+'</a></td><td></td><td>'+function () {
                               if(data1[i].attachmentDesc != undefined){
                                   return data1[i].attachmentDesc;
                               } else{
                                   return '';
                               }
                            }()+'</td><td>'+data1[i].sendTime+'</td><td>';
                        if(data1[i].mapPriv.MANAGE_USER == 1){
                            str+='<a href="javascript:;" class="editBtn"><fmt:message code="global.lang.edit"/></a>';
                        }
                        if(data1[i].mapPriv.SIGN_USER == 1){
                            str+='<a href="javascript:;" class="signReading"><fmt:message code="meet.th.ReadingStatus"/></a>';
                        }
                        str+='</td></tr>';
                    }
                }
                $('#file_Tach').append(str);
                $(".contentT").click(function () {
                    var state=$(this).find('.checkChildren').prop("checked");
                    if(state==true){
                        $(this).find('.checkChildren').prop("checked",true);
                        $(this).addClass('bgcolor');
                    }else{
                        $('#checkedAllY').prop("checked",false);
                        $(this).find('.checkChildren').prop("checked",false);
                        $(this).removeClass('bgcolor');
                    }
                    var child =   $(".checkChildren");
                    for(var i=0;i<child.length;i++){
                        var childstate= $(child[i]).prop("checked");
                        if(state!=childstate){
                            return
                        }
                    }
                    $('#checkedAllY').prop("checked",state);
                })

                $('#checkedAllY').prop("checked",false);
            }
        })
    }
    /*-------------------------------------------------------------------------------*/

    //新建子文件夹页面返回按钮
    $('#btnBack').click(function(){
        $('input[name="serial"]').val('');
        $('input[name="polderName"]').val('');
        $('.mainContent').show();
        $('.newAddFolder').hide();
    })
    //编辑页面显示
    $('#editFile').click(function(){
        $('.editAddFolder').show().siblings().hide();
        var sortId=$('input[name="folderId"]').val();
        $.ajax({
            type:'get',
            url:'../file/fileGetOne',
            dataType:'json',
            data:{'sortId':sortId},
            success:function(res){
                var data=res.object;
                $('input[name="edSerial"]').val('');
                $('input[name="edPolderName"]').val('');

                $('input[name="edSerial"]').val(data.sortNo);
                $('input[name="edPolderName"]').val(data.sortName);
            }
        })
    })
    //编辑页面确定按钮
    $('#editSure').click(function(){
        var sortId=$('input[name="folderId"]').val();
        var idea=$('input[name="folderId"]').attr('ireader');
        var editData=$('input[name="folderId"]').attr('editdata');
        var data={
            'sortId':sortId,
            'sortNo':$('input[name="edSerial"]').val(),
            'sortName':$('input[name="edPolderName"]').val()
        }
        $.ajax({
            type:'post',
            url:'../file/update',
            dataType:'json',
            data:data,
            success:function(res){
                if(res==1){
                    $.layerMsg({content:'<fmt:message code="depatement.th.Modifysuccessfully"/>！',icon:1},function(){
                        $('.editAddFolder').hide();
                        $('.mainContent').show();
                        init(5,sortId,1,idea,editData);
                        reloadTree();
                    });
                }else{
                    $.layerMsg({content:'<fmt:message code="depatement.th.modifyfailed"/>！',icon:2},function(){
                        console.log('<fmt:message code="depatement.th.modifyfailed"/>')
                    });
                }
            }
        })
    })
    //设置权限按钮
    $('#setting').click(function(){
        var sortId=$('.tree-node-selected').attr('node-id');
        $.popWindow('../file/temp?sortId='+sortId+'','<fmt:message code="netdisk.th.PermissionSetting"/>','0','0','1200px','600px');
    })
    //编辑页面返回按钮
    $('#editBack').click(function(){
        $('input[name="edSerial"]').val('');
        $('input[name="edPolderName"]').val('');
        $('.editAddFolder').hide();
        $('.mainContent').show();
    })
    //删除子文件夹按钮
    $('#deleteFile').click(function(){
        var sortId=$('input[name="folderId"]').val();
        var idea=$('input[name="folderId"]').attr('ireader');
        var editData=$('input[name="folderId"]').attr('editdata');
        layer.confirm('<fmt:message code="sys.th.commit"/>！', {
            btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'], //按钮
            title:"<fmt:message code="notice.th.DeleteFile"/>"
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'post',
                url:'../file/deletefileAndCon',
                dataType:'json',
                data:{'sortId':sortId},
                success:function(res){
                    if(res.flag == true){
//                        $('.details').hide();
//                        $('.newAddFolder').hide();
//                        $('.editAddFolder').hide();
//                        $('.mainContent').show();
                        layer.msg('<fmt:message code="workflow.th.delsucess"/>', { icon:6});
                        init(5,1,1,idea,editData);
                        reloadTree();
                    }else{
                        layer.msg('<fmt:message code="lang.th.deleSucess"/>', { icon:6});
                    }
                }
            });

        }, function(){
            layer.closeAll();
        });
    })
    var user_id='dePsenduser';
    $(function(){
        //选人控件
        $("#selectUserDep").on("click",function(){
            user_id='dePsenduser';
            $.popWindow("../common/selectUser");
        });
        //清空所选人员
        $('.clear').click(function(){
            $('#dePsenduser').val('');
            $('#dePsenduser').attr('user_id','');
        })

        $('#uploadinputimg').change(function(){
            var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
            var isOpera = userAgent.indexOf("Opera") > -1;
            $(".attach").show();
            if (userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera){
                //alert(111);
                var src = $(this).target || window.event.srcElement; //获取事件源，兼容chrome/IE
                var filename = src.value;
                var str = filename.substring(filename.lastIndexOf('\\') + 1);
                $('.box').append(str);
            }else{
                var arr=$(this)[0].files;
                var length = arr.length;
                var str='';
                //alert(arr);
                //alert(length);
                for(var i=0;i<arr.length;i++){
                    str+='<p>'+arr[i].name+'</p>';
                }
                $('.box').append(str);
            }

        })

        $('#start').click(function(){
            var sortId=$('[name="sortId"]').val();
            var idea=$('input[name="folderId"]').attr('ireader');
            var editData=$('input[name="folderId"]').attr('editdata');
            $('#uploadimgform').ajaxSubmit({
                dataType:'json',
                success:function (res) {
                    if(res.status == true){
                        $('.box').children().remove();
                        $('.attach').hide();
                        init(5,sortId,1,idea,editData);
                    }
                }
            })
        })

//       文件编辑
        $("#file_Tachr").on('click','.editBoxBtn',function(){
            var idT=$(this).parents('tr').attr('contentId');
            var sortId=$(this).parents('tr').attr('sortId');
            <%--$.popWindow('/file/contentAdd?contentId='+idT+'&sortId='+sortId,'编辑','100','300','860px','500px');--%>
            var contype=$(this).parents('tr').attr('conType');
            var idea=$('input[name="folderId"]').attr('ireader');
            $.popWindow('/file/contentAdd?contentId='+idT+'&sortId='+sortId+'&contype='+contype+'&idea='+idea,'<fmt:message code="global.lang.edit"/>','0','0','1200px','600px');
        })

        //全部取消点击事件
        $('.cancle').click(function(){
            $('.box').children().remove();
            $('.attach').hide();
        })
    })

    function copyData(url,data,sortId,iReader,editdatas){
//        var sortId=$('.tree-node-selected').attr('node-id');
         $.ajax({
             type:'post',
             url:url,
             dataType:'json',
             data:data,
             success:function(res){
                 if(res.flag==true){
                     $.layerMsg({content:'<fmt:message code="file.th.PasteSuccessfully"/>！',icon:1},function(){
                         init(5,sortId,1,iReader,editdatas);
                     });
                    if(contentId){
                        $('#paste').show();
                    }
                 }else{
                     $.layerMsg({content:'<fmt:message code="file.th.PasteFailed"/>！',icon:2},function(){
                         console.log(res.flag)
                     });
                 }
             }
         })
     }

    function dataDelete(fileId,id,iReader,editdatas){
        layer.confirm('<fmt:message code="sup.th.Delete"/>？', {
            btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'], //按钮
            title:"<fmt:message code="notice.th.DeleteFile"/>"
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'post',
                url:'${pageContext.request.contextPath }/file/batchDeleteConId',
                dataType:'json',
                data:{'fileId':fileId},
                success:function(){
                    layer.msg('<fmt:message code="workflow.th.delsucess"/>', { icon:6});
                    init(5,id,1,iReader,editdatas);
                }
            })

        }, function(){
            layer.closeAll();
        });

    }

    function reloadTree(){
        $("#fileTransfor").empty();
        $.ajax({
            Type: "GET",
            url: "${pageContext.request.contextPath}/file/writeTree",
            dataType:'json',
            success: function (data) {
                $("#fileTransfor").append("<ul id=\"fileTree\" class=\"easyui-tree\"data-options=\"method:'get',animate:true\" ></ul>");
                $("#fileTree").tree({
                    data : data,
                    onClick : function(node){
                        $('#noFile').hide();
                        $('.details').hide();
                        $('.queryDetail').hide();
                        $('.mainContent').show();
                        $('input[name="down-user"]').val(node.attributes.DOWN_USER);
                        if(node.attributes.DEL_USER == 1){ //删除权限
                            $('#deletebtn').show();
                            $('#deleteFile').show();
                            $('input[name="deleteQuanxian"]').val('1');
                        }else{
                            $('#deletebtn').hide();
                            $('#deleteFile').hide();
                            $('input[name="deleteQuanxian"]').val('0');
                        }
                        if(node.attributes.DOWN_USER == 1){ //下载权限
                            $('#download').show();
                            $('input[name="exportQuanxian"]').val('1');
                        }else{
                            $('#download').hide();
                            $('input[name="exportQuanxian"]').val('0');
                        }
                        if(node.attributes.NEW_USER == 1){ //新建权限
                            $('#newsAdd').show();
                            $('#newChild').show();
//                            $('#one_selected').show();
                            $('#batch').show();
//                            $('.second').hide();
                        }else{
                            $('#newsAdd').hide();
                            $('#newChild').hide();
//                            $('#one_selected').hide();
                            $('#batch').hide();
                        }
                        if(node.attributes.MANAGE_USER == 1){ //编辑权限
                            $('#editFile').show();
                            $('input[name="editQuanxian"]').val('1');
                        }else{
                            $('#editFile').hide();
                            $('input[name="editQuanxian"]').val('0');
                        }
                        if(node.attributes.USER_ID == 0){ //访问权限
                            $('#noJurisdiction').show().siblings().hide();
                        }else{
                            $('#noJurisdiction').hide();
                        }
                        init(5,node.id,1,node.attributes.SIGN_USER);
                        $('input[name="sortTxt"]').val('');
                        $('input[name="folderId"]').val('');
                        $('input[name="paid"]').val('');
                        $('input[name="sortTxt"]').val(node.text);
                        $('input[name="paid"]').val(node.attributes.pid);
                        $('input[name="folderId"]').val(node.id);
                        ireaeders=$('input[name="folderId"]').attr('iReader',node.attributes.SIGN_USER);
                        editdatas=$('input[name="folderId"]').attr('editdata',node.attributes.MANAGE_USER);
                    },
                    /*onLoadSuccess:function(node,data) {
                        defaultRenderLi(0);
                    }*/
                });
            }
        });
    }

    //获取文件夹中的文件列表
    function init(sortType,id,postType,iReder,editData){
        $('.contentTr').remove();
        $.ajax({
            type:'post',
            url:'../file/catalog',
            dataType:'json',
            data:{'sortId':id,'sortType':sortType,'postType':postType},
            success:function(data){
                var files='';
                var arr=new Array();
                var temp=0;
                var downUser=$('input[name="down-user"]').val();
                for(var i=0;i<data.length;i++){
                    var str1='';
                    arr=data[i].attachmentList;
                    var editBox='';
                    if($('input[name="editQuanxian"]').val() == '1'){
                        editBox='<a href="javascript:;" class="editBoxBtn" style="margin-left: 10px;"><fmt:message code="global.lang.edit"/></a>';
                    }else{
                        editBox='';
                    }
                   if(data[i].fileType=="file"){
                       temp++;
                       if(data[i].attachmentName!=''){
                           for(var j=0;j<arr.length;j++){
                               if(downUser == '1'){
                                   str1+='<a href="/download?'+encodeURI(arr[j].attUrl)+'" style="display:block;width:170px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;" title="'+arr[j].attachName+'"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+arr[j].attachName+'</a>';
                               }else{
                                   str1+='<a href="javascript:;" style="display:block;color:#000;width:170px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;" title="'+arr[j].attachName+'"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+arr[j].attachName+'</a>';
                               }

                           }
                           if(data[i].readers == '0'){
                               files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' conType='1'><td width='30%'><input class=\"checkChild\" type=\"checkbox\" conId='"+data[i].contentId+"' name=\"check\" value=\"\" > <img src='../img/file/icon_notread_1_03.png' style='width: 16px;height: 16px;margin-left: 10px;'><a class='TITLE' href='javascript:;' style='color:#54b6fe;'>"+data[i].subject+ "  </a></td>  <td width='20%'>"+str1+"</td> <td width='20%'> "+data[i].sendTime+ "  </td><td width='10%'> "+data[i].contentNo+ "  </td><td width='20%'>";
                               <%--if(editData == '1'){--%>
                                   <%--files+="<a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a>";--%>
                               <%--}--%>
                               if(iReder == '1'){
                                   files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"
                               }
                               files+=editBox+"</td></tr>"
                           }else{
                               files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' conType='1'><td width='30%'><input class=\"checkChild\" type=\"checkbox\" conId='"+data[i].contentId+"' name=\"check\" value=\"\" > <a class='TITLE' href='javascript:;' style='color:#54b6fe;'>"+data[i].subject+ "  </a></td>  <td width='20%'>"+str1+"</td> <td width='20%'> "+data[i].sendTime+ "  </td><td width='10%'> "+data[i].contentNo+ "  </td><td width='20%'>";
                               <%--if(editData == '1'){--%>
                                   <%--files+="<a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a>";--%>
                               <%--}--%>
                               if(iReder == '1'){
                                   files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"
                               }
                               files+=editBox+"</td></tr>"
                           }
                       }else{
                           if(data[i].readers == '0'){
                               files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' conType='1'><td width='30%'><input class=\"checkChild\" type=\"checkbox\" conId='"+data[i].contentId+"' name=\"check\" value=\"\" > <img src='../img/file/icon_notread_1_03.png' style='width: 16px;height: 16px;margin-left: 10px;'><a class='TITLE' href='javascript:;' style='color:#54b6fe;'>"+data[i].subject+ "  </a></td>  <td width='20%'><a href='javascript:;'></a></td> <td width='20%'> "+data[i].sendTime+ "  </td><td width='10%'> "+data[i].contentNo+ "  </td><td width='20%'>";
                               <%--if(editData == '1'){--%>
                                   <%--files+="<a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a>";--%>
                               <%--}--%>
                               if(iReder == '1'){
                                   files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"
                               }
                               files+=editBox+"</td></tr>"
                           }else{
                               files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' conType='1'><td width='30%'><input class=\"checkChild\" type=\"checkbox\" conId='"+data[i].contentId+"' name=\"check\" value=\"\" > <a class='TITLE' href='javascript:;' style='color:#54b6fe;'>"+data[i].subject+ "  </a></td>  <td width='20%'><a href='javascript:;'></a></td> <td width='20%'> "+data[i].sendTime+ "  </td><td width='10%'> "+data[i].contentNo+ "  </td><td width='20%'>";
                               if(editData == '1'){
                                   files+="<a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a>";
                               }
                               if(iReder == '1'){
                                   files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"
                               }
                               files+=editBox+"</td></tr>"
                           }
                       }
                    }
                }
                if(temp==0){
                    files='<tr><td colspan="5"><div style="margin: 20px 0;width: 100%;text-align: center;"><fmt:message code="file.th.noFiles"/></div></td></tr>';
                }
                $("#file_Tachr").html(files);
                $('[name="sortId"]').val(id)
                $(".contentTr").click(function () {
                    var state=$(this).find('.checkChild').prop("checked");
                    if(state==true){
                        $(this).find('.checkChild').prop("checked",true);
                        $(this).addClass('bgcolor');
                    }else{
                        $('#checkedAll').prop("checked",false);
                        $(this).find('.checkChild').prop("checked",false);
                        $(this).removeClass('bgcolor');
                    }
                    var child =   $(".checkChild");
                    for(var i=0;i<child.length;i++){
                        var childstate= $(child[i]).prop("checked");
                        if(state!=childstate){
                            return
                        }
                    }
                    $('#checkedAll').prop("checked",state);
                })

                $('#checkedAll').prop("checked",false);
            }
        });
    }
});

//时间控件调用
var start = {
    format: 'YYYY/MM/DD hh:mm:ss',
    /* min: laydate.now(), //设定最小日期为当前日期*/
    /* max: '2099-06-16 23:59:59', //最大日期*/
    istime: true,
    istoday: false,
    choose: function(datas){
        end.min = datas; //开始日选好后，重置结束日的最小日期
        end.start = datas //将结束日的初始值设定为开始日
    }
};
var end = {
    format: 'YYYY/MM/DD hh:mm:ss',
    /*min: laydate.now(),*/
    /*max: '2099-06-16 23:59:59',*/
    istime: true,
    istoday: false,
    choose: function(datas){
        start.max = datas; //结束日选好后，重置开始日的最大日期
    }
};

//正在开发中
function clicked(){
    layer.msg('<fmt:message code="lang.th.Upcoming"/>！', {icon: 6});
}
</script>
</head>
<body>
<div style="height: 100%">

    <div  class="cabinet_left">
      <!--  <div onclick="cabinet('1')" id="personal" style="width:49%;height:30px;line-height:30px;   float: left;border:1px solid #c0c0c0;text-align: center;"><fmt:message code="main.public"/></div>
       <div onclick="cabinet('2')" id="public"  style="width:49%;height:30px;line-height:30px;  float: left;border:1px solid #c0c0c0;text-align: center;"><fmt:message code="main.personnel"/></div> -->

       <div onclick="" id="personal" style="width:100%;height:44px;line-height:44px;border-bottom: #9e9e9e 1px solid;">
           <div class="div_Img">
               <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_publicFile.png" style="vertical-align: middle;" alt="">
           </div>
           <div class="divP"><fmt:message code="main.public"/></div>
        </div>
      <%-- <div onclick="cabinet('2')" id="public"  style="width:50%;height:40px;line-height:40px;  float: left;text-align: center;"><fmt:message code="main.personnel"/></div>
      --%>
        <div id="fileTransfor" style="width:100%;">
                <%--<ul id="fileTree" class="easyui-tree" data-options="url:'writeTree',method:'get',animate:true" >--%>
				<%--</ul>--%>
        </div>
    </div>
    <div class="cabinet_info">
        <input type="hidden" name="down-user" value="">
        <div class="noData" id="noFile" style="display: block;">
            <div class="bgImg">
                <div class="IMG">
                    <img src="../img/sys/icon64_info.png"/>
                </div>
                <div class="TXT"><fmt:message code="Email.th.PleaseSelect"/></div>
            </div>
        </div>
        <div class="noData" id="noJurisdiction" style="display: none;">
            <div class="bgImg">
                <div class="IMG">
                    <img src="../img/sys/icon64_info.png"/>
                </div>
                <div class="TXTa"><fmt:message code="file.th.NotPermission"/>！</div>
            </div>
        </div>
        <div class="mainContent" style="display:none;">
            <input type="hidden" name="editQuanxian" value="">
            <input type="hidden" name="exportQuanxian" value="">
            <input type="hidden" name="deleteQuanxian" value="">
            <div class="head w clearfix">
                <input type="hidden" name="paid" id="paid" value="">
                <div class="ss one" id="newsAdd" style="border-radius: 3px;"><img style="margin-right: -26px;margin-left: 7px;margin-bottom: 2px;margin-top: 7px;" src="../../img/mywork/newbuildworjk.png" alt=""> <a id="contentAdd" href="javascript:;"><fmt:message code="file.th.newfile"/></a></div>
                <div id="batch" class="ss two" style="position: relative">
                    <form id="uploadimgform" target="uploadiframe"  action="../file/fileBoxUpload" enctype="multipart/form-data" method="post" >
                        <input type="hidden" name="sortId">
                        <input type="file" name="file" id="uploadinputimg" multiple="multiple" class="w-icon5"
                               style="position: absolute;z-index: 99999;width: 89px;opacity:0;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                        <a href="#" id="uploadimg"><fmt:message code="notice.th.up"/></a>
                    </form>
                </div>
                <div id="SEARCH" class="ss three"> <a  class="SEARCH" href="javascript:;"><fmt:message code="global.lang.query"/></a></div>
                <div id="overall" class="ss four"> <a href="javascript:;"><fmt:message code="Email.th.global"/></a></div>
                <div class="selected" id="one_selected" style="display: block;">
                    <div id="TitleOne" class="doTitle"><span style="margin-left: 28px;"><fmt:message code="file.th.op"/></span></div>
                    <div id="classA" class="hideDiv" style="display: none;">
                        <ul>
                            <li id="newChild"><fmt:message code="file.th.newf"/></li>
                            <li id="setting"><fmt:message code="roleAuthorization.th.SetPermissions"/></li>
                        </ul>
                        <ul class="second">
                            <li id="deleteFile"><fmt:message code="flie.th.dele"/></li>
                            <li id="editFile"><fmt:message code="global.lang.edit"/></li>
                        </ul>
                    </div>
                </div>
                <%--<div class="selected" id="two_selected" style="display: none;">
                    &lt;%&ndash;<select id="fileDone">
                        <option value="0">文件夹操作</option>
                        <option value="1">新建子文件夹</option>
                        <option value="2">设置权限</option>
                        <option value="3">编辑</option>
                        <option value="4">删除</option>
                    </select>&ndash;%&gt;
                        <div id="TitleTwo" class="doTitle">文件夹操作</div>
                        <div id="second" class="hideDiv" style="display: none;">
                            <ul>
                                <li id="">新建子文件夹</li>
                                <li>设置权限</li>
                                <li>删除目录</li>
                                <li>编辑</li>
                            </ul>
                        </div>
                </div>--%>
            </div>
            <!--middle部分开始-->
            <div class="w" style="margin-top: 10px;">
                <div class="wrap">
                    <input type="hidden" name="sortTxt" value="">
                    <input type="hidden" name="folderId" value="">
                    <table class="w wenfile">
                        <thead>
                        <tr>
                            <td class="th"><fmt:message code="file.th.name"/></td>
                            <td class="th"><fmt:message code="email.th.file"/></td>
                            <td class="th" style="">
                                <fmt:message code="notice.th.PostedTime"/>
                                <%--<img style="position: absolute;margin-left:9px;cursor: pointer;" src="../img/file/cabinet05.png" alt=""/>--%>
                                <%--<img style="position: absolute;margin-top:10px;margin-left:9px;cursor: pointer;" src="../img/file/cabinet06.png " alt=""/>--%>
                            </td>
                            <td class="th" style="">
                                <fmt:message code="file.th.Sort"/>
                                <%--<img style="position: absolute;margin-left:9px;cursor: pointer;" src="../img/file/cabinet05.png" alt=""/>--%>
                                <%--<img style="position: absolute;margin-top:10px;margin-left:9px;cursor: pointer;" src="../img/file/cabinet06.png " alt=""/>--%>
                            </td>
                            <td class="th" id="hiddenTd" style="display: block;"><fmt:message code="notice.th.operation"/></td>
                        </tr>
                        </thead>
                        <tbody id="file_Tachr">
                        </tbody>
                    </table>
                </div>
            </div>
            <!--bottom 部分开始-->
            <div class="bottom w">
                <input type="hidden" name="" id="copyAndShear" sortId="">
                <div class="checkALL">
                    <input id="checkedAll" type="checkbox" name="" value="" >
                    <label for="checkedAll"><fmt:message code="notice.th.allchose"/></label>
                </div>
                <div class="boto" id="singReading">
                    <a class="ONE" href="javascript:;"><span><fmt:message code="file.th.SignReading"/></span></a>
                </div>
                <div class="boto" id="copy">
                    <a class="TWO" href="javascript:;"><span><fmt:message code="file.th.copy"/></span></a>
                </div>
                <div class="boto" id="shear">
                    <a class="THREE" href="javascript:;"><span><fmt:message code="file.th.cut"/></span></a>
                </div>
                <div class="boto" id="paste" style="display: none;">
                    <a class="SIX" href="javascript:;"><span><fmt:message code="fille.th.paste"/></span></a>
                </div>
                <div class="boto" id="deletebtn">
                    <a class="FOURs" href="javascript:;"><span><fmt:message code="global.lang.delete"/></span></a>
                </div>
                <%--<div class="boto" id="download">--%>
                    <%--<a class="FiveOne" href="javascript:;"><span><fmt:message code="file.th.download"/></span></a>--%>
                <%--</div>--%>

            </div>
            <%--<div class="floderOperation" style="display: block;">
                <input type="hidden" name="folderId" value="">
                <div class="childFolders" style="display: block;">
                    <div class="operation">文件夹操作：</div>
                    <div class="newChildFolder">
                        <a id="newChildFolders" href="javascript:;"><span>新建子文件夹</span></a>
                    </div>
                </div>
                <div class="childFolder" style="display: none;">
                    <div class="operation">文件夹操作：</div>
                    <div class="newChildFolder">
                        <a id="newChildFolder" href="javascript:;"><span>新建子文件夹</span></a>
                    </div>
                    <div class="editFolder">
                        <a id="editFolder" href="javascript:;"><span>编辑</span></a>
                    </div>
                    <div class="deleteFolder">
                        <a id="deleteFolder" href="javascript:;"><span>删除目录</span></a>
                    </div>
                </div>
            </div>--%>
            <div class="attach" style="display: none;">
                <div class="box" id="fileName"></div>
                <%--<div class="remind">
                    <p>事务提醒：</p>
                    <input type="radio" name="remindUser" value="">
                    <span>手动选择被提醒人员</span>
                    <input type="radio" name="remindUser" value="">
                    <span>提醒全部有权限人员</span>
                </div>
                <div class="inPole">
                    <textarea name="txt" id="dePsenduser" user_id='' value="" disabled style="min-width: 200px;min-height: 50px;"></textarea>
                    <span class="add_img" style="margin-left: 10px">
                        <a href="javascript:;" id="selectUserDep" class="Add " style="color:#207bd6;">添加</a>
                    </span>
                    <span class="add_img">
						<a href="javascript:;" class="clear" style="color:#207bd6;">清除</a>
					</span>
                </div>
                <div class="share">
                    <input type="checkbox" name="share" value="">
                    <span>分享到企业社区</span>
                </div>--%>
                <div class="divBtns">
                    <div class="start" id="start"><fmt:message code="file.th.StartUploading"/></div>
                    <div class="cancle"><fmt:message code="file.th.cancelAll"/></div>
                </div>
            </div>
        </div>
        <div class="details" style="display:none;width: 95%;margin: 0 auto; margin-top: 10px;">
            <div class="w">
                <div class="wrap">
                    <table class="w">
                        <thead>
                        <tr>
                            <td class="th"><fmt:message code="file.th.name"/></td>
                            <td class="th"><fmt:message code="email.th.file"/></td>
                            <td class="th" style="">
                                <fmt:message code="notice.th.PostedTime"/>
                                <%--<img style="position: absolute;margin-left:9px;cursor: pointer;" src="../img/file/cabinet05.png" alt=""/>--%>
                                <%--<img style="position: absolute;margin-top:10px;margin-left:9px;cursor: pointer;" src="../img/file/cabinet06.png " alt=""/>--%>
                            </td>
                            <td class="th" style="position: relative">
                                <fmt:message code="file.th.Sort"/>
                                <%--<img style="position: absolute;margin-left:9px;cursor: pointer;" src="../img/file/cabinet05.png" alt=""/>--%>
                                <%--<img style="position: absolute;margin-top:10px;margin-left:9px;cursor: pointer;" src="../img/file/cabinet06.png " alt=""/>--%>
                            </td>
                            <td class="th"><fmt:message code="notice.th.operation"/></td>
                        </tr>
                        </thead>
                        <tbody id="file_Tachrs">
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="bottom w">
                <div class="checkALL">
                    <input id="checkedAlls" type="checkbox" name="" value="" >
                    <label for="checkedAlls"><fmt:message code="notice.th.allchose"/></label>
                </div>
                <%--<div class="boto" onclick="clicked()">
                    <a class="ONE" href="javascript:;"><span>签阅</span></a>
                </div>--%>
                <%--<div class="boto">--%>
                    <%--<a class="FiveTow" href="javascript:;"><span>下载</span></a>--%>
                <%--</div>--%>
                <div class="boto">
                    <a class="queryDelete" id="queryDelete" href="javascript:;"><span><fmt:message code="global.lang.delete"/></span></a>
                </div>

            </div>
            <div class="button">
                <div class="backBtn"><span style="margin-left: 33px;"><fmt:message code="notice.th.return"/></span></div>
            </div>
        </div>
        <div class="queryDetail" style="display:none;margin-top: 10px">
            <div class="w">
                <div class="wrap">
                    <table class="w">
                        <thead>
                        <tr>
                            <td class="th"><fmt:message code="news.th.file"/></td>
                            <td class="th"><fmt:message code="file.th.name"/></td>
                            <td class="th"><fmt:message code="email.th.file"/></td>
                            <td class="th"><fmt:message code="doc.th.AppendixDescription"/></td>
                            <td class="th" style="position: relative">
                                <fmt:message code="notice.th.PostedTime"/>
                                <%--<img style="position: absolute;margin-left:9px;cursor: pointer;" src="../img/file/cabinet05.png" alt=""/>--%>
                                <%--<img style="position: absolute;margin-top:10px;margin-left:9px;cursor: pointer;" src="../img/file/cabinet06.png " alt=""/>--%>
                            </td>
                            <td class="th"><fmt:message code="notice.th.operation"/></td>
                        </tr>
                        </thead>
                        <tbody id="file_Tach">
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="bottom w">
                <div class="checkALL">
                    <input id="checkedAllY" type="checkbox" name="" value="" >
                    <label for="checkedAllY"><fmt:message code="notice.th.allchose"/></label>
                </div>
                <%--<div class="boto">--%>
                    <%--<a class="FiveTow" id="exportA" href="javascript:;"><span><fmt:message code="file.th.download"/></span></a>--%>
                <%--</div>--%>
                <div class="boto">
                    <a class="queryDelete" id="deleteAll" href="javascript:;"><span><fmt:message code="global.lang.delete"/></span></a>
                </div>
            </div>
            <div class="button">
                <div class="backBtn"><span style="margin-left: 33px;"><fmt:message code="notice.th.return"/></span></div>
            </div>
        </div>
        <div class="newAddFolder" style="display: none;">
            <div class="addHeader">
                <div class="addiv_Img">
                    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_menuSettings.png" style="vertical-align: middle;" alt="<fmt:message code="file.th.newf"/>">
                </div>
                <div class="divP"><fmt:message code="file.th.newf"/></div>
            </div>
            <table cellspacing="0" cellpadding="0" class="tab myTab" style="border-collapse:collapse;background-color: #fff">
                    <tr>
                        <td style="border-right: #ccc 1px solid;"><fmt:message code="file.th.Sort"/>：</td>
                        <td><input type="text" name="serial" value=""></td>
                    </tr>
                    <tr>
                        <td style="border-right: #ccc 1px solid;"><fmt:message code="file.th.filename"/>：</td>
                        <td><input type="text" name="polderName" value=""></td>
                    </tr>
                <tr>
                    <td colspan="2">
                        <div class="typeButton">
                            <div id="btnSure"><span style="margin-left: 32px;"><fmt:message code="global.lang.ok"/></span></div>
                            <div id="btnBack"><span style="margin-left: 32px;"><fmt:message code="notice.th.return"/></span></div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div class="editAddFolder" style="display: none;">
            <div class="addHeader">
                <div class="addiv_Img">
                    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_menuSettings.png" style="vertical-align: middle;" alt="<fmt:message code="file.th.edit"/>">
                </div>
                <div class="divP"><fmt:message code="file.th.edit"/></div>
            </div>
            <table cellspacing="0" cellpadding="0" class="tab myTab" style="border-collapse:collapse;background-color: #fff">
                <tr>
                    <th><fmt:message code="file.th.Sort"/></th>
                    <th><fmt:message code="file.th.filename"/></th>
                </tr>
                <tr>
                    <td>
                        <input type="text" name="edSerial" value="">
                    </td>
                    <td>
                        <input type="text" name="edPolderName" value="">
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="typeButton">
                            <div id="editSure"><span style="margin-left: 32px;"><fmt:message code="global.lang.ok"/></span></div>
                            <div id="editBack"><span style="margin-left: 32px;"><fmt:message code="notice.th.return"/></span></div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <%--<div style="height: 100% ;">

    </div>--%>
</div>
<script>

    <%--function parentajax(sortId) {--%>
    <%--var ajaxPage={--%>
    <%--data:{--%>
    <%--sortId:sortId,--%>
    <%--page:1,//当前处于第几页--%>
    <%--pageSize:10,//一页显示几条--%>
    <%--useFlag:true--%>
    <%--},--%>
    <%--page:function () {--%>
    <%--$('.contentTr').remove();--%>
    <%--var me=this;--%>
    <%--$.ajax({--%>
    <%--type:'post',--%>
    <%--url:'/newFileContent/getFileContentBySortId',--%>
    <%--dataType:'json',--%>
    <%--data:me.data,--%>
    <%--success:function(res){--%>
    <%--var data=res.datas;--%>
    <%--var files='';--%>
    <%--var arr=new Array();--%>
    <%--var downUser=$('input[name="down-user"]').val();--%>
    <%--var editData=$('input[name="folderId"]').attr('editdata');--%>
    <%--var idea=$('input[name="folderId"]').attr('ireader');--%>
    <%--if(data.length > 0){--%>
    <%--for(var i=0;i<data.length;i++){--%>
    <%--var str1='';--%>
    <%--arr=data[i].attachmentList;--%>
    <%--var editBox='';--%>
    <%--if($('input[name="editQuanxian"]').val() == '1'){--%>
    <%--editBox='<a href="javascript:;" class="editBoxBtn" style="margin-left: 10px;"><fmt:message code="global.lang.edit"/></a>';--%>
    <%--}else{--%>
    <%--editBox='';--%>
    <%--}--%>
    <%--if(data[i].attachmentName!=''){--%>
    <%--for(var j=0;j<arr.length;j++){--%>
    <%--if(downUser == '1'){--%>

    <%--//                                            var iconType='';--%>
    <%--//                                            if(GetFileExt(arr[j].attachName) == '.docx' || GetFileExt(arr[j].attachName) == '.doc' || GetFileExt(arr[j].attachName) == '.DOC' || GetFileExt(arr[j].attachName) == '.DOCX' || GetFileExt(arr[j].attachName) == '.word' || GetFileExt(arr[j].attachName) == '.WORD'){--%>
    <%--//                                                iconType='word';--%>
    <%--//                                            }else if(GetFileExt(arr[j].attachName) == '.pptx' || GetFileExt(arr[j].attachName) == '.ppt'){--%>
    <%--//                                                iconType='ppt';--%>
    <%--//                                            }else if(GetFileExt(arr[j].attachName) == '.xlsx' || GetFileExt(arr[j].attachName) == '.xls'){--%>
    <%--//                                                iconType='excel';--%>
    <%--//                                            }else if(GetFileExt(arr[j].attachName) == '.pdf'){--%>
    <%--//                                                iconType='pdf';--%>
    <%--////                                            iconType=GetFileExt(arr[j].attachName).replace('.', "")--%>
    <%--//                                            }else if(GetFileExt(arr[j].attachName) == '.exe'){--%>
    <%--//                                                iconType='exe';--%>
    <%--//                                            }else if(GetFileExt(arr[j].attachName) == '.jpg' || GetFileExt(arr[j].attachName) == '.png'){--%>
    <%--//                                                iconType='pic';--%>
    <%--//                                            }else if(GetFileExt(arr[j].attachName) == '.rar' || GetFileExt(arr[j].attachName) == '.zip'){--%>
    <%--//                                                iconType='zip';--%>
    <%--//                                            }else {--%>
    <%--//                                                iconType='file';--%>
    <%--//                                            }--%>
    <%--var iconType='';--%>
    <%--if(GetFileExt(arr[j].attachName) == '.docx' || GetFileExt(arr[j].attachName) == '.doc' || GetFileExt(arr[j].attachName) == '.DOC' || GetFileExt(arr[j].attachName) == '.DOCX' || GetFileExt(arr[j].attachName) == '.word' || GetFileExt(arr[j].attachName) == '.WORD'){--%>
    <%--alert('1');--%>
    <%--iconType='word';--%>
    <%--}else if(GetFileExt(arr[j].attachName) == '.pptx' || GetFileExt(arr[j].attachName) == '.ppt'){--%>
    <%--alert('2');--%>
    <%--iconType='ppt';--%>
    <%--}else if(GetFileExt(arr[j].attachName) == '.xlsx' || GetFileExt(arr[j].attachName) == '.xls'){--%>
    <%--alert('3');--%>
    <%--iconType='excel';--%>
    <%--}else if(GetFileExt(arr[j].attachName) == '.pdf'){--%>
    <%--alert('4');--%>
    <%--iconType='pdf';--%>
    <%--//                                            iconType=GetFileExt(arr[j].attachName).replace('.', "")--%>
    <%--}else if(GetFileExt(arr[j].attachName) == '.exe'){--%>
    <%--alert('5');--%>
    <%--iconType='exe';--%>
    <%--}else if(GetFileExt(arr[j].attachName) == '.jpg' || GetFileExt(arr[j].attachName) == '.png'){--%>
    <%--alert('6');--%>
    <%--iconType='pic';--%>
    <%--}else if(GetFileExt(arr[j].attachName) == '.rar' || GetFileExt(arr[j].attachName) == '.zip'){--%>
    <%--alert('7');--%>
    <%--iconType='zip';--%>
    <%--}else {--%>
    <%--alert('8');--%>
    <%--iconType='file';--%>
    <%--}--%>

    <%--str1+='<a href="/download?'+encodeURI(arr[j].attUrl)+'" class="fujian" style="display:block;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;" title="'+arr[j].attachName+'"><img style="width:18px;height:22px;margin-right:5px;" src="../img/attachmentIcon/'+iconType+'.png"/>'+arr[j].attachName+'</a>';--%>
    <%--}else{--%>
    <%--str1+='<a href="javascript:;" class="fujian" style="display:block;color:#000;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;" title="'+arr[j].attachName+'"><img style="width:18px;height:22px;margin-right:5px;" src="../img/attachmentIcon/'+iconType+'.png"/>'+arr[j].attachName+'</a>';--%>
    <%--}--%>

    <%--}--%>
    <%--if(data[i].isRead == 0){--%>
    <%--files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' conType='1'><td width='30%'><input class=\"checkChild\" style='margin-top: -10px;' type=\"checkbox\" conId='"+data[i].contentId+"' name=\"check\" value=\"\" > <img src='../img/file/icon_notread_1_03.png' style='width: 16px;height: 16px;margin-left: 10px;margin-top: -10px;'><a class='TITLE' href='javascript:;'  style='color:#54b6fe;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;'>"+data[i].subject+ "  </a></td>  <td width='20%'>"+str1+"</td> <td width='20%'> "+data[i].sendTime+ "  </td><td width='10%'> "+data[i].contentNo+ "  </td><td width='20%'>";--%>
    <%--if(idea == '1'){--%>
    <%--files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"--%>
    <%--}--%>
    <%--files+=editBox+"</td></tr>"--%>
    <%--}else{--%>
    <%--files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' conType='1'><td width='30%'><input class=\"checkChild\" style='margin-top: -10px;' type=\"checkbox\" conId='"+data[i].contentId+"' name=\"check\" value=\"\" > <a class='TITLE' href='javascript:;' style='color:#54b6fe;'>"+data[i].subject+ "  </a></td>  <td width='20%'>"+str1+"</td> <td width='20%'> "+data[i].sendTime+ "  </td><td width='10%'> "+data[i].contentNo+ "  </td><td width='20%'>";--%>
    <%--if(idea == '1'){--%>
    <%--files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"--%>
    <%--}--%>
    <%--files+=editBox+"</td></tr>"--%>
    <%--}--%>
    <%--}else{--%>
    <%--if(data[i].isRead == 0){--%>
    <%--files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' conType='1'><td width='30%'><input class=\"checkChild\" style='margin-top: -10px;' type=\"checkbox\" conId='"+data[i].contentId+"' name=\"check\" value=\"\" > <img src='../img/file/icon_notread_1_03.png' style='width: 16px;height: 16px;margin-left: 10px;margin-top: -10px;'><a class='TITLE' href='javascript:;'  style='color:#54b6fe;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;'>"+data[i].subject+ "  </a></td>  <td width='20%'><a href='javascript:;'></a></td> <td width='20%'> "+data[i].sendTime+ "  </td><td width='10%'> "+data[i].contentNo+ "  </td><td width='20%'>";--%>
    <%--if(idea == '1'){--%>
    <%--files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"--%>
    <%--}--%>
    <%--files+=editBox+"</td></tr>"--%>
    <%--}else{--%>
    <%--files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' conType='1'><td width='30%'><input class=\"checkChild\" style='margin-top: -10px;' type=\"checkbox\" conId='"+data[i].contentId+"' name=\"check\" value=\"\" > <a class='TITLE' href='javascript:;' style='color:#54b6fe;'>"+data[i].subject+ "  </a></td>  <td width='20%'><a href='javascript:;'></a></td> <td width='20%'> "+data[i].sendTime+ "  </td><td width='10%'> "+data[i].contentNo+ "  </td><td width='20%'>";--%>
    <%--if(idea == '1'){--%>
    <%--files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"--%>
    <%--}--%>
    <%--files+=editBox+"</td></tr>"--%>
    <%--}--%>
    <%--}--%>
    <%--}--%>
    <%--}else{--%>
    <%--files='<tr><td colspan="5"><div style="margin: 20px 0;width: 100%;text-align: center;"><fmt:message code="file.th.noFiles"/></div></td></tr>';--%>
    <%--}--%>
    <%--$("#file_Tachr").html(files);--%>
    <%--me.pageTwo(res.total,me.data.pageSize,me.data.page)--%>
    <%--$('[name="sortId"]').val(sortId)--%>
    <%--$(".contentTr").click(function () {--%>
    <%--var state=$(this).find('.checkChild').prop("checked");--%>
    <%--if(state==true){--%>
    <%--$(this).find('.checkChild').prop("checked",true);--%>
    <%--$(this).addClass('bgcolor');--%>
    <%--}else{--%>
    <%--$('#checkedAll').prop("checked",false);--%>
    <%--$(this).find('.checkChild').prop("checked",false);--%>
    <%--$(this).removeClass('bgcolor');--%>
    <%--}--%>
    <%--var child =   $(".checkChild");--%>
    <%--for(var i=0;i<child.length;i++){--%>
    <%--var childstate= $(child[i]).prop("checked");--%>
    <%--if(state!=childstate){--%>
    <%--return--%>
    <%--}--%>
    <%--}--%>
    <%--$('#checkedAll').prop("checked",state);--%>
    <%--})--%>

    <%--$('#checkedAll').prop("checked",false);--%>
    <%--}--%>
    <%--});--%>
    <%--},--%>
    <%--pageTwo:function (totalData, pageSize,indexs) {--%>
    <%--var mes=this;--%>
    <%--$('#dbgz_page').pagination({--%>
    <%--totalData: totalData,--%>
    <%--showData: pageSize,--%>
    <%--jump: true,--%>
    <%--coping: true,--%>
    <%--homePage:'',--%>
    <%--endPage: '',--%>
    <%--current:indexs||1,--%>
    <%--callback: function (index) {--%>
    <%--mes.data.page=index.getCurrent();--%>
    <%--mes.page();--%>
    <%--}--%>
    <%--});--%>
    <%--}--%>
    <%--}--%>
    <%--ajaxPage.page();--%>
    <%--}--%>

    function parentajax(sortId){
        $('.contentTr').remove();
        $.ajax({
            type:'post',
            url:'../file/catalog',
            dataType:'json',
            data:{'sortId':sortId,'sortType':5,'postType':1},
            success:function(data){
                var files='';
                var arr=new Array();
                var temp=0;
                var downUser=$('input[name="down-user"]').val();
                var editData=$('input[name="folderId"]').attr('editdata');
                var idea=$('input[name="folderId"]').attr('ireader');
                for(var i=0;i<data.length;i++){
                    var str1='';
                    arr=data[i].attachmentList;
                    var editBox='';
                    if($('input[name="editQuanxian"]').val() == '1'){
                        editBox='<a href="javascript:;" class="editBoxBtn" style="margin-left: 10px;"><fmt:message code="global.lang.edit"/></a>';
                    }else{
                        editBox='';
                    }
                    if(data[i].fileType=="file"){
                        temp++;
                        if(data[i].attachmentName!=''){
                            for(var j=0;j<arr.length;j++){
                                if(downUser == '1'){
                                    str1+='<a href="/download?'+encodeURI(arr[j].attUrl)+'" style="display:block;width:170px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;" title="'+arr[j].attachName+'"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+arr[j].attachName+'</a>';
                                }else{
                                    str1+='<a href="javascript:;" style="display:block;color:#000;width:170px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;" title="'+arr[j].attachName+'"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+arr[j].attachName+'</a>';
                                }

                            }
                            if(data[i].readers == '0'){
                                files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' conType='1'><td width='30%'><input class=\"checkChild\" type=\"checkbox\" conId='"+data[i].contentId+"' name=\"check\" value=\"\" > <img src='../img/file/icon_notread_1_03.png' style='width: 16px;height: 16px;margin-left: 10px;'><a class='TITLE' href='javascript:;' style='color:#54b6fe;'>"+data[i].subject+ "  </a></td>  <td width='20%'>"+str1+"</td> <td width='20%'> "+data[i].sendTime+ "  </td><td width='10%'> "+data[i].contentNo+ "  </td><td width='20%'>";
                                if(idea == '1'){
                                    files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"
                                }
                                files+=editBox+"</td></tr>"
                            }else{
                                files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' conType='1'><td width='30%'><input class=\"checkChild\" type=\"checkbox\" conId='"+data[i].contentId+"' name=\"check\" value=\"\" > <a class='TITLE' href='javascript:;' style='color:#54b6fe;'>"+data[i].subject+ "  </a></td>  <td width='20%'>"+str1+"</td> <td width='20%'> "+data[i].sendTime+ "  </td><td width='10%'> "+data[i].contentNo+ "  </td><td width='20%'>";
                                if(idea == '1'){
                                    files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"
                                }
                                files+=editBox+"</td></tr>"
                            }
                        }else{
                            if(data[i].readers == '0'){
                                files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' conType='1'><td width='30%'><input class=\"checkChild\" type=\"checkbox\" conId='"+data[i].contentId+"' name=\"check\" value=\"\" > <img src='../img/file/icon_notread_1_03.png' style='width: 16px;height: 16px;margin-left: 10px;'><a class='TITLE' href='javascript:;' style='color:#54b6fe;'>"+data[i].subject+ "  </a></td>  <td width='20%'><a href='javascript:;'></a></td> <td width='20%'> "+data[i].sendTime+ "  </td><td width='10%'> "+data[i].contentNo+ "  </td><td width='20%'>";
                                if(idea == '1'){
                                    files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"
                                }
                                files+=editBox+"</td></tr>"
                            }else{
                                files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' conType='1'><td width='30%'><input class=\"checkChild\" type=\"checkbox\" conId='"+data[i].contentId+"' name=\"check\" value=\"\" > <a class='TITLE' href='javascript:;' style='color:#54b6fe;'>"+data[i].subject+ "  </a></td>  <td width='20%'><a href='javascript:;'></a></td> <td width='20%'> "+data[i].sendTime+ "  </td><td width='10%'> "+data[i].contentNo+ "  </td><td width='20%'>";
                                if(idea == '1'){
                                    files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"
                                }
                                files+=editBox+"</td></tr>"
                            }
                        }
                    }
                }
                if(temp==0){
                    files='<tr><td colspan="5"><div style="margin: 20px 0;width: 100%;text-align: center;"><fmt:message code="file.th.noFiles"/></div></td></tr>';
                }
                $("#file_Tachr").html(files);
                $('[name="sortId"]').val(sortId)
                $(".contentTr").click(function () {
                    var state=$(this).find('.checkChild').prop("checked");
                    if(state==true){
                        $(this).find('.checkChild').prop("checked",true);
                        $(this).addClass('bgcolor');
                    }else{
                        $('#checkedAll').prop("checked",false);
                        $(this).find('.checkChild').prop("checked",false);
                        $(this).removeClass('bgcolor');
                    }
                    var child =   $(".checkChild");
                    for(var i=0;i<child.length;i++){
                        var childstate= $(child[i]).prop("checked");
                        if(state!=childstate){
                            return
                        }
                    }
                    $('#checkedAll').prop("checked",state);
                })

                $('#checkedAll').prop("checked",false);
            }
        });
    }

    function queryOneDatasd(sortId,iReder){
        var data={
            'sortId':sortId,
            'pageNo':0,
            'pageSize':10,
            'subjectName':$('input[name="subjectName"]').val(),
            'contentNo':$('input[name="contentNo"]').val(),
            'creater':$('#userDuser').attr('user_id'),
            'contentValue1':$('input[name="contentValue1"]').val(),
            'contentValue2':$('input[name="contentValue2"]').val(),
            'contentValue3':$('input[name="contentValue3"]').val(),
            'atiachmentDesc':$('input[name="atiachmentDesc"]').val(),
            'atiachmentName':$('input[name="atiachmentName"]').val(),
            'atiachmentCont':$('input[name="atiachmentCont"]').val(),
            'crStartDate':$('input[name="crStartDate"]').val(),
            'crEndDate':$('input[name="crEndDate"]').val(),
        }
        $.ajax({
            type:'post',
            url:'../file/queryBySearchValue',
            dataType:'json',
            data:data,
            success:function(res){
                $('#file_Tachrs').find('tr').remove();
                var data1=res.datas;
                var str='';
                var files='';
                for(var i=0;i<data1.length;i++){
                    if(data1[i].attachmentName!=''){

                        str+="  <tr class='contentTrs' sortId='"+data1[i].sortId+"' contentId='"+data1[i].contentId+"' conType='2'><td><input class='checkChildren' type='checkbox' conId='"+data1[i].contentId+"' name='check' value='' > <a class='TITLE' style='color:#54b6fe;' href='javascript:;'>"+data1[i].subject+ "  </a></td>  <td><img style='width:16px;' src=\"../img/file/cabinet@.png\" alt=\"\"/>"+data1[i].attachmentName+"</td> <td> "+data1[i].sendTime+ "  </td><td> "+data1[i].contentNo+ "  </td><td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a>";
                        if(iReder == '1'){
                            files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"
                        }
                        files+="</td></tr>"
                    }else{
                        str+="  <tr class='contentTrs' sortId='"+data1[i].sortId+"' contentId='"+data1[i].contentId+"' conType='2'><td><input class='checkChildren' type='checkbox' conId='"+data1[i].contentId+"' name='check' value='' > <a class='TITLE' style='color:#54b6fe;' href='javascript:;'>"+data1[i].subject+ "  </a></td>  <td></td> <td> "+data1[i].sendTime+ "  </td><td> "+data1[i].contentNo+ "  </td><td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a>";
                        if(iReder == '1'){
                            files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"
                        }
                        files+="</td></tr>"
                    }
                }
                $('#file_Tachrs').append(str);
                $(".contentTrs").click(function () {
                    var state=$(this).find('.checkChildren').prop("checked");
                    if(state==true){
                        $(this).find('.checkChildren').prop("checked",true);
                        $(this).addClass('bgcolor');
                    }else{
                        $('#checkedAlls').prop("checked",false);
                        $(this).find('.checkChildren').prop("checked",false);
                        $(this).removeClass('bgcolor');
                    }
                    var child =   $(".checkChildren");
                    for(var i=0;i<child.length;i++){
                        var childstate= $(child[i]).prop("checked");
                        if(state!=childstate){
                            return
                        }
                    }
                    $('#checkedAlls').prop("checked",state);
                })

                $('#checkedAlls').prop("checked",false);
            }
        })
    }
    function queryAllDatasd(iReder){
        var data={
            'serachType':'2',
            'subject':$('input[name="subject"]').val(),
            'sort_no':$('input[name="sort_no"]').val(),
            'creater':$('#userDuser').attr('user_id'),
            'keyword1':$('input[name="keyword1"]').val(),
            'keyword2':$('input[name="keyword2"]').val(),
            'keyword3':$('input[name="keyword3"]').val(),
            'attScript':$('input[name="attScript"]').val(),
            'attName':$('input[name="attName"]').val(),
            'attContain':$('input[name="attContain"]').val(),
            'begainTime':$('input[name="begainTime"]').val(),
            'endTime':$('input[name="endTime"]').val(),
        }
        $.ajax({
            type:'post',
            url:'../file/serachAll',
            dataType:'json',
            data:data,
            success:function(res){
                $('#file_Tach').find('tr').remove();
                var data1=res.obj;
                console.log(res);
                var str='';
                var arr=new Array();
                var files ='';
                for(var i=0;i<data1.length;i++){
                    var stra='';
                    arr=data1[i].attachmentList;
                    if(data1[i].attachmentName!=''){
                        for(var j=0;j<arr.length;j++){
                            stra+='<a href="/download?'+encodeURI(arr[j].attUrl)+'" style="display:block;"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+arr[j].attachName+'</a>';
                        }
                        str+='<tr class="contentT" contentId="'+data1[i].contentId+'" conType="3"><td><input class="checkChildren" conId="'+data1[i].contentId+'" type="checkbox" name="check" value="" style="margin-right:15px;" >'+data1[i].filePath+'</td><td><a class="TITLE" href="javascript:;" style="color:#54b6fe;margin-left:0;">'+data1[i].subject+'</a></td><td>'+stra+'</td><td>'+data1[i].attachmentDesc+'</td><td>'+data1[i].sendTime+'</td><td><a href="javascript:;" class="editBtn"><fmt:message code="global.lang.edit"/></a>'
                        if(iReder == '1'){
                            files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"
                        }
                        files+="</td></tr>"
                    }else {
                        str+='<tr class="contentT" contentId="'+data1[i].contentId+'" conType="3"><td><input class="checkChildren" conId="'+data1[i].contentId+'" type="checkbox" name="check" value="" style="margin-right:15px;" >'+data1[i].filePath+'</td><td><a class="TITLE" href="javascript:;" style="color:#54b6fe;margin-left:0;">'+data1[i].subject+'</a></td><td></td><td>'+data1[i].attachmentDesc+'</td><td>'+data1[i].sendTime+'</td><td><a href="javascript:;" class="editBtn"><fmt:message code="global.lang.edit"/></a>';
                        if(iReder == '1'){
                            files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"
                        }
                        files+="</td></tr>"
                    }
                }
                $('#file_Tach').append(str);
                $(".contentT").click(function () {
                    var state=$(this).find('.checkChildren').prop("checked");
                    if(state==true){
                        $(this).find('.checkChildren').prop("checked",true);
                        $(this).addClass('bgcolor');
                    }else{
                        $('#checkedAllY').prop("checked",false);
                        $(this).find('.checkChildren').prop("checked",false);
                        $(this).removeClass('bgcolor');
                    }
                    var child =   $(".checkChildren");
                    for(var i=0;i<child.length;i++){
                        var childstate= $(child[i]).prop("checked");
                        if(state!=childstate){
                            return
                        }
                    }
                    $('#checkedAllY').prop("checked",state);
                })

                $('#checkedAllY').prop("checked",false);
            }
        })
    }

</script>
</body>
</html>
