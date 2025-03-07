<%--
  Created by IntelliJ IDEA.
  User: liruixu
  Date: 2017/6/14
  Time: 10:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="user.th.AddRoles" /></title>
    <link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">

    <style>
        .TableData input{
            vertical-align: middle;
        }
        .userData {
            display: none;
        }
        #delBtn {
            display: none;
        }
        .head .headli1_2{
            margin-top: -5px;
        }
    </style>
    <script type="text/javascript" src="../js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/js/common/language.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>

</head>
<body>
<div class="navigation  clearfix">
    <div class="left">
        <img src="../img/icon_addrole_06.png" alt="">
        <div class="news"><fmt:message code="depatement.th.Add/RemoveAuxiliaryDepartments" /></div>
        <div id="Confidential" style="display: inline-block"></div>
    </div>
</div>
<table class="tr_td" width="560" align="center">
    <tbody><tr class="TableData">
        <td nowrap="" width="80"><fmt:message code="notice.th.operation" />：</td>
        <td>
            <input type="radio" name="OPERATION" value="1" id="OPERATION0" checked=""><label for="OPERATION0"><fmt:message code="customer.detail.add" /><fmt:message code="sys.auxiliary.department" /></label>
            <input type="radio" name="OPERATION" value="0" id="OPERATION1"><label for="OPERATION1"><fmt:message code="menuSSetting.th.deleteMenu" /><fmt:message code="sys.auxiliary.department" /></label>
        </td>
    </tr>
    <tr>

        <td nowrap="" class="TableData"><fmt:message code="diary.th.body" />：</td>
        <td class="TableData" id="selUser">
            <input type="hidden" name="TO_ID" value="">
            <textarea cols="50" name="TO_NAME" rows="4" id="BigStatic" class="BigStatic" wrap="yes" readonly=""></textarea>
            <a href="javascript:;" class="orgAdd" ><fmt:message code="mailMonitoring.add" /></a>
            <a href="javascript:;" class="orgClear" ><fmt:message code="mailMonitoring.clear" /></a>
        </td>
        <td class="userData">
            <select name="" id="userInfo" style="width: 150px;height: 30px;">

            </select>
        </td>
    </tr>
    <tr class="TableData">
        <td nowrap=""><fmt:message code="hr.th.department" />：
            <%--<a href="javascript:select_all();"><u>全选</u></a>--%>
        </td>
        <td class="tadata" id="selqx">
        </td>
    </tr>
    <tr class="TableControl">
        <td colspan="2" align="center">
            <input type="button" value='<fmt:message code="menuSSetting.th.menusetsure" />' class="import" id="importBtn">
            <input type="button" value='<fmt:message code="menuSSetting.th.menusetsure" />' class="import" id="delBtn">
        </td>
    </tr>
    <input type="hidden" name="USER_PRIV_STR" value="">
    <input type="hidden" name="DEPT_ID" value="">
    </tbody>
</table>
<p style="width: 565px;margin: 20px auto;color: red"><fmt:message code="sys.auxiliary.department.text"/></p>



<script>
    function jump(me){
        parent.newjump($(me).attr('data-Url'))
    }
    /**
     * Created by liruixu on 2017/6/16.
     */
    var user_id='';

    $(function () {
        var urlbool={
            urlstr:null,
            init:function () {
                var me=this;
                $.get('/department/getAlldept?resultFlag=simple',function (json) {
                    me.ajaxdata(json);
                },'json')
            },
            ajaxdata:function (date) {
                if(date.flag){
                    var str=''
                    for(var i=0;i<date.obj.length;i++){
                        str+='<label><input type="checkbox" name="chesk" value="'+date.obj[i].deptId+'">'+date.obj[i].deptName+'</label>&nbsp;'
                    }
                    $('.tadata').html(str)
                }
            }
        }
        urlbool.init()

        $('.orgAdd').on("click",function () {
            user_id = $(this).prev().prop('id');
            $.popWindow("/common/selectUser");
        })
        $('.orgClear').on("click",function () {
            $("#BigStatic").val("").attr({
                'username':'',
                'dataid':'',
                'user_id':'',
                'userprivname':''
            });
        })
        $('#importBtn').on("click",function () {
            var userId = $('textarea').attr('user_id');
            if(!userId) {
                alert('请选择人员')
                return
            }
            var obj={};
            obj.sign=$('[name="OPERATION"]:checked').val();
            obj.deptIds=''
            $('[name="chesk"]:checked').each(function (i,n) {
                obj.deptIds+=$(this).val()+','
            })
            obj.userId=userId;
            $.post('/department/updateOtherDeptByUserIds',obj,function (json) {
                if(json.flag){
                    $.layerMsg({content:menuSSetting_th_editSuccess ,icon:1},function () {
                        // parent.newjump('')
                       location.reload()
                    })
                }
            },'json')
        })
//    新增能辅助部门
        $('#OPERATION0').on("click",function() {
            $('#selUser').css('display','block');
            $('.userData').css('display','none');
            $('#importBtn').css('display','block');
            $('#delBtn').css('display','none');
            urlbool.init()
        })
//    删除辅助部门
        $('#OPERATION1').on("click",function() {
            $('#selUser').css('display','none');
            $('.userData').css('display','block');
            $('#importBtn').css('display','none');
            $('#delBtn').css('display','block');
            $('#selqx').empty();
            $.ajax({
                url:"/userPriv/selectHaveDept",
                success:function(res) {
                    if(res.flag) {
                        renderSelect(res.data,$('#userInfo'));
                    }
                }
            })
        })
        //渲染下拉选择框
        function renderSelect(list,dom) {
            dom.empty();
            if(list.length <= 0) {
                dom.html('');
                return
            }
            let str = "<option value=''>请选择</option>"
            for(let i = 0; i < list.length; i++) {
                str += '<option value='+list[i].userId+'>'+list[i].userName+'</option>'
            }
            dom.html(str);
        }
        //渲染部门
        function renderData(list,dom) {
            dom.empty();
            let str = "";
            for(let i = 0; i < list.length; i++) {
                str+='<label><input type="checkbox" checked name="chesk" value="'+list[i].deptId+'">'+list[i].deptName+'</label>&nbsp;'
            }
            dom.html(str);
        }
        //    选择人员
        $('#userInfo').on("change",function() {
            debugger
            const val = $(this).val();
            $.ajax({
                url:"/department/selectDeptOther",
                data:{
                    userId:val
                },
                success:function(res) {
                    if(res.flag) {
                        renderData(res.data,$('#selqx'))
                    }
                }
            })
        })
//    删除权限的保存按钮点击事件
        $('#delBtn').on("click",function() {
            let obj = {};
            obj.userId = $('#userInfo').val()
            obj.sign = $('#OPERATION1').val();
            obj.deptIds='';
            let doms = $('[name="chesk"]:checked');
            if(doms.length > 0) {
                doms.each(function (i,n) {
                    obj.deptIds+=$(this).val()+','
                })
            }

            $.post('/department/updateOtherDeptByUserIds',obj,function (json) {
                if(json.flag){
                    $.layerMsg({content:menuSSetting_th_editSuccess ,icon:1},function () {
                        // parent.newjump('')
                        location.reload()
                    })
                }
            },'json')
        })
    })
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
                var data=res.object[0]
                if (data.paraValue!=0){
                    $('#Confidential').append('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </span>')
                }
        }
    })
</script>
</body>
</html>
