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
    <title><fmt:message code="meet.th.ReadingStatus" /></title>
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style>
        *{margin: 0;padding: 0;}
        html,body{width: 100%;font-family: 微软雅黑;}
        .content{width: 100%}
        .header{width: 100%;height: 45px;overflow: hidden;background-color: #2b7fe0;}
        .divImg{width: 21px;height:26px;margin-top:10px;margin-left: 3%;float: left;}
        .title{line-height: 45px;margin-left: 20px;font-size: 20px;float: left;color:#fff;}
        .mainTitle{font-size: 15px;color:#fff;margin-left: 10px;}
        .headerBtn{width: 118px;height: 28px;float: right;font-size: 14px;line-height: 28px;margin-top: 9px;margin-right: 3%;cursor: pointer;}
        #emptySign{background: url("../img/file/icon_sweep_10.png") no-repeat;}
        #remind{text-align: center;border: #ccc 1px solid;border-radius: 5px;}
        .main{width: 100%;margin: 0 auto;}
        /*.mainTitle{width: 100%;border:#ccc 1px solid;height: 30px;text-align: center;line-height: 30px;font-size: 15px;}*/
        .TableBlock{width:99%;border: 1px #dddddd solid;font-size: 9pt;border-collapse: collapse;margin: 10px auto;}
        .TableBlock th{color:#2F5C8F;padding: 10px;}
        .TableBlock td{border: #ccc 1px solid;padding: 6px;}
        .noSignReading{width: 100%}
        .noSignReading .bgImg{width: 290px;height: 120px;margin: 70px auto;background-color: #357ece;border-radius: 10px;box-shadow: 3px 3px 3px #2F5C8F;overflow: hidden;}
        .noSignReading .bgImg .IMG{float: left;width: 60px;height: 60px;margin-top: 32px;margin-left: 30px;}
        .noSignReading .bgImg .IMG img{width: 100%;}
        .noSignReading .bgImg .TXT{float: left;color: #fff;font-size: 16px;margin-top: 50px;margin-left: 20px;}
    </style>
</head>
<body>
<div class="content">
    <div class="header">
        <%--<div class="divImg"><img src="../img/file/icon_publicFile.png" alt=""></div>--%>
        <div class="title"><fmt:message code="meet.th.ReadingStatus" /><span class="mainTitle"></span></div>
        <div class="headerBtn" id="emptySign"><span style="margin-left: 27px;"><fmt:message code="main.th.EmptyYourSign" /></span></div>
        <%--<div class="headerBtn" id="remind"><span>提醒未读人员</span></div>--%>
    </div>
    <div class="main" style="display: block;">
        <%--<div class="mainTitle"></div>--%>
        <table class="TableBlock" width="100%">
            <tr>
                <th style="text-align: left;margin-left: 10px;"><fmt:message code="departement.th.memberUnit" /></th>
                <th><fmt:message code="main.th.AlreadyReadPersonnel" /></th>
                <th><fmt:message code="main.th.UnreadPersons" /></th>
            </tr>
        </table>
    </div>
    <div class="noSignReading" style="display: none;">
        <div class="bgImg">
            <div class="IMG">
                <img src="../img/sys/icon64_info.png"/>
            </div>
            <div class="TXT"><fmt:message code="main.th.NoOneReads" /></div>
        </div>
    </div>
</div>
<script>
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
    $(function(){
        var contentId=$.getQueryString("contentId");
        $.ajax({
            url: '../file/signConState',
            type: 'get',
            data: {'contentId': contentId},
            dataType: 'json',
            success: function (res) {
                var data=res.obj;
                var arrData=res.msg.split(',');
                $('.mainTitle').html('');
                var str='';
                $('.mainTitle').html(res.object.subject);
                if(res.flag==true){
                    var arrs=digui(data,0)
                    str= departmentChild(arrs,str,0,-1)
                    var foot='<tr><td nowrap  style="text-align: left;margin-left: 10px;"><b><fmt:message code="global.lang.total" />：</b></td><td nowrap align="center"><b>'+arrData[1]+'</b></td><td nowrap align="center"><b>'+arrData[0]+'</b></td></tr>'

                    $('.TableBlock').append(str+foot);
                }
            }
        })

        //清空签阅情况
        $('#emptySign').click(function(){
            layer.confirm('<fmt:message code="main.th.emptySign" />？', {
                btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
                title:"<fmt:message code="main.th.EmptySign" />"
            }, function(){
                $.ajax({
                    type:'post',
                    url:'../file/updateContent',
                    dataType:'json',
                    data:{'contentId': contentId,'readers':''},
                    success:function(){
                        layer.msg('<fmt:message code="main.th.EmptySuccess" />', { icon:6});
                        $('.main').hide();
                        $('.noSignReading').show();
                    }
                })
            }, function(){
                layer.closeAll();
            });

        })
    })

    //部门遍历方法
    function departmentChild(datas,opt_li,level,dept){
        for(var i=0;i<datas.length;i++){
            var String="";
            var space=""
            for(var j=0;j<level;j++){
                space+="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            }
                if(i==0){
                String=space+"├";
            }else if(i!=0){
                String=space+"├";
            }else if(i==datas.length-1){
                String=space+"├";
            }
            if(dept==datas[i].deptId){
                opt_li+='<tr class=TableData><td class="TableContent">'+String+datas[i].deptName+'</td><td style="">'+datas[i].read+'</td>'+
                    '<td style="">'+datas[i].unread+'</td></tr>';
            }else{
                opt_li+='<tr class=TableData><td class="TableContent">'+String+datas[i].deptName+'</td><td style="">'+datas[i].read+'</td>'+
                    '<td style="">'+datas[i].unread+'</td></tr>';
            }
            if(datas[i].childs!=null){
                opt_li = departmentChild(datas[i].childs,opt_li,level+1,dept);
            }
        }
        return opt_li;
    }
</script>
</body>
</html>
