<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<head>
    <head>
        <title>OA用户导入钉钉</title>
        <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    </head>
    <link rel="stylesheet" type="text/css" href="../../css/common/style.css" />
    <link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../css/enterpriseManage/weixinqy.css">
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script src="../../js/base/base.js"></script>
    <link rel="stylesheet" type="text/css" href="../../css/common/ui.dynatree.css">
    <script type="text/javascript" src="../../js/js_lang.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
<body>
<style>
    body{
        background-color: #f5f5f5;
    }
</style>
<script type="text/javascript">
//    var S = {
//        'import' : 0
//    };
//    $(document).ready(function(){
//        $("#btn-oa-user-sync").click(function(){
//            var self = $(this);
//            if(S.import == 1)
//            {
//                alert("正在导入，请等待");
//                return;
//            }
//
//            var items = $("#userTree").dynatree("getSelectedNodes");
//            if(items.length == 0)
//            {
//                alert("请选择要导入的人员");
//            }
//            else
//            {
//                var user_id = [];
//                for(var i in items)
//                {
//                    if(items[i].data.user_id)
//                        user_id.push(items[i].data.user_id);
//                }
//
//                if(user_id.length == 0)
//                {
//                    alert("选择部门无效果，请选择具体人员");
//                    return;
//                }
//
//
//                $(this).addClass("disabled");
//                S.import = 1;
//
//                $.ajax({
//                    type: "GET",
//                    url: "oa_user.php",
//                    dataType: 'json',
//                    data: {'action': 'importUser', 'user_id': user_id.join(",")},
//                    success: function(msg){
//                        if(msg.success || msg.failed || msg.exists)
//                        {
//                            $("#sync-modal .modal-body p").html('导入成功：' + msg.success + ' 导入失败：' + msg.failed + ' 重复忽略：' + msg.exists);
//                            $("#sync-modal").modal('show');
//                            S.import = 0;
//                            self.removeClass("disabled");
//                        }
//                    }
//                });
//            }
//        });
//    });
</script>
<div>
    <%--<div class="sync-item">--%>
        <%--<button id="btn-oa-user-sync" class="btn btn-small btn-primary" type="button">导入选择的人员</button>--%>
    <%--</div>--%>
    <div class="sync-tree sync-user-tree">
        <div id="userTree">
            <div class="cont_left" id="cont_left">
                <ul>
                    <li class="liDown dept_li" id="dept_lis"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_sectorList.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="部门列表"><fmt:message code="depatement.th.depa" /></li>
                    <li class="pick" style="display: block;">
                        <div class="pickCompany"><span style="height:35px;line-height:35px;" class="childdept"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 10px;margin-left: 13px;margin-bottom: 4px;"><a href="javascript:void(0)" class="dynatree-title" title=""></a></span></div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div id="sync-modal" class="modal hide fade">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h3>同步结果</h3>
    </div>
    <div class="modal-body">
        <p></p>
    </div>
    <div class="modal-footer">
        <button type="botton" class="btn" data-dismiss="modal">关闭</button>
    </div>
</div>


<script type="text/javascript">
    var uid1=[]
    $('#userTree').on('click', 'input[type=checkbox]', function () {
         var uid = new Array();
            $("input[type=checkbox]:checked").each(function (index) {
                uid.push($(this).parent().attr('data-uid'));
            })
        uid1=uid.join(';');
        return uid1;
    })

    function loadrole1(target, teptId, num, fn) {
        $.ajax({
            url:' /dingdingManage/dingdingGetUserList',
            type: 'get',
            data: {
                deptId: teptId
            },
            dataType: 'json',
            success: function (data) {
                if (!data.flag) {
                    return
                }
                var str = '';
                var arr = [];
                if ($(target).children('li').length == 0) {
                    for (var i = 0; i < data.object.length; i++) {
                        str += '<li><span data-uid="'+data.object[i].deptId+',' + data.object[i].uid + '" data-numString="1"  style="padding-left:' + (20 + 20 * parseInt(num)) + 'px;height:35px;line-height:35px;"  class="childdept role"><input type="checkbox" name="" value="" style="position: relative;bottom: 2px;right: 4px;"><span></span>' +
                            '<img  src="' + function () {
                                var avatar = data.object[i].avatar;
                                if (avatar == undefined || avatar == "") {
                                    avatar = data.object[i].sex;
                                }
                                if (avatar == 0) {
                                    return '/img/email/icon_head_man_06.png'
                                } else if (avatar == 1) {
                                    return '/img/email/icon_head_woman_06.png'
                                } else {
                                    return '/img/user/' + data.object[i].avatar
                                }
                            }() + '" style="width: 20px;height:20px;margin-top: -3px;margin-right:4px;" alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" title="' + data.object[i].userName + '">' + data.object[i].userName + '</a></span></li>';

                    }
                    $(target).html(str);
                } else {
                    $(target).children('li').each(function (m, b) {
                        for (var i = 0; i < data.object.length; i++) {
                            if ($($(target).children('li')[i]).children('span').attr('data-uid') != data.object[i].uid) {
                                str = '<li><span data-uid="'+data.object[i].deptId+',' + data.object[i].uid + '" data-numString="1"  style="padding-left:' + (20 + 20 * parseInt(num) ) + 'px;height:35px;line-height:35px;"  class="childdept role"><input type="checkbox" name="" value="" style="position: relative;bottom: 2px;right: 4px;"><span></span>' +
                                    '<img  src="' + function () {
                                        var avatar = data.object[i].avatar;
                                        if (avatar == undefined || avatar == "") {
                                            avatar = data.object[i].sex;
                                        }
                                        if (avatar == 0) {
                                            return '/img/email/icon_head_man_06.png'
                                        } else if (avatar == 1) {
                                            return '/img/email/icon_head_woman_06.png'
                                        } else {
                                            return '/img/user/' + data.object[i].avatar
                                        }
                                    }() + '" style="width: 20px;height:20px;margin-top: -3px;margin-right:4px;" alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" title="' + data.object[i].userName + '">' + data.object[i].userName + '</a></span></li>';
                                $(target).append(str)
                            }
                        }
                        return false
                    })
                }

                if (fn != undefined) {
                    fn();
                }

            }
        })
    }
    loadSidebar1($('.pick'),0)
    function loadSidebar1(target,deptId,fn) {

        $.ajax({
            url: '/dingdingManage/dingdingGetUserList',
            type: 'get',
            data: {
                deptId: deptId
            },
            dataType: 'json',
            success: function (data) {

                $(target).empty();
                var str = '';
                data.obj.forEach(function (v, i) {
                    if (v.deptName) {
                        str += '<li><span  data-numtrue="1" ' +
                            'onclick= "imgDown1(' +v.deptId + ',this)"   data-numString="1"  style="height:35px;line-height:35px;padding-left: 14px" deptid="' + v.deptId + '" class="childdept" clickType="0"><span class=""></span>' +
                            '<img src="/img/sys/dapt_right.png" alt="" class="imgleft" style="width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;"><a href="javascript:void(0)" class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a></span><ul style="display:none;" class="dpetWhole0"></ul></li>';
                    }
                })



                target.append(str);


            }
        })
    }

    function imgDown1(deptNum, me) {
        ajaxdata1(deptNum, me);
        if ($(me).attr('data-types') == undefined) {
            $(me).find('img').attr('src', $(me).find('img').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
            if ($(me).find('img').attr('src') == '/img/sys/dapt_right.png') {
                $(me).find('img').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": ""});
                $(me).find('img').width(8);
                $(me).find('img').height(14);
                $(me).next().hide();
                $(me).next().html('')
//                console.log('关闭')
            } else if ($(me).find('img').attr('src') == '/img/sys/dapt_down.png') {
                $(me).find('img').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": "-5px"});
                $(me).find('img').width(14);
                $(me).find('img').height(9);
                $(me).next().show();
                $(me).next().html('')
//                console.log('打开')

            }
        }
        else {
            $(me).find('img').attr('src', $(me).find('img').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
            if ($(me).find('img').attr('src') == '/img/sys/dapt_right.png') {
                $(me).find('img').width(8);
                $(me).find('img').height(14);
            } else if ($(me).find('img').attr('src') == '/img/sys/dapt_down.png') {
                $(me).find('img').width(14);
                $(me).find('img').height(9);
            }
            if ($(me).attr('data-types') == '1') {
                $(me).next().show();
                $(me).attr('data-types', '2')
            } else if ($(me).attr('data-types') == '2') {
                $(me).next().hide();
                $(me).attr('data-types', '1')
            }

        }


//
                loadrole1($(me).next(), deptNum, $(me).attr('data-numtrue'));
//

    }

    function ajaxdata1(id,me){

        $.ajax({
            url: '/dingdingManage/dingdingGetUserList',
            type: 'get',
            data: {
                deptId: id
            },
            dataType: 'json',
            success: function (data) {

                var str1 = '';
                var str2='';
                data.obj.forEach(function (v, i) {
                    if (v.deptName) {
                        str1 += '<li><span  data-numtrue="1" ' +
                            'onclick= "imgDown1(' +v.deptId + ',this)"   data-numString="1"  style="height:35px;line-height:35px;padding-left: 14px" deptid="' + v.deptId + '" class="childdept" ><span class=""></span>' +
                            '<img src="/img/sys/dapt_right.png" alt="" class="imgleft" style="width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;"><a href="javascript:void(0)" class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a></span><ul style="display:none;" class="dpetWhole"></ul></li>';
                    }
                })
                $(me).next().append(str1);

            }
        })

    }

    //限制排序号只能输入三位有效数字
//    var text = document.getElementById("deptNo_");
//    text.onkeyup = function(){
//        this.value=this.value.replace(/\D/g,'');
//        if(text.value.length>3){
//            text.value = deptNoShow;
//        }
//    }

//    var ac=$("input[type=checkbox][checked]").parent().attr('data-uid')
//    console.log(ac)



</script>
</body>
</html>