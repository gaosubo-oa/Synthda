<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-08-11
  Time: 11:56
  To change this template use File | Settings | File Templates.
--%>
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
    <title>关联关键任务</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css?2019101815.40">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/modules/layer/default/layer.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>

    <style>
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
        .con_left ,.con_leftZ{
            float: left;
            /*width: 230px;*/
            height: 100%;
        }
        .con_right ,.con_rightZ {
            float: left;
            /*width: calc(100% - 230px);*/
            height: 100%;
            padding-left: 10px;
            box-sizing: border-box;
        }
    </style>
</head>
<body>
<input type="hidden" id="leftId">
<input type="hidden" id="rightId">
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
    <ul class="layui-tab-title">
        <li class="layui-this">主项关键任务</li>
        <li>职能关键任务</li>
    </ul>
    <div class="layui-tab-content">
        <div class="layui-tab-item layui-show">
            <div class="clearfix">
                <%--查询--%>
                <div class="layui-row mainLeftQuery layui-form">
                    <%-- <div class="layui-col-xs3">
                         <div class="layui-form-item">
                             <label class="layui-form-label">年度:</label>
                             <div class="layui-input-block">
                                 <select name="year" lay-filter="year">
                                     <option value="">请选择</option>
                                 </select>
                             </div>
                         </div>
                     </div>
                     <div class="layui-col-xs3">
                         <div class="layui-form-item">
                             <label class="layui-form-label">月度:</label>
                             <div class="layui-input-block">
                                 <select name="month"></select>
                             </div>
                         </div>
                     </div>--%>
                    <div class="layui-col-xs4">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="padding: 9px 0px">责任部门:</label>
                            <div class="layui-input-block" style="margin-left: 85px;">
                                <textarea  type="text" title="责任部门" name="mainCenterDept" id="mainCenterDept" readonly  style="background:#e7e7e7;height: 45px;width: 63%;text-indent:1em;border-radius: 4px;"></textarea>
                                <a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="deptAdd">添加</a>
                                <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="deptDel">清空</a>
                            </div>
                        </div>
                    </div>
                    <button type="button" class="layui-btn layui-btn-sm queryTarget" style="margin-left: 5%;margin-top: 5px;">查询</button>
                </div>
                <div class="con_left" style="margin-top: -20px;">
                    <div class="eleTree ele1" style="overflow-x: auto;margin-top: 10px;" lay-filter="projectLeft"></div>
                </div>
                <div class="con_right layui-form"></div>
            </div>
        </div>
        <div class="layui-tab-item">
            <div class="clearfix">
                <%--查询--%>
                <div class="layui-row mainRightQuery layui-form">
                    <div class="layui-col-xs3">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="padding: 9px 0px;width: 50px">年度:</label>
                            <div class="layui-input-block" style="margin-left: 57px;">
                                <select name="year" lay-filter="yearRight">
                                    <option value="">请选择</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <%-- <div class="layui-col-xs3">
                         <div class="layui-form-item">
                             <label class="layui-form-label">月度:</label>
                             <div class="layui-input-block">
                                 <select name="month"></select>
                             </div>
                         </div>
                     </div>--%>
                    <%-- <div class="layui-col-xs4">
                         <div class="layui-form-item">
                             <label class="layui-form-label">所属部门:</label>
                             <div class="layui-input-block">
                                 <textarea  type="text" title="所属部门" name="mainCenterDept" id="mainCenterDeptRight" readonly  style="background:#e7e7e7;height: 45px;width: 67%;text-indent:1em;border-radius: 4px;"></textarea>
                                 <a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="deptAdd">添加</a>
                                 <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="deptDel">清空</a>
                             </div>
                         </div>
                     </div>--%>
                    <button type="button" class="layui-btn layui-btn-sm queryTarget" style="margin-left: 5%;margin-top: 5px;">查询</button>
                </div>
                <div class="con_leftZ" style="margin-top: -20px;">
                    <div class="eleTree ele1Z" style="overflow-x: auto;margin-top: 10px;" lay-filter="projectLeftZ"></div>
                </div>
                <div class="con_rightZ layui-form"></div>
            </div>
        </div>
    </div>
</div>
<script>
    //选部门控件添加
    $(document).on('click', '.deptAdd', function () {
        var chooseNum = $(this).attr('chooseNum') == 1 ? '?0' : '';
        dept_id = $(this).siblings('textarea').attr('id');
        $.popWindow("/common/selectDept" + chooseNum);
    });
    //选部门控件删除
    $(document).on('click', '.deptDel', function () {
        var deptId = $(this).siblings('textarea').attr('id');
        $('#' + deptId).val('');
        $('#' + deptId).attr('deptid', '');
    });
    $('.ele1').height($(window).height()-150)
    $('.ele1Z').height($(window).height()-150)
    var leftArr=[]
    //获取父页面的关联关键任务id
    if(parent.$('form input[name="tgId"]').attr('tgId')){
        var tgIds=parent.$('form input[name="tgId"]').attr('tgId').split(',')
        leftArr=leftArr.concat(tgIds)
    }
    //获取父页面的左侧所选部门
    if(parent.$('#leftId').attr('mainCenterDeptName') && parent.$('#leftId').attr('mainCenterDept')){
        $('#mainCenterDept').val(parent.$('#leftId').attr('mainCenterDeptName'))
        $('#mainCenterDept').attr('deptId',parent.$('#leftId').attr('mainCenterDept'))
    }
    // console.log(leftArr)
    layui.use(['eleTree','form','element'], function(){
        var eleTree = layui.eleTree;
        var form = layui.form;
        var element = layui.element;
        form.render()
        // 计划期间年度列表
        var allYear = '';
        // 获取计划期间年度列表
        $.get('/planPeroidSetting/selectAllYear', function(res) {
            if (res.object.length > 0) {
                res.object.forEach(function(item){
                    allYear += '<option value="'+item.periodYear+'">'+item.periodYear+'</option>'
                });
            }
            $('.mainLeftQuery [name="year"]').append(allYear);
            $('.mainRightQuery [name="year"]').append(allYear);
            form.render('select');
            //默认职能关键任务年度为当年
            $('.mainRightQuery select[name="year"] option').each(function () {
                var nowYear=new Date().getFullYear()
                if($(this).text()==nowYear){
                    $('.mainRightQuery select[name="year"]').val($(this).val())
                    form.render()
                }
            })
        });

        // 获取月度
        form.on('select(year)', function (data) {
            if (data.value) {
                getPlanMonth(data.value, function (monthStr) {
                    $('.mainLeftQuery [name="month"]').html(monthStr);
                    form.render('select');
                });
            } else {
                $('.mainLeftQuery [name="month"]').html('<option value="">请选择</option>');
                form.render('select');
            }
        });
        form.on('select(yearRight)', function (data) {
            if (data.value) {
                getPlanMonth(data.value, function (monthStr) {
                    $('.mainRightQuery [name="month"]').html(monthStr);
                    form.render('select');
                });
            } else {
                $('.mainRightQuery [name="month"]').html('<option value="">请选择</option>');
                form.render('select');
            }
        });
        element.on('tab(docDemoTabBrief)', function(data){
            // console.log(data.index); //得到当前Tab的所在下标
            if(data.index==0){
                $('.con_right').html('')
                projectLeft()
            }else{
                $('.con_rightZ').html('')
                projectLeftZ()
            }
        });
        /******************************************主项关键任务************************************************/
        //主项-左侧
        function projectLeft() {
            eleTree.render({
                elem: '.ele1',
                url: '/projectTarget/ProjectProAndBag?projOrgId=',
                highlightCurrent: true,
                showLine: true,
                accordion: true, // 手风琴效果
                request: {
                    name: "name", // 显示的内容
                    key: "ids", // 节点id
                    children: "bags",
                },
                response: {
                    statusName: 'code',
                    statusCode: 0,
                    dataName: "obj"
                },
                done:function () {
                    /*var con_right=$(window).width()-$('.con_left').width()-50
                    $('.con_right').css('width',con_right)*/
                }
            });
        }
        projectLeft()
        // 主项-左侧节点点击事件
        eleTree.on("nodeClick(projectLeft)", function (d) {
            if ($('.eleTree-node-content-active').parent().attr('eletree-floor') == 0) {
                $('#leftId').attr('projectId',d.data.currentData.projectId)
                $('#leftId').attr('pbagId','')
                rigthShow(d.data.currentData.projectId, '','');
            } else {
                $('#leftId').attr('projectId','')
                $('#leftId').attr('pbagId',d.data.currentData.pbagId)
                rigthShow('',d.data.currentData.pbagId,'');
            }
        });
        // 主项-右侧
        function rigthShow(projectId, pbagId,deptId) {
            $.ajax({
                url: '/projectTarget/selectByProOrBagShow',
                dataType: 'json',
                type: 'get',
                data:{projectId:projectId,pbagId:pbagId,deptId:deptId,useFlag:false},
                success: function (res) {
                    if(res.flag){
                        var data=res.obj
                        var str=''
                        for(var i=0;i<data.length;i++){
                            str+='<div class="layui-input-block" style="margin-left: 20px"><input lay-filter="leftTarget" type="checkbox" name="'+res.obj[i].tgName+'" title="'+res.obj[i].tgName+'" value="'+res.obj[i].tgId+'" lay-skin="primary"> </div>'
                        }
                        $('.con_right').html(str)
                        form.render()
                        //选中的回显
                        $('.layui-input-block input').each(function (index) {
                            leftArr.forEach(function (v,i) {
                                if($('.layui-input-block input').eq(index).val()==v){
                                    $('.layui-input-block input').eq(index).prop('checked','true')
                                    form.render()
                                }
                            })
                        })
                    }
                }
            });
        }
        //主项-右侧-监听复选框
        form.on('checkbox(leftTarget)', function(data){
            /* console.log(data.elem.checked); //是否被选中，true或者false
             console.log(data.value); //复选框value值，也可以通过data.elem.value得到*/
            //判断是否被选中
            if(data.elem.checked){
                leftArr.push(data.value)
            }else{
                for(var i = 0; i < leftArr.length; i++){
                    if(leftArr[i] == data.value ){
                        leftArr.splice(i,1);
                    }
                }
            }
        });
        //主项-查询
        $('.mainLeftQuery .queryTarget').click(function () {
            var projectId=$('#leftId').attr('projectId')
            var pbagId=$('#leftId').attr('pbagId')
            if(projectId==undefined || pbagId==undefined){
                layer.msg('请先选择左侧！', {icon: 0});
                return false
            }
            /* var year=$('.mainLeftQuery select[name="year"]').val() || ''
             var month=$('.mainLeftQuery select[name="month"]').val() || ''*/
            if($('#mainCenterDept').attr('deptId')){
                var mainCenterDept=$('#mainCenterDept').attr('deptId').replace(/,$/, '')
            }else{
                var mainCenterDept=''
            }
            rigthShow(projectId,pbagId,mainCenterDept);
        })

        /******************************************职能关键任务************************************************/
        //职能-左侧
        function projectLeftZ() {
            eleTree.render({
                elem: '.ele1Z',
                url: '/plcOrg/getTreeListByLoginer?projOrgId=',
                highlightCurrent: true,
                showLine: true,
                accordion: true, // 手风琴效果
                request: {
                    name: "contractorName", // 显示的内容
                    key: "deptId", // 节点id
                    children: "orgList",
                },
                response: {
                    statusName: 'flag',
                    statusCode: true,
                    dataName: "object"
                },
                done:function () {
                    /*var con_right=$(window).width()-$('.con_leftZ').width()-200
                    $('.con_rightZ').css('width',con_right)*/
                }
            });
        }
        // 职能-左侧节点点击事件
        eleTree.on("nodeClick(projectLeftZ)", function (d) {
            // console.log(d.data.currentData)
            if (d.data.currentData.deptParent != 0) {
                var con_right=$(window).width()-$('.con_leftZ').width()-200
                $('.con_rightZ').css('width',con_right)
                $('#rightId').attr('projOrgId',d.data.currentData.projOrgId)
                rigthShowZ(d.data.currentData.projOrgId,'');
            }
        });
        // 职能-右侧
        function rigthShowZ(projOrgId,year) {
            $.ajax({
                url: '/projectTarget/targetByDept',
                dataType: 'json',
                type: 'get',
                data:{projOrgId:projOrgId,year:year,flag:2,useFlag:false},
                success: function (res) {
                    if(res.flag){
                        var data=res.obj
                        var str=''
                        for(var i=0;i<data.length;i++){
                            str+='<div class="layui-input-block" style="margin-left: 20px"><input lay-filter="leftTarget" type="checkbox" name="'+res.obj[i].tgName+'" title="'+res.obj[i].tgName+'" value="'+res.obj[i].tgId+'" lay-skin="primary"> </div>'
                        }
                        $('.con_rightZ').html(str)
                        form.render()
                        //选中的回显
                        $('.con_rightZ .layui-input-block input').each(function (index) {
                            leftArr.forEach(function (v,i) {
                                if($('.con_rightZ .layui-input-block input').eq(index).val()==v){
                                    $('.con_rightZ .layui-input-block input').eq(index).prop('checked','true')
                                    form.render()
                                }
                            })
                        })
                    }
                }
            });
        }
        //职能-查询
        $('.mainRightQuery .queryTarget').click(function () {
            var projOrgId=$('#rightId').attr('projOrgId')
            if(projOrgId==undefined){
                layer.msg('请先选择左侧部门！', {icon: 0});
                return false
            }
            var year=$('.mainRightQuery select[name="year"]').val() || ''
            // var month=$('.mainRightQuery select[name="month"]').val() || ''
            /* if($('#mainCenterDeptRight').attr('deptId')){
                 var mainCenterDept=$('#mainCenterDeptRight').attr('deptId').replace(/,$/, '')
             }else{
                 var mainCenterDept=''
             }*/
            rigthShowZ(projOrgId,year);
        })
    });

    function getPlanMonth(year, fn) {
        $.ajax({
            url: '/planPeroidSetting/showAllSet',
            dataType: 'json',
            type: 'get',
            data:{periodYear: year},
            async:false,
            success: function (res) {
                var str = '<option value="">请选择</option>';
                if (res.object.length > 0) {
                    res.object.forEach(function (item) {
                        str += '<option value="' + item.periodMonth + '">' + item.periodMonth + '</option>'
                    });
                }
                if (fn) {
                    fn(str);
                }
            }
        });
    }
</script>
</body>
</html>

