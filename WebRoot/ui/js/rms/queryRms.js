/**
 * Created by ZHUDI on 2017/12/26.
 */
$(function () {
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
//    查询
    $('.saveBtn_s').on('click',function(){
        var deptOne=0;
        if(typeof($("#deptId_s").attr("deptid"))!="undefined"){
            deptOne=$('#deptId_s').attr('deptid').replace(/,/g,'');
        }
        data={
            page:1,//当前处于第几页
            pageSize:5,//一页显示几条
            rollCode:$('input[name="rollCode_s"]').val(), //案卷号
            rollName:$('input[name="rollName_s"]').val(),//案卷名称
            years:$('input[name="years_s"]').val(), //归卷年代
            beginDate:$('input[name="beginDate_s"]').val(), //起始日期
            beginDate2:$('input[name="beginDate2"]').val(), //起始日期
            endDate:$('input[name="endDate_s"]').val(), //终止日期
            endDate2:$('input[name="endDate2"]').val(), //终止日期
            deadline:$('input[name="deadline_s"]').val(), //保管期限
            deadline2:$('input[name="deadline2"]').val(), //保管期限
            categoryNo:$('input[name="categoryNo_s"]').val(), //全宗号
            catalogNo:$('input[name="catalogNo_s"]').val(), //目录号
            archiveNo:$('input[name="archiveNo_s"]').val(), //档案馆号
            boxNo:$('input[name="boxNo_s"]').val(), //保险箱号
            microNo:$('input[name="microNo_s"]').val(), //缩微号
            certificateStart:$('input[name="certificateStart_s"]').val(), //凭证编号（起）
            certificateStart2:$('input[name="certificateStart2"]').val(), //凭证编号（起）
            certificateEnd:$('input[name="certificateEnd_s"]').val(), //凭证编号（止）
            certificateEnd2:$('input[name="certificateEnd2"]').val(), //凭证编号（止）
            rollPage:$('input[name="rollPage_s"]').val(), //页数
            rollPage2:$('input[name="rollPage2"]').val(), //页数
            remark:$('input[name="remark_s"]').val(), //备注
            roomId:$('#roomId_s option:selected').val(), //所属卷库
            secret:$('#secret_s option:selected').val(), //案卷密级
            certificateKind:$('#certificateKind_s option:selected').val(), //凭证类别
            deptId:deptOne
        }
        $('.dataMange').show().siblings().hide();
        init(data,$('#j_tb'));
    })
    //			查看文件
    $('#j_tb').on('click','.lookFile',function(){
        var dataId=$(this).parents('tr').attr('data-id');
        parent.$('.iframeShow').eq(3).show().siblings().hide();
//                var test=$("#iframeShow").contents().find("#hiddenId");
//                test.val(dataId);
        parent.$('#iframeFour').attr('src','/rmsRoll/lookFile?rollId='+dataId);
    })
    //			拆卷/封卷
    $('#j_tb').on('click','.removeData',function(){
        var dataid=$(this).parents('tr').attr('data-id');
        var statusId=$(this).parents('tr').attr('data-status');
        if(statusId == '0'){
            statusId='1';
        }else{
            statusId='0';
        }
        $.ajax({
            type:'post',
            url:'/rmsRoll/update',
            dataType:'json',
            data:{
                rollId:dataid,
                status:statusId
            },
            success:function(res){
                if(res.flag){
                    $.layerMsg({content: '操作成功！', icon: 1});
                    init(data,$('#j_tb'));
                }else{
                    $.layerMsg({content: '操作失败！', icon: 2});
                }
            }
        })
    })
    //    删除
    $('#j_tb').on('click','.deleteData',function(){
        var deleteId=$(this).parents('tr').attr('data-id');
        deleteData(deleteId,data)
    })
})

//查询列表
function init(dataId,element) {
    var ajaxPage={
        data:dataId,
        page:function () {
            element.find('tr').remove();
            var me=this;
            $.ajax({
                type:'get',
                url:'/rmsRoll/query',
                dataType:'json',
                data:me.data,
                success:function(res) {
                    var datas=res.obj;
                    var str='';
                    for(var i=0;i<datas.length;i++){
                        var certificateName='';
                        if(datas[i].certificateKind == '1'){
                            certificateName='XXX1';
                        }else if(datas[i].certificateKind == '2'){
                            certificateName='XXX2';
                        };
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
                        var statusName='';
                        if(datas[i].status == '0'){
                            statusName='未封卷';
                        }else if(datas[i].status == '1'){
                            statusName='已封卷';
                        }
                        str+='<tr data-id="'+datas[i].rollId+'" data-status="'+datas[i].status+'">' +
                            '<td><input type="checkbox" name="check" class="checkedChild" value=""></td>' +
                            '<td>'+datas[i].rollCode+'</td>' +
                            '<td>'+datas[i].rollName+'</td>' +
                            '<td>'+datas[i].roomName+'</td>' +
                            '<td>'+datas[i].categoryNo+'</td>' +
                            '<td>'+certificateName+'</td>' +
                            '<td>'+secretName+'</td>' +
                            '<td>'+statusName+'</td>' +
                            '<td><a href="javascript:;" class="lookFile" style="margin-right: 10px;">查看文件</a><a href="javascript:;" class="removeData" style="margin-right: 10px;">拆卷/封卷</a><a href="javascript:;" class="editData" style="margin-right: 10px;">编辑</a><a href="javascript:;" class="deleteData">删除</a></td>' +
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
    }
    ajaxPage.page();
}


//删除
function deleteData(deleData,dataSele){
    layer.confirm('确定要删除此条数据吗？', {
        btn: ['确定','取消'], //按钮
        title:"确认删除"
    }, function(){
        //确定删除，调接口
        $.ajax({
            type:'post',
            url:'/rmsRoll/delete',
            dataType:'json',
            data:{'rollIds':deleData},
            success:function(res){
                if(res.flag){
                    layer.msg('删除成功', { icon:6});
                    init(dataSele,$('#j_tb'))
                }else{
                    layer.msg('删除失败', { icon:6});
                }
            }
        });

    }, function(){
        layer.closeAll();
    });
}