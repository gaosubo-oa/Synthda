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
    <title>经营报表</title>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script type="text/javascript" src="/js/planbudget/common.js"></script>

    <style>

        html, body {
            width: 100%;
            height: 100%;
            background: #fff;
        }

        /*伪元素是行内元素 正常浏览器清除浮动方法*/
        .clearfix:after {
            content: "";
            display: block;
            height: 0;
            clear: both;
            visibility: hidden;
        }

        .clearfix {
            *zoom: 1; /*ie6清除浮动的方式 *号只有IE6-IE7执行，其他浏览器不执行*/
        }

        .container {
            position: relative;
            width: 100%;
            height: 100%;
            padding: 15px 0 10px;
            box-sizing: border-box;
        }

        .wrapper {
            position: relative;
            width: 100%;
            height: 100%;
            padding: 0 8px;
            box-sizing: border-box;
        }

        /* region 左侧样式 */
        .wrap_left {
            position: relative;
            float: left;
            width: 230px;
            height: 100%;
            padding-right: 10px;
            box-sizing: border-box;
        }

        .wrap_left h2 {
            line-height: 35px;
            text-align: center;
        }

        .wrap_left .left_form {
            position: relative;
            overflow: hidden;
        }

        .left_form .layui-input {
            height: 35px;
            margin: 10px 0;
            padding-right: 25px;
        }

        .tree_module {
            position: absolute;
            top: 90px;
            right: 10px;
            bottom: 0;
            left: 0;
            overflow: auto;
            box-sizing: border-box;
        }

        .eleTree-node-content {
            overflow: hidden;
            word-break: break-all;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .search_icon {
            position: absolute;
            top: 10px;
            right: 0;
            height: 35px;
            width: 25px;
            padding-top: 8px;
            text-align: center;
            cursor: pointer;
            box-sizing: border-box;
        }

        .search_icon:hover {
            color: #0aa3e3;
        }
        /* endregion */

        /* region 右侧样式 */
        .wrap_right {
            position: relative;
            height: 100%;
            margin-left: 230px;
            overflow: auto;
        }

        .query_module .layui-input {
            height: 35px;
        }

        /* region 图标样式 */
        .icon_img {
            font-size: 25px;
            cursor: pointer;
        }

        .icon_img:hover {
            color: #0aa3e3;
        }
        /* endregion */

        /* endregion */

        .td_title {
            width: 200px;
            background-color: #e7e7e7;
            border-color: #ccc !important;
        }

        /*附件详情--start*/
        .operationDiv {
            display: none;
            position: absolute;
            top: -50px;
            left: 5px;
            background: #fff;
            box-shadow: 0 0 5px 0 rgb(0, 0, 0);
            border-radius: 5px;
        }
        .divShow {
            position: relative;
        }
        .divShow:hover .operationDiv {
            display: block;
        }
        /*附件详情--end*/

    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="leftId" class="layui-input">
    <div class="wrapper">
        <div class="wrap_left">
            <h2 style="text-align: center;line-height: 35px;">经营报表</h2>
            <div class="left_form">
                <div class="search_icon">
                    <i class="layui-icon layui-icon-search"></i>
                </div>
                <input type="text" name="title" id="search_project" placeholder="项目名称" autocomplete="off" class="layui-input" />
            </div>
            <div class="tree_module">
                <div id="leftTree" class="eleTree" lay-filter="leftTree"></div>
            </div>
        </div>
        <div class="wrap_right">
            <div class="query_module layui-form layui-row" style="position: relative">
                <div class="layui-col-xs4">
                    <div class="layui-form-item">
                        <label class="layui-form-label">仓库</label>
                        <div class="layui-input-block">
                            <select name="city">
                                <option value=""></option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs4">
                    <div class="layui-form-item">
                        <label class="layui-form-label">CBS</label>
                        <div class="layui-input-block">
                            <select name="cbsId">
                                <option value=""></option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs4" style="margin-top: 3px;text-align: center">
                    <button type="button" class="layui-btn layui-btn-sm searchData">查询</button>
                    <button type="button" class="layui-btn layui-btn-sm">高级查询</button>
                </div>
                <div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
                    <i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
                    <i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
                </div>
            </div>
            <div style="position: relative">
                <div class="table_box">
                    <table id="tableDemo" lay-filter="tableDemo"></table>
                </div>
                <div class="no_data" style="text-align: center;display: none">
                    <div class="no_data_img" style="margin-top:12%;">
                        <img style="margin-top: 2%;" src="/img/noData.png">
                    </div>
                    <p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧项目</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/html" id="toolbarDemo">

</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="detail">查看明细</a>
</script>

<script>
    var tipIndex = null;
    $('.icon_img').hover(function () {
        var tip = $(this).attr('text')
        tipIndex = layer.tips(tip, this)
    }, function () {
        layer.close(tipIndex)
    });

    var dictionaryObj = {
        MANAGE_ITEM_TYPE: {},
        ITEM_TYPE: {},
        CONTROL_TYPE: {},
    }
    var dictionaryStr = 'MANAGE_ITEM_TYPE,ITEM_TYPE,CONTROL_TYPE';
    $.get('/plbDictonary/selectDictionaryByDictNos', {plbDictNos: dictionaryStr}, function (res) {
        if (res.flag) {
            for (var dict in dictionaryObj) {
                dictionaryObj[dict] = {object: {}, str: ''}
                if (res.object[dict]) {
                    res.object[dict].forEach(function (item) {
                        dictionaryObj[dict]['object'][item.plbDictNo] = item.dictName;
                        dictionaryObj[dict]['str'] += '<option value=' + item.plbDictNo + '>' + item.dictName + '</option>';
                    });
                }
            }
        }
    });

    layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree', 'xmSelect'], function () {
        var laydate = layui.laydate;
        var form = layui.form;
        var table = layui.table;
        var element = layui.element;
        var soulTable = layui.soulTable;
        var eleTree = layui.eleTree;
        var xmSelect = layui.xmSelect;
        var tableIns = null;

        form.render();
        //表格显示顺序
        var colShowObj = {
            itemNo: {field: 'itemNo', title: '立项编号', sort: true,  hide: false},
            itemType: {field: 'itemType', title: '立项类型', sort: true, hide: false,templet:function (d) {
                return dictionaryObj['MANAGE_ITEM_TYPE']['object'][d.itemType] || ''
            }},
            itemAmount: {field: 'itemAmount', title: '立项金额', sort: true, hide: false},
            itemContent: {field: 'itemContent', title: '立项内容', sort: true, hide: false},
        }

        var TableUIObj = new TableUI('plb_manage_item');


        // 初始化左侧项目
        projectLeft();
        // 监听排序事件
        table.on('sort(tableDemo)', function (obj) {
            var param = {
                orderbyFields: obj.field,
                orderbyUpdown: obj.type
            }

            TableUIObj.update(param, function () {
                tableShow($('#leftId').attr('projId'))
            })
        });
        // 监听筛选列
        form.on('checkbox()', function (data) {
            //判断监听的复选框是筛选列下的复选框
            if ($(data.elem).attr('lay-filter') == 'LAY_TABLE_TOOL_COLS') {
                setTimeout(function () {
                    var $parent = $(data.elem).parent().parent()
                    var arr = []
                    $parent.find('input[type="checkbox"]').each(function () {
                        var obj = {
                            showFields: $(this).attr('name'),
                            isShow: !$(this).prop('checked')
                        }
                        arr.push(obj)
                    })
                    var param = {showFields: JSON.stringify(arr)}
                    TableUIObj.update(param)
                }, 1000)
            }
        });
        //工具条事件
        table.on('tool(tableDemo)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）

            if(layEvent === 'detail'){ //查看
                layer.open({
                    type: 1,
                    title: '查看明细',
                    area: ['80%', '70%'],
                    btnAlign: 'c',
                    content: ['<div class="layui-form">' +
                    //表格数据
                    '       <div style="padding: 0px 5px">' +
                    '           <table id="mtlPlanIdTable" lay-filter="mtlPlanIdTable"></table>' +
                    '      </div>' +
                    '</div>'].join(''),
                    success: function () {
                        table.render({
                            elem: '#mtlPlanIdTable',
                            url: '/PlbManageItem/queryBudgetItemByItemId?itemId='+data.itemId,
                            limit: 1000,
                            cols: [[
                                {field: 'itemNo', title: '预算科目编号',},
                                {field: 'itemName', title: '预算科目名称', width: 200,templet:function (d) {
                                    return '<span class="itemNameDetail" listId="'+d.listId+'" style="color:blue;cursor: pointer">'+d.itemName+'</span>'
                                }},
                                {field: 'itemType', title: '科目类型',templet:function (d) {
                                    return dictionaryObj['ITEM_TYPE']['object'][d.itemType] || ''
                                }},
                                {field: 'controlType', title: '控制类型',templet:function (d) {
                                        return dictionaryObj['CONTROL_TYPE']['object'][d.controlType] || ''
                                    }},
                                {field: 'itemRemark', title: '科目说明',},
                            ]],
                            parseData: function (res) { //res 即为原始返回的数据
                                return {
                                    "code": 0, //解析接口状态
                                    "data": res.data, //解析数据列表
                                };
                            },
                        });
                    },
                });
            }
        });

        //查看经营跟踪明细
        $(document).on('click','.itemNameDetail',function () {
            var listId=$(this).attr('listId')
            layer.open({
                type: 1,
                title: '经营跟踪明细',
                area: ['80%', '90%'],
                content: '<div id="tgDetailBox" style="padding: 0 10px;"></div>',
                success: function () {
                    $.get('/PlbManageTrack/queryByItemId',{listId:listId},function (res) {
                        var data = res.data;
                        var tableStr=''
                        data.forEach(function (v,i) {
                            tableStr += '<table class="layui-table">' +
                                '<tr><td class="td_title">本次进展：</td><td>'+(v.thisProgress || '')+'</td><td class="td_title">进展状态：</td><td>'+(v.doStatus || '')+'</td></tr>' +
                                '<tr><td class="td_title">累计完成量：</td><td>'+(v.cumulativeProgress || '')+'</td><td class="td_title">进展描述：</td><td>'+(v.progressDesc || '')+'</td></tr>' +
                                '<tr><td class="td_title">成果附件：</td><td colspan="3">' +function () {
                                    if (!!v.attachments && v.attachments.length > 0) {
                                        var str = '';

                                        v.attachments.forEach(function (item) {
                                            var attachName = item.attachName;
                                            var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                            var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                            var attachmentUrl = item.attUrl;
                                            attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                            fileExtension = fileExtension.toLowerCase();

                                            str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                '<div class="operationDiv" style="top: -50px;">' + function () {
                                                    if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                    } else {
                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                    }
                                                }() +
                                                '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                + '</div>' +
                                                '</div>'
                                        });

                                        return str;
                                    } else {
                                        return '';
                                    }
                                }()+ '</td></tr>' +
                                '<tr><td class="td_title">异常原因：</td><td>'+(v.unusualReason || '')+'</td><td class="td_title">创建人：</td><td>'+(v.userName || '')+'</td></tr>' +
                                '<tr><td class="td_title">异常支撑材料：</td><td colspan="3">' +function () {
                                    if (!!v.unusualAttachments && v.unusualAttachments.length > 0) {
                                        var str = '';

                                        v.unusualAttachments.forEach(function (item) {
                                            var attachName = item.attachName;
                                            var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                            var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                            var attachmentUrl = item.attUrl;
                                            attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                            fileExtension = fileExtension.toLowerCase();

                                            str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                '<div class="operationDiv" style="top: -50px;">' + function () {
                                                    if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                    } else {
                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                    }
                                                }() +
                                                '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                + '</div>' +
                                                '</div>'
                                        });

                                        return str;
                                    } else {
                                        return '';
                                    }
                                }()+ '</td></tr>' +
                                '</table>';
                        })
                        $('#tgDetailBox').html(tableStr ? tableStr : '<p style="text-align: center">暂无数据</p>');
                    })
                }
            });
        })

        var searchTimer = null
        $('#search_project').on('input propertychange', function () {
            clearTimeout(searchTimer)
            searchTimer = null
            var val = $(this).val()
            searchTimer = setTimeout(function () {
                projectLeft(val)
            }, 300)
        });
        $('.search_icon').on('click', function () {
            projectLeft($('#search_project').val())
        });

        //左侧项目信息列表
        function projectLeft(projectName) {
            projectName = projectName ? projectName : ''
            var loadingIndex = layer.load();
            $.get('/plbOrg/treeListOrg', {projectName: projectName}, function (res) {
                layer.close(loadingIndex);
                if (res.flag) {
                    eleTree.render({
                        elem: '#leftTree',
                        data: res.data,
                        highlightCurrent: true,
                        showLine: true,
                        defaultExpandAll: true,
                        request: {
                            name: 'name',
                            children: "plbProjList",
                        }
                    });
                    TableUIObj.init(colShowObj,function () {
                        tableShow('')
                    });
                }
            });
        }

        // 树节点点击事件
        eleTree.on("nodeClick(leftTree)", function (d) {
            var currentData = d.data.currentData;
            if (currentData.projId) {
                $('#leftId').attr('projId', currentData.projId);
                $('.no_data').hide();
                $('.table_box').show();
                tableShow(currentData.projId);
            } else {
                $('.table_box').hide();
                $('.no_data').show();
            }
        });

        // 渲染表格
        function tableShow(projId) {
            var cols = [{checkbox: true}].concat(TableUIObj.cols)
            cols.push({title:'操作',width:100, align:'center', toolbar: '#barDemo'})

            tableIns = table.render({
                elem: '#tableDemo',
                url: '/PlbManageItem/queryAll',
                toolbar: '#toolbarDemo',
                cols: [cols],
                defaultToolbar: ['filter'],
                height: 'full-100',
                page: {
                    limit: TableUIObj.onePageRecoeds,
                    limits: [10, 20, 30, 40, 50]
                },
                where: {
                    projId: projId,
                    orderbyFields: upperFieldMatch(TableUIObj.orderbyFields),
                    orderbyUpdown: TableUIObj.orderbyUpdown
                },
                autoSort: false,
                parseData: function (res) { //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "data": res.data, //解析数据列表
                        "count": res.totleNum, //解析数据长度
                    };
                },
                request: {
                    limitName: 'pageSize' //每页数据量的参数名，默认：limit
                },
                done: function (res) {
                    //增加拖拽后回调函数
                    soulTable.render(this, function () {
                        TableUIObj.dragTable('tableDemo')
                    })

                    if (TableUIObj.onePageRecoeds != this.limit) {
                        TableUIObj.update({onePageRecoeds: this.limit})
                    }
                },
                initSort: {
                    field: TableUIObj.orderbyFields,
                    type: TableUIObj.orderbyUpdown
                }
            });
        }

        //点击查询
        $('.searchData').click(function () {
            var searchParams = {}
            var $seachData = $('.query [name]')
            $seachData.each(function () {
                searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
            })
            tableIns.reload({
                where: searchParams,
                page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });

        // 附件查阅
        $(document).on('click', '.yulan', function () {
            var url = $(this).attr('data-url');
            pdurl($.UrlGetRequest('?' + url), url);
        });
    });
</script>
</body>
</html>