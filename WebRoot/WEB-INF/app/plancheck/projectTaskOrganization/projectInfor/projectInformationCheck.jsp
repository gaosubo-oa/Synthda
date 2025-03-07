<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-07-15
  Time: 10:52
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
    <title>项目信息审核</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css?2019101815.40">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style>
        html,body{
            height: 100%;
            background: #ffffff;
        }
        hr{
            margin: 5px 0px;
        }
        .layui-input-block{
            margin-left: 152px;
        }
        .layui-form-label{
            width: 122px;
        }
        .layui-table-view{
            margin-left: 11px;
        }
        .layui-table-view .layui-table td, .layui-table-view .layui-table th{
            padding: 3px 0px;
        }
        .layui-table-tool{
            min-height: 40px;
            padding: 5px 15px;
        }
        .layui-form-item{
            /*width: 49%;*/
            margin-bottom: 8px;
        }
        /*  .newAndEdit{
              display: flex;
          }*/
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
        .layui-btn-container{
            position: relative;
        }
        .query .layui-form-item{
            margin-bottom: -5px;
        }
        .query .layui-form-label{
            width: 60px;
        }
        .query .layui-input-block{
            margin-left: 90px;
        }
        .inputs .layui-form-select .layui-input{
            height: 35px !important;
        }
        .layui-textarea{
            min-height: 80px;
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
        .con_left {
            float: left;
            width: 230px;
            /*height: 100%;*/
            margin-top: 10px;
            overflow-y: auto;
        }
        .con_right {
            float: left;
            width: calc(100% - 230px);
            height: 100%;
            position: relative;
        }
        .foldIcon{
            /*display: none;*/
            position: absolute;
            left: -10px;
            top: 42%;
            font-size: 30px;
            cursor: pointer;
        }
        .select{
            background: #c7e1ff;
        }
        .con_left ul li{
            padding: 5px;
        }
        .con_left input{
            height: 35px;
        }
        .layui-table-tool-self{
            top: 4px;
        }
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
<input type="hidden" id="leftId" class="layui-input">
   <%-- <div class="headImg" style="padding-top: 10px">
        <span style="font-size:22px;margin-left:10px;color:#494d59;margin-top: 2px"><img style="margin-left:1.5%" src="../img/commonTheme/theme6/icon_summary.png" alt=""><span  class="headTitle" style="margin-left: 10px">项目信息审核</span></span>
    </div>
    <hr>--%>
    <form class="layui-form" action="" style="padding-top: 15px;box-sizing: border-box">
        <div class="query layui-row" >
            <div class="layui-col-xs2">
                <div class="layui-form-item">
                    <label class="layui-form-label" >项目名称</label>
                    <div class="layui-input-block">
                        <input style="height: 35px" type="text" name="queryProjectName" required  lay-verify="required" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-col-xs2">
                <div class="layui-form-item inputs">
                    <label class="layui-form-label" >所属单位</label>
                    <div class="layui-input-block" >
                        <select name="respectiveRegion" lay-verify="required"></select>
                    </div>
                </div>
            </div>
            <div class="layui-col-xs2">
                <div class="layui-form-item inputs">
                    <label class="layui-form-label" >项目地点</label>
                    <div class="layui-input-block">
                        <select  name="queryProjectPlace" lay-verify="required" >
                            <option value="">请选择</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="layui-col-xs2">
                <div class="layui-form-item inputs">
                    <label class="layui-form-label" >项目类型</label>
                    <div class="layui-input-block" >
                        <select  name="queryProjectType" lay-verify="required" >
                            <option value="">请选择</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="layui-col-xs2">
                <div class="layui-form-item">
                    <label class="layui-form-label" >中标时间</label>
                    <div class="layui-input-block">
                        <input style="height: 35px" type="text" id="queryWinTime" name="queryWinTime" required  lay-verify="required" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-col-xs2 authority_search" style="margin-top: 2px;display: none;">
                <button type="button" class="layui-btn layui-btn-sm showAll" style="float: right;margin-right: 10px;" >显示全部</button>
                <button type="button" class="layui-btn layui-btn-sm reset" style="float: right;margin-right: 10px;" >重置</button>
                <button type="button" class="layui-btn layui-btn-sm" onclick="query()" style="float: right">查询</button>
            </div>
        </div>
    </form>
    <div style="padding: 0px 8px;" class="clearfix">
        <div class="con_left">
            <div class="eleTree ele1" style="margin-top: 10px;" lay-filter="projectLeft"></div>
        </div>
        <div class="con_right">
            <table id="demo" lay-filter="test"></table>
            <i class="layui-icon layui-icon-left foldIcon" title="折叠"></i>
        </div>
    </div>
<script type="text/html" id="barDemo">
<%--    {{#   console.log(d) }}--%>
    {{#  if(d.auditerStatus != 0){ }}
    {{#  if(authorityObject && authorityObject['33']){ }}
        <a class="layui-btn layui-btn-xs" lay-event="approval" style="cursor: not-allowed;background: #C1C1C1;">同意</a>
    {{#  }  }}
    {{#  if(authorityObject && authorityObject['25']){ }}
        <a class="layui-btn layui-btn-xs" lay-event="noApproval" style="cursor: not-allowed;background: #C1C1C1;">退回</a>
    {{#  }  }}
    {{#  }else{  }}
    {{#  if(authorityObject && authorityObject['33']){ }}
        <a class="layui-btn layui-btn-xs" lay-event="approval">同意</a>
    {{#  }  }}
    {{#  if(authorityObject && authorityObject['25']){ }}
        <a class="layui-btn layui-btn-xs" lay-event="noApproval">退回</a>
    {{#  }  }}
    {{#  }  }}

</script>

<script>
    initAuthority();
    var orgIds = '';
    var table
    var form
    var laydate
    var eleTree
    var insTree
    var tableIns
    var height=$(window).height()-115
    var projectTypeObj={}
    $('.con_left').height(height)
    var dictionaryObj = {CUSTOMER_UNIT:{}}
    var dictionaryStr = 'CUSTOMER_UNIT'
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
    layui.use(['table','form','laydate','eleTree'], function(){
        table = layui.table;
        form = layui.form;
        laydate = layui.laydate;
        eleTree = layui.eleTree;
        form.render()
        //中标时间
        laydate.render({
            elem: '#queryWinTime' //指定元素
        });
        //项目地点显示
        $.ajax({
            url:'/ProjectInfo/selectInfoPlace',
            dataType:'json',
            type:'get',
            success:function(res){
                var projectPlace=res.obj
                var str='<option value="">请选择</option>'
                for(var i=0;i<projectPlace.length;i++){
                    str+='<option value="'+projectPlace[i].projectPlace+'">'+projectPlace[i].projectPlace+'</option>'
                }
                $('[name="queryProjectPlace"]').html(str)
                // console.log(projectTypeObj)
                form.render()
            }
        })
        //项目类型显示
        $.ajax({
            url:'/ProjectInfo/selectProjectTypeByNo',
            dataType:'json',
            type:'get',
            success:function(res){
                var projectType=res.data
                var str='<option value="">请选择</option>'
                for(var i=0;i<projectType.length;i++){
                    str+='<option value="'+projectType[i].dictNo+'">'+projectType[i].dictName+'</option>'
                    projectTypeObj[projectType[i].dictNo]=projectType[i].dictName
                }
                $('[name="queryProjectType"]').html(str)
                // console.log(projectTypeObj)
                form.render()
            }
        })
        //左侧下拉框部门展示和所属单位展示
        $.ajax({
            // url:'/department/getDeptTop',
            url:'/plcOrg/selectYJ',
            dataType:'json',
            type:'get',
            success:function(res){
                var data=res.obj
                var str1='<option value="">请选择</option>'
                for(var i=0;i<data.length;i++){
                    str1+='<option value="'+data[i].projOrgId+'">'+data[i].contractorName+'</option>'
                }
                // $('.con_left [name="deptName"]').html(str1)
                $('.query [name="respectiveRegion"]').html(str1)
                form.render()
            }
        })
        //监听工具条
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            if(layEvent === 'detail'){ //查看
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
            }else if(layEvent === 'approval'){
                if(data.auditerStatus==0){
                    isApproval(1,data.projectId)
                }
            }else if(layEvent === 'noApproval'){
                if(data.auditerStatus==0){
                    isApproval(2,data.projectId)
                }
            }
        });
        //是否批准
        function isApproval(type,projectId) {
            if(type==1){
                var title='同意'
                var auditerStatus=1
            }else if(type==2){
                var title='退回'
                var auditerStatus=2
            }
            layer.confirm('确定'+title+'吗？', function(index){
                $.ajax({
                    url:'/ProjectInfo/updateAuditerStatus',
                    dataType:'json',
                    type:'post',
                    data:{projectId:projectId,auditerStatus:auditerStatus},
                    success:function(res){
                        if(res.flag){
                            layer.msg('保存成功！',{icon:1});
                            layer.close(index)
                            // tableIns.config.where._ = new Date().getTime();
                            tableIns.reload({
                                where: { //设定异步数据接口的额外参数，任意设
                                    projOrgId:$('#leftId').attr('projOrgId')
                                    ,projectStatus: ''
                                    ,_:new Date().getTime()
                                    ,useFlag: true
                                }
                                ,page: {
                                    curr: 1 //重新从第 1 页开始
                                }
                            })
                        }
                    }
                })
            });
        }
        //左侧项目机构列表
        function projectLeft() {
            $.get('/plcOrg/getTreeListByLoginer', function (res) {
                if (res.flag) {
                    insTree = eleTree.render({
                        elem: '.ele1',
                        data: res.object,
                        highlightCurrent: true,
                        showLine: true,
                        request: {
                            name: "contractorName", // 显示的内容
                            key: "deptId", // 节点id
                            children: 'orgList',
                        }
                    });
                    orgIds = getTreeId(res.object);
                    projectTable('','',orgIds)
                }
            });
        }
        projectLeft()
        // 节点点击事件
        eleTree.on("nodeClick(projectLeft)",function(d) {
            // console.log(d.data);    // 点击节点对于的数据
            //只有机构下能添加项目，部门下不能添加项目，开启权限可以添加项目
            if(d.data.currentData.projOrgId && d.data.currentData.isPermission == '1'){
                projectTable(d.data.currentData.projOrgId,'')
                $('#leftId').attr('projOrgId',d.data.currentData.projOrgId)
                $('#leftId').attr('contractorName',d.data.currentData.contractorName)
            }
        })
        //表格渲染
        function projectTable(projOrgId,projectStatus,orgIds){
            tableIns=table.render({
                elem: '#demo'
                ,url: '/ProjectInfo/selectProCheck'
                ,page: true //开启分页
                , limit: 50
                ,height:$(window).height()-120
                ,where:{
                    projOrgId:projOrgId,
                    projectStatus:projectStatus,
                    orgIds: orgIds,
                    _:new Date().getTime(),
                    useFlag:true
                }
                ,toolbar: '#toolbarDemo'
                , defaultToolbar: ['filter']
                ,cols: [[ //表头
                    {type: 'numbers',title: '序号'},
                    {field: 'auditerStatus', title: '审批状态',width:120,templet:function (d) {
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
                   // {field: 'projectNo', title: '项目编号',width:150 }
                    ,{field: 'projectName', title: '项目名称',width:500,event: 'detail', style:'cursor: pointer;color:blue' }
                    ,{field: 'projectAbbreviation', title: '项目简称',width:200}
                    ,{field: 'projectPlace', title: '项目地点',width:90 }
                    ,{field: 'respectiveRegionName', title: '所属单位',width:150 }
                    ,{field: 'ownerUnitName', title: '业主单位',width:90 }
                    // ,{field: 'ownerName', title: '业主联系人',width:100 }
                    ,{field: 'ownerPhone', title: '业主单位联系方式',width:130 }
                    ,{field: 'manageUnitName', title: '监理单位',width:90 }
                    // ,{field: 'manageName', title: '监理联系人',width:100 }
                    ,{field: 'managePhone', title: '监理单位联系方式',width:130 }
                    ,{field: 'contractMoney', title: '合同总金额',width:100 }
                    ,{field: 'contractDuration', title: '合同总工期',width:100 }
                    ,{field: 'statrtTime', title: '计划开始时间',width:130,templet:function (d) {
                            return format(d.statrtTime)
                        } }
                    ,{field: 'endTime', title: '计划结束时间',width:130,templet:function (d) {
                            return format(d.endTime)
                        }}
                    ,{field: 'projectManageName', title: '项目经理',width:90 }
                    ,{field: 'projectManagePhone', title: '经理联系电话',width:130 }
                    ,{field: 'winningDate', title: '中标日期',width:120,templet:function (d) {
                            return format(d.winningDate)
                        } }
                    /* ,{field: 'importantYn', title: '是否是公司重点',templet:function (d) {
                             if(d.importantYn=='0'){
                                 return '否'
                             }else{
                                 return '是'
                             }
                         }}
                     ,{field: 'contractMoney', title: '合同额', }
                     ,{field: 'ownerUnit', title: '业主单位', }
                     ,{field: 'manageUnit', title: '监理单位', }
                     ,{field: 'acceptStandard', title: '验收标准', }*/
                    ,{fixed: 'right',title: '操作',align:'center', toolbar: '#barDemo',width:150}
                ]]
                ,parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "count": res.count, //解析数据长度
                        "data": res.data //解析数据列表
                    };
                }
            });
        }
        //显示全部
        $('.showAll').on('click',function () {
            projectTable('','', orgIds)
        })
    });
    //点击按钮收缩
    $('.foldIcon').on('click',function () {
        if($(this).hasClass('layui-icon-left')){
            $(this).attr('title','展开')
            $('.con_left').hide()
            $('.con_right').css({
                'width':'100%',
            })
            $('.layui-table-view').css('margin-left','7px')
            $(this).css('left','-14px')
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
    //查询功能
    function query() {
        var projectStatus=$('.layui-tab .layui-this',window.parent.document).attr('projectStatus')
        // var projOrgId=$('.select').attr('projorgid')
        var projOrgId=$('#leftId').attr('projOrgId')
        if(!projOrgId){
            projOrgId=''
        }
        var params={
            projectStatus:projectStatus,
            projOrgId:projOrgId,
            projectName:$('.query input[name="queryProjectName"]').val(),
            respectiveRegion:$('.query select[name="respectiveRegion"]').val(),
            projectPlace:$('.query select[name="queryProjectPlace"]').val(),
            projectType:$('.query select[name="queryProjectType"]').val(),
            winningDate:$('.query input[name="queryWinTime"]').val(),
            useFlag: true
        }
        tableIns.reload({
            where: params
            ,page: {
                curr: 1 //重新从第 1 页开始
            }
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "data": res.data, //解析数据列表
                    "count": res.count, //解析数据长度
                };
            }
        });
    }
    //重置功能
    $('.reset').on('click',function () {
        $('.query input[name="queryProjectName"]').val('')
        $('.query select[name="respectiveRegion"]').val('')
        $('.query input[name="queryProjectPlace"]').val('')
        $('.query select[name="queryProjectType"]').val('')
        $('.query input[name="queryWinTime"]').val('')
        var projectStatus=$('.layui-tab .layui-this',window.parent.document).attr('projectStatus')
        var projOrgId=$('#leftId').attr('projOrgId')
        if(!projOrgId){
            projOrgId=''
        }
        var params={
            projectStatus:projectStatus,
            projOrgId:projOrgId,
            projectName:$('.query input[name="queryProjectName"]').val(),
            respectiveRegion:$('.query select[name="respectiveRegion"]').val(),
            projectPlace:$('.query select[name="queryProjectPlace"]').val(),
            projectType:$('.query select[name="queryProjectType"]').val(),
            winningDate:$('.query input[name="queryWinTime"]').val(),
            useFlag: true
        }
        tableIns.reload({
            where: params
            ,page: {
                curr: 1 //重新从第 1 页开始
            }
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "data": res.data, //解析数据列表
                    "count": res.count, //解析数据长度
                };
            }
        });
    })
    //将毫秒数转为yyyy-MM-dd格式时间
    function format(t) {
        if(t) return new Date(t).Format("yyyy-MM-dd");
        else return ''
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

    function getTreeId(data) {
        var ids = ''
        if (data.length > 0) {
            data.forEach(function (item) {
                if (item.isPermission == '1') {
                    ids += item.projOrgId + ',';
                }
                if (item.orgList && item.orgList.length > 0) {
                    ids += getTreeId(item.orgList);
                }
            });
        }
        return ids;
    }
    
</script>
</body>

</html>

