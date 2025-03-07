
var getRequestObj=$.GetRequest();
var user_id=null;
var dept_id=null;
var priv_id=null;
var ue=null;

function ajaxforms(type) {
    $('#ajaxform').ajaxSubmit({
        type: 'post',
        dataType: 'json',
        success: function (json) {
            if (json.flag) {
                $.layerMsg({content: SuccessfulOperation, icon: 1}, function () {
                    parent.$('[name="notices"]').attr('src','/censor/FilterWordManagement')
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

    // $('.tijiaobtn').click(function () {
    //     layer.open({
    //         title:SubmitExaminationApproval,
    //         content:'' +
    //         '<ul class="formUl">' +
    //         '<li class="clearfix"><label>'+hr_th_Approver+'：</label><select name="shenpiren" id=""><option value="">'+ds+'</option></select></li>' +
    //         '<li class="clearfix"><label>'+tixing+'：</label><label><input checked="checked" type="checkbox" style="float: none">'+notice_th_remindermessage+'</label></li>' +
    //         '</ul>',
    //         btn:[sure,cancel],
    //         success:function () {
    //             $.get('/sys/getDeptManagers',function (json) {
    //                 if(json.flag){
    //                     var arr=json.obj;
    //                     var str='<option value="">'+ds+'</option>';
    //                     for(var i=0;i<arr.length;i++){
    //                         str+='<option value="'+arr[i].userId+'">'+arr[i].userName+'</option>'
    //                     }
    //                     $('[name="shenpiren"]').html(str)
    //
    //                 }
    //             },'json')
    //         },
    //         yes:function (index) {
    //             $('[name="auditer"]').val($('[name="shenpiren"]').val());
    //             ajaxforms(2)
    //         }
    //     })
    // });






    if(getRequestObj.type=='new'){
        $('.navigation').find('h2').text(censor_th_addword);
        $('#ajaxform').attr('action','/censor/addCensorWords');
        // $('[name="sendTimes"]').val(queryTime());


        GetDropDownBox(function () {
            if($('[name="find"]').find('option:selected').attr('data-isEdit')==1){
                $('.sendbtn').hide();
                $('.tijiaobtn').show()
            }
        });
        $('[name="beginDates"]').val(queryTime(1))

    }else {
        $('.navigation').find('h2').text(censor_th_updateword);
        $('#ajaxform').attr('action','updateCensorWords');
        $('[name="find"]').val(getRequestObj.find);
        // ue.ready(function () {
            $.get('getCensorWordsInforById',{
                wordId:getRequestObj.wordId
            },function (json) {
                if(json.flag){
                    var obj=json.object;
                    var arr=$('input');
                    $('[name="wordId"]').val(obj.wordId);
                    $('[name="find"]').val(obj.find);
                    $('[name="replacement"]').val(obj.replacement);

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

