
function GetDropDownBox(fn) {
    $.ajax({
        url: "/sys/getNotifyTypeList?CodeNos=NOTIFY",
        type:'get',
        dataType:"JSON",
        success:function(data){
            var arr=data.obj;
            var str='<option value="">'+notice_type_alltype+'</option>';
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
//表格初始化
var pageObj=$.tablePage('#pagediv','1300px',[
    {
        width:'72px',
        title:ggghhhh,
        name:'',
        selectFun:function (n,obj) {
            return '<input type="checkbox" class="choose" data-id="'+obj.wordId+'">'
        }
    },
    {
        width:'180px',
        title:censor_th_modulename,
        name:'moduleCode'
    },
 /*   {
        width:'180px',
        title:censor_th_filtering,
        name:'useFlag'
    },*/
    {
        width:'180px',
        title:censor_th_reviewers,
        name:'checkUser'
    },
    {
        width:'180px',
        title:censor_th_remind,
        name:'smsRemind'
    },
    {
        width:'180px',
        title:censor_th_telremind,
        name:'sms2Remind'
    },
    /*{
        width:'90px',
        title:notice_th_type,
        name:'typeName',
        selectFun:function (name,obj) {
            if(name==''){
                return notice_type_alltype
            }else {
                return name;
            }
        }
    },*/
    /*{
        width:'140px',
        title:notice_th_releasescope,
        name:'deprange',
        selectFun:function (name,obj,i) {
            return '<span class="toTypeName" data-i="'+i+'" style="cursor: pointer">'+name+obj.rolerange+obj.userrange+'</span>'
        }
    },*/
    // {
    //     width:'200px',
    //     title:censor_th_badwords,
    //     name:'find',
        // selectFun:function (name,obj,i) {
        //     if(obj.top=='1'){
        //         return '<div style="width: 100%;text-align: left">' +
        //             // '<img src="/img/news/top.png" alt="" style="margin-right: 5px;"/>' +
        //                 '<span style="    color: #fff;\
        //         background: #ef7559;\
        //         font-size: 12px;\
        //         padding: 2px 5px;\
        //         margin-right: 3px;\
        //         border-radius: 3px;">'+notice_th_top+'</span>'+
        //             '<a href="/notice/detail?notifyId='+obj.notifyId+'" ' +
        //             'target="_blank" class="windowOpen">'+name+'</a>' +
        //             '</div>'
        //     }else {
        //         return '<div style="width: 100%;text-align: left">' +
        //             '<a href="/notice/detail?notifyId='+obj.notifyId+'" ' +
        //             'target="_blank" class="windowOpen">'+name+'</a>' +
        //             '</div>'
        //     }
        // }
    // },
    // {
    //     width:'200px',
    //     title:censor_th_replacewords,
    //     name:'replacement',
        // selectFun:function (name,obj,i) {
        //     if(obj.top=='1'){
        //         return '<div style="width: 100%;text-align: left">' +
        //             // '<img src="/img/news/top.png" alt="" style="margin-right: 5px;"/>' +
        //             '<span style="    color: #fff;\
        //     background: #ef7559;\
        //     font-size: 12px;\
        //     padding: 2px 5px;\
        //     margin-right: 3px;\
        //     border-radius: 3px;">'+notice_th_top+'</span>'+
        //             '<a href="/notice/detail?notifyId='+obj.notifyId+'" ' +
        //             'target="_blank" class="windowOpen">'+name+'</a>' +
        //             '</div>'
        //     }else {
        //         return '<div style="width: 100%;text-align: left">' +
        //             '<a href="/notice/detail?notifyId='+obj.notifyId+'" ' +
        //             'target="_blank" class="windowOpen">'+name+'</a>' +
        //             '</div>'
        //     }
        // }
    // },

/*    {
        width:'160px',
        title:notice_th_PostedTime,
        name:'notifyDateTime'
    },*/
  /*  {
        width:'120px',
        title:notice_th_effectivedate,
        name:'begin',
        selectFun:function (name) {
            return name.split(' ')[0]
        }
    },*/
/*    {
        width:'120px',
        title:notice_th_endDate,
        name:'end',
        selectFun:function (name) {
            return name.split(' ')[0]
        }
    },*/
   /* {
        width:'80px',
        title:type1,
        name:'publish',
        selectFun:function (name,obj,i) {
            switch(name)
            {
                case '0':
                    return '<span class="red">'+notice_th_unposted+'</span>'
                    break;
                case '1':
                    return '<span class="green">'+notice_state_effective+'</span>'
                    break;
                case '2':
                    return '<span class="blue">'+meet_th_PendingApproval+'</span>'
                    break;
                case '4':
                    return '<span class="red">'+notice_state_end+'</span>'
                    break;
                default:
                    return '<span class="red">'+meet_th_noGuo+'</span>'

            }
        }
    },*/
    {
        width:'235px',
        title:option
    },
],function (me) {
    me.data.typeId=$('[name="type"]').val();
    me.data.changeId='1';
    me.data.exportId='1';

    //1显示  // 2不显示  //不写fn这个属性就是全显示
    me.init("/censor/getCensorModule",[
        {fn:function (obj) {
            if(obj.publish==2||obj.publish==0){
                return 2
            }
        }},
        {fn:function (obj) {
                if(obj.publish==2||obj.publish==0){
                return 2
            }
        }},
        {name:edit1},
        // {name:del}
    ],function () {
        /*var str='<tr>' +
            '<td style="width: 400px;text-align: center"><input type="checkbox" name="all"><span>'+notice_th_allchose+'</span></td>' +
            '<td colspan="9" style="text-align: left">' +
            '<a class="notice_top"><span style="margin-left: 23px;">'+notice_th_top+'</span></a>' +
            '<a class="notice_notop"><span style="margin-left:25px;">'+news_th_quittop+'</span></a>' +
            '<a class="delete_check"><span style="margin-left: 27px;">'+notice_th_DeleteSelectedBulletin+'</span></a>' +
            '<a class="delete_all"><span style="margin-left:27px;">'+notice_th_DeleteAllAnnouncements+'</span></a>' +
            '</td>' +
            '</tr>'*/
        // $('#operation').html(str)
    })
})



    // 事件绑定处理
    $('#pagediv').on('click','[name="all"]',function(){//全选
        if($(this).is(':checked')){
            $('#pageTbody').find('input[type=checkbox]').prop('checked',true)
        }else {
            $('#pageTbody').find('input[type=checkbox]').removeProp('checked')
        }
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
                url:'/censor/delCensorWords',
                dataType:'json',
                data:{'notifyIds':fileId},
                success:function(json){
                   if(json.flag){
                       $.layerMsg({
                           content:delc,
                           icon:1
                       },function () {
                           pageObj.init()
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
                                pageObj.init();
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
                            pageObj.init();
                        })
                    }else {
                        $.layerMsg({content: notice_th_CancelTopF, icon: 2})
                    }

                }
            })

        });
    })









    // $('#pagediv').on('click','.editAndDelete0',function(){
    //     var notifyId=pageObj.arrs[$(this).attr('data-i')].notifyId;
    //     $.popWindow("finddetail?notifyId="+notifyId,situation,'0','0','1150px','700px');
    // })
    //
    $('#pagediv').on('click','.editAndDelete2',function(){
        var moduleId=pageObj.arrs[$(this).attr('data-i')].moduleId;
        parent.$('[name="notices"]').attr('src','../../censor/EditModule?type=edit&moduleId='+moduleId)
    })
    //
    //
    // $('#pagediv').on('click','.editAndDelete1',function(){
    //     var me=this;
    //     var data={
    //         "notifyId":pageObj.arrs[$(me).attr('data-i')].notifyId,
    //         "typeId":pageObj.arrs[$(me).attr('data-i')].typeId
    //     };
    //     console.log(data)
    //     if($(this).find('span').attr('data-type')=='stop'){
    //         data.publish=4;  // 发布标识(0-未发布,1-已发布,2-已终止)
    //     }else if($(this).find('span').attr('data-type')=='effective'){
    //         data.publish=1;
    //     }
    //     $.post('updateNotify',data,function (json) {
    //         if(json.flag){
    //             if($(me).find('span').attr('data-type')=='stop'){
    //                 $(me).find('span').attr('data-type','effective');
    //                 $(me).find('span').text(notice_state_effective);
    //                 $(me).parent().prev().find('span').text(notice_state_end)
    //                 $(me).parent().prev().find('span').removeClass('green')
    //                 $(me).parent().prev().find('span').addClass('red')
    //             }else if($(me).find('span').attr('data-type')=='effective'){
    //                 $(me).find('span').attr('data-type','stop');
    //                 $(me).find('span').text(notice_state_end);
    //                 $(me).parent().prev().find('span').text(notice_state_effective)
    //                 $(me).parent().prev().find('span').addClass('green')
    //                 $(me).parent().prev().find('span').removeClass('red')
    //             }
    //         }
    //     },'json')
    // })


    $('#pagediv').on('click','.editAndDelete3',function(){
        var tid=$(this).parents('tr').find('.choose').attr('data-id');
        layer.confirm(qued, {
            btn: [sure,cancel] ,//按钮
            title:ifDelete
        }, function(){
            //确定删除，调接口
            $.ajax({
                url: "/censor/delCensorWords",
                type: "post",
                data:{
                    wordId:tid
                },
                dataType: 'json',
                success: function (json) {
                    if (json.flag) {
                    $.layerMsg({content: delc, icon: 1}, function () {
                        pageObj.init()
                    })
                    }
                }
            })

        }, function(){
            layer.closeAll();
        });
    })

    $('.submit').click(function () {
        pageObj.data.read='';
        pageObj.data.typeId=$('[name="type"]').val();
        pageObj.data.changeId='1';
        pageObj.data.exportId='1';
        pageObj.init()
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