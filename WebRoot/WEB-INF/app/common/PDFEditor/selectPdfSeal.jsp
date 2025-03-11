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
    <title>选择印章</title>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8 ? MYOA_CHARSET : htmlspecialchars($HTML_PAGE_CHARSET))?>" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../../css/workflow/m_reset.css">
    <link rel="stylesheet" type="text/css" href="../../css/workflow/work/bootstrap.css">
    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="../../js/base/base.js"></script>
    <style>
        .small {
            font-size: 9pt;
        }
        .big3 {
            font-size: 12pt;
            COLOR: #124164;
            FONT-WEIGHT: bold;
        }
        .TableBlock {
            border: 1px #dddddd solid;
            line-height: 20px;
            font-size: 9pt;
            border-collapse: collapse;
        }
        .TableData {
            BACKGROUND: #FFFFFF;
            COLOR: #000000;
        }
        .TableData:hover{
            background: #708DDF;
            color: #fff;
        }
        .TableHeader {
            COLOR: #383838;
            FONT-WEIGHT: bold;
            FONT-SIZE: 9pt;
            background: #fff;
            line-height: 40px;
            border-bottom: 1px #dddddd solid;
        }
        .TableBlock .TableHeader td, .TableBlock td.TableHeader {
            height: 30px;
            background: #ffffff;
            /* border: 1px #9cb269 solid; */
            font-weight: bold;
            color: #383838;
            line-height: 23px;
            padding: 0px;
            padding-left: 5px;
        }
        .TableBlock .TableData td, .TableBlock td.TableData {
            border-bottom: 1px #dddddd solid;
            border-top: 1px #dddddd solid;
            border-right: 1px #dddddd solid;
            padding: 3px;
            height: 30px;
        }
    </style>
</head>

<table width="100%" class="small" border="0" cellspacing="0" cellpadding="3">
    <tbody><tr>
        <td class="Big"><img align="absmiddle" src="/img/form/system.gif"><span class="big3"> 我的印章</span>&nbsp;
        </td>
    </tr>
    </tbody>
</table>
<table width="100%" class="TableBlock">
    <tbody>
    <tr class="TableHeader">
        <td align="center"><b>印章ID</b></td>
        <td align="center"><b>印章名称</b></td>
    </tr>

    </tbody>
</table>
<body>

<script>
    function click_seal(id){
        if(location.href.indexOf('ITEM=szaddSeal') > -1){
            window.opener.szaddSealImg(sealInfor[id].signImg, id)
        }else if(location.href.indexOf('ITEM=szAddh5') > -1){
            parent.szaddSealImg(sealInfor[id].signImg, id)
        }else{
            window.opener.addSealImg(sealInfor[id].signImg, sealInfor[id].attachmentId.split(',')[1], id);
        }
        window.close();
    }
    var sealInfor = {};
    $(function(){
        $.ajax({
            url:'/xsign/getXSignModels?usePriv=true',
            type:'get',
            dataType:'json',
            success:function(json){
                var str = '';
                for(var i=0;i<json.obj.length;i++){
                    sealInfor[json.obj[i].signId] = json.obj[i];
                    str += '<tr class="TableData">\
                        <td align="center" class="menulines" style="" onclick="javascript:click_seal('+ json.obj[i].signId +')">\
                        '+ json.obj[i].signId +'  </td>\
                        <td align="center" class="menulines" onclick="javascript:click_seal('+ json.obj[i].signId +')">\
                        '+ json.obj[i].signName +'  </td>\
                        </tr>';
                }
                $('.TableHeader').after(str);
            }
        })
    })

</script>
</body>
</html>