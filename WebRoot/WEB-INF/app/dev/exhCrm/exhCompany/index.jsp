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
    <title>企业信息管理</title>
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
        html,body{
            background: rgb(245,245,245);
        }
        .header {
            margin-top: 15px;
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

        #ajaxforms .layui-form-item .layui-inline {
            margin-bottom: -5px !important;
        }

        #ajaxforms .layui-form-label {
            width: 107px;
        }
        .layui-table td, .layui-table th {
            text-align: center;
        }
        .layui-form-label {
            float: left;
            display: block;
            padding: 9px 0px;
            font-weight: 400;
            line-height: 20px;
            text-align: right;
            padding-right: 10px;
        }
        .container .layui-row {
            height: 50px;
            line-height: 50px;
            margin-left: 30px;
        }
        .layui-form-label {
            text-align: left;
        }
        .layui-table-page {
            text-align: right !important;
        }
        .layui-table img {
            max-width: 100px;
            position: relative;
            bottom: 2px;
        }
        img[src=""],img:not([src]){
            opacity:0;
        }
        .layui-form-item {
            width: 65%;
            margin-left: 6%;
        }
        .layui-input-block {
            margin-left: 120px;
            min-height: 36px;
        }
        #importBox .layui-form-item{
            width: 75%;
        }
    </style>
</head>
<body>
<div class="header">
    <div class="title">
        <img src="../ui/img/exhCrm/companyManage.png" style="width: 28px;"><span style="font-size: 22px;">企业信息管理</span>
        <hr style="background-color: black"/>
    </div>
    <div style="margin: 20px 10px">
        <form class="layui-form" action="">
            <div>
<%--                &lt;%&ndash;            下拉选择框&ndash;%&gt;--%>
                <div class="layui-inline">
                    <label class="layui-form-label">企业名称</label>
                    <div class="layui-input-inline">
                        <input type="text" name="companyNames" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <%--    输入框--%>
                <div class="layui-inline year" style="margin: auto 15px">
                    <label class="layui-form-label" style="">企业简称</label>
                    <div class="layui-input-inline year1">
                        <input type="text" name="shortNames" autocomplete="off" class="layui-input">
                    </div>
                </div>
                    <%--    功能按钮--%>
                    <button type="button" class="layui-btn search" style="margin-left: 10px;">查询</button>
                    <button type="button" class="layui-btn export" id="export">导出</button>
                    <button type="button" class="layui-btn" id="import">导入</button>
                    <button type="button" class="layui-btn layui-btn-normal add" id="add">新增</button>
                </div>
<%--            </div>--%>


        </form>
    </div>
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
            url:"/exhCompany/selectCompany",
            page:true,
            limit: 20,
            limits:[20,30,40,50],
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
            },
            cols:[[
                {field:"companyCode",title:'企业编号'},
                {field:"companyName",title:'企业名称'},
                {field:"shortName",title:'简称'},
                {field:"taxIdNumber",title:'企业税号'},
                {field:"holder",title:'法人'},
                {field:"regAddress",title:'注册地址'},
                {field:"website",title:'企业官网'},
                {field:"rank",title:'级别'},
                {field:"enterpriseType",title:'企业性质'},
                {field:"logo",title:'企业logo',event: 'viewLogo', templet: function(d) {
                    var logo = (d.logo || "");
                    if(logo){
                        var firstLogo=logo.substr(0,logo.lastIndexOf('.'))
                        firstLogo=firstLogo.substr(0,firstLogo.length-1);
                        var lastLogo=logo.substr(logo.lastIndexOf('.')+1);
                        logo = firstLogo+'.'+lastLogo
                        return '<img src="../ui/img/exhCrm/'+logo+'" ' + 'alt="" width="30px" height="30px">';
                    }else{
                        return '暂无图片';
                    }
                }},
                {field:"creatorname",title:'创建人'},
                {field:"createTime",width:130,title:'创建时间'},
                {title:'操作',width:235,templet:function(d) {
                    return '<button class="layui-btn layui-btn-xs layui-btn-normal" lay-event="addContact">添加联系人</button><button class="layui-btn layui-btn-xs" lay-event="detail">详情</button><button class="layui-btn layui-btn-xs layui-btn-normal" lay-event="edit">编辑</button><button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</button>'
                    }},
            ]]
        });
        //表格按钮点击事件
        table.on('tool(test)',function(obj) {
            var data = obj.data;
            let companyId = data.companyId;
            if(obj.event=='detail') {
                layer.open({
                    type:2,
                    title:'查看详情',
                    area:['100%','100%'],
                    content: '/exhCompany/exhCompanyDetail?code=1&type=1&companyId='+companyId,
                    end:function() {
                        dataTable.reload();
                    }
                })
            }else if(obj.event=='viewLogo'){
                var t = $(this).find("img");
                //页面层
                layer.open({
                    type: 1,
                    title: '图片预览',
                    skin: 'layui-layer-rim', //加上边框
                    area: ['50%', '60%'], //宽高 t.width() t.height()
                    shadeClose: true, //开启遮罩关闭
                    end: function (index, layero) {
                        return false;
                    },
                    content: '<div style="margin:10px auto;text-align:center"><img src="' + $(t).attr('src') + '" /></div>'
                });
            }else if(obj.event == 'addContact') {
                layer.open({
                    type: 1
                    ,shade: 0.5
                    ,maxmin: true
                    ,title: ['添加企业联系人信息', 'font-size:18px;']
                    ,area: ['40%', '40%']
                    ,content:'<form class="layui-form" id="form1">\n' +
                        '        <div id="basic_attr" data-type="basic_attr">\n' +
                        '            <div class="layui-form-item"  style="margin-top: 15px;">\n' +
                        '                <label class="layui-form-label" style="width: 90px;padding: 5px;"><span style="color: red; font-size: 15px;">*</span>姓名:</label>\n' +
                        '                <div class="layui-input-block">\n' +
                        '                    <input  type="text" name="contactName" required lay-verify="required" placeholder="请输入联系人姓名" autocomplete="off" class="layui-input">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '            <div class="layui-form-item" style="margin-top: 15px;">\n' +
                        '                <label class="layui-form-label" style="width: 90px;padding: 5px;"><span style="color: red; font-size: 15px;">*</span>联系电话:</label>\n' +
                        '                <div class="layui-input-block">\n' +
                        '                    <input type="text" name="contactMobile" required lay-verify="required" placeholder="请输入联系电话" autocomplete="off" class="layui-input">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '            <div class="layui-form-item"  style="margin-top: 15px;">\n' +
                        '                <label class="layui-form-label" style="width: 90px;padding: 5px;"><span style="color: red; font-size: 15px;">*</span>办公地点:</label>\n' +
                        '                <div class="layui-input-block">\n' +
                        '                    <input  type="text" name="officeAddress" required lay-verify="required"  placeholder="请输入办公地点" autocomplete="off" class="layui-input">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '    </form>'
                    ,btn: ['确定','取消']
                    ,success:function(){
                        form.render();
                    }
                    ,yes: function(index){
                        var contactData = getContactData(companyId);
                        if(contactData) {
                            //企业联系人信息
                            $.ajax({
                                url: "/exhCompanyContact/insert",
                                type: "get",
                                async: false,
                                data: contactData,
                                success:function (res) {
                                    if (res.flag) {
                                        layer.msg('新建成功', {icon: 1})
                                        layer.close(index);
                                        dataTable.reload();
                                    } else {
                                        layer.msg(res.msg, {icon: 2});
                                    }
                                },
                                error: function (res) {
                                    console.log(res)
                                }
                            })
                        }
                    }
                });
            }else if(obj.event == 'edit') {
                layer.open({
                    type:2,
                    title:'编辑',
                    area:['100%','100%'],
                    content: '/exhCompany/exhCompanyDetail?code=2&companyId='+companyId,
                    end:function() {
                        dataTable.reload();
                    }
                })
            }else if(obj.event=='del') {
                layer.confirm('确定删除吗',{icon: 3, title:'提示'},function(index) {
                    $.ajax({
                        url:"/exhCompany/deleteByPrimaryKey",
                        data:{
                            exhCompanyId:companyId
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
        })
        //新建企业
        $('#add').on("click",function() {
            layer.open({
                type: 1
                ,shade: 0.5
                ,maxmin: true
                ,title: ['新建企业', 'font-size:18px;']
                ,area: ['60%', '80%']
                ,content:'<form class="layui-form" id="form1">\n' +
                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '            <label class="layui-form-label layui-required" style="width: 90px;padding: 5px;">企业名称<span style="color: red; font-size: 15px;">*</span></label>\n' +
                    '            <div class="layui-input-block">\n' +
                    '                <input  type="text" name="companyName"  placeholder="请输入企业名称" autocomplete="off" class="layui-input">\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '            <label class="layui-form-label layui-required" style="width: 90px;padding: 5px;">企业简称</label>\n' +
                    '            <div class="layui-input-block">\n' +
                    '                <input  type="text" name="shortName"  placeholder="" autocomplete="off" class="layui-input">\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '            <label class="layui-form-label layui-required" style="width: 90px;padding: 5px;">企业税号<span style="color: red; font-size: 15px;">*</span></label>\n' +
                    '            <div class="layui-input-block">\n' +
                    '                <input  type="text" name="taxIdNumber"  placeholder="" autocomplete="off" class="layui-input">\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '            <label class="layui-form-label layui-required" style="width: 90px;padding: 5px;">企业法人<span style="color: red; font-size: 15px;">*</span></label>\n' +
                    '            <div class="layui-input-block">\n' +
                    '                <input  type="text" name="holder"  placeholder="" autocomplete="off" class="layui-input">\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '            <label class="layui-form-label layui-required" style="width: 90px;padding: 5px;">注册地址</label>\n' +
                    '            <div class="layui-input-block">\n' +
                    '                <input  type="text" name="regAddress"  placeholder="" autocomplete="off" class="layui-input">\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '            <label class="layui-form-label layui-required" style="width: 90px;padding: 5px;">企业官网</label>\n' +
                    '            <div class="layui-input-block">\n' +
                    '                <input  type="text" name="website"  placeholder="" autocomplete="off" class="layui-input">\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '            <label class="layui-form-label layui-required" style="width: 90px;padding: 5px;">级别<span style="color: red; font-size: 15px;">*</span></label>\n' +
                    '            <div class="layui-input-block">\n' +
                    '                <select name="rank" id="rank" lay-filter="project" lay-search></select>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '            <label class="layui-form-label layui-required" style="width: 90px;padding: 5px;">企业性质</label>\n' +
                    '            <div class="layui-input-block">\n' +
                    '                <input  type="text" name="enterpriseType"  placeholder="" autocomplete="off" class="layui-input">\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '            <label class="layui-form-label" style="width: 90px;padding: 5px;">企业LOGO</label>\n' +
                    '            <div class="layui-input-block">\n' +
                    '                <input type=\'file\' id="photo" name="file"\n' +
                    '                       style="cursor:pointer;"\n' +
                    '                       size=\'1\' hideFocus=\'\' title=""/>\n' +
                    '                <div id="img" name="img" style="">\n' +
                    '                    <img class="uploads" src="" style="width: 100px;margin-top: 10px;"/>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '    </form>'
                ,btn: ['确定','取消']
                ,success:function(){
                    //渲染级别下拉框
                    $.ajax({
                        url:"/code/getCode?parentNo=COMPANY",
                        success:function(res) {
                            if(res.flag && res.obj.length > 0) {
                                var data = res.obj;
                                var str = "<option value=''>请选择</option>"
                                for(var i = 0; i < data.length; i++) {
                                    str += '<option codeId='+data[i].codeId+' codeNo='+data[i].codeNo+'>'+data[i].codeName+'</option>'
                                }
                                $("#rank").html(str);
                                form.render("select")
                            }
                        }
                    });
                    photoInit();
                }
                ,yes: function(index){
                    var formData = new FormData($('#form1')[0]);
                    var imgSrc = $("#img img").attr("src");
                    if(!imgSrc){
                        formData.delete('file');
                    }
                    var companyName = $('input[name=companyName]').val();
                    if(!companyName) {
                        layer.msg("企业名称为必填项",{icon: 2})
                        return
                    }
                    var taxIdNumber = $('input[name=taxIdNumber]').val();
                    if(!taxIdNumber) {
                        layer.msg("企业税号为必填项",{icon: 2})
                        return
                    }
                    var holder = $('input[name=holder]').val();
                    if(!holder) {
                        layer.msg("企业法人为必填项",{icon:2})
                        return
                    }
                    var rank = $('#rank').val();
                    if(!rank) {
                        layer.msg("级别为必选项",{icon:2})
                        return
                    }
                    // var shortName = $('input[name=shortName]').val();
                    // if(!shortName) {
                    //     layer.msg("企业简称为必填项",{icon: 2})
                    //     return
                    // }
                    // var regAddress = $('input[name=regAddress]').val();
                    // if(!regAddress) {
                    //     layer.msg("注册地址为必填项",{icon:2})
                    //     return
                    // }
                    // var website = $('input[name=website]').val();
                    // if(!website) {
                    //     layer.msg("企业官网为必填项",{icon:2})
                    //     return
                    // }
                    // var enterpriseType = $('input[name=enterpriseType]').val();
                    // if(!enterpriseType) {
                    //     layer.msg("企业性质为必填项",{icon:2})
                    //     return
                    // }
                    //企业信息
                    const loading = layer.load(2);
                    $.ajax({
                        type:'post',
                        url:"/exhCompany/insert",
                        data: formData,
                        processData: false,
                        contentType : false,
                        success:function(res) {
                            if(res.flag) {
                                layer.msg('新建成功',{icon:1})
                                layer.close(index);
                                dataTable.reload();
                            }else {
                                layer.msg(res.msg,{icon: 2});
                            }
                            layer.close(loading);
                        },
                        error:function (res) {
                            console.log(res)
                        }
                    });
                }
            });
        });
        $('#import').on("click",function(){
            layer.open({
                type: 1,
                area: ['531px', '372px'], //宽高
                title:'导入数据',
                maxmin:true,
                btn: ['确定'], //可以无限个按钮
                content: '<div id="importBox" style="margin: 43px auto;">' +
                    '<form class="layui-form" action="">\n' +
                    '  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 30%;">下载导入模板：</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <a class="layui-form-mid" id="load" style="text-decoration: underline; color: blue; cursor: pointer">下载模板</a>\n' +
                    '    </div>\n' +
                    '  </div>\n' +
                    '  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 30%;">选择导入文件：</label>\n' +
                    '    <div class="layui-input-inline" style="width: 87px;">\n' +
                    '      <button type="button" class="layui-btn layui-btn-sm" id="test1">\n' +
                    '       <i class="layui-icon">&#xe67c;</i>上传文件\n' +
                    '       </button>' +
                    '    </div>\n' +
                    '    <div class="layui-form-mid layui-word-aux" id="textfilter">未选择文件</div>\n' +
                    '  </div>' +
                    '  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 30%;">格式说明：</label>\n' +
                    '    <div class="layui-form-mid layui-word-aux">1.导入数据源只支持xls、xlsx格式</div>\n' +
                    '  </div>' +
                    '</form>' +
                    '</div>',
                success:function () {
                    // 下载模板
                    $('#load').on('click',function () {
                        window.location.href = encodeURI("/file/exhCrm/企业信息管理导入模板.xls")
                    })
                    //上传
                    //执行实例
                    var uploadInst = upload.render({
                        elem: '#test1' //绑定元素
                        ,url: '/exhCompany/insertImport' //上传接口
                        ,accept:'file'
                        ,auto:false
                        ,bindAction: '.layui-layer-btn0'
                        ,choose: function(obj){
                            //将每次选择的文件追加到文件队列
                            var files = obj.pushFile();
                            obj.preview(function(index, file, result) {
                                $("#textfilter").text(file.name);
                            });
                            // console.log(files);
                        }
                        ,done: function(res){
                            //上传完毕回调
                            if(res.flag) {
                                layer.msg('导入成功',{icon:1})
                                dataTable.reload();
                            }else {
                                layer.msg(res.msg,{icon:2})
                            }
                        }
                        ,error: function(){
                            //请求异常回调
                            layer.msg("请上传正确的附件信息");
                        }
                    });
                },
                yes: function(index, layero){
                    layer.close(index);
                }
            });
        });
        $('#export').on("click",function(){
            if(flags){
                window.location.href ='/exhCompany/selectCompany?Export=true&companyName='+companyNames+'&shortName='+shortNames;
            }else{
                window.location.href ='/exhCompany/selectCompany?Export=true';
            }
        });
        //    查询事件
        var companyNames;
        var shortNames;
        $('.search').on("click",function() {
            companyNames = $('input[name=companyNames]').val();
            shortNames = $('input[name=shortNames]').val();
            dataTable.reload({
                url: '/exhCompany/selectCompany',
                page:true,
                limit: 10,
                limits:[10,20,30,40,50],
                where: {
                    companyName:companyNames,
                    shortName:shortNames,
                    page: 1,
                    pageSize: 20,
                    useFlag:true,
                    Export:false
                },
                request:{
                    pageName:'page',
                    limitName:'pageSize'
                },
                page: {
                    curr: 1
                },
                done:function(res){    //渲染完成后回调
                    flags = true;
                }
            });
        });
        function getContactData(companyId){
            var contactName = $('input[name=contactName]').val();
            if(!contactName) {
                layer.msg("联系人姓名为必填项",{icon:2})
                return
            }
            var contactMobile = $('input[name=contactMobile]').val();
            if(!contactMobile) {
                layer.msg("联系人电话为必填项",{icon:2})
                return
            }
            var officeAddress = $('input[name=officeAddress]').val();
            if(!officeAddress) {
                layer.msg("办公地点为必填项",{icon:2})
                return
            }
            return {
                companyId:companyId,
                contactName:contactName,
                contactMobile:contactMobile,
                officeAddress:officeAddress
            }
        }
    })
function photoInit() {
    if (typeof FileReader == 'undefined') {
        $("#photo").on('change',function (event) {
            var src = event.target.value;
            var pathLength = src.length;
            var additionName = src.substring(pathLength - 3, pathLength);
            if (additionName == "jpg" || additionName == "png" || additionName == "gif" || additionName == "JPG" || additionName == "PNG" || additionName == "GIF") {
                var img = '<img src="' + src + '" style="width:170px;height:175px;" />';
                $("#img").empty().append(img);
            } else {
                var img = "<font color=red><fmt:message code="adding.th.contav" /></font>";
                $("#img").empty().append(img);
            }
        });
    } else {
        $("#photo").on('change',function (e) {
            for (var i = 0; i < e.target.files.length; i++) {
                var file = e.target.files.item(i);
                if (!(/^image\/.*$/i.test(file.type))) {
                    var img = "<font color=red><fmt:message code="adding.th.contav" /></font>";
                    $("#img").empty().append(img);
                    continue;
                }

                //实例化FileReader API
                var freader = new FileReader();
                freader.readAsDataURL(file);
                freader.onload = function (e) {
                    var img = '<img src="' + e.target.result + '" style="width:170px;height:175px;"/>';
                    $("#img").empty().append(img);
                }
            }
        });
    }
}

</script>
</body>
</html>
