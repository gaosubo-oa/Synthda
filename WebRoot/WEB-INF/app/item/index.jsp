<%--
  Created by IntelliJ IDEA.
  User: 高速波办公
  Date: 2021/3/24
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>OA登录</title>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <script src="https://filecdn.cqliving.com/static/h5zwy/resource/js/common/zwyCloudApi.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/vconsole.min.js"></script>

</head>
<body>
<script>
    console.log('start:');
    console.log(1);
    console.log(window.performance.navigation.type);
    console.log(2);
    console.log(document.referrer);
    if(window.performance.navigation.type == 2){
        history.go(-1);
    }
    if(document.referrer.indexof('/ewx/oneIndex?') > -1){
        history.go(-1);
    }
    var vConsole = new VConsole();
    try{
        var obj = ZWY_CLOUD.getUserInfo();
        console.log('userInfor:');
        console.log(obj)
        if(obj.token == ''){
            var params = {
                callback:'getToken',
                loginType:1
            }
            ZWY_CLOUD.appSessionToken(params);
        }else{
            loginFun(obj);
        }
    }catch(e){
        console.log('error:');
        console.log(e);
    }
    function getToken(params){
        var sessionObj = $.parseJSON(params);
        console.log('2:');
        console.log(sessionObj);
        loginFun(sessionObj);
    }
    function loginFun(sessionObj){
        var username = sessionObj.phone;
        if(username == ''){
            var params = {
                callback:'getToken',
                loginType:2
            }
            ZWY_CLOUD.appSessionToken(params);
        }else{
            var thirdAssessToken = sessionObj.token;
            $.cookie('thirdAssessToken', thirdAssessToken, {expires: 7});
            $.ajax({
                url: '/jsonp/v1/login',
                type: 'post',
                dataType: 'json',
                data:{
                    username:username,
                    thirdAssessToken:thirdAssessToken,
                    thirdPartyType:3
                },
                success: function (json) {
                    console.log(json);
                    if (json.flag&&json.object) {
                        console.log('OA登陆成功！');
                        location.href = '/ewx/index';
                    }else{
                        alert('OA登陆失败！')
                    }
                },
                error:function(err){
                    console.log(err);
                    alert('OA登陆失败！')
                }
            });
        }

    }
</script>
</body>
</html>
