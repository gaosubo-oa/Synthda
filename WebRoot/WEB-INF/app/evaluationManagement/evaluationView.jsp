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
    <title>查看评价</title>
    <link rel="stylesheet" type="text/css" href="../../lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="../../lib/layui/layui/layui.js"></script>
<%--    <script type="text/javascript" src="../../js/xoajq/xoajq2.js"></script>--%>
    <script type="text/javascript" src="../../lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <style>
        * {font-family: "Microsoft Yahei" !important;}
        .add{
            margin-top: 10px;
            margin-left: 10px;
        }
        .layui-layer-btn .layui-layer-btn1{
            background: #009688;
            color: #fff;
        }
        #Settlement{
            table-layout: fixed;
            border-collapse: collapse;
            width: 100%;
        }
        .layui-body{overflow-y: scroll;}
        #pensons .layui-table-cell {
            font-size:14px;
            padding:0 5px;
            height:auto;
            overflow:visible;
            text-overflow:inherit;
            white-space:normal;
            word-break: break-all;
            text-align: center;
        }
        .layui-table-view .layui-table td, .layui-table-view .layui-table th:nth-child(8){
            width: 100px;
        }
        a{
            color: blue;
        }
        .layui-textarea {
            min-height: 35px;
            width: 300px;
            height: 35px;
            margin-top: 2px;
            /*padding: 6px 10px;*/
            resize: vertical;
            line-height: 20px;
        }
        .layui-input-block{
            width: 100px;
        }
        .layui-rate {
            padding: 0;
            font-size: 0;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<p>
<span class="layui-btn layui-btn-primary" style="background-color: #009688; color: white;" >查看评价</span>
<span class="layui-btn layui-btn-primary" id="fenxi">评价分析</span>
</p>

<form class="layui-form" action="" style="margin-top: 15px">
    <div class="layui-inline layui-form-text">
        <label class="layui-form-label">选择部门：</label>
        <div class="layui-input-inline">
            <textarea  placeholder="请选择部门" deptid="" style="width: 200px" readonly name="textUser" id="textUser" class="layui-textarea"></textarea>
        </div>
        <span style="color: red">*</span>
        <a href="javascript:;" class="governor" id="market_pop"><fmt:message code="global.lang.add"/></a>
        <a href="javascript:;" class="clearTwo" onclick="market_pop()"><fmt:message code="global.lang.empty"/></a>
    </div>

    <div class="layui-inline" style="margin-left: 50px">
        <div class="layui-input-inline" style="display: flex">
            <label class="layui-form-label">综合评价：</label>
            <select name="evLevel" id="evLevel" lay-verify="required">
                <option value="">请选择</option>
                <option value="1">优秀</option>
                <option value="2">一般</option>
                <option value="3">黑名单</option>
            </select>
        </div>
    </div>

    <div class="layui-inline" >
        <label class="layui-form-label">姓名：</label>
        <div class="layui-input-inline">
            <input type="text" name="xingming" style="width: 200px" id="userName"placeholder="请输入" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-inline" style="margin-top: 10px;" >
        <label class="layui-form-label">所在项目：</label>
        <div class="layui-input-inline">
            <input type="text" name="xiangmu" id="xiangmu" style="width: 200px" placeholder="请输入" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-inline" style="">
        <div class="layui-input-inline" style="    margin-left: 10px;
    margin-top: 10px">
            <button type="button" class="layui-btn" id="insert">查询</button>
            <button type="button" class="layui-btn" id="print" >导出</button>
        </div>
    </div>
    <table id="test" lay-filter="SettlementFilter1"></table>
</form>

<script type="text/javascript">
    $("#fenxi").on("click",function (){
        window.location.href="/hrEvaluate/evaluationAnalysis";
    })
    var dept_id = '';
    $('#market_pop').on("click",function () {
        dept_id = 'textUser';
        $.popWindow("../common/selectDept?0");
    });
    //清除数据
    function market_pop() {
        $('#textUser').attr('deptid', '');
        $('#textUser').val('');
    }
    var laydate;
    var table = layui.table;
    layui.use('form', function(){
        var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
        //但是，如果你的HTML是动态生成的，自动渲染就会失效
        //因此你需要在相应的地方，执行下述方法来手动渲染，跟这类似的还有 element.init();
        form.render();
    });
    layui.use(['table','form','rate'], function(){
        var rate = layui.rate;
        var form = layui.form;
        var table = layui.table;
        laydate = layui.laydate;
        var tableIns = table.render({
            elem: '#test'
            ,url:'/hrEvaluate/selectByUserId'
            ,cols: [[
                {field:'userName', title:'姓名',fixed: 'left',width:'10%'}
                ,{field:'evLevel', title:'综合评价',templet: evLevelName, edit: 'text',width:'10%'}
                ,{field: 'evSkill',title: '工作技能',templet:function (a) {
                    return '<div id="evSkill'+a.evId+'"></div>'
                },width:'13%'}
                ,{field:'evAttitude', title:'工作态度',templet:function (a) {
                    return '<div id="evAttitude'+a.evId+'"></div>'},width:'13%'}
                ,{field: 'project',title: '所在项目',edit: 'text',width:'10%'}
                ,{field:'evDetail', title:'详细评价',edit: 'text',width:'10%'}
                ,{field:'attachmentName', title: '评价文件',align:'left', templet: function (a) {
                    if (a.attachmentList != undefined) {
                        var data = a.attachmentList
                        var stra2 = '';
                        for (var i = 0; i < data.length; i++) {
                            var fileExtension = data[i].attachName.substring(data[i].attachName.lastIndexOf(".") + 1, data[i].attachName.length);//截取附件文件后缀
                            var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                            var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + data[i].size;
                            stra2 += '<div class="dech" deUrl="' + deUrl + '">' +
                                '<a NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
                                '<img  src="/img/attachment_icon.png"/>' + data[i].attachName + '</a>' +
                                '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' +
                                '<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px">' +
                                '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                '<a class="download" style="padding-left: 5px;" href="/download?' + encodeURI(deUrl) + '" >' +
                                '<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
                                '<input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +
                                '</div>'
                            <%--str += '<div class="dech" deUrl="' + encodeURI(arrAttach[i].attUrl)+ '"><a href="/download?'+encodeURI(arrAttach[i].attUrl)+'" NAME="' + arrAttach[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + arrAttach[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + arrAttach[i].aid + '@' + arrAttach[i].ym + '_' + arrAttach[i].attachId + ',"></div>';--%>
                        }
                        return stra2
                    } else {
                        return ' '
                    }
                },width:'12%'},
                ,{field: 'evUserName',title: '评价人',edit: 'text',width:'10%'}
                ,{field:'evTime', title:'评价时间', edit: 'text',width:'10%',templet: function(d){
                    return  d.evTime.slice(0,-2)
                }}
                ,{field: 'deptName',title: '部门',edit: 'text',width:'10%'}
                ,{field: 'jobName',title: '岗位',edit: 'text',width:'10%'}
                ,{field: 'postName',title: '职位',edit: 'text',width:'10%'}
                ,{field: 'mobilNo',title: '手机号',edit: 'text',width:'10%'}
                ,{field: 'evId',title: '操作',width:'5%',align:'center',templet:function (d){
                    if (d.deletePriv == 1){
                        return '<a class="layui-btn layui-btn-xs layui-bg-orange " lay-event="delete" id="delete">删除</a>';
                    } else {
                        return '';
                    }
                }}
            ]]
            ,done:function(res, curr, count){
                var data = res.data;//返回的json中data数据
                for (var item in data) {
                    var evSkill=data[item].evSkill/2
                    var evAttitude=data[item].evAttitude/2
                    rate.render({
                        elem: '#evSkill'+data[item].evId+''         //绑定元素
                        , length: 5            //星星个数
                        , value:  evSkill          //初始化值
                        , readonly: true      //只读
                        , half: true
                    });
                    rate.render({
                        elem: '#evAttitude'+data[item].evId+''         //绑定元素
                        , length: 5            //星星个数
                        , value:  evAttitude          //初始化值
                        , readonly: true      //只读
                        , half: true
                    });
                }
            }
            ,page: true
        });

        table.on('tool(SettlementFilter1)', function(obj){//注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            if(layEvent === 'delete'){
                layer.confirm('是否确定删除？', {
                    btn: ['确定', '取消'], //按钮
                    title: "是否确定删除"
                }, function () {
                    $.ajax({
                        url: '/hrEvaluate/deleteByEvaluatesId',
                        type: 'get',
                        data:{
                            evId: data.evId
                        },
                        dataType: 'json',
                        success: function (result) {
                            if(result.flag) {
                                $.layerMsg({content: '删除成功！', icon: 1}, function () {
                                    location.reload();
                                });
                            }else{
                                $.layerMsg({content: '删除失败！', icon: 1}, function () {
                                });
                            }
                        }
                    })
                }, function () {
                    layer.closeAll();
                });
            }
        });

        $('#insert').on("click",function(){
            // location.reload();
            var currentPage=1;
            table.reload('test',{
                    url : '/hrEvaluate/selectByUserId',
                    data:{page:currentPage},
                    page:{
                        curr:currentPage
                    },
                    where:{
                        deptId:$('#textUser').attr('deptid'),
                        project:$('#xiangmu').val(),
                        evLevel:$('#evLevel').val(),
                        userName:$('#userName').val()
                    }
                })

            })

        $('.inquire').on("click",function () {
            if($("#textUser").val()==''){
                var deptId=''
            }else{
            var deptId=$("#textUser").attr('deptid');
            }
            var evLevel= $('[name="evLevel"] option:selected').val()
            var xingming= $('input[name="xingming"]').val()
            var xiangmu= $('input[name="xiangmu"]').val()
            table.reload('test', {
                where: {
                    deptId: deptId,
                    evLevel:evLevel,
                    userName:xingming,
                    project:xiangmu,
                },page: {
                    curr: 1
                }
            })
        });
        //实时获取现在时间
        function date(){

        }


    });

    function evLevelName(data) {
        var evLevel = data.evLevel;
        if (evLevel == 1) {
            return "优秀";
        }else if(evLevel == 2){
            return "一般 ";
        }else if(evLevel == 3){
            return "黑名单";
        }else {
            return "";
        }
    }
    $(document).on('click', '.deImgs', function () {
        var _this = this;
        var attUrl = $(this).parents('.dech').attr('deUrl');
        layer.confirm('确定删除该附件吗？', function (index) {
            $.ajax({
                type: 'get',
                url: '/delete?' + attUrl,
                dataType: 'json',
                success: function (res) {
                    if (res.flag == true) {
                        layer.msg('删除成功', {icon: 6, time: 1000});
                        $(_this).parent().remove();
                    } else {
                        layer.msg('删除失败', {icon: 2, time: 1000});
                    }
                }
            })
        });
    });
    $('#print').on("click",function(){
        window.location.href= '/hrEvaluate/hrEvaluateFileExport?userName='+$('#userName').val()+'&evLevel='+$('#evLevel').val()+'&project='+$('#xiangmu').val()+'&deptId='+$('#textUser').attr('deptid');
    })

</script>

</body>
</html>