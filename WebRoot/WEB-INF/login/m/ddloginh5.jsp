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
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>钉钉首页入口-组织</title>
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script src="../../js/H5/dingtalk.js"></script>
    <link href="../../css/H5/default.css" rel="stylesheet"/>
    <style>
        header {
            background-color: #5077aa;
            height: 0.85rem;
            align-items: center;
            font-size: 0.28rem;
            color: #fff;
            padding-left: 0.23rem;
            padding-right: 0.23rem;
            text-align: center;
            line-height: 0.85rem;
            position: fixed;
            width: 100%;
            z-index: 1;
        }
        .hd{
            height: 0.85rem;
        }
        #con{
            /*text-align: right;*/
            /*margin-right: 2rem;*/
            font-size: 0.33rem;
            /*margin-top: 1rem;*/
        }
        #con p{
            padding-top: .2rem;
        }
        #con p input{
            position: relative;
            bottom: .03rem;
            left: .23rem;
        }
        #con p label span{
            display: inline-block;
            width: 80%;
            text-align: right;
        }
        .ent{
            width: 1.5rem;
            height: .65rem;
            background-color: #5077aa;
            text-align: center;
            line-height: .65rem;
            color: #fff;
            font-size: .28rem;
            border-radius: .16rem;
            margin: .7rem auto;
        }
        #adders{
            color: #fff;
        }
    </style>
</head>
<body>
<header>

    <span><fmt:message code="label.replace.name" /></span>

</header>
<div class="hd"></div>
<div id="con"></div>
<div class="ent"><a id="adders" href="javascript:;">选择组织</a></div>
</body>
<script>
    var corpId = '<%=corpId%>';
    var corpSecret = '<%=corpSecret%>';
    var fs = document.documentElement.clientWidth / 750  * 100;
    document.querySelector("html").style.fontSize = fs + "px";
    $(function(){

        $.ajax({
            url:'/getCompanyAll',
            type:'get',
            dataType:'json',
            success:function(res){
                if(res.flag){
                    var app="";
                    for(var i=0;i<res.obj.length;i++){
                        app+='<p><label><span>'+res.obj[i].name+'</span><input type="radio"  oid='+res.obj[i].oid+' value="'+res.obj[i].name+'" name="activity"></label></p>'
                    }
                    $('#con').html(app)
                }

            }
        })
        $('#adders').click(function(){

            var oid=$("input[name='activity']:checked").attr('oid');    
            $("#corpId").val(corpId);
            $("#corpSecret").val(corpSecret);
            dd.ready(function() {
                dd.runtime.permission.requestAuthCode({
                    corpId: corpId,
                    onSuccess: function(result) {
                        $.ajax({
                            url:'/m/dingdingLoginH5',
                            type:'POST',
                            data:{
                                corpId:corpId,
                                corpSecret:corpSecret,
                                code:result.code,
                                oId:oid
                            },
                            dataType:'json',
                            success:function (res) {
                                if(res.flag) {
                                    window.open('/m/getMainddh5','_self');
                                } else {
                                    alert(res.msg+'！')
                                }
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
    })
</script>
</html>