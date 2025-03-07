<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<head>

    <meta charset="UTF-8">
    <title><fmt:message code="url.th.commonApplicationSettings" /></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/sys/userInfor.css"/>
    <link rel="stylesheet" type="text/css" href="/css/sys/url.css"/>

<%--    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>

    <style>
        html,body{
            height: 100%;
        }
        .content .right {
            position: relative;
            float: none;
            width: 100%;
        }
        .title {
            height: 35px;
            line-height: 35px;
        }
        .title img {
            margin-left: 15px;
            vertical-align: middle;
            width: 24px;
            height: 26px;
            padding-bottom: 8px;
        }
        .title span {
            margin-left: 0px;
            font-size: 22px;
            line-height: 35px;
        }

        .right_module {
            position: absolute;
            top: 55px;
            left: 50px;
            right: 50px;
            bottom: 50px;
            padding: 50px 30px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        .right_box {
            position: relative;
            width: 100%;
            height: 100%;
        }
        .box_left {
            position: relative;
            height: 100%;
            float: left;
            width: 40%;
            overflow: auto;
        }
        .box_right {
            float: right;
            position: relative;
            width: 40%;
            height: 100%;
            overflow: auto;
        }
        .box_rights {
            float: right;
            position: relative;
            width: 100%;
            height: 100%;
            overflow: auto;
        }


        .box_con {
            height: 100%;
            position: absolute;
            top: 0;
            left: 0;
            padding-top: 26px;
            width: 100%;
            box-sizing: border-box;
        }
        .box_con .left_ul,
        .box_con .right_ul{
            height: 100%;
            overflow: auto;
            padding: 5px;
            box-sizing: border-box;
            border: 1px solid #ccc;
        }
        .ul_item {
            padding: 5px;
            line-height: 24px;
            cursor: default;
        }
        .save_setting {
            color:#fff;
            position: absolute;
            background-color: #2F8AE3;
            outline: none;
            border: 1px solid #ccc;
            padding: 8px 20px;
            bottom: 5px;
            width: 80px;
            left: 50%;
            margin-left: -20px;
            cursor: default;
            border-radius: 5px;
        }
        .btn-mini {
            width: 28px;
            height: 28px;
        }
        .btn_top{
            background: url('/img/commonTheme/desktop/top.png') no-repeat ;
        }
        .btn-bottom{
            background: url('/img/commonTheme/desktop/bottom.png') no-repeat ;
        }
        .btn-right{
            background: url('/img/commonTheme/desktop/right.png') no-repeat ;
        }
        .btn-left{
            background: url('/img/commonTheme/desktop/left.png') no-repeat ;
        }
        .inputlayout>ul ul>li.active {
            background: #4898d5;
            color: #fff;
        }
        .active{
            background: #4898d5;
            color: #fff;
        }
        .actives{
            background: #4898d5;
            color: #fff;
        }
    </style>

</head>
<body>
    <div class="content" id="myTable">
        <div class="right">
            <div class="title">
                <img src="../img/person.png" >
                <span><fmt:message code="url.th.commonApplicationSettings" /></span>
            </div>


            <div class="right_module" >
                <div style="margin-left:0px;margin-top:15%;position: absolute">
                    <td align="center" class="TableData" style="vertical-align: middle;">
                        <input class="btn btn-mini btn_top" style="border: none;cursor:default;"   type="button" >
                        <br><br>
                        <input class="btn btn-mini btn-bottom" style="border: none;cursor:default;"  type="button" value="  ">
                    </td>
                </div>




                <div class="right_box" style="margin-left: 50px;">
                    <div class="box_left">
                        <h3 style="padding-left: 5px;"><fmt:message code="url.th.commonApplicationMenu" /></h3>
                        <div class="box_con">
                            <ul class="left_ul  allacti " ></ul>
                        </div>
                    </div>


                    <div style="position:relative;float:left;margin-top:15%;margin-left:5%;margin-right:4%">
                        <input class="btn btn-mini btn-right"    type="button" style="cursor:default;border: none;">
                        <br><br>
                        <input class="btn btn-mini btn-left"    type="button" style="cursor:default;border: none;" >
                    </div>

                        <%--<div style="position:relative;float:left;margin-top:150px;margin-left:30px;margin-right:30px">--%>
                            <%--<input class="btn btn-mini btn-right"    type="button" style="cursor:pointer;border: none;">--%>
                            <%--<br><br>--%>
                            <%--<input class="btn btn-mini btn-left"    type="button" style="cursor:pointer;border: none;" >--%>
                        <%--</div>--%>
                    <div class="box_right" style="margin-right: 7%">
                        <h3 style="padding-left: 5px;"><fmt:message code="url.th.alternativeApplicationMenu" /></h3>
                        <div class="box_con">
                            <ul class="right_ul  allactis ">

                            </ul>
                        </div>
                    </div>

                </div>
                <button class="save_setting" ><fmt:message code="global.lang.save" /></button>
            </div>
        </div>
    </div>

    <script>
        var usuallyMenu = {};
        var data111 = location.search.split('?');
        var code_menu;
        if(data111!=""){
            code_menu = data111[1].split('=')[1];
        }

        $(function(){
            // 获取当前用户的所有菜单
            function showMenu() {
                $.get('/showMenu', function (res) {  //获取到右侧所有的菜单选项
                    if (res.flag) {
                        var data = buildData(res.obj, []);
                        var str = '';
                        data.forEach(function (item) {
                            // console.log(item.img)//获取到右侧所有的菜单选项,不包括子选项
                            if (item.img) {
                                str += '<li class="ul_item" style="cursor:default">-----[' + item.name + ']-----</li>'
                            } else if (!item.child || item.child.length == 0) {
                                var styleStr = '';
                                if (usuallyMenu[item.fId]) {
                                    styleStr = 'style="display:none;"'
                                }
                                str += '<li id="' + item.fId + '" class="ul_item li_item item" '+styleStr+'>' + item.name + '</li>'
                            }
                        });
                        $('.right_ul').append(str);
                    }
                });
            }

            // 获得已设置的常用应用列表
            $.get('/getUsuallyMenu', function(res){
                console.log(res)
                if (res.flag) {
                    var str = '';
                    res.obj.forEach(function(item){
                        str += '<li id="'+item.fId+'" class="ul_item li_item item">'+item.name+'</li>';
                        usuallyMenu[item.fId] = item.fId;
                    });
                    $('.left_ul').append(str);
                }
                showMenu();
            });

            $(document).delegate('.allacti>li','click',function () {
                $(this).parent().find('li').removeClass('active')
                $(this).addClass('active')

            })
            $(document).delegate('.allactis>li','click',function () {
                $(this).parent().find('li').removeClass('actives')
                $(this).addClass('actives')

            })

            //上移
            $(".btn_top").on('click',function(){
               // $('li.active').prev().before();
                var liId = $('.active.item').attr('id');
                $("#"+liId+"").insertBefore($("#"+liId+"").prev());

                if(liId==null){
                    alert('<fmt:message code="url.th.pleaseSelectAMenu" />！')
                }

            });

            //下移
            $(".btn-bottom").on('click',function(){
                var liId = $('.active.item').attr('id');
                $("#"+liId+"").next().insertBefore($("#"+liId+""));

                if(liId==null){
                    alert('<fmt:message code="url.th.pleaseSelectAMenu" />！')
                }

            });

            //右移
            $('.btn-left').on('click',function(){
                var id = $('.active.item').attr('id');

                if($('.item.active')){
                    $('#'+id, $('.right_ul')).show();
                    $('.item.active').remove();
                }else{
                    alert('<fmt:message code="url.th.pleaseSelectAMenu" />！')
                }

            });

            //左移
            $(".btn-right").on('click',function(){
                    var id = $('.actives.item').attr('id');
                    var $leftUl = $('.left_ul');
                    var $checkItem = $('#'+id, $leftUl);
                    if ($checkItem.length > 0) {
                        return false;
                    }
                    $checkItem = $('.actives.item').removeClass("actives").clone();
                    $leftUl.append($checkItem);
                $('#'+id, $('.right_ul')).hide();
                if(id==null){
                    alert('<fmt:message code="url.th.pleaseSelectAMenu" />！')
                }

            });

            //双击左移
            $(document).delegate('.allactis>li','dblclick',function () {
                var id = $('.actives.item').attr('id');
                var $leftUl = $('.left_ul');
                var $checkItem = $('#'+id, $leftUl);
                if ($checkItem.length > 0) {
                    return false;
                }
                $checkItem = $('.actives.item').removeClass("actives").clone();
                $leftUl.append($checkItem);
                $('#'+id, $('.right_ul')).hide();
                if(id==null){
                    alert('<fmt:message code="url.th.pleaseSelectAMenu" />！')
                }

            })
            //双击右移
            $(document).delegate('.allacti>li','dblclick',function () {
                var id = $('.active.item').attr('id');

                if($('.item.active')){
                    $('#'+id, $('.right_ul')).show();
                    $('.item.active').remove();
                }else{
                    alert('<fmt:message code="url.th.pleaseSelectAMenu" />！')
                }

            });
            // 保存设置
            $('.save_setting').on('click', function(){
                var $checkedItem = $('.li_item', $('.left_ul'));
                var shortcut = ''
                $checkedItem.each(function(){
                    // console.log(this)
                    shortcut += $(this).attr('id') + ',';
                });
                $.post('/user/updateshortcut', {shortcut: shortcut}, function(res){
                    if(code_menu==1){
                        layer.msg('<fmt:message code="url.th.commonSettingsSavedSuccessfully" />');
                    }else{
                        layer.msg('<fmt:message code="url.th.theCommonSettingsAreSavedSuccessfully" />');
                        parent.location.reload();
                    }
                });
            });

        });


        // 处理树结构数据为扁平数据
        function buildData(treeData, dataArr) {
            var tree = JSON.parse(JSON.stringify(treeData));

            tree.forEach(function(item){
                dataArr.push(item);
                item.child && item.child.length>0 ? buildData(item.child, dataArr) : "";
            });

            return dataArr;
        }
    </script>

</body>
</html>
