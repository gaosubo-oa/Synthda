/**
 * @Name: 树表功能
 * @Author: 方堃
 * 最近修改时间: 2019/08/26
 */

function Classtree(options) {
    var that = this
    this.tabData ={}
        ,this.id
        ,this.nowParent = {}   // 当前点击节点的根级父元素数据
        ,this.ishover = options.ishover //是否显示树表功能操作 默认：是 {ishover:false}不显示
        ,this.chk_value = []
        ,this.chk_status = []
        ,this.container = options.container
        ,this.lazy = options.lazy //是否懒加载 默认：是 {lazy:false}直接渲染

        that.eventsinit()
}

Classtree.prototype.eventsinit =function(){      //   初始化
    var that = this
        ,tabData = that.tabData

    // 节点展开收起
    $(document).on('click',that.container+' .control',function (e) {
        e.stopPropagation()
        var othis = $(this)
            ,ptr = othis.parents('tr')
            ,id = $(ptr).attr('data-id')
            ,pid = "pid"

        if(tabData[id].isOpen == 'true') {             //  收起
            othis.html('&#xe623;')
            tabData[id].isOpen = 'false'
            that.recursionFindNode(id)
        } else {                           //  展开
            othis.html('&#xe625;')
            tabData[id].isOpen = 'true'
            if(!tabData[id].onceLoad) that.loadNode(ptr,id)
            else that.findNode(id,'show')
        }
    })

    //  监听悬浮事件
    if(that.ishover){
        $(document).on('mouseenter mouseleave',that.container+' .xfbox',function (e) {
            if(e.type == "mouseenter"){
                $(this).find('.ope').show()
            }else if(e.type == "mouseleave"){
                $(that.container+' .ope').hide()
            }
        })
    }

    //  节点点击
    $(document).on('click',that.container+' tr',function (e) {
        e.stopPropagation()
        var othis = $(this)
            ,id = othis.attr('data-id')
            ,obj = tabData[id]
        that.findParent(obj.id,obj.pid)  //  更新根级父节点数据

        if(typeof that.nodeClick == "function") that.nodeClick(obj,othis)
        else return false
    })

    //  节点添加
    $(document).on('click',that.container+' .tbadd',function (e) {
        e.stopPropagation()
        var othis = $(this)
            ,id = othis.parents('tr').attr('data-id')
            ,obj = tabData[id]
        that.findParent(obj.id,obj.pid)  //  更新根级父节点数据

        if(typeof that.nodeAdd == "function") that.nodeAdd(obj)
        else return false
    })

    // 节点编辑
    $(document).on('click',that.container+' .tbeit',function (e) {
        e.stopPropagation()
        var othis = $(this)
            ,id = othis.parents('tr').attr('data-id')
            ,obj = tabData[id]
        if(typeof that.nodeEdit == "function") that.nodeEdit(obj)
        else return false
    })

    //  节点删除
    $(document).on('click',that.container+' .tbdel',function (e) {
        e.stopPropagation()
        var othis = $(this)
            ,id = othis.parents('tr').attr('data-id')
            ,obj = tabData[id]
        if(typeof that.nodeDel == "function") that.nodeDel(obj)
        else return false
    })

}


Classtree.prototype.init =function(obj,id){              //    渲染数据之后操作
    if(obj.length == 0) return this.dataEmpty()
    var that = this
        ,tabData = that.tabData;

    if(id){            // 点击加载子表数据
        that.hierarchy(obj,id)          //添加分级参数 及 缩进
        that.addxx(id)            //  添加分级线
        that.tabData[id].onceLoad = 'true'  // 加载一次
    } else {          // 父级加载数据
        $('.xx').remove()   //  第一次加载去除父级分级线
        that.hierarchy(obj)
    }

    that.conversion(obj)    //  存储树表数据

    if(that.lazy == false && !id){              // 非懒加载操作
        var trlist = $(that.container+' tr');
        $.each(trlist, function(i,itemNode) {
            if($(itemNode).attr('data-pid') == 0) $(itemNode).show()
            else $(itemNode).hide()
        })
    }
    $(that.container).show()     // 渲染完成显示列表数据
    $(that.container+' .ope').hide()      // 功能隐藏
}

Classtree.prototype.findNode =function(val,operation){    //   查找匹配节点隐藏显示
    var that = this
        ,nodelist = $(that.container+" tr[data-pid = '"+val+"']")
    if(nodelist.length>0){
        $.each(nodelist, function(i,itemNode) {
            if(operation == 'hide') $(itemNode).hide()
            else $(itemNode).show()
        })
    }
}

Classtree.prototype.recursionFindNode =function(val){   //    递归收起所有子节点
    var that = this
    var nodelist = $(that.container+" tr[data-pid = '"+val+"']")
    if(nodelist.length>0){
        $.each(nodelist, function(i,itemNode) {
            $(itemNode).hide()
            $(itemNode).find('.control').html('&#xe623;')
            var vl = $(itemNode).attr('data-id');
            that.tabData[vl].isOpen = 'false'
            that.recursionFindNode(vl)
        })
    }
}

Classtree.prototype.hierarchy = function(obj,val){    //      控制子节点缩进 及 添加分级
    var that = this
        ,nodelist = $(that.container+" tr[data-pid = '"+val+"']")
        ,parentnode = $(that.container+" tr[data-id = '"+val+"']")
        ,cnum;
    if(nodelist.length>0){
        $.each(nodelist, function(i,itemNode) {
            cnum = Number($(parentnode).attr('hierarchy'))
            $(itemNode).attr('hierarchy',cnum+1).find('.soulj').html(that.times('&nbsp;&nbsp;&nbsp;&nbsp;',cnum+1))
        })
    }
    that.findNode('tr',val,'show',cnum+1)
    if(val){
        $.each(obj, function(i,itemNode) {
            itemNode.hierarchy = cnum+1
        })
    }else {
        $.each(obj, function(i,itemNode) {
            itemNode.hierarchy = 1
        })
    }

    return obj
}

Classtree.prototype.times = function (str, num){   // 缩进
    var that = this
    if(num == 2) return str
    else  return num > 2 ? str += that.times(str, --num): str;
}

Classtree.prototype.getHeight = function (elem){       //获取元素高度
    var that = this
    $.each(elem, function(i,itemNode) {
        console.log($(itemNode).outerHeight())
    })
}

Classtree.prototype.getcheck = function (elem){       //获取所有复选框选中的值
    var that = this
    that.chk_value = []
    that.chk_status = []
    $(that.container+' input[name="cked"]:checked').each(function(){
        that.chk_value.push($(this).val());
        that.chk_status.push($(this).attr('status'));
    });
}

Classtree.prototype.conversion = function (objList){    //转化对象数据
    var that = this
        ,tabData = that.tabData
    $.each(objList, function(i,v) {
        tabData[v.id] = v;
        tabData[v.id].isOpen = false;
    })
}

Classtree.prototype.resetData = function (){    //数据重置
    var that = this;

    that.tabData = {}
    that.chk_value = []
}

Classtree.prototype.findParent = function (id,pid){    //查找当前节点的 根级父节点
    var that = this
        ,tabData = that.tabData;
    if(pid == 0 && pid!=undefined ) return that.nowParent = {}

    $.each(tabData, function(i,item) {
        if(item.id == id){
            if(item.pid != 0) that.findParent(item.pid)
            else that.nowParent = item
        }
    })
}

Classtree.prototype.addChildNode = function (id,obj){    // 新增插入子节点(与外部接口模板渲染方法结合使用)
    var that = this;
    if(typeof that.rendering != "function") return     //外部模板渲染方法
    var tabData = that.tabData
        ,thisTr = $(that.container+" tr[data-id = '"+id+"']")
        ,cro = $(thisTr).find('.soulj').next()
        tabData[id].onceLoad = 'true';

    $(that.container+" tr[data-pid = '"+id+"']").remove()
        if(cro.hasClass('control')){
            that.rendering($(thisTr),id,obj)
            cro.html('&#xe625;')
        } else {
            cro.addClass('control').css('color','#666').html('&#xe625;')
            that.rendering($(thisTr),id,obj)
        }

}

Classtree.prototype.deleteNode = function (ids){    // 根据id删除节点
    var that = this
        ,tabData = that.tabData;

    if(typeof ids == 'object'){
        $.each(ids, function(i,item) {
            $(that.container+" tr[data-id = '"+item+"']").remove()
        })
    }else $(that.container+" tr[data-id = '"+ids+"']").remove()

}

Classtree.prototype.dataEmpty = function (ids){    // 数据为空时 显示内容
    var that = this
        ,tabData = that.tabData;
        len = $(that.container).prev().find('th').length;
    $(that.container).html('<tr><td colspan="'+len+'" style="text-align: center">暂无数据</td></tr>')
}



