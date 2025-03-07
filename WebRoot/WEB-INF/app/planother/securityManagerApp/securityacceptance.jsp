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
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>安全验收App</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20190817.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../../js/common/fileupload.js"></script>
    <style>
        .layui-tab-title li{
            min-width: 41%;
            border-bottom: 1px solid #000000;
        }

    </style>
</head>
<body>
<div style="margin-top: 20px;position: relative;">
    <img src="../../img/log2.png" style="position: absolute;left: 21px;top: 2px;width: 25px; "><span
        style="margin-left: 49px;font-size: 20px;">安全验收</span>
    <span type="text"  id="fillingDate" style="position: absolute;right: 50px;top: 10px"></span>
    <span id="water" style="position: absolute;right: 21px;top: 8px"></span>
</div>
<hr class="layui-bg-blue" style="height: 5px">

<div class="layui-tab">
    <ul class="layui-tab-title">
        <li class="layui-this">检查类型</li>
        <li>项目名称</li>
    </ul>
    <div class="layui-tab-content">
        <div class="layui-tab-item layui-show" >
            <div id="dv1" style="border: 1px solid #C0C0C0; border-radius: 10px;  height: 110px; background-color: #FFFFFF; margin-top: 2%; margin-bottom:auto; margin-left:auto; margin-right: auto;width: 90%" >
                <div style="height: 50px; border-bottom: 1px solid #C0C0C0;display: flex;flex-direction: row">
                    <div style="display: flex; width: 30%">
                        <div style="font-weight: bold; font-size: 17px;color: #000000; top: 0;bottom: 0;left: 0;right: 0;margin: auto">全部任务</div>
                    </div>
                    <div style="display: flex; width: 66%">
                        <div style=" font-size: 13px;color: #000000; top: 0;bottom: 0;left: 0;right: 0;margin-top: auto;margin-bottom:auto;margin-left: 65% ">任务总数</div>
                    </div>
                </div>
                <div id="dvbox1" style="display: flex;height: 70px">
                    <div style="width: 30%;position: relative">
                        <div style="position: absolute;top: 7%;left: 50%;font-size: 19px;color: #000000" id="allnum1"></div>
                        <div style="position: absolute;top: 37%;left: 35.3%;">总事项</div>
                    </div>
                    <div style="width: 30%;position: relative">
                        <div style="position: absolute;top: 7%;left: 50%;font-size: 19px;color:#FF8C00" id="nNum1"></div>
                        <div style="position: absolute;top: 37%;left: 35.3%;">未验收</div>
                    </div>
                    <div style="width: 30%;position: relative">
                        <div style="position: absolute;top: 7%;left: 50%;font-size: 19px;color:#00FF00" id="yNum1"></div>
                        <div style="position: absolute;top: 37%;left: 35.3%;">已验收</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-tab-item">
            <div id="dv2" style="border: 1px solid #C0C0C0; border-radius: 10px;  height: 110px; background-color: #FFFFFF; margin-top: 2%; margin-bottom:auto; margin-left:auto; margin-right: auto;width: 90%" >
                <div style="height: 50px; border-bottom: 1px solid #C0C0C0;display: flex;flex-direction: row">
                    <div style="display: flex; width: 30%">
                        <div style="font-weight: bold; font-size: 17px;color: #000000; top: 0;bottom: 0;left: 0;right: 0;margin: auto">全部任务</div>
                    </div>
                    <div style="display: flex; width: 66%">
                        <div style=" font-size: 13px;color: #000000; top: 0;bottom: 0;left: 0;right: 0;margin-top: auto;margin-bottom:auto;margin-left: 65% ">任务总数</div>
                    </div>
                </div>
                <div id="dvbox2" style="display: flex;height: 70px">
                    <div style="width: 30%;position: relative">
                        <div style="position: absolute;top: 7%;left: 50%;font-size: 19px;color: #000000" id="allnum2"></div>
                        <div style="position: absolute;top: 37%;left: 35.3%;">总事项</div>
                    </div>
                    <div style="width: 30%;position: relative">
                        <div style="position: absolute;top: 7%;left: 50%;font-size: 19px;color:#FF8C00" id="nNum2"></div>
                        <div style="position: absolute;top: 37%;left: 35.3%;">未验收</div>
                    </div>
                    <div style="width: 30%;position: relative">
                        <div style="position: absolute;top: 7%;left: 50%;font-size: 19px;color:#00FF00" id="yNum2"></div>
                        <div style="position: absolute;top: 37%;left: 35.3%;">已验收</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    layui.use(['element'],function(){
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
    })
    initCheck();
    function initCheck() {
        $.ajax({
            url:'/workflow/secirityManager/getRecifiOrAcceptByOption?isRecification=false&checkType=1&recificaionStatus=1,3',
            datatype:'json',
            type:'get',
            success:function(res){
                var htm='';
                if(res.obj==undefined){
                    $("#allnum1").text("0");
                    $("#nNum1").text("0");
                    $("#yNum1").text("0");
                }else if(res.obj.length==0){
                    $("#allnum1").text("0");
                    $("#nNum1").text("0");
                    $("#yNum1").text("0");
                }else{
                    for(var i=0;i<res.obj.otherData.length;i++){
                        htm+='<div   style="border: 1px solid #C0C0C0; border-radius: 10px;  height: 110px; background-color: #FFFFFF; margin-top: 5%;bottom: 0; margin-bottom:auto; left: 0; margin-left:auto; right: 0; margin-right: auto;width: 90%" >\n' +
                            '    <div style="height: 50px; border-bottom: 1px solid #C0C0C0;display: flex;flex-direction: row">\n' +
                            '         <div style="display: flex; width: 30%">\n' +
                            '            <div style="font-weight: bold; font-size: 17px;color: #000000; top: 0;bottom: 0;left: 0;right: 0;margin: auto">'+res.obj.otherData[i].name+'</div>\n' +
                            '         </div>\n' +
                            '        <div style="display: flex; width: 66%">\n' +
                            '            <div style=" font-size: 13px;color: #000000; top: 0;bottom: 0;left: 0;right: 0;margin-top: auto;margin-bottom:auto;margin-left: 65% "></div>\n' +
                            '        </div>\n' +
                            '    </div>\n' +
                            '    <div id="htm'+i+'" testTypeNo="'+res.obj.otherData[i].testTypeNo+'" projectId="'+res.obj.otherData[i].projectId+'" style="display: flex;height: 70px">\n' +
                            '        <div style="width: 30%;position: relative">\n' +
                            '            <div style="position: absolute;top: 7%;left: 50%;font-size: 19px;color: #000000">'+res.obj.otherData[i].num+'</div>\n' +
                            '            <div style="position: absolute;top: 37%;left: 35.3%;">总事项</div>\n' +
                            '        </div>\n' +
                            '        <div style="width: 30%;position: relative">\n' +
                            '            <div style="position: absolute;top: 7%;left: 50%;font-size: 19px;color:#FF8C00">'+res.obj.otherData[i].nNum+'</div>\n' +
                            '            <div style="position: absolute;top: 37%;left: 35.3%;">未验收</div>\n' +
                            '        </div>\n' +
                            '        <div style="width: 30%;position: relative">\n' +
                            '            <div style="position: absolute;top: 7%;left: 50%;font-size: 19px;color:#00FF00">'+res.obj.otherData[i].yNum+'</div>\n' +
                            '            <div style="position: absolute;top: 37%;left: 35.3%;">已验收</div>\n' +
                            '        </div>\n' +
                            '    </div>\n' +
                            '</div>';

                        $(document).on('click','#htm'+i,function(){
                            var projectId=$(this).attr("projectId");
                            var testTypeNo=$(this).attr("testTypeNo");
                            window.location.href="/workflow/secirityManager/securityCheckApp?projectId="+projectId+"&testTypeNo="+testTypeNo+"&datatype=1&seciritytype=2";
                        })
                    }
                    $("#allnum1").text(res.obj.allNum);
                    $("#nNum1").text(res.obj.nNum);
                    $("#yNum1").text(res.obj.yNum);
                    $("#dv1").after(htm);
                    $("#dvbox1").click(function(){
                        window.location.href="/workflow/secirityManager/securityCheckApp?datatype=0&seciritytype=2"
                    })
                }

            }
        })
    }

    initName();
    function initName() {
        $.ajax({
            url:'/workflow/secirityManager/getRecifiOrAcceptByOption?isRecification=false&project=1&recificaionStatus=1,3',
            datatype:'json',
            type:'get',
            success:function(res){
                var htm='';
                if(res.obj==undefined){
                    $("#allnum2").text("0");
                    $("#nNum2").text("0");
                    $("#yNum2").text("0");
                }else if(res.obj.length==0){
                    $("#allnum2").text("0");
                    $("#nNum2").text("0");
                    $("#yNum2").text("0");
                }else{
                    for(var i=0;i<res.obj.otherData.length;i++){
                        htm+='<div   style="border: 1px solid #C0C0C0; border-radius: 10px;  height: 110px; background-color: #FFFFFF; margin-top: 5%; margin-bottom:auto; margin-left:auto; margin-right: auto;width: 90%" >\n' +
                            '    <div style="height: 50px; border-bottom: 1px solid #C0C0C0;display: flex;flex-direction: row">\n' +
                            '         <div style="display: flex; width: 100%">\n' +
                            '            <div style="font-weight: bold; font-size: 17px;color: #000000; top: 0;bottom: 0;margin-top: auto;margin-bottom: auto;margin-left: 5.3%">'+res.obj.otherData[i].name+'</div>\n' +
                            '         </div>\n' +
                            '    </div>\n' +
                            '    <div id="bx'+i+'"  projectId="'+res.obj.otherData[i].projectId+'" style="display: flex;height: 70px">\n' +
                            '        <div style="width: 30%;position: relative">\n' +
                            '            <div style="position: absolute;top: 7%;left: 50%;font-size: 19px;color: #000000">'+res.obj.otherData[i].num+'</div>\n' +
                            '            <div style="position: absolute;top: 37%;left: 35.3%;">总事项</div>\n' +
                            '        </div>\n' +
                            '        <div style="width: 30%;position: relative">\n' +
                            '            <div style="position: absolute;top: 7%;left: 50%;font-size: 19px;color:#FF8C00">'+res.obj.otherData[i].nNum+'</div>\n' +
                            '            <div style="position: absolute;top: 37%;left: 35.3%;">未检查</div>\n' +
                            '        </div>\n' +
                            '        <div style="width: 30%;position: relative">\n' +
                            '            <div style="position: absolute;top: 7%;left: 50%;font-size: 19px;color:#00FF00">'+res.obj.otherData[i].yNum+'</div>\n' +
                            '            <div style="position: absolute;top: 37%;left: 35.3%;">已检查</div>\n' +
                            '        </div>\n' +
                            '    </div>\n' +
                            '</div>';

                        $(document).on('click','#bx'+i,function(){
                            var projectId=$(this).attr("projectId");
                            window.location.href="/workflow/secirityManager/securityCheckApp?projectId="+projectId+"&datatype=2&seciritytype=2"
                        })
                    }

                    $("#allnum2").text(res.obj.allNum);
                    $("#nNum2").text(res.obj.nNum);
                    $("#yNum2").text(res.obj.yNum);
                    $("#dv2").after(htm);
                    $("#dvbox2").click(function(){
                        window.location.href="/workflow/secirityManager/securityCheckApp?datatype=0&seciritytype=2"
                    })
                }

            }
        })
    }
</script>
</body>
</html>
