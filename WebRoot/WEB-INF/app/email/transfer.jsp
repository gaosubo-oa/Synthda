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
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Content-Type"  content="multipart/form-data; charset=utf-8" />
    <title><fmt:message code="email.th.transferOfFile" /></title>
    <link rel="stylesheet" type="text/css" href="../css/sys/journal.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../css/easyui/easyui.css">
    <link rel="stylesheet" type="text/css" href="../css/easyui/icon.css">
    <script src="/js/common/language.js"></script>
<%--    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>

    <script src="../lib/laydate.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../js/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/easyui/easyui-lang-zh_CN.js"></script>
    <script src="/js/attachment/attachView.js?20210406.1" type="text/javascript" charset="utf-8"></script>
    <script src="../js/jquery/jquery.form.min.js" type="text/javascript" charset="utf-8"></script>

    <style type="text/css">
        table{
            font-size: 11pt;
        }
        table tr td:first-child {
            font-size: 13pt;
        }
        table .newData td{
            font-size: 11pt !important;
        }
        .next,.save,.close{
            background-color: #fafafa;
            border-radius: 3px;
            height: 21px;
            line-height: 13px;
            padding: 2px 6px;
            font-size: 13px;
            color: #333;
            margin: 1px;
            text-decoration: none;
            text-align: center;
            cursor: pointer;
            -webkit-appearance: none;
            border: 1px solid #ddd;
        }

    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<div class="content">

    <div class="mainCon" style="width: 100%;margin-top: 0px;">
        <div class="journalSurvey" style="display: block;">
            <div class="title">
                <div class="div_Img">
                    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_logProfile.png" style="vertical-align: middle;" alt="<fmt:message code="journal.th.MenuMain" />">
                </div>
                <div class="new"><fmt:message code="email.th.transferOfFile" />-<span class="filename"></span></div>
            </div>
            <div class="table">
                <table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff">
                    <tr>
                        <td class="tit"  style="text-align: left;color: #2F5C8F;"><fmt:message code="email.th.recipients" />：</td>
                    </tr>
                    <tr>

                        <td width="80%" class="choose">
                            <input type="radio" name="fileBox" checked value="0"><span><fmt:message code="main.personnel" /></span>
                            <input type="radio" name="fileBox" value="1"><span><fmt:message code="main.public" /></span>
                            <%--<input type="radio" name="fileBox" value="2"><span>网络硬盘</span>--%>
                        </td>

                    </tr>
                    <tr>
                        <td width="80%" class="list" style="display: none;">
                           <div id="fileList" class="easyui-tree">

                           </div>
                            <input type="hidden" class="boxId">
                        </td>

                    </tr>
                    <tr>
                        <td width="80%" class="list" style="display: none;">
                            <div id="" >
                                <fmt:message code="email.th.transferOfFileName" />： <input type="text" class="fileName" disabled style="width: 300px;">
                            </div>

                        </td>
                    </tr>
                    <tr>
                        <%--<form id="uploadimgform" target="uploadiframe"  action="/common/turnSave" enctype="multipart/form-data" method="post" >--%>

                        <%--</form>--%>
                        <td width="80%" class="" style="text-align:center">
                            <span class="next" type="0"><fmt:message code="workflow.th.Nextst" /></span>
                            <span class="save" style="display:none"><fmt:message code="workflow.th.Dump" /></span>
                            <span class="close"><fmt:message code="global.lang.close" /></span>
                        </td>
                    </tr>

                </table>
            </div>

        </div><!--日志概况结束-->



    </div>
</div>
<script type="text/javascript">
    var url = window.location.search;
    var attaName = decodeURI(url.split('ATTACHMENT_NAME=')[1]).replace('%2b', "+").replace('%40',"@").replace('%23',"#").replace('%26',"&").replace('%2F',"/").replace('%3F',"?").replace('%ef%bf%a5',"￥").replace('%24',"$").replace('%ef%bc%81',"！").replace('%ef%bc%88',"（").replace('%ef%bc%89',"）").replace('%e2%80%a6%e2%80%a6',"…").replace('%40',"@");
    // var attaId = $.GetRequest().AID+'@'+$.GetRequest().YM+'_'+$.GetRequest().ATTACHMENT_ID
    var attaId = $.GetRequest().ATTACHMENT_ID

    $('.filename').html(decodeURI(attaName))
    $('.fileName').val(decodeURI(attaName))


    $('.next').on('click',function(){
        var type = $(this).attr('type')
        if(type == 0){
            $(this).text('<fmt:message code="workflow.th.upstep" />');
            $(this).attr('type',1);
            $('.save').show();
            $('.list').show();
            $('.choose').hide();

            if($('input[type="radio"]:checked').val()==0){
                person();
            }else if($('input[type="radio"]:checked').val()==1){
                publicFile();
            }
        }else if(type == 1){
            $(this).text('<fmt:message code="workflow.th.Nextst" />');
            $(this).attr('type',0);
            $('.list').hide();
            $('.choose').show();
            $('.save').hide();
        }
    })
//    转存
    $('.save').on('click',function(){
        if($('.tree-node-selected').attr('node-id')==undefined){
            $.layerMsg({content:'<fmt:message code="email.th.pleaseSelectTheLocationToTransferAndSave" />',icon:2});
            return false;
        }/*else if($('.tree-node-selected').attr('node-id')==0){
            $.layerMsg({content:'请转存到非根目录的文件夹下',icon:2});
            return false;
        }*/
        var data={
            'sortId':$('.tree-node-selected').attr('node-id'),
            'ATTACHMENT_NAME':$('.fileName').val(),
            'ATTACHMENT_ID':attaId,
           'MODULE':$.GetRequest().MODULE,
            'AID':$.GetRequest().AID,
            'YM':$.GetRequest().YM,
            'COMPANY':$.GetRequest().COMPANY
        }
        if($('input[type="radio"]:checked').val()==1){
            data.sortType = 5;
            var datas={
                'sortId':$('.tree-node-selected').attr('node-id'),
                'sortType':5,
                'page':1,//当前处于第几页
                'pageSize':10,//一页显示几条
                'useFlag':true,
            }
            $.ajax({
                type:'post',
                url:'/newFileContent/getContentById',
                dataType:'json',
                data:datas,
                success:function(res){
                    var nodeData=res.object;

                    if(nodeData.attributes.NEW_USER != 1&&nodeData.attributes.OWNER != 1){ //新建权限
                        $.layerMsg({content:'<fmt:message code="email.th.noTransferPermission" />',icon:2});
                        return false;
                    }else{
                        $.ajax({
                            url:'/common/turnSave',
                            dataType:'json',
                            type:'get',
                            data:data,
                            success:function (res) {
                                if(res.flag){
                                    $.layerMsg({content:'<fmt:message code="email.th.transferAndSaveSuccessfully" />',icon:1,time:1000},function(){
                                        window.close();
                                    });
                                }else{
                                    $.layerMsg({content:'<fmt:message code="email.th.transferAndSaveFailed" />',icon:2,time:1000});
                                }

                            }
                        })
                    }
                }
            });
        }else{
            $.ajax({
                url:'/common/turnSave',
                dataType:'json',
                type:'get',
                data:data,
                success:function (res) {
                    if(res.flag){
                        $.layerMsg({content:'<fmt:message code="email.th.transferAndSaveSuccessfully" />',icon:1,time:1000},function(){
                            window.close();
                        });
                    }else{
                        $.layerMsg({content:'<fmt:message code="email.th.transferAndSaveFailed" />',icon:2,time:1000});
                    }

                }
            })
        }

            // $.ajax({
            //     url:'/common/turnSave',
            //     type:'post',
            //     dataType:'json',
            //     data:data,
            //     success:function(res){
            //         console.log(res)
            //     }
            // })




    })
//    关闭
    $('.close').on('click',function(){
        window.close();
    })

//    个人文件柜
    function person(){
        var dataTr;
        $('#fileList').tree({
            url: '/newFilePri/getPriFileSort',
            animate: true,
            lines: false,
            loadFilter: function (rows) {
                console.log(rows)
                return convert(rows.datas);
            },
            onClick: function (node) {

            },
            onLoadSuccess: function (node, data) {

                $('#fileList').tree('collapseAll');
                $("#fileList li").find("div[node-id='0']").addClass("tree-node-selected marginDiv");   //设置第一个节点高亮
                $("#fileList li").find("div[node-id='0']").find('.tree-file').css('background','url("/img/file/icon_directory.png") no-repeat 0px');
                var n = $("#filfileListeTree").tree("getSelected");
                if (n != null) {
                    $("#fileList").tree("select", n.target);    //相当于默认点击了一下第一个节点，执行onSelect方法
                }


                for(var i=0;i<data.length;i++){

                    var node = $("#fileList").tree("find",data[i].id);//找到id对应的节点
                    $(node.target).attr("title",data[i].text);//.target得到dom对象，设置title
                    if(data[i].children!=undefined){
                        buildNode(data[i].children)
                    }

                }

            },
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
        if(rows != undefined){
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
                if (row.sortParent == node.id) {
                    var child = {id: row.sortId, text: row.sortName,attributes:row.attributes};
                    if (node.children) {
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

    //公共文件柜
    function publicFile(){
        $('#fileList').tree({
            url: '/newFilePub/getNewAllPrivateFile?sortId=0',
            animate:true,
            lines: false,
            loadFilter: function(rows){
                var arr = convert2(rows.datas);
                return arr;
            },
            onLoadSuccess: function (row, data) {
                for(var i=0;i<data.length;i++){
                    var node = $("#fileList").tree("find",data[i].id);//找到id对应的节点
                    $(node.target).attr("title",data[i].text);//.target得到dom对象，设置title
                    if(data[i].children!=undefined){
                        buildNode(data[i].children)
                    }
                }
            },
            onClick:function(node){


            },
            onBeforeExpand:function(node,param){
                $('#fileList').tree('options').url = '/newFilePub/getNewAllPrivateFile?sortId='+node.id;// change the url
            }

        });
    }
    function convert2(data){

        var arr = [];
        data.forEach(function(v,i){
            if(v.sortName){
                var node = new TreeNode(v.sortId,v.sortName,"closed")
                arr.push(node);
            }
        });
        return arr;
    }
    function TreeNode(id,text,state,children){
        this.id = id;
        this.text = text;
        this.state = state;
        this.children = children;
    }
    function buildNode(data){
        $.each(data,function(i,item){

            if(item.children!= undefined && 0 < item.children.length){
                var node = $("#fileList").tree("find",data[i].id);//找到id对应的节点
                $(node.target).attr("title",data[i].text);//.target得到dom对象，设置title
                buildNode(item.children);
            }else{
                var node = $("#fileList").tree("find",data[i].id);//找到id对应的节点
                $(node.target).attr("title",data[i].text);//.target得到dom对象，设置title
            }
        });
    }


</script>
</body>
</html>

