<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>借阅记录</title>
    <link rel="stylesheet" type="text/css" href="../lib/laydate/skins/default/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <script src="/js/common/language.js"></script>
<%--    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/laydate/laydate.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/js/jquery/jquery.form.min.js"></script>
    <style>
        .buttonDiv .deleteBtn{
            width: 112px;
            height: 28px;
            margin: 20px auto;
            background: url("../img/btn_deletecontent_03.png") no-repeat;
            line-height: 28px;
            cursor: pointer;
        }
        .editMange input[type="text"]{
            width: 260px;
            height: 30px;
        }
        select{
            width: 260px;
            height: 30px;
        }
        textarea{
            width: 260px;
            height: 50px;
            vertical-align: middle;
        }
        a{
            text-decoration: none;
            color: #207bd6;
        }
        .bx{
            height: 100%;
        }
        .newTbale tr td{
            border-right: #ccc 1px solid;
            padding: 5px;
        }
        #tr_td{
            width: 96%;
            margin: 10px auto;
        }
        #tr_td tr:nth-child(odd){
            background-color: #fff;
        }

        #tr_td .th{
            font-size: 13pt;
            text-align: center;
        }
        #trList tr td {
            font-size: 11pt;
            text-align: center;
        }
        .mainContent{
            border-top: #ccc 1px solid;
        }
        .mainLeft{
            height: 100%;
            width: 208px;
            float: left;
            border-right: #ccc 1px solid;
        }
        .mainLeft ul,.mainLeft li{
            width: 100%;
        }
        .mainLeft li{
            height: 45px;
            line-height: 45px;
            font-size: 11pt;
            text-align: center;
            border-bottom: #ccc 1px solid;
            cursor: pointer;
        }
        .mainLeft li:hover{
            background: #add2f8;
            color: #000;
            font-weight: bold;
        }
        .on{
            background: #add2f8;
            color: #000;
            font-weight: bold;
        }
        .mainRight{
            float: left;
        }
        .backBtn{
            float: right;
            width: 50px;
            height: 30px;
            background: #3c92e5;
            color: #ffffff;
            line-height: 30px;
            text-align: center;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 2%;
            margin-top: 25px;
        }
        .deleteData{
            color: red;
        }
    </style>
</head>

<body>
<div class="bx">
    <div class="navigation  clearfix juMange" id="juMange" style="display: block;">
        <div class="left" style="margin-left: 30px;width: 40%;margin-bottom: 20px;">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_jieyuejilu.png" style="margin-top: 19px;">
            <div class="news">
                <span>借阅记录</span>
            </div>

        </div>
        <div class="backBtn" style="display: none;">返回</div>
    </div>
    <div style="clear: both;"></div>
    <div class="mainContent">
        <div class="mainLeft" id="mainleft">
            <ul id="liValue">
                <li class="on " id="ons"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_daipizhun.png" style="margin-right: 10px;" alt="">待批准借阅</li>
                <li ><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_yipizhun.png" style="margin-right: 10px;" alt="">已批准借阅</li>
                <li><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_weipizhun.png" style="margin-right: 10px;" alt="">未批准借阅</li>
                <li><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_yiguihuan.png" style="margin-right: 10px;" alt="">已归还借阅</li>
            </ul>
        </div>
        <div id="pagediv">

        </div>
        <div class="mainRight">
            <input type="hidden" name="borrowType" value="0">
            <table id="tr_td">
                <thead>
                <tr>
                    <td class="th">
                        案卷/文件
                    </td>
                    <td class="th">
                        申请时间
                    </td>
                    <td class="th">
                        审批时间
                    </td>
                    <td class="th">
                        归还时间
                    </td>
                    <td class="th" style="width: 100px;">
                        状态
                    </td>
                    <td class="th" style="width: 150px;">
                        <fmt:message code="notice.th.operation"/>
                    </td>
                </tr>
                </thead>
                <tbody id="trList">

                </tbody>
            </table>
            <div class="right" style="float: right;margin-right: 2%;">
                <!-- 分页按钮-->
                <div class="M-box3" id="dbgz_page"></div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">

    // window.onload = function(){
    //         $('#ons').click()
    // }
    var daObj={
        allow:0,
        page:1,//当前处于第几页
        pageSize:10,//一页显示几条
    }
    $(function () {
        var jieyueFileId=getQueryString('fileId');
        var mainHeight=$('.bx').height()-$('#juMange').height()-1;
        $('.mainContent').height(mainHeight);
        var mainWidth=$('.mainContent').width()-359;
        $('.mainRight').width(mainWidth);
        $('.mainRight').height(mainHeight);
        if(jieyueFileId != '' && jieyueFileId != undefined){
            $('.backBtn').show();

            dataList($('#trList'),daObj,'/RmsLendController/queryByCount');
        }else{
            $('.backBtn').hide();
            dataList($('#trList'),daObj,'/RmsLendController/queryByCount');
        }
//        点击返回
        $('.backBtn').on('click',function () {
            $('#iframeShow',parent.document).hide();
            $('#juMange',parent.document).show();
            $('#iframeShow',parent.document).find('#iframeThr').attr('src','');
        })
//        dataList($('#trList'),daObj,'/RmsLendController/selRmsLend');
        $('.mainLeft li').on('click',function () {
            $(this).addClass('on').siblings().removeClass('on');
            var index=$(this).index();
            $('input[name="borrowType"]').val(index);
            daObj.allow=index;
            dataList($('#trList'),daObj,'/RmsLendController/queryByCount');
        });
//      文件详情
        $('#trList').on('click','.to_detail',function () {
            var editId=$(this).parents('tr').attr('data-id');
            $.popWindow('/rmsFile/detail?fileId='+editId);
        });
//        点击撤销
//        $('#trList').on('click','.revokeData',function () {
//            var lendId=$(this).parents('tr').attr('data-id');
////            var borrowType=$('input[name="borrowType"]').val();
//            daObj.allow=$('input[name="borrowType"]').val();
//            deleteAndRevoke(lendId,'0',daObj);
//        });
//        点击操作-详情-查看案卷
        $('#trList').on('click','.checkData',function () {
            // var lendId=$(this).parents('tr').attr('data-id'); //借阅id
            // $.popWindow('/RmsLendController/borrowingTheQuery?lendId='+lendId);
            // var editId=$(this).parents('tr').attr('data-id');
            var rollId=$(this).parents('tr').attr('data-id');
            $.popWindow('/rmsRoll/lookFile?rollId='+rollId);
        });
//        点击操作-详情-查看文件
        $('#trList').on('click','.checkDatas',function () {
            var fileId=$(this).parents('tr').attr('id');
            $.popWindow('/rmsFile/detail?fileId='+fileId);


        });




//        点击删除
        $('#trList').on('click','.deleteData',function () {
            var lendId=$(this).parents('tr').attr('data-ids');
            layer.confirm(qued,{
                btn: [sure,cancel], //按钮
                title:'确定撤销？'
            }, function(){
                $.ajax({
                    type:'post',
                    url:'/RmsLendController/deleteFlag',
                    dataType:'json',
                    data:{'lendId':lendId},
                    success: function (json) {
                        //第三方扩展皮肤
                        layer.msg('<fmt:message code="workflow.th.delsucess" />', {icon: 6});
                        location.reload();
                    }
                })
            }, function () {
                layer.closeAll();
            })
        });
//        点击归还
       $('#trList').on('click','.returnData',function () {
           var lendId=$(this).parents('tr').attr('data-ids');
//            var borrowType=$('input[name="borrowType"]').val();
           daObj.allow=$('input[name="borrowType"]').val();
           layer.confirm('确定要归还该文件吗？', {
               btn: [sure,cancel], //按钮
               title:'归还'
           }, function(){
               $.ajax({
                   type:'post',
                   url:'/RmsLendController/modifyRmsLendById',
                   dataType:'json',
                   data:{
                       lendId:lendId,
                       allow:3
                   },
                   success:function(res){
                       if(res.flag){
                           layer.msg('归还成功！', { icon:6});
                           // dataList($('#trList'),daObj,'/RmsLendController/selRmsLend');
                           location.reload();
                       }else{
                           layer.msg('归还失败！', { icon:5});
                       }
                   }
               });
           }, function(){
               layer.closeAll();
           });
       });


    })


    function deleteAndRevoke(dataId,dType,browType) {
        var titleTxt='';
        var title2='';
        if(dType == '0'){
            titleTxt='确定要撤销该项借阅吗？';
            title2='撤销';
        }else {
            titleTxt='确定要删除该项借阅吗？';
            title2='删除';
        }
        layer.confirm(titleTxt, {
            btn: [sure,cancel], //按钮
            title:title2
        }, function(){
            $.ajax({
                type:'post',
                url:'/RmsLendController/modifyRmsLendById',
                dataType:'json',
                data:{
                    lendId:dataId,
                    deleteFlag:1
                },
                success:function(res){
                    if(res.flag){
                        if(dType == '0'){
                            layer.msg('撤销成功！', { icon:6});
                        }else {
                            layer.msg('删除成功！', { icon:6});
                        }
                        dataList($('#trList'),browType,'/RmsLendController/selectByCount');
                    }else{
                        if(dType == '0'){
                            layer.msg('撤销失败！', { icon:5});
                        }else {
                            layer.msg('删除失败！', { icon:5});
                        }
                    }
                }
            });

        }, function(){
            layer.closeAll();
        });
    }



    function dataList(element,dataObject,url) {
        // $("#liValue li").click(function () {
        //    var  vname = $(this).text();
        // })

        var ajaxPage={
            data:dataObject,
            page:function () {
                element.find('tr').remove();
                var me=this;
                $.ajax({
                    type:'get',
                    url:url,
                    dataType:'json',
                    data:me.data,
                    success:function(res) {
                        var datas=res.obj;
                        var str='';
                        var allDate='0000-00-00 00:00:00';
                        if(datas.length >= 1){
                            for(var i=0;i<datas.length;i++){
                                str+='<tr data-id="'+datas[i].rollId+'"  id="'+datas[i].fileId+'" data-ids="'+datas[i].lendId+'" >' +

                                    '<td id="'+datas[i].type+'">'+datas[i].name+'</td>' +


                                    '<td>'+function () {
                                        if(datas[i].lendTime != undefined && datas[i].lendTime != ''){
                                            // 格式化时间为 'YYYY/MM/DD mm:dd:ss'  否则ie下 new Date() 方法会出错
                                            var dateStr = datas[i].lendTime.substr(0, datas[i].lendTime.length-2).replace(/-/g,"/");
                                            return new Date(dateStr).Format('yyyy-MM-dd hh:mm:ss');
                                        }else{
                                        return allDate;
                                    }
                                    }()+'</td>' +
                                    '<td>'+function () {
                                        if(datas[i].allowTime != undefined){
                                            var dateStr = datas[i].allowTime.substr(0, datas[i].lendTime.length-2).replace(/-/g,"/");
                                            return new Date(dateStr).Format('yyyy-MM-dd hh:mm:ss');
                                        }else{
                                            return allDate;
                                        }
                                    }()+'</td>' +
                                    '<td>'+function () {
                                        if(datas[i].returnTime != undefined){
                                            var dateStr = datas[i].returnTime.substr(0, datas[i].lendTime.length-2).replace(/-/g,"/");
                                            return new Date(dateStr).Format('yyyy-MM-dd hh:mm:ss');
                                        }else{
                                            return allDate;
                                        }
                                    }()+'</td>' +
                                    '<td>'+function () {
                                            if(datas[i].allow == '0' ){
                                                return '未审核';
                                            } else if(datas[i].allow == '1'){
                                                return '已批准';
                                            }else if(datas[i].allow == '2'){
                                                return '未批准';
                                            }else if (datas[i].allow == '3') {
                                                return '已收回';
                                            }else{
                                                return   ' ' ;
                                            }
                                    }()+'</td>' +
                                    '<td>'+function () {

                                        if(dataObject.allow != 1){

                                                return '<a class="deleteData" style="cursor: pointer">撤销</a>'


                                        }
                                        if(dataObject.allow == 1){


                                            if(datas[i].type ==1 ){
                                                return '<a class="checkData" style="cursor: pointer">查看案卷</a>&nbsp;&nbsp;<a style="cursor: pointer" class="returnData">归还</a>&nbsp;&nbsp;<a class="deleteData" style="cursor: pointer;display: none;">删除</a>'
                                            }
                                            if(datas[i].type ==0 ){
                                                return '<a class="checkDatas" style="cursor: pointer">查看文件</a>&nbsp;&nbsp;<a style="cursor: pointer" class="returnData">归还</a>&nbsp;&nbsp;<a class="deleteData" style="cursor: pointer;display: none;">删除</a>'
                                            }
                                        }

                                    }()+'</td>' +
                                    '</tr>'

                            }
                        }else{
                            str='<tr>' +
                                '<td colspan="5"><img src="/img/rms/shouyekong.png" alt=""><p>暂无数据</p></td>' +
                                '</tr>'
                        }
                        element.html(str);
                        me.pageTwo(res.totleNum,me.data.pageSize,me.data.page)
                        // $(".nos").click(function(){
                        //     $("td").removeClass("todetail");
                        // });

                        $(".todetail").on('click',function(){
                            var type=$(this).attr('id');

                            if(type ==1 ){
                                var rollId=$(this).parents('tr').attr('data-id');
                                $.popWindow("/rmsRoll/detail?rollId="+rollId);
                            }
                            if(type ==0 ){
                                var fileId=$(this).parents('tr').attr('id');
                                $.popWindow('/rmsFile/detail?fileId='+fileId);

                            }
                        });

                        // $('#tr_td').on('click','.todetail',function(){
                        //     var type=$(this).attr('id');
                        //
                        //         if(type ==1 ){
                        //             var rollId=$(this).parents('tr').attr('data-id');
                        //             $.popWindow("/rmsRoll/detail?rollId="+rollId);
                        //         }
                        //         if(type ==0 ){
                        //             var fileId=$(this).parents('tr').attr('id');
                        //             $.popWindow('/rmsFile/detail?fileId='+fileId);
                        //
                        //         }
                        //
                        // });
                    }
                })

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
        };
        ajaxPage.page();
    }

    function getQueryString(name) {
        var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
        var r = window.location.search.substr(1).match(reg);
        if (r != null) {
            return unescape(r[2]);
        }
        return null;
    }
</script>
</body>
</html>
