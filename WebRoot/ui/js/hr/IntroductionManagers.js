/**
 * Created by ilous on 2018/8/7.
 */
var type = $.GetRequest().type;
var userId = $.GetRequest().userId;
var dept_id;
var tel;
var id;
var auditState=2;
var userPriv;//当前登录人的角色ID
var userId;// 当前登录人的userId
function checkInner(object) {
    if (object == "" || typeof (object) == "undefined") {
        return ""
    } else {
        return object
    }
}
function checkState(userPriv,obj) {
    if ((userPriv == 3 && obj.auditState== 1)||(userPriv == 5 && obj.auditState=== 2)||(userPriv == 2 && obj.auditState=== 3)||(userPriv == 1 && obj.auditState=== 4)) {
        return "<button type='button' class='layui-btn layui-btn-sm stateyes' tel='" + obj.staffPhone +"'  id='" + obj.id + "' state='"+obj.auditState+"'>审核通过</button><button type='button' class='layui-btn layui-btn-sm stateyes' tel='" + obj.staffPhone +"'  id='" + obj.id + "' state='"+obj.auditState+"'>驳回</button>"
    } else {
        return ''
    }
}
function  checkAudit(auditState) {

    if (auditState == 1) {
        return '<span style="text-align: center;">提交离职申请</span>';
    // } else if (auditState== 2) {
    //     return '<span style="text-align: center;">采销经理审核通过</span>';
    // } else if (auditState == 3) {
    //     return '<span style="text-align: center;">部门经理审核通过</span>';
    // } else if (auditState== 4) {
    //     return '<span style="text-align: center;">部门助理审核通过</span>';
    } else if (auditState== 5) {
        return '<span style="text-align: center;">管理员审核通过</span>';
    } else if (auditState== 6) {
        return '<span style="text-align: center;">离职申请退回</span>';
    // } else if (auditState== 7) {
    //     return '<span style="text-align: center;">商企赋能部审核通过</span>';
    // } else if (auditState== '2,8'){
    //     return '<span style="text-align: center;color: red">采销经理审核不通过</span>';
    // } else if (auditState== '3,8'){
    //     return '<span style="text-align: center;color: red">部门经理审核不通过</span>';
    // } else if (auditState== '4,8'){
    //     return '<span style="text-align: center;color: red">部门助理审核不通过</span>';
    // } else if (auditState== '5,8'){
    //     return '<span style="text-align: center;color: red">合同审核管理员审核不通过</span>';
    // } else if (auditState== '6,8'){
    //     return '<span style="text-align: center;color: red">人事管理员审核不通过</span>';
    // } else if (auditState== '7,8'){
    //     return '<span style="text-align: center;color: red">商企赋能部审核不通过</span>';
    // }else if(auditState== '8'){
    //     return '<span style="text-align: center;color: red">审核不通过</span>';
    }else {
        return '<span style="text-align: center;"></span>';
    }

}
function ajaxTable(datt) {
    ajaxPageLe = {
        data: {
            page: 1,//当前处于第几页
            pageSize: 10,//一页显示几条
            useFlag: true
        },
        page: function () {
            var me = this;
            $.ajax({
                url: '/personManagement/IntroductionManagerInfo',
                type: 'get',
                data: {
                    page: me.data.page,
                    pageSize: me.data.pageSize,
                    useFlag: me.data.useFlag,
                    staffName:$('#staffName').val(),
                    auditState:$('#status').val()
                },
                dataType: 'json',
                success: function (res) {
                    var str = "";
                    userPriv=res.object.userPriv;
                    userId=res.object.userId;
                    if(res.obj.length>0) {
                        for (var x = 0; x < res.obj.length; x++) {

                            // auditStateNo = checkInner(res.object[x]["isReport"]);
                            str += " <tr>\n" +
                                // "<td style='width:3%' class='checkWrap description'><input type='checkbox' name='chkItem' class='kx'></td>\n" +
                                // "<td style='width:18%' class='to_detail description' title=" + checkInner(res.obj[x]['locationQ']) + checkInner(res.obj[x]['locationX']) + checkInner(res.obj[x]['locationStreet']) + checkInner(res.obj[x]['position']) + " uuid=" + checkInner(res.obj[x]["uuid"]) + " data-id=" + res.obj[x]["premId"] + "><a href='#'>" + checkInner(res.object[x]["locationQ"]) + checkInner(res.object[x]["locationX"]) + checkInner(res.object[x]["locationStreet"]) + checkInner(res.object[x]["position"]) + "</a></td>\n" +
                                "<td style='width:5%' class='description' title=" + checkInner(res.obj[x]["staffName"]) + ">" + checkInner(res.obj[x]["staffName"]) + "</td>\n" +
                                "<td style='width:5%' class='description' title=" + checkInner(res.obj[x]["workJob"]) + ">" + checkInner(res.obj[x]["workJobName"]) + "</td>\n" +
                                "<td style='width:8%'>" + checkInner(res.obj[x]["datesEmployed"]) + "</td>\n" +
                                "<td style='width:11%'>" + checkInner(res.obj[x]["staffEmail"]) + "</td>\n" +
                                "<td style='width:8%;text-align: center'>" + checkAudit(res.obj[x]["auditState"])
                                + "</td>\n" +
                                "<td style='width:100px;text-align: left'><button type='button' class='layui-btn layui-btn-sm stateinfo'  id='" + res.obj[x]['id'] + "' style=''>查看</button>&nbsp;&nbsp;" /*+ checkState(userPriv, res.obj[x])*/
                                + function () {
                                    //     if ((userPriv == 3 && res.obj[x]["auditState"]== 1)||(userPriv == 5 && res.obj[x]["auditState"]=== 2)||(userPriv == 2 && res.obj[x]["auditState"]=== 3)||(userPriv == 1 && res.obj[x]["auditState"]=== 4)) {
                                    //  if (userPriv == 1 && res.obj[x]["auditState"]== 4) {
                                    // if ((userPriv == 5 && res.obj[x]["auditState"] == 1) || (userPriv == 4 && res.obj[x]["auditState"] == 2) || (userPriv == 2 && res.obj[x]["auditState"] == 3) || (userPriv == 1 && res.obj[x]["auditState"] == 4) || (userPriv == 3 && res.obj[x]["auditState"] == 2)) {
                                    if ((userPriv == 6 && res.obj[x].auditState == 1) || (userPriv == 4 && res.obj[x].auditState == 2) || (userPriv == 5 && res.obj[x].auditState == 3) || (userPriv == 10 && res.obj[x].auditState == 4)|| (userPriv == 2 && res.obj[x].auditState == 5)|| (userId== 152 && res.obj[x].auditState == 6)) {
                                        return "<button type='button' class='layui-btn layui-btn-sm stateyes' tel='" + res.obj[x]["staffPhone"] + "'  id='" + res.obj[x]["id"] + "' state='" + res.obj[x]["auditState"] + "'  deptId='" + res.obj[x]["deptId"] + "'>审核通过</button>" +
                                            "<button type='button' class='layui-btn layui-btn-sm stateno' tel='" + res.obj[x]["staffPhone"] + "'  id='" + res.obj[x]["id"] + "' state='" + res.obj[x]["auditState"] + "'>驳回</button>"
                                    } else {
                                        return ''
                                    }
                                }()
                            "</td></tr>"
                        }
                    }
                    else{
                        str+='<div style="margin-left: 500px;margin-top: 80px"><div><img style="margin-bottom: 20px;" src="/img/main_img/shouyekong.png" alt="" style=""></div> <div style="border-radius: 0.12rem;font-size: .28rem;float:left;text-align: center;height: .7rem;color: #2F5C8F;margin-left: 20px">暂无数据！</div></div>'
                        $('.right').hide();
                    }
                    $("#j_tb").html(str);

                    me.pageTwo(res.totleNum, me.data.pageSize, me.data.page);
                }
            })

        },
        pageTwo: function (totalData, pageSize, indexs) {
            var mes = this;
            $('#dbgz_page').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage: '',
                endPage: '',
                current: indexs || 1,
                callback: function (index) {
                    mes.data.page = index.getCurrent();
                    mes.page();
                }
            });
        }
    };
    ajaxPageLe.page();
}
$(function () {
    //表格初始化
    ajaxTable();
    // 查询
    $('#searchBtn').on("click",function () {
        ajaxTable();
    })
})


// 事件绑定处理
$('#pagediv').on('click', '[name="all"]', function () {//全选
    if ($(this).is(':checked')) {
        $('#pageTbody').find('input[type=checkbox]').prop('checked', true)
    } else {
        $('#pageTbody').find('input[type=checkbox]').removeProp('checked')
    }
})


$('#pagediv').on('click', '.delete_check', function () {//删除
    if ($('#pageTbody').find('input[type=checkbox]:checked').length == 0) {
        $.layerMsg({content: '请先选择内容', icon: 2});
        return;
    }
    var fileId = [];
    $('#pageTbody').find('input[type=checkbox]:checked').each(function () {
        var conId = $(this).attr("data-id");
        fileId.push(conId);
    })

    layer.confirm(qued, {
        btn: [sure, cancel], //按钮
        title: queding
    }, function () {
        $.ajax({
            type: 'post',
            url: '/hr/leave/leaveDelete',
            dataType: 'json',
            data: {'leaveId': fileId},
            success: function (json) {
                if (json.flag) {
                    $.layerMsg({
                        content: delc,
                        icon: 1
                    }, function () {
                        pageObj.init()
                    })
                } else {
                    $.layerMsg({
                        content: delf, icon: 2
                    })
                }
            }
        })

    });
})

$(document).on('click', '.stateinfo', function () {
    var id = $(this).attr('id');
    var tel = $(this).attr('tel');
    $.popWindow("/personManagement/newIntroduction?id=" + id+'&type=detail', '员工入职信息', '0', '0', '1200px', '600px');
})
$(document).on('click', '.stateyes', function () {
    id = $(this).attr('id');
    // var state=$(this).attr('state');
    //   var data1=$(this).attr('data');
    tel = $(this).attr('tel');
    var deptId=$(this).attr('deptId');
    var state=$(this).attr('state');
    $.ajax({
        url: "/hr/staffEntry/auditUpdate",
        type: "get",
        data:{
            'auditState':Number(state)+Number(1),
            id:id,
            //   deptId:deptId
            //  deptId:4
        },
        dataType: 'json',
        success: function (res) {
            if (res.flag) {
                layer.msg(res.msg,{icon:6},function () {
                    ajaxPageLe.page();
                })
            }
            else {
                layer.msg(res.msg,{icon:5},function () {
                    ajaxPageLe.page();
                    //opener.pageObj.init()
                    // parent.pageObj.init()
                })
            }
        },
        error:function () {
            layer.msg(res.msg,{icon:5},function () {
                //opener.pageObj.init()
                ajaxPageLe.page();
            })
        }

    })
    //if(state==4){
    // $.popWindow("../common/selectDept?introduction=true");
    /*
     $.ajax({
     url: "/hr/staffEntry/auditUpdate",
     type: "get",
     data:{
     'auditState':2,
     id:id,
     tel:tel

     },
     dataType: 'json',
     success: function (res) {
     if (res.flag) {
     layer.msg(res.msg,{icon:6},function () {
     pageObj.init()
     })
     }
     else {
     layer.msg(res.msg,{icon:5},function () {
     // pageObj.init()
     })
     }
     }
     })
     */
    //$.popWindow("DimissionDetail?ids="+ids,'员工入职详细信息','0','0','1200px','600px');
    // }
})
$(document).on('click', '.stateno', function () {
    var id = $(this).attr('id');
    var tel = $(this).attr('tel');
    layer.open({
        content: '确定退回？',
        btn: ['确定', '取消'],
        yes: function (index, layero) {
            layer.open({
                type: 1,
                title: '退回原因',
                //skin: 'layui-layer-rim', //加上边框
                area: ['690px', '400px'], //宽高
                btn: ['确定'], //按钮
                content: '<textarea style="width:600px;margin: 40px;height: 210px" name="university" id="university" cols="84" rows="4" class="BigInput" value=""></textarea>',
                yes: function (index) {
                    if(userPriv=='6'){
                        user=2
                    }
                    else if(userPriv=='4'){
                        user=3
                    }
                    else if(userPriv=='5'){
                        user=4
                    }
                    else if(userPriv=='10'){
                        user=5
                    }else if(userPriv=='2'){
                        user=6
                    }else if(userId=='152'){
                        user=7
                    }
                    $.ajax({
                        url: '/hr/staffEntry/auditUpdate',
                        type: 'get',
                        data: {
                            'auditState': user+','+8,
                            id: id,
                            deptId: null,
                            msg: $('#university').val()
                        },
                        dataType: 'json',
                        success: function (res) {
                            layer.close(index);
                            if (res.flag) {
                                layer.msg(res.msg, {icon: 6}, function () {
                                    ajaxPageLe.page();
                                })
                            } else {
                                layer.msg(res.msg, {icon: 5}, function () {
                                    ajaxPageLe.page();
                                })
                            }
                        }
                    })
                }
            });


        }
        , btn2: function (index, layero) {
            layer.closeAll();
            //return false 开启该代码可禁止点击该按钮关闭
        }
        , cancel: function () {
            //右上角关闭回调
            //return false 开启该代码可禁止点击该按钮关闭
        }
    });
    //  $.popWindow("DimissionDetail?ids="+ids,'员工入职详细信息','0','0','1200px','600px');
})
$('#pagediv').on('click', '.editAndDelete2', function () {
    var id = pageObj.arrs[$(this).attr('data-i')].leaveId;
    // parent.$('[name="notices"]').attr('src','../../notice/newAndEdit?type=edit&notifyId='+notifyId)
    layer.confirm(qued, {
        btn: [sure, cancel],//按钮
        title: ifDelete
    }, function () {
        //确定删除，调接口
        $.ajax({
            url: "/hr/leave/leaveDelete",
            type: "get",
            data: {
                'leaveId[]': id
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

    }, function () {
        layer.closeAll();
    });
})


$('#pagediv').on('click', '.editAndDelete1', function () {
    var me = this;
    var id = pageObj.arrs[$(this).attr('data-i')].leaveId;
    if (type != undefined) {
        parent.$('[name="notices"]').attr('src', '/dimission/newDimission?type=1&userId="' + userId + '"&id=' + id)
    } else {
        parent.$('[name="notices"]').attr('src', '/dimission/newDimission?id=' + id)
    }


})


$('#pagediv').on('click', '.editAndDelete3', function () {
    var tid = pageObj.arrs[$(this).attr('data-i')].notifyId;
    layer.confirm(qued, {
        btn: [sure, cancel],//按钮
        title: ifDelete
    }, function () {
        //确定删除，调接口
        $.ajax({
            url: "/notice/deleteById",
            type: "get",
            data: {
                notifyId: tid
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

    }, function () {
        layer.closeAll();
    });
})

$('.submit').on("click",function () {
    pageObj.data.read = '';
    pageObj.data.typeId = $('[name="type"]').val();
    pageObj.data.changeId = '1';
    pageObj.data.exportId = '1';
    pageObj.init()
})

$('#pagediv').on('mouseover', '.toTypeName', function () {
    var obi = pageObj.arrs[$(this).attr('data-i')];

    layer.tips(userManagement_th_department + '：' + obi.deprange + '<br/>' +
        journal_th_user + '：' + obi.userrange + '<br/>' +
        userManagement_th_role + '：' + obi.rolerange + '', this, {
        tips: [1, '#3595CC'],
        time: 1000
    });
})