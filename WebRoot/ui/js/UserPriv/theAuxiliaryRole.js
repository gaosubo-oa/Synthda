/**
 * Created by liruixu on 2017/6/16.
 */
var user_id='';

$(function () {
    var urlbool={
        urlstr:null,
        init:function () {
            var me=this;
            $.get('/getAllUserPriv',function (json) {
                me.ajaxdata(json);
            },'json')
        },
        ajaxdata:function (date) {
           if(date.flag){
               var str=''
                for(var i=0;i<date.obj.length;i++){
                    str+='<label><input type="checkbox" name="chesk" value="'+date.obj[i].userPriv+'">'+date.obj[i].privName+'</label>&nbsp;'
                }
                $('.tadata').html(str)
           }
        }
    }
    urlbool.init()
    
    $('.orgAdd').on("click",function () {
        user_id = $(this).prev().prop('id');
        $.popWindow("/common/selectUser");
    })
    $('.orgClear').on("click",function () {
        $("#BigStatic").val("").attr({
            'username':'',
            'dataid':'',
            'user_id':'',
            'userprivname':''
        });
    })
    $('#importBtn').on("click",function () {
        var userId = $('textarea').attr('user_id');
        if(!userId) {
            alert('请选择人员')
            return
        }
        var obj={};
        obj.sign=$('[name="OPERATION"]:checked').val();
        obj.funcIds=''
        $('[name="chesk"]:checked').each(function (i,n) {
            obj.funcIds+=$(this).val()+','
        })
        obj.userId=userId;
        $.post('/userPriv/updateUserFunByUID',obj,function (json) {
            if(json.flag){
                $.layerMsg({content:menuSSetting_th_editSuccess ,icon:1},function () {
                    // parent.newjump('')
                    location.href='/theAuxiliaryRole'
                })
            }
        },'json')
    })
//    新增能辅助角色
    $('#OPERATION0').on("click",function() {
        $('#selUser').css('display','block');
        $('.userData').css('display','none');
        $('#importBtn').css('display','block');
        $('#delBtn').css('display','none');
        urlbool.init()
    })
//    删除辅助角色
    $('#OPERATION1').on("click",function() {
        $('#selUser').css('display','none');
        $('.userData').css('display','block');
        $('#importBtn').css('display','none');
        $('#delBtn').css('display','block');
        $('#selqx').empty();
        $.ajax({
            url:"/userPriv/selectHavePriv",
            success:function(res) {
                if(res.flag) {
                    renderSelect(res.data,$('#userInfo'));
                }
            }
        })
    })
    //渲染下拉选择框
    function renderSelect(list,dom) {
        dom.empty();
        if(list.length <= 0) {
            dom.html('');
            return
        }
        let str = "<option value=''>请选择</option>"
        for(let i = 0; i < list.length; i++) {
            str += '<option value='+list[i].userId+'>'+list[i].userName+'</option>'
        }
        dom.html(str);
    }
    //渲染角色
    function renderData(list,dom) {
        dom.empty();
        let str = "";
        for(let i = 0; i < list.length; i++) {
            str+='<label><input type="checkbox" checked name="chesk" value="'+list[i].userPriv+'">'+list[i].privName+'</label>&nbsp;'
        }
        dom.html(str);
    }
    //    选择人员
    $('#userInfo').on("change",function() {
        const val = $(this).val();
        $.ajax({
            url:"/userPriv/selectPriv",
            data:{
                userId:val
            },
            success:function(res) {
                if(res.flag) {
                    renderData(res.data,$('#selqx'))
                }
            }
        })
    })
//    删除权限的保存按钮点击事件
    $('#delBtn').on("click",function() {
        let obj = {};
        obj.userId = $('#userInfo').val()
        obj.sign = $('#OPERATION1').val();
        obj.funcIds='';
        let doms = $('[name="chesk"]:checked');
        if(doms.length > 0) {
        doms.each(function (i,n) {
                obj.funcIds+=$(this).val()+','
            })
        }

        $.post('/userPriv/updateUserFunByUID',obj,function (json) {
            if(json.flag){
                $.layerMsg({content:menuSSetting_th_editSuccess ,icon:1},function () {
                    // parent.newjump('')
                    location.href='/theAuxiliaryRole'
                })
            }
        },'json')
    })
})