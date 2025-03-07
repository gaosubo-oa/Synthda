var XHR;
function downloads(that) {
    window.open($(that).attr('data-url'))
}
var boxStyle = GetQueryString('boxStyle');
var otherBoxId = GetQueryString('id');
var pageNum = 1;
var pageTotao = 0;
var userCookie = $.cookie('userId');
var ue;
$(function () {
    var data1 = {
        "flag": 'inbox',
        "page": pageNum,
        "pageSize": 15,
        "useFlag": true,
        "searchCriteria": '',
        "orderByName": '',
        "orderWhere": '',
        "isWebmail": '',

    };
    var data2 = {
        "flag": 'drafts',
        "page": pageNum,
        "pageSize": 15,
        "useFlag": true,
        "searchCriteria": '',
        "orderByName": '',
        "orderWhere": '',
    };
    var data3 = {
        "flag": 'outbox',
        "page": pageNum,
        "pageSize": 15,
        "useFlag": true,
        "searchCriteria": '',
        "orderByName": '',
        "orderWhere": '',
        "isWebmail": ''
    };
    var data4 = {
        "flag": 'recycle',
        "page": pageNum,
        "pageSize": 15,
        "useFlag": true,
        "searchCriteria": '',
        "orderByName": '',
        "orderWhere": '',
        "isWebmail": ''
    };
    var data5 = {
        'page': pageNum,
        'pageSize': 15,
        'useFlag': false,
        'boxId': otherBoxId,
        "searchCriteria": '',
        "orderByName": '',
        "orderWhere": ''
    }
    if (boxStyle == 'inbox') {  //收件箱

        showAjax(data1, 'newShowEmail');
        $('.getUser').show();

    } else if (boxStyle == 'drafts') {  //草稿箱

        $('.getUser').hide();
        showAjax(data2, 'newShowEmail');
    } else if (boxStyle == 'outbox') {  //已发送

        $('.getUser').hide();
        showAjax(data3, 'newShowEmail');
    } else if (boxStyle == 'recycle') {  //废纸篓

        $('.getUser').hide();
        showAjax(data4, 'newShowEmail');
    } else if (boxStyle == 'otherBox') {  //其他邮件箱

        $('.getUser').hide();
        showAjax(data5, 'selectBoxEmail');
    } else if (boxStyle == 'unreadBox') {
        $('.getUser').hide();
        data1.flag = 'inboxNoRead';
        showAjax(data1, 'newShowEmail');
    }
    var timer = null;
    $('#befor').on('scroll',function () {
        var wholeHeight = $(this)[0].scrollHeight;
        var scrollTop = $(this)[0].scrollTop;
        var divHeight = $(this)[0].clientHeight;
        var iNows = Math.ceil(pageTotao / 15);

        var liLIst = $('.signDiv').find('li');

        if (divHeight + scrollTop >= wholeHeight) {
            clearTimeout(timer);
            timer = setTimeout(function () {
                if (boxStyle == 'inbox') {  //收件箱
                    ++data1.page;
                    if (data1.page > iNows) {
                        return false;
                    }
                    showAjax(data1, 'newShowEmail');
                    $('.getUser').show();
                    // 滚动条到最底下，加载出来的邮件默认全选
                    if($('#inputType').attr('model') == 'selectAll'){
                        if ($('.chekEmail').prop('checked')) {
                            $('.chekEmail').show();
                            $('.chekEmail').prop('checked', true);
                            $('#Replay', parent.document).hide();
                            $('#ReplayAll', parent.document).hide();
                        } else {
                            $('.chekEmail').prop('checked', false);
                            $('.chekEmail').hide();
                            $('#Replay', parent.document).show();
                            $('#ReplayAll', parent.document).show();
                        }
                    }
                } else if (boxStyle == 'drafts') {  //草稿箱
                    ++data2.page;
                    if (data2.page > iNows) {
                        return false;
                    }
                    $('.getUser').hide();
                    showAjax(data2, 'newShowEmail');
                    // 滚动条到最底下，加载出来的邮件默认全选
                    if($('#inputType').attr('model') == 'selectAll'){
                        if ($('.chekEmail').prop('checked') == true) {
                            $('.chekEmail').show();
                            $('.chekEmail').prop('checked', true);
                            $('#Replay', parent.document).hide();
                            $('#ReplayAll', parent.document).hide();
                        } else {
                            $('.chekEmail').prop('checked', false);
                            $('.chekEmail').hide();
                            $('#Replay', parent.document).show();
                            $('#ReplayAll', parent.document).show();
                        }
                    }
                } else if (boxStyle == 'outbox') {  //已发送
                    ++data3.page;
                    if (data3.page > iNows) {
                        return false;
                    }
                    $('.getUser').hide();
                    showAjax(data3, 'newShowEmail');
                    // 滚动条到最底下，加载出来的邮件默认全选
                    if($('#inputType').attr('model') == 'selectAll'){
                        if ($('.chekEmail').prop('checked') == true) {
                            $('.chekEmail').show();
                            $('.chekEmail').prop('checked', true);
                            $('#Replay', parent.document).hide();
                            $('#ReplayAll', parent.document).hide();
                        } else {
                            $('.chekEmail').prop('checked', false);
                            $('.chekEmail').hide();
                            $('#Replay', parent.document).show();
                            $('#ReplayAll', parent.document).show();
                        }
                    }

                } else if (boxStyle == 'recycle') {  //废纸篓
                    ++data4.page;
                    if (data4.page > iNows) {
                        return false;
                    }
                    $('.getUser').hide();
                    showAjax(data4, 'newShowEmail');
                    // 滚动条到最底下，加载出来的邮件默认全选
                    if($('#inputType').attr('model') == 'selectAll'){
                        if ($('.chekEmail').prop('checked') == true) {
                            $('.chekEmail').show();
                            $('.chekEmail').prop('checked', true);
                            $('#Replay', parent.document).hide();
                            $('#ReplayAll', parent.document).hide();
                        } else {
                            $('.chekEmail').prop('checked', false);
                            $('.chekEmail').hide();
                            $('#Replay', parent.document).show();
                            $('#ReplayAll', parent.document).show();
                        }
                    }

                } else if (boxStyle == 'otherBox') {  //其他邮件箱
                    ++data5.page;
                    if (data5.page > iNows) {
                        return false;
                    }
                    $('.getUser').hide();
                    showAjax(data5, 'selectBoxEmail');
                    if($('#inputType').attr('model') == 'selectAll'){
                        if ($('.chekEmail').prop('checked') == true) {
                            $('.chekEmail').show();
                            $('.chekEmail').prop('checked', true);
                            $('#Replay', parent.document).hide();
                            $('#ReplayAll', parent.document).hide();
                        } else {
                            $('.chekEmail').prop('checked', false);
                            $('.chekEmail').hide();
                            $('#Replay', parent.document).show();
                            $('#ReplayAll', parent.document).show();
                        }
                    }
                }
                /***************处理当滚动前勾选了复选框功能时，再次加载的数据也要出现复选框**************************/
                if($('#inputType').attr('model') == 'reelect'){
                    if($('.chekEmail').attr('fuxuan') == 'yes'&&!!$('.chekEmail').attr('fuxuan')){
                        $('.chekEmail').show();
                    }else{
                        $('.chekEmail').hide();
                    }
                }

                /***************END***********************/
            }, 500);

        }

    });

    //详情点击事件
    $('.main_left').on('click', '.BTN', function () {

        /*if ($(this).attr('class').indexOf('backing') > -1) {
            return false;
        }*/
        $(this).addClass("backing").siblings().removeClass("backing");
        var nId = $(this).find('input').attr('id');
        var readf = $(this).find('input').attr('readf');
        var bodyNid = $(this).find('input').attr('nId');
        var fromId = $(this).attr('fromId');
        var detailData = {
            emailId: nId,
            flag: 'inbox',
            sjxflg:'inbox'
        }
        //////////////////////////////////////////////////////////
        if (boxStyle == 'inbox' || boxStyle == 'unreadBox') {
            var noReadel = {
                flag: 'isRead',
                emailId: nId
            }
            if (readf == '0') {
                initData(noReadel);
                // $(this).find('.noReadF').attr('src','../img/icon_read_2_03.png');
                $(this).find('.noReadF').attr('src', '');
            } else {
                initData(detailData);
            }
            getUserInfo_s(fromId,nId)
        } else if (boxStyle == 'drafts') {
            $('.getUser').hide();
            initDrafts(bodyNid);
        } else if (boxStyle == 'outbox') {
            $('.getUser').hide();
            var detailOutbox = {
                bodyId: bodyNid,
                flag: 'outbox'
            }
            /////////////////////////////
            initData(detailOutbox);
        } else if (boxStyle == 'recycle') {
            $('.getUser').hide();
            initData(detailData);
        } else if (boxStyle == 'otherBox') {
            $('.getUser').hide();
            var detailOtherBox = {
                emailId: nId,
                flag: ''
            }
            initData(detailOtherBox);
        }

    });

    //点击搜索图标
    $('.Search').on('click',function () {
        $('.search_div').toggle();
    })

    //搜索结果方法
    $('.searchTxt').on('keyup', function (e) {
        if(e.key == 'Enter') {
            var valN = $(this).val();

            if (boxStyle == 'inbox') {  //收件箱
                data1.searchCriteria = valN;
                data1.page = 1;
                showAjaxPaixu(data1, 'newShowEmail');
                $('.getUser').show();

            } else if (boxStyle == 'drafts') {  //草稿箱
                data2.searchCriteria = valN;
                data2.page = 1;
                $('.getUser').hide();
                showAjaxPaixu(data2, 'newShowEmail');
            } else if (boxStyle == 'outbox') {  //已发送
                data3.searchCriteria = valN;
                data3.page = 1;
                $('.getUser').hide();
                showAjaxPaixu(data3, 'newShowEmail');
            } else if (boxStyle == 'recycle') {  //废纸篓
                data4.searchCriteria = valN;
                data4.page = 1;
                $('.getUser').hide();
                showAjaxPaixu(data4, 'newShowEmail');
            } else if (boxStyle == 'otherBox') {  //其他邮件箱
                data5.searchCriteria = valN;
                data5.page = 1;
                $('.getUser').hide();
                showAjaxPaixu(data5, 'selectBoxEmail');
            }
        }

    });
    //搜索按钮点击
    $(".searchBtn").on("click",function() {
        var valN = $('.searchTxt').val();

        if (boxStyle == 'inbox') {  //收件箱
            data1.searchCriteria = valN;
            data1.page = 1;
            showAjaxPaixu(data1, 'newShowEmail');
            $('.getUser').show();

        } else if (boxStyle == 'drafts') {  //草稿箱
            data2.searchCriteria = valN;
            data2.page = 1;
            $('.getUser').hide();
            showAjaxPaixu(data2, 'newShowEmail');
        } else if (boxStyle == 'outbox') {  //已发送
            data3.searchCriteria = valN;
            data3.page = 1;
            $('.getUser').hide();
            showAjaxPaixu(data3, 'newShowEmail');
        } else if (boxStyle == 'recycle') {  //废纸篓
            data4.searchCriteria = valN;
            data4.page = 1;
            $('.getUser').hide();
            showAjaxPaixu(data4, 'newShowEmail');
        } else if (boxStyle == 'otherBox') {  //其他邮件箱
            data5.searchCriteria = valN;
            data5.page = 1;
            $('.getUser').hide();
            showAjaxPaixu(data5, 'selectBoxEmail');
        }
    })
    //取消搜索按钮
    $('.cancleSpan').on('click',function () {
        $('.searchTxt').val('');
        $('.search_div').hide();
        if (boxStyle == 'inbox') {  //收件箱
            data1.searchCriteria = '';
            showAjaxPaixu(data1, 'newShowEmail');
            $('.getUser').show();
        } else if (boxStyle == 'drafts') {  //草稿箱
            data2.searchCriteria = '';
            $('.getUser').hide();
            showAjaxPaixu(data2, 'newShowEmail');
        } else if (boxStyle == 'outbox') {  //已发送
            data3.searchCriteria = '';
            $('.getUser').hide();
            showAjaxPaixu(data3, 'newShowEmail');
        } else if (boxStyle == 'recycle') {  //废纸篓
            data4.searchCriteria = '';
            $('.getUser').hide();
            showAjaxPaixu(data4, 'newShowEmail');
        } else if (boxStyle == 'otherBox') {  //其他邮件箱
            data5.searchCriteria = '';
            $('.getUser').hide();
            showAjaxPaixu(data5, 'selectBoxEmail');
        }
    })


    //刷新点击事件
    $('.ReFresh').on('click',function () {
        if (boxStyle == 'inbox') {  //收件箱
            // showAjax(data1,'showEmail');
            showAjaxPaixu(data1, 'newShowEmail');
            $('.getUser').show();
        } else if (boxStyle == 'drafts') {  //草稿箱
            $('.getUser').hide();
            // showAjax(data2,'showEmail');
            showAjaxPaixu(data2, 'newShowEmail');
        } else if (boxStyle == 'outbox') {  //已发送
            $('.getUser').hide();
            // showAjax(data3,'showEmail');
            showAjaxPaixu(data3, 'newShowEmail');
        } else if (boxStyle == 'recycle') {  //废纸篓
            $('.getUser').hide();
            // showAjax(data4,'showEmail');
            showAjaxPaixu(data4, 'newShowEmail');
        } else if (boxStyle == 'otherBox') {  //其他邮件箱
            $('.getUser').hide();
            // showAjax(data5,'selectBoxEmail');
            showAjaxPaixu(data5, 'selectBoxEmail');
        }
    })

    //标记已读
    $('.signReaders').on('click',function () {
        $('#inputType').attr('model','reelect')
        $('.chekEmail').prop('checked', false);
        if($('.chekEmail').attr('fuxuan')  == 'yes'){
            $('.chekEmail').removeAttr('fuxuan')
        }else{
            $('.chekEmail').attr('fuxuan','yes')
        }
        $('.chekEmail').toggle();
    })

    //一键全选
    $('.selectReaders').on('click',function () {
        $('.chekEmail').attr('fuxuan','no');
        $('#inputType').attr('model','selectAll')
        if ($('.chekEmail').prop('checked') == true) {
            $('.chekEmail').prop('checked', false);
            $('.chekEmail').hide();
            if (boxStyle == 'inbox') {
                $('#Replay', parent.document).show();
                $('#ReplayAll', parent.document).show();
            }
        } else {
            $('.chekEmail').show();
            $('.chekEmail').prop('checked', true);
            if (boxStyle == 'inbox') {
                $('#Replay', parent.document).hide();
                $('#ReplayAll', parent.document).hide();
            }
        }
    })
    //排序图标点击
    $('.sort_right').on('click',function (e) {
        e.stopPropagation();
        $('.signDiv').toggle();
    })
    var orderNameStr = "";
    var oWhereStr = "";
    //排序内容点击
    $('.signDiv').on('click', 'li', function () {
        $(this).addClass('bgSort').siblings().removeClass('bgSort');
        // orderNameStr=$(this).attr('orderByName');
        // oWhereStr=$(this).attr('orderWhere');
        orderNameStr = $('#orderByName').find('.bgSort').attr('orderByName');
        oWhereStr = $('#orderWhere').find('.bgSort').attr('orderWhere');
        var id = $('.divUlShow').find('li.on').attr('boxid');
        if (boxStyle == 'inbox') {  //收件箱
            data1.orderByName = orderNameStr;
            data1.orderWhere = oWhereStr;
            showAjaxPaixu(data1, 'newShowEmail');
            $('.getUser').show();
        } else if (boxStyle == 'drafts') {  //草稿箱
            data2.orderByName = orderNameStr;
            data2.orderWhere = oWhereStr;
            $('.getUser').hide();
            showAjaxPaixu(data2, 'newShowEmail');
        } else if (boxStyle == 'outbox') {  //已发送
            data3.orderByName = orderNameStr;
            data3.orderWhere = oWhereStr;
            $('.getUser').hide();
            showAjaxPaixu(data3, 'newShowEmail');
        } else if (boxStyle == 'recycle') {  //废纸篓
            data4.orderByName = orderNameStr;
            data4.orderWhere = oWhereStr;
            $('.getUser').hide();
            showAjaxPaixu(data4, 'newShowEmail');
        } else if (boxStyle == 'otherBox') {  //其他邮件箱
            data5.orderByName = orderNameStr;
            data5.orderWhere = oWhereStr;
            $('.getUser').hide();
            showAjaxPaixu(data5, 'selectBoxEmail');
        }
        $('.signDiv').hide();
    })
    $('.a1').on('click',function () {
        var str = '<tr class="tian"><td>' + email_th_carbonCopyRecipients + '：</td><td><textarea id="copeNameText" name="txt" disabled></textarea><span class="add_img"><a href="javascript:;" id="selectUserO" class="Add" style="margin-left: 16px;font-size: 14px;">' + global_lang_add + '</a></span><span class="add_img"><a href="javascript:;" class="clearCC" style="margin-left: 16px;font-size: 14px;">' + notice_th_delete1 + '</a></span></td></tr>';
        var txt = $(this).text();
        if (txt == email_th_addwait) {//添加抄送
            $(this).text(email_th_HideCC);//隐藏抄送
            $('.append_tr').after(str);
        } else {
            $(this).text(email_th_addwait);//添加抄送
            $('.tian').remove();
        }
    })

    $('.a2').on('click',function () {
        var str = '<tr class="mis"><td>' + email_th_BlindPeople + '：</td><td><textarea id="secritText" name="txt" disabled></textarea><span class="add_img"><a href="javascript:;" id="selectUserT" class="Add" style="margin-left: 16px;font-size: 14px;">' + global_lang_add + '</a></span><span class="add_img"><a href="javascript:;" class="clearBCC" style="margin-left: 16px;font-size: 14px;">' + notice_th_delete1 + '</a></span></td></tr>';
        var txt = $(this).text();
        if (txt == email_th_addbcc) {//添加密送
            $(this).text(email_th_HiddenSecret);//隐藏密送
            $('.append_tr').after(str);
        } else {
            $(this).text(email_th_addbcc);//添加密送
            $('.mis').remove();
        }
    })
    $('.a3').on('click',function(){
        // var str='<tr class="InText"><td style="padding: 5px;">'+InEmali+'：</td><td style="padding: 5px;"><select><option value="1729562020@qq.com">1729562020@qq.com</option><option value="845708329@qq.com">845708329@qq.com</option></select><span>'+sendMail+'</span></td></tr>';
        var txt=$(this).text();
        if (txt==addOut) {
            $(this).text(yinOut);
            $('.InText').show();
            $(this).attr('a3Type','1')
        }else{
            $(this).text(addOut);
            $('.InText').hide();
            $(this).attr('a3Type','0')
        }
    })
})

//邮件列表
function showAjax(dataId, emailUrl) {
    // $('.befor').find('li').remove();
    var ajaxPage = {
        data: dataId,
        page: function () {
            var me = this;
            $.ajax({
                type: 'get',
                url: emailUrl,
                dataType: 'json',
                data: me.data,
                success: function (res) {
                    var data1 = res.obj;
                    var str = '';
                    var dataNUm = res.object;
                    pageTotao = res.totleNum;
                    $('#inboxNum', parent.document).html(res.inboxCount);
                    $('#draftsNum', parent.document).html(res.draftsCount);
                    $('#hasBeenSendNum', parent.document).html(res.hairboxCount);
                    $('#wastebasketNum', parent.document).html(res.wasteCount);
                    $('#unreadNum', parent.document).html(res.noReadCount);
                    if (data1.length > 0) {
                        $('.befor').show();
                        $('.noContent').hide();
                        $('.noEmail').hide();
                        for (var i = 0; i < data1.length; i++) {
                            var sendTime = data1[i].sendTimes;
                            var emailSubject = '';
                            if (data1[i].emailList[0].withdrawFlag == undefined || data1[i].emailList[0].withdrawFlag == '0') {
                                emailSubject = data1[i].subject;
                            } else {
                                emailSubject = retuened + ':' + data1[i].subject;
                            }
                            var toNames = (data1[i].toName).split(',');
                            var toNameId = (data1[i].toId2).split(',');
                            str += '<li class="BTN" fromId="' + data1[i].fromId + '" style="cursor: pointer;text-align: left;height: 44px">' +
                                '<input type="hidden" readF="' + data1[i].emailList[0].readFlag + '" nId="' + data1[i].bodyId + '" id="' + data1[i].emailList[0].emailId + '"  emailId="' + data1[i].emailList[0].emailId + '" ueId="' + data1[i].emailList[0].deleteFlag + '">' +
                                '<input type="checkbox" class="chekEmail" checkId="' + data1[i].bodyId + '" emailId="' + data1[i].emailList[0].emailId + '" style="width:16px;display:none;">' +
                                '<div class="shang" style="display: inline;margin-left: 1%">' +
                                '<span style="position: absolute;left: 35px;">' + function () {
                                    if (dataId.flag == 'inbox') {
                                        return returnUserName(data1[i].users);
                                    } else if (dataId.flag == 'outbox') {
                                        if (data1[i].toName == '') {
                                            return toNameId[0];
                                        } else {
                                            return toNames[0];
                                        }
                                    } else {
                                        if (data1[i].users != undefined){
                                            return data1[i].users.userName
                                        }
                                        return '';
                                    }
                                }() + '</span>' +
                                function () {
                                    if (boxStyle == 'inbox' || boxStyle == 'unreadBox') {
                                        if (data1[i].emailList[0].readFlag == '1') {
                                            return '';
                                        } else {
                                            return '<img style="margin-left: -4.4%;float: left;width: 20px;height: 20px" class="noReadF" src="../img/unreads.png"/>';
                                        }
                                    } else {
                                        // return '<img src="../img/readed.png"/>';
                                        return '';
                                    }
                                }() +
                                '<span class="time">' + sendTime + '</span>' +
                                '</div>' +
                                '<div class="xia">' +
                                '<span style="float: left">' + function () {
                                    if (data1[i].attachmentId != '' && data1[i].emailList[0].withdrawFlag != '1') {
                                        return '<img style="left: 0px;" src="../img/huixingzhen.png"/>';
                                    } else {
                                        return '';
                                    }
                                }() + '</span>' +
                                '<a href="javascript:;" class="xia_txt" style="width: 90%;height:20px;white-space:normal;-webkit-line-clamp:2;overflow: hidden;-webkit-box-orient: vertical;position: absolute;left: 35px;    white-space: nowrap;word-break: keep-all;overflow: hidden;text-overflow: ellipsis;">' + emailSubject + '</a>' +
                                '</div>' +
                                '</li>';
                        }
                        $('.befor').append(str);
                        // $('li.BTN').eq(0).addClass("backing");
                        if (boxStyle == 'inbox' || boxStyle == 'unreadBox') {
                            $('li.BTN').eq(0).trigger('click');
                        }
                        $('li.BTN').eq(0).addClass("backing");
                        $('li.BTN').eq(0).find(".noReadF").attr('src', '');

                        var emailId = $('.befor .backing').find('input[type="hidden"]').attr('id');
                        var bodyNid = $('.befor .backing').find('input').attr('nId');
                        if (boxStyle == 'inbox' || boxStyle == 'unreadBox') {
                            var formIds = $('.befor .backing').attr('fromid');
                            var detailData = {
                                emailId: emailId,
                                flag: 'isRead'
                            }
                            $('.detailes').show();
                            $('.drafts').hide();
                            getUserInfo_s(formIds);
                            initData(detailData);
                        } else if (boxStyle == 'drafts') {
                            $('.detailes').hide();
                            $('.drafts').show();
                            initDrafts(bodyNid);

                        } else if (boxStyle == 'outbox') {
                            $('.getUser').hide();
                            $('.detailes').show();
                            $('.drafts').hide();
                            var detailOutbox = {
                                bodyId: bodyNid,
                                flag: ''
                            }
                            initData(detailOutbox);
                        } else if (boxStyle == 'recycle') {

                            $('.getUser').hide();
                            $('.detailes').show();
                            $('.drafts').hide();
                            var detailRecycle = {
                                emailId: emailId,
                                flag: ''
                            }
                            initData(detailRecycle);
                        } else if (boxStyle == 'otherBox') {
                            $('.getUser').hide();
                            $('.detailes').show();
                            $('.drafts').hide();
                            var detailOtherBox = {
                                emailId: emailId,
                                flag: ''
                            }
                            initData(detailOtherBox);
                        }
                    } else {
                        $('.befor').hide();
                        $('.noContent').show();
                        $('.noEmail').show().siblings().hide();
                    }
                    // me.pageTwo(res.totleNum,me.data.pageSize,me.data.page)
                }
            })

        },
        pageTwo: function (totalData, pageSize, indexs) {
            var mes = this;
            $('#dbgz_page').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage: '',
                endPage: '',
                current: indexs || 1,
                callback: function (index) {
                    mes.data.page = index.getCurrent();
                    mes.page();
                }
            });
        }
    };
    ajaxPage.page();
}

function yd(e) {
    var atturl = e.attr('attrurl');
    $.pdurl($.UrlGetRequest('?' + atturl), atturl);
}
//收件箱、已发送、废纸篓详情展示
function initData(datas) {
    layer.load();
    $('.detailes').find('#TAB').remove();
    $('.detailes').find('.article').remove();
    if (XHR) {
        XHR.abort();
    }
    var users = $.cookie("userName");
    XHR = $.ajax({
        type: 'get',
        url: 'queryByID',
        dataType: 'json',
        data: datas,
        success: function (rsp) {
            // console.log(XHR);
            $('.detailes').find('#TAB').remove();
            $('.detailes').find('.article').remove();
            var data2 = rsp.object;
            if (!data2 || data2.length <= 0) {
                return;
            }
            var liNum = $('#befor li').find('input[type="hidden"]')
            for(var i=0; i<liNum.length; i++){
                if(liNum.eq(i).attr('id') == datas.emailId){
                    $('#befor li').eq(i).addClass("backing").siblings().removeClass("backing")
                }
            }
            var sendTime = data2.sendTimes;
            var object = '';
            var stra = '';
            var people=''
            for(i=0;i<data2.toUserEmailInfo.length;i++){
                peop=data2.toUserEmailInfo[i].userName
                people+=peop+','
            }
            var str1=''
            str1='<tbody style="display: inline-block;padding-left: 30px;margin-top: 10px">' +
                '<tr style="margin-top: 10px;display: block">' +
                '<td style="width:80px;font-size: 11pt;font-weight: 600">'+email_th_sender+'：</td>' +
                '<td style="font-size: 11pt;">' + data2.users.userName + '</td>' +
                '</tr>' +
                '<tr style="margin-top: 10px;display: block"> ' +
                '<td style="width:80px;font-size: 11pt;font-weight: 600">'+email_th_recipients+'：</td>' +
                '<td style="font-size: 11pt;">' + people + '</td>' +
                '</tr >' +
                '<tr style="margin-top: 10px;display: block">' +
                '<td style="width:80px;font-size: 11pt;font-weight: 600">'+email_th_sending_time+'：</td>' +
                '<td style="font-size: 11pt;">' + sendTime + '</td>' +
                '</tr>' +
                '<tr style="margin-top: 10px;display: flex;">' +
                '<td style="width:100px;font-size: 11pt;font-weight: 600">'+email_th_main+'：</td>' +
                '<td width="100%" style="display:block;margin-left: 10px;font-size: 11pt;white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" >' + data2.subject + '</td>' +
                '</tr>' +
                '</tbody>'
            $('.imformation').html(str1)
            var arr = new Array();
            arr = data2.attachment;
            var content = '';
            if (data2.emailList[0].withdrawFlag == '0') {
                var contentMsg = data2.content;
                if (contentMsg.indexOf('iframe') > -1) {
                    var cm = $('<div>' + contentMsg.toString() + '</div>');
                    cm.find('iframe').remove();
                    contentMsg = cm.html();
                }
                content = contentMsg;
            } else {
                content = sysLdering;
            }

            var emailSubject = '';
            if (data2.emailList[0].withdrawFlag == undefined || data2.emailList[0].withdrawFlag == '0') {
                emailSubject = data2.subject;
            } else {
                emailSubject = retuened + ':' + data2.subject;
            }
            object += '<table id="TAB" cellspacing="0" cellpadding="0" style="border-collapse:collapse;table-layout: fixed;">' +
                '<tr>' +
                '<td style="width:70px;">' + email_th_main + '：</td>' +
                '<td width="100%" style="display:block;white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" title="' + data2.subject + '">' +
                '<div id="title" style="width:60%;width: calc(100% - 200px);display:block;white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" title="' + data2.subject + '">' + emailSubject + '</div>' +
                '</td></tr>' +  //主题
                '<tr><td>' + email_th_sender + '：</td><td>' + data2.users.userName + '</td></tr>' +  //发件人
                '<tr><td>' + email_th_recipients + '：</td>' +
                '<td><span class="isReaderType" style="display: inline-block;" title="' + data2.toName + '">' + function () {
                    if (data2.toUserEmailInfo) {
                        var userStr = "";

                        for (var i = 0; i < data2.toUserEmailInfo.length; i++) {
                            if (i > 2) {
                                userStr += "...";
                                break;
                            }
                            if (data2.toUserEmailInfo[i].readFlag == '1') {
                                userStr += '<img src="/img/email_open.gif" /><span style="margin-right: 10px;">' + data2.toUserEmailInfo[i].userName + '</span>'
                            } else {
                                userStr += '<img   src="../img/unread.png" class="noReadF"/><span style="margin-right: 10px;">' + data2.toUserEmailInfo[i].userName + '</span>'
                            }
                        }
                        return userStr;
                    }
                }() + '</span>' +
                '<a urls="" href="/email/emailReadDetail?bodyId=' + data2.bodyId + '&userIdsType=toId2" target="_blank">' + event_th_ViewMailStatus + '</a></td></tr>'
            //收件人
            if (data2.copyName != '') {
                object += '<tr><td>' + email_th_carbonCopyRecipients + '：</td>' +
                    '<td><span class="copyType" style="display: inline-block;" title="' + data2.copyName + '">' + function () {
                        var copyUserStr = "";
                        if (data2.copyUserEmailInfo) {
                            for (var i = 0; i < data2.copyUserEmailInfo.length; i++) {
                                if (i > 2) {
                                    copyUserStr += "...";
                                    break;
                                }
                                if (data2.copyUserEmailInfo[i].readFlag == '1') {
                                    copyUserStr += '<img src="/img/email_open.gif" /><span style="margin-right: 10px;">' + data2.copyUserEmailInfo[i].userName + '</span>'
                                } else {
                                    copyUserStr += '<img src="../img/unread.png" class="noReadF"/><span style="margin-right: 10px;">' + data2.copyUserEmailInfo[i].userName + '</span>'
                                }
                            }
                            return copyUserStr;
                        }
                    }() + '</span>' +
                    '<a urls="" href="/email/emailReadDetail?bodyId=' + data2.bodyId + '&userIdsType=copyToId" target="_blank">' + event_th_ViewMailStatus + '</a>' +
                    '</td></tr>';
                //抄送人
            }
            if(boxStyle == 'inbox'){
                if (data2.secretToName != '' && data2.secretToName != undefined) {
                    var secretToName = data2.secretToName.split(',')
                    for(var i=0;i<secretToName.length;i++){
                        if(users == secretToName[i]){
                            object += '<tr><td>' + email_th_BlindPeople + '：</td>' +
                                '<td><span class="secrCopy" style="display: inline-block;min-width: 240px;width:30%;">' + function () {
                                    var secrUserStr = "";
                                    secrUserStr = '<img src="../img/readed.png" /><span style="margin-right: 10px;">' + secretToName[i] + '</span>'
                                    // var secrUserStr = "";
                                    // if (data2.sercUserEmailInfo) {
                                    //     for (var i = 0; i < data2.sercUserEmailInfo.length; i++) {
                                    //         if (i > 2) {
                                    //             secrUserStr += "...";
                                    //             break;
                                    //         }
                                    //         if (data2.sercUserEmailInfo[i].readFlag == '1') {
                                    //             secrUserStr += '<img src="../img/readed.png" /><span style="margin-right: 10px;">' + data2.sercUserEmailInfo[i].userName + '</span>'
                                    //         } else {
                                    //             secrUserStr += '<img src="../img/unread.png" class="noReadF"/><span style="margin-right: 10px;">' + data2.sercUserEmailInfo[i].userName + '</span>'
                                    //         }
                                    //     }
                                    //     return secrUserStr;
                                    // }
                                    return secrUserStr;
                                }()
                                + '</span>' +
                                '<a urls="" href="/email/emailReadDetail?bodyId=' + data2.bodyId + '&userIdsType=secretToId&inboxType=inbox" target="_blank">' + event_th_ViewMailStatus + '</a>' +
                                '</td></tr>'
                        }
                    }

                    //密送人
                }
            }else{
                if (data2.secretToName != '' && data2.secretToName != undefined) {
                    object += '<tr><td>' + email_th_BlindPeople + '：</td>' +
                        '<td><span class="secrCopy" style="display: inline-block;min-width: 240px;width:30%;">' + function () {
                            var secrUserStr = "";
                            if (data2.sercUserEmailInfo) {
                                for (var i = 0; i < data2.sercUserEmailInfo.length; i++) {
                                    if (i > 2) {
                                        secrUserStr += "...";
                                        break;
                                    }
                                    if (data2.sercUserEmailInfo[i].readFlag == '1') {
                                        secrUserStr += '<img src="../img/readed.png" /><span style="margin-right: 10px;">' + data2.sercUserEmailInfo[i].userName + '</span>'
                                    } else {
                                        secrUserStr += '<img src="../img/unread.png" class="noReadF"/><span style="margin-right: 10px;">' + data2.sercUserEmailInfo[i].userName + '</span>'
                                    }
                                }
                                return secrUserStr;
                            }
                        }() + '</span>' +
                        '<a urls="" href="/email/emailReadDetail?bodyId=' + data2.bodyId + '&userIdsType=secretToId&inboxType=outbox" target="_blank">' + event_th_ViewMailStatus + '</a>' +
                        '</td></tr>'
                }
            }

            object += '<tr><td>' + email_th_time + '：</td><td>' + sendTime + '</td></tr>'//时间



            if (data2.attachment.length > 0) {
                if(data2.attachment.length > 1){
                    var manydownload = '<a class="operation batch" href="javascript:void(0);"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">批量下载</a>';
                }else{
                    var manydownload = ''
                }
                object += '<tr><td>' + email_th_file + '：</td><td class="attachment" id="operationImg2">' + attachView(arr, '', '4', '0', '1', '0') + '<div>'+ manydownload +'</div></td></tr>';

            }
            object += '</table>' +
                '<div class="article"><p>' + content + '</p></div>';

            $('.detailes').append(object);
            $('.img_').css('height','16px')
            $('.img_').css('width','16px')
            $('.operationImg').on('click',function(){
                // $(document).on('click','.operationImg',function () {
                var thisa = $(this).next().attr('openimg')
                var openNmu = $(this).next().attr('openNmu')
                if($('#getIndex').length > 0){
                    $('#getIndex').remove()
                }
                var str3 = '<input type="text" id="getIndex" openNum = "'+openNmu+'" style="display: none">'
                $('#operationImg2').append(str3)
                $('#getIndex').val(thisa)
                event.stopPropagation()
                window.open("/email/imgOpen?openNmu="+openNmu,"_blank");
                // layer.open({
                //     title:'图片',
                //     type: 2,
                //     shadeClose: true,
                //     shade: 0.5,
                //     maxmin: true, //开启最大化最小化按钮
                //     area: ['100%', '100%'],
                //     content: '/email/imgOpen',
                //     success: function () {
                //
                //     }
                // });
            })


            // $('.batch').click(function () {
            //     for (var i = 0; i < $('.attachment .font_').length; i++) {
            //         var atturl = $('.attachment .font_ ').children('.download').eq(i).attr('href');
            //         window.open(encodeURI(atturl));
            //     }
            // })
            $('.batch').on('click',function () {
                var str = '';
                for(var i=0;i<arr.length;i++){
                    str+= arr[i].aid+','
                }
                var nowTime = new Date().toLocaleString();
                var toyear = nowTime.substring(0,6);
                var today =  nowTime.substring(7,11);
                var Nowadays = $("#title").attr("title")
                window.location.href='/getZipFilename?aId='+str+'&module=email&zipName='+encodeURI(Nowadays);

            })
            var toUserArrId = [];
            var copyUserArrId = [];
            var sercUserArrId = [];
            var indextoUser = -1;
            var indexcopyUser = -1;
            var indexsercUser = -1;
            if (data2.toUserEmailInfo) {
                for (var i = 0; i < data2.toUserEmailInfo.length; i++) {
                    toUserArrId.push(data2.toUserEmailInfo[i].toId)
                }

                if (toUserArrId.toString().indexOf(userCookie) > -1) {
                    for (var i = 0; i < toUserArrId.length; i++) {
                        if (toUserArrId[i] == userCookie) {
                            indextoUser = i;
                            break;
                        }
                    }
                    $('.isReaderType').find('img').eq(indextoUser).attr('src', '/img/email_open.gif');
                }

            }
            if (data2.copyUserEmailInfo) {
                for (var i = 0; i < data2.copyUserEmailInfo.length; i++) {
                    copyUserArrId.push(data2.copyUserEmailInfo[i].toId)
                }
                if (copyUserArrId.toString().indexOf(userCookie) > -1) {
                    for (var i = 0; i < copyUserArrId.length; i++) {
                        if (copyUserArrId[i] == userCookie) {
                            indexcopyUser = i;
                            break;
                        }
                    }
                    $('.copyType').find('img').eq(indexcopyUser).attr('src', '/img/email_open.gif');
                }
            }
            if (data2.sercUserEmailInfo) {
                for (var i = 0; i < data2.sercUserEmailInfo.length; i++) {
                    sercUserArrId.push(data2.sercUserEmailInfo[i].toId)
                }
                if (sercUserArrId.toString().indexOf(userCookie) > -1) {
                    for (var i = 0; sercUserArrId.length; i++) {
                        if (sercUserArrId[i] == userCookie) {
                            indexsercUser = i;
                            break;
                        }
                    }
                    $('.secrCopy').find('img').eq(indexsercUser).attr('src', '../img/readed.png');
                }
            }
            var Height = $('.detailes').height() - $('#TAB').height() - 46;
            $('.article').height(Height + 'px');

            $('.imgfileBox').css("margin-left", "25px")
            $('.imgfileBox').append('<ul class="hoverbox"><li class="hoverboxLiConsult"><span class="plotting">></span>'+email_th_refer_to+'</li><li class="hoverboxLiDownload"><span class="plotting">></span>'+email_th_download+'</li></ul>')
            $('.imgfileBox').on('mouseover',function () {
                if ($(this).children('.hoverbox').length > 0) {
                    $(this).children('.hoverbox').eq($(this).children('.hoverbox').length - 1).show();
                }
            });
            $('.imgfileBox').on('mouseout',function () {
                if ($(this).children('.hoverbox').length > 0) {
                    $(this).children('.hoverbox').eq($(this).children('.hoverbox').length - 1).hide();
                }

            });
            $('.imgfileBox').on('click', '.hoverboxLiDownload', function () {
                if($(this).parents('.imgfileBox').find('img').hasClass('imgupload_data')){
                    var atturl = $(this).parents('.imgfileBox').find('img').attr('src').split('/xs?')[1]
                }else{
                    var atturl = $(this).parents('.imgfileBox').find('img').attr('atturl');
                }
                window.open("/download?" + encodeURI(atturl));

            })
            $('.imgfileBox').on('click', '.hoverboxLiConsult', function () {
                if($(this).parents('.imgfileBox').find('img').hasClass('imgupload_data')){
                    var str = $(this).parents('.imgfileBox').find('img').attr('src').split('/xs?')[1];
                    var fileURl = $(this).parents('.imgfileBox').find('img').attr('title');
                }else{
                    var str = $(this).parents('.imgfileBox').find('img').attr('atturl');
                    var fileURl = $(this).parents('.imgfileBox').find('img').next().text();
                }
                var fileExtension = fileURl.substring(fileURl.lastIndexOf(".") + 1, fileURl.length);//截取附件文件后缀
                pdurl(fileExtension, str);
            });
            layer.closeAll()
        }
    });
}
//草稿箱详情展示
function initDrafts(nId) {
    $.ajax({
        type: 'get',
        url: 'queryByID',
        dataType: 'json',
        data: {'bodyId': nId, 'flag': ''},
        success: function (rsp) {
            if (rsp.flag == true) {
                var data2 = rsp.object;
                if (!data2 || data2.length <= 0) {
                    return;
                }
                var atta = data2.attachment;
                var str = '';
                $('.tian').remove();
                $('.mis').remove();

                $('textarea').val('');
                $('#txt').val('');


                $('#senduser').val('');
                $('.Attachment td').eq(1).find('div').remove();
                for (var i = 0; i < atta.length; i++) {
                    if(atta[i].attachName.split('.')[1]=='ofd'|atta[i].attachName.split('.')[1]=='oFd'||atta[i].attachName.split('.')[1]=='OFD'||atta[i].attachName.split('.')[1]=='oFD'){
                        str += '<div class="dech" name1="'+atta[i].attachName+'" deUrl="' + encodeURI(atta[i].attUrl) + '">' +
                            '<a href="/download?' + encodeURI(atta[i].attUrl) + '" NAME="' + atta[i].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
                            '<img style="margin-right:10px;" src="../img/huixingzhen.png"/>' + atta[i].attachName + '</a>' +
                            '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/>' +
                            '<a fileExtension="'+atta[i].attachName.split('.')[1] +'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">'+yulan+'</a><a style="padding-left: 5px" href="/download?'+encodeURI(atta[i].attUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">'+email_th_download+'</a>' +
                            '<a class="operation" href="javascript:;" onclick="editAttachment($(this))" class="editFile" style="margin-left: 10px;" attrurl="' +encodeURI(atta[i].attUrl) + '"><img src="/img/attachmentIcon/icon_edit.png" style="margin-right: 5px;" alt="">'+edit1+'</a><a fileExtension="'+atta[i].attachName.split('.')[1] +'" onclick="transfers($(this))"  attrurl="' +encodeURI(atta[i].attUrl) + '" href="javascript:;" style="padding-left: 5px"  ><img src="/img/attachmentIcon/tran.png"  style="padding: 0 5px;">'+email_th_transfer_and_save+'</a>'+
                            '<input type="hidden" class="inHidden" value="' + atta[i].aid + '@' + atta[i].ym + '_' + atta[i].attachId + ',">' +
                            '</div>';
                    }else{
                        str += '<div class="dech" name1="'+atta[i].attachName+'" deUrl="' + encodeURI(atta[i].attUrl) + '">' +
                            '<a href="/download?' + encodeURI(atta[i].attUrl) + '" NAME="' + atta[i].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
                            '<img style="margin-right:10px;" src="../img/huixingzhen.png"/>' + atta[i].attachName + '</a>' +
                            '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/>' +
                            '<a fileExtension="'+atta[i].attachName.split('.')[1] +'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">'+email_th_refer_to+'</a><a style="padding-left: 5px" href="/download?'+encodeURI(atta[i].attUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">'+email_th_download+'</a>' +
                            '<a class="operation" href="javascript:;" onclick="editAttachment($(this))" class="editFile" style="margin-left: 10px;" attrurl="' +encodeURI(atta[i].attUrl) + '"><img src="/img/attachmentIcon/icon_edit.png" style="margin-right: 5px;" alt="">'+edit1+'</a><a fileExtension="'+atta[i].attachName.split('.')[1] +'" onclick="transfers($(this))"  attrurl="' +encodeURI(atta[i].attUrl) + '" href="javascript:;" style="padding-left: 5px"  ><img src="/img/attachmentIcon/tran.png"  style="padding: 0 5px;">'+email_th_transfer_and_save+'</a>'+
                            '<input type="hidden" class="inHidden" value="' + atta[i].aid + '@' + atta[i].ym + '_' + atta[i].attachId + ',">' +
                            '</div>';
                    }
                }
                $('.Attachment td').eq(1).append(str);
                $('#senduser').val(data2.toName);
                $('#senduser').attr('user_id', data2.toId2);
                if (data2.copyToId != '') {
                    var cStr = '';
                    cStr = '<tr class="tian"><td>' + email_th_carbonCopyRecipients + '：</td><td><textarea id="copeNameText" name="txt" disabled></textarea><span class="add_img"><a href="javascript:;" id="selectUserO" class="Add" style="margin-left: 5px;">' + global_lang_add + '</a></span><span class="add_img"><a href="javascript:;" class="clearCC" style="margin-left: 5px;">' + notice_th_delete1 + '</a></span></td></tr>';
                    $('.a1').text(email_th_HideCC);
                    $('.append_tr').after(cStr);
                    $('#copeNameText').attr('user_id', data2.copyToId + ',');
                    $('#copeNameText').val(data2.copyName);
                }
                if (data2.secretToId != '') {
                    var sStr = '';
                    sStr = '<tr class="mis"><td>' + email_th_BlindPeople + '：</td><td><textarea id="secritText" name="txt" disabled></textarea><span class="add_img"><a href="javascript:;" id="selectUserT" class="Add" style="margin-left: 5px;">' + global_lang_add + '</a></span><span class="add_img"><a href="javascript:;" class="clearBCC" style="margin-left: 5px;">' + notice_th_delete1 + '</a></span></td></tr>';
                    $('.a2').text(email_th_HiddenSecret);//'隐藏密送'
                    $('.append_tr').after(sStr);
                    $('#secritText').attr('user_id', data2.secretToId + ',');
                    $('#secritText').val(data2.secretToName);
                }
                $('#txt').val(data2.subject);
                $('#outEmail').val(data2.toWebmail);

                $("#outSelect option[value='"+data2.fromWebmail+"']").attr("selected","selected");
                ue = UE.getEditor('container',{elementPathEnabled : false});
                // UEimgfuc();
                ue.ready(function () {
                    ue.setContent(data2.content);
                });
                // ue.addListener("ready", function () {
                //     // editor准备好之后才可以使用
                //     ue.setContent('');
                //     if (ue.setContent) {
                //         ue.setContent(data2.content);
                //     }
                // });
            }
        }
    });
}


//排序列表
function showAjaxPaixu(dataId, emailUrl) {
    // $('.befor').find('li').remove();
    var ajaxPage = {
        data: dataId,
        page: function () {
            var me = this;
            $.ajax({
                type: 'get',
                url: emailUrl,
                dataType: 'json',
                data: me.data,
                success: function (res) {
                    var data1 = res.obj;
                    var str = '';
                    var dataNUm = res.object;
                    pageTotao = res.totleNum;
                    $('#inboxNum', parent.document).html(res.inboxCount);
                    $('#draftsNum', parent.document).html(res.draftsCount);
                    $('#hasBeenSendNum', parent.document).html(res.hairboxCount);
                    $('#wastebasketNum', parent.document).html(res.wasteCount);
                    if (data1.length > 0) {
                        $('.befor').show();
                        $('.noContent').hide();
                        $('.noEmail').hide();
                        for (var i = 0; i < data1.length; i++) {
                            var sendTime = data1[i].sendTimes;
                            var emailSubject = '';
                            var toNames = (data1[i].toName).split(',');
                            var toNameId = (data1[i].toId2).split(',');
                            if (data1[i].emailList[0].withdrawFlag == undefined || data1[i].emailList[0].withdrawFlag == '0') {
                                emailSubject = data1[i].subject;
                            } else {
                                emailSubject = retuened + ':' + data1[i].subject;
                            }
                            str += '<li class="BTN" fromId="' + data1[i].fromId + '" style="cursor: pointer;text-align: left;height: 44px">' +
                                '<input type="hidden" readF="' + data1[i].emailList[0].readFlag + '" nId="' + data1[i].bodyId + '" id="' + data1[i].emailList[0].emailId + '" ueId="' + data1[i].emailList[0].deleteFlag + '">' +
                                '<input type="checkbox" class="chekEmail" checkId="' + data1[i].bodyId + '" style="width:16px;display:none;">' +
                                '<div class="shang" style="display: inline;margin-left: 1%">' +
                                '<span style="position: absolute;\n' +
                                '    left: 35px;">' + function () {
                                    if (dataId.flag == 'inbox') {
                                        return returnUserName(data1[i].users);
                                    } else if (dataId.flag == 'outbox') {
                                        if (data1[i].toName == '') {
                                            return toNameId[0];
                                        } else {
                                            return toNames[0];
                                        }
                                    } else {
                                        return data1[i].users.userName;
                                    }
                                }() + '</span>' +
                                function () {
                                    if (boxStyle == 'inbox' || boxStyle == 'unreadBox') {
                                        if (data1[i].emailList[0].readFlag == '1') {
                                            // return '<img src="../img/readed.png"/>';
                                            return '';
                                        } else {
                                            return '<img style="margin-left: -4.4%;float: left;width: 20px;height: 20px" class="noReadF" src="../img/unreads.png"/>';
                                        }
                                    } else {
                                        // return '<img src="../img/readed.png"/>';
                                        return '';
                                    }
                                }() +
                                '<span class="time">' + sendTime + '</span>' +
                                '</div>' +
                                '<div class="xia">' +
                                '<span style="float: left">' + function () {
                                    if (data1[i].attachmentId != '' && data1[i].emailList[0].withdrawFlag != '1') {
                                        return '<img style="left: 0px;" src="../img/huixingzhen.png"/>';
                                    } else {
                                        return '';
                                    }
                                }() + '</span>' +
                                '<a href="javascript:;" class="xia_txt" style="width: 90%;height:20px;white-space:normal;-webkit-line-clamp:2;overflow: hidden;-webkit-box-orient: vertical;position: absolute;left: 35px;    white-space: nowrap;word-break: keep-all;overflow: hidden;text-overflow: ellipsis;">' + emailSubject + '</a>' +
                                '</div>' +
                                '</li>';
                        }
                        $('.befor').html(str);
                        $('li.BTN').eq(0).addClass("backing");
                        var emailId = $('.befor .backing').find('input[type="hidden"]').attr('id');
                        var bodyNid = $('.befor .backing').find('input').attr('nId');
                        if (boxStyle == 'inbox' || boxStyle == 'unreadBox') {
                            var formIds = $('.befor .backing').attr('fromid');
                            var detailData = {
                                emailId: emailId,
                                flag: ''
                            }
                            $('.detailes').show();
                            $('.drafts').hide();
                            getUserInfo_s(formIds);
                            initData(detailData);
                        } else if (boxStyle == 'drafts') {
                            $('.detailes').hide();
                            $('.drafts').show();
                            initDrafts(bodyNid);

                        } else if (boxStyle == 'outbox') {
                            $('.getUser').hide();
                            $('.detailes').show();
                            $('.drafts').hide();
                            var detailOutbox = {
                                bodyId: bodyNid,
                                flag: ''
                            }
                            initData(detailOutbox);
                        } else if (boxStyle == 'recycle') {

                            $('.getUser').hide();
                            $('.detailes').show();
                            $('.drafts').hide();
                            var detailRecycle = {
                                emailId: emailId,
                                flag: ''
                            }
                            initData(detailRecycle);
                        } else if (boxStyle == 'otherBox') {
                            $('.getUser').hide();
                            $('.detailes').show();
                            $('.drafts').hide();
                            var detailOtherBox = {
                                emailId: emailId,
                                flag: ''
                            }
                            initData(detailOtherBox);
                        }
                    } else {
                        $('.befor').hide();
                        $('.noContent').show();
                        $('.noEmail').show().siblings().hide();
                    }
                }
            })

        },
        pageTwo: function (totalData, pageSize, indexs) {
            var mes = this;
            $('#dbgz_page').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage: '',
                endPage: '',
                current: indexs || 1,
                callback: function (index) {
                    mes.data.page = index.getCurrent();
                    mes.page();
                }
            });
        }
    };
    ajaxPage.page();
}


//获取人员图像、信息接口
function getUserInfo_s(id) {
    $.ajax({
        type: 'get',
        url: '../user/findUserByuserId',
        dataType: 'json',
        data: {'userId': id},
        success: function (res) {
            if (res.flag == true) {
                var dataU = res.object;
                $('.zong').text(dataU.userPrivName);
                $('.userdept').text(dataU.deptName);
                $('.span_hr').find('p').find('span').eq(0).html(dataU.userName);
                if (dataU.avatar == '' || dataU.avatar == undefined) {
                    $('.attrImg img').attr('src', '../img/email/icon_head_man_06.png');
                } else if (dataU.avatar == 0) {
                    $('.attrImg img').attr('src', '../img/user/boy.png');
                } else if (dataU.avatar == 1) {
                    $('.attrImg img').attr('src', '../img/user/girl.png');
                } else {
                    $('.attrImg img').attr('src', '../../img/user/' + dataU.avatar);
                }
            }

        }
    })
}
//获取地址栏参数
function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null)return unescape(r[2]);
    return null
}
<!-- 处理姓名为空处理 /users处理 -->
function returnUserName(users) {
    if (users == undefined || users == "") {
        return ""
    } else {
        return users.userName
    }
}
//查看邮件状态
function lookemail(e) {
    var urls = e.attr('urls');
    var name = '<fmt:message code="event.th.ViewMailStatus" />';
    if (typeof(qt) == 'undefined') {
        window.open(urls);
    } else {
        new QWebChannel(qt.webChannelTransport, function (channel) {
            var content = channel.objects.interface;
            content.xoa_sms(urls, name, "web_child_url")
        })
    }
}
