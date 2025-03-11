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

    <title>分包商客商管理</title>
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
        .layui-layer-btn {
            text-align: center;
        }
        /*上传附件样式start*/
        .openFile input[type=file] {
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 18px;
            z-index: 99;
            opacity: 0;
        }

        .bar {
            height: 18px;
            background: green;
        }

        /*上传附件样式end*/

    </style>

</head>
<body>
<div style="padding:10px">
    <table id="tableList" lay-filter="tableList"></table>
</div>


<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新建</button>
        <button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>
        <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
    </div>
    <div style="position:absolute;top: 10px;right:60px;">
        <button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;">导入</button>
        <button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;">导出</button>
    </div>
</script>

<script type="text/javascript">
    var dictionaryObj = {
        MERCHANT_TYPE: {},
        CUSTOMER_SOURCE: {},
        CUSTOMER_NATURE: {},
        CUSTOMER_TYPE: {},
    }
    var dictionaryStr = 'MERCHANT_TYPE,CUSTOMER_SOURCE,CUSTOMER_NATURE,CUSTOMER_TYPE';
    // 获取数据字典数据
    $.get('/plbDictonary/selectDictionaryByDictNos', {plbDictNos: dictionaryStr}, function (res) {
        if (res.flag) {
            for (var dict in dictionaryObj) {
                dictionaryObj[dict] = {object: {}, str: '<option value=""></option>'}
                if (res.object[dict]) {
                    res.object[dict].forEach(function (item) {
                        dictionaryObj[dict]['object'][item.plbDictNo] = item.dictName;
                        dictionaryObj[dict]['str'] += '<option value=' + item.plbDictNo + '>' + item.dictName + '</option>';
                    });
                }
            }
        }
    });

    layui.use(['table', 'form','laydate','soulTable'], function () {
        var table = layui.table,
            form = layui.form,
            laydate = layui.laydate,
            soulTable = layui.soulTable;

        // 表格显示顺序
        var colShowObj = {
            customerNo:{field: 'customerNo', title: '客商编号', sort: true, hide: false},
            customerName:{field: 'customerName', title: '客商单位名称', sort: true, hide: false},
            customerShortName:{field: 'customerShortName', title: '客商单位简称', sort: true, hide: false},
            customerOrgCode:{field: 'customerOrgCode', title: '组织机构代码', sort: true, hide: false},
            taxNumber:   {field: 'taxNumber', title: '税务登记号', sort: true, hide: false},
            accountNumber:{field: 'accountNumber', title: '开户行账户', sort: true, hide: false},
        }

        var TableUIObj = new TableUI('plb_subcontractors_customer');
        TableUIObj.init(colShowObj, function(){
            tableShow();
        });

        var tableList = null;

        function tableShow() {
            var cols = [{checkbox: true}].concat(TableUIObj.cols)
            tableList = table.render({
                elem: '#tableList',
                url: '/subcontractor/getDataByCondition',
                page: true,
                height: 'full-80',
                toolbar: '#toolbarDemo',
                defaultToolbar: ['filter'],
                cols: [cols],
                where: {
                    orderbyFields: upperFieldMatch(TableUIObj.orderbyFields),
                    orderbyUpdown: TableUIObj.orderbyUpdown
                },
                parseData: function (res) { //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "data": res.data,//解析数据列表
                        "count": res.totleNum, //解析数据长度
                    }
                },
                done: function () {
                    //增加拖拽后回调函数
                    soulTable.render(this, function () {
                        TableUIObj.dragTable('tableList');
                    });

                    if (TableUIObj.onePageRecoeds != this.limit) {
                        TableUIObj.update({onePageRecoeds: this.limit});
                    }
                },
                initSort: {
                    field: TableUIObj.orderbyFields,
                    type: TableUIObj.orderbyUpdown
                }
            });
        }
        // 监听排序事件
        table.on('sort(tableList)', function (obj) {
            var param = {
                orderbyFields: obj.field,
                orderbyUpdown: obj.type
            }

            TableUIObj.update(param, function () {
                tableShow();
            });
        });
        // 监听筛选列
        var checkboxTimer = null;
        form.on('checkbox()', function (data) {
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

        tableShow()

        // 普通表格头部工具条事件监听
        table.on('toolbar(tableList)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                case 'add':
                    newOrEdit(0)
                    break;
                case 'edit':
                    if (checkStatus.data.length != 1) {
                        layer.msg('请选择一项！', {icon: 0});
                        return false
                    }
                    newOrEdit(1, checkStatus.data[0])
                    break;
                case 'del':
                    if (!checkStatus.data.length) {
                        layer.msg('请至少选择一项！', {icon: 0});
                        return false
                    }
                    var subcontractorsCustomerId = ''
                    checkStatus.data.forEach(function (v, i) {
                        subcontractorsCustomerId += v.subcontractorsCustomerId + ','
                    })
                    layer.confirm('确定删除该条数据吗？', function (index) {
                        $.post('/subcontractor/delSubcontractor', {subcontractorIds: subcontractorsCustomerId}, function (res) {
                            if (res.flag) {
                                layer.msg('删除成功！', {icon: 1});
                            } else {
                                layer.msg('删除失败！', {icon: 0});
                            }
                            layer.close(index)
                            tableList.config.where._ = new Date().getTime();
                            tableList.reload()
                        })
                    });
                    break;
                case 'export':
                    // window.location.href = '/plbMtlPlan/outCurrentPageData?mtlPlanIds=' + exportData
                    break;
            }
        });

        //新建/编辑
        function newOrEdit(type, data) {
            var title
            var url = ''
            if (type == '0') {
                title = '新建'
                url = '/subcontractor/insertOrUpdate'
            } else if (type == '1') {
                title = '编辑'
                url = '/subcontractor/insertOrUpdate'
            }
            layer.open({
                type: 1,
                title: title,
                area: ['100%', '100%'],
                maxmin: true,
                min: function () {
                    $('.layui-layer-shade').hide()
                },
                btn: ['保存', '取消'],
                content: ['<form class="layui-form" id="form" lay-filter="formTest">' +
                //内容start
                //第一行
                '           <div class="layui-row" style="margin-top: 10px">' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">客商编号</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <input type="text" name="customerNo"  autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">客商单位名称</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <input type="text" name="customerName" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '           </div>' +
                //第二行
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">客商单位简称</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <input type="text" name="customerShortName" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">客商类型</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                          <select name="merchantType"></select>'+
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '           </div>' +
                //第三行
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">客商来源</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                          <select name="customerSource"></select>' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">组织机构代码</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <input type="text" name="customerOrgCode" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '           </div>' +
                //第四行
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">单位性质</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                          <select name="customerNature"></select>' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">单位类别</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                          <select name="customerType"></select>' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '           </div>' +
                //第五行
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">税务登记号</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <input type="text" name="taxNumber" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">开户行名称</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <input type="text" name="accountName" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '           </div>' +
                //第六行
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">开户行账户</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <input type="text" name="accountNumber" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">账号单位地址</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <input type="text" name="accountAddress" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '           </div>' +
                //第七行
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">账号单位电话</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <input type="text" name="accountTelno" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">法人代表</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <input type="text" name="legalPeron" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '           </div>' +
                //第八行
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">注册资金（万元）</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <input type="text" name="accountTelno" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">单位营业地址</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <input type="text" name="businessAddress" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '           </div>' +
                //第九行
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">联系人</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <input type="text" name="contactPerson" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">联系电话</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <input type="text" name="contactTelno" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '           </div>' +
                //第十行
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">营业范围</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <input type="text" name="businessScope" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">录入人</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <input type="text" name="createUser" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '           </div>' +
                //第十一行
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">录入时间</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <input type="text" name="createTime" id="createTime" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">备注</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <input type="text" name="remarks" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '           </div>' +
                //第十二行
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs12">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">资证材料</label>' +
                '                       <div class="layui-input-block" style="line-height: 36px">' +
                '                           <div id="fileContent"></div>' +
                '                           <a href="javascript:;" class="openFile" style="float: left;position:relative">' +
                '                           <img src="../img/mg11.png" alt=""><span>添加附件</span>' +
                '                           <input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
                '                           </a>' +
                '                           <div class="progress" style="width: 200px;float: left;margin-left: 10px;margin-top: 2px;">' +
                '                           <div class="bar" style="width: 0%;"></div>\n' +
                '                           </div>' +
                '                           <div class="barText" style="float: left;margin-left: 10px;"></div>' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '           </div>' +
                //内容end
                '</form>'].join(''),
                success: function () {
                    fileuploadFn('#fileupload', $('#fileContent'));
                    $('[name="merchantType"]').html(dictionaryObj['MERCHANT_TYPE']['str'])
                    $('[name="customerSource"]').html(dictionaryObj['CUSTOMER_SOURCE']['str'])
                    $('[name="customerNature"]').html(dictionaryObj['CUSTOMER_NATURE']['str'])
                    $('[name="customerType"]').html(dictionaryObj['CUSTOMER_TYPE']['str'])
                    //回显数据
                    if (type == 1) {
                        form.val("formTest", data);
                        //附件回显
                        var strs1 = '';
                        if(data.attachments && data.attachments.length>0){
                            for (var i = 0; i < data.attachments.length; i++) {
                                strs1 += '<div class="dech" deUrl="'+encodeURI(data.attachments[i].attUrl)+'"><a href="/download?'+encodeURI(data.attachments[i].attUrl)+'" NAME="' + data.attachments[i].attachName + '*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + data.attachments[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data.attachments[i].aid + '@' + data.attachments[i].ym + '_' + data.attachments[i].attachId + ',"></div>';
                            }
                        }
                        $('#fileContent').append(strs1);
                    }
                    form.render()
                    laydate.render({
                        elem: '#createTime' //指定元素
                        , trigger: 'click' //采用click弹出
                        , value: data ? format(data.createTime) : ''
                    });
                },
                yes: function (index) {
                    var datas = $('#form').serializeArray()
                    var obj = {}
                    datas.forEach(function (item, index) {
                        obj[item.name] = item.value
                    })
                    //附件
                    var attachmentId = '';
                    var attachmentName = '';
                    for (var i = 0; i < $('#fileContent .dech').length; i++) {
                        attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                        attachmentName += $('#fileContent a').eq(i).attr('name');
                    }
                    obj.attachmentId = attachmentId
                    obj.attachmentName = attachmentName

                    if (type == 1) {
                        obj.subcontractorsCustomerId = data.subcontractorsCustomerId
                    }

                    $.ajax({
                        url: url,
                        data: obj,
                        dataType: 'json',
                        type: 'post',
                        success: function (res) {
                            if (res.flag) {
                                layer.msg('保存成功！', {icon: 1});
                                layer.close(index);
                                tableList.config.where._ = new Date().getTime();
                                tableList.reload()
                            } else {
                                layer.msg('保存失败！', {icon: 0});
                            }

                        }
                    })
                },
            })
        }

        //删除附件
        $(document).on('click', '.deImgs',function(){
            var _this = this;
            var attUrl = $(this).parents('.dech').attr('deUrl');
            layer.confirm('确定删除该附件吗？', function(index){
                $.ajax({
                    type: 'get',
                    url: '/delete?'+attUrl,
                    dataType: 'json',
                    success:function(res){

                        if(res.flag == true){
                            layer.msg('删除成功', { icon:6});
                            $(_this).parent().remove();
                        }else{
                            layer.msg('删除失败', { icon:2});
                        }
                    }
                })
            });

        });
    });

    /**
     * 将毫秒数转为yyyy-MM-dd格式时间
     * @param t (时间戳)
     * @returns {string}
     */
    function format(t) {
        if (t) {
            return new Date(t).Format("yyyy-MM-dd");
        } else {
            return '';
        }
    }

    //判断是否显示空
    function isShowNull(data) {
        if (!!data) {
            return data
        } else {
            return ''
        }
    }

    //附件上传 方法
    var timer=null;
    function fileuploadFn(formId,element) {
        $(formId).fileupload({
            dataType:'json',
            progressall: function (e, data) {
                var progress = parseInt(data.loaded / data.total * 100, 10);
                element.siblings('.progress').find('.bar').css(
                    'width',
                    progress + '%'
                );
                element.siblings('.barText').html(progress + '%');
                if(progress >= 100){  //判断滚动条到100%清除定时器
                    timer=setTimeout(function () {
                        element.siblings('.progress').find('.bar').css(
                            'width',
                            0 + '%'
                        );
                        element.siblings('.barText').html('');
                    },2000);

                }
            },
            done: function (e, data) {
                if(data.result.obj != ''){
                    var data = data.result.obj;
                    var str = '';
                    var str1 = '';
                    for (var i = 0; i < data.length; i++) {
                        var gs = data[i].attachName.split('.')[1];
                        if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){ //后缀为这些的禁止上传
                            str += '';
                            layer.alert('jsp、css、js、html、java文件禁止上传!',{},function(){
                                layer.closeAll();
                            });
                        }
                        else{
                            var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
                            var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                            var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                            var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;

                            str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                        }
                    }
                    element.append(str);
                }else{
                    layer.alert('添加附件大小不能为空!',{},function(){
                        layer.closeAll();
                    });
                }
            }
        });
    }

</script>
</body>
</html>
