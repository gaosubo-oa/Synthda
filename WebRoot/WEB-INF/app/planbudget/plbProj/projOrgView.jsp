<%--
  Created by IntelliJ IDEA.
  User: 王秋彤
  Date: 2021/10/12
  Time: 9:41
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
    <title>人员信息预览</title>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <%--    <script type="text/javascript" src="/js/common/fileupload.js"></script>--%>
    <script type="text/javascript" src="/js/planbudget/common.js?20210413"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/planother/planotherUtil.js?221202108301508"></script>

    <style>

        html, body {
            width: 100%;
            height: 100%;
            background: #fff;
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

        .container {
            position: relative;
            width: 100%;
            height: 100%;
            padding: 15px 0 10px;
            box-sizing: border-box;
        }

        .wrapper {
            position: relative;
            width: 100%;
            height: 100%;
            padding: 0 8px;
            box-sizing: border-box;
        }

        /* region 左侧样式 */
        .wrap_left {
            position: relative;
            float: left;
            width: 230px;
            height: 100%;
            padding-right: 10px;
            box-sizing: border-box;
        }

        .wrap_left h2 {
            line-height: 35px;
            text-align: center;
        }

        .wrap_left .left_form {
            position: relative;
            overflow: hidden;
        }

        .left_form .layui-input {
            height: 35px;
            margin: 10px 0;
            padding-right: 25px;
        }

        .tree_module {
            position: absolute;
            top: 90px;
            right: 10px;
            bottom: 0;
            left: 0;
            overflow: auto;
            box-sizing: border-box;
        }

        .eleTree-node-content {
            overflow: hidden;
            word-break: break-all;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .search_icon {
            position: absolute;
            top: 10px;
            right: 0;
            height: 35px;
            width: 25px;
            padding-top: 8px;
            text-align: center;
            cursor: pointer;
            box-sizing: border-box;
        }

        .search_icon:hover {
            color: #0aa3e3;
        }

        /* endregion */

        /* region 右侧样式 */
        .wrap_right {
            position: relative;
            height: 100%;
            margin-left: 230px;
            overflow: auto;
        }

        .query_module .layui-input {
            height: 35px;
        }

        /* region 图标样式 */
        .icon_img {
            font-size: 25px;
            cursor: pointer;
        }

        .icon_img:hover {
            color: #0aa3e3;
        }

        /* endregion */

    </style>
</head>
<body>

<div class="container table_box" >
    <table id="tableDemo" lay-filter="tableDemo"></table>
</div>

<script type="text/html" id="toolbarDemo">
    <div style="position:absolute;top: 10px;right:60px;">
        <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="preservation">保存</button>
    </div>
</script>

<script>
    // 获取地址栏参数值
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }

   var runId = getQueryString("runId");

    var _disabled = getQueryString('disabled');
    //var type = getQueryString("type");
    if('0'!=_disabled){
        _disabled = 'disabled'
    }else {
        _disabled = ''
    }

    var data = null



    layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer'], function () {
        var laydate = layui.laydate;
        var form = layui.form;
        var table = layui.table;
        var layer = layui.layer;


        var param = {};
        var fla = true;
        if(runId){
            param.runId=runId;
        }else{
            fla = false;
            layer.msg("信息获取失败！")
            return false;
        }
        if(fla){
            tableInit(runId)
        }
        // 渲染数据表格
        function tableInit(runId) {
           table.render({
                elem: '#tableDemo'
               // , data: []
               , url: '/projOrg/select'
               , where: {
                        runId: runId,
                       delFlag: '0'
                   }
               , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                    layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                    , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                    , first: false //不显示首页
                    , last: false //不显示尾页
                } //开启分页
                , toolbar: '#toolbar'
                , cols: [[ //表头
                    {field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false}
                    , {field: 'deptName', title: '部门', minWidth: 90,sort: true, hide: false}
                    , {field:'jobName',title:'岗位',minWidth: 120,sort:true,hide:false}
                    , {field: 'userName', title: '姓名', minWidth: 120,sort: true, hide: false}
                    , {field: 'mobileNo', title: '电话',minWidth: 100, sort: true, hide: false}
                    , {field: 'jobDuty', title: '岗位职责',minWidth: 120, sort: true, hide: false, templet: function (d) {
                           return '<input type="text" name="jobDuty" projOrgId="'+(d.projOrgId || '')+'" userId="'+(d.userId || '')+'" '+_disabled+' class="layui-input" style="height: 100%;" value="' + (d.jobDuty || '') + '">'
                       }
                    }
                ]]
                , limit: 10
                , done: function (res) {
                }
            });
        }

    })



    function detailsData() {
        //遍历表格获取每行数据
        var $trs = $('.table_box').find('.layui-table-main tr');
        var dataArr = [];
        $trs.each(function () {
            var dataObj = {
                deptName: $(this).find('[data-field="deptName"] div').text(),
                jobName: $(this).find('[data-field="jobName"] div').text(),
                userName: $(this).find('[data-field="userName"] div').text(),
                mobileNo: $(this).find('[data-field="mobileNo"] div').text(),
                jobDuty: $(this).find('input[name="jobDuty"]').val(),
                projOrgId: $(this).find('input[name="jobDuty"]').attr('projOrgId') || '',
                userId: $(this).find('input[name="jobDuty"]').attr('userId') || '',
                projectId: $('#leftId').attr('projId') || '',
                currFlowUserName: $(this).find('[data-field="currFlowUserName"] div').text(),
                auditerStatus: $(this).find('[data-field="auditerStatus"]').attr('data-content')
            }
            dataArr.push(dataObj);
        });

        return dataArr
    }


    function childFunc() {
        if(_disabled){
            return true
        }
        var dataArr = detailsData()
        var data = []
        dataArr.forEach(function(item){
            var obj = {
                jobDuty: item.jobDuty,
                userId: item.userId,
                projectId: $('#leftId').attr('projId')
            }
            if(item.projOrgId){
                obj.projOrgId = item.projOrgId
            }
            data.push(obj)
        })
        var loadIndex = layer.load();


        var _flag = false;

        $.ajax({
            url: '/projOrg/updateById',
            data: JSON.stringify(data),
            dataType: 'json',
            contentType: "application/json;charset=UTF-8",
            type: 'post',
            success: function (res) {
                layer.close(loadIndex);
                if (res.code=='0') {
                    layer.msg('保存成功！', {icon: 1});
                } else {
                    layer.msg(res.msg, {icon: 2});
                    _flag = true
                }
            }
        });

        if(_flag){
            return false;
        }
        return true;

    }


</script>
</body>
</html>
