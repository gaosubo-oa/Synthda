<%--
  Created by IntelliJ IDEA.
  User: 李善澳
  Date: 2019/11/7
  Time: 9:59
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title><fmt:message code="vote.th.Classification"/></title>

    <style>
        .news {
            cursor: pointer;
        }

        .div_tr input {
            float: none;
            height: 28px;
            border-width: 1px;
            border-style: solid;
            border-color: rgb(153, 153, 153);
            border-image: initial;
        }

        .span_td {
            display: inline-block;
            width: 120px;
            text-align: right;
        }

        .inputlayout > ul ul > li.active {
            background: #4898d5;
            color: #fff;
        }

        .inPole {
            display: inline-block;
        }

        .Return {
            background: #4d90fe;
            margin-right: 40px;
            padding: 5px 10px;
            margin-top: 5px;
            border-radius: 4px;
            color: #fff;
            cursor: pointer;
            float: right;
        }

        .ADD {
            float: right;
            background: #4d90fe;
            margin-top: 5px;
            margin-right: 40px;
            padding: 5px 10px;
            border-radius: 4px;
            color: #fff;
            cursor: pointer;
        }

        .deleteok {
            width: 109px;
            height: 24px;
            background: url(../../img/btn_deleteannounce.png) 0px 0px no-repeat;
        }

        .delete_check {
            text-align: center;
            cursor: pointer;
        }

        .ADD {
            border-radius: 6px;
            padding: 5px 15px;
            background-color: #2b7fe0 !important;
        }

        .Return {
            padding: 5px 32px;
            background-color: #2b7fe0 !important;
        }
    </style>
    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/css/office/depository/index.css">
    <script type="text/javascript" src="../js/xoajq/xoajq3.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <style>
        .maintop p {
            line-height: 35px;
        }
    </style>
</head>
<body style="background: #fff">
<div class="maintop clearfix" style="margin-top: 4px;border-bottom: #999 1px solid;">
    <p>
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_addrole_06.png" style="margin-left: 20px;margin-bottom: 5px;">
        <span style="font-size: 18px;margin: 10px 0 10px 5px;color: black;">资产类别设置</span>
    </p>
    <button type="button" class="ADD">新建资产类别</button>
</div>


<div class="mainBottom" id="mainBottom" style="margin-top: 10px;">
    <table>
        <thead>
        <tr>
            <th class="th" style="color: #2F5C8F;width:8%;" align="center"><fmt:message code="workflow.th.Serial"/></th>
            <th class="th" style="color: #2F5C8F;" width="10%" align="center">类别名称</th>
            <%-- <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message
                     code="vote.th.SubordinateLibrary"/></th>--%>
            <th class="th" style="color: #2F5C8F;" width="10%" align="center">类别排序号</th>
            <th class="th" style="color: #2F5C8F;" width="20%" align="center"><fmt:message
                    code="menuSSetting.th.menuSetting"/></th>
            <%--操作--%>
        </tr>
        </thead>
        <tbody id="j_tb">
        </tbody>
    </table>
</div>
</body>
<script>
    window.onload = function selectAll() {
        $.ajax({
            url: '/eduFixAssets/getFixAssetstypeName',
            type: 'json',
            success: function (res) {
                var data = res.object;
                var len = data.length;
                var str = "";
                for (var i = 0; i < len; i++) {
                    str += '<tr>' +
                        '<td>' + (i + 1) + '</td>' +
                        '<td>' + data[i]['typeName'] + '</td>' +
                        '<td>' + data[i]['typeNo'] + '</td>' +
                        '<td>' +
                        ' <a href="javascript:;" class="details" onclick="edit(' + data[i]['typeId'] + ');">' + "<fmt:message code="global.lang.edit" />" + '</a>&nbsp' +
                        ' <a href="javascript:;" class="details" onclick="deleteone(' + data[i]['typeId'] + ');">' + "<fmt:message code="global.lang.delete" />" + '</a>&nbsp' +
                        '</td>' +
                        '</tr>';
                }
                $('.mainBottom table tbody').html(str);
            }
        });

    }


    function deleteone(e) {
        layer.confirm('<fmt:message code="sup.th.Delete1" />？', {
            btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'], //按钮
            title: "删除资产类别？",
            area: ['380px', '200px'],
            offset: ['80px', '300px'],
        }, function () {
            //确定删除，调接口
            $.ajax({
                type: 'post',
                url: '/eduFixAssets/delFixAssetsType',
                dataType: 'json',
                data: {'typeId': e},
                success: function (res) {
                    if (res.flag) {
                        layer.msg('<fmt:message code="workflow.th.delsucess" />', {icon: 6});
                        window.location.reload();

                    } else {
                        layer.msg('<fmt:message code="lang.th.deleSucess" />', {icon: 2});
                        window.location.reload();
                    }

                }
            })
        }, function () {
            layer.closeAll();
        });
    }

    function edit(e) {
        layer.open({
            type: 1,
            title: ['编辑资产类别分类', 'background-color:#2b7fe0;color:#fff;'],
            area: ['450px', '250px'],
            offset: ['80px', '300px'],
            shadeClose: true, //点击遮罩关闭
            btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
            content: '<div class="div_table" style="height: 100px;width: 250px; margin-top: 20px; margin-left: 10px;">' +
                '<input type="hidden" id="typeId">' +
                '<div class="div_tr" style="width:400px;margin:10px;line-height: 18px; ">' + '<span class="span_td">类别名称：</span><span><input type="text" style="width: 220px;" id="typeName" name="typeName"  value=""/></span></div>' +
                '<div class="div_tr" style="width:400px;margin:10px;line-height: 18px; ">' + '<span class="span_td">类别排序号：</span><span><input type="text" style="width: 220px;" id="typeNo" name="typeNo"  value=""] /></span></div>' +
                '</div>',
            success: function () {
                $.ajax({
                    type: 'get',
                    url: '/eduFixAssets/selFixAssetsTypeById',
                    data: {typeId: e},
                    dataType: 'json',
                    success: function (res) {
                        var datas = res.object;
                        $('#typeId').val(datas.typeId);
                        $('#typeName').val(datas.typeName);
                        $('#typeNo').val(datas.typeNo);
                    }
                })
            },
            yes: function (index) {
                var data = {
                    typeId: $('#typeId').val(),
                    typeName: $('#typeName').val(),
                    typeNo: $('#typeNo').val()

                }
                if (checkForm()) {

                    layer.close(index);
                    editClassification(data);

                }
            },
        });
    }


    $('.ADD').on("click",function () {
        layer.open({
            type: 1,
            title: ['新建资产类别', 'background-color:#2b7fe0;color:#fff;'],
            area: ['450px', '250px'],
            offset: ['80px', '300px'],
            shadeClose: true, //点击遮罩关闭
            content: '<div class="div_table" style="height: 100px;width: 250px; margin-top: 20px; margin-left: 10px;">' +
                '<div class="div_tr" style="width:400px;margin:10px;line-height: 18px; ">' + '<span class="span_td">类别名称：</span><span><input type="text" style="width: 220px;" id="typeName" name="typeName"  value="" /></span></div>' +
                '<div class="div_tr" style="width:400px;margin:10px;line-height: 18px; ">' + '<span class="span_td">类别排序号：</span><span><input type="text" style="width: 220px;" id="typeNo" name="typeNo"  value="" /></span></div>' +
                '</div>',
            btn: ['保存', '取消']
            , yes: function (index, layero) {
                var data = {
                    typeName: $('#typeName').val(),
                    typeNo: $('#typeNo').val()
                }
                if (checkForm()) {

                    layer.close(index);

                    newClassification(data);
                }
            }, btn2: function (index, layero) {
            }
        });
    })

    function checkForm() {
        if ($('#typeName').val() == "") {
            layer.msg('类别名称不能为空！', {icon: 2});
            return false;
        } else if ($('#typeNo').val() == "") {
            layer.msg('类别排序号不能为空！', {icon: 2});
            return false;
        } else if (isNaN($('#typeNo').val())) {
            layer.msg('类别排序号只能为数字！', {icon: 2});
            return false;
        }
        return true;
    }

    function newClassification(data) {
        $.ajax({
            type: 'post',
            url: '/eduFixAssets/insertFixAssetsType',
            dataType: 'json',
            data: data,
            async:false,
            success: function (res) {
                if (res.flag) {
                    if(res.msg == '类别名称重复'){
                        $.layerMsg({content: '类别名称重复', icon: 2});
                    }else{
                        $.layerMsg({content: '<fmt:message code="url.th.addSuccess" />！', icon: 1});
                        window.location.reload();
                    }

                } else {
                    $.layerMsg({content: '<fmt:message code="hr.th.AddFailed" />！', icon: 2});
                }
            }
        })
    }

    function editClassification(data) {
        $.ajax({
            type: 'post',
            url: '/eduFixAssets/updateFixAssetsType',
            dataType: 'json',
            data: data,
            async:false,
            success: function (res) {
                if (res.flag) {
                    if(res.msg == '类别名称重复'){
                        $.layerMsg({content: '类别名称重复', icon: 2});
                    }else{
                        $.layerMsg({content: '<fmt:message code="url.th.addSuccess" />！', icon: 1});
                        window.location.reload();
                    }
                } else {
                    $.layerMsg({content: '<fmt:message code="vote.th.UpdateFailure" />！', icon: 2});
                }
            }
        })
    }

</script>
</html>
