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
    <title><fmt:message code="event.th.NewAssets" /></title>
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <link rel="stylesheet" href="../lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="../lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <script type="text/javascript" src="../../lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="../../lib/layui/layui/layui.all.js"></script>
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../../lib/layui/layui/global.js"></script>

    <script type="text/javascript" src="/lib/qrcode.js"></script>
    <script src="../js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/jquery/jquery.form.min.js"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script src="../lib/laydate/laydate.js"></script>
    <script type="text/javascript">
        //附件上传 方法
        var timer=null;
        function fileuploadFn(formId,element,num) {
            // $('#uploadinputimg').fileupload({
            $(formId).fileupload({
                dataType:'json',
                progressall: function (e, data) {
                    var progress = parseInt(data.loaded / data.total * 100, 10);
                    $('#progress .bar').css(
                        'width',
                        progress + '%'
                    );
                    $('.barText').html(progress + '%');
                    if(progress >= 100){  //判断滚动条到100%清除定时器
                        timer=setTimeout(function () {
                            $('#progress .bar').css(
                                'width',
                                0 + '%'
                            );
                            $('.barText').html('');
                        },2000);

                    }
                },
                done: function (e, data) {
                    if(data.result.obj != ''){
                        var data = data.result.obj;
                        var str = '';
                        var str1 = '';
                        for (var i = 0; i < data.length; i++) {
                            var gs = data[i].attachName.split('.')[1];
                            if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){ //后缀为这些的禁止上传
                                str += '';
                                layer.alert('jsp、css、js、html、java文件禁止上传!',{},function(){
                                    layer.closeAll();
                                });
                            }else{
                                if(num == 0){
                                    str += '<div style="float:left;position:relative;margin-right:10px;" class="dech" deUrl="' + encodeURI(data[i].attUrl)+ '"><image class="smallImg" style="max-width:100px;max_height:100px;" src="/download?'+encodeURI(data[i].attUrl)+'" imgName="' + data[i].attachName + '"><img class="deImgs" style="margin-left:5px;cursor: pointer;position:absolute;top:0;right:0;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                                }else{
                                    str += '<div style="margin-right: 30px;float:left;position:relative;" class="dech" deUrl="' + encodeURI(data[i].attUrl)+ '"><a class="smallImg" style="max-width:100px;max_height:100px;" href="/download?'+encodeURI(data[i].attUrl)+'" imgName="' + data[i].attachName + '">'+ data[i].attachName +'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;position:absolute;top:5px;right:-15px;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                                }
                            }
                        }
                        // $('.Attachment td').eq(1).append(str);
                        element.append(str);
                    }else{
                        layer.alert('添加附件大小不能为空!',{},function(){
                            layer.closeAll();
                        });
                    }
                }
            });
        }
    </script>
</head>
<style>
    body{
        margin:0px;
    }
    .headImg {
        display: inline-block;
        float: left;
        margin-top:22px;
    }
    .divTitle{
        font-size: 22px;
        color: rgb(73, 77, 89);
        margin-left: 10px;
        margin-right: 20px;
        height:70px;
        line-height:70px;
        width:80%;
    }
    td{
        color: rgb(64, 64, 96);
        padding: 10px;
        font: 14px 微软雅黑;
    }
    .editInfo tr td {/*表格的边框样式*/
        border-width: 1px;
        border-style: solid;
        border-color: rgb(192, 192, 192);
        border-image: initial;
    }
    .editInfo tr td b{
        font-size: 20px;
        font-weight: bold;
    }
    table{
        border-collapse: collapse;/*表格边框合并*/
        width: 100%;
    }
    /*.editInfo tr td:first-child{*/
    /*width: 30%;*/
    /*}*/
    /*.main{*/
    /*margin-top: 20px;*/
    /*}*/
    .save_btn{/*保存按钮*/
        background: url(../../img/save.png) no-repeat;
        margin-top: 20px;
        margin-left: 45%;

    }
    .btn_ {
        height: 43px;
        margin-top: 10px;
        margin-bottom: 20px;
        padding-left: 41px;
        padding-top: 7px;
        font-size: 14px;
    }
    #saveBtn{
        cursor: pointer;
    }
    .editInfo input[type="text"]{
        height: 32px;
    }
    .blue{
        font-weight:bold;
        color:#2a588c;
    }
    .headTop{
        position: relative;
    }
    .newClass{
        position:absolute;
        top:0;
        right:0;
        width: 90px;
        height: 28px;
        background: url(../../img/file/cabinet01.png) no-repeat;
        color: #fff;
        font-size: 14px;
        line-height: 28px;
        margin: 2% 3% 0 0;
        cursor: pointer;
    }
    .bar {
        height: 18px;
        background: green;
    }
    .TableHeader{
        height: 30px;
        background: #e8f4fc;
    }
</style>
<body style="font-family: 微软雅黑;">
<div class="headTop" style="margin-left: 30px">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/fixAssetsNew.png">&nbsp;&nbsp;
    </div>
    <div class="divTitle ">
        <%--<fmt:message code="event.th.NewAssets" />--%>
        新建资产
    </div>
    <div class="newClass" id="turn">
        <span style="margin-left: 30px;">返回</span>
    </div>
</div>
<div class="main" style="margin-left: 30px">
    <div class="mainBody">
        <table class="editInfo">
            <tr>
                <td nowrap="" class="TableHeader" colspan="6"><b>&nbsp;基本信息</b></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>是否是固定资产：</td>
                <td>
                    <select name="isAssets" id="isAssets" style="height: 30px;width: 85px">
                        <option value="1">是</option>
                        <option value="0">否</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";><fmt:message code="event.th.FixedAssetNumber" />：</td>
                <td>
                    <input name="id" id="id" type="text" class="test_null"  placeholder="请输入..." disabled>
                    <span style="font-size: 14px;color: red">&nbsp;&nbsp;*</span>
                    <button type="button" title="获取固定资产编号" id="gdNum">生成</button>
                </td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";><fmt:message code="event.th.AssetName" />：</td>
                <td><input name="assetsName" id="assetsName"  type="text"  class="test_null"><span style="font-size: 14px;color: red">&nbsp;&nbsp;*</span></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>出厂编号：</td>
                <td><input name="factoryNo" id="factoryNo"  type="text"></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>类别：</td>
                <td>
                    <select name="typeId" id="typeId" style="height: 30px;width: 85px" class="test_null" value="0"></select><span style="font-size: 14px;color: red">&nbsp;&nbsp;*</span>
                </td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>所在部门：</td>
                <td>
                    <textarea name="localAddress1" id="localAddress" class="localAddress" deptid="" cols="22" disabled readonly></textarea>
                    <a href="javascript:;" class="addAddress" style="color:#207bd6;text-decoration:none"><fmt:message code="global.lang.add" /></a>
                    <a href="javascript:;" class="clearAddress" style="color:#f00;text-decoration:none" onclick="emptyDept('localAddress')"><fmt:message code="global.lang.empty" /></a>
                </td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>所在项目：</td>
                <td>
                    <%-- <select name="otherDept" id="otherDept" style="height: 30px;width: 160px">

                     </select>
                     <select name="otherDept1" id="otherDept1" style="height: 30px;width: 160px">

                     </select>--%>

                    <div class="layui-input-inline" id="tre" style="width: 200px;">
                        <input type="text" id="tree" lay-filter="tree"  name="" class="layui-input">
                        <input name="client" type="hidden" class="client" id="client"></div>
                </td>

            </tr>
            <tr>
                <td class="blue" style="width:15%";>所在位置：</td>
                <td>
                    <select name="currutLocation" id="currutLocation" style="height: 30px;width: 160px">

                    </select>
                </td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>资产性质：</td>
                <td>
                    <select name="cptlKind" id="cptlKind" style="height: 30px;width: 85px">
                        <option value="01">资产</option>
                        <option value="02">费用</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>是否是应急救援设备：</td>
                <td>
                    <select name="emergencyEquipment" id="emergencyEquipment" style="height: 30px;width: 85px">
                        <option value="1">是</option>
                        <option value="0">否</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td nowrap="" class="TableHeader" colspan="6"><b>&nbsp;库存信息</b></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>是否有证书：</td>
                <td>
                    <select name="isCertificate" id="isCertificate" style="height: 30px;width: 85px">
                        <option value="0" >没有</option>
                        <option value="1">有</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>证书编号：</td>
                <td><input name="certificateNo" id="certificateNo"  type="text" disabled="disabled"></td>
            </tr>
            <tr>
                <td width="15%" style="padding-left: 10px;" class="blue">固定资产证书附件上传：</td>
                <td width="85%" class="files" style="position: relative">
                    <form id="uploadimgform1" style="float: left;" target="uploadiframe"  action="/upload?module=fixAssets"  method="post" >
                        <input type="file" multiple="multiple" name="file"  id="uploadinputimg1"  class="w-icon5" style="position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                        <a href="#" id="uploadimg1"><img style="margin-right:5px;" src="../img/icon_uplod.png"/>附件上传</a>
                    </form>
                    <div id="progress" style="width: 200px;float: left;margin-left: 10px;margin-top: 2px;">
                        <div class="bar" style="width: 0%;"></div>
                    </div>
                    <div class="barText" style="float: left;margin-left: 10px;"></div>
                </td>
            </tr>
            <tr>
                <td width="15%" style="padding-left: 10px;" class="blue">固定资产证书附件选择：</td>
                <td width="85%" class="files" id="eduFixAsstesFile" style="position: relative">

                </td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>增加类型：</td>
                <td>
                    <select name="prcsId" id="prcsId" style="height: 30px;width: 218px">
                        <option value="1">购入不需安装的固定资产</option>
                        <option value="2">购入需安装已完工的固定资产</option>
                        <option value="3">其他单位转入的固定资产(新设备)</option>
                        <option value="4">其他单位转入的固定资产(旧设备)</option>
                        <option value="5">捐赠的固定资产</option>
                        <option value="6">融资租赁的固定资产</option>
                        <option value="7">固定资产盘盈</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>资产原值：</td>
                <td><input name="cptlVal" id="cptlVal" type="number" min="0"><span style="font-size: 14px;color: #000000">&nbsp;&nbsp;数字</span></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>残值率：</td>
                <td><input name="cptlBal" id="cptlBal" type="number" min="0"><span style="font-size: 14px;color: #000000">&nbsp;&nbsp;数字</span></td>
            </tr>

            <tr>
                <td class="blue" style="width:15%";>折旧年限：</td>
                <td><input name="dpctYy" id="dpctYy" type="number" min="0"><span style="font-size: 14px;color: #000000">&nbsp;&nbsp;数字</span></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>累计折旧：</td>
                <td><input name="sumDpct" id="sumDpct" type="number" min="0"><span style="font-size: 14px;color:#000">&nbsp;&nbsp;数字 为空表示新资产</span></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>月折旧额：</td>
                <td><input name="monDpct" id="monDpct" type="number" min="0"><input id="zjBut" type="button"  onclick="jsFunction()" value="计算"></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>折旧率：</td>
                <td><input name="monDepr" id="monDepr" type="number" min="0"><span style="font-size: 14px;color: #000000">&nbsp;&nbsp;数字</span></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>资产净值：</td>
                <td><input name="worth" id="worth" type="text"></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>本年计提折旧：</td>
                <td><input name="yyDpct" id="yyDpct" type="text"></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>已计提月份：</td>
                <td><input name="monAccrual" id="monAccrual" type="text"></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>使用年限：</td>
                <td><input name="useYy" id="useYy" type="text"></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";><fmt:message code="event.th.BuyTime" />：</td>
                <td><input name="buyTime" id="buyTime" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})"  type="text" readonly></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>品牌型号：</td>
                <td><input name="info" id="info"  type="text"></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";><fmt:message code="event.th.Number" />：</td>
                <td><input name="number" id="number"  type="number" min="0"></td>
            </tr>

            <tr>
                <td class="blue" style="width:15%";>保管人：</td>
                <td>
                    <textarea name="keeper" id="keeper" class="keeper test_null" user_id=""  style="vertical-align: middle;" disabled readonly cols="22"></textarea>
                    <span style="font-size: 14px;color: red">&nbsp;&nbsp;*</span>
                    <a href="javascript:;" class="addKeeper" style="color:#207bd6;text-decoration:none"><fmt:message code="global.lang.add" /></a>
                    <a href="javascript:;" class="clearKeeper" style="color:#f00;text-decoration:none" onclick="emptyUser('keeper')"><fmt:message code="global.lang.empty" /></a>
                </td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>调度人：</td>
                <td>
                    <textarea name="keepers" id="keepers" class="keeper test_null" user_id=""  style="vertical-align: middle;" disabled readonly cols="22"></textarea>
                    <span style="font-size: 14px;color: red">&nbsp;&nbsp;*</span>
                    <a href="javascript:;" class="addKeepers" style="color:#207bd6;text-decoration:none"><fmt:message code="global.lang.add" /></a>
                    <a href="javascript:;" class="clearKeepers" style="color:#f00;text-decoration:none" onclick="emptyUser('keepers')"><fmt:message code="global.lang.empty" /></a>
                </td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";><fmt:message code="event.th.ArticleStatus" />：</td>
                <td>
                    <select name="status" id="status" style="height: 30px;width: 85px">
                        <option value="1"><fmt:message code="event.th.notUsed" /></option>
                        <option value="2"><fmt:message code="evvent.th.Use" /></option>
                        <option value="3"><fmt:message code="event.th.damage" /></option>
                        <option value="4"><fmt:message code="event.th.Lose" /></option>
                        <option value="5"><fmt:message code="event.th.Scrap" /></option>
                    </select>
                </td>
            </tr>
            <%--<tr class="setImg">--%>
            <%--<td nowrap="" class="TableData blue" class="blue" style="width:15%";><fmt:message code="event.th.FixedAssetsPicture" />：</td>--%>
            <%--<td nowrap="" class="TableData">--%>
            <%--&lt;%&ndash;<span id="showImage"></span>&ndash;%&gt;--%>
            <%--&lt;%&ndash;<input type="file" name="imageFile" id="imageFile" size="40" class="BigInput" title="<fmt:message code="url.th.SelectPicture" />" style="height: 27px;">&nbsp;&ndash;%&gt;--%>
            <%--</td>--%>
            <%--</tr>--%>
            <%--<tr class="showImg" style="display: none">--%>
            <%--<td nowrap="" class="TableData blue" class="blue" style="width:15%";><fmt:message code="event.th.FixedAssetsPicture" />：</td>--%>
            <%--<td>--%>
            <%--<image  style="max-width:100px;max-height:100px;" id="image" > &nbsp;&nbsp;<input type="button" id="delImg" value="<fmt:message code="global.lang.delete" />"></image>--%>
            <%--<input type="text" name="image" style="display: none">--%>
            <%--</td>--%>
            <%--</tr>--%>
            <%--<tr class="Attachment" style="width:100%; padding-left: 10px;">--%>
            <%--<td width="15%" class="blue">固定资产图片选择：</td>--%>
            <%--<td width="85%"   class="files" id="files_txt" style="color:#fff;">--%>
            <%--<div id="fileContent"></div>--%>
            <%--</td>--%>
            <%--</tr>--%>
            <%--<tr class="">--%>
            <%--<td width="15%" style="padding-left: 10px;" class="blue">固定资产图片上传：</td>--%>
            <%--<td width="85%" class="files" style="position: relative">--%>
            <%--<!-- <fmt:message code="email.th.addfile" /> -->--%>
            <%--<form id="uploadimgform" style="float: left;" target="uploadiframe"  action="/upload?module=fixAssets"  method="post" >--%>
            <%--<input type="file" multiple="multiple" name="file" accept="image/gif,image/jpeg,image/jpg,image/png,image/svg" id="uploadinputimg"  class="w-icon5" style="position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">--%>
            <%--<a href="#" id="uploadimg"><img style="margin-right:5px;" src="../img/icon_uplod.png"/>图片上传</a>--%>
            <%--</form>--%>
            <%--&lt;%&ndash;<a href="javascript:;" onclick="formFile()" style="float: left;margin: 0 15px;"><img style="margin-right:5px;" src="../img/icon_uplod.png"/>从文件柜选择附件</a>&ndash;%&gt;--%>
            <%--<div id="progress" style="width: 200px;float: left;margin-left: 10px;margin-top: 2px;">--%>
            <%--<div class="bar" style="width: 0%;"></div>--%>
            <%--</div>--%>
            <%--<div class="barText" style="float: left;margin-left: 10px;"></div>--%>
            <%--</td>--%>
            <%--</tr>--%>

            <tr>
                <td class="blue" width="15%";><fmt:message code="journal.th.Remarks" />：</td>
                <td><input name="remake" id="remake"  type="text"></td>
            </tr>
            <tr style="display: none" class="qrTd">
                <td class="blue" width="15%";><fmt:message code="doc.th.QRCode" />：</td>
                <td><span id="showQRCode"  style="display: inline-block;"></span></td>
            </tr>
            <tr>
                <td class="blue" width="15%";><fmt:message code="file.th.builder" />：</td>
                <td><input name="creater" id="creater" user_id="" readonly disabled  type="text" class="test_null"><span style="font-size: 14px;color: red">&nbsp;&nbsp;*</span></td>
            </tr>
            <tr>
                <td class="blue" width="15%";><fmt:message code="notice.th.createTime" />：</td>
                <td><input name="createTime" id="createTime" readonly disabled type="text" class="test_null"><span style="font-size: 14px;color: red">&nbsp;&nbsp;*</span></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>有效时间：</td>
                <td><input name="validityTime" id="validityTime" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})"  type="text" readonly></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>减少日期：</td>
                <td><input name="dcrDate" id="dcrDate" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})"  type="text" readonly></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>启用日期：</td>
                <td><input name="fromYy" id="fromYy" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})"  type="text" readonly class="test_null"><span style="font-size: 14px;color: red">&nbsp;&nbsp;*</span></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>报废日期：</td>
                <td><input name="logoutTime" id="logoutTime" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})"  type="text" readonly></td>
            </tr>
            <tr>
                <td nowrap="" class="TableHeader" colspan="6"><b>&nbsp;资产信息</b></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>条形码：</td>
                <td><input type="text" id="barCode"/></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>资产等级：</td>
                <td><input type="text" id="capitalLevel"/></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>制造厂商：</td>
                <td><input type="text" id="manuFacturer"/></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>出厂日期：</td>
                <td><input type="text" id="manuDate" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})"/></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>计量单位：</td>
                <td><input type="text" id="unitId"/></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>财务编号：</td>
                <td><input type="text" id="fnamark"/></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>预警数量：</td>
                <td><input type="text" id="alertNum"/></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>发票号码：</td>
                <td><input type="text" id="invoice"/></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>合同号：</td>
                <td><input type="text" id="contractNo"/></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>设备名称(英文)：</td>
                <td><input type="text" id="assetsNameEnglish"/></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>设备代码：</td>
                <td><input type="text" id="deviceCode"/></td>
            </tr>
            <tr>
                <td class="blue" style="width:15%";>折旧方法：</td>
                <td><input type="text" id="depreciationMethod"/></td>
            </tr>
            <tr>
                <td class="blue_text" width="20%">
                    <fmt:message code="notice.th.reminder"/>：
                </td>
                <td width="80%" style="text-align: left" id="thing">
                    <input type="checkbox" class="remind" checked value="0" style="vertical-align: middle;">
                    <span><fmt:message code="notice.th.remindermessage"/></span>
                    <%--<input type="hidden" name="howRenind" >&nbsp;--%>
                    <input type="checkbox" class="smsRemind" value="1" style="vertical-align: middle;">
                    <span><fmt:message code="vote.th.UseRemind"/></span>
                    <%--<input type="hidden" name="smsDefault" value="1">--%>
                </td>
            </tr>
            <tr>
        </table>
        <%--</form>--%>
        <div>
            <div id="saveBtn" value="0" type="save" class="btn_ save_btn"><fmt:message code="global.lang.save" /></div>
        </div>
    </div>
</div>
<script>
    var form
    var treeSelect

    var timer=null;
    //是否需要生成固定资产编号
    $.ajax({
        url:"/syspara/selectTheSysPara?paraName=MYPROJECT",
        success:function(res) {
            console.log(res)
            if(res.flag && res.object.length > 0 && res.object[0].paraValue == 'hangtiankaiyuan') {
                $('#gdNum').css('display','none');
                $('#id').attr('disabled',false);
            }
        }
    })
    // 查询提醒权限
    $.ajax({
        type:'get',
        url:'/smsRemind/getRemindFlag',
        dataType:'json',
        data:{
            type:74
        },
        success:function (res) {
            if(res.flag){
                if(res.obj.length>0){
                    var data = res.obj[0];
                    // 是否默认发送
                    if(data.isRemind=='0'){
                        $('.remind').prop("checked", false);
                    }else if(data.isRemind=='1'){
                        $('.remind').prop("checked", true);
                    }
                    // 是否手机短信默认提醒
                    if(data.isIphone=='0'){
                        $('.smsRemind').prop("checked", false);
                    } else if (data.isIphone=='1'){
                        $('.smsRemind').prop("checked", true);
                    }
                    // 是否允许发送事务提醒
                    if(data.isCan=='0'){
                        $('.remind').prop("checked", false);
                        $('.smsRemind').prop("checked", false);
                        $('.items').hide();
                    }

                }
            }
        }
    })
    function fileuploadFn(formId,element) {
        $('#form1').attr('action','../upload?module=hr');

        // $('#uploadinputimg').fileupload({
        $(formId).fileupload({
            dataType:'json',
            progressall: function (e, data) {
                var progress = parseInt(data.loaded / data.total * 100, 10);
                $('#progress .bar').css(
                    'width',
                    progress + '%'
                );
                $('.barText').html(progress + '%');
                if(progress >= 100){  //判断滚动条到100%清除定时器
                    timer=setTimeout(function () {
                        $('#progress .bar').css(
                            'width',
                            0 + '%'
                        );
                        $('.barText').html('');
                    },2000);

                }
            },
            done: function (e, data) {
                if(data.result.obj != ''){
                    var data = data.result.obj;
                    var str = '';
                    var str1 = '';
                    for (var i = 0; i < data.length; i++) {
                        var gs = data[i].attachName.split('.')[1];
                        if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){ //后缀为这些的禁止上传
                            str += '';
                            layer.alert('jsp、css、js、html、java文件禁止上传!',{},function(){
                                layer.closeAll();
                            });
                        }else{
                            str += '<div class="dech" deUrl="' + encodeURI(data[i].attUrl)+ '"><a href="/download?'+encodeURI(data[i].attUrl)+'" NAME="' + data[i].attachName + '*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                        }
                    }
                    // $('.Attachment td').eq(1).append(str);
                    element.append(str);
                }else{
                    layer.alert('添加附件大小不能为空!',{},function(){
                        layer.closeAll();
                    });
                }
            }
        });
    }
    //附件删除
    function getTypeInner(){
        $.ajax({
            //查出类型对应数据
            url: '/eduFixAssets/getFixAssetstypeName',
            type: 'get',
            dataType: 'json',
            async:false,
            success: function (obj) {
                if(obj.flag){
                    var optionstring="";
                    $.each(obj.object,function(key,value){  //循环遍历后台传过来的json数据
                        optionstring += "<option value=\"" + value.typeId + "\" >" + value.typeName + "</option>";
                    });
                    $("#typeId").html("<option value='0'>请选择</option> "+optionstring);//这里是和后台连接获得下拉标签里的值
                }
            }
        });
    }


    function direction(){
        //所在位置
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
    }
    //    function panduan() {
    //        console.log($('#isCertificate').val());
    //    }
    //    panduan();
    function jsFunction() {
        //（资产原值-残值-累计折旧）/（折旧年限*12）---残值
        //（资产原值-累计折旧）*（1-残值率/100）/（折旧年限*12）---残值率
        var yz = $("#cptlVal").val();
        var czl = $("#cptlBal").val();
        var zjnx = $("#dpctYy").val();
        var ljzj = $("#sumDpct").val();
        var mon_dpct=(yz - ljzj)*(1-czl/100)/(zjnx*12);
        $("#monDpct").val(mon_dpct.toFixed(2));
    };

    <!--王禹萌----------------------------------------------->
    //		图片上传
    fileuploadFn('#uploadinputimg',$('.Attachment td').eq(1),'0');
    //	附件上传方法
    fileuploadFn('#uploadinputimg1',$('#eduFixAsstesFile'),'1');

    //附件删除
    $('#eduFixAsstesFile').on('click','.deImgs',function(){
        var data=$(this).parents('.dech').attr('deUrl');
        var dome=$(this).parents('.dech');
        deleteChatment(data,dome);

    })
    //删除附件
    function deleteChatment(data,element){

        layer.confirm('<fmt:message code="workflow.th.que" />？', {
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
            title:"<fmt:message code="notice.th.DeleteAttachment" />",
            offset: '[center.center]'

        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'get',
                url:'../delete',
                dataType:'json',
                data:data,
                success:function(res){

                    if(res.flag == true){
                        layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});
                        //                                     var file = $('[name="file"]')
                        //                                     file.after(file.clone().val(""));
                        //                                     file.remove();
                        element.remove();
                    }else{
                        <%--layer.msg('<fmt:message code="lang.th.deleSucess" />', { icon:6});--%>
                        alert('有错')
                    }
                }
            });

        }, function(){
            layer.closeAll();
        });
    }
    //时间控件
    /* var start = {
     format: 'YYYY-MM-DD',
     istime: true
     };*/
    //返回上级页面
    $("#turn").on("click",function () {
        if (apex==1){
            window.location.href = "/eduFixAssets/fixAssetsManager";
        }else if (apex==2){
            window.location.href = "/eduFixAssets/fixAssetsQuery";
        }else {
            window.location.href = "/eduFixAssets/fixAssetsManager";
        }


    })
    var editFlag=${editFlag};
    var apex = ${apex};
    $("#gdNum").on("click",function(){
        //初始化固定资产编号
        $.ajax({
            url: '/eduFixAssets/getFixAssetsId',
            type: 'get',
            dataType: 'json',
            success: function (obj) {
                if(obj.flag){
                    $("#id").val(obj.object.id);//初始化固定资产编号
                }
            }
        })

    })
    layui.use([ 'layer', 'form', 'treeSelect'], function () {
        var layer = layui.layer;
        form = layui.form;
        treeSelect = layui.treeSelect;

        //下拉樹獲取
        function treeSelects(treeId,id){
            treeSelect.render({
                elem: treeId,     // 选择器
                data: '/crashParent/showAllTree',  // 数据
                type: 'get',      // 异步加载方式：get/post，默认get
                placeholder: '请选择',   // 占位符
                search: true,  // 是否开启搜索功能：true/false，默认false
                style: {   // 一些可定制的样式
                    folder: {enable: true},
                    line: {enable: true}
                },
                click: function(d){     // 点击回调
                    $('input[name="client"]').val(d.current.id);
                    form.render()
                },
                // 加载完成后的回调函数
                success: function (d) {
                    if(id!=''&&id!=undefined){
                        var treeId = $('.layui-treeSelect-body').attr('id')
                        treeSelect.checkNode('#tree',treeId,id);
                    }
                    form.render();
                }
            });
        }

        // treeSelectqq()
        // function treeSelectqq(id){
        //     treeSelect.render({
        //         // 选择器
        //         elem: '#tree',
        //         // 数据
        //         data:'/crashParent/showAllTree',
        //         // 异步加载方式：get/post，默认get
        //         type: 'get',
        //         // 占位符
        //         placeholder: '请选择',
        //         // 是否开启搜索功能：true/false，默认false
        //         search: true,
        //         // 一些可定制的样式
        //         style: {
        //             folder: {
        //                 enable: true
        //             },
        //             line: {
        //                 enable: true
        //             }
        //         },
        //         // 点击回调
        //         click: function(d){
        //             console.log(treeSelectqq)
        //             $('#client').val(d.current.id);
        //         },
        //         // 加载完成后的回调函数
        //         success: function (d) {
        //             console.log(id)
        //             var treeId = $('.layui-treeSelect-body').attr('id')
        //             var treeObj = $.fn.zTree.getZTreeObj(treeId)
        //             console.log(treeId)
        //             var nodes = treeObj.transformToArray(treeObj.getNodes());
        //             for (var i=0, l=nodes.length; i < l; i++) {
        //                 if (nodes[i].isParent){
        //                     treeObj.setChkDisabled(nodes[i], true);
        //                 }
        //             }
        //         }
        //     });
        // }

        $(function(){
            //这里需要修改
            getTypeInner();
            direction();
            if(editFlag==0){//为添加页面，对添加页面进行初始化
                treeSelects('#tree','')
                $.ajax({
                    url: '/eduFixAssets/getFixAssetsId',
                    type: 'get',
                    dataType: 'json',
                    success: function (obj) {
                        if(obj.flag){
                            $("#createTime").val(obj.object.createrTime);//创建时间
                        }
                    }
                });

                //初始化创建人和创建时间
                $("#creater").val($.cookie("userName"));//创建人姓名
                $("#creater").attr("user_id",$.cookie("uid"));//创建人userId
                $('.setImg').show();
                $('.showImg').hide();
                $(".qrTd").hide();
            }else{//为编辑页面，对编辑页面进行初始化
                $(".divTitle").html("<fmt:message code="event.th.ModifyAssets" />");
                $.ajax({
                    url: '/eduFixAssets/selFixAssetsById',
                    type: 'get',
                    data:{
                        id:'${id}',

                    },
                    dataType: 'json',
                    success: function (obj) {
                        $("#id").attr("disabled",true);
                        $("#gdNum").attr("disabled",true);
                        var data=obj.object;
                        // console.log(data)
                        if(obj.flag){
                            treeSelects('#tree',data.otherDept)
                            $("#id").val(data.id);
                            $("#factoryNo").val(data.factoryNo);
                            $("#currutLocation").val(data.currutLocation);
                            $("#typeId").val(data.typeId);
                            //                        $("#typeId").val("3");
                            $("#assetsName").val(data.assetsName);
                            $("#buyTime").val(data.buyTime);
                            $("#info").val(data.info);
                            $("#number").val(data.number);
                            $("#localAddress").val(data.deptName);
                            $("#localAddress").attr("deptid",data.deptId);
                            $("#cptlKind").val(data.cptlKind);
                            $('#emergencyEquipment').val(data.rescueType)
                            $("#isCertificate").val(data.isCertificate);
                            $("#prcsId").val(data.prcsId);
                            $("#cptlVal").val(data.cptlVal);
                            $("#cptlBal").val(data.cptlBal);
                            $("#dpctYy").val(data.dpctYy);
                            $("#sumDpct").val(data.sumDpct);
                            $("#monDpct").val(data.monDpct);
                            $("#monDepr").val(data.monDepr);
                            $("#worth").val(data.worth);
                            $("#yyDpct").val(data.yyDpct);
                            $("#monAccrual").val(data.monAccrual);
                            $("#useYy").val(data.useYy);
                            $("#certificateNo").val(data.certificateNo);
                            $("#keeper").val(data.keeperName);
                            $("#keeper").attr("dataid",data.keeper);
                            $("#keepers").val(data.schedulerName);
                            $("#keepers").attr("user_id",data.scheduler);
                            $("#status").val(data.status);
                            /*$("#imageFile").val(data.imageFile);*/
                            $("#remake").val(data.remark);
                            /*   $("#QRcodeFile").val(data.QRcodeFile);*/
                            $("#creater").val(data.createrName);
                            $("#validityTime").val(data.validityTime);
                            $("#dcrDate").val(data.dcrDate);
                            $("#fromYy").val(data.fromYymm);
                            $("#logoutTime").val(data.logoutTime);
                            $("#creater").attr("user_id",data.creater);
                            $("#createTime").val(data.createrTime);
                            $("#assetsNameEnglish").val(data.assetsNameEnglish);
                            $("#deviceCode").val(data.deviceCode);
                            $("#depreciationMethod").val(data.depreciationMethod);
                            if(data.remind=='0'){
                                $('.remind').prop("checked", false);
                            }else if(data.remind=='1'){
                                $('.remind').prop("checked", true);
                            }
                            if(data.smsRemind=='0'){
                                $('.smsRemind').prop("checked", false);
                            } else if (data.smsRemind=='1'){
                                $('.smsRemind').prop("checked", true);
                            }
                            if (data.isAssets=='0'){
                                $("#isAssets").get(0).selectedIndex = 1;
                            }else {
                                $("#isAssets").get(0).selectedIndex = 0;
                            }
                            $("#barCode").val(data.barCode);
                            $("#capitalLevel").val(data.capitalLevel);
                            $("#manuFacturer").val(data.manuFacturer);
                            $("#manuDate").val(data.manuDate);
                            $("#unitId").val(data.unitId);
                            $("#fnamark").val(data.fnamark);
                            $("#alertNum").val(data.alertNum);
                            $("#invoice").val(data.invoice);
                            $("#contractNo").val(data.contractNo);;
                            function strsplice(a){

                                var index = a.indexOf("?");

                                return a.substring(index+1);
                            }
                            if(data.image!=''){
                                var data = data.image.split(",");
                                var str;
                                for(i=0;i<data.length;i++){
                                    str += '<div style="float:left;position:relative;margin-right:10px;" class="dech" deUrl="' + strsplice(data[i])+ '"><image class="smallImg" style="max-width:100px;max_height:100px;" src="' + data[i]+ '"><img class="deImgs" style="margin-left:5px;cursor: pointer;position:absolute;top:0;right:0;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden"></div>';
                                }
                                $('.Attachment td').eq(1).append(str);
                            }
                            //文件回显开始
                            var arr = data.attachmentList;
                            var str1="";
                            if (arr != ''&&arr!=undefined) {
                                for (var i = 0; i < (arr.length); i++) {
                                    str1+='<div class="dech" deUrl="'+encodeURI(arr[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" NAME="'+arr[i].attachName+'*" href="/download?'+encodeURI(arr[i].attUrl)+'">'+arr[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+arr[i].attachName+'*"  class="inHidden" value="'+arr[i].aid+'@'+arr[i].ym+'_'+arr[i].attachId+',"></div>';
                                }
                                $('#eduFixAsstesFile').append(str1);
                            };
                            //文件回显结束
                            var createTime = data.createrTime;
                            var id = data.id;
                            var companyId = data.companyId;
                            var obj ={"mark":"fixAssets","id":id,"createTime":createTime,"companyId":companyId};
                            var text = JSON.stringify(obj);
                            var qrcode = new QRCode(document.getElementById("showQRCode"), {
                                width : 100,//设置宽高
                                height : 100,
                                text:text
                            });
                        }
                    }
                })
            }
        });
    })

    //清空人员控件
    function emptyUser(id){
        $("#"+id).val("");
        $("#"+id).attr("dataid","");
        $("#"+id).attr("user_id","");
    }
    /* 选人控件 */
    $(".addKeeper").on("click",function(){//使用保管人
        user_id = "keeper";
        $.popWindow("../../common/selectUser?0");
    });

    $(".addKeepers").on("click",function(){//使用保管人
        user_id = "keepers";
        $.popWindow("../../common/selectUser?0");
    });

    //清空部门控件
    function emptyDept(id){
        $("#"+id).val("");
        $("#"+id).attr("deptid","");
    }
    /* 选部门控件 */
    $(".addAddress").on("click",function(){//所在位置
        dept_id = "localAddress";
        $.popWindow("../../common/selectDept?0");
    });

    //证书判断
    $("#isCertificate").on("change",function(){
        if($(this).find("option:selected").val() == "0"){
            $("#certificateNo").attr("disabled","disabled");
        }else{
            $("#certificateNo").attr("disabled",false);
        }

    })



    //保存按钮：editFlag==0 为添加操作，editFlag==1 为修改操作
    $("#saveBtn").on("click",function () {

        //检查是否为空
        var array = $(".test_null");
        var typeId = document.getElementById("typeId").value;
        if (typeId == 0){
            alert('请选择类别');
            return false;
        };
        for(var i=0;i<array.length;i++){
            if(array[i].value.length==""){
                alert('*号为必填项');
                return false;
            }
        }
        var attendId='';
        var attendName='';
        //使用保管人
        var keeper = $("#keeper").attr("dataid");

        var keepers = $("#keepers").attr("user_id");
        //所在位置
        var locationAddress=$("#localAddress").attr("deptid");
        if(locationAddress==''){
            locationAddress=0;
        }else{
            locationAddress =  locationAddress.split(',')[0];
        }
        //创建人
        var creater=$("#creater").attr("user_id");
        //固定资产名称
        var assetsName = $("#assetsName").val();
        //购买时间
        var buyTime = $("#buyTime").val();
        //有效时间
        var validityTime = $("#validityTime").val();
        //减少日期
        var dcrDate = $("#dcrDate").val();
        //启用日期
        var fromYy = $("#fromYy").val();
        //报废日期
        var logoutTime = $("#logoutTime").val();
        //品牌型号
        var info = $("#info").val();
        //数量
        var number = $("#number").val();
        //状态
        var status = $("#status option:selected").val();
        //备注
        var remake = $("#remake").val();
        var arr=[];
        var image=""
        var images = $(".smallImg")
        for(i=0;i<images.length;i++){
            arr.push($(images[i]).attr("src"));
        }
        if(arr.length>0){
            image = arr.join(",")
        }
        //以下是新加的2019/1/24
        //其他部门
        var otherDept = $('#client').val();
        var currutLocation = $("#currutLocation option:selected").val();
        //条形码
        var barCode = $("#barCode").val();
        //资产等级
        var capitalLevel = $("#capitalLevel").val();
        //制造厂商
        var manuFacturer = $("#manuFacturer").val();
        //出厂日期
        var manuDate = $("#manuDate").val();
        //计量单位
        var unitId = $("#unitId").val();
        //财务编号
        var fnamark = $("#fnamark").val();
        //预警数量
        var alertNum = $("#alertNum").val();
        //发票号码
        var invoice = $("#invoice").val();
        //合同号
        var contractNo = $("#contractNo").val();
        //以上是新加的2019/1/24

        //出厂编号
        var factoryNo = $("#factoryNo").val();
        //类别
        var typeId = $("#typeId").val();
        //资产性质
        var cptlKind = $("#cptlKind").val();
        //是否是应急救援设备
        var rescueType = $("#emergencyEquipment").val();
        //是否有证书
        var isCertificate = $("#isCertificate").val();
        //证书编号
        var certificateNo = $("#certificateNo").val();
        //增加类型
        var prcsId = $("#prcsId").val();
        //原值
        var cptlVal = $("#cptlVal").val();
        //残值率
        var cptlBal = $("#cptlBal").val();
        //折旧年限
        var dpctYy = $("#dpctYy").val();
        //月折旧额
        var monDpct = $("#monDpct").val();
        //累计折旧
        var sumDpct = $("#sumDpct").val();
        //所在位置
        // var currutLocation = $("#currutLocation").val();
        //使用年限
        var useYy = $("#useYy").val();
        //折旧率
        var monDepr = $("#monDepr").val();
        //资产净值
        var worth = $("#worth").val();
        //本年计提折旧
        var yyDpct=$("#yyDpct").val();
        //已计提月份
        var monAccrual = $("#monAccrual").val();
        //附件
        var fileId="";
        var fileName="";
        for(var i=0;i<$('.dech').length;i++){
            fileId +=$('.dech').eq(i).find('.inHidden').val();
            fileName += $('.dech').eq(i).find('a').attr('name')+',';
        }
        var assetsNameEnglish = $("#assetsNameEnglish").val();
        var deviceCode = $("#deviceCode").val();
        var depreciationMethod = $("#depreciationMethod").val();
        //是否是固定资产
        var isAssets = $("#isAssets").val();

        if(editFlag==0){//添加操作
            $.ajax({
                url:'/eduFixAssets/selFixAssetsById',
                type:'get',
                data:{
                    id:$('#id').val()
                },
                dataType:'json',
                success:function (res) {
                    if (res.flag){
                        alert('固定资产编号重复');
                        return;
                    } else {
                        $.ajax({
                            url:"/eduFixAssets/insertFixAssets",
                            type:'post',
                            dataType:'json',
                            data:{
                                id:$('#id').val(),
                                otherDept:otherDept,
                                isAssets:isAssets,
                                keeper:keeper,
                                scheduler:keepers,
                                deptId:locationAddress,
                                creater:creater,
                                createrTime:$("#createTime").val(),
                                assetsName:assetsName,
                                buyTime:buyTime,
                                info:info,
                                number:number,
                                status:status,
                                remark:remake,
                                image:image,
                                factoryNo:factoryNo,
                                typeId:typeId,
                                cptlKind:cptlKind,
                                rescueType:rescueType,
                                isCertificate:isCertificate,
                                certificateNo:certificateNo,
                                prcsId:prcsId,
                                cptlVal:cptlVal,
                                cptlBalVal:cptlBal,
                                cptlBal:cptlBal,
                                dpctYy:dpctYy,
                                monDpct:monDpct,
                                sumDpct:sumDpct,
                                dcrDate:dcrDate,
                                validityTime:validityTime,
                                logoutTime:logoutTime,
                                fromYymm:fromYy,
                                currutLocation:currutLocation,
                                useYy:useYy,
                                monDepr:monDepr,
                                worth:worth,
                                yyDpct:yyDpct,
                                attachmentId:fileId,
                                attachmentName:fileName,
                                monAccrual:monAccrual,
                                barCode:barCode,
                                capitalLevel:capitalLevel,
                                manuFacturer:manuFacturer,
                                manuDate:manuDate,
                                unitId:unitId,
                                fnamark:fnamark,
                                alertNum:alertNum,
                                invoice:invoice,
                                contractNo:contractNo,
                                assetsNameEnglish:assetsNameEnglish,
                                deviceCode:deviceCode,
                                depreciationMethod:depreciationMethod,
                                remind:function(){
                                    if($('.remind').prop('checked')==false){
                                        return '0';
                                    }else {
                                        return '1';
                                    }
                                },
                                smsRemind:function(){
                                    if($('.smsRemind').prop('checked')==false){
                                        return '0';
                                    }else {
                                        return '1';
                                    }
                                }
                            },
                            success:function (json) {
                                if(json.flag) {
                                    $.layerMsg({content: '<fmt:message code="diary.th.modify" />！', icon: 1}, function () {
                                        window.location.href='/eduFixAssets/fixAssetsManager';
                                        window.parent.show()
                                    });
                                }else{
                                    $.layerMsg({content: json.msg+'！', icon: 1}, function () {
                                    });
                                }
                            }
                        });
                    }
                }
            });
        }else{
            //编辑
            $.ajax({
                url:"/eduFixAssets/updateFixAssetsById",
                type:'post',
                dataType:'json',
                data:{
                    id:$('#id').val(),
                    otherDept:otherDept,
                    isAssets:isAssets,
                    keeper:keeper,
                    scheduler:keepers,
                    deptId:locationAddress,
                    creater:creater,
                    createrTime:$("#createTime").val(),
                    assetsName:assetsName,
                    buyTime:buyTime,
                    info:info,
                    monAccrual:monAccrual,
                    number:number,
                    status:status,
                    remark:remake,
                    image:image,
                    factoryNo:factoryNo,
                    typeId:typeId,
                    cptlKind:cptlKind,
                    rescueType:rescueType,
                    isCertificate:isCertificate,
                    certificateNo:certificateNo,
                    prcsId:prcsId,
                    cptlVal:cptlVal,
                    cptlBalVal:cptlBal,
                    cptlBal:cptlBal,
                    dpctYy:dpctYy,
                    monDpct:monDpct,
                    sumDpct:sumDpct,
                    dcrDate:dcrDate,
                    validityTime:validityTime,
                    logoutTime:logoutTime,
                    fromYymm:fromYy,
                    currutLocation:currutLocation,
                    useYy:useYy,
                    monDepr:monDepr,
                    worth:worth,
                    yyDpct:yyDpct,
                    attachmentId:fileId,
                    attachmentName:fileName,
                    barCode:barCode,
                    capitalLevel:capitalLevel,
                    manuFacturer:manuFacturer,
                    manuDate:manuDate,
                    unitId:unitId,
                    fnamark:fnamark,
                    alertNum:alertNum,
                    invoice:invoice,
                    contractNo:contractNo,
                    assetsNameEnglish:assetsNameEnglish,
                    deviceCode:deviceCode,
                    depreciationMethod:depreciationMethod,
                    remind:function(){
                        if($('.remind').prop('checked')==false){
                            return '0';
                        }else {
                            return '1';
                        }
                    },
                    smsRemind:function(){
                        if($('.smsRemind').prop('checked')==false){
                            return '0';
                        }else {
                            return '1';
                        }
                    }
                },
                success:function (json) {
                    if(json.flag) {
                        $.layerMsg({content: '<fmt:message code="diary.th.modify" />！', icon: 1}, function () {
                            // window.location.href='/eduFixAssets/fixAssetsManager';
                            window.location.href='/eduFixAssets/fixAssetsQuery';
                        });
                    }else{
                        $.layerMsg({content: json.msg+'！', icon: 1}, function () {
                        });
                    }
                }
            })
        }
    })
</script>
</body>
</html>
