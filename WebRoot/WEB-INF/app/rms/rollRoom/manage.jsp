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
	<title><fmt:message code="vote.th.LibraryManagement"/></title>
	<link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
	<link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
	<link rel="stylesheet" type="text/css" href="../css/base.css"/>
<%--	<script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>--%>
	<script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
	<script src="../js/news/page.js"></script>
	<script src="../lib/laydate/laydate.js"></script>
	<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/layer/layer.js?20201106"></script>
	<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
	<style>
		a{
			text-decoration: none;
			color: #207bd6;
		}
		.head{
			height: 45px;
		}
		.newTbale{
			width: 100%;
			margin-top: 80px;
		}
		.newTbale table{
			width: 60%;
			margin: 20px auto;
		}
		.newTbale table tr td:first-of-type{
			width: 210px;
			border-right: #ccc 1px solid;
		}
		.newTbale table input{
			width: 260px;
			height: 26px;
			padding-left: 5px;
			vertical-align: middle;
		}
		.newTbale table textarea{
			width: 300px;
			height: 50px;
			vertical-align: middle;
		}
		.newBtn{
			display: block;
			float: left;
			background: url(../img/confirm.png) no-repeat !important;
			border: none;
			width: 70px;
			height: 29px;
			line-height: 29px;
			margin-left: 10px;
		}
		.resetBtn{
			display: block;
			float: left;
			background: url(../img/news/new_filling.png) no-repeat;
			border: none;
			width: 70px;
			height: 29px;
			line-height: 29px;
			margin-left: 10px;
		}
		.clickBtn{
			width: 100%;
		}
		.divBtn{
			width: 170px;
			margin: 0 auto;
			height: 30px;
			float: none;
			background: none;
		}
		.td_title2{

		}
		#tr_td .th{
			font-size: 13pt;
		}
		#j_tb tr td {
			font-size: 11pt;
		}
	</style>
</head>

<body>
	<div class="bx">
		<div class="head w clearfix">
			<ul class="index_head">
				<li data_id="0" data-num="0"><span class="one headli1_1"><fmt:message code="vote.th.LibraryManagement"/></span><img class="headli1_2" src="../img/twoth.png" alt=""/></li>
				<li data_id="1" data-num="2"><span class="headli"><fmt:message code="vote.th.NewLibrary"/></span></li>

			</ul>
		</div>
		<div class="mainCon">
			<div class="navigation  clearfix juMange" style="display: block;">
				<div class="left" style="margin-left: 30px;width: 40%;">
					<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_manageRollRoom.png" style="margin-top: 18px;">
					<div class="news">
						卷库管理
					</div>
				</div>
				<div class="wrap" style="margin-left: 0;padding: 0 20px;margin-top: 70px;">
					<table id="tr_td">
						<thead>
						<tr>
							<td class="th">
								<fmt:message code="vote.th.CoilingNumber"/>
							</td>
							<td class="th">
								<fmt:message code="vote.th.CoilingName"/>
							</td>
							<td class="th">
								<fmt:message code="workflow.th.sector"/>
							</td>

							<td class="th">
								<fmt:message code="notice.th.operation"/>
							</td>
						</tr>
						</thead>
						<tbody id="j_tb">

						</tbody>
					</table>
					<div class="right">
						<!-- 分页按钮-->
						<div class="M-box3" id="dbgz_page">
						</div>

					</div>
				</div>
			</div>
			<div class="navigation  clearfix newJu" style="display: none;">
				<div class="left" style="margin-left: 30px;width: 40%;">
					<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_NewRollRoom.png" style="margin-top: 19px;">
					<div class="news">
						<fmt:message code="vote.th.NewLibrary"/>
					</div>
				</div>
				<div class="newTbale">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><fmt:message code="vote.th.CoilingNumber"/>：</td>
							<td><input type="text" name="roomCode" id="roomCode" value=""><img class="td_title2" src="../img/mg2.png" style="margin-top: 10px;margin-left: 5px;" alt="必填"></td>
						</tr>
						<tr>
							<td><fmt:message code="vote.th.CoilingName"/>：</td>
							<td><input type="text" name="roomName" id="roomName" value=""><img class="td_title2" src="../img/mg2.png" style="margin-top: 10px;margin-left: 5px;" alt="必填"></td>
						</tr>
						<tr>
							<td><fmt:message code="workflow.th.sector"/>：</td>
							<td>
								<textarea name="textDeptOne" disabled readonly id="textDeptOne" dataid="" resize="auto"></textarea>
								<img class="td_title2" src="../img/mg2.png" alt="必填">
								<a href="javascript:;" class="checkOne" id="checkOne" style="margin: 0 10px;"><fmt:message code="notice.th.chose"/></a>
								<a href="javascript:;" class="clearOne" id="clearOne"><fmt:message code="global.lang.empty"/></a>
							</td>
						</tr>
						<tr>
							<td><fmt:message code="vote.th.Scope(Department)"/>：</td>
							<td>
								<textarea name="textDept" disabled readonly id="textDept" dataid="" resize="auto"></textarea>
								<a href="javascript:;" class="checkThr" id="checkThr" style="margin: 0 10px;"><fmt:message code="notice.th.chose"/></a>
								<a href="javascript:;" class="clearThr"><fmt:message code="global.lang.empty"/></a>
							</td>
						</tr>
						<tr>
							<td><fmt:message code="vote.th.CoilingAdministrator"/>：</td>
							<td>
								<textarea name="textUser" disabled readonly id="textUser" dataid="" resize="auto"></textarea>
								<img class="td_title2" src="../img/mg2.png" alt="必填">
								<a href="javascript:;" class="checkTwo" id="checkTwo" style="margin: 0 10px;"><fmt:message code="notice.th.chose"/></a>
								<a href="javascript:;" class="clearTwo"><fmt:message code="global.lang.empty"/></a>
							</td>
						</tr>
						<tr>
							<td><fmt:message code="journal.th.Remarks"/>：</td>
							<td><textarea name="remark" id="textBzk"></textarea></td>
						</tr>
					</table>
					<div class="clickBtn">
						<div class="divBtn">
							<a href="javascript:;" class="newBtn" id="newBtn"><span style="margin-left: 32px;"><fmt:message code="global.lang.ok"/></span></a>
							<a href="javascript:;" class="resetBtn" id="resetBtn"><span style="margin-left: 32px;"><fmt:message code="workflow.th.Reset"/></span></a>
						</div>
					</div>
				</div>
			</div>
			<%--编辑--%>
			<div class="navigation  clearfix edit" style="display: none;">
				<div class="left" style="margin-left: 30px;width: 40%;">
					<img src="/img/rms/icon_editRollRoom.png" style="margin-top: 19px;">
					<div class="news">
						<fmt:message code="vote.th.EditingLibrary"/>
					</div>
				</div>
				<div class="newTbale">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><fmt:message code="vote.th.CoilingNumber"/>：</td>
							<td><input type="text" name="roomCode" id="roomCode_s" value=""><img class="td_title2" src="../img/mg2.png" style="margin-top: 10px;margin-left: 5px;" alt="必填"></td>
						</tr>
						<tr>
							<td><fmt:message code="vote.th.CoilingName"/>：</td>
							<td><input type="text" name="roomName" id="roomName_s" value=""><img class="td_title2" src="../img/mg2.png" style="margin-top: 10px;margin-left: 5px;" alt="必填"></td>
						</tr>
						<tr>
							<td><fmt:message code="workflow.th.sector"/>：</td>
							<td>
								<textarea name="textDeptOne" disabled readonly id="textDeptOne_s" dataid="" resize="auto"></textarea>
								<img class="td_title2" src="../img/mg2.png" alt="必填">
								<a href="javascript:;" class="checkOne" id="checkOne_s" style="margin: 0 10px;"><fmt:message code="notice.th.chose"/></a>
								<a href="javascript:;" class="clearOne_s"><fmt:message code="global.lang.empty"/></a>
							</td>
						</tr>
						<tr>
							<td><fmt:message code="vote.th.Scope(Department)"/>：</td>
							<td>
								<textarea name="textDept" disabled readonly id="textDept_s" dataid="" resize="auto"></textarea>
								<a href="javascript:;" class="checkThr" id="checkThr_s" style="margin: 0 10px;"><fmt:message code="notice.th.chose"/></a>
								<a href="javascript:;" class="clearThr_s"><fmt:message code="global.lang.empty"/></a>
							</td>
						</tr>
						<tr>
							<td><fmt:message code="vote.th.CoilingAdministrator"/>：</td>
							<td>
								<textarea name="textUser" disabled readonly id="textUser_s" dataid="" resize="auto"></textarea>
								<img class="td_title2" src="../img/mg2.png" alt="必填">
								<a href="javascript:;" class="checkTwo" id="checkTwo_s" style="margin: 0 10px;"><fmt:message code="notice.th.chose"/></a>
								<a href="javascript:;" class="clearTwo_s"><fmt:message code="global.lang.empty"/></a>
							</td>
						</tr>
						<tr>
							<td><fmt:message code="journal.th.Remarks"/>：</td>
							<td><textarea name="remark" id="textBzk_s"></textarea></td>
						</tr>
					</table>
					<div class="clickBtn">
						<div class="divBtn">
							<a href="javascript:;" class="newBtn" id="newBtn_s" data-id=""><span style="margin-left: 32px;"><fmt:message code="global.lang.ok"/></span></a>
							<a href="javascript:;" class="resetBtn" id="resetBtn_s"><span style="margin-left: 32px;"><fmt:message code="notice.th.return"/></span></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function(){
            var data={
                page:1,//当前处于第几页
				pageSize:10,//一页显示几条
            }

            init(data,$('#j_tb'));

            $('.M-box3').pagination({
                pageCount:10,
                jump:true,
                coping:true,
                homePage:'首页',
                endPage:'末页',
                prevContent:'上页',
                nextContent:'下页'
            });

		    $('.index_head li').on('click',function(){
		        var ind=$(this).index();
		        $(this).find('span').addClass('one').end().siblings().find('span').removeClass('one');
		        $('.mainCon').find('.clearfix').eq(ind).show().siblings().hide();
			})

            $('#checkOne').on('click',function(){
                dept_id='textDeptOne';
                $.popWindow("../common/selectDept?0");
            });
            $('#checkThr').on('click',function(){
                dept_id='textDept';
                $.popWindow("../common/selectDept");
            });
            $('#checkTwo').on('click',function(){
                user_id='textUser';
                $.popWindow("../common/selectUser?0");
            });

            $('#checkOne_s').on('click',function(){
                dept_id='textDeptOne_s';
                $.popWindow("../common/selectDept?0");
            });
            $('#checkThr_s').on('click',function(){
                dept_id='textDept_s';
                $.popWindow("../common/selectDept");
            });
            $('#checkTwo_s').on('click',function(){
                user_id='textUser_s';
                $.popWindow("../common/selectUser?0");
            });
//            清空
			$('.clearOne').on('click',function(){
			    $('#textDeptOne').attr('deptid','');
			    $('#textDeptOne').attr('deptname','');
			    $('#textDeptOne').attr('deptno','');
			    $('#textDeptOne').val('');
			})
            $('.clearThr').on('click',function(){
                $('#textDept').attr('deptid','');
                $('#textDept').attr('deptname','');
                $('#textDept').attr('deptno','');
                $('#textDept').val('');
            })
            $('.clearTwo').on('click',function(){
                $('#textUser').attr('dataid','');
                $('#textUser').attr('username','');
                $('#textUser').attr('user_id','');
                $('#textUser').attr('userprivname','');
                $('#textUser').val('');
            })

            $('.clearOne_s').on('click',function(){
                $('#textDeptOne_s').attr('deptid','');
                $('#textDeptOne_s').attr('deptname','');
                $('#textDeptOne_s').attr('deptno','');
                $('#textDeptOne_s').val('');
            })
            $('.clearThr_s').on('click',function(){
                $('#textDept_s').attr('deptid','');
                $('#textDept_s').attr('deptname','');
                $('#textDept_s').attr('deptno','');
                $('#textDept_s').val('');
            })
            $('.clearTwo_s').on('click',function(){
                $('#textUser_s').attr('dataid','');
                $('#textUser_s').attr('username','');
                $('#textUser_s').attr('user_id','');
                $('#textUser_s').attr('userprivname','');
                $('#textUser_s').val('');
            })

            $('#newBtn').on('click',function(){
                var deptOne=0;
                var userOne='';
                if(typeof($("#textDeptOne").attr("deptid"))!="undefined"){
                    deptOne=$('#textDeptOne').attr('deptid').replace(/,/g,'');
				}
                if(typeof($("#textUser").attr("user_id"))!="undefined"){
                    userOne=$('#textUser').attr('user_id');
                }
                var roomCode=$('#roomCode').val();
                var roomName=$('#roomName').val();
                var remark=$('#textBzk').val();
                if(roomCode == ''){
                    layer.msg('<fmt:message code="vote.th.FillNumber"/>！', { icon:5,time:1000});
                    return false;
				}
                if(roomName == ''){
                    layer.msg('<fmt:message code="vote.th.FillLibrary"/>！', { icon:5,time:1000});
                    return false;
                }
                if(deptOne == ''){
                    layer.msg('<fmt:message code="vote.th.ChooseDepartment"/>！', { icon:5,time:1000});
                    return false;
                }
                if(userOne == ''){
                    layer.msg('<fmt:message code="vote.th.selectLibrarian"/>！', { icon:5,time:1000});
                    return false;
                }
                var datas={
                    roomCode:roomCode,
                    roomName:roomName,
                    deptId:deptOne,
                    viewDeptId:$('#textDept').attr('deptid'),
                    manageUser:userOne,
                    remark:remark
				}
                $.ajax({
					type:'post',
					url:'/rmsRollRoom/save',
					dataType:'json',
					data:datas,
					success:function(res){
					    if(res.flag){
                            layer.msg('<fmt:message code="depatement.th.Newsuccessfully"/>！', { icon:1,time: 1000},function () {
                                $('.juMange').show().siblings().hide();
                            });
                            init(data,$('#j_tb'));
                            location.reload();
						}else{
                            layer.msg('<fmt:message code="depatement.th.Newfailed"/>！', { icon:2});
						}
					}
				})
			})

//			编辑
			$('#j_tb').on('click','.editDiv',function(){
			    $('.edit').show().siblings().hide();
			    var dataId=$(this).parents('tr').attr('data-id');
			    $.ajax({
					type:'get',
					url:'/rmsRollRoom/selectById',
					dataType:'json',
					data:{
                        roomId:dataId
					},
					success:function(res){
					    var datas=res.object;
					    $('#roomCode_s').val(datas.roomCode);
					    $('#roomName_s').val(datas.roomName);
					    $('#textDeptOne_s').attr('deptid',datas.deptId);
                        $('#textDeptOne_s').val(datas.deptName);
                        $('#textDept_s').attr('deptid',datas.viewDeptId);
                        $('#textDept_s').val(datas.viewDeptName);
                        $('#textUser_s').attr('user_id',datas.manageUser);
                        $('#textUser_s').val(datas.manageUserName);
                        $('#textBzk_s').val(datas.remark);
                        $('#newBtn_s').attr('data-id',datas.roomId);
					}
				})
			})

//			编辑保存
			$('#newBtn_s').on('click',function(){
			    var dataId=$(this).attr('data-id');
                var deptOne=0;
                var userOne='';
                if(typeof($("#textDeptOne_s").attr("deptid"))!="undefined"){
                    deptOne=$('#textDeptOne_s').attr('deptid').replace(/,/g,'');
                }
                if(typeof($("#textUser_s").attr("user_id"))!="undefined"){
                    userOne=$('#textUser_s').attr('user_id');
                }
                var roomCode=$('#roomCode_s').val();
                var roomName=$('#roomName_s').val();
                var remark=$('#textBzk_s').val();
                if(roomCode == ''){
                    layer.msg('<fmt:message code="vote.th.FillNumber"/>！', { icon:5,time:1000});
                    return false;
                }
                if(roomName == ''){
                    layer.msg('<fmt:message code="vote.th.FillLibrary"/>！', { icon:5,time:1000});
                    return false;
                }
                if(deptOne == ''){
                    layer.msg('<fmt:message code="vote.th.ChooseDepartment"/>！', { icon:5,time:1000});
                    return false;
                }
                if(userOne == ''){
                    layer.msg('<fmt:message code="vote.th.selectLibrarian"/>！', { icon:5,time:1000});
                    return false;
                }
                var datas={
                    roomId:dataId,
                    roomCode:roomCode,
                    roomName:roomName,
                    deptId:deptOne,
                    viewDeptId:$('#textDept_s').attr('deptid'),
                    manageUser:userOne,
                    remark:remark
                }
                $.ajax({
                    type:'post',
                    url:'/rmsRollRoom/update',
                    dataType:'json',
                    data:datas,
                    success:function(res){
                        if(res.flag){
                            layer.msg('<fmt:message code="depatement.th.Modifysuccessfully"/>！', { icon:1,time:1000},function () {
                                $('.juMange').show().siblings().hide();
                            });
                            init(data,$('#j_tb'))
                        }else{
                            layer.msg('<fmt:message code="depatement.th.Newfailed"/>！', { icon:2});
                        }
                    }
                })
			})
//          返回
            $('#resetBtn_s').on('click',function(){
                $('.juMange').show().siblings().hide();
            })
//          重置
            $('#resetBtn').on('click',function(){
                $('#roomCode').val('');
                $('#roomName').val('');

                $('#textDeptOne').attr('deptid','');
                $('#textDeptOne').attr('deptname','');
                $('#textDeptOne').attr('deptno','');
                $('#textDeptOne').val('');

                $('#textDept').attr('deptid','');
                $('#textDept').attr('deptname','');
                $('#textDept').attr('deptno','');
                $('#textDept').val('');

                $('#textUser').attr('dataid','');
                $('#textUser').attr('username','');
                $('#textUser').attr('user_id','');
                $('#textUser').attr('userprivname','');
                $('#textUser').val('');

                $('#textBzk').val('');
            })
//			删除
            $('#j_tb').on('click','.deleteData',function(){
                var dataId=$(this).parents('tr').attr('data-id');
                layer.confirm('<fmt:message code="event.th.DeleteData"/>？', {
                    btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'], //按钮
                    title:"<fmt:message code="workflow.th.suredel"/>"
                }, function(){
                    //确定删除，调接口
                    $.ajax({
                        type:'post',
                        url:'/rmsRollRoom/delete',
                        dataType:'json',
                        data:{'roomId':dataId},
                        success:function(res){
                            if(res.flag){
                                layer.msg('<fmt:message code="workflow.th.delsucess"/>', { icon:6,time:1000});
                                $('.juMange').show().siblings().hide();
                                init(data,$('#j_tb'))
                            }else{
                                layer.msg('<fmt:message code="lang.th.deleSucess"/>', { icon:6});
                            }
                        }
                     });

                }, function(){
                    layer.closeAll();
                });
			})
		})


        function init(datas,element) {
            var ajaxPage={
                data:datas,

                page:function () {
                    element.find('tr').remove();
                    var me=this;
                    $.ajax({
                        type:'get',
                        url:'/rmsRollRoom/query',
                        dataType:'json',
                        data:me.data,
                        success:function(res) {
                            var datas=res.obj;
                            var str='';
                            for(var i=0;i<datas.length;i++){
                                str+='<tr data-id="'+datas[i].roomId+'">' +
									'<td>'+datas[i].roomCode+'</td>' +
									'<td>'+datas[i].roomName+'</td>' +
									'<td>'+(datas[i].deptName || '')+'</td>' +
									'<td><a href="javascript:;" class="editDiv" style="margin-right: 10px;"><fmt:message code="global.lang.edit"/></a><a href="javascript:;" class="deleteData">删除</a></td>' +
									'</tr>'
							}

                            element.append(str);
                            me.pageTwo(res.totleNum,me.data.pageSize,me.data.page)
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
            }
            ajaxPage.page();
        }

	</script>
</body>
</html>
