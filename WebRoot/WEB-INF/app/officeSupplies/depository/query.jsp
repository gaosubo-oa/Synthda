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
	<title><fmt:message  code="vote.th.OfficeInquiries"/></title>
    <link rel="stylesheet" type="text/css" href="../css/news/center.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css" />
	<link rel="stylesheet" href="/lib/laydate/need/laydate.css">
	<script src="../../js/common/language.js"></script>
	<script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
	<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/laydate/laydate.js"></script>
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
			/*margin-left:9px !important;*/
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
		a{
			text-decoration: none;
			color: #0066cc;
			margin: 0 5px;
		}
        .center .login .header {
            background-color: #3691DA;
            color: #fff;
            padding: 10px;
            font-size: 16px;
            letter-spacing: 1px;
            font-weight: bold;
        }
        .center .login .ce1 {
            height: 40px;
        }
        .center .login .icons {
            padding-left: 0px;
        }
		.center .login .middle {
			border: 1px solid #DCDCDC;
			border-bottom: none;
		}
		.delete_ok{
			width: 109px;
			height:24px;
			padding-top: 3px;
			padding-left: 10px;
			background: url(../../img/btn_deleteannounce.png) 0px 0px no-repeat;
		}
		.headTop .headImg {
			float: left;
			width: 23px;
			height: 100%;
			margin-left: 30px;
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
<div class="bx">
	<div class="center">
		<div class="navigation  clearfix" style="margin-top: -56px;">
			<div class="left" >
				<div class="headImg">
					<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_offSupQuery.png" alt="">
				</div>
				<div class="news" style="width:170px;margin-top: 30px;">
					<fmt:message  code="vote.th.OfficeInquiries"/>
				</div>
			</div>
		</div>
		<div class="login" style="margin-bottom: 10px">
			<div class="header" style="text-align: center">
				<p style="padding: 10px"><fmt:message  code="event.th.PleaseCriteria"/></p>
			</div>
			<form id="queryMainForm">
				<div class="middle">

						<div class="le ce1" >
							<div class="color" style="width:135px;"><fmt:message  code="vote.th.QueryType"/>:</div>
							<div style="float:left;">
								<select id="transFlag" name="transFlag" style="width: 164px;height:30px;">
									<option value=""><fmt:message  code="hr.th.PleaseSelect"/></option>
									<option value="1"><fmt:message  code="vote.th.user"/></option>
									<option value="2"><fmt:message  code="vote.th.borrow"/></option>
									<option value="3"><fmt:message  code="vote.th.Purchasing"/></option>
									<option value="4"><fmt:message  code="vote.th.Maintain"/></option>
									<option value="5"><fmt:message  code="event.th.Scrap"/></option>
									<%--<option value="6">调拨</option>--%>
								</select>
							</div>
						</div>
						<div class="le ce1">
							<div class="color" style="width:135px;"> <fmt:message  code="sup.th.Applicant"/>：</div>
							<div>
								<input id="borrow1" name="borrow1" type="text" disabled readonly>
								<a href="javascript:;" id="addBorrow"><fmt:message  code="global.lang.select"/></a>
								<a href="javascript:;" id="clearBorrow" onclick="emptyUser(borrow1)" style="color: red"><fmt:message  code="global.lang.empty"/></a>
							</div>
						</div>
						<div class="le ce1">
						<div class="color" style="width:135px;">
						   <fmt:message  code="vote.th.OfficeStorehouse"/>：
						</div>
						<div>
							<select style="width: 164px;height: 30px" id="depositoryId" name="depositoryId">
								<option value=""><fmt:message  code="hr.th.PleaseSelect"/></option>
							</select>
						</div>
						</div>

					<div class="le ce1">
						<div class="color" style="width:135px;"><fmt:message  code="vote.th.OfficeCategory"/>：</div>
						<div>
                            <select style="width: 164px;height: 30px" id="officeProtype" name="officeProtype">
								<option value=""><fmt:message  code="hr.th.PleaseSelect"/></option>
							</select>
						</div>
					</div>
					<div class="le ce1">
						<div class="color" style="width:135px;"><fmt:message  code="vote.th.OfficeSupplies"/>：</div>
						<div>
							<select style="width: 164px;height: 30px" id="proId" name="proId">
								<option value=""><fmt:message  code="hr.th.PleaseSelect"/></option>
							</select>
						</div>
					</div>
					<div class="le ce1">
						<div class="color" style="width:135px;"> <fmt:message  code="global.lang.date"/>：</div>
						<div>
							<input id="transBeginDate" name="transBeginDate" type="text"  onclick="laydate(start)"><span style="margin-left: 5px; font-family: 微软雅黑;font-size: 14px;"><fmt:message  code="global.lang.to"/></span>
							<input id="transEndDate" name="transEndDate" type="text"  onclick="laydate(end)">
						</div>
					</div>

				</div>
			</form>
			<div class="icons">
				<div id="btn_query"  style="margin-right:10px; cursor: pointer;margin-left: 175px;" onclick=" queryNoApprove()"><h2><fmt:message  code="global.lang.query"/></h2></div>
				<div id="daochu"  style="margin-right:10px; cursor: pointer;" onclick="empty() "><h2 style="color: red"><fmt:message  code="workflow.th.Reset"/></h2></div>
			</div>
		</div>
	</div>


	<!--表单选项显示-->
	<div class="step1" style="display: none">
		<div class="navigation  clearfix">
			<div class="left">
				<img src="/img/commonTheme/${sessionScope.InterfaceModel}/gonggaoguanli.png">
				<div class="news" style="width:170px;margin-top: 30px;">
					<fmt:message  code="work.th.workList"/>
				</div>
			</div>
		</div>

		<!--table表单  标题栏 -->
		<div>
			<div id="already">
				<table id="tr_td">
					<thead>
					<tr>
						<td class="th"><fmt:message  code="vote.th.OfficeName"/></td>
						<td class="th" style="width: 100px"><fmt:message  code="vote.th.Registration"/></td>
						<td class="th"><fmt:message  code="sup.th.Applicant"/></td>
						<td class="th" style="width: 50px"><fmt:message  code="event.th.Number"/></td>
						<td class="th" style="width: 50px"><fmt:message  code="vote.th.UnitPrice"/></td>
						<td class="th"><fmt:message  code="vote.th.OperationDate"/></td>
                        <td class="th"><fmt:message  code="vote.th.Operator"/></td>
                        <td class="th" style="width: 300px"><fmt:message  code="journal.th.Remarks"/></td>
						<td class="th notice_do"><fmt:message  code="vote.th.AdditionalInformation"/></td>
					</tr>
					</thead>
					<tbody id="j_tb"></tbody>
				</table>
				<div id="dbgz_page" class="M-box3 fr" style="float: right;margin-top: 1%">

				</div>
			</div>
		</div>
	</div>
</div>


</body>
</html>

<script>

    $('#addBorrow').on("click",function(){
        user_id="borrow1";
        $.popWindow("../../common/selectUser?0");
    });

    //清空人员控件
    function emptyUser(id){
        $("#"+id).val("");
        $("#"+id).attr("dataid","");
        $("#"+id).attr("user_id","");
    }

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

    $("#depositoryId").on("change",function () {
        $.ajax({
            url:"/officetransHistory/getDownObjects",
            type:'post',
            dataType:'json',
            data:{
                typeDepository:$(this).val()
            },
            success:function (json) {
                var str='<option value=""><fmt:message  code="hr.th.PleaseSelect"/></option>';
                var data=json.obj;
                if(json.flag){
                    for(var i=0;i<data.length;i++){
                        str+='<option value="'+data[i].id+'">'+data[i].typeName+'</option>';
                    }
                }
                $("#officeProtype").html(str);
            }
        })
    })

    $("#officeProtype").on("change",function () {
        $.ajax({
            url:"/officetransHistory/getDownObjects",
            type:'post',
            dataType:'json',
            data:{
                officeProductType:$(this).val()
            },
            success:function (json) {
                var str='<option value=""><fmt:message  code="hr.th.PleaseSelect"/></option>';
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

	$(function () {
        $.ajax({
            url:"/officeDepository/getDeposttoryByDept",
            type:'post',
            dataType:'json',
            success:function (json) {
                var str='<option value=""><fmt:message  code="hr.th.PleaseSelect"/></option>';
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

    function queryNoApprove() {
        $(".center").hide();
        $(".step1").show();
        //列表显示
        var ajaxPageLe = {
            data: {
                page: 1,//当前处于第几页
                pageSize: 10,//一页显示几条
                useFlag: true,
                output: 0,
                transFlag: $('#transFlag option:selected').val(), // 查询类型
                borrower: $('#borrower1').attr('user_id'), // 申请人
                depositoryId: $('#depositoryId option:selected').val(), // 办公用品库
                officeProtype: $('#officeProtype option:selected').val(), // 办公用品类别
                proId: $('#proId option:selected').val(), // 办公用品
//                grantStatus: $('#grantStatus option:selected').val(),
                transBeginDate: $("#transBeginDate").val(), // 开始时间
                transEndDate: $('#transEndDate').val() // 结束时间
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
                        var str = "";
                        if(obj.flag) {
                            for (var i = 0; i < data.length; i++) {
                                str += '<tr>' +
                                    '<td title="'+ data[i].proName +'">' + data[i].proName + '</td>' ;
                                if(data[i].transFlag==1){
                                    str+='<td title="<fmt:message  code="vote.th.user"/>"><fmt:message  code="vote.th.user"/></td>' ;
                                }else if(data[i].transFlag==2){
                                    str+='<td title="<fmt:message  code="vote.th.borrow"/>"><fmt:message  code="vote.th.borrow"/></td>' ;
                                }else if(data[i].transFlag==3){
                                    str+='<td title="<fmt:message  code="vote.th.Purchasing"/>"><fmt:message  code="vote.th.Purchasing"/></td>' ;
                                }else if(data[i].transFlag==4){
                                    str+='<td title="<fmt:message  code="vote.th.Maintain"/>"><fmt:message  code="vote.th.Maintain"/></td>' ;
                                }else if(data[i].transFlag==5){
                                    str+='<td title="<fmt:message  code="event.th.Scrap"/>"><fmt:message  code="event.th.Scrap"/></td>' ;
                                }else{
                                    str+='<td title=""></td>' ;
                                }

                                str+= '<td title="'+ data[i].borrowerName +'">' + data[i].borrowerName + '</td>' +
                                    '<td title="'+ data[i].transQty +'">' + data[i].transQty + '</td>' +
                                    '<td title="'+ data[i].price +'">' + data[i].price + '</td>' ;
                                if(data[i].transDate!='undefined'){
                                    str+='<td title="'+ data[i].transDate +'">'+data[i].transDate+'</td>';
                                }else{
                                    str+='<td title=""></td>';
                                }
                                str+='<td title="'+ data[i].operatorName +'">' + data[i].operatorName + '</td>'+
                                    '<td title="'+data[i].remark+'">' + data[i].remark + '</td>';
                                if(data[i].returnStatus==1){
                                    str+='<td title="<fmt:message  code="vote.th.Res"/>"><fmt:message  code="vote.th.Res"/></td>' ;
                                }else{
                                    str+='<td title="<fmt:message  code="vote.th.NotReturned"/>"><fmt:message  code="vote.th.NotReturned"/></td>' ;
                                }
                                str += '</tr>';
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


    //进行条件查询方法，并在列表中显示
	function queryList() {
        $(".center").hide();
        $(".step1").show();
        $('#queryMainForm').ajaxSubmit({
            url:"/officetransHistory/selTranshistoryByCond",
            type:'post',
            dataType:'json',
            data:{
				borrower:$("#borrow1").attr("user_id"),
				output:0
			},
            success:function (json) {
                $("#tr_td tbody").html("");
                var str = "";
                var data = json.obj;
                if (json.flag) {
                    for (var i = 0; i < data.length; i++) {
                        str += '<tr>' +
                            '<td title="'+ data[i].proName +'">' + data[i].proName + '</td>' ;
                        if(data[i].transFlag==1){
                            str+='<td title="<fmt:message  code="vote.th.user"/>"><fmt:message  code="vote.th.user"/></td>' ;
                        }else if(data[i].transFlag==2){
                            str+='<td title="<fmt:message  code="vote.th.borrow"/>"><fmt:message  code="vote.th.borrow"/></td>' ;
                        }else if(data[i].transFlag==3){
                            str+='<td title="<fmt:message  code="vote.th.Purchasing"/>"><fmt:message  code="vote.th.Purchasing"/></td>' ;
                        }else if(data[i].transFlag==4){
                            str+='<td title="<fmt:message  code="vote.th.Maintain"/>"><fmt:message  code="vote.th.Maintain"/></td>' ;
                        }else if(data[i].transFlag==5){
                            str+='<td title="<fmt:message  code="event.th.Scrap"/>"><fmt:message  code="event.th.Scrap"/></td>' ;
                        }else{
                            str+='<td title=""></td>' ;
						}

                           str+= '<td title="'+ data[i].borrowerName +'">' + data[i].borrowerName + '</td>' +
                            '<td title="'+ data[i].transQty +'">' + data[i].transQty + '</td>' +
                            '<td title="'+ data[i].price +'">' + data[i].price + '</td>' ;
                        if(data[i].transDate!='undefined'){
                            str+='<td title="'+ data[i].transDate +'">'+data[i].transDate+'</td>';
                        }else{
                            str+='<td title=""></td>';
                        }
                            str+='<td title="'+ data[i].operatorName +'">' + data[i].operatorName + '</td>'+
                            '<td title="'+ data[i].remark +'">' + data[i].remark + '</td>';
                        if(data[i].returnStatus==1){
                            str+='<td title="<fmt:message  code="vote.th.Res"/>"><fmt:message  code="vote.th.Res"/></td>' ;
                        }else{
                            str+='<td title="<fmt:message  code="vote.th.NotReturned"/>"><fmt:message  code="vote.th.NotReturned"/></td>' ;
                        }
                        str += '</tr>';
                    }
                    $("#tr_td tbody").html(str);
                }
            }
		})
    }

    function empty() {
        $("#transFlag").val("");
        $("#borrow1").val("");
        $("#borrow1").attr("user_id","");
        $("#depositoryId").val("");
        $("#officeProtype").val("");
        $("#proId").val("");
        $("#transBeginDate").val("");
        $("#transEndDate").val("");
    }
</script>