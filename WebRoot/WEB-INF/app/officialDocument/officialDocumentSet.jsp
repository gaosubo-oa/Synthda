<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/27
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><fmt:message code="doc.th.TemplateSetting"/></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">

    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/js/jquery/jquery-validate.js"></script>
    <script src="/lib/validate-mothods.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>
        .headTop {
            position: relative;
        }
    </style>
</head>
<body>
<div class="head w clearfix">
    <ul class="index_head">
        <li data-type="0">
            <span class="one headli1_1">word模板</span>
            <img class="headli1_2" src="../../img/twoth.png" alt=""/>
        </li>
        <li data-type="1">
            <span class="headli1_1">网页模板</span>
            <img class="headli1_2" src="../../img/twoth.png" alt=""/>
        </li>
    </ul>
</div>
<div class="headTop">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_templateSet.png" alt="">
    </div>
    <div class="divTitle">
        <fmt:message code="doc.th.TemplateSetting"/>
    </div>
    <a href="javascript:void(0)" class="new_xinjiano new_xinjianoTwo" data-id="1"><fmt:message code="global.lang.new"/></a>
</div>
<div style="margin: 0 auto;margin-top: 25px;height: 60px;width: 97%;" class="clearfix">
    <label class="fl" style="margin-top: 16px;">
        <select name="dispatchType" id="" style="float:left;">
            <option value=""><fmt:message code="hr.th.PleaseSelect"/></option>
            <option value="1"><fmt:message code="doc.th.WordTemplate"/></option>
            <option value="2"><fmt:message code="doc.th.RedTemplate"/></option>
        </select>
        <button  type="button" class="Query fl"><fmt:message code="global.lang.query"/></button>
    </label>


    <div id="dbgz_page" class="M-box3 fr">

    </div>
</div>

<div class="pagediv" style="margin: 0 auto;width: 97%;">
    <table>
        <thead>
        <tr>
            <th style="min-width: 40px"><fmt:message code="workflow.th.Serial"/></th>
            <th style="min-width: 110px"><fmt:message code="sms.th.TemplateName"/></th>
            <th style="min-width: 85px"><fmt:message code="sup.th.SubordinateClassification"/></th>
            <th style="min-width: 550px"><fmt:message code="doc.th.ScopeAuthorization"/></th>
            <th style="min-width: 95px"><fmt:message code="notice.th.operation"/></th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>



<script>
    var user_id='';
    var dept_id='';
    var priv_id='';
    $('.index_head').on('click', 'li', function () {
        // 设置样式
        $('.index_head span').removeClass("one")
        $(this).children("span").addClass("one");
        if($(this).attr('data-type')=='0'){
            window.location.href = '/document/officialDocumentSet'
        }else if($(this).attr('data-type')=='1'){
            window.location.href = '/htmlModel/index'
        }
    });
    function validform() {
        return  $("#datasave").validate({
            checkStart: true,
            focusInvalid: false,
            errorPlacement: function (error, element) { //错误信息位置设置方法
                layer.tips(error[0].innerText, $(element), {time: 2000, tipsMore: true});
            },
            rules: {//验证那个东西
                name:{
                    required:true
                },
                categoryId:{
                    required:true
                }
            },
            messages: {//提示信息
                name:{
                    required:'<fmt:message code="doc.th.ThisRequired"/>'
                },
                categoryId:{
                    required:'<fmt:message code="doc.th.ThisRequired"/>'
                }
            }
        })
    }

    
    function regTitle(title) {
        if(title==''){
            return true;
        }
        if(title.indexOf('.doc')==-1&&title.indexOf('.docx')==-1&&title.indexOf('.dot')==-1&&title.indexOf('.dotx')==-1){
            return false;
        }else {
            return true;
        }
        
    }
    function changeFile(me) {
        $('[name="deleteFlag"]').val(2)
        console.log(me.files[0].name)
        $.ajax({
            url: "/upload?module=template",
            data: new FormData($("#datasave")[0]),
            type: "POST",
            processData: false,
            contentType: false,
            dataType: "json",
            success: function (res) {
                if (res.flag) {
                    if (res.obj.length>0) {
                        var attachmentId = '',
                            attachmentName = '';
                        var deUrl = '';
                        var fileExtension='';
                        var attName = '';
                        var fileExtensionName='';
                        res.obj.forEach(function(item){
                            attachmentId += item.aid + '@' + item.ym + '_' + item.attachId + ',';
                            attachmentName += item.attachName + '*';
                            fileExtension=item.attachName.substring(item.attachName.lastIndexOf(".")+1,item.attachName.length);//截取附件文件后缀
                            attName = encodeURI(item.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                            fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                            deUrl = item.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+item.size;
                        });
                        $('#fileA').attr('href', '/download?'+encodeURI(deUrl)+' NAME=' + attachmentName);
                        $('input[name="attachmentId"]', $("#datasave")).val(attachmentId);
                        $('input[name="attachmentName"]', $("#datasave")).val(attachmentName);
                        $('#fileA').html(me.files[0].name)
                        $('#fileA').siblings('b').show()
                    }
                }
            },
            error: function (json) {
            }
        });
    }




    $(document).delegate('.new_xinjianoTwo','click',function () {
        var str='',url='',me=this;
        if($(this).attr('data-id')==1){
            str='<fmt:message code="doc.th.NewTemplate"/>'
            url='/template/add'
            
        }else {
            str='<fmt:message code="doc.th.EditTemplate"/>'
            url='/template/update'
        }
        layer.open({
            title:str,
            btn:['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'],
            area:['600px','400px'],
            content:'<form id="datasave" action="'+url+'" method="post" enctype="multipart/form-data">' +
            '<input type="hidden" name="deleteFlag" >' +
            '<input type="hidden" name="type" value="office">' +
            '<input type="hidden" name="id" >' +
            '<input type="hidden" name="attachmentId" value="">'+
            '<input type="hidden" name="attachmentName" value="">'+
            '<ul class="formUl">' +
            '<li class="clearfix"><label><b>*</b><fmt:message code="sms.th.TemplateName"/>:</label>' +
            '<input type="text" name="name" placeholder="<fmt:message code="doc.th.PleaseEnterTemplateName"/>">' +
            '</li>' +
            '<li class="clearfix"><label><b>*</b><fmt:message code="sup.th.SubordinateClassification"/>:</label>' +
            '<select name="categoryId" id="">' +
            '<option value=""><fmt:message code="hr.th.PleaseSelect"/></option>' +
            '<option value="1"><fmt:message code="doc.th.WordTemplate"/></option>' +
            '<option value="2"><fmt:message code="doc.th.RedTemplate"/></option>' +
            '</select>' +
            '</li>' +
            '<li class="clearfix"><label>排序号:</label>' +
                '<input type="text" name="sortNo" placeholder="请输入排序号（只能为数字）">' +
            '</li>' +
         /*   '<li class="clearfix"><label><fmt:message code="doc.th.DispatchWord"/>:</label>' +
            '<select name="" id="">' +
            '<option value=""><fmt:message code="hr.th.PleaseSelect"/></option>' +
            '</select>' +
            '</li>' +*/
            '<li class="clearfix"><label><fmt:message code="netdisk.th.Scope(personnel)"/>:</label>' +
            '<textarea name="" id="query_userId" readonly="readonly" placeholder="<fmt:message code="doc.th.authorisedOfficer"/>" cols="30" rows="10"></textarea>' +
            '<div class="btntext">' +
            '<a href="javascript:void(0)" style="color: #4898d5;margin-bottom: 5px" data-num="1" class="choose"><fmt:message code="global.lang.select"/></a>' +
            '<a href="javascript:void(0)" class="clearUser" style="color: darkred;"><fmt:message code="global.lang.empty"/></a>' +
            '<input type="hidden" name="privUser">' +
            '</div>' +
            '</li>' +
            '<li class="clearfix"><label><fmt:message code="netdisk.th.ScopeAuthorization"/>:</label>' +
            '<textarea name="" id="department" readonly="readonly" placeholder="<fmt:message code="doc.th.LicensingAuthority"/>" cols="30" rows="10"></textarea>' +
            '<div class="btntext">' +
            '<a href="javascript:void(0)" style="color: #4898d5;margin-bottom: 5px" data-num="2" class="choose"><fmt:message code="global.lang.select"/></a>' +
            '<a href="javascript:void(0)" class="clearDept" style="color: darkred;"><fmt:message code="global.lang.empty"/></a>' +
            '<input type="hidden" name="privOrg">' +
            '</div>' +
            '</li>' +
            '<li class="clearfix"><label><fmt:message code="netdisk.th.Scope(role)"/>:</label>' +
            '<textarea name="" id="theScopeOf" readonly="readonly" placeholder="<fmt:message code="doc.th.AuthorizedRole"/>" cols="30" rows="10"></textarea>' +
            '<div class="btntext">' +
            '<a href="javascript:void(0)" style="color: #4898d5;margin-bottom: 5px" data-num="3" class="choose"><fmt:message code="global.lang.select"/></a>' +
            '<a href="javascript:void(0)" class="clearPriv" style="color: darkred;"><fmt:message code="global.lang.empty"/></a>' +
            '<input type="hidden" name="privRole">' +
            '</div>' +
            '</li>' +
            '<li class="clearfix"><label><fmt:message code="sms.th.templateFile"/>:</label>' +
            '<div class="btntext" >' +
            '<a href="javascript:void(0)" id="fileDownload" style="display: inline-block;position: relative;' +
            'padding: 2px 10px;background: #4898d5;border-radius: 9px;margin-right: 10px;color: #fff;"> <fmt:message code="doc.th.SelectLocally"/>' +
            '<input type="file" name="file" onchange="changeFile(this)" style="position: absolute;width: 100%;top: 0px;left: 0px;opacity: 0;z-index: 100;"></a>' +
            '<a href="javascript:void(0)" style="display: inline-block;' +
            'padding: 2px 10px;background: #4898d5;border-radius: 9px;margin-right: 10px;color: #fff;display:none;"><fmt:message code="doc.th.SelectCabinet"/></a>' +
            '<a href="javascript:void(0)" style="margin-top: 10px;"><fmt:message code="doc.th.Format"/></a>' +
            '</div>' +
            '</li>' +
            '<li class="clearfix"><label><fmt:message code="doc.th.file"/>:</label>' +
            '<div class="btntext" >' +
            '<a href="javascript:void(0)" id="fileA" style="padding: 2px 10px;display: inline-block; color: blue;"></a>' +
            '<b style="color: red;display: none;cursor: pointer">x</b>' +
            '</div>' +
            '</li>' +
            '</ul>' +
            '</form>',
            success:function () {
                validform();
                $('#fileA').siblings('b').click(function () {
                    $('input[name="attachmentId"]', $("#datasave")).val('');
                    $('input[name="attachmentName"]', $("#datasave")).val('');
                    if($(me).attr('data-id')!=1){
                        $('[name="deleteFlag"]').val(1)
                        var file = $('[name="file"]')
                        file.after(file.clone().val(""));
                        file.remove();
                        $(this).parent().find('a').html('')
                        $(this).hide()
                    }else {
                        var file = $('[name="file"]')
                        file.after(file.clone().val(""));
                        file.remove();
                        console.log($('[name="file"]').val())
                        console.log($('[name="file"]'))
                        $(this).parent().find('a').html('')
                        $(this).hide()
                    }

                })

                if($(me).attr('data-id')!=1){
                    $('[name="id"]').val($(me).attr('data-val'))
                    $('[name="name"]').val($(me).parent().parent().find('td').eq(1).text())
                    $('[name="categoryId"]').find('option').each(function (i,n) {
                        if($(this).val()==$(me).parent().parent().find('td').eq(2).find('input').val()){
                            $(this).attr('selected','selected')
                            return false;
                        }
                    })
                    $('[name="sortNo"]').val($(me).parent().parent().find('td').eq(0).text())
                    $('[name="deleteFlag"]').val(0)
                    $('#query_userId').attr('user_id',$(me).siblings('[name="userH"]').val())
                    $('#query_userId').val($(me).siblings('[name="privUserName"]').val())
                    $('#department').attr('deptid',$(me).siblings('[name="OrgH"]').val())
                    $('#department').val($(me).siblings('[name="privOrgName"]').val())
                    $('#theScopeOf').attr('userpriv',$(me).siblings('[name="RoleH"]').val())
                    $('#theScopeOf').val($(me).siblings('[name="privRoleName"]').val())
//                    $('[name="file"]').val($(me).siblings('[name="fileName"]').val())
                    if($('[name="fileName"]').val()!=undefined && $(me).siblings('[name="fileName"]').val() != ''){
                        $('#fileA').siblings('b').show();
                        $('#fileA').attr('href', '/download?'+$(me).siblings('[name="fileName"]').val());
                        // var fileNameArr=$(me).siblings('[name="fileName"]').val().split('&');
                        // var fileName = fileNameArr[fileNameArr.length-2].split("=");

                        var attachmentId=$(me).siblings('[name="attachmentId"]').val();
                        var attachmentName = $(me).siblings('[name="attachmentName"]').val();

                        $('input[name="attachmentId"]', $("#datasave")).val(attachmentId);
                        $('input[name="attachmentName"]', $("#datasave")).val(attachmentName);

                        $('#fileA').html(attachmentName.split('*')[0])
                    }

                }
            },yes:function (index) {
                if(validform().form()) {
                    var strTitle=$('[name="file"]').val();
                   if(regTitle(strTitle)) {

                       $('#query_userId').next().find('input').val($('#query_userId').attr('user_id'))
                       $('#department').next().find('input').val($('#department').attr('deptid'))
                       $('#theScopeOf').next().find('input').val($('#theScopeOf').attr('userpriv'))
                       $('#datasave').ajaxSubmit({
                           type: 'post',
                           dataType: 'json',
                           success: function (json) {
                                if(json.flag){
                                    $.layerMsg({content:'<fmt:message code="user.th.SuccessfulOperation"/>！',icon:1},function(){
                                        ajaxPage.page()
                                    });

                                }
                           }
                       })
                   }else {
                       layer.tips('<fmt:message code="doc.th.uploadFiles"/>',$('#fileDownload'),
                       {time: 2000, tipsMore: true}
                       )

                   }
                }else {
                 //console.log('sss')
                }
            }
        })
    })
    $(document).delegate('.choose','click',function () {
        if($(this).attr('data-num')==1){
            user_id = $(this).parent().siblings('textarea').prop('id');
            $.popWindow("../common/selectUser");
        }else if($(this).attr('data-num')==2){
            dept_id=$(this).parent().siblings('textarea').prop('id');
            console.log(dept_id)
            $.popWindow("../common/selectDept");
        }else {
            priv_id=$(this).parent().siblings('textarea').prop('id');
            $.popWindow("../common/selectPriv");
        }
    })

    //清除数据
    $(document).delegate('.clearUser','click',function ()  { //清空人员
        $('#query_userId').attr('user_id', '');
        $('#query_userId').attr('userprivname', '');
        $('#query_userId').removeAttr('dataid');
        $('#query_userId').val('');
    });

    $(document).delegate('.clearDept','click',function ()  { //清空人员
        $('#department').attr('deptname','');
        $('#department').attr('deptid', '');
        $('#department').removeAttr('deptno');
        $('#department').val('');
    });

    $(document).delegate('.clearPriv','click',function ()  { //清空人员
        $('#theScopeOf').removeAttr('userpriv');
        $('#theScopeOf').removeAttr('privid');
        $('#theScopeOf').attr('dataid', '');
        $('#theScopeOf').val('');
    });



    $(document).delegate('.deleteSc','click',function () {
        var me=this;
        $.layerConfirm({title:'<fmt:message code="workflow.th.suredel"/>',content:'<fmt:message code="workflow.th.que"/>？',icon:0},function() {
            $.get('/template/deleteById',{id:$(me).attr('data-id')},function (json) {
                if(json.flag){
                    $.layerMsg({content:'<fmt:message code="workflow.th.delsucess"/>！',icon:1},function(){
                        ajaxPage.page()
                    });
                }
            },'json')
        })

    })


    var ajaxPage={
        data:{
            page:1,//当前处于第几页
            pageSize:10,//一页显示几条
            useFlag:true,
            type:'office',
            categoryId:null
        },
        page:function () {
            var me=this;
           this.data.categoryId=$('[name="dispatchType"]').val()
            $.get('/template/queryAll',me.data,function (json) {
                if(json.flag){
                    var str='';
                    for(var i=0;i<json.obj.length;i++){
                        str+='<tr>' +
                            '<td>'+function () {
                                if(json.obj[i].sortNo != undefined){
                                    return json.obj[i].sortNo
                                }else {
                                    return ''
                                }
                            }()+'</td>' +
                            '<td>'+json.obj[i].name+'</td>' +
                            '<td>'+function () {
                                if(json.obj[i].categoryId==1){
                                    return '<fmt:message code="doc.th.WordTemplate"/>'
                                }else if(json.obj[i].categoryId==2){
                                    return '<fmt:message code="doc.th.RedTemplate"/>'
                                }else {
                                    return ''
                                }
                            }()+' <input type="hidden" value="'+json.obj[i].categoryId+'"></td>' +
                            '<td>'+json.obj[i].privOrgName+''+json.obj[i].privRoleName+''+json.obj[i].privUserName+'</td>' +
                            '<td><a href="javascript:void(0)" class="new_xinjianoTwo" data-val="'+json.obj[i].id+'" style="margin-right: 10px"><fmt:message code="depatement.th.modify"/></a>' +
                            '<input type="hidden" name="userH" value="'+json.obj[i].privUser+'">' +
                            '<input type="hidden" name="OrgH" value="'+json.obj[i].privOrg+'">' +
                            '<input type="hidden" name="RoleH" value="'+json.obj[i].privRole+'">' +
                            '<input type="hidden" name="fileName" value="'+function(){
                                if(json.obj[i].attUrl!=undefined){
                                    return json.obj[i].attUrl
                                }else {
                                    return ''
                                }
                            }()+'">' +
                            '<input type="hidden" name="privOrgName" value="'+json.obj[i].privOrgName+'">' +
                            '<input type="hidden" name="privRoleName" value="'+json.obj[i].privRoleName+'">' +
                            '<input type="hidden" name="privUserName" value="'+json.obj[i].privUserName+'">' +
                            '<input type="hidden" name="attachmentId" value="'+json.obj[i].attachmentId+'">'+
                            '<input type="hidden" name="attachmentName" value="'+json.obj[i].attachmentName+'">'+
                            '<a href="javascript:void(0)" data-id="'+json.obj[i].id+'" class="deleteSc"><fmt:message code="global.lang.delete"/></a></td>' +
                            '</tr>'
                    }
                    $('.pagediv table tbody').html(str)
                    me.pageTwo(json.totleNum,me.data.pageSize,me.data.page)
                }



            },'json')
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


    ajaxPage.page()
    $('.Query').click(function () {
        ajaxPage.data.page=1;
        ajaxPage.page()
    })
</script>

</body>
</html>
