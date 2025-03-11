<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/27
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <title><fmt:message code="doc.th.MyDispatch"/></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <%--<link rel="stylesheet" href="/css/base.css">--%>
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js?20220415.1"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>
        .pagediv .page-bottom-outer-layer table td:nth-child(2){
            /*overflow: auto;*/
            white-space: inherit;
            text-overflow: clip;
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
        .editAndDelete0, .editAndDelete3, .editAndDelete4 {
            color: #e01919;
        }
        .title-xiangqing{
            display: inline-block;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        #pageTbody td{
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="headTop">
        <div class="headImg">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/wodefawen.png" alt="">
        </div>
        <div class="divTitle">
            <fmt:message code="doc.th.MyDispatch"/>
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
            <label class="fl">
                <input name="printDate"  placeholder="<fmt:message code="doc.th.enterDate"/>" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" type="text">
            </label>
        </label>
        <label class="fl clearfix" style="margin-top: 16px;margin-left: 10px;" >
            <span class="fl" style="margin-top: 5px;"><fmt:message code="notice.th.title"/>：</span>
            <label class="fl"><input name="title" placeholder="<fmt:message code="global.lang.printsubject"/>"  type="text"></label>
        </label>
        <label class="fl clearfix" style="margin-top: 16px;margin-left: 10px;" >
            <span class="fl" style="margin-top: 5px;"><fmt:message code="notice.th.state"/>：</span>
            <label class="fl"><select name="status">
                <option value=""><fmt:message code="hr.th.PleaseSelect"/></option>
                <option value="1"><fmt:message code="sup.th.NotReceived"/></option>
                <option value="2"><fmt:message code="lang.th.Process"/></option>
                <option value="3"><fmt:message code="doc.th.ToReceive"/></option>
                <option value="4"><fmt:message code="sup.th.HaveGoneThrough"/></option>
            </select></label>
            <button  type="button" class="Query fl"><fmt:message code="global.lang.query"/></button>
        </label>

    </div>

    <div id="pagediv">

    </div>
    <script>
        function bzlct(e) {
            eventas = e;
            var aa = window.open('/flowSetting/processDesignToolTwo?flowId=' + e.attr('flowid') + '&rilwId=' + e.attr('runid'), '');
        }
        $.get('/code/GetDropDownBox',{CodeNos:'GWTYPE'},function (json) {
            var arrTwo=json.GWTYPE;
            var str='<option value=""><fmt:message code="hr.th.PleaseSelect"/></option>'
            for(var i=0;i<arrTwo.length;i++){
                str+='<option value="'+arrTwo[i].codeNo+'">'+arrTwo[i].codeName+'</option>'
            }
            $('[name="dispatchType"]').html(str)
        },'json')

        window.onresize = function(){
            var screenwidth = document.documentElement.clientWidth;
            if(screenwidth > 1155){
                var nums = screenwidth*0.97;
                var sumwidth = screenwidth*0.97+'px';
            }else{
                var nums = 1120;
                var sumwidth = '1120px';
            }

            pageObj.configuration[0]['width'] = nums * 0.04 + 'px';
            pageObj.configuration[1]['width'] = nums * 0.230 + 'px';
            pageObj.configuration[2]['width'] = nums * 0.085 + 'px';
            pageObj.configuration[3]['width'] = nums * 0.106 + 'px';
            pageObj.configuration[4]['width'] = nums * 0.106 + 'px';
            pageObj.configuration[5]['width'] = nums * 0.08 + 'px';
            pageObj.configuration[6]['width'] = nums * 0.11 + 'px';

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
        var width2 = nums*0.170+'px';
        var width3 = nums*0.085+'px';
        var width4 = nums*0.106+'px';
        var width5 = nums*0.106+'px';
        var width7 = nums*0.08+'px';
        var width8 = nums*0.17+'px';
        var pageObj=$.tablePage('#pagediv',sumwidth,[
            {
                width:width1,
                title:'<fmt:message code="workflow.th.liushui"/>',
                name:'runId'
            },
            {
                width:width2,
                title:'<fmt:message code="doc.th.DispatchHeader"/>',
                name:'title',
                selectFun:function (title,obj) {
                    if(obj.workLevel == 0||obj.workLevel == undefined){
                            var str = '<span style="color: green;">【<fmt:message code="sup.th.ordinary" />】</span>';
                        }else if(obj.workLevel == 1){
                            var str = '<span style="color: red;">【<fmt:message code="sup.th.urgent" />】</span>';
                        }else if(obj.workLevel == 2){
                            var str = '<span style="color: red;">【<fmt:message code="doc.th.ExtraUrgent" />】</span>';
                        }
                    if(title!=undefined){
                        return '<a href="javascript:;" style="width: '+width2+'" title="'+title+'" class="title-xiangqing">'+str+title+'</a>'
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
            },
            {
                width:width4,
                title:'<fmt:message code="doc.th.DispatchTime"/>',
                name:'printDate'
            },{
                width:width5,
                title:'<fmt:message code="attend.th.CurrentStep"/>',
                name:'step',
                selectFun:function (step,obj) {
                    return '<a class="wenhao" style="cursor: pointer;" onclick="bzlct($(this))" runid="'+ obj.runId +'" flowid="'+ obj.flowId +'"><span><fmt:message code="workflow.th.First"/>'+step+'<fmt:message code="workflow.th.step"/>:'+obj.prcsName+'</span>' +
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
                        }()+'</p></a>'
                }
            },{
                width:width7,
                title:'<fmt:message code="notice.th.state"/>',
                name:'prFlag',
                selectFun:function (prFlag) {
                    if(prFlag==1){
                        return '<span style="color: orange;" title="<fmt:message code="sup.th.NotReceived"/>"><fmt:message code="sup.th.NotReceived"/></span>'
                    }else if(prFlag==2){
                        return '<span style="color: #37aa43;" title="<fmt:message code="lang.th.Process" />"><fmt:message code="lang.th.Process" /></span>'
                    } else if(prFlag==3){
                        return '<span style="color: #2b7fe0;" title="<fmt:message code="doc.th.ToReceive"/>"><fmt:message code="doc.th.ToReceive"/></span>'
                    }else {
                        return '<span style="color: red;" title="<fmt:message code="lang.th.HaveThrough" />"><fmt:message code="lang.th.HaveThrough" /></span>'
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
            me.data.curUserID=2;
            me.data.docStatus=$('[name="status"]').val()
            me.data.documentType=0;
            me.data.pageSize = 10;
            //1显示  // 2不显示  //不写fn这个属性就是全显示
            me.init('/document/selMyDocSendOrReceive',[{name:'<fmt:message code="menuSSetting.th.deleteMenu"/>',fn:function (obj) {

                if(obj.step==1) {
                    return 1
                }else {
                    return 2
                }

            }},{name:'<fmt:message code="roleAuthorization.th.ViewDetails"/>',fn:function (obj) {
                return 1
            }},
                {name:'传阅',fn:function(obj){
                        if (obj.flowProcess.viewPriv == 1) {
                            return '<span style="margin-right: 10px;display: inline-block;cursor: pointer;color: #2b7fe0" title=""><fmt:message code="document.th.circulated" /></span>'
                        } else {
                            return 0;
                        }
                    }
                },{
                name:'<fmt:message code="document.th.StatusOfCirculation" />',fn:function(obj){
                    if(obj.viewUser== ","||obj.viewUser== ""){
                        return 0
                    }else {
                        return  1;
                    }
                }
            },{
                name:'<fmt:message code="roleAuthorization.th.TakeBack" />',fn:function(obj){
                    if(obj.prFlag=="3" ){
                        return 1
                    }else {
                        return  0;
                    }
                }
            },{
                name:'<fmt:message code="document.th.WithdrawalOfCirculation" />',fn:function(obj){
                    if(obj.viewUser== ","||obj.viewUser== ""){
                        return 0
                    }else {
                        return  1;
                    }
                }
            }])
        })

        $('.Query').on('click', function () {
            pageObj.data.page=1;
            pageObj.data.printDate=$('[name="printDate"]').val();
            pageObj.data.dispatchType=$('[name="dispatchType"]').val()
            pageObj.data.title=$('[name="title"]').val()
            pageObj.data.docStatus=$('[name="status"]').val()
            pageObj.init();
        })
        $(document).on('click','.editAndDelete0',function () {
            var obj=pageObj.arrs[$(this).attr('data-i')]
            var ids=obj.frpId;
            var me=this;
            $.layerConfirm({title:'<fmt:message code="menuSSetting.th.suredeleteMenu"/>',content:'<fmt:message code="menuSSetting.th.isdeleteMenu"/>？',icon:0},function(){
                $.get('/workflow/work/deleteRunPrcs',{id:ids},function (json) {
                    if (json.code == '100066'){
                        $.layerMsg({content:'进入删除审批，审批通过后删除',icon:4});
                    } else if(json.flag){
                        $.layerMsg({content:'<fmt:message code="workflow.th.delsucess"/>！',icon:1},function(){
                            $(me).parent().parent().remove()
                        });
                    }else {
                        $.layerMsg({content:'<fmt:message code="lang.th.deleSucess"/>！',icon:2});
                    }
                },'json')
            })
        })

        $(document).on('click','.title-xiangqing',function () {
            $(this).parents('tr').find('.editAndDelete1').trigger('click');
        })

        $(document).on('click','.editAndDelete1',function () {
            var obj=pageObj.arrs[$(this).attr('data-i')]
            $.popWindow('/workflow/work/workformPreView?flowId='+obj.flowId+'&flowStep='+obj.step+'' +
                '&tabId='+obj.id+'&tableName='+obj.tableName+'&runId='+obj.runId+'&' +
                'prcsId='+obj.realPrcsId+'&isNomalType=false&hidden=true')
        })
        $(document).on('click','.editAndDelete2',function () {
            var obj=pageObj.arrs[$(this).attr('data-i')]
            // console.log(obj)
            layer.open({
                type: 1
                ,area :['600px', '250px']
                ,title: '<fmt:message code="document.th.circulated" />'
                ,content: '<div style="margin-top: 20px;"  >' +
                    '<div style="display: flex;margin-left: 45px;margin-top: 45px;" >\n' +
                    '    <label  style="width:70px;padding: 9px 0px;"><fmt:message code="roleAuthorization.th.selectPersonnel" />:</label>\n' +
                    '    <div  >\n' +
                    '      <textarea  type="text" name="userIds"  id="userId" user_id="" disabled style="height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                    '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="userIdAdd"><fmt:message code="global.lang.add" /></a>\n' +
                    ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="userIdDel"><fmt:message code="global.lang.empty" /></a>\n'+
                    ' </div>\n' +
                    '  </div>\n' +
                    '</div>'
                ,btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />']
                ,success: function(layero, index){
                    //人员的添加
                    $(".userIdAdd").on("click",function(){
                        user_id = 'userId';
                        $.popWindow("/common/selectUser");
                    });
                    //人员的删除
                    $('.userIdDel').on('click', function () {
                        $('#userId').attr("dataid","");
                        $('#userId').attr("user_id","");
                        $('#userId').val("");
                    });
                }
                ,yes: function(index, layero){
                    var flowId=obj.flowId
                    var prcsId=obj.realPrcsId
                    var flowStep=obj.step
                    var runId=obj.runId
                    var tableName=obj.title
                    if(flowId==undefined){
                        flowId=''
                    }
                    if(prcsId==undefined){
                        prcsId=''
                    }
                    if(flowStep==undefined){
                        flowStep=''
                    }
                    if(runId==undefined){
                        runId=''
                    }
                    if(tableName==undefined){
                        tableName=''
                    }
                    $.ajax({
                        url:'/workflow/work/Circulate',
                        type: "post",
                        dataType: "json",
                        data:{
                            viewUser:$('#userId').attr('user_id'),
                            flowId:flowId,
                            prcsId:prcsId,
                            flowStep:flowStep,
                            runId: runId,
                            runName:tableName
                        },
                        success:function (res) {
                            if(res.flag){
                                layer.msg('传<fmt:message code="document.th.circulatedSuccess" />！',{icon:1, time: 2000}, function(){
                                    layer.close(index)
                                });
                            }else {
                                layer.msg(res.msg,{icon:2, time: 2000}, function(){
                                    layer.close(index)
                                });
                            }
                        }
                    })
                }
            });
        })
        $(document).on('click','.editAndDelete3',function () {
            var obj=pageObj.arrs[$(this).attr('data-i')]
            window.open('/ToBeReadController/ReadFileInfo?&runId='+obj.runId+'&prcsId='+obj.step+'&flowPrcs='+obj.realPrcsId);
        })

        $(document).on('click','.editAndDelete4',function () {
            var obj=pageObj.arrs[$(this).attr('data-i')]
            $.ajax({
                type: "get",
                url: "/workflow/work/workBack",
                dataType: 'JSON',
                data: {
                    prcsId: obj.step,
                    runId: obj.runId,
                    flowPrcs: obj.realPrcsId,
                    userId:obj.curUserId,
                    tabId:obj.id,
                    tableName:obj.tableName
                },
                success: function (res) {
                    if(res.flag){
                        $.layerMsg({content:'<fmt:message code="document.th.SuccessfulRetrieval" />！',icon:1});
                        location.reload();
                    }else{
                        $.layerMsg({content:'<fmt:message code="document.th.RecallFailure" />！',icon:2});
                        location.reload();
                    }
                }
            });
        })
        $(document).on('click','.editAndDelete5',function () {
            var obj=pageObj.arrs[$(this).attr('data-i')];
            $.layerConfirm({title:'<fmt:message code="document.th.WithdrawalOfCirculation" />',content:'<fmt:message code="document.th.CirculateTheDocument" />',icon:0,offset:"200px"},function(){
                $.ajax({
                    type: "get",
                    url: "/ToBeReadController/withdrawFileRead",
                    dataType: 'JSON',
                    data: {
                        prcsId: obj.step,
                        runId: obj.runId,
                        flowPrcs: obj.realPrcsId,
                        tabId: obj.id,
                        tableName: obj.tableName,
                        flowId: obj.flowId
                    },
                    success: function (res) {
                        if (res.flag) {
                            $.layerMsg({content: '<fmt:message code="document.th.TheCirculationWasSuccessfullyWithdrawn" />！', icon: 1});
                            pageObj.init();
                        } else {
                            $.layerMsg({content: '<fmt:message code="document.th.CirculationRetractionFailed" />！', icon: 2});
                            pageObj.init();
                        }
                    }
                });
            });
        });
    </script>
</body>
</html>
