<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <title id="noticeTitles"></title>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" type="text/css" href="../lib/laydate/skins/default/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../css/dept/deptManagement.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/easyui/themes/easyui.css"/>
    <link rel="stylesheet" type="text/css" hcont_rigref="../lib/easyui/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../css/news/center.css"/>
    <script type="text/javascript" src="../../js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script>
        //添加人员
        function selPriv(id) {
            user_id=id;
            $.popWindow("../../common/selectUser");
        }
        function clearPriv(id) {
            $("#"+id).val("");
            $("#"+id).attr('user_id','');
            $("#"+id).attr('dataid','');
        }
    </script>
    <title><fmt:message code="notice.title.notify" /></title>
    <style>
        body{
            margin:0;
            padding:0;
            background-color:#f6f7f9;
        }
        table{
            border-collapse:collapse;
            border:1px solid #dedede;
            width:1100px;
            background-color:#ffffff;
            margin-left:45px;
            margin-top:35px;

        }
        td{
            border:1px solid #dedede;
            font-size:11pt;
        }
        textarea{
            height:56px;
            width:300px;
            background:#e0e0e0;
            margin:2px 0 0 2px;
        }
        .btn{
            width: 70px;
            height: 24px;
            margin:0 auto;
            padding:2px 0 2px 0;
            background: url("/img/confirm.png") no-repeat;

        }
        input{
            position:relative;
            top:-1px;
        }
        button{
            background: transparent;
            margin-left: 33px;
            line-height: 26px;
            font-size:11pt;
        }

        .add{
            color:#207bd6;
        }
        .empty{
            color:#9aa9b8;
        }
        .head{
            height:45px;
            border-bottom:1px solid #9E9E9E ;
        }
        h1{
            line-height: 45px;
            font-size: 22px;
        }
        input[type="checkbox"],input[type="radio"]{
            background: transparent;
            border: 0;
        }
    </style>
</head>
<body>
    <div class="head">
        <h1>
            <img style="margin-left: 30px;" src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_noticeMang.png" alt="">
            <a id="noticeTitle"></a>
<%--        <h2 id="noticeTitle"></h2>--%>
        </h1>
    </div>
    <table >
        <tr>
            <td width="400px" id="noticeTypes"></td>
            <td class="checkboxs">
                <input type="checkbox" id="noticeType" name="set-up" class="my_inputAll my_input" value="TYPE-"/>
                <a id="noticeTypeName"></a>
                <%--<input type="checkbox" name="decision" class="my_input" value="01-"/>决定--%>
                <%--<input type="checkbox" name="notice" class="my_input" value="02-">通知--%>
                <%--<input type="checkbox" name="bulletin" class="my_input" value="03-"/>通报--%>
                <%--<input type="checkbox" name="other" class="my_input" value="04-"/>其他--%>
            </td>
        </tr>
        <%--<tr>--%>
            <%--<td>审批设置</td>--%>
            <%--<td>--%>
                <%--<input type="checkbox" name="automatic" class="approve"/>自动选择审批人为本部门主管--%>
                <%--<br/>--%>
                <%--<input type="checkbox" name="approve" style="display:none" class="approve"/>--%>
                <%--&lt;%&ndash;审批公告时审批人可进行编辑&ndash;%&gt;--%>
            <%--</td>--%>
        <%--</tr>--%>
        <tr>
            <td>置顶时间(天数)</td>
            <td>
                <input type="text" class="dataNum" name="NOTIFY_TOP_DAYS" style="width: 100px;" value="0">
                <span>为空表示不限制置顶时间</span>
            </td>
        </tr>
        <tr>
            <td>指定可审批人员</td>
            <td>
                <textarea cols="45"  name="bookPriv" rows="3" id="bookPriv" class="bookPriv globalPriv" wrap="yes" readonly="" ></textarea>
                <a href="javascript:;" class="addBookPriv" onclick="selPriv('bookPriv')"><fmt:message code="global.lang.add" /></a>
                <a href="javascript:;" class="clearBookPriv" onclick="clearPriv('bookPriv')"><fmt:message code="global.lang.empty" /></a>
            </td>
        </tr>
        <tr>
            <td>指定可不经审批直接发布的人员</td>
            <td><textarea cols="45"  name="bookPriv" rows="3" id="bookPriv2" class="bookPriv globalPriv" wrap="yes" readonly="" ></textarea>
                <a href="javascript:;" class="addBookPriv" onclick="selPriv('bookPriv2')"><fmt:message code="global.lang.add" /></a>
                <a href="javascript:;" class="clearBookPriv" onclick="clearPriv('bookPriv2')"><fmt:message code="global.lang.empty" /></a>
            </td>
         </tr>
        <tr>
            <td colspan="2">
                <div class="btn">
                    <button><fmt:message code="main.th.confirm" /></button>
                </div>
            </td>
        </tr>
    </table>
    <script>
        var specifyTable= $.GetRequest()['notice_type'] || '';
        var paraName;
        var parentNo;
        $(function(){
            $.get("/myNotifyConfig/getNotifyType?noticeType="+specifyTable,function(res){
                $('#noticeTitles').text(res.data.mynotice_menu4_name)
                $('#noticeTitle').text(res.data.mynotice_menu4_name)
                $('#noticeTypeName').text('选择'+res.data.mynotice_type_name)
                $('#noticeTypes').text(res.data.mynotice_type_name+'(勾选为需要审批)')
                paraName = res.data.mynotice_top_dates
                parentNo = res.data.mynotice_type
                //        查询置顶天数
                $.ajax({
                    type:'get',
                    url:'/mySyspara/selectDemo',
                    dataType:'json',
                    data:{
                        paraName:paraName,
                        specifyTable:specifyTable
                    },
                    success:function (res) {
                        if(res.flag){
                            if(res.object.paraValue == ''){
                                $('input[name="NOTIFY_TOP_DAYS"]').val('');
                            }else{
                                $('input[name="NOTIFY_TOP_DAYS"]').val(res.object.paraValue);
                            }
                        }
                    }
                })
                $.get('/code/getCode?parentNo='+parentNo,function (json) {
                    if(json.flag){
                        var obj = json.obj;
                        var str = '';
                        $('.btn').attr('msg',json.msg);
                        for(var i=0;i<obj.length;i++){
                            str += '<input type="checkbox" name="decision" class="my_input" value="'+ obj[i].codeNo +'-"/>'+obj[i].codeName;
                        }
                        $('.checkboxs').append(str);
                        $.get('/mySys/selectNotify?specifyTable='+specifyTable,function (json) {
                            if(json.flag){
                                var arr=json.obj;
//                        if(arr[0].edit==1){
//                            $('[name="approve"]').prop('checked',true)
//                        }else{
//                            $('[name="approve"]').prop('checked',false)
//                        }
//                         if(arr[1].manager=='1'){
//                             $('[name="automatic"]').prop('checked',true)
//                         }else{
//                             $('[name="automatic"]').prop('checked',false)
//                         }
                                var arrtwo=arr[1].singls;
                                $('.my_input').each(function (i,n) {
                                    for(var m=i;m<arrtwo.length;m++){
                                        if(arrtwo[m]==1){
                                            $(this).prop('checked',true)
                                        }
                                        break;
                                    }
                                })
                                var user_id='';
                                var user_name='';
                                for(var i=0;i<arr[2].bookPriv.length;i++){
                                    user_id+=arr[2].bookPriv[i].userId+',';
                                    user_name+=arr[2].bookPriv[i].userName+','
                                }
                                $('#bookPriv').val(user_name);
                                $('#bookPriv').attr('user_id',user_id);

                                user_id='';
                                user_name='';
                                if(arr[3]&&arr[3].bookPriv2){
                                    for(var i=0;i<arr[3].bookPriv2.length;i++){
                                        user_id+=arr[3].bookPriv2[i].userId+',';
                                        user_name+=arr[3].bookPriv2[i].userName+','
                                    }
                                }

                                $('#bookPriv2').val(user_name);
                                $('#bookPriv2').attr('user_id',user_id);
                                //$("textarea").append('user_id',user_id)

                            }
                        },'json')
                    }
                });
            })
        })
//         $.get('/code/getCode?parentNo='+parentNo,function (json) {
//             if(json.flag){
//                 var obj = json.obj;
//                 var str = '';
//                 $('.btn').attr('msg',json.msg);
//                 for(var i=0;i<obj.length;i++){
//                     str += '<input type="checkbox" name="decision" class="my_input" value="'+ obj[i].codeNo +'-"/>'+obj[i].codeName;
//                 }
//                 $('.checkboxs').append(str);
//                 $.get('/mySys/selectNotify?specifyTable='+specifyTable,function (json) {
//                     if(json.flag){
//                         var arr=json.obj;
// //                        if(arr[0].edit==1){
// //                            $('[name="approve"]').prop('checked',true)
// //                        }else{
// //                            $('[name="approve"]').prop('checked',false)
// //                        }
// //                         if(arr[1].manager=='1'){
// //                             $('[name="automatic"]').prop('checked',true)
// //                         }else{
// //                             $('[name="automatic"]').prop('checked',false)
// //                         }
//                         var arrtwo=arr[1].singls;
//                         $('.my_input').each(function (i,n) {
//                             for(var m=i;m<arrtwo.length;m++){
//                                     if(arrtwo[m]==1){
//                                         $(this).prop('checked',true)
//                                     }
//                                     break;
//                             }
//                         })
//                         var user_id='';
//                         var user_name='';
//                         for(var i=0;i<arr[2].bookPriv.length;i++){
//                             user_id+=arr[2].bookPriv[i].userId+',';
//                             user_name+=arr[2].bookPriv[i].userName+','
//                         }
//                         $('#bookPriv').val(user_name);
//                         $('#bookPriv').attr('user_id',user_id);
//
//                         user_id='';
//                         user_name='';
//                         if(arr[3]&&arr[3].bookPriv2){
//                             for(var i=0;i<arr[3].bookPriv2.length;i++){
//                                 user_id+=arr[3].bookPriv2[i].userId+',';
//                                 user_name+=arr[3].bookPriv2[i].userName+','
//                             }
//                         }
//
//                         $('#bookPriv2').val(user_name);
//                         $('#bookPriv2').attr('user_id',user_id);
//                         //$("textarea").append('user_id',user_id)
//
//                     }
//                 },'json')
//             }
//         });



        $('.my_inputAll').on("click",function () {
            if($(this).is(':checked')){
                $(this).siblings('input').prop('checked',true)
            }else{
                $(this).siblings('input').prop('checked',false)
            }
        });
        $('.btn').on("click",function() {
            var obj={};
            var singls='';
            if($('input.my_input:checked').length>0){
              // singls='TYPE-,';
                $('input.my_input').each(function(){
                    if($(this).is(':checked')){
                        singls+=$(this).val()+'1,'
                    }else {
                        singls+=$(this).val()+'0,'
                    }

                })
            }else {
                //singls=$('.btn').attr('msg');
                $('input.my_input').each(function(){
                    singls+=$(this).val()+'0,'
                })

            }
            if($('[name="automatic"]').is(':checked')){
                obj.manager=1;
            }else {
                obj.manager=0;
            }
//            if($('[name="approve"]').is(':checked')){
//                obj.edit=1;
//            }else {
//                obj.edit=0;
//            }
            obj.edit=0;
            if($('#bookPriv').attr('user_id')!=undefined){
                obj.userIds=$('#bookPriv').attr('user_id')
            }else {
                obj.userIds='';
            }
            if($('#bookPriv2').attr('user_id')!=undefined){
                obj.exceptionUserIds=$('#bookPriv2').attr('user_id')
            }else {
                obj.exceptionUserIds='';
            }
            obj.singls=singls;
            obj.specifyTable=specifyTable;
            $.ajax({
                type: "post",
                url: "/mySys/editNotify",
                data:obj,
                dataType: "json",
                success: function(data){
                    //console.log(obj)
                    window.alert('<fmt:message code="event.th.SubmitSuccessfully" />！')
                    location.reload();
                }
            });
            $.ajax({  //设置公告置顶天数
                type:'post',
                url:'/mySyspara/updateDemo',
                dataType:'json',
                data:{
                    paraName:paraName,
                    paraValue:$('input[name="NOTIFY_TOP_DAYS"]').val(),
                    specifyTable:specifyTable
                },
                success:function (res) {
                    if(res.flag){

                    }else{
                        layer.msg('修改失败！',{icon:2});
                    }
                }
            })
        });

    </script>
</body>
</html>
