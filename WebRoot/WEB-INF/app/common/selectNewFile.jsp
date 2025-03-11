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
    <title><fmt:message code="common.th.selFile" /></title><%--选择文件柜附件--%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%--    <meta name="renderer" content="webkit">--%>
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/common/style.css" />
    <link rel="stylesheet" type="text/css" href="../css/common/select.css" />
    <link rel="stylesheet" type="text/css" href="../css/common/org_select.css">
    <link rel="stylesheet" type="text/css" href="../lib/easyui/themes/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/easyui/themes/icon.css"/>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/js/base/base.js?20201111.1"></script>
    <script type="text/javascript" src="../lib/easyui/jquery.easyui.min.js" ></script>
    <script type="text/javascript" src="../lib/easyui/tree.js" ></script>
</head>
<style type="text/css">
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
    .block-right-header,.block-right-add,.block-right-remove{
        display: none;
    }
    .onlineRight{
        width: 98%;
        left: 0 !important;
        border-left: none !important;
        padding: 8px !important;
        margin: 0 auto;
    }
    #allPriv .block-left-item:hover{
        background: #e7f2fa;
    }
    .privActive{
        background: #c7e1f6 !important;
        font-weight: bold;
    }
    .textLeft{
        text-align: left !important;

    }
    #allGroup .block-left-item:hover{
        background: #e7f2fa;
    }
    #query_userId{
        border: 1px solid #d9d9d9;
        width: 91%;
        height: 100px;
        border-radius: 4px;
        margin-top: 15px;
        margin-left: 20px;
        color: #666;
        padding: 5px;
    }

    .addcustom{
        position: fixed;
        bottom: 5px;
        /* display: block; */
        color: #fff;
        left: 32px;
        background-color: #5bc0de;
        border-color: #46b8da;
        padding: 6px 12px;
        width: 106px;
        text-align: center;
        border-radius: 2px;
        z-index: 99999;
        cursor: pointer;
    }
    .status{padding-left:10px}
    .gwpost,.zwposition{
        height: 20px;
        margin-top: 4px;
        margin-left: 4px;
    }
    #navMenu span {
        float: left;
        overflow: hidden;
        color: #000000;
        text-decoration: none;
        padding-left: 5px;
        font-size: 14px;
        background: url(../../img/common/menu_top_line.png) no-repeat top right;
        height: 30px;
    }

</style>
<body>
<!-- //开始 -->
<!-- //头部 -->

<div id="north">
    <div id="navMenu" style="width:auto;">
        <a href="#" title='<fmt:message code="common.th.selPerson" />' class="tab_btn"  block="selected" hidefocus="hidefocus"><span><fmt:message code="common.th.selected" /></span></a><%--已选人员 已选--%>
        <%--<a href="#" title='<fmt:message code="common.th.selByDepart" />' id="department" block="dept" hidefocus="hidefocus" class=" tab_btn active"><span><fmt:message code="userManagement.th.department" /></span></a>&lt;%&ndash;按部门选择 部门&ndash;%&gt;--%>
        <a href="#" title="按个人文件柜选择" id="privBtn" class="tab_btn active" block="priv" hidefocus="hidefocus"><span>个人文件柜</span></a>
        <a href="#" title="按公共文件柜选择" id="comBtn" class="tab_btn" block="com" hidefocus="hidefocus"><span>公共文件柜</span></a>
        <%--<a href="#" title="按自定义组选择" id="customGroup" class="tab_btn" block="custom" hidefocus="hidefocus"><span>个人分组</span></a>--%>
        <%--<a href="#" title="从在线人员选择" id="userOnline" class="tab_btn" block="online" hidefocus="hidefocus"><span>在线</span></a>--%>
        <%--<a href="#" block="query" class="tab_btn" hidefocus="hidefocus" style="display:none;"><span><fmt:message code="workflow.th.sousuo" /></span></a>&lt;%&ndash;搜索&ndash;%&gt;--%>
        <%--<span href="javascript:;" style="width: 100px;">--%>
        <%--<select name="jobId" class="gwpost">--%>
        <%--<option value="">请选择岗位</option>--%>
        <%--</select>--%>
        <%--</span>--%>
        <%--<span href="javascript:;">--%>
        <%--<select name="postId" class="zwposition">--%>
        <%--<option value="">请选择职务</option>--%>
        <%--</select>--%>
        <%--</span>--%>
    </div>
    <%--<div id="navRight" style="float:right;">--%>
        <%--<div class="search">--%>
            <%--<div class="search-body">--%>
                <%--<div class="search-input"><input notlogin_flag="" id="keyword" type="text" value=""></div>--%>
                <%--<div id="search_clear" class="search-clear" style="display:none;"></div>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
</div>

<!-- //内容 -->
<div>
    <!-- 已选 -->
    <div class="main-block" id="selectedDox" >
        <div class="left moduleContainer" id="dept_menu">
            <div class="tree">
                <ul class="dynatree-container dynatree-no-connector" >
                </ul>
            </div>

        </div>
        <div class="right" id="dept_item">
            <div class="block-right" id="dept_item_2">
                <!-- 部门名 -->

                <div class="block-right-remove"><fmt:message code="meet.th.DeleteAll" /></div><%--全部删除--%>

                <div class="userItem">
                </div>
            </div>
        </div>
    </div>
    <!-- 个人文件柜 -->
    <div class="main-block" id="privBox" style="display:block;">
        <div class="left moduleContainer" id="priv_menu" style="overflow: scroll">

            <div class="tree">
                <%--<div class="pickCompany">--%>
                <%--<span  class="childdept" style="display: none;">--%>
                <%--<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 5px;margin-left: 5px;margin-bottom: 4px;">--%>
                <%--<input type="checkbox" id="checkedUserAll" value="" style="width: 15px;height: 15px;">--%>
                <%--<a href="javascript:void(0)" class="dynatree-title" onclick="initTree();"  id="companyName" title=""></a>--%>
                <%--</span>--%>
                <%--</div>--%>
                <ul class="dynatree-container dynatree-no-connector" style="margin-left: 10px;" id="privOrg">
                </ul>
            </div>

        </div>
        <div class="right" id="priv_item">
            <div class="block-right" id="priv_item_2">
                <!-- 部门名 -->
                <div class="block-right-header" title="" style="background: #b6e0ff;"></div>

                <div onclick="addAllUser($('#privBox'))" class="block-right-add"><fmt:message code="meet.th.addAll" /></div><%--全部添加--%>
                <div onclick="deleteAllUser($('#privBox'))" class="block-right-remove"><fmt:message code="meet.th.DeleteAll" /></div><%--全部删除--%>
                <div class="userItem curDept">

                </div>
            </div>
        </div>
    </div>
    <!-- 公共文件柜 -->
    <div class="main-block" id="comBox">
        <div class="left moduleContainer" id="com_menu" style="overflow: scroll">

            <div class="tree">
                <%--<div class="pickCompany">--%>
                <%--<span  class="childdept" style="display: none;">--%>
                <%--<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 5px;margin-left: 5px;margin-bottom: 4px;">--%>
                <%--<input type="checkbox" id="checkedUserAll" value="" style="width: 15px;height: 15px;">--%>
                <%--<a href="javascript:void(0)" class="dynatree-title" onclick="initTree();"  id="companyName" title=""></a>--%>
                <%--</span>--%>
                <%--</div>--%>
                <ul class="dynatree-container dynatree-no-connector" style="margin-left: 10px;" id="comOrg">
                </ul>
            </div>

        </div>
        <div class="right" id="com_item">
            <div class="block-right" id="com_item_2">
                <!-- 部门名 -->
                <div class="block-right-header" title="" style="background: #b6e0ff;"></div>

                <div  onclick="addAllUser($('#comBox'))" class="block-right-add"><fmt:message code="meet.th.addAll" /></div><%--全部添加--%>
                <div  onclick="deleteAllUser($('#comBox'))" class="block-right-remove"><fmt:message code="meet.th.DeleteAll" /></div><%--全部删除--%>
                <div class="userItem curDept">

                </div>
            </div>
        </div>
    </div>
    <!-- 搜索 -->
    <%--<div class="main-block" id="searchName" style="display: none;">--%>
        <%--<div class="right onlineRight" id="search_online">--%>
            <%--<div class="block-right" id="search_onlineUser" style="display: block;">--%>
                <%--<div class="block-right-header" title="" style="background: #b6e0ff;" id="onlineUser">查询人员</div>--%>
                <%--<div id="onlineAdd" class="block-right-add" onclick="addAllUser($('#searchName'))"><fmt:message code="meet.th.addAll" /></div>&lt;%&ndash;全部添加&ndash;%&gt;--%>
                <%--<div class="block-right-remove" onclick="deleteAllUser($('#searchName'))"><fmt:message code="meet.th.DeleteAll" /></div>&lt;%&ndash;全部删除&ndash;%&gt;--%>

                <%--<div class="userItem">--%>

                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="noUsers" style="display: none;text-align: center;line-height: 100px;font-size: 12pt;">无符合条件的用户</div>--%>
        <%--</div>--%>
    <%--</div>--%>
</div>
<!-- //结束 -->
<div id="south">
    <span class="chooseBox">已选附件：</span><span class="chooseBox" style="color: red;margin-right: 10px;" data-num="0">0个</span>

    <input type="button" class="BigButtonA" value='<fmt:message code="global.lang.ok" />' onclick="close_window();">&nbsp;&nbsp;<%--确定--%>
</div>
</body>
<script type="text/javascript">
    if ((( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent))) {
        $('div.left').css('width', '150px');
        $('div.right').css('left', '158px');
    }
    var file_id;
    if(parent.opener && parent.opener.file_id){
        file_id = parent.opener.file_id
    }else{
        file_id = parent.file_id
    }
    var model;
    if(parent.opener && parent.opener.model){
        model = parent.opener.model
    }else{
        model = parent.model
    }
    var urlType=location.href.split('?')[1];
    var onLine=[];
    function check(name){
        if(name == undefined){
            return '无'
        }else{
            return name
        }
    }
    var initTree;
    var initTree1;
    function close_window(){
        var itemsArr = $('#selectedDox .userItem .active');
        var itemnum=location.href.split('?')[1]
        var idstr = "";
        for(var i=0;i<itemsArr.length;i++){
            var obj = itemsArr.eq(i);
            idstr += obj.attr("attch_id")+","
        };
        $.ajax({
            url: '/newFilePub/copyFile',
            dataType: 'json',
            type: 'post',
            data: {
                model: model
                ,attachmentIds: idstr
            },
            success: function (res) {
                if(res.flag){
                    if(res.data.length>0) {
                        //父页面数据 有下载查看按钮
                        if (itemnum == 1 || itemnum == "1" || itemnum.indexOf("1")>-1) {
                            var listStr = "";
                            for (var i = 0; i < res.data.length; i++) {
                                var fileExtension = res.data[i].attachName.substring(res.data[i].attachName.lastIndexOf(".") + 1, res.data[i]
                                    .attachName.length);
                                var attName = encodeURI(res.data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                var deUrl = res.data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+res.data[i].size;
                                if(fileExtension == 'jpg'|| fileExtension == 'png'|| fileExtension == 'gif'|| fileExtension == 'jpeg'|| fileExtension == 'svg'|| fileExtension == 'swf'){
                                    listStr += '<div class="dech"   NAME1="' + res.data[i].attachName + '" deUrl="' + res.data[i].attUrl + '">' +
                                        '<a href="/download?' + encodeURI(res.data[i].attUrl) + '" NAME="' + res.data[i].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
                                        '<img  src="/img/attachment_icon.png"/>' + res.data[i].attachName + '</a>' +
                                        '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' +
                                        '<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px">' +
                                        '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                        '<a style="padding-left: 5px" href="/download?' + encodeURI(res.data[i].attUrl) + '" >' +
                                        '<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
                                        '<input type="hidden" class="inHidden" value="' + res.data[i].aid + '@' + res.data[i].ym + '_' + res.data[i].attachId + ',"></div>';

                                }else if(fileExtension == 'docx'|| fileExtension == 'doc'|| fileExtension == 'xls' || fileExtension == 'xlsx' || fileExtension == 'pptx'){
                                    listStr += '<div class="dech"   NAME1="' + res.data[i].attachName + '" deUrl="' + res.data[i].attUrl + '"><a href="/download?' + encodeURI(res.data[i].attUrl) + '" NAME="' + res.data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + res.data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><a fileExtension="' + fileExtension + '" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a><a style="padding-left: 5px" href="/download?' + encodeURI(res.data[i].attUrl) + '" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><a class="operation" href="javascript:;" onclick="editAttachment($(this))" class="editFile" style="margin-left: 10px;" attrurl="' + deUrl + '"><img src="/img/attachmentIcon/icon_edit.png" style="margin-right: 5px;" alt="">编辑</a><input type="hidden" class="inHidden" value="' + res.data[i].aid + '@' + res.data[i].ym + '_' + res.data[i].attachId + ',"></div>';
                                }else if(fileExtension == 'zip'|| fileExtension == 'mp4' || fileExtension == 'rar'){
                                    listStr += '<div class="dech"   NAME1="' + res.data[i].attachName + '" deUrl="' + res.data[i].attUrl + '">' +
                                        '<a href="/download?' + encodeURI(res.data[i].attUrl) + '" NAME="' + res.data[i].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
                                        '<img  src="/img/attachment_icon.png"/>' + res.data[i].attachName + '</a>' +
                                        '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' +
                                        '<a style="padding-left: 5px" href="/download?' + encodeURI(res.data[i].attUrl) + '" >' +
                                        '<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
                                        '<input type="hidden" class="inHidden" value="' + res.data[i].aid + '@' + res.data[i].ym + '_' + res.data[i].attachId + ',"></div>';
                                }else{
                                    listStr += '<div class="dech"   NAME1="' + res.data[i].attachName + '" deUrl="' + res.data[i].attUrl + '">' +
                                        '<a href="/download?' + encodeURI(res.data[i].attUrl) + '" NAME="' + res.data[i].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
                                        '<img  src="/img/attachment_icon.png"/>' + res.data[i].attachName + '</a>' +
                                        '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' +
                                        '<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px">' +
                                        '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                        '<a style="padding-left: 5px" href="/download?' + encodeURI(res.data[i].attUrl) + '" >' +
                                        '<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
                                        '<input type="hidden" class="inHidden" value="' + res.data[i].aid + '@' + res.data[i].ym + '_' + res.data[i].attachId + ',"></div>';
                                }
                            }
                            if (file_id) {
                                try {
                                    parent.opener.document.getElementById(file_id).appendChild(listStr);
                                } catch (e) {
                                    console.log(e);
                                    parent.opener.$("#" + file_id).append(listStr);
                                }
                            } else {
                                parent.opener.$("#" + file_id).append(listStr);
                            }
                            window.close();
                            //判断如果存在layer层，则关闭layer层
                            if (parent.selectUsreLayerIndex) {
                                parent.layer.close(parent.selectUsreLayerIndex);
                                return false;
                            }
                            parent.layer.closeAll();
                            //无下载查阅按钮
                        } else if(itemnum == 2 || itemnum == "2" || itemnum.indexOf("2")>-1){
                            var listStr = "";
                            for (var i = 0; i < res.data.length; i++) {
                                var fileExtension = res.data[i].attachName.substring(res.data[i].attachName.lastIndexOf(".") + 1, res.data[i].attachName.length);
                                listStr += '<div class="dech" deUrl="' + res.data[i].attUrl + '"><a href="/download?' + encodeURI(res.data[i].attUrl) + '" NAME="' + res.data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + res.data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + res.data[i].aid + '@' + res.data[i].ym + '_' + res.data[i].attachId + ',"></div>';
                            }
                            if (file_id) {
                                try {
                                    parent.opener.document.getElementById(file_id).appendChild(listStr);
                                } catch (e) {
                                    console.log(e);
                                    parent.opener.$("#" + file_id).append(listStr);
                                }
                            } else {
                                parent.opener.$("#" + file_id).append(listStr);
                            }
                            window.close();
                            //判断如果存在layer层，则关闭layer层
                            if (parent.selectUsreLayerIndex) {
                                parent.layer.close(parent.selectUsreLayerIndex);
                                return false;
                            }
                            parent.layer.closeAll();
                        }else if(itemnum == 0 || itemnum == "0"|| itemnum.indexOf("0")>-1){ //流程中文件柜样式
                            var iconImgType = {
                                txt : '../../img/icon_file.png',
                                jpg : '../../img/icon_image.png',
                                png : '../../img/icon_image.png',
                                pdf :  '../../img/icon_pdf.png',
                                ppt : '../../img/icon_ppt.png',
                                pptx :  '../../img/icon_ppt.png',
                                doc : '../../img/icon_word.png',
                                docx : '../../img/icon_word.png',
                                xls :  '../../img/icon_excel.png',
                                xlsx :  '../../img/icon_excel.png'
                            };
                            var listStr = "";
                            for (var i = 0; i < res.data.length; i++) {
                                var attachName = res.data[i].attachName;
                                var attachNameArrByc = attachName.split('.');
                                var attrnametype = attachNameArrByc[attachNameArrByc.length-1];
                                var thisspan = res.data[i].attachName;
                                var fileuploadSRC = iconImgType[attrnametype]||"../../img/icon_file.png";
                                if(attrnametype == 'doc'||attrnametype == 'docx'||attrnametype == 'DOC'||attrnametype == 'DOCX'||attrnametype == 'xls'||attrnametype == 'xlsx'||attrnametype == 'XLS'||attrnametype == 'XLSX'||attrnametype == 'ppt'||attrnametype == 'PPT'||attrnametype == 'ppt'||attrnametype == 'PPTX'||attrnametype == 'wps'||attrnametype == 'WPS'){
                                    listStr += '<div class="imgfileBox" style="display:  inline-block;position:  relative;"><img atturl="'+res.data[i].attUrl+'&userid='+ res.obj1 +'" name="'+file_id.attr('name')+'" src="'+fileuploadSRC+'" style="cursor: pointer;margin: 0 5px;'+file_id.attr('style')+'"  id="'+file_id.attr('name')+'" title="'+res.data[i].attachName+'" align="absmiddle" style=""  class="fileupload_data"    width="'+file_id.attr('width')+'" height="'+file_id.attr('height')+'"/><span class="uploadImg" title="'+ res.data[i].attachName +'" style="width:'+file_id.attr('width')+'px;text-align: center;">'+ thisspan +'</span><ul class="hoverbox" flag="true" ><li class="hoverboxLiDownload"><span class="plotting">></span>下载</li><li class="hoverboxLiPreview"><span class="plotting">></span>查阅</li><li class="hoverboxLiEdit"><span class="plotting">&gt;</span>编辑</li><li class="hoverboxLidelete"><span class="plotting">></span>删除</li></ul></div>';

                                }else{
                                    listStr += '<div class="imgfileBox" style="display:  inline-block;position:  relative;"><img atturl="'+res.data[i].attUrl+'&userid='+ res.obj1 +'" name="'+file_id.attr('name')+'" src="'+fileuploadSRC+'" style="cursor: pointer;margin: 0 5px;'+file_id.attr('style')+'"  id="'+file_id.attr('name')+'" title="'+res.data[i].attachName+'" align="absmiddle" style=""  class="fileupload_data"    width="'+file_id.attr('width')+'" height="'+file_id.attr('height')+'"/><span class="uploadImg" title="'+ res.data[i].attachName +'" style="width:'+file_id.attr('width')+'px;text-align: center;">'+ thisspan +'</span><ul class="hoverbox" flag="true" ><li class="hoverboxLiDownload"><span class="plotting">></span>下载</li><li class="hoverboxLiPreview"><span class="plotting">></span>查阅</li><li class="hoverboxLidelete"><span class="plotting">></span>删除</li></ul></div>';

                                }
                            }

                            if (file_id) {
                                try {
                                    file_id.get(0).insertBefore(listStr,file_id.get(0));
                                } catch (e) {
                                    console.log(e);
                                    file_id.before(listStr);
                                }
                            } else {
                                file_id.before(listStr);
                            }
                            window.close();
                            //判断如果存在layer层，则关闭layer层
                            if (parent.selectUsreLayerIndex) {
                                parent.layer.close(parent.selectUsreLayerIndex);
                                return false;
                            }
                            parent.layer.closeAll();
                        }else if(itemnum == 4 || itemnum == "4"|| itemnum.indexOf("4")>-1){ //流程h5样式
                            var http = 'http://'+ window.location.host;
                            var iconImgType = {
                                txt : '/img/icon_file.png',
                                jpg : '/img/icon_image.png',
                                png : '/img/icon_image.png',
                                pdf :  '/img/icon_pdf.png',
                                ppt : '/img/icon_ppt.png',
                                pptx :  '/img/icon_ppt.png',
                                doc : '/img/icon_word.png',
                                docx : '/img/icon_word.png',
                                xls :  '/img/icon_excel.png',
                                xlsx :  '/img/icon_excel.png'
                            };
                            var listStr = "";
                            for (var i = 0; i < res.data.length; i++) {
                                var imptarget = parent.$(file_id)
                                var attachName = res.data[i].attachName;
                                var url =  res.data[i].attUrl;
                                var name = attachName;
                                var attachNameArrByc = attachName.split('.');
                                var attrnametype = attachNameArrByc[attachNameArrByc.length-1];
                                var thisspan = res.data[i].attachName;
                                var fileuploadSRC = iconImgType[attrnametype]||"../../img/icon_file.png";
                                //var name_arr = name.split(',')[i];
                                var attrnametype = thisspan.split('.')[1];
                                if(attrnametype.replace(/^(.*[n])*.*(.|n)$/g, "$2") == ','){
                                    attrnametype = attrnametype.split(',')[0];
                                }
                                if(iconImgType[attrnametype] == undefined){
                                    var src = '/img/icon_file.png';
                                }else{
                                    var src = iconImgType[attrnametype];
                                }
                                var thisspan = attachName;
                                if(thisspan != ''){
                                    if(thisspan.split('.')[0].length > 8){
                                        var thisspan = thisspan.split('.')[0].substr(0,8)+'…'+thisspan.split('.')[1];
                                    }
                                }
                                //if (type == 4) {
                                listStr += '<div style="display:  inline-block;position:  relative;float: left;" class="imgfileBox">' +
                                    '<img atturl="'+ url +'" name="'+imptarget.attr('name')+'" names="'+attachName+'" onclick="anios1($(this))" src="'+ src +'" url="'+ url +'" ' +
                                    'style="cursor: pointer;"  id="'+imptarget.attr('name')+'" title="'+imptarget.attr('title')+'" align="absmiddle" style="width: 30px;height: 30px"  class="fileupload_data" />' +
                                    '<span class="uploadImg">'+ thisspan +'</span>' +
                                    '<span style="color: red;margin-left:15px;cursor:pointer;font-size: 12px;" class="hoverboxLidelete" atturl="'+url+'">×删除</span></br>'  +
                                    ' </div>';
                                //} else {
                                //    listStr += '<div style="display:  inline-block;position:  relative;float: left;height: 90px;"><img atturl="'+ arr[i].split('/download?')[1] +'" name="'+imptarget.attr('name')+'" names="'+name_arr[0]+'" onclick="anios1($(this))" src="'+ src +'" url="'+ arr[i].split('/download?')[1] +'" style="cursor: pointer;"  id="'+imptarget.attr('name')+'" title="'+imptarget.attr('title')+'" align="absmiddle" style=""  class="fileupload_data"    width="'+imptarget.attr('width')+'" height="'+imptarget.attr('height')+'"/><span class="uploadImg">'+ thisspan +'</span></div>';
                                //}
                                // if(attrnametype == 'doc'||attrnametype == 'docx'||attrnametype == 'DOC'||attrnametype == 'DOCX'||attrnametype == 'xls'||attrnametype == 'xlsx'||attrnametype == 'XLS'||attrnametype == 'XLSX'||attrnametype == 'ppt'||attrnametype == 'PPT'||attrnametype == 'ppt'||attrnametype == 'PPTX'||attrnametype == 'wps'||attrnametype == 'WPS'){
                                //     listStr += '<div class="imgfileBox" style="display:  inline-block;position:  relative;"><img atturl="'+res.data[i].attUrl+'&userid='+ res.obj1 +'" name="'+file_id.attr('name')+'" src="'+fileuploadSRC+'" style="cursor: pointer;margin: 0 5px;'+file_id.attr('style')+'"  id="'+file_id.attr('name')+'" title="'+res.data[i].attachName+'" align="absmiddle" style=""  class="fileupload_data"    width="'+file_id.attr('width')+'" height="'+file_id.attr('height')+'"/><span class="uploadImg" title="'+ res.data[i].attachName +'" style="width:'+file_id.attr('width')+'px;text-align: center;">'+ thisspan +'</span><ul class="hoverbox" flag="true" ><li class="hoverboxLiDownload"><span class="plotting">></span>下载</li><li class="hoverboxLiPreview"><span class="plotting">></span>查阅</li><li class="hoverboxLiEdit"><span class="plotting">&gt;</span>编辑</li><li class="hoverboxLidelete"><span class="plotting">></span>删除</li></ul></div>';
                                // }else{
                                //     listStr += '<div class="imgfileBox" style="display:  inline-block;position:  relative;"><img atturl="'+res.data[i].attUrl+'&userid='+ res.obj1 +'" name="'+file_id.attr('name')+'" src="'+fileuploadSRC+'" style="cursor: pointer;margin: 0 5px;'+file_id.attr('style')+'"  id="'+file_id.attr('name')+'" title="'+res.data[i].attachName+'" align="absmiddle" style=""  class="fileupload_data"    width="'+file_id.attr('width')+'" height="'+file_id.attr('height')+'"/><span class="uploadImg" title="'+ res.data[i].attachName +'" style="width:'+file_id.attr('width')+'px;text-align: center;">'+ thisspan +'</span><ul class="hoverbox" flag="true" ><li class="hoverboxLiDownload"><span class="plotting">></span>下载</li><li class="hoverboxLiPreview"><span class="plotting">></span>查阅</li><li class="hoverboxLidelete"><span class="plotting">></span>删除</li></ul></div>';
                                //
                                // }
                            }
                            if (file_id) {
                                try {
                                    file_id.get(0).insertBefore(listStr,file_id.get(0));
                                } catch (e) {
                                    console.log(e);
                                    file_id.before(listStr);
                                }
                            } else {
                                file_id.before(listStr);
                            }
                            window.close();
                            //判断如果存在layer层，则关闭layer层
                            if (parent.selectUsreLayerIndex) {
                                parent.layer.close(parent.selectUsreLayerIndex);
                                return false;
                            }
                            parent.layer.closeAll();
                        }else{

                        }
                    }
                }else{
                   layer.msg(res.msg);
                   return false;
                }
            }
        });
    }
    $(function(){
        //个人文件柜左侧树加载方法
        initTree = function(){
            var url = '/newFilePri/getPriFileTree'
            $('#privOrg').tree({
                url: url,
                animate:true,
                // checkbox:true,
                cascadeCheck:true,
                loadFilter: function(node){
                    return convert(node.datas);
                },
                onClick:function(node){
                    buildNewUserList(node.id,node.text,"#privBox","/newFileContent/getFileContentBySortId?sortId=");
                    $(this).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
                    node.state = node.state === 'closed' ? 'open' : 'closed';
                },
                onDblClick:function (node) {

                },
                onLoadSuccess:function(node,data){
                    if(data.length>0){
                        if($("#privOrg").find("li").find('div[node-id='+data[0].id+']').parent().parent().prev("div").length == 0){
                            $("#privOrg").find("li").find("div").removeClass("tree-node-selected")
                            $("#privOrg").find("li").eq(0).find("div").eq(0).addClass("tree-node-selected")
                            buildNewUserList($("#privOrg").find("li").eq(0).find("div").eq(0).attr("node-id"),$("#privOrg").find("li").eq(0).find("div").eq(0).find("span.tree-title").html(),"#privBox","/newFileContent/getFileContentBySortId?sortId=");
                        }else{
                            $("#privOrg").find("li").find("div").removeClass("tree-node-selected")
                            $("#privOrg").find("li").find('div[node-id='+data[0].id+']').parent().parent().prev("div").addClass("tree-node-selected")
                            buildNewUserList($("#privOrg").find("li").find('div[node-id='+data[0].id+']').parent().parent().prev("div").attr("node-id"),$("#privOrg").find("li").find('div[node-id='+data[0].id+']').parent().parent().prev("div").find("span.tree-title").html(),"#privBox","/newFileContent/getFileContentBySortId?sortId=");
                        }
                    }
                },
                onBeforeExpand:function(node,param){
                    $('#privOrg').tree('options').url = '/newFilePri/getPriFileTree?sortId='+node.id;// change the url
                },
                onCheck:function (node,checked) {
                    // $('.tree-checkbox').addClass('sele')
                    // nodedept = node.id
                    // nodedeptName = node.text
                    // chexbuildNewUserList(node.id,node.text,"#privBox",function () {
                    //     if(checked){
                    //         $('#privBox').find('.block-right-item').addClass('active');
                    //         var str  = '';
                    //         $('#privBox .userItem .active').each(function (i,v) {
                    //             if($(v).attr('user_id') !='' || $(v).attr('user_id') != undefined){ //判断user_id是否为空
                    //                 if( $('#selectedDox .userItem #'+$(v).attr('user_id')).length < 1){
                    //                     str += $(this).prop("outerHTML");
                    //                 }
                    //             }
                    //         });
                    //         $('#selectedDox .userItem').append(str);
                    //     }else {
                    //         $('#privBox').find('.block-right-item').removeClass('active');
                    //         $('#selectedDox .userItem .block-right-item').each(function() {
                    //             if( $('#deptBox .userItem #'+$(this).attr('user_id')).length > 0){
                    //                 $('#deptBox .userItem #'+$(this).attr('user_id')).removeClass('active');
                    //             }
                    //         });
                    //         $('#selectedDox .userItem .block-right-item').remove();
                    //     }
                    //     var num = $('#selectedDox .userItem .block-right-item').length;
                    //     $('.chooseBox').eq(1).html(num+'个').attr('data-num',num);
                    // })
                }

            });
        }
        //公共文件柜左侧树加载方法
        initTree1 = function(){
            var url = '/newFilePub/getNewAllPrivateFileTree?sortId=0'
            $('#comOrg').tree({
                url: url,
                animate:true,
                // checkbox:true,
                cascadeCheck:true,
                loadFilter: function(node){

                    return convert(node.datas);

                },
                onClick:function(node){
                    buildNewUserList(node.id,node.text,"#comBox","/newFileContent/getContentById?useFlag=false&sortType=5&sortId=");
                    $(this).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
                    node.state = node.state === 'closed' ? 'open' : 'closed';
                },
                onDblClick:function (node) {

                },
                onLoadSuccess:function(node,data){
                    if(data.length>0){
                        if($("#comOrg").find("li").find('div[node-id='+data[0].id+']').parent().parent().prev("div").length == 0){
                            $("#comOrg").find("li").find("div").removeClass("tree-node-selected")
                            $("#comOrg").find("li").eq(0).find("div").eq(0).addClass("tree-node-selected")
                            buildNewUserList($("#comOrg").find("li").eq(0).find("div").eq(0).attr("node-id"),$("#comOrg").find("li").eq(0).find("div").eq(0).find("span.tree-title").html(),"#comBox","/newFileContent/getContentById?useFlag=false&sortType=5&sortId=");
                        } else{
                            $("#comOrg").find("li").find("div").removeClass("tree-node-selected")
                            $("#comOrg").find("li").find('div[node-id='+data[0].id+']').parent().parent().prev("div").addClass("tree-node-selected")
                            buildNewUserList($("#comOrg").find("li").find('div[node-id='+data[0].id+']').parent().parent().prev("div").attr("node-id"),$("#comOrg").find("li").find('div[node-id='+data[0].id+']').parent().parent().prev("div").find("span.tree-title").html(),"#comBox","/newFileContent/getContentById?useFlag=false&sortType=5&sortId=");
                        }
                    }
                },
                onBeforeExpand:function(node,param){
                    $('#comOrg').tree('options').url = '/newFilePub/getNewAllPrivateFileTree?sortId='+node.id;// change the url
                },
                onCheck:function (node,checked) {
                    // $('.tree-checkbox').addClass('sele')
                    // nodedept = node.id
                    // nodedeptName = node.text
                    // showUserAndDept(nodedept,nodedeptName,function () {
                    //     if(checked){
                    //         $('#comBox').find('.block-right-item').addClass('active');
                    //         var str  = '';
                    //         $('#comBox .userItem .active').each(function (i,v) {
                    //             if($(v).attr('user_id') !='' || $(v).attr('user_id') != undefined){ //判断user_id是否为空
                    //                 if( $('#selectedDox .userItem #'+$(v).attr('user_id')).length < 1){
                    //                     str += $(this).prop("outerHTML");
                    //                 }
                    //             }
                    //         });
                    //         $('#selectedDox .userItem').append(str);
                    //     }else {
                    //         $('#comBox').find('.block-right-item').removeClass('active');
                    //         $('#selectedDox .userItem .block-right-item').each(function() {
                    //             if( $('#deptBox .userItem #'+$(this).attr('user_id')).length > 0){
                    //                 $('#deptBox .userItem #'+$(this).attr('user_id')).removeClass('active');
                    //             }
                    //         });
                    //         $('#selectedDox .userItem .block-right-item').remove();
                    //     }
                    //     var num = $('#selectedDox .userItem .block-right-item').length;
                    //     $('.chooseBox').eq(1).html(num+'个').attr('data-num',num);
                    // },$('.gwpost').val(),$('.zwposition').val());
                }

            });
        }
        initTree();
        initTree1();
        //已选页签点击全部删除方法
        $('#selectedDox .block-right-remove').on('click',function () {
            $('#selectedDox .userItem .block-right-item').each(function() {
                if( $('.userItem div[attch_id="'+$(this).attr('attch_id')+'"]').length > 0){
                    $('.userItem div[attch_id="'+$(this).attr('attch_id')+'"]').removeClass('active');
                }
            });
            $('#selectedDox .userItem .block-right-item').remove();
            var num = $('#selectedDox .userItem .block-right-item').length;
            $('.chooseBox').eq(1).html(num+'个').attr('data-num',num);
        });
        //已选页签点击附件移出方法
        $('#selectedDox .userItem ').on('click','.block-right-item',function () {
            $('.userItem div[attch_id="'+$(this).attr('attch_id')+'"]').removeClass('active');
            $(this).remove();
            var num = $('#selectedDox .userItem .block-right-item').length;
            $('.chooseBox').eq(1).html(num+'个').attr('data-num',num);
        });
        //点击左侧树的节点  右侧附件渲染方法
        function buildNewUserList(id,text,ele,url) {
            var index = layer.load();
            $(ele).find('.block-right-header').text(text);
            $.ajax({
                type:'get',
                url:url+id,
                data:{
                    useFlag:false
                },
                dataType:'json',
                success: function (res) {
                    var tr = [];
                    var num=0;
                    var acarr = [];
                    var acdom = $('#selectedDox .userItem .active');
                    for(var i=0;i<acdom.length;i++){
                        acarr.push($('#selectedDox .userItem .active').eq(i).attr("attch_id"))
                    }
                    if(url == "/newFileContent/getFileContentBySortId?sortId="){
                        var data = res.datas
                    }else{
                        var data = res.object.contentList;
                    }
                    data.forEach(function (v,i) {
                        var divObj ;
                        if(v.sortId || v.sortId == 0){
                            $(ele).find('.block-right-header').show();
                            $(ele).find('.block-right-add').show();
                            $(ele).find('.block-right-remove').show();
                            num++;
                            if(Array.isArray(v.attachmentList)){
                            // if(v.attachmentList.length>0&&v.attachmentList != undefined){
                                for(var i=0;i<v.attachmentList.length;i++){
                                    if(v.attachmentList[i].id !="" || v.attachmentList[i].id !=undefined){
                                        divObj = $('<div class="block-right-item '+function () {
                                            if(acarr.length>0) {
                                                var bool = false;
                                                for (var j = 0; j < acarr.length; j++) {
                                                    if ((v.attachmentList[i].id.split(",")[0]+"") == (acarr[j]+"")) {
                                                        bool = true;
                                                        break;
                                                    }
                                                }
                                                if (bool) {
                                                    return 'active';
                                                }else {
                                                    return ''
                                                }
                                            }else {
                                                return ''
                                            }
                                        }()+'" userId="'+v.userId+'"  attch_id="'+v.attachmentList[i].id.split(",")[0]+'" attch_name="'+v.attachmentList[i].attachName+'" url="'+v.attachmentList[i].attUrl+'" sortId="'+v.sortId+'" filechName="'+function(){if(v.subject==undefined){return ''}else{return v.subject}}()+'"  fileName="'+function(){if(text==undefined){return ''}else{return text}}()+'" title="'+v.attachmentList[i].attachName+'"><span class="name">'+'['+check(text)+']&nbsp;&nbsp;'+'['+check(v.subject)+']&nbsp;&nbsp;'+check(v.attachmentList[i].attachName)+'</span></div>');
                                    }
                                    tr.push(divObj);
                                }
                            }
                        }

                    });
                    if(num==0){
                        $(ele).find('.block-right-header').hide();
                        $(ele).find('.block-right-add').hide();
                        $(ele).find('.block-right-remove').hide();
                        tr.push($('<div style="width: 230px;height: 200px;margin: 20px auto;text-align: center">' +
                            '<img src="/img/common/dianjikong.png" style="margin-top: 20px;" alt="">\
                            <span style="width: 100%;display: inline-block;margin-top: 10px;\
                        font-size: 15px;\
                        font-weight: bold;">本目录下暂无附件</span>' +
                            '</div>'))
                    }else {
                        $(ele).find('.block-right-header').show();
                        $(ele).find('.block-right-add').show();
                        $(ele).find('.block-right-remove').show();
                    }
                    $(ele).find('.userItem').html(tr);
                    layer.close(index);
                },
                error:function(XMLHttpRequest, textStatus, errorThrown){
                    // 状态码
                    console.log(XMLHttpRequest.status);
                    // 状态
                    console.log(XMLHttpRequest.readyState);
                    // 错误信息
                    console.log(textStatus);
                    layer.close(index);
                }
            })
        }

        //左侧树渲染 转数据方法
        function TreeNode(id,text,state,userId,children){
            this.id = id;
            this.text = text;
            this.state = state;
            this.userId = userId;
            this.children = children;
        }
        //左侧树渲染 转数据返回方法
        function convert(data){
            var arr = [];
            var tr = '';
            var defTr = ''
            data.forEach(function(v,i){
                if(v.sortId || v.sortId == 0){
                    var node = {};
                    if(v.state == "closed"){
                        node = new TreeNode(v.sortId,v.sortName,"closed",v.userId)
                    } else if(v.state == "open"){
                        node = new TreeNode(v.sortId,v.sortName,"open",v.userId)
                    }
                    arr.push(node);
                }else if(v.userId){
                    if(v.sex==0){
                        tr+='<div class="block-right-item '+function () {
                            if(user_id) {

                                var user_idArr;
                                if(Array.isArray(user_id)){
                                    user_idArr= user_id;
                                }else {
                                    user_idArr= user_id.split(',');
                                }
                                var bool = false;
                                for (var i = 0; i < user_idArr.length; i++) {
                                    if (v.userId == user_idArr[i]) {
                                        bool = true;
                                        break;
                                    }
                                }
                                if (bool) {
                                    return 'active';
                                }else {
                                    return ''
                                }
                            }else {
                                return ''
                            }
                        }()+'" item_id="'+v.uid+'" userPrivName="'+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'" item_name="'+v.userName+'" id="'+v.userId+'" user_id="'+v.userId+'" uid="'+v.uid+'" title="'+v.userName+'"><span class="name">'+'['+check(v.deptName)+']&nbsp;'+check(v.userName)+' '+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'<span class="status">'+function () {
                            if(onLine.toString().indexOf(v.userId) > -1){
                                return '<span style="color:#ff0000;">在线</span>';
                            }else{
                                return '';
                            }
                        }()+' </span></span></div>';
                    }else if(v.sex==1){
                        tr+='<div class="block-right-item '+function () {
                            if(user_id) {

                                var user_idArr;
                                if(Array.isArray(user_id)){
                                    user_idArr= user_id;
                                }else {
                                    user_idArr= user_id.split(',');
                                }
                                var bool = false;
                                for (var i = 0; i < user_idArr.length; i++) {
                                    if (v.userId == user_idArr[i]) {
                                        bool = true;
                                        break;
                                    }
                                }
                                if (bool) {
                                    return 'active';
                                }else {
                                    return ''
                                }
                            }else {
                                return ''
                            }
                        }()+'" item_id="'+v.uid+'" userPrivName="'+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'" item_name="'+v.userName+'"  id="'+v.uid+'"  user_id="'+v.userId+'" uid="'+v.userId+'" title="'+v.userName+'"><span class="name">'+'['+check(v.deptName)+']&nbsp;'+check(v.userName)+' '+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'<span class="status">'+function () {
                            if(onLine.toString().indexOf(v.userId) > -1){
                                return '<span style="color:#ff0000;">在线</span>';
                            }else{
                                return '';
                            }
                        }()+'</span></span></div>';
                    }
                }
            });
//				$('#deptBox .userItem').html(tr);
            return arr;
        }
        //顶部页签 切换
        $('.tab_btn').click(function(){
            var type = $(this).attr('block');
            $(this).addClass("active").siblings().removeClass('active');
            switch(type){
                case "priv":
                    $('#privBox').show().siblings().hide();
                    break;
                case "com":
                    $('#comBox').show().siblings().hide();
                    break;
                case "selected":
                    $('#selectedDox').show().siblings().hide();
                    if($('#selectedDox .userItem div').length >0){
                        $('#selectedDox .block-right-remove').show();
                    }else{
                        $('#selectedDox .block-right-remove').hide();
                    }
                    break;
                case "online":
                    break
                case "query":

                    break;
            }
        });
        //右侧附件点击方法
        $('.right').on("click",".block-right-item",function(){
            var that = $(this);
            if(that.attr('class').indexOf('active') > 0){
                that.removeClass("active");
                if( $('#selectedDox .userItem div[attch_id="'+that.attr('attch_id')+'"]').length > 0){
                    $('#selectedDox .userItem div[attch_id="'+that.attr('attch_id')+'"]').remove();
                }
            }else{
                var divObj = $(that.prop("outerHTML"));
                divObj.addClass("active");
                that.addClass("active");
                if( $('#selectedDox .userItem div[attch_id="'+that.attr('attch_id')+'"]').length < 1){
                    $('#selectedDox .userItem').append(divObj);
                }
                // if(urlType==0){
                //     that.siblings('div').removeClass('active')
                //     $('#selectedDox .userItem').empty()
                //     $('#selectedDox .userItem').append(divObj);
                // }
            }
            var num = $('#selectedDox .userItem .block-right-item').length;
            $('.chooseBox').eq(1).html(num+'个').attr('data-num',num);
        });
        //右侧附件鼠标移入
        $('.block-right').on('mouseover','div',function(){
            $(this).addClass('hover');
        });
        //右侧附件鼠标移出
        $('.block-right').on('mouseout','div',function(){
            $(this).removeClass('hover');
        });

    });
    //点击全部添加方法
    function addAllUser(element) {
        element.find('.userItem .block-right-item').addClass('active');
        var str  = '';
        element.find('.userItem .active').each(function (i,v) {
            if( $('#selectedDox .userItem div[attch_id="'+$(this).attr('attch_id')+'"]').length < 1){
                str += $(this).prop("outerHTML");
            }
        });
        $('#selectedDox .userItem').append(str);
        var num = $('#selectedDox .userItem .block-right-item').length;
        $('.chooseBox').eq(1).html(num+'个').attr('data-num',num);
    }
    //点击全部删除方法
    function deleteAllUser(element) {
        element.find('.userItem .active').each(function (i,v) {
            if( $('#selectedDox .userItem div[attch_id="'+$(this).attr('attch_id')+'"]').length > 0){
                $('#selectedDox .userItem div[attch_id="'+$(this).attr('attch_id')+'"]').remove();
            }
        });
        element.find('.userItem .block-right-item').removeClass('active');
        var num = $('#selectedDox .userItem .block-right-item').length;
        $('.chooseBox').eq(1).html(num+'个').attr('data-num',num);
    }

    function anios1(e){
        if(e.attr('url').indexOf('http:') >-1){
            var url = e.attr('url');
        }else{
            if (window["context"] == undefined) {
                if (!window.location.origin) {
                    window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port: '');
                }
                window["context"] = location.origin;
            }
            var domain = document.location.origin;
            var url = domain+e.attr('url');
        }
        if(e.hasClass('fileupload_data')){
            var url = domain+'/download?'+e.attr('url');
        }
        var name = e.attr('names');
        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
            try{
                window.webkit.messageHandlers.overLookFile.postMessage({'url':url,'name':name});
            }catch(error){
                overLookFile(url,name);
            }
        } else if (/(Android)/i.test(navigator.userAgent)) {
            Android.overLookFile(url,name);
        }
    }
    function editAttachment(_this,print) { //编辑附件
        var name=_this.parents('.dech').attr('name1')
        var name1 = name.split('.')[1];
        if(name1 == 'jsp'||name1 == 'css'||name1 == 'js'||name1 == 'html'||name1 == 'java'||name1 == 'php'||name1 == 'pdf'||name1 == 'png'|| name1 == 'oxps'||name1 == 'jpg'||name1 == 'bmp' || name1 == 'emf' || name1 == 'gif'|| name1 == 'pcx'|| name1 == 'pcd'|| name1 == 'ai'|| name1 == 'webp'|| name1 == 'WMF'|| name1 == 'dxf' ||name1 == 'PNG'||name1 == 'JPG'||name1 == 'BMP' || name1 == 'EMF' || name1 == 'GIF'|| name1 == 'PCX'|| name1 == 'PCD'|| name1 == 'AI'|| name1 == 'WEBP'|| name1 == 'wmf'|| name1 == 'DXF' ||name1 == 'ofd'||name1 == 'OFD'||name1 == 'oFd'||name1 == 'oFD' ){ //后缀为这些的禁止上传
            layer.msg(name1+'文件不能编辑!',{},function(){

            });
            return false;
        }
        var atturl=_this.attr('attrurl');
        var gs = UrlGetRequest('?'+atturl)||'';

        if(atturl != undefined&&atturl.indexOf('&ATTACHMENT_NAME=') > -1&&atturl.indexOf('isOld=1') == -1){
            var atturl1 = atturl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
            var atturl2 = '';
            if(atturl.split('&ATTACHMENT_NAME=')[1] != undefined&&atturl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1){
                for(var i=1;i<atturl.split('&ATTACHMENT_NAME=')[1].split('&').length;i++){
                    atturl2 += '&' + atturl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
                }
                atturl = atturl1 + atturl2;
            }else{
                atturl = atturl1;
            }
        }
        var url = "/common/webOffice?documentEditPriv=1&fomat="+name1+"&ntType=1&officeType=1&print="+print+"&"+atturl;
        $.ajax({
            url:'/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
            type:'post',
            datatype:'json',
            async:false,
            success: function (res) {
                if(res.flag){
                    if(res.object[0].paraValue == 0){
                        //默认加载NTKO插件 进行跳转
                        url = "/common/ntko?documentEditPriv=1&fomat="+name1+"&ntType=1&officeType=1&print="+print+"&"+atturl;
                    }else if(res.object[0].paraValue == 2){
                        //默认加载NTKO插件 进行跳转
                        url = "/wps/info?"+ atturl +"&permission=write";
                    }else if(res.object[0].paraValue == 3){

                        //默认加载NTKO插件 进行跳转
                        url = "/common/onlyoffice?"+ atturl +"&edit=true";
                    }
                }

            }
        })
        $.popWindow(url,'<fmt:message code="main.th.PreviewPage" />','0','0','1200px','600px');
    }
</script>
</html>
