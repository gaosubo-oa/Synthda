<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() +"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html><!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>会话</title>
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css" />
    <script type="text/javascript" src="/js/xoajq/xoajq1.js">    </script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style>
        .mui-bar-nav~.mui-content{
            padding-top:0px!important;
        }
        .mui-scroll{
            position: relative;!important;
        }
        body{background: #ffffff;
            font-family:'微软雅黑'}
        .cal_type {
            width: 40px;
            margin-left: 14px;
        }
        .mui-table-view:after{
            background-color: #e7e7e7;
        }
        .simba_conter .simba_subject{
        font-size: 14px;
        }

        .mui-scroll .mui-table-view li.mui-table-view-cell:hover{
            background: #abd9fe;
        }
         input[type=text]{width:30%;!important;height:30px;!important;}
        .M-box3 {
            width: 150px;!important;
        }
    </style>
    <script type="text/javascript" charset="utf-8">
//        mui.init();

        $(function(){
            var data = {
                page: 1,
                pageSize: 15,
                useFlag: true,

                //time:new Date().getTime()
            }
            var datawait = {
                page: 1,
                pageSize: 15,
                useFlag: true,

            }

            $(document).ready(function () {

                initPageList_db(function (pageCount) {

                    initPagination_db(pageCount, data.pageSize);
                })

            })

            function initPagination_db(totalData, pageSize) {
                $('#dbgz_page').pagination({
                    totalData: totalData,
                    showData: pageSize,
                    jump: true,
                    coping: true,
                    homePage: '',
                    endPage: '',
                    current: datawait.page,
                    //prevContent: '',
                    //nextContent: '',
                    //jumpBtn: '',
                    callback: function (index) {
                        datawait.page = index.getCurrent();
                        initPageList_db(function (pageCount) {
                            initPagination_db(pageCount, data.pageSize);
                        })
                    }
                })
            }
            var uid=${uId}
            var img={"0":"../img/spirit/nan.png","1":"../img/spirit/nv.png"}
            function initPageList_db(cb) {
                $.ajax({
                    url: '/im/getImList?of_from=' + uid + '@gsubo',
                    type: 'get',
                    dataType: 'json',
                    success: function (obj) {
                        // var obj=obj.obj;
                        var li = '';
                        if (obj != '') {
                            for (var i = obj.length - 1; i >= 0; i--) {

                                var listtimes = obj[i].time;
                                /* li+='<li><div class="yiji_title"><span class="head_pic"><img src="../img/main_img/app/208006.png" alt="img"/></span>&nbsp;&nbsp;&nbsp;&nbsp;  <span title="'+obj[i].list_id+'" id="'+obj[i].from_uid+'" class="appname">'+obj[i].content.substring(0,obj[i].content.length-2);+'</span><span class="dianji before"></span></div>';*/
                                li += '<div class="mui-content" userName="' + obj[i].user_Name + '" user_priv_name="' + obj[i].user_priv_name + '" mobilNo="' + obj[i].mobilNo + '" sex="' + obj[i].sex + '" birthday="' + obj[i].birthday + '" id="' + obj[i].to_uid + '" onclick="openPerson(this)"> ' +
                                    '<div class="mui-scroll"> <ul class="mui-table-view"> ' +
                                    '<li class="mui-table-view-cell" > <a class="mui-navigate-right"> ' +
                                    '<div class="simba_work"> <img class="cal_type" src="' + img[obj[i].sex] + '"> </div> ' +
                                    '<div class="simba_conter"><div class="simba_subject" >' + obj[i].user_Name + '<span class="list_time">' + formatDate(parseInt(obj[i].time)) + '</div> ' +
                                    '<div class="simba_writing">' + obj[i].content + '<span></div> ' +
                                    '</div>' +
                                    ' </a> ' +
                                    '</li> ' +
                                    '</ul>' +
                                    '</div> ' +
                                    '</div>';

                                li+=' </li>';
                            }
                            $(".app_connect ").html(li);
                            if (cb) {
                                //alert(data.totleNum);
                                cb(obj.length);

                            }
                        }

                    }
                })
            }



        })

        function openPerson(e){
            var uname=$(e).attr('userName');
            var uid=$(e).attr('id');
            var userPrivName=$(e).attr('user_priv_name');
            var sex=$(e).attr('sex');
            var mobilNo=$(e).attr('mobilNo');

            var birthday=$(e).attr('birthday');
            var data={"uname":uname,"userPrivName":userPrivName,"sex":sex,"birthday":birthday,"mobilNo":mobilNo};
            var data2=JSON.stringify(data);

            parent.doQtPer(data2,uid);
        }
        function formatDate(timespan)
        {


            var dateTime = new Date(timespan * 1000);
            var year = dateTime.getFullYear();
            var month = dateTime.getMonth() + 1;
            var day = dateTime.getDate();
            var hour = dateTime.getHours();
            var minute = dateTime.getMinutes();
            //当前时间
            var now = Date.parse(new Date());  //typescript转换写法
            var milliseconds = 0;
            var timeSpanStr;
            //计算时间差
            milliseconds = (now / 1000) - timespan;

            //一分钟以内
            if (milliseconds <= 60) {
                timeSpanStr = '刚刚';
            }
            //大于一分钟小于一小时
            else if (60 < milliseconds && milliseconds <= 60 * 60) {
                timeSpanStr = Math.ceil((milliseconds / (60))) + '分钟前';
            }
            //大于一小时小于等于一天
            else if (60 * 60 < milliseconds && milliseconds <= 60 * 60 * 24) {
                timeSpanStr = Math.ceil(milliseconds / (60 * 60)) + '小时前';
            }
            //大于一天小于等于15天
            else if (60 * 60 * 24 < milliseconds && milliseconds <= 60 * 60 * 24 * 30) {
                timeSpanStr = Math.ceil(milliseconds / (60 * 60 * 24)) + '天前';
            }
            //大于一个月小于一年
            else if (60 * 60 * 24 * 30 < milliseconds && milliseconds <= 60 * 60 * 24 * 30 * 12){
                timeSpanStr = Math.ceil(milliseconds / (60 * 60 * 24 * 30)) + '个月前';
            }
            //超过一年显示
            else {
                timeSpanStr = year + '年' + month + '月' + day + '日 ' + hour + ':' + minute;
            }
            return timeSpanStr;
        }

    </script>

</head>


<body>

<div class="wrap">

    <div class="app_connect yiji">

    </div>
    <div class="right">
        <!-- 分页按钮-->
        <div class="M-box3" id="dbgz_page"></div>
    </div>
</div>
</body>

<script language="JavaScript">

</script>

</html>