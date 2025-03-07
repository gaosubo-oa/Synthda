<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/5/14
  Time: 11:23
  To change this template use File | Settings | File Templates.
--%>
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
        <title>选择岗位</title>
        <meta http-equiv="Content-Type" content="text/html; charset=gbk"/>
        <meta name="renderer" content="webkit">
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
        </style>
    </head>
    <body>
        <!-- //开始 -->
        <!-- //头部 -->

        <div id="north">
            <div id="navMenu" style="width:auto;">
                <a href="#" title='<fmt:message code="common.th.selPerson" />' class="tab_btn" block="selected"
                   hidefocus="hidefocus"><span><fmt:message code="common.th.selected"/></span></a><%--已选人员  已选--%>
                <a href="#" title='<fmt:message code="common.th.selByDepart" />' block="dept" hidefocus="hidefocus"
                   class=" tab_btn active"><span>岗位</span></a>
                <a href="#" block="query" class="tab_btn" hidefocus="hidefocus" style="display:none;"><span><fmt:message
                        code="workflow.th.sousuo"/></span></a><%--搜索--%>
            </div>
            <div id="navRight" style="float:right;display: none;">
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
                                <a href="javascript:void(0)" class="dynatree-title" onclick="initTree();" id="companyName"
                                   title=""></a>
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
        var urlType = location.href.split('?')[1];
        var jobId = parent.opener.document.getElementById(parent.opener.user_job_id).getAttribute('jobId');
        var jobName = parent.opener.document.getElementById(parent.opener.user_job_id).getAttribute('jobName');
        var jobList = [];
        var checkedIds = [];
        $(function () {
            buildDefaultItem();
            var numIndex = 0;

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

            // 组织
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
                }
            });

            // 选择-删除岗位
            $('#dept_item').on("click", ".block-right-item", function () {
                var that = $(this);
                var jobId = that.attr('jobId');
                if (that.attr('class').indexOf('active') > 0) {
                    that.removeClass("active");
                    if (checkedIds.indexOf(jobId) > -1) {
                        $('#selectedDox .userItem #' + jobId).remove();
                        checkedIds.splice(checkedIds.indexOf(jobId), 1);
                    }
                } else {
                    var divObj = $(that.prop("outerHTML"));
                    divObj.addClass("active");
                    that.addClass("active");
                    if (checkedIds.indexOf(jobId) == -1) {
                        $('#selectedDox .userItem').append(divObj);
                        checkedIds.push(jobId);
                    }
                    if (urlType == 0) {
                        checkedIds = [jobId];
                        that.siblings('div').removeClass('active')
                        $('#selectedDox .userItem').empty();
                        $('#selectedDox .userItem').append(divObj);
                    }
                }
            });

            // 已选全部删除
            $('#selectedDox #block-right-remove').on('click', function () {
                $('#selectedDox .userItem .block-right-item').each(function () {
                    var jobId = $(this).attr('jobId');
                    if ($('#deptBox .userItem #' + jobId).length > 0) {
                        $('#deptBox .userItem #' + jobId).removeClass('active');
                    }
                    if (checkedIds.indexOf(jobId) > -1) {
                        checkedIds.splice(checkedIds.indexOf(jobId), 1);
                    }
                });
                $('#selectedDox .userItem .block-right-item').remove();
            });
            // 已选删除
            $('#selectedDox .userItem ').on('click', '.block-right-item', function () {
                var jobId = $(this).attr('jobId');
                if ($('#deptBox .userItem #' + jobId).length > 0) {
                    $('#deptBox .userItem #' + jobId).removeClass('active');
                }
                if (checkedIds.indexOf(jobId) > -1) {
                    checkedIds.splice(checkedIds.indexOf(jobId), 1);
                }
                $(this).remove();
            });

            // 岗位全部添加
            $('#deptBox #block-right-add').on('click', function () {
                $('#deptBox .userItem .block-right-item').addClass('active');
                var str = '';
                $('#deptBox .userItem .active').each(function (i, v) {
                    var jobId = $(this).attr('jobId');
                    if (checkedIds.indexOf(jobId) == -1) {
                        str += $(this).prop("outerHTML");
                        checkedIds.push(jobId);
                    }
                });
                $('#selectedDox .userItem').append(str);
            });
            // 岗位全部删除
            $('#deptBox #block-right-remove').on('click', function () {
                $('#deptBox .userItem .active').each(function (i, v) {
                    var jobId = $(this).attr('jobId');
                    if (checkedIds.indexOf(jobId) > -1) {
                        $('#selectedDox .userItem #' + jobId).remove();
                        checkedIds.splice(checkedIds.indexOf(jobId), 1);
                    }
                });
                $('#deptBox .userItem .block-right-item').removeClass('active');
            });

            $('.block-right').on('mouseover', 'div', function () {
                $(this).addClass('hover');
            });
            $('.block-right').on('mouseout', 'div', function () {
                $(this).removeClass('hover');
            });
        });

        /**
         * 初始化左侧树
         */
        function initTree() {
            var loadIndex = layer.load();

            /**
             * 获取岗位数据
             */
            $.get('/position/selectUserJob', function (res) {
                layer.close(loadIndex);
                var trSrt = '';
                var checkedStr = '';
                jobList = res.obj;

                if (jobList && jobList.length > 0) {
                    $('#block-right-header').text('全部岗位').show();
                    $('#block-right-add').show();
                    $('#block-right-remove').show();

                    var leftTreeData = [];
                    var deptArrIndexArr = [];

                    jobList.forEach(function (job) {
                        if (deptArrIndexArr.indexOf(job.deptId) == -1) {
                            var deptObj = {
                                deptId: job.deptId,
                                deptName: job.deptName
                            }
                            deptArrIndexArr.push(job.deptId);
                            leftTreeData.push(deptObj);
                        }

                        var active = '';
                        var deptName = job.deptName ? '[' + job.deptName + ']&nbsp;' : '';
                        if (checkedIds.indexOf(job.jobId.toString()) > -1) {
                            active = 'active';
                            checkedStr += '<div class="block-right-item ' + active + '" jobId="'+ job.jobId +'" jobName="' + job.jobName + '" id="' + job.jobId + '" title="' + job.jobName + '"><span class="name">' + deptName + job.jobName + '(' + job.level + ')<span class="status"></span></span></div>'
                        }

                        trSrt += '<div class="block-right-item ' + active + '" jobId="'+ job.jobId +'" jobName="' + job.jobName + '" id="' + job.jobId + '" title="' + job.jobName + '"><span class="name">' + deptName + job.jobName + '(' + job.level + ')<span class="status"></span></span></div>'
                    });

                    // 渲染左侧部门树
                    $('#deptOrg').tree({
                        data: leftTreeData,
                        animate: true,
                        loadFilter: function (node) {
                            var arr = convert(node);
                            return arr;
                        },
                        onClick: function (node) {
                            var jobData = [];
                            $('#block-right-header').text(node.text);
                            jobList.forEach(function(job) {
                                if (job.deptId == node.id) {
                                    jobData.push(job);
                                }
                            });
                            build(jobData);
                        }
                    });

                    $('#selectedDox .userItem').html(checkedStr);
                } else {
                    $('#block-right-header').hide();
                    $('#block-right-add').hide();
                    $('#block-right-remove').hide();
                    trSrt = '<div style="width: 230px;height: 200px;margin: 20px auto;text-align: center">' +
                        '<img src="/img/common/dianjikong.png" style="margin-top: 20px;" alt="">\
                        <span style="width: 100%;display: inline-block;margin-top: 10px;\
                    font-size: 15px;\
                    font-weight: bold;">暂无岗位</span>' +
                        '</div>';
                }

                $('#deptBox .userItem').html(trSrt);
            });
        };

        function TreeNode(id, text, state, children) {
            this.id = id;
            this.text = text;
            this.state = state;
            this.children = children;
        }

        function convert(data) {
            var arr = [];
            data.forEach(function (v, i) {
                if (v.deptName && v.deptId) {
                    var node = new TreeNode(v.deptId, v.deptName)
                    arr.push(node);
                }
            });
            return arr;
        }

        /**
         * 创建岗位列表
         * @param jobData 岗位数据
         */
        function build(jobData) {
            var trSrt = '';

            if (jobData && jobData.length > 0) {
                $('#block-right-header').show();
                $('#block-right-add').show();
                $('#block-right-remove').show();

                jobData.forEach(function (job) {
                    var active = checkedIds.indexOf(job.jobId.toString()) > -1 ? 'active' : '';
                    var deptName = job.deptName ? '[' + job.deptName + ']&nbsp;' : '';
                    trSrt += '<div class="block-right-item ' + active + '" jobId="'+ job.jobId +'" jobName="' + job.jobName + '" id="' + job.jobId + '" title="' + job.jobName + '"><span class="name">' + deptName + job.jobName + '(' + job.level + ')<span class="status"></span></span></div>'
                });
            } else {
                $('#block-right-header').hide();
                $('#block-right-add').hide();
                $('#block-right-remove').hide();
                trSrt = '<div style="width: 230px;height: 200px;margin: 20px auto;text-align: center">' +
                    '<img src="/img/common/dianjikong.png" style="margin-top: 20px;" alt="">\
                    <span style="width: 100%;display: inline-block;margin-top: 10px;\
                font-size: 15px;\
                font-weight: bold;">暂无岗位</span>' +
                    '</div>';
            }

            $('#deptBox .userItem').html(trSrt);
        }

        /**
         * 确定
         */
        function close_window() {
            var itemsArr = $('#selectedDox .userItem .block-right-item');
            var itemnum = location.href.split('?')[1]
            if (itemnum == 0) {
                if (itemsArr.length > 1) {
                    layer.msg('<fmt:message code="common.th.onlyChooseOne" />', {icon: 5});
                    return false;
                }
            }

            var selectItemsId = '';
            var selectItemsName = '';
            for (var i = 0; i < itemsArr.length; i++) {
                var obj = itemsArr.eq(i);
                selectItemsId += (obj.attr("jobId") + ',');
                selectItemsName += (obj.attr("jobName") + ',');
            }
            parent.opener.document.getElementById(parent.opener.user_job_id).value = selectItemsName;
            parent.opener.document.getElementById(parent.opener.user_job_id).setAttribute('jobId', selectItemsId);
            parent.opener.document.getElementById(parent.opener.user_job_id).setAttribute('jobName', selectItemsName);
            if (typeof parent.opener.selectJobFn == 'function') {
                parent.opener.selectJobFn(selectItemsId, selectItemsName);
            }
            window.close();
        }

        /**
         * 设置默认选择
         */
        function buildDefaultItem() {
            var arr = ''
            if (jobId && jobName) {
                var jobIdArr = checkedIds = jobId.replace(/,$/, '').split(',');
                var jobNameArr = jobName.replace(/,$/, '').split(',');

                for (var i = 0; i < jobIdArr.length; i++) {
                    if (jobIdArr[i]) {
                        arr += '<div class="block-right-item active" jobName="' + jobNameArr[i] + '" id="' + jobIdArr[i] + '" jobId="' + jobIdArr[i] + '" title="' + jobNameArr[i] + '"><span class="name">' + jobNameArr[i] + '<span class="status"></span></span></div>';
                    }
                }
                $('#selectedDox .userItem').append(arr);
            }
        };
    </script>
</html>
