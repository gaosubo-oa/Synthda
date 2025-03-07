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
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title></title>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../css/news/center.css"/>
    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/laydate.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>
        .titleOne{
            width: 100%;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
         .pub{
            overflow: hidden;
            text-overflow: ellipsis;
            width:100%;
            white-space: nowrap;
        }
        table{
            table-layout: fixed;
        }
        .titleOne .windowOpen{
            color: #207BD6!important;
        }
    </style>
</head>
<body>
<div class="bx">
    <!--head开始-->
    <div class="head w clearfix">
        <ul class="index_head">
           <li data_id="0" data-num="0"><span class="one headli1_1"><fmt:message
                    code="notice.title.unreadannouncement"/></span><img class="headli1_2" src="../img/twoth.png" alt=""/>
            </li>
            
            <li data_id="" data-num="1"><span class="headli2_1"><fmt:message
                    code="notice.title.notify"/></span><img src="../img/twoth.png" alt="" class="headli2_2"/>
            </li>
                    
           <li data_id="1" data-num="2"><span class="headli3"><fmt:message code="notice.title.announcementquery"/></span></li>
           
        </ul>
    </div>
    <!--head通栏结束-->

    <!--navigation开始-->
    <div class="step1" style="margin-left: 0">
        <div class="navigation  clearfix">
            <div class="left" style="margin-left: 30px">

                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/weidugonggao.png">
                
                <div class="news">
                    <fmt:message code="notice.title.notify"/>
                </div>                
               <select name="TYPE" class="button1 nav_type" id="select">
               </select>
                <div>
                    <div class="nav_date">
                        <fmt:message code="global.lang.date"/>
                        :
                    </div>
                    <input class="button1" id="sendTime">
                </div>
                <!-- 查询按钮 -->
                <div id="cx" class="submit">
                    <fmt:message code="global.lang.query"/>
                </div>
            </div>
            


        </div>

        <!--navigation结束-->

        <!--content部分开始-->
        <div>
            <div class="wrap" style="margin-left: 0;padding: 0 20px;">
                <table id="tr_td">
                    <thead>
                    <tr>
                        <td class="th" width="15%">
                            <fmt:message code="notice.th.publisher"/>
                        </td>
                        <td class="th" width="20%">
                            <fmt:message code="notice.th.title" />
                        </td>
                        <td class="th" width="20%">
                            <fmt:message code="notice.th.effectivedate"/>
                        </td>

                        <td class="th" width="30%">
                            <fmt:message code="notice.th.releasescope"/>
                        </td>
                        <td class="th" width="15%">
                            <fmt:message code="notice.th.type"/>
                        </td>
                        <!-- <td class="th">发布部门</td> -->
                    </tr>
                    </thead>
                    <tbody id="j_tb">
                    
                    </tbody>
                </table>
                <div class="right">
                    <!-- 分页按钮-->
                    <div class="M-box3">
                    </div>

                </div>
            </div>


        </div>
        <!--content部分结束-->

    </div>
</div>
<!-- <div class="center" style="width:100%;margin-top: 50px;display: none;"> -->
<div class="center" id="qt" style="margin-left: 0">
	 <div class="navigation  clearfix">
            <div class="left" style="margin-left: 30px">
                <img src="../img/weidugonggao.png">
                <div class="news">
                    	<fmt:message code="notice.title.announcementquery"/>
                </div>                              
	</div> 
    <div class="login">
        <div class="header">
            <fmt:message code="global.lang.inputquerycondition"/>
        </div>
        <form id="empty">
        <div class="middle">
            <div class="le publisher">
                <div class="color" style="width:120px;">
                    <fmt:message code="notice.th.publisher"/> ：
                </div>
                <input id="input_text1" type="text"/>
                <div style="margin-right:23px; color:#207BD6">
                   <a href="javascript:;" id="query_adduser" style="color:#207bd6;font-size: 14px;"> <fmt:message code="global.lang.add"/></a>
                </div>
                <div>
                   <a href="javascript:;"  onclick="clearData()" style="color:#207bd6;font-size: 14px;"><fmt:message code="global.lang.empty"/></a>
                </div>
            </div>
            <div class="le subject">
                <div class="color" style="width:120px;">
                    <fmt:message code="notice.th.title"/> ：</div>
                <input id="subject_query" class="input_text2" type="text"/>
            </div>
            <div class="le date">
                <div class="color" style="width:120px;"><fmt:message code="notice.title.Releasedate"/> ：</div>
                <input id="beginTime"class="input_text3" type="text"/>
                <div class="color">
                    <fmt:message code="global.lang.to"/>
                </div>
                
               <div><input id="endTime" class="input_text4" type="text"/></div> 
            </div>
            <div class="le ce1">
                <div class="color" style="width:120px;"><fmt:message code="notice.th.type"/> ：</div>
            <div> 
                 <select name="TYPE"  class="button1 input_text5" id="select_query">

                    </select>
                </div>

            </div>
            <div class="le ce2">
                <div class="color" style="width:120px;"><fmt:message code="notice.th.content"/>:</div>
              	<input id="content" class="input_text6" type="text"/>
            </div>
        </div>
        </form>
        <div class="icons">
             <div id="btn_query" style="margin-left: 80px;"><fmt:message code="global.lang.query"/></div>

            <div class="filling"  onclick="Refillings()"><fmt:message code="global.lang.refillings"/></div>
        </div>
    </div>
</div>
<!--footer部分结束-->
</div>
<script>
user_id='input_text1';//选人控件
$(function () {

    //页面加载时发送ajax获取下拉框数据
    var str="<option value=\"0\" selected=\"\"><fmt:message code="notice.type.alltype"/></option>";
    var str2="<option value=\"0\" selected=\"\"><fmt:message code="notice.th.chosenotifytype"/></option>"
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
            $('#select_query').append(str2);
        }


    })
            var data = {
                read : $('.index_head .one').parent().attr('data_id'),
				typeId : $('#select').val()==0?'':$('#select').val(),
				sendTime : $('#sendTime').val(),
				page:1,
				pageSize:5,
				useFlag:true,
				beginDate:'',
				endDate:'',
				content:'',
				subject:'',
                fromId:''

            };
            initPageList(function(pageCount){
           		 initPagination(pageCount,data.pageSize);
            });

            $(".index_head li").click(function (){

                $(this).find('span').addClass('one').parent().siblings('').find('span').removeClass('one');  // 删除其他兄弟元素的样式
                $(".news").html($(this).find('span').text());
				data.read = $(this).attr('data_id');
				data.typeId = $('#select').val()==0?'':$('#select').val();
				data.sendTime = $('#sendTime').val();
				if($(this).attr('data-num')==0){
				    $('.navigation .left img').prop('src','/img/commonTheme/${sessionScope.InterfaceModel}/weidugonggao.png')
                }else if($(this).attr('data-num')==1){
                    $('.navigation .left img').prop('src','/img/commonTheme/${sessionScope.InterfaceModel}/la1.png')
                }else {
                    $('.navigation .left img').prop('src','/img/commonTheme/${sessionScope.InterfaceModel}/gonggaochaxun.png')
                }
				//console.log(data);
				if(data.read == ''||data.read == 0){
					$('.step1').show();
					$('.center').hide();
                    data.subject = '';
                    data.beginTime = '';
                    data.endTime = '';
                    data.typeId =  0;
                    data.content = '';
                    $('.step1').show();
                    $('.step2').hide();
                    $('.center').hide();
					initPageList(function(pageCount){
		           		 initPagination(pageCount,data.pageSize);
		            });
				}else if(data.read == 1){
					$('.step1').hide();
					$('.center').show();
					$('#subject').val('');
					$('#beginTime').val('');
					$('#endTime').val('');
					$('#select').val()==0?'':$('#select').val();
					$('#content').val('');
				}
				
            })
            function initPageList(cb){
            	var layerIndex = layer.load(0, {shade: false});
            	$.ajax({
					type: "get",
					url: "/notice/notifyManage",
					dataType: 'JSON',
					data: data,
					success: function(data){
                       /* var toTypeName = ""*/
						if(data.obj.length == 0){
							layer.closeAll()
							console.log($('.index_head .one').parent().attr('data_id')=='0');
							if($('.index_head .one').parent().attr('data_id') == '0'){
                                    $("#j_tb").html("");
								layer.msg('<fmt:message code="notice.alert.nodatealert"/>', {icon: 6});
								var turnindex=setInterval(function(){
									layer.closeAll();
									$(".index_head li").eq(1).click();
									clearInterval(turnindex);
								},2*1000);
							}else{
                                $("#j_tb").html("");
								layer.msg('<fmt:message code="global.lang.nodata"/>', {icon: 6});
                                if(cb){
                                    cb(0);
                                }
							}
							
						}else{
							var news = "";

                        	for (var i = 0; i < data.obj.length; i++) {
                                var toTypeName = ""
                                var deprange = "";
                                var rolerange = "";
                                var userrange = "";

                                if(data.obj[i].deprange){
                                    deprange=data.obj[i].deprange;
                                }
                                if(data.obj[i].rolerange){
                                    rolerange=data.obj[i].rolerange;
                                }
                                if(data.obj[i].userrange){
                                    userrange=data.obj[i].userrange;
                                }
                                toTypeName = '<fmt:message code="userManagement.th.department" />：'+deprange+'-用户：'+userrange+'-<fmt:message code="userManagement.th.role" />:'+ rolerange;
                                var alltype = deprange+userrange+rolerange

                        		if(data.obj[i].toId != ""){
                        			toTypeName+="<fmt:message code="userManagement.th.department" />";
                        		};
                        		if(data.obj[i].privId != ""){
                        			toTypeName+=",<fmt:message code="userManagement.th.role" />";
                        		}
                        		if(data.obj[i].userId != ""){
                        			toTypeName+=",用户";
                        		};

                                var typeName = "";
                                if(data.obj[i].typeName==-1){
                                    typeName ="";
                                }else{
                                    typeName =data.obj[i].typeName;
                                };
                        	  // var toTypeName = data.obj[i].toId==""?(data.obj[i].privId==""?"用户":"<fmt:message code="userManagement.th.role" />"):"<fmt:message code="userManagement.th.department" />";
                        	   
                               news += "<tr><td notifyId="+data.obj[i].notifyId+" class=''>"+data.obj[i].name+"</td>"+
                                       "<td ><div class='titleOne'>";
                                            if(data.obj[i].top == '1'){
                                                news +='<img src="/img/news/top.png" alt="" style="margin-right: 5px;">';
                                            }
                                news +="<a href='#' notifyId="+data.obj[i].notifyId+" class='windowOpen' style='color:#59b7fb'>"+data.obj[i].subject+"</a></div></td>"+
                                       "<td notifyId="+data.obj[i].notifyId+" class=''>"+data.obj[i].notifyDateTime/*.split(' ')[0]*/+"</td>"+
                                       "<td notifyId="+data.obj[i].notifyId+" class='publishtip'  toTypeName="+toTypeName+"><div class='pub'>"+alltype+"</div></td>"+
                                       "<td notifyId="+data.obj[i].notifyId+" class=''>"+typeName+"</td>"

                           }
							var loadindex=setInterval(function(){
								layer.closeAll();
								$("#j_tb").html(news);
								clearInterval(loadindex);
							},1000);
							
							if(cb){
								cb(data.totleNum);
							}
						}
					}   
				})
            }

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
            homePage:'<fmt:message code="global.page.first" />',
            endPage:'<fmt:message code="global.page.last" />',
            prevContent:'<fmt:message code="global.page.pre" />',
            nextContent:'<fmt:message code="global.page.next" />',
            jumpBtn:'<fmt:message code="global.page.jump" />',
            callback:function(index){
                data.page = index.getCurrent();
                console.log(index.getCurrent());
                initPageList();
            }
        });
    }
    function doQtFunc(url,type,name) {
//        if(qt.webChannelTransport == undefined){
            $.popWindow(url,name,'0','100','1200px','700px');
//        }else{
//            new QWebChannel(qt.webChannelTransport, function(channel){
//                var content = channel.objects.interface;
//                content.xoa_sms('/notice/'+url,name,"web_child_url");
//            });
//        }

    }
    /* 新闻详情页 */
        $("#j_tb").on('click','.windowOpen',function(){
            var nid=$(this).attr('notifyId');
            doQtFunc('detail?notifyId='+nid,' ','<fmt:message code="notice.th.queryDetail"/>');
        });
        $('.submit').click(function (){
            data.read = $('.index_head .one').parent().attr('data_id');
            data.typeId = $('#select').val();
            data.sendTime = $('#sendTime').val();
            //console.log(read,typeId,nTime);
            initPageList(function(pageCount){
                initPagination(pageCount,data.pageSize);
            });
        });
        //时间控件调用
				

   $('#btn_query').click(function (){
       data.fromId=$("#input_text1").attr("user_id");//人员控件 -
		data.read='';
		data.subject = $('#subject_query').val();
		data.beginDate = $('#beginTime').val();
		data.endDate = $('#endTime').val();
		data.typeId =  $('#select_query').val()==0?'':$('#select_query').val();
		data.content = $('#content').val();
		console.log(data);
		initPageList();
		$('.step1').show();
		$('.center').hide();
	});
   $('.export').on('click',function(){
       $.layerMsg({content:'<fmt:message code="lang.th.Upcoming"/>',icon:6},function(){});
   })
});
	 laydate({
         elem: '#sendTime', //目标元素。
         format: 'YYYY-MM-DD', //日期格式
         istime: true //显示时、分、秒
     });
   
   //时间控件调用
   var start = {
        elem: '#beginTime',
        format: 'YYYY-MM-DD',
        /* min: laydate.now(), //设定最小日期为当前日期*/
        /* max: '2099-06-16 23:59:59', //最大日期*/
        istime: true,
        istoday: false,
        choose: function(datas){
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas; //将结束日的初始值设定为开始日
        }
   };

   var end = {
        elem: '#endTime',
        format: 'YYYY-MM-DD',
        /*min: laydate.now(),*/
        /*max: '2099-06-16 23:59:59',*/
        istime: true,
        istoday: false,
        choose: function(datas){
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
   };
   laydate(start);
   laydate(end);
     /* 新闻查询重填 */
	function Refillings(){
		document.getElementById("empty").reset();  
	}
/* 新闻查询清空 */	
	function clearData(){
		$("#input_text1").val("");
		$('#subject_query').val('');
        $('#beginTime').val('');
        $('#endTime').val('');
        $('#content').val('');
        $('#select_query').val('<fmt:message code="notice.th.chosenotifytype" />');
        $("#input_text1").attr("user_id","")
	}
/* 选人控件 */
$("#query_adduser").on("click",function(){
   		user_id = "input_text1";
       	$.popWindow("../common/selectUser");      		 		 
       	});  
</script>
</body>



</html>
