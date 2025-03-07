$(function() {
    showMenus($('#ulList table'))
    //下一级菜单
    $('#ulList').on('click', '.nextRank', function () {
        var dataType=$(this).attr('dataType')
        $('.divP span').html('')
        $('.menuTitle').html(dataType)
        $(this).addClass('refresh').parents('tr').siblings().find('.nextRank').removeClass('refresh');
        $('.monoidalSet').show().siblings().hide();
        var id = $(this).parents('tr').attr('childId');
        twoLevelMenu(id, $('.childMenu'));

    })
    //一级菜单编辑
    $('#ulList').on('click', '.editOne', function () {
        $('.divP span').html('')
        // $('.editClass').show().siblings().hide();
        $('.editClass').show();
        $('.editClass').show().siblings('div').hide()
        var id = $(this).parents('tr').attr('childId');
        editOneLevelMenu(id)
    })
    //一级菜单编辑确定按钮
    $('#btn1').click(function () {
        editSave()
    })
    //一级菜单编辑返回按钮
    $('#btn2').click(function () {
        $('input[name="mainId"]').val('');
        $('input[name="mainName"]').val('');
        $('input[name="mainName1"]').val('');
        $('input[name="mainName2"]').val('');
        $('input[name="mainName3"]').val('');
        $('input[name="mainName4"]').val('');
        $('input[name="mainName5"]').val('');
        $('input[name="mainImg"]').val('');
        $('.addClass').show().siblings().hide();
    });




    //增加一级菜单主分类显示
    $('#Addspan').click(function () {
        $('.addClass').show().siblings().hide();
    })
    $('.spanUP').click(function () {
        $('.divUP').find('.spanUP').removeClass('on');
        $(this).addClass('on');
    })
    //增加一级菜单确定按钮
    $('#addBtn').click(function () {
        AddClassA();
    })
    //增加一级菜单返回按钮
    $('#backBtn').click(function () {
        $('input[name="id"]').val('');
        $('input[name="name"]').val('');
        $('input[name="name1"]').val('');
        $('input[name="name2"]').val('');
        $('input[name="name3"]').val('');
        $('input[name="name4"]').val('');
        $('input[name="name5"]').val('');
        $('input[name="img"]').val('');
    })
    //删除一级菜单
    $('#ulList').on('click', '.deleteMenu', function () {
        var id = $(this).parents('tr').attr('childId');
        deleteMenu(event,id);
    })
    //子菜单项设置返回按钮
    $('#childrenBtn').click(function () {
        $('.addClass').show().siblings().hide();
    })
    //新建子菜单
    $('#childBtn').click(function () {
        $('.AddChild').show().siblings().hide();
        var id = $('.refresh').parents('tr').attr('childId')
        getChildId(id)
    })
    //新建子菜单确定按钮
    $('#btn_sure').click(function () {
        var id = $('.refresh').parents('tr').attr('childId')
        addChildMenu(id, $('.childMenu'));
    })
    //新建子菜单返回按钮
    $('#btn_back').click(function () {
        $('.monoidalSet').show().siblings().hide();
    })
    //子菜单编辑
    $('.tab').on('click', '.editChilds', function () {
        $('.editChild').show().siblings().hide();
        var id = $(this).parents('tr').attr('childernId');
        var len = id.length;
        var pId = id.substr(0, len - 2);
        editChildMenu(id);
        editParentId(pId);
    })
    //子菜单编辑确定按钮
    $('#edBtn_sure').click(function () {
        var id = $('.refresh').parents('tr').attr('childId');
        saveChildEdit(id, $('.childMenu'));
    })
    //子菜单编辑返回按钮
    $('#edBtn_back').click(function () {
        $('.monoidalSet').show().siblings().hide();
    })
    //子菜单删除
    $('.tab').on('click', '.deleteChild', function () {
        var Eid = $(this).parents('tr').attr('childernId');
        var id = $('.refresh').parents('tr').attr('childId');
        deleteChildMenu(event,Eid, id, $('.childMenu'));
    })
    //添加权限点击事件
    $('.tab').on('click', '.addJurisdition', function () {
        var id = $(this).parents('tr').attr('fid');
        $('input[name="addJurisd"]').val(id);
        $('.addJurisd').show().siblings().hide();
        authorizationPriv(id, $('#PRIV'));
        authorizationUser(id, $('#USER'));
    })
    //删除权限点击事件
    $('.tab').on('click', '.deleteJurisdition', function () {
        var id = $(this).parents('tr').attr('fid');
        $('input[name="deleteJurisd"]').val(id);
        $('.deleteJurisd').show().siblings().hide();
        authorizationPriv(id, $('#deletePRIV'));
        authorizationUser(id, $('#deleteUSER'));
    })
    //删除权限确定点击事件
    $('#deleteBtn_sure').click(function () {
        var privid = $('#deletePrivDuser').attr('userpriv');
        var userid = $('#deleteSenduser').attr('user_id');
        if (!privid && userid == 'id') {
            $.layerMsg({content: choose2, icon: 0}, function () {
            });
        } else if (!privid) {
            deleteAuthorizationUser();
        } else if (userid == 'id') {
            deleteAuthorizationPriv();
        } else {
            deleteAuthorizationPriv();
            deleteAuthorizationUser();
        }

    })
    //添加权限确定点击事件
    $('#addBtn_sure').click(function () {
        var privid = $('#privDuser').attr('userpriv');//角色
        var userid = $('#senduser').attr('user_id');//人员
        // console.log("角色"+privid)
        // console.log("人员"+userid)
        if (privid==undefined&& userid == 'id') {
            $.layerMsg({content: choose2, icon: 0}, function () {
            });
        } else if (privid==undefined&& userid!='id') {
            addAuthorizationUser();
        } else if (userid == 'id'&&privid!=undefined) {
            addAuthorizationPriv()
        } else if(privid!=undefined&& userid != 'id') {
            addAuthorizationPriv();
            addAuthorizationUser();
        }
    })
    //添加权限返回按钮点击事件
    $('#addBtn_back').click(function () {
        var id = $('.refresh').parents('tr').attr('childId');
        $('#privDuser').val('');
        $('#senduser').val('');
        $('.monoidalSet').show().siblings().hide();
        twoLevelMenu(id, $('.childMenu'));
    })
    //删除权限返回按钮点击事件
    $('#deleteBtn_back').click(function () {
        var id = $('.refresh').parents('tr').attr('childId');
        $('#deletePrivDuser').val('');
        $('#deleteSenduser').val('');
        $('.monoidalSet').show().siblings().hide();
        twoLevelMenu(id, $('.childMenu'));
    })

    //正在开发的
    $('.hidden').click(function () {
        //alert('123');
        $('.hideDome').show().siblings().hide();
    })

    function AddClassA() {
        var data = {
            'id': $('input[name="id"]').val(),
            'name': $('input[name="name"]').val(),
            'name1': $('input[name="name1"]').val(),
            'name2': $('input[name="name2"]').val(),
            'img': $('input[name="img"]').val(),
            'name3': $('input[name="name3"]').val(),
            'name4': $('input[name="name4"]').val(),
            'name5': $('input[name="name5"]').val(),
        }
        var reg = /^\d{2}$/;
        var valId = reg.test($('input[name="id"]').val());
        if (!valId) {
            alert(retype);
            return;
        }
        $.ajax({
            type: 'get',
            url: '../addSysMenu',
            dataType: 'json',
            data: data,
            success: function (rsp) {
                if (rsp.flag == true) {
                    $.layerMsg({content: Newsuccess, icon: 1}, function () {
                        location.reload();
                    });
                } else {
                    $.layerMsg({content: rsp.msg, icon: 2,time:2000,}, function () {
                    });
                }
            }
        })
    }
var id1
    function editOneLevelMenu(id) {
        $.ajax({
            type: 'get',
            url: '../../getTheFirstMenu',
            dataType: 'json',
            data: {'id': id},
                success: function (rsp) {
                var data1 = rsp.object;
                id1=data1.id
                var span=$('<span>'+edtiMenu+'</span>')
                $('.editClass input[name="mainId"]').val('');
                $('.editClass input[name="mainName"]').val('');
                $('.editClass input[name="mainName1"]').val('');
                $('.editClass input[name="mainName2"]').val('');
                $('.editClass input[name="mainImg"]').val('');
                $('.editClass input[name="mainName3"]').val('');
                $('.editClass input[name="mainName4"]').val('');
                $('.editClass input[name="mainName5"]').val('');

                $('.divP img').after(span)
                $('.editClass input[name="mainId"]').val(data1.id);
                $('.editClass input[name="mainName"]').val(data1.name);
                $('.editClass input[name="mainName1"]').val(data1.name1);
                $('.editClass input[name="mainName2"]').val(data1.name2);
                $('.editClass input[name="mainName3"]').val(data1.name3);
                $('.editClass input[name="mainName4"]').val(data1.name4);
                $('.editClass input[name="mainName5"]').val(data1.name5);
                $('.editClass input[name="mainImg"]').val(data1.img);
            }
        })
    }

    function editSave() {
        var data = {
            id:id1,
            'newId': $('input[name="mainId"]').val(),
            'name': $('input[name="mainName"]').val(),
            'name1': $('input[name="mainName1"]').val(),
            'name2': $('input[name="mainName2"]').val(),
            'name3': $('input[name="mainName3"]').val(),
            'name4': $('input[name="mainName4"]').val(),
            'name5': $('input[name="mainName5"]').val(),
            'img': $('input[name="mainImg"]').val()
        }
        $.ajax({
            type: 'get',
            url: '../updateFirstMenu',
            dataType: 'json',
            data: data,
            success: function (rsp) {
                if (rsp.flag == true) {
                    $.layerMsg({content:menuSSetting_th_editSuccess, icon: 1}, function () {
                        location.reload();
                    });
                } else {
                    $.layerMsg({content: rsp.msg, icon: 2,time:2000,}, function () {
                    });
                }
            }
        })
    }

    function saveChildEdit(id, element) {
        var data = {
            'fId': $('.editChild input[name="editfId"]').val(),
            'parentId': $('.editChild select[name="editParentId"] option:checked').val(),
            'id': $('.editChild input[name="editId"]').val(),
            'name': $('.editChild input[name="editName"]').val(),
            'url': $('.editChild input[name="editUrl"]').val(),
            'isopenNew':$('#editChecked').val(),
            'sendUser': $('.editChild select[name="editSendUser"] option:checked').val(),
            'sendKey': $('.editChild input[name="editSendKey"]').val(),
            'isShowFunc':$('.editChild input[name="isShowFunc"]:checked').val()
        }
        $.ajax({
            type: 'post',
            url: '../editSysFunction',
            dataType: 'json',
            data: data,
            success: function (rsp) {
                if (rsp.flag == true) {
                    $.layerMsg({content: menuSSetting_th_editSuccess, icon: 1}, function () {
                        $('.monoidalSet').show().siblings().hide();
                        twoLevelMenu(id, element);
                    });
                } else {
                    $.layerMsg({content:editFail, icon: 2}, function () {
                        $('.monoidalSet').show().siblings().hide();
                        twoLevelMenu(id, element);
                    });
                }
                // $('.monoidalSet').show().siblings().hide();
                // twoLevelMenu(id,element);
            }

        })

    }

    function addChildMenu(id, element) {
        var data = {
            'fId': $('input[name="addfId"]').val(),
            'parentId': $('select[name="addParentId"] option:checked').val(),
            'id': $('input[name="addId"]').val(),
            'name': $('input[name="addName"]').val(),
            'url': $('input[name="addUrl"]').val(),
            'isopenNew': $('#newChecked').val(),
            'sendUser': $('select[name="sendUser"] option:checked').val(),
            'sendKey': $('input[name="sendKey"]').val(),
            'isShowFunc': $('input[name="addisShowFunc"]:checked').val()
        }
        var reg = /^\d{2}$/;
        var valId = reg.test($('input[name="addId"]').val());
        if (valId) {
            $.ajax({
                type: 'post',
                url: '../addFunction',
                dataType: 'json',
                data: data,
                success: function (rsp) {
                    if (rsp.flag == true) {
                        $.layerMsg({content: depatement_th_Newsuccessfully, icon: 1}, function () {
                            $('.monoidalSet').show().siblings().hide();
                            twoLevelMenu(id, element);
                        });
                    } else {
                        $.layerMsg({content: depatement_th_Newfailed, icon: 2}, function () {
                            $('.monoidalSet').show().siblings().hide();
                            twoLevelMenu(id, element);
                        });
                    }
                    // $('.monoidalSet').show().siblings().hide();
                    // twoLevelMenu(id,element);
                }
            })
        } else {
            $.layerMsg({content: "输入字段不符合，重新输入", icon: 0}, function () {
                return false;
            });
        }

    }

    function editChildMenu(id) {
        $.ajax({
            type: 'get',
            url: '../findChildMenu',
            dataType: 'json',
            data: {'id': id},
            success: function (rsp) {
                var data1 = rsp.obj;
                $('.editChild input[name="editfId"]').val('');

                $('.editChild input[name="editId"]').val('');
                $('.editChild input[name="editName"]').val('');
                $('.editChild input[name="editUrl"]').val('');
                $('.editChild input[name="editSendKey"]').val('');
                if(data1[0].isopenNew == '1'){
                    $('#editChecked').prop('checked',true);
                }else{
                    $('#editChecked').prop('checked',false);
                }
                if(data1[0].isShowFunc == '0'){
                    $('.editChild input[name="isShowFunc"]').eq(0).prop('checked',true);
                }else{
                    $('.editChild input[name="isShowFunc"]').eq(1).prop('checked',true);
                }
                for (var i = 0; i < data1.length; i++) {
                    var chId = data1[i].id;
                    var nId = chId.substr(-2);
                    $('.editChild input[name="editfId"]').val(data1[i].fId);

                    $('.editChild input[name="editId"]').val(nId);
                    $('.editChild input[name="editName"]').val(data1[i].name);
                    $('.editChild input[name="editUrl"]').val(data1[i].url);
                    $('#editSendUser').val(data1[i].sendUser);
                    $('.editChild input[name="editSendKey"]').val(data1[i].sendKey);
                    $('#editChecked').val(data1[i].isopenNew);
                }
            }
        })
    }

    function editParentId(pId) {
        $.ajax({
            type: 'get',
            url: '../getTheFirstMenu',
            dataType: 'json',
            data: {'id': pId},
            success: function (rsp) {
                var data2 = rsp.object;
              //  $('.editChild select[name="editParentId"] option:checked').html('');
             //   $('.editChild select[name="editParentId"] option:checked').html(data2.name);
               // $('.editChild select[name="editParentId"] option:checked').val(pId);
                  $('[name="editParentId"]').val(pId)
            }
        })
    }

    function deleteChildMenu(event,Eid, id, element) {
        if(document.all){  //只有ie识别
            event.cancelBubble=true;
        }else{
            event.stopPropagation();
        }
        layer.confirm(delete7, {
            btn: [sure,cancel], //按钮
            title:Deletemenu
        }, function(index){
            //确定删除，调接口
            layer.confirm(content1, {
                btn: [sure,cancel], //按钮
                title:Deletemenu
            }, function(){
                //确定删除，调接口
                $.ajax({
                    type: 'get',
                    url: '../deleteSysMenu',
                    dataType: 'json',
                    data: {'id': Eid},
                    success: function () {
                        $('.monoidalSet').show().siblings().hide();
                        twoLevelMenu(id, element);
                    }
                })
                layer.closeAll();
            }, function(){
                layer.closeAll();
            });
        }, function(index){
            layer.close(index);
            //layer.closeAll();
        });

        // var msg = '确认删除？';
        // if (confirm(msg) == true) {
        //     $.layerConfirm({content: '您确定要删除吗？', title: '确定删除', icon: 0}, function () {
        //         $.ajax({
        //             type: 'get',
        //             url: '../deleteSysMenu',
        //             dataType: 'json',
        //             data: {'id': Eid},
        //             success: function () {
        //                 $('.monoidalSet').show().siblings().hide();
        //                 twoLevelMenu(id, element);
        //             }
        //         })
        //         return true;
        //         // }else{
        //     }, function () {
        //         return false;
        //     });
        // }



    }
})

//添加角色
function addAuthorizationPriv() {
    var privid = $('#privDuser').attr('userpriv');
    /*var id=$('.tab .addJurisdition').parents('tr').attr('fid');*/
    var id = $('input[name="addJurisd"]').val();
    $.ajax({
        type: 'post',
        url: '../updateUserPrivfuncIdStr',
        dataType: 'json',
        data: {'privids': privid, 'funcId': id},
        success: function (res) {
            //console.log(res.msg);

            if (res.flag) {
                $.layerMsg({content: "添加角色成功", icon: 1});
                $('#privDuser').val('');
                $('#privDuser').attr('userpriv','');
                $('#privDuser').attr('privid','');
                authorizationPriv(id,$('#PRIV'));
            } else {
                $.layerMsg({content:"添加角色失败", icon: 2}, function () {

                });
            }
        }
    })
}


//添加人员
function addAuthorizationUser() {
    var userid = $('#senduser').attr('user_id');


    /* var id=$('.tab .addJurisdition').parents('tr').attr('fid');*/
    var id = $('input[name="addJurisd"]').val();


    $.ajax({
        type: 'post',
        url: '../updateAuthUser',
        dataType: 'json',
        data: {'uids': userid, 'fid': id},
        success: function (res) {
            //console.log(res.msg);
            if (res.flag) {
                $.layerMsg({content: "添加人员成功", icon: 1});
                $('#senduser').val('');
                $('#senduser').attr('user_id','');
                $('#senduser').attr('username','');
                $('#senduser').attr('dataid','');
                $('#senduser').attr('userprivname','');
                authorizationUser(id,$('#USER'));
            } else {
                $.layerMsg({content:"添加人员失败", icon: 2}, function () {
                });
            }
        }
    })
}

//删除角色
function deleteAuthorizationPriv() {
    var privid = $('#deletePrivDuser').attr('userpriv');
    /*var id=$('.tab .addJurisdition').parents('tr').attr('fid');*/
    var id = $('input[name="deleteJurisd"]').val();
    $.ajax({
        type: 'post',
        url: '/deleteUserPriv',
        dataType: 'json',
        data: {'privids': privid, 'funcIds': id},
        success: function (res) {
            //console.log(res.msg);
            // $.layerMsg({content:'删除成功',icon:2})
            $('#deletePrivDuser').val('').attr('privid', '').attr('userpriv', '');
            authorizationPriv(id, $('#deletePRIV'));
        }
    })
}

//删除人员
function deleteAuthorizationUser() {
    var userid = $('#deleteSenduser').attr('user_id');
    /*var id=$('.tab .addJurisdition').parents('tr').attr('fid');*/
    var id = $('input[name="deleteJurisd"]').val();
    $.ajax({
        type: 'post',
        url: '/deleteAuthUser',
        dataType: 'json',
        data: {'uIds': userid, 'fid': id},
        success: function (res) {
            //console.log(res.msg);
            // $.layerMsg({content:'删除成功',icon:2})
            $('#deleteSenduser').val('').attr('user_id', '').attr('username', '').attr('dataid', '').attr('userprivname', '');
            authorizationUser(id, $('#deleteUSER'));
        }
    })
}
//已授权范围（角色）
function authorizationPriv(id, element) {
    $.ajax({
        type: 'get',
        url: '../getAuthRoleName',
        dataTyle: 'json',
        data: {'fid': id},
        success: function (res) {
            var data = res.object||'';
            element.text(data);
        
        }
    })
}
//已授权范围（人员）
function authorizationUser(id, element) {
    /*var id=$('.tab .addJurisdition').parents('tr').attr('fid');*/
    $.ajax({
        type: 'get',
        url: '../getAuthUserName',
        dataTyle: 'json',
        data: {'fid': id},
        success: function (res) {
            var data = res.object||'';
            element.text(data);
           
        }
    })
}


function twoLevelMenu(id,element){
    $('.add_children').remove();
    $.ajax({
        type:'get',
        url:'../findChildMenu',
        dataType:'json',
        data:{'id':id},
        success:function(rsp){
            var data1=rsp.obj;
            //console.log(data1);
            var str="";
            str= queryMenu(data1,str);
            // for(var i=0;i<data1.length;i++){
            //     str+='<tr class="add_children" fid="'+data1[i].fId+'" childernId="'+data1[i].id+'"><td width="40%"><span class="margspan" style="margin: 0 10px">'+data1[i].id+'</span><span>'+data1[i].name+'</span></td><td width="59.5%"><a href="javascript:;" class="editChilds">编辑</a><a href="javascript:;" class="deleteChild">删除</a><a href="javascript:;" class="addJurisdition">添加权限</a><a href="javascript:;" class="deleteJurisdition">删除权限</a></td></tr>'
            // }

            element.after(str);
        }
    })
}

function queryMenu(data,str) {

    for(var i=0;i<data.length;i++){
        str+='<tr class="add_children" fid="'+data[i].fId+'" childernId="'+data[i].id+'"><td width="40%"><span class="margspan" style="margin: 0 10px">'+data[i].id+'</span><span>'+data[i].name+'</span></td><td width="59.5%"><a href="javascript:;" class="editChilds">'+edit1+'</a><a href="javascript:;" class="deleteChild">'+del+'</a><a href="javascript:;" class="addJurisdition">'+addPermission+'</a><a href="javascript:;" class="deleteJurisdition">'+DeletingPermissions+'</a></td></tr>'
        if(data[i].child){
            if(data[i].child.length>0){
                //console.log("im coming !")
                str = queryMenu(data[i].child,str);
            }
        }
    }
    return str;
}
function deleteMenu(event,id){
    event.stopPropagation();
    layer.confirm(delete7, {
        btn: [sure,cancel], //按钮
        title:Deletemenu
    }, function(){
        //确定删除，调接口
        layer.confirm(content1, {
            btn: [sure,cancel], //按钮
            title:Deletemenu
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'get',
                url:'../deleteSysMenu',
                dataType:'json',
                data:{'id':id},
                success:function(){
                    location.reload();
                }
            })
        }, function(){
            layer.closeAll();
        });
    }, function(index){
        layer.close(index);
        //layer.closeAll();
    });

    // var msg='确认删除？';
    // $.layerConfirm({title:'确定删除',content:'您确定要删除吗？',icon:0},function(){
    //     $.ajax({
    //         type:'get',
    //         url:'../deleteSysMenu',
    //         dataType:'json',
    //         data:{'id':id},
    //         success:function(){
    //             location.reload();
    //         }
    //     })
    //     return true;
    // },function(){
    //     return false;
    // });
}
function getChildId(id){
    $.ajax({
        type:'get',
        url:'../getMenuId',
        dataType:'json',
        success:function(res){
            var data=res.object;
            $('input[name="addfId"]').val(data);
            $('input[name="addId"]').val('');
            $('input[name="addName"]').val('');
            $('input[name="addUrl"]').val('');
            $('#menuTree').val(id);

        }
    })
}





