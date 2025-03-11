<%--需把局部样式归并为一个通用或符合公告管理的公共样式，
接口对完需调整--%>

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
<head lang="en">
    <meta charset="UTF-8">
    <title><fmt:message code="vote.th.ClaimQuery" /></title>
    <link rel="stylesheet" type="text/css" href="../css/news/center.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css" />
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <%--<script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>--%>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="../css/news/new_news.css"/>
    <!-- word文本编辑器 -->
    <script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <style>
        #cont_totals td{
            color: #000;
            font-weight: normal;
        }
        table{
            table-layout:fixed;
        }
        #tr_td tr td.publishtip {
            overflow: hidden;
            text-overflow:ellipsis;
            height: 40px;
            width: 40px;
            white-space:nowrap;
        }
        .news_t h1,.news_two h1{
            line-height: 23px;
            text-align: center;
        }
        .add_print h1,.add_down h1{
            color: #000;
            line-height: 20px;
            text-align: center;
        }
        .title a{
            color: #59b7fb;
        }
        .caozuo a:hover{
            color:#287fe0;
        }
        .center .login .icons div{
            margin-left:9px !important;
        }

        .center .login .ce1{
            line-height: 24px;
            margin-top:24px!important;
        }


        .icons div {
            float: left;
            line-height: 30px;
        }
        #daochu{
            background: url(../../img/news/new_export.png) no-repeat;
        }
        #btn_query{
            background: url(../img/file/cabinet03.png) no-repeat;
        }
        .icons h2{
            text-align: center;
            width: 71%;
        }
        table tr td input {
            height: 25px;
            border: #ccc 1px solid;
            padding-left: 5px;
        }
        .notice_top h2,.notice_notop h2,.delete_check h2,.delete_all h2{
            text-align: left;
            margin-left: 12px;
        }
        .navigation{
            /*display: inline-block;*/
            float: left;
            width: 96% !important;
            margin-left: 2%;
        }
        table td{
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .le input[type='text']{
            height: 25px;
            width: 160px;
        }
        .le input[type='radio']{
            height: 14px;
            margin-top: 6px;
        }
        #tr_td td{
            text-align: center;
        }
        .center .login .middle .le {
            margin-left: 31px;
        }
        .center .login .ce1 {
            margin-top: 18px;
        }
        .center  .login{
            width: 500px;
        }
        .center .login .header {
            line-height: 50px;
        }


        .center .login .icons{
            padding-left: 160px;
        }
        .M-box3 .active{
            margin: 0px 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            background: #2b7fe0;
            font-size: 12px;
            border: 1px solid #2b7fe0;
            color:#fff;
            text-align:center;
            display: inline-block;
        }
        .M-box3 a{
            margin: 0 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            font-size: 12px;
            display: inline-block;
            text-align:center;
            background: #fff;
            border: 1px solid #ebebeb;
            color: #bdbdbd;
            text-decoration: none;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<div class="bx" style="width: 100%;">
    <div class="center">
        <div class="navigation  clearfix" style="margin-top: -50px;">
            <div class="left" style="width:300px">
                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/workPlanQuery.png"style="margin-top:20px"/>
                <div class="news">
                    <fmt:message code="vote.th.ClaimQuery" />
                </div>
            </div>
        </div>
        <div class="login" style="margin-bottom: 10px">
            <div class="header">
                <span><fmt:message code="event.th.PleaseCriteria" /></span>
            </div>
            <form id="queryTranshistoryForm">
                <div class="middle">
                  <div class="le ce1">
                        <div class="color" style="width:135px;">
                            <span><fmt:message code="sup.th.Applicant" />：</span>
                        </div>
                        <div>
                            <textarea name="borrower1" id="borrower1" class="borrower1" user_id="" value="" dataid="" disabled style="min-width: 160px;height:30px;"></textarea>
                            <a href="javascript:;" id="addBorrower"><fmt:message code="global.lang.add" /></a>
                            <a href="javascript:;" id="clearBorrower" style="color: red"><fmt:message code="global.lang.empty" /></a>
                        </div>
                    </div>

                    <div class="le ce1">
                        <div class="color" style="width:135px;"> <fmt:message code="vote.th.OfficeStorehouse" />：</div>
                        <div>
                            <select style="width: 164px;height: 32px" id="depositoryId" name="depositoryId"><option value=""><fmt:message code="hr.th.PleaseSelect" /></option></select>
                        </div>
                    </div>

                    <div class="le ce1">
                        <div class="color" style="width:135px;"><fmt:message code="vote.th.ClaimQuery" />：</div>
                        <div>
                            <select style="width: 164px;height: 32px" id="typeId" name="typeId"><option value=""><fmt:message code="hr.th.PleaseSelect" /></option></select>
                        </div>
                    </div>

                    <div class="le ce1">
                        <div class="color" style="width:135px;"><fmt:message code="vote.th.OfficeSupplies" />：</div>
                        <div>
                            <select style="width: 164px;height: 32px" id="proId" name="proId"><option value=""><fmt:message code="hr.th.PleaseSelect" /></option></select>
                        </div>
                    </div>

                    <div class="le ce1">
                        <div class="color" style="width:135px;"><fmt:message code="notice.th.state" />：</div>
                        <div>
                            <select style="width: 164px;height: 32px" id="grantStatus" name="grantStatus">
                                <option value=""><fmt:message code="hr.th.PleaseSelect" /></option>
                                <option value="0"><fmt:message code="vote.th.Untreated" /></option>
                                <option value="1"><fmt:message code="vote.th.Processed" /></option>
                            </select>
                        </div>
                    </div>

                    <div class="le ce1" style="padding-bottom: 15px;">
                        <div class="color" style="width:135px;"><fmt:message code="hr.th.DateOfApplication" />：</div>
                        <div>
                            <input id="transBeginDate" name="transBeginDate" type="text" style="float: left;width: 130px" onclick="laydate(start)">
                            <span style="float: left">&nbsp;<fmt:message code="global.lang.to" />&nbsp;</span>
                            <input id="transEndDate" name="transEndDate" type="text" style="float: left;width: 130px" onclick="laydate(end)">
                        </div>
                    </div>

                </div>
            </form>
            <div class="icons">
                <div id="btn_query"  style="margin-right:10px; cursor: pointer;" onclick="queryTransByCond(0) "><h2><fmt:message code="global.lang.query" /></h2></div>
                <div id="daochu"  style="margin-right:10px; cursor: pointer;" onclick="queryTransByCond(1) "><h2><fmt:message code="global.lang.report" /></h2></div>
            </div>
        </div>
    </div>


    <!--表单选项显示-->
    <div class="step1" style="display: none">
        <div class="navigation  clearfix">
            <div class="left" style="width:300px">
                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/workPlanQuery.png" style="margin-top:20px">
                <div class="news" >
                   <fmt:message code="vote.th.ClaimQuery" />
                </div>
            </div>
            <%--分页按钮--%>
            <%--<div id="dbgz_page" class="M-box3 fr" style="margin-top: 2%">--%>
            <%--</div>--%>
        </div>

        <!--table表单  标题栏 -->
        <div>
            <div id="already">
                <table id="tr_td" style="width:99%">
                    <thead>
                    <tr>
                        <td class="th"><fmt:message code="workflow.th.Serial" /></td>
                        <td class="th" ><fmt:message code="vote.th.OfficeName" /></td>
                        <td class="th titleOne"><fmt:message code="vote.th.Registration" /></td>
                        <td class="th"><fmt:message code="sup.th.Applicant" /></td>
                        <td class="th"><fmt:message code="event.th.Number" /></td>
                        <td class="th"><fmt:message code="hr.th.DateOfApplication" /> </td>
                        <td class="th"><fmt:message code="event.th.ApprovalStatus" /></td>
                        <td class="th"><fmt:message code="journal.th.Remarks" /></td>
                        <td class="th"><fmt:message code="notice.th.state" /></td>
                        <td class="th notice_do"><fmt:message code="notice.th.operation" /></td>
                    </tr>
                    </thead>
                    <tbody id="j_tb"></tbody>
                </table>
                <div id="dbgz_page" class="M-box3 fr" style="margin-right: 5%;margin-top: 1%">

                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>

<script>
    //选人控件
    $("#addBorrower").on("click",function(){//申请人
        user_id = "borrower1";
        $.popWindow("../../common/selectUser?0");
    });
    //清空人员控件
    $('#clearBorrower').on("click",function () {
        $("#borrower1").val("");
        $("#borrower1").attr('user_id','');
        $("#borrower1").attr('dataid','');
        $("#borrower1").attr('username','');
        $("#borrower1").attr('userprivname','');
    })




    //时间控件
    var start = {
        format: 'YYYY-MM-DD',
        /* min: laydate.now(), //设定最小日期为当前日期*/
        /* max: '2099-06-16 23:59:59', //最大日期*/
        istime: true,
        istoday: false,
        choose: function(datas){
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas //将结束日的初始值设定为开始日
        }
    };
    var end = {
        format: 'YYYY-MM-DD',
        /*min: laydate.now(),*/
        /*max: '2099-06-16 23:59:59',*/
        istime: true,
        istoday: false,
        choose: function(datas){
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };

    $(function () {
        $.ajax({
            url:"/officeDepository/selAllDepository",
            type:'post',
            dataType:'json',
            success:function (json) {
                var str='<option value=""><fmt:message code="hr.th.PleaseSelect" /></option>';
                var data=json.obj;
                if(json.flag){
                    for(var i=0;i<data.length;i++){
                        str+='<option value="'+data[i].id+'">'+data[i].depositoryName+'</option>';
                    }
                }
                $("#depositoryId").html(str);
            }
        })
    })

    $(function () {
        //列表显示

    })

//    var obj = {};
//    var url = location.href.split('?')[1].split('&');
//    for(var i = 0; i < url.length; i++){
//        obj[url[i].split('=')[0]] = url[i].split('=')[1];
//    }

    function queryNoApprove() {
        //列表显示
        var ajaxPageLe = {
            data: {
                page: 1,//当前处于第几页
                pageSize: 10,//一页显示几条
                useFlag: true,
                output: 0,
                borrower: $('#borrower1').attr('user_id'),
                depositoryId: $('#depositoryId option:selected').val(),
                typeId: $('#typeId option:selected').val(),
                proId: $('#proId option:selected').val(),
                grantStatus: $('#grantStatus option:selected').val(),
                transBeginDate: $("#transBeginDate").val(),
                transEndDate: $('#transEndDate').val()
//                ,
//                transId: obj.transId
                // computationNumber:null
            },
            page: function () {
                var me = this;
                $.ajax({
                    url: '/officetransHistory/selTranshistoryByCond',
                    type: 'get',
                    dataType: 'json',
                    data:me.data,
                    success: function (obj) {
                        var data = obj.obj;
                        console.log('data',data)
                        var str = "";
                        if(obj.flag) {
                            for(var i=0;i<data.length;i++){
                                str+='<tr>' +
                                    '<td>'+(i+1)+'</td>'+
                                    '<td>'+data[i].proName+'</td>' ;
                                if(data[i].transFlag==1){
                                    str+='<td><fmt:message code="vote.th.user" /></td>' ;
                                }else if(data[i].transFlag==2){
                                    str+='<td><fmt:message code="vote.th.borrow" /></td>' ;
                                }else if(data[i].transFlag==3){
                                    str+='<td><fmt:message code="vote.th.Purchasing"/></td>' ;
                                }else if(data[i].transFlag==4){
                                    str+='<td><fmt:message code="vote.th.Maintain"/></td>' ;
                                }else if(data[i].transFlag==5){
                                    str+='<td><fmt:message code="event.th.Scrap"/></td>' ;
                                }
                                str+= '<td>'+data[i].borrowerName+'</td>' +
                                    '<td>'+data[i].transQty+'</td>' ;
                                if(data[i].transDate!='undefined'){
                                    str+='<td>'+data[i].transDate+'</td>';
                                }else{
                                    str+='<td></td>';
                                }
                                if (data[i].transState == "01") {
                                    str+='<td><fmt:message code="vote.th.ApprovalDepartment" /></td>' ;
                                } else if (data[i].transState == "02") {
                                    str+='<td><fmt:message code="vote.th.ToAdministrator" /></td>' ;
                                } else if (data[i].transState == "1") {
                                    str+='<td><fmt:message code="sup.th.Agree" /></td>' ;
                                }else if (data[i].transState == "21") {
                                    str+='<td><fmt:message code="vote.th.DisapprovaApproval" /></td>' ;
                                }else if (data[i].transState == "22") {
                                    str+='<td><fmt:message code="vote.th.StorekeeperDismissal" /></td>' ;
                                }
                                if(data[i].remark==undefined){
                                    str+='<td></td>' ;
                                }else{
                                    str+='<td>'+data[i].remark+'</td>' ;
                                }

                                if (data[i].transState == "1") {
                                    if(data[i].grantStatus=="1"){
                                        str+='<td><fmt:message code="vote.th.AlreadyIssued" /></td>' ;
                                    }else{
                                        str+='<td><fmt:message code="vote.th.WaitDistribution" /></td>' ;
                                    }
                                } else{
                                    str+='<td>待审核</td>' ;
                                }
                                if (data[i].flag==1) {
                                    str+='<td><a href="javascript:void(0)" onclick="approval(1,'+data[i].transId+','+data[i].proId+')"><fmt:message code="meet.th.Approval" /></a>&nbsp;<a href="javascript:void(0)" onclick="approval(2,'+data[i].transId+','+data[i].proId+')"><fmt:message code="meet.th.NotApprove" /></a></td>';
                                } else if(data[i].flag==2){
                                    str+='<td><a href="javascript:void(0)"javascript:void(0)" onclick="productRelease('+data[i].transId+')"><fmt:message code="vote.th.grant" /></a></td>' ;
                                }else{
                                    str+='<td></td>';
                                }
                                str+='</tr>';
                            }
                            $("#already tbody").html(str);
                        }
                        me.pageTwo(obj.totleNum, me.data.pageSize, me.data.page)
                    }
                });

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
    }


    $("#depositoryId").on("change",function () {
        $.ajax({
            url:"/officetransHistory/getDownObjects",
            type:'post',
            dataType:'json',
            data:{
                typeDepository:$(this).val()
            },
            success:function (json) {
                var str='<option value=""><fmt:message code="hr.th.PleaseSelect" /></option>';
                var data=json.obj;
                if(json.flag){
                    for(var i=0;i<data.length;i++){
                        str+='<option value="'+data[i].id+'">'+data[i].typeName+'</option>';
                    }
                }
                $("#typeId").html(str);
            }
        })
    })



    $("#typeId").on("change",function () {
        $.ajax({
            url:"/officetransHistory/getDownObjects",
            type:'post',
            dataType:'json',
            data:{
                officeProductType:$(this).val()
            },
            success:function (json) {
                var str='<option value=""><fmt:message code="hr.th.PleaseSelect" /></option>';
                var data=json.obj;
                if(json.flag){
                    for(var i=0;i<data.length;i++){
                        str+='<option value="'+data[i].proId+'">'+data[i].proName+'</option>';
                    }
                }
                $("#proId").html(str);
            }
        })
    })

    //进行条件查询方法，并在列表中显示
    function queryTransByCond(output) {
        if(output!=1){//查询按钮
//            query();
            queryNoApprove();
            $(".center").hide();
            $(".step1").show();
        }else{//导出按钮
            window.location.href='/officetransHistory/selTranshistoryByCond?page=1&pageSize=100&useFlag=true&output='+output+'&borrower='+$("#borrower1").attr("user_id")+
                '&depositoryId='+$("#depositoryId").val()+'&typeId='+$("#typeId").val()+'&proId='+$("#proId").val()+
                '&grantStatus='+$("#grantStatus").val()+'&transBeginDate='+$("#transBeginDate").val()+'&transEndDate='+$("#transEndDate").val()+'&flag='+1;
        }
    }

    //进行条件查询方法，并在列表中显示
    function query() {
        $('#queryTranshistoryForm').ajaxSubmit({
            url:"/officetransHistory/selTranshistoryByCond",
            type:'post',
            data:{
                borrower:$("#borrower1").attr("user_id"),
                flag:1,
                output:0
            },
            dataType:'json',
            success:function (json) {
                $("#tr_td tbody").html("");
                var str="";
                var data=json.obj;
                console.log('data',data)
                if(json.flag) {
                    for(var i=0;i<data.length;i++){
                        str+='<tr>' +
                            '<td>'+(i+1)+'</td>'+
                            '<td>'+data[i].proName+'</td>' ;
                        if(data[i].transFlag==1){
                            str+='<td><fmt:message code="vote.th.user" /></td>' ;
                        }else if(data[i].transFlag==2){
                            str+='<td><fmt:message code="vote.th.borrow" /></td>' ;
                        }else if(data[i].transFlag==3){
                            str+='<td><fmt:message code="vote.th.Purchasing"/></td>' ;
                        }else if(data[i].transFlag==4){
                            str+='<td><fmt:message code="vote.th.Maintain"/></td>' ;
                        }else if(data[i].transFlag==5){
                            str+='<td><fmt:message code="event.th.Scrap"/></td>' ;
                        }
                        str+= '<td>'+data[i].borrowerName+'</td>' +
                            '<td>'+data[i].transQty+'</td>' ;
                        if(data[i].transDate!='undefined'){
                            str+='<td>'+data[i].transDate+'</td>';
                        }else{
                            str+='<td></td>';
                        }
                        if (data[i].transState == "01") {
                            str+='<td><fmt:message code="vote.th.ApprovalDepartment" /></td>' ;
                        } else if (data[i].transState == "02") {
                            str+='<td><fmt:message code="vote.th.ToAdministrator" /></td>' ;
                        } else if (data[i].transState == "1") {
                            str+='<td><fmt:message code="sup.th.Agree" /></td>' ;
                        }else if (data[i].transState == "21") {
                            str+='<td><fmt:message code="vote.th.DisapprovaApproval" /></td>' ;
                        }else if (data[i].transState == "22") {
                            str+='<td><fmt:message code="vote.th.StorekeeperDismissal" /></td>' ;
                        }
                        // str+='<td>'+data[i].remark+'</td>' ;
                        if(data[i].remark==undefined){
                            str+='<td></td>' ;
                        }else{
                            str+='<td>'+data[i].remark+'</td>' ;
                        }
                        if (data[i].transState == "1") {
                           if(data[i].grantStatus=="1"){
                               str+='<td><fmt:message code="vote.th.AlreadyIssued" /></td>' ;
                           }else{
                               str+='<td><fmt:message code="vote.th.WaitDistribution" /></td>' ;
                           }
                        } else{
                            str+='<td><fmt:message code="vote.th.NotAudited" /></td>' ;
                        }
                        if (data[i].flag==1) {
                            str+='<td><a href="javascript:void(0)" onclick="approval(1,'+data[i].transId+','+data[i].proId+')"><fmt:message code="meet.th.Approval" /></a>&nbsp;<a href="javascript:void(0)" onclick="approval(2,'+data[i].transId+','+data[i].proId+')"><fmt:message code="meet.th.NotApprove" /></a></td>';
                        } else if(data[i].flag==2){
                            str+='<td><a href="javascript:void(0)"javascript:void(0)" onclick="productRelease('+data[i].transId+')"><fmt:message code="vote.th.grant" /></a></td>' ;
                        }else{
                            str+='<td></td>';
                        }
                        str+='/tr>';
                    }
                    $("#tr_td tbody").html(str);
                }
            }
        })
    }

    //批准和不批准操作
    function approval(status,id,proId) {
        $.ajax({
            url: '/officetransHistory/upTransHistoryState',
            type: 'get',
            dataType: 'json',
            data: {
                transState:status,
                transId:id,
                proIds:proId
            },
            success: function (obj) {
                if(obj.flag){
                    layer.msg('<fmt:message code="meet.th.SuccessfulApproval" />', { icon:6});
                    queryNoApprove()
                }else{
                    layer.msg('<fmt:message code="event.th.ApprovalFailure" />', { icon:2});
                }
            }
        })
    }

    //办公用品发放
    function productRelease(id) {
        $.ajax({
            url: '/officetransHistory/upGrantStatus',
            type: 'get',
            data: {
                transId:id,
                grantStatus: 1,
            },
            dataType: 'json',
            success: function (obj) {
                if(obj.flag == true){
                    layer.msg('<fmt:message code="vote.th.Success" />', { icon:6});
                    queryNoApprove()
                }else{
                    layer.msg('<fmt:message code="vote.th.Failure" />', { icon:2});
                }
            }
        })
    }
</script>