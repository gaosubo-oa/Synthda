<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-07-15
  Time: 16:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <title>子项目审核</title>
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
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>

    <style>

        html, body {
            width: 100%;
            height: 100%;
            background: #fff;
            user-select: none;
        }

        /*伪元素是行内元素 正常浏览器清除浮动方法*/
        .clearfix:after {
            content: "";
            display: block;
            height: 0;
            clear: both;
            visibility: hidden;
        }

        .clearfix {
            *zoom: 1; /*ie6清除浮动的方式 *号只有IE6-IE7执行，其他浏览器不执行*/
        }

        .container {
            position: relative;
            width: 100%;
            height: 100%;
        }

        .con_left {
            float: left;
            width: 230px;
            height: 100%;
            margin-top: 10px;
        }

        .left_List .left_List_item{
            width: 100%;
            line-height: 40px;
            padding-left: 10px;
            border-bottom: 1px solid #ddd;
            border-radius: 3px;
            overflow: hidden;
            box-sizing: border-box;
            word-break: break-all;
            white-space: nowrap;
            text-overflow: ellipsis;
            cursor: pointer;
        }

        .left_List .select{
            background: #c7e1ff;
        }

        .con_right {
            float: left;
            width: calc(100% - 230px);
            height: 100%;
            position: relative;
            overflow-y: auto;
            /*margin-top: 41px;*/
        }

        .project_tree_module {
            float: left;
            width: 255px;
            min-height: 50px;
            padding-right: 15px;
            box-sizing: border-box;
            height: 100%;
            overflow: hidden;
        }
        .project_info {
            float: left;
            width: calc(100% - 255px);
            box-shadow: 0 0px 5px 0 rgba(0,0,0,.1);
            border-radius: 3px;
        }

        .project_name {
            font-size: 18px;
            font-weight: 500;
        }
        .inputs input{
            height: 30px !important;
        }
        form{
            padding: 10px;
            margin-left: -20px;
        }
        .query .layui-form-item{
            margin-bottom: 0px;
        }
        .query .layui-input{
            height: 35px;
        }
        .query .layui-input-block{
            margin-top: 2px;
        }
        .foldIcon{
            /*display: none;*/
            position: absolute;
            left: -8px;
            top: 42%;
            font-size: 30px;
            cursor: pointer;
        }
        .select{
            /*background: #c7e1ff;*/
            background: #eee;
        }
        .con_left ul li{
            padding: 5px;
        }
        .con_left ul{
            overflow-y: auto;
        }
        .layui-btn-container{
            position: relative;
        }
        .layui-layer-btn{
            text-align: center;
        }
        .ew-tree-table{
            margin-left: 10px !important;
        }
        .con_left input{
            height: 35px;
        }
        .query .layui-form-label{
            padding: 9px 0px;
        }
        .query .layui-input-block{
            margin-left: 90px
        }
        .layui-btn-container .layui-btn{
            margin-bottom: 0px;
        }
        .ew-tree-table .ew-tree-table-tool{
            padding: 6px 15px !important;
            min-height: 30px !important;
        }
        .ew-tree-table-tool-right{
            position: absolute;
            right: 12px;
            top: 6px;
        }
        /*固定顶部*/
        /*  .ew-tree-table-tool{
              position: fixed;
              top: 110px;
              width: 80.6%;
              z-index: 99999;
          }*/
    </style>
    
    <script type="text/javascript">
        var funcUrl = location.pathname;
        var authorityObject = null;
        if (funcUrl) {
            $.ajax({
                type: 'GET',
                url: '/plcPriv/findPermissions',
                data: {
                    funcUrl: funcUrl
                },
                dataType: 'json',
                async: false,
                success: function (res) {
                    if (res.flag) {
                        if (res.object && res.object.length > 0) {
                            authorityObject = {}
                            res.object.forEach(function (item) {
                                authorityObject[item] = item;
                            });
                        }
                    }
                },
                error: function () {
                    
                }
            });
        }
    </script>

</head>
<body>
<div class="container" style="padding-top: 15px;box-sizing: border-box">
    <input type="hidden" id="leftId" class="layui-input">
  <%--  <div class="header">
        <div class="headImg" style="padding-top: 10px">
					<span style="font-size:22px;margin-left:10px;color:#494d59;margin-top: 2px"><img
                            style="margin-left:1.5%" src="../img/commonTheme/theme6/icon_summary.png" alt=""><span
                            style="margin-left: 10px">子项目审核</span></span>
        </div>
    </div>
    <hr>--%>
    <div class="query layui-form layui-row">
        <div class="layui-col-xs2">
            <div class="layui-form-item" style="width: 237px">
                <label class="layui-form-label" >子项目名称</label>
                <div class="layui-input-block" >
                    <input type="text" name="pbagName" required  lay-verify="required"  autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-col-xs2" style="width: 16.1%">
            <div class="layui-form-item" >
                <label class="layui-form-label">施工单位</label>
                <div class="layui-input-block">
                    <select name="buildUnit" lay-verify="required">
                        <option value="">请选择</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-col-xs2" style="width: 16.2%">
            <div class="layui-form-item">
                <label class="layui-form-label">设计单位</label>
                <div class="layui-input-block">
                    <select name="designUnit" lay-verify="required">
                        <option value="">请选择</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-col-xs2" style="width: 16.2%">
            <div class="layui-form-item">
                <label class="layui-form-label">子项目类型</label>
                <div class="layui-input-block">
                    <select name="pbagType" lay-verify="required">
                        <option value="">请选择</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-col-xs2" style="width: 16.2%">
            <div class="layui-form-item">
                <label class="layui-form-label">子项目状态</label>
                <div class="layui-input-block">
                    <%--                    <input type="text" name="bagStatus" required  lay-verify="required" autocomplete="off" class="layui-input">--%>
                    <select name="bagStatus" lay-verify="required">
                        <option value="">请选择</option>
                        <option value="1">未开始</option>
                        <option value="2">超时未开始</option>
                        <option value="3">正在进行</option>
                        <option value="4">进度滞后</option>
                        <option value="5">进度超前</option>
                        <option value="6">暂停执行</option>
                        <option value="7">正常完成</option>
                        <option value="8">滞后完成</option>
                        <option value="9">提前完成</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-col-xs2 authority_search" style="margin-top:4px;width: 18%;display: none;">
            <button type="button" class="layui-btn layui-btn-sm showAll"  style="float: right;" >显示全部</button>
            <button type="button" class="layui-btn layui-btn-sm"  onclick="reset()" style="float: right;margin-right: 10px;">重置</button>
            <button type="button" class="layui-btn layui-btn-sm querySubproject"  style="float: right">查询</button>
        </div>
    </div>
    <div style="padding: 0px 8px;" class="clearfix">
        <div class="con_left">
            <%--组织筛选--%>
            <div  class="layui-form">
                <select name="deptName" lay-verify="required" lay-filter="deptName">
                </select>
            </div>
            <%--项目机构和项目信息--%>
            <%--            <div class="eleTree ele1" style="overflow-x: auto;margin-top: 10px;" lay-filter="projectLeft"></div>--%>
            <ul style="margin-top: 10px;"></ul>
        </div>
        <div class="con_right">
            <%--<div class="tishi" style="height: 100%;text-align: center;border: none;">
                <div style="width:100%;padding-top:12%;"><img style="margin-top: 2%;text-align: center;" src="/img/noData.png" alt=""></div>
                <h2 style="margin: auto;text-align: center;font-size: 20px;font-weight: normal;">请选择左侧项目</h2>
            </div>--%>
            <div style="position: relative">
                <table id="demoTreeTb" lay-filter="demoTreeTb"></table>
                <i class="layui-icon layui-icon-left foldIcon" title="折叠"></i>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container" style="height: 30px;">
        {{#  if(authorityObject && authorityObject['33']){ }}
        <button class="layui-btn layui-btn-sm" lay-event="approval">同意</button>
        {{#  }  }}
        {{#  if(authorityObject && authorityObject['25']){ }}
        <button class="layui-btn layui-btn-sm" lay-event="noApproval">退回</button>
        {{#  }  }}
    </div>
</script>
<script>
    initAuthority();
    
    var form
    var insTb
    $('.con_left ul').height($(window).height()-180)
    // $('.con_right').height($(window).height()-180)
    //选人控件添加
    $(document).on('click','.userAdd',function () {
        var chooseNum=$(this).attr('chooseNum')==1? '?0' : ''
        user_id=$(this).siblings('textarea').attr('id')
        $.popWindow("/common/selectUser"+chooseNum);
    })
    //选人控件删除
    $(document).on('click','.userDel',function () {
        var userId=$(this).siblings('textarea').attr('id')
        $('#'+userId).val('')
        $('#'+userId).attr('user_id','')
    })
    var dictionaryObj = {PBAG_NATURE: {}, PBAG_CLASS: {}, PBAG_TYPE: {}, COST_TYPE: {}, PBAG_LEVEL: {}, ACCORDING: {}, PLAN_SYCLE: {}, TASK_TYPE: {},CUSTOMER_UNIT:{},WORKAREA_NAME:{}}
    var dictionaryStr = 'PBAG_NATURE,PBAG_CLASS,PBAG_TYPE,COST_TYPE,PBAG_LEVEL,ACCORDING,PLAN_SYCLE,TASK_TYPE,CUSTOMER_UNIT,WORKAREA_NAME'
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
                    dictionaryObj[dict] = {object: {}, str: ''}
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
    layui.use(['treeTable','form','laydate','upload'], function () {
        var  treeTable = layui.treeTable;
        var  laydate = layui.laydate;
        var  upload = layui.upload;
        form = layui.form;
        // var insTb
        $('.query select[name="buildUnit"]').append(dictionaryObj['CUSTOMER_UNIT']['str'])
        $('.query select[name="designUnit"]').append(dictionaryObj['CUSTOMER_UNIT']['str'])
        $('.query select[name="pbagType"]').append(dictionaryObj['PBAG_TYPE']['str'])
        form.render();
        //左侧下拉框部门展示
        $.ajax({
            // url:'/department/getDeptTop',
            url:'/plcOrg/selectYJ',
            dataType:'json',
            type:'get',
            success:function(res){
                var data=res.obj
                var str='<option value="">请选择</option>'
                for(var i=0;i<data.length;i++){
                    str+='<option value="'+data[i].projOrgId+'">'+data[i].contractorName+'</option>'
                }
                $('.con_left [name="deptName"]').html(str)
                form.render()
                projectLeft($('.con_left [name="deptName"]').val())
            }
        })
        //加监听左侧下拉框部门选择
        form.on('select(deptName)', function(data){
            // console.log(data.value); //得到被选中的值
            projectLeft(data.value)
        });
        //左侧项目信息列表
        function projectLeft(projOrgId){
            $.get('/ProjectInfo/selectProPlus?projOrgId='+projOrgId+'&useflag=false',function (res) {
                var data=res.data
                var str=''
                for(var i=0;i<data.length;i++){
                    str+='<li projectId="'+data[i].projectId+'" projectNo="'+data[i].projectNo+'">'+data[i].projectAbbreviation+'</li>'
                }
                if (data.length > 0){
                    treeTableShow(data[0].projectId);
                }
                $('.con_left ul').html(str);
                $('.con_left ul').children('li').eq(0).addClass('select');
            })
        }
        // 节点点击事件
        $(document).on('click','.con_left ul li',function () {
            $(this).addClass('select').siblings().removeClass('select')
            var projectId=$(this).attr('projectId')
            var projectNo=$(this).attr('projectNo')
            treeTableShow(projectId)
            $('#leftId').attr('projectId',projectId)
            $('#leftId').attr('projectInfoNo',projectNo)
        })
        // 渲染树形表格
        function treeTableShow(projectId) {
            insTb = treeTable.render({
                elem: '#demoTreeTb',
                url: '/plcProjectBag/selectByProjectIdShow?projectId='+projectId+'&_='+new Date().getTime(),
                toolbar: '#toolbarDemo',
                tree: {
                    iconIndex: 1,           // 折叠图标显示在第几列
                    idName:'ids',
                    childName:"bags"
                },
                cols: [[
                    {type: 'checkbox'},
                    {field: 'auditerStatus', title: '审批状态',width:220,templet:function (d) {
                            if(d.auditerStatus==0){
                                return '待审批'
                            }else if(d.auditerStatus==1){
                                return '已批准'
                            }else if(d.auditerStatus==2){
                                return '未批准,请修改后重新提交'
                            }else{
                                return  ''
                            }
                        } },
                    // {field: 'bagNumber', title: '子项目编号',width:200,},
                    {field: 'pbagName', title: '子项目名称',width:400,templet: function(d){
                            /* if(dictionaryObj['WORKAREA_NAME']['object'][d.pbagName]){
                                 return '<span style="color:blue;" class="pbagName" ids="'+d.ids+'">'+dictionaryObj['WORKAREA_NAME']['object'][d.pbagName] +'</span>'
                             }else{
                                 return '<span style="color:blue;" class="pbagName" ids="'+d.ids+'">'+ d.pbagName +'</span>'
                             }*/
                            return '<span style="color:blue;cursor: pointer" class="pbagName pbagDetail" ids="'+d.ids+'" pbagId="'+d.pbagId+'" >'+ d.pbagName +'</span>'
                        }},
                    {field: 'pbagNature', title: '子项目性质',width:150,templet: function(d){
                            return  dictionaryObj['PBAG_NATURE']['object'][d.pbagNature] || ''
                        }},
                    {field: 'pbagContent', title: '施工内容',width:200,},
                    {field: 'pbagClass', title: '子项目分类',width:120,templet: function(d){
                            return  dictionaryObj['PBAG_CLASS']['object'][d.pbagClass] || ''
                        }},
                    {field: 'pbagType', title: '子项目类型',width:120,templet: function(d){
                            return  dictionaryObj['PBAG_TYPE']['object'][d.pbagType] || ''
                        }},
                    /*  {field: 'costType', title: '成本类型',templet: function(d){
                              return  dictionaryObj['COST_TYPE']['object'][d.costType] || ''
                          }},*/
                    {field: 'dutyUserName', title: '责任人'},
                    // {field: 'dutyUserTel', title: '责任人电话'},
                    // {field: 'dutyDept', title: '责任部门'},
                    {field: 'planBeginDate', title: '计划开始时间',width:150,templet: function(d){
                            return format(d.planBeginDate)
                        }},
                    {field: 'planEndDate', title: '计划结束时间',width:150,templet: function(d){
                            return format(d.planEndDate)
                        }},
                    /* {field: 'realBeginDate', title: '实际开始时间'},
                     {field: 'realEndDate', title: '实际完成时间'},*/
                    // {field: 'acceptStandard', title: '验收标准'},
                    {field: 'budgetYn', title: '是否预算控制',width:130,templet: function(d){
                            return  isUndefined(d.budgetYn)
                        }},
                    {field: 'pbagLevel', title: '子项目层级',width:120,},
                    {field: 'buildUnit', title: '施工单位',width:120,templet: function(d){
                            return  dictionaryObj['CUSTOMER_UNIT']['object'][d.buildUnit] || ''
                        }},
                    {field: 'designUnit', title: '设计单位',width:120,templet: function(d){
                            return  dictionaryObj['CUSTOMER_UNIT']['object'][d.designUnit] || ''
                        }},
                    {field: 'purchaseUnitUser', title: '采购单位',width:120,templet: function(d){
                            return  dictionaryObj['CUSTOMER_UNIT']['object'][d.purchaseUnitUser] || ''
                        }},
                    // {field: 'truePeriod', title: '实际工期'},
                    {field: 'planPeriod', title: '计划工期'},
                    // {field: 'pbagTarget', title: '子项目关键任务'},
                    {field: 'isNewChild', title: '是否开放下级子项目',width:160,templet: function(d){
                            return  isUndefined(d.isNewChild)
                        }},
                    {field: 'isNewItem', title: '是否新建子任务',width:120,templet: function(d){
                            return  isUndefined(d.isNewItem)
                        }},
                    {field: 'isNewTarget', title: '是否新建关键任务',width:120,templet: function(d){
                            return  isUndefined(d.isNewTarget)
                        }},
                    {field: 'isinitializtion', title: '是否初始化',width:120,templet: function(d){
                            return  isUndefined(d.isinitializtion)
                        }},
                ]],
                height: 'full-90',
                parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "data": res.obj //解析数据列表
                    };
                },
                done:function (res) {
                    // $('th[data-type="checkbox"] .ew-tree-table-cell').remove()
                    // $('.ew-tree-table-tool-item').eq(1).hide()
                    $('.ew-tree-table-tool-item').eq(2).hide()
                    // $('.ew-tree-table-box').height($(window).height()-240)
                }
            });
        }
        // treeTableShow('')
        treeTable.on('toolbar(demoTreeTb)', function(obj){
            // console.log(obj)
            switch(obj.event){
                case 'approval':
                    isApproval(1)
                    break;
                case 'noApproval':
                    isApproval(2)
                    break;
            };
        });
        //是否批准
        function isApproval(type) {
            if(type==1){
                var title='同意'
                var auditerStatus=1
            }else if(type==2){
                var title='退回'
                var auditerStatus=2
            }
            if(insTb.checkStatus().length==0){
                layer.msg('请选择至少一项子项目！',{icon:0});
                return false
            }
            var arrId=[]
            var pbagIdArr=[]
            $('tbody td .layui-form-checked').each(function (index,item) {
                //判断是否有子集
                if($(this).parents('tr').attr('data-have-child')){
                    var dataIndent=parseInt($(this).parents('tr').attr('data-indent'))
                    arrId.push($(this).parents('tr').find('.pbagName').attr('pbagid'))
                    //只取属于自己子集的pbagid
                    $(this).parents('tr').nextAll('tr').each(function () {
                        if(parseInt($(this).attr('data-indent')) > dataIndent ){
                            arrId.push($(this).find('.pbagName').attr('pbagid'))
                        }else{
                            return false
                        }
                    })
                }else{
                    arrId.push($(this).parents('tr').find('.pbagName').attr('pbagid'))
                }
            })
            //数组去重
            for(var i=0;i<arrId.length;i++){
                if(pbagIdArr.indexOf(arrId[i])==-1){
                    pbagIdArr.push(arrId[i])
                }
            }
            // console.log(pbagIdArr)
            var pbagId=pbagIdArr.join(',')
            layer.confirm('确定'+title+'吗？', function(index){
                for(i=0;i<insTb.checkStatus().length;i++){
                    if(insTb.checkStatus()[i].auditerStatus ==auditerStatus ){
                        if(auditerStatus==1){
                            layer.msg("该选项中已经同意不可重复同意")
                            return false;
                        }
                        else{
                            layer.msg("该选项中已经退回不可重复退回")
                            return false;
                        }
                    }
                    $.ajax({
                        url:'/plcProjectBag/updateAuditerStatus',
                        dataType:'json',
                        type:'post',
                        data:{ pbagId:pbagId,
                            auditerStatus:auditerStatus},
                        success:function(res){
                            if(res.flag){
                                layer.msg('保存成功！',{icon:1});
                                layer.close(index)
                                insTb.reload()
                            }
                        }
                    })
                }
            });
        }
        //判断是否全选
        treeTable.on('checkbox(demoTreeTb)', function(obj){
            /* console.log(obj.checked);  // 当前是否选中状态
             console.log(obj.data);  // 选中行的相关数据
             console.log(obj.type);  // 如果触发的是全选，则为：all，如果触发的是单选，则为：more*/
            if(obj.type=='more'){
                var checkbox=$('tbody td .layui-form-checkbox')
                for(var i=0;i<checkbox.length;i++){
                    if(!checkbox.eq(i).hasClass('layui-form-checked')){
                        $('thead th .layui-form-checkbox').removeClass('layui-form-checked')
                        return false
                    }else{
                        $('thead th .layui-form-checkbox').addClass('layui-form-checked')
                    }
                }
            }
        });
        //子项目详情页面
        $(document).on('click','.pbagDetail',function () {
            $.get('/plcProjectBag/selectPbagById',{pbagId:$(this).attr('pbagId')},function (res) {
                var data=res.data
                layer.open({
                    type: 1,
                    title: '子项目详情',
                    area: ['70%', '80%'],
                    maxmin: true,
                    min: function () {
                        $('.layui-layer-shade').hide()
                    },
                    content: '<div style="margin: 10px"><table class="layui-table child" >\n' +
                        '  <colgroup>\n' +
                        '    <col width="150">\n' +
                        '    <col width="200">\n' +
                        '    <col width="150">\n' +
                        '    <col width="200>\n' +
                        '  </colgroup>'+
                        '  <tbody>\n' +
                        '    <tr>\n' +
                        '      <td>编号</td>\n' +
                        '      <td>'+isShowNull(data.bagNumber)+'</td>\n' +
                        '      <td>上级子项目</td>\n' +
                        '      <td id="shangjiName">'+isShowNull(data.parentPbagId)+'</td>\n' +
                        '    </tr>\n' +
                        '    <tr>\n' +
                        '      <td>子项目名称</td>\n' +
                        '      <td>'+isShowNull(data.pbagName)+'</td>\n' +
                        '      <td>子项目类型</td>\n' +
                        '      <td>'+isShowNull(dictionaryObj['PBAG_TYPE']['object'][data.pbagType])+'</td>\n' +
                        '    </tr>\n' +
                        '    <tr>\n' +
                        '      <td>子项目性质</td>\n' +
                        '      <td>'+isShowNull(dictionaryObj['PBAG_NATURE']['object'][data.pbagNature])+'</td>\n' +
                        '      <td>子项目分类</td>\n' +
                        '      <td>'+isShowNull(dictionaryObj['PBAG_CLASS']['object'][data.pbagClass])+'</td>\n' +
                        '    </tr>\n' +
                        '    <tr>\n' +
                        '      <td>施工单位</td>\n' +
                        '      <td>'+isShowNull(dictionaryObj['CUSTOMER_UNIT']['object'][data.buildUnit])+'</td>\n' +
                        '      <td>施工单位负责人及电话</td>\n' +
                        '      <td>'+isShowNull(data.buildUnitUser)+'</td>\n' +
                        '    </tr>\n' +
                        '    <tr>\n' +
                        '      <td>设计单位</td>\n' +
                        '      <td>'+isShowNull(dictionaryObj['CUSTOMER_UNIT']['object'][data.designUnit])+'</td>\n' +
                        '      <td>设计单位负责人及电话</td>\n' +
                        '      <td>'+isShowNull(data.designUnitUser)+'</td>\n' +
                        '    </tr>\n' +
                        '    <tr>\n' +
                        '      <td>主要负责人</td>\n' +
                        '      <td>'+isShowNull(data.dutyUserName.replace(/,$/, '').split(','))+'</td>\n' +
                        '      <td>计划开始时间</td>\n' +
                        '      <td>'+function () {
                            if(data.planBeginDate){
                                return format(data.planBeginDate)
                            }else{
                                return  ''
                            }
                        }()+'</td>\n' +
                        '    </tr>\n' +
                        '    <tr>\n' +
                        '      <td>计划结束时间</td>\n' +
                        '      <td>'+function () {
                            if(data.planEndDate){
                                return format(data.planEndDate)
                            }else{
                                return  ''
                            }
                        }()+'</td>\n' +
                        '      <td>计划工期</td>\n' +
                        '      <td>'+isShowNull(data.planPeriod)+'</td>\n' +
                        '    </tr>\n' +
                        '    <tr>\n' +
                        '      <td>是否要预算控制</td>\n' +
                        '      <td>'+isUndefined(data.budgetYn)+'</td>\n' +
                        '      <td>是否开放下级子项目</td>\n' +
                        '      <td>'+isUndefined(data.isNewChild)+'</td>\n' +
                        '    </tr>\n' +
                        '    <tr>\n' +
                        '      <td>是否可新建关键任务</td>\n' +
                        '      <td>'+isUndefined(data.isNewTarget)+'</td>\n' +
                        '      <td>是否可新建子任务</td>\n' +
                        '      <td>'+isUndefined(data.isNewItem)+'</td>\n' +
                        '    </tr>\n' +
                        '    <tr>\n' +
                        '      <td>关联资源</td>\n' +
                        '      <td></td>\n' +
                        '    </tr>\n' +
                        '  </tbody>\n' +
                        '</table></div>',
                    success:function () {
                        //获取上级子项目名称
                        var parentIdName=data.parentPbagId || 0
                        $.get('/plcProjectBag/bagNameByParentId',{parentId:parentIdName},function (res) {
                            //判断是否已经是一级子项目
                            if(res.object.pbagName){
                                $('#shangjiName').text(res.object.pbagName)
                            }else{
                                $('#shangjiName').text(res.object)
                            }
                        })
                    }
                })
            })
        })
        //判断是否初始化
        function isinitializtion() {
            var isOpen=''
            $.ajax({
                url:'/plcProjectBag/isStart',
                data:{projectId:$('#leftId').attr('projectId')},
                dataType:'json',
                type:'get',
                async:false,
                success:function(res){
                    if(res.flag){
                        isOpen=res.data
                    }
                }
            })
            return isOpen
        }
        //查询
        $('.querySubproject').on('click',function () {
            /*  if(!$('#leftId').attr('projectId')){
                  layer.msg('请先选择左侧项目！', {icon: 0});
                  return false
              }*/
            var projectId=$('#leftId').attr('projectId')
            if(!projectId){
                projectId=''
            }
            var params={
                projectId:projectId,
                pbagName:$('.query input[name="pbagName"]').val(),
                buildUnit:$('.query select[name="buildUnit"]').val(),
                designUnit:$('.query select[name="designUnit"]').val(),
                pbagType:$('.query select[name="pbagType"]').val(),
                bagStatus:$('.query select[name="bagStatus"]').val(),
                _:new Date().getTime()
            }
            insTb.reload({
                url:'/plcProjectBag/selectProCheck',
                where: params
            })
        })
        //显示全部
        $('.showAll').on('click',function () {
            treeTableShow('')
            $('.select').removeClass('select')
            $('#leftId').removeAttr('projectId')
        })
    })
    //点击按钮收缩
    $('.foldIcon').on('click',function () {
        if($(this).hasClass('layui-icon-left')){
            $(this).attr('title','展开')
            $('.con_left').hide()
            $('.con_right').css({
                'width':'100%',
            })
            $(this).addClass('layui-icon-right').removeClass('layui-icon-left')
        }else{
            $(this).attr('title','折叠')
            $('.con_left').show().css('width','230px')
            $('.con_right').css({
                'width':'calc(100% - 230px)',
                'margin-left':'0px'
            })
            $(this).addClass('layui-icon-left').removeClass('layui-icon-right')
        }

    })
    //判断是否该为空
    function isUndefined(data) {
        if(data==1){
            return '是'
        }else if(data==0){
            return '否'
        }else{
            return ''
        }
    }
    //将毫秒数转为yyyy-MM-dd格式时间
    function format(t) {
        if (t) return new Date(t).Format("yyyy-MM-dd");
        else return ''
    }
    //重置功能
    function reset() {
        $('.query input[name="pbagName"]').val('')
        $('.query select[name="buildUnit"]').val('')
        $('.query select[name="designUnit"]').val('')
        $('.query select[name="pbagType"]').val('')
        $('.query input[name="title"]').val('')
        form.render()
        var projectId=$('#leftId').attr('projectId')
        if(!projectId){
            projectId=''
        }
        var params={
            projectId:projectId,
            pbagName:$('.query input[name="pbagName"]').val(),
            buildUnit:$('.query select[name="buildUnit"]').val(),
            designUnit:$('.query select[name="designUnit"]').val(),
            pbagType:$('.query select[name="pbagType"]').val(),
            bagStatus:$('.query select[name="bagStatus"]').val(),
            _:new Date().getTime()
        }
        insTb.reload({
            url:'/plcProjectBag/selectProCheck',
            where: params
        })
    }
    //判断是否显示空
    function isShowNull(data) {
        if(data){
            return data
        }else{
            return ''
        }
    }

    // 初始化页面操作权限
    function initAuthority() {
        // 是否设置页面权限
        if (authorityObject) {
            // 检查保存权限
            if (authorityObject['09']) {
                $('.authority_search').show();
            }
        }
    }

</script>
</body>
</html>
