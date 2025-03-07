<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String corpId = (String)request.getAttribute("corpId");
    String corpSecret = (String)request.getAttribute("corpSecret");
    String oId = request.getParameter("oId");
%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>收文管理</title>
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script src="../../js/H5/dingtalk.js"></script>
    <link href="../../css/H5/default.css" rel="stylesheet"/>
    <style>
        header {
            height: 0.85rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 0.32rem;
            color: #fff;
            padding-left: 0.23rem;
            padding-right: 0.23rem;
            position: fixed;
            width: 100%;
            z-index: 1;
            background-color: #3984ff;
            box-shadow: 1px 1px 7px rgba(0, 0, 0, .85);
        }
        .usernav {
            font-size: 0.24rem;
            height: 2rem;
            display: flex;
            align-items: center;
            text-align: center;
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
        .hd{
            height: 0.85rem;
        }
        .usernav a{
            width: 25%;
            position: relative;
        }

        body{
            background:  #e6ebec;
        }
    </style>
    <script type="text/javascript">
        var fs = document.documentElement.clientWidth / 750  * 100;
        document.querySelector("html").style.fontSize = fs + "px";
    </script>
</head>
<body>
<header>
    <i><a href="/m/getMainddh5" style="color: #fff">返回</a></i>
    <span>收文管理</span>
    <i style="width: .4rem"></i>
</header>
<div class="hd"></div>
<div>
    <section class="usernav">
        <a href="/document/getAgencyReceipth5">
            <img src="../../img/H5/5.3.png"/>
            <div>待办收文</div>
        </a>
        <a href="/document/getBeenOfficeh5">
            <img src="../../img/H5/5.4.png"/>
            <div>已办收文</div>
        </a>
        <%--<a href="/document/getMyinboxh5">--%>
            <%--<img src="../../img/H5/3.1.png"/>--%>
            <%--<div>我的收文</div>--%>
        <%--</a>--%>
    </section>
</div>

</div>
<script>
    var corpId = '<%=corpId%>';
    var corpSecret = '<%=corpSecret%>';
    var oId = <%=oId%>;

    $(function() {

        $("#corpId").val(corpId);
        $("#corpSecret").val(corpSecret);
        dd.ready(function() {
            dd.runtime.permission.requestAuthCode({
                corpId: corpId,
                onSuccess: function(result) {
                    $.ajax({
                        url:'/dingdingManage/dingdingCodeGetUser',
                        type:'POST',
                        data:{
                            corpId:corpId,
                            corpSecret:corpSecret,
                            code:result.code,
                            oId:oId
                        },
                        dataType:'json',
                        success:function (res) {
                            if(res.flag) {
                                $("#flag").val("成功"+res.msg);
                                $("#userName").val(res.data.userName);
                                $("#userPrivName").val(res.data.userPrivName);
                            } else {
                                $("#flag").val("失败"+res.msg);
                            }
                        },
                        error : function(XMLHttpRequest, textStatus, errorThrown) {
                            $("#flag").val(errorThrown);
                        }
                    })

                    $("#result").val(result.code);
                },
                onFail : function(err) {
                    //加一个错误提示
                }

            });
        });
    })
</script>


</body>
</html>