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
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <title><fmt:message code="main.unitquery" /></title>
    <link rel="stylesheet" href="../css/sys/companyinfo.css" />
    <script src="../js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style>
        .edui-default{
            margin-top: 0px;
        }

        .blue_text,.tab .tab{
            font-size: 11pt;
        }

    </style>
</head>
<body>
<div class="content">
    <div class="headDiv">
        <div class="nav_t1"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/danweichaxun.png"></div>
        <div class="divP"><fmt:message code="diary.th.unitInfo" /></div>
    </div>
    <div class="tab">
        <table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff">
            <tr>
                <td colspan="2" style="color:#23477e;font-size: 13pt;font-weight: bold;"><fmt:message code="diary.th.unitInfo" /></td>
            </tr>
            <tr>
                <td width="30%" class="blue_text"><fmt:message code="depatement.th.Unitname" />：</td>
                <td><input type="text" name="unitName" class="unitName" disabled="disabled" id="unitName"/></td>
            </tr>
            <tr>
                <td width="30%" class="blue_text"><fmt:message code="depatement.th.Telephone" />：</td>
                <td><input type="text" name="telNo" class="telNo" disabled="disabled" id="telNo"/></td>
            </tr>
            <tr>
                <td width="30%" class="blue_text"><fmt:message code="depatement.th.fax" />：</td>
                <td><input type="text" name="faxNo" class="faxNo" disabled="disabled" id="faxNo"/></td>
            </tr>
            <tr>
                <td width="30%" class="blue_text"><fmt:message code="depatement.th.Zipcode" />：</td>
                <td><input type="text" name="postNo" class="postNo" disabled="disabled" id="postNo"/></td>
            </tr>
            <tr>
                <td width="30%" class="blue_text"><fmt:message code="depatement.th.address" />：</td>
                <td><input type="text" name="address" class="address" disabled="disabled" id="address"/></td>
            </tr>
            <tr>
                <td width="30%" class="blue_text"><fmt:message code="depatement.th.website" />：</td>
                <td ><input type="text" name="url" class="url" disabled="disabled" id="url"/></td>
            </tr>
            <tr>
                <td width="30%" class="blue_text"><fmt:message code="depatement.th.Electronicmailbox" />：</td>
                <td><input type="text" name="email" class="email" disabled="disabled" id="email"/></td>
            </tr>
            <tr>
                <td width="30%" class="blue_text"><fmt:message code="depatement.th.Openingbank" />：</td>
                <td><input type="text" name="bankName" class="bankName" disabled="disabled" id="bankName"/></td>
            </tr>
            <tr>
                <td width="30%" class="blue_text"><fmt:message code="depatement.th.Accountnumber" />：</td>
                <td><input type="text" name="bankNo" class="bankNo" disabled="disabled" id="bankNo"/></td>
            </tr>
            <tr>
                <td width="30%" class="blue_text">税号：</td>
                <td><input type="text" name="taxNumber" class="taxNumber" disabled="disabled" id="taxNumber"/></td>
            </tr>
            <tr>
                <td colspan="2" style="color:#23477e;font-size: 13pt;font-weight: bold;"><fmt:message code="depatement.th.Unitprofile" /></td>
            </tr>

            <tr>
                <td colspan="2">
                    <div id="container" style="width: 99.9%;min-height: 300px;" name="content"></div>
                </td>
            </tr>
            <tr>
                <td width="20%"><fmt:message code="depatement.th.Attachmentdocument" />：</td>
                <td class="enclosure"></td>
            </tr>
        </table>
    </div>
</div>
<script type="text/javascript">
//    var ue = UE.getEditor('container',{
//        initialFrameHeight: 270,
//        elementPathEnabled:false
//    });
    $(function(){
//        ue.ready(function() {
            $.ajax({
                type: 'get',
                url: '/sys/showUnitManage',
                dataType: 'json',
                success: function (res) {
                    var data = res.object;
                    var str = '';
                    var arr = new Array();
                    arr = data.attachment;
                    $('.unitName').val(data.unitName);
                    $('.telNo').val(data.telNo);
                    $('.faxNo').val(data.faxNo);
                    $('.postNo').val(data.postNo);
                    $('.address').val(data.address);
                    $('.url').val(data.url);
                    $('.email').val(data.email);
                    $('.bankName').val(data.bankName);
                    $('.bankNo').val(data.bankNo);
                    $('.taxNumber').val(data.taxNumber);
                    if (data.attachmentName != '') {
                        for (var i = 0; i < arr.length; i++) {
                            str += '<div><a href="/download?' + arr[i].attUrl + '"><img style="vertical-align: middle;" src="../img/icon_print_07.png"/>' + arr[i].attachName + '</a></div>';
                        }
                    }
                    $('.enclosure').append(str);
                    $('#container').html(data.content);
//                    ue.setContent(data.content);
                }
            })
//        })
    })
</script>
</body>
</html>

