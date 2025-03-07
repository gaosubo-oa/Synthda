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
<head>
    <meta charset="UTF-8">
    <title><fmt:message code="main.statusbarset" /></title>
    <style type="text/css">
        *{margin: 0;padding: 0;}
        body{font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;position: relative;top: 0;left: 0;width: 100%;height: 100%;}
        a{text-decoration: none;color: #2B7FE0;}
        ul{list-style: none;}
        .content{width: 100%;height: 100%;overflow: hidden;}
        .content .headDiv{width: 100%;height: 45px;border-bottom: #999 1px solid;overflow: hidden;position: fixed;top: 0;left: 0;background: #fff;}
        .content .header{display: block;height: 45px;line-height: 45px;font-size: 20px;margin-left: 30px;}
        .content .main{width: 95%;margin: 20px auto;border: #ccc 1px solid;margin-top: 70px;}
        .content .main .title{width: 100%;height: 34px;border-bottom: #ccc 1px solid;}
        .content .main .title span{height: 100%;line-height: 34px;font-size: 14px;margin-left: 10px;}
        .content .main .text{width: 100%;border-bottom: #ccc 1px solid;}
        .content .main .text textarea{width: 99%;min-height: 300px;margin: 4px;outline: none;border: #ccc 1px solid;}
        .content .main .text p{font-size: 14px;color: #666;margin: 6px 0 10px 10px;}
        .content .main .time{width: 100%;border-bottom: #ccc 1px solid;padding: 10px 0;}
        .content .main .time span{font-size: 14px;margin-left: 10px;color: #666;}
        .content .main .sureBtn{width: 100%;}
        .content .main .sureBtn .btn{width: 70px;height: 28px;margin: 5px auto;text-align: center;line-height: 28px;font-size: 14px;cursor: pointer;background: url("../img/sys/icon_confirm.png") no-repeat;background-size:100% 100%; }
        .divP{
            float: left;
            height: 45px;
            line-height: 45px;
            font-size: 22px;
            margin-left: 12px;
            color:#494d59;
        }
        .div_Img{
            float: left;
            width: 23px;
            height: 100%;
            margin-left: 30px;
        }
        .div_Img img{
            width: 23px;
            height: 23px;
            margin-top: 13px;
        }
    </style>
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" ></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script>
        $(function(){
            $('#btn').click(function(){
                modifyTime();
                modifyText();
            });
            scarchTime($('.seaTime'));
            searchText($('#seachTxt'));

            //修改时间
            function modifyTime(){
                var moTime=$('.seaTime').val();
                $.ajax({
                    type:'get',
                    url:'/syspara/updateSysParaByParaName',
                    dataType:'json',
                    data:{'paraName':'STATUS_TEXT_MARQUEE','paraValue':moTime},
                    success:function(rsp){
                        if(rsp.flag==true){
                            //console.log('<fmt:message code="depatement.th.Modifysuccessfully" />');
                        }else{
                            //console.log('<fmt:message code="depatement.th.modifyfailed" />');
                        }
                    }
                })
            }
            //修改文字
            function modifyText(){
                var moTxt=$('#seachTxt').val();
                $.ajax({
                    type:'get',
                    url:'/sys/editStatusText',
                    dataType:'json',
                    data:{'statusText':moTxt},
                    success:function(rsp){
                        if(rsp.flag==true){
                           // alert('修改成功');
                            layer.msg('<fmt:message code="depatement.th.Modifysuccessfully" />', {icon: 1});
                        }else{
                           // alert('修改失败');
                            layer.msg('<fmt:message code="depatement.th.modifyfailed" />', {icon: 2});
                        }
                    }
                })
            }

        });
        //查询时间
        function scarchTime(element){
            $.ajax({
                type:'get',
                url:'/syspara/selectTheSysPara',
                dataType:'json',
                data:{'paraName':'STATUS_TEXT_MARQUEE'},
                success:function(rsp){
                    var data=rsp.object;
                    element.val(data[0].paraValue);
                }
            })
        }
        //查询状态栏文字
        function searchText(element){
            $.ajax({
                type:'get',
                url:'/sys/getStatusText',
                dataType:'json',
                success:function(rsp){
                    var data=rsp.object;
                    var str = "";
                    data.forEach(function (v,i) {
                        if(v != ''){
                            str+=(v+'\n\r');
                        }

                    });
                    //console.log(str);
                    element.val(str);
                }
            })
        }
    </script>
</head>
<body>
<div class="content">
    <div class="headDiv">
        <div class="div_Img">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_statusBarSet.png" style="vertical-align: middle;" alt="菜单主分类设置">
        </div>
        <div class="divP"><fmt:message code="main.statusbarset" /></div>
    </div>
    <div class="main">
        <div class="title">
            <span><fmt:message code="system.th.StatusBar" /></span>
        </div>
        <div class="text">
            <textarea name="txt" id="seachTxt"></textarea>
            <p><fmt:message code="system.th.Tip" /></p>
        </div>
        <div class="time">
            <span><fmt:message code="system.th.Scroll" />：</span>
            <input type="text" class="seaTime" />
            <span><fmt:message code="system.th.second" /></span>
        </div>
        <div class="sureBtn">
            <div class="btn" id="btn"><span style="margin-left: 20px;"><fmt:message code="global.lang.ok" /></span></div>
        </div>
    </div>
</div>
</body>
</html>
