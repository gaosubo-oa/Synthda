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
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title><fmt:message code="main.th.feedbackStep" /></title>
    <link rel="stylesheet" href="../../css/workflow/work/m/style.css">
    <style>
        .nofirest {
            height: 44px;
            line-height: 44px;
            padding-left: 15px;
        }
        .l, .r {
            height: 40px;
        }
        .l .circle {
            margin-right: 8px;
            border: none;
        }
        #nextstep{
            padding-left: 0;
        }
        header {
            height: 38px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 15px;
            color: #fff;
            position: fixed;
            width: 90%;
            z-index: 1;
            top: 0;
            padding: 0 5%;
            background-color: #3984ff;
            box-shadow: 1px 1px 7px rgba(0, 0, 0, .85);
        }
    </style>
</head>
<body>
<header>
    <i><a href="javascript:history.go(-1);" style="color: #fff">返回</a></i>
    <span>转交下一步</span>
    <i id="feedbackbtn">确定</i>
</header>
<div style="height:38px"></div>
<div class="turnview" id="pro_turn"><div class="word_title">
    <img src="../../img/workflow/m/apply_next_select.png" alt="" class="icon">
    <div class="word_quick_action"><fmt:message code="main.th.feedbackStep" /></div>
</div>
    <div class="list-panel" id="nextstep">

    </div>

    <div id="panel-next-user">
        <div class="word_title nofirest">
            <img src="../../img/workflow/m/apply_next_select.png" alt="" class="icon">
            <div class="word_quick_action">请输入回退意见：</div>
        </div>
        <div class="signBox">
            <textarea id="feedbacktext" rows="4" class="gapp_textarea" data-key="0" data-field-type="020000" data-must="0" data-is-write="1" name="" placeholder=""></textarea>

        </div>

    </div>
</div>
<script src="../../js/xoajq/xoajq1.js"></script>
<script src="../../js/template.js"></script>
<script src="../../lib/laydate/laydate.js"></script>
<script src="../../js/mustache.min.js"></script>
<script src="../../js/base/base.js"></script>
<script>

var feedback = {};
function ready(){
    if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
        try{
            window.webkit.messageHandlers.rightTitle.postMessage({'title':'<fmt:message code="workflow.th.Transfer" />','name':'xxxxx','function':'feedback'});
        }catch(err){
            rightTitle('<fmt:message code="workflow.th.Transfer" />','xxxxx','feedback');
        }
    } else if (/(Android)/i.test(navigator.userAgent)) {
        //alert(navigator.userAgent);
        Android.rightTitle('<fmt:message code="workflow.th.Transfer" />','xxxxx','feedback');
    }
}
    $(function () {
        var flowId = $.getQueryString("flowId");
        var flowStep = $.getQueryString("flowStep") || '';
        var prcsId = $.getQueryString("prcsId") || '';
        var runId = $.getQueryString("runId") || '';
        var allowback = $.getQueryString("allowback") || '';

            $.ajax({
                type: "get",
                url: "/workflow/work/getflowprcsdata",
                dataType: 'JSON',
                data: {
                    prcsId: flowStep,
                    runId: runId,
                    allowBack:allowback
                },
                success: function (res) {

                   if(res.flag){
                       var prcName = '';
                        res.obj.forEach(function (v,i) {
                            <%--prcName +='<span class="nofirest"><input type="radio" flowPrcs="'+v.flowProcess.prcsId+'" nextPrcsId="0" value="normal2" name="feedbackstep" >&nbsp;<fmt:message code="workflow.th.First" />'+v.prcsId+'<fmt:message code="workflow.th.step" />'+v.flowProcess.prcsName+'&nbsp;&nbsp;主办人：'+v.userName+'</span><br>';--%>
                            prcName +='<li class="nofirest" onclick="ajax_info($(this))" flowprcs="'+v.flowProcess.prcsId+'"><div class="l"><img src="/img/widget_open.png" uname="" class="circle" type="radio" nextprcsid="0" value="normal2" name="nextstep"></div><div class="r"><span style="margin-left: 0;">&nbsp;<fmt:message code="workflow.th.First" />'+v.prcsId+'<fmt:message code="workflow.th.step" />'+v.flowProcess.prcsName+'&nbsp;&nbsp;主办人：'+v.userName+'</span></div></li>'
                        })
                        $('#nextstep').html(prcName);
                        $('.nofirest').eq(0).click();
                   }
                }
             });

        feedback = function () {
            var backflowPrcs = $(".bag").parents('.nofirest').attr('flowprcs');
            var feedbacktext = $('#feedbacktext').val()
            if(feedbacktext == ''){
                alert("<fmt:message code="main.th.ReturnOpinion" />！");
            }else{


            $.ajax({
                type: "get",
                url: "/workflow/work/insertprcsdata",
                dataType: 'JSON',
                data: {
                    flowPrcs : backflowPrcs,
                    prcsId : prcsId,
                    flowStep:flowStep,
                    runId : runId,
                    feedback : feedbacktext
                },
                success: function (res) {
                    if(res.flag){
                        $.layerMsg({content:"回退成功！",icon:1},function(){
                            window.history.go(-2)
                            location.reload();
                        });
                    /************调用移动端返回工作流列表方法************************/
//                        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
//                            finishWork();
//                        } else if (/(Android)/i.test(navigator.userAgent)) {
//                            Android.finishWebActivity();
//                        }

                    }else{
                        alert('回退失败！');
                    }

                }
            });
            }
        };
        $('#feedbackbtn').click(function () {
            feedback();
        });


    });
function ajax_info(a) {
    var e = a.find('.circle');
    e.addClass('bag').attr('src', '/img/widget_check2.png').parents('.nofirest').siblings().find('.circle').removeClass('bag').attr('src', '/img/widget_open.png');
}
</script>
</body>
</html>