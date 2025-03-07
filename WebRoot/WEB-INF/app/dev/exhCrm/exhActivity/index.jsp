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
    <title>活动管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>

    <style>
        .mbox{
            padding: 8px;
        }
        .layui-form-item{
            width: 65%;
            margin-left: 6%;
        }
        .fenlei .layui-form-select{
            width: 40%;
        }
        #valLen {
            color:#ccc;
            font-size: 12px;
            position: absolute;
            right: 0;
        }
        #tishi {
            font-size: 12px;
            display: none;
        }
    </style>
</head>
<body>
<div class="mbox">
    <div style="margin-top: 20px;position: relative;" class="head">
        <img src="/img/activities.png" style="position: absolute;left: 16px;width: 28px; "><span style="margin-left: 49px;font-size: 20px;">活动管理</span>
        <hr style="background-color: black"/>
    </div>
    <div style="margin: 10px 0">
        <form class="layui-form" action="">
            <div class="layui-inline">
                <div class="layui-inline">
                    <label class="layui-form-label">活动名称</label>
                    <div class="layui-input-inline" style="margin-right: 10px;">
                        <input id="actName1" type="text" lay-verify="required" autocomplete="off" class="layui-input projectYear">
                    </div>
                </div>
                <div class="layui-inline" style="margin-left: -14px">
                    <label class="layui-form-label">活动类型</label>
                    <div class="layui-input-inline stat">
<%--                        <input type="text" name="userName" id="selectDept"  autocomplete="off" class="layui-input dept">--%>
                        <select id="actType1" name="actType1" class="actType1" lay-verify="actType1" lay-filter="actType1">
                            <option value="">请选择</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline" style="margin-left: -14px">
                    <label class="layui-form-label" style="margin: 0px 10px;">管理员</label>
                    <div class="layui-input-inline stat">
                        <input id="manager1" name="manager1" class="theControlData layui-input" readonly="readonly" style="width: 230px; display: inline-block;background-color: #D2D2D2" rows="2">
                        <a href="javascript:;" class="addControls" style="margin-left:5px;" data-type=”dept”>添加</a>
                        <a href="javascript:;" class="cleardate">清空</a>
                    </div>
                </div>
            </div>
            <div class="layui-inline">
                <button class="layui-btn search" type="button" style="margin-left: 6px;" >
                    查询
                </button>
            </div>
            <div class="layui-inline">
                <button type="button" class="layui-btn" id="import" lay-event="import" style="margin-left: 6px"><img src="/img/planCheck/导入.png" style="width: 20px;height: 20px;margin-top: -4px;">导入</button>
            </div>
            <div class="layui-inline">
                <button type="button" class="layui-btn" id="export" lay-event="export" style="margin-left: 6px"> <img src="/img/planCheck/导出.png" style="width: 20px;height: 20px;margin-top: -4px;">导出</button>
            </div>
            <div class="layui-inline">
                <button class="layui-btn add" type="button" style="margin-left: 6px;">
                    <i class="layui-icon layui-icon-addition"></i>新建
                </button>
            </div>
        </form>
    </div>
    <div style="text-align: right;"></div>
    <table id="demo" lay-filter="test"></table>
</div>

<script type="text/html" id="barDemo">
<%--    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="modify">详情</a>--%>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="application/javascript">
    var flags=false;
    //导出
    $('#export').on('click',function(){
        window.location.href = '/exhActivity/selectCompany?Export=true';
    })

    //版主的添加
    $(".addControls").on("click",function(){
        user_id = 'manager1';
        $.popWindow("/common/selectUser?0");
    });
    //版主的删除
    $('.cleardate').on("click",function () {
        $("#manager1").val("");
        $("#manager1").attr('username','');
        $("#manager1").attr('dataid','');
        $("#manager1").attr('user_id','');
        $("#manager1").attr('userprivname','');
    });
    layui.use(['form', 'table', 'element', 'layedit','eleTree','upload','layer','laydate'], function () {
        const table = layui.table
        const form = layui.form
        const element = layui.element
        const upload = layui.upload
        const layedit = layui.layedit
        const eleTree = layui.eleTree;
        const layer = layui.layer;
        const laydate = layui.laydate;
        form.render()

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
                    '    <div class="layui-form-mid layui-word-aux">1.导入数据源支持xls格式和xlsx</div>\n' +
                    '  </div>' +
                    '</form>' +
                    '</div>',
                success:function () {
                    // 下载模板
                    $('#load').on('click',function () {
                        window.location.href = encodeURI("/file/exhCrm/大会活动管理导入模板.xls")
                    })
                    //上传
                    //执行实例
                    var uploadInst = upload.render({
                        elem: '#test1' //绑定元素
                        ,url: '/exhActivity/insertImport' //上传接口
                        ,accept:'file'
                        ,auto:false
                        ,bindAction: '.layui-layer-btn0'
                        // ,data:{tableName:data.dName}
                        ,choose: function(obj){
                            //将每次选择的文件追加到文件队列
                            var files = obj.pushFile();
                            obj.preview(function(index, file, result) {
                                $("#textfilter").text(file.name);
                            });
                        }
                        ,done: function(res){
                            //上传完毕回调
                            if(res.flag) {
                                layer.msg('导入成功',{icon:1})
                                dataTable.reload();
                            }else {
                                layer.msg('导入失败',{icon:2})
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
        //第一个实例
        const dataTable=table.render({
            elem: '#demo'
            ,url: '/exhActivity/selectCompany?useFlag=true' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
            {field: "actName", title: '活动名称', align: 'center',width:'10%'},
            {field: "actType", title: '活动类型', align: 'center'},
            {field: "managerstr", title: '管理员', align: 'center'},
            {field: "managerMobile", title: '管理员手机号', align: 'center'},
            {field:"actCode",title:'活动编号',align:'center'},
            {field:"remark",title:'备注',align:'center'},
            {field: "enablestr", title: '是否生效', align: 'center'},
            {field: "creatorname", title: '创建人', align: 'center'},
            {field: "actDate", title: '创建时间', align: 'center'},
            {title: '操作', align: 'center', toolbar: '#barDemo',width:'12%'}
            ]]
            ,parseData: function(res){ //res 即为原始返回的数据
                // console.log(res)
                return {
                    "code": 0, //解析接口状态
                    "msg":"",
                    "count": res.totleNum,
                    "data": res.obj //解析数据列表
                };
            },
        });

        //监听工具条
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
            if(layEvent === 'del'){ //删除
                layer.confirm('确定删除该数据吗？', function(index){
                    $.post('/exhActivity/deleteByPrimaryKey',{exhCompanyId:data.actId},function (res) {
                        if (res.flag){
                            obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                            layer.close(index);
                            layer.msg('删除成功',{icon:1});
                            dataTable.reload();
                        }
                    });
                });
            } else if(layEvent === 'edit'){ //编辑
                creat(1,data)
            }else if(layEvent === 'modify'){ //详情
                creat(2,data)
            }
        });

        //点击新建
        $('.add').on("click",function () {
            creat(0)
        })
        form.render();
        $.ajax({
            url:'/code/getCode?parentNo=ACTIVITY',
            type:'post',
            dataType:'json',
            data:{
            },
            success:function(res){
                var arr=[];
                var str
                for(var i=0;i<res.obj.length;i++){
                    str += '<option  codeNo='+res.obj[i].codeNo+'>'+res.obj[i].codeName+'</option>'
                }
                $('select[name="actType1"]').append(str);
                form.render('select');
            }
        })

        $('#export').on("click",function(){
            if(flags){
                window.location.href ='/exhActivity/selectCompany?Export=true&actName='+actName+'&actType='+actType+'&manager='+manager;
            }else{
                window.location.href ='/exhActivity/selectCompany?Export=true';
            }
        });
        //查询
        var actName;
        var actType;
        var manager;
        $('.search').click(function(){
            actName = $('#actName1').val();
            actType = $('#actType1').val();
            manager = $("#manager1").attr("user_id") || "";
            dataTable.reload({
                url: '/exhActivity/selectCompany',
                page:true,
                limit: 20,
                limits:[10,20,30,40,50],
                where: {
                    actName: actName,
                    actType:actType,
                    manager:manager,
                },
                request:{
                    pageName:'page',
                    limitName:'pageSize'
                },
                page: {
                    curr: 1
                },
                done:function(res) {//渲染完成后回调
                    flags = true;
                }
            });
        })

        function creat(type,obj) {
            if(type=='0'){
                var title = '新建'
                var url = '/exhActivity/insert'
            }else if (type=='1'){
                var title = '编辑'
                var url = '/exhActivity/updateByPrimary'
            }else {
                var title = '详情'
                var url = '/exhActivity/selectByPrimaryKey'
            }
            layer.open({
                type: 1,
                title: title,
                btn:['确定','取消'],
                shade: 0.5,
                maxmin: true, //开启最大化最小化按钮
                area: ['60%', '80%'],
                content:'<form class="layui-form" id="ajaxforms" lay-filter="formsTest">' +
                    '<div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '    <label class="layui-form-label"><span style="color: red; font-size: 15px;">*</span>活动名称:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="actName" required  lay-verify="required" placeholder="请输入活动名称" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '<div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 90px;padding: 5px;"><span style="color: red; font-size: 15px;">*</span>活动类型:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    // '      <input type="text" name="actType" required  lay-verify="required" autocomplete="off" class="layui-input">\n' +
                    '<select id="actType" name="actType" class="actType" lay-verify="actType" lay-filter="actType">\n' +
                    '<option value="">请选择</option>' +
                    '                    </select>' +
                    '    </div>\n' +
                    '  </div>'+
                    // '<div class="layui-form-item">\n' +
                    // '    <label class="layui-form-label" style="width: 90px;padding: 5px;"><span style="color: red; font-size: 15px;">*</span>活动编号:</label>\n' +
                    // '    <div class="layui-input-block">\n' +
                    // '      <input type="text" name="actCode" id="actCode" required  lay-verify="required" autocomplete="off" class="layui-input">\n' +
                    // '    </div>\n' +
                    // '  </div>'+
                    ' <div class="layui-form-item layui-form-text">\n' +
                    '    <label class="layui-form-label">备注:</label>\n' +
                    '    <div class="layui-input-block" style="position:relative;">\n' +
                    '      <textarea name="remark" id="remark" class="layui-textarea" maxlength="200"></textarea>\n' +
                    '      <p id="tishi" style="color:red;">输入的长度最多为200</p>\n' +
                    // '      <span id="valLen">0/200</span>\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '<div class="layui-form-item" style="width: 80%;">\n' +
                    '    <label class="layui-form-label" style="width:100px;padding: 9px 0px;"><span style="color: red; font-size: 15px;">*</span>管理员:</label>\n' +
                    '    <div class="layui-input-block" >\n' +
                    '      <textarea  type="text" name="manager" id="manager" disabled  style="height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                    '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="moderatorAdd">添加</a>\n' +
                    ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="moderatorDel">清空</a>\n'+
                    ' </div>\n' +
                    '  </div>\n' +
                    '<div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '    <label class="layui-form-label" style="width: 95px;padding: 6px"><span style="color: red; font-size: 15px;">*</span>管理员手机号:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="managerMobile" id="managerMobile" required  lay-verify="required" placeholder="请输入管理员手机号" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '<div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">是否生效:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="radio" name="enable" value="0" title="否" checked>\n' +
                    '      <input type="radio" name="enable" value="1" title="是">\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '</form>',
                success:function(){
                    form.render();
                    if (type=='0'){
                        $.ajax({
                            url:'/code/getCode?parentNo=ACTIVITY',
                            type:'post',
                            dataType:'json',
                            data:{
                            },
                            success:function(res){
                                var arr=[];
                                var str
                                for(var i=0;i<res.obj.length;i++){
                                    str += '<option  codeNo='+res.obj[i].codeNo+'>'+res.obj[i].codeName+'</option>'
                                }
                                $('select[name="actType"]').append(str);
                                form.render('select');
                            }
                        })
                    }


                    //1是编辑
                    if(type=='1'){
                        form.val("formsTest", obj);
                        //管理员
                        $('#manager').val(obj.managerstr);
                        $('#manager').attr("user_id",obj.manager);
                            $.ajax({
                                url:"/code/getCode?parentNo=ACTIVITY",
                                success:function(res) {
                                    if(res.flag && res.obj.length > 0) {
                                        var datas = res.obj;
                                        var str
                                        for(var i = 0; i < datas.length; i++) {
                                            if(obj.actType == datas[i].codeName) {
                                                str += '<option selected codeId='+datas[i].codeId+' codeNo='+datas[i].codeNo+'>'+datas[i].codeName+'</option>'
                                            }else {
                                                str += '<option codeId='+datas[i].codeId+' codeNo='+datas[i].codeNo+'>'+datas[i].codeName+'</option>'
                                            }
                                        }
                                        $('select[name="actType"]').append(str);
                                        form.render('select');
                                    }
                                }
                            })
                        form.render()
                    }else if (type=='2'){
                        form.val("formsTest", obj);

                        $("#actCode").attr("disabled", "disabled");
                        $(".moderatorAdd").attr("disabled", "disabled");
                        $(".moderatorDel").attr("disabled", "disabled");
                        $("input[name=actName]").attr("disabled", "disabled");
                        $("input[name=actType]").attr("disabled", "disabled");
                        $("input[name=enable]").attr("disabled", "disabled");
                        $("input[name=managerMobile]").attr("disabled", "disabled");
                        $("textarea[name=remark]").attr("disabled", "disabled");
                        form.render()
                    }

                    //版主的添加
                    $(".moderatorAdd").on("click",function(){
                        user_id = 'manager';
                        $.popWindow("/common/selectUser?0");
                    });
                    //版主的删除
                    $('.moderatorDel').on("click",function () {
                        $("#manager").val("");
                        $("#manager").attr('username','');
                        $("#manager").attr('dataid','');
                        $("#manager").attr('user_id','');
                        $("#manager").attr('userprivname','');
                    });
                    $('select[name="actType"] option').attr('selected',false)
                    $('select[name="actType"] option:last-child').attr("selected",true);
                    form.render()
                },
                yes:function (index) {
                    var managerMobile = $('input[name="managerMobile"]').val()
                    var reg =/^[0-9]*$/; //数字
                    if(!reg.test(managerMobile)){
                        layer.msg('管理员手机号只能输入数字',{time:1000,icon:2})
                        return false;
                    }
                    if( $('input[name="actName"]').val()==''){
                        layer.msg('请填写活动名称', {icon: 2});
                    }else if($('select[name="actType"]').val()==''){
                        layer.msg('请填写活动类型', {icon: 2});
                    }
                    // else if($('#actCode').val() == ""){
                    //     layer.msg('请填写展位信息', {icon: 2});
                    // }
                    else if($('#manager').val() == ""){
                        layer.msg('请填写管理员', {icon: 2});
                    }else if($('#managerMobile').val() == ""){
                        layer.msg('请填写管理员手机号', {icon: 2});
                    }else{
                        var s=$('#ajaxforms').serializeArray();
                        var data={}
                        $.each(s,function (key,value) {
                            data[value.name]=value.value
                        })
                        data.manager=$('[name="manager"]').attr('user_id');
                        if(type==1){
                            data.actId=obj.actId
                        }else if (type==2){
                            data.actId=obj.actId
                        }
                        $.ajax({
                            url:url,
                            type: "post",
                            dataType: "json",
                            data:data,
                            success:function (res) {
                                if(res.flag){
                                    if(type==1){
                                        layer.msg('修改成功',{icon:1});
                                    }else{
                                        layer.msg('新建成功',{icon:1});
                                    }
                                    layer.close(index);
                                    dataTable.reload();
                                } else {
                                    layer.msg(res.msg, {icon: 2});
                                }
                            }
                        })
                    }
                }
            })
        }
    });


</script>
</body>
</html>