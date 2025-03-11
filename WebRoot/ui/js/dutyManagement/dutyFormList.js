/**
 * 值班管理
 * author:殷冬
 * time:2018-05-12
 * vision:1.0.0
 */

$(function () {
    var basePath=document.getElementById("basePath").value;
//表格初始化
var pageObj=$.tablePage('#pagediv','1160px',[

    {
        width:'251px',
        title:'开始时间',
        name:'startTime'
    },
    {
        width:'251px',
        title:'结束时间',
        name:'endTime'
    },
    {
        width:'284px',
        title:'发布范围',
        name:'',
        selectFun:function (n,obj) {
            var fw="";
            var fw1="";
            var fw2="";
            if(obj.toIdStr!=null){
                if(obj.toIdStr.length<10){
                    fw+=obj.toIdStr;
                }else{
                    fw+=obj.toIdStr.substring(0,10);
                    // return fw;
                }
            }
            if(obj.privIdStr!=null){
                if(obj.privIdStr.length<10){
                    fw1+=obj.privIdStr;
                }else{
                    fw1+=obj.privIdStr.substring(0,10);
                    // return fw1;
                }
            }
            if(obj.userIdStr!=null){
                if(obj.userIdStr.length<10){
                    fw2+=obj.userIdStr;
                }else{
                    fw2+=obj.userIdStr.substring(0,10);
                }
            }
            var str3 =  "<div   title='"+"-部门："+obj.toIdStr+"&#13-角色："+obj.privIdStr+"&#13-人员："+obj.userIdStr+"'>"+fw+fw1+fw2+"</div>"
            return str3;
        }
    },
    {
        width:'251px',
        title:'附件',
        name:'',
        selectFun:function (n,obj) {
            var arr = new Array();
            arr = obj.attachment;
            if(obj.attachmentName!=null){
                for (var i = 0; i < (arr.length); i++) {
                    return '<a type="javascript:;"  href="'+basePath+'download?' + encodeURI(arr[i].attUrl) + '">'+arr[i].attachName+'</a>';
                }
            }else{
                return "";
            }
        }
    },
    {
        width:'170px',
        title:option
    },
],function (me) {
    // me.data.typeId=$('[name="type"]').val();
    // me.data.changeId='1';
    // me.data.exportId='1';

    //1显示  // 2不显示  //不写fn这个属性就是全显示
    me.init("/dutyManagement/getDutyFormManagementList",[
        {name:roleAuthorization_th_ViewDetails}

    ],function () {

    })
})
    $("#report").on("click",function(data){
        window.location.href="/dutyManagement/reportDutyForm";
    });

    $('#pagediv').on('click','.editAndDelete0',function(){
        var dutyId=pageObj.arrs[$(this).attr('data-i')].dutyId;
        $.popWindow("returnSelDutyFormManagement?dutyId="+dutyId,situation,'0','0','1150px','700px');
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
})