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
    <title>企业业务关系管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
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
        .itemFont {
            display: inline-block;
            height: 100%;
            cursor: pointer;
            position: relative;
            top: -30px;
            right: -50px;
            float: right;
        }
        .itemFont:hover {
            color: #0000FF;
        }
    </style>
</head>
<body>
<div class="mbox">
    <div style="margin-top: 20px;position: relative;" class="head">
        <img src="/img/exhcompanyrelation.png" style="position: absolute;left: 16px;width: 28px; "><span style="margin-left: 49px;font-size: 20px;">企业业务关系管理</span>
        <hr style="background-color: black"/>
    </div>
    <div style="margin: 10px 0">
        <form class="layui-form" action="">
            <div>
                <div class="layui-inline" style="margin-left: -14px">
                    <label class="layui-form-label">企业名称</label>
                    <div class="layui-input-inline stat">
                        <input id="companyId2" type="text" lay-verify="required" autocomplete="off" class="layui-input">
                        <%--                        <input type="text" name="userName" id="selectDept"  autocomplete="off" class="layui-input dept">--%>
                    </div>
                </div>
                <div class="layui-inline" style="margin-left: -14px">
                    <label class="layui-form-label">活动名称</label>
                    <div class="layui-input-inline stat">
                        <%--                        <input type="text" name="userName" id="selectDept"  autocomplete="off" class="layui-input dept">--%>
                            <input id="actId2" type="text" lay-verify="required" autocomplete="off" class="layui-input ">
                    </div>
                </div>
                <button type="button" class="layui-btn search" style="margin-left: 10px;">查询</button>
                <button type="button" class="layui-btn" id="import"><img src="/img/planCheck/导入.png" style="width: 20px;height: 20px;margin-top: -4px;">导入</button>
                <button type="button" class="layui-btn export" id="export"><img src="/img/planCheck/导出.png" style="width: 20px;height: 20px;margin-top: -4px;">导出</button>
                <button type="button" class="layui-btn layui-btn-normal add" id="add"><i class="layui-icon layui-icon-addition"></i>新建</button>
            </div>


        </form>
    </div>

    <table id="demo" lay-filter="test"></table>
</div>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="application/javascript">
    var flags=false;
    layui.use(['table','form','layer','laydate','upload'], function(){
        var table = layui.table;
        var form = layui.form;
        const layer = layui.layer;
        const laydate = layui.laydate;
        const upload = layui.upload;

        //第一个实例
        var  tableIns=table.render({
            elem: '#demo'
            ,url: '/exhCompanyRelation/selectAll?useFlag=true' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {field:"companyName",title:'企业名称',align:'center'},
                {field:"actName",title:'活动名称',align:'center'},
                {field:"serviceTime",title:'业务发生时间',align:'center'},
                {field:"relationType",title:'关系种类',align:'center'},
                {field:"role",title:'角色',align:'center'},
                {field:"contactName",title:'企业对接人姓名',align:'center'},
                {field:"contactTel",title:'企业对接人电话',align:'center'},
                {field:"businessName",title:'商务联系人姓名',align:'center'},
                {field:"businessMobile",title:'商务联系人电话',align:'center'},
                {field:"relationContent",title:'内容',align:'center'},
                {title: '操作',align:'center',toolbar: '#barDemo'}
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
                    $.post('/exhCompanyRelation/deleteByPrimaryKey',{id:data.id},function (res) {
                        if (res.flag){
                            obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                            layer.close(index);
                            layer.msg('删除成功',{icon:1});
                        }
                    });
                });
            } else if(layEvent === 'edit'){ //编辑
                creat(1,data)
            }
        });

        //点击新建
        $('.add').on("click",function () {
            creat(0)
        })
        form.render();
        // $.ajax({
        //     url: "/exhActivity/selectCompany",
        //     dataType: "json",
        //     async: false,
        //     success: function (res) {
        //         if (res.flag) {
        //             var data = res.obj;
        //             var arr=[];
        //             var str
        //             for (var i = 0; i < data.length; i++) {
        //                 str+='<option value=' + data[i].actId + '>' + data[i].actName + '</option>'
        //             }
        //             $('select[name="actId1"]').append(str);
        //             form.render('select');
        //         }
        //     }
        // })

        // $.ajax({
        //     url: "/exhCompany/selectCompany",
        //     dataType: "json",
        //     async: false,
        //     success: function (res) {
        //         if (res.flag) {
        //             var data = res.obj;
        //             var arr=[];
        //             var str
        //             for (var i = 0; i < data.length; i++) {
        //                 str+='<option value='+data[i].companyId+'>'+data[i].companyName+'</option>'
        //             }
        //             $('select[name="companyId1"]').append(str);
        //             form.render('select');
        //         }
        //     }
        // })


        $('#export').on("click",function(){
            actName = $('#actId2').val();
            companyName= $('#companyId2').val();
            if(flags){
                window.location.href ='/exhCompanyRelation/selectAll?useFlag=true&export=true&actName='+actName+'&companyName='+companyName;
            }else{
                window.location.href ='/exhCompanyRelation/selectAll?useFlag=true&export=true';
            }
        });
        //查询
        var actName;
        var companyName;
        $('.search').click(function(){
            actName = $('#actId2').val();
            companyName= $('#companyId2').val();
            tableIns.reload({
                url: '/exhCompanyRelation/selectAll',
                page:true,
                limit: 20,
                limits:[10,20,30,40,50],
                where: {
                    actName: actName,
                    companyName:companyName,
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
                        window.location.href = encodeURI("/file/exhCrm/企业业务关系管理表.xls")
                    })
                    //上传
                    //执行实例
                    var uploadInst = upload.render({
                        elem: '#test1' //绑定元素
                        ,url: '/exhCompanyRelation/import' //上传接口
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
        function creat(type,obj) {
            if(type=='0'){
                var title = '新建'
                var url = '/exhCompanyRelation/insertExhCompanyRelation'
            }else{
                var title = '编辑'
                var url = '/exhCompanyRelation/updateExhCompanyRelation'
            }
            layer.open({
                type: 1,
                title: title,
                btn:['确定','取消'],
                shade: 0.5,
                maxmin: true, //开启最大化最小化按钮
                area: ['60%', '80%'],
                content:'<form class="layui-form" id="ajaxforms" lay-filter="formsTest">' +
                        '<input type="hidden" name="id"/>'+
                    '<div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 90px;padding: 5px;"><span style="color: red; font-size: 15px;">*</span>企业名称:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    ' <input type="text" id="userId" name="companyId" style="background-color:#ebebeb;" readonly class="layui-input"  placeholder="请选择客户名称">' +
                    '<div class="itemFont companyId" style="color:#1E9FFF">选择</div>' +
                    '    </div>\n' +
                    '  </div>' +
                    '<div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 90px;padding: 5px;"><span style="color: red; font-size: 15px;">*</span>活动名称:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    ' <input type="text" id="userId" name="actId" style="background-color:#ebebeb;" readonly class="layui-input" placeholder="请选择活动名称">' +
                    '<div class="itemFont actId" style="color:#1E9FFF">选择</div>' +
                    '    </div>\n' +
                    '  </div>' +
                    '<div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 90px;padding: 5px;"><span style="color: red; font-size: 15px;">*</span>关系种类:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <select name="relationType">' +
                    '<option id="relationType">请选择关系种类</option>' +
                    '      </select>\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '<div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 90px;padding: 5px;"><span style="color: red; font-size: 15px;">*</span>角色:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <select name="role">' +
                    '          <option id="role">请选择角色</option>' +
                    '      </select>\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '<div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '    <label class="layui-form-label"><span style="color: red; font-size: 15px;">*</span>是否对客户可见:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      是<input type="radio" name="userVisible" value="0" class="layui-input">\n' +
                    '      否<input type="radio" name="userVisible" value="1"  class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '<div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '    <label class="layui-form-label" style="width: 109px;padding: 0px;margin-left: -12px"><span style="color: red; font-size: 15px;">*</span>企业对接人姓名:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="contactName" required  lay-verify="required" placeholder="请输入企业对接人姓名" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '<div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '    <label class="layui-form-label" style="width: 109px;padding: 0px;margin-left: -12px"><span style="color: red; font-size: 15px;">*</span>企业对接人电话:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="contactTel" required  lay-verify="required" placeholder="请输入企业对接人电话" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '<div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '    <label class="layui-form-label" style="width: 109px;padding: 0px;margin-left: -12px"><span style="color: red; font-size: 15px;">*</span>商务联系人姓名:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="businessName" required  lay-verify="required" placeholder="请输入商务联系人姓名" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '<div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '    <label class="layui-form-label" style="width: 109px;padding: 0px;margin-left: -12px"><span style="color: red; font-size: 15px;">*</span>商务联系人电话:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="businessMobile" required  lay-verify="required" placeholder="请输入商务联系人电话" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '<div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '    <label class="layui-form-label"><span style="color: red; font-size: 15px;">*</span>内容:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="relationContent" required  lay-verify="required" placeholder="请输入内容" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div>'+
                    ' <div class="layui-form-item layui-form-text">\n' +
                    '    <label class="layui-form-label"><span style="color: red; font-size: 15px;">*</span>详细说明:</label>\n' +
                    '    <div class="layui-input-block" style="position:relative;">\n' +
                    '      <textarea name="detail" id="detail" class="layui-textarea" maxlength="200"></textarea>\n' +
                    '      <p id="tishi" style="color:red;">输入的长度最多为200</p>\n' +
                    // '      <span id="valLen">0/200</span>\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '</form>',
                success:function(){
                    $('.actId').on("click",function() {
                        layer.open({
                            type: 2,
                            title:'选择活动名称',
                            content:"../fcrmCustomer/selectCustomer?szyx=3",
                            area:['800px','500px'],
                            btn:['确定','取消'],
                            yes:function(index,dom) {
                                var body = layer.getChildFrame('body', index);
                                var dom = body.find('.container .warp .item div.active');
                                var text = dom.parent().parent().attr("text");
                                var val = dom.parent().parent().val();
                                $('input[name=actId]').val(text).attr("text",val)
                                layer.close(index)
                            }
                        })
                    })
                    $('.companyId').on("click",function() {
                        layer.open({
                            type: 2,
                            title:'选择企业名称',
                            content:"../fcrmCustomer/selectCustomer?szyx=2",
                            area:['800px','500px'],
                            btn:['确定','取消'],
                            yes:function(index,dom) {
                                var body = layer.getChildFrame('body', index);
                                var dom = body.find('.container .warp .item div.active');
                                var text = dom.parent().parent().attr("text");
                                var val = dom.parent().parent().val();
                                $('input[name=companyId]').val(text).attr("text",val)
                                layer.close(index)
                            }
                        })
                    })

                    $.ajax({
                        url:" /code/getCode?parentNo=RELATION_TYPE",
                        dataType:"json",
                        async:false,
                        success:function(res) {
                            if(res.flag) {
                                var data = res.obj;
                                for(var i = 0; i < data.length; i++) {
                                    $("#relationType").after('<option value='+data[i].codeNo+'>'+data[i].codeName+'</option>')
                                }
                            }
                        }
                    })

                    $.ajax({
                        url:" /code/getCode?parentNo=IDENTITY_DICTIONARY",
                        dataType:"json",
                        async:false,
                        success:function(res) {
                            if(res.flag) {
                                var data = res.obj;
                                for(var i = 0; i < data.length; i++) {
                                    $("#role").after('<option value='+data[i].codeNo+'>'+data[i].codeName+'</option>')
                                }
                            }
                        }
                    })
                    // $('input[name="lockDaysBefore"]').val('0')
                    form.render();
                    //1是编辑
                    if(type=='1'){
                        form.val("formsTest", obj);
                        $("select[name='relationType'] option:contains("+obj.relationType+")").prop("selected", true);
                        $("select[name='role'] option:contains("+obj.role+")").prop("selected", true);
                        $("input[name='actId']").attr("text",obj.actId)
                        $("input[name='actId']").val(obj.actName);
                        $("input[name='companyId']").attr("text",obj.companyId);
                        $("input[name='companyId']").val(obj.companyName)
                        $("#detail").val(obj.detail)
                        //版主
                        $('#manager').val(obj.boardHosterName);
                        $('#manager').attr("user_id",obj.manager);
                        form.render()
                    }
                    form.render()
                },
                yes:function (index) {
                    var s=$('#ajaxforms').serializeArray();
                    var data={}
                    $.each(s,function (key,value) {
                        data[value.name]=value.value
                    })
                    data.actId=$("input[name='actId']").attr("text");
                    data.actName=$("input[name='actId']").val();
                    data.companyId=$("input[name='companyId']").attr("text");
                    data.companyName=$("input[name='companyId']").val();

                    // var managerMobile = $('input[name="managerMobile"]').val()
                    // var reg =/^[0-9]*$/; //数字
                    // if(!reg.test(managerMobile)){
                    //     layer.msg('管理员手机号只能输入数字',{time:1000,icon:2})
                    //     return false;
                    // }
                    if( $("input[name='actId']").val()==""){
                        layer.msg('请选择企业', {icon: 2});
                    } else if ($("input[name='companyId']").val()=="") {
                        layer.msg('请选择活动', {icon: 2});
                    }else if(data.relationType.indexOf("请选择关系种类")!=-1){
                        layer.msg('请选择关系种类', {icon: 2});
                    }else if(data.role.indexOf("请选择角色")!=-1){
                        layer.msg('请选择角色', {icon: 2});
                    } else if(data.detail===""){
                        layer.msg('请填写详细说明', {icon: 2});
                    }else{
                        // data.manager=$('[name="manager"]').attr('user_id')
                        if(type==1){
                            data.actId=obj.actId
                            data.companyId=obj.companyId
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
                                    tableIns.reload();
                                }
                                else {
                                    layer.msg('操作失败', {icon: 2});
                                }
                            }
                        })
                    }
                }
            })
            //    内容输入信息
            $('#remark').on({
                input: function() {
                    const valLength = $('#remark').val().length;
                    $('#valLen').text(valLength + "/200");
                    if(valLength >= 200) {
                        $('#valLen').css('color','red')
                        $('#tishi').css('display','block')
                    }else {
                        $('#valLen').css('color','#ccc')
                        $('#tishi').css('display','none')
                    }
                }
            })
        }
    });



</script>
</body>
</html>