var user_id = ''
var dept_id = ''

var globalInfo = {}
var form
//目标类型
var TG_TYPE_OBJ = {}
var TG_TYPE_STR = ''
//计划类型
var PLAN_TYPE_OBJ = {}
var PLAN_TYPE_STR = ''
//计划阶段数据
var PLAN_PHASE_OBJ = {}
var PLAN_PHASE_STR = ''
//计划形式数据
var PLAN_RATE_OBJ = {}
var PLAN_RATE_STR = ''
//计划级次数据
var PLAN_LEVEL_OBJ = {}
var PLAN_LEVEL_STR = ''
//工作项依据
var ACCORDING_OBJ = {}
var ACCORDING_STR = ''


//获取目标类型数据、计划类型数据、计划阶段数据、计划形式数据、计划级次数据、子项目类型数据、子项目层级数据、成本类型数据、子项目性质、子项目分类、工作项依据
$.get('/Dictonary/selectDictionaryByDictNos?dictNos=TG_TYPE,PLAN_TYPE,PLAN_PHASE,PLAN_RATE,PLAN_LEVEL,PBAG_TYPE,PBAG_LEVEL,COST_TYPE,PBAG_NATURE,PBAG_CLASS,ACCORDING', function(res) {
    var data=res.object
    //目标类型数据
    data.TG_TYPE.forEach(function(item) {
        TG_TYPE_OBJ[item.dictNo] = item.dictName
        TG_TYPE_STR += '<option value='+item.dictNo+'>'+item.dictName+'</option>'
    })
    //计划类型数据
    data.PLAN_TYPE.forEach(function(item) {
        PLAN_TYPE_OBJ[item.dictNo] = item.dictName
        PLAN_TYPE_STR += '<option value='+item.dictNo+'>'+item.dictName+'</option>'
    })
    //计划阶段数据
    data.PLAN_PHASE.forEach(function(item) {
        PLAN_PHASE_OBJ[item.dictNo] = item.dictName
        PLAN_PHASE_STR += '<option value='+item.dictNo+'>'+item.dictName+'</option>'
    })
    //计划形式数据
    data.PLAN_RATE.forEach(function(item) {
        PLAN_RATE_OBJ[item.dictNo] = item.dictName
        PLAN_RATE_STR += '<option value='+item.dictNo+'>'+item.dictName+'</option>'
    })
    //计划级次数据
    data.PLAN_LEVEL.forEach(function(item) {
        PLAN_LEVEL_OBJ[item.dictNo] = item.dictName
        PLAN_LEVEL_STR += '<option value='+item.dictNo+'>'+item.dictName+'</option>'
    })
    //工作包类型数据
    var str =""
    data.PBAG_TYPE.forEach(function(item){
        str += '<option value="'+item.dictNo+'">'+item.dictName+'</option>'
    })
    $('#pbagType').append(str)
    form.render('select')
    $('pbagType option')
    //子项目层级数据
    var str1 = ''
    data.PBAG_LEVEL.forEach(function(item){
        str1 += '<option value="'+item.dictNo+'">'+item.dictName+'</option>'
    })
    $('#pbagLevel').append(str1)
    form.render('select')
    //成本类型数据
    var str2 = ''
    data.COST_TYPE.forEach(function(item){
        str2 += '<option value="'+item.dictNo+'">'+item.dictName+'</option>'
    })
    $('#costType').append(str2)
    form.render('select')
    //子项目性质
    var str3=''
    data.PBAG_NATURE.forEach(function(item){
        str3 += '<option value="'+item.dictNo+'">'+item.dictName+'</option>'
    })
    $('#pbagNature').append(str3)
    form.render('select')
    //子项目分类
    var str4=''
    data.PBAG_CLASS.forEach(function(item){
        str4 += '<option value="'+item.dictNo+'">'+item.dictName+'</option>'
    })
    $('#pbagClass').append(str4)
    form.render('select')
    //工作项依据
    data.ACCORDING.forEach(function(item) {
        ACCORDING_OBJ[item.dictNo] = item.dictName
        ACCORDING_STR += '<option value='+item.dictNo+'>'+item.dictName+'</option>'
    })
})
layui.use(['table','layer','form','element','eleTree','laydate', 'upload'], function(){
    var table = layui.table,
        eleTree = layui.eleTree,
        layer = layui.layer,
        laydate = layui.laydate,
        upload = layui.upload,
        element = layui.element;
    form = layui.form
    var eTree = null,
        targetTable = null,
        taskTable = null;

    initPBagForm()

    // 切换tab
    element.on('tab(docDemoTabBrief)', function(data){
        switch (data.index) {
            case 1:
                if (targetTable) {
                    targetTable.reload()
                }
                break;
            case 2:
                if (taskTable) {
                    taskTable.reload()
                }
                break;
        }
    })

    // 工作包附件上传
    upload.render({
        elem: '#uploadBagFile'
        ,url: '/upload?module=plancheck' //上传接口
        ,accept: 'file' //普通文件
        ,done: function(res){
            var data=res.obj[0];

            var fileExtension=data.attachName.substring(data.attachName.lastIndexOf(".")+1,data.attachName.length);//截取附件文件后缀
            var attName = encodeURI(data.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
            var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
            var deUrl = data.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data.size;
            var str = '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + data.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + data.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="'+data.attachName+'" class="inHidden" value="' + data.aid + '@' + data.ym + '_' + data.attachId + ',"></div>';

            $('#bagFiles').append(str);

            layer.msg('上传成功', {icon:6});
        }
    })

    // 删除附件
    $(document).on('click', '.deImgs',function(){
        var _this = this;
        var attUrl = $(this).parents('.dech').attr('deUrl');
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
        initPBagForm()
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
        $.ajax({
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
        })
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
                contextmenuList: contextmenuList, // 节点右键操作
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
        $('#titles').show()
        $('#title').hide()

        $('#titles').text(d.data.currentData.pbagName)
        globalInfo['pbagId'] = d.data.currentData.pbagId
        globalInfo['isLeaf'] = d.data.currentData.isLeaf
        globalInfo['leaf'] = d.data.currentData.leaf
        globalInfo['pBagOptType'] = 2
        initPBagForm(d.data.currentData)
        initTargetTable(globalInfo['projectId'], d.data.currentData.pbagId)
        initTaskTable(globalInfo['projectId'], d.data.currentData.pbagId)
    })

    // 自定义插入节点前事件
    eleTree.on("nodeInsertNodeBefore(projectData)",function(d) {
        addNode(1, d.data)
    })

    // 自定义插入节点后事件
    eleTree.on("nodeInsertNodeBehind(projectData)",function(d) {
        addNode(2, d.data)
    })

    // 自定义插入子节点事件
    eleTree.on("nodeInsertChildNode(projectData)",function(d) {
        addNode(3, d.data)
    })

    // 自定义删除节点事件 removeNode
    eleTree.on("nodeRemoveNode(projectData)",function(d) {
        var title = '确定删除该条项目('+d.data.pbagName+')及其所有子项目？'
        var confirmIndex = layer.confirm(title, {
            btn: ['确定', '取消']
        }, function(){
            $.post('/plcProjectBag/delete', {pbagId: d.data.pbagId}, function(res){
                if (res.flag) {
                    eTree.reload({
                        where: {
                            projectId: globalInfo['projectId'],
                            parentPbagId: 0,
                            time: new Date().getTime() // 防止ie下不刷新
                        }
                    })
                    layer.msg('删除成功', {icon: 1})
                    initPBagForm()
                    globalInfo = {}
                    layer.close(confirmIndex)
                } else {
                    layer.msg('删除失败', {icon: 2})
                }
            })
        })
    })

    // 初始化子项目表单数据
    function initPBagForm(data){
        if (data){
            // 显示右侧编辑数据
            form.val("pBagForm", data)
            $('#saveProjectBag').text('编辑保存')
        } else {
            // 清空表单数据
            $("#pBagForm")[0].reset()
            $('#saveProjectBag').text('新增保存')
        }

        form.render()

        // 处理时间显示
        // 计划开始时间
        laydate.render({
            elem: '#planBeginDate',
            value: data && data.planBeginDate ? new Date(data.planBeginDate) : ''
        })

        // 计划结束时间
        laydate.render({
            elem: '#planEndDate',
            value: data && data.planEndDate ? new Date(data.planEndDate) : ''
        })

        // 实际开始时间
        laydate.render({
            elem: '#realBeginDate',
            value: data && data.realBeginDate ? new Date(data.realBeginDate) : ''
        })

        // 实际结束时间
        laydate.render({
            elem: '#realEndDate',
            value: data && data.realEndDate ? new Date(data.realEndDate) : ''
        })

        // 处理部门显示
        $('#dutyDept').val(data ? data.dutyDeptName : '')
        $('#dutyDept').attr('deptid', data ? data.dutyDept : '')

        // 处理用户显示
        $('#dutyUser').val(data ? data.dutyUserName : '')
        $('#dutyUser').attr('user_id', data ? data.dutyUser : '')

        // 处理附件显示
        var attachments = data ? data.attachments || [] : []
        var fileStr = ''
        if (attachments.length > 0) {
            attachments.forEach(function(attachment){
                var fileExtension=attachment.attachName.substring(attachment.attachName.lastIndexOf(".")+1,attachment.attachName.length)//截取附件文件后缀
                var attName = encodeURI(attachment.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6")
                var fileExtensionName=attName.substring(0,attName.lastIndexOf("."))
                var deUrl = attachment.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+attachment.size
                fileStr += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + attachment.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + attachment.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="'+attachment.attachName+'" class="inHidden" value="' + attachment.aid + '@' + attachment.ym + '_' + attachment.attachId + ',"></div>'
            })
        }
        $('#bagFiles').html(fileStr)

    }

    // 新增节点方法
    function addNode(type, data) {
        globalInfo['pbagId'] = data.pbagId
        globalInfo['parentPbagId'] = type === 3 ? data.pbagId : data.parentPbagId
        globalInfo['isLeaf'] = true
        globalInfo['leaf'] = true
        globalInfo['pBagOptType'] = 1
        globalInfo['insertType'] = type
        globalInfo['parentNodeData'] = data

        initPBagForm()

        $('[name=pbagName]').focus()

    }

    // 保存子项目
    $('#saveProjectBag').on('click', function(event){
        // 阻止表单默认提交
        if (event.stopPropagation) {
            event.stopPropagation()
            event.preventDefault()
        } else if (window.event) {
            window.event.cancelBubble = true
            window.event.returnValue = false
        }

        var data = {}
        if (!globalInfo['pbagId']) { // 判断直接新增子项目
            globalInfo['pBagOptType'] = 1
            globalInfo['insertType'] = 3
            data['parentPbagId'] = 0
            data['projectId'] = globalInfo['projectId']
        } else {
            if (globalInfo['pBagOptType'] === 2 && !globalInfo['pbagId']) { // 判断编辑操作，不存在pbagId，直接返回
                return false
            } else if (globalInfo['pBagOptType'] !== 1 && globalInfo['pBagOptType'] !== 2) { // 判断非新增或修改，直接返回
                return false
            }

            if (globalInfo['pBagOptType'] === 1) {
                data['parentPbagId'] = globalInfo['parentPbagId']
                data['projectId'] = globalInfo['projectId']
            }

            data['pbagId'] = globalInfo['pbagId']
        }

        var dataEle = $('#pBagForm [name]').serializeArray()
        $.each(dataEle, function() {
            data[this.name] = this.value
        })

        var dutyDept = $('#dutyDept').attr('deptid') || ''
        var dutyUser = $('#dutyUser').attr('user_id') || ''
        var attachmentId = ''
        var attachmentName = ''

        var $attachments = $('#bagFiles').find('input[type="hidden"]')
        $attachments.each(function(){
            attachmentId += $(this).val()
            attachmentName += $(this).data('attachname') + '*'
        })

        data['dutyDept'] = parseInt(dutyDept.replace(',', '') || 0)
        data['dutyUser'] = dutyUser.replace(',', '')
        data['attachmentId'] = attachmentId
        data['attachmentName'] = attachmentName

        if (globalInfo['pBagOptType'] === 2) { // 编辑子项目信息
            $.post('/plcProjectBag/update', data, function(res){
                if (res.flag) {
                    data['isLeaf'] = globalInfo['isLeaf']
                    data['leaf'] = globalInfo['leaf']
                    eTree.updateKeySelf(globalInfo['pbagId'], data)
                    layer.msg('保存成功', {icon: 1})
                } else {
                    layer.msg('保存失败', {icon: 2})
                }
            })
        } else if (globalInfo['pBagOptType'] === 1) { // 新建子项目
            data['type'] = globalInfo['insertType']
            data['isLeaf'] = !globalInfo['pbagId'] && globalInfo['insertType'] === 3 ? true : globalInfo['parentNodeData']['isLeaf']
            $.post('/plcProjectBag/add', data, function(res){
                if (res.flag) {
                    var nodeData = res.obj[0]
                    if (globalInfo['insertType'] === 1) {
                        eTree.insertBefore(data['pbagId'], nodeData)
                        globalInfo = {}
                        globalInfo['projectId'] = nodeData['projectId']
                        globalInfo['pbagId'] = nodeData.pbagId
                        globalInfo['parentPbagId'] = nodeData.parentPbagId
                        globalInfo['isLeaf'] = true
                        globalInfo['leaf'] = true
                        globalInfo['pBagOptType'] = 2
                        $('#saveProjectBag').text('编辑保存')
                    } else if (globalInfo['insertType'] === 2) {
                        eTree.insertAfter(data['pbagId'], nodeData)
                        globalInfo = {}
                        globalInfo['projectId'] = nodeData.projectId
                        globalInfo['pbagId'] = nodeData.pbagId
                        globalInfo['parentPbagId'] = nodeData.parentPbagId
                        globalInfo['isLeaf'] = true
                        globalInfo['leaf'] = true
                        globalInfo['pBagOptType'] = 2
                        $('#saveProjectBag').text('编辑保存')
                    } else if (globalInfo['insertType'] === 3) {
                        eTree.reload({
                            where: {
                                projectId: data['projectId'],
                                parentPbagId: 0,
                                time: new Date().getTime()
                            }
                        })
                        globalInfo = {}
                        globalInfo['projectId'] = nodeData.projectId
                        initPBagForm()
                    }
                    layer.msg('保存成功', {icon: 1})
                } else {
                    layer.msg('保存失败', {icon: 2})
                }
            })
        }
    })

    // 初始化目标表格
    function initTargetTable(projectId, pBagId) {
        targetTable = table.render({
            elem: '#targetTable',
            url: '/projectTarget/query',
            page: true
            ,toolbar: '#toolbarDemo'
            ,defaultToolbar:['']
            ,cols: [[ //表头
                {type:'checkbox'}
                ,{field: 'tgNo', title: '目标编号', minWidth: 90}
                ,{field: 'tgName', title: '目标名称', minWidth: 110}
                // ,{field: 'parentTgId', title: '上级目标名称', }
                ,{field: 'tgType', title: '目标类型', minWidth: 110, templet:function (d) {
                        for (var key in TG_TYPE_OBJ) {
                            if (key == d.tgType) {
                                return TG_TYPE_OBJ[key]
                            }
                        }
                    }
                }
                ,{field: 'tgGrade', title: '目标等级', minWidth: 90}
                ,{field: 'tgDesc', title: '目标说明', minWidth: 90}
                ,{field: 'mainAreaDeptName', title: '一级监督部门', minWidth:120}
                ,{field: 'mainProjectDeptName', title: '二级监督部门', minWidth:120}
                // ,{field: 'projectId', title: '所属项目名称', }
                // ,{field: 'pbagId', title: '所属子项目名称', }
                ,{field: 'dutyUserName', title: '责任人', minWidth: 110}
                ,{field: 'assistUserName', title: '协作人(多人)', minWidth: 110}
                ,{field: 'mainCenterDeptName', title: '所属部门', minWidth:150}
                ,{field: 'assistCompanyDeptName', title: '协助部门', minWidth:150}
                ,{field: 'planType', title: '计划类型', minWidth: 110}
                ,{field: 'planStage', title: '计划阶段', minWidth: 110}
                ,{field: 'planRate', title: '计划形式', minWidth: 110}
                ,{field: 'planLevel', title: '计划级次', minWidth: 110}
                ,{field: 'controlLevel', title: '关注等级', minWidth: 110}
                ,{field: 'according', title: '工作项目依据', minWidth: 110}
                ,{field: 'isKeypoint', title: '是否关键项工作', minWidth: 110, templet: function(d){
                        return d.isKeypoint === '1' ? '是' : '否'
                    }}
                ,{field: 'isExam', title: '是否考核', minWidth: 110, templet: function(d){
                        return d.isExam === '1' ? '是' : '否'
                    }}
                ,{field: 'isResult', title: '是否提交成果', minWidth: 110, templet: function(d){
                        return d.isResult === '1' ? '是' : '否'
                    }}
                ,{field: 'planSycle', title: '周期类型', minWidth: 110}
                // ,{field: 'flowId', title: '审批流程', minWidth: 110}
                ,{field: 'planStartDate', title: '计划开始时间',minWidth:120,templet:function (d) {
                        return format(d.planStartDate)
                    }}
                ,{field: 'planEndDate', title: '计划结束时间',minWidth:120,templet:function (d) {
                        return format(d.planEndDate)
                    } }
                ,{field: 'planContinuedDate', title: '计划工期', minWidth: 110}
                ,{field: 'realStartDate', title: '实际开始时间',minWidth:120,templet:function (d) {
                        return format(d.realStartDate)
                    } }
                ,{field: 'realEndDate', title: '实际结束时间',minWidth:120,templet:function (d) {
                        return format(d.realEndDate)
                    } }
                ,{field: 'realContinuedDate', title: '计划工期', minWidth: 110}
                ,{field: 'standardDegree', title: '标准难度系数', minWidth: 110}
                ,{field: 'hardDegree', title: '难度系数', minWidth: 110}
                ,{field: 'resultConfirm', title: '成果确认', minWidth: 110}
                ,{field: 'resultDesc', title: '成果描述', minWidth: 110}
                ,{field: 'finalResultDesc', title: '最终交付成果描述', minWidth: 110}
                ,{field: 'unusualRes', title: '异常原因', minWidth: 110}
                ,{field: 'unusualStuff', title: '异常职称材料', minWidth: 110}
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
                // ,{fixed: 'right',title: '操作',align:'center', toolbar: '#targerBar', minWidth:170}
            ]],
            where: {
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
                                pBagId: tData.pbagId,
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
            content: '<div id="targetFormBox" style="padding: 30px 50px 0 30px;">\n' +
                '        <form class="layui-form" id="targetForm" lay-filter="targetForm">\n' +
                '            <div class="layui-row">\n' +
                '                <div class="layui-col-xs6" style="padding: 0 20px;">\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">目标编号</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input '+disabled+' type="text" name="tgNo" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">是否预算控制</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="radio" '+disabled+' name="budgetYn" value="1" title="是">\n' +
                '                            <input type="radio" '+disabled+' name="budgetYn" value="0" title="否" checked>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">目标等级</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="text" '+disabled+' name="tgGrade" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">主要负责人</label>\n' +
                '                        <div class="layui-input-inline select_input">\n' +
                '                            <input type="text" readonly id="mainDutyUser" name="dutyUserName" autocomplete="off" class="layui-input '+disabled+' user_input">\n' +
                '                        </div>\n' +
                '                        <div class="layui-form-mid layui-word-aux choose_'+disabled+'" userid="mainDutyUser">\n' +
                '                            <a href="javascript:;" class="choose_user" choosetype="1" style="color: blue;">添加</a>\n' +
                '                            <a href="javascript:;" class="clear_user" style="color: red">删除</a>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">计划开始时间</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="text" id="targetPlanBeginDate" '+disabled+' name="planBeginDate" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">计划结束时间</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="text" id="targetPlanEndDate" '+disabled+' name="planEndDate" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">实际开始时间</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="text" id="targetRealBeginDate" '+disabled+' name="realBeginDate" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">实际结束时间</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="text" id="targetRealEndDate" '+disabled+' name="realEndDate" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">一级监督部门</label>\n' +
                '                        <div class="layui-input-inline select_input">\n' +
                '                            <input type="text" '+disabled+' readonly id="oneControlDept" name="mainAreaDeptName" autocomplete="off" class="layui-input '+disabled+' dept_input">\n' +
                '                        </div>\n' +
                '                        <div class="layui-form-mid layui-word-aux choose_'+disabled+'" deptid="oneControlDept">\n' +
                '                            <a href="javascript:;" class="choose_dept" choosetype="1" style="color: blue;">添加</a>\n' +
                '                            <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">提交的成果描述</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="text" '+disabled+'id="submitResultDesc" name="submitResultDesc" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                </div>\n' +
                '                <div class="layui-col-xs6" style="padding: 0 20px;">\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">目标名称</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="text" '+disabled+' name="tgName" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">目标类型</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <select id="tgType" '+disabled+' name="tgType" class="'+disabled+'" lay-verify="required">\n' +
                '                                <option value=""></option>\n' +
                '                            </select>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">目标说明</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="text" '+disabled+' name="tgDesc" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">填写部门</label>\n' +
                '                        <div class="layui-input-inline select_input">\n' +
                '                            <input type="text" readonly id="addDeptId" name="addDeptId" autocomplete="off" class="layui-input '+disabled+' dept_input">\n' +
                '                        </div>\n' +
                '                        <div class="layui-form-mid layui-word-aux choose_'+disabled+'" deptid="addDeptId">\n' +
                '                            <a href="javascript:;" class="choose_dept" choosetype="1" style="color: blue;">添加</a>\n' +
                '                            <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">二级监督部门</label>\n' +
                '                        <div class="layui-input-inline select_input">\n' +
                '                            <input type="text" readonly id="twoControlDept" name="mainProjectDeptName" autocomplete="off" class="layui-input '+disabled+' dept_input">\n' +
                '                        </div>\n' +
                '                        <div class="layui-form-mid layui-word-aux choose_'+disabled+'" deptid="twoControlDept">\n' +
                '                            <a href="javascript:;" class="choose_dept" choosetype="1" style="color: blue;">添加</a>\n' +
                '                            <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">所属部门/单位</label>\n' +
                '                        <div class="layui-input-inline select_input">\n' +
                '                            <input type="text" readonly id="deptId" name="deptId" autocomplete="off" class="layui-input '+disabled+' dept_input">\n' +
                '                        </div>\n' +
                '                        <div class="layui-form-mid layui-word-aux choose_'+disabled+'" deptid="deptId">\n' +
                '                            <a href="javascript:;" class="choose_dept" choosetype="1" style="color: blue;">添加</a>\n' +
                '                            <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">难度系数</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="text" '+disabled+' name="standardDegree" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">最终得分</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="text" '+disabled+' name="endScore" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">质量得分</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="text" '+disabled+' name="qualityScore" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-upload" style="height: auto">\n' +
                '                        <div id="targetFiles" style="padding-left: 160px;"></div>\n' +
                '                        <label class="layui-form-label">附件：</label>\n' +
                '                        <div class="layui-input-block" id="file_box">\n' +
                '                        <button type="button" class="layui-btn layui-btn-primary" id="uploadTargetFile" style="border: 0px;color:#3870d7;padding: 0;"><img src="/img/icon_uplod.png" style="margin-right: 5px;"><i style="display: none" class="layui-icon"></i>附件上传</button>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                </div>\n' +
                '            </div>\n' +
                '        </form>\n' +
                '    </div>',
            success:function () {
                $('#tgType').append(TG_TYPE_STR)
                form.render()

                // 处理时间显示
                // 计划开始时间
                laydate.render({
                    elem: '#targetPlanBeginDate',
                    value: tData && tData.planStartDate ? new Date(tData.planStartDate) : ''
                })

                // 计划结束时间
                laydate.render({
                    elem: '#targetPlanEndDate',
                    value: tData && tData.planEndDate ? new Date(tData.planEndDate) : ''
                })

                // 实际开始时间
                console.log(tData)
                laydate.render({
                    elem: '#targetRealBeginDate',
                    value: tData && tData.realStartDate ? new Date(tData.realStartDate) : ''
                })

                // 实际结束时间
                laydate.render({
                    elem: '#targetRealEndDate',
                    value: tData && tData.realEndDate ? new Date(tData.realEndDate) : ''
                })

                if (type !== 1) {
                    form.val("targetForm", tData)
                    // 处理一级监督部门显示
                    $('#oneControlDept').val(tData ? tData.mainAreaDeptName : '')
                    $('#oneControlDept').attr('deptid', tData ? tData.mainAreaDept : '')

                    // 处理填写部门显示
                    $('#addDeptId').val(tData ? tData.addDeptName : '')
                    $('#addDeptId').attr('deptid', tData ? tData.addDeptId : '')

                    // 处理二级监督部门显示
                    $('#twoControlDept').val(tData ? tData.mainProjectDeptName : '')
                    $('#twoControlDept').attr('deptid', tData ? tData.mainProjectDept : '')

                    // 处理所属部门/单位显示
                    $('#deptId').val(tData ? tData.mainCenterDeptName : '')
                    $('#deptId').attr('deptid', tData ? tData.mainCenterDept : '')

                    // 处理用户显示
                    $('#mainDutyUser').val(tData ? tData.mainDutyUserName : '')
                    $('#mainDutyUser').attr('user_id', tData ? tData.mainDutyUser : '')
                    //处理最终的描述成果
                    $('#submitResultDesc').val(tData ? tData.finalResultDesc : '')
                    // 处理附件显示
                    var attachments = tData ? tData.attachments || [] : []
                    var fileStr = ''
                    if (attachments.length > 0) {
                        attachments.forEach(function(attachment){
                            var fileExtension=attachment.attachName.substring(attachment.attachName.lastIndexOf(".")+1,attachment.attachName.length)//截取附件文件后缀
                            var attName = encodeURI(attachment.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6")
                            var fileExtensionName=attName.substring(0,attName.lastIndexOf("."))
                            var deUrl = attachment.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+attachment.size
                            fileStr += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + attachment.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + attachment.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="'+attachment.attachName+'" class="inHidden" value="' + attachment.aid + '@' + attachment.ym + '_' + attachment.attachId + ',"></div>'
                        })
                    }
                    if (type === 2) {
                        $('#targetFiles').html(fileStr)
                    } else {
                        $('#file_box').html(fileStr)
                    }
                }

                $('.layui-disabled').attr('placeholder', '')

                // 工作包附件上传
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

                        $('#targetFiles').append(str);

                        layer.msg('上传成功', {icon:6});
                    }
                })
            },
            yes:function (targetLayer) {
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

                var oneControlDept = $('#oneControlDept').attr('deptid') || ''
                var addDeptId = $('#addDeptId').attr('deptid') || ''
                var twoControlDept = $('#twoControlDept').attr('deptid') || ''
                var deptId = $('#deptId').attr('deptid') || ''
                var mainDutyUser = $('#mainDutyUser').attr('user_id') || ''
                var attachmentId = ''
                var attachmentName = ''

                var $attachments = $('#targetFiles').find('input[type="hidden"]')
                $attachments.each(function(){
                    attachmentId += $(this).val()
                    attachmentName += $(this).data('attachname') + '*'
                })

                data['oneControlDept'] = parseInt(oneControlDept.replace(',', '') || 0)
                data['addDeptId'] = parseInt(addDeptId.replace(',', '') || 0)
                data['twoControlDept'] = parseInt(twoControlDept.replace(',', '') || 0)
                data['deptId'] = parseInt(deptId.replace(',', '') || 0)
                data['mainDutyUser'] = mainDutyUser
                data['attachmentId'] = attachmentId
                data['attachmentName'] = attachmentName
                $.post(url, data, function(res){
                    if (res.flag) {
                        layer.msg('保存成功', {icon: 1})
                        layer.close(targetLayer)
                        targetTable.reload({
                            url: '/projectTarget/query',
                            where: {
                                projectId: globalInfo['projectId'],
                                pBagId: globalInfo['pbagId'],
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

    // 初始化任务表格
    function initTaskTable(projectId, pBagId){
        taskTable=table.render({
            elem: '#taskTable',
            url: '/plcProjectItem/query',
            page: true,
            toolbar: '#toolbarDemo'
            ,defaultToolbar:['']
            ,cellMinWidth:100,
            cols: [[ //表头
                {type:'checkbox'}
                ,{field: 'taskNo', title: '任务编码', minWidth: 90}
                ,{field: 'taskName', title: '任务名称', minWidth: 110}
                ,{field: 'breakTimes', title: '分解子任务数量',minWidth: 150 }
                ,{field: 'dutyUserName', title: '责任人', minWidth: 90}
                ,{field: 'assistUserName', title: '协作人(多人)', minWidth: 110}
                ,{field: 'mainCenterDeptName', title: '所属部门', minWidth: 90}
                ,{field: 'mainAreaDeptName', title: '一级监督部门', minWidth: 150}
                ,{field: 'mainProjectDeptName', title: '二级监督部门', minWidth: 150}
                ,{field: 'assistCompanyDeptsName', title: '协助部门', minWidth: 110}
                ,{field: 'planType', title: '计划类型', minWidth: 90, templet: function(d){
                        return PLAN_TYPE_OBJ[d.planType] ? PLAN_TYPE_OBJ[d.planType] : ''
                    }}
                ,{field: 'planStage', title: '计划阶段', minWidth: 90, templet: function(d){
                        return PLAN_PHASE_OBJ[d.planStage] ? PLAN_PHASE_OBJ[d.planStage] : ''
                    }}
                ,{field: 'planRate', title: '计划形式', minWidth: 90, templet: function(d){
                        return PLAN_RATE_OBJ[d.planRate] ? PLAN_RATE_OBJ[d.planRate] : ''
                    }}
                ,{field: 'planLevel', title: '计划级次', minWidth: 90, templet: function(d){
                        return PLAN_LEVEL_OBJ[d.planLevel] ? PLAN_LEVEL_OBJ[d.planLevel] : ''
                    }}
                ,{field: 'controlLevel', title: '关注等级', minWidth: 90}
                ,{field: 'according', title: '工作项依据', minWidth: 110}
                ,{field: 'isKeypoint', title: '是否关键工作项', minWidth: 150, templet:function(d){
                        if (d.isKeypoint == 0) {
                            return '否'
                        } else if (d.isKeypoint == 1) {
                            return '是'
                        }
                    }}
                ,{field: 'isExam', title: '是否考核', minWidth: 90, templet:function(d){
                        if (d.isExam == 0) {
                            return '否'
                        } else if (d.isExam == 1) {
                            return '是'
                        }
                    }}
                ,{field: 'isResult', title: '是否提交成果', minWidth: 150, templet:function(d){
                        if (d.isResult == 0) {
                            return '否'
                        } else if (d.isResult == 1) {
                            return '是'
                        }
                    }}
                ,{field: 'planSycle', title: '周期类型', minWidth: 100}
                ,{field: 'flowId', title: '审批流程', minWidth:90 }
                ,{field: 'planStartDate', title: '计划开始时间', minWidth: 120, templet:function (d) {
                        return format(d.planStartDate)
                    }}
                ,{field: 'planEndDate', title: '计划完成时间', minWidth: 120, templet:function (d) {
                        return format(d.planEndDate)
                    }}
                ,{field: 'planContinuedDate', title: '计划工期', minWidth: 90}
                ,{field: 'realStartDate', title: '实际开始时间', minWidth: 120, templet:function (d) {
                        return format(d.realStartDate)
                    }}
                ,{field: 'realEndDate', title: '实际结束时间', minWidth: 120, templet:function (d) {
                        return format(d.realEndDate)
                    }}
                ,{field: 'realContinuedDate', title: '实际工期', minWidth: 90}
                ,{field: 'standardDegree', title: '标准难度系数', minWidth: 110}
                ,{field: 'hardDegree', title: '难度系数', minWidth: 90}
                ,{field: 'resultConfirm', title: '成果确认', minWidth: 90}
                ,{field: 'resultDesc', title: '成果描述', minWidth: 110}
                ,{field: 'finalResultDesc', title: '最终交付成果描述', minWidth: 150}
                ,{field: 'unusualRes', title: '异常原因', minWidth: 90}
                ,{field: 'unusualStuff', title: '异常支撑材料', minWidth: 120}
                ,{field: 'qualityScore', title: '质量得分', minWidth: 90}
                ,{field: 'taskStatus', title: '任务状态', minWidth: 90}
                ,{field: 'taskPrecess', title: '任务进度', minWidth: 90}
                ,{field: 'taskType', title: '任务类型', minWidth: 90}
                ,{field: 'riskPoint', title: '风险点', minWidth: 80}
                ,{field: 'difficultPoint', title: '难度点', minWidth: 80}
                ,{field: 'openNextTask', title: '是否开放下级任务', minWidth: 150, templet:function(d){
                        if (d.openNextTask == 0) {
                            return '否'
                        } else if (d.openNextTask == 1) {
                            return '是'
                        }
                    }}
                ,{field: 'endScore', title: '最终得分', minWidth: 90}
                ,{field: 'resultStandard', title: '完成标准', minWidth: 110}
                ,{field: 'itemQuantity', title: '工程量', minWidth: 110}
                ,{field: 'itemQuantityNuit', title: '工程量单位', minWidth: 110}
                // ,{fixed: 'right',title: '操作', align:'center', toolbar: '#taskBar', minWidth:170}
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

    // 监听-任务表格-工具条
    table.on('tool(taskTable)', function(obj){
        var tData = obj.data;
        var layEvent = obj.event;
        if(layEvent === 'detail'){
            creatTask(3, tData)
        } else if (layEvent === 'edit') {
            creatTask(2, tData)
        } else if(layEvent === 'del'){
            layer.confirm('确定删除当前数据?', function(index){
                $.post('/plcProjectItem/delete', {planItemId: tData.planItemId}, function(res){
                    if (res.flag) {
                        taskTable.reload({
                            url: '/plcProjectItem/query',
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
    function creatTask(type, tData) {
        var title = '',
            disabled = '',
            url = '';
        switch (type) {
            case 1:
                title='添加任务'
                url='/plcProjectItem/add'
                break;
            case 2:
                title='编辑任务'
                url='/plcProjectItem/update'
                break;
            case 3:
                title='查看任务'
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
            maxmin:true,
            min: function(){
                $('.layui-layer-shade').hide()
            },
            btn:['确定','取消'],
            btnAlign: 'c',
            content: '<div id="taskFormBox" style="padding: 30px 50px 0 30px;">\n' +
                '        <form class="layui-form" id="taskForm" lay-filter="taskForm">\n' +
                '            <div class="layui-row">\n' +
                '                <div class="layui-col-xs6" style="padding: 0 20px;">\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">任务编码</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input '+disabled+' type="text" name="taskNo" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">责任人</label>\n' +
                '                        <div class="layui-input-inline select_input">\n' +
                '                            <input type="text" readonly id="taskDutyUser" name="dutyUser" autocomplete="off" class="layui-input '+disabled+' user_input">\n' +
                '                        </div>\n' +
                '                        <div class="layui-form-mid layui-word-aux choose_'+disabled+'" userid="taskDutyUser">\n' +
                '                            <a href="javascript:;" class="choose_user" choosetype="1" style="color: blue;">添加</a>\n' +
                '                            <a href="javascript:;" class="clear_user" style="color: red">删除</a>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">主责中心部门</label>\n' +
                '                        <div class="layui-input-inline select_input">\n' +
                '                            <input type="text" readonly id="mainCenterDept" name="mainCenterDeptName" autocomplete="off" class="layui-input '+disabled+' dept_input">\n' +
                '                        </div>\n' +
                '                        <div class="layui-form-mid layui-word-aux choose_'+disabled+'" deptid="mainCenterDept">\n' +
                '                            <a href="javascript:;" class="choose_dept" choosetype="1" style="color: blue;">添加</a>\n' +
                '                            <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">主责中心部门责任人</label>\n' +
                '                        <div class="layui-input-inline select_input">\n' +
                '                            <input type="text" readonly id="mainCenterDeptUser" name="mainCenterDeptUser" autocomplete="off" class="layui-input '+disabled+' user_input">\n' +
                '                        </div>\n' +
                '                        <div class="layui-form-mid layui-word-aux choose_'+disabled+'" userid="mainCenterDeptUser">\n' +
                '                            <a href="javascript:;" class="choose_user" choosetype="1" style="color: blue;">添加</a>\n' +
                '                            <a href="javascript:;" class="clear_user" style="color: red">删除</a>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">主责区域部门</label>\n' +
                '                        <div class="layui-input-inline select_input">\n' +
                '                            <input type="text" readonly id="mainAreaDept" name="mainAreaDeptName" autocomplete="off" class="layui-input '+disabled+' dept_input">\n' +
                '                        </div>\n' +
                '                        <div class="layui-form-mid layui-word-aux choose_'+disabled+'" deptid="mainAreaDept">\n' +
                '                            <a href="javascript:;" class="choose_dept" choosetype="1" style="color: blue;">添加</a>\n' +
                '                            <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">主责区域部门责任人</label>\n' +
                '                        <div class="layui-input-inline select_input">\n' +
                '                            <input type="text" readonly id="mainAreaDeptUser" name="mainAreaDeptUser" autocomplete="off" class="layui-input '+disabled+' user_input">\n' +
                '                        </div>\n' +
                '                        <div class="layui-form-mid layui-word-aux choose_'+disabled+'" userid="mainAreaDeptUser">\n' +
                '                            <a href="javascript:;" class="choose_user" choosetype="1" style="color: blue;">添加</a>\n' +
                '                            <a href="javascript:;" class="clear_user" style="color: red">删除</a>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">计划类型</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <select id="planType" '+disabled+' name="planType" class="'+disabled+'" lay-verify="required">\n' +
                '                                <option value=""></option>\n' +
                '                            </select>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">计划阶段</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <select id="planStage" '+disabled+' name="planStage" class="'+disabled+'" lay-verify="required">\n' +
                '                                <option value=""></option>\n' +
                '                            </select>\n' +
                '                        </div>\n' +
                '                    </div>\n' +

                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">控制级别</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input '+disabled+' type="text" name="controlLevel" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">是否关键工作项</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="radio" '+disabled+' name="isKeypoint" value="1" title="是">\n' +
                '                            <input type="radio" '+disabled+' name="isKeypoint" value="0" title="否" checked>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">计划周期</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input '+disabled+' type="text" name="planSycle" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">是否启用</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="radio" '+disabled+' name="useFlag" value="1" title="是">\n' +
                '                            <input type="radio" '+disabled+' name="useFlag" value="0" title="否" checked>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">是否预算控制</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="radio" '+disabled+' name="isBudget" value="1" title="是">\n' +
                '                            <input type="radio" '+disabled+' name="isBudget" value="0" title="否" checked>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">是否关联控制指标</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="radio" '+disabled+' name="isAssociate" value="1" title="是">\n' +
                '                            <input type="radio" '+disabled+' name="isAssociate" value="0" title="否" checked>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">是否强制控制</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="radio" '+disabled+' name="isForce" value="1" title="是">\n' +
                '                            <input type="radio" '+disabled+' name="isForce" value="0" title="否" checked>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">标准难度系数</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input '+disabled+' type="text" name="standardDegree" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">难度系数</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input '+disabled+' type="text" name="hardDegree" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">成果确认</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input '+disabled+' type="text" name="resultConfirm" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">完成标准</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input '+disabled+' id="resultDesc" type="text" name="resultStandard" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">最终描述成果</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input '+disabled+' type="text" name="finalResultDesc" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">异常原因</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input '+disabled+' type="text" name="unusualRes" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">异常支撑材料</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input '+disabled+' type="text" name="unusualStuff" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-upload" style="height: auto">\n' +
                '                        <div id="taskFiles" style="padding-left: 160px;"></div>\n' +
                '                        <label class="layui-form-label">附件：</label>\n' +
                '                        <div class="layui-input-block" id="file_box">\n' +
                '                        <button type="button" class="layui-btn layui-btn-primary" id="uploadTaskFile" style="border: 0px;color:#3870d7;padding: 0;"><img src="/img/icon_uplod.png" style="margin-right: 5px;"><i style="display: none" class="layui-icon"></i>附件上传</button>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                </div>\n' +
                '                <div class="layui-col-xs6" style="padding: 0 20px;">\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">任务名称</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input '+disabled+' type="text" name="taskName" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">协作人(多人)</label>\n' +
                '                        <div class="layui-input-inline select_input">\n' +
                '                            <input type="text" readonly id="assistUser" name="assistUserName" autocomplete="off" class="layui-input '+disabled+' user_input">\n' +
                '                        </div>\n' +
                '                        <div class="layui-form-mid layui-word-aux choose_'+disabled+'" userid="assistUser">\n' +
                '                            <a href="javascript:;" class="choose_user" style="color: blue;">添加</a>\n' +
                '                            <a href="javascript:;" class="clear_user" style="color: red">删除</a>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">主责项目部门</label>\n' +
                '                        <div class="layui-input-inline select_input">\n' +
                '                            <input type="text" readonly id="mainProjectDept" name="mainProjectDeptName" autocomplete="off" class="layui-input '+disabled+' dept_input">\n' +
                '                        </div>\n' +
                '                        <div class="layui-form-mid layui-word-aux choose_'+disabled+'" deptid="mainProjectDept">\n' +
                '                            <a href="javascript:;" class="choose_dept" choosetype="1" style="color: blue;">添加</a>\n' +
                '                            <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">主责项目部门责任人</label>\n' +
                '                        <div class="layui-input-inline select_input">\n' +
                '                            <input type="text" readonly id="mainProjectDeptUser" name="mainProjectDeptUser" autocomplete="off" class="layui-input '+disabled+' user_input">\n' +
                '                        </div>\n' +
                '                        <div class="layui-form-mid layui-word-aux choose_'+disabled+'" userid="mainProjectDeptUser">\n' +
                '                            <a href="javascript:;" class="choose_user" choosetype="1" style="color: blue;">添加</a>\n' +
                '                            <a href="javascript:;" class="clear_user" style="color: red">删除</a>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">公司协助部门</label>\n' +
                '                        <div class="layui-input-inline select_input">\n' +
                '                            <input type="text" readonly id="assistCompanyDepts" name="assistCompanyDeptsName" autocomplete="off" class="layui-input '+disabled+' dept_input">\n' +
                '                        </div>\n' +
                '                        <div class="layui-form-mid layui-word-aux choose_'+disabled+'" deptid="assistCompanyDepts">\n' +
                '                            <a href="javascript:;" class="choose_dept" choosetype="1" style="color: blue;">添加</a>\n' +
                '                            <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">区域协助部门</label>\n' +
                '                        <div class="layui-input-inline select_input">\n' +
                '                            <input type="text" readonly id="assistAreaDepts" name="mainCenterDeptName" autocomplete="off" class="layui-input '+disabled+' dept_input">\n' +
                '                        </div>\n' +
                '                        <div class="layui-form-mid layui-word-aux choose_'+disabled+'" deptid="assistAreaDepts">\n' +
                '                            <a href="javascript:;" class="choose_dept" choosetype="1" style="color: blue;">添加</a>\n' +
                '                            <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">计划形式</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <select id="planRate" '+disabled+' name="planRate" class="'+disabled+'" lay-verify="required">\n' +
                '                                <option value=""></option>\n' +
                '                            </select>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">计划级次</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <select id="planLevel" '+disabled+' name="planLevel" class="'+disabled+'" lay-verify="required">\n' +
                '                                <option value=""></option>\n' +
                '                            </select>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">工作项依据</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <select id="according" '+disabled+' name="according" class="'+disabled+'" lay-verify="required">\n' +
                '                                <option value=""></option>\n' +
                '                            </select>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">计划开始时间</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="text" id="taskPlanStartDate" '+disabled+' name="planStartDate" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">计划完成时间</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="text" id="taskPlanEndDate" '+disabled+' name="planEndDate" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">计划工期</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input '+disabled+' type="text" name="planContinuedDate" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">实际开始时间</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="text" id="taskRealStartDate" '+disabled+' name="realStartDate" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">实际完成时间</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="text" id="taskRealEndDate" '+disabled+' name="realEndDate" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">实际工期</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input '+disabled+' type="text" name="realContinuedDate" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">任务状态</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input '+disabled+' type="text" name="taskStatus" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">任务进度</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input '+disabled+' type="text" name="taskPrecess" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">风险点</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input '+disabled+' type="text" name="riskPoint" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">难度点</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input '+disabled+' type="text" name="difficultPoint" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">是否开放下级任务</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="radio" '+disabled+' name="openNextTask" value="1" title="是">\n' +
                '                            <input type="radio" '+disabled+' name="openNextTask" value="0" title="否" >\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">质量得分</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input '+disabled+' type="text" name="qualityScore" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">最终得分</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input '+disabled+' type="text" name="endScore" autocomplete="off" class="layui-input '+disabled+'">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                </div>\n' +
                '            </div>\n' +
                '        </form>\n' +
                '    </div>',
            success:function () {
                $('#planType').append(PLAN_TYPE_STR)
                $('#planStage').append(PLAN_PHASE_STR)
                $('#planRate').append(PLAN_RATE_STR)
                $('#planLevel').append(PLAN_LEVEL_STR)
                $('#according').append(ACCORDING_STR)
                form.render()

                // 处理时间显示
                // 计划开始时间
                laydate.render({
                    elem: '#taskPlanStartDate',
                    value: tData && tData.taskPlanStartDate ? new Date(tData.planStartDate) : ''
                })

                // 计划结束时间
                laydate.render({
                    elem: '#taskPlanEndDate',
                    value: tData && tData.planEndDate ? new Date(tData.planEndDate) : ''
                })

                // 实际开始时间
                laydate.render({
                    elem: '#taskRealStartDate',
                    value: tData && tData.realStartDate ? new Date(tData.realStartDate) : ''
                })

                // 实际结束时间
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

                    // // 处理主责中心部门责任人显示
                    // $('#mainCenterDeptUser').val(tData ? tData.mainCenterDeptUserName : '')
                    // $('#mainCenterDeptUser').attr('user_id', tData ? tData.mainCenterDeptUser : '')

                    // 处理主责区域部门显示
                    $('#mainAreaDept').val(tData ? tData.mainAreaDeptName : '')
                    $('#mainAreaDept').attr('deptid', tData ? tData.mainAreaDept : '')

                    // // 处理主责区域部门责任人显示
                    // $('#mainAreaDeptUser').val(tData ? tData.mainAreaDeptUserName : '')
                    // $('#mainAreaDeptUser').attr('user_id', tData ? tData.mainAreaDeptUser : '')

                    // 处理协作人(多人)显示
                    $('#assistUser').val(tData ? tData.assistUserName : '')
                    $('#assistUser').attr('user_id', tData ? tData.assistUser : '')

                    // 处理主责项目部门显示
                    $('#mainProjectDept').val(tData ? tData.mainProjectDeptName : '')
                    $('#mainProjectDept').attr('deptid', tData ? tData.mainProjectDept : '')
                    //
                    // // 处理主责项目部门责任人显示
                    // $('#mainProjectDeptUser').val(tData ? tData.mainProjectDeptUserName : '')
                    // $('#mainProjectDeptUser').attr('user_id', tData ? tData.mainProjectDeptUser : '')

                    // 处理公司协助部门显示
                    $('#assistCompanyDepts').val(tData ? tData.assistCompanyDeptsName : '')
                    $('#assistCompanyDepts').attr('deptid', tData ? tData.assistCompanyDepts : '')

                    // 处理区域协助部门显示
                    $('#assistAreaDepts').val(tData ? tData.mainCenterDeptName : '')
                    $('#assistAreaDepts').attr('deptid', tData ? tData.mainCenterDept : '')
                    //处理是否开启下级任务

                    // 处理附件显示
                    var attachments = tData ? tData.attachments || [] : []
                    var fileStr = ''
                    if (attachments.length > 0) {
                        attachments.forEach(function(attachment){
                            var fileExtension=attachment.attachName.substring(attachment.attachName.lastIndexOf(".")+1,attachment.attachName.length)//截取附件文件后缀
                            var attName = encodeURI(attachment.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6")
                            var fileExtensionName=attName.substring(0,attName.lastIndexOf("."))
                            var deUrl = attachment.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+attachment.size
                            fileStr += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + attachment.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + attachment.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="'+attachment.attachName+'" class="inHidden" value="' + attachment.aid + '@' + attachment.ym + '_' + attachment.attachId + ',"></div>'
                        })
                    }
                    if (type === 2) {
                        $('#taskFiles').html(fileStr)
                    } else {
                        $('#file_box').html(fileStr)
                    }
                }

                $('.layui-disabled').attr('placeholder', '').css('color', '#222')

                // 工作包附件上传
                upload.render({
                    elem: '#uploadTaskFile'
                    ,url: '/upload?module=plancheck' //上传接口
                    ,accept: 'file' //普通文件
                    ,done: function(res){
                        var data=res.obj[0];
                        var fileExtension=data.attachName.substring(data.attachName.lastIndexOf(".")+1,data.attachName.length);//截取附件文件后缀
                        var attName = encodeURI(data.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                        var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                        var deUrl = data.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data.size;
                        var str = '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + data.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + data.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="'+data.attachName+'" class="inHidden" value="' + data.aid + '@' + data.ym + '_' + data.attachId + ',"></div>';

                        $('#taskFiles').append(str);

                        layer.msg('上传成功', {icon:6});
                    }
                })
            },
            yes:function (index) {
                var data = {}

                if (type === 3) {
                    layer.close(index)
                    return false
                } else if (type === 2) {
                    data['planItemId'] = tData.planItemId
                    globalInfo['projectId'] = tData.projectId
                    globalInfo['pbagId'] = tData.pbagId
                } else if (type === 1) {
                    data['projectId'] = globalInfo['projectId']
                    data['pbagId'] = globalInfo['pbagId']
                }

                var dataEle = $('#taskForm [name]').serializeArray()
                $.each(dataEle, function() {
                    data[this.name] = this.value
                })

                var dutyUser = $('#taskDutyUser').attr('user_id') || ''
                var mainCenterDept = $('#mainCenterDept').attr('deptid') || ''
                var mainCenterDeptUser = $('#mainCenterDeptUser').attr('user_id') || ''
                var mainAreaDept = $('#mainAreaDept').attr('deptid') || ''
                var mainAreaDeptUser = $('#mainAreaDeptUser').attr('user_id') || ''
                var assistUser = $('#assistUser').attr('user_id') || ''
                var mainProjectDept = $('#mainProjectDept').attr('deptid') || ''
                var mainProjectDeptUser = $('#mainProjectDeptUser').attr('user_id') || ''
                var assistCompanyDepts = $('#assistCompanyDepts').attr('deptid') || ''
                var assistAreaDepts = $('#assistAreaDepts').attr('deptid') || ''

                var attachmentId = ''
                var attachmentName = ''

                var $attachments = $('#taskFiles').find('input[type="hidden"]')
                $attachments.each(function(){
                    attachmentId += $(this).val()
                    attachmentName += $(this).data('attachname') + '*'
                })

                data['dutyUser'] = dutyUser
                data['mainCenterDept'] = parseInt(mainCenterDept.replace(',', '') || 0)
                data['mainCenterDeptUser'] = mainCenterDeptUser
                data['mainAreaDept'] = parseInt(mainAreaDept.replace(',', '') || 0)
                data['mainAreaDeptUser'] = mainAreaDeptUser
                data['assistUser'] = assistUser
                data['mainProjectDept'] = parseInt(mainProjectDept.replace(',', '') || 0)
                data['mainProjectDeptUser'] = mainProjectDeptUser
                data['assistCompanyDepts'] = parseInt(assistCompanyDepts.replace(',', '') || 0)
                data['assistAreaDepts'] = parseInt(assistAreaDepts.replace(',', '') || 0)

                data['attachmentId'] = attachmentId
                data['attachmentName'] = attachmentName

                data['standardDegree'] = parseInt(data['standardDegree'] || 0)
                data['taskPrecess'] = parseInt(data['taskPrecess'] || 0)
                $.post(url, data, function(res){
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