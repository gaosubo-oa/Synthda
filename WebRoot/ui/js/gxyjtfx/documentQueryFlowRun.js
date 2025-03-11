/**
 * Created by 骆鹏 on 2017/7/26.
 */
var search = null;
var huiqian = '';
var zhuban = '';
function jumpOpenType(flowId,type,e) {

    e.parents('tr').find('.editAndDelete0').click();
    // window.open('/flowSetting/processDesignToolsT?flowId='+flowId+'&type='+type);
}
function jumpOpenName(e,flowId,step,runId,realPrcsId,tableName,tabId) {
    if(step == undefined){
        step = '';
    }
    if(realPrcsId == undefined){
        realPrcsId = '';
    }
    if($(e).parents('tr').find('.editAndDelete0').length > 0&&$(e).parents('tr').find('.editAndDelete0').attr('data-i') != undefined&&
        pageObj.arrs[$(e).parents('tr').find('.editAndDelete0').attr('data-i')] != undefined&&
        pageObj.arrs[$(e).parents('tr').find('.editAndDelete0').attr('data-i')].sortMainType != ''){
        var sortMainType = '';
    }else{
        var sortMainType = '';
    }
    if($(e).attr('tableName')=='BUDGETTYPE'){
        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
            window.open('/workflow/work/workformh5PreView?flowId='+flowId+'&flowStep='+step+'&runId='+runId+'&tableName=budget&prcsId='+realPrcsId);
        } else if (/(Android)/i.test(navigator.userAgent)) {
            window.open('/workflow/work/workformh5PreView?flowId='+flowId+'&flowStep='+step+'&runId='+runId+'&tableName=budget&prcsId='+realPrcsId);
        }else{
            window.open('/workflow/work/workformPreView?flowId='+flowId+'&flowStep='+step+'&runId='+runId+'&tableName=budget&prcsId='+realPrcsId);
        }
    }else{
        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
            window.location.href = '/workflow/work/workformh5PreView?flowId='+flowId+'&flowStep='+step+'&runId='+runId+'&prcsId='+realPrcsId+'&tableName=document&tabId='+tabId+'&isNomalType=false'
            // window.open('/workflow/work/workformh5PreView?flowId='+flowId+'&flowStep='+step+'&runId='+runId+'&prcsId='+realPrcsId);
        } else if (/(Android)/i.test(navigator.userAgent)) {
            window.open('/workflow/work/workformh5PreView?flowId='+flowId+'&flowStep='+step+'&runId='+runId+'&prcsId='+realPrcsId+'&tableName=document&tabId='+tabId+'&isNomalType=false');
        }else{
            window.open('/workflow/work/workformPreView?flowId='+flowId+'&flowStep='+step+'&runId='+runId+'&prcsId='+realPrcsId+'&tableName=document&tabId='+tabId+'&isNomalType=false');
        }
    }

}
function getCookie(name)
{
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
    if(arr=document.cookie.match(reg))
        return unescape(arr[2]);
    else
        return null;
}

var oHead = document.getElementsByTagName('HEAD').item(0);
var oScript= document.createElement("script");
var type = getCookie("language");
oScript.type = "text/javascript";

if(type){
    oScript.src="/js/Internationalization/"+type+".js";
}else{
    oScript.src="/js/Internationalization/zh_CN.js";
}
window.onresize = function(){
    if (!IsCustomFlow) {
        var screenwidth = document.documentElement.clientWidth;
        if (screenwidth > 1396) {
            var nums = screenwidth * 0.97;
            var sumwidth = screenwidth * 0.97 + 'px';
        } else {
            var nums = 1355;
            var sumwidth = '1355px';
        }
        pageObj.configuration[0]['width'] = nums * 0.0222 + 'px';
        pageObj.configuration[1]['width'] = nums * 0.0664 + 'px';
        pageObj.configuration[2]['width'] = nums * 0.1107 + 'px';
        pageObj.configuration[3]['width'] = nums * 0.2066 + 'px';
        pageObj.configuration[4]['width'] = nums * 0.0849 + 'px';
        pageObj.configuration[5]['width'] = nums * 0.1144 + 'px';
        pageObj.configuration[6]['width'] = nums * 0.1476 + 'px';
        pageObj.configuration[7]['width'] = nums * 0.0480 + 'px';
        pageObj.configuration[8]['width'] = nums * 0.1993 + 'px';
        $('.page-top-outer-layer').css('width', sumwidth).find('table').css('width', sumwidth);
        for (var i = 0; i < $('.page-top-outer-layer').find('th').length; i++) {
            $('.page-top-outer-layer').find('th').eq(i).css('width', pageObj.configuration[i]['width']);
        }
        $('.page-bottom-outer-layer').css('width', sumwidth).find('.page-bottom-inner-layer').css('width', sumwidth).find('table').css('width', sumwidth);
        var table = $('.page-bottom-outer-layer .page-bottom-inner-layer table');
        for (var i = 0; i < table.find('tr').length; i++) {
            for (var j = 0; j < table.find('tr').eq(i).find('td').length; j++) {
                table.find('tr').eq(i).find('td').eq(j).css('width', pageObj.configuration[j]['width']);
            }
        }
    }
};

var pageObj;

$.getScript(oScript.src,function(){
    var eventas;
    if (!IsCustomFlow) {
        if ((( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent))) {
            
        }else{
            pageObj = initTable()
        }

        $('#pageTbody').on('mouseover', '.divShow', function () {
            $(this).find('.operationDiv').show();
        })
        $('#pageTbody').on('mouseout', '.divShow', function () {
            $(this).find('.operationDiv').hide();
        })

        //流程图
        $(document).on('click', '.editAndDelete0', function () {
            search = $(this);
            var obj = pageObj.arrs[$(this).attr('data-i')]
            eventas = $(this).parent().parent().find('.wenhao');
            var rilwId = obj.runId ? obj.runId : obj.run_id;
            window.open('/flowSetting/processDesignToolTwo?flowId=' + obj.flowId + '&rilwId=' + rilwId);
        })
        // 预览
        $(document).on('click', '.yulan', function () {
            var url = $(this).attr('data-url');
            pdurl($.UrlGetRequest('?' + url), url);
        })
        //结束
        $(document).on('click', '.editAndDelete1', function () {
            var obj = pageObj.arrs[$(this).attr('data-i')]
            //询问框
            layer.confirm(com, {
                btn: [sure, cancel],//按钮
            }, function () {
                $.ajax({
                    type: 'post',
                    data: {
                        runId: obj.runId,
                        flag: 2,
                        prcsId: obj.prcsId,
                        userId: obj.userId,
                        flowPrcs: obj.flowPrcs,
                        prcsFlag: obj.prcsFlag
                    },
                    url: '/workflow/work/updateState',
                    dataType: 'json',
                    success: function (res) {
                        if (res.code == '100066'){
                            $.layerMsg({content: '进入删除审批，审批通过后删除', icon: 4});
                            pageObj.init();
                        } else if (res.flag) {
                            $.layerMsg({content: chegon, icon: 1});
                            pageObj.init();
                        } else {
                            $.layerMsg({content: shib, icon: 2});
                        }

                    }
                })
            }, function () {
                layer.closeAll();
            })
        })
        //催办
        $(document).on('click', '.editAndDelete2', function () {
            var obj = pageObj.arrs[$(this).attr('data-i')]
            layer.open({
                type: 1,
                offset: '80px',
                area: ['800px', '300px'],
                // closeBtn: 0,
                title: [cui, 'background-color:#f3f3f3;color:#333'],
                btn: [sure, cancel],
                content: '<div class="content" style="width:98%;margin:0 auto">' +
                    '<div class="heade" style="margin-top:20px;font-size:16px;border-radius: 4px">' + inputContent + '：</div>' +
                    '<textarea name="" id="urgeCon" style="width:100%;height:85px;border-radius: 4px; margin-top: 20px;"></textarea>' +
                    '<span>手机短信提醒：</span><input type="checkbox" value="2" class="smsRemind" name="smsRemind"/>'+
                    '</div>',
                yes: function () {
                    $.ajax({
                        type: 'post',
                        data: {
                            id: obj.id,
                            userId: obj.userId,
                            flowPrcs: obj.flowPrcs,
                            runId: obj.runId,
                            runName: obj.runName,
                            flowId: obj.flowId,
                            prcsId: obj.prcsId,
                            smsContent: $("#urgeCon").val(),
                            smsRemind:$('input[name=smsRemind]:checked').val()
                        },
                        url: '/workflow/work/reminders',
                        dataType: 'json',
                        success: function (res) {
                            if (res.flag) {
                                if (res.obj1 == 1 && res.obj1 != undefined) {
                                    $.layerMsg({content: '您已催办过，请勿重复点击', icon: 6})
                                    return false;
                                } else {
                                    $.layerMsg({content: cuibanC, icon: 1});
                                    pageObj.init();
                                    layer.closeAll();
                                }
                            } else {
                                $.layerMsg({content: cuibanS, icon: 2});
                            }

                        }
                    })
                },
                btn2: function () {

                },
                success: function () {
                    //流程请尽快办理，流水号：xxxx，张三请假xxx
                    $("#urgeCon").val(jinkbl + "，" +liushui +"："+ obj.runId + "，"+ obj.runName);
                    //$("#urgeCon").val(tixing + ":" + obj.runId + "，" + flowName + ":" + obj.runName + deWork);
                }
            })
        })
        //删除
        $(document).on('click', '.editAndDelete3', function () {
            var obj = pageObj.arrs[$(this).attr('data-i')];
            //询问框
            layer.confirm(qued, {
                btn: [sure, cancel],//按钮
            }, function () {
                $.ajax({
                    type: 'post',
                    data: {
                        runId: obj.runId ? obj.runId : obj.run_id,
                        flag: 1
                    },
                    url: '/workflow/work/updateState',
                    dataType: 'json',
                    success: function (res) {
                        if (res.code == '100066'){
                            $.layerMsg({content: '进入删除审批，审批通过后删除', icon: 4});
                            pageObj.init();
                        } else if (res.flag) {
                            $.layerMsg({content: delc, icon: 1});
                            pageObj.init();
                        } else {
                            $.layerMsg({content: delf, icon: 2});
                        }

                    }
                })
            }, function () {
                layer.closeAll();
            });
        })
        //恢复执行
        $(document).on('click', '.editAndDelete4', function () {
            var obj = pageObj.arrs[$(this).attr('data-i')]
            //询问框
            layer.confirm(sureHandle, {
                btn: [sure, cancel],//按钮
            }, function () {
                $.ajax({
                    type: 'post',
                    data: {
                        runId: obj.runId ? obj.runId : obj.run_id,
                        id: obj.id
                    },
                    url: '/workflow/work/resumeExe',
                    dataType: 'json',
                    success: function (res) {
                        if (res.flag) {
                            $.layerMsg({content: returnC, icon: 1});
                            pageObj.init();
                        } else {
                            $.layerMsg({content: returnS, icon: 2});
                        }

                    }
                })
            }, function () {
                layer.closeAll();
            })
        })
        //编辑
        $(document).on('click', '.editAndDelete5', function () {
            var obj = pageObj.arrs[$(this).attr('data-i')]
            window.open('/workflow/work/workformedit?opflag=1&flowId=' + obj.flowId + '&prcsId=&flowStep=&runId=' + obj.runId);
        })
        //传阅
        $(document).on('click', '.editAndDelete6', function () {
            var obj = pageObj.arrs[$(this).attr('data-i')]
            // console.log(obj)
            var lockded = false;
            layer.open({
                type: 1
                , area: ['600px', '250px']
                , title: '传阅'
                , content: '<div style="margin-top: 20px;"  >' +
                    '<div style="display: flex;margin-left: 45px;margin-top: 45px;" >\n' +
                    '    <label  style="width:70px;padding: 9px 0px;">请选择人员:</label>\n' +
                    '    <div  >\n' +
                    '      <textarea  type="text" name="userIds"  id="userIdPeople" user_id="" disabled style="height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                    '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="userIdAdd">添加</a>\n' +
                    ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="userIdDel">清空</a>\n' +
                    ' </div>\n' +
                    '  </div>\n' +
                    '</div>'
                , btn: ['确定', '取消']
                , success: function (layero, index) {
                    //人员的添加
                    $(".userIdAdd").on("click", function () {
                        user_id = 'userIdPeople';
                        $.popWindow("/common/selectUser");
                    });
                    //人员的删除
                    $('.userIdDel').click(function () {
                        $('#userIdPeople').attr("dataid", "");
                        $('#userIdPeople').attr("user_id", "");
                        $('#userIdPeople').val("");
                    });
                }
                , yes: function (index, layero) {
                    var flowId = obj.flowId
                    /*var prcsId = obj.flowPrcs
                    var flowStep = obj.prcsId*/
                    var prcsId = obj.prcsId
                    var flowStep = obj.flowPrcs
                    var runId = obj.runId
                    var runName = obj.runName
                    if (flowId == undefined) {
                        flowId = ''
                    }
                    if (prcsId == undefined) {
                        prcsId = ''
                    }
                    if (flowStep == undefined) {
                        flowStep = ''
                    }
                    if (runId == undefined) {
                        runId = ''
                    }
                    if (runName == undefined) {
                        runName = ''
                    }

                    if (!lockded) {
                        lockded = true;
                        $.ajax({
                            url: '/workflow/work/Circulate',
                            type: "post",
                            dataType: "json",
                            data: {
                                viewUser: $('#userIdPeople').attr('user_id'),
                                flowId: flowId,
                                prcsId: prcsId,
                                flowStep: flowStep,
                                runId: runId,
                                runName: runName
                            },
                            success: function (res) {

                                if (res.flag) {
                                    layer.msg('传阅成功！', {icon: 1, time: 2000}, function () {
                                        layer.close(index)
                                    });
                                }else{
                                    lockded = false;
                                }
                            }
                        })
                    }

                }
            });
        })
        // 收藏
        $(document).on('click', '.editAndDelete7', function () {
            var obj = pageObj.arrs[$(this).attr('data-i')];
            var runId = obj.runId;
            $('#favoriteRunId').val(runId)
            layer.open({
                title: CollectionDocument
                ,type: 1
                ,maxmin:true
                ,area: ['500px', '250px']
                ,content: $('#bounced')
                ,btn: [collection, cancel]
                ,success: function(){
                    var load = layer.load();
                    $.ajax({
                        type: "get",
                        url: "/flowFavorite/selectFavorite?pageSzie=1000&page=1",
                        dataType: 'json',
                        success: function (data) {
                            if(data.flag){
                                var json = data.data;
                                var option = '<option value="">ds</option>';
                                for(var i = 0; i< json.length; i++){
                                    option += '<option value="'+ json[i].favoriteId +'">'+ json[i].favoriteName +'</option>'
                                }
                                $('#favoriteId').html(option)
                            }
                            layer.close(load);
                        }
                        ,error: function(err){
                            layer.close(load);
                        }
                    })
                }
                , yes: function (index, layero) {
                    var favoriteId = $('#favoriteId').val()||'';
                    if(favoriteId != ''){
                        var load = layer.load();
                        $.ajax({
                            type: "get",
                            url: "/flowFavorite/addFavoriteFlow",
                            data: {
                                favoriteId: favoriteId,
                                runId: $('#favoriteRunId').val()||''
                            },
                            dataType: 'json',
                            success: function (data) {
                                if(data.flag){
                                    layer.msg('收藏成功！', { icon: 1, time: 2500 }, function(){
                                        layer.closeAll();
                                    })
                                }else{
                                    layer.msg('收藏失败！', { icon: 2, time: 2500 })
                                }

                            }
                            ,error: function(err){
                                layer.msg('收藏失败！', { icon: 2, time: 2500 })
                            }
                        })
                    }else{
                        layer.msg('请选择收藏目录！', { icon: 7, time: 2500 })
                    }
                }
            })
        })
        //流程分类递归
        function queryChild_flow(datas, str_li, level) {
            for (var i = 0; i < datas.length; i++) {
                var className = "levelleft" + level;
                if (datas[i].sortName == '未定义') {
                    str_li += '<option value="' + datas[i].sortNo + '">' + datas[i].sortName + '</option>'
                } else {
                    str_li += '<option value="' + datas[i].sortNo + '">' + datas[i].sortName + '</option>'
                }
                if (datas[i].childs != null) {
                    str_li = queryChild_flow(datas[i].childs, str_li, level + 1);
                }
            }
            return str_li;
        }

        $(".queryBtn").click(function () {
            if ((( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent))) {
                chaxun();
                return false;
            }
            console.log(pageObj.data)
            pageObj.data = {beginDate: "",
                endDate: "",
                flowId: "191",
                page: 1,
                pageSize: 15,
                runId: "",
                runName: "",
                state: "",
                status: "",
                useFlag: true,
                userId: "admin",
                workLevel: "",
                sortMainType :'DOCUMENTTYPE'
            }
            if ($("#status").val() == 5 || $("#status").val() == 6) {
                pageObj.data.userId = $('[name="userId"]').attr("user_Id");
            } else {
                pageObj.data.userId = $.cookie("userId");
            }
            if ($('[name="flowName"]').val() == "") {
                $('[name="flowName"]').attr('dataType', '0')
            }
            var relation_2 = $('.tabText').attr('relation_2')
            if(relation_2 != undefined && $('.tabText').val() != ''){
                var relationArr = relation_2.split('&')
                for(let k=0;k<relationArr.length;k++){
                    let relationArr0 = relationArr[k].split('=')
                    let pageObjArr = relationArr0[0]
                    pageObj.data[pageObjArr] = relationArr0[1]
                }
            }
            pageObj.data.flowId = $('[name="flowId"]').val();
            pageObj.data.runId = $('[name="runId"]').val();
            pageObj.data.runName = $('[name="runName"]').val();
            pageObj.data.state = $('[name="status"]').val();
            pageObj.data.workLevel = $('[name="status2"]').val();
            pageObj.data.status = $('[name="status1"]').val();
            pageObj.data.beginDate = $('[name="beginDate"]').val();
            pageObj.data.endDate = $('[name="endDate"]').val();
            pageObj.data.beginUser = $('[name="userId0"]').attr('user_id').split(',')[0];
            pageObj.data.page = 1;
            pageObj.init();
        })

        //点击表单查询
        $(".tabQue").click(function () {
            var FLOW_ID = $('[name="flowName"]').attr('dataType')
            if(FLOW_ID == 0){
                layer.msg('请先选择流程!', {icon: 2});
            }else {
                searchFormData(FLOW_ID)
            }

        })

        $("#export").click(function () {//导出
            var $this = $('#pageTbody input[type="checkbox"]:checked');
            var length = $('#pageTbody input[type="checkbox"]:checked').length;
            if (length != 0) {
                var runIds = '';
                for (var i = 0; i < length; i++) {
                    if (i == length - 1) {
                        runIds += $this.eq(i).attr('runid');
                    } else {
                        runIds += $this.eq(i).attr('runid') + ',';
                    }
                }
                window.location.href = '/flowRun/exportFlowRunBatch?runIds=' + runIds;
            } else {
                layer.msg('请选择至少一条流程!', {icon: 2});
            }

        })

        $('#allexport').click(function () {//全部导出
            var userId = '';
            if ($("#status").val() == 5 || $("#status").val() == 6) {
                userId = $('[name="userId"]').attr("user_Id");
            } else {
                userId = $.cookie("userId");
            }
            if ($('[name="flowName"]').val() == "") {
                $('[name="flowName"]').attr('dataType', '0')
            }
            var length = $('#pageTbody input[type="checkbox"]').length;
            window.location.href = '../../flowRun/queryFlowRun?sortMainType=DOCUMENTTYPE&output=2&userId=' + userId +
                '&flowId=' + $('[name="flowId"]').val() + '&runId=' + $('[name="runId"]').val() + '&runName=' + $('[name="runName"]').val() +
                '&state=' + $('[name="status"]').val() + '&workLevel=' + $('[name="status2"]').val() + '&status=' + $('[name="status1"]').val()
                + '&beginDate=' + $('[name="beginDate"]').val() + '&endDate=' + $('[name="endDate"]').val();

        })

        $("#end").click(function () {
            var runIds = "";
            var prcsIds = "";
            var userIds = "";
            var flowPrcss = "";
            var prcsFlags = "";
            $('input:checkbox[name=id]:checked').each(function (i) {
                if (0 == i) {
                    runIds = $(this).attr("id");
                    prcsIds = $(this).attr("prcsid");
                    userIds = $(this).attr("userid");
                    flowPrcss = $(this).attr("flowprcs");
                    prcsFlags = $(this).attr("prcsflag");
                } else {
                    runIds += ("," + $(this).attr("id"));
                    prcsIds += ("," + $(this).attr("prcsid"));
                    userIds += ("," + $(this).attr("userid"));
                    flowPrcss += ("," + $(this).attr("flowprcs"));
                    prcsFlags += ("," + $(this).attr("prcsflag"));
                }
            });
            if (runIds == '') {
                $.layerMsg({content: xuanzeEnd, icon: 2});
            }
            layer.confirm(com, {
                title: xinxiM,
                btn: [sure, cancel],//按钮
            }, function () {
                $.ajax({
                    type: 'post',
                    data: {
                        runId: runIds,
                        flag: 2,
                        prcsId: prcsIds,
                        userId: userIds,
                        flowPrcs: flowPrcss,
                        prcsFlag: prcsFlags
                    },
                    url: '/workflow/work/updateState',
                    dataType: 'json',
                    success: function (res) {
                        if (res.code == '100066'){
                            $.layerMsg({content: '进入删除审批，审批通过后删除', icon: 4});
                            pageObj.init();
                        } else if (res.flag) {
                            $.layerMsg({content: chegon, icon: 1});
                            pageObj.init();
                        } else {
                            $.layerMsg({content: shib, icon: 2});
                        }
                    }
                })
            }, function () {
                layer.closeAll();
            })

        })
    } else {
        // 主办或会签
        $(document).on('click', '.editAndDelete0', function () {
            var obj = pageObj.arrs[$(this).attr('data-i')];
            if (obj.OP_FLAG == 1) {
                huiqian = 'zhuban';
            } else {
                huiqian = 'huiqian';
            }

            window.open('/workflow/work/workform?opflag=' + obj.OP_FLAG + '&flowId=' + FLOW_ID + '&prcsId=' + obj.FLOW_PRCS + '&flowStep=' + obj.PRCS_ID
                + '&runId=' + obj.run_id);

        })
        // 删除
        $(document).on('click', '.editAndDelete1', function () {
            //询问框
            var obj = pageObj.arrs[$(this).attr('data-i')]
            var tid = obj.id;
            //删除判断
            layer.confirm('确认删除？', {
                btn: ['确定', '取消'] //按钮
            }, function () {
                //确定删除，调接口
                $.ajax({
                    url: '../../workflow/work/deleteRunPrcs',
                    type: 'get',
                    dataType: 'json',
                    data: {
                        id: tid
                    },
                    success: function (obj) {
                        if (obj.code == '100066'){
                            layer.msg('进入删除审批，审批通过后删除', {icon: 4});
                        } else {
                            //第三方扩展皮肤
                            layer.msg('删除成功！', {icon: 6});
                        }
                        location.reload();
                    }
                })
            }, function () {
                layer.closeAll();

            });
        })
    }

    //全选
    $('#pagediv').on('click', '[name="all"]', function () {
        if ($(this).is(':checked')) {
            $('#pageTbody').find('.canDelete[type=checkbox]').prop('checked', true)
        } else {
            $('#pageTbody').find('.canDelete[type=checkbox]').removeProp('checked')
        }
    })
    //打印全选
    $('#pagediv').on('click', '[name="allPrint"]', function () {
        if ($(this).is(':checked')) {
            $('#pageTbody').find('.id[type=checkbox]').prop('checked', true)
        } else {
            $('#pageTbody').find('.id[type=checkbox]').removeProp('checked')
        }
    })
});

function searchFormData(FLOW_ID){
    $.ajax({
        url:'/form/getForm?flowId='+FLOW_ID,
        data:{},
        type:'get',
        dataType:'json',
        success:function(res){
            var SCRIPT_REGEX = /<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi;
            var html1 = res.obj.printModel;
            //过滤script
            var html = html1.replace(SCRIPT_REGEX, "")
            $('.hideenHTML').html(html);
            var arr = [];
            var $form_item = $('.hideenHTML').find(' .form_item');
            var length = $form_item.length;
            var str = '';
            var str1 = '';
            var xmacro = 'xmacro';

            if( $('.tabText').val() != ''){
                var relation_2 = $('.tabText').attr('relation_2')
                var relationArr = relation_2.split('&')
                var arr1 = []
                for(let k=0;k<relationArr.length;k++){
                    let relationArr0 = relationArr[k].split('=')
                    let pageObjArr = relationArr0[0]
                    // pageObj.data[pageObjArr] = relationArr0[1]
                    var object1 = {
                        'key':pageObjArr,
                        'value':relationArr0[1]
                    }
                    arr1.push(object1);
                }
                console.log(arr1)
            }


            for(var i=0;i<length;i++){
                var name = $form_item.eq(i).attr('name');
                var title = $form_item.eq(i).attr('title');
                var nameNum = name.split('DATA_')[1];
                str += '<option value="frd.'+ name +'">['+ title +']</option>';
                str1 += ' <p jsonArr="'+jsonArr+'" style="    margin: 10px 0;">'+
                    '<span nowrap="" class="TableData" style="text-indent: 15px;width: '+function(){
                        if ((( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent))) {
                            return '34%'
                        }else{
                            return '20%'
                        }
                    }()+'"><label for="relation_'+ nameNum +'">['+ nameNum +'] '+ title +'：</label></span>'+
                    '<span nowrap=""  >'+
                    '<select style="width:24%;height:30px;" id="relation_20" name="relation_'+ nameNum +'" class="form-control" >'+
                    '<option value="1">等于</option>'+
                    '<option value="6">不等于</option>'+
                    '<option value="7">开始为</option>'+
                    '<option value="8" selected="">包含</option>'+
                    '<option value="9">结束为</option>'+
                    '<option value="10">为空</option>'+
                    '</select>&nbsp;'+
                    '<input style="width:'+function(){
                        if ((( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent))) {
                            return '35%'
                        }else{
                            return '40%'
                        }
                    }()+';height: 28px" id="DATA_'+ nameNum +'" name="DATA_'+ nameNum +'" type="text" size="30" class="form-control">'+
                    '</span>'+
                    '</p>';
                var object = {
                    'key':name,
                    'value':title
                };

            };

            //判断浏览器大小方法
            function screen() {
                //获取当前窗口的宽度
                var width = $(window).width();
                if (width > 1200) {
                    return 3;   //大屏幕
                } else if (width > 992) {
                    return 2;   //中屏幕
                } else if (width > 768) {
                    return 1;   //小屏幕
                } else {
                    return 0;   //超小屏幕
                }
            }
            layer.open({
                type: 1,
                offset: screen() < 2 ? ['15%', '5%']: '80px',
                area: screen() < 2 ? ['90%', '70%'] : ['50%', '70%'],
                // closeBtn: 0,
                title: ['表单字段条件', 'background-color:#f3f3f3;color:#333'],
                btn: [sure, cancel],
                content: '<form method="post" id="form1" name="form1" role="form" class="form-inline" enctype="multipart/form-data">' +
                    '<div style="margin-top: 10px">'+str1+'</div></form>',
                success:function(res){
                    if( $('.tabText').val() != ''){
                        var data = arr1;
                        if(null!=data){
                            var dataJson = data;
                            for(var key in dataJson){
                                $("[name='"+dataJson[key].key+"']").val(dataJson[key].value);
                            }
                        }
                    }

                },
                yes: function () {
                    var arrtext1 = $('#form1').serialize()
                    var arrtext = decodeURIComponent(arrtext1,true)
                    var relationArr = arrtext.split('&')
                    var relationArr2 = []
                    var relationArr3 = []
                    for(var c=0;c<relationArr.length;c++){
                        if(c%2 != 0){
                            relationArr2.push(relationArr[c])
                        }else{
                            relationArr3.push(relationArr[c])
                        }
                    }
                    var arr2 = []
                    var arr3 = []
                    for (var j=0;j<length;j++){
                        var name = $form_item.eq(j).attr('name');
                        var title = $form_item.eq(j).attr('title');
                        let relationArr0 = relationArr2[j].split('=')
                        let pageObjArr = relationArr0[0]
                        let relationArr1 = relationArr3[j].split('=')
                        let pageObjArr2 = relationArr1[0]
                        if(relationArr0[1] != ''){
                            var object3 = {
                                'key':title,
                                'value':relationArr0[1]
                            };
                            arr2.push(object3)
                            var object4 = {
                                'key':name,
                                'value':relationArr0[1]
                            };
                            var object5 = {
                                'key':pageObjArr2,
                                'value':relationArr1[1]
                            };
                            arr3.push(object4)
                            arr3.push(object5)
                        }
                    }
                    var arrStr = ''
                    for(var a = 0;a<arr2.length;a++){
                        arrStr += arr2[a].key+':'+arr2[a].value +'  '
                    }
                    var arrtext = ''
                    for(var b = 0;b<arr3.length;b++){
                        arrtext += arr3[b].key+'='+arr3[b].value+'&'
                    }
                    $('.tabText').attr('relation_2',arrtext)
                    // $('.tabText').val(arrtext)
                    $('.tabText').val(arrStr)
                    layer.closeAll();
                }
            })

        }
    })
}
function jsonArr(arr){
    var arr = arr
    var data = arr;
    if(null!=data){
        var dataJson = data;
        for(var key in dataJson){
            $("#"+key+"").val(dataJson[key]);
        }
    }

}
function hide_item(data,text) {
}

function getWorkLevle(num_workLevel){
    var str_workLevel;
    switch(num_workLevel){
        case 0:
            str_workLevel=ordinary;
            break;
        case 2:
            str_workLevel=ThereIs;
            break;
        case 1:
            str_workLevel=emergency;
            break;
        default:
            str_workLevel=ordinary;
    }
    return str_workLevel;
}

function initTable(tableHead){
    var tableObj = null;
    var screenwidth = document.documentElement.clientWidth;
    if (screenwidth > 1396) {
        var nums = screenwidth * 0.97;
        var sumwidth = screenwidth * 0.97 + 'px';
    } else {
        var nums = 1355;
        var sumwidth = '1355px';
    }
    if (!IsCustomFlow) {

        var width0 = nums * 0.0222 + 'px';
        var width1 = nums * 0.0664 + 'px';
        var width2 = nums * 0.1107 + 'px';
        var width3 = nums * 0.2066 + 'px';
        var width4 = nums * 0.0849 + 'px';
        var width5 = nums * 0.1144 + 'px';
        var width6 = nums * 0.1476 + 'px';
        var width7 = nums * 0.0480 + 'px';
        var width8 = nums * 0.1993 + 'px';
        tableObj = $.tablePage('#pagediv', sumwidth, [ // 1260
            {
                width: width0,
                title: '',
                name: 'checkbox',
                selectFun: function (runId, obj) {
                    var str = '';
                    // var str1 = ''
                    var disabled = '';
                    if (obj.manage == '1' || obj.all == '1') {
                        str = 'canDelete';
                    } else {
                        // disabled = 'disabled:"disabled" style="cursor: not-allowed;display: none;"';
                        disabled = 'disabled:"disabled" style="cursor: not-allowed;"';
                    }
                    return '<div style="padding-left: 10px; width: 70px;"><input type="checkbox" id="' + obj.runId + '" '+disabled+' name="checkbox" class="id ' + str + '" runId="' + obj.runId + '"/></div>';
                }
            },
            {
                width: width1,
                title: liushui,
                name: 'runId',
                selectFun: function (runId, obj) {
                    if (obj.endTime == undefined) {
                        return '<img class="headli1_2_icon" src="../../img/workflow/work/waitwork.png" alt="" style="margin-top: -3px">&nbsp;' + runId;
                    } else {
                        return '<img class="headli1_2_icon" src="../../img/workflow/work/endwork.png" alt="" style="margin-top: -3px">&nbsp;' + runId;
                    }
                }
            },
            {
                width: width2,
                title: documentName,
                name: 'flowName',
                selectFun: function (flowName, obj) {
                    return '<a class="wenhao" style="cursor: pointer;" onclick="jumpOpenType(' + obj.flowId + ',type=0,$(this))">' + flowName + '</a>';
                }
            },
            {

                width: width3,
                title: documentTitle,
                name: 'runName',
                selectFun: function (runName, obj) {
                    var workLeverl = getWorkLevle(obj.workLevel);
                    if(obj.workLevel == 0){
                        var fontcolor = 'green';
                    }else{
                        var fontcolor = 'red';
                    }
                    return '<a class="wenhao" style="cursor: pointer;" tableName="' + obj.sortMainType + '" onclick="jumpOpenName(this,' + obj.flowId + ',' + obj.flowPrcs + ',' + obj.runId + ',' + obj.prcsId + ','+obj.tableName+','+obj.tabId+')"><span class="font-green" style="color:'+ fontcolor +';">【'+workLeverl+'】</span>' + runName + '</a>';
                }
            },
            {
                width: width4,
                title: documentOriginator,
                name: 'userName',
            },
            {
                width: width5,
                title: stime,
                name: 'beginTime',
                selectFun: function (beginTime, obj) {
                    return beginTime.substring(0, beginTime.length - 2);
                }
            },
            {
                width: width6,
                title: file,
                name: 'attachmentName',
                selectFun: function (attachmentName, obj) {
                    if (attachmentName == '') {
                        return ''
                    } else {
                        var str = "";
                        // console.log(obj)
                        for (var i = 0; i < obj.list.length; i++) {
                            var v = obj.list[i];
                            var attachName = v.attachName;
                            var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                            var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                            var attachmentUrl = v.attUrl;
                            attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                            str += '<div class="divShow"><a href="javascript:;" style="    width: 20px;display: inline;">' + obj.list[i].attachName + '</a>' +
                                '<div class="operationDiv" style="display:none;">' + function () {
                                    if (fileExtension == 'pdf' || fileExtension == 'PDF' || fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg' || fileExtension == 'JPG' || fileExtension == 'txt' || fileExtension == 'TXT') { //判断是否需要查阅
                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="margin-left: 10px"><img src="/img/attachmentIcon/attachPreview.png" style="margin-right: 5px;" alt="">查阅</a>'
                                    } else {
                                        return '<a class="operation yulan"  href="javascript:void(0);" href="javascript:void(0);" attrurl="' + attachmentUrl + '" onclick="preview($(this))" style="margin-left: 10px"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">预览</a>'+
                                            '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="margin-left: 10px"><img src="/img/attachmentIcon/attachPreview.png" style="margin-right: 5px;" alt="">查阅</a>'
                                    }
                                }() +
                                '<a class="operation" style="margin-left: 10px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                + '</div>' +
                                '</div>'
                        }
                        return str;
                    }
                }
            },
            {
                width: width7,
                title: type1,
                name: 'endTime',
                selectFun: function (endTime, obj) {
                    if (obj.endTime == undefined) {
                        return '<span style="color: #37aa43;">' + handling + '</span>' //2b7fe0
                    } else {
                        return '<span style="color: red;">' + ends + '</span>'
                    }
                }
            },
            {

                width: width8,
                title: option

            }
        ], function (me) {
            me.data.pageSize = 15;
            if ($("#status").val() == 5 || $("#status").val() == 6) {
                me.data.userId = $('[name="userId"]').attr("user_Id");
            } else {
                me.data.userId = $.cookie("userId");
            }
            if ($('[name="flowName"]').val() == "") {
                $('[name="flowName"]').attr('dataType', '0')
            }
            var flowId = $.GetRequest().flowId;
            if(flowId){
                me.data.flowId = flowId;
            }else{
                me.data.flowId = $('[name="flowId"]').val();
            }
            me.data.runId = $('[name="runId"]').val();
            me.data.runName = $('[name="runName"]').val();
            me.data.state = $('[name="status"]').val();
            me.data.workLevel = $('[name="status2"]').val();
            me.data.status = $('[name="status1"]').val();
            me.data.beginDate = $('[name="beginDate"]').val();
            me.data.endDate = $('[name="endDate"]').val();
            me.data.sortMainType = 'DOCUMENTTYPE';
            me.data.sortDetailType='SENDNG'
            me.init('/gxyjtfx/flowRun/queryFlowRun', [{
                name: workflow, fn: function (obj) {
                    return 1;
                }
            }, {
                name: ending, fn: function (obj) {
                    if ((obj.all == '1' || obj.manage == '1') && obj.endTime == undefined) {
                        return 1;
                    } else {
                        return 0;
                    }
                }
            }, {
                name: cui, fn: function (obj) {
                    if (obj.all == '1' || obj.manage == '1' || obj.monitor == '1') {
                        if (obj.endTime != undefined) {
                            return 0;
                        } else {
                            return 1;
                        }
                    } else {
                        return 0;
                    }
                }
            }, {
                name: del, fn: function (obj) {
                    if (obj.all == '1' || obj.manage == '1') {
                        return 1;
                    } else {
                        return 0;
                    }
                }
            }, {
                name: handleRe, fn: function (obj) {
                    if ((obj.all == '1' || obj.manage == '1') && (obj.prcsFlag == 4 || obj.endTime != undefined)) {
                        return 1;
                    } else {
                        return 0;
                    }
                }
            }, {
                name: edit1, fn: function (obj) {
                    if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                        return 0;
                    } else if (/(Android)/i.test(navigator.userAgent)) {
                        return 0;
                    } else {
                        if ((obj.all == '1' || obj.edit == '1') && obj.endTime != undefined) {
                            return 1;
                        } else {
                            return 0;
                        }
                    }

                }
            },
            {
                name: circulated, fn: function (obj) {
                    if (obj.chuan == 1) {
                        return 1
                    } else {
                        return 0
                    }
                }
            },
            {
                name: collection, fn: function (obj) {
                    return 1
                }
            }
            ], function () {
                var str = '<tr>' +
                    '<td style="width: 30px;text-align: right"><input type="checkbox" name="all"></td>' +
                    '<td style="text-align: left"><span>delSelectAll</span></td>' +
                    // '<td colspan="8" style="text-align: left">' +
                    // '</td>' +
                    '<td style="width: 100px;line-height: 30px;"><input type="checkbox" name="allPrint" style="margin-top: -2px;"><span style="margin-left: 8px;">prtSelectAll</span></td>' +
                    '<td colspan="8" style="text-align: left">' +
                    '</td>' +
                    '</tr>'
                $('#operation').html(str)
            })
        })
    } else {
        var check = {
            width: '40px',
            title: '<div style="padding-left: 10px; width: 40px;"><input type="checkbox" name="all" id="selectAll" ischecked="false"></div>',
            name: 'id',
            selectFun: function (prcsId, obj) {
                if (obj.PRCS_ID == '1') {
                    return '<div style="padding-left: 10px; width: 40px;"><input type="checkbox" name="checkbox" id="' + obj.id + '" runId="' + obj.run_id + '" class="canDelete"></div>';
                } else {
                    return '<div style="padding-left: 10px; width: 40px;"><input type="checkbox" name="checkbox"  disabled></div>';
                }
            }
        }
        var tableRows = [];
        if (tableHead) {
            tableRows.push(check)
            tableHead.forEach(function (data) {
                var item = {title: data[0], name: data[1]}
                tableRows.push(item)
            })
            tableRows.push({width: width8, title: '操作'})
        }

        tableObj = $.tablePage('#pagediv', sumwidth, tableRows, function(me){
            // 获取查询条件
            var $input = $('.custom_search').find('[name]');
            console.log($input)
            var condition = '';
            $input.each(function(){
                var val = $(this).val().trim() || '';
                condition += $(this).attr('name') + '=' + val + ',';
            })
            me.data.pageSize = 10;
            me.data.useFlag = true;
            me.data.flowId = FLOW_ID;
            me.data.sortMainType = 'DOCUMENTTYPE';
            me.data.condition = condition;
            me.init('/flowRunPage/queryFlowRuns', [{
                name: '主办', fn: function (obj) {
                    if (obj.OP_FLAG == '0') {
                        return "<span style='display: inline-block;width:48px;height:24px;background: #0cae32;color:#fff;line-height:24px;border-radius:3px;text-align: center'><img src='/img/workflow/work/add_work/sign.png ' style='vertical-align:middle;margin-top: -2px;'/>编辑</span>";
                    } else {
                        return "<span style='display: inline-block;width:48px;height:24px;background: #0cae32;color:#fff;line-height:24px;border-radius:3px;text-align: center'><img src='/img/workflow/work/add_work/mainBan2.png ' style='vertical-align:middle;margin-top: -2px;'/>编辑</span>";
                    }
                }
            }, {
                name: '删除', fn: function (obj) {
                    if (obj.PRCS_ID == '1') {
                        return "<span style='display: inline-block;width:48px;height:24px;background: #ef4747;color:#fff;line-height:24px;border-radius:3px;text-align: center'><img src='/img/workflow/work/add_work/del.png ' style='vertical-align:middle;margin-top: -2px;'/>删除</span>";
                    } else {
                        return 0;
                    }
                }
            }], function () {
            })
        })
    }

    return tableObj
}

function clickeDelete() {
    var length = $('.canDelete[name=checkbox]:checked').length;
    var tid = '';
    for (var i = 0; i < length; i++) {
        var $this = $('.canDelete[name=checkbox]:checked').eq(i);
        // var obj = pageObj.arrs[$this.parents('tr').find('.editAndDelete1').attr('data-i')];
        tid += $this.attr('id') + ',';
    }
    if (length == 0) {
        layer.msg('请选择至少一条流程!', {icon: 2});
    } else {
        //删除判断
        layer.confirm('是否删除？', {
            btn: ['确定', '取消'] //按钮
        }, function () {
            //确定删除，调接口
            $.ajax({
                url: '../../workflow/work/deleteRunPrcsBatch',
                type: 'get',
                dataType: 'json',
                data: {
                    idBatch: tid
                },
                success: function (obj) {
                    if (obj.code == '100066'){
                        layer.msg('进入删除审批，审批通过后删除', {icon: 4});
                    } else {
                        //第三方扩展皮肤
                        layer.msg('删除成功！', {icon: 6});
                    }
                    location.reload();
                }
            })
        }, function () {
            layer.closeAll();

        });
    }
}

function newWorkFlow(cb){
    $.ajax({
        url:'../../workflow/work/workfastAdd',
        type:'get',
        dataType:'json',
        data:{
            flowId:FLOW_ID,
            prcsId : 1,
            flowStep : 1,
            runId:'',
            preView:0
        },
        async: false,//同步请求,这里使用ajax必须使用同步方式请求，因为浏览器认为这种打开在ajax后新页面是不安全的
        success:function(res){
            if(res.flag){
                var data = res.object;
                window.open('/workflow/work/workform?opflag=1&flowId=' + FLOW_ID + '&prcsId=1&flowStep=1&runId=' + data.flowRun.runId);
            }
        }
    });
}
