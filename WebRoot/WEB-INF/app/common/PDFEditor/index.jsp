<%--
  Created by IntelliJ IDEA.
  User: yx
  Date: 2021/1/5
  Time: 11:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>PDF在线编辑</title>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js" ></script>
    <script type="text/javascript" src="/js/base/base.js" ></script>
    <script src="/lib/layer/layer.js?20201106"></script>

    <style>
        *{
            padding: 0;
            margin: 0;
        }
        body, html {
            width: 100%;
            height: 100%;
            overflow: hidden;
            font-size: 16px;
            font-family: "Microsoft yahei";
            margin: 0;
            color: #333333;
        }
        .control{
            height: 35px;
            background-color: #2b579a;
        }
        .controlBox{
            list-style: none;
        }
        .controlBox li{
            color: #fff;
            font-size: 12px;
            float: left;
            padding: 0px 23px;
            height: 35px;
            line-height: 35px;
            box-sizing: border-box;

            cursor: pointer;
        }
        .controlBox li:hover{
            background-color: #124078;
        }
        .wrap {
            width: 100%;
            height: 100%;
            float: left;
            clear: both;
        }
        .left_side, .right_side {
            float: left;
        }
        .left_side {
            visibility: visible;
            width: 14%;
            height: 100%;
            box-shadow: 2px 6px 12px #888888;
            background-color: #2b579a;
        }
        .right_side {
            width: 86%;
            height: 100%;
        }
        .menu_ul {
            padding: 0;
            margin: 0;
            color: #fff;
        }
        .menu_ul_li {
            list-style: none;
            cursor: pointer;
            display: block;
        }
        .fileMenu, .signMenu {
            display: block;
            padding: 10px 0px 15px 20px;
        }
        .menu_ul_li ul {
            list-style: none;
            padding-left: 0px;
        }
        .menu_ul_li ul li {
            height: 18px;
            list-style: none;
            padding: 10px 0px 15px 40px;
        }
        .menu_ul_li ul li:hover{
            background-color: #124078;
        }
        .menu_ul_li ul li img {
            vertical-align: middle;
            margin-left: 22px;
            visibility: hidden;
        }
        .menu_ul_li ul li span {
            font-size: 14px;
            line-height: 16px;
            vertical-align: middle;
        }
    </style>
</head>
<body>
<input type="hidden" id="tabid" value="">
<input type="hidden" id="attachId" value="">
<input type="hidden" id="module" value="">
<input type="hidden" id="xAttachId" value="">
<input type="hidden" id="signId" value="">
<input type="hidden" id="password" value="">
<div class="control" style="display: none">
    <ul class="controlBox">
        <li onclick="makeSign()">盖章</li>
        <li>手写</li>
        <li>批注</li>
    </ul>
</div>
<div id="wrap" class="wrap">
    <div class="left_side">
        <ul class="menu_ul">
            <li class="menu_ul_li PDF_menu_li" style="display: block;">
                <span class="signMenu">PDF版式文件</span>
                <ul class="signUl">
                    <li class="oper oper3006" onclick="ToWord($(this))" wordatturl="" style="display: none;"><span>切换为Word编辑</span>
                    </li>
                    <li class="oper oper3008" style="display: none;" onclick="downPdfOrWord()"><span>PDF正文下载</span></li>
                    <li class="oper oper3009" style="display: none;" onclick="deletePdf()"><span>删除PDF</span></li><%--删除PDF--%>
                    <li class="oper oper3010" style="display: none;" onclick="makeSign()"><span>盖章</span>
                    </li>
                </ul>
                <ul class="signUl">

                </ul>
            </li>
        </ul>
    </div>
    <div class="right_side grid-content bg-purple" style="height: 100%">
        <iframe  width="100%" height="100%" id="the-canvas" scrolling="no" style="border:1px solid black;width:100%;"></iframe>
    </div>
</div>

<script>
    var signFlag = false;
    function autodivheight(){
        var winHeight=0;
        if (window.innerHeight)
            winHeight = window.innerHeight;
        else if ((document.body) && (document.body.clientHeight))
            winHeight = document.body.clientHeight;
        if (document.documentElement && document.documentElement.clientHeight)
            winHeight = document.documentElement.clientHeight;
        winWidth = document.documentElement.clientWidth;
        console.log(winHeight)
        //document.getElementById("the-canvas").style.height= winHeight - 36 +"px";
        document.getElementById("the-canvas").style.height= winHeight + "px";
    };
    function ToWord(e){
        if(document.referrer.indexOf('&initwordType=1') == -1){
            var url = document.referrer+'&initwordType=1';
        }else{
            var url = document.referrer;
        }
        location.href = url;
    }
    function downPdfOrWord(){
        window.open("/download?"+location.search.split('?')[1]);
    }
    function test(){
        // if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
        //     var url ='/lib/pdfjs/web/viewer.html?type=sign&file='+encodeURIComponent(pdfurl)+'&version=20210315.1';
        // } else if (/(Android)/i.test(navigator.userAgent)) {
        //     var url ='/lib/pdfjs/web/viewer.html?type=sign&file='+encodeURIComponent(pdfurl)+'&version=20210315.1';
        // } else{
        //     var url ='/xs'+location.search+'&ATTACHMENT_NAME=';
        // }
        var url ='/xs'+location.search+'&ATTACHMENT_NAME=';
        var pdfurl = location.origin+'/download'+location.search;
        if(documentEditPrivDetail.indexOf('3009') > -1) {
            signFlag = true;
            url ='/lib/pdfjs/web/viewer.html?type=sign&file='+encodeURIComponent(pdfurl)+'&version=20220328.2';
        }
        var userAgent = navigator.userAgent;
        if(userAgent.indexOf('QtWebEngine') > -1){
            url ='/lib/pdfjs/web/viewer.html?type=sign&file='+encodeURIComponent(pdfurl)+'&version=20220328.2';
        }
        $('#the-canvas').attr('src', url);
    }
    function makeSign() {
        if(!signFlag){
            var pdfurl = location.origin+'/download'+location.search;
            var url ='/lib/pdfjs/web/viewer.html?type=sign&file='+encodeURIComponent(pdfurl)+'&version=20220328.2';
            $('#the-canvas').attr('src',url);
            signFlag = true;
        }
        $.popWindow('/common/PDFselectSeal');
    }
    function addSealImg(src,xAttachId,signId) {
        $('#xAttachId').val(xAttachId);
        $('#signId').val(signId);
        var src = src;
        var signId = signId;
        layer.open({
            area: ['auto', '200px'],
            maxWidth:400,
            closeBtn: 0,
            title:'输入密码',
            content: '<input type="password" placeholder="请输入印章密码" id="SealPaseWord" style="width: 70%;height: 30px;border-radius: 4px;background: #f8f8f8;border: 1px solid #d4cdcd!important;font-size: 14px;text-indent: 5px;margin-top: 10px;">',
            btn:['确定', '取消'],
            success: function(layero,index){

            },
            yes:function(index, layero){
                var psw = $('#SealPaseWord').val();
                $('#password').val(psw);
                $.ajax({
                    type: 'get',
                    url: '/xsign/isPwdTrue',
                    dataType: 'json',
                    data:{
                        signId:signId,
                        password:psw
                    },
                    success: function (res) {
                        if(res.object){
                            $("#the-canvas")[0].contentWindow.sign(src);
                            layer.closeAll();
                        }else{
                            $('#SealPaseWord').val('');
                            alert('密码错误！')
                        }

                    }
                });

            }
        });

    }
    function GetQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        re = new RegExp("amp;", "g"); //定义正则表达式
        var r = window.location.search.substr(1).replace(re, "").match(reg);  //获取url中"?"符后的字符串并正则匹配
        var context = "";
        if (r != null)
            context = r[2];
        reg = null;
        r = null;
        return context == null || context == "" || context == "undefined" ? "" : context;
    }
    /**
     * 删除PDF
     */
    function deletePdf() {
        layer.confirm('是否删除该PDF正文文件？', {
            btn: ['确定', '取消'] //按钮
        }, function () {
            $.get('/document/delPDF',{ runId: parent.runId },function (res) {
                if(res.flag){
                    $.layerMsg({content:'删除成功！', icon:1 },function(){
                        parent.$('.tabAB .active').trigger('click')
                    });
                }else{
                    $.layerMsg({content:'删除失败！', icon:2 },function(){

                    });
                }
            })
        }, function () {


        });
    }
    autodivheight();
    var tabId = $.GetRequest().tabId||'';
    var ATTACHMENT_ID = $.GetRequest().ATTACHMENT_ID||'';
    var MODULE = $.GetRequest().MODULE||'';
    $('#tabid').val(tabId);
    $('#attachId').val(ATTACHMENT_ID);
    $('#module').val(MODULE);
    var res = {};
    $(function(){
        $.ajax({
            url: "/document/selectDocById",
            type: "get",
            dataType: "json",
            data: {id: GetQueryString("tabId"), randomNum: Math.random()},
            async:false,
            success: function (data) {
                if (data.flag) {
                    res = data;
                }
            }
        })
        documentEditPrivDetail = parent.window.workForm.option.flowProcesses.documentEditPrivDetail;
        //判断如果是详情页面，只显示下载按钮
        if(parent.location.href.indexOf('workformPreView')>-1){
            $('.PDF_menu_li').show().siblings().hide();
            $('.oper3008').show().siblings().hide()
        }else{
            //如果是经办人，则只能下载
            if(GetQueryString("opflag")=='0'){
                if(documentEditPrivDetail.indexOf('3008') >-1){
                    $('.PDF_menu_li').show().siblings().hide();
                    $('.oper3008').show().siblings().hide()
                }else{
                    $('.PDF_menu_li').show().siblings().hide();
                    $('.oper3008').hide()
                }
            }else{
                if(documentEditPrivDetail.indexOf('3006') >-1){
                    $('.PDF_menu_li').show().siblings().hide();
                    if (res.object.wordAttUrl && res.object.wordAttUrl != '') {
                        $('.oper3006').attr('wordAtturl',res.object.wordAttUrl.split('&ATTACHMENT_NAME=')[0]+'&ATTACHMENT_NAME=').show();
                    } else {
                        $('.oper3006').hide()
                    }
                }
                //判断PDF正文下载是否显示
                if(documentEditPrivDetail.indexOf('3008') >-1){
                    $('.PDF_menu_li').show().siblings().hide();
                    $('.oper3008').show()
                }else{
                    $('.PDF_menu_li').show().siblings().hide();
                    $('.oper3008').hide()
                }
                //判断删除PDF是否显示
                if(documentEditPrivDetail.indexOf('3009') >-1){
                    $('.PDF_menu_li').show().siblings().hide();
                    $('.oper3009').show()
                }else{
                    $('.PDF_menu_li').show().siblings().hide();
                    $('.oper3009').hide()
                }

                //判断PDF正文盖章是否显示
                if(documentEditPrivDetail.indexOf('3010') >-1){
                    $('.PDF_menu_li').show().siblings().hide();
                    $('.oper3010').show()
                }else{
                    $('.PDF_menu_li').show().siblings().hide();
                    $('.oper3010').hide()
                }
            }

        }
        test();
    })
</script>
</body>
</html>
