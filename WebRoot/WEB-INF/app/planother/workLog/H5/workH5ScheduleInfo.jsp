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
    <title>进展填报H5</title>
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
    <div class="mui-scroll-wrapper">
        <div class="mui-scroll">
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
            <ul id="dataUl" class="mui-table-view mui-table-view-striped mui-table-view-condensed">
                <%--          <li class="mui-table-view-cell">--%>
                <%--              <div class="mui-table" style="border-bottom: 1px solid gray">--%>
                <%--                  <div class="mui-table-cell mui-col-xs-10">--%>
                <%--                      <h4 class="mui-ellipsis">2022.1.21工作日志</h4>--%>
                <%--                      <span class="mui-h5">日期：2022.1.21</span>--%>
                <%--                      <span class="mui-h5">天气   ：晴</span>--%>
                <%--                      <p class="mui-h6 mui-ellipsis">总结：总结1</p>--%>
                <%--                  </div>--%>
                <%--                  <div class="mui-table-cell mui-col-xs-2 mui-text-right">--%>
                <%--                      <button type="button" class="mui-btn mui-btn-primary">提交</button>--%>
                <%--                  </div>--%>
                <%--              </div>--%>
                <%--              <div class="mui-table">--%>
                <%--                  <div class="mui-table-cell mui-col-xs-6">--%>
                <%--                      <span class="mui-h5">填报人：张三</span>--%>
                <%--                  </div>--%>
                <%--                  <div class="mui-table-cell mui-col-xs-6 mui-text-right">--%>
                <%--                      <span class="mui-h5">2022-1-20  18:45</span>--%>
                <%--                  </div>--%>
                <%--              </div>--%>
                <%--          </li>--%>
                <%--          <li class="mui-table-view-cell">--%>
                <%--              <div class="mui-table" style="border-bottom: 1px solid gray">--%>
                <%--                  <div class="mui-table-cell mui-col-xs-10">--%>
                <%--                      <h4 class="mui-ellipsis">2022.1.21工作日志</h4>--%>
                <%--                      <span class="mui-h5">日期：2022.1.21</span>--%>
                <%--                      <span class="mui-h5">天气   ：晴</span>--%>
                <%--                      <p class="mui-h6 mui-ellipsis">总结：总结1</p>--%>
                <%--                  </div>--%>
                <%--                  <div class="mui-table-cell mui-col-xs-2 mui-text-right">--%>
                <%--                      <button type="button" class="mui-btn mui-btn-primary">提交</button>--%>
                <%--                  </div>--%>
                <%--              </div>--%>
                <%--              <div class="mui-table">--%>
                <%--                  <div class="mui-table-cell mui-col-xs-6">--%>
                <%--                      <span class="mui-h5">填报人：张三</span>--%>
                <%--                  </div>--%>
                <%--                  <div class="mui-table-cell mui-col-xs-6 mui-text-right">--%>
                <%--                      <span class="mui-h5">2022-1-20  18:45</span>--%>
                <%--                  </div>--%>
                <%--              </div>--%>
                <%--          </li>--%>
                <%--          <li class="mui-table-view-cell">--%>
                <%--              <div class="mui-table" style="border-bottom: 1px solid gray">--%>
                <%--                  <div class="mui-table-cell mui-col-xs-10">--%>
                <%--                      <h4 class="mui-ellipsis">2022.1.21工作日志</h4>--%>
                <%--                      <span class="mui-h5">日期：2022.1.21</span>--%>
                <%--                      <span class="mui-h5">天气   ：晴</span>--%>
                <%--                      <p class="mui-h6 mui-ellipsis">总结：总结1</p>--%>
                <%--                  </div>--%>
                <%--                  <div class="mui-table-cell mui-col-xs-2 mui-text-right">--%>
                <%--                      <button type="button" class="mui-btn mui-btn-primary">提交</button>--%>
                <%--                  </div>--%>
                <%--              </div>--%>
                <%--              <div class="mui-table">--%>
                <%--                  <div class="mui-table-cell mui-col-xs-6">--%>
                <%--                      <span class="mui-h5">填报人：张三</span>--%>
                <%--                  </div>--%>
                <%--                  <div class="mui-table-cell mui-col-xs-6 mui-text-right">--%>
                <%--                      <span class="mui-h5">2022-1-20  18:45</span>--%>
                <%--                  </div>--%>
                <%--              </div>--%>
                <%--          </li>--%>
                <%--          <li class="mui-table-view-cell">--%>
                <%--              <div class="mui-table" style="border-bottom: 1px solid gray">--%>
                <%--                  <div class="mui-table-cell mui-col-xs-10">--%>
                <%--                      <h4 class="mui-ellipsis">2022.1.21工作日志</h4>--%>
                <%--                      <span class="mui-h5">日期：2022.1.21</span>--%>
                <%--                      <span class="mui-h5">天气   ：晴</span>--%>
                <%--                      <p class="mui-h6 mui-ellipsis">总结：总结1</p>--%>
                <%--                  </div>--%>
                <%--                  <div class="mui-table-cell mui-col-xs-2 mui-text-right">--%>
                <%--                      <button type="button" class="mui-btn mui-btn-primary">提交</button>--%>
                <%--                  </div>--%>
                <%--              </div>--%>
                <%--              <div class="mui-table">--%>
                <%--                  <div class="mui-table-cell mui-col-xs-6">--%>
                <%--                      <span class="mui-h5">填报人：张三</span>--%>
                <%--                  </div>--%>
                <%--                  <div class="mui-table-cell mui-col-xs-6 mui-text-right">--%>
                <%--                      <span class="mui-h5">2022-1-20  18:45</span>--%>
                <%--                  </div>--%>
                <%--              </div>--%>
                <%--          </li>--%>
                <%--          <li class="mui-table-view-cell">--%>
                <%--              <div class="mui-table" style="border-bottom: 1px solid gray">--%>
                <%--                  <div class="mui-table-cell mui-col-xs-10">--%>
                <%--                      <h4 class="mui-ellipsis">2022.1.21工作日志</h4>--%>
                <%--                      <span class="mui-h5">日期：2022.1.21</span>--%>
                <%--                      <span class="mui-h5">天气   ：晴</span>--%>
                <%--                      <p class="mui-h6 mui-ellipsis">总结：总结1</p>--%>
                <%--                  </div>--%>
                <%--                  <div class="mui-table-cell mui-col-xs-2 mui-text-right">--%>
                <%--                      <button type="button" class="mui-btn mui-btn-primary">提交</button>--%>
                <%--                  </div>--%>
                <%--              </div>--%>
                <%--              <div class="mui-table">--%>
                <%--                  <div class="mui-table-cell mui-col-xs-6">--%>
                <%--                      <span class="mui-h5">填报人：张三</span>--%>
                <%--                  </div>--%>
                <%--                  <div class="mui-table-cell mui-col-xs-6 mui-text-right">--%>
                <%--                      <span class="mui-h5">2022-1-20  18:45</span>--%>
                <%--                  </div>--%>
                <%--              </div>--%>
                <%--          </li>--%>
                <%--          <li class="mui-table-view-cell">--%>
                <%--              <div class="mui-table" style="border-bottom: 1px solid gray">--%>
                <%--                  <div class="mui-table-cell mui-col-xs-10">--%>
                <%--                      <h4 class="mui-ellipsis">2022.1.21工作日志</h4>--%>
                <%--                      <span class="mui-h5">日期：2022.1.21</span>--%>
                <%--                      <span class="mui-h5">天气   ：晴</span>--%>
                <%--                      <p class="mui-h6 mui-ellipsis">总结：总结1</p>--%>
                <%--                  </div>--%>
                <%--                  <div class="mui-table-cell mui-col-xs-2 mui-text-right">--%>
                <%--                      <button type="button" class="mui-btn mui-btn-primary">提交</button>--%>
                <%--                  </div>--%>
                <%--              </div>--%>
                <%--              <div class="mui-table">--%>
                <%--                  <div class="mui-table-cell mui-col-xs-6">--%>
                <%--                      <span class="mui-h5">填报人：张三</span>--%>
                <%--                  </div>--%>
                <%--                  <div class="mui-table-cell mui-col-xs-6 mui-text-right">--%>
                <%--                      <span class="mui-h5">2022-1-20  18:45</span>--%>
                <%--                  </div>--%>
                <%--              </div>--%>
                <%--          </li>--%>
                <%--          <li class="mui-table-view-cell">--%>
                <%--              <div class="mui-table" style="border-bottom: 1px solid gray">--%>
                <%--                  <div class="mui-table-cell mui-col-xs-10">--%>
                <%--                      <h4 class="mui-ellipsis">2022.1.21工作日志</h4>--%>
                <%--                      <span class="mui-h5">日期：2022.1.21</span>--%>
                <%--                      <span class="mui-h5">天气   ：晴</span>--%>
                <%--                      <p class="mui-h6 mui-ellipsis">总结：总结1</p>--%>
                <%--                  </div>--%>
                <%--                  <div class="mui-table-cell mui-col-xs-2 mui-text-right">--%>
                <%--                      <button type="button" class="mui-btn mui-btn-primary">提交</button>--%>
                <%--                  </div>--%>
                <%--              </div>--%>
                <%--              <div class="mui-table">--%>
                <%--                  <div class="mui-table-cell mui-col-xs-6">--%>
                <%--                      <span class="mui-h5">填报人：张三</span>--%>
                <%--                  </div>--%>
                <%--                  <div class="mui-table-cell mui-col-xs-6 mui-text-right">--%>
                <%--                      <span class="mui-h5">2022-1-20  18:45</span>--%>
                <%--                  </div>--%>
                <%--              </div>--%>
                <%--          </li>--%>
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

    // window.addEventListener('refresh', function(e){//执行刷新
    //     location.reload();
    // });
    (function($$) {

        // $("#info").on("tap",function(){
        //     mui.openWindow({
        //         url: '/workflow/workLog/workH5Info',
        //         id:'info'
        //     });
        // });

        mui('.mui-scroll-wrapper').scroll({
            indicators: true //是否显示滚动条
        });

        // $$('.mui-scroll-wrapper').scroll({
        //     indicators: true //是否显示滚动条
        // });

        // $(document).on('click tap', '#dataUl li', function () {
        //     mui.openWindow({
        //         url: '/workflow/workLog/workH5Info?workPlanId='+$(this).attr('workPlanId'),
        //         id:'info',
        //         /*extras:{
        //             workPlanId:$(this).attr('workPlanId')
        //         }*/
        //     });
        // })

        //保存
        $(".preservation").on("tap",function(){
            // saveAllData()
        });

        //确定
        $(".determine").on("tap",function(){
            mui.back()
        });
        $("#info").on("tap",function(){
            mui.back()
        });


        mui.init({
            swipeBack:true, //启用右滑关闭功能
        });
        /*mui.plusReady(function(){
            // 在这里调用plus api

            //获得父页面的webview
            var list = plus.webview.currentWebview().opener();
            //触发父页面的自定义事件(refresh),从而进行刷新
            mui.fire(list, 'refresh');
            //返回true,继续页面关闭逻辑
            return true;
        });*/

    })(mui);

    layui.use(['element','layer','transfer','form','table','laydate'],function () {
        var layer=layui.layer;
        var form = layui.form;
        var table=layui.table;
        var laydate=layui.laydate;
        $.ajax({ //工作日志填报记录数据接口
            url:"/workflow/workLog/getWorkPlan?page=1&limit=10",
            //data:{},
            dataType:"json",
            success:function(res){
                var _htm="";
                if(res.code===0||res.code==="0"){
                    if(res.count>0){
                        var data = res.data;
                        for(var i=0;i<data.length;i++){
                            var obj = res.data[i];
                            _htm+="<li class=\"mui-table-view-cell\" workPlanId='"+obj.workPlanId+"'>\n" +
                                "              <div class=\"mui-table\" style=\"border-bottom: 1px solid gray\">\n" +
                                "                  <div class=\"mui-table-cell mui-col-xs-10\">\n" +
                                "                      <h4 class=\"mui-ellipsis\">"+obj.planName+"</h4>\n" +
                                "                      <span class=\"mui-h5\">日期："+obj.fillingDate+"</span>\n" +
                                "                      <span class=\"mui-h5\">天气   ："+obj.weather+"</span>\n" +
                                "                      <p class=\"mui-h6 mui-ellipsis\">总结："+obj.planSummary+"</p>\n" +
                                "                  </div>\n" +
                                "                  <div class=\"mui-table-cell mui-col-xs-2 mui-text-right\">\n" +
                                "                      <span class=\"mui-h5\">"+obj.auditerStatusStr+"</span>\n" +
                                "                  </div>\n" +
                                "              </div>\n" +
                                "              <div class=\"mui-table\">\n" +
                                "                  <div class=\"mui-table-cell mui-col-xs-6\">\n" +
                                "                      <span class=\"mui-h5\">填报人："+obj.createUserName+"</span>\n" +
                                "                  </div>\n" +
                                "                  <div class=\"mui-table-cell mui-col-xs-6 mui-text-right\">\n" +
                                "                      <span class=\"mui-h5\">"+obj.createTime+"</span>\n" +
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
                $("#dataUl").html(_htm);
            }
        })
    })
</script>
</body>
</html>
