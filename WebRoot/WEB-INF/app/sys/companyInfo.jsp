<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	 <%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
	<head>
	    <meta charset="UTF-8">
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
        <title><fmt:message code="main.unitmanage" /></title>
        <%--<link rel="stylesheet" href="../css/base.css" />
        <link rel="stylesheet" type="text/css" href="../css/common/addpage.css"/>
        <link rel="stylesheet" href="../lib/pagination/style/pagination.css" />--%>
        <link rel="stylesheet" href="../css/sys/companyinfo.css" />
        <script type="text/javascript" src="../js/xoajq/xoajq3.js"></script>
        <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
        <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
        <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
        <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
        <script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
        <script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
        <script src="/lib/ueditor/UEcontroller.js" type="text/javascript" charset="utf-8"></script>
        <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
        <script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
        <script src="/js/jquery/jquery.form.min.js"></script>
        <%--<script type="text/javascript" src="../js/sys/companyinfo.js"></script>--%>
        <style>
            input{
                font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
                font-size:14px;
            }
            #edui1_elementpath{
                border-right:none;
            }
        </style>
	</head>
	<body>

    <div class="content">
        <div class="headDiv">
            <div class="nav_t1"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_unitManagement.png"></div>
            <div class="divP"><fmt:message code="main.unitmanage" /></div>
        </div>
        <div class="tab">
                <table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff">
                    <tr>
                        <td class="blue_text"><fmt:message code="depatement.th.Unitname" />：</td>
                        <td>
                            <input type="text" name="unitName" class="inputTd" value="" id="isFlag"/>
                         <%-- <span style="font-size: 12px;color: #666;">如需修改，请联系管理员在多组织管理中修改</span>--%>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="depatement.th.Telephone" />：</td>
                        <td>
                            <input type="text"  name="telNo" class="inputTd" placeholder=""/>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="depatement.th.fax" />：</td>
                        <td>
                            <input type="text" name="faxNo" class="inputTd" placeholder=""/>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="depatement.th.Zipcode" />：</td>
                        <td>
                            <input type="text" name="postNo" class="inputTd" placeholder=""/>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="depatement.th.address" />：</td>
                        <td>
                            <input type="text" name="address" class="inputTd" placeholder=""/>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="depatement.th.website" />：</td>
                        <td>
                            <input type="text" onblur="checkWZ()" name="url" class="inputTd" placeholder=""/>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="depatement.th.Electronicmailbox" />：</td>
                        <td>
                            <input type="text" onblur="checkEmail()" name="email" class="inputTd" placeholder=""/>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="depatement.th.Openingbank" />：</td>
                        <td>
                            <input type="text" name="bankName" class="inputTd" placeholder=""/>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="depatement.th.Accountnumber" />：</td>
                        <td>
                            <input type="number" name="bankNo" class="inputTd" placeholder="" style="width: 200px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="depatement.th.TaxID" />：</td>
                        <td>
                            <input type="text" name="taxNumber" class="inputTd" placeholder=""/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="blue_text"><fmt:message code="depatement.th.Unitprofile" /></td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="depatement.th.Attachmentdocument" />：</td>
                        <td class="enclosure"></td>
                    </tr>
                    <tr>
                        <td class="blue_text"><fmt:message code="global.th.fileup" />：</td>
                        <td class="files">
                            <%--<form id="uploadimgform" target="uploadiframe"  action="/upload?module=sys" enctype="multipart/form-data" method="post" >--%>
                                <%--<input type="file" name="file" id="uploadinputimg" multiple="multiple" class="w-icon5" style="display:none;">--%>
                                <%--<a href="javascript:void (0)" id="uploadimg"><div class="div_upload_im"><img src="../img/mg11.png" alt=""/></div><fmt:message code="global.th.fileup" /></a>--%>
                            <%--</form>--%>
                            <form id="uploadimgform" target="uploadiframe"  action="/upload?module=sys"  method="post" >
                                <input type="file" multiple="multiple" name="file"  id="uploadinputimg"  class="w-icon5" style="position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                                <a href="#" id="uploadimg"><img style="margin-right:5px;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>
                            </form>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div id="container" style="width: 99.9%;min-height: 300px;" name="content" type="text/plain"></div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="btn">
                                <div id="submit" class="submit"><span style="margin-left: 26px"><fmt:message code="depatement.th.SaveUnitsettings" /></span></div>
                                <%--<input id="submit" type="button" value="<fmt:message code="depatement.th.SaveUnitsettings" />"/>--%>
                            </div>
                        </td>
                    </tr>
                </table>
        </div>
    </div>
</body>
    <script type="text/javascript">
        var ue = UE.getEditor('container',{elementPathEnabled : false});
        UEimgfuc();
        var res;
        function checkPhone(){
            var phone = $('input[name="telNo"]').val();
            if(!(/^1(3|4|5|6|7|8|9)\d{9}$/.test(phone))){
                $.layerMsg({content:'电话有误，请重填',icon:5})
                return false;
            }
        }
        function checkWZ(){
            var url = $('input[name="url"]').val();
            if(url!=''&&!(/^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\*\+,;=.]+$/.test(url))){
                $.layerMsg({content:'网址有误，请重填',icon:5})
                return false;
            }
        }
        function checkEmail(){
            var email = $('input[name="email"]').val();
            if(email!=''&&!(/^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/.test(email))){
                $.layerMsg({content:'电子信箱有误，请重填',icon:5})
                return false;
            }
        }
        $(function(){


            $('#uploadinputimg').fileupload({
                dataType:'json',
                done: function (e, data) {
                    if(data.result.obj != ''){
                        var data = data.result.obj;
                        var str = '';
                        var str1 = '';
                        for (var i = 0; i < data.length; i++) {
                            var gs = data[i].attachName.split('.')[1];
                            if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){
                                str += '';
                                layer.alert('jsp、css、js、html、java文件禁止上传!',{},function(){
                                    layer.closeAll();
                                });
                            }else{
                                str += '<div class="dech" deUrl="' + encodeURI(data[i].attUrl)+ '">' +
                                    '<a href="/download?'+encodeURI(data[i].attUrl)+'" NAME="' + data[i].attachName + '*" style="display: inline-block;">' +
                                    '<img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + data[i].attachName + '</a>' +
                                    '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/>' +
                                    '<input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +
                                    '</div>';
                            }
                        }
//                        $('.Attachment td').eq(1).append(str);
                        $('.enclosure').append(str);
                    }else{
                        //alert('添加附件大小不能为空!');
                        layer.alert('添加附件大小不能为空!',{},function(){
                            layer.closeAll();
                        });
                    }
                }
            });

            //附件删除
            $('.enclosure').on('click','.deImgs',function(){
                var data=$(this).parents('.dech').attr('deUrl');
                var dome=$(this).parents('.dech');
                deleteChatment(data,dome);
            })
            //queryInfo();

            //信息查询
            ue.ready(function() {

                    $.ajax({
                        url: '../sys/showUnitManage',
                        type: 'get',
                        dataType: 'json',
                        success: function (res) {
//                            console.log(res.object);
                            var data = res.object;
                            var stra = '';
                            var arr = new Array();

                            arr = data.attachment;

                            $('input[name="unitName"]').val(data.unitName);
                            $('input[name="telNo"]').val(data.telNo);
                            $('input[name="faxNo"]').val(data.faxNo);
                            $('input[name="postNo"]').val(data.postNo);
                            $('input[name="address"]').val(data.address);
                            $('input[name="url"]').val(data.url);
                            $('input[name="email"]').val(data.email);
                            $('input[name="bankName"]').val(data.bankName);
                            $('input[name="bankNo"]').val(data.bankNo);
                            $('input[name="taxNumber"]').val(data.taxNumber);

                            if (data.attachmentName != '') {   //判断是否存在附件
                                for (var i = 0; i < arr.length; i++) {
                                    stra+='<div class="dech" deUrl="' + encodeURI(arr[i].attUrl)+ '">' +
                                        '<span><a href="/download?'+encodeURI(arr[i].attUrl)+'" style="text-decoration:none;cursor: pointer;display:inline-block;" name="'+ arr[i].name +'">' +
                                        '<img style="margin-right:10px;" src="../img/attachment_icon.png"/>'+arr[i].attachName+'</a>' +
                                        '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/>' +
                                        '<input type="hidden" class="inHidden" value="'+ arr[i].id +'"></span></div>';
                                }
                            }
                            if(data.isFlag == 'true'){
                                $('#isFlag').attr("disabled",true);
                            }

//                            if(data.isFlag == 'false'){
//                                $('input').attr("readonly","readonly")
//                            }else{
//                                $('input').removeAttr("readonly")
//                            }
                            $('.enclosure').html(stra);
                            ue.setContent(data.content);
                        }
                    })

            })
            //保存修改
            $('#submit').on("click",function(){
                var url = $('input[name="url"]').val();
                if(url!=''&&!(/^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\*\+,;=.]+$/.test(url))){
                    $.layerMsg({content:'网址有误，请重填',icon:5})
                    return false;
                }
                var email = $('input[name="email"]').val();
                if(email!=''&&!(/^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/.test(email))){
                    $.layerMsg({content:'电子信箱有误，请重填',icon:5})
                    return false;
                }
                var txt = ue.getContentTxt();
                var html = ue.getContent();
                var attach=$('.enclosure').find('a');
                var aId='';
                var uId='';
                for(var i=0;i<$('.enclosure .inHidden').length;i++){
                    aId += $('.enclosure .inHidden').eq(i).val();
                }
                for(var i=0;i<$('.enclosure .inHidden').length;i++){
                    uId += attach.eq(i).attr('NAME');
                }
                var data={
                    'unitName':$('input[name="unitName"]').val(),
                    'telNo':$('input[name="telNo"]').val(),
                    'faxNo':$('input[name="faxNo"]').val(),
                    'postNo':$('input[name="postNo"]').val(),
                    'address':$('input[name="address"]').val(),
                    'url':$('input[name="url"]').val(),
                    'email':$('input[name="email"]').val(),
                    'bankName':$('input[name="bankName"]').val(),
                    'bankNo':$('input[name="bankNo"]').val(),
                    'taxNumber':$('input[name="taxNumber"]').val(),
                    'attachmentId':aId,
                    'attachmentName':uId,
                    'content':html
                }
                $.ajax({
                    type:'post',
                    url:'../sys/updateUnit',
                    dataType:'json',
                    data:data,
                    success:function(rsp){
                        if(rsp.flag == true){
                            $.layerMsg({content:'<fmt:message code="depatement.th.Modifysuccessfully" />',icon:1},function(){
                                location.reload();
                            });
                        }else{
                            $.layerMsg({content:'<fmt:message code="depatement.th.modifyfailed" />',icon:2},function(){
                                console.log(rsp.flag);
                            });
                        }
                    }
                })
            })
        })

        //删除附件
        function deleteChatment(data,element){
            layer.confirm('<fmt:message code="workflow.th.que" />？', {
                btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
                title:"<fmt:message code="notice.th.DeleteAttachment" />"
            }, function(){
                //确定删除，调接口
                $.ajax({
                    type:'post',
                    url:'../delete',
                    dataType:'json',
                    data:data,
                    success:function(res){

                        if(res.flag == true){
                            layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});
                            element.remove();
                        }else{
                            layer.msg('<fmt:message code="lang.th.deleSucess" />', { icon:5});
                        }
                    }
                });

            }, function(){
                layer.closeAll();
            });
        }

    </script>
</html>
