/**
 * author:殷冬
 * time2018-05-12
 * vision:1.0.0
 */
var getRequestObj=$.GetRequest();;
var user_id=null;
var dept_id=null;
var priv_id=null;
var ue=null;

function GetDropDownBox(fn) {
    $.ajax({
        url: "/sys/getNotifyTypeList",
        type:'get',
        dataType:"JSON",
        data : {"CodeNos":"NOTIFY"},
        success:function(data){
            var str='<option value="" data-isEdit="'+data.object.isEdit+'">'+notice_type_alltype+'</option>';

            var arr=data.obj;
            for(var i=0;i<arr.length;i++){
                str += '<option value="'+arr[i].codeNo+'" data-isEdit="'+arr[i].isEdit+'">'+arr[i].codeName+'</option>'

            }
            $('[name="typeId"]').html(str)
            if(fn!=undefined){
                fn()
            }
        }

    })
}
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
var dataobj={istime: true, format: 'YYYY-MM-DD',min:queryTime(1)};
function typeIdStatic(me) {
    if($(me).find('option:selected').attr('data-isEdit')=='1'){
        $('.tijiaobtn').show();
        $('.sendbtn').hide()
    }else {
        $('.tijiaobtn').hide();
        $('.sendbtn').show()
    }
}
function addforms(){
    console.log("meijinlai ");
}

function ajaxforms(type) {
    layer.load();
    var dutyId = getRequestObj.dutyId;
    $('[name="tuisong"]').val(type);


    $('.theControlData').each(function () {
        if($(this).attr('user_id')!=undefined) {
            $(this).siblings('input[type=hidden]').val($(this).attr('user_id'));
            return true;
        }
        if($(this).attr('userpriv')!=undefined){
            $(this).siblings('input[type=hidden]').val($(this).attr('userpriv'));
            return true
        }
        if($(this).attr('deptid')!=undefined){
            $(this).siblings('input[type=hidden]').val($(this).attr('deptid'))
        }
    })
    var filearr=$('.dech');
    var aId='';
    var uId='';
    for(var i=0;i<filearr.length;i++){
        aId+=$(filearr[i]).find('input').val();
        uId+=$(filearr[i]).find('a').attr('name');
    }
    $('[name="attachmentId"]').val(aId);
    $('[name="attachmentName"]').val(uId);
    if(type==1){
        if(getRequestObj.notifyId!=undefined){
            $('[name="lastEditTimes"]').val(queryTime())
        }
    }
    $("#getWeekTime").val($("#weekTime").val());
    if(bumentype == 0){
        if($('#department').val()!=''){

            $("#dutyId").val(dutyId);
            $('#ajaxform').ajaxSubmit({
                type: 'post',
                dataType: 'json',
                success: function (data) {
                    layer.closeAll();
                    if (data) {
                        $.layerMsg({content: SuccessfulOperation, icon: 1}, function () {
                            $("#sttt",window.parent.document).click();
                        });
                    } else {
                        $.layerMsg({content: networkError, icon: 2});
                    }

                }
            })
        }else{
            $.layerMsg({content: '按部门发布不能为空', icon: 2},function () {
                layer.closeAll("loading");
            });
        }
    }else{
        if($('#department').val()!=""){
        if($('#roleall').val()!=''||$('#personnel').val()!=''){
            $('#ajaxform').ajaxSubmit({
                type: 'post',
                dataType: 'json',
                success: function (json) {
                    layer.closeAll();
                    if (json.flag) {
                        $.layerMsg({content: SuccessfulOperation, icon: 1}, function () {
                            $("#sttt",window.parent.document).click();
                        });
                    } else {
                        $.layerMsg({content: networkError, icon: 2});
                    }

                }
            })
        }else{
            $.layerMsg({content: '按角色或者人员发布不能全部为空', icon: 2},
                function () {
                layer.closeAll("loading");
            });
        }
    }else{
            $.layerMsg({content: '按部门发布不能为空', icon: 2},function () {
                layer.closeAll("loading");
            });
        }
    }
}
// type 用来控制按部门发布或是按照人员或角色发布  0为部门 1为人员或角色发布
var bumentype = 0
$(function () {
    var dutyId = getRequestObj.dutyId;
    if(dutyId !=undefined){
        $("#Title").html("修改值班表");
        //根据主键id获取值班表信息
        $.ajax({
            url: '/dutyManagement/getDutyFormById',
            type: 'get',
            data: {
                dutyId: dutyId
            },
            dataType: 'json',
            success: function (data) {
                $('#department').val(data.toIdStr);
                $('#department').attr('deptid',data.toId);
                if(data.privId!=''){
                    $('#roleall').attr('userpriv',data.privId);
                    $('#roleall').val(data.privIdStr);
                    $('#roleall').parent().parent().show()
                }

                if(data.userId!='') {
                    $('#personnel').val(data.userIdStr);
                    $('#personnel').attr('user_id', data.userId);
                    $('#personnel').parent().parent().show()
                }
                var data1 = data.attachmentList;
                var str = '';
                var str1 = '';
                for (var i = 0; i < data1.length; i++) {
                    str+='<div class="dech" deUrl="'+encodeURI(data1[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" NAME="'+data1[i].attachName+'*" href="/download?'+encodeURI(data1[i].attUrl)+'">'+data1[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data1[i].attachName+'*"  class="inHidden" value="'+data1[i].aid+'@'+data1[i].ym+'_'+data1[i].attachId+',"></div>';
                }
                $('#files_txt').append(str);
                $("#startTime").val(data.startTime);
                $("#endTime").val(data.endTime);
                $("#weekTime").val(data.week);
                $("#dateTime").val(data.dateTime);
                $("#leaderClass").val(data.leaderClass);
                $("#dayClass").val(data.dayClass);
                $("#nightClass").val(data.nightClass);
                $("#chanceClass").val(data.chanceClass);
                $("#secretary").val(data.secretary);
                $("#driveClass").val(data.driveClass);
                $('#ajaxform').attr('action','/dutyManagement/dutyFormManagementUpdate');
            }
        })
    }else{
        $("#Title").html("添加值班表");
        $('#ajaxform').attr('action','/dutyManagement/addDutyFormManagement');
    }
  
    // ue = UE.getEditor('word_container',{elementPathEnabled : false});

    $('.deptandrole').on("click",function () {
        if($('.deptrole').is(':hidden')){
            $('.deptrole').show();
            bumentype = 1
        }else {
            $('.deptrole').hide();
            bumentype = 0;
        }
    });



    $('[name="remindTixing"]').on("click",function () {
        if($(this).is(':checked')){
            $(this).siblings('input').val(1)
        }else {
            $(this).siblings('input').val(0)
        }
    });

    $('[name="topDing"]').on("click",function () {
        if($(this).is(':checked')){
            $(this).siblings('input[type=hidden]').val(1)
        }else {
            $(this).siblings('input[type=hidden]').val(0)
        }
    });

    $('[name="smsRemind"]').on("click",function () {
        if($(this).is(':checked')){
            $(this).nextAll('input[type=hidden]').val(0)
        }else {
            $(this).nextAll('input[type=hidden]').val(1)
        }
    });

    $('#download_ck').on("click",function () {
        if($(this).is(':checked')){
            $(this).siblings('input[type=hidden]').val(1)
        }else {
            $(this).siblings('input[type=hidden]').val(0)
        }
    });

    $('.addControls').on("click",function () {
        var type=$(this).attr('data-type');

        if(type==1){
            dept_id=$(this).siblings('textarea').prop('id');
            // $("#roleall").val("");
            // $("#personnel").val("");
            $.popWindow("../common/selectDept");

        }else if(type==2){
            priv_id=$(this).siblings('textarea').prop('id');
            // $("#department").val("");
            // $("#personnel").val("");
            $.popWindow("../common/selectPriv?1");
        }else if(type==3){
            user_id = $(this).siblings('textarea').prop('id');
            // $("#department").val("");
            // $("#roleall").val("");
            $.popWindow("../common/selectUser");
        }
    });

    $('.recoveryTime').on("click",function () {
        $(this).siblings('input').val(queryTime())
    });

    $('#fileupload').fileupload({
        dataType: 'json',
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progress .bar').css(
                'width',
                progress + '%'
            );
            $('.barText').html(progress + '%');
            if(progress >= 100){  //判断滚动条到100%清除定时器
                timer=setTimeout(function () {
                    $('#progress .bar').css(
                        'width',
                        0 + '%'
                    );
                    $('.barText').html('');
                },2000);

            }
        },
        done: function (e, data) {
            if (data.result.obj != undefined) {
                var data = data.result.obj;
                var str = '';
                var str1 = '';
                for (var i = 0; i < data.length; i++) {
                        str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" NAME="'+data[i].attachName+'*" href="/download?'+encodeURI(data[i].attUrl)+'">'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';
                }
                $('#files_txt').append(str);
            }
        }
    });








        //$('.navigation').find('h2').text(notice_th_newnotify);

        GetDropDownBox(function () {
            if($('[name="typeId"]').find('option:selected').attr('data-isEdit')==1){
                $('.sendbtn').hide();
                $('.tijiaobtn').show()
            }
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
        $(this).siblings('textarea').attr('userpriv','')
    })

});
