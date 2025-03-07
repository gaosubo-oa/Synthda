<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/26
  Time: 10:43
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
    <title>重点工作监察</title>
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/css/base.css">
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1"/>
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/efficiency/base.js" type="text/javascript" charset="utf-8"></script>
    <style>
        .head {
            margin-top: 10px;
            height: 33px;
        }

        .head .title {
            margin-left: 22px;
        }

        .head span {
            float: none;
            /*margin-top: 9px;*/
            font-size: 22px;
            color: #333;
            display: inline-block;
            margin-left: 10px;
            vertical-align: middle;
            margin-top: -6px;
        }

        label select {
            width: 130px;
            padding-left: 10px;
            height: 32px;
        }

        .fl input {
            padding: 0 10px;
            width: 130px
        }

        #export, #allexport, #allsearch, #alldelete {
            margin-left: 10px;
            border: 1px solid #2b7edf;
            color: #ffffff;
            background-color: #2b7edf;
            cursor: pointer;
            height: 28px;
            border-radius: 5px;
            width: 80px;
            height: 30px;
        }

        #export, #allexport {
            background-color: #0cae32;
            border: 1px solid #0cae32;
            color: #ffffff;
        }

        #export:hover, #allexport:hover {
            background-color: #17bb3e;
            border: 1px solid #17bb3e;

        }

        #alldelete {
            border: 1px solid #ef4747;
            color: #ffffff;
            background-color: #ef4747;
        }

        #alldelete:hover {
            border: 1px solid #fe4f4f;
            color: #ffffff;
            background-color: #fe4f4f;
        }

        #allexport {
            width: 110px;
        }

        #allsearch {
            width: 110px;
        }

        #end {
            background: #00a0e9;
            margin-left: 10px;
            padding: 5px 1px;
            border-radius: 4px;
            color: #fff;
            cursor: pointer;
        }

        .Query {
            background: #2b7edf;
            margin-left: 70px;
            margin-top: 16px;
            padding: 5px 1px;
            border-radius: 5px;
            color: #fff;
            cursor: pointer;
            width: 80px;
            height: 30px;
        }

        #allsearch:hover, .Query:hover {
            background-color: #3b8eef;
        }

        #pagediv #pageTbody input[name="checkbox"] {
            display: inline-block;
        }

        .pagediv .page-bottom-outer-layer table td:last-child {
            font-weight: normal;
            overflow: hidden;
            white-space: pre;
            height: 40px;
            padding: 4px;
            box-sizing: border-box;
            text-overflow: ellipsis;
            font-size: 11pt;
            text-align: left;
            border-right: 1px solid #ddd;
        }

        .sel {
            width: 165px;
            max-height: 250px;
            position: absolute;
            top: 31px;
            left: 60px;
            overflow: auto;
            background: #fff;
            border: 1px solid #e2e3e3;
            display: none;
        }

        .sel li {
            line-height: 24px;
            color: #000;
        }

        #list {
            width: 40px;
            height: 32px;
            background: #f3f3f3;
            border: 1px solid #ccc;
            vertical-align: middle;
            position: absolute;
            right: 0px;
            top: 0px;
            border-radius: 0px 3px 3px 0px;
        }

        #list img {
            margin-top: -2px;
            margin-left: 0px;
        }

        .canchoose:hover {
            background: #2b7edf;
            color: #fff;
        }

        .ones {
            list-style-type: disc;
        }

        .pagediv .page-top-inner-layer {
            padding-right: 0px;
        }

    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<script>
    $(function () {
        $('#displayBtn').click(function () {
            if ($('#more_div').css("display") == "none") {
                $('#more_div').css("display", "block");
                $("#displayBtn").text("<fmt:message code="main.th.Stop"/>");
            } else {
                $('#more_div').css("display", "none");
                $('#more_div').css("height", "0px");
                $("#displayBtn").text("<fmt:message code="email.th.more"/>");
            }
        })
    });
</script>

<body>
<div class="head">
    <div class="title">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/flow_run_title.png"><span style="">重点工作监察</span>
    </div>
</div>
<div style="margin: 0 auto;width: 97%; ">
    <div style="margin: 0 auto; height:62px;width: 100%;">
        <%--流程类型--%>
        <%--<label class="fl" style="margin-top: 16px;position: relative">--%>
        <%--<span class="fl" style="margin-top: 6px;"><fmt:message code="workflow.th.processname"/>：</span>--%>
        <%--<input type="text" name="flowName" placeholder="全部流程" dataType="" style="width: 150px;padding-left: 5px;">--%>
        <%--<button id="list"><img src="../../img/workflow/work/xiala.png" alt=""></button>--%>
        <%--<ul class="sel"></ul>--%>
        <%--&lt;%&ndash;<select name="dispatchType" id="">&ndash;%&gt;--%>
        <%--&lt;%&ndash;<option value=""><fmt:message code="hr.th.PleaseSelect"/></option>&ndash;%&gt;--%>
        <%--&lt;%&ndash;</select>&ndash;%&gt;--%>
        <%--</label>--%>
        <%--流程类型--%>
        <label class="fl clearfix" style="margin-top: 16px;margin-left: 30px;">
            <span class="fl" style="margin-top: 6px;">流程类型：</span>
            <label class="fl">
                <select id="selectFlowType" name="flowType" title="">
                    <option value="">请选择：</option>
                </select>
            </label>
        </label>
        <%--流水号--%>
        <label class="fl clearfix" style="margin-top: 16px;margin-left: 70px;">
            <span class="fl" style="margin-top: 6px;"><fmt:message code="workflow.th.liushui"/>：</span>
            <label class="fl"><input name="runId" placeholder="<fmt:message code="workflow.th.liushui"/>" type="text"
                                     onblur="onblus(this.value);"/></label>
        </label>
        <%--工作名称/文号--%>
        <label class="fl clearfix" style="margin-top: 16px;margin-left: 70px;">
            <span class="fl" style="margin-top: 6px;"><fmt:message code="workflow.th.job"/>：</span>
            <label class="fl">
                <input name="runName" placeholder="<fmt:message code="workflow.th.job"/>" type="text">
            </label>
        </label>
        <%-- 范围--%>
        <label class="fl clearfix" style="margin-top: 16px;margin-left: 70px;">
            <span class="fl" style="margin-top: 6px;"><fmt:message code="diary.th.Range"/>：</span>
            <label class="fl">
                <select name="status" id="status" style="width: 100px;">
                    <option value=""><fmt:message code="work.th.AllRange"/></option>
                    <%--<option value="1"><fmt:message code="workflow.th.IStarted"/></option>--%>
                    <option value="2"><fmt:message code="workflow.th.IDidIt"/></option>
                    <%--     <option value="3"><fmt:message code="workflow.th.IManageIt"/></option>--%>
                    <%-- <option value="4"><fmt:message code="work.th.MyConcern"/></option>--%>
                   <%-- <option value="5"><fmt:message code="work.th.DesignatedSponsor"/></option>--%>
                    <option value="6"><fmt:message code="work.th.DesignatedController"/></option>
                    <%--<option value="7"><fmt:message code="adding.th.look"/></option>--%>
                </select>
                <input name="userId" type="text" readonly id="userId" user_Id="" style="display: none"/>
                <a href="javascript:;" id="addUser" style="display: none"><fmt:message code="global.lang.add"/></a>
                <a href="javascript:;" id="clearUser" style="display: none"><fmt:message code="global.lang.empty"/></a>
            </label>
        </label>
        <div class="fl clearfix" style="margin-left: 10px;margin-bottom: 10px;">
            <button type="button" class="Query fl queryBtn">
                <img src="../../img/workflow/worksearch1.png"
                     style="margin-right: 2px;margin-left:5px;margin-bottom: 1px;">
                <span style="margin-right: 5px;"><fmt:message code="global.lang.query"/></span>
            </button>
        </div>
    </div>
    <div id="more_div" style="padding-bottom: 48px;">
        <%--状态--%>
        <label class="fl clearfix" style="margin-left: 52px;">
            <span class="fl" style="margin-top: 6px;"><fmt:message code="notice.th.state"/>：</span>
            <label class="fl"><select name="status1" style="width: 90px;">
                <option value=""><fmt:message code="work.th.AllStates"/></option>
                <option value="1"><fmt:message code="work.th.Executing"/></option>
                <option value="4"><fmt:message code="work.th.ItOver."/></option>
                <%--<option value="3"><fmt:message code="work.th.Archived"/></option>--%>
            </select></label>
        </label>
        <%--流程发起日期--%>
        <label class="fl clearfix" style="margin-left: 75px;">
            <span class="fl" style="margin-top: 6px;"><fmt:message code="adding.th.launch"/>：</span>
            <label class="fl">
                <input name="beginDate" placeholder="<fmt:message code="sup.th.startTime"/>" type="text"
                       onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})"/>
                &nbsp;&nbsp;<fmt:message code="global.lang.to"/>&nbsp;&nbsp;
                <input name="endDate" placeholder="<fmt:message code="meet.th.EndTime"/>" type="text"
                       onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})"/>
            </label>
        </label>
    </div>
</div>
<div id="pagediv">

</div>
</body>
<script>
    $(document).keyup(function (e) {//捕获文档对象的按键弹起事件
        if (e.keyCode == 13) {//按键信息对象以参数的形式传递进来了
            //此处编写用户敲回车后的代码
            $('.queryBtn').click();
        }
    });

    function allsearch() {
        window.open('/flowRunPage/allsearch');
    }

    function onblus(x) {
        // 清除两边的空格
        String.prototype.trim = function () {
            return this.replace(/(^\s*)|(\s*$)/g, '');
        };
        var inputStr = x;//用于存放输入的字符串
        if (!inputStr || !inputStr.trim() || isNaN(inputStr)) {
            //输入的不是数字
            <%--alert("<fmt:message code="doc.th.number"/>");--%>
        }
    }

    function alldelete(e) {
        var deletelayer = layer.load();
        var length = $('.canDelete[name=checkbox]:checked').length;
        var tid = '';
        for (var i = 0; i < length; i++) {
            var $this = $('.canDelete[name=checkbox]:checked').eq(i);
            var obj = $this.attr('runid');
            tid += obj + ',';
        }
        if (tid != '') {
            $.ajax({
                url: "/workflow/work/batchUpdateState?runId=" + tid,
                type: 'post',
                dataType: 'json',
                success: function (res) {
                    if (res.code == '100066'){
                        $.layerMsg({content: '进入删除审批，审批通过后删除', icon: 4});
                    }
                    location.reload();
                }
            })
        } else {
            layer.close(deletelayer);
            layer.msg('请选择可以删除的流程!', {icon: 2});
        }

    }

    $("#addUser").on("click", function () {
        user_id = 'userId';
        $.popWindow("../common/selectUser?0");
    });
    $("#clearUser").on("click", function () {
        $("#userId").val("");
        $("#userId").attr('user_id', '');
    })

    $("#status").change(function () {
        var str = this.value;
        if (str == 5 || str == 6) {
            $('#userId').css("display", "inline-block");
            $('#addUser').css("display", "inline-block");
            $('#clearUser').css("display", "inline-block");
        } else {
            $('#userId').css("display", "none");
            $('#addUser').css("display", "none");
            $('#clearUser').css("display", "none");
        }
    })
    $(document).click(function () {
        $('.sel').hide()
    })

    $('#list').click(function (e) {
        e.stopPropagation()
        if ($('.sel').css('display') != 'none') {
            $('.sel').hide()
        } else {
            $('.sel').show()
        }

    })
    $('[name="flowName"]').keyup(function () {
        $('.sel').show()
        var val = $(this).val()
        $('.sel li').each(function (i, v) {
//            console.log(v.innerHTML)
            if (v.innerHTML.indexOf(val) > -1) {
                $(v).show();
                $(v).parent().show()
            } else {
                $(v).hide();
            }
        })

    })

    $('.sel').on('click', 'li', function (e) {
        e.stopPropagation()
        if ($(this).attr('value')) {
            $('[name="flowName"]').val($(this).html())
            $('[name="flowName"]').attr('dataType', $(this).attr('value'))
            $('.sel').hide()
        } else {
            $('.sel').show()
        }
    })

    function buildNode(len, data) {
        var prefix = 10;
        for (var i = 0; i < len; i++) {
            prefix += 10;
        }

        $.each(data, function (i, item) {
            if (0 < item.childs.length) {
                $('.sel').append("<li style='padding-left:" + (prefix) + "px;font-weight:bold;font-size:14px;' id=" + item.sortId + ">" + item.sortName + "<li>");
                $.each(item.flowTypeModels, function (j, v) {
                    $('.sel').append("<li style='padding-left:" + (prefix + 10) + "px;cursor:pointer' class='canchoose' value=" + v.flowId + ">" + v.flowName + "<li>");
                })
                buildNode(len + 1, item.childs);
            } else {
                $('.sel').append("<li style='padding-left:" + (prefix) + "px;font-weight:bold;font-size:14px;' id=" + item.sortId + ">" + item.sortName + "<li>");
                $.each(item.flowTypeModels, function (j, v) {
                    $('.sel').append("<li style='padding-left:" + (prefix + 10) + "px;cursor:pointer' class='canchoose' value=" + v.flowId + ">" + v.flowName + "<li>");
                })
            }
        });
    }

    $(function () {
        $.ajax({
            url: "/flow/selOneToAllType",
            type: 'post',
            dataType: 'json',
            success: function (res) {
                var data = res.datas;
//                console.log(data)
                var str = '<option value=""><fmt:message code="hr.th.PleaseSelect"/></option>';
                if (res.flag) {
                    $.each(data, function (i, item) {
                        $('.sel').append("<li class='ones' style='font-weight:bold;font-size:14px;' id=" + item.sortId + "><img src='../../img/data_points.png' style='margin-right: 5px;' alt=''>" + item.sortName + "<li>");
                        $.each(item.flowTypeModels, function (j, v) {
                            $('.sel').append("<li style='padding-left:10px;cursor:pointer' class='canchoose' value=" + v.flowId + ">" + v.flowName + "<li>");
//                                $('[name="dispatchType"]').append("<option value="+v.flowId +">" + + "</option>");
                        })
                        buildNode(1, item.childs);
                    });
                }
            }
        })
    })
</script>
<script>
    /**
     * Created by 骆鹏 on 2017/7/26.
     */
    function jumpOpenType(flowId, runId) {
        window.open('/FlowRunFu/KeySonWorkSupervision?flowId=' + flowId + '&flowStep=""&prcsId=""&runId=' + runId);
    }

    function jumpOpenName(flowId, step, runId, realPrcsId) {
        if (step == undefined) {
            step = '';
        }
        if (realPrcsId == undefined) {
            realPrcsId = '';
        }
        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
            window.open('/workflow/work/workformh5PreView?flowId=' + flowId + '&flowStep=' + step + '&runId=' + runId + '&prcsId=' + realPrcsId);
        } else if (/(Android)/i.test(navigator.userAgent)) {
            window.open('/workflow/work/workformh5PreView?flowId=' + flowId + '&flowStep=' + step + '&runId=' + runId + '&prcsId=' + realPrcsId);
        } else {
            window.open('/workflow/work/workformPreView?flowId=' + flowId + '&flowStep=' + step + '&runId=' + runId + '&prcsId=' + realPrcsId);
        }
    }

    function getCookie(name) {
        var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
        if (arr = document.cookie.match(reg))
            return unescape(arr[2]);
        else
            return null;
    }

    var oHead = document.getElementsByTagName('HEAD').item(0);
    var oScript = document.createElement("script");
    var type = getCookie("language");
    oScript.type = "text/javascript";

    if (type) {
        oScript.src = "/js/Internationalization/" + type + ".js";
    } else {
        oScript.src = "/js/Internationalization/zh_CN.js";
    }

    $.getScript(oScript.src, function () {
        var eventas;
        var pageObj = $.tablePage('#pagediv', '100%', [ // 1260
//            {
//                width:'3%',
//                title:'',
//                name:'checkbox',
//                selectFun:function (runId,obj) {
//                    if(obj.manage == '1'||obj.all == '1'){
//                        var str='canDelete';
//                    }else{
//                        var str='';
//                    }
//                    return '<div style="padding-left: 20px; width: 70px;"><input type="checkbox" id="'+obj.runId+'" name="checkbox" class="id '+ str +'" runId="'+obj.runId+'"/></div>';
//                }
//            },
            {
                width: '5%',
                title: liushui,
                name: 'runId',
            },
            {
                width: '23%',
                title: '工作名称',
                name: 'workTitle',
                selectFun: function (workTitle, obj) {
                    return '<a class="wenhao" title="' + workTitle + '" style="cursor: pointer;" ' +
                        'onclick="jumpOpenType(' + obj.flowId + ',' + obj.runId + ')">' + workTitle + '</a>';
                }
            },
            {
                width: '10%',
                title: '责任领导',
                name: 'ziren',
                selectFun: function (ziren) {
                    return '<span>' + trimComma(ziren) + '</span>';
                }
            },
            {
                width: '10%',
                title: '牵头单位',
                name: 'qiantou',
                selectFun: function (qiantou) {
                    return '<span>' + trimComma(qiantou) + '</span>';
                }

            }, {
                width: '10%',
                title: '办理单位',
                name: 'deptName',
                selectFun: function (deptName) {
                    return '<span title="' + deptName + '">' + deptName + '</span>';
                }
            },
            {
                width: '9%',
                title: '当前办理人',
                name: 'userName',
            },
            {
                width: '10%',
                title: '办理时限',
                name: 'shixian',
            },
            {
                width: '10%',
                title: '办理状态',
                name: 'workStatusInt',
                selectFun: function (workStatusInt, obj) {
                    if (workStatusInt == 1) {
                        return '<span style="color: green;font-weight: bold">正常办理中</span>'
                    } else if (workStatusInt == 2) {
                        return '<span style="color: orange;font-weight: bold">超时办理中</span>'
                    } else if (workStatusInt == 3) {
                        return '<span style="color: green;font-weight: bold">正常办结</span>'
                    } else if (workStatusInt == 4) {
                        return '<span style="color: orange;font-weight: bold">超时办结</span>'
                    } else if(workStatusInt == 5){
                        return '<span style="color: green;font-weight: bold">办理中</span>'
                    } else if(workStatusInt == 6){
                        return '<span style="color: green;font-weight: bold">已办结</span>'
                    }
                }
            },
            {
                width: '13%',
                title: '距办理时间',
                name: 'shijian',
            },
            {
                width: '0',
                title: ''
            }
        ], function (me) {
            me.data.pageSize = 5;

//            me.data.endDate=$('[name="endDate"]').val();
//            me.data.isZhong='FLOW_ID_Q';

            me.init('/FlowRunFu/queryFlowRunZhongList'
//                ,function () {
//                var str='<tr>' +
//                    '<td style="width: 500px;text-align: center"><input type="checkbox" name="all"><span>全选</span></td>' +
//                    '<td colspan="9" style="text-align: left">' +
//                    '</td>' +
//                    '</tr>'
//                $('#operation').html(str)
//            }
            )
        })
        $('#pagediv').on('click', '[name="all"]', function () {//全选
            if ($(this).is(':checked')) {
                $('#pageTbody').find('input[type=checkbox]').prop('checked', true)
            } else {
                $('#pageTbody').find('input[type=checkbox]').removeProp('checked')
            }
        })
        $(document).on('click', '.editAndDelete0', function () {//流程图
            var obj = pageObj.arrs[$(this).attr('data-i')]
            eventas = $(this).parent().parent().find('.wenhao');
            // $('title').html('<fmt:message code="workflow.th.First" />'+obj.prcsId+'<fmt:message code="workflow.th.step" />:'+obj.flowProcess.prcsName+'</a>')
            window.open('/flowSetting/processDesignToolTwo?flowId=' + obj.flowId + '&rilwId=' + obj.runId);
        })

        $(document).on('click', '.editAndDelete1', function () {//恢复执行
            var runId = pageObj.arrs[$(this).attr('data-i')].runId
            $.ajax({
                type: 'post',
                data: {
                    runId: runId,
                },
                url: '/workflow/work/resumeExe',
                dataType: 'json',
                success: function (res) {
                    if (res.flag) {
                        $.layerMsg({content: '恢复成功', icon: 1});
                        pageObj.init();
                    } else {
                        $.layerMsg({content: shib, icon: 2});
                    }
                }
            })

        })

        $(document).on('click', '.editAndDelete2', function () {//结束
            var runId = pageObj.arrs[$(this).attr('data-i')].runId
            $.ajax({
                type: 'post',
                data: {
                    runId: runId,
                    flag: 2
                },
                url: '/workflow/work/updateState',
                dataType: 'json',
                success: function (res) {
                    if (res.code == '100066'){
                        $.layerMsg({content: '进入删除审批，审批通过后删除', icon: 4});
                        pageObj.init();
                    } else if (res.flag) {
                        $.layerMsg({content: chegon, icon: 1});
                        pageObj.init();
                    } else {
                        $.layerMsg({content: shib, icon: 2});
                    }
                }
            })

        })

        $(document).on('click', '.yulan', function () {
            var url = $(this).attr('data-url');
            $.pdurl($.UrlGetRequest('?' + url), url);
        })
//        $(document).on('click','.editAndDelete1',function () {//结束
//            var obj=pageObj.arrs[$(this).attr('data-i')]
//            //询问框
//            layer.confirm(com, {
//                btn: [sure,cancel ] ,//按钮
//            }, function(){
//                $.ajax({
//                    type:'post',
//                    data:{
//                        runId:obj.runId,
//                        flag:2,
//                        prcsId:obj.prcsId,
//                        userId:obj.userId,
//                        flowPrcs:obj.flowPrcs,
//                        prcsFlag:obj.prcsFlag
//                    },
//                    url:'/workflow/work/updateState',
//                    dataType:'json',
//                    success:function(res){
//                        if (res.flag) {
//                            $.layerMsg({content: chegon, icon: 1});
//                            pageObj.init();
//                        } else {
//                            $.layerMsg({content:shib, icon: 2});
//                        }
//
//                    }
//                })
//            }, function() {
//                layer.closeAll();
//            })
//        })

//        $(document).on('click','.editAndDelete2',function () {//催办
//            var obj=pageObj.arrs[$(this).attr('data-i')]
//            layer.open({
//                type:1,
//                offset: '80px',
//                area: ['800px', '300px'],
//                // closeBtn: 0,
//                title:[cui, 'background-color:#f3f3f3;color:#333'],
//                btn:[sure,cancel],
//                content: '<div class="content" style="width:98%;margin:0 auto">' +
//                '<div class="heade" style="margin-top:20px;font-size:16px;border-radius: 4px">'+inputContent+'：</div>'+
//                '<textarea name="" id="urgeCon" style="width:100%;height:85px;border-radius: 4px; margin-top: 20px;"></textarea>'+
//                '</div>',
//                yes:function(){
//                    $.ajax({
//                        type:'post',
//                        data:{
//                            id:obj.id,
//                            userId:obj.userId,
//                            flowPrcs:obj.flowPrcs,
//                            runId:obj.runId,
//                            runName:obj.runName,
//                            flowId:obj.flowId,
//                            prcsId:obj.prcsId,
//                            smsContent:$("#urgeCon").val()
//                        },
//                        url:'/workflow/work/reminders',
//                        dataType:'json',
//                        success:function(res){
//                            if (res.flag) {
//                                if(res.obj1 == 1 && res.obj1 != undefined){
//                                    $.layerMsg({content:'您已催办过，请勿重复点击',icon:6})
//                                    return false;
//                                }else{
//                                    $.layerMsg({content: cuibanC, icon: 1});
//                                    pageObj.init();
//                                    layer.closeAll();
//                                }
//                            } else {
//                                $.layerMsg({content: cuibanS, icon: 2});
//                            }
//
//                        }
//                    })
//                },
//                btn2:function(){
//
//                },
//                success:function(){
//                    $("#urgeCon").val(tixing +":"+obj.runId+"，"+flowName +":"+obj.runName+deWork);
//                }
//            })
//        })

//        $(document).on('click','.editAndDelete3',function () {//删除
//            var obj=pageObj.arrs[$(this).attr('data-i')];
//            //询问框
//            layer.confirm(qued, {
//                btn: [sure,cancel] ,//按钮
//            }, function(){
//                $.ajax({
//                    type:'post',
//                    data:{
//                        runId:obj.runId,
//                        flag:1
//                    },
//                    url:'/workflow/work/updateState',
//                    dataType:'json',
//                    success:function(res){
//                        if (res.flag) {
//                            $.layerMsg({content: delc, icon: 1});
//                            pageObj.init();
//                        } else {
//                            $.layerMsg({content: delf, icon: 2});
//                        }
//
//                    }
//                })
//            }, function(){
//                layer.closeAll();
//            });
//        })

//        $(document).on('click','.editAndDelete4',function () {//恢复执行
//            var obj=pageObj.arrs[$(this).attr('data-i')]
//            //询问框
//            layer.confirm(sureHandle, {
//                btn: [sure,cancel ] ,//按钮
//            }, function(){
//                $.ajax({
//                    type:'post',
//                    data:{
//                        runId:obj.runId,
//                        id:obj.id
//                    },
//                    url:'/workflow/work/resumeExe',
//                    dataType:'json',
//                    success:function(res){
//                        if (res.flag) {
//                            $.layerMsg({content: returnC, icon: 1});
//                            pageObj.init();
//                        } else {
//                            $.layerMsg({content: returnS, icon: 2});
//                        }
//
//                    }
//                })
//            }, function() {
//                layer.closeAll();
//            })
//        })

//        $(document).on('click','.editAndDelete5',function () {//编辑
//            var obj=pageObj.arrs[$(this).attr('data-i')]
//            window.open('/workflow/work/workformedit?opflag=1&flowId='+ obj.flowId +'&prcsId=&flowStep=&runId='+ obj.runId);
//        })

        //流程分类递归
        function queryChild_flow(datas, str_li, level) {
            for (var i = 0; i < datas.length; i++) {
                var className = "levelleft" + level;
                if (datas[i].sortName == '未定义') {
                    str_li += '<option value="' + datas[i].sortNo + '">' + datas[i].sortName + '</option>'
                } else {
                    str_li += '<option value="' + datas[i].sortNo + '">' + datas[i].sortName + '</option>'
                }
                if (datas[i].childs != null) {
                    str_li = queryChild_flow(datas[i].childs, str_li, level + 1);
                }
            }
            return str_li;
        }

        $(".queryBtn").click(function () {
            if ($("#status").val() == 5 || $("#status").val() == 6) {
                pageObj.data.userId = $('[name="userId"]').attr("user_Id");
            } else {
                pageObj.data.userId = $.cookie("userId");
            }
            if ($('[name="flowName"]').val() == "") {
                $('[name="flowName"]').attr('dataType', '0')
            }
            pageObj.data.flowId = $('[name="flowName"]').attr('dataType');
            pageObj.data.runId = $('[name="runId"]').val();
            pageObj.data.runName = $('[name="runName"]').val();
            pageObj.data.flowType = $('[name="flowType"]').val();
            pageObj.data.state = $('[name="status"]').val();
            pageObj.data.workLevel = $('[name="status2"]').val();
            pageObj.data.status = $('[name="status1"]').val();
            pageObj.data.beginDate = $('[name="beginDate"]').val();
            pageObj.data.endDate = $('[name="endDate"]').val();
            pageObj.init();
        })

        $("#export").click(function () {//导出
            var userId = '';
            if ($("#status").val() == 5 || $("#status").val() == 6) {
                userId = $('[name="userId"]').attr("user_Id");
            } else {
                userId = $.cookie("userId");
            }
            var length = $('#pageTbody input[type="checkbox"]').length;
            window.location.href = '../../FlowRunFu/queryFlowRunFu?output=1&userId=' + userId +
                '&flowId=' + $('[name="flowName"]').attr('dataType') + '&runId=' + $('[name="runId"]').val() + '&runName=' + $('[name="runName"]').val() +
                '&state=' + $('[name="status"]').val() + '&workLevel=' + $('[name="status2"]').val() + '&status=' + $('[name="status1"]').val()
                + '&beginDate=' + $('[name="beginDate"]').val() + '&endDate=' + $('[name="endDate"]').val();
        })


        $('#allexport').click(function () {//全部导出
            var userId = '';
            if ($("#status").val() == 5 || $("#status").val() == 6) {
                userId = $('[name="userId"]').attr("user_Id");
            } else {
                userId = $.cookie("userId");
            }
            if ($('[name="flowName"]').val() == "") {
                $('[name="flowName"]').attr('dataType', '0')
            }
            var length = $('#pageTbody input[type="checkbox"]').length;
            window.location.href = '../../flowRun/queryFlowRun?output=2&userId=' + userId +
                '&flowId=' + $('[name="flowName"]').attr('dataType') + '&runId=' + $('[name="runId"]').val() + '&runName=' + $('[name="runName"]').val() +
                '&state=' + $('[name="status"]').val() + '&workLevel=' + $('[name="status2"]').val() + '&status=' + $('[name="status1"]').val()
                + '&beginDate=' + $('[name="beginDate"]').val() + '&endDate=' + $('[name="endDate"]').val();

        })

        $("#end").click(function () {
            var runIds = "";
            var prcsIds = "";
            var userIds = "";
            var flowPrcss = "";
            var prcsFlags = "";
            $('input:checkbox[name=id]:checked').each(function (i) {
                if (0 == i) {
                    runIds = $(this).attr("id");
                    prcsIds = $(this).attr("prcsid");
                    userIds = $(this).attr("userid");
                    flowPrcss = $(this).attr("flowprcs");
                    prcsFlags = $(this).attr("prcsflag");
                } else {
                    runIds += ("," + $(this).attr("id"));
                    prcsIds += ("," + $(this).attr("prcsid"));
                    userIds += ("," + $(this).attr("userid"));
                    flowPrcss += ("," + $(this).attr("flowprcs"));
                    prcsFlags += ("," + $(this).attr("prcsflag"));
                }
            });
            if (runIds == '') {
                $.layerMsg({content: xuanzeEnd, icon: 2});
            }
            layer.confirm(com, {
                title: xinxiM,
                btn: [sure, cancel],//按钮
            }, function () {
                $.ajax({
                    type: 'post',
                    data: {
                        runId: runIds,
                        flag: 2,
                        prcsId: prcsIds,
                        userId: userIds,
                        flowPrcs: flowPrcss,
                        prcsFlag: prcsFlags
                    },
                    url: '/workflow/work/updateState',
                    dataType: 'json',
                    success: function (res) {
                        if (res.code == '100066'){
                            $.layerMsg({content: '进入删除审批，审批通过后删除', icon: 4});
                            pageObj.init();
                        } else if (res.flag) {
                            $.layerMsg({content: chegon, icon: 1});
                            pageObj.init();
                        } else {
                            $.layerMsg({content: shib, icon: 2});
                        }
                    }
                })
            }, function () {
                layer.closeAll();
            })

        })
    });

</script>
</html>
