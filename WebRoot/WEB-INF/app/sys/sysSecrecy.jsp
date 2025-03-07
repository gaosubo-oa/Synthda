<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2023/3/23
  Time: 10:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>系统安全保密员</title>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <script type="text/javascript"  src="/js/common/language.js"></script>
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript"  src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript"  src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=20230404" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js?20230216.2"></script>
    <style>
        html,body {
            width: 100%;
        }
        .header {
            height: 45px;
            background-color: #fff;
            padding: 10px;
            box-sizing: border-box;
            font-size: 16px;
        }
        .header .nav {
            height: 100%;
            display: flex;
            align-items: center;
        }
        .nav li {
            height: 28px;
        }
        .nav li .pad {
            padding: 7px;
        }
        .pad.select {
            background-color: #2F8AE3;
            color: #fff;
            border-radius: 8px;
        }
        .pad.journal {
            border-radius: 8px;
        }
        .pad.setting {
            border-radius: 8px;
        }
        .space{
            width:2px;
        }
        h1{
            line-height: 45px;
            font-size: 22px;
        }
        .seePas:hover {
            color: #2F8AE3;
        }
        .seePas {
            cursor: pointer;
        }
        .saveBtn{
            width: 70px;
            height: 28px;
            margin: 0 auto;
            line-height: 28px;
            text-align: center;
            border-radius: 4px;
            cursor: pointer;
            background: url("../../img/confirm.png") no-repeat;
        }
        .content {
            padding: 0 10px;
            box-sizing: border-box;
        }
        /*.operation {*/
        /*    display: none;*/
        /*}*/
        /*.unloading {*/
        /*    display: none;*/
        /*}*/
        /*.lookFile {*/
        /*    display: none;*/
        /*}*/
    </style>
</head>
<body>
<div class="header">
    <ul class="nav">
        <li id="approve">
            <span class="pad select" class="one">待审批用户</span>
            <img class="space" src="../../img/twoth.png" alt="">
        </li>
        <li id="deptSec">
            <span class="pad" class="one">待审批部门</span>
            <img class="space" src="../../img/twoth.png" alt="">
        </li>
        <li id="overUser">
            <span class="pad" class="one">已审批用户</span>
            <img class="space" src="../../img/twoth.png" alt="">
        </li>
        <li id="overDept">
            <span class="pad" class="one">已审批部门</span>
            <img class="space" src="../../img/twoth.png" alt="">
        </li>

        <li>
            <span class="pad" class="one">删除用户</span>
            <img class="space" src="../../img/twoth.png" alt="">
        </li>

        <li>
            <span class="pad" class="one">删除部门</span>
            <img class="space" src="../../img/twoth.png" alt="">
        </li>

        <li style="margin-left: 4px" id="journal">
            <span class="pad journal">审计日志</span>
            <img class="space" src="../../img/twoth.png" alt="">
        </li>
<%--        <li style="margin-left: 4px">--%>
<%--            <span class="pad journal">重置密码</span>--%>
<%--            <img class="space" src="../../img/twoth.png" alt="">--%>
<%--        </li>--%>
        <li style="margin-left: 4px" id="setting">
            <span class="pad setting">审计日志设置</span>
            <img class="space" src="../../img/twoth.png" alt="">
        </li>
    </ul>
</div>
<hr style="margin-top: 0">
<div class="box content0" style="display: block;">
    <h1 style="height: 80px;line-height: 80px;">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/faceSetting.png" style="margin-top: 29px;float: left;margin-left: 30px;margin-right: 7px;">
        待审批用户
    </h1>
    <div class="content">
        <table id="demo" lay-filter="test"></table>
    </div>
</div>

<div class="box content1" style="display: none;">
    <h1 style="height: 80px;line-height: 80px;">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/faceSetting.png" style="margin-top: 29px;float: left;margin-left: 30px;margin-right: 7px;">
        待审批部门
    </h1>
    <div class="content">
        <table id="demo3" lay-filter="test3"></table>
    </div>
</div>

<div class="box content2" style="display: none;">
    <h1 style="height: 80px;line-height: 80px;">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/faceSetting.png" style="margin-top: 29px;float: left;margin-left: 30px;margin-right: 7px;">
        已审批用户
    </h1>
    <div class="content">
        <table id="demo5" lay-filter="test5"></table>
    </div>
</div>

<div class="box content3" style="display: none;">
    <h1 style="height: 80px;line-height: 80px;">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/faceSetting.png" style="margin-top: 29px;float: left;margin-left: 30px;margin-right: 7px;">
        已审批部门
    </h1>
    <div class="content">
        <table id="demo6" lay-filter="test6"></table>
    </div>
</div>

<div class="box content4" style="display: none;">
    <h1 style="height: 50px;line-height: 50px;">
        <img src="/img/commonTheme/theme1/auditLog.png" style="width: 25px;margin-top: 12px;float: left;margin-left: 30px;margin-right: 7px;">
        删除用户
    </h1>
    <div class="content">
        <iframe src="/securityApproval/sysSecrecyUser" frameborder="0" style="width: 100%;height: 100%;"></iframe>
    </div>
</div>

<div class="box content5" style="display: none;">
    <h1 style="height: 50px;line-height: 50px;">
        <img src="/img/commonTheme/theme1/auditLog.png" style="width: 25px;margin-top: 12px;float: left;margin-left: 30px;margin-right: 7px;">
        删除部门
    </h1>
    <div class="content">
        <iframe src="/securityApproval/sysSecrecyDept" frameborder="0" style="width: 100%;height: 100%;"></iframe>
    </div>
</div>


<div class="box content6" style="display: none;">
    <h1 style="height: 80px;line-height: 80px;">
        <img src="/img/commonTheme/theme1/auditLog.png" style="width: 25px;margin-top: 29px;float: left;margin-left: 30px;margin-right: 7px;">
        安全审计日志表
    </h1>
    <div class="content">
        <div class="layui-form-item">

            <div class="layui-inline">
                <label class="layui-form-label">用户:</label>
                <div class="layui-input-inline" style="width: 212px;">
                    <input type="text" id="userId" name="userId" utocomplete="off" class="layui-input" style="width: 150px;display: inline-block;">
                    <a href="javascript:;" class="addControls" style="margin-left:5px;" data-type="user">添加</a>
                    <a href="javascript:;" class="cleardate">清空</a>

                </div>
            </div>

            <div class="layui-inline">
                <label class="layui-form-label">操作类型:</label>
                <div class="layui-input-inline" style="width: 150px;">
                    <select name="type" lay-verify="" style="width: 150px;height: 38px; border: 1px solid #ccc;">
                        <option value="">请选择</option>
                    </select>
                </div>
            </div>

            <div class="layui-inline">
                <label class="layui-form-label">日期范围</label>
                <div class="layui-input-inline" style="width: 150px;">
                    <input type="text" id="beginTime" name="beginTime" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid">-</div>
                <div class="layui-input-inline" style="width: 150px;">
                    <input type="text" id="endTime" name="endTime"  autocomplete="off" class="layui-input">
                </div>
        </div>
            <button class="layui-btn searchBtn">查询</button>
            <button class="layui-btn exportBtn">导出</button>
        <table id="demo1" lay-filter="test"></table>
    </div>
</div>
</div>
<%--<div class="box content7" style="display: none;">--%>
<%--    <h1 style="height: 80px;line-height: 80px;">--%>
<%--        <img src="/img/commonTheme/theme1/auditLog.png" style="width: 25px;margin-top: 29px;float: left;margin-left: 30px;margin-right: 7px;">--%>
<%--        重置密码--%>
<%--    </h1>--%>
<%--    <div class="content">--%>
<%--        <div class="respas" style="width: 800px;margin: 30px auto;text-align: center;">--%>
<%--            <div class="layui-form-item">--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label" style="width: 180px;">重置系统安全审计员密码：</label>--%>
<%--                    <div class="layui-input-inline" style="width: 400px;">--%>
<%--                        <input type="password" name="resPas" autocomplete="off" class="layui-input setPas" style="display: inline-block;width: 335px;">--%>
<%--                        <span style="font-size: 12px;" class="seePas">查看密码</span>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <div class="layui-form-item">--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label" style="width: 180px;">上传附件：</label>--%>
<%--                    <div class="layui-input-inline" style="width: 400px;">--%>
<%--                        <form method="post" action="/upload?module=sys">       <div class="layui-form-item" style="text-align: left;">--%>
<%--                            <input type="file" multiple="multiple" name="file"  id="fileInp" style="border:none; display:inline-block; cursor:pointer;width: 70px;">--%>
<%--                                                    </div>--%>
<%--                                                    </form>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="layui-form-item">--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label" style="width: 180px;">附件信息：</label>--%>
<%--                    <div class="layui-input-inline" style="width: 400px;">--%>
<%--                        <table style="margin: 0;border: none;"><tr class="Attachment" style="border:none;">--%>
<%--                            <td style="border:none;" width="75%"   class="files" id="files_txt">--%>
<%--                                <div id="fileContent"></div>--%>
<%--                            </td>--%>
<%--                        </tr></table>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="layui-form-item">--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label" style="width: 180px;">变更原因：</label>--%>
<%--                    <div class="layui-input-inline" style="width: 400px;">--%>
<%--                        <textarea name="reason" required lay-verify="required" placeholder="请输入" class="layui-textarea"></textarea>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <button class="layui-btn savePasBtn">确定</button>--%>
<%--        </div>--%>

<%--    </div>--%>
<%--</div>--%>
<div class="box content7" style="display: none;">
    <h1 style="height: 80px;line-height: 80px;">
        <img src="/img/commonTheme/theme1/setting.png" style="width: 25px;margin-top: 29px;float: left;margin-left: 30px;margin-right: 7px;">
        审计日志设置
    </h1>
    <div class="content">
        <table style="width: 99%;margin: 0 auto;">
            <thead>
            <tr style="height: 45px;line-height: 45px;background: rgb(242,242,242)">
                <th>选项</th>
                <th>参数</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td style="text-align: center;">日志已占用空间：</td>
                <td style="text-align: center;">

                    <label for="">
                        <input type="text" style="width:200px" name="datalength" >M
                    </label>

                </td>
            </tr>
            <tr>
                <td style="text-align: center;">空间预警阈值：</td>
                <td style="text-align: center;">

                    <label for="">
                        <input max="100" min="0" type="number" value="0" style="width:200px" name="thresholdPercentage" >%
                    </label>

                </td>
            </tr>
            <tr>
                <td style="text-align: center;">日志保存时限：</td>
                <td style="text-align: center;">

                    <label for="">
                        <input type="text" style="width:200px" name="retentionTime" >月
                    </label>

                </td>
            </tr>
            <tr class="showApp">
                <td style="text-align: center;">日志占用空间阈值：</td>
                <td style="text-align: center;">

                    <label for="">
                        <input type="text" style="width:200px" name="spaceThreshold" >M
                    </label>

                </td>
            </tr>
            <tr class="showApp">
                <td style="text-align: center;">日志处理方式：</td>
                <td style="text-align: center;">

                    <label for="">
                        <select style="width:200px;margin-left: -1.7%;" name="processMode" id="processMode">
                            <option value="">请选择</option>
                            <option value="1">覆盖</option>
                            <option value="2">备份清空</option>
                        </select>
                    </label>

                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="saveBtn"><span style="margin-left: 20px;">确定</span></div>
                </td>
            </tr>
            </tbody>

        </table>
    </div>
</div>



<script>
    fileuploadFn('#fileInp',$('.Attachment td').eq(0));
    var dept_id = "";
    var user_id = "";
    var moduleId = 12;
   // 使用全局的layui
   layui.use(['table','layer','form','laydate'],function() {
       var table = layui.table;
       var layer = layui.layer;
       var form = layui.form;
       var laydate = layui.laydate;
       //查询按钮点击事件
       $('.searchBtn').on("click",function() {
           auditLog({
               type:$('[name=type]').val() || "",
               userId: $('#userId').attr("user_id") || "",
               beginTime:$('#beginTime').val() || "",
               endTime:$('#endTime').val() || "",
               useFlag: true
           })
       })
       //导出按钮点击事件
       $(".exportBtn").on("click",function() {
           var type= $('[name=type]').val() || "";
           var userId = $('#userId').attr("user_id") || "";
           var beginTime = $('#beginTime').val() || "";
           var endTime = $('#endTime').val() || "";
           window.location.href = '/securityLog/querySecurityLog?type='+type+'&userId='+userId+'&beginTime='+beginTime+'&endTime='+endTime+'&export=1'+'&useFlag=false';
       })
       $('.addControls').click(function () {
           moduleId = 12;
           user_id = $(this).siblings('input').prop('id');
           $.ajax({
               url:'/imfriends/getIsFriends',
               type:'get',
               dataType:'json',
               success:function(obj){
                   if(obj.object == 1){
                       $.popWindow("/common/selectUserIMAddGroup?0");
                   }else{
                       $.popWindow("/common/selectUser?0");
                   }
               },
               error:function(res){
                   $.popWindow("/common/selectUser?0");
               }
           })
       })
       $(document).on('click','.cleardate',function () {
           $(this).siblings('input').val('');
           $(this).siblings('input').attr('user_id','');
           $(this).siblings('input').attr('dataid','');
           $(this).siblings('input').attr('username','');

           $(this).siblings('input').attr('deptid','');
           $(this).siblings('input').attr('deptname','');

           $(this).siblings('input').attr('privid','');
           $(this).siblings('input').attr('userpriv','');
           $(this).siblings('input').attr('userprivname','');
       })


       function renderLogType() {
         $.ajax({
             url:"/sys/getLogType",
             success:function(res) {
                 var data = res.obj;
                 var result = data.map(function(it) {
                     return '<option value="'+it.codeNo+'">'+it.codeName+'</option>'
                 }).join("")
                 $('[name=type]').append(result)
                 form.render("select");
             }
         })
     }
       laydate.render({
           elem:"#beginTime",
           type:"date",
           trigger:"click"
       })
       laydate.render({
           elem:"#endTime",
           type:"date",
           trigger:"click"
       })
       var secrecyArr = [];
       //获取密级信息
       $.ajax({
           url: "/code/getCode?parentNo=USER_SECRECY",
           async: false,
           success: function (res) {
               secrecyArr = res.obj;
           }
       })
       //附件删除
       $('#files_txt').on('click','.deImgs',function(){
           var data=$(this).parents('.dech').attr('deUrl');
           var dome=$(this).parents('.dech');
           deleteChatment(data,dome);
       })
       //把密集信息转换
       function rendSecrecy(info) {
           var result = secrecyArr.filter(function (it) {
               return it.codeNo == info;
           })
           if(result.length  == 0) {
               return ""
           }
           return result[0].codeName
       }
       //转换管理范围
       function renderManage(data) {
           if(data == 0) {
               return "本部门"
           }else if(data == 1) {
               return "全体"
           }else if(data == 2) {
               return "指定部门"
           }else {
               return ""
           }
       }
       //转换管理范围
       function renderOperationType(data) {
           if(data == 0) {
               return "新建"
           }else if(data == 1) {
               return "变更"
           }else if(data == 2) {
               return "删除"
           }else {
               return ""
           }
       }

       $(function(){
           $.ajax({
               type:'post',
               url:'/securityLog/querySecadmSetPara',
               dataType:'json',
               success:function(res){
                   var data = res.data;
                   var obj=JSON.parse(res.object)
                   $('[name=datalength]').val(data.datalength);
                   $('input[name="retentionTime"]').val(obj.retentionTime);
                   $('input[name="spaceThreshold"]').val(obj.spaceThreshold);
                   $('input[name="thresholdPercentage"]').val(obj.thresholdPercentage);
                   $('select[name="processMode"]').val(obj.processMode);
               }
           })
           //点击确定
           $('.saveBtn').click(function () {

               $.ajax({
                   type:'post',
                   url:'/securityLog/editSecadmSetPara',
                   // dataType:'json',
                   data:{
                       retentionTime:$('input[name="retentionTime"]').val(),
                       spaceThreshold:$('input[name="spaceThreshold"]').val(),
                       processMode:$('#processMode').val(),
                       thresholdPercentage:$('[name=thresholdPercentage]').val(),
                   },
                   success:function (res) {
                       if(res.flag){
                           layer.msg('保存成功!', {icon: 1});
                       }else {
                           layer.msg('保存失败！', {icon: 2});
                       }
                   }
               })
           })
       })

       $('.nav').on("click","li",function() {
           const index = $(this).index();
           $('.box').hide();
           $('.content'+index).show();
           if(index == 6) {
               renderLogType()
           }
       })
       //点击查看密码
       $('.seePas').on("click",function() {
           const type = $('.setPas').attr("type")
           if(type=="password") {
               $('.setPas').attr("type","text");
               $(this).text("隐藏密码")
           }else {
               $('.setPas').attr("type","password");
               $(this).text("查看密码")
           }
       })
       //确定修改密码
       $(".savePasBtn").on("click",function() {
           layer.confirm("确定要修改密码吗?",{icon:0,title:"提示"},function(index) {
               var attachmentId = [];
               var attachmentName = [];
               var doms = $('.inHidden');
              if(doms.length > 0) {
                  for(var i = 0; i < doms.length; i++) {
                      attachmentId.push($(doms[i]).val().rePlaceAll(",",""))
                      attachmentName.push($(doms[i]).parents(".dech").attr("name1"))
                  }
              }
               var reason = $('[name=reason]').val();
               if(attachmentId.length == 0 || attachmentName.length == 0) {
                   layer.msg("请选择附件",{icon:2})
                   return
               }
               if(!reason) {
                   layer.msg("请填写原因",{icon:2})
                   return
               }
               const val = $(".setPas").val().replaceAll(" ","");
               if(!val) {
                   layer.close(index);
                   layer.msg("密码不能为空",{icon:2})
                   return
               }
               $.ajax({
                   url:"/securityApproval/updateApproveUserPass",
                   data: {
                       approveUser:"AUDIT",
                       password:val,
                       attachmentId:attachmentId.join(","),
                       attachmentName:attachmentName.join(","),
                       reason:reason,
                   },
                   success:function(res) {
                       if(res.flag) {
                           layer.msg("修改成功",{icon:1},function() {
                               $('[name=pasVal]').val("");
                               $("#files_txt .dech").remove();
                               $('[name=reason]').val("");
                               layer.clsoe(index)
                           })
                       }else {
                           layer.msg(res.msg,{icon:2},function() {
                               layer.clsoe(index)
                           })
                       }
                   }
               })
           })
       })
       gradeApproval();
       $(".pad").on("click",function() {
           $('.pad').removeClass("select")
           $(this).addClass("select");
       })
       //定级审批点击事件
       $('#approve').click(function(){
           gradeApproval();
       });
       //审计日志点击事件
       $('#journal').click(function(){
           auditLog({
                   useFlag: true
           });
       });
       //限制
       $("[name=thresholdPercentage]").on("input",function() {
           var val = $(this).val();
           if(val > 100) {
               $(this).val(100)
           }
           if(val < 0) {
               $(this).val(0)
           }
       })
       //部门审批
       $('#deptSec').click(function(){
           renderDeptList();
       });
       // 渲染已审批用户
       $('#overUser').click(function(){
           renderOverUserList();
       });
       // 渲染已审批部门
       $('#overDept').click(function(){
           renderOverDeptList();
       });
       //渲染已审批的用户列表
       function renderOverUserList() {
           const tableInfo = table.render({
               elem: '#demo5',
               url: '/securityApproval/queryApproveUser', //数据接口
               page: true, //开启分页
               request:{
                   pageName: 'page' //页码的参数名称，默认：page
                   ,limitName: 'pageSize' //每页数据量的参数名，默认：limit
               },
               where: {
                   useFlag:true
               },
               parseData: function (res) {
                   if(!res.flag && res.msg) {
                       layer.msg(res.msg,{icon:2})
                   }
                   return {
                       code: 0,
                       msg: res.msg,
                       data: res.obj,
                        count:res.totleNum
                   }
               },
               cols: [[ //表头
                   {
                       field: 'userId', title: '用户ID', templet: function (d) {
                           return d.users.userId || ""
                       }
                   }
                   , {
                       field: 'byname', title: '用户名', templet: function (d) {
                           return d.users.byname || ""
                       }
                   }
                   , {
                       field: 'userName', title: '真实姓名', templet: function (d) {
                           return d.users.userName || ""
                       }
                   }
                   , {
                       field: 'deptName', title: '部门', templet: function (d) {
                           return d.users.deptName || ""
                       }
                   }
                   , {
                       field: 'userPrivName', title: '角色', templet: function (d) {
                           return d.users.userPrivName || ""
                       }
                   }
                   , {
                       field: 'userSecrecy', title: '密级', templet: function (d) {
                           return rendSecrecy(d.users.userSecrecy) || ""
                       }
                   }
                   , {
                       field: 'postPriv', title: '管理范围', templet: function (d) {
                           return renderManage(d.users.postPriv)
                       }
                   }
                   , {
                       field: 'operationType', title: '审批类型', templet: function (d) {
                           return renderOperationType(d.operationType)
                       }
                   }
                   , {
                       field: 'operationReason', title: '变更理由', templet: function (d) {
                           return d.operationReason || ""
                       }
                   }
                   , {field: 'attachmentName', title: '附件',templet:function(d) {
                           //返回附件列表
                           if(!d.attachmentList) {
                               return ""
                           }
                           return showFiles(d.attachmentList)
                       }}
                   , {
                       field: 'approvalStatus', title: '审批状态', templet: function (d) {
                           if(d.approvalStatus == 0) {
                               return "待审批"
                           }else if(d.approvalStatus == 1) {
                               return "通过"
                           }else if(d.approvalStatus == 2) {
                               return "拒绝"
                           }
                       }
                   }
                   , {
                       field: 'operationTime', title: '时间', templet: function (d) {
                           return new Date(d.operationTime).Format('yyyy-MM-dd hh:mm:ss') || ""
                       }
                   }
                   , {
                       field: 'attachmentName', title: '操作', width: 150, templet: function () {
                           return '<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="detail">查看</button>'
                       }
                   }
               ]]
           });
           table.on('tool(test5)', function (obj) {
               var event = obj.event;
               var data = obj.data;
                if (event == "detail") {
                   window.open('/securityApproval/sysLookUser?' + data.recordId)
               }
           })
       }
       //渲染已审批的部门
       function renderOverDeptList() {
           //第一个实例
           const tableInfo = table.render({
               elem: '#demo6',
               url: '/securityApproval/queryApproveDept', //数据接口
               page: true, //开启分页
               request:{
                   pageName: 'page' //页码的参数名称，默认：page
                   ,limitName: 'pageSize' //每页数据量的参数名，默认：limit
               },
               where: {
                   useFlag:true
               },
               parseData: function (res) {
                   if(!res.flag && res.msg) {
                       layer.msg(res.msg,{icon:2})
                   }
                   return {
                       code: 0,
                       msg: res.msg,
                       data: res.obj,
                       count:res.totleNum
                   }
               },
               cols: [[ //表头
                   {
                       field: 'deptId', title: '部门ID', templet: function (d) {
                           return d.users.deptId || ""
                       }
                   },
                   {
                       field: 'deptName', title: '部门名称', templet: function (d) {
                           return d.users.deptName || ""
                       }
                   },
                   {
                       field: 'deptName', title: '部门负责人', templet: function (d) {
                           return d.department.managerStr || ""
                       }
                   },
                   {
                       field: 'deptName', title: '部门审核人', templet: function (d) {
                           return d.department.deptApproverName || ""
                       }
                   },
                   {
                       field: 'deptName', title: '审批类型', templet: function (d) {
                           return renderOperationType(d.operationType)
                       }
                   },
                   {
                       field: 'deptName', title: '变更理由', templet: function (d) {
                           return d.operationReason || ""
                       }
                   },
                   {
                       field: 'deptName', title: '附件',templet: function (d) {
                           if(!d.attachmentList) {
                               return ""
                           }
                           return showFiles(d.attachmentList)
                       }
                   },
                   {
                       field: 'approvalStatus', title: '审批状态', templet: function (d) {
                           if(d.approvalStatus == 0) {
                               return "待审批"
                           }else if(d.approvalStatus == 1) {
                               return "通过"
                           }else if(d.approvalStatus == 2) {
                               return "拒绝"
                           }
                       }
                   },
                   {
                       field: 'operationTime', title: '时间', templet: function (d) {
                           return new Date(d.operationTime).Format('yyyy-MM-dd hh:mm:ss') || ""
                       }
                   },
                   {
                       field: 'attachmentName', title: '操作', width: 150, templet: function () {
                           return '<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="detail">查看</button>'
                       }
                   }
               ]]
           });
           table.on("tool(test6)",function(obj) {
               var data = obj.data;
               var event = obj.event;
               if(event === "detail") {
                   window.open('/securityApproval/sysLookDept?deptid='+data.department.deptId)
               }
           })
       }
       //回显附件
       function showFiles(fileArr) {
           let str = "";
           for(var i = 0; i < fileArr.length; i++) {
               var attachObj = fileArr[i];
               str += '<div id="'+ attachObj.attachId +'"><label class="seeFild"><img  src="/img/attachment_icon.png"/></label><label class="attchInfo" attachId="'+ attachObj.attachId +'">'+ attachObj.attachName +'</label><a href="/download?'+ attachObj.attUrl +'" type="button" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a></div>'
           }
           return str
       }
       function lookFile(repalogId){//查看附件
           if (repalogId == undefined || repalogId == "") {
               layer.msg("文件已被损坏，无法查看");
           } else {
               selectFile(repalogId,'fcrm');
           }
       }
       function downFile(repalogId){//下载附件
           if (repalogId == undefined || repalogId == "") {
               layer.msg("文件已被损坏，无法下载");
           } else {
               //var fcrmRepair ="fcrmRepair"
               window.location.href = "/fcrm/limsDownload?model=fcrm&attachId=" +repalogId
           }
       }
       function gradeApproval() {
           layui.use(['table', 'layer', 'form'], function () {
               var table = layui.table;
               var layer = layui.layer;
               var form = layui.form;

               //第一个实例
               const tableInfo = table.render({
                   elem: '#demo',
                   url: '/securityApproval/queryApproveUser?approvalStatus=0', //数据接口
                   page: true, //开启分页
                   request:{
                       pageName: 'page' //页码的参数名称，默认：page
                       ,limitName: 'pageSize' //每页数据量的参数名，默认：limit
                   },
                   where: {
                     useFlag:true
                   },
                   parseData: function (res) {
                       if(!res.flag && res.msg) {
                           layer.msg(res.msg,{icon:2})
                       }
                       return {
                           code: 0,
                           msg: res.msg,
                           data: res.obj,
                           count:res.totleNum
                       }
                   },
                   cols: [[ //表头
                       {
                           field: 'userId', title: '用户ID', templet: function (d) {
                               return d.users.userId || ""
                           }
                       }
                       , {
                           field: 'byname', title: '用户名', templet: function (d) {
                               return d.users.byname || ""
                           }
                       }
                       , {
                           field: 'userName', title: '真实姓名', templet: function (d) {
                               return d.users.userName || ""
                           }
                       }
                       , {
                           field: 'deptName', title: '部门', templet: function (d) {
                               return d.users.deptName || ""
                           }
                       }
                       , {
                           field: 'userPrivName', title: '角色', templet: function (d) {
                               return d.users.userPrivName || ""
                           }
                       }
                       , {
                           field: 'userSecrecy', title: '密级', templet: function (d) {
                               return rendSecrecy(d.users.userSecrecy) || ""
                           }
                       }
                       , {
                           field: 'postPriv', title: '管理范围', templet: function (d) {
                               return renderManage(d.users.postPriv)
                           }
                       }
                       , {
                           field: 'operationType', title: '审批类型', templet: function (d) {
                               return renderOperationType(d.operationType)
                           }
                       }
                       , {
                           field: 'operationReason', title: '变更理由', templet: function (d) {
                               return d.operationReason || ""
                           }
                       }
                       , {field: 'attachmentName', title: '附件',templet:function(d) {
                           //返回附件列表
                               if(!d.attachmentList) {
                                   return ""
                               }
                               return showFiles(d.attachmentList)
                           }}
                       , {
                           field: 'operationTime', title: '时间', templet: function (d) {
                               return new Date(d.operationTime).Format('yyyy-MM-dd hh:mm:ss') || ""
                           }
                       }
                       , {
                           field: 'attachmentName', title: '操作', width: 150, templet: function () {
                               return '<button class="layui-btn layui-btn-sm" lay-event="approve">审批</button> <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="detail">查看</button>'
                           }
                       }
                   ]]
               });
               table.on('tool(test)', function (obj) {
                   var event = obj.event;
                   var data = obj.data;
                   if (event == "approve") {
                       layer.open({
                           type: 1,
                           offset:['100px','300px'],
                           area: ['600px', '400px'],
                           btn: ['确定', '取消'],
                           content: '<div style="padding: 0 20px;">' +
                               '    <div class="layui-form-item" style="margin-top: 20px;">\n' +
                               '                        <label class="layui-form-label">审批状态</label>\n' +
                               '                        <div class="layui-input-block" style="line-height: 36px;">\n' +
                               '                        <input type="radio" name="approvalStatus" value="1" checked>同意\n' +
                               '                        <input type="radio" name="approvalStatus" value="2">拒绝\n' +
                               '                    </div>\n' +
                               '                    </div>' +
                               '    <div class="layui-form-item">\n' +
                               '                        <label class="layui-form-label">人员密级</label>\n' +
                               '                        <div class="layui-input-block" style="line-height: 36px;">\n' +
                               '<select name="userSecrecy" lay-verify="" style="width: 150px;">\n' +
                               '</select>'+
                               '                    </div>\n' +
                               '                    </div>' +
                               '    <div class="layui-form-item">\n' +
                               '                        <label class="layui-form-label">管理范围</label>\n' +
                               '                        <div class="layui-input-block" style="line-height: 36px;">\n' +
                               '   <select name="postPriv" class="postPriv">\n' +
                               '                            <option value="0">本部门</option>\n' +
                               '                            <option value="1">全体</option>\n' +
                               '                            <option value="2">指定部门</option>\n' +
                               '                        </select>'+
                               '                    </div>\n' +
                               '                    </div>' +
                               '    <div class="layui-form-item deptInfo" style="display: none;">\n' +
                               '                        <label class="layui-form-label">管理范围</label>\n' +
                               '                        <div class="layui-input-block" style="line-height: 36px;">\n' +
                               '  <textarea name="postDept" id="postDept" class="layui-textarea" readonly style="width: 400px;height: 50px; display: inline-block;background: #e7e7e7;"></textarea>\n' +
                               '                        <a href="javascript:;" class="postDeptBtn">添加</a>\n' +
                               '                        <a href="javascript:;" class="clearData">清空</a>'+
                               '                    </div>\n' +
                               '                    </div>' +
                               ' <div class="layui-form-item layui-form-text">\n' +
                               '    <label class="layui-form-label">审批意见</label>\n' +
                               '    <div class="layui-input-block">\n' +
                               '      <textarea name="approvalOpinion" placeholder="请输入意见" class="layui-textarea"></textarea>\n' +
                               '    </div>\n' +
                               '  </div>' +
                               '</div>',
                           success:function() {
                               if(data.operationType == 1) {
                                   $("[name=userSecrecy]").attr("disabled",true);
                                   $("[name=postPriv]").attr("disabled",true);
                                   $(".postDeptBtn").css("pointer-events","none");
                                   $(".clearData").css("pointer-events","none");
                               }
                               $('#postDept').attr("deptid",data.users.postDept).val(data.users.postDeptName);
                               const doms = $(".postPriv option");
                               for(var j = 0; j < doms.length; j++) {
                                   const dom = doms[j];
                                   if(data.users.postPriv == 2) {
                                       $('.deptInfo').show();
                                   }
                                   if($(dom).val() == data.users.postPriv) {
                                       $(dom).attr("selected",true)
                                   }
                               }
                               $.ajax({
                                   url:"/code/getCode?parentNo=USER_SECRECY",
                                   async:false,
                                   success:function(res) {
                                       var obj = res.obj;
                                       var str = "";
                                       for(var i = 0; i < obj.length; i++) {
                                           if(obj[i].codeNo === data.users.userSecrecy) {
                                               str += '<option value="'+obj[i].codeNo+'" selected>'+obj[i].codeName+'</option>'
                                           }else {
                                               str += '<option value="'+obj[i].codeNo+'">'+obj[i].codeName+'</option>'
                                           }
                                       }
                                       $('select[name=userSecrecy]').html(str);
                                   }
                               })
                               $(".postDeptBtn").click(function() {
                                   dept_id="postDept";
                                   $.popWindow("../common/selectDept");
                               })
                               $('.clearData').click(function () {
                                   $(this).siblings('textarea').val('')
                                   $(this).siblings('textarea').attr('userpriv','')
                                   $(this).siblings('textarea').attr('deptid','')
                                   $(this).siblings('textarea').attr('deptname','')
                                   $(this).siblings('input[name="txtsenduser"]').attr('userpriv','');
                                   $(this).siblings('input[name="txtsenduser"]').attr('privid','');
                                   $(this).siblings('input[name="txtsenduser"]').attr('user_id','');
                                   $(this).siblings('input[name="txtsenduser"]').val('');
                               });
                               $(".postPriv").on("change",function() {
                                   const val = $(this).val();
                                   if(val == 2) {
                                       $('.deptInfo').show()
                                   }else {
                                       $('.deptInfo').hide();
                                   }
                               })
                           },
                           btn1: function (index) {
                               var spId = data.spId;
                               var approvalStatus = $('[name=approvalStatus]:checked').val();
                               var approvalOpinion = $('[name=approvalOpinion]').val();
                               $.ajax({
                                   url: "/securityApproval/approveUser",
                                   data: {
                                       spId: spId,
                                       approvalStatus: approvalStatus,
                                       approvalOpinion: approvalOpinion,
                                       operationContent:JSON.stringify({
                                           userSecrecy:$('select[name=userSecrecy]').val(),
                                           postPriv:$('select[name=postPriv]').val(),
                                           postDept:$('#postDept').attr("deptid") || ""
                                       })
                                   },
                                   success: function (res) {
                                       if (res.flag) {
                                           layer.msg("审批完成", {icon: 1}, function () {
                                               layer.close(index)
                                               tableInfo.reload();
                                           })
                                       } else {
                                           layer.msg(res.msg, {icon: 2}, function () {
                                               layer.close(index)
                                           })
                                       }
                                   }
                               })
                           }
                       })
                   } else if (event == "detail") {
                       window.open('/securityApproval/sysLookUser?' + data.recordId)
                   }
               })
           });
       }

       function auditLog(where) {
           where = where?where:{};
           layui.use(['table', 'layer', 'form'], function () {
               var table = layui.table;
               var layer = layui.layer;
               var form = layui.form;

               //第一个实例
               const tableIns = table.render({
                   elem: '#demo1',
                   url: '/securityLog/querySecurityLog', //数据接口
                   page: true, //开启分页
                   parseData: function (res) {
                       return {
                           code: 0,
                           msg: res.msg,
                           data: res.obj,
                           count: res.totleNum,
                       }
                   },
                   where:where,
                   request:{
                       pageName:'page',
                       limitName:'pageSize'
                   },
                   cols: [[ //表头
                       {
                           field: 'logId', title: '日志ID',align:'center'
                       }
                       , {
                           field: 'userId', title: '用户ID',align:'center'
                       }
                       , {
                           field: 'userName', title: '用户姓名',align:'center'
                       }
                       , {
                           field: 'time', title: '时间',align:'center'
                       }
                       , {
                           field: 'ip', title: 'IP地址',align:'center'
                       }
                       , {
                           field: 'typeName', title: '日志类型',align:'center'
                       }
                       , {
                           field: 'remark', title: '备注',align:'center'
                       }
                       , {
                           field: 'remark', title: '附件',align:'center',templet:function(d) {
                               var str = "";
                               if(d.attachmentList && d.attachmentList.length > 0) {
                                   for(var i = 0; i < d.attachmentList.length; i++) {
                                       var item = d.attachmentList[i];
                                       str += '<a style="display: block;" href="/download?'+item.attUrl+'">'+item.attachName+'</a>'
                                   }
                               }
                               return str;
                           }
                       }
                       , {
                           field: 'clientTypeName', title: '设备类型',align:'center'
                       }
                       , {
                           field: 'clientVersion', title: '版本号',align:'center'
                       }
                   ]]
               });
           });
       }
       function renderDeptList() {
           //第一个实例
           const tableInfo = table.render({
               elem: '#demo3',
               url: '/securityApproval/queryApproveDept?approvalStatus=0', //数据接口
               page: true, //开启分页
               request:{
                   pageName: 'page' //页码的参数名称，默认：page
                   ,limitName: 'pageSize' //每页数据量的参数名，默认：limit
               },
               where: {
                   useFlag:true
               },
               parseData: function (res) {
                   if(!res.flag && res.msg) {
                       layer.msg(res.msg,{icon:2})
                   }
                   return {
                       code: 0,
                       msg: res.msg,
                       data: res.obj,
                       count:res.totleNum
                   }
               },
               cols: [[ //表头
                   {
                       field: 'deptId', title: '部门ID', templet: function (d) {
                           return d.users.deptId || ""
                       }
                   },
                   {
                       field: 'deptName', title: '部门名称', templet: function (d) {
                           return d.users.deptName || ""
                       }
                   },
                   {
                       field: 'deptName', title: '部门负责人', templet: function (d) {
                           return d.department.managerStr || ""
                       }
                   },
                   {
                       field: 'deptName', title: '部门审核人', templet: function (d) {
                           return d.department.deptApproverName || ""
                       }
                   },
                   {
                       field: 'deptName', title: '审批类型', templet: function (d) {
                           return renderOperationType(d.operationType)
                       }
                   },
                   {
                       field: 'deptName', title: '变更理由', templet: function (d) {
                           return d.operationReason || ""
                       }
                   },
                   {
                       field: 'deptName', title: '附件',templet: function (d) {
                           if(!d.attachmentList) {
                               return ""
                           }
                           return showFiles(d.attachmentList)
                       }
                   },
                   {
                       field: 'operationTime', title: '时间', templet: function (d) {
                           return new Date(d.operationTime).Format('yyyy-MM-dd hh:mm:ss') || ""
                       }
                   },
                   {
                       field: 'attachmentName', title: '操作', width: 150, templet: function () {
                           return '<button class="layui-btn layui-btn-sm" lay-event="approve">审批</button> <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="detail">查看</button>'
                       }
                   }
               ]]
           });
           table.on("tool(test3)",function(obj) {
               var data = obj.data;
               var event = obj.event;
                if(event === "approve") {
                    layer.open({
                        type: 1,
                        title: "审批",
                        area: ['600px', '400px'],
                        offset:["100px",'300px'],
                        btn: ['确定', '取消'],
                        content:'<div style="padding: 0 20px;">' +
                            '    <div class="layui-form-item" style="margin-top: 20px;">\n' +
                            '                        <label class="layui-form-label">审批状态</label>\n' +
                            '                        <div class="layui-input-block" style="line-height: 36px;">\n' +
                            '                        <input type="radio" name="approvalStatus" value="1" checked>同意\n' +
                            '                        <input type="radio" name="approvalStatus" value="2">拒绝\n' +
                            '                    </div>\n' +
                            '                    </div>' +
                            '    <div class="layui-form-item">\n' +
                            '                        <label class="layui-form-label">部门负责人</label>\n' +
                            '                        <div class="layui-input-block" style="line-height: 36px;">\n' +
                            '                        <input type="text" name="manager" readonly id="manager" style="width: 200px;background: #e7e7e7;">' +
                            '                        <a href="javascript:;" class="addBtn">添加</a>\n' +
                            '                        <a href="javascript:;" class="cleardate">清空</a>'+
                            '                    </div>\n' +
                            '                    </div>' +
                            '    <div class="layui-form-item">\n' +
                            '                        <label class="layui-form-label">部门审核人</label>\n' +
                            '                        <div class="layui-input-block" style="line-height: 36px;">\n' +
                            '                        <input type="text" name="deptApprover" readonly id="deptApprover" style="width: 200px;background: #e7e7e7;">' +
                            '                        <a href="javascript:;" class="addBtn">添加</a>\n' +
                            '                        <a href="javascript:;" class="cleardate">清空</a>'+
                            '                    </div>\n' +
                            '                    </div>' +
                            ' <div class="layui-form-item layui-form-text">\n' +
                            '    <label class="layui-form-label">审批意见</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <textarea name="approvalOpinion" placeholder="请输入意见" class="layui-textarea"></textarea>\n' +
                            '    </div>\n' +
                            '  </div>' +
                            '</div>',
                        success:function() {
                            if(data.operationType == 1) {
                                $(".addBtn").css("pointer-events","none");
                                $(".cleardate").css("pointer-events","none");
                            }
                            //选择人员
                            $('.addBtn').click(function () {
                                moduleId = "";
                                user_id = $(this).siblings('input').prop('id');
                                $.ajax({
                                    url:'/imfriends/getIsFriends',
                                    type:'get',
                                    dataType:'json',
                                    success:function(obj){
                                        if(obj.object == 1){
                                            $.popWindow("/common/selectUserIMAddGroup?0");
                                        }else{
                                            $.popWindow("/common/selectUser?0");
                                        }
                                    },
                                    error:function(res){
                                        $.popWindow("/common/selectUser?0");
                                    }
                                })
                            })
                            //清空按钮
                            $(document).on('click','.cleardate',function () {
                                $(this).siblings('input').val('');
                                $(this).siblings('input').attr('user_id','');
                                $(this).siblings('input').attr('dataid','');
                                $(this).siblings('input').attr('username','');

                                $(this).siblings('input').attr('deptid','');
                                $(this).siblings('input').attr('deptname','');

                                $(this).siblings('input').attr('privid','');
                                $(this).siblings('input').attr('userpriv','');
                                $(this).siblings('input').attr('userprivname','');
                            })
                        //数据回显
                            $("#manager").attr("user_id",data.department.manager).val(data.department.managerStr)
                            $("#deptApprover").attr("user_id",data.department.deptApprover).val(data.department.deptApproverName)
                        },
                        btn1:function(index) {
                            var spId = data.spId;
                            var approvalStatus = $('[name=approvalStatus]:checked').val();
                            var approvalOpinion = $('[name=approvalOpinion]').val();
                            if(approvalStatus == 1) {
                                if(!$('#manager').attr("user_id") || !$('#deptApprover').attr("user_id")) {
                                    layer.msg("部门负责人和部门审核人必须选择")
                                    return
                                }
                                if($('#manager').attr("user_id") == $('#deptApprover').attr("user_id")) {
                                    layer.msg("部门负责人和部门审核人不能是同一个人")
                                    return
                                }
                            }
                            $.ajax({
                                url: "/securityApproval/approveUser",
                                data: {
                                    spId: spId,
                                    approvalStatus: approvalStatus,
                                    approvalOpinion: approvalOpinion,
                                    operationContent:JSON.stringify({
                                        manager:$('#manager').attr("user_id") || "",
                                        deptApprover:$('#deptApprover').attr("user_id") || "",
                                    })
                                },
                                success: function (res) {
                                    if (res.flag) {
                                        layer.msg("审批完成", {icon: 1}, function () {
                                            layer.close(index)
                                            tableInfo.reload();
                                        })
                                    } else {
                                        layer.msg(res.msg, {icon: 2}, function () {
                                            layer.close(index)
                                        })
                                    }
                                }
                            })
                        }
                    })
                }else  if(event === "detail") {
                    window.open('/securityApproval/sysLookDept?deptid='+data.department.deptId)
                }
           })
       }
   })
</script>
</body>
</html>
