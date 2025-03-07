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
    <%-- <meta charset="UTF-8">
     <meta charset="utf-8">--%>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <%--    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">--%>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>工作日志H5(详情)</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20190817.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>
    <link rel="stylesheet" href="../../lib/mui/mui/mui.picker.min.css" />

    <%--    <link rel="stylesheet" href="../../lib/easyUpload/easy_upload.min.css" />--%>

    <script type="text/javascript" src="../../js/notes/jquery-2.1.2.min.js" ></script>
    <script src="/lib/jquery.form.min.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>

    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <script type="text/javascript" src="../../lib/mui/mui/mui.picker.min.js" ></script>

    <script src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918.09" type="text/javascript" charset="utf-8"></script>
    <%--    <script type="text/javascript" src="../../lib/easyUpload/easyUpload.min.js" ></script>--%>

    <%--    <script type="text/javascript" src="/js/planother/planotherUtil.js?221202108301508"></script>--%>


    <style>
        /** { touch-action: none; }*/
        html,body{
            background: #fff;
            font-size: 17px;
            line-height: 21px;
            -webkit-overflow-scrolling: touch;
            width: 100%;
        }

        .mui-control-content {
            background-color: white;
            /*min-height: 215px;*/
        }
        .mui-control-content .mui-loading {
            margin-top: 50px;
        }

        #slider{
            touch-action: none;
        }
        .mui-content select,.layui-layer select{
            border: 1px solid rgba(0,0,0,.2) !important;
        }

        .mui-table-view-condensed > .mui-table-view-cell{
            border-bottom: 10px solid #e4e4e4;
        }
        .mui-table-view-condensed > .mui-table-view-cell:nth-last-of-type(1){
            border-bottom: none;
        }


        .mui-popover {
            /*height: 135px;*/
            height: 45px;
            width: 60px;
        }
        #middlePopover{
            position: fixed;
            /*left: 0px;*/
            right: 50px;
            top: 250px;
            /*bottom: 0px;*/
            margin: auto;
        }
        #middlePopover button{
            width: 100%;
            margin: 5px auto;
        }
        #middlePopover .mui-popover-arrow{
            top: -25px;
            left: 25px;
        }

        .field_required {
            color: red;
            font-size: 16px;
        }

        .todayAddDetails,.tomorrowAddDetails,.resourcesAddDetails {
            padding:0;
            margin:10px auto;
            width: 50%;
        }
        /*.mui-content .mui-slider{*/
        /*    height: 100%;*/
        /*}*/

        .isShow{
            display: none;
        }
        .left{
            display: inline-block;
            width: 70%;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            margin: -4px;
        }
        .more,.arrowright {
            float: right;
            margin-right: 30px;
        }
    </style>
</head>
<body>
<div class="mui-content _disabled">
    <input type="hidden" id="leftId">
    <div class="mui-scroll-wrapper">
        <div class="mui-scroll">
            <!--这里放置真实显示的DOM内容-->
            <ul class="mui-table-view mui-table-view-striped mui-table-view-condensed">
                <%--          基本信息--%>
                <li class="mui-table-view-cell">
                    <div class="mui-table" style="border-bottom: 1px solid gray">
                        <div class="mui-table-cell mui-col-xs-6">
                            <h4 class="mui-ellipsis">日期</h4>
                        </div>
                        <div class="mui-table-cell mui-col-xs-6 mui-text-right">
                            <span class="mui-h5 fillingDate"></span>
                        </div>
                    </div>
                    <div class="mui-table" style="border-bottom: 1px solid gray">
                        <div class="mui-table-cell mui-col-xs-6">
                            <h4 class="mui-ellipsis">天气</h4>
                        </div>
                        <div class="mui-table-cell mui-col-xs-6 mui-text-right">
                            <span class="mui-h5 weather"></span>
                        </div>
                    </div>
                    <div class="mui-table" style="border-bottom: 1px solid gray">
                        <div class="mui-table-cell mui-col-xs-6">
                            <h4 class="mui-ellipsis">编制人</h4>
                        </div>
                        <div class="mui-table-cell mui-col-xs-6 mui-text-right">
                            <span class="mui-h5 createUserName"></span>
                        </div>
                    </div>
                    <div class="mui-table" style="border-bottom: 1px solid gray">
                        <div class="mui-table-cell mui-col-xs-12">
                            <h4 class="mui-ellipsis">总结</h4>
                            <textarea class="summary" name="planSummary" rows="4" placeholder="请填写"></textarea>
                        </div>
                    </div>
                </li>
                <%--    进展填报--%>
                <li class="mui-table-view-cell">
                    <div class="mui-table" style="border-bottom: 1px solid gray">
                        <div class="mui-table-cell mui-col-xs-12">
                            <h4 class="mui-ellipsis">进展填报</h4>
                        </div>
                    </div>
                    <ul class="mui-table-view" id="scheduleUl">
                        <%--                <li class="mui-table-view-cell mui-collapse">--%>
                        <%--                    <a class="mui-navigate-right" href="#">面板1</a>--%>
                        <%--                    <div class="mui-collapse-content">--%>
                        <%--                        <div class="mui-table" style="border-bottom: 1px solid gray">--%>
                        <%--                            <div class="mui-table-cell mui-col-xs-4">--%>
                        <%--                                <h5 class="mui-ellipsis">任务名称</h5>--%>
                        <%--                            </div>--%>
                        <%--                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">--%>
                        <%--                                <input type="text" class="mui-input-clear" placeholder="请填写内容">--%>
                        <%--                            </div>--%>
                        <%--                        </div>--%>
                        <%--                        <div class="mui-table" style="border-bottom: 1px solid gray">--%>
                        <%--                            <div class="mui-table-cell mui-col-xs-4" style="border-bottom: 1px solid gray">--%>
                        <%--                                <h5 class="mui-ellipsis">*进展日期</h5>--%>
                        <%--                            </div>--%>
                        <%--                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">--%>
                        <%--                                <input type="text" id="recordDate" class="mui-input-clear" placeholder="请选择日期">--%>
                        <%--                            </div>--%>
                        <%--                        </div>--%>
                        <%--                        <div class="mui-table" style="border-bottom: 1px solid gray">--%>
                        <%--                            <div class="mui-table-cell mui-col-xs-4">--%>
                        <%--                                <h5 class="mui-ellipsis" style="position: absolute">*进展情况</h5>--%>
                        <%--                            </div>--%>
                        <%--                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">--%>
                        <%--                                <textarea class="summary" rows="2" placeholder="请填写"></textarea>--%>
                        <%--                            </div>--%>
                        <%--                        </div>--%>
                        <%--                        <div class="mui-table" style="border-bottom: 1px solid gray">--%>
                        <%--                            <div class="mui-table-cell mui-col-xs-4">--%>
                        <%--                                <h5 class="mui-ellipsis">*进展百分比</h5>--%>
                        <%--                            </div>--%>
                        <%--                            <div class="mui-table-cell mui-col-xs-7 mui-text-right">--%>
                        <%--                                <div class="mui-input-row mui-input-range field-contain">--%>
                        <%--                                    <div>--%>
                        <%--                                        <input type="range" id='field-range' value="60" min="0" max="100" step="10" />--%>
                        <%--                                        &lt;%&ndash;                              <span class="mui-h5" id='field-range-input'>60</span>&ndash;%&gt;--%>
                        <%--                                    </div>--%>
                        <%--                                    &lt;%&ndash;<div style="float:right">--%>
                        <%--                                        <input type="text" id='field-range-input' value='60'>--%>
                        <%--                                    </div>&ndash;%&gt;--%>
                        <%--                                </div>--%>
                        <%--                            </div>--%>
                        <%--                            <div class="mui-table-cell mui-col-xs-1 mui-text-right">--%>
                        <%--                                <span class="mui-h5" id='field-range-input'>60</span>--%>
                        <%--                            </div>--%>
                        <%--                        </div>--%>
                        <%--                        <div class="mui-table" style="border-bottom: 1px solid gray">--%>
                        <%--                            <div class="mui-table-cell mui-col-xs-4">--%>
                        <%--                                <h5 class="mui-ellipsis">成果</h5>--%>
                        <%--                            </div>--%>
                        <%--                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">--%>
                        <%--                                <input type="text" class="mui-input-clear" placeholder="请添加">--%>
                        <%--                            </div>--%>
                        <%--                        </div>--%>
                        <%--                    </div>--%>
                        <%--                </li>--%>
                    </ul>
                </li>
                <%--    昨日计划今日完成--%>
                <li class="mui-table-view-cell">
                    <div class="mui-table" style="border-bottom: 1px solid gray">
                        <div class="mui-table-cell mui-col-xs-12">
                            <h4 class="mui-ellipsis">昨日计划今日完成</h4>
                        </div>
                    </div>
                    <ul class="mui-table-view" id="yestdayUl">

                    </ul>
                </li>
                <%--            今日其他工作--%>
                <li class="mui-table-view-cell">
                    <div class="mui-table" style="border-bottom: 1px solid gray">
                        <div class="mui-table-cell mui-col-xs-12">
                            <h4 class="mui-ellipsis">今日其他工作</h4>
                        </div>
                    </div>
                    <div id="slider" class="mui-slider">
                        <div id="sliderSegmentedControl" class="mui-slider-indicator mui-segmented-control mui-segmented-control-inverted">
                            <a class="mui-control-item" href="#item1mobile">
                                工作
                            </a>
                            <a class="mui-control-item" href="#item2mobile">
                                资源
                            </a>
                        </div>
                        <div id="sliderProgressBar" class="mui-slider-progress-bar mui-col-xs-6"></div>
                        <%--                <div id="sliderProgressBar" class="mui-slider-progress-bar mui-col-xs-12"></div>--%>
                        <div class="mui-slider-group">
                            <div id="item1mobile" class="mui-slider-item mui-control-content mui-active">
                                <%--                        <div id="scroll1" class="mui-scroll-wrapper">--%>
                                <%--                            <div class="mui-scroll">--%>
                                <ul class="mui-table-view" id="todyWorkUl">

                                </ul>
                                <div class="mui-table disaplayNone">
                                    <div class="mui-table-cell mui-col-xs-12">
                                        <button type="button" class="mui-btn mui-btn-block mui-btn-outlined todayAddDetails" style="color: #13d4ed;">+添加明细</button>
                                    </div>
                                </div>
                                <%--                            </div>--%>
                                <%--                        </div>--%>
                            </div>
                            <div id="item2mobile" class="mui-slider-item mui-control-content">
                                <%--                        <div id="scroll2" class="mui-scroll-wrapper">--%>
                                <%--                            <div class="mui-scroll">--%>
                                <%--                                <div class="mui-loading">--%>
                                <%--                                    <div class="mui-spinner">--%>
                                <%--                                    </div>--%>
                                <%--                                </div>--%>
                                <ul class="mui-table-view" id="resources">

                                </ul>
                                <div class="mui-table disaplayNone">
                                    <div class="mui-table-cell mui-col-xs-12">
                                        <button type="button" class="mui-btn mui-btn-block mui-btn-outlined resourcesAddDetails" style="color: #13d4ed;">+添加明细</button>
                                    </div>
                                </div>
                                <%--                            </div>--%>
                                <%--                        </div>--%>

                            </div>
                        </div>
                    </div>

                </li>
                <%--            明日工作安排--%>
                <li class="mui-table-view-cell">
                    <div class="mui-table" style="border-bottom: 1px solid gray">
                        <div class="mui-table-cell mui-col-xs-12">
                            <h4 class="mui-ellipsis">明日工作安排</h4>
                        </div>
                    </div>
                    <ul class="mui-table-view" id="tomorrowWorkUl">

                    </ul>
                    <div class="mui-table disaplayNone" style="border-bottom: 1px solid gray">
                        <div class="mui-table-cell mui-col-xs-12">
                            <button type="button" class="mui-btn mui-btn-block mui-btn-outlined tomorrowAddDetails" style="color: #13d4ed;">+添加明细</button>
                        </div>
                    </div>

                </li>

                <li class="mui-table-view-cell">
                    <div class="mui-table" style="padding: 20px">
                        <div class="mui-table-cell mui-col-xs-6 disaplayNone" style="text-align: center">
                            <button type="button" class="mui-btn mui-btn-primary mui-btn-outlined info preservation">
                                保存
                            </button>
                        </div>
                        <div class="mui-table-cell mui-col-xs-6 disaplayNone" style="text-align: center">
                            <button type="button" class="mui-btn mui-btn-primary mui-btn-outlined info submit">
                                提交
                            </button>
                        </div>
                        <div class="mui-table-cell mui-col-xs-6 disaplayShow" style="text-align: center;display: none">
                            <button type="button" class="mui-btn mui-btn-primary mui-btn-outlined info determine">
                                确定
                            </button>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>

</div>

<div id="middlePopover" class="mui-popover">
    <div class="mui-popover-arrow"></div>
    <div class="">
        <ul>
            <li>
                <button type="button" class="mui-btn mui-btn-danger mui-btn-outlined del">删除</button>
            </li>
            <%--            <li>--%>
            <%--                <button type="button" class="mui-btn btn-primary mui-btn-outlined">删除</button>--%>
            <%--            </li>--%>
            <%--            <li>--%>
            <%--                <button type="button" class="mui-btn btn-success mui-btn-outlined">删除</button>--%>
            <%--            </li>--%>
        </ul>
    </div>

</div>

<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>

<script type="text/javascript">
    (function($$) {

        var _thisDom = ''

        /* window.addEventListener('touchmove', function(e) {
             var target = e.target;
             if (target && target.tagName === 'TEXTAREA') {//textarea阻止冒泡
                 e.stopPropagation();
             }
         }, true);*/

        // form.render("select");//初始化表单


        //判断进度填报的每一个是不是都改了完成百分比，不然就给出提示“有进展还未填报是否确认保存或提交”
        $(document).on('input propertychange', '[name="percentComplete"]', function () {
            if($(this).val()!=$(this).attr('percentComplete')){
                $(this).attr('flag',true)
            }else {
                $(this).attr('flag','')
            }
        })
        //判断昨日计划今日完成的那个完成状态是不是都改了，有一个没改就提示“昨日任务还未填报是否保存或提交”
        $(document).on('input propertychange', '[name="completionStatus"]', function () {
            if($(this).val()!=$(this).attr('completionStatus')){
                $(this).attr('flag',true)
                $(this).parents('.mui-collapse').find('.isShow').show()
            }else {
                $(this).attr('flag','')
                $(this).parents('.mui-collapse').find('.isShow').hide()
            }
        })


        //保存
        $(".preservation").on("tap",function btap(){
            saveAllData()
            // window.location.href="/workflow/workLog/workLogH5Index"
            // $(".preservation").unbind('tap')

            /*setTimeout(function(){
                $('.preservation').bind('tap',btap)
            },3000)*/
        });
        //提交
        $(".submit").on("tap",function(){
            saveAllData(true)
        });

        //确定
        $(".determine").on("tap",function(){
            mui.back()
        });
        /*$(".info").on("tap",function(){
            mui.back()
        });*/

        $(document).on('tap', '.recordDate,.recordBeginDate', function () {
            var that = this
            var picker = new mui.DtPicker({
                type:'date',
                labels: ['年', '月', '日'],//设置默认标签区域提示语
            });
            picker.show(function(rs) {
                $(that).val(rs.text)
                picker.dispose();
            });
            $('.mui-dtpicker .mui-btn').html('取消');
            $('.mui-dtpicker .mui-btn-blue').html('确定');
        });

        var _this = null
        $(document).on("tap",'.more',function(e){
            $('#middlePopover').css('left',$(this).offset().left-24)
            $('#middlePopover').css('top',$(this).offset().top+24)

            _this = this
            mui('#middlePopover').popover('toggle');
        })
        // mui('.mui-scroll-wrapper').scroll();
        // mui('body').on('shown', '.mui-popover', function(e) {
        //     console.log('shown', e.detail.id);//detail为当前popover元素
        // });
        // mui('body').on('hidden', '.mui-popover', function(e) {
        //     console.log('hidden', e.detail.id);//detail为当前popover元素
        //     console.log(e.detail);
        //     console.log(e);
        // });

        //进展填报跳转
        /* $(document).on('tap', '#scheduleUl .arrowright', function () {
             mui.openWindow({
                 url: '/workflow/workLog/workH5ScheduleInfo?scheduleId='+$(this).attr('scheduleId'),
                 id:'scheduleUl'
             });
         })*/

        //删除
        $(document).on("tap",'.del',function(){
            delFun(_this)
            mui('#middlePopover').popover('hide');
        })

        mui.init({
            swipeBack:true, //启用右滑关闭功能
            /* beforeback: function(){
                 alert(1)
                 //获得列表界面的webview
                 var list = plus.webview.currentWebview().opener();
                 //触发列表界面的自定义事件（refresh）,从而进行数据刷新
                 alert(list)
                 mui.fire(list,'refresh2');
                 //返回true，继续页面关闭逻辑
                 // return true;
             }*/
        });

        /*document.addEventListener("plusready",function(){
            var list = plus.webview.currentWebview().opener();
        });*/

        // mui.plusReady(function(){
        //     layer.confirm('测试？', function (index) {
        //
        //     })
        //     // 在这里调用plus api
        //     alert(1)
        //     //获得父页面的webview
        //     var list = plus.webview.currentWebview().opener();
        //     //触发父页面的自定义事件(refresh),从而进行刷新
        //     mui.fire(list, 'refresh');
        //     //返回true,继续页面关闭逻辑
        //     return true;
        // });


        //监听input事件，获取range的value值，也可以直接element.value获取该range的值
        $(document).on("input",'input[type="range"]',function(){
            $(this).parents('.field-range').next().find('span').text($(this).val())
        })
        /* $(document).on("input",'#field-range-input',function(){
             $('#field-range').val($(this).val())
         })*/

        $$('.mui-scroll-wrapper').scroll({
            indicators: true //是否显示滚动条
        });
        /*var html2 = '<ul class="mui-table-view"><li class="mui-table-view-cell">第二个选项卡子项-1</li><li class="mui-table-view-cell">第二个选项卡子项-2</li><li class="mui-table-view-cell">第二个选项卡子项-3</li><li class="mui-table-view-cell">第二个选项卡子项-4</li><li class="mui-table-view-cell">第二个选项卡子项-5</li></ul>';
        document.getElementById('slider').addEventListener('slide', function(e) {
            if (e.detail.slideNumber === 1) {
                if ($('#item2mobile .mui-loading').length>0) {
                    setTimeout(function() {
                        $('#item2mobile .mui-scroll').html(html2)
                    }, 500);
                }
            }
        });*/
    })(mui);

    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
    }


    layui.use(['element','layer','element','form','table','laydate'],function () {
        var layer=layui.layer;
        var form = layui.form;
        var element = layui.element;
        var table=layui.table;
        var laydate=layui.laydate;

        var optionStr = '<option value="">请选择</option>';
        $.ajax({
            //查询文档等级
            url: '/Dictonary/selectDictionaryByNo?dictNo=RESOURCES_TYPE',
            type: 'get',
            dataType: 'json',
            async:false,
            success: function (res) {
                var data=res.data
                if(data!=undefined&&data.length>0){
                    for(var i=0;i<data.length;i++){
                        //if(data[i].dictNo==dataa.testTypeNo){
                        optionStr += '<option value="' + data[i].dictNo + '">' + data[i].dictName + '</option>'
                        //}else{
                        //    optionStr += '<option value="' + data[i].dictNo + '">' + data[i].dictName + '</option>'
                        //}
                    }
                }
            }
        })

        var _url = '/workflow/workLog/insertWorkPlan'
        if(getUrlParam('workPlanId')){
            _url += '?workPlanId='+getUrlParam('workPlanId')
        }

        $.ajax({ //工作日志填报初始化接口
            url:_url,
            dataType:"json",
            success:function(res){
                if(res.code===0||res.code==="0"){
                    var workPlanId = res.obj;//获取工作计划主表id
                    var _edit = res.object
                    $('#leftId').attr('workPlanId',workPlanId)

                    $.ajax({ //基本信息
                        url:"/workflow/workLog/getWorkPlanById?workPlanId="+workPlanId,
                        dataType:"json",
                        success:function(res){
                            //渲染日期
                            if(res.obj&&res.obj.fillingDate){
                                $('.fillingDate').text(res.obj.fillingDate)
                            }else {
                                $('.fillingDate').text(getNowFormatDate('-'))
                            }

                            //渲染天气
                            if(res.obj&&res.obj.weather){
                                $('.weather').text(res.obj.weather)
                            }

                            //渲染编制人
                            if(res.obj&&res.obj.createUserName){
                                $('.createUserName').text(res.obj.createUserName)
                            }

                            if(res.obj&&res.obj.fillingDate){
                                $('[name="planSummary" ]').text(res.obj.planSummary)
                            }

                        }
                    })

                    $.ajax({ //工作日志填报-昨日工作数据接口
                        url:"/workflow/workLog/getYestdayWork?workTypes=2&planId="+workPlanId,
                        dataType:"json",
                        success:function(res){
                            var _htm="";
                            var all_htm = ''
                            if(res.code===0||res.code==="0"){
                                if(res.data&&res.data.length>0){
                                    for(var i=0;i<res.data.length;i++){
                                        var todyObj = res.data[i];
                                        var img_add1 = ''
                                        if(todyObj.attachmentList){
                                            img_add1 = imgadd1('','','3',todyObj.attachmentList)
                                        }
                                        var new_time = new Date().getTime()
                                        _htm+= '<li class="mui-table-view-cell mui-collapse" synchroStatus="'+(todyObj.synchroStatus?todyObj.synchroStatus:"y"+(new_time+i))+'">\n' +
                                            '                    <a class="mui-navigate-right" href="#"><span class="left">'+(todyObj.jobContent||"")+'</span><span class="isShow" style="'+(todyObj.editedFlag=="1"?"display:inline-block":"")+'">(已填报)<span></a>\n' +
                                            '                    <div class="mui-collapse-content">\n' +
                                            '                        <div class="mui-table" style="border-bottom: 1px solid gray;">\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-4">\n' +
                                            '                                <h5 class="mui-ellipsis">工作内容</h5>\n' +
                                            '                            </div>\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                                <input type="text" name="jobContent" value="'+(todyObj.jobContent||"")+'" disabled class="mui-input-clear" placeholder="请填写内容">\n' +
                                            '                            </div>\n' +
                                            '                        </div>\n' +
                                            '                        <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-4">\n' +
                                            '                                <h5 class="mui-ellipsis" style="position: absolute">说明</h5>\n' +
                                            '                            </div>\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                                <textarea class="summary" name="explain" logId="'+(todyObj.logId||'')+'"  disabled rows="2" placeholder="请填写">'+(todyObj.explain||"")+'</textarea>\n' +
                                            '                            </div>\n' +
                                            '                        </div>' +
                                            '                        <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-4">\n' +
                                            '                                <h5 class="mui-ellipsis" style="position: absolute">备注</h5>\n' +
                                            '                            </div>\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                                <textarea class="summary" name="memo"  rows="2" placeholder="请填写">'+(todyObj.explain||"")+'</textarea>\n' +
                                            '                            </div>\n' +
                                            '                        </div>' +
                                            '                        <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-4">\n' +
                                            '                                <h5 class="mui-ellipsis"><span field="completionStatus" class="field_required">*</span>完成状态</h5>\n' +
                                            '                            </div>\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                                <select name="completionStatus" completionStatus="'+(_edit&&todyObj.editedFlag=="0"?"":todyObj.completionStatus)+'" flag="" >\n' +
                                            '                                    <option value="">请选择</option>\n' +
                                            '                                    <option '+(_edit&&todyObj.editedFlag=="0"?"": (todyObj.completionStatus&&todyObj.completionStatus==0?'selected':""))+ ' value="0">完成</option>\n' +
                                            '                                    <option '+(_edit&&todyObj.editedFlag=="0"?"": (todyObj.completionStatus&&todyObj.completionStatus==1?'selected':""))+ ' value="1">部分完成</option>\n' +
                                            '                                    <option '+(_edit&&todyObj.editedFlag=="0"?"": (todyObj.completionStatus&&todyObj.completionStatus==10?'selected':""))+' value="10">未启动</option>\n' +
                                            '                                </select>\n' +
                                            '                            </div>\n' +
                                            '                        </div>\n' +
                                            '                        <div class="mui-table">\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-4">\n' +
                                            '                                <h5 class="mui-ellipsis">附件</h5>\n' +
                                            '                            </div>\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                                <%--                                                    <input type="text" class="mui-input-clear" placeholder="请添加">--%>\n' +
                                            '\n' +
                                            '                                <div style="position: relative">\n' +
                                            '                                    <div style="position: relative">\n' +
                                            '                                        <a href="javascript:;" class="xzbtn upload" style="height: 32px;line-height: 32px;font-size: 16px;color: #01adff;position: absolute;top: 20px;left: 5px"  id="upload">上传附件</a>\n' +
                                            '                                    </div>\n' +
                                            '\n' +
                                            '                                </div>\n' +
                                            '                                <div style="width: 100%;height: 45px;" class="choose_box">\n' +
                                            '                                    <div style="width: 100%;text-align: center">\n' +
                                            '                                        <%--<img class="choosewj" src="/img/workflow/work/choose_img.png" alt="" onclick="btn1()" style="height:46px;width: 100%;margin-bottom: 40px">--%>\n' +
                                            '                                        <%--            <span class="xzbtn" style="display: none;padding: 13px 80px;background: #3b87f5;font-size: 16px;font-weight: bold; border-radius: 40px;color:#fff;" onclick="btn1()">选择文件</span>--%>\n' +
                                            '                                        <form id="uploadimgform" style="display:none;" target="uploadiframe" action="/upload?module=workflow"  enctype="multipart/form-data" method="post" >\n' +
                                            '                                            <input type="file"  name="file" id="uploadinputimg" uploadType="1" multiple class="w-icon5">\n' +
                                            '                                        </form>\n' +
                                            '                                    </div>\n' +
                                            '                                </div>\n' +
                                            '                            </div>\n' +
                                            '                        </div>\n' +
                                            '\n' +
                                            '                        <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                            '                            <div style="margin-top: 10px">\n' +
                                            '                                <div>\n' +
                                            '                                    <ul class="uploadbox">\n' +
                                            '\n' +
                                            '                                    </ul>\n' +
                                            '                                </div>\n' +
                                            '                                <div class="photo_box">\n' + img_add1+
                                            '\n' +
                                            '                                </div>\n' +
                                            '                            </div>\n' +
                                            '                        </div>\n' +
                                            '                    </div>\n' +
                                            '                </li>';

                                        if(todyObj&&todyObj.addTommorFlag=="add"&&todyObj.completionStatus!=0){
                                            var _htm2 = '<li class="mui-table-view-cell mui-collapse" logOldId="'+(todyObj.logId||'')+'" synchroStatus="y'+(new_time+i)+'" >\n' +
                                                '                    <a class="mui-navigate-right" href="#"><span class="left">'+(todyObj.jobContent||"")+'</span></a>\n' +
                                                '                    <div class="mui-collapse-content">\n' +
                                                '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                                '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                                                '                               <h5 class="mui-ellipsis"><span field="jobContent" class="field_required">*</span>工作内容</h5>\n' +
                                                '                           </div>\n' +
                                                '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                                '                               <input type="text" name="jobContent" disabled style="background: #e7e7e7" value="'+(todyObj.jobContent||"")+'" class="mui-input-clear" placeholder="请填写内容">\n' +
                                                '                           </div>\n' +
                                                '                       </div>\n' +
                                                '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                                '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                                                '                               <h5 class="mui-ellipsis" style="position: absolute">说明</h5>\n' +
                                                '                           </div>\n' +
                                                '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                                '                               <textarea class="summary" name="explain" disabled style="background: #e7e7e7" rows="2" placeholder="请填写">'+(todyObj.explain||"")+'</textarea>\n' +
                                                '                           </div>\n' +
                                                '                       </div>\n' +
                                                /*'                       <div class="mui-table">\n' +
                                                '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                                                '                               <h5 class="mui-ellipsis">附件</h5>\n' +
                                                '                           </div>\n' +
                                                '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                                '                               <%--                                                    <input type="text" class="mui-input-clear" placeholder="请添加">--%>\n' +
                                                '\n' +
                                                '                               <div style="position: relative">\n' +
                                                '                                   <div style="position: relative">\n' +
                                                '                                       <a href="javascript:;" class="xzbtn upload" style="height: 32px;line-height: 32px;font-size: 16px;color: #01adff;position: absolute;top: 20px;left: 5px"  id="upload">上传附件</a>\n' +
                                                '                                   </div>\n' +
                                                '\n' +
                                                '                               </div>\n' +
                                                '                               <div style="width: 100%;height: 45px;" class="choose_box">\n' +
                                                '                                   <div style="width: 100%;text-align: center">\n' +
                                                '                                       <%--<img class="choosewj" src="/img/workflow/work/choose_img.png" alt="" onclick="btn1()" style="height:46px;width: 100%;margin-bottom: 40px">--%>\n' +
                                                '                                       <%--            <span class="xzbtn" style="display: none;padding: 13px 80px;background: #3b87f5;font-size: 16px;font-weight: bold; border-radius: 40px;color:#fff;" onclick="btn1()">选择文件</span>--%>\n' +
                                                '                                       <form id="uploadimgform" style="display:none;" target="uploadiframe" action="/upload?module=workflow"  enctype="multipart/form-data" method="post" >\n' +
                                                '                                           <input type="file"  name="file" id="uploadinputimg" uploadType="1" multiple class="w-icon5">\n' +
                                                '                                       </form>\n' +
                                                '                                   </div>\n' +
                                                '                               </div>\n' +
                                                '                           </div>\n' +
                                                '                       </div>\n' +
                                                '\n' +
                                                '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                                '                           <div style="margin-top: 10px">\n' +
                                                '                               <div>\n' +
                                                '                                   <ul class="uploadbox">\n' +
                                                '\n' +
                                                '                                   </ul>\n' +
                                                '                               </div>\n' +
                                                '                               <div class="photo_box">\n' +
                                                '\n' +
                                                '                               </div>\n' +
                                                '                           </div>\n' +
                                                '                       </div>\n' +*/
                                                '                    </div>\n' +
                                                '                </li>';
                                            all_htm+=_htm2
                                        }
                                    }
                                }
                            }
                            $("#yestdayUl").append(_htm);
                            $('#tomorrowWorkUl').append(all_htm)
                            if(!_edit){
                                $('._disabled [name]').attr('disabled', 'disabled');
                                $('.upload').hide()
                            }

                        }
                    })
                    $.ajax({ //工作日志填报-今日其他工作数据接口
                        url:"/workflow/workLog/getTodyWork?planId="+workPlanId,
                        dataType:"json",
                        success:function(res){
                            var _htm="";
                            var all_htm = ''
                            if(res.code===0||res.code==="0"){
                                if(res.data&&res.data.length>0){
                                    for(var i=0;i<res.data.length;i++){
                                        var todyObj = res.data[i];
                                        var img_add1 = ''
                                        if(todyObj.attachmentList){
                                            img_add1 = imgadd1('','','3',todyObj.attachmentList)
                                        }
                                        var new_time = new Date().getTime()
                                        _htm+= '<li class="mui-table-view-cell mui-collapse" synchroStatus="t'+(new_time+i)+'" tsynchroStatus="'+(todyObj.synchroStatus||'')+'">\n' +
                                            '                    <a class="mui-navigate-right" href="#"><span class="left">'+(todyObj.jobContent||"")+'</span><span class="mui-icon mui-icon-more more" logId="'+(todyObj.logId||'')+'" judgeState="today"></span></a>\n' +
                                            '                    <div class="mui-collapse-content">\n' +
                                            '                        <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-4">\n' +
                                            '                                <h5 class="mui-ellipsis"><span field="jobContent" class="field_required">*</span>工作内容</h5>\n' +
                                            '                            </div>\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                                <input type="text" name="jobContent" value="'+(todyObj.jobContent||"")+'" class="mui-input-clear" placeholder="请填写内容">\n' +
                                            '                            </div>\n' +
                                            '                        </div>\n' +
                                            '                        <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-4">\n' +
                                            '                                <h5 class="mui-ellipsis"><span field="completionStatus" class="field_required">*</span>完成状态</h5>\n' +
                                            '                            </div>\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                                <select name="completionStatus">\n' +
                                            '                                    <option value="">请选择</option>\n' +
                                            '                                    <option '+(todyObj.completionStatus&&todyObj.completionStatus==0?'selected':"")+ ' value="0">完成</option>\n' +
                                            '                                    <option '+(todyObj.completionStatus&&todyObj.completionStatus==1?'selected':"")+ ' value="1">部分完成</option>\n' +
                                            '                                    <option '+(todyObj.completionStatus&&todyObj.completionStatus==10?'selected':"")+' value="10">未启动</option>\n' +
                                            '                                </select>\n' +
                                            '                            </div>\n' +
                                            '                        </div>\n' +
                                            '                        <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-4">\n' +
                                            '                                <h5 class="mui-ellipsis" style="position: absolute">说明</h5>\n' +
                                            '                            </div>\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                                <textarea class="summary" name="explain" logId="'+(todyObj.logId||"")+'"  workPlanId="'+(todyObj.workPlanId||"")+'" rows="2" placeholder="请填写">'+(todyObj.explain||"")+'</textarea>\n' +
                                            '                            </div>\n' +
                                            '                        </div>' +
                                            '                        <div class="mui-table">\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-4">\n' +
                                            '                                <h5 class="mui-ellipsis">附件</h5>\n' +
                                            '                            </div>\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                                <%--                                                    <input type="text" class="mui-input-clear" placeholder="请添加">--%>\n' +
                                            '\n' +
                                            '                                <div style="position: relative">\n' +
                                            '                                    <div style="position: relative">\n' +
                                            '                                        <a href="javascript:;" class="xzbtn upload" style="height: 32px;line-height: 32px;font-size: 16px;color: #01adff;position: absolute;top: 20px;left: 5px"  id="upload">上传附件</a>\n' +
                                            '                                    </div>\n' +
                                            '\n' +
                                            '                                </div>\n' +
                                            '                                <div style="width: 100%;height: 45px;" class="choose_box">\n' +
                                            '                                    <div style="width: 100%;text-align: center">\n' +
                                            '                                        <%--<img class="choosewj" src="/img/workflow/work/choose_img.png" alt="" onclick="btn1()" style="height:46px;width: 100%;margin-bottom: 40px">--%>\n' +
                                            '                                        <%--            <span class="xzbtn" style="display: none;padding: 13px 80px;background: #3b87f5;font-size: 16px;font-weight: bold; border-radius: 40px;color:#fff;" onclick="btn1()">选择文件</span>--%>\n' +
                                            '                                        <form id="uploadimgform" style="display:none;" target="uploadiframe" action="/upload?module=workflow"  enctype="multipart/form-data" method="post" >\n' +
                                            '                                            <input type="file"  name="file" id="uploadinputimg" uploadType="1" multiple class="w-icon5">\n' +
                                            '                                        </form>\n' +
                                            '                                    </div>\n' +
                                            '                                </div>\n' +
                                            '                            </div>\n' +
                                            '                        </div>\n' +
                                            '\n' +
                                            '                        <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                            '                            <div style="margin-top: 10px">\n' +
                                            '                                <div>\n' +
                                            '                                    <ul class="uploadbox">\n' +
                                            '\n' +
                                            '                                    </ul>\n' +
                                            '                                </div>\n' +
                                            '                                <div class="photo_box">\n' +  img_add1 +
                                            '\n' +
                                            '                                </div>\n' +
                                            '                            </div>\n' +
                                            '                        </div>\n' +
                                            '                    </div>\n' +
                                            '                </li>';

                                        if(todyObj&&todyObj.addTommorFlag=="add"&&todyObj.completionStatus!=0){
                                            var _htm2 = '<li class="mui-table-view-cell mui-collapse" logOldId="'+(todyObj.logId||'')+'" synchroStatus="t'+(new_time+i)+'" >\n' +
                                                '                    <a class="mui-navigate-right" href="#"><span class="left">'+(todyObj.jobContent||"")+'</span></a>\n' +
                                                '                    <div class="mui-collapse-content">\n' +
                                                '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                                '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                                                '                               <h5 class="mui-ellipsis"><span field="jobContent" class="field_required">*</span>工作内容</h5>\n' +
                                                '                           </div>\n' +
                                                '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                                '                               <input type="text" name="jobContent" disabled style="background: #e7e7e7" value="'+(todyObj.jobContent||"")+'" class="mui-input-clear" placeholder="请填写内容">\n' +
                                                '                           </div>\n' +
                                                '                       </div>\n' +
                                                '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                                '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                                                '                               <h5 class="mui-ellipsis" style="position: absolute">说明</h5>\n' +
                                                '                           </div>\n' +
                                                '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                                '                               <textarea class="summary" name="explain" disabled style="background: #e7e7e7" rows="2" placeholder="请填写">'+(todyObj.explain||"")+'</textarea>\n' +
                                                '                           </div>\n' +
                                                '                       </div>\n' +
                                                /*'                       <div class="mui-table">\n' +
                                                '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                                                '                               <h5 class="mui-ellipsis">附件</h5>\n' +
                                                '                           </div>\n' +
                                                '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                                '                               <%--                                                    <input type="text" class="mui-input-clear" placeholder="请添加">--%>\n' +
                                                '\n' +
                                                '                               <div style="position: relative">\n' +
                                                '                                   <div style="position: relative">\n' +
                                                '                                       <a href="javascript:;" class="xzbtn upload" style="height: 32px;line-height: 32px;font-size: 16px;color: #01adff;position: absolute;top: 20px;left: 5px"  id="upload">上传附件</a>\n' +
                                                '                                   </div>\n' +
                                                '\n' +
                                                '                               </div>\n' +
                                                '                               <div style="width: 100%;height: 45px;" class="choose_box">\n' +
                                                '                                   <div style="width: 100%;text-align: center">\n' +
                                                '                                       <%--<img class="choosewj" src="/img/workflow/work/choose_img.png" alt="" onclick="btn1()" style="height:46px;width: 100%;margin-bottom: 40px">--%>\n' +
                                                '                                       <%--            <span class="xzbtn" style="display: none;padding: 13px 80px;background: #3b87f5;font-size: 16px;font-weight: bold; border-radius: 40px;color:#fff;" onclick="btn1()">选择文件</span>--%>\n' +
                                                '                                       <form id="uploadimgform" style="display:none;" target="uploadiframe" action="/upload?module=workflow"  enctype="multipart/form-data" method="post" >\n' +
                                                '                                           <input type="file"  name="file" id="uploadinputimg" uploadType="1" multiple class="w-icon5">\n' +
                                                '                                       </form>\n' +
                                                '                                   </div>\n' +
                                                '                               </div>\n' +
                                                '                           </div>\n' +
                                                '                       </div>\n' +
                                                '\n' +
                                                '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                                '                           <div style="margin-top: 10px">\n' +
                                                '                               <div>\n' +
                                                '                                   <ul class="uploadbox">\n' +
                                                '\n' +
                                                '                                   </ul>\n' +
                                                '                               </div>\n' +
                                                '                               <div class="photo_box">\n' +
                                                '\n' +
                                                '                               </div>\n' +
                                                '                           </div>\n' +
                                                '                       </div>\n' +*/
                                                '                    </div>\n' +
                                                '                </li>';
                                            all_htm+=_htm2
                                        }

                                    }
                                }
                            }
                            $("#todyWorkUl").append(_htm);
                            $('#tomorrowWorkUl').append(all_htm)
                            if(!_edit){
                                $('.more').hide()
                                $('._disabled [name]').attr('disabled', 'disabled');
                                $('.upload').hide()
                            }

                            /*if(res.code===0||res.code==="0") {
                                if (res.data && res.data.length > 0) {
                                    for (var i = 0; i < res.data.length; i++) {
                                        var todyObj = res.data[i];
                                        $("#a"+todyObj.logId).val(todyObj.explain);
                                    }
                                }
                            }*/
                        }
                    })
                    $.ajax({ //工作日志填报-今日其他工作 资源数据接口
                        url:"/workflow/workLog/getResources?planId="+workPlanId,
                        dataType:"json",
                        success:function(res){
                            var _htm="";
                            if(res.code===0||res.code==="0"){
                                if(res.data&&res.data.length>0){
                                    for(var i=0;i<res.data.length;i++){
                                        var todyObj = res.data[i];
                                        var img_add1 = ''
                                        if(todyObj.attachmentList){
                                            img_add1 = imgadd1('','','3',todyObj.attachmentList)
                                        }
                                        _htm += '<li class="mui-table-view-cell mui-collapse">\n' +
                                            '                    <a class="mui-navigate-right " href="#"><span class="left">'+(todyObj.resourceName||"")+'</span><span class="mui-icon mui-icon-more more" detailsId="'+(todyObj.detailsId||'')+'" judgeState="resources"></span></a>\n' +
                                            '                    <div class="mui-collapse-content">\n' +
                                            '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                            '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                                            '                               <h5 class="mui-ellipsis"><span field="resourceName" class="field_required">*</span>资源名称</h5>\n' +
                                            '                           </div>\n' +
                                            '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                               <input type="text" name="resourceName" value="'+(todyObj.resourceName||"")+'" class="mui-input-clear" placeholder="请填写内容">\n' +
                                            '                           </div>\n' +
                                            '                       </div>\n' +
                                            '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                            '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                                            '                               <h5 class="mui-ellipsis"><span field="resourceType" class="field_required">*</span>资源类型</h5>\n' +
                                            '                           </div>\n' +
                                            '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                               <select name="resourceType" id="detailsId'+(todyObj.detailsId||"")+'">\n' +optionStr+
                                            /*'                                   <option value="">请选择</option>\n' +
                                            '                                   <option value="0">完成</option>\n' +
                                            '                                   <option value="1">部分完成</option>\n' +
                                            '                                   <option value="10">未启动</option>\n' +*/
                                            '                               </select>\n' +
                                            '                           </div>\n' +
                                            '                       </div>\n' +
                                            '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                            '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                                            '                               <h5 class="mui-ellipsis">数量</h5>\n' +
                                            '                           </div>\n' +
                                            '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                               <input type="number" name="resourcesNumber" value="'+(todyObj.resourcesNumber||"")+'" class="mui-input-clear" placeholder="请填写">\n' +
                                            '                           </div>\n' +
                                            '                       </div>\n' +
                                            '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                            '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                                            '                               <h5 class="mui-ellipsis" style="position: absolute">说明</h5>\n' +
                                            '                           </div>\n' +
                                            '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                               <textarea class="summary" name="explain" detailsId="'+(todyObj.detailsId||"")+'"  workPlanId="'+(todyObj.workPlanId||"")+'" rows="2" placeholder="请填写">'+(todyObj.explain||"")+'</textarea>\n' +
                                            '                           </div>\n' +
                                            '                       </div>\n' +
                                            '                        <div class="mui-table">\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-4">\n' +
                                            '                                <h5 class="mui-ellipsis">附件</h5>\n' +
                                            '                            </div>\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                                <%--                                                    <input type="text" class="mui-input-clear" placeholder="请添加">--%>\n' +
                                            '\n' +
                                            '                                <div style="position: relative">\n' +
                                            '                                    <div style="position: relative">\n' +
                                            '                                        <a href="javascript:;" class="xzbtn upload" style="height: 32px;line-height: 32px;font-size: 16px;color: #01adff;position: absolute;top: 20px;left: 5px"  id="upload">上传附件</a>\n' +
                                            '                                    </div>\n' +
                                            '\n' +
                                            '                                </div>\n' +
                                            '                                <div style="width: 100%;height: 45px;" class="choose_box">\n' +
                                            '                                    <div style="width: 100%;text-align: center">\n' +
                                            '                                        <%--<img class="choosewj" src="/img/workflow/work/choose_img.png" alt="" onclick="btn1()" style="height:46px;width: 100%;margin-bottom: 40px">--%>\n' +
                                            '                                        <%--            <span class="xzbtn" style="display: none;padding: 13px 80px;background: #3b87f5;font-size: 16px;font-weight: bold; border-radius: 40px;color:#fff;" onclick="btn1()">选择文件</span>--%>\n' +
                                            '                                        <form id="uploadimgform" style="display:none;" target="uploadiframe" action="/upload?module=workflow"  enctype="multipart/form-data" method="post" >\n' +
                                            '                                            <input type="file"  name="file" id="uploadinputimg" uploadType="1" multiple class="w-icon5">\n' +
                                            '                                        </form>\n' +
                                            '                                    </div>\n' +
                                            '                                </div>\n' +
                                            '                            </div>\n' +
                                            '                        </div>\n' +
                                            '\n' +
                                            '                        <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                            '                            <div style="margin-top: 10px">\n' +
                                            '                                <div>\n' +
                                            '                                    <ul class="uploadbox">\n' +
                                            '\n' +
                                            '                                    </ul>\n' +
                                            '                                </div>\n' +
                                            '                                <div class="photo_box">\n' +  img_add1 +
                                            '\n' +
                                            '                                </div>\n' +
                                            '                            </div>\n' +
                                            '                        </div>\n' +
                                            '                    </div>\n' +
                                            '                </li>';

                                    }
                                }
                            }
                            $("#resources").append(_htm);
                            if(!_edit){
                                $('.more').hide()
                                $('._disabled [name]').attr('disabled', 'disabled');
                                $('.upload').hide()
                            }

                            if (res.data && res.data.length > 0) {
                                for (var i = 0; i < res.data.length; i++) {
                                    var todyObj = res.data[i];
                                    $("#detailsId"+todyObj.detailsId).val(todyObj.resourceType);
                                }
                            }
                        }
                    })
                    // $.ajax({ //工作日志填报-资源情况数据接口
                    //     url:"/workflow/workLog/insertWorkPlan",
                    //     dataType:"json",
                    //     success:function(res){
                    //         if(res.code===0||res.code==="0"){
                    //             var workPlanId = res.obj;//获取工作计划主表id
                    //
                    //         }
                    //     }
                    // })
                    $.ajax({ //工作日志填报-明日其他工作接口
                        url:"/workflow/workLog/getTomorrowWork?planId="+workPlanId,
                        dataType:"json",
                        success:function(res){
                            var _htm="";
                            if(res.code===0||res.code==="0"){
                                if(res.data&&res.data.length>0){
                                    for(var i=0;i<res.data.length;i++){
                                        var todyObj = res.data[i];
                                        var img_add1 = ''
                                        if(todyObj.attachmentList){
                                            img_add1 = imgadd1('','','3',todyObj.attachmentList)
                                        }
                                        _htm+= '<li class="mui-table-view-cell mui-collapse" synchroStatus="'+(todyObj.synchroStatus||"")+'">\n' +
                                            '                    <a class="mui-navigate-right" href="#"><span class="left">'+(todyObj.jobContent||"")+'</span><span class="mui-icon mui-icon-more more '+(todyObj.logOldId?'isShow':'')+'" logId="'+(todyObj.logId||'')+'" judgeState="tomorrow"></span></a>\n' +
                                            '                    <div class="mui-collapse-content">\n' +
                                            '                        <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-4">\n' +
                                            '                                <h5 class="mui-ellipsis"><span field="jobContent" class="field_required">*</span>工作内容</h5>\n' +
                                            '                            </div>\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                                <input type="text" name="jobContent" value="'+(todyObj.jobContent||"")+'" '+(todyObj.logOldId?'disabled style="background: #e7e7e7"':"")+'  class="mui-input-clear" placeholder="请填写内容">\n' +
                                            '                            </div>\n' +
                                            '                        </div>\n' +
                                            '                        <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-4">\n' +
                                            '                                <h5 class="mui-ellipsis" style="position: absolute">说明</h5>\n' +
                                            '                            </div>\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                                <textarea class="summary" name="explain" logId="'+(todyObj.logId||'')+'" workPlanId="'+(todyObj.workPlanId||"")+'" '+(todyObj.logOldId?'disabled style="background: #e7e7e7"':"")+' rows="2" placeholder="请填写">'+(todyObj.explain||"")+'</textarea>\n' +
                                            '                            </div>\n' +
                                            '                        </div>' +
                                            '                        <div class="mui-table '+(todyObj.logOldId?'isShow':'')+'">\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-4">\n' +
                                            '                                <h5 class="mui-ellipsis">附件</h5>\n' +
                                            '                            </div>\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                                <%--                                                    <input type="text" class="mui-input-clear" placeholder="请添加">--%>\n' +
                                            '\n' +
                                            '                                <div style="position: relative">\n' +
                                            '                                    <div style="position: relative">\n' +
                                            '                                        <a href="javascript:;" class="xzbtn upload" style="height: 32px;line-height: 32px;font-size: 16px;color: #01adff;position: absolute;top: 20px;left: 5px"  id="upload">上传附件</a>\n' +
                                            '                                    </div>\n' +
                                            '\n' +
                                            '                                </div>\n' +
                                            '                                <div style="width: 100%;height: 45px;" class="choose_box">\n' +
                                            '                                    <div style="width: 100%;text-align: center">\n' +
                                            '                                        <%--<img class="choosewj" src="/img/workflow/work/choose_img.png" alt="" onclick="btn1()" style="height:46px;width: 100%;margin-bottom: 40px">--%>\n' +
                                            '                                        <%--            <span class="xzbtn" style="display: none;padding: 13px 80px;background: #3b87f5;font-size: 16px;font-weight: bold; border-radius: 40px;color:#fff;" onclick="btn1()">选择文件</span>--%>\n' +
                                            '                                        <form id="uploadimgform" style="display:none;" target="uploadiframe" action="/upload?module=workflow"  enctype="multipart/form-data" method="post" >\n' +
                                            '                                            <input type="file"  name="file" id="uploadinputimg" uploadType="1" multiple class="w-icon5">\n' +
                                            '                                        </form>\n' +
                                            '                                    </div>\n' +
                                            '                                </div>\n' +
                                            '                            </div>\n' +
                                            '                        </div>\n' +
                                            '\n' +
                                            '                        <div class="mui-table '+(todyObj.logOldId?'isShow':'')+'" style="border-bottom: 1px solid gray">\n' +
                                            '                            <div style="margin-top: 10px">\n' +
                                            '                                <div>\n' +
                                            '                                    <ul class="uploadbox">\n' +
                                            '\n' +
                                            '                                    </ul>\n' +
                                            '                                </div>\n' +
                                            '                                <div class="photo_box">\n' + img_add1 +
                                            '\n' +
                                            '                                </div>\n' +
                                            '                            </div>\n' +
                                            '                        </div>\n' +
                                            '                    </div>\n' +
                                            '                </li>';
                                    }
                                }
                            }
                            $("#tomorrowWorkUl").append(_htm);
                            if(!_edit){
                                $('.more').hide()
                                $('._disabled [name]').attr('disabled', 'disabled');
                                $('.upload').hide()
                            }

                            /* if(res.code===0||res.code==="0") {
                                 if (res.data && res.data.length > 0) {
                                     for (var i = 0; i < res.data.length; i++) {
                                         var todyObj = res.data[i];
                                         $("#c"+todyObj.logId).val(todyObj.explain);
                                     }
                                 }
                             }*/
                        }
                    })
                    $.ajax({ //工作日志填报进度数据接口
                        url:"/procedureSchedule/select?isClose=02&delFlag=0&isApp=isApp&dataFormStr=3&byUser=byUser&sBeginDate=sBeginDate&haveParent=haveParent&workPlanId="+workPlanId,
                        //data:{},
                        dataType:"json",
                        success:function(res){
                            var _htm="";
                            if(res.code===0||res.code==="0"){
                                if(res.data&&res.data.length>0){
                                    var data = res.data;
                                    for(var i=0;i<data.length;i++){
                                        var obj = res.data[i];
                                        var img_add1 = ''
                                        if(obj.record&&obj.record.attachmentList){
                                            img_add1 = imgadd1('','','3',obj.record&&obj.record.attachmentList)
                                        }
                                        _htm+='<li class="mui-table-view-cell mui-collapse">\n' +
                                            '                    <a class="mui-navigate-right" href="#">'+(obj.longName||"")+'<span class="mui-icon mui-icon-arrowright arrowright '+(obj&&obj.child&&obj.child.length>0?"":"isShow")+'" scheduleId="'+(obj.scheduleId||"")+'" ></span></a>\n' +
                                            '                    <div class="mui-collapse-content">\n' +
                                            '                        <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-4">\n' +
                                            '                                <h5 class="mui-ellipsis">任务名称</h5>\n' +
                                            '                            </div>\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                                <input type="text" style="background: #e7e7e7" disabled value="'+(obj.scheduleName||'')+'"  placeholder="请填写内容">\n' +
                                            '                            </div>\n' +
                                            '                        </div>\n' +
                                            '                        <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-4" style="border-bottom: 1px solid gray">\n' +
                                            '                                <h5 class="mui-ellipsis"><span field="recordBeginDate" class="field_required">*</span>进展开始时间</h5>\n' +
                                            '                            </div>\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                                <input type="text"  name="recordBeginDate" style="'+(obj.record&&obj.record.editBeginDate&&obj.record.editBeginDate=="edit"?'':'background: #e7e7e7')+'" class="mui-input-clear recordBeginDate" '+(obj.record&&obj.record.editBeginDate&&obj.record.editBeginDate=="edit"?'':'disabled')+'  value="'+(obj.record&&obj.record.recordBeginDate?obj.record.recordBeginDate:'')+'" placeholder="请选择日期">\n' +
                                            '                            </div>\n' +
                                            '                        </div>\n' +
                                            '                        <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-4" style="border-bottom: 1px solid gray">\n' +
                                            '                                <h5 class="mui-ellipsis"><span field="recordDate" class="field_required">*</span>进展日期</h5>\n' +
                                            '                            </div>\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                                <input type="text"  name="recordDate" class="mui-input-clear recordDate" value="'+(obj.record&&obj.record.recordDate?obj.record.recordDate:'')+'" placeholder="请选择日期">\n' +
                                            '                            </div>\n' +
                                            '                        </div>\n' +
                                            '                        <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-4">\n' +
                                            '                                <h5 class="mui-ellipsis" style="position: absolute">进展情况</h5>\n' +
                                            '                            </div>\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                                <textarea scheduleId="'+(obj.scheduleId||"")+'" workScheduleId="'+(obj.workScheduleId||"")+'" scheduleRecordId="'+(obj.record&&obj.record.scheduleRecordId?obj.record.scheduleRecordId:'')+'" workPlanId="'+(obj.workPlanId||"")+'" name="recordProgress"  class="summary" rows="2" placeholder="请填写">'+((obj.record&&obj.record.recordProgress)||'')+'</textarea>\n' +
                                            '                            </div>\n' +
                                            '                        </div>\n' +
                                            '                        <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-4">\n' +
                                            '                                <h5 class="mui-ellipsis"><span field="percentComplete" class="field_required">*</span>进展百分比</h5>\n' +
                                            '                            </div>\n' +
                                            '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                               <select name="percentComplete" flag="" percentComplete="'+(obj.record&&obj.record.percentComplete?obj.record.percentComplete:0)+'">\n' +
                                            '                                    <option value="">请选择</option>\n' +
                                            '                                    <option '+(obj.record&&obj.record.percentComplete&&obj.record.percentComplete==10?'selected':"")+ ' value="10">10</option>\n' +
                                            '                                    <option '+(obj.record&&obj.record.percentComplete&&obj.record.percentComplete==20?'selected':"")+ ' value="20">20</option>\n' +
                                            '                                    <option '+(obj.record&&obj.record.percentComplete&&obj.record.percentComplete==30?'selected':"")+ ' value="30">30</option>\n' +
                                            '                                    <option '+(obj.record&&obj.record.percentComplete&&obj.record.percentComplete==40?'selected':"")+ ' value="40">40</option>\n' +
                                            '                                    <option '+(obj.record&&obj.record.percentComplete&&obj.record.percentComplete==50?'selected':"")+ ' value="50">50</option>\n' +
                                            '                                    <option '+(obj.record&&obj.record.percentComplete&&obj.record.percentComplete==60?'selected':"")+ ' value="60">60</option>\n' +
                                            '                                    <option '+(obj.record&&obj.record.percentComplete&&obj.record.percentComplete==70?'selected':"")+ ' value="70">70</option>\n' +
                                            '                                    <option '+(obj.record&&obj.record.percentComplete&&obj.record.percentComplete==80?'selected':"")+ ' value="80">80</option>\n' +
                                            '                                    <option '+(obj.record&&obj.record.percentComplete&&obj.record.percentComplete==90?'selected':"")+ ' value="90">90</option>\n' +
                                            '                                    <option '+(obj.record&&obj.record.percentComplete&&obj.record.percentComplete==100?'selected':"")+' value="100">100</option>\n' +
                                            '                               </select>\n' +
                                            '                           </div>\n' +
                                            /*'                            <div class="mui-table-cell mui-col-xs-7 mui-text-right field-range">\n' +
                                            '                                <div class="mui-input-row mui-input-range field-contain">\n' +
                                            '                                    <div>\n' +
                                            '                                        <input type="range"  name="percentComplete" flag="" percentComplete="'+(obj.record&&obj.record.percentComplete?obj.record.percentComplete:0)+'" value="'+(obj.record&&obj.record.percentComplete?obj.record.percentComplete:0)+'" min="0" max="100" step="25" />\n' +
                                            '                                        <%--<span class="mui-h5" id=\'field-range-input\'>60</span>--%>\n' +
                                            '                                    </div>\n' +
                                            '                                    <%--<div style="float:right">\n'+
'                                        <input type="text" id=\'field-range-input\' value=\'60\'>\n'+
'                                    </div>--%>\n' +
                                            '                                </div>\n' +
                                            '                            </div>\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-1 mui-text-right">\n' +
                                            '                                <span class="mui-h5" class=\'field-range-input\'>'+(obj.record&&obj.record.percentComplete?obj.record.percentComplete:0)+'</span>\n' +
                                            '                            </div>\n' +*/
                                            '                        </div>\n' +
                                            '                        <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                            '                            <div class="mui-table-cell mui-col-xs-4">\n' +
                                            '                                <h5 class="mui-ellipsis">成果</h5>\n' +
                                            '                            </div>\n' +
                                            /*'                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                                <input type="text" class="mui-input-clear" placeholder="请添加">\n' +
                                            '                            </div>\n' +*/
                                            '                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                                            '                                <%--                                                    <input type="text" class="mui-input-clear" placeholder="请添加">--%>\n' +
                                            '\n' +
                                            '                                <div style="position: relative">\n' +
                                            '                                    <div style="position: relative">\n' +
                                            '                                        <a href="javascript:;" class="xzbtn upload" style="height: 32px;line-height: 32px;font-size: 16px;color: #01adff;position: absolute;top: 20px;left: 5px"  id="upload">上传附件</a>\n' +
                                            '                                    </div>\n' +
                                            '\n' +
                                            '                                </div>\n' +
                                            '                                <div style="width: 100%;height: 45px;" class="choose_box">\n' +
                                            '                                    <div style="width: 100%;text-align: center">\n' +
                                            '                                        <%--<img class="choosewj" src="/img/workflow/work/choose_img.png" alt="" onclick="btn1()" style="height:46px;width: 100%;margin-bottom: 40px">--%>\n' +
                                            '                                        <%--            <span class="xzbtn" style="display: none;padding: 13px 80px;background: #3b87f5;font-size: 16px;font-weight: bold; border-radius: 40px;color:#fff;" onclick="btn1()">选择文件</span>--%>\n' +
                                            '                                        <form id="uploadimgform" style="display:none;" target="uploadiframe" action="/upload?module=workflow"  enctype="multipart/form-data" method="post" >\n' +
                                            '                                            <input type="file"  name="file" id="uploadinputimg" uploadType="1" multiple class="w-icon5">\n' +
                                            '                                        </form>\n' +
                                            '                                    </div>\n' +
                                            '                                </div>\n' +
                                            '                            </div>\n' +
                                            '                        </div>\n' +
                                            '                        <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                                            '                            <div style="margin-top: 10px">\n' +
                                            '                                <div>\n' +
                                            '                                    <ul class="uploadbox">\n' + img_add1 +
                                            '\n' +
                                            '                                    </ul>\n' +
                                            '                                </div>\n' +
                                            '                                <div class="photo_box">\n' +
                                            '\n' +
                                            '                                </div>\n' +
                                            '                            </div>\n' +
                                            '                        </div>\n' +
                                            '                    </div>\n' +
                                            '                </li>';
                                    }
                                }else{
                                    _htm="";
                                }
                            }else{
                                _htm="";
                            }
                            $("#scheduleUl").append(_htm);

                            if(!_edit){
                                $('._disabled [name]').attr('disabled', 'disabled');
                                $('.upload').hide()
                            }

                            /*if(res.code===0||res.code==="0") {
                                if (res.count > 0) {
                                    var data = res.data;
                                    for (var i = 0; i < data.length; i++) {
                                        var obj = res.data[i];
                                        if(obj.record&&obj.record.recordProgress){
                                            $("#a"+obj.scheduleId).val(obj.record.recordProgress);
                                        }
                                    }
                                }
                            }*/
                        }
                    })

                    if(!_edit){
                        $('._disabled [name]').attr('disabled', 'disabled');
                        $('.disaplayNone').hide()
                        $('.disaplayShow').show()
                        $('.more').hide()
                        $('.upload').hide()
                    }
                }
            }
        })



        //今日
        $(document).on('tap', '.todayAddDetails', function () {
            var _htm = '<li class="mui-table-view-cell mui-collapse mui-active">\n' +
                '                    <a class="mui-navigate-right " href="#"><span class="left"></span><span class="mui-icon mui-icon-more more" judgeState="today"></span></a>\n' +
                '                    <div class="mui-collapse-content">\n' +
                '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                '                               <h5 class="mui-ellipsis"><span field="jobContent" class="field_required">*</span>工作内容</h5>\n' +
                '                           </div>\n' +
                '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                '                               <input type="text" name="jobContent" class="mui-input-clear" placeholder="请填写内容">\n' +
                '                           </div>\n' +
                '                       </div>\n' +
                '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                '                               <h5 class="mui-ellipsis"><span field="completionStatus" class="field_required">*</span>完成状态</h5>\n' +
                '                           </div>\n' +
                '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                '                               <select name="completionStatus">\n' +
                '                                   <option value="">请选择</option>\n' +
                '                                   <option value="0">完成</option>\n' +
                '                                   <option value="1">部分完成</option>\n' +
                '                                   <option value="10">未启动</option>\n' +
                '                               </select>\n' +
                '                           </div>\n' +
                '                       </div>\n' +
                '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                '                               <h5 class="mui-ellipsis" style="position: absolute">说明</h5>\n' +
                '                           </div>\n' +
                '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                '                               <textarea class="summary" name="explain" rows="2" placeholder="请填写"></textarea>\n' +
                '                           </div>\n' +
                '                       </div>\n' +
                '                        <div class="mui-table">\n' +
                '                            <div class="mui-table-cell mui-col-xs-4">\n' +
                '                                <h5 class="mui-ellipsis">附件</h5>\n' +
                '                            </div>\n' +
                '                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                '                                <%--                                                    <input type="text" class="mui-input-clear" placeholder="请添加">--%>\n' +
                '\n' +
                '                                <div style="position: relative">\n' +
                '                                    <div style="position: relative">\n' +
                '                                        <a href="javascript:;" class="xzbtn upload" style="height: 32px;line-height: 32px;font-size: 16px;color: #01adff;position: absolute;top: 20px;left: 5px"  id="upload">上传附件</a>\n' +
                '                                    </div>\n' +
                '\n' +
                '                                </div>\n' +
                '                                <div style="width: 100%;height: 45px;" class="choose_box">\n' +
                '                                    <div style="width: 100%;text-align: center">\n' +
                '                                        <%--<img class="choosewj" src="/img/workflow/work/choose_img.png" alt="" onclick="btn1()" style="height:46px;width: 100%;margin-bottom: 40px">--%>\n' +
                '                                        <%--            <span class="xzbtn" style="display: none;padding: 13px 80px;background: #3b87f5;font-size: 16px;font-weight: bold; border-radius: 40px;color:#fff;" onclick="btn1()">选择文件</span>--%>\n' +
                '                                        <form id="uploadimgform" style="display:none;" target="uploadiframe" action="/upload?module=workflow"  enctype="multipart/form-data" method="post" >\n' +
                '                                            <input type="file"  name="file" id="uploadinputimg" uploadType="1" multiple class="w-icon5">\n' +
                '                                        </form>\n' +
                '                                    </div>\n' +
                '                                </div>\n' +
                '                            </div>\n' +
                '                        </div>\n' +
                '\n' +
                '                        <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                '                            <div style="margin-top: 10px">\n' +
                '                                <div>\n' +
                '                                    <ul class="uploadbox">\n' +
                '\n' +
                '                                    </ul>\n' +
                '                                </div>\n' +
                '                                <div class="photo_box">\n' +
                '\n' +
                '                                </div>\n' +
                '                            </div>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                </li>';
            $('#todyWorkUl').append(_htm)
            /*layer.open({
                type: 1,
                title: '添加明细',
                area: ['100%', '100%'],
                btn: ['确定','取消'],
                btnAlign: 'c',
                content:  '<div class="mui-table-view-cell onePopup">\n' +
                    '               <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                    '                   <div class="mui-table-cell mui-col-xs-4">\n' +
                    '                       <h5 class="mui-ellipsis"><span field="jobContent" class="field_required">*</span>工作内容</h5>\n' +
                    '                   </div>\n' +
                    '                   <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                    '                       <input type="text" name="jobContent" class="mui-input-clear" placeholder="请填写内容">\n' +
                    '                   </div>\n' +
                    '               </div>\n' +
                    '               <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                    '                   <div class="mui-table-cell mui-col-xs-4">\n' +
                    '                       <h5 class="mui-ellipsis"><span field="completionStatus" class="field_required">*</span>完成状态</h5>\n' +
                    '                   </div>\n' +
                    '                   <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                    '                       <select name="completionStatus">\n' +
                    '                           <option value="">请选择</option>\n' +
                    '                           <option value="0">完成</option>\n' +
                    '                           <option value="1">部分完成</option>\n' +
                    '                           <option value="10">未启动</option>\n' +
                    '                       </select>\n' +
                    '                   </div>\n' +
                    '               </div>\n' +
                    '               <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                    '                   <div class="mui-table-cell mui-col-xs-4">\n' +
                    '                       <h5 class="mui-ellipsis" style="position: absolute">说明</h5>\n' +
                    '                   </div>\n' +
                    '                   <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                    '                       <textarea class="summary" name="explain" rows="2" placeholder="请填写"></textarea>\n' +
                    '                   </div>\n' +
                    '               </div>\n' +
                    '               <div class="mui-table">\n' +
                    '                   <div class="mui-table-cell mui-col-xs-4">\n' +
                    '                       <h5 class="mui-ellipsis">附件</h5>\n' +
                    '                   </div>\n' +
                    '                   <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                   '\n' +
                    '                       <div style="position: relative">\n' +
                    '                           <div style="position: relative">\n' +
                    '                               <a href="javascript:;" class="xzbtn upload" style="height: 32px;line-height: 32px;font-size: 16px;color: #01adff;position: absolute;top: 20px;left: 5px"  id="upload">上传附件</a>\n' +
                    '                           </div>\n' +
                    '\n' +
                    '                       </div>\n' +
                    '                       <div style="width: 100%;height: 45px;" class="choose_box">\n' +
                    '                           <div style="width: 100%;text-align: center">\n' +
                    '                               <form id="uploadimgform" style="display:none;" target="uploadiframe" action="/upload?module=workflow"  enctype="multipart/form-data" method="post" >\n' +
                    '                                   <input type="file"  name="file" id="uploadinputimg" uploadType="1" multiple class="w-icon5">\n' +
                    '                               </form>\n' +
                    '                           </div>\n' +
                    '                       </div>\n' +
                    '                   </div>\n' +
                    '               </div>\n' +
                    '\n' +
                    '               <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                    '                   <div style="margin-top: 10px">\n' +
                    '                       <div>\n' +
                    '                           <ul class="uploadbox">\n' +
                    '\n' +
                    '                           </ul>\n' +
                    '                       </div>\n' +
                    '                       <div class="photo_box">\n' +
                    '\n' +
                    '                       </div>\n' +
                    '                   </div>\n' +
                    '               </div>\n' +
                    '       </div>',
                success: function () {

                    form.render();
                },
                yes: function (index) {
                    var _html = '<li class="mui-table-view-cell mui-collapse">\n' +
                        '           <a class="mui-navigate-right" href="#">' +$('.onePopup [name="jobContent"]').val()+
                        '           </a>\n' +
                        '           <div class="mui-collapse-content">\n' +$('.onePopup').html()+
                        '           </div>\n' +
                        '       </li>';

                    $('#todyWorkUl').append(_html)

                    $('#todyWorkUl li:last [name="jobContent"]').val($('.onePopup [name="jobContent"]').val())
                    $('#todyWorkUl li:last [name="completionStatus"]').val($('.onePopup [name="completionStatus"]').val())
                    $('#todyWorkUl li:last [name="explain"]').val($('.onePopup [name="explain"]').val())

                    layer.close(index);
                }

            });*/
        })

        $(document).on('input propertychange', '[name="jobContent"]', function () {
            $(this).parents('.mui-collapse-content').prev().find('.left').text($(this).val())

            var that = $(this).parents('#todyWorkUl li')

            var _jobContent = $(this).val()||''
            if($('#tomorrowWorkUl [synchroStatus="'+$(that).attr('synchroStatus')+'"]').length==1){
                $('#tomorrowWorkUl [synchroStatus="'+$(that).attr('synchroStatus')+'"]').find('[name="jobContent"]').val(_jobContent)
                $('#tomorrowWorkUl [synchroStatus="'+$(that).attr('synchroStatus')+'"] .left').text($(this).val())
            }

        })
        $(document).on('input propertychange', '[name="explain"]', function () {
            var that = $(this).parents('#todyWorkUl li')

            var _explain = $(this).val()||''
            if($('#tomorrowWorkUl [synchroStatus="'+$(that).attr('synchroStatus')+'"]').length==1){
                $('#tomorrowWorkUl [synchroStatus="'+$(that).attr('synchroStatus')+'"]').find('[name="explain"]').val(_explain)
            }

        })
        $(document).on('input propertychange', '[name="completionStatus"]', function () {
            var that = null
            if($(this).parents('#todyWorkUl li').length>0){
                that = $(this).parents('#todyWorkUl li')
            }else if($(this).parents('#yestdayUl li').length>0){
                that = $(this).parents('#yestdayUl li')
            }else{
                return
            }

            if($(this).val()=='0'){
                $('#tomorrowWorkUl [synchroStatus="'+$(that).attr('synchroStatus')+'"]').remove()
            }else {
                $('#tomorrowWorkUl [synchroStatus="'+$(that).attr('synchroStatus')+'"]').remove()
                var _jobContent = $(that).find('[name="jobContent"]').val()||''
                var _explain = $(that).find('[name="explain"]').val()||''
                if($('[synchroStatus="'+$(that).attr('synchroStatus')+'"]').parents('#tomorrowWorkUl li').attr('synchroStatus')){
                    $('#tomorrowWorkUl [synchroStatus="'+$(that).attr('synchroStatus')+'"]').find('[name="jobContent"]').val(_jobContent)
                    $('#tomorrowWorkUl [synchroStatus="'+$(that).attr('synchroStatus')+'"]').find('[name="explain"]').val(_explain)
                }else {
                    var new_time = new Date().getTime()
                    $(that).attr('synchroStatus',new_time)
                    var _htm = '<li class="mui-table-view-cell mui-collapse" logOldId="'+($(that).find('[name="explain"]').attr('logId')||'')+'" synchroStatus="'+new_time+'" >\n' +
                        '                    <a class="mui-navigate-right" href="#"><span class="left">'+_jobContent+'</span></a>\n' +
                        '                    <div class="mui-collapse-content">\n' +
                        '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                        '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                        '                               <h5 class="mui-ellipsis"><span field="jobContent" class="field_required">*</span>工作内容</h5>\n' +
                        '                           </div>\n' +
                        '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                        '                               <input type="text" name="jobContent" disabled style="background: #e7e7e7" value="'+_jobContent+'" class="mui-input-clear" placeholder="请填写内容">\n' +
                        '                           </div>\n' +
                        '                       </div>\n' +
                        '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                        '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                        '                               <h5 class="mui-ellipsis" style="position: absolute">说明</h5>\n' +
                        '                           </div>\n' +
                        '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                        '                               <textarea class="summary" disabled style="background: #e7e7e7" name="explain" rows="2" placeholder="请填写">'+_explain+'</textarea>\n' +
                        '                           </div>\n' +
                        '                       </div>\n' +
                        /*'                       <div class="mui-table">\n' +
                        '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                        '                               <h5 class="mui-ellipsis">附件</h5>\n' +
                        '                           </div>\n' +
                        '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                        '                               <%--                                                    <input type="text" class="mui-input-clear" placeholder="请添加">--%>\n' +
                        '\n' +
                        '                               <div style="position: relative">\n' +
                        '                                   <div style="position: relative">\n' +
                        '                                       <a href="javascript:;" class="xzbtn upload" style="height: 32px;line-height: 32px;font-size: 16px;color: #01adff;position: absolute;top: 20px;left: 5px"  id="upload">上传附件</a>\n' +
                        '                                   </div>\n' +
                        '\n' +
                        '                               </div>\n' +
                        '                               <div style="width: 100%;height: 45px;" class="choose_box">\n' +
                        '                                   <div style="width: 100%;text-align: center">\n' +
                        '                                       <%--<img class="choosewj" src="/img/workflow/work/choose_img.png" alt="" onclick="btn1()" style="height:46px;width: 100%;margin-bottom: 40px">--%>\n' +
                        '                                       <%--            <span class="xzbtn" style="display: none;padding: 13px 80px;background: #3b87f5;font-size: 16px;font-weight: bold; border-radius: 40px;color:#fff;" onclick="btn1()">选择文件</span>--%>\n' +
                        '                                       <form id="uploadimgform" style="display:none;" target="uploadiframe" action="/upload?module=workflow"  enctype="multipart/form-data" method="post" >\n' +
                        '                                           <input type="file"  name="file" id="uploadinputimg" uploadType="1" multiple class="w-icon5">\n' +
                        '                                       </form>\n' +
                        '                                   </div>\n' +
                        '                               </div>\n' +
                        '                           </div>\n' +
                        '                       </div>\n' +
                        '\n' +
                        '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                        '                           <div style="margin-top: 10px">\n' +
                        '                               <div>\n' +
                        '                                   <ul class="uploadbox">\n' +
                        '\n' +
                        '                                   </ul>\n' +
                        '                               </div>\n' +
                        '                               <div class="photo_box">\n' +
                        '\n' +
                        '                               </div>\n' +
                        '                           </div>\n' +
                        '                       </div>\n' +*/
                        '                    </div>\n' +
                        '                </li>';
                    $('#tomorrowWorkUl').append(_htm)
                }

            }


        })

        //资源
        $(document).on('tap', '.resourcesAddDetails', function () {
            var _htm = '<li class="mui-table-view-cell mui-collapse mui-active">\n' +
                '                    <a class="mui-navigate-right " href="#"><span class="left"></span><span class="mui-icon mui-icon-more more" judgeState="resources"></span></a>\n' +
                '                    <div class="mui-collapse-content">\n' +
                '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                '                               <h5 class="mui-ellipsis"><span field="resourceName" class="field_required">*</span>资源名称</h5>\n' +
                '                           </div>\n' +
                '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                '                               <input type="text" name="resourceName" class="mui-input-clear" placeholder="请填写内容">\n' +
                '                           </div>\n' +
                '                       </div>\n' +
                '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                '                               <h5 class="mui-ellipsis"><span field="resourceType" class="field_required">*</span>资源类型</h5>\n' +
                '                           </div>\n' +
                '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                '                               <select name="resourceType">\n' +optionStr+
                /*'                                   <option value="">请选择</option>\n' +
                '                                   <option value="0">完成</option>\n' +
                '                                   <option value="1">部分完成</option>\n' +
                '                                   <option value="10">未启动</option>\n' +*/
                '                               </select>\n' +
                '                           </div>\n' +
                '                       </div>\n' +
                '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                '                               <h5 class="mui-ellipsis">数量</h5>\n' +
                '                           </div>\n' +
                '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                '                               <input type="number" name="resourcesNumber" class="mui-input-clear" placeholder="请填写">\n' +
                '                           </div>\n' +
                '                       </div>\n' +
                '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                '                               <h5 class="mui-ellipsis" style="position: absolute">说明</h5>\n' +
                '                           </div>\n' +
                '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                '                               <textarea class="summary" name="explain" rows="2" placeholder="请填写"></textarea>\n' +
                '                           </div>\n' +
                '                       </div>\n' +
                '                        <div class="mui-table">\n' +
                '                            <div class="mui-table-cell mui-col-xs-4">\n' +
                '                                <h5 class="mui-ellipsis">附件</h5>\n' +
                '                            </div>\n' +
                '                            <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                '                                <%--                                                    <input type="text" class="mui-input-clear" placeholder="请添加">--%>\n' +
                '\n' +
                '                                <div style="position: relative">\n' +
                '                                    <div style="position: relative">\n' +
                '                                        <a href="javascript:;" class="xzbtn upload" style="height: 32px;line-height: 32px;font-size: 16px;color: #01adff;position: absolute;top: 20px;left: 5px"  id="upload">上传附件</a>\n' +
                '                                    </div>\n' +
                '\n' +
                '                                </div>\n' +
                '                                <div style="width: 100%;height: 45px;" class="choose_box">\n' +
                '                                    <div style="width: 100%;text-align: center">\n' +
                '                                        <%--<img class="choosewj" src="/img/workflow/work/choose_img.png" alt="" onclick="btn1()" style="height:46px;width: 100%;margin-bottom: 40px">--%>\n' +
                '                                        <%--            <span class="xzbtn" style="display: none;padding: 13px 80px;background: #3b87f5;font-size: 16px;font-weight: bold; border-radius: 40px;color:#fff;" onclick="btn1()">选择文件</span>--%>\n' +
                '                                        <form id="uploadimgform" style="display:none;" target="uploadiframe" action="/upload?module=workflow"  enctype="multipart/form-data" method="post" >\n' +
                '                                            <input type="file"  name="file" id="uploadinputimg" uploadType="1" multiple class="w-icon5">\n' +
                '                                        </form>\n' +
                '                                    </div>\n' +
                '                                </div>\n' +
                '                            </div>\n' +
                '                        </div>\n' +
                '\n' +
                '                        <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                '                            <div style="margin-top: 10px">\n' +
                '                                <div>\n' +
                '                                    <ul class="uploadbox">\n' +
                '\n' +
                '                                    </ul>\n' +
                '                                </div>\n' +
                '                                <div class="photo_box">\n' +
                '\n' +
                '                                </div>\n' +
                '                            </div>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                </li>';
            $('#resources').append(_htm)
        })

        $(document).on('input propertychange', '[name="resourceName"]', function () {
            $(this).parents('.mui-collapse-content').prev().find('.left').text($(this).val())
        })

        $(document).on('tap', '.tomorrowAddDetails', function () {
            var _htm = '<li class="mui-table-view-cell mui-collapse mui-active">\n' +
                '                    <a class="mui-navigate-right" href="#"><span class="left"></span><span class="mui-icon mui-icon-more more" judgeState="tomorrow"></span></a>\n' +
                '                    <div class="mui-collapse-content">\n' +
                '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                '                               <h5 class="mui-ellipsis"><span field="jobContent" class="field_required">*</span>工作内容</h5>\n' +
                '                           </div>\n' +
                '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                '                               <input type="text" name="jobContent" class="mui-input-clear" placeholder="请填写内容">\n' +
                '                           </div>\n' +
                '                       </div>\n' +
                '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                '                               <h5 class="mui-ellipsis" style="position: absolute">说明</h5>\n' +
                '                           </div>\n' +
                '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                '                               <textarea class="summary" name="explain" rows="2" placeholder="请填写"></textarea>\n' +
                '                           </div>\n' +
                '                       </div>\n' +
                '                       <div class="mui-table">\n' +
                '                           <div class="mui-table-cell mui-col-xs-4">\n' +
                '                               <h5 class="mui-ellipsis">附件</h5>\n' +
                '                           </div>\n' +
                '                           <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                '                               <%--                                                    <input type="text" class="mui-input-clear" placeholder="请添加">--%>\n' +
                '\n' +
                '                               <div style="position: relative">\n' +
                '                                   <div style="position: relative">\n' +
                '                                       <a href="javascript:;" class="xzbtn upload" style="height: 32px;line-height: 32px;font-size: 16px;color: #01adff;position: absolute;top: 20px;left: 5px"  id="upload">上传附件</a>\n' +
                '                                   </div>\n' +
                '\n' +
                '                               </div>\n' +
                '                               <div style="width: 100%;height: 45px;" class="choose_box">\n' +
                '                                   <div style="width: 100%;text-align: center">\n' +
                '                                       <%--<img class="choosewj" src="/img/workflow/work/choose_img.png" alt="" onclick="btn1()" style="height:46px;width: 100%;margin-bottom: 40px">--%>\n' +
                '                                       <%--            <span class="xzbtn" style="display: none;padding: 13px 80px;background: #3b87f5;font-size: 16px;font-weight: bold; border-radius: 40px;color:#fff;" onclick="btn1()">选择文件</span>--%>\n' +
                '                                       <form id="uploadimgform" style="display:none;" target="uploadiframe" action="/upload?module=workflow"  enctype="multipart/form-data" method="post" >\n' +
                '                                           <input type="file"  name="file" id="uploadinputimg" uploadType="1" multiple class="w-icon5">\n' +
                '                                       </form>\n' +
                '                                   </div>\n' +
                '                               </div>\n' +
                '                           </div>\n' +
                '                       </div>\n' +
                '\n' +
                '                       <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                '                           <div style="margin-top: 10px">\n' +
                '                               <div>\n' +
                '                                   <ul class="uploadbox">\n' +
                '\n' +
                '                                   </ul>\n' +
                '                               </div>\n' +
                '                               <div class="photo_box">\n' +
                '\n' +
                '                               </div>\n' +
                '                           </div>\n' +
                '                       </div>\n' +
                '                    </div>\n' +
                '                </li>';
            $('#tomorrowWorkUl').append(_htm)
            /*layer.open({
                type: 1,
                title: '添加明细',
                area: ['100%', '100%'],
                btn: ['确定','取消'],
                btnAlign: 'c',
                content:  '<div class="mui-table-view-cell twoPopup">\n' +
                    '               <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                    '                   <div class="mui-table-cell mui-col-xs-4">\n' +
                    '                       <h5 class="mui-ellipsis"><span field="jobContent" class="field_required">*</span>工作内容</h5>\n' +
                    '                   </div>\n' +
                    '                   <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                    '                       <input type="text" name="jobContent" class="mui-input-clear" placeholder="请填写内容">\n' +
                    '                   </div>\n' +
                    '               </div>\n' +
                    '               <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                    '                   <div class="mui-table-cell mui-col-xs-4">\n' +
                    '                       <h5 class="mui-ellipsis" style="position: absolute">说明</h5>\n' +
                    '                   </div>\n' +
                    '                   <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                    '                       <textarea class="summary" name="explain" rows="2" placeholder="请填写"></textarea>\n' +
                    '                   </div>\n' +
                    '               </div>\n' +
                    '               <div class="mui-table">\n' +
                    '                   <div class="mui-table-cell mui-col-xs-4">\n' +
                    '                       <h5 class="mui-ellipsis">附件</h5>\n' +
                    '                   </div>\n' +
                    '                   <div class="mui-table-cell mui-col-xs-8 mui-text-right">\n' +
                    '                       <%--                                                    <input type="text" class="mui-input-clear" placeholder="请添加">--%>\n' +
                    '\n' +
                    '                       <div style="position: relative">\n' +
                    '                           <div style="position: relative">\n' +
                    '                               <a href="javascript:;" class="xzbtn upload" style="height: 32px;line-height: 32px;font-size: 16px;color: #01adff;position: absolute;top: 20px;left: 5px"  id="upload">上传附件</a>\n' +
                    '                           </div>\n' +
                    '\n' +
                    '                       </div>\n' +
                    '                       <div style="width: 100%;height: 45px;" class="choose_box">\n' +
                    '                           <div style="width: 100%;text-align: center">\n' +
                    '                               <%--<img class="choosewj" src="/img/workflow/work/choose_img.png" alt="" onclick="btn1()" style="height:46px;width: 100%;margin-bottom: 40px">--%>\n' +
                    '                               <%--            <span class="xzbtn" style="display: none;padding: 13px 80px;background: #3b87f5;font-size: 16px;font-weight: bold; border-radius: 40px;color:#fff;" onclick="btn1()">选择文件</span>--%>\n' +
                    '                               <form id="uploadimgform" style="display:none;" target="uploadiframe" action="/upload?module=workflow"  enctype="multipart/form-data" method="post" >\n' +
                    '                                   <input type="file"  name="file" id="uploadinputimg" uploadType="1" multiple class="w-icon5">\n' +
                    '                               </form>\n' +
                    '                           </div>\n' +
                    '                       </div>\n' +
                    '                   </div>\n' +
                    '               </div>\n' +
                    '\n' +
                    '               <div class="mui-table" style="border-bottom: 1px solid gray">\n' +
                    '                   <div style="margin-top: 10px">\n' +
                    '                       <div>\n' +
                    '                           <ul class="uploadbox">\n' +
                    '\n' +
                    '                           </ul>\n' +
                    '                       </div>\n' +
                    '                       <div class="photo_box">\n' +
                    '\n' +
                    '                       </div>\n' +
                    '                   </div>\n' +
                    '               </div>\n' +
                    '       </div>',
                success: function () {

                    form.render();
                },
                yes: function (index) {
                    var _html = '<li class="mui-table-view-cell mui-collapse">\n' +
                        '           <a class="mui-navigate-right" href="#">' +$('.twoPopup [name="jobContent"]').val()+
                        '           </a>\n' +
                        '           <div class="mui-collapse-content">\n' +$('.twoPopup').html()+
                        '           </div>\n' +
                        '       </li>';

                    $('#tomorrowWorkUl').append(_html)

                    $('#tomorrowWorkUl li:last [name="jobContent"]').val($('.twoPopup [name="jobContent"]').val())
                    $('#tomorrowWorkUl li:last [name="explain"]').val($('.twoPopup [name="explain"]').val())

                    layer.close(index);
                }

            });*/
        })
    })

    //删除方法
    function delFun(dom) {
        if($(dom).attr('logId')||$(dom).attr('detailsId')){
            if($(dom).attr('judgeState')=='today'){
                $.ajax({
                    url:"/workflow/workLog/delDanger?ids="+$(dom).attr('logId'),
                    dataType:"json",
                    success:function(res){
                        if(res.code==="0"||res.code===0){
                            layer.msg(res.msg);
                            $(dom).parent().parent().remove()
                            $('#tomorrowWorkUl [synchroStatus="'+$(dom).parent().parent().attr('tsynchrostatus')+'"]').remove()
                        }else{
                            layer.msg(res.msg);
                        }
                    }
                })
            }else if($(dom).attr('judgeState')=='resources'){
                $.ajax({
                    url:"/workflow/workLog/delResources?ids="+$(dom).attr('detailsId'),
                    dataType:"json",
                    success:function(res){
                        if(res.code==="0"||res.code===0){
                            layer.msg(res.msg);
                            $(dom).parent().parent().remove()
                        }else{
                            layer.msg(res.msg);
                        }
                    }
                })
            }else if($(dom).attr('judgeState')=='tomorrow'){
                $.ajax({
                    url:"/workflow/workLog/delTorrmorWork?ids="+$(dom).attr('logId'),
                    dataType:"json",
                    success:function(res){
                        if(res.code==="0"||res.code===0){
                            layer.msg(res.msg);
                            $(dom).parent().parent().remove()
                        }else{
                            layer.msg(res.msg);
                        }
                    }
                })
            }
        }else {
            $(dom).parent().parent().remove()
            if($(dom).attr('judgeState')=='today'){
                $('#tomorrowWorkUl [synchroStatus="'+$(dom).parent().parent().attr('synchrostatus')+'"]').remove()
            }
        }
    }


    //保存子表数据
    function saveData(){
        //遍历表格获取每行数据
        //进展填报
        var $trs = $('#scheduleUl').find('li');
        var dataArr = [];

        var scheduleFlag = false
        $trs.each(function () {
            var attachId = '';
            var attachName = '';
            for (var i = 0; i < $(this).find('img').length; i++) {
                attachId += $(this).find('img').eq(i).attr('attachmentId');
                attachName += $(this).find('img').eq(i).eq(i).attr('attachmentName');
            }
            var dataObj = {
                workScheduleId:$(this).find('[name="recordProgress"]').attr('workScheduleId') || '',
                scheduleId: $(this).find('[name="recordProgress"]').attr('scheduleId') || '',
                workPlanId: $(this).find('[name="recordProgress"]').attr('workPlanId') || '',
                scheduleRecordId: $(this).find('[name="recordProgress"]').attr('scheduleRecordId') || '',
                recordBeginDate: $(this).find('[name="recordBeginDate"]').val(),
                recordDate: $(this).find('[name="recordDate"]').val(),
                recordProgress: $(this).find('[name="recordProgress"]').val(),
                percentComplete: $(this).find('[name="percentComplete"]').val(),
                attachmentId:attachId,
                attachmentName:attachName
            }
            dataArr.push(dataObj);

            if(!($(this).find('[name="percentComplete"]').attr('flag'))){
                scheduleFlag = true
            }
        });

        //昨日计划今日完成
        var $trs2 = $('#yestdayUl').find('li');
        var dataArr2 = [];

        var yestdayFlag = false
        $trs2.each(function () {
            var dataObj = {
                synchroStatus: $(this).attr('synchroStatus')||'',
                logId: $(this).find('[name="explain"]').attr('logId') || '',
                memo: $(this).find('[name="memo"]').val(),
                completionStatus: $(this).find('[name="completionStatus"]').val()
            }
            dataArr2.push(dataObj);

            // if(!($(this).find('[name="completionStatus"]').attr('flag'))){
            if(!($(this).find('[name="completionStatus"]').val())){
                yestdayFlag = true
            }
        });

        //今日其他工作
        var $trs3 = $('#todyWorkUl').find('li');
        var dataArr3 = [];
        $trs3.each(function () {
            var attachId = '';
            var attachName = '';
            for (var i = 0; i < $(this).find('img').length; i++) {
                attachId += $(this).find('img').eq(i).attr('attachmentId');
                attachName += $(this).find('img').eq(i).eq(i).attr('attachmentName');
            }
            var dataObj = {
                synchroStatus: $(this).attr('synchroStatus')||'',
                logId: $(this).find('[name="explain"]').attr('logId') || '',
                workPlanId: $(this).find('[name="explain"]').attr('workPlanId') || '',
                jobContent: $(this).find('[name="jobContent"]').val(),
                completionStatus: $(this).find('[name="completionStatus"]').val(),
                explain: $(this).find('[name="explain"]').val(),
                workType:1,
                attachmentId:attachId,
                attachmentName:attachName
            }
            dataArr3.push(dataObj);
        });

        //明日其他工作
        var $trs4 = $('#tomorrowWorkUl').find('li');
        var dataArr4 = [];
        $trs4.each(function () {
            var attachId = '';
            var attachName = '';
            for (var i = 0; i < $(this).find('img').length; i++) {
                attachId += $(this).find('img').eq(i).attr('attachmentId');
                attachName += $(this).find('img').eq(i).eq(i).attr('attachmentName');
            }
            var dataObj = {
                synchroStatus: $(this).attr('synchroStatus')||'',
                logOldId: $(this).attr('logOldId')||'',
                logId: $(this).find('[name="explain"]').attr('logId') || '',
                workPlanId: $(this).find('[name="explain"]').attr('workPlanId') || '',
                jobContent: $(this).find('[name="jobContent"]').val(),
                explain: $(this).find('[name="explain"]').val(),
                workType:2,
                attachmentId:attachId,
                attachmentName:attachName
            }
            dataArr4.push(dataObj);
        });

        //今日其他工作 资源
        var $trs5 = $('#resources').find('li');
        var dataArr5 = [];
        $trs5.each(function () {
            var attachId = '';
            var attachName = '';
            for (var i = 0; i < $(this).find('img').length; i++) {
                attachId += $(this).find('img').eq(i).attr('attachmentId');
                attachName += $(this).find('img').eq(i).eq(i).attr('attachmentName');
            }
            var dataObj = {
                detailsId: $(this).find('[name="explain"]').attr('detailsId') || '',
                workPlanId: $(this).find('[name="explain"]').attr('workPlanId') || '',
                resourceName: $(this).find('[name="resourceName"]').val(),
                resourceType: $(this).find('[name="resourceType"]').val(),
                resourcesNumber:$(this).find('[name="resourcesNumber"]').val(),
                explain: $(this).find('[name="explain"]').val(),
                attachmentId:attachId,
                attachmentName:attachName
            }
            dataArr5.push(dataObj);
        });

        return {
            scheduleData: dataArr,
            yestdayData: dataArr2,
            todyWorkData: dataArr3,
            tomorrowWorkData: dataArr4,
            resourcesData: dataArr5,
            scheduleFlag:scheduleFlag,
            yestdayFlag:yestdayFlag
        }
    }

    //保存所有数据
    //默认保存  提交 state 等于 true
    function saveAllData(state){
        var _history = window.history;
        $('.preservation').attr('disabled','disabled')
        var params = ''

        var obj = {}
        obj.fillingDate = $('.fillingDate').text()
        obj.weather = $('.weather').text()
        obj.createUserName = $('.createUserName').text()
        obj.planSummary = $('[name="planSummary" ]').val()

        obj.workPlanId = $('#leftId').attr('workPlanId')||''

        obj.scheduleRecords = saveData().scheduleData
        obj.yestdayWork = saveData().yestdayData
        obj.todyWork = saveData().todyWorkData
        obj.tomorrowWork = saveData().tomorrowWorkData
        obj.resourcesList = saveData().resourcesData

        if(state){
            obj.submitFlag = '1'
        }

        // 判断必填项
        var requiredFlag = false;
        $('.field_required').each(function(){
            var field = $(this).attr('field');
            var fieldDomVal = $(this).parents('.mui-table').find('[name="'+field+'"]').val()
            if (field && !fieldDomVal && fieldDomVal != '0') {
                var fieldName = $(this).parent().text().replace('*', '');
                layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
                requiredFlag = true;
                $('.preservation').attr('disabled','')
                return false;
            }
        });

        if (requiredFlag) {
            return false;
            $('.preservation').attr('disabled','')
        }

        var _flag = false
        obj.scheduleRecords.forEach(function(item){
            if(item.percentComplete==100){
                _flag = true
            }
        })
        if(saveData().scheduleFlag){
            layer.confirm('有进展还未填报是否确认保存或提交？', function (index) {
                if(saveData().yestdayFlag){
                    layer.confirm('昨日任务还未填报是否保存或提交？', function (index) {
                        if(_flag){
                            layer.confirm('是否确认完成？', function (index) {
                                    var loadIndex = layer.load();
                                    $.ajax({
                                        url: '/workflow/workLog/updateWorkLog?isclose=true'+params,
                                        data: JSON.stringify(obj),
                                        dataType: 'json',
                                        contentType: "application/json;charset=UTF-8",
                                        type: 'post',
                                        async:false,
                                        success: function (res) {
                                            layer.close(loadIndex);
                                            if (res.flag) {
                                                layer.msg('保存成功！', {icon: 1});
                                                window.location.href="/workflow/workLog/workLogH5Index"

                                            } else {
                                                $('.preservation').attr('disabled','')
                                                layer.msg(res.msg, {icon: 2});
                                            }
                                        }
                                    });
                                }
                                /* , function(index, layero){
                                     var loadIndex = layer.load();
                                     $.ajax({
                                         url: '/workflow/workLog/updateWorkLog?'+params,
                                         data: JSON.stringify(obj),
                                         dataType: 'json',
                                         contentType: "application/json;charset=UTF-8",
                                         type: 'post',
                                         async:false,
                                         success: function (res) {
                                             layer.close(loadIndex);
                                             if (res.flag) {
                                                 layer.msg('保存成功！', {icon: 1});

                                                 window.location.href="/workflow/workLog/workLogH5Index"
                                             } else {
                                                $('.preservation').attr('disabled','')
                                                 layer.msg(res.msg, {icon: 2});
                                             }
                                         }
                                     });
                                 };*/
                            )
                        }else{
                            var loadIndex = layer.load();
                            $.ajax({
                                url: '/workflow/workLog/updateWorkLog?'+params,
                                data: JSON.stringify(obj),
                                dataType: 'json',
                                contentType: "application/json;charset=UTF-8",
                                type: 'post',
                                async:false,
                                success: function (res) {
                                    layer.close(loadIndex);
                                    if (res.flag) {
                                        layer.msg('保存成功！', {icon: 1});

                                        window.location.href="/workflow/workLog/workLogH5Index"

                                    } else {
                                        $('.preservation').attr('disabled','')
                                        layer.msg(res.msg, {icon: 2});
                                    }
                                }
                            });
                        }
                    });
                }else {
                    var loadIndex = layer.load();
                    $.ajax({
                        url: '/workflow/workLog/updateWorkLog?'+params,
                        data: JSON.stringify(obj),
                        dataType: 'json',
                        contentType: "application/json;charset=UTF-8",
                        type: 'post',
                        async:false,
                        success: function (res) {
                            layer.close(loadIndex);
                            if (res.flag) {
                                layer.msg('保存成功！', {icon: 1});
                                window.location.href="/workflow/workLog/workLogH5Index"

                            } else {
                                $('.preservation').attr('disabled','')
                                layer.msg(res.msg, {icon: 2});
                            }
                        }
                    });
                }
            });
        }else {
            if(saveData().yestdayFlag){
                layer.confirm('昨日任务还未填报是否保存或提交？', function (index) {
                    if(_flag){
                        layer.confirm('是否确认完成？', function (index) {
                                var loadIndex = layer.load();
                                $.ajax({
                                    url: '/workflow/workLog/updateWorkLog?isclose=true'+params,
                                    data: JSON.stringify(obj),
                                    dataType: 'json',
                                    contentType: "application/json;charset=UTF-8",
                                    type: 'post',
                                    async:false,
                                    success: function (res) {
                                        layer.close(loadIndex);
                                        if (res.flag) {
                                            layer.msg('保存成功！', {icon: 1});


                                            window.location.href="/workflow/workLog/workLogH5Index"

                                        } else {
                                            $('.preservation').attr('disabled','')
                                            layer.msg(res.msg, {icon: 2});
                                        }
                                    }
                                });
                            }
                            /*, function(index, layero){
                                var loadIndex = layer.load();
                                $.ajax({
                                    url: '/workflow/workLog/updateWorkLog?'+params,
                                    data: JSON.stringify(obj),
                                    dataType: 'json',
                                    contentType: "application/json;charset=UTF-8",
                                    type: 'post',
                                    async:false,
                                    success: function (res) {
                                        layer.close(loadIndex);
                                        if (res.flag) {
                                            layer.msg('保存成功！', {icon: 1});


                                                window.location.href="/workflow/workLog/workLogH5Index"
                                        } else {
                                           $('.preservation').attr('disabled','')
                                                layer.msg(res.msg, {icon: 2});
                                        }
                                    }
                                });
                            }*/
                        );
                    }else{
                        var loadIndex = layer.load();
                        $.ajax({
                            url: '/workflow/workLog/updateWorkLog?'+params,
                            data: JSON.stringify(obj),
                            dataType: 'json',
                            contentType: "application/json;charset=UTF-8",
                            type: 'post',
                            async:false,
                            success: function (res) {
                                layer.close(loadIndex);
                                if (res.flag) {
                                    layer.msg('保存成功！', {icon: 1});

                                    window.location.href="/workflow/workLog/workLogH5Index"

                                } else {
                                    $('.preservation').attr('disabled','')
                                    layer.msg(res.msg, {icon: 2});
                                }
                            }
                        });
                    }
                });
            }else {
                if(_flag){
                    layer.confirm('是否确认完成？', function (index) {
                            var loadIndex = layer.load();
                            $.ajax({
                                url: '/workflow/workLog/updateWorkLog?isclose=true'+params,
                                data: JSON.stringify(obj),
                                dataType: 'json',
                                contentType: "application/json;charset=UTF-8",
                                type: 'post',
                                async:false,
                                success: function (res) {
                                    layer.close(loadIndex);
                                    if (res.flag) {
                                        layer.msg('保存成功！', {icon: 1});

                                        window.location.href="/workflow/workLog/workLogH5Index"

                                    } else {
                                        $('.preservation').attr('disabled','')
                                        layer.msg(res.msg, {icon: 2});
                                    }
                                }
                            });
                        }
                        /* , function(index, layero){
                             var loadIndex = layer.load();
                             $.ajax({
                                 url: '/workflow/workLog/updateWorkLog?'+params,
                                 data: JSON.stringify(obj),
                                 dataType: 'json',
                                 contentType: "application/json;charset=UTF-8",
                                 type: 'post',
                                 async:false,
                                 success: function (res) {
                                     layer.close(loadIndex);
                                     if (res.flag) {
                                         layer.msg('保存成功！', {icon: 1});


                                                 window.location.href="/workflow/workLog/workLogH5Index"
                                     } else {
                                        $('.preservation').attr('disabled','')
                                                 layer.msg(res.msg, {icon: 2});
                                     }
                                 }
                             });
                         }*/
                    );
                }else{
                    var loadIndex = layer.load();
                    $.ajax({
                        url: '/workflow/workLog/updateWorkLog?'+params,
                        data: JSON.stringify(obj),
                        dataType: 'json',
                        contentType: "application/json;charset=UTF-8",
                        type: 'post',
                        async:false,
                        success: function (res) {
                            layer.close(loadIndex);
                            if (res.flag) {
                                layer.msg('保存成功！', {icon: 1});

                                window.location.href="/workflow/workLog/workLogH5Index"

                            } else {
                                $('.preservation').attr('disabled','')
                                layer.msg(res.msg, {icon: 2});
                            }
                        }
                    });
                }
            }
        }
    }

    if(!($('.weather').text())){
        //渲染天气
        $.get('/sys/getInterfaceInfo', function (json){
            if (json.flag) {
                if(json.object.weatherCity!=1){
                    // alert('111')
                    // window.onload = loadScript;
                    loadScript()
                }
            }
        }, 'json')
        function loadScript() {
            var script = document.createElement("script");
            script.src = "http://api.map.baidu.com/api?v=2.0&ak=7HSdUGqKaz5U0ph0LIQ2Qd4rFmFZA2kY&callback=getweatherBefore";//此为v2.0版本的引用方式,加载完成后执行getweatherBefore事件
            document.body.appendChild(script);
        }
    }

    $(document).on('tap', '.upload', function () {
        _thisDom = $(this)

        if($.getQueryString("type") == 'EWC'){
            // console.log('uploadimgform');
            // alert('企业微信移动端工作流公共附件功能正在开发中！');
            $("#uploadinputimg").attr('uploadType','1');
            $('#uploadimgform').attr('action','/upload?module=workflow&flowPrcs='+$.getQueryString("flowStep")+'&runId='+$.getQueryString("runId"));
            $("#uploadinputimg").trigger("click");
        }else{
            // $('.choosewj').attr('src','/img/workflow/work/choose_imgclick.png')
            btn('imgadd1',1)
        }
    })

    /*$(".upload").click(function btn1(e){
        if($.getQueryString("type") == 'EWC'){
            // console.log('uploadimgform');
            // alert('企业微信移动端工作流公共附件功能正在开发中！');
            $("#uploadinputimg").attr('uploadType','1');
            $('#uploadimgform').attr('action','/upload?module=workflow&flowPrcs='+$.getQueryString("flowStep")+'&runId='+$.getQueryString("runId"));
            $("#uploadinputimg").trigger("click");
        }else{
            // $('.choosewj').attr('src','/img/workflow/work/choose_imgclick.png')
            btn('imgadd1',1)
        }

    })*/
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
            // alert(navigator.userAgent);
            //alert(navigator.userAgent);
            //var filesize = 1
            //Android.addImage(cb,num,filesize);
            Android.addImage(cb,num);
        }
        // $('.choosewj').attr('src','/img/workflow/work/choose_img.png')
    }

    var index=0;
    function imgadd1(img,name,type,attachmentList){
        // alert(img)
        // alert(name)
        // alert(type)
        // var arr = img.split(',');
        var arr = img.split(',');
        var name_arr = name.split(',');
        if(type == 3){
            arr = attachmentList
            if(!arr) return ''
            var img = '';
            for(var i=0;i<arr.length ;i++){
                index+=1;
                var fileId="\'blah"+index+"\'";
                img += '<div id="blah'+index+'"  style="position: relative"><img delUrl='+arr[i].attUrl+' attachmentName='+arr[i].attachName+"*"+' attachmentId='+arr[i].id+' id="blah"  src="/xs?'+ encodeURI(arr[i].attUrl) +'" onclick="anios($(this))" style="width:70px;height:100px;margin-right: 10px;margin-bottom: 10px;" url="'+window.location.origin+"/xs?"+ encodeURI(arr[i].attUrl) +'"  name="'+ arr[i].attachName +'"><span class="layui-icon layui-icon-close-fill" style="color: #dc143c;position: absolute;left: 59px;top: -4px;" onClick="delFile('+fileId+')"></span></div>';
            }
            return img
            // $('.photo_box').append(img);
            // _thisDom.parents('.mui-table').next().find('.photo_box').append(img);
            //return true;
        }else
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
            // $('.photo_box').append(img);
            _thisDom.parents('.mui-table').next().find('.photo_box').append(img);
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
            // alert(name_str)
            // $('.uploadbox').css('min-height', '50px')
            // $('.uploadbox').append(name_str);
            _thisDom.parents('.mui-table').next().find('.uploadbox').append(name_str);
            //return true;
        }
    }
    function anios(e){
        var url = e.attr('url');
        var name = e.attr('name');
        // alert(url)
        // alert(name)
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
    /**********************结束*****************************/
    /**********************与移动端交互 页面加载后 将附件的图片添加 初始化页面附件查看方式*****************************/``


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


    function getParamByUrl(url,name) {
        //构造一个含有目标参数的正则表达式对象
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        //匹配目标参数
        var r = url.match(reg);
        //返回参数值
        if (r != null) return unescape(r[2]); return null;
    }

    //日期
    function getNowFormatDate(formate) {
        var date = new Date();
        var seperator1 = formate;
        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        var currentdate = year + seperator1 + month + seperator1 + strDate;
        return currentdate;
    }


    //天气
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
                                    $(".weather").text(res.object.weather)
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
