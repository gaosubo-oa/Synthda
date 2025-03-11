/**
 * Created by gaosubo-sheji on 2017/6/2.
 */
$(function(){
    //在职人员树状图展示
    //getChDept($('#ULDown'),20);
    //init()
    // getChDept($('#ULDown'),30);

    $('.AUP').click(function(){
        //$('#ulList').slideToggle();
        if($('#downChild').css('display')=='block'){
            $(this).addClass('liUp').removeClass('liDown');
            $('#downChild').slideUp();
        }else{
            $(this).addClass('liDown').removeClass('liUp');
            $('#downChild').slideDown();
        }
    })
    //部门点击事件
    // $('#ULDown').on('click','.childdept',function(){
    //
    //     $('.childQuery').show().siblings().hide();
    //     $('#ULDown li').find('span').removeClass('on');
    //     $(this).addClass('on');
    //     var deptId=$(this).attr('deptid');
    //     var data={
    //         'choice':1,
    //         'deptId':deptId
    //     }
    //     companyAllPerson(data,$('.allCondition'));
    // })
    /*if($('.childQuery').css('display')=='none'){
        $('#ULDown li').find('span').removeClass('on');
    }*/
    //人员查询点击事件
    $('#QUERY').click(function(){
        $('.queryUser').show().siblings().hide();
    })
    //全部人员点击事件
    $('#ALLP').click(function(){
        $('.allPerson').show().siblings().hide();
        var data={'choice':1};
        queryAllPerson(data,$('.trAllPerson'));
    })
    //外出人员点击事件
    $('#OUTP').click(function(){
        $('.outPerson').show().siblings().hide();
    })
    $('.spanUP').click(function(){
        $('.collect').find('.spanUP').removeClass('on');
        $(this).addClass('on');
    })
    //查询按钮点击事件
    $('#submit').click(function(){
        $('.conditionQuery').show().siblings().hide();
        var deId=$('select[name="unit"] option:checked').val();
        var privNo=$('select[name="user"] option:checked').val();
        if(deId==0){
            deId='';
        }
        if(privNo==0){
            privNo='';
        }
        var data={
            'userId':$('input[name="userId"]').val(),
            'userName':$('input[name="userName"]').val(),
            'sex':$('select[name="sex"] option:checked').val(),
            'deptId':deId,
            'userPrivNo':privNo,
            'choice':1
        }
        queryAllPerson(data,$('.Condition'));
    })
    //导出按钮点击事件
    $('#export').click(function(){
        var std = $('#orgMore option:selected').val();
        var userId=$('input[name="userId"]').val();
        var userName=$('input[name="userName"]').val();
        var sex=$('select[name="sex"] option:checked').val();
        var deId=$('select[name="unit"] option:checked').val();
        var privNo=$('select[name="user"] option:checked').val();
        if(deId==0){
            deId='';
        }
        if(privNo==0){
            privNo='';
        }
        window.location.href='../getUserbyCondition1?userId='+userId+'&userName='+userName+'&sex='+sex+'&deptId='+deId+'&userPrivNo='+privNo+'&choice=2&sql='+std;
    })
    //人员详情点击事件
    $('.tab').on('click','.userDetail',function(){
        var uid=$(this).parents('tr').attr('uid');
        $.popWindow('/sys/userDetailsPlus?uid=' + uid +'','用户信息','100','200','1000px','600px');
    })
    //用户查询返回按钮
    $('.tab').on('click','.backBtn',function(){
        $('.conditionQuery').hide();
        $('.queryUser').show();
    })
})

function init(){
    var std = $('#orgMore option:selected').val();
    $.ajax({
        url:'../department/getChDeptPlus?OID='+std,
        type:'get',
        data:{'deptId':20 },
        dataType:'json',
        success:function(res){
            var data1=res.obj;
            var str='';
            str='<span deptid="'+data1.deptId+'" class="childdept" style="display: block;width:100%;padding:8px 0 8px 30px;font-size: 14px;"><a href="#" class="dynatree-title" title="'+data1[0].deptName+'">'+data1[0].deptName+'</a></span>'
            $('#ULDown').before(str);
        }
    })
}
//部门人员树状图方法
function getChDept(element,deptId){
    var std = $('#orgMore option:selected').val();
    $.ajax({
        url:'../department/getChDeptPlus?OID='+std,
        type:'get',
        data:{'deptId':deptId },
        dataType:'json',
        success:function(data){

            if(deptId==30){
                var str = '';
                data.obj.forEach(function(v,i){
                    if(v.deptName){
                        str+='<li><span deptid="'+v.deptId+'" class="childdept"><img style="margin-left: 42px;margin-right: 5px" src="../img/main_img/company_logo.png" alt=""><a href="#" class="dynatree-title" title="'+v.deptName+'">'+v.deptName+'</a></span><ul></ul></li>';
                    }else{
                        str+='<li><span deptid="'+v.deptId+'" class="childdept"><span><img style="margin-left: 65px;margin-right: 5px" src="../img/main_img/man.png" alt=""></span><img style="margin-left: 65px;margin-right: 5px" src="../img/main_img/man.png" alt=""><a href="#" class="dynatree-title" title="'+v.userName+'">'+v.userName+'</a></span><ul></ul></li>';
                    }
                });
            }else{
                var str = '';
                data.obj.forEach(function(v,i){
                    if(v.deptName){
                        str+='<li><span deptid="'+v.deptId+'" class="childdept"><img style="margin-left: 65px;margin-right: 5px" src="../img/main_img/company_logo.png" alt=""><a href="#" class="dynatree-title" title="'+v.deptName+'">'+v.deptName+'</a></span><ul></ul></li>';
                    }else{
                        if(v.sex==0){
                            str+='<li><span deptid="'+v.deptId+'" class="childdept"><img style="margin-left: 65px;margin-right: 5px" src="../img/main_img/man.png" alt=""><a href="#" class="dynatree-title" title="'+v.userName+'">'+v.userName+'</a></span><ul></ul></li>';
                        }else if(v.sex==1){
                            str+='<li><span deptid="'+v.deptId+'" class="childdept"><img style="margin-left: 65px;margin-right: 5px" src="../img/main_img/women.png" alt=""><a href="#" class="dynatree-title" title="'+v.userName+'">'+v.userName+'</a></span><ul></ul></li>';
                        }
                    }

                });
            }
            element.html(str);
        }
    })
}
//查询所有人员
function queryAllPerson(data,element){
    $('.loopData').remove();
    var std = $('#orgMore option:selected').val();
    $.ajax({
        type:'get',
        url:'../getUserbyCondition1?sql='+std,
        dataType:'json',
        data:data,
        success:function(res){
            var data1=res.obj;
            var str='';
            for(var i=0;i<data1.length;i++){
                var txt=data1[i].sex==0?'男':'女';
                str+='<tr class="loopData" uid="'+data1[i].uid+'"><td>'+data1[i].dep.deptName+'</td><td>'+data1[i].userPrivName+'</td><td><a href="javascript:;" class="userDetail">'+data1[i].userName+'</a></td><td>'+data1[i].online+'</td><td>'+txt+'</td><td>'+data1[i].telNoDept+'</td><td>'+data1[i].mobilNo+'</td><td>'+data1[i].email+'</td></tr>'
            }
            element.after(str);
        }
    })
}
//通过部门查询人员
function companyAllPerson(data,element){
    $('.loopData').remove();
    var std = $('#orgMore option:selected').val();
    $.ajax({
        type:'get',
        url:'../getUserbyCondition?sql='+std,
        dataType:'json',
        data:data,
        success:function(res){
            var data1=res.obj;
            var str='';
            for(var i=0;i<data1.length;i++){
                var txt=data1[i].sex==0?'男':'女';
                if(data1[i].RoleAuxiliaryName){
                    str+='<tr class="loopData" uid="'+data1[i].uid+'"><td>'+data1[i].dep.deptName+'</td><td><a href="javascript:;" class="userDetail">'+data1[i].userName+'</a></td><td>'+data1[i].userPrivName+'</td><td>'+data1[i].RoleAuxiliaryName+'</td><td>'+data1[i].online+'</td><td>'+txt+'</td><td>'+data1[i].telNoDept+'</td><td>'+data1[i].dep.telNo+'</td><td>'+data1[i].mobilNo+'</td><td>'+data1[i].email+'</td></tr>'
                }else{
                    str+='<tr class="loopData" uid="'+data1[i].uid+'"><td>'+data1[i].dep.deptName+'</td><td><a href="javascript:;" class="userDetail">'+data1[i].userName+'</a></td><td>'+data1[i].userPrivName+'</td><td></td><td>'+data1[i].online+'</td><td>'+txt+'</td><td>'+data1[i].telNoDept+'</td><td>'+data1[i].dep.telNo+'</td><td>'+data1[i].mobilNo+'</td><td>'+data1[i].email+'</td></tr>'
                }

            }
            element.after(str);
        }
    })
}