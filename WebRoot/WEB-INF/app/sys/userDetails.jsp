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
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <title><fmt:message code="userDetails.th.detail" /></title>
    <link rel="stylesheet" type="text/css" href="../css/sys/uesrDetails.css"/>
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<div class="content">
    <div class="mainTitle">
        <img src="/img/main_img/xingzhuang.png" style="vertical-align: middle;margin-left: 15px;" alt="">
        <span style="margin-left: 8px;vertical-align: middle" id="userMessages"><fmt:message code="userDetails.th.detail" /></span>
    </div>
    <div class="header">
        <div class="imgHead">
            <div class="img">

            </div>
            <%--<div class="button">
                <div class="microNews">微讯</div>
                <div class="Mail">邮件</div>
            </div>--%>
        </div>
        <div class="information">
            <div style="" class="uName">
                <span class="userName"></span>
            </div>
            <%--<div style="float: right;">
                <span>关注</span>
                <span>0</span>
                <span style="margin: 0 15px;color: #000;">|</span>
                <span>粉丝</span>
                <span>0</span>
            </div>--%>

            <p style="color: #666666" class="deptName"></p>
            <p style="color: #999999" class="userPrivName"></p>
            <%--<div class="follow">关注</div>--%>
        </div>
    </div>
    <div class="footer" style="margin-bottom: 10px;">
        <div class="title"><fmt:message code="sys.cards" /></div>
        <div class="excelLeft">
            <table class="table1" border="" cellspacing="1" cellpadding="1" style="">
                <tr>
                    <td width="35%"><fmt:message code="userDetails.th.name" />：</td>
                    <td class="userName"></td>
                </tr>
                <tr>
                    <td width="35%"><fmt:message code="userDetails.th.Gender" />：</td>
                    <td class="sex"></td>
                </tr>
                <tr>
                    <td><fmt:message code="userManagement.th.department" />：</td>
                    <td  class="deptName"></td>
                </tr>
               <%-- <tr>
                    <td><fmt:message code="userDetails.th.OtherSectors" />：</td>
                    <td class="deptNameOther"></td>
                </tr>--%>
                <tr>
                    <%--<td><fmt:message code="userManagement.th.role" />：</td>--%>
                    <td><fmt:message code="customer.detail.position" />：</td>
                    <td class="zhiwu"></td>
                </tr>
                <%--<tr>--%>
                    <%--<td><fmt:message code="userDetails.th.AuxiliaryRole" />：</td>--%>
                    <%--<td class="userPrivNameOther"></td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                    <%--<td><fmt:message code="userDetails.th.post" />：</td>--%>
                    <%--<td class="postName"></td>--%>
                <%--</tr>--%>
            </table>
        </div>
        <div class="excelRight">
            <table class="table2" border="" cellspacing="0" cellpadding="0" style="">
                <%--<tr>--%>
                    <%--<td width="35%"><fmt:message code="userDetails.th.Gender" />：</td>--%>
                    <%--<td class="sex"></td>--%>
                <%--</tr>--%>
                <tr>
                    <td><fmt:message code="userDetails.th.Birthday" />：</td>
                    <td class="birthday"></td>
                </tr>
                <tr>
                    <td width="35%"><fmt:message code="userDetails.th.MobilePhone" />：</td>
                    <td class="mobilNo "></td>
                </tr>
                <tr>
                    <td><fmt:message code="depatement.th.Telephone" />：</td>
                    <td class="telNoDept"></td>
                </tr>
                <tr>
                    <td>Email：</td>
                    <td class="email" style="white-space: nowrap;"></td>
                </tr>
               <%-- <tr>
                    <td>QQ：</td>
                    <td class="oicqNo"></td>
                </tr>--%>
            </table>
        </div>
        <%--<div class="excelright">
            <table class="table2" border="" cellspacing="0" cellpadding="0" style="border-collapse:collapse;background-color: #fff">
                <tr>
                    <td width="35%">性别：</td>
                    <td class="sex"></td>
                </tr>
                <tr>
                    <td>生日：</td>
                    <td class="birthday"></td>
                </tr>
                <tr>
                    <td>生肖：</td>
                    <td></td>
                </tr>
                <tr>
                    <td>星座：</td>
                    <td></td>
                </tr>
                <tr>
                    <td>血型：</td>
                    <td></td>
                </tr>
            </table>
        </div>--%>
    </div>
</div>
<script>
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
            if(res.object.length!=0){
                var data=res.object[0]
                if (data.paraValue!=0){
                    $('#userMessages').after('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 12pt;margin-left: 20px;margin-top: 10px;vertical-align: middle;"> 机密级★ </span>')
                }
            }
        }
    })
    function imgerrorSpecial(e,opt){
        if(opt){
            var url = '';
            switch (opt){
                case 1://头像
                    url=domain+'/img/main_img/nantouxiang.png';
                    break;
                case 2://logo
                    url=domain+'/img/main_img/nvtouxiang.png';
                    break;
                default:

            }
        }
        $(e).attr('src',url);
    }
    $(function(){
        var uid=$.getQueryString('uid');
        $.ajax({
            type:'get',
            url:'../user/findUserByuid',
            dataType:'json',
            data:{'uid':uid},
            success:function(res){
                var data =res.object;
                var SEX = '';
                var str1 = '';
                var str = '';

                if(data.sex == '0'){
                    SEX='<fmt:message code="customer.male" />';
                    str='<img style="width: 22px;vertical-align: middle;" src="../img/sys/icon_man.png" alt="">';
                    if(data.avatar != '0'&&data.avatar != '1'&&data.avatar != ''&&data.avatar128 != ''){
                        if(data.avatar != '0'&&data.avatar != '1'&&data.avatar != ''){
                            str1= '<img onerror="imgerrorSpecial(this,1)" src="/img/user/'+data.avatar128+'" style="width: 114px;border-radius: 50%;" alt="">';
                        }else{
                            str1= '<img onerror="imgerrorSpecial(this,1)" src="/img/user/'+data.avatar+'" style="width: 114px;border-radius: 50%;" alt="">';
                        }
                    }else{
                        str1= '<img src="/img/main_img/nantouxiang.png"  style="width: 114px;" alt="">';
                    }
                }else if(data.sex == '1'){
                    SEX='<fmt:message code="customer.female" />';
                    str='<img style="width: 22px;vertical-align: middle;" src="../img/sys/icon_woman.png" alt="">';
                    if(data.avatar != '0'&&data.avatar != '1'&&data.avatar != ''){
                        if(data.avatar != '0'&&data.avatar != '1'&&data.avatar != ''&&data.avatar128 != ''){
                            str1= '<img onerror="imgerrorSpecial(this,2)" src="/img/user/'+data.avatar128+'" style="width: 114px;border-radius: 50%;" alt="">';
                        }else{
                            str1= '<img onerror="imgerrorSpecial(this,2)" src="/img/user/'+data.avatar+'" style="width: 114px; border-radius: 50%;" alt="">';
                        }
                    }else{
                        str1= '<img src="/img/main_img/nvtouxiang.png"  style="width: 114px;" alt="">';
                    }
                }else{
                    str1='<img src="/img/main_img/nantouxiang.png" style="width: 114px;" alt="">';
                    str='<img style="width: 22px;vertical-align: middle;" src="../img/sys/icon_man.png" alt="">';
                }
                $('.img').append(str1);
                $('.uName').append(str);
                $('.userName').text(data.userName);
                $('.deptName').text(data.longDepName);
                $('.deptNameOther').text(data.deptOtherName);

                /*if(data.deptName && data.postName){
                    $('.userPrivName').text(data.deptName+','+data.postName);
                }
                if(data.deptName && data.postName == undefined){
                    $('.userPrivName').text(data.deptName);
                }
                if(data.postName && data.deptName == undefined){
                    $('.userPrivName').text(data.postName);
                }*/
                //若职务为空显示主角色
                if(data.postName==undefined || data.postName ==''){
                    $('.userPrivName').text(data.userPrivName);
                }else{
                    $('.userPrivName').text(data.postName);
                }


                $('.postName').text(data.postName);
                $('.sex').text(SEX);
                $('.birthday').text(data.biexcelRightrthday);
                $('.mobilNo').text(data.mobilNo);
                $('.telNoDept').text(data.telNoDept);
                $('.email').text(data.email);
                $('.zhiwu').text(data.postName);
                $('.oicqNo').text(data.oicqNo);
            }
        })
    })
</script>
</body>
</html>