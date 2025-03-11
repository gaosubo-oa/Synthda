<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/26
  Time: 10:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title>查看邮件状态</title>
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/css/base.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>


</head>
<script>
    var bodyId="${bodyId}";
    var userIds="${userIds}";
    var param ={
        bodyId:bodyId,
        userIds:userIds
    }
    $.post('/emailPlus/getEmailReadDetail?bodyId='+bodyId+'&userIds='+userIds,
        {
        },function (json) {
          if(json.flag){
              var str='';
              var datas =json.datas;
              for(var i=0;i<datas.length;i++){

                  str+='<tr>'+
                      '<td>'+datas[i].userName+'</td>' +
                      '<td>'+function () {
                          if(datas[i].readFlag==0){
                              return "<fmt:message code="email.th.unread"/>"
                          }else {
                              return "<fmt:message code="email.th.read"/>"
                          }
                      }()+'</td>'+
                      '<td>'+function () {
                          if(datas[i].readFlag==0){
                              return "";
                          }else {
                              //return datas[i].readTime+"";

                              if(datas[i].readTime!="" && datas[i].readTime!=undefined){
                                  return new Date(datas[i].readTime).Format("yyyy-MM-dd hh:mm:ss")
                              }else{
                                  return "";
                              }

                          }
                      }()+'</td>'+
                      '<td>'+datas[i].deptName+'</td>'+
//                      '<td>'+datas[i].userName+'</td>'
                      '</tr>';

                  datas[i].userName;
              }
              $('.pagediv table tbody').html(str)
          }

    })
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
            if(res.object.length!=0){
                var data=res.object[0]
                if (data.paraValue!=0){
                    $('#dbgz_page').before('<p style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 25px;margin-top: 10px;margin-bottom: 10px;"> 机密级★ </p>')
                }
            }
        }
    })



</script>

<body>

        <div id="dbgz_page" class="M-box3 fr">
        </div>
    <div class="pagediv" style="margin: 0 auto;width: 97%;">
        <table>
            <thead>
                <tr>
                    <th><fmt:message code="email.th.recipients"/></th>
                    <th><fmt:message code="notice.th.state"/></th>
                    <th><fmt:message code="email.th.readtime"/></th>
                    <%--<th><fmt:message code="email.th.readtime"/></th>--%>
                    <th><fmt:message code="hr.th.department"/></th>
                    <%--<th>阅读时间</th>--%>
                </tr>
            </thead>
            <tbody>
           </tbody>
        </table>
    </div>
</body>
</html>
