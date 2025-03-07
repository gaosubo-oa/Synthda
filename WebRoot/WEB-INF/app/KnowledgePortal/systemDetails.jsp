<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    String corpId = (String)request.getAttribute("corpId");
    String corpSecret = (String)request.getAttribute("corpSecret");
%>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>制度详情</title>
    <link rel="stylesheet" href="../../css/email/m/jquery.mobile.css" />
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>

    <link rel="stylesheet" href="../../css/email/m/styles.css" />
    <link rel="stylesheet" href="../../css/email/m/mail.css">
    <script type="text/javascript" src="../../js/notes/jquery-2.1.2.min.js" ></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <script type="text/javascript" src="../../js/diary/m/simbaJs.js" ></script>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" href="../../lib/mui/mui/mui.picker.min.css" />
    <script type="text/javascript" src="../../lib/mui/mui/mui.picker.min.js"></script>
    <style>
        body{
            word-break: break-word;
            overflow: auto;
        }
        .cont{
            margin: auto 10px;
        }
        .item{
            text-align: center;
            margin-top: 10px;
            font-size: 20px;
            color: #2a588c;
        }
        .cont{
            font-size: 16px;
            color: #646464;
            line-height: 30px;
            line-height: 38px;
        }
        .details{
            color: #000;
            line-height: 25px;
            font-size: 15px;
        }
        .header{
            margin-top: 10px;
            margin-left:10px;
        }
        .cont a{
            color: blue;
        }
    </style>
</head>
<body>
    <div class="cont">
    </div>
</div>
</body>
</html>
<script>
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }
    var instId = getQueryString('instId')
    $.ajax({
        url:'/InstitutionContent/findContentById',
        type:'get',
        dataType:'json',
        data:{
            instId: instId
        },
        success:function(res){
            if (res.flag) {
                var str = '';
                var data = res.object;
                
                if (!!data) {
                    str = '<div class="item">' + empty(data.instName) + '</div>\n' +
                        '        <div class="cont">\n' +
                        '            <div><span>制度编号:</span><span class="number">' + empty(data.instNumber) + '</span></div>\n' +
                        '            <div><span>制度分类:</span><span>' + empty(data.institutionSort.sortName) + '</span><div>\n' +
                        '        </div>\n' +
                        '        <hr>\n' +
                        '        <div class="details">' + empty(data.instContent) + '</div>'
                }
                
                $('.cont').html(str);
                
                var $aEles = $('.cont').find('a');
                
                $aEles.each(function(){
                    var _this = this;
                    var href = $(this).attr('href');
                    
                    if (!!href) {
                        // 判断是否为下载链接
                        if (/^\/download\?/.test(href)) {
                            var aid = '';
                            var module = '';
                            var paramsArr = href.split(/\?/)[1].split(/&/g);
                            paramsArr.forEach(function(item){
                                var key = item.split('=')[0];
                                if (key == 'AID') {
                                    aid = item.split('=')[1];
                                }
                                if (key == 'MODULE') {
                                    module = item.split('=')[1];
                                }
                            });
                            
                            $.get('/attachment/findByAid', {aid: aid, module: module}, function(res){
                                if (res.flag && res.object) {
                                    $(_this).attr('attrUrl', '/download?'+res.object.attUrl);
                                    $(_this).attr('href', 'javascript:;');
                                    $(_this).attr('name', res.object.attachName);
                                    $(_this).addClass('link_download');
                                }
                            });
                            
                        } else if (/^\/institution\/selectInstitution\?/.test(href)) { // 判断是否是制度详情链接，修改为h5链接
                            href = href.replace(/^\/institution\/selectInstitution/, '/KnowledgePortalH5/systemDetails');
                            $(this).attr('href', href);
                        }
                    }
                });
            }
        }
    })
    
    // 附件下载
    $('.cont').on('click', '.link_download', function () {
        var url = $(this).attr('attrUrl');
        var name = $(this).attr('name') || '';
        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
            if ($.getQueryString("type") == 'EWC') {
                window.open(url)
            } else {
                try{
                    window.webkit.messageHandlers.overLookFile.postMessage({'url':url,'name':name});
                }catch(error){
                    overLookFile(url,name);
                }
            }
        } else if (/(Android)/i.test(navigator.userAgent)) {
            if ($.getQueryString("type") == 'EWC') {
                window.open(url)
            } else {
                Android.overLookFile(url, name);
            }
        } else {
            window.open(url);
        }
    });

    // //返回功能
    // mui('.header').on('tap','.moreFiles',function(){
    //     window.history.go(-1)
    // })
    //判断返回是否为空
    function empty(esName) {
        if (esName==undefined ||esName==''){
            return ''
        }else{
            return esName
        }
    }
</script>
