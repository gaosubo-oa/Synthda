/**
 * Created by liruixu on 2017/6/15.
 */
function jump(me){//跳转方法，调用父界面
    parent.newjump($(me).attr('data-Url'))
}


var privTypeIds;
var id;
$(function () {
    var urlbool={//判断从哪里进入
        urlstr:null,
        privTypeId:null,
        init:function () {
            this.urlstr=window.location.href.split('?')[1];
            this.privTypeId=window.location.href.split('=')[0];
            id=this.urlstr.split('=')[1]
            privTypeIds=this.privTypeId.split('?')[1];
            if(this.urlstr.indexOf('&lang') > -1){
                this.urlstr = this.urlstr.split('&lang')[0];
            }
            if(privTypeIds == 'privTypeId'){
                $('.news').html('编辑角色分类权限')
                $('.TableBlockthree').remove();
                this.urlstr=id
                var me=this;
                this.addtableData(function () {
                    me.checkAjax();
                });//请求回显数据
            }else{
                if(this.urlstr=='0'){//添加编辑
                    this.roleDate()
                    this.addtableData()
                }else {
                    $('.news').html('编辑角色权限')
                    $('.TableBlockthree').remove();

                    var me=this;
                    this.addtableData(function () {
                        me.checkAjax();
                    });//请求回显数据
                }
            }


        },
        roleDate:function () {//角色数据加载
            var str=''
            $.get('/getAllUserPriv',function (json) {
                if(json.flag) {
                    for (var i = 0; i < json.obj.length; i++) {
                        str += '<label><input type="checkbox" name="USER_PRIV" value="' + json.obj[i].userPriv + '" />' + json.obj[i].privName + '</label>&nbsp;&nbsp;&nbsp;'
                    }
                    $('.newrole').html(str)
                }else {
                    layer.msg(sysError)
                }
            },'json')
        },
        addtableData:function (fn) {//表单数据加载
            var tablestr=''
            $.get('/getAllFunctionMenu',function (json) {
                if(json.flag) {
                    for (var n = 0; n < json.obj.length; n++) {
                        var str = ''
                        for (var m = 0; m < json.obj[n].child.length; m++) {
                            var strchild = ''
                            for (var l = 0; l < json.obj[n].child[m].child.length; l++) {
                                if (json.obj[n].child[m].child.length != 0) {
                                    strchild += '<br/>&nbsp;&nbsp;&nbsp;<label><input type="checkbox" name="chechild" value="' + json.obj[n].child[m].child[l].fId + '">' + json.obj[n].child[m].child[l].name + '</label>'
                                }
                            }
                            str += '<tr class="secondary" title="' + json.obj[n].child[m].name + '"><td nowrap="">' +
                                '<label><input type="checkbox" name="chechild" class="parentS" value="' + json.obj[n].child[m].fId + '" />' + json.obj[n].child[m].name + '</label>' + strchild + '</td></tr>'
                        }
                        tablestr += '<td valign="top">' +
                            '<table class="TableBlock" align="center">' +
                            '<tbody>' +
                            '<tr class="TableHeader" title="' + json.obj[n].name + '">' +
                            '<td nowrap="">' +
                            '<label><input type="checkbox" name="MENU_01" value="' + json.obj[n].fId + '" class="allche">' + json.obj[n].name + '</label>' +
                            '</td>' +
                            '</tr>' + str + '' +
                            '</tbody>' +
                            '</table>' +
                            '</td>'
                    }
                    $('.TableContentTwo').html(tablestr);
                }else {
                    layer.msg(sysError)
                }
                if(fn!=undefined){
                    fn();
                }
            },'json')
        },
        checkAjax:function () {
            if(privTypeIds == 'privTypeId'){
                $.get('/userPrivType/queryUserPrivTypeById',{'privTypeId':this.urlstr},function (json) {
                    if(json.flag){
                        $('.news').html('编辑角色分类权限 - ('+json.object.privTypeName+')');
                        var arr=json.object.funcIdStr.split(',');
                        $('[name=chechild]').each(function (i,n) {
                            for(var k=0;k<arr.length;k++){
                                if($(this).val()==arr[k]){
                                    $(this).prop('checked',true);
                                }
                            }
                        })
                    }
                },'json')
            }else{
                $.get('/userPriv/findUserPrivAndTypeFuncIdStr',{'userPriv':this.urlstr},function (json) {
                    if(json.flag){
                        $('.news').html('编辑角色权限 - ('+json.object.privName+')');
                        var arr=json.object.funcIdStr.split(',');
                        var strInfo = json.object.userPrivTypeFuncIdStr.split(',');
                        $('[name=chechild]').each(function (i,n) {
                            for(var k=0;k<arr.length;k++){
                                if($(this).val()==arr[k]){
                                    $(this).prop('checked',true);
                                }
                            }
                        })

                        $('[name=chechild]').each(function (i,n) {
                            if(!strInfo.includes($(n).val())) {
                                $(n).prop('disabled',true)
                                $(n).parents('.secondary').css('background','#ccc')
                            }
                        })

                        var doms = $('.TableBlock input');
                            for(var i = 0; i < doms.length; i++) {
                                if($(doms[i]).prop('disabled')) {
                                    $(doms[i]).parents('.secondary').siblings('.TableHeader').find('input').prop('disabled',true)
                                    $(doms[i]).parents('.secondary').siblings('.TableHeader').css('background','#ccc')
                                }
                            }




                    }
                },'json')
            }

        }
    }



    $(document).on('.TableHeader [type="checkbox"]','click',function () {
        if($(this).is(':checked')){
            $(this).prop('checked',true)
            $(this).parents('.TableBlock').find('[type="checkbox"]').each(function (i,n) {
                $(this).prop('checked',true)
            })
        }else {
            $(this).prop('checked',false)
            $(this).parents('.TableBlock').find('[type="checkbox"]').each(function (i,n) {
                $(this).prop('checked',false)
            })
        }
    })

    $(document).on('.parentS','click',function () {
        if( $(this).parent().next().get(0).nodeName='BR'){
            if($(this).is(':checked')){
                $(this).parent().parent().find('[type="checkbox"]').each(function (i,n) {
                    $(this).prop('checked',true)
                })
            }else {
                $(this).parent().parent().find('[type="checkbox"]').each(function (i,n) {
                    $(this).prop('checked',false)
                })
            }
        }
    })



    $('.btntrue').on("click",function () {
        var str='';
        $('[name="chechild"]:checked').each(function () {
            str+=$(this).val()+','
        })
        if(privTypeIds == 'privTypeId'){
            var obj={
                'funcIdStr':str
            }
            obj.privTypeId=urlbool.urlstr;
            $.post('/userPrivType/updateUserPrivType',obj,function (json) {
                if(json.flag) {
                    $.layerMsg({content: menuSSetting_th_editSuccess, icon: 1}, function () {
                        // parent.newjump('roleAuthorization')
                        location.href='permission'
                    })
                }
            },'json')
        }else{
            if(urlbool.urlstr=='0'){
                var obj={
                    'funcIds':str
                }

                var checkVal='';
                $('[name="USER_PRIV"]:checked').each(function () {
                    checkVal+=$(this).val()+','
                })
                obj.privids=checkVal;
                // obj.privids=$('[name="USER_PRIV"]:checked').val();
                if($('[name="OPERATION"]:checked').val()==0) {
                    $.post('/userPriv/updateUserPrivfuncIdStr', obj, function (json) {
                        $.layerMsg({content:addSuccess,icon:1},function () {
                            // parent.newjump('')
                            location.href='permission'
                        })
                    }, 'json')
                }else {
                    $.post('/userPriv/deleteUserPriv', obj, function (json) {

                        $.layerMsg({content:delc,icon:1},function () {
                            // parent.newjump('roleAuthorization')
                            location.href='permission'
                        })
                    }, 'json')
                }
            }else {
                var obj={
                    'funcIdStr':str
                }
                obj.userPriv=urlbool.urlstr;
                $.post('/userPriv/updateUser',obj,function (json) {
                    if(json.flag) {
                        $.layerMsg({content: menuSSetting_th_editSuccess, icon: 1}, function () {
                            location.href='permission'
                        })
                    }
                },'json')
            }
        }

    })
    urlbool.init()
})