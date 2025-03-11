<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../css/dept/deptManagement.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/easyui/themes/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../css/sys/userInfor.css"/>
    <link rel="stylesheet" type="text/css" hcont_rigref="../lib/easyui/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../css/news/center.css"/>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <script type="text/javascript" src="../js/xoajq/xoajq3.js"></script>
    <script src="../lib/laydate/laydate.js"></script>
    <style>
        html,
        body,
        .wrap{

            width:100%;
            height:100%;
        }		.pick{			overflow-x: auto;		}		.pick::-webkit-scrollbar{            width: 5px;            height: 6px;            background-color: #f5f5f5;        }        /*定义滚动条的轨道，内阴影及圆角*/        #cont_left::-webkit-scrollbar-track{            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);            border-radius: 10px;            background-color: #f5f5f5;        }        /*定义滑块，内阴影及圆角*/        ::-webkit-scrollbar-thumb{            /*width: 10px;*/            height: 20px;            border-radius: 10px;            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);            background-color: #555;        }
		::-webkit-scrollbar{            width: 5px;            height: 0px;            background-color: #f5f5f5;        }        
        .head_rig h1 {
            float: left;
            margin-right:20px;
        }
		
        .search h1 {
            text-align: center;
            color: #fff;
            font-size: 14px;
            line-height: 28px;
            background-image: url(../img/workflow/btn_check_nor_03.png);
            background-repeat: no-repeat;
        }

        .cont {
            width: 102%;
            height: 95%;
            overflow-y: auto;
        }

        .head {
            border-bottom: 1px solid #dedede;

        }

        .head_rig h1 :hover {
            cursor: pointer;
        }

        .search h1 :hover {
            cursor: pointer;
        }

        .new_excell_info_other span {
            margin-left: 10px;
            color: black;
        }

        .new_excell_info_other li {
            height: 50%;
            line-height: 24px;
            font-size: 20px;
        }
        .ChildTitleIcon{
            position:static;
            margin-top:-4px!important;
        }
        .title span{
            margin-left:6px;
        }

        li {
            display: list-item;
            text-align: -webkit-match-parent;
        }

        select {
            height: 32px;
            width: 220px;
            border-radius: 4px;
            border: 1px solid #cccccc;
            background-color: #ffffff;
        }

        .f_field_ctrl input {
            color: #000;
        }

        .dpetWhole0{overflow: auto}
        dpetWhole0 li{white-space: nowrap;}
        .cont_rig {
            float: left;
            background-color: #f9f9f9;
        }
        .cont_left{
            border-right: 1px solid #c0c0c0!important;
        }

        .view span {
            cursor: pointer;
            border-width: 1px;
            border-style: solid;
            border-color: rgb(47, 138, 227);
            border-image: initial;
            padding: 2px 10px;
        }
        .view span:first-of-type{
            border-top-left-radius: 5px;
            border-bottom-left-radius: 5px;
            border-right: none;
        }
        .on {
            background-color: rgb(47, 138, 227);
            color: rgb(255, 255, 255);
        }

        .deptInfoTable tr td{
            border-right: 1px solid #c0c0c0;
            color: #000;
            font-weight: normal
        }

        .title span{
            color: #000;
            font-weight: 400;
            font-size: 20px;
        }
        /*.blue_text{*/
            /*width: 25%;*/
        /*}*/
         .table .blue_text{
            font-size: 13pt;
             width: 35%;
        }

        .deptInfoTable tr td:first-child{
            font-size: 13pt;
        }
        .deptInfoTable tr td:nth-child(2){
            font-size: 11pt;
        }
        .pick li{width: 2000px;}
        .cont_left .pick{
            overflow-y: hidden;
        }
    </style>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js?20190701"></script>
    <title><fmt:message code="main.deptquery" /></title>
</head>
<body style="overflow:scroll;overflow-x:hidden;">

<div class="wrap" style="margin-left:0px !important;">
    <div class="head">
        <div class="head_left">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/deptQueryBig.png" alt="">
            <h1 style="color: #333;"><fmt:message code="main.deptquery" /></h1>
            <div style="float:right;margin-right: 6%;margin-top: 10px;font-size: 14px" class="view">
                <span class="view1 on"><fmt:message code="vote.th.Tree" /></span>
                <span class="view2" style="border-top-right-radius: 5px;border-bottom-right-radius: 5px;"><fmt:message code="vote.th.List" /></span>
            </div>
        </div>
    </div>

    <div class="cont" style="overflow-y: auto ">
        <div class="cont_left" id="cont_left">
            <ul>
                <li class="liDown dept_li" id="dept_lis"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_sectorList.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="部门列表"><fmt:message code="depatement.th.depa" /></li>
                <li class="pick" style="display: block;overflow-x: hidden">
                    <div class="pickCompany"><span style="height:35px;line-height:35px;" class="childdept"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 10px;margin-left: 13px;margin-bottom: 4px;"><a href="javascript:void(0)" class="dynatree-title" title=""></a></span></div>
                </li>
                <li class="liUp dept_li" onclick="deptQuery(this)" ><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_sectorList.png" style="vertical-align: middle;margin-right: 10px;width: 15px;" alt="部门查询"><fmt:message code="attend.lang.deptquery" /></li>
            </ul>
        </div>
        <%--部门查询条件--%>
        <div class="cont_rig">
            <!-- 部门右侧页面 -->
            <div class="queryDept" style="display: block;">
                <div class="title">
                    <img src="../img/department/deptQuery.png" class="ChildTitleIcon" alt="部门查询" style="width:auto;margin-top: 12px;">
                    <span><fmt:message code="attend.lang.deptquery" /></span>
                </div>
                <table class="table" cellspacing="0" cellpadding="0" style="border-collapse:collapse;background-color: #fff;width: 50%">
                    <tr>
                        <td class="blue_text" style="color: #000;font-weight: normal"><fmt:message code="departement.th.memberUnit" />：</td>
                        <td>
                            <input type="text" name="deptName" class="inputTd" id="deptName"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="btn">
                                <div id="submit" class="backQueryBtn"><span style="margin-left: 33px;"><fmt:message code="global.lang.query" /></span></div>
                                <%--<div id="export" class="backExportBtn"><span style="margin-left: 33px;"><fmt:message code="global.lang.report" /></span></div>--%>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <%--部门查询列表展示--%>
       <div class="mainRight tab" style="float: left;width: 80%;display: none;margin-top:0px;">
           <div class="title">
               <img src="../img/department/deptQuery.png" class="ChildTitleIcon" alt="部门查询" style="margin-top: 12px;">
               <span><fmt:message code="attend.lang.deptquery" /></span>
           </div>
            <table class="deptQuertTable" style="width: 95%;margin-left: 1%">

            </table>
        </div>

        <%--部门信息展示--%>
        <div class="deptInfo" style="float: left;width: 80%;display: none">
            <div class="title">
                <img src="../img/department/deptInfo.png" class="ChildTitleIcon" alt="部门信息" style="margin-top: 12px;width:auto">
                <span><fmt:message code="vote.th.DeInformation" /></span>
            </div>
            <table class="deptInfoTable" style="width: 50%;margin: 20px auto;">

            </table>
        </div>
    </div>
   <%-- 列表视图--%>
    <div class="listShow" style="float: left;width: 80%;display: none">
        <jsp:include page="deptListShow.jsp"/>
    </div>
</div>
</div>
</body>
<script type="text/javascript">
    boolTwo=false;
    numstring=true;

    /*左侧点击事件显示隐藏*/
    $("#dept_lis").on('click', function () {
        if ($(this).siblings('.pick').css('display') == 'none') {
            $(this).siblings('.pick').show();
            $(this).addClass("liDown").removeClass("liUp");
        } else {
            $(this).siblings('.pick').hide();
            $(this).addClass("liUp").removeClass("liDown");
        }
    });

    //正在开发中
    function develop(me){
        $('.cont_rig').hide()
        $('.mainRight').show()
        $(".deptInfo").hide();
        $('.mainRight').height($(document).height()-$('.head').height())
        $('.mainRight').find('iframe').prop('src',$(me).attr('data-url'))
    };


    //部门信息详情展示
    function ajaxdata(id,me){
        $('.mainRight').hide()
        $('.cont_rig').hide()
        $(".deptInfo").show()
        var data={
            'choice':1,
            'deptId':id
        }
        $.ajax({
            type:'get',
            url:'/department/getDeptById',
            dataType:'json',
            data:data,
            success:function(res){
                var data1=res.object;
                 str='<tr><td style="width:30%"><fmt:message code="departement.th.memberUnit" />：</td><td>'+data1.deptName+'</td></tr>'+
                    '<tr><td><fmt:message code="departement.th.Departmenthead" />：</td><td>'+data1.managerStr+'</td></tr>'+
                    '<tr><td><fmt:message code="departement.th.Departmentalassistant" />：</td><td>'+data1.assistantStr+'</td></tr>'+
                    '<tr><td><fmt:message code="department.th.leadership" />：</td><td>'+data1.leader1Name+'</td></tr>'+
                    '<tr><td><fmt:message code="depatment.th.leadership" />：</td><td>'+data1.leader2Name+'</td></tr>'+
                    '<tr><td><fmt:message code="depatement.th.Telephone" />：</td><td>'+data1.telNo+'</td></tr>'+
                    '<tr><td><fmt:message code="depatement.th.fax" />：</td><td>'+data1.faxNo+'</td></tr>'+
                    '<tr><td><fmt:message code="depatement.th.address" />：</td><td>'+data1.deptAddress+'</td></tr>'+
                    '<tr><td><fmt:message code="diary.th.function" />：</td><td>'+data1.deptFunc+'</td></tr>';
                $('.deptInfoTable').html(str);
            }
        })
    }

    $(function () {
//        部门左侧数据渲染
        loadSidebar1($('.pick'),0)
        function loadSidebar1(target,deptId,fn) {
            $.ajax({
                url: '/department/getChDeptfq',
                type: 'get',
                data: {
                    deptId: deptId
                },
                dataType: 'json',
                success: function (data) {
                    var str = '';
                    data.obj.forEach(function (v, i) {
                        if (v.deptName) {
                            str += '<li><span  data-numtrue="1" ' +
                                'onclick= "imgDown(' +v.deptId + ',this)" data-types="1"  data-numString="1"  style="height:35px;line-height:35px;padding-left: 14px" deptid="' + v.deptId + '" class="childdept"><span class=""></span><img src="/img/commonTheme/${sessionScope.InterfaceModel}/dapt_right.png" alt="" style="margin-left: 12px;width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;"><a href="javascript:void(0)" class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a></span><ul style="display:none;" class="dpetWhole0"></ul></li>';
                        }
                    })
                    widthnum++;
                    target.append(str);

                }
            })
        }
        $.ajax({
            url:'/sys/showUnitManage',
            type:'get',
            dataType:"JSON",
            data : '',
            success:function(obj){

                var data = obj.object.unitName;
                $('.pick .pickCompany .dynatree-title').text(data).attr('title',data);

            },
            error:function(e){
              //  console.log(e);
            }
        })
    });

    function deptQuery(fn) {
        $('.cont_rig').show()
        $('.mainRight').hide()
        $(".deptInfo").hide()
    }

    $(".backQueryBtn").on("click",function () {
        $('.mainRight').show()
        $('.cont_rig').hide()
        $(".deptInfo").hide()
        $.ajax({
            type:'get',
            url:'/department/selByLikeDeptName',
            dataType:'json',
            data:{
                deptName:$("#deptName").val()
            },
            success:function(res){
                var datas=res.obj;
                var str='  <tr><th width=""><fmt:message code="departement.th.memberUnit" /></th><th width=""><fmt:message code="departement.th.Departmenthead" /></th> <th width=""><fmt:message code="departement.th.Departmentalassistant" /></th> <th width=""><fmt:message code="department.th.leadership" /></th> <th width=""><fmt:message code="depatment.th.leadership" /></th> <th width=""><fmt:message code="depatement.th.Telephone" /></th> <th width=""><fmt:message code="depatement.th.fax" /></th> <th width=""><fmt:message code="depatement.th.address" /></th> <th width=""><fmt:message code="diary.th.function" /></th></tr>';
                for(var i=0;i<datas.length;i++){
                    str+="<tr><td>"+datas[i].deptName+"</td>"+//部门名称
                    "<td>"+datas[i].manager +"</td>"+// 部门主管
                    "<td>"+datas[i].assistantId+"</td>"+// 部门助理
                    "<td>"+datas[i].leader1+"</td>"+// 主管领导
                    "<td>"+datas[i].leader2 +"</td>"+// 分管领导
                    "<td>"+datas[i].telNo +"</td>"+// 电话
                    "<td>"+datas[i].faxNo+"</td>"+// 传真
                    "<td>"+datas[i].deptAddress+"</td>"+// 地址
                    "<td>"+datas[i].deptFunc+"</td></tr>";//部门职能'
                }
                $('.deptQuertTable').html(str);
            }
        })
    })

    $(".view1").on("click",function () {
        $(".view1").addClass("on");
        $(".view2").removeClass("on");
        $(".listShow").hide()
        $(".cont").show()
    })
    $(".view2").on("click",function () {
        $(".view2").addClass("on");
        $(".view1").removeClass("on");
        /*$("#iframeList").attr("src","/department/deptListShow");*/
        $(".listShow").show()
        $(".cont").hide()
    })
</script>

</html>
