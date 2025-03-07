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
    <link rel="stylesheet" type="text/css" href="../lib/laydate/skins/default/laydate.css"/>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" type="text/css" href="../../css/dept/deptManagement.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/dept/new_news.css"/>
    <script type="text/javascript" src="../../js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <title>日志查询权限设置</title>
    <style>
        .newNew tr td{
            border:none;
        }
        .newNew .tableHead tr td{
            border:1px solid #c0c0c0;
        }
        .ban{
            width: 80px;
            height: 28px;
            padding-left: 10px;
        }
        .close_but{
            width:50px;
            height: 37px;
            margin-left:0px;
            line-height: 28px;
            border-radius: 4px;
            padding-left: 4px;
            cursor: pointer;
            /*color:#fff;*/
        }
        .success span{
            width: 132px;
            height: 35px;
            background-color: rgba(224, 224, 224, 0.61);
            font-size: 16px;
            border-radius: 5px;
            padding-left:8px;
            cursor:pointer;

            line-height: 30px;
            display: inline-block;
        }
        #save{
            background:url(../../img/vote/saveBlue.png) no-repeat;
            color:#fff;
            line-height:30px;
            font-size:16px;
            width:91px;
            height: 30px;
            cursor: pointer;
            padding-left: 11px;

        }
        table tbody tr td{
            font-size: 11pt !important;
        }
        .nav li {
            height: 33px;
            line-height: 32px;
            float: left;
            font-size: 14px;
            margin-left: 20px;
            margin-top: 6px;
            cursor: pointer;
        }
        .release3 {
            display: inline-block;
            font-size: 14px;
            color: #207bd6;
            margin-left: 10px;
            cursor: pointer;
            margin-top: 0px;
            margin-right: 20px;
        }
        .head-top {
            width: 100%;
            position: fixed;
            top: 0px;
            left: 0px;
            height: 45px;
            border-bottom: 1px solid #999;
            background: #fff;
            overflow: hidden;
            z-index: 9999999;
        }
        .head-top ul .head-top-li.active {
            background: #2F8AE3;
            color: #fff;
        }
        .head-top ul .head-top-li {
            height: 26px;
            line-height: 26px;
            margin: 10px 11px 0px 11px;
            padding: 1px 20px;
            font-size: 14px;
            border-radius: 20px;
            cursor: pointer;
        }
        .navigation input{
            width: 200px;
            margin-left: 10px;
        }
        .hieraTable th,td {
            text-align: center;
        }
        .hieraTable thead {
            background: white;
            line-height: 40px;
            border-bottom: 1px #dddddd solid;
            font-size: 13pt;
            color: #2F5C8F;
            font-weight: bold;
            border: 0px;
        }
        .submit{
            border: 1px solid #ada6a6;
            padding: 3px 10px;
            background: #e4e4e4;
        }
        .td_title1 {
            width: 300px;
        }
        #save2 {
            background: url(../../img/vote/saveBlue.png) no-repeat;
            color: #fff;
            line-height: 30px;
            font-size: 16px;
            width: 91px;
            height: 30px;
            cursor: pointer;
            padding-left: 11px;
        }
    </style>
</head>
<body style="overflow:scroll;overflow-y: auto;overflow-x:hidden;">

<div class="head-top">
    <ul class="clearfix">
        <li class="fl head-top-li" data-type="">日志设置</li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li" data-type="0">汇报设置</li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li" data-type="1">层级关系</li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li active" data-type="2">日志查询权限设置</li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li" data-type="3">移动端模板设置</li>
    </ul>
</div>
<div class="step" style="margin-top: 60px">
    <div id="Confidential"></div>
    <div class="navigation" style="margin-left: 11%;width: 79%;margin-bottom: 30px;">
        <label style="font-size: 15px;">姓名<input type="text" placeholder="" id="userName"   style="margin-right: 5px"></label>
        <label style="margin-left: 15px;font-size: 15px;">查看权限范围<input type="text" placeholder=""  readonly="readonly" id="selectReadRange" style="margin-right: 5px" onclick="selectReadRange()"></label>
        <a href="javascript:;" class="submit" id="search">搜索</a>
        <a href="javascript:;" class="submit" id="add">新建</a>
    </div>
    <div id="pagediv" style="margin-top: 80px;">
        <table class="hieraTable" style="table-layout:fixed">
            <thead>
            <tr>
                <th style="width: 20%">姓名</th>
                <th style="width: 60%;">查看权限范围</th>
                <th style="width: 20%">操作</th>
            </tr>
            </thead>
            <tbody class="list">

            </tbody>
        </table>
        <div style="margin: 0px auto 0px;height:50px;width: 97%;" class="clearfix">
            <div id="dbgz_page" class="M-box3" style="display: none">

            </div>
        </div>
    </div>
</div>
<div class="step1" style="display: none;margin-left: 10px;margin-top: 80px;">
    <table class="newNews">
        <tbody>
        <tr>
            <td class="td_w blue_text">设置人员：</td>
            <td>
                <input class="td_title1" type="text" placeholder="" id="setUser" disabled style="background-color: #e0e0e0"/>
                <div class="release3" id="user_add">选择</div>
            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">查看权限范围：</td>
            <td>
                <textarea class="td_title1" type="text" placeholder="" id="readRange" disabled style="background-color: #e0e0e0;height: 100px;border-radius: 5px;"></textarea>
                <div class="release3" id="readRange_add">添加</div>
            </td>
        </tr>
        </tbody>

        <div>
            <tr style="text-align:center">
                <td colspan="2">
                    <button type="button" class="close_but" id="save">保存</button>
                    <button type="button" class="close_but" id="save2" style="display: none">保存</button>
                    <button type="button" class="close_but" id="return" style="width: 91px;height: 30px;line-height: 30px;font-size: 16px;">返回</button>
                </td>
            </tr>
        </div>
    </table>
</div>

</body>

<script type="text/javascript">
    $('.head-top li').on("click",function () {
        $(this).siblings('li').removeClass('active')
        $(this).addClass('active')
        if($(this).attr('data-type')==''){
            window.location.href = "/diarySetting/index"
        }else if($(this).attr('data-type')=='0'){
            window.location.href = "/diarySetting/logSetting"
        }else if($(this).attr('data-type')=='1'){
            window.location.href = "/diarySetting/hierarchy"
        }else if($(this).attr('data-type')=='2'){
            window.location.href = "/diaryReadPriv/readPrivIndex"
        }else if($(this).attr('data-type')=='3'){
            window.location.href = "/diarySetting/mobileTemplate"
        }
    })
    // 选人
    function selectReadRange(){
        user_id = "selectReadRange";
        $.popWindow("../common/selectUser");
    }
    $("#user_add").on("click", function () {
        user_id = "setUser";
        $.popWindow("../common/selectUser?0");
    });
    $('#readRange_add').on("click",function () {
        user_id = 'readRange';
        $.popWindow("../common/selectUser");
    });
    //    分页列表
    var ajaxPageLe = {
        data: {
            page: 1,//当前处于第几页
            limit: 10,//一页显示几条
            useFlag: true
        },
        page: function (userName,selectReadRange) {
            var me = this;
            me.data.userIdName = userName;
            me.data.readRange = selectReadRange
            $.ajax({
                url: '/diaryReadPriv/selectAllDiaryReadPriv',
                type: 'get',
                data: me.data,
                dataType: 'json',
                success: function (reg) {
                    var datas = reg.obj;
                    var str = "";
                    for (var i = 0; i < datas.length; i++) {
                        str += '  <tr rprivId="' + datas[i].rprivId + '">' +
                            '                    <td>'+datas[i].userIdName+'</td>' +
                            '                    <td title="' + datas[i].readRangeName +'" style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;cursor: pointer">' + datas[i].readRangeName + '</td>' +
                            '                    <td>' +
                            '                        <a href="javascript:;" class="choose up"  data-type="2">修改</a>' +
                            '                        <a href="javascript:;" class="del de" >删除</a>' +
                            '                    </td>' +
                            '                </tr>'
                    }
                    $('.list').html(str);
                    if (reg.totleNum > 10) {
                        $('#dbgz_page').show();
                        me.pageTwo(reg.totleNum, me.data.limit, me.data.page)
                    } else {
                        $('#dbgz_page').hide();
                    }
                }
            })

        },
        pageTwo: function (totalData, pageSize, indexs) {
            var mes = this;
            $('#dbgz_page').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage: '',
                endPage: '',
                current: indexs || 1,
                callback: function (index) {
                    mes.data.page = index.getCurrent();
                    mes.page();
                }
            });
        }
    }
    ajaxPageLe.page();
    //删除
    $('.list').on('click', '.del', function () {
        var rprivId = $(this).parents('tr').attr('rprivId')
        layer.confirm(' 确定要删除吗', {
            btn: ['确定', '取消'], //按钮
            title: " 删除"
        }, function () {
            $.ajax({
                url: '/diaryReadPriv/deleteDiaryReadPrivById',
                type: 'post',
                dataType: 'json',
                data: {rprivId: rprivId},
                success: function () {
                    layer.msg(' 删除成功', {icon: 6});
                    ajaxPageLe.page();
                }
            })
        }, function () {
            layer.closeAll();
        })
    })
    //修改
    var rprivId;
    $('.list').on('click', '.up', function () {
        rprivId = $(this).parents('tr').attr('rprivId')
        $('.step').css('display','none')
        $('.step1').css('display','block')
        $('#save').css('display','none')
        $('#save2').css('display','inline-block')
        $.ajax({
            type: 'get',
            url: '/diaryReadPriv/selectAllDiaryReadPriv',
            dataType: 'json',
            data:{
                rprivId:rprivId
            },
            success: function (res) {
                if(res.flag){
                    var object=res.obj;
                    if(object!=undefined){
                        $("#setUser").val(object[0].userIdName+',');
                        $("#setUser").attr('user_id',object[0].userId+',');
                        $("#readRange").val(object[0].readRangeName || '');
                        $("#readRange").attr('user_id',object[0].readRange || '');
                    }
                }
            }
        })
    })
    //新建
    $('#add').on('click',function () {
        $('.step').css('display','none')
        $('.step1').css('display','block')
    })
    //搜索
    $('#search').on('click',function () {
        var userName = $('#userName').val()
        var selectReadRange = $('#selectReadRange').attr('user_id')
        ajaxPageLe.page(userName,selectReadRange);
    })
    $(function () {
        //保存
        function save(){
            var data={
                userId:$('#setUser').attr('user_id').replace(",", ""),
                readRange:$('#readRange').attr('user_id')
            };
            $.ajax({
                type: 'post',
                url: '/diaryReadPriv/addDiaryReadPriv',
                dataType: 'json',
                data: data,
                success: function (res) {
                    if(res.flag){
                        layer.msg('保存成功',{time:1000,icon:1},function () {
                            //刷新
                            window.location.reload();
                        });
                    }else{
                        layer.msg(res.msg,{time:1500,icon:2});
                    }

                }
            })
        }

        //修改
        function update(rprivId){
            var data={
                rprivId:rprivId,
                userId:$('#setUser').attr('user_id').replace(",", ""),
                readRange:$('#readRange').attr('user_id')
            };
            $.ajax({
                type: 'post',
                url: '/diaryReadPriv/updateDiaryReadPriv',
                dataType: 'json',
                data: data,
                success: function (res) {
                    if(res.flag){
                        layer.msg('保存成功',{time:1000,icon:1},function () {
                            //刷新
                            window.location.reload();
                        });
                    }else{
                        layer.msg(res.msg,{time:1500,icon:2});
                    }

                }
            })
        }

        $('#save').on("click",function () {
            save();
        });
        //修改保存
        $('#save2').on("click",function () {
            update(rprivId);
        });
        $('#return').on("click",function () {
            window.location.reload();
        });
    });

    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
            var data=res.object[0]
            if (data.paraValue!=0){
                $('#Confidential').append('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </span>')
            }
        }
    })

</script>
</html>

