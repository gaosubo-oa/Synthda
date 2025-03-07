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
    <meta charset="utf-8">
    <title>预算流程设置</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script type="text/javascript" src="/js/jquery/jquery.form.min.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>

    <style>
        .layui-form-label {
            width: 100px;
        }

        .layui-input-block {
            margin-left: 130px;
        }

        .ztree * {
            font-size: 11pt !important;
        }

        #questionTree li {
            border-bottom: 1px solid #ddd;
            line-height: 40px;
            padding-left: 10px;
            cursor: pointer;
            border-radius: 3px;
        }

        .select {
            background: #c7e1ff;
        }

        /*选择流程样式start*/
        .search_inline {
            width: 310px;
            height: 32px;
            display: inline-block;
            position: relative;
        }
        .search_inline .search_inline_item {
            width: 100%;
            box-sizing: border-box;
            height: 32px;
            border: 1px solid #ccc;
        }
        .list {
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
        .sel {
            width: 100%;
            max-height: 250px;
            position: absolute;
            top: 100%;
            left: 0;
            overflow: auto;
            background: #fff;
            border: 1px solid #e2e3e3;
            display: none;
            z-index: 1;
        }
        .canchoose:hover{
            background: #2b7edf;
            color: #fff;
        }
        /*选择流程样式end*/

    </style>

</head>
<body>
<div class="layui-fluid" id="LAY-app-message">
    <input type="hidden" id="sortId">
    <div class="layui-row ">
        <div class="layui-lf" style="width:250px;float:left">
            <div class="layui-card">
                <div class="layui-card-body" id="leftHeight" style="height:650px;">
                    <ul id="questionTree" style="overflow:auto;height:calc(100% - 40px)">
                    </ul>
                </div>
            </div>
        </div>
        <div class="layui-rt rightHeight" style="width:calc(100% - 250px);float:left;background-color: #fff;">
            <div style="padding-left: 10px;height: 100%;">
                <div class="layui-form" style="margin-top: 15px">
                    <div class="layui-form-item">
                        <label class="layui-form-label">选择流程</label>
                        <div class="layui-input-block">
                            <div class="search_inline">
                                <input type="text" class="search_inline_item news_flow_id" dataType="'+(flowId || '')+'" autocomplete="off" name="flowName" placeholder="全部流程">
                                <button class="list" isClick="true"><img src="/img/workflow/work/xiala.png" alt=""></button>
                                <ul class="sel"></ul>
                            </div>
                            <button type="button" class="layui-btn layui-btn-sm add" style="margin-top: -3px;margin-left: 15px">新增</button>
                        </div>
                    </div>
                    <div id="flowSelect" style="overflow-y: auto">
                        <table class="layui-table"><tbody></tbody></table>
                    </div>
                    <div style="text-align: center"><button type="button" class="layui-btn save">保存</button></div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    resizeSize();

    window.onresize = resizeSize;

    $.get('/plbDictonary/selectDictionaryByDictNos', {plbDictNos: 'FLOW_SETTING'}, function (res) {
        if (res.flag) {
            var data = res.object.FLOW_SETTING;
            var str = ''
            for (var i = 0; i < data.length; i++) {
                if (i == 0) {
                    str += '<li class="select"  plbDictNo="' + data[i].plbDictNo + '">' + data[i].dictName + '</li>'
                } else {
                    str += '<li plbDictNo="' + data[i].plbDictNo + '">' + data[i].dictName + '</li>'
                }
            }
            $('#questionTree').html(str);
            selectFlow($('.select').attr('plbDictNo'))
        }
    });

    layui.use(['form'], function () {
        var form = layui.form;

        var loadingIndex = layer.load();

        $('#questionTree').on('click', 'li', function () {
            $(this).addClass('select').siblings().removeClass('select');
            $('#flowSelect tbody').html('')
            selectFlow($('.select').attr('plbDictNo'))
        })

        //新增
        $(document).on('click','.add',function () {
            if($('[name="flowName"]').attr('dataType') && $('[name="flowName"]').val()){
                var lock=false
                $('#flowSelect tbody .flowTd').each(function () {
                    if($(this).attr('dataType') == $('[name="flowName"]').attr('dataType')){
                        layer.msg('请选择不同的流程！', {icon: 0, time: 1500});
                        lock=true
                        return false
                    }
                })
                if(lock){
                    return false
                }
                if($('.noFlowData').length>0){
                    $('#flowSelect tbody').html('')
                }
                var str='<tr><td class="flowTd" dataType="'+$('[name="flowName"]').attr('dataType')+'">'+$('[name="flowName"]').val()+'</td><td width="80" align="center"><button type="button" class="layui-btn layui-btn-sm layui-btn-danger del">删除</button></td></tr>'
                $('#flowSelect tbody').append(str)
            }else{
                layer.msg('请选择一个流程！', {icon: 0, time: 1500});
                return false;
            }
        })

        //删除
        $(document).on('click','.del',function () {
            $(this).parents('tr').remove()
        })

        //保存
        $(document).on('click','.save',function () {
            var flowIds=''
            $('#flowSelect tbody .flowTd').each(function () {
                flowIds+=$(this).attr('dataType')+','
            })
            $.get('/plbFlowSetting/update',{flowIds:flowIds,plbDictNo:$('.select').attr('plbDictNo')},function (res) {
                if(res.flag){
                    layer.msg('保存成功！', {icon: 1,});
                }
            })
        })

        // 获取全部流程
        $.ajax({
            url:"/flow/selOneToAllType",
            type:'post',
            dataType:'json',
            success:function(res){
                layer.close(loadingIndex);
                var data=res.datas;
                var str='<option value=""><fmt:message code="hr.th.PleaseSelect"/></option>';
                if(res.flag){
                    var flowId = $.GetRequest().flowId;
                    $.each(data,function(i,item){
                        $('.sel').append("<li class='ones' style='font-weight:bold;font-size:14px;' id="+item.sortId +"><img src='../../img/data_points.png' style='margin-right: 5px;' alt=''>" + item.sortName + "<li>");
                        $.each(item.flowTypeModels,function(j,v){
                            $('.sel').append("<li style='padding-left:10px;cursor:pointer' class='canchoose' value="+v.flowId +">" +v.flowName + "<li>");
                            if(flowId&&flowId==v.flowId){
                                $('[name="flowName"]').val(v.flowName);
                                $('[name="flowName"]').attr('dataType',v.flowId);
                                $('[name="flowName"]').attr('readonly','true');
                                $('.list').hide();
                                return;
                            }
                        })
                        buildNode(1,item.childs);
                    });
                    $('.search_inline').each(function (index,element) {
                        $(element).find('.canchoose').each(function (i,n) {
                            // $('.search_inline .canchoose').each(function (i,n) {
                            // 	if($(this).attr('value')==$('.search_inline .news_flow_id').eq(index).attr('datatype')){
                            if($(n).attr('value')==$(element).find('.news_flow_id').attr('datatype')){
                                $(n).trigger('click');
                                return false;
                            }
                        });
                    })
                }
            }
        });

        //监听流程下拉按钮
        $(document).on('click','.list',function (e) {
            e.stopPropagation()
            $('.list').removeAttr('isClick')
            $(this).attr('isClick','true')
            if($(this).attr('isClick')){
                if($(this).next().css('display')!='none'){
                    $(this).next().hide()
                }else{
                    $(this).next().show()
                }
            }
        })
        //监听流程选择
        $(document).on('click','.sel li',function(e){
            e.stopPropagation()
            if($(this).parent().prev().attr('isClick')){
                if($(this).attr('value')){
                    $(this).parent().siblings('[name="flowName"]').val($(this).html())
                    $(this).parent().siblings('[name="flowName"]').attr('dataType',$(this).attr('value'))
                    $('.sel').hide()
                }else{
                    $('.sel').show()
                }
            }
        })

        $(document).on('click',function(){
            $('.sel').hide()
        })

        //实时搜索流程
        $('[name="flowName"]').on('keyup',function(){
            $('.sel').show()
            var val=$(this).val()
            $('.sel li').each(function(i,v){
//            console.log(v.innerHTML)
                if(v.innerHTML.indexOf(val)>-1){
                    $(v).show();
                    $(v).parent().show()
                }else{
                    $(v).hide();
                }
            })

        })

        function buildNode(len,data){
            var prefix = 10;
            for(var i=0;i<len;i++){
                prefix += 10;
            }

            $.each(data,function(i,item){
                if(0 < item.childs.length){
                    $('.sel').append("<li style='padding-left:"+(prefix)+"px;font-weight:bold;font-size:14px;' id="+item.sortId +">" + item.sortName + "<li>");
                    $.each(item.flowTypeModels,function(j,v){
                        $('.sel').append("<li style='padding-left:"+(prefix+10)+"px;cursor:pointer' class='canchoose' value="+v.flowId +">" +  v.flowName + "<li>");
                    })
                    buildNode(len+1,item.childs);
                }else{
                    $('.sel').append("<li style='padding-left:"+(prefix)+"px;font-weight:bold;font-size:14px;' id="+item.sortId +">" + item.sortName + "<li>");
                    $.each(item.flowTypeModels,function(j,v){
                        $('.sel').append("<li style='padding-left:"+(prefix+10)+"px;cursor:pointer' class='canchoose' value="+v.flowId +">" +  v.flowName + "<li>");
                    })
                }
            });
        }

    })

    //显示右侧所选流程
    function selectFlow(plbDictNo) {
        $.get('/flow/getDataByCondition',{plbDictNo:plbDictNo},function (res) {
            if(res.data && res.data.flowData){
                var flowData=res.data.flowData
                var str=''
                for(var i in flowData){
                    str+='<tr><td class="flowTd" dataType="'+i+'">'+flowData[i]+'</td><td width="80" align="center"><button type="button" class="layui-btn layui-btn-sm layui-btn-danger del">删除</button></td></tr>'
                }
                $('#flowSelect tbody').append(str)
            }else{
                $('#flowSelect tbody').append('<tr class="noFlowData"><td colspan="3" align="center">暂无所选流程</td></tr>')
            }
        })
    }

    // 初始化内容高度
    function resizeSize() {
        var height = $(window).height()
        $('#leftHeight').height(height - 80)
        $('#flowSelect').height(height - 150)
    }

</script>
</body>
</html>