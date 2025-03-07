<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>监察权限设置</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <link rel="stylesheet" type="text/css" href="../css/base.css" />
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>

</head>
<style>
  .num{
      text-align: center;
  }
table{
    margin:20px auto;
    border:none;
}
tr,td{
    border:none;
}
    .mintit{
        text-align: left;
        height:50px;
        line-height: 50px;
        color: #124064;
        font-weight: bold;
        font-size: 17px;
        margin-left:10%;
    }
  .btn{
      text-align: center;
  }
  .btn_ {
      width:100px;
      height: 40px;
      padding-left: 10px;
      margin-top:25px;
      font-size: 14px;
      cursor: pointer;
      background: url(/img/save.png) no-repeat;
  }



</style>
<body>
<div data-num="0" id="num0"  class="num">
    <div class="table">
        <div class="mintit">全面深度监察、统计</div>
        <table cellspacing="0" cellpadding="0" style="border-collapse:collapse;background-color: #fff;width: 90%;">
            <%--<tr>--%>
                <%--<td width="20%" style="text-align: center;">--%>
                    <%--<p><fmt:message code="doc.th.ScopeAuthorization" />：</p>--%>
                    <%--<p>（<fmt:message code="userManagement.th.department" />）</p>--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<div class="inPole">--%>
                        <%--<textarea name="txt" id="SendCompany0" deptid='' value="" disabled style="min-width: 329px;min-height:76px;width: 85%;"></textarea>--%>
                        <%--<span class="add_img" style="margin-left: 10px">--%>
		                                    <%--<a href="javascript:;" id="SelectCompany0" class="AddD"><fmt:message code="global.lang.add" /></a>--%>
		                                <%--</span>--%>
                        <%--<span class="add_img">--%>
		                                    <%--<a href="javascript:;" class="deClearD"  id="clearCompany0"><fmt:message code="notice.th.delete1" /></a>--%>
		                                <%--</span>--%>
                    <%--</div>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td width="20%" style="text-align: center;">--%>
                    <%--<p><fmt:message code="doc.th.ScopeAuthorization" />：</p>--%>
                    <%--<p>（<fmt:message code="userManagement.th.role" />）</p>--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<div class="inPole">--%>
                        <%--<textarea name="txt" id="SendPriv0" userpriv="" privid='' value="" disabled style="min-width: 329px;min-height:76px;width: 85%;"></textarea>--%>
                        <%--<span class="add_img" style="margin-left: 10px">--%>
		                                    <%--<a href="javascript:;" id="SelectPriv0" class="AddP"><fmt:message code="global.lang.add" /></a>--%>
		                                <%--</span>--%>
                        <%--<span class="add_img">--%>
		                                    <%--<a href="javascript:;" class="deClearP" id="clearPriv0" ><fmt:message code="notice.th.delete1" /></a>--%>
		                                <%--</span>--%>
                    <%--</div>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <tr>
                <td width="20%" style="text-align: center;">
                    <p>指定人员：</p>
                    <%--<p>（<fmt:message code="diary.th.body" />）</p>--%>
                </td>
                <td>
                    <div class="inPole">
                        <textarea name="txt" id="Senduser0" user_id='' value="" disabled style="min-width: 329px;min-height:76px;width: 85%;"></textarea>
                        <span class="add_img" style="margin-left: 10px">
		                                    <a href="javascript:;" id="SelectUser0" class="AddU"><fmt:message code="global.lang.add" /></a>
		                                </span>
                        <span class="add_img">
		                                    <a href="javascript:;" class="deClearU" id="clearUser0"><fmt:message code="notice.th.delete1" /></a>
		                                </span>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</div>
<div data-num="1" id="num1" class="num"><div class="table">
    <div class="mintit">局部深度监察、统计 </div>
    <table cellspacing="0" cellpadding="0" style="border-collapse:collapse;background-color: #fff;width: 90%;">
        <%--<tr>--%>
            <%--<td width="20%" style="text-align: center;">--%>
                <%--<p><fmt:message code="doc.th.ScopeAuthorization" />：</p>--%>
                <%--<p>（<fmt:message code="userManagement.th.department" />）</p>--%>
            <%--</td>--%>
            <%--<td>--%>
                <%--<div class="inPole">--%>
                    <%--<textarea name="txt" id="SendCompany1" deptid='' value="" disabled style="min-width: 329px;min-height:76px;width: 85%;"></textarea>--%>
                    <%--<span class="add_img" style="margin-left: 10px">--%>
		                                    <%--<a href="javascript:;" id="SelectCompany1" class="AddD"><fmt:message code="global.lang.add" /></a>--%>
		                                <%--</span>--%>
                    <%--<span class="add_img">--%>
		                                    <%--<a href="javascript:;" class="deClearD"  id="clearCompany1"><fmt:message code="notice.th.delete1" /></a>--%>
		                                <%--</span>--%>
                <%--</div>--%>
            <%--</td>--%>
        <%--</tr>--%>
        <%--<tr>--%>
            <%--<td width="20%" style="text-align: center;">--%>
                <%--<p><fmt:message code="doc.th.ScopeAuthorization" />：</p>--%>
                <%--<p>（<fmt:message code="userManagement.th.role" />）</p>--%>
            <%--</td>--%>
            <%--<td>--%>
                <%--<div class="inPole">--%>
                    <%--<textarea name="txt" id="SendPriv1" userpriv="" privid='' value="" disabled style="min-width: 329px;min-height:76px;width: 85%;"></textarea>--%>
                    <%--<span class="add_img" style="margin-left: 10px">--%>
		                                    <%--<a href="javascript:;" id="SelectPriv1" class="AddP"><fmt:message code="global.lang.add" /></a>--%>
		                                <%--</span>--%>
                    <%--<span class="add_img">--%>
		                                    <%--<a href="javascript:;" class="deClearP" id="clearPriv1" ><fmt:message code="notice.th.delete1" /></a>--%>
		                                <%--</span>--%>
                <%--</div>--%>
            <%--</td>--%>
        <%--</tr>--%>
        <tr>
            <td width="20%" style="text-align: center;">
                <p>指定人员：</p>
                <%--<p>（<fmt:message code="diary.th.body" />）</p>--%>
            </td>
            <td>
                <div class="inPole">
                    <textarea name="txt" id="Senduser1" user_id='' value="" disabled style="min-width: 329px;min-height:76px;width: 85%;"></textarea>
                    <span class="add_img" style="margin-left: 10px">
		                                    <a href="javascript:;" id="SelectUser1" class="AddU"><fmt:message code="global.lang.add" /></a>
		                                </span>
                    <span class="add_img">
		                                    <a href="javascript:;" class="deClearU" id="clearUser1"><fmt:message code="notice.th.delete1" /></a>
		                                </span>
                </div>
            </td>
        </tr>
    </table>
</div></div>
<div data-num="2" id="num2" class="num">
    <div class="mintit">统计概况浏览</div>
    <div class="table">
        <table cellspacing="0" cellpadding="0" style="border-collapse:collapse;background-color: #fff;width: 90%;">
            <%--<tr>--%>
                <%--<td width="20%" style="text-align: center;">--%>
                    <%--<p><fmt:message code="doc.th.ScopeAuthorization" />：</p>--%>
                    <%--<p>（<fmt:message code="userManagement.th.department" />）</p>--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<div class="inPole">--%>
                        <%--<textarea name="txt" id="SendCompany2" deptid='' value="" disabled style="min-width: 329px;min-height:76px;width: 85%;"></textarea>--%>
                        <%--<span class="add_img" style="margin-left: 10px">--%>
		                                    <%--<a href="javascript:;" id="SelectCompany2" class="AddD"><fmt:message code="global.lang.add" /></a>--%>
		                                <%--</span>--%>
                        <%--<span class="add_img">--%>
		                                    <%--<a href="javascript:;" class="deClearD"  id="clearCompany2"><fmt:message code="notice.th.delete1" /></a>--%>
		                                <%--</span>--%>
                    <%--</div>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td width="20%" style="text-align: center;">--%>
                    <%--<p><fmt:message code="doc.th.ScopeAuthorization" />：</p>--%>
                    <%--<p>（<fmt:message code="userManagement.th.role" />）</p>--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<div class="inPole">--%>
                        <%--<textarea name="txt" id="SendPriv2" userpriv="" privid='' value="" disabled style="min-width: 329px;min-height:76px;width: 85%;"></textarea>--%>
                        <%--<span class="add_img" style="margin-left: 10px">--%>
		                                    <%--<a href="javascript:;" id="SelectPriv2" class="AddP"><fmt:message code="global.lang.add" /></a>--%>
		                                <%--</span>--%>
                        <%--<span class="add_img">--%>
		                                    <%--<a href="javascript:;" class="deClearP" id="clearPriv2" ><fmt:message code="notice.th.delete1" /></a>--%>
		                                <%--</span>--%>
                    <%--</div>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <tr>
                <td width="20%" style="text-align: center;">
                    <p>指定人员：</p>
                    <%--<p><fmt:message code="doc.th.ScopeAuthorization" />：</p>--%>
                    <%--<p>（<fmt:message code="diary.th.body" />）</p>--%>
                </td>
                <td>
                    <div class="inPole">
                        <textarea name="txt" id="Senduser2" user_id='' value="" disabled style="min-width: 329px;min-height:76px;width: 85%;"></textarea>
                        <span class="add_img" style="margin-left: 10px">
		                                    <a href="javascript:;" id="SelectUser2" class="AddU"><fmt:message code="global.lang.add" /></a>
		                                </span>
                        <span class="add_img">
		                                    <a href="javascript:;" class="deClearU" id="clearUser2"><fmt:message code="notice.th.delete1" /></a>
		                                </span>
                    </div>
                </td>
            </tr>

        </table>
    </div>
</div>
<div data-num="3" id="num3" class="num">
    <%--<div class="mintit">新增、修改权限</div>--%>
    <%--<div class="table">--%>
        <%--<table cellspacing="0" cellpadding="0" style="border-collapse:collapse;background-color: #fff;width: 90%;">--%>

            <%--<tr>--%>
                <%--<td width="20%" style="text-align: center;">--%>
                    <%--<p>指定人员：</p>--%>
                    <%--&lt;%&ndash;<p><fmt:message code="doc.th.ScopeAuthorization" />：</p>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<p>（<fmt:message code="diary.th.body" />）</p>&ndash;%&gt;--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<div class="inPole">--%>
                        <%--<textarea name="txt" id="Senduser3" user_id='' value="" disabled style="min-width: 329px;min-height:76px;width: 85%;"></textarea>--%>
                        <%--<span class="add_img" style="margin-left: 10px">--%>
		                                    <%--<a href="javascript:;" id="SelectUser3" class="AddU"><fmt:message code="global.lang.add" /></a>--%>
		                                <%--</span>--%>
                        <%--<span class="add_img">--%>
		                                    <%--<a href="javascript:;" class="deClearU" id="clearUser3"><fmt:message code="notice.th.delete1" /></a>--%>
		                                <%--</span>--%>
                    <%--</div>--%>
                <%--</td>--%>
            <%--</tr>--%>

        <%--</table>--%>
    <%--</div>--%>
</div>
<div class="btn"><button id="saveBtn"  class="btn_">保存</button></div>
</body>

<script>

    $(function(){
//        $(".AddD").on("click",function(){//选部门控件
//            var deptNum = $(this).parents(".num").attr("data-num");
//            dept_id='SendCompany'+deptNum;
//            $.popWindow("../common/selectDept");
//        });
//        $(".AddP").on("click",function(){//选角色控件
//            var deptNum = $(this).parents(".num").attr("data-num");
//            priv_id='SendPriv'+deptNum;
//            $.popWindow("../common/selectPriv");
//        });
        $(".AddU").on("click",function(){//选人员控件
            var deptNum = $(this).parents(".num").attr("data-num");
            user_id='Senduser'+deptNum;
            $.popWindow("../common/selectUser");
        });
//清空部门
//        $(".deClearD").on("click",function(){
//            var deptNum = $(this).parents(".num").attr("data-num");
//            $('#SendCompany'+deptNum).val("");
//            $('#SendCompany'+deptNum).attr("deptid","");
//        })
//清空角色
//        $(".deClearP").on("click",function(){
//            var deptNum = $(this).parents(".num").attr("data-num");
//            $('#SendPriv'+deptNum).val("");
//            $('#SendPriv'+deptNum).attr("privid","");
//        })
//清空人员
        $(".deClearU").on("click",function(){
            var deptNum = $(this).parents(".num").attr("data-num");
            $('#Senduser'+deptNum).val("");
            $('#Senduser'+deptNum).attr("user_id","");
        })
    })
//初始化
    init();
function init(){
    $.ajax({
        url:"/FlowPara/selectFlowParaByQuan",
        dataType:"json",
        type:"get",
        success:function(res){
            if(res.flag){
                var arr1 = res.obj.filter(function(item){
                    return item.paraName== "FLOW_QUANMIAN_ID";

                });
                var id1 = arr1[0].paraValue;
                var str1 = arr1[0].paraNameStr;
                $("#Senduser0").attr("user_id",id1);
                $("#Senduser0").html(str1);
                var arr2 = res.obj.filter(function(item){
                    return item.paraName== "FLOW_JUBU_ID";

                });
                var id2 = arr2[0].paraValue;
                var str2 = arr2[0].paraNameStr;
                $("#Senduser1").attr("user_id",id2);
                $("#Senduser1").html(str2);
                var arr3 = res.obj.filter(function(item){
                    return item.paraName== "FLOW_LIULAN_ID";

                });
                var id3 = arr3[0].paraValue;
                var str3 = arr3[0].paraNameStr;
                $("#Senduser2").attr("user_id",id3);
                $("#Senduser2").html(str3);
                save();


            }
        }
    })
}

    function save(){
        $("#saveBtn").click(function(){
            var val1 = $("#Senduser0").attr("user_id");
            var val2 = $("#Senduser1").attr("user_id");
            var val3 = $("#Senduser2").attr("user_id");
            var arr=[{paraName:"FLOW_QUANMIAN_ID",paraValue:val1},{paraName:"FLOW_JUBU_ID",paraValue:val2},{paraName:"FLOW_LIULAN_ID",paraValue:val3}];
            $.ajax({
                url:"/FlowPara/modify",
                type:"post",
                dataType:"json",
                data:{
                    jsonStr:JSON.stringify(arr)
                },
                success:function(res){
                    if(res.flag){
                        layer.msg('保存成功！', {icon: 1});
                        init();
                    }else{
                        layer.msg('保存失败！', {icon: 2});
                    }

                }
            })

        })
    }
</script>
</html>