/**
 * Created by Klous on 2018/8/7.
 */
var type = $.GetRequest().type;
var userId= decodeURI($.GetRequest().userId);
$(function () {

//表格初始化
    var pageObj=$.tablePage('#pagediv','100%',[
        {
            width:'5%',
            title:ggghhhh,
            name:'',
            selectFun:function (n,obj) {
                return '<input type="checkbox" class="choose" data-id="'+obj.leaveId+'">'
            }
        },
        {
            width:'8%',
            title:'离职人员',
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
            width:'10%',
            title:'离职部门',
            name:'deptName'
        },
        {
            width:'8%',
            title:'担任职务',
            name:'position',
        },
        {
            width:'8%',
            title:'离职类型',
            name:'quitType',
            // selectFun:function (name,obj,i) {
            //     switch(name)
            //     {
            //         case '':
            //             return ' '
            //             break;
            //         case '1':
            //             return '辞职'
            //             break;
            //         case '2':
            //             return '离休'
            //             break;
            //         case '3':
            //             return '退休'
            //             break;
            //         case '4':
            //             return '借调'
            //             break;
            //         default:
            //             return ' '
            //     }
            // }
        },
        {
            width:'10%',
            title:'拟离职日期',
            name:'quitTimePlan'
        },
        {
            width:'10%',
            title:'实际离职日期',
            name:'quitTimeFact'
        },
        {
            width:'10%',
            title:'工资截止日期',
            name:'lastSalaryTime'
        },
        {
            width:'10%',
            title:'离职当月薪资',
            name:'salary'
        },
        {
            width:'10%',
            title:'审核状态',
            name:'auditState',
            selectFun:function (name) {
                switch(name)
                {
                    case '':
                        return ' '
                        break;
                    case '1':
                        return '提交离职申请'
                        break;
                    case '5':
                        return '管理员审核通过'
                        break;
                    case '6':
                        return '离职申请退回'
                        break;
                    default:
                        return ' '
                }
            }
        },
        {
            width:'12%',
            title:option
        },
    ],function (me) {
        if(userId!=undefined&&userId!='undefined'){
            me.data.leavePerson = userId;
        }
        me.data.typeId=$('[name="type"]').val();
        // me.data.changeId='1';
        // me.data.exportId='1';

        //1显示  // 2不显示  //不写fn这个属性就是全显示
        me.init("/hr/leave/leaveQuery",[
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
                '<td style="width: 400px;padding-left: 5px"><input type="checkbox" name="all"><span>'+notice_th_allchose+'</span></td>' +
                '<td colspan="10" style="text-align: left">' +
                '<a href="javascript:;" class="delete_check"><img src="/img/file/icon_fileDelete.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt="">删除</a>' +
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




    $('#pagediv').on('click','.delete_check',function(){//删除
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
                url:'/hr/leave/leaveDelete',
                dataType:'json',
                data:{'leaveId':fileId},
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

    $('#pagediv').on('click','.editAndDelete0',function(){
        var ids=pageObj.arrs[$(this).attr('data-i')].leaveId;
        $.popWindow("DimissionDetail?ids="+ids,'员工离职详细信息','0','0','1200px','600px');
    })

    $('#pagediv').on('click','.editAndDelete2',function(){
        var id=pageObj.arrs[$(this).attr('data-i')].leaveId;
        // parent.$('[name="notices"]').attr('src','../../notice/newAndEdit?type=edit&notifyId='+notifyId)
        layer.confirm(qued, {
            btn: [sure,cancel] ,//按钮
            title:ifDelete
        }, function(){
            //确定删除，调接口
            $.ajax({
                url: "/hr/leave/leaveDelete",
                type: "get",
                data:{
                    'leaveId[]':id
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
        var id=pageObj.arrs[$(this).attr('data-i')].leaveId;
        console.log(id)
        if(type!=undefined){
            parent.$('[name="notices"]').attr('src','/dimission/newDimission?type=1&userId="'+userId+'"&id='+id)
        }else{
            parent.$('[name="notices"]').attr('src','/dimission/newDimission?id='+id)
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