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
    <!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/css/base.css">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" type="text/css" href="../css/aplayer/apalyer.css?20221209">
<%--    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script src="../../js/news/page.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/attachment/attachView.js?20221108.1" type="text/javascript" charset="utf-8"></script>
    <script src="/js/dplayer/dp.js?20220318.1" type="text/javascript" charset="utf-8"></script>
    <script src="/js/dplayer/renderVideo.js?20220318.1" type="text/javascript" charset="utf-8"></script>
    <title><fmt:message code="vote.th.VotingResults"/></title>
    <style>
        .title span {
            font-size: 22px;
            color: #494d59;
            padding-left: 20px;

        }
.operationDiv {
    display: block;
}
        .title {
            margin-bottom: 20px;
            text-align: center;
            font-weight: bold;
        }

        .tit {
            background-color: #D6E4EF;
            font-size: 15px;
            color: #2F5C8F;
            font-weight: bold;
            border: 0px;
            line-height: 40px;
            text-align: left;
            border: 1px solid #c0c0c0;
            margin-top: -1px;
        }
        .download,.saveto {
            display: none;
        }
        .con {
            text-align: right;
        }

        .con > span {
            padding-right: 20px;
        }

        .box {
            height: 30px;
            width: 300px;
            margin: 20px auto;
        }

        .box button {
            width: 80px;
            height: 30px;
            line-height: 30px;
            border-radius: 3px;
        }

        #result {
            width: 120px;
        }

        #vote {
            float: left;
            width: 76px;
            height: 30px;
            line-height: 30px;
            background: url("../../img/vote/icon_toupiao.png") no-repeat;
            cursor: pointer;
        }

        #vote span {
            margin-left: 36px;
            font-size: 14px;
            color: #fff;
        }

        #close {
            float: left;
            width: 76px;
            height: 30px;
            line-height: 30px;
            background: url("../../img/vote/icon_back.png") no-repeat;
            cursor: pointer;
        }

        #close span {
            margin-left: 36px;
            font-size: 14px;
        }

        #result {
            float: left;
            width: 106px;
            height: 30px;
            line-height: 30px;
            background: url("../../img/vote/icon_chakan.png") no-repeat;
            cursor: pointer;
            margin: 0 20px;
        }

        #result span {
            margin-left: 36px;
            font-size: 14px;
        }
    </style>
</head>
<body style="overflow:scroll;overflow-y: auto;overflow-x:hidden;">

<%--学生信息列表--%>
<div style="margin-top:20px">
    <div class="title">
        <span class="titleName"></span>
    </div>
    <div class="description">
        <%--<span class="description">这里是投票描述</span>--%>
    </div>
    <div class="con">
        <span><fmt:message code="notice.th.publisher"/>:<span class="user"></span></span>
        <span><fmt:message code="notice.title.Releasedate"/>:<span class="time"></span></span>
    </div>
</div>
<div>
    <div class="table">
        <ul class="list">

        </ul>
    </div>
</div>
<div class="box">
    <div id="vote"><span><fmt:message code="vote.th.vote"/></span></div>
    <div id="close" style="margin-left:20px"><span><fmt:message code="global.lang.close"/></span></div>
</div>
</body>

<script type="text/javascript">
    $(function () {
//        获取id和标题
        var sId = $.GetRequest().resultId;
// 显示标题和日期以及发布人
        var type;

//展示投票
        function init() {
            $.ajax({
                url: '/vote/manage/getChildVoteList',
                type: 'get',
                data: {voteId: sId},
                dataType: 'json',
                success: function (res) {
                    var strDescription;
                    var data = res.object;
                    type = data.type;
                    var parent = data.voteItemList;
                    var fileArr = [];

                    var child = data.voteTitleList;
                    $('.titleName').html(data.subject);
                    $('.user').html(data.userName);
                    $('.time').html(data.sendTime);
                    strDescription = '<span>' + data.content + '</span>';

                    str = '  <li id="' + data.voteId + '" data-type="' + data.type + '"> ' +
                        '<div class="tit">' + data.subject + '</div> ' +
                        '<ul class="conn"><table>' +
                        function () {
                            var str1 = "";
                            if (parent.length > 0) {
                                if (data.type != 2) {
                                    for (var i = 0; i < parent.length; i++) {
                                        var data2=parent[i].attachmentList;
                                        var data3=parent[i].attachmentName;
                                        str1 += '<tr>' +
                                            '<td style="width:25%">' + function () {

                                                if (data.type == "0") {
                                                    if (parent[i].itemName.indexOf("{textarea}") != -1) {
                                                        return '<input type="radio"  name="radio' + data.voteId + '" id="' + parent[i].itemId + '" value="' + parent[i].itemName + '"  /><span style="padding-left:7px;">' + parent[i].itemName.replace('{textarea}', "") + '</span> '
                                                            + '<textarea  class="voteReason1 " id="' + parent[i].itemId + '" rows="5" cols="30">' + '</textarea>'
                                                    } else {
                                                        return '<input type="radio" satisfaction="1"  name="radio' + data.voteId + '" id="' + parent[i].itemId + '" value="' + parent[i].itemName + '" /><span style="padding-left:7px;">' + parent[i].itemName + '</span>'+
                                                            '<span>'+function () {
                                                                if(data2!==undefined){
                                                                    var stra2 = '';
                                                                    for (var i = 0; i < data2.length; i++) {
                                                                        var arrUrl = data2[i].attUrl;
                                                                        var fileExtension = data2[i].attachName.substring(data2[i].attachName.lastIndexOf(".") + 1, data2[i].attachName.length);//截取附件文件后缀
                                                                        var attName = encodeURI(data2[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                                        var gs = data2[i].attachName.substring(data2[i].attachName.lastIndexOf(".") + 1, data2[i].attachName.length);
                                                                        var deUrl = data2[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + data2[i].size;
                                                                        if(gs.indexOf('png')!==-1||gs.indexOf('bmp')==!-1||gs.indexOf('jpeg')==!-1||gs.indexOf('jpg')!==-1){//后缀为这些的禁止上传
                                                                            return '<img src="/xs?'+ encodeURI(deUrl) +'" ' + 'alt=""   height="30px" style="margin-left: 30px">';
                                                                        }else if(gs.indexOf('mp4')!==-1){
                                                                            return '<span data-src="'+arrUrl+'">'+data2[i].attachName+'</span><a href="#" id="bf"><fmt:message code="vote.th.play" /></a>'
                                                                        }else {

                                                                            stra2= attachView(data2,'','3', '0', '1', '0');
                                                                        }
                                                                    }
                                                                    return stra2
                                                                } else {
                                                                    return data3
                                                                }
                                                            }()+'</span> '
                                                    }
                                                } else if (data.type == "1") {
                                                    if (parent[i].itemName.indexOf("{textarea}") != -1) {
                                                        return '<input type="checkbox" parentcheckbox="1"   name="checkbox' + data.voteId + '" id="' + parent[i].itemId + '" value="' + parent[i].itemName + '" /><span style="padding-left:7px;">' + parent[i].itemName.replace('{textarea}', "") + '</span>'
                                                            + '<textarea  class="voteReason1" id="' + parent[i].itemId + '" rows="5" cols="30">' + '</textarea>'
                                                    } else {
                                                        return '<input  type="checkbox" parentcheckbox="1"  satisfaction="1"   name="checkbox' + data.voteId + '" id="' + parent[i].itemId + '" value="' + parent[i].itemName + '" /><span style="padding-left:7px;">' + parent[i].itemName + '</span>' +
                                                            '<span>'+function () {
                                                                if(data2!==undefined){
                                                                    var stra2 = '';
                                                                    for (var i = 0; i < data2.length; i++) {
                                                                        var fileExtension = data2[i].attachName.substring(data2[i].attachName.lastIndexOf(".") + 1, data2[i].attachName.length);//截取附件文件后缀
                                                                        var attName = encodeURI(data2[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                                        var gs = data2[i].attachName.substring(data2[i].attachName.lastIndexOf(".") + 1, data2[i].attachName.length);
                                                                        var deUrl = data2[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + data2[i].size;
                                                                        if(gs.indexOf('png')!==-1||gs.indexOf('bmp')==!-1||gs.indexOf('jpeg')==!-1||gs.indexOf('jpg')!==-1){//后缀为这些的禁止上传
                                                                            return '<img src="/xs?'+ encodeURI(deUrl) +'" ' + 'alt=""   height="30px" style="margin-left: 30px">';
                                                                        }else if(gs.indexOf('mp4')!==-1){
                                                                            return '<span data-src="'+arrUrl+'">'+data2[i].attachName+'</span><a href="#" id="bf"><fmt:message code="vote.th.play" /></a>'
                                                                        }else {

                                                                            stra2= attachView(data2,'','4', '0', '1', '0');
                                                                        }
                                                                    }
                                                                    return stra2
                                                                } else {
                                                                    return data3
                                                                }
                                                            }()+'</span> '
                                                    }
                                                } else {
                                                    return '<textarea  class="voteReason2 " style="width:1231px;height:121px" id="' + parent[i].itemId + '" ></textarea>'
                                                }
                                            }() +
                                            '</td>' +
                                            '</tr>'
                                    }
                                } else {
                                    str1 += '<tr>' +
                                        '<td style="width:25%">' + function () {
                                            return '<textarea  class="voteReason2 " style="width:1231px;height:121px" id="' + data.voteId + '" ></textarea>'
                                        }() +
                                        '</td>' +
                                        '</tr>'
                                }

                            }
                            else{
                                if(data.type == 2){
                                    str1+= '<tr>' +
                                        '<td style="width:25%">'+
                                        function(){
                                            return '<textarea  class="voteReason2 " style="width:1231px;height:121px" id="'+data.voteId+'" ></textarea>'

                                        }()+
                                        '</td>'+
                                        '</tr>'
                                }
                            }
                            return str1;
                        }() +
                        '</table></ul> ' +
                        '</li>' +
                        function () {
                            var str2 = "";
                            for (var i = 0; i < child.length; i++) {
                                var item = child[i].voteItemList;
                                var id = child[i].voteId;
                                var type = child[i].type;
                                str2 += '  <li id="' + child[i].voteId + '" data-type="' + data.type + '"> ' +
                                    '<div class="tit">' + child[i].subject + '</div> ' +
                                    '<ul class="conn"><table>' +
                                    function () {
                                        var str3 = "";
                                        if (type != 2) {
                                            for (var i = 0; i < item.length; i++) {
                                                str3 += '<tr>' +
                                                    '<td style="width:25%">' + function () {
                                                        if (type == "0") {
                                                            if (item[i].itemName.includes("{textarea}")) {
                                                                return '<input  type="radio"  name="radio' + id + '"  id="' + item[i].itemId + '"  />' + '<span style="padding-left:7px;">' + item[i].itemName.replace('{textarea}', "") + '</span> '
                                                                    + '<textarea  class="voteReason1 " id="' + item[i].itemId + '" rows="5" cols="30">' + '</textarea>'
                                                            } else {
                                                                return '<input  type="radio" satisfaction="1"   name="radio' + id + '"  id="' + item[i].itemId + '"/>' + '<span style="padding-left:7px;">' + item[i].itemName + '</span> '
                                                            }
                                                        } else if (type == "1") {
                                                            if (item[i].itemName.includes("{textarea}")) {
                                                                return '<input  type="checkbox"   name="checkbox' + id + '" id="' + item[i].itemId + '" />' + '<span style="padding-left:7px;">' + item[i].itemName.replace('{textarea}', "") + '</span> '
                                                                    + '<textarea  class="voteReason1 " id="' + item[i].itemId + '" rows="5" cols="30">' + '</textarea>'
                                                            } else {
                                                                return '<input  type="checkbox" satisfaction="1"  name="checkbox' + id + '" id="' + item[i].itemId + '" value="' + item[i].itemName + '" />' + '<span style="padding-left:7px;">' + item[i].itemName + '</span> '
                                                            }
                                                        }
                                                    }() +
                                                    '</tr>'
                                            }
                                        } else {
                                            return '<textarea  class="voteReason2 " style="width:1231px;height:121px;margin-top: 20px;margin-left: 13px;" id="' + id + '"></textarea>'
                                        }

                                        return str3;
                                    }() + '</table></ul> ' +
                                    '</li>'
                            }
                            return str2;
                        }() +
                        '</table></ul> ' +
                        '</li>' +
                        function () {
                            if (data.anonymity == 1) {
                                var str2 = "";
                                str2 += '  <li id="" data-type=""> ' +
                                    '<div class="tit"><fmt:message code="vote.th.secretBallot" /></div> ' +
                                    '<ul class="conn"><table>' + function () {
                                        var str3 = "";
                                        str3 += '<tr>' +
                                            '<td style="width:25%">' +
                                            '<input  type="radio" class="anonymity" name="anonymity" value="<fmt:message code="global.lang.no" />" checked="true"/>' +
                                            '<input  style="margin-left: 28px;width: 200px;display: inline-block" type="text" class="anonymityName" value="匿名用户" readonly="readonly" /><i style="color: red;display: inline-block">*</i></td>' +
                                            '</tr>'
                                        return str3;
                                    }() + '</table></ul> ' +
                                    '</li>'
                                return str2;
                            } else {
                                return '';
                            }

                        }();
                    $('.list').html(str);
                    $(".description").html(strDescription);
                    if (type == "1") {
                        $('#vote').attr('num', data.maxNum)
                        $('#vote').attr('minnum', data.minNum)
                        $(document).ready(function () {
                            $('input[name="checkbox"]').on('click',function () {
                                if ($("input[name='checkbox']:checked").length > data.maxNum) {
                                    if (languageType == 'zh_CN') {
                                        $.layerMsg({content: '最多选择' + data.maxNum + '个', icon: 2})
                                    } else if (languageType = 'zh_tw') {
                                        $.layerMsg({content: '最多選擇' + data.maxNum + '個', icon: 2})
                                    } else if (languageType = 'en_US') {
                                        $.layerMsg({content: 'Select at most' + data.maxNum + 'item', icon: 2})
                                    }
                                    $(this).removeAttr("checked");
                                }
                            });
                        });
                    }
                    $('.anonymity').on('click',function () {
                        if ($('input[name=anonymity]:checked').val() == '<fmt:message code="global.lang.yes" />') {
                            $(this).val('<fmt:message code="global.lang.no" />');
                            $(this).siblings().css('display', 'inline-block')
                        } else {
                            $(this).val('<fmt:message code="global.lang.yes" />');
                            $(this).prop('checked', false);
                            $(this).siblings().css('display', 'none')
                        }
                    });
                }

            })
        }

        init()

$(document).on("click","#bf",function() {
    var languageType = getCookie("language");

    var url = $(this).siblings('span').attr("data-src");
    renderVideo({
        url:'/download?'+url,
        width: 800,
        height: 500
    })
})
//        点击关闭
        $('#close').on('click',function () {
            window.close();
        })
            var checkboxlen
        //点击投票
        $('#vote').on('click',function () {
            var voteCon = "";
            var voteMsg = "";
            var textarea1 = $('.voteReason1').length;
            var textarea2 = $('.voteReason2').length;
            var lilen = $(".list").find("li");
            var tal = [];
            for (var z = 0; z < lilen.length; z++) {
                var l = lilen.eq(z).find("ul").children().length;
                if (l > 1) {
                    tal.push(lilen.eq(z));
                } else if (l == 1 && lilen.eq(z).find("ul").children().children().length > 0) {
                    tal.push(lilen.eq(z));
                }
            }
            var arr = []
            for (var i = 0; i < tal.length; i++) {
                if ($(tal[i]).find('input[type="radio"]:checked').length > 0 && $(tal[i]).find('input[type="radio"]:checked') != undefined) {
                    arr.push($(tal[i]).find('input[type="radio"]:checked'));
                }
                if ($(tal[i]).find('input[type="checkbox"]:checked').length > 0 && $(tal[i]).find('input[type="checkbox"]:checked') != undefined) {
                    arr.push($(tal[i]).find('input[type="checkbox"]:checked'));
                }
                if ($(tal[i]).find('table').prev("textarea").length > 0) {
                    if ($(tal[i]).find('table').prev("textarea").val() != "") {
                        arr.push($(tal[i]).find('table').prev("textarea"));
                    }
                }
                if ($(tal[i]).find('table').find("textarea").length > 0) {
                    if ($(tal[i]).find('table').find("textarea").val() != ""&&$(tal[i]).find('table').find("textarea").parent("td").children().length==1) {
                        arr.push($(tal[i]).find('table').find("textarea"));
                    }
                }
            }

            if (arr.length >= tal.length) {
                var arr2 = []
                for (var j = 0; j < arr.length; j++) {
                    if ($(arr[j]).parents("td")) {
                        if ($(arr[j]).parents("td").find("textarea").length > 0) {
                            if ($(arr[j]).parents("td").find("textarea").val() == "") {
                                arr2.push("1");
                            }
                        }
                    }
                }
            } else {
                $.layerMsg({content: '<fmt:message code="vote.th.pleaseFillInAllTheItemsAndVoteBeforeSubmitting" />', icon: 2});
                return false;
            }
            if (arr2.length > 0) {
                $.layerMsg({content: '<fmt:message code="vote.th.thereIsATextBoxThatHasNotBeenFilledIn" />', icon: 2});
                return false;
            }
            if(type==1){
               if(arr[0].length >$(this).attr('num')){
                   if (languageType == 'zh_CN') {
                       $.layerMsg({content: '父级最多选择' + $(this).attr('num') + '个', icon: 2})
                   } else if (languageType = 'zh_tw') {
                       $.layerMsg({content: '父級最多選擇' + $(this).attr('num') + '個', icon: 2})
                   } else if (languageType = 'en_US') {
                       $.layerMsg({content: 'You can select at most' + $(this).attr('num') + 'parent-level item', icon: 2})
                   }
                   return;
               }
                if(arr[0].length<$(this).attr('minnum')){
                    if (languageType == 'zh_CN') {
                        $.layerMsg({content: '父级最少选择' + $(this).attr('minnum') + '个', icon: 2})
                    } else if (languageType = 'zh_tw') {
                        $.layerMsg({content: '父級最少選擇' + $(this).attr('minnum') + '個', icon: 2})
                    } else if (languageType = 'en_US') {
                        $.layerMsg({content: 'Select at least' + $(this).attr('minnum') + 'parent-level item', icon: 2})
                    }
                    return;
                }

            }

            var userName = $('.anonymityName').val();
            if ($('.anonymity').val() == '<fmt:message code="global.lang.no" />' && userName == '') {
                $.layerMsg({content: '<fmt:message code="vote.th.pleaseFillInTheNameOfTheAnonymousVote" />', icon: 2})
                return false;
            } else if ($('.anonymity').val() == '<fmt:message code="global.lang.yes" />') {
                userName = '';
            }

            var data = {
                options: "",
                voteId: sId,
                voteCon: "",
                voteMsg: "",
                userName: userName
            }
            var voteCon = "";
            var voteMsg = "";
            var textarea1 = $('.voteReason1').length;
            var textarea2 = $('.voteReason2').length;

            if(textarea1>0){
                for(var i = 0;i<textarea1;i++){
                    voteMsg += $('.voteReason1').eq(i).attr('id')+','+$('.voteReason1').eq(i).val()+'|';
            }
            }
            if(textarea2>0) {
                for (var i = 0; i < textarea2; i++) {
                    voteCon += $('.voteReason2').eq(i).attr('id') + ',' + $('.voteReason2').eq(i).val() + '|';
                }
            }

            var id = "";
            $('[type="radio"]:checked').each(function () {
                if ($(this).attr('name') != 'anonymity') {
                    id += $(this).attr('id') + ",";
                }
            });
            $('[type="checkbox"]:checked').each(function () {
                id += $(this).attr('id') + ',';
            })

            data.options = id;
            data.voteCon = voteCon;
            data.voteMsg = voteMsg;
            if (data.options == "" && data.voteCon == "") {
                $.layerMsg({content: '<fmt:message code="hr.th.PleaseSelect" />！', icon: 1});
            } else {
                $.ajax({
                    type: 'post',
                    url: '/vote/manage/updateVoteTitle',
                    dataType: 'json',
                    data: {
                        voteId: sId
                    },
                    success: function (res) {
                    }
                })
                $.ajax({
                    type: 'post',
                    url: '/vote/manage/addVoteTitle',
                    dataType: 'json',
                    data: data,
                    success: function (res) {
                        if (res.flag) {
                            $.layerMsg({content: '<fmt:message code="vote.th.VoteSuccess" />！', icon: 1}, function () {
                                window.close();
                                window.opener.location.href = window.opener.location.href;
                            });

                        } else {
                            $.layerMsg({content: res.msg, icon: 2});
                        }
                    }
                });
            }

        })

    })

    function getCookie(name) {
        var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
        if(arr=document.cookie.match(reg))
            return unescape(arr[2]);
        else
            return null;
    }
</script>
</html>
