<%--
  Created by IntelliJ IDEA.
  User: gaosubo3000
  Date: 2020/12/15
  Time: 17:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title><fmt:message code="system_config.documentSettings" /></title>
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/jquery/jquery.cookie.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
</head>
<style>
    .content{
        width: 80%;
        margin: 20px auto;
    }
    .headText{
        background: cornflowerblue !important;
        color: white;
    }
    .qutitle{
        font-weight: bold;
    }
    .qutitle .layui-form-radio {
        width: 100% !important;
    }
    .qutitle .layui-form-radio div {
        width: 97% !important;
    }
    input{
        width: 200px;
    }
    .layui-input, .layui-textarea{
        display: inline-block;
        width: 40%;
    }
    /*.tdRight{*/
    /*    text-align: right;*/
    /*}*/
</style>
<body>
<div class="content">
    <form class="layui-form" action="">
        <table class="layui-table">
            <colgroup>
                <col width="27%">
                <col>
            </colgroup>
            <thead>
            <tr class="headText">
                <th colspan="2" ><h3><fmt:message code="system_config.officeDocumentOnlinePreviewSettings" /></h3></th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td colspan="2" class="qutitle">
                    <input class="DOCUMENT_PREVIEW_OPEN2" type="radio" name="DOCUMENT_PREVIEW_OPEN" values = '2' value="内置预览服务（安全性高，支持内网、外网及保密环境使用）" title="<fmt:message code="system_config.builtInPreviewService" />" checked="">
                </td>
            </tr>
            <tr>
                <td class="tdRight"><fmt:message code="system_config.useMicrosoftOfficeToConvertWordDocuments" /></td>
                <td>
                    <input class="WORD_TO_HTML_OPEN1" type="radio"  value="是" name="WORD_TO_HTML_OPEN" title="<fmt:message code="global.lang.yes" />" checked values="1">
                    <input class="WORD_TO_HTML_OPEN0" type="radio"  value="否" name="WORD_TO_HTML_OPEN" title="<fmt:message code="global.lang.no" />" values="0">
                </td>

            </tr>
            <tr>
                <td class="tdRight"><fmt:message code="system_config.microsoftOfficeServerAddress" /></td>
                <td>
                    <input type="text" class="layui-input wordToHtmlAddress" style="width: 230px;" name="WORD_TO_HTML_ADDRESS" value="">
                    <%--                        <input type="tel" name="phone" lay-verify="required|phone" autocomplete="off" class="layui-input">--%>
                    <span><fmt:message code="system_config.microsoftOfficeServerAddressInfo" /></span>
                </td>
            </tr>
            <tr>
                <td class="tdRight"><fmt:message code="system_config.previewDocumentWithWatermarkDisplay" /></td>
                <td>
                    <input class="DOCUMENT_PREVIEW_WATERMARK1" type="radio"  value="是" name="DOCUMENT_PREVIEW_WATERMARK" title="<fmt:message code="global.lang.yes" />" checked values="1">
                    <input class="DOCUMENT_PREVIEW_WATERMARK0" type="radio"  value="否" name="DOCUMENT_PREVIEW_WATERMARK" title="<fmt:message code="global.lang.no" />" values="0">
                </td>

            </tr>
            <tr>
                <td colspan="2" class="qutitle">
                    <input class="DOCUMENT_PREVIEW_OPEN3" type="radio" name="DOCUMENT_PREVIEW_OPEN" values="3" value="金山WPS云服务（安全性一般，文档会上传金山云，请谨慎使用）" title="<fmt:message code="system_config.kingsoftWPSCloudService" />">
                </td>
            </tr>
            <tr>
                <td class="tdRight"> <fmt:message code="system_config.APPID" /></td>
                <td>
                    <input type="tel" name="WPS_OPEN_APPID" lay-verify="required|phone" autocomplete="off" class="layui-input">
                </td>

            </tr>
            <tr>
                <td class="tdRight"> <fmt:message code="system_config.APPKEY" /> </td>
                <td>
                    <input type="tel" name="WPS_OPEN__APPKEY" lay-verify="required|phone" autocomplete="off" class="layui-input">
                </td>
            </tr>
            <tr>
                <td colspan="2" class="qutitle">
                    <input class="DOCUMENT_PREVIEW_OPEN1" type="radio" name="DOCUMENT_PREVIEW_OPEN" values="1" value="微软Office云服务（安全性较差，文档会上传微软云，请谨慎使用）" title="<fmt:message code="system_config.microsoftOfficeCloudServices" />">
                </td>
            </tr>
            <tr>
                <td class="tdRight"><fmt:message code="system_config.officeWebAppServer" /></td>
                <td>
                    <input type="text" class=" layui-input intnetShow" style="width: 230px;" name="DOCUMENT_PREVIEW" value="">
                    <%--                        <input type="tel" name="phone" lay-verify="required|phone" autocomplete="off" class="layui-input">--%>
                    <span><fmt:message code="system_config.alternativeFreeCloudServers" />： https://view.officeapps.live.com</span>
                </td>
            </tr>
            <tr>
                <td class="tdRight"><fmt:message code="system_setting.outside_address" /></td>
                <td>
                    <input  class="layui-input" type="text" name="OUTSIDE_ADDRESS" style="width: 230px;" placeholder="<fmt:message code="system_setting.please_fill_address" />">
                    <%--                        <input type="tel" name="phone" lay-verify="required|phone" autocomplete="off" class="layui-input">--%>
                    <span><fmt:message code="system_setting.address_example_info" /></span>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="qutitle">
                    <input class="DOCUMENT_PREVIEW_OPEN4" type="radio" name="DOCUMENT_PREVIEW_OPEN" values="4" value="Only Office文档服务" title="<fmt:message code="system_config.onlyOfficeDocumentServices" />">
                </td>
            </tr>
            <tr>
                <td class="tdRight"><fmt:message code="system_config.onlyOfficeServerAddress" /></td>
                <td>
                    <input type="tel" name="ONLY_OFFICE_ADDRESS" lay-verify="required|phone" autocomplete="off" class="layui-input">
                    <span><fmt:message code="system_config.onlyOfficeServerAddressDesc" /></span>
                </td>
            </tr>
            <tr>
                <td class="tdRight"><fmt:message code="system_config.onlyOfficeServerIntranetAddress" /></td>
                <td>
                    <input type="tel" name="ONLY_OFFICE_ADDRESS_LAN" lay-verify="required|phone" autocomplete="off" class="layui-input">
                    <span><fmt:message code="system_config.onlyOfficeServerIntranetAddressDesc" /></span>
                </td>
            </tr>
            <tr>
                <td class="tdRight"><fmt:message code="system_config.theAccessAddressOfThisSystem" /></td>
                <td>
                    <input class="layui-input" type="text" name="OUTSIDE_ADDRESS2" lay-verify="required|phone" autocomplete="off" class="layui-input">
                    <span><fmt:message code="system_config.theAccessAddressOfThisSystemDesc" /></span>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="qutitle">
                    <input class="DOCUMENT_PREVIEW_OPEN0" type="radio" name="DOCUMENT_PREVIEW_OPEN" values="0" value="关闭Office文档在线预览" title="<fmt:message code="system_config.turnOffTheOnlinePreviewOfOfficeDocuments" />">
                </td>
            </tr>
            <tr style="height: 52px"></tr>
            <tr class="headText">
                <th colspan="2" ><h3><fmt:message code="system_config.onlineViewingAndEditingSettingsForOfficeDocuments" /></h3></th>
            </tr>
            <tr>
                <td colspan="2" class="qutitle" style="line-height: 25px">
                    <%--                        <input type="radio" name="OFFICE_EDIT" checked value="1">--%>
                    <input class="OFFICE_EDIT1" type="radio" name="OFFICE_EDIT" values="1" value="点聚WebOffice插件（需配合IE内核浏览器、双核浏览器如360或OA精灵PC客户端使用。安全性高，支持内网、外网及保密环境使用）" title="<fmt:message code="system_config.onlineViewingAndEditingSettingsForOfficeDocuments.Dianju" />"  checked="">
                </td>
            </tr>
            <tr>
                <td colspan="2" class="qutitle" style="line-height: 25px">
                    <input class="OFFICE_EDIT0" type="radio" name="OFFICE_EDIT" values="0" value="软航NTKO插件（需配合IE内核浏览器、双核浏览器如360或OA精灵PC客户端使用。安全性高，支持内网、外网及保密环境使用）" title="<fmt:message code="system_config.onlineViewingAndEditingSettingsForOfficeDocuments.NTKO" />" >
                </td>
            </tr>
            <tr>
                <td colspan="2" class="qutitle" style="line-height: 25px">
                    <input class="OFFICE_EDIT2" type="radio" name="OFFICE_EDIT" values="2" value="金山WPS云服务（支持主流浏览器如360或OA精灵PC客户端使用。安全性一般，文档会上传金山云，请谨慎使用）" title="<fmt:message code="system_config.onlineViewingAndEditingSettingsForOfficeDocuments.WPS" />" >
                </td>
            </tr>
            <tr>
                <td colspan="2" class="qutitle" style="line-height: 25px">
                    <input class="OFFICE_EDIT3" type="radio" name="OFFICE_EDIT" values="3" value="only Office云服务" title="<fmt:message code="system_config.onlyOfficeDocumentServices" />" >
                </td>
            </tr>
            <tr>
                <td colspan="2" class="qutitle" style="line-height: 25px">
                    <input class="OFFICE_EDIT_CLOSE" type="radio" name="OFFICE_EDIT" values="-1" value="关闭Office文档在线查阅、编辑" title="<fmt:message code="system_config.turnOffTheOnlineViewingAndEditingOfOfficeDocuments" />" >
                </td>
            </tr>
            </tbody>
        </table>
        <div style="display: flex;justify-content: center;margin-top: 20px">
            <button type="button" class="layui-btn saveBtn"><fmt:message code="global.lang.save" /></button>
        </div>

    </form>
</div>
</body>
</html>
<script>
    layui.use(['form', 'layedit', 'laydate'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate;
        form.render()
        var OUTSIDE_ADDRESS0 = ''
        var OUTSIDE_ADDRESS2 = ''
        //回显
        $(function(){
            var paraName = 'WORD_TO_HTML_OPEN,WORD_TO_HTML_ADDRESS,WPS_OPEN_APPID,WPS_OPEN__APPKEY,DOCUMENT_PREVIEW,OUTSIDE_ADDRESS,OFFICE_EDIT,DOCUMENT_PREVIEW_OPEN,ONLY_OFFICE_ADDRESS,ONLY_OFFICE_ADDRESS_LAN,DOCUMENT_PREVIEW_WATERMARK'
            var paraNames = paraName.split(",")
            console.log(paraNames)
            $.ajax({
                type: 'get',
                url: '/sysTasks/getSysParaList',
                contentType: "application/json",
                dataType: 'json',
                data:{
                    paraName:paraName
                },

                success: function (res) {
                    console.log(res)
                    var item=res.obj;
                    for(var i=0;i<item.length;i++){
                        // word转换html开关
                        if(item[i].paraName =='WORD_TO_HTML_OPEN'){
                            if(item[i].paraValue == 1){
                                $('.WORD_TO_HTML_OPEN1').attr("checked", "checked");
                            }else if(item[i].paraValue == 0){
                                $('.WORD_TO_HTML_OPEN0').attr("checked", "checked");
                            }
                            // $(":radio[name='WORD_TO_HTML_OPEN'][value='" + item[i].paraValue + "']").prop("checked", "checked");
                        }
                        if(item[i].paraName =='DOCUMENT_PREVIEW_WATERMARK'){
                            if(item[i].paraValue == 1){
                                $('.DOCUMENT_PREVIEW_WATERMARK1').attr("checked", "checked");
                            }else if(item[i].paraValue == 0){
                                $('.DOCUMENT_PREVIEW_WATERMARK0').attr("checked", "checked");
                            }
                        }
                        //word转换html地址
                        if(item[i].paraName =='WORD_TO_HTML_ADDRESS' ){
                            $('input[name="WORD_TO_HTML_ADDRESS"]').val(item[i].paraValue);
                        }
                        //wps   WPS_OPEN_APPID
                        if(item[i].paraName =='WPS_OPEN_APPID' ){
                            $('input[name="WPS_OPEN_APPID"]').val(item[i].paraValue);
                        }
                        //wps   WPS_OPEN__APPKEY
                        if(item[i].paraName =='WPS_OPEN__APPKEY' ){
                            $('input[name="WPS_OPEN__APPKEY"]').val(item[i].paraValue);
                        }

                        //wps   备选免费云服务器：
                        if(item[i].paraName =='DOCUMENT_PREVIEW' ){
                            $('input[name="DOCUMENT_PREVIEW"]').val(item[i].paraValue);
                        }
                        //wps   备选免费云服务器：
                        if(item[i].paraName =='DOCUMENT_PREVIEW' ){
                            $('input[name="DOCUMENT_PREVIEW"]').val(item[i].paraValue);
                        }

                        //only office 的服务器地址
                        if(item[i].paraName =='ONLY_OFFICE_ADDRESS' ){
                            $('input[name="ONLY_OFFICE_ADDRESS"]').val(item[i].paraValue);
                        }
                        //only office 的服务器内网地址
                        if(item[i].paraName =='ONLY_OFFICE_ADDRESS_LAN' ){
                            $('input[name="ONLY_OFFICE_ADDRESS_LAN"]').val(item[i].paraValue);
                        }

                        //wps   本系统外网访问地址：
                        if(item[i].paraName =='OUTSIDE_ADDRESS' ){
                            $('input[name="OUTSIDE_ADDRESS"]').val(item[i].paraValue);
                            $('input[name="OUTSIDE_ADDRESS2"]').val(item[i].paraValue);
                            OUTSIDE_ADDRESS0 = item[i].paraValue
                            OUTSIDE_ADDRESS2 = item[i].paraValue
                        }

                        //wps   本系统外网访问地址：OFFICE_EDIT
                        if(item[i].paraName =='OFFICE_EDIT' ){
                            if(item[i].paraValue == 1){
                                $('.OFFICE_EDIT1').attr("checked", "checked");
                            }else if(item[i].paraValue == 0){
                                $('.OFFICE_EDIT0').attr("checked", "checked");
                            }else if(item[i].paraValue == 3){
                                $('.OFFICE_EDIT3').attr("checked", "checked");
                            }else if(item[i].paraValue == 2){
                                $('.OFFICE_EDIT2').attr("checked", "checked");
                            } else { // 关闭为 -1
                                $('.OFFICE_EDIT_CLOSE').attr("checked", "checked");
                            }
                        }


                        if(item[i].paraName == 'DOCUMENT_PREVIEW_OPEN'){
                            if(item[i].paraValue == 1){
                                $('.DOCUMENT_PREVIEW_OPEN1').attr("checked", "checked");
                            }else if(item[i].paraValue == 0){
                                $('.DOCUMENT_PREVIEW_OPEN0').attr("checked", "checked");
                            }else if(item[i].paraValue == 2){
                                $('.DOCUMENT_PREVIEW_OPEN2').attr("checked", "checked");
                            }else if(item[i].paraValue == 4){
                                $('.DOCUMENT_PREVIEW_OPEN4').attr("checked", "checked");
                            }else if(item[i].paraValue == 3) {
                                $('.DOCUMENT_PREVIEW_OPEN3').attr("checked", "checked");
                            }
                        }
                    }


                    form.render()
                }
            })
        })


        //保存
        $('.saveBtn').click(function () {
            var arr=[];
            var object1={};
            object1.paraName="WORD_TO_HTML_OPEN";
            object1.paraValue=$('input[name="WORD_TO_HTML_OPEN"]:checked').attr('values');
            arr.push(object1);
            var object2={};
            object2.paraName="WORD_TO_HTML_ADDRESS";
            object2.paraValue=$('input[name="WORD_TO_HTML_ADDRESS"]').val();
            arr.push(object2);
            var object3={};
            object3.paraName="WPS_OPEN_APPID";
            object3.paraValue=$('input[name="WPS_OPEN_APPID"]').val();
            arr.push(object3);
            var object4={};
            object4.paraName="WPS_OPEN__APPKEY";
            object4.paraValue=$('input[name="WPS_OPEN__APPKEY"]').val();
            arr.push(object4);
            var object5={};
            object5.paraName="DOCUMENT_PREVIEW";
            object5.paraValue=$('input[name="DOCUMENT_PREVIEW"]').val();
            arr.push(object5);
            if(OUTSIDE_ADDRESS0 != $('input[name="OUTSIDE_ADDRESS"]').val() && OUTSIDE_ADDRESS2 == $('input[name="OUTSIDE_ADDRESS2"]').val()){
                var object6={};
                object6.paraName="OUTSIDE_ADDRESS";
                object6.paraValue=$('input[name="OUTSIDE_ADDRESS"]').val();
                arr.push(object6);
            }else if( OUTSIDE_ADDRESS2 != $('input[name="OUTSIDE_ADDRESS2"]').val() && OUTSIDE_ADDRESS0 == $('input[name="OUTSIDE_ADDRESS"]').val()){
                var object6={};
                object6.paraName="OUTSIDE_ADDRESS";
                object6.paraValue=$('input[name="OUTSIDE_ADDRESS2"]').val();
                arr.push(object6);
            }else{
                var object6={};
                object6.paraName="OUTSIDE_ADDRESS";
                object6.paraValue=$('input[name="OUTSIDE_ADDRESS"]').val();
                arr.push(object6);
            }

            var object7={};
            object7.paraName="OFFICE_EDIT";
            object7.paraValue=$('input[name="OFFICE_EDIT"]:checked').attr('values');
            arr.push(object7);
            var object8={};
            object8.paraName="DOCUMENT_PREVIEW_OPEN";
            object8.paraValue=$('input[name="DOCUMENT_PREVIEW_OPEN"]:checked').attr('values');
            arr.push(object8);
            var object9={};
            object9.paraName="ONLY_OFFICE_ADDRESS";
            object9.paraValue=$('input[name="ONLY_OFFICE_ADDRESS"]').val();
            arr.push(object9);
            var object10={};
            object10.paraName="DOCUMENT_PREVIEW_WATERMARK";
            object10.paraValue=$('input[name="DOCUMENT_PREVIEW_WATERMARK"]:checked').attr('values');
            arr.push(object10);

            var object11={};
            object11.paraName="ONLY_OFFICE_ADDRESS_LAN";
            object11.paraValue=$('input[name="ONLY_OFFICE_ADDRESS_LAN"]').val();
            arr.push(object11);


            if(arr[7].paraValue == 3 || arr[6].paraValue == 2){
                if($('input[name="WPS_OPEN_APPID"]').val()== '' || $('input[name="WPS_OPEN__APPKEY"]').val()== ''){
                    layer.msg('<fmt:message code="system_config.pleaseFillInTheappIDAndappkey" />',{icon: 2});
                    return false
                }
            }

            $.ajax({
                type:'post',
                url:'/sysTasks/updateSysTasks',
                dataType:'json',
                data:{
                    jsonStr:JSON.stringify(arr)
                },
                success:function (res) {
                    if(res.flag){
                        var str='<fmt:message code="menuSSetting.th.editSuccess" />'
                        layer.msg(str, {icon: 1,time:3000,title: "<fmt:message code="system_config.warmPrompt" />",offset:"40%"});
                    }else {
                        layer.msg('<fmt:message code="menuSSetting.th.editFail" />！', {icon: 2,time:3000,title: "<fmt:message code="system_config.warmPrompt" />",offset:"40%"});
                    }
                }
            })
        })

    });
</script>