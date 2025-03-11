/**
 * Created by ZHUDI on 2018/1/2.
 */
$(function(){
    var data;
    $('.M-box3').pagination({
        pageCount:10,
        jump:true,
        coping:true,
        homePage:'首页',
        endPage:'末页',
        prevContent:'上页',
        nextContent:'下页'
    });

    $('.saveBtn_s').on('click',function(){
        data={
            page:1,//当前处于第几页
            pageSize:5,//一页显示几条
            delStatus:0,
            fileCode:$('input[name="fileCode_s"]').val(), //文件号
            fileSubject:$('input[name="fileSubject_s"]').val(), //文件主题词
            fileTitle:$('input[name="fileTitle_s"]').val(), //文件标题
            fileTitle0:$('input[name="fileTitle0_s"]').val(), //文件辅标题
            sendUnit:$('input[name="sendUnit_s"]').val(), //发文单位
            sendDate:$('input[name="sendDate_s"]').val(), //发文日期
            sendDate2:$('input[name="sendDate2"]').val(), //发文日期
            roomId:$('#roomId_s option:selected').val(), //所属卷库
            rollId:$('#rollId_s option:selected').val(), //所属案卷
            secret:$('#secret_s option:selected').val(), //密级
            urgency:$('#urgency_s option:selected').val(), //紧急等级
            fileType:$('#fileType_s option:selected').val(), //文件分类
            fileKind:$('#fileKind_s option:selected').val(), //公文类别
            filePage:$('input[name="filePage_s"]').val(), //文件页数
            filePage2:$('input[name="filePage2"]').val(), //文件页数
            printPage:$('input[name="printPage_s"]').val(), //打印页数
            printPage2:$('input[name="printPage2"]').val(), //打印页数
            remark:$('input[name="remark_s"]').val(), //备注
        }
        $('.juMange').show().siblings().hide();
        init(data,$('#j_tb'));
    })
//    重置
    $('.resetBtn_s').on('click',function(){
        $('input[name="fileCode_s"]').val(''), //文件号
        $('input[name="fileSubject_s"]').val(''); //文件主题词
        $('input[name="fileTitle_s"]').val(''); //文件标题
        $('input[name="fileTitle0_s"]').val(''); //文件辅标题
        $('input[name="sendUnit_s"]').val(''); //发文单位
        $('input[name="sendDate_s"]').val(''); //发文日期
        $('input[name="sendDate2"]').val(''); //发文日期
        $('#roomId_s').val(''); //所属卷库
        $('#rollId_s').val(''); //所属案卷
        $('#secret_s').val(''); //密级
        $('#urgency_s').val(''); //紧急等级
        $('#fileType_s').val(''); //文件分类
        $('#fileKind_s').val(''); //公文类别
        $('input[name="filePage_s"]').val(''); //文件页数
        $('input[name="filePage2"]').val(''); //文件页数
        $('input[name="printPage_s"]').val(''); //打印页数
        $('input[name="printPage2"]').val(''); //打印页数
        $('input[name="remark_s"]').val(''); //备注
    });

    //		编辑保存
    $('.saveBtn').on('click',function(){
        if($('input[name="fileCode"]').val() == ''){
            layer.msg('请填写文件号！', { icon:5,time:1000});
            return false;
        }
        if($('input[name="fileSubject"]').val() == ''){
            layer.msg('请填写文件主题词！', { icon:5,time:1000});
            return false;
        }
        if($('input[name="fileTitle"]').val() == ''){
            layer.msg('请填写文件标题！', { icon:5,time:1000});
            return false;
        }
        if($('#secret option:selected').val() == ''){
            layer.msg('请选择密级！', { icon:5,time:1000});
            return false;
        }
        var aId='';
        var uId='';
        for(var i=0;i<$('.attachNameDiv .inHidden').length;i++){
            aId+=$('.attachNameDiv .inHidden').eq(i).val();
        }
        for(var i=0;i<$('.attachNameDiv .dech').length;i++){
            uId+=$('.attachNameDiv .dech').eq(i).find('a').attr('NAME');
        }
        $('input[name="attachmentId"]').val(aId);
        $('input[name="attachmentName"]').val(uId);

        $('#form1').ajaxSubmit({
            type: 'post',
            dataType: 'json',
            success: function (res) {
                if (res.flag) {
                    $.layerMsg({content: '保存成功！', icon: 1}, function () {
//                            location.reload();
                        $('.juMange').show().siblings().hide();
                        init(data,$('#j_tb'));
                    });
                } else {
                    $(this).attr('data-type',true)
                    alert('异常')
                }

            }
        })

    });

    //    销毁
    $('#j_tb').on('click','.deleteData',function(){
        var deleteId=$(this).parents('tr').attr('data-id');
        deleteData(deleteId,data)
    });
//    复选框
    $('#j_tb').on('click','.checkedChild',function(){
        var state =$(this).prop("checked");
        if(state==true){
            $(this).prop("checked",true);
        }else{
            $('#checkedAll').prop("checked",false);
            $(this).prop("checked",false);
        }
        var child =   $(".checkedChild");
        for(var i=0;i<child.length;i++){
            var childstate= $(child[i]).prop("checked");
            if(state!=childstate){
                return
            }
        }
        $('#checkedAll').prop("checked",state);
    });
//批量销毁
    $('.deleteBtn').on('click',function(){
        var deleteId='';
        $(".checkedChild:checkbox:checked").each(function(){
            var conId=$(this).parents('tr').attr("data-id");
            deleteId+=conId+',';
        });
        deleteData(deleteId,data);
    });
//    移卷至
    $('#rollIdSelect').on('change',function(){
        var oId=$(this).find('option:selected').val();
        var textTile=$(this).find('option:selected').text();
        var deleteId='';
        $(".checkedChild:checkbox:checked").each(function(){
            var conId=$(this).parents('tr').attr("data-id");
            deleteId+=conId+',';
        });
        if(deleteId == ''){
            layer.msg('请选择文件', { icon:5,time:1000});
            return false;
        }
        var datas={
            fileIds:deleteId,
            rollId:oId
        }
        removeToData(textTile,datas,data)
    })

})

function queryAllAnjuan(element){
    $.ajax({
        type:'get',
        url:'/rmsRollRoom/selectAll',
        dataType:'json',
        success:function(res){
            var data=res.obj;
            var str='';
            for(var i=0;i<data.length;i++){
                str+='<option value="'+data[i].roomId+'">'+data[i].roomName+'</option>';
            }
            element.append(str);
        }
    })
}

//查询数据
function init(dataId,element) {
    var ajaxPage={
        data:dataId,
        page:function () {
            element.find('tr').remove();
            var me=this;
            $.ajax({
                type:'get',
                url:'/rmsFile/query',
                dataType:'json',
                data:me.data,
                success:function(res) {
                    var datas=res.obj;
                    var str='';
                    for(var i=0;i<datas.length;i++){
                        // var certificateName='';
                        // if(datas[i].certificateKind == '1'){
                        //     certificateName='XXX1';
                        // }else if(datas[i].certificateKind == '2'){
                        //     certificateName='XXX2';
                        // }
                        var secretName='';
                        if(datas[i].secret == '1'){
                            secretName='普密';
                        }else if(datas[i].secret == '2'){
                            secretName='绝密';
                        }else if(datas[i].secret == '3'){
                            secretName='机密';
                        }else if(datas[i].secret == '4'){
                            secretName='秘密';
                        }
                        // var statusName='';
                        // if(datas[i].status == '0'){
                        //     statusName='未封卷';
                        // }else if(datas[i].status == '1'){
                        //     statusName='已封卷';
                        // }
                        str+='<tr data-id="'+datas[i].fileId+'" data-status="'+datas[i].status+'">' +
                            '<td><input type="checkbox" name="check" class="checkedChild" value=""></td>' +
                            '<td>'+datas[i].fileCode+'</td>' +
                            '<td class="to_detail" style="color:#1687cb;cursor: pointer">'+datas[i].fileTitle+'</td>' +
                            '<td>'+secretName+'</td>' +
                            '<td>'+datas[i].sendUnit+'</td>' +
                            '<td>'+function(){
                                if(datas[i].sendDate != undefined){
                                    return datas[i].sendDate;
                                }else{
                                    return '';
                                }
                            }()+'</td>' +
                            '<td>'+datas[i].rollName+'</td>' +
                            '<td><a href="javascript:;" class="eaitData" style="margin-right: 10px;">编辑</a><a href="javascript:;" class="deleteData" style="margin-right: 10px;">销毁</a></td>' +
                            '</tr>'
                    }

                    element.append(str);
                    me.pageTwo(res.totleNum,me.data.pageSize,me.data.page)
                }
            })

        },
        pageTwo:function (totalData, pageSize,indexs) {
            var mes=this;
            $('#dbgz_page').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage:'',
                endPage: '',
                current:indexs||1,
                callback: function (index) {
                    mes.data.page=index.getCurrent();
                    mes.page();
                }
            });
        }
    };
    ajaxPage.page();
}

//销毁
function deleteData(deleData,dataSele) {
    if(deleData==''){
        layer.msg('请选择您要删除的数据',{offset:'30%'});
    }else {
    layer.confirm('确定要销毁数据吗？', {
        btn: ['确定', '取消'], //按钮
        title: "确认销毁"
    }, function () {
        //确定删除，调接口
        $.ajax({
            type: 'post',
            url: '/rmsFile/destroy',
            dataType: 'json',
            data: {'fileIds': deleData},
            success: function (res) {
                if (res.flag) {
                    layer.msg('销毁成功', {icon: 6});
                    init(dataSele, $('#j_tb'))
                } else {
                    layer.msg('销毁失败', {icon: 6});
                }
            }
        });

    }, function () {
        layer.closeAll();
    });
}
}

//    移动至其他卷库
function removeToData(titles,data,dataSele){
        layer.confirm('确定要将数据移至' + titles + '吗？', {
            btn: ['确定', '取消'], //按钮
            title: "确认移动"
        }, function () {
            //确定删除，调接口
            $.ajax({
                type: 'post',
                url: '/rmsFile/updateRollBath',
                dataType: 'json',
                data: data,
                success: function (res) {
                    if (res.flag) {
                        layer.msg('移动成功', {icon: 6});
                        init(dataSele, $('#j_tb'))
                    } else {
                        layer.msg('移动失败', {icon: 6});
                    }
                }
            });

        }, function () {
            layer.closeAll();
        });
}