<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<head>
    <head>
        <title>选择部分OA用户同步到企业微信</title>
        <meta http-equiv="Content-Type" content="text/html; charset=gbk"/>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1"/>
        <meta name="viewport"
              content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    </head>
    <link rel="stylesheet" type="text/css" href="../../css/common/style.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../css/enterpriseManage/weixinqy.css">
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script src="../../js/wechatQY/wechatBase.js"></script>
    <link rel="stylesheet" type="text/css" href="../../css/common/ui.dynatree.css">
    <script type="text/javascript" src="../../js/js_lang.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
<body>
<style>
    body {
        background-color: #f5f5f5;
    }
</style>
<div>
    <div class="sync-item" style="padding: 20px">
        <button id="btn-oa-user-sync" class="btn btn-small btn-primary" type="button">导入选择的人员</button>
    </div>
    <div class="sync-tree sync-user-tree">
        <div id="userTree">
            <div class="cont_left" id="cont_left">
                <ul>
                    <li class="liDown dept_li" id="dept_lis"><img
                            src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_sectorList.png"
                            style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="部门列表"><fmt:message
                            code="depatement.th.depa"/></li>
                    <li class="pick" style="display: block;">
                        <%--                        <div class="pickCompany"><span style="height:35px;line-height:35px;" class="childdept"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 10px;margin-left: 13px;margin-bottom: 4px;"><a href="javascript:void(0)" class="dynatree-title" title=""></a></span></div>--%>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    var uid1 = []
    $('#userTree').on('click', 'input[type=checkbox]', function () {
        var uid = new Array();
        $("input[type=checkbox]:checked").each(function (index) {
            uid.push($(this).parent().attr('userid'));
        })
        uid1 = uid.join(',');
    })

    $('#btn-oa-user-sync').click(function () {
        // console.log(uid1);
        if (uid1.length > 0) {
            layer.confirm('确定导入选择的人员吗？', function (index) {
                layer.close(index);
                $.post('/ewx/chooseOAUserToWX', {userIds: uid1}, function (res) {
                    if (res.flag) {
                        layer.msg('同步成功！', {icon: 1});
                    } else {
                        layer.msg(res.msg, {icon: 2});
                    }
                })
            });
        } else {
            layer.msg('请先选择导入的人员！', {icon: 2});
        }

    })
    loadSidebar1($('.pick'), 0)

    function loadSidebar1(target, deptId) {
        $.ajax({
            url: '/department/getChDeptfq',
            type: 'get',
            data: {
                deptId: deptId
            },
            dataType: 'json',
            success: function (data) {
                var str = '';
                data.obj.forEach(function (v, i) {
                    if (v.deptName) {
                        str += '<li><span data-types="1"  data-numtrue="1" ' +
                            'onclick= "imgDown_s(' + v.deptId + ',this)"  style="height:35px;line-height:35px;padding-left: 30px" deptid="' + v.deptId + '" class="firsttr childdept"><span class=""></span><img src="/img/sys/dapt_right.png" alt="" style="margin-left: 12px;width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;"><a href="javascript:void(0)" class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a></span><ul style="display:none;" class="dpetWhole0"></ul></li>';
                    }
                })
                target.append(str);
            }
        })
    }


</script>
</body>
</html>
