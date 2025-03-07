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
	<title></title>
	<link rel="stylesheet" type="text/css" href="../css/news/center.css"/>
	<link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
	<link rel="stylesheet" type="text/css" href="../css/base.css" />

	<script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
	<script src="../js/news/page.js"></script>
	<script src="../lib/laydate.js"></script>
	<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
	<link rel="stylesheet" type="text/css" href="../css/news/new_news.css"/>
	<!-- word文本编辑器 -->
	<script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../lib/laydate/laydate.js"></script>
	<script src="../../lib/layer/layer.js?20201106"></script>
	<script src="../../js/jquery/jquery.cookie.js"></script>
	<script src="/js/workflow/work/workform.js?20210224"></script>
	<style>
		/* .btn_ok{
             width:26%;
             height:40px;
             background: #f0f0f0;
             float:left;
             margin-left:30px;

             border-radius: 4px;
             font-size:18px;
             text-align: center;
             line-height: 40px;
         }*/
		.headli4{
			width: 90px;
			display: inline-block;
			text-align: center;
			margin-top: 4px;
		}
		#cont_totals td{
			color: #000;
			font-weight: normal;
		}
		.notice_type{
			width:61px;
		}
		.notice_do{
			width:168px;
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
		#add_send{
			display: inline-block;
			float: left;
			width: 66px;
			height: 30px;
			margin-right: 40px;
			margin-top: 10px;
			margin-bottom: 20px;
			background: url(../../img/publish.png) no-repeat;
			padding-left: 23px;
			padding-top: 7px;
			cursor: pointer;
			font-size: 14px;
		}
		#add_baocun{
			display: inline-block;
			float: left;
			width: 66px;
			height: 30px;
			margin-right: 40px;
			margin-top: 10px;
			margin-bottom: 20px;
			background: url(../../img/save.png) no-repeat;
			padding-left: 23px;
			padding-top: 7px;
			cursor: pointer;
			font-size: 14px;
		}
		#add_titileTime{
			text-align: left;
		}
		.foot_mg{
			width: 57%;
			height: 50px;
			margin: 20px auto;
		}
		.start_end_time{
			display: inline-block;
			float: left;
			border: none;
			width: 400px;
			height: 20px;


		}
		.td_title1{
			border:none !important;
			color:#000 !important;
		}
		.step2{
			margin-left:2%;
		}
		.news_t{
			width: 139px !important;
		}
		.news_t h1,.news_two h1{
			line-height: 23px;
			text-align: center;
		}
		.news_two{
			width: 139px;
			margin-top: 3px;
		}
		.add_print,.add_down,.add_nochose{
			float:left;
			margin-top:10px;
		}
		.add_print,.add_down{
			width: 152px;

		}
		.add_nochose{
			width: 195px;
			text-align: center;
			line-height:20px;
		}
		.add_print h1,.add_down h1{
			color: #000;
			line-height: 20px;
			text-align: center;
		}
		.add_show,.textTop,.remindCheck,.remindShow{
			float:left;
		}
		.add_show,.remindShow{
			line-height: 24px;
			/* text-align: -webkit-auto; */
			text-align: center;
		}
		.zhiding{
			margin-top:3px;
		}
		.title a{
			color: #59b7fb;
		}
		.titleOne{
			width: 148px;
		}
		.find_detail{
			cursor: pointer;
		}
		/*标题长时隐藏设置*/
		.title{
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
		}

		.notice_change,.notice_delete,#add_send,#add_baocun,.release3{
			cursor: pointer;
		}
		.release3{
			margin-top:0px !important;
			line-height: 26px;
		}
		.caozuo a:hover{
			color:#287fe0;
		}
		.notice_geshi{
			display: block;
			margin-top: -46px;
			margin-left: 79px;
		}
		#add_type_notice,.notice_type{
			float:left;
		}
		/*修改的字体*/
		.notice_change{
			color: #1772c0;
			margin-left: 5px;
		}
		.notice_change:hover {
			color: #287fe0 !important;
		}
		/*删除的字体*/
		.notice_delete{
			color: #e01919;
			margin-left: 5px;
		}
		.notice_delete:hover {
			color: #C81623 !important;
		}
		.notice_zhongzhi{
			color: #1772c0;
			margin-left: 5px;
		}
		.center .login .icons div{
			margin-left:9px !important;
		}
		.icons div {
			display: inline-block;
			float: left;
			height: 30px;
			line-height: 30px;
			width: 56px;
			text-align: center;
			margin-right: 15px;
			/*        background: url(../../img/gobbing.png) no-repeat;*/
			cursor: pointer;
			padding-left: 20px;
		}
		#daochu{
			background: url(../../img/news/new_export.png) no-repeat;
		}
		#btn_query{
			background: url(../img/file/cabinet03.png) no-repeat;
		}
		#new_change{
			background: url(../../img/gobbing.png) no-repeat;
		}
		#find_delete{
			background: url(../../img/btn_delete.png) no-repeat;
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
		.last_str{
			cursor: pointer;
		}
		.bgcolor{
			background: #c5e9fb !important;
			color: #000000;
		}
		/*置顶一系列按钮的背景图片*/
		.notice_top{
			background: url(../../img/btn_top.png)0px 10px no-repeat;
			text-align: center;
			font-size: 12px;
		}
		.notice_top h2,.notice_notop h2,.delete_check h2,.delete_all h2{
			text-align: left;
			margin-left: 12px;
		}

		/*取消置顶*/
		.notice_notop{
			background: url(../../img/btn_canceltop.png) 0px 10px no-repeat;
			text-align: center;
			font-size: 12px;
		}
		/*选中删除*/
		.delete_check{
			background: url(../../img/btn_deleteannounce.png) 0px 10px no-repeat;
			text-align: center;
			font-size: 12px;
		}
		/*全部删除*/
		.delete_all{
			background: url(../../img/btn_deleteannounce.png)0px 10px no-repeat;
			text-align: right;
			font-size: 12px;
		}
		#find_start,#find_end{
			height: 20px;
			line-height: 20px;
			width: 130px;
			/* margin-left: -4.2px; */
			margin-top: 20px;
			cursor: pointer;
		}
		.orgAdd{
			color: rgb(32, 123, 214);
			padding-left: 12px;
			background: url(../../img/org_select.png) 0px 0px no-repeat;
			background-position: 0px 0px;
			cursor: pointer;
		}
		.orgClear{
			color: rgb(154, 169, 184);
			padding-left: 12px;
			margin-left: 5px;
			background: url(../../img/org_select.png) 0px -60px no-repeat;
			background-position: 0px -60px;
			cursor: pointer;
		}
		.navigation{
			display: inline-block;
			float: left;
			width: 96% !important;
			margin-left: 2%;
		}
		/*  #find_end{
              margin-left:20px;
          }*/
		.tbody_th{
			background-color: #fff;
			font-size: 15px !important;
			color: #2F5C8F !important;
			font-weight: bold !important;
			/*  border: 0px !important;
              width:6% !important;*/
		}
		table td{
			/*  height: 22px;*/
			/*width: 20%;*/
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
		}
		.th{
			cursor: pointer;
		}
	</style>
</head>
<body>
<div class="bx">


	<!--表单选项显示-->


	<!-- 新建公告 -->
	<div class="step1">
		<table class="newNews">
			<div class="navigation  clearfix">
				<div class="nav_t1"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/newsManages2_1.png"></div>
				<div class="nav_t2" class="news"></div>
				<%-- <fmt:message code="notice.th.newnotify"/>--%>
				<!-- <div class="nav_t3">选择格式 -->
				<%--<div class="nav_t3" >--%>
				<%--<select name="" class="sel" id="add_sel">--%>

				<%--<option value="0" selected><fmt:message code="notice.format.Commonformat"/></option>--%>
				<%--<option value="1" disabled="disabled"><fmt:message code="notice.format.MHTformat"/></option>--%>
				<%--<option value="2" disabled="disabled"><fmt:message code="notice.format.hyperlink"/></option>--%>
				<%--</select>--%>
				<%--<span class="notice_geshi"></span>--%>
				<%--</div>--%>
				<div class="nav_t3 sel format" id="add_sel">
					<%--<select name="" >--%>
					<fmt:message code="notice.format.Commonformat"/>
					<%--<div class="" ></div>--%>
					<%--</select>--%>
				</div>


			</div>
			<!-- 二级选项 -->
			<tbody>
			<tr>
				<td class="td_w">
					<select name="" class="type_notice" id="add_type_notice">
						<%-- <option value="00"><fmt:message code="notice.th.chosenotifytype"/></option>
                         <option value="01"><fmt:message code="notice.type.Decision"/></option>
                         <option value="02"><fmt:message code="notice.type.notice"/></option>
                         <option value="03"><fmt:message code="notice.type.Bulletin"/></option>
                         <option value="04"><fmt:message code="notice.type.other"/></option>
                         <option value="05"> <fmt:message  code="news.th.none"/></option>--%>
					</select>
					<%--<span class="notice_type"><img class="td_title2" src="../img/mg2.png" alt=""></span>--%>
				</td>
				<td>
					<div class="td_title1">
						<!-- 需调整 -->

						<input type="text" name="titileTime" id="add_titileTime"  style="height: 20px;line-height:20px; width: 255px; margin-left: -4.2px; margin-top: -1px;"
							   placeholder=" <fmt:message code="global.lang.printsubject"/>..." >

					</div>
					<img class="td_title2" src="../img/mg2.png" alt=""/>
				</td>
			</tr>
			<tr>
				<td class="blue_text">  <fmt:message code="notice.th.IssuedByDepartment"/>：<br/><a href="javaScript:;" style="color: #207bd6;font-size: 14px;font-weight: normal;" id="personnel" onclick="showAndHidden('personnel','role','man')"> <fmt:message  code="notice.th.PostedByPersonnelOrRoles"/></a></td><%--隐藏按人员或角色发布--%>
				<td>
					<textarea readonly="readonly" class=" td_title1  release1" id="query_toId" dataid="" resize="auto"></textarea>
					<%--<input class="td_title1  release1"  id="query_toId" type="text"/>--%>
					<img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>
					<div class="release3" id="dept_add"><fmt:message code="global.lang.add"/></div>
					<div class="release4 empty"onclick="empty('query_toId')"><fmt:message code="global.lang.empty"/></div>

				</td>
			</tr>
			<tr id="role" style="display: none">
				<td class="blue_text">  <fmt:message code="notice.th.role"/>：</td>
				<td>
					<textarea readonly="readonly" class=" td_title1  release1" id="query_privId" dataid="" resize="auto"></textarea>
					<%--<input class="td_title1  release1" id="query_privId" type="text"/>--%>
					<img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>
					<div class="release3" id="priv_add"><fmt:message code="global.lang.add"/></div>
					<div class="release4 empty" onclick="empty('query_privId')"><fmt:message code="global.lang.empty"/></div>
				</td>
			</tr>
			<tr id="man" style="display: none">
				<td class="blue_text"> <fmt:message code="notice.th.somebody"/>：</td>
				<td>
					<textarea readonly="readonly" class=" td_title1  release1" id="query_userId" dataid="" resize="auto"></textarea>
					<%--<input class="td_title1  release1" id="query_userId" dataid="" type="text"/>--%>
					<img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>
					<div class="release3"  id="query_adduser"><fmt:message code="global.lang.add"/></div>
					<div class="release4 empty" onclick="empty('query_userId')"><fmt:message code="global.lang.empty"/></div>
				</td>
			</tr>
			<!--- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->

			<tr>
				<td class="blue_text"><fmt:message code="notice.th.PostedTime"/>：</td>
				<td>
					<div class="td_title1">
						<!-- 需引入时间插件 -->
						<input type="text" id="add_newDate"  name="publishTime" class="publishTime" style="height: 20px; width: 255px; margin-left: -4.2px; margin-top: -1px;">
					</div>
					<img class="td_title2 release2" src="../img/mg2.png" alt=""/>

					<div class="release3" id="add_notice_time"><fmt:message code="notice.th.ResetToCurrentTime"/></div>
				</td>
			</tr>

			<tr>
				<td class="blue_text"><fmt:message code="notice.th.validity"/>：</td>
				<td>
					<div class="td_title1 start_end_time">
						<!-- 引入时间控件 和 css 调整  -->
						<input type="text"  name="startTime" id="notice_start_add" class="startTime notice_startime" style="height: 20px;line-height:20px;width: 130px; margin-left: -4.2px; margin-top: -1px;">
						<span style="float: left;"><fmt:message code="global.lang.to"/></span>
						<input type="text"  name="endTime" id="notice_end_add" class="endTime notice_endTime" style="height: 20px;width: 130px;  margin-top: -1px;">
						<fmt:message code="notice.th.null"/>

					</div>
					<%--<img class="td_title2 release2" src="../img/mg2.png" style="margin-left: -10px;" alt="">--%>
				</td>
			</tr>

			<!-- 复选框样式调整  -->
			<tr>
				<td class="blue_text"><fmt:message code="notice.th.reminder"/>：</td>
				<td class="remind">


					<div class="news_t">
						<input type="checkbox" name="remind" class="remindCheck" value="0" checked>
						<h1 class="remindShow"><fmt:message code="notice.th.remindermessage"/></h1>
					</div>
					<%--  <div class="news_two">
                          <input type="checkbox" name="remind" ><h1><fmt:message code="notice.th.share"/></h1>
                      </div>--%>
				</td>
			</tr>

			<tr>
				<td class="blue_text"><fmt:message code="notice.th.top"/>：</td>
				<td class="top_box">
					<div>
						<input type="checkbox" name="textTop" id="textTop" class="textTop">
						<h1 class="add_show"><fmt:message code="notice.th.topMajor"/></h1>
					</div>
					<div class="t_box">
						<input type="text" name="textDay" id="textDay" class="textDay" value="0"
							   style="height: 20px; width: 40px; margin-left: -5.2px; margin-top: -1px;">
					</div>
					<div class="zhiding"><fmt:message code="notice.th.endTop"/></div>
				</td>
			</tr>
			<tr>
				<td class="blue_text"><fmt:message code="notice.th.contentValidity"/>：</td>
				<td class="abstract">
					<div class="abstract1">
						<input type="text"  name="summny" id="add_summny" class="summny" style="height: 20px;line-height: 20px;color: #000; width: 255px; margin-left: -4.2px; margin-top: -1px;">
					</div>
					<div class="abstract2"><fmt:message code="notice.th.contentHigh"/></div>
					<%--<img class="td_title2 release2" src="../img/mg2.png" style="margin-left: 3px;" alt="">--%>
				</td>
			</tr>

			<!-- 需调整 -->
			<tr>
				<td class="blue_text"><fmt:message code="notice.th.fileUpload"/>：</td>
				<td class="enclosure">
					<div id="query_uploadArr" style="display:block;">

					</div>
					<div><img src="../img/mg11.png" alt=""/></div>
					<div class="enclosure_t">
						<form id="uploadimgform" target="uploadiframe" action="../upload?module=notify" enctype="multipart/form-data" method="post">
							<input type="file" multiple="multiple" name="file" id="uploadinputimg" class="w-icon5" style="display:none;">
							<a id="uploadimg" style="cursor: pointer;"><fmt:message code="notice.th.addfile"/></a>

						</form>

					</div>

				</td>
			</tr>

			<!--word编辑器-->
			<tr>
				<td colspan="2">
					<div id="word_container" name="content" type="text/plain" style="width: 100%;min-height: 200px;"></div>
				</td>
			</tr>
			<%--<tr>--%>
			<%--<td class="blue_text">--%>
			<%--<fmt:message code="notice.th.keyWord"/>：--%>
			<%--</td>--%>
			<%--<td class="keyword">--%>
			<%--<input class="keyword_ip"><fmt:message code="global.th.printkey"/></input>--%>
			<%--<div class="keyword_t"><fmt:message code="notice.th.AutomaticKeywordAcquisition"/></div>--%>
			<%--<div><fmt:message code="notice.th.keyContent"/></div>--%>
			<%--</tr>--%>
			</tbody>

		</table>
		<div class="foot_mg clearfix">
			<div class="btn_">
				<div  id="add_send" value="1" type="publish" class="fot_1 btn_ok"><fmt:message code="global.lang.publish"/></div>
				<div  id="add_baocun" value="0" type="save" class="btn_style btn_ok"><fmt:message code="global.lang.save"/></div>
			</div>

		</div>
	</div>

</div>



<!--content部分结束-->





<!--footer部分结束-->
</div>
<script>
    var ue = UE.getEditor('word_container');
    function Refillings(id){
        document.getElementById(id).reset();
    };
    user_id='';
    /*  function empty(id){
          $("#"+id).val("");
      };*/


    /* 新建新闻、修改新闻人员控件清空 */
    function empty(id){
        $("#"+id).val("");
        $("#"+id).attr("deptid","");
    };
    /* 新建新闻、修改新闻人员控件清空 */
    function empty1(id){
        $("#"+id).val("");
        $("#"+id).attr("userpriv","");
    };
    /* 新建新闻、修改新闻人员控件清空 */
    function empty2(id){
        $("#"+id).val("");
        $("#"+id).attr("user_id","");
        $("#"+id).attr("dataid","");
    };
    /* word文本编辑器 */



    function emptys(id,id1,id2,id3,id4,id5,id6,id7,id8,id9){
        $("#"+id).val("");
        $("#"+id1).val("");
        $("#"+id2).val("");
        $("#"+id3).val("");
        $("#"+id4).val("");
        $("#"+id5).val('<fmt:message  code="notice.th.all"/>')=='0';//全部
        $("#"+id6).val('<fmt:message  code="notice.th.chosenotifytype"/>')=='0';//选择公告类型
        $("#"+id7).val('<fmt:message  code="notice.th.all"/>')=='0';//全部
        $("#"+id8).val('')=='';
        $("#"+id9).val('<fmt:message  code="notice.th.all"/>')=='0';//全部
    };
    /* 公告人员控件显示和隐藏 */
    function showAndHidden(persion,role,man){
        if($("#"+persion).html() ==' <fmt:message  code="notice.th.PostedByPersonnelOrRoles"/>'){
            $("#"+persion).html(" <fmt:message  code="notice.th.Hidden"/>");
            $("#"+role).show();
            $("#"+man).show();
        }else{
            $("#"+persion).html(" <fmt:message  code="notice.th.PostedByPersonnelOrRoles"/>");
            $("#"+role).hide();
            $("#"+man).hide();
        }
    }
    $(function(){

        //页面加载时发送ajax获取下拉框数据
        var str="<option value=\"0\" selected=\"\"><fmt:message code="notice.type.alltype"/></option>";
        var str2="<option value=\"0\" selected=\"\"><fmt:message code="notice.th.chosenotifytype"/></option>";
        $.ajax({
            url: "/code/GetDropDownBox",
            type:'get',
            dataType:"JSON",
            data : {"CodeNos":"NOTIFY"},
            success:function(data){
                for (var proId in data){
                    for(var i=0;i<data[proId].length;i++){
                        str+='<option value="'+data[proId][i].codeNo+'">'+data[proId][i].codeName+'</option>'
                        str2+='<option value="'+data[proId][i].codeNo+'">'+data[proId][i].codeName+'</option>'
                    }
                }
                $('#select').append(str);
                $('#add_type_notice').append(str2);
                $('#selectTwo').append(str2);
            }

        })


        var now = null;
        function queryTime(){
            function p(s) {
                return s < 10 ? '0' + s: s;
            }

            var myDate = new Date();
            //获取当前年
            var year=myDate.getFullYear();
            //获取当前月
            var month=myDate.getMonth()+1;
            //获取当前日
            var date=myDate.getDate();
            var h=myDate.getHours();       //获取当前小时数(0-23)
            var m=myDate.getMinutes();     //获取当前分钟数(0-59)
            var s=myDate.getSeconds();

            now=year+'-'+p(month)+"-"+p(date)+" "+p(h)+':'+p(m)+":"+p(s);
        }







        //获取当前时间
        var now_time = null;
        var now_month = null;

        function p(s) {
            return s < 10 ? '0' + s: s;
        }

        var myDate = new Date();
        //获取当前年
        var year=myDate.getFullYear();
        //获取当前月
        var month=myDate.getMonth()+1;
        //获取当前日
        var date=myDate.getDate();
        var h=myDate.getHours();       //获取当前小时数(0-23)
        var m=myDate.getMinutes();     //获取当前分钟数(0-59)
        var s=myDate.getSeconds();

        now_time=year+'-'+p(month)+"-"+p(date)+" "+p(h)+':'+p(m)+":"+p(s);
        now_month=year+'-'+p(month)

        /*本年的范围*/
        var now_year = year + "-01-01/" + year + "-12-31";

        <!-- 本月 -->
        var now = new Date(); //当前日期
        var nowDayOfWeek = now.getDay(); //今天本周的第几天
        var nowDay = now.getDate(); //当前日
        var nowMonth = now.getMonth(); //当前月
        var nowYear = now.getYear(); //当前年
        nowYear += (nowYear < 2000) ? 1900 : 0; //

        var lastMonthDate = new Date(); //上月日期
        lastMonthDate.setDate(1);
        lastMonthDate.setMonth(lastMonthDate.getMonth()-1);
        var lastYear = lastMonthDate.getYear();
        var lastMonth = lastMonthDate.getMonth();

        //格式化日期：yyyy-MM-dd
        function formatDate(date) {
            var myyear = date.getFullYear();
            var mymonth = date.getMonth()+1;
            var myweekday = date.getDate();

            if(mymonth < 10){
                mymonth = "0" + mymonth;
            }
            if(myweekday < 10){
                myweekday = "0" + myweekday;
            }
            return (myyear+"-"+mymonth + "-" + myweekday);
        }

        //获得某月的天数
        function getMonthDays(myMonth){
            var monthStartDate = new Date(nowYear, myMonth, 1);
            var monthEndDate = new Date(nowYear, myMonth + 1, 1);
            var days = (monthEndDate - monthStartDate)/(1000 * 60 * 60 * 24);
            return days;
        }
        //获得本季度的开始月份
        function getQuarterStartMonth(){
            var quarterStartMonth = 0;
            if(nowMonth<3){
                quarterStartMonth = 0;
            }
            if(2<nowMonth && nowMonth<6){
                quarterStartMonth = 3;
            }
            if(5<nowMonth && nowMonth<9){
                quarterStartMonth = 6;
            }
            if(nowMonth>8){
                quarterStartMonth = 9;
            }
            return quarterStartMonth;
        }

        //获得本周的开始日期
        function getWeekStartDate() {
            var weekStartDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek);
            return formatDate(weekStartDate);
        }

        //获得本周的结束日期
        function getWeekEndDate() {
            var weekEndDate = new Date(nowYear, nowMonth, nowDay + (6 - nowDayOfWeek));
            return formatDate(weekEndDate);
        }

        //获得本月的开始日期
        function getMonthStartDate(){
            var monthStartDate = new Date(nowYear, nowMonth, 1);
            return formatDate(monthStartDate);
        }

        //获得本月的结束日期
        function getMonthEndDate(){
            var monthEndDate = new Date(nowYear, nowMonth, getMonthDays(nowMonth));
            return formatDate(monthEndDate);
        }
        //选人员
        $('#query_adduser').click(function(){
            user_id='query_userId';
            $.popWindow("../common/selectUser");
        });
        //选部门
        $('#dept_add').click(function(){
            dept_id='query_toId';
            $.popWindow("../common/selectDept");
        });
        //选角色
        $('#priv_add').click(function(){
            priv_id='query_privId';
            $.popWindow("../common/selectPriv");
        });

        /*所有部门*/
        //部门共用
        var opt_li_dep='<option value="0"  class="levelleft0">所有部门</option><option value="01"  class="levelleft0" id="choose_more">多选部门</option>';
        departmentAjax(function (departmentData) {
            opt_li_dep=  departmentChild(departmentData,opt_li_dep,0,-1);
            $('#dept_id').html(opt_li_dep);
        });

        //部门遍历方法
        function departmentChild(datas,opt_li,level,dept){
            for(var i=0;i<datas.length;i++){
                var String="";
                var space=""
                for(var j=0;j<level;j++){
                    space+="├&nbsp;&nbsp;&nbsp;";
                }

                if(i==0){
                    String=space+"┌";
                }else
                if(i!=0){
                    String=space+"├";
                }else
                if(i==datas.length-1){
                    String=space+"└";
                }
                if(dept==datas[i].deptId){
                    opt_li+='<option value="'+datas[i].deptId+'" selected="selected">'+String+datas[i].deptName+'</option>';
                }else{
                    opt_li+='<option value="'+datas[i].deptId+'">'+String+datas[i].deptName+'</option>';
                }
                if(datas[i].childs!=null){
                    opt_li = departmentChild(datas[i].childs,opt_li,level+1,dept);
                }
            }
            return opt_li;
        }
        //部门接口
        function departmentAjax(callback){
            $.ajax({
                url:'../../department/getAlldept',
                type:'get',
                dataType:'json',
                success:function(obj){
                    var data=obj.obj;
                    var  departmentData= digui(data,0);
                    callback(departmentData);
                }
            });
        }
        function digui(datas,departId) {
            var data=new Array();
            for(var i=0;i<datas.length;i++){
                if(datas[i].deptParent==departId){
                    datas[i]["childs"]=digui(datas,datas[i].deptId);
                    data.push(datas[i]);
                }
            }
            return data;
        }
        /*多选部门的点击事件*/
        $('#dept_id').change(function(){
            var pf1=$(this).children('option:selected').val();
            var start_total_time=$('#find_start').val();
            var end_total_time=$('#find_end').val();
            if($(this).children('option:selected').val()=='01'){
                layer.open({
                    type: 1,
                    /* skin: 'layui-layer-rim', //加上边框 */
                    offset: '80px',
                    area: ['402px', '252px'], //宽高
                    title:'<fmt:message code="notify.th.MultiSectoralSelection"/>',/*多部门选择*/
                    content: '<div class="modal-body" style="max-height: 150px;height: 150px;padding: 0px;overflow: hidden;">'+
                    '<div style="margin-top: 30px;margin-left: 20px;"><input name="more_dept_id" type="hidden" value="">'+
                    '<textarea name="more_dept_name" id="query_Tos" value="" class="BigStatic" rows="4" cols="40" wrap="yes" readonly=""></textarea>'+
                    '<a class="orgAdd" id="add"><fmt:message code="global.lang.select"/></a><a class="orgClear"><fmt:message code="global.lang.empty"/></a></div></div>',//选择 清空
                    btn:['<fmt:message code="notice.th.Statistics"/>', '<fmt:message code="global.lang.close"/>'],/*统计 关闭*/
                    yes: function(index, layero){
                        //按钮【按钮三】的回调
                        /*alert($('.name_biaodan').val());*/
                        /* alert('0k');*/

                        var layerIndex = layer.load(0, {shade: false});
                        layer.closeAll();
                        $.ajax({
                            url: '/myNotice/getNotifyGroupFromDept',
                            type: 'get',
                            data: {
                                fromDept:'',
                                beginTime:'',
                                endTime:'',
                                sendTime:''
                            },
                            dataType: 'json',
                            success: function (obj) {
                                var data=obj.obj;
                                if(obj.flag==true){
                                    var str='';

                                    for(var i=0;i<data.length;i++){
                                        str+='<tr><td class="th">'+(i+1)+'</td><td class="th" id="deptName" deptId='+data[i].deptId+'>'+data[i].deptName+'</td><td class="th" >'+data[i].count+'</td></tr>'
                                    }
                                    var theath='<thead><tr><td class="tbody_th"><fmt:message code="workflow.th.Serial"/></td><td class="tbody_th"><fmt:message code="userManagement.th.department"/></td><td class="tbody_th" ><fmt:message code="notice.th.PublicationQuantity"/></td></tr></thead>'
                                    $('#cont_totals').html(theath+str);

                                }
                            }
                        })
                    }

                });
            }
            //点击选择，走选择部门的控件
            $('.layui-layer').on('click','#add',function(){
                /*    alert('111');*/
                dept_id='query_Tos';
                $.popWindow("../common/selectDept");
            });

            /*当前部门下调用的接口*/
            $.ajax({
                url: '/myNotice/getNotifyGroupFromDept',
                type: 'get',
                data: {
                    fromDept:pf1,
                    beginTime:start_total_time,
                    endTime:end_total_time,
                    sendTime:now_time
                },
                dataType: 'json',
                success: function (obj) {
                    var data=obj.obj;
                    if(obj.flag==true) {
                        var tr = '';
                        if (data.length > 0) {
                            for (var i = 0; i < data.length; i++) {
                                tr += '<tr class="trs" step="1"><td class="th">' + (i + 1) + '</td><td class="th" deptId='+data[i].deptId+' step="1">' + data[i].deptName + '</td><td class="th" >' + data[i].count + '</td></tr>'
                            }
                        } else {
                            layer.msg('<fmt:message code="hr.th.Nopublishedinformation"/>', {icon: 6});/*无发布的公共信息*/
                        }
                        var theath='<thead><tr><td class="tbody_th"><fmt:message code="workflow.th.Serial"/></td><td class="tbody_th"><fmt:message code="userManagement.th.department"/></td><td class="tbody_th" ><fmt:message code="notice.th.PublicationQuantity"/></td></tr></thead>'
                        $('#cont_totals').html(theath+tr);

                    }

                }
            })

        })
        /*第一级的人员点击事件,显示第二级*/
        $('#cont_totals').on('click','#deptName',function(){
            /*var step=1;*/
            var deptId=$(this).attr('deptId');
            var beginTime=$('#find_start').val();
            var endTime=$('#find_end').val();
            /* /notice/getNotifyByFromDept*/
            $.ajax({
                url: '/myNotice/getNotifyByFromDept',
                type: 'get',
                data: {
                    fromDept:deptId,
                    beginTime:beginTime,
                    endTime:endTime
                    /* sendTime:now_time*/
                },
                dataType: 'json',
                success: function (obj) {
                    var data=obj.obj;
                    if(obj.flag==true){
                        var str='';
                        if(data.length>0){
                            for(var i=0;i<data.length;i++){
                                str+='<tr class="trs" step="2"><td class="th">'+(i+1)+'</td><td class="th" id="deptName" fromId='+data[i].fromId+' deptId='+data[i].fromDept+'>'+data[i].fromDeptStr+'</td><td class="th" id="name" fromId='+data[i].fromId+' deptId='+data[i].fromDept+' step="2">'+data[i].fromIdStr+'</td><td class="th" >'+data[i].resultCount+'</td></tr>'
                            }/*姓名（点击查看详情）  发布数量*/
                            var theat='<thead><tr><td class="tbody_th"><fmt:message code="workflow.th.Serial"/></td><td class="tbody_th"><fmt:message code="userManagement.th.department"/></td><td class="tbody_th" ><fmt:message code="notify.th.NameClickToViewDetails"/></td><td class="tbody_th" ><fmt:message code="notice.th.PublicationQuantity"/></td></tr></thead>'
                            $('#cont_totals').html(theat+str);
                        }else{
                            layer.msg('<fmt:message code="hr.th.Nopublishedinformation"/>', {icon: 6});/*无发布的公共信息*/
                        }


                    }
                }
            })
        })
        /*点击人名，显示人员详情*/

        $('#cont_totals').on('click','#name',function(){
            var deptId=$(this).attr('deptId');
            var fromId=$(this).attr('fromId');
            var beginTime=$('#find_start').val();
            var endTime=$('#find_end').val();
            $.ajax({
                url: '/myNotice/getNotifyByFromIdAndDept',
                type: 'get',
                data: {
                    fromDept:deptId,
                    fromId:fromId
                },
                dataType: 'json',
                success: function (obj) {
                    var data=obj.obj;
                    if(obj.flag==true){
                        var str='';
                        if(data.length>0){
                            for(var i=0;i<data.length;i++){
                                str+='<tr class="trs" >' +
                                    '<td class="th" width="10%">'+(i+1)+'</td>' +
                                    '<td class="th" width="10%" id="deptName" deptId='+data[i].fromDept+'>'+data[i].fromIdStr+'</td>' +
                                    '<td class="th" width="10%" deptId='+data[i].fromDept+'>'+data[i].typeId+'</td>' +
                                    '<td class="th" width="20%" title='+data[i].toId+'>'+data[i].toId+'</td>' +
                                    '<td class="th subject_detail" width="10%" notifyId='+data[i].notifyId+' step="3">'+data[i].subject+'</td>' +
                                    '<td class="th" width="10%" >'+data[i].sendTime+'</td>' +
                                    '<td class="th" width="10%">'+data[i].beginDate+'</td>' +
                                    '<td class="th" width="10%" >'+data[i].endDate+'</td>' +
                                    '<td class="th" width="10%" >'+data[i].publish+'</td>' +
                                    '</tr>'
                            }
                            /*发布人  类型  发布范围  标题（点击查看详情）创建时间  生效日期  终止日期  状态*/
                            var detail_theat='<thead>' +
                                '<tr>' +
                                '<td class="tbody_th" width="10%"><fmt:message code="workflow.th.Serial"/>\
                                </td>\
                                <td class="tbody_th" width="10%"><fmt:message code="notice.th.publisher"/></td>\
                                <td class="tbody_th" width="10%"><fmt:message code="notice.th.type"/></td>\
                                <td class="tbody_th" width="20%"><fmt:message code="notice.th.releasescope"/></td>\
                                <td class="tbody_th" width="10%"><fmt:message code="notify.th.TitleClickToViewDetails"/></td>\
                                <td class="tbody_th" width="10%"><fmt:message code="notice.th.createTime"/></td>\
                                <td class="tbody_th" width="10%"><fmt:message code="notice.th.effectivedate"/></td>\
                                <td class="tbody_th" width="10%"><fmt:message code="notice.th.endDate"/></td>\
                                <td class="tbody_th" width="10%"><fmt:message code="notice.th.state"/></td>\
                                </tr></thead>'
                            $('#cont_totals').html(detail_theat+str);
                        }else{
                            layer.msg('<fmt:message code="hr.th.Nopublishedinformation"/>', {icon: 6});/*无发布的公共信息*/
                        }


                    }
                }
            })
        })






        /*查询页面的添加人员fromId*/



        //添加附件
        /* 添加附件 */

        $('#uploadimg').click(function(){
            $('#uploadinputimg').click();
        });

        $('#uploadinputimg').change(function(e){
            var target = $(e.target);
            var file;
            if(target[0].files && target[0].files[0]){
                file=target[0].files[0];
            }
            if(file){
                $.upload($('#uploadimgform'),function(res){
                    var str = "";
                    var str1="";
                    var data=res.obj;
                    for(var i=0;i<data.length;i++){
                        str+='<div class="dech" deUrl="'+data[i].attUrl+'" style="display:block;"><a class="ATTACH_a" NAME="'+data[i].attachName+'*" href="/download?'+data[i].attUrl+'">'+data[i].attachName+'</a><img class="deImg" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';
                    }

                    $('#query_uploadArr').append(str);

                });
            }
        });






        var data = {
            read : $('.index_head .one').parent().attr('data_id'),
            typeId : $('#select').val()==0?'':$('#select').val(),
            nTime : $('#sendTime').val(),
            page:1,
            pageSize:5,
            useFlag:true,
            newsTime:'',
            lastEditTime:'',
            content:'',
            subject:'',
            typeId:0,
            beginTime:'',
            endTime:'',
            content:'',
            changeId:'1',
            exportId:'1'
        };


        $('#tr_td').on('mouseenter','.publishtip',function () {
            var that = $(this);
            var str=that.attr('toTypeName').replace(/-/g,'<br>')
            layer.tips(str,that, {
                tips: [1, '#3595CC'],
                time: 10000
            });
        });
        $('#tr_td').on('mouseleave','.publishtip',function () {
            layer.closeAll();

        })
        function initPagination(totalData,pageSize){

            $('.M-box3').pagination({
                totalData:totalData,
                showData:pageSize,
                jump:true,
                coping:true,
                current: data.page,
                homePage:'<fmt:message code="global.page.first" />',
                endPage:'<fmt:message code="global.page.last" />',
                prevContent:'<fmt:message code="global.page.pre" />',
                nextContent:'<fmt:message code="global.page.next" />',
                jumpBtn:'<fmt:message code="global.page.jump" />',
                callback:function(index){
                    data.page = index.getCurrent();

                    initPageList(function(pageCount){
                        initPagination(pageCount,data.pageSize);
                    });
                }
            });
        }




        $('#add_notice_time').on('click',function(){
            queryTime();
            $("#add_newDate").val(now);
        });
        //新建发布公告通知
        $('#add_send').on('click',function(){
            var remindVal=0;
            if($('.remindCheck').is(":checked")){
                remindVal=1;
            }
            //附件循环遍历一下
            var attach=$('#query_uploadArr').find('a');
            var inp_value=$('#query_uploadArr').find('.inHidden');
            var aId='';
            var uId='';
            //value 值
            for(var i=0;i<$('#query_uploadArr .inHidden').length;i++){
                aId +=inp_value.eq(i).attr('value');

            }
            //name值
            for(var i=0;i<$('#query_uploadArr .inHidden').length;i++){
                uId += attach.eq(i).attr('name');
            }
            var action=$(this).attr("ac");

            var data_notice={
                subject:$('#add_titileTime').val(),//标题
                toId:$('#query_toId').attr('deptid'),//部门发布范围
                format:0,//格式
                userId:$('#query_userId').attr("user_id"),//按人员发布
                privId:$('#query_privId').attr('userpriv'),//按角色发布
                attachmentId:aId,//附件ID串
                attachmentName:uId,//附件名称串
                download:$(".down").is(':checked')==false?0:1,//是否允许下载office附件(0-不允许,1-允许)
                subjectColor:'',//标题颜色
                keyword:$('.keyword_ip').val(),//内容关键词
                topDays:$('#textDay').val(),//置顶天数
                publish:$(this).attr('value'),//发布标识(0-未发布,1-已发布,2-待审批,3-未通过)
                top:$("#textTop").eq(0).is(':checked')==false?0:1,//是否置顶(0-否,1-是)
                /* /!* top:$("#add_textTop").is(':checked')==false?0:1,//是否置顶(0-否,1-是),*!/*/
                summary:$('#add_summny').val(),//内容简介
                content:ue.getContent(),//内容
                sendTimes:$('#add_newDate').val(),//发布时间
                beginDates:$('#notice_start_add').val(),//开始日期
                endDates:$('#notice_end_add').val(),  //结束日期
                remind:remindVal//事务提醒
            };
            if($('#add_titileTime').val()==''){

                layer.msg('<fmt:message code="notify.th.PleaseFillTheTitle" />', { icon:6});/*请填写标题*/
                return false;
            }else  if(!($('#query_toId').val() || $('#query_privId').val() || $('#query_userId').val() )){

                layer.msg('<fmt:message code="notify.th.PleaseFillTheScopeOfTheRelease" />', { icon:6});/*请填写发布范围*/
                return false;
            }else  if(ue.getContent() == ''){

                layer.msg('<fmt:message code="notify.th.PleaseFillTheText" />', { icon:6});/*请填写正文*/
                return false;
            }else{
                if(action=="update"){
                    var noId=$(this).attr("noId");
                    data_notice['lastEditTimes']=$('#add_newDate').val();
                    data_notice['notifyId']=noId;
                    data_notice['readers']='';
                    data_notice['typeId']=$('#add_type_notice option:checked').attr('value');//公告类型
                    /*    typeId:$('#add_type_notice option:checked').attr('value'),*///公告类型
                    update(data_notice);

                }else if(action=="add"){
                    if($('#add_type_notice option:checked').attr('value')=='00'){
                        data_notice['typeId']='';//公告类型
                    }else{
                        data_notice['typeId']=$('#add_type_notice option:checked').attr('value');
                    }

                    //公告类型
                    add_notice(data_notice);
                }
            }


        })
        //新建的数据接口
        function add_notice(data_notice){
            $.ajax({
                type: "post",
                url: "/myNotice/addNotify",
                dataType: 'json',
                data: data_notice,
                success: function (obj) {

                    if(obj.flag==true){
                        $.layerMsg({content:'<fmt:message  code="user.th.PublishSuccessfully"/>！',icon:1},function(){
                            window.location.reload();
                        });
                    }
                }

            });
        }
        //新建公告通知,保存
        $('#add_baocun').on('click',function(){
            var btnType=$(this).attr('attrtype');
            //事务提醒
            var remindVal=0;
            if($('.remindCheck').is(":checked")){
                remindVal=1;
            }
            var attach=$('#query_uploadArr').find('a');
            var inp_value=$('#query_uploadArr').find('.inHidden');
            var aId='';
            var uId='';
            //value 值
            for(var i=0;i<$('#query_uploadArr .inHidden').length;i++){
                aId +=inp_value.eq(i).attr('value');

            }
            //name值
            for(var i=0;i<$('#query_uploadArr .inHidden').length;i++){
                uId += attach.eq(i).attr('name');
            }
//            var action=$(this).attr("ac");

            if(btnType == 'add'){
                $.ajax({
                    type: "post",
                    url: "/myNotice/addNotify",
                    dataType: 'json',
                    data: {
                        subject:$('#add_titileTime').val(),//标题
                        toId:$('#query_toId').attr('deptid'),//部门发布范围
                        format:0,//格式
                        userId:$('#query_userId').attr("user_id"),//按人员发布
                        privId:$('#query_privId').attr('privid'),//按角色发布
                        attachmentId:aId,//附件ID串
                        attachmentName:uId,//附件名称串
                        download:$(".down").is(':checked')==false?0:1,//是否允许下载office附件(0-不允许,1-允许)
                        subjectColor:'',//标题颜色
                        keyword:$('.keyword_ip').val(),//内容关键词
                        topDays:$('#textDay').val(),//置顶天数
                        publish:$(this).attr('value'),//发布标识(0-未发布,1-已发布,2-待审批,3-未通过)
                        top:$("#add_textTop").is(':checked')==false?0:1,//是否置顶(0-否,1-是),
                        summary:$('#add_summny').val(),//内容简介
                        content:ue.getContent(),//内容
                        sendTimes:$('#add_newDate').val(),//发布时间
                        beginDates:$('#notice_start_add').val(),//开始日期
                        endDates:$('#notice_end_add').val(), //结束日期
                        remind:remindVal//事务提醒
                    },
                    success: function (obj) {
                        if(obj.flag==true){
                            $.layerMsg({content:' <fmt:message  code="diary.th.modify"/>！',icon:1},function(){
                                window.location.reload();
                            });
                        }
                    }

                });
            }else{
                var notifyId=$('#add_send').attr('noid');
                $.ajax({
                    url: "updateNotify",
                    type: "post",
                    data: {
                        notifyId:notifyId,//主键ID
                        subject:$('#add_titileTime').val(),//标题
                        toId:$('#query_toId').attr('deptid'),//部门发布范围
                        format:0,//格式
                        typeId:$('#add_type_notice option:checked').val(),//公告类型
                        //startTime:$('#notice_start_add').val(),//有效期
                        userId:$('#query_userId').attr("user_id"),//按人员发布
                        privId:$('#query_privId').attr('userpriv'),//按角色发布
                        attachmentId:aId,//附件ID串
                        attachmentName:uId,//附件名称串
                        download:$(".down").is(':checked')==false?0:1,//是否允许下载office附件(0-不允许,1-允许)
                        subjectColor:'',//标题颜色
                        keyword:$('.keyword_ip').val(),//内容关键词
                        topDays:$('#textDay').val(),//置顶天数
                        publish:$(this).attr('value'),//发布标识(0-未发布,1-已发布,2-待审批,3-未通过)
                        top:$("#textTop").eq(0).is(':checked')==false?0:1,//是否置顶(0-否,1-是)
                        /* /!* top:$("#add_textTop").is(':checked')==false?0:1,//是否置顶(0-否,1-是),*!/*/
                        summary:$('#add_summny').val(),//内容简介
                        content:ue.getContent(),//内容
                        sendTimes:$('#add_newDate').val(),//发布时间
                        beginDates:$('#notice_start_add').val(),//开始日期
                        endDates:$('#notice_end_add').val(),  //结束日期
                        remind:remindVal//事务提醒
                    },
                    dataType: 'json',
                    success: function (obj) {

                        if(obj.flag==true){
                            $.layerMsg({content:' <fmt:message  code="depatement.th.Modifysuccessfully"/>！',icon:1},function(){
                                window.location.reload();
                            });
                        }

                    }
                })
            }

        })

        //修改保存的数据接口
        function update(data_notice){
            $.ajax({
                url: "updateNotify",
                type: "post",
                data: data_notice,
                dataType: 'json',
                success: function (obj) {

                    if(obj.flag==true){
                        $.layerMsg({content:' <fmt:message  code="depatement.th.Modifysuccessfully"/>！',icon:1},function(){
                            window.location.reload();
                        });
                    }

                }
            })
        }

        //修改公告通知管理
        $('#j_tb').on('click','.notice_change',function(){
            $('.nav_t2').html('<fmt:message code="notify.th.AnnounceNoticeOfNotice" />');/*修改公告通知*/

            var tid=$(this).attr('notifyId');
            $('.step1').hide();
            $('.step2').show();
            $('#add_send').attr('ac',"update");
            $('#add_send').attr('noId',tid);

            $('.center').hide();
            $('#add_baocun').attr('attrType','edit');
            ue.ready(function(){
                //公告详情
                $.ajax({
                    url: "getOneById",
                    type: "get",
                    data:{
                        notifyId:tid,
                        permissionId:'1',
                        changId:'1'
                    },
                    dataType: 'json',
                    success: function (obj) {
                        var data=obj.object;
                        var durl;
                        var attachs='';
                        for(var i=0;i<data.attachment.length;i++){
                            attachs += '<div class="dech" deUrl="'+data.attachment[i].attUrl+'"><a class="ATTACH_a" NAME="'+data.attachment[i].attachName+'*" href="/download?'+data.attachment[i].attUrl+'">'+data.attachment[i].attachName+'</a><img class="deImg" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data.attachment[i].attachName+'*"  class="inHidden" value="'+data.attachment[i].aid+'@'+data.attachment[i].ym+'_'+data.attachment[i].attachId+',"></div>'//附件内容
                        }

                        var endTime=new Date((data.endDate)*1000).Format('yyyy-MM-dd hh:mm:ss');
                        var beginDate=new Date((data.beginDate)*1000).Format('yyyy-MM-dd hh:mm:ss');
                        $('#add_titileTime').val(data.subject);
                        $('#query_privId').val(data.rolerange);//选角色
                        $('#query_privId').attr('userpriv',data.privId);
                        $('#query_userId').val(data.userrange);//选人
                        $('#query_userId').attr('user_id',data.userId);
                        $('#query_toId').val(data.deprange);//选部门
                        $('#query_toId').attr('deptid',data.toId);
                        /*if($('.start_time').val()==''){
                            $('#notice_start_add').val('');//起始时间
                        }else{
                            $('#notice_start_add').val(data.beginDate);//起始时间
                        }
                        if($('.end_time').val()==''){
                            $('#notice_end_add').val('');//结束时间
                        }else{
                            $('#notice_end_add').val(data.endDate);//结束时间
                        }*/

                        $('#notice_start_add').val(data.begin),//开始日期
                            $('#notice_end_add').val(data.end),  //结束日期
                            $('#add_newDate').val(data.notifyDateTime);//发布时间


                        $('#query_uploadArr').html(attachs);//附件

                        //  $("#add_type_notice").find("option[value="+data.typeId+"]").attr("selected",true);//类型
                        if(data.top==1){
                            $('#textTop').prop('checked',true);//是否置顶
                        };
                        ue.setContent(data.content);//内容
                        if(data.top==1){
                            $('.print').prop('checked',true);//是否打印
                        }
                        if(data.top==1){
                            $('.down').prop('checked',true);//是否下载
                        }
                        $('#add_type_notice').val(data.typeId);//公告类型
                        $('#textDay').val(data.topDays)//置顶天数
                        $('#add_summny').val(data.summary);//内容
                        $('.keyword_ip').val(data.keyword);//关键词


                    }

                })
            })

        });
        //点击复选框
        $("#j_tb").on('click','#notice_tr',function () {
            /*    alert('111');*/
            var state=$(this).find('.checkChild').prop("checked");
            if(state==true){
                $(this).find('.checkChild').prop("checked",true);
                $(this).addClass('bgcolor');
            }else{
                $('#checkedAll').prop("checked",false);
                $(this).find('.checkChild').prop("checked",false);
                $(this).removeClass('bgcolor');
            }
            var child =   $(".checkChild");
            for(var i=0;i<child.length;i++){
                var childstate= $(child[i]).prop("checked");
                if(state!=childstate){
                    return
                }
            }
            $('#notice_tr').prop("checked",state);
        })
        //点击全选
        $('#j_tb').on('click','#checkedAll',function(){
            /*alert('111');*/
            var state =$(this).prop("checked");
            if(state==true){
                $(this).prop("checked",true);
                $(".checkChild").prop("checked",true);
                $(this).parents('tr').siblings('#notice_tr').addClass('bgcolor');
            }else{
                $(this).prop("checked",false);
                $(".checkChild").prop("checked",false);;
                $(this).parents('tr').siblings('#notice_tr').removeClass('bgcolor');
            }
        })
        //删除封装的方法
        function dataDelete(fileId){
            layer.confirm(' <fmt:message  code="global.lang.sure"/>', {
                btn: [' <fmt:message  code="global.lang.ok"/>',' <fmt:message  code="depatement.th.quxiao"/>'], //按钮
                title:" <fmt:message  code="notice.th.DeleteFile"/>"
            }, function(){
                //确定删除，调接口
                $.ajax({
                    type:'post',
                    url:'/myNotice/deleteByIds',
                    dataType:'json',
                    data:{'notifyIds':fileId},
                    success:function(){
                        layer.msg(' <fmt:message  code="workflow.th.delsucess"/>', { icon:6});
                        /* init(4,id,1);*/
                        window.location.reload();
                    }
                })

            }, function(){
                layer.closeAll();
            });

        }
        //点击删除选中按钮
        $('#j_tb').on('click','.delete_check',function(){
            /* alert('111');*/
            var fileId=[];
            $("#j_tb .checkChild:checkbox:checked").each(function(){

                var conId=$(this).attr("conId");
                /*  alert(conId);*/
                fileId.push(conId);

            })
            if(fileId == ''){
                $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:1});
            }else{
                /*    $('.contentTrs').remove();
                    $('.mainContent').show();
                    $('.details').hide();*/
                dataDelete(fileId)
            }
        })


        //设置置顶
        $('#j_tb').on('click','.notice_top',function(){
            var fileId=[];
            $("#j_tb .checkChild:checkbox:checked").each(function(){
                var conId=$(this).attr("conId");
                fileId.push(conId);

            })
            if(fileId == ''){
                $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:1});
            }else{
                layer.confirm(' <fmt:message  code="notice.th.ifTop"/>？', {
                    btn: [' <fmt:message  code="global.lang.ok"/>',' <fmt:message  code="depatement.th.quxiao"/>'], //按钮
                    title:" <fmt:message  code="notice.th.TopFile"/>"
                }, function(){
                    //确定删除，调接口
                    $.ajax({
                        type:'post',
                        url:'/myNotice/updateByIds',
                        dataType:'json',
                        data:{
                            notifyIds:fileId,
                            top:'1'
                        },
                        success:function(){
                            layer.msg(' <fmt:message  code="notice.th.TopSuccess"/>', { icon:6});
                            /* init(4,id,1);*/
                            window.location.reload();
                        }
                    })

                }, function(){
                    layer.closeAll();
                });
            }
        })
        //取消置顶
        $('#j_tb').on('click','.notice_notop',function(){
            var fileId=[];
            $("#j_tb .checkChild:checkbox:checked").each(function(){
                var conId=$(this).attr("conId");
                fileId.push(conId);

            })
            if(fileId == ''){
                $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:1});
            }else{
                layer.confirm('<fmt:message  code="notice.th.cancelTop"/>？ ', {
                    btn: [' <fmt:message  code="global.lang.ok"/>',' <fmt:message  code="depatement.th.quxiao"/>'], //按钮
                    title:" <fmt:message  code="notice.th.CancelTopFile"/>"
                }, function(){
                    //确定删除，调接口
                    $.ajax({
                        type:'post',
                        url:'/myNotice/updateByIds',
                        dataType:'json',
                        data:{
                            notifyIds:fileId,
                            top:'0'
                        },
                        success:function(){
                            layer.msg(' <fmt:message  code="notice.th.CancelTopSuccess"/>', { icon:6});
                            /* init(4,id,1);*/
                            window.location.reload();
                        }
                    })

                }, function(){
                    layer.closeAll();
                });
            }
        })
        //查阅情况
        $('#j_tb').on('click','.find_detail',function(){
            /* alert('111');*/
            var notifyId=$(this).attr('notifyId');
            $.popWindow("finddetail?notifyId="+notifyId,'查阅情况','0','0','1150px','700px');
        })


        //删除公告通知管理
        $('#j_tb').on('click','.notice_delete',function(){
            var that = $(this).parents('#notice_tr');
            var tid=$(this).attr('notifyId');

            layer.confirm(' <fmt:message  code="global.lang.sure"/>', {
                btn: [' <fmt:message  code="global.lang.ok"/>',' <fmt:message  code="depatement.th.quxiao"/>'] ,//按钮
                title:' <fmt:message  code="workflow.th.suredel"/>'
            }, function(){
                //确定删除，调接口
                $.ajax({
                    url: "/myNotice/deleteById",
                    type: "get",
                    data:{
                        notifyId:tid
                    },
                    dataType: 'json',
                    success: function (obj) {
                        //第三方扩展皮肤
                        layer.msg(' <fmt:message  code="workflow.th.delsucess"/>', { icon:6});

                        that.remove();
                    }
                })

            }, function(){
                layer.closeAll();
            });


        })
        //删除附件
        function deleteChatment(data,element){

            layer.confirm(' <fmt:message  code="workflow.th.que"/>', {
                btn: [' <fmt:message  code="global.lang.ok"/>',' <fmt:message  code="depatement.th.quxiao"/>'], //按钮
                title:" <fmt:message  code="notice.th.DeleteAttachment"/>"
            }, function(){
                //确定删除，调接口
                $.ajax({
                    type:'get',
                    url:'../delete',
                    dataType:'json',
                    data:data,
                    success:function(res){

                        if(res.flag == true){
                            layer.msg(' <fmt:message  code="workflow.th.delsucess"/>', { icon:6});
                            element.remove();
                        }else{
                            layer.msg(' <fmt:message  code="lang.th.deleSucess"/>', { icon:6});
                        }
                    }
                });

            }, function(){
                layer.closeAll();
            });
        }

        //点击x，删除附件
        $('.enclosure').on('click','.deImg',function(){
            var data=$(this).parents('.dech').attr('deUrl');
            var dome=$(this).parents('.dech');
            deleteChatment(data,dome);
        })




    });

    /* 终止和生效方法 */

    function stoprwo(me,id,publishId,stopId){
        var pulbish;
        /*  alert($(stopId).html()); */
        if($('#'+stopId).html()=='<fmt:message code="notice.state.end" />'){
            pulbish = "2";
            /* 	alert(2); */
        }else if($('#'+stopId).html() == '<fmt:message code="notice.state.effective" />'){
            pulbish = "1";
        }
        var data={
            "notifyId":id,
            "publish":pulbish  // 发布标识(0-未发布,1-已发布,2-已终止)
        };
        $.ajax({
            url:"updateNotify",
            type:'post',
            dataType:"JSON",
            data : data,
            success:function(data){
                if($(me).html()=='<fmt:message code="notice.state.end" />'){
                    $(me).parent().prev().html("<fmt:message code="notice.state.end" />");
                    $(me).html("<fmt:message code="notice.state.effective" />");
                }else if($(me).html() == '<fmt:message code="notice.state.effective" />'){
                    $(me).parent().prev().html("<fmt:message code="notice.state.effective" />");
                    $(me).html("<fmt:message code="notice.state.end" />");
                }
            },
            error:function(e){
            }
        });

    }

    var now = null;
    function queryTime(){
        function p(s) {
            return s < 10 ? '0' + s: s;
        }

        var myDate = new Date();
        //获取当前年
        var year=myDate.getFullYear();
        //获取当前月
        var month=myDate.getMonth()+1;
        //获取当前日
        var date=myDate.getDate();
        var h=myDate.getHours();       //获取当前小时数(0-23)
        var m=myDate.getMinutes();     //获取当前分钟数(0-59)
        var s=myDate.getSeconds();

        now=year+'-'+p(month)+"-"+p(date)+" "+p(h)+':'+p(m)+":"+p(s);
    }

    laydate({
        elem: '#add_newDate', //目标元素。
        format: 'YYYY-MM-DD hh:mm:ss', //日期格式
        istoday: true,
        istime: true //显示时、分、秒
    });

    //查询公告时间控件调用
    var start = {
        elem: '#beginTime',
        format: 'YYYY-MM-DD hh:mm:ss',
        /* min: laydate.now(), //设定最小日期为当前日期
         max: '2099-06-16 23:59:59', //最大日期*/
        istime: true,
        istoday: false,
        choose: function(datas){
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas; //将结束日的初始值设定为开始日
        }
    };
    var end = {
        elem: '#endTime',
        format: 'YYYY-MM-DD hh:mm:ss',
        /*     min: laydate.now(),
             max: '2099-06-16 23:59:59',*/
        istime: true,
        istoday: false,
        choose: function(datas){
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };

    /*新建公告时间控件调用*/

    var starts = {
        elem: '#notice_start_add',
        format: 'YYYY-MM-DD',
        /*        min: laydate.now(), //设定最小日期为当前日期
                max: '2099-06-16 23:59:59', //最大日期*/
        istime: true,
        istoday: false,
        choose: function(datas){
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas; //将结束日的初始值设定为开始日
        }
    };
    /*新建公告时间控件调用*/

    var starts = {
        elem: '#notice_start_add',
        format: 'YYYY-MM-DD',
        /*        min: laydate.now(), //设定最小日期为当前日期
                max: '2099-06-16 23:59:59', //最大日期*/
        istime: true,
        istoday: false,
        choose: function(datas){
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas; //将结束日的初始值设定为开始日
        }
    };
    var ends = {
        elem: '#notice_end_add',
        format: 'YYYY-MM-DD',
        /*       min: laydate.now(),
               max: '2099-06-16 23:59:59',*/
        istime: true,
        istoday: false,
        choose: function(datas){
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };
    /*   find_start*/
    var find_start = {
        elem: '#find_start',
        format: 'YYYY-MM-DD',
        /*       min: laydate.now(),
         max: '2099-06-16 23:59:59',*/
        istime: true,
        istoday: false,
        choose: function(datas){
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };
    var find_end = {
        elem: '#find_end',
        format: 'YYYY-MM-DD',
        /*       min: laydate.now(),
         max: '2099-06-16 23:59:59',*/
        istime: true,
        istoday: false,
        choose: function(datas){
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };
    laydate(start);
    laydate(end);
    laydate(starts);
    laydate(ends);
    laydate(find_start);
    laydate(find_end);




</script>
<script>
    $(function(){


        var num =$.GetRequest().num||'';
        var flowId = $.GetRequest().flowId|| '';
        var flowStep = $.GetRequest().flowStep || '';
        var runId = $.GetRequest().runId || '';
        var prcsId=$.GetRequest().prcsId || '';

        ue.ready(function () {
            if(num.indexOf('1')!=-1){
                workForm.init({
                        formhtmlurl:'../../workflow/work/workfastAdd',//URL
                        resdata:{
                            flowId:flowId,
                            runId:runId,
                            flowStep:flowStep,
                            prcsId:prcsId
                        },
                        flowStep:flowStep,//预览
                        target:'.cont_form',
                        preView:true},
                    function (data,option,obj) {
                        ue.setContent(ue.getContent()+obj.html());//内容
                    });

            }

            if(num.indexOf('2')){
                $.post('/flowProcess/getFlowAttachment',{'runId':$.GetRequest().runId},function (json) {
                    if(json.flag){
                        var str='';
                        for(var i=0;i<json.obj.length;i++){
                            str+='<tr class="/download?'+json.obj[i].attUrl+'"><td class="fileDownload" align="center">'+json.obj[i].attachName+'</td><td align="center">11</td><td align="center">sss</td></tr>'
                        }

                    }
                    ue.setContent(ue.getContent()+str);//内容
                },'json')

            }

            if(num.indexOf('3')){
                $.post('/flowProcess/getFlowFeedBack',{'runId':$.GetRequest().runId},function (json) {
                    if(json.flag){
                        var str1='';
                        var arr=json.obj;
                        for(var i=0;i<arr.length;i++){
                            str1+=' <tr style="background: #fff;margin-top: 10px;">\
                        <td width="70%"><p style="font-weight: bold"><fmt:message code="workflow.th.First" />'+arr[i].prcsId+'<fmt:message code="workflow.th.step" />'+arr[i].prcsName+' '+arr[i].userName+'：</p> <p style="margin: 10px;">'+arr[i].content+'</p></td>\
                        <td width="30%" align="right">'+arr[i].editTime+'</td>\
                    </tr>'
                        }
                        ue.setContent(ue.getContent()+str1);//内容
                    }
                },'json')
            }


            if(num.indexOf('4')){
                $.get('/flowProcess/getFlowRunPrecsAll',{
                    'runId':$.GetRequest().runId
                },function (json) {
                    if(json.flag){
                        var str='';
                        var designdata=json.datas;
                        for(var i=0;i<designdata.length;i++){
                            str+='<tr style="border-right: 1px solid #ddd">' +
                                '<td width="30%" align="center"><fmt:message code="workflow.th.First" />'+(i+1)+'<fmt:message code="workflow.th.step" /></td>' +
                                '<td width="35%" align="center"><img src="/img/arrow_down.gif" alt=""><fmt:message code="workflow.th.Serial" />'+(i+1)+'：'+designdata[i].prcsName+'</td>' +
                                '<td width="35%" align="center"><img src="/img/workflow.gif" alt=""><a style=" color: red;text-decoration:underline" href="javascript:void(0)">' +
                                ''+designdata[i].userName +'&nbsp'+function () {
                                    if (designdata[i].opFlag == 0) {
                                        return '<fmt:message code="workflow.th.HandledBy" />'
                                    } else if (designdata[i].opFlag == 1) {
                                        return '<fmt:message code="workflow.th.host" />'
                                    }
                                }()+'</a><span style="color: #00aa00;margin-left: 5px;">('+function () {
                                    if (designdata[i].prcsFlag == 1) {
                                        return '<fmt:message code="sup.th.NotReceived" />'
                                    } else if (designdata[i].prcsFlag == 2) {
                                        return '<fmt:message code="lang.th.Process" />'+designdata[i].handleTime
                                    } else if (designdata[i].prcsFlag == 3) {
                                        var handleTimes;
                                        if(designdata[i].handleTime==undefined){
                                            handleTimes=''
                                        }else {
                                            handleTimes=designdata[i].handleTime
                                        }
                                        return '<fmt:message code="workflow.th.ForwardToTheNextStep" />' + handleTimes
                                    } else if (designdata[i].prcsFlag == 4) {
                                        return '<fmt:message code="lang.th.HaveThrough" />'+designdata[i].handleTime
                                    } else if (designdata[i].prcsFlag == 5) {
                                        return '<fmt:message code="workflow.th.FreeFlowPresettingSteps" />'
                                    } else if (designdata[i].prcsFlag == 6) {
                                        return '<fmt:message code="workflow.th.HasBeenSuspended" />'
                                    }
                                }()+')</span><p><fmt:message code="workflow.th.StartedOn" />: ' + designdata[i].createTime + '</p>' +
                                '<p><fmt:message code="workflow.th.EndTo" />: ' + designdata[i].deliverTime + '</p></td>' +
                                '</tr>'
                        }

                        ue.setContent(ue.getContent()+str);//内容
                    }
                },'json')

            }
        })









    })



</script>


</body>
</html>