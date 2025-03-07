$.extend({
    message: function (options) {
        var defaults = {
            message: '操作成功',
            time: '1500',
            type: 'success',
            showClose: false,
            autoClose: true,
            onClose: function () {}
        }

        if (typeof options === 'string') {
            defaults.message = options;
        }

        if (typeof options === 'object') {
            defaults = $.extend({}, defaults, options);
        }

        var templateClose = defaults.showClose ? '<a href="#" class="close" data-dismiss="alert">&times;</a>' : '';
        var template = '<div id="myAlert" style="position: fixed;top: 20px;left: 50%;z-index: 999999;margin: 0;padding: 5px 10px;" class="alert fade in alert-' + defaults.type + '">' +
            templateClose +
            '<span>' + defaults.message + '</span>' +
            '</div>';

        var $body = $('body');
        var $message = $(template);

        $message.find('.alert').css('margin', '0')
        var timer = null;

        $body.append($message);

        $message.css({'margin-left': function(){
                var width = $(this).outerWidth();
                return -(width/2) + 'px';
            }});

        var closeFn = function () {
            $("#myAlert").alert('close');
            clearTimeout(timer);
            defaults.onClose();
        }

        //自动关闭
        if (defaults.autoClose) {
            timer = setTimeout(function () {
                closeFn();
            }, defaults.time);
        }
    },
    confirm: function (options) {
        var defaults = {
            title: '信息提示',
            content: '确认点击？',
            confirmBtn: '确定',
            cancelBtn: '取消',
            confirm: function () {

            },
            cancel: function () {

            },
            onOpen: function () {

            },
            onClose: function () {

            }
        }

        if (typeof options === 'string') {
            defaults.content = options;
        } else if (typeof options === 'object') {
            defaults = $.extend({}, defaults, options);
        } else {
            var err = new Error('confirm options error');
            throw err;
        }

        var template = '<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">'+
            '<div class="modal-dialog row" role="document">'+
            '<div class="modal-content col-sm-8 col-sm-offset-2">'+
            '<div class="modal-header">'+
            '<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>'+
            '<h4 class="modal-title" id="myModalLabel">'+defaults.title+'</h4>'+
            '</div>'+
            '<div class="modal-body" style="line-height: 30px;font-size: 16px;overflow: hidden">'+
            '<span class="glyphicon glyphicon-exclamation-sign" style="float:left;font-size:30px;color:orange;margin-right: 10px"></span>'+
            '<p style="padding-top: 2px;margin: 0">'+defaults.content+'</p>'+
            '</div>'+
            '<div class="modal-footer">'+
            '<button type="button" class="btn btn-default" data-dismiss="modal" id="cancelBtn">'+defaults.cancelBtn+'</button>'+
            '<button type="button" class="btn btn-primary" id="confirmBtn">'+defaults.confirmBtn+'</button>'+
            '</div>'+
            '</div>'+
            '</div>'+
            '</div>';

        var $body = $('body');
        var $confirm = $(template);

        $body.append($confirm);

        $confirm.modal('show');

        $confirm.on('hidden.bs.modal', function(){
            defaults.onClose();
            $confirm.remove();
        });

        $confirm.on('shown.bs.modal', function(){
            defaults.onOpen();
        });

        $('#cancelBtn').on('click', function(){
            defaults.cancel();
            $confirm.modal('hide');
        });

        $('#confirmBtn').on('click', function(){
            defaults.confirm();
            $confirm.modal('hide');
        });

    },
    userModal: function (options) {
        var defaults = {
            allUsers: [],
            singleSelect: false, // 是否单选 默认否
            deptTreeData: [],       // 部门树
            checkedUsers: {}, // 传入已选择的用户
            isdeptAllUser: false,
            deptId: 0,
            makeSure: function () {

            }, // 确定按钮回调
            cancel: function () {

            },  // 取消回调
            onOpen: function () {

            }, // 打开时调用
            onClose: function () {

            }, // 关闭时调用
            // 初始化部门树
            initDepartmentTree: function () {
                var h = this;
                // 获取当前用户的所属部门及所有子部门
                $.get("queryUser", function(res){
                    if (res.flag) {
                        h.deptId = res.data.deptId;
                        $.get('/department/getNewChAllDept', {deptId: res.data.deptId}, function(res) {

                            var arr = defaults.getTreeList([res.object], []);

                            defaults.deptTreeData[0].nodes = defaults.buildTree(arr);

                            $('#dept_tree', $userModal).treeview({
                                data: defaults.deptTreeData,
                                highlightSelected: true,
                                showBorder: false,
                                levels: 2
                            });

                            $('#dept_tree', $userModal).on('nodeSelected', function(event, data) {
                                // 点击根节点更新部门树
                                if (data.level === 0) {
                                    defaults.getDepartmentAllUsers(0);
                                    return false;
                                } else {
                                    defaults.deptId = data.id;
                                    if (defaults.isdeptAllUser) {
                                        // 点击子节点获取部门下用户(包含子部门)
                                        defaults.getDepartmentAllUsers(data.id);
                                    } else {
                                        // 点击子节点获取部门下用户(不含子部门)
                                        defaults.getDepartmentUsers(data.id);
                                    }

                                    return false;
                                }
                            });

                            defaults.allUsers = defaults.getUserList([res.object], []);

                            // 获取默认的用户列表
                            $.get('/user/selNewNowUsersBai', function(res){
                                if (res.flag) {
                                    var $rList = $('.r_list');
                                    $('.empty_data', $rList).hide();
                                    res.obj.forEach(function(item){
                                        $('.r_data_list', $rList).append(defaults.newUserItem(item));
                                    });
                                }
                            });

                            // 显示已选择用户
                            if (defaults.allUsers && defaults.allUsers.length > 0) {
                                var index = 0;
                                defaults.allUsers.forEach(function(user){
                                    if (h.checkedUsers[user.userId]) {
                                        defaults.checkedUsers[user.userId] = { userId: user.userId, userName: user.userName};
                                        var $userItem = defaults.newCheckedUser(user);
                                        $('.users_box', $userModal).append($userItem);
                                        index++;
                                    }
                                });
                                $('.check_num', $userModal).text(index);
                            }

                        });
                    }
                }, 'json');

            },
            // 根据部门获取用户列表(不含子部门)
            getDepartmentUsers: function (deptId) {
                $.get('/department/getNewChDeptBai', {deptId: deptId}, function(res){
                    if (res.flag) {
                        var $rList = $('.r_list', $userModal);
                        $('.r_data_list', $rList).empty();
                        if (res.obj.length > 0) {
                            $('.empty_data', $rList).hide();
                            res.obj.forEach(function(item){
                                $('.r_data_list', $rList).append(defaults.newUserItem(item));
                            });
                        } else {
                            $('.empty_data', $rList).show();
                        }
                    }
                });
            },
            // 根据部门获取用户列表(包含子部门)
            getDepartmentAllUsers: function (deptId) {
                $.get('/department/getNewChAllDept', {deptId: deptId}, function(res){
                    if (res.flag) {
                        var userList = defaults.getUserList([res.object], []);
                        var $rList = $('.r_list', $userModal);
                        $('.r_data_list', $rList).empty();
                        if (userList.length > 0) {
                            $('.empty_data', $rList).hide();
                            userList.forEach(function(item){
                                $('.r_data_list', $rList).append(defaults.newUserItem(item));
                            });
                        } else {
                            $('.empty_data', $rList).show();
                        }
                    }
                })
            },
            // 根据分组获取用户列表
            getUsersByGroupId: function (groupId){
                $.get('/getUsersByGroupIdBai', {groupId: groupId}, function(res){
                    if (res.flag) {
                        var $rList = $('.r_list', $userModal);
                        $('.r_data_list', $rList).empty();
                        if (res.object.length > 0) {
                            $('.empty_data', $rList).hide();
                            res.object.forEach(function(item){
                                $('.r_data_list', $rList).append(defaults.newUserItem(item));
                            });
                        } else {
                            $('.empty_data', $rList).show();
                        }
                    }
                });
            },
            // 根据角色获取用户列表
            getUserByUserPriv: function (userPriv) {
                $.get('/user/getUserByUserPrivBai', {userPriv: userPriv}, function(res){
                    if (res.flag) {
                        var $rList = $('.r_list', $userModal);
                        $('.r_data_list', $rList).empty();
                        if (res.object.users.length > 0) {
                            $('.empty_data', $rList).hide();
                            res.object.users.forEach(function(item){
                                $('.r_data_list', $rList).append(defaults.newUserItem(item));
                            });
                        } else {
                            $('.empty_data', $rList).show();
                        }
                    }
                })
            },
            // 获取所有用户
            getUserList: function (arr, result) {
                arr.forEach(function(dept) {
                    if (dept.users && dept.users.length > 0) {
                        result = result.concat(dept.users)
                    }
                    if (dept.child) {
                        result = defaults.getUserList(dept.child, result);
                    }
                });
                return result;
            },
            //获取树结构扁平
            getTreeList: function (arr, result) {
                var self = this;
                arr.forEach(function(item) {
                    if (item.child) {
                        result.push({ id: item.deptId, text: item.deptName, deptNo: item.deptNo, pid: item.deptParent });
                        self.getTreeList(item.child, result);
                    } else {
                        result.push({ id: item.deptId, text: item.deptName, deptNo: item.deptNo, pid: item.deptParent });
                    }
                });
                return result;
            },
            // 获取树结构
            buildTree: function(list) {
                var temp = {};
                var tree = [];
                for (var i in list) {
                    temp[list[i].id] = list[i];
                }

                for (var i in temp) {
                    if (temp[i].pid) {
                        if (!temp[temp[i].pid].nodes) {
                            temp[temp[i].pid].nodes = [];
                        }
                        temp[temp[i].pid].nodes.push(temp[i]);
                    } else {
                        tree.push(temp[i]);
                    }
                }

                return tree;
            },
            // 初始化用户项
            newUserItem: function (data) {
                var h = this;
                var avatar = data.avatar;
                if (avatar == undefined || avatar == "") {
                    avatar = data.sex;
                }
                if (avatar == 0) {
                    avatar = '/img/email/icon_head_man_06.png'
                } else if (avatar == 1) {
                    avatar = '/img/email/icon_head_woman_06.png'
                } else {
                    avatar = '/img/user/' + data.avatar
                }

                var isChecked = '';
                if (h.checkedUsers[data.userId]) {
                    isChecked = 'active';
                }
                var $listItem = $('<div class="r_item col-xs-6 '+isChecked+'">\n' +
                    '<span class="glyphicon glyphicon-ok"></span>' +
                    '\t\t\t\t\t\t\t\t\t\t<img src="'+avatar+'" class="u_avatar">\n' +
                    '\t\t\t\t\t\t\t\t\t\t<div class="u_info">\n' +
                    '\t\t\t\t\t\t\t\t\t\t\t<p class="u_name">'+data.userName+'</p>\n' +
                    '\t\t\t\t\t\t\t\t\t\t\t<p class="u_priv_name">'+data.userPrivName+'</p>\n' +
                    '\t\t\t\t\t\t\t\t\t\t\t<p class="u_office">'+data.deptName+'</p>\n' +
                    '\t\t\t\t\t\t\t\t\t\t</div>\n' +
                    '\t\t\t\t\t\t\t\t\t</div>');

                $listItem.data('userInfo', data);

                return $listItem;
            },
            // 初始化已选择的用户项
            newCheckedUser: function(data) {
                var avatar = data.avatar;
                if (avatar == undefined || avatar == "") {
                    avatar = data.sex;
                }
                if (avatar == 0) {
                    avatar = '/img/email/icon_head_man_06.png'
                } else if (avatar == 1) {
                    avatar = '/img/email/icon_head_woman_06.png'
                } else {
                    avatar = '/img/user/' + data.avatar
                }
                var $userItem = $('<div class="u_item col-xs-3">\n' +
                    '\t\t\t\t\t\t\t\t\t\t<img src="'+avatar+'" class="u_avatar">\n' +
                    '\t\t\t\t\t\t\t\t\t\t<div class="u_info">\n' +
                    '\t\t\t\t\t\t\t\t\t\t\t<p class="u_name">'+data.userName+'</p>\n' +
                    '\t\t\t\t\t\t\t\t\t\t\t<p class="u_priv_name">'+data.userPrivName+'</p>\n' +
                    '\t\t\t\t\t\t\t\t\t\t\t<p class="u_office">'+data.deptName+'</p>\n' +
                    '\t\t\t\t\t\t\t\t\t\t</div>\n' +
                    '\t\t\t\t\t\t\t\t\t</div>');
                $userItem.attr('id', data.userId);
                $userItem.data('userInfo', data);

                return $userItem;
            },
            throttle: function (method,text) {
                clearTimeout(method.tId);
                method.tId=setTimeout(function(){
                    method.call(method,text);
                },500);
            },
            // 获取输入框搜索用户
            getSearchUsers: function(text){
                $.get("/user/getBySearchBai?search=" + text, function(res){
                    if (res.flag) {
                        var $rList = $('.r_list', $userModal);
                        $('.r_data_list', $rList).empty();
                        if (res.obj.length > 0) {
                            $('.empty_data', $rList).hide();
                            res.obj.forEach(function(item){
                                $('.r_data_list', $rList).append(defaults.newUserItem(item));
                            });
                        } else {
                            $('.empty_data', $rList).show();
                        }
                    }
                });
            }
        }

        if (typeof options === 'object') {
            defaults = $.extend({}, defaults, options);
        } else {
            var err = new Error('userModal options error');
            throw err;
        }

        {
            var template = '<div class="modal fade user_list_modal" style="z-index: 99999999" id="userModal" tabindex="-1" role="dialog"\n' +
                '\t aria-labelledby="userModalLabel">\n' +
                '\t<div class="modal-dialog" role="document">\n' +
                '\t\t<div class="modal-content">\n' +
                '\t\t\t<div class="modal-header">\n' +
                '\t\t\t\t<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>\n' +
                '\t\t\t\t<h4 class="modal-title" id="userModalLabel">用户选择</h4>\n' +
                '\t\t\t</div>\n' +
                '\t\t\t<div class="modal-body">\n' +
                '\t\t\t\t<div class="m_body_content">\n' +
                '\t\t\t\t\t<div class="c_top">\n' +
                '\t\t\t\t\t\t<div class="row">\n' +
                '\t\t\t\t\t\t\t<div class="c_top_l col-xs-5" style="border-right: 1px solid #dcdcdc;">\n' +
                '\t\t\t\t\t\t\t\t<div class="u_m_serch">\n' +
                '\t\t\t\t\t\t\t\t\t<input id="searchinput" type="text" placeholder="搜索用户" style="width: 100%;"/>\n' +
                '\t\t\t\t\t\t\t\t\t<span class="glyphicon glyphicon-search m_icon_search"></span>\n' +
                '\t\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\t\t\t<div>\n' +
                '\t\t\t\t\t\t\t\t\t<ul id="usertab" class="nav nav-tabs row">\n' +
                '\t\t\t\t\t\t\t\t\t\t<li class="col-xs-3 active"><a class="user_tab_a" data-type="1" href="#department" style="font-size: 12px;padding: 5px;" data-toggle="tab">部门</a></li>\n' +
                '\t\t\t\t\t\t\t\t\t\t<li class="col-xs-3"><a class="user_tab_a" href="#role" style="font-size: 12px;padding: 5px;" data-toggle="tab">角色</a></li>\n' +
                '\t\t\t\t\t\t\t\t\t\t<li class="col-xs-3"><a class="user_tab_a" href="#commongroup" style="font-size: 12px;padding: 5px;" data-toggle="tab">公共分组</a></li>\n' +
                '\t\t\t\t\t\t\t\t\t\t<li class="col-xs-3"><a class="user_tab_a" href="#personalgroup" style="font-size: 12px;padding: 5px;" data-toggle="tab">个人分组</a></li>\n' +
                '\t\t\t\t\t\t\t\t\t</ul>\n' +
                '\t\t\t\t\t\t\t\t\t<div id="usertabcontent" class="tab-content">\n' +
                '\t\t\t\t\t\t\t\t\t\t<div class="tab-pane fade in active" id="department">\n' +
                '\t\t\t\t\t\t\t\t\t\t\t<div id="dept_tree"></div>\n' +
                '\t\t\t\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\t\t\t\t\t<div class="tab-pane fade" id="role">\n' +
                '\t\t\t\t\t\t\t\t\t\t\t<ul class="priv_list"></ul>\n' +
                '\t\t\t\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\t\t\t\t\t<div class="tab-pane fade" id="commongroup">\n' +
                '\t\t\t\t\t\t\t\t\t\t\t<ul class="group_list common_group_list"></ul>\n' +
                '\t\t\t\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\t\t\t\t\t<div class="tab-pane fade" id="personalgroup">\n' +
                '\t\t\t\t\t\t\t\t\t\t\t<ul class="group_list personal_group_list"></ul>\n' +
                '\t\t\t\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\t\t<div class="c_top_r col-xs-7">\n' +
                '\t\t\t\t\t\t\t\t<div class="r_title">\n' +
                '\t\t\t\t\t\t\t\t\t<a href="javascript:;" class="check_all_user"><span class="check_box glyphicon glyphicon-ok"></span>选择全部</a>\n' +
                '\t\t\t\t\t\t\t\t\t<a href="javascript:;" class="check_other_user"><span class="check_box glyphicon glyphicon-ok"></span>包含子部门人员</a>\n' +
                '\t\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\t\t\t<div class="row r_list">' +
                '<div class="r_data_list"></div>'+
                '<div class="empty_data" style="display: none;font-size: 16px;margin-top: 20px;text-align: center;font-weight: 600;">\n' +
                '\t\t\t\t\t\t\t\t\t\t<img src="/img/common/dianjikong.png" alt="">\n' +
                '\t\t\t\t\t\t\t\t\t\t<p style="margin-top: 10px;">暂无人员</p>\n' +
                '\t\t\t\t\t\t\t\t\t</div>'+
                '\t\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t<div class="c_bottom">\n' +
                '\t\t\t\t\t\t<div class="check_title clearf">\n' +
                '\t\t\t\t\t\t\t<p>已选择<span class="check_num">0</span>项</p>\n' +
                '\t\t\t\t\t\t\t<a href="javascript:void(0);" id="cancel_all"><span class="glyphicon glyphicon-trash"></span>取消全部</a>\n' +
                '\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\t<div class="users_box clearf">\n' +
                '\n' +
                '\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t</div>\n' +
                '\t\t\t\t</div>\n' +
                '\t\t\t</div>\n' +
                '\t\t\t<div class="modal-footer">\n' +
                '\t\t\t\t<button type="button" class="btn btn-primary" id="btn_ok">确定</button>\n' +
                '\t\t\t</div>\n' +
                '\t\t</div>\n' +
                '\t</div>\n' +
                '</div>';
        }

        var $body = $('body');
        var $userModal = $(template);

        if (defaults.singleSelect) {
            $('.check_all_user', $userModal).css({'display':'none'});
        }

        // 打开弹窗是调用
        $userModal.on('show.bs.modal', function(){

            // 获取根部门
            $.get('/sys/showUnitManage', function(res) {
                if (res.flag) {
                    defaults.deptTreeData.push({text: res.object.unitName, nodes: [], unitId: res.object.unitId});
                    defaults.initDepartmentTree();
                }
            });

            // 获取角色列表
            $.get('/userPriv/getAllPriv', function (res) {
                if (res.flag) {
                    var $privList = $('#usertabcontent').find('.priv_list')

                    res.obj.forEach(function(item){
                        var $temp = $('<li><a data-userpriv="'+item.userPriv+'">'+item.privName+'<span class="glyphicon glyphicon-education"></span></a></li>');
                        $privList.append($temp);
                    });
                }
            });

            // 获取公共分组列表
            $.get('/usergroup/getAllUserGroup', function(res) {
                if (res.flag) {
                    var $commonGroup = $('#usertabcontent').find('.common_group_list')

                    res.obj.forEach(function(item){
                        var $temp = $('<li><a class="group_item" data-group="'+item.groupId+'">'+item.groupName+'</a></li>');
                        $commonGroup.append($temp);
                    });
                }
            });

            // 获取个人分组列表
            $.get('/usergroup/getAllUserGroup1', function(res){
                if (res.flag) {
                    var $personalGroup = $('#usertabcontent').find('.personal_group_list')

                    res.obj.forEach(function(item){
                        var $temp = $('<li><a class="group_item" data-group="'+item.groupId+'">'+item.groupName+'</a></li>');
                        $personalGroup.append($temp);
                    });
                }
            });

        });

        // 弹窗关闭时调用
        $userModal.on('hidden.bs.modal', function(){
            defaults.onClose();
            $userModal.remove();
        });

        // 切换tab选项
        $('.user_tab_a', $userModal).on('click', function (e) {
            e.preventDefault();
            var tabType = $(this).data('type');

            if (tabType && tabType == '1') {
                $('.check_other_user').show();
            } else {
                $('.check_other_user').hide();
            }
        });

        // 选择全部用户
        $('.check_all_user', $userModal).on('click', function(){
            var $checkBox = $(this).find('.check_box');

            $checkBox.toggleClass('on');

            if ($checkBox.hasClass('on')) {
                $('.r_list', $userModal).find('.r_item').each(function(index, ele) {
                    var userInfo = $(ele).data('userInfo');
                    $(this).addClass('active');
                    if ($('#'+userInfo.userId, $userModal).length === 0) {
                        defaults.checkedUsers[userInfo.userId] = { userId: userInfo.userId, userName: userInfo.userName};
                        var $userItem = defaults.newCheckedUser(userInfo);
                        $('.users_box', $userModal).append($userItem);
                    }
                });
            } else {
                $('.r_list', $userModal).find('.r_item').each(function(index, ele) {
                    var userInfo = $(ele).data('userInfo');
                    $(this).removeClass('active');
                    $('#'+userInfo.userId, $userModal).remove();
                    delete defaults.checkedUsers[userInfo.userId];
                });
            }
            var checkNum = $('.users_box', $userModal).children('.u_item').length;
            $('.check_num').text(checkNum);
        });

        // 包含子部门选择
        $('.check_other_user', $userModal).on('click', function(){
            $(this).find('.check_box').toggleClass('on');
            defaults.isdeptAllUser = !defaults.isdeptAllUser
            if (defaults.isdeptAllUser) {
                // 点击子节点获取部门下用户(包含子部门)
                defaults.getDepartmentAllUsers(defaults.deptId);
            } else {
                // 点击子节点获取部门下用户(不含子部门)
                defaults.getDepartmentUsers(defaults.deptId);
            }
        });

        // 选择用户弹窗点击选择用户
        $('.r_list', $userModal).on('click', '.r_item', function(){
            var userInfo = $(this).data('userInfo');
            if (defaults.singleSelect) {
                $(this).siblings().removeClass('active');
            }
            $(this).toggleClass('active');
            var isActive = $(this).hasClass('active');
            if (isActive) {
                if (defaults.singleSelect) {
                    $('.users_box', $userModal).empty();
                    defaults.checkedUsers = {}
                }
                if ($('#'+userInfo.userId, $userModal).length > 0) {
                    return false;
                }
                defaults.checkedUsers[userInfo.userId] = { userId: userInfo.userId, userName: userInfo.userName};
                var $userItem = defaults.newCheckedUser(userInfo);
                $('.users_box', $userModal).append($userItem);
                var checkNum = $('.users_box', $userModal).children('.u_item').length;
                $('.check_num', $userModal).text(checkNum);
            } else {
                $('#'+userInfo.userId, $userModal).remove();
                var checkNum = $('.users_box', $userModal).children('.u_item').length;
                $('.check_num', $userModal).text(checkNum);
                delete defaults.checkedUsers[userInfo.userId];
            }
        });

        // 角色点击
        $userModal.on('click', '.priv_list a', function () {
           var userPriv = $(this).data('userpriv')
           defaults.getUserByUserPriv(userPriv);
        });

        // 分组点击
        $userModal.on('click', '.group_item', function(){
            var groupId = $(this).data('group')
            defaults.getUsersByGroupId(groupId);
        });

        // 点击确定
        $('#btn_ok', $userModal).on('click', function(){
            var selectUsers = [];
            for (var user in defaults.checkedUsers) {
                selectUsers.push(defaults.checkedUsers[user])
            }
            defaults.makeSure(selectUsers);
            $userModal.modal('hide');
        });

        // 取消全部
        $('#cancel_all', $userModal).on('click',function(){
            $('.check_all_user', $userModal).remove('active');
            $('.users_box', $userModal).empty();
            $('.check_num').text(0);
            $('.r_list', $userModal).find('.r_item').each(function(index, ele) {
                var userInfo = $(ele).data('userInfo');
                $(this).removeClass('active');
                $('#'+userInfo.userId, $userModal).remove();
                delete defaults.checkedUsers[userInfo.userId];
            });
        });

        // 输入框搜索
        $('#searchinput', $userModal).on('input propertychange', function(){
            var text = encodeURI($(this).val());
            var $rList = $('.r_list', $userModal);
            $('.r_data_list', $rList).empty();
            if(text!= ''){
                defaults.throttle(defaults.getSearchUsers, text);
            }else{
                $('.empty_data', $rList).show();
            }
        });

        $body.append($userModal);

        $userModal.modal('show');
    }
});