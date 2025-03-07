<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title><fmt:message code="main.deptquery"/></title>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../css/news/new_news.css"/>
    <link rel="stylesheet" type="text/css" href="../css/dept/deptQuery.css"/>
    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style>

        thead{
            text-align: center;
        }
        #tableDapt tr td{
            text-align: center;
        }
        .headDept img{
            margin-top: 10px;
        }
        .headDiv {
            width: 100%;
            height: 45px;
            border-bottom: #999 1px solid;
            background: #f5f7f8;
            position: fixed;
            top: 0;
            left: 0;
        }
        .nav_t1 {
            height: 45px;
            float: left;
            margin-left: 30px;
            width: 26px;
        }
        .nav_t1 img {
            margin-top: 12px;
            width: 23px;
        }
        .divP {
            float: left;
            height: 45px;
            line-height: 45px;
            font-size: 22px;
            margin-left: 12px;
            color: #333;
        }
    </style>
</head>
<body>
<%--<div class="headDiv">
    <div class="nav_t1"><img src="../img/sys/dept1.png"></div>
    <div class="divP"><fmt:message code="department.th.Enquiry"/></div>
</div>--%>
<%--<div class="headDept clearfix">--%>
    <%--<img src="../img/bumenchaxun1.png" style="margin-top: 24px;">--%>
    <%--<div class="" style="height: 71px;line-height: 71px;">--%>
        <%--<fmt:message code="department.th.Enquiry"/>--%>
    <%--</div>--%>
<%--</div>--%>
<!--content部分开始-->

<table id="tr_td" style=" width: 113%;margin-left: 6%; margin-top: 2%;">
    <thead>
    <tr>
        <td class="th" style="width:130px;"><fmt:message code="departement.th.memberUnit"/></td>
        <td class="th"><fmt:message code="departement.th.Departmenthead"/></td>
        <td class="th"><fmt:message code="departement.th.Departmentalassistant"/></td>
        <td class="th"><fmt:message code="department.th.leadership"/></td>
        <td class="th"><fmt:message code="depatment.th.leadership"/></td>
        <td class="th"><fmt:message code="depatement.th.Telephone"/></td>
        <td class="th"><fmt:message code="depatement.th.fax"/></td>
        <td class="th"><fmt:message code="depatement.th.address"/></td>
        <td class="th" style="width:200px;"><fmt:message code="diary.th.function"/></td>
    </tr>
    </thead>
    <tbody id="tableDapt">

    </tbody>
</table>

</body>
<script>

    $(function(){

        var departmentData =new Array();
        //部门接口
        function departmentAjax(){
            $.ajax({
                url:'/department/getAlldept',
                type:'get',
                dataType:'json',
                success:function(obj){
                    var data=obj.obj;
//                    if (obj.obj.deptParent==0||obj.obj.deptParent==20){
//
//                    }
                //    console.log(data)
                    var  departmentData= digui(data,0);
//                    console.log("0=||======================>")
                //    console.log(departmentData)
                    var str_li='';
                    str_li=queryChild(departmentData,str_li,0);
               //     console.log(str_li)
                    $("#tableDapt").html(str_li);
                }
            });
        }


        departmentAjax();
        function digui(datas,departId) {
            var data=new Array();
            for(var i=0;i<datas.length;i++){
                    if(datas[i].deptParent==departId){
                        datas[i]["childs"]=digui(datas,datas[i].deptId);
                        data.push(datas[i]);
                    }
            }
            return data;
        }

        //表单分类递归
        function queryChild(datas,str_li,level){
            for(var i=0;i<datas.length;i++){
                var className="levelleft"+level;
                if(datas[i].deptName=='未定义'){
                    str_li += "<tr><td>"+datas[i].deptName+"</td>"+//部门名称
                        "<td>"+datas[i].managerStr +"</td>"+// 部门主管
                        "<td>"+datas[i].assistantId+"</td>"+// 部门助理
                        "<td>"+datas[i].leader1+"</td>"+// 主管领导
                        "<td>"+datas[i].leader2 +"</td>"+// 分管领导
                        "<td>"+datas[i].telNo +"</td>"+// 电话
                        "<td>"+datas[i].faxNo+"</td>"+// 传真
                        "<td>"+datas[i].deptAddress+"</td>"+// 地址
                        "<td>"+datas[i].deptFunc+"</td></tr>";//部门职能
                }else{
                    str_li += "<tr><td class='"+className+"' style='padding-left: "+level*10+"px'>"+datas[i].deptName+"</td>"+//部门名称
                        "<td>"+datas[i].managerStr +"</td>"+// 部门主管
                        "<td>"+datas[i].assistantId+"</td>"+// 部门助理
                        "<td>"+datas[i].leader1+"</td>"+// 主管领导
                        "<td>"+datas[i].leader2 +"</td>"+// 分管领导
                        "<td>"+datas[i].telNo +"</td>"+// 电话
                        "<td>"+datas[i].faxNo+"</td>"+// 传真
                        "<td>"+datas[i].deptAddress+"</td>"+// 地址
                        "<td>"+datas[i].deptFunc+"</td></tr>";//部门职能
                }
                /* console.log(datas[i].childs); */
                if(datas[i].childs!=null){
                    str_li = queryChild(datas[i].childs,str_li,level+1);

                }
            }
            return str_li;
        }//表单递归结束

    })

</script>


</html>
