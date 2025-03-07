<%--
  Created by IntelliJ IDEA.
  User: 小小木
  Date: 2022/2/17
  Time: 15:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>个人预算报表</title>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
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
    <script src="../js/jquery/jquery.cookie.js"></script>

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

        .wrap_right {
            position: relative;
            height: 100%;
            margin-left: 230px;
            overflow: auto;
        }
        .query_module .layui-form-label{
            width:90px;}
        .query_module .layui-input {
            height: 35px;
            width:230px;
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

        .form_label {
            float: none;
            padding: 9px 0;
            text-align: left;
            width: auto;
        }

        .form_block {
            margin: 0;
        }

        .field_required {
            color: red;
            font-size: 16px;
        }

        .layer_wrap .layui_col {
            width: 20% !important;
            padding: 0 5px;
        }

        /* region 上传附件样式 */
        .file_upload_box {
            position: relative;
            height: 22px;
            overflow: hidden;
        }
        .open_file {
            float: left;
            position:relative;
        }
        .open_file input[type=file] {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 2;
            opacity: 0;
        }

        .progress {
            float: left;
            width: 200px;
            margin-left: 10px;
            margin-top: 2px;
        }

        .bar {
            width: 0%;
            height: 18px;
            background: green;
        }

        .bar_text {
            float: left;
            margin-left: 10px;
        }
        /* endregion */

        .td_title {
            width: 200px;
            background: #F2F2F2;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="wrapper">
        <div class="query_module layui-form layui-row" style="position: relative">
            <%-- <div class="layui-col-xs3">
                 <div class="layui-form-item">
                     <label class="layui-form-label">预算年度:</label>
                     <div class="layui-input-block">
                         <input type="text" name="budgetYear" placeholder="预算年度" autocomplete="off" class="layui-input">
                     </div>
                 </div>
             </div>
             <div class="layui-col-xs3">
                 <div class="layui-form-item">
                     <label class="layui-form-label">制单月份:</label>
                     <div class="layui-input-block">
                         <select name="budgetMonth">
                             <option value=""></option><option value="1">1月</option><option value="2">2月</option><option value=""3>3月</option>
                             <option value="4">4月</option><option value="5">5月</option><option value="6">6月</option><option value="7">7月</option>
                             <option value="8">8月</option><option value="9">9月</option><option value="10">10月</option><option value="11">11月</option><option value="12">12月</option>
                         </select>
                     </div>
                 </div>
             </div>
             <div class="layui-col-xs3">
                 <div class="layui-form-item">
                     <label class="layui-form-label">预算科目:</label>
                     <div class="layui-input-block">
                         <div id="projectIdsSelect" class="xm-select-demo"></div>
                     </div>
                 </div>
             </div>--%>
            <div class="layui-col-xs3">
                <div class="layui-form-item">
                    <label class="layui-form-label">经办人:</label>
                    <div class="layui-input-block">
                        <input type="text" name="createUser" id="createUser" placeholder="经办人" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input userAdd">
                    </div>
                </div>
            </div>
            <div class="layui-col-xs3">
                <div class="layui-form-item">
                    <label class="layui-form-label">报销人:</label>
                    <div class="layui-input-block">
                        <input type="text" name="reimburseUser" id="reimburseUser" placeholder="报销人" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input userAdd">
                    </div>
                </div>
            </div>
            <div class="layui-col-xs3">
                <div class="layui-form-item">
                    <label class="layui-form-label">费用承担部门:</label>
                    <div class="layui-input-block">
                        <input type="text" name="reimburseBelongDept" id="reimburseBelongDept" placeholder="费用承担部门" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input deptAdd">
                    </div>
                </div>
            </div>
            <div class="layui-col-xs3" style="margin-top: 3px;text-align: center">
                <button type="button" class="layui-btn layui-btn-sm searchData">查询</button>
            </div>
        </div>
        <div style="position: relative">
            <div class="table_box" >
                <table id="tableObj" lay-filter="tableObj"></table>
            </div>
        </div>
    </div>
</div>


<script type="text/html" id="detailBarDemo">
    <a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
</script>


<script>
    //选部门控件添加
    $(document).on('click', '.deptAdd', function () {
        dept_id = $(this).attr('id');
        $.popWindow("/common/selectDept?0");
    });
    $(document).on('click', '.userAdd', function () {
        user_id = $(this).attr('id')
        $.popWindow("/common/selectUser?0");
    });

    // 表格显示顺序
    var colShowObj = {
        reimburseNo: {field: 'reimburseNo', title: '单据编号', sort: true, hide: false},
        createTime: {field: 'createTime', title: '提交时间', sort: true, hide: false},
        createUserName: {field: 'createUserName', title: '经办人', sort: true, hide: false,templet: function (d) {
                return d.createUserName ? d.createUserName.replace(/,$/, '') : ''
            }},
        reimburseUserName: {field: 'reimburseUserName', title: '报销人', sort: true, hide: false,templet: function (d) {
                return d.reimburseUserName ? d.reimburseUserName.replace(/,$/, '') : ''
            }},
        reimburseDesc: {field: 'reimburseDesc', title: '报销事项', sort: true, hide: false},
        reimburseBelongDeptName: {field: 'reimburseBelongDeptName', title: '费用承担部门', sort: true, hide: false,templet: function (d) {
                return d.reimburseBelongDeptName ? d.reimburseBelongDeptName.replace(/,$/, '') : ''
            }},
        reimburseTotal: {field: 'reimburseTotal', title: '申请支出金额', sort: true, hide: false,templet: function (d) {
                return d.reimburseTotal || 0
            }},
        reimburseStatus: {
            field: 'reimburseStatus',
            title: '报销状态',
            sort: true,
            hide: false,
            templet: function (d) {
                if (d.reimburseStatus == '0') {
                    return '未提交';
                } else if (d.reimburseStatus == '1') {
                    return '报销中';
                } else if (d.reimburseStatus == '2') {
                    return '已报销';
                }else if (d.reimburseStatus == '3'){
                    return '已退回'
                }else{
                    return ''
                }
            }
        },
    }
    var TableUIObj = new TableUI('plb_dept_reimburse');


    var dictionaryObj = {
        CONTROL_TYPE: {},
        BUDGET_YEAR: {},
        REIMBURSEMENT_TYPE: {},
    }
    var dictionaryStr = 'CONTROL_TYPE,BUDGET_YEAR,REIMBURSEMENT_TYPE';
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

    layui.use(['form', 'table', 'soulTable', 'eleTree','element','laydate'], function () {
        var layForm = layui.form,
            layTable = layui.table,
            eleTree = layui.eleTree,
            soulTable = layui.soulTable,
            element = layui.element,
            laydate = layui.laydate;
        layForm.render();

        laydate.render({
            elem: '[name="budgetYear"]',
            trigger: 'click', //采用click弹出
            type: 'year'
        });

        var tableObj = null;

        TableUIObj.init(colShowObj,function () {
            tableInit()
        });


        // 监听排序事件
        layTable.on('sort(tableObj)', function (obj) {
            var param = {
                orderbyFields: obj.field,
                orderbyUpdown: obj.type
            }

            TableUIObj.update(param, function () {
                tableInit($('.layui-tab .layui-this').attr('colsType'),$('#leftId').attr('deptId'));
            });
        });
        // 监听筛选列
        var checkboxTimer = null;
        layForm.on('checkbox()', function (data) {
            //判断监听的复选框是筛选列下的复选框
            if ($(data.elem).attr('lay-filter') == 'LAY_TABLE_TOOL_COLS') {
                checkboxTimer = null;
                clearTimeout(checkboxTimer);
                setTimeout(function () {
                    var $parent = $(data.elem).parent().parent();
                    var arr = [];
                    $parent.find('input[type="checkbox"]').each(function () {
                        var obj = {
                            showFields: $(this).attr('name'),
                            isShow: !$(this).prop('checked')
                        }
                        arr.push(obj);
                    });
                    var param = {showFields: JSON.stringify(arr)}
                    TableUIObj.update(param);
                }, 1000);
            }
        });

        layTable.on('tool(tableObj)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            if (layEvent === 'detail') {
                newOrEdit(3, data);
            }
        });

        /**
         * 加载表格方法
         */
        function tableInit() {
            var cols = [{checkbox: true}].concat(TableUIObj.cols)
            // var cols = TableUIObj.cols

            cols.push({
                fixed: 'right',
                align: 'center',
                toolbar: '#detailBarDemo',
                title: '操作',
                width: 100
            })

            var option = {
                elem: '#tableObj',
                url:'/plbDeptBudget/myBudgetReportForm',
                cols: [cols],
                toolbar: '#toolbarHead',
                defaultToolbar: ['filter'],
                height: 'full-165',
                page: {
                    limit: TableUIObj.onePageRecoeds,
                    limits: [10, 20, 30, 40, 50]
                },
                where: {
                    orderbyFields: upperFieldMatch(TableUIObj.orderbyFields),
                    orderbyUpdown: TableUIObj.orderbyUpdown
                },
                autoSort: false,
                request: {
                    limitName: 'pageSize'
                },
                response: {
                    statusName: 'flag',
                    statusCode: true,
                    msgName: 'msg',
                    countName: 'totleNum',
                    dataName: 'data'
                },
                done: function () {
                    //增加拖拽后回调函数
                    soulTable.render(this, function () {
                        TableUIObj.dragTable('tableObj');
                    });

                    if (TableUIObj.onePageRecoeds != this.limit) {
                        TableUIObj.update({onePageRecoeds: this.limit});
                    }
                }
            }


            if (TableUIObj.orderbyFields) {
                option.initSort = {
                    field: TableUIObj.orderbyFields,
                    type: TableUIObj.orderbyUpdown
                }
            }

            tableObj = layTable.render(option);
        }

        function newOrEdit(type, data) {
            var title = '';
            var reimburseType = data.reimburseType

            var url = '/plbDeptBudget/editClaimForm?type=' + type + '&reimburseType=' + reimburseType;
            if (type == 1) {
                title = '新增' + dictionaryObj['REIMBURSEMENT_TYPE']['object'][reimburseType];
            } else if (type == 2) {
                title = '编辑' + dictionaryObj['REIMBURSEMENT_TYPE']['object'][reimburseType] + '-' + data.reimburseNo;
                url += '&reimburseId=' + data.reimburseId;
            } else if (type == 3) {
                title = dictionaryObj['REIMBURSEMENT_TYPE']['object'][reimburseType] + '-' + data.reimburseNo;
                url += '&reimburseId=' + data.reimburseId + '&disabled=1';
            }
            iframeLayerIndex = layer.open({
                type: 2,
                title: title,
                area: ['100%', '100%'],
                content: url,
            });
        }


        //点击查询
        $('.searchData').on('click',function () {
            var searchParams = {}
            var $seachData = $('.query_module [name]')
            $seachData.each(function () {
                searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
            })
            searchParams.createUser=$('#createUser').attr('user_id') ? $('#createUser').attr('user_id').replace(/,$/, '') : ''
            searchParams.reimburseUser=$('#reimburseUser').attr('user_id') ? $('#reimburseUser').attr('user_id').replace(/,$/, '') : ''
            searchParams.reimburseBelongDept=$('#reimburseBelongDept').attr('deptid') ? $('#reimburseBelongDept').attr('deptid').replace(/,$/, '') : ''

            tableObj.reload({
                where: searchParams,
                page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });

        //判断是否显示空
        function isShowNull(data) {
            if(data){
                return data
            }else{
                return ''
            }
        }
    });
</script>
</body>
</html>
