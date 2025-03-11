<%--
  Created by IntelliJ IDEA.
  User: CY
  Date: 2017/12/18
  Time: 14:14
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <title><fmt:message code="adding.th.xiXUN"/></title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta http-equiv="Content-Type" content="text/html;">
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css"/>
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.tag.css"/>
    <link rel="stylesheet" href="../../css/officialDocument/officialDocument.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
<%--    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="../js/bootstrap/bootstrap.min.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <style>
        .top {
            width: 100%;
            padding-left: 20px;
            margin: 0 auto;
            height: 50px;
            line-height: 50px;
        }

        .big3 {
            font-size: 12pt;
            color: #124164;
            font-weight: bold;
        }

        .conIn {
            width: 600px;
            border: #EEE0E0 1px solid;
            margin: 0 auto;
            background-color: #FFF;
            padding: 20px 0 20px 0;
        }

        ul {
            margin: 0px;
            padding: 0px;
        }

        ul li {
            list-style: none;
            margin-bottom: 20px;
        }

        .control-label {
            display: inline-block;
            width: 160px;
            text-align: right;
        }

        input[type=text] {
            height: 28px !important;
            padding: 4px 6px;
            vertical-align: middle;
            margin-bottom: 0px !important;
            margin-left: 20px;
            float: none;
            width: 200px;
        }

        button {
            cursor: pointer !important;
        }

        .topIn, table {
            width: 100%;
            margin: 0 auto;
        }

        .btn {
            margin: 0 5px;
        }

        .M-box3 .active {
            margin: 0px 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            background: #2b7fe0;
            font-size: 12px;
            border: 1px solid #2b7fe0;
            color: #fff;
            text-align: center;
            display: inline-block;
        }

        .M-box3 a {
            margin: 0 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            font-size: 12px;
            display: inline-block;
            text-align: center;
            background: #fff;
            border: 1px solid #ebebeb;
            color: #bdbdbd;
            text-decoration: none;
        }

        .M-box3 a:hover {
            background: #2b7fe0;
        }

        .jump-ipt {
            width: 30px !important;
            border-radius: 0px !important;
            margin-left: 0px !important;
        }

        table {
            width: 95%;
        }

    </style>
</head>
<body>
<div id="container">
    <div class="top" style="text-align: center;">
        <span class="big3"> <fmt:message code="adding.th.xiXUN"/></span>
    </div>
    <div class="conIn">
        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
            <ul class="layui-tab-title">
                <li class="layui-this"><fmt:message code="adding.th.contact1"/></li>
                <li><fmt:message code="notice.th.External"/></li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <form action="/address/selectUser" id="formOut">
                        <ul class="out">
                            <li class="clearfix">
                                <label class="control-label"><fmt:message code="hr.th.department"/>：</label>
                                <input type="text" name="deptName" id="deptId">
                                <a href="javascript:;" style="color: #3079ed;" class="chose1"><fmt:message
                                        code="global.lang.select"/></a>
                                <a href="javascript:;" style="color: #3079ed;" class="empty1"><fmt:message
                                        code="global.lang.empty"/></a>
                            </li>
                            <li class="clearfix">
                                <label class="control-label"><fmt:message code="userManagement.th.role"/>：</label>
                                <input type="text" name="userPrivName" id="userPrivName">
                                <a href="javascript:;" style="color: #3079ed;" class="chose2"><fmt:message
                                        code="global.lang.select"/></a>
                                <a href="javascript:;" style="color: #3079ed;" class="empty2"><fmt:message
                                        code="global.lang.empty"/></a>
                            </li>
                            <li class="clearfix">
                                <label class="control-label"><fmt:message code="userDetails.th.mobilePhone"/>：</label>
                                <input type="text" name="mobilNo">
                            </li>
                            <li class="clearfix">
                                <label class="control-label"><fmt:message code="depatement.th.phone"/>：</label>
                                <input type="text" name="telNoDept">
                            </li>
                            <li class="clearfix">
                                <label class="control-label"><fmt:message code="depatement.th.telephone"/>：</label>
                                <input type="text" name="telNoHome">
                            </li>
                            <li class="clearfix">
                                <label class="control-label"><fmt:message code="address.th.QQ" />：</label>
                                <input type="text">
                            </li>
                            <li class="clearfix">
                                <label class="control-label"><fmt:message code="address.th.EMAIL" />：</label>
                                <input type="text">
                            </li>

                        </ul>
                    </form>
                </div>
                <div class="layui-tab-item">
                    <form action="/address/selectAddress" id="formIn">
                        <ul class="in">
                            <li class="clearfix">
                                <label class="control-label"><fmt:message code="userDetails.th.name"/>：</label>
                                <input type="text" name="psnName">
                            </li>
                            <li class="clearfix">
                                <label class="control-label"><fmt:message code="user.th.Grouping"/>：</label>
                                <select name="groupId" id="group" style="margin-left: 20px;width: 200px;">
                                </select>
                            </li>
                            <li class="clearfix">
                                <label class="control-label"><fmt:message code="userDetails.th.post" />：</label>
                                <input type="text" name="ministration" id="ministra">
                            </li>
                            <li class="clearfix">
                                <label class="control-label"><fmt:message code="userDetails.th.mobilePhone"/>：</label>
                                <input type="text" name="mobilNo">
                            </li>
                            <li class="clearfix">
                                <label class="control-label"><fmt:message code="depatement.th.Company"/>：</label>
                                <input type="text" name="deptName">
                            </li>
                            <li class="clearfix">
                                <label class="control-label"><fmt:message code="depatement.th.phone"/>：</label>
                                <input type="text" name="telNoDept">
                            </li>
                            <li class="clearfix">
                                <label class="control-label"><fmt:message code="depatement.th.telephone"/>：</label>
                                <input type="text" name="telNoHome">
                            </li>
                            <li class="clearfix">
                                <label class="control-label"><fmt:message code="workflow.th.officeAddress"/>：</label>
                                <input type="text" name="addDept">
                            </li>
                            <li class="clearfix">
                                <label class="control-label"><fmt:message code="workflow.th.Address"/>：</label>
                                <input type="text" name="addHome">
                            </li>
                            <li class="clearfix">
                                <label class="control-label"><fmt:message code="journal.th.Remarks"/>：</label>
                                <input type="text" name="notes">
                            </li>
                        </ul>
                    </form>


                </div>

            </div>
        </div>


        <div class="clearfix" style="text-align: center">
            <button class="btn btn-primary" style="margin-right:20px;" id="query"><fmt:message
                    code="global.lang.query"/></button>
            <button class="btn" id="close"><fmt:message code="global.lang.close"/></button>
        </div>
    </div>
</div>
<div class="QueryIn" style="display: none">
    <div class="topIn" style="margin:20px auto;">
        <span class="big3" style="padding-left:20px;"><fmt:message code="global.lang.result"/></span>
        <%--<button class="btn back" style="margin:0px 10px;">返回</button>--%>
        <%--<button class="btn del">删除重复联系人</button>--%>
    </div>
    <div style="margin: -15px auto 0px;height:50px;width: 97%;" class="clearfix">
        <div id="dbgz_page" class="M-box3">

        </div>
    </div>
    <table class="tableIn" style="display: none">
        <thead>
        <tr>
            <%--<th>选择</th>--%>
            <%--                    <th><fmt:message code="global.lang.Groupname" /></th>--%>
            <th><fmt:message code="userDetails.th.name"/></th>
            <th><fmt:message code="userDetails.th.Gender"/></th>
            <th><fmt:message code="userDetails.th.post" /></th>
            <th><fmt:message code="depatement.th.Unitname"/></th>
            <th><fmt:message code="userInfor.th.Workphone"/></th>
            <th><fmt:message code="userInfor.th.Workpho"/></th>
            <th><fmt:message code="main.email"/></th>
            <th><fmt:message code="notice.th.operation"/></th>

        </tr>
        </thead>
        <tbody class="listIn">

        </tbody>
        <%--<tfoot>--%>
        <%--<tr>--%>
        <%--<td colspan="9" style="text-align: left">--%>
        <%--<input type="checkbox" class="checkAll" style="vertical-align: middle;float:none">--%>
        <%--<label style="display: inline-block">全选</label>--%>
        <%--<button class="btn delAll">删除</button>--%>
        <%--&lt;%&ndash;<button class="btn phoneMsg">群发短信</button>&ndash;%&gt;--%>
        <%--&lt;%&ndash;<button class="btn email">群发邮件</button>&ndash;%&gt;--%>
        <%--</td>--%>
        <%--</tr>--%>
        <%--</tfoot>--%>
    </table>
    <%--        <!--编辑联系人-->--%>
    <div id="edit_add" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
         style="top: 50%;margin-top: -226px;left: 50%; margin-left: -500px;width: 1000px;">
        <div class="modal-body" style="max-height: 400px;height: 400px;padding: 0px;overflow: hidden;">
            <iframe width="100%" height="100%" id="iframe_edit" name="iframe_edit" frameborder="0" src="">
            </iframe>
        </div>
        <div class="modal-footer" style="padding-bottom: 10px;padding-top: 10px;text-align:center;">
            <button class="btn btn-primary" onClick="submit_edit()" style="margin-left:220px;"><fmt:message
                    code="global.lang.save"/></button>
            <button class="btn" data-dismiss="modal" aria-hidden="true" id="hide_edit"><fmt:message
                    code="global.lang.close"/></button>
        </div>
    </div>
    <table class="tableOut" style="display: none">
        <thead>
        <tr>
            <%--<th>选择</th>--%>
            <th><fmt:message code="userDetails.th.name"/></th>
            <th><fmt:message code="userDetails.th.Gender"/></th>
            <th><fmt:message code="hr.th.department"/></th>
            <th><fmt:message code="userManagement.th.role"/></th>
            <th><fmt:message code="userInfor.th.Workphone"/></th>
            <th><fmt:message code="hr.th.PhoneNumber" /></th>
            <th><fmt:message code="main.email"/></th>
            <%--<th>操作</th>--%>
        </tr>
        </thead>
        <tbody class="listOut">

        </tbody>
        <%--<tfoot>--%>
        <%--<tr>--%>
        <%--<td colspan="9" style="text-align: left">--%>
        <%--<input type="checkbox" class="checkAll2" style="vertical-align: middle;float:none">--%>
        <%--<label style="display: inline-block">全选</label>--%>
        <%--&lt;%&ndash;<button class="btn phoneMsg">群发微信</button>&ndash;%&gt;--%>
        <%--&lt;%&ndash;<button class="btn email">群发邮件</button>&ndash;%&gt;--%>
        <%--</td>--%>
        <%--</tr>--%>
        <%--</tfoot>--%>
    </table>
    <div class="topIn" style="text-align: center;width:85%;margin:20px auto">
        <button class="btn back" style="margin:0px 10px;"><fmt:message code="notice.th.return"/></button>
    </div>
</div>
<script>
    // $('.autoInsertInput').bind('input propertychange', function(e) {
    //
    // });


    //点击选择角色

    $(".chose1").on("click", function () {//选部门控件
        dept_id = 'deptId';
        $.popWindow("../../common/selectDept");
    });
    $(".chose2").on("click", function () {//选角色控件
        priv_id = 'priv';
        $.popWindow("../../common/selectPriv");
    });
    $('.empty1').on('click',function () {
        $('#deptId').attr('deptname', '')
        $('#deptId').val('');
        $('#deptId').attr('deptid', '')
        $('#deptId').attr('deptno', '')
    })
    $('.empty2').on('click',function () {
        $('#priv').attr('privid', '')
        $('#priv').val('');
        $('#priv').attr('userpriv', '')
    })
    // 点击查询
    $('#query').on('click',function () {

        if ($('.layui-tab-content .layui-show').find('form').attr('id') == 'formIn') {
            $('.QueryIn').show();
            $('.tableIn').show();
            $('.tableOut').hide();
            $('#container').hide();
            $('.back').attr('data-id', 0)
            $('.del').text('<fmt:message code="adding.th.duplicate" />')
            ajaxPageLe.page();
        } else {
            $('.QueryIn').show();
            $('.tableOut').show();
            $('.tableIn').hide();
            $('.del').text('<fmt:message code="notice.th.reportFile" />')
            $('#container').hide();
            $('.back').attr('data-id', 1)
            ajaxPageLe.page2();
        }

    })
    $('.back').on('click',function () {
        $('.QueryIn').hide();
        $('#container').show();
        // if($(this).attr('data-id')==0){
        //      $('.in').show();
        //      $('.out').hide();
        //  }else{
        //      $('.in').hide();
        //      $('.out').show();
        //  }
    })
    //  点击关闭
    $('#close').on('click',function () {
        window.close();
    })
    //  获取分组下拉框内容
    $.ajax({
        url: '/addressGroup/getGroups',
        type: 'get',
        dataType: 'json',
        success: function (res) {
            var data = res.data;
            var str = '<option value=""><fmt:message code="hr.th.PleaseSelect" /></option>';
            for (var i = 0; i < data.length; i++) {
                str += '<option value="' + data[i].groupId + '">' + data[i].groupName + '</option>'
            }
            $('#group').html(str);
        }
    })
    // 内部列表带分页
    var ajaxPageLe = {
        data: {
            page: 1,//当前处于第几页
            pageSize: 10,//一页显示几条
            useFlag: true
            // computationNumber:null
        },
        page: function () {
            var me = this;
            $('#formIn').ajaxSubmit({
                data: me.data,
                dataType: 'json',
                success: function (res) {
                    var str = '';

                    $.each(res.obj, function (index, data) {
                        var sex = ' ';
                        var ministration = '';
                        var deptName = '';
                        var telNoDept = '';
                        var mobilNo = '';
                        var email ='';
                       if (data.sex == 0) {
                            sex = '<fmt:message code="userInfor.th.male" />'
                        }
                        if (data.sex == 1) {
                            sex = '<fmt:message code="userInfor.th.female" />'
                        }
                        if (data.ministration==null){
                            ministration = ''
                        }else {
                            ministration = data.ministration
                        } if (data.deptName==null){
                            deptName = ''
                        }else {
                            deptName = data.deptName
                        } if (data.telNoDept==null){
                            telNoDept = ''
                        }else {
                            telNoDept = data.telNoDept
                        } if (data.mobilNo==null){
                            mobilNo = ''
                        }else {
                            mobilNo = data.mobilNo
                        }
                        if (data.email==null){
                            email = ''
                        }else {
                            email = data.email
                        }

                        str += ' <tr id="' + data.addId + '">' +
                            //                               '                    <td><input type="checkbox" class="checkChild"></td>' +
                            '                    <td>' + data.psnName + '</td>' +
                            '                    <td>' + sex + '</td>' +
                            '                    <td>' + ministration + '</td>' +
                            '                    <td>' + deptName + '</td>' +
                            //                               '                    <td>'+data[i].ministration+'</td>' +
                            '                    <td>' + telNoDept + '</td>' +
                            '                    <td>' + mobilNo + '</td>' +
                            '                    <td>' + email + '</td>' +
                            '                    <td><a href="javascript:;"  class="detail"><fmt:message code="file.th.detail" /></a><a href="javascript:;" data-toggle="modal" role="button"  data-target="#edit_add"  class="edit" style="margin:0px 10px;" onclick="edit(' + data.addId + ')"><fmt:message code="global.lang.edit" /></a><a href="javascript:;" class="del"><fmt:message code="global.lang.delete" /></a></td>' +
                            '                </tr>'
                    })
                    $('.listIn').html(str);
                    me.pageTwo(res.totleNum, me.data.pageSize, me.data.page)
                }
            })
//                me.pageTwo(reg.totleNum,me.data.pageSize,me.data.page)

        },
        pageTwo: function (totalData, pageSize, indexs) {
            var mes = this;
            $('#dbgz_page').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage: '',
                endPage: '',
                current: indexs || 1,
                callback: function (index) {
                    mes.data.page = index.getCurrent();
                    mes.page();
                }
            });
        },
        page2: function () {
            var me = this;
            me.data.deptIds = $('#deptId').attr('deptId')
            $('#formOut').ajaxSubmit({
                data: me.data,
                dataType: 'json',
                success: function (res) {
                    var str = '';
                    $.each(res.obj, function (index, data) {
                        var  telNoDept = '';
                        var mobilNo = '';
                        var email = '';
                        if (data.telNoDept==null){
                            telNoDept = '';
                        }else {
                            telNoDept = data.telNoDept;
                        } if (data.mobilNo==null){
                            mobilNo = '';
                        }else {
                            mobilNo = data.mobilNo;
                        } if (data.email==null){
                            email = '';
                        }else {
                            email = data.email;
                        }

                        str += ' <tr id="' + data.userId + '">' +
                            /* '                    <td><input type="checkbox" class="childCheck"></td>' +*/
                            '                    <td>' + data.userName + '</td>' +
                            '                    <td>' + data.sexName + '</td>' +
                            '                    <td>' + data.deptName + '</td>' +
                            '                    <td>' + data.userPrivName + '</td>' +
                            '                    <td>' + telNoDept + '</td>' +
                            '                    <td>' + mobilNo + '</td>' +
                            '                    <td>' + email + '</td>'
                        '                </tr>'
                    })
                    $('.listOut').html(str);
                    me.pageTwo2(res.totleNum, me.data.pageSize, me.data.page)
                }
            })
//                me.pageTwo(reg.totleNum,me.data.pageSize,me.data.page)

        },
        pageTwo2: function (totalData, pageSize, indexs) {
            var mes = this;
            $('#dbgz_page').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage: '',
                endPage: '',
                current: indexs || 1,
                callback: function (index) {
                    mes.data.page = index.getCurrent();
                    mes.page2();
                }
            });
        }
    }
    //点击详情
    $('.listIn').on('click', '.detail', function () {
        var id = $(this).parents('tr').attr('id');
        $.popWindow('/address/show_add?addId=' + id + '&SHARE_TYPE=0')
    })
    $('.listOut').on('click', '.detail', function () {
        var id = $(this).parents('tr').attr('id');
        $.popWindow('/address/show_add?addId=' + id + '&SHARE_TYPE=0')
    })

    function check(all, child) {
        //        点击全选
        $(all).on('click',function () {
            var state = $(this).prop('checked');
            if (state == true) {
                $(this).prop('checked', true);
                $(child).prop('checked', true);
            } else {
                $(this).prop('checked', false);
                $(child).prop('checked', false);
            }
        })
    }

    check('.checkAll', '.childCheck')
    check('.checkAll2', '.checkChild')

    //        $('.listIn').on('click','.edit',function(){
    //            var id=$(this).parents('tr').attr('id')
    //            window.open("/address/edit?addId="+id,"_blank","width=1000,height=500,resizable='no',scrollbars='no'");
    //        })

    function edit(data) {
        $('#iframe_edit').attr('src', '/address/edit?addId=' + data);
    }

    function submit_edit() {
        document.getElementById('iframe_edit').contentWindow.CheckForm();
    }


    //  点击删除
    $('.listIn').on('click', '.del', function () {
        var id = $(this).parents('tr').attr('id');
        layer.confirm('<fmt:message code="attend.th.qued" />？ ', {
            btn: [' <fmt:message code="global.lang.ok" />', ' <fmt:message code="depatement.th.quxiao" />'], //按钮
            title: "<fmt:message code="menuSSetting.th.deleteMenu" />"
        }, function () {
            $.ajax({
                url: '/address/deleteUser',
                type: 'post',
                dataType: 'json',
                data: {addId: id},
                success: function () {
                    layer.msg(' <fmt:message code="workflow.th.delsucess" />', {icon: 6});
                    ajaxPageLe.page();
                }
            })
        }, function () {
            layer.closeAll();
        })
    })

</script>
</body>
</html>
