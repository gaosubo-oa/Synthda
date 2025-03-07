$(function(){
    $('#AddFolder').on("click",function(){
        var emailType=$('input[name="examFlag"]:checked').val();
        var Number=$('#deptName').attr('deptid');
        var Name=$('#userName').attr('user_id');
        var number2=$('#sendAmount').val();
        var Name2=$('#excludeUserName').attr('user_id');
        var dept=$('textarea[name="deptName"]').val()   //所属部门
        var userPer=$('textarea[name="userName"]').val() //审核人
        if(dept==''){
            layer.msg(email_th_ChooseDepartment+'！',{icon:2});
            return false
        }
        if(userPer==''){
            layer.msg(email_th_pleaseSelectTheReviewer+'！',{icon:2});
            return false
        }
        $.ajax({
            type:'post',
            url:'/approveEmail/addEmailSet',
            dataType:'json',
            data:{
                userId:Name,
                deptId:Number,
                excludeUserId:Name2,
                sendAmount:number2

            },
            success:function (res) {
                if(res.flag){
                    layer.msg(addSuccess+'！',{icon:1});
                    dataList($('#eList'));
                }else{
                    layer.msg(addFailed+'！',{icon:2});
                }
            }
        })

    })
    dataList($('#eList'));
//    编辑
    $('#eList').on('click','.editData',function () {
        var dataId=$(this).parents('tr').attr('data-id');
        layer.open({
            type:1,
            title:[workflow_design_setting34,'background-color:#2b7fe0;color:#fff;'],
            area: ['460px', '260px'],
            shadeClose: true, //点击遮罩关闭
            btn: [sure, cancel],
            content:'<table border="0" cellspacing="0" cellpadding="0" width="96%" style="border-collapse:collapse;background-color: #fff;margin: 10px auto;">' +
            '<tr>' +
            '<td>'+Subordinatedepartment+'：</td>' +
            '<td>' +
            '<textarea name="deptNames" id="deptNames" deptid="" style="min-width: 80%;min-height: 50px;" value="" readonly></textarea>'+
             '<a href="javascript:;" class="chose2Dept" style="margin-right: 10px;margin-left: 5px;">'+workflow_common_select+'</a>'+
             '<a href="javascript:;" class="clear2Dept">'+workflow_common_clear+'</a>' +
            '</td>' +
            '</tr>' +
            '<tr>' +
            '<td>'+email_th_excludePersonnel+'：</td>' +
            '<td>' +
            '<textarea name="excludeUserNames" id="excludeUserNames" excludeuserid="" style="min-width: 80%;min-height: 50px;" value="" readonly></textarea>'+
            '<a href="javascript:;" class="choseUserPerson" style="margin-right: 10px;margin-left: 5px;">'+workflow_common_select+'</a>'+
            '<a href="javascript:;" class="clearUserPerson">'+workflow_common_clear+'</a>' +
            '</td>' +
            '</tr>' +
                '<tr>' +
                '<td>'+censor_th_reviewers+'：</td>' +
                '<td>' +
                '<textarea name="userNames" id="userNames" userid="" style="min-width: 80%;min-height: 50px;" value="" readonly></textarea>'+
                '<a href="javascript:;" class="chose2User" style="margin-right: 10px;margin-left: 5px;">'+workflow_common_select+'</a>'+
                '<a href="javascript:;" class="clear2User">'+workflow_common_clear+'</a>' +
                '</td>' +
                '</tr>' +
            '</table>',
            success:function () {
                $.ajax({
                    type:'get',
                    url:'/approveEmail/selEmailSetByDept',
                    dataType:'json',
                    data:{
                        essId:dataId
                    },
                    success:function (res) {
                        var datas=res.object;
                        $('#deptNames').attr('deptid',datas.deptId);
                        $('#deptNames').val(datas.deptName);
                        $('#userNames').attr('user_id',datas.userId);
                        $('#userNames').val(datas.userName);
                        $('#excludeUserNames').attr('user_id',datas.excludeUserId);
                        $('#excludeUserNames').val(datas.excludeUserName);
                    }
                })
            },
            yes:function (index) {
                var dept=$('textarea[name="deptNames"]').val()   //所属部门
                var userPer=$('textarea[name="userNames"]').val() //审核人
                if(dept==''){
                    layer.msg(email_th_ChooseDepartment+'！',{icon:2});
                    return false
                }
                if(userPer==''){
                    layer.msg(email_th_pleaseSelectTheReviewer+'！',{icon:2});
                    return false
                }
                $.ajax({
                    type:'post',
                    url:'/approveEmail/updateEmailSet',
                    dataType:'json',
                    data:{
                        userId:$('#userNames').attr('user_id'),
                        deptId:$('#deptNames').attr('deptid'),
                        excludeUserId:$('#excludeUserNames').attr('user_id'),
                        essId:dataId
                    },
                    success:function (res) {
                        if(res.flag){
                            layer.msg(menuSSetting_th_editSuccess,{icon:1});
                            dataList($('#eList'));
                            layer.close(index);
                        }else {
                            layer.msg(editFail+'！',{icon:2});
                        }
                    }
                })
            }
        })
        $('.choseUserPerson').on("click",function () {
            user_id='excludeUserNames';
            $.popWindow("../common/selectUser");
        })
        $('.chose2Dept').on("click",function () {
            dept_id='deptNames';
            $.popWindow("../common/selectDept");
        })
        $('.chose2User').on("click",function () {
            user_id='userNames';
            $.popWindow("../common/selectUser");
        })
        $('.clear2Dept').on("click",function () {
            $('#deptNames').attr('deptname','');
            $('#deptNames').attr('deptid','');
            $('#deptNames').attr('deptno','');
            $('#deptNames').val('');
        });
        $('.clear2User').on("click",function () {
            $('#userNames').attr('user_id','');
            $('#userNames').attr('username','');
            $('#userNames').attr('dataid','');
            $('#userNames').attr('userprivname','');
            $('#userNames').val('');
        })
        $('.clearUserPerson').on("click",function () {
            $('#excludeUserNames').attr('user_id','');
            $('#excludeUserNames').attr('username','');
            $('#excludeUserNames').attr('dataid','');
            $('#excludeUserNames').attr('userprivname','');
            $('#excludeUserNames').val('');
        })

    })
//    删除
    $('#eList').on('click','.deleteData',function () {
        var dataId=$(this).parents('tr').attr('data-id');
        layer.confirm(sureDelete+'？', {
            btn: [sure, cancel], //按钮
            title: DeletingPermissions
    }, function(){
            //确定删除，调接口
            $.ajax({
                type:'post',
                url:'/approveEmail/delEmailSet',
                dataType:'json',
                data:{
                    essId:dataId
                },
                success:function(res){
                    if(res.flag){
                        layer.msg(delc+'！', { icon:1});
                        // dataList($('#eList'));
                        location.reload();
                    }else{
                        layer.msg(delf+'！', { icon:2});
                    }
                }
            })

        }, function(){
            layer.closeAll();
        });
    })
})

function dataList(element) {
    $.ajax({
        type:'get',
        url:'/approveEmail/selEmailSet',
        dataType:'json',
        success:function (res) {
            var datas=res.obj;
            var paraData=res.object;
            $(":radio[name='examFlag'][value='" + paraData.paraValue + "']").prop("checked", true);
          /*  if(paraData.paraValue == '1'){
                $('#hide1').hide();
                $('#hide2').hide();
            }else {
                $('#hide1').show();
                $('#hide2').show();
            }*/
            if(datas.length > 0){
                var str='';
                for(var i=0;i<datas.length;i++){
                    var deptId = datas[i].deptId.split(',')[0];
                    str+='<tr data-id="'+datas[i].essId+'">' +
                        '<td>'+deptId+'</td>' +
                        '<td>'+datas[i].deptName+'</td>' +
                        '<td>'+datas[i].excludeUserName+'</td>' +
                        '<td>'+datas[i].userName+'</td>' +
                        '<td><a href="javascript:;" class="editData" style="margin-right: 10px;">'+edit1+'</a><a href="javascript:;" class="deleteData">'+del+'</a></td>' +
                        '</tr>'
                }
                element.html(str);
            }
        }
    })
}