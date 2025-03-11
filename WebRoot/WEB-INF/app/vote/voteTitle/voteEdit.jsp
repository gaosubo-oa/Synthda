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
    <link rel="stylesheet" type="text/css" href="../../lib/laydate/need/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/dept/deptManagement.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/dept/new_news.css"/>
<%--    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=201908121454" type="text/javascript" charset="utf-8"></script>
    <title><fmt:message code="vote.th.ModifyVoting" /></title>
    <style>

        #search{
            margin-left: 360px;
            font-size: 16px;
        }
        #export{
            font-size: 16px;
        }
        .newNew tr td{
            border:none;
        }
        .layui-upload-file {
            display: none !important;
            opacity: .01;
        }
        .newNew .tableHead tr td{
            border:1px solid #c0c0c0;
        }
        .ban{
            width: 80px;
            height: 28px;
            padding-left: 10px;
        }
        .left{
            float:left;
        }
        .new_but{
            width:130px;
            background:#2F8AE3;
            height: 28px;
            line-height: 28px;
            border-radius: 4px;
            margin-left: 0px;
            padding-left: 4px;
            cursor: pointer;
            color:#fff;
        }
        .close_but{
            width:87px;
            background:url(../../img/vote/fabu.png) no-repeat;
            height: 30px;
            line-height:30px;
            border-radius: 4px;
            padding-left: 4px;
            cursor: pointer;
            color:#fff;
            margin-right:7px;
        }
        .box{
            width:300px;
            height:100px;
            background:#2F8AE3;
            color:#fff;
            line-height:100px;
            margin:0 auto;
            font-size:20px;
            text-align:center;
        }
        .addItem{
            width:100px;
            height:28px;
            line-height:28px;
            border-radius:5px;
        }
        .addChild{
            width:100px;
            height:28px;
            line-height:28px;
            border-radius:5px;
        }
        .back{
            width:50px;
            height:28px;
            line-height:28px;
            border-radius:5px;
        }

        #clearSave{
            background:url(../../img/vote/clearsave.png) no-repeat;
            background-size: 181px;
            color:#fff;
            width:181px;
            font-size:16px;
            height:30px;
            line-height:30px;
            padding-left: 22px;
        }
        #save{
            background:url(../../img/vote/saveBlue.png) no-repeat;
            color:#fff;
            line-height:30px;
            font-size:16px;
            width:91px;
            height: 30px;
            margin: 0px;
            padding-left: 11px;

        }
        #refull{
            color:#000;
            width: 87px;
            line-height:30px;
            height: 30px;
            font-size:16px;
            background: url("../../img/vote/new.png") no-repeat;
            margin: 0px;
            padding-left: 12px;

        }

        .addItem{
            background:url(../../img/vote/save.png) no-repeat;
            color:#fff;
            width: 142px;
            height:30px;
            cursor:pointer;
        }
        .addChild{
            background:url(../../img/vote/save.png) no-repeat;
            color:#fff;
            height:30px;
            width:139px;
            cursor:pointer;
        }
        .back {
            display: inline-block;
            width: 78px;
            height: 30px;
            line-height: 30px;
            cursor:pointer;
            /* margin-right: 30px; */
            /* margin-top: 20px; */
            /* margin-bottom: 20px; */
            cursor: pointer;
            border-radius: 3px;
            background: url(../../img/vote/icon_back.png) no-repeat;
            padding-left: 14px;
            font-size: 14px;
        }
        .sizeIn{
            display: none;
        }

    </style>
</head>
<body style="overflow:scroll;overflow-y: auto;overflow-x:hidden;">

<%--学生信息列表--%>

<div class="step1" style="display: block;margin-left: 10px;">
    <table class="newNews">
        <div class="nav_box clearfix">
            <div class="nav_t1"><img src="../../img/sys/new_dept.png"></div>
            <div class="nav_t2" class="news"><fmt:message code="vote.th.ModifyVoting" /></div>
        </div>
        <tbody>
        <tr>
            <td class="td_w blue_text">
                <fmt:message code="notice.th.title" /><span style="color: red">*</span>：
            </td>
            <td>
                <input class="td_title1" type="text" placeholder="" id="studentNo"/>
            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                <fmt:message code="vote.th.Publication(Department)" />：
            </td>
            <td>
                <textarea name="" id="deptment"  user_id="" value="" style="width: 230px" disabled></textarea>
                <a href="javascript:;" id="selectDept" style="color:#1772c0"><fmt:message code="global.lang.add" /></a>
                <a href="javascript:;" id="clearDept" style="color:#1772c0"><fmt:message code="global.lang.empty" /></a>
            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                <fmt:message code="vote.th.Release(role)" />：
            </td>
            <td>
                <textarea name="" id="role"  user_id="" style="width: 230px" disabled></textarea>
                <a href="javascript:;" id="selectPriv" style="color:#1772c0"><fmt:message code="global.lang.add" /></a>
                <a href="javascript:;" id="clearPriv" style="color:#1772c0"><fmt:message code="global.lang.empty" /></a>
            </td>
        </tr>

        <tr>
            <td class="blue_text">
                <fmt:message code="vote.th.Release(personnel)" />：
            </td>
            <td>
                <textarea name="" id="userDuser"  user_id="" style="width: 230px" disabled></textarea>
                <a href="javascript:;" id="selectUser" style="color:#1772c0"><fmt:message code="global.lang.add" /></a>
                <a href="javascript:;" id="clearUser" style="color:#1772c0"><fmt:message code="global.lang.empty" /></a>
            </td>
        </tr>
        <tr>
            <td class="blue_text">
                <fmt:message code="vote.th.View(roles)" />：
            </td>
            <td>
                <textarea name="" id="seeRole"  user_id="" style="width: 230px" disabled></textarea>
                <a href="javascript:;" id="selectPriv1" style="color:#1772c0"><fmt:message code="global.lang.add" /></a>
                <a href="javascript:;" id="clearPriv1" style="color:#1772c0"><fmt:message code="global.lang.empty" /></a>
            </td>
        </tr>
        <tr>
            <td class="blue_text">
                <fmt:message code="vote.th.View(personnel)" />：
            </td>
            <td>
                <textarea name="" id="seeUser"  user_id="" style="width: 230px" disabled></textarea>
                <a href="javascript:;" id="selectUser1" style="color:#1772c0"><fmt:message code="global.lang.add" /></a>
                <a href="javascript:;" id="clearUser1" style="color:#1772c0"><fmt:message code="global.lang.empty" /></a>
            </td>
        </tr>
        <tr>
            <td class="blue_text">
                <fmt:message code="vote.th.VotingDescription" />：
            </td>
            <td>
                <textarea name="" cols="60" rows="5" id="voteTitle"></textarea>
            </td>
        </tr>
        <tr>
            <td class="blue_text">
                <fmt:message code="notice.th.type" />：
            </td>
            <td>
                <select class="type" id="type" type="text" placeholder="">
                    <option id="only" value="0"><fmt:message code="vote.th.Radio" /></option>
                    <option id="double" value="1"><fmt:message code="vote.th.Multiselect" /></option>
                    <option id="textarea" value="2"><fmt:message code="vote.th.TextEntry" /></option>
                </select>
                <input type="text" style="width: 50px;height: 21px;margin-left: 20px;" name="minNum" class="sizeIn" placeholder="<fmt:message code="vote.th.minimumValue" />"/>
                <span class="sizeIn">-</span>
                <input type="text" style="width: 50px;height: 21px;" class="sizeIn" name="maxNum" placeholder="<fmt:message code="vote.th.maximumValue" />"/>
            </td>
        </tr>
        <tr>
            <td class="blue_text">
                <fmt:message code="vote.th.ViewVoteResults" />：
            </td>
            <td>
                <select  id="seeResult" class="result">
                    <option value="0"><fmt:message code="vote.th.Allow" /></option>
                    <option value="1"><fmt:message code="vote.th.before" /></option>
                    <option value="2"><fmt:message code="vote.th.notAllowed" /></option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="blue_text">
                <fmt:message code="vote.th.secretBallot" />：
            </td>
            <td>
                <input type="checkbox" class="niName">
                <span><fmt:message code="vote.th.AllowAnonymousVoting" /></span>
            </td>
        </tr>
        <tr>
            <td class="blue_text">
                <fmt:message code="notice.th.validity" />：
            </td>
            <td>
                <span>
                    <fmt:message code="notice.th.effectivedate" />：
                </span>
                <input class="sentTime" id="sentTime" type="text" placeholder="" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss',max: $('#endDate').val()})" style="width: 160px"/><fmt:message code="vote.th.EmptyEffect" />
                <br/>
                <span>
                    <fmt:message code="notice.th.endDate" />：
                </span>
                <input class="endDate" id="endDate" type="text" placeholder="" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss',min: $('#sentTime').val()})" style="width: 160px"/><fmt:message code="notice.th.null" />
            </td>
        </tr>
        <tr>
            <td class="blue_text">
                <fmt:message code="notice.th.top" />：
            </td>
            <td>
                <input class="top"  type="checkbox" placeholder=""/><fmt:message code="vote.th.important" />
            </td>
        </tr>
        <tr>
            <td class="blue_text"><fmt:message code="global.th.fileup" />：</td>
            <td><div id="fieldInfo">
                <a type="button" id="attachmentName" style="display: inline-block;color: blue">
                    <img src="/img/mg11.png" alt=""><fmt:message code="workflow.th.UploadAttachment" />
                </a>
                <div id="attachmentName0">
                </div>
            </div></td>
        </tr>
        <tr class="business">
            <td class="blue_text">
                <fmt:message code="notice.th.reminder" />：
            </td>
            <td>
                <input  type="checkbox" id="remind" placeholder=""/><fmt:message code="notice.th.remindermessage" />
                <input  type="checkbox" id="smsRemind" placeholder=""/><fmt:message code="vote.th.UseRemind" />
            </td>
        </tr>
        </tbody>

        <div>
            <tr style="text-align:center">
                <td colspan="2">
                    <%--<button type="button" class="close_but" id="publish"><fmt:message code="global.lang.publish" /></button>--%>
                    <button type="button" class="new_but" id="clearSave"><fmt:message code="vote.th.DataEmpty" /></button>
                    <button type="button" class="close_but" id="save"><fmt:message code="global.lang.save" /></button>
                    <button type="button" class="close_but" id="refull"><fmt:message code="global.lang.refillings" /></button>
                </td>
            </tr>
        </div>
    </table>
    <div class="success" style="display:none">
        <div class="box">
            <fmt:message code="vote.th.successfullySaved" />！
        </div>
        <div style="text-align:center;margin-top:20px">
            <button class="addItem"><fmt:message code="vote.th.AddVotingItems" /></button>
            <button class="back"><fmt:message code="notice.th.return" /></button>
        </div>
    </div>
</div>
</body>

<script type="text/javascript">
    var attachmentName;
    var attachmentName0;
    var attachId='';
    var attachName='';
    layui.use(['upload'], function() {
        var upload = layui.upload;
        //上传图片
        fieldLength = $(".fieldHover").length;
        var uploadInst = upload.render({
            elem: '#attachmentName' //绑定元素
            , url: '/upload?module=voteTitle'
            , accept: 'file'  //文件格式
            , auto: true
            , bindAction: '#uploadButton'
            , multiple: false
            , done: function (res) {
                var attachObj = res.obj[0];
                attachmentName = attachObj.aid + '@' + attachObj.ym + '_' + attachObj.attachId;
                attachmentName0 = attachObj.attachName;
                var attachId = attachObj.aid + '@' + attachObj.ym + '_' + attachObj.attachId;
                var attach = '<div id="' + attachObj.attachId + '"><label class="seeFild"><img  src="/img/attachment_icon.png"/></label><label class="attchInfo" attachId="' + attachId + '">' + attachObj.attachName + '</label><a onclick="lookFile(\'' + attachId + '\')"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a><a href="/download?' + attachObj.attUrl + '" type="button" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><a onclick="deleteAttachment(this,\'' + attachObj.attUrl + '\')" ><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/></a></div>'
                $("#fieldInfo").append(attach)
            }
        });

    });
    $("#uploadButton").on('click',function () {
        uploadInst.reload();
    })
    $("#type").on('change',function(){
        if($(this).val()==1){
            $('.sizeIn').show();
        }else{
            $('.sizeIn').hide();
        }
    });
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


    function lookFile(repalogId){//查看附件
        if (repalogId == undefined || repalogId == "") {
            layer.msg("<fmt:message code="vote.th.theFileHasBeenDamagedAndCannotBeViewed" />");
        } else {
            selectFile(repalogId,'voteTitle');
        }
    }
    //点击修改后，调详情接口
    $(function () {
        // 查询提醒权限
        $.ajax({
            type:'get',
            url:'/smsRemind/getRemindFlag',
            dataType:'json',
            data:{
                type:11
            },
            success:function (res) {
                if(res.flag){
                    if(res.obj.length>0){
                        var data = res.obj[0];
                        // 是否默认发送
                        if(data.isRemind=='0'){
                            $('#remind').prop("checked", false);
                        }else if(data.isRemind=='1'){
                            $('#remind').prop("checked", true);
                        }
                        // 是否手机短信默认提醒
                        if(data.isIphone=='0'){
                            $('#smsRemind').prop("checked", false);
                        } else if (data.isIphone=='1'){
                            $('#smsRemind').prop("checked", true);
                        }
                        // 是否允许发送事务提醒
                        if(data.isCan=='0'){
                            $('#remind').prop("checked", false);
                            $('#smsRemind').prop("checked", false);
                            $('.business').hide();
                        }

                    }
                }
            }
        })

        var sId = $.GetRequest().editId;
        $.ajax({
            url: '/vote/manage/getChildDetail',
            type: 'post',
            dataType: 'json',
            data: {voteId: sId},
            success: function (reg) {
                var data = reg.object;
                $('#studentNo').val(data.subject);
                $('#deptment').html(data.toId);
                $('#role').html(data.privId);

                $('#userDuser').html(data.usersName);
                $('#userDuser').attr('user_id',data.userId);

                $('#seeRole').html(data.viewResultPrivId);

                $('#seeUser').html(data.viewResultUserName);
                $('#seeUser').attr('user_id',data.viewResultUserId);

                $('#voteTitle').val(data.content);
                $('#type').val(data.type);
                if(data.type==1){
                    $('.sizeIn').show();
                    $('[name="minNum"]').val(data.minNum);
                    $('[name="maxNum"]').val(data.maxNum);
                }
                $('#seeResult').val(data.viewPriv);
                $('#sentTime').val(data.sendTime);
                $('#endDate').val(data.endDate);
                if (data.anonymity == 0) {
                     $('.niName').prop('checked', false);
                } else {
                     $('.niName').prop('checked', true);
                }

                if (data.top == 0) {
                    $('.top').prop('checked', false);
                } else {
                     $('.top').prop('checked', true);
                }
                if (data.remind == '0') {
                    $('#remind').prop('checked', false);
                } else {
                    $('#remind').prop('checked', true);
                }
                if (data.smsRemind == '0') {
                    $('#smsRemind').prop('checked', false);
                } else {
                    $('#smsRemind').prop('checked', true);
                }
                var data1 = data.attachment?data.attachment:[];
                var stra2 = '';
                for (var i = 0; i < data1.length; i++) {
                    // var attUrl=
                    var fileExtension = data1[i].attachName.substring(data1[i].attachName.lastIndexOf(".") + 1, data1[i].attachName.length);//截取附件文件后缀
                    var attName = encodeURI(data1[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                    var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                    var deUrl = data1[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + data1[i].size;
                    var attachId=data1[i].aid +'@'+ data1[i].ym +'_'+ data1[i].attachId;
                    stra2 +=
                        '<div id="'+  data1[i].attachId +'" style="padding: 10px 0 10px 0"><label class="seeFild"><img  src="/img/attachment_icon.png"/></label>' +
                        '<label class="attchInfo" attachId="'+ data1[i].aid +'@'+ data1[i].ym +'_'+ data1[i].attachId+'">'+  data1[i].attachName +'</label><a onclick="lookFile(\''+attachId +'\')"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a><a href="/download?'+  data1[i].attUrl.slice(0,12)+"MODULE="+"voteTitle&" + data1[i].attUrl.slice(24) +'" type="button" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>'

                    stra2+='<a onclick="deleteAttachment(this,\''+ data1[i].attUrl.slice(0,12)+"MODULE="+"voteTitle&" + data1[i].attUrl.slice(24) +'\')" ><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/></a>';

                    stra2+= '<input type="hidden" class="inHidden" value="' + data1[i].aid + '@' + data1[i].ym + '_' + data1[i].attachId + ',"></div>';
                }
                if(stra2.length >0){
                    $("#attachmentName").attr("display","none");
                    $("#fieldInfo").append(stra2);
                }
            }
        })

        function save(){
            var minNum='';
            var maxNum='';
            $(".attchInfo").each(function(){
                attachId +=$(this).attr("attachid")+',';
                attachName += $(this).text()+',';
            });
            console.log($(this))
            console.log(attachId)
            if($('#type option:selected').val()==1){
                minNum= $('[name="minNum"]').val();
                maxNum=$('[name="maxNum"]').val();
            }else {
                minNum='';
                maxNum='';
            }
            var data = {
                voteId: sId,
                subject: $('#studentNo').val(),
                toId: $('#deptment').attr('deptid'),
                privId: $('#role').attr('userpriv'),
                userId: $('#userDuser').attr('user_id'),
                viewResultPrivId: $('#seeRole').attr('userpriv'),
                viewResultUserId: $('#seeUser').attr('user_id'),
                content: $('#voteTitle').val(),
                type: $('#type option:selected').val(),
                viewPriv: $('#seeResult option:selected').val(),
                minNum: minNum,
                maxNum: maxNum,
                anonymity: function () {
                    if ($('.niName').prop('checked') == false) {
                        return '0';
                    } else {
                        return '1';
                    }
                }(),
                sendTime: $('#sentTime').val(),
                endDate: $('#endDate').val(),
                top: function () {
                    if ($('.top').prop('checked') == false) {
                        return '0';
                    } else {
                        return '1';
                    }
                }(),
                attachmentId: attachId,
                attachmentName: attachName,
                remind:function(){
                    if($('#remind').prop('checked')==false){
                        return '0';
                    }else {
                        return '1';
                    }
                },
                smsRemind:function(){
                    if($('#smsRemind').prop('checked')==false){
                        return '0';
                    }else {
                        return '1';
                    }
                }
            }
            $.ajax({
                type: 'post',
                url: '/vote/manage/updateVoteTitle',
                dataType: 'json',
                data: data,
                success: function (res) {
                    if (res.flag) {
                        $.layerMsg({content: '<fmt:message code="depatement.th.Modifysuccessfully" />！', icon: 1});
                        if($('#type option:selected').val()!=2){
                            $('.success').show();
                            $('.newNews').hide();
                        }else{
                            self.parent.document.getElementById('iframe').src='/vote/manage/voteList';
                        }

                    } else {
                        $.layerMsg({content: '<fmt:message code="depatement.th.modifyfailed" />！', icon: 2});
                    }
                }
            })
        }
        function clearSave(){
            var minNum='';
            var maxNum='';
            if($('#type option:selected').val()==1){
                minNum= $('[name="minNum"]').val();
                maxNum=$('[name="maxNum"]').val();
            }else {
                minNum='';
                maxNum='';
            }
            var data = {
                voteId: sId,
                subject: $('#studentNo').val(),
                toId: $('#deptment').attr('deptid'),
                privId: $('#role').attr('userpriv'),
                userId: $('#userDuser').attr('user_id'),
                viewResultPrivId: $('#seeRole').attr('userpriv'),
                viewResultUserId: $('#seeUser').attr('user_id'),
                content: $('#voteTitle').val(),
                type: $('#type option:selected').val(),
                viewPriv: $('#seeResult option:selected').val(),
                minNum: minNum,
                maxNum: maxNum,
                anonymity: function () {
                    if ($('.niName').prop('checked') == false) {
                        return '0';
                    } else {
                        return '1';
                    }
                }(),
                sendTime: $('#sentTime').val(),
                endDate: $('#endDate').val(),
                top: function () {
                    if ($('.top').prop('checked') == false) {
                        return '0';
                    } else {
                        return '1';
                    }
                }(),
                attachmentId: $('#attchment').val(),
                attachmentName: $('.selectFile').val(),
                remind:function(){
                    if($('#remind').prop('checked')==false){
                        return '0';
                    }else {
                        return '1';
                    }
                },
                smsRemind:function(){
                    if($('#smsRemind').prop('checked')==false){
                        return '0';
                    }else {
                        return '1';
                    }
                }
            }
            $.ajax({
                type: 'post',
                url: '/vote/manage/clearSave',
                dataType: 'json',
                data: data,
                success: function (res) {
                    if (res.flag) {
                        $.layerMsg({content: '<fmt:message code="depatement.th.Modifysuccessfully" />！', icon: 1});
                        if($('#type option:selected').val()!=2){
                            $('.success').show();
                            $('.newNews').hide();
                        }else{
                            self.parent.document.getElementById('iframe').src='/vote/manage/voteList';
                        }

                    } else {
                        $.layerMsg({content: '<fmt:message code="depatement.th.modifyfailed" />！', icon: 2});
                    }
                }
            })
        }
        $('#save').on('click',function () {
                if($('.td_title1').val().replace(/(^\s*)|(\s*$)/g, "")==""){
                    $.layerMsg({content: '<fmt:message code="event.th.titleCannotEmpty" />', icon: 2});
                }else if($('#deptment').val()==""&&$('#role').val()==""&&$('#userDuser').val()==""){
                    $.layerMsg({content: '<fmt:message code="vote.th.thereIsAtLeastOneReleaseScope" />！', icon: 2});
                }else{
                    save();
                }
            });


        //点击发布，改变状态值，接口不改变
        $('#publish').on('click',function () {
            $(".attchInfo").each(function(){
                attachId +=$(this).attr("attachid")+',';
                attachName += $(this).text()+',';
            });
            console.log($(this))
            console.log(attachId)
            var data = {
                voteId: sId,
                subject: $('#studentNo').val(),
                toId: $('#deptment').attr('deptid'),
                privId: $('#role').attr('userpriv'),
                userId: $('#user').attr('user_id'),
                viewResultPrivId: $('#seeRole').attr('userpriv'),
                viewResultUserId: $('#seeUser').attr('user_id'),
                content: $('#voteTitle').val(),
                type: $('#type option:selected').val(),
                viewPriv: $('#seeResult option:selected').val(),
                anonymity: function () {
                    if ($('.niName').prop('checked') == false) {
                        return '0';
                    } else {
                        return '1';
                    }
                }(),
                sendTime: $('#sentTime').val(),
                endDate: $('#endDate').val(),
                publish:1,
                top: function () {
                    if ($('.top').prop('checked') == false) {
                        return '0';
                    } else {
                        return '1';
                    }
                }(),
                attachmentId:attachId,
                attachmentName: attachName,
            }
            $.ajax({
                type: 'post',
                url: '/vote/manage/updateVoteTitle',
                dataType: 'json',
                data: data,
                success: function (res) {
                    if (res.flag) {
                        $.layerMsg({content: '<fmt:message code="depatement.th.Modifysuccessfully" />！', icon: 1});
                        $('.success').show();
                        $('.newNews').hide();
                    } else {
                        $.layerMsg({content: '<fmt:message code="depatement.th.modifyfailed" />！', icon: 2});
                    }
                }
            })

        })


            //添加选人控件
            $("#selectUser").on("click", function () {//选人员控件
                user_id = 'userDuser';
                $.popWindow("../../common/selectUser");
            });
            $("#selectPriv").on("click", function () {//选角色控件
                priv_id = 'role';
                $.popWindow("../../common/selectPriv?1");
            });
            $("#selectDept").on("click", function () {//选部门控件
                dept_id = 'deptment';
                $.popWindow("../../common/selectDept?allDept=1");
            });
            //清除数据
            function clearUser(){
                $('#userDuser').attr('user_id', '');
                $('#userDuser').attr('userprivname', '');
                $('#userDuser').attr('dataid','');
                $('#userDuser').val('');
            }
            function clearRole(){
                $('#role').attr('userpriv','');
                $('#role').attr('privid','');
                $('#role').attr('dataid', '');
                $('#role').val('');
            }
            function clearDept(){
                $('#deptment').attr('deptid','');
                $('#deptment').attr('dataid', '');
                $('#deptment').attr('deptno','');
                $('#deptment').val('');
            }
            function clearproRole(){
                $('#seeRole').attr('user_id', '');
                $('#seeRole').attr('userprivname', '');
                $('#seeRole').attr('dataid','');
                $('#seeRole').val('');
            }
            function clearproUser(){
                $('#seeUser').attr('userpriv','');
                $('#seeUser').attr('privid','');
                $('#seeUser').attr('dataid', '');
                $('#seeUser').val('');
            }

            $('#clearUser').on('click',function () { //清空人员
                clearUser();
            });
            $('#clearPriv').on('click',function () { //清空角色
                clearRole();
            });
            $('#clearDept').on('click',function () { //清空部门
                clearDept();
            });
//            权限清空
            $('#clearPriv1').on('click',function () { //清空角色
                clearproRole();
            });
            $('#clearUser1').on('click',function () { //清空人员
                clearproUser();
            });
            //查看权限控件添加
            $("#selectUser1").on("click", function () {//选人员控件
                user_id = 'seeUser';
                $.popWindow("../../common/selectUser");
            });
            $("#selectPriv1").on("click", function () {//选角色控件
                priv_id = 'seeRole';
                $.popWindow("../../common/selectPriv?1");
            });
//清空所有内容
            function clearAll(){
                $('#studentNo').val("");
                clearUser();
                clearDept();
                clearRole();
                clearproRole();
                clearproUser();
                $('#voteTitle').val("");
                $('#sentTime').val('');
                $('#endDate').val('');
                $('#noName').prop('checked',false);
                $('#top').prop('checked',false);
            }
//            点击重填
        $('#refull').on('click',function(){
            clearAll();
        })
//        清空数据并保存
            $('#clearSave').on('click',function(){
                if($('.td_title1').val().replace(/(^\s*)|(\s*$)/g, "")==""){
                    $.layerMsg({content: '<fmt:message code="event.th.titleCannotEmpty" />', icon: 2});
                }else if($('#deptment').val()==""&&$('#role').val()==""&&$('#userDuser').val()==""){
                    $.layerMsg({content: '<fmt:message code="vote.th.thereIsAtLeastOneReleaseScope" />！', icon: 2});
                }else{
                    clearSave();
                }

            })

//        点击添加投票项目
        $('.addItem').on('click',function(){
            self.parent.document.getElementById("iframe").src='/vote/manage/updateVote?ItemId='+sId;
        })
//        点击添加子投票
        $('.addChild').on('click',function(){
            self.parent.document.getElementById("iframe").src='/vote/manage/voteChild';
            document.cookie="childId="+sId;
        })
//        点击返回
        $('.back').on('click',function(){
            self.parent.document.getElementById("iframe").src='/vote/manage/voteList';
        })

    })

    var start = {
        elem: '#STAFF_BIRTH',
        format: 'YYYY-MM-DD',
        istime: true,
        istoday: false,
        choose: function(datas){
         end.min = datas; //开始日选好后，重置结束日的最小日期
         end.start = datas; //将结束日的初始值设定为开始日
         }
        //回调函数
    };
    laydate(start);

    var end = {
        format: 'YYYY/MM/DD hh:mm:ss',
        istime: true,
        istoday: false,
        choose: function(datas){
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };

</script>
</html>
