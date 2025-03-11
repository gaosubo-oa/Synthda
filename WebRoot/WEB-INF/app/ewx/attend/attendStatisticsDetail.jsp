<%--
  Created by IntelliJ IDEA.
  User: gaoran
  Date: 2020/3/27
  Time: 14:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>考勤统计</title>
    <link rel="stylesheet" href="../../css/email/m/jquery.mobile.css" />
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>

    <link rel="stylesheet" href="../../css/email/m/styles.css" />
    <link rel="stylesheet" href="../../css/email/m/style.css">
    <link rel="stylesheet" href="../../css/email/m/mail.css">
    <script type="text/javascript" src="../../js/notes/jquery-2.1.2.min.js" ></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <%--<script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>--%>
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <script type="text/javascript" src="../../js/diary/m/simbaJs.js" ></script>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/base.js?20190927.1"></script>
    <link rel="stylesheet" href="../../lib/mui/mui/mui.picker.min.css" />
    <script type="text/javascript" src="../../lib/mui/mui/mui.picker.min.js" ></script>
    <style>
        #header h1{
            color: #fff;
        }

        .mui-content {
            height: calc(100% - 45px);
            background: #fff;
        }
        .mui-input-row span{
            /*float: right;*/
            line-height: 40px;
        }
        .mui-bar-nav~.mui-content {
            height: 100%;
            background: #fff;
            overflow: auto;
        }
        .mui-input-row label {
            padding-left: 0;
            font-family: 'microsoft yahei';
            width: 96px;
            font-size: 13px;
        }
        .nav span{
            width: 48%;
            display: inline-block;
            text-align: center;
        }

        .result,.result1{
            color:#00a0e9;
            padding-left: 17px;
        }
        .mui-input-row label{
            padding-left: 0;
            font-family:'microsoft yahei';
            width: 96px;
        }
        .mui-input-row label~input{
            float: left;
            padding: 10px 0;
            width: calc(100% - 120px);
        }
        .mui-content {
            height: 100%;
            background: #fff;
            overflow: auto;
        }
        #beginTime{
            display: block;
            width: 48%;
            margin: 0 auto;
        }
        .attendance{
            color: #ccc;
            font-size: 14px;
        }
        .radiu{
            width: 2.9rem;
            height: 2.9rem;
            font-size: .09rem;
            line-height: 2.9rem;
            text-align: center;
            color: #00CCFF;
            border-radius: 50%;
            border: 1px solid #00CCFF;
            float: left;
            margin-top:.55rem;
            margin-left: 0.8rem;
            overflow: hidden;
        }
        .iconLeft{
            width: .3rem;
            height: 1.1rem;
            display: inline-block;
            background-color: #7c86bf;
            margin-left: .4rem;
            vertical-align: sub;
            margin-right: .5rem;
        }
        .iconRight{
            width: .3rem;
            height: 1.1rem;
            display: inline-block;
            background-color: #FFCC66;
            margin-left: .4rem;
            vertical-align: sub;
            margin-right: .5rem;
        }
        .box{
            height: 2rem;
            line-height: 2rem;
            color: #ccc;
            padding-left: 1.2rem;
            background-color: #f2f2f6
        }
        .text{
            height: 4rem;
            border-bottom: 1px solid #ccc;
            font-size: 17px;
            line-height: 4rem;
            padding-left: 1rem;
        }
        .datas{
            height: 2.4rem;
            display: block;
            color: #00CCFF;
            width: 80%;
            border: 1px solid #00CCFF;
            border-radius: 0.4rem;
            margin: 0 auto;
            line-height: 2.4rem;
            text-align: center;
        }
    </style>
</head>
<body>
<%--头部的时间--%>
<div class="mui-content" id="aaa" style="overflow: auto;">
    <ul>
        <li class="mui-table-view-cell mui-input-row" id="demo"><span class="result  name='vuStart'" id="beginTime"></span></li>
        <li style="height: 4.2rem;">
            <div class="radiu"></div>
            <div style="font-size: 15px;width: 17rem; padding-top: .8rem;margin-left: 4rem;box-sizing: border-box">
                <p style="line-height: 1.5rem;" id="name"></p>
                <div class="attendance">考勤默认类型：一个月的考勤类型</div>
            </div>
        </li>
        <li style="border-bottom: 1px solid #c8c7cc;width: 99%;margin-left: 1rem;"></li>
    </ul>
    <%--出勤率--%>
    <div style="display: flex;height: 2.5rem;line-height: 2.5rem">
        <div style="width: 50%;flex: 1;">
            <span class="iconLeft"></span>
            <span class="sname">出勤天数</span>
            <span class="type" style="float: right;margin-right: 1rem;margin-left: .3rem;color: blue"></span>
            <span class="num" style="float: right;color: blue"></span>
        </div>
        <div style="width: 50%;flex: 1">
            <span class="iconRight"></span>
            <span class="sname1">正常打卡</span>
            <span class="type1" style="float: right;margin-right: 1rem;margin-left: .3rem;color: blue"></span>
            <span class="num1" style="float: right;color: blue"></span>
        </div>
    </div>
    <div style="display: flex;height: 2.5rem;line-height: 2.5rem">
        <div style="width: 50%;flex: 1;">
            <span class="iconLeft"></span>
            <span class="sname2">外勤打卡</span>
            <span class="type2" style="float: right;margin-right: 1rem;margin-left: .3rem;color: blue"></span>
            <span class="num2" style="float: right;color: blue"></span>
        </div>
        <div style="width: 50%;flex: 1">
            <span class="iconRight"></span>
            <span class="sname3">早退</span>
            <span class="type3" style="float: right;margin-right: 1rem;margin-left: .3rem;color: blue"></span>
            <span class="num3" class="" style="float: right;color: blue"></span>
        </div>
    </div>
    <div style="display: flex;height: 2.5rem;line-height: 2.5rem">
        <div style="width: 50%;flex: 1;">
            <span class="iconLeft"></span>
            <span class="sname4">缺卡</span>
            <span class="type4" style="float: right;margin-right: 1rem;margin-left: .3rem;color: blue"></span>
            <span class="num4" style="float: right;color: blue"></span>
        </div>
        <div style="width: 50%;flex: 1">
            <span class="iconRight"></span>
            <span class="sname5">迟到</span>
            <span  class="type5" style="float: right;margin-right: 1rem;margin-left: .3rem;color: blue"></span>
            <span class="num5" style="float: right;color: blue"></span>
        </div>
    </div>
    <div style="display: flex;height: 2.5rem;line-height: 2.5rem">
        <div style="width: 50%;flex: 1;">
            <span class="iconLeft"></span>
            <span class="sname6">矿工</span>
            <span class="type6" style="float: right;margin-right: 1rem;margin-left: .3rem;color: blue"></span>
            <span class="num6" style="float: right;color: blue"></span>
        </div>
        <div style="width: 50%;flex: 1">
            <span class="iconRight"></span>
            <span class="sname7">设备异常</span>
            <span class="type7" style="float: right;margin-right: 1rem;margin-left: .3rem;color: blue"></span>
            <span class="num7" style="float: right;color: blue"></span>
        </div>
    </div>
    <div style="display: flex;height: 2.5rem;line-height: 2.5rem">
        <div style="width: 50%;flex: 1;">
            <span class="iconLeft"></span>
            <span class="sname8">请假</span>
            <span class="type8" style="float: right;margin-right: 1rem;margin-left: .3rem;color: blue"></span>
            <span class="num8" style="float: right;color: blue"></span>
        </div>
        <div style="width: 50%;flex: 1">
            <span class="iconRight"></span>
            <span class="sname9">加班</span>
            <span class="type9" style="float: right;margin-right: 1rem;margin-left: .3rem;color: blue"></span>
            <span class="num9" style="float: right;color: blue"></span>
        </div>
    </div>
    <div style="display: flex;height: 2.5rem;line-height: 2.5rem">
        <div style="width: 50%;flex: 1;">
            <span class="iconLeft"></span>
            <span class="sname10">外出</span>
            <span class="type10" style="float: right;margin-right: 1rem;margin-left: .3rem;color: blue"></span>
            <span class="num10" style="float: right;color: blue"></span>
        </div>
        <div style="width: 50%;flex: 1">
            <span class="iconRight"></span>
            <span class="sname11">出差</span>
            <span class="type11" style="float: right;margin-right: 1rem;margin-left: .3rem;color: blue"></span>
            <span class="num11" style="float: right;color: blue"></span>
        </div>
    </div>
    <div style="padding-top: 0.9rem;box-sizing: border-box;height: 5rem">
        <a id="ming"  class="datas">按日期查看明细</a>
    </div>
    <div class="attend_t_div" style="height: 6rem;">
        <div class="box">迟到记录</div>
        <div class="box">早退记录</div>
        <div class="box">缺卡记录</div>
    </div>

</div>
<script>
    // 获取地址栏参数值
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }
    function GetUrlByParamName(name){ //获取地址栏传得文字
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var URL =  decodeURI(window.location.search);
        var r = URL.substr(1).match(reg);
        if(r!=null){
            //decodeURI() 函数可对 encodeURI() 函数编码过的 URI 进行解码
            return  decodeURI(r[2]);
        };
        return null;
    };
    $('#ming').click(function(){
        window.location.href="/ewx/attendStatisticsDayDetail?type=1&uid="+uid
    })
    //使用GetUrlByParamName()方法获取url中参数名为questionnaireName的参数内容
    var username = GetUrlByParamName("username");
    var uid = getQueryString('uid')
    $('.radiu').html(username)
    $('#name').html(username)
    var year=new Date().getFullYear() ;
    var  month=new Date().getMonth();
    var day=new Date().getDate();
    $('#beginTime').append(getNowTime)

    $("#demo").click(function(){
        var picker = new mui.DtPicker({
            type: "datetime",//设置日历初始视图模式
            beginDate: new Date(year, month, day),//设置开始日期
            endDate: new Date(2222, 12, 25),//设置结束日期
            labels: ['年', '月', '日', '时', '分'],//设置默认标签区域提示语
        })
        picker.show(function(rs) {

            $(".result").html(rs.text);  //rs.text.split(' ')[0]只获取年。下标改成1，只获取月，以此类推
//
//            //return false;    //这是阻止对话框关闭的
//
            attendQuery(rs.y.text+"-"+rs.m.text);
            picker.dispose();  //释放组件资源，释放后将将不能再操作组件.所以每次用完便立即调用 dispose 进行释放，下次用时再创建新实例
        })
        $('.mui-btn').html('取消');
        $('.mui-btn-blue').html('确定');
    })

    attendQuery();
    function attendQuery(date){
        var start = nowformat();
        if(date){
            start = date;
        }
        $.ajax({
            url:'/attend/myAttendance',
            dataType:'json',//服务器返回json格式数据
            type:'post',//HTTP请求类型
            data:{
                strat:start,
                uid : uid
            },
            success:function(res){
                var list = res.data.attendList
                $('.type').html(list[0].type)
                $('.num').html(list[0].num)
                $('.type1').html(list[1].type)
                $('.num1').html(list[1].num)
                $('.type2').html(list[2].type)
                $('.num2').html(list[2].num)
                $('.type3').html(list[3].type)
                $('.num3').html(list[3].num)
                $('.type4').html(list[4].type)
                $('.num4').html(list[4].num)
                $('.type5').html(list[5].type)
                $('.num5').html(list[5].num)
                $('.type6').html(list[6].type)
                $('.num6').html(list[6].num)
                $('.type7').html(list[7].type)
                $('.num7').html(list[7].num)
                $('.type8').html(list[8].type)
                $('.num8').html(list[8].num)
                $('.type9').html(list[9].type)
                $('.num9').html(list[9].num)
                $('.type10').html(list[10].type)
                $('.num10').html(list[10].num)
                $('.type11').html(list[11].type)
                $('.num11').html(list[11].num)




                var str=""
                var list2 = res.data.list;
                for(var i=0,length=list2.length;i<length;i++){
                    var attend_t = list2[i];
                    if(attend_t.sname){
                        str+='<div class="box">'+attend_t.sname+'</div>';
                    }
                    var rem = attend_t.remarksList;
                    if(rem.length>0){
                        for(var j=0;j<rem.length;j++){
                            str+=' <div class="text"><span>'+rem[j].date+'</span><span style="margin-left: 5px;">'+rem[j].week+'</span></div>'
                        }
                    }

                }

                $('.attend_t_div').html(str);
            }
        })
    }


    //获取当前时间  年月日时分
    function getNowTime() {
        var date = new Date();
        this.year = date.getFullYear();
        this.month = date.getMonth() + 1;
        this.date = date.getDate();
        if(this.month<10){
            this.month = "0"+this.month;
        }
        if(this.date<10){
            this.date = "0"+this.date;
        }
        this.hour = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
        this.minute = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
        var currentTime = this.year+'-'+this.month + '-' + this.date + ' ' + this.hour + ':' + this.minute;
        return currentTime;
    }
    //当前月份
    function nowformat() {
        var  nstr = "";
        var now = new Date();
        var nyear = now.getFullYear();
        var nmonth = now.getMonth()+1;
        var nday = now.getDate();
        if(nmonth<10){
            nmonth = "0"+nmonth;
        }
        nstr = nyear+"-"+nmonth;
        return nstr;
    }

</script>
</body>
</html>
