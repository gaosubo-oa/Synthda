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
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>工作日志</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20190817.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918.09" type="text/javascript" charset="utf-8"></script>
    <style>
        html,body{
            background: #fff;
        }
        .layui-card-header{
            border-bottom: 1px solid #eee;
        }
        .mbox{
            padding: 0px;
        }
        .inbox{
            padding: 5px;
            padding-right: 30px;
        }
        .deptinput{
            display: inline-block;
            width: 75%;
        }
        .layui-btn{
            margin-left: 10px;
        }
        .layui-btn .layui-icon{
            margin-right: 0px;
        }
        .red{
            color: red;
            font-size: 16px;
        }
        .layui-form-label{
            padding: 8px 15px;
        }
        .layui-card-body{
            display: flex;
        }
        .layui-lf{
            min-width: 16%;
            overflow-x: auto;
            height: 600px !important;
        }
        .layui-rt{
            width: 84%;
            margin-left: 6px;
            margin-top:0px;
        }
        .treeTitle{
            display: flex;
            box-sizing: border-box;
            justify-content: center;
            align-items: center;
            width: 100%;
            height: 30px;
            background-color: #00a0e9;
            color: #fff;
            padding: 15px;
            position: relative;
        }
        .layui-nav-item,.layadmin-flexible{
            position: absolute;
            left: 5px;
            top: 23px;
            z-index: 9999999;
        }
        .rtfix{
            width:200px;
            overflow-x: scroll;
        }
        .bg{
            background-color: #F2F2F2;
        }
        .bgs{
            background-color: #F2F2F2;
        }
        .back{
            background-color: #ccc;
        }
        /*滚动条样式*/
        /*.rtfix::-webkit-scrollbar {!*滚动条整体样式*!*/
        /*width: 4px;     !*高宽分别对应横竖滚动条的尺寸*!*/
        /*height: 10px;*/
        /*}*/
        /*.rtfix::-webkit-scrollbar-button{*/
        /*background-color: #000;*/
        /*border:1px solid #ccc;*/
        /*display:block;*/
        /*}*/
        /*.rtfix::-webkit-scrollbar-thumb {!*滚动条里面小方块*!*/
        /*border-radius: 5px;*/
        /*-webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);*/
        /*background: rgba(0,0,0,0.2);*/
        /*}*/
        /*.rtfix::-webkit-scrollbar-track {!*滚动条里面轨道*!*/
        /*-webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);*/
        /*border-radius: 0;*/
        /*background: rgba(0,0,0,0.1);}*/
        .eleTree{
            cursor: pointer;
        }
        .layui-table-view .layui-table td, .layui-table-view .layui-table th{
            padding: 3px 0;
        }
        .layui-tab layui-tab-card{
            margin-top: -4px;
        }
        .layui-tab-card>.layui-tab-title .layui-this:after {
            border-width: 0px;
        }
        .baseinfo td{
            padding: 5px 2px;
        }
        .active{
            display: none;
        }
        .back{
            background-color: #F2F2F2;
        }
        .layui-colla-item {
            position: relative;
        }
        .layui-collapse .layui-card-body{
            padding: 0 8px;
        }
        .repairLable{
            padding: 8px 15px;
            text-align: right;
            vertical-align: middle;
        }
        .layui-form-select dl dd{
            height: 32px;
            line-height: 32px;
        }
        .layui-form-select .layui-select-title .layui-input{
            height: 32px;
        }
        #formTest .layui-form-select input,#lendListTest .layui-form-select input{
            height: 32px;
        }
        .layui-input{
            height: 32px !important;
        }
        .layui-form-item{
            margin-bottom: 5px; !important;
        }
        .layui-form-label{
            width: 70px; !important;
        }
        .textAreaBox{
            width: 100%;
            max-width: 100%;
            cursor: pointer;
            margin: 0px;
            overflow-y:visible;
            min-height: 37px;
        }
    </style>
</head>
<body>
<div class="mbox">
                <div id="clientSerch" style="height: 40px">
                    <%--表格上方搜索栏--%>
                    <form class="layui-form" action="" style="height: 40px">
                        <div class="demoTable" style="height: 40px" >
                            <label style="float: left;height: 40px;line-height: 40px;margin: 0 10px;padding: 0 10px">查询字段</label>
                            <div class="layui-input-inline" style="float:left;margin-top: 4px">
                                <select name="serchSelect" id="serchSelect" lay-filter="columnName" placeholder="请选择" lay-search="" style="height: 10px">
                                    <option value="0">请选择查询字段</option>
                                    <option value="planName">工作计划名称</option>
                                    <option value="fillingDate">填报时间</option>
                                    <option value="planCompletionStatus">完成状态</option>
                                </select>
                            </div>
                            <div class="layui-input-inline" style="float: left;height: 32px;margin-top: 4px;">
                                <input class="layui-input" id="planName" autocomplete="off"  name="planName" style="height: 38px;margin-left: 6px;">
                                <input class="layui-input" id="fillingDate" autocomplete="off"  name="fillingDate" style="display:none;height: 38px;margin-left: 6px;">
                                <div id="selha" style="display: none">
                                    <select name="planCompletionStatus" id="planCompletionStatus" >
                                        <option value="">请选择</option>
                                        <option value="0">全部完成</option>
                                        <option value="1">部分完成</option>
                                        <option value="10">未启动</option>
                                    </select>
                                </div>
                            </div>
                            <div class="layui-input-inline" style="float: left;height: 32px;margin-top: 4px;">
                                <a class="layui-btn" data-type="reload" lay-event="searchCust" id="searchCust" style="float:left;height:32px;line-height: 32px;margin-left: 10px">搜索</a>
                            </div>
                        </div>
                    </form>
                </div>
                <table id="Settlement" lay-filter="SettlementFilter"></table>
</div>
<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="addTest" style="width: 60px">填报</button>
        <%--		<button class="layui-btn layui-btn-sm" lay-event="delTest" style="width: 60px">删除</button>--%>
        <%--		<button class="layui-btn layui-btn-sm" lay-event="upfile" style="width: 100px" id="">导入</button>--%>
        <%--		<button class="layui-btn layui-btn-sm" lay-event="delete" style="width: 60px">导出</button>--%>
    </div>
</script>
<script type="text/html" id="barOperation">
    <a class="layui-btn layui-btn-xs" lay-event="check" >修改</a>
</script>
<script type="text/html" id="formTable1toolbar2">
    <div class="layui-btn-container" style="height: 30px;">
        <input type="button" class="layui-btn layui-btn-sm" lay-event="addTest" value="新增">
        <input type="button" class="layui-btn layui-btn-sm" lay-event="delTest" value="删除">
    </div>
</script>
<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>

<script type="text/javascript">
    var user_id;
    var detailsInit;
    var detailsInitData=[];
    var detailsInit2;
    var detailsInitData2=[];
    var dept_id;
    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
    }
    var columnId = parent.columnTrId;//getUrlParam('columnId');
    var SettlementTable;
    var SettlementTable1;

    layui.use(['table','layer','form','element','eleTree','upload','laydate'], function() {
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var eleTree = layui.eleTree;
        var element = layui.element;
        var $ = layui.jquery;
        var upload = layui.upload;
        var laydate = layui.laydate;

        $(document).on("click","#rectificationPersion",function(){ //整改人
            user_id = "rectificationPersion";
            $.popWindow("/projectTarget/selectOwnDeptUser?0");
        })

        $(document).on("click","#acceptancePersion",function(){ //验收人
            user_id = "acceptancePersion";
            $.popWindow("/projectTarget/selectOwnDeptUser?0");
        })
        $(document).on('click', '#testDept', function () {
            dept_id = "testDept";
            $.popWindow("/common/selectDept?0");
        });
        $(document).on('click', '#testLeader', function () {
            user_id = "testLeader";
            $.popWindow("/projectTarget/selectOwnDeptUser?0");
        })

        //工作日志

        form.on('select(columnName)',function (data) {
            if(data.value=="fillingDate"){
                laydate.render({
                    elem: '#fillingDate'
                    , trigger: 'click'
                    , format: 'yyyy-MM-dd'
                    // , format: 'yyyy-MM-dd HH:mm:ss'
                });
                $("#planName").hide();
                $("#fillingDate").show();
                $("#selha").hide();
            }else if(data.value=="planName") {
                $("#fillingDate").hide();
                $("#planName").show();
                $("#selha").hide();
            }else if(data.value=="planCompletionStatus"){
                $("#planName").hide();
                $("#fillingDate").hide();
                $("#selha").show();
            } else{
                $("#planName").show();
                $("#fillingDate").hide();
                $("#selha").hide();
            }
        })
        //头工具栏事件
        $('#searchCust').click(function () {
            var serchSelect = $("#serchSelect").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value"); //下拉列表的值
            var searchtext = "";
            var serchObjUrl = "/subscribe/search?"+serchSelect+"="+searchtext;
            if(serchSelect == "planName"){
                searchtext = $("#planName").val();
                if((searchtext==''&&serchSelect=='0') || (searchtext==''&&serchSelect==0)){ //两个都为空查询全部
                    serchObjUrl = "/workflow/workLog/getWorkPlan";//重载表格
                }else if((searchtext!=""&&serchSelect=='0') || (searchtext!=""&&serchSelect==0)){ //只输入，没有选择
                    layer.msg("请选择查询条件");
                }else{
                    serchObjUrl = "/workflow/workLog/getWorkPlan?"+serchSelect+"="+searchtext;//重载表格
                }
            }else if(serchSelect == "fillingDate"){
                searchtext = $("#fillingDate").val(); //输入框的值
                if((searchtext==''&&serchSelect=='0') || (searchtext==''&&serchSelect==0)){ //两个都为空查询全部
                    serchObjUrl = "/workflow/workLog/getWorkPlan";//重载表格
                }else if((searchtext!=""&&serchSelect=='0') || (searchtext!=""&&serchSelect==0)){ //只输入，没有选择
                    layer.msg("请选择查询条件");
                }else{
                    serchObjUrl = "/workflow/workLog/getWorkPlan?"+serchSelect+"="+searchtext;//重载表格
                }
            }else if(serchSelect == "planCompletionStatus"){
                searchtext = $("#planCompletionStatus").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value");
                searchtext = searchtext==undefined?"":searchtext
                if((searchtext==''&&serchSelect=='0') || (searchtext==''&&serchSelect==0)){ //两个都为空查询全部
                    serchObjUrl = "/workflow/workLog/getWorkPlan";//重载表格
                }else if((searchtext!=""&&serchSelect=='0') || (searchtext!=""&&serchSelect==0)){ //只输入，没有选择
                    layer.msg("请选择查询条件");
                }else{
                    serchObjUrl = "/workflow/workLog/getWorkPlan?"+serchSelect+"="+searchtext;//重载表格
                }
            }else{
                layer.msg("请选择查询条件");
            }
            table.reload("Settlement",{
                url: serchObjUrl
            });
        })
        // 树右侧表格实例
        SettlementTable = layui.table.render({
            elem: '#Settlement'
            // , data: []
            , url: '/workflow/workLog/getWorkPlan'//数据接口
            , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                , first: false //不显示首页
                , last: false //不显示尾页
            } //开启分页
            , toolbar: '#toolbar'
            , cols: [[ //表头
                {field: 'workPlanId', title: 'ID',width:50}
                , {field: 'planName', title: '工作计划名称',event: 'detail', style:'cursor: pointer;color:blue'}
                , {field: 'planCompletionStatus', title: '完成状态',templet:function(d){
                        if(d.planCompletionStatus=="0"){
                            return "全部完成";
                        }else if(d.planCompletionStatus=="1"){
                            return "部分完成";
                        }else if(d.planCompletionStatus=="10"){
                            return "未启动";
                        }
                    }}
                , {field: 'weather', title: '天气'}
                , {field: 'fillingDate', title: '填报时间'}
                // ,{width:100, title: '操作',align:'center', toolbar: '#barOperation'}
            ]]
            , limit: 10
            , done: function (res) {
            }
        });
        table.on('tool(SettlementFilter)', function(obj){
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
            console.log(data)
            if (layEvent === 'detail') { //详情
                var createTime=data.createTime;
                var datatime= new Date(Date.parse(createTime.replace(/-/g,  "/")));    //转换成Data();
                var datayear=datatime.getFullYear();
                var datamonth=datatime.getMonth()+1;
                var dataday=datatime.getDate();
                var contenttime=datayear+"-"+datamonth+"-"+dataday;
                var nowdate=new Date();
                var nowdatayear=nowdate.getFullYear();
                var nowdatamonth=nowdate.getMonth()+1;
                var nowdataday=nowdate.getDate();
                var nowcontenttime=nowdatayear+"-"+nowdatamonth+"-"+nowdataday;
                var datatype;
                if (contenttime==nowcontenttime){
                    window.location.href="/workflow/workLog/workLogApp?workPlanId="+data.workPlanId+"&datatype=0"
                }else {
                    window.location.href="/workflow/workLog/workLogApp?workPlanId="+data.workPlanId+"&datatype=1"
                }
            }
        })

        //表格头工具事件
        table.on('toolbar(SettlementFilter)', function(obj){
            var checkStatus = table.checkStatus("Settlement").data;
            var event = obj.event;
            switch(event){
                case 'addTest': //填报日志
                    //执行新增工作计划
                    var logIndex = layer.load(1);
                    var workPlanId;
                    var datatype;
                    $.ajax({
                        url:"/workflow/workLog/insertWorkPlan",
                        dataType:"json",
                        async: false,
                        success:function(res){
                            layer.close(logIndex);
                            if(res.code==="0"||res.code===0){
                                workPlanId = res.obj;
                            }else{
                                layer.msg(res.msg);
                            }
                        }
                    })

                    // var workPlanId=checkStatus[0].workPlanId;
                    window.location.href="/workflow/workLog/workLogApp?workPlanId="+workPlanId+"&datatype=0";
                    break;

                case 'delete':  //多条删除
                    if(checkStatus.length == 0){
                        layer.msg("请选中一条或多条数据，进行删除");
                        return false;
                    }else{
                        var docfileIds = "";
                        for(var i=0;i<checkStatus.length;i++){
                            docfileIds += checkStatus[i].docfileId+",";
                        }
                        layer.confirm('确定要删除吗？', function(index){
                            $.ajax({
                                type: "post",
                                url: '/fileManage/delFile',
                                dataType: "json",
                                data:{
                                    columnIds:docfileIds
                                },
                                success:function (res) {
                                    if(res.code == "0" || res.code == 0){
                                        SettlementTable.reload();
                                    }
                                    layer.msg(res.msg);
                                }
                            })
                            layer.close(index);
                        });
                    }
                    break;
            };
        });

        //日志查询
        SettlementTable1 = layui.table.render({
            elem: '#Settlement1'
            // , data: []
            , url: '/workflow/workLog/getWorkPlan'//数据接口
            , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                , first: false //不显示首页
                , last: false //不显示尾页
            } //开启分页
            //, toolbar: '#toolbar'
            , cols: [[ //表头
                {type: 'checkbox'}
                , {field: 'workPlanId', title: 'ID',width:50}
                , {field: 'planName', title: '工作计划名称'}
                , {field: 'planCompletionStatus', title: '完成状态',templet:function(d){
                        if(d.planCompletionStatus=="0"){
                            return "全部完成";
                        }else if(d.planCompletionStatus=="1"){
                            return "部分完成";
                        }else if(d.planCompletionStatus=="10"){
                            return "未启动";
                        }
                    }}
                , {field: 'weather', title: '天气'}
                , {field: 'fillingDate', title: '填报时间'}
                // ,{width:100, title: '操作',align:'center', toolbar: '#barOperation'}
            ]]
            , limit: 10
            , done: function (res) {
            }
        });

    })

    function childFunc(){
        columnId = parent.columnTrId
        SettlementTable.reload({
            url: '/fileManage/getFile?columnIds='+columnId//数据接口
        });
    }
    function lookFile(repalogId){//查看附件
        if (repalogId == undefined || repalogId == "") {
            layer.msg("文件已被损坏，无法查看");
        } else {
            selectFile1(repalogId,'knowlage');
            //window.location.href = "/equipment/limsDownload?model=" + model + "&attachId=" + attachId  下载
        }
    }
    //查看附件
    function selectFile1(attchId,model) {
        if(attchId){
            //查看附件
            var data={
                attachId:attchId,
                model:model
            }
            var res=toAjaxT1("/equipment/selectAttchUrl",data);
            if(res.code==0){
                if(res.object){
                    limsPreview1(res.object);
                }
            }
        }

    }
    //附件预览点击调取
    function limsPreview1(attrUrl) {
        var url = '';
        if(attrUrl != undefined&&attrUrl.indexOf('&ATTACHMENT_NAME=') > -1){
            var atturl1 = attrUrl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
            var atturl2 = '';
            if(attrUrl.split('&ATTACHMENT_NAME=')[1] != undefined&&attrUrl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1){
                for(var i=1;i<attrUrl.split('&ATTACHMENT_NAME=')[1].split('&').length;i++){
                    atturl2 += '&' + attrUrl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
                }
                url = atturl1 + atturl2;
            }else{
                url = atturl1;
            }
        }
        if(limsUrlGetRequest('?'+attrUrl) == 'pdf' || limsUrlGetRequest('?'+attrUrl) == 'PDF'){
            layui.layer.open({
                type: 2,
                title: '预览',
                offset:["20px",""],
                content: "/pdfPreview?"+url,
                area: ['80%', '80%']
            })
            // $.popWindow("/pdfPreview?"+url,PreviewPage,'0','0','1200px','600px');
        }else if(limsUrlGetRequest('?'+attrUrl) == 'png' || limsUrlGetRequest('?'+attrUrl) == 'PNG'|| limsUrlGetRequest('?'+attrUrl) == 'jpg' || limsUrlGetRequest('?'+attrUrl) == 'JPG'|| limsUrlGetRequest('?'+attrUrl) == 'txt'|| limsUrlGetRequest('?'+attrUrl) == 'TXT'){
            layui.layer.open({
                type: 2,
                title: '预览',
                content: "/xs?"+url,
                offset:["20px",""],
                area: ['80%', '80%'],
                success:function(layero, index){
                    var iframeWindow = window['layui-layer-iframe'+ index];
                    var doc = $(iframeWindow.document);
                    doc.find('img').css("width","100%");
                }
            })
            // $.popWindow("/xs?"+url,PreviewPage,'0','0','1200px','600px');
        }else{
            pdurl1(limsUrlGetRequest('?'+attrUrl),attrUrl)
            // $.ajax({
            //     type:'get',
            //     url:'/sysTasks/getOfficePreviewSetting',
            //     dataType:'json',
            //     success:function (res) {
            //         if(res.flag){
            //             var strOfficeApps = res.object.previewUrl;//在线预览服务地址
            //             if(strOfficeApps == ''){
            //                 strOfficeApps = 'https://view.officeapps.live.com';
            //             }
            //             layui.layer.open({
            //                 type: 2,
            //                 title: '预览',
            //                 offset:["20px",""],
            //                 content: strOfficeApps+'/op/view.aspx?src='+domains+'/download?'+encodeURIComponent(url),
            //                 area: ['80%', '80%']
            //             })
            //             // $.popWindow(strOfficeApps+'/op/view.aspx?src='+domains+'/download?'+encodeURIComponent(url),'','0','0','1200px','600px')
            //         }
            //     }
            // })

        }
    }
    //同步
    function toAjaxT1(url,data) {
        var result;
        $.ajax({
            url:url,
            data:data,
            type: 'post',
            async:false,
            dataType: 'json',
            success: function (res){
                result=res;
            }
        });
        return result;
    }
    //截取附件文件后缀
    function limsUrlGetRequest(name) {
        var attach=name
        return attach.substring(attach.lastIndexOf(".")+1,attach.length);
    }
    function pdurl1(gs,atturl){ //根据后缀判断选择调取那种打开方式
        if(atturl != undefined&&atturl.indexOf('&ATTACHMENT_NAME=') > -1){
            var atturl1 = atturl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
            var atturl2 = '';
            if(atturl.split('&ATTACHMENT_NAME=')[1] != undefined&&atturl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1){
                for(var i=1;i<atturl.split('&ATTACHMENT_NAME=')[1].split('&').length;i++){
                    atturl2 += '&' + atturl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
                }
                atturl = atturl1 + atturl2;
            }else{
                atturl = atturl1;
            }
        }
        if(gs == 'png'||gs == 'jpg'||gs == 'bmp' || gs == 'emf' || gs == 'gif'|| gs == 'pcx'|| gs == 'pcd'|| gs == 'ai'|| gs == 'webp'|| gs == 'WMF'|| gs == 'dxf' ||gs == 'PNG'||gs == 'JPG'||gs == 'BMP' || gs == 'EMF' || gs == 'GIF'|| gs == 'PCX'|| gs == 'PCD'|| gs == 'AI'|| gs == 'WEBP'|| gs == 'wmf'|| gs == 'DXF'|| gs == 'txt'|| gs == 'TXT'){
            $.popWindow("/xs?"+atturl,PreviewPage,'0','0','1200px','600px');
        }else if(gs == 'mp4'||gs == 'rmvb'||gs == 'avi'||gs == 'ifo'||gs == 'wmv'||gs == 'MP4'||gs == 'RMVB'||gs == 'AVI'||gs == 'IFO'||gs == 'WMV'){
            layer.open({type: 2, title: false, area: ['630px', '360px'], shade: 0.8, closeBtn: 0, shadeClose: true, content: "/common/video?videoatturlsplit="+atturl});
            layer.msg('点击任意处关闭');
        }else if(gs == 'pdf'||gs == 'PDF'){
            $.popWindow("/pdfPreview?"+atturl,PreviewPage,'0','0','1200px','600px');
        }else{
            var url = "/common/webOfficeView?documentEditPriv=0&fomat="+gs+"&"+atturl;
            $.ajax({
                url:'/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
                type:'post',
                datatype:'json',
                async:false,
                success: function (res) {
                    if(res.flag){
                        if(res.object[0].paraValue == 0){
                            //默认加载NTKO插件 进行跳转
                            url = "/common/ntkoview?documentEditPriv=0&fomat="+gs+"&"+atturl;
                        }else if(res.object[0].paraValue == 2){
                            //默认加载NTKO插件 进行跳转
                            url = "/wps/info?"+ atturl +"&permission=read";
                        }
                    }

                }
            })
            setTimeout(function(){
                $.popWindow(url,PreviewPage,'0','0','1200px','600px');
            }, 1000);
        }
    }
    function undefind_nullStr(value) {
        if(value==undefined){
            return ""
        }
        return value
    }
    function getAttachIds(obj) {
        return obj.aid+"@"+obj.ym+"_"+obj.attachId;
    }
</script>
</body>
</html>
