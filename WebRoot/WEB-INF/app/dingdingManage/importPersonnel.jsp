<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<head>
    <title>OA用户导入钉钉</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script type="text/javascript" src="/static/js/module.js"></script>
    <script type="text/javascript" src="../../lib/layer/layer.js?20201106"></script>
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1"/>
    <link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../lib/ueditor/formdesign/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../css/enterpriseManage/weixinqy.css">
    <link rel="stylesheet" type="text/css" href="/css/base.css">
    <link rel="stylesheet" type="text/css" href="../../css/common/style.css" />

    <style>
        #userlist .alert{ visibility: hidden; }
        #userlist .alert.active{ visibility: visible; }
        fieldset h5{
            font-size: 13pt;
        }
        #downChild{
            position: fixed;
            top: 46px;
            width: 19.9%;
            float: left;
            height: 100%;
            overflow-y: auto;
            overflow-x: hidden;
            border-right: #ccc 1px solid;
        }
        #downChild .dpetWhole0 .childdept{
            padding-left: 60px!important;
        }
        #downChild .dpetWhole0 ul .childdept{
            padding-left: 80px!important;
        }
        #downChild .dpetWhole0 ul ul li .childdept{
            padding-left: 95px!important;
        }

        #downChild li>span{
            font-size: 12pt;
        }

        .well{
            width: 78%;
            float: right;
        }
        legend h5{
            margin: 10px 0;
            margin-left: 20px;
            font-weight: bold;
        }
        .content .well{
            position: fixed;
            top: 46px;
            left: 19.9%;
            float: right;
            height: 100%;
            overflow-y: auto;
            overflow-x: hidden;
        }
        .span_btn span {
            border: #ccc 1px solid;
            padding: 2px 4px;
            border-radius: 3px;
            color: #2B7FE0;
        }
    </style>
</head>
<body>
<fieldset>
    <legend><h5>OA用户导入钉钉</h5></legend>
</fieldset>
<div class="content">
    <div id="downChild">
        <div class="pickCompany">
            <div style="padding-left: 16px;" class="childdept" style="vertical-align: middle;width: 15px;margin-right: 10px;margin-left: 13px;margin-bottom: 4px;">

            </div>
        </div>

    </div>
    <div class="well" >
        <div class="userlist-wrapper">
            <div id="pagediv">

            </div>
            <%--<form name="userForm" >--%>
            <%--<input type="hidden" name="username">--%>
            <%--<input type="hidden" name="userid">--%>
            <%--<input type="hidden" id="userId">--%>
            <%--<table  class="table table-striped table-bordered">--%>
            <%--<thead>--%>
            <%--<tr role="row">--%>
            <%--<th class="sorting_disabled" rowspan="1" colspan="1">用户名</th>--%>
            <%--<th class="sorting_disabled" rowspan="1" colspan="1">用户ID</th>--%>
            <%--<th class="sorting_disabled" rowspan="1" colspan="1">状态</th>--%>
            <%--<th class="sorting_disabled" rowspan="1" colspan="1">选项</th>--%>
            <%--<th class="sorting_disabled" rowspan="1" colspan="1">提示</th>--%>
            <%--</tr>--%>
            <%--</thead>--%>
            <%--<tbody id="userlist">--%>

            <%--</tbody>--%>
            <%--</table>--%>
            <%--</form>--%>
        </div>
    </div>
</div>

</body>

<script type="text/javascript" charset="utf-8">
    var pageObj;

    loadSidebar1($('#downChild'),0);

    $(document).delegate('.btnr1','click',function () {
        var userid=$(this).attr('uId');
        var openId=$(this).attr('openid');
        layer.open({
            type: 1,
            title: ['提示','background-color:#2e8ded;color:#fff'],
            content:'<div style="font-size: 18px;text-align: center;padding-top: 60px;">确认解绑！</div>',
            area: ['430px', '250px'],

            btn: ['确定','关闭'],
            yes:function(index){
                $.ajax({
                    url:'/dingding/removeBind',
                    type:'post',
                    data:{
                        'openId':openId,
                        'userId':userid
                    },
                    dataType:'json',
                    success:function(){

                        layer.close(index);
                        pageObj.init();

                    }
                })
            },
            btn1:function(index){
                layer.close(index)
            },
            btnAlign:'c'

        })


    })


    var user_id=null;
    var dingdingId;
    var opid;
    $(document).delegate('.btnr','click',function () {
        opid = $(this).attr('openId');
        $('#userId').removeAttr('userId');
        $('#userId').removeAttr('userName');
        user_id='userId';
        $.popWindow('/common/selectUser?0');
        dingdingId=$('#userId').attr('user_id');
        return dingdingId
    })

    // 部门树遍历方法
    function loadSidebar1(target,deptId) {
        $.ajax({
            url: '/dingdingManage/dingdingGetUserList',
            type: 'get',
            data: {
                deptId: deptId
            },
            dataType: 'json',
            success: function (data) {
                var strTop = '';
                var str = '';
                if(data.flag){
                    data.obj.forEach(function (v, i) {
                        if (v.deptName) {
//                            if(v.deptId != 1){
                                // 其它部门
                                str += '<li><span data-types="1"  data-numtrue="1" ' +
                                    'onclick= "imgDown_s(' +v.deptId + ',this)"  style="height:35px;line-height:35px;padding-left: 30px" deptid="' + v.deptId + '" class="firsttr childdept">' +
                                    '<span class=""></span>' +
                                    '<img src="/img/sys/dapt_right.png" alt="" style="margin-left: 12px;width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;">' +
                                    '<a href="javascript:void(0)" class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a>' +
                                    '</span><ul style="display:none;" class="dpetWhole0"></ul></li>';
                            /*} else{
                                // 顶部部门 第一个部门
                                strTop+= '<li><span data-types="1"  data-numtrue="1" ' +
                                    'onclick= "show_users(' +v.deptId + ')"  style="height:35px;line-height:35px;padding-left: 8px" deptid="' + v.deptId + '" class="firsttr childdept">' +
                                    '<span class=""></span>' +
                                    '<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="margin-left: 12px;width: 15px;height: 14px;margin-top: -3px;margin-right: 4px;">' +
                                    '<a href="javascript:void(0)" class="dynatree-title" title="' + v.deptName + '"（钉钉）>' + v.deptName + '（钉钉）</a>' +
                                    '</span><ul style="display:none;" class="dpetWhole0"></ul></li>';
                            }*/
                        }
                    });

                    widthnum++;
                    target.append(strTop);
                    target.append(str);

                    $('#userlist').append('<tr class="ja" ><td colspan="5" style="text-align:center">请选择部门，展示人员数据！</td></tr>');

                }

            }
        })
    }

    $.extend({
        loadSidebar_dd: function (target, deptId, fn) {
            $.ajax({
                url: '/department/getChDeptfq',
                type: 'get',
                data: {
                    deptId: deptId
                },
                dataType: 'json',
                success: function (data) {

                    if (deptId == 0) {
                        var str = '';
                        if ($(target).children('li').length == 0) {
                            data.obj.forEach(function (v, i) {
                                if (v.deptName) {
                                    str += '<li><span data-types="1" data-numstring="1"   data-numtrue="1" ' +
                                        'onclick= "imgDown_s(' + v.deptId + ',this)"  ' +
                                        'style="height:35px;line-height:35px;padding-left: 14px" ' +
                                        'deptid="' + v.deptId + '" class="childdept"><span class="">' +
                                        '</span><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" ' +
                                        'style="vertical-align: middle;width: 15px;' +
                                        'margin-right: 10px;margin-left:15px;">' +
                                        '<a href="javascript:void(0)" ' +
                                        'class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a>' +
                                        '</span><ul style="display:none;" class="dpetWhole0"></ul></li>';
                                }
                            })
                            target.html(str);
                        } else {
                            $(target).children('li').each(function (v, l) {
                                for (var i = 0; i < data.obj.length; i++) {
                                    if ($($(target).children('li')[i]).children('span').attr('deptid') != data.obj[i].deptId) {
                                        if (v.deptName) {
                                            str = '<li><span data-types="1" data-numstring="1"   data-numtrue="1" ' +
                                                'onclick= "imgDown_s(' + data.obj.deptId + ',this)"  ' +
                                                'style="height:35px;line-height:35px;padding-left: 14px" ' +
                                                'deptid="' + data.obj.deptId + '" class="childdept">' +
                                                '<span class="">' +
                                                '</span><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" ' +
                                                'style="vertical-align: middle;width: 15px;' +
                                                'margin-right: 10px;margin-left:15px;">' +
                                                '<a href="javascript:void(0)" ' +
                                                'class="dynatree-title" title="' + data.obj.deptName + '">' + data.obj.deptName + '</a>' +
                                                '</span><ul style="display:none;" class="dpetWhole0"></ul></li>';
                                        }
                                        $(target).append(str)
                                    }
                                }
                                return false
                            })
                        }
                        widthnum++;
                        if (fn != undefined) {
                            fn($(target).find('.dpetWhole0'))
                        }
                    } else {
                        var str = '';
                        if ($(target).children('li').length == 0) {
                            data.obj.forEach(function (v, i) {
                                var targetnum = parseInt($(target).prev().attr('data-numtrue'))

                                if (v.deptName && v.isHaveCh == 1) {
                                    str += '<li><span  onclick= "imgDown_s(' + v.deptId + ',this)" ' +
                                        'data-numString="2" deptid="' + v.deptId + '" ' +
                                        'data-numtrue="' + (targetnum + 1) + '"  ' +
                                        'style="padding-left:' +
                                        (20 + (20 * parseInt($(target).prev().attr('data-numtrue')))) + 'px;' +
                                        'height:35px;line-height:35px;"  deptid="' + v.deptId + '" class="childdept">' +
                                        '<span></span><img id="img' + v.deptId + '" src="/img/sys/dapt_right.png" ' +
                                        'style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" alt="">' +
                                        '&nbsp;<a href="javascript:void(0)" class="dynatree-title" ' +
                                        'title="' + v.deptName + '">' + v.deptName + '</a></span>' +
                                        '<ul style="display:none;"></ul></li>';
                                } else {
                                    str += '<li>' +
                                        '<span onclick="imgDown_s(' + v.deptId + ',this)" ' +
                                        'data-numString="1" deptid="' + v.deptId + '" ' +
                                        'data-numtrue="' + (targetnum + 1) + '" ' +
                                        'style="padding-left:' + (20 + (20 *
                                        parseInt($(target).prev().attr('data-numtrue')))) + 'px;' +
                                        'height:35px;line-height:35px;"  deptid="' + v.deptId + '" ' +
                                        'class="childdept"><span></span><img  src="/img/sys/dapt_right.png" ' +
                                        'style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" ' +
                                        'alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" ' +
                                        'title="' + v.deptName + '">' + v.deptName + '</a></span><ul ' +
                                        'style="display:none;"></ul></li>';
                                }

                            });
                            target.html(str);
                        } else {
                            $(target).children('li').each(function (v, l) {

                                for (var i = 0; i < data.obj.length; i++) {



                                    if ($($(target).children('li')[i]).children('span').attr('deptid') != data.obj[i].deptId) {

                                        var targetnum = parseInt($(target).prev().attr('data-numtrue'))

                                        if (data.obj[i].deptName && data.obj[i].isHaveCh == 1) {
                                            str = '<li><span  onclick= "imgDown_s(' + data.obj[i].deptId + ',this)" ' +
                                                'data-numString="2" deptid="' + data.obj[i].deptId + '" ' +
                                                'data-numtrue="' + (targetnum + 1) + '"  ' +
                                                'style="padding-left:' +
                                                (20 + (20 * parseInt($(target).prev().attr('data-numtrue')))) + 'px;' +
                                                'height:35px;line-height:35px;"  deptid="' + data.obj[i].deptId + '" class="childdept">' +
                                                '<span></span><img id="img' + data.obj[i].deptId + '" src="/img/sys/dapt_right.png" ' +
                                                'style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" alt="">' +
                                                '&nbsp;<a href="javascript:void(0)" class="dynatree-title" ' +
                                                'title="' + data.obj[i].deptName + '">' + data.obj[i].deptName + '</a></span>' +
                                                '<ul style="display:none;"></ul></li>';
                                        } else {
                                            str = '<li>' +
                                                '<span onclick="imgDown_s(' + data.obj[i].deptId + ',this)" ' +
                                                'data-numString="1" deptid="' + data.obj[i].deptId + '" ' +
                                                'data-numtrue="' + (targetnum + 1) + '" ' +
                                                'style="padding-left:' + (20 + (20 *
                                                parseInt($(target).prev().attr('data-numtrue')))) + 'px;' +
                                                'height:35px;line-height:35px;"  deptid="' + data.obj[i].deptId + '" ' +
                                                'class="childdept"><span></span><img  src="/img/sys/dapt_right.png" ' +
                                                'style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" ' +
                                                'alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" ' +
                                                'title="' + data.obj[i].deptName + '">' + data.obj[i].deptName + '</a></span><ul ' +
                                                'style="display:none;"></ul></li>';
                                        }
                                        $(target).append(str)
                                    }
                                }
                                return false;
                            })
                        }
                        widthnum++
                        if (fn != undefined) {
                            fn();
                        }
                    }
                }
            })
        }
    })

    function imgDown_s(deptNum, me) {
        if ($(me).attr('data-types') == undefined) {
            $(me).find('img').attr('src', $(me).find('img').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
            if ($(me).find('img').attr('src') == '/img/sys/dapt_right.png') {
                $(me).find('img').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": ""});
                $(me).find('img').width(8);
                $(me).find('img').height(14);
                $(me).next().hide();
                // $(me).next().html('')
            } else if ($(me).find('img').attr('src') == '/img/sys/dapt_down.png') {
                $(me).find('img').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": "-5px"});
                $(me).find('img').width(14);
                $(me).find('img').height(9);
                $(me).next().show();
            }
        }
        else {
            $(me).find('img').attr('src', $(me).find('img').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
            if ($(me).find('img').attr('src') == '/img/sys/dapt_right.png') {
                $(me).find('img').width(8);
                $(me).find('img').height(14);
            } else if ($(me).find('img').attr('src') == '/img/sys/dapt_down.png') {
                $(me).find('img').width(14);
                $(me).find('img').height(9);
            }
            if ($(me).attr('data-types') == '1') {
                $(me).next().show();
                $(me).attr('data-types', '2')
            } else if ($(me).attr('data-types') == '2') {
                $(me).next().hide();
                $(me).attr('data-types', '1')
            }
        }
        show_users(deptNum);

        $('#btn').attr('data_id',deptNum);

        if ($(me).attr('data-numstring') == 1) {
            if (boolTwo) {
                if ($(me).next().css('display') == 'none') {
                    return;
                }
            } else {
                $.loadSidebar_dd($(me).next(), deptNum)
            }
        }
        if($(me).next().html()=='') {
            if (boolTwo) {
                if (departments) {
                    $.loadSidebar_dd($(me).next(), deptNum)
                }
            }

        }
        if ($(me).attr('data-numstring') == 2) {
            if (numstring) {
                $.loadSidebar_dd($(me).next(), deptNum)
            }
        }
    }



    function show_users(deptId) {
            var screenwidth = document.documentElement.clientWidth;
            // console.log(screenwidth*0.9)
            if (screenwidth  > 2000) {
                var nums = screenwidth * 0.97;
                var sumwidth = screenwidth * 0.97 + 'px';
            } else {
                var nums = 800;
                var sumwidth = '800px';
            }
            var width0 = nums * 0.045 + 'px';
            //表格数据初始化展示
            pageObj = $.tablePage('#pagediv',sumwidth, [
                {
                    width: width0,
                    title:'选择',
                    name:'checkbox',
                    selectFun:function (n,obj) {
                        return '<input type="checkbox"  name="checkbox"  userId="'+obj.userId+'" deptId="'+obj.deptId+'"/>'
                    }
                },
                {
                    width: width0,
                    title: 'OA用户姓名',
                    name: 'userName',
                },
                {
                    width: width0,
                    title: '角色',
                    name: 'userPrivName',
                },
            ], function (me) {
    //            me.data.pageSize = 10;
                me.data.deptId=deptId,
                me.init('/dingdingManage/dingdingGetUserList')
            })
            $(function () {
                var str = '<tr>' +
                    '<td style="width: 400px;text-align: left;"><input id="allCheckBox" type="checkbox" name="all"><label for="allCheckBox" style="color: black;cursor:pointer;display: inline-block;">' + notice_th_allchose + '</label></td>' +
                    '<td colspan="2" style="text-align: left">' +
                    '<a class="notice_notop span_btn"><span style="cursor:pointer;">导入</span></a>' +
                    '</td>' +
                    '</tr>';
                $('#operation').append(str);
                $('.notice_notop').click(function () {
                    var uid = new Array();
                    $("input[type=checkbox]:checked").each(function (index) {
                        var userId=$(this).attr('userId')
                        var deptId=$(this).attr('deptId')
                        uid.push(deptId+','+userId);
                    })
                    uid1=uid.join(';');
                    if (uid1== '') {
                        $.layerMsg({content: '请选择要导入的数据', icon: 0});
                    } else {
                        layer.confirm('是否确认导入', {
                            btn: [' <fmt:message  code="global.lang.ok"/>', ' <fmt:message  code="depatement.th.quxiao"/>'], //按钮
                            title: "导入人员"
                        }, function () {
                            $.ajax({
                                type: 'post',
                                url: '/dingding/userSynchro',
                                dataType: 'json',
                                data: {'synchroUsers': uid1},
                                success: function (data) {
                                    if(data.flag){
                                        layer.msg(data.msg, {icon: 1});
                                    } else {
                                        var msg = '导入失败';
                                        if(data.msg)
                                            msg = data.msg;
                                        layer.msg(msg, {icon: 2});
                                    }
//                                            window.location.reload();
                                }
                            })
                        }, function () {
                            layer.closeAll();
                        });
                    }
                });
            })
            $('#dbgz_page').css('display','none');
            $('#pagediv').on('click','[name="all"]',function(){//全选
                if($(this).is(':checked')){
                    $('#pageTbody').find('input[type=checkbox]').prop('checked',true)
                }else {
                    $('#pageTbody').find('input[type=checkbox]').removeProp('checked')
                }
            })

        }
</script>
</html>