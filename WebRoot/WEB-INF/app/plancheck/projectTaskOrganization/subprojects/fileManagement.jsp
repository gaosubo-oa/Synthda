<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-04-16
  Time: 12:00
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
    <title>档案管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css?2019101815.40">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/jquery/jquery.cookie.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>

    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <style>
        html,body{
            height: 100%;
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
</head>
<body>
<div>
    <div class="headImg" style="margin-top: 10px">
        <span style="font-size:22px;margin-left:10px;color:#494d59;margin-top: 2px"><img style="margin-left:1.5%" src="../img/commonTheme/theme6/icon_summary.png" alt=""><span  class="headTitle" style="margin-left: 10px">档案管理</span></span>
    </div>
    <hr>
    <input type="hidden" id="leftId" class="layui-input">
    <div style="margin-top: 20px">
        <form class="layui-form" action="">
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
                            <select name="respectiveRegion" lay-verify="required"  class="deptName">
                                <option value="">请选择</option>
                            </select>
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
                        <label class="layui-form-label" >竣工时间</label>
                        <div class="layui-input-block">
                            <input style="height: 35px" type="text" id="queryWinTime" name="queryWinTime" required  lay-verify="required" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs2" style="margin-top: 2px;text-align: right;">
                   <%-- <button type="button" class="layui-btn layui-btn-sm showAll" style="float: right;margin-right: 10px;" >显示全部</button>--%>
                    <button type="button" class="layui-btn layui-btn-sm" onclick="query()">查询</button>
                    <button type="button" class="layui-btn layui-btn-sm reset" style="margin-left: 10px;" >重置</button>
                    <button button type="button" class="layui-btn layui-btn-sm"  style="margin-left: 10px;margin-right:10px;">
                        <i class="layui-icon layui-icon-spread-left icon"></i>
                    </button>
                </div>
            </div>
        </form>
        <div style="padding: 0px 8px;" class="clearfix">
            <div class="con_left">
                <%--组织筛选--%>
                <%-- <div  class="layui-form">
                     <select name="deptName" lay-verify="required" lay-filter="deptName">
                     </select>
                 </div>--%>
                <%--项目机构--%>
                <%--<ul style="margin-top: 10px;"></ul>--%>
                <%--<div class="eleTree ele1" style="margin-top: 10px;" lay-filter="projectLeft"></div>--%>
                <ul id="questionTree" style="overflow:auto;height:calc(100% - 10px)"></ul>
            </div>
            <div class="con_right">
                <%-- <div class="tishi" style="height: 100%;text-align: center;border: none;">
                     <div style="width:100%;padding-top:10%;"><img style="margin-top: 2%;text-align: center;" src="/img/noData.png" alt=""></div>
                     <h2 style="margin: auto;text-align: center;font-size: 20px;font-weight: normal;">请选择左侧所属机构</h2>
                 </div>--%>
                <table id="demo" lay-filter="test"></table>
                <i class="layui-icon layui-icon-left foldIcon" title="折叠"></i>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add">项目信息</button>
        <button class="layui-btn layui-btn-sm" lay-event="inforAdd" style="margin-left:10px;">计划</button>
        <button class="layui-btn layui-btn-sm" lay-event="projectStatus" style="margin-left:10px;">版本</button>
        <button class="layui-btn layui-btn-sm" lay-event="add" style="margin-left:10px;">经验总监</button>
        <div style="position:absolute;top: 0px;right:-85px">
<%--            <button class="layui-btn layui-btn-sm" lay-event="edit" style="margin-left:10px;">编辑</button>--%>
<%--            <button class="layui-btn layui-btn-sm" lay-event="del" style="margin-left:10px;">删除</button>--%>
<%--            <button class="layui-btn layui-btn-sm " lay-event="import" style="margin-left:10px;">导入</button>--%>
            <button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;">导出</button>
        </div>
    </div>
</script>

<script>
    var table
    var form
    var laydate
    var upload
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
    layui.use(['table','form','laydate','upload','eleTree'], function(){
        table = layui.table;
        form = layui.form;
        laydate = layui.laydate;
        upload = layui.upload;
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
        // 所属单位的ajax
        $.ajax({
            url: '/department/getDeptTop',
            dataType: 'json',
            type: 'get',
            success: function (res) {
                var obj = res.obj
                var str = ''
                for (var i = 0; i < obj.length; i++) {
                    str += '<option value="' + obj[i].deptName + '">' + obj[i].deptName + '</option>'
                }
                $('.deptName').append(str)
                form.render('select');
            }
        });
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
        //上方按钮显示
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            // console.log(checkStatus)
            switch(obj.event){
                case 'add':
                    var projOrgId= $('#leftId').attr('projOrgId')
                    if(projOrgId==undefined){
                        layer.msg('请选择左侧后进行添加！',{icon:0});
                        return false
                    }
                    creat(0)
                    break;
                case 'inforAdd':
                    if(checkStatus.data.length!=1){
                        layer.msg('请选择一项项目！',{icon:0});
                        return false
                    }
                    creatAdd(checkStatus.data[0])
                    /* layer.open({
                         type: 2,
                         area: ['100%', '100%'],
                         content: '/ProjectInfo/projectInforSupply' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                     });*/
                    break;
                case 'projectStatus':
                    if(!checkStatus.data.length){
                        layer.msg('请至少选择一项项目！',{icon:0});
                        return false
                    }
                    var projectId=[]
                    checkStatus.data.forEach(function (v,i) {
                        projectId.push(v.projectId)
                    })
                    layer.open({
                        type: 1,
                        title: '项目进展',
                        btn: ['确定', '取消'],
                        area: ['30%', '64%'],
                        content: '<div class="layui-form" style="width: 70%;margin: 15px auto">' +
                            '<div class="layui-form-item">\n' +
                            '      <select name="projectStatus">\n' +
                            '        <option value="0">在建</option>\n' +
                            '        <option value="1">收尾</option>\n' +
                            '        <option value="2">竣工</option>\n' +
                            '        <option value="3">关闭</option>\n' +
                            '      </select>\n' +
                            '    </div>'+
                            '</div>',
                        success: function(){
                            form.render('select')
                        },
                        yes: function (index) {
                            $.ajax({
                                url:'/ProjectInfo/updateProjectStatus',
                                dataType:'json',
                                type:'post',
                                data:{projectId:projectId,projectStatus:$('select[name="projectStatus"]').val()},
                                traditional:true,
                                success:function(res){
                                    if(res.flag){
                                        layer.msg('保存成功！',{icon:1});
                                    }
                                    layer.close(index)
                                    tableIns.config.where._ = new Date().getTime();
                                    tableIns.reload()
                                }
                            })
                        },
                    });
                    break;
                case 'edit':
                    if(checkStatus.data.length!=1){
                        layer.msg('请选择一项项目！',{icon:0});
                        return false
                    }
                    creat('1',checkStatus.data[0])
                    break;
                case 'import':
                    //alert(11111)
                    var repTableId = $('.select').attr('repTableId');
                    Import(repTableId);
                    break;
                case 'export':
                    window.location.href="/ProjectInfo/outputProjectInfo"
                    break;
            };
        });
        //监听工具条
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            if(layEvent === 'detail'){ //查看
                creat('2',data)
            }
        });
        //左侧项目机构列表
        function projectLeft(){
            /*$.get('/ProjectInfo/selectByRegion?deptId='+deptId,function (res) {
                var data=res.obj
                var str=''
                for(var i=0;i<data.length;i++){
                    if(i==0){
                        str+='<li class="select" projOrgId="'+data[i].projOrgId+'">'+data[i].contractorName+'</li>'
                    }else{
                        str+='<li projOrgId="'+data[i].projOrgId+'">'+data[i].contractorName+'</li>'
                    }
                }
                $('.con_left ul').html(str)
                if($('.select').attr('projOrgId')){
                    projectTable($('.select').attr('projOrgId'),$('.layui-tab .layui-this',window.parent.document).attr('projectStatus'))
                    $('.foldIcon').show()
                }
                if($('.con_left ul').html()==''){
                    $('.tishi').show()
                    $('.layui-table-view').hide()
                    $('.foldIcon').hide()
                }else{
                    $('.tishi').hide()
                    $('.layui-table-view').show()
                    $('.foldIcon').show()
                }
            })*/
            insTree =eleTree.render({
                elem: '.ele1',
                // url:'/plcOrg/selectYJ?'+'&_='+new Date().getTime(),
                url:'/plcOrg/getTreeListByLoginer?_='+new Date().getTime(),
                highlightCurrent:true,
                showLine: true,
                request: {
                    name: "contractorName", // 显示的内容
                    key: "deptId", // 节点id
                    children:'orgList',
                },
                response: {
                    statusName: 'flag',
                    statusCode: true,
                    dataName: "object"
                },
            });
        }
        projectLeft()
        // 节点点击事件
        eleTree.on("nodeClick(projectLeft)",function(d) {
            // console.log(d.data);    // 点击节点对于的数据
            //只有机构下能添加项目，部门下不能添加项目
            if(d.data.currentData.projOrgId && d.data.currentData.isPermission == '1'){
                var projectStatus=$('.layui-tab .layui-this',window.parent.document).attr('projectStatus')
                projectTable(d.data.currentData.projOrgId,projectStatus)
                $('#leftId').attr('projOrgId',d.data.currentData.projOrgId)
                $('#leftId').attr('contractorName',d.data.currentData.contractorName)
            }
        })
        //表格渲染
        function projectTable(projOrgId,projectStatus){
            tableIns=table.render({
                elem: '#demo'
                ,url: '/ProjectInfo/selectPro'
                ,page: true //开启分页
                ,where:{
                    projOrgId:projOrgId,
                    projectStatus:projectStatus,
                    _:new Date().getTime(),
                    useFlag:true
                }
                ,toolbar: '#toolbarDemo'
                , defaultToolbar: ['filter']
                ,cols: [[ //表头
                    {type:'checkbox'}
                    ,{field: 'orderId', title: '序号', }
                    ,{field: 'projectNo', title: '编号',width:150 }
                    ,{field: 'projectName', title: '项目名称',width:500,event: 'detail', style:'cursor: pointer;color:blue' }
                    ,{field: 'projectAbbreviation', title: '项目简称',width:200}
                    // ,{field: 'projectCode', title: '项目编码',width:90 }
                    ,{field: 'projectPlace', title: '项目地点',width:90 }
                    ,{field: 'respectiveRegionName', title: '所属单位',width:150 }
                    // ,{field: 'ownerUnitName', title: '业主单位',width:90 }
                    // // ,{field: 'ownerName', title: '业主联系人',width:100 }
                    // ,{field: 'ownerPhone', title: '业主单位联系方式',width:130 }
                    // ,{field: 'manageUnitName', title: '监理单位',width:90 }
                    // // ,{field: 'manageName', title: '监理联系人',width:100 }
                    // ,{field: 'managePhone', title: '监理单位联系方式',width:130 }
                    // ,{field: 'contractMoney', title: '合同总金额',width:100 }
                    // ,{field: 'contractDuration', title: '合同总工期',width:100 }
                    ,{field: 'statrtTime', title: '计划开始时间',width:130,templet:function (d) {
                            return format(d.statrtTime)
                        } }
                    ,{field: 'endTime', title: '计划结束时间',width:130,templet:function (d) {
                            return format(d.endTime)
                        }}
                    ,{field: 'planDate', title: '计划工期',width:120,templet:function (d) {
                            return format(d.winningDate)
                        } }
                    ,{field: 'projectType', title: '项目类型',width:90 }
                    ,{field: 'projectManage', title: '项目经理',width:90 }
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
        projectTable('',$('.layui-tab .layui-this',window.parent.document).attr('projectStatus'))
        //新增编辑共用方法
        function creat(type,data) {
            var title
            if(type=='0'){
                var projOrgId= $('#leftId').attr('projOrgId')
                title='添加项目'
                url='/ProjectInfo/insertProjectInfo'
            }else if(type=='1'){
                title='编辑项目'
                url='/ProjectInfo/upProjectInfo'
            }else{
                title='查看项目'
            }
            layer.open({
                type: 1,
                title: title,
                area: ['100%', '100%'],
                maxmin:true,
                min: function(){
                    $('.layui-layer-shade').hide()
                },
                btn:['保存','上报','取消'],
                content: '<form class="layui-form" id="form" lay-filter="formTest">' +
                    //第一行
                    '<div class="layui-row">'+
                    '<div class="newAndEdit layui-col-xs6" style="margin-top:15px;"> <div class="layui-form-item" >\n' +
                    '    <label class="layui-form-label">项目编号<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="projectNo"  readonly style="background:#e7e7e7;width:90%;display:inline-block" autocomplete="off" class="layui-input jinyong textNull" title="项目编号">\n' +
                    '<button type="button" class="layui-btn layui-btn-sm refresh">刷新</button>'+
                    '    </div>\n' +
                    '  </div>'+
                    '  </div>'+
                    '<div class="newAndEdit layui-col-xs6" style="margin-top:15px;"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">是否是公司重点</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '<input type="radio" name="importantYn" value="1" title="是" class="jinyong">\n' +
                    '<input type="radio" name="importantYn" value="0" title="否" checked class="jinyong">'+
                    '    </div>\n' +
                    '  </div></div>'+
                    '</div>'+
                    //第二行
                    '<div class="layui-row">'+
                    '<div class="newAndEdit layui-col-xs6"> <div class="layui-form-item" >\n' +
                    '    <label class="layui-form-label">项目名称<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="projectName"  autocomplete="off" class="layui-input jinyong textNull" title="项目名称">\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '  </div>'+
                    '<div class="newAndEdit layui-col-xs6"><div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">项目简称<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="projectAbbreviation"  autocomplete="off" class="layui-input jinyong textNull" title="项目简称">\n' +
                    '    </div>\n' +
                    '  </div></div>'+
                    '</div>'+
                    //第三行
                    '<div class="layui-row">'+
                    '<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">项目类型<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block projectType">\n' +
                    // '      <input type="text" name="projectType" autocomplete="off" class="layui-input jinyong">\n' +
                    ' <select name="projectType" lay-verify="required" class="jinyong textNull" title="项目类型">\n' +
                    '      </select>'+
                    '    </div>\n' +
                    '  </div>'+
                    '  </div>'+
                    ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">项目地点<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="projectPlace"  autocomplete="off" class="layui-input jinyong textNull" title="项目地点">\n' +
                    '    </div>\n' +
                    '  </div> </div>'+
                    '</div>'+
                    //第四行
                    '<div class="layui-row">'+
                    '<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">中标时间<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" class="layui-input jinyong textNull" title="中标时间" autocomplete="off" name="winningDate" id="winningDate">' +
                    '    </div>\n' +
                    '  </div>'+
                    '  </div>'+
                    ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">所属单位<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block respectiveRegion">\n' +
                    /*' <select name="respectiveRegion" lay-verify="required" class="jinyong textNull" title="所属单位">\n' +
                    '      </select>'+*/
                    '      <input type="text" name="respectiveRegion" style="background:#e7e7e7;" readonly autocomplete="off" class="layui-input jinyong textNull" title="所属单位">\n' +
                    '    </div>\n' +
                    '  </div> </div>'+
                    '</div>'+
                    //第五行
                    '<div class="layui-row">'+
                    ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">合同额(万元)<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="number" name="contractMoney"  autocomplete="off" class="layui-input jinyong textNull" title="合同额(万元)">\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '  </div>'+
                    ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">计划开始时间<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" class="layui-input jinyong textNull" autocomplete="off" title="计划开始时间" name="statrtTime" id="test1">' +
                    '    </div>\n' +
                    '  </div> </div>'+
                    '</div>'+
                    //第六行
                    '<div class="layui-row">'+
                    '<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">计划结束时间<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" class="layui-input jinyong textNull" title="计划结束时间"  autocomplete="off"  name="endTime" id="test2">' +
                    '    </div>\n' +
                    '  </div>'+
                    '  </div>'+
                    ' <div class="newAndEdit layui-col-xs6"><div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">合同总工期<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="contractDuration" readonly style="background: #e7e7e7;" autocomplete="off" class="layui-input jinyong textNull" title="合同总工期">\n' +
                    '    </div>\n' +
                    '  </div> </div>'+
                    '</div>'+
                    //第七行
                    '<div><div class="layui-form-item">' +
                    '    <label class="layui-form-label">验收标准<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '<textarea name="acceptStandard" title="验收标准"  class="layui-textarea jinyong textNull"></textarea>'+
                    '    </div>\n' +
                    '</div>'+
                    '</div>'+
                    //第八行
                    '<div class="layui-row">'+
                    ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">总承包部名称<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block contractDept">\n' +
                    '  <textarea  type="text" title="总承包部名称" class="textNull" name="contractDept" id="contractDept" readonly  style="background:#e7e7e7;height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                    '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="contractDeptAdd">添加</a>\n' +
                    ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="contractDeptDel">清空</a>\n'+
                    '    </div>\n' +
                    '  </div>'+
                    '  </div>'+
                    ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">初始化分解层级</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    // '      <input type="text" name="breakTimes"  autocomplete="off" class="layui-input jinyong">\n' +
                    ' <select name="breakTimes" lay-verify="required" class="jinyong">\n' +
                    '<option value="">请选择</option>'+
                    '<option value="2">2</option>'+
                    '<option value="3">3</option>'+
                    '<option value="4">4</option>'+
                    '<option value="5">5</option>'+
                    '<option value="6">6</option>'+
                    '<option value="7">7</option>'+
                    '<option value="8">8</option>'+
                    '<option value="9">9</option>'+
                    '      </select>'+
                    '    </div>\n' +
                    '  </div> </div>'+
                    '</div>'+

                    //项目补充信息
                    '<div class="inforAdd" style="display:none">' +
                    //第一行
                    '<div class="layui-row">'+
                    ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">项目名称</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="projectName"  autocomplete="off" class="layui-input jinyong" disabled>\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '  </div>'+
                    ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">总承包部负责人</label>\n' +
                    '    <div class="layui-input-block ">\n' +
                    // '  <textarea  type="text" name="" id="" readonly  style="background:#e7e7e7;height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                    '      <input type="text" name="overallLeader"  autocomplete="off" class="layui-input jinyong">\n' +
                    '    </div>\n' +
                    '  </div> </div>'+
                    '</div>'+
                    //第二行
                    '<div class="layui-row">'+
                    ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">项目经理</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="projectManage"  autocomplete="off" class="layui-input jinyong">\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '  </div>'+
                    ' <div class="newAndEdit layui-col-xs6"><div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">项目经理电话</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="projectManagePhone"  autocomplete="off" class="layui-input jinyong">\n' +
                    '    </div>\n' +
                    '  </div> </div>'+
                    '</div>'+
                    //第三行
                    '<div class="layui-row">'+
                    ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">业主单位</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="ownerUnit" autocomplete="off" class="layui-input jinyong">\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '  </div>'+
                    ' <div class="newAndEdit layui-col-xs6"><div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">业主单位联系方式</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="ownerPhone" autocomplete="off" class="layui-input jinyong">\n' +
                    '    </div>\n' +
                    '  </div> </div>'+
                    '</div>'+
                    //第四行
                    '<div class="layui-row">'+
                    ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">监理单位</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="manageUnit" autocomplete="off" class="layui-input jinyong">\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '  </div>'+
                    ' <div class="newAndEdit layui-col-xs6"><div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">监理单位联系方式</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="managePhone" autocomplete="off" class="layui-input jinyong">\n' +
                    '    </div>\n' +
                    '  </div> </div>'+
                    '</div>'+
                    //第五行
                    '<div><div class="layui-form-item">' +
                    '    <label class="layui-form-label">施工内容</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '<textarea name="workContent"  class="layui-textarea jinyong"></textarea>'+
                    '    </div>\n' +
                    '</div>'+
                    '</div>'+
                    ' <div class="layui-form-item" style="display:none">\n' +
                    '    <label class="layui-form-label">附件</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    /* '<button type="button" class="layui-btn" id="attachment">\n' +
                     '  <i class="layui-icon">&#xe67c;</i>上传附件' +
                     '</button>'+*/
                    '<div id="fujian"></div>'+
                    ' <div id="fileAll">\n' +
                    '</div>\n' +
                    '<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                    '<img src="../img/mg11.png" alt="">\n' +
                    '<span><fmt:message code="email.th.addfile"/></span>\n' +
                    '<input type="file" multiple id="fileupload" data-url="/upload?module=plancheck" name="file">\n' +
                    '</a>\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '</div>'+
                    '</form>',
                success:function () {
                    var heightLayer=$('.layui-layer-content').height()
                    $('.layui-layer-content').height(heightLayer-50)
                    //编号
                    if(type==0){
                        $.get('/ProjectInfo/getMaxNo',{model:'projectInfo'},function (res) {
                            $('form input[name="projectNo"]').val(res)
                        })
                        $('#form input[name="respectiveRegion"]').val($('#leftId').attr('contractorname'))
                        $('#form input[name="respectiveRegion"]').attr('projOrgId',$('#leftId').attr('projOrgId'))
                    }
                    //点击刷新按钮
                    $('.refresh').click(function () {
                        $.get('/ProjectInfo/getMaxNo',{model:'projectInfo'},function (res) {
                            $('form input[name="projectNo"]').val(res)
                        })
                    })
                    form.render()
                    //项目类型回显
                    $.ajax({
                        url:'/ProjectInfo/selectProjectTypeByNo',
                        dataType:'json',
                        type:'post',
                        async:false,
                        success:function(res){
                            var projectType=res.data
                            var str=''
                            for(var i=0;i<projectType.length;i++){
                                str+='<option value="'+projectType[i].dictNo+'">'+projectType[i].dictName+'</option>'
                            }
                            $('[name="projectType"]').html(str)
                            form.render()
                        }
                    })
                    if(type=='1'){
                        $('.refresh').hide()
                        $('input[name="projectNo"]').css('width','100%')
                        //给表单赋值
                        form.val("formTest",data);
                        // console.log(data)
                        $('#contractDept').val(data.contractDeptName)
                        $('#contractDept').attr('deptid',data.contractDept)
                        $('#form input[name="respectiveRegion"]').val(data.respectiveRegionName)
                        $('#form input[name="respectiveRegion"]').attr('projOrgId',data.respectiveRegion)
                    }
                    if(type=='2'){
                        $('.refresh').hide()
                        $('form input[name="projectNo"]').css('background','none')
                        form.val("formTest",data);
                        $('.inforAdd').show()
                        $('.breakTimes').html('<input type="text" name="" value="'+data.breakTimes+'"  autocomplete="off" class="layui-input jinyong">')
                        $('.projectType').html('<input type="text" name="" value="'+function () {
                            if(projectTypeObj[data.projectType]){
                                return  projectTypeObj[data.projectType]
                            }else{
                                return ''
                            }
                        }()+'"  autocomplete="off" class="layui-input jinyong">')
                        $('.projectStatus').html('<input type="text" name="" value="'+function () {
                            if(data.projectStatus==0){
                                return '在建'
                            }else if(data.projectStatus==1){
                                return '收尾'
                            }else if(data.projectStatus==2){
                                return '竣工'
                            }else if(data.projectStatus==3){
                                return '关闭'
                            }
                        }()+'"  autocomplete="off" class="layui-input jinyong">')
                        $('.contractDept').html('<input type="text" name="" value="'+function () {
                            if(data.contractDeptName!=undefined){
                                return data.contractDeptName
                            }else {
                                return ''
                            }
                        }()+'"  autocomplete="off" class="layui-input jinyong">')
                        $('.respectiveRegion').html('<input type="text" name="" value="'+function () {
                            if(data.respectiveRegionName!=undefined){
                                return data.respectiveRegionName
                            }else {
                                return ''
                            }
                        }()+'"  autocomplete="off" class="layui-input jinyong">')
                        $('[name="overallLeader"]').val(data.overallLeaderName)
                        $('[name="projectManage"]').val(data.projectManageName)
                        $('[name="ownerUnit"]').val(data.ownerUnitName)
                        $('[name="manageUnit"]').val(data.manageUnitName)
                        $('#form .layui-input').css('border','none')
                        $('input[name="contractDuration"]').css('background','none')
                        // console.log(data)
                        $('.openFile').hide()
                        $('.layui-layer-btn').hide()
                        $('.contractDeptAdd').hide()
                        $('.contractDeptDel').hide()
                        $('#attachment').hide()
                        for(var i=0;i<$('.jinyong').length;i++){
                            $('.jinyong').eq(i).attr('disabled',true)
                            // form.render()
                        }
                        form.render()
                        //附件回显
                        var strs1 = '';
                        if(data.attachmentList){
                            for (var i = 0; i < data.attachmentList.length; i++) {
                                strs1 += '<div class="dech" deUrl="'+encodeURI(data.attachmentList[i].attUrl)+'"><a href="/download?'+encodeURI(data.attachmentList[i].attUrl)+'" NAME="' + data.attachmentList[i].attachName + '*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + data.attachmentList[i].attachName + '</a><input type="hidden" class="inHidden" value="' + data.attachmentList[i].aid + '@' + data.attachmentList[i].ym + '_' + data.attachmentList[i].attachId + ',"></div>';
                            }
                            $('#fileAll').append(strs1);
                        }
                    }
                    laydate.render({
                        elem: '#winningDate' //指定元素
                        ,trigger: 'click' //采用click弹出
                    });
                    // 初始化计划开始时间
                    var planStartLaydateConfig = {
                        elem: '#test1',
                        done: function (value, date) {
                            if ($('#test2').val()) {
                                var planPeriod = !!value ? timeRange(value, $('#test2').val()) + '天' : '';
                                $('input[name="contractDuration"]').val(planPeriod);
                            }
                            if (planEndLaydate.config.min) {
                                // 修改开始时间最大选择日期
                                planEndLaydate.config.min = {
                                    year: date.year || 1900,
                                    month: date.month - 1 || 0,
                                    date: date.date || 1,
                                }
                            } else {
                                planEndLaydateConfig.min = value;
                            }
                        }
                        ,trigger: 'click' //采用click弹出
                    }
                    if (data && data.endTime) {
                        planStartLaydateConfig.max = data.endTime;
                    }
                    var planStartLaydate = laydate.render(planStartLaydateConfig);

                    // 初始化计划结束时间
                    var planEndLaydateConfig = {
                        elem: '#test2',
                        done: function (value, date) {
                            if ($('#test1').val()) {
                                var planPeriod = !!value ? timeRange($('#test1').val(), value) + '天' : '';
                                $('input[name="contractDuration"]').val(planPeriod);
                            }
                            if (planStartLaydate.config.max) {
                                // 修改开始时间最大选择日期
                                planStartLaydate.config.max = {
                                    year: date.year || 2099,
                                    month: date.month - 1 || 11,
                                    date: date.date || 31,
                                }
                            } else {
                                planStartLaydateConfig.max = value;
                            }
                        }
                        ,trigger: 'click' //采用click弹出
                    }
                    if (data && data.statrtTime) {
                        planEndLaydateConfig.min = data.statrtTime;
                    }
                    var planEndLaydate = laydate.render(planEndLaydateConfig);
                    //总承包部的添加
                    $(".contractDeptAdd").on("click",function(){
                        dept_id = 'contractDept';
                        $.popWindow("/common/selectDept?0");
                    });
                    //总承包部的删除
                    $('.contractDeptDel').click(function () {
                        $('#contractDept').attr("deptid","");
                        $('#contractDept').attr("deptno","");
                        $('#contractDept').val("");
                    });
                },
                yes:function (index) {
                    //必填项提示
                    for(var i=0;i<$('.textNull').length;i++){
                        if($('.textNull').eq(i).val()==''){
                            layer.msg($('.textNull').eq(i).attr('title')+'为必填项！', {icon: 0});
                            return false
                        }
                    }
                    var datas=$('#form').serializeArray()
                    // console.log(data)
                    var obj={}
                    datas.forEach(function (item,index) {
                        obj[item.name]=item.value
                    })
                    // console.log(obj)
                    //获取总承包部的id
                    if($('#contractDept').attr('deptid')!=undefined){
                        obj.contractDept=$('#contractDept').attr('deptid').replace(/,$/, '')
                    }
                    //获取所属区域的id
                    if($('#respectiveRegion').attr('deptid')!=undefined){
                        obj.respectiveRegion=$('#respectiveRegion').attr('deptid').replace(/,$/, '')
                    }
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
                    obj.respectiveRegion=projOrgId

                    if(type=='1'){
                        obj.projectId=data.projectId
                    }else if(type=='0'){
                        obj.projOrgId=projOrgId
                    }
                    $.ajax({
                        url:url,
                        data:obj,
                        dataType:'json',
                        type:'post',
                        success:function(res){
                            if(type==0){
                                if(res.flag && res.object==1){
                                    layer.msg('编号重复，请点击刷新按钮重置编号！',{icon:0});
                                }else if(res.flag){
                                    layer.msg('新增成功！',{icon:1});
                                    layer.close(index)
                                    /* tableIns.config.where._ = new Date().getTime();
                                     tableIns.reload()*/
                                    tableIns.reload({
                                        where: { //设定异步数据接口的额外参数，任意设
                                            projOrgId:$('#leftId').attr('projOrgId')
                                            ,projectStatus: $('.layui-tab .layui-this',window.parent.document).attr('projectStatus')
                                            ,_:new Date().getTime()
                                            ,useFlag: true
                                        }
                                        ,page: {
                                            curr: 1 //重新从第 1 页开始
                                        }
                                    })
                                }
                            }else if(type==1){
                                if(res.flag){
                                    layer.msg('修改成功！',{icon:1});
                                    layer.close(index)
                                    /*tableIns.config.where._ = new Date().getTime();
                                    tableIns.reload()*/
                                    tableIns.reload({
                                        where: { //设定异步数据接口的额外参数，任意设
                                            projOrgId:$('#leftId').attr('projOrgId')
                                            ,projectStatus: $('.layui-tab .layui-this',window.parent.document).attr('projectStatus')
                                            ,_:new Date().getTime()
                                            ,useFlag: true
                                        }
                                        ,page: {
                                            curr: 1 //重新从第 1 页开始
                                        }
                                    })
                                }
                            }

                        }
                    })
                }
            })
        }

        //显示全部
        $('.showAll').click(function () {
            projectTable('',$('.layui-tab .layui-this',window.parent.document).attr('projectStatus'))
        })
    });
    /*  $(document).on('click','.con_left ul li',function () {
          $(this).addClass('select').siblings().removeClass('select')
          var projOrgId=$(this).attr('projOrgId')
          var projectStatus=$('.layui-tab .layui-this',window.parent.document).attr('projectStatus')
          projectTable(projOrgId,projectStatus)
      })*/
    //点击按钮收缩
    $('.foldIcon').click(function () {
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
    //选部门控件添加
    $(document).on('click','.deptAdd',function () {
        var chooseNum=$(this).attr('chooseNum')==1? '?0' : ''
        dept_id=$(this).siblings('textarea').attr('id')
        $.popWindow("/common/selectDept"+chooseNum);
    })
    //选部门控件删除
    $(document).on('click','.deptDel',function () {
        var deptId=$(this).siblings('textarea').attr('id')
        $('#'+deptId).val('')
        $('#'+deptId).attr('deptid','')
    })
    //删除附件
    $(document).on('click', '.deImgs',function(){
        var _this = this;
        var attUrl = $(this).parents('.dech').attr('deUrl');
        layer.confirm('确定删除该附件吗？', function(index){
            $.ajax({
                type: 'get',
                url: '/delete?'+attUrl,
                dataType: 'json',
                success:function(res){

                    if(res.flag == true){
                        layer.msg('删除成功', { icon:6});
                        $(_this).parent().remove();
                    }else{
                        layer.msg('删除失败', { icon:2});
                    }
                }
            })
        });

    });
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
    $('.reset').click(function () {
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
    //移除数组 arr 中的所有值与 item 相等的元素，直接在给定的 arr 数组上进行操作，并将结果返回
    function removeWithoutCopy(arr, item) {
        var num = arr.length;
        for(var i = 0; i < num; i++){
            if(arr[i] == item ){
                arr.splice(i,1);
            }
        }
        return arr;
    }
    //计算合同总工期
    function timeRange(beginTime,endTime) {
        var t1=new Date(beginTime)
        var t2=new Date(endTime)
        var time=t2.getTime()-t1.getTime()
        var days=parseInt(time / (1000*60*60*24))+1
        return days
    }
</script>
</body>

</html>

