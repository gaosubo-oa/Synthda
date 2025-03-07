/**
 * Created by Klous on 2018/8/7.
 */


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

    //导出
    if(type==2){
        window.location.href='/hr/leave/leaveExport?'+$('#ajaxform').serialize()+'&page=1&pageSize=15&useFlag=true';
        return;
    }

    //获取查询的值
    var arrs=$('#ajaxform').serializeArray()
    for(var i=0;i<arrs.length;i++){
        pageObj.data[arrs[i].name]=arrs[i].value;
    }
    //1显示  // 2不显示  //不写fn这个属性就是全显示
    pageObj.init("/hr/leave/leaveCondition",[
        {name:'详细信息'},
        {name:'修改'},
        {name:del}
    ],function () {
        $('#pagediv').css('visibility','visible')
        $('.query').hide();
        $('#pagediv').show();
        $('.page-bottom-inner-layer').height(279);
        var str='<tr>' +
            '<td style="width: 400px;text-align: center"><input type="checkbox" name="all"><span>'+notice_th_allchose+'</span></td>' +
            '<td colspan="9" style="text-align: left">' +
            '<a href="javascript:;" class="delete_check"><img src="/img/file/icon_fileDelete.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt="">删除</a>' +
            // '<a class="delete_all"><span style="margin-left:27px;">删除全部内容</span></a>' +
            '</td>' +
            '</tr>'
        $('#operation').html(str)
    })
}
var user_id=null;
var dept_id=null;
var pageObj=null;
$(function () {

    $('.addroles').on("click",function () {
        user_id = $(this).siblings('textarea').prop('id');
        $.popWindow("../common/selectUser?0");
    })

    $('.addroless').on("click",function () {
        dept_id=$(this).siblings('textarea').prop('id');
        $.popWindow("../../common/selectDept?0");
    })

    pageObj=$.tablePage('#pagediv','100%',[
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
            width:'12%',
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
            width:'12%',
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
            width:'11%',
            title:option
        },
    ],function (me) {
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
                '<td colspan="9" style="text-align: left">' +
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
                data:{'leaveDelete':fileId},
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


    $('#pagediv').on('mouseover','.toTypeName',function () {
        var obi=pageObj.arrs[$(this).attr('data-i')];

        layer.tips('部门：'+obi.deprange+'<br/>' +
            '用户：'+obi.userrange+'<br/>' +
            '角色：'+obi.rolerange+'',this, {
            tips: [1, '#3595CC'],
            time: 1000
        });
    })


    $('#pagediv').on('click','.editAndDelete0',function(){
        var ids=pageObj.arrs[$(this).attr('data-i')].leaveId;
        // $.popWindow("learningExperienceDetail?ids="+ids,'学习经历详细信息','0','0','1200px','600px');
        $.popWindow("DimissionDetail?ids="+ids,'员工离职详细信息','0','0','1200px','600px');
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
        var id=pageObj.arrs[$(this).attr('data-i')].leaveId;
        // console.log(id)
        // parent.$('[name="notices"]').attr('src','/learningExperience/newLearningExperience?id='+id)
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