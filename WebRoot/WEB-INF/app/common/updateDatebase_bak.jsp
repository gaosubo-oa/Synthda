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
	<title><fmt:message code="common.th.selPeople" /></title><%--选择人员--%>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
	<script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
	<%--<script src="/js/jqmeter.min.js" type="text/javascript"></script>--%>
	<style type="text/css">
		body,div,a,span,p,input,table,tr,td,th,thead,tbody,select{
			margin: 0;
			padding: 0;
		}
		body{
			font-family: 微软雅黑;
			width: 100%;
			overflow: hidden;
		}
		.content{
			width: 100%;
		}
		.main{
			width: 500px;
			height: 300px;
			margin: 150px auto;
			border:1px solid #eee;
			padding: 10px;
			position: relative;
		}
		.divTitle{
			width: 100%;
			height: 40px;
			line-height: 40px;
			text-align: center;
			font-size: 18px;
			font-weight: bold;

		}
		.main p{
			font-size: 16px;
			color: #555;
			line-height: 30px;

		}
		.divBtn{
			width: 70px;
			height: 28px;
			background-color: rgb(47,128,209);
			border-radius:5px;
			font-size: 14px;
			line-height: 28px;
			text-align: center;
			color: #fff;
			cursor: pointer;
			position: absolute;
			right:10px;
			bottom:10px;
		}
		.ok{
			width:200px;
			height:60px;
			margin:0 auto;
			text-align:center;
			line-height:60px;
			color:#000;
			/*display:none;*/
		}
		.tbox{
			width:500px;
			height:20px;
			background:url(/img/common/bak.png) no-repeat;
			margin-top:20px;
			background-size: 100% 100%;
		}
		.tbox div{
			width:0px;
			height:20px;
			background:url(/img/common/pro.png) no-repeat;
			text-align:center;
			font-family: 微软雅黑;
			font-size:14px;
			line-height:20px;
			background-size: 100% 100%;
		}
	</style>
	<script type="text/javascript">
		var i=0;
		/*add——创建tbx下的div加文字和变宽度的方法*/
        function add(i){
            var tbox =$(".tbox");
            var tiao =$(".tiao");
            tiao.css("width",i+"%").html(i+"%");
        }
		/*创建方法（i++循环起来）*/
        function xh(){
            if(i>100){
                $(".ok").html("加载完成").fadeIn("slow");
                layer.msg('恭喜您，升级成功！', { icon:6,time:1000});
                return;
            }
            if(i<=100){
                setTimeout("xh()",100)
                add(i);
                i++;
            }
        }
        function ajaxData() {
            $.ajax({
                type:'post',
                url:'/code/updateDabase',
                dataType:'json',
                success:function(res){
                    if(res.flag){
//                        layer.msg('恭喜您，升级成功！', { icon:6,time:1000});
                    }else{
                        layer.msg('升级失败！', { icon:5,time:1000});
                    }
                }
            })
        }
		$(function () {
		    $('#divBtn').click(function(){
                layer.confirm('是否完成准备工作？', {
                    btn: ['确定','取消'], //按钮
                    title:"第一步"
                }, function(){
                    layer.confirm('是否运行SQL脚本？', {
                        btn: ['确定','取消'], //按钮
                        title:"第二步"
                    }, function(index){
                        layer.open({
                            type: 1,
                            title:'脚本执行中',
                            area: ['600px', '260px'],
                            shadeClose: true, //点击遮罩关闭
                            btn: ['下一步'],
							content:'<div style="width: 502px;margin: 20px auto;">' +
										'<div class="tbox">'+
											'<div class="tiao"></div>'+
										'</div>'+
                            			'<div class="ok">正在加载，请勿关闭！</div>'+
									'</div>',
							success:function(){
                                xh();
                                ajaxData()
                            },
							yes:function(index){
							    layer.close(index);
                                layer.confirm('附件迁移复制附件目录MYOA/attach  到xoa/attach/xoa1001即可。', {
                                    btn: ['确定'], //按钮
                                    title:"第三步"
                                },function(){
                                    layer.closeAll();
								})
							}
						})
                    }, function(index1){
                        layer.close(index1);
                    });
                }, function(index){
                    layer.close(index);
                });
			})
        })
	</script>
</head>
<body>
	<div class="content">
		<div class="main">
			<div class="divTitle">OA升级心通达</div>
			<p>1.用Navicat Premium 导出通达sql文件。</p>
			<p>2.用NotePad++(或者其他编辑文件工具)打开文件将其中的 CHARSET=gbk 全部改为 CHARSET=utf8 并保存。</p>
			<p>3.打开Navicat Premium  连接localhost  端口号3308 在xoa1001库导入保存好的文件。</p>
			<%--<p>1.用 Navicat 链接OA数据库，导出OA系统的数据库文件TD_OA.sql（结构和数据）。</p>--%>
			<%--<p>2.用 NotePad++ 等高级编辑器，打开TD_OA.sql文件，批量将 CHARSET=gbk 全部改为 CHARSET=utf8 。</p>--%>
			<%--<p>3.打开Navicat 链接心通达OA数据库（host:localhost,port:3308,password:gaosubo3000），创建库TD_OA，导入2处理后的文件TD_OA.sql到创建的TD_OA库中。</p>--%>
			<div class="divBtn" id="divBtn">下一步</div>
		</div>
	</div>
</body>
</html>
