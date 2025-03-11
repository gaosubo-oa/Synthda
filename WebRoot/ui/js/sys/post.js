var basepath = '';
basepath = window.location.protocol +'//'+ window.location.host;
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
    $.get('/position/selectUserJob',function (json) {
        if(json.flag){
            var v=1;
            var arr=json.obj;
            var str=''
            for(var i=0;i<arr.length;i++){

                str+='<tr><td>'+ arr[i].jobNo +'</td>\
                  <td>'+arr[i].jobName+'</td>\
                  <td>'+arr[i].typeName+'</td>\
                  <td>'+arr[i].level+'</td>\
                  <td>'+arr[i].deptName+'</td>\
                        <td>'
                    +'<a href="javascript:void (0)" class="newsBtntwo" onclick="stoprwo(' + arr[i].jobId + ')">'+edit1+'</a>\
                         <a href="javascript:void (0)" onclick="deleteList(' + arr[i].jobId + ')">'+del+'</a>\
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
    var fileId='';
    var fileName='';
    getData();
    $('.Query').on("click",function () {
        ajaxPage.data.page=1;
        ajaxPage.page()
    })
    $('#user_btn').on('click',function () {

        layer.open({
            type: 1,
            title:[NewPost, 'background-color:#2b7fe0;color:#fff;'],
            area: ['700px', '500px'],
            shadeClose: true, //点击遮罩关闭
            // btn: ['创建', '取消'],
            content:'<form id="saveRule" class="layui-form"><div class="inputlayout">' +
            '<ul>' +
            '<li class="clearfix">' +
            '<label>'+PostName+' ：</label><input type="text" name="jobName" value=""><b style="padding-left: 10px;">* </b>' +
            '</li>' +
            '<li class="clearfix">' +
            '<label>'+Functionaltypes+'：</label>' +
            ' <select style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" name="type">'+
            '<option value="">'+ds+'</option>'+
            '</select><b style="padding-left: 13px;">* </b>   ' +
            '</li>' +
            '<li class="clearfix">' +
            '<label>'+Postlevel+' ：</label><input type="text" name="level" value=""><b style="padding-left: 10px;">* </b>' +
            '</li>' +
            '<li class="clearfix">' +
            '<label>'+Postevel+' ：</label><input type="text" name="jobNo"><b style="padding-left: 10px;">* </b>' +
            '</li>' +
            '<li class="clearfix">' +
            '<label>'+Subordinatedepartment+'：</label>' +
            ' <select style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" name="deptId">'+
            '<option value="">'+ds+'</option>'+
            '</select>   ' +
            '</li>' +
            '<li class="clearfix">' +
            '<label>'+Organization+' ：</label><input type="text" name="jobPlan">' +
            '</li>' +

            '<li class="clearfix">' +
            '<label>'+Duty+' ：</label><textarea name="duty" id="duty" value style="min-width: 300px;min-height:60px;"></textarea>' +
            '</li>' +
            '<li class="clearfix">' +
            '<label>'+EntryRequirements+' ：</label><textarea name="description" id="textCont" value style="min-width: 300px;min-height:60px;"></textarea>' +
            '</li>' +
            /*  '<input style="width: 200px; position: absolute; left: 280px;bottom: 0px;" id="fileupload" type="file" name="files[]" data-url="upload?module=userjob" multiple>'+*/
            '<li class="clearfix">' +
            '<label>'+Attachmentsupload+'：</label>' +
            '<div>'+
            '<form id="uploadimgform" target="uploadiframe"  action="/upload?module=seal"  method="post" >'+
            '<input type="file" multiple="multiple" name="file" id="uploadinputimg"  class="w-icon5" style="cursor:pointer;margin-left: 32px;opacity: 0;width: 70px;'+
            'filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">'+
            '<a href="#" id="uploadimg" style="z-index:-1;position: relative;left: -69px;"><img style="margin-right:5px;" src="../img/icon_uplod.png"/>'+Attachmentsupload+'</a>'+
            '</form>'+
            '<div style="margin-left:183px;" class="attmend"></div>'+
            '</div>'+
            '</li>' +
            '</ul>' +
            '</div></form>',
            btn: [saveNew,quxiao],
            btn1: function (index) {
                if ($('[name="jobName"]').val() == "") {
                    $.layerMsg({ content: thePost, icon: 2 });
                    return false;
                };
                if ($('[name="type"]').val() == "") {
                    $.layerMsg({ content:function1, icon: 2 });
                    return false;
                };
                if ($('[name="level"]').val() == "") {
                    $.layerMsg({ content: Please, icon: 2 });
                    return false;
                };
                if ($('[name="jobNo"]').val() == "") {
                    $.layerMsg({ content: Please2, icon: 2 });
                    return false;
                };
                for(var i=0;i<$('.inHidden').length;i++){
                    fileId += $('.inHidden').eq(i).val();
                    fileName += $('.inHidden').eq(i).attr('name');
                }
                $.ajax({
                    type:'post',
                    url:'/position/addUserJob',
                    dataType:'json',
                    data:{
                        jobName:$('[name="jobName"]').val(),
                        level:$('[name="level"]').val(),
                        jobNo:$('[name="jobNo"]').val(),
                        jobPlan:$('[name="jobPlan"]').val(),
                        duty:$('#duty').val(),
                        description:$('[name="description"]').val(),
                        type: $('select[name="type"] option:checked').val(),
                        deptId: $('select[name="deptId"] option:checked').val(),
                        attachmentId:fileId,
                        attachmentName:fileName,
                    },
                });
                layer.close(index);
                location.reload();
            },
            success:function(res){
                $('#uploadinputimg').fileupload({
                    dataType:'json',
                    url:'/upload?module=userjob',
                    done: function (e, data) {

                        if(data.result.obj != ''){
                            var data = data.result.obj;
                            var str = '';
                            var str1 = '';
                            for (var i = 0; i < data.length; i++) {
                                str += '<div class="dech" deUrl="' + data[i].attUrl+ '"><a href="'+ basepath +'/download?'+encodeURI(data[i].attUrl)+'" NAME="' + data[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                            }
                            $('.attmend').append(str);
                        }else{
                            //alert('添加附件大小不能为空!');
                            layer.alert(attachments1,{},function(){
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
                });

                //职能类型
                $.get('/code/GetDropDownBox',{CodeNos:'function'},function (json) {
                    var arrTwo=json.function;
                    var str='<option value="">'+ds+'</option>'
                    for(var i=0;i<arrTwo.length;i++){
                        str+='<option value="'+arrTwo[i].codeNo+'">'+arrTwo[i].codeName+'</option>'
                    }
                    $('[name="type"]').html(str)
                },'json');
                //所属部门
                $.get('/department/getAlldept',function (json) {
                    var arrTwo=json.obj;
                    var str='<option value="">'+ds+'</option>'
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
        $('b').css('color', 'red');
        // laydate.render({
        //     elem: '#sentTime'
        // });
    })

})
function stoprwo(me){
    // console.log(me)
    $.ajax({
        type:'post',
        url:'/position/getUserjobId',
        dataType:'json',
        data: {
            jobId: me
        },
        success:function(res){
            if(res.flag){
                var data=res.object;
                var arr = res.object.attachment;
                var str1=""

                layer.open({
                    type: 1,
                    title:[edit1, 'background-color:#2b7fe0;color:#fff;'],
                    area: ['700px', '500px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: [modify1, cancel],
                    content:'<form id="saveRule" class="layui-form"><div class="inputlayout" >' +
                    '<ul>' +
                    '<li class="clearfix">' +
                    '<label>'+PostName+' ：</label><input type="text" name="jobName" value="'+data.jobName+'"><b style="padding-left: 10px;">* </b>' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label>'+Functionaltypes+'：</label>' +
                    ' <select style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" name="type">'+
                    '<option value="">'+ds+'</option>'+
                    '</select><b style="padding-left: 13px;">* </b>   ' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label>'+Postlevel+' ：</label><input type="text" name="level" value="'+data.level+'"><b style="padding-left: 10px;">* </b>' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label>'+Postevel+' ：</label><input value="'+data.jobNo+'" type="text" name="jobNo"><b style="padding-left: 10px;">* </b>' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label>'+Subordinatedepartment+'：</label>' +
                    ' <select style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" name="deptId">'+
                    '<option value="">'+ds+'</option>'+
                    // '<option value="0">董事会</option>'+
                    // '<option value="1">短信内容后</option>'+
                    '</select>   ' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label>'+Organization+' ：</label><input value="'+data.jobPlan+'" type="text" name="jobPlan">' +
                    '</li>' +

                    '<li class="clearfix">' +
                    '<label>'+Duty+' ：</label><textarea name="duty" id="duty" value style="min-width: 300px;min-height:60px;"></textarea>' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label>'+EntryRequirements+' ：</label><textarea name="description" id="description" value="'+data.description+'" style="min-width: 300px;min-height:60px;"></textarea>' +
                    '</li>' +
                    /* '<input style="width: 200px; position: absolute; left: 280px;bottom: 0px;" id="fileupload" type="file" name="files[]" data-url="server/php/" multiple>'+*/
                    '<li class="clearfix">' +
                    '<label>'+Attachmentsupload+'：</label>' +
                    '<div>'+
                    '<form id="uploadimgform" target="uploadiframe"  action="/upload?module=seal"  method="post" >'+
                    '<input type="file" multiple="multiple" name="file" id="uploadinputimg"  class="w-icon5" style="cursor:pointer;margin-left: 32px;opacity: 0;width: 70px;'+
                    'filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">'+
                    '<a href="#" id="uploadimg" style="z-index:-1;position: relative;left: -69px;"><img style="margin-right:5px;" src="../img/icon_uplod.png"/>'+Attachmentsupload+'</a>'+
                    '</form>'+
                    '<div style="margin-left:183px;" class="attmend"></div>'+
                    '</div>'+
                    '</li>' +
                    '</ul>' +
                    '</div></form>',
                    success:function () {
                        if (res.object.attachment != '' && res.object.attachment != undefined) {
                            for (var i = 0; i < (arr.length); i++) {
                                str1+='<div class="dech" deUrl="'+encodeURI(arr[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" NAME="'+arr[i].attachName+'*" href="'+ basepath +'/download?'+encodeURI(arr[i].attUrl)+'"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>'+arr[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+arr[i].attachName+'*"  class="inHidden" value="'+arr[i].aid+'@'+arr[i].ym+'_'+arr[i].attachId+',"></div>';
                            }
                            $('.attmend').append(str1);
                        };
                        // 职能类型
                        $.get('/code/GetDropDownBox',{CodeNos:'function'},function (json) {
                            var arrTwo=json.function;
                            var str='<option value="">'+ds+'</option>'
                            for(var i=0;i<arrTwo.length;i++){
                                str+='<option value="'+arrTwo[i].codeNo+'">'+arrTwo[i].codeName+'</option>'
                            }
                            $('[name="type"]').html(str)
                            checkehuo('type', data.type);
                        },'json');
                        //所属部门
                        $.get('/department/getAlldept',function (json) {
                            var arrTwo=json.obj;
                            var str='<option value="">'+ds+'</option>'
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


                        $('#uploadinputimg').fileupload({
                            dataType:'json',
                            url:'/upload?module=userjob',
                            done: function (e, data) {

                                if(data.result.obj != ''){
                                    var data = data.result.obj;
                                    var str = '';
                                    var str1 = '';
                                    for (var i = 0; i < data.length; i++) {
                                        str += '<div class="dech" deUrl="' + data[i].attUrl+ '"><a href="'+ basepath +'/download?'+encodeURI(data[i].attUrl)+'" NAME="' + data[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                                    }
                                    $('.attmend').append(str);
                                }else{
                                    //alert('添加附件大小不能为空!');
                                    layer.alert(attachments1,{},function(){
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
                        $('#duty').val(data.duty);
                        $('#description').val(data.description)

                    },

                    yes:function(index){
                        if ($('[name="jobName"]').val() == "") {
                            $.layerMsg({ content: thePost, icon: 2 });
                            return false;
                        };
                        if ($('[name="type"]').val() == "") {
                            $.layerMsg({ content:function1, icon: 2 });
                            return false;
                        };
                        if ($('[name="level"]').val() == "") {
                            $.layerMsg({ content: Please, icon: 2 });
                            return false;
                        };
                        if ($('[name="jobNo"]').val() == "") {
                            $.layerMsg({ content: Please2, icon: 2 });
                            return false;
                        };
                        var fileId='';
                        var fileName='';
                        for(var i=0;i<$('.inHidden').length;i++){
                            fileId += $('.inHidden').eq(i).val();
                            fileName += $('.inHidden').eq(i).attr('name');
                        }
                        $.ajax({
                            type:'post',
                            url:'/position/updateUserJob',
                            dataType:'json',
                            data:{
                                jobId: me,
                                jobName:$('[name="jobName"]').val(),
                                level:$('[name="level"]').val(),
                                jobPlan:$('[name="jobPlan"]').val(),
                                duty:  $('#duty').val(),
                                description:$('[name="description"]').val(),
                                type: $('select[name="type"] option:checked').val(),
                                deptId: $('select[name="deptId"] option:checked').val(),
                                jobNo:$('[name="jobNo"]').val(),
                                attachmentId:fileId,
                                attachmentName:fileName,
                            },
                            success:function(res){
                                if(res.flag){
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

    layer.confirm(deleteIt, {
        btn: [sure, cancel], //按钮
        title: information
    }, function() {
        //确定删除，调接口
        $.ajax({
            type: 'post',
            url: '/position/deleteUserJob',
            dataType: 'json',
            data: {
                jobId: me
            },
            success: function(res) {
                if (res.flag) {
                    $.layerMsg({ content:delc, icon: 1 });
                } else {
                    $.layerMsg({ content: delf, icon: 1 });
                }
                location.reload();
            }
        })
    }, function() {

        layer.closeAll();
    });

}
