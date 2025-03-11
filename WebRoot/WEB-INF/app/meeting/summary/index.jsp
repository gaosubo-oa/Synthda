<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/27
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title><fmt:message code="main.meetingsummary" /></title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
	<link rel="stylesheet" href="/css/meeting/myMeeting.css">
	<link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
	<link rel="stylesheet" href="/lib/laydate/need/laydate.css">
	<link rel="stylesheet" href="/lib/pagination/style/pagination.css">
	<%--<link rel="stylesheet" href="/css/base.css">--%>
	<script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/layer/layer.js?20201106"></script>
	<script src="/js/base/base.js"></script>
	<script src="/lib/laydate/laydate.js"></script>
	<script src="/js/jquery/jquery.cookie.js"></script>
	<script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
	<script src="/js/jquery/jquery.form.min.js"></script>
	<script src="../js/attachment/attachView.js?20210406.1" type="text/javascript" charset="utf-8"></script>

	<style>
		.tdStyle1{
			overflow: hidden;
			text-overflow:ellipsis;
			white-space: nowrap;
			padding: 10px;
		}
		.jump-ipt{
			float: left;
			width: 30px;
			height: 30px;
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
		.M-box3 a:hover {
			color: #fff;
			background: #2b7fe0;
		}
	</style>
</head>
<body style="font-family: 微软雅黑;">
<div class="headTop">
	<div class="headImg">
		<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_summary.png" alt="">
	</div>
	<div class="divTitle">
		<fmt:message code="main.meetingsummary" />
	</div>
</div>
<div class="main">
		<div class="pagediv" id="already" style="margin: 0 auto;width: 97%;margin-top: 50px;">
			<table>
				<thead>
				<tr>
					<th width="20%" style="text-align: center"><fmt:message code="meet.th.ConferenceName" /></th>
					<th><fmt:message code="sup.th.Applicant" /></th>
					<th><fmt:message code="sup.th.startTime" /></th>
					<th><fmt:message code="meet.th.EndTime" /></th>
					<th><fmt:message code="meet.th.ConferenceSummaryStatus" /></th>
					<th width="20%"><fmt:message code="notice.th.operation" /></th>
				</tr>
				</thead>
				<tbody>
			<%--	<tr>
					<td>测试附件</td>
					<td>系统管理员</td>
					<td>2017-07-27 12:30</td>
					<td>2017-07-27 13:00</td>
					<td>已上传</td>
					<td>
						<a href="javascript:;" style="display: block;">查看纪要</a>
						<a href="javascript:;" style="display: block;">编辑会议纪要</a>
					</td>
				</tr>--%>
				</tbody>
			</table>
			<div id="dbgz_page" class="M-box3 fr" style="margin-right: 5%;margin-top: 1%">

			</div>
		</div>
	</div>
</div>

<script>
    var user_id='';
    $(function () {
        //初始化数据
        init();



        $("#stateUser").on("click",function(){//选人员控件
            user_id='userDuser';
            $.popWindow("../common/selectUser");
        });
        $('#clearState').on("click",function(){ //清空人员
            $('#userDuser').attr('user_id','');
            $('#userDuser').attr('dataid','');
            $('#userDuser').val('');
        });
    })

	//点击查看会议纪要
    $('.pagediv').on('click','.detailData',function(event){
        var sId=$(this).parents('tr').attr('Sid');
        event.stopPropagation();
        layer.open({
            type: 1,
            title:['<fmt:message code="main.meetingsummary" />', 'background-color:#2b7fe0;color:#fff;'],
            area: ['800px', '350px'],
            shadeClose: true, //点击遮罩关闭
            btn: ['<fmt:message code="global.lang.close" />'],
            content: '<div class="table"><table style="width: 80%; margin-left:60px; margin-top: 30px;">' +
            '<tr style="height: 50px;"><td style="width: 100px"><fmt:message code="workflow.th.name" />：</td><td class="data1" style="text-align: center"></td></tr>' +
            '<tr  style="height: 50px;"><td style="width: 100px"><fmt:message code="meet.th.DesignatedReader" />：</td><td class="data2" style="text-align: center"></td></tr>' +
            '<tr  style="height: 50px;"><td style="width: 100px"><fmt:message code="email.th.file" />：</td><td class="data3" style="text-align: center"></td></tr>' +
            '<tr  style="height: 50px;"><td rowspan="3" style="width: 100px"><fmt:message code="meet.th.SummaryContent" />：</td><td class="data4" style="text-align:center;word-wrap: break-word;"> </td></tr>' +
            '</table></div>',
            success:function(){
                $.ajax({
                    type:'get',
                    url:'/MeetSummary/getMeetSummarydetail',
                    dataType:'json',
                    data:{'sid':sId},
                    success:function(res){
						var datas = res.object;
						$('.data1').append(datas.meetName);
						$('.data2').append(datas.readPeopleNames);
						$('.data4').append(datas.summary);
						if (datas.attachmentList.length > 0) {
							<%--for(var i=0;i<datas.attachmentList.length;i++){--%>
							<%--str+='<div style="line-height: 0;"><img style="width:16px;margin-right: 5px;" src="../img/file/cabinet@.png"/><a href="/download?'+datas.attachmentList[i].attUrl+'">'+datas.attachmentList[i].attachName+'</a></div>'--%>
							<%--}--%>
							$('.data3').append(attachView(datas.attachmentList, '', '4', '0', '1', '0'));
						}
                    }
                })
            },
            yes:function(index){

                layer.close(index);
            },
        });
    });

     //初始化数据函数
	function init(){
        $('.pagediv tbody tr').remove();

        //        列表带分页
        var ajaxPageLe={
            data:{
                page:1,//当前处于第几页
                pageSize:5,//一页显示几条
                useFlag:true
                // computationNumber:null
            },
            page:function () {
                var me=this;

                $.ajax({
                    type:'get',
                    url:'/MeetSummary/getAllInfo',
                    data:me.data,
                    dataType:'json',
                    success:function(res) {
                        var data=res.obj;
                        var str='';
                        if(data.length>0){
                            for(var i=0;i<data.length;i++) {
                                if(data[i].recorderId==$.cookie('uid')){
                                    str+='<tr style="height: 43px;" Sid="'+data[i].sid+'"><td style="text-align: center" class="tdStyle1" title="' + data[i].meetName + '"><a href="javascript:void(0);" class="meetingDetail"  sid="'+data[i].sid+'">'+data[i].meetName+'</a><td class="tdStyle1">'+data[i].userName+'</td><td class="tdStyle1">'+data[i].startTime+'</td><td class="tdStyle1">'+data[i].endTime+'</td><td class="tdStyle1">'+data[i].isuploadsummary+'</td><td><a href="javascript:;" class="detailData" style="margin-right: 10px;"><fmt:message code="meet.th.ViewMinutes" /></a><a href="javascript:;" class="editData" style=""><fmt:message code="doc.th.EditMeetingMinutes" /></a></td>';
                                }else{
                                    str+='<tr style="height: 43px;" Sid="'+data[i].sid+'"><td style="text-align: center" class="tdStyle1" title="' + data[i].meetName + '"><a href="javascript:void(0);" class="meetingDetail"  sid="'+data[i].sid+'">'+data[i].meetName+'</a><td class="tdStyle1">'+data[i].userName+'</td><td class="tdStyle1">'+data[i].startTime+'</td><td class="tdStyle1">'+data[i].endTime+'</td><td class="tdStyle1">'+data[i].isuploadsummary+'</td><td><a href="javascript:;" class="detailData" style=""><fmt:message code="meet.th.ViewMinutes" /></a></td>';
                                }
                            }
                            $('.pagediv tbody').html(str);
                            me.pageTwo(res.totleNum,me.data.pageSize,me.data.page)
                        }
                    }
                });

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
        ajaxPageLe.page();
	}

    //点击会议名称显示会议详情
    $('.pagediv').on('click','.meetingDetail',function (event){
        $.ajax({
            url: '/meeting/queryMeetingById',
            type: 'get',
            dataType: 'json',
            data: {
                sid: $(this).attr("sid")
            },
            success: function (obj) {
                var data=obj.object;
                var str='';
                if(data.attachmentList && data.attachmentList.length > 0){
                    for(var i=0;i<data.attachmentList.length;i++){
                        str+='<div style="line-height: 0;"><img style="width:16px;margin-right: 5px;" src="../img/file/cabinet@.png"/><a href="/download?'+data.attachmentList[i].attUrl+'">'+data.attachmentList[i].attachName+'</a></div>'
                    }
                }else{
                    str='';
                }
                layer.open({
                    type: 1,
                    title: ['<fmt:message code="meet.th.SeeConferenceDetails" />', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['600px', '500px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['<fmt:message code="global.lang.close" />'],
                    content:  '<div class="table"><table style="margin:auto;">' +
                    '<tr><td width="30%"><span class="span_td"><fmt:message code="workflow.th.name" />：</span></td><td><span>'+data.meetName+'</span></td></tr>'+
                    '<tr><td width="30%"><span class="span_td"><fmt:message code="email.th.main" />：</span></td><td><span>'+data.subject+'</span></td></tr>'+
                    '<tr><td width="30%"><span class="span_td"><fmt:message code="sup.th.Applicant" />：</span></td><td><span>'+data.userName+'</span></td></tr>'+
                    '<tr><td width="30%"><span class="span_td">联系电话：</span></td><td><span>'+data.mobileNo+'</span></td></tr>'+
                    '<tr><td width="30%"><span class="span_td"><fmt:message code="meet.th.MeetingMinutesClerk" />：</span></td><td><span>'+data.recorderName+'</span></td></tr>'+
                    '<tr><td width="30%"><span class="span_td"><fmt:message code="sup.th.ApplicationTime" />：</span></td><td><span>从 &nbsp;</span><span>'+data.startTime+'</span><span>&nbsp;<fmt:message code="global.lang.to" />&nbsp;</span><span>'+data.endTime+'</span></td></tr>' +
                    '<tr><td width="30%"><span class="span_td"><fmt:message code="meet.th.ConferenceRoom" />：</span></td><td><span>'+data.meetRoomName+'</span></td></tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.ApprovalAdministrator" />：</span></td><td><span>'+data.managerName+'</span></td></tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.external" />：</span></td><td><span>'+data.attendeeOut+'</span></td></tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.internal" />：</span></td><td><span>'+data.attendeeName+'</span></td></tr>'+
                    '<tr><td><span class="span_td">前台会议服务人员：</span></td><td><span>'+ (data.serviceUserName || '') +'</span></td></tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceRoomEquipment" />：</span></td><td><span>'+data.equipmentNames+'</span></td></tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="email.th.file" />：</span></td><td><span><div class="inPole">'+str+'</div></span></td></tr>' +
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceDescription" />：</span></td><td><span>'+data.meetDesc+'</span></td></tr>'+
                    '</table></div>',
                })
            }
        })
    })


	//编辑会议纪要
    $('.pagediv').on('click','.editData',function (event){
        var sId=$(this).parents('tr').attr('Sid');
        event.stopPropagation();
        layer.open({
            type: 1,
            title:['<fmt:message code="doc.th.EditMeetingMinutes" />', 'background-color:#2b7fe0;color:#fff;'],
            area: ['600px', '400px'],
            shadeClose: true, //点击遮罩关闭
            btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
            content: '<div class="div_table" style="margin: 30px auto;width: 80%;">' +
            '<div class="div_tr"><span class="span_td" style="text-align: right"><fmt:message code="workflow.th.name" />：</span><span><input type="text" readonly="true"  style="width: 180px; float: none" name="typeName" class="inputTd meetName" value="" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>'+
            '<div class="div_tr"><span class="span_td" style="text-align: right"><fmt:message code="meet.th.DesignatedReader" />：</span><span><div class="inPole" style="float: none;"><textarea  name="txt" class="recorderName" id="recoderDuser" user_id="" value="" disabled style="min-width: 220px;min-height:60px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectRecorder" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearRecoder" class="clearRecoder "><fmt:message code="global.lang.empty" /></a></span></div></span></div>'+
            //照片
			'<div class="div_tr photo"><span class="span_td" style="text-align: right">照片：</span><span><div class="inPole" style="float: none;"><div class="Attachment"></div>' +
			'<form  target="uploadiframe"  action="../upload?module=summary_meet" enctype="multipart/form-data" method="post" >'+
			'<input type="file" name="file"   class="w-icon5 uploadinputimg" style="position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">' +
			'<a href="javascript:;">' +
			'<img style="margin-right:5px;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>'+
			'</form></div></span></div>'+
			//录像
			'<div class="div_tr video"><span class="span_td" style="text-align: right">录像：</span><span><div class="inPole" style="float: none;"><div class="Attachment"></div>' +
			'<form  target="uploadiframe"  action="../upload?module=summary_meet" enctype="multipart/form-data" method="post" >'+
			'<input type="file" name="file"  class="w-icon5 uploadinputimg" style="position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">' +
			'<a href="javascript:;">' +
			'<img style="margin-right:5px;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>'+
			'</form></div></span></div>'+
			//录音
			'<div class="div_tr recording"><span class="span_td" style="text-align: right">录音：</span><span><div class="inPole" style="float: none;"><div class="Attachment"></div>' +
			'<form  target="uploadiframe"  action="../upload?module=summary_meet" enctype="multipart/form-data" method="post" >'+
			'<input type="file" name="file"  class="w-icon5 uploadinputimg" style="position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">' +
			'<a href="javascript:;">' +
			'<img style="margin-right:5px;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>'+
			'</form></div></span></div>'+
			//会议纪要
			'<div class="div_tr meeingContent"><span class="span_td" style="text-align: right">会议纪要：</span><span><div class="inPole" style="float: none;"><div class="Attachment"></div>' +
			'<form  target="uploadiframe"  action="../upload?module=summary_meet" enctype="multipart/form-data" method="post" >'+
			'<input type="file" name="file"   class="w-icon5 uploadinputimg" style="position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">' +
			'<a href="javascript:;">' +
			'<img style="margin-right:5px;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>'+
			'</form></div></span></div>'+


			'<div class="div_tr otherFile"><span class="span_td" style="text-align: right"><fmt:message code="sup.th.RelatedAccessories" />：</span><span><div class="inPole" style="float: none;"><div class="Attachment"></div>' +
            '<form id="uploadimgform" target="uploadiframe"  action="../upload?module=summary_meet" enctype="multipart/form-data" method="post" >'+
            '<input type="file" name="file" id="uploadinputimg"  class="w-icon5 uploadinputimg" style="position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">' +
            '<a href="javascript:;" id="uploadimg">' +
            '<img style="margin-right:5px;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>'+
            '</form></div></span></div>'+
            '<div class="div_tr"><span class="span_td" style="text-align: right"><fmt:message code="doc.th.MeetingMinutesContent" />：</span><span><div class="inPole"><textarea name="meetDesc" id="meetDesc" class="meetDesc" value="6868686" style="min-width: 300px;min-height:100px;"></textarea></div></span></div>'+
            '</div>',
            success:function(){
                $.ajax({
                    url:'/MeetSummary/getMeetSummarydetail',
                    type:'get',
                    dataType:'json',
                    data:{
                        sid:sId
                    },
                    success:function(obj){
                        var data=obj.object;

                        //照片
						var str2='';
						if(data.photoList && data.photoList.length>0){
							for(var i=0;i<data.photoList.length;i++){
								str2+='<div class="dech" deUrl="'+data.photoList[i].attUrl+'"><a href="/download?'+data.photoList[i].attUrl+'" NAME="'+data.photoList[i].attachName+'*"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+data.photoList[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+data.photoList[i].aid+'@'+data.photoList[i].ym+'_'+data.photoList[i].attachId+',"></div>';
							}
						}else{
							str2='';
						}
						$('.photo .Attachment').append(str2);

						//录像
						var str3='';
						if(data.videoList && data.videoList.length>0){
							for(var i=0;i<data.videoList.length;i++){
								str3+='<div class="dech" deUrl="'+data.videoList[i].attUrl+'"><a href="/download?'+data.videoList[i].attUrl+'" NAME="'+data.videoList[i].attachName+'*"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+data.videoList[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+data.videoList[i].aid+'@'+data.videoList[i].ym+'_'+data.videoList[i].attachId+',"></div>';
							}
						}else{
							str3='';
						}
						$('.video .Attachment').append(str3);

						//录音
						var str4='';
						if(data.recordList && data.recordList.length>0){
							for(var i=0;i<data.recordList.length;i++){
								str4+='<div class="dech" deUrl="'+data.recordList[i].attUrl+'"><a href="/download?'+data.recordList[i].attUrl+'" NAME="'+data.recordList[i].attachName+'*"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+data.recordList[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+data.recordList[i].aid+'@'+data.recordList[i].ym+'_'+data.recordList[i].attachId+',"></div>';
							}
						}else{
							str4='';
						}
						$('.recording .Attachment').append(str4);

						//会议纪要
						var str5='';
						if(data.summaryAttachmentList && data.summaryAttachmentList.length>0){
							for(var i=0;i<data.summaryAttachmentList.length;i++){
								str5+='<div class="dech" deUrl="'+data.summaryAttachmentList[i].attUrl+'"><a href="/download?'+data.summaryAttachmentList[i].attUrl+'" NAME="'+data.summaryAttachmentList[i].attachName+'*"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+data.summaryAttachmentList[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+data.summaryAttachmentList[i].aid+'@'+data.summaryAttachmentList[i].ym+'_'+data.summaryAttachmentList[i].attachId+',"></div>';
							}
						}else{
							str5='';
						}
						$('.meeingContent .Attachment').append(str5);

						//相关附件
						var str='';
						if(data.attachmentList && data.attachmentList.length>0){
							for(var i=0;i<data.attachmentList.length;i++){
								str+='<div class="dech" deUrl="'+data.attachmentList[i].attUrl+'"><a href="/download?'+data.attachmentList[i].attUrl+'" NAME="'+data.attachmentList[i].attachName+'*"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+data.attachmentList[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+data.attachmentList[i].aid+'@'+data.attachmentList[i].ym+'_'+data.attachmentList[i].attachId+',"></div>';
							}
						}else{
							str='';
						}
						$('.otherFile .Attachment').append(str);

                        $('input[name="typeName"]').val(data.meetName);
                        $('#recoderDuser').val(data.readPeopleNames);
                        $('#recoderDuser').attr('dataid', data.readPeopleId);
                        $('#meetDesc').val(data.summary);

                    }
                });
                //删除附件
                $('.Attachment').on('click','.deImgs',function(){
                    var data=$(this).parents('.dech').attr('deUrl');
                    var dome=$(this).parents('.dech');
                    deleteChatment(data,dome);
                })
            },
            yes:function(index){
                if($('input[name="typeName"]').val() == '' ){
                    $.layerMsg({content:'<fmt:message code="sup.th.With*" />！',icon:2});
                    return;
                }

                //照片
				var photoId='';
				var photoName='';
                for(var i=0;i<$('.photo .Attachment .inHidden').length;i++){
					photoId += $('.photo .Attachment .inHidden').eq(i).val();
					photoName += $('.photo .Attachment a').eq(i).attr('NAME');
                }

				//录像
				var videoId='';
				var videoName='';
				for(var i=0;i<$('.video .Attachment .inHidden').length;i++){
					videoId += $('.video .Attachment .inHidden').eq(i).val();
					videoName += $('.video .Attachment a').eq(i).attr('NAME');
				}

				//录音
				var recordId='';
				var recordName='';
				for(var i=0;i<$('.recording .Attachment .inHidden').length;i++){
					recordId += $('.recording .Attachment .inHidden').eq(i).val();
					recordName += $('.recording .Attachment a').eq(i).attr('NAME');
				}

				//会议纪要
				var summaryAttachmentId='';
				var summaryAttachmentName='';
				for(var i=0;i<$('.meeingContent .Attachment .inHidden').length;i++){
					summaryAttachmentId += $('.meeingContent .Attachment .inHidden').eq(i).val();
					summaryAttachmentName += $('.meeingContent .Attachment a').eq(i).attr('NAME');
				}

				//相关附件
				var aId='';
				var uId='';
				for(var i=0;i<$('.otherFile .Attachment .inHidden').length;i++){
					aId += $('.otherFile .Attachment .inHidden').eq(i).val();
					uId += $('.otherFile .Attachment a').eq(i).attr('NAME');
				}

                var paraData={
                    sid:sId,
                    meetName:   $('input[name="typeName"]').val(),
                    readPeopleId:     $('#recoderDuser').attr('dataid'),
                    summary: $('#meetDesc').val(),
					photoId:photoId,
					photoName:photoName,
					videoId:videoId,
					videoName:videoName,
					recordId:recordId,
					recordName:recordName,
					summaryAttachmentId:summaryAttachmentId,
					summaryAttachmentName:summaryAttachmentName,
					attachmentId:aId,
					attachmentName:uId,
                }

                $.ajax({
                    url: '/MeetSummary/editMeetSummarydetail',
                    type: 'get',
                    dataType: 'json',
                    data: paraData,
                    success: function (obj) {
                        init();
                        if(obj.flag){
                            $.layerMsg({content:'<fmt:message code="depatement.th.Modifysuccessfully" />！',icon:1});
                        }else{
                            $.layerMsg({content:'<fmt:message code="depatement.th.modifyfailed" />！',icon:2});
                        }
                    }
                })
                layer.close(index);
            },
        });
        //删除附件
        $('.Attachment').on('click','.deImgs',function(){
            var data=$(this).parents('.dech').attr('deUrl');
            var dome=$(this).parents('.dech');
            deleteChatment(data,dome);
        })

        $('#selectRecorder').on("click",function(){//选人员控件（纪要员）
            user_id='recoderDuser';
            $.popWindow("../common/selectUser");
        });
        $('#clearRecoder').on("click",function(){ //清空人员（纪要员）
            $('#recoderDuser').attr('user_id','');
            $('#recoderDuser').attr('dataid','');
            $('#recoderDuser').val('');
        });
        <%--$('#uploadimg').on('click',function(){--%>
            <%--$('#uploadinputimg').click();--%>
        <%--})--%>
        <%--$('#uploadinputimg').on("change",function(e){--%>
            <%--var target = $(e.target);--%>
            <%--var file;--%>
            <%--if(target[0].files && target[0].files[0]){--%>
                <%--file=target[0].files[0];--%>
            <%--}--%>
            <%--if(file){--%>
                <%--$.upload($('#uploadimgform'),function(res){--%>
                    <%--var data=res.obj;--%>
                    <%--var str='';--%>
                    <%--var str1='';--%>
                    <%--console.log(res);--%>
                    <%--for(var i=0;i<data.length;i++){--%>
                        <%--str+='<div class="dech" deUrl="'+data[i].attUrl+'"><a href="/download?'+data[i].attUrl+'" NAME="'+data[i].attachName+'*"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+data[i].attachName+'</a><img class="deImg" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';--%>
						<%--/*str1+='<input type="hidden" class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',">';*/--%>
                    <%--}--%>
                    <%--$('.Attachment').append(str);--%>
                <%--});--%>
            <%--}--%>
        <%--});--%>

        $('.uploadinputimg').fileupload({
            dataType:'json',
            done: function (e, data) {
                if(data.result.obj != ''){
                    var data = data.result.obj;
                    var str = '';
                    var str1 = '';
                    for (var i = 0; i < data.length; i++) {
                        str += '<div class="dech" deUrl="' + data[i].attUrl+ '"><a href="/download?'+encodeURI(data[i].attUrl)+'" NAME="' + data[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                    }
                    $(e.target).parents('.inPole').find('.Attachment').append(str);
                }else{
                    //alert('添加附件大小不能为空!');
                    layer.alert('添加附件大小不能为空!',{},function(){
                        layer.closeAll();
                    });
                }
            }
        });

    })
	//附件删除
    function deleteChatment(data,element){

        layer.confirm('<fmt:message code="sup.th.Delete" />？', {
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
            title:"<fmt:message code="notice.th.DeleteFile" />"
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

        }, function(index){
            layer.close(index);
        });
    }
</script>
</body>
</html>
