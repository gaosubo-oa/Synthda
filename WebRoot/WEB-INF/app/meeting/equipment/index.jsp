<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/27
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
	<title><fmt:message code="meet.th.Conference" /></title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<link rel="stylesheet" href="/css/meeting/equipment.css">
	<link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
	<link rel="stylesheet" href="/lib/laydate/need/laydate.css">
	<link rel="stylesheet" href="/lib/pagination/style/pagination.css">
	<%--<link rel="stylesheet" href="/css/base.css">--%>
	<script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
	<script src="/lib/layer/layer.js?20201106"></script>
	<script src="/js/base/base.js"></script>
	<script src="/lib/laydate/laydate.js"></script>
	<script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<style>
	*{
		font-family: 微软雅黑;
		font-size: 13pt;
	}
	td{
		font-size: 11pt;
	}
	table tr td a{
		font-size: 11pt;
	}
	table tr td input[type="checkbox"], table tr th input[type="checkbox"]{
		margin:0;
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
<body style="font-family: 微软雅黑;">
<div class="headTop">
	<div class="headImg">
		<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_equipment.png" alt="">
	</div>
	<div class="divTitle">
		<fmt:message code="meet.th.Conference" />
	</div>
	<div class="batchDelete" id="batchDelete" style="background:url(../../img/meeting/btn_deleteAll.jpg) no-repeat!important; border-radius: 20px;margin-right: 1.5%;">
		<span style="margin-left: 32px;"><fmt:message code="meet.th.BatchDelete" /></span>
	</div>
	<div class="newClass" id="newClass" style="border-radius: 20px;padding: 0 5px;margin-right: 1.5%">
		<span style="margin-left: 26px;"><img style="margin-right: 4px;margin-left: -16px;margin-bottom: -1px;" src="../../img/mywork/newbuildworjk.png" alt=""><fmt:message code="meet.th.AddDevice" /></span>
	</div>
</div>
<div class="main">
	<div class="pagediv" id="already" style="margin: 0 auto;width: 97%;margin-top: 50px;">
		<table>
			<thead>
			<tr>
				<th style="padding-left: 20px;"><input type="checkbox" name="checkedAll" id="checkedAll"></th>
				<th width="75%"><fmt:message code="meet.th.DeviceName" /></th>
				<th style="padding-left: 20px;" width="15%"><fmt:message code="notice.th.operation" /></th>
			</tr>
			</thead>
			<tbody>
		<%--	<tr>
				<td><input type="checkbox" name="checkedChild"></td>
				<td>暖壶</td>
				<td><a href="javascript:;">编辑</a></td>
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


        //全选点击事件
        $('#checkedAll').on("click",function(){
            var state =$(this).prop("checked");
            if(state==true){
                $(this).prop("checked",true);
                $(".checkChild").prop("checked",true);
                $(".contentTr").addClass('bgcolor');
            }else{
                $(this).prop("checked",false);
                $(".checkChild").prop("checked",false);;
                $('.contentTr').removeClass('bgcolor');
            }
        })

        //点击新建分类
        $('#newClass').on("click",function(event) {
            event.stopPropagation();
            layer.open({
                type: 1,
                title: ['<fmt:message code="meet.th.NewDevice" />', 'background-color:#2b7fe0;color:#fff;'],
                area: ['300px', '220px'],
                shadeClose: true, //点击遮罩关闭
                btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
                content: '<div class="div_table" style="height: 100px;width: 250px; margin-top: 10px; margin-left: 10px;">'+
                '<div class="div_tr">' +
					'<span class="span_td"><fmt:message code="meet.th.DeviceName" />：</span>'+
					'<span><input type="text" style="width: 130px;float: none;" name="equipmentName" class="inputTd" value="" /></span></div>' +
                '</div>',
                yes: function (index) {
                    var data = {
                        equipmentName: $('input[name="equipmentName"]').val()
                    }
                    if(data==""){
                        $.layerMsg({content:'内容不能为空',icon:3});
					}else{
                        newClassification(data);
                        layer.close(index);
					}
                },
            });
        });

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

    //新建分类接口
    function newClassification(data){
        $.ajax({
            type:'post',
            url:'/Meetequipment/addEquiets',
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

    //修改接口接口
    function editClassification(data){
        $.ajax({
            type:'post',
            url:'/Meetequipment/updateEquiet',
            dataType:'json',
            data:data,
            success:function(res){
                init();
                if(res.flag){
                    $.layerMsg({content:'<fmt:message code="menuSSetting.th.editSuccess" />！',icon:1});
                }else{
                    $.layerMsg({content:'<fmt:message code="depatement.th.modifyfailed" />！',icon:2});
                }
            }
        })
    }

    function init() {
        $('.pagediv tbody tr').remove();


        //        列表带分页
        var ajaxPageLe={
            data:{
                page:1,//当前处于第几页
                pageSize:10,//一页显示几条
                useFlag:true
                // computationNumber:null
            },
            page:function () {
                var me=this;

                $.ajax({
                    type:'get',
                    url:'/Meetequipment/getAllEquiet',
                    dataType:'json',
                    data:me.data,
                    success:function(res) {
                        var data=res.obj;
                        var str='';
                        if(data.length>0){
                            for(var i=0;i<data.length;i++) {
                                str+='<tr class="contentTr" sId="'+data[i].sid+'"><td  style="padding-left: 20px;"><input type="checkbox" name="checkedChild" class="checkChild" sId="'+data[i].sid+'"></td><input type="hidden" id="'+data[i].sid+'"><td>'+data[i].equipmentName+'</td><td style="padding-left: 20px;"><a href="javascript:edit('+data[i].sid+');"><fmt:message code="global.lang.edit" /></a>&nbsp;<a href="javascript:deleteone('+data[i].sid+');"><fmt:message code="global.lang.delete" /></a></td>';
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

    function edit(e){
      var equipmentName="";
        $.ajax({
            type:'get',
            url:'/Meetequipment/getdetailEquiet',
			data:{Sid:e},
            dataType:'json',
            success:function(res) {
                equipmentName=res.object.equipmentName;
                layer.open({
                    type: 1,
                    title: ['<fmt:message code="meet.th.ModifDevice" />', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['300px', '220px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
                    content: '<div class="div_table" style="height: 100px;width: 250px; margin-top: 10px; margin-left: 10px;">'+
                    '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.DeviceName" />：</span><span><input type="text" style="width: 130px;float: none;" name="equipmentName" id="next" class="inputTd" value="" /></span></div>' +
                    '</div>',
                    yes: function (index) {
                        var data = {
                            sid: e,
                            equipmentName: $('input[name="equipmentName"]').val()
                        }
                        editClassification(data);
                        layer.close(index);
                    },
					success:function(){
                        $('#next').val(equipmentName);
					}
                });
			}
        });
	}
	//单个删除新闻
function deleteone(e){
    layer.confirm('<fmt:message code="sup.th.Delete" />？', {
        btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
        title:"<fmt:message code="notice.th.DeleteAttachment" />"
    }, function(){
        //确定删除，调接口
        $.ajax({
            type:'post',
            url:'/Meetequipment/deleteEquiets',
            dataType:'json',
            data:{'Sids':e},
            success:function(){
                layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});
                init();
            }
        })
    }, function(){
        layer.closeAll();
    });
	}
    $('#batchDelete').on("click",function(){
        var Sids='';
        $("#already .checkChild:checkbox:checked").each(function(){
            var conId=$(this).attr("sId");
            Sids+=conId+",";
        })
        if(Sids == ''){
            layer.msg('<fmt:message code="meet.th.PleaseDelete" />', { icon:2});
        }else {
            layer.confirm('<fmt:message code="sup.th.Delete" />？', {
                btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
                title:"<fmt:message code="notice.th.DeleteAttachment" />"
            }, function() {
                $.ajax({
                    type: 'post',
                    url: '/Meetequipment/deleteEquiets',
                    dataType: 'json',
                    data: {'Sids': Sids},
                    success: function () {
                        layer.msg('<fmt:message code="workflow.th.delsucess" />', {icon: 6});
                        init();
                    }
                })
            }, function(){
                layer.closeAll();
            });
        }
	})

</script>
</body>
</html>
