/**
 * Created by 骆鹏 on 2017/6/26.
 */
var userSev = "";
var postDept = "";
var postDeptId = "";
function inputcheck(name,value) {
    $('[name="'+name+'"]').val(value)
}
function checkboxChecked(name,value) {
    if(value==1){
        $('[name="'+name+'"]').prop('checked',true)
    }
}
function radiochecked(name,value) {
    $('[name="'+name+'"]').each(function (i,n) {
        if($(this).val()==value){
            $(this).prop('checked',true)
            return false
        }
    })
}
var deptidnum,deptYj;
loadALLDeptSidebarurl='/getOrgList'
$(function () {

    $.get('/sys/getInterfaceInfo',function (json) {
        if(json.flag){
            if(json.object.loginValidation!=3){
                $('.jiaoyu').hide()
            }
        }
    },'json')


    $('.tdAnewrole').click(function () {
        if($($(this).parent().parent().siblings('.trrole')[0]).css('display')==='none'){
            $(this).parent().parent().siblings('.trrole').show()
        }else {
            $(this).parent().parent().siblings('.trrole').hide()
            // $('#senduser7').val('')
            // $('#senduser8').val('')
            // $('#senduser7').attr('dataid','')
            // $('#senduser8').attr('deptid','')

        }

    });

    $('.clearData').click(function () {
        $(this).siblings('textarea').val('')
        $(this).siblings('textarea').attr('userpriv','')
        $(this).siblings('textarea').attr('deptid','')
        $(this).siblings('input[name="txtsenduser"]').attr('userpriv','');
        $(this).siblings('input[name="txtsenduser"]').attr('privid','');
        $(this).siblings('input[name="txtsenduser"]').attr('user_id','');
        $(this).siblings('input[name="txtsenduser"]').val('');
    });
    $('.clearDataTwo').click(function () {
        $(this).parent().siblings('textarea').val('')
        $(this).parent().siblings('textarea').attr('userpriv','')
        $(this).parent().siblings('textarea').attr('deptid','')
        $(this).parent().siblings('textarea').attr('dataid','')
        $(this).parent().siblings('textarea').attr('user_id','')
    });



    //        获取学科控件
    function getYear(year){
        $.ajax({
            url:'/code/getCode',
            type:'get',
            data:{parentNo:'COURSE_REALM'},
            dataType:'json',
            //data:datas,
            success:function(reg){
                var datas=reg.obj;

                for (var i=0;i<datas.length;i++){
                    str='<option value="'+datas[i].codeOrder+'">'+datas[i].codeName+'</option>';
                    $(year).append(str);
                }

            }
        })
    }
    getYear('.subject');


    function isCardID(sId){
        var iSum=0 ;
        var info="" ;
        if(!/^\d{17}(\d|x)$/i.test(sId)) return fillError;
        sId=sId.replace(/x$/i,"a");
        if(aCity[parseInt(sId.substr(0,2))]==null) return feifa;
        sBirthday=sId.substr(6,4)+"-"+Number(sId.substr(10,2))+"-"+Number(sId.substr(12,2));
        var d=new Date(sBirthday.replace(/-/g,"/")) ;
        if(sBirthday!=(d.getFullYear()+"-"+ (d.getMonth()+1) + "-" + d.getDate()))return feiDate;
        for(var i = 17;i>=0;i --) iSum += (Math.pow(2,i) % 11) * parseInt(sId.charAt(17 - i),11) ;
        if(iSum%11!=1) return fillcard;
        //aCity[parseInt(sId.substr(0,2))]+","+sBirthday+","+(sId.substr(16,1)%2?"男":"女");//此次还可以判断出输入的身份证号的人性别
        return true;
    }

    $('[name="SUMMARY"]').click(function () {
        if(!$(this).is(':checked')){
            $(this).parent().parent().parent().siblings('.inthide').show()
        }else {
            $(this).parent().parent().parent().siblings('.inthide').hide();
            $(this).parent().parent().parent().siblings('.inthide').find('input')[0].value=-1
        }
    });

    $('.departmentbu').click(function () {
        if($(this).parent().parent().next().is(':hidden')){
            $(this).parent().parent().next().show()
        }else {
            $(this).parent().parent().next().hide();
        }
    });

    $('#selectUsertwo').click(function () {
        if($(this).parent().parent().next().is(':hidden')){
            $(this).parent().parent().next().show()
        }else {
            $(this).parent().parent().next().hide();
        }
    });


    // 初始化 查询考勤类型 岗位 职务数据 成功后调用根据UID查询接口 判断是否为编辑
    $.when(selOaTheam(),selJob(),selPost(),selEmploymentType(),selJobLevel()).then(function () {
        selUserById()
    })
});

// 查询系统默认主题
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
function selJob() {
    var dtd = $.Deferred(); // 新建一个Deferred对象
    $.ajax({
        url: "/position/selectUserJob",
        type: 'get',
        dataType: "JSON",
        success: function (res) {
            var data = res.obj;
            var str = '';
            for (var i = 0; i < data.length; i++) {
                str += '<option value="' + data[i].jobId + '">' + data[i].jobName + '</option>'
            }
            $('select[name="jobId"]').append(str);
            // 改变状态
            dtd.resolve();
        }
    });
    return dtd.promise();
}

// 获取岗级数据
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
//获取人员密级
function userSecrecy() {
    $.ajax({
        url:"/code/getCode?parentNo=USER_SECRECY",
        async:false,
        success:function(res) {
            var data = res.obj;
            var str = '';
            for(var i = 0; i < data.length; i++) {
                str += '<option value="'+data[i].codeNo+'">'+data[i].codeName+'</option>'
            }
            $('.userSecrecy').html(str)
        }
    })
}
userSecrecy()
// 查询所有职务
function selPost() {
    var dtd = $.Deferred(); // 新建一个Deferred对象
    $.ajax({
        url: "/duties/selectUserPostList",
        type: 'get',
        dataType: "JSON",
        success: function (res) {
            var data = res.obj;
            var str = '';
            for (var i = 0; i < data.length; i++) {
                str += '<option value="' + data[i].postId + '">' + data[i].postName + '</option>'
            }
            $('select[name="postId"]').append(str);
            dtd.resolve();
        }
    });
    return dtd.promise();
}

// 查询所有人员类型
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
            /*新建用户时默认显示【'01'】类型的人员类型*/
            if(seleId) {
                $('select[name="employmentType"] option').each(function () {
                    if($(this).val()=='01'){
                        $('select[name="employmentType"]').val($(this).val())
                        return false
                    }
                })
            }
            dtd.resolve();
        }
    });
    return dtd.promise();
}

// 根据uid查询
function selUserById() {
    if(location.href.split('?')[1]!=0){
        // if(location.href.split('?')[1]==1) {
        //     $('input').each(function (i, n) {
        //         $(this).prop('readonly', 'readonly');
        //         $(this).css('background', '#ddd');
        //         if ($(this).prop('type') == 'radio' || $(this).prop('type') == 'checkbox') {
        //             $(this).prop('disabled', 'disabled')
        //         }
        //     })
        //     $('select').each(function (i, n) {
        //         if ($(this).prop('name') != 'deptId') {
        //             $(this).prop('disabled', 'disabled');
        //             $(this).css('background', '#ddd');
        //         }
        //     });
        //     $('textarea').each(function (i, n) {
        //         $(this).prop('readonly', 'readonly');
        //         $(this).css('background', '#ddd')
        //     })
        // }saveNew
        $('#btn1').val('保存')
        if(location.href.indexOf('isAdd')<0){
            $.get('/user/getUserByuid',{'uid':location.href.split('?')[1].split('&')[0]},function (json) {
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
                            var str = '';
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
                    $('.titleTxt').html(updateUser)
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
                    postDept = json.object.modulePriv.postPriv || "";
                    userSev = json.object.userSecrecy || ""
                    postDeptId = json.object.modulePriv.deptId || ""
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
                    $('#department').deptquerySelect2(function (me) {
                        $.get('/department/selectUnallocated', function(res){
                            $(me).append('<option value="0">'+lizhi+'</option>')
                            if (res.flag && res.msg != 'false'){
                                $(me).append('<option value="'+res.object.deptId+'">'+res.object.deptName+'</option>')
                            }
                            $(me).val(json.object.deptId)
                        })
                    });
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



                    // $('#department').deptSelect(function (me) {
                    //     $(me).append('<option value="0">'+lizhi+'</option>')
                    //     $(me).val(json.object.deptId)
                    //
                    // });
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
        }

    }else {
        $('.newname').text(window.opener.userstr)
        document.title = addUser;
    }
}