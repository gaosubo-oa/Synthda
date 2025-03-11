<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/26
  Time: 10:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <title><fmt:message code="doc.th.To-doList"/></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">

    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <%--<link rel="stylesheet" href="/css/base.css">--%>
    <script src="/js/common/language.js"></script>

    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js?20220415.1"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <%--<script src="/js/document/makeADraft.js"></script>--%>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style type="text/css">
        table{
            table-layout: fixed;
        }
        .pagediv .page-bottom-outer-layer table td:nth-child(3){
            overflow: auto;
            white-space: inherit;
            text-overflow: clip;
            text-align: left;
        }
        .pagediv .page-bottom-outer-layer table td{
            text-align: center;
        }
        .editAndDelete2 {
            color: #e01919;
        }
        .QueryDelete{
            background: #ef4747;
        }
        .wenhao{
            cursor: pointer;
        }
        table tr th{
            padding: 5px 4px!important;
        }
        .pagediv .page-top-inner-layer {
            height: 42px;
        }
        .pagediv .page-top-inner-layer table th{
            line-height: 30px;
        }
        #pageTbody td{
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="headTop">
        <div class="headImg">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/daibanfawen.png" alt="">
        </div>
        <div class="divTitle">
            <fmt:message code="doc.th.To-doList"/>
        </div>


    </div>
    <div style="margin: 0 auto;margin-top: 46px;height: 60px;width: 97%;" class="clearfix">
        <label class="fl" style="margin-top: 16px;display: none;">
            <span class="fl" style="margin-top: 5px;"><fmt:message code="doc.th.recordType"/>：</span>
            <select name="dispatchType" id="">
                <option value=""><fmt:message code="hr.th.PleaseSelect"/></option>
            </select>
        </label>
        
        <label class="fl clearfix" style="margin-top: 16px;margin-left: 10px;">
            <span class="fl" style="margin-top: 5px;"><fmt:message code="global.lang.date"/>：</span>
            <label class="fl"><input name="printDate" readonly="readonly" placeholder="<fmt:message code="doc.th.enterDate"/>" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" type="text"></label>

        </label>
        <label class="fl clearfix" style="margin-top: 16px;margin-left: 10px;" >
            <span class="fl" style="margin-top: 5px;"><fmt:message code="notice.th.title"/>：</span>
            <label class="fl"><input name="title" placeholder="<fmt:message code="document.th.SerialNumber" />"  type="text"></label>
        </label>
        <label class="fl clearfix" style="margin-top: 16px;margin-left: 10px;" >
            <span class="fl" style="margin-top: 5px;"><fmt:message code="notice.th.state"/>：</span>
            <label class="fl"><select name="status">
                <option value=""><fmt:message code="hr.th.PleaseSelect"/></option>
                <option value="1"><fmt:message code="lang.th.will"/></option>
                <option value="2"><fmt:message code="lang.th.Process"/></option>
            </select></label>
            <button type="button" class="Query fl QuerySearch"><fmt:message code="global.lang.query"/></button>
            <button type="button" class="Query fl QueryDelete" onclick="clickeDelete();"><fmt:message code="global.lang.delete"/></button>

        </label>

    </div>


    <div id="pagediv">

    </div>


    <script>
        function runWorkListPage() {
            location.reload();
        }
        function bzlct(e) {
            eventas = e;
            var aa = window.open('/flowSetting/processDesignToolTwo?flowId=' + e.attr('flowid') + '&rilwId=' + e.attr('runid'), '');
        }
        function clickeDelete() {
            var length = $('.kx[name=checkbox]:checked').length;
            var tid = '';
            for (var i = 0; i < length; i++) {
                var $this = $('.kx[name=checkbox]:checked').eq(i);
                var obj = pageObj.arrs[$this.parents('tr').find('.editAndDelete1').attr('data-i')];
                tid += obj.frpId + ',';
            }
            if (length == 0) {
                layer.msg('<fmt:message code="document.th.PleaseSelectAtLeastOneProcess"/>!', {icon: 2});
            } else {
                //删除判断
                layer.confirm('<fmt:message code="sup.th.Delete" />？', {
                    btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'] //按钮
                }, function () {
                    //确定删除，调接口
                    $.ajax({
                        url: '../../workflow/work/deleteRunPrcsBatch',
                        type: 'get',
                        dataType: 'json',
                        data: {
                            idBatch: tid
                        },
                        success: function (obj) {
                            if (obj.code == '100066'){
                                layer.msg('进入删除审批，审批通过后删除', {icon: 4});
                            } else {
                                //第三方扩展皮肤
                                layer.msg('<fmt:message code="workflow.th.delsucess" />', {icon: 6});
                            }
                            location.reload();
                        }
                    })
                }, function () {
                    layer.closeAll();

                });
            }
        }
        var openRold=parent.opensload;
        var typeName;
        var huiqian;
        $.get('/code/GetDropDownBox',{CodeNos:'GWTYPE'},function (json) {
            var arrTwo=json.GWTYPE;
            var str='<option value=""><fmt:message code="hr.th.PleaseSelect"/></option>'
            for(var i=0;i<arrTwo.length;i++){
                str+='<option value="'+arrTwo[i].codeNo+'">'+arrTwo[i].codeName+'</option>'
            }
            $('[name="dispatchType"]').html(str)
        },'json')
        $(document).on('click', '#selectAll', function () {
            var ischecked = $(this).attr('ischecked');
            if (ischecked == 'true') {
                $('.kx').prop("checked", "");
                $(this).attr('ischecked', false);
            } else {
                $('.kx').prop("checked", "checked");
                $(this).attr('ischecked', true);
            }
        })

        window.onresize = function(){
            var screenwidth = document.documentElement.clientWidth;
            if(screenwidth > 1155){
                var nums = screenwidth*0.97;
                var sumwidth = screenwidth*0.97+'px';
            }else{
                var nums = 1120;
                var sumwidth = '1120px';
            }
            pageObj.configuration[0]['width'] = nums * 0.03 + 'px';
            pageObj.configuration[1]['width'] = nums * 0.04 + 'px';
            pageObj.configuration[2]['width'] = nums * 0.200 + 'px';
            pageObj.configuration[3]['width'] = nums * 0.085 + 'px';
            pageObj.configuration[4]['width'] = nums * 0.116 + 'px';
            pageObj.configuration[5]['width'] = nums * 0.126 + 'px';
            pageObj.configuration[6]['width'] = nums * 0.08 + 'px';
            pageObj.configuration[7]['width'] = nums * 0.11 + 'px';
            $('.page-top-outer-layer').css('width',sumwidth).find('table').css('width',sumwidth);
            for(var i=0;i< $('.page-top-outer-layer').find('th').length;i++){
                $('.page-top-outer-layer').find('th').eq(i).css('width',pageObj.configuration[i]['width']);
            }
            $('.page-bottom-outer-layer').css('width',sumwidth).find('.page-bottom-inner-layer').css('width',sumwidth).find('table').css('width',sumwidth);
            var table = $('.page-bottom-outer-layer .page-bottom-inner-layer table');
            for(var i=0;i<table.find('tr').length;i++){
                for(var j=0;j<table.find('tr').eq(i).find('td').length;j++){
                    table.find('tr').eq(i).find('td').eq(j).css('width',pageObj.configuration[j]['width']);
                }
            }
        };

        var screenwidth = document.documentElement.clientWidth;
        if(screenwidth > 1155){
            var nums = screenwidth*0.97;
            var sumwidth = screenwidth*0.97+'px';
        }else{
            var nums = 1120;
            var sumwidth = '1120px';
        }
        var width1 = nums*0.04+'px';
        var width2 = nums*0.200+'px';
        var width3 = nums*0.085+'px';
        var width4 = nums*0.116+'px';
        var width5 = nums*0.126+'px';
        var width7 = nums*0.08+'px';
        var width8 = nums*0.11+'px';
        var width9 = nums*0.03+'px';
        var pageObj=$.tablePage('#pagediv',sumwidth,[
            {
                width: width9,
                title: '<input type="checkbox" name="checkbox" ischecked="false" id="selectAll">',
                name: 'prcsId',
                selectFun: function (prcsId, obj) {
                    if(obj.step == '1') {
                        return '<input type="checkbox" name="checkbox" class="kx">';
                    } else {
                        return '<input type="checkbox" name="checkbox"  disabled>';
                    }
                }
            },
            {
                width:width1,
                title:'<fmt:message code="workflow.th.liushui"/>',
                name:'runId'
            },
            {
                width:width2,
                title:'<fmt:message code="doc.th.DispatchHeader"/>',
                name:'title',
                selectFun:function (title,obj){
                    if(title!=undefined){
                        if(obj.workLevel == 0||obj.workLevel == undefined){
                            var str = '<span style="color: green;">【<fmt:message code="sup.th.ordinary" />】</span>';
                        }else if(obj.workLevel == 1){
                            var str = '<span style="color: red;">【<fmt:message code="sup.th.urgent" />】</span>';
                        }else if(obj.workLevel == 2){
                            var str = '<span style="color: red;">【<fmt:message code="doc.th.ExtraUrgent" />】</span>';
                        }
                        return '<a href="javascript:;" class="title-banli wenhao wenhao1">'+str+title+'</a>'
                    }else {
                        return ""
                    }
                }
            },
            {
                width:width3,
                title:'<fmt:message code="doc.th.Scholar"/>',
                name:'createrName',
                selectFun:function (createrName,obj) {
                    if(createrName){
                        return createrName
                    }else {
                        return ""
                    }
                }

            },{
                width:width4,
                title:'<fmt:message code="doc.th.DispatchTime"/>',
                name:'createTime',
                selectFun:function (createTime,obj) {
                    if(createTime.indexOf('.') > -1){
                        return createTime.split('.')[0]
                    }else {
                        return createTime
                    }
                }
            },
            {
                width:width5,
                title:'<fmt:message code="attend.th.CurrentStep"/>',
                name:'step',
                selectFun:function (step,obj) {
                    return '<div class="BanLitips" runid="'+ obj.runId +'" step="'+step +'"><p  style="color: #2b7fe0;cursor: pointer;" onclick="bzlct($(this))" runid="'+ obj.runId +'" flowid="'+ obj.flowId +'"><fmt:message code="workflow.th.First"/>'+step+'<fmt:message code="workflow.th.step"/>：'+obj.prcsName+'</p>' +
                        '<p style="'+function () {
                            if(obj.ifOutTime!=undefined&&obj.ifOutTime==true){
                                return "color:red";
                            }else {
                                return "color:green";
                            }
                        }()+'">'+function () {
                            if(obj.timeOutStr!=undefined&&obj.timeOutStr!='undefined'){
                                return obj.timeOutStr;
                            }else {
                                return ""
                            }
                        }()+'</p></div>'
                }
            },
            {
                width:width7,
                title:'<fmt:message code="notice.th.state"/>',
                name:'prFlag',
                selectFun:function (prFlag) {
                    if(prFlag==1){
                        return '<fmt:message code="sup.th.NotReceived"/>'
                    }else if(prFlag==2){
                        return '<fmt:message code="lang.th.Process"/>'
                    } else if(prFlag==3){
                        return '<fmt:message code="doc.th.ToReceive"/>'
                    }else {
                        return '<fmt:message code="lang.th.HaveThrough"/>'
                    }
                }
            },
            {
                width:width8,
                title:'<fmt:message code="notice.th.operation"/>'
            }
        ],function (me) {
            me.data.printDate=$('[name="printDate"]').val();
            me.data.dispatchType=$('[name="dispatchType"]').val()
            me.data.title=$('[name="title"]').val()
            me.data.docStatus=$('[name="status"]').val()
            me.data.documentType=0;
            me.data.pageSize = 10;

            /***********公文模块智能开发，根据页面url中存在flowId传值判断******************/
            var flowId = $.GetRequest().flowId|| '';
            me.data.flowId=flowId;
            if(flowId != ''){
                $('.divTitle').html('<fmt:message code="mian.toBeRead" />');
            }
            //1显示  // 2不显示  //不写fn这个属性就是全显示
            me.init('/document/selWillDocSendOrReceive',[{name:'<fmt:message code="document.th.handle" />',fn:function (obj) {
                if(obj.opFlag=="1"){
                    return "<fmt:message code="document.th.handle" />"
                }else if(obj.opFlag=="0") {
                    return "<fmt:message code="workflow.th.JointlySign" />"
                }
            }},{name:'<fmt:message code="roleAuthorization.th.ViewDetails" />',fn:function (obj) {
                return 1
            }},{
                name: '<fmt:message code="global.lang.delete" />', fn: function (obj) {
                    if (obj.step == '1') {
                        // return 1;
                        return '<span style="margin-right: 10px;display: inline-block;cursor: pointer;color: #e01919" title="多余参与过的公文，无法删除"><fmt:message code="global.lang.delete" /></span>'
                    } else {
                        return 0;
                    }
                }
            }])
        })
        //鼠标悬浮当前步骤时，显示提示信息
        var tip_index
        $('#pagediv').on('mouseenter','.BanLitips',function () {
            var that = this;
            $.get('/flowRun/stepStatus',{runId:$(this).attr('runid'),step:$(this).attr('step')},function (res) {
                // console.log(res)
                var data=res.obj
                var str=''
                data.forEach(function (v,i) {
                    str+='<div>'+'<span>'+v.userName+'</span>&nbsp;&nbsp;&nbsp;'+v.prcsFlag+'</div>'
                })
                tip_index=layer.tips(str,that, {
                    tips: [1, '#3595CC'],
                    time: 0
                });
            })
        });
        $('#pagediv').on('mouseleave','.BanLitips',function () {
            layer.close(tip_index);
        });



        $('.QuerySearch').on('click', function () {
            pageObj.data.page=1;
            pageObj.data.printDate=$('[name="printDate"]').val();
            pageObj.data.dispatchType=$('[name="dispatchType"]').val()
            pageObj.data.title=$('[name="title"]').val()
            pageObj.data.docStatus=$('[name="status"]').val()
            pageObj.init();
        })

        $(document).on('click','.title-banli',function () {
            $(this).parents('tr').find('.editAndDelete0').trigger('click');
        })

        $(document).on('click','.editAndDelete0',function () {
            var obj=pageObj.arrs[$(this).attr('data-i')];
            huiqian='zhuban';
            $.popWindow('/workflow/work/workform?&flowId='+obj.flowId+'&prcsId='+obj.realPrcsId+'&flowStep='+obj.step
                +'&runId='+obj.runId+'&tabId='+obj.id+'&tableName='+obj.tableName+'&isNomalType=false&hidden=true&opFlag='+obj.opFlag)
        })

        $(document).on('click','.editAndDelete1',function () {
            var obj=pageObj.arrs[$(this).attr('data-i')];
            typeName=$(this).parent().parent().find('td')[0].innerHTML;
            $.popWindow('/workflow/work/workformPreView?flowId='+obj.flowId+'&flowStep='+obj.step+'' +
                '&tabId='+obj.id+'&tableName='+obj.tableName+'&runId='+obj.runId+'&' +
                'prcsId='+obj.realPrcsId+'&isNomalType=false&hidden=true')
        })

        $(document).on('click', '.editAndDelete2', function () {
            var obj = pageObj.arrs[$(this).attr('data-i')]
            var tid = obj.frpId;
            //删除判断
            layer.confirm('<fmt:message code="sup.th.Delete" />？', {
                btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'] //按钮
            }, function () {
                //确定删除，调接口
                $.ajax({
                    url: '../../workflow/work/deleteRunPrcs',
                    type: 'get',
                    dataType: 'json',
                    data: {
                        id: tid
                    },
                    success: function (obj) {
                        if (obj.code == '100066'){
                            layer.msg('进入删除审批，审批通过后删除', {icon: 4});
                        } else {
                            //第三方扩展皮肤
                            layer.msg('<fmt:message code="workflow.th.delsucess" />', {icon: 6});
                        }
                        location.reload();
                    }
                })
            }, function () {
                layer.closeAll();

            });
        })


    </script>
</body>
</html>
