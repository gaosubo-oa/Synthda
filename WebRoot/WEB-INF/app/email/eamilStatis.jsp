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
    <title><fmt:message code="adding.th.emailCoun" /></title><%--邮件统计--%>
<%--    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" charset="utf-8" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" charset="utf-8" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" href="/lib/layui/layuiadmin/layui//css/layui.css">
    <script src="/lib/layui/layuiadmin/layui/layui.js" type="text/javascript" charset="utf-8"></script>
    <style type="text/css">
        *{margin: 0;padding: 0;}
        body{font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;font-size: 10pt;width: 100%;}
        .content{
            width: 100%;
        }
        select{
            width: 200px;
            height: 30px;
            outline: none;
            border-radius: 4px;
        }
        .header{
            width: 100%;
            /*margin-left: 10px;*/
            /*margin-top: 10px;*/
        }
        #selectYear{
            margin-right: 20px;
            margin-top: 52px;
        }
        .mainCon{
            width: 100%;
        }
        .mainCon table{
            width: 99%;
            margin: 20px auto;
        }
        .mainCon table tr{
            border: #ccc 1px solid;
        }
        .mainCon table tr th{
            padding: 8px;
            color: #2F5C8F;
            font-size: 13pt;
        }
        .mainCon table tr td{
            padding: 8px;
            text-align: left;
            font-size: 11pt;
        }
        .mainCon table tr td a{
            text-decoration: none;
            color:#59b7fb;
        }
        .saveBtn{
            float: right;
            background: url("../img/email/icon_backing.png") no-repeat;
            width: 70px;
            height: 28px;
            /*border-radius: 4px;*/
            margin-top: 9px;
            line-height: 28px;
            /*border: #aaa 1px solid;*/
            text-align: center;
            cursor: pointer;
            margin-right: 20px;
        }
        .divText{
            float: left;
            height: 100%;
            line-height: 45px;
            font-size: 22px;
            margin-left: 20px;
        }
        .headTop{
            width: 100%;
            position: fixed;
            top: 0px;
            left: 0px;
            height: 45px;
            border-bottom: 1px solid #999;
            background: #fff;
            overflow: hidden;
        }
        .headTop .headImg {
            float: left;
            width: 23px;
            height: 100%;
            margin-left: 30px;
        }
        .headTop .divTitle {
            float: left;
            height: 45px;
            line-height: 45px;
            font-size: 22px;
            margin-left: 10px;
            color: #494d59;
        }
        .headImg img {
            /*width: 23px;*/
            /*height: 23px;*/
            margin-top: 11px;
            vertical-align: middle;
        }

        .impo{
            width: 90px;
            height: 28px;
            background: #2b7fe0!important;
            border-radius: 3px;
            color: #fff;
            font-size: 14px;
            line-height: 28px;
            margin: 2% 4% 0 0;
            cursor: pointer;
            text-align: center;
            margin-left: 10px;
        }
        #divTable td{
            text-align: center;
        }
    </style>
    <script type="text/javascript">

        $(function () {
            $('#selectDept').deptSelects(function(me){
//                $(me).val(window.opener.numdept)
                <%--$(me).append('<option value=""><fmt:message code="userManagement.th.Outgoing" /></option>')--%>
            });
            $('#selectYear').val(new Date().getFullYear());
            var yearId=$('#selectYear option:selected').val();
            // var deptId=$('#selectDept option:selected').val();
            var deptId=$('#selectDept option:selected').val();
            ajaxShow(yearId,deptId,$('#divTable'));

            $('#selectYear').on('change',function(){
                var yearVal=$(this).find('option:selected').val();
                var deptVal=$('#selectDept').find('option:selected').val();
                ajaxShow(yearVal,deptVal,$('#divTable'));
            })
            $('#selectDept').on('change',function(){
                var yearVal=$('#selectYear').find('option:selected').val();
                var deptVal=$(this).find('option:selected').val();
                ajaxShow(yearVal,deptVal,$('#divTable'));
            })

            $('#divTable').on('click','.monthDate',function(){
                var userName = $(this).parents('tr').attr('data-name');
                $('.textName').text('');
                $('.textDept').text('');
                var dataNum=$(this).attr('data-unm');
                var dataName=$(this).parents('tr').attr('data-name');
                var dataDept=$(this).parents('tr').attr('data-dept');
                var me=this;
                $('.emailList').hide();
                $('.queryList').show();
                $('.textName').text(dataName);
                $('.textDept').text('（'+dataDept+'）');
                $('#appendTable').find('tr').remove();
                $.ajax({
                    type:'get',
                    url:'/email/selectListByMoths',
                    dataType:'json',
                    data:{
                        sendTime:dataNum,
                        userId:$(me).attr('data-fromId'),
                        year:$('#selectYear').val()
                    },
                    success:function(res){
                        var datas=res.obj;
                        var str='';

                        for(var i=datas.length-1;i>-1;i--){
                            var stra='';
                            for(var j=0;j<datas[i].attachmentList.length;j++){
                                var attachmentUrl =datas[i].attachmentList[j].attUrl; //获取附件地址
                                var attName = encodeURI(datas[i].attachmentList[j].attachFile).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                attachmentUrl = attachmentUrl.substring(0,attachmentUrl.lastIndexOf("ATTACHMENT_NAME="))+"ATTACHMENT_NAME="+attName; //处理附件名字
                                var urlName=encodeURI(attachmentUrl).replace('%2524','');
                                stra+='<div class="dech" deUrl="'+datas[i].attachmentList[j].attUrl+'"><a href="/download?'+urlName+'" NAME="'+datas[i].attachmentList[j].attachName+'*" style="text-decoration:none;"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>'+datas[i].attachmentList[j].attachName+'</a><input type="hidden" class="inHidden" value="'+datas[i].attachmentList[j].aid+'@'+datas[i].attachmentList[j].ym+'_'+datas[i].attachmentList[j].attachId+',"></div>'
                            }
                            str+='<tr data-id="'+datas[i].bodyId+'">' +
                                '<td style="width: 10%;">'+ userName +'</td>'+
                                '<td style="width: 35%;"><a class="dataSub" href="javascript:;" style="">'+datas[i].subject+'</a></td>' +
                                '<td style="width: 20%;">'+datas[i].sendTimes+'</td>' +
                                '<td class="attachName" style="width: 35%">'+stra+'</td>' +
                                '</tr>'
                        }
                        $('#appendTable').append(str);
                    }
                })
            })
            $('.saveBtn').on('click',function(){
                $('.emailList').show();
                $('.queryList').hide();
            })
            $('#appendTable').on('click','.dataSub',function(){
                var dataId=$(this).parents('tr').attr('data-id');
//                window.open('/email/eamilDetailByOne?dataId='+dataId+'&editType=0');
                window.open('/email/details?id='+dataId+'&editType=0');
            })

        })
       var user_th_selectDepartment;
        $.fn.deptSelects = function (args, timers) {
            if(specialdept != undefined){
                if(specialdept == 1){
                    user_th_selectDepartment = user_th_specialselectDepartment;
                }
            }
            var _this = $(this);
            if (timers != null) {
                clearInterval(timers);
                timers = null;
            }
            $.ajax({
                url: "/department/getAlldept",
                type: 'get',
                data: {},
                dataType: 'json',
                success: function (obj) {
                    var data = obj.obj;
                    departmentData = digui(data, 0);
                    var str = departmentChild(departmentData, '<option value="0">'+user_th_selectDepartment+'</option>', 0, -1);
                    _this.html(str);
                    if (_this.attr('pval') && (_this.attr('pval').indexOf('_') > -1)) {
                        var pval = _this.attr('pval').split('_');
                        _this.val(pval[0]);
                    }
                    if (args != undefined) {
                        args(_this);
                    }

                    var array = new Array();  //定义数组
                    var arr=new Array();
                    $("#selectDept option").each(function(){  //遍历所有option
                         var txt = $(this).val();   //获取option值
                        var txts = $(this).text();   //获取option值
                        if(txts!=''){
                            array.push(txts);  //添加到数组中
                        }
                        if(txt!=''){
                            arr.push(txt);  //添加到数组中
                        }
                    });
                    for (var i=0;i<array.length;i++) {
                        if (array[i].indexOf(dept) !=-1){
                            $('#selectDept').val(arr[i]);
                        }


                    }

                },
                error: function () {
                }
            });
        };

        var  dept;
        function ajaxShow(yearId,deptId,element) {
            if(deptId == undefined || deptId == null){
                deptId = 0
            }
            element.find('tr').remove();
            $.ajax({
                type:'get',
                url:'/email/selectCount',
                dataType:'json',
                data:{
                    sendTime:yearId,
                    toId:deptId
                },
                success:function(res){
                    var datas=res.obj;
                    var str='';
                    for(var i=0;i<datas.length;i++){
                        // dept=datas[0].deptName;
                        var num=0;
                        str+='<tr data-name="'+datas[i].users.userName+'" data-dept="'+datas[i].deptName+'">' +
                            '<td>'+datas[i].deptName+'</td>' +
                            '<td>'+datas[i].users.userName+'</td>' +
                            '<td><a class="monthDate" data-fromId="'+datas[i].fromId+'" href="javascript:;" data-unm="'+(num+1)+'">'+datas[i].count1+'</a></td>' +
                            '<td><a class="monthDate" data-fromId="'+datas[i].fromId+'" href="javascript:;" data-unm="'+(num+2)+'">'+datas[i].count2+'</a></td>' +
                            '<td><a class="monthDate" data-fromId="'+datas[i].fromId+'" href="javascript:;" data-unm="'+(num+3)+'">'+datas[i].count3+'</a></td>' +
                            '<td><a class="monthDate" data-fromId="'+datas[i].fromId+'" href="javascript:;" data-unm="'+(num+4)+'">'+datas[i].count4+'</a></td>' +
                            '<td><a class="monthDate" data-fromId="'+datas[i].fromId+'" href="javascript:;" data-unm="'+(num+5)+'">'+datas[i].count5+'</a></td>' +
                            '<td><a class="monthDate" data-fromId="'+datas[i].fromId+'" href="javascript:;" data-unm="'+(num+6)+'">'+datas[i].count6+'</a></td>' +
                            '<td><a class="monthDate" data-fromId="'+datas[i].fromId+'" href="javascript:;" data-unm="'+(num+7)+'">'+datas[i].count7+'</a></td>' +
                            '<td><a class="monthDate" data-fromId="'+datas[i].fromId+'" href="javascript:;" data-unm="'+(num+8)+'">'+datas[i].count8+'</a></td>' +
                            '<td><a class="monthDate" data-fromId="'+datas[i].fromId+'" href="javascript:;" data-unm="'+(num+9)+'">'+datas[i].count9+'</a></td>' +
                            '<td><a class="monthDate" data-fromId="'+datas[i].fromId+'" href="javascript:;" data-unm="'+(num+10)+'">'+datas[i].count10+'</a></td>' +
                            '<td><a class="monthDate" data-fromId="'+datas[i].fromId+'" href="javascript:;" data-unm="'+(num+11)+'">'+datas[i].count11+'</a></td>' +
                            '<td><a class="monthDate" data-fromId="'+datas[i].fromId+'" href="javascript:;" data-unm="'+(num+12)+'">'+datas[i].count12+'</a></td>' +
                            '</tr>';
                    }
//                    $('#divTable').append(str);

                    element.html(str);
                    $("#selectDept option").trigger('size');

                }
            })
        }
    </script>
</head>
<body style="overflow-x: hidden">
<div class="headTop">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/youjiantongji.png" alt="">
    </div>
    <div class="divTitle">
        <fmt:message code="adding.th.emailCoun" />
    </div>
</div>
<div class="content">
    <div class="emailList" style="display: block;">
        <div class="header" style="width:96%;margin-top: 10px;margin-left: 20px;">
            <select name="selectYear" id="selectYear">
                <option value="2011">2011<fmt:message code="chat.th.year" /></option>
                <option value="2012">2012<fmt:message code="chat.th.year" /></option>
                <option value="2013">2013<fmt:message code="chat.th.year" /></option>
                <option value="2014">2014<fmt:message code="chat.th.year" /></option>
                <option value="2015">2015<fmt:message code="chat.th.year" /></option>
                <option value="2016">2016<fmt:message code="chat.th.year" /></option>
                <option value="2017">2017<fmt:message code="chat.th.year" /></option>
                <option value="2018">2018<fmt:message code="chat.th.year" /></option>
                <option value="2019">2019<fmt:message code="chat.th.year" /></option>
                <option value="2020"selected>2020<fmt:message code="chat.th.year" /></option>
                <option value="2021">2021<fmt:message code="chat.th.year" /></option>
                <option value="2022">2022<fmt:message code="chat.th.year" /></option>
                <option value="2023">2023<fmt:message code="chat.th.year" /></option>
                <option value="2024">2024<fmt:message code="chat.th.year" /></option>
                <option value="2025">2025<fmt:message code="chat.th.year" /></option>
                <option value="2026">2026<fmt:message code="chat.th.year" /></option>
                <option value="2027">2027<fmt:message code="chat.th.year" /></option>
                <option value="2028">2028<fmt:message code="chat.th.year" /></option>
                <option value="2029">2029<fmt:message code="chat.th.year" /></option>
                <option value="2030">2030<fmt:message code="chat.th.year" /></option>
            </select>
            <select name="selectDept" id="selectDept">

            </select>
            <div class="impo" style="width: 70px;display: inline-block">导出</div>
        </div>
        <div class="mainCon">
            <table border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse">
                <thead>
                <tr>
                    <th><fmt:message code="hr.th.department" /></th>
                    <th><fmt:message code="userDetails.th.name" /></th>
                    <th><fmt:message code="chat.th.1" /></th>
                    <th><fmt:message code="chat.th.2" /></th>
                    <th><fmt:message code="chat.th.3" /></th>
                    <th><fmt:message code="chat.th.4" /></th>
                    <th><fmt:message code="chat.th.5" /></th>
                    <th><fmt:message code="chat.th.6" /></th>
                    <th><fmt:message code="chat.th.7" /></th>
                    <th><fmt:message code="chat.th.8" /></th>
                    <th><fmt:message code="chat.th.9" /></th>
                    <th><fmt:message code="chat.th.10" /></th>
                    <th><fmt:message code="chat.th.11" /></th>
                    <th><fmt:message code="chat.th.12" /></th>
                </tr>
                </thead>
                <tbody id="divTable">

                </tbody>
            </table>
        </div>
    </div>
    <div class="queryList" style="display: none;">
        <div class="header" style="height: 45px;margin-bottom: 20px;color: #494d59;border-bottom:#999 1px solid; ">
            <div class="divText"> <fmt:message code="adding.th.xdf" />- <span class="textName"></span><span class="textDept"></span></div>

            <div class="saveBtn"><span style="margin-left: 23px"><fmt:message code="notice.th.return" /></span></div>
        </div>
        <button type="button" class="layui-btn layui-btn-normal" style="margin-left: 30px;"><i class="layui-icon layui-icon-return"></i><fmt:message code="notice.th.return" /></button>
        <div class="mainCon" style="">
            <table border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse">
                <thead>
                <tr>
                    <th style="text-align: left"><fmt:message code="email.th.sender" /></th>
                    <th style="text-align: left"><fmt:message code="notice.th.title" /></th>
                    <th style="text-align: left"><fmt:message code="email.th.time" /></th>
                    <th style="text-align: left"><fmt:message code="email.th.file" /></th>
                </tr>
                </thead>
                <tbody id="appendTable">

                </tbody>
            </table>
        </div>
    </div>
</div>
<script>
    $('.impo').on('click',function () {
        window.location.href='/email/selectCount?export=1&sendTime='+$('#selectYear').val()+'&toId='+$('#selectDept option:selected').val();
    })
    $('.layui-btn-normal').on('click',function(){
        $('.emailList').show();
        $('.queryList').hide();
    })
</script>
</body>
</html>
