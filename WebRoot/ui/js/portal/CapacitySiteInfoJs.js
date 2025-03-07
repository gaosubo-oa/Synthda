var ajaxPage={
    data:{
        page:1,//当前处于第几页
        pageSize:5,//一页显示几条
    },
    page:function () {
        var me=this;
        $.get('/capacitySiteInfo/selectCapacitySiteInfoList',me.data,function (json) {
            var str='';
            var arr=json.datas
            for(var i=0;i<arr.length;i++){
                str+='<tr>' +
                    '<td>'+arr[i].siteName+'</td>' +
                    '<td>'+arr[i].siteName+'</td>' +
                    '<td>'+arr[i].sortNo+'</td>' +
                    '<td>'+arr[i].folder+'</td>' +
                    '<td>'
                    + '<a href="javascript:void(0)" target="_blank" style="margin-right: 10px" onclick="update('+arr[i].sid+',this)">编辑</a>'+
                    '<a href="javascript:void(0)" target="_blank" style="margin-right: 10px">模板</a>'+
                    '<a href="javascript:void(0)" target="_blank" style="margin-right: 10px" >预览</a>'+
                    '<a href="javascript:void(0)" target="_blank" style="margin-right: 10px">发布</a>'+
                    '<a href="javascript:void(0)" target="_blank" style="margin-right: 10px" onclick="deletes('+arr[i].sid+',this)">删除</a>'+
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
}


ajaxPage.page()
$('.Query').click(function () {
    ajaxPage.data.page=1;
    ajaxPage.page()
})

function add(){
    layer.open({
        type: 1,
        title:['创建站点', 'background-color:#2b7fe0;color:#fff;'],
        area: ['520px', '380px'],
        shadeClose: true, //点击遮罩关闭
        btn: ['创建', '取消'],
        content: '<div class="newsAdd" style="padding-left: 5px;">' +
        '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 100%;margin-top: 20px;">' +
        '<tr><td style="width: 95px;padding-left: 59px;">站点标识：  </td><td><input type="text" class="inp"  style="width: 180px;" name="siteIdentity" id="siteIdentity" class="inputTd" /></td></tr>' +
        '<tr><td style="width: 95px;padding-left: 59px;">站点名称：  </td><td><input type="text" class="inp"  style="width: 180px;" name="siteName" id="siteName" class="inputTd" /></td></tr>' +
        '<tr><td style="width: 95px;padding-left: 59px;">排序号：  </td><td><input type="text" class="inp"  style="width: 180px;" name="sortNo" id="sortNo" class="inputTd" /></td></tr>' +
        '<tr><td style="width: 95px;padding-left: 59px;">存放位置：  </td><td><input type="text" class="inp"  style="width: 180px;" name="folder" id="folder" class="inputTd" /></td></tr>' +
        '<tr><td style="width: 95px;padding-left: 59px;">页面类型：  </td><td>' +
        '<select name="pubFileExt"  id="pubFileExt" style="float: left; width: 64px;" id="">' +
        '            <option value="html">html</option>' +
        '            <option value="jsp">jsp</option>' +
        '        </select>' +
        '</td></tr>' +
        '</table></div>',
        yes:function(index){
            $.ajax({
                type:'get',
                url:'../capacitySiteInfo/addCapacitySiteInfo',
                dataType:'json',
                data:{
                    siteIdentity:$('#siteIdentity').val(),
                    siteName:$('#siteName').val(),
                    sortNo:$('#sortNo').val(),
                    folder:$('#folder').val(),
                    pubFileExt:$("#pubFileExt").val(),
                },
                success:function(res){
                    if(res.flag){
                        console.log(res.flag)
                    }
                }
            });
            layer.close(index);

        },

    });
};

function  update(id,me) {

    $.post('/capacitySiteInfo/queryCapacitySiteInfoOne',{'sid':id},function (json) {
        if(json.flag){
            var date=json.data;
            layer.open({
                type: 1,
                title:['创建站点', 'background-color:#2b7fe0;color:#fff;'],
                area: ['520px', '380px'],
                shadeClose: true, //点击遮罩关闭
                btn: ['创建', '取消'],
                content: '<div class="newsAdd" style="padding-left: 5px;">' +
                '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 100%;margin-top: 20px;">' +
                '<tr><td style="width: 95px;padding-left: 59px;">站点标识：  </td><td><input type="text" class="inp"  style="width: 180px;" name="siteIdentity" id="siteIdentity" class="inputTd" value="'+date.siteIdentity+'" /></td></tr>' +
                '<tr><td style="width: 95px;padding-left: 59px;">站点名称：  </td><td><input type="text" class="inp"  style="width: 180px;" name="siteName" id="siteName" class="inputTd" value="'+date.siteName+'" /></td></tr>' +
                '<tr><td style="width: 95px;padding-left: 59px;">排序号：  </td><td><input type="text" class="inp"  style="width: 180px;" name="sortNo" id="sortNo" class="inputTd" value="'+date.sortNo+'" /></td></tr>' +
                '<tr><td style="width: 95px;padding-left: 59px;">存放位置：  </td><td><input type="text" class="inp"  style="width: 180px;" name="folder" id="folder" class="inputTd" value="'+date.folder+'" /></td></tr>' +
                '<tr><td style="width: 95px;padding-left: 59px;">页面类型：  </td><td>' +
                '<select name="pubFileExt"  id="pubFileExt" style="float: left; width: 64px;" id="">' +
                '            <option value="html">html</option>' +
                '            <option value="jsp">jsp</option>' +
                '        </select>' +
                '</td></tr>' +
                '</table></div>',
                yes:function(index){
                    $.ajax({
                        type:'get',
                        url:'../capacitySiteInfo/updateCapacitySiteInfo',
                        dataType:'json',
                        data:{
                            sid:id,
                            siteIdentity:$('#siteIdentity').val(),
                            siteName:$('#siteName').val(),
                            sortNo:$('#sortNo').val(),
                            folder:$('#folder').val(),
                            pubFileExt:$("#pubFileExt").val(),
                        },
                        success:function(res){
                            if(res.flag){
                                console.log(res.flag)
                            }
                        }
                    });
                    layer.close(index);

                },

            });

        }
    },'json')
    
};

function deletes(id,me) {
    $.layerConfirm({title:'确定删除',content:'您确定要删除吗？',icon:0},function(){
        $.post('/capacitySiteInfo/deleteCapacitySiteInfoOne',{'sid':id},function (json) {
            if(json.flag){
                $.layerMsg({content:'删除成功！',icon:1},function(){
                    $(me).parent().parent().remove()
                });
            }
        },'json')
    })

}