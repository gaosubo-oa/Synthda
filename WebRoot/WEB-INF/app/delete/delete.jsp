<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<!--[if IE 6 ]> <html class="ie6 lte_ie6 lte_ie7 lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 6 ]> <html class="lte_ie6 lte_ie7 lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 7 ]> <html class="lte_ie7 lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 8 ]> <html class="lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 9 ]> <html class="lte_ie9"> <![endif]-->
<!--[if (gte IE 10)|!(IE)]><!--><html><!--<![endif]-->
<head>
    <title><fmt:message code="vote.th.ScavengingData" /></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
<%--<link rel="stylesheet" type="text/css" href="../css/notice/style.css" />--%>
    <link rel="stylesheet" type="text/css" href="../css/dept/roleAuthorization.css?20210311.1" />
    <link rel="stylesheet" type="text/css" href="/lib/layer/mobile/need/layer.css" />
    <%--   <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>--%>
    <%-- <link rel="stylesheet" type="text/css" href="../css/base.css" />--%>
    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/laydate/laydate.js"></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style>
        table{
            width: 100%;
            table-layout: fixed;
        }
        .contant{
            width:98%;
            margin-left:2%;
        }
        .one_all{
            margin-left:2%;
        }
        .data_all{
            width:90%;
        }
        .two{
            width:12%;
            float:left;
        }

        .erji{
            width: 100%;
            height: 54px;
            margin-left:5%;
        }
        .three{
            float:left;
            width: 18%;
        }
        .sanji{
            width: 88%;
        }
        .sanji,.two_all{
            float:left;
        }
        .person{
            height:70px;
        }
        /*2,3,7 85*/
        .tab_cone .one:nth-child(1){
            margin-top:10px;
        }
        .tab_cone .one:nth-child(2),.tab_cone .one:nth-child(3),.tab_cone .one:nth-child(5),.tab_cone .one:nth-child(7){
            height:90px;
            width:100%;
        }
        .all_title{

            height:45px;
            border-bottom: 1px solid #9E9E9E;
        }
        .all_title img,.all_title h1,.all_choose,.delete_data,.delete_data img,.delete_data h2{
            float:left;
        }
        .all_title img{
            margin-top: 9px;

        }
        .all_title h1{
            width: 70%;
            font-size: 22px;
            font-weight: normal;
            margin-left: 12px;
            line-height: 45px;
            height: 100%;
        }
        .all_choose{
            line-height: 39px;
        }
        input{
            margin: -1px;
        }
        .all_choose input{
            margin-top: 9px;
        }
        .delete_data{
            margin-top: 8px;
            margin-left: 10px;
            border-radius: 3px;
            outline: none;
            border: none;
            color: #fff;
            width: 107px;
            height: 30px;
            background: #2f80d1;
        }
        .delete_data h2{
            color: #fff;
            font-size: 14px;
            margin-top:2px;
            margin-left: 9px;
        }
.find_detail{
    cursor: pointer;
}
        .contant{
            width: 100%;
            margin-left: 0px;
        }
        .all_title{
            padding: 0 30px;

        }
        .delete_data{
            float: right;
            margin-right:20px;
        }
        .data_all{
            width:95%;
            margin:20px auto 0px;
        }
        #j_tb tr td{
            text-align: center;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>


<body class="bodycolor" style="padding: 0;">
<div class="contant">
    <div class="all_title">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/delete_data.png" alt="">
        <h1><fmt:message code="vote.th.ScavengingData" /></h1>
        <%--<div class="all_choose">--%>
            <%--<span>全选/取消全选</span>--%>
        <%--</div>--%>
        <button class="delete_data"><img src="../img/delete_one.png" alt="" style="margin-top: 2px;margin-left: 5px"><h2><fmt:message code="notice.th.OneKeyEmpty" /></h2></button>
    </div>
    <div class="data_all">
        <table id="tr_td">
            <thead>
            <tr>
                <td class="th" align="center"><input class="checkChild" style="vertical-align: bottom;position: relative;bottom: 5px;right: 15px;" id="checkedAll" type="checkbox" conid="29" name="check" value=""><fmt:message code="global.lang.select" /></td>
                <td class="th" align="center"><fmt:message code="notice.th.Modular" /></td>
                <td class="th" align="center"><fmt:message code="menuSSetting.th.menuSetting" /></td>
            </tr>
            </thead>
            <tbody id="j_tb">

            </tbody>
        </table>

    </div>

</div>


</body>
<script>

    var funData=[
        {id:"0116",name:"<fmt:message code="notice.th.notice" />"},
        {id:"0117",name:"<fmt:message code="email.th.news" />"},
        {id:"0101",name:"<fmt:message code="notice.th.mail" />"},
        {id:"2016",name:"<fmt:message code="email.th.agenda" />"},
        {id:"0128",name:"<fmt:message code="email.th.log" />"},
        <%--{id:"0136",name:"<fmt:message code="main.personnel" />"},--%>
        <%--{id:"3001",name:"<fmt:message code="main.public" />"}--%>
    ]
    function renderData() {
        var str="";
        for(var i=0;i<funData.length;i++){
            str +='<tr>' +
                '<td><input class="checkChild choose" type="checkbox" menuId="'+funData[i].id+'" name="checks" value="" onclick="setAll()"></td> ' +
                '<td>'+funData[i].name+'</td> ' +
                '<td class="action_do" menuId="'+funData[i].id+'"><span class="find_detail"  style="color:#1772c0;"><fmt:message code="notice.th.delete1" /></span></td> ' +
                '</tr>'
        }
        // console.log(str);
        $("#j_tb").append(str);
    }
    //点击子复选框,全选框 选中、取消
    function setAll(){
        if(!$(".choose").checked){
            $("#checkedAll").prop("checked",false); // 子复选框某个不选择，全选也被取消
        }
        var choicelength=$("input[type='checkbox'][name='checks']").length;
        var choiceselect=$("input[type='checkbox'][name='checks']:checked").length;
        if(choicelength==choiceselect){
            $("#checkedAll").prop("checked",true);   // 子复选框全部部被选择，全选也被选择；
        }

    }
    $(function () {
        renderData();
        /*点击清空的接口*/
        $('.action_do').on('click', function () {
            var menuIds = [];
            var menuId = $(this).attr("menuId");
            menuIds.push(menuId);
            dosubmit(menuIds);
        })
        $(".delete_data").on('click', function () {

            var choicelength=$("input[type='checkbox'][name='checks']").length;
            var choiceselect=$("input[type='checkbox'][name='checks']:checked").length;
            if(choicelength==choiceselect){
                var menuIds = [];
                $("#j_tb input[type=checkbox]:checked").each(function (i, n) {
                    var menuId = $(this).attr("menuId");
                    menuIds.push(menuId);
                })
                dosubmit(menuIds);
            }else{

                layer.confirm('请全选后，一键清除！',{icon: 0,title:'提示'},function(index){
                    layer.close(index);

                });
            }

        })
        function dosubmit(menuIds) {
            $.layerConfirm({title:'<fmt:message code="menuSSetting.th.suredeleteMenu" />',content:'<fmt:message code="notice.th.DisappearAndRestored" />!',icon:0},function(){
                $.layerConfirm({title:'<fmt:message code="menuSSetting.th.suredeleteMenu" />',content:'<fmt:message code="workflow.th.que" />？',icon:0},function(){
            $.ajax({
        url: 'danger/truncate',
        type: 'post',
        data:{
            menuId:menuIds
        },
        dataType: 'json',
        success: function (obj) {
            if(obj.flag==false){
                $.layerMsg({content:obj.msg,icon:0});
            }else {
                $.layerMsg({content:obj.msg,icon:1});
            }

        }
    })
                })
            })

        }

        /*全选*/
        $('#checkedAll').on('click', function () {
            /*alert('111');*/
            var state = $(this).prop("checked");
            if (state == true) {
                $(this).prop("checked", true);
                $(".checkChild").prop("checked", true);
            } else {
                $(this).prop("checked", false);
                $(".checkChild").prop("checked", false);
            }
        })

    })

</script>
</html>

