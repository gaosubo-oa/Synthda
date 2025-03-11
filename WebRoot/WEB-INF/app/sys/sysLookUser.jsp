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
<head>
    <meta charset="UTF-8">
    <title>用户信息</title>
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../css/sys/addUser.css"/>
    <script src="/js/common/language.js"></script>
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="../lib/laydate/laydate.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/base.js?20191018" type="text/javascript" charset="utf-8"></script>
    <script src="../js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js?20230216.2"></script>

    <style>
        .clearfix:after {
            content: '';
            display: block;
            clear: both;
        }

        .fl {
            float: left;
        }

        textarea {
            min-width: 204px;
            min-height: 50px;
            width: 204px;
            height: 50px;
            color: #555;
        }

        #signBtn {
            cursor: pointer;
            background-color: #6299d9;
            padding: 2px 5px;
            border-radius: 4px;
            color: #fff;
        }
        *:focus-visible {
            outline: none;
        }
        .operation {
            display: none;
        }
        .unloading {
            display: none;
        }
    </style>
</head>
<body>
<div class="content">
    <div class="title" style="margin-top: 20px;">
        <span class="titleTxt">用户信息</span>
        <span class="subText" style="font-family: Microsoft yahei; font-weight: bolder; font-size: 12pt; color:red; display: none;">机密级★</span>
    </div>
    <table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff">
        <tr>
            <td colspan="2" style="color: #3eb1f0"><fmt:message code="user.th.UserBasicInformation"/></td>
        </tr>
        <tr>
            <td width="15%"><fmt:message code="global.lang.user"/>：</td>
            <td width="70%">
                <input type="text" name="userId" data-options="required:true"/>
                <span style="color: #ff0000;font-size: 10pt;" class="span1"></span>
            </td>
        </tr>
        <tr style="display: none" class="qipilang">
            <td width="15%">用户ID：</td>
            <td width="70%">
                <input type="text" name="userId2" data-options="required:true" />
                <span style="color: #ff0000;font-size: 10pt;" class="span1"></span>
            </td>
        </tr>
        <tr>
            <td width="15%"><fmt:message code="userManagement.th.Realname"/>：</td>
            <td width="70%">
                <input type="text" name="userName" data-options="required:true"/>
            </td>
        </tr>
        <tr class="bindYu" style="display: none">
            <td width="15%">绑定域用户：</td>
            <td width="70%">
                <input type="text" name="domainUserName" data-options="required:true"/>
            </td>
        </tr>

        <tr>
            <td width="15%"><fmt:message code="user.th.UserNumber"/>：</td>
            <td width="70%">
                <input type="text" id = "number" name="userNo" value="10">
            </td>
        </tr>

        <tr>
            <td width="15%"><fmt:message code="url.th.Leading"/>：</td>
            <td width="70%">
                <input type="text" name="txtsenduser" id="senduser1" readonly="" user_id='' value="">
            </td>
        </tr>
        <tr id="fuzhuPriv" style="display: none">
            <td width="15%"><fmt:message code="userDetails.th.AuxiliaryRole"/>：</td>
            <td width="70%">
                <textarea name="txtsendusers" id="sendusers" readonly="" user_id='' value=""></textarea>
                <span style="color: #ff0000;font-size: 10pt;"></span>
            </td>
        </tr>
        <tr>
            <td width="15%"><fmt:message code="userManagement.th.department"/>：</td>
            <td width="70%">
                <input type="text" id="department" name="deptId" style="width: 200px;">
            </td>
        </tr>
        <tr id="otherDept" style="display: none">
            <td width="15%"><fmt:message code="user.th.OtherDepartments"/>：</td>
            <td width="70%">
                <textarea name="departmentname" id="departments" readonly></textarea>
            </td>
        </tr>
        <tr>
            <td width="15%"><fmt:message code="hr.th.post"/>：</td>
            <td width="70%">
                <select name="jobId" style="width: 200px;">
                    <option value=""><fmt:message code="sys.th.fillPost"/></option>
                </select>
            </td>
        </tr>
        <tr>
            <td width="15%">岗级：</td>
            <td width="70%">
                <select name="jobLevel" style="width: 200px;">
                    <option value="">请选择岗级</option>
                </select>
            </td>
        </tr>
        <tr>
            <td width="15%"><fmt:message code="userDetails.th.post"/>：</td>
            <td width="70%">
                <select name="postId" style="width: 200px;">
                    <option value="0"><fmt:message code="sys.th.fillRet"/></option>
                </select>
            </td>
        </tr>
        <%--人员类型--%>
        <tr>
            <td width="15%">人员类型：</td>
            <td width="70%">
                <select name="employmentType" style="width: 200px;">
                    <option value="">请选择</option>
                </select>
            </td>
        </tr>
        <tr>
            <td width="15%"><fmt:message code="hr.th.IDNumber"/>：</td>
            <td width="70%">
                <input type="text" name="idNumber" value="">
                <span id="numberName" style="color: #ff0000;font-size: 10pt;"></span>
            </td>
        </tr>
        <tr class="userSecrecyInfo">
            <td width="15%">密级：</td>
            <td width="70%">
                <select name="userSecrecy" class="userSecrecy" style="width: 200px;">
                </select>
            </td>
        </tr>
        <tr class="eduService" style="display: none">
            <td width="15%">教育服务号：</td>
            <td width="70%">
                <input type="text" name="msn" value="">
            </td>
        </tr>
        <tr class="jiaoyu">
            <td width="15%"><fmt:message code="sys.th.planNo"/>：</td>
            <td width="70%">
                <input type="text" name="traNumber" value="">
            </td>
        </tr>
        <tr class="jiaoyu">
            <td width="15%"><fmt:message code="sys.th.subject"/>：</td>
            <td width="70%">
                <select name="" class="subject" name="subject">
                </select>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="color:#3eb1f0 "><fmt:message code="user.th.UserRights"/></td>
        </tr>
        <tr>
            <td width="15%"><fmt:message code="userManagement.th.ManagementScope"/>：</td>
            <td width="70%">
                <select name="postPriv">
                    <option value="0"><fmt:message code="sys.th.ThisDepartment"/></option>
                    <option value="1"><fmt:message code="url.th.all"/></option>
                    <option value="2"><fmt:message code="sys.th.DesignatedDepartment"/></option>
                </select>
            </td>
        </tr>
        <tr class="postDeptContainer" style="display: none;">
            <td width="15%"> 管理范围指定部门：</td>
            <td width="70%">
                <textarea name="postDept" id="postDept" readonly></textarea>
            </td>
        </tr>
        <tr>
            <td width="15%">内部邮箱容量：</td>
            <td width="70%">
                <input type="text" name="emailCapacity" value="100">
                <p style="display: inline-block">单位：MB</p>
            </td>
        </tr>
        <tr>
            <td width="15%">个人文件柜容量限制：</td>
            <td width="70%">
                <input type="text" name="folderCapacity" value="100">
                <p style="display: inline-block">单位：MB</p>
            </td>
        </tr>
        <tr id="otherOrg" style="display: none">
            <td width="15%">其他所属组织：</td>
            <td width="70%">
                <textarea name="mhOrg" id="mhOrg" readonly style="height: 50px;min-height: 50px;"></textarea>
            </td>
        </tr>
        <tr style="" class="otherOption">
            <td colspan="2">
                <table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 100%;margin-top:0;"></table>
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <div class="div_btn">
                    <input type="button" class="inpuBtn backCanBtn" style="padding-left: 28px;" id="btn2" onclick="backtn($(this))"
                           value="<fmt:message code="global.lang.close" />"/>
                </div>
            </td>
        </tr>
    </table>
</div>
<script>
    $("input").prop("readonly",true)
    $("textarea").prop("readonly",true)
    $("select").prop("disabled",true)
    function backtn(e) {
        window.close();
    }
    //判断页面是否需要显示机密级字样
    $.ajax({
        url:"/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ",
        success:function(res) {
            var data = res.object[0];
            if(data.paraValue == 1) {
                $(".subText").show()
            }else {
                $(".subText").hide()
            }
        }
    })
    // 查询系统默认主题
    selOaTheam()
    function selOaTheam() {
        var dtd = $.Deferred(); // 新建一个Deferred对象
        $.ajax({
            url: "/sys/getInterfaceInfo",
            type: 'get',
            dataType: "JSON",
            success: function (data) {
                if(data.flag){
                    $('select[name="THEME"]').val(data.object.theme);
                }
                // 改变状态
                dtd.resolve();
            }
        });
        return dtd.promise();
    }

    // 查询所有考勤类型
    selAttend()
    function selAttend() {
        var dtd = $.Deferred(); // 新建一个Deferred对象
        $.ajax({
            url: "/attendSet/selsectAttendSet",
            type: 'get',
            dataType: "JSON",
            success: function (data) {
                var data = data.obj;
                var str = '';
                for (var i = 0; i < data.length; i++) {
                    str += '<option value="' + data[i].sid + '">' + data[i].title + '</option>'
                }
                $('select[name="twoSele"]').append(str);
                // 改变状态
                dtd.resolve();
            }
        });
        return dtd.promise();
    }

    // 查询所有岗位
    function selJob(id) {
        var dtd = $.Deferred(); // 新建一个Deferred对象
        $.ajax({
            url: "/position/selectUserJob",
            type: 'get',
            dataType: "JSON",
            success: function (res) {
                var data = res.obj;
                var str = '';
                for (var i = 0; i < data.length; i++) {
                    if(data[i].jobId === id) {
                        str += '<option value="' + data[i].jobId + '" selected>' + data[i].jobName + '</option>'
                    }else {
                        str += '<option value="' + data[i].jobId + '">' + data[i].jobName + '</option>'
                    }

                }
                $('select[name="jobId"]').append(str);
                // 改变状态
                dtd.resolve();
            }
        });
        return dtd.promise();
    }

    // 获取岗级数据
    selJobLevel()
    function selJobLevel() {
        var dtd = $.Deferred(); // 新建一个Deferred对象
        $.get('/code/getCode', {parentNo: 'JOB_LEVEL'}, function (res) {
            if (res.obj && res.obj.length > 0) {
                var str = '';
                res.obj.forEach(function (item) {
                    str += '<option value="' + item.codeNo + '">' + item.codeName + '</option>';
                });
                $('select[name="jobLevel"]').append(str);
            }
            // 改变状态
            dtd.resolve();
        });

        return dtd.promise();
    }
    function inputcheck(name,value) {
        $('[name="'+name+'"]').val(value)
    }
    // 查询所有职务
    function selPost(id) {
        var dtd = $.Deferred(); // 新建一个Deferred对象
        $.ajax({
            url: "/duties/selectUserPostList",
            type: 'get',
            dataType: "JSON",
            success: function (res) {
                var data = res.obj;
                var str = '';
                for (var i = 0; i < data.length; i++) {
                    if(data[i].postId) {
                        str += '<option value="' + data[i].postId + '" selected>' + data[i].postName + '</option>'
                    }else {
                        str += '<option value="' + data[i].postId + '">' + data[i].postName + '</option>'
                    }

                }
                $('select[name="postId"]').append(str);
                dtd.resolve();
            }
        });
        return dtd.promise();
    }

    // 查询所有人员类型
    selEmploymentType()
    function selEmploymentType() {
        var dtd = $.Deferred(); // 新建一个Deferred对象
        $.ajax({
            url: "/code/getCode",
            type: 'get',
            data:{parentNo:'staffType'},
            dataType: "JSON",
            success: function (res) {
                var data = res.obj;
                var str = '';
                for (var i = 0; i < data.length; i++) {
                    str += '<option value="' + data[i].codeNo + '">' + data[i].codeName + '</option>'
                }
                $('select[name="employmentType"]').append(str);

                dtd.resolve();
            }
        });
        return dtd.promise();
    }
    function checkboxChecked(name,value) {
        if(value==1){
            $('[name="'+name+'"]').prop('checked',true)
        }
    }
    //        获取学科控件
    function getYear(year,id){
        $.ajax({
            url:'/code/getCode',
            type:'get',
            data:{parentNo:'COURSE_REALM'},
            dataType:'json',
            //data:datas,
            success:function(reg){
                var datas=reg.obj;

                for (var i=0;i<datas.length;i++){
                    if(datas[i].codeOrder == id) {
                        str='<option value="'+datas[i].codeOrder+'" selected>'+datas[i].codeName+'</option>';
                    }else {
                        str='<option value="'+datas[i].codeOrder+'">'+datas[i].codeName+'</option>';
                    }
                    $(year).append(str);
                }

            }
        })
    }
    function radiochecked(name,value) {
        $('[name="'+name+'"]').each(function (i,n) {
            if($(this).val()==value){
                $(this).prop('checked',true)
                return false
            }
        })
    }
    $.get('/user/getUserByuid',{'uid':location.href.split('?')[1].split('&')[0]},function (json) {
        console.log(json,'json')
        if(json.flag){
            $('input[name="password"]').val('')
            if(json.object.deptYj!=undefined){
                if(json.object.deptYj.indexOf(",")!=-1) {
                    deptYj = json.object.deptYj.split(",");
                }else{
                    deptYj = "";
                }}else{
                deptYj = "";
            }
            $.ajax({
                url:"/code/getCode?parentNo=USER_SECRECY",
                success:function(res) {
                    var data = res.obj;
                    var str = "";
                    for(var i = 0; i < data.length; i++) {
                        if(data[i].codeNo === json.object.userSecrecy) {
                            str += '<option selected value="'+data[i].codeNo+'">'+data[i].codeName+'</option>'
                        }else {
                            str += '<option value="'+data[i].codeNo+'">'+data[i].codeName+'</option>'
                        }

                    }
                    $('.userSecrecy').html(str)
                }
            })
            //回显岗位数据
            selJob(json.object.jobId);
            selPost(json.object.postId);
            getYear('.subject',json.object.subject);
            $("#department").val(json.object.deptName)
            inputcheck('userId2',json.object.userId)
            inputcheck('userId',json.object.byname)
            inputcheck('userName',json.object.userName)
            inputcheck('txtsenduser',json.object.userPrivName)
            inputcheck('txtsendusers',json.object.userPrivOtherName)
            inputcheck('userNo',json.object.userNo)
            if(json.object.postPriv == 2) {
                $('.postDeptContainer').show();
            }
            $('#postDept').attr("deptid",json.object.modulePriv.deptId)
            $('#postDept').val(json.object.modulePriv.deptName)
            postDept = json.object.modulePriv.deptId;
            userSecrecy = json.object.userSecrecy
            inputcheck('postPriv',json.object.postPriv)
            inputcheck('idNumber',json.object.idNumber)
            inputcheck('traNumber',json.object.traNumber)
            if(json.object.domainUserName != null && json.object.domainUserName != undefined){
                $('.bindYu').css('display','table-row')
                $('input[name="domainUserName"]').val(json.object.domainUserName)
            }else{
                $('.bindYu').css('display','none')
            }
            $('.subject option[value='+json.object.subject+']').attr('selected',true)

            document.title = updateUser;
            $('.newname').text(window.opener.userstr);
            if(json.object.attachment!=undefined&&json.object.attachment.length>0&&json.object.attachment!=""){
                $('.showSign').show();
                $('.showSign img').attr('src','/xs?'+encodeURI(json.object.attachment[0].attUrl));
                $('.signImageId').val(json.object.signImageId)
                $('.signImageName').val(json.object.signImageName)
                $('#signBtn').hide();
                $('#uploadinputimg').hide();
            }else{
                $('.showSign').hide();
                $('#signBtn').show();
                $('#uploadinputimg').show();
            }
            if(json.object.userPrivOtherName == ''){
                $('#fuzhuPriv').hide();
            }else{
                $('#fuzhuPriv').show();
            }
            if(json.object.userPrivOtherName == ''){
                $('#otherDept').hide();
            }else{
                $('#otherDept').show();
            }
            deptidnum=json.object.deptId;
            $('[name="txtsenduser"]').attr('userPriv',json.object.userPriv+',')
            $('[name="txtsendusers"]').attr('userpriv',json.object.userPrivOther)

            if(json.object.modulePriv.userName != undefined && json.object.modulePriv.userName != ''){
                $('#anUser').show();
            }else{
                $('#anUser').hide();
            }

            if(json.object.modulePriv.deptName != undefined && json.object.modulePriv.deptName != '' ){
                $('#anDept').show();
            }else{
                $('#anDept').hide();
            }

            checkboxChecked('notViewUser',json.object.notViewUser)
            checkboxChecked('notViewTable',json.object.notViewTable)
            checkboxChecked('useingKey',json.object.useingKey)
            checkboxChecked('usingFinger',json.object.usingFinger)
            radiochecked('notLogin',json.object.notLogin)
            radiochecked('simpleInterface',json.object.simpleInterface)
            radiochecked('notMobileLogin',json.object.notMobileLogin)
            inputcheck('imRange',json.object.imRange)
            inputcheck('twoSele',json.object.userExt.dutyType)
            inputcheck('emailCapacity',json.object.userExt.emailCapacity)
            inputcheck('folderCapacity',json.object.userExt.folderCapacity)
            checkboxChecked('usePop3',json.object.userExt.usePop3)
            checkboxChecked('useEmail',json.object.userExt.useEmail)
            inputcheck('webmailNum',json.object.userExt.webmailNum)
            inputcheck('webmailCapacity',json.object.userExt.webmailCapacity)
            inputcheck('txtbindIp',json.object.userExt.bindIp)
            inputcheck('txtremark',json.object.userExt.remark)
            inputcheck('sex',json.object.sex)
            inputcheck('birthday',json.object.birthday)
            checkboxChecked('isLunar',json.object.isLunar)
            checkboxChecked('mobilNoHidden',json.object.mobilNoHidden)
            inputcheck('mobilNo',json.object.mobilNo)
            inputcheck('email',json.object.email)
            inputcheck('telNoDept',json.object.telNoDept)
            inputcheck('txtPrivName',json.object.modulePriv.privName)
            $('[name="txtPrivName"]').attr('userpriv',json.object.modulePriv.privId)
            inputcheck('txtUserName',json.object.modulePriv.userName)
            $('[name="txtUserName"]').attr('user_id',json.object.modulePriv.userId)
            inputcheck('txtDeptName',json.object.modulePriv.deptName)
            $('[name="txtDeptName"]').attr('deptid',json.object.modulePriv.deptId)
            $('[name="roomNum"]').val(json.object.roomNum)
            inputcheck('departmentname',json.object.deptOtherName)
            $('[name="departmentname"]').attr('deptid',json.object.deptIdOther)
            if(json.object.post!=undefined){
                inputcheck('post',json.object.post)
            }
            $('select[name="postId"]').val(json.object.postId)
            $('select[name="employmentType"]').val(json.object.userExt.employmentType)
            $('select[name="jobId"]').val(json.object.jobId)
            $('select[name="jobLevel"]').val(json.object.userExt.jobLevel)
            $('select[name="THEME"]').val(json.object.theme)
            if(json.object.uid==1){
                $('.addUserPriv').css("display","none")
                $('.clearUserPriv').css("display","none")
            }
            if(json.object.msn != undefined || json.object.msn != ''){
                inputcheck('msn',json.object.msn)//教育服务号
            }
            if(json.object.mhOrgName != undefined || json.object.mhOrgName != ''){
                inputcheck('mhOrg',json.object.mhOrgName)
                $('[name="mhOrg"]').attr('oid',json.object.mhOrg)
            }

            $.ajax({
                url:"department/getDepartmentYj",
                type:"get",
                dataType:"json",
                success:function(res){
                    if(res.flag){
                        var data = res.obj;
                        if(json.object.deptYj != undefined){
                            var deptYj = json.object.deptYj.split(',')
                            for(var i=0;i<data.length;i++){
                                for(var j=0;j<deptYj.length;j++){
                                    if(data[i].deptId == deptYj[j]){
                                        $('.checkChild').eq(i).attr('checked',true)
                                    }
                                }
                            }
                        }
                    }

                }

            })
        }else {
            alert(intelError)
        }
    },'json')
</script>
</body>
</html>
