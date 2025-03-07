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
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title><fmt:message code="main.personnel"/></title>
    <link rel="stylesheet" type="text/css" href="../css/easyui/easyui.css">
    <link rel="stylesheet" type="text/css" href="../css/easyui/icon.css">
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../css/cabinet.css?20201106.1">
    <link rel="stylesheet" type="text/css" href="../css/file/fileHomePerson.css">
    <%--<script type="text/javascript" src="../js/easyui/jquery.min.js"></script>--%>
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="../js/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/easyui/easyui-lang-zh_CN.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/laydate/laydate.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/jquery/jquery.form.min.js" type="text/javascript" charset="utf-8"></script>
    <style>
        .tree-title{
            color:#333;
            font-size: 14px;
        }
        .deleteFolder{
            width:112px;
        }
        .ss a{
            font-size:12px;
            /*font-size:11pt;*/
        }
        /*.layui-layer-btn{*/
            /*background-color: #e8f4fc;*/
            /*padding: 5px 10px 10px;*/
        /*}*/
        .w .th{
            font-size: 13pt;
        }
        .w td{
            font-size: 11pt;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
<script type="text/javascript">
    function defaultRenderLi(nodeId){
        $("#fileTransfor li").find("div[node-id='"+nodeId+"']").addClass("tree-node-selected");   //设置第一个节点高亮
    }

    var user_id='userDuser';

$(function(){
    var Height=$('body').height()-47;
    $('#fileTransfor').height(Height);
//    alert(Height);
    reloadTree();
    init(4,0,1);
    //新建文件
    $('#contentAdd').click(function(){
        var sortId=$('.tree-node-selected').attr('node-id');
        var sortText=$('input[name="sortTxt"]').val();
        <%--$.popWindow('${pageContext.request.contextPath }/file/contentAdd?sortId='+sortId+'&text='+sortText,'<fmt:message code="global.lang.new"/>','100','300','960px','750px');--%>
        $.popWindow('${pageContext.request.contextPath }/file/contentAdd?sortId='+sortId+'&text='+encodeURI(sortText),'<fmt:message code="global.lang.new"/>','100','300','960px','750px');
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
        var id=$('.w .contentTr').attr('sortId');
        var fileId=[];
        $(".checkChild:checkbox:checked").each(function(){
            var conId=$(this).attr("conId")
            fileId.push(conId);
        })
        if(fileId == ''){
            $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
        }else{
            dataDelete(fileId,id)
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
    //编辑点击事件
    $('.w').on('click','.editBtn',function(){
        var idT=$(this).parents('tr').attr('contentId');
        var sortId=$(this).parents('tr').attr('sortId');
        var contype=$(this).parents('tr').attr('contype');
       //window.open('/file/contentAdd?contentId='+idT+'&sortId='+sortId+'&contype='+contype);
        $.popWindow('/file/contentAdd?contentId='+idT+'&sortId='+sortId+'&contype='+contype,'<fmt:message code="global.lang.edit"/>','100','300','960px','500px');
    })
    //文件详情点击事件
    $('.w').on('click','.TITLE',function(){
        var idT=$(this).parents('tr').attr('contentId');
        var sortId=$(this).parents('tr').attr('sortId');
        $.popWindow('/file/toFileDetails?contentId='+idT+'&sortId='+sortId,'<fmt:message code="file.th.detail"/>','100','300','800px','500px');
    })

    //弹出一个页面层，查询点击事件
    $('.SEARCH').on('click', function(event){
        event.stopPropagation();
        var sortId=$('.contentTr').attr('sortId');

        layer.open({
            type: 1,
            title:['<fmt:message code="global.lang.query"/>', 'background-color:#2b7fe0;color:#fff;'],
            area: ['600px', '460px'],
            shadeClose: true, //点击遮罩关闭
            btn: ['<fmt:message code="global.lang.query"/>', '<fmt:message code="global.lang.close"/>'],
            content: '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 94%;">' +
            '<tr><td><fmt:message code="file.th.TitleContainsText"/>：</td><td><input type="text" style="width: 150px;" name="subjectName" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.Sort"/>：</td><td><input type="text" style="width: 150px;" name="contentNo" class="inputTd" value="" /></td></tr>'+
            <%--'<tr><td><fmt:message code="file.th.builder"/>：</td><td><div class="inPole"><textarea name="txt" id="userDuser" user_id="id" value="admin" disabled style="min-width: 300px;min-height:50px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add"/></a></span></div></td></tr>'+--%>
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
                queryOneData(sortId,userId);
                layer.close(index);
                $('.mainContent').hide();
                $('.details').show();
            }
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
                queryAllData(userId)
                layer.close(index);
                $('.mainContent').hide();
                $('.queryDetail').show();
            }
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
    })

    var conId;
    var data={};
    //复制点击事件
    $('#copy').click(function(){
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
        fileIds=[];
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
        if(tId == '1'){
            data={
                'witchSortId':sortId,
                'copyId':conId
            }
            copyData('../file/copyAndParse',data,sortId);
        }else if(tId == '2'){
            data={
                'sortId':sortId,
                'contentId':fileIds
            }
            copyData('../file/fileCut',data,sortId);
        }
    })

    //下载点击事件
    $('.FiveOne').click(function(){
        var text=$('input[name="sortTxt"]').val();
        var fileId=[];
        $(".checkChild:checkbox:checked").each(function(){
            var conId=$(this).attr("conId");
            fileId.push(conId);
        })
        //console.log(fileId);
        if(fileId == ''){
            $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
            return false;
        }else{
            window.location.href='../file/downFileContent?contentId='+fileId+'&sortName='+text;
        }
    })
    //下载点击事件
    $('.FiveTow').click(function(){
        var text=$('input[name="sortTxt"]').val();
        var fileId=[];
        $(".checkChildren:checkbox:checked").each(function(){
            var conId=$('.bgcolor').attr('contentId');
            fileId.push(conId);
        })
        //console.log(fileId);
        if(fileId == ''){
            $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
            return false;
        }else{
            window.location.href='../file/downFileContent?contentId='+fileId+'&sortName='+text;
        }
    })
    //新建子文件夹
    $('#newChildFolder').click(function(){
        $('.newAddFolder').show().siblings().hide();
    })
    //根目录新建子文件夹
    $('#newChildFolders').click(function(){
        $('.newAddFolder').show().siblings().hide();
    })
    //新建子文件夹确定事件
    $('#btnSure').click(function(){
        var sortParent=$('.tree-node-selected').attr('node-id');
        var data={
            'sortType':4,
            'sortParent':sortParent,
            'sortNo':$('input[name="serial"]').val(),
            'sortName':$('input[name="polderName"]').val()
        }
        if($('input[name="serial"]').val()=='' || $('input[name="polderName"]').val()==''){
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
            url:'../file/getFileCheck',
            dataType:'json',
            data:data,
            success:function(res) {
                if (res == '1') {
                    $.layerMsg({content:'<fmt:message code="main.th.alreadyExists"/>！',icon:3});
                    return false;
                }else{
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
                                    $('.details').hide();
                                    $('.queryDetail').hide();
                                    $('.newAddFolder').hide();
                                    $('.editAddFolder').hide();
                                    $('.mainContent').show();
                                    init(4,sortParent,1);
                                    reloadTree();
                                });
                            }else {
                                $.layerMsg({content:'<fmt:message code="depatement.th.Newfailed"/>！',icon:2},function(){
                                    //console.log('<fmt:message code="depatement.th.Newfailed"/>');
                                });
                            }
                        }
                    })
                }
            }
        });


    })


    //新建子文件夹返回按钮
    $('#btnBack').click(function(){
        $('input[name="serial"]').val('');
        $('input[name="polderName"]').val('')
        $('.mainContent').show();
        $('.newAddFolder').hide();
    })
    //编辑子文件夹按钮
    $('#editFolder').click(function(){
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
    //编辑子文件夹确定按钮
    $('#editSure').click(function(){
        var sortId=$('input[name="folderId"]').val();
        var data={
            'sortId':sortId,
            'sortNo':$('input[name="edSerial"]').val(),
            'sortName':$('input[name="edPolderName"]').val()
        }

        if($('input[name="edPolderName"]').val() == ''){
            $.layerMsg({content:'<fmt:message code="doc.th.sortNumber"/>！',icon:2});
            return false;
        }

            $.ajax({
                type:'post',
                url:'../file/update',
                dataType:'json',
                data:data,
                success:function(res){
                    if(res==1){
                        $.layerMsg({content:'<fmt:message code="menuSSetting.th.editSuccess"/>！',icon:1},function(){
                            $('.details').hide();
                            $('.queryDetail').hide();
                            $('.newAddFolder').hide();
                            $('.editAddFolder').hide();
                            $('.mainContent').show();
                            init(4,sortId,1);
                            reloadTree();
                        });
                    }else{
                        $.layerMsg({content:'<fmt:message code="depatement.th.modifyfailed"/>！',icon:2},function(){
                            //console.log('<fmt:message code="depatement.th.modifyfailed"/>')
                        });
                    }
                }
            })
    })

    //编辑子文件夹返回按钮
    $('#editBack').click(function(){
        $('.mainContent').show();
        $('.editAddFolder').hide();
    })
    //删除子文件夹按钮
    $('#deleteFolder').click(function(){
        var sortId=$('input[name="folderId"]').val();
        layer.confirm('<fmt:message code="sys.th.commit"/>！', {
            btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'], //按钮
            title:"<fmt:message code="file.th.removeFolders"/>"
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'post',
                url:'../file/deletefileAndCon',
                dataType:'json',
                data:{'sortId':sortId},
                success:function(res){
                    if(res.flag == true){
                        $('.details').hide();
                        $('.queryDetail').hide();
                        $('.newAddFolder').hide();
                        $('.editAddFolder').hide();
                        $('.mainContent').show();
                        layer.msg('<fmt:message code="workflow.th.delsucess"/>', { icon:6});
                        init(4,0,1);
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
    /*------------------------------------------------------------------*/
    //查询列表删除
    function dataDeleteOne(fileId,sortId,id){
        layer.confirm('<fmt:message code="sup.th.Delete"/>？', {
            btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'], //按钮
            title:"<fmt:message code="file.th.removeFolders"/>"
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
    function queryOneData(sortId,id){
        var data={
            'sortId':sortId,
            'pageNo':0,
            'pageSize':10,
            'subjectName':$('input[name="subjectName"]').val(),
            'contentNo':$('input[name="contentNo"]').val(),
            'creater':$.cookie('userId')+',',
            'contentValue1':$('input[name="contentValue1"]').val(),
            'contentValue2':$('input[name="contentValue2"]').val(),
            'contentValue3':$('input[name="contentValue3"]').val(),
            'atiachmentDesc':$('input[name="atiachmentDesc"]').val(),
            'atiachmentName':$('input[name="atiachmentName"]').val(),
            'atiachmentCont':$('input[name="atiachmentCont"]').val(),
            'crStartDate':$('input[name="crStartDate"]').val(),
            'crEndDate':$('input[name="crEndDate"]').val(),
            'sortType':'4'
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
                for(var i=0;i<data1.length;i++){
                    if(data1[i].attachmentName!=''){
                        str+="  <tr class='contentTrs' sortId='"+data1[i].sortId+"' contentId='"+data1[i].contentId+"' conType='2'><td><input class='checkChildren' type='checkbox' conId='"+data1[i].contentId+"' name='check' value='' > <a class='TITLE' style='color:#54b6fe;width: 260px;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;' href='javascript:;'>"+data1[i].subject+ "  </a></td>  <td><img style='width:16px;' src=\"../img/file/cabinet@.png\" alt=\"\"/>"+data1[i].attachmentName+"</td> <td> "+data1[i].sendTime+ "  </td><td> "+data1[i].contentNo+ "  </td><td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a></td></tr>"
                    }else{
                        str+="  <tr class='contentTrs' sortId='"+data1[i].sortId+"' contentId='"+data1[i].contentId+"' conType='2'><td><input class='checkChildren' type='checkbox' conId='"+data1[i].contentId+"' name='check' value='' > <a class='TITLE' style='color:#54b6fe;width: 260px;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;' href='javascript:;'>"+data1[i].subject+ "  </a></td>  <td></td> <td> "+data1[i].sendTime+ "  </td><td> "+data1[i].contentNo+ "  </td><td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a></td></tr>"
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
            title:"<fmt:message code="file.th.removeFolders"/>"
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
            'serachType':'1',
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
            'endTime':$('input[name="endTime"]').val()
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
                        str+='<tr class="contentT" contentId="'+data1[i].contentId+'" conType="3"><td><input class="checkChildren" conId="'+data1[i].contentId+'" type="checkbox" name="check" value="" style="margin-right:15px;" >'+data1[i].filePath+'</td><td><a class="TITLE" href="javascript:;" style="color:#54b6fe;margin-left:0;width: 260px;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">'+data1[i].subject+'</a></td><td>'+stra+'</td><td>'+data1[i].attachmentDesc+'</td><td>'+data1[i].sendTime+'</td><td><a href="javascript:;" class="editBtn"><fmt:message code="global.lang.edit"/></a></td></tr>';
                    }else {
                        str+='<tr class="contentT" contentId="'+data1[i].contentId+'" conType="3"><td><input class="checkChildren" conId="'+data1[i].contentId+'" type="checkbox" name="check" value="" style="margin-right:15px;" >'+data1[i].filePath+'</td><td><a class="TITLE" href="javascript:;" style="color:#54b6fe;margin-left:0;width: 260px;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">'+data1[i].subject+'</a></td><td></td><td>'+data1[i].attachmentDesc+'</td><td>'+data1[i].sendTime+'</td><td><a href="javascript:;" class="editBtn"><fmt:message code="global.lang.edit"/></a></td></tr>'
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

    var user_id='userDuser';
    $(function(){
        //选人控件
        $("#selectUserDep").on("click",function(){
            user_id='userDuser';
            $.popWindow("../common/selectUser");
        });
        //清空所选人员
        $('.clear').click(function(){
            $('#userDuser').val('');
            $('#userDuser').attr('user_id','');
        })

        $('#uploadimg').on('click', function(ele) {
            $('#uploadinputimg').click();
            $(".attach").show();

        })
        $('#uploadinputimg').change(function(){
            var arr=$(this)[0].files
            var str='';
            //console.log(arr);
            for(var i=0;i<arr.length;i++){
                str+='<p style="margin-left: 10px">'+arr[i].name+'</p>';
            }
            $('.box').append(str);
        })


        $('#start').click(function(){
            var sortId=$('[name="sortId"]').val();
            $('#uploadimgform').ajaxSubmit({
                dataType:'json',
                success:function (res) {
                    //console.log(res)
                    if(res.status == true){
                        $('.box').children().remove();
                        $('.attach').hide();
                        init(4,sortId,1);
                    }
                }
            })

        })

        //全部取消点击事件
        $('.cancle').click(function(){
            $('.box').children().remove();
            $('.attach').hide();
        })
    })

    function copyData(url,data,sortId){
        $.ajax({
            type:'post',
            url:url,
            dataType:'json',
            data:data,
            success:function(res){
                if(res.flag==true){
                    $.layerMsg({content:'<fmt:message code="file.th.PasteSuccessfully"/>！',icon:1},function(){
                        init(4,sortId,1);
                    });
                }else{
                    $.layerMsg({content:'<fmt:message code="file.th.PasteFailed"/>！',icon:2});
                }
            }
        })
    }

    function dataDelete(fileId,id){
        layer.confirm('<fmt:message code="sup.th.Delete"/>？', {
            btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'], //按钮
            title:"<fmt:message code="file.th.removeFolders"/>"
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'post',
                url:'${pageContext.request.contextPath }/file/batchDeleteConId',
                dataType:'json',
                data:{'fileId':fileId},
                success:function(){
                    layer.msg('<fmt:message code="workflow.th.delsucess"/>', { icon:6});
                    init(4,id,1);
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
             url: "${pageContext.request.contextPath}/file/writeTreePerson",
             dataType:'json',
             success: function (data) {
                $("#fileTransfor").append("<ul id=\"fileTree\" class=\"easyui-tree\"data-options=\"method:'get',animate:true\" style='font-size: 14px;' ></ul>");
	                $("#fileTree").tree({
			               data : data,
			               onClick : function(node){
                               $('.details').hide();
                               $('.queryDetail').hide();
                               $('.queryDetail').hide();
                               $('.newAddFolder').hide();
                               $('.editAddFolder').hide();
                               $('.mainContent').show();
                               if(node.id==0){
                                   $('.childFolders').show().siblings().hide();
                               }else{
                                   $('.childFolder').show().siblings().hide();
                               }
                               init(4,node.id,1);
                               $('input[name="sortTxt"]').val('');
                               $('input[name="folderId"]').val('');
                               $('input[name="sortTxt"]').val(node.text);
                               $('input[name="folderId"]').val(node.id);
			               },
                        onLoadSuccess:function(node,data) {
                            defaultRenderLi(0);
                        }
	                   });
              }
          }); 
     }
     

    //获取文件夹中的文件列表
    function init(sortType,id,postType){
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
                for(var i=0;i<data.length;i++){
                    var str1=''
                    arr=data[i].attachmentList
                    if(data[i].fileType=="file"){
                        temp++;
                        if(data[i].attachmentName!=''){
                            for(var j=0;j<arr.length;j++){
                                str1+='<a href="/download?'+encodeURI(arr[j].attUrl)+'" style="display:block;width:170px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;" title="'+arr[j].attachName+'"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+arr[j].attachName+'</a>';
                            }
                            files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' conType='1'><td><input class=\"checkChild\" type=\"checkbox\" conId='"+data[i].contentId+"' name=\"check\" value=\"\" > <a class='TITLE' href='javascript:;' style='color:#54b6fe;width: 260px;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;'>"+data[i].subject+ "  </a></td>  <td>"+str1+"</td> <td> "+data[i].sendTime+ "  </td><td> "+data[i].contentNo+ "  </td><td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a></td></tr>"
                        }else{
                            files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' conType='1'><td><input class=\"checkChild\" type=\"checkbox\" conId='"+data[i].contentId+"' name=\"check\" value=\"\" > <a class='TITLE' href='javascript:;' style='color:#54b6fe;width: 260px;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;'>"+data[i].subject+ "  </a></td>  <td><a href='javascript:;'></a></td> <td> "+data[i].sendTime+ "  </td><td> "+data[i].contentNo+ "  </td><td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a></td></tr>"
                        }
                    }
                }
                if(temp==0){
                    files='<tr><td colspan="5"><div style="margin: 20px 0;width: 100%;text-align: center;"><fmt:message code="file.th.noFiles"/></div></td></tr>';
                }
                $("#file_Tachr").html(files);
                $('[name="sortId"]').val(id);
                $("#file_Tachr").find(".contentTr").click(function () {
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
    layer.msg('<fmt:message code="lang.th.Upcoming"/>', {icon: 6});
}

</script>
</head>
<body>
<div class="contentPage">

    <div  class="cabinet_left">
      <!--  <div onclick="cabinet('1')" id="personal" style="width:49%;height:30px;line-height:30px;   float: left;border:1px solid #c0c0c0;text-align: center;"><fmt:message code="main.public"/></div>
       <div onclick="cabinet('2')" id="public"  style="width:49%;height:30px;line-height:30px;  float: left;border:1px solid #c0c0c0;text-align: center;"><fmt:message code="main.personnel"/></div> -->
       
      <div onclick="cabinet('2')" id="public"  style="width:100%;height:44px;overflow: hidden;border-bottom: #9e9e9e 1px solid;">
          <div class="div_Img">
              <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_personalFile.png" style="vertical-align: middle;" alt="">
          </div>
          <div class="divP"><fmt:message code="main.personnel"/></div>
      </div>
        <!-- <div onclick="" id="personal" style="width:100%;height:40px;line-height:40px;padding-left: 15px;   float: left;text-align: left;"><fmt:message code="main.public"/></div>
 -->
        <div id="fileTransfor" style="width:100%;">
                <%--<ul id="fileTree" class="easyui-tree" data-options="url:'writeTreePerson',method:'get',animate:true" >--%>
				<%--</ul>--%>
        </div>
    </div>
    <div class="cabinet_info">
        <%--<div class="noData" style="display: block;">
            <div class="bgImg">
                <div class="IMG">
                    <img src="../img/sys/icon64_info.png"/>
                </div>
                <div class="TXT">请选择文件夹进行浏览</div>
            </div>
        </div>--%>
        <div class="mainContent" style="display:block;">
            <div class="head w clearfix">
                <div class="ss one" style="border-radius: 3px;"> <a id="contentAdd" href="javascript:;"><img style="margin-right: 4px;margin-left: -16px;margin-bottom: 3px;" src="../../img/mywork/newbuildworjk.png" alt=""><fmt:message code="file.th.newfile"/></a></div>
                <div id="batch" class="ss two">
                    <form id="uploadimgform" target="uploadiframe"  action="../file/fileBoxUpload" enctype="multipart/form-data" method="post" >
                        <input type="hidden" name="sortId">
                        <input type="file" name="file" id="uploadinputimg" multiple="multiple" class="w-icon5" style="display:none;">
                        <a href="#" id="uploadimg"><img style="margin-right: 3px;margin-left: -18px;margin-bottom: 4px;" src="../../img/mywork/shangchuan.png" alt=""><fmt:message code="notice.th.up"/></a>
                    </form>
                </div>
                <div id="SEARCH" class="ss three"> <a  class="SEARCH" href="javascript:;" style="left: 25px;"><fmt:message code="global.lang.query"/></a></div>
                <div id="overall" class="ss four"> <a href="javascript:;"><fmt:message code="Email.th.global"/></a></div>
            </div>
            <!--middle部分开始-->
            <div class="w" style="margin-top: 10px;">
                <div class="wrap">
                    <input type="hidden" name="sortTxt" value="<fmt:message code="main.th.RootFolder"/>">
                    <table class="w">
                        <thead>
                        <tr>
                            <td class="th" width="35%"><fmt:message code="file.th.name"/></td>
                            <td class="th" width="20%"><fmt:message code="email.th.file"/></td>
                            <td class="th" width="20%" style="">
                                <fmt:message code="notice.th.PostedTime"/>
                                <%--<img style="position: absolute;margin-left:9px;cursor: pointer;" src="../img/file/cabinet05.png" alt=""/>--%>
                                <%--<img style="position: absolute;margin-top:10px;margin-left:9px;cursor: pointer;" src="../img/file/cabinet06.png " alt=""/>--%>
                            </td>
                            <td class="th" width="15%" style="">
                                <fmt:message code="file.th.Sort"/>
                                <%--<img style="position: absolute;margin-left:9px;cursor: pointer;" src="../img/file/cabinet05.png" alt=""/>--%>
                                <%--<img style="position: absolute;margin-top:10px;margin-left:9px;cursor: pointer;" src="../img/file/cabinet06.png " alt=""/>--%>
                            </td>
                            <td class="th" width="10%"><fmt:message code="notice.th.operation"/></td>
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
               <%-- <div class="boto" onclick="clicked()">
                    <a class="ONE" href="javascript:;"><span>签阅</span></a>
                </div>--%>
                <div class="boto" id="copy">
                    <a class="TWO" href="javascript:;"><span><fmt:message code="file.th.copy"/></span></a>
                </div>
                <div class="boto" id="shear">
                    <a class="THREE" href="javascript:;"><span><fmt:message code="file.th.cut"/></span></a>
                </div>
                <div class="boto" id="paste" style="display: none;">
                    <a class="SIX" href="javascript:;"><span><fmt:message code="fille.th.paste"/></span></a>
                </div>
                <div class="boto">
                    <a class="FOURs" href="javascript:;"><span><fmt:message code="global.lang.delete"/></span></a>
                </div>
                <%--<div class="boto">--%>
                    <%--<a class="FIVE FiveOne" href="javascript:;"><span><fmt:message code="file.th.download"/></span></a>--%>
                <%--</div>--%>

            </div>
            <div class="floderOperation" style="display: block;">
                <input type="hidden" name="folderId" value="">
                <div class="childFolders" style="display: block;">
                    <div class="operation"><fmt:message code="file.th.op"/>：</div>
                    <div class="newChildFolder">
                        <a id="newChildFolders" href="javascript:;"><img style="margin-right: -26px;margin-left: 7px;margin-bottom: 2px;" src="../../img/mywork/newbuildworjk.png" alt=""><span><fmt:message code="file.th.newf"/></span></a>
                    </div>
                </div>
                <div class="childFolder" style="display: none;">
                    <div class="operation"><fmt:message code="file.th.op"/>：</div>
                    <div class="newChildFolder">
                        <a id="newChildFolder" href="javascript:;"><img style="margin-right: 4px;margin-left: 9px;margin-bottom: 3px;" src="../../img/mywork/newbuildworjk.png" alt=""><span style="margin-left: 2px"><fmt:message code="file.th.newf"/></span></a>
                    </div>
                    <div class="editFolder">
                        <a id="editFolder" href="javascript:;"><span><fmt:message code="global.lang.edit"/></span></a>
                    </div>
                    <div class="deleteFolder">
                        <a id="deleteFolder" href="javascript:;"><span><fmt:message code="flie.th.dele"/></span></a>
                    </div>
                </div>
            </div>
            <div class="attach" style="display: none;">
                <div class="box" id="fileName"></div>
               <%-- <div class="remind">
                    <p>事务提醒：</p>
                    <input type="radio" name="remindUser" value="">
                    <span>手动选择被提醒人员</span>
                    <input type="radio" name="remindUser" value="">
                    <span>提醒全部有权限人员</span>
                </div>
                <div class="inPole">
                    <textarea name="txt" id="userDuser" user_id='' value="" disabled style="min-width: 200px;min-height: 50px;"></textarea>
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
                <div class="divBtn">
                    <div class="start" id="start"><fmt:message code="file.th.StartUploading"/></div>
                    <div class="cancle"><fmt:message code="file.th.cancelAll"/></div>
                </div>
            </div>
        </div>
        <div class="details" style="display:none;margin-top: 10px">
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
                            <td class="th" style="">
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
                <div class="boto">
                    <a class="FIVE FiveTow" href="javascript:;"><span><fmt:message code="file.th.download"/></span></a>
                </div>
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
                <div class="boto">
                    <a class="FIVE FiveTow" id="exportA" href="javascript:;"><span><fmt:message code="file.th.download"/></span></a>
                </div>
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
                        <td style="border-right: #ccc 1px solid;"><fmt:message code="file.th.Sort"/></td>
                        <td><input type="text" name="serial" value=""></td>
                    </tr>
                    <tr>
                        <td style="border-right: #ccc 1px solid;"><fmt:message code="file.th.filename"/></td>
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
        <iframe id="mainFram"  src="" class="cabinet_right"></iframe>
    </div>--%>
</div>
<script>

    <%--function parentajax(sortId){--%>
    <%--var ajaxPage={--%>
    <%--data:{--%>
    <%--userId:genCookie,--%>
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
    <%--if(data.length > 0 ){--%>
    <%--for(var i=0;i<data.length;i++){--%>
    <%--arr=data[i].attachmentList;--%>
    <%--if(data[i].attachmentName != ''){--%>
    <%--var str1='';--%>
    <%--for(var j=0;j<arr.length;j++){--%>

    <%--var iconType='';--%>
    <%--if(GetFileExt(arr[j].attachName) == '.docx' || GetFileExt(arr[j].attachName) == '.doc' || GetFileExt(arr[j].attachName) == '.DOC' || GetFileExt(arr[j].attachName) == '.DOCX' || GetFileExt(arr[j].attachName) == '.word' || GetFileExt(arr[j].attachName) == '.WORD'){--%>
    <%--iconType='word';--%>
    <%--}else if(GetFileExt(arr[j].attachName) == '.pptx' || GetFileExt(arr[j].attachName) == '.ppt'){--%>
    <%--iconType='ppt';--%>
    <%--}else if(GetFileExt(arr[j].attachName) == '.xlsx' || GetFileExt(arr[j].attachName) == '.xls'){--%>
    <%--iconType='excel';--%>
    <%--}else if(GetFileExt(arr[j].attachName) == '.pdf'){--%>
    <%--iconType='pdf';--%>
    <%--//                                            iconType=GetFileExt(arr[j].attachName).replace('.', "")--%>
    <%--}else if(GetFileExt(arr[j].attachName) == '.exe'){--%>
    <%--iconType='exe';--%>
    <%--}else if(GetFileExt(arr[j].attachName) == '.jpg' || GetFileExt(arr[j].attachName) == '.png'){--%>
    <%--iconType='pic';--%>
    <%--}else if(GetFileExt(arr[j].attachName) == '.rar' || GetFileExt(arr[j].attachName) == '.zip'){--%>
    <%--iconType='zip';--%>
    <%--}else {--%>
    <%--iconType='file';--%>
    <%--}--%>

    <%--str1+='<div><a href="/download?'+encodeURI(arr[j].attUrl)+'" class="fujian" style="display:block;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;" title="'+arr[j].attachName+'"><img style="width:18px;height:22px;margin-right:5px;" src="../img/attachmentIcon/'+iconType+'.png"/>'+arr[j].attachName+'</a></div>';--%>
    <%--}--%>
    <%--files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' conType='1'><td><input class=\"checkChild\" type=\"checkbox\" conId='"+data[i].contentId+"' name=\"check\" value=\"\" > <a class='TITLE' href='javascript:;' style='color:#54b6fe;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;'>"+data[i].subject+ "  </a></td>  <td>"+str1+"</td> <td> "+data[i].sendTime+ "  </td><td> "+data[i].contentNo+ "  </td><td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a></td></tr>"--%>
    <%--}else{--%>
    <%--files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' conType='1'><td><input class=\"checkChild\" type=\"checkbox\" conId='"+data[i].contentId+"' name=\"check\" value=\"\" > <a class='TITLE' href='javascript:;' style='color:#54b6fe;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;'>"+data[i].subject+ "  </a></td>  <td><a href='javascript:;'></a></td> <td> "+data[i].sendTime+ "  </td><td> "+data[i].contentNo+ "  </td><td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a></td></tr>"--%>
    <%--}--%>
    <%--}--%>
    <%--}else {--%>
    <%--files='<tr><td colspan="5"><div style="margin: 20px 0;width: 100%;text-align: center;"><fmt:message code="file.th.noFiles"/></div></td></tr>';--%>
    <%--}--%>

    <%--$("#file_Tachr").html(files);--%>
    <%--me.pageTwo(res.total,me.data.pageSize,me.data.page)--%>
    <%--$('[name="sortId"]').val(sortId);--%>
    <%--$("#file_Tachr").find(".contentTr").click(function () {--%>
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
        $.ajax({
            type:'post',
            url:'../file/catalog',
            dataType:'json',
            data:{'sortId':sortId,'sortType':4,'postType':1},
            success:function(data){
                var files='';
                var arr=new Array();
                for(var i=0;i<data.length;i++){
                    if(data[i].fileType=="file"){
                        arr=data[i].attachmentList;
                        if(arr.length>0){
                            var str1='';
                            for(var j=0;j<arr.length;j++){
                                str1+='<div><a href="/download?'+encodeURI(arr[j].attUrl)+'" style="display:block;width:170px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;" title="'+arr[j].attachName+'"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+arr[j].attachName+'</a></div>';
                            }
                            files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' conType='1'><td><input class=\"checkChild\" type=\"checkbox\" conId='"+data[i].contentId+"' name=\"check\" value=\"\" > <a class='TITLE' href='javascript:;' style='color:#54b6fe;width: 260px;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;'>"+data[i].subject+ "  </a></td>  <td>"+str1+"</td> <td> "+data[i].sendTime+ "  </td><td> "+data[i].contentNo+ "  </td><td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a></td></tr>"
                        }else{
                            files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' conType='1'><td><input class=\"checkChild\" type=\"checkbox\" conId='"+data[i].contentId+"' name=\"check\" value=\"\" > <a class='TITLE' href='javascript:;' style='color:#54b6fe;width: 260px;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;'>"+data[i].subject+ "  </a></td>  <td><a href='javascript:;'></a></td> <td> "+data[i].sendTime+ "  </td><td> "+data[i].contentNo+ "  </td><td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a></td></tr>"
                        }
                    }
                }
                $("#file_Tachr").html(files);
                $('[name="sortId"]').val(sortId);
                $("#file_Tachr").find(".contentTr").click(function () {
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

    //查询列表方法
    function queryOneDatasd(sortId){
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
            'crEndDate':$('input[name="crEndDate"]').val()
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
                for(var i=0;i<data1.length;i++){
                    if(data1[i].attachmentName!=''){
                        str+="  <tr class='contentTrs' sortId='"+data1[i].sortId+"' contentId='"+data1[i].contentId+"' conType='2'><td><input class='checkChildren' type='checkbox' conId='"+data1[i].contentId+"' name='check' value='' > <a class='TITLE' style='color:#54b6fe;width: 260px;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;' href='javascript:;'>"+data1[i].subject+ "  </a></td>  <td><img style='width:16px;' src=\"../img/file/cabinet@.png\" alt=\"\"/>"+data1[i].attachmentName+"</td> <td> "+data1[i].sendTime+ "  </td><td> "+data1[i].contentNo+ "  </td><td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a></td></tr>"
                    }else{
                        str+="  <tr class='contentTrs' sortId='"+data1[i].sortId+"' contentId='"+data1[i].contentId+"' conType='2'><td><input class='checkChildren' type='checkbox' conId='"+data1[i].contentId+"' name='check' value='' > <a class='TITLE' style='color:#54b6fe;width: 260px;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;' href='javascript:;'>"+data1[i].subject+ "  </a></td>  <td></td> <td> "+data1[i].sendTime+ "  </td><td> "+data1[i].contentNo+ "  </td><td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a></td></tr>"
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

    function queryAllDatasd(){
        var data={
            'serachType':'1',
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
            'endTime':$('input[name="endTime"]').val()
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
                        str+='<tr class="contentT" contentId="'+data1[i].contentId+'" conType="3"><td><input class="checkChildren" conId="'+data1[i].contentId+'" type="checkbox" name="check" value="" style="margin-right:15px;" >'+data1[i].filePath+'</td><td><a class="TITLE" href="javascript:;" style="color:#54b6fe;margin-left:0;width: 260px;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">'+data1[i].subject+'</a></td><td>'+stra+'</td><td>'+data1[i].attachmentDesc+'</td><td>'+data1[i].sendTime+'</td><td><a href="javascript:;" class="editBtn"><fmt:message code="global.lang.edit"/></a></td></tr>';
                    }else {
                        str+='<tr class="contentT" contentId="'+data1[i].contentId+'" conType="3"><td><input class="checkChildren" conId="'+data1[i].contentId+'" type="checkbox" name="check" value="" style="margin-right:15px;" >'+data1[i].filePath+'</td><td><a class="TITLE" href="javascript:;" style="color:#54b6fe;margin-left:0;width: 260px;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">'+data1[i].subject+'</a></td><td></td><td>'+data1[i].attachmentDesc+'</td><td>'+data1[i].sendTime+'</td><td><a href="javascript:;" class="editBtn"><fmt:message code="global.lang.edit"/></a></td></tr>'
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