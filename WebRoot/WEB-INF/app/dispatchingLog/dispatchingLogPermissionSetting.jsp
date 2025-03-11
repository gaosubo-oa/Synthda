
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title>调度日志权限设置</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/base.css">
    <link rel="stylesheet" href="/css/workflow/flowsetting/style.css">
<%--    <script src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <style>
        .con_title .select_t{
            height: 30px;
            font-size: 14px;
            line-height: 30px;
            width: 220px;
        }
        .con_title .title_s{
            line-height: 32px;
        }
        .title_1{
            height: 80px;
            margin-top: 20px;
        }
        .title_2{
            margin-bottom: 25px;
        }
        .title_3{
            height: 63px;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        .select_put textarea{
            height: 60px;
            float: left;
            background: #fff;
            border: 1px solid #cccccc;
        }
        .select_put a,.select_put span{
            float: left;
            color: #2B7FE0;
        }
        .select_put{
            margin-top: 15px;
        }
        .con_l{
            width:425px;
        }
        .clear_r_cTwo{
            color: #e01919!important;
        }
        .btn{
            position: relative;
            padding: 4px 12px;
            /*text-shadow: 0 1px 0 #fff;*/
            white-space: nowrap;
            font-family: Simsun, Arial, sans-serif;
            font-weight: bold;
            text-align: center;
            vertical-align: middle;
            box-shadow: none;
        }
        .btn-success{
            border: 1px solid #2b7edf;
            color: #ffffff;
            background-color: #2b7edf;
            background-image: linear-gradient(to bottom, #2b7edf, #2b7edf);
            background-repeat: repeat-x;
            height: 30px;
            width: 100px;
            cursor: pointer;
            border-radius: 6px;
            font-size: 10pt;
        }
        .btn-delete{
            border: 1px solid #ef4747;
            color: #ffffff;
            background-color: #ef4747;
            background-image: linear-gradient(to bottom, #ef4747, #ef4747);
            background-repeat: repeat-x;
            width: 100px;
            height: 30px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 10pt;
        }
    </style>
</head>
<body>
<div class="cont_r" style="margin-left: -15px;overflow: auto">
    <div class="item_s item_con" style="overflow: auto; width:102.5%;">
        <table class="table" cellspacing="0" id="table_power">
            <caption class="clearfix">
                <img style="margin-right: 10px;width: 24px;padding-left: 0px;float: left;" src="/img/workflow/flowsetting/flowSettingMain/guanliquanxian.png"  alt="">
                <span class="priv_t">调度日志权限设置</span>
                <button type="button" class="btn btn-success newAndeEdit" id="new" style="margin-right: 5pt;"><img src="../../img/mywork/newbuildworjk1.png" style="margin-right: 3px;margin-bottom: 2px;">新建</button>
                <button type="button" class="btn btn-delete delete_d" style="margin-right: 10px;"><img src="../../img/mywork/deletework1.png" style="margin-right: 7px;margin-bottom: 0px;">删除</button>
            </caption>

            <thead>
            <tr>
                <th><fmt:message code="sms.th.Button" /></th>
                <th style="width:100px;"><fmt:message code="workflow.th.PrivilegeType" /></th>
                <th><fmt:message code="doc.th.ScopeAuthorization" /></th>
<%--                <th style="width:100px;"><fmt:message code="userManagement.th.ManagementScope" /></th>--%>
                <th style="width:100px;"><fmt:message code="notice.th.operation" /></th>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
</div>
<script>
    // 绑定单击事件
    $('#table_power').delegate('.newAndeEdit','click', function () {

        var privId = undefined;
        var str = '';
        var url = '';
        var strTitle = '';
        // 点击编辑按钮时
        if($(this).attr('data-id') == 1){
            // 获取当前权限的id
            privId = $(this).attr('privId');

            // 查找出文本框的value
            var data_i = $(this).find('input').val();
            // 转换成json对象
            data_i = JSON.parse(data_i);

            str = '编辑';
            url = '/dispatchingLogPermissionSetting/replacePriv';
            strTitle = '<fmt:message code="menuSSetting.th.editSuccess" />';

            // 点击新建按钮时
        } else {
            str = '新建';
            url = '/dispatchingLogPermissionSetting/addPriv';
            strTitle = '<fmt:message code="depatement.th.Newsuccessfully" />';
        }

        // 发起弹窗层
        layer.open({
            title: '<p id="title_info" style="background: #2b7fe0;height: 43px;width: 100%;font-size: 16px;padding-left: 10px;color: #fff">'+str+'</p>;',
            shade: 0.3,
            content: '<div class="pop_con">' +
                '<div class="con_t">' +
                '<div class="con_l">' +
                '<div class="con_title">' +
                '<div class="title_3">' +
                '<div class="title_label"></div>' +
                '<span class="title_s"><fmt:message code="workflow.th.Authorizationype" /> <label style="color: red;">*</label></span>' +
                '<div class="title_put"><select name="" id="select_t" class="select_t" onchange="selectChange($(this))">' +
                // '<option value="0">全部</option>' +
                '<option value="1">查看</option>' +
                '<option value="2">编辑</option>' +
                '<option value="3">删除</option>' +
                '</select></div>' +
                // '<span class="text1" style="display:  inline-block;margin-top: 10px;margin-left: 48px;"></span>' +
                '</div>' +
                '<div class="title_3">' +
                '<div class="title3_label">' +
                '<span class="title_s"><fmt:message code="netdisk.th.Scope(personnel)" /></span></div>' +
                '<div class="select_put">' +
                '<textarea name="txt" id="senduser" user_id="" value="" disabled></textarea>' +
                '<a style="margin-left: 18px;cursor: pointer" id="selectUser"><fmt:message code="global.lang.add" /></a>' +
                '<a style="margin-left: 18px;cursor: pointer" class="clear_r_cTwo"><fmt:message code="global.lang.empty" /></a></div></div>' + '<div class="title_3">' +
                '<div class="title3_label">' +
                '<span class="title_s"><fmt:message code="netdisk.th.ScopeAuthorization" /></span></div>' +
                '<div class="select_put">' +
                '<textarea name="txt" id="sendept" dept_id="" value="" disabled></textarea>' +
                '<span style="margin-left: 18px;cursor: pointer" id="selectUser_t"><fmt:message code="global.lang.add" /></span>' +
                '<span style="margin-left: 18px;cursor: pointer" class="clear_r_cTwo"><fmt:message code="global.lang.empty" /></span></div></div>' + '<div class="title_3">' +
                '<div class="title3_label">' +
                '<span class="title_s"><fmt:message code="netdisk.th.Scope(role)" /></span></div>' +
                '<div class="select_put">' +
                '<textarea name="txt" id="sendRole" userpriv="" priv_id="" value="" disabled></textarea>' +
                '<span style="margin-left: 18px;cursor: pointer" id="selectUser_s"><fmt:message code="global.lang.add" /></span>' +
                '<span style="margin-left: 18px;cursor: pointer" class="clear_r_cTwo"><fmt:message code="global.lang.empty" /></span></div></div>' +
                '</div></div></div>' +
                '</div>',
            area: ['650px', '475px'],
            btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
            scrolling: 'no',
            success: function () {
                // 清空文本框
                $('.clear_r_cTwo').on('click',function () {
                    $(this).siblings('textarea').val('')
                    $(this).siblings('textarea').attr('dataid','')
                    $(this).siblings('textarea').attr('user_id','')
                    $(this).siblings('textarea').attr('deptid','')
                    $(this).siblings('textarea').attr('privid','')
                    $(this).siblings('textarea').attr('userpriv','')
                })
                /*弹窗控件*/
                $("#selectUser").on('click',function () {
                    user_id = 'senduser';
                    $.popWindow("../common/selectUser");
                });
                $("#selectUser_t").on('click',function () {
                    dept_id = 'sendept';
                    $.popWindow("../common/selectDept?allDept=1");
                })
                $("#selectUser_s").on('click',function () {
                    priv_id = 'sendRole';
                    $.popWindow("../common/selectPriv");
                })
                $("#addSave_uTwo").on('click',function () {
                    dept_id = 'addUserTwos';
                    $.popWindow("../common/selectDept");
                })

                $("#addSave_uThree").on('click',function () {
                    user_id = 'addUserThrees';
                    $.popWindow("../common/selectUserIMAddGroup");
                })

                $("#addSave_uFour").on('click',function () {
                    priv_id = 'addUserFours';
                    $.popWindow("../common/selectPriv");
                })


                // 如果查到id 说明当前是编辑状态
                if (privId != undefined) {
                    // 回显授权类型
                    $("#select_t>option[value="+ data_i.privType +"]").attr("selected",true);
                    // 回显授权人员
                    $('#senduser').val(data_i.userName);
                    $('#senduser').attr('dataid', data_i.privUser);
                    $('#senduser').attr('userid', data_i.userId);
                    // 回显授权部门
                    $('#sendept').val(data_i.deptName);
                    $('#sendept').attr('deptid',data_i.privDept);
                    // 回显授权角色
                    $('#sendRole').val(data_i.roleName);
                    $('#sendRole').attr('privid',data_i.privRole);
                }


            },
            // 点击保存
            yes: function (index) {

                // 判断授权为空就提示
                if ($("#senduser").attr("dataid") != undefined ||
                    $("#sendRole").attr("privid") != undefined ||
                    $("#sendept").attr("deptid") != undefined) {

                    // 获取新建数据
                    var privType = $('#select_t').val();
                    var userId = $("#senduser").attr("dataid");
                    var roleId = $('#sendRole').attr('privid');
                    var deptId = $('#sendept').attr('deptid');

                    var data = {
                        'privType': privType,
                        'privUser': userId,
                        'privRole':roleId,
                        'privDept': deptId,
                    };
                    if(privId != undefined) data.privId = privId;

                    $.ajax({
                        type: 'post',
                        url: url,
                        dataType: 'json',
                        data: data,
                        success: function (data) {
                            if (data.flag) {
                                $.layerMsg({content:strTitle,icon:1},function(){
                                    allPeimissions();
                                });
                            } else {
                                layer.msg('<fmt:message code="sms.th.operationFailed" />。。', {icon: 6})
                            }
                        }
                    });
                } else {
                    alert('<fmt:message code="workflow.th.Authorization" />'); return;
                }
            }
        });
    })
</script>


<script>
    // 查询所有权限
    var priv_type = ['','查询','编辑','删除']
    function allPeimissions() {
        $.ajax({
            type: 'get',
            url: "/dispatchingLogPermissionSetting/getDispatchingLogPrivList",
            dataType: "json",
            success: function (result) {
                var datas = result.data;
                var html='';
                if (result.flag) {
                    for (var i = 0; i < datas.length; i++) {
                        var type = (datas[i].privType) * 1;
                        var typeStr = "";
//                        if (i >= 0 && i <= 5) {
                        typeStr = priv_type[type];
//                        }
                        var u_d_r_Str = "";
                        if (datas[i].userName) {
                            u_d_r_Str += "<fmt:message code="journal.th.user" />:" + datas[i].userName + "</br>";
                        }
                        if (datas[i].deptName) {
                            u_d_r_Str += "<fmt:message code="userManagement.th.department" />:" + datas[i].deptName + "</br>";
                        }
                        if (datas[i].roleName) {
                            u_d_r_Str += "<fmt:message code="userManagement.th.role" />:" + datas[i].roleName + "</br>";
                        }

                        var data_g = {};
                        data_g.deptName = datas[i].deptName;
                        data_g.roleName = datas[i].roleName;
                        data_g.userName = datas[i].userName;
                        data_g.privType = datas[i].privType;
                        data_g.userId = datas[i].userId;
                        data_g.privUser = datas[i].privUser;
                        data_g.privDept = datas[i].privDept;
                        data_g.privRole = datas[i].privRole;
                        var strdata_g = JSON.stringify(data_g);
                        strdata_g="'"+strdata_g+"'";
                        html += '' +
                            '<tr>' + '' +
                            '<td style="display: none">' + datas[i].privId + '</td>'
                            + '<td>' + '<input type="checkbox" privId="' + datas[i].privId + '" class="one">' + '</td>' +
                            '' + '<td>' + typeStr + '</td>' + '' +
                            '<td style="text-align: center;padding-left: 10px">' + u_d_r_Str + '</td>' +
                            // '<td style="text-align: center;padding-left: 10px">' + datas[i].scopeName + '</td>' +
                            '' + '<td>' + '<a href="javascript:void(0)" class="powerUpdate fileUpdateactive newAndeEdit" data-id="1" privId="' + datas[i].privId + '" >' +
                            '<input type="hidden" value='+strdata_g+'>'+'<fmt:message code="menuSSetting.th.editMenu" /></a>' +
                            '' + '<a href="javascript:void(0)" class="delete_d del_privactive" privId="' + datas[i].privId + '"><fmt:message code="menuSSetting.th.deleteMenu" /></a>' + '</td>' + '</tr>';
                    }
                }
                $('#table_power tbody').html(html);
            }
        })
    }
    allPeimissions();

    // 删除
    $('#table_power').delegate('.delete_d','click',function () {
        var privId = [];
        if ($('.one').is(':checked')) {
            $.each($('.one:checked'), function (index, elem) {
                privId.push($(elem).attr('privId'));
            });
        } else if ($(this).attr('privId') > 0){
            privId.push($(this).attr('privId'));
        } else {
            layer.msg("请选中需要删除的内容");
            return;
        }
        privId = JSON.stringify(privId);
        $.layerConfirm({
            title: '<fmt:message code="menuSSetting.th.suredeleteMenu" />',
            content: '<fmt:message code="workflow.th.que" />？',
            icon: 0
        }, function () {
            $.ajax({
                type: 'post',
                url: '/dispatchingLogPermissionSetting/removePriv',
                contentType:'application/json;charset=UTF-8',
                data:privId,
                dataType: 'json',
                success: function (result) {
                    if (result.flag) {
                        $.layerMsg({content: '<fmt:message code="workflow.th.delsucess" />！', icon: 1}, function () {
                            allPeimissions();
                        });
                    } else {
                        $.layerMsg({content: '<fmt:message code="lang.th.deleSucess" />！', icon: 1});
                    }
                }
            })
        });
    });
</script>
</body>
</html>
