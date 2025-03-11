<%--
  Created by IntelliJ IDEA.
  User: dongke
  Date: 2021/3/29
  Time: 8:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>检查项详情</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20190817.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="/lib/jquery.form.min.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" href="/lib/zTree_v3/css/zTreeStyle/zTreeStyle.css"/>
    <script type="text/javascript" src="/lib/zTree_v3/js/jquery.ztree.all.min.js"></script>
    <style>
        #basic_infor .basic_infor_title{
            background: #f5f5f9;
            height: 32px;
            padding: 0 16px;
        }
        #basic_infor .basic_infor_title .basic_infor{
            margin-left: 6px;
            line-height:32px;
        }
        #basic_infor .basic_infor_title .icon{
            margin-top: 8px;
            height: 16px;
            width: auto;
        }
        #basic_infor .basic_infor_title .icon{
            margin-top: 8px;
            height: 16px;
            width: auto;
        }
        #basic_infor{
            z-index: 998;
        }
        #basic_infor .basic_infor_title{
            background: #f5f5f9;
            height: 32px;
            padding: 0 16px;
        }
        .uploadbox p{margin-bottom: 5px;color: #095de0;display: inline-block}

        .uploadbox{
            font-size: 11pt;
        }

    </style>
</head>
<body>
<form class="layui-form" action style="position: absolute;left: -26px;width: 100%;">
    <div class="layui-form" style="margin-top: 26px;margin-bottom: 26px">
  <div class="layui-form-item">
      <label class="layui-form-label">检查区域</label>
      <div class="layui-input-block">
          <input type="text" name="title" id="securityRegionName" layui-verify="title" autocomplete="off" class="layui-input">
      </div>
  </div>
    <div class="layui-form-item">
        <label class="layui-form-label">图纸位置</label>
        <div class="layui-input-block">
            <input type="text" name="title" id="securityPhoto" layui-verify="title" placeholder="待开发" disabled="disabled" autocomplete="off" class="layui-input">
<%--          <span>已标注</span>--%>
<%--            <span id="spa">查看</span>--%>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">检查项</label>
        <div class="layui-input-block">
            <input type="text" name="title" id="securityKnowledgeName" layui-verify="title" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">隐患级别</label>
        <div class="layui-input-block">
            <input type="text" name="title" id="securityGradeName" layui-verify="title" autocomplete="off" class="layui-input">
        </div>
    </div>
        <div class="layui-form-item">
            <label class="layui-form-label">检查内容</label>
            <div class="layui-input-block">
                <input type="text" name="title" id="securityDanger" layui-verify="title" autocomplete="off" class="layui-input">
            </div>
        </div>
    <div class="layui-form-item">
        <label class="layui-form-label">整改措施</label>
        <div class="layui-input-block">
            <input type="text" name="title" id="securityDangerMeasures" layui-verify="title" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" id="securityDangerDescDv">
        <label class="layui-form-label">隐患描述</label>
        <div class="layui-input-block">
            <input type="text" name="title" id="securityDangerDesc"  layui-verify="title" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" id="rectificationRadio">
        <label class="layui-form-label">是否整改</label>
        <div class="layui-input-block">
            <input type="radio" lay-filter="rectificationfilter" name="rectificationfilter" id="filter1" value="0" title="是" checked="checked" >
            <input type="radio" lay-filter="rectificationfilter" name="rectificationfilter" id="filter2" value="1" title="否" >
        </div>
    </div>
        <div class="layui-form-item" id="test1Dv">
                <label class="layui-form-label">整改期限</label>
               <div class="layui-input-inline">
                        <input  class="layui-input" id="test1"  tabindex="-1" readonly="readonly">
                    </div>
            </div>
           <div class="layui-form-item" id="rectificationPersionDv" >
                <label class="layui-form-label">整改人</label>
                <div class="layui-input-block">
                        <input type="text" name="title"  layui-verify="title" id="rectificationPersion" autocomplete="off" class="layui-input" readonly="readonly">
                    </div>
            </div>
                <div class="layui-form-item" id="acceptancefilterRadio">
                    <label class="layui-form-label">是否验收</label>
                    <div class="layui-input-block">
                            <input type="radio" lay-filter="acceptancefilter" name="acceptancefilter" id="filter3" value="0" title="是" checked="checked" >
                            <input type="radio" lay-filter="acceptancefilter" name="acceptancefilter" id="filter4" value="1" title="否" >
                        </div>
               </div>
        <div class="layui-form-item" id="acceptancePersionDv">
            <label class="layui-form-label">验收人</label>
            <div class="layui-input-block">
                <input type="text" name="title"  layui-verify="title" id="acceptancePersion" autocomplete="off" class="layui-input" readonly="readonly">
            </div>
        </div>

<div class="basic_infor_title" id="uploadDv"  >
    <div class="basic_infor" style="font-size: 16px;color: #333;margin-left: 6px;font-weight: 900"><fmt:message code="email.th.file" /></div>
    <div class="basic_infor_title_link" style="position: relative">
        <a href="javascript:;" class="xzbtn" style="height: 32px;line-height: 32px;font-size: 16px;color: #01adff;position: absolute;left: 85px;"  id="upload"></a>
    </div>
</div>
<div style="padding-bottom: 8px;" id="uploadboxDv">
    <div>
        <ul class="uploadbox">

        </ul>
    </div>
    <div class="photo_box" style="margin-top: 43px;margin-left: 37px; display: flex;flex-wrap: wrap;align-content: space-between;padding-left: 55px">

    </div>
</div>
    </div>
</form>

<script>
    var user_id;
    var checkliId;
    var rectificationId;
    var ids;
    var checkStatus;//判断是否二次提交
    var checkFlag;//判断是否已检查
    var recificationFlag;//判断是否已整改
    var acceptanceFlag;//判断是否已验收
    var needRecification;//判断是否需要整改
    var needAcceptance;//判断是否需要验收
    layui.use(['laydate','form'],function(){
         laydate = layui.laydate;
         form=layui.form;
        $("#rectificationPersion").click(function(){
            user_id='rectificationPersion';
            layer.open({
                type: 2,
                title: '选择用户',
                content: "/common/selectUser?0",
                area: ['100%', '80%']
            })
        })

        $("#acceptancePersion").click(function(){
            user_id='acceptancePersion';
            layer.open({
                type: 2,
                title: '选择用户',
                content: "/common/selectUser?0",
                area: ['100%', '80%']
            })
        })
        laydate.render({
            elem: '#test1' //指定元素
            ,trigger: 'click'
            ,format: 'yyyy-MM-dd'
        });
        laydate.render({
            elem: '#checkTime' //指定元素
            ,trigger: 'click'
            ,format: 'yyyy-MM-dd'
        });
        laydate.render({
            elem: '#rectificationTime' //指定元素
            ,trigger: 'click'
            ,format: 'yyyy-MM-dd'
        });
        laydate.render({
            elem: '#acceptanceTime' //指定元素
            ,trigger: 'click'
            ,format: 'yyyy-MM-dd'
        });
       form.on('radio(rectificationfilter)', function(data){
            var dataval=data.value;
            if(dataval==0){
                //需要整改
                $("#test1Dv").show();
                $("#rectificationPersionDv").show();
                $("#acceptancefilterRadio").show();
                $("#acceptancePersionDv").show();
            }else{
                $("#test1Dv").hide();
                $("#rectificationPersionDv").hide();
                $("#acceptancefilterRadio").hide();
                $("#acceptancePersionDv").hide();
            }
        });
        form.on('radio(acceptancefilter)', function(data){
            var dataval=data.value;
            if(dataval==0){
                //需要验收
                $("#acceptancePersionDv").show();
                $("#acceptanceDescDv").show();
            }else{
                $("#acceptancePersionDv").hide();
                $("#acceptanceDescDv").hide();
            }
        });
    })

    function getUrlParam(name) {
        //构造一个含有目标参数的正则表达式对象
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        //匹配目标参数
        var r = window.location.search.substr(1).match(reg);
        //返回参数值
        if (r != null) return unescape(r[2]); return null;
    }
    var seciritytype=getUrlParam("seciritytype");
    var securityContentId=getUrlParam("securityContentId");
    var projectId=getUrlParam("projectId");
    var testTypeNo=getUrlParam("testTypeNo");
    var datatype=getUrlParam("datatype");
   judge(seciritytype);
    function judge(seciritytype){

        var seciritytype=Number(seciritytype);
        switch (seciritytype) {
           case 0:
               initsecurityContent(securityContentId);
               var btn=`<div class="layui-colla-item" style="float: right;margin-bottom: 30px">
               <button type="button" class="layui-btn layui-btn-sm" onclick="checkSubmit()">提交</button>
               <button type="button" class="layui-btn layui-btn-sm" onclick="pageBack()">返回</button>
               </div>`;
               var checkTime=`<div class="layui-form-item">
                <label class="layui-form-label">检查时间</label>
               <div class="layui-input-inline">
                        <input  class="layui-input" id="checkTime"  tabindex="-1" readonly="readonly">
                    </div>
            </div>`;
               $("#upload").text("上传质量检查照片");
               $("#securityDangerDescDv").after(checkTime);
               $("#uploadboxDv").after(btn);
               break;
           case 1:
               var htm="<div class='layui-form-item' id='rectificationDescDv' >" +
                   " <label class=\"layui-form-label\">整改描述</label>"+
                   "<div class='layui-input-block'> <input id='rectificationDesc' type=\"text\" name=\"title\"  layui-verify=\"title\" autocomplete=\"off\" class=\"layui-input\"></div>"+
                   "</div>\n";
               var btn=`<div class="layui-colla-item" style="float: right;margin-bottom: 30px">
               <button type="button" class="layui-btn layui-btn-sm" onclick="rectificationPreservation()">保存</button>
               <button type="button" class="layui-btn layui-btn-sm" onclick="rectificationSubmit()">保存并提交</button>
               <button type="button" class="layui-btn layui-btn-sm" onclick="pageBack()">返回</button>
               </div>`;
               var rectificationTime=`<div class="layui-form-item" >
                <label class="layui-form-label">整改时间</label>
               <div class="layui-input-inline">
                        <input  class="layui-input" id="rectificationTime"  tabindex="-1" readonly="readonly">
                    </div>
            </div>`;
               $("#upload").text("上传质量整改照片");
             $("#rectificationPersionDv").after(htm);
             $("#rectificationDescDv").after(rectificationTime);
             $("#uploadboxDv").after(btn)
               $("#securityDangerDesc").attr("disabled","disabled");
               $("#test1").attr("disabled","disabled");
               $("#rectificationPersion").attr("disabled","disabled");
               $("#acceptancePersion").attr("disabled","disabled");
               $("[name='rectificationfilter']").attr("disabled","disabled");
               $("[name='acceptancefilter']").attr("disabled","disabled");
               initsecurityContent(securityContentId);
               break;
           case 2:
               var rectificationDescDvhtm="<div class='layui-form-item' id='rectificationDescDv' >" +
                   " <label class=\"layui-form-label\">整改描述</label>"+
                   "<div class='layui-input-block'> <input id='rectificationDesc' type=\"text\" name=\"title\"  layui-verify=\"title\" autocomplete=\"off\" class=\"layui-input\"></div>"+
                   "</div>\n";
               var acceptanceDescDvhtm= "<div class='layui-form-item' id='acceptanceDescDv' >" +
                   " <label class=\"layui-form-label\">验收描述</label>"+
                   "<div class='layui-input-block'> <input id='acceptanceDesc' type=\"text\" name=\"title\"  layui-verify=\"title\" autocomplete=\"off\" class=\"layui-input\"></div>"+
                   "</div>\n";
               var btn=`<div class="layui-colla-item" style="float: right;margin-bottom: 30px">
               <button type="button" class="layui-btn layui-btn-sm" onclick="acceptanceAgree()">保存并同意</button>
               <button type="button" class="layui-btn layui-btn-sm" onclick="acceptanceBack()">保存并退回</button>
               <button type="button" class="layui-btn layui-btn-sm" onclick="acceptancePreservation()">保存</button>
               <button type="button" class="layui-btn layui-btn-sm" onclick="pageBack()">返回</button>
               </div>`;
               var acceptanceTime=`<div class="layui-form-item"  id="acceptanceTimeDv">
                <label class="layui-form-label">验收时间</label>
               <div class="layui-input-inline">
                        <input  class="layui-input" id="acceptanceTime"  tabindex="-1" readonly="readonly">
                    </div>
            </div>`;
               $("#upload").text("上传质量验收照片");
               $("#rectificationPersionDv").after(rectificationDescDvhtm);
               $("#uploadboxDv").after(acceptanceDescDvhtm,btn);
               $("#acceptancefilterRadio").after(acceptanceTime)
               $("#rectificationDesc").attr("disabled","disabled");
               $("#securityDangerDesc").attr("disabled","disabled");
               $("#test1").attr("disabled","disabled");
               $("#rectificationPersion").attr("disabled","disabled");
               $("#acceptancePersion").attr("disabled","disabled");
               $("[name='rectificationfilter']").attr("disabled","disabled");
               $("[name='acceptancefilter']").attr("disabled","disabled");
               initsecurityContent(securityContentId);
               break;
        }
    }


    function initsecurityContent(securityContentId) {
          $.ajax({
              url:"/workflow/qualityManager/getDetailsInfoById",
              data:{detailsInfoId:securityContentId},
              dataType:"json",
              type:"post",
              success:function (res) {
                 $("#securityRegionName").val(res.obj.securityRegionName).attr("disabled","disabled");
                 $("#securityKnowledgeName").val(res.obj.securityKnowledgeName).attr("disabled","disabled");
                 $("#securityGradeName").val(res.obj.securityGradeName).attr("disabled","disabled");
                 $("#securityDangerMeasures").val(res.obj.securityDangerMeasures).attr("disabled","disabled");
                 $("#securityDanger").val(res.obj.securityDanger).attr("disabled","disabled");
                 $("#securityDangerDesc").val(res.obj.securityDangerDesc);
                 $("#test1").val(res.obj.rectificationPeriod);
                 $("#rectificationPersion").val(res.obj.rectificationPersionName);
                 $("#rectificationPersion").attr("user_id",res.obj.rectificationPersion)
                 $("#acceptancePersion").val(res.obj.acceptancePersionName);
                 $("#acceptancePersion").attr("user_id",res.obj.acceptancePersion);
                 $("#rectificationDesc").val(res.obj.rectificationDesc);
                 $("#acceptanceDesc").val(res.obj.acceptanceDesc);
                 $("#checkTime").val(res.obj.checkTime);
                 $("#rectificationTime").val(res.obj.rectificationTime);
                 $("#acceptanceTime").val(res.obj.acceptanceTime);
                  var n=res.obj.attachmentList;
                  var photo=""
                  for(var i=0;i<n.length;i++){
                      var fileId="\"blah"+i+"\"";
                      photo+="<div id='blah"+i+"' style='position: relative'>" +
                          "<img attachmentId="+res.obj.attachmentId+" attachmentName="+res.obj.attachmentName+" delurl="+n[i].attUrl+" src='/xs?"+n[i].attUrl+"' style='width: 70px;height: 100px;margin-right: 10px;margin-bottom: 10px;'/>" +
                          "<span class='layui-icon layui-icon-close-fill spa'  style='color: #DC143C;position: absolute;left: 59px;top: -4px;' onclick='delFile("+fileId+")' ></span>"+
                          "</div>"
                  }
                  $(".photo_box").html(photo);
                 // $("#spa").click(function(){
                 //     window.location.href="/workflow/qualityManager/securityDrawing?securityContentId="+securityContentId+"";
                 // })
                  checkliId=res.obj.checkliId;
                  rectificationId=res.obj.rectificationId;
                  ids=res.obj.rectificationId;
                  checkFlag=res.obj.checkFlag  //判断是否已检查
                  recificationFlag=res.obj.recificationFlag//判断是否已整改
                  acceptanceFlag=res.obj.acceptanceFlag//判断是否已验收
                  needRecification=res.obj.needRecification;
                  needAcceptance=res.obj.needAcceptance;
                  if(needRecification==0){
                      //需要整改
                      $("#test1Dv").show();
                      $("#rectificationPersionDv").show();
                      $("#acceptancefilterRadio").show();
                      $("#acceptancePersionDv").show();
                      $("#filter1").attr("checked","checked");
                      if(needAcceptance==0){
                          //需要验收
                          $("#acceptancePersionDv").show();
                          $("#acceptanceDescDv").show();
                          $("#filter3").attr("checked","checked");
                      }else{
                          $("#acceptancePersionDv").hide();
                          $("#acceptanceDescDv").hide();
                          $("#filter4").attr("checked","checked");
                      }
                  }else{
                      $("#test1Dv").hide();
                      $("#rectificationPersionDv").hide();
                      $("#acceptancefilterRadio").hide();
                      $("#acceptancePersionDv").hide();
                      $("#filter2").attr("checked","checked");
                  }
                  layui.form.render();
              }
          })
    }

    function checkSubmit() {
        //质量检查提交
        if(checkFlag==1){
            alert("已提交,不能重复提交");
            return;
        }else{
            var rectificationPeriod=$("#test1").val();
            var securityDangerDesc=$("#securityDangerDesc").val();
            var rectificationPersion=$("#rectificationPersion").attr("user_id");
            var rectificationPersionName=$("#rectificationPersion").val();
            var acceptancePersion=$("#acceptancePersion").attr("user_id");
            var acceptancePersionName=$("#acceptancePersion").val();
            var needRecification=$("input[name='rectificationfilter']:checked").val();
            var needAcceptance=$("input[name='acceptancefilter']:checked").val();
            var checkTime=$("#checkTime").val();
            if(checkTime==""){
                var checkDate=new Date();
                var y=checkDate.getFullYear();
                var m=checkDate.getMonth();
                var d=checkDate.getDate();
                checkTime=y+"-"+m+"-"+d;
            }
            var attachmentId='';
            var attachmentName='';
            $("div[class=photo_box] img").each(function() {
                attachmentId+=$(this).attr("attachmentId");
                attachmentName+=$(this).attr("attachmentName");
            });
            if (needRecification==1){
                //是否整改选择否
                rectificationPeriod="";
                rectificationPersion="";
                rectificationPersionName="";
                acceptancePersion="";
                acceptancePersionName="";
                needAcceptance=1;
                $.ajax({
                    url:'/workflow/qualityManager/updateDetailsInfo?checkFlag=1&recificationStatus=0',
                    data:{rectificationPeriod:rectificationPeriod,securityDangerDesc:securityDangerDesc,rectificationPersion:rectificationPersion,rectificationPersionName:rectificationPersionName,acceptancePersion:acceptancePersion,acceptancePersionName:acceptancePersionName,securityContentId:securityContentId,needRecification:needRecification,needAcceptance:needAcceptance,checkTime:checkTime},
                    datatype:"json",
                    type:"post",
                    success:function(res){
                        window.history.go(-1);
                        // window.location.href="/workflow/qualityManager/securityCheckApp?projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"&seciritytype="+seciritytype+""
                    }
                })
            }else{
                //是否整改选择是
                if(needAcceptance==1){
                    //是否验收选择否
                    acceptancePersion="";
                    acceptancePersionName="";
                    if(rectificationPersion==""||rectificationPersion==undefined){
                        alert("请填写整改人");
                        return;
                    }else{
                        if(rectificationPersion.substring(rectificationPersion.length-1,rectificationPersion.length)==","){
                            rectificationPersion = rectificationPersion.substring(0,rectificationPersion.length-1);
                        }
                        if(rectificationPersionName.substring(rectificationPersionName.length-1,rectificationPersionName.length)==","){
                            rectificationPersionName = rectificationPersionName.substring(0,rectificationPersionName.length-1);
                        }
                        $.ajax({
                            url:'/workflow/qualityManager/updateDetailsInfo?checkFlag=1&recificationStatus=0',
                            data:{rectificationPeriod:rectificationPeriod,securityDangerDesc:securityDangerDesc,rectificationPersion:rectificationPersion,rectificationPersionName:rectificationPersionName,acceptancePersion:acceptancePersion,acceptancePersionName:acceptancePersionName,securityContentId:securityContentId,needRecification:needRecification,needAcceptance:needAcceptance,checkTime:checkTime},
                            datatype:"json",
                            type:"post",
                            success:function(res){
                                window.history.go(-1);
                                // window.location.href="/workflow/qualityManager/securityCheckApp?projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"&seciritytype="+seciritytype+""
                            }
                        })
                    }
                }else{
                    //是否验收选择是
                    if(rectificationPersion==""||rectificationPersion==undefined||acceptancePersion==""||acceptancePersion==undefined){
                        alert("请填写整改人和验收人");
                        return;
                    }else{
                        if(rectificationPersion.substring(rectificationPersion.length-1,rectificationPersion.length)==","){
                            rectificationPersion = rectificationPersion.substring(0,rectificationPersion.length-1);
                        }
                        if(acceptancePersion.substring(acceptancePersion.length-1,acceptancePersion.length)==","){
                            acceptancePersion = acceptancePersion.substring(0,acceptancePersion.length-1);
                        }
                        if(rectificationPersionName.substring(rectificationPersionName.length-1,rectificationPersionName.length)==","){
                            rectificationPersionName = rectificationPersionName.substring(0,rectificationPersionName.length-1);
                        }
                        if(acceptancePersionName.substring(acceptancePersionName.length-1,acceptancePersionName.length)==","){
                            acceptancePersionName = acceptancePersionName.substring(0,acceptancePersionName.length-1);
                        }
                        $.ajax({
                            url:'/workflow/qualityManager/updateDetailsInfo?checkFlag=1&recificationStatus=0',
                            data:{rectificationPeriod:rectificationPeriod,securityDangerDesc:securityDangerDesc,rectificationPersion:rectificationPersion,rectificationPersionName:rectificationPersionName,acceptancePersion:acceptancePersion,acceptancePersionName:acceptancePersionName,securityContentId:securityContentId,needRecification:needRecification,needAcceptance:needAcceptance,checkTime:checkTime},
                            datatype:"json",
                            type:"post",
                            success:function(res){
                                window.history.go(-1);
                                // window.location.href="/workflow/qualityManager/securityCheckApp?projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"&seciritytype="+seciritytype+""
                            }
                        })
                    }
                }
            }
        }
    }
  function rectificationPreservation(securityContentId) {
        //质量整改保存
      if(recificationFlag==1){
          alert("已保存");
          return;
      }else if(recificationFlag==2){
          var rectificationDesc=$("#rectificationDesc").val();
          var rectificationTime=$("#rectificationTime").val();
          if(rectificationTime==""){
              var rectificationDate=new Date();
              var y=rectificationDate.getFullYear();
              var m=rectificationDate.getMonth();
              var d=rectificationDate.getDate();
              rectificationTime=y+"-"+m+"-"+d;

          }
          var attachmentId='';
          var attachmentName='';
          $("div[class=photo_box] img").each(function() {
              attachmentId+=$(this).attr("attachmentId");
              attachmentName+=$(this).attr("attachmentName");
          });
          $.ajax({
              url:'/workflow/qualityManager/rectification?recificationFlag=1',
              data:{securityContentId:securityContentId,rectificationDesc:rectificationDesc,attachmentId:attachmentId,attachmentName:attachmentName,rectificationTime:rectificationTime},
              datatype:"json",
              type:"post",
              success:function(res){
                  window.history.go(-1);
                  //window.location.href="/workflow/qualityManager/securityCheckApp?projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"&seciritytype="+seciritytype+""
              }
          })
      }else{
          var rectificationDesc=$("#rectificationDesc").val();
          var rectificationTime=$("#rectificationTime").val();
          if(rectificationTime==""){
              var rectificationDate=new Date();
              var y=rectificationDate.getFullYear();
              var m=rectificationDate.getMonth();
              var d=rectificationDate.getDate();
              rectificationTime=y+"-"+m+"-"+d;
          }
          var attachmentId='';
          var attachmentName='';
          $("div[class=photo_box] img").each(function() {
              attachmentId+=$(this).attr("attachmentId");
              attachmentName+=$(this).attr("attachmentName");
          });
          $.ajax({
              url:'/workflow/qualityManager/rectification?recificationFlag=1',
              data:{securityContentId:securityContentId,rectificationDesc:rectificationDesc,attachmentId:attachmentId,attachmentName:attachmentName,rectificationTime:rectificationTime},
              datatype:"json",
              type:"post",
              success:function(res){
                  window.history.go(-1);
                  //window.location.href="/workflow/qualityManager/securityCheckApp?projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"&seciritytype="+seciritytype+""
              }
          })
      }
  }
  function rectificationSubmit() {
        //质量整改保存并提交
      if(recificationFlag==1){
          alert("已提交，不能重复提交");
          return;
      }else if(recificationFlag==2){
          var rectificationDesc=$("#rectificationDesc").val();
          var rectificationTime=$("#rectificationTime").val();
          if(rectificationTime==""){
              var rectificationDate=new Date();
              var y=rectificationDate.getFullYear();
              var m=rectificationDate.getMonth();
              var d=rectificationDate.getDate();
              rectificationTime=y+"-"+m+"-"+d;
          }
          var attachmentId='';
          var attachmentName='';
          $("div[class=photo_box] img").each(function() {
              attachmentId+=$(this).attr("attachmentId");
              attachmentName+=$(this).attr("attachmentName");
          });
          $.ajax({
              url:'/workflow/qualityManager/commitAcceptance?type=rectification&acceptance=true&recificationFlag=1',
              data:{securityContentId:securityContentId,checkliId:checkliId,rectificationDesc:rectificationDesc,attachmentId:attachmentId,attachmentName:attachmentName,rectificationTime:rectificationTime},
              datatype:'json',
              success:function(res){
                  window.history.go(-1);
                  //window.location.href="/workflow/qualityManager/securityCheckApp?projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"&seciritytype="+seciritytype+""

              }
          })
      }else{
          var rectificationDesc=$("#rectificationDesc").val();
          var rectificationTime=$("#rectificationTime").val();
          if(rectificationTime==""){
              var rectificationDate=new Date();
              var y=rectificationDate.getFullYear();
              var m=rectificationDate.getMonth();
              var d=rectificationDate.getDate();
              rectificationTime=y+"-"+m+"-"+d;
          }
          var attachmentId='';
          var attachmentName='';
          $("div[class=photo_box] img").each(function() {
              attachmentId+=$(this).attr("attachmentId");
              attachmentName+=$(this).attr("attachmentName");
          });
          $.ajax({
              url:'/workflow/qualityManager/commitAcceptance?type=rectification&acceptance=true&recificationFlag=1',
              data:{securityContentId:securityContentId,checkliId:checkliId,rectificationDesc:rectificationDesc,attachmentId:attachmentId,attachmentName:attachmentName,rectificationTime:rectificationTime},
              datatype:'json',
              success:function(res){
                  window.history.go(-1);
                  //window.location.href="/workflow/qualityManager/securityCheckApp?projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"&seciritytype="+seciritytype+""

              }
          })
      }
}
  function acceptanceAgree() {
      //质量验收保存并同意
      if(acceptanceFlag==1){
          alert("已同意");
          return;
      }else{
          var acceptanceDesc=$("#acceptanceDesc").val();
          var acceptanceTime=$("#acceptanceTime").val();
          if(acceptanceTime==""){
              var acceptanceDate=new Date();
              var y=acceptanceDate.getFullYear();
              var m=acceptanceDate.getMonth();
              var d=acceptanceDate.getDate();
              acceptanceTime=y+"-"+m+"-"+d;
          }
          var attachmentId='';
          var attachmentName='';
          $("div[class=photo_box] img").each(function() {
              attachmentId+=$(this).attr("attachmentId");
              attachmentName+=$(this).attr("attachmentName");
          });
          $.ajax({
              url:'/workflow/qualityManager/commitAcceptance?type=accptance&flag=true&acceptance=true&acceptanceFlag=1',
              data:{ids:ids,rectificationId:rectificationId,acceptanceDesc:acceptanceDesc,attachmentId:attachmentId,attachmentName:attachmentName,acceptanceTime:acceptanceTime},
              datatype:"json",
              success:function(res){
                  window.history.go(-1);
              }
          })
      }
}
   function acceptanceBack() {
    //质量验收保存并退回
       if(acceptanceFlag==2){
           alert("已退回");
           return;
       }else{
           var acceptanceDesc=$("#acceptanceDesc").val();
           var acceptanceTime=$("#acceptanceTime").val();
           if(acceptanceTime==""){
               var acceptanceDate=new Date();
               var y=acceptanceDate.getFullYear();
               var m=acceptanceDate.getMonth();
               var d=acceptanceDate.getDate();
               acceptanceTime=y+"-"+m+"-"+d;
           }
           var attachmentId='';
           var attachmentName='';
           $("div[class=photo_box] img").each(function() {
               attachmentId+=$(this).attr("attachmentId");
               attachmentName+=$(this).attr("attachmentName");
           });
           $.ajax({
               url:'/workflow/qualityManager/commitAcceptance?type=accptance&flag=false&acceptance=true&acceptanceFlag=2',
               data:{ids:ids,rectificationId:rectificationId,acceptanceDesc:acceptanceDesc,attachmentId:attachmentId,attachmentName:attachmentName,acceptanceTime:acceptanceTime},
               datatype:"json",
               success:function(res){
                   window.history.go(-1);
               }
           })
       }
}
    function acceptancePreservation() {
         //质量验收保存
        if(acceptanceFlag==1){
            alert("已保存");
            return;
        }else{
            var acceptanceDesc=$("#acceptanceDesc").val();
            var acceptanceTime=$("#acceptanceTime").val();
            if(acceptanceTime==""){
                var acceptanceDate=new Date();
                var y=acceptanceDate.getFullYear();
                var m=acceptanceDate.getMonth();
                var d=acceptanceDate.getDate();
                acceptanceTime=y+"-"+m+"-"+d;
            }
            var attachmentId='';
            var attachmentName='';
            $("div[class=photo_box] img").each(function() {
                attachmentId+=$(this).attr("attachmentId");
                attachmentName+=$(this).attr("attachmentName");
            });
            $.ajax({
                url:'/workflow/qualityManager/acceptance?acceptanceFlag=1',
                data:{rectificationId:rectificationId,acceptanceDesc:acceptanceDesc,attachmentId:attachmentId,attachmentName:attachmentName,acceptanceTime:acceptanceTime},
                datatype:"json",
                success:function(res){
                    window.history.go(-1);
                }
            })
        }
    }
    function pageBack() {
        window.history.go(-1);
    }

    function getParamByUrl(url,name) {
        //构造一个含有目标参数的正则表达式对象
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        //匹配目标参数
        var r = url.match(reg);
        //返回参数值
        if (r != null) return unescape(r[2]); return null;
    }

    $("#upload").click(function btn1(e){
        if($.getQueryString("type") == 'EWC'){
            // console.log('uploadimgform');
            // alert('企业微信移动端工作流公共附件功能正在开发中！');
            $("#uploadinputimg").attr('uploadType','1');
            $('#uploadimgform').attr('action','workUpload?module=workflow&flowPrcs='+$.getQueryString("flowStep")+'&runId='+$.getQueryString("runId"));
            $("#uploadinputimg").trigger("click");
        }else{
            $('.choosewj').attr('src','/img/workflow/work/choose_imgclick.png')
            btn('imgadd1',1)
        }

    })
    function btn(cb,num){
        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {

            try{
                var filesize = 1
                window.webkit.messageHandlers.addImage.postMessage({'function':cb,'num':num});
            }catch(err){
                //var filesize = 1
                addImage(cb,num,filesize);
            }

        } else if (/(Android)/i.test(navigator.userAgent)) {
            //alert(navigator.userAgent);
            //alert(navigator.userAgent);
            //var filesize = 1
            //Android.addImage(cb,num,filesize);
            Android.addImage(cb,num);
        }
        // $('.choosewj').attr('src','/img/workflow/work/choose_img.png')
    }
    function getCookie (key) {
        var arr=document.cookie.split('; '); //多个cookie之间是用;+空格连接的
        for (var i = 0; i < arr.length; i++) {
            var arr2=arr[i].arr.split('=');
            if(arr2[0]==key){
                return arr2[1];
            }
        }
        return false;//如果函数没有返回值，得到的结果是undefined
    }
    /************调用移动端原始表单查看的方法************************/
    function formInfo() {
        if($.getQueryString("type") == 'EWC'){
            window.location.href = '/workflow/work/workformPreView?flowId=' + globalData.flowId + '&flowStep=&prcsId=&runId=' + globalData.flowRun.runId + '&formInfo=formInfo';
        }else{
            if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                try{
                    window.webkit.messageHandlers.formInfoUrlLink.postMessage({'url':'/workflow/work/workformPreView?flowId=' + globalData.flowId + '&flowStep=&prcsId=&runId=' + globalData.flowRun.runId + '&formInfo=formInfo','name':'原始表单'});
                }
                catch(err) {
                    formInfoUrlLink('/workflow/work/workformPreView?flowId=' + globalData.flowId + '&flowStep=&prcsId=&runId=' + globalData.flowRun.runId + '&formInfo=formInfo','原始表单');
                }
            } else if (/(Android)/i.test(navigator.userAgent)) {
                Android.formInfoUrlLink('/workflow/work/workformPreView?flowId=' + globalData.flowId + '&flowStep=&prcsId=&runId=' + globalData.flowRun.runId + '&formInfo=formInfo','原始表单');
            }
        }

    };
    var index=0;
    function imgadd1(img,name,type){
        var arr = img.split(',');
        var name_arr = name.split(',');
        if(type == 1){
            var img = '';
            for(var i=0;i<arr.length -1;i++){
                index+=1;
                var url =  arr[i];
                var deUrl = url.split("?")[1];
                var fileId="\'blah"+index+"\'";
                var attachmentId=getParamByUrl("&"+deUrl,"ATTACHMENT_ID");
                var ym=getParamByUrl("&"+deUrl,"YM");
                var aid=getParamByUrl("&"+deUrl,"AID");
                var attachmentName=getParamByUrl(arr[i],"ATTACHMENT_NAME");
                var attachId = aid+"@"+ym+"_"+attachmentId+",";//拼接attachmentId
                img += '<div id="blah'+index+'"  style="position: relative"><img delUrl='+deUrl+' attachmentName='+attachmentName+"*"+' attachmentId='+attachId+' id="blah"  src="'+ arr[i] +'" onclick="anios($(this))" style="width:70px;height:100px;margin-right: 10px;margin-bottom: 10px;" url="'+url +'" name="'+ name_arr[i] +'"><span class="layui-icon layui-icon-close-fill" style="color: #dc143c;position: absolute;left: 59px;top: -4px;" onClick="delFile('+fileId+')"></span></div>';
            }
            $('.photo_box').append(img);
            //return true;
        }else{
            var name_str = '';
            for(var i=0;i<name_arr.length -1;i++){
                var url = arr[i];
                if($.getQueryString("type") == 'EWC'){
                    name_str += '<p><a style="display: none" href="'+url+'">'+ name_arr[i] +'</a></p>'
                }else {
                    name_str += '<p onclick="anios($(this))" url="'+url+'"  name="'+ name_arr[i] +'">'+ name_arr[i] +'</p>'
                }
            }
            alert(name_str)
            // $('.uploadbox').css('min-height', '50px')
            $('.uploadbox').append(name_str);
            //return true;
        }
    }
    function anios(e){
        var url = e.attr('url');
        var name = e.attr('name');
        //
        // var name = e.next().text();
        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
            if($.getQueryString("type") == 'EWC'){
                window.open(url)
            }else{
                try{
                    window.webkit.messageHandlers.overLookFile.postMessage({'url':url,'name':name});
                }catch(error){
                    overLookFile(url,name);
                }
            }
        } else if (/(Android)/i.test(navigator.userAgent)) {
            if($.getQueryString("type") == 'EWC'){
                window.open(url)
            }else{
                Android.overLookFile(url,name);
            }
        } else {
            window.open(url);
        }
    }
    function anios1(e){
        if(e.attr('url').indexOf('http:') >-1){
            var url = e.attr('url');
        }else{
            if (window["context"] == undefined) {
                if (!window.location.origin) {
                    window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port: '');
                }
                window["context"] = location.origin;
            }
            var domain = document.location.origin;
            var url = domain+e.attr('url');
        }
        if(e.hasClass('fileupload_data')){
            var url = domain+'/download?'+e.attr('url');
        }
        var name = e.attr('names');
        // var name = e.next().text();
        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
            try{
                window.webkit.messageHandlers.overLookFile.postMessage({'url':url,'name':name});
            }catch(error){
                overLookFile(url,name);
            }
        } else if (/(Android)/i.test(navigator.userAgent)) {
            Android.overLookFile(url,name);
        }
    }
    /**********************结束*****************************/
    /**********************与移动端交互 页面加载后 将附件的图片添加 初始化页面附件查看方式*****************************/``
    function auto() {
        var width = $('#word').width() / 2;
        $('#word .table td').css('width', '' + width + '');
        var width1 = width - 62;
        $('#word .action').css('width', '' + width1 + '');
    }
    function dateclick(e) {
        laydate({
            elem: '#' + $(e).attr('target'),
            format: 'YYYY-MM-DD hh:mm:ss'
        });
    }

    function delFile(fileId){
        var delUrl="";
        $("div[id="+fileId+"] img").each(function() {
            delUrl= $(this).attr("delUrl");
        })

        //删除列表
        layui.layer.confirm('确定要删除吗', {
            btn: ['确定', '取消'], //按钮
            title: " 删除",
            offset: '120px'
        },function(index){
            $.ajax({
                url:"/delete?"+delUrl,
                dataType:"json",
                type:"get",
                success:function(res){
                    layui.layer.close(index)
                    if(res.flag){
                        $("#"+fileId).remove();
                    }
                    layui.layer.msg(res.msg)
                }
            })
        }, function () {
            layui.layer.closeAll();

        })
    }

</script>
</body>
</html>
