var user_id = ''
var dept_id = ''

var globalInfo = {}

var dictionaryObj = {PLAN_TYPE: {}, PLAN_PHASE: {}, PLAN_RATE: {}, PLAN_LEVEL: {}, CONTROL_LEVEL: {}, ACCORDING: {}, PLAN_SYCLE: {}, TASK_TYPE: {}}
var dictionaryStr = 'PLAN_TYPE,PLAN_PHASE,PLAN_RATE,PLAN_LEVEL,CONTROL_LEVEL,ACCORDING,PLAN_SYCLE,TASK_TYPE'

// 获取数据字典数据
$.get('/Dictonary/selectDictionaryByDictNos', {dictNos: dictionaryStr}, function(res){
    if (res.flag) {
        for (var dict in dictionaryObj) {
            dictionaryObj[dict] = {object: {}, str: ''}
            if (res.object[dict]) {
                res.object[dict].forEach(function(item){
                    dictionaryObj[dict]['object'][item.dictNo] = item.dictName
                    dictionaryObj[dict]['str'] += '<option value=' + item.dictNo + '>' + item.dictName + '</option>'
                })
            }
        }
    }
})

layui.use(['table', 'layer', 'form', 'element', 'laydate', 'upload', 'eleTree'], function () {
    var table = layui.table,
        form = layui.form,
        layer = layui.layer,
        laydate = layui.laydate,
        upload = layui.upload,
        eleTree = layui.eleTree,
        element = layui.element;

    var eTree = null,
        taskTable = null;
    form.render();

    // 获取左侧项目列表信息
    $.get('/ProjectInfo/queryProjectInfo', function (res) {
        if (res.flag && res.obj.length > 0) {
            var str = ''
            res.obj.forEach(function (project) {
                str += '<li class="left_List_item" title="' + project.projectName + '" projectId="' + project.projectId + '">' + project.projectName + '</li>'
            })
            var $str = $(str)
            $str.eq(0).addClass('select')
            $('.project_name').text($str.eq(0).text())
            globalInfo['projectId'] = $str.eq(0).attr('projectId')
            getTreeData(0, globalInfo['projectId'])
            $('#projectList').append($str)
        }
    })

    // 左侧项目列表点击事件
    $('#projectList').on('click', '.left_List_item', function () {
        var $this = $(this)
        $this.siblings().removeClass('select')
        $this.addClass('select')
        globalInfo = {}
        globalInfo['projectId'] = $this.attr('projectId')
        $('.project_name').text($this.text())
        getTreeData(0, globalInfo['projectId'])
        taskTable = null
        $('.mubiao').hide()
        $('#taskTable').siblings().remove()
    })

    // 选择部门
    $(document).on('click', '.choose_dept', function () {
        var chooseType = $(this).attr('choosetype') == 1 ? '?0' : ''
        dept_id = $(this).parent().attr('deptid')
        $.popWindow("../common/selectDept" + chooseType);
    })
    // 清空部门
    $(document).on('click', '.clear_dept', function () {
        var deptId = $(this).parent().attr('deptid')
        $('#' + deptId).val('')
        $('#' + deptId).attr('deptid', '')
    })

    // 选择用户
    $(document).on('click', '.choose_user', function () {
        var chooseType = $(this).attr('choosetype') == 1 ? '?0' : ''
        user_id = $(this).parent().attr('userid');
        $.ajax({
            url: '/imfriends/getIsFriends',
            type: 'get',
            dataType: 'json',
            data: {},
            success: function (obj) {
                if (obj.object == 1) {
                    $.popWindow("../common/selectUserIMAddGroup" + chooseType);
                } else {
                    $.popWindow("../common/selectUser" + chooseType);
                }
            },
            error: function (res) {
                $.popWindow("../common/selectUser" + chooseType);
            }
        })
    })
    // 清空用户
    $(document).on('click', '.clear_user', function () {
        var userId = $(this).parent().attr('userid')
        $('#' + userId).val('')
        $('#' + userId).attr('user_id', '')
    })

    // 删除附件
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
    })

    // 获取树数据
    function getTreeData(parentId, projectId) {

        // 渲染树
        if (!eTree) {
            eTree = eleTree.render({
                elem: '.project_tree',
                showLine: true, // 显示连接线
                url: '/plcProjectBag/query',
                lazy: true, // 开启懒加载
                //expandOnClickNode: false, // 禁止点击节点关闭显示子节点
                highlightCurrent: true, // 选中高亮
                where: {
                    projectId: projectId,
                    parentPbagId: parentId
                },
                request: { // 修改数据为组件需要的数据
                    name: "pbagName", // 显示的内容
                    key: "pbagId", // 节点id
                    parentId: 'parentPbagId', // 节点父id
                    isLeaf: "isLeaf" // 是否有子节点
                },
                response: { // 修改响应数据为组件需要的数据
                    statusName: "flag",
                    statusCode: true,
                    dataName: "obj"
                },
                load: function (data, callback) { // 懒加载方法
                    $.post('/plcProjectBag/query?parentPbagId=' + data.pbagId + '&projectId=' + projectId, function (res) {
                        callback(res.obj);//点击节点回调
                    })
                }
            })
        } else {
            eTree.reload({
                where: {
                    projectId: projectId,
                    parentPbagId: parentId
                },
                load: function (data, callback) { // 懒加载方法
                    $.post('/plcProjectBag/query?parentPbagId=' + data.pbagId + '&projectId=' + projectId, function (res) {
                        callback(res.obj); // 点击节点回调
                    })
                }
            })
        }

    }

    // 树节点点击事件
    eleTree.on("nodeClick(projectData)", function (d) {
        // console.log(d.data.currentData)
        $('.mubiao').show()
        globalInfo['projectId'] = d.data.currentData.projectId
        globalInfo['pbagId'] = d.data.currentData.pbagId
        initTaskTable(globalInfo['projectId'], d.data.currentData.pbagId)
    })

    // 监听-任务表格-工具条
    table.on('tool(taskTable)', function (obj) {
        var tData = obj.data;
        var layEvent = obj.event;
        if (layEvent === 'detail') {
            creatTask(3, tData)
        } else if (layEvent === 'edit') {
            creatTask(2, tData)
        } else if (layEvent === 'del') {
            layer.confirm('确定删除当前数据?', function (index) {
                $.post('/plcProjectItem/delete', {planItemId: tData.planItemId}, function (res) {
                    if (res.flag) {
                        taskTable.reload({
                            url: '/plcProjectItem/query',
                            where: {
                                projectId: globalInfo['projectId'],
                                pbagId: globalInfo['pbagId'],
                                time: new Date().getTime(),
                                useFlag: true
                            },
                            page: {
                                curr: 1
                            }
                        })
                        obj.del()
                        layer.close(index)
                        layer.msg('删除成功', {icon: 1})
                    } else {
                        layer.msg('删除失败', {icon: 2})
                    }
                })
            })
        }
    })

    // 监听-任务表格-头部工具
    table.on('toolbar(taskTable)', function (obj) {
        switch (obj.event) {
            case 'add':
                creatTask(1)
                break;
        }
    })

    // 初始化任务表格
    function initTaskTable(projectId, pBagId) {
        taskTable = table.render({
            elem: '#taskTable',
            url: '/plcProjectItem/query',
            page: true,
            toolbar: '#taskToolBar',
            defaultToolbar: [''],
            cols: [[ //表头
                {type:'checkbox'}
                ,{field: 'taskNo', title: '任务编码', minWidth: 90}
                , {field: 'taskName', title: '任务名称', minWidth: 90}
                , {field: 'dutyUserName', title: '责任人', minWidth: 90}
                , {field: 'assistUserName', title: '协作人(多人)', minWidth: 110}
                , {field: 'mainCenterDeptName', title: '所属部门', minWidth: 120}
                , {field: 'mainAreaDeptName', title: '一级监督部门', minWidth: 120}
                , {field: 'mainProjectDeptName', title: '二级监督部门', minWidth: 120}
                , {field: 'assistCompanyDeptsName', title: '协助部门', minWidth: 120}
                , {
                    field: 'planType', title: '计划类型', minWidth: 90, templet: function (d) {
                        var object = dictionaryObj['PLAN_TYPE']['object']
                        return object[d.planType] ? object[d.planType] : ''
                    }
                }
                , {
                    field: 'planStage', title: '计划阶段', minWidth: 90, templet: function (d) {
                        var object = dictionaryObj['PLAN_PHASE']['object']
                        return object[d.planStage] ? object[d.planStage] : ''
                    }
                }
                , {
                    field: 'planRate', title: '计划形式', minWidth: 90, templet: function (d) {
                        var object = dictionaryObj['PLAN_RATE']['object']
                        return object[d.planRate] ? object[d.planRate] : ''
                    }
                }
                , {
                    field: 'planLevel', title: '计划级次', minWidth: 90, templet: function (d) {
                        var object = dictionaryObj['PLAN_LEVEL']['object']
                        return object[d.planLevel] ? object[d.planLevel] : ''
                    }
                }, {
                    field: 'controlLevel', title: '关注等级', minWidth: 90, templet: function (d) {
                        var object = dictionaryObj['CONTROL_LEVEL']['object']
                        return object[d.controlLevel] ? object[d.controlLevel] : ''
                    }
                }
                , {
                    field: 'according', title: '工作项依据', minWidth: 100, templet: function (d) {
                        var object = dictionaryObj['ACCORDING']['object']
                        return object[d.according] ? object[d.according] : ''
                    }
                }
                , {
                    field: 'isKeypoint', title: '是否关键工作项', minWidth: 130, templet: function (d) {
                        if (d.isKeypoint == 0) {
                            return '否'
                        } else if (d.isKeypoint == 1) {
                            return '是'
                        }
                    }
                }
                , {
                    field: 'isExam', title: '是否考核', minWidth: 90, templet: function (d) {
                        if (d.isExam == 0) {
                            return '否'
                        } else if (d.isExam == 1) {
                            return '是'
                        }
                    }
                }
                , {
                    field: 'isResult', title: '是否提交成果', minWidth: 120, templet: function (d) {
                        if (d.isResult == 0) {
                            return '否'
                        } else if (d.isResult == 1) {
                            return '是'
                        }
                    }
                }
                , {
                    field: 'planSycle', title: '周期类型', minWidth: 90, templet: function (d) {
                        var object = dictionaryObj['PLAN_SYCLE']['object']
                        return object[d.planSycle] ? object[d.planSycle] : ''
                    }
                }
                , {
                    field: 'planStartDate', title: '计划开始时间', minWidth: 120, templet: function (d) {
                        return format(d.planStartDate)
                    }
                }
                , {
                    field: 'planEndDate', title: '计划完成时间', minWidth: 120, templet: function (d) {
                        return format(d.planEndDate)
                    }
                }
                , {field: 'planContinuedDate', title: '计划工期', minWidth: 90}
                , {
                    field: 'realStartDate', title: '实际开始时间', minWidth: 120, templet: function (d) {
                        return format(d.realStartDate)
                    }
                }
                , {
                    field: 'realEndDate', title: '实际完成时间', minWidth: 120, templet: function (d) {
                        return format(d.realEndDate)
                    }
                }
                , {field: 'realContinuedDate', title: '实际工期', minWidth: 90}
                , {field: 'standardDegree', title: '标准难度系数', minWidth: 90}
                , {field: 'hardDegree', title: '难度系数', minWidth: 90}
                , {field: 'resultConfirm', title: '成果确认', minWidth: 90}
                , {field: 'resultDesc', title: '成果描述', minWidth: 90}
                , {field: 'finalResultDesc', title: '最终交付成果描述', minWidth: 150}
                , {field: 'unusualRes', title: '异常原因', minWidth: 90}
                , {field: 'unusualStuff', title: '异常支撑材料', minWidth: 120}
                , {field: 'qualityScore', title: '质量得分', minWidth: 90}
                , {field: 'taskStatus', title: '任务状态', minWidth: 90}
                , {field: 'taskPrecess', title: '任务进度', minWidth: 90}
                , {
                    field: 'taskType', title: '任务类型', minWidth: 90, templet: function (d) {
                        var object = dictionaryObj['TASK_TYPE']['object']
                        return object[d.taskType] ? object[d.taskType] : ''
                    }
                }
                , {field: 'taskDesc', title: '任务说明', minWidth: 90}
                , {field: 'riskPoint', title: '风险点', minWidth: 80}
                , {field: 'difficultPoint', title: '难度点', minWidth: 80}
                , {
                    field: 'openNextTask', title: '是否开放下级任务', minWidth: 145, templet: function (d) {
                        if (d.isKeypoint == 0) {
                            return '否'
                        } else if (d.isKeypoint == 1) {
                            return '是'
                        }
                    }
                }
                , {field: 'endScore', title: '最终得分', minWidth: 90}
                , {field: 'itemQuantity', title: '工程量', minWidth: 90}
                , {field: 'itemQuantityNuit', title: '工程量单位', minWidth: 110}
                // , {fixed: 'right', title: '操作', align: 'center', toolbar: '#taskBar', minWidth: 170}
            ]],
            where: {
                projectId: projectId,
                pbagId: pBagId,
                useFlag: true,
                time: new Date().getTime()
            },
            request: {
                limitName: 'pageSize'
            },
            response: {
                statusName: 'flag',
                statusCode: true,
                dataName: 'obj',
                countName: 'totleNum'
            }
        })
    }

    // 目标-查看、新增、编辑-共用方法
    function creatTask(type, tData) {
        var title = '',
            disabled = '',
            url = '';
        switch (type) {
            case 1:
                title = '添加任务'
                url = '/plcProjectItem/add'
                break;
            case 2:
                title = '编辑任务'
                url = '/plcProjectItem/update'
                break;
            case 3:
                title = '查看任务'
                disabled = 'disabled'
                break;
            default:
                return false
                break;
        }

        var taskLayer = layer.open({
            type: 1,
            title: title,
            area: ['100%', '100%'],
            maxmin: true,
            min: function () {
                $('.layui-layer-shade').hide()
            },
            btn: ['保存', '取消'],
            btnAlign: 'c',
            content: '<div id="taskFormBox" style="padding: 30px 50px 0 30px;">\n' +
            '        <form class="layui-form" id="taskForm" lay-filter="taskForm">\n' +
            '            <div class="layui-row">\n' +
            '                <div class="layui-col-xs6" style="padding: 0 20px;">\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">任务编码</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input ' + disabled + ' type="text" name="taskNo" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">责任人</label>\n' +
            '                        <div class="layui-input-inline select_input">\n' +
            '                            <input type="text" readonly id="taskDutyUser" name="dutyUser" autocomplete="off" class="layui-input ' + disabled + ' user_input">\n' +
            '                        </div>\n' +
            '                        <div class="layui-form-mid layui-word-aux choose_' + disabled + '" userid="taskDutyUser">\n' +
            '                            <a href="javascript:;" class="choose_user" choosetype="1" style="color: blue;">添加</a>\n' +
            '                            <a href="javascript:;" class="clear_user" style="color: red">删除</a>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">所属部门</label>\n' +
            '                        <div class="layui-input-inline select_input">\n' +
            '                            <input type="text" readonly id="mainCenterDept" name="mainCenterDept" autocomplete="off" class="layui-input ' + disabled + ' dept_input">\n' +
            '                        </div>\n' +
            '                        <div class="layui-form-mid layui-word-aux choose_' + disabled + '" deptid="mainCenterDept">\n' +
            '                            <a href="javascript:;" class="choose_dept" choosetype="1" style="color: blue;">添加</a>\n' +
            '                            <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">一级监督部门</label>\n' +
            '                        <div class="layui-input-inline select_input">\n' +
            '                            <input type="text" readonly id="mainAreaDept" name="mainAreaDept" autocomplete="off" class="layui-input ' + disabled + ' dept_input">\n' +
            '                        </div>\n' +
            '                        <div class="layui-form-mid layui-word-aux choose_' + disabled + '" deptid="mainAreaDept">\n' +
            '                            <a href="javascript:;" class="choose_dept" choosetype="1" style="color: blue;">添加</a>\n' +
            '                            <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">计划类型</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <select id="planType" ' + disabled + ' name="planType" class="' + disabled + '" lay-verify="required">\n' +
            '                                <option value=""></option>\n' +
            '                            </select>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">周期类型</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <select id="planSycle" ' + disabled + ' name="planSycle" class="' + disabled + '" lay-verify="required">\n' +
            '                                <option value=""></option>\n' +
            '                            </select>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">任务类型</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <select id="taskType" ' + disabled + ' name="taskType" class="' + disabled + '" lay-verify="required">\n' +
            '                                <option value=""></option>\n' +
            '                            </select>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">计划阶段</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <select id="planStage" ' + disabled + ' name="planStage" class="' + disabled + '" lay-verify="required">\n' +
            '                                <option value=""></option>\n' +
            '                            </select>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">计划开始时间</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input type="text" id="taskPlanStartDate" ' + disabled + ' name="planStartDate" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">计划完成时间</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input type="text" id="taskPlanEndDate" ' + disabled + ' name="planEndDate" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">计划工期</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input ' + disabled + ' type="text" name="planContinuedDate" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">任务说明</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input ' + disabled + ' type="text" name="taskDesc" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">所属目标</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <select id="tgId" ' + disabled + ' name="tgId" class="' + disabled + '" lay-verify="required">\n' +
            '                                <option value=""></option>\n' +
            '                            </select>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">是否关键工作项</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input type="radio" ' + disabled + ' name="isKeypoint" value="1" title="是">\n' +
            '                            <input type="radio" ' + disabled + ' name="isKeypoint" value="0" title="否" checked>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">是否开放下级任务</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input type="radio" ' + disabled + ' name="openNextTask" value="1" title="是">\n' +
            '                            <input type="radio" ' + disabled + ' name="openNextTask" value="0" title="否" checked>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">是否提交成果</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input type="radio" ' + disabled + ' name="isResult" value="1" title="是">\n' +
            '                            <input type="radio" ' + disabled + ' name="isResult" value="0" title="否" checked>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">是否考核</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input type="radio" ' + disabled + ' name="isExam" value="1" title="是">\n' +
            '                            <input type="radio" ' + disabled + ' name="isExam" value="0" title="否" checked>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">标准难度系数</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input ' + disabled + ' type="text" name="standardDegree" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">难度系数</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input ' + disabled + ' type="text" name="hardDegree" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">成果确认</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input ' + disabled + ' type="text" name="resultConfirm" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">成果描述</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input ' + disabled + ' type="text" name="resultDesc" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">最终交付成果描述</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input ' + disabled + ' type="text" name="finalResultDesc" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '                <div class="layui-col-xs6" style="padding: 0 20px;">\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">任务名称</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input ' + disabled + ' type="text" name="taskName" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">协作人(多人)</label>\n' +
            '                        <div class="layui-input-inline select_input">\n' +
            '                            <input type="text" readonly id="assistUser" name="assistUser" autocomplete="off" class="layui-input ' + disabled + ' user_input">\n' +
            '                        </div>\n' +
            '                        <div class="layui-form-mid layui-word-aux choose_' + disabled + '" userid="assistUser">\n' +
            '                            <a href="javascript:;" class="choose_user" style="color: blue;">添加</a>\n' +
            '                            <a href="javascript:;" class="clear_user" style="color: red">删除</a>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">二级监督部门</label>\n' +
            '                        <div class="layui-input-inline select_input">\n' +
            '                            <input type="text" readonly id="mainProjectDept" name="mainProjectDept" autocomplete="off" class="layui-input ' + disabled + ' dept_input">\n' +
            '                        </div>\n' +
            '                        <div class="layui-form-mid layui-word-aux choose_' + disabled + '" deptid="mainProjectDept">\n' +
            '                            <a href="javascript:;" class="choose_dept" choosetype="1" style="color: blue;">添加</a>\n' +
            '                            <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">协助部门</label>\n' +
            '                        <div class="layui-input-inline select_input">\n' +
            '                            <input type="text" readonly id="assistCompanyDepts" name="assistCompanyDepts" autocomplete="off" class="layui-input ' + disabled + ' dept_input">\n' +
            '                        </div>\n' +
            '                        <div class="layui-form-mid layui-word-aux choose_' + disabled + '" deptid="assistCompanyDepts">\n' +
            '                            <a href="javascript:;" class="choose_dept" choosetype="0" style="color: blue;">添加</a>\n' +
            '                            <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">计划形式</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <select id="planRate" ' + disabled + ' name="planRate" class="' + disabled + '" lay-verify="required">\n' +
            '                                <option value=""></option>\n' +
            '                            </select>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">计划级次</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <select id="planLevel" ' + disabled + ' name="planLevel" class="' + disabled + '" lay-verify="required">\n' +
            '                                <option value=""></option>\n' +
            '                            </select>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">工作项依据</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <select id="according" ' + disabled + ' name="according" class="' + disabled + '" lay-verify="required">\n' +
            '                                <option value=""></option>\n' +
            '                            </select>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">关注等级</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <select id="controlLevel" ' + disabled + ' name="controlLevel" class="' + disabled + '" lay-verify="required">\n' +
            '                                <option value=""></option>\n' +
            '                            </select>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">实际开始时间</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input type="text" id="taskRealStartDate" ' + disabled + ' name="realStartDate" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">实际完成时间</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input type="text" id="taskRealEndDate" ' + disabled + ' name="realEndDate" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">实际工期</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input ' + disabled + ' type="text" name="realContinuedDate" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">任务状态</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input ' + disabled + ' type="text" name="taskStatus" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">任务进度</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input ' + disabled + ' type="text" name="taskPrecess" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">风险点</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input ' + disabled + ' type="text" name="riskPoint" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">难度点</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input ' + disabled + ' type="text" name="difficultPoint" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">质量得分</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input ' + disabled + ' type="text" name="qualityScore" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">最终得分</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input ' + disabled + ' type="text" name="endScore" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">工程量</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input ' + disabled + ' type="text" name="itemQuantity" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">工程量单位</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input ' + disabled + ' type="text" name="itemQuantityNuit" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">异常原因</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input ' + disabled + ' type="text" name="unusualRes" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item">\n' +
            '                        <label class="layui-form-label">异常支撑材料</label>\n' +
            '                        <div class="layui-input-block">\n' +
            '                            <input ' + disabled + ' type="text" name="unusualStuff" autocomplete="off" class="layui-input ' + disabled + '">\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item" style="height: auto">\n' +
            '                        <div id="taskFiles" style="padding-left: 160px;"></div>\n' +
            '                        <label class="layui-form-label">任务文件：</label>\n' +
            '                        <div class="layui-input-block" id="taskFileBox">\n' +
            '                        <button type="button" class="layui-btn layui-btn-primary" id="uploadTaskFile" style="border: 0px;color:#3870d7;padding: 0;"><img src="/img/icon_uplod.png" style="margin-right: 5px;"><i style="display: none" class="layui-icon"></i>附件上传</button>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="layui-form-item" style="height: auto">\n' +
            '                        <div id="resultFiles" style="padding-left: 160px;"></div>\n' +
            '                        <label class="layui-form-label">成果文件：</label>\n' +
            '                        <div class="layui-input-block" id="resultFileBox">\n' +
            '                        <button type="button" class="layui-btn layui-btn-primary" id="uploadResultFile" style="border: 0px;color:#3870d7;padding: 0;"><img src="/img/icon_uplod.png" style="margin-right: 5px;"><i style="display: none" class="layui-icon"></i>附件上传</button>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '        </form>\n' +
            '    </div>',
            success: function () {

                $('#planType').append(dictionaryObj['PLAN_TYPE']['str'])
                $('#planSycle').append(dictionaryObj['PLAN_SYCLE']['str'])
                $('#taskType').append(dictionaryObj['TASK_TYPE']['str'])
                $('#planStage').append(dictionaryObj['PLAN_PHASE']['str'])
                $('#planRate').append(dictionaryObj['PLAN_RATE']['str'])
                $('#planLevel').append(dictionaryObj['PLAN_LEVEL']['str'])
                $('#according').append(dictionaryObj['ACCORDING']['str'])
                $('#controlLevel').append(dictionaryObj['CONTROL_LEVEL']['str'])

                // 获取目标
                $.ajax({
                    url: '/projectTarget/getDropDown?pbagId=' + globalInfo['pbagId'],
                    type: 'GET',
                    datatype: 'JSON',
                    async: false,
                    success: function(res) {
                        if (res.flag && res.obj.length > 0) {
                            var str = ''
                            res.obj.forEach(function (item) {
                                str += '<option value="' + item.tgId + '">' + item.tgName + '</option>'
                            })
                            $('#tgId').append(str)
                        }
                        form.render()
                    }
                })

                // 处理时间显示
                // 计划开始时间
                laydate.render({
                    elem: '#taskPlanStartDate',
                    value: tData && tData.planStartDate ? new Date(tData.planStartDate) : ''
                })

                // 计划完成时间
                laydate.render({
                    elem: '#taskPlanEndDate',
                    value: tData && tData.planEndDate ? new Date(tData.planEndDate) : ''
                })

                // 实际开始时间
                laydate.render({
                    elem: '#taskRealStartDate',
                    value: tData && tData.realStartDate ? new Date(tData.realStartDate) : ''
                })

                // 实际完成时间
                laydate.render({
                    elem: '#taskRealEndDate',
                    value: tData && tData.realEndDate ? new Date(tData.realEndDate) : ''
                })

                if (type !== 1) {
                    form.val("taskForm", tData)

                    // 处理责任人显示
                    $('#taskDutyUser').val(tData ? tData.dutyUserName : '')
                    $('#taskDutyUser').attr('user_id', tData ? tData.dutyUser : '')

                    // 处理主责中心部门显示
                    $('#mainCenterDept').val(tData ? tData.mainCenterDeptName : '')
                    $('#mainCenterDept').attr('deptid', tData ? tData.mainCenterDept : '')

                    // 处理主责中心部门责任人显示
                    $('#mainCenterDeptUser').val(tData ? tData.mainCenterDeptUserName : '')
                    $('#mainCenterDeptUser').attr('user_id', tData ? tData.mainCenterDeptUser : '')

                    // 处理主责区域部门显示
                    $('#mainAreaDept').val(tData ? tData.mainAreaDeptName : '')
                    $('#mainAreaDept').attr('deptid', tData ? tData.mainAreaDept : '')

                    // 处理主责区域部门责任人显示
                    $('#mainAreaDeptUser').val(tData ? tData.mainAreaDeptUserName : '')
                    $('#mainAreaDeptUser').attr('user_id', tData ? tData.mainAreaDeptUser : '')

                    // 处理协作人(多人)显示
                    $('#assistUser').val(tData ? tData.assistUserName : '')
                    $('#assistUser').attr('user_id', tData ? tData.assistUser : '')

                    // 处理主责项目部门显示
                    $('#mainProjectDept').val(tData ? tData.mainProjectDeptName : '')
                    $('#mainProjectDept').attr('deptid', tData ? tData.mainProjectDept : '')

                    // 处理主责项目部门责任人显示
                    $('#mainProjectDeptUser').val(tData ? tData.mainProjectDeptUserName : '')
                    $('#mainProjectDeptUser').attr('user_id', tData ? tData.mainProjectDeptUser : '')

                    // 处理公司协助部门显示
                    $('#assistCompanyDepts').val(tData ? tData.assistCompanyDepts : '')
                    $('#assistCompanyDepts').attr('deptid', tData ? tData.assistCompanyDepts : '')

                    // 处理区域协助部门显示
                    $('#assistAreaDepts').val(tData ? tData.assistCompanyDeptsName : '')
                    $('#assistAreaDepts').attr('deptid', tData ? tData.assistAreaDepts : '')

                    // 处理附件显示
                    var taskAttachments = tData ? tData.attachments || [] : []
                    var taskFileStr = ''
                    if (taskAttachments.length > 0) {
                        taskAttachments.forEach(function (attachment) {
                            var fileExtension = attachment.attachName.substring(attachment.attachName.lastIndexOf(".") + 1, attachment.attachName.length)//截取附件文件后缀
                            var attName = encodeURI(attachment.attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6")
                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."))
                            var deUrl = attachment.attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + attachment.size
                            taskFileStr += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + attachment.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + attachment.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="' + attachment.attachName + '" class="inHidden" value="' + attachment.aid + '@' + attachment.ym + '_' + attachment.attachId + ',"></div>'
                        })
                    }

                    var resultAttachments = tData ? tData.attachments2 || [] : []
                    var resultFileStr = ''
                    if (resultAttachments.length > 0) {
                        resultAttachments.forEach(function (attachment) {
                            var fileExtension = attachment.attachName.substring(attachment.attachName.lastIndexOf(".") + 1, attachment.attachName.length)//截取附件文件后缀
                            var attName = encodeURI(attachment.attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6")
                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."))
                            var deUrl = attachment.attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + attachment.size
                            resultFileStr += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + attachment.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + attachment.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="' + attachment.attachName + '" class="inHidden" value="' + attachment.aid + '@' + attachment.ym + '_' + attachment.attachId + ',"></div>'
                        })
                    }

                    if (type === 2) {
                        $('#taskFiles').html(taskFileStr)
                        $('#resultFiles').html(resultFileStr)
                    } else {
                        $('#taskFileBox').html(taskFileStr)
                        $('#resultFileBox').html(resultFileStr)
                    }
                }

                $('.layui-disabled').attr('placeholder', '').css('color', '#222')

                // 任务文件上传
                upload.render({
                    elem: '#uploadTaskFile'
                    , url: '/upload?module=plancheck' //上传接口
                    , accept: 'file' //普通文件
                    , done: function (res) {
                        var data = res.obj[0];

                        var fileExtension = data.attachName.substring(data.attachName.lastIndexOf(".") + 1, data.attachName.length);//截取附件文件后缀
                        var attName = encodeURI(data.attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                        var deUrl = data.attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + data.size;
                        var str = '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + data.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + data.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="' + data.attachName + '" class="inHidden" value="' + data.aid + '@' + data.ym + '_' + data.attachId + ',"></div>';

                        $('#taskFiles').append(str);

                        layer.msg('上传成功', {icon: 6});
                    }
                })

                // 成果文件上传
                upload.render({
                    elem: '#uploadResultFile'
                    , url: '/upload?module=plancheck' //上传接口
                    , accept: 'file' //普通文件
                    , done: function (res) {
                        var data = res.obj[0];

                        var fileExtension = data.attachName.substring(data.attachName.lastIndexOf(".") + 1, data.attachName.length);//截取附件文件后缀
                        var attName = encodeURI(data.attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                        var deUrl = data.attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + data.size;
                        var str = '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + data.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + data.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="' + data.attachName + '" class="inHidden" value="' + data.aid + '@' + data.ym + '_' + data.attachId + ',"></div>';

                        $('#resultFiles').append(str);

                        layer.msg('上传成功', {icon: 6});
                    }
                })

            },
            yes: function () {
                var data = {}

                if (type === 3) {
                    layer.close(taskLayer)
                    return false
                } else if (type === 2) {
                    data['planItemId'] = tData.planItemId
                } else {
                    data['projectId'] = globalInfo['projectId']
                    data['pbagId'] = globalInfo['pbagId']
                }

                var dataEle = $('#taskForm [name]').serializeArray()
                $.each(dataEle, function () {
                    data[this.name] = this.value
                })

                var attachmentId = ''
                var attachmentName = ''

                var $taskAttachments = $('#taskFiles').find('input[type="hidden"]')
                $taskAttachments.each(function () {
                    attachmentId += $(this).val()
                    attachmentName += $(this).data('attachname') + '*'
                })

                var attachmentId2 = ''
                var attachmentName2 = ''

                var $resultAttachments = $('#resultFiles').find('input[type="hidden"]')
                $resultAttachments.each(function () {
                    attachmentId2 += $(this).val()
                    attachmentName2 += $(this).data('attachname') + '*'
                })

                data['dutyUser'] = $('#taskDutyUser').attr('user_id') || ''
                data['mainCenterDept'] = $('#mainCenterDept').attr('deptid') || ''
                data['mainAreaDept'] = $('#mainAreaDept').attr('deptid') || ''
                data['assistUser'] = $('#assistUser').attr('user_id') || ''
                data['mainProjectDept'] = $('#mainProjectDept').attr('deptid') || ''
                data['assistCompanyDepts'] = $('#assistCompanyDepts').attr('deptid') || ''

                data['attachmentId'] = attachmentId
                data['attachmentName'] = attachmentName

                data['standardDegree'] = parseInt(data['standardDegree'] || 0)
                data['taskPrecess'] = parseInt(data['taskPrecess'] || 0)

                $.post(url, data, function (res) {
                    if (res.flag) {
                        layer.msg('保存成功', {icon: 1})
                        layer.close(taskLayer)
                        taskTable.reload({
                            url: '/plcProjectItem/query',
                            where: {
                                projectId: globalInfo['projectId'],
                                pbagId: globalInfo['pbagId'],
                                time: new Date().getTime(),
                                useFlag: true
                            },
                            page: {
                                curr: 1
                            }
                        })
                    } else {
                        layer.msg('保存失败', {icon: 2})
                    }
                })
            }
        })
    }

})

//将毫秒数转为yyyy-MM-dd格式时间
function format(t) {
    if (t) {
        return new Date(t).Format("yyyy-MM-dd")
    } else {
        return ''
    }
}