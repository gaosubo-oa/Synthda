/**
 * 值班管理
 * author:殷冬
 * time:2018-05-12
 * vision:1.0.0
 */

$(function () {
    var basePath=document.getElementById("basePath").value;
//表格初始化
var pageObj=$.tablePage('#pagediv','1106px',[
    {
        width:'121px',
        title:'选择',
        name:'',
        selectFun:function (n,obj) {
            return '<input type="checkbox" class="choose" data-id="'+obj.dutyId+'">'
        }
    },
    {
        width:'200px',
        title:'开始时间',
        name:'startTime'
    },
    {
        width:'200px',
        title:'结束时间',
        name:'endTime'
    },
    {
        width:'230px',
        title:'值班人员',
        name:'',
        selectFun:function (n,obj) {
            var fw="";
            var fw1="";
            var fw2="";
            if(obj.toIdStr!=null){
                if(obj.toIdStr.length<10){
                    fw+=obj.toIdStr;
                }else{
                    fw+=obj.toIdStr.substring(0,10);
                    // return fw;
                }
            }
            if(obj.privIdStr!=null&&obj.privIdStr!=undefined){
                if(obj.privIdStr.length<10){
                    fw1+=obj.privIdStr;
                }else{
                    fw1+=obj.privIdStr.substring(0,10);
                    // return fw1;
                }
            }
            if(obj.userIdStr!=null&&obj.userIdStr!=undefined){
                if(obj.userIdStr.length<10){
                    fw2+=obj.userIdStr;
                }else{
                    fw2+=obj.userIdStr.substring(0,10);
                }
            }
        var str3 =  "<div   title='"+"-部门："+obj.toIdStr+"&#13-角色："+obj.privIdStr+"&#13-人员："+obj.userIdStr+"'>"+fw+fw1+fw2+"</div>"
            return str3;
        }
    },
    {
        width:'200px',
        title:'附件',
        name:'',
        selectFun:function (n,obj) {
            var arr = new Array();
            arr = obj.attachmentList;

            if(obj.attachmentList!=null){
                if(arr.length>0){
                for (var i = 0; i < (arr.length); i++) {

                    return '<a type="javascript:;"  href="'+basePath+'download?' + encodeURI(arr[i].attUrl) + '">'+arr[i].attachName+'</a>';
                }}else{
                    return ""
                }
            }else{
                return "";
            }
        }
    },
    {
        width:'165px',
        title:option
    }
],function (me) {
    // me.data.typeId=$('[name="type"]').val();
    // me.data.changeId='1';
    // me.data.exportId='1';

    //1显示  // 2不显示  //不写fn这个属性就是全显示
    me.init("/dutyManagement/getDutyFormList?exportId=0",[
        {name:roleAuthorization_th_ViewDetails},
        {name:modify1},
        {name:del}
    ],function () {
        var str='<tr>' +
            '<td colspan="0"  style="width: 400px;text-align: center"><input type="checkbox" name="all"><span>'+notice_th_allchose+'</span></td>' +
            '<td colspan="10" style="text-align: left">' +
            '<a href="javascript:;" class="delete_check"><img src="/img/file/icon_fileDelete.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt="">删除</a>' +
            // '<a class="delete_all"><span style="margin-left:27px;">删除全部内容</span></a>' +
            '</td>' +
            '</tr>'
        $('#operation').html(str)
    })
})

    //导出
    $("#report").on("click",function(data){
        window.location.href="/dutyManagement/getDutyFormList?exportId=1";
    });

    // 事件绑定处理
    $('#pagediv').on('click','[name="all"]',function(){//全选
        console.log($('[name="type"]').val());
        if($(this).is(':checked')){
            $('#pageTbody').find('input[type=checkbox]').prop('checked',true)
        }else {
            $('#pageTbody').find('input[type=checkbox]').removeProp('checked')
        }
    })

    /**
     * 删除所选信息
     */
    $('#pagediv').on('click','.delete_check',function(){
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
                url:'/dutyManagement/delDutyFormByDutyIds',
                dataType:'json',
                data:{'dutyIds':fileId},
                success:function(data){
                   if(data){
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







    // $('#pagediv').on('click','.notice_top',function(){//置顶
    //    if($('#pageTbody').find('input[type=checkbox]:checked').length==0){
    //        $.layerMsg({content:notice_th_dj,icon:2});
    //        return;
    //    }
    //     var fileId=[];
    //     $('#pageTbody').find('input[type=checkbox]:checked').each(function(){
    //         var conId=$(this).attr("data-id");
    //         fileId.push(conId);
    //     })
    //     layer.confirm(ConfirmTop, {
    //         btn: [sure,cancel], //按钮
    //         title:SetTop
    //     }, function(){
    //
    //             $.ajax({
    //                 type:'post',
    //                 url:'/notice/updateByIds',
    //                 dataType:'json',
    //                 data:{
    //                     notifyIds:fileId,
    //                     top:'1'
    //                 },
    //                 success:function(json){
    //                     if(json.flag) {
    //                         $.layerMsg({content: TopSuccess, icon: 1}, function () {
    //                             pageObj.init();
    //                         })
    //                     }else {
    //                         $.layerMsg({content: TopFailure, icon: 2})
    //                     }
    //
    //                 }
    //             })
    //
    //         });
    // })
    //
    //
    //
    // $('#pagediv').on('click','.notice_notop',function(){//取消置顶
    //     if($('#pageTbody').find('input[type=checkbox]:checked').length==0){
    //         $.layerMsg({content:notice_th_dj,icon:2});
    //         return;
    //     }
    //     var fileId=[];
    //     $('#pageTbody').find('input[type=checkbox]:checked').each(function(){
    //         var conId=$(this).attr("data-id");
    //         fileId.push(conId);
    //     })
    //     layer.confirm(notice_th_dd, {
    //         btn: [sure,cancel], //按钮
    //         title:notice_th_Determine
    //     }, function(){
    //         $.ajax({
    //             type:'post',
    //             url:'/notice/updateByIds',
    //             dataType:'json',
    //             data:{
    //                 notifyIds:fileId,
    //                 top:'0'
    //             },
    //             success:function(json){
    //                 if(json.flag) {
    //                     $.layerMsg({content: notice_th_CancelTopSuccess, icon: 1}, function () {
    //                         pageObj.init();
    //                     })
    //                 }else {
    //                     $.layerMsg({content: notice_th_CancelTopF, icon: 2})
    //                 }
    //
    //             }
    //         })
    //
    //     });
    // })









    $('#pagediv').on('click','.editAndDelete0',function(){
        var dutyId=pageObj.arrs[$(this).attr('data-i')].dutyId;
        $.popWindow("returnSelDutyFormManagement?dutyId="+dutyId,situation,'0','0','1200px','600px');
    })

    $('#pagediv').on('click','.editAndDelete1',function(){
        var dutyId=pageObj.arrs[$(this).attr('data-i')].dutyId;
        parent.$('[name="notices"]').attr('src','../../dutyManagement/dutyFormManagementAdd?dutyId='+dutyId)
    })


    $('#pagediv').on('click','.editAndDelete2',function(){
        var dutyId=pageObj.arrs[$(this).attr('data-i')].dutyId;
        layer.open({
            type: 1,
            title: ['提示','background-color:#2e8ded;color:#fff'],
            content:'<div style="text-align: center;margin-top: 18px;">确认删除吗？</div>',
            area: ['200px', '160px'],
            btn: ['确认','取消'],
            yes:function(index){
                $.ajax({
                    url:'/dutyManagement/delDutyFormById',
                    type:'post',
                    data:{
                        'dutyId':dutyId,
                    },
                    dataType:'json',

                    success:function(res){
                        layer.close(index)
                        if(res){
                            layer.msg("删除成功",{
                                icon: 1,
                                time: 1500 //2秒关闭（如果不配置，默认是3秒）
                            },function(){
                                pageObj.init()
                            })
                        }else {
                            layer.msg("删除失败",{
                                icon: 2,
                                time: 1500 //2秒关闭（如果不配置，默认是3秒）
                            },function(){
                                pageObj.init()
                            })
                        }
                    }
                })
            },
            btn2: function (index) {
                layer.close(index)
            }

        })
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