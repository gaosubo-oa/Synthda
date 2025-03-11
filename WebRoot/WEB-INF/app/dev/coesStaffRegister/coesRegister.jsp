
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>人员登记管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
<%--    <meta name="viewport"--%>
<%--          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">--%>

    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script src="/ui/js/qrcode.min.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.config.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>

</head>
<style>
    /*.layui-form .divbox{*/
    /*    float: left;*/
    /*}*/

    #box .layui-from {
        width: 100%;
    }
    .layui-table-page>div{
        float: right;
    }
    #box .layui-table {
        width: 90%;
        margin: 0 auto;
    }

    .asd {
        font-weight: bold;
        font-size: 18px;
        margin-left: 30px;
    }

    .evaluation span {
        font-weight: bold;
        font-size: 18px;
        margin-left: 55px;
    }

    /*#box th {*/
    /*    text-align: center;*/
    /*}*/

    /*#box tr {*/
    /*    height: 40px;*/
    /*}*/

    #box button {
        right: -14px;
        z-index: 999;
        top:77px
    }
    #btn{
        margin-right: 35px;
        position: absolute;
        right: 30px;
        z-index: 999;
        top:77px
    }
    #from {
        width: 100%;
        margin: 0 auto;
        padding-top: 20px;
    }

    #from .new {
        font-weight: bold;
        font-size: 18px;
        margin-left: 30px;
    }

    .people {
        width: 100%;
        overflow: hidden;
        margin-bottom: 15px;
    }

    .people1 {
        width: 44%;
        float: left;
        overflow: hidden;
    }

    .people2 {
        float: right;
        overflow: hidden;
        margin-right: 61px;
    }

    .tbtn {
        text-align: center;
    }

    .tbtn button {
        margin-bottom: 20px;
        width: 100px;
    }

    .annex {
        font-size: 14px;
        margin-left: 30px;
    }
    .layui-form-select{
        width: 200px!important;
        height: 35px!important;
    }
    @media print {.notprint{display: none;}}
    #test3 {
        margin-left: 68px;
    }

    .layui-form-label {
        width: 100px;
    }

    .layui-table-view .layui-form-checkbox[lay-skin=primary] i {
        margin-top: 5px;
    }

    .layui-form {
        margin-left: 10px;
        /*margin-top: 10px;*/
        display: block;
        margin-right: 10px;
    }

    .layui-table-cell laytable-cell-1-0-5 {
        width: 268px;
    }

    /*.layui-table-page{*/
    /*    width: 1054px;*/
    /*}*/
    .layui-laypage-btn{
        display: none;
    }
    .layui-box layui-laypage layui-laypage-default{
        margin-left: 1060px;
    }
    .thHeight1 td {
        height: 80px;
    }

    .thHeight2 td {
        height: 120px;
        letter-spacing: 7px;
    }

    .layui-form input[type=checkbox], .layui-form input[type=radio], .layui-form select {
    }

    .layui-form select {

    }

    .evaluation {
        width: 800px;
        padding-top: 10px;
    }

    tr {
        text-align: center;
    }

    td {
        text-align: center;
    }

    #asd {
        width: 10px;
    }

    .layui-table td, .layui-table th {
        padding: 10px 9px;
    }

    .layui-form-checkbox {
        display: none;
    }

    .layui-table-view .layui-table td, .layui-table-view .layui-table th {
        text-align: center;
    }

    .layui-table-tool {
        display: none;
    }
    .layui-input{
        width: 200px;
    }
    .box1 {
        overflow: hidden;
        margin-left: 55px;
        margin-bottom: 50px;
    }

    .top1 {
        width: 199px;
        height: 39px;
        background-color: rgb(204 204 204);
        display: block;
        font-weight: bold;
        font-size: 18px;
        float: left;
        text-align: center;
        line-height: 39px;
        border: 1px solid rgba(121, 121, 121, 1);
    }

    .top2 {
        width: 228px;
        height: 39px;
        background-color: rgba(121, 121, 121, 1);
        display: block;
        font-weight: bold;
        font-size: 18px;
        float: left;
        text-align: center;
        line-height: 39px;
    }

    #meeting {
        width: 84px;
    }

    #textarea {
        width: 73%;
        height: 100px;
    }

    #party {
        float: right;
        position: absolute;
        left: 1000px;
        top: 75px;
    }

    #year {
        float: right;
        position: absolute;
        left: 1320px;
        top: 75px;
    }
    /*.layui-tab-content{*/
    /*    margin-top: 20px;*/
    /*}*/
    .laytable-cell-1-0-6{
        maxWidth: 220px;

    }
    .niuma{
        width: 1000px;
        position: relative;
    }
    .setInfo {
        text-align: left;
        padding-left: 100px !important;
        color: #000;
        font-weight: bold;
    }
    .layui-form-label {
        text-align: left;
    }
    td {
        margin: 1px;
    }
    .item {
        white-space: nowrap;
    }
</style>
<body>
<div class="layui-tab">
    <ul class="layui-tab-title">
        <li class="layui-this">人员登记管理</li>
        <li>人员登记表</li>
    </ul>
    <div class="layui-tab-content">
        <div class="layui-tab-item layui-show">

            <div>
                <div style="
    height: 20px;
    line-height: 10px;
    font-size: 22px;
    color: #494d59;">
                    <img src="/ui/img/zkim/category.png">
                    人员登记管理</div>
                 <form class="layui-form" action="">
                                    <div style="position: relative;line-height: 60px;">
                                        <div class="item">
                                            <div class="layui-inline divbox">
                                                <label class="layui-form-label" style="width: 80px !important; margin-left: -15px;">姓名</label>
                                                <div class="layui-input-inline">
                                                    <input  style="width: 200px" id="cName" name="cName" class="layui-input" type="text">
                                                </div>
                                            </div>

                                            <div class="layui-inline divbox">
                                                <label class="layui-form-label" style="width: 80px;">手机号</label>
                                                <div class="layui-input-inline">
                                                    <input  style="width: 200px" id="mobbleNo" maxlength="11" name="mobbleNo" class="layui-input" type="text">
                                                </div>
                                            </div>
                                            <div class="layui-inline divbox">
                                                <label class="layui-form-label" style="width: 80px;">身份证号码</label>
                                                <div class="layui-input-inline">
                                                    <input  style="width: 200px"  id="idCard" maxlength="18" name="idCard" class="layui-input" type="text">
                                                </div>
                                            </div>
                                           <div class="layui-inline divbox">
                                               <div class="layui-inline">
                                                   <label class="layui-form-label" style="width: 30px;">状态</label>
                                               </div>
                                              <div class="layui-inline">
                                                  <select name="state" lay-verify="" style="width: 200px;">
                                                      <option value="">请选择</option>
                                                      <option value="1">在船</option>
                                                      <option value="2">离船</option>
                                                  </select>
                                              </div>

                                           </div>
                                        </div>
                                   <div class="item">
                                       <div class="layui-inline divbox" style="margin-top: -14px;">
                                           <label class="layui-form-label" style="width: 80px; margin-left: -15px;">开始时间</label>
                                           <div class="layui-input-inline">
                                               <input  style="width: 200px"  id="boardScanTime" name="boardScanTime" class="layui-input" type="text">
                                           </div>
                                       </div>
                                       <div class="layui-inline divbox" style="margin-top: -14px;">
                                           <label class="layui-form-label" style="width: 80px;">结束时间</label>
                                           <div class="layui-input-inline">
                                               <input  style="width: 200px"  id="ashoreScanTime" name="ashoreScanTime" class="layui-input" type="text">
                                           </div>
                                       </div>
                                       <div class="layui-inline divbox" style="margin-top: 10px;">
                                           <label class="layui-form-label" style="width: 80px;">船名/项目</label>
                                           <div class="layui-input-inline"  style="display: flex">
                                               <select id="visitLocation" name="visitLocation" class="visitLocation" lay-verify="visitLocation" lay-filter="visitLocation">
                                                   <option value="">请选择</option>
                                               </select>
                                           </div>
                                       </div>

                                       <div class="layui-inline divbox" style="margin-top: 10px;">
                                           <label class="layui-form-label" style="width: 35px;">排序</label>
                                           <div class="layui-input-inline"  style="display: flex">
                                               <select id="sort" name="sort" class="sort" lay-verify="sort" lay-filter="sort" style="width: 200px;">
                                                   <option value="1">默认排序</option>
                                                   <option value="2">人员类型升序</option>
                                                   <option value="3">人员类型降序</option>
                                               </select>
                                           </div>
                                       </div>

                                   </div>
                                        <div class="item">
                                            <div>
                                                <button type="button" style="margin-left: 10px;vertical-align: top;" class="layui-btn layui-btn-normal layui-btn-radius divbox" onclick="creatCode()">生成二维码</button>
                                                <button type="button" class="layui-btn layui-btn-sm divbox" id="search1" style="vertical-align: top;height: 38px;" lay-event="search1">查询</button>
                                                <button type="button" class="layui-btn layui-btn-sm divbox" id="export" style="vertical-align: top; height: 38px;" lay-event="export">导出</button>
                                                <button type="button" class="layui-btn layui-btn-sm divbox" id="reBtn" style="margin-left: 10px;vertical-align: top;height: 38px;" >计算时间</button>
                                                <button type="button" class="layui-btn layui-btn-sm divbox" id="addBtn" style="margin-left: 10px;vertical-align: top;height: 38px;" >添加</button>
                                            </div>
                                        </div>
                                        </div>
                                </form>
            </div>
            <div class="layui-fluid">
                <div class="layui-row">
                    <div class="layui-col-xs12 layui-col-sm12 	layui-col-md12">
                        <div style="margin-top: -20px; width: 100%;">
                            <table class="layui-hide layui-col-xs12" id="test1" lay-filter="test1"></table>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div class="layui-tab-item">
              <div class="register_table">

<%--                              数据表格--%>
            <div style="background-color:#fff;">
                <p style="text-align:center;line-height: 50px;"><strong><span style="font-family:宋体;color:black; font-size: 22px;">人员登记表</span>&nbsp;&nbsp;</strong><strong><span style="font-family:'Times New Roman',serif;color:black;font-size: 22px;">POB Record(QSHE-P617/C2S0753-03)</span></strong><strong></strong></p>

                <p style="text-indent:42px">
                <form class="layui-form">
         <div class="item">
             <%---                       选择船名--%>
             <div class="layui-inline" style="margin: 10px; margin-left: 70px; display: inline-block;">
                 <label class="layui-form-label" style="padding: 9px 0; width: 184px;">船名/项目 Vessel/Project</label>
                 <div class="layui-input-inline"  style="display: flex">
                     <select id="shipName" name="shipName" class="visitLocation" lay-verify="shipName" lay-filter="shipName">
                         <option value="">请选择</option>
                     </select>
                 </div>
             </div>
             <%--            选择日期--%>
             <div style="margin-left: 200px; display: inline-block;">
                 <div class="layui-inline" style="margin: 10px;" >
                     <label class="layui-form-label" style="width: 164px;">更新日期 Updated Date</label>
                     <div class="layui-input-inline"  style="display: flex">
                         <input type="text" id="shipDate" name="shipDate" autocomplete="off" class="layui-input">
                     </div>
                 </div>
                 <%--                                   提交按钮--%>
                 <button type="button" class="layui-btn layui-btn-sm" id="swarchShip" lay-event="swarchShip" style="height: 30px;line-height: 30px;">查询</button>
             </div>
         </div>
                </form>
                </p>
                <table cellspacing="0" cellpadding="0" id="test2" width="100%">
                    <tbody>
                    <tr style=";height:38px" class="firstRow">
                        <td width="6" style="border-width: 1px 1px 1px 1px; border-color: windowtext; border-style: solid; padding: 0px 7px;" height="38">
                            <p style="text-align:center"><span style=";font-family:宋体;color:black">序号</span></p>
                            <p style="text-align:center">
                                <span style=";font-family:'Times New Roman',serif;color:black">No</span>
                            </p>
                        </td>
                        <td width="9" style="border-top: 1px solid windowtext; border-left: none; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px;" height="38">
                            <p style="text-align:center">
                                <span style=";font-family:宋体;color:black">姓名</span>
                            </p>
                            <p style="text-align:center">
                                <span style=";font-family:'Times New Roman',serif;color:black">Name</span>
                            </p>
                        </td>
                        <td width="14" style="border-top: 1px solid windowtext; border-left: none; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px;" height="38">
                            <p style="text-align:center">
                                <span style=";font-family:宋体;color:black">单位</span>
                            </p>
                            <p style="text-align:center">
                                <span style=";font-family:'Times New Roman',serif;color:black">Department</span>
                            </p>
                        </td>
                        <td width="10" style="border-top: 1px solid windowtext; border-left: none; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px;" height="38">
                            <p style="text-align:center">
                                <span style=";font-family:宋体;color:black">岗位</span>
                                <span style=";font-family:'Times New Roman',serif;color:black">/</span>
                                <span style=";font-family:宋体;color:black">职务</span>
                            </p>
                            <p style="text-align:center">
                                <span style=";font-family:'Times New Roman',serif;color:black">post</span>
                            </p>
                        </td>
                        <td width="10" style="border-top: 1px solid windowtext; border-left: none; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px;" height="38">
                            <p style="text-align:center">
                                <span style=";font-family:宋体;color:black">人员类型</span>

                            </p>
                            <p style="text-align:center">
                                <span style=";font-family:'Times New Roman',serif;color:black">staff type</span>
                            </p>
                        </td>
                        <td width="10" style="border-top: 1px solid windowtext; border-left: none; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px;" height="38">
                            <p style="text-align:center">
                                <span style=";font-family:宋体;color:black">房间号</span>
                            </p>
                            <p style="text-align:center">
                                <span style=";font-family:'Times New Roman',serif;color:black">Room</span>
                            </p>
                        </td>
                        <td width="19" colspan="2" style="border-top: 1px solid windowtext; border-left: none; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px;" height="38"><p style="text-align:center">
                            <span style=";font-family:宋体;color:black">登船时间和地点</span>
                        </p>
                            <p style="text-align:center">
                                <span style=";font-family:'Times New Roman',serif;color:black">Boarding time and &nbsp; location</span>
                            </p>
                        </td>
                        <td width="20" colspan="2" style="border-top: 1px solid windowtext; border-left: none; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px;" height="38"><p style="text-align:center">
                            <span style=";font-family:宋体;color:black">离船时间和地点</span>
                        </p>
                            <p style="text-align:center">
                                <span style=";font-family:'Times New Roman',serif;color:black">Departure time and &nbsp; location</span>
                        </p>
                        </td>
                        <td width="10" valign="top" style="border-top: 1px solid windowtext; border-left: none; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px;" height="38">
                            <p style="text-align:center">
                            <span style=";font-family:宋体;color:black">在船天数</span>
                        </p>
                            <p style="text-align:center">
                                <span style=";font-family:'Times New Roman',serif;color:black">Days onboard</span>
                            </p>
                        </td>
                    </tr>
                    <tr class="crew">
                        <td style="border-width: 1px 1px 1px 1px; border-color: windowtext; border-style: solid; padding: 0px 7px;" colspan="11" height="38">
                            <p style="text-align:center"><span style=";font-family:宋体;color:black;font-weight: bold">第 1 部分船员(Part One Ship's Crew)</span></p>

                        </td>
                    </tr>
                    <tr class="engineer">
                        <td  style="border-width: 1px 1px 1px 1px; border-color: windowtext; border-style: solid; padding: 0px 7px; font-weight: bold" colspan="11"  height="38">
                            <p style="text-align:center"><span style=";font-family:宋体;color:black">第 2 部分工程人员(Part Two Project Crew)</span></p>

                        </td>
                    </tr>
                    <tr class="passenger">
                        <td  style="border-width: 1px 1px 1px 1px; border-color: windowtext; border-style: solid; padding: 0px 7px; font-weight: bold"  colspan="11" height="38">
                            <p style="text-align:center"><span style=";font-family:宋体;color:black">第 3 部分乘客(Part Three Passenger)</span></p>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
<%--                  end--%>
            </div>
        </div>
    </div>
</div>




</body>
<script>
<%--    返回编辑和删除的权限--%>
var qx = -1;

$.ajax({
    url:"/coesStaffRegister/selectprivID",
    success:function(res) {
        qx = res;
    }
})
    $.ajax({
        url:"/coesStaffRegister/selectupdate",
        dataType:"json",
        data:{
            ifs:false
        },
        success:function(res) {
        }
    })
    function getCookie(cookie_name) {
        var allcookies = document.cookie;
        //索引长度，开始索引的位置
        var cookie_pos = allcookies.indexOf(cookie_name);


        // 如果找到了索引，就代表cookie存在,否则不存在
        if (cookie_pos != -1) {
            // 把cookie_pos放在值的开始，只要给值加1即可
            //计算取cookie值得开始索引，加的1为“=”
            cookie_pos = cookie_pos + cookie_name.length + 1;
            //计算取cookie值得结束索引
            var cookie_end = allcookies.indexOf(";", cookie_pos);


            if (cookie_end == -1) {
                cookie_end = allcookies.length;


            }
            //得到想要的cookie的值
            var value = unescape(allcookies.substring(cookie_pos, cookie_end));
        }
        return value;
    }
    var byname = getCookie('byname');
    function showBtn() {
        if(byname === 'admin') {
            return false
        }else if(byname == 485) {
            return false
        }else if(byname == 2731) {
            return false
        }else if(byname == 5432) {
            return false
        } else {
            return true
        }
    }
<%--    不同人员类型的数组--%>
    var crewArr = [];
    var engArr = [];
    var pasArr = [];
    var address1;
    layui.use(['layer','laydate'], function () {
        var layer = layui.layer;
        var laydate = layui.laydate;
        laydate.render({
            elem:"#boardScanTime",
            trigger:"click",
            format:"yyyy-MM-dd HH:mm:ss",
            type:"datetime"

        })
        laydate.render({
            elem:"#ashoreScanTime",
            trigger:"click",
            format:"yyyy-MM-dd HH:mm:ss",
            type:"datetime"
        })
    });

    //导出数据
    $('#export').click(function() {
        var name = $("#cName").val()
        var mobilNo = $('#mobbleNo').val();
        var idNumber = $('#idCard').val();
        var sort = $('select[name=sort]').val();
        window.location.href = "/coesStaffRegister/export?ifs="+true+"&name="+name+"&mobilNo"+mobilNo+"&idNumber"+idNumber+"&order="+sort;
    })
    //预览等弹出框
    function creatCode() {
        if ($("#visitLocation").val()==''||$("#visitLocation").val()==undefined){
            layer.msg('请选择船名！',{icon:0});
            return false;
        }
        var address1= $("#visitLocation").find("option:selected").text()
        var address2=decodeURI(address1);
        var codeNo1 = $("#visitLocation").val()
        layer.open({
            type: 1,
            title:"生成二维码",
            area:['100%','100%'],
            offset:"0px",
                content: '<div id="code">\n' +
                    '        <center> <div id="qrcode"  style="margin-top: 100px"></div></center>\n' +
                    '    </div><center><strong><p style="margin-top: 30px;font-size: 30px">'+address2+'</p></strong></center>'+
                    '    <center><p style="margin-top: 30px;font-size: 16px;color:red;">请使用微信扫描二维码</p></center>',
                btn:['<i class="layui-icon" style="margin-right: 10px;">&#xe609</i>下载图片','打印','取消'],
            btn1:function(index) {
                var img = $('#qrcode img');
                var url = img[0].src;
                        var a = document.createElement('a');          // 创建一个a节点插入的document
                        var event = new MouseEvent('click')           // 模拟鼠标click点击事件
                        a.download = '二维码'                      // 设置a节点的download属性值
                        a.href = url;                                 // 将图片的src赋值给a节点的href
                        a.dispatchEvent(event)
            },
            btn2:function() {
                        window.print();
            }
        })
        const url = location.origin + '/coesStaffRegister/coesStaffRegisterH5?codeNo='+codeNo1;
        console.log(url)
        new QRCode(document.getElementById("qrcode"),{
            text:location.origin + '/coesStaffRegister/coesStaffRegisterH5?codeNo='+codeNo1,
            width: 300,
            height: 300
        })
    }
    layui.use(['form', 'table', 'element', 'layedit','eleTree','laydate'], function () {
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var layedit = layui.layedit
        var eleTree = layui.eleTree;
        var laydate = layui.laydate;
        form.render()
        $.ajax({
            url:'/code/getCode?parentNo=COES_BOAT_NAME',
            type:'post',
            dataType:'json',
            data:{
            },
            success:function(res){
                var arr=[];
                var str
                for(var i=0;i<res.obj.length;i++){
                    str+='<option  value="'+res.obj[i].codeNo+'">'+res.obj[i].codeName+'</option>'
                }
                $('select[name="visitLocation"]').append(str);
                form.render('select');
            }
        })
        $('#search1').click(function () {
            var name = $("#cName").val()
            var mobilNo = $('#mobbleNo').val();
            var idNumber = $('#idCard').val();
            var boatName = $('select[name=visitLocation] option:selected').text();
            var boardScanTime = $('input[name=boardScanTime]').val();
            var ashoreScanTime = $('input[name=ashoreScanTime]').val();
            var state = $('select[name=state] option:selected').text();
            var sort = $('select[name=sort]').val();
            if(state == '请选择') {
                state = '';
            }
            if(boatName == '请选择') {
                boatName = '';
            }
            // table.reload('tableData',{
            //     where: {
            //                 name:name,
            //                 mobilNo:mobilNo,
            //                 idNumber:idNumber,
            //                 boatName: boatName,
            //                 boardScanTime:boardScanTime,
            //                 ashoreScanTime:ashoreScanTime,
            //                 state:state,
            //                 pageSize: 20,
            //                 order:sort,
            //                 ifs:true,
            //                 useFlag:true
            //     }
            // })
            table.render({
                id:'tableData',
                elem: '#test1',
                url: '/coesStaffRegister/allcoesRegister',
                title: '用户数据表',
                page:true,
                limit:20,
                limits:[20,50,100],
                width: '100%',
                where: {
                    name:name,
                    mobilNo:mobilNo,
                    idNumber:idNumber,
                    boatName: boatName,
                    boardScanTime:boardScanTime,
                    ashoreScanTime:ashoreScanTime,
                    state:state,
                    order:sort,
                    ifs:true,
                    useFlag:true
                },
                request: {
                    pageName:'page',
                    limitName:'pageSize',
                    useFlag:true
                },
                cols: [[
                    {field:"name",title:"姓名",width: 100},
                    {field:"mobilNo",title:"手机号码",width: 150},
                    {field:"idNumber",title:"身份证号码",width: 190,templet:function(res) {
                            var num = res.idNumber.substring(res.idNumber.length - 4,res.idNumber.length);
                            return '**************'+num
                        }},
                    {field:"company",title:"单位",width: 150,sort:true},
                    {field:"post",title:"岗位",width: 150,sort:true},
                    {field:"staffType",title:"人员类型",width:150},
                    {field:"roomNumber",title:"房间号",width: 100},
                    {field:"boardAddress",title:"登船地点",width: 150},
                    {field:"boardTime",title:"登船日期",width: 184},
                    {field:"boatName",title:"船名/项目",width: 150},
                    {field:"ashoreAddress",title:"离船地点",width: 150},
                    {field:"ashoreTime",title:"离船日期",width: 184},
                    {title:"在船天数",width: 100,templet:function(res) {
                                return res.boardDays
                        }},
                    {field:"state",title:"状态",width: 100},
                    {title:'操作',width: 120,templet:function(res) {
                            if(qx == -1) {
                                return ''
                            }else if(qx == 0) {
                                return '<button class="layui-btn layui-btn-xs" lay-event="edit">编辑</button>'
                            }else if(qx == 1) {
                                return '<button class="layui-btn layui-btn-xs" lay-event="edit">编辑</button><button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</button>'
                            }
                        }}

                ]],
                parseData: function (res) { //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "msg": res.msg, //解析提示文本
                        "count": res.totleNum, //解析数据长度
                        "data": res.obj, //解析数据列表
                    };
                },
                done: function(res, curr, count){
                    //如果是异步请求数据方式，res即为你接口返回的信息。
                    //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
                    if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )
                        || ( navigator.userAgent.indexOf('Macintosh') > -1 && navigator.userAgent.indexOf('Chrome') == -1 )
                        || ( navigator.userAgent.indexOf('Macintosh') > -1 && navigator.userAgent.indexOf('Firefox') == -1 )
                        || (/(Android)/i.test(navigator.userAgent))
                    ) {
                        $('body').width($('.layui-table').width()+80)
                    }
                }
            })

        });
        $('#reBtn').click(function() {
            $.ajax({
                url:"/coesStaffRegister/selectupdate",
                dataType:"json",
                data:{
                    ifs:true
                },
                success:function(res) {
                    if(res.flag) {
                        tableInfo.reload();
                        layer.msg('计算成功',{icon: 1,time:1500})
                    }
                }
            })
        })
        //渲染表格
        var tableInfo = table.render({
            id:'tableData',
            elem: '#test1',
             url: '/coesStaffRegister/allcoesRegister',
             title: '用户数据表',
            page: true,
            limit: 20,
            limits:[20,50,100],
            width:'100%',
            where: {
                useFlag: true,
                ifs:true
            },
            request: {
                pageName:'page',
                limitName:'pageSize',
            },
             cols: [[
                 {field:"name",title:"姓名",width: 100},
                 {field:"mobilNo",title:"手机号码",width: 140},
                 {field:"idNumber",title:"身份证号码",width: 180,templet:function(res) {
                         var num = res.idNumber.substring(res.idNumber.length - 4,res.idNumber.length);
                         return '**************'+num
                     }},
                 {field:"company",title:"单位",width: 150,sort:true},
                 {field:"post",title:"岗位",width: 150,sort:true},
                 {field:"staffType",title:"人员类型",width:150},
                 {field:"roomNumber",title:"房间号",width: 100},
                 {field:"boardAddress",title:"登船地点",width: 150},
                 {field:"boardTime",title:"登船日期",width: 184},
                 {field:"boatName",title:"船名/项目",width: 150},
                 {field:"ashoreAddress",title:"离船地点",width: 100},
                 {field:"ashoreTime",title:"离船日期",width: 184},
                 {title:"在船天数",width: 100,templet:function(res) {
                         return res.boardDays
                     }},
                 {field:"state",title:"状态",width: 100},
                 {title:'操作',width: 120,templet:function(res) {
                            if(qx == -1) {
                                return ''
                            }else if(qx == 0) {
                                return '<button class="layui-btn layui-btn-xs" lay-event="edit">编辑</button>'
                            }else if(qx == 1) {
                                return '<button class="layui-btn layui-btn-xs" lay-event="edit">编辑</button><button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</button>'
                            }
                         // return '<button class="layui-btn layui-btn-xs" lay-event="edit">编辑</button><button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</button>'
                     }}
             ]],
             parseData: function (res) { //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.totleNum, //解析数据长度
                    "data": res.obj, //解析数据列表
                };
            },
            done: function(res, curr, count){
                //如果是异步请求数据方式，res即为你接口返回的信息。
                //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
                if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )
                    || ( navigator.userAgent.indexOf('Macintosh') > -1 && navigator.userAgent.indexOf('Chrome') == -1 )
                    || ( navigator.userAgent.indexOf('Macintosh') > -1 && navigator.userAgent.indexOf('Firefox') == -1 )
                    || (/(Android)/i.test(navigator.userAgent))
                ) {
                    $('body').width($('.layui-table').width()+80)
                }
            }
        })
        table.on('tool(test1)', function(obj){
            var event = obj.event;
            if(event == 'del') {
                var id = obj.data.regId;
                layer.confirm('确认删除吗',{icon: 3, title:'提示'},function(index) {
                    $.ajax({
                        url:"/coesStaffRegister/deleteStaffRegister",
                        dataType:"json",
                        data:{
                            id:id
                        },
                        success:function(res) {
                            if(res.flag) {
                              layer.msg(res.msg,{icon:1},function() {
                                  layer.close(index);
                                  table.reload('tableData',{},true);
                              });
                            }
                        }
                    })
                })
            }else if(event == 'edit') {
                var id = obj.data.regId;
                layer.open({
                    type:2,
                    title:'编辑',
                    area:['400px','600px'],
                    btn:['确定','取消'],
                    offset: '20px',
                    content:"/coesStaffRegister/coesEdit?regId="+id,
                    yes:function(index,layero) {
                        var body = layer.getChildFrame('body', index);
                        var name = $(body).find('input[name=name]').val();
                        if(!name) {
                            layer.msg('请输入姓名',{icon: 2})
                            return
                        }
                        var mobilNo = $(body).find('input[name=mobilNo]').val();
                        var idNumber = $(body).find('input[name=idNumber]').val();
                        var company = $(body).find('select[name=company] option:selected').text();
                        if(!company) {
                            layer.msg('请选择单位',{icon:2})
                            return
                        }
                        var post = $(body).find('input[name=post]').val();
                        if(!post) {
                            layer.msg('请输入岗位',{icon:2})
                            return
                        }
                        var staffType = $(body).find('select[name=staffType] option:selected').text();
                        if(!staffType || staffType=='请选择') {
                            layer.msg('请选择人员类型',{icon:2})
                            return
                        }
                        var roomNumber = $(body).find('input[name=roomNumber]').val();
                        var boardAddress = $(body).find('input[name=boardAddress]').val();
                        if(!boardAddress) {
                            layer.msg('请输入登船地点',{icon:2})
                            return
                        }
                        var boardTime = $(body).find('input[name=boardTime]').val();
                        if(!boardTime) {
                            layer.msg('请选择登船日期',{icon:2});
                            return
                        }
                        var boatName = $(body).find('select[name=boatName] option:selected').text();
                        if(boatName == '请选择') {
                            boatName = '';
                            layer.msg('请选择船名/项目',{icon:2});
                            return
                        }

                        var ashoreAddress = $(body).find('input[name=ashoreAddress]').val();
                        var ashoreTime = $(body).find('input[name=ashoreTime]').val();
                        $.ajax({
                            url:"/coesStaffRegister/editStaffRegister",
                            dataType:"json",
                            data:{
                                regId: id,
                                name:name,
                                mobilNo:mobilNo,
                                idNumber:idNumber,
                                company:company,
                                post:post,
                                staffType:staffType,
                                roomNumber:roomNumber,
                                boardTime:boardTime,
                                boardAddress:boardAddress,
                                boatName:boatName,
                                ashoreAddress:ashoreAddress,
                                ashoreTime:ashoreTime
                            },
                            success:function(){
                                //第三方扩展皮肤
                                layui.layer.msg('修改成功', {icon: 1},function() {
                                    layer.close(index);
                                    table.reload('tableData',{},true);
                                });

                            }
                        })
                    }
                })

            }
        }
        )
        //新增数据
        $('#addBtn').click(function() {
            layer.open({
                type:2,
                title:"新增人员登记",
                area:['400px','600px'],
                btn:['确定','取消'],
                content:'/coesStaffRegister/addCoes?qx='+qx,
                yes:function(i,layero) {
                    var body = layer.getChildFrame('body', i);
                    var name = $(body).find('input[name=name]').val();
                    if(!name) {
                        layer.msg('请输入姓名',{icon: 2})
                        return
                    }
                    var mobilNo = $(body).find('input[name=mobilNo]').val();
                    var idNumber = $(body).find('input[name=idNumber]').val();
                    var company = $(body).find('select[name=company] option:selected').text();
                    if(!company) {
                        layer.msg('请选择单位',{icon:2})
                        return
                    }
                    var post = $(body).find('input[name=post]').val();
                    if(!post) {
                        layer.msg('请输入岗位',{icon:2})
                        return
                    }
                    var staffType = $(body).find('select[name=staffType] option:selected').text();
                    if(!staffType || staffType == '请选择') {
                        layer.msg('请选择人员类型',{icon:2})
                        return
                    }
                    var roomNumber = $(body).find('input[name=roomNumber]').val();
                    var boardAddress = $(body).find('input[name=boardAddress]').val();
                    if(!boardAddress) {
                        layer.msg('请输入登船地点',{icon:2})
                        return
                    }
                    var boardTime = $(body).find('input[name=boardTime]').val();
                    if(!boardTime) {
                        layer.msg('请选择登船日期',{icon:2});
                        return
                    }
                    var boatName = $(body).find('select[name=boatName]').val();
                    if(boatName == '请选择') {
                        boatName = '';
                        layer.msg('请选择船名/项目',{icon:2});
                        return
                    }
                    if(boatName) {
                        $.ajax({
                            url:"/coesStaffRegister/selectNumber",
                            dataType:'json',
                            data: {
                                idNumber:idNumber,
                                mobilNo:mobilNo
                            },
                            success:function(res) {
                                if(res.obj.length === 0 || res.obj[0]['ashoreAddress'] != '') {
                                    layer.confirm('确定提交吗',{icon:0},function(index) {
                                        $.ajax({
                                            url:"/coesStaffRegister/boardStaffRegister",
                                            dataType:"json",
                                            data: {
                                                boardTime: boardTime,
                                                name: name,
                                                company: company,
                                                post: post,
                                                mobilNo: mobilNo,
                                                idNumber: idNumber,
                                                boardAddress:boardAddress,
                                                staffType:staffType,
                                                roomNumber:roomNumber,
                                                boatName: boatName
                                            },
                                            success:function(res) {
                                                if(res.flag) {
                                                    layer.msg('提交成功',{icon:1},function() {
                                                        layer.close(index);
                                                        layer.close(i);
                                                        table.reload('tableData',{},true);
                                                    })
                                                }
                                            }
                                        })
                                    })
                                }else {
                                    layer.msg('该用户未离船',{icon:2})
                                    return
                                }
                            }
                        })
                    }else {
                        layer.msg('请选择船名',{icon:2});
                    }




                }
            })
        })

            //人员登记表渲染
    //    获取船名
        $.ajax({
            url:'/code/getCode?parentNo=COES_BOAT_NAME',
            type:'post',
            dataType:'json',
            data:{
            },
            success:function(res){
                var arr=[];
                var str
                for(var i=0;i<res.obj.length;i++){
                    str+='<option  value="'+res.obj[i].codeNo+'">'+res.obj[i].codeName+'</option>'
                }
                $('select[name="shipName"]').append(str);
                form.render('select');
            }
        })
    //    选择日期
        laydate.render({
            elem:"#shipDate",
            trigger:"click",
            value: new Date()
        })
    //    根据船名和时间获取数据
        $('#swarchShip').click(function() {
            pasArr = [];
            crewArr = [];
            engArr = [];
            $('.info').remove();
            var shipName = $('select[name=shipName] option:selected').text();
            if(!shipName) {
                layer.msg("请选择船名",{icon:2})
                return
            }
            var shipDate = $('input[name=shipDate]').val();
            $.ajax({
                url:"/coesStaffRegister/allcoesRegister",
                dataType:"json",
                data: {
                    ifs: false,
                    boatName: shipName,
                    Time: shipDate
                },
                success:function(res) {
                    if(res.flag) {
                        var datas = res.obj;
                        for(var i = 0; i < datas.length; i++) {
                            if(datas[i].staffType == '乘客') {
                                pasArr.push(datas[i])
                            }else if(datas[i].staffType == '船员'){
                                crewArr.push(datas[i])
                            }else if(datas[i].staffType == '工程人员') {
                                engArr.push(datas[i])
                            }
                        }
                    for(var i = crewArr.length - 1; i >= 0; i--) {
                        renderShip(i,crewArr[i],$('.crew'))
                    }
                        for(var i = engArr.length - 1; i >= 0; i--) {
                            renderShip(i,engArr[i],$('.engineer'))
                        }
                        for(var i = pasArr.length - 1; i >= 0; i--) {
                            renderShip(i,pasArr[i],$('.passenger'))
                        }
                    }
                }
            })
        })
    });
//    渲染表格的函数
    function renderShip(index,obj,dom) {
        var tr = $("<tr>");
        tr.html('<td width="6" style="border-top: 1px solid windowtext; border-left: 1px solid windowtext; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px;" height="25">'+(index + 1)+'<br>'+
               ' </td>'+
              ' <td width="9" style="border-top: 1px solid windowtext; border-left: 1px solid windowtext; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px;" height="25">'+obj.name+'<br>'+
               ' </td>'+
               ' <td width="14" style="border-top: 1px solid windowtext; border-left: 1px solid windowtext; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px;" height="25">'+obj.company+'<br>'+
               ' </td>'+
               ' <td width="10" style="border-top: 1px solid windowtext; border-left: 1px solid windowtext; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px;" height="25">'+obj.post+'<br>'+
               ' </td>'+
            ' <td width="10" style="border-top: 1px solid windowtext; border-left: 1px solid windowtext; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px;" height="25">'+obj.staffType+'<br>'+
            ' </td>'+
               ' <td width="10" style="border-top: 1px solid windowtext; border-left: 1px solid windowtext; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px;" height="25">'+obj.roomNumber+'<br>'+
                '</td>'+
               ' <td width="9" style="border-top: 1px solid windowtext; border-left: 1px solid windowtext; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px;" height="25">'+obj.boardTime+'<br>'+
                '</td>'+
               ' <td width="10" style="border-top: 1px solid windowtext; border-left: 1px solid windowtext; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px;" height="25">'+obj.boardAddress+'<br>'+
                '</td>'+
                '<td width="9" style="border-top: 1px solid windowtext; border-left: 1px solid windowtext; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px;" height="25">'+(obj.ashoreTime || "")+'<br>'+
                '</td>'+
               ' <td width="11" style="border-top: 1px solid windowtext; border-left: 1px solid windowtext; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px;" height="25">'+obj.ashoreAddress+'<br>'+
                '</td>'+
                '<td width="10" style="border-top: 1px solid windowtext; border-left: 1px solid windowtext; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px;" height="25">'+obj.boardDays+'<br>'+
                '</td>')
        tr.css({
            height: 40
        })
        tr.addClass('info')
        dom.after(tr)
    }
</script>
</html>


