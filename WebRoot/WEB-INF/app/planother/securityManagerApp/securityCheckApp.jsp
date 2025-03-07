<%--
  Created by IntelliJ IDEA.
  User: dongke
  Date: 2021/3/25
  Time: 16:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>检查项模式App</title>
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
    <script src="/lib/layui/layui/lay/mymodules/eleTree.js"></script>
</head>
<style>
    .layui-tab-title li{
        min-width: 25%;
    }
    body .demo-class .layui-layer-btn0{
        position: relative;
        top: 70px;
    }
    body .demo-class .layui-layer-btn1{
        position: relative;
        top: 70px;
    }
</style>
<body>
<div style="margin-top: 20px;position: relative;">
    <img src="../../img/log2.png" style="position: absolute;left: 21px;top: 2px;width: 25px; ">
    <span id="text" style="margin-left: 49px;font-size: 20px;"></span>
    <span   id="fillingDate" style="position: absolute;right: 72px;top: 10px"></span>
    <span id="water" style="position: absolute;right: 47px;top: 8px"></span>
    <div style="    position: absolute;right: 15px;top: 8px;">
        <img src="../../img/workLog/screen.jpg" width="20px" height="22px" onclick="checkScreen()" style="cursor: pointer">
    </div>
</div>
<hr class="layui-bg-blue" style="height: 5px">

<div class="layui-tab">
    <ul class="layui-tab-title">
        <li class="layui-this">检查项模式</li>
        <li>清单模式</li>
        <li>图纸模式</li>
    </ul>
    <div class="layui-tab-content">
        <div class="layui-tab-item layui-show" >
            <div class="layui-collapse" lay-filter="test" id="content1">
            </div>
        </div>
        <div class="layui-tab-item">
            <div  style="width: 100%;height: 75%">
                <ul style="list-style: none" id="ul1">

                </ul>
            </div>
        </div>
        <div class="layui-tab-item">待开发</div>
    </div>
</div>

<script>
  layui.use(['laydate','element'],function(){
      var laydate=layui.laydate;
      var element=layui.element;
      var $=layui.jquery;


      $('.site-demo-active').on('click', function(){
          var othis = $(this), type = othis.data('type');
          active[type] ? active[type].call(this, othis) : '';
      });

      //Hash地址的定位
      var layid = location.hash.replace(/^#test=/, '');
      element.tabChange('test', layid);

      element.on('tab(test)', function(elem){
          location.hash = 'test='+ $(this).attr('lay-id');
      });



      laydate.render({
          elem: '#fillingDate',// input里时间的Id
          value: new Date(),
          trigger:'',
          done: function (value, date) {
          }
      });
      $.get('/sys/getInterfaceInfo', function (json){
          if (json.flag) {
              if(json.object.weatherCity!=1){
                  window.onload = loadScript;
              }
          }
      }, 'json')
      function loadScript() {
          var script = document.createElement("script");
          script.src = "http://api.map.baidu.com/api?v=2.0&ak=7HSdUGqKaz5U0ph0LIQ2Qd4rFmFZA2kY&callback=getweatherBefore";//此为v2.0版本的引用方式,加载完成后执行getweatherBefore事件
          document.body.appendChild(script);
      }
  })
  function getUrlParam(name) {
      //构造一个含有目标参数的正则表达式对象
      var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
      //匹配目标参数
      var r = window.location.search.substr(1).match(reg);
      //返回参数值
      if (r != null) return unescape(r[2]); return null;
  }
   var projectId=getUrlParam("projectId");
   var testTypeNo=getUrlParam("testTypeNo");
   var datatype=getUrlParam("datatype");
   var seciritytype=getUrlParam("seciritytype");
   judge(seciritytype,datatype)
  function judge(seciritytype,datatype) {
       switch (seciritytype) {
           case "0":
               $("#text").text("安全检查");
               switch (datatype) {
                   case "0":
                       initSecurity();
                       break
                   case "1":
                       initSecurityTestTypeNo(testTypeNo);
                       break;
                   case "2":
                       initSecurityProjectId(projectId);
                       break;
               }
               break;
           case "1":
               $("#text").text("安全整改");
               switch (datatype) {
                   case "0":
                       initRectification();
                       break
                   case "1":
                       initRectificationTestTypeNo(testTypeNo);
                       break;
                   case "2":
                       initRectificationProjectId(projectId);
                       break;
               }
               break;
           case "2":
               $("#text").text("安全验收");
               switch (datatype) {
                   case "0":
                       initAcceptance();
                       break
                   case "1":
                       initAcceptanceTestTypeNo(testTypeNo);
                       break;
                   case "2":
                       initAcceptanceProjectId(projectId);
                       break;
               }
               break;
       }
  }

  function initSecurity(projectId,testTypeNo) {
     $.ajax({
         url:"/workflow/secirityManager/selectDetailInfoGroupByType",
         data:{projectId:projectId,testTypeNo:testTypeNo},
         dataType:"json",
         type:"post",
         success:function(res){
             var htm='';
             var htmli='';
             var htmlist='';
             var photolist='';
             for (var i=0;i<res.data.length;i++){
                 for(var j=0;j<res.data[i].knowledgeValue.length;j++){
                     htmli+="<li style='list-style: decimal; list-style: decimal;border-bottom: 1px solid #C0C0C0;font-size: 15px;margin: 15px auto;position: relative;left: 14px;'>" +
                         "<a href='/workflow/secirityManager/securityManagerContent?securityContentId="+res.data[i].knowledgeValue[j].securityContentId+"&seciritytype="+seciritytype+"&projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"'>"+res.data[i].knowledgeValue[j].securityDanger+"</a>"+
                     "</li>";
                     if(res.data[i].knowledgeValue[j].attachmentList.length>4){
                         for(var h=0;h<4;h++){
                             photolist+="<li style=' display: inline-block;'><img src='/xs?"+res.data[i].knowledgeValue[j].attachmentList[h].attUrl+"' width='60px' height='60px' style='margin-left: 10px;margin-top: 4px'></li>"
                         }
                     }else{
                         for(var h=0;h<res.data[i].knowledgeValue[j].attachmentList.length;h++){
                             photolist+="<li style=' display: inline-block;'><img src='/xs?"+res.data[i].knowledgeValue[j].attachmentList[h].attUrl+"' width='60px' height='60px' style='margin-left: 10px;margin-top: 4px'></li>"
                         }
                     }
                     var checkFlag =res.data[i].knowledgeValue[j].checkFlag;
                     var text;
                     if (checkFlag==0||checkFlag==null||checkFlag==undefined){
                         text="未检查";
                     }else{
                         text="已检查";
                     }
                     htmlist+="<li>" +
                         "<div style=' width:100%;height: 150px;border-top: 1px solid #C0C0C0;border-left: 1px solid #C0C0C0;border-right: 1px solid #C0C0C0;'>" +
                         "<a href='/workflow/secirityManager/securityManagerContent?securityContentId="+res.data[i].knowledgeValue[j].securityContentId+"&seciritytype="+seciritytype+"&projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"' style='font-size: 17px'>"+res.data[i].knowledgeValue[j].securityDanger+"("+text+")</a>"+
                         "<ul>"+photolist+"</ul>"+
                         "</div>"+
                         "</li>";
                     photolist="";
                 }
                 htm+="<div class=\"layui-colla-item\">\n" +
                     " <h2 class=\"layui-colla-title\">"+res.data[i].knowledgeName+"" +
                     "<i class=\"layui-icon layui-colla-icon\"></i></h2>" +
                     "<div class=\"layui-colla-content\" >" +
                     "<ol>" +
                     ""+htmli+"" +
                     "</ol>" +
                     "</div>" +
                     "</div>"
                 htmli="";

             }
             $("#content1").html(htm);
             $("#ul1").html(htmlist);
             layui.element.init();//初始化
         }
     })
  }
  function initSecurityTestTypeNo(testTypeNo) {
      $.ajax({
          url:"/workflow/secirityManager/selectDetailInfoGroupByType",
          data:{testTypeNo:testTypeNo},
          dataType:"json",
          type:"post",
          success:function(res){
              var htm='';
              var htmli='';
              var htmlist='';
              var photolist='';
              for (var i=0;i<res.data.length;i++){
                  for(var j=0;j<res.data[i].knowledgeValue.length;j++){
                      htmli+="<li style='list-style: decimal; list-style: decimal;border-bottom: 1px solid #C0C0C0;font-size: 15px;margin: 15px auto;position: relative;left: 14px;'>" +
                          "<a href='/workflow/secirityManager/securityManagerContent?securityContentId="+res.data[i].knowledgeValue[j].securityContentId+"&seciritytype="+seciritytype+"&projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"'>"+res.data[i].knowledgeValue[j].securityDanger+"</a>"+
                          "</li>";
                      if(res.data[i].knowledgeValue[j].attachmentList.length>4){
                          for(var h=0;h<4;h++){
                              photolist+="<li style=' display: inline-block;'><img src='/xs?"+res.data[i].knowledgeValue[j].attachmentList[h].attUrl+"' width='60px' height='60px' style='margin-left: 10px;margin-top: 4px'></li>"
                          }
                      }else{
                          for(var h=0;h<res.data[i].knowledgeValue[j].attachmentList.length;h++){
                              photolist+="<li style=' display: inline-block;'><img src='/xs?"+res.data[i].knowledgeValue[j].attachmentList[h].attUrl+"' width='60px' height='60px' style='margin-left: 10px;margin-top: 4px'></li>"
                          }
                      }
                      var checkFlag =res.data[i].knowledgeValue[j].checkFlag;
                      var text;
                      if(res.data[i].knowledgeValue[j].recificationStatus==undefined){
                          if(checkFlag==="1"){
                              text="已检查未提交";
                          }else{
                              text="未检查"
                          }
                      }else{
                          if(checkFlag==="1"){
                              text="已检查";
                          }
                      }
                      // if (res.data[i].knowledgeVlaue[j].recificationStatus==undefined&&checkFlag==="0" ){
                      //     text="未检查";
                      // }else if(res.data[i].knowledgeVlaue[j].recificationStatus==undefined&&checkFlag==="1"){
                      //     text="已检查未提交";
                      // }else if(res.data[i].knowledgeVlaue[j].recificationStatus!=undefined&&checkFlag==="1"){
                      //     text="已检查";
                      // }
                      htmlist+="<li>" +
                          "<div style='width: 100%;height: 150px;border-top: 1px solid #C0C0C0;border-left: 1px solid #C0C0C0;border-right: 1px solid #C0C0C0;'>" +
                          "<a href='/workflow/secirityManager/securityManagerContent?securityContentId="+res.data[i].knowledgeValue[j].securityContentId+"&seciritytype="+seciritytype+"&projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"' style='font-size: 17px'>"+res.data[i].knowledgeValue[j].securityDanger+"("+text+")</a>"+
                          "<ul>"+photolist+"</ul>"+
                          "</div>"+
                          "</li>";
                      photolist="";
                  }
                  htm+="<div class=\"layui-colla-item\">\n" +
                      " <h2 class=\"layui-colla-title\">"+res.data[i].knowledgeName+"" +
                      "<i class=\"layui-icon layui-colla-icon\"></i></h2>" +
                      "<div class=\"layui-colla-content\" >" +
                      "<ol>" +
                      ""+htmli+"" +
                      "</ol>" +
                      "</div>" +
                      "</div>"
                  htmli=""
              }
              var text=res.obj;
              $("#text").after("("+text+")");
              $("#content1").html(htm);
              $("#ul1").html(htmlist);
              layui.element.init();//初始化
          }
      })
  }
  function initSecurityProjectId(projectId) {
      $.ajax({
          url:"/workflow/secirityManager/selectDetailInfoGroupByType",
          data:{projectId:projectId},
          dataType:"json",
          type:"post",
          success:function(res){
              var htm='';
              var htmli='';
              var htmlist='';
              var photolist='';
              for (var i=0;i<res.data.length;i++){
                  for(var j=0;j<res.data[i].knowledgeValue.length;j++){
                      htmli+="<li style='list-style: decimal; list-style: decimal;border-bottom: 1px solid #C0C0C0;font-size: 15px;margin: 15px auto;position: relative;left: 14px;'>" +
                          "<a href='/workflow/secirityManager/securityManagerContent?securityContentId="+res.data[i].knowledgeValue[j].securityContentId+"&seciritytype="+seciritytype+"&projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"'>"+res.data[i].knowledgeValue[j].securityDanger+"</a>"+
                          "</li>";
                      if(res.data[i].knowledgeValue[j].attachmentList.length>4){
                          for(var h=0;h<4;h++){
                              photolist+="<li style=' display: inline-block;'><img src='/xs?"+res.data[i].knowledgeValue[j].attachmentList[h].attUrl+"' width='60px' height='60px' style='margin-left: 10px;margin-top: 4px'></li>"
                          }
                      }else{
                          for(var h=0;h<res.data[i].knowledgeValue[j].attachmentList.length;h++){
                              photolist+="<li style=' display: inline-block;'><img src='/xs?"+res.data[i].knowledgeValue[j].attachmentList[h].attUrl+"' width='60px' height='60px' style='margin-left: 10px;margin-top: 4px'></li>"
                          }
                      }
                      var checkFlag =res.data[i].knowledgeValue[j].checkFlag;
                      var text;
                      if (res.data[i].knowledgeValue[j].recificationStatus==undefined&&checkFlag==0 ){
                          text="未检查";
                      }else if(res.data[i].knowledgeValue[j].recificationStatus==undefined&&checkFlag==1){
                          text="已检查未提交";
                      }else if(res.data[i].knowledgeValue[j].recificationStatus!=undefined&&checkFlag==1){
                          text="已检查";
                      }
                      htmlist+="<li>" +
                          "<div style='width: 100%;height: 150px;border-top: 1px solid #C0C0C0;border-left: 1px solid #C0C0C0;border-right: 1px solid #C0C0C0;'>" +
                          "<a href='/workflow/secirityManager/securityManagerContent?securityContentId="+res.data[i].knowledgeValue[j].securityContentId+"&seciritytype="+seciritytype+"&projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"' style='font-size: 17px'>"+res.data[i].knowledgeValue[j].securityDanger+"("+text+")</a>"+
                          "<ul>"+photolist+"</ul>"+
                          "</div>"+
                          "</li>";
                      photolist="";
                  }
                  htm+="<div class=\"layui-colla-item\">\n" +
                      " <h2 class=\"layui-colla-title\">"+res.data[i].knowledgeName+"" +
                      "<i class=\"layui-icon layui-colla-icon\"></i></h2>" +
                      "<div class=\"layui-colla-content\" >" +
                      "<ol>" +
                      ""+htmli+"" +
                      "</ol>" +
                      "</div>" +
                      "</div>"
                  htmli=""
              }
              $("#text").after("("+text+")");
              $("#content1").html(htm);
              $("#ul1").html(htmlist);
              layui.element.init();//初始化
          }
      })
  }
  function initRectification(projectId,testTypeNo) {
        $.ajax({
            url:'/workflow/secirityManager/getRecificaOrAcceptanceGroupByType?isRecification=true&recificationStatus=0,1,2,3',
            data:{projectId:projectId,testTypeNo:testTypeNo},
            datatype:"json",
            success:function(res){
                var htm='';
                var htmli='';
                var htmlist='';
                var photolist='';
                for (var i=0;i<res.data.length;i++){
                    for(var j=0;j<res.data[i].knowledgeValue.length;j++){
                        htmli+="<li style='list-style: decimal; list-style: decimal;border-bottom: 1px solid #C0C0C0;font-size: 15px;margin: 15px auto;position: relative;left: 14px;'>" +
                            "<a href='/workflow/secirityManager/securityManagerContent?securityContentId="+res.data[i].knowledgeValue[j].securityContentId+"&seciritytype="+seciritytype+"&projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"'>"+res.data[i].knowledgeValue[j].securityDanger+"</a>"+
                            "</li>";
                        if(res.data[i].knowledgeValue[j].attachmentList.length>4){
                            for(var h=0;h<4;h++){
                                photolist+="<li style=' display: inline-block;'><img src='/xs?"+res.data[i].knowledgeValue[j].attachmentList[h].attUrl+"' width='60px' height='60px' style='margin-left: 10px;margin-top: 4px'></li>"
                            }
                        }else{
                            for(var h=0;h<res.data[i].knowledgeValue[j].attachmentList.length;h++){
                                photolist+="<li style=' display: inline-block;'><img src='/xs?"+res.data[i].knowledgeValue[j].attachmentList[h].attUrl+"' width='60px' height='60px' style='margin-left: 10px;margin-top: 4px'></li>"
                            }
                        }
                        var recificationFlag =res.data[i].knowledgeValue[j].recificationFlag;
                        var rectificationStatus=res.data[i].knowledgeValue[j].recificationStatus;

                        var text;
                        if(rectificationStatus==0&&recificationFlag==0){
                            text="未整改";
                        }else if(rectificationStatus==0&&recificationFlag==1){
                            text="已整改未提交"
                        }else if(rectificationStatus==1&&recificationFlag==1){
                            text="已整改"
                        }else if(rectificationStatus==2&&recificationFlag==1){
                            text="已退回重新整改"
                        }

                        htmlist+="<li>" +
                            "<div style=' width:100%;height: 150px;border-top: 1px solid #C0C0C0;border-left: 1px solid #C0C0C0;border-right: 1px solid #C0C0C0;'>" +
                            "<a href='/workflow/secirityManager/securityManagerContent?securityContentId="+res.data[i].knowledgeValue[j].securityContentId+"&seciritytype="+seciritytype+"&projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"' style='font-size: 17px'>"+res.data[i].knowledgeValue[j].securityDanger+"("+text+")</a>"+
                            "<ul>"+photolist+"</ul>"+
                            "</div>"+
                            "</li>";
                        photolist="";
                    }
                    htm+="<div class=\"layui-colla-item\">\n" +
                        " <h2 class=\"layui-colla-title\">"+res.data[i].knowledgeName+"" +
                        "<i class=\"layui-icon layui-colla-icon\"></i></h2>" +
                        "<div class=\"layui-colla-content\" >" +
                        "<ol>" +
                        ""+htmli+"" +
                        "</ol>" +
                        "</div>" +
                        "</div>"
                    htmli="";

                }
                $("#content1").html(htm);
                $("#ul1").html(htmlist);
                layui.element.init();//初始化
            }
        })
  }
  function initRectificationTestTypeNo(testTypeNo) {
         $.ajax({
             url:'/workflow/secirityManager/getRecificaOrAcceptanceGroupByType?isRecification=true&recificationStatus=0,1,2,3',
             data:{testTypeNo:testTypeNo},
             datatype:"json",
             success:function(res){
                 var htm='';
                 var htmli='';
                 var htmlist='';
                 var photolist='';
                 for (var i=0;i<res.data.length;i++){
                     for(var j=0;j<res.data[i].knowledgeValue.length;j++){
                         htmli+="<li style='list-style: decimal; list-style: decimal;border-bottom: 1px solid #C0C0C0;font-size: 15px;margin: 15px auto;position: relative;left: 14px;'>" +
                             "<a href='/workflow/secirityManager/securityManagerContent?securityContentId="+res.data[i].knowledgeValue[j].securityContentId+"&seciritytype="+seciritytype+"&projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"'>"+res.data[i].knowledgeValue[j].securityDanger+"</a>"+
                             "</li>";
                         if(res.data[i].knowledgeValue[j].attachmentList.length>4){
                             for(var h=0;h<4;h++){
                                 photolist+="<li style=' display: inline-block;'><img src='/xs?"+res.data[i].knowledgeValue[j].attachmentList[h].attUrl+"' width='60px' height='60px' style='margin-left: 10px;margin-top: 4px'></li>"
                             }
                         }else{
                             for(var h=0;h<res.data[i].knowledgeValue[j].attachmentList.length;h++){
                                 photolist+="<li style=' display: inline-block;'><img src='/xs?"+res.data[i].knowledgeValue[j].attachmentList[h].attUrl+"' width='60px' height='60px' style='margin-left: 10px;margin-top: 4px'></li>"
                             }
                         }
                         var recificationFlag =res.data[i].knowledgeValue[j].recificationFlag;
                         var rectificationStatus=res.data[i].knowledgeValue[j].recificationStatus;
                         var text;
                         if(rectificationStatus==0&&recificationFlag==0){
                             text="未整改";
                         }else if(rectificationStatus==0&&recificationFlag==1){
                             text="已整改未提交"
                         }else if(rectificationStatus==1&&recificationFlag==1){
                             text="已整改"
                         }else if(rectificationStatus==2&&recificationFlag==1){
                             text="已退回重新整改"
                         }

                         htmlist+="<li>" +
                             "<div style='width: 100%;height: 150px;border-top: 1px solid #C0C0C0;border-left: 1px solid #C0C0C0;border-right: 1px solid #C0C0C0;'>" +
                             "<a href='/workflow/secirityManager/securityManagerContent?securityContentId="+res.data[i].knowledgeValue[j].securityContentId+"&seciritytype="+seciritytype+"&projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"' style='font-size: 17px'>"+res.data[i].knowledgeValue[j].securityDanger+"("+text+")</a>"+
                             "<ul>"+photolist+"</ul>"+
                             "</div>"+
                             "</li>";
                         photolist="";
                     }
                     htm+="<div class=\"layui-colla-item\">\n" +
                         " <h2 class=\"layui-colla-title\">"+res.data[i].knowledgeName+"" +
                         "<i class=\"layui-icon layui-colla-icon\"></i></h2>" +
                         "<div class=\"layui-colla-content\" >" +
                         "<ol>" +
                         ""+htmli+"" +
                         "</ol>" +
                         "</div>" +
                         "</div>"
                     htmli=""
                 }
                 var text=res.obj;
                 $("#text").after("("+text+")");
                 $("#content1").html(htm);
                 $("#ul1").html(htmlist);
                 layui.element.init();//初始化
             }
         })
  }
  function initRectificationProjectId(projectId) {
           $.ajax({
               url:'/workflow/secirityManager/getRecificaOrAcceptanceGroupByType?isRecification=true&recificationStatus=0,1,2,3',
               data:{projectId,projectId},
               datatype:"json",
               success:function(res){
                   var htm='';
                   var htmli='';
                   var htmlist='';
                   var photolist='';
                   for (var i=0;i<res.data.length;i++){
                       for(var j=0;j<res.data[i].knowledgeValue.length;j++){
                           htmli+="<li style='list-style: decimal; list-style: decimal;border-bottom: 1px solid #C0C0C0;font-size: 15px;margin: 15px auto;position: relative;left: 14px;'>" +
                               "<a href='/workflow/secirityManager/securityManagerContent?securityContentId="+res.data[i].knowledgeValue[j].securityContentId+"&seciritytype="+seciritytype+"&projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"'>"+res.data[i].knowledgeValue[j].securityDanger+"</a>"+
                               "</li>";
                           if(res.data[i].knowledgeValue[j].attachmentList.length>4){
                               for(var h=0;h<4;h++){
                                   photolist+="<li style=' display: inline-block;'><img src='/xs?"+res.data[i].knowledgeValue[j].attachmentList[h].attUrl+"' width='60px' height='60px' style='margin-left: 10px;margin-top: 4px'></li>"
                               }
                           }else{
                               for(var h=0;h<res.data[i].knowledgeValue[j].attachmentList.length;h++){
                                   photolist+="<li style=' display: inline-block;'><img src='/xs?"+res.data[i].knowledgeValue[j].attachmentList[h].attUrl+"' width='60px' height='60px' style='margin-left: 10px;margin-top: 4px'></li>"
                               }
                           }
                           var recificationFlag =res.data[i].knowledgeValue[j].recificationFlag;
                           var rectificationStatus=res.data[i].knowledgeValue[j].recificationStatus;
                           var text;
                           if(rectificationStatus==0&&recificationFlag==0){
                               text="未整改";
                           }else if(rectificationStatus==0&&recificationFlag==1){
                               text="已整改未提交"
                           }else if(rectificationStatus==1&&recificationFlag==1){
                               text="已整改"
                           }else if(rectificationStatus==2&&recificationFlag==1){
                               text="已退回重新整改"
                           }

                           htmlist+="<li>" +
                               "<div style='width: 100%;height: 150px;border-top: 1px solid #C0C0C0;border-left: 1px solid #C0C0C0;border-right: 1px solid #C0C0C0;'>" +
                               "<a href='/workflow/secirityManager/securityManagerContent?securityContentId="+res.data[i].knowledgeValue[j].securityContentId+"&seciritytype="+seciritytype+"&projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"' style='font-size: 17px'>"+res.data[i].knowledgeValue[j].securityDanger+"("+text+")</a>"+
                               "<ul>"+photolist+"</ul>"+
                               "</div>"+
                               "</li>";
                           photolist="";
                       }
                       htm+="<div class=\"layui-colla-item\">\n" +
                           " <h2 class=\"layui-colla-title\">"+res.data[i].knowledgeName+"" +
                           "<i class=\"layui-icon layui-colla-icon\"></i></h2>" +
                           "<div class=\"layui-colla-content\" >" +
                           "<ol>" +
                           ""+htmli+"" +
                           "</ol>" +
                           "</div>" +
                           "</div>"
                       htmli=""
                   }
                   $("#text").after("("+text+")");
                   $("#content1").html(htm);
                   $("#ul1").html(htmlist);
                   layui.element.init();//初始化
               }
           })
  }
  function initAcceptance(projectId,testTypeNo) {
      $.ajax({
          url:'/workflow/secirityManager/getRecificaOrAcceptanceGroupByType?isRecification=false&recificationStatus=1,2,3',
          data:{projectId:projectId,testTypeNo:testTypeNo},
          datatype:"json",
          success:function(res){
              var htm='';
              var htmli='';
              var htmlist='';
              var photolist='';
              for (var i=0;i<res.data.length;i++){
                  for(var j=0;j<res.data[i].knowledgeValue.length;j++){
                      htmli+="<li style='list-style: decimal; list-style: decimal;border-bottom: 1px solid #C0C0C0;font-size: 15px;margin: 15px auto;position: relative;left: 14px;'>" +
                          "<a href='/workflow/secirityManager/securityManagerContent?securityContentId="+res.data[i].knowledgeValue[j].securityContentId+"&seciritytype="+seciritytype+"&projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"'>"+res.data[i].knowledgeValue[j].securityDanger+"</a>"+
                          "</li>";
                      if(res.data[i].knowledgeValue[j].attachmentList.length>4){
                          for(var h=0;h<4;h++){
                              photolist+="<li style=' display: inline-block;'><img src='/xs?"+res.data[i].knowledgeValue[j].attachmentList[h].attUrl+"' width='60px' height='60px' style='margin-left: 10px;margin-top: 4px'></li>"
                          }
                      }else{
                          for(var h=0;h<res.data[i].knowledgeValue[j].attachmentList.length;h++){
                              photolist+="<li style=' display: inline-block;'><img src='/xs?"+res.data[i].knowledgeValue[j].attachmentList[h].attUrl+"' width='60px' height='60px' style='margin-left: 10px;margin-top: 4px'></li>"
                          }
                      }
                      var acceptanceFlag =res.data[i].knowledgeValue[j].acceptanceFlag;
                      var rectificationStatus=res.data[i].knowledgeValue[j].recificationStatus;
                      var text;
                      if (rectificationStatus==1&&acceptanceFlag==0){
                          text="未验收";
                      }else if(rectificationStatus==1&&acceptanceFlag==1){
                          text="已验收未同意";
                      }else if(rectificationStatus==2&&acceptanceFlag==1){
                          text="已退回";
                      }else if(rectificationStatus==3&&acceptanceFlag==1){
                          text=("已验收完成")
                      }
                      htmlist+="<li>" +
                          "<div style=' width:100%;height: 150px;border-top: 1px solid #C0C0C0;border-left: 1px solid #C0C0C0;border-right: 1px solid #C0C0C0;'>" +
                          "<a href='/workflow/secirityManager/securityManagerContent?securityContentId="+res.data[i].knowledgeValue[j].securityContentId+"&seciritytype="+seciritytype+"&projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"' style='font-size: 17px'>"+res.data[i].knowledgeValue[j].securityDanger+"("+text+")</a>"+
                          "<ul>"+photolist+"</ul>"+
                          "</div>"+
                          "</li>";
                      photolist="";
                  }
                  htm+="<div class=\"layui-colla-item\">\n" +
                      " <h2 class=\"layui-colla-title\">"+res.data[i].knowledgeName+"" +
                      "<i class=\"layui-icon layui-colla-icon\"></i></h2>" +
                      "<div class=\"layui-colla-content\" >" +
                      "<ol>" +
                      ""+htmli+"" +
                      "</ol>" +
                      "</div>" +
                      "</div>"
                  htmli="";

              }
              $("#content1").html(htm);
              $("#ul1").html(htmlist);
              layui.element.init();//初始化
          }
      })
  }
  function initAcceptanceTestTypeNo(testTypeNo) {
      $.ajax({
          url:'/workflow/secirityManager/getRecificaOrAcceptanceGroupByType?isRecification=false&recificationStatus=1,2,3',
          data:{testTypeNo:testTypeNo},
          datatype:"json",
          success:function(res){
              var htm='';
              var htmli='';
              var htmlist='';
              var photolist='';
              for (var i=0;i<res.data.length;i++){
                  for(var j=0;j<res.data[i].knowledgeValue.length;j++){
                      htmli+="<li style='list-style: decimal; list-style: decimal;border-bottom: 1px solid #C0C0C0;font-size: 15px;margin: 15px auto;position: relative;left: 14px;'>" +
                          "<a href='/workflow/secirityManager/securityManagerContent?securityContentId="+res.data[i].knowledgeValue[j].securityContentId+"&seciritytype="+seciritytype+"&projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"'>"+res.data[i].knowledgeValue[j].securityDanger+"</a>"+
                          "</li>";
                      if(res.data[i].knowledgeValue[j].attachmentList.length>4){
                          for(var h=0;h<4;h++){
                              photolist+="<li style=' display: inline-block;'><img src='/xs?"+res.data[i].knowledgeValue[j].attachmentList[h].attUrl+"' width='60px' height='60px' style='margin-left: 10px;margin-top: 4px'></li>"
                          }
                      }else{
                          for(var h=0;h<res.data[i].knowledgeValue[j].attachmentList.length;h++){
                              photolist+="<li style=' display: inline-block;'><img src='/xs?"+res.data[i].knowledgeValue[j].attachmentList[h].attUrl+"' width='60px' height='60px' style='margin-left: 10px;margin-top: 4px'></li>"
                          }
                      }
                      var acceptanceFlag =res.data[i].knowledgeValue[j].acceptanceFlag;
                      var rectificationStatus=res.data[i].knowledgeValue[j].recificationStatus;
                      var text;
                      if (rectificationStatus==1&&acceptanceFlag==0){
                          text="未验收";
                      }else if(rectificationStatus==1&&acceptanceFlag==1){
                          text="已验收未同意";
                      }else if(rectificationStatus==2&&acceptanceFlag==1){
                          text="已退回";
                      }else if(rectificationStatus==3&&acceptanceFlag==1){
                          text=("已验收完成")
                      }
                      htmlist+="<li>" +
                          "<div style='width: 100%;height: 150px;border-top: 1px solid #C0C0C0;border-left: 1px solid #C0C0C0;border-right: 1px solid #C0C0C0;'>" +
                          "<a href='/workflow/secirityManager/securityManagerContent?securityContentId="+res.data[i].knowledgeValue[j].securityContentId+"&seciritytype="+seciritytype+"&projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"' style='font-size: 17px'>"+res.data[i].knowledgeValue[j].securityDanger+"("+text+")</a>"+
                          "<ul>"+photolist+"</ul>"+
                          "</div>"+
                          "</li>";
                      photolist="";
                  }
                  htm+="<div class=\"layui-colla-item\">\n" +
                      " <h2 class=\"layui-colla-title\">"+res.data[i].knowledgeName+"" +
                      "<i class=\"layui-icon layui-colla-icon\"></i></h2>" +
                      "<div class=\"layui-colla-content\" >" +
                      "<ol>" +
                      ""+htmli+"" +
                      "</ol>" +
                      "</div>" +
                      "</div>"
                  htmli=""
              }
              var text=res.obj;
              $("#text").after("("+text+")");
              $("#content1").html(htm);
              $("#ul1").html(htmlist);
              layui.element.init();//初始化
          }
      })
  }
  function initAcceptanceProjectId(projectId) {
      $.ajax({
          url:'/workflow/secirityManager/getRecificaOrAcceptanceGroupByType?isRecification=false&recificationStatus=1,2,3',
          data:{projectId,projectId},
          datatype:"json",
          success:function(res){
              var htm='';
              var htmli='';
              var htmlist='';
              var photolist='';
              for (var i=0;i<res.data.length;i++){
                  for(var j=0;j<res.data[i].knowledgeValue.length;j++){
                      htmli+="<li style='list-style: decimal; list-style: decimal;border-bottom: 1px solid #C0C0C0;font-size: 15px;margin: 15px auto;position: relative;left: 14px;'>" +
                          "<a href='/workflow/secirityManager/securityManagerContent?securityContentId="+res.data[i].knowledgeValue[j].securityContentId+"&seciritytype="+seciritytype+"&projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"'>"+res.data[i].knowledgeValue[j].securityDanger+"</a>"+
                          "</li>";
                      if(res.data[i].knowledgeValue[j].attachmentList.length>4){
                          for(var h=0;h<4;h++){
                              photolist+="<li style=' display: inline-block;'><img src='/xs?"+res.data[i].knowledgeValue[j].attachmentList[h].attUrl+"' width='60px' height='60px' style='margin-left: 10px;margin-top: 4px'></li>"
                          }
                      }else{
                          for(var h=0;h<res.data[i].knowledgeValue[j].attachmentList.length;h++){
                              photolist+="<li style=' display: inline-block;'><img src='/xs?"+res.data[i].knowledgeValue[j].attachmentList[h].attUrl+"' width='60px' height='60px' style='margin-left: 10px;margin-top: 4px'></li>"
                          }
                      }
                      var acceptanceFlag =res.data[i].knowledgeValue[j].acceptanceFlag;
                      var rectificationStatus=res.data[i].knowledgeValue[j].recificationStatus;
                      var text;
                      if (rectificationStatus==1&&acceptanceFlag==0){
                          text="未验收";
                      }else if(rectificationStatus==1&&acceptanceFlag==1){
                          text="已验收未同意";
                      }else if(rectificationStatus==2&&acceptanceFlag==1){
                          text="已退回";
                      }else if(rectificationStatus==3&&acceptanceFlag==1){
                          text=("已验收完成")
                      }
                      htmlist+="<li>" +
                          "<div style='width: 100%;height: 150px;border-top: 1px solid #C0C0C0;border-left: 1px solid #C0C0C0;border-right: 1px solid #C0C0C0;'>" +
                          "<a href='/workflow/secirityManager/securityManagerContent?securityContentId="+res.data[i].knowledgeValue[j].securityContentId+"&seciritytype="+seciritytype+"&projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"' style='font-size: 17px'>"+res.data[i].knowledgeValue[j].securityDanger+"("+text+")</a>"+
                          "<ul>"+photolist+"</ul>"+
                          "</div>"+
                          "</li>";
                      photolist="";
                  }
                  htm+="<div class=\"layui-colla-item\">\n" +
                      " <h2 class=\"layui-colla-title\">"+res.data[i].knowledgeName+"" +
                      "<i class=\"layui-icon layui-colla-icon\"></i></h2>" +
                      "<div class=\"layui-colla-content\" >" +
                      "<ol>" +
                      ""+htmli+"" +
                      "</ol>" +
                      "</div>" +
                      "</div>"
                  htmli=""
              }
              var text=res.obj;
              $("#text").after("("+text+")");
              $("#content1").html(htm);
              $("#ul1").html(htmlist);
              layui.element.init();//初始化
          }
      })
  }
  function checkScreen() {
       layui.layer.open({
           type: 1,
           title:'筛选',
           skin: 'layui-layer-molv  demo-class', //加上边框
           area: ['80%', '80%'], //宽高
           btn:['确定','取消'],
           closeBtn:0,
           content:
               '<form class="layui-form" action>' +
               '<div  style="margin-top: 10px;margin-bottom: 10px;margin-left: 10px">状态</div>'+
               ' <div class="layui-form-item" style="margin-left: -109px">\n' +
               '    <div class="layui-input-block"  id="block1">\n' +
               '    </div>\n' +
               '  </div>'+
               '<div  style="margin-top: 10px;margin-bottom: 10px;margin-left: 10px">检查类型</div>'+
               ' <div class="layui-form-item" style="margin-left: -109px">\n' +
               '    <div class="layui-input-block" id="block2">\n' +
               '    </div>\n' +
               '  </div>'+
               '<div style="margin-top: 10px;margin-bottom: 10px;margin-left: 10px">项目名称</div>'+
               '<div style="position:relative;top: 52px;left: 10px">隐患区域</div>'+
               ' <div class="layui-form-item" style="margin-left: -109px;width: 368px;margin-top: -15px;position: relative">\n' +
               '    <div class="layui-input-block">\n' +
               '      <select id="interest" lay-filter="">\n' +
               '      </select>\n' +
               '    </div>\n' +
               '<input class="layui-input" id="securityRegionId" pid3 autocomplete="off"  name="securityRegionId" placeholder="请选择区域" style="height: 38px;width: 70%;margin-left: 6px;position: absolute;left:105px;top: 82px;">\n' +
               '<div class="eleTree eleb4 region" lay-filter="dataX" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:120px;left:111px;width: 70%;"></div>'+
               '<div class="inbox" style="margin: 27px 31px 10px -2px;">' +
               '<div>'+
               '<label class="layui-form-label" style="position: relative;top: 56px;left: 63px;">检查项</label>' +
               '</div>'+
               '<div class="layui-input-block">' +
               '<textarea type="text" " id="pele" pid name="ttitle1" required="" style="cursor: pointer;min-height: 96px;position: relative;top: 97px;left: 5px;" placeholder="请选择检查项" readonly="" autocomplete="off" class="layui-input"></textarea>' +
               '<div class="eleTree ele2" lay-filter="data2" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:121px;left:6px;width: 100%;"></div>' +
               '</div>' +
               '</div>' +
               '</form>',
           success:function(){
               var $block1=$("#block1");
               var $block2=$("#block2");
               switch (seciritytype) {
                        case "0":
                            //安全检查
                            var htm="<input type='checkbox' name='checkFlag' value='1' title='全部'  checked=''>"+
                                "<input type='checkbox' name='checkFlag' value='2' title='已检查'>"+
                                "<input type='checkbox' name='checkFlag' value='3' title='未检查'>"
                            $block1.prepend(htm);
                            $.ajax({
                                //查询检查类型
                                url:'/Dictonary/selectDictionaryByNo?dictNo=SECURITY_CHECK_TYPE',
                                async:false,
                                success:function(res){
                                    var checkBx="";
                                    for(var i=0;i<res.data.length;i++){
                                        checkBx+="<input type='checkbox' name='dictName' value='"+res.data[i].dictNo+"' title='"+res.data[i].dictName+"'>";
                                    }
                                    $block2.prepend(checkBx);
                                    layui.form.render();
                                }
                            })
                            break
                        case "1":
                            //安全整改
                             var htm="<input type='checkbox' name='checkFlag' value='1' title='全部'  checked=''>"+
                                "<input type='checkbox' name='checkFlag' value='2' title='已整改'>"+
                                "<input type='checkbox' name='checkFlag' value='3' title='未整改'>"
                            $block1.prepend(htm);
                            $.ajax({
                                //查询检查类型
                                url:'/Dictonary/selectDictionaryByNo?dictNo=SECURITY_CHECK_TYPE',
                                success:function(res){
                                    var checkBx="";
                                    for(var i=0;i<res.data.length;i++){
                                        checkBx+="<input type='checkbox' name='dictName' value='"+res.data[i].dictNo+"' title='"+res.data[i].dictName+"'>";
                                    }
                                    $block2.prepend(checkBx);
                                    layui.form.render();
                                }
                            })
                           break
                        case "2":
                            //安全验收
                            var htm="<input type='checkbox' name='checkFlag' value='1' title='全部'  checked=''>"+
                                "<input type='checkbox' name='checkFlag' value='2' title='已验收'>"+
                                "<input type='checkbox' name='checkFlag' value='3' title='未验收'>"
                            $block1.prepend(htm);
                            $.ajax({
                                //查询检查类型
                                url:'/Dictonary/selectDictionaryByNo?dictNo=SECURITY_CHECK_TYPE',
                                success:function(res){
                                    var checkBx="";
                                    for(var i=0;i<res.data.length;i++){
                                        checkBx+="<input type='checkbox' name='dictName' value='"+res.data[i].dictNo+"' title='"+res.data[i].dictName+"'>";
                                    }
                                    $block2.prepend(checkBx);
                                    layui.form.render();
                                }
                            })
                            break
               }
               var $select1 = $("#interest");
               var optionStr1 = '<option value="">请选择项目名称</option>';
               var projectId;
               $.ajax({
                   url:'/ProjectInfo/selectProPlus?projOrgId=&useflag=false',
                   type:'get',
                   success:function(res){
                       var data=res.data
                       if(data!=undefined&&data.length>0){
                           for (var i=0;i<data.length;i++){
                               optionStr1 += '<option id="op'+i+'" value="' + data[i].projectId + '">' + data[i].projectName + '</option>'
                           }
                       }
                       $select1.html(optionStr1);
                       layui.form.render();
                   }
               });
               $(document).on("click","[name='securityRegionId']",function (e) {
                   debugger
                   e.stopPropagation();
                   var projectId = $("#interest").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value")
                   if(projectId == null|| projectId == undefined){
                       layer.msg('请先选择项目名称')
                   }else{
                       layui.eleTree.render({
                           elem: '.eleb4',
                           url:'/workflow/secirityManager/getRegionByProject?projectId='+projectId,
                           expandOnClickNode: false,
                           highlightCurrent: true,
                           showLine:true,
                           showCheckbox: false,
                           checked: false,
                           lazy: false,
                           done: function(res){
                               if(res.data.length == 0){
                                   $(".eleb4").html('<div style="text-align: center">暂无数据</div>');
                               }
                           }
                       });
                   }

                   $(".eleb4").slideDown();
               })
               $(document).on("click",function() {
                   $(".eleb4").slideUp();
               })
               layui.eleTree.on("nodeClick(dataX)",function(d) {
               var parData = d.data.currentData;
               var str111="";
               $.ajax({
                   url:'/workflow/secirityManager/getRegionById?regionId='+parData.regionId,
                   dataType:'json',
                   type:'post',
                   async: false,
                   success:function(res){
                       if(res.code===0||res.code==="0"){
                           var regionName = res.obj;
                           str111 = regionName//name
                       }
                   }
               })
               $("#securityRegionId").val(str111)
               $("#securityRegionId").attr("pid3",parData.id)
           });


               var el;
               $("[name='ttitle1']").on("click",function (e) {
                   e.stopPropagation();
                   if(!el){
                       el=layui.eleTree.render({
                           elem: '.ele2',
                           url:'/workflow/secirityManager/getSecurityByType?parent=0',
                           expandOnClickNode: false,
                           highlightCurrent: true,
                           showLine:true,
                           showCheckbox: true,
                           checked: false,
                           lazy: true,
                           load: function(data,callback) {
                               $.post('/workflow/secirityManager/getSecurityByType?parent='+data.id,function (res) {
                                   callback(res.data);//点击节点回调
                               })
                           },
                           done: function(res){

                           }
                       });
                   }
                   $(".ele2").slideDown();
               })
               $(document).on("click",function() {
                   $(".ele2").slideUp();
               })
               //节点点击事件
               var str111="";
               var parData1="";
               layui.eleTree.on("nodeChecked(data2)",function(d) {
                   parData1 = d.data.currentData;
                   console.log(parData1)
                   $.ajax({
                       url:'/workflow/secirityManager/getKnowledgeById?knowleId='+parData1.securityKnowledgeId,
                       dataType:'json',
                       type:'post',
                       async: false,
                       success:function(res){
                           if(d.isChecked==true||d.isChecked=="true"){
                               var securityKnowledgeName = res.obj+",";
                               str111+=securityKnowledgeName
                           }else{
                               var securityKnowledgeName = res.obj+",";
                               str111= str111.replace(securityKnowledgeName,"");
                           }
                       }
                   })
                   $("[name='ttitle1']").val(str111);
                   $("#pele").attr("pid",parData1.id);
               });
           }
           ,yes:function(){
                   var checkFlagArray=[];
                   var checkFlag="";//状态
                   var testTypeNos="";//检查类型
                   var projectId;//项目名称
                   var regionIds;//隐患区域
                   var knowledgeIds;//检查项
             $("input[name='checkFlag']:checked").each(function(){
                 checkFlagArray.push($(this).val());
             })
               if(checkFlagArray.length>=2||checkFlagArray.length==0){
                   alert("请选择一种状态");
                   return;
               }else{
                   if($.inArray('1',checkFlagArray)==0){
                      checkFlag="1,0";
                   }else if($.inArray('2',checkFlagArray)==0&&$.inArray('3',checkFlagArray)<0){
                       //已检查,已整改，已验收
                       checkFlag="1";
                   }else if($.inArray('3',checkFlagArray)==0&&$.inArray('2',checkFlagArray)<0){
                       //未检查,未整改，未验收
                       checkFlag="0";
                   }
               }
               $("input[name='dictName']:checked").each(function(){
                   testTypeNos+=$(this).val()+",";
               })
               projectId = $("#interest").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value");
               regionIds=$("#securityRegionId").val();
               knowledgeIds=$("#pele").val();
               $.ajax({
                   url:"/workflow/secirityManager/selectDetailInfoGroupByType",
                   data:{checkFlags:checkFlag,testTypeNos:testTypeNos,projectId:projectId,regionIds:regionIds,knowledgeIds:knowledgeIds},
                   dataType:"json",
                   type:"post",
                   success:function(res){
                       if(res.data.length==0){
                           $("#content1").text("暂无数据");
                           $("#ul1").html("暂无数据");
                       }else{
                           var htm='';
                           var htmli='';
                           var htmlist='';
                           var photolist='';
                           for (var i=0;i<res.data.length;i++){
                               for(var j=0;j<res.data[i].knowledgeValue.length;j++){
                                   htmli+="<li style='list-style: decimal; list-style: decimal;border-bottom: 1px solid #C0C0C0;font-size: 15px;margin: 15px auto;position: relative;left: 14px;'>" +
                                       "<a href='/workflow/secirityManager/securityManagerContent?securityContentId="+res.data[i].knowledgeValue[j].securityContentId+"&seciritytype="+seciritytype+"&projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"'>"+res.data[i].knowledgeValue[j].securityDanger+"</a>"+
                                       "</li>";
                                   if(res.data[i].knowledgeValue[j].attachmentList.length>4){
                                       for(var h=0;h<4;h++){
                                           photolist+="<li style=' display: inline-block;'><img src='/xs?"+res.data[i].knowledgeValue[j].attachmentList[h].attUrl+"' width='60px' height='60px' style='margin-left: 10px;margin-top: 4px'></li>"
                                       }
                                   }else{
                                       for(var h=0;h<res.data[i].knowledgeValue[j].attachmentList.length;h++){
                                           photolist+="<li style=' display: inline-block;'><img src='/xs?"+res.data[i].knowledgeValue[j].attachmentList[h].attUrl+"' width='60px' height='60px' style='margin-left: 10px;margin-top: 4px'></li>"
                                       }
                                   }
                                   switch(seciritytype){
                                       case "0":
                                           var checkFlag =res.data[i].knowledgeValue[j].checkFlag;
                                           var text;
                                           if (res.data[i].knowledgeValue[j].recificationStatus==undefined&&checkFlag==0 ){
                                               text="未检查";
                                           }else if(res.data[i].knowledgeValue[j].recificationStatus==undefined&&checkFlag==1){
                                               text="已检查未提交";
                                           }else if(res.data[i].knowledgeValue[j].recificationStatus!=undefined&&checkFlag==1){
                                               text="已检查";
                                           }
                                           break;
                                       case "1":
                                           var recificationFlag =res.data[i].knowledgeValue[j].recificationFlag;
                                           var rectificationStatus=res.data[i].knowledgeValue[j].recificationStatus;
                                           var text;
                                           if(rectificationStatus==0&&recificationFlag==0){
                                               text="未整改";
                                           }else if(rectificationStatus==0&&recificationFlag==1){
                                               text="已整改未提交"
                                           }else if(rectificationStatus==1&&recificationFlag==1){
                                               text="已整改"
                                           }else if(rectificationStatus==2&&recificationFlag==1){
                                               text="已退回重新整改"
                                           }
                                           break;
                                       case "2":
                                           var acceptanceFlag =res.data[i].knowledgeValue[j].acceptanceFlag;
                                           var rectificationStatus=res.data[i].knowledgeValue[j].recificationStatus;
                                           var text;
                                           if (rectificationStatus==1&&acceptanceFlag==0){
                                               text="未验收";
                                           }else if(rectificationStatus==1&&acceptanceFlag==1){
                                               text="已验收未同意";
                                           }else if(rectificationStatus==2&&acceptanceFlag==1){
                                               text="已退回";
                                           }else if(rectificationStatus==3&&acceptanceFlag==1){
                                               text=("已验收完成")
                                           }
                                           break;
                                   }
                                   htmlist+="<li>" +
                                       "<div style='width: 100%;height: 150px;border-top: 1px solid #C0C0C0;border-left: 1px solid #C0C0C0;border-right: 1px solid #C0C0C0;'>" +
                                       "<a href='/workflow/secirityManager/securityManagerContent?securityContentId="+res.data[i].knowledgeValue[j].securityContentId+"&seciritytype="+seciritytype+"&projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype="+datatype+"' style='font-size: 17px'>"+res.data[i].knowledgeValue[j].securityDanger+"("+text+")</a>"+
                                       "<ul>"+photolist+"</ul>"+
                                       "</div>"+
                                       "</li>";
                                   photolist="";
                               }
                               htm+="<div class=\"layui-colla-item\">\n" +
                                   " <h2 class=\"layui-colla-title\">"+res.data[i].knowledgeName+"" +
                                   "<i class=\"layui-icon layui-colla-icon\"></i></h2>" +
                                   "<div class=\"layui-colla-content\" >" +
                                   "<ol>" +
                                   ""+htmli+"" +
                                   "</ol>" +
                                   "</div>" +
                                   "</div>"
                               htmli=""
                           }
                           debugger
                           var text="";
                           $("#text").after(text);
                           $("#content1").html(htm);
                           $("#ul1").html(htmlist);
                           layui.element.init();//初始化
                       }
                   }
               })
               layer.closeAll();
           }
       })
  }
  function getweatherBefore(){
      var area="";
      var areaText = "";
      //获取地理位置
      if(BMap!=undefined) {
          var map = new BMap.Map("allmap");
          var point = new BMap.Point(108.95, 34.27);
          // map.centerAndZoom(point, 18);
          var geolocation = new BMap.Geolocation();
          geolocation.getCurrentPosition(function (r) {
              if (this.getStatus() == BMAP_STATUS_SUCCESS) {
                  // var mk = new BMap.Marker(r.point);
                  // map.addOverlay(mk);//标出所在地
                  // map.panTo(r.point);//地图中心移动
                  //alert('您的位置：'+r.point.lng+','+r.point.lat);
                  var point = new BMap.Point(r.point.lng, r.point.lat);//用所定位的经纬度查找所在地省市街道等信息
                  var gc = new BMap.Geocoder();
                  gc.getLocation(point, function (rs) {
                      var addComp = rs.addressComponents; //地址信息
                      area = rs.addressComponents.city;
                      $.ajax({
                          type:'get',
                          url:'/widget/getWeatherNew',
                          dataType:'json',
                          data:{cityName:area},
                          success:function(res){
                              if(res.flag && res.object){
                                  $("#water").text(res.object.weather)
                              }
                          }
                      })
                  });
              } else {
                  alert('failed' + this.getStatus());
              }

          }, {enableHighAccuracy: true})

      }
  }
</script>
</body>
</html>
