x<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/27
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
	<title><fmt:message code="meet.th.MeetingRoomManagement" /></title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<%--<link rel="stylesheet" href="/css/meeting/myMeeting.css">--%>
	<link rel="stylesheet" href="/css/meeting/room.css">
	<link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
	<link rel="stylesheet" href="/lib/laydate/need/laydate.css">
	<link rel="stylesheet" href="/lib/pagination/style/pagination.css">
	<%--<link rel="stylesheet" href="/css/base.css">--%>
	<script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
	<script src="/lib/layer/layer.js?20201106"></script>
	<script src="/js/base/base.js"></script>
	<script src="/lib/laydate/laydate.js"></script>
	<script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
	<style>
		.table .span_td{
			margin: 0;
		}
		.equip tbody td{
			text-align: center;
		}
		.equipSpan{
			background-color:#00a2d4;
		}
		.equip {
			width: 77%;
			margin: 20px auto;
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
	</style>
	<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body style="font-family: 微软雅黑;">
<div class="headTop">
	<div class="headImg">
		<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_manageRoom.png" alt="">
	</div>
	<div class="divTitle">
		<fmt:message code="meet.th.MeetingRoomManagement" />
	</div>
	<div class="newClass" id="newClass" style="padding: 0 10px; border-radius: 20px; text-align: center;">
		<span><img style="margin-right: 4px;margin-bottom: -1px;" src="../../img/mywork/newbuildworjk.png" alt=""><fmt:message code="meet.th.NewConferenceRoom" /></span>
	</div>
</div>
<div class="main">
	<div class="pagediv" id="already" style="margin: 0 auto;width: 97%;margin-top: 50px;">
		<table>
			<thead>
			<tr>
				<th style="text-align: center"  width="5%"><%--<fmt:message code="hr.th.number" />--%></th>
				<th><fmt:message code="meet.th.ConferenceRoomName" /></th>
				<th><fmt:message code="meeting.conferenceRoomSortNumber" /></th>
				<th><fmt:message code="depatement.th.address" /></th>
				<th><fmt:message code="meet.th.NumbeAccommodated" /></th>
				<th><fmt:message code="meet.th.EquipmentStatus" /></th>
				<th><fmt:message code="meet.th.MeetingRoomManager" /></th>
				<th><fmt:message code="meet.th.ApplicatioAuthority" /></th>
				<th><fmt:message code="meet.th.Application" /></th>
				<th><fmt:message code="notice.th.operation" /></th>
			</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<div id="dbgz_page" class="M-box3 fr" style="margin-right: 5%;margin-top: 1%">

		</div>
	</div>
</div>
</div>

<script>



    var dept_id='';
    var user_id='';
    $(function () {


        //初始化数据
        init();

        //点击新建分类
        $('#newClass').on("click",function(event) {
            event.stopPropagation();
            layer.open({
                type: 1,
                title: ['<fmt:message code="meet.th.NewConferenceRoom1" />', 'background-color:#2b7fe0;color:#fff;'],
                area: ['800px', '500px'],
                shadeClose: true, //点击遮罩关闭
                btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
                content: '<div class="div_table" style="margin-left: 35px;">' +
						'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.ConferenceRoomName" />：</span><span><input type="text" style="width: 70%;float: none;margin-left:5px;" name="mrName" class="inputTd" value="" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>' +
						'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.ConferenceRoomDescription" />：</span><span><input type="text" style="width: 70%;float: none;margin-left:5px;" name="mrDesc" class="inputTd" value="" /></span></div>' +
						'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.MeetingRoomManager" />：</span><span><div class="inPole" style="width: 70%;"><textarea name="txt" id="userDuser" user_id="" value="" disabled style="width: 85%;min-height:50px;resize:none;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearUser" class="clearUser "><fmt:message code="global.lang.empty" /></a></span></div></span></div>' +
						'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.ApplicatioAuthority" />：</span><span><div class="inPole" style="width: 70%;"><textarea name="txt" id="userDept" userDept="" value="" disabled style="width: 85%;min-height:50px;resize:none;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectDept" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearDept" class="clearDept "><fmt:message code="global.lang.empty" /></a></span></div></span></div>' +
						'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.Application" />：</span><span><div class="inPole" style="width: 70%;"><textarea name="txt" id="userDuserSd" user_id="" value="" disabled style="width: 85%;min-height:50px;resize: none;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUserSd" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearUserSd" class="clearUserSd "><fmt:message code="global.lang.empty" /></a></span></div></span></div>' +
						'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.NumbeAccommodated" />：</span><span><input type="text" style="width: 70%;float: none;margin-left:5px;" name="mrCapacity" class="inputTd" value="" /></span></div>' +
						'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.ConferenceRoomEquipment" />：</span><span><div class="inPole" style="width: 70%"><textarea name="txt" id="equipmentId" class="equipmentId" equipmentId="" disabled style="width: 85%;min-height:60px;resize:none;"></textarea></span>' +
						'<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="addEquipment" class="addEquipment"><fmt:message code="global.lang.add" /></a></span>' +
						'<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearEquipment" class="clearEquipment"><fmt:message code="global.lang.empty" /></a></div></span></div>' +
						'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.EquipmentStatus" />：</span><span><input type="text" style="width: 70%;float: none;margin-left:5px;" name="mrDevice" class="inputTd" value="" /></span></div>' +
						'<div class="div_tr"><span class="span_td"><fmt:message code="depatement.th.address" />：</span><span><input type="text" style="width: 70%;float: none;margin-left:5px;" name="mrPlace" class="inputTd" value="" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>' +
				'<div class="div_tr"><span class="span_td"><fmt:message code="meeting.conferenceRoomSortNumber" />：</span><span><input type="text" style="width: 70%;float: none;margin-left:5px;" name="orderNo" class="inputTd" value="" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>' +
				'<div class="div_tr"><span class="span_td"><fmt:message code="meeting.approvalSettings" />：</span>' +
				'<span><select name="isApprove" class="inputTd" style="width: 70%;height: 25px;margin-left: 5px;">\n' +
					'	<option value="1"><fmt:message code="meeting.noApprovalNeeded" /></option>'+
						'<option value="2"><fmt:message code="meeting.approvalNeeded" /></option>'+
				'<option value="3"><fmt:message code="meeting.approvalNeededOverThreeHours" /></option>'+
				'                        </select>' +
				'</span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>' +
				'</div>',
                yes: function (index) {
					if($('input[name="mrName"]').val() == '' ){
						$.layerMsg({content:'请填写会议室名称！',icon:2});
						return;
					}
					if($('input[name="mrPlace"]').val() == '' ){
						$.layerMsg({content:'请填写地址！',icon:2});
						return;
					}
					if($('input[name="orderNo"]').val() == '' ){
						$.layerMsg({content:'会议室排序号不可为空',icon:2});
						return;
					}
					if($('input[name="isApprove"]').val() == '' ){
						$.layerMsg({content:'审批设置不能为空',icon:2});
						return;
					}
                    var data = {
                        mrName: $('input[name="mrName"]').val(),
                        mrDesc: $('input[name="mrDesc"]').val(),
                        managerids:$('#userDuser').attr('dataid'),
                        meetroomdept:$('#userDept').attr('deptid'),
                        meetroomperson:$('#userDuserSd').attr('dataid'),
                        mrCapacity:$('input[name="mrCapacity"]').val(),
                        equipmentIds:$('#equipmentId').attr('equipmentid'),
                        equipmentNames:$('#equipmentId').val(),
                        mrDevice:$('input[name="mrDevice"]').val(),
                        mrPlace:$('input[name="mrPlace"]').val(),
						orderNo:$('input[name="orderNo"]').val(),
						isApprove:$('select[name="isApprove"]').val(),
                    }
                    newClassification(data);
                    layer.close(index);
                },
            });
            $('#selectUser').on("click",function(){//选人员控件
                user_id='userDuser';
                $.popWindow("../common/selectUser");
            });
            $('#clearUser').on("click",function(){ //清空人员
                $('#userDuser').attr('user_id','');
                $('#userDuser').attr('dataid','');
                $('#userDuser').val('');
            });
            $("#selectUserSd").on("click",function(){
                user_id='userDuserSd';
                $.popWindow("../common/selectUser");
            });

            $('#clearUserSd').on("click",function(){ //清空人员
                $('#userDuserSd').attr('user_id','');
                $('#userDuserSd').attr('dataid','');
                $('#userDuserSd').val('');
            });

            $("#selectDept").on("click",function(){//选部门控件
                dept_id='userDept';
                $.popWindow("../common/selectDept");
            });
            $('#clearDept').on("click",function(){ //清空人员
                $('#userDept').attr('dept_id','');
                $('#userDept').attr('deptid','');
                $('#userDept').val('');
            });

            //查询所有办公设备
            var equipStr='';
            $.ajax({
                url: '/Meetequipment/getAllEquiet',
                type: 'get',
                dataType: 'json',
                success: function (obj) {
                    var data=obj.obj;
                    for(var i=0;i<data.length;i++){
                        equipStr+='<tr><td class="equipClick" equipmentid="'+data[i].sid+'">'+data[i].equipmentName+'</td></tr>';
                    }
                }
            })
            //选择办公设备控件
            $(".addEquipment").on("click",function(){
                layer.open({
                    type: 1,
                    title: ['<fmt:message code="meet.th.SelectDevice" />', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['300px', '500px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['<fmt:message code="global.lang.ok" />'],
                    content:'<table class="equip">' +
                    '<tr><td><span><fmt:message code="meet.th.SelectDevice" /></span></td></tr>'+
                    '<tr><td id="addAll"><span><fmt:message code="meet.th.addAll" /></span></td></tr>'+
                    '<tr><td id="delAll"><span><fmt:message code="meet.th.DeleteAll" /></span></td></tr>'+
                    equipStr+
                    '</table>',
                    success:function(){
                        $(".equipClick").on("click",function(){
                            $(this).toggleClass('equipSpan');
                        })
                        $("#addAll").on("click",function(){
                            $(".equipClick").addClass('equipSpan');
                        })
                        $("#delAll").on("click",function(){
                            $(".equipClick").removeClass('equipSpan');
                        })
                    },
                    yes:function(index){
                        var equipSpanArray=$(".equipSpan");
                        var equipId="";
                        var equipName="";
                        for(var i=0;i<equipSpanArray.length;i++){
                            equipName+=$(equipSpanArray[i]).html()+",";
                            equipId+=$(equipSpanArray[i]).attr("equipmentid")+",";
                        }
                        $(".equipmentId").attr("equipmentId",equipId);
                        $(".equipmentId").val(equipName);
                        layer.close(index);
                    }

                })
            })
            $(".clearEquipment").on("click",function(){
                $(".equipmentId").attr("equipmentId","");
                $(".equipmentId").val("");
            })

        });


    })

    //新建分类接口
    function newClassification(data){
        $.ajax({
            type:'post',
            url:'/meetingRoom/addMeetRoom',
            dataType:'json',
            data:data,
            success:function(res){
                init();
                if(res.flag){
                    $.layerMsg({content:'<fmt:message code="depatement.th.Newsuccessfully" />！',icon:1});
                }else{
                    $.layerMsg({content:'<fmt:message code="depatement.th.Newfailed" />！',icon:2});
                }
            }
        })
    }

    function init() {
        $('.pagediv tbody tr').remove();


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
                    url:'/meetingRoom/getAllMeetRoomInfo',
                    dataType:'json',
                    data:me.data,
                    success:function(res) {
                        var data=res.obj;
                        var str='';
                        if(data.length>0){
                            for(var i=0;i<data.length;i++) {
                                str+='<tr><td style="text-align: center"> </td><td><a href="javascript:void(0);" class="meetRoomDetail"  meetRoomId="'+data[i].sid+'">'+data[i].mrName+'</a></td><td style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;width: 50px;" title="'+data[i].orderNo+'">'+data[i].orderNo+'</td></td><td style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;width: 100px;" title="'+data[i].mrPlace+'">'+data[i].mrPlace+'</td><td>'+function(){if(data[i].mrCapacity==undefined){return '';}else{return data[i].mrCapacity}}()+'</td><td>'+function(){if(data[i].mrDevice==undefined){return ''}else{return data[i].mrDevice}}()+'</td><td style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;width: 100px;" title="'+data[i].managetnames+'">'+data[i].managetnames+'</td><td style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;width: 100px;" title="'+data[i].meetroomdeptName+'">'+data[i].meetroomdeptName+'</td><td style="display: block;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;width: 100px;" title="'+data[i].meetroompersonName+'">'+data[i].meetroompersonName+'</td><td><a href="javascript:edit('+data[i].sid+');"><fmt:message code="global.lang.edit" /></a>&nbsp;<a href="javascript:deleteone('+data[i].sid+');"><fmt:message code="global.lang.delete" /></a></td>';
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

    function deleteone(e){
        layer.confirm('<fmt:message code="sup.th.Delete" />？', {
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
            title:"<fmt:message code="notice.th.DeleteFile" />"
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'post',
                url:'/meetingRoom/deleteMeetRoomBySid',
                dataType:'json',
                data:{'sid':e},
                success:function(){
                    layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});
                    init();
                }
            })
        }, function(){
            layer.closeAll();
        });
	}
	//更新操作
	function edit(e) {
                layer.open({
					type: 1,
					title: ['<fmt:message code="meet.th.ModifyInformation" />', 'background-color:#2b7fe0;color:#fff;'],
					area: ['800px', '500px'],
					shadeClose: true, //点击遮罩关闭
					btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
					content: '<div class="div_table" style="margin-left: 35px;">' +
							'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.ConferenceRoomName" />：</span><span><input type="text" style="width: 70%;float: none;margin-left:5px;" name="mrName" class="inputTd" value="" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>' +
							'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.ConferenceRoomDescription" />：</span><span><input type="text" style="width: 70%;float: none;margin-left:5px;" name="mrDesc" class="inputTd" value="" /></span></div>' +
							'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.MeetingRoomManager" />：</span><span><div class="inPole" style="width: 70%"><textarea name="txt" id="userDuser" user_id="" value="" disabled style="width: 85%;min-height:50px;resize:none"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearUser" class="clearUser "><fmt:message code="global.lang.empty" /></a></span></div></span></div>' +
							'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.ApplicatioAuthority" />：</span><span><div class="inPole" style="width: 70%"><textarea name="txt" id="userDept" userDept="" value="" disabled style="width: 85%;min-height:50px;resize:none"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectDept" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearDept" class="clearDept "><fmt:message code="global.lang.empty" /></a></span></div></span></div>' +
							'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.Application" />：</span><span><div class="inPole" style="width: 70%"><textarea name="txt" id="userDuserSd" user_id="" value="" disabled style="width: 85%;min-height:50px;resize:none"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUserSd" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearUserSd" class="clearUserSd "><fmt:message code="global.lang.empty" /></a></span></div></span></div>' +
							'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.NumbeAccommodated" />：</span><span><input type="text" style="width: 70%;float: none;margin-left:5px;" name="mrCapacity" class="inputTd" value="" /></span></div>' +
							'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.ConferenceRoomEquipment" />：</span><span><div class="inPole" style="width: 70%;"><textarea name="txt" id="equipmentId" class="equipmentId" equipmentId="" disabled style="width: 85%;min-height:60px;resize: none;"></textarea></span>' +
							'<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="addEquipment" class="addEquipment"><fmt:message code="global.lang.add" /></a></span>' +
							'<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearEquipment" class="clearEquipment"><fmt:message code="global.lang.empty" /></a></div></span></div>' +
							'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.EquipmentStatus" />：</span><span><input type="text" style="width: 70%;float: none;margin-left:5px;" name="mrDevice" class="inputTd" value="" /></span></div>' +
							'<div class="div_tr"><span class="span_td"><fmt:message code="depatement.th.address" />：</span><span><input type="text" style="width: 70%;float: none;margin-left:5px;" name="mrPlace" class="inputTd" value="" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>' +
							'<div class="div_tr"><span class="span_td"><fmt:message code="meeting.conferenceRoomSortNumber" />：</span><span><input type="text" style="width: 70%;float: none;margin-left:5px;" name="orderNo" class="inputTd" value="" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>' +
							'<div class="div_tr"><span class="span_td"><fmt:message code="meeting.approvalSettings" />：</span>' +
							'<span><select name="isApprove" class="inputTd" style="width: 70%;height: 25px;margin-left: 5px;">\n' +
							'	<option value="1"><fmt:message code="meeting.noApprovalNeeded" /></option>'+
							'<option value="2"><fmt:message code="meeting.approvalNeeded" /></option>'+
							'<option value="3"><fmt:message code="meeting.approvalNeededOverThreeHours" /></option>'+
							'                        </select>' +
							'</span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>' +
							'</div>',

                    success:function (){
                  $.ajax({
                        type: 'get',
                        url: '/meetingRoom/getMeetRoomBySid',
                        data: {sid: e},
                        dataType: 'json',
                        success: function (res) {
                            var datas = res.object;
							$('input[name="mrName"]').val(datas.mrName);
                            $('input[name="mrDesc"]').val(datas.mrDesc);
                            $('#userDuser').attr({
								'user_id':datas.manageridsUserId,
                                'dataid': datas.managerids
							});
                            $('#userDuser').val(datas.managetnames);
                            $('#userDept').attr('deptid', datas.meetroomdept);
                            $('#userDept').val(datas.meetroomdeptName);
                            $('#userDuserSd').attr({
                                'dataid': datas.meetroomperson,
                                'user_id': datas.meetroompersonUserId,

                            });
                            $('#equipmentId').attr('equipmentId',datas.equipmentIds);
                            $('#equipmentId').val(datas.equipmentNames)
                            $('#userDuserSd').val(datas.meetroompersonName);
                            $('input[name="mrCapacity"]').val(datas.mrCapacity);
                            $('input[name="mrDevice"]').val(datas.mrDevice);
							$('input[name="mrPlace"]').val(datas.mrPlace);
                            $('input[name="orderNo"]').val(datas.orderNo);
							$('select[name="isApprove"]').val(datas.isApprove);
                        }
                    })
                },
                    yes: function (index) {
                        if($('input[name="mrName"]').val() == '' ){
                            $.layerMsg({content:'请填写会议室名称！',icon:2});
                            return;
                        }
                        if($('input[name="mrPlace"]').val() == '' ){
                            $.layerMsg({content:'请填写地址！',icon:2});
                            return;
                        }
						if($('input[name="orderNo"]').val() == '' ){
							$.layerMsg({content:'会议室排序号不可为空',icon:2});
							return;
						}
						if($('input[name="isApprove"]').val() == '' ){
							$.layerMsg({content:'审批设置不能为空',icon:2});
							return;
						}
                        var data = {
                            sid: e,
                            mrName: $('input[name="mrName"]').val(),
                            mrDesc: $('input[name="mrDesc"]').val(),
                            managerids:$('#userDuser').attr('dataid'),
                            meetroomdept:$('#userDept').attr('deptid'),
                            meetroomperson:$('#userDuserSd').attr('dataid'),
                            mrCapacity:$('input[name="mrCapacity"]').val(),
                            equipmentIds:$('#equipmentId').attr('equipmentid'),
                            equipmentNames:$('#equipmentId').val(),
                            mrDevice:$('input[name="mrDevice"]').val(),
                            mrPlace:$('input[name="mrPlace"]').val(),
							orderNo:$('input[name="orderNo"]').val(),
							isApprove:$('select[name="isApprove"]').val(),
                        }
                        editClassification(data);
                        layer.close(index);
                    },
                });


        //查询所有办公设备
        var equipStr='';
        $.ajax({
            url: '/Meetequipment/getAllEquiet',
            type: 'get',
            dataType: 'json',
            success: function (obj) {
                var data=obj.obj;
                for(var i=0;i<data.length;i++){
                    equipStr+='<tr><td class="equipClick" equipmentid="'+data[i].sid+'">'+data[i].equipmentName+'</td></tr>';
                }
            }
        })
        //选择办公设备控件
        $(".addEquipment").on("click",function(){
            layer.open({
                type: 1,
                title: ['<fmt:message code="meet.th.SelectDevice" />', 'background-color:#2b7fe0;color:#fff;'],
                area: ['300px', '500px'],
                shadeClose: true, //点击遮罩关闭
                btn: ['<fmt:message code="menuSSetting.th.menusetsure" />'],
                content:'<table class="equip">' +
                '<tr><td><span><fmt:message code="meet.th.SelectDevice" /></span></td></tr>'+
                '<tr><td id="addAll"><span><fmt:message code="meet.th.addAll" /></span></td></tr>'+
                '<tr><td id="delAll"><span><fmt:message code="meet.th.DeleteAll" /></span></td></tr>'+
                equipStr+
                '</table>',
                success:function(){
                    $(".equipClick").on("click",function(){
                        $(this).toggleClass('equipSpan');
                    })
                    $("#addAll").on("click",function(){
                        $(".equipClick").addClass('equipSpan');
                    })
                    $("#delAll").on("click",function(){
                        $(".equipClick").removeClass('equipSpan');
                    })
                },
                yes:function(index){
                    var equipSpanArray=$(".equipSpan");
                    var equipId="";
                    var equipName="";
                    for(var i=0;i<equipSpanArray.length;i++){
                        equipName+=$(equipSpanArray[i]).html()+",";
                        equipId+=$(equipSpanArray[i]).attr("equipmentid")+",";
                    }
                    $(".equipmentId").attr("equipmentId",equipId);
                    $(".equipmentId").val(equipName);
                    layer.close(index);
                }

            })
        })
        $(".clearEquipment").on("click",function(){
            $(".equipmentId").attr("equipmentId","");
            $(".equipmentId").val("");
        })
        $('#selectUser').on("click",function(){//选人员控件
            user_id='userDuser';
            $.popWindow("../common/selectUser");
        });
        $('#clearUser').on("click",function(){ //清空人员
            $('#userDuser').attr('user_id','');
            $('#userDuser').attr('dataid','');
            $('#userDuser').val('');
        });
        $("#selectUserSd").on("click",function(){
            user_id='userDuserSd';
            $.popWindow("../common/selectUser");
        });

        $('#clearUserSd').on("click",function(){ //清空人员
            $('#userDuserSd').attr('user_id','');
            $('#userDuserSd').attr('dataid','');
            $('#userDuserSd').val('');
        });

        $("#selectDept").on("click",function(){//选部门控件
            dept_id='userDept';
            $.popWindow("../common/selectDept");
        });
        $('#clearDept').on("click",function(){ //清空人员
            $('#userDept').attr('dept_id','');
            $('#userDept').attr('deptid','');
            $('#userDept').val('');
        });
            }


    //修改接口
    function editClassification(data){
        $.ajax({
            type:'post',
            url:'/meetingRoom/editMeetRoom',
            dataType:'json',
            data:data,
            success:function(res){
                init();
                if(res.flag){
                    $.layerMsg({content:'<fmt:message code="depatement.th.Modifysuccessfully" />！',icon:1});
                }else{
                    $.layerMsg({content:'<fmt:message code="depatement.th.modifyfailed" />！',icon:2});
                }
            }
        })
    }

    //点击会议室名称显示会议室详情
    $('.pagediv').on('click','.meetRoomDetail',function (event){
        $.ajax({
            url: '/meetingRoom/getMeetRoomBySid',
            type: 'get',
            dataType: 'json',
            data: {
                sid: $(this).attr("meetRoomId")
            },
            success: function (obj) {
                var data=obj.object;
                var meetList=data.meetingWithBLOBs;
                var str= '<div class="table"><table style="margin:auto;">' +
                    '<tr><td width="20%"><span class="span_td"><fmt:message code="meet.th.ConferenceRoomName" />：</span></td><td><span>'+data.mrName+'</span></td></tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceRoomDescription" />：</span></td><td><span>'+data.mrDesc+'</span></td></tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.MeetingRoomManager" />：</span></td><td><span>'+data.managetnames+'</span></td></tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.ApplicatioAuthority" />：</span></td><td><span>'+data.meetroomdeptName+'</span></td></tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.Application" />：</span></td><td><span>'+data.meetroompersonName+'</span></td></tr>' +
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.NumbeAccommodated" />：</span></td><td><span>'+data.mrCapacity+'</span></td></tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.EquipmentStatus" />：</span></td><td><span>'+data.mrDevice+'</span></td></tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="depatement.th.address" />：</span></td><td><span>'+data.mrPlace+'</span></td></tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.ApplicationRecord" />：</span></td>' +
                    '<td>' +
                    '<table>' +
                    '<tr>' +
                    '<td><fmt:message code="meet.th.ConferenceName" /></td>' +
                    '<td><fmt:message code="sup.th.Applicant" /></td>' +
                    '<td><fmt:message code="sup.th.startTime" /></td>' +
                    '<td><fmt:message code="meet.th.EndTime" /></td>' +
                    '<td><fmt:message code="notice.th.state" /></td>' +
                    '<tr>';
                for(var i=0;i<meetList.length;i++){
                    str+='<tr>' +
                        '<td>'+meetList[i].meetName+'</td>' +
                        '<td>'+meetList[i].userName+'</td>' +
                        '<td>'+meetList[i].startTime+'</td>' +
                        '<td>'+meetList[i].endTime+'</td>' +
                        '<td>'+meetList[i].statusName+'</td>' +
                        '</tr>'
                }
                str+='</table></td></tr>'+
                    '</table></div>';
                layer.open({
                    type: 1,
                    title: ['<fmt:message code="meet.th.SeeDetails" />', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['900', '500px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: [ '<fmt:message code="global.lang.close" />'],
                    content: str
                })
            }
        })
    })

</script>
</body>
</html>
