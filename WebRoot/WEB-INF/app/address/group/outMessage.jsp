<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><fmt:message code="address.th.externalRecipient" /></title>
    <%--<fmt:message code="global.page.first" />--%>
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta http-equiv="Content-Type" content="text/html;">
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
<%--    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">--%>
<%--    <link rel="stylesheet" type="text/css" href="../css/bootstrap.tag.css">--%>
<%--    <link rel="stylesheet" type="text/css" href="../css/jquery-ui-1.10.3.custom.min.css">--%>
<%--    <link rel="stylesheet" type="text/css" href="../css/address/index.css"/>--%>
<%--    <link rel="stylesheet" type="text/css" href="../css/dept/deptManagement.css"/>--%>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>

    <%--<script>

            var regex_match = /(nokia|iphone|android|motorola|^mot-|softbank|foma|docomo|kddi|up.browser|up.link|htc|dopod|blazer|netfront|helio|hosin|huawei|novarra|CoolPad|webos|techfaith|palmsource|blackberry|alcatel|amoi|ktouch|nexian|samsung|^sam-|s[cg]h|^lge|ericsson|philips|sagem|wellcom|bunjalloo|maui|symbian|smartphone|midp|wap|phone|windows ce|iemobile|^spice|^bird|^zte-|longcos|pantech|gionee|^sie-|portalmmm|jigs browser|hiptop|^benq|haier|^lct|operas*mobi|opera*mini|320x320|240x320|176x220)/i;

            var u = navigator.userAgent;

            if (null == u) {
                //return true;
            }
            var result = regex_match.exec(u);
            if (null == result) {
                //return false
            } else {
                location.href = '/address/addressh5';
                //return true
            }


    </script>--%>
    <style>
        /*#img6{*/
        /*margin-left:13px;*/
        /*}*/
        .select{
            background: #ccebff!important;
        }
        .wrap{
            height:100%;
        }
        .left{
            height:calc(100% - 50px);
            overflow-y:auto;
        }

    </style>
<%--    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>--%>
<%--    <script type="text/javascript" src="../js/js_lang.js"></script>--%>
    <%--<script src="../js/jquery/jquery.min.js"></script>--%>
<%--    <script src="../js/bootstrap/bootstrap.min.js"></script>--%>
<%--    <script src="../js/jquery/jquery-ui.custom.min.js"></script>--%>
    <script src="/js/base/base.js"></script>
    <script type="text/javascript">
        numstring=true;
        function show_dept(uid){
            document.getElementById("show_add").src = "/address/show_add?deptId=" + uid ;
        }

        function goto(SHARE_TYPE, groupId, PUBLIC_FLAG, TYPE,e) {
            e.attr('pd','1');
            e.addClass('select')
            e.parent().addClass('select')
            e.parent().siblings().find('a').removeClass('select')
            e.parent().siblings().removeClass('select')
            e.parent().siblings().find('span').removeClass('select')
            var power = document.getElementById("power").value;
            var sharing = document.getElementById("sharing").value;
            var url = "/address/showList?groupId=" + groupId + "&PUBLIC_FLAG=" + PUBLIC_FLAG + "&SHARE_TYPE=" + SHARE_TYPE + "&TYPE=" + TYPE +"&deptid=" +e.attr('deptid');
            document.getElementById('groupId').value = groupId;
            //document.getElementById('iframe_export').src = "address/export.php?GROUP_ID="+GROUP_ID;
            document.getElementById('talklist').src = url;
            document.getElementById('search_list').value = '<fmt:message code="address.th.searchContacts" />...';
            document.getElementById("gettype").value = TYPE;
            document.getElementById("share_type").value = SHARE_TYPE;
            $('[name=list_hover]').css("background", "url(../img/address/white-tras.png) no-repeat");
        }

        function doinit() {
            var attr = "";
            $.ajax({
                type: 'post',
                url: '/addressGroup/selectAllAddressGroup',
                dataType: 'json',
                success: function (reg) {
                    if (reg['status']) {
                        var data = reg.data;
                        var content = "";
                        for (var i = 0; i < data.length; i++) {
                            attr += data[i].groupId+","

                            content += "<li><a  onclick='goto(0," + data[i].groupId + ",0,1,$(this)),search_box(this.innerText)'  title='" + data[i].groupName + "'>" + function(){
                                if(data[i].userId==""){
                                    return data[i].groupName+'(公共)'
                                }else{
                                    return data[i].groupName
                                }
                            }()+ "</a></li>";
                            /* content +="<li class='fz' onClick='show_group('"+data[i].groupId+"',0); title='"+data[i].groupName+"'><span style='margin-right:54px'>"+data[i].groupName+"</span>"
                             +"<span class='dl' style='position:absolute;right:20px;*+top:5px;' onClick='delete_group('"+data[i].groupId+"');'><img class='imgx' src='../img/address/x.png' /></span></li>";
                             */
                        }
                        $("#my_group_count").val(data.length+1);
                        $("#my_group").append(content);
                        $("#power").attr("value",attr);
                        $("#key3").attr("value","1");
                        $("#sharing").attr("value","");
                        /*第一次加载时定位分组高度*/
                        var my_group_count = $('#my_group_count').val();
                        var share_group_count = $('#share_group_count').val();
                        var work_group_count = $('#work_group_count').val();
                        var height = $(window).height() - $('#lianxi').offset().top - 132;

//                        if (height - my_group_count * 47 > 0) {
//                            $('#my_group').height(my_group_count * 47);
//                        }
//                        else {
//                            $('#my_group').height(height);
//                        }

                        if (height - share_group_count * 47 > 0) {
                            $('#share').height(share_group_count * 47);
                        }
                        else {
                            $('#share').height(height);
                        }

                        if (height - work_group_count * 47 > 0) {
                            $('#work').height(work_group_count * 47);
                        }
                        else {
                            $('#work').height(height);
                        }
                    }
                }
            });
        };
        var boolTwo= false;
        function ajaxdata(id,me,event){
//            event.stopPropagation()
            goto(2,id,0,2,$(me))
            show_dept(id)
            $(".kf").hide();




        }


        //获取我的通讯簿分组

        $(function () {
//            dragSplitter();
            doinit();

            loadSidebar1($(".pick"),0)
            function loadSidebar1(target,deptId,fn) {

                $.ajax({
                    url: '/department/getChDeptfq',
                    type: 'get',
                    data: {
                        deptId: deptId
                    },
                    dataType: 'json',
                    success: function (data) {
                        var str = '';
                        data.obj.forEach(function (v, i) {
                            if (v.deptName) {
                                str += '<li><span  data-numtrue="1" ' +
                                    'onclick= "imgDown(' +v.deptId + ',this,event)" data-types="1"  data-numString="1"  style="height:35px;line-height:35px;padding-left: 3px" deptid="' + v.deptId + '" class="childdept">' +
                                    '<span class=""></span>' +
                                    '<img src="/img/sys/dapt_right.png" alt="" style="margin-left: 12px;width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;">' +
                                    '<a href="javascript:void(0)" style="color: #000" class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a></span>' +
                                    '<ul style="display:none;" class="dpetWhole0"></ul></li>';
                            }
                        })
                        widthnum++;
                        if(fn!=undefined){
                            fn();
                        }

                        target.append(str);

                    }
                })
            }

//            /*第一次加载时定位分组高度*/
//            var my_group_count = $('#my_group_count').val();
//            alert($('#my_group_count').val())
//            var share_group_count = $('#share_group_count').val();
//            var work_group_count = $('#work_group_count').val();
//            var height = $(window).height() - $('#lianxi').offset().top - 132;
//
//            if (height - my_group_count * 47 > 0) {
//                $('#my_group').height(my_group_count * 47);
//            }
//            else {
//                $('#my_group').height(height);
//            }
//
//            if (height - share_group_count * 47 > 0) {
//                $('#share').height(share_group_count * 47);
//            }
//            else {
//                $('#share').height(height);
//            }
//
//            if (height - work_group_count * 47 > 0) {
//                $('#work').height(work_group_count * 47);
//            }
//            else {
//                $('#work').height(height);
//            }


            /*第一次加载时字母列取高度*/
            var letter_arr = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
            var circle_count = Math.floor(($(window).height() - $('#list').offset().top) / 38)//圆的个数
            var letter_count = Math.ceil(26 / circle_count);//每个圆最多放字母数
            var el_count = (letter_count * circle_count) % 26;//少字母的圆（放字母letter_count-1个）
            var all_count = 26 - el_count;//满字母的圆（放字母letter_count个）
            var for_count = 0;//循环计数

            var s_letter_str = '<ul id="list_letter">';
            $("#list_letter").remove();
            if (letter_count > 26) {
                for (var i = 0; i < 26; i++) {
                    s_letter_str += '<li><a href="#" name="list_hover" onClick="show_list(\'' + letter_arr[i] + '\');" hidefocus="true">' + letter_arr[i] + '</a></li>';
                }
                console.log(s_letter_str)
            }
            else {
                for (var i = 0; i < circle_count; i++) {
                    var letter_old = "";//临时存储字母
                    var letter_show = ""//显示字母
                    if (for_count < (el_count * (letter_count - 1))) {
                        for (var j = 0; j < (letter_count - 1); j++) {
                            letter_old += letter_arr[for_count];
                            for_count++;
                        }
                        if (letter_count > 3) {
                            letter_show = letter_old.substring(0, 1) + letter_old.substring(letter_count - 2);
                        }
                        else {
                            letter_show = letter_old;
                        }
                        s_letter_str += '<li><a href="#" name="list_hover" onClick="show_list(\'' + letter_old + '\');" hidefocus="true">' + letter_show + '</a></li>';

                    }

                    else {
                        for (var j = 0; j < letter_count; j++) {
                            letter_old += letter_arr[for_count];
                            for_count++;
                        }

                        if (letter_count > 2) {
                            letter_show = letter_old.substring(0, 1) + letter_old.substring(letter_count - 1);
                        }
                        else {
                            letter_show = letter_old;
                        }
                        if(letter_show=='undefined'){
                            s_letter_str+=''
                        }else{
                            s_letter_str += '<li><a href="#" name="list_hover" onClick="show_list(\'' + letter_old + '\');" hidefocus="true">' + letter_show + '</a></li>';
                        }


                    }
                }
            }
            s_letter_str += '</ul>';

            $("#list_letter").remove();
            $("#list").append(s_letter_str);

            /*第一次加载时定义联系人iframe高度*/
            $('#talklist').height($(window).height() - $('#lianxi').offset().top);

            $(window).resize(function () {
                var height = $(window).height() - $('#lianxi').offset().top - 132;
                if (height - my_group_count * 47 > 0) {
                    $('#my_group').height(my_group_count * 47);
                }
                else {
                    $('#my_group').height(height);
                }

                if (height - share_group_count * 47 > 0) {
                    $('#share').height(share_group_count * 47);
                }
                else {
                    $('#share').height(height);
                }

                if (height - work_group_count * 47 > 0) {
                    $('#work').height(work_group_count * 47);
                }
                else {
                    $('#work').height(height);
                }
                /*字母列取高度*/
                var letter_arr = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
                var circle_count = Math.floor(($(window).height() - $('#list').offset().top) / 38)//圆的个数
                var letter_count = Math.ceil(26 / circle_count);//每个圆最多放字母数
                var el_count = (letter_count * circle_count) % 26;//少字母的圆（放字母letter_count-1个）
                var all_count = 26 - el_count;//满字母的圆（放字母letter_count个）
                var for_count = 0;//循环计数

                var s_letter_str = '<ul id="list_letter">';
                $("#list_letter").remove();
                if (letter_count > 26) {
                    for (var i = 0; i < 26; i++) {
                        s_letter_str += '<li><a href="#" name="list_hover" onClick="show_list(\'' + letter_arr[i] + '\');" hidefocus="true">' + letter_arr[i] + '</a></li>';
                    }
                }
                else {
                    for (var i = 0; i < circle_count; i++) {
                        var letter_old = "";//临时存储字母
                        var letter_show = ""//显示字母
                        if (for_count < (el_count * (letter_count - 1))) {
                            for (var j = 0; j < (letter_count - 1); j++) {
                                letter_old += letter_arr[for_count];
                                for_count++;
                            }
                            if (letter_count > 3) {
                                letter_show = letter_old.substring(0, 1) + letter_old.substring(letter_count - 2);
                            }
                            else {
                                letter_show = letter_old;
                            }
                            s_letter_str += '<li><a href="#" name="list_hover" onClick="show_list(\'' + letter_old + '\');" hidefocus="true">' + letter_show + '</a></li>';
                        }
                        else {
                            for (var j = 0; j < letter_count; j++) {
                                letter_old += letter_arr[for_count];
                                for_count++;
                            }
                            if (letter_count > 2) {
                                letter_show = letter_old.substring(0, 1) + letter_old.substring(letter_count - 1);
                            }
                            else {
                                letter_show = letter_old;
                            }
                            s_letter_str += '<li><a href="#" name="list_hover" onClick="show_list(\'' + letter_old + '\');" hidefocus="true">' + letter_show + '</a></li>';
                        }
                    }
                }
                s_letter_str += '</ul>';

                $("#list_letter").remove();
                $("#list").append(s_letter_str);

                /*字母选择样式效果*/
                $('[name=list_hover]').on('click',function () {
                    $(this).css("background", "url(../img/address/black-tras.png) no-repeat")
                    $(this).parent().siblings().children().css("background", "url(../img/address/white-tras.png) no-repeat")
                })

                /*定义联系人列的高度*/
                $('#talklist').height($(window).height() - $('#lianxi').offset().top);

                /*联系人详细信息高度*/
                $("#show_add").contents().find("#right").height($(window).height());
            });

            $("#my_group_show").on('click',function () {
                $("#my_group").toggle();
                $("#share").hide();
                $("#work").hide();
            })
            $("#share_show").on('click',function () {
                $("#share").toggle();
                $("#work").hide();
                $("#my_group").hide();
            })
            $("#work_show")on('click',function () {
                $("#work").toggle();
                $('.pick').show();


                $("#my_group").hide();
                $("#share").hide();

            })
            $("#new_add2").on('click',function () {
                $('#iframe_new').attr("src", "/address/new");
            })
            //编辑用户信息edit
            $("#edit").on('click',function () {
                var addId = $('#show_add_id').val();
                $('#iframe_edit').attr("src", "/address/edit?uid=" + addId);
            })

            $("#import_info2").on('click',function () {
                $('#iframe_import').attr("src", "/address/goImportUsers");
            })
            $("#export_info2").on('click',function () {
                var keyword = $("#search_list").val();
                if (keyword.indexOf("搜索") > -1) {
                    keyword = "";
                }
                $('#iframe_export').attr("src", "address/export.php?keyword=" + keyword);
            })
            $(".nav ul li a").on('click',function () {
                $(this).css("background-color", "#ccebff!important")
                $(this).parent().css("background-color", "#ccebff!important")
//                $(this).parent().siblings().children().css("background-color", "#F8F8F8")
            })
            $("#search_list").keyup(function () {
                var keyword = $("#search_list").val();
                var key1 = $("#key1").val();
                var key2 = $("#key2").val();
                var groupId = $("#groupId").val();
                var flag = $("#key3").val();
                var gettype = $("#gettype").val();//点击我的分组与共享状态
                var power = $("#power").val();  //我的分组有权限的ID
                var sharing = $("#sharing").val();//共享的GROUP_ID
                var share_type = $("#share_type").val();//我的分组与共享的区别状态
                $('#talklist').attr('src',"/address/showList?psnName=" + keyword + "&userName=" + keyword+'&gettype='+gettype)
//                frames['talklist'].location = "/address/showList?psnName=" + keyword + "&userName=" + keyword ;
            })
            $("#search_list").focus(function () {
                var keyword = $("#search_list").val();
                if (keyword.indexOf("搜索") > -1) {
                    $("#search_list").val("");
                }
            })
            $("#search_list").blur(function () {
                var keyword = $("#search_list").val();
                if (keyword == "") {
                    $("#search_list").val($("#search_box").val());
                }
            })
            $('[name=list_hover]').on('click',function () {
                $(this).css("background", "url(../img/address/black-tras.png) no-repeat")
                $(this).parent().siblings().children().css("background", "url(../img/address/white-tras.png) no-repeat")
            })
            //关闭分组管理进行操作
            $("#hide_group").on('click',function () {
                window.location.reload();
            })
        })

        /*各种层提交事件*/
        //添加联系人
        function submit_new() {
            document.getElementById('iframe_new').contentWindow.CheckForm();
            //frames["iframe_new"].document.getElementById("form1").submit();
        }

        function submit_edit() {
            document.getElementById('iframe_edit').contentWindow.CheckForm();
        }
        function submit_group() {
            document.getElementById('iframe_group').contentWindow.group_submit();
        }
        function submit_import() {
            document.getElementById('iframe_import').contentWindow.importAddress();
        }
        function submit_export() {
            document.getElementById('iframe_export').contentWindow.export_submit();
        }

        /*字母定位函数*/
        function show_list(key) {
            var list_arr = key.split("");
            var top_height;
            for (var i = 0; i < list_arr.length; i++) {
                if ($(window.frames["talklist"].document).find("#" + list_arr[i] + "").length > 0) {
                    top_height = $(window.frames["talklist"].document).find("#" + list_arr[i] + "").offset().top;

                    //$(window.frames["talklist"].document)find("#show_talklist").animate({scrollTop: top_height }, 500);
                    $('html,body', window.frames["talklist"].document).animate({scrollTop: top_height}, 500);
                    return;
                }
            }
        }
        function setdragcookie(splitterbarleft) {
            var today = new Date();
            var expires = new Date();
            expires.setTime(today.getTime() + 1000 * 60 * 60 * 24 * 365);
            document.cookie = "addrbarleft=" + splitterbarleft + "; path=/general/address/; expires=" + expires.toGMTString();
        }
        function dragSplitter() {
            var splitterwidth = $("#splitter-bar-vertical").width();
            $("#splitter-bar-vertical").draggable({
                containment: "#splitter-bar-scroll",
                axis: "x",
                start: function () {
                    $(".splitter-bar-scroll").addClass("splitter-bar-scroll-on");
                    $(".splitter-overlay").show();
                },
                drag: function () {
                    $(".splitter-bar-scroll").addClass("splitter-bar-scroll-on");
                },
                stop: function () {
                    $(".splitter-overlay").hide();
                    $(".splitter-bar-scroll").removeClass("splitter-bar-scroll-on");
                    var verticalleft = $("#splitter-bar-vertical").offset().left;
                    $(".left").css("width", verticalleft - 1);
                    $(".center").css("left", verticalleft + splitterwidth);
                    $("#splitter-bar").css("left", $("#splitter-bar-vertical").position().left);
                    setdragcookie($("#splitter-bar-vertical").position().left);
                }
            });
        }
        function search_box(value) {
            newStr = value.replace(/\([^\)]*\)/g, "");
            if (newStr.length > 7) {
                newStr = newStr.substr(0, 6) + "...";
            }
            document.getElementById("search_list").value = "<fmt:message code="workflow.th.sousuo" /> " + newStr + " <fmt:message code="adding.th.lianxi" />";
            document.getElementById("search_box").value = "<fmt:message code="workflow.th.sousuo" /> " + newStr + " <fmt:message code="adding.th.lianxi" />";

        }
        function closeIframe() {
            $("#hide_new").trigger('click');
        }
    </script>
    <style>
        ul {
            padding: 0;
            margin: 0;
        }

        input[type="button"] {
            width: 88px;
        }
        .dpetWhole0{overflow: auto}
        dpetWhole0 li{white-space: nowrap;}
        a{
            color: #000;
        }
        .head {
            width: 100%;
            background: #fff;
            border-bottom: 1px solid #9E9E9E;
            padding-bottom: 0;
            height: 45px;
        }
        .head_left {
            width: 100%;
        }
    </style>
</head>
<body marginwidth="0" marginheight="0" style="height: 100%;overflow:hidden;background:#f6f7f9;">
<div class="wrap" style="margin-left:0px !important;">
    <div class="head">
        <div class="head_left">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/address.png" style="height: 30px;width: 30px;" alt="">
            <h1 style="line-height: 26px;"><fmt:message code="main.addressbook" /></h1>
            <%--<h1>部门/成员单位管理</h1>--%>
        </div>
    </div>
    <!--新建联系人-->
    <div id="new_add" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static"
         style="top: 50%;margin-top: -226px;left: 50%; margin-left: -500px;width: 1000px;">
        <div class="modal-body" style="max-height: 400px;height: 400px;padding: 0px;overflow: hidden;">
            <iframe width="100%" height="100%" id="iframe_new" name="iframe_new" frameborder="0" src="">
            </iframe>
        </div>
        <div class="modal-footer" style="padding-bottom: 10px;padding-top: 10px;text-align:center;">
            <button class="btn btn-primary" onClick="submit_new()"  aria-hidden="true"  style="margin-left:220px;"><fmt:message code="global.lang.save" /></button>
            <button class="btn" data-dismiss="modal" aria-hidden="true" id="hide_new"><fmt:message code="global.lang.close" /></button>
        </div>
    </div>

    <!--编辑联系人-->
    <div id="edit_add" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
         style="top: 50%;margin-top: -226px;left: 50%; margin-left: -500px;width: 1000px;">
        <div class="modal-body" style="max-height: 400px;height: 400px;padding: 0px;overflow: hidden;">
            <iframe width="100%" height="100%" id="iframe_edit" name="iframe_edit" frameborder="0" src="">
            </iframe>
        </div>
        <div class="modal-footer" style="padding-bottom: 10px;padding-top: 10px;text-align:center;">
            <button class="btn btn-primary" onClick="submit_edit()" style="margin-left:220px;"><fmt:message code="global.lang.save" /></button>
            <button class="btn" data-dismiss="modal" aria-hidden="true" id="hide_edit"><fmt:message code="global.lang.close" /></button>
        </div>
    </div>

    <!--分组管理-->
    <div id="group_manage" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
         style="top: 50%;margin-top: -226px;left: 50%; margin-left: -500px;width: 1000px;">
        <div class="modal-body" style="max-height: 400px;height: 400px;padding: 0px;overflow: hidden;">
            <iframe width="100%" height="100%" id="iframe_group" name="iframe_group" frameborder="0" src="">
            </iframe>
        </div>
        <div class="modal-footer" style="padding-bottom: 10px;padding-top: 10px;text-align:center;">
            <button class="btn btn-primary" onClick="submit_group()" style="margin-left:213px;"><fmt:message code="global.lang.save" /></button>
            <button class="btn" data-dismiss="modal" aria-hidden="true" id="hide_group"><fmt:message code="global.lang.close" /></button>
        </div>
    </div>

    <!--导入数据-->
    <div id="import_info" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
         style="top: 50%;margin-top: -211px;left: 50%; margin-left: -375px;width: 750px;">
        <div class="modal-body" style="max-height: 370px;height: 370px;padding: 0px;overflow: hidden;">
            <iframe width="100%" height="100%" id="iframe_import" name="iframe_import" frameborder="0" src="">
            </iframe>
        </div>
        <div class="modal-footer" style="padding-bottom: 10px;padding-top: 10px;text-align:center;">
            <button class="btn btn-primary" onClick="submit_import()"><fmt:message code="workflow.th.Import" /></button>
            <button class="btn" data-dismiss="modal" aria-hidden="true" id="hide_import"><fmt:message code="global.lang.close" /></button>
        </div>
    </div>

    <!--导出数据-->
    <div id="export_info" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
         style="top: 50%;margin-top: -226px;left: 50%; margin-left: -450px;width: 900px;">
        <div class="modal-body" style="max-height: 400px;height: 400px;padding: 0px;overflow: hidden;">
            <iframe width="900px" height="100%" id="iframe_export" name="iframe_export" frameborder="0" src="">
            </iframe>
        </div>
        <div class="modal-footer" style="padding-bottom: 10px;padding-top: 10px;text-align:center;">
            <button class="btn btn-primary" onClick="submit_export()" style="margin-left:190px;"><fmt:message code="global.lang.report" /></button>
            <button class="btn" data-dismiss="modal" aria-hidden="true" id="hide_export"><fmt:message code="global.lang.close" /></button>
        </div>
    </div>

    <div class="content" style="min-width: 800px;height: 100%;width: 100%;">
        <%--<div class="splitter-overlay"></div>--%>
        <%--<div class="splitter-bar-scroll" id="splitter-bar-scroll">--%>
        <%--<div class="splitter-bar-bgd"></div>--%>
        <%--<div class="splitter-bar-vertical" id="splitter-bar"></div>--%>
        <%--<div class="splitter-bar-vertical ui-draggable" id="splitter-bar-vertical"></div>--%>
        <%--</div>--%>
        <div class="left">
            <div class="bts">
                <form id="form">
                    <button href="#new_add" id="new_add2" type="button" role="button" style="width:80px;height:30px;font-size:14px;border-radius: 3px;"
                            class="btn btn-success" data-toggle="modal"/>
                    <%--<i class="icon-plus icon-white"></i>--%><fmt:message code="global.lang.new" /> </button>
                    <input name="" href="#edit_add" type="hidden" value='<fmt:message code="global.lang.edit" />' role="button" class="bt" id="edit"
                           data-toggle="modal"/>
                    <div class="btn-group">
                        <button hidefocus="true" type="submit" class="btn btn-info dropdown-toggle"
                                style="width:80px;height:30px;font-size:14px;" data-toggle="dropdown"/>
                        <fmt:message code="email.th.more" /> <span class="caret"></span></button>
                        <ul class="dropdown-menu" style="left:-64px;">
                            <li><a id="group_manage2" href="#group_manage" role="button"
                                   data-toggle="modal"><fmt:message code="adding.th.fenzu" /></a>
                            </li>
                            <li><a id="import_info2" href="#import_info" role="button"
                                   data-toggle="modal">导入数据</a>
                            </li>
                            <%--<li><a id="export_info2" href="#export_info" role="button"--%>
                            <%--data-toggle="modal">导出数据</a>--%>
                            <%--</li>--%>
                            <li><a id="search_info" onClick="window.open('/address/conQuery');"><fmt:message code="adding.th.xiXUN" /></a>
                            </li>
                        </ul>
                    </div>
                </form>
            </div>
            <div class="lianxi" id="lianxi">
                <ul>
                    <li class="nav firstnav">
                    <span>
                        <img src="../img/address/myGroup.png" width="22" height="22"/>
                    </span>
                        <a id="my_group_show" style="height:40px;" href="javascript:;"
                           onClick="goto(0,-1,1,1,$(this)),search_box(this.innerText)"><fmt:message code="adding.th.me" /></a>
                        <ul id="my_group">
                            <a class="default" style="height: 46px;"  href="#" style="height:36px;" onClick="goto(0,0,0,1,$(this)),search_box(this.innerText)"><fmt:message code="main.th.mo" /></a>
                        </ul>
                    </li>
                    <li class="nav secondnav">
                    <span>
                        <i class="layui-icon layui-icon-share" style="font-size: 19px;color: #286B8F"></i>
                    </span>
                        <a id="share_group" style="height:40px;" href="javascript:;" onClick="goto(0,-1,1,1,$(this)),search_box(this.innerText)">共享</a>
                    </li>
                    <li class="nav thirdnav">
                    <span>
                        <img src="../img/address/colleague.png" width="22" height="22"/>
                    </span>
                        <a id="work_show" href="javascript:;"
                           onClick="goto(2,0,0,2,$(this)),search_box(this.innerText)"><fmt:message code="adding.th.tong" /></a>
                    <li class="pick" style="display: block;">
                        <%--<div class="pickCompany"><span style="height:35px;line-height:35px;" class="childdept"><img src="/img/spirit/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 10px;margin-left: 13px;margin-bottom: 4px;"><a href="javascript:void(0)" class="dynatree-title" title=""></a></span></div>--%>

                    </li>
                    <%--<ul id="work" style="height: <?=$height_work?>;">--%>
                    <%--<li class="all" onClick="goto(2,0,0,2),search_box(this.innerText)"><a href="#">全部</a>--%>
                    <%--</li>--%>
                    <%--</ul>--%>
                    </li>
                </ul>
            </div>
        </div>
        <div class="center" style="margin-top: 46px;">
            <div class="middle">
                <div class="input-append" style="margin-top:12px;margin-left:10px;">
                    <input name="" type="text" style="width:164px;" class="input-medium search-query span3" id="search_list"
                           value='<fmt:message code="adding.th.sou" />'/>
                    <span class="add-on" style="width:25px;background: #3c92e5 ;"><i class="icon-search icon-white" style="background: url('../../img/address/shape.png');width:17px;height:17px;"></i></span>
                </div>
                <div id="list">
                    <ul id="list_letter">
                    </ul>
                </div>
                <div id="name">
                    <input type="hidden" name="groupId" id="groupId" value="0">
                    <iframe width="100%" id="talklist" name="talklist" frameborder="0" src="/address/showList?TYPE=1&SHARE_TYPE=0&PUBLIC_FLAG=1">
                    </iframe>
                </div>
            </div>
            <input type="hidden" name="show_add_id" id="show_add_id" value="">
            <input type="hidden" name="key1" id="key1" value="">
            <input type="hidden" name="key2" id="key2" value="">
            <input type="hidden" name="key3" id="key3" value="<?=$flag?>">
            <input type="hidden" name="type" id="gettype" value="1">
            <input type="hidden" name="power" id="power" value="<?=$arr?>">
            <input type="hidden" name="sharing" id="sharing" value="<?=$sharing?>">
            <input type="hidden" name="share_type" id="share_type" value="0">
            <input type="hidden" name="my_group_count" id="my_group_count" value="<?=$i_group_count?>">
            <input type="hidden" name="share_group_count" id="share_group_count" value="<?=$i_share_count?>">
            <input type="hidden" name="work_group_count" id="work_group_count" value="<?=$i_work_count?>">
            <input type="hidden" name="search_box" id="search_box" value=" <fmt:message code="adding.th.sou" />">
            <div class="right">
                <iframe width="100%" height="100%" id="show_add" name="show_add" frameborder="0"
                        src="">
                </iframe>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            $("#group_manage2").on('click',function () {
                $('#iframe_group').attr("src", "/addressGroup/manager");
            });
            // 查询
            $(".search-query").on('change',function () {
            })
        });
    </script>
</div>
<!--编辑返回时返回编辑ID-->
</body>
</html>
