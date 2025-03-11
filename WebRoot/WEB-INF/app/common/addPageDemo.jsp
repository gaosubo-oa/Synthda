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
	<link rel="stylesheet" href="../css/base.css" />
	
	<link rel="stylesheet" type="text/css" href="../css/common/addpage.css"/> 	
	<link rel="stylesheet" href="../lib/pagination/style/pagination.css" />
	<title>首页</title>
	</head>
	<body>
	<!-- 新建新闻 -->
	<div class="step2" style="margin: 0px 14px;">
	<!-- 中间部分 -->
	 <table class="newNews">
        <div class="nav_box clearfix">
            <div class="nav_t1"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/newsManages2_1.png"></div>
            <div class="nav_t2" class="news">新建新闻</div>
             <div class="nav_t3" > 
            	<select name="" class="sel format" id="query_format">
                    <option value="" selected="">全部</option>
			        <option value="0">普通格式</option>
			        <option value="1">MHT格式</option>
			        <option value="2">超链接格式</option>                    
                </select>            
            </div>                
        </div>
        <tbody>
        <tr>
            <td class="td_w">
                <!-- <div class="text1 blue_text">请选择新闻类型</div>
                <img class="text2" src="../../img/mg1.png" alt=""/> -->
                <select name="" class="typeId" id="query_typeId">
                    <option value="">&nbsp;选择新闻类型</option>
		          	<option value="01">公司动态</option>
					<option value="02">媒体关注</option>
					<option value="03">行业资讯</option>
					<option value="04">合作伙伴新闻</option>
					<option value="05">客户新闻</option>                    
                </select>
            </td>
            <td>
                <input class="td_title1" id="query_subject" type="text"  placeholder="请输入新闻标题..."/>
                <img class="td_title2" src="../img/mg2.png" alt=""/>
            </td>
        </tr>
        <tr>
            <td class="blue_text">  按照部门发布：</td>
            <td>
                <input class="td_title1  release1" id="query_toId" type="text"/>
                <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>
               <!--  <div class="release3">添加</div>
                <div class="release4 empty">清空</div> -->
                <div class="release3" style="color:#dfdfdf">添加</div>
                <div class="release4 empty" style="color:#dfdfdf">清空</div> 
            </td>
        </tr>
        <tr>
            <td class="blue_text">  按照角色发布：</td>
            <td>
                <input class="td_title1  release1" id="query_privId" type="text"/>
                <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>
                <div class="release3" style="color:#dfdfdf">添加</div>
                <div class="release4 empty" style="color:#dfdfdf">清空</div>
            </td>
        </tr>
        <tr>
            <td class="blue_text">  按照人员发布：</td>
            <td>
                <input class="td_title1  release1" id="query_userId" type="text"/>
                <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>
                <div class="release3" id="query_adduser">添加</div>
                <div class="release4 empty" style="color:#dfdfdf;">清空</div>
            </td>
        </tr>
        <tr>
            <td class="blue_text">
           		  发布时间：
            </td>
            <td>
                <input class="td_title1 time_coumon" id="query_newTime" type="text" placeholder="请输入发布时间..."/>
                <a href="javascript:;" id="step_release2"><div class="release3">设置为当前时间</div></a>
            </td>
        </tr>
        <tr>
            <td class="blue_text">
           		 评论:
            </td>
            <td>            
                <select name="" class="anonymityYn" id="query_anonymityYn">
                    <option value="0">实名评论</option>
          			<option value="1">匿名评论</option>
          			<option value="2">禁止评论</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="blue_text">
              	  提醒：
            </td>
            <td class="remind">
                <div><input class="news_t1"  type="checkbox" checked/></div>
             
                <div class="news_t">发送事物提醒消息</div>
                <div><input class="news_t1" type="checkbox" checked/></div>
               
                <div class="news_t2">分享到企业社区</div>
            </td>
        </tr>
        <tr>
            <td class="blue_text">
               	 置顶：
            </td>
            <td class="top_box">
                <div><input class="news_t1 " id="query_top" type="checkbox"/></div>
                <!-- <div><input type="checkbox" style="height:14px;width:14px;margin-top: 4px;"/></div> -->
                <!-- <div><img src="../../img/mg4.png" alt=""/></div> -->
                <div class="news_t3">使新闻置顶，显示为重要</div>
                <input class="t_box" id="add_topDate" type="text" value="0"/>
                <div class="news_t4">天后结束置顶（0表示一直置顶）</div>
            </td>		
        </tr>
        <tr>
            <td class="blue_text">
              	  内容简介：
            </td>
            <td class="abstract">
                <input class="abstract1" id="ip4" type="text"  maxlength="39" placeholder="请输入内容..."/>
                <div class="abstract2">(最多输入30个字)</div>
            </td>
        </tr>
        <tr>
            <td class="blue_text">
               	 附件上传：
            </td>
            <td class="enclosure">
            	<div id="query_uploadArr">

            	</div><br>
                <div><img src="../img/mg11.png" alt=""/></div>
               <!--  <div class="enclosure_t"><a href="#">添加附件</a></div> -->
                <div>
	                <form id="uploadimgform" target="uploadiframe"  action="../upload?module=news" enctype="multipart/form-data" method="post" >
						<input type="file" name="file" id="uploadinputimg"  class="w-icon5" style="display:none;">
						<a id="uploadimg" style="cursor: pointer;">添加附件</a>
					</form>
				</div>
                <div><img class="left_img" src="../img/mg12.png" alt=""/></div>
                <div class="enclosure_t"><a href="#">从文件柜和网络硬盘选择附件</a></div>
                <div><img src="../img/mg13.png" alt=""/></div>
                <div class="enclosure_t"><a href="#">批量插入图片</a></div>
                <div><img src="../img/mg14.png" alt=""/></div>
                <div class="enclosure_t"><a href="#">批量上传过</a></div>
            </td>
        </tr>
        <!--word编辑器-->
        </tbody>        
    </table>
</div>
	</body>
</html>
