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
<%--    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">--%>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>工作日志H5</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20190817.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

    <link rel="stylesheet" href="../../css/email/m/jquery.mobile.css"/>
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>

    <script src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918.09" type="text/javascript" charset="utf-8"></script>

    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <style>
        html,body{
            background: #fff;
            font-size: 17px;
            line-height: 21px;
            -webkit-overflow-scrolling: touch;
            width: 100%;
        }

    </style>
</head>
<body>
  <div class="mui-content">
<%--                      <a href="/workflow/workLog/workH5Info" target="_blank">--%>
<%--                          测试--%>
<%--                      </a>--%>
      <span class="mui-icon mui-icon-plusempty" id="info" style="
        color: blue;
        display: inline-block;
        position: fixed;
        font-size: 50px;
        font-weight: bolder;
        z-index: 999;
        right: 20px;
        bottom: 20px;">
      </span>
      <div class="mui-input-row mui-search">
          <input type="search" class="mui-input-clear" placeholder="请输入标题搜索">
      </div>
    <div class="mui-scroll-wrapper" id="refreshContainer" style="top: 50px">
        <div class="mui-scroll">
            <!--这里放置真实显示的DOM内容-->
            <ul id="dataUl" class="mui-table-view mui-table-view-striped mui-table-view-condensed">

            </ul>
        </div>
    </div>

  </div>

<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>

<script type="text/javascript">

    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
    }
    (function () {
            var browserRule = /^.*((iPhone)|(iPad)|(Safari))+.*$/
            if (browserRule.test(navigator.userAgent)) {
                window.onpageshow = function (e) {
                    if (e.persisted || (window.performance && window.performance.navigation.type == 2)) {
                        window.location.reload()
                    }
                }
            }
        }
    )()




    mui.init({
        pullRefresh : {
            container:"#refreshContainer",//下拉刷新容器标识，querySelector能定位的css选择器均可，比如：id、.class等
            down : {
                style: 'circle', //必选，下拉刷新样式
                color: '#2BD009', //可选，设置下拉刷新控件颜色
                height: 50,//可选,默认50.触发下拉刷新拖动的距离,
                auto: false,//可选,默认false.是否首次加载时自动下拉刷新一次
                contentdown: "下拉可以刷新",//可选，在下拉可刷新状态时，下拉刷新控件上显示的标题内容
                contentover: "释放立即刷新",//可选，在释放可刷新状态时，下拉刷新控件上显示的标题内容
                contentrefresh: "正在刷新...",//可选，正在刷新状态时，下拉刷新控件上显示的标题内容
                callback :pulldownRefresh //必选，刷新函数，根据具体业务来编写，比如通过ajax从服务器获取新数据；
            }
        }
    });
  /*  window.onload = function() {
        document.referrer = ''
        // alert('ce')
        mui.plusReady(function(){
            alert("当前页面URL："+plus.webview.currentWebview().getURL());
        });
        window.addEventListener('refresh', function(){//执行刷新
            // alert(11)
            location.reload();
        });
    }*/



    /**
     * 下拉刷新具体业务实现
     */
    function pulldownRefresh() {
        saveDate(1,1,10,function () {
            mui('#refreshContainer').pullRefresh().endPulldownToRefresh(); //refresh completed
        })
    }

    mui('.mui-scroll-wrapper').scroll({
        indicators: true, //是否显示滚动条
        deceleration: 0.0005 //flick 减速系数，系数越大，滚动速度越慢，滚动距离越小，默认值0.0006
    });

    $("#info").on("tap",function(){
        $.get('/workflow/workLog/isSubmit', function (res) {
            if(res.code==0){
                mui.openWindow({
                    url: '/workflow/workLog/workH5Info',
                    id:'info'
                });
            }else if(res.code==10){
                layer.msg(res.msg, {icon: 0, time: 2000});
            }
        })
    });

    $(document).on('tap', '#dataUl li', function () {
        mui.openWindow({
            url: '/workflow/workLog/workH5Info?workPlanId='+$(this).attr('workPlanId'),
            id:'info',
            /*extras:{
                workPlanId:$(this).attr('workPlanId')
            }*/
        });
    })
   /* layui.use(['element','layer','transfer','form','table','laydate'],function () {
        var layer=layui.layer;
        var form = layui.form;
        var table=layui.table;
        var laydate=layui.laydate;

    })*/
    saveDate(1,1,10)
    //type 1 下拉刷新
    function saveDate(type,page,limit,fn){
        $.ajax({ //工作日志填报记录数据接口
            url:"/workflow/workLog/getWorkPlan?page="+page+"&limit="+limit,
            //data:{},
            dataType:"json",
            success:function(res){
                var _htm="";
                if(res.code===0||res.code==="0"){
                    if(res.count>0){
                        var data = res.data;
                        for(var i=0;i<data.length;i++){
                            var obj = res.data[i];
                            _htm+="<li class=\"mui-table-view-cell\" workPlanId='"+(obj.workPlanId||'')+"'>\n" +
                                "              <div class=\"mui-table\" style=\"border-bottom: 1px solid gray\">\n" +
                                "                  <div class=\"mui-table-cell mui-col-xs-10\">\n" +
                                "                      <h4 class=\"mui-ellipsis\">"+(obj.planName||'')+"</h4>\n" +
                                "                      <span class=\"mui-h5\">日期："+(obj.fillingDate||'')+"</span>\n" +
                                "                      <span class=\"mui-h5\">天气   ："+(obj.weather||'')+"</span>\n" +
                                "                      <p class=\"mui-h6 mui-ellipsis\">总结："+(obj.planSummary||'')+"</p>\n" +
                                "                  </div>\n" +
                                "                  <div class=\"mui-table-cell mui-col-xs-2 mui-text-right\">\n" +
                                "                      <span class=\"mui-h5\">"+(obj.auditerStatusStr||'')+"</span>\n" +
                                "                  </div>\n" +
                                "              </div>\n" +
                                "              <div class=\"mui-table\">\n" +
                                "                  <div class=\"mui-table-cell mui-col-xs-6\">\n" +
                                "                      <span class=\"mui-h5\">填报人："+(obj.createUserName||'')+"</span>\n" +
                                "                  </div>\n" +
                                "                  <div class=\"mui-table-cell mui-col-xs-6 mui-text-right\">\n" +
                                "                      <span class=\"mui-h5\">"+(obj.createTime||'')+"</span>\n" +
                                "                  </div>\n" +
                                "              </div>\n" +
                                "          </li>";
                        }
                    }else{
                        _htm="<li class=\"mui-table-view-cell\">\n" +
                            "              <div class=\"mui-table\" style=\"border-bottom: 1px solid gray\">\n" +
                            "                  <div class=\"mui-table-cell mui-col-xs-10\">\n" +
                            "                      <span class=\"mui-h5\">暂无数据</span>\n" +
                            "                  </div>\n" +
                            "              </div>\n" +
                            "          </li>";
                    }
                }else{
                    _htm="<li class=\"mui-table-view-cell\">\n" +
                        "              <div class=\"mui-table\" style=\"border-bottom: 1px solid gray\">\n" +
                        "                  <div class=\"mui-table-cell mui-col-xs-10\">\n" +
                        "                      <span class=\"mui-h5\">暂无数据</span>\n" +
                        "                  </div>\n" +
                        "              </div>\n" +
                        "          </li>";
                }
                if(type==1){
                    $("#dataUl").html(_htm);
                }else if(type==2){
                    $("#dataUl").append(_htm);
                }
                if(fn){
                    fn()
                }
            }
        })
    }
</script>
</body>
</html>
