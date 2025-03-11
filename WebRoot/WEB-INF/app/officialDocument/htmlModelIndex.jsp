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

<html>
<head>
    <title><fmt:message code="doc.th.TemplateSetting"/></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/js/jquery/jquery-validate.js"></script>
    <script src="/lib/validate-mothods.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>


<%--    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>--%>
<%--    <script type="text/javascript" src="../../js/base/base.js"></script>--%>
<%--    <script src="/lib/layer/layer.js?20201106"></script>--%>
<%--    <script src="../../lib/laydate/laydate.js"></script>--%>
<%--    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>--%>
<%--    <script src="/lib/layer/layer.js?20201106"></script>--%>
<%--    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>--%>
<%--    <script type="text/javascript" src="/js/base/base.js"></script>--%>
<%--    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>--%>
<%--    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>--%>
<%--    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>--%>
<%--    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>--%>

    <style>
        .header {
            height: 43px;
            border-bottom: 1px solid #9E9E9E;
            overflow: hidden;
            margin-bottom: 10px;
            position: fixed;
            top: 0px;
            width: 100%;
            background-color: #fff;
            z-index: 1099;
        }
        .nav li {
            height: 33px;
            line-height: 32px;
            float: left;
            font-size: 14px;
            margin-left: 20px;
            margin-top: 6px;
            cursor: pointer;
        }
        .select {
            background-color: #2F8AE3;
            color: #fff;
            border-radius: 20px;
            -webkit-border-radius: 20px;
            -moz-border-radius: 20px;
            -o-border-radius: 20px;
            -ms-border-radius: 20px;
        }
        .pad {
            padding: 6px 14px;
            line-height: 28px;
        }
        .space {
            width: 2px;
            margin-left: 16px;
        }
        .newNews tr td {
            border: 1px solid #c0c0c0;
        }
        .td_title1 {
            display: inline-block;
            float: left;
            border: 1px solid #d9d9d9;
            width: 300px;
            color: #333;
            padding-left: 3px;
            background: #fff;
        }
        .close_but {
            width: 90px;
            height: 30px;
            line-height: 30px;
            border-radius: 4px;
            margin-left: 20px;
            padding-left: 14px;
            cursor: pointer;
            background: url(../../img/sys/cole.png) no-repeat;
            font-size: 16px;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }
        #save,#save2 {
            background: url(../../img/vote/saveBlue.png) no-repeat;
            color: #fff;
            line-height: 30px;
            font-size: 16px;
            width: 91px;
            height: 30px;
            cursor: pointer;
            padding-left: 11px;
        }
    </style>
</head>
<body>
<div class="header">
    <ul class="nav">
        <li data-type="0"><span class="pad">word模板</span></li>
        <li><img class="space" src="../../img/twoth.png" alt=""></li>
        <li data-type="1" class="select"><span class="pad">网页模板</span></li>
    </ul>
</div>
<div class="step">
    <div class="headTop" style="top: 60px">
        <div class="headImg">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_templateSet.png" alt="">
        </div>
        <div class="divTitle">网页模板</div>
        <a href="javascript:void(0)" class="new_xinjiano new_xinjianoTwo" data-id="1"><fmt:message code="global.lang.new"/></a>
    </div>
    <div style="margin: 0 auto;margin-top: 120px;height: 60px;width: 97%;" class="clearfix">
        <label class="fl" style="margin-top: 16px;">
            <select name="dispatchType" id="modelManage" class="modelType" onchange="ChangeType(this.value);">
                <option value="">所有类别</option>
            </select>
        </label>


        <div id="dbgz_page" class="M-box3 fr">

        </div>
    </div>

    <div class="pagediv" style="margin: 0 auto;width: 97%;">
        <table>
            <thead>
            <tr>
                <th style="min-width: 40px">排序号</th>
                <th style="min-width: 110px">模板名称</th>
                <th style="min-width: 85px">模板类别</th>
                <th style="min-width: 95px">操作</th>
            </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
</div>
<div class="step1" style="margin-left: 10px;display: none;margin-top: 100px;">
      <table class="newNews">
           <tbody>
           <tr>
               <td class="td_w blue_text">排序号：</td>
               <td><input class="td_title1" type="text" placeholder="" id="modelNo" /></td>
           </tr>
           <tr>
              <td class="td_w blue_text">模板名称：</td>
               <td><input class="td_title1" type="text" placeholder="" id="modelName" /></td>
           </tr>
           <tr>
                 <td class="td_w blue_text">模板类别：</td>
                 <td>
                    <select class="td_title1 modelType" style="box-sizing: border-box;" id="modelType" >
                           <option value="">所有类别</option>
                    </select>
                 </td>
           </tr>
             <tr>
                <td  colspan="2"><div id="container" style="width: 99.9%;min-height: 200px;" name="content" type="text/plain"></div></td>
              </tr>
             </tbody>
          <div>
              <tr style="text-align:center">
                  <td colspan="2">
                      <button type="button" class="close_but" id="save">保存</button>
                      <button type="button" class="close_but" id="save2" style="display: none">保存</button>
                      <button type="button" class="close_but" id="return" style="width: 91px;height: 30px;line-height: 30px;font-size: 16px;">返回</button>
                  </td>
              </tr>
          </div>
        </table>
</div>


<script>
    $('.header li').click(function () {
        $(this).siblings('li').removeClass('select')
        $(this).addClass('select')
        if($(this).attr('data-type')=='0'){
            window.location.href = '/document/officialDocumentSet'
        }else if($(this).attr('data-type')=='1'){
            window.location.href = '/htmlModel/index'
        }
    })
    function ChangeType(MODEL_TYPE)
    {
        ajaxPage.data.modelType = MODEL_TYPE;
        ajaxPage.page()
    }
    var ue = UE.getEditor('container',{elementPathEnabled : false});
    modelType()
    function modelType(){
        $.ajax({
            type: 'get',
            url: "/code/getCode",
            data: {"parentNo": "HTML_MODEL_TYPE"},
            success: function (data) {
                if(data.flag){
                    var str = ''
                    for (var x = 0; x < data.obj.length; x++) {
                        str += "<option value=" + data.obj[x]["codeNo"] + ">" + data.obj[x]["codeName"] + "</option>"
                    }
                }
                $(".modelType").append(str);
            }
        });
    }
    var ajaxPage={
        data:{
            page:1,//当前处于第几页
            limit:10,//一页显示几条
            useFlag:true,
        },
        page:function () {
            var me=this;
            $.get('/htmlModel/selectAllHtmlModel',me.data,function (json) {
                if(json.flag){
                    var str='';
                    if(json.obj.length > 0){
                        for(var i=0;i<json.obj.length;i++){
                            str+='<tr>' +
                                '<td>'+function () {
                                    if(json.obj[i].modelNo != undefined){
                                        return json.obj[i].modelNo
                                    }else {
                                        return ''
                                    }
                                }()+'</td>' +
                                '<td>'+function () {
                                    if(json.obj[i].modelName != undefined){
                                        return json.obj[i].modelName
                                    }else {
                                        return ''
                                    }
                                }() +'</td>' +
                                '<td>'+function () {
                                    if(json.obj[i].modelTypeName != undefined){
                                        return json.obj[i].modelTypeName
                                    }else {
                                        return ''
                                    }
                                }() +'</td>' +
                                '<td><a href="javascript:void(0)" class="new_xinjianoTwo" modelId="'+json.obj[i].modelId+'" style="margin-right: 10px">编辑</a>' +
                                '<a href="javascript:void(0)" modelId="'+json.obj[i].modelId+'" class="deleteSc">删除</a></td>' +
                                '</tr>'
                        }
                        $('.pagediv table tbody').html(str)
                        me.pageTwo(json.totleNum,me.data.limit,me.data.page)
                    }else{
                        $('.pagediv table tbody').html(str)
                        layer.msg('暂无数据！',{time:1000,icon:2})
                    }

                }

            },'json')
        },
        pageTwo:function (totalData, pageSize,indexs) {
            var mes=this;
            $('#dbgz_page').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage:'',
                endPage: '',
                current:indexs||1,
                callback: function (index) {
                    mes.data.page=index.getCurrent();
                    mes.page();
                }
            });
        }
    }
    ajaxPage.page()
    var modelId;
    var url=''
    $(document).delegate('.new_xinjianoTwo','click',function () {
        $('.step').css('display','none')
        $('.step1').css('display','block')
        var me=this;
        if($(this).attr('data-id')==1){
            url='/htmlModel/addHtmlModel'
        }else {
            $('#save').css('display','none')
            $('#save2').css('display','inline-block')
            modelId = $(this).attr('modelId')
            url='/htmlModel/updateHtmlModel'
            $.ajax({
                type: 'get',
                url: '/htmlModel/selectAllHtmlModel',
                dataType: 'json',
                data:{
                    modelId:modelId
                },
                success: function (res) {
                    if(res.flag){
                        $("#modelNo").val(res.obj[0].modelNo);
                        $("#modelName").val(res.obj[0].modelName);
                        var numbers = $("#modelType").find("option"); //获取select下拉框的所有值
                        for (var j = 1; j < numbers.length; j++) {
                            if ($(numbers[j]).val() == res.obj[0].modelType) {
                                $(numbers[j]).attr("selected", "selected");
                            }
                        }
                        ue.ready(function () {
                            ue.setContent(res.obj[0].contentStr);
                        });
                    }
                }
            })
        }

    })
    //保存
    function save(url,modelId){
        var modelNo = $("#modelNo").val();
        var reg =/^[0-9]*$/; //数字
        if(!reg.test(modelNo)){
            layer.msg('排序号只能输入数字',{time:1000,icon:2})
            return false;
        }
        var modelName = $("#modelName").val();
        var modelType = $("#modelType").val();
        var contentStr = ue.getContent();
        if(modelName == null || modelName == ''){
            layer.msg('模板名称不能为空',{time:1000,icon:2})
            return false;
        }
        $.ajax({
            type: 'get',
            url: url,
            dataType: 'json',
            data:{
                modelNo:modelNo,
                modelName:modelName,
                modelType:modelType,
                contentStr:contentStr,
                modelId:modelId
            },
            success: function (res) {
                if(res.flag){
                    layer.msg('保存成功！',{time:1000,icon:1})
                    window.location.reload();
                }else{
                    layer.msg('保存失败！',{time:1000,icon:2})
                }
            }
        })
    }
    $('#save').click(function () {
        save(url)
    });
    $('#save2').click(function () {
        save(url,modelId)
    });
    $(document).delegate('.deleteSc','click',function () {
        var me=this;
        layer.confirm(' 确定要删除吗', {
            btn: ['确定', '取消'], //按钮
            title: " 删除"
        }, function () {
            $.ajax({
                url: '/htmlModel/deleteHtmlModel',
                type: 'post',
                dataType: 'json',
                data: {modelId: $(me).attr('modelid')},
                success: function () {
                    layer.msg(' 删除成功', {icon: 6});
                    ajaxPage.page()
                }
            })
        }, function () {
            layer.closeAll();
        })

    })
    $('#return').click(function () {
        window.location.reload();
    });
</script>

</body>
</html>
