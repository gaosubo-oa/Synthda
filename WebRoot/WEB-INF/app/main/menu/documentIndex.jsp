<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-03-31
  Time: 17:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>公文门户</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/echarts.min.js"></script>
    <style>
    html, body{
    font-family: "Microsoft Yahei" !important;
    }
        body{
        background: #F8F8F8;
        }
    .left1{
        /*width: 30%;*/
        width: 63%;
        background: #FFFFFF
    }
    .right1{
        background: #ffffff;
        margin-left:1%;
        width: 36%;
     }
    .right1 li:hover{
        background: #e8f4fc;
        cursor: pointer;
    }
    .right1 li{
    list-style: disc;
    padding: 4px 0px;
    font-size: 13px;
    }
    .one ,.two , .three ,.left1List , .left1List , .left1Item , .right1List{
        display: flex;
    }
     .item1{
        margin: 5px 6px; 
        font-weight: bold;
     }
     .item2{
        text-align: center;
        font-weight: bold;
        font-size: 30px;
        }
        .item3{
        /*margin: 5px 10px;*/
        margin: 5px 66px;
        }
        .item4{
        margin-top: 5px;
        }
        .left1Item{
        margin: 5px 2%;
        }
    .daishou li:hover{
        background: #e8f4fc;
        cursor: pointer;
    }
     .yishou li:hover{
        background: #e8f4fc;
        cursor: pointer;
    }
     .myshou li:hover{
        background: #e8f4fc;
        cursor: pointer;
    }
     .daifa li:hover{
        background: #e8f4fc;
        cursor: pointer;
    }
     .yifa li:hover{
        background: #e8f4fc;
        cursor: pointer;
    }
     .myfa li:hover{
        background: #e8f4fc;
        cursor: pointer;
    }
    .liuchengShou , .liuchengFa{
        width: 50%;
        margin-left: 17%;
        margin-top: 25px;
        cursor: pointer;
    }
    .layui-form-selected dl{
        max-height: 135px;
    }
    .noData{
        margin-top: 5%;
    }
    @media screen and (max-width: 1150px) {
    .left1Item {
        margin: 5px 1%;
    }
    }
    </style>
</head>
<body>
    <div style="padding: 8px;padding-left: 15px">
    <div style="display: flex"><img src="/img/menu/documentTop.png" style="width: 63%;height: 350px" title='公文'/>
    <div class="right1">
                <div >
                 <h2 style="margin-left: 5.5%;font-weight: bold;margin-top: 2%;font-size: 16px">常用收文</h2>
                <div style="display: flex;font-size: 16px;margin-top: 2%;" id="oftenShou">
                    <div style="width: 50%;margin-left: 6%;"><ul class="leftShou"></ul></div>
                    <div style="width: 50%;margin-left:4%;"><ul class="rightShou"></ul></div>
                </div>
                 </div>
                <%--<div style="width: 50%;">
                 <h2 style="margin-left: 6%;font-weight: bold;margin-top: 2%;">常用发文</h2>
                <div style="display: flex;font-size: 15px;margin-top: 2%;">
                <div style="width: 50%;margin-left: 6%;"><ul class="leftFa"></ul></div>
                <div style="width: 50%;margin-left:4%"><ul class="rightFa"></ul></div>
                </div>
                 </div>--%>
            </div>
    </div>
        <%--第一块内容--%>
        <div class="one" style="margin-top: 10px;height: 170px;">
            <%--左侧第一块--%>
            <div class="left1">
            <%--左侧第一块上面--%>
                <div class="left1List" style="margin-top: 45px;margin-left: 5px;justify-content: space-between;">
            <%--左1--%>
            <a href="javascript:;"style="width: 20%;">
            <h2 style="display: none">我的收文</h2>
                    <div class="left1Item">
                        <%--<div style="width: 60px; height: 100px; background: antiquewhite;"></div>--%>
                 <img src="/img/menu/myShou.png" style="width: 60px;height: 65px" title='我的收文'/>
    <div style="font-size: 15px;margin-left: 8px;color: #FFB800;">
                            <div><h3 class="item1">我的收文</h3></div>
                            <div><h3 class="item2 sendDocument"></h3></div>
                        </div>
                    </div>
            </a>

            <%--左2--%>
            <a href="javascript:;"  style="width: 20%;">
            <h2 style="display: none">我的发文</h2>
                    <div class="left1Item">
                        <%--<div style="width: 60px; height: 100px; background: antiquewhite;"></div>--%>
                 <img src="/img/menu/myFa.png" style="width: 53px;height: 65px" title='我的发文'/>
                    <div style="font-size: 15px;margin-left: 8px;color: #6BDF06;">
                        <div><h3 class="item1">我的发文</h3></div>
                        <div><h3 class="item2 receiveDocument"></h3></div>
                    </div>
                    </div>
            </a>
                    <%--左3--%>
            <a href="javascript:;"  style="width: 20%;">
                    <div class="left1Item">
                    <%--<div style="width: 60px; height: 100px;background: url(/login/default/user/theme20/sketchbook.png) no-repeat;"></div>--%>
                    <img src="/img/menu/myYue.png" style="width: 61px;height: 68px" title='我的阅文'/>
                    <div style="font-size: 15px;margin-left: 8px;color: #1296DB;">
                    <div><h3 class="item1">我的阅文</h3></div>
                    <div><h3 class="item2 readDocument"></h3></div>
                    </div>
                    </div>
            </a>
            <a href="javascript:;"  style="width: 20%;">
                    <%--左4--%>
                    <div class="left1Item">
                    <%--<div style="width: 60px; height: 100px; background: antiquewhite;"></div>--%>
                    <img src="/img/menu/myChao.png" style="width: 63px;height: 72px" title='超时公文'/>
                    <div style="font-size: 15px;color: #FF1222;">
                    <div><h3 class="item1">超时公文</h3></div>
                    <div><h3 class="item2 timeOutDocument"></h3></div>
                    </div>
                    </div>
             </a>

                </div>
            <%--左侧第一块下面--%>
                <%--<div class="left1List" style="margin: 15px 0px;margin-left: 5px;justify-content: space-between;">

                </div>--%>
            </div>
            <%--右侧第一块--%>
            <%--<div class="right1">
                <div >
                 <h2 style="margin-left: 5.5%;font-weight: bold;margin-top: 2%;font-size: 16px">常用收文</h2>
                <div style="display: flex;font-size: 16px;margin-top: 2%;" id="oftenShou">
                    <div style="width: 50%;margin-left: 6%;"><ul class="leftShou"></ul></div>
                    <div style="width: 50%;margin-left:4%;"><ul class="rightShou"></ul></div>
                </div>
                 </div>
                &lt;%&ndash;<div style="width: 50%;">
                 <h2 style="margin-left: 6%;font-weight: bold;margin-top: 2%;">常用发文</h2>
                <div style="display: flex;font-size: 15px;margin-top: 2%;">
                <div style="width: 50%;margin-left: 6%;"><ul class="leftFa"></ul></div>
                <div style="width: 50%;margin-left:4%"><ul class="rightFa"></ul></div>
                </div>
                 </div>&ndash;%&gt;
            </div>--%>
            <%--右侧第二块--%>
            <div class="right1">
            <%--<div style="width: 50%;">
            <h2 style="margin-left: 5.5%;font-weight: bold;margin-top: 2%;">常用收文</h2>
            <div style="display: flex;font-size: 16px;margin-top: 2%;">
            <div style="width: 50%;margin-left: 6%;"><ul class="leftShou"></ul></div>
            <div style="width: 50%;margin-left:4%;"><ul class="rightShou"></ul></div>
            </div>
            </div>--%>
            <div >
            <h2 style="margin-left: 6%;font-weight: bold;margin-top: 2%;font-size: 16px">常用发文</h2>
            <div style="display: flex;font-size: 15px;margin-top: 2%;" id="oftenFa">
            <div style="width: 50%;margin-left: 6%;"><ul class="leftFa"></ul></div>
            <div style="    width: 50%;margin-left:4%"><ul class="rightFa"></ul></div>
            </div>
            </div>
            </div>
        </div>
        <%--第二块内容--%>
        <div class="two" style="margin-top: 10px;">
        <%--左侧--%>
        <div style="width: 63%;background: #FFFFFF">
        <h3 style="padding-left: 18px;margin-top:10px;font-weight: bold;font-size: 16px">收文管理</h3>
        <div class="layui-tab  layui-tab-brief">
        <ul class="layui-tab-title">
        <li class="layui-this">待办收文</li>
        <li>已办收文</li>
        <li>我的收文</li>
        </ul>
        <div class="layui-tab-content" >
        <div class="layui-tab-item layui-show daishou"></div>
        <div class="layui-tab-item yishou"></div>
        <div class="layui-tab-item myshou"></div>
        </div>
        </div>
        </div>
        <%--右侧--%>
        <div style="width: 36%;margin-left: 1%;background: #ffffff;">
        <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
        <div id="main" style="width: 100%;height:300px;"></div>
        </div>
        </div>
        <%--第三块内容--%>
        <div class="three" style="margin-top: 10px;">
        <%--左侧--%>
        <div style="width: 63%;background: #FFFFFF">
        <h3 style="padding-left: 18px;margin-top:10px;font-weight: bold;font-size: 16px">发文管理</h3>
        <div class="layui-tab  layui-tab-brief">
        <ul class="layui-tab-title">
        <li class="layui-this">待办发文</li>
        <li>已办发文</li>
        <li>我的发文</li>
        </ul>
        <div class="layui-tab-content" >
        <div class="layui-tab-item layui-show daifa"></div>
        <div class="layui-tab-item yifa"></div>
        <div class="layui-tab-item myfa"></div>
        </div>
        </div>
        </div>
        <%--右侧--%>
        <div style="width: 36%;margin-left: 1%;background: #ffffff;">
        <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
        <div id="main2" style="width:100%;height:300px;"></div>
        </div>
        </div>
        <%--第四块内容--%>
        <div class="four" style="margin-top: 10px;background: #FFFFFF">
                <h3 style="padding-left: 18px;padding-top:10px;font-weight: bold;font-size: 16px">我参与的公文</h3>
                <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
                <div id="main3" style="width:100%;height:300px;"></div>
        </div>
    </div>

        <script type="text/javascript">
        var form = layui.form
        var flowId
        var formId
        //数字显示
        $.ajax({
            type: 'post',
            url: '/document/selectCount',
            dataType: 'json',
            success:function(res) {
                if(res.flag){
                    $('.sendDocument').html(res.object.sendDocument)//我的收文
                    $('.receiveDocument').html(res.object.receiveDocument)//我的发文
                    $('.readDocument').html(res.object.readDocument)
                    $('.timeOutDocument').html(res.object.timeOutDocument)
                }

             }
        })
        //常用收文
        $.ajax({
            type: 'post',
            url: '/document/sortCommonDocument',
            dataType: 'json',
            data:{
                mainType:'DOCUMENTTYPE',
                detailType:'RECEIVE'
            },
            success:function(res) {
                var data = res.datas||'';
                var str = ''
                var str1 = ''
                if(data&&data.length > 0){
                    for(var i = 0; i < data.length; i++){
                        if(i%2==0){
                            str+='<li class="oftenShou" urlid="'+data[i].flowId+'" formId="'+data[i].formId+'">'+data[i].flowName+'</li>'
                        }else{
                            str1+='<li class="oftenShou" urlid="'+data[i].flowId+'" formId="'+data[i].formId+'">'+data[i].flowName+'</li>'
                        }
                    }
                    $('.leftShou').append(str)
                    $('.rightShou').append(str1)
                }else{
                    str += '<div class="noData" style="text-align: center;border: none;width: 100%;">' +
                    '<img  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
                    '</div>';
                    $('#oftenShou').html(str)
                }

            }
         })
        //常用收文新增
        $(document).on('click','.oftenShou',function() {
            var runName=''
            var urlid=$(this).attr('urlid')
            formId=$(this).attr('urlid')
            formId=$(this).attr('formId')
            $.ajaxSettings.async = false;
            $.post('/document/getRunName',{flowId:$(this).attr('urlid'),runId:'',prcsId:1,flowStep:1},function (json) {
            if(json.flag){
            // runId=json.object.flowRun.runId;
            runName=json.data;
            }
            },'json')
            $.ajaxSettings.async = true;
            layer.open({
                type: 1,
                title:'新建'+$(this).html(),
                content:'<div style="margin-top: 10px;" class="layui-form">' +
                '<p>' +
                '<label style="display: inline-block;width: 150px;vertical-align: middle;height: 30px;line-height: 30px;text-align: right;">'+'收文标题'+' :</label>' +
                '<input class="layui-input" type="text" value="'+runName+'" autocomplete="off" style="border-color: #ccc;width:270px;margin-left: 10px;vertical-align: middle;display: inline-block;" name="nametitle">' +
                '</p>' +
                '<div style="margin-top: 25px;">' +
                '<label style="display: inline-block;width: 150px;vertical-align: middle;height: 30px;line-height: 30px;text-align: right;">'+'公文文种'+' :</label>' +
                '<div style="display: inline-block;margin-left:1.5%;width: 45%;"><select name="dispatchType">' +
                '<option value="">'+'请填写公文文种(可不填写）'+'</option>' +
                '</select></div>' +
                '</div>' +
                '<div style="margin-top: 25px; display: none;" class="sys_rule">' +
                '<label style="display: inline-block;width: 150px;vertical-align: middle;height: 30px;line-height: 30px;text-align: right;">编号类型:</label>' +
                '<div style="display: inline-block;margin-left:1.5%;width: 45%;"><select  name="sysRuleId">' +
                '<option value="">请选择编号类型(可不填写)</option>' +
                '</select></div>' +
                '</div>' +
                '<div class="liuchengShou"><img src="../../img/workflow/work/add_work/speak.png" alt="" style="margin-right: 10px"><span>流程说明</span></div>'+
                '</div>',
                btn:['确定','取消'],
                area:['600px','350px'],
                yes:function (index) {
                    if($('[name="nametitle"]').val() != ''){
                        var sysRuleId = $('[name="sysRuleId"]').val() ? parseInt($('[name="sysRuleId"]').val()) : 0;
                        $.ajax({
                            url:'/document/saveDoc',
                            type:'post',
                            dataType:'json',
                            data:{
                                title:$('[name="nametitle"]').val(),
                                flowId:urlid,
                                documentType:1,
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
                                if(json.flag){
                                    $.layerMsg({content:'保存成功',icon:1},function () {});
                                    $.popWindow('/workflow/work/workform?&flowId='+json.object.flowId+'&flowStep=1&tableName=document&tabId='+json.object.id+'&runId='+json.object.runId+'&prcsId=1&isNomalType=false')
                                    layer.close();
                                }else {
                                    $.layerMsg({content:'保存失败',icon:2});
                                }
                            }
                        });
                    }else{
                        $.layerMsg({content:'收文标题不可为空！',icon:2});
                    }

                },
                success:function () {
                    form.render()
                    $('.layui-layer').css('top', '')
                    $.get('/code/GetDropDownBox', { CodeNos: 'GWTYPE' }, function (json) {
                        var arrTwo = json.GWTYPE;
                        var str = '<option value="">' + '请填写公文文种(可不填写）' + '</option>'
                        for(var i = 0; i < arrTwo.length; i++){
                            str += '<option value="'+arrTwo[i].codeNo+'">' + arrTwo[i].codeName + '</option>'
                        }
                        $('[name="dispatchType"]').html(str)
                        form.render()
                    },'json');

                    $.get('/flow/selectAllFlow', {flowId:urlid}, function(res){
                        if (res.flag && res.object.sysRuleYn == 1) {
                            $('.sys_rule').show();
                            $.get('/document/getRuleAll', function(res){
                                if (res.flag) {
                                    var str = '';
                                    res.obj.forEach(function(code){
                                        str += '<option value="'+code.id+'">'+code.expression+'</option>'
                                    });
                                    $('[name="sysRuleId"]').append(str);
                                    form.render()
                                }
                            });
                        } else {
                            $('.sys_rule').hide();
                        }
                    });
                }
            })
        })
        //点击流程说明
        $(document).on('click', '.liuchengShou', function(){
            $.popWindow("/workflow/work/processSpeak?flowId=" + flowId + '&formId=' + formId, '流程说明', '0', '0', '1150px', '700px');
        })
        //常用发文
        $.ajax({
            type: 'post',
            url: '/document/sortCommonDocument',
            dataType: 'json',
            data:{
                mainType: 'DOCUMENTTYPE',
                detailType: 'SENDNG'
            },
            success:function(res) {
                var data = res.datas
                var str = ''
                var str1 = ''
                if(data.length > 0){
                    for(var i = 0; i < data.length; i++){
                        if(i%2 == 0){
                            str += '<li class="oftenFa" urlid="'+data[i].flowId+'" formId="'+data[i].formId+'">'+data[i].flowName+'</li>'
                        }else{
                            str1 += '<li class="oftenFa" urlid="'+data[i].flowId+'" formId="'+data[i].formId+'">'+data[i].flowName+'</li>'
                        }
                    }
                    $('.leftFa').append(str)
                    $('.rightFa').append(str1)
                }else{
                    str += '<div class="noData" style="text-align: center;border: none;width: 100%;">' +
                    '<img  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
                    '</div>';
                    $('#oftenFa').html(str)
                }




            }
        })
        //常用发文新增
        $(document).on('click','.oftenFa',function() {
        var runName=''
        var urlid=$(this).attr('urlid')
        formId=$(this).attr('urlid')
        formId=$(this).attr('formId')
        $.ajaxSettings.async = false;
        $.post('/document/getRunName',{flowId:$(this).attr('urlid'),runId:'',prcsId:1,flowStep:1},function (json) {
        if(json.flag){
        // runId=json.object.flowRun.runId;
        runName=json.data;
        }
        },'json')
        $.ajaxSettings.async = true;
        layer.open({
        type: 1,
        title:'新建'+$(this).html(),
        content:'<div style="margin-top: 10px;" class="layui-form">' +
        '<p>' +
        '<label style="display: inline-block;width: 150px;vertical-align: middle;height: 30px;line-height: 30px;text-align: right;">'+'收文标题'+' :</label>' +
        '<input class="layui-input" type="text" value="'+runName+'" autocomplete="off" style="border-color: #ccc;width:270px;margin-left: 10px;vertical-align: middle;display: inline-block;" name="nametitle">' +
        '</p>' +
        '<div style="margin-top: 25px;">' +
        '<label style="display: inline-block;width: 150px;vertical-align: middle;height: 30px;line-height: 30px;text-align: right;">'+'公文文种'+' :</label>' +
        '<div style="display: inline-block;margin-left:1.5%;width: 45%;"><select name="dispatchType">' +
        '<option value="">'+'请填写公文文种(可不填写）'+'</option>' +
        '</select></div>' +
        '</div>' +
        '<div style="margin-top: 25px; display: none;" class="sys_rule">' +
        '<label style="display: inline-block;width: 150px;vertical-align: middle;height: 30px;line-height: 30px;text-align: right;">编号类型:</label>' +
        '<div style="display: inline-block;margin-left:1.5%;width: 45%;"><select  name="sysRuleId">' +
        '<option value="">请选择编号类型(可不填写)</option>' +
        '</select></div>' +
        '</div>' +
        '<div class="liuchengFa"><img src="../../img/workflow/work/add_work/speak.png" alt="" style="margin-right: 10px"><span>流程说明</span></div>'+
        '</div>',
        btn:['确定','取消'],
        area:['600px','350px'],
        yes:function (index) {
        if($('[name="nametitle"]').val() != ''){
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
        if(json.flag){
        $.layerMsg({content:'保存成功',icon:1},function () {
        });
        $.popWindow('/workflow/work/workform?&flowId='+json.object.flowId+'&flowStep=1&tableName=document&tabId='+json.object.id+'&runId='+json.object.runId+'&prcsId=1&isNomalType=false')
        layer.close();
        }else {
        $.layerMsg({content:'保存失败',icon:2});
        }
        }
        });
        }else{
        $.layerMsg({content:'发文标题不可为空！',icon:2});
        }

        },
        success:function () {
        form.render()
        $('.layui-layer').css('top','')
        $.get('/code/GetDropDownBox',{CodeNos:'GWTYPE'},function (json) {
        var arrTwo=json.GWTYPE;
        var str='<option value="">'+'请填写公文文种(可不填写）'+'</option>'
        for(var i=0;i<arrTwo.length;i++){
        str+='<option value="'+arrTwo[i].codeNo+'">'+arrTwo[i].codeName+'</option>'
        }
        $('[name="dispatchType"]').html(str)
        form.render()
        },'json');

        $.get('/flow/selectAllFlow', {flowId:urlid}, function(res){
        if (res.flag && res.object.sysRuleYn == 1) {
        $('.sys_rule').show();
        $.get('/document/getRuleAll', function(res){
        if (res.flag) {
        var str = '';
        res.obj.forEach(function(code){
        str += '<option value="'+code.id+'">'+code.expression+'</option>'
        });
        $('[name="sysRuleId"]').append(str);
        form.render()
        }
        });
        } else {
        $('.sys_rule').hide();
        }
        });
        }
        })
        })
        //点击流程说明
        $(document).on('click','.liuchengFa',function(){
        $.popWindow("/workflow/work/processSpeak?flowId="+flowId+'&formId='+formId,'流程说明','0','0','1150px','700px');
        })
        //待办收文
        $.ajax({
            type: 'post',
            url: '/document/selWillDocSendOrReceive',
            dataType: 'json',
            data:{
                page: 1,
                pageSize:6,
                documentType: 1
            },
            success:function(res) {
                var data=res.datas
                var str=''
                if(data.length>0){
                    for(var i=0;i<data.length;i++){
                        var content = data[i].title.slice(0,5);
                        var title = data[i].title;
                    str+='<li style="display: flex;padding: 4px 6px;font-size: 13px" class="daishouDetail" flowId="'+data[i].flowId+'" realPrcsId="'+data[i].realPrcsId+'" step="'+data[i].step+'" runId="'+data[i].runId+'" id="'+data[i].id+'" tableName="'+data[i].tableName+'" opFlag="'+data[i].opFlag+'">' +
                    '<div style="width: 42%;" title="'+title+'">'+content+'</div>'+
                    '<div style="width: 30%;">'+data[i].createrName+'</div>'+
                    '<div style="width: 30%;">'+function() {
                    if(data[i].prFlag==1){
                    return '未接收'
                    }else if(data[i].prFlag==2){
                    return '办理中'
                    } else if(data[i].prFlag==3){
                    return '待接收'
                    }else {
                    return '已办结'
                    }
                    }()+'</div>'+
                    '<div style="width: 30%;">'+data[i].createTime.substr(0,data[i].createTime.length-2)+'</div>'+
                    '</li> '
                    }
                }else{
                    str += '<div class="noData" style="text-align: center;border: none;">' +
                    '<img  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
                    '</div>';
                }
                $('.daishou').append(str)
             }
        })
        //待办收文详情
        $(document).on('click','.daishouDetail',function() {
            $.popWindow('/workflow/work/workform?&flowId='+$(this).attr('flowId')+'&prcsId='+$(this).attr('realPrcsId')+'&flowStep='+$(this).attr('step')
            +'&runId='+$(this).attr('runId')+'&tabId='+$(this).attr('id')+'&tableName='+$(this).attr('tableName')+'&isNomalType=false&hidden=true&opFlag='+$(this).attr('opFlag'))
        })
        //已办收文
        $.ajax({
            type: 'post',
            url: '/document/selOverDocSendOrReceive',
            dataType: 'json',
            data:{
                page: 1,
                pageSize:6,
                documentType: 1
            },
            success:function(res) {
                var data=res.datas
                var str=''
                if(data.length>0){
                    for(var i=0;i<data.length;i++){
                         var content = data[i].title.slice(0,5);
                        var title = data[i].title;
                    str+='<li style="display: flex;padding: 8px 6px;" class="yishouDetail" flowId="'+data[i].flowId+'" step="'+data[i].step+'"  id="'+data[i].id+'" tableName="'+data[i].tableName+'" runId="'+data[i].runId+'" realPrcsId="'+data[i].realPrcsId+'">' +
                    '<div style="width: 42%;" title="'+title+'">'+content+'</div>'+
                    '<div style="width: 30%;">'+data[i].createrName+'</div>'+
                    '<div style="width: 30%;">'+function() {
                    if(data[i].prFlag==1){
                    return '未接收'
                    }else if(data[i].prFlag==2){
                    return '办理中'
                    } else if(data[i].prFlag==3){
                    return '待接收'
                    }else {
                    return '已办结'
                    }
                    }()+'</div>'+
                    '<div style="width: 30%;">'+data[i].createTime.substr(0,data[i].createTime.length-2)+'</div>'+
                    '</li> '
                    }
                }else{
                    str += '<div class="noData" style="text-align: center;border: none;">' +
                    '<img  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
                    '</div>';
                }
                $('.yishou').append(str)
             }
        })
        //已办收文详情
        $(document).on('click','.yishouDetail',function () {
            $.popWindow('/workflow/work/workformPreView?flowId='+$(this).attr('flowId')+'&flowStep='+$(this).attr('step')+'' +
            '&tabId='+$(this).attr('id')+'&tableName='+$(this).attr('tableName')+'&runId='+$(this).attr('runId')+'&' +
            'prcsId='+$(this).attr('realPrcsId')+'&isNomalType=false&hidden=true')
        })
        //我的收文
        $.ajax({
            type: 'post',
            url: '/document/selMyDocSendOrReceive',
            dataType: 'json',
            data:{
                page: 1,
                pageSize:6,
                documentType: 1
            },
            success:function(res) {
                var data=res.datas
                var str=''
                if(data.length>0){
                    for(var i=0;i<data.length;i++){
                    var content = data[i].title.slice(0,5);
                        var title = data[i].title;
                    str+='<li style="display: flex;padding: 8px 6px;" class="woshouDetail" flowId="'+data[i].flowId+'" step="'+data[i].step+'" id="'+data[i].id+'" tableName="'+data[i].tableName+'" runId="'+data[i].runId+'" realPrcsId="'+data[i].realPrcsId+'">' +
                    '<div style="width: 42%;" title="'+title+'">'+content+'</div>'+
                    '<div style="width: 30%;">'+data[i].createrName+'</div>'+
                    '<div style="width: 30%;">'+function() {
                    if(data[i].prFlag==1){
                    return '未接收'
                    }else if(data[i].prFlag==2){
                    return '办理中'
                    } else if(data[i].prFlag==3){
                    return '待接收'
                    }else {
                    return '已办结'
                    }
                    }()+'</div>'+
                    '<div style="width: 30%;">'+data[i].createTime.substr(0,data[i].createTime.length-2)+'</div>'+
                    '</li> '
                    }
                }else{
                    str += '<div class="noData" style="text-align: center;border: none;">' +
                    '<img  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
                    '</div>';
                }
                $('.myshou').append(str)
             }
        })
        //我的收文详情
        $(document).on('click','.woshouDetail',function () {
            $.popWindow('/workflow/work/workformPreView?flowId='+$(this).attr('flowId')+'&flowStep='+$(this).attr('step')+'' +
            '&tabId='+$(this).attr('id')+'&tableName='+$(this).attr('tableName')+'&runId='+$(this).attr('runId')+'&' +
            'prcsId='+$(this).attr('realPrcsId')+'&isNomalType=false&hidden=true')
        })
        //待办发文
        $.ajax({
            type: 'post',
            url: '/document/selWillDocSendOrReceive',
            dataType: 'json',
            data:{
                page: 1,
                pageSize:6,
                documentType: 0
            },
            success:function(res) {
                var data=res.datas
                var str=''
                if(data.length>0){
                    for(var i=0;i<data.length;i++){
                    str+='<li style="display: flex;padding: 4px 6px;font-size: 13px" class="daifaDetail" flowId="'+data[i].flowId+'" realPrcsId="'+data[i].realPrcsId+'" step="'+data[i].step+'" runId="'+data[i].runId+'" id="'+data[i].id+'" tableName="'+data[i].tableName+'" opFlag="'+data[i].opFlag+'">' +
                    '<div style="width: 42%;">'+data[i].title+'</div>'+
                    '<div style="width: 30%;">'+data[i].createrName+'</div>'+
                    '<div style="width: 30%;">'+function() {
                    if(data[i].prFlag==1){
                    return '未接收'
                    }else if(data[i].prFlag==2){
                    return '办理中'
                    } else if(data[i].prFlag==3){
                    return '待接收'
                    }else {
                    return '已办结'
                    }
                    }()+'</div>'+
                    '<div style="width: 30%;">'+data[i].createTime.substr(0,data[i].createTime.length-2)+'</div>'+
                    '</li> '
                    }
                }else{
                    str += '<div class="noData" style="text-align: center;border: none;">' +
                    '<img  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
                    '</div>';
                }
                $('.daifa').append(str)
             }
        })
        //待办发文详情
        $(document).on('click','.daifaDetail',function () {
            $.popWindow('/workflow/work/workform?&flowId='+$(this).attr('flowId')+'&prcsId='+$(this).attr('realPrcsId')+'&flowStep='+$(this).attr('step')
            +'&runId='+$(this).attr('runId')+'&tabId='+$(this).attr('id')+'&tableName='+$(this).attr('tableName')+'&isNomalType=false&hidden=true&opFlag='+$(this).attr('opFlag'))
        })
        //已办发文
        $.ajax({
            type: 'post',
            url: '/document/selOverDocSendOrReceive',
            dataType: 'json',
            data:{
                page: 1,
                pageSize:6,
                documentType: 0
            },
            success:function(res) {
                var data=res.datas
                var str=''
                if(data.length>0){
                    for(var i=0;i<data.length;i++){
                    str+='<li style="display: flex;padding: 8px 6px;" class="yifaDetail" flowId="'+data[i].flowId+'" step="'+data[i].step+'" id="'+data[i].id+'" tableName="'+data[i].tableName+'" runId="'+data[i].runId+'" realPrcsId="'+data[i].realPrcsId+'">' +
                    '<div style="width: 42%;">'+data[i].title+'</div>'+
                    '<div style="width: 30%;">'+data[i].createrName+'</div>'+
                    '<div style="width: 30%;">'+function() {
                    if(data[i].prFlag==1){
                    return '未接收'
                    }else if(data[i].prFlag==2){
                    return '办理中'
                    } else if(data[i].prFlag==3){
                    return '待接收'
                    }else {
                    return '已办结'
                    }
                    }()+'</div>'+
                    '<div style="width: 30%;">'+data[i].createTime.substr(0,data[i].createTime.length-2)+'</div>'+
                    '</li> '
                    }
                }else{
                    str += '<div class="noData" style="text-align: center;border: none;">' +
                    '<img  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
                    '</div>';
                }
                $('.yifa').append(str)
             }
        })
        //已办发文详情
        $(document).on('click','.yifaDetail',function () {
            $.popWindow('/workflow/work/workformPreView?flowId='+$(this).attr('flowId')+'&flowStep='+$(this).attr('step')+'' +
            '&tabId='+$(this).attr('id')+'&tableName='+$(this).attr('tableName')+'&runId='+$(this).attr('runId')+'&' +
            'prcsId='+$(this).attr('realPrcsId')+'&isNomalType=false&hidden=true')
        })
        //我的发文
        $.ajax({
            type: 'post',
            url: '/document/selMyDocSendOrReceive',
            dataType: 'json',
            data:{
                page: 1,
                pageSize:6,
                documentType: 0
            },
            success:function(res) {
                var data=res.datas
                var str=''
                if(data.length>0){
                    for(var i=0;i<data.length;i++){
                    str+='<li style="display: flex;padding: 8px 6px;" class="wofaDetail" flowId="'+data[i].flowId+'" step="'+data[i].step+'" id="'+data[i].id+'" tableName="'+data[i].tableName+'" runId="'+data[i].runId+'" realPrcsId="'+data[i].realPrcsId+'">' +
                    '<div style="width: 42%;">'+data[i].title+'</div>'+
                    '<div style="width: 30%;">'+data[i].createrName+'</div>'+
                    '<div style="width: 30%;">'+function() {
                    if(data[i].prFlag==1){
                    return '未接收'
                    }else if(data[i].prFlag==2){
                    return '办理中'
                    } else if(data[i].prFlag==3){
                    return '待接收'
                    }else {
                    return '已办结'
                    }
                    }()+'</div>'+
                    '<div style="width: 30%;">'+data[i].createTime.substr(0,data[i].createTime.length-2)+'</div>'+
                    '</li> '
                    }
                }else{
                    str += '<div class="noData" style="text-align: center;border: none;">' +
                    '<img  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
                    '</div>';
                }
                $('.myfa').append(str)
             }
        })
        //我的发文详情
        $(document).on('click','.wofaDetail',function () {
            $.popWindow('/workflow/work/workformPreView?flowId='+$(this).attr('flowId')+'&flowStep='+$(this).attr('step')+'' +
            '&tabId='+$(this).attr('id')+'&tableName='+$(this).attr('tableName')+'&runId='+$(this).attr('runId')+'&' +
            'prcsId='+$(this).attr('realPrcsId')+'&isNomalType=false&hidden=true')
        })
    
        
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
        var myChart2 = echarts.init(document.getElementById('main2'));
        var myChart3 = echarts.init(document.getElementById('main3'));
        // 指定图表的配置项和数据
        $.ajax({
                type: 'post',
                url: '/document/selectWillCount',
                dataType: 'json',
                success:function(res) {
                    var option = {
                color: ['#66CCFF','#B6ED13'],
                title: {
                        text: '完成比例',
                        top: '10px',
                        left:'center',
                        textStyle:{
                            fontSize:16
                        }
                },
                //提示框组件,鼠标移动上去显示的提示内容
                tooltip: {
                        // show:false,
                        trigger: 'item',
                        formatter: "{a} <br/>{b}: {c} ({d}%)"//模板变量有 {a}、{b}、{c}、{d}，分别表示系列名，数据名，数据值，百分比。
                },
                //图例
                legend: {
                        //图例垂直排列
                        // orient: 'vertical',
                        bottom: 5,
                        //data中的名字要与series-data中的列名对应，方可点击操控
                        data:['待办收文','已办收文',]
                },
                series: [
                {
                        name:'',
                        type:'pie',
                        //饼状图
                        // radius: ['50%', '70%'],
                        avoidLabelOverlap: false,
                        //标签
                        label: {
                                normal: {
                                        show: true,
                                        position: 'inside',
                                        formatter: '{d}%',//模板变量有 {a}、{b}、{c}、{d}，分别表示系列名，数据名，数据值，百分比。{d}数据会根据value值计算百分比

                                        textStyle : {
                                                align : 'center',
                                                baseline : 'middle',
                                                fontFamily : '微软雅黑',
                                                fontSize : 15,
                                                fontWeight : 'bolder'
                                        }
                                },
                        },
                        data:[
                                {value:res.object.waitReceive, name:'待办收文'},
                                {value:res.object.overReceive, name:'已办收文'},
                        ]
                }
                ]
        };
                    myChart.setOption(option);
                    var option2 = {
    color: ['#FF8012','#FEC10E'],
        title: {
        text: '完成比例',
        top: '10px',
        left:'center'
        },
        //提示框组件,鼠标移动上去显示的提示内容
        tooltip: {
        // show:false,
        trigger: 'item',
        formatter: "{a} <br/>{b}: {c} ({d}%)"//模板变量有 {a}、{b}、{c}、{d}，分别表示系列名，数据名，数据值，百分比。
        },
        //图例
        legend: {
        //图例垂直排列
        // orient: 'vertical',
        bottom: 5,
        //data中的名字要与series-data中的列名对应，方可点击操控
        data:['待办发文','已办发文',]
        },
        series: [
        {
        name:'',
        type:'pie',
        //饼状图
        // radius: ['50%', '70%'],
        avoidLabelOverlap: false,
        //标签
        label: {
        normal: {
        show: true,
        position: 'inside',
        formatter: '{d}%',//模板变量有 {a}、{b}、{c}、{d}，分别表示系列名，数据名，数据值，百分比。{d}数据会根据value值计算百分比

        textStyle : {
        align : 'center',
        baseline : 'middle',
        fontFamily : '微软雅黑',
        fontSize : 15,
        fontWeight : 'bolder'
        }
        },
        },
        data:[
        {value:res.object.waitSend, name:'待办发文'},
        {value:res.object.overSend, name:'已办发文'},
        ]
        }
        ]
        };
                    myChart2.setOption(option2);
                    window.addEventListener('resize',function(){
                        myChart.resize();
                        myChart2.resize();
                    })
                 }
            })
       $.ajax({
            type: 'post',
            url: '/document/selectBytypeCount',
            dataType: 'json',
            success:function(res) {
                var data=res.object
                var arr=[]
                var arrData=[]
                for(var key in data){
                    arr.push(key)
                    arrData.push(data[key])
                }
                var option3 = {
        color: ['#7482D9'],
        tooltip: {
        trigger: 'axis',
        axisPointer: {            // 坐标轴指示器，坐标轴触发有效
        type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        }
        },
        grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
        },
        xAxis: [
        {
        type: 'category',
        data: arr,
        axisTick: {
        alignWithLabel: true
        }
        }
        ],
        yAxis: [
        {
        type: 'value'
        }
        ],
        series: [
        {
        name: '',
        type: 'bar',
        barWidth: '60%',
        data: arrData
        }
        ]
        };
                  myChart3.setOption(option3);
                window.addEventListener('resize',function(){
                    myChart3.resize();
                })
             }
        })
        </script>
</body>
</html>
