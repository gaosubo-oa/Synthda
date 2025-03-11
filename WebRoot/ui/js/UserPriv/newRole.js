/**
 * Created by liruixu on 2017/6/15.
 */
function jump(me){
    parent.newjump($(me).attr('data-Url'))
}
$(function () {

    var urlbool={
        urlstr:null,
        init:function () {
            this.urlstr=window.location.href.split('?')[1]
            if(this.urlstr=='0'){
                $('.news').html(addRole)
            }else {
                $('.news').html(editUser)
                $('[data-url="newRole?0"]').parent().removeClass('one')
                this.ajaxdata();//请求回显数据
            }
        },
        ajaxdata:function () {
            $.get('/userPriv/findByuserPriv',{'userPriv':this.urlstr},function (json) {
                if(json.flag){
                    $('[name="PRIV_NO"]').val(json.object.privNo)
                    $('[name="PRIV_NAME"]').val(json.object.privName)
                    $('[name="IS_GLOBAL"]').each(function (i,n) {
                        if($(this).val()==json.object.privType){
                            $(this).prop('checked',true)
                            return false;
                        }
                    })
                }
            },'json')
        }
    }




    $('.import').click(function () {
        var postUrl='';
        var obj=null;
        if(urlbool.urlstr=='0'){
            postUrl='/userPriv/addUser';//走新建为0
            obj={'privName':$('[name="PRIV_NAME"]').val(),
                'privNo':$('[name="PRIV_NO"]').val(),
                'privType':$('[name="IS_GLOBAL"]:checked').val()
                };
        }else {
            postUrl='/userPriv/updateUser';//走修改步骤
            obj={'userPriv':urlbool.urlstr,
                'privName':$('[name="PRIV_NAME"]').val(),
                'privNo':$('[name="PRIV_NO"]').val()
                }
        }
        $.post(postUrl,obj,function (json) {
            if(json.flag){
                $.layerMsg({content:SuccessfulOperation,icon:1},function () {

                    location.href='roleAuthorization'
                })
            }else {
                $.layerMsg({content:json.msg,icon:2})
            }
        },'json')
    })


    urlbool.init()
})