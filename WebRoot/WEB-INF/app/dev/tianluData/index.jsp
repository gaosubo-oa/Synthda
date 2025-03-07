<%--
  Created by IntelliJ IDEA.
  User: Gsubo
  Date: 2020/12/4
  Time: 15:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>天录系统用户同步</title>
    <link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../css/enterpriseManage/weixinqy.css">
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/unslider.min.js"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
</head>
<body>

<div>
    <legend><h5>天录系统用户同步</h5></legend>

    <select id="schools" >

    </select>

    <button id="syn_data">确定同步</button>
</div>
<script type="text/javascript" >


    $(function(){

        $.ajax({
            url:'/tianLuData/selectSchools',
            type:'get',
            dataType:'json',
            success:function (res) {
                if(res.flag){
                    var objs = res.data;
                    var strs = '';
                    for (var i = 0; i < objs.length; i++) {
                        strs+='<option value="'+objs[i]._schoolid+'">'+objs[i]._schoolname+'</option>'
                    }
                    $('#schools').html(strs)
                }
            }
        })

        $("#syn_data").click(function(){
            var schoolId = $('#schools').val();
            $.ajax({
                url:'/tianLuData/synUsers',
                type:'POST',
                data:{
                    schoolId:schoolId
                },
                dataType:'json',
                success:function (res) {
                    if(res.flag){

                    }
                }
            })
        });
    })


</script>
</body>
</html>
