<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-04-26
  Time: 11:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>项目信息补充</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/jquery/jquery.cookie.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <style>
        hr{
            margin: 5px 0px;
        }
        .layui-input-block{
            margin-left: 150px;
        }
        .layui-form-label{
            width: 120px;
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
        /*.newAndEdit{
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
    </style>
</head>
<body>
<div >
    <div style="padding: 0px 8px">
        <table id="demo" lay-filter="test"></table>
    </div>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script>
    var table
    var form
    var laydate
    var upload
    var tableIns1
    layui.use(['table','form','laydate','upload'], function(){
        table = layui.table;
        form = layui.form;
        laydate = layui.laydate;
        upload = layui.upload;

        //第一个实例
       /* tableIns1=table.render({
            elem: '#demo'
            ,url: '/ProjectInfo/selectProjectInfo' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'projectChief', title: '项目总工',}
                ,{field: 'contractDeptName', title: '总承包部',}
                ,{field: 'respectiveRegionName', title: '所属区域',}
                ,{field: 'workContent', title: '施工内容',}
                ,{field: 'breakTimes', title: '分解次数',}
                ,{field: 'realBeginDate', title: '实际开始时间',}
                ,{field: 'realEndDate', title: '实际完工时间',}
                ,{field: 'projectStatus', title: '项目进展',templet:function (d) {
                        if(d.projectStatus==0){
                            return '在建'
                        }else if(d.projectStatus==1){
                            return '收尾'
                        }else if(d.projectStatus==2){
                            return '竣工'
                        }else if(d.projectStatus==3){
                            return '关闭'
                        }else{
                            return ''
                        }
                    }}
                ,{title: '操作',align:'center', toolbar: '#barDemo',width:260}
            ]]
        });
        //监听工具条
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）

            if(layEvent === 'detail'){ //查看
                creat('2',data)
            } else if(layEvent === 'del'){ //删除
                layer.confirm('确定删除该条数据吗？', function(index){
                    $.ajax({
                        url:'/ProjectInfo/delProjectInfo',
                        dataType:'json',
                        type:'get',
                        data:{projectId:data.projectId},
                        success:function(res){
                            if(res.flag){
                                layer.msg('删除成功！',{icon:1});
                                layer.close(index)
                                tableIns1.reload()
                            }
                        }
                    })
                });
            } else if(layEvent === 'edit'){ //编辑
                creat('1',data)
            }
        });*/
    });
    //新增编辑共用方法
    function creat(type,data) {
        var title
        if(type=='0'){
            title='添加项目信息补充'
            url='/ProjectInfo/insertProjectInfo'
        }else if(type=='1'){
            title='编辑项目信息补充'
            url='/ProjectInfo/upProjectInfo'
        }else{
            title='查看项目信息补充'
        }
        layer.open({
            type: 1,
            title: title,
            area: ['100%', '100%'],
            maxmin:true,
            min: function(){
                $('.layui-layer-shade').hide()
            },
            btn:['确定','取消'],
            content: '<form class="layui-form" id="form" lay-filter="formTest">' +
                //第一行
                '<div class="layui-row">'+
                ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">项目名称</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="projectName"  autocomplete="off" class="layui-input jinyong" disabled>\n' +
                '    </div>\n' +
                '  </div>'+
                '  </div>'+
                ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">总承包部负责人</label>\n' +
                '    <div class="layui-input-block respectiveRegion">\n' +
                '  <textarea  type="text" name="respectiveRegion" id="respectiveRegion" readonly  style="background:#e7e7e7;height: 45px;width: 370px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="respectiveRegionAdd">添加</a>\n' +
                ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="respectiveRegionDel">清空</a>\n'+
                '    </div>\n' +
                '  </div> </div>'+
                '</div>'+
                //第二行
                '<div class="layui-row">'+
                ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                /*'    <label class="layui-form-label">分解次数</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="breakTimes"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +*/
                '    <label class="layui-form-label">项目经理</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="projectManage"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div>'+
                '  </div>'+
                ' <div class="newAndEdit layui-col-xs6"><div class="layui-form-item">\n' +
                /*   '    <label class="layui-form-label">实际开始时间</label>\n' +
                   '    <div class="layui-input-block">\n' +
                   '      <input type="text" class="layui-input jinyong" name="realBeginDate" id="test3">' +
                   '    </div>\n' +*/
                '    <label class="layui-form-label">项目经理电话</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="projectManagePhone"  autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div> </div>'+
                '</div>'+
                //第三行
                '<div class="layui-row">'+
                ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                /*'    <label class="layui-form-label">实际完工时间</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" class="layui-input jinyong" name="realEndDate" id="test4">' +
                '    </div>\n' +*/
                '    <label class="layui-form-label">业主单位</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="ownerUnit" autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div>'+
                '  </div>'+
                ' <div class="newAndEdit layui-col-xs6"><div class="layui-form-item">\n' +
                /* '    <label class="layui-form-label">项目进展</label>\n' +
                 '    <div class="layui-input-block projectStatus ">\n' +
                 ' <select name="projectStatus" lay-verify="required" class="jinyong">\n' +
                 '        <option value=""></option>\n' +
                 '        <option value="0">在建</option>\n' +
                 '        <option value="1">收尾</option>\n' +
                 '        <option value="2">竣工</option>\n' +
                 '        <option value="3">关闭</option>\n' +
                 '      </select>'+
                 '    </div>\n' +*/
                '    <label class="layui-form-label">业主单位联系方式</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="ownerUnit" autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div> </div>'+
                '</div>'+
                //第四行
                '<div class="layui-row">'+
                ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">监理单位</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="manageUnit" autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div>'+
                '  </div>'+
                ' <div class="newAndEdit layui-col-xs6"><div class="layui-form-item">\n' +
                '    <label class="layui-form-label">监理单位联系方式</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="manageUnit" autocomplete="off" class="layui-input jinyong">\n' +
                '    </div>\n' +
                '  </div> </div>'+
                '</div>'+
                //第五行
                '<div><div class="layui-form-item">' +
                '    <label class="layui-form-label">施工内容</label>\n' +
                '    <div class="layui-input-block">\n' +
                '<textarea name="workContent"  class="layui-textarea jinyong"></textarea>'+
                '    </div>\n' +
                '</div>'+
                '</div>'+
                ' <div class="layui-form-item">\n' +
                '    <label class="layui-form-label">附件</label>\n' +
                '    <div class="layui-input-block">\n' +
              /*  '<button type="button" class="layui-btn" id="attachment">\n' +
                '  <i class="layui-icon">&#xe67c;</i>上传附件' +
                '</button>'+*/
                '<div id="fujian"></div>'+
                ' <div id="fileAll">\n' +
                '</div>\n' +
                '<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                '<img src="../img/mg11.png" alt="">\n' +
                '<span><fmt:message code="email.th.addfile"/></span>\n' +
                '<input type="file" multiple id="fileupload" data-url="/upload?module=plancheck" name="file">\n' +
                '</a>\n' +
                '    </div>\n' +
                '  </div>'+
                '</form>',
            success:function () {
                fileuploadFn('#fileupload',$('#fileAll'));
                form.render()
                if(type=='1'){
                    //给表单赋值
                    form.val("formTest",data);
                    console.log(data)
                    $('#contractDept').val(data.contractDeptName)
                    $('#contractDept').attr('deptid',data.contractDept)
                    $('#respectiveRegion').val(data.respectiveRegionName)
                    $('#respectiveRegion').attr('deptid',data.respectiveRegion)
                    //附件回显
                    var strs1 = '';
                    for (var i = 0; i < data.attachmentList.length; i++) {
                        strs1 += '<div class="dech" deUrl="'+encodeURI(data.attachmentList[i].attUrl)+'"><a href="/download?'+encodeURI(data.attachmentList[i].attUrl)+'" NAME="' + data.attachmentList[i].attachName + '*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + data.attachmentList[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data.attachmentList[i].aid + '@' + data.attachmentList[i].ym + '_' + data.attachmentList[i].attachId + ',"></div>';
                    }
                    $('#fileAll').append(strs1);
                }
                if(type=='2'){
                    $('.projectStatus').html('<input type="text" name="" value="'+function () {
                        if(data.projectStatus==0){
                            return '在建'
                        }else if(data.projectStatus==1){
                            return '收尾'
                        }else if(data.projectStatus==2){
                            return '竣工'
                        }else if(data.projectStatus==3){
                            return '关闭'
                        }else{
                            return ''
                        }
                    }()+'"  autocomplete="off" class="layui-input jinyong">')
                    $('.contractDept').html('<input type="text" name="" value="'+function () {
                        if(data.contractDeptName!=undefined){
                            if(data.contractDeptName.indexOf(',')!=-1){
                                return data.contractDeptName.substring(0,data.contractDeptName.length-1)
                            }else{
                                return data.contractDeptName
                            }
                        }else {
                            return ''
                        }
                    }()+'"  autocomplete="off" class="layui-input jinyong">')
                    $('.respectiveRegion').html('<input type="text" name="" value="'+function () {
                        if(data.respectiveRegionName!=undefined){
                            if(data.respectiveRegionName.indexOf(',')!=-1){
                                return data.respectiveRegionName.substring(0,data.respectiveRegionName.length-1)
                            }else{
                                return data.respectiveRegionName
                            }
                        }else {
                            return ''
                        }
                    }()+'"  autocomplete="off" class="layui-input jinyong">')
                    $('.layui-input').css('border','none')
                    // console.log(data)
                    form.val("formTest",data);
                    $('.openFile').hide()
                    $('.layui-layer-btn').hide()
                    $('.contractDeptAdd').hide()
                    $('.contractDeptDel').hide()
                    $('.respectiveRegionAdd').hide()
                    $('.respectiveRegionDel').hide()
                    for(var i=0;i<$('.jinyong').length;i++){
                        $('.jinyong').eq(i).attr('disabled',true)
                        // form.render()
                    }
                    form.render()
                    //附件回显
                    var strs1 = '';
                    for (var i = 0; i < data.attachmentList.length; i++) {
                        strs1 += '<div class="dech" deUrl="'+encodeURI(data.attachmentList[i].attUrl)+'"><a href="/download?'+encodeURI(data.attachmentList[i].attUrl)+'" NAME="' + data.attachmentList[i].attachName + '*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + data.attachmentList[i].attachName + '</a><input type="hidden" class="inHidden" value="' + data.attachmentList[i].aid + '@' + data.attachmentList[i].ym + '_' + data.attachmentList[i].attachId + ',"></div>';
                    }
                    $('#fileAll').append(strs1);

                }
                laydate.render({
                    elem: '#test1' //指定元素
                });
                laydate.render({
                    elem: '#test2' //指定元素
                });
                //总承包部的添加
                $(".contractDeptAdd").on("click",function(){
                    dept_id = 'contractDept';
                    $.popWindow("/common/selectDept?0");
                });
                //总承包部的删除
                $('.contractDeptDel').on('click',function () {
                    $('#contractDept').attr("deptid","");
                    $('#contractDept').attr("deptno","");
                    $('#contractDept').val("");
                });
                //所属区域的添加
                $(".respectiveRegionAdd").on("click",function(){
                    dept_id = 'respectiveRegion';
                    $.popWindow("/common/selectDept?0");
                });
                //所属区域的删除
                $('.respectiveRegionDel').on('click',function () {
                    $('#respectiveRegion').attr("deptid","");
                    $('#respectiveRegion').attr("deptno","");
                    $('#respectiveRegion').val("");
                });
            },
            yes:function (index) {
                var datas=$('#form').serializeArray()
                // console.log(data)
                var obj={}
                datas.forEach(function (item,index) {
                    obj[item.name]=item.value
                })
                // console.log(obj)
                //获取总承包部的id
                if($('#contractDept').attr('deptid')!=undefined){
                    obj.contractDept=$('#contractDept').attr('deptid').substring(0,$('#contractDept').attr('deptid').length-1)
                }
                //获取所属区域的id
                if($('#respectiveRegion').attr('deptid')!=undefined){
                    obj.respectiveRegion=$('#respectiveRegion').attr('deptid').substring(0,$('#respectiveRegion').attr('deptid').length-1)
                }
                //保存附件信息
                var filearr=$('#fileAll .dech');
                var aId='';
                var uId='';
                for(var i=0;i<filearr.length;i++){
                    aId+=$(filearr[i]).find('input').val();
                    uId+=$(filearr[i]).find('a').attr('name');
                }
                obj.attachmentId=aId
                obj.attachmentName=uId

                if(type=='1'){
                    obj.projectId=data.projectId
                }
                $.ajax({
                    url:url,
                    data:obj,
                    dataType:'json',
                    type:'post',
                    success:function(res){
                        if(type==0){
                            if(res.flag){
                                layer.msg('新增成功！',{icon:1});
                                layer.close(index)
                                tableIns1.reload()
                            }
                        }else if(type==1){
                            if(res.flag){
                                layer.msg('修改成功！',{icon:1});
                                layer.close(index)
                                tableIns1.reload()
                            }
                        }

                    }
                })
            }
        })
    }
    //删除附件
    $(document).on('click', '.deImgs',function(){
        var _this = this;
        var attUrl = $(this).parents('.dech').attr('deUrl');
        layer.confirm('确定删除该条数据吗？', function(index){
            $.ajax({
                type: 'get',
                url: '/delete?'+attUrl,
                dataType: 'json',
                success:function(res){

                    if(res.flag == true){
                        layer.msg('删除成功', { icon:6});
                        $(_this).parent().remove();
                    }else{
                        layer.msg('删除失败', { icon:6});
                    }
                }
            })
        });
    });
    //将毫秒数转为yyyy-MM-dd格式时间
    function format(t) {
        if(t) return new Date(t).Format("yyyy-MM-dd");
        else return ''
    }
</script>
</body>
</html>
