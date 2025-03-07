/**
 * Created by 骆鹏 on 2018/1/9.
 */
/**
 * Created by 骆鹏 on 2018/1/8.
 */

function GetDropDownBox(fn) {
    $.ajax({
        url: "/code/GetDropDownBox",
        type:'get',
        dataType:"JSON",
        data : {"CodeNos":"NOTIFY"},
        success:function(data){
            // var str='<option value="">'+notice_type_alltype+'</option>';
            var str='<option value="">' + notice_th_chosenotifytype + '</option>';
            for (var proId in data){
                console.log(data[proId])
                // if(){
                //
                // }
                for(var i=0;i<data[proId].length;i++){
                    if(data[proId][i].codeNo !=="LDZSJS"){
                        str += '<option value="'+data[proId][i].codeNo+'">'+data[proId][i].codeName+'</option>'
                    }
                }
            }
            $('[name="typeId"]').html(str)
            if(fn!=undefined){
                fn()
            }
        }

    })
}
function ajaxforms(type) {
    $('.theControlData').each(function () {
        if($(this).attr('user_id')!=undefined) {
            $(this).siblings('input[type=hidden]').val($(this).attr('user_id'))
            return true;
        }
        if($(this).attr('userpriv')!=undefined){
            $(this).siblings('input[type=hidden]').val($(this).attr('userpriv'))
            return true
        }
        if($(this).attr('deptid')!=undefined){
            $(this).siblings('input[type=hidden]').val($(this).attr('deptid'))
        }
    })
    var arrs=$('#ajaxform').serializeArray()
    for(var i=0;i<arrs.length;i++){
        pageObj.data[arrs[i].name]=arrs[i].value;
    }
    //1显示  // 2不显示  //不写fn这个属性就是全显示
    pageObj.init("/notice/notifyManage",[{name:'s',fn:function (obj) {
        if(obj.typeName==''){
            // return '<span style="color: #000;">'+notice_type_alltype+'</span>'
            return '<span style="color: #000;"></span>'
        }else {
            return '<span style="color: #000">'+obj.typeName+'</span>'
        }
    }}],function () {
        $('#pagediv').css('visibility','visible')
        $('.query').hide();
        $('#pagediv').show();
        $('.page-bottom-inner-layer').height(308);
    })
}
var user_id=null;
var pageObj=null;
$(function () {
    GetDropDownBox()
    $('.addroles').on('click',function () {
        user_id = $(this).siblings('textarea').prop('id');
        $.popWindow("../common/selectUser");
    })
    pageObj=$.tablePage('#pagediv','100%',[
        {
            width:'15%',
            title:notice_th_publisher,
            name:'s',
            selectFun:function (n,obj) {
                return obj.users.userName
            }
        },
        {
            width:'50%',
            title:notice_th_title,
            name:'subject',
            selectFun:function (name,obj,i) {
                if(obj.top=='1'){
                    return '<div style="width: 100%;text-align: left">' +
                        '<span style="    color: #fff;\
        background: #ef7559;\
        font-size: 12px;\
        padding: 2px 5px;\
        margin-right: 3px;\
        border-radius: 3px;">'+notice_th_top+'</span>'+
                        '<a onclick="detail('+obj.notifyId+')" href="javascript:;" ' +
                        'class="windowOpen">'+name+'</a>' +
                        '</div>'
                }else {
                    return '<div style="width: 100%;text-align: left">' +
                        '<a onclick="detail('+obj.notifyId+')" href="javascript:;" ' +
                        'class="windowOpen">'+name+'</a>' +
                        '</div>'
                }
            }
        },
        {
            width:'20%',
            title:notice_th_effectivedate,
            name:'begin'
        },
        // {
        //     width:'350px',
        //
        //     title:notice_th_releasescope,
        //     name:'deprange',
        //     selectFun:function (name,obj,i) {
        //         return '<span class="toTypeName" data-i="'+i+'" style="cursor: pointer">'+name+obj.rolerange+obj.userrange+'</span>'
        //
        //     }
        // },
        {
            width:'15%',
            title:notice_th_type,
            name:'typeName',
            selectFun:function (name,obj,i) {
                if(name==''){
                    // return notice_type_alltype
                    return '';
                }else {
                    return name
                }
            }
        }
    ],function (me) {
        me.data.pageSize=10;
    })

    $('#pagediv').on('mouseover','.toTypeName',function () {
        var obi=pageObj.arrs[$(this).attr('data-i')];

        layer.tips(userManagement_th_department+'：'+obi.deprange+'<br/>' +
            journal_th_user+'：'+obi.userrange+'<br/>' +
            userManagement_th_role+'：'+obi.rolerange+'',this, {
            tips: [1, '#3595CC'],
            time: 1000
        });
    })
    $(document).on('click','.chongtian',function () {
        $(':input','#ajaxform')

            .not(':button,:submit,:reset,:hidden')   //将myform表单中input元素type为button、submit、reset、hidden排除

            .val('')  //将input元素的value设为空值

            .removeAttr('checked')

            .removeAttr('checked') // 如果任何radio/checkbox/select inputs有checked or selected 属性，将其移除
    })


})


function detail(nid) {
    //$.popWindow('/notice/detail?notifyId='+nid,'公告详情','20','150','1200px','600px')
    layer.open({
        type: 2,
        title: notice_th_queryDetail,
        area: ['1200px', '600px'],
        shadeClose: true,
        // btn: ['打印']
        // ,yes: function(){
        //     //alert(111111111111)
        //     window.print();
        // },
        content:'/notice/detail?notifyId='+nid,
        cancel: function(){
            layer.closeAll();
        }
    });

}