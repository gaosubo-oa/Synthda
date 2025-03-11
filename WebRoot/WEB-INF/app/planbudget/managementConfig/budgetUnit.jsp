<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html >
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>预算单位</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css?2019101815.40">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style>
        html,body{
            height: 100%;
            background: #fff;
        }
        hr{
            margin: 5px 0px;
        }
        .query .layui-input-block{
            margin-left: 114px;
        }
        .layui-input-block{
            margin-left: 154px;
        }
        .layui-form-label{
            width: 122px;
        }
        .layui-table-view{
            margin-left: 11px;
        }
        .layui-table-view .layui-table td, .layui-table-view .layui-table th{
            padding: 3px 0px;
        }
        .layui-table-tool{
            min-height: 40px;
            padding: 5px 15px;
        }
        .layui-form-item{
            /*width: 49%;*/
            margin-bottom: 8px;
        }
        /*  .newAndEdit{
              display: flex;
          }*/
        .layui-layer-btn{
            text-align: center;
        }
        .openFile input[type=file]{
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
        .layui-btn-container{
            position: relative;
        }
        .query .layui-form-item{
            margin-bottom: -5px;
        }
        .query .layui-form-label{
            width: 60px;
            padding: 9px 0px;
        }
        .inputs .layui-form-select .layui-input{
            height: 35px !important;
        }
        .layui-textarea{
            min-height: 80px;
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
        .con_left {
            float: left;
            width: 230px;
            /*height: 100%;*/
            margin-top: 10px;
            /*overflow-y: auto;*/
        }
        .con_right {
            float: left;
            width: calc(100% - 230px);
            height: 100%;
            position: relative;
        }
        .foldIcon{
            display: none;
            position: absolute;
            left: -10px;
            top: 42%;
            font-size: 30px;
            cursor: pointer;
        }
        .select{
            background: #c7e1ff;
        }
        .con_left ul li{
            padding: 5px;
        }
        .con_left input{
            height: 35px;
        }
        .layui-table-tool-self{
            top: 4px;
        }
        .layui-col-xs2{
            width: 21%;
        }
    </style>
</head>
<body>
<input type="hidden" id="plbOrgId">
<div >
    <div style="padding: 0px 8px;" class="clearfix">
        <div class="con_left">
            <div style="margin-bottom:10px;text-align: center">
                <button type="button" class="layui-btn layui-btn-sm " id="import">导入</button>
                <button type="button" class="layui-btn layui-btn-sm " id="del">删除</button>
                <button type="button" class="layui-btn layui-btn-sm " id="edit">编辑</button>
            </div>
            <div style="text-align: center;background: #f2f2f2;height: 30px;line-height: 30px;font-size: 17px;font-weight: bold;">组织机构</div>
            <div class="eleTree ele1" style="margin-top: 10px;height: 560px;overflow-x: auto;" lay-filter="organizationLeft"></div>
        </div>
        <div class="con_right">
            <div class="tishi" style="height: 100%;text-align: center;border: none;">
                <div style="width:100%;padding-top:10%;"><img style="margin-top: 2%;text-align: center;" src="/img/noData.png" alt=""></div>
                <h2 style="margin: auto;text-align: center;font-size: 20px;font-weight: normal;">请选择左侧组织</h2>
            </div>
            <form class="rightContent layui-form" style="display: none" lay-filter="rightContent">
                <div class="layui-row" style="margin-top: 5%">
                    <div class="layui-col-xs6">
                        <div class="layui-form-item">
                            <label class="layui-form-label">预算单位名称</label>
                            <div class="layui-input-block">
                                <input type="text" name="deptName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs6">
                        <div class="layui-form-item">
                            <label class="layui-form-label">预算单位简称</label>
                            <div class="layui-input-block">
                                <input type="text" name="deptShortName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-row" style="margin: 15px auto">
                    <div class="layui-col-xs6">
                        <div class="layui-form-item">
                            <label class="layui-form-label">预算单位负责人</label>
                            <div class="layui-input-block">
                                <input type="text" name="plbDeptUser" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs6">
                        <div class="layui-form-item">
                            <label class="layui-form-label">预算单位联系电话</label>
                            <div class="layui-input-block">
                                <input type="text" name="deptUserPhone" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-row">
                    <div class="layui-col-xs6">
                        <div class="layui-form-item">
                            <label class="layui-form-label">经度</label>
                            <div class="layui-input-block">
                                <input type="text" name="longitude" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs6">
                        <div class="layui-form-item">
                            <label class="layui-form-label">维度</label>
                            <div class="layui-input-block">
                                <input type="text" name="latitude" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                </div>
                <div style="font-size: 18px; padding: 10px">授权其他组织或人员查阅</div>
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 140px;padding: 9px 5px">授权部门</label>
                    <div class="layui-input-block">
                            <textarea placeholder="请选择授权部门" id="privDept" readonly class="layui-textarea"
                                      style="float: left;width: 70%; background-color: #e7e7e7;"></textarea>
                        <div style="float: left; margin-top: 20px;" t_id="privDept">
                            <a href="javascript:;" style="margin-left: 10px; color: blue;" class="add_dept">添加</a>
                            <a href="javascript:;" style="margin-left: 10px; color: red;" class="clear_dept">清空</a>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 140px;padding: 9px 5px">授权角色</label>
                    <div class="layui-input-block">
                            <textarea placeholder="请选择授权角色" id="privRole" readonly class="layui-textarea"
                                      style="float: left;width: 70%; background-color: #e7e7e7;"></textarea>
                        <div style="float: left; margin-top: 20px;" t_id="privRole">
                            <a href="javascript:;" style="margin-left: 10px; color: blue;" class="add_role">添加</a>
                            <a href="javascript:;" style="margin-left: 10px; color: red;" class="clear_role">清空</a>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 140px;padding: 9px 5px">授权人员</label>
                    <div class="layui-input-block">
                            <textarea placeholder="请选择授权人员" id="privUser" readonly class="layui-textarea"
                                      style="float: left;width: 70%; background-color: #e7e7e7;"></textarea>
                        <div style="float: left; margin-top: 20px;" t_id="privUser">
                            <a href="javascript:;" style="margin-left: 10px; color: blue;" class="add_user">添加</a>
                            <a href="javascript:;" style="margin-left: 10px; color: red;" class="clear_user">清空</a>
                        </div>
                    </div>
                </div>
                <div style="text-align: center;margin-top: 6%">
                    <button type="button" class="layui-btn save">保存</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    var insTree
    var importFlag=false
    $('.con_left').height($(document).height() - 160);
    layui.use(['form','eleTree'], function(){
        var form = layui.form;
        var eleTree = layui.eleTree;
        /**
         * 左侧组织机构树
         */
        function leftShow() {
            insTree =eleTree.render({
                elem: '.ele1',
                url:'/plbOrg/lazyLoading?'+'&_='+new Date().getTime()+'&deptId=0',
                highlightCurrent:true,
                showLine: true,
                accordion: true,
                lazy:true,
                request: {
                    name: "deptName", // 显示的内容
                    key: "plbOrgId", // 节点id
                    children: "orgList",
                },
                response: {
                    statusName: 'flag',
                    statusCode: true,
                    dataName: "obj"
                },
                load: function(data,callback) {
                    $.post('/plbOrg/lazyLoading?deptId='+data.deptId,function (res) {
                        callback(res.obj);//点击节点回调
                    })
                },
            });
        }
        leftShow()
        // 节点点击事件
        eleTree.on("nodeClick(organizationLeft)",function(d) {
            // console.log(d.data);    // 点击节点对于的数据
            var loadindIndex = layer.load(0);
            var data=d.data.currentData
            $('#plbOrgId').val(data.plbOrgId)
            $('.tishi').hide()
            $('.rightContent').show()
            $('#import').attr('names',data.deptName)
            $.get('/plbOrg/queryId', {plbOrgId: data.plbOrgId}, function (res) {
                layer.close(loadindIndex);
                form.val("rightContent",res.object);
                $('.rightContent [name]').each(function () {
                    $(this).val(res.object[$(this).attr('name')] || '')
                })
                $('#privUser').val(res.object.userPrivName || '');
                $('#privUser').attr('user_id', res.object.userPriv || '');
                $('#privDept').val(res.object.deptPrivName || '');
                $('#privDept').attr('deptid', res.object.deptPriv || '');
                $('#privRole').val(res.object.rolePrivName || '');
                $('#privRole').attr('privid', res.object.rolePriv || '');
            })
        })
        //点击保存
        $('.save').on('click',function () {
            var params={}
            $('.rightContent [name]').each(function () {
                params[$(this).attr('name')]=$(this).val()
            })
            params.plbOrgId=$('#plbOrgId').val()
            params.userPriv = $('#privUser').attr('user_id') || '';
            params.deptPriv = $('#privDept').attr('deptid') || '';
            params.rolePriv = $('#privRole').attr('privid') || '';
            $.post('/plbOrg/update',params,function (res) {
                if(res.flag){
                    layer.msg('保存成功！',{icon:1});
                }
            })
        })
        //导入
        $('#import').on('click',function () {
            dept_id = $(this).attr('id');
            importFlag = true;
            $.popWindow("/common/selectDept");
        })
        //点击删除
        $('#del').on('click',function () {
            var plbOrgId=$('#plbOrgId').val()
            if(plbOrgId=='' || plbOrgId==undefined){
                layer.msg('请选择左侧一项!', { icon:0});
                return false
            }
            layer.confirm('确定删除'+'&nbsp;&nbsp;'+$('#import').attr('names')+'&nbsp;&nbsp;'+'吗？', function(index){
                $.post('/plbOrg/delete',{plbOrgId:plbOrgId},function (res) {
                    if(res.flag){
                        layer.msg('删除成功!', { icon:1});
                        insTree.reload()
                        $('.tishi').show()
                        $('.rightContent').hide()
                    }
                })
            });
        })
        //点击编辑
        $('#edit').on('click',function () {
            var plbOrgId=$('#plbOrgId').val()
            if(plbOrgId=='' || plbOrgId==undefined){
                layer.msg('请选择左侧一项!', { icon:0});
                return false
            }
            layer.open({
                type: 1,
                title: '编辑',
                area: ['40%', '30%'],
                btn: ['确定', '取消'],
                content:'<div  class="layui-form edit"  style="margin-top: 15px">' +
                    '  <div class="layui-form-item" style="width: 88%">\n' +
                    '    <label class="layui-form-label">组织机构名称</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="deptName" value="'+ $('#import').attr('names')+'" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '</div>',
                yes:function (index, layero) {
                    $.post('/plbOrg/update',{plbOrgId:plbOrgId,deptName:$('.edit input[name="deptName"]').val()},function (res) {
                        if(res.flag){
                            layer.msg('修改成功!', { icon:1});
                            layer.close(index)
                            insTree.reload()
                            $('.tishi').show()
                            $('.rightContent').hide()
                        }
                    })
                }
            })
        })
    });
    /**
     * 导入后的方法
     * @param deptIds  部门id
     */
    function importLeft(deptIds) {
        if(importFlag){
            $.post('/plbOrg/insert', {deptIds: deptIds}, function (res) {
                if (res.flag) {
                    layer.msg('导入成功！', {icon: 1});
                    insTree.reload()
                    $('#import').attr('deptid', '')
                    $('.tishi').show()
                    $('.rightContent').hide()
                }
            });
        }
    }

    // 添加授权部门
    $(document).on('click', '.add_dept', function () {
        dept_id = $(this).parent().attr('t_id');
        importFlag = false;
        $.popWindow("/common/selectDept");
    });
    // 清空授权部门
    $(document).on('click', '.clear_dept', function () {
        var id = $(this).parent().attr('t_id')
        $('#' + id).val('');
        $('#' + id).attr('deptid', '');
        $('#' + id).attr('deptname', '');
    });

    // 添加授权角色
    $(document).on('click', '.add_role', function () {
        priv_id = $(this).parent().attr('t_id');
        $.popWindow("/common/selectPriv");
    });
    // 清空授权角色
    $(document).on('click', '.clear_role', function () {
        var id = $(this).parent().attr('t_id')
        $('#' + id).val('');
        $('#' + id).attr('privid', '');
        $('#' + id).attr('userpriv', '');
    });

    // 添加授权人员
    $(document).on('click', '.add_user', function () {
        user_id = $(this).parent().attr('t_id');
        var chooseType = $(this).parent().attr('is_more') == 1 ? 0 : '';
        $.popWindow("/common/selectUser?"+chooseType);
    });
    // 清空授权人员
    $(document).on('click', '.clear_user', function () {
        var id = $(this).parent().attr('t_id')
        $('#' + id).val('');
        $('#' + id).attr('user_id', '');
        $('#' + id).attr('username', '');
        $('#' + id).attr('dataid', '');
        $('#' + id).attr('userprivname', '');
    });
</script>

</body>

</html>
