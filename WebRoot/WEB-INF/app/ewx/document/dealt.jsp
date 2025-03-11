<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>公文</title>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/mui/mui/mui.min.js" ></script>
    <script src="/lib/mui/mui/showLoading.js"></script>
    <link href="../../lib/mui/mui/mui.css?20190819.1" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>

    <script type="text/javascript" charset="UTF-8">
        mui.init();
    </script>
    <style>
        .mui-table-view.mui-grid-view .mui-table-view-cell .mui-media-object {
            width: 50%;
        }

        .mui-table-view.mui-grid-view .mui-table-view-cell .mui-media-body {
            font-size: 13px;
        }

        .mui-bar {
            background-color: #0B7CC4;
        }

        .examination {
            height: 40px;
            /*background-color: #C8C7CC;*/
        }

        .examination .left {
            float: left;
            line-height: 40px;
            margin-left: 26px;
            color: #999;
        }

        .examination .right {
            float: right;
            line-height: 40px;
            color: #22be8a;
            margin-right: 13px;
        }

        .mui-table-view:after {
            background-color: #fff;
        }

        .mui-title-bar {
            float: left;
            margin-right: 10px;
        }

        .mui-title-bar:after {
            content: ' ';
            border-left: 4px solid #ffa96f;
            line-height: 43px;
            margin-left: 10px;
        }

        .mui-table-view.mui-grid-view {
            padding-top: 4px;
            padding-bottom: 14px;
        }

        .mui-table-view:before {
            background-color: #FFFFFF;
        }

        .mui-badge {
            position: absolute;
            top: 0px;
            right: 0px;
        }

        .mui-table-view-cell>.mui-badge,
        .mui-table-view-cell>.mui-btn,
        .mui-table-view-cell>.mui-switch,
        .mui-table-view-cell>a>.mui-badge,
        .mui-table-view-cell>a>.mui-btn,
        .mui-table-view-cell>a>.mui-switch {
            position: absolute;
            top: 17%;
            right: 9px;
            border-radius: 50% 50%;
            z-index: 1;
        }
        img{
            width:38.67px;
            height:38.67px;
        }
        .mui-media-body{
            width:60px;
            height:15px;
        }
        .block{
            height: 88px;
            width: 100%;
        }
        .mui-table-view.mui-grid-view .mui-table-view-cell .mui-media-body{
            white-space: initial;
        }
        .mui-table-view.mui-grid-view .mui-table-view-cell .mui-media-body{
            height: 30px;
            margin-top: 0px;
        }
        .mui-table-view.mui-grid-view .mui-table-view-cell .mui-media-object{
            width:38.67px;
        }

        img{
            width:38.67px;
            height:38.67px;
        }
        .mui-card-header, .mui-card-footer{
            justify-content: flex-start;
        }
        #Common{
            background: #efeff4;
            padding: inherit;
        }
        select{
            border: 1px solid #ccc!important;
        }
    </style>
</head>

<body>
<i class="mui-title-bar" style="display:none;"></i>
<div class="mui-card-header" style="display:none;"></div>
<div class="mui-card-content">
    <ul class="mui-table-view mui-grid-view">
        <li style="position: relative;" class="mui-table-view-cell mui-media mui-col-xs-3">
            <span class="mui-badge mui-badge-danger" style="display: none">2</span>
            <a id="wait" class="mui-table-view-cell" href="javascript:;">
                <img class="mui-media-object" src="/img/menu/Todopost.png">
                <div class="mui-media-body " style="height: 15px;margin-top: 4px">待办发文</div>
            </a>
        </li>
        <li class="mui-table-view-cell mui-media mui-col-xs-3" >
            <a id="Launch" class="mui-table-view-cell" id="launch" href="javascript:;">
                <img class="mui-media-object" src="/img/menu/Havetodopost.png">
                <div class="mui-media-body " style="height: 15px;margin-top: 4px">办结发文</div>

            </a>
        </li>
    </ul>
</div>
<%--发文拟稿的部分--%>
<div>
    <ul class="mui-table-view mui-grid-view" id="Common">
    </ul>
</div>

</body>
<script type="text/javascript">
    var flowId
    var formId
    mui.showLoading("正在加载..","div");
    mui.ajax({
        type: 'get',
        url: '/document/sortFlow',
        data:{
            mainType:'DOCUMENTTYPE',
            detailType:'SENDNG'
        },
        dataType:'json',
        success:function(data){
            var li_str2='';
            var arr=data.datas;
            var str=''
            if(arr.length>0){
                for(var i=0;i<arr.length;i++){
                    var arrys=arr[i].flows;

                    li_str2 +=  '<div style="background-color: #fff; margin-top: 10px;">'+

                        '<div class="mui-card-header"><i class="mui-title-bar"></i>'+arr[i].sortName+'</div>'+
                        '<ul class="mui-table-view mui-grid-view">'
                    for(var y=0;y<arrys.length;y++){
                        li_str2 += '<li flowId="'+arrys[y].flowId+'" data-urlid="'+arrys[y].flowId+'" data-name="'+arrys[y].flowName+'"  formId="'+arrys[y].formId+'" class="mui-table-view-cell mui-media mui-col-xs-3 dianj">'+
                            '<a class="block mui-table-view-cell" href="javascript:;">'+
                            '<img class="mui-media-object" src="/img/workflow/mh5/liu.png">'+
                            '<div class="mui-media-body">'+arrys[y].flowName+'</div>'+
                            '</a>'+
                            '</li>'

                    }
                    li_str2 +=  '</ul>'+
                        '</div>'
                    jQuery("#Common").html(li_str2);
                }
            }
            mui.hideLoading(function(){
                $('.mui-card-content').show();
            });//隐藏laoding
        }
    });


    document.getElementById('wait').addEventListener('tap', function(e) {
        mui.openWindow({
            url: '/ewx/toDoPost',
        });

    });
    document.getElementById('Launch').addEventListener('tap', function(e) {
        mui.openWindow({
            url: '/ewx/finisheCompletion',
        });
    });
    $(document).on('click','.dianj',function(){
        var urlid=$(this).attr('data-urlid');
        var runId=null;
        var runName=null;
        var flowName=$(this).attr("data-name");
        flowId=$(this).attr("flowId");
        formId=$(this).attr("formId");
        (function (fn) {
            $.post('/document/getRunName',{flowId:urlid,runId:'',prcsId:1,flowStep:1},function (json) {
                if(json.flag){
                    runName=json.data;
                    if(fn!=undefined){
                        fn()
                    }
                }

            },'json')
        })(function () {
            layer.open({
                title:'新建'+flowName,
                content:'<div style="margin-top: 10px;">' +
                    '<p>' +
                    '<label style="display: inline-block;vertical-align: middle;height: 30px;line-height: 30px;text-align: right;">发文标题:</label>' +
                    '<input type="text" id="runName" value="'+runName+'" style="border-color: #ccc;width:270px;margin-left: 10px;vertical-align: middle" name="nametitle">' +
                    '</p>' +
                    '<p style="margin-top: 25px;" class="fillGong">' +
                    '<label style="display: inline-block;vertical-align: middle;height: 30px;line-height: 30px;text-align: right;">公文文种:</label>' +
                    '<select  style="border-color: #ccc;width:270px;margin-left: 10px;vertical-align: middle" name="dispatchType">' +
                    '<option value="">请填写公文文种(可不填写）:</option>' +
                    '</select>' +
                    '</p>' +
                    '<p style="margin-top: 25px; display: none" class="sys_rule">' +
                    '<label style="display: inline-block;vertical-align: middle;height: 30px;line-height: 30px;text-align: right;">编号类型:</label>' +
                    '<select  style="border-color: #ccc;width:270px;margin-left: 10px;vertical-align: middle" name="sysRuleId">' +
                    '<option value="">请选择编号类型(可不填写)</option>' +
                    '</select>' +
                    '</p>' +
                    '<div class="liucheng2"><img src="../../img/workflow/work/add_work/speak.png" alt="" style="margin-right: 10px;width:30px;height:30px"><span>流程说明</span></div>'+
                    '</div>',
                btn:['确定','取消'],
                area:['100%','40%'],
                yes:function () {
                    if($('[name="nametitle"]').val() != ''){
                        // var loadindex = layer.load();
                        var sysRuleId = $('[name="sysRuleId"]').val() ? parseInt($('[name="sysRuleId"]').val()) : 0;
                        $.ajax({
                            url:'/document/saveDoc',
                            type:'post',
                            dataType:'json',
                            data:{
                                title:$('[name="nametitle"]').val(),
                                flowId:urlid,
                                documentType:0,
                                dispatchType:$('[name="dispatchType"]').val(),
                                fflowId:urlid,
                                frunId:'',
                                fprcsId:1,
                                fflowStep:1,
                                frunName:$('[name="nametitle"]').val(),
                                sysRuleId: sysRuleId
                            },
                            async: false,//同步请求,这里使用ajax必须使用同步方式请求，因为浏览器认为这种打开在ajax后新页面是不安全的
                            success:function(json){
                                // layer.close(loadindex);
                                if(json.flag){
                                    layer.msg('保存成功', {icon: 1});
                                    window.location.href='/workflow/work/workformh5?&flowId='+json.object.flowId+'&flowStep=1&tableName=document&tabId='+json.object.id+'&runId='+json.object.runId+'&prcsId=1&isNomalType=false&type=EWC'
                                }else {
                                    layer.msg(json.msg, {icon: 2});
                                }
                            }
                        });
                    }
                    else{
                        // layer.msg('发文标题不可为空!', {icon:2});
                    }

                },
                success:function () {
                    var runNames=document.getElementById('runName');
                    runNames.focus();
                    $.get('/syspara/selectProjectId',function (res) {
                        if(res.object=='dazu'){
                            $('.fillGong').hide()
                        }
                    });
                    $.get('/code/GetDropDownBox',{CodeNos:'GWTYPE'},function (json) {
                        var arrTwo=json.GWTYPE;
                        var str='<option value="">请填写公文文种(可不填写）</option>'
                        for(var i=0;i<arrTwo.length;i++){
                            str+='<option value="'+arrTwo[i].codeNo+'">'+arrTwo[i].codeName+'</option>'
                        }
                        $('[name="dispatchType"]').html(str)
                    },'json');

                    $.get('/flow/selectAllFlow', {flowId: urlid}, function(res){
                        if (res.flag && res.object.sysRuleYn == 1) {
                            $('.sys_rule').show();
                            $.get('/document/getRuleAll2', function(res){
                                if (res.flag) {
                                    var str = '';
                                    res.obj.forEach(function(code){
                                        str += '<option value="'+code.id+'">'+code.expression+'</option>'
                                    });
                                    $('[name="sysRuleId"]').append(str);
                                }
                            });
                        } else {
                            $('.sys_rule').hide();
                        }
                    });

                }
            })
        })
    })
    //点击流程说明
    $(document).on('click','.liucheng2',function(){
       window.location.href="/workflow/work/processSpeak?flowId="+flowId+'&formId='+formId,'流程说明','0','0','1150px','700px'
    })
</script>

</html>
