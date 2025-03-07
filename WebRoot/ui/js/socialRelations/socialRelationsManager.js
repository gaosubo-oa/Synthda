/**
 * Created by Klous on 2018/7/2.
 */
var type = $.GetRequest().type;
var userId= decodeURI($.GetRequest().userId);

//点击全选，子复选框被选中
function demo(){
    var allcheck=document.getElementById("allcheck");
    var choice=document.getElementsByName("choice");
    for(var i=0;i<choice.length;i++){
        choice[i].checked=allcheck.checked;
    }
}

//点击子复选框,全选框 选中、取消
function setAll(){
    if(!$(".checknum").checked){
        $("#allcheck").prop("checked",false); // 子复选框某个不选择，全选也被取消
    }
    var choicelength=$("input[type='checkbox'][class='choose']").length;
    var choiceselect=$("input[type='checkbox'][class='choose']:checked").length;

    if(choicelength==choiceselect){
        $("#allcheck").prop("checked",true);   // 子复选框全部部被选择，全选也被选择；
    }

}

$(function () {

    $(document).on('click','.newClass',function () {
        if(type!=undefined){
            $(window.parent.document).find('.main').find('iframe').prop('src','/hr/manage/newSocialRelations?type=1&userId='+userId)
        }else{
            $(window.parent.document).find('.main').find('iframe').prop('src','/hr/manage/newSocialRelations')
        }

    })

//表格初始化
    var pageObj=$.tablePage('#pagediv','1100px',[
        {
            width:'70px',
            title:ggghhhh,
            name:'',
            selectFun:function (n,obj) {
                return '<input type="checkbox" class="choose" data-id="'+obj.socialRelId+'" onclick="setAll()">'
            }
        },
        {
            width:'150px',
            title:'单位员工',
            name:'userName',
            selectFun:function (name,obj,i) {
                if(name){
                    return name;
                } else {
                    return '(<span class="red">用户已删除</span>)'
                }
            }
        },
        {
            width:'150px',
            title:'成员姓名',
            name:'staffName'
        },
        {
            width:'150px',
            title:'与本人关系',
            name:'relativeName',
            selectFun:function (name) {
                if(name == undefined) {
                    return '';
                } else {
                    return name;
                }
            },
        },
        {
            width:'150px',
            title:'职业',
            name:'occupation',
        },
        {
            width:'150px',
            title:'联系电话(个人)',
            name:'phone'
        },{
            width:'200px',
            title:'操作'
        },

    ],function (me) {
        me.data.typeId=$('[name="type"]').val();
        me.data.changeId='1';
        me.data.exportId='1';
        //1显示  // 2不显示  //不写fn这个属性就是全显示
        me.init("/hr/manage/getSocialRelations?staffRole=",[
            // {name:notice_th_QueryStatus,fn:function (obj) {
            //     if(obj.publish==2||obj.publish==0){
            //         return 2
            //     }else {
            //         return notice_th_QueryStatus
            //     }
            // }},
            // {name:notice_state_end,fn:function (obj) {
            //     if(obj.publish==1){
            //         return '<span data-type="stop">'+notice_state_end+'</span>'
            //     }else if(obj.publish==4 || obj.publish==5){
            //         return '<span data-type="effective">'+notice_state_effective+'</span>'
            //     }else if(obj.publish==2||obj.publish==0){
            //         return 2
            //     }
            // }},
            {name:'详细信息'},
            {name:'修改'},
            {name:del}]
            ,function () {
                var str=          '<tr><td colspan="7"><label style="cursor: pointer;"><input style="cursor: pointer;" type="checkbox" name="all" onclick="demo()" id="allcheck"><span>全选</span></label>' +
                    '<a href="javascript:;" class="delete_check"><img src="/img/file/icon_fileDelete.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt="">删除</a></td></tr>'
                $('#operation').html(str)
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
            $.layerMsg({content:'请先选择内容',icon:2});
            return;
        }
        var socialRelId=[];
        $('#pageTbody').find('input[type=checkbox]:checked').each(function(){
            var conId=$(this).attr("data-id");
            socialRelId.push(conId);
        })

        console.log(socialRelId)

        layer.confirm(qued, {
            btn: [sure,cancel], //按钮
            title:queding
        }, function(){
            $.ajax({
                type:'post',
                url:'/hr/manage/deleteSocialRelations',
                dataType:'json',
                data:{'socialRelId':socialRelId},
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

    // 首页详情
    $('#pagediv').on('click','.editAndDelete0',function(){
        var ids=pageObj.arrs[$(this).attr('data-i')].socialRelId;
        $.popWindow("socialRelationsDetail?ids="+ids,'社会关系详细信息','0','0','1150px','700px');
    })

    // 首页删除
    $('#pagediv').on('click','.editAndDelete2',function(){
        var delid = [];
        var id=pageObj.arrs[$(this).attr('data-i')].socialRelId;
        delid.push(id)
        layer.confirm(qued, {
            btn: [sure,cancel] ,//按钮
            title:ifDelete
        }, function(){
            //确定删除，调接口
            $.ajax({
                url: "/hr/manage/deleteSocialRelations",
                type: "get",
                data:{
                    'socialRelId':delid
                },
                dataType: 'json',
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

        }, function(){
            layer.closeAll();
        });
    })


    // 首页修改
    $('#pagediv').on('click','.editAndDelete1',function(){
        var me=this;
        var id=pageObj.arrs[$(this).attr('data-i')].socialRelId;
        console.log(id)
        if(type!=undefined){
            parent.$('[name="notices"]').attr('src','/hr/manage/socialRelationUpdate?type=1&userId='+userId+'&id='+id)
        }else{
            parent.$('[name="notices"]').attr('src','/hr/manage/socialRelationUpdate?id='+id)
        }


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
                        $.layerMsg({content: '进入删除审批，审批通过后删除', icon: 4}, function () {
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

    $('.submit').on("click",function () {
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