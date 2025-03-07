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
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>人员评价</title>
    <%--<meta name="renderer" content="webkit">--%>
    <%--<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">--%>

    <%--<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">--%>
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta http-equiv="Content-Type" content="text/html;">
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" type="text/css" href="../../css/sys/userInfor.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/hr/index.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/sys/userInfor.js" type="text/javascript" charset="utf-8"></script>
    <%--<script src="../lib/laydate/laydate.js"></script>--%>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>

    <!-- word文本var data_器 -->
    <script src="/lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <style>
        html,body{
            height:100%;
        }
        .btn_{
            width:300px;display: block;
        }
        .leave_send{
            display: inline-block;
            float: left;
            width: 66px;
            height: 30px;
            margin-right: 0px;
            margin-top: 10px;
            margin-bottom: 20px;
            background: url(../../img/publish.png) no-repeat;
            padding-left: 47px;
            padding-top: 7px;
            cursor: pointer;
            font-size: 14px;
        }
        #downChild .dpetWhole0 .childdept{
            padding-left: 60px!important;
        }
        #downChild .dpetWhole0 ul .childdept{
            padding-left: 80px!important;
        }
        #downChild .dpetWhole0 ul ul li .childdept{
            padding-left: 95px!important;
        }
        .left {
            /*width: 21.5%;*/
            width: 17.5%;
            border-right: 1px solid #ccc;
            overflow-y: auto;
        }
        .rig {
            /*width: 78%;*/
            width: 82%;
            overflow-y: auto;
        }
        .colorDis{
            background-color: #e7e7e7;
        }
        table input{
            width: auto;
        }
        .allCondition{
            width: 1200px;
            margin-left: 20px;
        }
        .text_width{width:126px;}
        .loopData{
            font-size: 11pt;
        }



        table.TableBlock tr td:nth-child(2){
            width: 35%;
        }
        .bar {
            height: 18px;
            background: green;
        }
        .headli1_1 {
            padding: 0px 10px;
            display: inline-block;
            text-align: center;
        }
        .headli1_2 {
            width: 2px;
            margin-left: 10px;vertical-align: middle;

        }

        .span_td {
            display: inline-block;
            margin-top: 20px;
            width: 200px;
            text-align: right;
        }
        .inputTd{
            width: 300px;
            height: 30px;
            line-height: 30px;
        }

        .layui-table td, .layui-table th{
            padding: 8px 10px;
        }
        .layui-table-page{
            display: none;
        }
        .layui-rate{
            padding: 4px;
        }
        .import{
            color: red;
        }
        .layui-border-box {
            text-align: center;
        }
        .layui-layer-content{
            margin-top: 10px;
        }
        .layui-form-radio{
            margin: 6px 5px 0 0;
        }
    </style>
</head>
<body>
<div class="layui-form" style="background-color: #F2F2F2;">

    <div class="layui-form-item">
        <div class="layui-inline" style="margin-left: 10px;">
            <h2>人员评价</h2>
        </div>

        <div class="layui-inline" style="margin-top: 10px;">
            <label class="layui-form-label">姓名</label>
            <div class="layui-input-inline">
                <input type="text" name="xingming" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline" style="margin-top: 10px;">
            <button type="button" class="layui-btn layui-btn-sm" name="chaxun" lay-filter="demo1">查询</button>
        </div>
    </div>

</div>

<div class="cont" style="width: 100%;">
    <div class="left" style="background-color: #F5F7F8;">
        <div class="collect">
            <div id="incum" class="divUP">
                <div id="downChild" style="display:block;">
                    <div class="pickCompany"><span style="height:35px;line-height:35px;" class="childdept"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 10px;margin-left: 13px;margin-bottom: 4px;"><a href="javascript:void(0)" class="dynatree-title" title="" style="color: #000;"></a></span></div>
                </div>
            </div>
        </div>
    </div>

    <div class="rig">
        <div class="tishi" style="height: 100%;text-align: center;border: none;">
            <div style="width:100%;padding-top:20%;"><img style="margin-top: 2%;text-align: center;" src="/img/noData.png" alt=""></div>
            <h2 style="margin: auto;text-align: center;font-size: 20px;font-weight: normal;">请选择人员</h2>
        </div>
        <div class="table_personDetail" id="table_personDetail" style="display: none;">
            <div style="background-color: #F2F2F2;margin-left:10px;padding: 3px;position: relative">
                <span id="person" style="color:red;font-size: 25px;font-weight: bold">牛小牛</span><span style="font-size: 25px;font-weight: bold">历次评价</span>
                <button type="button" class="layui-btn" style="display: none;position: absolute;top: 0px;right: 0px;" id="addEv">添加评价</button>
            </div>
            <table id="demo" lay-filter="test"></table>

            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-xs" lay-event="detail">详情</a>
            </script>

        </div>

    </div>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
</script>
<script>
    var asd = ''
    var table,rate,form;
    var userId
    var table1
    var personnel
    layui.use(['table','form','rate'], function(){
        table = layui.table;
        form=layui.form
        rate = layui.rate;
    });

    /*人员接口*/
    function clickrenwu (id,me) {
        userId = $(me).attr('userId')
        if (userId == undefined){
            userId = id;
        }
        var arr = $.inArray(userId,personnel);
        if(arr == -1){
            $('#addEv').hide()  //不包含
        }else{
            $('#addEv').show()  //包含
        }
        var name=$(me).find('a').attr('title')
        if (name == undefined){
            name = me
        }
        $('.tishi').hide()
        $('#table_personDetail').show()
        $('#person').html(name)
        table1=table.render({
            elem: '#demo'
            ,url: '/hrEvaluate/queryHrEvaluates'//数据接口
            ,where: {userId:userId } //如果无需传递额外参数，可不加该参数
            ,method: 'post' //如果无需自定义HTTP类型，可不加该参数
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'id', title: '序号', width:'5%', fixed: '',templet: function(d){
                        return  d.LAY_INDEX
                    }}
                ,{field: 'userName', width:90,title: '被评价人',}
                ,{field: 'evLevel', width:100,title: '综合评价',templet: function(d){
                        if(d.evLevel==1) return  '<spam>优秀</span>'
                        if(d.evLevel==2) return  '<spam>一般</span>'
                        if(d.evLevel==3) return  '<spam>差</span>'
                    } }
                ,{field: 'evAttitude', title: '工作态度',minWidth:163,templet:function (d) {
                        return '<div id="evAttitude'+d.evId+'"></div>'
                    } }
                ,{field: 'evSkill', title: '工作技能',minWidth:163,templet:function (d) {
                        return '<div id="evSkill'+d.evId+'"></div>'}},
                {
                    field: 'attachmentName', title: '评价文件',align:'left', templet: function (d) {
                        if (d.attachmentList != undefined) {
                            // var attachmentList =  d.attachmentList
                            var data = d.attachmentList
                            var stra2 = '';
                            for (var i = 0; i < data.length; i++) {
                                var fileExtension = data[i].attachName.substring(data[i].attachName.lastIndexOf(".") + 1, data[i].attachName.length);//截取附件文件后缀
                                var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + data[i].size;
                                stra2 += '<div class="dech" deUrl="' + deUrl + '">' +
                                    '<a NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
                                    '<img  src="/img/attachment_icon.png"/>' + data[i].attachName + '</a>' +
                                    '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' +
                                    '<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px">' +
                                    '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                    '<a class="download" style="padding-left: 5px;" href="/download?' + encodeURI(deUrl) + '" >' +
                                    '<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
                                    '<input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +
                                    '</div>'
                                <%--str += '<div class="dech" deUrl="' + encodeURI(arrAttach[i].attUrl)+ '"><a href="/download?'+encodeURI(arrAttach[i].attUrl)+'" NAME="' + arrAttach[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + arrAttach[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + arrAttach[i].aid + '@' + arrAttach[i].ym + '_' + arrAttach[i].attachId + ',"></div>';--%>
                            }
                            return stra2
                        } else {
                            return ' '
                        }
                    }
                }
                ,{field: 'evUserName', title: '评价人',width:100}
                ,{field: 'evTime', title: '评价时间',minWidth:200,templet: function(d){
                        return  d.evTime.slice(0,-2)
                    } }
                ,{fixed: '', title: '操作',toolbar: '#barDemo',width:65}
            ]]
            ,parseData: function(res){ //res 即为原始返回的数据
                asd = res
                return {
                    "code":0, //解析接口状态
                    "data": res.obj//解析数据列表
                };
            },done:function(res, curr, count){
                var data = res.data;//返回的json中data数据
                for (var item in data) {
                    var evAttitude=data[item].evAttitude/2
                    var evSkill=data[item].evSkill/2
                    rate.render({
                        elem: '#evAttitude'+data[item].evId+''         //绑定元素
                        , length: 5            //星星个数
                        , value:  evAttitude          //初始化值
                        , readonly: true      //只读
                        , half: true

                    });
                    rate.render({
                        elem: '#evSkill'+data[item].evId+''         //绑定元素
                        , length: 5            //星星个数
                        , value:  evSkill          //初始化值
                        , readonly: true      //只读
                        , half: true
                    });
                }
                if (asd.msg == '无权限查看')
                {
                    $(".layui-table-main").html('<div class="layui-none">无权限查看</div>');
                }
            }
        });

        //监听工具条
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'detail'){ //查看
                layer.open({
                    type: 1,
                    title: '评价详情',
                    area: ['800px', '350px'], //宽高
                    content: '<form class="layui-form" action="">'+
                        '<table class="layui-table" style="text-align: center;">\n' +
                        '  <tbody>\n' +
                        '    <tr>\n' +
                        '      <td style="width:15%">综合评价</td>\n' +
                        '      <td style="width:31%"> <div id="totalEv">\n' +
                        '      </div></td>\n' +
                        '      <td style="width:15%">工作技能</td>\n' +
                        '      <td><div id="skill"></div><input id="sk"type="text"  class="layui-input" style="display: none"></td>\n' +
                        '    </tr>\n' +
                        '    <tr>\n' +
                        '      <td>所在项目</td>\n' +
                        '      <td><div class="pro"></div></td>\n' +
                        '      <td>工作态度</td>\n' +
                        '      <td><div id="attitude"></div><input id="att"type="text"  class="layui-input" style="display: none"></td>\n' +
                        '    </tr>\n' +
                        '    <tr>\n' +
                        '      <td>详细评价</td>\n' +
                        '      <td colspan="3"><div class="pingjia"></div></td>\n' +
                        '    </tr>\n' +
                        '<tr><td>附件</td><td colspan="3"><div class="wenjian"></div></td></tr>\n' +
                        '    <tr>\n' +
                        '      <td>评价人</td>\n' +
                        '      <td><span id="ev">张三</span></td>\n' +
                        '      <td>时间</td>\n' +
                        '      <td><div id="Date"></div></td>\n' +
                        '    </tr>\n' +
                        '  </tbody>\n' +
                        '</table>'+
                        '</form>'
                    ,success:function () {
//                            //渲染
                            rate.render({
                                elem: '#skill'   //绑定元素
                                , half: true //开启半星
                                , value: data.evSkill / 2
                                ,readonly: true
                            });
                            rate.render({
                                elem: '#attitude' //绑定元素
                                , half: true //开启半星
                                , value:  data.evAttitude / 2
                                ,readonly: true
                            });

                        //综合评价
                        // $("#totalEv input").each(function(index ,item){
                        //     if(data.evLevel==index+1){
                        //         $(this).attr('checked','checked')
                        //     }
                        // });
                        if(data.evLevel==1){
                            $('#totalEv').html('优秀')
                        }else if(data.evLevel==2){
                            $('#totalEv').html('一般')
                        }else if(data.evLevel==3){
                            $('#totalEv').html('差')
                        }

                        form.render('radio');
                        //所在项目
                        $('.pro').html(data.project)
                        //详细评价
                        $('.pingjia').html(data.evDetail)

                        var strimg = ''
                        var data1 = obj.data.attachmentList
                        if(obj.data.attachmentList != undefined){
                            for(var i=0;i<data1.length;i++){
                                var fileExtension=data1[i].attachName.substring(data1[i].attachName.lastIndexOf(".")+1,data1[i].attachName.length);//截取附件文件后缀
                                var attName = encodeURI(data1[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                var deUrl = data1[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data1[i].size;
                                strimg += '<div class="dech" deUrl="' + deUrl+ '">' +
                                    '<a NAME="' + data1[i].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
                                    '<img  src="/img/attachment_icon.png"/>' + data1[i].attachName + '</a>' +
                                    '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px">' +
                                    '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                    '<a class="download" style="padding-left: 5px;" href="/download?'+encodeURI(deUrl)+'" >' +
                                    '<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
                                    '<input type="hidden" class="inHidden" value="' + data1[i].aid + '@' + data1[i].ym + '_' + data1[i].attachId + ',">'
                            }
                        }else{

                        }
                        //文件回显
                        $('.wenjian').html(strimg)
                        //评价人
                        $('#ev').html(data.evUserName)
                        //时间
                        $('#Date').html(data.evTime.slice(0,-2))
                        form.render()

                    }
                });
            }
        });
        return  userId

    }
    //添加评价
    $('#addEv').on('click',function () {

        layer.open({
            type: 1,
            title: '添加评价',
            btn: ['确定', '取消'],
            area: ['800px', '450px'], //宽高
            content: '<form class="layui-form" action="">'+
                '<table class="layui-table" style="text-align: center;">\n' +
                '  <tbody>\n' +
                '    <tr>\n' +
                '      <td style="width:15%">综合评价<span class="import">*</span></td>\n' +
                '      <td style="width:35%"> <div id="totalEv"><input type="radio" name="ev" value="1" title="优秀" checked>\n' +
                '      <input type="radio" name="ev" value="2" title="一般" ><input type="radio" name="ev" value="3" title="差"></div></td>\n' +
                '      <td style="width:15%">工作技能<span class="import">*</span></td>\n' +
                '      <td><div id="skill"></div><input id="sk"type="text"  class="layui-input" style="display: none"></td>\n' +
                '    </tr>\n' +
                '    <tr>\n' +
                '      <td>所在项目<span class="import">*</span></td>\n' +
                '      <td><input type="text" name="project" required lay-verify="required" placeholder="请输入所在项目" autocomplete="off" class="layui-input">  </td>\n' +
                '      <td>工作态度<span class="import">*</span></td>\n' +
                '      <td><div id="attitude"></div><input id="att"type="text"  class="layui-input" style="display: none"></td>\n' +
                '    </tr>\n' +
                '    <tr>\n' +
                '      <td>详细评价<span class="import">*</span></td>\n' +
                '      <td colspan="3"><textarea name="ev" required lay-verify="required" placeholder="请输入评价" class="layui-textarea"></textarea></td>\n' +
                '    </tr>\n' +
                '<tr>\n'+
                '<td>附件</td>\n'+
                '<td colspan="3">    <div class="layui-row">\n' +
                '        <div class="layui-col-xs12" style="padding: 0 5px;">\n' +
                '            <div class="layui-form-item">\n' +
                '                <div class="layui-input-block form_block" style="margin-left: 0;">\n' +
                '<a href="javascript:;"  class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                // '<img src="../img/mg11.png" id="tu" alt="">\n' +
                // '<span id="zi">添加附件</span>\n' +
                '<input type="file"  multiple id="fileupload"  data-url="/upload?module=hrEvaluate" name="file">\n' +
                '</a>\n' +
                '                    <div id="fileAll" style="display: flow-root; position: relative; left: -128px; top: 8px;">\n' +
                '                    </div>\n' +
                '                </div>\n' +
                '            </div>\n' +
                '        </div>\n' +
                '    </div></td>\n'+
                '</tr>\n' +
                '    <tr>\n' +
                '      <td>评价人</td>\n' +
                '      <td><span id="ev"></span></td>\n' +
                '      <td>时间</td>\n' +
                '      <td><div id="Date"></div></td>\n' +
                '    </tr>\n' +
                '  </tbody>\n' +
                '</table>'+
                '</form>'
            ,success:function () {
                $.ajax({
                    type: 'get',
                    url: '/getLoginUser',
                    dataType: 'json',
                    success: function (res) {
                        var s=res.object.userName
                        var dd=document.getElementById('ev');
                        dd.innerHTML=s;
                    }
                })
                form.render()
                //渲染
                var ins1 = rate.render({
                    elem: '#skill'  //绑定元素
                    ,half: true //开启半星
                    ,choose: function(value){
                        var value=value*2;
                        $('#sk').val(value)
                    }
                });
                var ins2 = rate.render({
                    elem: '#attitude'  //绑定元素
                    ,half: true //开启半星
                    ,choose: function(value){
                        var value=value*2;
                        $('#att').val(value)
                    }
                });
                date()
                $.ajax({
                    type: 'post',
                    url: 'hrEvaluate/addHrEvaluates',
                    dataType: 'json',
                    success: function (res) {
                        // console.log(res.object.userName)
                        $('#ev').html(res.object.userName)
                    }
                })
                fileuploadFn('#fileupload', $('#fileAll'));

            }
            ,yes: function(){
                if($('#sk').val()==''){
                    layer.msg('请给工作技能评分!', {icon: 5});
                    return false
                }
                if($('input[name="project"]').val()==''){
                    layer.msg('请输入所在项目!', {icon: 5});
                    return false
                }
                if($('#att').val()==''){
                    layer.msg('请给工作态度评分!', {icon: 5});
                    return false
                }
                if($('textarea[name="ev"]').val()==''){
                    layer.msg('请输入评价!', {icon: 5});
                    return false
                }
                //综合评价
                var evLevel=$('#totalEv').find('input:checked').val()
                //工作技能
                var evSkill=$('#sk').val()
                //所在项目
                var project=$('input[name="project"]').val()
                //工作态度
                var evAttitude=$('#att').val()
                var attachmentId = '';
                var attachmentName = '';
                for (var i = 0; i < $('#fileAll .dech').length; i++) {
                    attachmentId += $('#fileAll .dech').eq(i).find('input').val();
                    attachmentName += $('#fileAll a').eq(i).attr('name');
                }
                //详细评价
                var evDetail=$('textarea[name="ev"]').val()

                $.ajax({
                    type: 'post',
                    url: '/hrEvaluate/addHrEvaluates',
                    dataType: 'json',
                    data: {
                        userId:userId,
                        evLevel:evLevel,
                        evSkill:evSkill,
                        project:project,
                        evAttitude:evAttitude,
                        attachmentId:attachmentId,
                        evDetail:evDetail,
                        attachmentName:attachmentName
                    },
                    success: function (res) {
                        console.log(res)
                        layer.closeAll();
                        table1.reload({
                            where: {userId:userId }
                        });
                    }
                })
            },
            btn2: function(index, layero){
                layer.closeAll();
            }
            ,cancel: function(){
                layer.closeAll();
            }
        });
    })
    $.ajax({
        type: 'post',
        url: '/HrEvaluatePriv/findIsUserPriv',
        dataType: 'json',
        success:function (res) {
          personnel= res.object
        }
    })
    //实时获取现在时间
    function date(){
        var date=new Date();
        var year=date.getFullYear(); //获取当前年份
        var mon=date.getMonth()+1; //获取当前月份
        var da=date.getDate(); //获取当前日
        var h=date.getHours(); //获取小时
        var m=date.getMinutes(); //获取分钟
        var s=date.getSeconds(); //获取秒
        if (mon < 10) mon = "0" + mon;
        if (da < 10) da = "0" + da;
        if (h < 10) h = "0" + h;
        if (m < 10) m = "0" + m;
        if (s < 10) s = "0" + s;
        var d=document.getElementById('Date');
        d.innerHTML=year+'-'+mon+'-'+da+' '+h+':'+m+':'+s;
    }
    var userId = "";
    var usreName = ""

    function turnZero(n){
        if(n=="0000-00-00"){
            return "";
        }else{
            return n;
        }
    };
    var deptNameShow = "";
    var deptIdShow = "";
    /*左侧部门接口*/
    function ajaxdata(deptNumId, me) {  //部门
        deptIdShow = deptNumId;
        deptNameShow = $(me).find('a').text();
        //   console.log($(me).next().val())
        $('.loopData').remove();
        $('.childQuery').show().siblings().hide();
        var data = {
            'deptId': deptNumId
        };
        $.ajax({
            type: 'get',
            url: '/hr/api/getPersonFilesByDeptId',
            dataType: 'json',
            data: data,
            success: function (res) {
                $(".checkOper").remove();
                var th = '<tr>' +
                    '<th><fmt:message code="notice.th.chose" /></th>' +
                    '<th><fmt:message code="userDetails.th.name" /></th>' +
                    '<th><fmt:message code="interfaceSetting.th.UserAvatar" /></th>' +
                    '<th><fmt:message code="HR.TH.FileAvatar" /></th>' +
                    '<th>OA<fmt:message code="userManagement.th.role" /></th>' +
                    '<th><fmt:message code="userDetails.th.Gender" /></th>' +
                    '<th><fmt:message code="hr.th.DateOfBirth" /></th>' +
                    '<th><fmt:message code="hr.th.Nation" /></th>' +
                    '<th><fmt:message code="hr.th.PlaceOfOrigin" /></th>' +
                    '<th><fmt:message code="hr.th.PoliticalOutlook" /></th>' +
                    '<th><fmt:message code="hr.th.InductionTime" /></th>' +
                    '<th><fmt:message code="notice.th.operation" /></th>' +
                    '</tr>';
                var data = res.obj;
                var str = '';
                if (data.length > 0) {
                    for (var i = 0; i < data.length; i++) {
                        var txt = data[i].staffSex == 0 ? '<fmt:message code="userInfor.th.male" />' : '<fmt:message code="userInfor.th.female" />';
                        var photo=data[i].photo==''?'<fmt:message code="hr.th.NotUploaded" />':'<fmt:message code="doc.th.Uploaded" />';
                        var photoName=data[i].photoName==''?'<fmt:message code="hr.th.NotUploaded" />':'<fmt:message code="doc.th.Uploaded" />';
                        str += '<tr class="loopData" uid="' + data[i].deptId + '">' +
                            '<td align="center"><input  id="input1" name="" type="checkbox" val="' + data[i].staffId + '" class="checkChild" style="margin-left: 30%;"/></td>' +
                            '<td class="userDetail">' + data[i].staffName + '</td>' +
                            '<td>' + photo + '</td>' +
                            '<td>' + photoName + '</td>' +
                            '<td>' + data[i].userPrivName + '</td>' +
                            '<td>' + txt + '</td>' +
                            '<td>' + turnZero(data[i].staffBirth) + '</td>' +
                            '<td>' + data[i].staffNationality + '</td>' +
                            '<td>' + data[i].staffNativePlaceName+'&nbsp;&nbsp;'+data[i].staffNativePlace2+ '</td>' ;

                        if(data[i].staffPoliticalStatus==1){
                            str+= '<td><fmt:message code="hr.th.TheMasses" /></td>' ;
                        }else  if(data[i].staffPoliticalStatus==2){
                            str+= '<td><fmt:message code="hr.th.Communist" /></td>' ;
                        }else  if(data[i].staffPoliticalStatus==3){
                            str+= '<td><fmt:message code="hr.th.CPCMembers" /></td>' ;
                        }else  if(data[i].staffPoliticalStatus==4){
                            str+= '<td><fmt:message code="hr.th.CPCProbationaryParty" /></td>' ;
                        }else  if(data[i].staffPoliticalStatus==5){
                            str+= '<td><fmt:message code="hr.th.DemocraticParties" /></td>' ;
                        }else  if(data[i].staffPoliticalStatus==6){
                            str+= '<td><fmt:message code="hr.th.PersonagesWithoutParty" /></td>' ;
                        }else{
                            str+= '<td></td>' ;
                        }
                        str+=  '<td>' + turnZero(data[i].datesEmployed) + '</td>' +
                            '<td><a class="hr_edit"  uid="' + data[i].uid + '"><fmt:message code="global.lang.edit" /></a>&nbsp;&nbsp;' +
                            '<a class="delBtnSingle"  val="' + data[i].staffId + '" href="javascript:void(0)"><fmt:message code="global.lang.delete" /></a></td>' +
                            '</tr>';
                    }
                    $('.allCondition').html(th + str);
                } else {
                    $('.allCondition').html(th);
                }
                var userCount = 0;//用户人数
                var haveDocument = 0;//建档人数
                //根据部门查询当前部门下用户的人数
                $.ajax({
                    type: 'get',
                    url: '/user/getUsersByDeptId',
                    dataType: 'json',
                    data: {
                        'deptId': deptNumId
                    },
                    success: function (obj) {
                        var data1 = obj.obj;
                        userCount = data1.length;
                        $(".have_per").html(userCount);
                        haveDocument = data.length;
                        $(".no_perCount").html(parseInt(userCount) - parseInt(haveDocument));
                    }
                })
            }
        })
        $.ajax({
            type: 'get',
            url: '/hr/api/queryCountNoDocument',
            dataType: 'json',
            data: data,
            success: function (res) {
                var count = res.totleNum;
                $(".no_perCount").html(count);
            }
        })
    }
    /*部门选择调用的方法*/
    //左侧树的加载
    $(function () {
        loadSidebar1($('#downChild'),0)
        function loadSidebar1(target,deptId) {
            $.ajax({
                url: '/department/getChDeptfq',
                type: 'get',
                data: {
                    deptId: deptId
                },
                dataType: 'json',
                success: function (data) {
                    var str = '';
                    data.obj.forEach(function (v, i) {
                        if (v.deptName) {
                            if(v.deptId != 100&&v.deptName != "高速波（系统支持）"&&v.deptNo != "900"){
                                str += '<li><span data-types="1"  data-numtrue="1" ' +
                                    'onclick= "imgDown(' +v.deptId + ',this)"  style="height:35px;line-height:35px;padding-left: 30px" deptid="' + v.deptId + '" class="firsttr childdept"><span class=""></span><img src="/img/sys/dapt_right.png" alt="" style="margin-left: 12px;width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;"><a href="javascript:void(0)" class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a></span><ul style="display:none;" class="dpetWhole0"></ul></li>';
                            }
                        }
                    })
                    widthnum++;
                    target.append(str);
                }
            })
        }
        //展示左侧 上海打捞局 字段
        $.ajax({
            url:'/sys/showUnitManage',
            type:'get',
            dataType:"JSON",
            data : '',
            success:function(obj){
                var data = obj.object.unitName;
                $('#downChild .pickCompany .dynatree-title').text(data).attr('title',data);

            },
            error:function(e){
            }
        })
    })

    $('button[name="chaxun"]').on("click",function(){
        var userName = $('input[name="xingming"]').val();
        if ( userName == undefined || userName == ''){
            return false;
        }
        $.post('/user/queryExportUsers',{
            userName:userName,
            pageSize: 100,
            useFlag: true,
            page: 1,
        },function(res){
            var obj = res.obj;

            if (res.flag && obj.length > 0){
                if ( obj.length == 1 ){
                    var obj0 = obj[0];
                    clickrenwu(obj0.userId,obj0.userName);
                }
                else{
                    layer.open({
                        type: 1,
                        content: '<div><table id="test2" lay-filter="test2"> </table></div>'
                        ,area: ['800px', '600px']
                        ,success: function(layero, index){
                            table.render({
                                elem: '#test2'
                                , url: '/user/queryExportUsers?userName='+userName+'&pageSize=100'+'&useFlag=true&page=1'
                                , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                                    title: '提示'
                                    , layEvent: 'LAYTABLE_TIPS'
                                    , icon: 'layui-icon-tips'
                                }]
                                , title: '用户数据表'
                                ,cols: [[ //表头
                                    {field: 'userName', title: '姓名',align:'center'}
                                    ,{field: 'sexName', title: '性别',align:'center'}
                                    ,{field: 'deptName', title: '部门',align:'center'}
                                    ,{fixed: 'right', title: '操作',align:'center',toolbar: '#barDemo'}
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
                            //工具条事件
                            table.on('tool(test2)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
                                var data = obj.data; //获得当前行数据
                                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                                var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
                                var userNames = data.userName;
                                if((userNames.indexOf('(') != -1) ||  (userNames.indexOf(')') != -1)){
                                    userNames = userNames.replace(/\(/g,"（").replace(/\)/g,"）");
                                }
                                if(layEvent === 'detail'){ //查看
                                    clickrenwu(data.userId,userNames);
                                    layer.close(index)
                                }
                            })

                        }
                    });


                }
            }
        })
    });

    $(document).on('click', '.deImgs', function () {
        var _this = this;
        var attUrl = $(this).parents('.dech').attr('deUrl');
        layer.confirm('确定删除该附件吗？', function (index) {
            $.ajax({
                type: 'get',
                url: '/delete?' + attUrl,
                dataType: 'json',
                success: function (res) {
                    if (res.flag == true) {
                        layer.msg('删除成功', {icon: 6, time: 1000});
                        $(_this).parent().remove();
                    } else {
                        layer.msg('删除失败', {icon: 2, time: 1000});
                    }
                }
            })
        });
    });

</script>
</body>
</html>

