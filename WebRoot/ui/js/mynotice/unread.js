/**
 * Created by 骆鹏 on 2018/1/9.
 */
/**
 * Created by 骆鹏 on 2018/1/5.
 */
var specifyTable= $.GetRequest()['specifyTable'] || '';
var noticeType;
var parentNo;
$(function(){
    $.get("/myNotifyConfig/getNotifyType?noticeType="+specifyTable,function(res){
        noticeType = '选择'+res.data.mynotice_type_name
        parentNo = res.data.mynotice_type
        GetDropDownBox()
    })
})
function GetDropDownBox(fn) {
    $.ajax({
        url: "/code/getCode?parentNo="+parentNo,
        type:'get',
        dataType:"JSON",
        success:function(data){
            // var str='<option value="">'+notice_type_alltype+'</option>';
            var str='<option value="">'+noticeType+'</option>';
            // for (var proId in data.obj){
            //     //console.log(data[proId])
            //     // if(){
            //     //
            //     // }
            //     for(var i=0;i<data.obj[proId].length;i++){
            //         if(data.obj[proId].codeNo !=="LDZSJS"){
            //             str += '<option value="'+data.obj[proId].codeNo+'">'+data.obj[proId].codeName+'</option>'
            //         }
            //     }
            // }
            var arr=data.obj;
            for(var i=0;i<arr.length;i++){
                str += '<option value="'+arr[i].codeNo+'" data-isEdit="'+arr[i].isEdit+'">'+arr[i].codeName+'</option>'

            }
            $('[name="type"]').html(str)
            if(fn!=undefined){
                fn()
            }
        }

    })
}
$(function () {
//表格初始化
    var pageObj=$.tablePage('#pagediv','100%',[
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
                        'class="windowOpen" title="'+name+'">'+name+'</a>' +
                        '</div>'
                }else {
                    return '<div style="width: 100%;text-align: left">' +
                        '<a onclick="detail('+obj.notifyId+')" href="javascript:;" ' +
                        'class="windowOpen" title="'+name+'">'+name+'</a>' +
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
        //     title:notice_th_releasescope,
        //     name:'deprange',
        //     selectFun:function (name,obj,i) {
        //         return '<span class="toTypeName" data-i="'+i+'" style="cursor: pointer">'+name+obj.rolerange+obj.userrange+'</span>'
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
        me.data.typeId=$('[name="type"]').val();
        me.data.read='0';
        me.data.sendTime=$('[name="sendTime"]').val();
        me.data.pageSize=10;
        //1显示  // 2不显示  //不写fn这个属性就是全显示
        me.init("/myNotice/notifyManage?specifyTable="+specifyTable,[{name:'s',fn:function (obj) {
            if(obj.typeName==''){
                // return '<span style="color: #000;">'+notice_type_alltype+'</span>'
                return '<span style="color: #000;"></span>'
            }else {
                return '<span style="color: #000;">'+obj.typeName+'</span>'
            }
        }}],function (json) {
            if(!json.flag){
                $.layerMsg({
                    content:noUnread_announcements,
                    icon:1
                },function () {
                    $((parent.$('.head-top li'))[2]).trigger('click')
                })
            }
        })
    })





    $('.submit').click(function () {
        pageObj.data.read='0';
        pageObj.data.sendTime=$('[name="sendTime"]').val();
        pageObj.data.typeId=$('[name="type"]').val();
        pageObj.init()
    })

    $('#pagediv').on('mouseover','.toTypeName',function () {
        var obi=pageObj.arrs[$(this).attr('data-i')];

        layer.tips(userManagement_th_department +':'+obi.deprange+'<br/>' +
            journal_th_user +':'+obi.userrange+'<br/>' +
            userManagement_th_role +':'+obi.rolerange+'',this, {
            tips: [1, '#3595CC'],
            time: 1000
        });
    })



})

function detail(nid) {
    layer.open({
        type: 2,
        title: '公告详情',
        area: ['1200px', '600px'],
        shadeClose: true,
        // btn: ['打印']
        // ,yes: function(){
        //     //alert(111111111111)
        //     window.print();
        // },
        content:'/myNotice/detail?notifyId='+nid+"&specifyTable="+specifyTable,
        cancel: function(){
            window.location.reload();
        }
    });

}
