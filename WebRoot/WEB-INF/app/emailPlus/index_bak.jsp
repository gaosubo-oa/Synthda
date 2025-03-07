
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
		<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title><fmt:message code="main.email" /></title><!-- 收件箱 -->
		<meta name="renderer" content="webkit">
	    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
		<link rel="stylesheet" type="text/css" href="/css/email/inbox.css"/>
		<link rel="stylesheet" type="text/css" href="/css/email/inbox-upright.css"/>

		<script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
		<script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
		<script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
		<script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
		<script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
		<script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
		<script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
		<script src="../lib/laydate/laydate.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/common/language.js"></script>
		<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
		<script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
		<script src="/js/jquery/jquery.form.min.js"></script>
		<script src="../js/jquery/jquery.cookie.js"></script>
		<script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/email/writeMail.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/email/inbox_list.js" type="text/javascript" charset="utf-8"></script>
		<style>
			a{text-decoration: none;}
			table{
				/*border-collapse: collapse;*/
				border-color: #ccc;
			}
			.main_left .BTN:hover{background:#c5e9fb;}
			.attachment a{text-decoration: none;}
			.attachment a img{vertical-align: middle;}
			.befor .searchTxt{width:70%;height:30px;padding-left:5px;margin-bottom:5px;}
			.UP_INBOX .tab table .Hover:hover{background-color:#c5e9fb;}
			.Hover img{width:16px;}
			.on_tr{background-color: #c5e9fb !important;}
			.UP_INBOX,.UP_INBOX .tab,.UP_INBOX .tab table{width: 99%;}
			.UP_INBOX .tab table tr{border: 1px solid #c0c0c0;}
			.UP_INBOX .tab table tr th{color: #2F5C8F;font-weight: normal;}
			.UP_INBOX .tab table tr:nth-child(odd){background-color: #fff;}
			.UP_INBOX .tab table tr:nth-child(even){background-color: #F6F7F9;}
			.UP_INBOX .tab table tr th,.UP_INBOX .tab table tr td{padding:10px;}
			.UP_INBOX,.UP_INBOX .tab,.UP_INBOX .tab table tr th.theme{text-align: center}
			.UP_INBOX .tab table .theme_a a{text-decoration: none;text-align: left;display: block;color:#2B7FE0;}
			.M-box3{margin-top:10px;float:right;margin-right: 7px;}
			.M-box3 a{margin: 0 3px;width: 29px;height: 29px;line-height: 29px;font-size: 12px;text-decoration: none;}
			.M-box3 .active{margin: 0px 3px;width: 29px;height: 29px;line-height: 29px;background: #2b7fe0;font-size: 12px;border: 1px solid #2b7fe0;}
			.jump-ipt{margin: 0 3px;width: 29px;height: 29px;line-height: 29px;font-size: 12px;}
			.M-box3 a:hover{background: #2b7fe0;}
			.set_up_ul{font-size: 14px;border: #ccc 1px solid;border-radius: 5px;width: 80%;background-color: #fff;position: absolute;bottom: 42px;margin-left: 5px}
			.set_up_ul ul{list-style: none;}
			.set_up_ul ul li{width: 100%;text-align: center;color: #000;height:25px;line-height:25px;}
			.set_up_ul ul li:hover{background-color: #6ea1d5;color:#fff;cursor: pointer;}
			.RemoveTo_div{font-size: 12px;border: #ccc 1px solid;border-radius: 5px;min-width:160px;background-color: #fff;position: absolute;left:0px;top: 30px;z-index: 9999;}
			.RemoveTo_div ul li{padding: 5px 10px;display:block;clear: both;}
			.RemoveTo_div .RemoveTo_child:hover{background-color: #6ea1d5;color:#fff;cursor: pointer;}
			.allEmail_div{font-size: 12px;border: #ccc 1px solid;border-radius: 5px;min-width:150px;background-color: #fff;position: absolute;left: 18.3%;top: 52px;z-index: 9999;}
			.allEmail_div ul li{padding: 5px 10px;display:block;clear: both;}
			.allEmail_div ul li:hover{background-color: #6ea1d5;color:#fff;cursor: pointer;}
			textarea{width: 230px;height: 50px;margin: 5px;}
			.noEmail_img{width: 163px;height: 162px;margin: 170px auto;}
			.noContent{width: 50px;margin: 200px auto;}
			.main_right table tr td>span>span{
				float: left;
			}
			.page .page_left .write .d_im{
				background: url(../../img/email/icon_normal_01.png) no-repeat;
				background-size:100% 100%;
			}
			.main .main_left ul li .xia img{
				float: none;
				position: absolute;
				margin-right: 0;
				right: 8%;
			}
			.inbox_btn_tim{
				height: 52px;
			}
			.page .page_left .inbox_btn{
				height: 52px;
				line-height: 52px;
			}
			img[src=""],img:not([src]){opacity:0;}
			.up_page_right{overflow-y: hidden}
			/*.main{overflow: hidden}*/
			input{background:none}
			.ul_showtwo{
				background: #6596c8;
			}
			.divUlShow{
				background: #6596c8;
			}
			.div_down{
				background: url(/img/icon_more_dakai_07.png) no-repeat 75% center;
			}
			.main_middle{
				position: absolute;
				float: left;
				width: 8px;
				height: 100%;
				background: #cee7ff;
				left:28%;
				cursor: col-resize;
				z-index: 10;
			}
			#divTbaleText{
				border-collapse: collapse;
			}
			#divTbaleText tr{
				border:#ccc 1px solid;
			}
			#divTbaleText tr th{
				padding: 5px;
			}
			#divTbaleText tr td{
				padding: 5px;
			}
		</style>
		<script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>
		<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
		<script>
			$(function () {
				if($('#InBox').find('img').prop('src').indexOf('theme2')!=-1||$('#InBox').find('img').prop('src').indexOf('theme4')!=-1){
                    $('#InBox').find('img').prop('src','/img/commonTheme/${sessionScope.InterfaceModel}/icon_inbox_07-.png')
					$('.ul_showtwo ul>li').click(function () {
						if($(this).hasClass('on')){
						    if($(this).find('img').prop('src').indexOf('-')==-1) {
                                $(this).siblings('li').each(function (i,n) {
                                    $(this).find('img').prop('src',$(this).find('img').prop('src').replace(/-/g,''))
                                })
                                $(this).parents('.inBox').next().find('.divUlShow').find('li').each(function () {
                                    $(this).find('img').prop('src',$(this).find('img').prop('src').replace(/-/g,''))

                                })


                                $(this).find('img').prop('src', $(this).find('img').prop('src').split('.png')[0] + '-' + '.png')
                            }
						}
                    })
					$(document).on('click','.divUlShow>ul>li',function () {
                        if($(this).hasClass('on')){
                            if($(this).find('img').prop('src').indexOf('-')==-1) {
                                $(this).siblings('li').each(function (i,n) {
                                    $(this).find('img').prop('src',$(this).find('img').prop('src').replace(/-/g,''))
                                })
                                $(this).parents('.other').prev().find('.ul_showtwo').find('li').each(function () {
                                    $(this).find('img').prop('src',$(this).find('img').prop('src').replace(/-/g,''))

                                })


                                $(this).find('img').prop('src', $(this).find('img').prop('src').split('.png')[0] + '-' + '.png')
                            }
                        }
                    })
				}
            })
		</script>
	</head>
	<body>
		<div class="page">
			
				<!--左侧侧边栏 开始-->
				<div class="page_left">
					<!--写邮件-->
					<div class="write">
						<div class="d_im" style="text-align:center;background-size:100% 100%;">

								<img src="/img/commonTheme/${sessionScope.InterfaceModel}/writeemail.png" alt="" style="width: 16px;height: 16px;margin-bottom: -2px;margin-right: 3px;">
								<span><fmt:message code="email.title.waitmail" /></span>
						</div>
					</div>
					<!--收件箱-->
					<div class="inBox">
						<a href="javascript:;" class="inbox_btn">
							<div class="inbox_btn_tim div_down" ><fmt:message code="email.title.mailbox" /></div>
						</a>
						<div class="ul_show ul_showtwo" style="display: block;">
							<ul>
								<li id="InBox" class="on Inbox"><a href="javascript:;"><img src="../img/commonTheme/${sessionScope.InterfaceModel}/icon_inbox_07.png"/><fmt:message code="email.title.inbox" /><span></span></a></li>
								<li id="drafts"><a href="javascript:;"><img src="../img/commonTheme/${sessionScope.InterfaceModel}/icon_drafts_07.png"/><fmt:message code="email.title.draftbox" /><span></span></a></li>
								<li id="hasBeenSend"><a href="javascript:;"><img src="../img/commonTheme/${sessionScope.InterfaceModel}/icon_sent_07.png"/><fmt:message code="email.title.sent" /><span></span></a></li>
								<li id="wastebasket"><a href="javascript:;"><img src="../img/commonTheme/${sessionScope.InterfaceModel}/icon_dustbin_07.png"/><fmt:message code="email.title.wastebasket" /></a></li>
								<li class='liSearch'><a href="javascript:;"><img src="../img/commonTheme/${sessionScope.InterfaceModel}/icon_search_03.png"/><fmt:message code="email.title.querymail" /></a></li>
							</ul>
						</div>
					</div>
					<!--其他邮件箱-->
					<div class="other">
						<a href="javascript:;" class="inbox_btn">
							<div class="inbox_btn_tim div_up"><fmt:message code="email.title.othermailbox" /></div>
						</a>
						<div class="ul_show divUlShow" >
							<ul>
								<%--<li><a href="javascript:;"><img src="../img/icon_file_11.png"/><fmt:message code="email.title.oneselffile" /></a></li>--%>
							</ul>
						</div>
						
					</div>
					<!--邮件智能分类-->
					<%--<div class="classify">
						<a href="javascript:;" class="inbox_btn">
							<div class="inbox_btn_tim div_up"><fmt:message code="email.title.mailsort" /></div>
						</a>
						<div class="ul_show spac_show">
							<ul>
								<li><a href="javascript:;"><span><fmt:message code="email.th.keywordchart" /></span></a></li>
								<li><a href="javascript:;"><span><fmt:message code="email.th.agenda" /></span></a></li>
								<li><a href="javascript:;"><span><fmt:message code="email.th.meeting" /></span></a></li>
								<li><a href="javascript:;"><span><fmt:message code="email.th.log" /></span></a></li>
								<li><a href="javascript:;"><span><fmt:message code="email.th.report" /></span></a></li>
								<li><a href="javascript:;"><span><fmt:message code="email.th.plan" /></span></a></li>
								<li><a href="javascript:;"><span><fmt:message code="email.th.notify" /></span></a></li>
								<li><a href="javascript:;"><span><fmt:message code="email.th.news" /></span></a></li>
								<li><a href="javascript:;"><span><fmt:message code="email.th.document" /></span></a></li>
								<li><a href="javascript:;"><span><fmt:message code="email.th.Project" /></span></a></li>
								<li><a href="javascript:;"><span><fmt:message code="email.th.personnel" /></span></a></li>
								<li><a href="javascript:;"><span><fmt:message code="email.th.assessment" /></span></a></li>
								<li><a href="javascript:;"><span><fmt:message code="email.th.Report" /></span></a></li>
								<li><a href="javascript:;"><span><fmt:message code="email.th.workflow" /></span></a></li>
								<li><a href="javascript:;"><span><fmt:message code="email.th.client" /></span></a></li>
								<li><a href="javascript:;"><span><fmt:message code="email.th.contract" /></span></a></li>
							</ul>
						</div>
					</div>--%>
					<!--邮箱设置-->
					<div class="setUp">
						<a href="javascript:;" class="aSeting">
							<img class="setUp_img" src="../img/icon_setmail_11.png"/>
							<span><fmt:message code="email.th.mailimpost" /></span>
						</a>
						<a href="javascript:;" class="aReflresh" >
							<img class="loding" src="../img/icon_refresh_11.png"/>
						</a>
						<div class="set_up_ul" style="display:none;">
							<ul>
								<li class="exceptLi"><fmt:message code="Email.th.Manageboxes" /></li>
								<%--<li class="externalMail">Internet邮箱</li>--%>
								<%--<li>导入Internet邮箱</li>
								<li>邮箱整理</li>
								<li>POP3设置</li>--%>
							</ul>
						</div>
					</div>
				</div>
			
			<!--左侧侧边栏 结束-->
			
			<!--右侧侧边栏 开始-->
			<div class="up_page_right">
				<div class="up_header">
					<div class="up_nav">
						<ul>
							<li id="allEmail" style="margin-right: 15%;"><img src="../img/icon_allmail_06.png" class="im"/><fmt:message code="email.th.allmail" /><img src="../img/icon_more_06.png" class="more_im"/></li>
							<li id="withdraw" style="display: none;"><fmt:message code="withdraw.th.draw" /></li>
							<%--<li onclick="clicked()"><img src="../img/icon_notread_06.png" class="im"/><fmt:message code="email.th.unread" /><span>3</span></li>--%>
							<li id="Replay"><img src="../img/icon_replay_03.png" class="im"/><fmt:message code="global.lang.reply" /></li>
							<li id="ReplayAll"><img src="../img/icon_replay_03.png" class="im"/><fmt:message code="email.th.replyall" /></li>
							<li id="Forward"><img src="../img/icon_transmit_06.png" class="im"/><fmt:message code="email.th.transmit" /></li>
							<li id="RemoveTo" style="position: relative;">
								<img src="../img/icon_move_06.png" class="im"/><fmt:message code="email.th.remove" /><img src="../img/icon_more_06.png" class="more_im"/>
								<div class="RemoveTo_div" style="display:none;">
									<ul>

									</ul>
								</div>
							</li>
							<li id="delete"><img src="../img/icon_delete_06.png" class="im"/><fmt:message code="global.lang.delete" /></li><%--<img src="../img/icon_more_06.png" class="more_im"/>--%>
							<%--<li onclick="clicked()"><fmt:message code="email.th.more" /><img src="../img/icon_more_06.png" class="am"/></li>--%>
						</ul>

						<div class="allEmail_div" style="display:none;">
							<ul>
								<li attrAll=""><fmt:message code="email.th.allmail" /></li>
								<li attrAll="0"><fmt:message code="workflow.th.Internalmail" /></li>
								<%--<li attrAll="1"><fmt:message code="workflow.th.ExternalMail" /></li>--%>
							</ul>
						</div>
					</div>
					<div class="up_pages">
						<%--<div class="up_div_pages">
							<ul>
								<li onclick="clicked()"><img src="../img/icon_left_03.png"/><fmt:message code="email.th.beforemail" /><span>|</span></li>
								<li onclick="clicked()"><fmt:message code="email.th.nextmail" /><img src="../img/icon_right_03.png"/></li>
							</ul>
						</div>--%>
						<div class="up_format">
							<ul>
								<li class="for_on"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_zuoyou_sel_03.png" id="ul_imgs"/></li>
								<li><img src="../img/iCon_list_003.png" id="ul_img"/></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="main" style="display: block;position: relative;">
					<div class="main_left" style="position: relative;border-right: none;left: 0px;">
						<ul style="display: block;padding-bottom: 10px;">
							<li class="befor">
								<div class="sort">
									<img class="Search" title='<fmt:message code="workflow.th.sousuo" />' src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_search_03(1).png"/><%--搜索--%>
									<img class="ReFresh" title='<fmt:message code="global.lang.refresh" />' src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_shuaxin_03.png"/><%--刷新--%>
									<img class="signReaders" title='<fmt:message code="main.th.taggedRead" />' src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_duoxuan_03.png"/><%--标记已读--%>
									<img class="selectReaders" title='<fmt:message code="notice.th.allSelect" />' src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_dx_01.png"/><%--标记已读--%>
								</div>
								<div class="sort_right">
									<img src="../img/icon_shaixuan_03.png"/><fmt:message code="email.th.order" />
								</div>
								<div style="clear: both"></div>
								<div style="display:none;" class="search_div">
									<input type="text" name="text" class="searchTxt" placeholder="<fmt:message code="main.th.ContentSearch" />"><span class="cancleSpan"><fmt:message code="depatement.th.quxiao" /></span>
								</div>
								<div class="signDiv" style="display: none;">
									<ul id="orderByName">
										<li orderByName="2"><fmt:message code="global.lang.date" /></li>
										<li orderByName="3"><fmt:message code="email.th.sender" /></li>
										<li orderByName="4"><fmt:message code="main.th.ReadNot" /></li>
										<li orderByName="5"><fmt:message code="main.th.Star" /></li>
										<li orderByName="6"><fmt:message code="email.th.file" /></li>
									</ul>
									<ul id="orderWhere">
										<li orderWhere="0" style="border-top:#ccc 1px solid;"><fmt:message code="netdisk.th.asc" /></li>
										<li orderWhere="1"><fmt:message code="netdisk.th.desc" /></li>
									</ul>
								</div>
							</li>
						</ul>
						<div class="noContent" style="display: none;"><span><fmt:message code="Email.th.noNote" /></span></div>
					</div>
					<div class="main_middle"></div>
					<div class="main_div_right" style="width: 71%;float: left;">
						<%--没有邮件显示--%>
						<div class="main_right noEmail" style="display: none;">
							<div class="noEmail_img">
								<img src="../img/img_nomessage_03.png" alt='<fmt:message code="main.th.emptyInbox" />'><%--空收件箱--%>
							</div>
						</div>
						<!-- 收件箱 -->
						<div class="main_right InBox" style="display: block;">
						
							<table id="TAB" cellspacing="0" cellpadding="0" style="border-collapse:collapse;table-layout: fixed;">
								
							</table>
							<span class="span_hr">
								<div class="attrImg"><img /></div>
								<p><span></span>&nbsp;&nbsp;<span class="zong"></span></p>
								<%--<fmt:message code="email.th.subject" />--%>
								<%--<fmt:message code="email.th.dept" />--%>
								<p class="userdept"></p>
							</span>
							<div class="article"></div>
						</div>

						<!-- 草稿箱 -->
						<div class="main_right drafts" id="styleDrafts" style="display:none;margin-bottom: 59px;">
						
							<table border="1" cellspacing="0" cellpadding="0" style="">
								<tr class="append_tr">
									<td width="15%"><fmt:message code="email.th.recipients" />：</td>
									<td width="84%">
										<div class="inPole">
											<textarea name="txt" id="senduser" user_id='' value="" disabled style="width: 230px;height: 50px;"></textarea>
											<span class="add_img">
												<a href="javascript:;" id="selectUser" class="Add"><fmt:message code="global.lang.add" /></a>
											</span>
											<span class="add_img">
												<a href="javascript:;" class="clear"><fmt:message code="notice.th.delete1" /></a>
											</span>
											
										</div>
										<div class="addPepl">
											<a href="javascript:;" class="a1"><fmt:message code="email.th.addwait" /></a>
											<a href="javascript:;" class="a2"><fmt:message code="email.th.addbcc" /></a>
											<%--<a href="javascript:;" class="a3"><fmt:message code="email.th.recentcontacts" />&nbsp;</a>--%>
											<!-- <span class="day">
												<ul>
													<li>系统管理员</li>
													<li>王德</li>
													<li>王云</li>
												</ul>
											</span> -->
										</div>
									</td>
								</tr>
								<tr>
									<td><fmt:message code="email.th.major" />：</td>
									<td>
										<input style="width: 230px;height: 30px;color:#000;text-align: left;" type="text" id="txt" value="" class="input_txt" />
									</td>
								</tr>
								<tr>
									<td width="15%">
										<p><fmt:message code="email.th.content" />：</p>
										<p class="Color"><a href="javascript:;" onclick="empty()"><fmt:message code="global.lang.empty" /></a></p>
									</td>
									<td width="84%">
										<div id="container" style="width: 99.9%;min-height: 200px;" name="content" type="text/plain"></div>
									</td>
								</tr>
                                 <tr class="Attachment" style="width:100%;">
                                     <td width="10%"><fmt:message code="email.th.file" />：</td>
                                    <td width="89%"   class="files" id="files_txt"></td>
								</tr>
								<tr>
									<td><fmt:message code="email.th.filechose" />：</td>
									<td>
                                    	<form id="uploadimgform" target="uploadiframe" action="../upload?module=email" enctype="multipart/form-data" method="post"  onsubmit="document.charset='UTF-8';">
											<input type="file" multiple="multiple" name="file"  id="uploadinputimg"  class="w-icon5" style="position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                                        	<a href="javascript:;" id="uploadimg"><img style="margin-right:5px;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>
                                        </form>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<div class="div_btn" style="margin-left:30%;">
                                        	<div class="sureBtn" id="btn1"><span style="margin-left: 30px;"><fmt:message code="email.th.transmitimmediate" /></span></div>
                                        	<div class="saveBtn" id="btn2"><span style="margin-left: 33px;"><fmt:message code="email.th.savedraftbox" /></span></div>
											<!--<input type="button" id="btn1" style="cursor: pointer;width: 70px;border-radius: 5px;height: 30px;line-height: 30px;color: #000;" value="<fmt:message code="email.th.transmitimmediate" />" />
                                        	<input type="button" id="btn2" style="cursor: pointer;width: 90px;border-radius: 5px;height: 30px;line-height: 30px;color: #000;" value="<fmt:message code="email.th.savedraftbox" />" />-->
										</div>
									</td>
								</tr>
							</table>
						</div>
						
						<!-- 已发送 -->
						<div class="main_right hasBeenSend" style="display:none;">
							<table id="TAC" cellspacing="0" cellpadding="0" style="border-collapse:collapse;table-layout: fixed;">
								 <%--<tr class="MAIN2">--%>
									<%--<td width="8%"><fmt:message code="email.th.main" />：</td>--%>
								<%--</tr>--%>
								<%--<tr class="SEND2">--%>
									<%--<td><fmt:message code="email.th.recipients" />：</td>--%>
								<%--</tr>--%>
								<%--<tr class="DATE2">--%>
									<%--<td><fmt:message code="email.th.time" />：</td>--%>
								<%--</tr>--%>
							</table>
							<div class="article1" style="padding-left: 3%;"></div>
						</div>
						<!-- 废纸篓 -->
						<div class="main_right wastebasket" style="display:none;">
							<table id="TAD" cellspacing="0" cellpadding="0" style="border-collapse:collapse;table-layout: fixed;"></table>
							<div class="article2"></div>
						</div>

                        <!-- 其他邮件箱 -->
                        <div class="main_right otherMailFolder" style="display:none;">
							<table id="TAE" cellspacing="0" cellpadding="0" style="border-collapse:collapse;table-layout: fixed;"></table>
							<div class="article3"></div>
                         </div>
					</div>
				</div>

                 <%--横版收件箱列表--%>
				<div class="main_right UP_INBOX" style="display:none;">
                       <div class="tab">
                             <table cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
                                   <tr class='tr_befor'>
                                        <th width="6%">
                                        <input type="checkbox" name="checkbox" id="checkbox" value="" style="width:13px;height:13px;" />
                                        </th>
                                        <th width="6%"><fmt:message code="notice.th.state" /></th>
                                        <th width="6%"><fmt:message code="email.th.sign" /></th>
                                        <th width="16%"><fmt:message code="email.th.sender" /></th>
                                        <th width="40%" class="theme"><fmt:message code="email.th.main" /></th>
                                        <th width="16%"><fmt:message code="email.th.time" /></th>
                                        <th width="10%"><fmt:message code="email.th.file" /></th>
									</tr>
                              </table>
                        </div>
						<div>
                              <div class="M-box3"></div>
						</div>
                    </div>
			</div>
		</div>
		
		<script type="text/javascript">
             var user = 'senduser';
             var user_id='';
			 var ue = UE.getEditor('container');
			 var res;
			$(function () {
			    var main_height = $(document).height() - 65;
                $('.main_left').height(main_height);
                $('.main_middle').height(main_height);
                var heights = main_height- 194;
				$('.article').height(heights);
                var data={
                    "flag":"inbox",
                    "page":1,
                    "pageSize":10,
                    "useFlag":true
                }
                //选人控件
                $("#selectUser").on("click",function(){
                    user_id='senduser';
                    $.popWindow("../common/selectUser");
                });
                $('.drafts').on('click','#selectUserO',function(){
                    user_id='copeNameText';
                    $.popWindow("../common/selectUser");
                })
                $('.drafts').on('click','#selectUserT',function(){
                    user_id='secritText';
                    $.popWindow("../common/selectUser");
                })
				//切换横版收件箱页面
				var oLI=$('.up_format ul li').eq(1);
				oLI.click(function () {
					$(this).addClass('for_on').find('img').attr('src','../img/icon_list_sel_03.png');
					$(this).siblings().removeClass('for_on');
					$(this).parent().find('li').eq(0).find('img').attr('src','../img/icon_zuoyou_03.png');
                    $('#withdraw').css('display','none');
					$('.main').hide();
					$('.UP_INBOX').show();
                    $('.UP_INBOX').find('tr.Hover').remove();
                    HVersion (function(pageCount){
                        initPagination(pageCount,data.pageSize);
					});
                });
                //横版数据展示方法
                function HVersion(cb) {
                    $.ajax({
                        type:'get',
                        url:'showEmail',
                        dataType:'json',
                        data:data,
                        success:function(rsp){
                            var data1=rsp.obj;
                            var str='';
							$('.tab').find('.Hover').remove();
                            for(var i=0;i<data1.length;i++){
                                var sendTime=new Date((data1[i].sendTime)*1000).Format('yyyy-MM-dd');
                                var emailSubject = '';
                                if(data1[i].emailList[0].withdrawFlag==undefined||data1[i].emailList[0].withdrawFlag=='0'){
                                    emailSubject= data1[i].subject ;
                                }else{
                                    emailSubject= '<fmt:message code="notice.th.Withdrawn" />：'+data1[i].subject;
                                }
                                if(data1[i].emailList[0].readFlag==1){
                                    if(data1[i].attachmentId!=''){
                                        str+='<tr class="Hover" Attr="'+data1[i].emailList[0].emailId+'" uId="'+data1[i].emailList[0].deleteFlag+'"><td><input type="checkbox" name="checkbox" id="checkbox" style="width:13px;height:13px;" value="" /></td><td><img src="../img/icon_read_2_03.png"/></td><td width="6%"></td><td width="6%">'+returnUserName(data1[i].users)+'</td><td class="theme_a" style="text-align:left;"><a href="javascript:;">'+emailSubject+'</a></td><td>'+sendTime+'</td><td><img src="../img/attachment_icon.png"/></td></tr>';
                                    }else{
                                        str+='<tr class="Hover" Attr="'+data1[i].emailList[0].emailId+'" uId="'+data1[i].emailList[0].deleteFlag+'"><td><input type="checkbox" name="checkbox" id="checkbox" style="width:13px;height:13px;" value="" /></td><td><img src="../img/icon_read_2_03.png"/></td><td width="6%"></td><td width="6%">'+returnUserName(data1[i].users)+'</td><td class="theme_a" style="text-align:left;"><a href="javascript:;">'+emailSubject+'</a></td><td>'+sendTime+'</td><td>&nbsp</td></tr>';
                                    }

                                } else if(data1[i].emailList[0].readFlag==0){
                                    if(data1[i].attachmentId!=''){
                                        str+='<tr class="Hover" Attr="'+data1[i].emailList[0].emailId+'" uId="'+data1[i].emailList[0].deleteFlag+'"><td><input type="checkbox" name="checkbox" id="checkbox" style="width:13px;height:13px;" value="" /></td><td><img src="../img/icon_read_2_03.png"/></td><td width="6%"></td><td width="6%">'+returnUserName(data1[i].users)+'</td><td class="theme_a" style="text-align:left;"><a href="javascript:;">'+emailSubject+'</a></td><td>'+sendTime+'</td><td><img src="../img/attachment_icon.png"/></td></tr>';
                                    }else{
                                        str+='<tr class="Hover" Attr="'+data1[i].emailList[0].emailId+'" uId="'+data1[i].emailList[0].deleteFlag+'"><td><input type="checkbox" name="checkbox" id="checkbox" style="width:13px;height:13px;" value="" /></td><td><img src="../img/icon_read_2_03.png"/></td><td width="6%"></td><td width="6%">'+returnUserName(data1[i].users)+'</td><td class="theme_a" style="text-align:left;"><a href="javascript:;">'+emailSubject+'</a></td><td>'+sendTime+'</td><td>&nbsp</td></tr>';
                                    }
                                }
                            }
                            $('.tr_befor').after(str);
                            if(cb){
                                cb(rsp.totleNum);
                            }
                            //initPagination(rsp.totleNum,data.pageSize);
                        }
                    });
                }
                //分页
                function initPagination(totalData,pageSize){
                    $('.M-box3').pagination({
                        totalData:totalData, //数据总条数
                        showData:pageSize,   //每页条目数
                        jump:true,
                        coping:true,
                        homePage:'<fmt:message code="global.page.first" />',
                        endPage:'<fmt:message code="global.page.last" />',
                        prevContent:'<fmt:message code="global.page.pre" />',
                        nextContent:'<fmt:message code="global.page.next" />',
                        jumpBtn:'<fmt:message code="global.page.jump" />',
                        callback:function(index){
                            data.page = index.getCurrent();
//                            console.log(index.getCurrent());
                            HVersion();
                        }
                    });
                }
				//横版列表页面的列表详情
                $('.tab').on('click','tr.Hover',function () {
                    $(this).addClass('on_tr').siblings().removeClass('on_tr');
					var sId=$(this).attr('Attr');
					var flagId=$(this).attr('uId');
                    $('#delete').attr({'uId':sId,'del':flagId});
                })
				$('.tab').on('click','.theme_a',function(){
                    var atr = $(this).parents('tr').attr('Attr');
                    var name = $(this).find('a').text();
                    if(typeof(qt) == "undefined"){
                        $.popWindow('details?id='+atr);
					}else{
                        new QWebChannel(qt.webChannelTransport, function(channel){
                            var content = channel.objects.interface;
                            content.xoa_sms('/email/details?id='+atr,name,"web_child_url");
                        });
					}

				})

                //切换竖版收件箱页面
                $('.up_format ul li:first-of-type').click(function () {
                    $(this).addClass('for_on').find('img').attr('src','/img/commonTheme/${sessionScope.InterfaceModel}/icon_zuoyou_sel_03.png');
                    $('#withdraw').css('display','none');
                    $(this).siblings().removeClass('for_on');
                    $(this).parent().find('li').eq(1).find('img').attr('src','../img/iCon_list_003.png');
                    $('.main').show();
                    $('.UP_INBOX').hide();

                })
				if ($('.main').css('display')=='block'){
                    $('.up_format ul li:first-of-type').addClass('for_on').find('img').attr('src','/img/commonTheme/${sessionScope.InterfaceModel}/icon_zuoyou_sel_03.png');

                    $('.up_format ul li:first-of-type').siblings().removeClass('for_on');
                    $('.up_format ul li:first-of-type').parent().find('li').eq(1).find('img').attr('src','../img/iCon_list_003.png');
				}

				
				//与写邮件页面互调
				$('.d_im').click(function(){
//				    $(this).css('background','url("../../img/email/icon_email_click_01.png") no-repeat');
                    $('.page').find('.div_iframe').remove();
					var Ifrmae='<div class="div_iframe" style="width: 82%;overflow: hidden;float: left;height: 100%;"><div id="iframe1" class="iframe1" style="width: 100%;height: 100%;"><iframe  id="iframeId" src="addbox" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe></div></div>';
					$('.up_page_right').css('display','none');
	    			$('.page').append(Ifrmae);
                    $('.div_iframeTwo').css('display','none')
                    $('.div_iframeOne').css('display','none');
	    		});
	    		$('.Inbox').click(function(){
	    			$('.page').find('.div_iframe').remove();
	    			$('.up_page_right').css('display','block');
	    		});

				//点击切换邮件箱管理页面
				$('.exceptLi').click(function(){
                    $('.page').find('.div_iframeOne').remove();
					$('.up_page_right').css('display','none');
                    var Ifrmae='<div class="div_iframeOne" style="width: 82%;overflow-y: hidden;overflow-x: hidden;float: left;height: 100%;"><div id="iframe1" class="iframe1" style="width: 100%;height: 100%;"><iframe name="myFrame" id="iframe_id" src="manageMail" frameborder="0" height="100%" width="100%" noresize="noresize"></iframe></div></div>';
                    $('.page').append(Ifrmae);

					$('.div_iframeTwo').css('display','none');
					$('.div_iframe').css('display','none');
                    document.getElementById("iframe_id").onload = function() {
                        myFrame.window.divListShow();
                    };
				})
				//点击切换外部邮件箱
				$('.externalMail').click(function(){
                    $('.page').find('.div_iframeOne').remove();
                    $('.up_page_right').css('display','none');
                    var Ifrmae='<div class="div_iframeOne" style="width: 82%;overflow-y: hidden;overflow-x: hidden;float: left;height: 100%;"><div id="iframe1" class="iframe1" style="width: 100%;height: 100%;"><iframe name="myFrame" id="iframe_id" src="manageMail" frameborder="0" height="100%" width="100%" noresize="noresize"></iframe></div></div>';
                    $('.page').append(Ifrmae);
                    $('.div_iframeTwo').css('display','none');
                    $('.div_iframe').css('display','none');
                    $('#withdraw').css('display','none');
                    document.getElementById("iframe_id").onload = function() { //控制子页面的方法
                        myFrame.window.showDiv();
                    };
				})

				//查询邮件点击事件
				$('.liSearch').click(function(){
                    $('.page').find('.div_iframeTwo').remove();
	    			var Ifrmae='<div class="div_iframeTwo" style="width: 82%;overflow:hidden;float: left;height: 100%;"><div id="iframe1" class="iframe1" style="width: 100%;height: 100%;"><iframe  id="iframeids" src="mailQuery" frameborder="0" height="100%" width="100%" noresize="noresize"></iframe></div></div>';
	    			$('.up_page_right').css('display','none');
	    			$('.page').append(Ifrmae);
                    $('.div_iframeOne').css('display','none');
                    $('.div_iframe').css('display','none');
	    		});
				
				//页面初始化
                showAjax('inbox','#TAB','.article','','','','');

                var selectBox='InBox';
				//收件箱点击事件
				$('#InBox').click(function(){
                    showAndHide();
					$('.up_nav').find('li').css('display','block');
                    $('.up_pages').css('display','block');
					$('.UP_INBOX').css('display','none');
					$('.InBox').css('display','block').siblings().css('display','none');
                    $('#withdraw').css('display','none');
					showAjax('inbox','#TAB','.article','','','','');
                    selectBox='InBox';
				});


				//草稿箱点击事件
				$('#drafts').click(function(){
                    selectBox='drafts';
                    showAndHide();
                    $('.main_left ul .befor').siblings().remove();
                    showAjax2('drafts','','','');
					$('#allEmail').css('display','block');
					$('#delete').css('display','block');
                    $('#Replay').css('display','none');
                    $('#ReplayAll').css('display','none');
                    $('#Forward').css('display','none');
					$('#RemoveTo').css('display','none');
					$('.div_iframeOne').css('display','none');
                    $('.up_page_right').css('display','block');
                    $('.up_pages').css('display','none');
                    $('#withdraw').css('display','none');
					if ($('.UP_INBOX').css('display')=='block'){
						$('.UP_INBOX').hide();
						$('.main').show().find('.drafts').show().siblings().hide();
					}
					$('.drafts').css('display','block').siblings().css('display','none');

                    $('.main_left').on('click','.BTN',function(){
                        var cId=$(this).find('input').attr('nId');
                        initDrafts(cId);

                        $('#delete').attr('uId',cId);
                    });
				});
				
				//已发送点击事件
				$('#hasBeenSend').click(function(){
                    selectBox='hasBeenSend';
                    showAndHide();
					$('#Forward').css('display','block');
                    $('#withdraw').css('display','block');
                    $('#delete').css('display','block');
                    $('#Replay').css('display','none');
                    $('#ReplayAll').css('display','none');
                    $('#RemoveTo').css('display','none');
                    $('.div_iframeOne').css('display','none');
                    $('.up_page_right').css('display','block');
                    $('.up_pages').css('display','none');
                    if ($('.UP_INBOX').css('display')=='block'){
                        $('.UP_INBOX').hide();
                        $('.main').show().find('.hasBeenSend').show().siblings().hide();
                    }
					
					$('.hasBeenSend').css('display','block').siblings().css('display','none');
					showAjax3("outbox",'','','','','#TAC');
					
					$('.main_left').on('click','.BTN',function(){
						var nId=$(this).find('input').attr('nId');
						init3(nId,'#TAC');
						var dele=$(this).find('input').attr('ueId');
						$('#delete').attr({'uId':nId,'del':dele});
					});
				});
				
				//废纸篓点击事件
				$('#wastebasket').click(function(){
                    selectBox='wastebasket';
                    showAndHide();
                    $('#allEmail').css('display','block');
                    $('#withdraw').css('display','none');
                    $('#delete').css('display','block');
                    $('#Replay').css('display','none');
                    $('#ReplayAll').css('display','none');
                    $('#Forward').css('display','none');
                    $('#RemoveTo').css('display','none');
                    $('.div_iframeOne').css('display','none');
                    $('.up_page_right').css('display','block');
                    $('.up_pages').css('display','none');
                    if ($('.UP_INBOX').css('display')=='block'){
                        $('.UP_INBOX').hide();
                        $('.main').show().find('.wastebasket').show().siblings().hide();
                    }

					$('.wastebasket').css('display','block').siblings().css('display','none');

					showAjax1('recycle','#TAD','.article2','','','','');
					$('.main_left').on('click','.BTN',function(){
						var nId=$(this).find('input').attr('id');
						var dele=$(this).find('input').attr('ueId');
						init(nId,'#TAD','.article2');
						$('#delete').attr({'uId':nId,'del':dele});
					});
					
				});
                //其他邮件箱下的文件夹中列表邮件点击事件展示详情
                $('.main_left').on('click','.folderBtn',function(){
                    var emailId=$(this).find('input').attr('id');
                    selectBox=emailId;
                    folderDetails(emailId);
                })
                $('.page_left').on('click','.otherLi',function(){
                    $('.page_left li').removeClass('on');
                    $(this).addClass('on');
                    selectBox=$(this).attr('boxid');
                })
                //搜索结果方法
                $('.searchTxt').bind('input propertychange', function() {
                    var id=$('.on').attr('boxId');
                    var valN=$(this).val();
                    //showAjax('inbox','#TAB','.article',valN,'','');
                    if(selectBox=='InBox'){
                        showAjax('inbox','#TAB','.article',valN,'','','');
                        $('.InBox').css('display','block').siblings().css('display','none');
                    } else if(selectBox=='hasBeenSend'){        //已发送
                        showAjax3("outbox",valN,'','','');
                        $('.hasBeenSend').css('display','block').siblings().css('display','none');
                    } else if(selectBox=='wastebasket'){        //废纸篓
                        showAjax1('recycle','#TAD','.article2',valN,'','','');
                        $('.wastebasket').css('display','block').siblings().css('display','none');
                    } else if(selectBox=='drafts'){			//草稿箱
                        showAjax2('drafts',valN,'','');
                        $('.drafts').css('display','block').siblings().css('display','none');
                    } else{
                        otherList(id,valN,'','','');
                    }
                });

                //取消搜索按钮
                $('.cancleSpan').click(function(){
                    $('.searchTxt').val('');
                    $('.search_div').hide();
                    var id=$('.on').attr('boxId');

                    if(selectBox=='InBox'){
                        showAjax('inbox','#TAB','.article','','','','');
                        $('.InBox').css('display','block').siblings().css('display','none');
                    } else if(selectBox=='hasBeenSend'){        //已发送
                        showAjax3("outbox",'','','','');
                        $('.hasBeenSend').css('display','block').siblings().css('display','none');
                    } else if(selectBox=='wastebasket'){        //废纸篓
                        showAjax1('recycle','#TAD','.article2','','','','');
                        $('.wastebasket').css('display','block').siblings().css('display','none');
                    } else if(selectBox=='drafts'){			//草稿箱
                        showAjax2('drafts','','','');
                        $('.drafts').css('display','block').siblings().css('display','none');
                    } else{
                        otherList(id,'','','','');
                    }

                })


				 //详情点击事件
				$('.main_left').on('click','.BTN',function(){
						//$(this).addClass("backing").siblings("li").removeClass("backing");
						var nId=$(this).find('input').attr('id');
						var dele=$(this).find('input').attr('ueId');
						var readf=$(this).find('input').attr('readf');
						var fromId=$('.backing').attr('fromId');
						if(readf==1){
							init(nId,'#TAB','.article');
						}else{
							readFlags(nId);
							$(this).find('.noReadF').attr('src','../img/icon_read_2_03.png');
						}
						var fromids = $(this).attr('fromid');
						$('#delete').attr({'uId':nId,'del':dele});
						getUserInfo(fromids,'.zong','.userdept');

				});
				//复选框多选点击
                $('.main_left').on('click','.BTN',function(){
                   	//alert($('.chekEmail').css('display'));
					if($('.chekEmail').css('display')=='block'||$('.chekEmail').css('display')=='inline-block'){
                        //alert(111)
                        var state=$(this).find('.chekEmail').prop("checked");
                        //alert(state)
                        if(state == true){
                            $(this).find('.chekEmail').prop("checked",true);
                            $(this).addClass("backing");
                        }else{
                            $(this).find('.chekEmail').prop("checked",false);
                            $(this).removeClass("backing");
                        }
                        var child =   $(".chekEmail");
                        for(var i=0;i<child.length;i++){
                            var childstate= $(child[i]).prop("checked");
                            if(state!=childstate){
                                return
                            }
                        }
					}else {
                        $(this).find('.chekEmail').prop("checked",false);
                        $(this).addClass("backing").siblings("li").removeClass("backing");
					}
				})
				//删除事件
				 $('#delete').click(function(){
					 if($('.chekEmail').css('display')=='block'||$('.chekEmail').css('display')=='inline-block'){

                         var arrId1=[];
                         var arrId2=[];
                         var arrId3=[];
                         $(".chekEmail:checkbox:checked").each(function(){
                             var sId=$(this).parents('.BTN').find('input[type="hidden"]').attr('id');
                             arrId1.push(sId);
                         })
                         $(".chekEmail:checkbox:checked").each(function(){
                             var ueID=$(this).parents('.BTN').find('input[type="hidden"]').attr('ueId');
                             arrId2.push(ueID);
                         })
                         $(".chekEmail:checkbox:checked").each(function(){
                             var bodyId=$(this).parents('.BTN').find('input[type="hidden"]').attr('nId');
                             arrId3.push(bodyId);
                         })
                         if($('.InBox').css('display')=='block'){                   //收件箱
                             deleted('inbox',arrId1,arrId2);
                             $('.InBox').css('display','block').siblings().css('display','none');
                         } else if($('.hasBeenSend').css('display')=='block'){        //已发送
                             deleted('outbox',arrId3,arrId2);
                             $('.hasBeenSend').css('display','block').siblings().css('display','none');
                         } else if($('.wastebasket').css('display')=='block'){        //废纸篓
                             deleted('recycle',arrId1,arrId2);
                             $('.wastebasket').css('display','block').siblings().css('display','none');
                         } else if($('.drafts').css('display')=='block'){
                             deleted1(arrId3);
                             $('.drafts').css('display','block').siblings().css('display','none');
                         } else if($('.UP_INBOX').css('display')=='block'){
                             deleted('inbox',arrId1,arrId2);
                             $('.UP_INBOX').show();
                             $('.main').hide();
                         } else if($('.otherMailFolder').css('display')=='block'){
                             deleted('inbox',arrId1,arrId2);
                         }
					 }else{
						 var sId=$('.main_left .backing input').attr('id');
						 var ueID=$('.main_left .backing input').attr('ueId');
						 var bodyId=$('.main_left .backing input').attr('nId');

                         if($('.InBox').css('display')=='block'){                   //收件箱
                             deleteds('inbox',sId,ueID);
                             $('.InBox').css('display','block').siblings().css('display','none');
                         } else if($('.hasBeenSend').css('display')=='block'){        //已发送
                             deleteds('outbox',bodyId,ueID);
                             $('.hasBeenSend').css('display','block').siblings().css('display','none');
                         } else if($('.wastebasket').css('display')=='block'){        //废纸篓
                             deleteds('recycle',sId,ueID);
                             $('.wastebasket').css('display','block').siblings().css('display','none');
                         } else if($('.drafts').css('display')=='block'){
                             deleted2(bodyId);
                             $('.drafts').css('display','block').siblings().css('display','none');
                         } else if($('.UP_INBOX').css('display')=='block'){
                             deleteds('inbox',sId,ueID);
                             $('.UP_INBOX').show();
                             $('.main').hide();
                         } else if($('.otherMailFolder').css('display')=='block'){
                             deleteds('inbox',sId,ueID);
                         }
					 }
				})
				
				//回复事件
				$('#Replay').click(function(){
					var sId=$('.main_left .backing input[type="hidden"]').attr('id');
					if(typeof(qt) == 'undefined'){
                        $.popWindow('writeMail2?sId=' + sId+'&type=0','<fmt:message code="global.lang.reply" />','0','0','1600px','800px');
					}else{
                        new QWebChannel(qt.webChannelTransport, function(channel){
                            var content = channel.objects.interface;
                            content.xoa_sms('/email/writeMail2?sId='+sId+'&type=0','<fmt:message code="global.lang.reply" />',"web_child_url");
                        });
					}

				});
				//回复全部事件
				$('#ReplayAll').click(function(){
                   	var sId=$('.main_left .backing input[type="hidden"]').attr('id');
                    if(typeof(qt) == 'undefined'){
                        $.popWindow('writeMail2?sId=' + sId+'&type=1','<fmt:message code="global.lang.reply" />','0','0','1600px','800px');
                    }else{
                        new QWebChannel(qt.webChannelTransport, function(channel){
                            var content = channel.objects.interface;
                            content.xoa_sms('/email/writeMail2?sId='+sId+'&type=1','<fmt:message code="global.lang.reply" />',"web_child_url");
                        });
					}

				})
				//转发事件
				$('#Forward').click(function(){
                    var sId=$('.main_left .backing input[type="hidden"]').attr('id');
					var nId=$('.main_left .backing input[type="hidden"]').attr('nId');
                    if($('.InBox').css('display')=='block'){
                        if(typeof(qt) == 'undefined'){
                            $.popWindow('writeMail2?sId=' + sId+'&type=2','<fmt:message code="email.th.transmit" />','0','0','1500px','800px');
                        }else{
                            new QWebChannel(qt.webChannelTransport, function(channel){
                                var content = channel.objects.interface;
                                content.xoa_sms('/email/writeMail2?sId='+sId+'&type=2','<fmt:message code="email.th.transmit" />',"web_child_url");
                            });
						}

					}else if($('.hasBeenSend').css('display')=='block'){
                        if(typeof(qt) == 'undefined'){
                            $.popWindow('writeMail2?sId=' + nId+'&type=3','<fmt:message code="email.th.transmit" />','0','0','1500px','800px');
                        }else{
                            new QWebChannel(qt.webChannelTransport, function(channel){
                                var content = channel.objects.interface;
                                content.xoa_sms('/email/writeMail2?sId=' +nId+ '&type=3','<fmt:message code="email.th.transmit" />',"web_child_url");
                            });
                        }
					}

				})
                //刷新点击事件
                $('.ReFresh').click(function(){
                    if($('.InBox').css('display')=='block'){       //收件箱
                        showAjax('inbox','#TAB','.article','','','','');
                    } else if($('.hasBeenSend').css('display')=='block'){        //已发送
                        showAjax3("outbox",'','','','','#TAC');
                    } else if($('.wastebasket').css('display')=='block'){        //废纸篓
                        showAjax1('recycle','#TAD','.article2','','','','');
                    } else if($('.drafts').css('display')=='block'){            //草稿箱
                        showAjax2('drafts','','','');
                    }
                })

				//附件上传
                $('#uploadinputimg').fileupload({
                    dataType:'json',
                    done: function (e, data) {
                        if(data.result.obj != ''){
                            var data = data.result.obj;
                            var str = '';
                            var str1 = '';
                            for (var i = 0; i < data.length; i++) {
                                var gs = data[i].attachName.split('.')[1];
                                if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){
                                    str += '';
                                    layer.alert('<fmt:message code="dem.th.uploading" />!',{},function(){
                                        layer.closeAll();
                                    });
                                }else{
                                    str += '<div class="dech" style="margin-top:5px;" deUrl="' + encodeURI(data[i].attUrl)+ '">' +
                                        '<a href="/download?'+encodeURI(data[i].attUrl)+'" NAME="' + data[i].attachName + '*">' +
                                        '<img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + data[i].attachName + '</a>' +
                                        '<span style="color:rgba(0,0,0,0.5);font-size:12px;margin-right:5px;margin-left:4px;">('+data[i].fileSize+')</span>' +
                                        '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/>' +
                                        '<input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +
                                        '</div>';
                                }
                            }
                            $('.Attachment td').eq(1).append(str);
                        }else{
                            //alert('添加附件大小不能为空!');
                            layer.alert('<fmt:message code="dem.th.AddEmpty" />!',{},function(){
                                layer.closeAll();
                            });
                        }
                    }
                });

					//草稿箱点击立即发送
					$('#btn1').click(function(){
						var bodyId=$('.main_left .backing').find('input').attr('nId');
                        var dataId1=$('.inPole').find('#senduser').attr('user_id');
                        var dataId2=$('.tian').find('#copeNameText').attr('user_id');
                        var dataId3=$('.mis').find('#secritText').attr('user_id');
                        var userId=$('textarea[name="txt"]').attr('user_id');
                        var txt = ue.getContentTxt();
                        var html = ue.getContent();
                        var val=$('#txt').val();
                        var attach=$('.Attachment td').eq(1).find('a');
                        var aId='';
                        var uId='';
                        for(var i=0;i<$('.Attachment td .inHidden').length;i++){
                            aId += $('.Attachment td .inHidden').eq(i).val();
                        }
                        for(var i=0;i<$('.Attachment td .inHidden').length;i++){
                            uId += attach.eq(i).attr('NAME');
                        }
                        var data={
							'bodyId':bodyId,
                            'sendFlag':0,
                            'toId2': dataId1,
                            'copyToId':dataId2,
                            'secretToId':dataId3,
                            'subject':val,
                            'content':html,
                            'attachmentId':aId,
                            'attachmentName':uId
                        };
                        $.ajax({
                            type:'post',
                            url:'sendEmail',
                            dataType:'json',
                            data:data,
                            success:function(rsp){
                                if(rsp.flag == true){
                                    $.layerMsg({content:'<fmt:message code="global.lang.send" />！',icon:1},function(){
                                        location.reload();
									});
                                }else{
                                    $.layerMsg({content:'<fmt:message code="global.lang.err" />！',icon:2},function(){
//										console.log(rsp.flag);
									});
                                }
                            }
                        });
					})
				//草稿箱点击保存到草稿箱
				$('#btn2').click(function(){
                    var bodyId=$('.main_left .backing').find('input').attr('nId');
                    var dataId1=$('.inPole').find('#senduser').attr('user_id');
                    var dataId2=$('.tian').find('#copeNameText').attr('user_id');
                    var dataId3=$('.mis').find('#secritText').attr('user_id');
                    var userId=$('textarea[name="txt"]').attr('user_id');
                    var txt = ue.getContentTxt();
                    var html = ue.getContent();
                    var val=$('#txt').val();
                    var attach=$('.Attachment td').eq(1).find('a');
                    var aId='';
                    var uId='';
                    for(var i=0;i<$('.Attachment td .inHidden').length;i++){
                        aId += $('.Attachment td .inHidden').eq(i).val();
                    }
                    for(var i=0;i<$('.Attachment td .inHidden').length;i++){
                        uId += attach.eq(i).attr('NAME');
                    }
                    var data={
						'bodyId':bodyId,
                        'toId2': dataId1,
                        'copyToId':dataId2,
                        'secretToId':dataId3,
                        'subject':val,
                        'content':html,
                        'attachmentId':aId,
                        'attachmentName':uId
                    };
                    $.ajax({
                        type:'post',
                        url:'saveEmail',
                        dataType:'json',
                        data:data,
                        success:function(){
                            $.layerMsg({content:'<fmt:message code="diary.th.modify" />！',icon:1},function(){
                                location.reload()
							});
                        }
                    });
				})


                //未读查询
                function readFlags(id){
                    $.ajax({
                        type:'get',
                        url:'queryByID',
                        dataType:'json',
                        data:{'flag':'isRead','emailId':id},
                        success:function(res){
                            var data2=res.object;
                            if(!data2||data2.length<=0){
                                return;
							}

                            var userStr="";
                            if(data2.toUserEmailInfo){
                                var touser= data2.toUserEmailInfo
                                for(var i=0;i<touser.length;i++){
//                                    if(i>2){
//                                        userStr+="...";
//                                        break;
//                                    }
//                                    var flag= touser[i].readFlag;
//                                    if(flag==1){
//                                        userStr+='<img src="../img/icon_read_2_03.png" />'
//                                    }else{
//                                        userStr+='<img src="../img/icon_notread_1_03.png" class="noReadF"/>'
//                                    }
                                    userStr+='<img src="../img/icon_read_2_03.png" /><span>'+touser[i].userName+'</span>';
//                                    userStr += '<span>'+touser[i].userName+'</span>';
                                }
                            }


                            var copyUserStr="";
                            var toId=data2.emailList[0].toId;
                            if(data2.copyUserEmailInfo){
                                var copyuser= data2.copyUserEmailInfo
                                for(var i=0;i<copyuser.length;i++){
                                    if(copyuser[i].toId ==toId){
                                        copyUserStr += '<img src="../img/icon_read_2_03.png" /><span>'+copyuser[i].userName+'</span>';
									}else{
                                        copyUserStr += '<img src="../img/icon_notread_1_03.png" class="noReadF"/><span>'+copyuser[i].userName+'</span>';
									}
//                                    if(i>2){
//                                        copyUserStr+="...";
//                                        break;
//                                    }
//                                    var flag= copyuser[i].readFlag;
//                                    if(flag==1){
//                                        copyUserStr+='<img src="../img/icon_read_2_03.png" />'
//                                    }else{
//                                        copyUserStr+='<img src="../img/icon_notread_1_03.png" class="noReadF"/>'
//                                    }

                                    //copyUserStr += '<span>'+copyuser[i].userName+'</span>';
                                }
                            }
                            var secrUserStr="";
                            if(data2.sercUserEmailInfo){
                                var secruser= data2.sercUserEmailInfo
                                for(var i=0;i<secruser.length;i++){
                                    if(i>2){
                                        secrUserStr+="...";
                                        break;
                                    }
                                    var flag= secruser[i].readFlag;
                                    if(flag==1){
                                        secrUserStr+='<img src="../img/icon_read_2_03.png" />'
                                    }else{
                                        secrUserStr+='<img src="../img/icon_notread_1_03.png" class="noReadF"/>'
                                    }

                                    secrUserStr += '<span>'+secruser[i].userName+'</span>';
                                }

                            }
                            var sendTime=new Date((data2.sendTime)*1000).Format('yyyy-MM-dd hh:mm');
                            var str='';
                            var stra='';
                            var arr=new Array();
                            arr=data2.attachment;
                            $('#TAB').find('tr').remove();
                            $('.article').find('*').remove();
                            $('.span_hr').find('p').find('span').eq(0).html('');
                            str+='<tr><td style="width:70px;"><fmt:message code="email.th.main" />：</td><td width="90%" style="display:block;white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" title="'+data2.subject+'">'+data2.subject+'</td></tr>' +
                                '<tr><td><fmt:message code="email.th.sender" />：</td><td>'+data2.users.userName+'</td></tr>' +
                                '<tr><td><fmt:message code="email.th.recipients" />：</td><td><span style="display: inline-block;min-width: 220px;width:30%;">'+userStr+'</span><a urls="/email/emailReadDetail?bodyId='+data2.bodyId+'&userIds=toId2" href="#" onclick="lookemail($(this))"><fmt:message code="event.th.ViewMailStatus" /></a></td></tr>';
                            if(data2.copyName!=''){
                                str+='<tr><td><fmt:message code="email.th.carbonCopyRecipients" />：</td><td><span style="display: inline-block;min-width: 220px;width:30%;">'+copyUserStr+'</span><a urls="/email/emailReadDetail?bodyId='+data2.bodyId+'&userIds=copyToId" href="#" onclick="lookemail($(this))"><fmt:message code="event.th.ViewMailStatus" /></a></td></tr>';
                            }
                            if(data2.secretToName!=''){
                                str+='<tr><td><fmt:message code="email.th.BlindPeople" />：</td><td><span style="display: inline-block;min-width: 220px;width:30%;">'+secrUserStr+'</span><a urls="/email/emailReadDetail?bodyId='+data2.bodyId+'&userIds=secretToId" href="#" onclick="lookemail($(this))"><fmt:message code="event.th.ViewMailStatus" /></a></td></tr>'
                            }
                            str+='<tr><td><fmt:message code="email.th.time" />：</td><td>'+sendTime+'</td></tr>';
                            if(data2.attachmentName!=''){
                                for(var i=0;i<arr.length;i++){
                                    stra+='<div><a href="/download?'+encodeURI(arr[i].attUrl)+'"><img src="../img/attachment_icon.png"/>'+arr[i].attachName+'</a><a href="/download?'+encodeURI(arr[i].attUrl)+'" style="margin-left:10px;"><fmt:message code="file.th.download" /></a></div>';
                                }
                                str+='<tr><td><fmt:message code="email.th.file" />：</td><td class="attachment">'+stra+'</td></tr>';
                            }
//<a href="/common/ntkoPreview?'+encodeURI(arr[i].attUrl)+'"  target="_Blank" style="margin: 0 20px;"><fmt:message code="global.lang.view" /></a>

                            $('#TAB').append(str);
                            $('.article').append('<p>'+data2.content+'</p>');
                            $('.span_hr').find('p').find('span').eq(0).html(data2.users.userName);
                        }
                    })
                }
			});

				function lookemail(e){
                    var urls = e.attr('urls');
				    var name = '<fmt:message code="event.th.ViewMailStatus" />';
                    if(typeof(qt) == 'undefined'){
                        window.open(urls);
					}else{
                        new QWebChannel(qt.webChannelTransport, function(channel){
                            var content = channel.objects.interface;
                            content.xoa_sms(urls,name,"web_child_url");
                        });
					}
				}
				//收件箱列表初始化展示方法
				function showAjax(flag,obj,cName,keyWord,sorName,sorWhere,allId){
					$('.BTN').remove();
					var data1={
						"flag":flag,
						"page":1,
						"pageSize":100,
						"useFlag":true,
						"searchCriteria":keyWord,
						"orderByName":sorName,
						"orderWhere":sorWhere,
						"isWebmail":allId
					};	
					$.ajax({
                        type:'get',
                        url:'showEmail',
                        dataType:'json',
                        data:data1,
                        success:function(rsp){
                            var data1=rsp.obj;
                            var dataNUm=rsp.object;
                            var str='';
                            $('#InBox a span').text('');
                            $('#drafts a span').text('');
                            $('#hasBeenSend a span').text('');
                            $('#InBox a span').append(rsp.totleNum);
                            $('#drafts a span').html(dataNUm.draftsCount);
                            $('#hasBeenSend a span').html(dataNUm.hairboxCount);


                            if(rsp.totleNum == 0){
                                $('.noEmail').show().siblings().hide();
                                $('.noContent').show();
                            }else{
                                $('.noContent').hide();
                                $('.noEmail').hide();
                            }
                            if(data1.length>0){
                                for(var i=0;i<data1.length;i++){
                                    var sendTime=new Date((data1[i].sendTime)*1000).Format('yyyy-MM-dd hh:mm');
                                    var emailSubject = '';
                                    if(data1[i].emailList[0].withdrawFlag==undefined||data1[i].emailList[0].withdrawFlag=='0'){
                                        emailSubject= data1[i].subject ;
                                    }else{
                                        emailSubject= '<fmt:message code="notice.th.Withdrawn" />：'+data1[i].subject;
                                    }
                                    if(data1[i].emailList[0].readFlag==1){
                                        if(data1[i].attachmentId!=''&&data1[i].emailList[0].withdrawFlag!='1'){
                                            str+='<li class="BTN" fromId="'+data1[i].fromId+'" style="cursor: pointer;"><input type="hidden" readF="'+data1[i].emailList[0].readFlag+'" nId="'+data1[i].bodyId+'" id="'+data1[i].emailList[0].emailId+'" ueId="'+data1[i].emailList[0].deleteFlag+'"><input type="checkbox" class="chekEmail" checkId="'+data1[i].bodyId+'" style="width: 16px;display: none;"><div class="shang"><span>'+returnUserName(data1[i].users)+'</span><img src="../img/icon_read_2_03.png"/><span class="time">'+sendTime+'</span></div><div class="xia"><a href="javascript:;" class="xia_txt">'+emailSubject+'</a><img src="../img/attachment_icon.png"/></div></li>';
                                        }else{
                                            str+='<li class="BTN" fromId="'+data1[i].fromId+'" style="cursor: pointer;"><input type="hidden" readF="'+data1[i].emailList[0].readFlag+'" nId="'+data1[i].bodyId+'" id="'+data1[i].emailList[0].emailId+'" ueId="'+data1[i].emailList[0].deleteFlag+'"><input type="checkbox" class="chekEmail" checkId="'+data1[i].bodyId+'" style="width: 16px;display: none;"><div class="shang"><span>'+returnUserName(data1[i].users)+'</span><img src="../img/icon_read_2_03.png"/><span class="time">'+sendTime+'</span></div><div class="xia"><a href="javascript:;" class="xia_txt">'+emailSubject+'</a></div></li>';
                                        }
                                    } else {
                                        if(data1[i].attachmentId!=''&&data1[i].emailList[0].withdrawFlag!='1'){
                                            str+='<li class="BTN" fromId="'+data1[i].fromId+'" style="cursor: pointer;"><input type="hidden" readF="'+data1[i].emailList[0].readFlag+'" nId="'+data1[i].bodyId+'" id="'+data1[i].emailList[0].emailId+'" ueId="'+data1[i].emailList[0].deleteFlag+'"><input type="checkbox" class="chekEmail" checkId="'+data1[i].bodyId+'" style="width: 16px;display: none;"><div class="shang"><span>'+returnUserName(data1[i].users)+'</span><img class="noReadF" src="../img/icon_notread_1_03.png"/><span class="time">'+sendTime+'</span></div><div class="xia"><a href="javascript:;" class="xia_txt">'+emailSubject+'</a><img src="../img/attachment_icon.png"/></div></li>';
                                        }else{
                                            str+='<li class="BTN" fromId="'+data1[i].fromId+'" style="cursor: pointer;"><input type="hidden" readF="'+data1[i].emailList[0].readFlag+'" nId="'+data1[i].bodyId+'" id="'+data1[i].emailList[0].emailId+'" ueId="'+data1[i].emailList[0].deleteFlag+'"><input type="checkbox" class="chekEmail" checkId="'+data1[i].bodyId+'" style="width: 16px;display: none;"><div class="shang"><span>'+returnUserName(data1[i].users)+'</span><img class="noReadF" src="../img/icon_notread_1_03.png"/><span class="time">'+sendTime+'</span></div><div class="xia"><a href="javascript:;" class="xia_txt">'+emailSubject+'</a></div></li>';
                                        }
                                    }
                                }
                                $('.befor').siblings().remove()
                                $('.befor').after(str);
                                $('li.BTN').eq(0).addClass("backing");
                                var mId=$('li.BTN').eq(0).find('input[type="hidden"]').attr('id');
                                var fromId=$('li.BTN').eq(0).attr('fromId');
                                init(mId,obj,cName);
                                getUserInfo(fromId,'.zong','.userdept');
							}

                        }
					});
				}
				//获取人员图像、信息接口
				function getUserInfo(id,sName,dName){
					$.ajax({
						type:'get',
						url:'../user/findUserByuserId',
						dataType:'json',
						data:{'userId':id},
						success:function(res){
							if(res.flag==true){
                                var dataU=res.object;
								$(sName).text(dataU.userPrivName);
                                $(dName).text(dataU.deptName);
                                if(dataU.avatar !=null&&dataU.avatar !=0){
									$('.attrImg img').attr('src','../img/user/'+dataU.avatar);
								}else{
                                    if(dataU.sex == "0"){
                                        $('.attrImg img').attr('src','../img/email/icon_head_man_06.png');
                                    }else{
                                        $('.attrImg img').attr('src','../img/email/icon_head_woman_06.png');
                                    }
								}
							}

						}
					})
				}
				//废纸篓列表展示方法
				function showAjax1(flag,obj,cName,keyWord,sorName,sorWhere,allId){
					$('.BTN').remove();
					var data1={
						"flag":flag,
						"page":1,
						"pageSize":100,
						"useFlag":true,
                        "searchCriteria":keyWord,
                        "orderByName":sorName,
                        "orderWhere":sorWhere,
                        "isWebmail":allId
					};
					$.ajax({
									type:'get',
									url:'showEmail',
									dataType:'json',
									data:data1,
									success:function(rsp){
										var data1=rsp.obj;
										var str='';
										if(rsp.totleNum == 0){
                                            $('.noEmail').show().siblings().hide();
                                            $('.noContent').show();
                                        }else{
                                            $('.noContent').hide();
                                            $('.noEmail').hide();
                                        }
                                        if(data1.length>0){
                                            for(var i=0;i<data1.length;i++){
                                                var sendTime=new Date((data1[i].sendTime)*1000).Format('yyyy-MM-dd hh:mm');
//                                            console.log(returnUserName(data1[i].users));
//                                        <img src="../img/icon_star_kong_03.png"/>
                                                if(data1[i].emailList[0].readFlag==1){
                                                    if(data1[i].attachmentId!=''){
                                                        str+='<li class="BTN"  fromId="'+data1[i].fromId+'" style="cursor: pointer;"><input type="hidden" nId="'+data1[i].bodyId+'" id="'+data1[i].emailList[0].emailId+'" ueId="'+data1[i].emailList[0].deleteFlag+'"><input type="checkbox" class="chekEmail" checkId="'+data1[i].bodyId+'" style="width: 16px;display: none;"><div class="shang"><span>'+returnUserName(data1[i].users)+'</span><img src="../img/icon_read_2_03.png"/><span class="time">'+sendTime+'</span></div><div class="xia"><a href="javascript:;" class="xia_txt">'+data1[i].subject+'</a><img src="../img/attachment_icon.png"/></div></li>';
                                                    }else{
                                                        str+='<li class="BTN" fromId="'+data1[i].fromId+'" style="cursor: pointer;"><input type="hidden" nId="'+data1[i].bodyId+'" id="'+data1[i].emailList[0].emailId+'" ueId="'+data1[i].emailList[0].deleteFlag+'"><input type="checkbox" class="chekEmail" checkId="'+data1[i].bodyId+'" style="width: 16px;display: none;"><div class="shang"><span>'+returnUserName(data1[i].users)+'</span><img src="../img/icon_read_2_03.png"/><span class="time">'+sendTime+'</span></div><div class="xia"><a href="javascript:;" class="xia_txt">'+data1[i].subject+'</a></div></li>';
                                                    }

                                                } else if(data1[i].emailList[0].readFlag==0){
                                                    if(data1[i].attachmentId!=''){
                                                        str+='<li class="BTN" fromId="'+data1[i].fromId+'" style="cursor: pointer;"><input type="hidden" nId="'+data1[i].bodyId+'" id="'+data1[i].emailList[0].emailId+'" ueId="'+data1[i].emailList[0].deleteFlag+'"><input type="checkbox" class="chekEmail" checkId="'+data1[i].bodyId+'" style="width: 16px;display: none;"><div class="shang"><span>'+returnUserName(data1[i].users)+'</span><img src="../img/icon_notread_1_03.png"/><span class="time">'+sendTime+'</span></div><div class="xia"><a href="javascript:;" class="xia_txt">'+data1[i].subject+'</a><img src="../img/attachment_icon.png"/></div></li>';
                                                    }else{
                                                        str+='<li class="BTN" fromId="'+data1[i].fromId+'" style="cursor: pointer;"><input type="hidden" nId="'+data1[i].bodyId+'" id="'+data1[i].emailList[0].emailId+'" ueId="'+data1[i].emailList[0].deleteFlag+'"><input type="checkbox" class="chekEmail" checkId="'+data1[i].bodyId+'" style="width: 16px;display: none;"><div class="shang"><span>'+returnUserName(data1[i].users)+'</span><img src="../img/icon_notread_1_03.png"/><span class="time">'+sendTime+'</span></div><div class="xia"><a href="javascript:;" class="xia_txt">'+data1[i].subject+'</a></div></li>';
                                                    }

                                                }

                                            }
                                            $('.befor').after(str);
                                            $('li.BTN').eq(0).addClass("backing");
                                            var mId=$('li.BTN').eq(0).find('input').attr('id');

                                            init(mId,obj,cName);
										}
									}
					});
				}

				<!-- 处理姓名为空处理 /users处理 -->
				function returnUserName(users){
				    if(users == undefined || users == ""){
                        return "";
                    }else{
				        return users.userName;
					}
				}

				//草稿箱列表展示方法
				function showAjax2(flag,keyWord,sorName,sorWhere){
					$('.main_left .BTN').remove();
							var data={
								"flag":flag,
								"page":1,
								"pageSize":100,
								"useFlag":true,
                                "searchCriteria":keyWord,
                                "orderByName":sorName,
                                "orderWhere":sorWhere,
						};
						$.ajax({
									type:'get',
									url:'showEmail',
									dataType:'json',
									data:data,
									success:function(rsp){
										var data1=rsp.obj;
										var str='';
										$('#drafts a span').text('');
										$('#drafts a span').append(rsp.totleNum);

										if(rsp.totleNum == 0){
											$('.noEmail').show().siblings().hide();
											$('.noContent').show();
										}else{
                                            $('.noContent').hide();
                                            $('.noEmail').hide();
										}
										if(data1.length>0){
                                            for(var i=0;i<data1.length;i++){
                                                var sendTime=new Date((data1[i].sendTime)*1000).Format('yyyy-MM-dd hh:mm');
                                                if(data1[i].attachmentId!=''){
//                                                <img src="../img/icon_collect_nor_03.png"/>
                                                    str+='<li class="BTN" fromId="'+data1[i].fromId+'" style="cursor: pointer;"><input type="hidden" nId="'+data1[i].bodyId+'" id="'+data1[i].emailList[0].emailId+'" ueId="'+data1[i].emailList[0].deleteFlag+'"><input type="checkbox" class="chekEmail" checkId="'+data1[i].bodyId+'" style="width: 16px;display: none;"><div class="shang"><span>'+returnUserName(data1[i].users)+'</span><img src="../img/icon_read_2_03.png"/><span class="time">'+sendTime+'</span></div><div class="xia"><a href="javascript:;" class="xia_txt">'+data1[i].subject+'</a><img src="../img/attachment_icon.png"/></div></li>';
                                                }else{
                                                    str+='<li class="BTN" fromId="'+data1[i].fromId+'" style="cursor: pointer;"><input type="hidden" nId="'+data1[i].bodyId+'" id="'+data1[i].emailList[0].emailId+'" ueId="'+data1[i].emailList[0].deleteFlag+'"><input type="checkbox" class="chekEmail" checkId="'+data1[i].bodyId+'" style="width: 16px;display: none;"><div class="shang"><span>'+returnUserName(data1[i].users)+'</span><img src="../img/icon_read_2_03.png"/><span class="time">'+sendTime+'</span></div><div class="xia"><a href="javascript:;" class="xia_txt">'+data1[i].subject+'</a></div></li>';
                                                }
                                            }
                                            $('.main_left ul .befor').after(str);
                                            $('li.BTN').eq(0).addClass("backing");
                                            var nID=$('li.BTN').eq(0).find('input').attr('nId');
                                            initDrafts(nID);
										}

									}
						});
				}
				//草稿箱详情数据
				function initDrafts(nId){
                    $('.drafts').find('.tian').remove();
                    $('.drafts').find('.mis').remove();
					$.ajax({
						type:'get',
						url:'queryByID',
						dataType:'json',
						data:{'bodyId':nId,'flag':''},
						success:function(rsp){
							if(rsp.flag == true){
                                var data2=rsp.object;
                                if(!data2||data2.length<=0){
                                    return;
                                }
                                var atta=data2.attachment;
                                var str='';

                                $('textarea').val('');
                                $('#txt').val('');
                                ue.setContent('');
                                $('#senduser').val('');
                                $('.Attachment td').eq(1).find('div').remove();
                                for(var i=0;i<atta.length;i++){
                                    <%--str+='<a href="/download?'+atta[i].attUrl+'" style="text-decoration: none;margin-left: 5px">'+atta[i].attachName+'</a>';--%>
                                    str+='<div class="dech" deUrl="'+encodeURI(atta[i].attUrl)+'"><a href="/download?'+encodeURI(atta[i].attUrl)+'" NAME="'+atta[i].attachName+'*" style="text-decoration:none;margin-left:5px;"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>'+atta[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+atta[i].aid+'@'+atta[i].ym+'_'+atta[i].attachId+',"></div>';
                                }

                                $('#senduser').val(data2.toName);
                                $('#senduser').attr('user_id',data2.toId2);
                                if(data2.copyToId !=''){
                                    var cStr='';
                                    cStr='<tr class="tian"><td><fmt:message code="main.th.CC" />：</td><td><textarea id="copeNameText" name="txt" disabled></textarea><span class="add_img"><a href="javascript:;" id="selectUserO" class="Add" style="margin-left: 5px;"><fmt:message code="global.lang.add" /></a></span><span class="add_img"><a href="javascript:;" class="clearCC" style="margin-left: 5px;"><fmt:message code="notice.th.delete1" /></a></span></td></tr>';
                                    $('.a1').text('<fmt:message code="email.th.HiddenSecret" />');
                                    $('.append_tr').after(cStr);
                                    $('#copeNameText').attr('user_id',data2.copyToId+',');
                                    $('#copeNameText').val(data2.copyName);
								}
								if(data2.secretToId !=''){
                                    var sStr='';
                                    sStr='<tr class="mis"><td><fmt:message code="email.th.bcc" />：</td><td><textarea id="secritText" name="txt" disabled></textarea><span class="add_img"><a href="javascript:;" id="selectUserT" class="Add" style="margin-left: 5px;"><fmt:message code="global.lang.add" /></a></span><span class="add_img"><a href="javascript:;" class="clearBCC" style="margin-left: 5px;"><fmt:message code="notice.th.delete1" /></a></span></td></tr>';
                                    $('.a2').text('<fmt:message code="email.th.HiddenSecret" />');
                                    $('.append_tr').after(sStr);
                                    $('#secritText').attr('user_id',data2.secretToId+',');
                                    $('#secritText').val(data2.secretToName);
								}
                                $('#txt').val(data2.subject);
                                ue.setContent(data2.content);
                                $('.Attachment td').eq(1).append(str);
                                var Height=$($('#styleDrafts')).height();
							}
						}
					});
				}
				//选人控件清除所选人员


				//附件删除
				$('#files_txt').on('click','.deImgs',function(){
					var data=$(this).parents('.dech').attr('deUrl');
					var dome=$(this).parents('.dech');
					deleteChatment(data,dome);
				})
				
				//已发送列表展示方法
				function showAjax3(flag,keyWord,sorName,sorWhere,allId,obj){
					$('.BTN').remove();
							var data={
								"flag":flag,
								"page":1,
								"pageSize":100,
								"useFlag":true,
                                "searchCriteria":keyWord,
                                "orderByName":sorName,
                                "orderWhere":sorWhere,
                                "isWebmail":allId
						};
						$.ajax({
									type:'get',
									url:'showEmail',
									dataType:'json',
									data:data,
									success:function(rsp){
										var data1=rsp.obj;
										var str='';
										if(rsp.totleNum == 0){
                                            $('.noEmail').show().siblings().hide();
                                            $('.noContent').show();
                                        }else{
                                            $('.noContent').hide();
                                            $('.noEmail').hide();
                                        }
										for(var i=0;i<data1.length;i++){
											var sendTime=new Date((data1[i].sendTime)*1000).Format('yyyy-MM-dd hh:mm');
												if(data1[i].attachmentId!=''){
													str+='<li class="BTN" style="cursor: pointer;"><input type="hidden" nId="'+data1[i].bodyId+'" id="'+data1[i].emailList[0].emailId+'" ueId="'+data1[i].emailList[0].deleteFlag+'"><input type="checkbox" class="chekEmail" checkId="'+data1[i].bodyId+'" style="width: 16px;display: none;"><div class="shang"><span>'+returnUserName(data1[i].users)+'</span><img src="../img/icon_read_2_03.png"/><span class="time">'+sendTime+'</span></div><div class="xia"><a href="javascript:;" class="xia_txt">'+data1[i].subject+'</a><img src="../img/attachment_icon.png"/></div></li>';
												}else{
													str+='<li class="BTN" style="cursor: pointer;"><input type="hidden" nId="'+data1[i].bodyId+'" id="'+data1[i].emailList[0].emailId+'" ueId="'+data1[i].emailList[0].deleteFlag+'"><input type="checkbox" class="chekEmail" checkId="'+data1[i].bodyId+'" style="width: 16px;display: none;"><div class="shang"><span>'+returnUserName(data1[i].users)+'</span><img src="../img/icon_read_2_03.png"/><span class="time">'+sendTime+'</span></div><div class="xia"><a href="javascript:;" class="xia_txt">'+data1[i].subject+'</a></div></li>';
												}
										}
										$('#hasBeenSend').find('span').text(rsp.totleNum);
                                        $('.befor').siblings().remove()
										$('.main_left ul .befor').after(str);
										$('li.BTN').eq(0).addClass("backing");
										var nID=$('li.BTN').eq(0).find('input').attr('nId');
										init3(nID,obj);
									}
						});
				}

                //收件箱、废纸篓详情展示方法
                function init(id,obj,cName){
                    $(cName).find('*').remove();
                    $.ajax({
                        type:'get',
                        url:'queryByID',
                        dataType:'json',
                        data:{'emailId':id,'flag':''},
                        success:function(rsp){
                            var data2=rsp.object;
                            if(!data2||data2.length<=0){
                                return;
                            }
                            var sendTime=new Date((data2.sendTime)*1000).Format('yyyy-MM-dd hh:mm');
                            var str='';
                            var stra='';
                            var arr=new Array();
                            arr=data2.attachment;
                            $(obj).find('tr').remove();
                            $(cName).find('*').remove();
                            $('.span_hr').find('p').find('span').eq(0).html('');

                            var userStr="";
                            if(data2.toUserEmailInfo){
                                var touser= data2.toUserEmailInfo
                                for(var i=0;i<touser.length;i++){
                                    if(i>2){
                                        userStr+="...";
                                        break;
									}
                                    var flag= touser[i].readFlag;
                                    if(flag==1){
                                        userStr+='<img src="../img/icon_read_2_03.png" />'
                                    }else{
                                        userStr+='<img src="../img/icon_notread_1_03.png" class="noReadF"/>'
                                    }

                                    userStr += '<span>'+touser[i].userName+'</span>';
                                }
                            }
                            var copyUserStr="";
                            if(data2.copyUserEmailInfo){
                                var copyuser= data2.copyUserEmailInfo
                                for(var i=0;i<copyuser.length;i++){
                                    if(i>2){
                                        copyUserStr+="...";
                                        break;
                                    }
                                    var flag= copyuser[i].readFlag;
                                    if(flag==1){
                                        copyUserStr+='<img src="../img/icon_read_2_03.png" />'
                                    }else{
                                        copyUserStr+='<img src="../img/icon_notread_1_03.png" class="noReadF"/>'
                                    }

                                    copyUserStr += '<span>'+copyuser[i].userName+'</span>';
                                }
                            }
                            var secrUserStr="";
                            if(data2.sercUserEmailInfo){
                                var secruser= data2.sercUserEmailInfo
                                for(var i=0;i<secruser.length;i++){
                                    if(i>2){
                                        secrUserStr+="...";
                                        break;
                                    }
                                    var flag= secruser[i].readFlag;
                                    if(flag==1){
                                        secrUserStr+='<img src="../img/icon_read_2_03.png" />'
                                    }else{
                                        secrUserStr+='<img src="../img/icon_notread_1_03.png" class="noReadF"/>'
                                    }

                                    secrUserStr += '<span>'+secruser[i].userName+'</span>';
                                }

                            }

//<a href="/common/ntkoPreview?'+encodeURI(arr[i].attUrl)+'"  target="_Blank" style="margin: 0 20px;"><fmt:message code="global.lang.view" /></a>

                            var emailSubject = '';
                            if(data2.emailList[0].withdrawFlag==undefined||data2.emailList[0].withdrawFlag=='0'){
                                emailSubject= data2.subject ;
                            }else{
                                emailSubject= '<fmt:message code="notice.th.Withdrawn" />：'+data2.subject;
                            }

                            str+='<tr><td style="width:70px;"><fmt:message code="email.th.main" />：</td><td width="90%" style="display:block;white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" title="'+data2.subject+'"><div style="width:60%;display:block;white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" title="'+data2.subject+'">'+emailSubject+'</div></td></tr>' +
								'<tr><td><fmt:message code="email.th.sender" />：</td><td>'+data2.users.userName+'</td></tr>' +
								'<tr><td><fmt:message code="email.th.recipients" />：</td><td><span style="display: inline-block;min-width: 220px;width:30%;">'+userStr+'</span><a urls="/email/emailReadDetail?bodyId='+data2.bodyId+'&userIds=toId2" href="#" onclick="lookemail($(this))"><fmt:message code="event.th.ViewMailStatus" /></a></td></tr>';
								if(data2.copyName!=''){
								    str+='<tr><td><fmt:message code="email.th.carbonCopyRecipients" />：</td><td><span style="display: inline-block;min-width: 220px;width:30%;">'+copyUserStr+'</span><a urls="/email/emailReadDetail?bodyId='+data2.bodyId+'&userIds=copyToId" href="#" onclick="lookemail($(this))"><fmt:message code="event.th.ViewMailStatus" /></a></td></tr>';
                                }
                                if(data2.secretToName!=''){
								    str+='<tr><td><fmt:message code="email.th.BlindPeople" />：</td><td><span style="display: inline-block;min-width: 220px;width:30%;">'+secrUserStr+'</span><a urls="/email/emailReadDetail?bodyId='+data2.bodyId+'&userIds=secretToId" href="#" onclick="lookemail($(this))"><fmt:message code="event.th.ViewMailStatus" /></a></td></tr>'
								}
                            str+='<tr><td><fmt:message code="email.th.time" />：</td><td>'+sendTime+'</td></tr>';
								if(data2.attachmentName!=''){
                                    if(data2.emailList[0].withdrawFlag!='1') {
                                        for (var i = 0; i < arr.length; i++) {
                                            stra += '<div><a href="/download?' + encodeURI(arr[i].attUrl) + '"><img src="../img/attachment_icon.png"/>' + arr[i].attachName + '</a><a style="margin-left:30px;" href="/download?' + encodeURI(arr[i].attUrl) + '"><fmt:message code="file.th.download" /></a></div>';
                                        }
                                    }
                                    str+='<tr><td><fmt:message code="email.th.file" />：</td><td class="attachment">'+stra+'</td></tr>';
								}
                            $(obj).append(str);
                            var content = '';
                            if(data2.emailList[0].withdrawFlag=='0'){
                                content = data2.content;
                            }else{
                                content = '<fmt:message code="notice.th.withdrawn" />。';
                            }
                            $(cName).append('<p>'+content+'</p>');
//                            $('.span_hr').find('p').find('span').eq(0).html(data2.users.userName);
                        }
                    });
                }

				//已发送详情展示方法
				function init3(id,obj){
                    $('.article1').find('*').remove();
//                    $('#TAC').find('tr').remove();
					$.ajax({
							type:'get',
							url:'queryByID',
							dataType:'json',
							data:{'bodyId':id,'flag':''},
							success:function(rsp){
								var data2=rsp.object;
                                if(!data2||data2.length<=0){
                                    return;
                                }
								if(data2 !=''){
                                    var arr=data2.attachment;
                                    var str='';
                                    var stra='';
                                    var sendTime=new Date((data2.sendTime)*1000).Format('yyyy-MM-dd hh:mm');
                                    $(obj).find('tr').remove();
                                    $('.article1').find('*').remove();
                                    var userStr="";
                                    if(data2.toUserEmailInfo){
                                        var touser= data2.toUserEmailInfo
                                        for(var i=0;i<touser.length;i++){
                                            if(i>2){
                                                userStr +="...";
                                                break;
                                            }
                                            var flag= touser[i].readFlag;
                                            if(flag==1){
                                                userStr+='<img src="../img/icon_read_2_03.png" />'
                                            }else{
                                                userStr+='<img src="../img/icon_notread_1_03.png" class="noReadF"/>'
                                            }

                                            userStr += '<span>'+touser[i].userName+'</span>';
                                        }
                                    }
                                    var copyUserStr="";
                                    if(data2.copyUserEmailInfo){
                                        var copyuser= data2.copyUserEmailInfo
                                        for(var i=0;i<copyuser.length;i++){
                                            if(i>2){
                                                copyUserStr+="...";
                                                break;
                                            }
                                            var flag= copyuser[i].readFlag;
                                            if(flag==1){
                                                copyUserStr+='<img src="../img/icon_read_2_03.png" />'
                                            }else{
                                                copyUserStr+='<img src="../img/icon_notread_1_03.png" class="noReadF"/>'
                                            }

                                            copyUserStr += '<span>'+copyuser[i].userName+'</span>';
                                        }
                                    }
                                    var secrUserStr="";
                                    if(data2.sercUserEmailInfo){
                                        var secruser= data2.sercUserEmailInfo
                                        for(var i=0;i<secruser.length;i++){
                                            if(i>2){
                                                secrUserStr+="...";
                                                break;
                                            }
                                            var flag= secruser[i].readFlag;
                                            if(flag==1){
                                                secrUserStr+='<img src="../img/icon_read_2_03.png" />'
                                            }else{
                                                secrUserStr+='<img src="../img/icon_notread_1_03.png" class="noReadF"/>'
                                            }

                                            secrUserStr += '<span>'+secruser[i].userName+'</span>';
                                        }
                                    }
                                    //<a href="/common/ntkoPreview?'+encodeURI(arr[i].attUrl)+'"  target="_Blank" style="margin: 0 20px;"><fmt:message code="global.lang.view" /></a>
                                    str+='<tr class="MAIN2"><td style="width:70px;"><fmt:message code="email.th.main" />：</td><td width="90%" style="display:block;white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" title="'+data2.subject+'">'+data2.subject+'</td></tr>'+
                                        '<tr class="SEND2"><td><fmt:message code="email.th.recipients" />：</td><td><span style="display: inline-block;min-width: 220px;width:30%;">'+userStr+'</span><a urls="/email/emailReadDetail?bodyId='+data2.bodyId+'&userIds=toId2" href="#" onclick="lookemail($(this))"><fmt:message code="event.th.ViewMailStatus" /></a></td></tr>';
                                    if(data2.copyName!=''){
                                        str+='<tr><td><fmt:message code="email.th.carbonCopyRecipients" />：</td><td><span style="display: inline-block;min-width: 220px;width:30%;">'+copyUserStr+'</span><a urls="/email/emailReadDetail?bodyId='+data2.bodyId+'&userIds=copyToId" href="#" onclick="lookemail($(this))"><fmt:message code="event.th.ViewMailStatus" /></a></td></tr>';
                                    }
                                    if(data2.secretToName!=''){
                                        str+='<tr><td><fmt:message code="email.th.BlindPeople" />：</td><td><span style="display: inline-block;min-width: 220px;width:30%;">'+secrUserStr+'</span><a urls="/email/emailReadDetail?bodyId='+data2.bodyId+'&userIds=secretToId" href="#" onclick="lookemail($(this))"><fmt:message code="event.th.ViewMailStatus" /></a></td></tr>'
                                    }
                                    str+='<tr class="DATE2"><td><fmt:message code="email.th.time" />：</td><td>'+sendTime+'</td></tr>';
                                    if(data2.attachmentName!=''){
                                        for(var i=0;i<arr.length;i++){
                                            stra+='<div><a href="/download?'+encodeURI(arr[i].attUrl)+'" class="a_post"><img src="../img/attachment_icon.png"/>'+arr[i].attachName+'</a><a style="margin-left:30px;" href="/download?'+encodeURI(arr[i].attUrl)+'"><fmt:message code="file.th.download" /></a></div>';
                                        }
                                        str+='<tr><td><fmt:message code="email.th.file" />：</td><td class="attachment">'+stra+'</td></tr>';
                                    }
                                    $('#TAC').append(str);
                                    $('.article1').append('<p>'+data2.content+'</p>');
								}

							}
						});
				} 
				
				//多条数据删除事件
				function deleted(flag,sId,ueID){
					 var data={
						"flag":flag,
						"requestFlags":sId,
						"deleteFlags":ueID
					}
                    layer.confirm('<fmt:message code="global.lang.sure" />', {
                        btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'] //按钮
                    }, function(){
                        //确定删除，调接口
                        $.ajax({
                            type:'get',
                            url:'deleteEmail',
                            dataType:'json',
                            data:data,
                            success:function(){
                                //location.reload();
                                if($('.wastebasket').css('display')=='block'){
                                    showAjax1('recycle','#TAD','.article2','','','','');
                                }else if($('.hasBeenSend').css('display')=='block'){
                                    showAjax3("outbox",'','','','','#TAC');
                                }else if($('.InBox').css('display')=='block'){
                                    showAjax('inbox','#TAB','.article','','','','');
                                } else if($('.otherMailFolder').css('display')=='block'){
                                    var id=$('.otherLi').attr('boxid');
                                    otherList(id,'','','');
								}
                                //第三方扩展皮肤
                                layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});
                            }
                        })
                    }, function(){
                        layer.closeAll();
                    });
                }

				//单条删除
				function deleteds(flag,sId,ueID){
					var data={
						"flag":flag,
						"emailID":sId,
						"deleteFlag":ueID
					}
					layer.confirm('<fmt:message code="global.lang.sure" />', {
						btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'] //按钮
					}, function(){
						//确定删除，调接口
						$.ajax({
							type:'get',
							url:'deleteEmail',
							dataType:'json',
							data:data,
							success:function(){
								//location.reload();
								if($('.wastebasket').css('display')=='block'){
									showAjax1('recycle','#TAD','.article2','','','','');
								}else if($('.hasBeenSend').css('display')=='block'){
									showAjax3("outbox",'','','','','#TAC');
								}else if($('.InBox').css('display')=='block'){
									showAjax('inbox','#TAB','.article','','','','');
								} else if($('.otherMailFolder').css('display')=='block'){
									var id=$('.otherLi').attr('boxid');
									otherList(id,'','','');
								}
								//第三方扩展皮肤
								layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});
							}
						})
					}, function(){
						layer.closeAll();
					});
				}
				
				//草稿箱删除多条
				function deleted1(bId){
					 var data={
						"requestFlags":bId,
					}
                    layer.confirm('<fmt:message code="global.lang.sure" />', {
                        btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'] //按钮
                    }, function(){
                        //确定删除，调接口
                        $.ajax({
                            type:'get',
                            url:'deleteDraftsEmail',
                            dataType:'json',
                            data:data,
                            success:function(){
                                //第三方扩展皮肤
                                layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});
                                showAjax2('drafts','','','');
                            }
                        }) ;
                    }, function(){
                        layer.closeAll();
                    });
				}
				//草稿箱删除单条
				function deleted2(bId){
					var data={
						"bodyId":bId,
					}
					layer.confirm('<fmt:message code="global.lang.sure" />', {
						btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'] //按钮
					}, function(){
						//确定删除，调接口
						$.ajax({
							type:'get',
							url:'deleteDraftsEmail',
							dataType:'json',
							data:data,
							success:function(){
								//第三方扩展皮肤
								layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});
								showAjax2('drafts','','','');
							}
						}) ;
					}, function(){
						layer.closeAll();
					});
				}

				//附件删除
				function deleteChatment(data,element){

					layer.confirm('<fmt:message code="workflow.th.que" />？', {
						btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
						title:"<fmt:message code="notice.th.DeleteAttachment" />"
					}, function(){
						//确定删除，调接口
						$.ajax({
							type:'get',
							url:'../delete',
							dataType:'json',
							data:data,
							success:function(res){

								if(res.flag == true){
									layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});
									element.remove();
								}else{
									layer.msg('<fmt:message code="lang.th.deleSucess" />', { icon:6});
								}
							}
						});

					}, function(){
						layer.closeAll();
					});
				}



				//ue编辑器清空方法
				function empty(){
					ue.setContent('');
				}
				
				//正在开发中
				function clicked(){
					layer.msg('<fmt:message code="lang.th.Upcoming" />', {icon: 6});
				}

//				$(function(){
//					$(".searchTxt").bind('input porpertychange',function(){
//						if($('.searchTxt').val()==null){
//                            alert("e12");
//                        }else{
//                            alert("e13");
//                        }
////                        console.log("e");
////                        showAjax('inbox','#TAB','.article',data);
//					});
//				});

				//搜索改变事件

		</script>

		<script language="javascript" type="text/javascript">
			function parenttest() {
                $('.other .ul_show ul').empty();
                $('.up_nav .RemoveTo_div ul').empty();
				var data={
					'page':1,
					'pageSize':10,
					'useFlag':true
				}
				$.ajax({
					type:'GET',
					url:'showEmailBox',
					dataType:'json',
					data:data,
					success:function(rsp){
						var data1=rsp.obj;
						var str='';
						var str1='';
						for(var i=0;i<data1.length;i++){
							str+='<li class="otherLi" boxId="'+data1[i].boxId+'"><a href="javascript:;"><img src="../img/commonTheme/${sessionScope.InterfaceModel}/icon_file_11.png"/>'+data1[i].boxName+'</a></li>';
							str1+='<li class="RemoveTo_child" boxId="'+data1[i].boxId+'">'+data1[i].boxName+'</li>';
						}
						$('.other .ul_show ul').append(str);
						$('.up_nav .RemoveTo_div ul').append(str1);
					}
				})
			}

			function showAndHide(){
                //图标切换
                if($('.UP_INBOX').css('display') == 'none'){
                    $('#ul_imgs').attr('src','/img/commonTheme/${sessionScope.InterfaceModel}/icon_zuoyou_sel_03.png');
                    $('#ul_img').attr('src','../../img/iCon_list_003.png');
                }else{
                    $('#ul_imgs').attr('src','../../img/icon_zuoyou_03.png');
                    $('#ul_img').attr('src','../../img/icon_list_sel_03.png');
                }
			}
		</script>


		<script>
            $(".a_post").on("click",function(event){
                event.preventDefault();  // 使a自带的方法失效，即无法向addStudent.action发出请求
                $.ajax({
                    type: "POST",  // 使用post方式
                    url: "addStudent.action",
                    contentType:"application/json",
                    data: JSON.stringify({param1:value1, param2:value2}),  // 参数列表，stringify()方法用于将JS对象序列化为json字符串
                    dataType:"json",
                    success: function(result){
                        // 请求成功后的操作
                    },
                    error: function(result){
                        // 请求失败后的操作
                    }
                });
            });
		</script>
	</body>
</html>

