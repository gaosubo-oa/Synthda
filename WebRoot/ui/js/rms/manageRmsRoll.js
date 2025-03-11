/**
 * Created by ZHUDI on 2017/12/26.
 */
var dataId={
    page:1,//当前处于第几页
    pageSize:10,//一页显示几条
    roomId:''
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

    //数据展示
    init(dataId,$('#j_tb'));

//			卷库改变
    $('#selectq').on('change',function(){
        var seleId=$(this).find('option:selected').val();
        var data={
            page:1,//当前处于第几页
            pageSize:5,//一页显示几条
            roomId:seleId
        };
        init(data,$('#j_tb'));
    });
//    删除
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
//批量删除
    $('.deleteBtn').on('click',function(){
        debugger;
        var deleteId='';
        $(".checkedChild:checkbox:checked").each(function(){
            var conId=$(this).parents('tr ').attr("data-id");
            deleteId+=conId+',';
        });
        deleteData(deleteId,dataId);
    });
    // 点击跳转详情
    $('#j_tb').on('click','.to_detail',function(){
        $.popWindow("detail?rollId="+$(this).parent().attr("data-id"));
    })

});

//查询数据
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
                        }
                        var secretName='';
                        if(datas[i].secret == '1'){
                            secretName=dem_th_PuDense;
                        }else if(datas[i].secret == '2'){
                            secretName=doc_th_TopSecret;
                        }else if(datas[i].secret == '3'){
                            secretName=doc_th_Confidential;
                        }else if(datas[i].secret == '4'){
                            secretName=doc_th_Secret;
                        }
                        var statusName='';
                        if(datas[i].status == '0'){
                            statusName=doc_th_Unsealed;
                        }else if(datas[i].status == '1'){
                            statusName=doc_th_sealed;
                        }
                        str+='<tr data-id="'+datas[i].rollId+'" data-status="'+datas[i].status+'">' +
                            '<td><input type="checkbox" name="check" class="checkedChild" value=""></td>' +
                            '<td>'+datas[i].rollCode+'</td>' +
                            '<td class="to_detail" style="color:#1687cb;cursor: pointer">'+datas[i].rollName+'</td>' +
                            '<td>'+datas[i].roomName+'</td>' +
                            '<td>'+datas[i].categoryNo+'</td>' +
                            '<td>'+certificateName+'</td>' +
                            '<td>'+secretName+'</td>' +
                            '<td>'+statusName+'</td>' +
                            '<td><a href="javascript:;" class="lookFile" style="margin-right: 10px;">'+doc_th_seeFile+'</a><a href="javascript:;" class="removeData" style="margin-right: 10px;">'+doc_th_DismantlingSealing+'</a><a href="javascript:;" class="editData" style="margin-right: 10px;">'+edit1+'</a><a href="javascript:;" class="deleteData">'+del+'</a></td>' +
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
//查询所有卷库
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

//删除
function deleteData(deleData,dataSele){
    if(deleData==''){
        layer.msg('请选择您要删除的数据',{offset:'30%'});
    }else{
    layer.confirm(event_th_DeleteData, {
        btn: [sure,cancel], //按钮
        title:queding
    }, function(){
        //确定删除，调接口
        $.ajax({
            type:'post',
            url:'/rmsRoll/delete',
            dataType:'json',
            data:{'rollIds':deleData},
            success:function(res){
                if(res.flag){
                    layer.msg(delc, { icon:6});
                    init(dataSele,$('#j_tb'))
                }else{
                    layer.msg(delf, { icon:6});
                }
            }
        });

    }, function(){
        layer.closeAll();
    });
    }
}