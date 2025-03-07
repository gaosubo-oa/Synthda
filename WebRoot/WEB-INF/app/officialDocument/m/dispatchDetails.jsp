<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String corpId = (String)request.getAttribute("corpId");
    String corpSecret = (String)request.getAttribute("corpSecret");
%>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>发文详情</title>
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>
    <script type="text/javascript" src="../../js/notes/jquery-2.1.2.min.js" ></script>
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <link rel="stylesheet" href="../../lib/mui/mui/mui.picker.min.css" />
    <script type="text/javascript" src="../../lib/mui/mui/mui.picker.min.js" ></script>
    <style>
        #header{
            background-color: #3984ff;
            box-shadow: 1px 1px 7px rgba(0, 0, 0, .85);
        }
        #header a{
            color: #fff;
        }
        #header h1{
            color: #fff;
        }
        .ulli{
            margin: 0 14px;
            border-bottom: 1px solid #c8c7cc;
            height: 50px;
            line-height: 58px;
        }

        .nav span{
            width: 48%;
            display: inline-block;
            text-align: center;
        }
        .navc{
            background-color: #00a0e9;
            color: #fff;
            border-radius: 10px;
        }
        #yspan{
            padding: 4px 10px;
            background-color: #00a0e9;
            color: #fff;
            border-radius: 5px;
            margin-left: 14px;
        }
        .result,.result1{
            color:#00a0e9;
            padding-left: 17px;
        }


        /* reset */
        html,body,h1,h2,h3,h4,h5,h6,div,dl,dt,dd,ul,ol,li,p,blockquote,pre,hr,figure,table,caption,th,td,form,fieldset,legend,input,button,textarea,menu{margin:0;padding:0;}
        header,footer,section,article,aside,nav,hgroup,address,figure,figcaption,menu,details{display:block;}
        table{border-collapse:collapse;border-spacing:0;}
        caption,th{text-align:left;font-weight:normal;}
        html,body,fieldset,img,iframe,abbr{border:0;}
        i,cite,em,var,address,dfn{font-style:normal;}
        [hidefocus],summary{outline:0;}
        li{list-style:none;}
        h1,h2,h3,h4,h5,h6,small{font-size:100%;}
        sup,sub{font-size:83%;}
        pre,code,kbd,samp{font-family:inherit;}
        q:before,q:after{content:none;}
        textarea{overflow:auto;resize:none;}
        label,summary{cursor:default;}
        a,button{cursor:pointer;}
        h1,h2,h3,h4,h5,h6,em,strong,b{font-weight:bold;}
        del,ins,u,s,a,a:hover{text-decoration:none;}
        body,textarea,input,button,select,keygen,legend{font:12px/1.14 arial,\5b8b\4f53;color:#333;outline:0;}
        body{background:#fff;}
        a,a:hover{color:#333;}
        #word .table tr{
            height: 46px;
        }
        #word .table tr td{
            position: relative;
            padding: 0 10px 0 15px;
        }
        #word .table input{
            height: 28px;
            text-indent: 32px;
            border-radius: 2px;
            border: 1px solid #879fb7;
            color: #268fd8;
        }
        #word .table tr td .icon{
            width: 20px;
            position: absolute;
            left: 25px;
            top: 14px;
        }
        #word .table tr td .add{
            width: 29px;
            height: 30px;
            position: absolute;
            top: 8px;
        //right: 17px;
        }
        #basic_infor .basic_infor_title .basic_infor_title_link a{
            color: #3aa5ff;
            float: right;
            height: 40px;
            line-height: 40px;
        }
        #basic_infor table{width:100%}
        #basic_infor .table tr{
            height: 40px;
            border-bottom: 1px solid #f7f7f7;
        }
        #basic_infor .table .td1 div{
            height: 36px;
            line-height: 36px;
            border-right: 1px solid #d5d5d5;
        }
        #basic_infor .table .td2{
            padding-left:10px;
            padding-right:10px;
        }
        #basic_infor .table .td1{
            width: 100px;
        }
        body{
            background:#efefef;
        }

        .listBox ul li{
        //height: 140px;
            line-height: 22px;
            background: #fff;
            padding: 10px 10px 10px 15px;
            margin-bottom:10px;
        }

        .listBox ul{
            position: relative;

        }
        .listBox .candertext img{
            width: 19px;
            margin-right: 2px;
            margin-bottom: -5px;
        }
        body,ul,li {
            padding:0;
            margin:0;
            border:0;
        }

        body {
            font-size:13px;
            -webkit-user-select:none;
            -webkit-text-size-adjust:none;
            font-family:"Microsoft yahei";
        }
        @-webkit-keyframes loading {
            from { -webkit-transform:rotate(0deg) translateZ(0); }
            to { -webkit-transform:rotate(360deg) translateZ(0); }
        }

        .addbtn img{
            width:55px;
        }


        .head h1,.head h3 {
            width:60px;
            height: 100%;
            color: #ffffff;
            font-size: 12px;
        }
        .head h2 {
            -webkit-box-flex: 1;
            color: #FFFFFF;
            font-size: 14px;
        }
        .head h4{
            color: #FFFFFF;
        }

        .main .all .search input{
            width: 100%;
            height:28px ;
            border-radius: 6px;
            border: none;
            margin-top: 6px;
        }


        .main_2 h1,.main_2 h2{
            float: left;
            line-height: 50px;
        }
        .main_2 h1{
            margin-left: 10px;
        }
        .main_2 h2 input{
            height: 48px;
            width: 250px;
            outline: none;
            border: none;
            margin-left: 10px;
        }
        .r h1{
            font-weight: bold;
            font-size: 14px;
        }

        .list-panel span{margin-right:5px;}

        .list-panel h1{}
        .list-panel textarea{margin-bottom:0px;}


        .pv .left img{    margin-top: 12px; width: 86px; border-radius: 43px;}

        /* reset */
        html,body,h1,h2,h3,h4,h5,h6,div,dl,dt,dd,ul,ol,li,p,blockquote,pre,hr,figure,table,caption,th,td,form,fieldset,legend,input,button,textarea,menu{margin:0;padding:0;}
        header,footer,section,article,aside,nav,hgroup,address,figure,figcaption,menu,details{display:block;}
        table{border-collapse:collapse;border-spacing:0;}
        caption,th{text-align:left;font-weight:normal;}
        html,body,fieldset,img,iframe,abbr{border:0;}
        i,cite,em,var,address,dfn{font-style:normal;}
        [hidefocus],summary{outline:0;}
        li{list-style:none;}
        h1,h2,h3,h4,h5,h6,small{font-size:100%;}
        sup,sub{font-size:83%;}
        pre,code,kbd,samp{font-family:inherit;}
        q:before,q:after{content:none;}
        textarea{overflow:auto;resize:none;}
        label,summary{cursor:default;}
        a,button{cursor:pointer;}
        h1,h2,h3,h4,h5,h6,em,strong,b{font-weight:bold;}
        del,ins,u,s,a,a:hover{text-decoration:none;}
        body,textarea,input,button,select,keygen,legend{font:15px/1.14 "microsoft yahei",\5b8b\4f53;color:#333;outline:0;}
        body{background:#fff;}
        a,a:hover{color:#333;}
        html,body{
            height: 100%;
            width: 100%;
            overflow: hidden;
        }
        .mui-content{
            height: calc(100% - 50px);
            background: #fff;
        }
        .mui-bar-tab~.mui-content{
            padding-bottom:0;
        }
        .mui-content>.mui-table-view:first-child{
            margin-top: 0;
        }
        .backs img,.backs h1{
            float:left;
        }

        .main .all .search input{
            width: 100%;
            height:28px ;
            border-radius: 6px;
            border: none;
            margin-top: 6px;
        }
        #word #table tr{
            height: 46px;
        }
        #word #table tr td{
            position: relative;
            padding: 0 10px 0 15px;
        }
        #word #table input{
            height: 28px;
            text-indent: 32px;
            border-radius: 2px;
            border: 1px solid #879fb7;
            color: #8fc9f1;
            outline:none;
            border:none;
        }

        #basic_infor .basic_infor_title .basic_infor_title_link a{
            color: #3aa5ff;
            float: right;
            height: 40px;
            line-height: 40px;
        }

        #basic_infor .table tr{
            height: 55px;
            border-bottom: 1px solid #f7f7f7;
        }
        #basic_infor .table .td1 div{
            height: 36px;
            line-height: 36px;
            border-right: 1px solid #d5d5d5;
        }
        body{
            background:#fff;

        }

        .listBox ul li{
            height: 68px;
            line-height: 18px;
            background: #fff;
            padding: 10px 10px 10px 15px;
            border:1px solid #f0f0f0;
            padding-right: 9px;

        }
        .listBox ul{
            position: relative;

        }
        .listBox .candertext img{
            width: 19px;
            margin-right: 2px;
            margin-bottom: -5px;
        }
        .listBox .detail_picture{
            width:200px;
            height:200px;
            margin-left:20px;
        }
        .f-right img{
            width:15px;
            height:15px;
        }


        .f-receive img{
            width:15px;
            height:15px;
        }
        .f-forward img{
            width:15px;
            height:15px;
        }
        .f-pictured img{
            width:15px;
            height:15px;
        }
        .wrap{
            position: relative;
            top: 20px;
            background: #fff;
        }
        .right h1{
            color: #000;
            font-size: 16px;
            font-weight: bold;
        }

        .kong{
            display: inline-block;
            width: 108px;
            position: relative;
        }
        .btn{
            padding: 6px 12px;
            background-color: #00a0e9;
            color: #fff;
            border-radius: 6px;
        }
        .titnav{
            margin: 18px 14px 0 14px;
            line-height: 30px;
        }
        .titnav p{
            color: #000;
        }
        .titnav p i{
            color:#00a0e9;
            font-size: 18px;
            font-style: italic;
        }
        .titnav p span{
            font-weight: 700;
        }
        .kong:after {
            position: absolute;
            top: 10px;
            right: 0;
            left: 100px;
            width: 1px;
            height: 38px;
            content: '';
            -webkit-transform: scaleY(.5);
            transform: scaleY(.5);
            background-color: #c8c7cc;
        }
        .kong1{
            display: inline-block;
            width: 108px;
        }
    </style>
</head>

<body data-role="page">
<header data-role="header" class="mui-bar mui-bar-nav" id="header">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" ></a>
    <h1 class="mui-title" id="mtitle">事件下发</h1>
</header>
<div class="mui-content" style="overflow: auto;">
    <div class="titnav">
        <p><i>流水号：No.667</i></p>
        <p><span>事件下发</span>2018-03-30 15：14：22</p>
        <p><span>流程发起人：</span>系统管理员</p>
        <p><span>流程发起：</span>2018-03-30 15：55：12</p>
    </div>
    <ul>
        <li class="ulli">

        </li>
        <li class="ulli" ><span class="kong1">基本信息</span></li>
        <li class="ulli" ><span class="kong">提交人</span><span class="result">回显</span></li>
        <li class="ulli" ><span class="kong">岗位</span><span class="result">回显</span></li>
        <li class="ulli" ><span class="kong">提交时间</span><span class="result">回显</span></li>
        <li class="ulli" ><span class="kong">问题描述</span><span class="result">回显</span></li>
        <li class="ulli" ><span class="kong">问题照片</span><span class="result">回显</span></li>
        <li class="ulli" ><span class="kong">受理社区</span><span class="result">回显</span></li>
        <li class="ulli" ><span class="kong">居委会主任</span><span class="result">回显</span></li>
        <li class="ulli" ><span class="kong">签字日期</span><span class="result">回显</span></li>
        <li class="ulli" ><span class="kong">负责人处理</span><span class="result">回显</span></li>
        <li class="ulli" ><span class="kong">接收日期</span><span class="result">回显</span></li>
        <li class="ulli" ><span class="kong">办理情况描述</span><span class="result">回显</span></li>
        <li class="ulli" ><span class="kong">办理后照片</span<span class="result">回显</span></li>
        <li class="ulli" ><span class="kong1">会签意见区</span></li>
        <li class="ulli" style=" height: 90px;line-height: 90px;margin-top: 10px;"><textarea type="text" style="height: 78px;padding: 8px 0 0 5px;"></textarea></li>
        <li class="ulli" ><span class="kong1">附件</span></li>
    </ul>
</div>

<script>
    var con=''
    var conid

    function mustWrite() {
        if($('.result').text()=='选择时间') {
            mui.toast("请选择开始时间！");
            return false;
        }
        if($('.result1').text()=='选择时间') {
            mui.toast("请选择结束时间！");
            return false;
        }
        if($('#cont').val()=='') {
            mui.toast("请填写内容！");
            return false;
        }
        if($('.result').text()==$('.result1').text()){
            mui.toast("请选择不同时间！");
            return false;
        }
    }
    //取cooke代码

    function getCookie(name)
    {
        var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
        if(arr=document.cookie.match(reg))
            return unescape(arr[2]);
        else
            return null;
    }
    var userId=getCookie('userId')

    $('.nav').on('click','span',function(){
        $('span').removeClass('navc')
        $(this).addClass('navc')
    })
    $('#mailtype').on('click','li',function(){
        $('li').removeClass('navc')
        $(this).addClass('navc')
        con=$(this).text()
        conid=$(this).attr('data-type')
    })
    $('#re_mail').on('click',function(){
        $('#yspan').text(con)
        $('#yspan').attr('data-type',conid)
        $('#modal').removeClass('mui-active')
    })

    var year=new Date().getFullYear() ;

    var  month=new Date().getMonth();

    var day=new Date().getDate();
    $("#demo").click(function(){
        var picker = new mui.DtPicker({
            type: "datetime",//设置日历初始视图模式
            beginDate: new Date(year, month, day),//设置开始日期
            endDate: new Date(2222, 04, 25),//设置结束日期
            labels: ['年', '月', '日', '时', '分'],//设置默认标签区域提示语
        })
        picker.show(function(rs) {
            $(".result").html(  rs.text);  //rs.text.split(' ')[0]只获取年。下标改成1，只获取月，以此类推
            //return false;    //这是阻止对话框关闭的
            picker.dispose();  //释放组件资源，释放后将将不能再操作组件.所以每次用完便立即调用 dispose 进行释放，下次用时再创建新实例
        })
        $('.mui-btn').html('取消');
        $('.mui-btn-blue').html('确定');
    })
    $("#demo1").click(function(){
        var picker = new mui.DtPicker({
            type: "datetime",//设置日历初始视图模式
            beginDate: new Date(year, month, day),//设置开始日期
            endDate: new Date(2222, 04, 25),//设置结束日期
            labels: ['年', '月', '日', '时', '分'],//设置默认标签区域提示语
        })
        picker.show(function(rs) {
            $(".result1").html(  rs.text);  //rs.text.split(' ')[0]只获取年。下标改成1，只获取月，以此类推
//            //return false;    //这是阻止对话框关闭的
            picker.dispose();  //释放组件资源，释放后将将不能再操作组件.所以每次用完便立即调用 dispose 进行释放，下次用时再创建新实例

        })
        $('.mui-btn').html('取消');
        $('.mui-btn-blue').html('确定');

    })
    $('#add').click(function(){
        if(mustWrite()==false) {
            return;
        }
        var content=$('#cont').val();
        var calTime=Date.parse(new Date($('.result').text().replace(/-/g,"/")))/1000;
        var endTime=Date.parse(new Date($('.result1').text().replace(/-/g,"/")))/1000;
        var calType
        if($('.fl').hasClass('navc')){
            calType=1
        }
        if($('.fr').hasClass('navc')){
            calType=2
        }
        var calLevel=$('#yspan').attr('data-type')
        if(calLevel==undefined){
            calLevel=''
        }
        mui.ajax('/schedule/addCalender',{
            data:{
                'calTime':calTime,
                'endTime':endTime,
                'content':content,
                'calType':calType,
                'calLevel':calLevel,
                'userId':userId,
            },
            dataType:'json',//服务器返回json格式数据
            type:'post',//HTTP请求类型
            success:function(data){
                if(data.flag){
                    var btnArray = ['确认'];
                    mui.confirm('保存成功', ' ', btnArray, function(e) {
                        mui.openWindow({
                            url: '/calender/calendarh5'
                        })
                    })
                }else{
                    var btnArray = ['确认'];
                    mui.confirm('保存失败！', ' ', btnArray, function(e) {
                    })
                }
            }
        })
    })

</script>
</body>
</html>
