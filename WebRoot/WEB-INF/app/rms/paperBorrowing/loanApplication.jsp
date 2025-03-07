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
    <title>借阅申请</title>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>

<%--    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="../../js/news/page.js"></script>
    <script type="text/javascript" src="../../lib/layui/layui/lay/dest/layui.all.js"></script>
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
        .dbgz_page{
            margin-left: 800px!important;
        }
    </style>
</head>

<body>
<div class="bx">
    <div class="navigation  clearfix juMange" id="juMange" style="display: block;">
        <div class="left" style="margin-left: 30px;width: 40%">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_jieyueshenqing.png" style="margin-top: 20px">
            <div class="news">
                <span>借阅申请</span>
                <select name="" id="rollIdSelect" style="float: right;margin-top: -4px;">
                    <option value="">所有卷库</option>
                </select>
            </div>
        </div>
        <div class="navRight" style="margin-top: 30px;float: right">
            <span class="addSign" id="files" style="display: block;">案卷借阅申请</span>
            <span class="addSign" id="file" style="display: block;">文件借阅申请</span>
        </div>
        <div class="wrap" style="margin-left: 0;padding: 0 20px;margin-top: 70px;">
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
                        <fmt:message code="notice.th.operation"/>
                    </td>
                </tr>
                </thead>
                <tbody id="j_tb">

                </tbody>
            </table>
            <div id="pagediv">

            </div>
            <div class="right"><!-- 分页显示-->
                <div class="M-box3" id="dbgz_page"></div>
            </div>
        </div>
    </div>
</div>
<div class="divIframeThr iframeShow" id="iframeShow" style="width: 100%;height: 100%;display: none;">
    <iframe src="" id="iframeThr" style="width: 100%;height: 100%;" frameborder="0"></iframe>
</div>
</div>
<script type="text/javascript">
    var dataId={
        page:1,//当前处于第几页
        pageSize:10,//一页显示几条
        roomId:''
    };
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
                $('#rollIdSelect').append(str);
            }
        });
        dataList(dataId,$('#j_tb'));
        // 点击跳转详情
        $('#j_tb').on('click','.to_detail',function(){
            $.popWindow("/rmsRoll/detail?rollId="+$(this).parent().attr("data-id"));
        });
//        按卷库查询
        $('#rollIdSelect').on('change',function(){
            var seleId=$(this).find('option:selected').val();
            var data={
                page:1,//当前处于第几页
                pageSize:10,//一页显示几条
                roomId:seleId
            };
            dataList(data,$('#j_tb'));
        });
//        点击借阅
        $('#j_tb').on('click','.lookFile',function () {
            var rollId=$(this).parents('tr').attr('data-id');
//            $('#juMange').hide();
//            $('#iframeShow').show();
            $.popWindow('/RmsLendController/lendingOperations?rollId='+rollId);
//            $('#iframeThr').attr('src','/RmsLendController/seeFile?rollId='+rollId);
        })
    })

    function dataList(dataId,element) {
        var ajaxPage={
            data:dataId,
            page:function () {
                var me=this;
                $.ajax({
                    type:'get',
                    url:'/rmsRoll/query',
                    dataType:'json',
                    data:me.data,
                    success:function(res) {
                        var datas=res.obj;
                        var str='';
                        if(datas.length > 0){
                            for(var i=0;i<datas.length;i++){
                                var certificateName='';
                                if(datas[i].certificateKind == '1'){
                                    certificateName='XXX1';
                                }else if(datas[i].certificateKind == '2'){
                                    certificateName='XXX2';
                                }
                                var secretName='';
                                if(datas[i].secret == '1'){
                                    secretName=dem_th_PuDense;
                                }else if(datas[i].secret == '2'){
                                    secretName=doc_th_TopSecret;
                                }else if(datas[i].secret == '3'){
                                    secretName=doc_th_Confidential;
                                }else if(datas[i].secret == '4'){
                                    secretName=doc_th_Secret;
                                }
                                var statusName='';
                                if(datas[i].status == '0'){
                                    statusName=doc_th_Unsealed;
                                }else if(datas[i].status == '1'){
                                    statusName=doc_th_sealed;
                                }
                                str+='<tr data-id="'+datas[i].rollId+'" data-status="'+datas[i].status+'">' +
                                    '<td>'+datas[i].rollCode+'</td>' +
                                    '<td>'+datas[i].rollName+'</td>' +
                                    '<td>'+datas[i].roomName+'</td>' +
                                    '<td>'+datas[i].categoryNo+'</td>' +
                                    '<td>'+certificateName+'</td>' +
                                    '<td>'+secretName+'</td>' +
                                    '<td>'+statusName+'</td>' +
                                    '<td><a href="javascript:;" class="lookFile" style="margin-right: 10px;">借阅</a></td>' +
                                    '</tr>'
                            }
                        }else {
                            str='<tr>' +
                                '<td colspan="8"><img src="/img/rms/shouyekong.png" alt=""><p>暂无数据</p></td>' +
                                '</tr>'
                        }


                        element.html(str);
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
    $('#file').on('click',function () {
        $('.M-box3').hide();
        $('#tr_td').css('display','none')
        $('#rollIdSelect').css('display','none')
        $('#pagediv').css('display','')
        $(function () {
            var screenwidth = document.documentElement.clientWidth;
            // console.log(screenwidth*0.9)
            if (screenwidth  > 1600) {
                var nums = screenwidth * 0.97;
                var sumwidth = screenwidth * 0.97 + 'px';
            } else {
                var nums = 1220;
                var sumwidth = '1220px';
            }
            var width0 = nums * 0.015 + 'px';
            var width1 = nums * 0.035 + 'px';
            var width2 = nums * 0.035 + 'px';
            var width3 = nums * 0.035 + 'px';
            var width4 = nums * 0.035 + 'px';
            var width5 = nums * 0.035 + 'px';
            var width6 = nums * 0.035 + 'px';
            pageObj=$.tablePage('#pagediv',sumwidth,[
                {
                    width:width0,
                    title:'',

                },
                {
                    width:width1,
                    title:'文件名称',
                    name:'fileTitle'
                },
                {
                    width:width2,
                    title:'文件编号',
                    name:'fileCode'
                },
                {
                    width:width3,
                    title:'所属案卷',
                    name:'rollName'
                },
                {
                    width:width4,
                    title:'创建时间',
                    name:'addTime',
                    selectFun:function (addTime) {
                        if(addTime && addTime !=''){
                            return new Date(addTime).Format('yyyy-MM-dd hh:mm:ss');
                        } else {
                            return '';
                        }
                    }
                },
                {
                    width:width5,
                    title:'发文单位',
                    name:'sendUnit'
                },
                {
                    width:width6,
                    title:'操作',
                    name:'orgAddress'
                }
            ],function (me) {
//            me.obj.codeId=$('[name="type"]').val();
                me.data.pageSize=10;
                me.data.delStatus=0;
                //1显示  // 2不显示  //不写fn这个属性就是全显示
                me.init("/RmsLendController/selectAndFile",[
                    {name:'借阅'},
                ],function () {
                    $('#pageTbody').on('click','.editAndDelete0',function() {
                        var fileId = pageObj.arrs[$(this).attr('data-i')].fileId;
                        $.popWindow('/RmsLendController/documentLibrary?fileId=' + fileId);
                    })
                });
            })
        })
    })
    $('#files').on('click',function () {
        $('.M-box3').show();
        $('#tr_td').css('display','')
        $('#rollIdSelect').css('display','')
        $('#pagediv').css('display','none')
        dataList();
    })
</script>
</body>
</html>
