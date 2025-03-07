<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<head>
    <title>同步部门</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../../css/common/style.css" />

    <!--[if lte IE 8]>
    <!--<script type="text/javascript" src="/static/js/ccorrect_btn.js"></script>-->
    <%--<![endif]-->--%>

    <script type="text/javascript" >
        var MYOA_JS_SERVER = "";
        var MYOA_STATIC_SERVER = "";
    </script>
</head>
<link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../../css/enterpriseManage/weixinqy.css">

<script src="../../lib/layer/layer.js?20201106"></script>
<script src="../../js/base/base.js"></script>
<body class="abody">

<div class="cont_left" id="cont_left">
    <ul>
        <li class="liDown dept_li" id="dept_lis"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_sectorList.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="部门列表"><fmt:message code="depatement.th.depa" /></li>
        <li class="pick" style="display: block;">
            <div class="pickCompany"><span style="height:35px;line-height:35px;" class="childdept"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 10px;margin-left: 13px;margin-bottom: 4px;"><a href="javascript:void(0)" class="dynatree-title" title=""></a></span></div>
        </li>
    </ul>
</div>

<div>
    <div class="sync-item" style="display: none;">
        <button id="btn-sync-dept" class="btn btn-small btn-primary" type="button">同步所有部门</button>
    </div>
    <div class="sync-tree">
        <div id="tree"></div>
        <%--<link rel="stylesheet" type="text/css" href="../../css/common/ui.dynatree.css">--%>
        <%--<script type="text/javascript" src="../../js/js_lang.js"></script>--%>
        <%--<script type="text/javascript" src="../../css/common/tree.js"></script>--%>

    </div>
</div>


<script type="text/javascript">

    loadSidebar1($('.pick'),0)
    function loadSidebar1(target,deptId,fn) {

        $.ajax({
            url: '/dingdingManage/dingdingGetDeptList',
            type: 'get',
            data: {
                deptId: deptId
            },
            dataType: 'json',
            success: function (data) {

                $(target).empty();
                var str = '';
                data.data.forEach(function (v, i) {
                    if (v.deptName) {
                        str += '<li><span  data-numtrue="1" ' +
                            'onclick= "imgDown1(' +v.deptId + ',this)"   data-numString="1"  style="height:35px;line-height:35px;padding-left: 14px" deptid="' + v.deptId + '" class="childdept" clickType="0"><span class=""></span>' +
                            '<img src="/img/sys/dapt_right.png" alt="" class="imgleft" style="width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;"><a href="javascript:void(0)" class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a></span><ul style="display:none;" class="dpetWhole0"></ul></li>';
                    }
                })

//                console.log("str="+str);

                target.append(str);

            }
        })
    }

    function imgDown1(deptNum, me) {
        ajaxdata1(deptNum, me);
        if ($(me).attr('data-types') == undefined) {
            $(me).find('img').attr('src', $(me).find('img').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
            if ($(me).find('img').attr('src') == '/img/sys/dapt_right.png') {
                $(me).find('img').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": ""});
                $(me).find('img').width(8);
                $(me).find('img').height(14);
                $(me).next().hide();
                 $(me).next().html('')
            } else if ($(me).find('img').attr('src') == '/img/sys/dapt_down.png') {
                $(me).find('img').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": "-5px"});
                $(me).find('img').width(14);
                $(me).find('img').height(9);
                $(me).next().show();
                $(me).next().html('')

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

//        if ($(me).attr('data-numstring') == 1) {
//            if (boolTwo) {
//                if ($(me).next().css('display') == 'none') {
//                    return;
//                }
//                $.loadrole($(me).next(), deptNum, $(me).attr('data-numtrue'));
//            } else {
                //$.loadSidebar($(me).next(), deptNum)
//            }
//        }
//        if($(me).next().html()=='') {
//            if (boolTwo) {
//                $.loadrole($(me).next(), deptNum, $(me).attr('data-numtrue'), function () {
//                    if (departments) {
//                        $.loadSidebar($(me).next(), deptNum)
//                    }
//                })
//            }
//
//        }
//        if ($(me).attr('data-numstring') == 2) {
//            if (numstring) {
//                $.loadSidebar($(me).next(), deptNum)
//            }
//        }

    }

    function ajaxdata1(id,me){

        $.ajax({
            url: '/dingdingManage/dingdingGetDeptList',
            type: 'get',
            data: {
                deptId: id
            },
            dataType: 'json',
            success: function (data) {

                var str1 = '';
                data.data.forEach(function (v, i) {
                    if (v.deptName) {
                        str1 += '<li><span  data-numtrue="1" ' +
                            'onclick= "imgDown1(' +v.deptId + ',this)"   data-numString="1"  style="height:35px;line-height:35px;padding-left: 14px" deptid="' + v.deptId + '" class="childdept" ><span class=""></span>' +
                            '<img src="/img/sys/dapt_right.png" alt="" class="imgleft" style="width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;"><a href="javascript:void(0)" class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a></span><ul style="display:none;" class="dpetWhole"></ul></li>';
                    }
                })

                $(me).next().append(str1);

            }
        })

    }

    //限制排序号只能输入三位有效数字
    var text = document.getElementById("deptNo_");
    text.onkeyup = function(){
        this.value=this.value.replace(/\D/g,'');
        if(text.value.length>3){
            text.value = deptNoShow;
        }
    }
</script>
</body>
</html>