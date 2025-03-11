<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>固定资产导入</title>
    <link rel="stylesheet" type="text/css" href="/lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base.css"/>
    <script src="../../js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript"
            charset="utf-8"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="https://cdn.bootcss.com/jquery.form/4.2.1/jquery.form.js"></script>
    <style type="text/css">
        .importHead {
            margin: 10px 0 10px 20px;
        }

        .importHead span {
            font-size: 18px;
            margin: 10px 0 10px 5px;
            color: black;
        }

        .importTable {
            width: 80%;
            margin: 0 auto;
        }

        .importBtn {
            width: 60px;
            height: 30px;
            border-radius: 5px;
            cursor: pointer;
            margin-left: 40%;
        }

        #model{
            color: #00a0e9;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="content">
    <div class="importHead">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_addrole_06.png" style="margin-left: 30px;margin-bottom: 2px;">
        <span>资产导入</span>
    </div>
    <div class="importDiv">
        <form class="form1" name="form1" id="uploadForm" method="post" action="/eduFixAssets/inputFixAsserts"
              enctype="multipart/form-data">
            <table class="importTable">
                <tr>
                    <td><fmt:message code="hr.th.DownloadImportTemplates" />：</td>
                    <td><a id="model">固定资产导入模板下载</a></td>
                </tr>
                <tr>
                    <td><fmt:message code="hr.th.SelectImportfile" />：</td>
                    <td><input style="width: auto" type="file" name="file" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"/></td>
                </tr>
                <tr>
                    <td><fmt:message code="roleAuthorization.th.Explain" />：</td>
                    <td><p><fmt:message code="ipmort.th.7" />。</p>
                        <p>2、固定资产编号格式：GDZC+日期+5位序号，必填字段。</p>
                        <p>3、所在位置格式：汉字，必填字段。</p>
                        <p>4、资产名称：汉字，必填字段。</p>
                        <p>5、资产原值、残值率、折旧年限、累计折旧、折旧率：数字，必填字段。</p>
                        <p>6、购买时间、有限时间、减少日期、启用日期、报废日期格式：如：2018-11-11。</p>
                        <p>7、物品状态菜单选项有未使用、使用、损坏、丢失、报废。</p>
                        <p>8、如有重复的部门名称，为避免导入错误，请使用部门名称/部门电话的格式（A部门/88888）。</p>
                        <p>9、如有重复的人员名称，为避免导入错误，请使用人员名称/人员账号的格式（张三/zhangsan）。</p>
                    </td>
                </tr>
                <tr>
                    <td>其他选项:</td>
                    <td>
                        <label for="delFlag">是否删除Excel表以外的数据：</label>
                        <input id="delFlag" type="checkbox"><label for="delFlag">确定</label>
                        <span style="margin-left: 30px;color: red;">注意：该删除是不可逆的</span>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><input class="importBtn" type="button" value="<fmt:message code="workflow.th.Import" />"></td>
                </tr>
            </table>
        </form>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        $('#model').on("click",function () {
            window.location.href = encodeURI("/file/fixAssets/固定资产导入模板.xls");
        });

        $('.importBtn').on("click",function () {
            var flag = CheckForm();
            if (flag) {
                layer.msg("<fmt:message code="down.th.2" />", {icon: 1});

                var delFlag = '0';
                if($('#delFlag').is(':checked')){
                    delFlag = '1';
                }

                $('#uploadForm').ajaxSubmit({
                    dataType: 'json',
                    data:{
                        delFlag:delFlag
                    },
                    success: function (res) {
                        if (res.flag) {
                            var str="<fmt:message code="down.th.3" />" + res.object.inputSuccess +"<fmt:message code="event.th.StripData" />!<br>"+
                                "更新了" + res.object.updateSuccess +"<fmt:message code="event.th.StripData" />!";
                            layer.msg(str, {icon: 1});
                        } else {
                            layer.msg("导入失败", {icon: 2});
                        }
                    }
                })

            }
        });

    })
    function CheckForm() {
        if (document.form1.file.value == "") {
            layer.msg("<fmt:message code="user.th.selectImport" />！", {icon: 2});
            return (false);
        }

        return (true);
    }
</script>
</body>
</html>
