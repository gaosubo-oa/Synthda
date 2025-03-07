$(function(){
    $('#txt2').trigger('focus');
    $('#AddFolder').on('click', function(){
        var Number=$('#txt1').val();
        var Name=$('#txt2').val();
        if(Number=='' || Name==''){
            $.layerMsg({content:sortAndName,icon:1});
            return false;
        }
        var data={
            'boxNo':Number,
            'boxName':Name
        }
        $.ajax({
            type:'post',
            url:'saveEmailBox',
            dataType:'json',
            data:data,
            success:function(res){
                if(res.msg == 'ok'){
                    $.layerMsg({content:depatement_th_Newsuccessfully,icon:1},function(){
                        window.parent.parenttest();
                        location.reload();
                    })
                }else if(res.msg == 'repeat'){
                      $.layerMsg({content:email_th_theSerialNumberOrNameIsDuplicated+'！',icon:2})
                }else{
                    $.layerMsg({content:depatement_th_Newfailed,icon:2})
                }

            }
        })

    })

    //新建文件夹展示
    setOtherMail ()

    //删除文件夹
    $('.TABLE_A').on('click','.deleteList',function(){
        var id=$(this).parents('tr').attr('boxId');
        deleteFolder (id)
    })

    //编辑文件夹
    $('.TABLE_A').on('click','.editList',function(){
        $('.DIV_LIST').css('display','none');
        $('.DIV_EDIT_LIST').css('display','block');
        var num=$(this).parents('tr').attr('boxNo');
        var name=$(this).parents('tr').attr('boxName');
        var boxId=$(this).parents('tr').attr('boxId');
        $('#txt3').val(num);
        $('#txt4').val(name);
        $('#txt5').val(boxId);
    })
    //点击确定
    $('#btnSure').on('click', function(){
        var data={
            'boxNo':$("#txt3").val(),
            'boxName':$("#txt4").val(),
            'boxId':$("#txt5").val()
        }

        $.ajax({
            type:'POST',
            url:'updateEmailBoxName',
            dataType:'json',
            data:data,
            success:function(rsp){
                if(rsp.msg == 'ok'){
                    $.layerMsg({content:menuSSetting_th_editSuccess,icon:1},function(){
                        window.parent.parenttest();
                        location.reload();
                    })
                }else if(rsp.msg == 'repeat'){
                    $.layerMsg({content:box_existed,icon:2})
                }else{
                    $.layerMsg({content:depatement_th_Newfailed,icon:2})
                }
            }
        })
    })

    //返回按钮
    $('#btnReturn').on('click', function(){
        $('#txt3').val();
        $('#txt4').val();
        $('.DIV_LIST').css('display','block');
        $('.DIV_EDIT_LIST').css('display','none');
    })

    var userId=$.cookie('userId');
    webMailList(userId,$('#tableList'));
    //新建邮箱按钮
    $('.newAdd').on('click', function(){
        $('.setList').show().siblings().hide();
        $('input[name="newOrEdit"]').val(new1);
        $('input[name="email"]').val('');
        $('input[name="popServer"]').val('');
        $('input[name="smtpServer"]').val('');
        $('input[name="emailUser"]').val('');
        $('input[name="emailPass"]').val('');
        $('input[name="quotaLimit"]').val('');
    })
    //配置按钮点击
    $('#tableList').on('click','#collocation',function(){
        var mailId=$(this).parents('tr').attr('mailId');
        $('.setList').show().siblings().hide();
        $('input[name="newOrEdit"]').val(meet_th_ToConfigure);
        $.ajax({
            type:'get',
            url:'selectOneWebMail',
            dataType:'json',
            data:{'userId':userId,'mailId':mailId},
            success:function(res){
                var data=res.object;
                $('input[name="email"]').val('');
                $('input[name="popServer"]').val('');
                $('input[name="smtpServer"]').val('');
                $('input[name="emailUser"]').val('');
                $('input[name="emailPass"]').val('');
                // $('#selection option:checked').val();
                // $('#selectOut option:checked').val();
                $('input[name="quotaLimit"]').val('');
                $('input[name="editId"]').val('');

                $('input[name="editId"]').val(data.mailId);
                $('input[name="email"]').val(data.email);
                $('input[name="popServer"]').val(data.popServer);
                $('input[name="smtpServer"]').val(data.smtpServer);
                $('input[name="emailUser"]').val(data.emailUser);
                $('input[name="emailPass"]').val(data.emailPass);
                $('input[name="quotaLimit"]').val(data.quotaLimit);
                $('input[name="pop3Port"]').val(data.pop3Port);
                $('input[name="smtpPort"]').val(data.smtpPort)
                if(data.smtpPass == 'no'){
                    $('#selection option[name="no"]').prop('selected',true);
                }else{
                    $('#selection option[name="yes"]').prop('selected',true);
                }
                if(data.checkFlag == '1'){
                    $('#selectOut option[name="1"]').prop('selected',true);
                }else{
                    $('#selectOut option[name="0"]').prop('selected',true);
                }
                if(data.isDefault == "1"){
                    $('input[name="isDefault"]').prop('checked',true);
                }else{
                    $('input[name="isDefault"]').prop('checked',false);
                }
                if(data.recvDel == '1'){
                    $('input[name="recvDel"]').prop('checked',true);
                }else{
                    $('input[name="recvDel"]').prop('checked',false);
                }
                if(data.recvFw == '1'){
                    $('input[name="recvFw"]').prop('checked',true);
                }else{
                    $('input[name="recvFw"]').prop('checked',false);
                }
                if(data.recvRemind == '1'){
                    $('input[name="recvRemind"]').prop('checked',true);
                }else{
                    $('input[name="recvRemind"]').prop('checked',false);
                }
                if(data.pop3Ssl == '1'){
                    $('input[name="pop3Ssl"]').prop('checked',true);
                }else{
                    $('input[name="pop3Ssl"]').prop('checked',false);
                }
                if(data.smtpSsl == '1'){
                    $('input[name="smtpSsl"]').prop('checked',true);
                }else{
                    $('input[name="smtpSsl"]').prop('checked',false);
                }
            }
        })
    })
    //删除按钮点击
    $('#tableList').on('click','#deleteMail',function(){
        var mailId=$(this).parents('tr').attr('mailId');
        deleteWebMail(mailId,userId,$('#tableList'))
    })

    //新建返回按钮
    $('.newBackBtn').on('click', function(){
        $('.setList').hide().siblings().show();
        $('input[name="email"]').val('');
        $('input[name="popServer"]').val('');
        $('input[name="smtpServer"]').val('');
        $('input[name="emailUser"]').val('');
        $('input[name="emailPass"]').val('');
        // $('#selection option:checked').val();
        // $('#selectOut option:checked').val();
        $('input[name="quotaLimit"]').val('');
    })
    //邮件地址和登录账户同步输入
    $('input[name="email"]').on('input propertychange', function() {
        $('input[name="emailUser"]').val($(this).val());
    })
    //新建确定按钮
    $('.newSureBtn').on('click', function(){
        var dataTxt=$('input[name="newOrEdit"]').val();
        var editId=$('input[name="editId"]').val();
        var isDefault='';
        var recvFw='';
        var recvDel='';
        var recvRemind='';
        var smtpSsl='';
        var pop3Ssl=''
        if($('input[name="isDefault"]').prop('checked') == true){
            isDefault='1';
        }else{
            isDefault='0';
        }
        if($('input[name="recvDel"]').prop('checked') == true){
            recvDel='1';
        }else{
            recvDel='0';
        }
        if($('input[name="recvFw"]').prop('checked') == true){
            recvFw='1';
        }else{
            recvFw='';
        }
        if($('input[name="recvRemind"]').prop('checked') == true){
            recvRemind='1';
        }else{
            recvRemind='0';
        }
        if($('input[name="pop3Ssl"]').prop('checked') == true){
            pop3Ssl='1';
        }else{
            pop3Ssl='0';
        }
        if($('input[name="smtpSsl"]').prop('checked') == true){
            smtpSsl='1';
        }else{
            smtpSsl='0';
        }
        var data={
            email:$('input[name="email"]').val(),
            popServer:$('input[name="popServer"]').val(),
            smtpServer:$('input[name="smtpServer"]').val(),
            emailUser:$('input[name="emailUser"]').val(),
            emailPass:$('input[name="emailPass"]').val(),
            smtpPass:$('#selection option:checked').val(),
            checkFlag:$('#selectOut option:checked').val(),
            quotaLimit:$('input[name="quotaLimit"]').val(),
            pop3Port:$('input[name="pop3Port"]').val(),
            smtpPort:$('input[name="smtpPort"]').val(),
            isDefault:isDefault,
            recvDel:recvDel,
            recvFw:recvFw,
            recvRemind:recvRemind,
            smtpSsl:smtpSsl,
            pop3Ssl:pop3Ssl
        }
        var datas={
            mailId:editId,
            email:$('input[name="email"]').val(),
            popServer:$('input[name="popServer"]').val(),
            smtpServer:$('input[name="smtpServer"]').val(),
            emailUser:$('input[name="emailUser"]').val(),
            emailPass:$('input[name="emailPass"]').val(),
            smtpPass:$('#selection option:checked').val(),
            checkFlag:$('#selectOut option:checked').val(),
            quotaLimit:$('input[name="quotaLimit"]').val(),
            pop3Port:$('input[name="pop3Port"]').val(),
            smtpPort:$('input[name="smtpPort"]').val(),
            isDefault:isDefault,
            recvDel:recvDel,
            recvFw:recvFw,
            recvRemind:recvRemind,
            smtpSsl:smtpSsl,
            pop3Ssl:pop3Ssl
        }
        if(dataTxt == new1){
            saveWebMail('saveWebMail',data,Newsuccessfully,userId,$('#tableList'));
        }else if(dataTxt == meet_th_ToConfigure){
            saveWebMail('updateWebMail',datas,email_th_configurationSuccessful,userId,$('#tableList'));
        }
    })

    var $inputs = $("#webEmail");
    $inputs.on('keyup', function() {
        $inputs.val($(this).val());
    });
    <!-- 数据同步 -->
    function copyob1toob(){
        var inputName = $("#webEmail").val();
        $("#webEmailUser").val(inputName);
        <!-- input输入框验证并级联其他 -->
        var reg=/@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
        var arr=str.match(reg);
        if(arr){
            var lName = returnWebPopServer(inputName);
            // 需写一个单独js事件，相关逻辑单独处理,考虑ssl安全验证的判断
            $("#webPopServer").val("pop."+lName+".com");
            $("#webSmtpServer").val("smtp."+lName+".com");
            if (returnSSLPort(lName)){
                $("#webPop3Port").val("995");
                $("#webSmtpPort").val("465");
            }
        }
    }


})

function setOtherMail (){
    var data={
        'page':1,
        'pageSize':10,
        'useFlag':true
    }
    $.ajax({
        type:'GET',
        url:'showEmailBox',
        dataType:'json',
        data:data,
        success:function(rsp){
            var data2=rsp.obj;
            var str='';
            for(var i=0;i<data2.length;i++){
                str+='<tr boxId="'+data2[i].boxId+'" boxNo="'+data2[i].boxNo+'" boxName="'+data2[i].boxName+'"><td style="text-align: center;">'+data2[i].boxNo+'</td><td style="text-align: center;">'+data2[i].boxName+'</td><td style="text-align: center;"><a class="editList" href="javascript:;">'+edit1+'</a><a class="deleteList" href="javascript:;">'+del+'</a></td></tr>'
            }
            $('.TABLE_A table').append(str);
        }
    })
}
function deleteFolder (id){
    var data={
        'page':1,
        'pageSize':6,
        'useFlag':false,
        'boxId':id
    }
    layer.confirm(ifDelete, {
        btn: [sure,cancel], //按钮
        title:notice_th_DeleteFile
    }, function(){
        //确定删除，调接口
        $.ajax({
            type:'GET',
            url:'deleteBoxEmail',
            dataType:'json',
            data:data,
            success:function(res){
                if (res.flag) {
                    layer.msg(delc, { icon:6});
                    window.parent.parenttest();
                    location.reload();
                } else {
                    layer.msg(res.msg, { icon:7});
                }
            }
        })

    }, function(){
        layer.closeAll();
    });

}

//新建或设置保存方法
function saveWebMail(url,data,txt,id,element){
    $.ajax({
        type:'post',
        url:url,
        dataType:'json',
        data:data,
        success:function(res){
            if(res.flag == true){
                $.layerMsg({content:txt,icon:1},function(){
                    $('.setList').hide().siblings().show();
                    webMailList(id,element);
                })
            }else{
                $.layerMsg({content:meet_th_SaveFailed,icon:1})
            }
        }
    })
}

//外部邮箱列表
function webMailList(id,element){
    element.find('.trList').remove();
    $.ajax({
        type:'get',
        url:'selectUserWebMail',
        dataType:'json',
        data:{'userId':id},
        success:function(res){
            var data=res.obj;
            var str='';
            for(var i=0;i<data.length;i++){
                str+='<tr class="trList" mailId="'+data[i].mailId+'"><td align="center">'+data[i].email+'</td><td align="center"><a href="javascript:;" style="margin-right: 15px" id="collocation">'+meet_th_ToConfigure+'</a><a href="javascript:;" id="deleteMail">'+del+'</a></td></tr>';
            }
            element.append(str);
        }
    })
}

//删除外部邮箱
function deleteWebMail(mId,id,element){
    layer.confirm(ifDelete, {
        btn: [sure,cancel], //按钮
        title:notice_th_DeleteFile
    }, function(){
        //确定删除，调接口
        $.ajax({
            type:'GET',
            url:'deleteWebMail',
            dataType:'json',
            data:{'mailId':mId},
            success:function(){
                layer.msg(delc, { icon:6});
                webMailList(id,element)
            }
        })

    }, function(){
        layer.closeAll();
    });
}


<!-- pop3自动填充-->
function returnWebPopServer(webEmailPop){
    var lName =  webEmailPop.lastIndexOf("@");
    return lName.substring(1,lName.indexOf("."));
}



<!-- 确认是否为SSL验证 -->
    function returnSSLPort(lName) {
    if(lName == "qq")
            return true;
    else
        return false;
    }
