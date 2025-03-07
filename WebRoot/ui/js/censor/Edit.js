
var getRequestObj=$.GetRequest();
var user_id=null;
var dept_id=null;
var priv_id=null;
var ue=null;

// function GetDropDownBox(fn) {
//     $.ajax({
//         url: "/sys/getNotifyTypeList",
//         type:'get',
//         dataType:"JSON",
//         data : {"CodeNos":"NOTIFY"},
//         success:function(data){
//             var str='<option value="" data-isEdit="'+data.object.isEdit+'">'+notice_type_alltype+'</option>';
//
//             var arr=data.obj;
//             for(var i=0;i<arr.length;i++){
//                 str += '<option value="'+arr[i].codeNo+'" data-isEdit="'+arr[i].isEdit+'">'+arr[i].codeName+'</option>'
//
//             }
//             $('[name="typeId"]').html(str)
//             if(fn!=undefined){
//                 fn()
//             }
//         }
//
//     })
// }
// function queryTime(type){
//     function p(s) {
//         return s < 10 ? '0' + s: s;
//     }
//     var myDate = new Date();
//     //获取当前年
//     var year=myDate.getFullYear();
//     //获取当前月
//     var month=myDate.getMonth()+1;
//     //获取当前日
//     var date=myDate.getDate();
//     var h=myDate.getHours();       //获取当前小时数(0-23)
//     var m=myDate.getMinutes();     //获取当前分钟数(0-59)
//     var s=myDate.getSeconds();
//     var now=year+'-'+p(month)+"-"+p(date)+" "+p(h)+':'+p(m)+":"+p(s);
//     if(type==undefined){
//         return now;
//     }else {
//         return year+'-'+p(month)+"-"+p(date)
//     }
//
// }
// var dataobj={istime: true, format: 'YYYY-MM-DD',min:queryTime(1)};
// function typeIdStatic(me) {
//     if($(me).find('option:selected').attr('data-isEdit')=='1'){
//         $('.tijiaobtn').show();
//         $('.sendbtn').hide()
//     }else {
//         $('.tijiaobtn').hide();
//         $('.sendbtn').show()
//     }
// }


function ajaxforms(type) {

    // if(type==0) {
    //     if(getRequestObj.type!='edit'){
    //         $('[name="publish"]').val(type);
    //     }else {
    //         $('[name="publish"]').val('');
    //
    //     }
    //
    // }else {
    //     $('[name="publish"]').val(type);
    //
    //
    //
    // }
    // $('[name="tuisong"]').val(type);
    // if(type==2){
    //     $('[name="tuisong"]').val(0);
    // }

    // $('.theControlData').each(function () {
    //     if($(this).attr('user_id')!=undefined) {
    //         $(this).siblings('input[type=hidden]').val($(this).attr('user_id'));
    //         return true;
    //     }
    //     if($(this).attr('userpriv')!=undefined){
    //         $(this).siblings('input[type=hidden]').val($(this).attr('userpriv'));
    //         return true
    //     }
    //     if($(this).attr('deptid')!=undefined){
    //         $(this).siblings('input[type=hidden]').val($(this).attr('deptid'))
    //     }
    // })
    // var filearr=$('#fileAll .dech');
    // var aId='';
    // var uId='';
    // for(var i=0;i<filearr.length;i++){
    //     aId+=$(filearr[i]).find('input').val();
    //     uId+=$(filearr[i]).find('a').attr('name');
    // }
    // $('[name="attachmentId"]').val(aId);
    // $('[name="attachmentName"]').val(uId);
    // $('[name="content"]').val(ue.getContent());
    // if(type==1){
    //     if(getRequestObj.notifyId!=undefined){
    //         $('[name="lastEditTimes"]').val(queryTime())
    //     }
    // }
    $('#ajaxform').ajaxSubmit({
        type: 'post',
        dataType: 'json',
        success: function (json) {
            if (json.flag) {
                $.layerMsg({content: SuccessfulOperation, icon: 1}, function () {
                    parent.$('[name="notices"]').attr('src','/censor/ModuleSettings')
                    parent.$('.head-top ul li').removeClass('active')
                    $((parent.$('.head-top ul li'))[0]).addClass('active')
                });
            } else {
                $.layerMsg({content: networkError, icon: 2});
            }

        }
    })
}

$(function () {
    ue = UE.getEditor('word_container',{elementPathEnabled : false});


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

    //点击保存

    // $('.savebtn').click(function () {
    //     var data={
    //         find:$('input[name="subject"]').val(),
    //         replacement:$('input[name="replacement"]').val(),
    //
    //     }
    //     $.ajax({
    //         type:'post',
    //         // url:'/censor/addCensorWords',
    //         dataType:'json',
    //         data:data,
    //         success:function (res) {
    //             if(res.flag){
    //                 layer.msg('保存成功！',{icon:1});
    //             }else {
    //                 layer.msg('保存失败！',{icon:1});
    //             }
    //         }
    //     })
    // })

    $('.addControls').click(function () {
        var type=$(this).attr('data-type');

        if(type==1){
            dept_id=$(this).siblings('textarea').prop('id');
            $.popWindow("../common/selectDept");
        }else if(type==2){
            priv_id=$(this).siblings('textarea').prop('id');
            $.popWindow("../common/selectPriv");
        }else if(type==3){
            user_id = $(this).siblings('textarea').prop('id');
            $.popWindow("../common/selectUser");
        }
    });

    $('.recoveryTime').click(function () {
        $(this).siblings('input').val(queryTime())
    });

    $('#fileupload').fileupload({
        dataType: 'json',
        done: function (e, data) {
            if (data.result.obj != undefined) {
                var data = data.result.obj;
                var str = '';
                var str1 = '';
                for (var i = 0; i < data.length; i++) {
                        str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" NAME="'+data[i].attachName+'*" href="/download?'+encodeURI(data[i].attUrl)+'">'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';
                }
                $('#fileAll').append(str);
            }
        }
    });

    $('.tijiaobtn').click(function () {
        layer.open({
            title:SubmitExaminationApproval,
            content:'' +
            '<ul class="formUl">' +
            '<li class="clearfix"><label>'+hr_th_Approver+'：</label><select name="shenpiren" id=""><option value="">'+ds+'</option></select></li>' +
            '<li class="clearfix"><label>'+tixing+'：</label><label><input checked="checked" type="checkbox" style="float: none">'+notice_th_remindermessage+'</label></li>' +
            '</ul>',
            btn:[sure,cancel],
            success:function () {
                $.get('/sys/getDeptManagers',function (json) {
                    if(json.flag){
                        var arr=json.obj;
                        var str='<option value="">'+ds+'</option>';
                        for(var i=0;i<arr.length;i++){
                            str+='<option value="'+arr[i].userId+'">'+arr[i].userName+'</option>'
                        }
                        $('[name="shenpiren"]').html(str)

                    }
                },'json')
            },
            yes:function (index) {
                $('[name="auditer"]').val($('[name="shenpiren"]').val());
                ajaxforms(2)
            }
        })
    });



    $('[name="startUsing"]')


    if(getRequestObj.type=='new'){
        $('.navigation').find('h2').text();
        $('#ajaxform').attr('action','/censor/addCensorModule');
        // $('[name="sendTimes"]').val(queryTime());


        GetDropDownBox(function () {
            if($('[name="moduleCode"]').find('option:selected').attr('data-isEdit')==1){
                $('.sendbtn').hide();
                $('.tijiaobtn').show()
            }
        });
        $('[name="beginDates"]').val(queryTime(1))

    }else {
        $('.navigation').find('h2').text(censor_th_modulesettings);
        $('#ajaxform').attr('action','updateCensorModule');
        $('[name="moduleCode"]').val(getRequestObj.moduleCode);
        // ue.ready(function () {
            $.get('getCensorModuleInforById',{
                moduleId:getRequestObj.moduleId
            },function (json) {
                if(json.flag){
                    var obj=json.object;
                    var arr=$('input');
                    $('[name="moduleId"]').val(obj.moduleId);
                    $('[name="moduleCode"]').val(obj.moduleCode);
                    $('[name="startUsing"]').val(obj.startUsing);
                    $('[name="checkUser"]').val(obj.checkUser);
                    $('[name="smsRemind"]').val(obj.smsRemind);
                    $('[name="sms2Remind"]').val(obj.sms2Remind);
                    $('[name="bannedHint"]').val(obj.bannedHint);
                    $('[name="modHint"]').val(obj.modHint);
                    $('[name="filterHint"]').val(obj.filterHint);

                    if(obj.userId!='') {
                        $('#personnel').val(obj.userrange);
                        $('#personnel').attr('user_id', obj.userId);
                        $('#personnel').parent().parent().show()
                    }

                    var data = obj.attachment;
                    var str = '';
                    var str1 = '';
                    for (var i = 0; i < data.length; i++) {
                        str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;">' +
                            '<a class="ATTACH_a" NAME="'+data[i].attachName+'*" href="/download?'+encodeURI(data[i].attUrl)+'">'+data[i].attachName+'' +
                            '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/>' +
                            '<input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',">' +
                            '</div>';
                    }
                    $('#fileAll').append(str);





                }else {
                    $.layerMsg({content: networkError, icon: 2});
                }
            },'json')
        // })

    }


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
        $(this).siblings('textarea').attr('userpriv','')
    })
});

