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
<head>
    <meta charset="UTF-8">
    <meta name="referrer" content="no-referrer">
    <title><fmt:message code="news.th.newsDetail"/></title>
    <link rel="stylesheet" type="text/css" href="../css/news/newsDetail.css"/>
    <script src="/js/common/language.js"></script>
<%--    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/attachment/attachView.js?20210406.1" type="text/javascript" charset="utf-8"></script>
    <script src="../js/webOffice/fileShow.js?20210423.1" type="text/javascript" charset="utf-8"></script>
    <style type="text/css">
        .divTxt p{
            word-wrap: break-word;
        }
        .divTxt p img{
            max-height: 100%;
            max-width: 100%;
        }
        a {
            color: #207BD6;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
    <script type="text/javascript">
        var changId = $.GetRequest().changId || ''
        function yd(e){
            var atturl = e.attr('attrurl');
            $.pdurl($.UrlGetRequest('?'+atturl),atturl);
        }
        $(function () {

            var nid = $.getQueryString('newsId');

            $.ajax({
                type: 'get',
                url: 'getOneById',
                dataType: 'json',
                data: {
                    'newsId': nid,
                    changId:changId
                },
                success: function (rsp) {
                    var data1 = rsp.object;
                    var str = '';
                    
                    var toTypeName = "";
                    if (rsp.object.toId != "") {
                        toTypeName += "<fmt:message code="userManagement.th.department" />";
                    }
                    if (rsp.object.privId != "") {
                        toTypeName += ",<fmt:message code="userManagement.th.role" />";
                    }
                    if (rsp.object.userId != "") {
                        toTypeName += ",<fmt:message code="journal.th.user" />";
                    }
                    if(rsp.object.anonymityYn=='0'){
                        $('#anonymous_personnel').hide();
                        $('#pinglunArea').show();
                    }else if(rsp.object.anonymityYn=='2'){
//                        $('#anonymous_personnel').hide();
//                        $('#system_personnel').hide();
//                        $('#add_text').attr('disabled',true);
//                        $('#determine').hide();
                        $('#pinglunArea').hide();
                    }else {
                        $('#pinglunArea').show();
                    }

//<a href="/common/ntkoPreview?'+encodeURI(arr[i].attUrl)+'"  target="_Blank" style="margin: 0 20px;"><fmt:message code="global.lang.view" /></a>
                    $('.title').text(data1.subject);
                    $('.title').attr("title",data1.subject);
                    var str2 = '';
                    if (!!data1.author) {
                        str2 += '<li><span><fmt:message code="event.th.author" />：</span><span>' + data1.author + '</span></li>'
                    }
                    if (!!data1.photographer) {
                        str2 += '<li><span><fmt:message code="new.th.photography" />：</span><span>' + data1.photographer + '</span></li>'
                    }
                    str = str2 + '<li><span><fmt:message code="notice.th.publisher" />：</span><span>' + data1.users.userName + '</span></li><li><span><fmt:message code="notice.th.PostedTime" />：</span><span>' + data1.newsDateTime + '</span></li>';
                    $('ul').append(str);
                    $('.divTxt').append('<p>' + data1.content + '</p>');
                    var str1 = "";
                    var arr = data1.attachment;
                    if (arr!=undefined&&arr.length>0) {
                        $('.Table').html(attachView(arr, '', '4', '0', '1', '0'));
                    }

                }
            });

            /*关闭按钮*/
//            $('#buttonReturn').click(function () {
//                window.close();
//                location.reload();
//            });
            $.ajax({
                type:'get',
                url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
                dataType:'json',
                success:function (res) {
                    if(res.object.length!=0){
                        var data=res.object[0]
                        if (data.paraValue!=0){
                            $('.detailsContent').before('<p style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;margin-bottom: 0px;"> 机密级★ </p>')
                        }
                    }
                }
            })


        });
        $(document).on('click','.operationImg',function () {
            var thisa = $(this).next().attr('openimg')
            var openNmu = $(this).next().attr('openNmu')
            var str3 = '<input type="text" id="getIndex" openNum = "'+openNmu+'" style="display: none">'
            $('.divContent1').append(str3)
            $('#getIndex').val(thisa)
            console.log(openNmu)
            window.open("/email/imgOpen?openNmu="+openNmu,"_blank");
        })
    </script>
</head>
<body>
<div class="detailsContent">
    <div class="title"></div>
    <div class="infor">
        <ul>

        </ul>
    </div>
    <div class="divContent">
        <div class="divTxt">
        </div>
        <div class="divContent1" style="border-top:1px solid #dedede; padding-top:10px;">
            <table class="Table" cellspacing="0" cellpadding="0">
            </table>
        </div>
    </div>
    <%--<div id="pinglunArea" style="display: none;"><jsp:include page="comment.jsp"/></div>--%>

    <%--<a href="javascript:void(0);" id="buttonReturn" class="button_query">关闭</a>--%>
</div>
</body>
</html>

