
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>防疫登记</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script src="/ui/js/qrcode.min.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.config.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>

</head>
<style>


    #box .layui-from {
        width: 100%;
    }
    .layui-table-page>div{
        float: right;
    }
    #box .layui-table {
        width: 90%;
        margin: 0 auto;
    }

    .asd {
        font-weight: bold;
        font-size: 18px;
        margin-left: 30px;
    }

    .evaluation span {
        font-weight: bold;
        font-size: 18px;
        margin-left: 55px;
    }

    /*#box th {*/
    /*    text-align: center;*/
    /*}*/

    /*#box tr {*/
    /*    height: 40px;*/
    /*}*/

    #box button {
        right: -14px;
        z-index: 999;
        top:77px
    }
    #btn{
        margin-right: 35px;
        position: absolute;
        right: 30px;
        z-index: 999;
        top:77px
    }
    #from {
        width: 100%;
        margin: 0 auto;
        padding-top: 20px;
    }

    #from .new {
        font-weight: bold;
        font-size: 18px;
        margin-left: 30px;
    }

    .people {
        width: 100%;
        overflow: hidden;
        margin-bottom: 15px;
    }

    .people1 {
        width: 44%;
        float: left;
        overflow: hidden;
    }

    .people2 {
        float: right;
        overflow: hidden;
        margin-right: 61px;
    }

    .tbtn {
        text-align: center;
    }

    .tbtn button {
        margin-bottom: 20px;
        width: 100px;
    }

    .annex {
        font-size: 14px;
        margin-left: 30px;
    }
    .layui-form-select{
        width: 200px!important;
        height: 35px!important;
    }
    @media print {.notprint{display: none;}}
    #test3 {
        margin-left: 68px;
    }

    .layui-form-label {
        width: 100px;
    }

    .layui-table-view .layui-form-checkbox[lay-skin=primary] i {
        margin-top: 5px;
    }

    .layui-form {
        margin-left: 10px;
        margin-top: 10px;
        display: block;
        margin-right: 10px;
    }

    .layui-table-cell laytable-cell-1-0-5 {
        width: 268px;
    }

    /*.layui-table-page{*/
    /*    width: 1054px;*/
    /*}*/
    .layui-laypage-btn{
        display: none;
    }
    .layui-box layui-laypage layui-laypage-default{
        margin-left: 1060px;
    }
    .thHeight1 td {
        height: 80px;
    }

    .thHeight2 td {
        height: 120px;
        letter-spacing: 7px;
    }

    .layui-form input[type=checkbox], .layui-form input[type=radio], .layui-form select {
    }

    .layui-form select {

    }

    .evaluation {
        width: 800px;
        padding-top: 10px;
    }

    tr {
        text-align: center;
    }

    td {
        text-align: center;
    }

    #asd {
        width: 10px;
    }

    .layui-table td, .layui-table th {
        padding: 10px 9px;
    }

    .layui-form-checkbox {
        display: none;
    }

    .layui-table-view .layui-table td, .layui-table-view .layui-table th {
        text-align: center;
    }

    .layui-table-tool {
        display: none;
    }
    .layui-input{
        width: 200px;
    }
    .box1 {
        overflow: hidden;
        margin-left: 55px;
        margin-bottom: 50px;
    }

    .top1 {
        width: 199px;
        height: 39px;
        background-color: rgb(204 204 204);
        display: block;
        font-weight: bold;
        font-size: 18px;
        float: left;
        text-align: center;
        line-height: 39px;
        border: 1px solid rgba(121, 121, 121, 1);
    }

    .top2 {
        width: 228px;
        height: 39px;
        background-color: rgba(121, 121, 121, 1);
        display: block;
        font-weight: bold;
        font-size: 18px;
        float: left;
        text-align: center;
        line-height: 39px;
    }

    #meeting {
        width: 84px;
    }

    #textarea {
        width: 73%;
        height: 100px;
    }

    #party {
        float: right;
        position: absolute;
        left: 1000px;
        top: 75px;
    }

    #year {
        float: right;
        position: absolute;
        left: 1320px;
        top: 75px;
    }
    .layui-tab-content{
        margin-top: 20px;
    }
    .laytable-cell-1-0-6{
        maxWidth: 220px;

    }
    .niuma{
        width: 1000px;
        position: relative;
    }
</style>
<body>
<div style="margin-top: 20px">
   <div style="
    height: 45px;
    line-height: 45px;
    font-size: 22px;
    margin-left: 50px;
    color: #494d59;">
       <img src="/ui/img/zkim/category.png">
       防疫登记</div>
       <form class="layui-form" action="">
        <div style="position: relative;line-height: 60px;">
            <div>
                <div class="layui-inline">
                    <label class="layui-form-label">姓名</label>
                    <div class="layui-input-inline">
                        <input  style="width: 200px" id="name" name="name" class="layui-input" type="text">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label" >审批状态</label>
                    <div class="layui-input-inline"  style="display: flex">
                        <select id="state" name="state" class="State" lay-verify="State" lay-filter="State">
                            <option value="">请选择</option>
                            <option value="2">待审批</option>
                            <option value="1">通过</option>
                            <option value="0">不通过</option>
                        </select>
                    </div>
                </div>
                    <div class="layui-inline">
                        <label class="layui-form-label" >地点</label>
                        <div class="layui-input-inline"  style="display: flex">
                            <select id="visitLocation" name="visitLocation" class="visitLocation" lay-verify="visitLocation" lay-filter="visitLocation">
                                <option value="">请选择</option>
                            </select>
                            <div align="center">
                                <button type="button" style="margin-left: 10px" class="layui-btn layui-btn-normal layui-btn-radius" onclick="creatCode()">生成二维码</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-inline" >
                    <label class="layui-form-label">单位</label>
                    <div class="layui-input-inline">
                        <input  style="width: 200px" id="company" name="company" class="layui-input" type="text">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">手机号</label>
                    <div class="layui-input-inline">
                        <input  style="width: 200px" id="mobbleNo" name="mobbleNo" class="layui-input" type="text">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">计划到访时间</label>
                    <div class="layui-input-inline">
                        <input  style="width: 200px" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" id="visitTime" name="visitTime" class="layui-input" type="text">
                    </div>
                </div>
                <button type="button" class="layui-btn layui-btn-sm" id="search1" lay-event="search1" style="height: 30px;line-height: 30px;">查询</button>
            <button type="button" class="layui-btn layui-btn-sm" id="export" lay-event="export" style="height: 30px;line-height: 30px;">导出</button>
            </div>
    </form>
    <table class="layui-hide" id="test1" lay-filter="test1"></table>
</div>
<script id="barDemos" type="text/html">
    <div class="long">
        {{#  if(d.state == '2'  ||  d.state == ''){ }}
        <a id="detail2" lay-event="detail2" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">通过</a>
        <a id="detail3" lay-event="detail3" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">不通过</a>
        <a id="detail1" lay-event="detail1" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">删除</a>
        {{#  }else if(d.state == '1'){ }}
        <a id="detail1" lay-event="detail1" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">删除</a>
        {{#  }else if(d.state == '0'){ }}
        <a id="detail1" lay-event="detail1" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">删除</a>
        {{#  } }}
    </div>

</script>

</body>
<script>
        var address1;
    $('#export').click(function () {
        var address = $("#visitLocation").val()
        var name1 = $("#name").val()
        var company1 = $("#company").val()
        var mobbleNo1 = $("#mobbleNo").val()
        var visitTime1 = $("#visitTime").val()
        var state1 = $("#state").val()
        window.location.href = '/Antiepidemic/export?name='+name1+'&company='+company1+'&mobbleNo='+mobbleNo1+'&visitTime='+visitTime1+'&state='+state1+'&visitLocation='+address
    })

    layui.use(['layer'], function () {
        var layer = layui.layer
    });

    //预览等弹出框
        function creatCode() {
            if ($("#visitLocation").val()==''||$("#visitLocation").val()==undefined){
                layer.msg('请选择地点！',{icon:0});
                return false;
            }
            var url = '';
            var codeNo1 = $("#visitLocation").val()
            var codeOrder1 = $("#visitLocation").val()
            var address1= $("#visitLocation").find("option:selected").text()
            var address2=decodeURI(address1);
            layer.open({
                type: 1,
                title: "生成二维码",//标题
                area: ['100%', '100%'],
                offset:'0px',
                content: '<div id="code">\n' +
                    '        <center> <div id="qrcode"  style="margin-top: 100px"></div></center>\n' +
                    '    </div><center><strong><p style="margin-top: 30px;font-size: 30px">'+address1+'</p></strong></center>',
                btn:['<i class="layui-icon" style="margin-right: 10px;">&#xe609</i>下载图片','打印','取消'],
                //绑定第一个按钮的点击事件
                btn1: function(index) {
                    var img=$('#qrcode img')                       // 获取要下载的图片
                    var url = img[0].src;                            // 获取图片地址
                    var a = document.createElement('a');          // 创建一个a节点插入的document
                    var event = new MouseEvent('click')           // 模拟鼠标click点击事件
                    a.download = '二维码'                      // 设置a节点的download属性值
                    a.href = url;                                 // 将图片的src赋值给a节点的href
                    a.dispatchEvent(event)
                },
                btn2: function(index) {
                    window.open('/Antiepidemic/QRcode?codeOrder1='+codeOrder1+'&address2='+address2)
                }
            });
            // 设置要生成二维码的链接
            new QRCode(document.getElementById("qrcode"), {
                text: location.origin+'/Antiepidemic/antiepidemicH5?codeNo='+codeNo1,
                width: 300,
                height: 300
            });
        }
    layui.use(['form', 'table', 'element', 'layedit','eleTree'], function () {
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var layedit = layui.layedit
        var eleTree = layui.eleTree;
        form.render()
        $.ajax({
            url:'/code/getCode?parentNo=VISIT_LOCATION',
            type:'post',
            dataType:'json',
            data:{
            },
            success:function(res){
                var arr=[];
                var str
                for(var i=0;i<res.obj.length;i++){
                    str+='<option  value="'+res.obj[i].codeNo+'">'+res.obj[i].codeName+'</option>'
                }
                $('select[name="visitLocation"]').append(str);
                form.render('select');
            }
        })
        $('#search1').click(function () {
            var visitLocation = $("#visitLocation").val()
            var name = $("#name").val()
            var company = $("#company").val()
            var mobbleNo = $("#mobbleNo").val()
            var time = $("#visitTime").val()
            var state = $("#state").val()
            table.render({
                elem: '#test1'
                ,cellMinWidth:'100'
                , url:'/Antiepidemic/selectAll?name='+name+'&company='+company+'&mobbleNo='+mobbleNo+'&time='+time+'&state='+state+'&pageSize='+'10'+'&useflag='+true+'&visitLocation='+visitLocation
                ,cols:[[
                    {field: 'antiId',width:'80', title: '流水号',  }
                    , {field: 'registerTime',width:'180',title: '登记时间', }
                    , {field: 'name', title: '姓名',}
                    , {field: 'company', title: '单位',}
                    , {field: 'post', title: '岗位职务',}
                    , {field: 'mobbleNo',width:'130', title: '手机号', }
                    , {field: 'idNumber',width:'190', title: '身份证号', }
                    , {field: 'visitLocationName', title: '访问地点', }
                    , {field: 'visitTime', width:'190',title: '计划到访时间', }
                    , {field: 'lsolation', width:'130',title: '访问前隔离情况', }
                    , {field: 'trip',width:'140', title: '14天内详细行程', }
                    , {field: 'approverComment',width:'300', title: '附件',  templet: function (d) {
                            var strr = ''
                            var object=d
                            if(d.attUrlHealth==undefined){
                                return ''
                            }else{
                                for(var i=0;i<object.attUrlHealth.length;i++){
                                    var str1 = ""
                                    if( object.attUrlHealth[i].attUrl != undefined ){
                                        var fileExtension=object.attUrlHealth[i].attachName.substring(object.attUrlHealth[i].attachName.lastIndexOf(".")+1,object.attUrlHealth[i].attachName.length);//截取附件文件后缀
                                        var attName = encodeURI(object.attUrlHealth[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                        var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                        var deUrl = object.attUrlHealth[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+object.attUrlHealth[i].size;
                                        str1 = '' +
                                            '<div class="dech" deurl="' +deUrl + '">' +
                                            '<a href="/download?' + object.attUrlHealth[i].attUrl + '" name="'+object.attUrlHealth[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                            '<img src="/img/attachment_icon.png">健康码</a>' +
                                            '<input type="hidden" class="inHidden" value="' + object.attUrlHealth[i].aid + '@' + object.attUrlHealth[i].ym + '_' + object.attUrlHealth[i].attachId +',">' +
                                            '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                            '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                            '<a style="padding-left: 5px" href="/download?' + object.attUrlHealth[i].attUrl + '">' +
                                            '<img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">下载</a>\n' +
                                            '</div>' +
                                            '</div>'
                                    }else{
                                        str1 = '';
                                    }
                                    strr += str1;
                                }
                                for(var i=0;i<object.attUrlNuclein.length;i++){
                                    var str1 = ""
                                    if( object.attUrlNuclein[i].attUrl != undefined ){
                                        var fileExtension=object.attUrlNuclein[i].attachName.substring(object.attUrlNuclein[i].attachName.lastIndexOf(".")+1,object.attUrlNuclein[i].attachName.length);//截取附件文件后缀
                                        var attName = encodeURI(object.attUrlNuclein[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                        var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                        var deUrl = object.attUrlNuclein[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+object.attUrlNuclein[i].size;
                                        str1 = '' +
                                            '<div class="dech" deurl="' +deUrl + '">' +
                                            '<a href="/download?' + object.attUrlNuclein[i].attUrl + '" name="'+object.attUrlNuclein[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                            '<img src="/img/attachment_icon.png">核酸记录</a>' +
                                            '<input type="hidden" class="inHidden" value="' + object.attUrlNuclein[i].aid + '@' + object.attUrlNuclein[i].ym + '_' + object.attUrlNuclein[i].attachId +',">' +
                                            '<a  fileExtension="'+fileExtension+'" onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                            '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                            '<a style="padding-left: 5px" href="/download?' + object.attUrlNuclein[i].attUrl + '">' +
                                            '<img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">下载</a>\n' +
                                            '</div>' +
                                            '</div>'
                                    }else{
                                        str1 = '';
                                    }
                                    strr += str1;
                                }
                                for(var i=0;i<object.attUrlTouch.length;i++){
                                    var str1 = ""
                                    if( object.attUrlTouch[i].attUrl != undefined ){
                                        var fileExtension=object.attUrlTouch[i].attachName.substring(object.attUrlTouch[i].attachName.lastIndexOf(".")+1,object.attUrlTouch[i].attachName.length);//截取附件文件后缀
                                        var attName = encodeURI(object.attUrlTouch[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                        var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                        var deUrl = object.attUrlTouch[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+object.attUrlTouch[i].size;
                                        str1 = '' +
                                            '<div class="dech" deurl="' +deUrl+ '">' +
                                            '<a href="/download?' + object.attUrlTouch[i].attUrl + '" name="'+object.attUrlTouch[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                            '<img src="/img/attachment_icon.png">同行密接自查</a>' +
                                            '<input type="hidden" class="inHidden" value="' + object.attUrlTouch[i].aid + '@' + object.attUrlTouch[i].ym + '_' + object.attUrlTouch[i].attachId +',">' +
                                            '<a  fileExtension="'+fileExtension+'" onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                            '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                            '<a style="padding-left: 5px" href="/download?' + object.attUrlTouch[i].attUrl + '">' +
                                            '<img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">下载</a>\n' +
                                            '</div>' +
                                            '</div>'
                                    }else{
                                        str1 = '';
                                    }
                                    strr += str1;
                                }
                                for(var i=0;i<object.attUrlTravel.length;i++){
                                    var str1 = ""
                                    if( object.attUrlTravel[i].attUrl != undefined ){
                                        var fileExtension=object.attUrlTravel[i].attachName.substring(object.attUrlTravel[i].attachName.lastIndexOf(".")+1,object.attUrlTravel[i].attachName.length);//截取附件文件后缀
                                        var attName = encodeURI(object.attUrlTravel[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                        var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                        var deUrl = object.attUrlTravel[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+object.attUrlTravel[i].size;
                                        str1 = '' +
                                            '<div class="dech" deurl="' +deUrl+ '">' +
                                            '<a href="/download?' + object.attUrlTravel[i].attUrl + '" name="'+object.attUrlTravel[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                            '<img src="/img/attachment_icon.png">行程码</a>' +
                                            '<input type="hidden" class="inHidden" value="' + object.attUrlTravel[i].aid + '@' + object.attUrlTravel[i].ym + '_' + object.attUrlTravel[i].attachId +',">' +
                                            '<a  fileExtension="'+fileExtension+'" onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                            '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                            '<a style="padding-left: 5px" href="/download?' + object.attUrlTravel[i].attUrl + '">' +
                                            '<img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">下载</a>\n' +
                                            '</div>' +
                                            '</div>'
                                    }else{
                                        str1 = '';
                                    }
                                    strr += str1;
                                }
                                for(var i=0;i<object.attUrlVaccination.length;i++){
                                    var str1 = ""
                                    if( object.attUrlVaccination[i].attUrl != undefined ){
                                        var fileExtension=object.attUrlVaccination[i].attachName.substring(object.attUrlVaccination[i].attachName.lastIndexOf(".")+1,object.attUrlVaccination[i].attachName.length);//截取附件文件后缀
                                        var attName = encodeURI(object.attUrlVaccination[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                        var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                        var deUrl = object.attUrlVaccination[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+object.attUrlVaccination[i].size;
                                        str1 = '' +
                                            '<div class="dech" deurl="' +deUrl + '">' +
                                            '<a href="/download?' + object.attUrlVaccination[i].attUrl + '" name="'+object.attUrlVaccination[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                            '<img src="/img/attachment_icon.png">疫苗接种</a>' +
                                            '<input type="hidden" class="inHidden" value="' + object.attUrlVaccination[i].aid + '@' + object.attUrlVaccination[i].ym + '_' + object.attUrlVaccination[i].attachId +',">' +
                                            '<a  fileExtension="'+fileExtension+'" onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                            '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                            '<a style="padding-left: 5px" href="/download?' + object.attUrlVaccination[i].attUrl + '">' +
                                            '<img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">下载</a>\n' +
                                            '</div>' +
                                            '</div>'
                                    }else{
                                        str1 = '';
                                    }
                                    strr += str1;
                                }
                                return strr
                            }
                        }}
                    , {field: 'promiseStateName',width:'150', title: '防疫隔离承诺书', }
                    , {field: 'state', title: '审批状态', templet: function (d) {
                            if(d.state=='0'){
                                return '不通过'
                            }else if(d.state=='1'){
                                return '通过'
                            }else if (d.state=='2'){
                                return '待审批'
                            }
                        } }
                    , {field: '', title: '操作',width:'10%', toolbar: '#barDemos',}

                ]],
                page:true,
                limit:10
                ,parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code":0,
                        "count":res.totleNum,
                        "data": res.obj //解析数据列表
                    };
                }
            });
        });
        table.render({
            elem: '#test1'
            , url: '/Antiepidemic/selectAll?FpageSize='+'10'+'&useflag='+true
            ,cellMinWidth:'100'
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                , layEvent: 'LAYTABLE_TIPS'
                , icon: 'layui-icon-tips'
            }]
            , title: '用户数据表'
            , cols: [[
                {field: 'antiId',width:'80', title: '流水号',  }
                , {field: 'registerTime',width:'180',title: '登记时间', }
                , {field: 'name', title: '姓名',}
                , {field: 'company', title: '单位',}
                , {field: 'post', title: '岗位职务',}
                , {field: 'mobbleNo',width:'130', title: '手机号', }
                , {field: 'idNumber',width:'190', title: '身份证号', }
                , {field: 'visitLocationName', title: '访问地点', }
                , {field: 'visitTime', width:'190',title: '计划到访时间', }
                , {field: 'lsolation', width:'130',title: '访问前隔离情况', }
                , {field: 'trip',width:'140', title: '14天内详细行程', }
                , {field: 'approverComment',width:'300', title: '附件',  templet: function (d) {
                        var strr = ''
                        var object=d
                        if(d.attUrlHealth==undefined){
                            return ''
                        }else{
                            for(var i=0;i<object.attUrlHealth.length;i++){
                                var str1 = ""
                                if( object.attUrlHealth[i].attUrl != undefined ){
                                    var fileExtension=object.attUrlHealth[i].attachName.substring(object.attUrlHealth[i].attachName.lastIndexOf(".")+1,object.attUrlHealth[i].attachName.length);//截取附件文件后缀
                                    var attName = encodeURI(object.attUrlHealth[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                    var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                    var deUrl = object.attUrlHealth[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+object.attUrlHealth[i].size;
                                    str1 = '' +
                                        '<div class="dech" deurl="' +deUrl + '">' +
                                        '<a href="/download?' + object.attUrlHealth[i].attUrl + '" name="'+object.attUrlHealth[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                        '<img src="/img/attachment_icon.png">健康码</a>' +
                                        '<input type="hidden" class="inHidden" value="' + object.attUrlHealth[i].aid + '@' + object.attUrlHealth[i].ym + '_' + object.attUrlHealth[i].attachId +',">' +
                                        '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                        '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                        '<a style="padding-left: 5px" href="/download?' + object.attUrlHealth[i].attUrl + '">' +
                                        '<img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">下载</a>\n' +
                                        '</div>' +
                                        '</div>'
                                }else{
                                    str1 = '';
                                }
                                strr += str1;
                            }
                            for(var i=0;i<object.attUrlNuclein.length;i++){
                                var str1 = ""
                                if( object.attUrlNuclein[i].attUrl != undefined ){
                                    var fileExtension=object.attUrlNuclein[i].attachName.substring(object.attUrlNuclein[i].attachName.lastIndexOf(".")+1,object.attUrlNuclein[i].attachName.length);//截取附件文件后缀
                                    var attName = encodeURI(object.attUrlNuclein[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                    var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                    var deUrl = object.attUrlNuclein[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+object.attUrlNuclein[i].size;
                                    str1 = '' +
                                        '<div class="dech" deurl="' +deUrl + '">' +
                                        '<a href="/download?' + object.attUrlNuclein[i].attUrl + '" name="'+object.attUrlNuclein[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                        '<img src="/img/attachment_icon.png">核酸记录</a>' +
                                        '<input type="hidden" class="inHidden" value="' + object.attUrlNuclein[i].aid + '@' + object.attUrlNuclein[i].ym + '_' + object.attUrlNuclein[i].attachId +',">' +
                                        '<a  fileExtension="'+fileExtension+'" onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                        '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                        '<a style="padding-left: 5px" href="/download?' + object.attUrlNuclein[i].attUrl + '">' +
                                        '<img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">下载</a>\n' +
                                        '</div>' +
                                        '</div>'
                                }else{
                                    str1 = '';
                                }
                                strr += str1;
                            }
                            for(var i=0;i<object.attUrlTouch.length;i++){
                                var str1 = ""
                                if( object.attUrlTouch[i].attUrl != undefined ){
                                    var fileExtension=object.attUrlTouch[i].attachName.substring(object.attUrlTouch[i].attachName.lastIndexOf(".")+1,object.attUrlTouch[i].attachName.length);//截取附件文件后缀
                                    var attName = encodeURI(object.attUrlTouch[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                    var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                    var deUrl = object.attUrlTouch[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+object.attUrlTouch[i].size;
                                    str1 = '' +
                                        '<div class="dech" deurl="' +deUrl+ '">' +
                                        '<a href="/download?' + object.attUrlTouch[i].attUrl + '" name="'+object.attUrlTouch[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                        '<img src="/img/attachment_icon.png">同行密接自查</a>' +
                                        '<input type="hidden" class="inHidden" value="' + object.attUrlTouch[i].aid + '@' + object.attUrlTouch[i].ym + '_' + object.attUrlTouch[i].attachId +',">' +
                                        '<a  fileExtension="'+fileExtension+'" onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                        '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                        '<a style="padding-left: 5px" href="/download?' + object.attUrlTouch[i].attUrl + '">' +
                                        '<img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">下载</a>\n' +
                                        '</div>' +
                                        '</div>'
                                }else{
                                    str1 = '';
                                }
                                strr += str1;
                            }
                            for(var i=0;i<object.attUrlTravel.length;i++){
                                var str1 = ""
                                if( object.attUrlTravel[i].attUrl != undefined ){
                                    var fileExtension=object.attUrlTravel[i].attachName.substring(object.attUrlTravel[i].attachName.lastIndexOf(".")+1,object.attUrlTravel[i].attachName.length);//截取附件文件后缀
                                    var attName = encodeURI(object.attUrlTravel[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                    var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                    var deUrl = object.attUrlTravel[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+object.attUrlTravel[i].size;
                                    str1 = '' +
                                        '<div class="dech" deurl="' +deUrl+ '">' +
                                        '<a href="/download?' + object.attUrlTravel[i].attUrl + '" name="'+object.attUrlTravel[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                        '<img src="/img/attachment_icon.png">行程码</a>' +
                                        '<input type="hidden" class="inHidden" value="' + object.attUrlTravel[i].aid + '@' + object.attUrlTravel[i].ym + '_' + object.attUrlTravel[i].attachId +',">' +
                                        '<a  fileExtension="'+fileExtension+'" onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                        '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                        '<a style="padding-left: 5px" href="/download?' + object.attUrlTravel[i].attUrl + '">' +
                                        '<img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">下载</a>\n' +
                                        '</div>' +
                                        '</div>'
                                }else{
                                    str1 = '';
                                }
                                strr += str1;
                            }
                            for(var i=0;i<object.attUrlVaccination.length;i++){
                                var str1 = ""
                                if( object.attUrlVaccination[i].attUrl != undefined ){
                                    var fileExtension=object.attUrlVaccination[i].attachName.substring(object.attUrlVaccination[i].attachName.lastIndexOf(".")+1,object.attUrlVaccination[i].attachName.length);//截取附件文件后缀
                                    var attName = encodeURI(object.attUrlVaccination[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                    var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                    var deUrl = object.attUrlVaccination[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+object.attUrlVaccination[i].size;
                                    str1 = '' +
                                        '<div class="dech" deurl="' +deUrl + '">' +
                                        '<a href="/download?' + object.attUrlVaccination[i].attUrl + '" name="'+object.attUrlVaccination[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                        '<img src="/img/attachment_icon.png">疫苗接种</a>' +
                                        '<input type="hidden" class="inHidden" value="' + object.attUrlVaccination[i].aid + '@' + object.attUrlVaccination[i].ym + '_' + object.attUrlVaccination[i].attachId +',">' +
                                        '<a  fileExtension="'+fileExtension+'" onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                        '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                        '<a style="padding-left: 5px" href="/download?' + object.attUrlVaccination[i].attUrl + '">' +
                                        '<img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">下载</a>\n' +
                                        '</div>' +
                                        '</div>'
                                }else{
                                    str1 = '';
                                }
                                strr += str1;
                            }
                            return strr
                        }
                    }}
                , {field: 'promiseStateName',width:'150', title: '防疫隔离承诺书', }
                , {field: 'state', title: '审批状态', templet: function (d) {
                        if(d.state=='0'){
                            return '不通过'
                        }else if(d.state=='1'){
                            return '通过'
                        }else if (d.state=='2'){
                            return '待审批'
                        }
                    } }
                , {field: '', title: '操作',width:'10%', toolbar: '#barDemos',}
            ]]
            , parseData: function (res) { //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.totleNum, //解析数据长度
                    "data": res.obj, //解析数据列表
                };
            }
            , page: true
        })




        $(document).on("click","#submit",function(){
            layer.close('page')
        })
        table.on('tool(test1)', function (obj) {
            data = obj.data;
            var data = obj.data;
            var dataObj = obj.data;
            var layEvent = obj.event;
            if (obj.event === 'detail1') {
                layer.confirm('确定删除该条数据吗？', {
                    btn: ['确定','取消'], //按钮
                    title:"删除"
                }, function(){
                    $.ajax({
                        type: 'post',
                        url: '/Antiepidemic/deleteById',
                        dataType: 'json',
                        data: {
                            antiId:data.antiId
                        },
                        success: function (json) {
                            if(json.flag){
                                layer.closeAll();
                                $.layerMsg({content: '删除成功！', icon: 1}, function () {
                                    location.reload();
                                })
                            }
                        }
                    })
                })
            }else if(obj.event === 'detail2'){
                layer.confirm('确定同意审批该条数据吗？', {
                    btn: ['确定','取消'], //按钮
                    title:"通过审批"
                }, function() {
                    $.ajax({
                        type: 'post',
                        url: '/Antiepidemic/update',
                        dataType: 'json',
                        data: {
                            state: '1',
                            antiId: data.antiId
                        },
                        success: function (json) {
                            data.approveStatus = '同意'
                            $.layerMsg({content: '通过成功！', icon: 1}, function () {
                                layer.closeAll();
                                location.reload();
                            })
                        }
                    })
                })

            }else if(obj.event === 'detail3'){
                layer.confirm('确定不通过该条数据吗？', {
                    btn: ['确定','取消'], //按钮
                    title:"不通过"
                }, function() {
                    $.ajax({
                        type: 'post',
                        url: '/Antiepidemic/update',
                        dataType: 'json',
                        data: {
                            state: '0',
                            antiId: data.antiId
                        },
                        success: function (json) {
                            data.approveStatus = '不同意'
                            $.layerMsg({content: '确定成功！', icon: 1}, function () {
                                layer.closeAll();
                                location.reload();
                            })
                        }
                    })
                })

            }

        })


    });


</script>
</html>


