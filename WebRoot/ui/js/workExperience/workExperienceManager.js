/**
 * Created by Klous on 2018/7/2.
 */


$(function () {

//表格初始化
    var pageObj=$.tablePage('#pagediv','1359px',[
        {
            width:'72px',
            title:ggghhhh,
            name:'',
            selectFun:function (n,obj) {
                return '<input type="checkbox" class="choose" data-id="'+obj.id+'">'
            }
        },
        {
            width:'130px',
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
            width:'215px',
            title:'所学专业	',
            name:'profession'
        },
        {
            width:'140px',
            title:'所获学历',
            name:'academic',
            selectFun:function (name,obj,i) {
                switch(name)
                {
                    case '':
                        return ' '
                        break;
                    case '1':
                        return '小学'
                        break;
                    case '2':
                        return '初中'
                        break;
                    case '3':
                        return '高中'
                        break;
                    case '4':
                        return '中专'
                        break;
                    case '5':
                        return '大专'
                        break;
                    case '6':
                        return '本科'
                        break;
                    case '7':
                        return '研究生'
                        break;
                    case '8':
                        return '博士'
                        break;
                    case '9':
                        return '博士后'
                        break;
                    case '10':
                        return '技校'
                        break;
                    default:
                        return ' '

                }
            }
        },
        {
            width:'140px',
            title:'所获学位',
            name:'degree',
            selectFun:function (name,obj,i) {
                switch(name)
                {
                    case '':
                        return ' '
                        break;
                    case '1':
                        return '博士后'
                        break;
                    case '2':
                        return '博士'
                        break;
                    case '3':
                        return 'MBA'
                        break;
                    case '4':
                        return '硕士'
                        break;
                    case '5':
                        return '双学士'
                        break;
                    case '6':
                        return '学士'
                        break;
                    case '7':
                        return '无'
                        break;
                    default:
                        return ' '
                }
            }
        },
        {
            width:'280px',
            title:'所在院校',
            name:'university'
        },
        {
            width:'145px',
            title:'证明人',
            name:'certifier'
        },
        {
            width:'235px',
            title:option
        },
    ],function (me) {
        me.data.typeId=$('[name="type"]').val();
        me.data.changeId='1';
        me.data.exportId='1';

        //1显示  // 2不显示  //不写fn这个属性就是全显示
        me.init("/learningExperience/getLearningExperienceList",[
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
            {name:del}
        ],function () {
            var str='<tr>' +
                '<td style="width: 400px;text-align: center"><input type="checkbox" name="all"><span>'+notice_th_allchose+'</span></td>' +
                '<td colspan="9" style="text-align: left">' +
                '<a class="delete_check"><span style="margin-left: 27px;">删除选中内容</span></a>' +
                // '<a class="delete_all"><span style="margin-left:27px;">删除全部内容</span></a>' +
                '</td>' +
                '</tr>'
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
        var fileId=[];
        $('#pageTbody').find('input[type=checkbox]:checked').each(function(){
            var conId=$(this).attr("data-id");
            fileId.push(conId);
        })

        console.log(fileId)
        layer.confirm(qued, {
            btn: [sure,cancel], //按钮
            title:queding
        }, function(){
            $.ajax({
                type:'post',
                url:'/learningExperience/deleteLearningExperienceByIds',
                dataType:'json',
                data:{'ids':fileId},
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









    $('#pagediv').on('click','.editAndDelete0',function(){
        var ids=pageObj.arrs[$(this).attr('data-i')].id;
        $.popWindow("learningExperienceDetail?ids="+ids,'学习经历详细信息','0','0','1150px','700px');
    })

    $('#pagediv').on('click','.editAndDelete2',function(){
        var delid = [];
        var id=pageObj.arrs[$(this).attr('data-i')].id;
        delid.push(id)
        // parent.$('[name="notices"]').attr('src','../../notice/newAndEdit?type=edit&notifyId='+notifyId)
        layer.confirm(qued, {
            btn: [sure,cancel] ,//按钮
            title:ifDelete
        }, function(){
            //确定删除，调接口
            $.ajax({
                url: "/learningExperience/deleteLearningExperienceByIds",
                type: "get",
                data:{
                    'ids':delid
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


    $('#pagediv').on('click','.editAndDelete1',function(){
        var me=this;
        var id=pageObj.arrs[$(this).attr('data-i')].id;
        console.log(id)
        parent.$('[name="notices"]').attr('src','/learningExperience/newLearningExperience?id='+id)

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