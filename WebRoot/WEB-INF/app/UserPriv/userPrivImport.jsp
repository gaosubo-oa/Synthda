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
    <title><fmt:message code="roleAuthorization.th.userPrivImport"/></title>
    <link rel="stylesheet" type="text/css" href="/lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base.css"/>
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
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

        #model {
            color: #00a0e9;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="content">
    <div class="importHead">
        <img src="/img/icon_rolemanage_06.png" style="margin-left: 30px;margin-bottom: 2px;">
        <span id="head"><fmt:message code="roleAuthorization.th.userPrivImport"/></span>
        <div id="Confidential" style="display: inline-block"></div>
    </div>
    <div class="importDiv">
        <form class="form1" name="form1" id="uploadForm" method="post" action="/inputUserPriv"
              enctype="multipart/form-data">
            <table class="importTable">
                <tr>
                    <td><fmt:message code="hr.th.DownloadImportTemplates"/>：</td>
                    <td><a id="model"><fmt:message code="roleAuthorization.th.userPrivImportFormwork"/></a></td>
                </tr>
                <tr>
                    <td><fmt:message code="hr.th.SelectImportfile"/>：</td>
                    <td><input style="width: auto" type="file" name="file"
                               accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"/>
                    </td>
                </tr>
                <tr>
                    <td><fmt:message code="roleAuthorization.th.Explain"/>：</td>
                    <td id="explain">
                        <p><fmt:message code="ipmort.th.7"/>。</p>
                        <p><fmt:message code="roleAuthorization.th.userPrivImport.th.2"/>。</p>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><input class="importBtn" type="button"
                                           value="<fmt:message code="workflow.th.Import" />"></td>
                </tr>
            </table>
        </form>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        var isOrgScope = $.GetRequest().isOrgScope || '';// 是否是分支机构角色与权限页面跳转过来
        if (isOrgScope === "") {
            $('#model').on("click", function () {
                window.location.href = encodeURI("/file/hr/角色权限导入模板.xls");
            });
        } else {
            $('title').text("<fmt:message code="roleAuthorization.th.userPrivImport1"/>");
            $('#head').text("<fmt:message code="roleAuthorization.th.userPrivImport1"/>");
            $('#model').text("<fmt:message code="roleAuthorization.th.userPrivImportFormwork1"/>");
            $('#uploadForm').attr("action", "/userPrivType/inputUserPriv");
            $('#explain').append('<p><fmt:message code="roleAuthorization.th.userPrivImport.th.3"/>。</p>');
            $('#model').on("click", function () {
                window.location.href = encodeURI("/file/hr/分支机构角色权限信息导入模板.xls");
            });
        }

        // 获取上传文件的input元素
        const fileInput = document.querySelector('input[type="file"]');

        // 监听文件上传完成事件
        fileInput.addEventListener('change', async (event) => {
            const file = event.target.files[0]; // 获取上传的文件对象
            if (!file.name.endsWith('.xls') && !file.name.endsWith('.xlsx')) { // 判断文件类型是否为.xls .xlsx
                alert('请上传 .xls 或者 .xlsx 格式的文件！');
            }
        });

        $('.importBtn').on("click", function () {
            var flag = CheckForm();
            if (flag) {
                layer.msg("<fmt:message code="down.th.2" />", {icon: 1});
                $('#uploadForm').ajaxSubmit({
                    type: 'post',
                    dataType: 'json',
                    success: function (res) {
                        if (res.flag) {
                            var data = res.object;
                            var str = "<fmt:message code="menuSSetting.th.importSuccess" />" + data.insertCounts + "条数据，失败" + data.failCounts + "条数据。";
                            if (data.reapNameCount != 0 || data.emptyCount != 0 || data.privTypeId != 0) {
                                str += '失败原因：';
                                if (data.emptyCount != 0) {
                                    str += '角色名称和角色排序号不能为空;';
                                }
                                if (data.reapNameCount != 0) {
                                    str += '角色名称重复;';
                                }
                                if (data.privTypeId != 0) {
                                    str += '角色分类不在管理范围内;';
                                }
                                $.layerMsg({content: str, icon: 0});
                            } else {
                                $.layerMsg({content: str, icon: 1}, function () {
                                });
                            }
                        } else {
                            $.layerMsg({content: res.msg, icon: 1}, function () {
                            });
                        }

                    }
                })
            }
        });

    })

    function CheckForm() {
        var fileName = document.form1.file.value;
        var fileExtension = fileName.split(".").pop();
        if (fileName === "") {
            layer.msg("<fmt:message code="user.th.selectImport" />！", {icon: 2});
            return false;
        }
        if (fileExtension !== "xls" && fileExtension !== "xlsx") {
            alert("请上传 .xls 或者 .xlsx 格式的文件！");
            return false;
        }
        return true;
    }
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
            var data=res.object[0]
            if (data.paraValue!=0){
                $('#Confidential').append('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </span>')
            }
        }
    })
</script>
</body>
</html>
