/**
 * Created by 骆鹏 on 2018/1/10.
 */
var numS=2;
var getobj=$.GetRequest();
function doQtDep(obj) {
    new QWebChannel(qt.webChannelTransport, function(channel) {
        var content = channel.objects.interface;
        content.xoa_sms(obj,'',"ADD_GROUPUSER_LIST");
    });
}

function removeChdept(target){
    target.html("");
}
function getChDept(target,deptId){
    $.ajax({
        url:'/department/getChDept',
        type:'get',
        data:{
            deptId:deptId
        },
        dataType:'json',
        success:function(data){
            if(deptId==undefined){
                var str = '';
                data.obj.forEach(function(v,i){
                    if(v.deptName){
                        str+='<li >' +
                            '<span  data-num="2" ' +
                            'style="padding-left: 20px " deptid="'+v.deptId+'" ' +
                            'class="childdept dynatree-node dynatree-folder ' +
                            'dynatree-expanded dynatree-has-children ' +
                            'dynatree-lastsib dynatree-exp-el ' +
                            'dynatree-ico-ef">' +
                            '<span class="dynatree-checkbox actives">' +
                            '<img src="/img/sys/dapt_right.png" alt="" data-type="1">' +
                            '</span>' +
                            '<a href="javascript:void(0)" class="dynatree-title" ' +
                            'title="">'+v.deptName+'</a>' +
                            '</span>' +
                            '<ul class="dyna_ul" ></ul>' +
                            '</li>';
                    }else{
                        str+='<li id="dyna_li" data-id="'+v.uid+'" onclick="openwin(this)">' +
                            '<span  ' +
                            'style="padding-left:20px; " ' +
                            'data-c="1" deptid="'+v.deptId+'" ' +
                            'class="childdept dynatree-node dynatree-folder ' +
                            'dynatree-expanded dynatree-has-children ' +
                            'dynatree-lastsib dynatree-exp-el dynatree-ico-ef">' +
                            '<span class="dynatree-checkbox">' +
                            '<img src="'+function () {
                                if(v.avatar=='0'){
                                    return '/img/email/icon_head_man_06.png'
                                }else if(v.avatar=='1'){
                                    return '/img/email/icon_head_woman_06.png'
                                }else if(v.avatar==''){
                                    return '/img/email/icon_head_man_06.png'
                                }else{
                                    return '/img/user/'+v.avatar
                                }
                            }()+'" alt="">' +
                            '</span><a href="javascript:void(0)" class="dynatree-title" ' +
                            'uid="'+v.uid+'" userPrivName="'+v.userPrivName+'" ' +
                            'sex="'+v.sex+'" id="'+v.mobilNo+'" ' +
                            'birthday="'+v.birthday+'" ' +
                            'title="'+v.userName+'" myStatus="'+ v.mystatus +'">'+v.userName+'</a>' +
                            '</span>' +
                            '<ul ></ul>' +
                            '</li>';
                    }
                });
            }else{
                var str = '';
                var bool=false;
                data.obj.forEach(function(v,i){
                    if(v.deptName){
                        str+='<li >' +
                            '<span  data-num="'+(parseInt($(target).prev().attr('data-num'))+1)+'" ' +
                            'style="padding-left: '+(parseInt($(target).prev().attr('data-num'))*20)+'px; " deptid="'+v.deptId+'" ' +
                            'class="childdept dynatree-node dynatree-folder ' +
                            'dynatree-expanded dynatree-has-children ' +
                            'dynatree-lastsib dynatree-exp-el ' +
                            'dynatree-ico-ef">' +
                            '<span class="dynatree-checkbox actives">' +
                            '<img src="/img/sys/dapt_right.png" alt="" data-type="1">' +
                            '</span>' +
                            '<a href="javascript:void(0)" class="dynatree-title" ' +
                            'title="">'+v.deptName+'</a>' +
                            '</span>' +
                            '<ul class="dyna_ul" ></ul>' +
                            '</li>';
                    }else{
                        str+='<li id="dyna_li" data-id="'+v.uid+'" onclick="openwin(this)">' +
                            '<span  ' +
                            'style="padding-left: '+(parseInt($(target).prev().attr('data-num'))*20)+'px; " ' +
                            'data-c="1" deptid="'+v.deptId+'" ' +
                            'class="childdept dynatree-node dynatree-folder ' +
                            'dynatree-expanded dynatree-has-children ' +
                            'dynatree-lastsib dynatree-exp-el dynatree-ico-ef">' +
                            '<span class="dynatree-checkbox">' +
                            '<img onerror="imgerror(this,1)" src="'+function () {
                                if(v.avatar=='0'){
                                    return '/img/email/icon_head_man_06.png'
                                }else if(v.avatar=='1'){
                                    return '/img/email/icon_head_woman_06.png'
                                }else if(v.avatar==''){
                                    return '/img/email/icon_head_man_06.png'
                                }else{
                                    return '/img/user/'+v.avatar
                                }
                            }()+'" alt="">' +
                            '</span><a href="javascript:void(0)" class="dynatree-title" ' +
                            'uid="'+v.uid+'" userPrivName="'+v.userPrivName+'" ' +
                            'sex="'+v.sex+'" id="'+v.mobilNo+'" ' +
                            'birthday="'+v.birthday+'" ' +
                            'title="'+v.userName+'" myStatus="'+ v.mystatus +'">'+v.userName+'</a>' +
                            '</span>' +
                            '<ul ></ul>' +
                            '</li>';
                    }
                });
            }
            target.html(str);
        }
    })
}


function initData() {
    $.ajax({
        url:'/sys/showUnitManage',
        type:'get',
        dataType:"JSON",
        data : '',
        success:function(obj){
            var data = obj.object.unitName;
            $('.pickCompany .dynatree-title').text(data).attr('title',data);
            getChDept($('#deptOrg'));
        },
        error:function(e){
        }
    })

}




function openwin(e){
    var uid = $.getQueryString("uid")||'';
    uid = uid.split(',');
    var prcsId = $.getQueryString("prcsId") || '';
    var deletes = '';
    var classs = '';
    var $id=$(e).attr('data-id');

    if($id==undefined){
        return;
    }
    var $bool=true;
    var $arr=$('#dataul li');
    for(var i=0;i<$arr.length;i++){
        if($($arr[i]).attr('data-id')==$id){
            $bool=false;
            break;
        }
    }
    if($bool){
        for(var i=0;i<uid.length;i++){
            if(uid[i] == $id){
                deletes = 'display: none;';
                classs = '';
                break;
            }else{
                deletes = 'display: block;';
                classs = 'class="none"';
            }
        }

        var str='<li '+ classs +'data-id="'+$id+'">\
                    <img onerror="imgerror(this,1)" src="'+$(e).find('img').prop('src')+'" alt="">\
                    <span>'+$(e).find('a').text()+'</span>\
                    <b class="deleteB" style="'+ deletes +'">x</b>\
                    </li>'
        $('#dataul').append(str)
    }else {
        alert('请不要重复添加')
    }
}

function throttle(method,text) {
    clearTimeout(method.tId);
    method.tId = setTimeout(function () {
        method.call(window,text);
    }, 500);
}

function hoverAjax(text) {
    if(text==''){
        $('.mainlefttoptext').hide()
    }
   $.get('/user/getByName?name='+text,function (json) {
        if(json.flag){
            if(text!=''){
                var arr=json.obj;
                $('.mainlefttoptext').show()
                if(arr.length!=0) {
                    var str='';
                    for(var i=0;i<arr.length;i++){
                        if(arr[i].deptName != '离职')
                        str+=' <li data-id="'+arr[i].uid+'">\
                            <img onerror="imgerror(this,1)" width="20px" height="20px" src="'+function () {
                                var avatar = arr[i].avatar;
                                if(avatar==undefined||avatar==""){
                                    avatar = arr[i].sex;
                                }
                                if(avatar==0){
                                    return '/img/email/icon_head_man_06.png'
                                }else if(avatar==1){
                                    return '/img/email/icon_head_woman_06.png'
                                }else {
                                    return '/img/user/'+arr[i].avatar
                                }
                            }()+'" alt="">\
                            <span><label>'+arr[i].userName+'</label>&nbsp;&nbsp;（'+arr[i].deptName+'&nbsp;&nbsp;/&nbsp;&nbsp;'+arr[i].userPrivName+'）</span>\
                            <b>√</b>\
                        </li>'

                        $('.mainlefttoptext .dataul').html(str)
                    }
                }else {
                    $('.mainlefttoptext .dataul').html('<li style="text-align: center;background: none">没有找到相关内容</li>');
                }

            }
        }
   },'json')

}



$(function () {
    init();window.setTimeout(init, 1);
    initData()

    //组织
    $('#sub_module_org_0 .tab_ctwo').on('click','.childdept',function(){

        var that = $(this);
        if(that.attr("drop")=="true"){
            that.attr("drop",false);
            removeChdept(that.next());
            if(that.attr('data-c')==undefined){
                that.find('img').prop('src','/img/sys/dapt_right.png')
            }
        }else{
            that.attr("drop",true);
            getChDept(that.next(),that.attr('deptid'));
            if(that.attr('data-c')==undefined) {
                that.find('img').prop('src', '/img/sys/dapt_down.png')
            }
        }
    });
    
    $('[name="sousuo"]').bind('input propertychange', function() {
        throttle(hoverAjax,$(this).val())
    })

    $('.mainlefttoptext').on('click','li',function (e) {
            e.stopPropagation()
            var $id=$(this).attr('data-id');
            if($id==undefined){
                return;
            }
            var $bool=true;
            var $arr=$('#dataul li');
            for(var i=0;i<$arr.length;i++){
                if($($arr[i]).attr('data-id')==$id){
                    $bool=false;
                    break;
                }
            }
            if($bool){
                var str='<li data-id="'+$id+'">\
                    <img src="'+$(this).find('img').prop('src')+'" alt="">\
                    <span>'+$(this).find('label').text()+'</span>\
                    <b class="deleteB">x</b>\
                    </li>'
                $('#dataul').append(str)
            }else {
                alert('请不要重复添加')
            }
    })

    $('#dataul').on('click','.deleteB',function () {
        $(this).parent().remove();
    })

    $(document).click(function () {
        $('.mainlefttoptext').hide()
    })



    $('.btnArr .active').click(function () {
        var quid = $.getQueryString("quid")||'';
        var obj={
            createUid:getobj.uid,
            allPersonnel:[],
            allName:[]
        }
        var $arr=$('#dataul li');
        if($arr.length==0){
            alert('请先选择人员')
            return;
        }
        $arr.each(function (i,n){
            obj.allPersonnel.push($(this).attr('data-id'))
            obj.allName.push($(this).find('span').text())
        })
        var ccuid = {
            'newuid':obj.allPersonnel.join(','),
            'newname':obj.allName.join(','),
            'quid':quid
        };
        var str=JSON.stringify(ccuid);
        $.ajax({
            typr:'get',
            url:'/im/updateRoom',
            data:{
                roomOf:quid,
                members:obj.allPersonnel.join(',')+','
            },
            dataType:'json',
            success:function(res){
                if(res.flag){
                    doQtDep(str);
                }else{
                    alert("保存失败!")
                }
            }
        })

    })
    $('.closeA').click(function () {
        // CloseWebPage()
        new QWebChannel(qt.webChannelTransport, function(channel) {
            var content = channel.objects.interface;
            content.xoa_sms(document.title,'CLOSE_WINDOW',"ADD_GROUPUSER_LIST");
        });
    })

})

function CloseWebPage(){
    if (navigator.userAgent.indexOf("MSIE") > 0) {
        if (navigator.userAgent.indexOf("MSIE 6.0") > 0) {
            window.opener = null;
            window.close();
        } else {
            window.open('', '_top');
            window.top.close();
        }
    }
    else if (navigator.userAgent.indexOf("Firefox") > 0) {
        window.location.href = 'about:blank ';
    } else {
        window.opener = null;
        window.open('', '_self', '');
        window.close();
    }
}