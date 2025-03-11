/**
 * Created by 骆鹏 on 2018/1/5.
 */
function GetDropDownBox(fn) {
    $.ajax({
        url: "/sys/getNotifyTypeList?CodeNos=NOTIFY",
        type:'get',
        dataType:"JSON",
        success:function(data){
            var arr=data.obj;
            // var str='<option value="">'+notice_type_alltype+'</option>';
            var str='<option value="">选择公告类型</option>';
            for (var i=0;i<arr.length;i++){

                str += '<option value="'+arr[i].codeNo+'">'+arr[i].codeName+'</option>'


            }
            $('[name="type"]').html(str)
            if(fn!=undefined){
                fn()
            }
        }

    })
}
var notifyId = $.GetRequest().notifyId
$(function () {
    GetDropDownBox()
    var bodyWidth=$('body').width();
    var width0=bodyWidth*0.04 + 'px';
    var width1=bodyWidth*0.07 + 'px';
    var width2=bodyWidth*0.07 + 'px';
    var width3=bodyWidth*0.07 + 'px';
    var width4=bodyWidth*0.13 + 'px';
    var width5=bodyWidth*0.13 + 'px';
    var width6=bodyWidth*0.20 + 'px';
    var width7=bodyWidth*0.10 + 'px';

    var width8=bodyWidth*0.07 + 'px';
    var width9=bodyWidth*0.12 + 'px';
//表格初始化
    var pageObj=$.tablePage('#pagediv',bodyWidth+'px',[
        {
            width:width0,
            title:'选择',
            name:'',
            selectFun:function (n,obj) {
                return '<input type="checkbox" class="choose" data-id="'+obj.userId+'">'
            }
        },
        {
            width:width3,
            title:"状态",
            name:'stateStr',
            selectFun:function (n,obj) {
                if(obj.state=='0'||obj.state=='2'){
                    return '<span style="color:green">'+obj.stateStr+'</span>'
                }else if(obj.state=='1'){
                    return '<span style="color:blue">'+obj.stateStr+'</span>'
                }else{
                    return '<span style="color:red">'+obj.stateStr+'</span>'
                }
                // return '<input type="checkbox" class="choose" data-id="'+obj.userId+'">'
            }
        },
        {
            width:width8,
            title:"发布人",
            name:'fromName'
        },
        {
            width:width9,
            title:"任务发布时间",
            name:'endTime'
        },
        {
            width:width1,
            title:"填报人",
            name:'userName'
        },
        {
            width:width2,
            title:"填报部门",
            name:'deptName'
        },
        {
            width:width4,
            title:"填报时间",
            name:'inuputTime',
          /*  selectFun:function (name,obj,i) {
                if(name!=undefined){
                    return new Date(name).Format('yyyy-MM-dd hh:mm:ss')
                }else{
                    return ''
                }
            }*/
        },
        {
            width:width5,
            title:"修改时间",
            name:'updateTime',
            // selectFun:function (name) {
            //     if(name!=undefined){
            //         return new Date(name).Format('yyyy-MM-dd hh:mm:ss')
            //     }else{
            //         return ''
            //     }
            //
            // }
        },
        {
            width:width6,
            title:"附件",
            name:'attachmentName',
            selectFun:function (name,obj) {
               /* var str=''
                if(obj.attachmentList!=null){
                    for(var i=0;i<obj.attachmentList.length;i++){
                        str += '<a href="/download?'+obj.attachmentList[i].attUrl+'">'+obj.attachmentList[i].attachName+'</a></br>'
                    }
                }*/
                var arr = obj.attachmentList;
                if (arr != null){
                    return attachView(arr,'','3','0','1','0');
                }
               return "";
            }
        },
        {
            width:width7,
            title:'操作'
        },
    ],function (me) {

        me.data.notyId = notifyId;
        me.data.pageSize=10;

        //1显示  // 2不显示  //不写fn这个属性就是全显示
        me.init("/myNotice/finddetailOpin",[
            {name:"退回",fn:function(obj){
                    if(obj.state==0||obj.state==2){
                        return 1
                    }else{
                        return 2
                    }
                }},
            {name:"催办",fn:function(obj){
                    if(obj.state==0||obj.state==2){
                        return 2
                    }else{
                        return 1
                    }
                }},
            {name:"查看",fn:function(obj){
                    if(obj.state==null){
                        return 2
                    }else{
                        return 1
                    }
                }}
        ],function (obj) {
            //鼠标移入附件名显示附件操作
            $('#pagediv').on('mouseover','.divShow',function () {
                $(this).find('.operationDiv').show();
            })
            $('#pagediv').on('mouseout','.divShow',function () {
                $(this).find('.operationDiv').hide();
            })

            var strh='<tr>' +
                '<td colspan="9">' +
                '<a href="/myNotice/finddetailOpin?isOut=true&notyId='+notifyId+'" id="outputs">导出回执信息</a>'+
                '<a href="/myNotice/downLoadZipAttachment?notifyId='+notifyId+'" id="downLoads" style="margin-left: 20px;">批量下载附件</a>'+
                '</td>' +
                '</tr>'

            var str='<tr>' +
                '<td style="width: 400px;text-align: left;"><input type="checkbox" name="all"><span>'+notice_th_allchose+'</span></td>' +
                '<td colspan="9" style="text-align: left">' +
                '<a href="javascript:;" id="plcb">批量催办</a>'+
                '<a href="javascript:;" id="plback" style="margin-left: 20px;">批量退回</a>'+
                '</td>' +
                '</tr>'
            $('#operation').html(str)
            $('#header').html(strh)
            $('#header').css("margin-left",width6)
            $('#fk').html(obj.obj1.yiHuiZhi)
            $('#wfk').html(obj.obj1.weiHuiZhi)
            $('#qb').html(obj.obj1.quanBuRenYuan)
            $('#th').html(obj.obj1.huiZhiTuiHui)
        })
    })



    // 事件绑定处理
    $('#pagediv').on('click','[name="all"]',function(){//全选
        if($(this).is(':checked')){
            $('#pageTbody').find('input[type=checkbox]').prop('checked',true)
        }else {
            $('#pageTbody').find('input[type=checkbox]').removeProp('checked')
        }
    })
    //批量催办
    $('#pagediv').on('click','#plcb',function(){
        var userIds = ''
        for(var i=0;i<$('#pageTbody').find('input[type=checkbox]:checked').length;i++){
            userIds += $('#pageTbody').find('input[type=checkbox]:checked').eq(i).attr('data-id')+','
        }
        layer.confirm("您确定要催办未回执人员吗?", {
            btn: [sure,cancel] ,//按钮
            title:"是否催办"
        }, function(){
            //催办，调接口
            $.ajax({
                url: "/myNotice/urgeOpin",
                type: "get",
                data:{
                    notifyId:notifyId,
                    userIds:userIds
                },
                dataType: 'json',
                success: function (json) {
                    if (json.flag) {
                        $.layerMsg({content: "催办成功", icon: 1,title:"asd"}, function () {

                            pageObj.init('/myNotice/finddetailOpin')
                        })
                    }
                }
            })

        }, function(){
            layer.closeAll();
        });

    })
    //批量退回
    $('#pagediv').on('click','#plback',function(){
        var userIds = ''
        for(var i=0;i<$('#pageTbody').find('input[type=checkbox]:checked').length;i++){
            userIds += $('#pageTbody').find('input[type=checkbox]:checked').eq(i).attr('data-id')+','
        }
        if(userIds==''){
            $.layerMsg({content:'请选择人员',icon:6});
            return false;
        }
        layer.confirm("您确定要退回吗?", {
            btn: [sure,cancel] ,//按钮
            title:"是否退回"
        }, function(){
            //催办，调接口
            $.ajax({
                url: "/myNotice/returnOpinion",
                type: "get",
                data:{
                    notifyId:notifyId,
                    userId:userIds
                },
                dataType: 'json',
                success: function (json) {
                    if (json.flag) {
                        $.layerMsg({content: "退回成功", icon: 1,title:"asd"}, function () {
                            pageObj.init('/myNotice/finddetailOpin')
                        })
                    }
                }
            })

        }, function(){
            layer.closeAll();
        });

    })
    //导出回执信息
    $('.navigation').on('click','#output',function(){

        $.ajax({
            url: "/myNotice/outputNotifyOpin",
            type: "get",
            data:{
                notifyId:notifyId
            },
            dataType: 'json',
            ContentType:"application/vnd.ms-excel",
            success: function (json) {
                if (json.flag) {
                    $.layerMsg({content: "导出成功", icon: 1,title:"asd"}, function () {
                    })
                }
            }
        })

    })
    //批量下载附件
    $('.navigation').on('click','#downLoad',function(){
        $.ajax({
            url: "/myNotice/downLoadZipAttachment",
            type: "get",
            data:{
                notifyId:notifyId
            },
            ContentType:"multipart/form-data",
            dataType: 'json',
            success: function (json) {
            }
        })

    })


    $('#pagediv').on('click','.notice_top',function(){//置顶
        if($('#pageTbody').find('input[type=checkbox]:checked').length==0){
            $.layerMsg({content:notice_th_dj,icon:2});
            return;
        }
        var fileId=[];
        $('#pageTbody').find('input[type=checkbox]:checked').each(function(){
            var conId=$(this).attr("data-id");
            fileId.push(conId);
        })
        layer.confirm(ConfirmTop, {
            btn: [sure,cancel], //按钮
            title:SetTop
        }, function(){

            $.ajax({
                type:'post',
                url:'/myNotice/updateByIds',
                dataType:'json',
                data:{
                    notifyIds:fileId,
                    top:'1'
                },
                success:function(json){
                    if(json.flag) {
                        $.layerMsg({content: TopSuccess, icon: 1}, function () {
                            pageObj.init('/myNotice/finddetailOpin');
                        })
                    }else {
                        $.layerMsg({content: TopFailure, icon: 2})
                    }

                }
            })

        });
    })



    $('#pagediv').on('click','.notice_notop',function(){//取消置顶
        if($('#pageTbody').find('input[type=checkbox]:checked').length==0){
            $.layerMsg({content:notice_th_dj,icon:2});
            return;
        }
        var fileId=[];
        $('#pageTbody').find('input[type=checkbox]:checked').each(function(){
            var conId=$(this).attr("data-id");
            fileId.push(conId);
        })
        layer.confirm(notice_th_dd, {
            btn: [sure,cancel], //按钮
            title:notice_th_Determine
        }, function(){
            $.ajax({
                type:'post',
                url:'/myNotice/updateByIds',
                dataType:'json',
                data:{
                    notifyIds:fileId,
                    top:'0'
                },
                success:function(json){
                    if(json.flag) {
                        $.layerMsg({content: notice_th_CancelTopSuccess, icon: 1}, function () {
                            pageObj.init('/myNotice/finddetailOpin');
                        })
                    }else {
                        $.layerMsg({content: notice_th_CancelTopF, icon: 2})
                    }

                }
            })

        });
    })







    //退回
    $('#pagediv').on('click','.editAndDelete0',function(){
        var notifyId=pageObj.arrs[$(this).attr('data-i')].notyId;
        var userId=pageObj.arrs[$(this).attr('data-i')].userId;
        layer.confirm("您确定要退回吗?", {
            btn: [sure,cancel] ,//按钮
            title:"是否退回"
        }, function(){
            //催办，调接口
            $.ajax({
                url: "/myNotice/returnOpinion",
                type: "get",
                data:{
                    notifyId:notifyId,
                    userId:userId
                },
                dataType: 'json',
                success: function (json) {
                    if (json.flag) {
                        $.layerMsg({content: "退回成功", icon: 1,title:"asd"}, function () {
                            pageObj.init('/myNotice/finddetailOpin')
                        })
                    }
                }
            })

        }, function(){
            layer.closeAll();
        });
    })
    //查看
    $('#pagediv').on('click','.editAndDelete2',function(){
        var data=pageObj.arrs[$(this).attr('data-i')];
        console.log(data)

        layer.open({
            title:'回执详情',
            area:['500px','600px'],
            type:1,
            btn:['返回'],
            content:'<table style="width:98%;margin:10px auto;">' +
                function(){
                    var str = ''
                    for(var k in data){
                        if(k.indexOf('field')>=0&&data[k]!=''){
                            var arr = data[k].split(':')
                            str += '<tr style="margin-left:10px;margin-top:10px"><td style="font-weight: bold;padding-right:10px;text-align:center;    font-weight: bold;\n' +
                                '    padding-right: 10px;\n' +
                                '    display: inline-block;\n' +
                                '    width: 30%;\n' +
                                ' ">'+arr[0]+':</td><td style="display: inline-block;\n' +
                                '    width: 65%;    vertical-align: top;">'+arr[1]+'</td></tr>'
                        }
                    }


                    var attachmentList= data.attachmentList;
                    if(attachmentList!=null){
                        str +='<tr style="margin-left:10px;margin-top:10px"><td style="font-weight: bold;padding-right:10px;text-align:center;    font-weight: bold;\n' +
                            '    padding-right: 10px;\n' +
                            '    display: inline-block;\n' +
                            '    width: 30%;\n' +
                            ' ">附件:</td><td style="display: inline-block;\n' +
                            '    width: 65%;    vertical-align: top;">'+function(){
                            var str2=""
                                for(var i=0;i<attachmentList.length;i++){
                                    str2 += '<a href="/download?'+attachmentList[i].attUrl+'">'+attachmentList[i].attachName+'</a></br>'
                                }
                                return str2;
                            }()+'</td></tr>'
                        // str += '<td style=" font-weight: bold;width: 35%;  ">附件：</td><td style="font-weight: bold;padding-right:10px;text-align:right; width: 65%;   ">';

                        str +='</table>';
                    }

                    return str
                }()
        })
    })
    //催办
    $('#pagediv').on('click','.editAndDelete1',function(){
        // var notifyId=pageObj.arrs[$(this).attr('data-i')].notyId;
        var userids  =
            layer.confirm("您确定要催办未回执人员吗?", {
                btn: [sure,cancel] ,//按钮
                title:"是否催办"
            }, function(){
                //催办，调接口
                $.ajax({
                    url: "/myNotice/urgeOpin",
                    type: "get",
                    data:{
                        notifyId:notifyId
                    },
                    dataType: 'json',
                    success: function (json) {
                        if (json.flag) {
                            $.layerMsg({content: "催办成功", icon: 1,title:"asd"}, function () {

                                pageObj.init('/myNotice/finddetailOpin')
                            })
                        }
                    }
                })

            }, function(){
                layer.closeAll();
            });
    })

    $('#pagediv').on('click','.editAndDelete5',function(){
        var notifyId=pageObj.arrs[$(this).attr('data-i')].notifyId;
        $.popWindow("finddetailOpinion?notifyId="+notifyId,situation,'0','0','1350px','700px');
    })

    $('#pagediv').on('click','.editAndDelete2',function(){
        var notifyId=pageObj.arrs[$(this).attr('data-i')].notifyId;
        parent.$('[name="notices"]').attr('src','../../myNotice/newAndEdit?type=edit&notifyId='+notifyId)
    })



    $('.submit').click(function () {
        pageObj.data.read='';
        pageObj.data.typeId=$('[name="type"]').val();
        pageObj.data.changeId='1';
        pageObj.data.exportId='1';

        if($('#status').val()!=0||$('#status').val()==""){
            pageObj.data.publish=$('#status').val();
            pageObj.init('/myNotice/finddetailOpin')
        }else{
            pageObj.data.page=1;
            pageObj.data.publish=undefined;
            pageObj.init('/myNotice/selectNotifyOverTime')
        }

    })
    // $('#pagediv').on('click','.query',function(){//全选
    //
    // })


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