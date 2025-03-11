/**
 * Created by 骆鹏 on 2017/7/27.
 */
var flowId
var formId
var minHangEdu;
var userEmailPanel = '';
//判断哪种模式显示
$.ajax({
    type: "post",
    url: "/users/getUserTheme",
    dataType: 'json',
    success: function (res) {
        var data = res.object;
        userEmailPanel = data.userExt.documentPanel;
        if ( userEmailPanel == '1'){
            $('.up_format li').eq(0).trigger('click');
        }else{
            $('.up_format li').eq(1).trigger('click');
        }
    }
})
$(function () {
    $.get('/document/sortFlow',{mainType:'DOCUMENTTYPE',detailType:'SENDNG'},function (json) {
        var width = $('.tableDl').width() * 0.2 * 0.94 - 30;
        if(json.flag&&json.datas!=undefined){
            $('.noData').hide();
            var arr=json.datas;
            var str=''
            for(var i=0;i<arr.length;i++){
                if(arr[i].flows.length != 0){
                    if(userEmailPanel != '1'){
                        str+='<dl style="width: 45%;height: auto">\
                        <dt>\
                            <img src="/img/sys/icon_organizationmanagement_03.png" alt=""> \
                            <span title="'+arr[i].sortName+'" style="width: '+ width +';">'+arr[i].sortName+'</span>\
                        </dt>\
                        <dd style="height: auto">\
                            <ul>\
                            '+function () {
                            var arrys=arr[i].flows;
                            var strflows=''
                            for(var m=0;m<arrys.length;m++){
                                strflows+='<li data-id="1" data-urlid="'+arrys[m].flowId+'" data-name="'+arrys[m].flowName+'" flowId="'+arrys[m].flowId+'" formId="'+arrys[m].formId+'">\
                                                <b></b>\
                                                <a  \
                                                href="javascript:void(0)"  >\
                                                '+arrys[m].flowName+'</a>\
                                               </li>'
                            }
                            return strflows;
                        }()+'\
                            </ul>\
                        </dd>\
                      </dl>'
                    }else{
                        str+='<dl>\
                        <dt>\
                            <img src="/img/sys/icon_organizationmanagement_03.png" alt=""> \
                            <span title="'+arr[i].sortName+'" style="width: '+ width +';">'+arr[i].sortName+'</span>\
                        </dt>\
                        <dd>\
                            <ul>\
                            '+function () {
                            var arrys=arr[i].flows;
                            var strflows=''
                            for(var m=0;m<arrys.length;m++){
                                strflows+='<li data-id="1" data-urlid="'+arrys[m].flowId+'" data-name="'+arrys[m].flowName+'" flowId="'+arrys[m].flowId+'" formId="'+arrys[m].formId+'">\
                                                <b></b>\
                                                <a  \
                                                href="javascript:void(0)"  >\
                                                '+arrys[m].flowName+'</a>\
                                               </li>'
                            }
                            return strflows;
                        }()+'\
                            </ul>\
                        </dd>\
                      </dl>'
                    }

                }

            }

            if(arr.length==0){
                str='<div style="position: relative;height: 100%">' +
                        '<div style="position: absolute;width: 100px;height: 130px;' +
                    'top: 38%;margin-top: -50px;left: 50%;margin-left: -50px;">' +
                            '<img src="/img/common/dianjikong.png" alt="">' +
                            '<p style="text-align: center;font-size: 11pt;color: #000;margin-top: 10px;' +
                    'padding-left: 12px;">'+no_Data+'</p>' +
                        '</div>' +
                    '</div>'

            }
            $('.tableDl').html(str)
        }else{
            $('.noData').show();
        }
    },'json')

    $('.up_format li').on('click', function(){
        var indexNum=$(this).index();
        if(indexNum == 0){
            $('.tableDl dl').css('width','26%')
            $('.tableDl dl').css('height','230px')
            $('.tableDl dl dd').css('height','186px')
            $('.up_format li').eq(0).addClass('for_on').find('img').attr('src','/img/commonTheme/theme6/icon_zuoyou_sel_03.png');
            $('.up_format li').eq(1).removeClass('for_on').find('img').attr('src','/img/iCon_list_003.png');
            $("#w2").removeAttr("click");
            userEmailPanel = '1';
        }else{
            $('.tableDl dl').css('width','45%')
            $('.tableDl dl').css('height','auto')
            $('.tableDl dl dd').css('height','auto')
            $('.up_format li').eq(0).removeClass('for_on').find('img').attr('src','/img/icon_zuoyou_03.png');
            $('.up_format li').eq(1).addClass('for_on').find('img').attr('src','/img/icon_list_sel_03.png');
            $("#w2").attr("click",'true');
            userEmailPanel = '2';
        }
        $.ajax({
            type: "post",
            url: "/userExt/userExtMenuPanel",
            dataType: 'json',
            data:{
                documentPanel: userEmailPanel
            },
            success: function (res) {
                if (res.flag){
                    userEmailPanel = (indexNum + 1);
                }
            }
        })
    })
    
    $('.tableDl').on('click', '[data-id="1"]', function () {
        var urlid=$(this).attr('data-urlid');
        var runId=null;
        var runName=null;
        var flowName=$(this).attr("data-name");
        flowId=$(this).attr("flowId");
        formId=$(this).attr("formId");
        (function (fn) {
            $.post('/document/getRunName',{flowId:urlid,runId:'',prcsId:1,flowStep:1},function (json) {
                if(json.flag){
                    // runId=json.data;
                    runName=json.data;
                    if(fn!=undefined){
                        fn()
                    }
                }

            },'json')
        })(function () {
            $.get('/syspara/selectProjectId',function (res) {
                if(res.object== 'MINHANG_EDU'){
                    $.ajax({
                        url:'/document/saveDoc',
                        type:'post',
                        dataType:'json',
                        data:{
                            title:'',
                            dispatchType:'',
                            flowId:urlid,
                            documentType:0,
                            fflowId:urlid,
                            frunId:'',
                            fprcsId:1,
                            fflowStep:1,
                            frunName:'',
                        },
                        async: false,//同步请求,这里使用ajax必须使用同步方式请求，因为浏览器认为这种打开在ajax后新页面是不安全的
                        success:function(json){
                            if(json.flag){
                                $.popWindow('/workflow/work/workform?&flowId='+json.object.flowId+'&flowStep=1&tableName=document&tabId='+json.object.id+'&runId='+json.object.runId+'&prcsId=1&isNomalType=false')
                            }else {
                                $.layerMsg({content:json.msg,icon:2});
                            }
                        }
                    });
                }else{
                    layer.open({
                        title:new1+flowName,
                        content:'<div style="margin-top: 10px;">' +
                            '<p>' +
                            '<label style="display: inline-block;width: 150px;font-family: 微软雅黑E\\8F6F\\96C5\\9ED1,Tahoma,Verdana!important;vertical-align: middle;height: 30px;line-height: 30px;text-align: right;">'+titleFawen+' :</label>' +
                            '<input type="text" id="runName" value="'+runName+'" style="border-color: #ccc;width:270px;margin-left: 10px;vertical-align: middle" name="nametitle">' +
                            '</p>' +
                            '<p style="margin-top: 25px;" class="fillGong">' +
                            '<label style="display: inline-block;width: 150px;font-family: 微软雅黑E\\8F6F\\96C5\\9ED1,Tahoma,Verdana!important;vertical-align: middle;height: 30px;line-height: 30px;text-align: right;">'+gongwenZhong+' :</label>' +
                            '<select  style="border-color: #ccc;width:270px;margin-left: 10px;vertical-align: middle" name="dispatchType">' +
                            '<option value="">'+fillGong+'</option>' +
                            '</select>' +
                            '</p>' +
                            '<p style="margin-top: 25px; display: none" class="sys_rule">' +
                            '<label style="display: inline-block;width: 150px;font-family: 微软雅黑E\\8F6F\\96C5\\9ED1,Tahoma,Verdana!important;vertical-align: middle;height: 30px;line-height: 30px;text-align: right;">编号类型:</label>' +
                            '<select  style="border-color: #ccc;width:270px;margin-left: 10px;vertical-align: middle" name="sysRuleId">' +
                            '<option value="">请选择编号类型(可不填写)</option>' +
                            '</select>' +
                            '</p>' +
                            '<div class="liucheng2"><img src="../../img/workflow/work/add_work/speak.png" alt="" style="margin-right: 10px"><span>流程说明</span></div>'+
                            '</div>',
                        btn:[sure,cancel],
                        area:['600px','350px'],
                        yes:function (index) {
                            if($('[name="nametitle"]').val() != ''){
                                var loadindex = layer.load();
                                var sysRuleId = $('[name="sysRuleId"]').val() ? parseInt($('[name="sysRuleId"]').val()) : 0;
                                $.ajax({
                                    url:'/document/saveDoc',
                                    type:'post',
                                    dataType:'json',
                                    data:{
                                        title:$('[name="nametitle"]').val(),
                                        flowId:urlid,
                                        documentType:0,
                                        dispatchType:$('[name="dispatchType"]').val(),
                                        fflowId:urlid,
                                        frunId:'',
                                        fprcsId:1,
                                        fflowStep:1,
                                        frunName:$('[name="nametitle"]').val(),
                                        sysRuleId: sysRuleId
                                    },
                                    async: false,//同步请求,这里使用ajax必须使用同步方式请求，因为浏览器认为这种打开在ajax后新页面是不安全的
                                    success:function(json){
                                        layer.close(loadindex);
                                        if(json.flag){
                                            $.layerMsg({content:save,icon:1},function () {
                                            });
                                            $.popWindow('/workflow/work/workform?&flowId='+json.object.flowId+'&flowStep=1&tableName=document&tabId='+json.object.id+'&runId='+json.object.runId+'&prcsId=1&isNomalType=false')
                                        }else {
                                            $.layerMsg({content:json.msg,icon:2});
                                        }
                                    }
                                });
                            }else{
                                $.layerMsg({content:'发文标题不可为空！',icon:2});
                            }

                        },
                        success:function () {
                            var runNames=document.getElementById('runName');
                            runNames.focus();
                            $.get('/syspara/selectProjectId',function (res) {
                                if(res.object=='dazu'){
                                    $('.fillGong').hide()
                                }
                            });
                            $.get('/code/GetDropDownBox',{CodeNos:'GWTYPE'},function (json) {
                                var arrTwo=json.GWTYPE;
                                var str='<option value="">'+fillGong+'</option>'
                                for(var i=0;i<arrTwo.length;i++){
                                    str+='<option value="'+arrTwo[i].codeNo+'">'+arrTwo[i].codeName+'</option>'
                                }
                                $('[name="dispatchType"]').html(str)
                            },'json');

                            $.get('/flow/selectAllFlow', {flowId: urlid}, function(res){
                                if (res.flag && res.object.sysRuleYn == 1) {
                                    $('.sys_rule').show();
                                    $.get('/document/getRuleAll2', function(res){
                                        if (res.flag) {
                                            var str = '';
                                            res.obj.forEach(function(code){
                                                str += '<option value="'+code.id+'">'+code.expression+'</option>'
                                            });
                                            $('[name="sysRuleId"]').append(str);
                                        }
                                    });
                                } else {
                                    $('.sys_rule').hide();
                                }
                            });

                        }
                    })
                }
            });
        })


    })
    //点击流程说明
    $(document).on('click','.liucheng2',function(){
       /* var flowId=$(this).parents('.sort_new').attr('tid');
        var formId=$(this).parents('.sort_new').attr('formid');
        var word=$(this).parent().siblings('.rig_left').find('h1').text();*/
        $.popWindow("/workflow/work/processSpeak?flowId="+flowId+'&formId='+formId,'流程说明','0','0','1150px','700px');
    })
})