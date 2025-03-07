<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-04-28
  Time: 9:54
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
    <title>部门计划执行填报</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/jquery/jquery.cookie.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script> <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>

    <style>
        .layui-layer-btn{
            text-align: center;
        }
        .layui-form-label{
            width: 100px;
        }
        .layui-input-block{
            margin-left: 135px;
        }
        .query .layui-form-item{
            width: 19%;
            margin:7px 0px 0px 5px
        }
        .query .layui-form-label{
            width: 60px;
        }
        .query .layui-input-block{
            margin-left: 90px;
        }
        .query .layui-input-block{
            margin-left: 90px;
        }
        .query .layui-input-block input{
            height: 35px;
        }

    </style>
</head>
<body>
<div>
    <div class="headImg" style="margin-top: 10px">
        <span style="font-size:22px;margin-left:10px;color:#494d59;margin-top: 2px"><img style="margin-left:1.5%" src="../img/commonTheme/theme6/icon_summary.png" alt=""><span  class="headTitle" style="margin-left: 10px">计划执行填报</span></span>
    </div>
    <hr style="margin: 5px 0px;">
    <%--筛选查询--%>
    <div class="query" style="display: flex">
        <div class="layui-form-item">
            <label class="layui-form-label">年度</label>
            <div class="layui-input-block">
                <input type="text" name="title" id="date" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">月度</label>
            <div class="layui-input-block">
                <input type="text" name="title" id="month" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">所属部门</label>
            <div class="layui-input-block">
                <input type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">类型</label>
            <div class="layui-input-block">
                <input type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">计划类型</label>
            <div class="layui-input-block">
                <input type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="query" style="display: flex">
        <div class="layui-form-item">
            <label class="layui-form-label">关键任务类型</label>
            <div class="layui-input-block">
                <input type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">关键任务状态</label>
            <div class="layui-input-block">
                <input type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">子任务状态</label>
            <div class="layui-input-block">
                <input type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">责任类型</label>
            <div class="layui-input-block">
                <input type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <button type="button" class="layui-btn  layui-btn-sm" style="margin-left: 30px;margin-top: 10px">查询</button>
    </div>
    <%--表格--%>
    <div style="padding:0px 8px">
        <table id="demo" lay-filter="test" ></table>
    </div>
</div>
<%--<script type="text/html" id="barDemo">--%>
<%--<a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>--%>
<%--<a class="layui-btn layui-btn-xs" lay-event="edit">填报</a>--%>
<%--</script>--%>
<script type="text/html" id="barDemoReport">
    <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container" style="float: right;margin-right: -133px;">
        <button type="button" class="layui-btn layui-btn-sm" lay-event="detail">查看</button>
        <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">填报</button>
    </div>
</script>
<script>
    var table
    var form
    var laydate
    var upload
    var tableIns
    var tableInsReport
    var planItemId
    var testdata
    layui.use(['table','form','laydate','upload'], function(){
        table = layui.table;
        form = layui.form;
        laydate = layui.laydate;
        upload = layui.upload;
        //日期
        laydate.render({
            elem: '#date',
            type:'year'
        });
        laydate.render({
            elem: '#month',
            type:'month'
        });
        //主页面表格展示
        tableIns=table.render({
            elem: '#demo'
            ,url: '/ProjectDaily/selectItem' //数据接口
            ,page: true //开启分页
            ,toolbar: '#toolbarDemo' //开启头部工具栏
            ,defaultToolbar: []
            ,cols: [[ //表头
                {type:'checkbox'}
                ,{field: 'taskName', title: '子任务名称',}
                ,{field: 'mainCenterDeptName', title: '所属部门',}
                ,{field: 'planStartDate', title: '计划开始时间',templet:function (d) {
                        return format(d.planStartDate)
                    }}
                ,{field: 'planEndDate', title: '计划结束时间',templet:function (d) {
                        return format(d.planEndDate)
                    }}
                ,{field: 'taskPrecess', title: '子任务进度',}
                ,{field: 'resultStandard', title: '完成标准',}
                ,{field: 'dutyUserName', title: '责任人',}
                ,{field: 'assistUserName', title: '协作人',}
                // ,{ align:'center', toolbar: '#barDemo'}
            ]]
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "data": res.object //解析数据列表
                };
            }
        });
        // 头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'detail':
                    // console.log(checkStatus.data.planItemId)
                    // detailReport(data.planItemId)
                    break;
                case 'getCheckLength':
                    // report(0,testdata)
                    break;
            };
        });
        // 监听工具条
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）

            if(layEvent === 'detail'){ //查看
                detailReport(data.planItemId)
            }else if(layEvent === 'edit'){ //填报
                report(0,data)
            }
        });
        // 监听工具条
        table.on('tool(report)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）

            if(layEvent === 'detail'){ //查看
                report(2,data)
            } else if(layEvent === 'del'){ //删除
                layer.confirm('确定删除该条数据吗？', function(index){
                    $.ajax({
                        url:'/ProjectDaily/delProjectDaily',
                        dataType:'json',
                        type:'get',
                        data:{dailyId:data.dailyId},
                        success:function(res){
                            if(res.flag){
                                layer.msg('删除成功！',{icon:1});
                                layer.close(index)
                                tableInsReport.reload()
                            }
                        }
                    })
                });
            } else if(layEvent === 'edit'){ //编辑
                report(1,data)
            }
        });
    });
    //查看填报
    function detailReport(planItemId) {
        layer.open({
            type: 1,
            title: '查看填报',
            area: ['100%', '100%'],
            maxmin:true,
            min: function(){
                $('.layui-layer-shade').hide()
            },
            content: '<div style="padding: 8px;"><table id="report" lay-filter="report"></table></div>',
            success:function () {
                tableInsReport=table.render({
                    elem: '#report'
                    ,url: '/ProjectDaily/selectProjectDailyByItemId' //数据接口
                    ,page: true //开启分页
                    ,where:{
                        ItemId:planItemId
                    }
                    ,cols: [[ //表头
                        {field: 'ctreateTime', title: '填报时间',templet:function (d) {
                                return format(d.ctreateTime)
                            }}
                        ,{field: 'ctreateUserName', title: '填报人',}
                        ,{field: 'tadayProgress', title: '今日完成百分比',}
                        ,{field: 'tadayDesc', title: '当日完成情况',}
                        ,{field: 'unusualReason', title: '异常原因',}
                        ,{field: 'dutyUserName', title: '责任人',}
                        ,{field: 'assistUserName', title: '协作人',}
                        ,{ align:'center', toolbar: '#barDemoReport'}
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
        })
    }
    //填报、编辑、查看页面方法
    function report(type,dataTotal) {
        var title
        if(type==0){  //新增
            title="新增填报"
            url="/ProjectDaily/insertProjectDaily"
        }else if(type==1){  //编辑
            title="编辑填报"
            url="/ProjectDaily/upProjectDaily"
        }else if(type==2){  //查看
            title="查看填报"
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
            content: '<form class="layui-form" lay-filter="report">' +
                '  <div class="layui-row" style="margin-top:20px">\n' +
                '    <div class="layui-col-xs6">\n' +
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">填报时间:</label>\n' +
                '    <div class="layui-input-block">\n' +
                '        <input type="text" class="layui-input" id="test1" name="ctreateTime">' +
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">当日完成情况:</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="tadayDesc" required  lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">责任人:</label>\n' +
                '    <div class="layui-input-block dutyUser">\n' +
                '  <textarea  type="text" name="dutyUser" id="dutyUser" readonly  style="background:#e7e7e7;height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="userAdd" chooseType="1">添加</a>\n' +
                ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="userDel">清空</a>\n'+
                '    </div>\n' +
                '  </div>'+
                '<div class="layui-upload" style="height: auto">\n' +
                ' <div id="achievementsFile" style="padding-left: 135px;"></div>\n' +
                '  <label class="layui-form-label">成果文件:</label>\n' +
                ' <div class="layui-input-block" id="achievements_box">\n' +
                ' <button type="button" class="layui-btn layui-btn-primary " id="uploadAchievementsFile" style="border: 0px;color:#3870d7;padding: 0;"><img src="/img/icon_uplod.png" style="margin-right: 5px;"><i style="display: none" class="layui-icon"></i>附件上传</button>\n' +
                ' </div>\n' +
                '</div>\n' +
                '    </div>\n' +
                '    <div class="layui-col-xs6">\n' +
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">今日完成百分比:</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="tadayProgress" required  lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
                '    </div>\n' +
                '  </div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">异常原因:</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="unusualReason" required  lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
                '    </div>\n' +
                '  </div>'+
                '<div class="layui-form-item">\n' +
                '    <label class="layui-form-label">协作人:</label>\n' +
                '    <div class="layui-input-block assistUser">\n' +
                '  <textarea  type="text" name="assistUser" id="assistUser" readonly  style="background:#e7e7e7;height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="userAdd" chooseType="2">添加</a>\n' +
                ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="userDel">清空</a>\n'+
                '    </div>\n' +
                '  </div>'+
                '<div class="layui-upload" style="height: auto">\n' +
                ' <div id="unusualFile" style="padding-left: 135px;"></div>\n' +
                '  <label class="layui-form-label">异常支撑材料:</label>\n' +
                ' <div class="layui-input-block" id="unusual_box">\n' +
                ' <button type="button" class="layui-btn layui-btn-primary " id="uploadUnusualFile" style="border: 0px;color:#3870d7;padding: 0;"><img src="/img/icon_uplod.png" style="margin-right: 5px;"><i style="display: none" class="layui-icon"></i>附件上传</button>\n' +
                ' </div>\n' +
                '</div>\n' +
                '    </div>\n' +
                '  </div>'+
                '</form>',
            success:function () {
                //编辑
                if(type==1){
                    console.log(dataTotal)
                    form.val("report",dataTotal);
                    //责任人
                    $('#dutyUser').val(dataTotal.dutyUserName)
                    $('#dutyUser').attr('user_id',dataTotal.dutyUser)
                    //协作人
                    $('#assistUser').val(dataTotal.assistUserName)
                    $('#assistUser').attr('user_id',dataTotal.assistUser)
                    // 处理成果文件显示
                    var attachmentList = dataTotal ? dataTotal.attachmentList || [] : []
                    var attachmentListStr = ''
                    if (attachmentList.length > 0) {
                        attachmentList.forEach(function(attachment){
                            var fileExtension=attachment.attachName.substring(attachment.attachName.lastIndexOf(".")+1,attachment.attachName.length)//截取附件文件后缀
                            var attName = encodeURI(attachment.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6")
                            var fileExtensionName=attName.substring(0,attName.lastIndexOf("."))
                            var deUrl = attachment.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+attachment.size
                            attachmentListStr += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + attachment.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + attachment.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="'+attachment.attachName+'" class="inHidden" value="' + attachment.aid + '@' + attachment.ym + '_' + attachment.attachId + ',"></div>'
                        })
                    }
                    $('#achievementsFile').html(attachmentListStr)
                    // 处理异常文件显示
                    var attachmentList2 = dataTotal ? dataTotal.attachmentList2 || [] : []
                    var attachmentListStr2 = ''
                    if (attachmentList2.length > 0) {
                        attachmentList2.forEach(function(attachment){
                            var fileExtension=attachment.attachName.substring(attachment.attachName.lastIndexOf(".")+1,attachment.attachName.length)//截取附件文件后缀
                            var attName = encodeURI(attachment.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6")
                            var fileExtensionName=attName.substring(0,attName.lastIndexOf("."))
                            var deUrl = attachment.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+attachment.size
                            attachmentListStr2 += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + attachment.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + attachment.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="'+attachment.attachName+'" class="inHidden" value="' + attachment.aid + '@' + attachment.ym + '_' + attachment.attachId + ',"></div>'
                        })
                    }
                    $('#unusualFile').html(attachmentListStr2)
                }else if(type==2){
                    form.val("report",dataTotal);
                    //责任人
                    $('.dutyUser').html('<input type="text" class="layui-input" value="'+function () {
                        return dataTotal.dutyUserName.substring(0,dataTotal.dutyUserName.length-1) || ''
                    }()+'" >')
                    //协作人
                    $('.assistUser').html('<input type="text" class="layui-input" value="'+function () {
                        return  dataTotal.assistUserName.substring(0,dataTotal.assistUserName.length-1)  || ''
                    }()+'" >')
                    $('.layui-input').css('border','none')
                    // 处理成果文件显示
                    var attachmentList = dataTotal ? dataTotal.attachmentList || [] : []
                    var attachmentListStr = ''
                    if (attachmentList.length > 0) {
                        attachmentList.forEach(function(attachment){
                            var fileExtension=attachment.attachName.substring(attachment.attachName.lastIndexOf(".")+1,attachment.attachName.length)//截取附件文件后缀
                            var attName = encodeURI(attachment.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6")
                            var fileExtensionName=attName.substring(0,attName.lastIndexOf("."))
                            var deUrl = attachment.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+attachment.size
                            attachmentListStr += '<div class="dech" style="padding-top: 10px;" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + attachment.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + attachment.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="'+attachment.attachName+'" class="inHidden" value="' + attachment.aid + '@' + attachment.ym + '_' + attachment.attachId + ',"></div>'
                        })
                    }
                    $('#achievements_box').html(attachmentListStr)
                    // 处理异常文件显示
                    var attachmentList2 = dataTotal ? dataTotal.attachmentList2 || [] : []
                    var attachmentListStr2 = ''
                    if (attachmentList2.length > 0) {
                        attachmentList2.forEach(function(attachment){
                            var fileExtension=attachment.attachName.substring(attachment.attachName.lastIndexOf(".")+1,attachment.attachName.length)//截取附件文件后缀
                            var attName = encodeURI(attachment.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6")
                            var fileExtensionName=attName.substring(0,attName.lastIndexOf("."))
                            var deUrl = attachment.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+attachment.size
                            attachmentListStr2 += '<div class="dech" style="padding-top: 10px;" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + attachment.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + attachment.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="'+attachment.attachName+'" class="inHidden" value="' + attachment.aid + '@' + attachment.ym + '_' + attachment.attachId + ',"></div>'
                        })
                    }
                    $('#unusual_box').html(attachmentListStr2)
                    $('.deImgs').hide()
                    $('.layui-layer-btn').hide()
                }
                laydate.render({
                    elem: '#test1' //指定元素
                });
                //成果文件附件上传
                upload.render({
                    elem: '#uploadAchievementsFile'
                    ,url: '/upload?module=plancheck' //上传接口
                    ,accept: 'file' //普通文件
                    ,done: function(res){
                        var data=res.obj[0];
                        var fileExtension=data.attachName.substring(data.attachName.lastIndexOf(".")+1,data.attachName.length);//截取附件文件后缀
                        var attName = encodeURI(data.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                        var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                        var deUrl = data.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data.size;
                        var str = '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + data.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + data.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="'+data.attachName+'" class="inHidden" value="' + data.aid + '@' + data.ym + '_' + data.attachId + ',"></div>';
                        $('#achievementsFile').append(str);
                        layer.msg('上传成功', {icon:6});
                    }
                })
                //异常附件上传
                upload.render({
                    elem: '#uploadUnusualFile'
                    ,url: '/upload?module=plancheck' //上传接口
                    ,accept: 'file' //普通文件
                    ,done: function(res){
                        var data=res.obj[0];
                        var fileExtension=data.attachName.substring(data.attachName.lastIndexOf(".")+1,data.attachName.length);//截取附件文件后缀
                        var attName = encodeURI(data.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                        var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                        var deUrl = data.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data.size;
                        var str = '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + data.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + data.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="'+data.attachName+'" class="inHidden" value="' + data.aid + '@' + data.ym + '_' + data.attachId + ',"></div>';
                        $('#unusualFile').append(str);
                        layer.msg('上传成功', {icon:6});
                    }
                })
            },
            yes:function (index) {
                //成果文件
                var attachmentId = ''
                var attachmentName = ''
                var $attachments = $('#achievementsFile').find('input[type="hidden"]')
                $attachments.each(function(){
                    attachmentId+= $(this).val()
                    attachmentName += $(this).data('attachname') + '*'
                })
                //异常文件
                var attachmentId2 = ''
                var attachmentName2 = ''
                var $attachments2 = $('#unusualFile').find('input[type="hidden"]')
                $attachments2.each(function(){
                    attachmentId2 += $(this).val()
                    attachmentName2 += $(this).data('attachname') + '*'
                })
                var data={
                    ctreateTime:$('#test1').val(),
                    tadayProgress:parseInt($('input[name="tadayProgress"]').val()),
                    tadayDesc:$('input[name="tadayDesc"]').val(),
                    unusualReason:$('input[name="unusualReason"]').val(),
                    dutyUser:$('#dutyUser').attr('user_id') || '' ,
                    assistUser:$('#assistUser').attr('user_id') || '' ,
                    attachmentId:attachmentId,
                    attachmentName:attachmentName,
                    attachmentId2:attachmentId2,
                    attachmentName2:attachmentName2,
                    planItemId:dataTotal.planItemId
                }
                if(type==1){
                    data.dailyId=dataTotal.dailyId
                    data.ctreateUser=dataTotal.ctreateUser
                }
                $.get(url,data,function (res) {
                    if(res.flag){
                        if(type==0){
                            layer.msg('填报成功！', {icon:6});
                            layer.close(index)
                        }else if(type==1){
                            layer.msg('修改成功！', {icon:6});
                            layer.close(index)
                            tableInsReport.reload()
                        }

                    }
                })
            }
        })
    }
    // 选择用户
    $(document).on('click', '.userAdd', function(){
        var chooseType = $(this).attr('choosetype') == 1 ? '?0' : ''
        user_id = $(this).siblings('textarea').attr('id');
        $.popWindow("../common/selectUserIMAddGroup" + chooseType);
    })
    // 清空用户
    $(document).on('click', '.userDel', function(){
        var userId = $(this).siblings('textarea').attr('id')
        $('#'+userId).val('')
        $('#'+userId).attr('user_id','')
    })
    //将毫秒数转为yyyy-MM-dd格式时间
    function format(t) {
        if(t) return new Date(t).Format("yyyy-MM-dd");
        else return ''
    }
</script>
</body>
</html>
