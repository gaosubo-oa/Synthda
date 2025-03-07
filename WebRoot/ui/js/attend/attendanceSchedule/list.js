
getlist()
//        列表
function getlist() {
    $.get('/attendSchedule/getAttendSchedule',function (json) {
        if(json.flag){
            var arr=json.obj;
            var str=''
            for(var i=0;i<arr.length;i++){
                var color;
                str+='<tr><td width="10%">'+ (i+1) +'</td>\
                  <td width="20%">'+arr[i].asname+'</td>\
                  <td width="20%">'+function () {
                       if(arr[i].typeName==undefined){
                           return ''
                       } else {
                           return arr[i].typeName
                       }
                    }()+'</td>\
                  <td width="15%" class="ellipsis" title="'+arr[i].useUsers+'">'+arr[i].useUsers+'</td>\
                  <td width="20%">'+function () {
                    if(arr[i].status == 0){
                        return '<span style="color: red">停用</span>';
                    }else {
                        return '<span style="color: green">启用</span>';
                    }
                    }()+'</td>\
                        <td width="25%">'+function () {
                    if(arr[i].status == 0){
                        return '<a href="javascript:void (0)" class="newsBtntwo" onclick="stoprwo(' + arr[i].asid + ',1,this)">启用</a>';
                    }else {
                        return '<a href="javascript:void (0)" class="newsBtntwo" onclick="stoprwo(' + arr[i].asid + ',0)" >停用</a>';
                    }

                }()+function(){
                        if(arr[i].status == 0){
                            return '<a class="editStatus" href="javascript:void (0)" style="margin-right:5px;color:#2B7FE0;" onclick="editData(' + arr[i].asid + ','+arr[i].status+')">编辑</a>';
                        }else {
                            return '<a class="editStatus" href="javascript:void (0)" style="margin-right:5px;color:#C0C0C0;cursor:default;" onclick="return false">编辑</a>';
                        }
                }() +function(){
                        if(arr.length==1){
                            return ''
                        }else{
                            return '<a href="javascript:void (0)" onclick="deleteData(' + arr[i].asid + ','+arr[i].status+')">删除</a>'
                        }
                    }()+

                    '</td></tr>'
            }
            $('.table .tbd').html(str)
        }
    })
}

//启用
function stoprwo(data,status) {
    // layer.confirm('确定删除该条数据吗？', {
    //     btn: ['确定','取消'], //按钮
    //     title:"删除"
    // }, function(){

    var indexs = layer.load(3, {
        shade: [0.1,'#fff'] //0.1透明度的白色背景
    });
        $.ajax({
            type:'post',
            url:'/attendSchedule/updateAttendScheduleStatus',
            dataType:'json',
            data:{
                asid:data,
                status:status
            },
            success:function(res){
                if(res.flag){
                    if(status == 1){
                        layer.msg('启用成功！', { icon:6,time:2000},function(){
                            $('.editStatus').attr('disabled','true')
                            layer.closeAll()
                        });
                        getlist()
                    }else {
                        layer.msg('停用成功！', { icon:6,time:2000},function(){
                            $('.editStatus').attr('disabled','false')
                            layer.closeAll()
                        });
                        getlist()
                    }

                }else {
                    layer.msg(res.msg, { icon:5,time:1500},function(){
                        layer.closeAll()
                    });
                }
            }
        })

    // }, function(){
    //     layer.closeAll();
    // });
}

//删除
function deleteData(data,status) {
    if(status == 1){
        layer.msg('不可删除启动中的排班，请先停用！', { icon:5});
        return false;
    }
    layer.confirm('确定删除该条数据吗？', {
        btn: ['确定','取消'], //按钮
        title:"删除"
    }, function(){
        //确定删除，调接口
        $.ajax({
            type:'post',
            url:'/attendSchedule/deleteAttendSchedule',
            dataType:'json',
            data:{
                asid:data,
                status:status
            },
            success:function(res){
                if(res.flag){
                    layer.msg('删除成功！', { icon:6});
                    getlist()
                }else {
                    layer.msg('删除失败！', { icon:5});
                }
            }
        })

    }, function(){
        layer.closeAll();
    });
}
