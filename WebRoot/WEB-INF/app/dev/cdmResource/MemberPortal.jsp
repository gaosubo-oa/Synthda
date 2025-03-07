<%--
  Created by IntelliJ IDEA.
  User: 椰子
  Date: 2022/1/28
  Time: 10:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>会员门户</title>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
</head>
<body >
<div class="s_container c_container new_total">
    <ul class="new_talk">
        <center><button id="reserved" style="height: 100px;width: 500px;font-size: 25px;margin-top: 10%" onclick="ziyuanyuding()">请预定钻石、铂金、黄金、白银资源包</button></center>
        <center><button id="reserveds" style="height: 100px;width: 500px;font-size: 25px;margin-top: 10%;display: none" onclick="ziyuanyudinger()">点击进入第二轮资源包预定</button></center>
    </ul>
</div>
</body>
</html>
<script>
    function ziyuanyuding(){
        window.location.href='/cdmResource/BusinessResourceReservation'
    }
    function ziyuanyudinger(){
        $.ajax({
            url:'/getLoginUser',
            type: "post",
            dataType: "json",
            success:function (res) {
                var userId=res.object.userId
                window.location.href='/cdmResource/BusinessResourceReservationTwo?userId='+userId
            }
        })
    }
    $.ajax({
        url:'/cdmResource/selectSysParaByPrivNo',
        type: "post",
        dataType: "json",
        success:function (res) {
            console.log(res)
            if(res.object.paraValue == ''){
                $("#reserved").show()
            }else{
                $("#reserved").hide()
                $.ajax({
                    url:'/cdmResource/selectSysParaByValue',
                    type: "post",
                    dataType: "json",
                    success:function (res) {
                        if(res.flag){
                            $("#reserved").hide()
                            $("#reserveds").show()
                        }else{
                            $("#reserved").hide()
                            $("#reserveds").hide()
                        }

                    }
                })
            }
        }
    })
</script>
