/**
 * Created by 骆鹏 on 2018/1/5.
 */
//判断是否开启三员管理，如果开启则隐藏编辑功能
var isOpenSanyuan = false;
$.ajax({
    url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
    success:function(res) {
        var data = res.object[0];
        if(data.paraValue == 0) {
        //    进入此判断说明开启了三员管理
            isOpenSanyuan = true;
        }
    }
})
function GetDropDownBox(fn) {
    $.ajax({
        url: "/sys/getNotifyTypeList?CodeNos=NOTIFY",
        type:'get',
        dataType:"JSON",
        success:function(data){
            var arr=data.obj;
            // var str='<option value="">'+notice_type_alltype+'</option>';
            var str='<option value="">'+notice_th_selectNotificationType+'</option>';
            for (var i=0;i<arr.length;i++){
                    str += '<option value="'+arr[i].codeNo+'">'+arr[i].codeName+'</option>'
            }
            $('[name="type"]').html(str)
            if(fn!=undefined){
                fn()
            }
        }

    })
}
$(function () {
    GetDropDownBox()
    var screenwidth = document.documentElement.clientWidth;
    if(screenwidth > 1450){
        var nums = screenwidth*0.97;
        var sumwidth = screenwidth*0.97+'px';
    }else{
        var nums = screenwidth * 1;
        var sumwidth = 100+'%';
    }
    var width0=nums*0.02 + 'px';
    var width1=nums*0.07 + 'px';
    var width2=nums*0.10 + 'px';
    var width3=nums*0.25 + 'px';
    var width4=nums*0.14 + 'px';
    var width5=nums*0.08 + 'px';
    var width6=nums*0.08 + 'px';
    var width7=nums*0.06 + 'px';
    var width8=nums*0.20 + 'px';
//表格初始化
var pageObj=$.tablePage('#pagediv',sumwidth,[
    {
        width:width0,
        title:'',
        name:'',
        selectFun:function (n,obj) {
            return '<input type="checkbox" class="choose" data-id="'+obj.notifyId+'">'
        }
    },
    {
        width:width1,
        // title:notice_th_publisher,
        title:'<fmt:message code="notice.th.publisher" />',
        name:'name'
    },
    {
        width:width2,
        // title:notice_th_type,
        title:'<fmt:message code="notice.th.type" />',
        name:'typeName',
        selectFun:function (name,obj) {
            if(name==''){
                // return notice_type_alltype
                return '';
            }else {
                return name;
            }
        }
    },
    /*{
        width:'140px',
        title:notice_th_releasescope,
        name:'deprange',
        selectFun:function (name,obj,i) {
            return '<span class="toTypeName" data-i="'+i+'" style="cursor: pointer">'+name+obj.rolerange+obj.userrange+'</span>'
        }
    },*/
    {
        width:width3,
        title:'<fmt:message code="notice.th.title" />',
        name:'subject',
        selectFun:function (name,obj,i) {
            if(obj.top=='1'){
                return '<div style="width: 100%;text-align: left">' +
                    // '<img src="/img/news/top.png" alt="" style="margin-right: 5px;"/>' +
                        '<span style="    color: #fff;\
                background: #ef7559;\
                font-size: 12px;\
                padding: 2px 5px;\
                margin-right: 3px;\
                border-radius: 3px;">'+notice_th_top+'</span>'+
                    '<a href="javascript:;" ' +
                    'title="'+name+'" data-id="'+obj.notifyId+'" class="windowOpen">'+name+'</a>' +
                    '<span style="color: red">   '+obj.contentSecrecy+'</span>'+
                    '</div>'
            }else {
                return '<div style="width: 100%;text-align: left">' +
                    '<a href="javascript:;" ' +
                    'title="'+name+'" data-id="'+obj.notifyId+'" class="windowOpen">'+name+'</a>' +
                    '<span style="color: red">   '+obj.contentSecrecy+'</span>'+
                    '</div>'
            }
        }
    },
    {
        width:width4,
        title:notice_th_CreationTime,
        name:'notifyDateTime'
    },
    {
        width:width5,
        title:notice_th_effectivedate,
        name:'begin',
        selectFun:function (name) {
            return name.split(' ')[0]
        }
    },
    {
        width:width6,
        title:notice_th_endDate,
        name:'end',
        selectFun:function (name) {
            return name.split(' ')[0]
        }
    },
    {
        width:width7,
        title:type1,
        name:'publish',
        selectFun:function (name,obj,i) {
            switch(name)
            {
                case '0':
                    return '<span class="red">'+notice_th_pendingRelease+'</span>'
                    break;
                case '1':
                    return '<span class="green">'+notice_th_hasTakenEffect+'</span>'
                    break;
                case '2':
                    return '<span class="blue">'+meet_th_PendingApproval+'</span>'
                    break;
                case '3':
                    return '<span class="red">'+meet_th_noGuo+'</span>'
                    break;
                case '4':
                    return '<span class="red">'+notice_state_pending_effectiveness+'</span>'
                    break;
                case '5':
                    return '<span class="red">'+notice_th_hasEnd+'</span>'
                    break;
                default:
                    return '<span class="red">'+notice_state_end+'</span>'

            }
        }
    },
    {
        width:width8,
        title:option
    },
],function (me) {

    me.data.typeId=$('[name="type"]').val();
    me.data.changeId='1';
    me.data.exportId='1';
    me.data.pageSize=10;
    //1显示  // 2不显示  //不写fn这个属性就是全显示
    me.init("/notice/notifyList",[
        {name:notice_th_QueryStatus,fn:function (obj) {//查阅情况
            if(obj.publish==2||obj.publish==0){
                return 2
            }else {
                return notice_th_QueryStatus
            }
        }},
        {name:notice_state_end,fn:function (obj) {//终止
            if(obj.publish==1){
                return '<span data-type="stop" draftDept="'+(obj.draftDept || '')+'">'+notice_state_end+'</span>'
            }else if(obj.publish==4 || obj.publish==5){
                return '<span data-type="effective">'+notice_state_effective+'</span>'
            }else if(obj.publish==2||obj.publish==0){
                return 2
            }
        }},
        {name:edit1,fn:function (obj) {//编辑
                if(obj.publish==1 || isOpenSanyuan){
                    return 2
                }else{
                    return 1
                }
            }},
        {name:del},//删除
        {name:notice_th_releasescope,fn:function (obj) {//发布范围
                if(obj){
                    return '<span data-type="releasescope">'+notice_th_releasescope+'</span>'
                }
            }},
        {name:notice_th_reminderForReceipt,fn:function (obj) {
                if(obj.isOpin==1 && obj.opinionFields!=null && obj.opinionFields!=''){
                    return 1
                }else{
                    return 2
                }
            }},
        {name:notice_th_receiptStatus,fn:function (obj) {
                if(obj.isOpin==1 && obj.opinionFields!=null && obj.opinionFields!=''){
                    return 1
                }else{
                    return 2
                }
            }}
    ],function () {
        var str='<tr>' +
            '<td style="width: 400px;text-align: left;"><input type="checkbox" name="all">' +
            '<a class="notice_top"><span style="margin-left: 23px;">'+notice_th_top+'</span></a>' +
            '<a class="notice_notop"><span style="margin-left:25px;">'+news_th_quittop+'</span></a>' +
            '<a class="delete_check"><span style="margin-left: 27px;">'+notice_th_DeleteSelectedBulletin+'</span></a>' +
            // '<a class="query"><span style="margin-left:27px;">过期公告</span></a>' +
            '</td>' +
            // '<td colspan="9" style="text-align: left">' +
            // '<a class="notice_top"><span style="margin-left: 23px;">'+notice_th_top+'</span></a>' +
            // '<a class="notice_notop"><span style="margin-left:25px;">'+news_th_quittop+'</span></a>' +
            // '<a class="delete_check"><span style="margin-left: 27px;">'+notice_th_DeleteSelectedBulletin+'</span></a>' +
            // // '<a class="query"><span style="margin-left:27px;">过期公告</span></a>' +
            // '</td>' +
            '</tr>'
        $('#operation').html(str)
    })
})



    // 事件绑定处理
    $('#pagediv').on('click','[name="all"]',function(){//全选
        if($(this).is(':checked')){
            $('#pageTbody').find('input[type=checkbox]').prop('checked',true)
        }else {
            $('#pageTbody').find('input[type=checkbox]').prop('checked',false)
        }
    })


    //公告详情
    $('#pagediv').on('click','.windowOpen',function () {
        var notifyId=$(this).attr('data-id');
        $.popWindow('/notice/detail?notifyId='+notifyId,notice_th_queryDetail,'20','150','1200px','500px')
    })


    $('#pagediv').on('click','.delete_check',function(){//删除公告
        if($('#pageTbody').find('input[type=checkbox]:checked').length==0){
            $.layerMsg({content:notice_th_dj,icon:2});
            return;
        }
        var fileId=[];
        $('#pageTbody').find('input[type=checkbox]:checked').each(function(){
            var conId=$(this).attr("data-id");
            fileId.push(conId);
        })
        layer.confirm(qued, {
            btn: [sure,cancel], //按钮
            title:queding
        }, function(){
            $.ajax({
                type:'post',
                url:'/notice/deleteByIds',
                dataType:'json',
                data:{'notifyIds':fileId},
                success:function(json){
                    if (json.code == '100066'){
                        $.layerMsg({content: notice_th_noticeDeleteByIdsPrompt, icon: 4}, function () {
                            pageObj.init('/notice/notifyList')
                        })
                    } else if(json.flag){
                       $.layerMsg({
                           content:delc,
                           icon:1
                       },function () {
                           pageObj.init('/notice/notifyList')
                       })
                   }else {
                       $.layerMsg({
                           content:delf, icon:2
                       })
                   }
                }
            })

        });
    })

    $('#pagediv').on('click','.notice_top',function(){//置顶
       if($('#pageTbody').find('input[type=checkbox]:checked').length==0){
           $.layerMsg({content:notice_th_dj,icon:2});
           return;
       }
        var fileId=[];
        $('#pageTbody').find('input[type=checkbox]:checked').each(function(){
            var conId=$(this).attr("data-id");
            fileId.push(conId);
        })
        layer.confirm(ConfirmTop, {
            btn: [sure,cancel], //按钮
            title:SetTop
        }, function(){

                $.ajax({
                    type:'post',
                    url:'/notice/updateByIds',
                    dataType:'json',
                    data:{
                        notifyIds:fileId,
                        top:'1'
                    },
                    success:function(json){
                        if(json.flag) {
                            $.layerMsg({content: TopSuccess, icon: 1}, function () {
                                pageObj.init('/notice/notifyList');
                            })
                        }else {
                            $.layerMsg({content: TopFailure, icon: 2})
                        }

                    }
                })

            });
    })

    $('#pagediv').on('click','.notice_notop',function(){//取消置顶
        if($('#pageTbody').find('input[type=checkbox]:checked').length==0){
            $.layerMsg({content:notice_th_dj,icon:2});
            return;
        }
        var fileId=[];
        $('#pageTbody').find('input[type=checkbox]:checked').each(function(){
            var conId=$(this).attr("data-id");
            fileId.push(conId);
        })
        layer.confirm(notice_th_dd, {
            btn: [sure,cancel], //按钮
            title:notice_th_Determine
        }, function(){
            $.ajax({
                type:'post',
                url:'/notice/updateByIds',
                dataType:'json',
                data:{
                    notifyIds:fileId,
                    top:'0'
                },
                success:function(json){
                    if(json.flag) {
                        $.layerMsg({content: notice_th_CancelTopSuccess, icon: 1}, function () {
                            pageObj.init('/notice/notifyList');
                        })
                    }else {
                        $.layerMsg({content: notice_th_CancelTopF, icon: 2})
                    }

                }
            })

        });
    })

    $('#pagediv').on('click','.editAndDelete0',function(){
        var notifyId=pageObj.arrs[$(this).attr('data-i')].notifyId;
        $.popWindow("finddetail?notifyId="+notifyId,situation,'0','0','1150px','700px');
    })
    $('#pagediv').on('click','.editAndDelete5',function(){
        var tid=pageObj.arrs[$(this).attr('data-i')].notifyId;
        layer.confirm(notice_th_urgeOpin+"?", {
            btn: [sure,cancel] ,//按钮
            title: notice_th_whetherToSendAReminder
        }, function(){
            //催办，调接口
            $.ajax({
                url: "/notice/urgeOpin",
                type: "get",
                data:{
                    notifyId:tid
                },
                dataType: 'json',
                success: function (json) {
                    if (json.flag) {
                            var str=''
                            for (var i=0;i<json.object.length;i++){
                                str += json.object[i].userName+','
                            }
                            //
                            layer.confirm(str,{
                                btn: [sure, cancel], //按钮
                                title: notice_th_personnelWhoHaveBeenSuccessfullyReminded
                            }, function(){
                                pageObj.init('/notice/notifyList');
                                layer.closeAll();
                            });

                    }
                }
            })

        }, function(){
            layer.closeAll();
        });
    })

    $('#pagediv').on('click','.editAndDelete6',function(){
        var notifyId=pageObj.arrs[$(this).attr('data-i')].notifyId;
        $.popWindow("finddetailOpinion?notifyId="+notifyId,situation,'0','0','1350px','700px');
    })

    $('#pagediv').on('click','.editAndDelete2',function(){
        var notifyId=pageObj.arrs[$(this).attr('data-i')].notifyId;
        var isEdit=isPublish(notifyId)
        if(isEdit==1){
            $.layerMsg({content:notice_th_thisAnnouncementHasComeIntoEffect+'！',icon:0});
            return false
        }
        parent.$('[name="notices"]').attr('src','../../notice/newAndEdit?type=edit&notifyId='+notifyId)
    })
    //在点击修改或编辑或审批时，如果已生效，则不允许操作
    function isPublish(notifyId){
        var isPublish=''
        $.ajax({
            url:'/notice/selectById',
            type:'get',
            data:{notifyId:notifyId},
            dataType:'json',
            async:false,
            success:function(res){
                if(res.flag && res.obj1.publish==1){
                    isPublish=res.obj1.publish
                }
            }
        })
        return isPublish
    }


    $('#pagediv').on('click','.editAndDelete1',function(){
        var me=this;
        var data={
            "notifyId":pageObj.arrs[$(me).attr('data-i')].notifyId,
            "typeId":pageObj.arrs[$(me).attr('data-i')].typeId
        };
        // console.log(data)
        if($(this).find('span').attr('data-type')=='stop'){
            data.publish=5;  // 发布标识(0-未发布,1-生效,2-待审批,3-未通过,4-待生效,5-终止)
        }else if($(this).find('span').attr('data-type')=='effective'){
            data.publish=1;
        }
        /*因终止后导致拟稿部门丢失，因此传该参数*/
        data.draftDept=$(this).find('span').attr('draftdept')
        $.post('updateTopstatus',data,function (json) {
            if(json.flag){
                if($(me).find('span').attr('data-type')=='stop'){
                    $(me).find('span').attr('data-type','effective');
                    $(me).find('span').text(notice_state_effective);
                    $(me).parent().prev().find('span').text(notice_state_end)
                    $(me).parent().prev().find('span').removeClass('green')
                    $(me).parent().prev().find('span').addClass('red')
                }else if($(me).find('span').attr('data-type')=='effective'){
                    $(me).find('span').attr('data-type','stop');
                    $(me).find('span').text(notice_state_end);
                    $(me).parent().prev().find('span').text(notice_state_effective)
                    $(me).parent().prev().find('span').addClass('green')
                    $(me).parent().prev().find('span').removeClass('red')
                }
                pageObj.init('/notice/notifyList')
            }
        },'json')
    })


    $('#pagediv').on('click','.editAndDelete3',function(){
        var tid=pageObj.arrs[$(this).attr('data-i')].notifyId;
        layer.confirm(qued, {
            btn: [sure,cancel] ,//按钮
            title:ifDelete
        }, function(){
            //确定删除，调接口
            $.ajax({
                url: "/notice/deleteById",
                type: "get",
                data:{
                    notifyId:tid
                },
                dataType: 'json',
                success: function (json) {
                    if (json.code == '100066'){
                        $.layerMsg({content: notice_th_noticeDeleteByIdsPrompt, icon: 4}, function () {
                            pageObj.init('/notice/notifyList')
                        })
                    } else if (json.flag) {
                        $.layerMsg({content: delc, icon: 1}, function () {
                            pageObj.init('/notice/notifyList')
                        })
                    }
                }
            })

        }, function(){
            layer.closeAll();
        });
    })
    $('#pagediv').on('mouseover','.editAndDelete4',function(){
        this.setAttribute('title', notice_th_viewReleaseScope);
    })
    //(发布范围取部门deprange、角色rolerange和人员userrange的并集)
    $('#pagediv').on('click','.editAndDelete4',function(){
        var tid=pageObj.arrs[$(this).attr('data-i')].notifyId;
        var scopeData;
        $.get('getOneById',{
            notifyId:tid,
            permissionId:'1',
            changId:'1'
        },function (json) {
            if(json.flag){
                // var loading = layer.msg('信息获取中', {icon: 16, shade: 0.3, time:0});
                scopeData = '部门：' + json.object.deprange +'<br>角色：'+ json.object.rolerange +'<br>人员：'+ json.object.userrange;
                // layer.close(loading);
                layer.confirm(scopeData, {
                    btn: [sure] ,//按钮
                    title: notice_th_releasescope
                });
            }
        });
    })

    $('.submit').on('click',function () {
        pageObj.data.read='';
        pageObj.data.typeId=$('[name="type"]').val();
        pageObj.data.changeId='1';
        pageObj.data.exportId='1';

        if($('#status').val()!=0||$('#status').val()==""){
            pageObj.data.publish=$('#status').val();
            pageObj.init('/notice/notifyList')
        }else{
            pageObj.data.page=1;
            pageObj.data.publish=undefined;
            pageObj.init('/notice/selectNotifyOverTime')
        }

    })

    $('#pagediv').on('mouseover','.toTypeName',function () {
        var obi=pageObj.arrs[$(this).attr('data-i')];

        layer.tips(userManagement_th_department+'：'+obi.deprange+'<br/>' +
            journal_th_user+'：'+obi.userrange+'<br/>' +
            userManagement_th_role+'：'+obi.rolerange+'',this, {
            tips: [1, '#3595CC'],
            time: 1000
        });
    })

})