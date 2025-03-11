
var ajaxPage={
    data:{
        page:1,//当前处于第几页
        pageSize:10,//一页显示几条
        useFlag:true,
        docStatus:null
    },

    page:function () {
        var me=this;
        this.data.printDate=$('[name="printDate"]').val();
        this.data.dispatchType=$('[name="dispatchType"]').val()
        this.data.title=$('[name="title"]').val()
        this.data.docStatus=$('[name="status"]').val()
        $.get('/document/selWillDocSendOrReceive',me.data,function (json) {

            var str='';
            var arr=json.datas
            for(var i=0;i<arr.length;i++){
                str+='<tr>' +
                    '<td>'+arr[i].title+'</td>' +
                    '<td>'+function () {
                        if(arr[i].codeName){
                            return arr[i].codeName
                        }else {
                            return ""
                        }
                    }()+'</td>' +
                    '<td>'+arr[i].createrName+'</td>' +
                    '<td>'+function () {
                        if(arr[i].unit){
                            return arr[i].unit
                        }else {
                            return ""
                        }
                    }()+'</td>' +
                    '<td>'+arr[i].printDate+'</td>' +
                    '<td>第'+arr[i].step+'步：'+arr[i].prcsName+'</td>' +
                    '<td>'+function () {
                        if(arr[i].prFlag==1){
                            return '未转发'
                        }else {
                            return '办理中'
                        }
                    }()+'</td>' +
                    '<td>' +
                    '<a href="/workflow/work/workform?flowId='+arr[i].flowId+'&prcsId='+arr[i].realPrcsId+'&flowStep='+arr[i].step
                    +'&runId='+arr[i].runId+'&tableId='+arr[i].id+'&tableMame='+arr[i].tableName+'&isNomalType=false" target="_blank" style="margin-right: 10px">办理</a>' +
                    '<a href="/workflow/work/workformPreView?flowId='+arr[i].flowId+'&flowStep='+arr[i].step+'&tableId='+arr[i].id+'&tableName='+arr[i].tableName+'&runId='+arr[i].runId+'&prcsId='+arr[i].realPrcsId+'" target="_blank">查看详情</a>' +
                    '</td>' +
                    '</tr>'
            }
            $('.pagediv table tbody').html(str)
            me.pageTwo(json.total,me.data.pageSize,me.data.page)

        },'json')
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
}/**
 * Created by gsb on 2017/8/8.
 */
