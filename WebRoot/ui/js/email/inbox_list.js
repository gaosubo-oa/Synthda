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
	$('.page_left li').click(function () {
		$('.page_left li').removeClass('on');
		$(this).addClass('on');
	})

    // $('.d_im').mouseover(function(){
    //     $(this).css('background','url("../../img/email/icon_float_01.png") no-repeat');
    // });
    // $('.d_im').mouseout(function(){
    //     $(this).css('background','url("../../img/email/icon_normal_01.png") no-repeat');
    // })

    // 高度设置
    $('.noEmail').height($('.up_page_right').height()-$('.up_header').height());

    $('.setUp').click(function(e){
        e.stopPropagation();
        $('.set_up_ul').toggle();
    })
    $(document).click(function(){
        if($('.set_up_ul').css('display')=='block'){
            $('.set_up_ul').css('display','none');
        }
        if($('.signDiv').css('display')=='block'){
            $('.signDiv').css('display','none');
        }
    })
    //其他邮件箱
    //otherMail();
    parenttest();

    //其他邮件箱下的文件夹点击事件
    $('.divUlShow').on('click','.otherLi',function(){
                   $('#Forward').css('display','none');
                   $('#delete').css('display','block');
                   $('#Replay').css('display','none');
                   $('#ReplayAll').css('display','none');
                   $('#RemoveTo').css('display','none');
                   $('.div_iframeOne').css('display','none');
        if ($('.UP_INBOX').css('display')=='block'){
            $('.UP_INBOX').hide();
            $('.main').show().find('.otherMailFolder').show().siblings().hide();
        }
        $('.otherMailFolder').css('display','block').siblings().css('display','none');
        var id=$(this).attr('boxId');
        otherList(id,'','','');
    })


    //点击移动按钮事件
    $('#RemoveTo').click(function(e){
        e.stopPropagation();
        $('.RemoveTo_div').toggle();
    })
    $(document).click(function(){
        if ($('.RemoveTo_div').css('display')=='block'){
            $('.RemoveTo_div').css('display','none');
        }
    })
    //点击移动按钮下的文件夹
    $('.RemoveTo_div').on('click','.RemoveTo_child',function(){
        var id=$(this).attr('boxId');
        var emailIds=$('.main_left .backing input[type="hidden"]').attr('id');
        var arrId=[];
        $(".chekEmail:checkbox:checked").each(function(){
            var MailId=$(this).parents('.backing').find('input[type="hidden"]').attr('id');
            arrId.push(MailId);
        })
        if($('.chekEmail').css('display') == 'block'){
            RemoveToMail(id,arrId);
        }else {
            RemoveToMailDan(id,emailIds);
        }

    })
    //点击搜索图标
    $('.Search').click(function(){
        $('.search_div').toggle();
    })
    //取消搜索按钮
    // $('.cancleSpan').click(function(){
    //     $('.searchTxt').val('');
    //     $('.search_div').hide();
    //     var id=$('.on').attr('boxId');
    //     alert(id)
    //     if($('.InBox').css('display')=='block'){
    //         showAjax('inbox','#TAB','.article','','','','');
    //         $('.InBox').css('display','block').siblings().css('display','none');
    //     } else if($('.hasBeenSend').css('display')=='block'){        //已发送
    //         showAjax3("outbox",'','','','');
    //         $('.hasBeenSend').css('display','block').siblings().css('display','none');
    //     } else if($('.wastebasket').css('display')=='block'){        //废纸篓
    //         showAjax1('recycle','#TAD','.article2','','','','');
    //         $('.wastebasket').css('display','block').siblings().css('display','none');
    //     } else if($('.drafts').css('display')=='block'){			//草稿箱
    //         showAjax2('drafts','','','');
    //         $('.drafts').css('display','block').siblings().css('display','none');
    //     } else if($('.otherMailFolder').css('display')=='block'){
    //         otherList(id,'','','','');
    //     }
    // })


    //排序图标点击
    $('.sort_right').click(function(e){
        e.stopPropagation();
        $('.signDiv').toggle();
    })
    var orderNameStr=""
    var oWhereStr=""
    //排序内容点击
    $('#orderByName').on('click','li',function(){
        $(this).addClass('bgSort').siblings().removeClass('bgSort');
        orderNameStr=$(this).attr('orderByName');
        var id=$('.divUlShow').find('li.on').attr('boxid');
        if($('.InBox').css('display')=='block'){
            showAjax('inbox','#TAB','.article','',orderNameStr,oWhereStr,'');
            $('.InBox').css('display','block').siblings().css('display','none');
        } else if($('.hasBeenSend').css('display')=='block'){        //已发送
            showAjax3("outbox",'',orderNameStr,oWhereStr,'');
            $('.hasBeenSend').css('display','block').siblings().css('display','none');
        } else if($('.wastebasket').css('display')=='block'){        //废纸篓
            showAjax1('recycle','#TAD','.article2','',orderNameStr,oWhereStr,'');
            $('.wastebasket').css('display','block').siblings().css('display','none');
        } else if($('.drafts').css('display')=='block'){			//草稿箱
            showAjax2('drafts','',orderNameStr,oWhereStr);
            $('.drafts').css('display','block').siblings().css('display','none');
        } else if($('.otherMailFolder').css('display')=='block'){
            otherList(id,'',orderNameStr,oWhereStr,'');
        }
    })
    //排序内容点击
    $('#orderWhere').on('click','li',function(){
        $(this).addClass('bgSort').siblings().removeClass('bgSort');
        var id=$('.divUlShow').find('li.on').attr('boxid');
        oWhereStr=$(this).attr('orderWhere');
        if($('.InBox').css('display')=='block'){
            showAjax('inbox','#TAB','.article','',orderNameStr,oWhereStr,'');
            $('.InBox').css('display','block').siblings().css('display','none');
        } else if($('.hasBeenSend').css('display')=='block'){        //已发送
            showAjax3("outbox",'',orderNameStr,oWhereStr,'');
            $('.hasBeenSend').css('display','block').siblings().css('display','none');
        } else if($('.wastebasket').css('display')=='block'){        //废纸篓
            showAjax1('recycle','#TAD','.article2','',orderNameStr,oWhereStr,'');
            $('.wastebasket').css('display','block').siblings().css('display','none');
        } else if($('.drafts').css('display')=='block'){			//草稿箱
            showAjax2('drafts','',orderNameStr,oWhereStr);
            $('.drafts').css('display','block').siblings().css('display','none');
        } else if($('.otherMailFolder').css('display')=='block'){
            otherList(id,'',orderNameStr,oWhereStr,'');

        }
    })

    //标记已读
    $('.signReaders').click(function(){
        $('.chekEmail').prop('checked',false);
        $('.chekEmail').toggle();
    })
    $('.selectReaders').click(function(){
        if($('.chekEmail').prop('checked')==true){
            $('.chekEmail').prop('checked',false);
            $('.chekEmail').hide();
        }else{
            $('.chekEmail').show();
            $('.chekEmail').prop('checked',true);
        }


       /* var state=$(this).prop('checked');
        if(state == true){
            $(this).prop('checked',true);
            $('.childCheck').prop('checked',true);
        }else{
            $(this).prop('checked',false);
            $('.childCheck').prop('checked',false);
        }*/
    })
    //全部邮件
    $('#allEmail').click(function(e){
        $('.allEmail_div').toggle();
        e.stopPropagation();
    })
    $(document).click(function(){
        if ($('.allEmail_div').css('display')=='block'){
            $('.allEmail_div').css('display','none');
        }
    })
    //全部邮件内容点击
    $('.allEmail_div').on('click','li',function(){
        var allId=$(this).attr('attrAll');
        var id=$('.on').attr('boxId');
        if($('.InBox').css('display')=='block'){
            showAjax('inbox','#TAB','.article','','','',allId);
            $('.InBox').css('display','block').siblings().css('display','none');
        } else if($('.hasBeenSend').css('display')=='block'){        //已发送
            showAjax3("outbox",'','','',allId);
            $('.hasBeenSend').css('display','block').siblings().css('display','none');
        } else if($('.wastebasket').css('display')=='block'){        //废纸篓
            showAjax1('recycle','#TAD','.article2','','','',allId);
            $('.wastebasket').css('display','block').siblings().css('display','none');
        }  else if($('.otherMailFolder').css('display')=='block'){
            otherList(id,'','','',allId);
        }
    })

    //点击撤回
    $('#withdraw').click(function(){
        var id=$('.backing').find('input[type="hidden"]').attr('nid');
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
                            '<th>'+email_th_recipients+'</th><th>state</th>' +
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

function otherList(id,keyWord,sorName,sorWhere){
    $('.BTN').remove();
    var data={
        'page':1,
        'pageSize':10,
        'useFlag':false,
        'boxId':id,
        "searchCriteria":keyWord,
        "orderByName":sorName,
        "orderWhere":sorWhere
    }
    $.ajax({
        type:'GET',
        url:'selectBoxEmail',
        dataType:'json',
        data:data,
        success:function(rsp){
            var data1=rsp.obj;
            var str='';
            if(!rsp.flag){
                $('.div_iframeTwo').remove();
                $('.div_iframeOne').remove();
                $('.up_page_right').show();
                $('.noEmail').show().siblings().hide();
                $('.noContent').show();
            }else{
                $('.article3').html("");
                $('.noContent').hide();
                $('.up_page_right').css('display','block');
                for(var i=0;i<data1.length;i++){
                    var sendTime=new Date((data1[i].sendTime)*1000).Format('yyyy-MM-dd hh:mm');
                    if(data1[i].emailList[0].readFlag==1){
                        if(data1[i].attachmentId!=''){
                            str+='<li class="BTN folderBtn" style="cursor: pointer;"><input type="hidden" nId="'+data1[i].bodyId+'" id="'+data1[i].emailList[0].emailId+'" ueId="'+data1[i].emailList[0].deleteFlag+'"><input type="checkbox" class="chekEmail" checkId="'+data1[i].bodyId+'" style="width: 16px;display: none;"><div class="shang"><span>'+data1[i].users.userName+'</span><img src="../img/icon_read_2_03.png"/><img src="../img/icon_star_kong_03.png"/><span class="time">'+sendTime+'</span></div><div class="xia"><a href="javascript:;" class="xia_txt">'+data1[i].subject+'</a><img src="../img/icon_accessory_03.png"/></div></li>';
                        }else{
                            str+='<li class="BTN folderBtn" style="cursor: pointer;"><input type="hidden" nId="'+data1[i].bodyId+'" id="'+data1[i].emailList[0].emailId+'" ueId="'+data1[i].emailList[0].deleteFlag+'"><input type="checkbox" class="chekEmail" checkId="'+data1[i].bodyId+'" style="width: 16px;display: none;"><div class="shang"><span>'+data1[i].users.userName+'</span><img src="../img/icon_read_2_03.png"/><img src="../img/icon_star_kong_03.png"/><span class="time">'+sendTime+'</span></div><div class="xia"><a href="javascript:;" class="xia_txt">'+data1[i].subject+'</a></div></li>';
                        }

                    } else if(data1[i].emailList[0].readFlag==0){
                        if(data1[i].attachmentId!=''){
                            str+='<li class="BTN folderBtn" style="cursor: pointer;"><input type="hidden" nId="'+data1[i].bodyId+'" id="'+data1[i].emailList[0].emailId+'" ueId="'+data1[i].emailList[0].deleteFlag+'"><input type="checkbox" class="chekEmail" checkId="'+data1[i].bodyId+'" style="width: 16px;display: none;"><div class="shang"><span>'+data1[i].users.userName+'</span><img src="../img/icon_notread_1_03.png"/><img src="../img/icon_star_kong_03.png"/><span class="time">'+sendTime+'</span></div><div class="xia"><a href="javascript:;" class="xia_txt">'+data1[i].subject+'</a><img src="../img/icon_accessory_03.png"/></div></li>';
                        }else{
                            str+='<li class="BTN folderBtn" style="cursor: pointer;"><input type="hidden" nId="'+data1[i].bodyId+'" id="'+data1[i].emailList[0].emailId+'" ueId="'+data1[i].emailList[0].deleteFlag+'"><input type="checkbox" class="chekEmail" checkId="'+data1[i].bodyId+'" style="width: 16px;display: none;"><div class="shang"><span>'+data1[i].users.userName+'</span><img src="../img/icon_notread_1_03.png"/><img src="../img/icon_star_kong_03.png"/><span class="time">'+sendTime+'</span></div><div class="xia"><a href="javascript:;" class="xia_txt">'+data1[i].subject+'</a></div></li>';
                        }

                    }

                }
                $('.befor').after(str);
                $('li.BTN').eq(0).addClass('backing')
                var emailId=$('.main_left .backing').find('input').attr('id');
                folderDetails(emailId);
            }
        }
    })
}
function folderDetails(eId){
    $.ajax({
        type:'get',
        url:'queryByID',
        dataType:'json',
        data:{'emailId':eId,'flag':''},
        success:function(rsp){
            var data2=rsp.object;
            var sendTime=new Date((data2.sendTime)*1000).Format('yyyy-MM-dd hh:mm');
            var str='';
            var stra='';
            var arr=new Array();
            arr=data2.attachment;
            $('#TAE').find('tr').remove();
            $('.article3').find('p').remove();

            $('.article3').find('div').remove();

            if(data2.attachmentName!='' && data2.copyName!=''){
                for(var i=0;i<arr.length;i++){
                    stra+='<div><a href="/download?'+arr[i].attUrl+'"><img src="../img/huixingzhen.png"/>'+arr[i].attachName+'</a></div>';
                }
                str='<tr><td style="width:70px;">'+notice_th_title+'：</td><td width="60%" style="display:block;white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" title="'+data2.subject+'">'+data2.subject+'</td></tr><tr><td>'+email_th_recipients+'：</td><td>'+data2.users.userName+'</td></tr><tr><td>'+email_th_recipients+'：</td><td><span><img src="../img/icon_read_3_07.png"/>'+data2.emailList[0].toName+'</span></td></tr><tr><td>'+email_th_carbonCopyRecipients+'：</td><td>'+data2.copyName+'</td></tr><tr><td>'+email_th_time+'：</td><td>'+sendTime+'</td></tr><tr><td>'+email_th_file+'：</td><td class="attachment">'+stra+'</td></tr>';
            } else if(data2.attachmentName=='' && data2.copyName!=''){
                str='<tr><td style="width:70px;">'+notice_th_title+'：</td><td width="60%" style="display:block;white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" title="'+data2.subject+'">'+data2.subject+'</td></tr><tr><td>'+email_th_recipients+'：</td><td>'+data2.users.userName+'</td></tr><tr><td>'+email_th_recipients+'：</td><td><span><img src="../img/icon_read_3_07.png"/>'+data2.emailList[0].toName+'</span></td></tr><tr><td>'+email_th_carbonCopyRecipients+'：</td><td>'+data2.copyName+'</td></tr><tr><td>'+email_th_time+'：</td><td>'+sendTime+'</td></tr>';
            } else if(data2.attachmentName!='' && data2.copyName ==''){
                for(var i=0;i<arr.length;i++){
                    stra+='<div><a href="/download?'+arr[i].attUrl+'"><img src="../img/huixingzhen.png"/>'+arr[i].attachName+'</a></div>';
                }
                str='<tr><td style="width:70px; ">'+notice_th_title+'：</td><td width="60%" style="display:block;white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" title="'+data2.subject+'">'+data2.subject+'</td></tr><tr><td>'+email_th_recipients+'：</td><td>'+data2.users.userName+'</td></tr><tr><td>'+email_th_recipients+'：</td><td><span><img src="../img/icon_read_3_07.png"/>'+data2.emailList[0].toName+'</span></td></tr><tr><td>'+email_th_time+'：</td><td>'+sendTime+'</td></tr><tr><td>'+email_th_file+'：</td><td class="attachment">'+stra+'</td></tr>';
            } else{
                str='<tr><td style="width:70px;">'+notice_th_title+'：</td><td width="60%" style="display:block;white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" title="'+data2.subject+'">'+data2.subject+'</td></tr><tr><td>'+email_th_recipients+'：</td><td>'+data2.users.userName+'</td></tr><tr><td>'+email_th_recipients+'：</td><td><span><img src="../img/icon_read_3_07.png"/>'+data2.emailList[0].toName+'</span></td></tr><tr><td>'+email_th_time+'：</td><td>'+sendTime+'</td></tr>';
            }

            $('#TAE').append(str);
            $('.article3').append('<p>'+data2.content+'</p>');
        }
    });
}
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
