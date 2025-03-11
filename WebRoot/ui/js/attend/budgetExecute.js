var userId=$.cookie('userId');
var userName=$.cookie('userName');
var zero='0';
var timer;
var flowID='';
var myDate = new Date();
//获取当前年
var year=myDate.getFullYear();
//获取当前月
var month=myDate.getMonth()+1;
if(month>=10){
    timer=year+'-'+month;
}else {
    timer=year+'-'+zero+month;
}
function undefindData(data) {
    if(data == undefined){
        return '';
    }else{
        return data;
    }
}
$(function(){
    //新建预算
    $('#busTravelData').click(function(){
        layer.open({
            type: 1,
            title:['新建预算', 'background-color:#2b7fe0;color:#fff;'],
            area: ['520px', '280px'],
            shadeClose: true, //点击遮罩关闭
            btn: [sure, cancel],
            content: '<div class="newsAdd" style="padding-left: 5px;">' +
            '<input id="userId" type="hidden" value="'+userId+'">'+
            '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 100%;margin-top: 20px;">' +
            '<tr class="applicant" >' +
            '<td>'+sup_th_Applicant+'：</td>' +
            '<td><input type="text" name="userName" style="width: 180px;" value="  '+userName+'" ></td>' +
            '</tr>' +
            '<tr>' +
            '<td>'+hr_th_RegistrationTime+'：</td>' +
            '<td><input type="text" style="width: 180px;" name="begainTime" id="start" class="inputTd" value=" '+getNowFormatDate()+'" /></td>' +
            '</tr>' +
            '</table>' +
            '</div>',
            yes:function(index){
                var val  = $('#userId').val();
                var createDate = $('#start').val()
                $.ajax({
                    type:'get',
                    url:'../budget/addBudgetingProcess?'+'applicant='+val+'&createDate='+createDate,
                    dataType:'json',
                    data:{
                        applicant:val ,
                        createDate:$('#start').val(),
                    },
                    success:function(res){
                        var data =res.data;
                        console.log(data);
                        $('thead tr').attr('flowID',data.flowId);
                        var flowID =$('thead tr').attr('flowID');
                        $('thead tr').attr('tableItem',data.tableName)
                        var  tableItem = $('thead tr').attr('tableItem')
                        var flowStep = $('thead tr').attr('flowStep');
                        $('thead tr').attr('runId',data.runId);
                        var runId = $('thead tr').attr('runId')
                        $('thead tr').attr('tabId',data.id);
                        var tabId = $('thead tr').attr('tabId')
                        if(res){
                            $.popWindow('../workflow/work/workform?flowId='+flowID+'&runId='+runId+'&tableName='+tableItem+'&tabId='+tabId+'&flowStep=1&prcsId=1&opflag=1&type=new&isNomalType=true');
                        }
                    }
                });
                layer.close(index);

            },
        });
    })
    var ajaxPageTr={
        data:{
            page:1,//当前处于第几页
            pageSize:5,//一页显示几条
            useFlag:true
            // computationNumber:null
        },
        page:function () {
            /*$('.busTravelData').siblings().remove();*/
            var me=this;
            layer.msg('加载中', {
                icon: 16
                ,shade: 0.01
            });
            $.ajax({
                type:'get',
                url:'/budget/queryAllBudgetingProcess',
                dataType:'json',
                data:me.data,
                success:function(res){
                    var data=res.obj;
                    var str='';
                    for(var i=0;i<data.length;i++){
                       /* var arrTime = data[i].applicationDate.split(" ");*/
                        str+='<tr>' +
                            '<td title="'+data[i].runId +'">'+data[i].runId +'</td>' +
                            '<td title="'+data[i].runName +'">'+data[i].runName +'</td>' +
                            '<td title="'+data[i].applicantName+'">'+data[i].applicantName+'</td>' +
                            '<td title="'+data[i].department+'">'+data[i].department+'</td>' +
                            /*'<td title="'+arrTime[0]+'&nbsp;'+arrTime[1]+'">'+data[i].applicationDate+'</td>' +*/
                            '<td>'+undefindData(data[i].applicationDate) +'</td>' +
                            '<td>'+function () {
                                if(data[i].step != 1){
                                    return '<a href="/workflow/work/workformPreView?flowId='+data[i].flowId+'&flowStep='+data[i].step+'&runId='+data[i].runId+'&prcsId='+data[i].realPrcsId+'" target="_blank">查看详情</a>'
                                }else {
                                    return '<a href="/workflow/work/workform?opflag=1&flowId='+data[i].flowId+'&flowStep='+data[i].step+'&runId='+data[i].runId+'&tableName=budgeting_process&prcsId='+data[i].realPrcsId+'&tabId='+data[i].id+'" target="_blank" style="margin-right: 10px">办理</a>';

                                }
                            }()+'</td>'+
                            '</tr>';
                    }
                    $('tbody').html(str);
                    layer.closeAll();
                    me.pageTwo(res.totleNum,me.data.pageSize,me.data.page)
                }
            })

        },
        pageTwo:function (totalData, pageSize,indexs) {
            var mes=this;
            $('#outTravel').pagination({
                totalData: totalData,
                showData: pageSize,
                prevContent:'上一页',
                nextContent:'下一页',
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
    ajaxPageTr.page();
    /*$('.table').on('click','.deleteBtn',function () {
        var dataId=$(this).attr('data-id');
        deleteData(dataId)
    })*/
    function deleteData(dataId) {
        layer.confirm('确定要删除该条数据吗？', {
            btn: ['确定','取消'], //按钮
            title:"删除"
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'get',
                url:'/workflow/work/deleteRunPrcs',
                dataType:'json',
                data:{
                    frpId:dataId
                },
                success:function(res){
                    if(res.flag == true){
                        layer.msg('删除成功！', { icon:6});
                            ajaxPageTr.page();
                    }else{
                        layer.msg('删除失败！', { icon:6});
                    }
                }
            });

        }, function(){
            layer.closeAll();
        });
    }
})

function getNowFormatDate() {

    return new Date().Format('yyyy-MM-dd hh:mm:ss');
}

