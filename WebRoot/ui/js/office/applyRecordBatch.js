var user_id='';
$(function(){
    var objData={
        proId:'',
        typeId:'',
        depositoryName:''
    }
    init(objData,$('#trList'));
//    获取办公用品库
    $.ajax({
        type:'get',
        url:'/officeDepository/getDeposttoryByDept',
        dataType:'json',
        success:function (res) {
            var data=res.obj;
            var str='';
            if(res.flag){
                if(data.length > 0){
                    for(var i=0;i<data.length;i++){
                        str+='<option value="'+data[i].id+'">'+data[i].depositoryName+'</option>';
                    }
                }
                $('[name="depositoryName"]').append(str);
            }
        }
    });
//    选择办公用品库
    $('[name="depositoryName"]').on("change",function () {
        var id=$(this).find('option:selected').val();
        $.ajax({
            type:'post',
            url:'/officetransHistory/getDownObjects',
            dataType:'json',
            data:{
                typeDepository:id
            },
            success:function (res) {
                var datas=res.obj;
                var str='';
                var stra='<option value="">请选择</option>'
                if(res.flag){
                    if(datas.length > 0){
                        for(var i=0;i<datas.length;i++){
                            str+='<option value="'+datas[i].id+'">'+datas[i].typeName+'</option>'
                        }
                    }
                    $('[name="typeName"]').html(stra+str);
                }
            }
        })
    });
//    点击查询
    $('.submit').on('click',function () {
        var objDatas={
            proId:$('[name="depositoryName"] option:selected').val(),
            typeId:$('[name="typeName"] option:selected').val(),
            depositoryName:$('[name="deposName"]').val()
        }
        init(objDatas,$('#trList'));
    });
    // var numTd=0;
//    点击加号
    $('#trList').on('click','.jiahao',function () {
        var numTd=$(this).parents('tr').find('.dataNum').val()
        var proStockNum=$(this).parents('tr').find('.proStockTd').text();
        var unitPriceNum=$(this).parents('tr').find('.unitPrice').text();
        numTd++;
        if(numTd >= proStockNum){
            numTd=proStockNum;
        }

        var sum = unitPriceNum * numTd
        $(this).parents('tr').find('.dataNum').val(numTd);
        $(this).parents('tr').find('.totalPrice').text(sum.toFixed(2));
    });
//    输入
    $('#trList').on('input','.dataNum',function () {
        var numTd=+$(this).parents('tr').find('.dataNum').val()
        var proStockNum=+$(this).parents('tr').find('.proStockTd').text();
        var unitPriceNum=$(this).parents('tr').find('.unitPrice').text();
        // numTd++;
        // if(numTd >= proStockNum){
        //     numTd=proStockNum;
        // }
        if(numTd > proStockNum) {
            numTd = proStockNum;
        }
        if(numTd < 0) {
            numTd = 0;
        }
        $(this).parents('tr').find('.dataNum').val(numTd);
        var sum = unitPriceNum * numTd
        $(this).parents('tr').find('.totalPrice').text(sum.toFixed(2));

    });
//    点击减号
    $('#trList').on('click','.jianhao',function () {
        var numTd=$(this).parents('tr').find('.dataNum').val()
        var unitPriceNum=$(this).parents('tr').find('.unitPrice').text();
        numTd--;
        if(numTd <= 0){
            numTd=0;
        }
        var sum = unitPriceNum * numTd
        $(this).parents('tr').find('.dataNum').val(numTd);
        $(this).parents('tr').find('.totalPrice').text(sum.toFixed(2));
    });
//    点击提交
    $('.saveBtn').on('click',function () {
        var arr=[];
        var lock=true;
        var result = true;
        var result2 = false;
        $('#trList').find('.divTr').each(function (index, elem) {
            var dataNum=$(elem).find('.dataNum').val(); //数量
            var proStockTd=$(elem).find('.proStockTd').html(); //库存，
            if(parseInt(dataNum) > parseInt(proStockTd)){
                layer.msg("申领的数量超过库存，请核对后提交",{icon: 2});
                result = false;
                return false;
            }
            if(parseInt(dataNum) < 0) {
                layer.msg("申领的数量超过库存，请核对后提交",{icon: 2});
                result = false;
                return false;
            }

            var object={};
            if(dataNum != '0'){
                object.proStock=$(elem).find('.proStockTd').text();
                object.proPrice=$(elem).find('.unitPrice').text();
                object.proName=$(elem).find('.proName').text();
                object.totalPrice=$(elem).find('.totalPrice').text();
                object.proId=$(elem).attr('data-proId');
                object.typeId=$(elem).attr('data-TypeId');
                object.depositoryId=$(elem).attr('data-depositoryId');
                object.transQty=$(elem).find('.dataNum').val();
                arr.push(object);
                result2 = true;
            }
        });

        if(result != false){
            if(result2 == false){
                layer.msg("没有申领物品",{icon: 2});
                return false;
            }
        layer.open({
            type: 1,
            title:['申请条件', 'background-color:#2b7fe0;color:#fff;'],
            area: ['400', '300px'],
            shadeClose: true, //点击遮罩关闭
            btn: ['提交', '关闭'],
            content: '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 94%;">' +
                // '<tr><td style="">部门审批人：</td><td><textarea name="deptUser" id="deptUser" user_id="" readonly></textarea>' +
                // '<a href="javascript:;" class="addUser" style="margin-right: 10px;">添加</a><a href="javascript:;" class="clearUser">清空</a>' +
                // '</td></tr>'+
                '<tr><td>备注：</td><td><textarea name="remark" id="remark"></textarea></td></tr>'+
                '</table>',
            yes:function(index){
                if(arr.length == 0){
                    layer.msg('请输入要申领物品的数量！',{icon:2});
                    return;
                }
                // if($('#deptUser').attr('user_id') == ''){
                //     layer.msg('请选择部门审批人！',{icon:6});
                //     return;
                // }
                if(lock!=true){
                    layer.msg('重复提交！',{icon:2});
                    return;
                }
                lock=false;
                var submit;
                    saveBtnStatus = true;
                    $.ajax({
                        type:'post',
                        url:'/officetransHistory/getApplayBatch?reflag='+'submit',
                        dataType:'json',
                        data:{
                            jsonStr:JSON.stringify(arr),
                            deptManager:$('#deptUser').attr('user_id'),
                            remark:$('#remark').val(),
                            flag:1
                        },
                        success:function (res) {
                            if(res.flag){
                                layer.msg('提交成功！',{icon:6},function () {
                                    layer.closeAll();
                                });


                            }else {
                                layer.msg('提交失败！',{icon:5});
                            }
                        }
                    })
                }

        });
        }

        //    点击添加
        $('.addUser').on('click',function () {
            user_id='deptUser';
            $.popWindow("../comm" +
                "" +
                "" +
                "" +
                "" +
                "" +
                "" +
                "" +
                "" +
                "" +
                "on/selectUser");
        })
        $('.clearUser').on('click',function () {
            $('#deptUser').attr('username','');
            $('#deptUser').attr('dataid','');
            $('#deptUser').attr('user_id','');
            $('#deptUser').attr('userprivname','');
            $('#deptUser').val('');
        });
    });
    $('.save').on('click',function () {
        var lock=true;
        var arr=[];
        var result = true;
        var result2 = false;
        $('#trList').find('.divTr').each(function (index, elem) {
            var dataNum=$(elem).find('.dataNum').val(); //数量
            var proStockTd=$(elem).find('.proStockTd').html(); //库存
            if(parseInt(dataNum) > parseInt(proStockTd)){
                layer.msg("申领的数量超过库存，请核对后提交",{icon: 2});
                result = false;
                return false;
            }
            var object={};
            if(dataNum != '0'){
                object.proStock=$(elem).find('.proStockTd').text();
                object.proPrice=$(elem).find('.unitPrice').text();
                object.proName=$(elem).find('.proName').text();
                object.totalPrice=$(elem).find('.totalPrice').text();
                object.proId=$(elem).attr('data-proId');
                object.typeId=$(elem).attr('data-TypeId');
                object.depositoryId=$(elem).attr('data-depositoryId');
                object.transQty=$(elem).find('.dataNum').val();
                arr.push(object);
                result2 = true;
            }
        });

        if(result != false) {
            if (result2 == false) {
                layer.msg("申领的数量超过库存，请核对后提交",{icon: 2});
                return false;
            }

            $.ajax({
                type: 'post',
                url: '/officetransHistory/selectByBorrower',
                dataType: 'json',
                success: function (res) {
                    console.log(res)
                    if(res.msg=='err'){
                        layer.open({
                            type: 1,
                            title: ['申请条件', 'background-color:#2b7fe0;color:#fff;'],
                            area: ['400px', '300px'],
                            shadeClose: true, //点击遮罩关闭
                            btn: ['提交', '关闭'],
                            content: '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 94%;">' +
                                // '<tr><td style="">部门审批人：</td><td><textarea name="deptUser" id="deptUser" user_id="" readonly></textarea>' +
                                // '<a href="javascript:;" class="addUser" style="margin-right: 10px;">添加</a><a href="javascript:;" class="clearUser">清空</a>' +
                                // '</td></tr>'+
                                '<tr><td>备注：</td><td><textarea name="remark" id="remark"></textarea></td></tr>'+
                                '</table>',
                            yes: function (index) {
                                if (arr.length == 0) {
                                    layer.msg('请输入要申领物品的数量！', {icon: 2});
                                    return;
                                }
                                // if ($('#deptUser').attr('user_id') == '') {
                                //     layer.msg('请选择部门审批人！', {icon: 6});
                                //     return;
                                // }
                                // if ($('#remark').val() == '') {
                                //     layer.msg('请填写备注！', {icon: 2});
                                //     return;
                                // }
                                if (lock!=true) {
                                    layer.msg('重复提交', {icon: 2});
                                    return;
                                }
                                lock=false;
                                var save;
                                $.ajax({
                                    type: 'post',
                                    url: '/officetransHistory/getApplayBatch?reflag=' + 'save',
                                    dataType: 'json',
                                    data: {
                                        jsonStr: JSON.stringify(arr),
                                        deptManager: $('#deptUser').attr('user_id'),
                                        remark: $('#remark').val(),
                                        flag: 1
                                    },
                                    success: function (res) {
                                        if (res.flag) {
                                            layer.msg('暂存成功！',{icon:1,time:2000},function () {
                                                location.reload();
                                            })
                                        } else {
                                            layer.msg('暂存失败！', {icon: 5});
                                        }
                                    }
                                })
                            }
                        });
                        //    点击添加
                        $('.addUser').on('click',function () {
                            user_id='deptUser';
                            $.popWindow("../common/selectUser");
                        })
                        $('.clearUser').on('click',function () {
                            $('#deptUser').attr('username','');
                            $('#deptUser').attr('dataid','');
                            $('#deptUser').attr('user_id','');
                            $('#deptUser').attr('userprivname','');
                            $('#deptUser').val('');
                        });
                    }else{
                        $.ajax({
                            type: 'post',
                            url: '/officetransHistory/getApplayBatch?reflag=' + 'save',
                            dataType: 'json',
                            data: {
                                jsonStr: JSON.stringify(arr),
                                deptManager: $('#deptUser').attr('user_id'),
                                remark: $('#remark').val(),
                                flag: 1
                            },
                            success: function (res) {

                                if (res.flag) {
                                    layer.msg('暂存成功！',{icon:1,time:2000},function () {
                                        location.reload();
                                    })
                                } else {
                                    layer.msg('暂存失败！', {icon: 5});
                                }

                            }
                        })
                    }
                }
            })

        }

    });

})

//展示数据
function init(data,element) {
    console.log(data)
    $.ajax({
        type:'get',
        url:'/officeSupplies/getOfficeTypeByNameList',
        dataType:'json',
        data:data,
        success:function (res) {
            console.log(res)
            var datas=res.obj;
            var str='';
            if(res.flag){
                if(datas.length > 0){
                    for(var i=0;i<datas.length;i++){
                        if(datas[i].proStock < 0) {
                            datas[i].proStock = 0;
                        }
                        str+='<tr class="divTr" data-proId="'+datas[i].proId+'" data-TypeId="'+datas[i].officeProtype+'" data-depositoryId="'+datas[i].depositoryId+'">' +
                            '<td class="proName">'+datas[i].proName+'</td>' +
                            '<td class="proStockTd" value="'+datas[i].proStock+'">'+datas[i].proStock+'</td>' +
                            '<td>￥<span class="unitPrice" value="'+datas[i].proPrice+'">'+datas[i].proPrice+'</span></td>' +
                            '<td><div class="jiajian jianhao">-</div>' +
                            '<input type="number" name="dataNum" min="0" class="dataNum" value="0" max="'+datas[i].proStock+'">' +
                            '<div class="jiajian jiahao">+</div></td>' +
                            '<td>￥<span class="totalPrice">0</span></td>' +
                            '</tr>'
                    }
                }
                element.html(str)
            }
        }
    })
}