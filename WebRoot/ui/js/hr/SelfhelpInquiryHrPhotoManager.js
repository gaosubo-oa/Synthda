/**
 * Created by Klous on 2018/7/2.
 */


$(function () {
//新建
    $("#newClass").on("click",function(){
        window.location.href="/hr/manage/photoNewedit";
        // $('.main').find('iframe').prop('src',' /hr/manage/photoNewedit')
    })
//表格初始化
    var pageObj=$.tablePage('#pagediv','1100px',[
     /*   {
            width:'70px',
            title:ggghhhh,
            name:'',
            selectFun:function (n,obj) {
                return '<input type="checkbox" class="choose" data-id="'+obj.licenseId+'">'
            }
        },*/
        {
            width:'156px',
            title:'单位员工',
            name:'staffName',
            selectFun:function (name,obj,i) {
                if(name){
                    return name;
                } else {
                    return '(<span class="red">用户已删除</span>)'
                }
            }
        },
        {
            width:'120px',
            title:'证照类型	',
            name:'licenseType',
            selectFun:function (name,obj,i) {
                switch(name)
                {
                    case '1':
                        return '<span>驾驶证</span>'
                        break;
                    case '2':
                        return '<span>健康证</span>'
                        break;
                    case '3':
                        return '<span>暂住证</span>'
                        break;
                    case '4':
                        return '<span>技能证</span>'
                        break;
                    case '5':
                        return '<span>其他</span>'
                        break;
                    default:
                        return '<span>不存在</span>'

                }
            }
        },
        {
            width:'162px',
            title:'证书编号',
            name:'licenseNo',
        },
        {
            width:'161px',
            title:'证照名称',
            name:'licenseName',
        },
        {
            width:'130px',
            title:'状态',
            name:'status',
            selectFun:function (name,obj,i) {
                switch(name)
                {
                    case '1':
                        return '<span>未生效</span>'
                        break;
                    case '2':
                        return '<span>生效中</span>'
                        break;
                    case '3':
                        return '<span>已到期</span>'
                        break;
                    default:
                        return '<span>未填写</span>'

                }
            }
        },
        {
            width:'130px',
            title:'发证机构',
            name:'notifiedBody'
        },
        {
            width:'170px',
            title:option,
            color:'#CCC',
        },
    ],function (me) {
      /*  me.data.typeId=$('[name="type"]').val();*/
        me.data.changeId='1';
        me.data.exportId='1';
        me.data.typeId='3'

        //1显示  // 2不显示  //不写fn这个属性就是全显示
        me.init("/hr/getHumanResourcesData",[
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
            {name:'详细信息'}
        ],function () {
            var str='<tr>' +
                '</tr>'
            $('#operation').html(str)
        })
    })


    $('#pagediv').on('click','.delete_check',function(){ //删除公告
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
                type:'get',
                url:'/hr/manage/deleteHrphotos',
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
                url:'/hr/manage/upHrphotos',
                dataType:'json',
                data:{
                    licenseId:fileId,
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
                url:'/hr/manage/upHrphotos',
                dataType:'json',
                data:{
                    licenseId:fileId,
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
        var ids=pageObj.arrs[$(this).attr('data-i')].licenseId;
        $.popWindow("/hr/manage/photoDetail?licenseId="+ids,'人事调动详细信息','0','0','1150px','700px');
    })

    $('#pagediv').on('click','.editAndDelete2',function(){
        var delid = [];
        var licenseId=pageObj.arrs[$(this).attr('data-i')].licenseId;
        console.log(id);
        delid.push(licenseId)
        // parent.$('[name="notices"]').attr('src','../../notice/newAndEdit?type=edit&notifyId='+notifyId)
        layer.confirm(qued, {
            btn: [sure,cancel] ,//按钮
            title:ifDelete
        }, function(){
            //确定删除，调接口
            $.ajax({
                url: "/hr/manage/deleteHrphotos",
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
        var id=pageObj.arrs[$(this).attr('data-i')].licenseId;
        console.log(id)
        parent.$('[name="notices"]').attr('src',' /hr/manage/photoNewedit?licenseId='+id)

    })


    $('#pagediv').on('click','.editAndDelete3',function(){
        var tid=pageObj.arrs[$(this).attr('data-i')].licenseId;
        layer.confirm(qued, {
            btn: [sure,cancel] ,//按钮
            title:ifDelete
        }, function(){
            //确定删除，调接口
            $.ajax({
                url: " /hr/manage/deleteHrphotos",
                type: "get",
                data:{
                    licenseId:tid
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