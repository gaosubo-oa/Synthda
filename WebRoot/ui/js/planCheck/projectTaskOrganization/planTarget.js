var user_id = ''
var dept_id = ''

var globalInfo = {}
var form
//目标类型
var TG_TYPE_STR = ''
var TG_TYPE_OBJ = {}
//计划类型
var PLAN_TYPE_STR = ''
var PLAN_TYPE_OBJ = {}
//计划阶段数据
var PLAN_PHASE_STR = ''
var PLAN_PHASE_OBJ= {}
//计划形式数据
var PLAN_RATE_STR = ''
var PLAN_RATE_OBJ = {}
//计划级次数据
var PLAN_LEVEL_STR = ''
var PLAN_LEVEL_OBJ = {}
//工作项依据
var ACCORDING_STR = ''
var ACCORDING_OBJ = {}
//目标等级
var TG_GRADE_STR = ''
var TG_GRADE_OBJ = {}
//关注等级
var CONTROL_LEVEL_STR = ''
var CONTROL_LEVEL_OBJ = {}
//周期类型
var PLAN_SYCLE_STR = ''
var PLAN_SYCLE_OBJ = {}
//获取目标类型数据、计划类型数据、计划阶段数据、计划形式数据、计划级次数据、子项目类型数据、子项目层级数据、成本类型数据、子项目性质、子项目分类、工作项依据、目标等级、目标等级、周期类型
$.get('/Dictonary/selectDictionaryByDictNos?dictNos=TG_TYPE,PLAN_TYPE,PLAN_PHASE,PLAN_RATE,PLAN_LEVEL,PBAG_TYPE,PBAG_LEVEL,COST_TYPE,PBAG_NATURE,PBAG_CLASS,ACCORDING,TG_GRADE,CONTROL_LEVEL,PLAN_SYCLE', function(res) {
    var data=res.object
    //目标类型数据
    data.TG_TYPE.forEach(function(item) {
        TG_TYPE_STR += '<option value='+item.dictNo+'>'+item.dictName+'</option>'
        TG_TYPE_OBJ[item.dictNo] = item.dictName
    })
    //计划类型数据
    data.PLAN_TYPE.forEach(function(item) {
        PLAN_TYPE_STR += '<option value='+item.dictNo+'>'+item.dictName+'</option>'
        PLAN_TYPE_OBJ[item.dictNo] = item.dictName
    })
    //计划阶段数据
    data.PLAN_PHASE.forEach(function(item) {
        PLAN_PHASE_STR += '<option value='+item.dictNo+'>'+item.dictName+'</option>'
        PLAN_PHASE_OBJ[item.dictNo] = item.dictName
    })
    //计划形式数据
    data.PLAN_RATE.forEach(function(item) {
        PLAN_RATE_STR += '<option value='+item.dictNo+'>'+item.dictName+'</option>'
        PLAN_RATE_OBJ[item.dictNo] = item.dictName
    })
    //计划级次数据
    data.PLAN_LEVEL.forEach(function(item) {
        PLAN_LEVEL_STR += '<option value='+item.dictNo+'>'+item.dictName+'</option>'
        PLAN_LEVEL_OBJ[item.dictNo] = item.dictName
    })
    //工作项依据
    data.ACCORDING.forEach(function(item) {
        ACCORDING_STR += '<option value='+item.dictNo+'>'+item.dictName+'</option>'
        ACCORDING_OBJ[item.dictNo] = item.dictName
    })
    //目标等级
    data.TG_GRADE.forEach(function(item){
        TG_GRADE_STR += '<option value="'+item.dictNo+'">'+item.dictName+'</option>'
        TG_GRADE_OBJ[item.dictNo] = item.dictName
    })
    //关注等级
    data.CONTROL_LEVEL.forEach(function(item){
        CONTROL_LEVEL_STR += '<option value="'+item.dictNo+'">'+item.dictName+'</option>'
        CONTROL_LEVEL_OBJ[item.dictNo] = item.dictName
    })
    //周期类型
    data.PLAN_SYCLE.forEach(function(item){
        PLAN_SYCLE_STR += '<option value="'+item.dictNo+'">'+item.dictName+'</option>'
        PLAN_SYCLE_OBJ[item.dictNo] = item.dictName
    })
})
layui.use(['table','layer','form','element','eleTree','laydate', 'upload'], function(){
    var table = layui.table,
        eleTree = layui.eleTree,
        layer = layui.layer,
        laydate = layui.laydate,
        upload = layui.upload,
        element = layui.element,
        form = layui.form;
    var eTree = null
    var targetTable
    form.render();
    // initPBagForm()
    // initTargetTable()
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

    // 获取左侧项目列表信息
    $.get('/ProjectInfo/queryProjectInfo', function(res){
        if (res.flag && res.obj.length > 0) {
            var str = ''
            res.obj.forEach(function(project){
                str += '<li class="left_List_item" title="'+project.projectName+'" projectId="'+project.projectId+'">'+project.projectName+'</li>'
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
    $('#projectList').on('click', '.left_List_item', function(){
        var $this = $(this)
        $this.siblings().removeClass('select')
        $this.addClass('select')
        // initPBagForm()
        globalInfo = {}
        globalInfo['projectId'] = $this.attr('projectId')
        $('.project_name').text($this.text())
        getTreeData(0, globalInfo['projectId'])
    })

    // 选择部门
    $(document).on('click', '.choose_dept',function(){
        var chooseType = $(this).attr('choosetype') == 1 ? '?0' : ''
        dept_id = $(this).parent().attr('deptid')
        $.popWindow("../common/selectDept" + chooseType);
    })
    // 清空部门
    $(document).on('click', '.clear_dept', function(){
        var deptId = $(this).parent().attr('deptid')
        $('#'+deptId).val('')
        $('#'+deptId).attr('deptid','')
    })
    // 选择用户
    $(document).on('click', '.choose_user', function(){
        var chooseType = $(this).attr('choosetype') == 1 ? '?0' : ''
        user_id = $(this).parent().attr('userid');
        $.popWindow("../common/selectUserIMAddGroup" + chooseType);
       /* $.ajax({
            url:'/imfriends/getIsFriends',
            type:'get',
            dataType:'json',
            data:{},
            success:function(obj){
                if(obj.object == 1){
                    $.popWindow("../common/selectUserIMAddGroup" + chooseType);
                }else{
                    $.popWindow("../common/selectUser" + chooseType);
                }
            },
            error:function(res){
                $.popWindow("../common/selectUser" + chooseType);
            }
        })*/
    })
    // 清空用户
    $(document).on('click', '.clear_user', function(){
        var userId = $(this).parent().attr('userid')
        $('#'+userId).val('')
        $('#'+userId).attr('user_id','')
    })

    // 获取树数据
    function getTreeData (parentId, projectId) {
        // 自定义树节点右击显示操作
        var contextmenuList = [
            {eventName: "insertNodeBefore", text: "插入节点前"},
            {eventName: "insertNodeBehind", text: "插入节点后"},
            {eventName: "insertChildNode", text: "插入子节点"},
            {eventName: "removeNode", text: "删除"}
        ]
        // 渲染树
        if (!eTree) {
            eTree = eleTree.render({
                elem: '.project_tree',
                showLine: true, // 显示连接线
                url: '/plcProjectBag/query',
                lazy: true, // 开启懒加载
                //expandOnClickNode: false, // 禁止点击节点关闭显示子节点
                // contextmenuList: contextmenuList, // 节点右键操作
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
    eleTree.on("nodeClick(projectData)",function(d) {
        // console.log(d.data.currentData)
        $('.mubiao').show()
        globalInfo['projectId'] = d.data.currentData.projectId
        globalInfo['pbagId'] = d.data.currentData.pbagId
        globalInfo['isLeaf'] = d.data.currentData.isLeaf
        globalInfo['leaf'] = d.data.currentData.leaf
        globalInfo['pBagOptType'] = 2
        initTargetTable(globalInfo['projectId'], d.data.currentData.pbagId)
    })
    // 初始化目标表格
    function initTargetTable(projectId, pBagId) {
        targetTable = table.render({
            elem: '#targetTable',
            url: '/projectTarget/query',
            page: true,
            toolbar: '#toolbarDemo',
            defaultToolbar:[''],
            cols: [[ //表头
                {field: 'tgNo', title: '目标编号', minWidth: 110}
                ,{field: 'tgName', title: '目标名称', minWidth: 150}
                ,{field: 'parentTgId', title: '上级目标', minWidth: 90 }
                ,{field: 'tgType', title: '目标类型', minWidth: 110,templet:function (d) {
                        for (var key in TG_TYPE_OBJ) {
                            if (key == d.tgType) {
                                return TG_TYPE_OBJ[key]
                            }
                        }
                    }
                }
                ,{field: 'tgGrade', title: '目标等级', minWidth: 90,templet:function (d) {
                        for (var key in TG_GRADE_OBJ) {
                            if (key == d.tgGrade) {
                                return TG_GRADE_OBJ[key]
                            }
                        }
                    }}
                ,{field: 'tgDesc', title: '目标说明', minWidth: 90}
                ,{field: 'mainAreaDeptName', title: '一级监督部门', minWidth:150}
                ,{field: 'mainProjectDeptName', title: '二级监督部门', minWidth:150}
                ,{field: 'projectId', title: '所属项目名称', }
                ,{field: 'pbagId', title: '所属子项目名称', }
                ,{field: 'dutyUserName', title: '责任人', minWidth: 110}
                ,{field: 'assistUserName', title: '协作人', minWidth: 110}
                ,{field: 'mainCenterDeptName', title: '所属部门', minWidth:150}
                ,{field: 'assistCompanyDeptName', title: '协助部门', minWidth:150}
                ,{field: 'planType', title: '计划类型', minWidth: 110,templet:function (d) {
                        for (var key in PLAN_TYPE_OBJ) {
                            if (key == d.planType) {
                                return PLAN_TYPE_OBJ[key]
                            }
                        }
                    }}
                ,{field: 'planStage', title: '计划阶段', minWidth: 110,templet:function (d) {
                        for (var key in PLAN_PHASE_OBJ) {
                            if (key == d.planStage) {
                                return PLAN_PHASE_OBJ[key]
                            }
                        }
                    }}
                ,{field: 'planRate', title: '计划形式', minWidth: 110,templet:function (d) {
                        for (var key in PLAN_RATE_OBJ) {
                            if (key == d.planRate) {
                                return PLAN_RATE_OBJ[key]
                            }
                        }
                    }}
                ,{field: 'planLevel', title: '计划级次', minWidth: 110,templet:function (d) {
                        for (var key in PLAN_LEVEL_OBJ) {
                            if (key == d.planLevel) {
                                return PLAN_LEVEL_OBJ[key]
                            }
                        }
                    }}
                ,{field: 'controlLevel', title: '关注等级', minWidth: 110,templet:function (d) {
                        for (var key in CONTROL_LEVEL_OBJ) {
                            if (key == d.controlLevel) {
                                return CONTROL_LEVEL_OBJ[key]
                            }
                        }
                    }}
                ,{field: 'according', title: '工作项依据', minWidth: 110,templet:function (d) {
                        for (var key in ACCORDING_OBJ) {
                            if (key == d.according) {
                                return ACCORDING_OBJ[key]
                            }
                        }
                    }}
                ,{field: 'isKeypoint', title: '是否关键工作项', minWidth: 110, templet: function(d){
                        return d.isKeypoint === '1' ? '是' : '否'
                    }}
                ,{field: 'isExam', title: '是否考核', minWidth: 110, templet: function(d){
                        return d.isExam === '1' ? '是' : '否'
                    }}
                ,{field: 'isResult', title: '是否提交成果', minWidth: 110, templet: function(d){
                        return d.isResult === '1' ? '是' : '否'
                    }}
                ,{field: 'planSycle', title: '周期类型', minWidth: 110,templet:function (d) {
                        for (var key in PLAN_SYCLE_OBJ) {
                            if (key == d.planSycle) {
                                return PLAN_SYCLE_OBJ[key]
                            }
                        }
                    }}
                // ,{field: 'flowId', title: '审批流程', minWidth: 110}
                ,{field: 'planStartDate', title: '计划开始时间',minWidth:120,templet:function (d) {
                        return format(d.planStartDate)
                    }}
                ,{field: 'planEndDate', title: '计划完成时间',minWidth:120,templet:function (d) {
                        return format(d.planEndDate)
                    } }
                ,{field: 'planContinuedDate', title: '计划工期', minWidth: 110}
                ,{field: 'realStartDate', title: '实际开始时间',minWidth:120,templet:function (d) {
                        return format(d.realStartDate)
                    } }
                ,{field: 'realEndDate', title: '实际完成时间',minWidth:120,templet:function (d) {
                        return format(d.realEndDate)
                    } }
                ,{field: 'realContinuedDate', title: '实际工期', minWidth: 110}
                ,{field: 'standardDegree', title: '标准难度系数', minWidth: 110}
                ,{field: 'hardDegree', title: '难度系数', minWidth: 110}
                ,{field: 'resultConfirm', title: '成果确认', minWidth: 110}
                ,{field: 'resultDesc', title: '成果描述', minWidth: 110}
                ,{field: 'finalResultDesc', title: '最终交付成果描述', minWidth: 110}
                ,{field: 'unusualRes', title: '异常原因', minWidth: 110}
                ,{field: 'unusualStuff', title: '异常支撑材料', minWidth: 110}
                ,{field: 'qualityScore', title: '质量得分', minWidth: 110}
                ,{field: 'taskStatus', title: '目标状态', minWidth: 110}
                ,{field: 'taskPrecess', title: '目标进度', minWidth: 110}
                ,{field: 'taskType', title: '目标类型', minWidth: 110}
                ,{field: 'taskDesc', title: '目标说明', minWidth: 110}
                ,{field: 'riskPoint', title: '风险点', minWidth: 110}
                ,{field: 'difficultPoint', title: '难度点', minWidth: 110}
                ,{field: 'openNextTask', title: '是否开放下级目标', minWidth: 110, templet: function(d){
                        return d.openNextTask === '1' ? '是' : '否'
                    }}
                ,{field: 'endScore', title: '最终得分', minWidth: 110}
                ,{field: 'resultStandard', title: '完成标准', minWidth: 110}
                ,{field: 'itemQuantity', title: '工程量', minWidth: 110}
                ,{field: 'itemQuantityNuit', title: '工程量单位', minWidth: 110}
                ,{fixed: 'right',title: '操作',align:'center', toolbar: '#targerBar', minWidth:170}
            ]],
            where: {
                projectId:projectId,
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
    //目标新建
    table.on('toolbar(targetTable)', function(obj){
        switch(obj.event){
            case 'add':
                creatTarget(1)
                break;
        };
    });
    // 监听-目标表格-工具条
    table.on('tool(targetTable)', function(obj){
        var tData = obj.data;
        var layEvent = obj.event;
        if(layEvent === 'detail'){
            creatTarget(3, tData)
        } else if (layEvent === 'edit') {
            creatTarget(2, tData)
        } else if(layEvent === 'del'){
            layer.confirm('确定删除当前数据?', function(index){
                $.post('/projectTarget/delete', {tgId: tData.tgId}, function(res){
                    if (res.flag) {
                        targetTable.reload({
                            url: '/projectTarget/query',
                            where: {
                                projectId: tData.projectId,
                                pbagId: tData.pbagId,
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

    // 目标-查看、新增、编辑-共用方法
    function creatTarget(type, tData) {
        var title = '',
            disabled = '',
            url = '';
        if (type === 1) {
            title='添加目标'
            url='/projectTarget/add'
        } else if (type === 2) {
            title='编辑目标'
            url='/projectTarget/update'
        } else if (type === 3) {
            title='查看目标'
            disabled = 'disabled'
        } else {
            return false
        }

        var targetLayer = layer.open({
            type: 1,
            title: title,
            area: ['100%', '100%'],
            maxmin:true,
            min: function(){
                $('.layui-layer-shade').hide()
            },
            btn:['确定','取消'],
            btnAlign: 'c',
            content:'<form id="targetForm" lay-filter="targetForm" style="padding: 30px 50px 0 30px;"class="layui-form">\n' +
                '                                    <div class="layui-row">\n' +
                '                                        <div class="layui-col-xs6">\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">目标编号:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+'  type="text" name="tgNo" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">目标名称:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="tgName" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">上级目标:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="parentTgId" placeholder="请输入" autocomplete="off" class="layui-input  '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">目标类型:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                     <select id="tgType" '+disabled+'  name="tgType" lay-verify="required" >' +
                '                                                         <option value=""></option>\n' +
                '                                                     </select>\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">目标等级:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <select id="tgGrade" '+disabled+' name="tgGrade" lay-verify="required">\n' +
                '                                                        <option value=""></option>\n' +
                '                                                    </select>\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">目标说明:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="tgDesc" placeholder="请输入" autocomplete="off" class="layui-input  '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">一级监督部门:</label>\n' +
                '                                                <div class="layui-input-inline">\n' +
                '                                                    <input '+disabled+' type="text" readonly id="mainAreaDept" name="mainAreaDept" autocomplete="off" class="layui-input dept_input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                                <div class="layui-form-mid layui-word-aux choose_'+disabled+'" deptid="mainAreaDept">\n' +
                '                                                    <a href="javascript:;" class="choose_dept" choosetype="2" style="color: blue;">添加</a>\n' +
                '                                                    <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">二级监督部门:</label>\n' +
                '                                                <div class="layui-input-inline">\n' +
                '                                                    <input '+disabled+' type="text" readonly id="mainProjectDept" name="mainProjectDept" autocomplete="off" class="layui-input dept_input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                                <div class="layui-form-mid layui-word-aux choose_'+disabled+'" deptid="mainProjectDept">\n' +
                '                                                    <a href="javascript:;" class="choose_dept" choosetype="2" style="color: blue;">添加</a>\n' +
                '                                                    <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
              /*  '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">所属项目:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="projectId" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">所属子项目:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="pbagId" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +*/
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">责任人:</label>\n' +
                '                                                <div class="layui-input-inline">\n' +
                '                                                    <input '+disabled+' type="text" readonly id="dutyUser" name="dutyUser" autocomplete="off" class="layui-input  user_input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                                <div class="layui-form-mid layui-word-aux choose_'+disabled+'" userid="dutyUser">\n' +
                '                                                    <a href="javascript:;" class="choose_user" choosetype="1" style="color: blue;">添加</a>\n' +
                '                                                    <a href="javascript:;" class="clear_user" style="color: red">删除</a>\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">协作人:</label>\n' +
                '                                                <div class="layui-input-inline">\n' +
                '                                                    <input '+disabled+' type="text" readonly id="assistUser" name="assistUser" autocomplete="off" class="layui-input user_input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                                <div class="layui-form-mid layui-word-aux choose_'+disabled+'" userid="assistUser">\n' +
                '                                                    <a href="javascript:;" class="choose_user" choosetype="2" style="color: blue;">添加</a>\n' +
                '                                                    <a href="javascript:;" class="clear_user" style="color: red">删除</a>\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">所属部门:</label>\n' +
                '                                                <div class="layui-input-inline">\n' +
                '                                                    <input '+disabled+' type="text" readonly id="mainCenterDept" name="mainCenterDept" autocomplete="off" class="layui-input dept_input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                                <div class="layui-form-mid layui-word-aux choose_'+disabled+'" deptid="mainCenterDept">\n' +
                '                                                    <a href="javascript:;" class="choose_dept" choosetype="2" style="color: blue;">添加</a>\n' +
                '                                                    <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">协助部门:</label>\n' +
                '                                                <div class="layui-input-inline">\n' +
                '                                                    <input '+disabled+' type="text" readonly id="assistCompanyDepts" name="assistCompanyDepts" autocomplete="off" class="layui-input dept_input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                                <div class="layui-form-mid layui-word-aux choose_'+disabled+'" deptid="assistCompanyDepts">\n' +
                '                                                    <a href="javascript:;" class="choose_dept" choosetype="2" style="color: blue;">添加</a>\n' +
                '                                                    <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">计划类型:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <select '+disabled+' id="planType" name="planType" lay-verify="required">\n' +
                '                                                        <option value=""></option>\n' +
                '                                                    </select>\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">计划阶段:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <select '+disabled+' id="planStage" name="planStage" lay-verify="required">\n' +
                '                                                        <option value=""></option>\n' +
                '                                                    </select>\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">计划形式:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <select '+disabled+' id="planRate" name="planRate" lay-verify="required">\n' +
                '                                                        <option value=""></option>\n' +
                '                                                    </select>\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">计划级次:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <select '+disabled+' id="planLevel" name="planLevel" lay-verify="required">\n' +
                '                                                        <option value=""></option>\n' +
                '                                                    </select>\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">关注等级:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <select '+disabled+' id="controlLevel" name="controlLevel" lay-verify="required">\n' +
                '                                                        <option value=""></option>\n' +
                '                                                    </select>\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">工作项依据:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <select '+disabled+' id="according" name="according" lay-verify="required">\n' +
                '                                                        <option value=""></option>\n' +
                '                                                    </select>\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">是否关键工作项:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="radio" name="isKeypoint" value="1" title="是">\n' +
                '                                                    <input '+disabled+' type="radio" name="isKeypoint" value="0" title="否" checked>\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">是否考核:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="radio" name="isExam" value="1" title="是">\n' +
                '                                                    <input '+disabled+' type="radio" name="isExam" value="0" title="否" checked>\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">是否提交成果:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="radio" name="isResult" value="1" title="是">\n' +
                '                                                    <input '+disabled+' type="radio" name="isResult" value="0" title="否" checked>\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">周期类型:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <select '+disabled+' id="planSycle" name="planSycle" lay-verify="required">\n' +
                '                                                        <option value=""></option>\n' +
                '                                                    </select>\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">工作量单位:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="itemQuantityNuit" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-upload" style="height: auto">\n' +
                '                                                <div id="achievementsFile" style="padding-left: 160px;"></div>\n' +
                '                                                <label class="layui-form-label">成果文件:</label>\n' +
                                        '                        <div class="layui-input-block" id="achievementsFile_box">\n' +
                '                                                <button type="button" class="layui-btn layui-btn-primary " id="uploadAchievementsFile" style="border: 0px;color:#3870d7;padding: 0;"><img src="/img/icon_uplod.png" style="margin-right: 5px;"><i style="display: none" class="layui-icon"></i>附件上传</button>\n' +
                '                                            </div>\n' +
                '                                            </div>\n' +
                '                                        </div>\n' +
                '                                        <div class="layui-col-xs6">\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">计划开始时间:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="planStartDate" id="planStartDate"  autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">计划完成时间:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="planEndDate" id="planEndDate"  autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">计划工期:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="planContinuedDate" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">实际开始时间:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="realStartDate" id="realStartDate"  autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">实际完成时间:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="realEndDate" id="realEndDate" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">实际工期:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="realContinuedDate" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">标准难度系数:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="standardDegree" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">难度系数:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="hardDegree" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">成果确认:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="resultConfirm" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">成果描述:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="resultDesc" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">最终交付成果描述:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="finalResultDesc" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">异常原因:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="unusualRes" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">异常支撑材料:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="unusualStuff" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">质量得分:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="qualityScore" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">目标状态:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="taskStatus" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">目标进度:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="taskPrecess" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">目标说明:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="taskDesc" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">风险点:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="riskPoint" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">难度点:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="difficultPoint" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">是否开放下级目标:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="radio" name="openNextTask" value="1" title="是">\n' +
                '                                                    <input '+disabled+' type="radio" name="openNextTask" value="0" title="否" checked>\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">最终得分:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="endScore" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">完成标准:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="resultStandard" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-form-item">\n' +
                '                                                <label class="layui-form-label">工程量:</label>\n' +
                '                                                <div class="layui-input-block">\n' +
                '                                                    <input '+disabled+' type="text" name="itemQuantity" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                                                </div>\n' +
                '                                            </div>\n' +
                '                                            <div class="layui-upload" style="height: auto">\n' +
                '                                                <div id="targetFile" style="padding-left: 160px;"></div>\n' +
                '                                                <label class="layui-form-label">目标文件:</label>\n' +
                                        '                        <div class="layui-input-block" id="targetFile_box">\n' +
                '                                                <button type="button" class="layui-btn layui-btn-primary " id="uploadTargetFile" style="border: 0px;color:#3870d7;padding: 0;"><img src="/img/icon_uplod.png" style="margin-right: 5px;"><i style="display: none" class="layui-icon"></i>附件上传</button>\n' +
                '                                            </div>\n' +
                '                                            </div>\n' +
                '                                        </div>\n' +
                '                                    </div>\n' +
                '                                </form>',
            success:function () {
                $('#tgType').append(TG_TYPE_STR)
                $('#tgGrade').append(TG_GRADE_STR)
                $('#planType').append(PLAN_TYPE_STR)
                $('#planStage').append(PLAN_PHASE_STR)
                $('#planRate').append(PLAN_RATE_STR)
                $('#planLevel').append(PLAN_LEVEL_STR)
                $('#controlLevel').append(CONTROL_LEVEL_STR)
                $('#according').append(ACCORDING_STR)
                $('#planSycle').append(PLAN_SYCLE_STR)
                form.render()
                // 处理时间显示
                // 计划开始时间
                laydate.render({
                    elem: '#planStartDate',
                    value: tData && tData.planStartDate ? new Date(tData.planStartDate) : ''
                })
                // 计划完成时间
                laydate.render({
                    elem: '#planEndDate',
                    value: tData && tData.planEndDate ? new Date(tData.planEndDate) : ''
                })
                // 实际开始时间
                laydate.render({
                    elem: '#realStartDate',
                    value: tData && tData.realStartDate ? new Date(tData.realStartDate) : ''
                })
                // 实际完成时间
                laydate.render({
                    elem: '#realEndDate',
                    value: tData && tData.realEndDate ? new Date(tData.realEndDate) : ''
                })
                if (type !== 1) {
                    form.val("targetForm", tData)
                    // 处理一级监督部门显示
                    $('#mainAreaDept').val(tData ? tData.mainAreaDeptName : '')
                    $('#mainAreaDept').attr('deptid', tData ? tData.mainAreaDept : '')
                    // 处理二级监督部门显示
                    $('#mainProjectDept').val(tData ? tData.mainProjectDeptName : '')
                    $('#mainProjectDept').attr('deptid', tData ? tData.mainProjectDept : '')
                    // 处理责任人显示
                    $('#dutyUser').val(tData ? tData.dutyUserName : '')
                    $('#dutyUser').attr('user_id', tData ? tData.dutyUser : '')
                    // 处理协作人显示
                    $('#assistUser').val(tData ? tData.assistUserName : '')
                    $('#assistUser').attr('user_id', tData ? tData.assistUser : '')
                    // 处理所属部门显示
                    $('#mainCenterDept').val(tData ? tData.mainCenterDeptName : '')
                    $('#mainCenterDept').attr('deptid', tData ? tData.mainCenterDept : '')
                    // 处理协助部门显示
                    $('#assistCompanyDepts').val(tData ? tData.assistCompanyDeptName : '')
                    $('#assistCompanyDepts').attr('deptid', tData ? tData.assistCompanyDepts : '')

                    // 处理目标文件显示
                    var targetAttachments = tData ? tData.attachments || [] : []
                    var targetFileStr = ''
                    if (targetAttachments.length > 0) {
                        targetAttachments.forEach(function(attachment){
                            var fileExtension=attachment.attachName.substring(attachment.attachName.lastIndexOf(".")+1,attachment.attachName.length)//截取附件文件后缀
                            var attName = encodeURI(attachment.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6")
                            var fileExtensionName=attName.substring(0,attName.lastIndexOf("."))
                            var deUrl = attachment.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+attachment.size
                            targetFileStr += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + attachment.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + attachment.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="'+attachment.attachName+'" class="inHidden" value="' + attachment.aid + '@' + attachment.ym + '_' + attachment.attachId + ',"></div>'
                        })
                    }
                    // 处理成果文件显示
                    var achievementsAttachments = tData ? tData.attachments || [] : []
                    var achievementsFileStr = ''
                    if (achievementsAttachments.length > 0) {
                        achievementsAttachments.forEach(function(attachment){
                            var fileExtension=attachment.attachName.substring(attachment.attachName.lastIndexOf(".")+1,attachment.attachName.length)//截取附件文件后缀
                            var attName = encodeURI(attachment.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6")
                            var fileExtensionName=attName.substring(0,attName.lastIndexOf("."))
                            var deUrl = attachment.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+attachment.size
                            achievementsFileStr += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + attachment.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + attachment.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="'+attachment.attachName+'" class="inHidden" value="' + attachment.aid + '@' + attachment.ym + '_' + attachment.attachId + ',"></div>'
                        })
                    }
                    if (type === 2) {
                        $('#targetFile').html(targetFileStr)
                        $('#achievementsFile').html(achievementsFileStr)
                    } else {
                        $('.layui-layer-btn').hide()
                        $('#targetFile_box').html(targetFileStr)
                        $('#achievementsFile_box').html(achievementsFileStr)
                        $('.deImgs').hide()
                    }
                }
                $('.layui-disabled').attr('placeholder', '')
                //目标文件附件上传
                upload.render({
                    elem: '#uploadTargetFile'
                    ,url: '/upload?module=plancheck' //上传接口
                    ,accept: 'file' //普通文件
                    ,done: function(res){
                        var data=res.obj[0];

                        var fileExtension=data.attachName.substring(data.attachName.lastIndexOf(".")+1,data.attachName.length);//截取附件文件后缀
                        var attName = encodeURI(data.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                        var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                        var deUrl = data.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data.size;
                        var str = '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + data.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + data.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="'+data.attachName+'" class="inHidden" value="' + data.aid + '@' + data.ym + '_' + data.attachId + ',"></div>';

                        $('#targetFile').append(str);

                        layer.msg('上传成功', {icon:6});
                    }
                })
                //成果文件附件上传
                upload.render({
                    elem: '#uploadAchievementsFile'
                    ,url: '/upload?module=plancheck' //上传接口
                    ,accept: 'file' //普通文件
                    ,done: function(res){
                        var data=res.obj[0];

                        var fileExtension=data.attachName.substring(data.attachName.lastIndexOf(".")+1,data.attachName.length);//截取附件文件后缀
                        var attName = encodeURI(data.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                        var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                        var deUrl = data.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data.size;
                        var str = '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + data.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + data.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="'+data.attachName+'" class="inHidden" value="' + data.aid + '@' + data.ym + '_' + data.attachId + ',"></div>';

                        $('#achievementsFile').append(str);

                        layer.msg('上传成功', {icon:6});
                    }
                })
            },
            yes:function () {
                var data = {}

                if (type === 3) {
                    layer.close(targetLayer)
                    return false
                } else if (type === 2) {
                    data['tgId'] = tData.tgId
                    globalInfo['projectId'] = tData.projectId
                    globalInfo['pbagId'] = tData.pbagId
                } else if (type === 1) {
                    data['projectId'] = globalInfo['projectId']
                    data['pbagId'] = globalInfo['pbagId']
                }

                var dataEle = $('#targetForm [name]').serializeArray()
                $.each(dataEle, function() {
                    data[this.name] = this.value
                })

                var mainAreaDept = $('#mainAreaDept').attr('deptid') || ''
                var mainProjectDept = $('#mainProjectDept').attr('deptid') || ''
                var dutyUser = $('#dutyUser').attr('user_id') || ''
                var assistUser = $('#assistUser').attr('user_id') || ''
                var mainCenterDept = $('#mainCenterDept').attr('deptid') || ''
                var assistCompanyDepts = $('#assistCompanyDepts').attr('deptid') || ''
                //目标文件
                var attachmentId = ''
                var attachmentName = ''
                var $attachments = $('#targetFile').find('input[type="hidden"]')
                $attachments.each(function(){
                    attachmentId += $(this).val()
                    attachmentName += $(this).data('attachname') + '*'
                })
                //成果文件
                var attachmentId2 = ''
                var attachmentName2 = ''
                var $attachments2 = $('#achievementsFile').find('input[type="hidden"]')
                $attachments2.each(function(){
                    attachmentId2 += $(this).val()
                    attachmentName2 += $(this).data('attachname') + '*'
                })

                data['mainAreaDept'] = mainAreaDept
                data['mainProjectDept'] =mainProjectDept
                data['dutyUser'] = dutyUser
                data['assistUser'] = assistUser
                data['mainCenterDept'] = mainCenterDept
                data['assistCompanyDepts'] = assistCompanyDepts
                data['attachmentId'] = attachmentId
                data['attachmentName'] = attachmentName
                data['attachmentId2'] = attachmentId2
                data['attachmentName2'] = attachmentName2

                $.post(url, data, function(res){
                    if (res.flag) {
                        layer.msg('保存成功', {icon: 1})
                        layer.close(targetLayer)
                        targetTable.reload({
                            url: '/projectTarget/query',
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