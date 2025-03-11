<%--http://localhost:8084/portals/conSetting?N0=1&portalsId=1http://localhost:8084/portals/conSetting?N0=1&portalsId=1--%>
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
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="dem.th.Poag"/></title>
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1"/>
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" href="/css/workflow/work/automaticNumbering.css">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">

    <%--<link rel="stylesheet" type="text/css" href="../css/news/new_news.css"/>--%>
    <%--<link rel="stylesheet" type="text/css" href="../css/news/management_query.css" />--%>

    <!-- 门户设置  -->
    <script src="/js/xoajq/xoajq1.js"></script>

    <script src="../js/news/page.js"></script>

    <script src="../lib/laydate.js"></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>


    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="/js/base/tablePage.js"></script>
    <script src="/js/common/basic.js"></script>
    <%--<script src="http://www.jq22.com/jquery/1.9.1/jquery.min.js"></script>--%>
    <script src="/js/portal/jquery-ui.min.js "></script>
    <script src="/js/portal/jquery.touch-punch.min.js"></script>
    <script src="/js/portal/jquery.shapeshift.js"></script>

    <script src="/lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20200924.1" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js" type="text/javascript" charset="utf-8"></script>

    <style>
        html, body {
            width: 100%;
            height: 100%;
            background: #fff;
        }

        .total {
            width: 98%;
            margin: auto;
            margin-top: 118px;
        }

        .navigation {
            /*background: none;*/

        }

        a {
            text-decoration: none;
            color: #207bd6;
            cursor: pointer;
        }

        select {
            padding: 5px 8px !important;
        }

        td {
            font-size: 11pt;
            line-height: 19px;
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

        b {
            color: red;
        }

        .all {
            padding-left: 38px;
            display: none;
        }

        .all li {
            margin: 5px 0;
        }

        .btnsava {
            padding: 5px 15px;
            border-radius: 4px;
            background: #2b7fe0;
            color: #fff;
        }

        .div_IMG {
            margin-left: 15px;
        }

        .portalTime {
            margin-top: 60px;
        }

        table {
            width: 80%;
            margin: 0 auto;
        }

        table tr td:nth-child(1) {
            width: 30%;
        }

        table tr {
            border: none;
        }

        table tbody tr:hover:hover {
            background: none
        }

        .container {
            border: 1px dashed #CCC;
            position: relative;
            min-height: 100px;
            display: flex;
            flex-wrap: wrap;
            /*text-align: left;*/
        }

        .container > div {
            /*background: #AAA;*/
            position: relative;
            height: 100px;
            width: 100px;
        }

        .container > .ss-placeholder-child {
            background: transparent;
            /*border: 1px dashed blue;*/
        }

        .import {
            background: #3c92e5 !important;
            border-radius: 4px;
            color: #fff !important;
            padding: 3px 10px;
            cursor: pointer;
        }

        #back {
            float: right;
            background: #3c92e5 !important;
            border-radius: 4px;
            color: #fff !important;
            padding: 3px 10px;
            height: 21px;
            width: 50px;
            text-align: center;
            line-height: 21px;
            margin: 20px 20px 0px 0px;
            cursor: pointer;
        }

        @media screen and (max-width: 1366px) {
            #show .container > div {
                padding-left: 5%;
                padding-right: 5%;
            }
        }

        @media screen and (min-width: 1367px) {
            #show .container > div {
                padding-left: 10%;
                padding-right: 10%;
            }
        }
       .titles{
           width: 55%;
           margin-left: 35%;
           margin-right: 10%;
       }
        .itemee{
            margin-top: 10px;
            width: 100%;
            height: 36px;
            text-indent: 2em;
            margin-bottom: 10px;
        }
        .spanitem{
            display: inline-block;
            margin-left: 403px;
            float: left;
            margin-top: 20px;
            font-size: 11pt;
        }
        .save {
            background: #3c92e5 !important;
            border-radius: 4px;
            color: #fff !important;
            padding: 3px 10px;
            cursor: pointer;
        }
    </style>
</head>
<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
<body>
<script>
    $(document).ready(function () {

    })
</script>
<div class="navigation" style="margin-top: 0px;">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/daishen.png" alt="">
    <h2>我的门户内容设置</h2>
    <span id="back">返回</span>
</div>


<div class="portalTime" style="">
    <table>
        <%--<tr>--%>
        <%--<td>--%>

        <%--</td>--%>
        <%--<td>说明：显示、不显示的门户之间可以相互拖动</td>--%>
        <%--</tr>--%>
        <tr>
            <td>我的门户显示的模块:</td>
            <td id="show">
                <div class="container">
                    <%--<div></div>--%>
                    <%--<div></div>--%>
                    <%--<div></div>--%>
                    <%--<div></div>--%>
                    <%--<div></div>--%>
                    <%--<div></div>--%>
                    <%--<div></div>--%>
                    <%--<div></div>--%>
                </div>


            </td>
        </tr>
        <tr>
            <td>我的门户不显示的模块:</td>
            <td id="hide">
                <div class="container shapeshifted_container_h1qwv ui-droppable">
                    <%--<div style="visibility: hidden"></div>--%>
                </div>
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <span class="import">保存门户内容设置</span>
            </td>
        </tr>

    </table>
    <%--自定义告示栏--%>
    <div style="margin-top: 20px">
        <div class="spanitem">
            <span>自定义告示栏1：</span>
        </div>
        <div class="titles">
            <input type="text" class="itemee tit1"   placeholder="请输入自定义告示栏1的标题" style="margin-top: 10px;width: 100%">
            <div id="word_container" name="word_container">

            </div>
        </div>
    </div>
    <%--自定义告示栏2--%>
    <div style="margin-top: 20px">
        <div class="spanitem">
            <span>自定义告示栏2：</span>
        </div>
        <div class="titles">
            <input type="text" class="itemee tit2" placeholder="请输入自定义告示栏2的标题" style="margin-top: 10px;width: 100%">
            <div id="word_container2" name="word_container">

            </div>
        </div>
    </div>
    <%--自定义告示栏2--%>
    <div style="margin: 20px 0px">
        <div class="spanitem">
            <span>自定义告示栏3：</span>
        </div>
        <div class="titles">
            <input type="text" class="itemee tit3" placeholder="请输入自定义告示栏3的标题" style="margin-top: 10px;width: 100%">
            <div id="word_container3" name="word_container">

            </div>
        </div>
    </div>
    <%--保存--%>
    <div style="height:90px;text-align: center">
        <button class="save" style="height: 30px;width: 120px;text-align: center">保存告示栏内容</button>
    </div>
</div>
<script>
    var showMap = {};
    var hideMap = {};
    var No = $.GetRequest().N0;
    var portalsId = $.GetRequest().portalsId;
    $('#back').click(function () {
        window.location.href = '/portals/index'
    })
    $.ajax({
        url: '/syspara/querySysParaProtal',
        type: 'get',
        dataType: 'json',
        success: function (res) {
            var content1=res.object[0].content1
            var content2=res.object[1].content2
            var content3=res.object[2].content3
            var title1=res.object[0].title1
            var title2=res.object[1].title2
            var title3=res.object[2].title3
            $(".tit1").val(title1);
            $(".tit2").val(title2);
            $(".tit3").val(title3);
            ue1.ready(function () {
                ue1.setContent(content1);
            });
            ue2.ready(function () {
                ue2.setContent(content2);
            });
            ue3.ready(function () {
                ue3.setContent(content3);
            });
        }
    })


    $.ajax({
        url: '/infoCenter/getInfoCenters',
        type: 'get',
        dataType: 'json',
        data: {parentNo: 'portals_show'},
        success: function (res) {

            if (res.flag) {
                $.ajax({
                    url: '/portals/selPortalsById',
                    dataType: 'json',
                    data: {portalsId: portalsId},
                    success: function (datas) {

                        var data = res.data;
                        var str = '';
                        var str1 = ''
                        var arr = [];
                        var ids = ""
                        for (var i = 0; i < data.length; i++) {
                            arr.push(data[i].infoNo);
                            ids += data[i].infoNo + ','
                        }
                        var portals = datas.object.portalsShow;
                        if (portals != "" && portals != undefined) {
                            var portalsArr = portals.split(',')
                            for (var j = 0; j < portalsArr.length; j++) {

                                if (arr.indexOf(portalsArr[j]) >= 0) {
                                    ids = ids.replace(portalsArr[j] + ',', '')
                                    for (var k = 0; k < data.length; k++) {
                                        if (portalsArr[j] == data[k].infoNo) {
                                            str += '<div class="aa"><div class="item" id="' + data[k].infoNo + '"><div style="position:relative"><img src="' + data[k].iconPath + '" alt="" style="width: 80px"><div>' + data[k].infoName1 + '</div><div style="position:absolute;right:-8px;top:0px;cursor:pointer;" class="del"><img src="/img/main_img/app/del.png" alt=""></div></div></div></div>'
                                            showMap[data[k].infoNo] = true;
                                        }
                                    }

                                }
                            }
                        } else {
                            // ids ='a'
                            // for(var a = 0;a<data.length;a++){
                            //     str += '<div class="aa"><div class="item" id="'+data[a].codeNo+'"><div style="position:relative"><img src="'+data[a].codeExt+'" alt=""><div>'+data[a].codeName+'</div><div style="position:absolute;right:-8px;top:0px;cursor:pointer;" class="del"><img src="/img/main_img/app/del.png" alt=""></div></div></div></div>'
                            // }
                        }


                        if (ids != '' && ids != 'a') {
                            var idsArr = ids.split(',')
                            for (var m = 0; m < idsArr.length; m++) {

                                for (var n = 0; n < data.length; n++) {
                                    if (idsArr[m] == data[n].infoNo) {
                                        str1 += '<div class="aa"><div class="item" id="' + data[n].infoNo + '"><div style="position:relative"><img src="' + data[n].iconPath + '" alt="" style="width: 80px"><div>' + data[n].infoName1 + '</div><div style="position:absolute;right:-8px;top:0px;cursor:pointer;" class="add"><img src="/img/main_img/app/add.png" alt=""></div></div></div></div>'
                                        hideMap[data[n].infoNo] = true;
                                    }
                                }

                            }
                        }

                        $('#show .container').html(str);
                        $('#hide .container').html(str1);
                        $(".container").shapeshift();

                    }
                })


            }
        }
    })

    var dels='';
    var adds='';

    $('.import').click(function () {
        // 保证请求成功后才能继续操作按钮
        if (window.importFlag == undefined) window.importFlag = true;
        if (window.importFlag != true) return false;
        window.importFlag = false;

        var ids = "";
        for (var i = 0; i < $('#show .container .item').length; i++) {
            ids += $('#show .container .item').eq(i).attr('id') + ','
        }

        for (var key in delMap) {
            dels += key +',';
        }
        for (var key in addMap) {
            adds += key +',';
        }

        // for (var i = 0; i < $('#show .container .item').length; i++) {
        //     adds += $('#show .container .item').eq(i).attr('id') + ','
        // }

        // for (var i = 0; i < $('#hide .container .item').length; i++) {
        //     dels += $('#hide .container .item').eq(i).attr('id') + ','
        // }
        /*if (ids.indexOf('00') == -1 && ids.indexOf('0b') == -1) {
            layer.msg('请选择至少一个【今日看板】', {icon: 1});
        }else {*/
            $.ajax({
                url: '/portals/update',
                type: 'post',
                dataType: 'json',
                data: {
                    portalsShow: ids,
                    portalsId: portalsId,
                    portalsNo: No,
                    add:adds,
                    del:dels
                },
                success: function (res) {
                    if (res.flag) {
                        layer.msg('保存成功！', {icon: 1, time: 2000,offset:['40%','45%'],});
                        // 初始化变量
                        for (var key in delMap) {
                            if (key in showMap) delete showMap[key];
                            hideMap[key] = true;
                        }
                        for (var key in addMap) {
                            if (key in hideMap) delete hideMap[key];
                            showMap[key] = true;
                        }
                    } else {
                        layer.msg('保存失败！', {icon: 0, time: 2000,offset:['40%','45%'],});
                    }
                    // 清空变量
                    delMap = {};
                    addMap = {};
                    adds = '';
                    dels = '';

                    window.importFlag = true;
                }
            })
            // $.ajax({
            //     url: '/infoCenter/setInfoCenterOrder',
            //     type: 'get',
            //     dataType: 'json,
            //     data: {infoLeftOrder: ids},
            //     success: function (res) {
            //
            //     }
            // })
        //}
    });

    delMap = {};
    addMap = {};
    $('#show').on('click', '.del', function (e) {
        var key = $(this).parents('.item').attr('id');
        if (!(key in hideMap)) delMap[key] = true;
        if (key in addMap) delete addMap[key];

        e.stopPropagation();
        $(this).addClass('add').removeClass('del').html('<img src="/img/main_img/app/add.png"/>')
        $(this).parents('.aa').appendTo('#hide .container');
        $(".container").shapeshift();
    })
    $('#hide').on('click', '.add', function (e) {
        var key = $(this).parents('.item').attr('id');
        if (!(key in showMap)) addMap[key] = true;
        if (key in delMap) delete delMap[key];

        e.stopPropagation();
        $(this).addClass('del').removeClass('add').html('<img src="/img/main_img/app/del.png"/>')
        $(this).parents('.aa').appendTo('#show .container');
        $(".container").shapeshift();
    })

    var ue1 = UE.getEditor('word_container',{elementPathEnabled : false});
    var ue2 = UE.getEditor('word_container2',{elementPathEnabled : false});
    var ue3 = UE.getEditor('word_container3',{elementPathEnabled : false});
    UEimgfuc();
    $('.save').click(function () {
        $.ajax({
            url: '/syspara/updateSysParaAtPortal',
            type: 'post',
            dataType: 'json',
            data: {
                title1:$('.tit1').val(),
                content1:ue1.getContent(),
                title2:$('.tit2').val(),
                content2:ue2.getContent(),
                title3:$('.tit3').val(),
                content3:ue3.getContent()
            },
            success:function (res) {
                if (res.flag) {
                    layer.msg('保存告示栏成功！',{icon:1,time: 2000},function () {
                        window.location.reload();//刷新当前页面.
                    });
                } else {
                    $.layerMsg({content: '保存失败', icon: 2})
                }
            }
        })
    })
</script>

</body>
</html>
