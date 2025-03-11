/**
 * Created by ZHUDI on 2017/12/29.
 */
var dataId={
    page:1,//当前处于第几页
    pageSize:10,//一页显示几条
    delStatus:'0'
};
$(function(){
    $('.M-box3').pagination({
        pageCount:10,
        jump:true,
        coping:true,
        homePage:'首页',
        endPage:'末页',
        prevContent:'上页',
        nextContent:'下页'
    });
    init(dataId,$('#j_tb'));

//    销毁
    $('#j_tb').on('click','.deleteData',function(){
        var deleteId=$(this).parents('tr').attr('data-id');
        deleteData(deleteId,dataId)
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
        deleteData(deleteId,dataId);
    });
//    移卷至
    $('#rollIdSelect').on('change',function () {
        var oId=$(this).find('option:selected').val();
        var textTile=$(this).find('option:selected').text();
        var deleteId='';
        $(".checkedChild:checkbox:checked").each(function(){
            var conId=$(this).parents('tr').attr("data-id");
            deleteId+=conId+',';
        });
        if(deleteId == ''){
            layer.msg(file_th_PleaseSelectFile, { icon:5,time:1000});
            return false;
        }
        var datas={
            fileIds:deleteId,
            rollId:oId
        }
        removeToData(textTile,datas,dataId)
    })

})


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
                            secretName=datas[i].secretName;
                        }else if(datas[i].secret == '2'){
                            secretName=datas[i].secretName;
                        }else if(datas[i].secret == '3'){
                            secretName=datas[i].secretName;
                        }else if(datas[i].secret == '4'){
                            secretName=datas[i].secretName;
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
                            '<td>'+function(){
                                    if(datas[i].sendUnit != undefined){
                                        return datas[i].sendUnit;
                                    }else{
                                        return '';
                                    }
                                }()+'</td>' +
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
function deleteData(deleData,dataSele){
    if(deleData==''){
        layer.msg('请选择您要删除的数据',{offset:'30%'});
    }else {
        layer.confirm(dem_th_Dodata, {
            btn: [sure, cancel], //按钮
            title: dem_th_ConfirmationDestruction
        }, function () {
            //确定删除，调接口
            $.ajax({
                type: 'post',
                url: '/rmsFile/destroy',
                dataType: 'json',
                data: {'fileIds': deleData},
                success: function (res) {
                    if (res.flag) {
                        layer.msg(dem_th_DestroySuccess, {icon: 6});
                        init(dataSele, $('#j_tb'))
                    } else {
                        layer.msg(dem_th_Failure, {icon: 6});
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
    layer.confirm(dem_th_Make+titles+dem_th_You, {
        btn: [sure,cancel], //按钮
        title:dem_th_ConfirmMovement
    }, function(){
        //确定删除，调接口
        $.ajax({
            type:'post',
            url:'/rmsFile/updateRollBath',
            dataType:'json',
            data:data,
            success:function(res){
                if(res.flag){
                    layer.msg(dem_th_MobileSuccess, { icon:6});
                    init(dataSele,$('#j_tb'))
                }else{
                    layer.msg(dem_th_MobileFailure, { icon:6});
                }
            }
        });

    }, function(){
        layer.closeAll();
    });
}