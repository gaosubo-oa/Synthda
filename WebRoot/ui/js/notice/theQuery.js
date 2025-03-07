/**
 * Created by 骆鹏 on 2018/1/8.
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
        url: "/code/GetDropDownBox",
        type:'get',
        dataType:"JSON",
        data : {"CodeNos":"NOTIFY"},
        success:function(data){
            // var str='<option value="">'+notice_type_alltype+'</option>';
            var str='<option value="">'+notice_th_chosenotifytype+'</option>';
            for (var proId in data){
                for(var i=0;i<data[proId].length;i++){
                    str += '<option value="'+data[proId][i].codeNo+'">'+data[proId][i].codeName+'</option>'

                }
            }
            $('[name="typeId"]').html(str)
            if(fn!=undefined){
                fn()
            }
        }

    })
}

function clicked1(){
    ajaxforms(2);
}
function ajaxforms(type) {
    $('[name="exportId"]').val(type)
    $('.theControlData').each(function () {
        if($(this).attr('user_id')!=undefined) {
            $(this).siblings('input[type=hidden]').val($(this).attr('user_id'))
            return true;
        }
        if($(this).attr('userpriv')!=undefined){
            $(this).siblings('input[type=hidden]').val($(this).attr('userpriv'))
            return true
        }
        if($(this).attr('deptid')!=undefined){
            $(this).siblings('input[type=hidden]').val($(this).attr('deptid'))
        }
    })

    if(type==2){
        // console.log('/notice/notifyList?'+$('#ajaxform').serialize()+'&page=1&pageSize=15&useFlag=true')
        window.location.href='/notice/notifyList?'+$('#ajaxform').serialize()+'&page=1&pageSize=15&useFlag=false';
        return;
    }
    var arrs=$('#ajaxform').serializeArray()
    for(var i=0;i<arrs.length;i++){
        pageObj.data[arrs[i].name]=arrs[i].value;
    }
    //1显示  // 2不显示  //不写fn这个属性就是全显示
    pageObj.init("/notice/notifyList",[
        {name:notice_th_QueryStatus,fn:function (obj) {
            if(obj.publish==2){
                return 2
            }else {
                return notice_th_QueryStatus
            }
        }},
        {name:notice_state_end,fn:function (obj) {
            if(obj.publish==1){
                return '<span data-type="stop">'+notice_state_end+'</span>'
            }else if(obj.publish==4 || obj.publish==5){
                return '<span data-type="effective">'+notice_state_effective+'</span>'
            }else if(obj.publish==2){
                return 2
            }
        }},
        {name:edit1,fn:function(obj) {
            if(isOpenSanyuan) {
                return 2
            }else {
                return 1
            }
            }},
        {name:del}
    ],function () {
        $('#pagediv').css('visibility','visible')
        $('.query').hide();
        $('#pagediv').show();
        $('#export').show();
        $('.page-bottom-inner-layer').height(279);
        var str='<tr>' +
            '<td style="width: 400px;text-align: center"><input type="checkbox" name="all"><span>'+notice_th_allchose+'</span></td>' +
            '<td colspan="9" style="text-align: left">' +
            '<a class="notice_top"><span style="margin-left: 23px;">'+notice_th_top+'</span></a>' +
            '<a class="notice_notop"><span style="margin-left:25px;">'+news_th_quittop+'</span></a>' +
            '<a class="delete_check"><span style="margin-left: 27px;">'+notice_th_DeleteSelectedBulletin+'</span></a>' +
            // '<a class="delete_all"><span style="margin-left:27px;">'+notice_th_DeleteAllAnnouncements+'</span></a>' +
            '</td>' +
            '</tr>'
        $('#operation').html(str)
    })
}
var user_id=null;
var pageObj=null;
$(function () {
    var userPriv=$.cookie('userPriv');
    if(userPriv == '1'){
        $('.pubilsher').show();
    }else{
        $('.pubilsher').hide();
    }
    GetDropDownBox()
    var bodyWidth=$('body').width();
    var width0=bodyWidth*0.05 + 'px';
    var width1=bodyWidth*0.08 + 'px';
    var width2=bodyWidth*0.09 + 'px';
    var width3=bodyWidth*0.21 + 'px';
    var width4=bodyWidth*0.15 + 'px';
    var width5=bodyWidth*0.09 + 'px';
    var width6=bodyWidth*0.09 + 'px';
    var width7=bodyWidth*0.05 + 'px';
    var width8=bodyWidth*0.19 + 'px';
    $('.addroles').on('click',function () {
        user_id = $(this).siblings('textarea').prop('id');
        $.popWindow("../common/selectUser");
    })
    pageObj=$.tablePage('#pagediv',bodyWidth+'px',[
        {
            width:width0,
            title:ggghhhh,
            name:'',
            selectFun:function (n,obj) {
                return '<input type="checkbox" class="choose" data-id="'+obj.notifyId+'">'
            }
        },
        {
            width:width1,
            title:notice_th_publisher,
            name:'name'
        },
        {
            width:width2,
            title:notice_th_type,
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
        // {
        //     width:'140px',
        //     title:notice_th_releasescope,
        //     name:'deprange',
        //     selectFun:function (name,obj,i) {
        //         return '<span class="toTypeName" data-i="'+i+'" style="cursor: pointer">'+name+obj.rolerange+obj.userrange+'</span>'
        //
        //     }
        // },
        {
            width:width3,
            title:notice_th_title,
            name:'subject',
            selectFun:function (name,obj,i) {
                if(obj.top=='1'){
                    return '<div style="width: 100%;text-align: left" title="'+name+'">' +
                        '<span style="    color: #fff;\
       background: #ef7559;\
       font-size: 12px;\
       padding: 2px 5px;\
       margin-right: 3px;\
       border-radius: 3px;">置顶</span>'+
                        '<a onclick="detail('+obj.notifyId+')" href="javascript:;"' +
                        'class="windowOpen">'+name+'</a>' +
                        '</div>'
                }else {
                    return '<div style="width: 100%;text-align: left" title="'+name+'">' +
                        '<a href="/notice/detail?notifyId='+obj.notifyId+'" ' +
                        'target="_blank" class="windowOpen">'+name+'</a>' +
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
            selectFun:function (name,obj,i) {// 发布标识(0-未发布,1-已发布,2-待审批,3-未通过,4-已终止)
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
                    case '3':
                        return '<span class="red">'+meet_th_noGuo+'</span>'
                        break;
                    case '4':
                        return '<span class="red">'+notice_state_pending_effectiveness+'</span>'
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
        me.data.pageSize=10;
    })




    // 事件绑定处理
    $('#pagediv').on('click','[name="all"]',function(){//全选
        if($(this).is(':checked')){
            $('#pageTbody').find('input[type=checkbox]').prop('checked',true)
        }else {
            $('#pageTbody').find('input[type=checkbox]').removeProp('checked')
        }
    })

    $(document).on('click','.cleardate',function () {
        $(this).siblings('textarea').val('')
        $(this).siblings('textarea').attr('user_id','');
        $(this).siblings('textarea').attr('deptid','');
        $(this).siblings('textarea').attr('deptname','');
        $(this).siblings('textarea').attr('privid','');
        $(this).siblings('textarea').attr('userpriv','');
        $(this).siblings('textarea').attr('username','');
        $(this).siblings('textarea').attr('dataid','');
        $(this).siblings('textarea').attr('userprivname','');
    })
    
    $(document).on('click','.chongtian',function () {
        $(':input','#ajaxform')

            .not(':button,:submit,:reset,:hidden')   //将myform表单中input元素type为button、submit、reset、hidden排除

            .val('')  //将input元素的value设为空值

            .removeAttr('checked')

            .removeAttr('checked') // 如果任何radio/checkbox/select inputs有checked or selected 属性，将其移除
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
        layer.confirm(queding, {
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
                            pageObj.init()
                        })
                    } else if(json.flag){
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


    $('#pagediv').on('mouseover','.toTypeName',function () {
        var obi=pageObj.arrs[$(this).attr('data-i')];

        layer.tips('部门：'+obi.deprange+'<br/>' +
            '用户：'+obi.userrange+'<br/>' +
            '角色：'+obi.rolerange+'',this, {
            tips: [1, '#3595CC'],
            time: 1000
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









    $('#pagediv').on('click','.editAndDelete0',function(){
        var notifyId=pageObj.arrs[$(this).attr('data-i')].notifyId;
        $.popWindow("finddetail?notifyId="+notifyId,notice_th_QueryStatus,'0','0','1200px','600px');
    })

    $('#pagediv').on('click','.editAndDelete2',function(){
        var notifyId=pageObj.arrs[$(this).attr('data-i')].notifyId;
        parent.$('[name="notices"]').attr('src','../../notice/newAndEdit?type=edit&notifyId='+notifyId)
    })


    $('#pagediv').on('click','.editAndDelete1',function(){
        var me=this;
        var data={
            "notifyId":pageObj.arrs[$(this).attr('data-i')].notifyId
        };
        if($(this).find('span').attr('data-type')=='stop'){
            data.publish=4;  // 发布标识(0-未发布,1-已发布,2-待审批,3-未通过,4-已终止)
        }else if($(this).find('span').attr('data-type')=='effective'){
            data.publish=1;
        }
        $.post('updateNotify',data,function (json) {
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
                pageObj.init()
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
                            pageObj.init()
                        })
                    } else if (json.flag) {
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

})

function detail(nid) {
    $.popWindow('/notice/detail?notifyId='+nid,notice_th_queryDetail,'20','150','1200px','600px')

}