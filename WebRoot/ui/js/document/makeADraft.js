/**
 * Created by 骆鹏 on 2017/7/26.
 */

var ajaxPage={
    data:{
        page:1,//当前处于第几页
        pageSize:7,//一页显示几条
        useFlag:true,
        documentType:0,
        // curUserID:0,
        printDate:null,
        dispatchType:null,
        title:null,
        docStatus:null
    },
    init:function () {
        $.get('/code/GetDropDownBox',{CodeNos:'GWTYPE'},function (json) {
            var arrTwo=json.GWTYPE;
            var str='<option value="">'+ds+'</option>'
            for(var i=0;i<arrTwo.length;i++){
                str+='<option value="'+arrTwo[i].codeNo+'">'+arrTwo[i].codeName+'</option>'
            }
            $('[name="dispatchType"]').html(str)
        },'json')

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
            if (arr=='') {
                $.layerMsg({
                    content: no_Data,
                    icon: 1
            });
            };
            for(var i=0;i<arr.length;i++){
                str+='<tr>' +
                    '<td style="width:180px ">'+arr[i].title+'</td>' +
                    '<td style="width: 180px">'+function () {
                        if(arr[i].codeName){
                            return arr[i].codeName
                        }else {
                            return ""
                        }
                    }()+'</td>' +
                    '<td style="width: 170px">'+arr[i].createrName+'</td>' +
                    '<td style="width: 170px">'+function () {
                        if(arr[i].unit){
                            return arr[i].unit
                        }else {
                            return ""
                        }
                    }()+'</td>' +
                    '<td style="width: 180px">'+arr[i].printDate+'</td>' +
                    '<td style="width: 500px"><p>'+di+arr[i].step+bu+'：'+arr[i].prcsName+'</p>' +
                    '<p style="'+function () {
                        if(arr[i].ifOutTime!=undefined&&arr[i].ifOutTime==true){
                            return "color:red";
                        }else {
                            return "color:green";
                        }
                    }()+'">'+function () {
                        if(arr[i].timeOutStr!=undefined&&arr[i].timeOutStr!='undefined'){
                            return arr[i].timeOutStr;
                        }else {
                            return ""
                        }
                    }()+'</p></td>' +
                    '<td style="width: 160px">'+function () {
                        if(arr[i].prFlag==1){
                            return Unreceived;
                        }else {
                            return handling;
                        }
                    }()+'</td>' +
                    '<td style="width: 260px">' +
                    '<a class="btna" href="/workflow/work/workform?flowId='+arr[i].flowId+'&prcsId='+arr[i].realPrcsId+'&flowStep='+arr[i].step
                    +'&runId='+arr[i].runId+'&tabId='+arr[i].id+'&tableName='+arr[i].tableName+'&isNomalType=false&hidden=true" target="_blank" style="margin-right: 10px">'+handle+'</a>' +
                    '<a class="btna" href="/workflow/work/workformPreView?flowId='+arr[i].flowId+'&flowStep='+arr[i].step+'&tabId='+arr[i].id+'&tableName='+arr[i].tableName+'&runId='+arr[i].runId+'&prcsId='+arr[i].realPrcsId+'&isNomalType=false&hidden=true" target="_blank">'+roleAuthorization_th_ViewDetails+'</a>' +
                    '</td>' +
                    '</tr>'
            }
            $('.pagediv .page-bottom-outer-layer table tbody').html(str)
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
}
$(function () {
    ajaxPage.init()
    ajaxPage.page()
    $('.Query').click(function () {
        ajaxPage.data.page=1;
        ajaxPage.page()
    })
})
