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
    <title>案卷统计</title>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <script src="/js/common/language.js"></script>
<%--    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/laydate.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/js/jquery/jquery.form.min.js"></script>
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
            width: 260px;
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
        #tr_td tr:nth-child(odd){
            background-color: #fff;
        }

        #tr_td .th{
            font-size: 13pt;
            text-align: center;
        }
        #j_tb tr td {
            font-size: 11pt;
            text-align: center;
        }

    </style>
</head>

<body>
<div class="bx">
    <div class="navigation  clearfix juMange" id="juMange" style="display: block;">
        <div class="left" style="margin-left: 30px">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_anjuanTongji.png">
            <div class="news">
                <span>案卷统计</span>
                <select name="rollIdSelect" id="selectq">
                    <option value="">所有卷库</option>
                </select>
            </div>
        </div>
        <div class="wrap" style="margin-left: 0;padding: 0 20px;">
            <table id="tr_td">
                <thead>
                <tr>
                    <td class="th">
                        <fmt:message code="dem.th.FileNumber"/>
                    </td>
                    <td class="th">
                        <fmt:message code="dem.th.FileName"/>
                    </td>
                    <td class="th">
                        <fmt:message code="dem.th.CoilingLibrary"/>
                    </td>
                    <td class="th">
                        <fmt:message code="dem.th.FondsNumber"/>
                    </td>
                    <td class="th">
                        <fmt:message code="dem.th.CertificateCategory"/>
                    </td>
                    <td class="th">
                        <fmt:message code="dem.th.FileSecurity"/>
                    </td>
                    <td class="th">
                        <fmt:message code="vote.th.FileStatus"/>
                    </td>
                    <td class="th" style="width: 220px;">
                        文件个数
                    </td>
                </tr>
                </thead>
                <tbody id="j_tb">

                </tbody>
            </table>
            <div class="right"><!-- 分页显示-->
                <div class="M-box3" id="dbgz_page"></div>
            </div>
        </div>
    </div>

    <%--<div class="divIframeThr iframeShow" id="iframeShow" style="width: 100%;height: 100%;display: none;">--%>
    <%--<iframe src="/rmsRoll/lookFile" id="iframeThr" style="width: 100%;height: 100%;" frameborder="0"></iframe>--%>
    <%--</div>--%>
</div>
<script type="text/javascript">

    $(function () {
        //        查询所有案卷
        $.ajax({
            type:'get',
            url:'/rmsRollRoom/selectAll',
            dataType:'json',
            success:function(res){
                var datas=res.obj;
                var str='';
                for(var i=0;i<datas.length;i++){
                    str+='<option value="'+datas[i].roomId+'">'+datas[i].roomName+'</option>'
                }
                $('#selectq').append(str);
            }
        });
        dataList('',$('#j_tb'));

//      点击跳转详情
        $('#j_tb').on('click','.to_detail',function(){
            $.popWindow("/rmsRoll/detail?rollId="+$(this).parent().attr("data-id"));
        });
//        改变卷库
        $('#selectq').on('change',function () {
            var seleId=$(this).find('option:selected').val();
            dataList(seleId,$('#j_tb'));
        });
    })

    function dataList(ids,element) {
        var ajaxPage={
            data:{
                page:1,//当前处于第几页
                pageSize:10,//一页显示几条
                roomId:ids
            },
            page:function () {
                element.find('tr').remove();
                var me=this;
                $.ajax({
                    type:'get',
                    url:'/RmsLendController/rollCount',
                    dataType:'json',
                    data:me.data,
                    success:function(res) {
                        var datas=res.obj;
                        var str='';
                        for(var i=0;i<datas.length;i++){
                            var certificateName='';
                            if(datas[i].certificateKind == '1'){
                                certificateName='XXX1';
                            }else if(datas[i].certificateKind == '2'){
                                certificateName='XXX2';
                            }
                            var secretName='';
                            if(datas[i].secret == '1'){
                                secretName='<fmt:message code="dem.th.PuDense" />';
                            }else if(datas[i].secret == '2'){
                                secretName='<fmt:message code="doc.th.Top-secret" />';
                            }else if(datas[i].secret == '3'){
                                secretName='<fmt:message code="dem.th.Confidential" />';
                            }else if(datas[i].secret == '4'){
                                secretName='<fmt:message code="dem.th.Secret" />';
                            }
                            var statusName='';
                            if(datas[i].status == '0'){
                                statusName=doc_th_Unsealed;
                            }else if(datas[i].status == '1'){
                                statusName=doc_th_sealed;
                            }
                            str+='<tr data-id="'+datas[i].rollId+'" data-status="'+datas[i].status+'">' +
                                '<td class="to_detail" style="color:#1687cb;cursor: pointer">'+datas[i].rollCode+'</td>' +
                                '<td>'+datas[i].rollName+'</td>' +
                                '<td>'+datas[i].roomName+'</td>' +
                                '<td>'+datas[i].categoryNo+'</td>' +
                                '<td>'+certificateName+'</td>' +
                                '<td>'+secretName+'</td>' +
                                '<td>'+statusName+'</td>' +
                                '<td>'+datas[i].anjuanCount+'</td>' +
                                '</tr>'
                        }

                        element.append(str);
                        me.pageTwo(res.totleNum,me.data.pageSize,me.data.page)
                    }
                })

            },
            pageTwo:function (totalData, pageSize,indexs) {
                var mes=this;
                $('#dbgz_page').pagination({
                    totalData: totalData,
                    showData: pageSize,
                    jump: true,
                    coping: true,
                    homePage:'',
                    endPage: '',
                    current:indexs||1,
                    callback: function (index) {
                        mes.data.page=index.getCurrent();
                        mes.page();
                    }
                });
            }
        };
        ajaxPage.page();
    }
</script>
</body>
</html>
