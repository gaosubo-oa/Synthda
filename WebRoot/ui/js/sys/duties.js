
function checkehuo(name, val) {
    if (val == '') {
        return;
    }
    $('[name="' + name + '"]').find('option').each(function(i, n) {
        if ($(this).val() == val) {
            $(this).attr('selected', 'selected')
        } else {
            $(this).removeAttr('selected', 'selected')
        }
    })
}
function getData(){
    $.get('/duties/selectUserPostList',function (json) {
        if(json.flag){
            var v=1;
            var arr=json.obj;
            var str=''
            for(var i=0;i<arr.length;i++){
                str+='<tr><td>'+ arr[i].postNo +'</td>\
                  <td>'+arr[i].postName+'</td>\
                  <td>'+arr[i].typeName+'</td>\
                  <td>'+arr[i].level+'</td>\
                  <td>'+arr[i].deptName+'</td>\
                        <td>'
                    +'<a href="javascript:void (0)" class="newsBtntwo" onclick="stoprwo(' + arr[i].postId + ')"><fmt:message code="global.lang.edit" /></a>\
                         <a href="javascript:void (0)" onclick="deleteList(' + arr[i].postId + ')"><fmt:message code="user.th.dfsfad" /><fmt:message code="global.lang.delete" /></a>\
                    </td></tr>'
            }
            $('table tbody').html(str)
        }
    })
}

//新建


$(function () {
    // ajaxPage.init()
    // ajaxPage.page()
    getData();

    $('.Query').click(function () {
        ajaxPage.data.page=1;
        ajaxPage.page()
    })
    $('#user_btn').on('click',function () {

        layer.open({
            type: 1,
            title:['<fmt:message code="main.newPosition" />', 'background-color:#2b7fe0;color:#fff;'],
            area: ['700px', '500px'],
            shadeClose: true, //点击遮罩关闭
            // btn: ['创建', '取消'],
            content:'<form id="saveRule" class="layui-form"><div class="inputlayout">' +
            '<ul>' +
            '<li class="clearfix">' +
            '<label><fmt:message code="main.titleName" /> ：</label><input type="text" name="postName" value=""><b style="padding-left: 10px;">* </b>' +
            '</li>' +
            '<li class="clearfix">' +
            '<label><fmt:message code="main.type" />：</label>' +
            ' <select style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" name="type">'+
            '<option value=""><fmt:message code="hr.th.PleaseSelect" /></option>'+
            '</select><b style="padding-left: 13px;">* </b>   ' +
            '</li>' +
            '<li class="clearfix">' +
            '<label><fmt:message code="vote.th.JobLevel" /> ：</label><input type="text" name="level" value=""><b style="padding-left: 10px;">* </b>' +
            '</li>' +
            '<li class="clearfix">' +
            '<label><fmt:message code="vote.th.number" /> ：</label><input type="text" name="postNo"><b style="padding-left: 10px;">* </b>' +
            '</li>' +
            '<li class="clearfix">' +
            '<label><fmt:message code="workflow.th.sector" />：</label>' +
            ' <select style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" name="deptId">'+
            '<option value=""><fmt:message code="hr.th.PleaseSelect" /></option>'+
            '</select>   ' +
            '</li>' +
            // '<li class="clearfix">' +
            // '<label>编制 ：</label><input type="text" name="postPlan">' +
            // '</li>' +

            '<li class="clearfix">' +
            '<label><fmt:message code="depatement.th.duty" /> ：</label><textarea name="duty" id="duty" value style="min-width: 300px;min-height:60px;"></textarea>' +
            '</li>' +
            '<li class="clearfix">' +
            '<label><fmt:message code="depatement.th.requirements" /> ：</label><textarea name="description" id="textCont" value style="min-width: 300px;min-height:60px;"></textarea>' +
            '</li>' +
            // '<input style="width: 200px; position: absolute; left: 280px;bottom: 0px;" id="fileupload" type="file" name="files[]" data-url="upload?module=userpost" multiple>'+
            '<li class="clearfix">' +
            '<label><fmt:message code="global.th.fileup" />：</label>' +
            '<div>'+
            '<div class="attmend"></div>'+
            '<form id="uploadimgform" target="uploadiframe"  action="/upload?module=seal"  method="post" >'+
            '<input type="file" multiple="multiple" name="file" id="uploadinputimg"  class="w-icon5" style="opacity: 0;width: 70px;'+
            'filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">'+
            '<a href="#" id="uploadimg"><img style="margin-right:5px;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>'+
            '</form>'+
            '</div>'+
            '</li>' +
            '</ul>' +
            '</div></form>',
            btn: ['<fmt:message code="global.lang.save" />','<fmt:message code="depatement.th.quxiao" />'],
            btn1: function (index) {
                if ($('[name="postName"]').val() == "") {
                    $.layerMsg({ content: '<fmt:message code="depatement.th.adfg" />', icon: 2 });
                    return false;
                };
                if ($('[name="type"]').val() == "") {
                    $.layerMsg({ content: '<fmt:message code="depatement.th.ret" />', icon: 2 });
                    return false;
                };
                if ($('[name="level"]').val() == "") {
                    $.layerMsg({ content: '<fmt:message code="depatement.th.zwjb" />', icon: 2 });
                    return false;
                };
                if ($('[name="postNo"]').val() == "") {
                    $.layerMsg({ content: '<fmt:message code="depatement.th.nub" />', icon: 2 });
                    return false;
                };
                $.ajax({
                    type:'post',
                    url:'/duties/addUserPost',
                    dataType:'json',
                    data:{
                        postName:$('[name="postName"]').val(),
                        level:$('[name="level"]').val(),
                        postNo:$('[name="postNo"]').val(),
                        // postPlan:$('[name="postPlan"]').val(),
                        duty:$('#duty').val(),
                        description:$('[name="description"]').val(),
                        type: $('select[name="type"] option:checked').val(),
                        deptId: $('select[name="deptId"] option:checked').val(),
                    },
                });
                layer.close(index);
                location.reload();
            },
            success:function(res){
                // 上传附件
                // $('#fileupload').fileupload({
                //     dataType: 'json',
                //     done: function (e, data) {
                //         $.each(data.result.files, function (index, file) {
                //             $('<p/>').text(file.name).appendTo(document.body);
                //         });
                //     }
                // });
                // $('b').css('color', 'red');


                $('#uploadinputimg').fileupload({
                    dataType:'json',
                    done: function (e, data) {
                        console.log(data)
                        if(data.result.obj != ''){
                            var data = data.result.obj;
                            var str = '';
                            var str1 = '';
                            for (var i = 0; i < data.length; i++) {
                                str += '<div class="dech" deUrl="' + data[i].attUrl+ '"><a href="/download?'+encodeURI(data[i].attUrl)+'" NAME="' + data[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                            }
                            $('.attmend').append(str);
                        }else{
                            //alert('添加附件大小不能为空!');
                            layer.alert('<fmt:message code="depatement.th.hjmn" />!',{},function(){
                                layer.closeAll();
                            });
                        }
                    }
                });

                //附件删除
                $('.attmend').on('click','.deImgs',function(){
                    var data=$(this).parents('.dech').attr('deUrl');
                    var dome=$(this).parents('.dech');
                    deleteChatment(data,dome);
                })

                // })
                //职能类型
                $.get('/code/GetDropDownBox',{CodeNos:'function'},function (json) {
                    var arrTwo=json.function;
                    var str='<option value=""><fmt:message code="hr.th.PleaseSelect" /></option>'
                    for(var i=0;i<arrTwo.length;i++){
                        str+='<option value="'+arrTwo[i].codeNo+'">'+arrTwo[i].codeName+'</option>'
                    }
                    $('[name="type"]').html(str)
                },'json');
                //所属部门
                $.get('/department/getAlldept',function (json) {
                    var arrTwo=json.obj;
                    var str='<option value=""><fmt:message code="hr.th.PleaseSelect" /></option>'
                    for(var i=0;i<arrTwo.length;i++){
                        str+='<option value="'+arrTwo[i].deptId+'">'+arrTwo[i].deptName+'</option>'
                    }
                    $('[name="deptId"]').html(str)
                },'json');

                if(res.flag){
                    console.log(res.flag)
                }
            },

        });
        // laydate.render({
        //     elem: '#sentTime'
        // });
    })

})


function stoprwo(me){
    // console.log(me)
    $.ajax({
        type:'post',
        url:'/duties/getUserPostId',
        dataType:'json',
        data: {
            postId: me
        },
        success:function(res){
            if(res.flag){
                var data=res.object;
                layer.open({
                    type: 1,
                    title:['<fmt:message code="global.lang.edit" />', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['700px', '500px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['<fmt:message code="depatement.th.modify" />', '<fmt:message code="depatement.th.quxiao" />'],
                    content:'<form id="saveRule" class="layui-form"><div class="inputlayout">' +
                    '<ul>' +
                    '<li class="clearfix">' +
                    '<label><fmt:message code="main.titleName" /> ：</label><input type="text" name="postName" value="'+data.postName+'"><b style="padding-left: 10px;">* </b>' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label><fmt:message code="main.type" />：</label>' +
                    ' <select style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" name="type">'+
                    '<option value=""><fmt:message code="hr.th.PleaseSelect" /></option>'+
                    '</select><b style="padding-left: 13px;">* </b>   ' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label><fmt:message code="vote.th.JobLevel" /> ：</label><input type="text" name="level" value="'+data.level+'"><b style="padding-left: 10px;">* </b>' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label><fmt:message code="vote.th.number" /> ：</label><input value="'+data.postNo+'" type="text" name="postNo"><b style="padding-left: 10px;">* </b>' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label><fmt:message code="workflow.th.sector" />：</label>' +
                    ' <select style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" name="deptId">'+
                    '<option value=""><fmt:message code="hr.th.PleaseSelect" /></option>'+
                    // '<option value="0">董事会</option>'+
                    // '<option value="1">短信内容后</option>'+
                    '</select>   ' +
                    '</li>' +
                    // '<li class="clearfix">' +
                    // '<label>编制 ：</label><input value="'+data.postPlan+'" type="text" name="postPlan">' +
                    // '</li>' +

                    '<li class="clearfix">' +
                    '<label><fmt:message code="depatement.th.duty" /> ：</label><textarea name="duty" id="duty" value style="min-width: 300px;min-height:60px;"></textarea>' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label><fmt:message code="depatement.th.requirements" /> ：</label><textarea name="description" id="description" value style="min-width: 300px;min-height:60px;"></textarea>' +
                    '</li>' +
                    '<input style="width: 200px; position: absolute; left: 280px;bottom: 0px;" id="fileupload" type="file" name="files[]" data-url="server/php/" multiple>'+
                    '</ul>' +
                    '</div></form>',
                    success:function () {
                        // 职能类型
                        $.get('/code/GetDropDownBox',{CodeNos:'function'},function (json) {
                            var arrTwo=json.function;
                            var str='<option value=""><fmt:message code="hr.th.PleaseSelect" /></option>'
                            for(var i=0;i<arrTwo.length;i++){
                                str+='<option value="'+arrTwo[i].codeNo+'">'+arrTwo[i].codeName+'</option>'
                            }
                            $('[name="type"]').html(str)
                            checkehuo('type', data.type);
                        },'json');
                        //所属部门
                        $.get('/department/getAlldept',function (json) {
                            var arrTwo=json.obj;
                            var str='<option value=""><fmt:message code="hr.th.PleaseSelect" /></option>'
                            for(var i=0;i<arrTwo.length;i++){
                                str+='<option value="'+arrTwo[i].deptId+'">'+arrTwo[i].deptName+'</option>'
                            }
                            $('[name="deptId"]').html(str);
                            checkehuo('deptId', data.deptId);
                        },'json');
                        // 上传附件
                        $('#fileupload').fileupload({
                            dataType: 'json',
                            done: function (e, data) {
                                $.each(data.result.files, function (index, file) {
                                    $('<p/>').text(file.name).appendTo(document.body);
                                });
                            }
                        });
                        $('#duty').val(data.duty);
                        $('#description').val(data.description)

                    },
                    yes:function(index){


                        if ($('[name="postName"]').val() == "") {
                            $.layerMsg({ content: '<fmt:message code="depatement.th.adfg" />', icon: 2 });
                            return false;
                        };
                        if ($('[name="type"]').val() == "") {
                            $.layerMsg({ content: '<fmt:message code="depatement.th.ret" />', icon: 2 });
                            return false;
                        };
                        if ($('[name="level"]').val() == "") {
                            $.layerMsg({ content: '<fmt:message code="depatement.th.zwjb" />', icon: 2 });
                            return false;
                        };
                        if ($('[name="postNo"]').val() == "") {
                            $.layerMsg({ content: '<fmt:message code="depatement.th.nub" />', icon: 2 });
                            return false;
                        };
                        $.ajax({
                            type:'post',
                            url:'/duties/updateUserPost',
                            dataType:'json',
                            data:{
                                postId: me,
                                postName:$('[name="postName"]').val(),
                                level:$('[name="level"]').val(),
                                // postPlan:$('[name="postPlan"]').val(),
                                duty:  $('#duty').val(),
                                description:$('[name="description"]').val(),
                                type: $('select[name="type"] option:checked').val(),
                                deptId: $('select[name="deptId"] option:checked').val(),
                                postNo:$('[name="postNo"]').val(),
                            },
                            success:function(res){
                                if(res.flag){
                                    console.log(222)
                                    layer.close(index);
                                };
                            }
                        });

                        layer.close(index);
                        location.reload();
                    },

                });
                $('b').css('color', 'red');

            }




        }


    });
}
function deleteList(me) {


    layer.confirm('<fmt:message code="attend.th.qued" />？', {
        btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'], //按钮
        title: "<fmt:message code=\"event.th.DeleteInformation\" />"
    }, function() {
        //确定删除，调接口
        $.ajax({
            type: 'post',
            url: '/duties/deleteUserPost',
            dataType: 'json',
            data: {
                postId: me
            },
            success: function(res) {
                if (res.flag) {
                    $.layerMsg({ content: '<fmt:message code="workflow.th.delsucess" />！', icon: 1 });
                } else {
                    $.layerMsg({ content: '<fmt:message code="lang.th.deleSucess" />！', icon: 1 });
                }
                location.reload();
            }
        })
    }, function() {

        layer.closeAll();
    });

}
