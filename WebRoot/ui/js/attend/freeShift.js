
//设置当前排班小菜单
$(document).on('click','.usable',function (e) {
    var objW=$(".ant-dropdown").width();
    var objH=$(".ant-dropdown").height();
    $(".ant-dropdown").hide();
    e.stopPropagation();
    elem = $(e.currentTarget)
    if(elem.hasClass('rowtitle')){
        $('.duletit').text('修改所有员工当天班次')
    }else if(elem.hasClass('costitle')){
        $('.duletit').text('修改该员工当月所有班次')
    } else {
        $('.duletit').text('修改该员工当天排班')
    }
    var selfX=objW+e.pageX;
    var selfY=objH+e.pageY;
    bodyW=document.documentElement.clientWidth+document.documentElement.scrollLeft;
    var bodyH=document.documentElement.clientHeight+document.documentElement.scrollTop;
    if(selfX>bodyW && selfY>bodyH){
        $(".ant-dropdown").css({top:(e.pageY-objH),left:(bodyW-objW-100)}).fadeIn();
    }else if(selfY>bodyH && selfX>bodyW){
        $(".ant-dropdown").css({top:(e.pageY-objH),left:(bodyW-objW-100)}).fadeIn();
    }else if(selfY>bodyH){
        $(".ant-dropdown").css({top:(e.pageY-objH),left:e.pageX-30}).fadeIn();
    }else if(selfX>bodyW){
        $(".ant-dropdown").css({top:e.pageY+20,left:(bodyW-objW-100)}).fadeIn();
    }else{
        $(".ant-dropdown").css({top:e.pageY,left:e.pageX-30}).fadeIn();
    }
})


$(document).on('click','.ant-menu-item',function (e) {
    var nu_sid = $(e.currentTarget).attr('data-sid');
    var nu_name = $(e.currentTarget).attr('data-name');
    var nu_time = elem.attr('data-time');
    var colf = '<span class="off">'+nu_name+'</span><div class="editFlag" data-sid="'+nu_time+':'+nu_sid+'"></div>';
    var bind_data ='';
    if(elem.hasClass('rowtitle')){
        var rows = elem.attr('data-row');
        var elerows =$("[row='"+rows+"']");
        seleRow(elerows)
        // 选择整列
        function seleRow(val) {
            if(val.length){
                for(var i=0;i<val.length;i++){
                    bind_data = $(val[i]).attr('data-time');
                    colf = '<span class="off">'+nu_name+'</span><div class="editFlag" data-sid="'+bind_data+':'+nu_sid+'"></div>';
                    $(val[i]).html(colf);
                }
            }
        }
    }else if(elem.hasClass('costitle')){
        var cos = elem.attr('data-cos');
        var elecos =$("[cos='"+cos+"']");
        seleCos(elecos)
        function seleCos(val) {
            if(val.length){
                for(var i=0;i<val.length;i++){
                    if($(val[i]).hasClass('usable')){
                        bind_data = $(val[i]).attr('data-time');
                        colf = '<span class="off">'+nu_name+'</span><div class="editFlag" data-sid="'+bind_data+':'+nu_sid+'"></div>';
                        $(val[i]).html(colf);
                    }
                }
            }
        }
    }else {
        elem.html(colf)
    }

})

$.ajax({
    url: '/attendSchedule/getAttendSet',
    dataType: 'json',
    success: function (obj) {
        if(obj.flag) {
            var data = obj.obj;
            if(data.length){
                var str = '';
                for(var i=0;i<data.length;i++){
                    str += '<li class="ant-menu-item" data-sid="'+data[i].sid+'" data-name="'+data[i].title+'">' +
                        '<span class="hedul"></span>' +
                        '<span>'+data[i].title+'</span></li>'
                }
                $('.ant-menu').html(str);
            }
        }
    }
})

$('.save').click(function () {
    var alldata = $('tbody tr');
    var arrs = [];

    if(alldata.length){
        $.each(alldata,function (i,v) {
            var val = $(v).find('.editFlag');
            if(val.length){
                var opsion = '';
                var str = [];
                for(var j=0;j<val.length;j++){
                    opsion = $(val[j]).attr('data-sid');
                   str.push(opsion)
                }
                str.unshift($(v).attr('data-uid')+'|');
                var sorf = str.join('.');
                arrs.push(sorf)
            }
        })

        $.ajax({
            url: '/attendSchedule/freedomScheduleSave',
            dataType: 'json',
            data: {
                userDutyList:arrs
            },
            success: function (obj) {
                if(obj.flag) {
                    layer.msg('保存成功', {icon: 1},function () {
                        // searchData(price)
                    })
                }

            }
        })

    }

})

