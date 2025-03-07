/**
 * Created by 张航宁 on 2019/4/29.
 */
$(function () {
    ue.ready(function() {
        var runId = $.getQueryString("runId") || '';
        var chkValue = $.getQueryString("chkValue") || '';
        var flowContent = '';
        if(chkValue != ''){
            flowContent = '<link rel="stylesheet" type="text/css" href="/css/workflow/m_reset.css">' +
                '<link rel="stylesheet" type="text/css" href="../../css/workflow/work/new_work.css">' +
                '<link rel="stylesheet" type="text/css" href="../../css/workflow/work/bootstrap.css">' +
                '<link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>' +
                '<link rel="stylesheet" type="text/css" href="../../css/workflow/work/handle.css"/>' +
                '<link rel="stylesheet" type="text/css" href="/css/dept/roleAuthorization.css?20220601"/>' +
                '<link rel="stylesheet" href="/css/workflow/work/workFormPreView.css?20220601"><style>.cont_form{height: auto;}</style>'
            // 表单信息
        }

        if(chkValue.indexOf('1')!=-1){
            try {
                $(".cont_form script",window.opener.document).remove()
                var form_content = $(".cont_form",window.opener.document).html();
                flowContent+='<div class="cont_form" id="a2">'+form_content+'</div>';
            }catch (e) {
                alert(notice_th_formError_pleaseGgoBackAndSelect_again+"！")
                window.opener=null
                window.top.open('','_self','')
                window.close();
            }

        }

        // 附件信息
        if(chkValue.indexOf('2')!=-1){
            // if($(".theAttachment",window.opener.document).css('display')!='none'){
            var attachment_content = $(".theAttachment",window.opener.document).html();
            flowContent+='<div class="theAttachment">'+attachment_content+'</div>';
            //兼容win7系统的ie模式
            // if(window.opener.document.querySelector('.theAttachment').style.display!='none'){

                //此处附件显示和公共附件显示重复，暂时注释此处代码
                // 请求接口 设置附件回显到公告附件
               /* $.get('/flowUtil/flowAttach2Other',{
                    runId:runId,
                    module:"notify"
                },function (res) {
                    var data = res.obj;
                    var str = '';
                    for (var i = 0; i < data.length; i++) {
                        str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" style="color: #000;" NAME="'+data[i].attachName+'*" href="javascript:;">'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';
                    }
                    $('#fileAll').append(str);
                })*/
            // }
        }

        // 会签意见
        if(chkValue.indexOf('3')!=-1){
            // if($(".steptextcheck",window.opener.document).css('display')!='none'){
            //兼容win7系统的ie模式
            // if(window.opener.document.querySelector('.steptextcheck').style.display!='none'){
            //
            // }
            var check_content = $(".steptextcheck",window.opener.document).html();
            flowContent+='<div class="steptextcheck">'+check_content+'</div>'
        }

        // 流程图
        if(chkValue.indexOf('4')!=-1){
            var liucheng_content = $(".steptextliucheng",window.opener.document).html();
            flowContent+='<div class="steptextliucheng">'+liucheng_content+'</div>'
        }

        // 公文正文
        if(chkValue.indexOf('5')!=-1){
            /*if($(".theAttachment",window.opener.document).css('display')!='none'){
                var attachment_content = $(".theAttachment",window.opener.document).html();
                flowContent+='<div class="theAttachment">'+attachment_content+'</div>';
            }*/
            // 请求接口 设置附件回显到公告附件
            $.get('/flowUtil/flowAttachDocument',{
                runId:runId,
                module:"notify"
            },function (res) {
                var data = res.obj;
                var str = '';
                for (var i = 0; i < data.length; i++) {
                    str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a href="/download?'+encodeURI(data[i].attUrl)+'" class="ATTACH_a" style="color: #2b7fe0;" NAME="'+data[i].attachName+'*" href="javascript:;"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';
                }
                $('#fileAll').append(str);
                $('#ajaxform input[name="subject"]').val(res.object)
                $('#ajaxform select[name="typeId"]').val(res.obj1)
            })
        }
        ue.setContent(flowContent);
    });

});