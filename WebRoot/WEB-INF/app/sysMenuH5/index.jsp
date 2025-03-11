<%--
  Created by IntelliJ IDEA.
  User: liran
  Date: 2018/5/18
  Time: 11:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"
         language="java" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>H5门户菜单管理</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/base.css">

    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <%--<link rel="stylesheet" href="/css/officialDocument/rentingList.css">--%>
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">

    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" type="text/css" href="/lib/laydate.css"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" charset="utf-8" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" charset="utf-8" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" charset="utf-8" src="/lib/pagination/js/jquery.pagination.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="/js/jquery/jquery.form.min.js"></script>
    <script type="text/javascript" src="/lib/laydate/laydate.js"></script>
    <%--<script type="text/javascript" charset="utf-8" src="/lib/timing/laydate/laydate.js"></script>--%>
    <script type="text/javascript" charset="utf-8" src="/js/base/base.js"></script>
    <%--<script src="/js/pzGrid/gridShjzry.js"></script>--%>

    <%--<script src="/js/pzGrid/runPsychosis.js"></script>--%>
    <style>
        .formUl li input[type=radio] {
            width: 16px;
        }

        .formUl li .radiolabel {
            width: 50px;
        }

        .divAdd {
            background-color: rgba(0, 0, 0, 0);
        }

        .clearfix input {
            float: none;
        }

        .importTable {
            width: 90%;
            margin: 20px auto;
        }

        .formUl li input {
            /*width: 100px;*/
            float: none;
        }

        .formUl li span {
            margin: 20px;
            line-height: 33px;
        }

        td {
            font-size: 11pt;
        }

        .headTop {
            border-bottom: none;
            margin: 10px;
            position: relative;
        }

        #demo .layui-table-cell{
            text-align: center;
        }
        .M-box3 a{
            margin: 0 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            font-size: 12px;
            text-decoration: none;
        }
        .newTask{
            position: absolute;
            right: 2%;
            top: 7px;
        }
        .deletes{
            color: red;
        }
    </style>

    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>

</head>
<body>
<div class="headTop">
    <div class="divTitle">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_menuSettings.png" alt="">
        H5门户菜单管理
    </div>
    <%--    <p class="newTask">新建任务</p>--%>
    <button type="button" class="layui-btn newTask">新建菜单</button>
</div>

<div  class="clearfix">

</div>

<div class="pagediv" style="margin: 0 auto;width: 97%;">


    <table>
        <thead>
        <tr>
            <th>排序号</th>
            <th>菜单名称</th>
            <th>菜单英文名称</th>
            <th>菜单繁中名称</th>
            <th>菜单地址</th>
            <th>备注</th>
            <th>菜单状态</th>
            <th>菜单类型</th>
            <th><fmt:message code="notice.th.operation"/></th>
        </tr>
        </thead>
        <tbody>

        </tbody>
    </table>
    <div id="dbgz_page" class="M-box3 fr">

    </div>

</div>
</body>
<script type="text/javascript">
    var ajaxPage = {
        data: {
            page: 1,//当前处于第几页
            pageSize: 15,//一页显示几条
            useFlag: true
        },

        page: function () {
            var me = this;
            $.post('/sysMenuH5/selectMenus', me.data, function (json) {
                var arr = json.data;
                if (arr.length > 0) {
                    var str = '';
                    for (var i = 0; i < arr.length; i++) {
                        var status = '', systemType = '系统应用', operation = '', deletes = '';

                        if (arr[i].openStatus == 1) {
                            operation = '<a class="switch" type="0" href="#">关闭</a>'
                            status = "<span style='color: green'>已开启</span>";
                        } else {
                            status = "<span style='color: red'>已停用</span>";
                            operation = '<a class="switch" type="1"  href="#">开启</a>'
                        }

                        if(arr[i].isSystem == 2){
                            deletes =  '<a class="deletes" type="0" href="#">删除</a>'
                            systemType = '自定义用户'
                        }


                        str += '<tr menuId="' + arr[i].menuId + '"  >' +
                            '<td>' + arr[i].sortNo + '</td>' +
                            '<td>' + arr[i].menuName + '</td>' +
                            '<td>' + arr[i].menuName1 + '</td>' +
                            '<td>' + arr[i].menuName2 + '</td>' +

                            '<td>' + arr[i].menuH5Url + '</td>' +
                            '<td>' + arr[i].remark + '</td>' +
                            '<td>' + status + '</td>' +
                            '<td>' + systemType + '</td>' +
                            '<td>' +
                            '<a class="edit" href="#" "><fmt:message code="global.lang.edit" /> </a>&nbsp;&nbsp;'  + operation + '&nbsp;&nbsp;'+ deletes+'' +
                            '</td>' +
                            '</tr>'

                    }
                    $('.pagediv table tbody').html(str)
                    me.pageTwo(json.totleNum, me.data.pageSize, me.data.page)
                }

            }, 'json')
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
        }
    }

    var chuzuwuId = null;
    $(function () {
        var menusOption = '';
        var menusGroups = '';
        // 获取菜单

        $.ajax({
            type: 'get',
            url: '/showNewMenu',
            dataType: 'json',
            success: function (rsp) {
                var data = rsp.datas;
                var str = '';
                menusOption += queryMenuT(data, str)

            }
        })


        function queryMenuT(data, str) {
            for (var i = 0; i < data.length; i++) {
                if (data[i].id.length==2){
                    str += '<option value="' + data[i].fId + '">' + data[i].name + '</option>';
                }else{
                    str += '<option value="' + data[i].fId + '">' +"&nbsp;&nbsp;├"+data[i].name + '</option>';
                }

                if (data[i].child) {
                    if (data[i].child.length > 0) {
                        str = queryMenuT(data[i].child, str);
                    }
                }

            }
            return str;
        }

        $('.executionDate').css('visibility','hidden')
        ajaxPage.page();

        setInterval(function () {
            ajaxPage.page();
        }, 120000);

        //查询
        $('.query1').click(function () {
            if ($('#gridId').attr('wanggeid') != '') {
                var gridId = $('#gridId').attr('wanggeid').replace(/,/g, "");
                ajaxPage.data.pGrid = gridId;
            } else {
                ajaxPage.data.pGrid = null;
            }
            ajaxPage.data.pName = $("#pName").val()
            ajaxPage.data.page = 1;
            ajaxPage.page()

        })


        $('#emptyGrid').click(function () {
            $('#gridId').val('');
            $('#gridId').attr('wanggeid', '');
        })

        //刷新
        $('#refresh').click(function () {
            location.reload();
        })


        //新建任务
        $(document).on('click', '.newTask', function () {

            layer.open({
                title: '新建H5门户菜单',
                area: ['550px', '550px'],
                type: 1,
                content: '<ul class="formUl">' +
                    '<input type="hidden" id="rentId">' +
                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label>排序号：</label>' +
                    '<input id="sortNo" /> <span style="color: red">*</span>' +
                    '</li>' +
                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label>菜单名称：</label>' +
                    '<input id="menuName"/><span style="color: red">*</span>' +
                    '</li>' +

                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label>菜单英文名称：</label>' +
                    '<input id="menuName1" />' +
                    '</li>' +

                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label>菜单繁中名称：</label>' +
                    '<input id="menuName2" />' +
                    '</li>' +

                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label>菜单地址：</label>' +
                    '<input id="menuH5Url" /><span style="color: red">*</span>' +
                    '</li>' +

                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label>菜单图标地址：</label>' +
                    '<input id="menuIcon" /><span style="color: red">*</span>' +
                    '</li>' +

                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label>菜单分组类型：</label>' +
                    '<select name="menuGroup" id="menuGroup">' +
                    '</select>' +

                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label>关联菜单：</label>' +
                    '<select name="editParentId" id="menuTrees">' +
                    '<option value="">请选择关联PC端菜单(不关联可不选)</option>'+
                     menusOption+
                    '</select>' +
                    '</li>' +

                    '<li class="clearfix">' +
                    '<label>备注：</label>' +
                    '<textarea name="remark" id="remark" style="resize:auto"></textarea>' +
                    '</li>' +
                    '</ul>',
                btn: ['确定', '返回'],
                success: function () {
                    //获取菜单分组类型
                    $.ajax({
                        type: 'get',
                        url: '/code/getCode?parentNo=PORTAL_GROUP_TYPE',
                        dataType: 'json',
                        success: function (rsp) {
                            var data = rsp.obj;
                            var str = '<option value="">请选择菜单分组类型</option>';
                            for(var i=0;i<data.length;i++){
                                str += '<option value="' + data[i].codeNo + '">' + data[i].codeName + '</option>';
                            }
                         $('#menuGroup').append(str);
                        }
                    })

                },
                yes:function(index){


                    if(checkNull($('#sortNo').val())){
                        layer.msg('排序号不允许为空')
                        return ;
                    }

                    if(checkNull($('#menuName').val())){
                        layer.msg('菜单名称不允许为空')
                        return ;
                    }

                    if(checkNull($('#menuH5Url').val())){
                        layer.msg('菜单地址不允许为空')
                        return ;
                    }

                    if(checkNull($('#menuIcon').val())){
                        layer.msg('菜单图标地址不允许为空')
                        return ;
                    }
                    if(checkNull($('#menuGroup').val())){
                        layer.msg('菜单分组类型不允许为空')
                        return ;
                    }


                    $.ajax({
                        url: '/sysMenuH5/addMenu',
                        data:{
                            sortNo:  $('#sortNo').val() ,
                            menuName:  $('#menuName').val(),
                            menuName1:  $('#menuName1').val(),
                            menuName2:  $('#menuName2').val(),
                            menuH5Url:  $('#menuH5Url').val(),
                            remark: $('#remark').val(),
                            menuPcId:$('#menuPcId').val(),
                            menuIcon:$('#menuIcon').val(),
                            portalGroupType:$('#menuGroup').val(),

                        },
                        type: 'post',
                        dataType: 'json',
                        success: function (res) {
                            if (res.flag) {
                                $.layerMsg({content: '新建成功！', icon: 1})

                                ajaxPage.page();
                                layer.closeAll()
                            } else {
                                $.layerMsg({content: '新建失败！', icon: 1})
                            }
                        }
                    })
                }
            })
        })

        //我的编辑
        $(document).on('click', '.edit', function () {

            var me = this;
            var menuId = $(me).parents('tr').attr('menuId');
            layer.open({
                title: '<fmt:message code="user.th.jkn" />',
                area: ['550px', '550px'],
                type: 1,
                content: '<ul class="formUl">' +
                    '<input type="hidden" id="menuId">' +
                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label>排序号：</label>' +
                    '<input id="sortNo" /> <span style="color: red">*</span>' +
                    '</li>' +
                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label>菜单名称：</label>' +
                    '<input id="menuName"/><span style="color: red">*</span>' +
                    '</li>' +

                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label>菜单英文名称：</label>' +
                    '<input id="menuName1" />' +
                    '</li>' +

                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label>菜单繁中名称：</label>' +
                    '<input id="menuName2" />' +
                    '</li>' +

                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label>菜单地址：</label>' +
                    '<input id="menuH5Url" /><span style="color: red">*</span>' +
                    '</li>' +

                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label>菜单图标地址：</label>' +
                    '<input id="menuIcon" /><span style="color: red">*</span>' +
                    '</li>' +

                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label>菜单分组类型：</label>' +
                    '<select name="menuGroups" id="menuGroups">' +
                    '</select>' +

                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label>关联菜单：</label>' +
                    '<select id="menuPcId">' +
                    '<option value="">请选择关联PC端菜单(不关联可不选)</option>'+
                    menusOption+
                    '</select>' +
                    '</li>' +

                    '<li class="clearfix">' +
                    '<label>备注：</label>' +
                    '<textarea name="remark" id="remark" style="resize:auto"></textarea>' +
                    '</li>' +
                    '</ul>',
                btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="notice.th.return" />'],
                btn1: function (index) {


                    if(checkNull($('#sortNo').val())){
                        layer.msg('排序号不允许为空')
                        return ;
                    }

                    if(checkNull($('#menuName').val())){
                        layer.msg('菜单名称不允许为空')
                        return ;
                    }

                    if(checkNull($('#menuH5Url').val())){
                        layer.msg('菜单地址不允许为空')
                        return ;
                    }

                    if(checkNull($('#menuIcon').val())){
                        layer.msg('菜单图标地址不允许为空')
                        return ;
                    }

                    if(checkNull($('#menuGroups').val())){
                        layer.msg('菜单分组类型不允许为空')
                        return ;
                    }

                    $.ajax({
                        url: "/sysMenuH5/updateMenu",
                        data:{
                            menuId: menuId,
                            sortNo:  $('#sortNo').val() ,
                            menuName:  $('#menuName').val(),
                            menuName1:  $('#menuName1').val(),
                            menuName2:  $('#menuName2').val(),
                            menuH5Url:  $('#menuH5Url').val(),
                            remark: $('#remark').val(),
                            menuPcId:$('#menuPcId').val(),
                            menuIcon:$('#menuIcon').val(),
                            portalGroupType:$('#menuGroups').val(),

                        },
                        type: 'post',
                        dataType: 'json',
                        success: function (res) {
                            if (res.flag) {
                                $.layerMsg({content: '<fmt:message code="netdisk.th.Editsuccess" />！', icon: 1})

                                ajaxPage.page();
                                layer.closeAll()
                            } else {
                                $.layerMsg({content: '<fmt:message code="event.th.EditFailed" />！', icon: 1})
                            }
                        }
                    })

                },
                success: function () {
                    //获取菜单分组类型
                    $.ajax({
                        type: 'get',
                        url: '/code/getCode?parentNo=PORTAL_GROUP_TYPE',
                        dataType: 'json',
                        success: function (rsp) {
                            var data = rsp.obj;
                            var str = '<option value="">请选择菜单分组类型</option>';
                            for(var i=0;i<data.length;i++){
                                str += '<option value="' + data[i].codeNo + '">' + data[i].codeName + '</option>';
                            }
                            $('#menuGroups').append(str);
                        }
                    })

                    $.ajax({
                        url: '/sysMenuH5/selectMenuById',
                        data: {menuId: menuId},
                        type: 'post',
                        dataType: 'json',
                        success: function (res) {
                            var data = res.data;
                            $('#sortNo').val(data.sortNo)
                            $('#menuName').val(data.menuName)
                            $('#menuName1').val(data.menuName1)
                            $('#menuName2').val(data.menuName2)
                            $('#menuH5Url').val(data.menuH5Url)
                            $('#remark').val(data.remark)
                            $('#menuPcId').val(data.menuPcId)
                            $('#menuIcon').val(data.menuIcon)
                            $('#menuGroups').val(data.portalGroupType)
                        }
                    })


                }
            })
        })


        //开启、关闭
        $(document).on('click', '.switch', function () {
            var menuId = $(this).parents('tr').attr('menuId')
            var type = $(this).attr('type')
            var title='确定要'+$(this).text()+'该菜单吗？'
            layer.confirm(title, {
                btn: ['确认','取消'], //按钮
                title:'提示信息'
            }, function(){
                //确定删除，调接口
                $.ajax({
                    type:'get',
                    url:'/sysMenuH5/updateMenu',
                    dataType:'json',
                    data:{
                        'menuId':menuId,
                        'openStatus':type
                    },
                    success:function(res){
                        $.layerMsg({content:res.msg,icon:1})
                        location.reload();
                    }
                })
            }, function(){
                layer.closeAll();
            });
        })

        //删除任务
        $(document).on('click', '.deletes', function () {
            var menuId = $(this).parents('tr').attr('menuId')

            layer.confirm('确定删除该菜单吗？', function (index) {
                $.ajax({
                    type: 'get',
                    url: '/sysMenuH5/deleteMenu',
                    data:{
                        menuIds:menuId
                    },
                    dataType: 'json',
                    success: function (res) {
                        if (res.flag == true) {
                            layer.msg('删除成功', {icon: 6, time: 1000});
                            ajaxPage.page();
                            layer.closeAll();

                        } else {
                            layer.msg('删除失败', {icon: 2, time: 1000});
                        }
                    }
                })
            });

        })


        function checkNull(str){
            if(str==undefined||str==''){
                return true;
            }
            return false;
        }
    })


</script>
</html>
