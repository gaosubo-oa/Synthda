
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<head>
    <title><fmt:message code="menuSSetting.th.menug" /></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/css/base.css">
    <link rel="stylesheet" href="/css/workflow/work/automaticNumbering.css">
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>

    <%--<script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>

    <%--<script src="/js/sys/duties.js"></script>--%>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style type="text/css">
        .layui-layer-btn{
            text-align: right !important;
        }
        b{
            color: red;
        }
        /*.inputlayout{*/
        /*    overflow-y: hidden!important;*/
        /*}*/
    </style>
</head>
<body>
<div class="headTop">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/duties.png" alt="">
    </div>
    <div class="divTitle">
        <fmt:message code="menuSSetting.th.menug" />
    </div>
    <div style="padding-right:10px;: 20px;" class="newBtn" id="user_btn">
        <div class="div_IMG">
            <img src="../img/sys/icon_newlyBuild.png" style="vertical-align: middle;" alt="<fmt:message code="depatement.th.Newcompany" />">
        </div>
        <div class="div_txt"><fmt:message code="depatement.th.ade" /></div>
    </div>

</div>
<div style="margin: 0 auto;margin-top: 10px;height: 60px;width: 97%;" class="clearfix">
    <%--<label class="fl" style="margin-top: 16px;">--%>
    <%--<span class="fl" style="margin-top: 5px;"><fmt:message code="doc.th.recordType"/>：</span>--%>
    <%--<select name="dispatchType" id="">--%>
    <%--<option value=""><fmt:message code="hr.th.PleaseSelect"/></option>--%>
    <%--</select>--%>
    <%--</label>--%>

    <%--<label class="fl clearfix" style="margin-top: 16px;margin-left: 10px;">--%>
    <%--<span class="fl" style="margin-top: 5px;"><fmt:message code="global.lang.date"/>：</span>--%>
    <%--<label class="fl"><input name="printDate" readonly="readonly" placeholder="<fmt:message code="doc.th.enterDate"/>" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" type="text"></label>--%>

    <%--</label>--%>
    <%--<label class="fl clearfix" style="margin-top: 16px;margin-left: 10px;" >--%>
    <%--<span class="fl" style="margin-top: 5px;"><fmt:message code="notice.th.title"/>：</span>--%>
    <%--<label class="fl"><input name="title" placeholder="<fmt:message code="global.lang.printsubject"/>"  type="text"></label>--%>
    <%--</label>--%>
    <%--<label class="fl clearfix" style="margin-top: 16px;margin-left: 10px;" >--%>
    <%--<span class="fl" style="margin-top: 5px;"><fmt:message code="notice.th.state"/>：</span>--%>
    <%--<label class="fl"><select name="status">--%>
    <%--<option value=""><fmt:message code="hr.th.PleaseSelect"/></option>--%>
    <%--<option value="1"><fmt:message code="lang.th.will"/></option>--%>
    <%--<option value="2"><fmt:message code="lang.th.Process"/></option>--%>
    <%--</select></label>--%>
    <%--<button  type="button" class="Query fl"><fmt:message code="global.lang.query"/></button>--%>
    <%--</label>--%>

</div>


<div class="pagediv" style="margin: 0 auto;width: 97%;">
    <table>
        <thead>
        <tr>
            <th><fmt:message code="hr.th.number" /></th>
            <th><fmt:message code="main.titleName" /></th>
            <th><fmt:message code="main.type" /></th>
            <th><fmt:message code="vote.th.JobLevel" /></th>
            <th><fmt:message code="workflow.th.sector" /></th>
            <%--<th></th>--%>
            <th><fmt:message code="menuSSetting.th.menuSetting" /></th>
            <%--<th><fmt:message code="notice.th.state"/></th>--%>
            <%--<th><fmt:message code="notice.th.operation"/></th>--%>
        </tr>
        </thead>
        <tbody>

        </tbody>
    </table>
    <div id="dbgz_page" class="M-box3 fr">

    </div>
</div>
<script>
    function checkehuo(name, val) {
        if (val == '') {
            return;
        }
        $('[name="' + name + '"]').find('option').each(function(i, n) {
            if ($(this).val() == val) {
                $(this).attr('selected', 'selected')
            } else {
                $(this).removeAttr('selected', 'selected')
            }
        })
    }
    function getData(){
        $.get('/duties/selectUserPostList',function (json) {
            if(json.flag){
                var v=1;
                var arr=json.obj;
                var str=''
                for(var i=0;i<arr.length;i++){
                    str+='<tr><td>'+ arr[i].postNo +'</td>\
                  <td>'+arr[i].postName+'</td>\
                  <td>'+arr[i].typeName+'</td>\
                  <td>'+arr[i].level+'</td>\
                  <td>'+arr[i].deptName+'</td>\
                        <td>'
                        +'<a href="javascript:void (0)" class="newsBtntwo" onclick="stoprwo(' + arr[i].postId + ')"><fmt:message code="global.lang.edit" /></a>\
                         <a href="javascript:void (0)" onclick="deleteList(' + arr[i].postId + ')"><fmt:message code="global.lang.delete" /></a>\
                    </td></tr>'
                }
                $('table tbody').html(str)
            }
        })
    }

    $(function () {
        var fileId='';
        var fileName='';
        // ajaxPage.init()
        // ajaxPage.page()
        getData();

        $('.Query').on("click",function () {
            ajaxPage.data.page=1;
            ajaxPage.page()
        })
        $('#user_btn').on('click',function () {
            layer.open({
                type: 1,
                title:['<fmt:message code="main.newPosition" />', 'background-color:#2b7fe0;color:#fff;'],
                area: ['700px', '450px'],
                shadeClose: false, //点击遮罩关闭
                // btn: ['创建', '取消'],
                content:'<form id="saveRule" class="layui-form"><div class="inputlayout" >' +
                '<ul>' +
                '<li class="clearfix">' +
                '<label><fmt:message code="main.titleName" /> ：</label><input type="text" name="postName" value=""><b style="padding-left: 10px;">* </b>' +
                '</li>' +
                '<li class="clearfix">' +
                '<label><fmt:message code="main.type" />：</label>' +
                ' <select style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" name="type">'+
                '<option value=""><fmt:message code="hr.th.PleaseSelect" /></option>'+
                '</select><b style="padding-left: 13px;">* </b>   ' +
                '</li>' +
                '<li class="clearfix">' +
                '<label><fmt:message code="vote.th.JobLevel" /> ：</label><input type="text" name="level" value=""><b style="padding-left: 10px;">* </b>' +
                '</li>' +
                '<li class="clearfix">' +
                '<label><fmt:message code="vote.th.number" /> ：</label><input type="text" name="postNo"><b style="padding-left: 10px;">* </b>' +
                '</li>' +
                '<li class="clearfix">' +
                '<label><fmt:message code="workflow.th.sector" />：</label>' +
                ' <select style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" name="deptId">'+
                '<option value=""><fmt:message code="hr.th.PleaseSelect" /></option>'+
                '</select>   ' +
                '</li>' +
                // '<li class="clearfix">' +
                // '<label>编制 ：</label><input type="text" name="postPlan">' +
                // '</li>' +

                '<li class="clearfix">' +
                '<label><fmt:message code="depatement.th.duty" /> ：</label><textarea name="duty" id="duty" value style="min-width: 300px;min-height:60px;"></textarea>' +
                '</li>' +
                '<li class="clearfix">' +
                '<label><fmt:message code="depatement.th.requirements" /> ：</label><textarea name="description" id="textCont" value style="min-width: 300px;min-height:60px;"></textarea>' +
                '</li>' +
                // '<input style="width: 200px; position: absolute; left: 280px;bottom: 0px;" id="fileupload" type="file" name="files[]" data-url="upload?module=userpost" multiple>'+
                '<li class="clearfix">' +
                '<label><fmt:message code="global.th.fileup" />：</label>' +
                '<div>'+
                '<form id="uploadimgform" target="uploadiframe"  action="/upload?module=seal"  method="post" >'+
                '<input type="file" multiple="multiple" name="file" id="uploadinputimg"  class="w-icon5" style="cursor:pointer;margin-left: 32px;opacity: 0;width: 70px;'+
                'filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">'+
                '<a href="#" id="uploadimg" style="z-index:-1;position: relative;left: -69px;"><img style="margin-right:5px;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>'+
                '</form>'+
                '<div style="margin-left:183px;" class="attmend"></div>'+
                '</div>'+
                '</li>' +
                '</ul>' +
                '</div></form>',
                btn: ['<fmt:message code="global.lang.save" />','<fmt:message code="depatement.th.quxiao" />'],
                btn1: function (index) {
                    if ($('[name="postName"]').val() == "") {
                        $.layerMsg({ content: '<fmt:message code="depatement.th.adfg" />', icon: 2 });
                        return false;
                    };
                    if ($('[name="type"]').val() == "") {
                        $.layerMsg({ content: '<fmt:message code="depatement.th.ret" />', icon: 2 });
                        return false;
                    };
                    if ($('[name="level"]').val() == "") {
                        $.layerMsg({ content: '<fmt:message code="depatement.th.zwjb" />', icon: 2 });
                        return false;
                    };
                    if ($('[name="postNo"]').val() == "") {
                        $.layerMsg({ content: '<fmt:message code="depatement.th.nub" />', icon: 2 });
                        return false;
                    };
                    for(var i=0;i<$('.inHidden').length;i++){
                        fileId += $('.inHidden').eq(i).val();
                        fileName += $('.inHidden').eq(i).attr('name');
                    }
                    $.ajax({
                        type:'post',
                        url:'/duties/addUserPost',
                        dataType:'json',
                        data:{
                            postName:$('[name="postName"]').val(),
                            level:$('[name="level"]').val(),
                            postNo:$('[name="postNo"]').val(),
                            // postPlan:$('[name="postPlan"]').val(),
                            duty:$('#duty').val(),
                            description:$('[name="description"]').val(),
                            type: $('select[name="type"] option:checked').val(),
                            deptId: $('select[name="deptId"] option:checked').val(),
                            attachmentId:fileId,
                            attachmentName:fileName,
                        },
                    });
                    layer.close(index);
                    location.reload();
                },
                success:function(res){
                    // 上传附件
                    // $('#fileupload').fileupload({
                    //     dataType: 'json',
                    //     done: function (e, data) {
                    //         $.each(data.result.files, function (index, file) {
                    //             $('<p/>').text(file.name).appendTo(document.body);
                    //         });
                    //     }
                    // });
                    // $('b').css('color', 'red');


                    $('#uploadinputimg').fileupload({
                        dataType:'json',
                        url:'/upload?module=userpost',
                        done: function (e, data) {

                            if(data.result.obj != ''){
                                var data = data.result.obj;
                                var str = '';
                                var str1 = '';
                                for (var i = 0; i < data.length; i++) {
                                    str += '<div class="dech" deUrl="' + data[i].attUrl+ '"><a href="/download?'+encodeURI(data[i].attUrl)+'" NAME="' + data[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                                }
                                $('.attmend').append(str);
                            }else{
                                //alert('添加附件大小不能为空!');
                                layer.alert('<fmt:message code="depatement.th.hjmn" />!',{},function(){
                                    layer.closeAll();
                                });
                            }
                        }
                    });

                    //附件删除
                    $('.attmend').on('click','.deImgs',function(){
                        var data=$(this).parents('.dech').attr('deUrl');
                        var dome=$(this).parents('.dech');
                        deleteChatment(data,dome);
                    })

                    // })
                    //职能类型
                    $.get('/code/GetDropDownBox',{CodeNos:'function'},function (json) {
                        var arrTwo=json.function;
                        var str='<option value=""><fmt:message code="hr.th.PleaseSelect" /></option>'
                        for(var i=0;i<arrTwo.length;i++){
                            str+='<option value="'+arrTwo[i].codeNo+'">'+arrTwo[i].codeName+'</option>'
                        }
                        $('[name="type"]').html(str)
                    },'json');
                    //所属部门
                    $.get('/department/getAlldept',function (json) {
                        var arrTwo=json.obj;
                        var str='<option value=""><fmt:message code="hr.th.PleaseSelect" /></option>'
                        for(var i=0;i<arrTwo.length;i++){
                            str+='<option value="'+arrTwo[i].deptId+'">'+arrTwo[i].deptName+'</option>'
                        }
                        $('[name="deptId"]').html(str)
                    },'json');

                    if(res.flag){
                        console.log(res.flag)
                    }
                },

            });
            // laydate.render({
            //     elem: '#sentTime'
            // });
        })

    })

    function stoprwo(me){
        // console.log(me)
        $.ajax({
            type:'post',
            url:'/duties/getUserPostId',
            dataType:'json',
            data: {
                postId: me
            },
            success:function(res){
                if(res.flag){
                    var data=res.object;
                    var arr = res.object.attachment;
                    var str1=""

                    layer.open({
                        type: 1,
                        title:['<fmt:message code="global.lang.edit" />', 'background-color:#2b7fe0;color:#fff;'],
                        area: ['700px', '500px'],
                        shadeClose: false, //点击遮罩关闭
                        btn: ['<fmt:message code="depatement.th.modify" />', '<fmt:message code="depatement.th.quxiao" />'],
                        content:'<form id="saveRule" class="layui-form"><div class="inputlayout" style="overflow-y: hidden!important;">' +
                        '<ul>' +
                        '<li class="clearfix">' +
                        '<label><fmt:message code="main.titleName" /> ：</label><input type="text" name="postName" value="'+data.postName+'"><b style="padding-left: 10px;">* </b>' +
                        '</li>' +
                        '<li class="clearfix">' +
                        '<label><fmt:message code="main.type" />：</label>' +
                        ' <select style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" name="type">'+
                        '<option value=""><fmt:message code="hr.th.PleaseSelect" /></option>'+
                        '</select><b style="padding-left: 13px;">* </b>   ' +
                        '</li>' +
                        '<li class="clearfix">' +
                        '<label><fmt:message code="vote.th.JobLevel" /> ：</label><input type="text" name="level" value="'+data.level+'"><b style="padding-left: 10px;">* </b>' +
                        '</li>' +
                        '<li class="clearfix">' +
                        '<label><fmt:message code="vote.th.number" /> ：</label><input value="'+data.postNo+'" type="text" name="postNo"><b style="padding-left: 10px;">* </b>' +
                        '</li>' +
                        '<li class="clearfix">' +
                        '<label><fmt:message code="workflow.th.sector" />：</label>' +
                        ' <select style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" name="deptId">'+
                        '<option value=""><fmt:message code="hr.th.PleaseSelect" /></option>'+
                        // '<option value="0">董事会</option>'+
                        // '<option value="1">短信内容后</option>'+
                        '</select>   ' +
                        '</li>' +
                        // '<li class="clearfix">' +
                        // '<label>编制 ：</label><input value="'+data.postPlan+'" type="text" name="postPlan">' +
                        // '</li>' +

                        '<li class="clearfix">' +
                        '<label><fmt:message code="depatement.th.duty" /> ：</label><textarea name="duty" id="duty" value style="min-width: 300px;min-height:60px;"></textarea>' +
                        '</li>' +
                        '<li class="clearfix">' +
                        '<label><fmt:message code="depatement.th.requirements" /> ：</label><textarea name="description" id="description" value style="min-width: 300px;min-height:60px;"></textarea>' +
                        '</li>' +
//                        '<input style="width: 200px; position: absolute; left: 280px;bottom: 0px;" id="fileupload" type="file" name="files[]" data-url="server/php/" multiple>'+

                        '<li class="clearfix">' +
                        '<label><fmt:message code="global.th.fileup" />：</label>' +
                        '<div>'+
                        '<form id="uploadimgform" target="uploadiframe"  action="/upload?module=seal"  method="post" >'+
                        '<input type="file" multiple="multiple" name="file" id="uploadinputimg"  class="w-icon5" style="cursor:pointer;margin-left: 32px;opacity: 0;width: 70px;'+
                        'filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">'+
                        '<a href="#" id="uploadimg" style="z-index:-1;position: relative;left: -69px;"><img style="margin-right:5px;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>'+
                        '</form>'+
                        '<div style="margin-left:183px;" class="attmend"></div>'+
                        '</div>'+
                        '</li>' +
                        '</ul>' +
                        '</div></form>',
                        success:function () {
                            if (res.object.attachment != '') {
                                for (var i = 0; i < (arr.length); i++) {
                                    str1+='<div class="dech" deUrl="'+encodeURI(arr[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" NAME="'+arr[i].attachName+'*" href="/download?'+encodeURI(arr[i].attUrl)+'"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>'+arr[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+arr[i].attachName+'*"  class="inHidden" value="'+arr[i].aid+'@'+arr[i].ym+'_'+arr[i].attachId+',"></div>';
                                }
                                $('.attmend').append(str1);
                            };

                            // 职能类型
                            $.get('/code/GetDropDownBox',{CodeNos:'function'},function (json) {
                                var arrTwo=json.function;
                                var str='<option value=""><fmt:message code="hr.th.PleaseSelect" /></option>'
                                for(var i=0;i<arrTwo.length;i++){
                                    str+='<option value="'+arrTwo[i].codeNo+'">'+arrTwo[i].codeName+'</option>'
                                }
                                $('[name="type"]').html(str)
                                checkehuo('type', data.type);
                            },'json');
                            //所属部门
                            $.get('/department/getAlldept',function (json) {
                                var arrTwo=json.obj;
                                var str='<option value=""><fmt:message code="hr.th.PleaseSelect" /></option>'
                                for(var i=0;i<arrTwo.length;i++){
                                    str+='<option value="'+arrTwo[i].deptId+'">'+arrTwo[i].deptName+'</option>'
                                }
                                $('[name="deptId"]').html(str);
                                checkehuo('deptId', data.deptId);
                            },'json');
                            // 上传附件

                            $('#uploadinputimg').fileupload({
                                dataType:'json',
                                url:'/upload?module=userpost',
                                done: function (e, data) {

                                    if(data.result.obj != ''){
                                        var data = data.result.obj;
                                        var str = '';
                                        var str1 = '';
                                        for (var i = 0; i < data.length; i++) {
                                            str += '<div class="dech" deUrl="' + data[i].attUrl+ '"><a href="/download?'+encodeURI(data[i].attUrl)+'" NAME="' + data[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                                        }
                                        $('.attmend').append(str);
                                    }else{
                                        //alert('添加附件大小不能为空!');
                                        layer.alert('<fmt:message code="dem.th.AddEmpty" />!',{},function(){
                                            layer.closeAll();
                                        });
                                    }
                                }
                            });

                            //附件删除
                            $('.attmend').on('click','.deImgs',function(){
                                var data=$(this).parents('.dech').attr('deUrl');
                                var dome=$(this).parents('.dech');
                                deleteChatment(data,dome);
                            })
                            $('#duty').val(data.duty);
                            $('#description').val(data.description)

                        },
                        yes:function(index){
                            var fileId='';
                            var fileName='';
                            for(var i=0;i<$('.inHidden').length;i++){
                                fileId += $('.inHidden').eq(i).val();
                                fileName += $('.inHidden').eq(i).attr('name');
                            }
                            if ($('[name="postName"]').val() == "") {
                                $.layerMsg({ content: '<fmt:message code="depatement.th.adfg" />', icon: 2 });
                                return false;
                            };
                            if ($('[name="type"]').val() == "") {
                                $.layerMsg({ content: '<fmt:message code="depatement.th.ret" />', icon: 2 });
                                return false;
                            };
                            if ($('[name="level"]').val() == "") {
                                $.layerMsg({ content: '<fmt:message code="depatement.th.zwjb" />', icon: 2 });
                                return false;
                            };
                            if ($('[name="postNo"]').val() == "") {
                                $.layerMsg({ content: '<fmt:message code="depatement.th.nub" />', icon: 2 });
                                return false;
                            };
                            $.ajax({
                                type:'post',
                                url:'/duties/updateUserPost',
                                dataType:'json',
                                data:{
                                    postId: me,
                                    postName:$('[name="postName"]').val(),
                                    level:$('[name="level"]').val(),
                                    // postPlan:$('[name="postPlan"]').val(),
                                    duty:  $('#duty').val(),
                                    description:$('[name="description"]').val(),
                                    type: $('select[name="type"] option:checked').val(),
                                    deptId: $('select[name="deptId"] option:checked').val(),
                                    postNo:$('[name="postNo"]').val(),
                                    attachmentId:fileId,
                                    attachmentName:fileName,
                                },
                                success:function(res){
                                    if(res.flag){
                                        layer.close(index);
                                    };
                                }
                            });

                            layer.close(index);
                            location.reload();
                        },

                    });
                    $('b').css('color', 'red');

                }




            }


        });
    }
    function deleteList(me) {

        layer.confirm('<fmt:message code="attend.th.qued" />？', {
            btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'], //按钮
            title: "<fmt:message code="event.th.DeleteInformation" />"
        }, function() {
            //确定删除，调接口
            $.ajax({
                type: 'post',
                url: '/duties/deleteUserPost',
                dataType: 'json',
                data: {
                    postId: me
                },
                success: function(res) {
                    if (res.flag) {
                        $.layerMsg({ content: '<fmt:message code="workflow.th.delsucess" />！', icon: 1 });
                    } else {
                        $.layerMsg({ content: '<fmt:message code="lang.th.deleSucess" />！', icon: 1 });
                    }
                    location.reload();
                }
            })
        }, function() {

            layer.closeAll();
        });

    }

    //删除附件
    function deleteChatment(data,element){

        layer.confirm('<fmt:message code="menuSSetting.th.isdeleteMenu" />？', {/*确定要删除吗*/
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮 /*确定 取消*/
            title:'<fmt:message code="notice.th.DeleteAttachment" />' /*删除附件*/
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'get',
                url:'../delete',
                dataType:'json',
                data:data,
                success:function(res){

                    if(res.flag == true){
                        layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});/*删除成功*/
                        element.remove();
                    }else{
                        layer.msg('<fmt:message code="lang.th.deleSucess" />', { icon:6});/*删除失败*/
                    }
                }
            });

        }, function(index){
            layer.close(index);
        });
    }
</script>
</body>
</html>
