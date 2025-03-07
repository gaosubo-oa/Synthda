

// 保存
$(document).on('click','.saveBtn',function(){
    var that =this;
    var deptId = $('#s1').attr('deptid')||'';
    var privId = $('#s2').attr('userpriv')||'';
    var userId = $('#s3').attr('user_id')||'';
    var kars = [];

    if($('#asname').val()==''){
        layer.msg('请填写必填字段！', { icon:6});
        return false;
    }

    if(deptId == ''&&privId == ''&&userId == ''){
        layer.msg('部门、角色、人员请至少选择一种范围进行设置！', { icon:6});
        return false;
    }

    if ($("input[name='yearRepeat']").is(':checked')) {

    }
     else  if($('#dateStart').val() == ''||$('#dateEnd').val()== ''){
            layer.msg('请填写必填字段！', { icon:6});
            return false;

    }


    var yearRepeat = 0;
    if($("input[name='yearRepeat']").is(':checked')){
        yearRepeat = 1
    }else {
        yearRepeat = 0
    }

    var isOut= 0;
    if($("input[name='isOut']").is(':checked')){
        isOut = 1
    }else {
        isOut = 0
    }

    var sday=[];
    var cum = $('.specialDay');
    for(var i=0;i<$('.specialDay').length;i++){
        sday.push($(cum[i]).text())
    }
    $.each($("input[name='fdays']"),function(){
        if(this.checked){
            $(this).val()
            kars.push($(this).val())
        }})

   var datas = {
       asname:$('#asname').val(),//班次名称
       deptId:deptId,//部门
       privId:privId,//角色
       userId:userId,//人员
       type:$("input[name='kqtype']:checked").val(),//考勤类型
       dateStart:$('#dateStart').val(),//起始日期
       dateEnd:$('#dateEnd').val(),//终止日期
       yearRepeat:yearRepeat,//是否按年重复
       mondayId:$('.mondayId').attr('data-sid')||'',//星期一
       tuesdayId:$('.tuesdayId').attr('data-sid')||'',//星期二
       wednesdayId:$('.wednesdayId').attr('data-sid')||'',//星期三
       thursdayId:$('.thursdayId').attr('data-sid')||'',//星期四
       fridayId:$('.fridayId').attr('data-sid')||'',//星期五
       saturdayId:$('.saturdayId').attr('data-sid')||'',//星期六
       sundayId:$('.sundayId').attr('data-sid')||'',//星期日
       workDay:kars.toString(),//核心工作日期
       status:0,
       workStart:$("input[name='workStart']").val(),//核心工作开始时间
       workEnd:$("input[name='workEnd']").val(),//核心工作结束时间
       workHour:$("input[name='workHour']").val(),//每日工作时长
       isOut:isOut,//允许外勤签到
       specialDay:sday.toString()//特殊免签日期
   }
   if($(that).attr('type')==2){

       datas.status=$("input[name='ispclas']:checked").val()
       datas.asid=$('.saveBtn').attr('sid');
       $.ajax({
           type:'post',
           url:'/attendSchedule/updateAttendSchedule',
           dataType:'json',
           data:datas,
           success:function(res){
               if(res.flag){
                   layer.msg('保存成功！', { icon:6},function () {
                       window.location.reload();
                   });
               }else {
                   layer.msg('保存失败！', { icon:5});
               }
           }
       })

   }else {
       $.ajax({
           type:'post',
           url:'/attendSchedule/insertSchedule',
           dataType:'json',
           data:datas,
           success:function(res){
               if(res.flag){
                   layer.msg('新建成功！', { icon:6},function () {
                       window.location.reload();
                   });
               }else {
                   layer.msg('新建失败！', { icon:5});
               }
           }
       })
   }



});