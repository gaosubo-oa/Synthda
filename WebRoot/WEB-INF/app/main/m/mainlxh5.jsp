<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>蓝信OA</title>
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <link href="../../css/H5/default.css" rel="stylesheet"/>
    <style>
        .nav{
            font-size: 0.28rem;
            color: #666;
            margin: 0 0.2rem;
            line-height: 0.8rem;
            padding-left: 0.18rem;
            position: relative;
        }
        .chunk{
            width: 4px;
            height: 13px;
            background:#7caeff;
            display: inline-block;
            position: relative;
            top: 2px;
            right: 9px;
        }
        .usernav {
            font-size: 0.24rem;
            display: flex;
            /*align-items: center;*/
            background-color: #fff;
            text-align: center;
            flex-wrap: wrap;
        }
        .usernav img{
            width: 0.9rem;
            height: 0.9rem;
            margin:0 auto;
        }
        .usernav div{
            padding-top: 0.15rem;
            color: #666;
        }
        input{
            width: 88%;
            border:1px solid #ccc;
            padding-left: .05rem;
            height: .5rem;
            margin: .1rem 0;
            border-radius: 3px;

        }
        .usernav a{
            width: 25%;
            position: relative;
            margin: .2rem 0;
        }

        .nav:after {
            position: absolute;
            top: 40px;
            right: 0;
            left: 0;
            height: 1px;
            content: '';
            -webkit-transform: scaleY(.5);
            transform: scaleY(.5);
            background-color: #c8c7cc;
        }
        /*.sub-nav{*/
            /*box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);*/
            /*border-radius: .1rem;*/
            /*background-color: #fff;*/
            /*margin: .25rem .2rem;*/
            /*padding: .1rem 0;*/
        /*}*/
        /*.nav{*/
            /*font-size: 0.28rem;*/
            /*color: #1e90ff;*/
            /*line-height: 0.62rem;*/
            /*padding-left: 0.5rem;*/
            /*position: relative;*/
            /*background-color: #f0f1f3;*/
            /*bottom: 5px;*/
            /*border-radius: 5px 5px 0px 0px;*/
            /*box-shadow: 0px 1px 3px #aeaeae;*/
        /*}*/
        /*body{*/
            /*background-color: #91b1da;*/
        /*}*/
    </style>
    <script type="text/javascript">
        var fs = document.documentElement.clientWidth / 750  * 100;
        document.querySelector("html").style.fontSize = fs + "px";
    </script>
</head>
<body>
<div class="mui-content" style="background: #ffffff;">
    <%--&lt;%&ndash;网格中心&ndash;%&gt;--%>
    <%--<div>--%>
        <%--<p class="nav"><span class="chunk"></span>网格中心</p>--%>
        <%--<div>--%>
            <%--<section class="usernav">--%>
                <%--<a href="javascript:;" class="alerts">--%>
                    <%--<img src="../../img/LXH5/Gridmap.png"/>--%>
                    <%--<div>网格地图</div>--%>
                <%--</a>--%>
            <%--</section>--%>
        <%--</div>--%>
    <%--</div>--%>

    <%--&lt;%&ndash;智慧城建&ndash;%&gt;--%>
    <%--<div>--%>
        <%--<p class="nav"><span class="chunk"></span>智慧城建</p>--%>
        <%--<div>--%>
            <%--<section class="usernav">--%>
                <%--<a href="javascript:;" class="alerts">--%>
                    <%--<img src="../../img/LXH5/policyAndRegulationManagement.png"/>--%>
                    <%--<div>环保政策法规</div>--%>
                <%--</a>--%>
                <%--<a href="javascript:;" class="alerts">--%>
                    <%--<img src="../../img/LXH5/huanbaoliucheng.png"/>--%>
                    <%--<div>环保流程</div>--%>
                <%--</a>--%>
                <%--<a href="javascript:;" class="alerts">--%>
                    <%--<img src="../../img/LXH5/huanbaoseshi.png"/>--%>
                    <%--<div>环保设施</div>--%>
                <%--</a>--%>
                <%--<a href="javascript:;" class="alerts">--%>
                    <%--<img src="../../img/LXH5/videoSurveillanceQiye.png"/>--%>
                    <%--<div>动态监管台账</div>--%>
                <%--</a>--%>
                <%--<a href="javascript:;" class="alerts">--%>
                    <%--<img src="../../img/LXH5/huanbaoAnjian.png"/>--%>
                    <%--<div>环保案件处理</div>--%>
                <%--</a>--%>
                <%--<a href="javascript:;" class="alerts">--%>
                    <%--<img src="../../img/LXH5/huanbaoxunjian.png"/>--%>
                    <%--<div>环保巡检</div>--%>
                <%--</a>--%>
                <%--<a href="javascript:;" class="alerts">--%>
                    <%--<img src="../../img/LXH5/shijiepaifa.png"/>--%>
                    <%--<div>事件派发</div>--%>
                <%--</a>--%>
                <%--<a href="javascript:;" class="alerts">--%>
                    <%--<img src="../../img/LXH5/xunJianTongji.png"/>--%>
                    <%--<div>巡检统计</div>--%>
                <%--</a>--%>
                <%--<a href="javascript:;" class="alerts">--%>
                    <%--<img src="../../img/LXH5/shiJianTongji.png"/>--%>
                    <%--<div>事件统计</div>--%>
                <%--</a>--%>
                <%--<a href="javascript:;" class="alerts">--%>
                    <%--<img src="../../img/LXH5/paifatongji.png"/>--%>
                    <%--<div>派发统计</div>--%>
                <%--</a>--%>
                <%--<a href="javascript:;" class="alerts">--%>
                    <%--<img src="../../img/LXH5/kongqizhongwuran.png"/>--%>
                    <%--<div>空气重污染</div>--%>
                <%--</a>--%>
                <%--<a href="javascript:;" class="alerts">--%>
                    <%--<img src="../../img/LXH5/huanbaokaohe.png"/>--%>
                    <%--<div>环保考核</div>--%>
                <%--</a>--%>
            <%--</section>--%>
        <%--</div>--%>
    <%--</div>--%>

    <%--&lt;%&ndash;智慧综治&ndash;%&gt;--%>
        <%--<div>--%>
            <%--<p class="nav"><span class="chunk"></span>智慧综治</p>--%>
            <%--<div>--%>
                <%--<section class="usernav">--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/fangWuguanli.png"/>--%>
                        <%--<div>流动人口与出租房屋管理</div>--%>
                    <%--</a>--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/maoDunJiufengGuanli.png"/>--%>
                        <%--<div>矛盾纠纷排查管理</div>--%>
                    <%--</a>--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/zhiyuanzheguanli.png"/>--%>
                        <%--<div>社区志愿者管理</div>--%>
                    <%--</a>--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/xinxibaosong.png"/>--%>
                        <%--<div>信息报送系统</div>--%>
                    <%--</a>--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/jichushuju.png"/>--%>
                        <%--<div>基础数据</div>--%>
                    <%--</a>--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/shequxinxicaiji.png"/>--%>
                        <%--<div>社区信息采集系统</div>--%>
                    <%--</a>--%>
                <%--</section>--%>
            <%--</div>--%>
        <%--</div>--%>

    <%--&lt;%&ndash;智慧安全&ndash;%&gt;--%>
        <%--<div>--%>
            <%--<p class="nav"><span class="chunk"></span>智慧安全</p>--%>
            <%--<div>--%>
                <%--<section class="usernav">--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/zongzhiZhenchefagui.png"/>--%>
                        <%--<div>安全政策法规</div>--%>
                    <%--</a>--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/anquanzhanting.png"/>--%>
                        <%--<div>安全教育展厅</div>--%>
                    <%--</a>--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/videoSurveillanceQiye.png"/>--%>
                        <%--<div>安全网格管理</div>--%>
                    <%--</a>--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/anquanxuanchunahuodong.png"/>--%>
                        <%--<div>安全宣传活动</div>--%>
                    <%--</a>--%>

                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/aanquanrichangguanli.png"/>--%>
                        <%--<div>安全日常管理</div>--%>
                    <%--</a>--%>
                <%--</section>--%>
            <%--</div>--%>
        <%--</div>--%>


    <%--&lt;%&ndash;系统管理&ndash;%&gt;--%>
        <%--<div>--%>
            <%--<p class="nav"><span class="chunk"></span>系统管理</p>--%>
            <%--<div>--%>
                <%--<section class="usernav">--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/MeunSetting.png"/>--%>
                        <%--<div>菜单设置</div>--%>
                    <%--</a>--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/ControlPanel.png"/>--%>
                        <%--<div>控制面板</div>--%>
                    <%--</a>--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/OrganizationSetting.png"/>--%>
                        <%--<div>组织机构管理</div>--%>
                    <%--</a>--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/Gridmembersetup.png"/>--%>
                        <%--<div>网格员管理</div>--%>
                    <%--</a>--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/GridinformationSettings.png"/>--%>
                        <%--<div>网格信息管理</div>--%>
                    <%--</a>--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/dangjianguanli.png"/>--%>
                        <%--<div>党建管理</div>--%>
                    <%--</a>--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/chengjianguanli.png"/>--%>
                        <%--<div>城建管理</div>--%>
                    <%--</a>--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/anquanguanli.png"/>--%>
                        <%--<div>安全管理</div>--%>
                    <%--</a>--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/menhushezhi.png"/>--%>
                        <%--<div>门户设置</div>--%>
                    <%--</a>--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/WorkFlowSetting.png"/>--%>
                        <%--<div>工作流设置</div>--%>
                    <%--</a>--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/Schedule.png"/>--%>
                        <%--<div>日程安排</div>--%>
                    <%--</a>--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/InterfaceSetting.png"/>--%>
                        <%--<div>界面设置</div>--%>
                    <%--</a>--%>
                    <%--<a href="javascript:;" class="alerts">--%>
                        <%--<img src="../../img/LXH5/ScheduleQuery.png"/>--%>
                        <%--<div>日程安排查询</div>--%>
                    <%--</a>--%>
                <%--</section>--%>
            <%--</div>--%>
        <%--</div>--%>

</div>
</body>
<script>
    $(function(){
        $.ajax({
            method:'get',
            url:'/showMenu',
            data:'',
            dataType:'json',
            success:function(res){
                var str='';
                $.each(res.obj,function(index,item){
                    str+='<div>'+
                        '<p class="nav"><span class="chunk"></span>'+item.name+'</p>'+
                        '<div>'+
                        '<section class="usernav">';
                    for(var i=0;i<item.child.length;i++){
                        var b
                        if(item.child[i].name1==undefined){
                            b= ''
                        }else {
                            var a=item.child[i].name1
                            b = a.replace(/\s/g,'');
                        }
                        var chiild=0
                        if(item.child[i].child && item.child[i].child.length >0){
                            chiild = 1;
                        }
                        str+=
                            '<a id="'+item.child[i].id+'" fId="'+item.child[i].fId+'" url="/'+item.child[i].url+'" child="'+chiild+'" class="alerts">'+
                            '<img src="../../img/menu/'+b+'.png"/>'+
                            '<div>'+item.child[i].name+'</div>'+
                            '</a>'
                    }
                    str += '</section>'+
                        '</div>'+
                        '</div>';
                })
                $('.mui-content').html(str)
            }
        })


        $('.mui-content').on('click','a',function(){
            var child=$(this).attr('child')
            var menuId=$(this).attr('id')
            if(child==0){
                var url=$(this).attr('url')
                $(this).attr('href',url)
            }
            if(child==1){
                window.location.href='/m/gettwoMenu?menuId='+menuId
            }
        })
    })
</script>
</html>