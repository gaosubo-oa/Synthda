<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="dem.th.fileManagement" /></title>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
<%--    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/laydate/laydate.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <style>
        a{
            text-decoration: none;
            color: #207bd6;
        }
        .buttonDiv{
            width: 100%;
        }
        .buttonDiv>div{
            float: left;
            margin: 20px 10px;
        }
        .buttonDiv .deleteBtn{
            width: 99px;
            height: 28px;
            /*margin: 20px auto;*/
            background: url("../img/btn_deletecontent_03.png") no-repeat;
            line-height: 28px;
            cursor: pointer;
        }
        .buttonDiv .exportDiv{
            width: 99px;
            height: 28px;
            /*margin: 20px auto;*/
            background: url("../img/icon_daoru.png") no-repeat;
            line-height: 28px;
            cursor: pointer;
        }
        .fileDone select{
            width: 160px;
            height:28px;
        }
        #tr_td tr:nth-child(odd){
            background-color: #fff;
        }

        input{
            float: none;
        }
        .newMange input[type="text"]{
            width: 260px;
            height: 30px;
        }
        select{
            width: 260px;
            height: 30px;
        }
        textarea{
            width: 260px;
            height: 50px;
            vertical-align: middle;
        }
        a{
            text-decoration: none;
            color: #207bd6;
        }
        .newTbale{
            width: 60%;
            margin: 0px auto;
            margin-top: 70px;
        }
        .newTbale tr td{
            border-right: #ccc 1px solid;
            padding: 5px;
        }
        .newTbale tr td:first-of-type{
            text-align: right;
        }
        .buttonDivs{
            width: 100%;
            margin-top: 20px;
        }
        .divBtn{
            width: 75px;
            margin: 0 auto;
            height: 30px;
        }
        .saveBtn{
            display: block;
            float: left;
            background: url(../img/confirm.png) no-repeat;
            border: none;
            width: 70px;
            height: 29px;
            line-height: 29px;
            cursor: pointer;
        }
    </style>
</head>

<body>
<div class="bx">
    <div class="navigation  clearfix exportMange" style="display: block;">
        <div class="left" style="margin-left: 30px;width: 40%">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/weidugonggao.png" style="margin-top: 20px">
            <div class="news">
                <fmt:message code="hr.th.SelectImportfile" />
            </div>
        </div>
        <div class="wrap" style="margin-left: 0;padding: 0 20px;margin-top: 70px;">
            <form id="form1" action="/rmsFile/import">
                <table class="newTbale" style="margin-top: 0;">
                    <tr>
                        <td> <fmt:message code="hr.th.DownloadImportTemplates" />：</td>
                        <td><a href="/file/rmsFile/文件档案.xls"><fmt:message code="hr.th.DownloadTemplate" /></a></td>
                    </tr>
                    <tr style="border-top: 0;">
                        <td style="width: 180px;"><fmt:message code="hr.th.selectFile" />：</td>
                        <td colspan="3">
                            <%--<div class="attachNameDiv"></div>--%>
                            <%--<form id="uploadimgform" target="uploadiframe"  action="/upload?module=rmsFile"  method="post" >--%>
                                <%--<input type="file" multiple="multiple" name="file"  id="uploadinputimg"  class="w-icon5" style="position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">--%>
                                <%--<a href="#" id="uploadimg"><img style="margin-right:5px;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>--%>
                            <%--</form>--%>
                                <input type="file" name="file"  id="uploadinputimg"  class="w-icon5" style="width: 300px;">
                        </td>
                    </tr>
                    <tr>
                        <td> <fmt:message code="roleAuthorization.th.Explain" />：</td>
                        <td>
                            <p>1、<fmt:message code="hr.th.textPlan" /></p>
                            <p style="color: #f00;">2、<fmt:message code="hr.th.textExplain" /></p>
                        </td>
                    </tr>
                </table>
            </form>
            <div class="buttonDivs">
                <div class="divBtn">
                    <div class="saveBtn"><span style="margin-left: 32px;"><fmt:message code="workflow.th.Import" /></span></div>
                </div>
            </div>
        </div>
    </div>

    <div class="navigation  clearfix mangeList" style="display: none;">
        <%--<div class="left" style="margin-left: 30px">--%>
            <%--<img src="/img/commonTheme/${sessionScope.InterfaceModel}/weidugonggao.png">--%>
            <%--<div class="news">--%>
                <%--文件管理--%>
            <%--</div>--%>
        <%--</div>--%>
        <div class="wrap" style="margin-left: 0;padding: 0 20px;">
            <table id="tr_td">
                <thead>
                <tr>
                    <%--<td>--%>
                        <%--<input type="checkbox" id="checkedAll">--%>
                    <%--</td>--%>
                    <td class="th">
                        文件号
                    </td>
                    <td class="th" style="width: 30%;">
                        文件标题
                    </td>
                    <td class="th">
                        密级
                    </td>
                    <td class="th">
                        发文单位
                    </td>
                    <td class="th">
                        发文时间
                    </td>
                    <td class="th">
                        所属案卷
                    </td>
                    <td class="th">
                        状态
                    </td>
                </tr>
                </thead>
                <tbody id="j_tb">

                </tbody>
            </table>
            <div class="right">
                <!-- 分页按钮-->
                <div class="M-box3" id="dbgz_page">
                </div>

            </div>
        </div>
    </div>

</div>
<script type="text/javascript">
    $(function() {

//        导入
        $('.saveBtn').on('click',function(){
            if($('#uploadinputimg').val() == ''){
                $.layerMsg({content: '<fmt:message code="file.th.PleaseSelectFile" />', icon: 5});
                return false;
            }
            $('#form1').ajaxSubmit({
                type: 'post',
                dataType: 'json',
                success: function (res) {
                   if (res.flag) {
                       $.layerMsg({content: '导入成功！', icon: 1}, function () {
                           $('.one',window.top.document).trigger('click')
                       });
                   } else {
                       // $(this).attr('data-type',true)
                       // alert('异常')
                       $.layerMsg({content: '导入失败！', icon: 0});
                   }
                }
            })
        })
    })

    function deleteChatment(data,element){

        layer.confirm('<fmt:message code="workflow.th.que" />？', {
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
            title:"<fmt:message code="notice.th.DeleteAttachment" />"
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'get',
                url:'../delete',
                dataType:'json',
                data:data,
                success:function(res){

                    if(res.flag == true){
                        layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});
                        element.remove();
                    }else{
                        layer.msg('<fmt:message code="lang.th.deleSucess" />', { icon:6});
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
