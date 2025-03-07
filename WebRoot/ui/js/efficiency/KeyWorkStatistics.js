/**
 * Created by 骆鹏 on 2017/7/26.
 */

function jumpOpenName(flowId,step,runId,realPrcsId) {
    if(step == undefined){
        step = '';
    }
    if(realPrcsId == undefined){
        realPrcsId = '';
    }
    if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
        window.open('/workflow/work/workformh5PreView?flowId='+flowId+'&flowStep='+step+'&runId='+runId+'&prcsId='+realPrcsId);
    } else if (/(Android)/i.test(navigator.userAgent)) {
        window.open('/workflow/work/workformh5PreView?flowId='+flowId+'&flowStep='+step+'&runId='+runId+'&prcsId='+realPrcsId);
    }else{
        window.open('/workflow/work/workformPreView?flowId='+flowId+'&flowStep='+step+'&runId='+runId+'&prcsId='+realPrcsId);
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

$.getScript(oScript.src,function(){
    $(document).on('click','.editAndDelete1',function () {//结束
        var obj=pageObj.arrs[$(this).attr('data-i')]
        //询问框
        layer.confirm(com, {
            btn: [sure,cancel ] ,//按钮
        }, function(){
            $.ajax({
                type:'post',
                data:{
                    runId:obj.runId,
                    flag:2,
                    prcsId:obj.prcsId,
                    userId:obj.userId,
                    flowPrcs:obj.flowPrcs,
                    prcsFlag:obj.prcsFlag
                },
                url:'/workflow/work/updateState',
                dataType:'json',
                success:function(res){
                    if (res.code == '100066'){
                        $.layerMsg({content: '进入删除审批，审批通过后删除', icon: 4});
                        pageObj.init();
                    } else if (res.flag) {
                        $.layerMsg({content: chegon, icon: 1});
                        pageObj.init();
                    } else {
                        $.layerMsg({content:shib, icon: 2});
                    }

                }
            })
        }, function() {
            layer.closeAll();
        })
    })

    // 查询类型：按人员/按部门
    // 按类型加载数据报表
    var searchType;

    //指定人员
    $('.addusers').click(function(){
        searchType='person';
        user_id="users";
        $.popWindow("../../common/selectUser");
    });

    //指定部门
    $('.adddemt').click(function(){
        searchType='department';
        dept_id="demt";
        $.popWindow("../../common/selectDept");
    });

    //        清空
    $('.clear').click(function () {
        $(this).siblings('textarea').val('');
        $(this).siblings('textarea').attr('user_id','');
        $(this).siblings('textarea').attr('username','');
        $(this).siblings('textarea').attr('dataid','');
        $(this).siblings('textarea').attr('userprivname','');
    });

    var exportData={
        userIds:"",
        deptIds:"",
        beginDate:"",
        endDate:"",
    }

    $(".queryBtn").click(function () {
        var types = $("input[name='types']:checked").val()
        if(types == 0){
            if($('#users').val() == ''){
                alert('请选择统计人员！');
                return false;
            }
        } else {
            if($('#demt').val() == ''){
                alert('请选择统计部门！');
                return false;
            }
        }
        $('.showbx').show();
        var pageObj;

        // if (searchType === 'person') {
            pageObj = $.tablePage('#pagediv', '100%', [ // 1260
                {
                    width: '11%',
                    title: '用户',
                    name: 'userName',
                },
                {
                    width: '11%',
                    title: '所在部门',
                    name: 'deptName',
                },
                {
                    width: '13%',
                    title: '参与工作数量',
                    name: 'count',
                    selectFun: function (count, obj) {
                        if (obj.count == undefined) {
                            return '<span style="font-weight: bold">0</span>'
                        } else {
                            return '<span style="font-weight: bold">' + obj.count + '</span>'
                        }
                    }
                },
                {
                    width: '13%',
                    title: '提前办结（%）',
                    name: 'tiqianbanjie',
                    selectFun: function (tiqianbanjie, obj) {
                        if (obj.tiqianbanjie == undefined) {
                            return '<span style="font-weight: bold">0</span>'
                        } else {
                            return '<span style="font-weight: bold">' + obj.tiqianbanjie + '</span>'
                        }
                    }
                },
                {
                    width: '13%',
                    title: '按时办结（%）',
                    name: 'anshibanjie',
                    selectFun: function (anshibanjie, obj) {
                        if (obj.anshibanjie == undefined) {
                            return '<span style="font-weight: bold">0</span>'
                        } else {
                            return '<span style="font-weight: bold">' + obj.anshibanjie + '</span>'
                        }
                    }
                }, {
                    width: '13%',
                    title: '超时办结（%）',
                    name: 'chaoshibanjie',
                    selectFun: function (chaoshibanjie, obj) {
                        if (obj.chaoshibanjie == undefined) {
                            return '<span style="font-weight: bold">0</span>'
                        } else {
                            return '<span style="font-weight: bold">' + obj.chaoshibanjie + '</span>'
                        }
                    }
                    // selectFun:function (beginTime,obj) {
                    //    console.log(obj)
                    // }
                }, {
                    width: '13%',
                    title: '按时办理中（%）',
                    name: 'anshibanli',
                    selectFun: function (anshibanli, obj) {
                        if (obj.anshibanli == undefined) {
                            return '<span style="font-weight: bold">0</span>'
                        } else {
                            return '<span style="font-weight: bold">' + obj.anshibanli + '</span>'
                        }
                    }
                },
                {
                    width: '13%',
                    title: '超时办理中（%）',
                    name: 'chaoshibanli',
                    selectFun: function (chaoshibanli, obj) {
                        if (obj.chaoshibanli == undefined) {
                            return '<span style="font-weight: bold">0</span>'
                        } else {
                            return '<span style="font-weight: bold">' + obj.chaoshibanli + '</span>'
                        }
                    }
                },
                {
                    width: '0px',
                    title: ''
                }
            ], function (me) {
                me.data.pageSize = 5;
                if (types == 0) {
                    me.data.userIds = $('#users').attr('user_id');
                } else {
                    me.data.deptIds = $('#demt').attr('deptid');
                }
                me.data.beginDate = $('[name="beginDate"]').val();
                me.data.endDate = $('[name="endDate"]').val();
                me.init('/FlowRunFu/zhongTong', '');
            })
        // }


    })

    $("#export").click(function () {//导出
        var types = $("input[name='types']:checked").val()
        if(types == 0){
            if($('#users').val() == ''){
                alert('请选择统计人员！');
                return false;
            }
        } else {
            if($('#demt').val() == ''){
                alert('请选择统计部门！');
                return false;
            }
        }
        if(types == 0){
            var userId=$('#users').attr('user_id');
            if(userId!=undefined){
                exportData.userIds=userId;
            }

        } else {
            var deptIds=$('#demt').attr('deptid');
            if(deptIds!=undefined){
                exportData.deptIds=deptIds;
            }
        }
        exportData.beginDate=$('[name="beginDate"]').val();
        exportData.endDate=$('[name="endDate"]').val();
        var length = $('#pageTbody input[type="checkbox"]').length;
        window.location.href='/FlowRunFu/zhongTong?export=1&userIds='+exportData.userIds+'&beginDate='+exportData.beginDate+'&endDate='+exportData.endDate+'&deptIds='+exportData.deptIds;
    })


    $('#allexport').click(function () {//全部导出
        var userId='';
        if($("#status").val()==5 || $("#status").val()==6){
            userId=$('[name="userId"]').attr("user_Id");
        }else{
            userId=$.cookie("userId");
        }
        if($('[name="flowName"]').val()==""){
            $('[name="flowName"]').attr('dataType','0')
        }
        var length = $('#pageTbody input[type="checkbox"]').length;
        window.location.href='../../flowRun/queryFlowRun?output=2&userId='+userId+
            '&flowId='+$('[name="flowName"]').attr('dataType')+'&runId='+$('[name="runId"]').val()+'&runName='+$('[name="runName"]').val()+
            '&state='+$('[name="status"]').val()+'&workLevel='+$('[name="status2"]').val()+'&status='+$('[name="status1"]').val()
            +'&beginDate='+$('[name="beginDate"]').val()+'&endDate='+$('[name="endDate"]').val();

    })

});
