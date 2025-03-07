<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!doctype html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>个人文件柜</title>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<link href="/lib/mui/mui/mui.css" rel="stylesheet" />
		<link rel="stylesheet" href="../css/file/m/detailed.css" />
		<script src="/lib/mui/mui/mui.min.js"></script>
		<script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
			mui.init();
		</script>
	</head>

	<body>
		<header class="mui-bar mui-bar-nav" id="header">
	    	<a class="mui-action-back mui-icon mui-icon-arrowleft mui-pull-left" style="color:#333;"></a>
	    	<h1 class="mui-title" id="title1">个人文件柜</h1>
			<a href="#picture" class="mui-icon mui-icon-plusempty mui-pull-right" style="color:#333;"></a>
		</header>
		<div class="main">
			<div id="item1" class="mui-control-content mui-active">
				<div id="scroll">
					<div class="mui-scroll" id="show_ul">
						<ul class='mui-table-view' id='show_li'>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!--新建目录-->
		<div id="modal1" class="mui-modal">
			<header class="mui-bar mui-bar-nav">
				<a class="mui-icon mui-icon-close mui-pull-left" href="#modal1" style="color:#333;"></a>
				<h1 class="mui-title">新建目录</h1>
				<a class="mui-btn-link mui-pull-right" onclick="save()" style="color:#333;">保存</a>
			</header>
			<div class="mui-content" style="height: 100%;">
				<div class="mui-input-group">
					<div class="mui-input-row">
						<label>文件夹名：</label>
						<input type="text" id="file_name" placeholder="请输入文件夹名">
					</div>
					<div class="mui-input-row">
						<label>排序号：</label>
						<input type="text" id="num" class="mui-input-clear" placeholder="请输入序号">
					</div>
				</div>
			</div>
		</div>

		<!--新建文件-->
			<div id="modal2" class="mui-modal">
			<header class="mui-bar mui-bar-nav">
				<a class="mui-icon mui-icon-close mui-pull-left" href="#modal2"></a>
				<h1 class="mui-title">新建文件</h1>
				<a class="mui-btn mui-btn-blue mui-btn-link mui-pull-right" id="save" onclick="save_file()">保存</a>
			</header>
			<div class="mui-content" style="height: 100%;">
				<form action="http://app.oaoa.pro/app/knowledge_center/a/add.php" method="post" enctype="multipart/form-data" id="form1">
					<input type="hidden" name="flag" value="2"/>
					<div class="mui-input-row">
						<label>文件名：</label>
						<input name="mtitle" type="text" id="file_name2" placeholder="请输入文件名">
					</div>

					<div class="mui-input-row">
						<label>序列号：</label>
						<input name="cno" type="text" id="num2" class="mui-input-clear" placeholder="请输入序列号">
					</div>

					<div class="mui-input-row">
						<label>说明：</label>
						<input name="file_desc" type="text" id="text_file" class="mui-input-clear" placeholder="请输入说明">
					</div>

					<div class="mui-input-row">
						<label>文件内容：</label>
						<textarea name="message" id="textarea" rows="5" placeholder="文件内容"></textarea>
					</div>
					<br/>
					<div class="mui-input-row">
						<label>附件：</label>
						<button type="button" onclick="appendByGallery()" id="add_button">添加附件</button>
						<%--<form id="uploadimgform" target="uploadiframe" action="../upload?module=file_folder" enctype="multipart/form-data" method="post">--%>
							<%--<input type="file" name="file" id="uploadinputimg" class="w-icon5">--%>
							<%--&lt;%&ndash;<a href="javascript:;" id="uploadimg"><img style="margin-right:5px;" src="../img/icon_uplod.png">附件上传</a>&ndash;%&gt;--%>
						<%--</form>--%>
					</div>
					<ul id="file_mess" style="padding: 5px 15px;display: inline-block;">
						<p id="empty" style="font-size:12px;color:#C6C6C6;">无上传文件</p>
					</ul>
				</form>
			</div>
		</div>


		<!--选择新建方式-->
		<div id="picture" class="mui-popover mui-popover-action mui-popover-bottom">
			<ul class="mui-table-view">
				<li class="mui-table-view-cell">
					<a href="#modal1">新建目录</a>
				</li>
				<li class="mui-table-view-cell">
					<a href="#modal2">新建文件</a>
				</li>
			</ul>
			<ul class="mui-table-view">
				<li class="mui-table-view-cell">
					<a href="#picture"><b>取消</b></a>
				</li>
			</ul>
		</div>
		<script>
            var back_data = [0];
            mui.ajax('/file/catalog', {
                data:{
                    sortId:0,
                    sortType:4,
                    postType:1
                },
                dataType: 'json', //服务器返回json格式数据
                type: 'post', //HTTP请求类型
                success: function(data) {
                    successData(data);
                    var f_str =  str2;
                    mui('#show_li')[0].insertAdjacentHTML('beforeend', f_str);
                },
                error: function(xhr, type, errorThrown) {
                    //异常处理；
                    console.log(type);
                }
            });
			mui('#picture').on('tap','a',function(){
				mui('#picture').popover('hide');
			});
            function successData(data){
                var str = "";
                for(var i = 0; i < data.length; i++) {
                    var img_url="";
                    if(data[i].fileType == "folder") {
                        var name = data[i].sortName;
                        var id = data[i].sortId;
                        var onclick = "get(this)";
                        img_url = '/img/file/m/personal.png';
                    } else if(data[i].fileType == "file") {
                        var name = data[i].subject;
                        img_url = '/img/file/m/file.png';
                        var id = data[i].contentId;
                        var onclick = "file_content(this)";
                    };
                    str += "<li id='" + id + "'   class='mui-table-view-cell catalog' onclick='" + onclick + "'><div class='mui-slider-right mui-disabled' onclick='del(this,event)'  data-type='1'><span class='mui-btn mui-btn-red'>删除</span></div><div class='mui-slider-handle'><img src='" + img_url + "' class='mui-pull-left' style='width: 45px'/><span class='mui-navigate-right' style='margin-left: 40px'>" + name + "</span></div></li>";
                }
                return str2=str;

            };
			//获取点击目录的参数，进行查询，清空页面，从新写入数据
			function get(self){
				var nid = self.getAttribute("id");
				jQuery('#show_li').html("");
				mui.ajax('/file/catalog',{
					data:{
                        sortId:nid,
                        sortType:4,
                        postType:1
					},
					dataType:'json',//服务器返回json格式数据
					type:'get',//HTTP请求类型
					success:function(data){
                        back_data.push(nid);
                        successData(data);
                        var f_str = "<li class='mui-table-view-cell' onclick='frist_page()'><div class='mui-slider-handle'><img src='/img/file/m/catalogue.png' class='mui-pull-left' style='width: 35px'/><span class='mui-navigate-right' style='margin-left: 40px'>返回根目录</span></div></li><li class='mui-table-view-cell'  onclick='prev_page()'><div class='mui-slider-handle'><img src='/img/file/m/back.png' class='mui-pull-left' style='width: 35px'/><span class='mui-navigate-right' style='margin-left: 40px'>返回上一级</span></div></li>" + str2;
                        mui('#show_li')[0].insertAdjacentHTML('beforeend', f_str);
					},
					error:function(xhr,type,errorThrown){
						//异常处理；
						console.log(type);
					}
				});
			}


			//返回根目录
			function frist_page(){
                location.reload();
			}
			//返回上级目录
			function prev_page(){
				if(back_data.length == 2){
                    back_data.pop();      //根据数组弹出最后一个元素 取弹出后数组的最后一个元素返回上级目录
                    var send_nid = back_data[back_data.length-1];
                    $('#show_li').html("");
                    mui.ajax('/file/catalog',{
                        data:{
                            sortId:send_nid,
                            sortType:4,
                            postType:1
                        },
                        dataType:'json',//服务器返回json格式数据
                        type:'get',//HTTP请求类型
                        success:function(data){
                            successData(data);
                            var f_str =  str2;
                            mui('#show_li')[0].insertAdjacentHTML('beforeend', f_str);
                        },
                        error:function(xhr,type,errorThrown){
                            //异常处理；
                            console.log(type);
                        }
                    });
				}else{
					back_data.pop();      //根据数组弹出最后一个元素 取弹出后数组的最后一个元素返回上级目录
                    console.log(back_data);
					var send_nid = back_data[back_data.length-1];
					$('#show_li').html("");
                    mui.ajax('/file/catalog',{
                        data:{
                            sortId:send_nid,
                            sortType:4,
                            postType:1
                        },
                        dataType:'json',//服务器返回json格式数据
                        type:'get',//HTTP请求类型
                        success:function(data){
                            successData(data);
                            var f_str = "<li class='mui-table-view-cell' onclick='frist_page()'><div class='mui-slider-handle'><img src='/img/file/m/catalogue.png' class='mui-pull-left' style='width: 35px'/><span class='mui-navigate-right' style='margin-left: 40px'>返回根目录</span></div></li><li class='mui-table-view-cell'  onclick='prev_page()'><div class='mui-slider-handle'><img src='/img/file/m/back.png' class='mui-pull-left' style='width: 35px'/><span class='mui-navigate-right' style='margin-left: 40px'>返回上一级</span></div></li>" + str2;
                            mui('#show_li')[0].insertAdjacentHTML('beforeend', f_str);
                        },
                        error:function(xhr,type,errorThrown){
                            //异常处理；
                            console.log(type);
                        }
                    });

				}
			}

			//删除操作 e参数为禁止冒泡时间
			function del(file_move,e){
				if(e!=undefined){
					e.stopPropagation();
				}
				var btnArray = ['确认','取消'];
				var elem = file_move;
				var li = elem.parentNode;
				mui.confirm('确认删除此便签？','提示',btnArray,function(f){
					if(f.index == 0){
						var id= elem.getAttribute('data-did');
						var type= elem.getAttribute('data-type');
						if(type == 1){
							var send_data = {
								flag:3,
								sid:id
							}
						}else if(type == 2){
							var send_data = {
								flag:3,
								cid:id
							}
						}
						mui.ajax('http://app.oaoa.pro/app/knowledge_center/a/add.php',{
							data:send_data,
							dataType:'json',//服务器返回json格式数据
							type:'post',//HTTP请求类型
							success:function(data){
								if(data.state == "ok"){
									mui.toast("删除成功");
									li.parentNode.removeChild(li);
								}else if(data.state == "no"){
									mui.toast("删除失败");
								}
							},
							error:function(xhr,type,errorThrown){
								//异常处理；
								console.log(type);
							}
						});
					}else{}
				});
			}

		//点击文件跳转，展示文件详细内容
		function file_content(self){
			var cid = self.getAttribute("id");
		  	mui.openWindow({
				url:'/file/fileContenth5?id='+cid,
				id:'/file/fileContenth5',
		  	});
		}

		//新建目录
		function save(){
		    console.log(back_data);
			var sortParent = back_data[back_data.length-1];
			var file_name = document.getElementById('file_name').value;
			var num = document.getElementById('num').value;
		    var send_data = {
                sortType:4,
                sortName:file_name,
                sortNo:num,
                sortParent:sortParent
		    }
			mui.ajax('/file/add',{
				data:send_data,
				dataType:'json',//服务器返回json格式数据
				type:'get',//HTTP请求类型
				timeout:10000,//超时时间设置为10秒；
				success:function(data){
//					if(data.state == "ok"){
						mui.toast("新增目录成功");
						history.go(-1);
						location.reload();
//					}else{
//						mui.toast("新增目录失败");
//					}
				},
				error:function(xhr,type,errorThrown){
					//异常处理；
					console.log(type);
				}
			});
		}
		//点击保存 提交数据
		function save_file(){
            var sortId = back_data[back_data.length-1];
			var send_pid = back_data[back_data.length-1];
			var title = document.getElementById('file_name2').value;
			var num2 = document.getElementById('num2').value;
			var text_file = document.getElementById('text_file').value;
			var textarea = document.getElementById('textarea').value;
			mui.ajax('/file/saveContent',{
				data:{
                    sortId:sortId,   //目录id
                    subject:title,
                    content:textarea,
                    attachmentId:"", //附件id串
                    attachmentName:"",//附件名称串
                    contentNo:num2
				},
				dataType:'json',//服务器返回json格式数据
				type:'post',//HTTP请求类型
				beforeSend: function() {
					mui('#save').button('loading');
			    },
			    complete: function() {
			    	mui('#save').button('reset');
			    },
				success:function(data){
					mui.toast("正在上传文件请稍等");
//					var qid = data.cid;
					createUpload(qid);
				},
				error:function(e){
			    	mui.alert(JSON.stringify(e));
			    }
			});
		}

		var files = [];
		function appendByGallery(){
			plus.gallery.pick(function(p){
		        // 添加文件
				var index=1;
				var p=p;
					var fe=document.getElementById("file_mess");
					var li=document.createElement("li");
					var n=p.substr(p.lastIndexOf('/')+1);
					li.innerText=n;
					fe.appendChild(li);
					files.push({name:"uploadkey"+index,path:p});
					index++;
					empty.style.display="none";
		    });
		}

		function createUpload(mid) {
			var server='http://app.oaoa.pro/app/knowledge_center/a/add.php?cid='+mid+'&flag=2';
				//var wt=plus.nativeUI.showWaiting();
				var task=plus.uploader.createUpload(server,
					{method:"POST"},
					function(t,status){ //上传完成
						if(status==200){
							mui.toast("新增成功");

							//location.reload();
						}else{
							mui.toast("新增失败");
							location.reload();
						}
					}
				);
				for(var i=0;i<files.length;i++){
					var f=files[i];
					task.addFile(f.path,{key:f.name});
					task.start();
				}

		}
		</script>
	</body>
</html>