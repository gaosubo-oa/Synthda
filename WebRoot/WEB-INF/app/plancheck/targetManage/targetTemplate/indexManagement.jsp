<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-11-02
  Time: 14:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html >
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>指标管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style>
        html,body{
            height: 100%;
        }
        .query .layui-form-item{
            margin-bottom: 0px;
        }
        .layui-layer-btn{
            text-align: center;
        }
    </style>
</head>
<body>
<div >
    <form class="layui-form" style="padding-top: 10px">
        <div class="query layui-row" >
            <div class="layui-col-xs2">
                <div class="layui-form-item">
                    <label class="layui-form-label" >指标名称</label>
                    <div class="layui-input-block">
                        <input style="height: 35px" type="text" name="tempName" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-col-xs2">
                <div class="layui-form-item">
                    <label class="layui-form-label" >一级指标类型</label>
                    <div class="layui-input-block" >
                        <select name="tempType"></select>
                    </div>
                </div>
            </div>
            <div class="layui-col-xs2">
                <div class="layui-form-item">
                    <label class="layui-form-label" >二级指标类型</label>
                    <div class="layui-input-block" >
                        <select name="tempTypeParent"></select>
                    </div>
                </div>
            </div>
            <div class="layui-col-xs2">
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 90px" >数据来源部门</label>
                    <div class="layui-input-block"  style="margin-left: 120px">
                        <input type="text" id="query_sourcesDeptId" readonly placeholder="请选择" style="cursor: pointer; background-color: #e7e7e7;" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-col-xs2">
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 90px" >数据复核部门</label>
                    <div class="layui-input-block"  style="margin-left: 120px">
                        <input type="text" id="query_checkDeptId" readonly placeholder="请选择" style="cursor: pointer; background-color: #e7e7e7;" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-col-xs2" style="margin-top: 5px;">
                <button type="reset" class="layui-btn layui-btn-sm reset" style="float: right;" >重置</button>
                <button type="button" class="layui-btn layui-btn-sm" id="query_data" style="float: right;margin-right: 10px">查询</button>
            </div>
        </div>
    </form>
    <div style="padding: 0px 8px;">
        <table id="demo" lay-filter="test"></table>
    </div>
</div>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container" style="float: right">
        <button class="layui-btn layui-btn-sm" lay-event="add">新增</button>
        <button class="layui-btn layui-btn-sm" lay-event="update">编辑</button>
        <button class="layui-btn layui-btn-sm" lay-event="delete">删除</button>
    </div>
</script>

<script>
    var dictionaryObj = {INDICATOR_TYPE_PARENT:{},INDICATOR_TYPE:{}}
    var dictionaryStr = 'INDICATOR_TYPE_PARENT,INDICATOR_TYPE'

    // 获取数据字典数据
    $.ajax({
        url:'/Dictonary/selectDictionaryByDictNos',
        dataType:'json',
        type:'get',
        async:false,
        data:{dictNos: dictionaryStr},
        success:function(res){
            if (res.flag) {
                for (var dict in dictionaryObj) {
                    dictionaryObj[dict] = {object: {}, str: '<option value="">请选择</option>'}
                    if (res.object[dict]) {
                        res.object[dict].forEach(function(item){
                            dictionaryObj[dict]['object'][item.dictNo] = item.dictName
                            dictionaryObj[dict]['str'] += '<option value=' + item.dictNo + '>' + item.dictName + '</option>'
                        })
                    }
                }
            }
        }
    })
    var projectTypeObj={}
    layui.use(['table','form'], function(){
        var table = layui.table,
        form = layui.form;
        var tableIns
        //数据来源部门
        $('#query_sourcesDeptId').click(function () {
            dept_id = 'query_sourcesDeptId';
            $.popWindow('/common/selectDept');
        });
        //数据复核部门
        $('#query_checkDeptId').click(function () {
            dept_id = 'query_checkDeptId';
            $.popWindow('/common/selectDept');
        });
        $('.query [name="tempType"]').html(dictionaryObj['INDICATOR_TYPE_PARENT']['str'] )
        $('.query [name="tempTypeParent"]').html(dictionaryObj['INDICATOR_TYPE']['str'] )
        form.render()
        //上方按钮显示
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'add':
                    creat(0)
                    break;
                case 'update':
                    if(checkStatus.data.length!=1){
                        layer.msg('请选择一项！',{icon:0});
                        return false
                    }
                    creat(1,checkStatus.data[0])
                    break;
                case 'delete':
                    if(!checkStatus.data.length){
                        layer.msg('请至少选择一项！',{icon:0});
                        return false
                    }
                    var tempIds=''
                    checkStatus.data.forEach(function (v,i) {
                        tempIds+=v.tempId+','
                    })
                    layer.confirm('确定删除该条数据吗？', function(index){
                        $.ajax({
                            url:'/targetItem/deleteTempTar',
                            dataType:'json',
                            type:'post',
                            data:{tempIds:tempIds},
                            success:function(res){
                                if(res.flag){
                                    layer.msg('删除成功！',{icon:1});
                                }else{
                                    layer.msg('删除失败！',{icon:0});
                                }
                                layer.close(index)
                                tableIns.config.where._ = new Date().getTime();
                                tableIns.reload()
                            }
                        })
                    });
                    break;
            };
        });
        //监听工具条
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            if(layEvent === 'detail'){ //查看
                // creat('2',data)
                layer.open({
                    type: 1,
                    title: '查看项目',
                    area: ['100%', '100%'],
                    maxmin:true,
                    min: function(){
                        $('.layui-layer-shade').hide()
                    },
                    content:'<div><table class="layui-table">\n' +
                        '  <tbody>\n' +
                        '    <tr><td style="width:10%">项目编号</td><td style="width:40%">'+(data.projectNo || '')+'</td><td style="width: 10%">是否是公司重点</td><td style="width:40%">'+function () {
                            if(data.importantYn=='0'){
                                return '否'
                            }else{
                                return '是'
                            }
                        }()+'</td></tr>\n' +
                        '    <tr><td>项目名称</td><td>'+(data.projectName || '')+'</td><td>项目简称</td><td>'+(data.projectAbbreviation || '')+'</td></tr>\n' +
                        '    <tr><td>项目类型</td><td>'+function () {
                            if(projectTypeObj[data.projectType]){
                                return  projectTypeObj[data.projectType]
                            }else{
                                return ''
                            }
                        }()+'</td><td>项目地点</td><td>'+(data.projectPlace || '')+'</td></tr>\n' +
                        '    <tr><td>中标时间</td><td>'+(data.winningDate || '')+'</td><td>责任部门</td><td>'+(data.respectiveRegionName || '')+'</td></tr>\n' +
                        '    <tr><td>合同额(万元)</td><td>'+(data.contractMoney || '')+'</td><td>计划开始时间</td><td>'+(format(data.statrtTime) || '')+'</td></tr>\n' +
                        '    <tr><td>计划结束时间</td><td>'+(format(data.endTime) || '')+'</td><td>计划工期</td><td>'+(data.contractDuration || '')+'</td></tr>\n' +
                        '    <tr><td>合同开始时间</td><td>'+(format(data.contractStartDate) || '')+'</td><td>合同结束时间</td><td>'+(format(data.contractEndDate) || '')+'</td></tr>\n' +
                        '    <tr><td>合同工期</td><td>'+(data.contractContinuedDate || '')+'</td><td>总承包部负责人</td><td>'+(data.overallLeaderName || '')+'</td></tr>\n' +
                        '    <tr><td>审批人</td><td>'+(data.infoCheckName || '')+'</td><td>初始化分解层级</td><td>'+(data.breakTimes || '')+'</td></tr>\n' +
                        '    <tr><td>项目经理</td><td>'+(data.projectManageName || '')+'</td><td>项目经理电话</td><td>'+(data.projectManagePhone || '')+'</td></tr>\n' +
                        '    <tr><td>业主单位</td><td>'+(data.ownerUnitName || '')+'</td><td>业主单位联系方式</td><td>'+(data.ownerPhone || '')+'</td></tr>\n' +
                        '    <tr><td>监理单位</td><td>'+function () {
                            if(data.manageUnitList){
                                var manageUnitList=data.manageUnitList
                                var manageUnitName=''
                                manageUnitList.forEach(function (item) {
                                    manageUnitName+=item.dictName+','
                                })
                                return manageUnitName
                            }else{
                                return  ''
                            }
                        }()+'</td><td>监理单位联系方式</td><td>'+(data.managePhone || '')+'</td></tr>\n' +
                        '    <tr><td>验收标准</td><td>'+(data.acceptStandard || '')+'</td><td>施工内容</td><td>'+(data.workContent || '')+'</td></tr>\n' +
                        '    <tr><td colspan="4">'+
                        function () {
                            if(data.budget){
                                var budget=JSON.parse(data.budget)
                                var budgetStr='<div style="margin-left: 10%;font-weight: bold;margin-bottom: 5px">合同约定的施工过程中结算与支付比例</div>'
                                budget.forEach(function (element,index) {
                                    var itemArr=element.split(',')
                                    budgetStr+=['<div class="layui-row">' +
                                    '<div class="layui-col-xs2" style="margin-left: 10%;width:20%">\n' +
                                    function () {
                                        if(itemArr[0]=='概算批准后'){
                                            return   (parseInt(index)+1)+'.概率批准后'
                                        }else{
                                            return   (parseInt(index)+1)+'.预算批准后'
                                        }
                                    }()+
                                    '</div>\n' +
                                    '<div class="layui-col-xs3" style="width:30%">' +
                                    (parseInt(index)+1)+'.结算比例至(%)：'+itemArr[1]+
                                    '</div>'+
                                    '<div class="layui-col-xs3" style="width:30%">' +
                                    (parseInt(index)+1)+'.支付结算比例的(%)：'+itemArr[2]+
                                    '</div>'+
                                    '</div>'].join('')
                                })
                                return budgetStr
                            }else{
                                return '暂无合同约定的施工过程中结算与支付比例'
                            }

                        }()+'</td></tr>' +
                        '  </tbody>\n' +
                        '</table></div>'
                })
            }
        });
        //表格渲染
        function projectTable(){
            tableIns=table.render({
                elem: '#demo'
                ,url: '/targetItem/selectAllByCondition'
                ,page: true //开启分页
                ,toolbar: '#toolbarDemo'
                , defaultToolbar: ['filter']
                ,cols: [[ //表头
                    {type:'checkbox'}
                    ,{type: 'numbers', title: '序号', }
                    ,{field: 'tempTypeParent', title: '一级指标类型',width:120,templet:function (d) {
                            return dictionaryObj['INDICATOR_TYPE_PARENT']['object'][d.tempTypeParent] || ''
                        }}
                    ,{field: 'tempType', title: '二级指标类型',width:120,templet:function (d) {
                            return dictionaryObj['INDICATOR_TYPE']['object'][d.tempType] || ''
                        }}
                    ,
                    {field: 'tempName', title: '指标名称',width:120 }
                    ,{field: 'sourcesDeptName', title: '数据来源部门',width:120,}
                    ,{field: 'checkDeptName', title: '数据复核部门',width:150,}
                    ,{field: 'tempDesc', title: '指标说明',}
                    ,{field: 'forceCheck', title: '是否强制勾选',width:150,templet:function (d) {
                            return d.forceCheck==1 ? '是' : '否'
                        }}
                ]]
                ,parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "count": res.data.pageTotal, //解析数据长度
                        "data": res.data.data //解析数据列表
                    };
                },
            });
        }
        projectTable()
        //新增编辑共用方法
        function creat(type,data) {
            var title
            var url=''
            if(type=='0'){
                title='新增'
                url='/targetItem/insertTempTar'
            }else if(type=='1'){
                title='编辑'
                url='/targetItem/updateTempTar'
            }else{
                title='查看'
            }
            layer.open({
                type: 1,
                title: title,
                area: ['80%', '70%'],
                maxmin:true,
                min: function(){
                    $('.layui-layer-shade').hide()
                },
                btn:['确定','取消'],
                content: '<form class="layui-form" id="form" lay-filter="formTest">' +
                    //第一行
                    '<div class="newAndEdit layui-col-xs6" style="margin-top:15px;"> <div class="layui-form-item" >\n' +
                    '    <label class="layui-form-label">一级指标类型</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '        <select name="tempTypeParent"></select>' +
                    '    </div>\n' +
                    '  </div>'+
                    '  </div>'+

                    //第二行
                    '<div class="layui-row">'+
                    '<div class="newAndEdit layui-col-xs6" style="margin-top:15px;"> <div class="layui-form-item" >\n' +
                    '    <label class="layui-form-label">二级指标类型</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '        <select name="tempType"></select>' +
                    '    </div>\n' +
                    '  </div>'+
                    '  </div>'+

                    '<div class="newAndEdit layui-col-xs6" style="margin-top:15px;"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">指标名称</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="tempName" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div></div>'+
                    '</div>'+
                    //第三行
                    '<div class="layui-row">'+
                    ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="padding: 9px 12px;width: 85px">数据来源部门</label>' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="sourcesDeptId" id="sourcesDeptId" autocomplete="off" class="layui-input" style="background:#e7e7e7;display: inline-block;width: 83%" readonly>\n' +
                    '      <span style="margin-left: 2px; color: red; cursor: pointer;" class="deptAdd" chooseNum="1">添加</span>' +
                    '      <span style="margin-left: 5px; color: blue; cursor: pointer;" class="deptDel">清空</span>' +
                    '    </div>\n' +
                    '  </div> </div>'+
                    '</div>'+
                    //第四行
                    '<div class="layui-row">'+
                    '<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="padding: 9px 12px;width: 85px">数据复核部门</label>\n' +
                    '    <div class="layui-input-block">' +
                    '      <input type="text" class="layui-input" autocomplete="off" name="checkDeptId" id="checkDeptId" style="background:#e7e7e7;display: inline-block;width: 83%" readonly>' +
                    '      <span style="margin-left: 2px; color: red; cursor: pointer;" class="deptAdd" chooseNum="1">添加</span>' +
                    '      <span style="margin-left: 5px; color: blue; cursor: pointer;" class="deptDel">清空</span>' +
                    '    </div>\n' +
                    '  </div>'+
                    '  </div>'+
                    ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">指标说明</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="tempDesc"  autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div> </div>'+
                    '</div>'+
                    //第五行
                    '<div class="layui-row">'+
                    '<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="padding: 9px 12px;width: 85px">是否强制勾选</label>\n' +
                    '    <div class="layui-input-block">' +
                    '        <input type="checkbox" name="forceCheck" title="强制勾选" lay-skin="primary" >\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '  </div>'+
                    '</div>'+

                    '</form>',
                success:function () {
                    $('#form [name="tempType"]').html(dictionaryObj['INDICATOR_TYPE']['str'])
                    $('#form [name="tempTypeParent"]').html(dictionaryObj['INDICATOR_TYPE_PARENT']['str'])

                    form.render()
                    if(type=='1'){
                        //给表单赋值
                        form.val("formTest",data);
                        $('#sourcesDeptId').val(data.sourcesDeptName)
                        $('#sourcesDeptId').attr('deptid',data.sourcesDeptId)
                        $('#checkDeptId').val(data.checkDeptName)
                        $('#checkDeptId').attr('deptid',data.checkDeptId)
                        if (data.forceCheck == 1) {
                            $('[name="forceCheck"]').prop('checked', true)
                        } else {
                            $('[name="forceCheck"]').prop('checked', false)
                        }
                        form.render()
                    }
                },
                yes:function (index) {
                    var datas=$('#form').serializeArray()
                    var obj={}
                    datas.forEach(function (item,index) {
                        obj[item.name]=item.value
                    })
                    //获取数据来源部门的id
                    if($('#sourcesDeptId').attr('deptid')){
                        obj.sourcesDeptId=$('#sourcesDeptId').attr('deptid').replace(/,$/, '')
                    }
                    //获取数据复核部门的id
                    if($('#checkDeptId').attr('deptid')){
                        obj.checkDeptId=$('#checkDeptId').attr('deptid').replace(/,$/, '')
                    }
                    var forceCheck
                    if ($('input[name="forceCheck"]').prop('checked')) {
                        forceCheck = 1
                    } else {
                        forceCheck = 0
                    }
                    obj.forceCheck=forceCheck
                    if(type==1){
                        obj.tempId=data.tempId
                    }
                    $.ajax({
                        url:url,
                        data:obj,
                        dataType:'json',
                        type:'post',
                        success:function(res){
                            if(type==0){
                                layer.msg('新增成功！',{icon:1});
                                layer.close(index)
                                tableIns.config.where._ = new Date().getTime();
                                tableIns.reload()
                            }else if(type==1){
                                if(res.flag){
                                    layer.msg('修改成功！',{icon:1});
                                    layer.close(index)
                                    tableIns.config.where._ = new Date().getTime();
                                    tableIns.reload()
                                }
                            }

                        }
                    })
                }
            })
        }
        //查询功能
        $('#query_data').on('click',function () {
            var params={
                tempName:$('.query [name="tempName"]').val(),
                // 名字搞错了！
                tempTypeParent:$('.query [name="tempType"]').val(),
                tempType:$('.query [name="tempTypeParent"]').val(),
                sourcesDeptIds:$('#query_sourcesDeptId').attr('deptid'),
                checkDeptIds:$('#query_checkDeptId').attr('deptid'),
                _:new Date().getTime()
            }
            tableIns.reload({
                where: params
                ,page: {
                    curr: 1 //重新从第 1 页开始
                }
                ,parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "count": res.data.pageTotal, //解析数据长度
                        "data": res.data.data //解析数据列表
                    };
                }
            });
        })
        //重置功能
        $('.reset').click(function () {
            $('#query_sourcesDeptId').val('');
            $('#query_sourcesDeptId').attr('deptid', '');
            $('#query_checkDeptId').val('');
            $('#query_checkDeptId').attr('deptid', '');
            tableIns.reload({
                where: {
                    tempName:$('.query [name="tempName"]').val(),
                    tempType:$('.query [name="tempType"]').val(),
                    tempTypeParent:$('.query [name="tempTypeParent"]').val(),
                    sourcesDeptIds:$('#query_sourcesDeptId').attr('deptid'),
                    checkDeptIds:$('#query_checkDeptId').attr('deptid'),
                    _:new Date().getTime()
                }
                ,page: {
                    curr: 1 //重新从第 1 页开始
                }
                ,parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "count": res.data.pageTotal, //解析数据长度
                        "data": res.data.data //解析数据列表
                    };
                }
            });
        })
    });
    //选部门控件添加
    $(document).on('click','.deptAdd',function () {
        var chooseNum=$(this).attr('chooseNum')==1? '?0' : ''
        dept_id=$(this).siblings('input').attr('id')
        $.popWindow("/common/selectDept"+chooseNum);
    })
    //选部门控件删除
    $(document).on('click','.deptDel',function () {
        var deptId=$(this).siblings('input').attr('id')
        $('#'+deptId).val('')
        $('#'+deptId).attr('deptid','')
    })
</script>
</body>
</html>
