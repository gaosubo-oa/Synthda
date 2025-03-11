/**
 * Created by liruixu on 2017/6/13.
 */
//全局方法
function jump(me){
    parent.newjump($(me).attr('data-Url'))
}
function delete_priv(me,num,showCount) {
    if(showCount=='0(0)/0'){
        $.layerConfirm({title:queding,content:qued,icon:0},function(){
            $.post('/userPriv/deletePriv',{'userPriv':num},function (json) {
                if(json.flag){
                    $.layerMsg({content:delc,icon:1},function () {
                        location.reload()
                    })
                }
            },'json')
        })
    }else{
        $.layerConfirm({title:'提示',content:'该角色下存在用户，不能删除',icon:0},function(){
        })
    }


}

$(function () {
    if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )|| ( navigator.userAgent.indexOf('Macintosh') > -1 && navigator.userAgent.indexOf('Chrome') == -1 ) || ( navigator.userAgent.indexOf('Macintosh') > -1 && navigator.userAgent.indexOf('Chrome') == -1 && navigator.userAgent.indexOf('Firefox') == -1 )||/(Android)/i.test(navigator.userAgent)) {
        $('#hiddenMain').show();
        $('#loginAdmin').hide();
        $('#north').show()
    }else{
        if($('[name="username"]').val()==0&&$.GetRequest().appType!=1){
            $('#hiddenMain').hide();
            $('#loginAdmin').show();
            $('#north').hide()
        }else {
            $('#hiddenMain').show();
            $('#loginAdmin').hide();
            $('#north').show()
        }
    }



    $('.dept_li ').on("click",function () {//左边栏展示隐藏
        if($(this).next('.pick').css('display')=='none') {
            $(this).next('.pick').show()
            $(this).removeClass('liUp')
            $(this).addClass('liDown')
        }else {
            $(this).next('.pick').hide()
            $(this).removeClass('liDown')
            $(this).addClass('liUp')
        }
    })





    $('.import').on("click",function () {
        if($('[name="super_pass"]').val() != ''){
            $.post('userPriv/checkSuperPass',{'password':$('[name="super_pass"]').val()},function (json) {
                if(json.flag) {
                    $('#hiddenMain').show();
                    $('#loginAdmin').hide();
                    $('#north').show()
                    $('input[name="username"]').val('1');
                }else {
                    layer.alert(mima,{title:xinxiM,btn:sure})
                }
            },'json')
        }else{
            layer.alert('请输入超极密码！',{title:xinxiM,btn:sure})
        }
    })

    $(document).on("keyup",function (e) {
        if(e.keyCode==13){
            if(!$('#loginAdmin').is(":hidden")){
                $('.import').trigger('click');
            }
        }
    })
    // htmlloadDate.init()

    // 跳转到角色导入页面
    $(document).on('click', '.fileload', function () {
        window.open("/userPrivImport");
    })

})

var htmlloadDate={//界面初始化数据
    init:function (privTypeId) {
        var me=this;
        $.get('/userPrivType/queryUserPrivByPrivTypeId',{privTypeId:privTypeId},function (json) {
            me.htmlLoad(json);
        },'json')
    },
    htmlLoad:function (date) {
        // if(userPriv)
        var str='';
        var data=date.obj

        for (var i = 0; i < data.length; i++) {
            $("[name='priv']").append('<option value="' + data[i].userPriv + '">' + data[i].privName + '</option>');
        }
        for(var i=0;i<data.length;i++){

            var color_str = '';
            if (data[i].userPriv ==1 ){
                color_str = 'style="color:red"';
            }
            str+='<tr>' +
                '<td nowrap="" align="center" width="60">'+data[i].privNo+'</td>' +
                '<td nowrap="" align="center" '+color_str+' >'+data[i].privName+'</td>' +
                '<td nowrap="" align="center" '+color_str+' >'+function () {
                if(data[i].privTypeName == undefined){
                    return '未分类';
                }else{
                    return data[i].privTypeName
                }

            }()+'</td>' +
                // '<td nowrap="" align="center">'+data[i].privDeptId+'</td>' +
                '<td nowrap="" align="center">'+data[i].showCount+'  &nbsp;&nbsp; <a target="_blank" href="userPriv/show_users?userPriv='+data[i].userPriv+'&privName="  data-url=""> '+'查看详情'+'</a> </td>' +
                '<td nowrap="" align="center"> <a href="modifyThePermissions?'+data[i].userPriv+'"  data-url=""> '+permissions+'</a>&nbsp;&nbsp;'+
                // '<a href="newRole?'+data[i].userPriv+'" data-url=""> '+edit1+'</a>&nbsp;&nbsp;'+
                '<span data-id="'+data[i].userPriv+'" class="editData" style="color: #1687cb;cursor: pointer" data-url="" onclick="editData($(this))"> '+edit1+'</span>&nbsp;&nbsp;'+
                '<a href="cloning?'+data[i].userPriv+'" data-url="">'+clone+'</a>&nbsp;&nbsp;'+
                '<span id="delete_priv" onclick="delete_priv(this,'+data[i].userPriv+',\''+data[i].showCount+'\')" style="color: #1687cb;cursor: pointer"> '+function () {
                    if(data[i].userPriv==undefined || data[i].userPriv==1){return ''}
                    else {
                        return ''+del+''
                    }
                }()+'</span>'+
                '</td>' +
                '</tr>'
        }/*<a href="javascript:viod(0)">查看详情</a>*/
        // if(data[i].userPriv==1){
        //     $('#delete_priv').attr('text','')
        // }
        $('#table_style tbody').html(str)
    }
}