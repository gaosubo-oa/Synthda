/**
 * Created by 骆鹏 on 2018/3/23.
 */
var strsecced = '';
var zhuxiao = "";
var bl = false;
var numthree;
var numTwo;
var width = $('body').width() - 507;
var flag4;
flag4 = false;
var pd = false;
var serverTime = '';
var serverTime2 = '';
var bannerText = "";
var bannerFont = ""
$('.head_mid').css('width',width+'px');
var menu = {};
var paraValue = 0;

function loadSidebar1(target, deptId) {
    $('.pickCompany').nextAll().remove()
    $.ajax({
        type:'get',
        async: false,
        url:'/syspara/queryOrgScope',
        dataType:'json',
        success:function (reg) {
            var item=reg.object;
            if(item.paraValue == 1){
                paraValue = 1;
            }
        }
    })
    $.ajax({
        url:'/imfriends/getIsFriends',
        type:'get',
        async: false,
        dataType:'json',
        data:{},
        success:function(obj){
            if(obj.object == 1){
                var data = {};
                if(paraValue == 1){
                    var url = '/getUserOrg'
                }else{
                    var url = '/getChDeptBai'
                }
                ajaxthis(url,target,data);
            }else{
                var data = {
                    deptId: deptId
                };
                if(paraValue == 1){
                    var url = '/getUserOrg'
                }else{
                    var url = '/department/getChDeptfq'
                }
                ajaxthis(url,target,data);
            }
        },
        error:function(res){
            var data = {
                deptId: deptId
            };
            if(paraValue == 1){
                var url = '/getUserOrg'
            }else{
                var url = '/department/getChDeptfq'
            }
            ajaxthis(url,target,data);
        }
    })
}
function ajaxthis(url,target,data){
    $.ajax({
        url: url,
        type: 'get',
        data: data,
        dataType: 'json',
        success: function (data) {
            var str = '';
            data.obj.forEach(function (v, i) {
                if (v.deptName) {
                    str += '<li><span data-types="1"  data-numtrue="1" ' +
                        'onclick= "imgDown(' + v.deptId + ',this)"  style="height:35px;line-height:35px;padding-left: 14px" deptid="' + v.deptId + '" class="childdept"><span class=""></span>' +
                        '<img src="/img/sys/dapt_right.png" alt="" style="margin-left: 12px;width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;">' +
                        '<a href="javascript:void(0)" class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a></span>' +
                        '<ul style="display:none;" class="dpetWhole0"></ul></li>';
                }
            })
            widthnum++;
            target.append(str);
        }
    })
}
function getChDept(target, deptId) {
    $.ajax({
        url: 'department/getChDept',
        type: 'get',
        data: {
            deptId: deptId
        },
        dataType: 'json',
        success: function (data) {
            /* if() */
            if (deptId == 30) {
                var str = '';
                data.obj.forEach(function (v, i) {
                    if (v.deptName) {
                        str += '<li><span deptid="' + v.deptId + '" class="childdept dynatree-node dynatree-folder dynatree-expanded dynatree-has-children dynatree-lastsib"><span></span><img src="img/spirit/icon_department.png" alt=""><a href="#" class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a></span><ul style="margin-left:10%;"></ul></li>';
                    } else {

                        str += '<li><span deptid="' + v.deptId + '" class="childdept dynatree-node dynatree-folder dynatree-expanded dynatree-has-children "><span><img src="img/main_img/man.png" alt=""></span><img src="img/main_img/man.png" alt=""><a href="#" class="dynatree-title" title="' + v.userName + '">' + v.userName + '</a></span><ul style="margin-left:10%;"></ul></li>';

                    }

                });
            } else {
                var str = '';
                data.obj.forEach(function (v, i) {
                    if (v.deptName) {
                        str += '<li><span deptid="' + v.deptId + '" class="childdept dynatree-node dynatree-folder dynatree-expanded dynatree-has-children f"><span class=""></span><img src="img/spirit/icon_company.png" alt=""><a href="#" class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a></span><ul style="margin-left:10%;"></ul></li>';
                    } else {
                        if (v.sex == 0) {

                            str += '<li><span deptid="' + v.deptId + '" class="childdept dynatree-node dynatree-folder dynatree-expanded dynatree-has-children"><span></span><img src="img/main_img/man.png" alt=""><a href="#" class="dynatree-title" title="' + v.userName + '">' + v.userName + '</a></span><ul style="margin-left:10%;"></ul></li>';
                        } else if (v.sex == 1) {
                            str += '<li><span deptid="' + v.deptId + '" class="childdept dynatree-node dynatree-folder dynatree-expanded dynatree-has-children"><span></span><img src="img/main_img/women.png" alt=""><a href="#" class="dynatree-title" title="' + v.userName + '">' + v.userName + '</a></span><ul style="margin-left:10%;"></ul></li>';
                        }
                    }
                });
            }
            target.html(str);
        }
    })
}
function returnUserName(users) {
    if (users == undefined || users == "") {
        return "";
    } else {
        return users.userName;
    }
}
function autodivheights() {
    var winHeight = 0;
    if (window.innerHeight)
        winHeight = window.innerHeight;
    else if ((document.body) && (document.body.clientHeight))
        winHeight = document.body.clientHeight;
    if (document.documentElement && document.documentElement.clientHeight)
        winHeight = document.documentElement.clientHeight;
    document.getElementById("client").style.height = winHeight - $('#headID').height() - 30 + "px";
    var width = $('body').width() - 507;
    $('.head_mid').css('width',width+'px');
    if($('.cont_left').is(':hidden')){
        $('.cont_rig').width('100%')
    }else {

        $('.cont_rig').width($('#client').width() - $('.cont_left').width()-5)
    }


    $('#tab_cTwo').height($('.all_ul').height()-$('#tab_tTwo').height());
}

function throttle(method) {
    clearTimeout(method.tId);
    method.tId = setTimeout(function () {
        method.call();
    }, 100);
}
function addEventHandler(target,type,fn){
    if(target.addEventListener){
        target.addEventListener(type,fn,false);
    }else{
        target.attachEvent("on"+type,fn,false);
    }
}
function locationReload() {
    location.reload()
}

function newjump(urlString) {
    $('#f_z00410').find('iframe').prop('src', urlString)
}
function changeMenuTab(id) {

    $('.cont_left').find('#' + id).children().click();
}
function enter(){
    $.get('/user/getOnlineCount',{},function (json) {
        if(json.flag){
            $('.peoplenum').html(json.object+main_th_people);
        }
    },'json')
    $.get('/sys/getSysMessage?queryType=sysInfo',{},function(json){
        if(json.flag){
            if(json.object.isSoftAuth != sysInfo_registered){
                $('.zhuce').html('（' + sysInfo_notRegistered + '）');
            }else{
                $('.zhuce').html('');
            }
        }
    },'json')
}
function init(fn) {
    $.ajax({
        url: 'showMenu',
        type: 'get',
        dataType: 'json',
        success: function (obj) {

            var data = obj.obj;
            var str = '';
            for (var i = 0; i < data.length; i++) {
                var er = '';
                for (var j = 0; j < data[i].child.length; j++) {
                    if (data[i].child[j].child.length > 0) {
                        var three = '';
                        for (var k = 0; k < data[i].child[j].child.length; k++) {
                            var four=""
                            if(data[i].child[j].child[k].child!=undefined&&data[i].child[j].child[k].child.length>0){
                                for(var m=0;m<data[i].child[j].child[k].child.length;m++){
                                    four += '<li class="four" data-Four="'+ data[i].child[j].isopenNew +'" ' +
                                        'id=' + data[i].child[j].id + ' menu_tid=' + data[i].child[j].child[k].id + ' ' +
                                        'url=' + data[i].child[j].child[k].child[m].url + ' title="' + data[i].child[j].child[k].child[m].name + '">' +
                                        '<img class="sanji_circle" src="img/main_img/'+$("#sessionType").val()+'/hei.png">' +
                                        '<h1 style="margin-left:6%;">' + data[i].child[j].child[k].child[m].name + '</h1>' +
                                        '</li>';
                                }
                                three += '<li class="three" data-er="'+ data[i].child[j].child[k].isopenNew +'" id=' + data[i].child[j].id + '  menu_tid=' + data[i].child[j].child[k].id + '>' +
                                    '<div url="' + data[i].child[j].child[k].url + '"  class="click_three else_three three_all"  title="' + data[i].child[j].child[k].name + '">' +
                                    '<img class="erji_circle" src="img/main_img/'+$("#sessionType").val()+'/smallthree.png">' +
                                    '<h1>' + data[i].child[j].child[k].name + '</h1>' +
                                    '<img class="er_img" src="img/main_img/'+$("#sessionType").val()+'/down.png">' +
                                    '</div>' +
                                    '<ul class="siji" style="display:none;">' + four + '</ul>' +
                                    '</li>';
                            }else{
                                three += '<li class="three three_all" data-three="'+ data[i].child[j].child[k].isopenNew +'" ' +
                                    'id=' + data[i].child[j].id + ' menu_tid=' + data[i].child[j].child[k].id + ' ' +
                                    'url=' + data[i].child[j].child[k].url + ' title="' + data[i].child[j].child[k].name + '">' +
                                    '<img class="sanji_circle" src="img/main_img/'+$("#sessionType").val()+'/hei.png">' +
                                    '<h1 style="margin-left:6%;">' + data[i].child[j].child[k].name + '</h1>' +
                                    '</li>';
                            }

                        }
                        er += '<li class="two" data-er="'+ data[i].child[j].isopenNew +'" id=' + data[i].child[j].id + '  menu_tid=' + data[i].child[j].id + '>' +
                            '<div url="' + data[i].child[j].url + '"  class="two_all click_erji else_two"  title="' + data[i].child[j].name + '">' +
                                    '<img class="erji_circle" src="img/main_img/'+$("#sessionType").val()+'/smallthree.png">' +
                                    '<h1>' + data[i].child[j].name + '</h1>' +
                                    '<img class="er_img" src="img/main_img/'+$("#sessionType").val()+'/down.png">' +
                            '</div>' +
                                    '<ul class="sanji" style="display:none;">' + three + '</ul>' +
                            '</li>';
                    } else {
                        er += '<li class="two" data-er="'+ data[i].child[j].isopenNew +'" id=' + data[i].child[j].id + ' menu_tid=' + data[i].child[j].id + '>' +
                            '<div url="' + data[i].child[j].url + '" class="two_all" title="' + data[i].child[j].name + '">' +
                                '<img class="erji_circle" src="img/main_img/'+$("#sessionType").val()+'/hei.png">' +
                                '<h1 class="erji_h1">' + data[i].child[j].name + '</h1>' +
                            '</div>' +
                            '</li>';
                    }
                }
                str += '<li class="one person " id="first_menu_' + data[i].id + '"><div class="one_all apel" title="' + data[i].name + '"><img class="one_logo" src="img/main_img/'+$("#sessionType").val()+'/' + data[i].img + '.png"><h1 class="one_name" id="first_menu_' + data[i].id + '">' + data[i].name + '</h1><img class="down_jiao" src="img/main_img/'+$("#sessionType").val()+'/down.png"></div><div class="two_menu"><ul class="erji b"  style="width:100%;display:none;"><li class="two"><div class="two_all">' + er + '</div></li></ul></div></li>';
            }
            $(".tab_cone").html(str);

            $.ajax({
                type: "post",
                url: "/users/getUserTheme",
                dataType: 'json',
                data: "",
                success: function (res) {
                    var data = res.object;

                    //判断导航面板
                    if (data.userExt.menuPanel == '1'){
                        $('#xianyin').click();
                    }
                    $('#xianyin').attr('url','/userExt/userExtMenuPanel');

                    var menu = 'first_menu_' + data.menuExpand;
                    $(".one").each(function(){
                        if($(this).attr("id") == menu){
                            $(this).find('.down_jiao').attr('src','img/main_img/'+$("#sessionType").val()+'/up.png');
                            $(this).find('.erji').show().addClass('actives');
                        }
                    });

                }
            })
            $('.per_shezhi').on('click', function () {
                if($('[url="person_info"]').length == 0){
                    window.open('/controlpanel/index');
                }else{
                    $('[url="person_info"]').click()
                }

            });

            //点击一级菜单。显示二级

            $('.one_all').on('click', function () {
                var top_one = $(this).parent().next('li').find('.one_all');
                if ($(this).siblings().find('.erji').css('display') == 'none') {
                    $(this).find('.down_jiao').attr('src', 'img/main_img/'+$("#sessionType").val()+'/up.png');
                    $(this).siblings().find('.erji').show();
                    $(this).siblings().find('.erji').addClass('actives')
                    $(this).parent().siblings().find('.one_all').removeClass('one_check');
                    $(this).addClass('one_check');
                    top_one.css('border-top', '1px solid #999');

                    flag4=false;
                    // $('.person').find('.down_jiao').attr('src','img/main_img/'+$("#sessionType").val()+'/up.png');
                    $('#zd_menu').removeClass('add_float');
                    $('#zd_menu').removeClass('add_default');
                    $('#zd_menu').removeClass('reduce_float');
                    $('#zd_menu').addClass('reduce_default');
                } else {
                    $(this).parent().find('.erji').removeClass('actives');
                    $(this).find('.down_jiao').attr('src', 'img/main_img/'+$("#sessionType").val()+'/down.png');
                    $(this).siblings().find('.erji').hide();
                    top_one.css('border-top', 'none');
                    $(this).parent().parent().find('.one_all').removeClass('one_check');
                    for(var i=0;i<$('.erji').length;i++){
                        if($('.erji').eq(i).hasClass('actives')){
                            pd = true;
                            break;
                        }else{
                            pd = false;
                        }
                    }
                    if(!pd){
                        $('.two_menu ul').css('display','none');
                        $('.one_all').removeClass('one_check');
                        flag4=true;
                        $('.person').find('.down_jiao').attr('src','img/main_img/'+$("#sessionType").val()+'/down.png');
                        $('#zd_menu').removeClass('add_float');
                        $('#zd_menu').removeClass('reduce_float');
                        $('#zd_menu').removeClass('reduce_default');
                        $('#zd_menu').addClass('add_default');
                    }
//                            $(this).addClass('one_check');
                }
            });

            //点击二级，出现三级
            $('.click_erji').on('click', function () {
                var san = $(this).siblings().html();
                if ($(this).siblings('.sanji').css('display') == 'none') {
                    $(this).find('.er_img').attr('src', 'img/main_img/'+$("#sessionType").val()+'/up.png');
                    $(this).siblings('.sanji').show();

                } else {
                    $(this).find('.er_img').attr('src', 'img/main_img/'+$("#sessionType").val()+'/down.png');
                    $(this).siblings('.sanji').hide();
                }

            });
            //点击三级，出现四级
            $('.sanji li').on('click','.click_three',function(){
                // $(this).addClass('activesanji')
                var four = $(this).siblings().html();
                if ($(this).siblings('.siji').css('display') == 'none') {
                    $(this).find('.er_img').attr('src', 'img/main_img/'+$("#sessionType").val()+'/up.png');
                    $(this).siblings('.siji').show();

                } else {
                    $(this).find('.er_img').attr('src', 'img/main_img/'+$("#sessionType").val()+'/down.png');
                    $(this).siblings('.siji').hide();
                }
            })

            //点击二级菜单
            $('.two_menu li').on('click', '.two_all', function () {
                var isopenNew=$(this).parent().attr('data-er');
                //给我的工作标签添加click事件
                /*     console.log($(this).parent().attr('menu_tid')=='1020');*/
                if($(this).parent().attr('menu_tid') == '1020') {
                    $(this).parent().click();
                }
                //控制菜单左侧的小图标
                // $(this).parent('.two').siblings().find('.erji_circle').attr('src', 'img/main_img/'+$("#sessionType").val()+'/hei.png');//同层的二级img
                // $(this).parents('.one').siblings().find('.erji_circle').attr('src', 'img/main_img/'+$("#sessionType").val()+'/hei.png');//不同层级三级img
                // $(this).parents('.one').siblings().find('.sanji_circle').attr('src', 'img/main_img/'+$("#sessionType").val()+'/hei.png');//不同层的三级
                // $(this).parent('.two').siblings().find('.sanji_circle').attr('src', 'img/main_img/'+$("#sessionType").val()+'/hei.png');//同层的三级
                // $(this).find('.erji_circle').attr('src', 'img/main_img/'+$("#sessionType").val()+'/smallthree.png');//当前的img

                $(this).parent().siblings().find('.two_all').removeClass('menu_change');//同层级的二级文字
//              $(this).parent().siblings().find('.else_two').addClass('active')//同层级的有三级的二级文字
                /*$(this).parents('.one').siblings().find('.else_two').css('background','rgb(232, 244, 252)')*/
                $(this).parents('.one').find('.three_all').removeClass('three_change');//同层级的二级文字
                $(this).parents('.one').siblings().find('.two_all').removeClass('menu_change');//不同层级的二级文字
                $(this).parent('.two').siblings().find('.three').removeClass('three_change');//同层级的三级文字
                $(this).parents('.one').siblings().find('.three').removeClass('three_change');//不同层级的三级文字
                $(this).parents('.one').find('.four').removeClass('four_change');//同层级的四级文字
                $(this).parents('.one').siblings().find('.four').removeClass('four_change');//不同层级的四级文字
                $(this).addClass('menu_change');

                var url = $(this).attr('url');
                if(url.indexOf('/Home/IndexLogin') > -1||url.indexOf('/Home/RoleIndex') > -1){//判断是否是牟平物业管理系统环境下智慧园区模块的菜单
                    //要判断登录环境是内网还是外网环境
                    if(location.href.indexOf('172.16.80.4:8080') > -1){
                        url = 'http://172.16.80.4:8080'+url.split('http://221.214.181.149:9921')[1];
                    }
                }
                var menu_tid = $(this).parent().attr('menu_tid');

                if(menu_tid == '3010'){
                    url += '?muType=0'
                }
                if (menu_tid == '3001' || menu_tid == '0136') {
                    url += '?0'
                }
                //判断标题id与iframeid是否相同
                /*			console.log($('#f_'+menu_tid).length>0);*/
                if(isopenNew == '1'){
                    window.open(url);
                }else{
                    if ($('#f_' + menu_tid).length > 0) {
                        //页面一打开，切换显示
                        $('.all_content .iItem').hide();
                        $('#f_' + menu_tid).show();
                        $('#f_' + menu_tid).find('iframe').attr('src', url)

                        $('#t_' + menu_tid).css({
                            'background': 'url(img/main_img/title_yes.png) 0px 4px no-repeat',
                            'color': '#2a588c',
                            'position': 'relative',
                            'z-index': 99999
                        })
                        $('#t_' + menu_tid).siblings().css({
                            'background': 'url(img/main_img/'+$("#sessionType").val()+'/title_no.png) 0px 4px no-repeat',
                            'color': '#fff',
                            'position': 'relative',
                            'z-index': 999
                        })
                    } else {
                        if ($(this).siblings('.sanji').length > 0) {
//                                $(this).css('background','#daf0fe');
                            $(this).addClass('activesanji')
                        }
                        else {
                            //页面不存在，新增 title和iframe
                            if (mobileObj.statusTwo) {

                                var titlestr = '<li class="choose" url="'+url+'" index="0;" id="t_' + menu_tid + '" title="' + $(this).find('h1').html() + '"><h1>' + $(this).find('h1').html() + '</h1><div class="img" style="display:none;"><img class="close"  src="img/main_img/icon.png"></div></li>';

                                var iframestr = '<div id="f_' + menu_tid + '" class="iItem" ><iframe id="every_module" src="' + url + '" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize" tid="2"></iframe></div>';

                                $('.main_title ul').append(titlestr);

                                $('#t_' + menu_tid).siblings().attr('style', 'background: url(img/main_img/'+$("#sessionType").val()+'/title_no.png) 0px 4px no-repeat;');
                                $('#t_' + menu_tid).siblings().css('color', '#fff');
                                /* console.log($('#t_'+menu_tid).siblings()); */
                                $('.all_content').append(iframestr);
                                $('.all_content .iItem').hide();
                                $('#f_' + menu_tid).show();
                                mobileObj.left()
                            }
                        }
                    }
                }
                if($('.main_title ul li').length >=4){
                    $('#iconCloseAll').show();
                }else{
                    $('#iconCloseAll').hide();
                }
            });

            //点击三级菜单，跳转页面。
            $('.sanji').on('click', '.three_all', function () {
                var isopenNewTh=$(this).attr('data-three');
                // $(this).parents('.two').siblings().find('.erji_circle').attr('src', 'img/main_img/'+$("#sessionType").val()+'/hei.png');//同层的二级img
                // $(this).parents('.one').siblings().find('.erji_circle').attr('src', 'img/main_img/'+$("#sessionType").val()+'/hei.png');//不同层级三级img
                // $(this).parents('.one').siblings().find('.sanji_circle').attr('src', 'img/main_img/'+$("#sessionType").val()+'/hei.png');//不同层的三级
                // $(this).siblings().find('.sanji_circle').attr('src', 'img/main_img/'+$("#sessionType").val()+'/hei.png');//同层的三级
                // $(this).find('.sanji_circle').attr('src', 'img/main_img/'+$("#sessionType").val()+'/lan.png');//当前的img
                $(this).parents('.two').find('.four').removeClass('four_change');//同层级的四级文字
                $(this).parents('.two').find('.three').removeClass('three_change');//同层级的三级文字
                $(this).parents('.two').find('.two_all').removeClass('menu_change');//同层级的二级文字
                $(this).parents('.two').siblings().find('.three').removeClass('three_change');//同层级的三级文字
                $(this).parents('.two').siblings().find('.two_all').removeClass('three_change');//同层级的二级文字
                $(this).parents('.one').siblings().find('.two_all').removeClass('three_change');//同层级的二级文字
//                        $(this).parents('.one').siblings().find('.else_two').css('background','rgb(232, 244, 252)');//不同层级的有三级的二级文字
                $(this).siblings().removeClass('three_change');//同层级的三级文字
                $(this).parents('.one').siblings().find('.three').removeClass('three_change');//不同层级的三级文字
                $(this).parents('.one').siblings().find('.four').removeClass('four_change');//不同层级的四级文字
                $(this).addClass('three_change');
                $(this).parents('.two').siblings().find('.two_all').removeClass('menu_change')
                var url = $(this).attr('url');
                var menu_tid = $(this).attr('menu_tid');
                if(isopenNewTh == '1'){
                    window.open(url);
                }else{
                    if ($('#f_' + menu_tid).length > 0) {
                        //页面一打开，切换显示
                        $('.all_content .iItem').hide();
                        $('#f_' + menu_tid).show();
                        $('#f_' + menu_tid).find('iframe').attr('src', url);
                        $('#t_' + menu_tid).siblings().css({
                            'background': 'url(img/main_img/'+$("#sessionType").val()+'/title_no.png) 0px 4px no-repeat',
                            'color': '#fff',
                            'position': 'relative',
                            'z-index': 999
                        });


                        $('#t_' + menu_tid).css({
                            'background': 'url(img/main_img/title_yes.png) 0px 4px no-repeat',
                            'color': '#2a588c',
                            'position': 'relative',
                            'z-index': 99999
                        })


                    } else {
                        // alert($(this).siblings('.siji').length)
                        if ($(this).siblings('.siji').length > 0) {
//                                $(this).css('background','#daf0fe');
                            $(this).addClass('activesanji')
                        }else{
                            if (mobileObj.statusTwo) {
                                //页面不存在，新增 title和iframe
                                var titlestrs = '<li class="choose " url="'+url+'" index="0;" id="t_' + menu_tid + '" title="' + $(this).find('h1').html() + '"><h1>' + $(this).find('h1').html() + '</h1><div class="img" style="display:none;"><img class="close" src="img/main_img/icon.png"></div></li>';

                                var iframestr = '<div id="f_' + menu_tid + '" class="iItem"><iframe id="every_module" src="' + url + '" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize" tid="2"></iframe></div>';

                                $('.main_title ul').append(titlestrs);

                                $('#t_' + menu_tid).siblings().attr('style', 'background: url(img/main_img/'+$("#sessionType").val()+'/title_no.png) 0px 4px no-repeat;');
                                $('#t_' + menu_tid).siblings().css('color', '#fff');
                                $('.all_content').append(iframestr);
                                $('.all_content .iItem').hide();
                                $('#f_' + menu_tid).show();
                                mobileObj.left()
                            }
                        }

                    }
                }
                if($('.main_title ul li').length > 7){
                    $('#iconCloseAll').show();
                }else{
                    $('#iconCloseAll').hide();
                }

            });

            //点击四级菜单，跳转页面。
            $('.siji').on('click', '.four', function () {
                var isopenNewTh=$(this).attr('data-four');
                // $(this).parents('.two').siblings().find('.erji_circle').attr('src', 'img/main_img/'+$("#sessionType").val()+'/hei.png');//同层的二级img
                // $(this).parents('.one').siblings().find('.erji_circle').attr('src', 'img/main_img/'+$("#sessionType").val()+'/hei.png');//不同层级三级img
                // $(this).parents('.one').siblings().find('.sanji_circle').attr('src', 'img/main_img/'+$("#sessionType").val()+'/hei.png');//不同层的三级
                // $(this).siblings().find('.sanji_circle').attr('src', 'img/main_img/'+$("#sessionType").val()+'/hei.png');//同层的三级
                // $(this).find('.sanji_circle').attr('src', 'img/main_img/'+$("#sessionType").val()+'/lan.png');//当前的img

                $(this).parents('.two').find('.three').removeClass('three_change');//同层级的三级文字
                $(this).parents('.two').siblings().find('.two_all').removeClass('three_change');//同层级的二级文字
                $(this).parents('.one').find('.two_all').removeClass('menu_change');//同层级的二级文字
//                        $(this).parents('.one').siblings().find('.else_two').css('background','rgb(232, 244, 252)');//不同层级的有三级的二级文字
                $(this).siblings().removeClass('three_change');//同层级的三级文字
                $(this).parents('.one').find('.three').removeClass('three_change');//不同层级的三级文字
                $(this).parents('.one').siblings().find('.two_all').removeClass('menu_change');//不同层级的二级文字
                $(this).parents('.one').siblings().find('.four').removeClass('four_change');//不同层级的四级文字
                $(this).addClass('four_change').siblings().removeClass('four_change');//同层级的四级文子
                $(this).parents('.two').find('.two_all').removeClass('menu_change')
                var url = $(this).attr('url');
                var menu_tid = $(this).attr('menu_tid');
                if(isopenNewTh == '1'){
                    window.open(url);
                }else{
                    if ($('#f_' + menu_tid).length > 0) {
                        //页面一打开，切换显示
                        $('.all_content .iItem').hide();
                        $('#f_' + menu_tid).show();
                        $('#f_' + menu_tid).find('iframe').attr('src', url)
                        $('#t_' + menu_tid).siblings().css({
                            'background': 'url(img/main_img/'+$("#sessionType").val()+'/title_no.png) 0px 4px no-repeat',
                            'color': '#fff',
                            'position': 'relative',
                            'z-index': 999
                        });


                        $('#t_' + menu_tid).css({
                            'background': 'url(img/main_img/title_yes.png) 0px 4px no-repeat',
                            'color': '#2a588c',
                            'position': 'relative',
                            'z-index': 99999
                        })


                    } else {
                        if (mobileObj.statusTwo) {
                            //页面不存在，新增 title和iframe
                            var titlestrs = '<li class="choose " url="'+url+'" index="0;" id="t_' + menu_tid + '" title="' + $(this).find('h1').html() + '"><h1>' + $(this).find('h1').html() + '</h1><div class="img" style="display:none;"><img class="close" src="img/main_img/icon.png"></div></li>';

                            var iframestr = '<div id="f_' + menu_tid + '" class="iItem"><iframe id="every_module" src="' + url + '" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize" tid="2"></iframe></div>';

                            $('.main_title ul').append(titlestrs);

                            $('#t_' + menu_tid).siblings().attr('style', 'background: url(img/main_img/'+$("#sessionType").val()+'/title_no.png) 0px 4px no-repeat;');
                            $('#t_' + menu_tid).siblings().css('color', '#fff');
                            $('.all_content').append(iframestr);
                            $('.all_content .iItem').hide();
                            $('#f_' + menu_tid).show();
                            mobileObj.left()
                        }
                    }
                }
                if($('.main_title ul li').length > 7){
                    $('#iconCloseAll').show();
                }else{
                    $('#iconCloseAll').hide();
                }

            });

            //success的后括号
            if(fn!=undefined){
                fn();
            }
        }
    });//ajax传入应用数据结束括号

}//init方法结束

// 启动全屏
function launchFullScreen(element) {
    //W3C
    if (element.requestFullscreen) {
        element.requestFullscreen();
    }
    //FireFox
    else if (element.mozRequestFullScreen) {
        element.mozRequestFullScreen();
    }
    //Chrome等
    else if (element.webkitRequestFullscreen) {
        element.webkitRequestFullscreen();
    }
    //IE11
    else if (element.msRequestFullscreen) {
        element.msRequestFullscreen();
    }
}
// 退出全屏
function exitFullscreen() {
    //W3C
    if (document.exitFullscreen) {
        document.exitFullscreen();
    }
    //FireFox
    else if (document.mozCancelFullScreen) {
        document.mozCancelFullScreen();
    }
    //Chrome等
    else if (document.webkitCancelFullScreen) {
        document.webkitCancelFullScreen();
    }
    //IE11
    else if (document.msExitFullscreen) {
        document.msExitFullscreen();
    }
}
/**
 * isFullscreen 判断浏览器是否全屏
 * @return [全屏则返回当前调用全屏的元素,不全屏返回false]
 */
function isFullscreen() {
    return document.fullscreenElement ||
        document.msFullscreenElement ||
        document.mozFullScreenElement ||
        document.webkitFullscreenElement || false;
}

//获取时间
function getNowTime() {
    // $.ajax({
    //     url: '/getDate',
    //     type: 'get',
    //     dataType: 'json',
    //     success: function (reg) {
            var nowTime = new Date().getTime();
            serverTime = nowTime;
            var date1 = new Date(nowTime).Format('MM月dd日');
            var date2 = new Date(nowTime).Format('hh:mm');
            $('.date').text(date1);
            $('.timeDate .time').text(date2);
            var date3 = new Date(nowTime).Format('yyyy-MM-dd ');
            var date4 = new Date(nowTime).Format(' hh:mm:ss');
            $('.daibantop .left h3').text(date3);
            $('.daibantop .left h4').text(date4);

    //     }
    // });
}
setInterval(function () {
    /// 以前的会出现偏差
    // serverTime = parseInt(serverTime) + 1000;
    // var nowTime = serverTime;

    // 改为重新获取当前时间
    var nowTime = new Date().getTime();
    var date1 = new Date(nowTime).Format('MM月dd日');
    var date2 = new Date(nowTime).Format('hh:mm');
    $('.date').text(date1);
    $('.timeDate .time').text(date2);
    // var date3 = new Date(nowTime).Format('yyyy-MM-dd ');
    // var date4 = new Date(nowTime).Format(' hh:mm:ss');
    // $('.daibantop .left h3').text(date3);
    // $('.daibantop .left h4').text(date4);
},1000);


function reloads() {
    if(!$('#f_0').is(':hidden')){
        var elType=$('.header ul .active').parent().attr('data-id');
        if(elType==4||elType==1){
            var src=$('[data-tabid="'+elType+'"]').find('iframe').prop('src');
            $('[data-tabid="'+elType+'"]').find('iframe').prop('src',src)
        }else if(elType==2){
            //公告查询调用
            announcement($('#all_notice'))//默认查询全部
            administrivia($('[data-bool=""]'))//新闻
            schedule($('[data-url="/schedule/getscheduleByDay"]'))//日程
            fileCabinet($('[data-url="/file/writeTree"]'))
            meeting()
            documentFile(0)//待办公文接口
            wangluoyingpan()//网络硬盘
            youjian()//邮件
            rizhis()//日志
        }
    }
}
//点击右侧刷新按钮，刷新当前展示门户页面
function reloadIframe(){
    document.getElementById('iframeName').contentWindow.location.reload(true);
}
$(function () {
    if(document.getElementById("client") != null){
        getNowTime();
        autodivheights();
        init(function () {
            $.get('/sys/getInterfaceInfo', function (json) {
                if (json.flag) {
                    strsecced = json.object.logOutText;
                    document.title = json.object.ieTitle;
                }
            }, 'json')
            //浏览器标题和注销文字的标题的接口

            $.ajax({
                url: '/sys/getIndexInfo',
                type: 'get',
                dataType: 'json',
                success: function (obj) {
                    if (obj.flag == true) {
                        zhuxiao = obj.object.logOutText;
                        if(bannerText!=""){
                            $('.headTitle').html(bannerText)
                            $('.headTitle').attr('style',bannerFont)
                        }else{
                            $('.headTitle').html(obj.object.ieTitle)
                        }
                    }
                }
            });
        });
        loadSidebar1($('#deptOrg'), 0)
        addEventHandler(window,'resize',function () {
            throttle(autodivheights)
        })
        //校务公开列表
        //页面加载时发送ajax获取下拉框数据
        $.ajax({
            url: "/code/GetDropDownBox",
            type: 'get',
            dataType: "JSON",
            data: {"CodeNos": "GONGKAI_TYPE"},
            success: function (data) {
                var str = '';
                for (var i = 0; i < data.GONGKAI_TYPE.length; i++) {
                    if (i >= 2) {
                        break;
                    }
                    str += '<li class="strList" onclick="announcementXiaoWu(this)" data-bool="' + data.GONGKAI_TYPE[i].codeNo + '" >' + data.GONGKAI_TYPE[i].codeName + '</li>';
                }
                $('#xiaoWuLi').append(str);
            }
        })
        // 获取常用应用设置
        $.get('/getUsuallyMenu', function(res){
            if (res.flag) {
                var str = '';
                res.obj.forEach(function(menu){
                    str += '<li class="c_menu" style="cursor:pointer;" data-er="'+menu.isopenNew+'" data-url="'+menu.url+'" menu_tid="'+menu.id+'" title="'+menu.name+'"><div class="two_all"><img class="erji_circle" src="img/main_img/theme6/hei.png"><h1 class="erji_h1" style="width:56%">'+menu.name+'</h1></div></li>'
                });
                $('.tab_cthree').append(str);

                // 常用应用设置切换
                $('.tab_cthree').on('click', '.c_menu', function(){
                    var _this = this;
                    $(_this).siblings().find('.two_all').removeClass('menu_change');
                    $(_this).find('.two_all').addClass('menu_change');

                    var isopenNew = $(this).data('er');
                    var url = $(this).data('url');
                    var menu_tid = $(this).attr('menu_tid');
                    if(menu_tid == '3010'){
                        url += '?muType=0'
                    }
                    if (menu_tid == '3001' || menu_tid == '0136') {
                        url += '?0'
                    }

                    if (isopenNew == '1') {
                        window.open(url);
                    } else {
                        if ($('#f_' + menu_tid).length > 0) {
                            //页面一打开，切换显示
                            $('.all_content .iItem').hide();
                            $('#f_' + menu_tid).show();
                            if (menu_tid == '3010' || menu_tid == '3001' || menu_tid == '0136') {
                                $('#f_' + menu_tid).find('iframe').attr('src', url)
                            }

                            $('#t_' + menu_tid).css({
                                'background': 'url(img/main_img/title_yes.png) 0px 4px no-repeat',
                                'color': '#2a588c',
                                'position': 'relative',
                                'z-index': 99999
                            })
                            $('#t_' + menu_tid).siblings().css({
                                'background': 'url(img/main_img/'+$("#sessionType").val()+'/title_no.png) 0px 4px no-repeat',
                                'color': '#fff',
                                'position': 'relative',
                                'z-index': 999
                            })
                        } else {
                            //页面不存在，新增 title和iframe
                            if (mobileObj.statusTwo) {

                                var titlestr = '<li class="choose" url="'+url+'" index="0;" id="t_' + menu_tid + '" title="' + $(this).find('h1').html() + '"><h1>' + $(this).find('h1').html() + '</h1><div class="img" style="display:none;"><img class="close"  src="img/main_img/icon.png"></div></li>';

                                var iframestr = '<div id="f_' + menu_tid + '" class="iItem" ><iframe id="every_module" src="' + url + '" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize" tid="2"></iframe></div>';

                                $('.main_title ul').append(titlestr);

                                $('#t_' + menu_tid).siblings().attr('style', 'background: url(img/main_img/'+$("#sessionType").val()+'/title_no.png) 0px 4px no-repeat;');
                                $('#t_' + menu_tid).siblings().css('color', '#fff');
                                $('.all_content').append(iframestr);
                                $('.all_content .iItem').hide();
                                $('#f_' + menu_tid).show();
                                mobileObj.left()
                            }
                        }
                    }

                    if($('.main_title ul li').length >=4){
                        $('#iconCloseAll').show();
                    }else{
                        $('#iconCloseAll').hide();
                    }

                });
            }
            $("#shezhi").on('click', function(){
                // $('[url="person_info"]').click()
                // $('#commonSetting').click()
                if ($('#f_commonSettings').length > 0) {
                    //页面一打开，切换显示
                    $('.all_content .iItem').hide();
                    $('#f_commonSettings').show();

                    $('#t_commonSettings').css({
                        'background': 'url(img/main_img/title_yes.png) 0px 4px no-repeat',
                        'color': '#2a588c',
                        'position': 'relative',
                        'z-index': 99999
                    })
                    $('#t_commonSettings').siblings().css({
                        'background': 'url(img/main_img/'+$("#sessionType").val()+'/title_no.png) 0px 4px no-repeat',
                        'color': '#fff',
                        'position': 'relative',
                        'z-index': 999
                    })
                } else {
                    //页面不存在，新增 title和iframe
                    if (mobileObj.statusTwo) {

                        var titlestr = '<li class="choose" url="/controlpanel/commonSettings" index="0;" id="t_commonSettings" title="常用应用设置"><h1>常用应用设置</h1><div class="img" style="display:none;"><img class="close"  src="img/main_img/icon.png"></div></li>';

                        var iframestr = '<div id="f_commonSettings" class="iItem" ><iframe id="every_module" src="/controlpanel/commonSettings" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize" tid="2"></iframe></div>';

                        $('.main_title ul').append(titlestr);

                        $('#t_commonSettings').siblings().attr('style', 'background: url(img/main_img/'+$("#sessionType").val()+'/title_no.png) 0px 4px no-repeat;');
                        $('#t_commonSettings').siblings().css('color', '#fff');
                        $('.all_content').append(iframestr);
                        $('.all_content .iItem').hide();
                        $('#f_commonSettings').show();
                        mobileObj.left()
                    }
                }
            });


        });

        $.ajax({
            url: '/sys/showUnitManage',
            type: 'get',
            dataType: "JSON",
            data: '',
            success: function (obj) {
                var data = obj.object.unitName;
                $('#deptOrg .pickCompany .dynatree-title').text(data).attr('title', data);

            },
            error: function (e) {
            }
        })

        //点击注销按钮
        $('#admin-side3').on('click', '#per_zhuxiao', function () {
            $.layerConfirm({
                title: '<fmt:message code="main.cancellation" />',
                content: strsecced,
                icon: 0
            }, function () {
                // 判断是否为中电建项目
                $.get('/ShowDownLoadQrCode', function (res) {
                    var href = '/';
                    if (res.flag && res.object == 1) {
                        $.get('/getThirdSysConfigInfo', function (res) {
                            if (res.flag) {
                                var data = res.data;
                                href = data.para3 + 'idp/profile/OAUTH2/Redirect/GLO?redirctToUrl=' +data.para7+ "apphub&redirectToLogin=true&entityId=apphuboauth"
                            }
                        });
                    } else {
                        href = '/';
                    }
                    $.ajax({
                        url: 'logOut',
                        type: 'get',
                        dataType: 'json',
                        success: function (obj) {
                            if (obj.flag == true) {
                                location.href = href;
                            }
                        }
                    });
                });
            })
        });

    }
    
    // 刷新门户
    $('.reloads').on('click', function () {
        reloadIframe()
    });
    
    // 中电建个人门户设置
    $('#setPersonal_ZDJ').on('click', function(){
        var iframeUrl = $("#contmain_1 #iframeName").attr('src');
        if (iframeUrl == '/document/personal_ZDJ' || iframeUrl == '/document/energyEfficiency_ZDJ') {
            $("#contmain_1 #iframeName").get(0).contentWindow.setOrder();
        }
    });
    
    // 中电建运营门户全屏
    $('#setFullScreen_ZDJ').on('click', function(){
        var iframeUrl = $("#contmain_1 #iframeName").attr('src');
        if (iframeUrl.indexOf('operationsCockpit_ZDJ') > -1) {
            if (isFullscreen()) {
                exitFullscreen()
            } else {
                launchFullScreen(document.getElementById('iframeName'))
            }
        }
    });

    // 处理中电建单点登录问题
    $.ajax({
        type: 'GET',
        url: '/user/getNowLoginUser',
        async: false,
        success: function(res){
            if (res.flag){
                var loginCokie = res.object;
                if ($.cookie('uid') != loginCokie.uid) {
                    loginCokie.language = 'zh_CN';
                    loginCokie.company = loginCokie.companyId;
                    $.setCookie(loginCokie);
                }
            }
        }
    });

    //传入用户个人资料的数据
    $.ajax({
        url: '/user/findUserByuid',
        type: 'get',
        data: {
            uid: $.cookie('uid')
        },
        dataType: 'json',
        success: function (obj) {
            if (obj.flag == true) {
                var data = obj.object;
                var img = data.avatar;
                var name = data.userName;
                var userPrivOtherName = data.userPrivOtherName;
                var dept = data.deptName;
                var postName = data.postName;
                var userPrivName = data.userPrivName;
                var userSecrecyCode = data.userSecrecy;
                //判断当前人员是否属于三员人员
                var secrecyAdm = data.secrecyAdm;


            }
            $('.yonghu_touxiang').attr('src', function () {
                if(data.avatar != 0&&data.avatar != 1&&data.avatar != ''){
                    return '/img/user/'+data.avatar;
                }
                if(data.sex == 0){
                    return '/img/user/boy.png';
                }
                else if(data.sex == 1){
                    return '/img/user/girl.png';
                }

            }());
            $.ajax({
                url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
                success:function(res) {
                    var data = res.object[0];
                    //开启了三员管理
                    if(data.paraValue == 0) {
                        //这种情况下需要展示 部门 职务密 级别
                        if(!secrecyAdm || secrecyAdm != 1) {
                            $('.per_all').find('h1').html('<span class="textSpan">'+userDetails_th_name+':</span><span class="contentSpan">'+name+'</span>');

                            if(postName && dept){
                                $('.per_all').find('#deptInfo').html(dept);
                                $('.per_all').find('.juede_suopings').html('<span class="textSpan">'+userDetails_th_post+':</span><span class="contentSpan">'+postName+'</span>')
                            }
                            if(dept && postName==undefined){
                                $('.per_all').find('.juede_suopings').html('<span class="textSpan">'+userDetails_th_post+':</span><span class="contentSpan">'+dept+'</span>');
                            }
                            if(postName && dept==undefined){
                                $('.per_all').find('.juede_suopings').html('<span class="textSpan">'+userDetails_th_post+':</span><span class="contentSpan">'+postName+'</span>');
                            }

                            var userPriv = userPrivOtherName;
                            if(userPriv!==undefined){
                                if (userPriv.length >20) {
                                    $('.per_all').find('h2').eq(1).html(userPriv.substring(0,20)+"...");
                                    $('.per_all').find('h2').eq(1).mouseout(function () {
                                        $('.per_all').find('h2').eq(1).attr('title',userPriv.substring(0,userPriv.length-1));
                                    });
                                }else{
                                    $('.per_all').find('h2').eq(1).html(userPriv.substring(0,userPriv.length-1));
                                }

                                if(dept!= undefined){
                                    $('.per_all').find('#deptInfo').html('<span class="textSpan">'+userManagement_th_department+':</span><span class="contentSpan">'+dept+'</span>');
                                }
                            }else{
                                if(dept!= undefined){
                                    $('.per_all').find('#deptInfo').html('<span class="textSpan">'+userManagement_th_department+':</span><span class="contentSpan">'+dept+'</span>');
                                }
                            }

                            //若职务为空显示主角色
                            if(data.postName!=undefined && data.userPrivName !=undefined){
                                $('.per_all').find('.juede_suopings').html('<span class="textSpan">'+userDetails_th_post+':</span><span class="contentSpan">'+data.userPrivName+'</span>')
                                $('.per_all').find('.juede_suoping').html(data.postName)

                            }
                            if(data.postName==undefined && data.userPrivName !=undefined){
                                $('.per_all').find('.juede_suopings').html('<span class="textSpan">'+userDetails_th_post+':</span><span class="contentSpan">'+data.userPrivName+'</span>')
                            }
                            if(data.postName!=undefined && data.userPrivName ==undefined){
                                $('.per_all').find('.juede_suopings').html('<span class="textSpan">'+userDetails_th_post+':</span><span class="contentSpan">'+data.postName+'</span>')
                            }

                            // if(postName && userPrivName){
                            //     $('.per_all').find('h2').html(userPrivName+','+postName);
                            // }

                            // $('.per_all').find('h2').eq(1).html(userPrivOtherName);
                            $.ajax({
                                url:"/syspara/selectTheSysPara?paraName=IS_SHOW_SECRET",
                                success:function(res) {
                                    var data = res.object[0];
                                    if(data.paraValue == 1) {
                                        if(userSecrecyCode){
                                            //查询系统代码人员密级
                                            $.ajax({
                                                url: '/code/getCode?parentNo=USER_SECRECY',
                                                type: 'get',
                                                dataType: 'json',
                                                success: function (res) {
                                                    var data=res.obj;
                                                    for(var i=0; i<data.length; i++){
                                                        if (data[i].codeNo == userSecrecyCode) {
                                                            $("#user_secrecy").html('<span class="textSpan">密级:</span><span class="contentSpan">'+data[i].codeName+'</span>');
                                                        }
                                                    }
                                                }
                                            })
                                        }else {
                                            $("#user_secrecy").html('<span class="textSpan">密级:</span><span class="contentSpan">无</span>');
                                        }
                                    }
                                }
                            })
                        }else {
                            $("#user_secrecy").hide();
                            $(".juede_suopings").hide();
                            $("#deptInfo").hide();

                        }
                    }else {
                        //    进入此处，说明没有开启三员管理,展示所有信息
                        $('.per_all').find('h1').html('<span class="textSpan">'+userDetails_th_name+':</span><span class="contentSpan">'+name+'</span>');

                        if(postName && dept){
                            $('.per_all').find('#deptInfo').html(dept);
                            $('.per_all').find('.juede_suopings').html('<span class="textSpan">'+userDetails_th_post+':</span><span class="contentSpan">'+postName+'</span>')
                        }
                        if(dept && postName==undefined){
                            $('.per_all').find('.juede_suopings').html('<span class="textSpan">'+userDetails_th_post+':</span><span class="contentSpan">'+dept+'</span>');
                        }
                        if(postName && dept==undefined){
                            $('.per_all').find('.juede_suopings').html('<span class="textSpan">'+userDetails_th_post+':</span><span class="contentSpan">'+postName+'</span>');
                        }

                        var userPriv = userPrivOtherName;
                        if(userPriv!==undefined){
                            if (userPriv.length >20) {
                                $('.per_all').find('h2').eq(1).html(userPriv.substring(0,20)+"...");
                                $('.per_all').find('h2').eq(1).mouseout(function () {
                                    $('.per_all').find('h2').eq(1).attr('title',userPriv.substring(0,userPriv.length-1));
                                });
                            }else{
                                $('.per_all').find('h2').eq(1).html(userPriv.substring(0,userPriv.length-1));
                            }

                            if(dept!= undefined){
                                $('.per_all').find('#deptInfo').html('<span class="textSpan">'+userManagement_th_department+':</span><span class="contentSpan">'+dept+'</span>');

                            }
                        }else{
                            if(dept!= undefined){
                                $('.per_all').find('#deptInfo').html('<span class="textSpan">'+userManagement_th_department+':</span><span class="contentSpan">'+dept+'</span>');
                            }
                        }

                        //若职务为空显示主角色
                        if(data.postName!=undefined && data.userPrivName !=undefined){
                            $('.per_all').find('.juede_suopings').html('<span class="textSpan">'+userDetails_th_post+':</span><span class="contentSpan">'+data.userPrivName+'</span>')
                            $('.per_all').find('.juede_suoping').html(data.postName)

                        }
                        if(data.postName==undefined && data.userPrivName !=undefined){
                            $('.per_all').find('.juede_suopings').html('<span class="textSpan">'+userDetails_th_post+':</span><span class="contentSpan">'+data.userPrivName+'</span>')
                        }
                        if(data.postName!=undefined && data.userPrivName ==undefined){
                            $('.per_all').find('.juede_suopings').html('<span class="textSpan">'+userDetails_th_post+':</span><span class="contentSpan">'+data.postName+'</span>')
                        }

                        // if(postName && userPrivName){
                        //     $('.per_all').find('h2').html(userPrivName+','+postName);
                        // }

                        // $('.per_all').find('h2').eq(1).html(userPrivOtherName);
                        $.ajax({
                            url:"/syspara/selectTheSysPara?paraName=IS_SHOW_SECRET",
                            success:function(res) {
                                var data = res.object[0];
                                if(data.paraValue == 1) {
                                    if(userSecrecyCode){
                                        //查询系统代码人员密级
                                        $.ajax({
                                            url: '/code/getCode?parentNo=USER_SECRECY',
                                            type: 'get',
                                            dataType: 'json',
                                            success: function (res) {
                                                var data=res.obj;
                                                for(var i=0; i<data.length; i++){
                                                    if (data[i].codeNo == userSecrecyCode) {
                                                        $("#user_secrecy").html('<span class="textSpan">密级:</span><span class="contentSpan">'+data[i].codeName+'</span>');
                                                    }
                                                }
                                            }
                                        })
                                    }else {
                                        $("#user_secrecy").html('<span class="textSpan">密级:</span><span class="contentSpan">无</span>');
                                    }
                                }
                            }
                        })
                    }
                }
            })
            $('.per_all').find('h1').html('<span class="textSpan">'+userDetails_th_name+':</span><span class="contentSpan">'+name+'</span>');

            if(postName && dept){
                $('.per_all').find('#deptInfo').html(dept);
                $('.per_all').find('.juede_suopings').html('<span class="textSpan">'+userDetails_th_post+':</span><span class="contentSpan">'+postName+'</span>')
            }
            if(dept && postName==undefined){
                $('.per_all').find('.juede_suopings').html('<span class="textSpan">'+userDetails_th_post+':</span><span class="contentSpan">'+dept+'</span>');
            }
            if(postName && dept==undefined){
                $('.per_all').find('.juede_suopings').html('<span class="textSpan">'+userDetails_th_post+':</span><span class="contentSpan">'+postName+'</span>');
            }

            var userPriv = userPrivOtherName;
            if(userPriv!==undefined){
                if (userPriv.length >20) {
                    $('.per_all').find('h2').eq(1).html(userPriv.substring(0,20)+"...");
                    $('.per_all').find('h2').eq(1).mouseout(function () {
                        $('.per_all').find('h2').eq(1).attr('title',userPriv.substring(0,userPriv.length-1));
                    });
                }else{
                    $('.per_all').find('h2').eq(1).html(userPriv.substring(0,userPriv.length-1));
                }

                if(dept!= undefined){
                    $('.per_all').find('#deptInfo').html('<span class="textSpan">'+userManagement_th_department+':</span><span class="contentSpan">'+dept+'</span>');
                }
            }else{
                if(dept!= undefined){
                    $('.per_all').find('#deptInfo').html('<span class="textSpan">'+userManagement_th_department+':</span><span class="contentSpan">'+dept+'</span>');
                }
            }

            //若职务为空显示主角色
            if(data.postName!=undefined && data.userPrivName !=undefined){
                $('.per_all').find('.juede_suopings').html('<span class="textSpan">'+userDetails_th_post+':</span><span class="contentSpan">'+data.userPrivName+'</span>')
                $('.per_all').find('.juede_suoping').html(data.postName)

            }
            if(data.postName==undefined && data.userPrivName !=undefined){
                $('.per_all').find('.juede_suopings').html('<span class="textSpan">'+userDetails_th_post+':</span><span class="contentSpan">'+data.userPrivName+'</span>')
            }
            if(data.postName!=undefined && data.userPrivName ==undefined){
                $('.per_all').find('.juede_suopings').html('<span class="textSpan">'+userDetails_th_post+':</span><span class="contentSpan">'+data.postName+'</span>')
            }

            // if(postName && userPrivName){
            //     $('.per_all').find('h2').html(userPrivName+','+postName);
            // }

            // $('.per_all').find('h2').eq(1).html(userPrivOtherName);
            $.ajax({
                url:"/syspara/selectTheSysPara?paraName=IS_SHOW_SECRET",
                success:function(res) {
                    var data = res.object[0];
                    if(data.paraValue == 1) {
                        if(userSecrecyCode){
                            //查询系统代码人员密级
                            $.ajax({
                                url: '/code/getCode?parentNo=USER_SECRECY',
                                type: 'get',
                                dataType: 'json',
                                success: function (res) {
                                    var data=res.obj;
                                    for(var i=0; i<data.length; i++){
                                        if (data[i].codeNo == userSecrecyCode) {
                                            $("#user_secrecy").html('<span class="textSpan">密级:</span><span class="contentSpan">'+data[i].codeName+'</span>');
                                        }
                                    }
                                }
                            })
                        }else {
                            $("#user_secrecy").html('<span class="textSpan">密级:</span><span class="contentSpan">无</span>');
                        }
                    }
                }
            })

            $('.personSrc').attr('src',$.cookie('personSrc'))

            $('.wybzd').text($('.juede_suoping').text())

            //针对中电建---若职务为空显示主角色
            if(data.postName==undefined || data.postName ==''){
                $('#zdjShow').html(data.userPrivName)
            }else{
                $('#zdjShow').html(data.postName)
            }
            var welcome;
            welcome = setInterval(function(){
                if(!$('body').is(":hidden")){
                    // 欢迎提示
                    welcomeTips();
                    clearInterval(welcome);
                }
            }, 1000)

        }
    })

    $('.reloadSide').on('click', function () {
        listTable()
    });

    $('.per_suoding ').on('click', function () {
        $(this).next().show()
        $(this).next().find('input').val('')
    });

    $('#LockCode').on('click', function (e) {
        var element = document.documentElement;
        if ($('[name="lockCode"]').val() == '') {
            $.layerMsg({content: mainlockempty+'！', icon: 2});
            return
        }

        $.cookie('lockCode', $('[name="lockCode"]').val())
        if(!$('.fullbody').hasClass('full-screen')) {
            $('.fullbody').addClass('full-screen');
            // 判断浏览器设备类型
            if(element.requestFullscreen) {
                element.requestFullscreen();
            } else if (element.mozRequestFullScreen){	// 兼容火狐
                element.mozRequestFullScreen();
            } else if(element.webkitRequestFullscreen) {	// 兼容谷歌
                element.webkitRequestFullscreen();
            } else if (element.msRequestFullscreen) {	// 兼容IE
                element.msRequestFullscreen();
            }
        }

        $('#go_back').click();
        if ($('.yonghu_touxiang').prop('src').indexOf('boy.png') != -1) {
            $('.personSrc').attr('src','/img/main_img/nantouxiang.png')
        } else if ($('.yonghu_touxiang').prop('src').indexOf('girl.png') != -1) {
            $('.personSrc').attr('src','/img/main_img/nvtouxiang.png')
        } else {
            $('.personSrc').attr('src',$('.yonghu_touxiang').prop('src'))
        }
        $.cookie('personSrc',$('.personSrc').attr('src'))
        $('.wybzd').text($('.per_all h1').text())
        if($('.layui-layer-shade').length > 0){
            $('.layui-layer-shade').eq($('.layui-layer-shade').length-1).click();
        }
        $('.posifixedCenter').find('input[type="password"]').val('')
        // var str = '<div class="posifixed">' +
        //     '<div style="position:fixed;width:200px;height:250px;left:50%;' +
        //     'margin-left:-100px;top: 50%;margin-top: -229px;">' +
        //     '<img style="width:100%;height:200px;" src="' + function () {
        //         if ($('.yonghu_touxiang').prop('src').indexOf('boy.png') != -1) {
        //             return '/img/main_img/nantouxiang.png'
        //         } else if ($('.yonghu_touxiang').prop('src').indexOf('girl.png') != -1) {
        //             return '/img/main_img/nvtouxiang.png'
        //         } else {
        //             return $('.yonghu_touxiang').prop('src')
        //         }
        //     }() + '" />' +
        //     '<span style="color: #fff;display: block;text-align: center;' +
        //     'line-height: 77px;font-size: 26px;">' +
        //     '<img src="/img/main_img/people.png" style="    vertical-align: initial;\
        // margin-right: 6px;"/>' + $('.juede_suoping').text() + '</span>' +
        //     '</div>' +
        //     '<div class="posifixedCenter" style="    margin-top: 65px;margin-left: -119px;">' +
        //     '<label><input type="password" style="height:27px;    width: 224px;" placeholder="'+mainlockunlockCode+'" style="margin-right: 10px;"><span id="theLock" style=" right: -17px;top: 0px;width: 38px;height: 37px;line-height: 35px;border-radius: 4px;text-align:center;"><img src="/img/main_img/icon_lock.png" /></span></label></div></div>'
        // $('body').append(str)
        $('.posifixed').show()
        document.onkeydown = function (e) {
            var ev = window.event || e;
            var code = ev.keyCode || ev.which;
            //
            if (code == 116) {
                if (ev.preventDefault) {
                    ev.preventDefault();
                } else {
                    ev.keyCode = 0;
                    ev.returnValue = false;
                }
            }
            // if(code == 27){
            //     ev.returnValue = false;
            // }
        }
        document.oncontextmenu = function () {
            return false;
        }
    })
    
    $('#theLocks').on('keypress', function(event){
        if(event.keyCode == "13")
        {
            $('#theLock').click()
        }
    });

    $(document).on('click', '#theLock', function () {
        if ($(this).prev().val() == $.cookie('lockCode')) {
            $.layerMsg({content: mainlockUnlockSuccessfully+'!', icon: 1}, function () {
                $('.posifixed').hide();
                $('#LockCode').parent().hide()
                $.cookie('lockCode', '')
                console.log($.cookie('lockCode'))
                document.onkeydown = function (e) {
                    return true
                }
                if(document.exitFullscreen) {
                    document.exitFullscreen();
                } else if (document.mozCancelFullScreen) {
                    document.mozCancelFullScreen();
                } else if (document.webkitCancelFullScreen) {
                    document.webkitCancelFullScreen();
                } else if (document.msExitFullscreen) {
                    document.msExitFullscreen();
                }
            });

        } else {
            $.layerMsg({content: mainlockPasswordError+'！', icon: 2});

        }
    })

    $('.cont_nav').on('click', 'li', function () {
        $(".cont_nav li").removeClass("infame");
        $(this).addClass('infame');

    });

    //点击关闭全部标签
    $('#iconCloseAll').on('click', function(){
        $('.main_title').find('.choose').remove();
        $('#f_0').css('display','block').siblings().remove();
        $('#t_0').css('display','block');
        $('.main_title').find('ul').css('left','0px');
        $(this).hide();
        $('#rightSpan').hide();
        $('#leftSpan').hide();
        $('.main_title').find('.gongzuoliu').removeAttr('style')
    })
    //右侧整体内容的tab切换

    $('.header').on('click', 'li span', function () {
        $(this).parent().siblings().find('span').removeClass('active');
        $(this).addClass('active');
        var iframesrc = $(this).parent().attr('iframesrc');
        var newWindow = $(this).parent().attr('newWindow');
        if (iframesrc == '/document/personal_ZDJ' || iframesrc == '/document/energyEfficiency_ZDJ') {
            $('#setPersonal_ZDJ').show();
        } else {
            $('#setPersonal_ZDJ').hide();
        }
        if (iframesrc.indexOf('operationsCockpit_ZDJ') > -1) {
            $('#setFullScreen_ZDJ').show();
        } else {
            $('#setFullScreen_ZDJ').hide();
        }
        if(newWindow == 1){
            window.open(iframesrc,'_blank')
        }else{
            $('#contmain_1 iframe').attr('src',iframesrc);
        }

    })
    //内容右侧tab切换
    var currentIndex = 4;
    var index;
    $('#taskbar_right').on('click', '.topLogo ', function (event) {
        // index = $(this).parent().find('.task_centerActive ').index($(this));
        index = $(this).parent().find('.topLogo ').index($(this));
        if(index==1){
            layer.closeAll();
        }
        if($(this).hasClass('logo_checks')){
            if (currentIndex != index) {
                currentIndex = index;
                $("#taskbar_right .topLogo").removeClass('logo_checks');
                $(this).addClass('logo_checks');
                //内容
                var contents = $(".side_all").find(".position");
                $(contents[index]).animate({width: "310px"});
                $(contents[index]).show()
                $(contents[index]).siblings().hide()
                $(contents[index]).siblings().css('width', '0px');
            }else{
                $(this).removeClass('logo_checks');
                $(this).find('a').removeClass('activeTwo');
                var contents = $(".side_all").find(".position");
                $(contents[index]).hide();
                $(contents[index]).css('width', '0px');
            }
        }else{
                //判断是否更换主题一栏
                if($(this).attr('isTheme')){
                    $('#admin-side2').css('overflow-y','auto')
                }
                currentIndex = index;

                $("#taskbar_right .topLogo").removeClass('logo_checks');
                $("#taskbar_right a").removeClass('activeTwo');
                $(this).addClass('logo_checks')
                $(this).find('a').addClass('activeTwo');
                //内容
                var contents = $(".side_all").find(".position");
                $(contents[index]).animate({width: "310px"});
                $(contents[index]).show()
                $(contents[index]).siblings().hide()
                $(contents[index]).siblings().css('width', '0px');

        }


        event.stopPropagation();

    });
    //顶部折叠功能
    $('#back').on('click', function(){
        var winHeight = 0;
        if (window.innerHeight)
            winHeight = window.innerHeight;
        else if ((document.body) && (document.body.clientHeight))
            winHeight = document.body.clientHeight;
        if (document.documentElement && document.documentElement.clientHeight)
            winHeight = document.documentElement.clientHeight;

        var type = $(this).attr('dataType')
        // console.log($("#sessionType").val())
        if(type == 0){
            $('.head').height(52);
            $('.head_left').find('img').hide()
            $('.head_left').height(6)
            $('#taskbar_right').css('marginTop','-16px')
            $('.head_rig a').css('marginTop','0px')
            document.getElementById("client").style.height = winHeight - 82 + "px";

            $('#tab_cTwo').height($('#client').height()-45);
            $(this).attr('dataType','1')
            if($("#sessionType").val() == 'theme6'||$("#sessionType").val() == 'theme7'){
                $('#back').css('background','url(/img/main_img/'+$("#sessionType").val()+'/btn_down.png)')

            }else{
                $('#back').css('background','url(/img/icon_btn_downmo.png)')

            }

            $('#back').css('backgroundSize','contain')
            $('.weather').hide();
            $('.head_left font').hide()
            if(bannerText!=""){
                $('.head_left img').hide()
            }
            $('.headTitle').show()
            $('.head_left img').hide()
            $('#taskbar_right').height(50)
            $('.QRCode').css('top','36px')
        }else{
            $('.head').height(107);
            $('.head_left').find('img').show()
            $('.head_left').height(61)
            $('#taskbar_right').css('marginTop','0px')
           $('.head_rig').css('marginTop','35px')
            document.getElementById("client").style.height = winHeight - 137 + "px";
            $('#tab_cTwo').height($('#client').height()-45);
            $(this).attr('dataType','0')
            if($("#sessionType").val() == 'theme6'||$("#sessionType").val() == 'theme7'){
                $('#back').css('background','url(/img/main_img/'+$("#sessionType").val()+'/btn_up.png)')
            }else{
                $('#back').css('background','url(/img/icon_btn_upmo.png)')
            }

            $('#back').css('backgroundSize','contain')
            $('.weather').show();

            if(bannerText!=""){
                $('.head_left font').show()
                $('.head_left img').hide()
            }else{
                $('.head_left font').show()
                // $('.head_left font').hide()
                $('.head_left img').show()
            }
            $('.headTitle').hide()
            $('#taskbar_right').height(46)
            $('.QRCode').css('top','35px')
        }
        $.ajax({
            url:"/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ",
            success:function(res) {
                if(res.object[0].paraValue == 1) {
                    if($(".headTitle").css("display") != "none") {
                        $(".secretText").hide()
                        var textFontSize = $(".headTitle").css("fontSize");
                        $(".headTitle").css("display","inline-block");
                        $(".headTitle").append('<span class="testText" style="vertical-align:middle;color:red; font-size: '+textFontSize+'; font-family: Microsoft yahei;font-weight: bold">机密级★ </span>');
                    } else{
                        $(".headTitle .testText").remove();
                        $(".secretText").show()
                    }
                }else {
                    $(".secretText").hide()
                }
            }
        })

    })

    //内容右侧 提醒下的tab切换
    var currentIndexTwo = 9;
    var index;
    $('.tixing_tab_t').on('click', 'li', function () {
        index = $(this).index();
        /* console.log(index);*/
        if (currentIndexTwo != index) {
            currentIndexTwo = index;
            $(".tixing_tab_t li").removeClass("tixing_check");
            $(this).addClass("tixing_check");
            //内容
            var contents = $("#tixing_tab_c").find("ul");
            $(contents[index]).show();
            $(contents[index]).siblings().hide();
        }

    });

    //点击返回按钮，右边内容收回
    $('.position').on('click', '#go_back', function () {

        $('.position').animate({width: "0px"});
        $('.side_all').find('.position').hide();
        $('#searchText').val('');
        currentIndex = 4;
        $('#taskbar_right').find('a').removeClass('activeTwo')


    });
    $('#headID').on('click', function () {
        $('.position').animate({width: "0px"});
        $('.side_all').find('.position').hide();
        $('#searchText').val('');
        currentIndex = 4;
        $('#taskbar_right').find('a').removeClass('activeTwo')
    })
    $('.cont_left').on('click', function () {
        $('.position').animate({width: "0px"});
        $('.side_all').find('.position').hide();
        $('#searchText').val('');
        currentIndex = 4;
        $('#taskbar_right').find('a').removeClass('activeTwo')
    })
    $(document).on('click', '.cont_rig', function () {
        $('.position').animate({width: "0px"});
        $('.side_all').find('.position').hide();
        $('#searchText').val('');
        currentIndex = 4;
        $('#taskbar_right').find('a').removeClass('activeTwo')
    })
    //鼠标移入左三角，变色
    $('.left_scroll').on('mouseover', function () {
        $(this).css('background', 'url(img/main_img/tabs_arrow.png) -71px 0px no-repeat');
    });

    $('.left_scroll').on('mouseout', function () {
        $(this).css('background', 'url(img/main_img/tabs_arrow.png) -10px 0px no-repeat');
    })

    //鼠标移入右三角，变色
    $('.right_scroll').on('mouseover', function () {
        $(this).css('background', 'url(img/main_img/tabs_arrow.png) -98px 0px no-repeat');
    });

    $('.right_scroll').on('mouseout', function () {
        $(this).css('background', 'url(img/main_img/tabs_arrow.png) -37px 0px no-repeat');
    });


    //鼠标点击，右边logo变颜色
    $('.task_centerActive').on('click', function () {
        $(this).addClass('activeTwo')
        $(this).siblings('a').removeClass('activeTwo')
        if ($(this).attr('data-step') == 6) {
            listTable()
        }
    });

    //点击设置 ，变样式
    $('#admin-side3').on('click', '.per_shezhi', function () {

        $(this).siblings().removeClass('button_chacked');
        $(this).addClass('button_chacked');
    });
    //点击锁定 ，变样式
    $('#admin-side3').on('click', '.per_suoding', function () {

        $(this).siblings().removeClass('button_chacked');

        $(this).addClass('button_chacked');
    });
    //点击注销 ，变样式
    $('#admin-side3').on('click', '.per_zhuxiao', function () {
        $(this).siblings().removeClass('button_chacked');
        $(this).addClass('button_chacked');
    });
    //移入
    $('.main_title').on('mouseover', 'li', function () {

        $(this).find('.close').attr('src', 'img/main_img/'+$("#sessionType").val()+'/delet_yuan.png');
        $(this).find('.img').show();
    });
    //移出
    $('.main_title').on('mouseout', 'li', function () {
        $(this).find('.img').hide();
    });
    //点击标题栏
    $('.main_title ').on('click', 'li', function () {
        $('.main_title li').removeClass('change');
        $(this).addClass('change');
        var t_this = $(this).attr('id');
        var num = t_this.split('_')[1];
        var url = $(this).attr('url');
        if ($('#f_' + num).length > 0) {
            /*console.log($('#f_'+num).length);*/
            $('.all_content .iItem').hide();
            $('#f_' + num).show();
            // $('#f_' + num).find('iframe').attr('src',url)
        }
        $(this).siblings().css({
            'background': 'url(img/main_img/'+$("#sessionType").val()+'/title_no.png) 0px 4px no-repeat',
            'color': '#fff',
            'position': 'relative',
            'z-index': 999
        })
        $(this).css({
            'background': 'url(img/main_img/title_yes.png) 0px 4px no-repeat',
            'color': '#2a588c',
            'position': 'relative',
            'z-index': 99999
        })
    });
    //删除
    //点击删除
    $('.main_title').on('click', '.close', function () {
        var me = this;
        mobileObj.right(function () {
            var re = $(me).parent().parent().attr('id');
            var delet = re.split('_')[1];
            $('#t_' + delet).siblings().attr('style', 'background:url(img/main_img/'+$("#sessionType").val()+'/title_no.png) 0px 4px no-repeat; ');
            $('#t_' + delet).siblings().css('color', '#fff');
            $('#t_' + delet).prev().attr('style', 'background:url(img/main_img/title_yes.png) 0px 4px no-repeat; position: relative; z-index: 99999;');
            $(me).parent().parent().remove();
            if ($('#f_' + delet).prev().find('iframe').attr('src') == '') {
                $('#f_0').show();
                $('#f_' + delet).remove();
            } else {
                $('#f_' + delet).prev().show();
                $('#f_' + delet).remove();
            }
            if ($('.main_title ul li').length == mobileObj.liNum) {
                $('#leftSpan').hide()
                $('#rightSpan').hide()
            }
        });
        var re = $(me).parent().parent().attr('id');
        var delet = re.split('_')[1];
        $('#t_' + delet).siblings().attr('style', 'background:url(img/main_img/'+$("#sessionType").val()+'/title_no.png) 0px 4px no-repeat; ');
        $('#t_' + delet).siblings().css('color', '#fff');
        $('#t_' + delet).prev().attr('style', 'background:url(img/main_img/title_yes.png) 0px 4px no-repeat; position: relative; z-index: 99999;');

        $(me).parent().parent().remove();
        if ($('#f_' + delet).prev().find('iframe').attr('src') == '') {
            $('#f_0').show();
            $('#f_' + delet).remove();
        } else {
            $('#f_' + delet).prev().show();
            $('#f_' + delet).remove();
        }
        if($('.main_title ul li').length > 7){
            $('#iconCloseAll').show();
        }else{
            $('#iconCloseAll').hide();
        }
        if($('.main_title ul li').length <=1){
            $('#f_0').show();
            $('#f_' + delet).remove();
        }
    });
    $('.tab_t').on('click', 'li', function () {

        $(".tab_t li").removeClass("yingy");
        $(this).addClass('yingy');
        if ($(this).attr('id') == 'use') {
            /* init(); */
            $('.tab_cone').css("display", "block");
            $('.tab_ctwo').css("display", "none");
            $('.tab_cthree').css("display", "none");
        } else if ($(this).attr('id') == 'commonSetting') {
            $('.tab_cone').css("display", "none");
            $('.tab_ctwo').css("display", "none");
            $('.tab_cthree').css("display", "block");
        } else {
            $('.tab_cone').css("display", "none");
            $('.tab_cthree').css("display", "none");
            $('.tab_ctwo').css("display", "block");
        }

    });

    //向左移动
    $('.right_scroll').on('click', function () {
        /* console.log($('.main_title li').length>=6); */
        if (!bl) {
            if (numTwo <= 6) {
                bl = true;
                return;
            }
            numTwo--;
            $('.left_scroll').show();
            $('.main_title li').animate({left: "-=100px"});
            $('.main_title ul').animate({width: "+=110px"});

        }
    })

    //向右移动
    $('.left_scroll').on('click', function () {
        if (bl) {
            numTwo++;
            if (numTwo == numthree) {
                bl = false;
            }
        }
        /*	console.log($('.main_title li').length>=8);*/
        if ($('.main_title li').length >= 6) {
            $('.right_scroll').show();
            $('.main_title li').animate({left: "+=100px"});

            if ($('.main_title li:nth-child(1)').attr('left') == 0) {
                $('.main_title li:nth-child(1)').css('left', '0px');
            }
        }
    });
    //组织
    $('.all_ul .tab_ctwo').on('click', '.childdept', function () {
        var that = $(this);

//            getChDept(that.next(),that.attr('deptid'));
    });
    //点击常用功能里面的div,进行页面跳转。
    $('.s_container').on('click', '.every_logo', function () {
        var tid = $(this).attr('menu_tid');
        if (tid == '0124') {
            return
        }
        var url = $(this).attr('url');
        /*	console.log(tid);
         console.log(url);*/

        if ($('#f_' + tid).length > 0) {
            $('.all_content .iItem').hide();
            $('#f_' + tid).show();

            $('#t_' + tid).css({
                'background': 'url(img/main_img/title_yes.png) 0px 4px no-repeat',
                'color': '#2a588c',
                'position': 'relative',
                'z-index': 99999
            })
            $('#t_' + tid).siblings().css({
                'background': 'url(img/main_img/'+$("#sessionType").val()+'/title_no.png) 0px 4px no-repeat',
                'color': '#fff',
                'position': 'relative',
                'z-index': 999
            })
        } else {
            if (mobileObj.statusTwo) {
                var titlestrs = '<li class="choose " url="'+url+'" index="0;" id="t_' + tid + '" title="' + $(this).find('h2').html() + '"><h1>' + $(this).find('h2').html() + '</h1><div class="img" style="display:none;"><img class="close" src="img/main_img/icon.png"></div></li>';
                var iframestr = '<div id="f_' + tid + '" class="iItem"><iframe id="every_module" src="' + url + '" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize" tid="2"></iframe></div>';

                $('.main_title ul').append(titlestrs);
                $('#t_' + tid).siblings().attr('style', 'background: url(img/main_img/'+$("#sessionType").val()+'/title_no.png) -1px 2px no-repeat; ');
                $('#t_' + tid).siblings().css('color', '#fff');
                $('.all_content').append(iframestr);
                $('.all_content .iItem').hide();
                $('#f_' + tid).show();
                mobileObj.left()
            }
        }
    })


    $('#zd_menu').on('click',function(){
        if(flag4){
            $('.two_menu ul').css('display','block');
            $('.two_menu ul').addClass('actives');
            flag4=false;
            $('.person').find('.down_jiao').attr('src','img/main_img/'+$("#sessionType").val()+'/up.png');
            $('.person').find('.er_img').attr('src','img/main_img/'+$("#sessionType").val()+'/up.png');
            $('#zd_menu').removeClass('add_float');
            $('#zd_menu').removeClass('add_default');
            $('#zd_menu').removeClass('reduce_float');
            $('#zd_menu').addClass('reduce_default');
        }else{
            $('.two_menu ul').css('display','none');
            $('.one_all').removeClass('one_check');
            flag4=true;
            $('.person').find('.down_jiao').attr('src','img/main_img/'+$("#sessionType").val()+'/down.png');
            $('.person').find('.er_img').attr('src','img/main_img/'+$("#sessionType").val()+'/down.png');
            $('#zd_menu').removeClass('add_float');
            $('#zd_menu').removeClass('reduce_float');
            $('#zd_menu').removeClass('reduce_default');
            $('#zd_menu').addClass('add_default');
        }
    })
    $('#use').on('click',function(){
        $('#zd_menu').css('display','block');
    })
    $('#orgnize').on('click',function(){
        $('#zd_menu').css('display','none');
    })
    $('#commonSetting').on('click',function(){
        $('#zd_menu').css('display','none');
    })


     // 欢迎提示
     function welcomeTips(){
        var userName = $(".per_all").children('h1').html();
        var deptName = $(".per_all").children('h3').text();
         $.ajax({
             type:'get',
             async: false,
             url:'/getBrithDay',
             dataType:'json',
             success:function (res) {
                 $.ajax({
                     url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
                     success:function(obj) {
                         var data = obj.object[0];
                         if(data.paraValue == 0) {
                         //    开启三员管理的话只提示姓名就可以
                             if(res.flag){
                                 layer.tips('<span size="11pt" color="#FCFDF4">'+main_welcome+'，'+userName+'<br><span style="display: inline-block;width: 100%; text-align: center">'+main_happyBirthdayToYou+'!</span></span>', $('#theme'), {
                                     tips: [3, '#4873c1'],
                                     time: 10000,
                                     id: 'tips'
                                 });
                             }else{
                                 layer.tips('<span size="11pt" color="#FCFDF4">'+main_welcome+'，'+userName+'</span>', $('#theme'), {
                                     tips: [3, '#4873c1'],
                                     time: 10000,
                                     id: 'tips'
                                 });
                             }
                         }else {
                             if(res.flag){
                                 layer.tips('<span size="11pt" color="#FCFDF4">'+main_welcome+'，'+userName+'<br>'+deptName+'<br><span style="display: inline-block;width: 100%; text-align: center">'+main_happyBirthdayToYou+'!</span></span>', $('#theme'), {
                                     tips: [3, '#4873c1'],
                                     time: 10000,
                                     id: 'tips'
                                 });
                             }else{
                                 layer.tips('<span size="11pt" color="#FCFDF4">'+main_welcome+'，'+userName+'<br>'+deptName+'</span>', $('#theme'), {
                                     tips: [3, '#4873c1'],
                                     time: 10000,
                                     id: 'tips'
                                 });
                             }
                         }
                     }
                 })

             }
         })
    }

})
