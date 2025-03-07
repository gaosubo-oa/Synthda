/**
 * Created by Klous on 2018/7/3.
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

    if(type==2){
        // console.log('/notice/notifyList?'+$('#ajaxform').serialize()+'&page=1&pageSize=15&useFlag=true')
        window.location.href='/hr/manage/selectHrphotos?'+$('#ajaxform').serialize()+'&page=1&pageSize=15&export=1';
        return;
    }
    var arrs=$('#ajaxform').serializeArray()
    for(var i=0;i<arrs.length;i++){
        pageObj.data[arrs[i].name]=arrs[i].value;
    }
   // 1显示  // 2不显示  //不写fn这个属性就是全显示
    pageObj.init(" /hr/manage/selectHrphotos",[
        {name:'详细信息'},
        {name:'修改'},
        {name:del}
    ],function () {
        $('#pagediv').css('visibility','visible')
        $('.query').hide();
        $('#pagediv').show();
        $('.page-bottom-inner-layer').height(280);
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
var pageObj=null;
$(function () {

    $.ajax({  //填充状态下拉框
        type:'get',
        url:'/hr/manage/getHrCodes',
        dataType:'json',
        data:{type:'edu'},
        success:function(res){
            if(res.flag) {
                var lists = res.data;
                var render = [];
                var str='';
                // render.push("")
                for(var i=0;i<lists.length;i++){
                    // render.push("<option value=\""+lists[i].codeNo+"\">"+lists[i].codeName+"</option>");
                    str+="<option value=\""+lists[i].codeNo+"\">"+lists[i].codeName+"</option>";
                }
                $("#status").append(str);
            }

        }
    })
    $.ajax({  //填充证照类型
        type:'get',
        url:'/hr/manage/getHrCodes',
        dataType:'json',
        data:{type:'degree'},
        success:function(res){
            if(res.flag) {
                var lists = res.data;
                var str='';
                for(var i=0;i<lists.length;i++){
                    str+="<option value=\""+lists[i].codeNo+"\">"+lists[i].codeName+"</option>";
                }
                $("#licenseType").append(str);
            }

        }
    })


    $('.addroles').on("click",function () {
        user_id = $(this).siblings('textarea').prop('id');
        $.popWindow("/common/selectUser");
    })

    pageObj=$.tablePage('#pagediv','1100px',[
        {
            width:'70px',
            title:'选择',
            name:'ggghhhh',
            selectFun:function (n,obj) {
                return '<input type="checkbox" class="choose" data-id="'+obj.licenseId+'">'
            }
        },
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
            title:option
        },
    ],function (me) {
        me.data.typeId=$('[name="type"]').val();
        me.data.changeId='1';
        me.data.exportId='1';

        //1显示  // 2不显示  //不写fn这个属性就是全显示
        me.init("/hr/manage/selectHrphotos",[

            {name:'详细信息'},
            {name:'修改'},
            {name:del}
        ],function () {
            var str='<tr>' +
                 '<td style="width: 400px;text-align: center"><input type="checkbox" name="all"><span>'+notice_th_allchose+'</span></td>' +
                '<td colspan="9" style="text-align: left">' +
            '<a class="delete_check"><span style="margin-left: 27px;">删除选中内容</span></a>' +
                  '<a class="delete_all"><span style="margin-left:27px;">删除全部内容</span></a>' + '</td>' +
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


    $('#pagediv').on('click','.delete_all',function(){//删除全部
        layer.confirm(delAll, {
            btn: [sure,cancel], //按钮
            title:queding
        }, function(){
            //确定删除，调接口
            var ids =[];
            ids.push('0116')
            $.ajax({
                type:'get',
                url:' /hr/manage/deleteHrphotos',
                dataType:'json',
                data:{"ids":ids},
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
                            content:delf,
                            icon:2
                        })
                    }

                }
            })

        });
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
                url:' /hr/manage/upHrphotos',
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
                url:' /hr/manage/upHrphotos',
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
        $.popWindow("/hr/manage/photoDetail?licenseId="+ids,'证照详细信息','0','0','1150px','800px');
    })

    $('#pagediv').on('click','.editAndDelete2',function(){
        var delid = [];
        var id=pageObj.arrs[$(this).attr('data-i')].licenseId;
        delid.push(id)
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
        parent.$('[name="notices"]').attr('src','/hr/manage//photoNewedit?licenseId='+id)

    })


    $('#pagediv').on('click','.editAndDelete3',function(){
        var tid=pageObj.arrs[$(this).attr('data-i')].licenseId;
        layer.confirm(qued, {
            btn: [sure,cancel] ,//按钮
            title:ifDelete
        }, function(){
            //确定删除，调接口
            $.ajax({
                url: "/hr/manage/deleteHrphotos",
                type: "get",
                data:{
                    ids:tid
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