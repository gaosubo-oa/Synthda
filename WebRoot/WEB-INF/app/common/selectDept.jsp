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
    <title><fmt:message code="common.th.SeleDepart"/></title><%--选择部门--%>
    <meta http-equiv="Content-Type" content="text/html; charset=gbk"/>
    <%--    <meta name="renderer" content="webkit">--%>
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/common/style.css"/>
    <link rel="stylesheet" type="text/css" href="../css/common/select.css"/>
    <!-- 	<link rel="stylesheet" type="text/css" href="../css/common/ui.dynatree.css"> -->
    <link rel="stylesheet" type="text/css" href="../css/common/org_select.css">
    <link rel="stylesheet" type="text/css" href="../lib/easyui/themes/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/easyui/themes/icon.css"/>
    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>
    <script src="/js/base/base.js"></script>
    <script type="text/javascript" src="../lib/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../lib/easyui/tree.js"></script>

</head>
<style>
    #dept_menu {
        overflow-x: auto;
    }

    .left_choose ul li div, .left_choose ul li h1, .left_choose ul img {
        float: left;
    }

    .left_choose ul img {
    <!-- margin-top: 8 px;
    -->
    }

    .left_choose ul li {
        width: 80%;
        height: 20px;
    <!-- background: red;
    --> margin-top: 10px;
    }

    .mar {
        margin-left: 10%;
    }

    .name li {
        list-style-type: none;
    }

    .choose {
        background: #D6E4EF !important;
    }

    .tree-folder {
        background: none;
        width: 0;
    }

    #block-right-all-dept {
        /*display: none!important;*/
    }

    /*div.main-block div.right div.block-right div.block-right-item{*/
    /*text-align: left;*/
    /*}*/
    /*div.main-block div.right div.block-right div.active span.name{*/
    /*background: url(../../img/common/dropdown_menu_checked.png) 20px center no-repeat;*/
    /*}*/
    div.main-block div.right div.block-right div.active span.name {
        background: none;
    !important;
    }

    div.main-block div.right div.block-right div.active {
        background: url('/ui/img/common/dropdown_menu_checked.png') 5px center no-repeat;
    !important;
        background-color: #dae9bb;
    }

    div.main-block div.right div.block-right div.active :hover {
        background-color: #dae9bb;
    !important;
    }
</style>
<body>
<!-- //开始 -->
<!-- //头部 -->

<div id="north">
    <div id="navMenu" style="width:auto;">
        <a href="#" title='<fmt:message code="common.th.selPerson" />' class="tab_btn" block="selected"
           hidefocus="hidefocus"><span><fmt:message code="common.th.selected"/></span></a><%--已选人员  已选--%>
        <a href="#" title='<fmt:message code="common.th.selByDepart" />' block="dept" hidefocus="hidefocus"
           class=" tab_btn active"><span><fmt:message code="userManagement.th.department"/></span></a><%--按部门选择   部门--%>

        <a href="#" block="query" class="tab_btn" hidefocus="hidefocus" style="display:none;"><span><fmt:message
                code="workflow.th.sousuo"/></span></a><%--搜索--%>
    </div>
    <div id="navRight" style="float:right;">
        <div class="search">
            <div class="search-body">
                <div class="search-input"><input notlogin_flag="" id="keyword" type="text" value=""></div>
                <div id="search_clear" class="search-clear" style="display:none;"></div>
            </div>
        </div>
    </div>
</div>

<!-- //内容 -->
<div>
    <div class="main-block" id="deptBox" style="display:block;">
        <div class="left moduleContainer" id="dept_menu">
            <div class="tree">
                <div class="pickCompany">
                    <span class="childdept" style="display: none;">
                        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt=""
                             style="vertical-align: middle;width: 15px;margin-right: 5px;margin-left: 5px;margin-bottom: 4px;">
                        <a href="javascript:void(0)" class="dynatree-title" id="companyName" title=""></a>
                    </span>
                </div>
                <ul class="dynatree-container dynatree-no-connector" style="margin-left: 10px;" id="deptOrg">
                </ul>
            </div>

        </div>
        <div class="right" id="dept_item">
            <div class="block-right" id="dept_item_2">
                <!-- 部门名 -->
                <div class="block-right-header" title="" id="block-right-header"></div>
                <div id="block-right-all-dept" deptname="全体部门" deptId="ALL_DEPT" title="全体部门"
                     style="display: none;" class="block-right-remove">
                    <span class="name" style="display: block">全体部门</span>
                </div>
                <div id="block-right-add" class="block-right-add"><fmt:message code="meet.th.addAll"/></div>
                <%--全部添加--%>
                <div id="block-right-remove" class="block-right-remove"><fmt:message code="meet.th.DeleteAll"/></div>
                <%--全部删除--%>

                <div class="userItem">

                </div>
            </div>
        </div>
    </div>
    <!-- 已选 -->
    <div class="main-block" id="selectedDox">
        <div class="left moduleContainer" id="dept_menu">
            <div class="tree">
                <ul class="dynatree-container dynatree-no-connector" id="deptOrg">
                </ul>
            </div>

        </div>
        <div class="right" id="dept_item">
            <div class="block-right" id="dept_item_2">
                <!-- 部门名 -->
                <div id="block-right-remove" class="block-right-remove"><fmt:message code="meet.th.DeleteAll"/></div>
                <%--全部删除--%>

                <div class="userItem">
                </div>
            </div>
        </div>
    </div>


</div>
<!-- //结束 -->
<div id="south">
    <input type="button" class="BigButtonA" value='<fmt:message code="global.lang.ok" />' onclick="close_window();">&nbsp;&nbsp;<%--确定--%>
</div>
</body>
<script>
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
            if(res.object.length!=0){
                var data=res.object[0]
                if (data.paraValue!=0){
                    $('.BigButtonA').before('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 12pt;position: absolute;left: 20px;"> 机密级★ </span>')
                }
            }
        }
    })
    var classDept = '';
    if (parent.opener && parent.opener.classDept) {
        //选择分级机构下部门
        classDept = parent.opener.classDept;
        $('#navRight').hide();
    } else if (parent && parent.classDept) {
        //选择分级机构下部门
        classDept = parent.classDept;
        $('#navRight').hide();
    }
    paraValue = "";
    var searchPara = "";
    var indexflag = false;
    $.ajax({
        type: 'get',
        url: '/syspara/queryOrgScope?moduleId='+moduleId,
        dataType: 'json',
        success: function (reg) {
            var item = reg.object;
            if (item.paraValue == 1) {
                paraValue = 1;
            }
        }
    })
    if (parent.opener && parent.opener.moduleId) {
        var moduleId = parent.opener.moduleId;
    } else {
        var moduleId = '';
    }
    var allType = GetQueryString('allType') || '';
    var dataAll = GetQueryString('allDept');
    var eduOrg = GetQueryString('eduOrg');
    var allDeptSingle = GetQueryString('allDeptSingle'); // 单选 但是可以选择全体部门
    if (eduOrg == '1' || eduOrg == '2' || eduOrg == '3') {
        var urlType = location.href.substring(location.href.indexOf('?') + 1, location.href.indexOf('&'));
    } else {
        if (location.href.split('?')[1] != undefined) {
            var urlType = location.href.split('?')[1].indexOf(0) == 0 ? 0 : location.href.split('?')[1];
        }
    }
    if (dataAll == '1') {
        $('#block-right-all-dept').show();
    } else {
        $('#block-right-all-dept').hide();
    }
    if (urlType == 0) {
        $('#block-right-header').hide()
        $('#block-right-add').hide()
        $('#block-right-remove').hide()
    }
    if (allDeptSingle == '1') {
        $('#block-right-all-dept').show();
    }

    function close_window() {
        var itemsArr = $('#selectedDox .userItem .active');

        if (eduOrg == '1' || eduOrg == '2' || eduOrg == '3') {
            var itemnum = location.href.substring(location.href.indexOf('?') + 1, location.href.indexOf('&'));
        } else {
            var itemnum = location.href.split('?')[1]
        }
        if (itemnum == 0) {
            if (selectDeptData.length > 1) {
                layer.msg('<fmt:message code="common.th.onlyChooseOne" />', {icon: 5});
                <%--alert('<fmt:message code="common.th.onlyChooseOne" />')/*只能选择一个*/--%>
                return
            }
        }
        var selectItemsId = '';
        var selectItemsName = '';
        var selectdeptNo = '';
        // for(var i=0;i<itemsArr.length;i++){
        //     var obj = itemsArr.eq(i);
        //     selectItemsId+=(obj.attr("deptId")+',');
        //     selectItemsName+=(obj.attr("deptName")+',');
        //     selectdeptNo+=(obj.attr("deptNo")+',');
        // };
        for (var i = 0; i < selectDeptData.length; i++) {
            selectItemsId += selectDeptData[i].deptId + ','
            selectItemsName += selectDeptData[i].deptName + ','
            selectdeptNo += selectDeptData[i].deptNo + ','
        }
        if ($('#block-right-all-dept').hasClass('active')) {
            selectItemsName = '全体部门';
            selectItemsId = 'ALL_DEPT';
            selectdeptNo = '';
        }
        if (parent.opener && parent.opener.dept_id) {
            parent.opener.document.getElementById(parent.opener.dept_id).value = selectItemsName;
            parent.opener.document.getElementById(parent.opener.dept_id).setAttribute('deptname', selectItemsName);
            parent.opener.document.getElementById(parent.opener.dept_id).setAttribute('deptId', selectItemsId);
        } else {
            parentObj.val(selectItemsName);
            parentObj.attr('deptname', selectItemsName);
            parentObj.attr('deptId', selectItemsId);
        }
        if (parent.opener) {
            if (typeof parent.opener.cbCallBack == 'function') {
                parent.opener.cbCallBack(selectItemsId)
            }
            //针对中电建，组织机构导入
            if (parent.opener.importLeft) {
                parent.opener.importLeft(selectItemsId)
            }
            if (eduOrg == '1') {
                if (parent.opener.selectParent) {
                    parent.opener.selectParent(selectItemsId, 1)
                }
            }

        }

        window.close();
        parent.layer.closeAll();
    }

    var initTree;
    var isAll = true; // 是否全部部门数据
    var selectDeptData = []; // 选中部门的数据

    var dep_id = '';
    var deptname = '';
    var parentObj = '';

    if (parent.opener && parent.opener.dept_id) {
        dep_id = parent.opener.document.getElementById(parent.opener.dept_id).getAttribute('deptId');
        deptname = parent.opener.document.getElementById(parent.opener.dept_id).value;
    } else {
        dep_id = parent.$("#" + parent.dept_id).attr('deptId');
        deptname = parent.$("#" + parent.dept_id).val();
        parentObj = parent.$("#" + parent.dept_id);
    }

    $(function () {
        buildDefaultItem();
        var numIndex = 0;

        function buildDefaultItem() {
            var arr = ''
            if (dep_id && deptname) {
                dep_id = dep_id.split(',');
                deptname = deptname.split(',');
//                deptno =deptno.split(',');

                for (var i = 0; i < dep_id.length; i++) {
                    if (dep_id[i]) {
//                        arr+='<div class="block-right-item active" deptNo="'+deptno[i]+'" deptName="'+deptname[i]+'" id="'+dep_id[i]+'" deptId="'+dep_id[i]+'" title="'+deptname[i]+'"><span class="name">'+deptname[i]+'<span class="status"></span></span></div>';
                        arr += '<div class="block-right-item active" deptName="' + deptname[i] + '" id="' + dep_id[i] + '" deptId="' + dep_id[i] + '" title="' + deptname[i] + '"><span class="name">' + deptname[i] + '<span class="status"></span></span></div>';
                    }
                }
                $('#selectedDox .userItem').append(arr);
            }
        };
        if (dep_id == 'ALL_DEPT') {
            $('#block-right-all-dept').addClass('active');
        } else {
            $("#block-right-all-dept").removeClass('active');
        }
        // 点击全体部门
        $('#block-right-all-dept').click(function () {
            var that = $(this);
            if ($(this).hasClass('active')) {
                $(this).removeClass('active');
                $('#selectedDox').find('#ALL_DEPT').remove();
                $('#selectedDox').find('#block-right-all-dept').remove();
            } else {
                $(this).addClass('active');
                var divObj = $(that.prop("outerHTML"));

                if ($('#selectedDox .userItem #' + that.attr('deptId')).length < 1) {
                    $('#selectedDox .userItem').append(divObj);
                } else {
                    $('#selectedDox .userItem').append('');
                }
            }

            $('#block-right-remove').trigger('click')
        })


        var globalIndex = 0;
        initTree = function () {
            if (urlType != 0) {
                $('#block-right-header').show()
                $('#block-right-add').show()
                $('#block-right-remove').show()
            }

            var url = '';
            if (classDept && allType == '') {
                url = '/hierarchical/getClassifyOrgByAdmin';
            } else {
                if (paraValue == "") {
                    url = '../department/getChDeptfq?deptId=0&allType=' + allType + '&moduleId=' + moduleId + '&resultFlag=simple'
                } else {
                    url = '../getUserOrg?moduleId='+moduleId
                }
            }
            $('#deptOrg').tree({
                url: url,
                animate: true,
                checkbox: true,
                code: $("#deptOrg span[class^='tree-icon tree-file']").remove(),
                loadFilter: function (node) {
                    if (node.obj && node.obj.length > 0) {
                        for (var i = 0; i < node.obj.length; i++) {
                            searchPara += node.obj[i].deptNo + ','
                        }
                    }

                    return convert(node.obj);
                },
                onDblClick: function (node) {

                },
                onLoadSuccess: function (node, data) {
                    // 判断是否开启了分支机构
                    if (paraValue == 1) {
                        // 调用为分支机构添加图片标识方法
                        diguiAddClassifyOrgImg(data);
                    }
                },
                onClick: function (node) {
                    if (isAll) {
                        selectDeptData = []
                    }
                    $('#block-right-all-dept').hide();
                    var opt_li_dep = '';
                    departmentAjax(node.id, function (departmentData) {
                        opt_li_dep = departmentChild(departmentData, opt_li_dep, 0, -1);
                        $('#deptBox .userItem').html(opt_li_dep);
                        if (node.checked) {
                            $('#deptBox .userItem').find('.block-right-item').click();
                        } else {
                            if (selectDeptData.length > 0) {
                                for (var i = 1; i < selectDeptData.length; i++) {
                                    for (var y = 0; y < $('#deptBox .userItem').find('.block-right-item').length; y++) {
                                        if (selectDeptData[i].deptId == $('#deptBox .userItem').find('.block-right-item').eq(y).attr("id")) {
                                            $('#deptBox .userItem').find('.block-right-item').eq(y).click();
                                        }
                                    }
                                }
                            }
                        }
                    });
                    $(this).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
                    node.state = node.state === 'closed' ? 'open' : 'closed';
                },
                onCheck: function (node, checked) {
                    if (isAll) {
                        selectDeptData = []
                    }
                    isAll = false
                    indexflag = true;
                    //添加部门
                    $('#block-right-all-dept').hide();
                    if (checked) {
                        var clickstatus = true;
                        $.ajax({
                            type: 'get',
                            url: '/department/getAllChildDept?deptId=' + node.id + '&moduleId='+moduleId,
                            dataType: 'json',
                            success: function (res) {
                                ss = res.obj1
                                var opt_li_dep = '<div class="block-right-item " deptNo="' + ss.deptId + '" deptName="' + ss.deptName + '" id="' + ss.deptId + '" deptId="' + ss.deptId + '" title="' + ss.deptName + '" deptParent="' + ss.deptParent + '"><span class="name" style="">' + ss.deptName + '<span class="status"></span></span></div>';
                                departmentAjax(node.id, function (departmentData) {
                                    opt_li_dep = departmentChildCheckboxNo(departmentData, opt_li_dep, 0, -1, '1');
                                    $('#deptBox .userItem').html(opt_li_dep);
                                    $('#deptBox .userItem').find('.block-right-item').click();
                                }, checked, clickstatus);
                            }
                        })
                    } else {
                        var opt_li_dep = '';
                        departmentAjax(node.id, function (departmentData) {
                            opt_li_dep = departmentChildCheckboxNo(departmentData, opt_li_dep, 0, -1, '0');
                            $('#deptBox .userItem').html(opt_li_dep);
                            $('#deptBox .userItem').find('.block-right-item').click();
                        }, checked);
                    }
                },
                onBeforeExpand: function (node, param) {
                    pareValue = "";
                    $('#deptOrg').tree('options').url = "../department/getChDeptfq?deptId=" + node.id + '&allType=' + allType + '&moduleId=' + moduleId + '&resultFlag=simple';// change the url
                    // .tree的click事件已经请求过，为啥还要再请求一模一样的接口一遍，这样很影响性能，如果是因为bug那就在上次请求的时候解决问题，也不应该再次请求，不理解先注释
                    // var opt_li_dep='';
                    // departmentAjax(node.id,function (departmentData) {
                    //     opt_li_dep=  departmentChild(departmentData,opt_li_dep,0,-1);
                    //     $('#deptBox .userItem').html(opt_li_dep);
                    // });
                },
            });
        };
        $.ajax({
            url: '../sys/showUnitManage',
            type: 'get',
            dataType: 'json',
            success: function (obj) {
                $('#companyName').html(obj.object.unitName);
                $('.childdept').show();
                initTree();
            }
        });
        initdata();

        $('.childdept').click(function () {
            isAll = true
            initdata();
            $('#block-right-all-dept').show();
        })

        function initdata() {
            var loading = layer.load(2)
            $.ajax({
                type: 'get',
                url: '/syspara/queryOrgScope',
                dataType: 'json',
                success: function (reg) {
                    layer.close(loading)
                    var item = reg.object;
                    if (item.paraValue == 1) {
                        paraValue = 1;
                    }

                    if (classDept && allType == '') {
                        var url = '/hierarchical/getClassifyOrgByAdmin';
                    } else {
                        if (paraValue == "") {
                            var loading = layer.load(2)
                            //显示部门下的子部门
                            $.ajax({
                                type: 'post',
                                url: '/department/getAlldept' + '?resultFlag=simple&pageSize=500&moduleId=' + moduleId,
                                dataType: 'json',
                                success: function (res) {
                                    layer.close(loading)
                                    var data = res.obj;
                                    var opt_li = ""
                                    departmentData = digui(data, 0);
                                    var str = departmentChild(departmentData, opt_li, 0, -1);
                                    $('#deptBox .userItem').html(str);
                                }
                            })
                        } else {
                            var url = '../getUserOrg?moduleId='+moduleId
                        }
                    }
                    var loading = layer.load(2)
                    $.ajax({
                        type: 'post',
                        url: url,
                        dataType: 'json',
                        success: function (res) {
                            layer.close(loading)
                            var data = res.obj;
                            // var data=res.obj;
                            var str = '';
                            if (res.flag && data.length > 0) {
                                $('#block-right-header').show()
                                $('#block-right-add').show()
                                $('#block-right-remove').show()
                                for (var j = 0; j < data.length; j++) {
                                    str += '<div class="block-right-item ' + function () {
                                        if (dep_id) {
                                            var user_idArr;
                                            if (Array.isArray(dep_id)) {
                                                user_idArr = dep_id;
                                            } else {
                                                user_idArr = dep_id.split(',');
                                            }

                                            var bool = false;
                                            for (var i = 0; i < user_idArr.length; i++) {
                                                if (data[j].deptId == user_idArr[i]) {
                                                    bool = true;
                                                    break;
                                                }
                                            }
                                            if (bool) {
                                                return 'active';
                                            } else {
                                                return ''
                                            }
                                        } else {
                                            return ''
                                        }
                                    }() + '" deptNo="' + data[j].deptNo + '" deptName="' + data[j].deptName + '" id="' + data[j].deptId + '" deptId="' + data[j].deptId + '" title="' + data[j].deptName + '" deptParent="' + data[j].deptParent + '"><span class="name">' + data[j].deptName + '<span class="status"></span></span></div>';

                                }
                                $('#deptBox .userItem').html(str);
                            }
                        }
                    })
                }
            })
        }

        function TreeNode(id, text, state, children) {
            this.id = id;
            this.text = text;
            this.state = state;
            this.children = children;
        }

        function convert(data) {
            var arr = [];
            // data.forEach(function(v,i){
            //     if(v.deptId){
            //         var node = new TreeNode(v.deptId,v.deptName,"closed",v.child)
            //         arr.push(node);
            //     }
            // });
            if (data && data.length) {
                arr = clearData(data)
            }
            return arr;
        }

        function clearData(list) {
            var arr = [];
            for (var i = 0; i < list.length; i++) {
                var obj = {
                    id: list[i].deptId,
                    text: list[i].deptName,
                    classifyOrg: list[i].classifyOrg,
                    state: "closed"
                };
                if (list[i].child && list[i].child.length) {
                    obj.children = clearData(list[i].child)
                }
                children = list[i].child
                arr.push(obj)
            }
            return arr
        }

        //组织
        $('.tab_btn').click(function () {
            var type = $(this).attr('block');
            $(this).addClass("active").siblings().removeClass('active');
            switch (type) {
                case "selected":
                    $('#selectedDox').show().siblings().hide();
                    break;
                case "dept":
                    $('#deptBox').show().siblings().hide();
                    break;
                case "priv":

                    break;
                case "group":

                    break;
                case "query":

                    break;
            }
        });

        //部门遍历方法
        function departmentChild(datas, opt_li, level, dept) {
            for (var i = 0; i < datas.length; i++) {
                var String = "";
                var space = ""
                for (var j = 0; j < level; j++) {
                    space += "├&nbsp;&nbsp;&nbsp;";
                }
                if (i == 0) {
                    String = space + "┌";
                } else if (i != 0) {
                    String = space + "├";
                } else if (i == datas.length - 1) {
                    String = space + "└";
                }
                if (dept == datas[i].deptId) {
                    opt_li += '<div class="block-right-item ' + function () {
                        if (dep_id) {
                            var user_idArr;
                            if (Array.isArray(dep_id)) {
                                user_idArr = dep_id;
                            } else {
                                user_idArr = dep_id.split(',');
                            }

                            var bool = false;
                            for (var j = 0; j < user_idArr.length; j++) {
                                if (datas[i].deptId == user_idArr[j]) {
                                    bool = true;
                                    break;
                                }
                            }
                            if (bool) {
                                return 'active';
                            } else {
                                return ''
                            }
                        } else {
                            return ''
                        }
                    }() + '" deptNo="' + datas[i].deptNo + '" deptName="' + datas[i].deptName + '" id="' + datas[i].deptId + '" deptId="' + datas[i].deptId + '" title="' + datas[i].deptName + '" deptParent="' + datas[i].deptParent + '"><div style="width: 10%;margin-left: 43.5%;text-align: left"><span class="name" style="">' + String + datas[i].deptName + '<span class="status"></span></span></div></div>';
                } else {
                    opt_li += '<div class="block-right-item ' + function () {
                        if (dep_id) {
                            var user_idArr;
                            if (Array.isArray(dep_id)) {
                                user_idArr = dep_id;
                            } else {
                                user_idArr = dep_id.split(',');
                            }

                            var bool = false;
                            for (var j = 0; j < user_idArr.length; j++) {
                                if (datas[i].deptId == user_idArr[j]) {
                                    bool = true;
                                    break;
                                }
                            }
                            if (bool) {
                                return 'active';
                            } else {
                                return ''
                            }
                        } else {
                            return ''
                        }
                    }() + '" deptNo="' + datas[i].deptNo + '" deptName="' + datas[i].deptName + '" id="' + datas[i].deptId + '" deptId="' + datas[i].deptId + '" title="' + datas[i].deptName + '" deptParent="' + datas[i].deptParent + '"><div style="width: 10%;margin-left: 43.5%;text-align: left"><span class="name" style="">' + String + datas[i].deptName + '<span class="status"></span></span></div></div>';
                }
                if (datas[i].childs != null) {
                    opt_li = departmentChild(datas[i].childs, opt_li, level + 1, dept);
                }
            }
            return opt_li;
        }

        //        点击复选框
        function departmentChildCheckboxNo(datas, opt_li, level, dept, checked) {
            for (var i = 0; i < datas.length; i++) {
                var String = "";
                var space = ""
                for (var j = 0; j < level; j++) {
                    space += "├&nbsp;&nbsp;&nbsp;";
                }
                if (i == 0) {
                    String = space + "┌";
                } else if (i != 0) {
                    String = space + "├";
                } else if (i == datas.length - 1) {
                    String = space + "└";
                }
                if (checked == '1') {
                    opt_li += '<div class="block-right-item" deptNo="' + datas[i].deptNo + '" deptName="' + datas[i].deptName + '" id="' + datas[i].deptId + '" deptId="' + datas[i].deptId + '" title="' + datas[i].deptName + '" deptParent="' + datas[i].deptParent + '"><span class="name" style="">' + String + datas[i].deptName + '<span class="status"></span></span></div>';
                } else {
                    opt_li += '<div class="block-right-item active" deptNo="' + datas[i].deptNo + '" deptName="' + datas[i].deptName + '" id="' + datas[i].deptId + '" deptId="' + datas[i].deptId + '" title="' + datas[i].deptName + '" deptParent="' + datas[i].deptParent + '"><span class="name" style="">' + String + datas[i].deptName + '<span class="status"></span></span></div>';
                }

                if (datas[i].childs != null) {
                    opt_li = departmentChildCheckboxNo(datas[i].childs, opt_li, level + 1, dept, checked);
                }
            }
            return opt_li;
        }


        //部门遍历接口
        function departmentAjax(id, callback, checked, clickstatus) {
            $.ajax({
                url: '/department/getAllChildDept?deptId=' + id,
                type: 'get',
                dataType: 'json',
                success: function (obj) {
                    var data = obj.obj;
                    var datas1 = obj.obj1;
                    var str = '';
                    if (data.length > 0) {
                        $('#block-right-header').show()
                        $('#block-right-add').show()
//                        $('#block-right-all-dept').show()
                        $('#block-right-remove').show()
                        var departmentData = digui(data, id);
                        if (clickstatus != true) {
                            departmentData.unshift(datas1)
                        }
                        callback(departmentData);
                    } else if (indexflag) {
                        $('#block-right-header').show()
                        $('#block-right-add').show()
                        $('#block-right-remove').show()
                        if (checked) {
                            var active = '';
                        } else {
                            var active = 'active';
                        }
                        var strbox = '<div class="block-right-item ' + active + '" deptNo="' + ss.deptId + '" deptName="' + ss.deptName + '" id="' + ss.deptId + '" deptId="' + ss.deptId + '" title="' + ss.deptName + '" deptParent="' + ss.deptParent + '"><span class="name" style="">' + ss.deptName + '<span class="status"></span></span></div>';
                        $('#deptBox .userItem').html(strbox);
                        $('#deptBox .userItem').find('.block-right-item').click();
                        indexflag = false;

                    } else {
                        $('#block-right-header').hide()
                        $('#block-right-add').hide()
                        $('#block-right-remove').hide()
                        str = '<div style="width: 230px;height: 200px;margin: 20px auto;text-align: center">' +
                            '<img src="/img/common/dianjikong.png" style="margin-top: 20px;" alt="">\
                            <span style="width: 100%;display: inline-block;margin-top: 10px;\
                        font-size: 15px;\
                        font-weight: bold;">本部门下暂无下级部门</span>' +
                            '</div>';
                        $('#deptBox .userItem').html(str);
                    }

                }
            });
        }

        function digui(datas, departId) {
            var data = new Array();
            for (var i = 0; i < datas.length; i++) {
                if (datas[i].deptParent == departId) {
                    datas[i]["childs"] = digui(datas, datas[i].deptId);
                    data.push(datas[i]);
                }
            }
            return data;
        }

        function build(id) {
            $.ajax({
                url: '../department/getAllChildDept?deptId=' + id,
                type: 'get',
                dataType: 'json',
                success: function (obj) {
                    if (obj.flag) {
                        var data = obj.obj;
                        var datas = obj.obj1
                        var tr = '';
                        var num = 0;
                        if (urlType != 0) {
                            $('#block-right-header').show()
                            $('#block-right-add').show()
                            $('#block-right-remove').show()
                        }


                        $('#block-right-all-dept').hide()
                        data.forEach(function (v, i) {
                            if (v.deptId) {

                                tr += '<div class="block-right-item ' + function () {
                                    if (dep_id) {
                                        var user_idArr;
                                        if (Array.isArray(dep_id)) {
                                            user_idArr = dep_id;
                                        } else {
                                            user_idArr = dep_id.split(',');
                                        }

                                        var bool = false;
                                        for (var i = 0; i < user_idArr.length; i++) {
                                            if (v.deptId == user_idArr[i]) {
                                                bool = true;
                                                break;
                                            }
                                        }
                                        if (bool) {
                                            return 'active';
                                        } else {
                                            return ''
                                        }
                                    } else {
                                        return ''
                                    }
                                }() + '" deptNo="' + v.deptNo + '" deptName="' + v.deptName + '" id="' + v.deptId + '" deptId="' + v.deptId + '" title="' + v.deptName + '" deptParent="' + v.deptParent + '"><span class="name">' + v.deptName + '<span class="status"></span></span></div>';
                            } else {
                                num++;
                            }
                        });
                        if (data.length == num) {
                            $('#block-right-header').hide()
                            $('#block-right-add').hide()
                            $('#block-right-all-dept').hide()
                            $('#block-right-remove').hide()
                            tr = '<div style="width: 230px;height: 200px;margin: 20px auto;text-align: center">' +
                                '<img src="/img/common/dianjikong.png" style="margin-top: 20px;" alt="">\
                                <span style="width: 100%;display: inline-block;margin-top: 10px;\
                            font-size: 15px;\
                            font-weight: bold;">本部门下暂无下级部门</span>' +
                                '</div>'
                        }

                        $('#deptBox .userItem').html(tr);

                    }
                }
            });
        }

        // 部门行点击事件
        $('#dept_item').on("click", ".block-right-item", function () {
            var that = $(this);
            $('#block-right-all-dept').removeClass('active')
            $('#selectedDox').find('#ALL_DEPT').remove();
            $('#selectedDox').find('#block-right-all-dept').remove();
            if (that.attr('class').indexOf('active') > 0) {
                that.removeClass("active");
                var index = 0;
                if ($('#selectedDox .userItem #' + that.attr('deptId')).length > 0) {
                    $('#selectedDox .userItem #' + that.attr('deptId')).remove();
                }

                var itemsArr = $('#selectedDox .userItem .active');
                selectDeptData = []
                for (var i = 0; i < itemsArr.length; i++) {
                    var obj = itemsArr.eq(i);
                    selectDeptData.push({
                        deptId: obj.attr("deptId"),
                        deptName: obj.attr("deptName"),
                        deptNo: obj.attr("deptNo")
                    })
                }
                ;
            } else {
                var divObj = $(that.prop("outerHTML"));
                divObj.addClass("active");
                that.addClass("active");

                selectDeptData.push({
                    deptId: $(that).attr('deptId'),
                    deptName: $(that).attr('deptName')
                })


                if ($('#selectedDox .userItem #' + that.attr('deptId')).length < 1) {
                    $('#selectedDox .userItem').append(divObj);
                }
                if (urlType == 0) {
                    that.siblings('div').removeClass('active')
                    $('#selectedDox .userItem').empty()
                    $('#selectedDox .userItem').append(divObj);
                }

                var itemsArr = $('#selectedDox .userItem .active');
                selectDeptData = []
                for (var i = 0; i < itemsArr.length; i++) {
                    var obj = itemsArr.eq(i);
                    selectDeptData.push({
                        deptId: obj.attr("deptId"),
                        deptName: obj.attr("deptName"),
                        deptNo: obj.attr("deptNo")
                    })
                }
                ;
            }
        });

        $('#selectedDox #block-right-remove').on('click', function () {
            $('#selectedDox .userItem .block-right-item').each(function () {
                if ($('#deptBox .userItem #' + $(this).attr('deptid')).length > 0) {
                    $('#deptBox .userItem #' + $(this).attr('deptid')).removeClass('active');
                }
            });
            $('#selectedDox .userItem .block-right-item').remove();
        });

        $('#selectedDox .userItem ').on('click', '.block-right-item', function () {
            $('#deptBox .userItem #' + $(this).attr('deptid')).removeClass('active');
            $(this).remove();
        });

        // 全部添加
        $('#deptBox #block-right-add').on('click', function () {
            if (isAll) {
                var loading = layer.load(2)
                //显示部门下的子部门
                $.ajax({
                    type: 'post',
                    url: '/department/getAlldept' + '?resultFlag=simple&moduleId=' + moduleId + '',
                    dataType: 'json',
                    success: function (res) {
                        var data = res.obj;
                        var opt_li = ""
                        // departmentData = digui(data, 0);
                        // var str = departmentChild(departmentData, opt_li, 0, -1);
                        // $('#deptBox .userItem').html(str);
                        selectDeptData = []
                        for (var i = 0; i < data.length; i++) {
                            selectDeptData.push({
                                deptId: data[i].deptId,
                                deptName: data[i].deptName,
                                deptNo: data[i].deptNo
                            })
                        }
                        $('#deptBox .userItem .block-right-item').addClass('active');
                        layer.close(loading)
                    }
                })
            } else {
                $('#block-right-all-dept').removeClass('active')
                $('#deptBox .userItem .block-right-item').addClass('active');
                $('#selectedDox').find('#ALL_DEPT').remove();
                $('#selectedDox').find('#block-right-all-dept').remove();
                var str = '';
                $('#deptBox .userItem .active').each(function (i, v) {
                    if ($('#selectedDox .userItem #' + $(this).attr('deptid')).length < 1) {
                        str += $(this).prop("outerHTML");
                    }
                });
                $('#selectedDox .userItem').append(str);
            }

        });

        // 全部删除
        $('#deptBox #block-right-remove').on('click', function () {
            $('#deptBox .userItem .active').each(function (i, v) {

                if ($('#selectedDox .userItem #' + $(this).attr('deptid')).length > 0) {

                    $('#selectedDox .userItem #' + $(this).attr('deptid')).remove();
                }
            });
            $('#deptBox .userItem .block-right-item').removeClass('active')
            // var itemsArr = $('#selectedDox .userItem .active');
            selectDeptData = []
            // for(var i=0;i<itemsArr.length;i++){
            //     var obj = itemsArr.eq(i);
            //     selectDeptData.push({
            //         deptId:obj.attr("deptId"),
            //         deptName:obj.attr("deptName"),
            //         deptNo:obj.attr("deptNo")
            //     })
            // };
        });

        $('.tree .dynatree-container').on('click', '.childdept', function () {
            var that = $(this);
            getChDept(that.next(), that.attr('deptid'));
            var title = that.find('a').text();
            $('.block-right-header').html(title);
        });

        $('.block-right').on('mouseover', 'div', function () {
            $(this).addClass('hover');
        });
        $('.block-right').on('mouseout', 'div', function () {
            $(this).removeClass('hover');
        });

        //搜索
        $('#keyword').bind('input propertychange', function () {
            var text = encodeURI($(this).val());
            if (text != '') {
                throttle(autodivheights, text);
            } else {
                $('#deptBox .userItem').html('');
            }
        });

    });

    function throttle(method, text) {
        clearTimeout(method.tId);
        method.tId = setTimeout(function () {
            method.call(method, text);
        }, 500);
    }

    function autodivheights(text) {
        if (paraValue == "") {
            var url = "../department/selByLikeDeptName?deptName=" + text
        } else {
            var url = "../department/selByLikeDeptNameAndDeptNo?deptName=" + text + "&deptNo=" + searchPara
        }
        $.ajax({
            type: "get",
            //url: "../department/selByLikeDeptName?deptName=" + text,
            url: url,
            dataType: 'JSON',
            success: function (res) {
                if (res.flag) {
                    var data = res.obj;
                    var tr = '';
                    $('#block-right-header').show()
                    $('#block-right-add').show()
                    $('#block-right-remove').show()
                    $('#block-right-all-dept').hide()
                    data.forEach(function (v, i) {
                        if (v.deptId) {
                            tr += '<div class="block-right-item ' + function () {
                                if (dep_id) {
                                    var user_idArr;
                                    if (Array.isArray(dep_id)) {
                                        user_idArr = dep_id;
                                    } else {
                                        user_idArr = dep_id.split(',');
                                    }

                                    var bool = false;
                                    for (var i = 0; i < user_idArr.length; i++) {
                                        if (v.deptId == user_idArr[i]) {
                                            bool = true;
                                            break;
                                        }
                                    }
                                    if (bool) {
                                        return 'active';
                                    } else {
                                        return ''
                                    }
                                } else {
                                    return ''
                                }
                            }() + '" deptNo="' + v.deptNo + '" deptName="' + v.deptName + '" id="' + v.deptId + '" deptId="' + v.deptId + '" title="' + v.deptName + '" deptParent="' + v.deptParent + '"><span class="name">' + v.deptName + '<span class="status"></span></span></div>';
                        }
                    });
                    if (data.length == 0) {
                        $('#block-right-header').hide()
                        $('#block-right-add').hide()
                        $('#block-right-all-dept').hide()
                        $('#block-right-remove').hide()
                        tr = '<div style="width: 230px;height: 200px;margin: 20px auto;text-align: center">' +
                            '<img src="/img/common/sousuokong.png" style="margin-top: 20px;" alt="">\
                            <span style="width: 100%;display: inline-block;margin-top: 10px;\
                        font-size: 15px;\
                        font-weight: bold;">暂无搜索部门</span>' +
                            '</div>'
                    }


                    $('#deptBox .userItem').html(tr);
                }
            }
        });
    }

    function GetQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }

    // 递归为分支机构添加图片标识
    function diguiAddClassifyOrgImg(data) {
        if (data != null && data.length > 0) {
            for (var i = 0; i < data.length; i++) {
                if (data[i].classifyOrg == 1) {
                    $("#deptOrg").find("[node-id=" + data[i].id + "]").append('<img  style="width: 25px;margin-top: -3px;" src="/img/common/branch.png"alt="分支机构"title="分支机构">');
                }
                diguiAddClassifyOrgImg(data[i].children);
            }
        }
    }

</script>
</html>
