var user_id = "";
// var newstr = ''
var sequence = ''
$(function () {


    var info = {
        editorIndex: 0,
        queryObj: {myTask: 1, implementation: 4, taskStatus: 2, importantLevel: 3},
        taskInfoModal: {taskInfo: {}, complateObj: {taskCount: 0, completedCount: 0}, loginUserType: '3'},
        createUser: {
            username: '',
            userId: ''
        },
        resetTaskForm: function(ele) {
            var h = this;
            // 清除输入框数据
            $(ele).siblings().find('.edit_task_name').val('');
            // 清除重要程度数据
            $(ele).find('.important').data('importantLevel', null);
            $(ele).find('.important').children().removeClass('active');
            // 管理者信息清除
            $(ele).find('.creator_box .c_name').get(0).setAttribute('user_id', h.createUser.userId);
            $(ele).find('.creator_box .c_name').val(h.createUser.userName);
            // 参与者信息清除
            var $joiner = $(ele).find('.joiner .joiner_ids');
            $joiner.get(0).setAttribute('user_id', '');
            $joiner.val('');
            // 清除到期日期
            $(ele).find('.task_date').val('');
        },
        initTaskModal: function(data, $ele) {
            var h = this;

            h.taskInfoModal.taskInfo = data;
            if (data.startDate.length > 0 && data.startDate != '') {
                h.taskInfoModal.taskInfo.startDate = data.startDate.split(' ')[0];
            }
            if (data.endDate.length > 0 && data.endDate != '') {
                h.taskInfoModal.taskInfo.endDate = data.endDate.split(' ')[0];
            }

            h.taskInfoModal.complateObj.taskCount = data.taskManages ? data.taskManages.length : 0;
            h.taskInfoModal.complateObj.completedCount = data.completedCount;

            $.ajax({
                type: 'GET',
                url: '/task/queryManageRole',
                data: {taskId: data.taskId},
                async: false,
                success: function(res) {
                    h.taskInfoModal.loginUserType = res.obj[0];
                    if (res.obj[0] === '4') {
                        $ele.removeClass('user_type_manage');
                        $ele.removeClass('user_type_shared');
                        $ele.find('.body_title input').get(0).readOnly = false;
                        $ele.find('.task_desc').get(0).readOnly = false;
                    } else if (res.obj[0] === '1') {
                        $ele.addClass('user_type_manage');
                        $ele.removeClass('user_type_shared');
                        $ele.find('.body_title input').get(0).readOnly = false;
                        $ele.find('.task_desc').get(0).readOnly = false;
                    } else {
                        $ele.removeClass('user_type_manage');
                        $ele.addClass('user_type_shared');
                        $ele.find('.body_title input').get(0).readOnly = true;
                        $ele.find('.task_desc').get(0).readOnly = true;
                    }
                }
            });

            // 判断任务是否完成
            if (data.taskStatus == 1) {//已完成
                $ele.find('.btn_mark').hide();
                $ele.find('.btn_cancel_mark').show();
                $ele.find('.btn_urge').hide();
            }
            // 判断是否关注
            if (data.follow == 1) { // 已关注
                $ele.find('.btn_attention').hide();
                $ele.find('.btn_cancel_attention').show();
            }
            // 任务名称
            $ele.find('.body_title input').val(data.taskName);
            // 负责人
            $ele.find('.manage_user').find('.c_name').attr('user_id', data.manageUser);
            $ele.find('.manage_user').find('.c_name').val(data.manageUserName);
            if (h.createUser.userId != data.manageUser) {
                $ele.find('.manage_user').find('.icon-change-creator').hide();
            } else {
                $ele.find('.manage_user').find('.icon-change-creator').show();
            }
            // 任务进度
            $ele.find('.progress-bar').css('width', data.progress + '%');
            $ele.find('.progress_btn').css('left', data.progress + '%');
            $ele.find('.progress_num').css('left', data.progress + '%').text(data.progress + '%');
            // 起始日和到期日
            $ele.find('#taskbegindate').val(data.startDate);
            $ele.find('#taskenddate').val(data.endDate);

            // 评分值
            $ele.find('.task_grade').val(data.taskGrade);
            if (!data.istaskGrade) {
                $ele.find('.task_grade').prop('disabled', true);
            }
            // 重要程度
            $('.btn_important ', $ele).each(function(index, ele){
                var importantLevel = $(ele).data('importantlevel')
                if (data.importantLevel == importantLevel) {
                    $(ele).addClass('active');
                    return false;
                }
            });
            // 参与人
            if (data.participate && data.participate != "") {
                $('#taskModalJoiner', $ele).attr('user_id', data.participate);
                $('#taskModalJoiner', $ele).val(data.participateName);
            }
            // 分享人
            if (data.shared && data.shared != "") {
                $('#taskModalShared', $ele).attr('user_id', data.shared);
                $('#taskModalShared', $ele).val(data.sharedName);
            }
            // 任务详情
            if (data.taskDesc) {
                $ele.find('.task_desc').val(data.taskDesc);
            }
            // 子任务
            if (data.parentId > 0) {
                $('.child_task_module', $ele).hide();
                $('.parent_task_module', $ele).show();
                $('.parent_task_name', $ele).text(data.parentName);
            } else {
                $('.parent_task_module', $ele).hide();
                $('.child_task_module', $ele).show();
                var count = data.taskManages ? data.taskManages.length : 0;
                $('.comple_unfinsh', $ele).text(count-data.completedCount);
                $('.comple_total', $ele).text(count);
                if (data.taskManages.length > 0) {
                    for (var i = 0; i < data.taskManages.length; i++) {
                        var $item = $('<li class="child_task_item"><a href="javascript:;">'+data.taskManages[i].taskName+'</a></li>');
                        $('.add_child_task', $ele).before($item);
                    }
                }
            }
            // 附件
            if (data.attachmentList && data.attachmentList.length>0){
                var str = '';
                var deUrl2 = ''
                for(var i=0;i<data.attachmentList.length;i++){
                     deUrl2 = data.attachmentList[i].attUrl+"&FILESIZE="+data.attachmentList[i].size;
                    str+='<div class="dech" deUrl="'+encodeURI(data.attachmentList[i].attUrl)+'"><a href="/download?'+encodeURI(deUrl2)+'" NAME="'+data.attachmentList[i].attachName+'*"fileSize="' + data.attachmentList[i].size + ',"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+data.attachmentList[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+data.attachmentList[i].aid+'@'+data.attachmentList[i].ym+'_'+data.attachmentList[i].attachId+',"></div>';
                }
                $('.modal_file_box', $ele).append($(str));
            } else {
                h.taskInfoModal.taskInfo.attachmentId = '';
                h.taskInfoModal.taskInfo.attachmentName = '';
            }
            // 评论
            if (data.taskFeedbacks && data.taskFeedbacks.length > 0) {
                data.taskFeedbacks.forEach(function(p){
                    if (p.parentId === 0) {
                        var $p = newTaskFeedback(p);
                        if (p.taskFeedbacks.length > 0) {
                            p.taskFeedbacks.forEach(function(c){
                                var $c = newTaskFeedback(c);
                                $p.find('.child_feedback_ul').prepend($c);
                            });
                        }
                        $('.feedback_ul', $ele).prepend($p);
                    }
                })
            }

        },
        tableEvents: function () {
            var h = this;

            // 顶部查询-我的任务
            $('.btn_mytask').on('click',function(){
                $(this).siblings().removeClass('active');
                $(this).addClass('active');
                var myTask = $(this).data('mytask');
                h.queryObj.myTask = parseInt(myTask);
                initTaskList();
            });

            // 顶部查询-执行情况
            $('.btn_implementation').on('click',function(){
                var implementation = $(this).data('implementation');
                $('#search_implementation').find('.btn_text').text($(this).text());
                h.queryObj.implementation = parseInt(implementation);
                initTaskList();
            });

            // 顶部查询-任务状态
            $('.btn_taskstatus').on('click',function(){
                var taskStatus = $(this).data('taskstatus');
                $('#search_taskstatus').find('.btn_text').text($(this).text());
                h.queryObj.taskStatus = parseInt(taskStatus);
                initTaskList();
            });

            // 顶部查询-重要程度
            $('.btn_importantlevel').on('click',function(){
                var importantLevel = $(this).data('importantlevel');
                $('#search_importantlevel').find('.btn_text').text($(this).text());
                h.queryObj.importantLevel = parseInt(importantLevel);
                initTaskList();
            });

            // 新增任务列表
            $('.add_task').on('click', function () {
                $(this).hide();
                $('.add_list_form').show();
                $('.add_form .well').css('padding', '19px 0');
            });

            // 取消新增任务列表
            $('.btn-cancel-list').on('click', function () {
                $('.add_list_form').hide(0, function () {
                    $('#list_name').val('');
                    $(this).find('.tool_tip').hide();
                });
                $('.add_task').show();
                $('.add_form .well').css('padding', '0');
            });

            // 监听新增任务列表输入框
            $('#list_name').on('blur', function () {
                var title = $(this).val().trim();
                if (!title) {
                    $(this).siblings('.tool_tip').show();
                }
            });

            // 监听输入框值改变
            $('#list_name').on('change', function () {
                $(this).siblings('.tool_tip').hide();
            });

            // 点击新增任务列表
            $('.btn-save-list').on('click', function () {
                var _this = this;
                var name = $('#list_name').val().trim();
                if (!name) {
                    $('.tool_tip').show();
                    return;
                }

                $.ajax({
                    type: "post",
                    url: basePath + "taskClass/addTaskClass",
                    dataType: 'json',
                    data: {
                        "className": name
                    },
                    success: function (obj) {
                        if (obj.flag) {
                            $('.add_list_form').hide(0, function () {
                                $(this).find('.tool_tip').hide();
                                $('#list_name').val('');
                            });
                            $('.add_task').show();
                            $('.add_form .well').css('padding', '0');
                            initTaskList();
                        } else {
                            $.confirm({
                                message: '新增列表失败',
                                type: 'danger'
                            });
                        }
                    }
                });
            });

            // 催办选择其他用户
            $('.add_other_users').on('click', function(){
                user_id='other_users';
                $.ajax({
                    url:'/imfriends/getIsFriends',
                    type:'get',
                    dataType:'json',
                    data:{},
                    success:function(obj){
                        if(obj.object == 1){
                            $.popWindow("../common/selectUserIMAddGroup");
                        }else{
                            $.popWindow("../common/selectUser");
                        }
                    },
                    error:function(res){
                        $.popWindow("../common/selectUser");
                    }
                })
            });
            // 催办清空其他用户
            $('.clear_other_users').on('click', function(){
                $('#other_users').get(0).setAttribute('user_id', '');
                $('#other_users').val('');
            });

        },
        events: function () {
            var h = this;
            var $contentBox = $('.content_box');

            // 点击显示编辑任务名称弹窗 (ie下span标签添加点击无效，需要将事件添加到父元素上)
            $contentBox.on('click', '.btn_show_menu', function (event) {
                if (event.stopPropagation) {
                    event.stopPropagation();
                } else if (window.event) {
                    window.event.cancelBubble = true;
                }
                var that = this;
                var $taskMenu = $(this).parents('.panel-heading').children('.task_name_menu')
                if (that.flag) {
                    $taskMenu.hide(0, function () {
                        var _this = this;
                        $(_this).children('.edit_menu').siblings().show();
                        $(_this).children('.edit_menu').hide();
                        $(_this).off('click');
                        $(_this).find('.close_menu').off('click');
                        $(_this).find('.btn_save_list').off('click');
                        $('body').off('click');
                        that.flag = !that.flag;
                    })
                } else {
                    $taskMenu.show(0, function () {
                        var _this = this;

                        // ×号绑定关闭事件
                        $(_this).find('.close_menu').on('click', function (event) {
                            var _self = this
                            $(_this).hide(0, function () {
                                $(_this).children('.edit_menu').siblings().show();
                                $(_this).children('.edit_menu').hide();
                                $(_self).off('click');
                                $(_this).off('click');
                                $(_this).find('.btn_save_list').off('click');
                                $('body').off('click');
                                that.flag = !that.flag;
                            })
                        })

                        // body绑定关闭事件
                        $('body').on('click', function () {
                            $(_this).hide(0, function () {
                                $(_this).children('.edit_menu').siblings().show();
                                $(_this).children('.edit_menu').hide();
                                $(_this).off('click');
                                $(_this).find('.close_menu').off('click');
                                $(_this).find('.btn_save_list').off('click');
                                $('body').off('click');
                                that.flag = !that.flag;
                            })
                        })
                        that.flag = !that.flag;
                    })
                }
            });

            // 点击删除任务列表
            $contentBox.on('click', '.btn_del_tasklist', function(){
                var _this = this;
                $.confirm({
                    content: '确定要删除该列表吗?',
                    confirm: function () {
                        var listData = $(_this).parents('.content_list_item').data('listData');
                        $.ajax({
                            type: "post",
                            url: basePath + "taskClass/delTaskClass",
                            data: {typeId: listData.typeId},
                            dataType: "json",
                            success: function(res) {
                                if (res.flag) {
                                    $.message('列表已删除');
                                    initTaskList()
                                } else {
                                    $.message({
                                        message: '删除列表失败',
                                        type: 'danger'
                                    });
                                }
                            }
                        });
                    }
                });
            });

            // 点击显示编辑表单
            $contentBox.on('click', '.btn_to_edit', function (event) {
                var $editMenu = $(this).parent().siblings('.edit_menu');
                var listData = $editMenu.parents('.content_list_item').data('listData');
                var $listNameInput = $editMenu.find('.nwe_list_name');
                $listNameInput.val(listData.typeName)
                if (event.stopPropagation) {
                    event.stopPropagation();
                } else if (window.event) {
                    window.event.cancelBubble = true;
                }
                $editMenu.siblings().hide();
                $editMenu.show(0, function(){
                    $(this).parents('.task_name_menu').on('click', function (event) {
                        if (event.stopPropagation) {
                            event.stopPropagation();
                        } else if (window.event) {
                            window.event.cancelBubble = true;
                        }
                    });

                    // 绑定保存按钮事件
                    $(this).find('.btn_save_list').on('click', function(event){
                        var typeName = $listNameInput.val().trim();

                        if (!typeName) {
                            $.message({
                                message: '请输入列表名称',
                                type: 'danger'
                            });
                            return;
                        }

                        $.ajax({
                            type: 'post',
                            url: basePath + 'taskClass/updateTaskClass',
                            data: {typeId: listData.typeId, typeName: typeName},
                            dataType: 'json',
                            success: function (res) {
                                if (res.flag) {
                                    listData.typeName = typeName;
                                    $editMenu.parents('.content_list_item').find('.list_title').text(typeName);
                                    $editMenu.parents('.content_list_item').find('.list_title').attr('title', typeName);
                                    $editMenu.parents('.task_name_menu').hide(0, function () {
                                        var _this = this;
                                        $(_this).children('.edit_menu').siblings().show();
                                        $(_this).children('.edit_menu').hide();
                                        $(_this).off('click');
                                        $(_this).find('.close_menu').off('click');
                                        $(_this).find('.btn_save_list').off('click');
                                        $('body').off('click');
                                        var that = $editMenu.parents('.content_list_item').find('.btn_show_menu').get(0);
                                        that.flag = !that.flag;
                                    });
                                } else {
                                    $.message({
                                        message: '修改失败',
                                        type: 'danger'
                                    });
                                }
                            }
                        });
                    });
                });
            });

            // 点击显示新增任务表单
            $contentBox.on('click', '.edit_task_name', function () {
                var _this = this;
                var userIds = $(_this).parents('form').find('.creator_box .c_name').get(0).getAttribute('user_id');
                if (userIds.length == 0) {
                    $(_this).parents('form').find('.creator_box .c_name').get(0).setAttribute('user_id', h.createUser.userId);
                    $(_this).parents('form').find('.creator_box .c_name').val(h.createUser.userName);
                }
                $(_this).parents('.form-group').siblings('.edit-form').show();
                setP_contentScroll(_this, false, function (isScroll, b_height) {
                    if (isScroll) {
                        $(_this).parents('.scroll').scrollTop(b_height);
                    }
                });
            });
            $contentBox.on('click', '.add_new_task', function(){
                var _this = this;
                var userIds = $(_this).parents('form').find('.creator_box .c_name').get(0).getAttribute('user_id');
                if (userIds.length == 0) {
                    $(_this).parents('form').find('.creator_box .c_name').get(0).setAttribute('user_id', h.createUser.userId);
                    $(_this).parents('form').find('.creator_box .c_name').val(h.createUser.userName);
                }
                $(_this).parents('.form-group').siblings('.edit-form').show();
                setP_contentScroll(_this, false, function (isScroll, b_height) {
                    if (isScroll) {
                        $(_this).parents('.scroll').scrollTop(b_height);
                    }
                });
            });

            // 新增任务-选择负责人
            $contentBox.on('click', '.form_add_creator', function () {
                user_id = $(this).parent().find('.c_name').attr('id');
                $.ajax({
                    url:'/imfriends/getIsFriends',
                    type:'get',
                    dataType:'json',
                    data:{},
                    success:function(obj){
                        if(obj.object == 1){
                            $.popWindow("/common/selectUserIMAddGroup?0");
                        }else{
                            $.popWindow("/common/selectUser?0");
                        }
                    },
                    error:function(res){
                        $.popWindow("/common/selectUser?0");
                    }
                });
            });
            // 新增任务-选择参与人
            $contentBox.on('click', '.form_add_joiner', function () {
                user_id = $(this).siblings('.joiner_ids').attr('id');
                $.ajax({
                    url:'/imfriends/getIsFriends',
                    type:'get',
                    dataType:'json',
                    data:{},
                    success:function(obj){
                        if(obj.object == 1){
                            $.popWindow("/common/selectUserIMAddGroup");
                        }else{
                            $.popWindow("/common/selectUser");
                        }
                    },
                    error:function(res){
                        $.popWindow("/common/selectUser");
                    }
                });
            });
            // 新增任务-清空参与人
            $contentBox.on('click', '.form_clear_joiner', function () {
                user_id = $(this).siblings('.joiner_ids').attr('id');
                $('#'+user_id).attr('user_id', '');
                $('#'+user_id).val('');
            });

            // 加载日期选择器
            $contentBox.on('click', '.task_date' ,function(){
                var dateId = $(this).prop('id')
                laydate.render({
                    elem: '#'+dateId,
                    type: 'date',
                    format: 'yyyy-MM-dd',
                    show: true,
                    trigger: 'click'
                });
            });

            // 关闭新增任务表单
            $contentBox.on('click', '.close_task_form', function () {
                var _this = this;
                $(_this).parents('.edit-form').hide(0, function(){
                    h.resetTaskForm(this)
                });
                setP_contentScroll(_this);
                // window.location.reload()
            });

            // 点击显示任务详情
            var flag1 = true;
            $contentBox.on('click', '.task_list_item', function () {
                if (flag1) {
                    flag1 = false;
                    var taskInfo = $(this).data('taskInfo');
                    $('#comment').addClass('active')
                    $('#myTabContent').css('display', 'block')
                    $('#myTabContent2').css('display', 'none')
                    $('#change').removeClass('active')
                // 获取任务详情
                $.get(basePath + 'task/queryTaskManageByTaskId', {taskId: taskInfo.taskId}, function (res) {
                    flag1 = true;
                    if (res.flag) {
                        h.initTaskModal(res.obj[0], $('#taskInfoModal'));
                        h.taskInfoModalEvents(res.obj[0], $('#taskInfoModal'));
                        $('#taskInfoModal').modal('show');
                        if ($('#progress-bar').css('width') == '100%') {
                            $('.btn_cancel_mark').show();
                            $('.btn_urge').hide();
                            $('.btn_mark').hide()
                        } else {
                            $('.btn_mark').show();
                            $('.btn_cancel_mark').hide();
                            $('.btn_urge').show();
                        }
                    }
                    if (res.object == undefined) {
                        $('.Change').show();
                        $('.Changeit').hide();
                    } else {
                        if (res.object.smsGatewayState == 0) {
                            $('.Change').hide();
                            $('.Changeit').show();
                        }
                    }
                });
            }
            });

            // 选择任务重要程度
            $contentBox.on('click', '.btn_important', function(){
                $(this).siblings().removeClass('active');
                $(this).addClass('active');
                var importantLevel = $(this).data('importantlevel');
                $(this).parent('.important').data('importantLevel', importantLevel);
            });

            // 点击新增具体任务
            $contentBox.on('click', '.btn_new_task', function(){
                var _this = this;

                var $form = $(_this).parents('form');
                var taskName = $form.find('.edit_task_name').val().trim(),
                    importantLevel = $form.find('.important .active').data('importantlevel'),
                    manageUser = $form.find('.c_name').attr('user_id').replace(',',''),
                    endDate = $form.find('.task_date').val(),
                    participate = $form.find('.joiner_ids').attr('user_id') || '',
                    typeId = $(_this).parents('.content_list_item').data('listData').typeId;
                //
                if (!taskName) {
                    $.message({
                        message: '请输入任务名称',
                        type: 'danger'
                    });
                    return false;
                }

                if ((typeof(importantLevel) == 'undefined' || !importantLevel) && importantLevel != 0) {
                    $.message({
                        message: '请选择任务重要程度',
                        type: 'danger'
                    });
                    return false;
                }

                if (!endDate) {
                    $.message({
                        message: '请选择结束日期',
                        type: 'danger'
                    });
                    return false;
                }
                var sequence =   $(_this).parents('.content_list_item').find('.task_list').children().last().attr('sequence')
                var sequence2 = ''
                if($(_this).parents('.content_list_item').find('.task_list').children().length == 0){
                    sequence2 = 0
                }else {
                    sequence2 = parseInt($(_this).parents('.content_list_item').find('.task_list').children().last().attr('sequence'))+1
                }
                var date = new Date();
                var createDate = date.getFullYear() + '-' + ((date.getMonth() + 1) < 10 ? '0' + (date.getMonth() + 1) : (date.getMonth() + 1)) + '-' + (date.getDate() < 10 ? '0' + date.getDate() : date.getDate());
                var data = {
                    taskId: typeId, // 任务主键id
                    taskName: taskName, // 任务名称
                    taskDesc: '', // 任务详情
                    importantLevel: parseInt(importantLevel), //重要程度 0普通 1重要 2紧急 传数字类型
                    createUser: h.createUser.userId.toString(), // 创建人
                    manageUser: manageUser.toString(), //负责人
                    taskStatus: '0', //任务状态
                    createDate: createDate, //创建时间
                    startDate: createDate, //开始时间
                    endDate: endDate, //结束时间
                    parentId: 0, //父任务Id
                    progress: 0, //任务进度 传数字类型
                    taskGrade: 0, // 评分
                    completeDate: '', // 完成日期
                    typeId: typeId, //任务类型id
                    attachmentId: '', // 附件id
                    attachmentName: '', // 附件名字
                    participate: participate, //参与者 拼接用户id用，连接
                    shared: '',//共享者 拼接用户id用，连接
                    follow: 0,//是否关注  取消关注2 关注1 默认 0
                    sequence:sequence2//排序号
                }

                $.ajax({
                    type: 'post',
                    url: basePath + "task/addTaskManage",
                    dataType: 'json',
                    data: data,
                    success: function (res) {
                        if (res.flag) {
                            var listData = $(_this).parents('.content_list_item').data('listData');
                            var $listItem = $(_this).parents('.content_list_item');

                            // 重新渲染该列表下的任务
                            initTaskItemList(listData.typeId, {}, $listItem);
                            $(_this).parents('.edit-form').hide(0, function(){
                                h.resetTaskForm(this)
                            });
                            setP_contentScroll(_this);
                        } else {
                            $.message({
                                message: '新增任务失败',
                                type: 'danger'
                            });
                        }
                    },
                    error: function(err) {
                        $.message({
                            message: '新增任务失败',
                            type: 'danger'
                        });
                    }
                });
            });


            // 点击删除具体任务
            $contentBox.on('click', '.remove_task_icon', function(event){
                var _this = this;
                if (event.stopPropagation) {
                    event.stopPropagation();
                } else if (window.event) {
                    window.event.cancelBubble = true;
                }

                var taskInfo = $(_this).parents('.task_list_item').data('taskInfo');
                $.get('/task/queryManageRole', {taskId: taskInfo.taskId}, function(res){

                    if (res.obj[0] === '1' || res.obj[0] === '4') {
                        $.confirm({
                            content: '确定要删除该任务吗?',
                            confirm: function () {

                                var $listItem = $(_this).parents('.content_list_item');

                                $.post(basePath+'task/deleteTaskManage', {taskId: taskInfo.taskId}, function(res){
                                    if (res.flag) {
                                        $.message('任务已删除');
                                        initTaskItemList(taskInfo.typeId, {}, $listItem);
                                    } else {
                                        $.message({
                                            message: '删除任务失败',
                                            type: 'danger'
                                        });
                                    }
                                });
                            }
                        });
                    }
                });
            });

            // task_toggle 任务完成状况切换
            $contentBox.on('click', '.task_toggle', function(event){
                var _this = this;
                if (event.stopPropagation) {
                    event.stopPropagation();
                } else if (window.event) {
                    window.event.cancelBubble = true;
                }

                var $p = $(_this).parents('.task_list_item');
                var taskInfo = $p.data('taskInfo');
                var taskStatus = '0';

                $.get('/task/queryManageRole', {taskId: taskInfo.taskId}, function(res){
                    if (res.obj[0] === '1' || res.obj[0] === '4') {
                        $(_this).toggleClass('on');

                        if ($(_this).hasClass('on')) {
                            taskStatus = '1';
                            taskInfo.progress = 100;
                        }

                        var data = {
                            taskId: taskInfo.taskId, // 任务主键id
                            taskName: taskInfo.taskName, // 任务名称
                            taskDesc: taskInfo.taskDesc || '', // 任务详情
                            importantLevel: parseInt(taskInfo.importantLevel), //重要程度 0普通 1重要 2紧急 传数字类型
                            createUser: taskInfo.createUser, // 创建人
                            manageUser: taskInfo.manageUser, //负责人
                            taskStatus: taskStatus, //任务状态
                            createDate: taskInfo.createDate || '', //创建时间
                            startDate: taskInfo.startDate || '', //开始时间
                            endDate: taskInfo.endDate || '', //结束时间
                            parentId: taskInfo.parentId, //父任务Id
                            progress: taskInfo.progress, //任务进度 传数字类型
                            taskGrade: taskInfo.taskGrade, // 评分
                            completeDate: taskInfo.completeDate || '', // 完成日期
                            typeId: taskInfo.typeId, //任务类型id
                            attachmentId: taskInfo.attachmentId || '', // 附件id
                            attachmentName: taskInfo.attachmentName || '', // 附件名字
                            participate: taskInfo.participate, //参与者 拼接用户id用，连接
                            shared: taskInfo.shared,//共享者 拼接用户id用，连接
                            follow: taskInfo.follow//是否关注  取消关注0 关注1 默认0
                        }

                        $.ajax({
                            url: '/task/updateTaskManage',
                            type: 'post',
                            dataType: 'json',
                            data: data,
                            success: function(res){
                                if (res.flag) {
                                    data.manageUserName = taskInfo.manageUserName;
                                    var $taskItem = newTaskItem(data);
                                    $p.replaceWith($taskItem);
                                }
                            }
                        });
                    }
                });
            });
        },
        taskInfoModalEvents: function(datas, $ele) {
            var h = this;
            var $modalEle = $('#taskInfoModal');

            var moveFlag = false;

            var history = datas;

            // 弹窗关闭清空数据
            $modalEle.on('hidden.bs.modal', function(){
                // h.taskInfoModal.taskInfo = {};
                // $(this).find('.btn_urge').show();
                // $(this).find('.btn_mark').show();
                // $(this).find('.btn_cancel_mark').hide();
                // $(this).find('.btn_attention').show();
                // $(this).find('.btn_cancel_attention').hide();
                // $(this).find('.body_title input').val('');
                // // 任务进度
                // $(this).find('.progress-bar').css('width', '0');
                // $(this).find('.progress_btn').css('left', '0');
                // $(this).find('.progress_num').css('left', '0').text(0 + '%');
                // // 起始日和到期日
                // $(this).find('#begindate').val('');
                // $(this).find('#enddate').val('');
                // // 评分值
                // $(this).find('.task_grade').prop('disabled', false);
                // $(this).find('.task_grade').val('0');
                // $('.btn_important ', $(this)).removeClass('active');
                // // 参与人taskModalCreator
                // $('#taskModalJoiner', $(this)).attr('user_id', '');
                // $('#taskModalJoiner', $(this)).val('');
                // // 分享人
                // $('#taskModalShared', $(this)).attr('user_id', '');
                // $('#taskModalShared', $(this)).val('');
                // // 任务详情
                // $(this).find('.task_desc').val('');
                // // 子任务
                // $('.add_child_task', $(this)).siblings().remove();
                // $('.add_child_task', $(this)).find('.child_task_box').hide();
                // //附件
                // $('.modal_file_box', $(this)).empty();
                // //评论
                // $('.feedback_ul', $(this)).empty();
                // $('.task_new').remove();
                window.location.reload()
            });

            // 设置催办
            $('.btn_urge', $modalEle).on('click', function() {
                layer.open({
                    title: '催办设置',
                    type: 1,
                    area: ['500px', '360px'],
                    btn: ['确定', '取消'],
                    content: $('#urgeModal'),
                    success: function(){
                        // 解决提醒弹窗输入框无法输入问题
                        $(document).off('focusin');
                    },
                    yes: function(){
                        var urgeContent = $('.urge_content').val().trim();
                        var remind = $('.remind:checked');
                        var otherPeople = $('#other_users').attr('user_id') || '';
                        var reminder =$('.reminder:checked');

                        if (remind.length > 1) {
                            remind = '1,2';
                        } else if (remind.length == 1) {
                            remind = remind.val()
                        }

                        if (otherPeople.length == 0) {
                            otherPeople = '';
                        }

                        if (reminder.length > 1) {
                            reminder = '1,2';
                        } else if (reminder.length == 1) {
                            reminder = reminder.val();
                        }

                        var data = {
                            taskId: h.taskInfoModal.taskInfo.taskId + ',',
                            urgeContent: urgeContent,
                            remind: remind,
                            otherPeople: otherPeople,
                            reminder: reminder
                        }

                        $.post(basePath+'task/batchUrgeTask', data, function(res){

                            if (res.flag){
                                layer.closeAll();
                                $('.urge_content').val('这个任务需要抓紧处理');
                                $('.remind').prop('checked', false);
                                $('.remind').eq(0).prop('checked', true);
                                $('#other_users').attr('user_id', '');
                                $('#other_users').val('');
                                $('.reminder').prop('checked', false);
                                $('.reminder').eq(0).prop('checked', true);
                            }
                        });
                    },
                    btn2: function(){
                        $('.urge_content').val('这个任务需要抓紧处理');
                        $('.remind').prop('checked', false);
                        $('.remind').eq(0).prop('checked', true);
                        $('#other_users').attr('user_id', '');
                        $('#other_users').val('');
                        $('.reminder').prop('checked', false);
                        $('.reminder').eq(0).prop('checked', true);
                    },
                    cancel: function(){
                        $('.urge_content').val('这个任务需要抓紧处理');
                        $('.remind').prop('checked', false);
                        $('.remind').eq(0).prop('checked', true);
                        $('#other_users').attr('user_id', '');
                        $('#other_users').val('');
                        $('.reminder').prop('checked', false);
                        $('.reminder').eq(0).prop('checked', true);
                    }
                })
            });

            // 点击标记完成
            $('.btn_mark', $modalEle).unbind('click').click(function() {
            // $('.btn_mark', $modalEle).on('click', function(){
                h.taskInfoModal.taskInfo.taskStatus = '1';
                // 同时更新进度
                h.taskInfoModal.taskInfo.progress = 100;


                $modalEle.find('.progress-bar').css('width', 100 + '%');
                $modalEle.find('.progress_btn').css('left', 100 + '%');
                $modalEle.find('.progress_num').css('left', 100 + '%').text(100 + '%');
                $modalEle.find('.btn_mark').hide();
                $modalEle.find('.btn_cancel_mark').show();
                $modalEle.find('.btn_urge').hide();


                // updateTaskInfo(2);
                // $modalEle.modal('hide');
            });

            // 点击标记未完成
            $('.btn_cancel_mark', $modalEle).unbind('click').click(function() {
            // $('.btn_cancel_mark', $modalEle).on('click', function(){
                h.taskInfoModal.taskInfo.taskStatus = '0';
                // 同时更新进度
                h.taskInfoModal.taskInfo.progress = 0;


                $modalEle.find('.progress-bar').css('width', 0 + '%');
                $modalEle.find('.progress_btn').css('left', 0 + '%');
                $modalEle.find('.progress_num').css('left', 0 + '%').text(0 + '%');
                $modalEle.find('.btn_mark').show();
                $modalEle.find('.btn_cancel_mark').hide();
                $modalEle.find('.btn_urge').show();


                // updateTaskInfo(3);
                // $modalEle.modal('hide');
            });

            // 点击关注
            $('.btn_attention', $modalEle).unbind('click').click(function() {
            // $('.btn_attention', $modalEle).on('click', function(){
                h.taskInfoModal.taskInfo.follow = 1;

                $modalEle.find('.btn_cancel_attention').show();
                $modalEle.find('.btn_attention').hide();


                // updateTaskInfo(4);
                // $modalEle.modal('hide');
            });

            // 取消关注
            $('.btn_cancel_attention', $modalEle).unbind('click').click(function() {
            // $('.btn_cancel_attention', $modalEle).on('click', function(){
                h.taskInfoModal.taskInfo.follow = 2;

                $modalEle.find('.btn_attention').show();
                $modalEle.find('.btn_cancel_attention').hide();

                // updateTaskInfo(5);
                // $modalEle.modal('hide');
            });

            // 点击删除任务

            $('.btn_del', $modalEle).on('click', function(){
                layer.confirm('确定要删除该任务吗？', {
                    btn: ['确定','取消'], //按钮
                    title:"删除任务"
                }, function(){
                    //确定删除，调接口
                    $.post(basePath+'task/deleteTaskManage', {taskId: h.taskInfoModal.taskInfo.taskId}, function(res){
                        if (res.flag) {
                            var $listItem = $('#type'+h.taskInfoModal.taskInfo.typeId);
                            layer.closeAll();
                            $modalEle.modal('hide');
                            $.message('任务已删除');
                            initTaskItemList(h.taskInfoModal.taskInfo.typeId, {}, $listItem);
                        } else {
                            $.message({
                                message: '删除任务失败',
                                type: 'danger'
                            });
                        }
                    });
                }, function(){
                    layer.closeAll();
                });
            });

            // 修改任务名称
            $('.body_title input', $modalEle).on('blur', function(){
                if (h.taskInfoModal.loginUserType == '2' || h.taskInfoModal.loginUserType == '3') {
                    return false;
                }
                var taskName = $(this).val().trim();
                if (!taskName) {
                    $(this).val(h.taskInfoModal.taskInfo.taskName);
                } else {
                    h.taskInfoModal.taskInfo.taskName = taskName;
                }
            });

            // 设置进度条拖拽
            $('.progress_btn', $modalEle).on('mousedown', function (event) {
                if (h.taskInfoModal.loginUserType == '2' || h.taskInfoModal.loginUserType == '3') {
                    return false;
                }
                if (h.taskInfoModal.taskInfo.taskStatus == 1) {
                    return false;
                }
                var _this = this;
                var $progress = $(this).parents('.progress');
                var $progress_bar = $(this).siblings('.progress-bar');
                var progressW = $progress.width();
                var bar_offset = $progress_bar.offset().left;
                var offset = 0;
                $(document).on("mousemove", function (event) {
                    moveFlag = true;
                    event = event || window.event;
                    var pageX = event.pageX;
                    offset = pageX - bar_offset;
                    offset = offset < 0 ? 0 : offset > progressW ? progressW : offset;
                    offset = offset / progressW * 100;
                    $(_this).css("left", offset + "%");
                    $(_this).siblings('.progress_num').css("left", offset + "%").text(Math.round(offset) + "%");
                    $progress_bar.css("width", offset + "%");
                    h.taskInfoModal.taskInfo.progress = Math.round(offset);
                })
            });

            // 取消进度条拖拽
            $(document).on("mouseup", function () {
                $(document).off("mousemove");

                if (moveFlag) {
                    if (h.taskInfoModal.taskInfo.progress == 100) {
                        h.taskInfoModal.taskInfo.taskStatus = '1';
                        $modalEle.find('.btn_mark').hide();
                        $modalEle.find('.btn_cancel_mark').show();
                        $modalEle.find('.btn_urge').hide();
                    } else {
                        h.taskInfoModal.taskInfo.taskStatus = '0';
                        $modalEle.find('.btn_mark').show();
                        $modalEle.find('.btn_cancel_mark').hide();
                        $modalEle.find('.btn_urge').show();
                    }
                }
                moveFlag = false;
            });

            // 修改起始日
            $('#taskbegindate', $modalEle).on('click', function(e) {
                if (h.taskInfoModal.loginUserType == '2' || h.taskInfoModal.loginUserType == '3') {
                    return false;
                }
                laydate.render({
                    elem: '#taskbegindate',
                    type: 'date',
                    format: 'yyyy-MM-dd',
                    show: true,
                    trigger: 'click',
                    done: function(value){
                        var sDate = formatTime(value);
                        var eDate = formatTime($('#taskenddate').val());
                        if (sDate > eDate) {
                            $.message({
                                message:'起始日不能大于到期日',
                                type: 'danger'
                            });
                            $modalEle.find('#taskbegindate').val(h.taskInfoModal.taskInfo.startDate);
                            return false;
                        }

                        h.taskInfoModal.taskInfo.startDate = value;
                    }
                });
            });

            // 修改到期日
            $('#taskenddate', $modalEle).on('click', function(e) {
                if (h.taskInfoModal.loginUserType == '2' || h.taskInfoModal.loginUserType == '3') {
                    return false;
                }
                // 修改到期日
                laydate.render({
                    elem: '#taskenddate',
                    type: 'date',
                    format: 'yyyy-MM-dd',
                    trigger: 'click',
                    show: true,
                    done: function(value){
                        var sDate = formatTime($('#taskbegindate').val());
                        var eDate = formatTime(value);
                        if (sDate > eDate) {
                            $.message({
                                message:'到期日不能小于起始日',
                                type: 'danger'
                            })
                            $modalEle.find('#taskenddate').val(h.taskInfoModal.taskInfo.endDate);
                            return false;
                        }
                        h.taskInfoModal.taskInfo.endDate = value;
                    }
                });
            });

            // 修改评分
            $('.task_grade', $modalEle).on('blur', function(e){
                if (h.taskInfoModal.loginUserType == '2' || h.taskInfoModal.loginUserType == '3') {
                    return false;
                }
                var taskGrade = parseInt($(this).val());
                h.taskInfoModal.taskInfo.taskGrade = taskGrade;
            });

            // 修改重要程度
            $('.btn_important', $modalEle).on('click', function(){
                if (h.taskInfoModal.loginUserType == '2' || h.taskInfoModal.loginUserType == '3') {
                    return false;
                }
                $(this).siblings().removeClass('active');
                $(this).addClass('active');
                var importantLevel = $(this).data('importantlevel');
                if (h.taskInfoModal.taskInfo.importantLevel == parseInt(importantLevel)) {
                    return false;
                }
                h.taskInfoModal.taskInfo.importantLevel = parseInt(importantLevel);
            });
            //变更历史

            $('#myTab li').unbind('click').click(function() {
                //评论
                if($(this).attr('id') == 'comment'){
                    $('#myTabContent').css('display','block')
                    $('#myTabContent2').css('display','none')
                }
            //    历史
                if($(this).attr('id') == 'change'){
                    $('#history').html(' ')
                    $('#myTabContent2').css('display','block')
                    $('#myTabContent').css('display','none')
                    biangeng()

                }
            })

            var  taskIdsss =  h.taskInfoModal.taskInfo.taskId // 任务主键id
            //变更历史
            function biangeng(){
                $.ajax({
                    url: '/taskChangeRecord/byConditionTaskId',
                    type: 'post',
                    dataType: 'json',
                    data: {
                        taskId:taskIdsss
                    },
                    success: function (res) {
                        var str= ''
                        for(var i=0;i<res.obj.length;i++){

                            var ptext = res.obj[i].changeContent
                            var ptextS  = ptext.split("*")
                            var strp = ''
                            for(var k=0;k<ptextS.length;k++){
                                strp += '<p class="layui-timeline-title">'+ptextS[k]+'</p>'
                            }
                            var createTime = res.obj[i].createTime.split(' ')[0]

                            var str ='<li class="layui-timeline-item">\n' +
                                '\t\t\t\t\t\t\t\t\t\t\t\t<i class="layui-icon layui-timeline-axis"></i>\n' +
                                '\t\t\t\t\t\t\t\t\t\t\t\t<div class="layui-timeline-content layui-text">\n' +
                                '\t\t\t\t\t\t\t\t\t\t\t\t\t<h3 class="layui-timeline-title">'+res.obj[i].createTime+'</h3>\n' +
                                '\t\t\t\t\t\t\t\t\t\t\t\t\t<p class="layui-timeline-title">'+res.obj[i].userName+'变更内容</p>\n' +
                                '                          <div>'+strp+'</div>\n'+
                                '\t\t\t\t\t\t\t\t\t\t\t\t</div>\n' +
                                '\t\t\t\t\t\t\t\t\t\t\t</li>'
                            $('#history').append(str)
                        }
                    }
                })
            }

            // 修改负责人
            $('.icon-change-creator', $modalEle).on('click', function(){
                user_id = 'taskModalCreator';
                $.ajax({
                    url:'/imfriends/getIsFriends',
                    type:'get',
                    dataType:'json',
                    data:{},
                    success:function(obj){
                        if(obj.object == 1){
                            $.popWindow("../common/selectUserIMAddGroup?0");
                        }else{
                            $.popWindow("../common/selectUser?0");
                        }
                    },
                    error:function(res){
                        $.popWindow("../common/selectUser?0");
                    }
                });
            });

            // 修改参与人
            $('.add_modal_joiner', $modalEle).on('click', function(){
                user_id = 'taskModalJoiner';
                $.ajax({
                    url:'/imfriends/getIsFriends',
                    type:'get',
                    dataType:'json',
                    data:{},
                    success:function(obj){
                        if(obj.object == 1){
                            $.popWindow("../common/selectUserIMAddGroup");
                        }else{
                            $.popWindow("../common/selectUser");
                        }
                    },
                    error:function(res){
                        $.popWindow("../common/selectUser");
                    }
                });
            });
            // 清空参与人
            $('.clear_modal_joiner', $modalEle).on('click', function(){
                $('#taskModalJoiner', $modalEle).attr('user_id', '');
                $('#taskModalJoiner', $modalEle).val('');
            });

            // 修改分享人
            // 清空分享人
            $('.clear_modal_shared', $modalEle).on('click', function(){
                $('#taskModalShared', $modalEle).attr('user_id', '');
                $('#taskModalShared', $modalEle).val('');
            });

            // 修改任务详情
            $('.add_modal_shared', $modalEle).on('click', function(){
                user_id = 'taskModalShared';
                $.ajax({
                    url:'/imfriends/getIsFriends',
                    type:'get',
                    dataType:'json',
                    data:{},
                    success:function(obj){
                        if(obj.object == 1){
                            $.popWindow("../common/selectUserIMAddGroup");
                        }else{
                            $.popWindow("../common/selectUser");
                        }
                    },
                    error:function(res){
                        $.popWindow("../common/selectUser");
                    }
                });
            });
            $('.task_desc', $modalEle).on('blur', function(){
                if (h.taskInfoModal.loginUserType == '2' || h.taskInfoModal.loginUserType == '3') {
                    return false;
                }
               var value = $(this).val().trim();
               if (value) {
                   h.taskInfoModal.taskInfo.taskDesc = value;
               }
            });

            // 显示新增子任务输入框
            $('.add_child_task', $modalEle).on('click', function(){
                $(this).find('.child_task_box').show();
            });

            var taskManages = ''
            var taskManagesnum = 0
            // 添加子任务
            // $('.child_task_name', $modalEle).unbind('blur').click(function() {
            // $('.child_task_name', $modalEle).on('blur', function(){
            $('.savesontask').unbind('click').click(function() {
                var _this = $('.child_task_name');
                var value = $('.child_task_name').val().trim();
                if (!value) {
                    $(this).val('');
                    return false;
                }
                taskManages += value+'、'
                var date = new Date();
                var createDate = date.getFullYear() + '-' + ((date.getMonth() + 1) < 10 ? '0' + (date.getMonth() + 1) : (date.getMonth() + 1)) + '-' + (date.getDate() < 10 ? '0' + date.getDate() : date.getDate());

                var data = {
                    taskId: 0,
                    taskName: value,
                    taskDesc: '',
                    importantLevel: 0,
                    createUser: h.createUser.userId,
                    manageUser: h.createUser.userId,
                    taskStatus: '0',
                    createDate: createDate,
                    startDate: createDate,
                    endDate: createDate,
                    parentId: h.taskInfoModal.taskInfo.taskId,
                    progress: 0,
                    taskGrade: 0,
                    completeDate: '',
                    typeId: h.taskInfoModal.taskInfo.typeId,
                    attachmentId: '',
                    attachmentName: '',
                    participate: '',
                    shared: '',
                    follow: 0
                }
                $.ajax({
                    type: 'post',
                    url: basePath + "task/addTaskManage",
                    dataType: 'json',
                    data: data,
                    success: function (res) {
                        if (res.flag) {
                            $(_this).val('');
                            h.taskInfoModal.complateObj.taskCount += 1;
                            $('.comple_unfinsh', $modalEle).text(h.taskInfoModal.complateObj.taskCount-h.taskInfoModal.complateObj.completedCount);
                            $('.comple_total', $modalEle).text(h.taskInfoModal.complateObj.taskCount);
                            var $item = $('<li class="child_task_item task_new"><a href="javascript:;">'+value+'</a></li>');
                            $(_this).parents('.add_child_task').before($item);
                            taskManagesnum++
                            // 重新渲染该列表下的任务
                            initTaskItemList(h.taskInfoModal.taskInfo.typeId, {}, $('#type'+h.taskInfoModal.taskInfo.typeId));
                        } else {
                            $.message({
                                message: '新增子任务失败',
                                type: 'danger'
                            });
                        }
                    },
                    error: function(err) {
                        $.message({
                            message: '新增子任务失败',
                            type: 'danger'
                        });
                    }
                });

            });

            //附件上传方法
            $('#uploadinputimg', $modalEle).on('click', function(){
                if (h.taskInfoModal.loginUserType == '2' || h.taskInfoModal.loginUserType == '3') {
                    return false;
                }
            });
            $('#uploadinputimg').fileupload({
                dataType:'json',
                done: function (e, data) {
                    if(data.result.obj != ''){
                        var data = data.result.obj;
                        var str = '';
                        var flag = true;
                        for (var i = 0; i < data.length; i++) {
                            var gs = data[i].attachName.split('.')[1];
                            if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){ //后缀为这些的禁止上传
                                str += '';
                                layer.alert('jsp、css、js、html、java文件禁止上传!',{},function(){
                                    layer.closeAll();
                                });
                                flag = false;
                            }else{
                                var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
                                var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;

                                str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + data[i].attachName + '*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                                h.taskInfoModal.taskInfo.attachmentId += data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',';
                                h.taskInfoModal.taskInfo.attachmentName += data[i].attachName + '*'
                            }
                        }
                        if (flag) {
                            // updateTaskInfo();
                        }
                        $('.modal_file_box', $modalEle).append(str);
                    }else{
                        layer.alert('添加附件大小不能为空!',{},function(){
                            layer.closeAll();
                        });
                    }
                }
            });

            //删除编辑中的附件
            $modalEle.on('click','.deImgs',function(){
                if (h.taskInfoModal.loginUserType == '2' || h.taskInfoModal.loginUserType == '3') {
                    return false;
                }
                var aId = $(this).siblings('.inHidden').val().replace(/,$/gi,"");
                var data=$(this).parents('.dech').attr('deUrl');
                var dome=$(this).parents('.dech');
                layer.confirm('确定删除此附件？', {
                    btn: ['确定','取消'], //按钮
                    title:"删除附件"
                }, function(){
                    var attachmentIds = h.taskInfoModal.taskInfo.attachmentId.replace(/,$/gi,"").split(',');
                    var attachmentNames = h.taskInfoModal.taskInfo.attachmentName.replace(/\*$/gi,"").split('*');
                    for (var i = 0; i < attachmentIds.length; i++) {
                        if (aId == attachmentIds[i]) {
                            attachmentIds.splice(i,1);
                            attachmentNames.splice(i,1);
                            break;
                        }
                    }
                    h.taskInfoModal.taskInfo.attachmentId = attachmentIds.join(',') + ',';
                    h.taskInfoModal.taskInfo.attachmentName = attachmentNames.join('*') + '*';
                    //确定删除，调接口
                    $.ajax({
                        type: 'get',
                        url: '../delete',
                        dataType: 'json',
                        data: data,
                        success: function (res) {
                            layer.closeAll();
                            if (res.flag == true) {
                                dome.remove();
                                // updateTaskInfo();
                            } else {
                                $.message({
                                    message: '删除失败',
                                    type: 'danger'
                                });
                            }
                        }
                    });
                }, function(){
                    layer.closeAll();
                });

            });
            // 发布评论
            var flag = true;
            $('.btn_publish', $modalEle).on('click', function(){
                if(flag){
                    flag = false
                    var txt = ue.getContentTxt().trim();
                    var createDate = getTime();
                    var data = {
                        feedbackContent: txt,
                        userId: h.createUser.userId,
                        taskId: h.taskInfoModal.taskInfo.taskId,
                        parentId: 0,
                        createTime: createDate
                    }
                    if (!txt) {
                        return false;
                    }
                    $.post(basePath+'task/addTaskFeedback', data, function(res){
                        if (res.flag) {
                            ue.setContent('');
                            $.get(basePath+'task/queryTaskManageByTaskId', {taskId: h.taskInfoModal.taskInfo.taskId}, function(res){
                                flag = true
                                if (res.flag) {
                                    var data = res.obj[0];
                                    if (data.taskFeedbacks && data.taskFeedbacks.length > 0) {
                                        $('.feedback_ul', $modalEle).empty();
                                        data.taskFeedbacks.forEach(function(p){
                                            if (p.parentId === 0) {
                                                var $p = newTaskFeedback(p);
                                                if (p.taskFeedbacks.length > 0) {
                                                    p.taskFeedbacks.forEach(function(c){
                                                        var $c = newTaskFeedback(c);
                                                        $p.find('.child_feedback_ul').prepend($c);
                                                    });
                                                }
                                                $('.feedback_ul', $modalEle).prepend($p);
                                            }
                                        })
                                    }
                                }
                            });
                        }
                    });
                }

            });

            // 回复评论
            $modalEle.on('click', '.btn_recall', function(event){
                if (event.stopPropagation) {
                    event.stopPropagation();
                } else if (window.event) {
                    window.event.cancelBubble = true;
                }
                $(this).parents('.feedback_li').find('.re_eidter').show(0, function(){
                    h.editorIndex++;
                    var myScript = $('<script id="re_container'+h.editorIndex+'" type="text/plain" style="width: 100%;"></script>');
                    $(this).find('button').before(myScript);
                    ue2 = UE.getEditor('re_container'+h.editorIndex, {
                        toolbars: [
                            ['fullscreen', 'undo', 'redo', 'italic', 'underline', 'fontfamily', 'fontsize', 'emotion', 'spechars', 'justifyleft', 'justifyright', 'justifycenter', 'justifyjustify', 'forecolor', 'backcolor', 'attachment']
                        ],
                        elementPathEnabled: false,
                    });
                });
            });

            // 发布子评论
            $modalEle.on('click', '.btn_feed', function(){
                var parentId = $(this).parents('.feedback_p').data('feedbackid');
                var txt = ue2.getContentTxt().trim();
                var createDate = getTime();
                if (!txt) {
                    return false;
                }
                var data = {
                    feedbackContent: txt,
                    userId: h.createUser.userId,
                    taskId: h.taskInfoModal.taskInfo.taskId,
                    parentId: parseInt(parentId),
                    createTime: createDate
                }
                $.post(basePath+'task/addTaskFeedback', data, function(res){
                    if (res.flag) {
                        var $newFeedback = newTaskFeedback(data);
                        $('#feedback'+parentId).find('.child_feedback_ul').prepend($newFeedback);
                    }
                });
            });
            var arrHistory = []
            // // 点击确定
            $(".update_task_info").unbind('click').click(function() {
                updateTaskInfo();
                $modalEle.modal('hide');

            });
            h.taskInfoModal.taskInfo.manageUser = $('#taskModalCreator', $modalEle).attr('user_id').replace(',','') || '';
            h.taskInfoModal.taskInfo.manageUserName = $('#taskModalCreator', $modalEle).val().replace(',','');
            h.taskInfoModal.taskInfo.participate = $('#taskModalJoiner', $modalEle).attr('user_id') || '';
            h.taskInfoModal.taskInfo.shared = $('#taskModalShared', $modalEle).attr('user_id') || '';

            if (h.taskInfoModal.taskInfo.createUser.length == 0) {
                $.message({
                    message: '请选择负责人',
                    type: 'danger'
                });
                return false;
            }


            var data = {
                taskId: h.taskInfoModal.taskInfo.taskId, // 任务主键id
                taskName: h.taskInfoModal.taskInfo.taskName, // 任务名称
                taskDesc: h.taskInfoModal.taskInfo.taskDesc || '', // 任务详情
                importantLevel: h.taskInfoModal.taskInfo.importantLevel, //重要程度 0普通 1重要 2紧急 传数字类型
                createUser: h.taskInfoModal.taskInfo.createUser, // 创建人Id
                manageUser: h.taskInfoModal.taskInfo.manageUser, //负责人Id
                taskStatus: h.taskInfoModal.taskInfo.taskStatus, //任务状态
                startDate: h.taskInfoModal.taskInfo.startDate, //开始时间
                endDate: h.taskInfoModal.taskInfo.endDate, //结束时间
                parentId: h.taskInfoModal.taskInfo.parentId, //父任务Id
                progress: h.taskInfoModal.taskInfo.progress, //任务进度 传数字类型
                taskGrade: h.taskInfoModal.taskInfo.taskGrade, // 评分
                typeId: h.taskInfoModal.taskInfo.typeId, //任务类型id
                attachmentId: h.taskInfoModal.taskInfo.attachmentId || '', // 附件id
                attachmentName: h.taskInfoModal.taskInfo.attachmentName || '', // 附件名字
                participate: h.taskInfoModal.taskInfo.participate, //参与者 拼接用户id用，连接
                shared: h.taskInfoModal.taskInfo.shared,//共享者 拼接用户id用，连接
                follow: h.taskInfoModal.taskInfo.follow,//是否关注  取消关注2 关注1 默认 0
                sharedName:h.taskInfoModal.taskInfo.sharedName
            }

            var history = data


            // 修改任务方法
            function updateTaskInfo (optType) {
                h.taskInfoModal.taskInfo.manageUser = $('#taskModalCreator', $modalEle).attr('user_id').replace(',','') || '';
                h.taskInfoModal.taskInfo.manageUserName = $('#taskModalCreator', $modalEle).val().replace(',','');
                h.taskInfoModal.taskInfo.participate = $('#taskModalJoiner', $modalEle).attr('user_id') || '';
                h.taskInfoModal.taskInfo.shared = $('#taskModalShared', $modalEle).attr('user_id') || '';

                if (h.taskInfoModal.taskInfo.createUser.length == 0) {
                    $.message({
                        message: '请选择负责人',
                        type: 'danger'
                    });
                    return false;
                }

                var data = {
                    taskId: h.taskInfoModal.taskInfo.taskId, // 任务主键id
                    taskName: h.taskInfoModal.taskInfo.taskName, // 任务名称
                    taskDesc: h.taskInfoModal.taskInfo.taskDesc || '', // 任务详情
                    importantLevel: h.taskInfoModal.taskInfo.importantLevel, //重要程度 0普通 1重要 2紧急 传数字类型
                    createUser: h.taskInfoModal.taskInfo.createUser, // 创建人Id
                    manageUser: h.taskInfoModal.taskInfo.manageUser, //负责人Id
                    taskStatus: h.taskInfoModal.taskInfo.taskStatus, //任务状态
                    startDate: h.taskInfoModal.taskInfo.startDate, //开始时间
                    endDate: h.taskInfoModal.taskInfo.endDate, //结束时间
                    parentId: h.taskInfoModal.taskInfo.parentId, //父任务Id
                    progress: h.taskInfoModal.taskInfo.progress, //任务进度 传数字类型
                    taskGrade: h.taskInfoModal.taskInfo.taskGrade, // 评分
                    typeId: h.taskInfoModal.taskInfo.typeId, //任务类型id
                    attachmentId: h.taskInfoModal.taskInfo.attachmentId || '', // 附件id
                    attachmentName: h.taskInfoModal.taskInfo.attachmentName || '', // 附件名字
                    participate: h.taskInfoModal.taskInfo.participate, //参与者 拼接用户id用，连接
                    shared: h.taskInfoModal.taskInfo.shared,//共享者 拼接用户id用，连接
                    follow: h.taskInfoModal.taskInfo.follow//是否关注  取消关注2 关注1 默认 0
                }
                var changeContent = ''
                var importantLevel = ''
                //参与人
                var participate1 = $('#taskModalJoiner', $modalEle).attr('username')
                //共享人
                var sharedName = $('#taskModalShared', $modalEle).attr('username')
                // 0普通 1重要 2紧急
                if(h.taskInfoModal.taskInfo.importantLevel == 0){
                    importantLevel = '普通'
                }else if(h.taskInfoModal.taskInfo.importantLevel == 1){
                    importantLevel = '重要'
                }else {
                    importantLevel = '紧急'
                }
                var participate= ''
                if(data.manageUser != history.manageUser){
                    changeContent = '负责人：'+h.taskInfoModal.taskInfo.manageUser+'*'
                }
                if(data.progress != history.progress){
                    changeContent +='进度：'+ h.taskInfoModal.taskInfo.progress+'*'
                }
                if(data.startDate != history.startDate){
                    changeContent +='开始时间：'+ h.taskInfoModal.taskInfo.startDate+'*'
                }
                if(data.endDate != history.endDate){
                    changeContent +='结束时间：'+ h.taskInfoModal.taskInfo.endDate+'*'
                }
                if(data.importantLevel != history.importantLevel){
                    changeContent +='重要程度：'+ importantLevel+','
                }
                if(data.participate != history.participate){
                    changeContent +='参与人：'+ participate1+'*'
                }
                if(data.shared != history.shared){
                    changeContent +='共享人：'+ sharedName+'*'
                }
                if(data.taskDesc != history.taskDesc){
                    changeContent +='任务详情：'+ h.taskInfoModal.taskInfo.taskDesc+'*'
                }
                if(data.attachmentName != history.attachmentName){
                    changeContent +='附件：'+ h.taskInfoModal.taskInfo.attachmentName+'*'
                }
                if(taskManagesnum !=0){
                    changeContent +='子任务：'+ taskManages+'*'
                }


                // taskFeedbacks

                $.ajax({
                    url: '/taskChangeRecord/addTaskRecord',
                    type: 'post',
                    dataType: 'json',
                    data: {
                        taskId: h.taskInfoModal.taskInfo.taskId, // 任务主键id
                        taskName: h.taskInfoModal.taskInfo.taskName, // 任务名称
                        changeContent:changeContent//变更内容
                    },
                    success: function (res) {

                    }
                })
                $.ajax({
                    url: basePath+'task/updateTaskManage',
                    type: 'post',
                    dataType: 'json',
                    data: data,
                    success: function(res){

                        if (res.flag) {
                            $.message('修改成功');
                            var $taskItem = newTaskItem(h.taskInfoModal.taskInfo);
                            $('#task'+h.taskInfoModal.taskInfo.taskId).replaceWith($taskItem);

                            // if (optType == 2) { // 标记完成
                            //     $modalEle.find('.progress-bar').css('width', 100 + '%');
                            //     $modalEle.find('.progress_btn').css('left', 100 + '%');
                            //     $modalEle.find('.progress_num').css('left', 100 + '%').text(100 + '%');
                            //     $modalEle.find('.btn_mark').hide();
                            //     $modalEle.find('.btn_cancel_mark').show();
                            //     $modalEle.find('.btn_urge').hide();
                            // } else if (optType == 3) { // 标记未完成
                            //     $modalEle.find('.progress-bar').css('width', 0 + '%');
                            //     $modalEle.find('.progress_btn').css('left', 0 + '%');
                            //     $modalEle.find('.progress_num').css('left', 0 + '%').text(0 + '%');
                            //     $modalEle.find('.btn_mark').show();
                            //     $modalEle.find('.btn_cancel_mark').hide();
                            //     $modalEle.find('.btn_urge').show();
                            // } else if (optType == 4) { // 点击关注
                            //     $modalEle.find('.btn_cancel_attention').show();
                            //     $modalEle.find('.btn_attention').hide();
                            // } else if (optType == 5) { // 取消关注
                            //     $modalEle.find('.btn_attention').show();
                            //     $modalEle.find('.btn_cancel_attention').hide();
                            // }
                            // window.location.reload()
                        } else {
                            if (optType == 2) {
                                $.message({
                                    message: res.msg,
                                    type: 'danger'
                                });
                            } else {
                                $.message({
                                    message: res.msg,
                                    type: 'danger'
                                });
                            }
                        }

                    },
                    error: function(err) {
                        $.message({
                            message: '修改失败',
                            type: 'danger'
                        });
                    }
                });
            }

        },
        init: function () {
            var h = this;

            // 初始化列表展示盒子的大小
            $('.content_wrapper').css({
                'top': function () {
                    var top = $('.search_box').offset().top + $('.search_box').outerHeight(true);
                    return top + 'px';
                }
            });

            // 获取当前用户信息
            $.get("queryUser", function(res){
                if (res.flag) {
                    h.createUser = res.data;
                }
            }, 'json');

            initContentWidth();

            setUISize();

            initTaskList();

            h.tableEvents();

            h.events()

            var qTaskId = getQueryString('taskId');
            // 从提醒跳转过来，默认显示任务详情
            if (qTaskId) {
                // 获取任务详情
                $.get(basePath+'task/queryTaskManageByTaskId', {taskId: qTaskId}, function(res){
                    if (res.flag) {
                        h.initTaskModal(res.obj[0], $('#taskInfoModal'));
                    }
                });

                $('#taskInfoModal').modal('show');
            }


        }
    }

    info.init();

    // 获取url参数
    function getQueryString (name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return r[2];
        return '';
    }

    // 初始化内容区域宽度
    function initContentWidth() {
        $('.content_list').css({
            'width': function () {
                var $children = $('.content_list').children();
                return $children.length * ($children.eq(0).outerWidth() + 10) + 'px';
            }
        });
    }

    // 重置任务内容区域高度
    function resetSize() {
        var headHeight = $('.panel-heading').outerHeight();
        var itemHeight = $('.content_list').outerHeight();
        $('.panel-content').css({
            'height': function () {
                return itemHeight - headHeight - 30 + 'px';
            }
        });
    }

    // 设置任务内容滚动
    function setP_contentScroll(ele, isInit, callback) {

        var $p_content = $(ele).parents('.panel-content');
        var $p_body = $p_content.find('.panel-body');
        var $p_footer = $p_content.find('.panel-footer');
        var c_height = $p_content.outerHeight();
        var b_height = $p_body.outerHeight();
        var m_height = $p_footer.outerHeight();
        var offset_right = getScrollbarWidth();
        offset_right = offset_right > 15 ? 15 : offset_right;
        if (!!isInit) {
            if (c_height < b_height + m_height) {
                $p_content.addClass('scroll');
                $p_body.css('margin-right', -offset_right + 'px');
                $p_footer.css('margin-right', -offset_right + 'px');
            } else {
                $p_content.removeClass('scroll');
                $p_body.css('margin-right', 0 + 'px');
                $p_footer.css('margin-right', 0 + 'px');
            }
        } else {
            if (c_height < b_height + m_height && callback) {
                $p_content.addClass('scroll');
                $p_body.css('margin-right', -offset_right + 'px');
                $p_footer.css('margin-right', -offset_right + 'px');
                return callback(true, b_height);
            } else {
                $p_content.removeClass('scroll');
                $p_body.css('margin-right', 0 + 'px');
                $p_footer.css('margin-right', 0 + 'px');
            }
        }
    }

    // 初始化每个任务列表高度
    function setUISize() {
        var $items = $('.edit_task_name');
        $items.each(function (index, ele) {
            setP_contentScroll(ele, true);
        });
    }

    // 获取滚动条宽度
    function getScrollbarWidth() {
        var scrollDiv = document.createElement("div");
        scrollDiv.style.cssText = 'width: 99px; height: 99px; overflow: scroll; position: absolute; top: -9999px;';
        document.body.appendChild(scrollDiv);
        var scrollbarWidth = scrollDiv.offsetWidth - scrollDiv.clientWidth;
        document.body.removeChild(scrollDiv);
        return scrollbarWidth;
    }

    // 监听页面大小改变
    $(window).on('resize',function () {
        resetSize();
        setUISize();
    });

    //写日志页面富文本编辑器
    var ue = UE.getEditor('word_container', {
        toolbars: [
            ['fullscreen', 'undo', 'redo', 'italic', 'underline', 'fontfamily', 'fontsize', 'emotion', 'spechars', 'justifyleft', 'justifyright', 'justifycenter', 'justifyjustify', 'forecolor', 'backcolor', 'attachment', 'link']
        ],
        elementPathEnabled: false,
    });
    var ue2 = null;


    // 生成新列表项
    function newTaskList(data) {
        // 生成列表项dom节点
        var $listItem = $('<li class="content_list_item" style="height: 100%">'+
            '<div class="panel panel-default">'+
            '<div class="panel-heading">'+
            '<h2 style="height: 20px;" class="panel-title"><span title="'+data.typeName+'" class="list_title">'+data.typeName+
            '</span><button type="button" style="float: right;" class="btn_show_menu">'+
            '<span class="glyphicon glyphicon-menu-hamburger icon-down"></span>'+
            '</button>'+
            '</h2>'+
            '<ul class="task_name_menu">'+
            '<li><a href="javascript:;" class="btn_to_edit">编辑列表</a></li>'+
            '<li><a href="javascript:;" class="btn_del_tasklist">删除列表</a></li>'+
            '<li class="edit_menu">'+
            '<form>'+
            '<div class="form-froup edit_menu_title">'+
            '<p>编辑列表<span class="glyphicon glyphicon-remove close_menu"></span></p>'+
            '</div>'+
            '<div class="form-froup" style="margin-bottom: 10px;">'+
            '<input type="text" class="form-control nwe_list_name" placeholder="请输入列表名称" />'+
            '</div>'+
            '<div class="form-froup">'+
            '<button type="button" class="btn btn-primary btn_save_list" style="width: 100%;">保存</button>'+
            '</div>'+
            '</form>'+
            '</li>'+
            '</ul>'+
            '</div>'+
            '<div class="panel-content-box">'+
            '<div class="panel-content">'+
            '<div class="panel-body">'+
            '<ul class="task_list"></ul>'+
            '</div>'+
            '<div class="panel-footer">'+
            '<form>'+
            '<div class="form-group">'+
            '<div class="input-group">'+
            '<input type="text" class="form-control edit_task_name" placeholder="请输入任务名称">'+
            '<span class="input-group-addon btn_add_task add_new_task" style="background: #dcdcdc">'+
            '<span class="glyphicon glyphicon-plus-sign icon-add-task"></span>'+
            '</span>'+
            '</div>'+
            '</div>'+
            '<div class="form-group edit-form cfix">'+
            '<div class="creator_box">'+
            '<div class="creator_name"><input id="manageUser'+data.typeId+'" class="c_name" user_id="" disabled style="width: auto;text-align: center;background-color: transparent;" value=""></div>'+
            '<span class="glyphicon glyphicon-plus-sign icon-change-creator form_add_creator" style="top: 3px;"></span>'+
            '</div>'+
            '<div class="joiner cfix">'+
            '<h4>参与者</h4>'+
            '<textarea class="joiner_ids" id="joiner'+data.typeId+'" disabled rows="2" style="width: 80%; resize: none;border-radius: 3px;" user_id=""></textarea>'+
            '<a href="javascript:;" class="form_add_joiner" style="float: right;color: blue;text-decoration: none;">添加</a>'+
            '<a href="javascript:;" class="form_clear_joiner" style="float: right;margin-top: -27px;color: red;text-decoration: none;">清空</a>'+
            '</div>'+
            '<div class="important">'+
            '<label class="btn_important normal" data-importantlevel="0"><span class="glyphicon glyphicon-ok"></span>普通</label>'+
            '<label class="btn_important urgent" data-importantlevel="1"><span class="glyphicon glyphicon-ok"></span>重要</label>'+
            '<label class="btn_important crucial" data-importantlevel="2"><span class="glyphicon glyphicon-ok"></span>紧急</label>'+
            '</div>'+
            '<div class="task_end_date">'+
            '<h4>到期日</h4>'+
            '<div class="input-group date_input">'+
            '<input class="form-control task_date" id="enddate'+data.typeId+'" placeholder="到期日" type="text" readonly="readonly">'+
            ' <span class="input-group-addon btn_add_task" style="background: #dcdcdc">'+
            '<span class="glyphicon glyphicon-time icon-add-task"></span>'+
            '</span>'+
            '</div>'+
            '</div>'+
            '<button type="button" class="btn btn-primary btn_new_task">创建</button>'+
            '<button type="button" class="btn btn-default close_task_form">关闭</button>'+
            '</div>'+
            '</form>'+
            '</div>'+
            '</div>'+
            '</div>'+
            '</div>'+
            '</li>');

        $listItem.attr('id', 'type'+data.typeId);
        $listItem.attr('typeId', data.typeId);

        // 将数据保存到dom节点中
        $listItem.data('listData', data);

        return $listItem;
    }

    // 生成具体任务项
    function newTaskItem(data) {
        // 截取日期为 YYYY-MM-DD
        var endDate = data.endDate.split(' ')[0];
        // 判断任务重要程度和完成状态
        var importantClass = '';
        var checkBoxStr = '<span class="glyphicon glyphicon-ok check_box task_toggle"></span>';
        if (data.taskStatus == 1) { // 已结束
            importantClass = 'end';
            checkBoxStr = '<span class="glyphicon glyphicon-ok check_box task_toggle on"></span>';
        } else if (data.importantLevel == 2){ // 重要
            importantClass = 'r';
        } else if (data.importantLevel == 1) { // 紧急
            importantClass = 'y';
        }
        // 用户头像区域显示处理
        var userInfo = ''
        if (data.avatar) { // 有头像显示头像
            userInfo = '<img src="/img/user/boy.png" alt="头像">'
        } else { // 无头像显示俩个字(大于两个字显示后两个)
            userInfo = '<span>'+data.manageUserName+'</span>';
        }
        // 附件显示处理
        var attachmentStr = '';
        if (data.attachmentId) {
            attachmentStr = '<span class="glyphicon glyphicon-paperclip" title="附件" style="margin-right: 10px;">';
        }

        // 显示已关注处理
        var followStr = ''
        if (data.follow == 1) {
            followStr = '</span><span class="glyphicon glyphicon-star-empty" title="已关注"></span>';
        }
        var completedCount = data.completedCount;
        if (typeof completedCount == 'undefined') {
            completedCount = info.taskInfoModal.complateObj.completedCount
        }
        var taskCount = data.taskCount;
        if (typeof taskCount == 'undefined') {
            taskCount = info.taskInfoModal.complateObj.taskCount
        }

        var $taskItem = $('<li class="task_list_item">' +
            '\t\t\t\t\t\t\t\t\t\t<h3 class="task_name" title="'+data.taskName+'">' + checkBoxStr +
            '\t\t\t\t\t\t\t\t\t\t\t'+data.taskName+'' +
            '\t\t\t\t\t\t\t\t\t\t</h3>' +
            '\t\t\t\t\t\t\t\t\t\t<div class="task_info">' +
            '\t\t\t\t\t\t\t\t\t\t\t<p>' +
            '\t\t\t\t\t\t\t\t\t\t\t\t<span class="end_date">'+endDate+'截止</span>' +
            '\t\t\t\t\t\t\t\t\t\t\t\t<span class="task_num" title="子任务完成数'+completedCount+'/'+taskCount+'"><span class="glyphicon glyphicon-align-left"></span>'+completedCount+'/'+taskCount+'</span>' +
            attachmentStr + followStr +
            '\t\t\t\t\t\t\t\t\t\t\t</p>' +
            '\t\t\t\t\t\t\t\t\t\t\t<div class="progress">' +
            '\t\t\t\t\t\t\t\t\t\t\t\t<div class="progress-bar" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"' +
            '\t\t\t\t\t\t\t\t\t\t\t\t\t style="width: '+data.progress+'%;">' +
            '\t\t\t\t\t\t\t\t\t\t\t\t\t<span class="sr-only">'+data.progress+'% Complete</span>' +
            '\t\t\t\t\t\t\t\t\t\t\t\t</div>' +
            '\t\t\t\t\t\t\t\t\t\t\t</div>' +
            '\t\t\t\t\t\t\t\t\t\t</div>' +
            '\t\t\t\t\t\t\t\t\t\t<div class="task_item_right">' +
            '\t\t\t\t\t\t\t\t\t\t\t<div class="avatar">' + userInfo +
            '\t\t\t\t\t\t\t\t\t\t\t</div>' +
            '\t\t\t\t\t\t\t\t\t\t\t<p class="task_progress">'+data.progress+'%</p>' +
            '\t\t\t\t\t\t\t\t\t\t</div>' +
            '\t\t\t\t\t\t\t\t\t\t<span class="glyphicon glyphicon-remove-circle remove_task_icon"></span>' +
            '\t\t\t\t\t\t\t\t\t</li>');

        $taskItem.addClass(importantClass);
        $taskItem.data('taskInfo', data);
        $taskItem.attr('id', 'task'+data.taskId);
        $taskItem.attr('sequence', data.sequence);
        $taskItem.attr('taskId', data.taskId);
        return $taskItem;
    }
    // 获取任务列表数据
    function initTaskList() {
        $.get(basePath+"taskClass/queryTaskClass", function(res){
            if (res.flag) {
                // 移除之前的列表
                $('.add_form').siblings().remove()
                // 生成列表节点
                res.obj.forEach(function(item) {
                    var $taskListItem = newTaskList(item);
                    initTaskItemList(item.typeId, {}, $taskListItem);
                    $('.content_list').append($taskListItem);
                });
                // 重新计算容器宽度
                initContentWidth();
                resetSize();
            }
        });
    }

    // 获取列表下的任务
    function initTaskItemList(typeId, queryObj, $ele){
        queryObj = info.queryObj;
        // 查询列表接口
        $.get("queryTask", {typeId: typeId, myTask: queryObj.myTask, implementation: queryObj.implementation, taskStatus: queryObj.taskStatus, importantLevel: queryObj.importantLevel},function(res){
            var arrS = []
            if (res.flag) {
                $ele.find('.task_list').empty();
                if (res.obj.length > 0) {
                    res.obj.forEach(function(item){
                        arrS.push(item)
                        var $taskItem = newTaskItem(item);
                        $ele.find('.task_list').append($taskItem);
                    });
                    if(res.obj != ''){
                        $('.task_list>li').arrangeable({
                            dragSelector: '.task_name'
                        });
                        $('.content_list>li.content_list_item').arrangeable1({
                            dragSelector: '.panel-title'
                        });
                    }
                }
            }
        }, 'json');
    }

    // 生成评论节点
    function newTaskFeedback (feedback) {
        var reStr = '';
        var cStr = '';
        var liStyle = '';
        var pClass = '';
        var editor = '';
        if (feedback.parentId == 0) {
            reStr = '<a href="javascript:;" class="btn_recall" style="float: right; margin-right: 50px;">回复</a>';
            cStr = '<ul class="child_feedback_ul" style="margin-top: 20px;margin-left: 40px;"></ul>';
            liStyle = 'style="margin-top: 20px;padding-bottom: 20px;border-bottom: 1px solid #999;"';
            pClass = 'feedback_p';
            editor = '<div class="re_eidter" style="display: none;"><button type="button" style="float: right;margin-top: 8px;margin-right: 20px;" class="btn btn-primary btn-xs btn_feed">发布</button>';
        } else {
            liStyle = 'style="padding: 10px 0 10px 10px;border-left: 3px solid #999;"';
        }
        var $feedback = $('<li class="feedback_li '+pClass+'" '+liStyle+' id="feedback'+feedback.feedbackId+'" data-feedbackid="'+feedback.feedbackId+'">' +
            '<img src="/img/boyMax.png" alt="用户头像" style="float: left;width: 40px;height: 40px;">' +
            '<div style=" margin-left: 40px;padding: 0 10px;position: relative;">' +
            '<p><span>'+(feedback.userName || feedback.userId)+'</span><span style="float: right;margin-right: 50px;">'+feedback.createTime.split('.')[0]+'</span>'+reStr +'</p>' +
            '<p style="overflow: hidden;word-break: break-all;font-size: 12px;" class="feedback_content">'+feedback.feedbackContent+'</p>' + editor +
            '</div>' +
            '</div>' + cStr +
            '</li>');

        return $feedback;
    }

    $('#taskInfoModal').on('click', function(){
        $('.re_eidter', $(this)).hide(0, function(){
            $(this).find('#re_container'+info.editorIndex).remove();
        });
    });

});

// 获取时间方法
function getTime () {
    var date = new Date();
    var year = date.getFullYear();
    var month = date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1;
    var day = date.getDate() < 10 ? '0' + date.getDate() : date.getDate();
    var hour = date.getHours();
    var minute = date.getMinutes();
    var second = date.getSeconds();
    var dateStr =  year+'-'+month+'-'+day+'-'+' '+hour+':'+minute+':'+second;

    return dateStr;
}

function formatTime(timeStr) {
    var time = ''
    if (timeStr) {
        timeStr.split('-').forEach(function(item){
            time+=item;
        })
    }
    return parseInt(time || 0)
}

//监听键盘事件，number输入框只能输入数字
$(document).on('keypress', 'input[type=number]', function(e){

    var key = window.event ? e.keyCode : e.which

    if (!((key > 95 && key < 106) || (key > 47 && key < 58) || key == 8 || key == 9 || key == 13 || key == 37 || key == 39)) {
        return false
    }
});
// 监听number输入框值不能小于0
$(document).on('input propertychange', 'input[type=number]', function(){
    var val = parseInt($(this).val())
    if (val <= 0) {
        $(this).val(0);
    } else if (val > 100) {
        $(this).val(100);
    }
});
