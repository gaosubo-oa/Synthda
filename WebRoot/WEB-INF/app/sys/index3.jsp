
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/10/style2.css" />
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.min.js"></script>

   <%-- <script type="text/javascript" src="../js/sys/utility.js"></script>--%>



</head>




<body class="bodycolor">
<form action="batch_audit_man.php" name="form1" method="post" onsubmit="return check_form();">
    <table border="0" width="100%" cellspacing="0" cellpadding="3" class="small">
        <tr>
            <td class="Big"><img src="../../img/secure.png" style="margin-left: 10px;" align="absmiddle"><span class="big3"> <a name="bottom">批量设置保密邮件审核人</a></span>
            </td>
        </tr>
    </table>
    <table class="TableBlock" width="65%" align="center">
        <tr>
            <td class="TableContent" width="30%">操作类型</td>
            <td class="TableData" width="70%">
                <input type="radio" name="OPERATION_TYPE" id="OPERATION_TYPE1" value=1 checked><label for="OPERATION_TYPE1">添加</label>
                <input type="radio" name="OPERATION_TYPE" id="OPERATION_TYPE0" value=0 ><label for="OPERATION_TYPE0">减少</label>
            </td>
        </tr>
        <tr id="hide1">
            <td class="TableContent">审核人员&nbsp;&nbsp;(注:部门的审核人员至少为两人)</td>
            <td class="TableData">
                <div class="inPole"><textarea name="txt" id="userDuserSd" user_id="" value="" disabled style="min-width: 250px;min-height:50px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUserSd" class="Add ">添加</a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearUserSd" class="clearUserSd ">清空</a></span></div>
            </td>
        </tr>
        <tr id="hide2">
            <td class="TableContent">涉及部门</td>
            <td class="TableData">
                <div class="inPole"><textarea name="txt" id="userDept" userDept="" value="" disabled style="min-width: 250px;min-height:50px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectDept" class="Add ">添加</a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearDept" class="clearDept ">清空</a></span></div>
            </td>
        </tr>
        <tr class="TableControl" align="center">
            <td colspan=2 >
                <input type="submit" class="BigButton" name="submit" value="提交">
            </td>
        </tr>
    </table>
</form>
<table border="0" width="100%" cellspacing="0" cellpadding="3" class="small" id="title_table">
    <tr>
        <td class="Big"><img src="../img/sys/error.png" style="width:32px;height:32px;margin-left: 10px;" align="absmiddle"><span class="big3"><span class="big3"> <a name="bottom">部门审核人不符合信息</span>
        </td>
    </tr>
</table>
<table class="TableList" width="65%" align="center" id="info_table">
    <thead class="TableHeader" align="center">
    <td width="30%">部门名称</td>
    <td>保密邮件审核人</td>
    </thead>

</table>
</body>
<script>
    jQuery.noConflict();

    $("#selectUserSd").on("click",function(){
        user_id='userDuserSd';
        $.popWindow("../common/selectUser");
    });

    $('#clearUserSd').click(function(){ //清空人员
        $('#userDuserSd').attr('user_id','');
        $('#userDuserSd').attr('dataid','');
        $('#userDuserSd').val('');
    });


    $("#selectDept").on("click",function(){//选部门控件
        dept_id='userDept';
        $.popWindow("../common/selectDept");
    });
    $('#clearDept').click(function(){ //清空人员
        $('#userDept').attr('dept_id','');
        $('#userDept').attr('deptid','');
        $('#userDept').val('');
    });

    function check_form(){
        if(jQuery("input[name='OPERATION_TYPE']:checked").length == 0){
            alert("请选择操作类型");
            return false;
        }
        var s =  $('#userDuserSd').attr('user_id');
        var ss = s.split(",");
        if(s == ""){
            alert("请选择审核人员");
            return false;
        }
        else if (ss[1] =="") {
            alert("请至少选两个审核人员");
        }
        if($('#userDept').attr('dept_id') == ""){
            alert("请选择涉及部门");
            return false;
        }
        return true;
    }
</script>
<script>


</script>
</html>
