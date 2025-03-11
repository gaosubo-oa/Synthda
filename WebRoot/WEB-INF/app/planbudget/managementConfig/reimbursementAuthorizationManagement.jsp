<%--
  Created by IntelliJ IDEA.
  User: 陈晟
  Date: 2021-03-25
  Time: 14:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>报销人授权管理</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css?2019101815.40">
    <link rel="stylesheet" href="/lib/layui/layui/css/treeTable.css?2019101815.17">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/modules/layer/default/layer.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">

<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <style>
        html,body {
            width: 100%;
            height: 100%;
        }

        .layui-disabled, .layui-disabled:hover {
            color: #797979 !important;
        }

        .ztree * {
            font-size: 11pt !important;
        }

        #questionTree li {
            border-bottom: 1px solid #ddd;
            line-height: 40px;
            padding-left: 10px;
            cursor: pointer;
            border-radius: 3px;
        }

        .select {
            background: #c7e1ff;
        }

        .layui-table-tool {
            min-height: 38px;
            padding: 2px 15px;
        }

        #leftHeight .layui-btn + .layui-btn {
            margin-left: 8px;
        }

        .query input, select {
            height: 35px;
        }

        .query button {
            float: left;
        }

        .layui-table-tool-temp {
            padding-right: 0px;
        }

        .query .layui-form-item {
            margin-bottom: 10px;
        }
    </style>
    <link rel="stylesheet" href="/lib/zTree_v3/css/zTreeStyle/zTreeStyle.css"/>
    <script type="text/javascript" src="/lib/zTree_v3/js/jquery.ztree.all.min.js"></script>


    <script type="text/javascript">
        var authorityObject = true
    </script>

</head>
<body>
<form class="layui-form" action="" style="padding-top: 15px;box-sizing: border-box">
    <div class="query" style="display: flex">
        <div class="layui-form-item" style="margin-left: 7px">
            <label class="layui-form-label">员工查询:</label>
            <div class="layui-input-block">
                <input type="text" name="title employeeQuery" required id="employeeQuery"
                       lay-verify="required" autocomplete="off" readonly class="layui-input taskName" style="cursor: pointer">
            </div>
        </div>
        <div class="authority_search" style="position: absolute;left:300px; width: 200px;">
            <button type="button" id="query" class="layui-btn layui-btn-sm search"
                    style="margin-left: 2%; width: 55px;">查询
            </button>
            <button type="button" id="clear" class="layui-btn layui-btn-sm clear"
                    style="margin-left: 20px;width: 55px;">重置
            </button>
            <button type="button" class="layui-btn layui-btn-sm" style="margin-left: 20px"><i
                    class="layui-icon layui-icon-spread-left icon"></i></button>
        </div>
    </div>
</form>

<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" style="margin: 0;" id="addTable">新增</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<table id="demo" lay-filter="test" style="margin-left: 100px;margin-right: 100px"></table>

<script>
    var dictionaryObj = {

    }
    var dictionaryStr = '';


    $.get('/plbDictonary/selectDictionaryByDictNos', {plbDictNos: dictionaryStr}, function (res) {
        if (res.flag) {
            for (var dict in dictionaryObj) {
                dictionaryObj[dict] = {object: {}, str: ''}
                if (res.object[dict]) {
                    res.object[dict].forEach(function (item) {
                        dictionaryObj[dict]['object'][item.plbDictNo] = item.dictName;
                        dictionaryObj[dict]['str'] += '<option value=' + item.plbDictNo + '>' + item.dictName + '</option>';
                    });
                }
            }
        }

    });


    layui.use(['eleTree', 'table', 'layer', 'form', 'element', 'laydate', 'upload',], function () {
        var table = layui.table,
            form = layui.form,
            layer = layui.layer,
            laydate = layui.laydate,
            upload = layui.upload,
            eleTree = layui.eleTree,
            element = layui.element;


        var tableIns=table.render({
            elem: '#demo'
            ,height: 'full-80'
            ,url: '/PlbUserAuthorized/getAllList' //数据接口
            ,toolbar:'#toolbar'
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'userName', title: '被授权员工',  sort: true, fixed: 'left'}
                ,{field: 'beginTime', title: '开始时间', sort: true}
                ,{field: 'endTime', title: '结束时间',  sort: true}
                ,{field: 'remarks', title: '备注', }
                ,{title: '操作',align: 'center', toolbar:'#barDemo'}
            ]]
            ,parseData: function (res) {
                return {
                    "code": 0, //解析接口状态
                    "data": res.data,//解析数据列表
                    "count": res.totleNum, //解析数据长度
                };
            },
            request: {
                pageName: 'page' //页码的参数名称，默认：page
                , limitName: 'pageSize' //每页数据量的参数名，默认：limit
            }
        });

        $('#employeeQuery').on('click', function () {
            user_id = 'employeeQuery';
            $.popWindow('/common/selectUser?0');
        });
        //点击查询
        $('#query').on('click',function () {
            var searchParams = {}

            searchParams["authorizedUser"] = $('#employeeQuery').attr('dataid').replace(/,$/gi, '')

            tableIns.reload({
                where: searchParams,
                page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });

        //点击重置
        $('#clear').on('click',function(){
            $('#employeeQuery').val('')
            $('#employeeQuery').removeAttr("username dataid user_id userprivname")
        })

        $(document).on('click','#addTable',function(){
            var authorized
            layer.open({
                type: 1,
                title: '新增',
                btn: ['确定', '取消'],
                shade: 0.5,
                maxmin: true, //开启最大化最小化按钮
                area: ['600px', '400px'],
                content:
                    '<div class="layui-form" id="newRight" >' +

                    '<div class="layui-form-item" style="width: 80%;margin-top: 8%;padding-left:20px">\n' +
                    '    <label class="layui-form-label" style="width: 25%">被授权员工</label>\n' +
                    '    <div class="layui-input-block" style="margin-left: 150px;">\n' +
                    '      <input type="text" name="authorizedUser" id="authorizedUser" readonly autocomplete="off" placeholder="请选择员工"   class="layui-input testNull" title="被授权员工" style="cursor: pointer; background:#e7e7e7">\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '<div class="layui-form-item"style="width: 80%;padding-left:20px">\n' +
                    '    <label class="layui-form-label" style="width: 25%">开始时间:</label>\n' +
                    '    <div class="layui-input-block" style="margin-left: 150px;">\n' +
                    '      <input type="text" name="beginTime" id="beginTime" required  lay-verify="required" placeholder="请选择开始时间"  autocomplete="off" class="layui-input testNull" title="开始时间">\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '<div class="layui-form-item" style="width: 80%;padding-left:20px">\n' +
                    '    <label class="layui-form-label" style="width: 25%">结束时间:</label>\n' +
                    '    <div class="layui-input-block" style="margin-left: 150px;">\n' +
                    '      <input type="text" name="endTime"  id="endTime"  required  lay-verify="required" placeholder="请选择结束时间" autocomplete="off" class="layui-input testNull" title="结束时间">\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '<div class="layui-form-item" style="width: 80%;padding-left:20px">\n' +
                    '    <label class="layui-form-label" style="width: 25%">备注:</label>\n' +
                    '    <div class="layui-input-block" style="margin-left: 150px;">\n' +
                    '      <input type="text" name="remarks" required  lay-verify="required" placeholder="请输入备注" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '</div>',

                success:function(){
                    $('#authorizedUser').on('click', function () {
                        user_id = 'authorizedUser';
                        $.popWindow('/common/selectUser?0');
                    });
                    laydate.render({
                        elem: '#beginTime' ,
                        trigger:'click'//指定元素
                    });
                    laydate.render({
                        elem: '#endTime',
                        trigger:'click'
                    });
                }

                ,
                yes: function (index) {
                    //判断被授权人不能为空
                    for (var i = 0; i < $('.testNull').length; i++) {
                        if ($('.testNull').eq(i).val() == '') {
                            layer.msg($('.testNull').eq(i).attr('title') + '为必填项！', {icon: 0});
                            return false
                        }
                    }

                    authorized = $('input[name="authorizedUser"]').attr('user_id');
                    var authorizedUser = authorized.replace(/,$/, '');
                    var beginTime = $('input[name="beginTime"]').val()+ ' 00:00:00';
                    var endTime = $('input[name="endTime"]').val()+ ' 00:00:00';
                    var remarks = $('input[name="remarks"]').val();

                    //判断开始时间在结束时间之后
                    if(beginTime>endTime){
                        layer.msg('开始时间需在结束时间之前',{icon: 0});
                        return false
                    }
                    var data = {
                        authorizedUser: authorizedUser,
                        beginTime: beginTime,
                        endTime: endTime,
                        remarks: remarks,
                    }
                    $.ajax({
                        url: '/PlbUserAuthorized/insert',
                        data: data,
                        dataType: 'json',
                        type: 'POST',
                        success: function (res) {
                            if (res.flag) {
                                layer.msg('新增成功', {icon: 1});
                                layer.close(index);
                                tableIns.reload()
                            }else {
                                layer.msg('新增失败', {icon: 2});
                                layer.close(index);
                            }
                        }
                    })
                }
            })
        });
        // 监听操作工具条
        table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
            if (layEvent === 'del') { //删除
                layer.confirm('确定要删除吗?', function (index) {
                    $.ajax({
                        type: 'post',
                        url: '/PlbUserAuthorized/delete',
                        dataType: 'json',
                        data: {PlbUserAuthorizedIds: data.authorizedId},
                        success: function (res) {
                            $('#query').trigger('click');
                            if (res.msg) {
                                layer.msg('删除成功！', {icon: 1});
                                tableIns.reload()
                            }

                        }
                    })
                    layer.close(index);
                });
            } else if (layEvent == 'edit') {
                //编辑
                var authorized
                var userId
                layer.open({
                    type: 1,
                    title: '编辑',
                    btn: ['确定', '取消'],
                    shade: 0.5,
                    maxmin: true, //开启最大化最小化按钮
                    area: ['600px', '400px'],
                    content:
                        '<div class="layui-form" id="newRight" >' +

                        '<div class="layui-form-item" style="width: 80%;margin-top: 8%;padding-left:20px">\n' +
                        '    <label class="layui-form-label" style="width: 25%">被授权员工</label>\n' +
                        '    <div class="layui-input-block" style="margin-left: 150px;">\n' +
                        '      <input type="text" name="authorizedUser" id="authorizedUser" readonly autocomplete="off"  class="layui-input testNull" title="被授权员工" style="cursor: pointer; background:#e7e7e7">\n' +
                        '    </div>\n' +
                        '  </div>' +
                        '<div class="layui-form-item"style="width: 80%;padding-left:20px">\n' +
                        '    <label class="layui-form-label" style="width: 25%">开始时间:</label>\n' +
                        '    <div class="layui-input-block" style="margin-left: 150px;">\n' +
                        '      <input type="text" name="beginTime" id="beginTime"  class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>' +
                        '<div class="layui-form-item" style="width: 80%;padding-left:20px">\n' +
                        '    <label class="layui-form-label" style="width: 25%">结束时间:</label>\n' +
                        '    <div class="layui-input-block" style="margin-left: 150px;">\n' +
                        '      <input type="text" name="endTime" id="endTime"   class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>' +
                        '<div class="layui-form-item" style="width: 80%;padding-left:20px">\n' +
                        '    <label class="layui-form-label" style="width: 25%">备注:</label>\n' +
                        '    <div class="layui-input-block" style="margin-left: 150px;">\n' +
                        '      <input type="text" name="remarks" id="remarks"  class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>' +
                        '</div>',
                    // 编辑界面数据回显
                    success:function(){
                        console.log(data)
                        userId = data.authorizedUser
                        $('#authorizedUser').val(data.userName)
                        $('#beginTime').val(data.beginTime)
                        $('#endTime').val(data.endTime)
                        $('#remarks').val(data.remarks)
                        $('#authorizedUser').attr('username',data.userName)
                        $('#authorizedUser').attr('dataid',data.authorizedUser)
                        $('#authorizedUser').attr('user_id',data.authorizedUser)
                        laydate.render({
                            elem: '#beginTime' ,
                            trigger:'click',
                            format:'yyyy-MM-dd HH:mm:ss'
                        });
                        laydate.render({
                            elem: '#endTime',
                            trigger:'click',
                            format:'yyyy-MM-dd HH:mm:ss'
                        });
                        $('#authorizedUser').on('click', function () {
                            user_id = 'authorizedUser';
                            $.popWindow('/common/selectUser?0');
                        });
                        console.log(userId)
                    }
                    ,
                    yes: function (index) {
                        //判断被授权人不能为空
                        for (var i = 0; i < $('.testNull').length; i++) {
                            if ($('.testNull').eq(i).val() == '') {
                                layer.msg($('.testNull').eq(i).attr('title') + '为必填项！', {icon: 0});
                                return false
                            }
                        }

                        var authorizedId = data.authorizedId;
                        authorized = $('input[name="authorizedUser"]').attr('user_id');
                        if(authorized){
                            var authorizedUser = authorized.replace(/,$/, '');
                        }else {
                            var authorizedUser = data.authorizedUser
                        }

                        var beginTime = $('input[name="beginTime"]').val();
                        var endTime = $('input[name="endTime"]').val();
                        var remarks = $('input[name="remarks"]').val();

                        if(beginTime>endTime){
                            layer.msg('开始时间需在结束时间之前',{icon: 0});
                            return false
                        }


                        // authorized = $('[name="authorizedUser"]', $('#baseForm')).attr('user_id') || '';
                        var datas = {
                            authorizedId:authorizedId,
                            authorizedUser: authorizedUser,
                            beginTime: beginTime,
                            endTime: endTime,
                            remarks: remarks,
                        }
                        console.log(datas)
                        $.ajax({
                            url: '/PlbUserAuthorized/update',
                            data: datas,
                            dataType: 'json',
                            type: 'POST',
                            success: function (res) {
                                if (res.flag) {
                                    layer.msg('编辑成功', {icon: 1});
                                    layer.close(index);
                                    tableIns.reload()
                                }else {
                                    layer.msg('编辑失败', {icon: 2});
                                    layer.close(index);
                                }
                            }
                        })
                    }
                })

            }
        });

    })


</script>

</body>
</html>