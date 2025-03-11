

var attendLeave;

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
/* 终止和生效方法 */

function able(me,id,stateId,stopId){
    var s;
    /*  alert($(stopId).html()); */
    // console.log($('#able').html())
    // console.log(stopId);
  // $('#').css('background','red')
  //   console.log($('#unable').html())
    if($('#'+stopId).html()==Enable){
        s = "1";
        // console.log(s)
        /* 	alert(2); */
    }else if($('#'+stopId).html() == Disable){
        s = "0";
        // console.log(s)
    };
    var data={
        "id":id,
        "state":s// 发布标识(0-未发布,1-已发布,2-已终止)
    };
    $.ajax({
        url:"/smsSettings/upSmsSettings",
        type:'post',
        dataType:"JSON",
        data : data,
        success:function(data){
            if($(me).html()==Enable){
                $(me).parent().prev().html(Enable);
                $(me).html(Disable);
            }else if($(me).html() == Disable){
                $(me).parent().prev().html(Disable);
                $(me).html(Enable);
            }
            location.reload();
        },
        error:function(e){
        }
    });
}
// function deletes(id,me) {
//     $.layerConfirm({title:'确定删除',content:'您确定要删除吗？',icon:0},function(){
//         $.post('smsSettings/delSmsSettings',{'id':id},function (json) {
//             if(json.flag){
//                 $.layerMsg({content:'删除成功！',icon:1},function(){
//                     $(me).parent().parent().remove()
//                 });
//             }
//         },'json')
//     })
//
// }

//列表
function getData(){
    $.get('/smsSettings/selectSmsSettingsAll',function (json) {
        if(json.flag){
            var v=1;
            var arr=json.obj;
            var str=''
            for(var i=0;i<arr.length;i++){
                str+='<tr><td>'+ (i+1) +'</td>\
                  <td>'+arr[i].name+'</td>\
                  <td>'+arr[i].protocol+'</td>\
                  <td>'+arr[i].host+'</td>\
                  <td>'+arr[i].mobile+'</td>'+
                  '<td>'+function(){
                if(arr[i].code==0){
                    return 'GBK'
                }else if(arr[i].code==1){
                    return 'utf-8'
                }
            }()
            +'</td>'+
                  '<td id="state">'+function(){
                        if(arr[i].state==0){
                            return Disable
                        }else if(arr[i].state==1){
                            return Enable
                        }
                    }()
                    +'</td>\
                        <td>'+(function () {
                        if (arr[i].state=="0"){
                            return "<a id='able"+arr[i].id+"' style='cursor:pointer;' onclick='able(this,"+arr[i].id+",\"state"+arr[i].id+"\",\"able"+arr[i].id+"\")'>"+Enable+"</a>"
                        }else {
                            return "<a id='unable"+arr[i].id+"' style='cursor:pointer;' onclick='able(this,"+arr[i].id+",\"state"+arr[i].id+"\",\"unable"+arr[i].id+"\")'>"+Disable+"</a>"
                        }
                    })()
                      +'<a href="javascript:void (0)" class="newsBtntwo" onclick="stoprwo(' + arr[i].id + ')">'+edit1+'</a>\
                         <a href="javascript:void (0)" onclick="deleteList(' + arr[i].id + ')">'+del+'</a>\
                    </td></tr>'
            }
            $('table tbody').html(str)
        }
    },'json')

}
function deleteList(me) {

    layer.confirm(deleteit, {
        btn: [sure, cancel], //按钮
        title: information
    }, function() {
        //确定删除，调接口
        $.ajax({
            type: 'post',
            url: '/smsSettings/delSmsSettings',
            dataType: 'json',
            data: {
                id: me
            },
            success: function(res) {
                if (res.flag) {
                    $.layerMsg({ content: delc, icon: 1 });
                } else {
                    $.layerMsg({ content:delf, icon: 1 });
                }
                location.reload();
            }
        })
    }, function() {

        layer.closeAll();
    });

}
// radio的动态显示
$(document).on('keyup', '.sign', function () {

    if (this.value != "" ){
        $('.liPosition').html(
            '<label>'+AddSignature+' ：' +'</label>'+
            '<input type="radio" name="signPosition" value="0" style="display:inline-block" checked="true"/> ' + NotAdd);

    } else {
        $('.liPosition').html(
            '<label>'+AddSignature+' ：' +'</label>'+
            '<input type="radio" name="signPosition" value="1" style="display:inline-block" checked="true" /> ' + HeadAdd +
            '<input type="radio" name="signPosition" value="2" style="display:inline-block" /> ' + TailAdd);
    }

});


//新建
$(function () {
    getData();
    $(document).on('click','#newBtn1', function () {
        layer.open({
            type: 1,
            title:[settings, 'background-color:#2b7fe0;color:#fff;'],
            area: ['700px', '460px'],
            shadeClose: false, //点击遮罩关闭
            // btn: ['创建', '取消'],
            content:'<div class="inputlayout">' +
            '<ul>' +
            '<li class="clearfix">' +
            '<input type="hidden" name="state" value="0">' +
            '</li>' +
            '<li class="clearfix">' +
            '<label><b>* </b>'+Gateway+' ：</label><input type="text" name="iname" value="">' +
            '</li>' +
            '<li class="clearfix">' +
            '<label><b>* </b>'+Agreement+' ：</label><input type="text" name="protocol" value="">' +
            '</li>' +
            '<li class="clearfix">' +
            '<label><b>* </b>'+Host+' ：</label><input type="text" name="host" value="">' +
            '</li>' +
            '<li class="clearfix">' +
            '<label><b>* </b>'+Interface+' ：</label><input type="text" name="port">' +
            '</li>' +
            '<li class="clearfix">' +
            '<label><b>* </b>'+depatement_th_Accountnumber+' ：</label><input type="text" name="uname" placeholder="格式要求“参数名=参数值”">' +
            '</li>' +
            '<li class="clearfix">' +
            '<label><b>* </b>'+Password+' ：</label><input type="text" name="pwd1" placeholder="格式要求“参数名=参数值”">' +
            '</li>' +
            '<li class="clearfix">' +
            '<label><b>* </b>'+Content+' ：</label><input type="text" name="contentField" value="">' +
            '</li>' +
            '<li class="clearfix">' +
            '<label><b>* </b>'+parameter+'：</label>' +
            ' <select id="code" style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" name="code">'+
            '<option value="">'+ds+'</option>'+
            '<option value="0">GBK</option>'+
            '<option value="1">utf-8</option>'+
            '</select>   ' +
            '</li>' +
            '<li class="clearfix">' +
            '<label><b>* </b>'+Receivery+' ：</label><input type="text" name="mobile" value="">' +
            '</li>' +
            '<li class="clearfix">' +
            '<label>'+parameterName+' ：</label><input type="text" name="timeContent" value=""  id="sentTime" >' +
            '</li>' +
            '<li class="clearfix">' +
            '<label>'+xoaSignature+' ：</label><input type="text" class="sign" name="sign">' +
            '</li>' +
            '<li class="clearfix">' +
            '<label>'+xoaSignatureValue+' ：</label><input type="text" name="signValue">' +
            '</li>' +
            '<li class="clearfix liPosition">' +
            '<label>'+AddSignature+' ：' +'</label>'+
                //
                '<input type="radio" name="signPosition" value="1" checked="true" /> ' +HeadAdd+
                '<input type="radio" name="signPosition" value="2" /> ' +TailAdd+

            '</li>' +
           /* *'<li class="clearfix">' +
            '<label>'+locations+'：</label>' +
            ' <select id="location" style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" name="location">'+
            '<option value="">'+ds+'</option>'+
            '<option value="0">'+Before+'</option>'+
            '<option value="1">'+text+'</option>'+
            '</select>   ' +
            '</li>' +*/
            '<li class="clearfix">' +
            '<label>'+parameter1+' ：</label><input type="text" name="extend1" value="" placeholder="格式要求“参数名=参数值”">' +
            '</li>' +
            '<li class="clearfix">' +
            '<label>'+parameter2+' ：</label><input type="text" name="extend2" value="" placeholder="格式要求“参数名=参数值”">' +
            '</li>' +
            '<li class="clearfix">' +
            '<label>'+parameter3+' ：</label><input type="text" name="extend3" value="" placeholder="格式要求“参数名=参数值”">' +
            '</li>' +
            '<li class="clearfix">' +
            '<label>'+parameter4+' ：</label><input type="text" name="extend4" value="" placeholder="格式要求“参数名=参数值”">' +
            '</li>' +
            '<li class="clearfix">' +
            '<label>'+parameter5+' ：</label><input type="text" name="extend5" value="" placeholder="是否对参数值进行编码 “1” or “0”">' +
            '</li>' +
            '</ul>' +
            '</div>',
            btn: [saveNew,cancel],
            yes: function (index) {
                if ($('[name="iname"]').val() == "") {
                    $.layerMsg({ content: gatewayu, icon: 2 });
                    return false;
                };
                if ($('[name="protocol"]').val() == "") {
                    $.layerMsg({ content: agreementu, icon: 2 });
                    return false;
                };
                if ($('[name="host"]').val() == "") {
                    $.layerMsg({ content: hostu, icon: 2 });
                    return false;
                };
                if ($('[name="port"]').val() == "") {
                    $.layerMsg({ content:interfacer, icon: 2 });
                    return false;
                };
                if ($('[name="uname"]').val() == "") {
                    $.layerMsg({ content: account, icon: 2 });
                    return false;
                };
                if ($('[name="pwd1"]').val() == "") {
                    $.layerMsg({ content: password2, icon: 2 });
                    return false;
                };
                if ($('[name="contentField"]').val() == "") {
                    $.layerMsg({ content: content2, icon: 2 });
                    return false;
                };
                if ($('select[name="code"] option:checked').val() == "") {
                    $.layerMsg({ content: encoding, icon: 2 });
                    return false;
                };
                if ($('[name="mobile"]').val() == "") {
                    $.layerMsg({ content: acceptance, icon: 2 });
                    return false;
                };
               /* if ($('[name="timeContent"]').val() == "") {
                    $.layerMsg({ content:parameter3, icon: 2 });
                    return false;
                };*/
               /* if ($('[name="sign"]').val() == "") {
                    $.layerMsg({ content:parameter4, icon: 2 });
                    return false;
                };*/

                $.ajax({
                    type:'post',
                    url:'/smsSettings/insertSmsSettings',
                    dataType:'json',
                    data:{
                        id:$('[name="Id"]').val(),
                        name:$('[name="iname"]').val(),
                        protocol:$('[name="protocol"]').val(),
                        host:$('[name="host"]').val(),
                        port:$('[name="port"]').val(),
                        username:$('[name="uname"]').val(),
                        pwd:$('[name="pwd1"]').val(),
                        contentField:$('[name="contentField"]').val(),
                        mobile:$('[name="mobile"]').val(),
                        sign:$('[name="sign"]').val(),
                        signValue:$('[name="signValue"]').val(),
                        signPosition:$('input[type=radio][name="signPosition"]:checked').val(),
                        extend1:$('[name="extend1"]').val(),
                        extend2:$('[name="extend2"]').val(),
                        extend3:$('[name="extend3"]').val(),
                        extend4:$('[name="extend4"]').val(),
                        extend5:$('[name="extend5"]').val(),
                        state: $('[name="state"]').val(),
                        code: $('select[name="code"] option:checked').val(),
                        /*location: $('select[name="location"] option:checked').val(),*/
                        timeContent:$('[name="timeContent"]').val()
                    },
                    success:function (json) {
                        layer.close(index);
                        location.reload();
                    }
                });

            },
            success:function(res){
            //     $('b').css('color', 'red');
            //     if(res.flag){
            //         console.log(res.flag)
            //     }
            //     laydate.render({
            //         elem: '#sentTime'
            //     });
            }
        });


    })
})


//编辑
function stoprwo(me){
    // console.log(me)
    $.ajax({
        type:'post',
        url:'/smsSettings/selectSmsSettingsById',
        dataType:'json',
        data: {
            id: me
        },
        success:function(res){
            var position = null;
            if(res.flag){
                var data=res.object;
                layer.open({
                    type: 1,
                    title:[edit1, 'background-color:#2b7fe0;color:#fff;'],
                    area: ['700px', '400px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: [modify1, cancel],
                    content: '<form id="saveRule" class="layui-form"><div class="inputlayout">' +
                    '<ul>' +
                    '<li class="clearfix">' +
                    '<label><b>* </b>'+GatewayName+' ：</label><input type="text" name="iname" value="'+function () {
                        if(data.name != undefined){
                            return data.name;
                        }else {
                            return "";
                        }
                    }()+'">' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label><b>* </b>'+Agreement+' ：</label><input type="text" name="protocol" value="'+function () {
                    if(data.protocol != undefined){
                        return data.protocol;
                    }else {
                        return "";
                    }
                }()+'">' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label><b>* </b>'+Host+' ：</label><input type="text" name="host" value="'+function () {
                        if(data.host != undefined){
                            return data.host;
                        }else {
                            return "";
                        }
                    }()+'">' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label><b>* </b>'+Interface+' ：</label><input type="text" name="port" value="'+function () {
                        if(data.port != undefined){
                            return data.port;
                        }else {
                            return "";
                        }
                    }()+'">' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label><b>* </b>'+Account+' ：</label><input type="text" name="uname" value="'+function () {
                    if(data.username != undefined){
                        return data.username;
                    }else {
                        return "";
                    }
                }()+'">' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label><b>* </b>'+Password5+' ：</label><input type="pwd" name="pwd1" value="'+function () {
                    if(data.pwd != undefined){
                        return data.pwd;
                    }else {
                        return "";
                    }
                }()+'">' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label><b>* </b>'+nameyu+' ：</label><input type="text" name="contentField" value="'+function () {
                    if(data.contentField != undefined){
                        return data.contentField;
                    }else {
                        return "";
                    }
                }()+'">' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label><b>* </b>'+parameter+'：</label>' +
                    ' <select id="code" style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" name="code">'+
                    '<option value="">'+ds+'</option>'+
                    '<option value="0">GBK</option>'+
                    '<option value="1">utf-8</option>'+
                    '</select>   ' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label><b>* </b>'+Receivery+' ：</label><input type="text" name="mobile" value="'+function () {
                        if(data.mobile != undefined){
                            return data.mobile;
                        }else {
                            return "";
                        }
                    }()+'">' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label>'+parameterName+' ：</label><input type="text" name="timeContent" value="'+function () {
                        if(data.timeContent != undefined){
                            return data.timeContent;
                        }else {
                            return "";
                        }
                    }()+'" >' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label>'+xoaSignature+' ：</label><input type="text" class="sign" name="sign" value="'+function () {
                        if(data.sign!=""){
                            position = '<input type="radio" id="signPosition" name="signPosition" value="0" style="display:inline-block" checked="true"/> ' + NotAdd;
                            return data.sign;
                        } else {
                            var before = false;
                            var after = false;
                            if (data.signPosition == 1) before = true;
                            if (data.signPosition == 2) after = true;

                            position = '<input type="radio" id="signPosition" name="signPosition" value="1" style="display:inline-block" checked="'+before+'"/> ' + HeadAdd +
                                '<input type="radio" id="signPosition" name="signPosition" value="2" style="display:inline-block" checked="'+after+'"/> ' + TailAdd;
                            return "";
                        }
                    }()+'">' +
                    '</li>' +
                   '<li class="clearfix">' +
                   '<label>'+xoaSignatureValue+' ：</label><input type="text" name="signValue" value="'+function () {
                       if(data.signValue != undefined){
                           return data.signValue;
                       }else {
                           return "";
                       }
                   }()+'">' +
                   '</li>' +
                   '<li class="clearfix liPosition">' +
                   '<label>'+AddSignature+' ：' +'</label>'+
                        position +
                   '</li>' +


                    /** '<li class="clearfix">' +
                    '<label>'+location+'：</label>' +
                    ' <select id="location" style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" name="location">'+
                    '<option value="">'+ds+'</option>'+
                    '<option value="0">'+Before+'</option>'+
                    '<option value="1">'+text+'</option>'+
                    '</select>   ' +
                    '</li>' +*/
                    '<li class="clearfix">' +
                    '<label>'+parameter1+' ：</label><input type="text" name="extend1" value="'+function () {
                    if(data.extend1 != undefined){
                        return data.extend1;
                    }else {
                        return "";
                    }
                }()+'">' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label>'+parameter2+' ：</label><input type="text" name="extend2" value="'+function () {
                    if(data.extend2 != undefined){
                        return data.extend2;
                    }else {
                        return "";
                    }
                }()+'">' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label>'+parameter3+' ：</label><input type="text" name="extend3" value="'+function () {
                    if(data.extend3 != undefined){
                        return data.extend3;
                    }else {
                        return "";
                    }
                }()+'">' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label>'+parameter4+' ：</label><input type="text" name="extend4" value="'+function () {
                    if(data.extend4 != undefined){
                        return data.extend4;
                    }else {
                        return "";
                    }
                }()+'">' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label>'+parameter5+' ：</label><input type="text" name="extend5" value="'+function () {
                    if(data.extend5 != undefined){
                        return data.extend5;
                    }else {
                        return "";
                    }
                }()+'">' +
                    '</li>' +
                    // '<li class="clearfix">' +
                    // '<label>状态：</label>' +
                    // ' <select id="state" style=" padding:5px 0;border: 1px solid #ddd;border-radius: 4px;; margin-left: 28px;width: 300px;display: inline-block" name="state">'+
                    // '<option value="">请选择</option>'+
                    // '<option value="启用">启用</option>'+
                    // '<option value="不启用">不启用</option>'+
                    // '</select>   ' +
                    // '</li>' +
                    '</ul>' +
                    '</div></form>',
                    yes:function(index){
                        $.ajax({
                            type:'post',
                            url:'/smsSettings/upSmsSettings',
                            dataType:'json',
                            data:{
                                id: me,
                                name:$('[name="iname"]').val(),
                                protocol:$('[name="protocol"]').val(),
                                host:$('[name="host"]').val(),
                                port:$('[name="port"]').val(),
                                username:$('[name="uname"]').val(),
                                pwd:$('[name="pwd1"]').val(),
                                contentField:$('[name="contentField"]').val(),
                                mobile:$('[name="mobile"]').val(),
                                sign:$('[name="sign"]').val(),
                                signValue:$('[name="signValue"]').val(),
                                signPosition:$('input[type=radio][name="signPosition"]:checked').val(),
                                extend1:$('[name="extend1"]').val(),
                                extend2:$('[name="extend2"]').val(),
                                extend3:$('[name="extend3"]').val(),
                                extend4:$('[name="extend4"]').val(),
                                extend5:$('[name="extend5"]').val(),
                                state: $('select[name="state"] option:checked').val(),
                                code: $('select[name="code"] option:checked').val(),
                                /*location: $('select[name="location"] option:checked').val(),*/
                                timeContent:$('[name="timeContent"]').val(),
                            },
                            success:function(res){
                                // form.render()
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
                checkehuo('location', data.location);
                checkehuo('code', data.code);
                // $('#state').val(data.state)
                // $('#state').css('background','red');
                // $('#code').val(data.code)
                // $('#location').val(data.location)
            }
        }


    });
}

