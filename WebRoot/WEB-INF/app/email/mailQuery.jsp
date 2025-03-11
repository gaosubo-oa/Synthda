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
		<title><fmt:message code="email.title.querymail" /></title><!-- 邮件查询 -->
		<link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
		<link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
		<%--<link rel="stylesheet" type="text/css" href="../css/base.css"/>--%>
<%--		<script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
		<script type="text/javascript" charset="utf-8" src="/js/xoajq/xoajq3.js"></script>
<%--		<script type="text/javascript" charset="utf-8" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
		<script src="../lib/laydate/laydate.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
		<script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
		<script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
		<style type="text/css">
			body{width: 100%;font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;font-size: 14px;overflow-x: hidden;}
			.content{width: 99%;margin: 0 auto;}
			.title{width: 100%;text-align: left;line-height: 40px;}
			/*.tab table tr td{padding: 5px 5px;border-color: #ddd;}*/
			#btn{margin: 0 auto;width:70px;height:28px;}
			/*#btn:hover{background-color: #fff;border-color:bbb;}*/
			/*#btn .DIV_Img,#btn .DIV_Txt{float: left}*/
			/*#btn .DIV_Img{margin: 3px 5px 3px 10px;}*/
			#btn .DIV_Txt{width: 70px;height:28px;line-height: 28px;background: url("../img/email/center_q.png ") no-repeat;cursor: pointer;}
			/*.tac table{border-color:#ddd;}*/
			.tac table tr{border: 1px solid #c0c0c0;}
			.tac table tr:nth-child(odd){background-color: #F6F7F9;}
			.tac table tr:nth-child(even){background-color: #fff;}
			.tac table tr th{padding: 10px;border-color: #ddd;font-size:14px;font-weight: normal;color: #2F5C8F;}
			.tac table tr td{padding: 10px;border-color: #ddd;font-size: 12px;text-align:center;}
			.tac table tr td a{text-decoration: none;color:#2B7FE0;}
			/*.tac table tr td #but{cursor: pointer;}*/
			.but{margin: 3px auto;width: 70px;height: 28px;line-height: 28px;background: url("../img/email/return.png") no-repeat;cursor: pointer;}
			.tac table tr:last-of-type td{text-align: right;}
			.Hover td img{width: 16px;}
			.Hover td:last-of-type img{width: 18px}
			.tac table .Hover:hover{background-color: #dbecff;}
			.title{height: 60px;width:100%;position: relative}
			.title .title_img img{width: 23px;margin-right:10px;float: left;margin-top: 9px;}
			.title .div_span{font-size: 22px;float: left;}
			.tab{width: 100%}
			.tab table{margin:0 auto;}
			.tab table tr{border: 1px solid #c0c0c0;}
			.tab table tr td,.tab table tr th{padding: 10px;}
			.tab table tr td{border-right: 1px solid #c0c0c0;}
			.tab table tr td input{height: 22px;}
			.tab table tr td select{height: 25px;width: 95px;}
			.M-box3{margin-top:10px;float:right;margin-right: 7px;}
			.M-box3 a{margin: 0 3px;width: 29px;height: 29px;line-height: 29px;font-size: 12px;text-decoration: none;}
			.M-box3 .active{margin: 0px 3px;width: 29px;height: 29px;line-height: 29px;background: #2b7fe0;font-size: 12px;border: 1px solid #2b7fe0;}
			.jump-ipt{margin: 0 3px;width: 29px;height: 29px;line-height: 29px;font-size: 12px;}
			.M-box3 a:hover{background: #2b7fe0;}
		</style>
		<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
		<style>
			.up_page_right .up_header {
				width: 99%;
				min-width: 918px;
			}
			.up_page_right .up_header .up_nav {
				width: 85%;
				float: left;
				height: 100%;
				/* overflow: hidden; */
			}
			ul {
				list-style: none;
			}
			.up_page_right .up_header .up_nav>ul>li {
				font-size: 10pt;
				float: left;
				padding: 0px 8px;
				border: #ccc 1px solid;
				margin-top: 12px;
				margin-right: 8px;
				border-radius: 3px;
				cursor: pointer;
				height: 28px;
				line-height: 28px;
				background-color: #fff;
			}

			.up_page_right .up_header .up_nav ul li img.im {
				width: 16px;
				height: 16px;
				vertical-align: middle;
				margin-right: 5px;
			}
			.up_nav ul{
				position: absolute;
				top: -13px;
				left: 115px;
			}
			.up_nav .im{
				vertical-align: middle;
				width: 16px;
			}
			#delete{
				font-size: 10pt;
				float: left;
				padding: 0px 8px;
				border: #ccc 1px solid;
				margin-top: 12px;
				margin-right: 8px;
				border-radius: 3px;
				cursor: pointer;
				height: 28px;
				line-height: 28px;
				background-color: #fff;
			}
			#RemoveTo{
				position: relative;font-size: 10pt;
				float: left;
				padding: 0px 8px;
				border: #ccc 1px solid;
				margin-top: 12px;
				margin-right: 8px;
				border-radius: 3px;
				cursor: pointer;
				height: 28px;
				line-height: 28px;
				background-color: #fff;
				position: relative;
				z-index: 10;
			}
			.RemoveTo_div{
				font-size: 12px;
				border-radius: 5px;
				min-width:160px;
				background-color: #fff;
				position: absolute;
				left:40px;
				top: 30px;
				z-index: 9999;
			}
			.RemoveTo_div ul li {
				min-width: 160px;
				padding: 5px 10px;
				display: block;
				clear: both;
			}
			.RemoveTo_div .RemoveTo_child:hover{
				background-color: #6ea1d5;
				color:#fff;cursor: pointer;
			}
			.backList{
				background-color: #c5e9fb !important;
			}
		</style>
	</head>
	<body>
		<div class="content">
			<div class="title">
				<div class="title_img">
					<img src="../img/icon_QUERY.png">
				</div>
				<div class="div_span"><fmt:message code="email.title.querymail" /></div>
			</div>
			<div class="tab">
				<form action="" method="get">
					<table cellspacing="0" cellpadding="0" width="70%" style="border-collapse:collapse;background-color: #fff">
						<tr>
						<th colspan="2" class="hhhed"><fmt:message code="global.lang.inputquerycondition" /></th>
					</tr>
						<tr>
							<td><fmt:message code="email.th.maillist" />：</td>
							<td class="radiobox">
								<input type="radio" name="copyTime" value="" id="COPY_TIME" checked="" style="    margin-top: 1px;
    vertical-align: middle;">
								<label for="COPY_TIME"><fmt:message code="email.th.nowmaillist" /></label>
							</td>
						</tr>
						<tr>
							<td><fmt:message code="email.th.chosebox" />：</td>
							<td>
								<select name="BOX" class="BigSelect">
							        <option value="1" ATTR="inbox"><fmt:message code="email.title.inbox" /></option>
							        <option value="2" ATTR="drafts"><fmt:message code="email.title.draftbox" /></option>
							        <option value="3" ATTR="outbox"><fmt:message code="email.title.sent" /></option>
							        <option value="4" ATTR="recycle"><fmt:message code="email.title.wastebasket" /></option>
						        </select>
							</td>
						</tr>
						<tr>
							<td><fmt:message code="email.th.mailtype" />：</td>
							<td>
								<select name="READ_FLAG" class="selectReader">
						          	<option value=""><fmt:message code="email.th.own" /></option>
						          	<option value="0"><fmt:message code="email.th.unread" /></option>
						         	<option value="1"><fmt:message code="email.th.read" /></option>
						        </select>
							</td>
						</tr>
						<tr>
							<td><fmt:message code="global.lang.date" />：</td>
							<td>
								<input class="laydate-icon" id="start" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})" style="width: 150px;"> &nbsp;<fmt:message code="global.lang.to" />&nbsp;
								<input class="laydate-icon" id="end" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})" style="width: 150px;">
							</td>
						</tr>
						<tr>
							<td><fmt:message code="email.th.sender" />：</td>
							<td>
								<input type="text" name="txt" id="txt1" readonly value="" />
								<a href="javascript:;" style="text-decoration: none;color: #207BD6;margin-right: 10px;" id="checkUser"><fmt:message code="notice.th.chose" /></a>
								<a href="javascript:;" style="text-decoration: none;color: #207BD6;" id="clearUser"><fmt:message code="notice.th.delete1" /></a>
							</td>
						</tr>
						<tr>
							<td><fmt:message code="email.th.mailmajor" />：</td>
							<td>
								<input type="text" name="txt" id="txt2" value="" />
							</td>
						</tr>
						<tr>
							<td><fmt:message code="email.th.mailcontent" />：</td>
							<td>
								<input type="text" name="txt" id="txt3" value="" />
							</td>
						</tr>
						<!-- <tr>
							<td><fmt:message code="email.th.mailcontent" />：</td>
							<td>
								<input type="text" name="txt" id="txt4" value="" />
							</td>
						</tr>
						<tr>
							<td><fmt:message code="email.th.mailcontent" />：</td>
							<td>
								<input type="text" name="txt" id="txt5" value="" />
							</td>
						</tr> -->
						<tr>
							<td><fmt:message code="email.th.filefolder" />：</td>
							<td>
								<input type="text" name="txt" id="txt6" value="" />
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div name="btn" id="btn" >
									<%--<div class="DIV_Img"><img src="../img/icon_refer.png" alt=""></div>--%>
									<div class="DIV_Txt"><span style="margin-left: 28px;"><fmt:message code="global.lang.query" /></span></div>
								</div>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="tac" style="display:none;">
				<div class="up_header">
					<div class="up_nav">
						<ul>
							<li id="RemoveTo" >
								<img src="/img/commonTheme/theme6/icon_move_06.png" class="im"><fmt:message code="email.th.remove" /><img src="/img/commonTheme/theme6/icon_more_06.png" class="more_im">
								<div class="RemoveTo_div" style="display:none;">
									<ul style="left: -41px;top: 0;z-index: 9999;border:1px solid #ccc;background: #fff;padding-left: 0">

									</ul>
								</div>
							</li>
							<li id="delete" dataheng=""  data-deletetype="inbox" data-defats="otherBox" data-box="">
								<img src="/img/commonTheme/theme6/icon_delete_06.png" class="im" style="vertical-align: text-bottom;margin-right: 2px;    width: 16px;"><fmt:message code="menuSSetting.th.deleteMenu" /></li>
						</ul>
					</div>

				</div>

				<input type="hidden" name="boxType" value="">
				<table cellspacing="0" cellpadding="0" style="border-collapse:collapse;width:99%;">
						<tr class='befor'>
							<th width="6%">
								<input type="checkbox" name="checkbox" id="checkbox" value="" />
							</th>
							<th width="6%"><fmt:message code="notice.th.state" /></th>
							<th width="6%"><fmt:message code="email.th.sign" /></th>
							<th width="16%"><fmt:message code="email.th.sender" /></th>
							<th width="40%" class="theme"><fmt:message code="email.th.main" /></th>
							<th width="16%"><fmt:message code="email.th.time" /></th>
							<th width="10%"><fmt:message code="email.th.file" /></th>
						</tr>
						<tr>
							<td colspan="7">
								<%--<div class="M-box3"></div>--%>
								<%--<input type="button" name="but" id="but" value="返回">--%>
									<div id="but" class="but"><span style="margin-right: 8px;font-size: 14px;"><fmt:message code="notice.th.return" /></span></div>
							</td>
						</tr>
					</table>
				<div class="right">
					<!-- 分页按钮-->
					<div class="M-box3" id="dbgz_page">
					</div>

				</div>
			</div>
		</div>
		<script type="text/javascript">
			var user_id='';
			//时间控件调用
//			var start = {
//			  elem: '#start',
//			  format: 'YYYY-MM-DD hh:mm:ss',
//			 /* min: laydate.now(), //设定最小日期为当前日期*/
//			 /* max: '2099-06-16 23:59:59', //最大日期*/
//			  istime: true,
//			  istoday: false,
//			  choose: function(datas){
//			     end.min = datas; //开始日选好后，重置结束日的最小日期
//			     end.start = datas //将结束日的初始值设定为开始日
//			  }
//			};
//			var end = {
//			  elem: '#end',
//			  format: 'YYYY-MM-DD hh:mm:ss',
//			  /*min: laydate.now(),*/
//			  /*max: '2099-06-16 23:59:59',*/
//			  istime: true,
//			  istoday: false,
//			  choose: function(datas){
//			    start.max = datas; //结束日选好后，重置开始日的最大日期
//			  }
//			};
//			laydate(start);
//			laydate(end);

			$(function(){
//			    选人
				$('select[name="BOX"]').on('change',function(){
                    var selectVal = $(this).val();
                    // console.log(selectVal);
                    if(selectVal=='3'){
                        $(this).parent().parent().siblings().eq(4).children().eq(0).html('<fmt:message code="email.th.recipients" />:');
                    }else{
                        $(this).parent().parent().siblings().eq(4).children().eq(0).html('<fmt:message code="email.th.sender" />:');
					}
                });
				$('#checkUser').on('click',function () {
					user_id='txt1';
                    $.popWindow("../common/selectUser?0");
                })
//				清空选人
				$('#clearUser').on('click',function () {
					$('#txt1').val('');
					$('#txt1').attr('username','');
					$('#txt1').attr('dataid','');
					$('#txt1').attr('user_id','');
					$('#txt1').attr('userprivname','');
                })
				$('#btn').on('click',function(){
                    $('.tac').find('.Hover').remove();
					$('.tab').css('display','none');
					$('.tac').css('display','block');
					var ATTR=$('.BigSelect option:checked').attr('ATTR');
					var startTime=$('#start').val();
					var endTime=$('#end').val();
					var Title=$('#txt2').val();
					var cont=$('#txt3').val();
					var Attach=$('#txt6').val();
					var readers=$('.selectReader option:checked').val();
					var data={
					    'copyTime':$('input[name=copyTime]:checked').val(),
						'flag':ATTR,
						'page':1,
						'pageSize':100,
						'useFlag':true,
						'readFlag':readers,
						// 'fromUserId':FName,
						'startDate':startTime,
						'endDate':endTime,
						'subject':Title,
						'content':cont,
						'attachmentName':Attach
					};
                    if($('#txt1').attr('user_id') != undefined){
                        if($('select[name="BOX"]').val()=='3'){
                            var FName=($('#txt1').attr('user_id')).replace(',','');
                            data['toId2'] = FName;
                        }else{
                            var FName=($('#txt1').attr('user_id')).replace(',','');
                            data['fromUserId'] = FName;
                        }
                    }
                    dataListEmail($('.befor'),data);
				});

				$('#but').on('click',function(){
					$('.tac').find('.Hover').remove();
					$('.tac').css('display','none');
					$('.tab').css('display','block');
				})

                $.ajax({
                    type:'get',
                    url:'/email/getEmailNames',
                    dataType:'json',
                    data:{},
                    success:function(data) {
                        var str='';
                        for(var i=0;i<data.object.length;i++){
                            str += '<input type="radio" name="copyTime" value="'+ data.object[i] +'" style="margin-top: 1px;vertical-align: middle;">'+
                            '<label for="COPY_TIME">'+ data.object[i] +'</label>'
						}
						$('.radiobox').append(str);
                    }
                });
			})

            function detail(id,flag){
                var boxType=$('input[name="boxType"]').val();
                var copyTime = $('input[name="copyTime"]:checked').val()
                window.open('/email/emailDetail?id='+id+'&copyTime='+copyTime+'&boxType='+boxType+'&flag='+flag,'_blank');
            }



            function dataListEmail(element,datas) {
                var ajaxPage={
                    data:datas,
                    page:function () {
                        element.siblings('.Hover').remove();
                        var me=this;
                        $.ajax({
                            type:'get',
                            url:'showEmail',
                            dataType:'json',
                            data:me.data,
                            success:function(rsp) {
                                var data1=rsp.obj;
                                var str='';
                                for(var i=0;i<data1.length;i++){
                                    var sendTime=new Date((data1[i].sendTime)*1000).Format('yyyy-MM-dd');
                                    var datas='';
                                    if(data1[i].emailList[0].emailId == undefined){
                                        datas=data1[i].emailList[0].bodyId;
                                        $('input[name="boxType"]').val('outBox');
                                    }else{
                                        datas=data1[i].emailList[0].emailId;
                                        $('input[name="boxType"]').val('inBox');
                                    }
                                    if(data1[i].emailList[0].readFlag==1){
                                        if(data1[i].attachmentId!=''){
                                            str+='<tr class="Hover" flag="'+$('.BigSelect').val()+'">' +
                                                '<td><input type="checkbox" name="checkbox" id="checkbox" class="checkboxChild" emailId="'+datas+'" value="" /></td>' +
                                                '<td><img src="../img/readed.png"/></td>' +
                                                '<td width="6%"><img src="../img/icon_star_kong_03.png"/></td>' +
                                                '<td width="6%">'+function () {
													if(data1[i].users == undefined){
                                                        return '';
													}else {
													    return data1[i].users.userName;
													}
                                                }()+'</td>' +
                                                '<td class="theme_a" style="text-align:center;"><a href="javascript:;" onclick="detail('+datas+','+$('.BigSelect').val()+')" style="color:#2B7FE0;">'+data1[i].subject+'</a></td>' +
                                                '<td>'+sendTime+'</td><td><img src="../img/icon_accessory_03.png"/></td>' +
                                                '</tr>';
                                        }else{
                                            str+='<tr class="Hover" flag="'+$('.BigSelect').val()+'">' +
												'<td><input type="checkbox" name="checkbox" id="checkbox" class="checkboxChild" value="" emailId="'+datas+'"  /></td>' +
												'<td><img src="../img/readed.png"/></td>' +
												'<td width="6%"><img src="../img/icon_star_kong_03.png"/></td>' +
												'<td width="6%">'+function () {
                                                    if(data1[i].users == undefined){
                                                        return '';
                                                    }else {
                                                        return data1[i].users.userName;
                                                    }
                                                }()+'</td>' +
												'<td class="theme_a" style="text-align:center;"><a href="javascript:;" onclick="detail('+datas+','+$('.BigSelect').val()+')" style="color:#2B7FE0;">'+data1[i].subject+'</a></td>' +
												'<td>'+sendTime+'</td><td>&nbsp</td></tr>';
                                        }

                                    } else if(data1[i].emailList[0].readFlag==0){
                                        if(data1[i].attachmentId!=''){
                                            str+='<tr class="Hover" flag="'+$('.BigSelect').val()+'">' +
												'<td><input type="checkbox" name="checkbox" class="checkboxChild" id="checkbox" value="" emailId="'+datas+'" /></td>' +
												'<td><img src="../img/readed.png"/></td>' +
												'<td width="6%"><img src="../img/icon_star_kong_03.png"/></td>' +
												'<td width="6%">'+function () {
                                                    if(data1[i].users == undefined){
                                                        return '';
                                                    }else {
                                                        return data1[i].users.userName;
                                                    }
                                                }()+'</td>' +
												'<td class="theme_a" style="text-align:center;"><a href="javascript:;" onclick="detail('+datas+','+$('.BigSelect').val()+')" style="color:#2B7FE0;">'+data1[i].subject+'</a></td>' +
												'<td>'+sendTime+'</td>' +
												'<td><img src="../img/icon_accessory_03.png"/></td></tr>';
                                        }else{
                                            str+='<tr class="Hover" flag="'+$('.BigSelect').val()+'">' +
												'<td><input type="checkbox" name="checkbox" id="checkbox" class="checkboxChild" value="" emailId="'+datas+'" /></td>' +
												'<td><img src="../img/readed.png"/></td>' +
												'<td width="6%"><img src="../img/icon_star_kong_03.png"/></td>' +
												'<td width="6%">'+function () {
                                                    if(data1[i].users == undefined){
                                                        return '';
                                                    }else {
                                                        return data1[i].users.userName;
                                                    }
                                                }()+'</td>' +
												'<td class="theme_a" style="text-align:center;"><a href="javascript:;" onclick="detail('+datas+','+$('.BigSelect').val()+')" style="color:#2B7FE0;">'+data1[i].subject+'</a></td>' +
												'<td>'+sendTime+'</td><td>&nbsp</td></tr>';
                                        }
                                    }

                                }
                                element.after(str);
//                                element.append(strTh+str);
                                me.pageTwo(rsp.totleNum,me.data.pageSize,me.data.page)
								$('.tac').on('click','.Hover',function () {
									var states=$(this).find('.checkboxChild').prop('checked');
									if(states == true){
										$(this).find('.checkboxChild').prop('checked',true);
										$(this).addClass('backList');
									}else {
										$('#checkbox').prop('checked',false);
										$(this).find('.checkboxChild').prop('checked',false);
										$(this).removeClass('backList');
									}
									var child =   $(".checkboxChild");
									for(var i=0;i<child.length;i++){
										var childstate= $(child[i]).prop("checked");
										if(states!=childstate){
											return
										}
									}
									$('#checkbox').prop("checked",states);
								})
								$('#checkbox').prop('checked',false);
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

            function dataUndefind(data) {
				if(data == 'undefined'){
				    return '';
				}else {
				    return data;
				}
            }

			//点击移动按钮事件
			$('#RemoveTo').on('click',function(e){
				e.stopPropagation();
				$('.RemoveTo_div').toggle();
			})
			$.ajax({
				type:'GET',
				url:'showEmailBox',
				dataType:'json',
				data:{
					'page':1,
					'pageSize':100,
					'useFlag':false
				},
				success:function(rsp){
					var data1=rsp.obj;
					var str='';
					var str1='';
					if(data1.length > 0){
						for(var i=0;i<data1.length;i++){
							str+='<li class="otherLi" boxId="'+data1[i].boxId+'"><a href="javascript:;"><img src="../img/commonTheme/${sessionScope.InterfaceModel}/icon_file_11.png"/>'+data1[i].boxName+'</a></li>';
							str1+='<li class="RemoveTo_child" boxId="'+data1[i].boxId+'">'+data1[i].boxName+'</li>';
						}
						$('.other .ul_show ul').html(str);
						$('.up_nav .RemoveTo_div ul').html(str1);
					}
				}
			})
			function fnc(){
				var ATTR=$('.BigSelect option:checked').attr('ATTR');
				var startTime=$('#start').val();
				var endTime=$('#end').val();
				var Title=$('#txt2').val();
				var cont=$('#txt3').val();
				var Attach=$('#txt6').val();
				var readers=$('.selectReader option:checked').val();
				var data={
					'copyTime':$('input[name=copyTime]:checked').val(),
					'flag':ATTR,
					'page':1,
					'pageSize':100,
					'useFlag':true,
					'readFlag':readers,
					// 'fromUserId':FName,
					'startDate':startTime,
					'endDate':endTime,
					'subject':Title,
					'content':cont,
					'attachmentName':Attach
				};
				if($('#txt1').attr('user_id') != undefined){
					if($('select[name="BOX"]').val()=='3'){
						var FName=($('#txt1').attr('user_id')).replace(',','');
						data['toId2'] = FName;
					}else{
						var FName=($('#txt1').attr('user_id')).replace(',','');
						data['fromUserId'] = FName;
					}
				}
				dataListEmail($('.befor'),data);
			}

			// 点击全选
			$('#checkbox').on('click',function () {
				var state=$(this).prop('checked');
				if(state == true){
					$(this).prop('checked',true);
					$('.Hover').addClass('backList');
					$('.checkboxChild').prop('checked',true);
				}else{
					$(this).prop('checked',false);
					$('.Hover').removeClass('backList');
					$('.checkboxChild').prop('checked',false);
				}
			})
			//监听的删除
			$('#delete').on('click',function () {
				var length = $('[name=checkbox]:checked').length;
				var tid = '';
				var tids =0
				var arrId1=[];
				var arrId2=[];
				var array = []
				for (var i = 0; i < length; i++) {
					var $this = $('[name=checkbox]:checked').eq(i);
					tid = $this.attr('emailId')
					arrId1.push(tid);
				}
				if (length == 0) {
					layer.msg('<fmt:message code="email.th.pleaseSelectAtLeastOnePieceOfData" />', {icon: 2});
				}else{
					for(var i = 0; i < arrId1.length; i++) {
						if(arrId1[i] != undefined) {
							array.push(arrId1[i])
							arrId2.push(tids);
						}
					}
					//删除判断
					layer.confirm('<fmt:message code="sup.th.Delete" />？', {
						btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'] //按钮
					}, function () {
						//确定删除，调接口
						$.ajax({
							url: '/email/deleteEmail',
							type: 'get',
							dataType: 'json',
							data: {
								"flag":$('.BigSelect option:checked').attr('ATTR'),
								"requestFlags":array,
								"deleteFlags":arrId2
							},
							success: function (obj) {
								if(obj.msg=='ok'){
									layer.msg('<fmt:message code="workflow.th.delsucess" />', {icon: 6});
									fnc()
								}else{
									layer.msg('<fmt:message code="license.deleSucess" />', {icon: 6});
								}
							}
						})
					}, function () {
						layer.closeAll();
					});
				}
			})

			//点击移动按钮下的文件夹
			$('.RemoveTo_div').on('click','.RemoveTo_child',function(){
				var length = $('[name=checkbox]:checked').length;
				var id=$(this).attr('boxId');
				var emailId='';
				var arrId=[];
				var arrays = []
				for (var i = 0; i < length; i++) {
					var $this = $('[name=checkbox]:checked').eq(i);
					emailId = $this.attr('emailId')
					arrId.push(emailId);
				}
				if (length == 0) {
					layer.msg('<fmt:message code="email.th.pleaseSelectAtLeastOnePieceOfData" />', {icon: 2});
				}else{
					var data
					if(length<2){
						 data={
							'boxId':id,
							'emailId':emailId
						}
					}else{
						for(var i = 0; i < arrId.length; i++) {
							if(arrId[i] != undefined) {
								arrays.push(arrId[i])
							}
						}
						data={
							'boxId':id,
							'requestFlags':arrays
						}
					}
					$.ajax({
						type:'post',
						url:'updateEmailBox',
						dataType:'json',
						data:data,
						success:function(obj){
							if(obj.msg=='ok'){
								layer.msg('<fmt:message code="dem.th.MobileSuccess" />', {icon: 6});
								fnc()
							}else{
								layer.msg('<fmt:message code="dem.th.MobileFailure" />', {icon: 6});
							}
						}
					})
				}
			})
		</script>
	</body>
</html>

