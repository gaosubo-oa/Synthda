<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>产品入库</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/dest/layui.all.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/highcharts.js"></script>
    <style>
        * {font-family: "Microsoft Yahei" !important;overflow-y: hidden;}
        nav button{
            margin-left: 5px;
            padding: .25rem .5rem;
            font-size: .875rem;
            border-radius: .2rem;
            margin-top: 10px;
        }
        nav div{
            float: left !important;
            margin: 15px;
        }
        nav{
            height: 50px;
            border-bottom: 1px solid #cfdbe2;
            background-color: #fafbfc;
            border-radius: 0;
        }
        .layui-tab{
            margin:0;
        }
        .content{
            height: 544px;
            overflow: auto;
            margin: 14px;
            padding: 14px;
            background: #fff;
        }
        .layui-tab-content{
            background-color: #F5F7FA;
        }
        .search{
            display: inline;
            margin-bottom: 1px;
            width: 185px;
            border: 0;
            background: #fafbfc;
        }
        .allBtn{
            float: left !important;
            margin-top: 10px;
            width: 70px;

            border: none;
            background: #fafbfc;
        }
        .screen{
            float: left !important;
            margin-top: 10px;
            width: 70px;
            margin-left: 27px;
            border-radius: 5px;
            color: black;
            border-color: #03a9f4;
            background: #fafbfc;
            border: none;
        }
        .one{
            border: 1px solid #03a9f4;
            border-radius: 5px;
            color: #03a9f4;
            border-color: #03a9f4;
            background: #fafbfc;
        }
        div .layui-input-inline{
            padding-left: 25px;
        }
        .icons{
            vertical-align: middle;
            font-size: 20px;
            display: inline-block;
            margin-top: 10px;
        }
        .searinp{
            height: 35px;
            line-height: 44px;
            width: 125px;
            border-top: none;
            border-left: none;
            border-right: none;
            margin-top: 12px;
            margin-left: 8px;
        }
        .layui-table > tbody div[class*='0-11'] {
            overflow: visible !important;
        }

        #addTableDiv .layui-table-cell {
            overflow: visible !important;
        }
    </style>
</head>
<body>
<form class="layui-form layui-row">
    <div class="layui-col-md2" id="leftTree">
        <nav style="border-right: 1px solid #cfdbe2;" class="layui-collapse" lay-filter="leftTree">
            <span  class="screen  classBtn">产品分类</span>
            <input type="text" placeholder="仓库搜索" class="searinp"><i class="layui-icon layui-icon-search icons"></i>
        </nav>
        <div class="" style="border-right: 1px solid #ccc;">

        </div>
    </div>
    <div class="layui-col-md10">
        <nav>
            <i class="layui-icon layui-icon-prev" style="float: left;line-height: 50px;margin-left: 5px;color:#fafbfc "></i>
            <button type="button" class="layui-btn layui-btn-primary layui-btn-sm allBtn one classBtn">全部</button>
            <button type="button" class="layui-btn layui-btn-primary layui-btn-sm screen  classBtn">更多筛选</button>
            <button type="button" class="layui-btn layui-btn-normal layui-btn-sm iconView" style="float: right;margin-right: 30px">添加</button>
            <button type="button" class="layui-btn layui-btn-primary layui-btn-sm export" style="float: right;" >导出</button>
            <button type="button" class="layui-btn layui-btn-primary layui-btn-sm save" style="float: right;margin-right: 30px;display:none" >保存</button>
            <button type="button" class="layui-btn layui-btn-normal layui-btn-sm return" style=" float: right;display:none">返回</button>
        </nav>
        <div>
            <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                <div class="layui-tab-content">
                    <div class="content">
                        <%--表格--%>
                        <div class="tabContent">
                            <table class="layui-hide" id="test" lay-filter="test"></table>
                        </div>
                        <%--添加的内容--%>
                        <div class="addContent" style="display: none">
                            <div>
                                <button data-type="0" style="margin-left: 15px" type="button" id="addButton" class="layui-btn layui-btn-sm" lay-event="add"  />添加
                            </div>
                            <div id="addTableDiv" class="layui-card-body">
                                <table class="layui-hide" id="settlementOf" lay-filter="settlementOf"></table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
</body>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="search">查看</a>
</script>

<script>
    $('.layui-col-md3 div').height($(document.body).height());
    $('.content').height($(document.body).height()-50);
    var data=[];
    layui.use(['form', 'layedit', 'laydate','layedit','table','element'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate
            ,element = layui.element
            ,table = layui.table;
        table.render({
            elem: '#test'
            ,url:'/test/table/demo1.json'
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,title: '用户数据表'
            ,cols: [[
                {field:'username', title:'产品编号'}
                ,{field:'sex', title:'产品名称'}
                ,{field:'city', title:'产品品牌'}
                ,{field:'sign', title:'签名'}
                ,{field:'experience', title:'数量'}
                ,{field:'ip', title:'产品分类'}
                ,{field:'logins', title:'入库仓库'}
                ,{field:'joinTime', title:'入库时间'}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:150}
            ]]
            ,page: true
        });
        $('.searinp').on('click',function () {
            $('.searinp').css('border-bottom-color','#2F8AE3')
        })

        //右上角的添加
        $('.iconView').on('click',function(){
            $('.return').show() //返回
            $('.save').show()  //保存
            $('.export').hide() //导出
            $('.iconView').hide() //添加
            $('.tabContent').hide()
            $('.addContent').show()
        })
        $('.return').on('click',function () {
            $('.tabContent').show()
            $('.addContent').hide()
            $('.export').show()
            $('.iconView').show()
            $('.return').hide() //返回
            $('.save').hide()  //保存
        })
        //添加的表格
        table.render({
            elem: '#settlementOf'
            ,data:data
            ,cols: [[
                {field:'money' ,title: '入库产品',templet: function(d){
                        return '<div  id="flowTab">'+
                            ' <span></span>'+
                            ' <div style="display: inline-block;border-bottom: 1px solid #ccc;" class="flowTab">'+
                            '<input type="text" class="search" placeholder="搜索产品名称"/>'+
                            '<span style="padding: 5px;color: #999;cursor: pointer;">'+
                            '<i class="layui-icon layui-icon-add-circle flow-Tab"></i>'+
                            ' </span>'+
                            ' </div>'+
                            ' </div>'
                    }}
                ,{field:'projectType',title: '入库数量',event: 'type',templet: function (d) {
                        return '<select class="projectType" lay-filter="projectType" lay-verify="required" >\n' +
                            '<option value=""></option>\n'+
                            '<option value="0">收入</option>\n'+
                            '<option value="1">支出</option>\n'+
                            '      </select>';
                    }}
                ,{field:'payTime',title: '生产日期',event: 'date', data_field: "dDate"}
                ,{field:'payTime', title: '产品批次',edit:true}
                ,{field:'payWay',title: '入库仓库',event: 'type', templet: function (d) {
                        // 模板的实现方式也是多种多样，这里简单返回固定的
                        return '<select class="payWay" lay-filter="payWay" lay-verify="required" >\n' +

                            '      </select>';
                    }}
                ,{field:'runId',width:300,title: '关联流程',templet: function (d) {
                        return '<div  id="flowTab">'+
                            ' <span></span>'+
                            ' <div style="display: inline-block;border-bottom: 1px solid #ccc;" class="flowTab">'+
                            '<input type="text" class="search" placeholder="搜索"/>'+
                            '<span style="padding: 5px;color: #999;cursor: pointer;">'+
                            '<i class="layui-icon layui-icon-search flow-Tab"></i>'+
                            ' </span>'+
                            ' </div>'+
                            ' </div>'
                    }}
                ,{field:'remarks',  title: '关联合同',edit:true}
                , { title: '操作',  align: 'center', toolbar: '#settlementOfDel'}
            ]]
            ,page: true
            ,done:function (obj) {
                $('.laytable-cell-1-0-8').css("display","inherit")
                $('.flow-Tab').on('click',function () {
                    var num=$('.flow-Tab').index(this)
                    $(this).parents('#flowTab').attr('id','flowTab'+num)
                    layer.open({
                        type: 1,
                        title: ['选择流程'],
                        area: ['750px', '640px'],
                        shadeClose: true, //点击遮罩关闭
                        content: '<div>' +
                            '<input style="width: 200px;margin:20px 0 0 20px;padding-left: 10px;line-height: 30px" placeholder="请输入流程的标题"/><i class="layui-icon layui-icon-search flowIcon" style="margin-left: -30px"></i></div>' +
                            '<div style="margin:0 20px 0 20px;">' +
                            '<table class="layui-hide" id="flowTable"></table>' +
                            '</div>',
                        btn: ['确定']
                        , success: function (data) {
                            table.render({
                                elem: '#flowTable'
                                , url: '/contract/selectFlow'
                                , cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
                                , cols: [[
                                    {type: 'checkbox', fixed: 'left'}
                                    ,{field: 'runName', title: '流程标题'}
                                    , {field: 'userName', title: '创建人'}
                                    , {field: 'beginTime', title: '创建时间'}
                                ]]
                                ,page:true
                            });
                            $('.flowIcon').on('click',function () {
                                var search=$(this).siblings('input').val()
                                if($('.search')!=''){
                                    table.reload('flowTable',{
                                        url:'/contract/selectFlowBy',
                                        method: 'post',
                                        where:{
                                            cha:search
                                        }
                                    })
                                }
                            });
                        },
                        yes:function(index){
                            var checkStatus = table.checkStatus('flowTable')  // 打开页面中的table ID
                                ,data = checkStatus.data;     //  这个data一直为 []
                            if(data!=''){
                                var flowName=''
                                var flowTab='#flowTab'+num
                                for(var i=0;i<data.length;i++){
                                    runId+=nonEmpty(data[i].runId)+',';
                                    $('#flowTab'+num).children('span').html('');
                                    flowName+='<span style="margin-top: 0" class="spanText flowSpan">'+data[i].runName+'<a title="取消" num='+[i]+' class="flowcancelTab" style="cursor: pointer;color: darkgrey;padding-left:10px">×</a></span><br>'
                                }
                                $('#flowTab'+num).find('.flowTab').hide();
                                $('#flowTab'+num).children('span').append(flowName).append('<span class="add-item-Tab" style="vertical-align: 7px;"><i class="layui-icon layui-icon-add-circle"></i></span>');
                                $('#flowTab'+num).find('.add-item-Tab').on('click',function () {
                                    $('#flowTab'+num).find('.flowTab').show();
                                    $('#flowTab'+num).find('.add-item-Tab').hide();
                                });
                                $('#flowTab'+num).find('.flowcancelTab').on('click',function () {
                                    $(this).parent('.spanText').prev().remove()
                                    $(this).parent('.spanText').remove().prev().remove();
                                    if($(this).attr('num')==0){
                                        $('.flowTab').show();
                                        $('.add-item-Tab').hide();
                                    }
                                });
                                layer.close(index)
                            }
                        }
                    })
                })
                $.ajax({
                    url: '/order/selectByPayment',
                    type: 'get',
                    dataType: 'json',
                    success: function (data) {
                        var str = '<option value=""></option>'
                        for(var i=0;i<data.obj.length;i++){
                            str+= '<option value="' + data.obj[i].codeNo + '">' +  data.obj[i].codeName + '</option>'
                        }
                        $('.payWay').html(str)
                        form.render('select');
                    }
                });

            }
        });
        //第二个表格的工具事件
        table.on('tool(settlementOf)',function (obj) {
            var layEvent = obj.event; //获得 lay-event 对应的值
            var tr = obj.tr;
            var data = obj.data;
            var newdata = {};
            if (layEvent === 'date') {
                var field = $(this).data('field');
                var index=tr.attr("data-index");
                laydate.render({
                    elem: this.firstChild
                    , show: true //直接显示
                    , closeStop: this
                    ,type:'datetime'
                    , done: function (value, date) {
                        table.cache["settlementOf"][index][field]=value
                    }
                });
            }
            if(layEvent=='type'){
                var index=tr.attr("data-index");
                var field = $(this).data('field');
                form.on('select(payWay)', function (data) {
                    table.cache["settlementOf"][index][field]=data.value
                });
                form.on('select(projectType)', function (data) {
                    table.cache["settlementOf"][index][field]=data.value
                });
            }
            if(layEvent=='del2'){
                var index=tr.attr("data-index");
                obj.del(tr);
                data =  table.cache["settlementOf"];
                data.splice(parseInt(index),1);
                table.reload('settlementOf',{
                    data : data
                });
                var trs=$("#addTableDiv").find(".layui-table-body").find("tr");
            }

        });
        //添加按钮点击事件
        $("#addButton").on('click',function () {
            var type=$(this).attr("data-type");
            if(type=="0"){ //未点击
                //代表还未点击过添加
                data=[];//置空，默认一个
                table.reload('settlementOf',{
                    data : data
                });
                var $addTable=$("#addTableDiv");//得到第二个实例
                $(this).attr("data-type","1");
                $("#addButton").click();
            }else{
                data =  table.cache["settlementOf"];
//                console.log(data)
                var data1={}
                data.push(data1);
                table.reload('settlementOf',{
                    data : data
                });
                for(var i=0;i<data.length;i++){
                    console.log(data[i])
                    var select = 'dd[lay-value=' + data[i].projectType + ']';
                    $('.projectType').siblings("div .layui-form-select").find('dl').find(select).click()
                }
            }
        });
        var runId='';
        $('.localAet').on('click',function () {
            layer.open({
                type: 1,
                title: ['合同选择'],
                area: ['750px', '640px'],
                shadeClose: true, //点击遮罩关闭
                content: '<div>' +
                    '<input style="width: 200px;margin:20px 0 0 20px;padding-left: 10px;line-height: 30px" type="text" placeholder="请输入合同编号或标题"/><i class="layui-icon layui-icon-search subIcon" style="margin-left: -45px"></i></div>' +
                    '<div style="margin:0 20px 0 20px;">' +
                    '<table class="layui-hide" id="subcontract"></table>' +
                    '</div>',
                btn: ['确定']
                , success: function (data) {
                    table.render({
                        elem: '#subcontract'
                        , url: '/contract/selectContractZi'
                        , cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
                        , cols: [[
                            {type: 'checkbox', fixed: 'left'}
                            ,{field: 'contractNo', title: '合同编号'}
                            , {field: 'title', title: '合同标题'}
                            , {field: 'createTime', title: '创建时间'}
                        ]]
                        ,page: true,
                    });
                    $('.subIcon').on('click',function () {
                        var search=$(this).siblings('input').val()
                        if(search=''){
                            table.reload('subcontract',{
                                url:'/contract/selectContractZiBy',
                                method: 'post',
                                where:{
                                    cha:search
                                }
                            })
                        }
                    });
                },
                yes:function(index){
                    var checkStatus = table.checkStatus('subcontract')  // 打开页面中的table ID
                        ,data = checkStatus.data;     //  这个data一直为 []
                    if(data!=''){
                        var str='';
                        var contractId='';
                        for(var i=0;i<data.length;i++){
                            contractId+=data[i].contractId+','
                            $('#local span:eq(0)').html('')
                            str+='<span class="spanText flowSpan">'+data[i].title+'<a title="取消" num='+[i]+' class="flowcancel" style="cursor: pointer;color: darkgrey;padding-left:10px">×</a></span>'
                        }
                        $('.save').attr('contractId',contractId)
                        $('.local').hide();
                        $('#local span:eq(0)').append(str).append('<span class="add-item" style="vertical-align: 7px;"><i class="layui-icon layui-icon-add-circle"></i></span>');
                        $('.add-item').on('click',function () {
                            $('.local').show();
                            $('.add-item').hide();
                        });
                        $('.flowcancel').on('click',function () {
                            $(this).parents('.spanText').remove();
                            if($(this).attr('num')==0){
                                $('.local').show();
                                $('.add-item').hide();
                            }
                        });
                        layer.close(index)
                    }
                }
            })
        })
        function nonEmpty(num) {
            if(num==''||num==undefined){
                return ''
            }else{
                return num
            }
        }
    });


</script>

</html>
