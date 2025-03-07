<%--
  Created by IntelliJ IDEA.
  User: dongke
  Date: 2021/3/10
  Time: 18:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>工作内容</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="/lib/jquery.form.min.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>

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
<div style="margin-top: 20px;position: relative;">
    <img src="../../img/log2.png" style="position: absolute;left: 21px;top: 2px;width: 25px; "><span
        style="margin-left: 49px;font-size: 20px;" id="spa">工作详情</span>
    <span type="text"  id="fillingDate" style="position: absolute;right: 50px;top: 10px"></span>
    <span id="water" style="position: absolute;right: 21px;top: 8px"></span>
</div>
<hr class="layui-bg-blue" style="height: 5px">
<form class="layui-form" action="" >
    <div class="layui-form-item" style="position: relative" ><%--    width 79%--%>
        <span style="position: absolute;color: red;left: 15px;top: 13px">*</span>
        <label class="layui-form-label" style="margin-left: -13px">工作内容</label>
        <div class="layui-input-block" style="width: 69%;position: relative">
<%--            <input  name="title" id="title1"  required  lay-verify="required"  autocomplete="off" class="layui-input" style="margin-left: -19px">--%>
            <textarea id="title1" style="margin-left: -19px;margin-top:7px;width: 100%;height: 100px" placeholder="请输入工作内容"></textarea>
        </div>
    </div>
    <div class="layui-form-item" style="height: 43px;width: 79%" id="d1"><%--    width 69%--%>
        <span style="position: absolute;color: red;left: 15px;top: 212px">*</span>
        <label class="layui-form-label" style="position: absolute; left: -9px;top: 199px">完成状态</label>
<%--        width 69%--%>
        <div class="layui-form" lay-filter="myDiv" style="position: absolute;top: 199px;left: 91px; width: 69%">
            <select name="" id="sel" lay-filter="mySelect" class="layui-input" style="margin-left: 10px">
                <option value="">请选择</option>
                <option value="0">完成</option>
                <option value="1">部分完成</option>
                <option value="10">未启动</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="margin-left: -13px">说明</label>
        <div class="layui-input-block">
            <textarea style="width: 100%;margin-top: 8px;height: 100px;margin-left: -19px" id="explain" placeholder="文字、图片、附件、音频"></textarea>
        </div>
    </div>
</form>








<div class="basic_infor_title">
    <div class="basic_infor" style="font-size: 16px;color: #333;margin-left: 6px;font-weight: 900"><fmt:message code="email.th.file" /></div>
    <div class="basic_infor_title_link" style="position: relative">
        <a href="javascript:;" class="xzbtn" style="height: 32px;line-height: 32px;font-size: 16px;color: #01adff;position: absolute;left: 85px"  id="upload">上传附件</a>
    </div>
</div>
<div style="padding-bottom: 8px;">
    <div>
        <ul class="uploadbox">

        </ul>
    </div>
    <div class="photo_box" style="margin-top: 43px;margin-left: 37px; display: flex;flex-wrap: wrap;align-content: space-between;padding-left: 55px">

    </div>
</div>
<div style="width: 100%;height: 45px;" class="choose_box">
    <div style="width: 100%;text-align: center">
        <%--<img class="choosewj" src="/img/workflow/work/choose_img.png" alt="" onclick="btn1()" style="height:46px;width: 100%;margin-bottom: 40px">--%>
        <%--            <span class="xzbtn" style="display: none;padding: 13px 80px;background: #3b87f5;font-size: 16px;font-weight: bold; border-radius: 40px;color:#fff;" onclick="btn1()">选择文件</span>--%>
        <form id="uploadimgform" style="display:none;" target="uploadiframe" action="workUpload?module=workflow"  enctype="multipart/form-data" method="post" >
            <input type="file"  name="file" id="uploadinputimg" uploadType="1" multiple class="w-icon5">
        </form>
    </div>
</div>
   <p style="text-align: center"><button type="button"  class="layui-btn layui-btn-sm" id="btn" style="width: 80px;margin-left: 5px" >保存</button>
   <button type="button"  class="layui-btn layui-btn-sm" id="btn2" style="width: 80px; margin-left: 28px" >返回</button>
   </p>
<script>

        layui.use(["form","upload","laydate"],function () {
            var form=layui.form;
            var laydate=layui.laydate;
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


          $("#btn2").click(function(){
              window.history.go(-1);
          })

            //使用正则表达式获取url中的参数
            function getUrlParam(name) {
                //构造一个含有目标参数的正则表达式对象
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                //匹配目标参数
                var r = window.location.search.substr(1).match(reg);
                //返回参数值
                if (r != null) return unescape(r[2]); return null;
            }
        function getParamByUrl(url,name) {
            //构造一个含有目标参数的正则表达式对象
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            //匹配目标参数
            var r = url.match(reg);
            //返回参数值
            if (r != null) return unescape(r[2]); return null;
        }
            var urlData = getUrlParam('logID');
            var urlType=getUrlParam('type');
            var workType=getUrlParam('workType')
            var workPlanId=getUrlParam("workPlanId");
            var datatype=getUrlParam("datatype");
            judge(datatype);
            panduan();
            function panduan() {
                switch (urlType) {
                    case '0':
                        $("#title1").attr("disabled","disabled");
                        var work=1
                        initWork(work,urlData,workPlanId);
                        $("#btn").click(function(){
                            preservationYestday();
                        })
                        break;
                    case '1':
                        var work=1
                        initWork(work,urlData,workPlanId);
                        $("#btn").click(function () {
                            preservationToday();
                        })
                        break;
                    case '2':
                        $("#d1").hide();
                        var work=1
                        initWork(work,urlData,workPlanId);
                        $("#btn").click(function () {
                            preservationTomorrow();
                        })
                        break;
                    case '3':
                        $("#spa").append("(今日)")
                        $("#btn").click(function () {
                            var txt=$("#title1").val();
                            var selval=$("#sel").val();
                            var explain=$("#explain").val();
                            if (txt==""||selval==""){
                                layui.layer.alert("工作内容、完成状态不能为空")
                            } else {
                                addContent(txt,selval,explain,workPlanId);
                            }
                        })
                        break;
                    case '4':
                        $("#spa").append("(明日)")
                        $("#d1").hide();
                        $("#btn").click(function () {
                            var txt=$("#title1").val();
                            var selval=""
                            var explain=$("#explain").val();
                            if (txt==""){
                                layui.layer.alert("工作内容不能为空")
                            } else {
                                addContent(txt,selval,explain,workPlanId);
                            }
                        })
                       break;
                }
            }


       function  initWork(work ,logid,workPlanId) {
           //工作内容数据查询
           $.ajax({
               url:"/workflow/workLog/getWorkById",
               data:{type:"work",workId:logid,workPlanId:workPlanId},
               dataType:"json",
               type:"post",
               success:function (res) {
                   $("#title1").val(res.object.jobContent);
                   $("#sel").val(res.object.completionStatus);
                   $("#explain").val(res.object.explain);
                   var n=res.object.attachmentList;
                   var photo=""
                   for(var i=0;i<n.length;i++){
                       var fileId="\"blah"+i+"\"";
                       photo+="<div id='blah"+i+"' style='position: relative'>" +
                           "<img attachmentId="+res.object.attachmentId+" attachmentName="+res.object.attachmentName+" delurl="+n[i].attUrl+" src='/xs?"+n[i].attUrl+"' style='width: 70px;height: 100px;margin-right: 10px;margin-bottom: 10px;'/>" +
                               "<span class='layui-icon layui-icon-close-fill spa'  style='color: #DC143C;position: absolute;left: 59px;top: -4px;' onclick='delFile("+fileId+")' ></span>"+
                       "</div>"
                   }
                   $(".photo_box").html(photo)
                   layui.form.render();
               }
           })

       }
        function preservationYestday() {
            var txt=$("#title1").val();
            var selval=$("#sel").val();
            var explain=$("#explain").val();
            var attachmentId='';
            var attachmentName='';
            $("div[class=photo_box] img").each(function() {
                attachmentId+=$(this).attr("attachmentId");
                attachmentName+=$(this).attr("attachmentName");
            });
            if (selval==""){
                layui.layer.alert("完成状态不能为空")
            } else {
                updateContent(txt,selval,explain,attachmentId,attachmentName,workPlanId);
            }
        }

        function preservationToday() {
            var txt=$("#title1").val();
            var selval=$("#sel").val();
            var explain=$("#explain").val();
            var attachmentId='';
            var attachmentName='';
            $("div[class=photo_box] img").each(function() {
                attachmentId+=$(this).attr("attachmentId");
                attachmentName+=$(this).attr("attachmentName");
            });
            if (txt==""||selval==""){
                layui.layer.alert("工作内容\&完成状态不能为空")
            } else {
                updateContent(txt,selval,explain,attachmentId,attachmentName,workPlanId);
            }
        }
        function preservationTomorrow() {
            var txt=$("#title1").val();
            var selval=$("#sel").val();
            var explain=$("#explain").val();
            var attachmentId='';
            var attachmentName='';
            $("div[class=photo_box] img").each(function() {
                attachmentId+=$(this).attr("attachmentId");
                attachmentName+=$(this).attr("attachmentName");
            });
            if (txt==""){
                layui.layer.alert("工作内容不能为空")
            } else {
                updateContent(txt,selval,explain,attachmentId,attachmentName);
            }
        }

        function updateContent(txt,selval,explain,attachmentId,attachmentName,workPlanId) {
            $.ajax({
                url:"/workflow/workLog/updateManager",
                data:{logId:urlData,jobContent:txt,completionStatus:selval,explain:explain,attachmentId:attachmentId,attachmentName:attachmentName,workPlanId:workPlanId},
                dataType:"json",
                type:"post",
                success:function (res) {
                    layui.layer.msg(res.msg,{time:500,offset:"500px",icon:1},function(){
                        window.history.go(-1);
                    })

                }
            })
        }
      function addContent(txt,selval,explain,workPlanId) {
           $.ajax({
               url:"/workflow/workLog/insertManager",
               data:{workType:workType,jobContent:txt,completionStatus:selval,explain:explain,workPlanId:workPlanId},
               dataType:"json",
               type:"post",
               success:function (res) {
                   layui.layer.msg(res.msg,{time:500,offset:"500px",icon:1},function(){
                       window.history.go(-1);
                   })
               }
           })
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
                //var filesize = 1,filesize
                imgadd1(cb,num);
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

    // function getweatherBefore(){
    //     var area="";
    //     var areaText = "";
    //     //获取地理位置
    //     if(BMap!=undefined) {
    //         var map = new BMap.Map("allmap");
    //         var point = new BMap.Point(108.95, 34.27);
    //         // map.centerAndZoom(point, 18);
    //         var geolocation = new BMap.Geolocation();
    //         geolocation.getCurrentPosition(function (r) {
    //             if (this.getStatus() == BMAP_STATUS_SUCCESS) {
    //                 // var mk = new BMap.Marker(r.point);
    //                 // map.addOverlay(mk);//标出所在地
    //                 // map.panTo(r.point);//地图中心移动
    //                 //alert('您的位置：'+r.point.lng+','+r.point.lat);
    //                 var point = new BMap.Point(r.point.lng, r.point.lat);//用所定位的经纬度查找所在地省市街道等信息
    //                 var gc = new BMap.Geocoder();
    //                 gc.getLocation(point, function (rs) {
    //                     var addComp = rs.addressComponents; //地址信息
    //                     area = rs.addressComponents.city;
    //                     $.ajax({
    //                         type:'get',
    //                         url:'/widget/getWeatherNew',
    //                         dataType:'json',
    //                         data:{cityName:area},
    //                         success:function(res){
    //                             if(res.flag && res.object){
    //                                 $("#water").text(res.object.weather)
    //                             }
    //                         }
    //                     })
    //                 });
    //             } else {
    //                 alert('failed' + this.getStatus());
    //             }
    //
    //         }, {enableHighAccuracy: true})
    //
    //     }
    // }
    function judge(datatype) {
      if (datatype!="0"){
            $("#title1").attr("disabled","disabled");
            $("#sel").attr("disabled","disabled");
            $("#explain").attr("disabled","disabled");
            $("#btn").attr("disabled","disabled");
      }
    }
</script>

</body>
</html>
