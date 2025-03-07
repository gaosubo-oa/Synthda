/**
 * @Name: 基于eletree二次封装
 * @Author: 方堃
 * @License：MIT
 * 最近修改时间: 2019/07/29
 */

function Classmeth(options) {
    this.id
    ,this.pid = 0
    ,this.lfobj
    ,this.rtobj
    ,this.objLen
    ,this.del = function (obj,delobj,url,ele,fn) {
        // this.pid = pid;
        if(obj.isLeaf == false || obj.isLeaf == 'false'){
            layer.msg('该节点存在子节点,无法删除');
        }else {
            layer.confirm('确认删除', function(index){
                $.get(url,delobj,function (res) {
                    if(res.code == 1){
                        layer.msg(res.msg, {
                            // icon: 1,//提示的样式
                            time: 1000, //2秒关闭（如果不配置，默认是3秒）//设置后不需要自己写定时关闭了，单位是毫秒
                        },function () {
                            layer.closeAll();
                        });
                    }else {
                        if(res.data.length>0){
                            $.each(res.data, function(i,val){
                                el.updateKeySelf(val.id,val);   //更新当前节点
                            });

                        }
                        if(ele) $(ele).remove();
                        el.remove(obj.id);
                        layer.closeAll();
                        if(typeof fn === 'function') return fn(res)
                    }
                })
            });
        }
    }
    this.insertBefore = function () {

    }
}

Classmeth.prototype ={
    constructor:Classmeth
    ,add:function () {
    }
}


