<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--// $.popWindow("../../common/selectUser");--%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" type="text/css" href="../../css/dept/deptManagement.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/dept/new_news.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
    <link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script type="text/javascript" src="../../lib/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../../lib/easyui/tree.js"></script>
    <%--<script type="text/javascript" src="../../js/index.js"></script>--%>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="../../js/base/base.js"></script>
    <title>办公用品报表</title>
</head>
<style>
    html,
    body,
    .wrap{
        width:100%;
        height:100%;
        /* overflow: hidden;*/
    }		.pick{			overflow-x: auto;		}		.pick::-webkit-scrollbar{            width: 5px;            height: 6px;            background-color: #f5f5f5;        }        /*定义滚动条的轨道，内阴影及圆角*/        #cont_left::-webkit-scrollbar-track{            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);            border-radius: 10px;            background-color: #f5f5f5;        }        /*定义滑块，内阴影及圆角*/        ::-webkit-scrollbar-thumb{            /*width: 10px;*/            height: 20px;            border-radius: 10px;            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);            background-color: #555;        }		::-webkit-scrollbar{            width: 5px;            height: 0px;            background-color: #f5f5f5;        }
    .head_rig  .import {
        width: 56px;
        height: 30px;
        font-size: 13px !important;
        cursor: pointer;
        background-repeat: no-repeat;
        background-image: url(../../img/sys/import.png);
        padding-left: 25px;
    }
    .head_rig  .export {
        width: 56px;
        height: 30px;
        font-size: 13px !important;
        cursor: pointer;
        background-repeat: no-repeat;
        background-image: url(../../img/sys/export.png);
        padding-left: 25px;
    }
    .head_rig .new_dept {
        width: 160px;
        height: 30px;
        font-size: 13px !important;
        background-image:url(../../img/sys/dept_personnel.png);
        cursor: pointer;
        background-repeat: no-repeat;
        color: #fff;
        margin-top: 0px;
        float: right;
    }

    #cont_left::-webkit-scrollbar {
        width: 0px;
    }

    #cont_left::-webkit-scrollbar-corner {
        /*background: #82AFFF;*/
    }

    .head_rig {
        width: 29%;
        margin-top: 0px;
        float: right;
    }
    .head_rig h1 {
        float: left;
        margin-right:20px;
    }

    .search h1 {
        text-align: center;
        color: #fff;
        font-size: 14px;
        line-height: 28px;
        background-image: url(../../img/workflow/btn_check_nor_03.png);
        background-repeat: no-repeat;
    }

    .cont {
        width: 102%;
        height: 95%;
        overflow-y: scroll;
    }
    .pick li{width: 2000px;}
    .head {
        border-bottom: 1px solid #9E9E9E;
        height: 42px;
    }
    .head_rig h1 :hover {
        cursor: pointer;
    }

    .search h1 :hover {
        cursor: pointer;
    }

    .new_excell_info_other span {
        margin-left: 10px;
        color: black;
    }

    .new_excell_info_other li {
        height: 50%;
        line-height: 24px;
        font-size: 20px;
    }

    user agent stylesheet
    li {
        display: list-item;
        text-align: -webkit-match-parent;
    }

    select {

        height: 32px;
        width: 220px;
        border-radius: 4px;
        border: 1px solid #cccccc;
        background-color: #ffffff;
    }

    .f_field_ctrl input {
        color: #000;
    }

    #delete_{
        padding-left: 2px;
    }

    .layui-layer-page .layui-layer-btn {
        padding-top: 10px;
        text-align: center;
    }
    .dpetWhole0{overflow: auto;margin-left:10px;}
    dpetWhole0 li{white-space: nowrap;}


    .classify{
        display: inline;
        float: left;
        margin-left: 10px;
    }

    .td_title1{
        height:32px;
    }

    .tdText{
        font-size: 15px;
        color: #2a588c;
        font-weight: bold;
    }
    .cont_left {
        border-right: none!important;
    }
    .cont_left ul{
        width: 90%;
        margin: 10px auto;
    }
    .cont_left ul li{
        margin-top:-1px;
        padding:15px;
        border:1px solid #eee;
        cursor:pointer;
    }
    .cont_left ul .selectLi{
        background: #0088cc;
        color:#fff;
    }
    .cont_left ul li img{
        float:right;
    }
    .cont_left ul li[type="thing"]{
        border-top-left-radius: 8px;
        border-top-right-radius: 8px;
    }
    .cont_left ul li[type="accounts"]{
        border-bottom-left-radius: 8px;
        border-bottom-right-radius: 8px;
    }
    textarea{
        background: #f2f2f2;
        text-indent: 5px;
        border: 1px solid #d9d9d9;
    }
    .setGlobal tr td{
        border: none;
    }

    .tit{
        position: absolute;
        color: #999;
        margin-left: 10px;
    }

    tr.padstyle td{
        padding-top: 40px;
    }
    table.setGlobal td span{
        color: #313131;
        font-weight: bold;
    }
    table{
        margin:0 auto!important;
    }
    .iptStyle{
        width:180px;
        border-radius: 5px;
    }
    .search{
        width: 90px;
        height: 28px;
        background: #2b7fe0!important;
        border-radius: 3px;
        color: #fff;
        font-size: 14px;
        line-height: 28px;
        margin:0 auto;
        cursor: pointer;
        text-align: center;
        margin-left: 10px;
    }
    table tr th{
        color: #2F5C8F;
        font-weight: bold;
        padding: 8px;
        text-align: center;
        font-size: 13pt;
    }
    table tr td{
        padding: 8px;
        text-align: center;
        border-right: #ccc 1px solid;
        font-size: 11pt;
    }
    .nav_rig{
        float:right;
        margin-right:30px;
    }
    .nav_rig button{
        width: 70px;
        height: 28px;
        background: #2b7fe0!important;
        border-radius: 3px;
        color: #fff;
        font-size: 14px;
        line-height: 28px;
        margin: 0 auto;
        cursor: pointer;
        text-align: center;
    }
    .blue_text{
        width:111px;
    }

</style>
<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>

<style type="text/css">
    .head_rig .new_dept, .nav_box .head_rig .new_dept{
        background-color: #fff !important
    }
</style>

<body style="overflow:scroll;overflow-y: hidden;overflow-x:hidden;">

<div class="wrap" style="margin-left:0px !important;">
    <div class="head">
        <div class="head_left">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/classifySetting.png" alt="">
            <h1>办公用品报表</h1>
        </div>
    </div>

    <div class="cont">
        <div class="cont_left" id="cont_left">
            <ul>
               <li type="thing" class="selectLi">
                   <span>物品总表</span>
                   <img src="/img/sys/icon_rightarrow_03.png" alt="">
               </li>
                <li type="buy">
                    <span>采购物品报表</span>
                    <img src="/img/sys/icon_rightarrow_03.png" alt="">
                </li>
                <li type="dept">
                    <span>部门、人员领用物品报表</span>
                    <img src="/img/sys/icon_rightarrow_03.png" alt="">
                </li>
                <li type="borrow">
                    <span>借用物品报表</span>
                    <img src="/img/sys/icon_rightarrow_03.png" alt="">
                </li>
                <li type="return">
                    <span>归还物品报表</span>
                    <img src="/img/sys/icon_rightarrow_03.png" alt="">
                </li>
                <li type="unreturn">
                    <span>未归还物品报表</span>
                    <img src="/img/sys/icon_rightarrow_03.png" alt="">
                </li>
                <li type="scrap">
                    <span>报废物品报表</span>
                    <img src="/img/sys/icon_rightarrow_03.png" alt="">
                </li>
                <li type="maintain">
                    <span>维护记录报表</span>
                    <img src="/img/sys/icon_rightarrow_03.png" alt="">
                </li>
                <li type="accounts">
                    <span>台账报表</span>
                    <img src="/img/sys/icon_rightarrow_03.png" alt="">
                </li>
            </ul>
        </div>

        <%--物品总表--%>
        <div class="cont_rig thing" type="thing">
            <div class="nav_box1 clearfix1" style="margin-left:0px;margin-top: 20px;margin-bottom: 15px; ">
                <div class="nav_t22" style="display:inline;font-size: 20px;font-family: 微软雅黑;margin-left: 8px" class="news">物品总表</div>
            </div>
            <!-- 中间部分 -->
            <table class="newNews" style="width: 95%;">
                <tbody>
                <tr>
                    <td class="td_w blue_text">办公用品库：</td>
                    <td><select name="" class="officku"><option value="">请选择</option></select></td>
                    <td class="td_w blue_text">办公用品类别：</td>
                    <td><select name="" class="officType"><option value="">请选择</option></select></td>
                    <td class="td_w blue_text">办公用品：</td>
                    <td><select name="" class="offic"><option value="">请选择</option></select></td>
                </tr>
                <tr>
                    <td class="td_w blue_text">日期： </td>
                    <td colspan="5">
                        <input class="iptStyle" class="startTime" type="text" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})"  placeholder="" />
                        <span>至</span>
                        <input class="iptStyle" class="endTime" type="text" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" placeholder=""/>
                    </td>
                </tr>

                <tr>
                    <td colspan="6">
                        <button type="button" class="search" type="thing" style="margin-left: 41%;">查询</button>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="thingList" style="display: none">
                <div class="nav_box1 clearfix1" style="margin-left:0px;margin-top: 20px;margin-bottom: 15px; ">
                    <div class="nav_t22" style="display:inline;font-size: 20px;font-family: 微软雅黑;margin-left: 8px" class="news">物品总量信息</div>
                    <div class="nav_rig">
                        <button>打印</button>
                        <button>导出</button>
                    </div>
                </div>
                <table style="width:95%">
                    <thead>
                        <tr>
                            <th>排序</th>
                            <th>办公用品名称</th>
                            <th>计量单位</th>
                            <th>单价</th>
                            <th>规格</th>
                            <th>当前库存</th>
                            <th>库存金额</th>
                            <th>采购量</th>
                            <th>领用量</th>
                            <th>借出量</th>
                            <th>归还量</th>
                            <th>未归还量</th>
                            <th>报废量</th>
                        </tr>
                    </thead>
                    <tbody class="thingLists">

                    </tbody>
                    </table>


            </div>
        </div>

        <%--采购物品报表--%>
        <div class="cont_rig buy" type="buy" style="display: none">
            <div class="nav_box1 clearfix1" style="margin-left:0px;margin-top: 20px;margin-bottom: 15px; ">
                <div class="nav_t22" style="display:inline;font-size: 20px;font-family: 微软雅黑;margin-left: 8px" class="news">采购物品查询</div>
            </div>
            <!-- 中间部分 -->
            <table class="newNews" style="width: 95%;">
                <tbody>
                <tr>
                    <td class="td_w blue_text">办公用品库：</td>
                    <td><select name="" class="officku"><option value="">请选择</option></select></td>
                    <td class="td_w blue_text">办公用品类别：</td>
                    <td><select name="" class="officType"><option value="">请选择</option></select></td>
                    <td class="td_w blue_text">办公用品：</td>
                    <td><select name="" class="offic"><option value="">请选择</option></select></td>
                </tr>
                <tr>
                    <td class="td_w blue_text">日期： </td>
                    <td colspan="3">
                        <input class="iptStyle" class="startTime" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" type="text"  placeholder="" />
                        <span>至</span>
                        <input class="iptStyle" class="endTime" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" type="text" placeholder=""/>
                    </td>
                    <td class="td_w blue_text">统计图： </td>
                    <td>
                        <label for="">
                            <input type="radio" checked name="" id="">
                            <span>饼状图</span>
                        </label>
                        <label for="">
                            <input type="radio" name="" id="">
                            <span>柱状图</span>
                        </label>
                        <label for="">
                            <input type="radio" name="" id="">
                            <span>数据表</span>
                        </label>
                    </td>
                </tr>

                <tr>
                    <td colspan="6">
                        <button type="button" class="search" type="buy" style="margin-left: 41%;">查询</button>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="buyList" style="display: none">
                <div class="nav_box1 clearfix1" style="margin-left:0px;margin-top: 20px;margin-bottom: 15px; ">
                    <div class="nav_t22" style="display:inline;font-size: 20px;font-family: 微软雅黑;margin-left: 8px" class="news">采购物品报表</div>
                    <div class="nav_rig">
                        <button>打印</button>
                        <button>导出</button>
                    </div>
                </div>
                <table style="width:95%">
                    <thead>
                    <tr>
                        <th>排序</th>
                        <th>办公用品名称</th>
                        <th>计量单位</th>
                        <th>单价</th>
                        <th>规格</th>
                        <th>当前库存</th>
                        <th>库存金额</th>
                        <th>采购量</th>
                        <th>领用量</th>
                        <th>借出量</th>
                        <th>归还量</th>
                        <th>未归还量</th>
                        <th>报废量</th>
                    </tr>
                    </thead>
                    <tbody class="buyLists">

                    </tbody>
                </table>


            </div>
        </div>

        <%--部门人员领用物品报表--%>
        <div class="cont_rig dept" type="dept" style="display: none">
            <div class="nav_box1 clearfix1" style="margin-left:0px;margin-top: 20px;margin-bottom: 15px; ">
                <div class="nav_t22" style="display:inline;font-size: 20px;font-family: 微软雅黑;margin-left: 8px" class="news">部门、人员领用物品查询</div>
            </div>
            <!-- 中间部分 -->
            <table class="newNews" style="width: 95%;">
                <tbody>
                <tr>
                    <td class="td_w blue_text">办公用品库：</td>
                    <td><select name="" class="officku"><option value="">请选择</option></select></td>
                    <td class="td_w blue_text">办公用品类别：</td>
                    <td><select name="" class="officType"><option value="">请选择</option></select></td>
                    <td class="td_w blue_text">办公用品：</td>
                    <td><select name="" class="offic"><option value="">请选择</option></select></td>
                </tr>
                <tr>
                    <td class="td_w blue_text">日期： </td>
                    <td colspan="3">
                        <input class="iptStyle" class="startTime" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" type="text"  placeholder="" />
                        <span>至</span>
                        <input class="iptStyle" class="endTime" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" type="text" placeholder=""/>
                    </td>
                    <td class="td_w blue_text">统计图： </td>
                    <td>
                        <label for="">
                            <input type="radio" checked name="" id="">
                            <span>饼状图</span>
                        </label>
                        <label for="">
                            <input type="radio" name="" id="">
                            <span>柱状图</span>
                        </label>
                        <label for="">
                            <input type="radio" name="" id="">
                            <span>数据表</span>
                        </label>
                    </td>
                </tr>

                <tr>
                    <td colspan="6">
                        <button type="button" class="search" type="dept" style="margin-left: 41%;">查询</button>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="deptList" style="display: none">
                <div class="nav_box1 clearfix1" style="margin-left:0px;margin-top: 20px;margin-bottom: 15px; ">
                    <div class="nav_t22" style="display:inline;font-size: 20px;font-family: 微软雅黑;margin-left: 8px" class="news">部门、人员领用物品报表</div>
                    <div class="nav_rig">
                        <button>打印</button>
                        <button>导出</button>
                    </div>
                </div>
                <table style="width:95%">
                    <thead>
                    <tr>
                        <th>排序</th>
                        <th>办公用品名称</th>
                        <th>计量单位</th>
                        <th>单价</th>
                        <th>规格</th>
                        <th>当前库存</th>
                        <th>库存金额</th>
                        <th>采购量</th>
                        <th>领用量</th>
                        <th>借出量</th>
                        <th>归还量</th>
                        <th>未归还量</th>
                        <th>报废量</th>
                    </tr>
                    </thead>
                    <tbody class="deptLists">

                    </tbody>
                </table>


            </div>
        </div>

        <%--借用物品报表--%>
        <div class="cont_rig borrow" type="borrow" style="display: none">
            <div class="nav_box1 clearfix1" style="margin-left:0px;margin-top: 20px;margin-bottom: 15px; ">
                <div class="nav_t22" style="display:inline;font-size: 20px;font-family: 微软雅黑;margin-left: 8px" class="news">借用物品报表</div>
            </div>
            <!-- 中间部分 -->
            <table class="newNews" style="width: 95%;">
                <tbody>
                <tr>
                    <td class="td_w blue_text">办公用品库：</td>
                    <td><select name="" class="officku"><option value="">请选择</option></select></td>
                    <td class="td_w blue_text">办公用品类别：</td>
                    <td><select name="" class="officType"><option value="">请选择</option></select></td>
                    <td class="td_w blue_text">办公用品：</td>
                    <td><select name="" class="offic"><option value="">请选择</option></select></td>
                </tr>
                <tr>
                    <td class="td_w blue_text">日期： </td>
                    <td colspan="3">
                        <input class="iptStyle" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" class="startTime" type="text"  placeholder="" />
                        <span>至</span>
                        <input class="iptStyle" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" class="endTime" type="text" placeholder=""/>
                    </td>
                    <td class="td_w blue_text">申请人： </td>
                    <td>
                        <input type="text" id="borrowUser" class="iptStyle">
                        <a href="javascript:;" onclick="addUser('borrowUser')">添加</a>
                        <a href="javascript:;" onclick="clearUser('borrowUser')">清除</a>
                    </td>
                </tr>

                <tr>
                    <td colspan="6">
                        <button type="button" class="search" type="borrow" style="margin-left: 41%;">查询</button>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="borrowList" style="display: none">
                <div class="nav_box1 clearfix1" style="margin-left:0px;margin-top: 20px;margin-bottom: 15px; ">
                    <div class="nav_t22" style="display:inline;font-size: 20px;font-family: 微软雅黑;margin-left: 8px" class="news">物品总量信息</div>
                    <div class="nav_rig">
                        <button>打印</button>
                        <button>导出</button>
                    </div>
                </div>
                <table style="width:95%">
                    <thead>
                    <tr>
                        <th>排序</th>
                        <th>办公用品名称</th>
                        <th>计量单位</th>
                        <th>单价</th>
                        <th>规格</th>
                        <th>当前库存</th>
                        <th>库存金额</th>
                        <th>采购量</th>
                        <th>领用量</th>
                        <th>借出量</th>
                        <th>归还量</th>
                        <th>未归还量</th>
                        <th>报废量</th>
                    </tr>
                    </thead>
                    <tbody class="borrowLists">

                    </tbody>
                </table>


            </div>
        </div>

        <%--归还物品报表--%>
        <div class="cont_rig return" type="return" style="display: none">
            <div class="nav_box1 clearfix1" style="margin-left:0px;margin-top: 20px;margin-bottom: 15px; ">
                <div class="nav_t22" style="display:inline;font-size: 20px;font-family: 微软雅黑;margin-left: 8px" class="news">归还物品查询</div>
            </div>
            <!-- 中间部分 -->
            <table class="newNews" style="width: 95%;">
                <tbody>
                <tr>
                    <td class="td_w blue_text">办公用品库：</td>
                    <td><select name="" class="officku"><option value="">请选择</option></select></td>
                    <td class="td_w blue_text">办公用品类别：</td>
                    <td><select name="" class="officType"><option value="">请选择</option></select></td>
                    <td class="td_w blue_text">办公用品：</td>
                    <td><select name="" class="offic"><option value="">请选择</option></select></td>
                </tr>
                <tr>
                    <td class="td_w blue_text">日期： </td>
                    <td colspan="3">
                        <input class="iptStyle" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" class="startTime" type="text"  placeholder="" />
                        <span>至</span>
                        <input class="iptStyle" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" class="endTime" type="text" placeholder=""/>
                    </td>
                    <td class="td_w blue_text">申请人： </td>
                    <td>
                        <input type="text" id="returnUser" class="iptStyle">
                        <a href="javascript:;" onclick="addUser('returnUser')">添加</a>
                        <a href="javascript:;" onclick="clearUser('returnUser')">清除</a>
                    </td>
                </tr>

                <tr>
                    <td colspan="6">
                        <button type="button" class="search" type="return" style="margin-left: 41%;">查询</button>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="returnList" style="display: none">
                <div class="nav_box1 clearfix1" style="margin-left:0px;margin-top: 20px;margin-bottom: 15px; ">
                    <div class="nav_t22" style="display:inline;font-size: 20px;font-family: 微软雅黑;margin-left: 8px" class="news">归还物品报表</div>
                    <div class="nav_rig">
                        <button>打印</button>
                        <button>导出</button>
                    </div>
                </div>
                <table style="width:95%">
                    <thead>
                    <tr>
                        <th>排序</th>
                        <th>办公用品名称</th>
                        <th>计量单位</th>
                        <th>单价</th>
                        <th>规格</th>
                        <th>当前库存</th>
                        <th>库存金额</th>
                        <th>采购量</th>
                        <th>领用量</th>
                        <th>借出量</th>
                        <th>归还量</th>
                        <th>未归还量</th>
                        <th>报废量</th>
                    </tr>
                    </thead>
                    <tbody class="returnLists">

                    </tbody>
                </table>


            </div>
        </div>

        <%--未归还物品报表--%>
        <div class="cont_rig unreturn" type="unreturn" style="display: none">
            <div class="nav_box1 clearfix1" style="margin-left:0px;margin-top: 20px;margin-bottom: 15px; ">
                <div class="nav_t22" style="display:inline;font-size: 20px;font-family: 微软雅黑;margin-left: 8px" class="news">未归还物品查询</div>
            </div>
            <!-- 中间部分 -->
            <table class="newNews" style="width: 95%;">
                <tbody>
                <tr>
                    <td class="td_w blue_text">办公用品库：</td>
                    <td><select name="" class="officku"><option value="">请选择</option></select></td>
                    <td class="td_w blue_text">办公用品类别：</td>
                    <td><select name="" class="officType"><option value="">请选择</option></select></td>
                    <td class="td_w blue_text">办公用品：</td>
                    <td><select name="" class="offic"><option value="">请选择</option></select></td>
                </tr>
                <tr>
                    <td class="td_w blue_text">日期： </td>
                    <td colspan="3">
                        <input class="iptStyle" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" class="startTime" type="text"  placeholder="" />
                        <span>至</span>
                        <input class="iptStyle" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" class="endTime" type="text" placeholder=""/>
                    </td>
                    <td class="td_w blue_text">申请人： </td>
                    <td>
                        <input type="text" id="unreturnUser" class="iptStyle">
                        <a href="javascript:;" onclick="addUser('unreturnUser')">添加</a>
                        <a href="javascript:;" onclick="clearUser('unreturnUser')">清除</a>
                    </td>
                </tr>

                <tr>
                    <td colspan="6">
                        <button type="button" class="search" type="unreturn" style="margin-left: 41%;">查询</button>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="unreturnList" style="display: none">
                <div class="nav_box1 clearfix1" style="margin-left:0px;margin-top: 20px;margin-bottom: 15px; ">
                    <div class="nav_t22" style="display:inline;font-size: 20px;font-family: 微软雅黑;margin-left: 8px" class="news">归还物品报表</div>
                    <div class="nav_rig">
                        <button>打印</button>
                        <button>导出</button>
                    </div>
                </div>
                <table style="width:95%">
                    <thead>
                    <tr>
                        <th>排序</th>
                        <th>办公用品名称</th>
                        <th>计量单位</th>
                        <th>单价</th>
                        <th>规格</th>
                        <th>当前库存</th>
                        <th>库存金额</th>
                        <th>采购量</th>
                        <th>领用量</th>
                        <th>借出量</th>
                        <th>归还量</th>
                        <th>未归还量</th>
                        <th>报废量</th>
                    </tr>
                    </thead>
                    <tbody class="unreturnLists">

                    </tbody>
                </table>


            </div>
        </div>

        <%--报废物品报表--%>
        <div class="cont_rig scrap" type="scrap" style="display: none">
            <div class="nav_box1 clearfix1" style="margin-left:0px;margin-top: 20px;margin-bottom: 15px; ">
                <div class="nav_t22" style="display:inline;font-size: 20px;font-family: 微软雅黑;margin-left: 8px" class="news">报废物品查询</div>
            </div>
            <!-- 中间部分 -->
            <table class="newNews" style="width: 95%;">
                <tbody>
                <tr>
                    <td class="td_w blue_text">办公用品库：</td>
                    <td><select name="" class="officku"><option value="">请选择</option></select></td>
                    <td class="td_w blue_text">办公用品类别：</td>
                    <td><select name="" class="officType"><option value="">请选择</option></select></td>
                    <td class="td_w blue_text">办公用品：</td>
                    <td><select name="" class="offic"><option value="">请选择</option></select></td>
                </tr>
                <tr>
                    <td class="td_w blue_text">日期： </td>
                    <td colspan="5">
                        <input class="iptStyle" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" class="startTime" type="text"  placeholder="" />
                        <span>至</span>
                        <input class="iptStyle" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" class="endTime" type="text" placeholder=""/>
                    </td>
                </tr>

                <tr>
                    <td colspan="6">
                        <button type="button" class="search" type="scrap" style="margin-left: 41%;">查询</button>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="scrapList" style="display: none">
                <div class="nav_box1 clearfix1" style="margin-left:0px;margin-top: 20px;margin-bottom: 15px; ">
                    <div class="nav_t22" style="display:inline;font-size: 20px;font-family: 微软雅黑;margin-left: 8px" class="news">报废物品报表</div>
                    <div class="nav_rig">
                        <button>打印</button>
                        <button>导出</button>
                    </div>
                </div>
                <table style="width:95%">
                    <thead>
                    <tr>
                        <th>排序</th>
                        <th>办公用品名称</th>
                        <th>计量单位</th>
                        <th>单价</th>
                        <th>规格</th>
                        <th>当前库存</th>
                        <th>库存金额</th>
                        <th>采购量</th>
                        <th>领用量</th>
                        <th>借出量</th>
                        <th>归还量</th>
                        <th>未归还量</th>
                        <th>报废量</th>
                    </tr>
                    </thead>
                    <tbody class="scrapLists">

                    </tbody>
                </table>


            </div>
        </div>

        <%--维护物品报表--%>
        <div class="cont_rig maintain" type="maintain" style="display: none">
            <div class="nav_box1 clearfix1" style="margin-left:0px;margin-top: 20px;margin-bottom: 15px; ">
                <div class="nav_t22" style="display:inline;font-size: 20px;font-family: 微软雅黑;margin-left: 8px" class="news">维护物品查询</div>
            </div>
            <!-- 中间部分 -->
            <table class="newNews" style="width: 95%;">
                <tbody>
                <tr>
                    <td class="td_w blue_text">办公用品库：</td>
                    <td><select name="" class="officku"><option value="">请选择</option></select></td>
                    <td class="td_w blue_text">办公用品类别：</td>
                    <td><select name="" class="officType"><option value="">请选择</option></select></td>
                    <td class="td_w blue_text">办公用品：</td>
                    <td><select name="" class="offic"><option value="">请选择</option></select></td>
                </tr>
                <tr>
                    <td class="td_w blue_text">日期： </td>
                    <td colspan="5">
                        <input class="iptStyle" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" class="startTime" type="text"  placeholder="" />
                        <span>至</span>
                        <input class="iptStyle" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" class="endTime" type="text" placeholder=""/>
                    </td>
                </tr>

                <tr>
                    <td colspan="6">
                        <button type="button" class="search" type="maintain" style="margin-left: 41%;">查询</button>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="maintainList" style="display: none">
                <div class="nav_box1 clearfix1" style="margin-left:0px;margin-top: 20px;margin-bottom: 15px; ">
                    <div class="nav_t22" style="display:inline;font-size: 20px;font-family: 微软雅黑;margin-left: 8px" class="news">维护物品报表</div>
                    <div class="nav_rig">
                        <button>打印</button>
                        <button>导出</button>
                    </div>
                </div>
                <table style="width:95%">
                    <thead>
                    <tr>
                        <th>排序</th>
                        <th>办公用品名称</th>
                        <th>计量单位</th>
                        <th>单价</th>
                        <th>规格</th>
                        <th>当前库存</th>
                        <th>库存金额</th>
                        <th>采购量</th>
                        <th>领用量</th>
                        <th>借出量</th>
                        <th>归还量</th>
                        <th>未归还量</th>
                        <th>报废量</th>
                    </tr>
                    </thead>
                    <tbody class="maintainLists">

                    </tbody>
                </table>


            </div>
        </div>

        <%--台账物品报表--%>
        <div class="cont_rig accounts" type="accounts" style="display: none">
            <div class="nav_box1 clearfix1" style="margin-left:0px;margin-top: 20px;margin-bottom: 15px; ">
                <div class="nav_t22" style="display:inline;font-size: 20px;font-family: 微软雅黑;margin-left: 8px" class="news">台账物品查询</div>
            </div>
            <!-- 中间部分 -->
            <table class="newNews" style="width: 95%;">
                <tbody>
                <tr>
                    <td class="td_w blue_text">办公用品库：</td>
                    <td><select name="" class="officku"><option value="">请选择</option></select></td>
                    <td class="td_w blue_text">办公用品类别：</td>
                    <td><select name="" class="officType"><option value="">请选择</option></select></td>
                    <td class="td_w blue_text">办公用品：</td>
                    <td><select name="" class="offic"><option value="">请选择</option></select></td>
                </tr>
                <tr>
                    <td class="td_w blue_text">日期： </td>
                    <td colspan="5">
                        <input class="iptStyle" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" class="startTime" type="text"  placeholder="" />
                        <span>至</span>
                        <input class="iptStyle" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" class="endTime" type="text" placeholder=""/>
                    </td>
                </tr>

                <tr>
                    <td colspan="6">
                        <button type="button" class="search" type="accounts" style="margin-left: 41%;">查询</button>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="accountsList" style="display: none">
                <div class="nav_box1 clearfix1" style="margin-left:0px;margin-top: 20px;margin-bottom: 15px; ">
                    <div class="nav_t22" style="display:inline;font-size: 20px;font-family: 微软雅黑;margin-left: 8px" class="news">台账物品报表</div>
                    <div class="nav_rig">
                        <button>打印</button>
                        <button>导出</button>
                    </div>
                </div>
                <table style="width:95%">
                    <thead>
                    <tr>
                        <th>排序</th>
                        <th>办公用品名称</th>
                        <th>计量单位</th>
                        <th>单价</th>
                        <th>规格</th>
                        <th>当前库存</th>
                        <th>库存金额</th>
                        <th>采购量</th>
                        <th>领用量</th>
                        <th>借出量</th>
                        <th>归还量</th>
                        <th>未归还量</th>
                        <th>报废量</th>
                    </tr>
                    </thead>
                    <tbody class="accountsLists">

                    </tbody>
                </table>


            </div>
        </div>





    </div>
</div>
</body>


</html>
<script>

    <%--点击左边菜单--%>
    $('.cont_left li').click(function(){
        var type = $(this).attr('type')
        $(this).addClass('selectLi').siblings().removeClass('selectLi');
        $('.cont_rig').hide();
        $('.'+type).show();
    })

    //选择申请人
    function addUser(id) {
        user_id = id;
        $.popWindow("../../common/selectUser");
    }

    //    清空申请人
    function clearUser(id){
        $('#'+id).val('');
        $('#'+id).removeAttr('user_id');
        $('#'+id).removeAttr('username');
        $('#'+id).removeAttr('userprivname');
        $('#'+id).removeAttr('dataId');
    }

//    获取办公用品库
    function getOfficeku(){
        $.ajax({
            url:'/officeDepository/getDeposttoryByDept',
            type:'get',
            dataType:'json',
            success:function(res){
                if(res.obj.length>0){
                    var str = '<option value="">请选择</option>';
                    for(var i=0;i<res.obj.length;i++){
                        str += '<option value="'+res.obj[i].id+'">'+res.obj[i].depositoryName+'</option>'
                    }
                    $('.officku').html(str)
                }
            }
        })
    }
    getOfficeku()

//    获取办公用品类别以及列表
    $('.officku').change(function(){
        var type = $(this).parents('.cont_rig').attr('type')
        var id = $(this).val();
        $.ajax({
            url:'/officetransHistory/getDownObjects',
            type:'get',
            data:{typeDepository:id},
            dataType:'json',
            success:function(res){
                if(res.obj.length>0){
                    var str = '<option value="">请选择</option>';
                    for(var i=0;i<res.obj.length;i++){
                        str += '<option value="'+res.obj[i].id+'">'+res.obj[i].typeName+'</option>'
                    }
                    $('.'+type).find('.officType').html(str)
                }
            }
        })
    })

//    获取办公用品
    $('.officType').change(function(){
        var type = $(this).parents('.cont_rig').attr('type')
        var id = $(this).val();
        $.ajax({
            url:'/officetransHistory/getDownObjects',
            type:'get',
            data:{officeProductType:id},
            dataType:'json',
            success:function(res){
                if(res.obj.length>0){
                    var str = '<option value="">请选择</option>';
                    for(var i=0;i<res.obj.length;i++){
                        str += '<option value="'+res.obj[i].proId+'">'+res.obj[i].proName+'</option>'
                    }
                    $('.'+type).find('.offic').html(str)
                }
            }
        })
    })







</script>

