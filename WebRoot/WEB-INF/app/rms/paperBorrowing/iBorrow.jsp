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
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>我的借阅</title>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/laydate/skins/default/laydate.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1"/>
<%--    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="../../js/news/page.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="../../lib/laydate/laydate.js"></script>

    <style>
        #selectq{
            margin-left: 10px;
            width: 120px;
            outline: none;
            border-radius:4px;
        }
        .editMange input[type="text"]{
            width: 260px;
            height: 30px;
        }
        select{
            width: 160px;
            height: 30px;
        }
        textarea{
            width: 260px;
            height: 50px;
            vertical-align: middle;
        }
        a{
            text-decoration: none;
            color: #207bd6;
        }
        .newTbale tr td{
            border-right: #ccc 1px solid;
            padding: 5px;
        }
        #j_tb tr:nth-child(even){
            background-color: #fff;
        }
        #j_tb tr:nth-child(odd){
            background-color: #f6f7f9;
        }

        #tr_td .th{
            font-size: 13pt;
            text-align: center;
        }
        #j_tb tr td {
            font-size: 11pt;
            text-align: center;
        }
        .addSign,.addAu{
            background: #00a0e9;
            padding: 5px 10px;
            border-radius: 4px;
            color: #fff;
            cursor: pointer;
            float: left;
            margin-right: 21px;
        }
        .editAndDelete1{
            color: red;
        }
    </style>
</head>

<body>
<div class="bx">
    <div class="navigation  clearfix juMange" id="juMange" style="display: block;">
        <div class="left" style="margin-left: 30px;width: 40%;margin-bottom: 20px">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_jieyueshenqing.png">
            <div class="news">
                <span>我的借阅</span>
            </div>
        </div>
        <%--<div class="wrap" style="margin-left: 0;padding: 0 20px;">--%>
        <%--<table id="tr_td">--%>
        <%--<thead>--%>
        <%--<tr>--%>
        <%--<td class="th">--%>
        <%--<fmt:message code="dem.th.FileNumber"/>--%>
        <%--</td>--%>
        <%--<td class="th">--%>
        <%--<fmt:message code="dem.th.FileName"/>--%>
        <%--</td>--%>
        <%--<td class="th">--%>
        <%--<fmt:message code="dem.th.CoilingLibrary"/>--%>
        <%--</td>--%>
        <%--<td class="th">--%>
        <%--<fmt:message code="dem.th.FondsNumber"/>--%>
        <%--</td>--%>
        <%--<td class="th">--%>
        <%--<fmt:message code="dem.th.CertificateCategory"/>--%>
        <%--</td>--%>
        <%--<td class="th">--%>
        <%--<fmt:message code="dem.th.FileSecurity"/>--%>
        <%--</td>--%>
        <%--<td class="th">--%>
        <%--<fmt:message code="vote.th.FileStatus"/>--%>
        <%--</td>--%>
        <%--<td class="th" style="width: 220px;">--%>
        <%--<fmt:message code="notice.th.operation"/>--%>
        <%--</td>--%>
        <%--</tr>--%>
        <%--</thead>--%>
        <%--<tbody id="j_tb">--%>

        <%--</tbody>--%>
        <%--</table>--%>
        <%--<div class="right"><!-- 分页显示-->--%>
        <%--<div class="M-box3" id="dbgz_page"></div>--%>
        <%--</div>--%>
        <%--</div>--%>
        <%--</div>--%>
        <div class="divIframeThr iframeShow" id="iframeShow" style="width: 100%;height: 100%;display: none;">
            <iframe src="" id="iframeThr" style="width: 100%;height: 100%;" frameborder="0"></iframe>
        </div>
    </div>
</div>
<div id="pagediv">

</div>
</body>
<script type="text/javascript">
    $(function () {
        var screenwidth = document.documentElement.clientWidth;
        // console.log(screenwidth*0.9)
        if (screenwidth  > 1250) {
            var nums = screenwidth * 0.97;
            var sumwidth = screenwidth * 0.97 + 'px';
        } else {
            var nums = 1250;
            var sumwidth = '1600px';
        }
        var width0 = nums * 0.015 + 'px';
        var width1 = nums * 0.065 + 'px';
        var width2 = nums * 0.065 + 'px';
        var width3 = nums * 0.065 + 'px';
        var width4 = nums * 0.065 + 'px';
        var width5 = nums * 0.065 + 'px';
        var width6 = nums * 0.065 + 'px';
        var width7 = nums * 0.065 + 'px';
        pageObj=$.tablePage('#pagediv',sumwidth,[
            {
                width:width0,
                title:'',

            },
            {
                width:width1,
                title:'档案名称',
                name:'name',
            },
            {
                width:width2,
                title:'申请人',
                name:'approve',
            },
            {
                width:width3,
                title:'添加时间',
                name:'addTime',
            },
            {
                width:width4,
                title:'申请时间',
                name:'lendTime',
            },
            {
                width:width5,
                title:'归还时间',
                name:'returnTime ',
            },
            {
                width:width6,
                title:'状态',
                name:'allow',
                selectFun:function (n,obj) {
                    if(obj.allow==0){
                        return "待批准借阅"
                    }else if(obj.allow==1){
                        return "已批准借阅"
                    }else if(obj.allow==2){
                        return "未批准借阅"
                    }else if(obj.allow==3){
                        return "已归还借阅"
                    }
                }
            },
            {
                width:width7,
                title:'操作',
                name:'orgAddress'
            }
        ],function (me) {
//            me.obj.codeId=$('[name="type"]').val();
            me.data.pageSize=10;
            //1显示  // 2不显示  //不写fn这个属性就是全显示
            me.init("/RmsLendController/selectLend",[
                {name:'详情'},
                // {name:'删除'},
            ],function () {
                $('#pageTbody').on('click','.editAndDelete0',function(){
                    var lendId = pageObj.arrs[$(this).attr('data-i')].lendId;
                    $.popWindow('/RmsLendController/ratify?lendId='+lendId);
                });
                $('#pageTbody').on('click','.editAndDelete1',function(){
                    var lendId = pageObj.arrs[$(this).attr('data-i')].lendId;
                    layer.confirm(qued,{
                        btn: [sure,cancel], //按钮
                        title:'确定删除？'
                    }, function(){
                        $.ajax({
                            type:'post',
                            url:'/RmsLendController/deleteFlag',
                            dataType:'json',
                            data:{'lendId':lendId},
                            success: function (json) {
                                //第三方扩展皮肤
                                layer.msg('<fmt:message code="workflow.th.delsucess" />', {icon: 6});
                                location.reload();
                            }
                        })
                    }, function () {
                        layer.closeAll();
                    })
                });
            });
        });
    });
</script>
</html>
