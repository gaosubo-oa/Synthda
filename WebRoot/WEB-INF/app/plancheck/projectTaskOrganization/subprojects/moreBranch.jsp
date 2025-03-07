<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-06-16
  Time: 20:09
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
    <title>子项目-多级分解</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css?2019101815.40">
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
        .header{
            font-size: 20px;
            margin-left: 21px;
            font-weight: bold;
            margin-top: 15px;
        }
        .layui-layer-btn{
            text-align: center;
        }
        .layui-table-header .layui-table{
            width: 100%;
        }
        .layui-table-view .layui-table{
            width: 100%;
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
            box-shadow: 0 1px 2px 0 rgba(0,0,0,.05);
        }
        .con_right {
            float: left;
            width: calc(100% - 230px);
            height: 100%;
            position: relative;
        }
    </style>

</head>
<body>
<input type="hidden" id="leftId" class="layui-input">
<div class="header"></div>
<div style="padding: 0px 8px;" class="clearfix">
    <div class="con_left">
        <div style="text-align: center;font-size: 18px">子项目</div>
        <div class="eleTree ele1" style="overflow-x: auto;margin-top: 10px;" lay-filter="pBagLeft"></div>
    </div>
    <div class="con_right">
        <div class="tishi" style="height: 100%;text-align: center;border: none;">
            <div style="width:100%;padding-top:10%;"><img style="margin-top: 2%;text-align: center;" src="/img/noData.png" alt=""></div>
            <h2 style="margin: auto;text-align: center;font-size: 20px;font-weight: normal;">请选择左侧子项目</h2>
        </div>
        <table id="demo" lay-filter="test"></table>
    </div>
</div>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <div style="position:absolute;top: 10px;right:7% ">
            <button class="layui-btn layui-btn-sm" lay-event="add" style="margin-left:10px;">新增</button>
        </div>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script>
    $('.eleTree').height($(window).height()-180)
    var dictionaryObj = {PBAG_TYPE: {}, CUSTOMER_UNIT: {}}
    var dictionaryStr = 'PBAG_TYPE,CUSTOMER_UNIT'
    var CUSTOMER_UNIT=''
    var lastchildren = '';
    // 获取数据字典数据
    $.ajax({
        url:'/Dictonary/selectDictionaryByDictNos',
        dataType:'json',
        type:'get',
        async:false,
        data:{dictNos: dictionaryStr},
        success:function(res){
            if (res.flag) {
                if(res.object['CUSTOMER_UNIT']){
                    CUSTOMER_UNIT=res.object['CUSTOMER_UNIT']
                }
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
    layui.use(['form','laydate','table','eleTree'], function(){
        var form = layui.form;
        var laydate = layui.laydate;
        var table = layui.table;
        var eleTree = layui.eleTree;
        var tableIns
        var insTree
        //左侧子项目列表
        function pBagLeft(){
            insTree =eleTree.render({
                elem: '.ele1',
                url:'/plcProjectBag/selectByIdLevel?projectId='+$.GetRequest().projectId+'&level='+$.GetRequest().level,
                highlightCurrent:true,
                showLine: true,
                request: {
                    name: "name", // 显示的内容
                    key: "ids", // 节点id
                    children: "bags",
                },
                response: {
                    statusName: 'flag',
                    statusCode: true,
                    dataName: "obj"
                },
                done: function(res){
                    // console.log(res);
                    forlastId(res.obj);
                    // console.info(lastchildren)
                }
            });
        }
        pBagLeft()
        // 节点点击事件
        eleTree.on("nodeClick(pBagLeft)",function(d) {
            // console.log(d.data);    // 点击节点对于的数据
            $('.tishi').hide()
            if(d.data.currentData.pbagLevel==$.GetRequest().level){
                treeTableShow(d.data.currentData.pbagId)
                $('#leftId').attr('pbagId',d.data.currentData.pbagId)
                $('#leftId').attr('buildUnit',d.data.currentData.buildUnit)
                $('#leftId').attr('designUnit',d.data.currentData.designUnit)
                $('#leftId').attr('purchaseUnitUser',d.data.currentData.purchaseUnitUser)
                $('#leftId').attr('planBeginDate',format(d.data.currentData.planBeginDate))
                $('#leftId').attr('planEndDate',format(d.data.currentData.planEndDate))
            }else{
                $('.layui-table-view').hide()
            }
        })
        // 渲染表格
        function treeTableShow(pbagId) {
            tableIns=table.render({
                elem: '#demo'
                ,url: '/plcProjectBag/selectByParentPbagId?parentPbagId='+pbagId+'&_='+new Date().getTime() //数据接口
                ,toolbar: '#toolbarDemo'
                ,defaultToolbar:['']
                ,cols: [[ //表头
                    {type: 'numbers',title: '序号', }
                    ,{field: 'bagNumber', title: '子项目编号',width:150 }
                    ,{field: 'pbagName', title: '子项目名称',width:280,event: 'detail', style:'color:blue' }
                    ,{field: 'pbagLevel', title: '子项目层级',width:200}
                    ,{field: 'buildUnit', title: '施工单位',width:130,templet:function (d) {
                            return dictionaryObj['CUSTOMER_UNIT']['object'][d.buildUnit]  || ''
                        } }
                    ,{field: 'designUnit', title: '设计单位',width:130,templet:function (d) {
                            if(d.designUnitList){
                                var designUnitList=d.designUnitList
                                var designUnitName=''
                                designUnitList.forEach(function (item) {
                                    designUnitName+=item.dictName+','
                                })
                                return designUnitName
                            }else{
                                return  ''
                            }
                        }}
                    ,{field: 'planBeginDate', title: '计划开始时间',width:130,templet:function (d) {
                            return format(d.planBeginDate)
                        } }
                    ,{field: 'planEndDate', title: '计划结束时间',width:130,templet:function (d) {
                            return format(d.planEndDate)
                        } }
                    ,{field: 'planPeriod', title: '计划工期',width:90 }
                    ,{title: '操作',fixed:'right',width:130,toolbar: '#barDemo'} //这里的toolbar值是模板元素的选择器
                ]]
                ,parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "data": res.data, //解析数据列表
                    };
                }
            });
        }
        //上方按钮显示
        table.on('toolbar(test)', function(obj){
            switch(obj.event){
                case 'add':
                    creat(0)
                    break;
            };
        });
        //监听工具条
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）

            if(layEvent === 'del'){ //删除
                layer.confirm('确定删除该条数据吗？', function(index){
                    $.ajax({
                        url:'/plcProjectBag/delete',
                        dataType:'json',
                        type:'post',
                        data:{pbagId:data.pbagId},
                        success:function(res){
                            if(res.flag){
                                layer.msg('删除成功！',{icon:1});
                            }else{
                                layer.msg('删除失败！',{icon:0});
                            }
                            layer.close(index)
                            tableIns.config.where._ = new Date().getTime();
                            tableIns.reload()
                            parent.insTb.reload()
                        }
                    })
                });
            } else if(layEvent === 'edit'){ //编辑
                creat(1,data)
            }
        });
        //新增方法
        function creat(type,data) {
            var title
            if(type=='0'){
                title='添加'
                url='/plcProjectBag/add'
            }else if(type=='1'){
                title='编辑'
                url='/plcProjectBag/update'
            }else{
                title='查看'
            }
            layer.open({
                type: 1,
                title: title,
                area: ['100%', '100%'],
                maxmin:true,
                min: function(){
                    $('.layui-layer-shade').hide()
                },
                btn:['保存','保存并新增','取消'],
                content: '<form class="layui-form" id="form" lay-filter="formTest">\n' +
                    '        <%--第一行--%>\n' +
                    '        <div class="layui-row" style="margin-top:15px">\n' +
                    '            <div class="layui-col-xs6">\n' +
                    '                <div class="layui-form-item">\n' +
                    '                    <label class="layui-form-label">工程编号<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '                    <div class="layui-input-block">\n' +
                    '                        <input type="text" name="bagNumber" style="background: #e7e7e7;" readonly required  lay-verify="required"  autocomplete="off" class="layui-input testNull" title="工程编号">\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-col-xs6">\n' +
                    '                <div class="layui-form-item">\n' +
                    '                    <label class="layui-form-label">工程类型<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '                    <div class="layui-input-block">\n' +
                    '                        <select name="pbagType" lay-verify="required" class="testNull" title="工程类型">\n' +
                    '                        </select>\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <%--第二行--%>\n' +
                    '        <div class="layui-row">\n' +
                    '            <div class="layui-col-xs6">\n' +
                    '                <div class="layui-form-item">\n' +
                    '                    <label class="layui-form-label">工程名称<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '                    <div class="layui-input-block">\n' +
                    '                        <input type="text" name="pbagName" required  lay-verify="required"  autocomplete="off" class="layui-input testNull" title="工程名称">\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-col-xs6">\n' +
                    '                <div class="layui-form-item">\n' +
                    '                    <label class="layui-form-label" style="width:90px;padding:9px">计划开始时间<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '                    <div class="layui-input-block">\n' +
                    '                        <input type="text" name="planBeginDate" id="planBeginDate" required  lay-verify="required"  autocomplete="off" class="layui-input testNull" title="计划开始时间">\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <%--第三行--%>\n' +
                    '        <div class="layui-row">\n' +
                    '            <div class="layui-col-xs6">\n' +
                    '                <div class="layui-form-item">\n' +
                    '                    <label class="layui-form-label" style="width:90px;padding:9px">计划完成时间<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '                    <div class="layui-input-block">\n' +
                    '                        <input type="text" name="planEndDate" id="planEndDate" required  lay-verify="required"  autocomplete="off" class="layui-input testNull"  title="计划完成时间">\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-col-xs6">\n' +
                    '                <div class="layui-form-item">\n' +
                    '                    <label class="layui-form-label">计划工期<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '                    <div class="layui-input-block">\n' +
                    '                        <input type="text" name="planPeriod" style="background: #e7e7e7;" readonly required  lay-verify="required"  autocomplete="off" class="layui-input testNull" title="计划工期">\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <%--第四行--%>\n' +
                    '        <div class="layui-row">\n' +
                    '            <div class="layui-col-xs6">\n' +
                    '                <div class="layui-form-item">\n' +
                    '                    <label class="layui-form-label">施工单位</label>\n' +
                    '                    <div class="layui-input-block">\n' +
                   /* '                        <select name="buildUnit" lay-verify="required" class="testNull" title="施工单位">\n' +
                    '                        </select>\n' +*/
                    '<input type="text" name="buildUnit" readonly title="施工单位" style="background:#e7e7e7;width:83%;display:inline-block" autocomplete="off" class="layui-input" >\n' +
                    '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" type="buildUnit" title="施工单位" class="customerUnitAdd">添加</a>\n' +
                    ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" type="buildUnit" class="customerUnitDel">清空</a>\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-col-xs6">\n' +
                    '                <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">施工单位负责人及电话</label>\n' +
                    '    <div class="layui-input-block ">\n' +
                    '      <input type="text" name="buildUnitUser"  autocomplete="off" class="layui-input" title="施工单位负责人及电话">\n' +
                    '    </div>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <%--第四行--%>\n' +
                    '        <div class="layui-row">\n' +
                    '            <div class="layui-col-xs6">\n' +
                    '                <div class="layui-form-item">\n' +
                    '                    <label class="layui-form-label">设计单位</label>\n' +
                    '                    <div class="layui-input-block">\n' +
                    /*'                        <select name="designUnit" lay-verify="required" class="testNull" title="设计单位">\n' +
                    '                        </select>\n' +*/
                    '<input type="text" name="designUnit" readonly title="设计单位" style="background:#e7e7e7;width:83%;display:inline-block" autocomplete="off" class="layui-input" >\n' +
                    '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" type="designUnit" isMore="true" title="设计单位" class="customerUnitAdd">添加</a>\n' +
                    ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" type="designUnit" class="customerUnitDel">清空</a>\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    ' <div class="layui-col-xs6"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">设计单位负责人及电话</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="designUnitUser"  autocomplete="off" class="layui-input" title="设计单位负责人及电话">\n' +
                    '    </div>\n' +
                    '  </div> </div>'+
                    '        </div>\n' +
                    '        <%--第五行--%>\n' +
                    '        <div class="layui-row">\n' +
                    '            <div class="layui-col-xs6">\n' +
                    '                <div class="layui-form-item">\n' +
                    '                    <label class="layui-form-label">采购单位</label>\n' +
                    '                    <div class="layui-input-block">\n' +
                  /*  '                        <select name="purchaseUnitUser" lay-verify="required" class="testNull" title="采购单位">\n' +
                    '                        </select>\n' +*/
                    '<input type="text" name="purchaseUnitUser" readonly title="采购单位" style="background:#e7e7e7;width:83%;display:inline-block" autocomplete="off" class="layui-input" >\n' +
                    '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" type="purchaseUnitUser"  title="采购单位" class="customerUnitAdd">添加</a>\n' +
                    ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" type="purchaseUnitUser" class="customerUnitDel">清空</a>\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-col-xs6">\n' +
                    '                <div class="layui-form-item">\n' +
                    '                    <label class="layui-form-label" style="width:90px;padding:9px">是否预算控制</label>\n' +
                    '                    <div class="layui-input-block">\n' +
                    '                        <input type="checkbox" name="budgetYn" title="预算控制" lay-skin="primary"  >\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <%--第六行--%>\n' +
                    '        <div class="layui-row">\n' +
                    '            <div class="layui-form-item layui-form-text">\n' +
                    '                <label class="layui-form-label">施工内容</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <textarea name="pbagContent"  class="layui-textarea"></textarea>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '    </form>',
                success:function () {
                    // 施工单位
                    $('.customerUnitAdd').on('click',function () {
                        var name=$(this).attr('type')
                        var isMore=$(this).attr('isMore')
                        layer.open({
                            type: 1,
                            title: '添加'+$(this).attr('title'),
                            area: ['40%', '70%'],
                            btn: ['确定', '取消'],
                            content:'<div style="margin-top: 10px;"><input style="margin-left: 10%;width: 80%" type="text" name="buildUnitSearch" placeholder="请输入'+$(this).attr('title')+'" autocomplete="off" class="layui-input"><div  class="layui-form result"  style="margin-top: 15px"></div></div>',
                            success:function () {
                                var data=CUSTOMER_UNIT
                                var str=''
                                if(isMore){
                                    for(var i=0;i<data.length;i++){
                                        str+='<div class="layui-input-block" style="margin-left: 10%"><input type="checkbox" name="'+data[i].dictName+'" title="'+data[i].dictName+'" value="'+data[i].dictNo+'" lay-skin="primary"> </div>'
                                    }
                                }else{
                                    for(var i=0;i<data.length;i++){
                                        str+='<div class="layui-input-block" style="margin-left: 10%"><input type="radio" name="buildUnitRadio" title="'+data[i].dictName+'" value="'+data[i].dictNo+'" > </div>'
                                    }
                                }
                                $('.result').html(str)
                                form.render()
                                var buildUnit=$('#form input[name="'+name+'"]').attr(name)
                                if(buildUnit){
                                    if(isMore){
                                        var buildUnitArr=buildUnit.replace(/,$/, '').split(',')
                                        $('.result input').each(function (index) {
                                            buildUnitArr.forEach(function (v,i) {
                                                if($('.result input').eq(index).val()==v){
                                                    $('.result input').eq(index).prop('checked','true')
                                                    form.render()
                                                }
                                            })
                                        })
                                    }else{
                                        $('.result input').each(function (index) {
                                            if($('.result input').eq(index).val()==buildUnit){
                                                $('.result input').eq(index).prop('checked','true')
                                                form.render()
                                            }
                                        })
                                    }
                                }
                                /*监听输入框进行模糊查询*/
                                $(document).on('input propertychange', '[name="buildUnitSearch"]', function (event) {
                                    var val=$(this).val()
                                    if(isMore){
                                        var $query=$('.result .layui-input-block span')
                                    }else{
                                        var $query=$('.result .layui-input-block .layui-form-radio div')
                                    }
                                    $query.each(function(i,v){
                                        // console.log($(v).text())
                                        if($(v).text().indexOf(val)>-1){
                                            $(v).parents('.layui-input-block').show();
                                        }else{
                                            $(v).parents('.layui-input-block').hide();
                                        }
                                    })
                                });
                            },
                            yes:function (index) {
                                var buildUnit=''
                                var buildUnitName=''
                                $('.result input').each(function () {
                                    if($(this).prop('checked')){
                                        if(isMore){
                                            buildUnit+=$(this).val()+','
                                            buildUnitName+=$(this).attr('title')+','
                                        }else{
                                            buildUnit+=$(this).val()
                                            buildUnitName+=$(this).attr('title')
                                        }
                                    }
                                })
                                $('#form input[name="'+name+'"]').val(buildUnitName)
                                $('#form input[name="'+name+'"]').attr(name,buildUnit)
                                layer.close(index);
                            }
                        })
                    })
                    $('.customerUnitDel').on('click',function () {
                        var name=$(this).attr('type')
                        $('#form input[name="'+name+'"]').val('')
                        $('#form input[name="'+name+'"]').attr(name,'')
                    })
                    $('select[name="pbagType"]').append(dictionaryObj['PBAG_TYPE']['str'])
                    $('select[name="buildUnit"]').append(dictionaryObj['CUSTOMER_UNIT']['str'])
                    $('select[name="designUnit"]').append(dictionaryObj['CUSTOMER_UNIT']['str'])
                    $('select[name="purchaseUnitUser"]').append(dictionaryObj['CUSTOMER_UNIT']['str'])
                    form.render()
                    if(type==0){
                        //编号
                        var level=parseInt($.GetRequest().level)+1
                        $.get('/ProjectInfo/getMaxNo',{model:'plcProjectBag',projectInfoNo:$.GetRequest().projectInfoNo,level:level},function (res) {
                            $('form input[name="bagNumber"]').val(res)
                        })
                        //自动回显上级所选单位
                        $('#form [name="buildUnit"]').val(dictionaryObj['CUSTOMER_UNIT']['object'][$('#leftId').attr('buildUnit')])
                        $('#form [name="buildUnit"]').attr('buildUnit',$('#leftId').attr('buildUnit'))
                        $('#form [name="designUnit"]').val(dictionaryObj['CUSTOMER_UNIT']['object'][$('#leftId').attr('designUnit')])
                        $('#form [name="designUnit"]').attr('designUnit',$('#leftId').attr('designUnit'))
                        $('#form [name="purchaseUnitUser"]').val(dictionaryObj['CUSTOMER_UNIT']['object'][$('#leftId').attr('purchaseUnitUser')])
                        $('#form [name="purchaseUnitUser"]').attr('purchaseUnitUser',$('#leftId').attr('purchaseUnitUser'))
                        form.render()
                        //默认采购单位为【powerchina】
                        $.get('/sys/getProject', function (res) {
                            if (res.flag && res.obj && res.obj == 'powerchina') {
                                for (var name in dictionaryObj['CUSTOMER_UNIT']['object']) {
                                    if (name == '99') {
                                        $('form input[name="purchaseUnitUser"]').val(dictionaryObj['CUSTOMER_UNIT']['object'][name])
                                        $('form input[name="purchaseUnitUser"]').attr('purchaseUnitUser', name)
                                    }
                                }
                            }
                        })
                    }
                    /*laydate.render({
                        elem: '#planBeginDate', //指定元素
                        trigger: 'click' //采用click弹出
                    });
                    laydate.render({
                        elem: '#planEndDate', //指定元素
                        done: function(value, date, endDate){
                            // console.log(value); //得到日期生成的值，如：2017-08-18
                            if($('#planBeginDate').val() && value){
                                var planPeriod=timeRange($('#planBeginDate').val(),value)+'天'
                                $('input[name="planPeriod"]').val(planPeriod)
                            }
                            if(!value){
                                $('input[name="planPeriod"]').val('')
                            }
                        }
                        ,trigger: 'click' //采用click弹出
                    });*/
                    if(type==1){
                        $('.layui-layer-btn1').hide()
                        form.val("formTest", data);
                        data.budgetYn==1 ? $('[name="budgetYn"]').prop('checked',true) : $('[name="budgetYn"]').prop('checked',false)
                        form.render()
                        //施工单位
                        if(data.buildUnit){
                            $('form input[name="buildUnit"]').val(dictionaryObj['CUSTOMER_UNIT']['object'][data.buildUnit])
                            $('form input[name="buildUnit"]').attr('buildUnit',data.buildUnit)
                        }
                        //设计单位
                        if(data.designUnitList){
                            var designUnitList=data.designUnitList
                            var designUnit=''
                            var designUnitName=''
                            designUnitList.forEach(function (item) {
                                designUnit+=item.dictNo+','
                                designUnitName+=item.dictName+','
                            })
                            $('form input[name="designUnit"]').val(designUnitName)
                            $('form input[name="designUnit"]').attr('designUnit',designUnit)
                        }
                        //采购单位
                        if(data.purchaseUnitUser){
                            $('form input[name="purchaseUnitUser"]').val(dictionaryObj['CUSTOMER_UNIT']['object'][data.purchaseUnitUser])
                            $('form input[name="purchaseUnitUser"]').attr('purchaseUnitUser',data.purchaseUnitUser)
                        }
                    }
                    // 初始化计划开始时间
                    var planStartLaydateConfig = {
                        elem: '#planBeginDate',
                        min: $('#leftId').attr('planBeginDate'),
                        max: $('#leftId').attr('planEndDate'),
                        done: function (value, date) {
                            if ($('#planEndDate').val()) {
                                var planPeriod = !!value ? timeRange(value, $('#planEndDate').val()) + '天' : '';
                                $('input[name="planPeriod"]').val(planPeriod);
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
                        ,value: data && data.planBeginDate ? format(data.planBeginDate) : ''
                    }
                    if (data && data.planEndDate) {
                        planStartLaydateConfig.max = data.planEndDate;
                    }
                    var planStartLaydate = laydate.render(planStartLaydateConfig);

                    // 初始化计划结束时间
                    var planEndLaydateConfig = {
                        elem: '#planEndDate',
                        min: $('#leftId').attr('planBeginDate'),
                        max: $('#leftId').attr('planEndDate'),
                        done: function (value, date) {
                            if ($('#planBeginDate').val()) {
                                var planPeriod = !!value ? timeRange($('#planBeginDate').val(), value) + '天' : '';
                                $('input[name="planPeriod"]').val(planPeriod);
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
                        ,value: data && data.planEndDate ? format(data.planEndDate) : ''
                    }
                    if (data && data.planBeginDate) {
                        planEndLaydateConfig.min = data.planBeginDate;
                    }
                    var planEndLaydate = laydate.render(planEndLaydateConfig);
                },
                yes:function (index) {
                    //必填项提示
                    for(var i=0;i<$('.testNull').length;i++){
                        if($('.testNull').eq(i).val()==''){
                            layer.msg($('.testNull').eq(i).attr('title')+'为必填项！', {icon: 0});
                            return false
                        }
                    }
                    var datas=$('form').serializeArray()
                    // console.log(datas)
                    var obj={}
                    datas.forEach(function (item,index) {
                        obj[item.name]=item.value
                    })
                    obj.budgetYn=$('[name="budgetYn"]').prop('checked') ? 1 :0
                    obj.type=3
                    obj.projectId=$.GetRequest().projectId
                    obj.parentPbagId=$('#leftId').attr('pbagId')
                    obj.pbagId=$('#leftId').attr('pbagId')
                    obj.pbagLevel=parseInt($.GetRequest().level)+1
                    if(type==1){
                        obj.pbagId=data.pbagId
                    }
                    obj.buildUnit=$('form [name="buildUnit"]').attr('buildUnit')
                    obj.designUnit=$('form [name="designUnit"]').attr('designUnit')
                    obj.purchaseUnitUser=$('form [name="purchaseUnitUser"]').attr('purchaseUnitUser')
                    // console.log(obj)
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
                                    tableIns.config.where._ = new Date().getTime();
                                    tableIns.reload()
                                    parent.insTb.reload()
                                }
                            }else if(type==1){
                                if(res.flag){
                                    layer.msg('修改成功！',{icon:1});
                                    layer.close(index)
                                    tableIns.config.where._ = new Date().getTime();
                                    tableIns.reload()
                                    parent.insTb.reload()
                                }
                            }

                        }
                    })
                },
                btn2: function(index, layero){
                    //必填项提示
                    for(var i=0;i<$('.testNull').length;i++){
                        if($('.testNull').eq(i).val()==''){
                            layer.msg($('.testNull').eq(i).attr('title')+'为必填项！', {icon: 0});
                            return false
                        }
                    }
                    var datas=$('form').serializeArray()
                    // console.log(datas)
                    var obj={}
                    datas.forEach(function (item,index) {
                        obj[item.name]=item.value
                    })
                    obj.budgetYn=$('[name="budgetYn"]').prop('checked') ? 1 :0
                    obj.type=3
                    obj.projectId=$.GetRequest().projectId
                    obj.parentPbagId=$('#leftId').attr('pbagId')
                    obj.pbagId=$('#leftId').attr('pbagId')
                    obj.pbagLevel=parseInt($.GetRequest().level)+1
                    if(type==1){
                        obj.pbagId=data.pbagId
                    }
                    obj.buildUnit=$('form [name="buildUnit"]').attr('buildUnit')
                    obj.designUnit=$('form [name="designUnit"]').attr('designUnit')
                    obj.purchaseUnitUser=$('form [name="purchaseUnitUser"]').attr('purchaseUnitUser')
                    // console.log(obj)
                    $.ajax({
                        url:url,
                        data:obj,
                        dataType:'json',
                        type:'post',
                        async:false,
                        success:function(res){
                            if(type==0){
                                if(res.flag){
                                    layer.msg('新增成功！',{icon:1});
                                    $('form')[0].reset()
                                    //自动回显上级所选单位
                                    $('select[name="buildUnit"]').val($('#leftId').attr('buildUnit'))
                                    $('select[name="designUnit"]').val($('#leftId').attr('designUnit'))
                                    $('select[name="purchaseUnitUser"]').val($('#leftId').attr('purchaseUnitUser'))
                                    form.render()
                                    tableIns.config.where._ = new Date().getTime();
                                    tableIns.reload()
                                    parent.insTb.reload()
                                }
                            }else if(type==1){
                                if(res.flag){
                                    layer.msg('修改成功！',{icon:1});
                                    layer.close(index)
                                    tableIns.config.where._ = new Date().getTime();
                                    tableIns.reload()
                                    parent.insTb.reload()
                                }
                            }

                        }
                    })
                    var level=parseInt($.GetRequest().level)+1
                    $.get('/ProjectInfo/getMaxNo',{model:'plcProjectBag',projectInfoNo:$.GetRequest().projectInfoNo,level:level},function (res) {
                        $('form input[name="bagNumber"]').val(res)
                    })
                    return false
                }
            })
        }
        function forlastId(list) {
            for (var i = 0; i < list.length; i++) {
                var chlist = list[i];
                if (chlist.bags && chlist.bags.length > 0) {
                    forlastId(chlist.bags);
                } else {
                    lastchildren+=chlist.pbagId+','
                }
            }
        }
    });
    //显示项目名称
    $.get('/ProjectInfo/selectProjectNameById',{projectId:$.GetRequest().projectId},function (res) {
        $('.header').html('项目名称:'+res.data)
    })
    //计算计划工期
    function timeRange(beginTime,endTime) {
        var t1=new Date(beginTime)
        var t2=new Date(endTime)
        var time=t2.getTime()-t1.getTime()
        var days=parseInt(time / (1000*60*60*24))+1
        return days
    }
    //将毫秒数转为yyyy-MM-dd格式时间
    function format(t) {
        if(t) return new Date(t).Format("yyyy-MM-dd");
        else return ''
    }
</script>
</body>
</html>
