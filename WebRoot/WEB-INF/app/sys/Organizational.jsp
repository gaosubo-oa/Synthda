<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <title>多组织管理</title>
    <link rel="stylesheet" type="text/css" href="../lib/laydate/skins/default/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../css/news/center.css"/>
    <script type="text/javascript" src="../js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="../js/news/page.js"></script>

    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <%--<script src="../lib/laydate/laydate.js"></script>--%>
    <script src="https://cdn.bootcss.com/jquery.form/4.2.1/jquery.form.js"></script>
    <style>
        .bx {
            width: 100%
        }

        .headDiv {
            width: 100%;
            height: 45px;
            border-bottom: #999 1px solid;
            overflow: hidden;
            position: fixed;
            top: 0;
            left: 0;
            background: #fff;
        }

        .divP {
            float: left;
            height: 45px;
            line-height: 45px;
            font-size: 22px;
            margin-left: 10px;
            color: #494d59;
        }

        .div_Img {
            float: left;
            width: 23px;
            height: 100%;
            margin-left: 30px;
        }

        .div_Img img {
            width: 23px;
            height: 23px;
            margin-top: 11px;
        }

        .newBtn {
            float: right;
            display: inline-block;
            width: 85px;
            height: 32px;
            background-color: #2f80d1;
            margin-top: 7px;
            margin-right: 10.3%;
            font-size: 14px;
            cursor: pointer;
            border: #ccc 1px solid;
            color: #fff;
            border-radius: 5px;
        }

        .div_txt {
            float: left;
            height: 32px;
            line-height: 32px;
            margin-left: 5px;
        }

        .div_IMG {
            float: left;
            width: 14px;
            height: 100%;
            margin-left: 5px;
        }

        .div_IMG img {
            width: 14px;
            height: 14px;
            margin-top: 9px;
        }

        .tab {
            width: 80%;
            margin: 66px auto 10px auto;
            /* margin-top: 66px;*/
        }

        .tab table {
            width: 99%;
            font-size: 14px;
            margin: 0 auto;
        }

        .tab table tr {
            border: 1px solid #c0c0c0;
            /*cursor: pointer;*/
        }

        .tab table tr th {
            color: #2F5C8F;
            font-weight: normal;
        }

        .tab table tr:nth-child(odd) {
            background-color: #fff;
        }

        .tab table tr:nth-child(even) {
            background-color: #F6F7F9;
        }

        .tab table tr.userData:hover {
            background-color: #74d174;
        }

        .tab table tr th, .tab table tr td {
            padding: 10px;
        }

        .tab table tr th, .tab table tr td {
            text-align: center;
        }

        .tab table a {
            text-decoration: none;
            text-align: left;
            display: inline-block;
            color: #2B7FE0;
        }

        .searchBox li {
            margin-bottom: 15px;
        }

        .searchBox li input[type="text"] {
            border: 1px solid #ccc;
            font-size: 14px;
            height: 32px;
            line-height: 34px;
            padding: 0 10px;
            width: 265px;
            float: left;
            border-radius: 4px;
            text-align: left;
        }

        .searchBox li input[type="text"]:focus {
            border-color: #0090e3;
        }

        .searchBox li label {
            height: 34px;
            width: 92px;
            line-height: 32px;
            text-align: right;
            margin-right: 10px;
            float: left;
            padding-right: 8px;
        }

        .select {
            width: 100px;
            height: 32px;
            border-radius: 4px;
        }
        .th{
            font-size: 13pt;
        }
        td{
            font-size: 11pt;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<div class="bx">
    <!--head开始-->
    <div class="headDiv">
        <div class="div_Img">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_organizationmanagement_03.png"
                 style="vertical-align: middle;" alt="多组织管理">
        </div>
        <div class="divP"><fmt:message code="depatement.th.Multiorganizational"/></div>
        <div class="newBtn" id="user_btn" style="display: block;">
            <div class="div_IMG">
                <img src="../img/sys/icon_newlyBuild.png" style="vertical-align: middle;" alt="新建组织">
            </div>
            <div class="div_txt"><fmt:message code="controller.th.newOrg"/></div>
        </div>
        <%--<input type="button" name="user_btn" id="user_btn" value="新建公司" />--%>
    </div>

    <!--content部分开始-->
    <div>
        <div class="tab">
            <table id="tr_td" cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
                <thead>
                <tr>
                    <td class="th">
                        <fmt:message code="controller.th.shiyi"/>
                    </td>
                    <td class="th" width="50%">
                        <fmt:message code="controller.th.shier"/>
                    </td>
                    <!-- <td class="th" style="position: relative"><%--<fmt:message code="notice.title.Releasedate" />--%>
                               <img style="position: absolute;margin-left:9px;cursor: pointer;" src="../img/fiveth.png" alt=""/>
                             <img style="position: absolute;margin-top:13px;margin-left:9px;cursor: pointer;" src="../img/sixth.png " alt=""/>
                        </td> -->
                    <%--<td class="th">--%>
                    <%--&lt;%&ndash; <fmt:message code="notice.title.Releasedate"/>&ndash;%&gt;<fmt:message code="depatement.th.Edition" />--%>
                    <%--</td>--%>

                    <td class="th" style='display: none;'>
                        <%-- <fmt:message code="news.th.clicks"/>--%>
                        <fmt:message code="depatement.th.Whether"/>
                    </td>
                    <td class="th">
                        <%--<fmt:message code="news.th.comment"/>--%>
                        <fmt:message code="notice.th.operation"/>
                    </td>
                    <!-- <td class="th">发布部门</td> -->
                </tr>
                </thead>
                <tbody id="j_tb" class="tr_td">

                </tbody>
            </table>
        </div>


    </div>
    <!--content部分结束-->

</div>
</div>


<script>
    user_id = 'input_text1';//选人控件
    $(function () {
        var data = {
            read: $('.index_head .one').parent().attr('data_id'),
            typeId: $('#select').val() == 0 ? '' : $('#select').val(),
            nTime: $('#sendTime').val(),
            page: 1,
            pageSize: 10,
            useFlag: true,
            newsTime: '',
            lastEditTime: '',
            content: '',
            subject: ''

        };
        initPageList(function (pageCount) {
            console.log(pageCount);
            initPagination(pageCount, data.pageSize);
        });


        $(".index_head li").on("click",function (){
            $(this).find('span').addClass('one').parent().siblings('').find('span').removeClass('one');  // 删除其他兄弟元素的样式
            $(".news").html($(this).find('span').text());
            data.read = $(this).attr('data_id');
            data.typeId = $('#select').val() == 0 ? '' : $('#select').val();
            data.nTime = $('#sendTime').val();
            console.log(data);
            if (data.read == '' || data.read == 0) {
                $('.step1').show();
                $('.center').hide();
                initPageList(function (pageCount) {
                    initPagination(pageCount, data.pageSize);
                });
            } else if (data.read == 1) {
                $('.step1').hide();
                $('.center').show('');
                $('#subject').val('');
                $('#beginTime').val('');
                $('#endTime').val('');
                $('#select').val() == 0 ? '' : $('#select').val();
                $('#content').val('');
            }
        })

        function initPageList(cb) {
            var layerIndex = layer.load(0, {shade: false});
            /* 0代表加载的风格，支持0-2 */
            $.ajax({
                type: "get",
                url: "${pageContext.request.contextPath}/sys/getOrgManage",
                dataType: 'JSON',
                data: data,
                success: function (obj) {
                    layer.closeAll();
                    if (obj.object.length == 0) {
                        if ($('.index_head .one').parent().attr('data_id') == '0') {
                            layer.msg('<fmt:message code="notice.alert.nodatealert" />', {icon: 6});
                            var turnindex = setInterval(function () {
                                layer.closeAll();
                                $(".index_head li").eq(1).click();
                                clearInterval(turnindex);
                            }, 2 * 1000);
                        } else {
                            layer.msg('<fmt:message code="global.lang.nodata" />', {icon: 6});
                        }
                        ;
                    } else {
                        var str = "";


                        for (var i = 0; i < obj.object.length; i++) {
                            var isOrgValue;
                            if (obj.object[i].isOrg == 1) {
                                isOrgValue = "是"
                            } else {
                                isOrgValue = "否"
                            }

                            str += "<tr><td><a href='###' style='color:#666;' oid=" + obj.object[i].oid + "  class='windowOpen'>" + obj.object[i].oid + "</ a></td>" +
                                "<td><a href='###' style='color:#111;' oid=" + obj.object[i].oid + " class='windowOpen'>" + obj.object[i].name + "</ a></td>" +
                                //                                    "<td><a href='###'  style='color:#666;' oid=" + obj.object[i].oid + " class='windowOpen'>" + obj.object[i].version + "</ a></td>" +
                                "<td style='display: none;'><a href='###'  style='color:#666;' oid=" + obj.object[i].oid + "  class='windowOpen'>" + isOrgValue + "</ a></td>" +

                                "<td>" + function () {
                                    if (obj.object[i].oid == 1001) {
                                        if(obj.code=='130140'){
                                            return '<a href=\'###\' oid=" + obj.object[i].oid + "  class=\'windowOpen thupdate\'>编辑</ a>'
                                        }else{
                                            return ''
                                        }
                                       } else {
                                        return '<a href=\'###\' oid=" + obj.object[i].oid + "  class=\'windowOpen thupdate\'>编辑</ a>'
                                      }
                                }() + "</td>";
                        }
                        var loadindex = setInterval(function () {
                            layer.closeAll();
                            $("#j_tb").html(str);
                            clearInterval(loadindex);
                            if(!obj.turn){
                                $('#user_btn').hide();
                                $('#j_tb .thupdate').hide();
                            }
                        }, 1000);

                        if (cb) {
                            //alert(obj.totleNum);
                            cb(obj.totleNum);
                        }
                    }

                }
            })
        };

        function initPagination(totalData, pageSize) {
            $('.M-box3').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage: '<fmt:message code="global.page.first" />',
                endPage: '<fmt:message code="global.page.last" />',
                prevContent: '<fmt:message code="global.page.pre" />',
                nextContent: '<fmt:message code="global.page.next" />',
                jumpBtn: '<fmt:message code="global.page.jump" />',
                callback: function (index) {
                    data.page = index.getCurrent();
                    console.log(index.getCurrent());
                    initPageList();
                }
            });
        };

        queryDept($('#user_btn'));

        //新建公司
        $('#user_btn').on("click",function () {
            layer.open({
                title: ['新建组织', 'background-color:#2b7fe0;color:#fff;'],
                shade: 0,
                content: '<div style="width: 462px">' +
                '<ul class="searchBox clearfix">' +
                '<li style="float: left">' +
                '<label style="color: #2F5C8F;font-weight: 500;"><fmt:message code="depatement.th.Corporatename" />：</label><input type="text" style="color:#000;" name="name" value="">' +
                '</li>' +
                <%--'<li style="float: left">' +--%>
                <%--'<label style="color: #2F5C8F;font-weight: 500;"><fmt:message code="depatement.th.Edition" />：</label><input type="text" style="color:#000;" name="version"  value="">' +--%>
                <%--'</li>' +--%>
                '<li style="display: none;float: left">' +
                '<label style="color: #2F5C8F;font-weight: 500;"><fmt:message code="depatement.th.Whether" />：</label><select name="isOrg" class="select"><option value="0"><fmt:message code="global.lang.no" /></option><option value="1"><fmt:message code="global.lang.yes" /></option></select>' +
                '</li>' +
                '</ul></div>',
                area: ['500px', '280px'],
                btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'],
                yes: function () {

                    var data = {
                        'name': $('input[name="name"]').val(),
                        'version': '17.07.03',
                        'isOrg': $('.select option:checked').val()
                    }
                    console.log(data);
                    if ($('input[name="name"]').val() == '') {
                        layer.alert('<fmt:message code="depatement.th.entercompanyname" />', {title: ['<fmt:message code="information" />', 'background-color:#2b7fe0;color:#fff;']});
                        return;
                    }
                    $.ajax({
                        type: 'post',
                        url: '/sys/addOrgManage',
                        dataType: 'json',
                        data: data,
                        success: function (json) {
                            if (json.msg == "ok") {
                                layer.msg('<fmt:message code="depatement.th.Newsuccessfully" />', {icon: 1});
                                setInterval(function () {
                                    location.reload();
                                }, 1000);


                            } else {
                                layer.msg('<fmt:message code="depatement.th.Newfailed" />。。', {icon: 2});

                            }
                        }
                    })

                }
            })
        });

        $("#j_tb").on('click', '.thupdate', function () {
            var $oid = $(this).parents('tr').find('td')[0].innerText;
            var $name = jQuery($(this).parents('tr').find('td')[1]).text();
            var $version = $(this).parents('tr').find('td')[2].innerText;
            var $isOrg = $(this).parent().prev().text();
            if ($isOrg == '是') {
                $isOrg = 1;
            } else {
                $isOrg = 0;
            }
            var me = this;


            layer.open({
                title: ['<fmt:message code="depatement.th.modify" />', 'background-color:#2b7fe0;color:#fff;'],
                shade: 0,
                content: '<div style="width: 462px"><form id="updatecom" action="${pageContext.request.contextPath}/sys/editOrgManage">' +
                '<ul class="searchBox clearfix">' +
                '<li style="float: left">' +
                '<label style="color: #2F5C8F;font-weight: 500;"><fmt:message code="depatement.th.CompanyID" />:</label><input type="text" style="color:#000;background-color:#eee;" name="oid" value="' + $oid + '" readonly="true" style="background: #fff">' +
                '</li>' +
                '<li style="float: left">' +
                '<label style="color: #2F5C8F;font-weight: 500;"><fmt:message code="depatement.th.Corporatename" />:</label><input type="text" style="color:#000;" name="name" value="' + $name + '">' +
                '</li>' +
//                '<li style="float: left">' +
//                '<label style="color: #2F5C8F;font-weight: 500;">版本:</label><input type="text" style="color:#000;" name="version"  value="' + $version + '">' +
//                '</li>' +
                '<li style="display:none;float: left">' +
                '<label style="color: #2F5C8F;font-weight: 500;"><fmt:message code="depatement.th.Whether" />:</label><select name="isOrg" id="sele" class="select"><option value="0"><fmt:message code="global.lang.no" /></option><option value="1"><fmt:message code="global.lang.yes" /></option></select>' +
                '</li>' +
                '</ul></form></div>',
                area: ['500px', '350px'],
                success: function () {
                    $('#updatecom #sele').val($isOrg);
                },
                btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'],
                yes: function (index) {
                    $('#updatecom').ajaxSubmit(function (json) {

                        for (var i = 0; i < json.object.length; i++) {
                            if (json.object[i].oid == $oid) {

                                $(me).parents('tr').find('td')[1].innerText = json.object[i].name;
                                $(me).parents('tr').find('td')[2].innerText = json.object[i].version;

                                if (json.object[i].isOrg == 1) {
                                    $(me).parents('tr').find('td')[3].innerText = '是'
                                } else {
                                    $(me).parents('tr').find('td')[3].innerText = '否'
                                }
                            }

                        }


                    });
                    location.reload();
                }
            })

        });


        $('.submit').on("click",function () {
            data.read = $('.index_head .one').parent().attr('data_id');
            data.typeId = $('#select').val();
            data.nTime = $('#sendTime').val();
            //console.log(read,typeId,nTime);
            initPageList();
        });
        //时间控件调用
        $('#btn_query').on("click",function () {

            data.subject = $('#subject_query').val();
            data.newsTime = $('#beginTime').val();
            data.lastEditTime = $('#endTime').val();
            data.typeId = $('#select_query').val() == 0 ? '' : $('#select_query').val();
            data.content = $('#content').val();
            initPageList();
            $('.step1').show();
            $('.center').hide();
        });
    });

//    laydate({
//        elem: '#sendTime', //目标元素。
//        format: 'YYYY-MM-DD', //日期格式
//        istime: true, //显示时、分、秒
//    });
    //时间控件调用
    /*var start = {
        elem: '#beginTime',
        format: 'YYYY-MM-DD',
        /!* min: laydate.now(), //设定最小日期为当前日期*!/
        /!* max: '2099-06-16 23:59:59', //最大日期*!/
        istime: true,
        istoday: false,
        choose: function (datas) {
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas; //将结束日的初始值设定为开始日
        }
    };
    var end = {
        elem: '#endTime',
        format: 'YYYY-MM-DD',
        /!*min: laydate.now(),*!/
        /!*max: '2099-06-16 23:59:59',*!/
        istime: true,
        istoday: false,
        choose: function (datas) {
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };
    laydate(start);
    laydate(end);*/

    function queryDept(element) {
        $.ajax({
            type: 'get',
            url: '/sys/checkOrgManage',
            dataType: 'json',
            success: function (res) {
                if (res.flag) {
                    element.show();
                } else {
                    element.hide();
                }
            }
        })
    }

</script>
</body>


</html>








