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
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/css/base.css">

    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script src="../../js/news/page.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript"
            charset="utf-8"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=201908121454" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <title><fmt:message code="main.votemanage" /></title>
    <style>
        .title span{
            font-size:22px;
            color:#494d59;

        }
        .title img{
            vertical-align: middle;
            padding-left:20px;
        }
        .title{
            margin-bottom:20px;
        }
        .btn{
            text-align:center;
        }
        button{
            width:50px;
        }
        .table table{
            width: 97%;
            margin:0 auto;
        }
        th{
            background-color: #fff;
            font-size: 15px;
            color: #2F5C8F;
            font-weight: bold;
            border: 0px;
            line-height:45px;
            text-align:left;
            padding-left:10px;
        }
        .choose{
            width:300px;
            height:25px;
            vertical-align: middle;
        }
        a{
            text-decoration:none;
        }
        label{
            float:left;
            padding-top:5px;
        }
        #add{
            width: 50px;
            height: 25px;
            border-radius: 5px;
            color: #fff;
            margin:3px 0px 0px 10px;
            background-color: #2F8AE3;
        }
        .openFile input[type=file] {
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 18px;
            z-index: 99;
            opacity: 0;
        }
        #back{
            display: inline-block;
            width: 78px;
            height: 38px;
            line-height: 30px;
            /*margin-right: 30px;*/
            /*margin-top: 20px;*/
            /*margin-bottom: 20px;*/
            cursor: pointer;
            border-radius: 3px;
            background: url(../../img/vote/icon_back.png) no-repeat;
            padding-left: 7px;
            font-size: 14px;
        }
        .del{

        }
        .layui-upload-file{
            opacity: 0;
            margin-left: -70px;
            width: 70px;
        }
        .seeFild{
            margin-top: -8px;
        }
        .attchInfo{
            margin-top: -5px;
        }
    </style>
</head>
<body style="overflow:scroll;overflow-y: auto;overflow-x:hidden;">

<%--学生信息列表--%>
<div style="margin-top:20px">
    <div class="title">
      <%--  <img src="../../img/vote/item.png" alt="">--%>
        <span style="padding-left: 20px; "><fmt:message code="vote.th.projectManagement" /> | </span>
          <span style="font-size: medium" ><fmt:message code="vote.th.projectManagementDesc1" />“+{textarea}”，<fmt:message code="vote.th.projectManagementDesc2" />+{textarea}</span>
    </div>
</div>
<div>

    <div class="table">
        <table>
            <thead>
            <tr>
                <th style="width:30%;"><fmt:message code="main.th.option" /></th>
                <th style="width:30%;"><fmt:message code="email.th.file" /></th>
                <th style="width: 10%;"><fmt:message code="vote.th.NumberVotes" /></th>
                <th style="width:20%;"><fmt:message code="vote.th.Voters" /></th>
                <th style="width: 10%;"><fmt:message code="menuSSetting.th.menuSetting" /></th>
            </tr>
            </thead>
            <tbody class="item">

            </tbody>
            <tfoot>
            <tr>
                <td colspan="4">
                    <label for=""><fmt:message code="vote.th.addItem" />：</label>
                    <input type="text" class="choose add">
                    <button id="add"><fmt:message code="global.lang.add" /></button>
                    <div class="layui-form-item"  style="margin-top:15px">
                       <label class="layui-form-label"><fmt:message code="vote.th.votingAttachment" />：</label>
                        <div class="inbox layui-input-block" id="fieldInfo">
                            <a type="button" id="attachmentName" style="margin-left: 12px;margin-top: 6px;display: inline-block;">
                                <img src="/img/mg11.png" alt=""><fmt:message code="workflow.th.UploadAttachment" />
                            </a>
                            <div id="attachmentName0">
                            </div>
                        </div>
                    </div>

                </td>
            </tr>
            </tfoot>
        </table>
    </div>
    <div style="text-align:center;margin-top:20px;">
        <span id="back" ><fmt:message code="notice.th.return" /></span>
    </div>
</div>
</body>
<script type="text/javascript">
    var attachmentName;
    var attachmentName0;
    var attachId='';
    var attachName='';
    borrow="";
    var eqdata;
    var equipId;
    var opeation;   //定义判断编辑
    var fcrmId;   //选择设备表格的id
    var equippenter = parent.equipids   //调取父页面的下拉树id
    var typedata //定义的选择设备页面0数据表格的长度
    var filedata;
    var equipStatusCode;
    var factoryNo;
    var equipNo;
    var currdeptName;
    var fieldLength;
    var form;
    var projectData;
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }
    var parentDta=parent.trObj;
    var deptId;
    var deptIds;
    var flval;
    layui.use(['form', 'layedit','table', 'laydate','element','treeSelect','upload'], function() {
        form = layui.form
        var laydate = layui.laydate
        var table = layui.table;
        var layer = layui.layer;
        var upload = layui.upload;
        var $ = layui.jquery;



        form.on('select(borrowerdeptName)', function (data) {
            deptId = data.elem.value;
        });

        //上传图片
        fieldLength = $(".fieldHover").length;
        var uploadInst = upload.render({
            elem: '#attachmentName' //绑定元素
            , url: '/upload?module=vote'
            , accept: 'file'  //文件格式
            , auto: true
            , bindAction: '#uploadButton'
            , multiple: false
            , done: function (res) {
                // console.log(res)
                var attachObj = res.obj[0];
                attachmentName = attachObj.aid +'@'+ attachObj.ym +'_'+ attachObj.attachId;
                attachmentName0 = attachObj.attachName;
                var attachId=attachObj.aid +'@'+ attachObj.ym +'_'+ attachObj.attachId;
                // console.log(attachmentName)
                // console.log(attachmentName0)
                var attach = '<div id="'+ attachObj.attachId +'" style="margin-left:10px;padding: 10px 0 10px 0"><label class="seeFild"><img  src="/img/attachment_icon.png"/></label><label class="attchInfo" attachId="'+ attachId +'">'+ attachObj.attachName +'</label><a onclick="lookFile(\''+ attachId +'\')"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a><a href="/download?'+ attachObj.attUrl +'" type="button" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><a onclick="deleteAttachment(this,\''+ attachObj.attUrl +'\')" ><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/></a></div>'
                $("#fieldInfo").append(attach)
            }
        });



        $("#uploadButton").click(function () {
            uploadInst.reload();
        })

        form.on("select", function(data){
            if (data.value != "" && data.value > 0){
                $.each(projectData,function(index,pData){
                    if (data.value == pData.ctId){
                        $("#cId").val(pData.cId);
                        $("#cName").val(pData.cName);
                        $("#ivUnit").val(pData.cName);
                    }
                });
            }else{
                $("#cName").val("");
            }

        });

    })


    function lookFile(repalogId){//查看附件
        if (repalogId == undefined || repalogId == "") {
            layer.msg("<fmt:message code="vote.th.theFileHasBeenDamagedAndCannotBeViewed" />");
        } else {
            selectFile(repalogId,'vote');
        }
    }
    function downFile(repalogId){//下载附件
        if (repalogId == undefined || repalogId == "") {
            layer.msg("<fmt:message code="vote.th.theFileHasBeenDamagedAndCannotBeDownloaded" />");
        } else {
            window.location.href = "/vote/limsDownload?model=vote&attachId=" +repalogId
        }
    }

    function deleteFiel(repalogId){//删除附件
        if (repalogId == undefined || repalogId == "") {
            layer.msg("<fmt:message code="vote.th.theFileDoesNotExist" />");
        } else {
            layer.confirm('<fmt:message code="workflow.th.flowDeleteWarn2" />', {icon: 3, title:'<fmt:message code="common.th.prompt" />'}, function(index){
                $.post(
                    'deleteByPrimaryKey'
                    ,{fileId:repalogId},function(res){
                        if(res.code==0){
                            $("#fileId"+repalogId).hide()
                        }
                        layer.msg(res.msg)
                    }
                )
            })
        }
    }
    // 上传附件的删除方法
    function deleteAttachment(_this, attUrl) {
        layer.confirm('<fmt:message code="license.del.attach" />', function (index) {
            $.ajax({
                type: 'get',
                url: '/delete?' + attUrl,
                dataType: 'json',
                success: function (res) {
                    if (res.flag == true) {
                        layer.msg('<fmt:message code="workflow.th.delsucess" />', {icon: 6, time: 1000});
                        $(_this).parent('div').remove();
                    } else {
                        layer.msg('<fmt:message code="lang.th.deleSucess" />', {icon: 2, time: 1000});
                    }
                }
            })
        });
    }


    //保存
    $('#save').click(function(){
        var ctName=$("#ctName option:selected").text();
        var ctId=$("#ctName option:selected").val();
        var cId=$("input[name=cId]").val();
        var cName=$("input[name=cName]").val();
        var ivDate=$("input[name=ivDate]").val();
        var ivUnit=$("input[name=ivUnit]").val();
        var ivAmount=$("input[name=ivAmount]").val();
        if(isNaN(ivAmount)) {
            layer.msg("<fmt:message code="vote.th.theInvoicedAmountMustBeFilledInWithNumbers" />");
            return
        }
        var machineNo=$("input[name=machineNo]").val();

        $.ajax({
            url: "/fcrmInvoicer/insert?ivType=1",
            type: 'get',
            dataType:'json',
            contentType:'application/json;charset=utf-8',
            data:data,
            success:function(res) {
                console.log("res："+res+" "+JSON.stringify(res));
                console.log("data是："+data);
                if(res.flag){
                    layer.msg("<fmt:message code="diary.th.modify" />", {icon:1,time:1000}, function(){
                        var index = parent.layer.getFrameIndex(window.name);
                        parent.location.reload(); //刷新父页面
                        parent.layer.close(index);
                    });
                }else{
                    layer.msg('<fmt:message code="meet.th.SaveFailed" />',{icon:2})
                }

            },
            error:function(err){
                console.log("<fmt:message code="vote.th.anErrorHasOccurred" />" + err);
            }
        })
    })

   $(function(){
       function check(name){
           if(name == undefined){
               return ''
           }else{
               return name;
           }
       }

//       获取id
       var ItemId=$.GetRequest().ItemId;
//       获取项目内容返显
       function show(){
           $.ajax({
               url:'/voteItem/getVoteItemList',
               type:'post',
               data:{voteId:ItemId},
               dataType:'json',
               success:function(reg){
                   var data=reg.obj;
                   var str="";
                   for(var i=0;i<data.length;i++){
                       var data2=data[i].attachmentList;
                       var data3=data[i].attachmentName
                       str+='<tr id="'+data[i].itemId+'"> ' +
                           '<td> ' +
                           '<input type="text" value="'+data[i].itemName+'" class="choose"> ' +
                           '</td> ' +
                           '<td>'+function () {
                           debugger
                               if(data2!==undefined){
                                   var stra2 = '';
                                   for (var i = 0; i < data2.length; i++) {
                                       var fileExtension = data2[i].attachName.substring(data2[i].attachName.lastIndexOf(".") + 1, data2[i].attachName.length);//截取附件文件后缀
                                       var attName = encodeURI(data2[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                       var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                       var deUrl = data2[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + data2[i].size;

                                       stra2 += '<div class="dech" deUrl="' + deUrl + '">' +
                                           '<a NAME="' + data2[i].attachName + '*" style="text-decoration:none;margin-left:5px;color: #333;">' +
                                           '<img  src="/img/attachment_icon.png"/>' + data2[i].attachName + '</a>' +
                                           // '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' +
                                           '<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px">' +
                                           '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查看</a>' +
                                           '<a href="/download?'+ encodeURI(deUrl) +'" type="button" style="padding: 0 5px;">' +
                                           '<img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;color: #333;">下载</a>' ;

                                       stra2+= '<input type="hidden" class="inHidden" value="' + data2[i].aid + '@' + data2[i].ym + '_' + data2[i].attachId + ',"></div>';
                                   }
                                   return stra2
                               } else {
                                   return ""
                               }
                           }()+'</td> ' +
                           '<td>'+function () {
                               if(data[i].voteCount == undefined){
                                   return 0
                               }else{
                                   return data[i].voteCount
                               }
                           }()+'</td> ' +
                           '<td><div style="word-wrap:break-word;">'+function() {
                                if(data[i].anonymous==undefined) {
                                    return ""
                                }else{
                                    return data[i].anonymous;
                                }
                       }()+'</div></td> ' +
                               '<td> ' +
                           '<a href="javascript:;" class="update" style="color:#1772c0"><fmt:message code="depatement.th.modify" /></a> ' +
                               '<a href="javascript:;" class="del" style="color:#e01919;"><fmt:message code="global.lang.delete" /></a> ' +

                               '</td> ' +
                               '</tr>'
                           }
                   $('.item').html(str);
                   }

               })
           }

       show();

//       点击返回
       $('#back').on('click',function(){
           self.parent.document.getElementById('iframe').src='/vote/manage/voteList';
           $(self.parent.document.getElementById('iframe')).parent().prev().find('.nav li').eq(0).find('span').addClass('select').parent().siblings().find('span').removeClass('select')


       })
//       点击删除
       $('.item').on('click','.del',function(){
           var sId=$(this).parent().parent().attr('id');
           layer.confirm('<fmt:message code="workflow.th.flowDeleteWarn2" />', {
               btn: [' <fmt:message  code="global.lang.ok"/>', ' <fmt:message  code="depatement.th.quxiao"/>'], //按钮
               title: " <fmt:message code="common.th.prompt" />"
           },function(){
               $.ajax({
                   url:'/voteItem/deleteByItemId',
                   type:'post',
                   data:{itemId:sId},
                   dataType:'json',
                   success:function(){
                       layer.msg(' <fmt:message  code="workflow.th.delsucess"/>', {icon: 6});
                       show();
                   }
               })
           },function(){
               layer.close();
           })
       })
//       点击修改
       $('.item').on('click','.update',function(){
           var sId=$(this).parent().parent().attr('id');
           var text=$(this).parent().parent().find('.choose').val();
           if(text.replace(/(^\s*)|(\s*$)/g, "")==""){
               layer.msg(' <fmt:message code="vote.th.theVotingItemsCannotBeEmpty" />！', {icon: 2});
               return;
           }
           $.ajax({
               url:'/voteItem/updateVoteItem',
               type:'post',
               data:{itemId:sId,itemName:text},
               dataType:'json',
               success:function(){
                   layer.msg(' <fmt:message code="menuSSetting.th.editSuccess" />！', {icon: 6});
                   show();
               }
           })
       })

//       点击添加
        $('#add').on('click',function(){
            var text=$('.add').val();
            if(text.replace(/(^\s*)|(\s*$)/g, "")==""){
                layer.msg(' <fmt:message code="vote.th.theVotingItemsCannotBeEmpty" />！', {icon: 2});
                return;
            }
            $(".attchInfo").each(function(){
                attachId +=$(this).attr("attachid")+',';
                attachName += $(this).text()+',';
            });
            $.ajax({
                url:'/voteItem/addVoteItem',
                data:{itemName:text,voteId:ItemId,attachmentId:attachId,attachmentName:attachName},
                type:'post',
                dataType:'json',
                success:function(obj){
                    // fileuploadFn('#fileupload', $('#fileAll'));
                   if(obj.flag){
                       layer.msg(' <fmt:message code="depatement.th.Newsuccessfully" />！', {icon: 6});
                       show();
                       $('.add').val("");
                       window.location.reload();
                   }else{
                       layer.msg(obj.msg, {icon: 5});
                   }
                }

            })
        })
   })
</script>
</html>
