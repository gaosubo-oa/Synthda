<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>医学CRM日志管理</title>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css"/>
    <script type="text/javascript"  src="/js/common/language.js"></script>
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/gapp/jquerygridly.js"></script>
    <script type="text/javascript"  src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript"  src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <style>
        * {
            font-family: "Microsoft Yahei" !important;
        }
        html,body{
            background: rgb(245,245,245);
            color: #666;
            font-size: 12pt;
        }
        .header {
            height: 78px;
            margin: 20px;
        }

        .header .title {
            margin-left: 10px;
        }
        .header span {
            float: none;
            color: #333;
            display: inline-block;
            margin-left: 10px;
            vertical-align: middle;
            margin-top: -6px;
        }
        .layui-form-item {
            width: 75%;
            margin-left: 6%;
        }
        .layui-textarea {
            height: auto!important;
        }
        .tab{
            background: rgb(245,245,245);
        }
        .tab table tbody tr td {
            text-align: center;
        }
        .tab table thead tr th div {
            line-height: 40px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="header">
    <div class="title">
        <img src="/img/mycount.png"><span style="font-size: 22px;">日志管理</span>
        <hr style="background-color: black"/>
    </div>
<%--    <div style="margin: 20px 10px">--%>
<%--        <form class="layui-form" action="">--%>
<%--            <div>--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label">企业名称</label>--%>
<%--                    <div class="layui-input-inline">--%>
<%--                        <input type="text" name="companyNames" autocomplete="off" class="layui-input">--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                &lt;%&ndash;    输入框&ndash;%&gt;--%>
<%--                <div class="layui-inline year" style="margin: auto 15px">--%>
<%--                    <label class="layui-form-label" style="">企业简称</label>--%>
<%--                    <div class="layui-input-inline year1">--%>
<%--                        <input type="text" name="shortNames" autocomplete="off" class="layui-input">--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                &lt;%&ndash;    功能按钮&ndash;%&gt;--%>
<%--                <button type="button" class="layui-btn search" style="margin-left: 10px;">查询</button>--%>
<%--                <button type="button" class="layui-btn export" id="export">导出</button>--%>
<%--                <button type="button" class="layui-btn" id="import">导入</button>--%>
<%--                <button type="button" class="layui-btn layui-btn-normal add" id="add">新增</button>--%>
<%--            </div>--%>
<%--        </form>--%>
<%--    </div>--%>
    <%--    表格--%>
    <div class="tab" style="margin: auto 10px">
        <table class="layui-hide" id="test" lay-filter="test"></table>
    </div>
</div>
<script>
    let ins = 0;
    var flags = false;
    layui.use(['form','table','layer','laydate','upload'],function() {
        const form = layui.form;
        const table = layui.table;
        const layer = layui.layer;
        const laydate = layui.laydate;
        const upload = layui.upload;
        laydate.render({
            elem:"#startTime",
            type:"date",
            trigger:"click"
        })
        laydate.render({
            elem:"#endTime",
            type:"date",
            trigger:"click"
        })
        const dataTable = table.render({
            elem:"#test",
            url:"/exhLog/selectCompany",
            page:true,
            limit: 10,
            limits:[10,20,30,40,50],
            parseData:function(res) {
                return {
                    "code": res.flag?0:400,
                    "msg": res.msg,
                    "count": res.totleNum,
                    "data": res.obj
                }
            },
            where: {
                useFlag:true,
                Export:false
            },
            request:{
                pageName:'page',
                limitName:'pageSize'
            }
            ,cols: [[
             {field:'logMod', width:142, title: '操作模块'}
            ,{field:'logType', width:90, title: '操作类型'}
            // 设置单元格样式
            ,{field:'oldData', minWidth:300, title: '原始数据',templet:function(d) {
                        if(d.logMod == '活动管理' && d.oldData){
                            return activityStr(d.oldData);
                        } else if(d.logMod == '企业管理' && d.oldData){
                            return companyStr(d.oldData);
                        } else if(d.logMod == '客户管理' && d.oldData){
                            return customerStr(d.oldData);
                        } else if(d.logMod == '客户联系人管理' && d.oldData){
                            return useContactStr(d.oldData);
                        } else if(d.logMod == '企业联系人管理' && d.oldData){
                            return companyContactStr(d.oldData);
                        } else if(d.logMod == '企业业务关系管理' && d.oldData){
                            return companyRelationStr(d.oldData);
                        } else if(d.logMod == '客户业务关系管理' && d.oldData){
                            return useRelationStr(d.oldData);
                        } else{
                            return ''
                        }
                    }
            }
            ,{field:'newData', minWidth:300, title: '修改数据',templet:function(d) {
                        if(d.logMod == '活动管理' && d.newData){
                            return activityStr(d.newData);
                        } else if(d.logMod == '企业管理' && d.newData){
                            return companyStr(d.newData);
                        } else if(d.logMod == '客户管理' && d.newData){
                            return customerStr(d.newData);
                        } else if(d.logMod == '客户联系人管理' && d.newData){
                            return useContactStr(d.newData);
                        } else if(d.logMod == '企业联系人管理' && d.newData){
                            return companyContactStr(d.newData);
                        } else if(d.logMod == '企业业务关系管理' && d.newData){
                            return companyRelationStr(d.newData);
                        } else if(d.logMod == '客户业务关系管理' && d.newData){
                            return useRelationStr(d.newData);
                        } else{
                            return ''
                        }
                    }
                }
            ,{field:'creatorname', width:110, title: '操作人'}
            ,{field:'createTimestr',width:155, title: '操作时间'}
            ,{title:'操作',width:155,templet:function(d) {
                        return '<button class="layui-btn layui-btn-xs" lay-event="detail">查看详情</button><button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</button>'
                    }}
        ]]
        });
        //表格按钮点击事件
        table.on('tool(test)',function(obj) {
            var data = obj.data;
            let ExhLogId = data.logid;
            if(obj.event=='detail') {
                $.ajax({
                    url:"/exhLog/selectByPrimaryKey",
                    data:{
                        ExhLogId:ExhLogId
                    },
                    success:function(res) {
                        if(res.flag) {
                            let detailData = res.object;
                            let logMod = detailData.logMod;
                            var newData = detailData.newData;
                            var oldData = detailData.oldData;
                            if(logMod == '活动管理'){
                                oldData = activityStr(oldData);
                                newData = activityStr(newData);
                            }else if(logMod == '企业管理'){
                                oldData = companyStr(oldData);
                                newData = companyStr(newData);
                            }else if(logMod == '客户管理'){
                                oldData = customerStr(oldData);
                                newData = customerStr(newData);
                            }else if(logMod == '客户联系人管理'){
                                oldData = useContactStr(oldData);
                                newData = useContactStr(newData);
                            }else if(logMod == '企业联系人管理'){
                                oldData = companyContactStr(oldData);
                                newData = companyContactStr(newData);
                            }else if(logMod == '客户业务关系管理'){
                                oldData = useRelationStr(oldData);
                                newData = useRelationStr(newData);
                            }else if(logMod == '企业业务关系管理'){
                                oldData = companyRelationStr(oldData);
                                newData = companyRelationStr(newData);
                            }
                            layer.open({
                                type:1
                                ,shade: 0.5
                                ,maxmin: true
                                ,title: ['查看详情', 'font-size:18px;']
                                ,area: ['60%', '80%']
                                ,content: '<form class="layui-form" id="form1">\n' +
                                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                                    '            <label class="layui-form-label" style="width: 90px;padding: 5px;">操作模块</label>\n' +
                                    '            <div class="layui-input-block">\n' +
                                    '                <input  type="text" name="logMod"  placeholder="" autocomplete="off" disabled class="layui-input">\n' +
                                    '            </div>\n' +
                                    '        </div>\n' +
                                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                                    '            <label class="layui-form-label" style="width: 90px;padding: 5px;">操作类型</label>\n' +
                                    '            <div class="layui-input-block">\n' +
                                    '                <input  type="text" name="logType"  placeholder="" autocomplete="off" disabled class="layui-input">\n' +
                                    '            </div>\n' +
                                    '        </div>\n' +
                                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                                    '            <label class="layui-form-label" style="width: 90px;padding: 5px;">原始数据</label>\n' +
                                    '            <div class="layui-input-block">\n' +
                                    '                <textarea type="text" name="oldData"  autocomplete="off" disabled class="layui-input" rows="5" cols="33" style="height:115px"></textarea>\n' +
                                    '            </div>\n' +
                                    '        </div>\n' +
                                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                                    '            <label class="layui-form-label" style="width: 90px;padding: 5px;">修改数据</label>\n' +
                                    '            <div class="layui-input-block">\n' +
                                    '                <textarea type="text" name="newData"  autocomplete="off" disabled class="layui-input"rows="5" style="height:115px"></textarea>\n' +
                                    '            </div>\n' +
                                    '        </div>\n' +
                                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                                    '            <label class="layui-form-label" style="width: 90px;padding: 5px;">操作人</label>\n' +
                                    '            <div class="layui-input-block">\n' +
                                    '                <input type="text" id="" name="creatorname" autocomplete="off" disabled class="layui-input">\n' +
                                    '            </div>\n' +
                                    '        </div>\n' +
                                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                                    '            <label class="layui-form-label" style="width: 90px;padding: 5px;">操作时间</label>\n' +
                                    '            <div class="layui-input-block">\n' +
                                    '                <input type="text" name="createTimestr" autocomplete="off" disabled class="layui-input">\n' +
                                    '            </div>\n' +
                                    '        </div>\n' +
                                    '    </form>'
                                ,success:function(index) {
                                    $("input[name=logMod]").val(detailData.logMod);
                                    $("input[name=logType]").val(detailData.logType)
                                    $("textarea[name=oldData]").val(oldData)
                                    $("textarea[name=newData]").val(newData)
                                    $("input[name=creatorname]").val(detailData.creatorname)
                                    $("input[name=createTimestr]").val(detailData.createTimestr)
                                }
                                ,end:function() {
                                    dataTable.reload();
                                }
                            })
                        }
                    }
                })
            }else if(obj.event=='del') {
                layer.confirm('确定删除吗',{icon: 3, title:'提示'},function(index) {
                    $.ajax({
                        url:"/exhLog/deleteByPrimaryKey",
                        data:{
                            ExhLogId:ExhLogId
                        },
                        success:function(res) {
                            if(res.flag) {
                                layer.msg('删除成功',{icon:1},function() {
                                    dataTable.reload();
                                })
                            }
                        }
                    })
                })
            }
        });
        //大会活动
        function activityStr(data){
            if(data){
                data = JSON.parse(data);
                Object.keys(data).forEach(key => {
                    if(key == 'enablestr'){
                        data['是否生效'] = data[key];
                        delete data[key]
                    }else if(key == 'createTimestr'){
                        data['创建时间'] = data[key];
                        delete data[key]
                    }else if(key == 'actCode'){
                        data['活动编号'] = data[key];
                        delete data[key]
                    }else if(key == 'actDate'){
                        data['创建时间'] = data[key];
                        delete data[key]
                    }else if(key == 'creator'){
                        data['创建人'] = data[key];
                        delete data[key]
                    }else if(key == 'creatorname'){
                        data['创建人'] = data[key];
                        delete data[key]
                    }else if(key == 'actId'){
                        data['活动id'] = data[key];
                        delete data[key]
                    }else if(key == 'actName'){
                        data['活动名称'] = data[key];
                        delete data[key]
                    }else if(key == 'actType'){
                        data['活动类型'] = data[key];
                        delete data[key]
                    }else if(key == 'manager'){
                        data['管理员'] = data[key];
                        delete data[key]
                    }else if(key == 'managerstr'){
                        data['管理员'] = data[key];
                        delete data[key]
                    }else if(key == 'managerMobile'){
                        data['管理员手机号'] = data[key];
                        delete data[key]
                    }else if(key == 'remark'){
                        data['备注'] = data[key];
                        delete data[key]
                    }else if(key == 'managerMobile'){
                        data['管理员手机号'] = data[key];
                        delete data[key]
                    }else if(key == 'booth'){
                        data['展位信息'] = data[key];
                        delete data[key]
                    } else if(key == 'enable'){
                        delete data[key]
                    }
                });
                return JSON.stringify(data);
            }
        }
        //企业信息管理
        function companyStr(data){
            if(data){
                data = JSON.parse(data);
                Object.keys(data).forEach(key => {
                    if(key == 'createTimestr'){
                        data['创建时间'] = data[key];
                        delete data[key]
                    }else if(key == 'companyCode'){
                        data['企业编号'] = data[key];
                        delete data[key]
                    }else if(key == 'creatorname'){
                        data['创建人'] = data[key];
                        delete data[key]
                    }else if(key == 'companyId'){
                        data['企业id'] = data[key];
                        delete data[key]
                    }else if(key == 'companyName'){
                        data['企业名称'] = data[key];
                        delete data[key]
                    }else if(key == 'shortName'){
                        data['企业简称'] = data[key];
                        delete data[key]
                    }else if(key == 'taxIdNumber'){
                        data['企业税号'] = data[key];
                        delete data[key]
                    }else if(key == 'holder'){
                        data['企业法人'] = data[key];
                        delete data[key]
                    }else if(key == 'regAddress'){
                        data['注册地址'] = data[key];
                        delete data[key]
                    }else if(key == 'website'){
                        data['企业官网'] = data[key];
                        delete data[key]
                    }else if(key == 'rank'){
                        data['级别'] = data[key];
                        delete data[key]
                    }else if(key == 'enterpriseType'){
                        data['企业性质'] = data[key];
                        delete data[key]
                    }else if(key == 'logo'){
                        data['企业LOGO'] = data[key];
                        delete data[key]
                    }else if(key == 'createTime'){
                        delete data[key]
                    }else if(key == 'creator'){
                        delete data[key]
                    }
                });
                return JSON.stringify(data);
            }
        }
        //客户信息管理
        function customerStr(data){
            if(data){
                data = JSON.parse(data);
                Object.keys(data).forEach(key => {
                    if(key == 'createTimestr'){
                        data['创建时间'] = data[key];
                        delete data[key]
                    }else if(key == 'exhUserCode'){
                        data['客户编号'] = data[key];
                        delete data[key]
                    }else if(key == 'creatorname'){
                        data['创建人'] = data[key];
                        delete data[key]
                    }else if(key == 'exhUserId'){
                        data['客户id'] = data[key];
                        delete data[key]
                    }else if(key == 'exhUserName'){
                        data['客户名称'] = data[key];
                        delete data[key]
                    }else if(key == 'gender'){
                        data['性别'] = data[key];
                        delete data[key]
                    }else if(key == 'cardId'){
                        data['身份证号'] = data[key];
                        delete data[key]
                    }else if(key == 'province'){
                        data['省份'] = data[key];
                        delete data[key]
                    }else if(key == 'titles'){
                        data['职称'] = data[key];
                        delete data[key]
                    }else if(key == 'registDate'){
                        data['注册日期'] = data[key];
                        delete data[key]
                    }else if(key == 'from'){
                        data['来源'] = data[key];
                        delete data[key]
                    }else if(key == 'remark'){
                        data['备注'] = data[key];
                        delete data[key]
                    }else if(key == 'enablestr'){
                        data['是否生效'] = data[key];
                        delete data[key]
                    }else if(key == 'createTime'){
                        delete data[key]
                    }else if(key == 'creator'){
                        delete data[key]
                    }else if(key == 'enable'){
                        delete data[key]
                    }
                });
                return JSON.stringify(data);
            }
        }
        //客户联系人管理
        function useContactStr(data){
            if(data){
                data = JSON.parse(data);
                Object.keys(data).forEach(key => {
                    if(key == 'createTimestr'){
                        data['创建时间'] = data[key];
                        delete data[key]
                    }else if(key == 'creatorname'){
                        data['创建人'] = data[key];
                        delete data[key]
                    }else if(key == 'exhUserId'){
                        data['客户id'] = data[key];
                        delete data[key]
                    }else if(key == 'attributeId'){
                        data['客户联系人id'] = data[key];
                        delete data[key]
                    }else if(key == 'nickName'){
                        data['昵称'] = data[key];
                        delete data[key]
                    }else if(key == 'address'){
                        data['住址'] = data[key];
                        delete data[key]
                    }else if(key == 'photo'){
                        data['照片'] = data[key];
                        delete data[key]
                    }else if(key == 'unit'){
                        data['单位'] = data[key];
                        delete data[key]
                    }else if(key == 'job'){
                        data['职务'] = data[key];
                        delete data[key]
                    }else if(key == 'mobile'){
                        data['手机号'] = data[key];
                        delete data[key]
                    }else if(key == 'email'){
                        data['电子邮箱'] = data[key];
                        delete data[key]
                    }else if(key == 'phone'){
                        data['座机'] = data[key];
                        delete data[key]
                    }else if(key == 'openId'){
                        data['微信账号'] = data[key];
                        delete data[key]
                    }else if(key == 'alipayId'){
                        data['支付宝账号'] = data[key];
                        delete data[key]
                    }else if(key == 'createTime'){
                        delete data[key]
                    }else if(key == 'creator'){
                        delete data[key]
                    }
                });
                return JSON.stringify(data);
            }
        }
        //企业联系人管理
        function companyContactStr(data){
            if(data){
                data = JSON.parse(data);
                Object.keys(data).forEach(key => {
                    if(key == 'companyId'){
                        data['企业id'] = data[key];
                        delete data[key]
                    }else if(key == 'contactId'){
                        data['联系人id'] = data[key];
                        delete data[key]
                    }else if(key == 'contactName'){
                        data['联系人姓名'] = data[key];
                        delete data[key]
                    }else if(key == 'contactMobile'){
                        data['联系电话'] = data[key];
                        delete data[key]
                    }else if(key == 'officeAddress'){
                        data['办公地点'] = data[key];
                        delete data[key]
                    }
                });
                return JSON.stringify(data);
            }
        }
        //客户业务关系管理
        function useRelationStr(data){
            if(data){
                data = JSON.parse(data);
                Object.keys(data).forEach(key => {
                    if(key == 'createTimestr'){
                        data['创建时间'] = data[key];
                        delete data[key]
                    }else if(key == 'creatorname'){
                        data['创建人'] = data[key];
                        delete data[key]
                    }else if(key == 'exhUserId'){
                        data['客户id'] = data[key];
                        delete data[key]
                    }else if(key == 'exhUserName'){
                        data['客户名称'] = data[key];
                        delete data[key]
                    }else if(key == 'actId'){
                        data['活动ID'] = data[key];
                        delete data[key]
                    }else if(key == 'actName'){
                        data['活动名称'] = data[key];
                        delete data[key]
                    }else if(key == 'serviceTime'){
                        data['业务发生时间'] = data[key];
                        delete data[key]
                    }else if(key == 'relationType'){
                        data['关系种类'] = data[key];
                        delete data[key]
                    }else if(key == 'role'){
                        data['角色'] = data[key];
                        delete data[key]
                    }else if(key == 'relationContent'){
                        data['内容'] = data[key];
                        delete data[key]
                    }else if(key == 'detail'){
                        data['详细说明'] = data[key];
                        delete data[key]
                    }else if(key == 'creator'){
                        delete data[key]
                    }
                });
                return JSON.stringify(data);
            }
        }
        //企业业务关系管理
        function companyRelationStr(data){
            if(data){
                data = JSON.parse(data);
                Object.keys(data).forEach(key => {
                    if(key == 'relationType'){
                        data['关系种类'] = data[key];
                        delete data[key]
                    }else if(key == 'id'){
                        data['企业业务关系id'] = data[key];
                        delete data[key]
                    }else if(key == 'role'){
                        data['角色'] = data[key];
                        delete data[key]
                    }else if(key == 'contactName'){
                        data['企业对接人姓名'] = data[key];
                        delete data[key]
                    }else if(key == 'contactTel'){
                        data['企业对接人电话'] = data[key];
                        delete data[key]
                    }else if(key == 'businessName'){
                        data['商务联系人姓名'] = data[key];
                        delete data[key]
                    }else if(key == 'businessMobile'){
                        data['商务联系人电话'] = data[key];
                        delete data[key]
                    }else if(key == 'relationContent'){
                        data['内容'] = data[key];
                        delete data[key]
                    }else if(key == 'actName'){
                        data['活动名称'] = data[key];
                        delete data[key]
                    }else if(key == 'actId'){
                        data['活动id'] = data[key];
                        delete data[key]
                    }else if(key == 'companyName'){
                        data['企业名称'] = data[key];
                        delete data[key]
                    }else if(key == 'companyId'){
                        data['企业id'] = data[key];
                        delete data[key]
                    }else if(key == 'serviceTime'){
                        data['业务发生时间'] = data[key];
                        delete data[key]
                    }else if(key == 'detail'){
                        data['详细说明'] = data[key];
                        delete data[key]
                    }
                });
                return JSON.stringify(data);
            }
        }
    })
</script>
</body>
</html>
