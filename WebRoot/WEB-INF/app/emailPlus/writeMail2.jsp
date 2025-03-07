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
	<title>回复</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
	<link rel="stylesheet" type="text/css" href="../css/email/writeMail.css"/>
<%--	<script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
	<script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
	<script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/ueditor/UEcontroller.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/email/writeMail.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
	<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/jquery/jquery.cookie.js"></script>
	<style>
		table{margin-top:10px;width: 90%;}
		table tr td{padding-left:10px;}
		.files a{text-decoration: none;}
	</style>
</head>
<body>
<table class="TABLE" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse;">
	<tr class="append_t">
		<td width="15%" style="padding-left: 10px;">组织：</td>
		<td width="85%">
			<div class="inPole">
				<select id="orgMore" class="orgMore"  name="workOpinion" style="min-width: 70%; height: 52px;background: rgb(235, 235, 228);margin: 5px;">
				</select>
				<span class="add_img">
					<a href="javascript:;" id = "clear"><fmt:message code="notice.th.delete1" /></a>
				</span>
			</div>
		</td>
	</tr>
	<tr class="append_tr">
		<td width="10%"><fmt:message code="email.th.recipients" />：</td>
		<td width="89%">
			<div class="inPole">
				<textarea name="txt" id="senduser" user_id='' value="" disabled></textarea>
				<span class="add_img" style="margin-left: 10px;">
							<%--<span class="addImg">
								<img src="../img/org_select.png" class="addIcon"/>
							</span>--%>
							<a href="javascript:;" id="selectUser" class="Add"><fmt:message code="global.lang.add" /></a>
						</span>
				<span class="add_img">
							<%--<span class="addImg">
								<img src="../img/org_select2.png" class="clearIcon"/>
							</span>--%>
							<a href="javascript:;" class="clear"><fmt:message code="notice.th.delete1" /></a>
						</span>
				<!--<input type="checkbox" name="check" id="check" value="向此人发送外部邮件" />
                <span>向此人发送外部邮件</span>-->
			</div>
			<div class="addPepl">
				<%--<a href="javascript:;" class="a3">添加外部收件人</a>--%>
				<a href="javascript:;" class="a1"><fmt:message code="email.th.addwait" /></a>
				<a href="javascript:;" class="a2"><fmt:message code="email.th.addbcc" /></a>
			</div>
		</td>
	</tr>
	<tr>
		<td><fmt:message code="email.th.major" />：</td>
		<td>
			<input type="text" id="txt" value="" class="input_txt" />
		</td>
	</tr>
	<tr>
		<td width="10%">
			<p><fmt:message code="email.th.content" />：</p>
			<!-- <p class="Color"><fmt:message code="email.th.countnumber" />：<span>0</span></p> -->
			<!-- <p class="Color"><fmt:message code="global.lang.empty" /></p> -->
		</td>
		<td width="89%">
			<div id="container" style="width: 99.9%;min-height: 300px;" name="content" type="text/plain"></div>
		</td>
	</tr>
	<tr class="Attachment" style="width:100%;">
		<td width="10%"><fmt:message code="email.th.file" />：</td>
		<td width="89%" class="files" id="files_txt"></td>
	</tr>
	<tr>
		<td><fmt:message code="email.th.filechose" />：</td>
		<td class="files">

			<form id="uploadimgform" target="uploadiframe"  action="../upload?module=email" enctype="multipart/form-data" method="post" >
				<input type="file" name="file" multiple="multiple" id="uploadinputimg"  class="w-icon5" style="display:none;">
				<a href="javascript:;" id="uploadimg"><img style="margin-right:5px;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>
			</form>

		</td>
	</tr>
	<tr>
		<td><fmt:message code="sms.th.remind" />：</td>
		<td class="remind">
			<div class="news_t">
				<input type="checkbox" name="remind" class="remindCheck" value="0" checked>
				<fmt:message code="notice.th.remindermessage" />
			</div>
			<%--  <div class="news_two">
                  <input type="checkbox" name="remind" ><h1><fmt:message code="notice.th.share"/></h1>
              </div>--%>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<div class="div_btn">
				<div class="sureBtn"><span style="margin-left: 30px;"><fmt:message code="email.th.transmitimmediate" /></span></div>
				<div class="saveBtn"><span style="margin-left: 33px;"><fmt:message code="email.th.savedraftbox" /></span></div>
			</div>
		</td>
	</tr>
</table>


<script type="text/javascript">
    var ue = UE.getEditor('container');
    UEimgfuc();
    var user_id='senduser';
    var userName=$.cookie('userName');
    var userId=$.cookie('userId');

    //获取输入框内容
    $(function () {

        $("#selectUser").on("click",function(){
            user_id='senduser';
            var oid=$('#orgMore option:selected').val();
            $.popWindow("../common/selectUserPlus?OID="+oid);
        });
        $('.TABLE').on('click','#selectUserO',function(){
            user_id='copeNameText';
            var oid=$('#orgMore option:selected').val();
            $.popWindow("../common/selectUserPlus?OID="+oid);
        })
        $('.TABLE').on('click','#selectUserT',function(){
            user_id='secritText';
            var oid=$('#orgMore option:selected').val();
            $.popWindow("../common/selectUserPlus?OID="+oid);
        })
        //获取地址栏参数
        var sId=$.getQueryString('sId');
        var TYPE=$.getQueryString('type');
        ue.ready(function(){
            function dataStyle(id){  //回复内容接口
                $.ajax({
                    type:'get',
                    url:'/emailPlus/messageEmail',
                    dataType:'html',
                    data:{'emailId':id},
                    success:function(res){
                        console.log(res);
                        ue.setContent(res,false);
                    }
                })
            }
            function dataStyles(id){  //回复内容接口
                $.ajax({
                    type:'get',
                    url:'/emailPlus/messageEmail',
                    dataType:'html',
                    data:{'bodyId':id},
                    success:function(res){
                        console.log(res);
                        ue.setContent(res,false);
                    }
                })
            }
            if(TYPE == 2){   //收件箱转发
                document.title="<fmt:message code="email.th.ForwardMail" />";
                $.ajax({
                    type:'get',
                    url:'/emailPlus/queryByID',
                    dataType:'json',
                    data:{'emailId':sId,'flag':''},
                    success:function(rsp){
                        var data2=rsp.object;
                        var sendTime=new Date((data2.sendTime)*1000).Format('yyyy-MM-dd hh:mm');
                        var stra='';
                        var arr=new Array();
                        arr=data2.attachment;
                        $('#txt').val('');
                        ue.setContent('');
                        $('#senduser').val('');
                        if(data2.attachmentName!=''){ //判断是否存在附件
                            for(var i=0;i<arr.length;i++){
                                <%--stra+='<span><a href="/download?'+arr[i].attUrl+'" style="text-decoration:none;cursor: pointer;display:block;"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>'+arr[i].attachName+'</a></span>';--%>
                                stra+='<div class="dech" deUrl="'+arr[i].attUrl+'"><a href="/download?'+arr[i].attUrl+'" NAME="'+arr[i].attachName+'*" style="text-decoration:none;"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>'+arr[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+arr[i].aid+'@'+arr[i].ym+'_'+arr[i].attachId+',"></div>';
                            }
                        }
                        if (TYPE==1&&data2.copyName!=''){
                            var str1='<tr class="tian"><td><fmt:message code="main.th.CC" />：</td><td><textarea user_id="" value="" name="txt" id="copeNameText" disabled></textarea><span class="add_img"><span class="addImg"></span><a href="javascript:;" id="selectUserO" class="Add"><fmt:message code="global.lang.add" /></a><span class="add_img"><span class="addImg"></span><a href="javascript:;" class="clear"><fmt:message code="notice.th.delete1" /></a></span></td></tr>';
                            $('.append_tr').after(str1);
                            $('.a1').text('<fmt:message code="email.th.HideCC" />');
                        }
                        $('#files_txt').html(stra);
                        dataStyle(sId)
                        $('#txt').val('Fw:'+data2.subject);
                        if (TYPE!=2){
                            $('#senduser').val(data2.users.userName+',');
                            $('#senduser').attr('user_id',data2.users.userId+',');
                        }else{
                            $('#senduser').val('');
                        }
                        $('#copeNameText').val(data2.copyName)
                    }
                });
            }else if(TYPE==3){   //发件箱转发
                document.title="<fmt:message code="email.th.ForwardMail" />";
                $.ajax({
                    type:'get',
                    url:'/emailPlus/queryByID',
                    dataType:'json',
                    data:{'bodyId':sId,'flag':''},
                    success:function(rsp){
                        var data2=rsp.object;
                        var sendTime=new Date((data2.sendTime)*1000).Format('yyyy-MM-dd hh:mm');
                        var stra='';
                        var arr=new Array();
                        arr=data2.attachment;
                        $('#txt').val('');
                        ue.setContent('');
                        $('#senduser').val('');

                        if(data2.attachmentName!=''){ //判断是否存在附件
                            for(var i=0;i<arr.length;i++){
                                <%--stra+='<span><a href="/download?'+arr[i].attUrl+'" style="text-decoration:none;cursor: pointer;display:block;"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>'+arr[i].attachName+'</a></span>';--%>
                                stra+='<div class="dech" deUrl="'+arr[i].attUrl+'"><a href="/download?'+arr[i].attUrl+'" NAME="'+arr[i].attachName+'*" style="text-decoration:none;"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>'+arr[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+arr[i].aid+'@'+arr[i].ym+'_'+arr[i].attachId+',"></div>';
                            }
                        }
                        if (TYPE==1&&data2.copyName!=''){
                            var str1='<tr class="tian"><td><fmt:message code="main.th.CC" />：</td><td><textarea user_id="" value="" name="txt" id="copeNameText" disabled></textarea><span class="add_img"><span class="addImg"></span><a href="javascript:;" id="selectUserO" class="Add"><fmt:message code="global.lang.add" /></a><span class="add_img"><span class="addImg"></span><a href="javascript:;" class="clear"><fmt:message code="notice.th.delete1" /></a></span></td></tr>';
                            $('.append_tr').after(str1);
                            $('.a1').text('<fmt:message code="email.th.HideCC" />');
                        }
                        $('#files_txt').html(stra);
                        dataStyles(sId);
                        $('#txt').val('Fw:'+data2.subject);
                        if (TYPE!=2){
                            $('#senduser').val(data2.users.userName+',');
                            $('#senduser').attr('user_id',data2.users.userId+',');
                        }else{
                            $('#senduser').val('');
                        }

                        $('#copeNameText').val(data2.copyName)
                    }
                });
            }else if( TYPE==0 ){
                document.title="<fmt:message code="email.th.reply" />";
                $.ajax({
                    type:'get',
                    url:'/emailPlus/queryByID',
                    dataType:'json',
                    data:{'emailId':sId,'flag':''},
                    success:function(rsp){
                        var data2=rsp.object;
                        var sendTime=new Date((data2.sendTime)*1000).Format('yyyy-MM-dd hh:mm');
                        var str1='';
                        var stra='';
                        var arr=new Array();
                        arr=data2.attachment;
                        $('#txt').val('');
                        ue.setContent('');
                        $('#senduser').val('');

                        if(data2.attachmentName!=''){   //判断是否存在附件
                            for(var i=0;i<arr.length;i++){
                                <%--stra+='<span><a href="/download?'+arr[i].attUrl+'" style="text-decoration:none;cursor: pointer;display:block;"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>'+arr[i].attachName+'</a></span>';--%>
                                stra+='<div class="dech" deUrl="'+arr[i].attUrl+'"><a href="/download?'+arr[i].attUrl+'" NAME="'+arr[i].attachName+'*" style="text-decoration:none;"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>'+arr[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+arr[i].aid+'@'+arr[i].ym+'_'+arr[i].attachId+',"></div>';
                            }
                        }
                        if (TYPE==1&&data2.copyName!=''){
                            str1='<tr class="tian"><td><fmt:message code="main.th.CC" />：</td><td><textarea user_id="" value="" name="txt" id="copeNameText" disabled></textarea><span class="add_img"><span class="addImg"></span><a href="javascript:;" id="selectUserO" class="Add"><fmt:message code="global.lang.add" /></a><span class="add_img"><span class="addImg"></span><a href="javascript:;" class="clear"><fmt:message code="notice.th.delete1" /></a></span></td></tr>';
                            $('.append_tr').after(str1);
                            $('.a1').text('<fmt:message code="email.th.HideCC" />');
                        }
                        $('#files_txt').html(stra);
                        dataStyle(sId)
                        $('#txt').val('Re:'+data2.subject);
                        if (TYPE!=2){
                            $('#senduser').val(data2.users.userName+',');
                            $('#senduser').attr('user_id',data2.users.userId+',');
                        }else{
                            $('#senduser').val('');
                        }
                        $('#copeNameText').val(data2.copyName)
                    }
                });
            }else if( TYPE==1 ){
                document.title='<fmt:message code="email.th.replyall" />';/*回复全部*/
                $.ajax({
                    type:'get',
                    url:'/emailPlus/queryByID',
                    dataType:'json',
                    data:{'emailId':sId,'flag':''},
                    success:function(rsp){
                        var data2=rsp.object;
                        var sendTime=new Date((data2.sendTime)*1000).Format('yyyy-MM-dd hh:mm');
                        var str1='';
                        var stra='';
                        var arr=new Array();
                        arr=data2.attachment;
                        var arrName;
                        arrName=data2.toName.split(',');
                        var arrCname;
                        arrCname=data2.copyName.split(',');
                        var arrId;
                        arrId=data2.toId2.split(',');
                        var arrCId;
                        arrCId=data2.copyToId.split(',');
                        $('#txt').val('');
                        ue.setContent('');
                        $('#senduser').val('');

                        if(data2.attachmentName!=''){   //判断是否存在附件
                            for(var i=0;i<arr.length;i++){
                                stra+='<div class="dech" deUrl="'+arr[i].attUrl+'"><a href="/download?'+arr[i].attUrl+'" NAME="'+arr[i].attachName+'*" style="text-decoration:none;"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>'+arr[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+arr[i].aid+'@'+arr[i].ym+'_'+arr[i].attachId+',"></div>';
                            }
                        }
                        if (TYPE==1&&data2.copyName!=''){
                            str1='<tr class="tian"><td><fmt:message code="main.th.CC" />：</td><td><textarea user_id="" value="" name="txt" id="copeNameText" disabled></textarea><span class="add_img"><span class="addImg"></span><a href="javascript:;" id="selectUserO" class="Add"><fmt:message code="global.lang.add" /></a><span class="add_img"><span class="addImg"></span><a href="javascript:;" class="clear"><fmt:message code="notice.th.delete1" /></a></span></td></tr>';
                            $('.append_tr').after(str1);
                            $('.a1').text('<fmt:message code="email.th.HideCC" />');
                        }
                        $('#files_txt').html(stra);
                        dataStyle(sId)
                        $('#txt').val('Re:'+data2.subject);
                        if (TYPE!=2){
                            $('#senduser').attr('user_id',data2.users.userId+',');
                        }else{
                            $('#senduser').val('');
                        }
                        for(var i=0;i<arrName.length;i++){ //收件人数组
                            if(userName==arrName[i]){
                                arrName.splice(i,1);
                            }
                        }
                        for(var i=0;i<arrCname.length;i++){ //抄送人数组
                            if(userName==arrCname[i]){
                                arrCname.splice(i,1);
                            }
                        }
                        for(var i=0;i<arrId.length;i++){
                            if(userId==arrId[i]){
                                arrId.splice(i,1);
                            }
                        }
                        for(var i=0;i<arrCId.length;i++){
                            if(userId==arrCId[i]){
                                arrCId.splice(i,1);
                            }
                        }

                        $('#senduser').val(data2.users.userName+','+arrName.join(','));
                        $('#senduser').attr('user_id',data2.users.userId+','+arrId.join(','));
                        $('#copeNameText').val(arrCname.join(','));
                        $('#copeNameText').attr('user_id',arrCId.join(','));
                    }
                });
            }

        })

        //附件上传方法
        $('#uploadimg').on('click', function(ele) {
            user_id='senduser';
            $('#uploadinputimg').trigger('click');
        })
        $('#uploadinputimg').on('change',function(e){
            var target = $(e.target);
            var file;
            if(target[0].files && target[0].files[0]){
                file=target[0].files[0];
            }

            if(file){
                $.upload($('#uploadimgform'),function(res){
                    var data=res.obj;
                    var str='';
                    for(var i=0;i<data.length;i++){
                        str+='<div class="dech" deUrl="'+data[i].attUrl+'"><a href="/download?'+data[i].attUrl+'" NAME="'+data[i].attachName+'*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';
                    }

                    $('.Attachment td').eq(1).append(str);

                });
            }
        });

        //附件删除
        $('#files_txt').on('click','.deImgs',function(){
            var data=$(this).parents('.dech').attr('deUrl');
            var dome=$(this).parents('.dech');
            deleteChatment(data,dome);
        })

        //选组织控件
        $.ajax({
            url:"../getCompanyAll",
            type:'get',
            dataType:"JSON",
            success:function (res) {
                var str = '';
                if(res.flag){
                    for(var i=0;i<res.obj.length;i++){
                        str +='<option  value="'+res.obj[i].oid+'">'+res.obj[i].name+'</option>'
                    }
                }
                $('#orgMore').append(str);
            }
        })
        $("#clear").on("click",function () {
            $("#orgMore").val("");
        })

        //点击立即发送
        $(".sureBtn").on("click",function(){
            var remindVal=0;
            if($('.remindCheck').is(":checked")){
                remindVal=1;
            }
            var dataId1=$('.inPole').find('#senduser').attr('user_id');
            var dataId2=$('.tian').find('#copeNameText').attr('user_id');
            var dataId3=$('.mis').find('#secritText').attr('user_id');
            var sql=$('#orgMore option:selected').val();
            var TYPE=$.getQueryString('type');
            var userId=$('textarea[name="txt"]').attr('user_id');
            var txt = ue.getContentTxt();
            var html = ue.getContent();
            var val=$('#txt').val();
            var attach=$('.Attachment td').eq(1).find('a');
            var aId='';
            var uId='';
            for(var i=0;i<$('.Attachment td .inHidden').length;i++){
                aId += $('.Attachment td .inHidden').eq(i).val();
            }
            for(var i=0;i<$('.Attachment td .inHidden').length;i++){
                uId += attach.eq(i).attr('NAME');
            }
            var data={
                'flag':'1',
                'emailId':sId,
                'toId2': dataId1,
                'copyToId':dataId2,
                'secretToId':dataId3,
                'sql':sql,
                'subject':val,
                'content':html,
                'attachmentId':aId,
                'attachmentName':uId,
				'remind':remindVal
            };
            $.ajax({
                type:'post',
                url:'/emailPlus/sendMessageEmail',
                dataType:'json',
                data:data,
                success:function(){
                    if (TYPE!=2 && TYPE!=3){
                        $.layerMsg({content:'<fmt:message code="doc.th.ReplySuccessfully" />！',icon:1},function(){
                                     window.close()
                                     parent.opener.location.reload()
                        });
                    }else{
                        $.layerMsg({content:'<fmt:message code="email.th.ForwardingSuccess" />！',icon:1},function(){
                            window.close()
                            parent.opener.location.reload()
                        });
                    }
                }
            });
        })

        //点击保存到草稿箱按钮
        $(".saveBtn").on("click",function(){
            var dataId1=$('.inPole').find('#senduser').attr('user_id');
            var dataId2=$('.tian').find('#copeNameText').attr('user_id');
            var dataId3=$('.mis').find('#secritText').attr('user_id');
            var userId=$('textarea[name="txt"]').attr('user_id');
            var sql=$('#orgMore option:selected').val();
            var txt = ue.getContentTxt();
            var html = ue.getContent();
            var val=$('#txt').val();
            var attach=$('.Attachment td').eq(1).find('a');
            var aId='';
            var uId='';
            for(var i=0;i<$('.Attachment td .inHidden').length;i++){
                aId += $('.Attachment td .inHidden').eq(i).val();
            }
            for(var i=0;i<$('.Attachment td .inHidden').length;i++){
                uId += attach.eq(i).attr('NAME');
            }
            var data={
                'flag':'1',
                'toId2': dataId1,
                'copyToId':dataId2,
                'secretToId':dataId3,
                'sql':sql,
                'subject':val,
                'content':html,
                'attachmentId':aId,
                'attachmentName':uId
            };
            $.ajax({
                type:'post',
                url:'/emailPlus/saveEmail',
                dataType:'json',
                data:data,
                success:function(){
                    $.layerMsg({content:'<fmt:message code="diary.th.modify" />！',icon:1},function(){
                        window.close()
                        parent.opener.location.reload()
                    });
                }
            });
        });

        //删除附件
        function deleteChatment(data,element){

            layer.confirm('<fmt:message code="workflow.th.que" />？', {
                btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
                title:"<fmt:message code="notice.th.DeleteAttachment" />"
            }, function(){
                //确定删除，调接口
                $.ajax({
                    type:'get',
                    url:'../emailPlus/delete',
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

            }, function(){
                layer.closeAll();
            });
        }
    })
</script>
</body>
</html>

