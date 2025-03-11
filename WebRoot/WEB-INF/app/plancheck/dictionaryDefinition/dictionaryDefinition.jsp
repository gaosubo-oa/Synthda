<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>数据字典管理</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">

		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
		<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

		<script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
		<script type="text/javascript" src="/js/jquery/jquery.form.min.js"></script>
		<script type="text/javascript" src="/js/base/base.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/global.js"></script>
		<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
        <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
        <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
        <script type="text/javascript" src="/js/common/fileupload.js"></script>

		<style>
			.layui-form-label {
				width: 100px;
			}

			.layui-input-block {
				margin-left: 130px;
			}

			.layui-disabled, .layui-disabled:hover {
				color: #797979 !important;
			}

			.ztree * {
				font-size: 11pt !important;
			}

			#questionTree li {
				border-bottom: 1px solid #ddd;
				line-height: 40px;
				padding-left: 10px;
				cursor: pointer;
				border-radius: 3px;
			}

			.select {
				background: #c7e1ff;
			}

			.layui-table-tool {
				min-height: 40px;
				padding: 5px 15px;
			}

			.func_name {
				overflow: hidden;
				text-overflow: ellipsis;
				white-space: nowrap;
			}

			/* region 上传附件样式 */
            .file_upload_box {
	            position: relative;
	            height: 22px;
	            margin-top: 8px;
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
		</style>

		<script type="text/javascript">
            var funcUrl = location.pathname;
            var authorityObject = null;
            if (funcUrl) {
                $.ajax({
                    type: 'GET',
                    url: '/plcPriv/findPermissions',
                    data: {
                        funcUrl: funcUrl
                    },
                    dataType: 'json',
                    async: false,
                    success: function (res) {
                        if (res.flag) {
                            if (res.object && res.object.length > 0) {
                                authorityObject = {}
                                res.object.forEach(function (item) {
                                    authorityObject[item] = item;
                                });
                            }
                        }
                    },
                    error: function () {

                    }
                });
            }
		</script>

	</head>
	<body>
		<%--<div style="padding-top: 5px;position: relative;">
			<img src="../../img/addcodemain.png" style="position: absolute;left: 22px;top:9px "><span style="margin-left: 49px;font-size: 20px;">数据字典管理</span>
		</div>
		&lt;%&ndash;蓝色分割线&ndash;%&gt;
		<hr class="layui-bg-blue" style="height: 5px">--%>
		<div class="layui-fluid" id="LAY-app-message">
			<input type="hidden" id="sortId">
			<div class="layui-row ">
				<div class="layui-lf" style="width:250px;float:left">
					<div class="layui-card">
						<div class="layui-card-body" id="leftHeight" style="height:650px;">
							<div style="margin-bottom:10px">
								<button type="button" class="layui-btn layui-btn-primary layui-btn-sm add" id="addPlan" style="display: none;">新增</button>
								<button type="button" class="layui-btn layui-btn-primary layui-btn-sm add" id="editPlan" style="display: none;">编辑</button>
								<button type="button" class="layui-btn layui-btn-primary layui-btn-sm del" id="delPlan" style="display: none;">删除</button>
							</div>
							<ul id="questionTree" style="overflow:auto;height:calc(100% - 40px)">
							</ul>
						</div>
					</div>
				</div>
				<div class="layui-rt rightHeight" style="width:calc(100% - 250px);float:left;background-color: #fff;">
					<div class="layui-card" style="padding-left: 10px;height: 100%;">
						<table id="questionTable" lay-filter="questionTable-table" onload=''></table>
					</div>
				</div>
			</div>
			<script type="text/html" id="barDemo">
				{{#  if(authorityObject && authorityObject['31']){ }}
				<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
				{{#  } }}
				{{#  if(authorityObject && authorityObject['32']){ }}
				<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
				{{#  } }}
			</script>
		</div>
		<script type="text/html" id="toolbar">
			<div class="layui-btn-container">
				{{# if(authorityObject && authorityObject['30']){ }}
				<button class="layui-btn layui-btn-sm" style="margin: 0;" id="addTable">新增</button>
				{{# } }}
			</div>
		</script>
		<script>
            initAuthority();

            resizeSize();

            window.onresize = resizeSize;

            var form = null;
            var table = null;
            var tableIns = null;

            var type = $.GetRequest().type;
            var dataType = $.GetRequest().dataType;
            var shitiType = ''

            $('#questionTree').on('click', 'li', function () {
                // var dictNo = $(this).attr('dictNo');
                // var thTitle = $(this).text();
                $(this).addClass('select').siblings().removeClass('select');
                // var  currentPage=1;
                initTable()

            })

            // 获取左侧类型列表
            function getlis() {
                $.ajax({
                    url: '/Dictonary/selectDictionary',
                    type: 'get',
                    dataType: 'json',
                    success: function (res) {
                        if (res.code == 0) {
                            var data = res.data;
                            var str = ''
                            for (var i = 0; i < data.length; i++) {
                                if (i == 0) {
                                    str += '<li class="select"  dictNo="' + data[i].dictNo + '"  dictId="' + data[i].dictId + '">' + data[i].dictName + '</li>'
                                } else {
                                    str += '<li dictNo="' + data[i].dictNo + '" dictId="' + data[i].dictId + '" >' + data[i].dictName + '</li>'
                                }
                            }
                            $('#questionTree').html(str);
                            initTable();
                        }
                    }
                })
            }

            getlis();

            //左侧新建类型
            $('#addPlan').on("click",function () {
                create(0, '')
            })
            //左侧修改类型
            $('#editPlan').on("click",function () {
                var dictId = $('.select').attr('dictId');
                create(1, dictId)
            })
            //左侧删除类型
            $('#delPlan').on("click",function () {
                var dictId = $('.select').attr('dictId');
                var text = $('.select').text();
                layer.confirm('是否要删除' + text, {icon: 3, title: '删除'}, function (index) {
                    $.ajax({
                        url: '/Dictonary/delDictionary',
                        data: {dictId: dictId},
                        type: 'get',
                        dataType: 'json',
                        success: function (res) {
                            if (res.flag) {
                                layer.msg('删除成功', {icon: 1})
                                getlis()
                            } else {
                                layer.msg('删除失败', {icon: 2})
                            }
                        }
                    })
                    layer.close(index);
                });
            })

            //左侧新建编辑共有函数
            function create(type, dictId) {
                if (type == '0') {
                    var title = '添加字典'
                    var url = '/Dictonary/insert'
                } else {
                    var title = '编辑'
                    var url = '/Dictonary/upDictionary'
                }
                layer.open({
                    type: 1,
                    title: title,
                    shadeClose: true,
                    btn: ['确定', '取消'],
                    shade: 0.5,
                    maxmin: true, //开启最大化最小化按钮
                    area: ['500px', '450px'],
                    content: ' <div class="layui-form" >' +
                        '<div class="layui-form-item"style="width: 80%;margin-top: 8%;">\n' +
                        '    <label class="layui-form-label">字典名称:<span style="color:red;">*</span></label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="dictName" required  lay-verify="required" placeholder="请输入字典名称" autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>' +
                        '<div class="layui-form-item" style="width: 80%;">\n' +
                        '    <label class="layui-form-label">代码编号:<span style="color:red;">*</span></label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="dictNo" required  lay-verify="required" placeholder="请输入代码编号" autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>' +
                        '<div class="layui-form-item" style="width: 80%;">\n' +
                        '    <label class="layui-form-label">排序号:<span style="color:red;">*</span></label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="dictOrder" required  lay-verify="required" placeholder="请输入排序号" autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>' +
                        '<div class="layui-form-item" style="width: 80%;">\n' +
                        '    <label class="layui-form-label">备注说明:</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="remarks" required  lay-verify="required" placeholder="请输入备注说明" autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>' +
	                    '<div class="layui-form-item" style="width: 80%;">' +
                            '<label class="layui-form-label">附件</label>' +
                            '<div class="layui-input-block">' +
                            '<div class="file_module" style="overflow: hidden;">' +
                            '<div id="fileContent" class="file_content"></div>' +
                            '<div class="file_upload_box">' +
                            '<a href="javascript:;" class="open_file">' +
                            '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                            '<input type="file" multiple id="fileupload" data-url="/upload?module=plancheck" name="file">' +
                            '</a>' +
                            '<div class="progress">' +
                            '<div class="bar"></div>\n' +
                            '</div>' +
                            '<div class="bar_text"></div>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                        '</div>',
                    success: function () {

                        fileuploadFn('#fileupload', $('#fileContent'));

                        if (type == 1) {
                            $.ajax({
                                url: '/Dictonary/selectDictionaryById',
                                type: 'get',
                                data: {dictId: dictId},
                                dataType: 'json',
                                success: function (res) {
                                    var data = res.data[0]
                                    $('input[name="dictName"]').val(data.dictName)
                                    $('input[name="dictNo"]').val(data.dictNo)
                                    $('input[name="dictOrder"]').val(data.dictOrder)
                                    $('input[name="remarks"]').val(data.remarks)

                                    if (data.attachmentList && data.attachmentList.length > 0) {
                                        var fileArr = data.attachmentList;
                                        var str = '';
                                        for (var i = 0; i < fileArr.length; i++) {
                                            var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
                                            var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                            var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

                                            str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
                                        }
                                        $('#fileContent').append(str);
                                    }
                                }
                            })
                        }
                        form.render();
                    },
                    yes: function () {
                        var dictName = $('input[name="dictName"]').val()
                        var dictNo = $('input[name="dictNo"]').val()
                        var dictOrder = $('input[name="dictOrder"]').val()
                        var remarks = $('input[name="remarks"]').val()
                        var data = {
                            dictName: dictName,
                            dictNo: dictNo,
                            dictOrder: dictOrder,
                            remarks: remarks
                        }
                       if (dictName==""){
						   layer.msg('请输入字典名称', {icon: 2});
						   return;
					   }
                       if (dictNo==""){
						   layer.msg('请输入字典编号', {icon: 2});
						   return;
					   }
                       if (dictOrder==""){
						   layer.msg('请输入排序号', {icon: 2});
						   return;
					   }

                        // 附件
                        var attachmentId = '';
                        var attachmentName = '';
                        for (var i = 0; i < $('#fileContent .dech').length; i++) {
                            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                            attachmentName += $('#fileContent a').eq(i).attr('name');
                        }
                        data.attachmentId = attachmentId;
                        data.attachmentName = attachmentName;

                        if (type == 1) {
                            data.dictId = dictId
                        }
                        $.ajax({
                            url: url,
                            data: data,
                            dataType: 'json',
                            type: 'get',
                            success: function (res) {
                                if (res.flag) {
                                    layer.msg('保存成功', {icon: 1});
                                    getlis();
                                    layer.closeAll();
                                }
                            }
                        })
                    }
                });
            }

            // 渲染右侧表格数据
            function initTable() {
                var dictNo = $('.select').attr('dictNo'),
                    thTitle = $('.select').text() + '名称';
                layui.use(['table', 'layer', 'form', 'xmSelect'], function () {
                    var layer = layui.layer,
                        xmSelect = layui.xmSelect;
                    table = layui.table;
                    form = layui.form;
                    var showStyleFlag = dictNo == 'PLAN_LEVEL' ? false : true;
                    tableIns = table.render({
                        elem: '#questionTable'
                        , url: '/Dictonary/selectDictionaryByNo?dictNo=' + dictNo
                        , toolbar: '#toolbar'
                        , defaultToolbar: ['']
                        , height: 'full-80'
                        , cols: [[ //表头
                            {field: 'dictNo', title: '编号'}
                            , {field: 'dictName', title: thTitle}

                            , {field: 'showStyle', title: '计划级次表现形式', hide: showStyleFlag}
                            , {
                                field: 'facility', title: '功能', templet: function (d) {
                                    var str = '';
                                    if (dictNo == 'FUNC_OP_PRIV' || dictNo == 'TG_TYPE' || dictNo == 'INDICATOR_TYPE') {
                                        str = '<div dictId="' + d.dictId + '" class="func_name"><span>' + (d.funcName || '') + '<span></div>';
                                    } else {
                                        str = d.facility;
                                    }
                                    return str;
                                }
                            }
							, {field: 'remarks', title: '备注',}
                            , {title: '操作', align: 'center', toolbar: '#barDemo'}
                        ]]
                    });

                    //监听工具条
                    table.on('tool(questionTable-table)', function (obj) {
                        var data = obj.data;
                        var layEvent = obj.event;
                        var dictId = data.dictId

                        if (layEvent === 'edit') {
                            var gongnengSelect = null;
                            var str = '';
                            var parentNo = $('.select').attr('dictno');
                            if (parentNo == 'PLAN_LEVEL') {
                                str = '<div class="layui-form-item" style="width: 80%;padding-left:20px">\n' +
                                    '    <label class="layui-form-label" style="width: 120px;">计划级次表现形式:</label>\n' +
                                    '    <div class="layui-input-block" style="margin-left: 150px;">\n' +
                                    '      <input type="text" name="showStyle" required  lay-verify="required" placeholder="请输入计划级次表现形式" autocomplete="off" class="layui-input">\n' +
                                    '    </div>\n' +
                                    '  </div>';
                            }
                            var gongnengStr = '<div class="layui-form-item" style="width: 80%;padding-left:20px">\n' +
                                '    <label class="layui-form-label" style="width: 120px;">功能:</label>\n' +
                                '    <div class="layui-input-block" style="margin-left: 150px;">\n' +
                                '      <input id="gongneng" type="text" name="gongneng" required  lay-verify="required" placeholder="请输入功能" autocomplete="off" class="layui-input">\n' +
                                '    </div>\n' +
                                '  </div>';
                            if (parentNo == 'FUNC_OP_PRIV') {
                                gongnengStr = '<div class="layui-form-item" style="width: 80%;padding-left:20px">\n' +
                                    '    <label class="layui-form-label" style="width: 120px;">功能:</label>\n' +
                                    '    <div class="layui-input-block" style="margin-left: 150px;">\n' +
                                    '      <div id="gongnengSelect" class="xm-select-demo" style="width: 100%;"></div>\n' +
                                    '    </div>\n' +
                                    '  </div>';
                            }
                            if (parentNo == 'TG_TYPE') {
                                gongnengStr = '<div class="layui-form-item" style="width: 80%;padding-left:20px">\n' +
                                    '    <label class="layui-form-label" style="width: 120px;">功能:</label>\n' +
                                    '    <div class="layui-input-block" style="margin-left: 150px;">\n' +
                                    '<select name="gongnengSelect" lay-verify="required">\n' +
                                    '        <option value=""></option>\n' +
                                    '      </select>' +
                                    '    </div>\n' +
                                    '  </div>';
                            }
                            if (parentNo == 'INDICATOR_TYPE') {
                                gongnengStr = '<div class="layui-form-item" style="width: 80%;padding-left:20px">\n' +
                                    '    <label class="layui-form-label" style="width: 120px;">功能:</label>\n' +
                                    '    <div class="layui-input-block" style="margin-left: 150px;">\n' +
                                    '<select name="gongnengSelect" lay-verify="required">\n' +
                                    '        <option value=""></option>\n' +
                                    '      </select>' +
                                    '    </div>\n' +
                                    '  </div>';
                            }
                            layer.open({
                                type: 1,
                                title: '编辑',
                                shadeClose: true,
                                btn: ['确定', '取消'],
                                shade: 0.5,
                                maxmin: true, //开启最大化最小化按钮
                                area: ['600px', '400px'],
                                content: ' <div class="layui-form" >' +
                                    '<div class="layui-form-item"style="width: 80%;margin-top: 8%;padding-left:20px">\n' +
                                    '    <label class="layui-form-label" style="width: 120px">' + thTitle + ':</label>\n' +
                                    '    <div class="layui-input-block" style="margin-left: 150px;">\n' +
                                    '      <input type="text" name="planCategoryName" required  lay-verify="required" placeholder="请输入' + thTitle + '" autocomplete="off" class="layui-input">\n' +
                                    '    </div>\n' +
                                    '  </div>' +
                                    '<div class="layui-form-item"style="width: 80%;padding-left:20px">\n' +
                                    '    <label class="layui-form-label" style="width: 120px">编号:</label>\n' +
                                    '    <div class="layui-input-block" style="margin-left: 150px;">\n' +
                                    '      <input type="text" name="dictNo" readonly disabled style="background: #e7e7e7" lay-verify="required" placeholder="请输入编号" autocomplete="off" class="layui-input">\n' +
                                    '    </div>\n' +
                                    '  </div>' + str + gongnengStr +
                                    '<div class="layui-form-item" style="width: 80%;padding-left:20px">\n' +
                                    '    <label class="layui-form-label" style="width: 120px;">备注:</label>\n' +
                                    '    <div class="layui-input-block" style="margin-left: 150px;">\n' +
                                    '      <input type="text" name="remarks" required  lay-verify="required" placeholder="请输入备注" autocomplete="off" class="layui-input">\n' +
                                    '    </div>\n' +
                                    '  </div>' +
                                    '</div>',
                                success: function () {
                                    console.log(parentNo);
                                    $('input[name="planCategoryName"]').val(data.dictName);
                                    if (parentNo == 'FUNC_OP_PRIV') {
                                        // 获取分类可见范围
                                        $.get('/findChildMenu?id=74', function (res) {
                                            if (res.flag && res.obj.length > 0) {
                                                gongnengSelect = xmSelect.render({
                                                    el: '#gongnengSelect',
                                                    autoRow: true,
                                                    filterable: true,
                                                    tree: {
                                                        show: true,
                                                        showFolderIcon: true,
                                                        showLine: true,
                                                        indent: 20,
                                                        expandedKeys: [-3],
                                                    },
                                                    toolbar: {
                                                        show: true,
                                                    },
                                                    name: 'gongneng',
                                                    prop: {
                                                        name: 'name',
                                                        value: 'fId',
                                                        children: 'child'
                                                    },
                                                    data: res.obj
                                                });
                                            }
                                            var facilityArr = data.facility.replace(/,$/, '').split(',');
                                            gongnengSelect.setValue(facilityArr);
                                            form.render();
                                        });
                                    } else if (parentNo == 'TG_TYPE') {
                                        $.get('/Dictonary/selectDictionaryByNo?dictNo=TG_TYPE_PARENT', function (res) {
                                            if (res.flag && res.data.length > 0) {
                                                var str = ''
                                                res.data.forEach(function (v, i) {
                                                    str += '<option value="' + v.dictNo + '">' + v.dictName + '</option>'
                                                })
                                                $('[name="gongnengSelect"]').append(str)
                                                $('[name="gongnengSelect"]').val(data.facility);
                                                form.render();
                                            }
                                        })
                                    } else if (parentNo == 'INDICATOR_TYPE') {
                                        $.get('/Dictonary/selectDictionaryByNo?dictNo=INDICATOR_TYPE_PARENT', function (res) {
                                            var str = ''
                                            if (res.flag && res.data.length > 0) {

                                                res.data.forEach(function (v, i) {
                                                    str += '<option value="' + v.dictNo + '">' + v.dictName + '</option>'
                                                })
                                            }
                                            $('[name="gongnengSelect"]').append(str)
                                            $('[name="gongnengSelect"]').val(data.facility);
                                            form.render();
                                        })
                                    } else {
                                        $('input[name="gongneng"]').val(data.facility);
                                    }
                                    $('input[name="showStyle"]').val(data.showStyle);
                                    $('input[name="dictNo"]').val(data.dictNo);
                                    $('input[name="remarks"]').val(data.remarks);
                                },
                                yes: function () {
                                    var planCategoryName = $('input[name="planCategoryName"]').val();
                                    var gongneng = '';
                                    if (parentNo == 'FUNC_OP_PRIV') {
                                        gongneng = gongnengSelect.getValue('valueStr');
                                        gongneng = !!gongneng ? gongneng + ',' : '';
                                    } else {
                                        gongneng = $('#gongneng').val()
                                    }
                                    var showStyle = $('input[name="showStyle"]').val();
                                    var remarks = $('input[name="remarks"]').val();
                                    var data = {
                                        dictName: planCategoryName,
                                        facility: gongneng,
                                        dictId: dictId,
                                        remarks: remarks,
                                        showStyle: showStyle ? showStyle : ''
                                    }
                                    $.ajax({
                                        url: '/Dictonary/upDictionary',
                                        data: data,
                                        dataType: 'json',
                                        type: 'get',
                                        success: function (res) {
                                            if (res.flag) {
                                                layer.msg('编辑成功', {icon: 1});
                                                layer.closeAll();
                                                tableIns.reload()
                                            }
                                        }
                                    });
                                }
                            });
                        } else if (layEvent === 'del') {
                            layer.confirm('真的删除该数据吗？', function (index) {
                                $.ajax({
                                    url: '/Dictonary/delDictionary',
                                    data: {dictId: dictId},
                                    dataType: 'json',
                                    type: 'get',
                                    success: function (res) {
                                        if (res.flag) {
                                            layer.msg('删除成功', {icon: 1});
                                            tableIns.reload()
                                        }
                                    }
                                })
                                layer.close(index);

                            });
                        }
                    });
                })
            }

            //右侧新建
            // $('#addTable').off();
            $(document).on('click', '#addTable', function () {
                var dictNo = $('.select').attr('dictNo'),
                    thTitle = $('.select').text() + '名称';
                var parentNo = $('.select').attr('dictno');
                var str = ''
                if (parentNo == 'PLAN_LEVEL') {
                    str = '<div class="layui-form-item" style="width: 80%;padding-left:20px">\n' +
                        '    <label class="layui-form-label" style="width: 25%">计划级次表现形式:</label>\n' +
                        '    <div class="layui-input-block" style="margin-left: 150px;">\n' +
                        '      <input type="text" name="showStyle" required  lay-verify="required" placeholder="请输入计划级次表现形式" autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>';
                }
                var gongnengSelect = null;
                var gongnengStr = '<div class="layui-form-item" style="width: 80%;padding-left:20px">\n' +
                    '    <label class="layui-form-label" style="width: 120px;">功能:</label>\n' +
                    '    <div class="layui-input-block" style="margin-left: 150px;">\n' +
                    '      <input type="text" name="gongneng" required  lay-verify="required" placeholder="请输入功能" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div>';
                if (parentNo == 'FUNC_OP_PRIV') {
                    gongnengStr = '<div class="layui-form-item" style="width: 80%;padding-left:20px">\n' +
                        '    <label class="layui-form-label" style="width: 120px;">功能:</label>\n' +
                        '    <div class="layui-input-block" style="margin-left: 150px;">\n' +
                        '      <div id="gongnengSelect" class="xm-select-demo" style="width: 100%;"></div>\n' +
                        '    </div>\n' +
                        '  </div>';
                }
                layer.open({
                    type: 1,
                    title: '新增',
                    btn: ['确定', '取消'],
                    shade: 0.5,
                    maxmin: true, //开启最大化最小化按钮
                    area: ['600px', '400px'],
                    content: ' <div class="layui-form" id="newRight" >' +
                        '<div class="layui-form-item" style="width: 80%;margin-top: 8%;padding-left:20px">\n' +
                        '    <label class="layui-form-label" style="width: 25%">' + thTitle + ':</label>\n' +
                        '    <div class="layui-input-block" style="margin-left: 150px;">\n' +
                        '      <input type="text" name="planCategoryName" required  lay-verify="required" placeholder="请输入' + thTitle + '" autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>' +
                        '<div class="layui-form-item"style="width: 80%;padding-left:20px">\n' +
                        '    <label class="layui-form-label" style="width: 25%">编号:</label>\n' +
                        '    <div class="layui-input-block" style="margin-left: 150px;">\n' +
                        '      <input type="text" name="dictNo" style="background: #e7e7e7" readonly required  lay-verify="required" placeholder="请输入编号" autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>' + str + gongnengStr +
                        '<div class="layui-form-item" style="width: 80%;padding-left:20px">\n' +
                        '    <label class="layui-form-label" style="width: 25%">备注:</label>\n' +
                        '    <div class="layui-input-block" style="margin-left: 150px;">\n' +
                        '      <input type="text" name="remarks" required  lay-verify="required" placeholder="请输入备注" autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>' +
                        '</div>',
                    success: function () {
                        var parentNo = $('.select').attr('dictno')
                        $.get('/Dictonary/getNoByParnetNo', {parentNo: parentNo}, function (res) {
                            $('#newRight input[name="dictNo"]').val(res)
                        });
                        if (parentNo == 'FUNC_OP_PRIV') {
                            // 获取分类可见范围
                            $.get('/findChildMenu?id=74', function (res) {
                                if (res.flag && res.obj.length > 0) {
                                    gongnengSelect = xmSelect.render({
                                        el: '#gongnengSelect',
                                        autoRow: true,
                                        filterable: true,
                                        tree: {
                                            show: true,
                                            showFolderIcon: true,
                                            showLine: true,
                                            indent: 20,
                                            expandedKeys: [-3],
                                        },
                                        toolbar: {
                                            show: true,
                                        },
                                        name: 'gongneng',
                                        prop: {
                                            name: 'name',
                                            value: 'fId',
                                            children: 'child'
                                        },
                                        data: res.obj
                                    });
                                }
                                form.render();
                            });
                        }
                    },
                    yes: function (index) {
                        var dictNo = $('input[name="dictNo"]').val();
                        var dictName = $('input[name="planCategoryName"]').val();
                        var facility = '';
                        if (parentNo == 'FUNC_OP_PRIV') {
                            facility = gongnengSelect.getValue('valueStr');
                            facility = !!facility ? facility + ',' : '';
                        } else {
                            facility = $('input[name="gongneng"]').val();
                        }
                        var showStyle = $('input[name="showStyle"]').val();
                        var remarks = $('input[name="remarks"]').val();
                        var data = {
                            dictNo: dictNo,
                            dictName: dictName,
                            facility: facility,
                            dictOrder: 0,
                            parentNo: parentNo,
                            showStyle: showStyle ? showStyle : '',
                            remarks: remarks
                        }
                        $.ajax({
                            url: '/Dictonary/inserts',
                            data: data,
                            dataType: 'json',
                            type: 'get',
                            success: function (res) {
                                if (res.flag) {
                                    if (res.code == 2) {
                                        layer.msg('该序号已被使用，请重新输入', {icon: 2});
                                    } else {
                                        layer.msg('新增成功', {icon: 1});
                                        layer.close(index);
                                        tableIns.reload()
                                    }
                                }
                            }
                        })
                    }
                });
            });

            var layerTipIndex = null;

            $(document).on('mouseover', '.func_name', function () {
                var text = $(this).text();
                var dictId = $(this).attr('dictid');
                $(this).parent().attr('id', dictId);
                layerTipIndex = layer.tips(text, '#' + dictId, {
                    tips: [1, '#78BA32'],
                    time: 0
                });
            });

            $(document).on('mouseout', '.func_name', function () {
                layer.close(layerTipIndex);
            });

            // 删除附件
            $(document).on('click', '.deImgs', function () {
                var _this = this;
                var attUrl = $(this).parents('.dech').attr('deUrl');
                layer.confirm('确定删除该附件吗？', function (index) {
                    $.ajax({
                        type: 'get',
                        url: '/delete?' + attUrl,
                        dataType: 'json',
                        success: function (res) {
                            if (res.flag == true) {
                                layer.msg('删除成功', {icon: 6, time: 1000});
                                $(_this).parent().remove();
                            } else {
                                layer.msg('删除失败', {icon: 2, time: 1000});
                            }
                        }
                    })
                });
            });

            // 初始化页面操作权限
            function initAuthority() {
                // 是否设置页面权限
                if (authorityObject) {
                    // 检查新增权限
                    if (authorityObject['01']) {
                        $('#addPlan').show();
                    }

                    // 检查编辑权限
                    if (authorityObject['05']) {
                        $('#editPlan').show();
                    }

                    // 检查删除权限
                    if (authorityObject['04']) {
                        $('#delPlan').show();
                    }
                }
            }

            // 初始化内容高度
            function resizeSize() {
                var height = $(window).height()
                $('#leftHeight').height(height - 80)
            }

		</script>
	</body>
</html>
