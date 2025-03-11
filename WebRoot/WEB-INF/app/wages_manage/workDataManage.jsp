<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<!DOCTYPE html>--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>考勤数据管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <style>
        .mbox{
            padding: 8px;
        }
        html {
            background: white;
            color: #666;
        }
        #ajaxforms .layui-input{
            /*width: 90%;*/
            /*margin: 2px auto;*/
            height: 30px;
            border-radius: 5px;
            line-height: 30px;
        }
        .fieldName{
            margin-left: 1%;
        }
        .layui-form-radio>i{
            font-size: 18px;
        }
        .layui-form-radio{
            margin: 0px 10px 0px 0px;
        }
        .layui-form-label {
            float: left;
            display: block;
            padding: 9px 15px;
            width: 100px;
            font-weight: 400;
            line-height: 20px;
            text-align: right;
        }
    </style>
</head>
<body>
<div class="mbox">
    <div style="margin:10px auto">
        <div style="margin-bottom: 10px;" >
            <span style="font-size: 20px;font-weight: bold;">考勤数据管理</span>
        </div>
        <div>
            <form class="layui-form"  action="" style="display: inline-block">
                <div style="margin-bottom: 10px; " >
                    <div class="layui-inline" style="margin-left: 62px;">
                        <label class="layui-form-label" style="width: 80px;">年份</label>
                        <div class="layui-input-inline" style="width: 125px;">
                            <input type="text" name="educationNum" lay-verify="required|phone" autocomplete="off" class="layui-input" id="">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label" style="width:84px;margin-left: 8px">月份</label>
                        <div class="layui-input-inline" style="width: 170px;">
                            <select class="schoolManageType" lay-verify="required" lay-search="">
                                <option value="">请选择</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label" style="width:60px;padding: 9px 9px;">部门</label>
                        <div class="layui-input-inline" style="width: 105px;">
                            <select name="statePrivateId" class="statePrivateId" lay-verify="required" lay-search="" lay-filter="statePrivateId">
                            </select>
                        </div>
                    </div>
                    <%--学段--%>
                    <div class="layui-inline">
                        <label class="layui-form-label" style="width:80px;">姓名</label>
                        <div class="layui-input-inline" style="width: 170px;">
                            <input type="text" name="deptName"  lay-verify="required|phone" autocomplete="off" class="layui-input" >
                        </div>
                    </div>
                    <div class="layui-inline">
                        <button type="button" class="layui-btn layui-btn-sm" style="height: 32px;line-height: 32px;margin-left: 90px;" id="insert">查询</button>
                        <button type="button" class="layui-btn layui-btn-sm setNum" style="height: 32px;line-height: 32px">发布考勤确认通知</button>
                        <button type="button" class="layui-btn layui-btn-sm setNum" style="height: 32px;line-height: 32px">生成薪资数据</button>
                        <button type="button" class="layui-btn layui-btn-sm add" style="height: 32px;line-height: 32px;" id="newAdd">导入</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <%--表格--%>
    <div class="tables" style="margin-top: 30px;">
        <table class="layui-hide" id="test" lay-filter="test"></table>
    </div>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs privateDel" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs privateDel" lay-event="del">删除</a>
</script>

<script>
    var tableIns;
    layui.use(['form', 'table','laydate','upload','laypage'], function(){
        form = layui.form
            ,table = layui.table
            ,laydate=layui.laydate
            ,upload = layui.upload;
        var laypage = layui.laypage;
        form.render()
        tableIns=table.render({
            elem: '#test'
            ,url: '/EduorgMessage/selectAll?pageSize=10&useFlag=true'
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "data": res.obj, //解析数据列表
                    "count": res.totleNum, //解析数据长度
                };
            }
            ,title: '用户数据表'
            ,cols: [[
                {field:'deptName', title:'姓名',align:'center',}
                ,{field:'orgFullname', title:'身份证号',align:'center',}
                ,{field:'orgNum', title:'岗薪',align:'center'}
                ,{field:'educationNum', title:'岗薪比例',align:'center'}
                ,{field:'unifiedCreditCode', title:'备注',align:'center'}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo',align:'center'}
            ]],
            page:true

        });
        table.on('tool(test)', function(obj){
            var data = obj.data;
            if(obj.event === 'del'){
                layer.confirm('确定要删除该数据吗？', function(index){
                    $.ajax({
                        url:'/EduorgMessage/deleteByOrgId',
                        data:{
                            orgId:data.orgId,
                        },
                        dataType:'json',
                        type:'get',
                        success:function(res){
                            if(res.flag){
                                layer.msg('删除成功',{icon:1});
                                tableIns.reload()
                            }
                        }
                    })
                    layer.close(index);

                });
            } else if(obj.event === 'edit'){
                addWages(1)
            }
        });
        $('.add').click(function () {
            addWages()
        })
        //新建编辑考勤
        function addWages(type){
            if(type == '1'){
                var title = '编辑考勤参数管理'
            }else{
                var title = '新建考勤参数管理'
            }
            layer.open({
                type: 1,
                area: ['40%', '70%'], //宽高
                title: title,
                maxmin:true,
                btn: ['保存','取消'], //可以无限个按钮
                content: '<div class="layui-collapse artifical">\n' +
                    '                            <form class="layui-form" action="" id="licencePart" lay-filter="formTest2" style="text-align: center;">\n' +
                    '                                <%-- 第一行--%>\n' +
                    '                                <div class="layui-row" style="margin-top: 20px;">\n' +
                    '                                    <div class="layui-col-xs12" style="padding: 0 5px;">\n' +
                    '                                        <div class="layui-form-item" >\n' +
                    '                                            <div class="layui-inline">\n' +
                    '                                                <label class="layui-form-label" >考勤分类<span style="color: red; font-size: 15px;">*</span></label>\n' +
                    '                                                <div class="layui-input-inline">\n' +
                    '                                                    <select type="text" name="licenseTypeId" lay-verify="required|phone" autocomplete="off" class="jinyong mustEdit" title="证照类型" lay-filter="licenseTypeId">\n' +
                    '                                                           <option value="">请选择</option>' +
                    '                                                           <option value="1">现场上班</option>' +
                    '                                                           <option value="2">机关上班</option>' +
                    '                                                           <option value="3">休息类别</option>' +
                    '                                                    </select>\n' +
                    '                                                </div>\n' +
                    '                                            </div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                </div>\n' +
                    '                                <%-- 第三行--%>\n' +
                    '                                <div class="layui-row">\n' +
                    '                                    <div class="layui-col-xs12" style="padding: 0 5px;">\n' +
                    '                                        <div class="layui-form-item" >\n' +
                    '                                            <div class="layui-inline">\n' +
                    '                                                <label class="layui-form-label" >考勤类型</label>\n' +
                    '                                                <div class="layui-input-inline">\n' +
                    '                                                    <select type="text" name="licenseTypeId" lay-verify="required|phone" autocomplete="off" class="jinyong mustEdit" title="证照类型" lay-filter="licenseTypeId">\n' +
                    '                                                           <option value="">请选择</option>' +
                    '                                                           <option value="1">出海</option>' +
                    '                                                           <option value="2">外埠考勤</option>' +
                    '                                                    </select>\n' +
                    '                                                </div>\n' +
                    '                                            </div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                </div>\n' +
                    '                                <div class="layui-row" style="margin-top: 20px;">' +
                    '                                    <div class="layui-col-xs12" style="padding: 0 5px;">\n' +
                    '                                        <div class="layui-form-item" >\n' +
                    '                                            <div class="layui-inline">\n' +
                    '                                                <label class="layui-form-label">类型代号<span style="color: red; font-size: 15px;">*</span></label>\n' +
                    '                                                <div class="layui-input-inline">\n' +
                    '                                                    <input type="text" name="licenceName"  lay-verify="required|phone" autocomplete="off" class="layui-input jinyong mustEdit">\n' +
                    '                                                </div>\n' +
                    '                                            </div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                               </div>' +
                    '                                <div class="layui-row" style="margin-top: 20px;">\n' +
                    '                                    <div class="layui-col-xs12" style="padding: 0 5px;">\n' +
                    '                                        <div class="layui-form-item" >\n' +
                    '                                            <div class="layui-inline">\n' +
                    '                                                <label class="layui-form-label" >岗薪计算公式<span style="color: red; font-size: 15px;">*</span></label>\n' +
                    '                                                <div class="layui-input-inline">\n' +
                    '                                                    <input type="text" name="licenceName"  lay-verify="required|phone" autocomplete="off" class="layui-input jinyong mustEdit">\n' +
                    '                                                </div>\n' +
                    '                                            </div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                </div>\n' +
                    '                                <div class="layui-row" style="margin-top: 20px;">\n' +
                    '                                    <div class="layui-col-xs12" style="padding: 0 5px;">\n' +
                    '                                        <div class="layui-form-item" >\n' +
                    '                                            <div class="layui-inline">\n' +
                    '                                                <label class="layui-form-label" >备注<span style="color: red; font-size: 15px;">*</span></label>\n' +
                    '                                                <div class="layui-input-inline">\n' +
                    '                                                    <input type="text" name="licenceName"  lay-verify="required|phone" autocomplete="off" class="layui-input jinyong mustEdit">\n' +
                    '                                                </div>\n' +
                    '                                            </div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                </div>\n' +
                    '                            </form>\n' +
                    '                    </div>',
                success:function () {
                    form.render()
                },
                yes: function(index, layero){
                    //必填项提示
                    for(var i=0; i<$('.mustEdit').length; i++){
                        if ($('.mustEdit').eq(i).val() == '') {
                            layer.msg($('.mustEdit').eq(i).attr('title') + '为必填项！', {icon: 0});
                            return false
                        }
                    }
                    $('#licencePart').attr('action',url)
                    $('#licencePart').ajaxSubmit({
                        type: 'post',
                        dataType: 'json',
                        data: data,
                        success: function (json) {
                            if(json.flag){
                                // licenceId = json.licenceId
                                $.layerMsg({content:'保存成功！',icon:1});
                                table.reload('tableDemocratic4',{
                                    where: {
                                        orgId:orgLegal,
                                        expired: '',
                                    }
                                })
                            }else{
                                $.layerMsg({content:json.msg,icon:1});
                            }
                        }
                    })
                    layer.close(index);
                }
            });
        }
    });


</script>
</body>
</html>