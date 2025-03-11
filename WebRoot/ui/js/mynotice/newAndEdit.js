/**
 * Created by 骆鹏 on 2018/1/6.
 */
var getRequestObj=$.GetRequest();
var user_id=null;
var dept_id=null;
var priv_id=null;
var ue=null;
var noticeType;
var specifyTable = $.GetRequest()['specifyTable'] || '';
var parentNo;

$(function(){
    $.get("/myNotifyConfig/getNotifyType?noticeType="+specifyTable,function(res){
        noticeType = '选择'+res.data.mynotice_type_name
        parentNo = res.data.mynotice_type
        if(getRequestObj.type=='new'){
            var txt = '新建';
            $('.navigation').find('h2').text(txt);
            $('#ajaxform').attr('action','/myNotice/addNotify?specifyTable='+specifyTable);
            $('[name="sendTimes"]').val(queryTime());


            GetDropDownBox(function () {
                if($('[name="typeId"]').find('option:selected').attr('data-isEdit')==1){
                    $('.sendbtn').hide();
                    $('.tijiaobtn').show()
                }
            });
            $('[name="beginDates"]').val(queryTime(1))

        }else {
            var txt="修改"
            $('.navigation').find('h2').text(txt);
            $('#ajaxform').attr('action','newUpdateNotify?specifyTable='+specifyTable);
            $('[name="notifyId"]').val(getRequestObj.notifyId);
            ue.ready(function () {
                $.get('getOneById',{
                    notifyId:getRequestObj.notifyId,
                    permissionId:'1',
                    changId:'1',
                    specifyTable:specifyTable
                },function (json) {
                    if(json.flag){
                        var obj=json.object;
                        var arr=$('input');
                        (function (fn) {
                            for(var i=0;i<arr.length;i++){
                                for(var key in obj){
                                    if($(arr[i]).prop('name')==key){
                                        $(arr[i]).val(obj[key])
                                    }
                                }
                            }
                            fn()
                        })(function () {
                            if($('[name="top"]').val()==1){
                                $('[name="topDing"]').prop('checked',true);
                            }else{
                                $('[name="topDing"]').prop('checked',false);
                            }
                        });
                        $('[name="sendTimes"]').val(obj.notifyDateTime);
                        $('[name="beginDates"]').val(obj.begin);
                        $('[name="endDates"]').val(obj.end);
                        $('[name="summary"]').val(obj.summary);

                        if(obj.howRenind!=""&&obj.howRenind!=undefined){
                            $('input[name="thingDefault"]').prop('checked',false)
                            $('input[name="smsRemind"]').prop('checked',false)
                            var arr = obj.howRenind.split(',');
                            for(var i=0;i<arr.length;i++){
                                if(arr[i] == '0'){
                                    $('input[name="thingDefault"]').prop('checked','checked')
                                }else if(arr[i] == '1'){
                                    $('input[name="smsRemind"]').prop('checked','checked')
                                }
                            }
                        }else{
                            $('input[name="thingDefault"]').prop('checked',false)
                            $('input[name="smsRemind"]').prop('checked',false)
                        }

                        $('#department').val(obj.deprange);
                        $('#department').attr('deptid',obj.toId);
                        if(obj.privId!=''){
                            $('#roleall').attr('userpriv',obj.privId);
                            $('#roleall').val(obj.rolerange);
                            $('#roleall').parent().parent().show()
                        }

                        if(obj.userId!='') {
                            $('#personnel').val(obj.userrange);
                            $('#personnel').attr('user_id', obj.userId);
                            $('#personnel').parent().parent().show()
                        }
                        /*按人员类别发布*/
                        if(obj.userType) {
                            var userTypeArr = obj.userType.split(',');
                            viewUserTypeSelect.setValue(userTypeArr);
                        }
                        /*拟稿部门*/
                        if(obj.draftDept!='') {
                            $('#draftDept').val(obj.draftDeptName);
                            $('#draftDept').attr('deptid', obj.draftDept);
                        }
                        if(obj.download==0){
                            $('#download_ck').removeProp('checked')
                        }
                        if(obj.isOpin==1){
                            $('.setHide').show();
                            $('[name="isOpin"]').attr("checked","checked");
                        }
                        $('[name="field"]').remove();
                        if(("opinionFields" in obj)){
                            var opinions = obj.opinionFields.split("-");
                            var str2='';
                            if(opinions.length>=2){
                                $('#clear').show()
                            }
                            if(opinions.length>=10){
                                $('#add').hide()
                            }
                            $.each(opinions,function (index) {
                                str2 += ' <input type="text" name="field" value="'+opinions[index]+'"  style="width: 200px;"/>'
                            });
                            $('#add').before(str2)
                        }
                        ue.setContent(obj.content);
                        GetDropDownBox(function () {
                            $('[name="typeId"]').val(obj.typeId);
                            if($('[name="typeId"]').find('option:selected').attr('data-isEdit')=='1'){
                                if(getRequestObj.approve == 'true'){
                                    $('.sendbtn').show();
                                    $('.tijiaobtn').hide()
                                }else {
                                    $('.sendbtn').hide();
                                    $('.tijiaobtn').show()
                                }
                            }
                        });
                        var data = obj.attachment;
                        var str = '';;
                        for (var i = 0; i < data.length; i++) {
                            var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
                            var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                            var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                            var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;
                            str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><a fileExtension="'+fileExtension+'" onclick="pdurls($(this))" href="javascript:;"  style="padding-left: 5px" deUrl="' + deUrl+ '"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a><a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                            // str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" style="color: #000;" NAME="'+data[i].attachName+'*" href="javascript:;">'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';
                        }
                        $('#fileAll').append(str);

                    }else {
                        $.layerMsg({content: networkError, icon: 2});
                    }
                },'json')
            })

        }
    })
})
function queryTime(type){
    function p(s) {
        return s < 10 ? '0' + s: s;
    }
    var myDate = new Date();
    //获取当前年
    var year=myDate.getFullYear();
    //获取当前月
    var month=myDate.getMonth()+1;
    //获取当前日
    var date=myDate.getDate();
    var h=myDate.getHours();       //获取当前小时数(0-23)
    var m=myDate.getMinutes();     //获取当前分钟数(0-59)
    var s=myDate.getSeconds();
    var now=year+'-'+p(month)+"-"+p(date)+" "+p(h)+':'+p(m)+":"+p(s);
    if(type==undefined){
        return now;
    }else {
        return year+'-'+p(month)+"-"+p(date)
    }

}
var dataobj={istime: false, format: 'YYYY-MM-DD',min:queryTime(1)};
function typeIdStatic(me) {
    if($(me).find('option:selected').attr('data-isEdit')=='1'){
        $('.tijiaobtn').show();
        $('.sendbtn').hide()
    }else {
        $('.tijiaobtn').hide();
        $('.sendbtn').show()
    }
}


function ajaxforms(type) {
    if(!$('#ajaxform select[name="typeId"]').val()){
        layer.msg('请'+noticeType+'!',{icon:0});
        return false
    }

    //判断如果是编辑页面且是保存按钮，就走新接口
    if(getRequestObj.type=='edit' && type==0){
        $('#ajaxform').attr('action','/myNotice/updateNotifys?specifyTable='+specifyTable);
    }
    var isEdit=isPublish(getRequestObj.notifyId)
    if(isEdit==1){
        $.layerMsg({content:'该条公告已生效！',icon:0});
        parent.window.location.reload()
        return false
    }

    if(type==0) {
        if(getRequestObj.type!='edit'){
            $('[name="publish"]').val(type);
        }else {
            $('[name="publish"]').val('');
        }
    }else {
        $('[name="publish"]').val(type);
    }


    if(type!=2){
        $('[name="tuisong"]').val(type);
        // $('[name="tuisong"]').val(0);
    }
    var index1,index2,index3;

    if($('[name=subject]').val() == ''){
        layer.msg('不能不输入标题！',{icon:2});
    }else if($('.barText').html() != '' && $('.barText').html()!="100%"){
        layer.msg('附件还未上传完毕！',{icon:2});
    }else{

        if($('#personnel').attr('user_id')!=undefined) {
            $('#personnel').siblings('input[type=hidden]').val($('#personnel').attr('user_id'));
            index1 = 1;
        }else{
            index1 = 2;
        }
        if($('#roleall').attr('userpriv')!=undefined){
            $('#roleall').siblings('input[type=hidden]').val($('#roleall').attr('userpriv'));
            index2 = 1;
        }else{
            index2 = 2;
        }
        if($('#department').attr('deptid')!=undefined){
            $('#department').siblings('input[type=hidden]').val($('#department').attr('deptid'));
            index3 = 1;
        }else{
            index3 = 2;
        }
        /*按人员类别发布*/
        if(viewUserTypeSelect.getValue('valueStr')){
            $('[name="userType"]').val(viewUserTypeSelect.getValue('valueStr')+',')
        }
        /*拟稿部门*/
        if($('#draftDept').attr('deptid')){
            $('#draftDept').siblings('input[type=hidden]').val($('#draftDept').attr('deptid').replace(/,$/, ''));
        }else{
            $('#draftDept').siblings('input[type=hidden]').val($('#draftDept').val());
        }

        if(index1 == 2 && index3 == 2 &&index2 == 2){
            layer.msg('部门、角色、人员至少填写一个！',{icon:2});
        }else{
            var filearr=$('#fileAll .dech');
            var aId='';
            var uId='';
            for(var i=0;i<filearr.length;i++){
                aId+=$(filearr[i]).find('input').val();
                uId+=$(filearr[i]).find('a').attr('name');
            }
            $('[name="attachmentId"]').val(aId);
            $('[name="attachmentName"]').val(uId);
            $('[name="content"]').val(ue.getContent());
            var checkvalue=""
            $('#thing input[type="checkbox"]').each(function(i,v){
                if($(this).is(':checked')){
                    checkvalue += $(this).val()+','
                }
            })
            $('input[name="howRenind"]').val(checkvalue)
            if(type==1){
                if(getRequestObj.notifyId!=undefined){
                    $('[name="lastEditTimes"]').val(queryTime())
                }
            }

            if($('[name="isOpin"]').is(':checked')){
                $('[name="isOpin"]').val(1)
                var str=""
                var strfield=""
                $('[name="field"]').each(function (index) {
                    if($(this).val() == ''){
                        $.layerMsg({content:'标题不能为空',icon:6})
                        return false ;
                    }
                    str += $(this).val()+'-'
                    strfield += $(this).val()+'(-)'
                });
                str = str.substr(0,str.length-1);
                $('[name="opinionFields"]').val(str)
                $('[name="fieldTitles"]').val(strfield)
            }else{
                $('[name="opinionFields"]').val('')
                $('[name="fieldTitles"]').val('')
            }


            //判断公告是否勾选置顶，如果勾选置顶且后面天数为空，则需要提示用户，如果后面天数为0，提示下，置顶时间为0，是否一直置顶？客户选择否的话可以继续修改，选择是则提交
            if($('[name="topDing"]').prop('checked') && $('[name="topDays"]').val()==''){
                $.layerMsg({content:'请填写置顶天数！',icon:0});
                return false
            }else if($('[name="topDing"]').prop('checked') && $('[name="topDays"]').val()=='0'){
                layer.confirm('置顶时间为0，是否一直置顶？', {
                    btn: ['是', '否']
                }, function(index, layero){
                    $('#ajaxform').ajaxSubmit({
                        type: 'post',
                        dataType: 'json',
                        success: function (json) {
                            if (json.flag) {
                                $.layerMsg({content: SuccessfulOperation, icon: 1}, function () {
                                    if(getRequestObj.approve == 'true'){
                                        window.close();
                                        window.opener.location.reload();
                                    }else{
                                        if(parent.$('[name="notices"]').length == 0){
                                            window.close();
                                        }else{
                                            /*parent.$('.head-top ul li').removeClass('active')
                                            $((parent.$('.head-top ul li'))[0]).addClass('active')
                                            parent.$('[name="notices"]').attr('src','../../myNotice/management')*/
                                            parent.window.location.reload()
                                        }

                                    }
                                });
                            } else {
                                $.layerMsg({content: '发布失败！', icon: 2});
                            }

                        }
                    })
                }, function(index){

                });
            }else{
                $('#ajaxform').ajaxSubmit({
                    type: 'post',
                    dataType: 'json',
                    success: function (json) {
                        if (json.flag) {
                            $.layerMsg({content: SuccessfulOperation, icon: 1}, function () {
                                if(getRequestObj.approve == 'true'){
                                    window.close();
                                    window.opener.location.reload();
                                }else{
                                    if(parent.$('[name="notices"]').length == 0){
                                        window.close();
                                    }else{
                                        /*parent.$('.head-top ul li').removeClass('active')
                                        $((parent.$('.head-top ul li'))[0]).addClass('active')
                                        parent.$('[name="notices"]').attr('src','../../myNotice/management')*/
                                        parent.window.location.reload()
                                    }

                                }
                            });
                        } else {
                            $.layerMsg({content: '发布失败！', icon: 2});
                        }

                    }
                })
            }

        }
    }

}
//在点击修改或编辑或审批时，如果已生效，则不允许操作
function isPublish(notifyId){
    var isPublish=''
    $.ajax({
        url:'/myNotice/selectById',
        type:'get',
        data:{notifyId:notifyId,specifyTable:specifyTable},
        dataType:'json',
        async:false,
        success:function(res){
            if(res.flag && res.obj1 && res.obj1.publish==1){
                isPublish=res.obj1.publish
            }
        }
    })
    return isPublish
}

function GetDropDownBox(fn) {
    $.ajax({
        url: "/mySys/getNotifyTypeList?specifyTable="+specifyTable,
        type:'get',
        dataType:"JSON",
        success:function(data){
            var str='<option value="" data-isEdit="'+data.object.isEdit+'">'+noticeType+'</option>';
            // var str='<option value="" data-isEdit="'+data.object.isEdit+'">'+notice_type_alltype+'</option>';

            var arr=data.obj;
            for(var i=0;i<arr.length;i++){
                str += '<option value="'+arr[i].codeNo+'" data-isEdit="'+arr[i].isEdit+'">'+arr[i].codeName+'</option>'

            }
            $('[name="typeId"]').html(str)
            if(chkValue1.indexOf('5')!=-1){
                // 针对内部分发后的类型回显不上
                $.ajax({
                    type:'get',
                    url:'/flowUtil/flowAttachDocument',
                    dataType:'json',
                    async:false,
                    data:{
                        runId:runId1,
                        module:"notify"
                    },
                    success:function (res) {
                        var data = res.obj;
                        var str = '';
                        $('#ajaxform select[name="typeId"]').val(res.obj1)
                    }

                })

            }
            if(fn!=undefined){
                fn()
            }
        }

    })
}
$(function () {
    var runId1 = $.getQueryString("runId") || '';
    var chkValue1 = $.getQueryString("chkValue") || '';
    ue = UE.getEditor('word_container',{elementPathEnabled : false});

    // 查询提醒权限
    $.ajax({
        type:'get',
        url:'/smsRemind/getRemindFlag',
        dataType:'json',
        data:{
            type:1,
            specifyTable:specifyTable
        },
        success:function (res) {
            if(res.flag){
                if(res.obj.length>0){
                    var data = res.obj[0];
                    // 是否默认发送
                    if(data.isRemind=='0'){
                        $('input[name="thingDefault"]').prop("checked", false);
                    }else if(data.isRemind=='1'){
                        $('input[name="thingDefault"]').prop("checked", true);
                    }
                    // 是否手机短信默认提醒
                    if(data.isIphone=='0'){
                        $('input[name="smsRemind"]').prop("checked", false);
                    } else if (data.isIphone=='1'){
                        $('input[name="smsRemind"]').prop("checked", true);
                    }
                    // 是否允许发送事务提醒
                    if(data.isCan=='0'){
                        $('input[name="thingDefault"]').prop("checked", false);
                        $('input[name="smsRemind"]').prop("checked", false);
                        $('#thing').parent('tr').hide();
                    }

                }
            }
        }
    })

    $('.deptandrole').click(function () {
        if($('.deptrole').is(':hidden')){
            $('.deptrole').show()
        }else {
            $('.deptrole').hide()
        }
    });

    $('[name="remindTixing"]').click(function () {
        if($(this).is(':checked')){
            $(this).siblings('input').val(1)
        }else {
            $(this).siblings('input').val(0)
        }
    });

    $('[name="topDing"]').click(function () {
        if($(this).is(':checked')){
            $(this).siblings('input[type=hidden]').val(1)
        }else {
            $(this).siblings('input[type=hidden]').val(0)
        }
    });

    $('[name="smsRemind"]').click(function () {
        if($(this).is(':checked')){
            $(this).nextAll('input[type=hidden]').val(0)
        }else {
            $(this).nextAll('input[type=hidden]').val(1)
        }
    });

    $('#download_ck').click(function () {
        if($(this).is(':checked')){
            $(this).siblings('input[type=hidden]').val(1)
        }else {
            $(this).siblings('input[type=hidden]').val(0)
        }
    });

    //        查询置顶天数
    //用编辑接口的回显置顶天数，故注释
    /*$.ajax({
        type:'get',
        url:'/syspara/selectDemo',
        dataType:'json',
        data:{
            paraName:'NOTIFY_TOP_DAYS'
        },
        success:function (res) {
            if(res.flag){
                if(res.object.paraValue == ''){
                    $('input[name="topDays"]').val('');
                }else{
                    $('input[name="topDays"]').val(res.object.paraValue);
                }
            }
        }
    })*/

    $('.addControls').click(function () {
        var type=$(this).attr('data-type');

        if(type==1){
            dept_id=$(this).siblings('textarea').prop('id');
            $.popWindow("../common/selectDept?allDept=1");
        }else if(type==2){
            priv_id=$(this).siblings('textarea').prop('id');
            $.popWindow("../common/selectPriv");
        }else if(type==3){
            user_id = $(this).siblings('textarea').prop('id');
            $.ajax({
                url:'/imfriends/getIsFriends',
                type:'get',
                dataType:'json',
                data:{},
                success:function(obj){
                    if(obj.object == 1){
                        $.popWindow("../common/selectUserIMAddGroup");
                    }else{
                        $.popWindow("../common/selectUser");
                    }
                },
                error:function(res){
                    $.popWindow("../common/selectUser");
                }
            })
        }else if(type==4){
            dept_id=$(this).siblings('textarea').prop('id');
            $.popWindow("../common/selectDept?0");
        }
    });

    $('.recoveryTime').click(function () {
        $(this).siblings('input').val(queryTime())
    });

    fileuploadFn('#fileupload',$('#fileAll'));

    // var timer=null;
//     $('#fileupload').fileupload({
//         dataType: 'json',
//         progressall: function (e, data) {
//             var progress = parseInt(data.loaded / data.total * 100, 10);
//             $('#progress .bar').css(
//                 'width',
//                 progress + '%'
//             );
//             $('.barText').html(progress + '%');
//             if(progress >= 100){
//                 timer=setTimeout(function () {
//                     $('#progress .bar').css(
//                         'width',
//                         0 + '%'
//                     );
//                     $('.barText').html('');
// //                            $('#progress').hide();
// //                            $('.barText').hide();
//                 },2000);
//
//             }
//         },
//         done: function (e, data) {
//             if (data.result.obj != undefined) {
//                 var data = data.result.obj;
//                 var str = '';
//                 var str1 = '';
//                 for (var i = 0; i < data.length; i++) {
//                         str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" style="color: #000;" NAME="'+data[i].attachName+'*" href="javascript:;">'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';
//                 }
//                 $('#fileAll').append(str);
//             }
//         }
//     });

    $('.tijiaobtn').click(function () {
        if(!$('#ajaxform select[name="typeId"]').val()){
            layer.msg('请'+noticeType+'!',{icon:0});
            return false
        }
        var isEdit=isPublish(getRequestObj.notifyId)
        if(isEdit==1){
            $.layerMsg({content:'该条公告已生效！',icon:0},function () {
                parent.window.location.reload()
            });
            return false
        }
        layer.open({
            title:SubmitExaminationApproval,
            content:'' +
            '<ul class="formUl">' +
            '<li class="clearfix"><label>'+hr_th_Approver+'：</label><select name="shenpiren" id=""><option value="">'+ds+'</option></select></li>' +
            '<li class="clearfix"><label>'+tixing+'：</label><label><input checked="checked" id="chcekedLab" type="checkbox" style="float: none">'+notice_th_remindermessage+'</label></li>' +
            '</ul>',
            btn:[sure,cancel],
            success:function () {
                $('input[name="tuisong"]').val('1');
                $.get('/mySys/getDeptManagers?specifyTable='+specifyTable,function (json) {
                    if(json.flag){
                        var arr=json.obj;
                        var str='<option value="">'+ds+'</option>';
                        for(var i=0;i<arr.length;i++){
                            str+='<option value="'+arr[i].userId+'">'+arr[i].userName+'</option>'
                        }
                        $('[name="shenpiren"]').html(str)

                    }
                },'json')
                $('#chcekedLab').click(function () {
                    var state =$(this).prop("checked");
                    if(state==true){
                        $(this).prop("checked",true);
                        $('input[name="approveRemind"]').val('1');
                        $('input[name="tuisong"]').val('1');
                        $('input[name="remind"]').val('1');
                    }else{
                        $(this).prop("checked",false);
                        $('input[name="approveRemind"]').val('0');
                        $('input[name="tuisong"]').val('0');
                        $('input[name="remind"]').val('0');
                    }
                })
            },
            yes:function (index) {

                if($('[name="shenpiren"] option:selected').val() == ''){
                    layer.msg('请选择审批人！',{icon:6});
                }else {
                    $('[name="auditer"]').val($('[name="shenpiren"]').val());
                    ajaxforms(2)
                }
            }
        })
    });




    $(document).on('click','.deImgs',function(){
        var data=$(this).parents('.dech').attr('deUrl');
        var dome=$(this).parents('.dech');
        layer.confirm(ConfirmAttachments, {
            btn: [sure,cancel], //按钮
            title:ifDelete
        }, function() {
            //确定删除，调接口
            $.ajax({
                type: 'get',
                url: '../delete',
                dataType: 'json',
                data: data,
                success: function (res) {
                    if (res.flag) {
                        layer.msg(delc, {icon: 6});
                        dome.remove();
                    } else {
                        layer.msg(delf, {icon: 6});
                    }
                }
            })
        })
    });

    $(document).on('click','.cleardate',function () {
        $(this).siblings('textarea').val('');
        $(this).siblings('textarea').attr('user_id','');
        $(this).siblings('textarea').attr('deptid','');
        $(this).siblings('textarea').attr('deptname','');
        $(this).siblings('textarea').attr('privid','');
        $(this).siblings('textarea').attr('userpriv','');
        $(this).siblings('textarea').attr('username','');
        $(this).siblings('textarea').attr('dataid','');
        $(this).siblings('textarea').attr('userprivname','');
    })
});
