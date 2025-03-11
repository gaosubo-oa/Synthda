$(function () {
    $('.inbox_btn').on('click',function () {

        if ($(this).siblings('.ul_show').css('display')=='none') {
            $(this).find('div').removeClass('div_up').addClass('div_down')
            $(this).siblings('.ul_show').slideDown();
        }else{
            $(this).find('div').removeClass('div_down').addClass('div_up')
            $(this).siblings('.ul_show').slideUp();
        }

    })
    $('.page_left li').on('click',function () {
        $('.page_left li').removeClass('on');
        $(this).addClass('on');
    })

    // 高度设置
    $('.noEmail').height($('.up_page_right').height()-$('.up_header').height());

    $('.setUp').on('click',function(e){
        e.stopPropagation();
        $('.set_up_ul').toggle();
    })

    $(document).on('click',function(){
        if($('.set_up_ul').css('display')=='block'){
            $('.set_up_ul').css('display','none');
        }
        if($('.signDiv').css('display')=='block'){
            $('.signDiv').css('display','none');
        }
    })
    //其他邮件箱
    parenttest();

    //其他邮件箱下的文件夹点击事件
    $('.divUlShow').on('click','.otherLi',function(){
        var id=$(this).attr('boxId');
        $('#iframeEmailList').attr('src', '/email/emailList?boxStyle=otherBox&id='+id);
        $('#delete').attr('data-box',id);
        $('#delete').attr('data-deletetype','otherBox');
        $('#allEmail').css('display','block');
        $('#delete').css('display','block');
        $('#Replay').css('display','none');
        $('#ReplayAll').css('display','none');
        $('#Forward').css('display','none');
        $('#RemoveTo').css('display','none');
        $('.div_iframeOne').css('display','none');
        $('.up_page_right').css('display','block');
        $('.up_pages').css('display','none');
        $('#withdraw').css('display','none');
    })


    //点击移动按钮事件
    $('#RemoveTo').on('click',function(e){
        e.stopPropagation();
        $('.RemoveTo_div').toggle();
    })
    $(document).on('click',function(){
        if ($('.RemoveTo_div').css('display')=='block'){
            $('.RemoveTo_div').css('display','none');
        }
    })
    //点击移动按钮下的文件夹
    $('.RemoveTo_div').on('click','.RemoveTo_child',function(){
        var id=$(this).attr('boxId');
        var dataHengNum=$('#delete').attr('dataHeng');
        var emailId='';
        var arrId=[];
        if(dataHengNum == 'true'){
            emailId=$("#iframeEmailListUp").contents().find(".tab .backList").attr('Attr');
            $("#iframeEmailListUp").contents().find(".checkboxChild:checkbox:checked").each(function(){
                var sId=$(this).parents('.Hover').attr('Attr');
                arrId.push(sId);
            })
        }else{
            emailId=$("#iframeEmailList").contents().find(".befor .backing").find('input[type="hidden"]').attr('id');
            $("#iframeEmailList").contents().find(".chekEmail:checkbox:checked").each(function(){
                var sId=$(this).parents('.BTN').find('input[type="hidden"]').attr('id');
                arrId.push(sId);
            })
        }

        if(dataHengNum == 'true'){
            RemoveToMail(id,arrId);
        }else{
            if($("#iframeEmailList").contents().find(".befor .chekEmail").css('display') == 'inline-block'){
                RemoveToMail(id,arrId);
            }else {
                RemoveToMailDan(id,emailId);
            }
        }
    })

    //全部邮件
    $('#allEmail').on('click',function(e){
        $('.allEmail_div').toggle();
        e.stopPropagation();
    })
    $(document).on('click',function(){
        if ($('.allEmail_div').css('display')=='block'){
            $('.allEmail_div').css('display','none');
        }
    })
    //全部邮件内容点击
    $('.allEmail_div').on('click','li',function(){
        var allId=$(this).attr('attrAll');
        var id=$('.on').attr('boxId');
        var boxType=$('.on').attr('id');
        var data1={
            "flag":'inbox',
            "page":1,
            "pageSize":15,
            "useFlag":true,
            "searchCriteria":'',
            "orderByName":'',
            "orderWhere":'',
            "isWebmail":allId
        };
        var data2={
            "flag":'drafts',
            "page":1,
            "pageSize":15,
            "useFlag":true,
            "searchCriteria":'',
            "orderByName":'',
            "orderWhere":allId
        };
        var data3={
            "flag":'outbox',
            "page":1,
            "pageSize":15,
            "useFlag":true,
            "searchCriteria":'',
            "orderByName":'',
            "orderWhere":'',
            "isWebmail":allId
        };
        var data4={
            "flag":'recycle',
            "page":1,
            "pageSize":15,
            "useFlag":true,
            "searchCriteria":'',
            "orderByName":'',
            "orderWhere":'',
            "isWebmail":allId
        };
        if(boxType == 'InBox'){
            $('.on').trigger('click');
        }else if(boxType == 'drafts'){
            btnClick(data2,'showEmail');
        }else if(boxType == 'hasBeenSend'){
            btnClick(data3,'showEmail');
        }else if(boxType == 'wastebasket'){
            btnClick(data4,'showEmail');
        }
    })

    //点击撤回
    $('#withdraw').on('click',function(){
        var id=$("#iframeEmailList").contents().find(".befor .backing").find('input[type="hidden"]').attr('nid');
        layer.open({
            type:1,
            title:withdrawal,
            area:['320px','200px'],
            btn:[sure,cancel],
            content:'<div>' +
                '<p style="font-size: 16px;margin: 20px;">'+decide1+'</p>' +
                '<p style="font-size: 14px;margin-left: 20px;">'+already+'</p>' +
                '</div>',
            yes:function(index){
                $.ajax({
                    type:'get',
                    url:'/email/updateEmailWithdraw',
                    dataType:'json',
                    data:{bodyId:id},
                    success:function(res){
                        var datas=res.obj;
                        var str='';
                        for(var i=0;i<datas.length;i++){
                            str+='<tr><td style="text-align: center;">'+datas[i].userName+'</td>';
                            if(datas[i].readFlag == '0'){
                                str+='<td style="color:#11cd6d;text-align: center;">'+Revocation+'</td></tr>';
                            }else if(datas[i].withdrawFlag=='1'){
                                str+='<td style="color:#11cd6d;text-align: center;">'+Revocation+'</td></tr>';
                            }else{
                                str+='<td style="color:#f00;text-align: center;">'+failure+'</td></tr>';
                            }
                        }
                        layer.open({
                            type:1,
                            title:Mailwithdrawal,
                            area:['400px','300px'],
                            btn:[global_lang_close],
                            content:'<div style="width: 100%;margin-top: 15px;">' +
                                '<table id="divTbaleText" style="width: 96%;margin: 0 auto;font-size: 14px;">' +
                                '<thead>' +
                                '<tr>' +
                                '<th>'+email_th_recipients+'</th><th>'+state+'</th>' +
                                '</tr>' +
                                '</thead>' +
                                '<tbody id="div_tbody">' +
                                '</tbody>'+
                                '</table>' +
                                '</div>',
                            success:function(){
                                $('#div_tbody').append(str);
                            }
                        })

                    }
                })
                layer.close(index);
            }
        })
    })

})

function RemoveToMail (id,emailId){
    var data={
        'boxId':id,
        'requestFlags':emailId
    }
    $.ajax({
        type:'post',
        url:'updateEmailBox',
        dataType:'json',
        data:data,
        success:function(){
            location.reload();
        }
    })
}
function RemoveToMailDan (id,emailId){
    var data={
        'boxId':id,
        'emailId':emailId
    }
    $.ajax({
        type:'post',
        url:'updateEmailBox',
        dataType:'json',
        data:data,
        success:function(){
            location.reload();
        }
    })
}
