
function downloads(that) {
    window.open($(that).attr('data-url'))
}
var boxStyle=GetQueryString('boxStyle');
var otherBoxId=GetQueryString('id');
var pageNum=1;
var pageTotao=0;
var userCookie=$.cookie('userId');
$(function(){
    var data1={
        "flag":'inbox',
        "page":pageNum,
        "pageSize":15,
        "useFlag":true,
        "searchCriteria":'',
        "orderByName":'',
        "orderWhere":'',
        "isWebmail":''
    };
    var data2={
        "flag":'drafts',
        "page":pageNum,
        "pageSize":15,
        "useFlag":true,
        "searchCriteria":'',
        "orderByName":'',
        "orderWhere":'',
    };
    var data3={
        "flag":'outbox',
        "page":pageNum,
        "pageSize":15,
        "useFlag":true,
        "searchCriteria":'',
        "orderByName":'',
        "orderWhere":'',
        "isWebmail":''
    };
    var data4={
        "flag":'recycle',
        "page":pageNum,
        "pageSize":15,
        "useFlag":true,
        "searchCriteria":'',
        "orderByName":'',
        "orderWhere":'',
        "isWebmail":''
    };
    var data5={
        'page':pageNum,
        'pageSize':15,
        'useFlag':false,
        'boxId':otherBoxId,
        "searchCriteria":'',
        "orderByName":'',
        "orderWhere":''
    }
    if(boxStyle == 'inbox'){  //收件箱

        showAjax(data1,'/emailPlus/showEmail');
        $('.getUser').show();

    }else if(boxStyle == 'drafts'){  //草稿箱

        $('.getUser').hide();
        showAjax(data2,'/emailPlus/showEmail');
    }else if(boxStyle == 'outbox'){  //已发送

        $('.getUser').hide();
        showAjax(data3,'/emailPlus/showEmail');
    }else if(boxStyle == 'recycle'){  //废纸篓

        $('.getUser').hide();
        showAjax(data4,'/emailPlus/showEmail');
    }else if(boxStyle == 'otherBox'){  //其他邮件箱

        $('.getUser').hide();
        showAjax(data5,'/emailPlus/selectBoxEmail');
    }

    
    
    var timer=null;

   $('#befor').on('scroll',function () {
       var wholeHeight=$(this)[0].scrollHeight;
       var scrollTop=$(this)[0].scrollTop;
       var divHeight=$(this)[0].clientHeight;
       var iNows=Math.ceil(pageTotao/15);

       var liLIst=$('.signDiv').find('li');

       if(divHeight+scrollTop>=wholeHeight){
           clearTimeout(timer);
           timer=setTimeout(function(){
               if(boxStyle == 'inbox'){  //收件箱
                    ++data1.page;
                    if(data1.page > iNows){
                        return false;
                    }
                   showAjax(data1,'/emailPlus/showEmail');
                   $('.getUser').show();

               }else if(boxStyle == 'drafts'){  //草稿箱
                   ++data2.page;
                   if(data2.page > iNows){
                       return false;
                   }
                   $('.getUser').hide();
                   showAjax(data2,'/emailPlus/showEmail');
               }else if(boxStyle == 'outbox'){  //已发送
                    ++data3.page;
                   if(data3.page > iNows){
                       return false;
                   }
                   $('.getUser').hide();
                   showAjax(data3,'/emailPlus/showEmail');
               }else if(boxStyle == 'recycle'){  //废纸篓
                    ++data4.page;
                   if(data4.page > iNows){
                       return false;
                   }
                   $('.getUser').hide();
                   showAjax(data4,'/emailPlus/showEmail');
               }else if(boxStyle == 'otherBox'){  //其他邮件箱
                    ++data5.page;
                   if(data5.page > iNows){
                       return false;
                   }
                   $('.getUser').hide();
                   showAjax(data5,'/emailPlus/selectBoxEmail');
               }
           },500);

       }

   })

    // if(boxStyle == 'inbox'){
    //     $('.main_left').find('.BTN').eq(0).live('click',function () {
    //         $(this).addClass("backing").siblings().removeClass("backing");
    //         var nId=$(this).find('input').attr('id');
    //         var readf=$(this).find('input').attr('readf');
    //         var bodyNid=$(this).find('input').attr('nId');
    //         var fromId=$(this).attr('fromId');
    //         var detailData={
    //             emailId:nId,
    //             flag:''
    //         }
    //         var noReadel={
    //             flag:'isRead',
    //             emailId:nId
    //         }
    //         if(readf== '0'){
    //             initData(noReadel);
    //             $(this).find('.noReadF').attr('src','../img/icon_read_2_03.png');
    //         }else{
    //             initData(detailData);
    //         }
    //         getUserInfo_s(fromId)
    //     })
    //     $('.main_left').find('.BTN').eq(0).click();
    // }

    //详情点击事件
    $('.main_left').on('click','.BTN',function(){
        $(this).addClass("backing").siblings().removeClass("backing");
        var nId=$(this).find('input').attr('id');
        var readf=$(this).find('input').attr('readf');
        var bodyNid=$(this).find('input').attr('nId');
        var fromId=$(this).attr('fromId');
        var detailData={
            emailId:nId,
            flag:''
        }
        if(boxStyle == 'inbox'){
            var noReadel={
                flag:'isRead',
                emailId:nId
            }
            if(readf== '0'){
                initData(noReadel);
                $(this).find('.noReadF').attr('src','../img/icon_read_2_03.png');
            }else{
                initData(detailData);
            }
            getUserInfo_s(fromId)
        }else if(boxStyle == 'drafts'){
            $('.getUser').hide();
            initDrafts(bodyNid);
        }else if(boxStyle == 'outbox'){
            $('.getUser').hide();
            var detailOutbox={
                bodyId:bodyNid,
                flag:''
            }
            initData(detailOutbox);
        }else if(boxStyle == 'recycle'){
            $('.getUser').hide();
            initData(detailData);
        }else if(boxStyle == 'otherBox'){
            $('.getUser').hide();
            var detailOtherBox={
                emailId:nId,
                flag:''
            }
            initData(detailOtherBox);
        }

    });

    //点击搜索图标
    $('.Search').on('click',function(){
        $('.search_div').toggle();
    })

    //搜索结果方法
    $('.searchTxt').on('bind','input propertychange', function() {
        var valN=$(this).val();

        if(boxStyle == 'inbox'){  //收件箱
            data1.searchCriteria=valN;
            showAjaxPaixu(data1,'/emailPlus/showEmail');
            $('.getUser').show();

        }else if(boxStyle == 'drafts'){  //草稿箱
            data2.searchCriteria=valN;
            $('.getUser').hide();
            showAjaxPaixu(data2,'/emailPlus/showEmail');
        }else if(boxStyle == 'outbox'){  //已发送
            data3.searchCriteria=valN;
            $('.getUser').hide();
            showAjaxPaixu(data3,'/emailPlus/showEmail');
        }else if(boxStyle == 'recycle'){  //废纸篓
            data4.searchCriteria=valN;
            $('.getUser').hide();
            showAjaxPaixu(data4,'/emailPlus/showEmail');
        }else if(boxStyle == 'otherBox'){  //其他邮件箱
            data5.searchCriteria=valN;
            $('.getUser').hide();
            showAjaxPaixu(data5,'/emailPlus/selectBoxEmail');
        }
    });

    //取消搜索按钮
    $('.cancleSpan').on('click',function () {
        $('.searchTxt').val('');
        $('.search_div').hide();
        if(boxStyle == 'inbox'){  //收件箱
            data1.searchCriteria='';
            showAjaxPaixu(data1,'/emailPlus/showEmail');
            $('.getUser').show();
        }else if(boxStyle == 'drafts'){  //草稿箱
            data2.searchCriteria='';
            $('.getUser').hide();
            showAjaxPaixu(data2,'/emailPlus/showEmail');
        }else if(boxStyle == 'outbox'){  //已发送
            data3.searchCriteria='';
            $('.getUser').hide();
            showAjaxPaixu(data3,'/emailPlus/showEmail');
        }else if(boxStyle == 'recycle'){  //废纸篓
            data4.searchCriteria='';
            $('.getUser').hide();
            showAjaxPaixu(data4,'/emailPlus/showEmail');
        }else if(boxStyle == 'otherBox'){  //其他邮件箱
            data5.searchCriteria='';
            $('.getUser').hide();
            showAjaxPaixu(data5,'/emailPlus/selectBoxEmail');
        }
    })


    //刷新点击事件
    $('.ReFresh').on('click',function(){
        if(boxStyle == 'inbox'){  //收件箱
            // showAjax(data1,'showEmail');
            showAjaxPaixu(data1,'/emailPlus/showEmail');
            $('.getUser').show();
        }else if(boxStyle == 'drafts'){  //草稿箱
            $('.getUser').hide();
            // showAjax(data2,'showEmail');
            showAjaxPaixu(data2,'/emailPlus/showEmail');
        }else if(boxStyle == 'outbox'){  //已发送
            $('.getUser').hide();
            // showAjax(data3,'showEmail');
            showAjaxPaixu(data3,'/emailPlus/showEmail');
        }else if(boxStyle == 'recycle'){  //废纸篓
            $('.getUser').hide();
            // showAjax(data4,'showEmail');
            showAjaxPaixu(data4,'/emailPlus/showEmail');
        }else if(boxStyle == 'otherBox'){  //其他邮件箱
            $('.getUser').hide();
            // showAjax(data5,'selectBoxEmail');
            showAjaxPaixu(data5,'/emailPlus/selectBoxEmail');
        }
    })

    //标记已读
    $('.signReaders').on('click',function(){
        $('.chekEmail').prop('checked',false);
        $('.chekEmail').toggle();
    })

    //一键全选
    $('.selectReaders').on('click',function(){
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
    //排序图标点击
    $('.sort_right').on('click',function(e){
        e.stopPropagation();
        $('.signDiv').toggle();
    })
    var orderNameStr="";
    var oWhereStr="";
    //排序内容点击
    $('.signDiv').on('click','li',function(){
        $(this).addClass('bgSort').siblings().removeClass('bgSort');
        // orderNameStr=$(this).attr('orderByName');
        // oWhereStr=$(this).attr('orderWhere');
        orderNameStr=$('#orderByName').find('.bgSort').attr('orderByName');
        oWhereStr=$('#orderWhere').find('.bgSort').attr('orderWhere');
        var id=$('.divUlShow').find('li.on').attr('boxid');
        if(boxStyle == 'inbox'){  //收件箱
            data1.orderByName=orderNameStr;
            data1.orderWhere=oWhereStr;
            showAjaxPaixu(data1,'/emailPlus/showEmail');
            $('.getUser').show();
        }else if(boxStyle == 'drafts'){  //草稿箱
            data2.orderByName=orderNameStr;
            data2.orderWhere=oWhereStr;
            $('.getUser').hide();
            showAjaxPaixu(data2,'/emailPlus/showEmail');
        }else if(boxStyle == 'outbox'){  //已发送
            data3.orderByName=orderNameStr;
            data3.orderWhere=oWhereStr;
            $('.getUser').hide();
            showAjaxPaixu(data3,'/emailPlus/showEmail');
        }else if(boxStyle == 'recycle'){  //废纸篓
            data4.orderByName=orderNameStr;
            data4.orderWhere=oWhereStr;
            $('.getUser').hide();
            showAjaxPaixu(data4,'/emailPlus/showEmail');
        }else if(boxStyle == 'otherBox'){  //其他邮件箱
            data5.orderByName=orderNameStr;
            data5.orderWhere=oWhereStr;
            $('.getUser').hide();
            showAjaxPaixu(data5,'/emailPlus/selectBoxEmail');
        }
        $('.signDiv').hide();
    })

    //排序内容点击
    // $('#orderWhere').on('click','li',function(){
    //     $(this).addClass('bgSort').siblings().removeClass('bgSort');
    //     var id=$('.divUlShow').find('li.on').attr('boxid');
    //     oWhereStr=$(this).attr('orderWhere');
    //     if(boxStyle == 'inbox'){  //收件箱
    //         data1.orderByName=orderNameStr;
    //         data1.orderWhere=oWhereStr;
    //         showAjaxPaixu(data1,'showEmail');
    //         $('.getUser').show();
    //     }else if(boxStyle == 'drafts'){  //草稿箱
    //         data2.orderByName=orderNameStr;
    //         data2.orderWhere=oWhereStr;
    //         $('.getUser').hide();
    //         showAjaxPaixu(data2,'showEmail');
    //     }else if(boxStyle == 'outbox'){  //已发送
    //         data3.orderByName=orderNameStr;
    //         data3.orderWhere=oWhereStr;
    //         $('.getUser').hide();
    //         showAjaxPaixu(data3,'showEmail');
    //     }else if(boxStyle == 'recycle'){  //废纸篓
    //         data4.orderByName=orderNameStr;
    //         data4.orderWhere=oWhereStr;
    //         $('.getUser').hide();
    //         showAjaxPaixu(data4,'showEmail');
    //     }else if(boxStyle == 'otherBox'){  //其他邮件箱
    //         data5.orderByName=orderNameStr;
    //         data5.orderWhere=oWhereStr;
    //         $('.getUser').hide();
    //         showAjaxPaixu(data5,'selectBoxEmail');
    //     }
    // })

    $('.a1').on('click',function () {
        var str='<tr class="tian"><td>'+email_th_carbonCopyRecipients+'：</td><td><textarea id="copeNameText" name="txt" disabled></textarea><span class="add_img"><a href="javascript:;" id="selectUserO" class="Add" style="margin-left: 16px;font-size: 14px;">'+global_lang_add+'</a></span><span class="add_img"><a href="javascript:;" class="clearCC" style="margin-left: 16px;font-size: 14px;">'+notice_th_delete1+'</a></span></td></tr>';
        var txt=$(this).text();
        if (txt==email_th_addwait) {//添加抄送
            $(this).text(email_th_HideCC);//隐藏抄送
            $('.append_tr').after(str);
        }else{
            $(this).text(email_th_addwait);//添加抄送
            $('.tian').remove();
        }
    })

    $('.a2').on('click',function () {
        var str='<tr class="mis"><td>'+email_th_BlindPeople+'：</td><td><textarea id="secritText" name="txt" disabled></textarea><span class="add_img"><a href="javascript:;" id="selectUserT" class="Add" style="margin-left: 16px;font-size: 14px;">'+global_lang_add+'</a></span><span class="add_img"><a href="javascript:;" class="clearBCC" style="margin-left: 16px;font-size: 14px;">'+notice_th_delete1+'</a></span></td></tr>';
        var txt=$(this).text();
        if (txt==email_th_addbcc) {//添加密送
            $(this).text(email_th_HiddenSecret);//隐藏密送
            $('.append_tr').after(str);
        }else{
            $(this).text(email_th_addbcc);//添加密送
            $('.mis').remove();
        }
    })
})

//邮件列表
function showAjax(dataId,emailUrl){
    // $('.befor').find('li').remove();
    var ajaxPage={
        data:dataId,
        page:function () {
            var me=this;
            $.ajax({
                type:'get',
                url:emailUrl,
                dataType:'json',
                data:me.data,
                success:function(res) {
                    var data1=res.obj;
                    var str='';
                    var dataNUm=res.object;
                    pageTotao=res.totleNum;
                    $('#inboxNum', parent.document).html(res.inboxCount);
                    $('#draftsNum', parent.document).html(res.draftsCount);
                    $('#hasBeenSendNum', parent.document).html(res.hairboxCount);
                    $('#wastebasketNum', parent.document).html(res.wasteCount);
                    if(data1 != undefined&&data1.length>0){
                        $('.befor').show();
                        $('.noContent').hide();
                        $('.noEmail').hide();
                        for(var i=0;i<data1.length;i++){
                            var sendTime= data1[i].sendTimes
                            var emailSubject = '';
                            if(data1[i].emailList[0].withdrawFlag==undefined||data1[i].emailList[0].withdrawFlag=='0'){
                                // if(data1[i].subject == '【无主题 】' && data1[i].attachmentName != ''){
                                if(data1[i].subject.indexOf('【'+email_th_no_subject+'】') != -1 && data1[i].attachmentName != '' && data1[i].attachment !=""){
                                    var qianzhui=data1[i].subject.replace('【'+email_th_no_subject+'】','');
                                    var file=data1[i].attachment[0].attachName;
                                    var filename=file.split('.');
                                    emailSubject=qianzhui + filename[0] ;
                                }else {
                                    emailSubject= data1[i].subject ;
                                }
                            }else{
                                emailSubject=retuened+':'+data1[i].subject;
                            }
                            var fromName = data1[i].fromName1?data1[i].fromName1:data1[i].fromName;
                            str+='<li class="BTN" fromId="'+data1[i].fromId+'" style="cursor: pointer;text-align: left">' +
                                '<input type="hidden" readF="'+data1[i].emailList[0].readFlag+'" nId="'+data1[i].bodyId+'" id="'+data1[i].emailList[0].emailId+'" ueId="'+data1[i].emailList[0].deleteFlag+'">' +
                                '<input type="checkbox" class="chekEmail" checkId="'+data1[i].bodyId+'" style="width: 16px;display: none;">' +
                                '<div class="shang" style="display: inline;left: 25px;    margin-left: 90px;">' +
                                '<span style="position: absolute;\n' +
                                '    left: 25px;">'+returnUserName(fromName)+'</span>' +
                                function () {
                                    if(boxStyle == 'inbox'){
                                        if(data1[i].emailList[0].readFlag=='1'){
                                            return '<img src="../img/icon_read_2_03.png"/>';
                                        }else{
                                            return '<img class="noReadF" src="../img/icon_notread_1_03.png"/>';
                                        }
                                    }else {
                                        return '<img src="../img/icon_read_2_03.png"/>';
                                    }
                                }()+
                                '<span class="time">'+sendTime+'</span>' +
                                '</div>' +
                                '<div class="xia">' +
                                '<a href="javascript:;" class="xia_txt" style="width: 90%;height:20px;white-space:normal;-webkit-line-clamp:2;overflow: hidden;-webkit-box-orient: vertical;position: absolute;left: 25px;    white-space: nowrap;word-break: keep-all;overflow: hidden;text-overflow: ellipsis;">'+emailSubject+'</a>' +
                                function () {
                                    if(data1[i].attachmentId!=''&&data1[i].emailList[0].withdrawFlag!='1'){
                                        return '<img style="left: 2px;" src="../img/huixingzhen.png"/>';
                                    }else{
                                        return '';
                                    }
                                }()+
                                '</div>' +
                                '</li>';
                        }

                        $('.befor').append(str);
                        $('li.BTN').eq(0).addClass("backing");
                        $('li.BTN').eq(0).find(".noReadF").attr('src','../img/icon_read_2_03.png');
                        var emailId=$('.befor .backing').find('input[type="hidden"]').attr('id');
                        var bodyNid=$('.befor .backing').find('input').attr('nId');
                        if(boxStyle == 'inbox'){
                            var formIds=$('.befor .backing').attr('fromid');
                            var detailData={
                                emailId:emailId,
                                flag:''
                            }
                            $('.detailes').show();
                            $('.drafts').hide();
                            getUserInfo_s(formIds);
                            initData(detailData);
                        }else if(boxStyle == 'drafts'){
                            $('.detailes').hide();
                            $('.drafts').show();
                            initDrafts(bodyNid);

                        }else if(boxStyle == 'outbox'){
                            $('.getUser').hide();
                            $('.detailes').show();
                            $('.drafts').hide();
                            var detailOutbox={
                                bodyId:bodyNid,
                                flag:''
                            }
                            initData(detailOutbox);
                        }else if(boxStyle == 'recycle'){

                            $('.getUser').hide();
                            $('.detailes').show();
                            $('.drafts').hide();
                            var detailRecycle={
                                emailId:emailId,
                                flag:''
                            }
                            initData(detailRecycle);
                        }else if(boxStyle == 'otherBox'){
                            $('.getUser').hide();
                            $('.detailes').show();
                            $('.drafts').hide();
                            var detailOtherBox={
                                emailId:emailId,
                                flag:''
                            }
                            initData(detailOtherBox);
                        }
                    } else{
                        $('.befor').hide();
                        $('.noContent').show();
                        $('.noEmail').show().siblings().hide();
                    }
                    // me.pageTwo(res.totleNum,me.data.pageSize,me.data.page)
                }
            })

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
    };
    ajaxPage.page();
}
function yd(e){
    var atturl = e.attr('attrurl');
    $.pdurl($.UrlGetRequest('?'+atturl),atturl);
}
//收件箱、已发送、废纸篓详情展示
function initData(datas){
    $('.detailes').find('#TAB').remove();
    $('.detailes').find('.article').remove();
    $.ajax({
        type:'get',
        url:'/emailPlus/queryByID',
        dataType:'json',
        data:datas,
        success:function(rsp){
            // alert(111)
            $('.detailes').find('#TAB').remove();
            $('.detailes').find('.article').remove();
            var data2=rsp.object;
            if(!data2||data2.length<=0){
                return;
            }
            var sendTime=data2.sendTimes;
            var object='';
            var stra='';
            var arr=new Array();
            arr=data2.attachment;
            var content = '';
            if(data2.emailList[0].withdrawFlag=='0'){
                var contentMsg = data2.content;
                if(contentMsg.indexOf('iframe') > -1){
                    var cm = $('<div>'+contentMsg.toString()+'</div>');
                    cm.find('iframe').remove();
                    contentMsg = cm.html();
                }
                content =contentMsg;
            }else{
                content = sysLdering;
            }

            var emailSubject = '';
            if(data2.emailList[0].withdrawFlag == undefined|| data2.emailList[0].withdrawFlag == '0'){
                // if(data2.subject == '【无主题 】' && data2.attachmentName != ''){
                if(data2.subject.indexOf('【'+email_th_no_subject+'】') != -1 && data2.attachmentName != ''){
                    var qianzhui=data2.subject.replace('【'+email_th_no_subject+'】','');
                    var file=data2.attachment[0].attachName;
                    var filename=file.split('.');
                    emailSubject=qianzhui + filename[0] ;
                }else {
                    emailSubject= data2.subject ;
                }
                // emailSubject= data2.subject ;
            }else{
                emailSubject= retuened+':'+data2.subject;
            }
            var fromName = data2.fromName1?data2.fromName1:data2.users.userName;
           
           object+='<table id="TAB" cellspacing="0" cellpadding="0" style="border-collapse:collapse;table-layout: fixed;">' +
                '<tr>' +
               '<td style="width:70px;">'+email_th_main+'：</td>' +
                '<td width="90%" style="display:block;white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" title="'+data2.subject+'">' +
                    '<div style="width:60%;display:block;white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" title="'+data2.subject+'">'+emailSubject+'</div>' +
                '</td></tr>' +  //主题
                '<tr><td>'+email_th_sender+'：</td><td>'+fromName+'</td></tr>' +  //发件人
                '<tr><td>'+email_th_recipients+'：</td>' +
               '<td><span class="isReaderType" style="display: inline-block;width:100px;" title="'+data2.toId2Name+'">'+data2.toId2Name
               /*function () {
                   if(data2.toUserEmailInfo){
                       var userStr="";

                       for(var i=0;i<data2.toUserEmailInfo.length;i++){
                           if(i>2){
                               userStr+="...";
                               break;
                           }
                           if(data2.toUserEmailInfo[i].readFlag == '1'){
                               userStr+='<img src="../img/icon_read_2_03.png" /><span style="margin-right: 10px;">'+data2.toUserEmailInfo[i].userName+'</span>'
                           }else{
                               userStr+='<img src="../img/icon_notread_1_03.png" class="noReadF"/><span style="margin-right: 10px;">'+data2.toUserEmailInfo[i].userName+'</span>'
                           }
                       }
                       return userStr;
                   }
               }()*/
               +'</span>' +
               '<a urls="" href="/emailPlus/emailReadDetail?bodyId='+data2.bodyId+'&userIds='+data2.toId2+'" target="_blank">'+event_th_ViewMailStatus+'</a></td></tr>'
                if(data2.copyName!=''){
                    object+= '<tr><td>'+email_th_carbonCopyRecipients+'：</td>' +
                        '<td><span class="copyType" style="display: inline-block;min-width: 240px;width:30%;" title="'+data2.copyName+'">'+function () {
                            var copyUserStr="";
                            if(data2.copyUserEmailInfo){
                                for(var i=0;i<data2.copyUserEmailInfo.length;i++){
                                    if(i>2){
                                        copyUserStr+="...";
                                        break;
                                    }
                                    if(data2.copyUserEmailInfo[i].readFlag == '1'){
                                        copyUserStr+='<img src="../img/icon_read_2_03.png" /><span style="margin-right: 10px;">'+data2.copyUserEmailInfo[i].userName+'</span>'
                                    }else{
                                        copyUserStr+='<img src="../img/icon_notread_1_03.png" class="noReadF"/><span style="margin-right: 10px;">'+data2.copyUserEmailInfo[i].userName+'</span>'
                                    }
                                }
                                return copyUserStr;
                            }
                        }()+'</span>' +
                        '<a urls="" href="/emailPlus/emailReadDetail?bodyId='+data2.bodyId+'&userIds='+data2.copyToId+'" target="_blank">'+event_th_ViewMailStatus+'</a>' +
                        '</td></tr>';
                }
                if(data2.secretToName!=''){
                    object+= '<tr><td>'+email_th_BlindPeople+'：</td>' +
                        '<td><span class="secrCopy" style="display: inline-block;min-width: 240px;width:30%;">'+function () {
                            var secrUserStr="";
                            if(data2.sercUserEmailInfo){
                                for(var i=0;i<data2.sercUserEmailInfo.length;i++){
                                    if(i>2){
                                        secrUserStr+="...";
                                        break;
                                    }
                                    if(data2.sercUserEmailInfo[i].readFlag == '1'){
                                        secrUserStr+='<img  src="../img/icon_read_2_03.png" /><span style="margin-right: 10px;">'+data2.sercUserEmailInfo[i].userName+'</span>'
                                    }else{
                                        secrUserStr+='<img src="../img/icon_notread_1_03.png" class="noReadF"/><span style="margin-right: 10px;">'+data2.sercUserEmailInfo[i].userName+'</span>'
                                    }
                                }
                                return secrUserStr;
                            }
                        }()+'</span>' +
                        '<a urls="" href="/emailPlus/emailReadDetail?bodyId='+data2.bodyId+'&userIds='+data2.secretToId+'" target="_blank">'+event_th_ViewMailStatus+'</a>' +
                        '</td></tr>'
                }
                   object+='<tr><td>'+email_th_time+'：</td><td>'+sendTime+'</td></tr>'
                if(data2.attachmentName!=''){
                    object+='<tr><td>'+email_th_file+'：</td><td class="attachment">'+attachmentShow_mail(arr)+'</td></tr>';

                }
                object+='</table>'+
                    '<div class="article"><p>'+content+'</p></div>';

                $('.detailes').append(object);

                var toUserArrId=[];
                var copyUserArrId=[];
                var sercUserArrId=[];
                var indextoUser=-1;
                var indexcopyUser=-1;
                var indexsercUser=-1;
                if(data2.toUserEmailInfo){
                    for(var i=0;i<data2.toUserEmailInfo.length;i++){
                        toUserArrId.push(data2.toUserEmailInfo[i].toId)
                    }

                    if(toUserArrId.toString().indexOf(userCookie) > -1){
                        for(var i=0;i<toUserArrId.length;i++){
                            if(toUserArrId[i]== userCookie){
                                indextoUser=i;
                                break;
                            }
                        }
                        $('.isReaderType').find('img').eq(indextoUser).attr('src','../img/icon_read_2_03.png');
                    }

                }
                if(data2.copyUserEmailInfo){
                    for(var i=0;i<data2.copyUserEmailInfo.length;i++){
                        copyUserArrId.push(data2.copyUserEmailInfo[i].toId)
                    }
                    if(copyUserArrId.toString().indexOf(userCookie) > -1){
                        for(var i=0;i<copyUserArrId.length;i++){
                            if(copyUserArrId[i] == userCookie){
                                indexcopyUser=i;
                                break;
                            }
                        }
                        $('.copyType').find('img').eq(indexcopyUser).attr('src','../img/icon_read_2_03.png');
                    }
                }
                if(data2.sercUserEmailInfo){
                    for(var i=0;i<data2.sercUserEmailInfo.length;i++){
                        sercUserArrId.push(data2.sercUserEmailInfo[i].toId)
                    }
                    if(sercUserArrId.toString().indexOf(userCookie) > -1){
                        for(var i=0;sercUserArrId.length;i++){
                            if(sercUserArrId[i] == userCookie){
                                indexsercUser=i;
                                break;
                            }
                        }
                        $('.secrCopy').find('img').eq(indexsercUser).attr('src','../img/icon_read_2_03.png');
                    }
                }
                var Height=$('.detailes').height()-$('#TAB').height()-46;
                $('.article').height(Height+'px');

        }
    });
}
//草稿箱详情展示
function initDrafts(nId) {
    $.ajax({
        type:'get',
        url:'/emailPlus/queryByID',
        dataType:'json',
        data:{'bodyId':nId,'flag':''},
        success:function(rsp){
            if(rsp.flag == true){
                var data2=rsp.object;
                if(!data2||data2.length<=0){
                    return;
                }
                var atta=data2.attachment;
                var str='';
                $('.tian').remove();
                $('.mis').remove();

                $('textarea').val('');
                $('#txt').val('');
                ue.setContent('');
                $('#senduser').val('');
                $('.Attachment td').eq(1).find('div').remove();
                for(var i=0;i<atta.length;i++){
                    str+='<div class="dech" deUrl="'+encodeURI(atta[i].attUrl)+'">' +
                        '<a href="/download?'+encodeURI(atta[i].attUrl)+'" NAME="'+atta[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                        '<img style="margin-right:10px;" src="../img/huixingzhen.png"/>'+atta[i].attachName+'</a>' +
                        '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/>' +
                        '<input type="hidden" class="inHidden" value="'+atta[i].aid+'@'+atta[i].ym+'_'+atta[i].attachId+',">' +
                        '</div>';
                }

                $('#senduser').val(data2.toName);
                $('#senduser').attr('user_id',data2.toId2);
                if(data2.copyToId !=''){
                    var cStr='';
                    cStr='<tr class="tian"><td>'+email_th_carbonCopyRecipients+'：</td><td><textarea id="copeNameText" name="txt" disabled></textarea><span class="add_img"><a href="javascript:;" id="selectUserO" class="Add" style="margin-left: 5px;">'+global_lang_add+'</a></span><span class="add_img"><a href="javascript:;" class="clearCC" style="margin-left: 5px;">'+notice_th_delete1+'</a></span></td></tr>';
                    $('.a1').text(email_th_HideCC);
                    $('.append_tr').after(cStr);
                    $('#copeNameText').attr('user_id',data2.copyToId+',');
                    $('#copeNameText').val(data2.copyName);
                }
                if(data2.secretToId !=''){
                    var sStr='';
                    sStr='<tr class="mis"><td>'+email_th_BlindPeople+'：</td><td><textarea id="secritText" name="txt" disabled></textarea><span class="add_img"><a href="javascript:;" id="selectUserT" class="Add" style="margin-left: 5px;">'+global_lang_add+'</a></span><span class="add_img"><a href="javascript:;" class="clearBCC" style="margin-left: 5px;">'+notice_th_delete1+'</a></span></td></tr>';
                    $('.a2').text(email_th_HiddenSecret);//'隐藏密送'
                    $('.append_tr').after(sStr);
                    $('#secritText').attr('user_id',data2.secretToId+',');
                    $('#secritText').val(data2.secretToName);
                }
                $('#txt').val(data2.subject);
                ue.setContent(data2.content);
                $('.Attachment td').eq(1).append(str);
                var Height=$($('#styleDrafts')).height();
            }
        }
    });
}


//排序列表
function showAjaxPaixu(dataId,emailUrl){
    // $('.befor').find('li').remove();
    var ajaxPage={
        data:dataId,
        page:function () {
            var me=this;
            $.ajax({
                type:'get',
                url:emailUrl,
                dataType:'json',
                data:me.data,
                success:function(res) {
                    var data1=res.obj;
                    var str='';
                    var dataNUm=res.object;
                    pageTotao=res.totleNum;
                    $('#inboxNum', parent.document).html(res.inboxCount);
                    $('#draftsNum', parent.document).html(res.draftsCount);
                    $('#hasBeenSendNum', parent.document).html(res.hairboxCount);
                    $('#wastebasketNum', parent.document).html(res.wasteCount);
                    if(data1.length>0){
                        $('.befor').show();
                        $('.noContent').hide();
                        $('.noEmail').hide();
                        for(var i=0;i<data1.length;i++){
                            var sendTime=new Date((data1[i].sendTime)*1000).Format('yyyy-MM-dd hh:mm');
                            var emailSubject = '';
                            if(data1[i].emailList[0].withdrawFlag==undefined||data1[i].emailList[0].withdrawFlag=='0'){
                                if(data1[i].subject.indexOf('【'+email_th_no_subject+'】') != -1 && data1[i].attachmentName != ''){
                                    var qianzhui=data1[i].subject.replace('【'+email_th_no_subject+'】','');
                                    var file=data1[i].attachment[0].attachName;
                                    var filename=file.split('.');
                                    emailSubject=qianzhui + filename[0] ;
                                }else {
                                    emailSubject= data1[i].subject ;
                                }
                                // emailSubject= data1[i].subject ;
                            }else{
                                emailSubject=retuened+':'+data1[i].subject;
                            }
                            var fromName = data1[i].fromName1?data1[i].fromName1:data1[i].users.userName;
                            str+='<li class="BTN" fromId="'+data1[i].fromId+'" style="cursor: pointer;text-align:left ">' +
                                '<input type="hidden" readF="'+data1[i].emailList[0].readFlag+'" nId="'+data1[i].bodyId+'" id="'+data1[i].emailList[0].emailId+'" ueId="'+data1[i].emailList[0].deleteFlag+'">' +
                                '<input type="checkbox" class="chekEmail" checkId="'+data1[i].bodyId+'" style="width: 16px;display: none;">' +
                                '<div class="shang" style="display: inline;left: 25px;    margin-left: 90px;">' +
                                '<span style="position: absolute;\n' +
                                '    left: 25px;">'+returnUserName(fromName)+'</span>' +
                                function () {
                                    if(boxStyle == 'inbox'){
                                        if(data1[i].emailList[0].readFlag=='1'){
                                            return '<img  src="../img/icon_read_2_03.png"/>';
                                        }else{
                                            return '<img  class="noReadF" src="../img/icon_notread_1_03.png"/>';
                                        }
                                    }else {
                                        return '<img  src="../img/icon_read_2_03.png"/>';
                                    }
                                }()+
                                '<span class="time">'+sendTime+'</span>' +
                                '</div>' +
                                '<div class="xia">' +
                                '<a href="javascript:;" class="xia_txt" style="width: 90%;height:20px;white-space:normal;-webkit-line-clamp:2;overflow: hidden;-webkit-box-orient: vertical;position: absolute;left: 25px;    white-space: nowrap;word-break: keep-all;overflow: hidden;text-overflow: ellipsis;">'+emailSubject+'</a>' +
                                function () {
                                    if(data1[i].attachmentId!=''&&data1[i].emailList[0].withdrawFlag!='1'){
                                        return '<img style="left: 2px;" src="../img/huixingzhen.png"/>';
                                    }else{
                                        return '';
                                   }
                                }()+
                                '</div>' +
                                '</li>';
                        }

                        $('.befor').html(str);
                        $('li.BTN').eq(0).addClass("backing");
                        var emailId=$('.befor .backing').find('input[type="hidden"]').attr('id');
                        var bodyNid=$('.befor .backing').find('input').attr('nId');
                        if(boxStyle == 'inbox'){
                            var formIds=$('.befor .backing').attr('fromid');
                            var detailData={
                                emailId:emailId,
                                flag:''
                            }
                            $('.detailes').show();
                            $('.drafts').hide();
                            getUserInfo_s(formIds);
                            initData(detailData);
                        }else if(boxStyle == 'drafts'){
                            $('.detailes').hide();
                            $('.drafts').show();
                            initDrafts(bodyNid);

                        }else if(boxStyle == 'outbox'){
                            $('.getUser').hide();
                            $('.detailes').show();
                            $('.drafts').hide();
                            var detailOutbox={
                                bodyId:bodyNid,
                                flag:''
                            }
                            initData(detailOutbox);
                        }else if(boxStyle == 'recycle'){

                            $('.getUser').hide();
                            $('.detailes').show();
                            $('.drafts').hide();
                            var detailRecycle={
                                emailId:emailId,
                                flag:''
                            }
                            initData(detailRecycle);
                        }else if(boxStyle == 'otherBox'){
                            $('.getUser').hide();
                            $('.detailes').show();
                            $('.drafts').hide();
                            var detailOtherBox={
                                emailId:emailId,
                                flag:''
                            }
                            initData(detailOtherBox);
                        }
                    } else{
                        $('.befor').hide();
                        $('.noContent').show();
                        $('.noEmail').show().siblings().hide();
                    }
                    // me.pageTwo(res.totleNum,me.data.pageSize,me.data.page)
                }
            })

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
    };
    ajaxPage.page();
}


//获取人员图像、信息接口
function getUserInfo_s(id){
    $.ajax({
        type:'get',
        url:'../user/findUserByuserId',
        dataType:'json',
        data:{'userId':id},
        success:function(res){
            if(res.flag==true){
                var dataU=res.object;
                $('.zong').text(dataU.userPrivName);
                $('.userdept').text(dataU.deptName);
                $('.span_hr').find('p').find('span').eq(0).html(dataU.userName);
                if(dataU.avatar =='' || dataU.avatar == undefined){
                    $('.attrImg img').attr('src','../img/email/icon_head_man_06.png');
                }else if(dataU.avatar == 0){
                    $('.attrImg img').attr('src', '../img/user/boy.png');
                }else if(dataU.avatar == 1){
                    $('.attrImg img').attr('src', '../img/user/girl.png');
                } else{
                    $('.attrImg img').attr('src','../../img/user/'+dataU.avatar);
                }
            }

        }
    })
}

//获取地址栏参数
function GetQueryString(name) {
    var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if(r!=null)return  unescape(r[2]); return null;
}

<!-- 处理姓名为空处理 /users处理 -->
function returnUserName(users){
    if(users == undefined || users == ""){
        return "";
    }else{
        return users;
    }
}
//查看邮件状态
function lookemail(e){
    var urls = e.attr('urls');
    var name = '<fmt:message code="event.th.ViewMailStatus" />';
    if(typeof(qt) == 'undefined'){
        window.open(urls);
        // $.popWindow(urls,'name')
    }else{
        new QWebChannel(qt.webChannelTransport, function(channel){
            var content = channel.objects.interface;
            content.xoa_sms(urls,name,"web_child_url");
        });
    }
}