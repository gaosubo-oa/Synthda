<%--
  Created by IntelliJ IDEA.
  User: 小小木
  Date: 2022/2/14
  Time: 14:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>机构信息审核</title>
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
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.config.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js?20201221.1" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js?20201221.1" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
</head>
<style>


    #box .layui-from {
        width: 100%;
    }
    .layui-table-page>div{
        float: right;
    }
    .layui-table-body{overflow-x: hidden;}
    #box .layui-table {
        width: 90%;
        margin: 0 auto;
    }

    .asd {
        font-weight: bold;
        font-size: 18px;
        margin-left: 30px;
    }

    .zxc {
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
    .layui-table-body {
        overflow-x: auto !important;
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
    }

    #test3 {
        margin-left: 68px;
    }

    .layui-form-label {
        width: 60px;
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
    <div>
        <span class="zxc">机构信息审核</span>
    </div>
    <form class="layui-form" action="">
        <div style="position: relative;    line-height: 60px;">
            <div class="layui-input-inline">
                <div style="display: flex">
                    <div id="book1" style="margin-top: 10px;">
                        <input id="book1" name="radio" title="待审批" type="radio" lay-filter="isAdvance" checked="" value="0">
                    </div>
                    <div id="book2" style="margin-top: 10px;">
                        <input id="book2" onclick="book2()" name="radio" title="同意" lay-filter="isAdvance" type="radio" value="1">
                    </div>
                    <div id="book3" style="margin-top: 10px">
                        <input id="book3" name="radio" title="不同意" type="radio" lay-filter="isAdvance" value="2">
                    </div>
                </div>
            </div>
<%--            <div class="layui-inline">--%>
<%--                <label class="layui-form-label">申请人</label>--%>
<%--                <div class="layui-input-inline">--%>
<%--                    <input  style="width: 200px" id="applicant" name="applicant" class="layui-input" type="text">--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="layui-inline">--%>
<%--                <label class="layui-form-label">借阅标题</label>--%>
<%--                <div class="layui-input-inline">--%>
<%--                    <input  style="width: 200px" id="borrowSubject" name="borrowSubject" class="layui-input" type="text">--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="layui-inline">--%>
<%--                <label class="layui-form-label">借阅时间</label>--%>
<%--                <div class="layui-input-inline">--%>
<%--                    <input  style="width: 200px" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" id="borrowTime" name="borrowTime" class="layui-input" type="text">--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <button type="button" class="layui-btn layui-btn-sm" id="search1" lay-event="search" style="height: 30px;line-height: 30px;">查询</button>--%>
        </div>


    </form>

    <table class="layui-hide" id="test1" lay-filter="test1"></table>
</div>
<script id="barDemos" type="text/html">
    <div class="long">
        {{#  if(d.auditStatus == '0'  ||  d.auditStatus == ''){ }}
        <a id="detail2" lay-event="detail2" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">同意</a>
        <a id="detail3" lay-event="detail3" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">不同意</a>
        {{#  }else if(d.auditStatus == '1'){ }}
        <a id="detail1" lay-event="detail1" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">查看</a>
        {{#  }else if(d.auditStatus == '2'){ }}
        <a id="detail1" lay-event="detail1" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">查看</a>
        {{#  } }}
    </div>

</script>

</body>
<script>
    var orgId='';
    var isAdvance='0'
    $.ajax({
        type: 'post',
        url: '/EduorgMessage/myOrg',
        dataType: 'json',
        async:false,
        data:{
            page:1,
            pageSize:10,
            useFlag:true
        },
        success: function (json) {
            if(json.flag){
                orgId=json.object.orgId;
            }
        }
    })
    layui.use(['form', 'table', 'element', 'layedit','eleTree'], function () {
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var layedit = layui.layedit
        var eleTree = layui.eleTree;
        form.render()

        var el;
        $("[name='orgDeptId']").on("click",function (e) {
            e.stopPropagation();
            if(!el){
                $.get('/orgDepartment/queryByDepIdList?deptId=0', function (res) {
                    if (res.flag) {
                        el = layui.eleTree.render({
                            elem: '.ele2',
                            data: res.obj,
                            expandOnClickNode: false,
                            highlightCurrent: true,
                            showLine: true,
                            showCheckbox: false,
                            checked: false,
                            lazy: true,
                            //defaultExpandAll: false,
                            request: {
                                name: 'orgDeptName',
                                id:'orgDeptId',
                                isLeaf:false
                                //children: "plbProjList",
                            },
                            load: function(data,callback) {
                                $.post('/orgDepartment/queryByDepIdList?deptId='+data.deptId,function (res) {
                                    callback(res.obj);//点击节点回调
                                })
                            },
                            done: function(res){
                                if(res.data.length == 0){
                                    $(".ele2").html('<div style="text-align: center">暂无数据</div>');
                                }
                            }
                        });

                    }
                });
            }
            $(".ele2").slideDown();
        })
        $(document).on("click",function() {
            $(".ele2").slideUp();
        })
        //节点点击事件
        layui.eleTree.on("nodeClick(data2)",function(d) {
            var parData1 = d.data.currentData;
            $("[name='orgDeptId']").val(parData1.deptName);
            $("#orgDeptName").attr("pid",parData1.deptId);
        })
        $('#book1').click(function () {
            var auditStatus = '0'
            table.render({
                elem: '#test1'
                , url:'/EduorgMessage/selectInfoAudit'
                , where:{
                    auditStatus:auditStatus,
                    orgId:orgId,
                    FpageSize:'10',
                    useFlag:true
                }
                , method:'post'
                , cols: [[
                    {field:'applicant',title:'申请人',align:'center',minWidth:150,},
                    {field:'orgName',title:'机构简称',align:'center',minWidth:150,},
                    {field:'changeType',title:'变更类型',align:'center',minWidth:150,templet: function (d) {
                            if (d.changeType == '1') {
                                return '基础信息'
                            }else {
                                return '办园信息'
                            }
                        }},
                    {field:'changes',title:'变更事项',align:'center',minWidth:150,},
                    {field:'beforeChange',title:'变更前',align:'center',minWidth:150,},
                    {field:'afterChange',title:'变更后',align:'center',minWidth:150,},
                    {field:'submissionTime',title:'提交时间',align:'center'},
                    {field:'auditTime',title:'审核时间',align:'center'},
                    {field: 'auditDesc', title: '审核意见', align:'center',minWidth:150,},
                    {field: 'attachmentName', title: '附件', align: 'center',minWidth:150, templet: function (d) {
                            var strr = ''
                            var object=d
                            if(d.attachmentList==undefined){
                                return ''
                            }else{
                                for(var i=0;i<object.attachmentList.length;i++){
                                    var str1 = ""
                                    if( object.attachmentList[i].attUrl != undefined ){
                                        var fileExtension=object.attachmentList[i].attachName.substring(object.attachmentList[i].attachName.lastIndexOf(".")+1,object.attachmentList[i].attachName.length);
                                        str1 = '' +
                                            '<div class="dech" deurl="' +object.attachmentList[i].attUrl + '">' +
                                            '<a href="/download?' + object.attachmentList[i].attUrl + '" name="'+object.attachmentList[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                            '<img src="/img/attachment_icon.png">' + object.attachmentList[i].attachName + '</a>' +
                                            '' +
                                            // '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png">' +
                                            '<input type="hidden" class="inHidden" value="' + object.attachmentList[i].aid + '@' + object.attachmentList[i].ym + '_' + object.attachmentList[i].attachId +',">' +
                                            '<a fileExtension="'+fileExtension+'"onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                            '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                            '<a style="padding-left: 5px" href="/download?' + object.attachmentList[i].attUrl + '">' +
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

                        }},
                    {title:'操作',toolbar:'#barDemos',minWidth:200,align:'center'},
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
        $('#book2').click(function () {
            var auditStatus = '1'
            table.render({
                elem: '#test1'
                , url:'/EduorgMessage/selectInfoAudit?auditStatus='+auditStatus+'&orgId='+orgId+'&pageSize='+'10'+'&useFlag='+true
                , cols: [[
                    {field:'applicant',title:'申请人',align:'center',minWidth:150,},
                    {field:'orgName',title:'机构简称',align:'center',minWidth:150,},
                    {field:'changeType',title:'变更类型',align:'center',minWidth:150,templet: function (d) {
                            if (d.changeType == '1') {
                                return '基础信息'
                            }else {
                                return '办园信息'
                            }
                        }},
                    {field:'changes',title:'变更事项',align:'center',minWidth:150,},
                    {field:'beforeChange',title:'变更前',align:'center',minWidth:150,},
                    {field:'afterChange',title:'变更后',align:'center',minWidth:150,},
                    {field:'submissionTime',title:'提交时间',align:'center'},
                    {field:'auditTime',title:'审核时间',align:'center'},
                    {field: 'auditDesc', title: '审核意见', align:'center',minWidth:150,},
                    {field: 'attachmentName', title: '附件', align: 'center',minWidth:150, templet: function (d) {
                            var strr = ''
                            var object=d
                            if(d.attachmentList==undefined){
                                return ''
                            }else{
                                for(var i=0;i<object.attachmentList.length;i++){
                                    var str1 = ""
                                    if( object.attachmentList[i].attUrl != undefined ){
                                        var fileExtension=object.attachmentList[i].attachName.substring(object.attachmentList[i].attachName.lastIndexOf(".")+1,object.attachmentList[i].attachName.length);
                                        str1 = '' +
                                            '<div class="dech" deurl="' +object.attachmentList[i].attUrl + '">' +
                                            '<a href="/download?' + object.attachmentList[i].attUrl + '" name="'+object.attachmentList[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                            '<img src="/img/attachment_icon.png">' + object.attachmentList[i].attachName + '</a>' +
                                            '' +
                                            // '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png">' +
                                            '<input type="hidden" class="inHidden" value="' + object.attachmentList[i].aid + '@' + object.attachmentList[i].ym + '_' + object.attachmentList[i].attachId +',">' +
                                            '<a fileExtension="'+fileExtension+'"onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                            '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                            '<a style="padding-left: 5px" href="/download?' + object.attachmentList[i].attUrl + '">' +
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

                        }},
                    {title:'操作',toolbar:'#barDemos',minWidth:200,align:'center'},
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
        $('#book3').click(function () {
            var auditStatus = '2'
            table.render({
                elem: '#test1'
                , url:'/EduorgMessage/selectInfoAudit?auditStatus='+auditStatus+'&orgId='+orgId+'&pageSize='+'10'+'&useFlag='+true
                , cols: [[
                    {field:'applicant',title:'申请人',align:'center',minWidth:150,},
                    {field:'orgName',title:'机构简称',align:'center',minWidth:150,},
                    {field:'changeType',title:'变更类型',align:'center',minWidth:150,templet: function (d) {
                            if (d.changeType == '1') {
                                return '基础信息'
                            }else {
                                return '办园信息'
                            }
                        }},
                    {field:'changes',title:'变更事项',align:'center',minWidth:150,},
                    {field:'beforeChange',title:'变更前',align:'center',minWidth:150,},
                    {field:'afterChange',title:'变更后',align:'center',minWidth:150,},
                    {field:'submissionTime',title:'提交时间',align:'center'},
                    {field:'auditTime',title:'审核时间',align:'center'},
                    {field: 'auditDesc', title: '审核意见', align:'center',minWidth:150,},
                    {field: 'attachmentName', title: '附件', align: 'center',minWidth:150, templet: function (d) {
                            var strr = ''
                            var object=d
                            if(d.attachmentList==undefined){
                                return ''
                            }else{
                                for(var i=0;i<object.attachmentList.length;i++){
                                    var str1 = ""
                                    if( object.attachmentList[i].attUrl != undefined ){
                                        var fileExtension=object.attachmentList[i].attachName.substring(object.attachmentList[i].attachName.lastIndexOf(".")+1,object.attachmentList[i].attachName.length);
                                        str1 = '' +
                                            '<div class="dech" deurl="' +object.attachmentList[i].attUrl + '">' +
                                            '<a href="/download?' + object.attachmentList[i].attUrl + '" name="'+object.attachmentList[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                            '<img src="/img/attachment_icon.png">' + object.attachmentList[i].attachName + '</a>' +
                                            '' +
                                            // '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png">' +
                                            '<input type="hidden" class="inHidden" value="' + object.attachmentList[i].aid + '@' + object.attachmentList[i].ym + '_' + object.attachmentList[i].attachId +',">' +
                                            '<a fileExtension="'+fileExtension+'"onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                            '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                            '<a style="padding-left: 5px" href="/download?' + object.attachmentList[i].attUrl + '">' +
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

                        }},
                    {title:'操作',toolbar:'#barDemos',minWidth:200,align:'center'},
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
        form.on('radio(isAdvance)', function(data){
            isAdvance = data.value

        });
        // $('#search1').click(function () {
        //     var applicant = $("#applicant").val()
        //     table.render({
        //         elem: '#test1'
        //         , url:'/EduorgMessage/selectInfoAudit?auditStatus='+isAdvance+'&applicant='+applicant+'&orgId='+orgId+'&pageSize='+'10'+'&useFlag='+true
        //         ,cols:[[
        //             {field:'applicant',title:'申请人',align:'center'},
        //             {field:'orgName',title:'机构简称',align:'center'},
        //             {field:'changeType',title:'变更类型',align:'center',templet: function (d) {
        //                     if (d.changeType == '1') {
        //                         return '基础信息'
        //                     }else {
        //                         return '办园信息'
        //                     }
        //                 }},
        //             {field:'changes',title:'变更事项',align:'center'},
        //             {field:'beforeChange',title:'变更前',align:'center'},
        //             {field:'afterChange',title:'变更后',align:'center'},
        //             {field:'submissionTime',title:'提交时间',align:'center',minWidth:200,},
        //             {field:'auditTime',title:'审核时间',align:'center',minWidth:200,},
        //             {field: 'auditDesc', title: '审核意见', },
        //             {title:'操作',toolbar:'#barDemos',minWidth:200,align:'center'},
        //         ]],
        //         page:true,
        //         limit:10
        //         ,parseData: function(res){ //res 即为原始返回的数据
        //             return {
        //                 "code":0,
        //                 "count":res.totleNum,
        //                 "data": res.obj //解析数据列表
        //             };
        //         }
        //     });
        // });
        var auditStatus = '0'
        table.render({
            elem: '#test1'
            , url:'/EduorgMessage/selectInfoAudit?auditStatus='+auditStatus+'&orgId='+orgId+'&pageSize='+'10'+'&useFlag='+true
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                , layEvent: 'LAYTABLE_TIPS'
                , icon: 'layui-icon-tips'
            }]
            ,method: 'post'
            , title: '用户数据表'
            , cols: [[
                {field:'applicant',title:'申请人',align:'center',minWidth:150,},
                {field:'orgName',title:'机构简称',align:'center',minWidth:150,},
                {field:'changeType',title:'变更类型',align:'center',minWidth:150,templet: function (d) {
                        if (d.changeType == '1') {
                            return '基础信息'
                        }else {
                            return '办园信息'
                        }
                    }},
                {field:'changes',title:'变更事项',align:'center',minWidth:150,},
                {field:'beforeChange',title:'变更前',align:'center',minWidth:150,},
                {field:'afterChange',title:'变更后',align:'center',minWidth:150,},
                {field:'submissionTime',title:'提交时间',align:'center'},
                {field:'auditTime',title:'审核时间',align:'center'},
                {field: 'auditDesc', title: '审核意见', align:'center',minWidth:150,},
                {field: 'attachmentName', title: '附件', align: 'center',minWidth:150, templet: function (d) {
                        var strr = ''
                        var object=d
                        if(d.attachmentList==undefined){
                            return ''
                        }else{
                            for(var i=0;i<object.attachmentList.length;i++){
                                var str1 = ""
                                if( object.attachmentList[i].attUrl != undefined ){
                                    var fileExtension=object.attachmentList[i].attachName.substring(object.attachmentList[i].attachName.lastIndexOf(".")+1,object.attachmentList[i].attachName.length);
                                    str1 = '' +
                                        '<div class="dech" deurl="' +object.attachmentList[i].attUrl + '">' +
                                        '<a href="/download?' + object.attachmentList[i].attUrl + '" name="'+object.attachmentList[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                        '<img src="/img/attachment_icon.png">' + object.attachmentList[i].attachName + '</a>' +
                                        '' +
                                        // '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png">' +
                                        '<input type="hidden" class="inHidden" value="' + object.attachmentList[i].aid + '@' + object.attachmentList[i].ym + '_' + object.attachmentList[i].attachId +',">' +
                                        '<a fileExtension="'+fileExtension+'"onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                        '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                        '<a style="padding-left: 5px" href="/download?' + object.attachmentList[i].attUrl + '">' +
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

                    }},
                {title:'操作',toolbar:'#barDemos',minWidth:200,align:'center'},
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


        $(document).on("click", "#people1", function () {
            org_id="people1";
            $.popWindow("../common/selectPartyMember?0");
        })


        $(document).on("click","#submit",function(){
            layer.close('page')
        })
        table.on('tool(test1)', function (obj) {
            var data = obj.data;
            if (obj.event === 'detail1') {
                layer.open({
                    type: 1
                    , title: '查看'
                    , area: ['60%', '80%'],
                    content: '<div class="layui-tab-item layui-show">\n' +
                        '                <div>\n' +
                        '                    <form class="layui-form" action="">\n' +
                        '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                        '                            <label class="layui-form-label">申请人</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="applicants" disabled="disabled" name="applicant" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                        <div class="layui-inline" style="margin-left: 10%">\n' +
                        '                            <label class="layui-form-label">机构简称</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="orgName" disabled="disabled" name="orgName" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                    </form></div>\n' +
                        '                <div>\n' +
                        '                    <form class="layui-form" action="">\n' +
                        '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                        '                            <label class="layui-form-label">变更类型</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="changeType" disabled="disabled" name="changeType" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                        <div class="layui-inline" style="margin-left: 10%">\n' +
                        '                            <label class="layui-form-label">变更事项</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="changes" disabled="disabled" name="changes" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                    </form></div>\n' +
                        '                <div>\n' +
                        '                    <form class="layui-form" action="">\n' +
                        '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                        '                            <label class="layui-form-label">变更前</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="beforeChange" disabled="disabled" name="beforeChange" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                        <div class="layui-inline" style="margin-left: 10%">\n' +
                        '                            <label class="layui-form-label">变更后</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="afterChange" disabled="disabled" name="afterChange" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                    </form></div>\n' +
                        '                <div>\n' +
                        '                    <form class="layui-form" action="">\n' +
                        '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                        '                            <label class="layui-form-label">提交时间</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="submissionTime" disabled="disabled" name="submissionTime" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                        <div class="layui-inline" style="margin-left: 10%">\n' +
                        '                            <label class="layui-form-label">变更原因</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="changeReason" disabled="disabled" name="changeReason" class="layui-input" type="text" style="border: none">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                                            <div class="layui-inline" style="width:100%">\n' +
                        '                                                <label class="layui-form-label"style="margin-left: 5%;">附件</label>\n' +
                        '                                               <div class="layui-input-block" style="padding-top: 9px">\n' +
                        '                                                   <div id="fileAllAgendas1" style="text-align: left;"></div>\n' +
                        '                                                   <a href="javascript:;" class="openFile" style="float: left;position:relative;margin-top:9px">\n' +
                        '                                                   </a>\n' +
                        '                                                </div>' +
                        '                                                </div>' +
                        '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                        '                            <label class="layui-form-label">审核时间</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="auditTime" disabled="disabled" name="auditTime" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                    </form></div>\n' +
                        '                <div>\n' +
                        '                    <form class="layui-form" action="">\n' +
                        '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                        '                            <label class="layui-form-label">审核意见</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="auditDesc" disabled="disabled" name="auditDesc" class="layui-input" type="text" style="border: none">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                    </form></div>\n' +
                        '                <div style="margin-top: 30px;text-align: center">\n' +
                        '                    <button class="layui-btn" id="return" type="button">返回</button>\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '            <div>\n' +
                        '            </div>\n' +
                        '        </div>'
                    ,
                    success: function () {
                        $('#changes').val(data.changes);
                        $('#beforeChange').val(data.beforeChange);
                        $('#orgName').val(data.orgName);
                        $('#submissionTime').val(data.submissionTime);
                        $('#afterChange').val(data.afterChange);
                        $('#applicants').val(data.applicant);
                        $('#auditTime').val(data.auditTime);
                        $('#auditDesc').val(data.auditDesc);
                        $('#changeReason').val(data.changeReason);
                        if(data.changeType=='1'){
                            $('#changeType').val('基础信息');
                        }else if(data.changeType=='2'){
                            $('#changeType').val('办园信息');
                        }

                        var strr = ''
                        if((data.attachmentList[0] != undefined && data.attachmentList.length>0)){
                            for(var i=0;i<data.attachmentList.length;i++){
                                var str1 = ""
                                var fileExtension=data.attachmentList[i].attachName.substring(data.attachmentList[i].attachName.lastIndexOf(".")+1,data.attachmentList[i].attachName.length);
                                if( data.attachmentList[i].attUrl != undefined ){
                                    str1 = '<div class="dech" deurl="' +data.attachmentList[i].attUrl + '">' +
                                        '<a href="/download?' + data.attachmentList[i].attUrl + '" name="'+data.attachmentList[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                        '<img src="/img/attachment_icon.png">' + data.attachmentList[i].attachName + '</a>' +
                                        // '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png">' +
                                        '<input type="hidden" class="inHidden" value="' + data.attachmentList[i].aid + '@' + data.attachmentList[i].ym + '_' + data.attachmentList[i].attachId +',">' +
                                        '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                        '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                        '<a style="padding-left: 5px" href="/download?' + data.attachmentList[i].attUrl + '">' +
                                        '<img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">下载</a>\n' +
                                        '</div>' +
                                        '</div>'
                                }else{
                                    str1 = '';
                                }
                                strr += str1;
                            }
                        }else {
                            strr='';
                        }
                        $('#fileAllAgendas1').html(strr);
                       // $('#licenceId').val(data.licenceName);
                        $("#return").click(function() {
                            layer.closeAll();
                        })
                        form.render()

                    },

                })
            }else if(obj.event === 'detail2'){
                layer.open({
                    type: 1
                    , area: ['60%', '80%'],
                    content: '<div class="layui-tab-item layui-show">\n' +
                        '                <div>\n' +
                        '                    <form class="layui-form" action="">\n' +
                        '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                        '                            <label class="layui-form-label">申请人</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="applicants" disabled="disabled" name="applicant" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                        <div class="layui-inline" style="margin-left: 10%">\n' +
                        '                            <label class="layui-form-label">机构简称</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="orgName" disabled="disabled" name="orgName" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                    </form></div>\n' +
                        '                <div>\n' +
                        '                    <form class="layui-form" action="">\n' +
                        '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                        '                            <label class="layui-form-label">变更类型</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="changeType" disabled="disabled" name="changeType" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                        <div class="layui-inline" style="margin-left: 10%">\n' +
                        '                            <label class="layui-form-label">变更事项</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="changes" disabled="disabled" name="changes" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                    </form></div>\n' +
                        '                <div>\n' +
                        '                    <form class="layui-form" action="">\n' +
                        '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                        '                            <label class="layui-form-label">变更前</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="beforeChange" disabled="disabled" name="beforeChange" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                        <div class="layui-inline" style="margin-left: 10%">\n' +
                        '                            <label class="layui-form-label">变更后</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="afterChange" disabled="disabled" name="afterChange" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                    </form></div>\n' +
                        '                <div>\n' +
                        '                    <form class="layui-form" action="">\n' +
                        '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                        '                            <label class="layui-form-label">提交时间</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="submissionTime" disabled="disabled" name="submissionTime" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                        <div class="layui-inline" style="margin-left: 10%">\n' +
                        '                            <label class="layui-form-label">变更原因</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="changeReason" disabled="disabled" name="changeReason" class="layui-input" type="text" style="border: none">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                                            <div class="layui-inline" style="width:100%">\n' +
                        '                                                <label class="layui-form-label"style="margin-left: 5%;">附件</label>\n' +
                        '                                               <div class="layui-input-block" style="padding-top: 9px">\n' +
                        '                                                   <div id="fileAllAgendas1" style="text-align: left;"></div>\n' +
                        '                                                   <a href="javascript:;" class="openFile" style="float: left;position:relative;margin-top:9px">\n' +
                        '                                                   </a>\n' +
                        '                                                </div>' +
                        '                                                </div>' +
                        '                    </form></div>\n' +
                        '                <div>\n' +
                        '                    <form class="layui-form" action="">\n' +
                        '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                        '                            <label class="layui-form-label">审核意见</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="auditDesc"  name="auditDesc" class="layui-input" type="text" >\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                    </form></div>\n' +
                        '                <div style="margin-top: 30px;text-align: center">\n' +
                        '                     <button class="layui-btn" id="save1" type="button">确定</button><button class="layui-btn" id="return" type="button">取消</button>\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '            <div>\n' +
                        '            </div>\n' +
                        '        </div>'
                    ,
                    success: function () {
                        $('#changes').val(data.changes);
                        $('#beforeChange').val(data.beforeChange);
                        $('#orgName').val(data.orgName);
                        $('#submissionTime').val(data.submissionTime);
                        $('#afterChange').val(data.afterChange);
                        $('#applicants').val(data.applicant);
                        $('#auditDesc').val(data.auditDesc);
                        $('#changeReason').val(data.changeReason);
                        if(data.changeType=='1'){
                            $('#changeType').val('基础信息');
                        }else if(data.changeType=='2'){
                            $('#changeType').val('办园信息');
                        }

                        var strr = ''
                        if((data.attachmentList!= undefined && data.attachmentList[0] != undefined && data.attachmentList.length>0)){
                            for(var i=0;i<data.attachmentList.length;i++){
                                var str1 = ""
                                var fileExtension=data.attachmentList[i].attachName.substring(data.attachmentList[i].attachName.lastIndexOf(".")+1,data.attachmentList[i].attachName.length);
                                if( data.attachmentList[i].attUrl != undefined ){
                                    str1 = '<div class="dech" deurl="' +data.attachmentList[i].attUrl + '">' +
                                        '<a href="/download?' + data.attachmentList[i].attUrl + '" name="'+data.attachmentList[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                        '<img src="/img/attachment_icon.png">' + data.attachmentList[i].attachName + '</a>' +
                                        // '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png">' +
                                        '<input type="hidden" class="inHidden" value="' + data.attachmentList[i].aid + '@' + data.attachmentList[i].ym + '_' + data.attachmentList[i].attachId +',">' +
                                        '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                        '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                        '<a style="padding-left: 5px" href="/download?' + data.attachmentList[i].attUrl + '">' +
                                        '<img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">下载</a>\n' +
                                        '</div>' +
                                        '</div>'
                                }else{
                                    str1 = '';
                                }
                                strr += str1;
                            }
                        }else {
                            strr='';
                        }
                        $('#fileAllAgendas1').html(strr);
                        // $('#licenceId').val(data.licenceName);
                        form.render()
                        $("#save1").click(function() {
                            if($('#auditDesc').val()==''||$('#auditDesc').val()==undefined){
                                layer.msg('请填写审批意见',{icon:0})
                                return false
                            }
                            $.ajax({
                                type: 'post',
                                url: '/EduorgMessage/updateAuditStatus?orgId='+data.orgId,
                                dataType: 'json',
                                data: {
                                    auditDesc: $("#auditDesc").val(),
                                    auditStatus: '1',
                                    infoAuditId: data.infoAuditId
                                },
                                success: function (json) {
                                    $.layerMsg({content: '同意成功！', icon: 1}, function () {
                                        layer.closeAll();
                                        location.reload();
                                    })
                                }
                            })
                            layer.closeAll();
                        })
                        $("#return").click(function() {
                            layer.closeAll();
                        })
                        form.render()

                    },

                })

            }else if(obj.event === 'detail3'){
                layer.open({
                    type: 1
                    , area: ['60%', '80%'],
                    content: '<div class="layui-tab-item layui-show">\n' +
                        '                <div>\n' +
                        '                    <form class="layui-form" action="">\n' +
                        '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                        '                            <label class="layui-form-label">申请人</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="applicants" disabled="disabled" name="applicant" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                        <div class="layui-inline" style="margin-left: 10%">\n' +
                        '                            <label class="layui-form-label">机构简称</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="orgName" disabled="disabled" name="orgName" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                    </form></div>\n' +
                        '                <div>\n' +
                        '                    <form class="layui-form" action="">\n' +
                        '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                        '                            <label class="layui-form-label">变更类型</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="changeType" disabled="disabled" name="changeType" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                        <div class="layui-inline" style="margin-left: 10%">\n' +
                        '                            <label class="layui-form-label">变更事项</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="changes" disabled="disabled" name="changes" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                    </form></div>\n' +
                        '                <div>\n' +
                        '                    <form class="layui-form" action="">\n' +
                        '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                        '                            <label class="layui-form-label">变更前</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="beforeChange" disabled="disabled" name="beforeChange" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                        <div class="layui-inline" style="margin-left: 10%">\n' +
                        '                            <label class="layui-form-label">变更后</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="afterChange" disabled="disabled" name="afterChange" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                    </form></div>\n' +
                        '                <div>\n' +
                        '                    <form class="layui-form" action="">\n' +
                        '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                        '                            <label class="layui-form-label">提交时间</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="submissionTime" disabled="disabled" name="submissionTime" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                        <div class="layui-inline" style="margin-left: 10%">\n' +
                        '                            <label class="layui-form-label">变更原因</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="changeReason" disabled="disabled" name="changeReason" class="layui-input" type="text" style="border: none">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                                            <div class="layui-inline" style="width:100%">\n' +
                        '                                                <label class="layui-form-label"style="margin-left: 5%;">附件</label>\n' +
                        '                                               <div class="layui-input-block" style="padding-top: 9px">\n' +
                        '                                                   <div id="fileAllAgendas1" style="text-align: left;"></div>\n' +
                        '                                                   <a href="javascript:;" class="openFile" style="float: left;position:relative;margin-top:9px">\n' +
                        '                                                   </a>\n' +
                        '                                                </div>' +
                        '                                                </div>' +
                        '                    </form></div>\n' +
                        '                <div>\n' +
                        '                    <form class="layui-form" action="">\n' +
                        '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                        '                            <label class="layui-form-label">审核意见</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="auditDesc"  name="auditDesc" class="layui-input" type="text" >\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                    </form></div>\n' +
                        '                <div style="margin-top: 30px;text-align: center">\n' +
                        '                     <button class="layui-btn" id="save1" type="button">确定</button><button class="layui-btn" id="return" type="button">取消</button>\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '            <div>\n' +
                        '            </div>\n' +
                        '        </div>'
                    ,
                    success: function () {
                        $('#changes').val(data.changes);
                        $('#beforeChange').val(data.beforeChange);
                        $('#orgName').val(data.orgName);
                        $('#submissionTime').val(data.submissionTime);
                        $('#afterChange').val(data.afterChange);
                        $('#applicants').val(data.applicant);
                        $('#auditDesc').val(data.auditDesc);
                        $('#changeReason').val(data.changeReason);
                        if(data.changeType=='1'){
                            $('#changeType').val('基础信息');
                        }else if(data.changeType=='2'){
                            $('#changeType').val('办园信息');
                        }

                        var strr = ''
                        if((data.attachmentList!= undefined && data.attachmentList[0] != undefined && data.attachmentList.length>0)){
                            for(var i=0;i<data.attachmentList.length;i++){
                                var str1 = ""
                                var fileExtension=data.attachmentList[i].attachName.substring(data.attachmentList[i].attachName.lastIndexOf(".")+1,data.attachmentList[i].attachName.length);
                                if( data.attachmentList[i].attUrl != undefined ){
                                    str1 = '<div class="dech" deurl="' +data.attachmentList[i].attUrl + '">' +
                                        '<a href="/download?' + data.attachmentList[i].attUrl + '" name="'+data.attachmentList[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                        '<img src="/img/attachment_icon.png">' + data.attachmentList[i].attachName + '</a>' +
                                        // '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png">' +
                                        '<input type="hidden" class="inHidden" value="' + data.attachmentList[i].aid + '@' + data.attachmentList[i].ym + '_' + data.attachmentList[i].attachId +',">' +
                                        '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                        '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                        '<a style="padding-left: 5px" href="/download?' + data.attachmentList[i].attUrl + '">' +
                                        '<img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">下载</a>\n' +
                                        '</div>' +
                                        '</div>'
                                }else{
                                    str1 = '';
                                }
                                strr += str1;
                            }
                        }else {
                            strr='';
                        }
                        $('#fileAllAgendas1').html(strr);
                        // $('#licenceId').val(data.licenceName);
                        form.render()
                        $("#save1").click(function() {
                            if($('#auditDesc').val()==''||$('#auditDesc').val()==undefined){
                                layer.msg('请填写审批意见',{icon:0})
                                return false
                            }
                            $.ajax({
                                type: 'post',
                                url: '/EduorgMessage/updateAuditStatus?orgId='+data.orgId,
                                dataType: 'json',
                                data: {
                                    auditDesc: $("#auditDesc").val(),
                                    auditStatus: '1',
                                    infoAuditId: data.infoAuditId
                                },
                                success: function (json) {
                                    $.layerMsg({content: '不同意成功！', icon: 1}, function () {
                                        layer.closeAll();
                                        location.reload();
                                    })
                                }
                            })
                            layer.closeAll();
                        })
                        $("#return").click(function() {
                            layer.closeAll();
                        })
                        form.render()

                    },

                })
            }

        })
    });


</script>
</html>
