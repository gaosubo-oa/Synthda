
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<head>
    <title><fmt:message code="dem.th.ory" /></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/css/base.css">
    <link rel="stylesheet" href="/css/workflow/work/automaticNumbering.css">
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/common/language.js"></script>
    <script src="/js/sys/post.js?20230424.1"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style type="text/css">
        .layui-layer-btn{
            text-align: right !important;
        }
    </style>
</head>
<body>
<div class="headTop">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/post.png" alt="">
    </div>
    <div class="divTitle">
        <fmt:message code="dem.th.ory" />
    </div>
    <div style="padding-right:10px;: 20px;" class="newBtn" id="user_btn">
        <div class="div_IMG">
            <img src="../img/sys/icon_newlyBuild.png" style="vertical-align: middle;" alt="<fmt:message code="depatement.th.Newcompany" />">
        </div>
        <div class="div_txt"><fmt:message code="global.lang.delg" /></div>
    </div>

</div>
<div style="margin: 0 auto;margin-top: 10px;height: 60px;width: 97%;" class="clearfix">
    <%--<label class="fl" style="margin-top: 16px;">--%>
        <%--<span class="fl" style="margin-top: 5px;"><fmt:message code="doc.th.recordType"/>：</span>--%>
        <%--<select name="dispatchType" id="">--%>
            <%--<option value=""><fmt:message code="hr.th.PleaseSelect"/></option>--%>
        <%--</select>--%>
    <%--</label>--%>

    <%--<label class="fl clearfix" style="margin-top: 16px;margin-left: 10px;">--%>
        <%--<span class="fl" style="margin-top: 5px;"><fmt:message code="global.lang.date"/>：</span>--%>
        <%--<label class="fl"><input name="printDate" readonly="readonly" placeholder="<fmt:message code="doc.th.enterDate"/>" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" type="text"></label>--%>

    <%--</label>--%>
    <%--<label class="fl clearfix" style="margin-top: 16px;margin-left: 10px;" >--%>
        <%--<span class="fl" style="margin-top: 5px;"><fmt:message code="notice.th.title"/>：</span>--%>
        <%--<label class="fl"><input name="title" placeholder="<fmt:message code="global.lang.printsubject"/>"  type="text"></label>--%>
    <%--</label>--%>
    <%--<label class="fl clearfix" style="margin-top: 16px;margin-left: 10px;" >--%>
        <%--<span class="fl" style="margin-top: 5px;"><fmt:message code="notice.th.state"/>：</span>--%>
        <%--<label class="fl"><select name="status">--%>
            <%--<option value=""><fmt:message code="hr.th.PleaseSelect"/></option>--%>
            <%--<option value="1"><fmt:message code="lang.th.will"/></option>--%>
            <%--<option value="2"><fmt:message code="lang.th.Process"/></option>--%>
        <%--</select></label>--%>
        <%--<button  type="button" class="Query fl"><fmt:message code="global.lang.query"/></button>--%>
    <%--</label>--%>

</div>


<div class="pagediv" style="margin: 0 auto;width: 97%;">
    <table>
        <thead>
        <tr>
            <th><fmt:message code="hr.th.number" /></th>
            <th><fmt:message code="dem.th.postName" /></th>
            <th><fmt:message code="dem.th.type" /></th>
            <th><fmt:message code="hr.th.level" /></th>
            <th><fmt:message code="workflow.th.sector" /></th>
            <%--<th></th>--%>
            <th><fmt:message code="menuSSetting.th.menuSetting" /></th>
            <%--<th><fmt:message code="notice.th.state"/></th>--%>
            <%--<th><fmt:message code="notice.th.operation"/></th>--%>
        </tr>
        </thead>
        <tbody>

        </tbody>
    </table>
    <div id="dbgz_page" class="M-box3 fr">

    </div>
</div>

<script>
    //删除附件
    function deleteChatment(data,element){

        layer.confirm('<fmt:message code="menuSSetting.th.isdeleteMenu" />？', {/*确定要删除吗*/
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮 /*确定 取消*/
            title:'<fmt:message code="notice.th.DeleteAttachment" />' /*删除附件*/
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'get',
                url:'../delete',
                dataType:'json',
                data:data,
                success:function(res){

                    if(res.flag == true){
                        layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});/*删除成功*/
                        element.remove();
                    }else{
                        layer.msg('<fmt:message code="lang.th.deleSucess" />', { icon:6});/*删除失败*/
                    }
                }
            });

        }, function(){
            layer.closeAll();
        });
    }
</script>
</body>
</html>
