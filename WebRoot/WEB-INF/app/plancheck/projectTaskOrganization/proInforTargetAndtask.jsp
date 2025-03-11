<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-04-19
  Time: 19:50
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
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>关键任务和子任务</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/jquery/jquery.cookie.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <style>
        .layui-input-block{
            margin-left: 156px;
        }
        .layui-form-label{
            width: 126px;
        }
        .layui-table-view .layui-table td, .layui-table-view .layui-table th{
            padding: 3px 0px;
        }
        .layui-table-tool{
            min-height: 40px;
            padding: 5px 15px;
        }
        .layui-form-item{
            width: 49%;
            margin-bottom: 8px;
        }
        .newAndEdit{
            display: flex;
        }
        .layui-layer-btn{
            text-align: center;
        }
        .openFile input[type=file]{
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 18px;
            z-index: 99;
            opacity: 0;
        }
    </style>
</head>
<body>
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" id="tabThree" >
<ul class="layui-tab-title">
    <li class="layui-this">关键任务</li>
    <li >子任务</li>
</ul>
<div class="layui-tab-content">
    <div class="layui-tab-item layui-show">
        <table id="target" lay-filter="target"></table>
    </div>
    <div class="layui-tab-item ">
        <table id="task" lay-filter="task"></table>
    </div>
</div>
</div>
<%--关键任务--%>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add" style="margin: 0;">添加关键任务</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<%--子任务--%>
<script type="text/html" id="toolbarDemo1">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add" style="margin: 0;">添加子任务</button>
    </div>
</script>
<script type="text/html" id="barDemo1">
    <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script>
    var projectId=getQueryVariable("projectId")
    var table
    var form
    var laydate
    var upload
    var tableIns
    var tableIns1
    var tgTypeArr={}
    // 关键任务类型
    $.ajax({
        url:'/Dictonary/selectDictionaryByNo?dictNo=TG_TYPE',
        dataType:'json',
        type:'post',
        async:false,
        success:function(res){
            var tgType=res.data
            for(var i=0;i<tgType.length;i++){
                tgTypeArr[tgType[i].dictNo]=tgType[i].dictName
            }
        }
    })
    layui.use(['table','form','laydate','upload'], function(){
         table = layui.table;
        form = layui.form;
        laydate = layui.laydate;
        upload = layui.upload;
        //关键任务表格渲染
         tableIns=table.render({
            elem: '#target'
            ,url: '/projectTarget/query?projectId='+projectId //数据接口
            ,page: true //开启分页
             ,toolbar: '#toolbarDemo'
             ,defaultToolbar:['']
             ,cellMinWidth:100
             ,cols: [[ //表头
                 {field: 'tgNo', title: '关键任务编号', }
                 ,{field: 'tgName', title: '关键任务名称',}
                 // ,{field: 'parentTgId', title: '上级关键任务名称', }
                 ,{field: 'tgType', title: '关键任务类型',templet:function (d) {
                         for(var key in tgTypeArr){
                             if(key==d.tgType){
                                 return tgTypeArr[key]
                             }
                         }
                     } }
                 ,{field: 'tgGrade', title: '关键任务等级', }
                 ,{field: 'tgDesc', title: '关键任务说明',}
                 ,{field: 'mainDutyUserName', title: '主要负责人', }
                 ,{field: 'planBeginDate', title: '计划开始时间',width:120,templet:function (d) {
                         return format(d.planBeginDate)
                     }}
                 ,{field: 'planEndDate', title: '计划结束时间',width:120,templet:function (d) {
                         return format(d.planEndDate)
                     } }
                 ,{field: 'realBeginDate', title: '实际开始时间',width:120,templet:function (d) {
                         return format(d.realBeginDate)
                     } }
                 ,{field: 'realEndDate', title: '实际结束时间',width:120,templet:function (d) {
                         return format(d.realEndDate)
                     } }
                 ,{field: 'addDeptName', title: '填写部门', width:120}
                 ,{field: 'oneControlDeptName', title: '一级监督部门',width:120 }
                 ,{field: 'twoControlDeptName', title: '二级监督部门',width:120 }
                 ,{field: 'isBudget', title: '是否预算控制',width:130,templet:function (d) {
                         if(d.isBudget==0){
                             return '否'
                         }else {
                             return '是'
                         }
                     }}
                 // ,{field: '', title: '所属工作包名称', }
                 // ,{field: '', title: '所属项目名称', }
                 ,{field: 'deptName', title: '所属部门/单位',width:150 }
                 ,{field: 'submitResultDesc', title: '提交的成果', }
                 ,{field: 'standardDegree', title: '权重/难度系数',width:150 }
                 ,{field: 'qualityScore', title: '质量得分', }
                 ,{field: 'endScore', title: '单项得分', }
                 ,{fixed: 'right',title: '操作',align:'center', toolbar: '#barDemo',width:170}
             ]]
             ,parseData: function(res){ //res 即为原始返回的数据
                 return {
                     "code": 0, //解析接口状态
                     "data": res.obj ,//解析数据列表
                     "count": res.totleNum, //解析数据长度
                 };
             }
             ,request: {
                    limitName: 'pageSize' //每页数据量的参数名，默认：limit
             }
        });
        //关键任务新建
        table.on('toolbar(target)', function(obj){
            switch(obj.event){
                case 'add':
                    target(0)
                    break;
            };
        });
        //监听关键任务工具条
        table.on('tool(target)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
            if(layEvent === 'detail'){ //查看
                target('2',data)
            } else if(layEvent === 'del'){ //删除
                layer.confirm('确定删除该条数据吗？', function(index){
                    $.ajax({
                        url:'/projectTarget/delete',
                        dataType:'json',
                        type:'get',
                        data:{tgId:data.tgId},
                        success:function(res){
                            if(res.flag){
                                layer.msg('删除成功！',{icon:1});
                                layer.close(index)
                                tableIns.reload()
                            }
                        }
                    })
                });
            } else if(layEvent === 'edit'){ //编辑
                target('1',data)
            }
        });
         //子任务表格渲染
        tableIns1=table.render({
            elem: '#task'
            ,url: '/plcProjectItem/query?projectId='+projectId //数据接口
            ,page: true //开启分页
            ,toolbar: '#toolbarDemo1'
            ,defaultToolbar:['']
            ,cellMinWidth:100
            ,cols: [[ //表头
                // {field: '', title: '所属项目', }
                // ,{field: '', title: '所属工作包',}
                {field: 'taskNo', title: '子任务编码', }
                ,{field: 'taskName', title: '子任务名称', }
                /*,{field: '', title: '父级子任务', }
                ,{field: '', title: '前置子任务',}
                ,{field: '', title: '分解子子任务数量', }*/
                ,{field: 'dutyUserName', title: '责任人', }
                ,{field: 'assistUserName', title: '协作人(多人)',width:150 }
                ,{field: 'mainCenterDeptName', title: '主责中心部门',width:150 }
                ,{field: 'mainCenterDeptUserName', title: '主责中心部门责任人',width:160 }
                ,{field: 'mainAreaDeptName', title: '主责区域部门',width:150}
                ,{field: 'mainAreaDeptUserName', title: '主责区域部门责任人',width:160 }
                ,{field: 'mainProjectDeptName', title: '主责项目部门',width:150 }
                ,{field: 'mainProjectDeptUserName', title: '主责项目部门责任人',width:160 }
                ,{field: 'assistCompanyDeptsName', title: '公司协助部门',width:150 }
                ,{field: 'assistAreaDeptsName', title: '区域协助部门', width:150}
                ,{field: 'planType', title: '计划类型', }
                ,{field: 'planStage', title: '计划阶段', }
                ,{field: 'planRate', title: '计划形式', }
                ,{field: 'planLevel', title: '计划级次', }
                ,{field: 'controlLevel', title: '控制级别', }
                ,{field: 'according', title: '工作项依据', }
                ,{field: 'isKeypoint', title: '是否关键工作项',width:160,templet:function (d) {
                        if(d.isKeypoint=='0'){
                            return '否'
                        }else{
                            return '是'
                        }
                    }}
                ,{field: 'planSycle', title: '计划周期', }
                // ,{field: '', title: '审批流程', }
                ,{field: 'useFlag', title: '是否启用',templet:function (d) {
                        if(d.useFlag=='0'){
                            return '禁用'
                        }else{
                            return '启用'
                        }
                    } }
                ,{field: 'isBudget', title: '是否预算控制',width:150,templet:function (d) {
                        if(d.isBudget=='0'){
                            return '否'
                        }else{
                            return '是'
                        }
                    }}
                ,{field: 'isAssociate', title: '是否关联控制指标',width:150,templet:function (d) {
                        if(d.isAssociate=='0'){
                            return '否'
                        }else{
                            return '是'
                        }
                    } }
                ,{field: 'isForce', title: '是否强制控制', width:150,templet:function (d) {
                        if(d.isForce=='0'){
                            return '否'
                        }else{
                            return '是'
                        }
                    }}
                ,{field: 'planStartDate', title: '计划开始时间',width:150,templet:function (d) {
                        return format(d.planStartDate)
                    } }
                ,{field: 'planEndDate', title: '计划完成时间',width:150,templet:function (d) {
                        return format(d.planEndDate)
                    } }
                ,{field: 'planContinuedDate', title: '计划工期', }
                ,{field: 'realStartDate', title: '实际开始时间',width:150,templet:function (d) {
                        return format(d.realStartDate)
                    }}
                ,{field: 'realEndDate', title: '实际结束时间', width:150,templet:function (d) {
                        return format(d.realEndDate)
                    }}
                ,{field: 'realContinuedDate', title: '实际工期',width:150 }
                ,{field: 'standardDegree', title: '标准难度系数',width:150 }
                ,{field: 'hardDegree', title: '难度系数', }
                ,{field: 'resultConfirm', title: '成果确认', }
                ,{field: 'resultDesc', title: '完成标准', }
                ,{field: 'finalResultDesc', title: '最终交付成果描述',width:150 }
                ,{field: 'unusualRes', title: '异常原因', }
                ,{field: 'unusualStuff', title: '异常支撑材料',width:150 }
                ,{field: 'qualityScore', title: '质量得分', }
                ,{field: 'taskStatus', title: '子任务状态', }
                ,{field: 'taskPrecess', title: '子任务进度', }
                ,{field: 'taskType', title: '子任务类型', }
                ,{field: 'taskDesc', title: '子任务描述', }
                ,{field: 'riskPoint', title: '风险点', }
                ,{field: 'difficultPoint', title: '难度点', }
                ,{field: 'endScore', title: '单项得分', }
                ,{fixed: 'right',title: '操作',align:'center', toolbar: '#barDemo1',width:170}
            ]]
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "data": res.obj ,//解析数据列表
                    "count": res.totleNum, //解析数据长度
                };
            }
        });
        //子任务新建
        table.on('toolbar(task)', function(obj){
            switch(obj.event){
                case 'add':
                    task(0)
                    break;
            };
        });
        //监听子任务工具条
        table.on('tool(task)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
            if(layEvent === 'detail'){ //查看
                task('2',data)
            } else if(layEvent === 'del'){ //删除
                layer.confirm('确定删除该条数据吗？', function(index){
                    $.ajax({
                        url:'/plcProjectItem/delete',
                        dataType:'json',
                        type:'get',
                        data:{planItemId:data.planItemId},
                        success:function(res){
                            if(res.flag){
                                layer.msg('删除成功！',{icon:1});
                                layer.close(index)
                                tableIns1.reload()
                            }
                        }
                    })
                });
            } else if(layEvent === 'edit'){ //编辑
                task('1',data)
            }
        });
    });
    //关键任务新建、编辑、查看共有方法
    function target(type,data) {
        var title
        if(type=='0'){
            title='添加关键任务'
            url='/projectTarget/add'
        }else if(type=='1'){
            title='编辑关键任务'
            url='/projectTarget/updatePlus'
        }else{
            title='查看关键任务'
        }
        layer.open({
            type: 1,
            title: title,
            area: ['100%', '100%'],
            maxmin:true,
            min: function(){
                $('.layui-layer-shade').hide()
            },
            btn:['确定','取消'],
            content: '<form class="layui-form" id="form" lay-filter="formTest">' +
                '<div class="newAndEdit" style="margin-top:15px;"> <div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">关键任务编号</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="tgNo"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">关键任务名称</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="tgName"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div></div>'+
                '<div class="newAndEdit" style="margin-top:15px;"> <div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">是否预算控制</label>\n' +
                '    <div class="layui-input-block">\n' +
                // '      <input type="text" name=""  autocomplete="off" class="layui-input jinyong">\n' +
                '<input type="radio" name="isBudget" value="1" title="是" class="jinyong">\n' +
                '<input type="radio" name="isBudget" value="0" title="否" checked class="jinyong">'+
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">关键任务类型</label>\n' +
                '    <div class="layui-input-block tgType">\n' +
                ' <select name="tgType" lay-verify="required" class="jinyong">\n' +
                '      </select>'+
                '    </div>\n' +
                '  </div></div>'+
                '<div class="newAndEdit">  <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">关键任务等级</label>\n' +
                '    <div class="layui-input-block projectType">\n' +
                '      <input type="text" name="tgGrade"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">关键任务说明</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="tgDesc"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div> </div>'+
                '<div class="newAndEdit">  <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">主要负责人</label>\n' +
                '    <div class="layui-input-block mainDutyUser">\n' +
                     '  <textarea  type="text" name="mainDutyUser" id="mainDutyUser" readonly  style="background:#e7e7e7;height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                   '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="mainDutyUserAdd">添加</a>\n' +
                   ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="mainDutyUserDel">清空</a>\n'+
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">计划开始时间</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" class="layui-input jinyong" name="planBeginDate" id="test1">' +
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">计划结束时间</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" class="layui-input jinyong" name="planEndDate" id="test2">' +
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">实际开始时间</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" class="layui-input jinyong" name="realBeginDate" id="test3">' +
                '    </div>\n' +
                '  </div> </div>'+
                '<div class="newAndEdit">  <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">实际结束时间</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" class="layui-input jinyong" name="realEndDate" id="test4">' +
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">填写部门</label>\n' +
                '    <div class="layui-input-block addDeptId">\n' +
                      '  <textarea  type="text" name="addDeptId" id="addDeptId" readonly  style="background:#e7e7e7;height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                   '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="addDeptIdAdd">添加</a>\n' +
                   ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="addDeptIdDel">清空</a>\n'+
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">一级监督部门</label>\n' +
                '    <div class="layui-input-block oneControlDept">\n' +
                '  <textarea  type="text" name="oneControlDept" id="oneControlDept" readonly  style="background:#e7e7e7;height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="oneControlDeptAdd">添加</a>\n' +
                ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="oneControlDeptDel">清空</a>\n'+
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">二级监督部门</label>\n' +
                '    <div class="layui-input-block twoControlDept">\n' +
                '  <textarea  type="text" name="twoControlDept" id="twoControlDept" readonly  style="background:#e7e7e7;height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="twoControlDeptAdd">添加</a>\n' +
                ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="twoControlDeptDel">清空</a>\n'+
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> <div class="layui-form-item">\n' +
                // '    <label class="layui-form-label">所属项目</label>\n' +
                '    <label class="layui-form-label">提交的成果描述</label>\n' +
                '    <div class="layui-input-block ">\n' +
                '      <input type="text" name="submitResultDesc"  autocomplete="off" class="layui-input">\n' +
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">所属部门/单位</label>\n' +
                '    <div class="layui-input-block deptId">\n' +
                '  <textarea  type="text" name="deptId" id="deptId" readonly  style="background:#e7e7e7;height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="deptIdAdd">添加</a>\n' +
                ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="deptIdDel">清空</a>\n'+
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> <div class="layui-form-item">\n' +
                // '    <label class="layui-form-label">提交的成果描述</label>\n' +
                '    <label class="layui-form-label">质量得分</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="qualityScore"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">难度系数</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="standardDegree"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">单项得分</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="endScore"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div>'+
                /*' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">单项得分</label>\n' +
                '    <div class="layui-input-block projectStatus ">\n' +
                '      <input type="text" name="endScore"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div> ' +*/
                '</div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">附件</label>\n' +
                '    <div class="layui-input-block">\n' +
                ' <div id="fileAll">\n' +
                '</div>\n' +
                '<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                '<img src="../img/mg11.png" alt="">\n' +
                '<span><fmt:message code="email.th.addfile"/></span>\n' +
                '<input type="file" multiple id="fileupload" data-url="/upload?module=plancheck" name="file">\n' +
                '</a>\n' +
                '    </div>\n' +
                '  </div>'+
                '</form>',
            success:function () {
                fileuploadFn('#fileupload',$('#fileAll'));
                form.render()
                //关键任务类型回显
                $.ajax({
                    url:'/Dictonary/selectDictionaryByNo?dictNo=TG_TYPE',
                    dataType:'json',
                    type:'post',
                    async:false,
                    success:function(res){
                        var tgType=res.data
                        var str='<option value="">请选择</option>'
                        for(var i=0;i<tgType.length;i++){
                            str+='<option value="'+tgType[i].dictNo+'">'+tgType[i].dictName+'</option>'
                        }
                        $('[name="tgType"]').html(str)
                        form.render()
                    }
                })
                //编辑回显
                if(type=='1'){
                    //给表单赋值
                    form.val("formTest",data);
                    console.log(data)
                    //主要负责人
                    $('#mainDutyUser').val(data.mainDutyUserName)
                    $('#mainDutyUser').attr('user_id',data.mainDutyUser+',')
                    //填写部门
                    $('#addDeptId').val(data.addDeptName)
                    $('#addDeptId').attr('deptid',data.addDeptId+',')
                    //一级监督部门
                    $('#oneControlDept').val(data.oneControlDeptName)
                    $('#oneControlDept').attr('deptid',data.oneControlDept+',')
                    //二级监督部门
                    $('#twoControlDept').val(data.twoControlDeptName)
                    $('#twoControlDept').attr('deptid',data.twoControlDept+',')
                    //所属部门/单位
                    $('#deptId').val(data.deptName)
                    $('#deptId').attr('deptid',data.deptId+',')
                    //附件回显
                    var strs1 = '';
                    for (var i = 0; i < data.attachmentList.length; i++) {
                        strs1 += '<div class="dech" deUrl="'+encodeURI(data.attachmentList[i].attUrl)+'"><a href="/download?'+encodeURI(data.attachmentList[i].attUrl)+'" NAME="' + data.attachmentList[i].attachName + '*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + data.attachmentList[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data.attachmentList[i].aid + '@' + data.attachmentList[i].ym + '_' + data.attachmentList[i].attachId + ',"></div>';
                    }
                    $('#fileAll').append(strs1);
                }
                if(type=='2'){
                    // console.log(data)
                    $('.tgType').html('<input type="text" name="" value="'+function () {
                        for(var key in tgTypeArr){
                            if(key==data.tgType){
                                return tgTypeArr[key]
                            }
                        }
                    }()+'"  autocomplete="off" class="layui-input jinyong">')
                    $('.mainDutyUser').html('<input type="text" name="" value="'+function () {
                        if(data.mainDutyUserName!=undefined){
                            return data.mainDutyUserName
                        }else{
                            return ''
                        }
                    }()+'"  autocomplete="off" class="layui-input jinyong">')
                    $('.addDeptId').html('<input type="text" name="" value="'+function () {
                        if(data.addDeptName!=undefined){
                            return data.addDeptName
                        }else {
                            return ''
                        }
                    }()+'"  autocomplete="off" class="layui-input jinyong">')
                    $('.oneControlDept').html('<input type="text" name="" value="'+function () {
                        if(data.oneControlDeptName!=undefined){
                            return data.oneControlDeptName
                        }else {
                            return ''
                        }
                    }()+'"  autocomplete="off" class="layui-input jinyong">')
                    $('.twoControlDept').html('<input type="text" name="" value="'+function () {
                        if(data.twoControlDeptName!=undefined){
                            return data.twoControlDeptName
                        }else {
                            return ''
                        }
                    }()+'"  autocomplete="off" class="layui-input jinyong">')
                    $('.deptId').html('<input type="text" name="" value="'+function () {
                        if(data.deptName!=undefined){
                            return data.deptName
                        }else {
                            return ''
                        }
                    }()+'"  autocomplete="off" class="layui-input jinyong">')
                    $('.layui-input').css('border','none')
                    // console.log(data)
                    form.val("formTest",data);
                    $('#attachment').hide()
                    $('.layui-layer-btn').hide()
                    $('.mainDutyUserAdd').hide()
                    $('.mainDutyUserDel').hide()
                    $('.addDeptIdAdd').hide()
                    $('.addDeptIdDel').hide()
                    $('.oneControlDeptAdd').hide()
                    $('.oneControlDeptDel').hide()
                    $('.twoControlDeptAdd').hide()
                    $('.twoControlDeptDel').hide()
                    $('.twoControlDeptAdd').hide()
                    $('.twoControlDeptDel').hide()
                    $('.deptIdAdd').hide()
                    $('.deptIdDel').hide()
                    for(var i=0;i<$('.jinyong').length;i++){
                        $('.jinyong').eq(i).attr('disabled',true)
                        // form.render()
                    }
                    form.render()
                    //附件回显
                    var strs1 = '';
                    for (var i = 0; i < data.attachmentList.length; i++) {
                        strs1 += '<div class="dech" deUrl="'+encodeURI(data.attachmentList[i].attUrl)+'"><a href="/download?'+encodeURI(data.attachmentList[i].attUrl)+'" NAME="' + data.attachmentList[i].attachName + '*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + data.attachmentList[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data.attachmentList[i].aid + '@' + data.attachmentList[i].ym + '_' + data.attachmentList[i].attachId + ',"></div>';
                    }
                    $('#fileAll').append(strs1);
                    $('.deImgs').hide()

                }
                laydate.render({
                    elem: '#test1' //指定元素
                });
                laydate.render({
                    elem: '#test2' //指定元素
                });
                laydate.render({
                    elem: '#test3' //指定元素
                });
                laydate.render({
                    elem: '#test4' //指定元素
                });
                //主要负责人的添加
                $(".mainDutyUserAdd").on("click",function(){
                    user_id = 'mainDutyUser';
                    $.popWindow("/common/selectUser?0");
                });
                //主要负责人的删除
                $('.mainDutyUserDel').on('click',function () {
                    $('#mainDutyUser').attr("dataid","");
                    $('#mainDutyUser').attr("user_id","");
                    $('#mainDutyUser').val("");
                });
                //填写部门的添加
                $(".addDeptIdAdd").on("click",function(){
                    dept_id = 'addDeptId';
                    $.popWindow("/common/selectDept?0");
                });
                //填写部门的删除
                $('.addDeptIdDel').on('click',function () {
                    $('#addDeptId').attr("deptid","");
                    $('#addDeptId').attr("deptno","");
                    $('#addDeptId').val("");
                });
                //一级监督部门的添加
                $(".oneControlDeptAdd").on("click",function(){
                    dept_id = 'oneControlDept';
                    $.popWindow("/common/selectDept?0");
                });
                //一级监督部门的删除
                $('.oneControlDeptDel').on('click',function () {
                    $('#oneControlDept').attr("deptid","");
                    $('#oneControlDept').attr("deptno","");
                    $('#oneControlDept').val("");
                });
                //二级监督部门的添加
                $(".twoControlDeptAdd").on("click",function(){
                    dept_id = 'twoControlDept';
                    $.popWindow("/common/selectDept?0");
                });
                //二级监督部门的删除
                $('.twoControlDeptDel').on('click',function () {
                    $('#twoControlDept').attr("deptid","");
                    $('#twoControlDept').attr("deptno","");
                    $('#twoControlDept').val("");
                });
                //所属部门/单位的添加
                $(".deptIdAdd").on("click",function(){
                    dept_id = 'deptId';
                    $.popWindow("/common/selectDept?0");
                });
                //所属部门/单位的删除
                $('.deptIdDel').on('click',function () {
                    $('#deptId').attr("deptid","");
                    $('#deptId').attr("deptno","");
                    $('#deptId').val("");
                });
            },
            yes:function (index) {
                var datas=$('#form').serializeArray()
                // console.log(data)
                var obj={}
                datas.forEach(function (item,index) {
                    obj[item.name]=item.value
                })
                // console.log(obj)
                //获取主要负责人的id
                if($('#mainDutyUser').attr('user_id')!=undefined){
                    obj.mainDutyUser=$('#mainDutyUser').attr('user_id').substring(0,$('#mainDutyUser').attr('user_id').length-1)
                }
                //获取填写部门的id
                if($('#addDeptId').attr('deptid')!=undefined){
                    obj.addDeptId=$('#addDeptId').attr('deptid').substring(0,$('#addDeptId').attr('deptid').length-1)
                }
                //获取一级监督部门的id
                if($('#oneControlDept').attr('deptid')!=undefined){
                    obj.oneControlDept=$('#oneControlDept').attr('deptid').substring(0,$('#oneControlDept').attr('deptid').length-1)
                }
                //获取二级监督部门的id
                if($('#twoControlDept').attr('deptid')!=undefined){
                    obj.twoControlDept=$('#twoControlDept').attr('deptid').substring(0,$('#twoControlDept').attr('deptid').length-1)
                }
                //获取所属部门/单位的id
                if($('#deptId').attr('deptid')!=undefined){
                    obj.deptId=$('#deptId').attr('deptid').substring(0,$('#deptId').attr('deptid').length-1)
                }
               /* var attachmentId = '';
                var attachmentName = '';
                var $attachments = $('#fujian').find('input[type="hidden"]');
                $attachments.each(function(){
                    attachmentId += $(this).val();
                    attachmentName += $(this).data('attachname') + ',';
                });
                obj.attachmentId=attachmentId
                obj.attachmentName=attachmentName*/
                //保存附件信息
                var filearr=$('#fileAll .dech');
                var aId='';
                var uId='';
                for(var i=0;i<filearr.length;i++){
                    aId+=$(filearr[i]).find('input').val();
                    uId+=$(filearr[i]).find('a').attr('name');
                }
                obj.attachmentId=aId
                obj.attachmentName=uId
                if(type=='1'){
                    obj.tgId=data.tgId
                }
                $.ajax({
                    url:url,
                    data:obj,
                    dataType:'json',
                    type:'post',
                    success:function(res){
                        if(type==0){
                            if(res.flag){
                                layer.msg('新增成功！',{icon:1});
                                layer.close(index)
                                tableIns.reload()
                            }
                        }else if(type==1){
                            if(res.flag){
                                layer.msg('修改成功！',{icon:1});
                                layer.close(index)
                                tableIns.reload()
                            }
                        }

                    }
                })
            }
        })
    }
    //子任务新建、编辑、查看共有方法
    function task(type,data) {
        var title
        if(type=='0'){
            title='添加子任务'
            url='/plcProjectItem/add'
        }else if(type=='1'){
            title='编辑子任务'
            url='/plcProjectItem/update'
        }else{
            title='查看子任务'
        }
        layer.open({
            type: 1,
            title: title,
            area: ['100%', '100%'],
            maxmin:true,
            min: function(){
                $('.layui-layer-shade').hide()
            },
            btn:['确定','取消'],
            content: '<form class="layui-form" id="form" lay-filter="formTest">' +
                '<div class="newAndEdit" style="margin-top:15px;"> <div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">子任务编码</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="taskNo"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">子任务名称</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="taskName"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div></div>'+
                '<div class="newAndEdit" style="margin-top:15px;"> <div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">责任人</label>\n' +
                '    <div class="layui-input-block dutyUser">\n' +
                '  <textarea  type="text" name="dutyUser" id="dutyUser" readonly  style="background:#e7e7e7;height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="dutyUserAdd">添加</a>\n' +
                ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="dutyUserDel">清空</a>\n'+
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">协作人</label>\n' +
                '    <div class="layui-input-block assistUser">\n' +
                '  <textarea  type="text" name="assistUser" id="assistUser" readonly  style="background:#e7e7e7;height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="assistUserAdd">添加</a>\n' +
                ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="assistUserDel">清空</a>\n'+
                '    </div>\n' +
                '  </div></div>'+
                '<div class="newAndEdit">  <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">主责中心部门</label>\n' +
                '    <div class="layui-input-block mainCenterDept">\n' +
                '  <textarea  type="text" name="mainCenterDept" id="mainCenterDept" readonly  style="background:#e7e7e7;height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="mainCenterDeptAdd">添加</a>\n' +
                ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="mainCenterDeptDel">清空</a>\n'+
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">主责中心部门责任人</label>\n' +
                '    <div class="layui-input-block mainCenterDeptUser">\n' +
                '  <textarea  type="text" name="mainCenterDeptUser" id="mainCenterDeptUser" readonly  style="background:#e7e7e7;height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="mainCenterDeptUserAdd">添加</a>\n' +
                ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="mainCenterDeptUserDel">清空</a>\n'+
                '    </div>\n' +
                '  </div> </div>'+
                '<div class="newAndEdit">  <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">主责区域部门</label>\n' +
                '    <div class="layui-input-block mainAreaDept">\n' +
                '  <textarea  type="text" name="mainAreaDept" id="mainAreaDept" readonly  style="background:#e7e7e7;height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="mainAreaDeptAdd">添加</a>\n' +
                ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="mainAreaDeptDel">清空</a>\n'+
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">主责区域部门责任人</label>\n' +
                '    <div class="layui-input-block mainAreaDeptUser">\n' +
                '  <textarea  type="text" name="mainAreaDeptUser" id="mainAreaDeptUser" readonly  style="background:#e7e7e7;height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="mainAreaDeptUserAdd">添加</a>\n' +
                ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="mainAreaDeptUserDel">清空</a>\n'+
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">主责项目部门</label>\n' +
                '    <div class="layui-input-block mainProjectDept">\n' +
                '  <textarea  type="text" name="mainProjectDept" id="mainProjectDept" readonly  style="background:#e7e7e7;height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="mainProjectDeptAdd">添加</a>\n' +
                ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="mainProjectDeptDel">清空</a>\n'+
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">主责项目部门责任人</label>\n' +
                '    <div class="layui-input-block mainProjectDeptUser">\n' +
                '  <textarea  type="text" name="mainProjectDeptUser" id="mainProjectDeptUser" readonly  style="background:#e7e7e7;height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="mainProjectDeptUserAdd">添加</a>\n' +
                ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="mainProjectDeptUserDel">清空</a>\n'+
                '    </div>\n' +
                '  </div> </div>'+
                '<div class="newAndEdit">  <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">公司协助部门</label>\n' +
                '    <div class="layui-input-block assistCompanyDepts">\n' +
                '  <textarea  type="text" name="assistCompanyDepts" id="assistCompanyDepts" readonly  style="background:#e7e7e7;height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="assistCompanyDeptsAdd">添加</a>\n' +
                ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="assistCompanyDeptsDel">清空</a>\n'+
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">区域协助部门</label>\n' +
                '    <div class="layui-input-block assistAreaDepts">\n' +
                '  <textarea  type="text" name="assistAreaDepts" id="assistAreaDepts" readonly  style="background:#e7e7e7;height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="assistAreaDeptsAdd">添加</a>\n' +
                ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="assistAreaDeptsDel">清空</a>\n'+
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">计划类型</label>\n' +
                '    <div class="layui-input-block planType">\n' +
                ' <select name="planType" lay-verify="required" class="jinyong">\n' +
                '      </select>'+
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">计划阶段</label>\n' +
                '    <div class="layui-input-block planStage">\n' +
                ' <select name="planStage" lay-verify="required" class="jinyong">\n' +
                '      </select>'+
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">计划形式</label>\n' +
                '    <div class="layui-input-block planRate">\n' +
                ' <select name="planRate" lay-verify="required" class="jinyong">\n' +
                '      </select>'+
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">计划级次</label>\n' +
                '    <div class="layui-input-block planLevel">\n' +
                ' <select name="planLevel" lay-verify="required" class="jinyong">\n' +
                '      </select>'+
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">控制级别</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="controlLevel"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">工作项依据</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="according"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">是否关键工作项</label>\n' +
                '    <div class="layui-input-block">\n' +
                  '<input type="radio" name="isKeypoint" value="1" title="是" class="jinyong">\n' +
                    '<input type="radio" name="isKeypoint" value="0" title="否" checked class="jinyong">'+
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">计划周期</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="planSycle"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">是否启用</label>\n' +
                '    <div class="layui-input-block">\n' +
                  '<input type="radio" name="useFlag" value="1" title="是" class="jinyong">\n' +
                '<input type="radio" name="useFlag" value="0" title="否" checked class="jinyong">'+
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">是否预算控制</label>\n' +
                '    <div class="layui-input-block">\n' +
                  '<input type="radio" name="isBudget" value="1" title="是" class="jinyong">\n' +
                '<input type="radio" name="isBudget" value="0" title="否" checked class="jinyong">'+
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">是否关联控制指标</label>\n' +
                '    <div class="layui-input-block">\n' +
                  '<input type="radio" name="isAssociate" value="1" title="是" class="jinyong">\n' +
                '<input type="radio" name="isAssociate" value="0" title="否" checked class="jinyong">'+
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">是否强制控制</label>\n' +
                '    <div class="layui-input-block ">\n' +
                  '<input type="radio" name="isForce" value="1" title="是" class="jinyong">\n' +
                '<input type="radio" name="isForce" value="0" title="否" checked class="jinyong">'+
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">计划开始时间</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" class="layui-input jinyong" autocomplete="off" name="planStartDate" id="test1">' +
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">计划完成时间</label>\n' +
                '    <div class="layui-input-block ">\n' +
                '      <input type="text" class="layui-input jinyong" autocomplete="off" name="planEndDate" id="test2">' +
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">计划工期</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="planContinuedDate"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">实际开始时间</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" class="layui-input jinyong" autocomplete="off" name="realStartDate" id="test3">' +
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">实际结束时间</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" class="layui-input jinyong" autocomplete="off" name="realEndDate" id="test4">' +
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">实际工期</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="realContinuedDate"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">标准难度系数</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="standardDegree"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">难度系数</label>\n' +
                '    <div class="layui-input-block ">\n' +
                '      <input type="text" name="hardDegree"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">成果确认</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="resultConfirm"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">完成标准</label>\n' +
                '    <div class="layui-input-block ">\n' +
                '      <input type="text" name="resultDesc"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">最终交付成果描述</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="finalResultDesc"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">异常原因</label>\n' +
                '    <div class="layui-input-block ">\n' +
                '      <input type="text" name="unusualRes"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">异常支撑材料</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="unusualStuff"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">质量得分</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="qualityScore"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">子任务状态</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="taskStatus"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">子任务进度</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="taskPrecess"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">子任务类型</label>\n' +
                '    <div class="layui-input-block taskType">\n' +
                ' <select name="taskType" lay-verify="required" class="jinyong">\n' +
                '      </select>'+
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">子任务描述</label>\n' +
                '    <div class="layui-input-block ">\n' +
                '      <input type="text" name="taskDesc"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">风险点</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="riskPoint"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">难度点</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="difficultPoint"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="newAndEdit"> ' +
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">单项得分</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="endScore"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div> </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">附件</label>\n' +
                '    <div class="layui-input-block">\n' +
                /*'<button type="button" class="layui-btn" id="attachment">\n' +
                '  <i class="layui-icon">&#xe67c;</i>上传附件' +
                '</button>'+
                '<div id="fujian"></div>'+*/
                ' <div id="fileAll">\n' +
                '</div>\n' +
                '<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                '<img src="../img/mg11.png" alt="">\n' +
                '<span><fmt:message code="email.th.addfile"/></span>\n' +
                '<input type="file" multiple id="fileupload" data-url="/upload?module=plancheck" name="file">\n' +
                '</a>\n' +
                '    </div>\n' +
                '  </div>'+
                '</form>',
            success:function () {
                fileuploadFn('#fileupload',$('#fileAll'));
                form.render()
                //计划类型回显
                ajaxSelect('PLAN_TYPE','planType')
                //计划阶段回显
                ajaxSelect('PLAN_PHASE','planStage')
                //计划形式回显
                ajaxSelect('PLAN_RATE','planRate')
                //计划级次回显
                ajaxSelect('PLAN_LEVEL','planLevel')
                //编辑回显
                if(type=='1'){
                    //给表单赋值
                    form.val("formTest",data);
                    console.log(data)
                    //责任人
                    $('#dutyUser').val(data.dutyUserName)
                    $('#dutyUser').attr('user_id',data.mainDutyUser)
                    //协作人
                    $('#assistUser').val(data.assistUserName)
                    $('#assistUser').attr('user_id',data.assistUser)
                    //主责中心部门
                    $('#mainCenterDept').val(data.mainCenterDeptName)
                    $('#mainCenterDept').attr('deptid',data.mainCenterDept)
                    //主责中心部门责任人
                    $('#mainCenterDeptUser').val(data.mainCenterDeptUserName)
                    $('#mainCenterDeptUser').attr('user_id',data.mainCenterDeptUser)
                    //主责区域部门
                    $('#mainAreaDept').val(data.mainAreaDeptName)
                    $('#mainAreaDept').attr('deptid',data.mainAreaDept)
                    //主责区域部门责任人
                    $('#mainAreaDeptUser').val(data.mainAreaDeptUserName)
                    $('#mainAreaDeptUser').attr('user_id',data.mainAreaDeptUser)
                    //主责项目部门
                    $('#mainProjectDept').val(data.mainProjectDeptName)
                    $('#mainProjectDept').attr('deptid',data.mainProjectDept)
                    //主责项目部门责任人
                    $('#mainProjectDeptUser').val(data.mainProjectDeptUserName)
                    $('#mainProjectDeptUser').attr('user_id',data.mainProjectDeptUser)
                    //公司协助部门
                    $('#assistCompanyDepts').val(data.assistCompanyDeptsName)
                    $('#assistCompanyDepts').attr('deptid',data.assistCompanyDepts)
                    //区域协助部门
                    $('#assistAreaDepts').val(data.assistAreaDeptsName)
                    $('#assistAreaDepts').attr('deptid',data.assistAreaDepts)
                    //附件回显
                    var strs1 = '';
                    if(data.attachmentList!=undefined){
                        if(data.attachmentList.length>0){
                            for (var i = 0; i < data.attachmentList.length; i++) {
                                strs1 += '<div class="dech" deUrl="'+encodeURI(data.attachmentList[i].attUrl)+'"><a href="/download?'+encodeURI(data.attachmentList[i].attUrl)+'" NAME="' + data.attachmentList[i].attachName + '*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + data.attachmentList[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data.attachmentList[i].aid + '@' + data.attachmentList[i].ym + '_' + data.attachmentList[i].attachId + ',"></div>';
                            }
                        }
                    }
                    $('#fileAll').append(strs1);
                }
                if(type=='2'){
                    // console.log(data)
                    $('.dutyUser').html('<input type="text" name="" value="'+function () {
                        if(data.dutyUserName!=undefined){
                            return data.dutyUserName
                        }else{
                            return ''
                        }
                    }()+'"  autocomplete="off" class="layui-input jinyong">')
                    $('.assistUser').html('<input type="text" name="" value="'+function () {
                        if(data.assistUserName!=undefined){
                            return data.assistUserName
                        }else {
                            return ''
                        }
                    }()+'"  autocomplete="off" class="layui-input jinyong">')
                    $('.mainCenterDept').html('<input type="text" name="" value="'+function () {
                        if(data.mainCenterDeptName!=undefined){
                            return data.mainCenterDeptName
                        }else {
                            return ''
                        }
                    }()+'"  autocomplete="off" class="layui-input jinyong">')
                    $('.mainCenterDeptUser').html('<input type="text" name="" value="'+function () {
                        if(data.mainCenterDeptUserName!=undefined){
                            return data.mainCenterDeptUserName
                        }else {
                            return ''
                        }
                    }()+'"  autocomplete="off" class="layui-input jinyong">')
                    $('.mainAreaDept').html('<input type="text" name="" value="'+function () {
                        if(data.mainAreaDeptName!=undefined){
                            return data.mainAreaDeptName
                        }else {
                            return ''
                        }
                    }()+'"  autocomplete="off" class="layui-input jinyong">')
                    $('.mainAreaDeptUser').html('<input type="text" name="" value="'+function () {
                        if(data.mainAreaDeptUserName!=undefined){
                            return data.mainAreaDeptUserName
                        }else {
                            return ''
                        }
                    }()+'"  autocomplete="off" class="layui-input jinyong">')
                    $('.mainProjectDept').html('<input type="text" name="" value="'+function () {
                        if(data.mainProjectDeptName!=undefined){
                            return data.mainProjectDeptName
                        }else {
                            return ''
                        }
                    }()+'"  autocomplete="off" class="layui-input jinyong">')
                    $('.mainProjectDeptUser').html('<input type="text" name="" value="'+function () {
                        if(data.mainProjectDeptUserName!=undefined){
                            return data.mainProjectDeptUserName
                        }else {
                            return ''
                        }
                    }()+'"  autocomplete="off" class="layui-input jinyong">')
                    $('.assistCompanyDepts').html('<input type="text" name="" value="'+function () {
                        if(data.assistCompanyDeptsName!=undefined){
                            return data.assistCompanyDeptsName
                        }else {
                            return ''
                        }
                    }()+'"  autocomplete="off" class="layui-input jinyong">')
                    $('.assistAreaDepts').html('<input type="text" name="" value="'+function () {
                        if(data.assistAreaDeptsName!=undefined){
                            return data.assistAreaDeptsName
                        }else {
                            return ''
                        }
                    }()+'"  autocomplete="off" class="layui-input jinyong">')
                    $('.tgType').html('<input type="text" name="" value="'+function () {
                        for(var key in tgTypeArr){
                            if(key==data.tgType){
                                return tgTypeArr[key]
                            }
                        }
                    }()+'"  autocomplete="off" class="layui-input jinyong">')
                    $('.layui-input').css('border','none')
                    // console.log(data)
                    form.val("formTest",data);
                    for(var i=0;i<$('.jinyong').length;i++){
                        $('.jinyong').eq(i).attr('disabled',true)
                        // form.render()
                    }
                    form.render()
                    //附件回显
                    var strs1 = '';
                    if(data.attachmentList!=undefined){
                        for (var i = 0; i < data.attachmentList.length; i++) {
                            strs1 += '<div class="dech" deUrl="'+encodeURI(data.attachmentList[i].attUrl)+'"><a href="/download?'+encodeURI(data.attachmentList[i].attUrl)+'" NAME="' + data.attachmentList[i].attachName + '*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + data.attachmentList[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data.attachmentList[i].aid + '@' + data.attachmentList[i].ym + '_' + data.attachmentList[i].attachId + ',"></div>';
                        }
                        $('#fileAll').append(strs1);
                    }else{
                        strs1='暂无附件'
                        $('#fileAll').append(strs1);
                        $('#fileAll').css('padding-top','8px')
                    }
                    $('.layui-layer-btn').hide()
                    $('.openFile').hide()
                    $('.deImgs').hide()

                }
                laydate.render({
                    elem: '#test1' //指定元素
                });
                laydate.render({
                    elem: '#test2' //指定元素
                });
                laydate.render({
                    elem: '#test3' //指定元素
                });
                laydate.render({
                    elem: '#test4' //指定元素
                });
                //责任人的添加
                $(".dutyUserAdd").on("click",function(){
                    addUser(1,'dutyUser')
                });
                //主要负责人的删除
                $('.dutyUserDel').on('click',function () {
                    clearUser('dutyUser')
                });
                //协作人的添加
                $(".assistUserAdd").on("click",function(){
                    addUser(2,'assistUser')
                });
                //协作人的删除
                $('.assistUserDel').on('click',function () {
                    clearUser('assistUser')
                });
                //主责中心部门的添加
                $(".mainCenterDeptAdd").on("click",function(){
                    addDept(1,'mainCenterDept')
                });
                //主责中心部门的删除
                $('.mainCenterDeptDel').on('click',function () {
                    cleardept('mainCenterDept')
                });
                //主责中心部门责任人的添加
                $(".mainCenterDeptUserAdd").on("click",function(){
                    addUser(1,'mainCenterDeptUser')
                });
                //主责中心部门责任人的删除
                $('.mainCenterDeptUserDel').on('click',function () {
                    clearUser('mainCenterDeptUser')
                });
                //主责区域部门的添加
                $(".mainAreaDeptAdd").on("click",function(){
                    addDept(1,'mainAreaDept')
                });
                //主责区域部门的删除
                $('.mainAreaDeptDel').on('click',function () {
                    cleardept('mainAreaDept')
                });
                //主责区域部门责任人的添加
                $(".mainAreaDeptUserAdd").on("click",function(){
                    addUser(1,'mainAreaDeptUser')
                });
                //主责区域部门责任人的删除
                $('.mainAreaDeptUserDel').on('click',function () {
                    clearUser('mainAreaDeptUser')
                });
                //主责项目部门的添加
                $(".mainProjectDeptAdd").on("click",function(){
                    addDept(1,'mainProjectDept')
                });
                //主责项目部门的删除
                $('.mainProjectDeptDel').on('click',function () {
                    cleardept('mainProjectDept')
                });
                //主责项目部门责任人的添加
                $(".mainProjectDeptUserAdd").on("click",function(){
                    addUser(1,'mainProjectDeptUser')
                });
                //主责项目部门责任人的删除
                $('.mainProjectDeptUserDel').on('click',function () {
                    clearUser('mainProjectDeptUser')
                });
                //公司协助部门的添加
                $(".assistCompanyDeptsAdd").on("click",function(){
                    addDept(2,'assistCompanyDepts')
                });
                //公司协助部门的删除
                $('.assistCompanyDeptsDel').on('click',function () {
                    cleardept('assistCompanyDepts')
                });
                //区域协助部门的添加
                $(".assistAreaDeptsAdd").on("click",function(){
                    addDept(2,'assistAreaDepts')
                });
                //区域协助部门的删除
                $('.assistAreaDeptsDel').on('click',function () {
                    cleardept('assistAreaDepts')
                });

            },
            yes:function (index) {
                var datas=$('#form').serializeArray()
                // console.log(data)
                var obj={}
                datas.forEach(function (item,index) {
                    obj[item.name]=item.value
                })
                // console.log(obj)
                //获取责任人的id
                if($('#dutyUser').attr('user_id')!=undefined){
                    obj.dutyUser=parseInt($('#dutyUser').attr('user_id').substring(0,$('#dutyUser').attr('user_id').length-1))
                }
                //获取协作人的id
                if($('#assistUser').attr('user_id')!=undefined){
                    obj.assistUser=$('#assistUser').attr('user_id')
                }
                //获取主责中心部门的id
                if($('#mainCenterDept').attr('deptid')!=undefined){
                    obj.mainCenterDept=parseInt($('#mainCenterDept').attr('deptid').substring(0,$('#mainCenterDept').attr('deptid').length-1))
                }
                //获取主责中心部门责任人的id
                if($('#mainCenterDeptUser').attr('user_id')!=undefined){
                    obj.mainCenterDeptUser=parseInt($('#mainCenterDeptUser').attr('user_id').substring(0,$('#mainCenterDeptUser').attr('user_id').length-1))
                }
                //获取主责区域部门的id
                if($('#mainAreaDept').attr('deptid')!=undefined){
                    obj.mainAreaDept=parseInt($('#mainAreaDept').attr('deptid').substring(0,$('#mainAreaDept').attr('deptid').length-1))
                }
                //获取主责区域部门责任人的id
                if($('#mainAreaDeptUser').attr('user_id')!=undefined){
                    obj.mainAreaDeptUser=parseInt($('#mainAreaDeptUser').attr('user_id').substring(0,$('#mainAreaDeptUser').attr('user_id').length-1))
                }
                //获取主责项目部门的id
                if($('#mainProjectDept').attr('deptid')!=undefined){
                    obj.mainProjectDept=parseInt($('#mainProjectDept').attr('deptid').substring(0,$('#mainProjectDept').attr('deptid').length-1))
                }
                //获取主责项目部门责任人的id
                if($('#mainProjectDeptUser').attr('user_id')!=undefined){
                    obj.mainProjectDeptUser=parseInt($('#mainProjectDeptUser').attr('user_id').substring(0,$('#mainProjectDeptUser').attr('user_id').length-1))
                }
                //获取公司协助部门的id
                if($('#assistCompanyDepts').attr('deptid')!=undefined){
                    obj.assistCompanyDepts=parseInt($('#assistCompanyDepts').attr('deptid').substring(0,$('#assistCompanyDepts').attr('deptid').length-1))
                }
                //获取区域协助部门的id
                if($('#assistAreaDepts').attr('deptid')!=undefined){
                    obj.assistAreaDepts=parseInt($('#assistAreaDepts').attr('deptid').substring(0,$('#assistAreaDepts').attr('deptid').length-1))
                }
                /*var attachmentId = '';
                var attachmentName = '';
                var $attachments = $('#fujian').find('input[type="hidden"]');
                $attachments.each(function(){
                    attachmentId += $(this).val();
                    attachmentName += $(this).data('attachname') + ',';
                });
                obj.attachmentId=attachmentId
                obj.attachmentName=attachmentName*/
                //保存附件信息
                var filearr=$('#fileAll .dech');
                var aId='';
                var uId='';
                for(var i=0;i<filearr.length;i++){
                    aId+=$(filearr[i]).find('input').val();
                    uId+=$(filearr[i]).find('a').attr('name');
                }
                obj.attachmentId=aId
                obj.attachmentName=uId
                if(type=='1'){
                    obj.planItemId=data.planItemId
                }
                $.ajax({
                    url:url,
                    data:obj,
                    dataType:'json',
                    type:'post',
                    success:function(res){
                        if(type==0){
                            if(res.flag){
                                layer.msg('新增成功！',{icon:1});
                                layer.close(index)
                                tableIns1.reload()
                            }
                        }else if(type==1){
                            if(res.flag){
                                layer.msg('修改成功！',{icon:1});
                                layer.close(index)
                                tableIns1.reload()
                            }
                        }

                    }
                })
            }
        })
    }
    //通过ajax方法回显下拉框
    function ajaxSelect(type,content) {
        $.ajax({
            url:'/Dictonary/selectDictionaryByNo?dictNo='+type+'',
            dataType:'json',
            type:'post',
            async:false,
            success:function(res){
                var tgType=res.data
                var str='<option value="">请选择</option>'
                for(var i=0;i<tgType.length;i++){
                    str+='<option value="'+tgType[i].dictNo+'">'+tgType[i].dictName+'</option>'
                }
                $('[name="'+content+'"]').html(str)
                form.render()
            }
        })
    }
    //选择人员添加方法
    function addUser(type,id){
        user_id = id;
        if(type==1){
            $.popWindow("/common/selectUser?0");
        }else{
            $.popWindow("/common/selectUser");
        }
    }
    //选择人员清空方法
    function clearUser(id){
        $('#'+id+'').attr("dataid","");
        $('#'+id+'').attr("user_id","");
        $('#'+id+'').val("");
    }
    //选择部门添加方法
    function addDept(type,id){
        dept_id = id;
        if(type==1){
            $.popWindow("/common/selectDept?0");
        }else{
            $.popWindow("/common/selectDept");
        }
    }
    //选择部门清空方法
    function cleardept(id){
        $('#'+id+'').attr("deptid","");
        $('#'+id+'').attr("deptno","");
        $('#'+id+'').val("");
    }
    //删除附件
    $(document).on('click', '.deImgs',function(){
        var _this = this;
        var attUrl = $(this).parents('.dech').attr('deUrl');
        layer.confirm('确定删除该条数据吗？', function(index){
            $.ajax({
                type: 'get',
                url: '/delete?'+attUrl,
                dataType: 'json',
                success:function(res){

                    if(res.flag == true){
                        layer.msg('删除成功', { icon:6});
                        $(_this).parent().remove();
                    }else{
                        layer.msg('删除失败', { icon:6});
                    }
                }
            })
        });

    });
    //获取地址栏参数
    function getQueryVariable(variable) {
        var query = window.location.search.substring(1);
        var vars = query.split("&");
        for (var i=0;i<vars.length;i++) {
            var pair = vars[i].split("=");
            if(pair[0] == variable){return pair[1];}
        }
        return(false);
    }
    //将毫秒数转为yyyy-MM-dd格式时间
    function format(t) {
        if(t) return new Date(t).Format("yyyy-MM-dd");
        else return ''
    }
</script>
</body>
</html>
