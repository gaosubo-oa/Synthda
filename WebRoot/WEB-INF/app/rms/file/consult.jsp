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
    <title>档案查阅</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">
    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base.css">
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="../../lib/layui/layui/lay/dest/layui.all.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>

    <style>
        .layui-form-radio{
            margin: 3px 10px 0 0!important;
        }

        .search_input{
            box-sizing: border-box;
        }
        .jump-ipt{
            height: 25px;
        }

        .table_title {
            text-align: left;
            padding: 0 10px;
            box-sizing: border-box;
        }
    </style>
</head>
<body>
    <!-- 头部区域 -->
    <div class="headTop">
        <div class="headImg">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_documentSupervise.png" alt="">
        </div>
        <div class="divTitle">
            档案查阅
        </div>
    </div>

    <!-- 搜素区域 -->
    <div style="margin: 0 auto;margin-top: 46px;height: 60px;width: 97%;" class="clearfix">
        <div class="fl" style="margin-top: 16px;">
            选择卷库：
            <select name="room" id="room" >
                <option value=""><fmt:message code="hr.th.PleaseSelect"/></option>
            </select>

            选择案卷：
            <select name="roll" id="roll">
                <option value=""><fmt:message code="hr.th.PleaseSelect"/></option>
            </select>

            文件标题关键字：<input name="rollName" class="search_input"/>

            发文单位：<input name="sendUnit" class="search_input"/>

            文件号：<input name="file" class="search_input"/>

            <button  type="button" class="Query fl"  style="float:right;"><fmt:message code="global.lang.query"/></button>
        </div>
    </div>

    <!-- 列表内容 -->
    <div class="pagediv" style="margin: 0 10px;">
        <table>
            <thead>
            <tr>
                <th class="table_title" style="width: 200px;">文件号</th>
                <th class="table_title" style="width: 230px;">文件标题</th>
                <th class="table_title" style="width: 150px;">发文单位</th>
                <th class="table_title" style="width: 100px;">发文时间</th>
                <th class="table_title" style="width: 90px;">密级</th>
                <th class="table_title" style="width: 100px;">紧急等级</th>
                <th class="table_title" style="width: 90px;">操作</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <div id="dbgz_page" class="M-box3 fr" style="margin-top: 40px;">

        </div>
    </div>

    <script>
        ;!function(){
            //当使用了 layui.all.js，无需再执行layui.use()方法
            var form = layui.form()
                ,layer = layui.layer;

        }();

        // 加载列表数据
        var ajaxPage={
            data:{
                page:1,
                pageSize:10,
                useFlag:true
            },
            page:function () {
                var me=this;
                this.data.room=$('[name="room"]').val();
                this.data.roll=$('[name="roll"]').val();
                this.data.rollName=$('input[name="rollName"]').val();
                this.data.sendUnit=$('input[name="sendUnit"]').val();
                this.data.file=$('input[name="file"]').val();
                $.get('/rmsFile/leaderQuery',me.data,function (json) {

                    var str='';
                    var arr=json.obj;
                    for(var i=0;i<arr.length;i++){
                        str+='<tr>' +
                            '<td style="text-align: left;">'+arr[i].fileCode+'</td>'+
                            '<td title="'+arr[i].fileTitle+'" style="width: 30%;max-width: 230px; text-align: left;"><div>'+arr[i].fileTitle+'</div></td>' +
                            '<td style="text-align: left;">'+arr[i].sendUnit+'</td>' +
                            '<td style="text-align: left;">'+(arr[i].sendDate ? arr[i].sendDate: "")+'</td>' +
                            '<td style="text-align: left;">'+arr[i].secretName+'</td>' +
                            '<td style="text-align: left;">'+arr[i].urgencyName+'</td>' +
                            '<td style="text-align: left;">' +
                            '<a href="javascript:void(0)" class="oversee" data-id="'+arr[i].fileId+'">查阅</a>' +
                            '</td>' +
                            '</tr>'
                    }
                    $('.pagediv table tbody').html(str)
                    me.pageTwo(json.totleNum,me.data.pageSize,me.data.page)

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
                    }
                });
            }
        }


        // 点击查询
        $('.Query').on('click',function () {
            ajaxPage.data.page=1;
            ajaxPage.page()
        })

        // 获取卷库列表
        $.get('/rmsRollRoom/selectAll',function (res) {
            if (res.flag && res.obj.length > 0) {
                var str='';
                res.obj.forEach(function(item){
                    str+='<option value="'+item.roomId+'">'+item.roomName+'</option>'
                })
                $('#room').append(str);
                $('#room').val('4');

                $.get('/rmsRoll/query',{roomId: '4'}, function (res) {
                    var rstr = '<option value=""><fmt:message code="hr.th.PleaseSelect"/></option>';
                    if (res.flag && res.obj.length > 0) {
                        res.obj.forEach(function(item){
                            rstr+='<option value="'+item.rollId+'">'+item.rollName+'</option>'
                        });

                    }
                    $('#roll').html(rstr);
                    $('#roll').val('7');

                    ajaxPage.page();
                });
            }
        });

        // 选择卷库后获取对应案卷列表
        $('#room').on('change', function(){
            var roomId = $(this).val();
            $('#roll').empty();
            var str='<option value=""><fmt:message code="hr.th.PleaseSelect"/></option>';
            if (roomId && roomId != '') {
                $.get('/rmsRoll/query',{roomId: roomId}, function (res) {
                    if (res.flag && res.obj.length > 0) {
                        res.obj.forEach(function(item){
                            str+='<option value="'+item.rollId+'">'+item.rollName+'</option>'
                        });
                    }
                    $('#roll').html(str);
                });
            } else {
                $('#roll').html(str);
            }
        });

        // 点击查阅
        $('.pagediv').on('click', '.oversee', function(){
            layer.open({
                type: 2,
                title: false,
                shadeClose: true,
                shade: 0.5,
                maxmin: true, //开启最大化最小化按钮
                area: ['953px', '90%'],
                content:'/rmsFile/detail?fileId='+$(this).data("id"),
                end:function(){

                },
                cancel:function(index){

                }
            });
        });

    </script>
</body>
</html>
