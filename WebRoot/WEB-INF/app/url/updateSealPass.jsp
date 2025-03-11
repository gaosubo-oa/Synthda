
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="url.th.sealPasswordModification" /></title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <link rel="stylesheet" href="/css/style.css">
    <script src="/js/common/language.js"></script>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css">
    <script src="/js/document/dialog.js"></script>
    <script src="/js/workflow/work/Loadwebsign.js"></script>
    <style>
        table tbody td{
            text-align: left!important;
        }
        input{
            float: none;
        }
        .editAndDelete3{
            color: red;
        }
        .newClass{
            float: right;
            width: 90px;
            height: 28px;
            background: url(../../img/file/cabinet01.png) no-repeat;
            color: #fff;
            font-size: 14px;
            line-height: 28px;
            margin: 2%  3% 0 0;
            cursor: pointer;
        }
        .delete_check {
            display: inline-block;
            width: 70px;
            height: 28px;
            position: relative;
            color: #ffffff;
            border-radius: 3px;
            background: #2b7fe0;
            text-align: center;
            line-height: 28px;
            margin-left: 20px;
        }
        .editAndDelete2{
            color: red;
        }
        .pagediv .page-bottom-outer-layer table td:last-child{
            border-right: 1px #dddddd solid;
        }
        .page-top-inner-layer{
            padding: 0!important;
        }
        table tr td,table tr th{
            text-align: center !important;
        }
        table tr td:last-child{
            width:150px !important;
        }
        table tfoot tr td:last-child{
            text-align: left !important;
        }
        table tr th:last-child{
            width:150px !important;
        }

        #overlay {display: none; z-index: 10000; height:100%;BACKGROUND: #B5C5E0; filter: alpha(opacity=50);LEFT: 0px; POSITION: absolute; TOP: 0px; -moz-opacity:0.5;opacity:0.5;}

        .ModalDialog {border: 2px #1e5ca5 solid;background: #fff; padding: 0px;margin: 10px auto; clear: both; position: absolute;  z-index: 10000;display:none;}
        .ModalDialog1 {border: 1px solid rgba(0, 0, 0, 0.3);-webkit-border-radius: 6px;border-radius: 6px;outline: none;-webkit-box-shadow: 0 3px 7px rgba(0, 0, 0, 0.3);background: #fff; padding: 0px;margin: 10px auto; clear: both; position: absolute;  z-index: 10000;display:none;}
        .header {color:#fff;overflow: hidden; font-weight: normal; background: url('../10/images/dialog_bg.png') left -35px repeat-x;height:28px;}
        .header .title {float:left;font-size: 16px;  font-weight: bold;line-height:28px;margin-left:10px;}
        .header .operation {padding-top: 8px;padding-right:5px; float: right; cursor: pointer; text-decoration: none;}
        .body {font-size: 9pt;margin: 0 !important; overflow-y: auto; padding: 10px 5px;}
        .footer {padding: 0; text-align: center; font-size: 12px; margin-bottom: 10px;}

        input.BigButtonAHover{width:60px;height:30px;height:27px !important;padding-bottom:3px;color:#000000;background:url("images/big_btn_a.png") no-repeat;border:0px;cursor:pointer;font-size:12pt;background-position:0 -30px;}
        input.BigButtonA{width:60px;height:30px;height:27px !important;padding-bottom:3px;color:#36434E;background:url("images/big_btn_a.png") no-repeat;border:0px;cursor:pointer;font-size:12pt;}
        input.BigButtonA:hover{background-position:0 -30px;}
    </style>
</head>
<body>
<div style="margin: 20px;font-size: 20px;"><fmt:message code="url.th.dianjuElectronicSeal" /></div>
<div id="pagediv" style="margin-top: 10px">

</div>
<div id="seal_pass" class="ModalDialog" style="width:400px;">
    <div class="header"><span id="title" class="title"> <fmt:message code="url.th.sealPasswordModification" /></span><a class="operation" href="javascript:HideDialog('seal_pass');"></a></div>
    <div id="seal_pass_body" class="body bodycolor">
<table class="TableBlock" width="90%" align="center">
    <tr>
        <td class="TableData" colspan=2 align="center">
            <OBJECT id=DMakeSealV61 style="left: 0px; top: 0px" classid="clsid:3F1A0364-AD32-4E2F-B550-14B878E2ECB1" VIEWASTEXT width=200 height=200 codebase='/lib/webSign/MakeSealV6.ocx#version=1,1,2,2'>
                <PARAM NAME="_Version" VALUE="65536">
                <PARAM NAME="_ExtentX" VALUE="2646">
                <PARAM NAME="_ExtentY" VALUE="1323">
                <PARAM NAME="_StockProps" VALUE="0">
            </OBJECT>          </td>
    </tr>
    <tr>
        <td class="TableContent" width=80><fmt:message code="document.th.SealId" /></td>
        <td class="TableData"><span id="seal_id"></span></td>
    </tr>
    <tr>
        <td class="TableContent"><fmt:message code="document.th.SealName" /></td>
        <td class="TableData"><span id="seal_name"></span></td>
    </tr>
    <tr>
        <td class="TableContent" ><fmt:message code="url.th.newPW" />：</td>
        <td class="TableData" >
            <input type="password" id="PASS1"  class="BigInput" size="20">
        </td>
    </tr>

    <tr>
        <td class="TableContent" ><fmt:message code="url.th.Confirm" />：</td>
        <td class="TableData" >
            <input type="password" id="PASS2"  class="BigInput" size="20">
        </td>
    </tr>
    <tr class="TableControl">
        <td class="TableData" colspan=2 align=center>
            <input type="hidden" id="SID" value="">
            <input type="hidden" id="SEAL_DATA" value="">
            <input type="button" onclick="mysubmit()" class=BigButton value="确认">
        </td>
    </tr>
</table>
</div>
</div>
</div>
</body>
<script>
var obj='';
var selId='';
var sealId='';
    function modifyPass(seal_id,seal_name)
    {
        obj = document.getElementById("DMakeSealV61");
        if(!obj){
            alert("尚未安装控件");
            return false;
        }

        clearSeal();
        show_info(seal_id);
    }
function show_info(ID)
{
        if(ID)
        {
            var obj = document.getElementById("DMakeSealV61");
            if(!obj){
                alert("控件加载失败！");
                return false;
            }
            if(0 == obj.LoadData(ID)){
                ShowDialog("seal_pass");

                var vID = 0;
                vID = obj.GetNextSeal(0);
                if(!vID){
                    return true;
                }
                if(obj.SelectSeal(vID)) return false;
                var vSealID = obj.strSealID;
                var vSealName = obj.strSealName;


                $("#seal_id").html(vSealID);
                $("#seal_name").html(vSealName);
                $("#SID").val(ID);
            }
            else{
                alert("读取印章数据失败");
                HideDialog('seal_pass');
            }
        }
        else{
            alert("无印章信息！");
            HideDialog('seal_pass');
        }
}
function mysubmit()
{
    if($("#PASS1").val() != $("#PASS2").val())
    {
        alert("两次密码不一致，请重新输入！");
        return;
    }
    obj.strOpenPwd = $("#PASS1").val();
    console.log(obj.strOpenPwd)

    $("#SEAL_DATA").val(obj.SaveData());
//    _post("set_seal.php","ID="+$("SID").value+"&SEAL_DATA="+$("SEAL_DATA").value.replace(/\+/g, '%2B')+"&PASS="+$("PASS1").value,function(req){
//        if(req.responseText!="err")
//        {
    $.ajax({
        type:'post',
        url:'/seal/updateSeal',
        dataType:'json',
        data:{
            'logType':'makeseal',
            'result':'修改密码成功',
            'sealData':$("#SEAL_DATA").val(),
            'id':selId,
            'sealId':sealId
        },
        success:function(json){
            alert("密码修改成功！");
            HideDialog('seal_pass');
            window.location.reload()
        }
    })

//            return;
//        }
//    });
}
function clearSeal()
{
    var vID = 0;
    do{
        vID = obj.GetNextSeal(vID);
        if(!vID)
            break;
        obj.DelSeal(vID);
    }while(vID);

    $("#seal_id").html('');
    $("#seal_name").html('');
    $("#SID").val('');
    $("#PASS1").val('');
    $("#PASS2").val('');
}


//    $(function () {

//表格初始化
        var pageObj=$.tablePage('#pagediv','100%',[
            {
                width:'12%',
                title:'<fmt:message code="document.th.SealId" />',
                name:'sealId'
            },
            {
                width:'12%',
                title:'<fmt:message code="document.th.SealName" />',
                name:'sealName'
            },
            {
                width:'12%',
                title:'<fmt:message code="doc.th.ScopeAuthorization" />',
                name:'userName'
            },
            {
                width:'12%',
                title:'<fmt:message code="notice.th.createTime" />',
                name:'createTime',
                selectFun:function (name,obj,i) {
                        return formatTime(name,'Y-M-D h:m:s')
                }
            },
            // {
            //     width:'12%',
            //     title:option
            // },
        ],function (me) {
//            me.data.typeId=$('[name="type"]').val();
//            me.data.changeId='1';
            //1显示  // 2不显示  //不写fn这个属性就是全显示
            me.init("/seal/getAllSealInfo",[
                // {name:notice_th_QueryStatus,fn:function (obj) {
                //     if(obj.publish==2||obj.publish==0){
                //         return 2
                //     }else {
                //         return notice_th_QueryStatus
                //     }
                // }},
                // {name:notice_state_end,fn:function (obj) {
                //     if(obj.publish==1){
                //         return '<span data-type="stop">'+notice_state_end+'</span>'
                //     }else if(obj.publish==4 || obj.publish==5){
                //         return '<span data-type="effective">'+notice_state_effective+'</span>'
                //     }else if(obj.publish==2||obj.publish==0){
                //         return 2
                //     }
                // }},
                {name:'修改密码'}
            ])
        })





        $('#pagediv').on('click','.editAndDelete0',function(){
            var ids=pageObj.arrs[$(this).attr('data-i')].sealData;
            selId=pageObj.arrs[$(this).attr('data-i')].id;
            sealId=pageObj.arrs[$(this).attr('data-i')].sealId;
            modifyPass(ids)
        })

        $('#pagediv').on('click','.editAndDelete2',function(){
            var delid = [];
            var id=pageObj.arrs[$(this).attr('data-i')].id;
            delid.push(id)
            // parent.$('[name="notices"]').attr('src','../../notice/newAndEdit?type=edit&notifyId='+notifyId)
            layer.confirm(qued, {
                btn: [sure,cancel] ,//按钮
                title:ifDelete
            }, function(){
                //确定删除，调接口
                $.ajax({
                    url: "/learningExperience/deleteLearningExperienceByIds",
                    type: "get",
                    data:{
                        'ids':delid
                    },
                    dataType: 'json',
                    success: function (json) {
                        if (json.flag) {
                            $.layerMsg({content: delc, icon: 1}, function () {
                                pageObj.init()
                            })
                        }
                    }
                })

            }, function(){
                layer.closeAll();
            });
        })

        function formatTime(number,format) {

            var formateArr  = ['Y','M','D','h','m','s'];
            var returnArr   = [];

            var date = new Date(number);
            returnArr.push(date.getFullYear());
            returnArr.push(formatNumber(date.getMonth() + 1));
            returnArr.push(formatNumber(date.getDate()));

            returnArr.push(formatNumber(date.getHours()));
            returnArr.push(formatNumber(date.getMinutes()));
            returnArr.push(formatNumber(date.getSeconds()));

            for (var i in returnArr)
            {
                format = format.replace(formateArr[i], returnArr[i]);
            }
            return format;
        }

        //数据转化
        function formatNumber(n) {
            n = n.toString()
            return n[1] ? n : '0' + n
        }
        $('.page-bottom-inner-layer').css('height',$('.page-bottom-inner-layer').height()-46+'px')
//    })
</script>
</html>
