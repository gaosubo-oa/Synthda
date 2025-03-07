<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
	<head>
		<title><fmt:message code="new.th.newsReviewSettings" /></title>
		<meta charset="utf-8"/>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<link rel="stylesheet" type="text/css" href="../css/base.css"/>
		<link rel="stylesheet" type="text/css" href="../lib/laydate/skins/default/laydate.css"/>
		<link rel="stylesheet" type="text/css" href="../css/dept/deptManagement.css"/>
		<link rel="stylesheet" type="text/css" href="../lib/easyui/themes/easyui.css"/>
		<link rel="stylesheet" type="text/css" hcont_rigref="../lib/easyui/themes/icon.css"/>
		<link rel="stylesheet" type="text/css" href="../css/news/center.css"/>
		
<%--		<script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>--%>
		<script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--		<script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
		<script type="text/javascript" src="../../js/base/base.js"></script>
		<script src="/lib/layer/layer.js?20201106"></script>
		<script src="../../lib/laydate/laydate.js"></script>
		
		<script>
            //添加人员
            function selPriv(id) {
                user_id = id;
                $.popWindow("../../common/selectUser");
            }

            function clearPriv(id) {
                $("#" + id).val("");
                $("#" + id).attr('user_id', '');
                $("#" + id).attr('dataid', '');
            }
		</script>
		<style>
			body {
				margin: 0;
				padding: 0;
				background-color: #f6f7f9;
			}
			
			table {
				border-collapse: collapse;
				border: 1px solid #dedede;
				width: 1100px;
				background-color: #ffffff;
				margin-left: 45px;
				margin-top: 35px;
				
			}
			
			td {
				border: 1px solid #dedede;
				font-size: 11pt;
			}
			
			textarea {
				height: 56px;
				width: 300px;
				background: #e0e0e0;
				margin: 2px 0 0 2px;
			}
			
			.btn {
				width: 70px;
				height: 24px;
				margin: 0 auto;
				padding: 2px 0 2px 0;
				background: url("/img/confirm.png") no-repeat;
			}
			
			input {
				position: relative;
				top: -1px;
			}
			
			button {
				background: transparent;
				margin-left: 33px;
				line-height: 26px;
				font-size: 11pt;
			}
			
			.add {
				color: #207bd6;
			}
			
			.empty {
				color: #9aa9b8;
			}
			
			.head {
				height: 45px;
				border-bottom: 1px solid #9E9E9E;
			}
			
			h1 {
				line-height: 45px;
				font-size: 22px;
			}
			
			input[type="checkbox"], input[type="radio"] {
				background: transparent;
				border: 0;
			}
			.search_inline {
				width: 310px;
				height: 32px;
				display: inline-block;
				position: relative;
			}
			.search_inline .search_inline_item {
				width: 100%;
				box-sizing: border-box;
				height: 32px;
			}
			.list {
				width: 40px;
				height: 32px;
				background: #f3f3f3;
				border: 1px solid #ccc;
				vertical-align: middle;
				position: absolute;
				right: 0px;
				top: 0px;
				border-radius: 0px 3px 3px 0px;
			}
			.sel {
				width: 100%;
				max-height: 250px;
				position: absolute;
				top: 100%;
				left: 0;
				overflow: auto;
				background: #fff;
				border: 1px solid #e2e3e3;
				display: none;
				z-index: 1;
			}
			.canchoose:hover{
				background: #2b7edf;
				color: #fff;
			}
		</style>
	</head>
	<body>
		<div class="head">
			<h1>
				<img style="margin-left: 30px;"
				     src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_noticeMang.png" alt="">
				<fmt:message code="new.th.newsReviewSettings" />
			</h1>
		</div>
		<table>
			<tr>
				<td width="400px"><fmt:message code="new.th.whetherToEnableNewsReview" /></td>
				<td class="checkboxs">
					<input type="radio" name="check" value="1"/><fmt:message code="system_setting.yes" />
					<input type="radio" name="check" value="0" checked><fmt:message code="system_setting.no" />
				</td>
			</tr>
			<tr id="newsApprovalType" style="display: none;">
				<td>新闻审批方式</td>
				<td>
					<select name="newsApprovalType">
						<option value="0">普通审批</option>
						<option value="1">流程审批</option>
					</select>
				</td>
			</tr>
			<tr id="newsFlow" style="display: none;">
				<td>设置新闻类型对应的流程</td>
				<td>
					<ul id="newsFlowBox">
						<li class="set_news_flow">
                            <a href="javascript:;" id="setNewsFlow" style="color: #000; font-size: 14px;">新增</a>
						</li>
					</ul>
				</td>
			</tr>
			<tr>
				<td><fmt:message code="new.th.designatedPersonnelWhoCanReviewNews" /></td>
				<td>
					<textarea cols="45" name="bookPriv" rows="3" id="bookPriv" class="bookPriv globalPriv" wrap="yes"
					          readonly=""></textarea>
					<a href="javascript:;" class="addBookPriv" onclick="selPriv('bookPriv')"><fmt:message
							code="global.lang.add"/></a>
					<a href="javascript:;" class="clearBookPriv" onclick="clearPriv('bookPriv')"><fmt:message
							code="global.lang.empty"/></a>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="btn submitCheck">
						<button><fmt:message code="main.th.confirm"/></button>
					</div>
				</td>
			</tr>
		</table>
		
		<script>
            //是否审核回显
            $.ajax({
                type: 'get',
                url: '/news/openNews',
                dataType: 'json',
                success: function (res) {
                    //单选框回显
                    $("input[name='check']").each(function () {
                        var str = $(this).val();
                        if (str == res.code) {
                            $(this).attr("checked", true);
                        }
                    });
                    
                    if ( res.code == 1) {
                        $('#newsApprovalType').show();
                        // 获取新闻审核方式
                        $.get('/syspara/selectTheSysPara?paraName=NEWS_APPROVAL_TYPE', function (res) {
                            if (res.flag) {
                                var data = res.object[0];
                                var paraValue = JSON.parse(data.paraValue);
                
                                $('[name="newsApprovalType"]').val(paraValue.checkType);
                
                                if (paraValue.checkType == 1) {
                                    if (paraValue.newsFlow) {
                                        for (var key in paraValue.newsFlow) {
                                            $('.set_news_flow').before(initNewsFlowLi(key, paraValue.newsFlow[key]));
                                        }
                                    }
                                    $('#newsFlow').show();
                                } else {
                                    $('#newsFlow').hide();
                                }
                            }
                        });
                    }
                }
            });
            //人员回显
            $.ajax({
                type: 'get',
                url: '/news/selectNewsAuditers',
                dataType: 'json',
                success: function (res) {
                    var data = res.obj1
                    var username = ''
                    var user_id = ''
					if(data && data.length>0){
						for (var i = 0; i < data.length; i++) {
							username += data[i].userName + ','
							user_id += data[i].userId + ','
						}
						$('#bookPriv').html(username)
						$('#bookPriv').attr('username', username)
						$('#bookPriv').attr('user_id', user_id)
					}
                }
            });
            
            var newsTypeObj = null;
            // 获取新闻类型
            $.ajax({
                url: '/code/GetDropDownBox?CodeNos=NEWS',
                type: 'GET',
                dataType: 'json',
                async: false,
                success: function(res){
                    newsTypeObj = res.NEWS;
                }
            });
            
            // 切换是否开启审核
            $('.checkboxs input[name="check"]').on('click', function () {
                var val = $(this).val();
                if (val == 1) {
                    $('#newsApprovalType').show(0, function () {
                        var val = $('select[name="newsApprovalType"]').val();
                        if (val == 1) {
                            $('#newsFlow').show();
                        } else {
                            $('#newsFlow').hide();
                        }
                    });
                } else {
                    $('#newsApprovalType').hide();
                    $('#newsFlow').hide();
                }
            });

            //提交
            $('.submitCheck').on('click',function () {
            	var selectLC=$('.news_flow_id')
            	var selectTY=$('.news_flow_type')
				var arr=[]
				if($('#newsFlow').css('display')!='none'){
					for(var i=0;i<selectLC.length;i++){
						if(!selectLC.eq(i).attr('datatype')){
							layer.msg('请选择对应的流程！', {icon: 0});
							return false
						}
					}
					for(var i=0;i<selectTY.length;i++){
						arr.push(selectTY.eq(i).val())
					}
					var s = arr.join(",")+",";
					for(var i=0;i<arr.length;i++) {
						if(s.replace(arr[i]+",","").indexOf(arr[i]+",")>-1) {
							layer.msg('请删除重复的新闻类型！', {icon: 0});
							return false
						}

					}
					// console.log(arr)
				}
				if($('input[name="check"]:checked').val()==1 && !$('#bookPriv').attr('user_id')){
					layer.msg('请选择对应的审批人！', {icon: 0});
					return false
				}
                var userId = $('#bookPriv').attr('user_id')
                if (userId == undefined) {
                    userId = ''
                }
                var YN = $('input[name="check"]:checked').val();
    
                var data = {
                    paraName: 'NEWS_APPROVAL_TYPE',
                    paraValue: null
                }
    
                var paraValue = {
                    checkType: $('[name="newsApprovalType"]').val()
                }
    
                if (YN == 1) {
                    paraValue.checkType = $('[name="newsApprovalType"]').val();
                    if (paraValue.checkType == 1) {
                        var $newsFlow = $('.news_flow_li');
                        if ($newsFlow.length > 0) {
                            paraValue.newsFlow = {};
                            $newsFlow.each(function () {
                                var newsType = $(this).find('.news_flow_type').val();
                                var flowId = $(this).find('.news_flow_id').attr('datatype');
                                paraValue.newsFlow[newsType] = flowId;
                            });
                        }
                    }
                } else {
                    paraValue.checkType = 0;
                }
                data.paraValue = JSON.stringify(paraValue);
                $.post('/syspara/updateSysParaByParaName', data, function (res) {
                    
                });

                $.ajax({
                    type: 'get',
                    url: '/news/upNewsAuditers',
                    dataType: 'json',
                    data: {
                        userId: userId,
                        YN: YN
                    },
                    success: function (res) {
                        $.layerMsg({content: '保存成功！', icon: 1});
                    }
                });
            });

            // 切换审核类型
            $('select[name="newsApprovalType"]').on('change', function(){
                var val = $(this).val();
                if (val == 1) {
                    $('#newsFlow').show();
                } else {
                    $('#newsFlow').hide();
                }
            });
            
            // 新增新闻对应流程
            $('#setNewsFlow').on('click',function () {
                var $parent = $(this).parent();

                $parent.before(initNewsFlowLi());
            });

            // 删除新闻对应流程
            $(document).on('click', '.remove_news_flow', function () {
                var $parentLi = $(this).parents('li');
                $parentLi.remove();
            });

            // 创建新闻对应流程的li的方法
            function initNewsFlowLi(newsType, flowId) {
            	console.log(newsType,"key"+flowId+"value");
                var newsTypeStr = '';
    
                newsTypeObj.forEach(function (type) {
                    newsTypeStr += '<option value="' + type.codeNo + '">' + type.codeName + '</option>';
                });
    
                var str = '<li class="news_flow_li" style="padding: 2px 0;">\n' +
                        '                            <div style="display: inline-block;">\n' +
                        '                                <select class="news_flow_type">\n' + newsTypeStr + '</select>\n' +
                        '                            </div>\n' +
                        /*'                            <div style="display: inline-block;">\n' +
                        '                                <input type="text" class="news_flow_id" value="'+(flowId || '')+'" placeholder="请输入流程id" style="width: auto;height: 28px;box-sizing: border-box;top: 0;">\n' +
                        '                            </div>\n' +*/
						'  <div class="search_inline">\n' +
						'                        <input type="text" class="search_inline_item news_flow_id" dataType="'+(flowId || '')+'" autocomplete="off" name="flowName" placeholder="全部流程">\n' +
						'                        <button class="list" isClick="true"><img src="/img/workflow/work/xiala.png" alt=""></button>\n' +
						'                        <ul class="sel"></ul>\n' +
						'                    </div>'+
                        '                            <div style="display: inline-block;">\n' +
                        '                                <a href="javascript:;" class="remove_news_flow" style="font-size: 14px;color: red;">删除</a>\n' +
                        '                            </div>\n' +
                        '                        </li>';
                
                var $str = $(str);
                
                if (newsType) {
                    $str.find('.news_flow_type').val(newsType);
                }

				// 获取全部流程
				$.ajax({
					url:"/flow/selOneToAllType",
					type:'post',
					dataType:'json',
					success:function(res){
						var data=res.datas;
						var str='<option value=""><fmt:message code="hr.th.PleaseSelect"/></option>';
						if(res.flag){
							var flowId = $.GetRequest().flowId;
							$.each(data,function(i,item){
								$('.sel').append("<li class='ones' style='font-weight:bold;font-size:14px;' id="+item.sortId +"><img src='../../img/data_points.png' style='margin-right: 5px;' alt=''>" + item.sortName + "<li>");
								$.each(item.flowTypeModels,function(j,v){
									$('.sel').append("<li style='padding-left:10px;cursor:pointer' class='canchoose' value="+v.flowId +">" +v.flowName + "<li>");
									if(flowId&&flowId==v.flowId){
										$('[name="flowName"]').val(v.flowName);
										$('[name="flowName"]').attr('dataType',v.flowId);
										$('[name="flowName"]').attr('readonly','true');
										$('.list').hide();
										return;
									}
								})
								buildNode(1,item.childs);
							});
							$('.search_inline').each(function (index,element) {
								$(element).find('.canchoose').each(function (i,n) {
									// $('.search_inline .canchoose').each(function (i,n) {
									// 	if($(this).attr('value')==$('.search_inline .news_flow_id').eq(index).attr('datatype')){
									if($(n).attr('value')==$(element).find('.news_flow_id').attr('datatype')){
										$(n).trigger('click');
										return false;
									}
								});
							})
						}
					}
				});
                
                return $str;
                
            }

			function buildNode(len,data){
				var prefix = 10;
				for(var i=0;i<len;i++){
					prefix += 10;
				}

				$.each(data,function(i,item){
					if(0 < item.childs.length){
						$('.sel').append("<li style='padding-left:"+(prefix)+"px;font-weight:bold;font-size:14px;' id="+item.sortId +">" + item.sortName + "<li>");
						$.each(item.flowTypeModels,function(j,v){
							$('.sel').append("<li style='padding-left:"+(prefix+10)+"px;cursor:pointer' class='canchoose' value="+v.flowId +">" +  v.flowName + "<li>");
						})
						buildNode(len+1,item.childs);
					}else{
						$('.sel').append("<li style='padding-left:"+(prefix)+"px;font-weight:bold;font-size:14px;' id="+item.sortId +">" + item.sortName + "<li>");
						$.each(item.flowTypeModels,function(j,v){
							$('.sel').append("<li style='padding-left:"+(prefix+10)+"px;cursor:pointer' class='canchoose' value="+v.flowId +">" +  v.flowName + "<li>");
						})
					}
				});
			}

			$(document).on('click','.list',function (e) {
				e.stopPropagation()
				$('.list').removeAttr('isClick')
				$(this).attr('isClick','true')
				if($(this).attr('isClick')){
					if($(this).next().css('display')!='none'){
						$(this).next().hide()
					}else{
						$(this).next().show()
					}
				}
			})

			$(document).on('click','.sel li',function(e){
				e.stopPropagation()
				if($(this).parent().prev().attr('isClick')){
					if($(this).attr('value')){
						$(this).parent().siblings('[name="flowName"]').val($(this).html())
						$(this).parent().siblings('[name="flowName"]').attr('dataType',$(this).attr('value'))
						/*$('[name="flowName"]').val($(this).html())
						$('[name="flowName"]').attr('dataType',$(this).attr('value'))*/
						$('.sel').hide()
					}else{
						$('.sel').show()
					}
				}
			})

			$(document).on('click',function(){
				$('.sel').hide()
			})
		
		</script>
	</body>
</html>

