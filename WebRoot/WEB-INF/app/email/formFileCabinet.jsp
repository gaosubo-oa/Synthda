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
    <title><fmt:message code="email.th.uploadFilesFromTheFileCabinet" /></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/easyui/easyui.css">
    <link rel="stylesheet" type="text/css" href="../css/easyui/icon.css">
    <link rel="stylesheet" type="text/css" href="../css/common/style.css" />
    <link rel="stylesheet" type="text/css" href="../css/common/select.css" />
    <link rel="stylesheet" type="text/css" href="../css/common/org_select.css">
    <%--<link rel="stylesheet" type="text/css" href="../lib/easyui/themes/easyui.css"/>--%>
    <%--<link rel="stylesheet" type="text/css" href="../lib/easyui/themes/icon.css"/>--%>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" charset="utf-8" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" charset="utf-8" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/js/base/base.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="../lib/easyui/jquery.easyui.min.js" ></script>
    <script type="text/javascript" src="../lib/easyui/tree.js" ></script>
</head>
<style type="text/css">
    .main-block{
        top: 0 !important;
        bottom: 0 !important;
    }
    #dept_menu{
        overflow-x: auto;
    }
    .left_choose ul li div,.left_choose ul li h1,.left_choose ul img{
        float:left;
    }
    .left_choose ul img{
    <!-- margin-top:8px; -->
    }
    .left_choose ul li{
        width:80%;
        height:20px;
    <!-- background:red; -->
        margin-top:10px;
    }
    .mar{
        margin-left:10%;
    }
    .name li{
        list-style-type:none;
    }
    .choose{
        background:#D6E4EF !important;
    }
    #block-right-header,#block-right-add,#block-right-remove{
        display: none;
    }
    .fileBox{
        width: 100%;
        height: 40px;
        border-bottom: #ccc 1px solid;
        border-top: #ccc 1px solid;
        line-height: 40px;
        cursor: pointer;
    }
    tr{
        border: #ccc 1px solid;
    }
    th{
        padding: 8px;
        font-size: 11pt;
    }
    td{
        padding: 8px;
        font-size: 11pt;
    }
    .noFile{
        text-align: center;
        font-size: 11pt;
        margin-top: 20px;
    }
</style>
<body>
<!-- //内容 -->
    <div class="main-block" id="deptBox" style="display:block;">
        <div class="left moduleContainer" style="padding: 0" id="dept_menu">
            <div class="doneFile">
                <div class="fileBox" id="doneBox" style="">
                    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 5px;margin-left: 5px;margin-bottom: 4px;">
                    <a href="javascript:void(0)" class="dynatree-title"  id="doneFile" title=""><fmt:message code="email.th.selectedFiles" /></a>
                </div>
            </div>
            <div class="prosonFile">
                <div class="fileBox" id="prosonBox" style="">
                    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 5px;margin-left: 5px;margin-bottom: 4px;">
                    <a href="javascript:void(0)" class="dynatree-title"  id="prosonFile" title=""><fmt:message code="main.personnel" /></a>
                </div>
                <ul class="dynatree-container dynatree-no-connector" style="display: none;" id="prosonOrg">
                </ul>
            </div>
            <div class="publicFile">
                <div class="fileBox" id="publicBox">
                    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 5px;margin-left: 5px;margin-bottom: 4px;">
                    <a href="javascript:void(0)" class="dynatree-title" onclick=""  id="publicFile" title=""><fmt:message code="main.public" /></a>
                </div>
                <ul class="dynatree-container dynatree-no-connector" style="display: none;" id="publicOrg">
                </ul>
            </div>

        </div>
        <div class="right" id="dept_item" style="border-left: none;">
            <div class="doneCheck" style="display: block;">
                <span style="font-size: 13pt;margin-bottom: 5px;display: block;"><fmt:message code="email.th.selectedFiles" /></span>
                <table border="0" id="doneTable" cellspacing="0" cellpadding="0" style="border-collapse: collapse;width: 100%;display: none;">
                    <thead>
                    <tr>
                        <th style="width: 60px;"><fmt:message code="notice.th.chose" /></th>
                        <th><fmt:message code="file.th.name" /></th>
                    </tr>
                    </thead>
                    <tbody id="trList_s">

                    </tbody>
                </table>
                <div class="noDoneFile" style="display: block;text-align: center;margin-top: 20px;"><fmt:message code="email.th.noSelectedFiles" /></div>
            </div>
            <div class="pleaseCheck" style="display: none;">
                <div class="block-right" id="dept_item_2" style="display: block;">
                    <table border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse;width: 100%;">
                        <thead>
                        <tr>
                            <th style="width: 230px;"><fmt:message code="news.th.files" /></th>
                            <th><fmt:message code="common.th.selFile" /></th>
                        </tr>
                        </thead>
                        <tbody id="trList">

                        </tbody>
                    </table>
                </div>
                <div class="noFile" style="display: none;"><fmt:message code="email.th.noSelectedFiles" /></div>
            </div>
        </div>
    </div>
<!-- //结束 -->
<div id="south">
    <input type="button" class="BigButtonA" value='<fmt:message code="global.lang.close" />' onclick="close_window();">&nbsp;&nbsp;<%--确定--%>
</div>
</body>
<script type="text/javascript">
    var attach_id='';
    var attachName='';
    var reloadTree;
    var publicTree;
    var genCookie=$.cookie('userId');
    if(parent.opener && parent.opener.user_id){  //判断是否存在父级页面并且有该元素
        attach_id = parent.opener.document.getElementById(parent.opener.attach_id).getAttribute('attach_id');
        attachName = parent.opener.document.getElementById(parent.opener.attach_id).getAttribute('attachName');

    }else{
        attach_id = parent.$("#"+parent.attach_id).attr('attach_id');
        attachName = parent.$("#"+parent.attach_id).attr('attachName');
    }
    $(function () {
        $('#prosonBox').on('click',function () {
            reloadTree()
            $('#prosonOrg').slideToggle();

        })
        $('#publicBox').on('click',function () {
            $('#publicOrg').slideToggle();
            publicTree()
        })
        $('#doneBox').on('click',function () {
            $('.doneCheck').show();
            $('.pleaseCheck').hide();
            if($('#trList_s').find('.trAttach')){
                $('#doneTable').show();
                $('.noDoneFile').hide();
            }else{
                $('#doneTable').hide();
                $('.noDoneFile').show();
            }
        })
//        点击已选中的复选框
        $('#trList_s').on('click','.checkBtn',function () {
            var attaFile=$(this).parents('.trAttach').find('.checkedFile');
            var attachId=$(attaFile).attr('attachid');
            var attachName=$(attaFile).attr('attachname');
            var name=$(attaFile).text();
            var dataId=$(attaFile).attr('id');
            var state=$(this).prop('checked');
            var str='<div class="dech" id="'+dataId+'">' +
                '<a href="javascript:;" style="color: #000;" NAME="' + attachName + '"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + name + '</a>' +
                '<input type="hidden" class="inHidden" value="'+attachId+'">' +
                '</div>';
            var childElement=parent.opener.document.getElementById('fileContent');
            if(state == true){
                $(this).prop('checked',true);
                $(childElement).append(str);
            }else{
                $(this).prop('checked',false);
                $(childElement).find('#'+dataId).remove();
            }
        })
//        个人文件柜树加载方法
        reloadTree=function () {
            $('#prosonOrg').tree({
                url: '/newFilePri/getPriFileSort',
                animate: true,
                lines: false,
                loadFilter: function (rows) {
                    return convert(rows.datas);
                },
                onClick: function (node) {
                    $(this).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
                    node.state = node.state === 'closed' ? 'open' : 'closed';
                    prosonInit(node.id)
                },
                onLoadSuccess: function (node, data) {
                    $('#prosonOrg').tree('collapseAll');
//                    $("#prosonOrg li").find("div[node-id='0']").addClass("tree-node-selected marginDiv");   //设置第一个节点高亮
                    $("#prosonOrg li").find("div[node-id='0']").find('.tree-file').css('background','url("/img/file/icon_directory.png") no-repeat 0px');
                    var n = $("#prosonOrg").tree("getSelected");
                    if (n != null) {
                        $("#prosonOrg").tree("select", n.target);    //相当于默认点击了一下第一个节点，执行onSelect方法
                    }
                },
            });
        }
//        公共文件柜树加载方法
        publicTree=function () {
            $('#publicOrg').tree({
                url: '/newFilePub/getNewAllPrivateFile?sortId=0',
                animate:true,
                lines: false,
                loadFilter: function(rows){
                    var arr = converts(rows.datas);
                    return arr;
                },
                onClick:function(node){
                    $(this).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
                    node.state = node.state === 'closed' ? 'open' : 'closed';
                    pubilcInit(node.id)
                },
                onBeforeExpand:function(node,param){
                    $('#publicOrg').tree('options').url = '/newFilePub/getNewAllPrivateFile?sortId='+node.id;// change the url
                }

            });
        }
        //处理树结构
        function convert(rows) {
            function exists(rows, parentId) {
                for (var i = 0; i < rows.length; i++) {
                    if (rows[i].sortId == parentId) return true;
                }
                return false;
            }
            var nodes = [];
            for (var i = 0; i < rows.length; i++) {
                var row = rows[i];
                if (!exists(rows, row.sortParent)) {
                    nodes.push({
                        id: row.sortId,
                        text: row.sortName,
                        attributes:row.attributes
                    });
                }
            }
            var toDo = [];
            for (var i = 0; i < nodes.length; i++) {
                toDo.push(nodes[i]);
            }
            while (toDo.length) {
                var node = toDo.shift();	// the parent node
                // get the children nodes
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    if (row.sortParent == node.id) {  //判断当前id和父级id相等
                        var child = {id: row.sortId, text: row.sortName,attributes:row.attributes};
                        if (node.children) { //如果存在子级，能够执行关闭、打开操作
                            if (node.id != 0) {
                                node.state = "closed"
                            }
                            node.children.push(child);
                        } else {

                            node.children = [child];
                        }
                        toDo.push(child);
                    }
                }
            }
            return nodes;
        }

        function TreeNode(id,text,state,children){
            this.id = id;
            this.text = text;
            this.state = state;
            this.children = children;
        }
//       处理树结构
        function converts(data){
            var arr = [];
            data.forEach(function(v,i){
                if(v.sortName){
                    var node = new TreeNode(v.sortId,v.sortName,"closed")
                    arr.push(node);
                }
            });
            return arr;
        }
//        个人文件柜附件显示
        function prosonInit(id) {
            $('.doneCheck').hide();
            $('.pleaseCheck').show();
            $.ajax({
                type:'get',
                url:'/newFileContent/getFileContentBySortId',
                dataType:'json',
                data:{
                    userId:genCookie,
                    sortId:id,
                    useFlag:false
                },
                success:function (res) {
                    var str='';
                    var arr=[];
                    if(res.flag){
                        if(res.datas.length > 0){ //判断是否存在数据
                            for(var i=0;i<res.datas.length;i++){
                                if(res.datas[i].attachmentList != undefined){
                                    $('#dept_item_2').show();
                                    $('.noFile').hide()
                                    arr.push(res.datas[i].attachmentList);
                                    var attachList=res.datas[i].attachmentList;
                                    if(attachList.length > 0){ //判断是否存在附件
                                        str+='<tr>' +
                                            '<td>'+res.datas[i].subject+'</td>' +
                                            '<td>'+function () {
                                                var stra='';
                                                for(var j=0;j<attachList.length;j++){
                                                    stra+='<div>' +
                                                        '<a href="javascript:;" id="'+attachList[j].aid+'" class="checkedFile" attachId="'+attachList[j].id+'" attachName="'+attachList[j].name+'">'+attachList[j].attachName+'</a>' +
                                                        '</div>'
                                                }
                                                return stra;
                                            }()+'</td>' +
                                            '</tr>'
                                    }
                                }
                            }
                        }
                        if(arr.length == 0){
                            $('#dept_item_2').hide();
                            $('.noFile').show();
                        }else{
                            $('#dept_item_2').show();
                            $('.noFile').hide()
                            $('#trList').html(str)
                        }
                    }
                }
            })
        }
//        公共文件柜附件显示
        function pubilcInit(id) {
            $('.doneCheck').hide();
            $('.pleaseCheck').show();
            $.ajax({
                type:'get',
                url:'/newFileContent/getContentById',
                dataType:'json',
                data:{
                    sortType:5,
                    sortId:id,
                    useFlag:false
                },
                success:function (res) {
                    var datas=res.object
                    var str='';
                    var arr=[];
                    if(res.flag){
                        if(datas.contentList.length > 0){ //判断是否存在数据
                            for(var i=0;i<datas.contentList.length;i++){
                                if(datas.contentList[i].attachmentList != undefined){
                                    $('#dept_item_2').show();
                                    $('.noFile').hide()
                                    arr.push(datas.contentList[i].attachmentList);
                                    var attachList=datas.contentList[i].attachmentList;
                                    if(attachList.length > 0){ //判断是否存在附件
                                        str+='<tr>' +
                                            '<td>'+datas.contentList[i].subject+'</td>' +
                                            '<td>'+function () {
                                                var stra='';
                                                for(var j=0;j<attachList.length;j++){
                                                    stra+='<div>' +
                                                        '<a href="javascript:;" id="'+attachList[j].aid+'" class="checkedFile" attachId="'+attachList[j].id+'" attachName="'+attachList[j].name+'">'+attachList[j].attachName+'</a>' +
                                                        '</div>'
                                                }
                                                return stra;
                                            }()+'</td>' +
                                            '</tr>'
                                    }
                                }
                            }
                        }
                        if(arr.length == 0){
                            $('#dept_item_2').hide();
                            $('.noFile').show();
                        }else{
                            $('#dept_item_2').show();
                            $('.noFile').hide()
                            $('#trList').html(str)
                        }
                    }
                }
            })
        }
//        选择文件
        $('.pleaseCheck').on('click','.checkedFile',function () {
            var attachId=$(this).attr('attachid');
            var sttachName=$(this).attr('attachname');
            var name=$(this).text();
            var aId=$(this).attr('id');
            var str='<div class="dech" id="'+aId+'">' +
                '<a href="javascript:;" style="color: #000;" NAME="' + sttachName + '"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + name + '</a>' +
                '<input type="hidden" class="inHidden" value="'+attachId+'">' +
                '</div>';
            var stra='<tr class="trAttach">' +
                '<td><input type="checkbox" class="checkBtn" value="" checked></td>' +
                '<td><a href="javascript:;" id="'+aId+'" class="checkedFile" attachId="'+attachId+'" attachName="'+sttachName+'">'+name+'</a></td>' +
                '</tr>';
            var childElement=parent.opener.document.getElementById('fileContent');
            if($(childElement).find('#'+aId).attr('id') == undefined){  //判断是否已经选择
                $(childElement).append(str);
            }else{
                var childDech=$(childElement).find('.dech');
                if($(childDech).attr('id') == aId){
                    $(childElement).find('#'+aId).remove();
                }
            }
            if($('#trList_s').find('#'+aId).attr('id') == undefined){ //判断已选是否存在
                $('#trList_s').append(stra);
            }else{
                if($('#trList_s').find('.checkedFile').attr('id') == aId){
                    $('#trList_s').find('#'+aId).parents('.trAttach').remove();
                }
            }
        })
    })
    function close_window() {
        window.close();
    }
</script>
</html>
