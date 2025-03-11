/**
 * Created by liruixu on 2017/6/20.
 */
var user_id;
var priv_id;
$(function () {

    $.get('/userPriv/getAllRoleManager',function (data) {
        if(data.flag){
            var streingt=''
            for(var i=0;i<data.obj.length;i++){

                streingt+='<tr><input type="hidden" name="roleManagerId" value="'+data.obj[i].roleManagerId+'"><td nowrap="" align="center">'+(i+1)+'</td>' +
                    '<td align="center">'+data.obj[i].roleManagerText.substr(0, data.obj[i].roleManagerText.length - 1)+'<input type="hidden" name="roleManager" value="'+data.obj[i].roleManager+'"></td>' +
                    '<td align="center">'+data.obj[i].userPrivText.substr(0, data.obj[i].userPrivText.length - 1)+'<input type="hidden" name="userPriv" value="'+data.obj[i].userPriv+'"></td>' +
                    '<td nowrap="" align="center"><a href="javascript:void(0)" class="textbj" style="margin-right: 10px">'+edit1+'</a>' +
                    '<a href="javascript:void(0)" class="deletea">'+del+'</a></td></tr>'
            }
            $('.tr_tds tbody').html(streingt)
            
        }
    },'json')
    $('.orgAdd').on("click",function(){
        if($(this).attr('data-num')=='0') {
            user_id = $(this).prev().prop('id')
            $.popWindow("../common/selectUser");
        }else {
            priv_id=$(this).prev().prop('id')
            $.popWindow("../common/selectPriv");
        }
    })
    $('.orgClear').on("click",function () {
        if($(this).attr('data-numTwo')==0){
            $("#mainsstwo").val("").attr({
                'username':'',
                'dataid':'',
                'user_id':'',
                'userprivname':''
            });
            $("#mainss").val("").attr({
                'username':'',
                'dataid':'',
                'user_id':'',
                'userprivname':''
            });
        }else {
            $("#PRIV_ID").val("").attr({
                'username':'',
                'dataid':'',
                'user_id':'',
                'userprivname':''
            });
            $("#PRIV_IDtwo").val("").attr({
                'username':'',
                'dataid':'',
                'user_id':'',
                'userprivname':''
            });
        }
    })
    $(document).on('.deletea','click',function () {
        var me=this;
        $.layerConfirm({title:queding,content:qued,icon:0},function(){
            $.post('/userPriv/deleteRoleManagerById',{'roleManagerId':$(me).parent().parent().find('[name="roleManagerId"]').val()},function (json) {
                if(json.flag){
                    location.reload()
                }
            },'json')
        })




    })
    $(document).on('.textbj','click',function () {
        $('#showdiv').hide();
        $('#hidediv').show();
        $('.newtwo').text(StatisticsTot)
        $('[name="roleManagerIdTwo"]').val($(this).parent().parent().find('[name="roleManagerId"]').val())
        $('#mainsstwo').val($(this).parent().parent().find('[name="roleManager"]').parent().text())
        $('#PRIV_IDtwo').val($(this).parent().parent().find('[name="userPriv"]').parent().text())
        $('#PRIV_IDtwo').attr('userpriv',$(this).parent().parent().find('[name="userPriv"]').val())
        $('#mainsstwo').attr('user_id',$(this).parent().parent().find('[name="roleManager"]').val())
    })

    $('.twoim').on("click",function () {
        $.post('/userPriv/updateRoleManager',
            {'roleManager':$('#mainsstwo').attr('user_id'),
                'userPriv':$('#PRIV_IDtwo').attr('userpriv'),
            'roleManagerId':$('[name="roleManagerIdTwo"]').val()},function (json) {
                if (json.flag) {
                    $.layerMsg({content:Modification,icon:1},function () {
                        location.reload()
                    })


                }
            },'json')
    })
    
$('.oneim').on("click",function () {
    if($('#mainss').val()==''||$('#PRIV_ID').val()==''){
        alert(notEmpty)
        return false
    }
    $.post('/userPriv/insertRoleManager',
        {'roleManager':$('#mainss').attr('user_id'),
            'userPriv':$('#PRIV_ID').attr('userpriv')},function (json) {
        if(json.flag) {
            // var str='<tr><input type="hidden"><td nowrap="" align="center">'+$('.tr_tds tbody tr').length+'</td>' +
            //     '<td align="left">'+$('#mainss').val()+'<input type="hidden" value="'+$('#mainss').attr('user_id')+'"></td>' +
            //     '<td align="left">'+$('#PRIV_ID').val()+'<input type="hidden" value="'+$('#PRIV_ID').attr('privid')+'"></td>' +
            //     '<td nowrap="" align="center"><a href="javascript:void(0)" class="textbj" style="margin-right: 10px">编辑</a>' +
            //     '<a href="javascript:void(0)">删除</a></td></tr>'
            // $('.tr_tds tbody').append(str)
            $.layerMsg({content:addSuccess,icon:1},function () {
                location.reload()
            })
            // $('#mainss').val('')
            // $('#PRIV_ID').val('')
            // $('#PRIV_ID').attr('privid','')
            // $('#mainss').attr('deptid','')
        }
    },'json')
})
})