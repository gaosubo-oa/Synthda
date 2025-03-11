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
    <title><fmt:message code="dem.th.Poag" /></title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css?v=3.0">
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1" />
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" href="/css/workflow/work/automaticNumbering.css">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">

    <%--<link rel="stylesheet" type="text/css" href="../css/news/new_news.css"/>--%>
    <%--<link rel="stylesheet" type="text/css" href="../css/news/management_query.css" />--%>

    <!-- 门户设置  -->
    <script src="/js/xoajq/xoajq1.js"></script>
    <script src="../js/news/page.js"></script>

    <script src="../lib/laydate/laydate.js"></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/drag/dragSort.js?20200824"></script>

    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="/js/base/tablePage.js"></script>
    <script src="/js/common/basic.js"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <style>
        .total{
            width: 98%;
            margin: auto;
            margin-top: 118px;
        }
        .navigation{
            background: none;
            position: static;
            line-height: 0;
            height: 0;
            margin-bottom: -60px;


        }
        a {
            text-decoration: none;
            color: #207bd6;
            cursor: pointer;
        }
        select{
            padding: 5px 8px !important;
        }
        td{
            font-size: 11pt;
            line-height: 40px;
            word-break: keep-all;
            white-space: nowrap;
            text-overflow: ellipsis;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-align: center;
        }
        .query {
            width: 550px;
            margin: 133px auto;
        }
        b{
            color: red;
        }

        .all{
            padding-left: 38px;
            display: none;
        }
        .all li{
            margin: 5px 0;
        }

        .btnsava {
            padding: 5px 15px;
            border-radius: 4px;
            background: #2b7fe0;
            color: #fff;
        }
        .div_IMG{
            margin-left: 15px;
        }
        /*.layui-table-header thead{*/
        /*    display: none;*/
        /*}*/
        .layui-table th{
            text-align: center;
        }
        .demoTable{
            display: flex;
            justify-content: center;
            margin-top: 50px;
        }
        /*.layui-table-col-special{*/
        /*    width: 50%;*/
        /*}*/
        thead .layui-table-view .layui-form-checkbox[lay-skin=primary] i{
            display: none;
        }
        input[lay-filter="layTableAllChoose"] i{
            display: none;
        }
        .order_label {
            width: 170px;
        }
        .card_label {
            float: left;
            clear: none;
        }
        .layui-input-block {
            margin-left: 200px;
        }
        .layui-form-checked[lay-skin=primary] i {
            border-color: #5FB878!important;
            background-color: #5FB878;
            color: #fff!important;
        }
        
        #saveRule input[type=radio]{
            display: inline-block;
        }
        .layui-table-cell{
            margin-left: -35px;
        }
        .laytable-cell-1-0-1{
            margin-left: -5px;
        }
    </style>
</head>
<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
<body>
<div class="head-top">
    <ul class="clearfix">
        <li class="fl head-top-li active" data-type=""><fmt:message code="dem.th.Poag" /></li>

        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li" data-type="1" style=""><fmt:message code="home.page.setting.title" /></li>

<%--        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>--%>
        <li class="fl head-top-li" data-type="0" style="display: none">门户自动切换设置</li>
        <div style="padding-right:10px;" class="newBtn" id="user_btn">
        <div class="div_IMG">
        <img src="../img/sys/icon_newlyBuild.png" style="vertical-align: middle;" alt="新建">
        </div>
        <div class="div_txt"><fmt:message code="global.lang.new" /></div>
        </div>
    </ul>
</div>
<div class="navigation" style="margin-top: 66px;">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/daishen.png" alt="">
    <h2><fmt:message code="dem.th.Poag" /></h2>
</div>



<div class="portal" >
    <form id="queryNews">
        <table class="clearfix total" style="width: 70%">
            <thead>
            <tr style="font-size: 14px">
                <th><fmt:message code="vote.th.SortNumber" /></th>
                <th><fmt:message code="dem.th.PortalName" /></th>
                <th><fmt:message code="dem.th.PortaType" /></th>
                <th><fmt:message code="dem.th.PortalAddress" /></th>
                <th><fmt:message code="dem.th.Enabledstate" /></th>
                <th><fmt:message code="notice.th.operation" /></th>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </form>
</div>

<div class="portalTime" style="display: none">
    <div class="query">
        <div class="header">门户自动切换时间间隔</div>
        <form id="ajaxform" action="">
            <input type="hidden" name="read">
            <input type="hidden" name="sendTime">
            <table style="width: 100%">
                <tbody>

                <tr class="borderNone" >
                    <%--<td width="30%" class="color"><fmt:message code="notice.th.content"/>：</td>--%>
                    <td width="100%" colspan="2" >
                        <input id="times" style="padding-left: 10px;width: 50%;height: 30px;" type="text" placeholder="<fmt:message code="doc.th.enterTime" />" name="times"> <fmt:message code="system.th.second" />
                        <div> 说明:0秒（0表示不自动切换）</div>
                    </td>
                </tr>

                <tr class="borderNone">
                    <td colspan="2" style="text-align: center">
                        <a href="javascript:;" class="btnsava" onclick="ajaxtimes()"><fmt:message code="global.lang.ok" /></a>
                        <%--<a href="javascript:;" style="margin-left: 10px" class="btnsava chongtian"  ><fmt:message code="global.lang.refillings"/></a>--%>
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
    </div>
</div>

<div class="widget" style="margin-top: 100px;display: none ;width: 603px;margin: 100px auto;">
             <span style="font-size: 15px;font-weight: bold;"><fmt:message code="interfaceSetting.th.description" />：</span>
            <span style="color: red;font-size: 15px"><fmt:message code="interfaceSetting.th.selectWidgetsToEnableForAllUsers" /></span><br>
            <span style="color: red;font-size: 15px;margin-left: 49px"><fmt:message code="interfaceSetting.th.mobileWidgetEdit" /></span>
    <table class="layui-table" id="test"  lay-filter="test">

    </table>
    <div class="layui-btn-group demoTable">
        <button class="layui-btn" data-type="getCheckData" id="getCheckData"><fmt:message code="interfaceSetting.th.batchSetting" /></button>
    </div>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="score">设置</a>
</script>
<script>

    $(function () {
        var lang = getCookie('language');
        var portalName='';
        $.ajax({
            type:'post',
            url:'/portals/selPortals',
            dataType:'json',
            data:{
//                page:1,
//                pageSize:10,
            },
            success:function (json) {
                if(json.flag){
                    var v=1;
                    var arr=json.obj;
                    var str=''
                    var del=''
                    for(var i=0;i<arr.length;i++){

                        if(arr[i].portalLink==undefined){arr[i].portalLink=''}
                        if(arr[i].useFlag==undefined){arr[i].useFlag=''}
                        if(arr[i].useFlag=='1'){arr[i].useFlag='√'}
                        if(arr[i].useFlag=='0'){arr[i].useFlag='×'}

                        if(arr[i].portalType=='0'){
                            arr[i].portalTypeStr='<fmt:message code="global.lang.portal" />'
                            del='<fmt:message code="global.lang.delete" />'
                        }
                        if(arr[i].portalType=='1'){
                            arr[i].portalTypeStr='<fmt:message code="global.lang.stom" />'
                            del='<fmt:message code="global.lang.delete" />'
                        }
                        if(arr[i].portalType=='2'){
                            arr[i].portalTypeStr='站点门户'
                            del='<fmt:message code="global.lang.delete" />'
                        }
                        if(lang=='en_US'){
                            portalName=arr[i].portalName1;
                            console.log(portalName);
                        }else{
                            portalName=arr[i].portalName;
                            console.log(portalName);
                        }
                        str+='<tr><td>'+ arr[i].portalsNo +'</td>\
                  <td>'+portalName+'</td>\
                  <td>'+arr[i].portalTypeStr+'</td>\
                  <td>'+arr[i].portalLink+'</td>\
                  <td>'+arr[i].useFlag+'</td>\
                        <td>'
                            +'<a href="javascript:void (0)" class="newsBtntwo" onclick="stoprwo(' + arr[i].portalsId + ')"><fmt:message code="global.lang.edit" /></a>'+
                            function(){
                                if(arr[i].portalType == 0&&(arr[i].portalName=='我的门户'||arr[i].portalName=='应用门户')){
                                    return '<a href="javascript:void (0)" class="conSet" portalsId="'+ arr[i].portalsId+'" No="'+ arr[i].portalsNo+'" con="'+arr[i].portalName+'"><fmt:message code="global.lang.portalContentSetting" /></a>'
                                }
                                // else if(arr[i].portalName=='个人门户'){
                                //     return '<a href="javascript:void (0)" onclick="setOrder('+arr[i].portalsId+')">门户内容设置</a>'
                                // }
                                else if(arr[i].portalName=='运营效能'){
                                    return '<a href="javascript:void (0)" onclick="setOrder1('+arr[i].portalsId+')"><fmt:message code="global.lang.portalContentSetting" /></a>'
                                }
                                else {
                                    if(arr[i].portalType!='0'){
                                        return '<a href="javascript:void (0)" onclick="deleteList(' + arr[i].portalsId + ')">'+del+'</a>'
                                    }
                                    return '';
                                }
                            }()
                    '</td></tr>'
                    }
                    $('#queryNews table tbody').html(str)
                }
            }
        })
    })


        // 点击设置
       setOrder= function (Id) {
            var height = $(window).height();
            var layerHeight = height <= 420 ? '100%' : '420px';

            layui.use(['form'], function () {
                var form = layui.form;
                layer.open({
                    type: 1,
                    title: '个人门户设置',
                    btn: ['保存', '取消'],
                    btnAlign: 'c',
                    area: ['500px', layerHeight],
                    content: ['<div style="overflow:hidden;"><form class="layui-form layui-row card_form" style="padding: 20px 20px;overflow: hidden;">',
                        '<div class="layui-form-item layui-col-xs6 card_label" id="01">' +
                        '<label class="layui-form-label order_label">新闻</label>' +
                        '<div class="layui-input-block">' +
                        '<input type="checkbox" value="01" name="setOrder"  lay-skin="primary">' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-form-item layui-col-xs6 card_label" id="02">' +
                        '<label class="layui-form-label order_label">通知公告</label>' +
                        '<div class="layui-input-block">' +
                        '<input type="checkbox" value="02" name="setOrder" lay-skin="primary">' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-form-item layui-col-xs6 card_label" id="03">' +
                        '<label class="layui-form-label order_label">业务审批</label>' +
                        '<div class="layui-input-block">' +
                        '<input type="checkbox" value="03" name="setOrder" lay-skin="primary">' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-form-item layui-col-xs6 card_label" id="04">' +
                        '<label class="layui-form-label order_label">公文管理</label>' +
                        '<div class="layui-input-block">' +
                        '<input type="checkbox" value="04" name="setOrder" lay-skin="primary">' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-form-item layui-col-xs6 card_label" id="05">' +
                        '<label class="layui-form-label order_label">计划审核</label>' +
                        '<div class="layui-input-block">' +
                        '<input type="checkbox" value="05" name="setOrder" lay-skin="primary">' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-form-item layui-col-xs6 card_label" id="06">' +
                        '<label class="layui-form-label order_label">执行填报</label>' +
                        '<div class="layui-input-block">' +
                        '<input type="checkbox" value="06" name="setOrder" lay-skin="primary">' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-form-item layui-col-xs6 card_label" id="07">' +
                        '<label class="layui-form-label order_label">流程办理失效-总部各中心</label>' +
                        '<div class="layui-input-block">' +
                        '<input type="checkbox" value="07" name="setOrder" lay-skin="primary">' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-form-item layui-col-xs6 card_label" id="08">' +
                        '<label class="layui-form-label order_label">超过7天未办结流程TOP10</label>' +
                        '<div class="layui-input-block">' +
                        '<input type="checkbox" value="08" name="setOrder" lay-skin="primary">' +
                        '</div>' +
                        '</div>',
                        // '<div class="layui-form-item layui-col-xs6" style="clear: none;">' +
                        // '<label class="layui-form-label order_label">四模块</label>' +
                        // '<div class="layui-input-block">' +
                        // '<input type="radio" value="2" name="moduleType" lay-skin="primary">' +
                        // '</div>' +
                        // '</div>',
                        // '<div class="layui-form-item layui-col-xs6" style="clear: none;">' +
                        // '<label class="layui-form-label order_label">六模块</label>' +
                        // '<div class="layui-input-block">' +
                        // '<input type="radio" value="3" name="moduleType" lay-skin="primary">' +
                        // '</div>' +
                        // '</div>',
                        '</form></div>'].join(''),
                    success: function () {
                        $.get('/portals/updatePersonal',{ portalsId:Id}, function (res)     {
                            var cardOrderArr = cardOrderArr = ['01', '02', '03', '04', '05', '06'];
                          //  var moduleType = 3;
                            try {
                                if (res.flag && res.data) {
                                    //var cardOrderObj = JSON.parse(res.object);
                                    cardOrderArr = res.data;
                                //    moduleType = parseInt(cardOrderObj.moduleType);
                                }
                            } catch (e) {
                                console.log(e);
                            }

                            // for (var i = cardOrderArr.length; i > 0; i--) {
                            //     var $cardEle = $('#' + cardOrderArr[i - 1]);
                            //     var $cloneEle = $cardEle.clone();
                            //     $cardEle.remove();
                            //     $cloneEle.find('input[name="setOrder"]').prop('checked', true);
                            //     $('.card_form').prepend($cloneEle);
                            // }
                            cardOrderArr.forEach(function (item) {
                                //	$('input[value="'+item+'"]').prop('disabled','disabled')
                                $('input[value="'+item+'"]').prop('checked','true')
                                form.render()
                            })

                            // if (moduleType == 3) {
                            //     $('input[name="moduleType"]').eq(1).prop('checked', true);
                            // } else {
                            //     $('input[name="moduleType"]').eq(0).prop('checked', true);
                            // }

                            form.render();
                            // 拖拽
                          //  $('.card_label').arrangeable();
                        });
                    },
                    yes: function (index) {
                        var cardOrderArr = []
                        $('input[name="setOrder"]:checked').each(function () {
                            var key = $(this).val();
                            cardOrderArr.push(key);
                        });

                        var moduleType = $('input[name="moduleType"]:checked').val();

                        var cardOrderObj = {"cardOrder": cardOrderArr, "moduleType": moduleType}

                        $.post('/portals/updatePersonal', {mytableRight:cardOrderArr.join(","),portalsId:Id}, function (res) {
                            if (res.flag) {
                                window.location.reload();
                            } else {
                                layer.msg('保存失败！', {icon: 2, time: 2000});
                            }
                        });
                    }
                });
            });
        }

        setOrder1= function(Id){
            var height = $(window).height();
            var layerHeight = height <= 420 ? '100%' : '420px';

            layui.use(['form'], function () {
                var form = layui.form;
                layer.open({
                    type: 1,
                    title: '运营效能门户设置',
                    btn: ['保存', '取消'],
                    btnAlign: 'c',
                    area: ['500px', layerHeight],
                    content: ['<div style="overflow:hidden;"><form class="layui-form layui-row card_form" style="padding: 20px 20px;overflow: hidden;">',
                        '<div class="layui-form-item layui-col-xs6 card_label" id="01">' +
                        '<label class="layui-form-label order_label">流程办理实效-总部各中心</label>' +
                        '<div class="layui-input-block">' +
                        '<input type="checkbox" value="01" name="setOrder1" lay-skin="primary">' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-form-item layui-col-xs6 card_label" id="02">' +
                        '<label class="layui-form-label order_label">计划任务数量-总部各中心</label>' +
                        '<div class="layui-input-block">' +
                        '<input type="checkbox" value="02" name="setOrder1" lay-skin="primary">' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-form-item layui-col-xs6 card_label" id="03">' +
                        '<label class="layui-form-label order_label">流程应用频率排行TOP10</label>' +
                        '<div class="layui-input-block">' +
                        '<input type="checkbox" value="03" name="setOrder1" lay-skin="primary">' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-form-item layui-col-xs6 card_label" id="04">' +
                        '<label class="layui-form-label order_label">流程被回退次数周排行TOP10</label>' +
                        '<div class="layui-input-block">' +
                        '<input type="checkbox" value="04" name="setOrder1" lay-skin="primary">' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-form-item layui-col-xs6 card_label" id="05">' +
                        '<label class="layui-form-label order_label">流程办理时效-直属单位</label>' +
                        '<div class="layui-input-block">' +
                        '<input type="checkbox" value="05" name="setOrder1" lay-skin="primary">' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-form-item layui-col-xs6 card_label" id="06">' +
                        '<label class="layui-form-label order_label">超过7天未办理流程TOP10</label>' +
                        '<div class="layui-input-block">' +
                        '<input type="checkbox" value="06" name="setOrder1" lay-skin="primary">' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-form-item layui-col-xs6 card_label" id="07">' +
                        '<label class="layui-form-label order_label">超过7天未办结节点流程TOP10</label>' +
                        '<div class="layui-input-block">' +
                        '<input type="checkbox" value="07" name="setOrder1" lay-skin="primary">' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-form-item layui-col-xs6 card_label" id="07">' +
                        '<label class="layui-form-label order_label">计划管理看板</label>' +
                        '<div class="layui-input-block">' +
                        '<input type="checkbox" value="08" name="setOrder1" lay-skin="primary">' +
                        '</div>' +
                        '</div>',
                        '<div style="clear: both;">' +
                        '</div>',
                        '</form></div>'].join(''),
                    success: function () {
                        $.get('/portals/updatePersonal', { portalsId:Id } , function (res) {
                            var cardOrderArr = cardOrderArr = ['01', '02', '03', '04', '05', '06'];
                            //  var moduleType = 3;
                            try {
                                if (res.flag && res.data) {
                                    // var cardOrderObj = JSON.parse(res.object);
                                    cardOrderArr = res.data;
                                    //    moduleType = parseInt(cardOrderObj.moduleType);
                                }
                            } catch (e) {
                                console.log(e);
                            }

                            // for (var i = cardOrderArr.length; i > 0; i--) {
                            //     var $cardEle = $('#' + cardOrderArr[i - 1]);
                            //     var $cloneEle = $cardEle.clone();
                            //     $cardEle.remove();
                            //     $cloneEle.find('input[name="setOrder"]').prop('checked', true);
                            //     $('.card_form').prepend($cloneEle);
                            // }
                            cardOrderArr.forEach(function (item) {
                                //	$('input[value="'+item+'"]').prop('disabled','disabled')
                                $('input[value="'+item+'"]').prop('checked','true')
                                form.render()
                            })

                            // if (moduleType == 3) {
                            //     $('input[name="moduleType"]').eq(1).prop('checked', true);
                            // } else {
                            //     $('input[name="moduleType"]').eq(0).prop('checked', true);
                            // }

                            form.render();
                            // 拖拽
                            //  $('.card_label').arrangeable();
                        });
                    },
                    yes: function (index) {
                        var cardOrderArr = []
                        $('input[name="setOrder1"]:checked').each(function () {
                            var key = $(this).val();
                            cardOrderArr.push(key);
                        });

                        var moduleType = $('input[name="moduleType"]:checked').val();

                        var cardOrderObj = {"cardOrder": cardOrderArr, "moduleType": moduleType}

                        $.post('/portals/updatePersonal', {mytableRight:cardOrderArr.join(","),portalsId:Id}, function (res) {
                            if (res.flag) {
                                window.location.reload();
                            } else {
                                layer.msg('保存失败！', {icon: 2, time: 2000});
                            }
                        });
                    }
                });
            });
        }


    //点击内容设置
    $(document).on('click','.conSet',function(){
        var con = $(this).attr('con');
        var No = $(this).attr('No');
        var portalsId = $(this).attr('portalsId')

        if(portalsId == '1'){
            window.location.href='/portals/conSetting?N0='+No+'&portalsId='+portalsId
        }else if(portalsId == '2'){
            window.location.href='/portals/appPortal?N0='+No+'&portalsId='+portalsId
        }else{
            window.location.href='/portals/manaPortal?N0='+No+'&portalsId='+portalsId
        }

    })

    function portal() {
        $('.navigation h2').html('<fmt:message code="dem.th.Poag" />');
        $('.navigation img').prop('src','/img/commonTheme/${sessionScope.InterfaceModel}/daishen.png')
    }
    function portalTime() {
        $('.navigation h2').html('门户自动切换设置');
        $('.navigation img').attr('src','/img/commonTheme/${sessionScope.InterfaceModel}/yishen.png')
    }
    function widget() {
        $('.navigation h2').html('移动端首页设置');
        $('.navigation img').attr('src','/img/commonTheme/${sessionScope.InterfaceModel}/yishen.png')
    }
    var lang = getCookie('language');
    var arr = ''
    layui.use('table', function() {
        var table = layui.table;
        table.render({
            elem: '#test'
            ,url:'/widget/selAllWidgetModel'
            ,cols: [[
                {type:'checkbox',fixed: 'left',width:120}
                ,{field:'id',width:150, title: '<fmt:message code="interfaceSetting.th.serialNumber" />', sort: true}
                ,{field:lang==='en_US' ? 'data':'name',width:400, title: '<fmt:message code="interfaceSetting.th.portalName" />'}
                // , {field: 'type', title: '操作', toolbar: '#barDemo'}
            ]]
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    // "count": res.total, //解析数据长度
                    "data": res.obj //解析数据列表
                };
            }
            ,done:function (res) {
                console.log(res)
                var datas = res.data;
                for(var i=0; i<datas.length; i++){
                    if(datas[i].isOn == '1'){
                        datas[i]["LAY_CHECKED"] = 'true';
                        var index= datas[i]['LAY_TABLE_INDEX'];
                        $('tr[data-index=' + index + '] input[type="checkbox"]').prop('checked', true);
                        $('tr[data-index=' + index + '] input[type="checkbox"]').next().addClass('layui-form-checked');
                    }
                }
            }
            // ,page: true
        });

        $('.laytable-cell-1-0-0').append("<span style='color: red;margin-right: -39px;margin-left: 10px;font-size: 15px'><fmt:message code="interfaceSetting.th.enable" /></span>");

        $('#getCheckData').click(function(){
            var chooseArr = layui.table.checkStatus('test').data;
            if(chooseArr.length == 0){
                layer.alert('请至少选择一个门户！', {icon: 7})
            }else{
                var strId = ''
                for(var i=0;i<chooseArr.length;i++){
                    strId +=chooseArr[i].id +','
                }
                $.ajax({
                    type:'post',
                    url:'/widget/updateAllWidgetSet',
                    dataType:'json',
                    data: {
                        moduleIds: strId
                    },
                    success:function(res){
                        layer.alert('设置成功！', {icon: 1})
                    }
                })
            }

        })




        table.on('tool(test)', function(obj){
            var data = obj.data;
            if(obj.event === 'score'){
                $.ajax({
                    type:'post',
                    url:'/widget/updateAllWidgetSet',
                    dataType:'json',
                    data: {
                        moduleIds: data.id +','
                    },
                    success:function(res){

                    }
                })
            }
        })
    });

    $('.head-top li').click(function () {
        $(this).siblings('li').removeClass('active')
        $(this).addClass('active')
        if($(this).attr('data-type')==''){
            portal()
            $('.portalTime').hide()
            $('.portal').show()
            $('.newBtn').show()
            $('.widget').hide()
        }else if($(this).attr('data-type')=='0'){
            portalTime()
            $('.portalTime').show()
            $('.portal').hide()
            $('.newBtn').hide()
            $('.widget').hide()

            $.ajax({
                type:'post',
                url:'/syspara/selectTheSysPara',
                dataType:'json',
                data: {
                    paraName:'PORTALS_TIME'
                },
                success:function(res){
                    var obj = res.object;
                    if(obj[0].paraValue != ''&&obj[0].paraValue !=undefined){
                        $('#times').val(obj[0].paraValue)
                    }

                }
            })
        }else if($(this).attr('data-type')=='1'){
            widget()
            $('.widget').show()
            $('.portalTime').hide()
            $('.portal').hide()
            $('.newBtn').hide()
        }
    })
    portal()

    //新建
    $('#user_btn').on('click',function () {

        layer.open({
            type: 1,
            title:['<fmt:message code="global.lang.new" />', 'background-color:#2b7fe0;color:#fff;'],
            area: ['730px', '500px'],
            shadeClose: true, //点击遮罩关闭
            // btn: ['创建', '取消'],
            content:'<form id="saveRule" class="layui-form"><div class="inputlayout" style="overflow-y: hidden;">' +
            '<ul>' +
            '<li class="clearfix">' +
            '<label><fmt:message code="vote.th.SortNumber" /> ：</label><input id="deptNos" type="text" name="portalsNo" value=""><b style="padding-left: 10px;">* </b>' +
            '</li>' +
            '<li class="clearfix">' +
            '<label><fmt:message code="dem.th.PortalName" /> ：</label><input type="text" name="portalName" value=""><b style="padding-left: 10px;">* </b>' +
            '</li>' +
            '<li class="clearfix">' +
            '<label><fmt:message code="dem.th.PortaType" />：</label>' +
            ' <select style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" class="portalType" name="portalType">'+
//                '<option value="">请选择</option>'+
            '<option value="0"><fmt:message code="global.lang.portal" /></option>'+
            '<option value="1"><fmt:message code="global.lang.stom" /></option>'+
            '<option value="2">站点门户</option>'+
            '</select>' +
            '</li>' +
            '<li class="clearfix xadres" style="display:none">' +
            '<label><fmt:message code="global.lang.dfgsht" />：</label><input type="text" name="portalLink">' +
            '</li>' +
            '<li class="clearfix zadres" style="display:none">' +
            '<label><fmt:message code="global.lang.dutr" /> ：</label><input type="text" name="moduleId" value="">' +
            '</li>' +
            '<li class="clearfix siteres" style="display:none">' +
            '<label>站点门户地址：</label>' +
            ' <select style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" class="siteadress" name="siteadress">'+
            '</select>' +
            '</li>' +
            '<li class="clearfix">' +
            '<label><fmt:message code="dem.th.shry" />：</label>' +
            ' <select style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" name="useFlag">'+
//                '<option value="">请选择</option>'+
            '<option value="0"><fmt:message code="three.th.Disable" /></option>'+
            '<option value="1"><fmt:message code="user.th.kjnf" /></option>'+
            '</select><b style="padding-left: 10px;">* </b>   ' +
            '</li>' +
            '<li class="clearfix">' +
            '<label><fmt:message code="interfaceSetting.th.openInNewWindow" />：</label>' +
            '<input type="radio" name="newWindow" value="0" checked style="vertical-align: middle;" /><span><fmt:message code="interfaceSetting.th.yes" /></span>'+
            '<input type="radio" name="newWindow"  value="1" style="vertical-align: middle;"/><span><fmt:message code="interfaceSetting.th.no" /></span>'+
            '</li>' +
            '<li class="clearfix">' +
            '<label><fmt:message code="doc.th.Licen" /> ：</label>' +
            '<input readonly type="text" name="accessPrivDept" id="accessPrivDept" /><b style="padding-left: 10px;"> </b>'+
            '<a style="margin: 0 10px;" class="deptAdd"><fmt:message code="global.lang.add" /></a>'+
            '<a class="deptClear"><fmt:message code="global.lang.empty" /></a>'+
            '</li>' +
            '<li class="clearfix">' +
            '<label><fmt:message code="doc.th.Autho" /> ：</label>' +
            '<input type="text" readonly name="accessPrivPriv" id="accessPrivPriv"  class="BigInput" value="" privid="" userpriv=""><b style="padding-left: 10px;"> </b>'+
            '<a style="margin: 0 10px;" href="javascript:;" class="userPrivAdd" name="orgAdd" ><fmt:message code="global.lang.add" /></a>'+
            '<a href="javascript:;" class="userPrivClear" name="orgClear"><fmt:message code="global.lang.empty"/></a>'+
            '</li>' +
            '<li class="clearfix">' +
            '<label><fmt:message code="attend.th.Authorized" /> ：</label>' +
            '<input type="text" name="accessPrivUser" id="accessPrivUser" readonly/><b style="padding-left: 10px;"> </b>'+
            '<a style="margin: 0 10px;" class="userAdd"><fmt:message code="global.lang.add" /></a>'+
            '<a class="userClear"><fmt:message code="global.lang.empty" /></a>'+
            '</li>' +
            '</ul>' +
            '</div></form>',
            btn: ['<fmt:message code="global.lang.save" />','<fmt:message code="depatement.th.quxiao" />'],
            btn1: function (index) {
                if ($('[name="portalsNo"]').val() == "") {
                    $.layerMsg({ content: '<fmt:message code="netdisk.th.trhr" />', icon: 2 });
                    return false;
                };
                if ($('[name="portalType"]').val() == "") {
                    $.layerMsg({ content: '<fmt:message code="netdisk.th.tyjb" />', icon: 2 });
                    return false;
                };
                if ($('[name="portalName"]').val() == "") {
                    $.layerMsg({ content: '<fmt:message code="netdisk.th.tyjo" />', icon: 2 });
                    return false;
                };

                if($('#accessPrivDept').val()==''&&$('#accessPrivPriv').val()==''&&$('#accessPrivUser').val()==''){
                    var accessPriv = 0;

                }else{
                    var accessPriv = 1

                }
//                    if ($('#accessPrivDept').attr('deptid') == "" || $('#accessPrivDept').attr('deptid') == undefined) {
//                        $.layerMsg({ content: '请填写授权部门', icon: 2 });
//                        return false;
//                    };
//                    if ($('#accessPrivPriv').attr('userpriv') == "" || $('#accessPrivPriv').attr('userpriv') == undefined) {
//                        $.layerMsg({ content: '请填写授权角色', icon: 2 });
//                        return false;
//                    };
//                    if ($('#accessPrivUser').attr('user_id') == "" || $('#accessPrivUser').attr('user_id') == undefined) {
//                        $.layerMsg({ content: '请填写授权用户', icon: 2 });
//                        return false;
//                    };
                $.ajax({
                    type:'post',
                    url:'/portals/add',
                    dataType:'json',
                    data:{
                        portalsNo:$('[name="portalsNo"]').val(),
                        portalName:$('[name="portalName"]').val(),
                        moduleId:$('[name="moduleId"]').val(),
                        siteModuleId: $('select[name="siteadress"] option:checked').val(),
                        portalLink:$('[name="portalLink"]').val(),
                        portalType: $('select[name="portalType"] option:checked').val(),
                        useFlag: $('select[name="useFlag"] option:checked').val(),
                        accessPrivDept: $('#accessPrivDept').attr('deptid')||'',
                        accessPrivPriv: $('#accessPrivPriv').attr('userpriv')||'',
                        accessPrivUser: $('#accessPrivUser').attr('user_id')||'',
                        accessPriv:accessPriv,
                        newWindow:$('[name="newWindow"]:checked').val()
                    },
                    success: function(json){
                        if(json.flag == true){
                            layer.msg('保存成功！', { icon: 1, time: 2500 }, function () {
                                location.reload();
                            });
                        }else{
                            layer.msg('保存失败！', { icon: 2, time: 2500 })
                        }
                    }
                });
            },
            success:function(res){

                $.ajax({
                    type:'post',
                    url:'/cmsSite/getSiteList',
                    dataType:'json',
                    success:function(res){
                        var data = res.data;
                        var arrs = [];
                        for(var i=0;i<data.length;i++){
                            var obj = {};
                            obj.name = data[i].siteName;
                            obj.value = data[i].sid;
                            arrs.push(obj)
                        }
                        fillsel('siteadress',arrs,'value','name')
                    }

                })

                if($('.portalType option:selected').val()=='0'){
//                    $('select[name="portalType"]').attr("disabled","disabled")
                    $('input[name="portalLink"]').attr("disabled","disabled")
                    $('.xadres').show()
                    $('.zadres').hide()
                    $('.siteres').hide()
                }
                if($('.portalType option:selected').val()=='1'){

                    $('.zadres').show()
                    $('.xadres').hide()
                    $('.siteres').hide()
                }

                if($('.portalType option:selected').val()=='2'){

                    $('.zadres').hide()
                    $('.xadres').hide()
                    $('.siteres').show()
                }
                //限制排序号只能输入三位有效数字
                var text2 = document.getElementById("deptNos");
                text2.onkeyup = function(){
                    this.value=this.value.replace(/\D/g,'');
                    if(text2.value.length>3){
                        text2.value = '';
                    }
                }

                $('.portalType').change(function () {
                    if($('.portalType option:selected').val()=='0'){
                        $('.xadres').show();
                        $('.zadres').hide();
                        $('.siteres').hide();
                    }
                    if($('.portalType option:selected').val()=='1'){
                        $('.zadres').show();
                        $('.xadres').hide();
                        $('.siteres').hide();
                    }
                    if($('.portalType option:selected').val()=='2'){
                        $('.zadres').hide()
                        $('.xadres').hide()
                        $('.siteres').show()
                    }
                })



                if(res.flag){
                }
            },

        });

    })

    //编辑

    function stoprwo(me){
        $.ajax({
            type:'post',
            url:'/portals/selPortalsById',
            dataType:'json',
            data: {
                portalsId: me
            },
            success:function(res){
                if(res.flag){
                    var data=res.object;
                    if(data.moduleId==undefined){data.moduleId=''}
                    if(data.portalLink==undefined){data.portalLink=''}
                    var moduleId = data.moduleId;
                    var portalType = data.portalType;
                    layer.open({
                        type: 1,
                        title:['<fmt:message code="global.lang.edit" />', 'background-color:#2b7fe0;color:#fff;'],
                        area: ['700px', '500px'],
                        shadeClose: true, //点击遮罩关闭
                        // btn: ['创建', '取消'],
                        content:'<form id="saveRule" class="layui-form"><div class="inputlayout">' +
                        '<ul>' +
                        '<li class="clearfix">' +
                        '<label><fmt:message code="vote.th.SortNumber" /> ：</label><input id="deptNos" type="text" name="portalsNo" value="'+data.portalsNo+'"><b style="padding-left: 10px;">* </b>' +
                        '</li>' +
                        '<li class="clearfix">' +
                        '<label><fmt:message code="dem.th.PortalName" /> ：</label><input type="text" name="portalName" value="'+data.portalName+'"><b style="padding-left: 10px;">* </b>' +
                        '</li>' +
                        '<li class="clearfix">' +
                        '<label><fmt:message code="dem.th.PortaType" />：</label>' +
                        ' <select style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" class="portalType" name="portalType">'+
//                '<option value="">请选择</option>'+
                        '<option value="0"><fmt:message code="global.lang.portal" /></option>'+
                        '<option value="1"><fmt:message code="global.lang.stom" /></option>'+
                        '<option value="2">站点门户</option>'+
                        '</select>' +
                        '</li>' +
                        '<li class="clearfix xadres" style="display:none">' +
                        '<label><fmt:message code="global.lang.dfgsht" />：</label><input type="text" name="portalLink" value="'+data.portalLink+'">' +
                        '</li>' +
                        '<li class="clearfix zadres" style="display:none">' +
                        '<label><fmt:message code="global.lang.dutr" />  ：</label><input type="text" name="moduleId" value="'+data.moduleId+'">' +
                        '</li>' +
                        '<li class="clearfix siteres" style="display:none">' +
                        '<label>站点门户地址：</label>' +
                        ' <select style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" class="siteadress" name="siteadress">'+
                        '</select>' +
                        '</li>' +
                        '<li class="clearfix">' +
                        '<label><fmt:message code="dem.th.shry" />：</label>' +
                        ' <select style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" name="useFlag">'+
//                '<option value="">请选择</option>'+
                        '<option value="0"><fmt:message code="three.th.Disable" /></option>'+
                        '<option value="1"><fmt:message code="user.th.kjnf" /></option>'+
                        '</select><b style="padding-left: 10px;">* </b>   ' +
                        '</li>' +
                        '<li class="clearfix">' +
                        '<label>是否新窗口打开：</label>' +
                        '<input type="radio" name="newWindow" value="0" checked style="vertical-align: middle;" /><span>否</span>'+
                        '<input type="radio" name="newWindow"  value="1" style="vertical-align: middle;"/><span>是</span>'+
                        '</li>' +
                        '<li class="clearfix">' +
                        '<label><fmt:message code="depatement.th.serh" />：</label>' +
                        ' <select style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" class="uxo" name="accessPriv">'+
//                '<option value="">请选择</option>'+
                        '<option value="0"><fmt:message code="depatement.th.gsbf" /></option>'+
                        '<option value="1"><fmt:message code="netdisk.th.ryhndf" /></option>'+
                        '</select><b style="padding-left: 10px;"> </b>   ' +
                        '</li>' +
                        '<div class="all">' +
                        '<li class="clearfix">' +
                        '<label><fmt:message code="doc.th.Licen" /> ：</label>' +
                        '<input type="text" name="accessPrivDept" id="accessPrivDept" /><b style="padding-left: 10px;"> </b>'+
                        '<a style="margin: 0 10px;" class="deptAdd"><fmt:message code="global.lang.add" /></a>'+
                        '<a class="deptClear"><fmt:message code="global.lang.empty" /></a>'+
                        '</li>' +
                        '<li class="clearfix">' +
                        '<label><fmt:message code="doc.th.Autho" /> ：</label>' +
                        '<input type="text" name="accessPrivPriv" id="accessPrivPriv"  class="BigInput" value="" privid="" userpriv=""><b style="padding-left: 10px;"></b>'+
                        '<a style="margin: 0 10px;" href="javascript:;" class="userPrivAdd" name="orgAdd" ><fmt:message code="global.lang.add" /></a>'+
                        '<a href="javascript:;" class="userPrivClear" name="orgClear"><fmt:message code="global.lang.empty"/></a>'+
                        '</li>' +
                        '<li class="clearfix">' +
                        '<label><fmt:message code="attend.th.Authorized" /> ：</label>' +
                        '<input type="text" name="accessPrivUser" id="accessPrivUser" /><b style="padding-left: 10px;"> </b>'+
                        '<a style="margin: 0 10px;" class="userAdd"><fmt:message code="global.lang.add" /></a>'+
                        '<a class="userClear"><fmt:message code="global.lang.empty" /></a>'+
                        '</li>' +
                        '</div>' +
                        '</ul>' +
                        '</div></form>',
                        btn: ['<fmt:message code="global.lang.save" />','<fmt:message code="depatement.th.quxiao" />'],
                        success:function(res){
                            checkehuo('portalType', data.portalType);
                            checkehuo('useFlag', data.useFlag);
                            // if(data.accessPrivDept==""&&data.accessPrivPriv=='')
                            checkehuo('accessPriv', data.accessPriv);
                            $("[name='newWindow'][value='"+data.newWindow+"']").prop("checked","checked");

                            $.ajax({
                                type:'post',
                                url:'/cmsSite/getSiteList',
                                dataType:'json',
                                success:function(res){
                                    var data = res.data;
                                    var arrs = [];
                                    for(var i=0;i<data.length;i++){
                                        var obj = {};
                                        obj.name = data[i].siteName;
                                        obj.value = data[i].sid;
                                        arrs.push(obj)
                                    }
                                    fillsel('siteadress',arrs,'value','name');
                                    if(portalType!=undefined&&portalType==2){
                                        $(".siteadress").find("option[value="+moduleId+"]").attr("selected",true);
                                    }
                                }

                            })

                            if($('.portalType option:selected').val()=='0'){
                                $('select[name="portalType"]').attr("disabled","disabled")
                                $('input[name="portalLink"]').attr("disabled","disabled")
                                $('.xadres').show()
                                $('.zadres').hide()
                                $('.siteres').hide()
                            }
                            if($('.portalType option:selected').val()=='1'){

                                $('.zadres').show()
                                $('.xadres').hide()
                                $('.siteres').hide()
                            }

                            if($('.portalType option:selected').val()=='2'){

                                $('.zadres').hide()
                                $('.xadres').hide()
                                $('.siteres').show()
                            }


                            if($('.uxo option:selected').val()=='0'){
                                $('.all').hide()
                            } else {
                                $('.all').show()
                            }

                            //限制排序号只能输入三位有效数字
                            var text2 = document.getElementById("deptNos");
                            text2.onkeyup = function(){
                                this.value=this.value.replace(/\D/g,'');
                                if(text2.value.length>3){
                                    text2.value = '';
                                }
                            }



                            $('.portalType').change(function () {
                                if($('.portalType option:selected').val()=='0'){
                                    $('.xadres').show();
                                    $('.zadres').hide();
                                    $('.siteres').hide();
                                }
                                if($('.portalType option:selected').val()=='1'){
                                    $('.zadres').show();
                                    $('.xadres').hide();
                                    $('.siteres').hide();
                                }
                                if($('.portalType option:selected').val()=='2'){
                                    $('.zadres').hide()
                                    $('.xadres').hide()
                                    $('.siteres').show()
                                }


                            })

                            $('.uxo').change(function () {

                                if($('.uxo option:selected').val()=='0'){
                                    $('.all').hide()
                                }
                                if($('.uxo option:selected').val()=='1'){
                                    $('.all').show()
                                }

                            })



                            var privt = data.privDept;
                            var priv = data.privPriv;
                            var priu = data.privUser;
                            var sr1='',sr11='',sr2='',sr22='',sr3='',sr33=''
                            if(data.privDept!='' && data.privDept!=undefined){
                                for(var i=0;i<privt.length;i++){
                                    sr1 += privt[i].deptName+',';
                                    sr11 += privt[i].deptId+','
                                }
                                $('#accessPrivDept').val(sr1)
                                $('#accessPrivDept').attr('deptid', sr11)
                            }

                            if(data.privPriv!='' && data.privPriv!=undefined){
                                for(var i=0;i<priv.length;i++){
                                    sr2 += priv[i].privName+',';
                                    sr22 += priv[i].userPriv+','
                                }
                                $('#accessPrivPriv').val(sr2)
                                $('#accessPrivPriv').attr('userpriv', sr22)
                            }

                            if(data.privUser!='' && data.privUser!=undefined){
                                for(var i=0;i<priu.length;i++){
                                    sr3 += priu[i].userName+',';
                                    sr33 += priu[i].userId+','
                                }
                                $('#accessPrivUser').val(sr3)
                                $('#accessPrivUser').attr('user_id', sr33)
                            }




                        },
                        yes: function (index) {
                            if ($('[name="portalsNo"]').val() == "") {
                                $.layerMsg({ content: '<fmt:message code="netdisk.th.trhr" />', icon: 2 });
                                return false;
                            };
                            if ($('[name="portalName"]').val() == "") {
                                $.layerMsg({ content: '<fmt:message code="netdisk.th.tyjo" />', icon: 2 });
                                return false;
                            };
//                    if ($('#accessPrivDept').attr('deptid') == "" || $('#accessPrivDept').attr('deptid') == undefined) {
//                        $.layerMsg({ content: '请填写授权部门', icon: 2 });
//                        return false;
//                    };
//                    if ($('#accessPrivPriv').attr('userpriv') == "" || $('#accessPrivPriv').attr('userpriv') == undefined) {
//                        $.layerMsg({ content: '请填写授权角色', icon: 2 });
//                        return false;
//                    };
//                    if ($('#accessPrivUser').attr('user_id') == "" || $('#accessPrivUser').attr('user_id') == undefined) {
//                        $.layerMsg({ content: '请填写授权用户', icon: 2 });
//                        return false;
//                      };
                            $.ajax({
                                type:'post',
                                url:'/portals/update',
                                dataType:'json',
                                data:{
                                    portalsId: me,
                                    portalsNo:$('[name="portalsNo"]').val(),
                                    portalName:$('[name="portalName"]').val(),
                                    moduleId:$('[name="moduleId"]').val(),
                                    portalLink:$('[name="portalLink"]').val(),
                                    siteModuleId: $('select[name="siteadress"] option:checked').val(),
                                    portalType: $('select[name="portalType"] option:checked').val(),
                                    accessPriv: $('select[name="accessPriv"] option:checked').val(),
                                    useFlag: $('select[name="useFlag"] option:checked').val(),
                                    accessPrivDept: $('#accessPrivDept').attr('deptid')||'',
                                    accessPrivPriv: $('#accessPrivPriv').attr('userpriv')||'',
                                    accessPrivUser: $('#accessPrivUser').attr('user_id')||'',
                                   // portalsShow:'',
                                    //portalsMenu:'',
                                   // showNum:'',
                                    newWindow:$('[name="newWindow"]:checked').val()
                                },
                                success: function(json){
                                    if(json.flag == true){
                                        layer.msg('编辑成功！', { icon: 1, time: 2500 }, function () {
                                            location.reload();
                                        });
                                    }else{
                                        layer.msg('编辑失败！', { icon: 2, time: 2500 })
                                    }
                                }
                            });

                        },

                    });
                }

            }

        });
    }

    function checkehuo(name, val) {
        if (val == '') {
            return;
        }
        $('[name="' + name + '"]').find('option').each(function(i, n) {
            if ($(this).val() == val) {
                $(this).attr('selected', 'selected')
            } else {
                $(this).removeAttr('selected', 'selected')
            }
        })
    }
    // 获取角色信息控件
    $(document).on("click",".userPrivAdd",function(){
        priv_id="accessPrivPriv";
        $.popWindow("../common/selectPriv");
    });
    // 清空角色信息
    $(document).on('click','.userPrivClear',function () {
        $('#accessPrivPriv').attr("privid","");
        $('#accessPrivPriv').attr("userpriv","");
        $('#accessPrivPriv').val("");
    });

    // 获取部门信息控件
    $(document).on("click",".deptAdd",function(){
        dept_id="accessPrivDept";
        $.popWindow("../common/selectDept");
    });
    // 清空部门信息
    $(document).on('click','.deptClear',function () {
        $('#accessPrivDept').attr("deptid","");
        $('#accessPrivDept').attr("deptno","");
        $('#accessPrivDept').val("");
    });

    //选人控件
    $(document).on("click",".userAdd",function(){
        user_id='accessPrivUser';
        $.popWindow("../common/selectUser");

    });
    // 清空用户信息
    $(document).on('click','.userClear',function () {
        $('#accessPrivUser').attr("username","");
        $('#accessPrivUser').attr("user_id","");
        $('#accessPrivUser').attr("dataid","");
        $('#accessPrivUser').attr("userprivname","");
        $('#accessPrivUser').val("");
    });

    function deleteList(me) {

        layer.confirm('<fmt:message code="attend.th.qued" />？', {
            btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'], //按钮
            title: "<fmt:message code="event.th.DeleteInformation" />"
        }, function() {
            //确定删除，调接口
            $.ajax({
                type: 'post',
                url: '/portals/deletePortals',
                dataType: 'json',
                data: {
                    portalsIds: me
                },
                success: function(res) {
                    if (res.flag) {
                        $.layerMsg({ content: '<fmt:message code="workflow.th.delsucess" />！', icon: 1 });
                    } else {
                        $.layerMsg({ content: '<fmt:message code="lang.th.deleSucess" />！', icon: 1 });
                    }
                    location.reload();
                }
            })
        }, function() {

            layer.closeAll();
        });

    }

    // 时间


    var text3 = document.getElementById("times");
    text3.onkeyup = function(){
        this.value=this.value.replace(/\D/g,'');
    }

    function ajaxtimes() {
        var tm = $('#times').val()
        $.ajax({
            type:'post',
            url:'/syspara/updateSysParaByParaName',
            dataType:'json',
            data: {
                paraName:'PORTALS_TIME',
                paraValue: tm
            },
            success:function(res){
                if(res.flag){
                    $.layerMsg({content:'<fmt:message code="depatement.th.Modifysuccessfully" />',icon:1})
                }
            }
        })
    }


</script>

</body>
</html>
