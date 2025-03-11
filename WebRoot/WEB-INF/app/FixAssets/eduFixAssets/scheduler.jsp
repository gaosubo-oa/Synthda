<%--
  Created by IntelliJ IDEA.
  User: jia
  Date: 2019/3/19
  Time: 14:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title>保管人确认</title>
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <%-- <link rel="stylesheet" type="text/css" href="../css/base.css" />
     <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
     <script src="../../lib/layer/layer.js?20201106"></script>--%>

    <link rel="stylesheet" type="text/css" href="../css/news/center.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css" />
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <script src="../js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="../css/news/new_news.css"/>
    <!-- word文本编辑器 -->
    <script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="../js/jquery/jquery.cookie.js" type="text/javascript" charset="utf-8"></script>
</head>
<style>
    body,html{
        width:100%;
        height:100%;
    }
    .th{
        font-size: 13pt;
        width:10%;
    }
    td{
        width:10%;
        font-size: 11pt;
    }
    .navigation{
        margin-left: 30px;
    }
    .del_btn {
        color: #E01919;
        cursor: pointer;
    }
    .edit_btn,.Handover_btn,.Maintain_btn,.detail_btn,.allocation_btn,.scrap_btn{
        color: #1772C0;
        cursor: pointer;
    }
    #tr_td td{
        text-align: center;
    }
    .exportsss {
        width: 80px;
        height: 30px;
        cursor: pointer;
        background-image: url(../../img/import.png);
        padding-left: 25px;
        font-size: 13px;
        background-repeat: no-repeat;
        border-width: initial;
        border-style: none;
        border-color: initial;
        border-image: initial;
    }
    .fileload {
        position: absolute;
        opacity: 0;
        width: 80px;
        right: 520px;
        height: 29px;
        top: 21px;
    }
    .newClass{
        float: right;
        width: 90px;
        height: 28px;
        background: url(../../img/file/cabinet01.png) no-repeat;
        color: #fff;
        font-size: 14px;
        line-height: 28px;
        margin: 2% 4% 0 0;
        cursor: pointer;
    }
    .notice_do{
        width:16%;
    }
    td.assetName a{
        display: block;
        width:100%;
        max-width: 138px;
        color: #1772C0;
        cursor: pointer;
        overflow: hidden;
        text-overflow:ellipsis;
        white-space: nowrap;
    }
    .imgDiv{
        text-align: center;
        display: none;

    }
    .cl{
        clear: both;
    }
    .inp{
        border-radius: 4px;
        border: 1px solid #ccc;
        font-size: 12px;
        margin: 0;
        font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
    }
    .newsAdd tr{
        border-radius: 10px;
    }
    .bottom div{
        float: left;
        height: 85%;
        font-size: 14px;
        font-weight: normal;
        text-align: center;
        margin-top: 10px;
    }
    .bottom .dispatchAll {
        width: 80px;
        height: 30px;
        background-color: #2d7de0;
        color: white;
        text-align: center;
        cursor: pointer;
        border-radius: 14px;
        margin-top: 5px;
        line-height: 30px;
        margin-left: 30px;
    }
    .layui-layer .layuiDiv {
        margin-top: 20px;
        text-align: center;
    }

    .layuiDiv span {
        font-size: 11pt;
    }

    .layuiDiv select {
        width: 300px;
        height: 40px;
        font-size: 11pt;
    }
    .navigation .left .news{
        margin-right: 20px;
    }
    /*.layui-layer{*/
    /*top:100px!important;*/
    /*}*/
</style>
<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
<body style="font-family: 微软雅黑;">
<div>
<div class="navigation  clearfix" style="width: 97%;">
    <div class="left">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/fixAssetsManage.png">
        <div class="news" style="width: 150px;
    margin-top: 30px;">
            保管人确认
        </div>
    </div>
    <div class="allrecive" id="demo" style="background: #2b7fe0; margin-right: 50px;float:right;color: #fff;margin-top:21px;padding: 2px 10px;border-radius:3px;font-size: 11pt;width: 60px;height: 30px;cursor:pointer;line-height: 30px">全部接收</div>

</div>
    <div >
        <div >
            <div class="imgDiv">
                <img class="noneImg" src="/img/main_img/shouyekong.png" alt="" style="margin-top: 10%">
                <div>暂无数据</div>
            </div>
            <table id="tr_td" style="margin-left: 1%;width: 98%;" >
                <thead>
                <tr>
                    <td class="th"><fmt:message code="notice.th.chose"/></td>
                    <td class="th" ><fmt:message code="event.th.FixedAssetNumber" /></td>
                    <td class="th"><fmt:message code="event.th.AssetName" /></td>
                    <td class="th titleOne">品牌型号</td>
                    <td class="th">项目名称</td>
                    <td class="th">所属部门</td>
                    <td class="th" >所在位置</td>
                    <td class="th">类型</td>
                    <td class="th"><fmt:message code="event.th.ArticleStatus" /></td>
                    <%--<td class="th"><fmt:message code="event.th.FixedAssetsPicture" /></td>--%>
                    <td class="th notice_do"><fmt:message code="notice.th.operation" /></td>
                </tr>
                </thead>
                <tbody id="j_tb"></tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--分页按钮--%>
    <div id="dbgz_page" class="M-box3 fr" style="margin-right: 6%;margin-top: 2%">

    </div>
</div>
<script>
    //进行条件查询方法，并在列表中显示
    var ajaxPage={
        data:{
            page:1,//当前处于第几页
            pageSize:20,//一页显示几条
            useFlag:true,
            keeper:1
        },
        init:function () {
        },
        page:function () {
            var me=this;
            $.get('/eduFixAssets/selectEduFixAssets',me.data,function (obj) {
                $("#tr_td tbody").html("");
                var str="";
                var data=obj.obj;
                if(obj.flag){
                    if(data.length==0){
                        $(".imgDiv").css("display","block");
                        $("#tr_td").css("display","none");
                        $("#dbgz_page").css("display","none");
                        $("#demo").css("display","none");
                        return
                    }
                    $(".imgDiv").css("display","none");
                    $("#tr_td").css("display","block");
                    $("#dbgz_page").css("display","block");
                    for(var i=0;i<data.length;i++) {
                        str += '<tr >' +
                            '<td class="checkWrap"><input type="checkbox" name="chkItem" class="childCheck"> </td>' +
                            '<td style="min-width:166px">' + data[i].id + '</td>' +
                            '<td class="assetName" id="' + data[i].id + '" title="' + data[i].assetsName + '"><a >' + isNull(data[i].assetsName) + '</a></td>' +
                            '<td>' + isNull(data[i].info) + '</td>' +
                            '<td>' + isNull(data[i].projectName) + '</td>' +
                            '<td>' + isNull(data[i].deptName) + '</td>' +
                            '<td style="min-width:120px">' + isNull(data[i].currutLocation) + '</td>' +
                            '<td>' + isNull(data[i].typeName) + '</td>';
                        if (data[i].status == 1) {
                            str += '<td><fmt:message code="event.th.notUsed" /></td>';
                        } else if (data[i].status == 2) {
                            str += '<td><fmt:message code="evvent.th.Use" /></td>';
                        } else if (data[i].status == 3) {
                            str += '<td><fmt:message code="event.th.damage" /></td>';
                        } else if (data[i].status == 4) {
                            str += '<td><fmt:message code="event.th.Lose" /></td>';
                        } else if (data[i].status == 5) {
                            str += '<td><fmt:message code="event.th.Scrap" /></td>';
                        } else {
                            str += '<td></td>';
                        }

//                        if(data[i].image!='' && data[i].image!='undefined'){
//                            str += '<td>' + '<img src="/img/edu/eduFixAssets/' + data[i].image + '" style="height: 70px;width: 110px;"/>' + '</td>';
//                        }else{
//                            str += '<td></td>';
//                        }
                        if (data[i].schedulerstatus ==null ||(data[i].schedulerstatus != "0" && data[i].schedulerstatus != "1")) {

                            str += '<td white-space: nowrap; style="min-width:100px;">' +
                                //                            '<a class="detail_btn"  id="'+data[i].id+'" >查看详情</a>' +
                                '<a class="del_btn" style="margin-right:10px;color:#1772C0" fixassetsid="' + data[i].id + '" id="dquren" onclick="dquren()" style="">接收</a>' +
                                '<a class="del_btn" style="color:#1772C0" fixassetsid="' + data[i].id + '" id="buqueren"        onclick="Nofount()"   style="">不接收</a>' +
                                '</td>';
                        }else if(data[i].schedulerstatus =="0"){
                            str+='<td  style="min-width:100px;">' +
                                //                            '<a class="detail_btn"  id="'+data[i].id+'" >查看详情</a>' +
                                '<span class="del_btn" style="margin-right:10px;color:red;cursor:default;" fixassetsid="' + data[i].id + '"  style="">接收</span>' +
                                '</td>';
                        }else if(data[i].schedulerstatus =="1"){
                            str+='<td style="min-width:100px;">' +
                                '<span class="del_btn" style="margin-right:10px;color:blue;cursor:default;" fixassetsid="' + data[i].id + '" id="dquren" onclick="dquren()"  style="">接收</span>' +
                                //                            '<a class="detail_btn"  id="'+data[i].id+'" >查看详情</a>' +
                                '<span class="del_btn" style="margin-right:10px;color:red;cursor:default" fixassetsid="' + data[i].id + '"  id="Nofount" onclick="Nofount()"  style="">不接收</span>' +
                                '</td>';
                        }
                    }
                    $("#tr_td tbody").html(str);
                    $("#allChoose").prop("checked", false);


                }
                me.pageTwo(obj.totleNum,me.data.pageSize,me.data.page)

            },'json')
        },
        pageTwo:function (totalData, pageSize,indexs) {

            var mes=this;
            $('#dbgz_page').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage:'',
                endPage: '',
                current:indexs||1,
                callback: function (index) {
                    mes.data.page=index.getCurrent();
                    mes.page();
                },
            });
        }

    }



    ajaxPage.init()
    ajaxPage.page()
    function isNull(str) {
        if (str){
            return str;
        }else {
            return '';
        }
    }
    //点击标题查看详情
    $("#tr_td").on("click",".assetName",function () {
        var ids = $(this).attr('id');
        layer.open({
            type: 1,
            title: ['详情', 'background-color:#2b7fe0;color:#fff;'],
            area: ['900px', '80%'],
            shadeClose: true, //点击遮罩关闭
            content:
            "<div class='layuiDiv'>\n" +
            "        <span>资产名称：</span>\n" +
            "<input name=\"deptId\" id=\"deptId\" class=\"deptId\" deptid=\"\"  readonly style='height:40px;width:400px;'>\n" +
            "</div>\n" +
            "    <div class='layuiDiv'>\n" +
            "        <span style='margin-left: 28px'>类型：</span><select disabled id='typeIds' style='width:400px;'><option value=''>请选择..</option></select>\n" +
            "    </div>\n" +
            "    <div class='layuiDiv'>\n" +
            "        <span>所在部门：</span>\n" +
            "<input name=\"deptName\" id=\"deptName\" class=\"deptName\" deptid=\"\"  readonly style='width:400px;height:40px;'>" +

            "    </div>\n" +
            "    <div class='layuiDiv'>\n" +
            "        <span>所在位置：</span><select disabled id='currutLocation' style='width:400px;'><option value=''>请选择..</option></select>\n" +
            "    </div>\n" +
            "    <div class='layuiDiv'>\n" +
            "        <span>物品状态：</span><select disabled id='statuss' style='width:400px;'><option value=''>请选择..</option></select>\n" +
            "\n" +
            "    </div>" +
            "<div class='layuiDiv'>\n" +
            "<span>项目名称：</span><select id='otherDept' disabled readonly style='width:400px;'><option value=''>请选择..</option></select>" +
            "</div>"+
            "<div class='layuiDiv'>\n" +
            " <span style='margin-left: 12px;'>保管人：</span>\n" +
            "<input name=\"scheduler\" id=\"scheduler\" class=\"scheduler\" deptid=\"\"  readonly style='width:400px;height:40px;'>" +
            "</div>\n",
            success:function(){

                $.ajax({
                    type: 'get',
                    data: {ids: ids},
                    url: "/eduFixAssets/getEdufixAssets",
                    success: function (object) {
                        var objects = object.object
                        $("#deptId").val(objects.assetsName);
                        $("#scheduler").val(objects.schedulerName);
                        $("#deptName").val(objects.deptName);

                        $.ajax({
                            type: 'get',
                            url: "/code/getCode",
                            data: {"parentNo": "LOCATION_ADDRESS"},
                            success: function (data) {
                                $('#currutLocation').html('');
                                $("#currutLocation").append("<option value=''>请选择..</optionid>")
                                for (var x = 0; x < data.obj.length; x++) {
                                    $("#currutLocation").append("<option value=" + data.obj[x]["codeId"] + ">" + data.obj[x]["codeName"] + "</option>")
                                }
                                console.log(objects.currutLocation)
                                $("#currutLocation").val(objects.currutLocation);
                            }
                        });
                        $.ajax({
                            type: 'get',
                            url: "/code/getCode",
                            data: {"parentNo": "PROJECT_NAME"},
                            success: function (data) {
                                $('#otherDept').html('');
                                $("#otherDept").append("<option value=''>请选择..</optionid>")
                                for (var x = 0; x < data.obj.length; x++) {
                                    $("#otherDept").append("<option value=" + data.obj[x]["codeId"] + ">" + data.obj[x]["codeName"] + "</option>")
                                }
                                $("#otherDept").val(objects.otherDept);
                            }
                        });

                        $.ajax({
                            url:'/eduFixAssets/getFixAssetstypeName',
                            type:'json',
                            success:function (res) {
                                var data = res.object;
                                var len = data.length;
                                for (var i = 0; i < len; i++) {
                                    $("#typeIds").append("<option value='"+data[i]['typeId']+"'>"+data[i]['typeName']+"</option>");
                                }

                                $("#typeIds").val(objects.typeId); //获取select下拉框的所有值
                            }
                        });
                        $('#statuss').append('<option value="1"><fmt:message code="event.th.notUsed" /></option>\n' +
                            '                        <option value="2"><fmt:message code="evvent.th.Use" /></option>\n' +
                            '                        <option value="3"><fmt:message code="event.th.damage" /></option>\n' +
                            '                        <option value="4"><fmt:message code="event.th.Lose" /></option>\n' +
                            '                        <option value="5"><fmt:message code="event.th.Scrap" /></option>');
                        $("#statuss").val(objects.status); //获取select下拉框的所有值
                    }
                });

            }
        });

    })
    $("#tr_td").on("click",".detail_btn",function () {


    })
    //确认或者不确认

    function  dquren(){
        layer.confirm('是否确认接收！', {
            btn: ['确定'],//按钮
            // area: ['285px', '707px'],
            title: '提示'
        }, function () {
            layer.closeAll();
            var dat={
                id:$("#dquren").attr("fixassetsid"),
                schedulerstatus:0
            }
            quer(dat);
        });

    }

    $(document).on("click",".allrecive",function(){
        layer.confirm('是否全部接收！', {
            btn: ['确定'],//按钮
            // area: ['285px', '707px'],
            title: '提示'
        }, function () {
            layer.closeAll();
            $.ajax({
                url:"/eduFixAssets/updateQuerenBatch",
                data:{},
                type:'post',
                success:function(){
                    ajaxPage.page();
                    $.layerMsg({content: '成功！', icon: 1});
                }
            })
        });
    })

    function Nofount (){
        layer.open({
            type: 1,
            title: ['请填写不接收的理由', 'background-color:#2b7fe0;color:#fff;'],
            area: ['700px', '300'],
            shadeClose: true, //点击遮罩关闭
            btn: ['确定', '关闭'],
            content:
            "<div class='layuiDiv'>\n" +
            "        <span style='margin-left: 46px;'>不接收理由：<span style='color:red'>*</span></span>\n" +
            "<textarea name='txt' id='noAcceptReason' assetsId='' value='' style='min-width: 500px;min-height:150px;font-size:11pt'></textarea>\n" +
            "</div>",

            yes: function (index){
                var dat={
                    id:$("#dquren").attr("fixassetsid"),
                    schedulerstatus:1,
                    noAcceptReason:$("#noAcceptReason").val()
                }
                if($("#noAcceptReason").val()==''){
                    $.layerMsg({content: '请填写理由！', icon: 6});
                }else{
                 quer(dat);
                 layer.closeAll();
                }
            }
        });
    }

    function quer(dat){
        $.ajax({
            url:"/eduFixAssets/updateQueren",
            data:dat,
            type:'post',
            success:function(){
                ajaxPage.page();
                $.layerMsg({content: '成功！', icon: 1});
            }
        })
    }
</script>
</body>
</html>
