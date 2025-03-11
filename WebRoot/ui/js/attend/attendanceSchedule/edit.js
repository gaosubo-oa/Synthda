
//编辑
function editData(data,status) {
    if(status == 1){
        // layer.msg('不可编辑启动中的排班，请先停用！', { icon:5});
        // return false;
        $('.addTable_readonly').show();
        $('.btn_rtn').show();
        $('.iptdetail').hide();
    }else {
        $('.addTable_readonly').hide();
        $('.btn_rtn').hide();
        $('.iptdetail').show();
    }
    $('.saveBtn').attr('type',2);
    $('.saveBtn').attr('sid',data);
    $('.leave').hide();
    $('.addSchedule').show();
    // $('.ispai').show();
    $('.editcls').show();
    $('.newcls').hide();

    $.ajax({
        type:'post',
        url:'/attendSchedule/getAttendScheduleById',
        dataType:'json',
        data:{
            asid:data,
        },
        success:function(res){
            if(res.flag){
                var data = res.object;
                $('.piliangshezhi').attr('portalType',data.mondayId)
                $('#asname').val(data.asname);
                $('#dateStart').val(data.dateStart);
                $('#dateEnd').val(data.dateEnd);
                $('#s1').val(data.deptName);
                $('#s1').attr('deptid',data.deptId);
                $('#s2').val(data.privName);
                $('#s2').attr('userpriv',data.privId);
                $('#s3').val(data.userName);
                $('#s3').attr('user_id',data.userId);
                $("input[name='ispclas'][value='" + data.status + "']").prop("checked", "checked");
                $("input[name='kqtype'][value='" + data.type + "']").prop("checked", "checked");
                if(data.yearRepeat!=0){
                    $("input[name='yearRepeat']").prop("checked", "checked");
                }
                if(data.isOut!=0){
                    $("input[name='isOut']").prop("checked", "checked");
                }
                $("input[name='workStart']").val(data.workStart);
                $("input[name='workEnd']").val(data.workEnd);
                $("input[name='workHour']").val(data.workHour);

                $.ajax({
                    type:'post',
                    url:'/attendSchedule/getAttendSet',
                    dataType:'json',
                    success:function(json){
                        weekq = json.obj;
                        var str='';
                        var nums=0;
                        // 回显考勤时间
                        for(var i=0;i<weekq.length;i++){
                            var tm1 = '-',tm2 = '-',tm3 = '-',tm4 = '-',hor='',miao=0;
                            if(weekq[i].sid == data.mondayId){
                                if(weekq[i].atime1 != ''&&weekq[i].atime2 != ''){
                                    str+='<span>'+weekq[i].atime1+' - '+weekq[i].atime2+'</span>';
                                    tm1=weekq[i].atime1+' - '+weekq[i].atime2;
                                }
                                if(weekq[i].atime3 != ''&&weekq[i].atime4 != ''){
                                    str+='<span>'+weekq[i].atime3+' - '+weekq[i].atime4+'</span>';
                                    tm2=weekq[i].atime3+' - '+weekq[i].atime4;
                                }
                                if(weekq[i].atime5 != ''&&weekq[i].atime6 != ''){
                                    str+='<span>'+weekq[i].atime5+' - '+weekq[i].atime6+'</span>';
                                    tm3=weekq[i].atime5+' - '+weekq[i].atime6;
                                }
                                if(weekq[i].atime7 != ''&&weekq[i].atime8 != ''){
                                    str+='<span>'+weekq[i].atime7+' - '+weekq[i].atime8+'</span>';
                                    tm4 = weekq[i].atime7+' - '+weekq[i].atime8;
                                }
                                if(weekq[i].attendType == '1'){
                                    str =''
                                    str+='<span>'+weekq[i].workStart+'—'+weekq[i].workEnd+'</span>';
                                    tm1 = weekq[i].workStart+'-'+weekq[i].workEnd;
                                    tm2 = ''
                                    tm3 = ''
                                    tm4 = ''
                                }
                                if(weekq[i].duration != 0){
                                    str+='<span>'+weekq[i].duration+'</span>';
                                    hor = weekq[i].duration;
                                    miao= weekq[i].durationSeconde;
                                }
                                $('.mondayId').attr('data-sid',data.mondayId);
                                var tbs = '<td style="text-align: center;font-size: 9pt">星期一</td>' +
                                    '<td>'+tm1+'</td>' +
                                    '<td>'+tm2+'</td>' +
                                    '<td>'+tm3+'</td>' +
                                    '<td>'+tm4+'</td>' +
                                    '<td class="oshour" data-hour="'+miao+'">'+hor+'</td>' +
                                    '<td>' +
                                    '<a href="javascript:;" style="margin-right: 10px;" class="sets">设置</a>\n' +
                                    '<a href="javascript:;" class="dels">删除</a>\n' +
                                    '</td>'
                                $('.mondayId').html(tbs);

                            }

                            if(weekq[i].sid == data.tuesdayId){
                                if(weekq[i].atime1 != ''&&weekq[i].atime2 != ''){
                                    str+='<span>'+weekq[i].atime1+' - '+weekq[i].atime2+'</span>';
                                    tm1=weekq[i].atime1+' - '+weekq[i].atime2;
                                }
                                if(weekq[i].atime3 != ''&&weekq[i].atime4 != ''){
                                    str+='<span>'+weekq[i].atime3+' - '+weekq[i].atime4+'</span>';
                                    tm2=weekq[i].atime3+' - '+weekq[i].atime4;
                                }
                                if(weekq[i].atime5 != ''&&weekq[i].atime6 != ''){
                                    str+='<span>'+weekq[i].atime5+' - '+weekq[i].atime6+'</span>';
                                    tm3=weekq[i].atime5+' - '+weekq[i].atime6;
                                }
                                if(weekq[i].atime7 != ''&&weekq[i].atime8 != ''){
                                    str+='<span>'+weekq[i].atime7+' - '+weekq[i].atime8+'</span>';
                                    tm4 = weekq[i].atime7+' - '+weekq[i].atime8;
                                }
                                if(weekq[i].duration != 0){
                                    str+='<span>'+weekq[i].duration+'</span>';
                                    hor = weekq[i].duration;
                                    miao= weekq[i].durationSeconde;
                                }
                                $('.tuesdayId').attr('data-sid',data.tuesdayId);
                                var tbs = '<td style="text-align: center;font-size: 9pt">星期二</td>' +
                                    '<td>'+tm1+'</td>' +
                                    '<td>'+tm2+'</td>' +
                                    '<td>'+tm3+'</td>' +
                                    '<td>'+tm4+'</td>' +
                                    '<td class="oshour" data-hour="'+miao+'">'+hor+'</td>' +
                                    '<td>' +
                                    '<a href="javascript:;" style="margin-right: 10px;" class="sets">设置</a>\n' +
                                    '<a href="javascript:;" class="dels">删除</a>\n' +
                                    '</td>'
                                $('.tuesdayId').html(tbs);
                            }

                            if(weekq[i].sid == data.wednesdayId){
                                if(weekq[i].atime1 != ''&&weekq[i].atime2 != ''){
                                    str+='<span>'+weekq[i].atime1+' - '+weekq[i].atime2+'</span>';
                                    tm1=weekq[i].atime1+' - '+weekq[i].atime2;
                                }
                                if(weekq[i].atime3 != ''&&weekq[i].atime4 != ''){
                                    str+='<span>'+weekq[i].atime3+' - '+weekq[i].atime4+'</span>';
                                    tm2=weekq[i].atime3+' - '+weekq[i].atime4;
                                }
                                if(weekq[i].atime5 != ''&&weekq[i].atime6 != ''){
                                    str+='<span>'+weekq[i].atime5+' - '+weekq[i].atime6+'</span>';
                                    tm3=weekq[i].atime5+' - '+weekq[i].atime6;
                                }
                                if(weekq[i].atime7 != ''&&weekq[i].atime8 != ''){
                                    str+='<span>'+weekq[i].atime7+' - '+weekq[i].atime8+'</span>';
                                    tm4 = weekq[i].atime7+' - '+weekq[i].atime8;
                                }
                                if(weekq[i].duration != 0){
                                    str+='<span>'+weekq[i].duration+'</span>';
                                    hor = weekq[i].duration;
                                    miao= weekq[i].durationSeconde;
                                }
                                $('.wednesdayId').attr('data-sid',data.wednesdayId);
                                var tbs = '<td style="text-align: center;font-size: 9pt">星期三</td>' +
                                    '<td>'+tm1+'</td>' +
                                    '<td>'+tm2+'</td>' +
                                    '<td>'+tm3+'</td>' +
                                    '<td>'+tm4+'</td>' +
                                    '<td class="oshour" data-hour="'+miao+'">'+hor+'</td>' +
                                    '<td>' +
                                    '<a href="javascript:;" style="margin-right: 10px;" class="sets">设置</a>\n' +
                                    '<a href="javascript:;" class="dels">删除</a>\n' +
                                    '</td>'
                                $('.wednesdayId').html(tbs);
                            }

                            if(weekq[i].sid == data.thursdayId){
                                if(weekq[i].atime1 != ''&&weekq[i].atime2 != ''){
                                    str+='<span>'+weekq[i].atime1+' - '+weekq[i].atime2+'</span>';
                                    tm1=weekq[i].atime1+' - '+weekq[i].atime2;
                                }
                                if(weekq[i].atime3 != ''&&weekq[i].atime4 != ''){
                                    str+='<span>'+weekq[i].atime3+' - '+weekq[i].atime4+'</span>';
                                    tm2=weekq[i].atime3+' - '+weekq[i].atime4;
                                }
                                if(weekq[i].atime5 != ''&&weekq[i].atime6 != ''){
                                    str+='<span>'+weekq[i].atime5+' - '+weekq[i].atime6+'</span>';
                                    tm3=weekq[i].atime5+' - '+weekq[i].atime6;
                                }
                                if(weekq[i].atime7 != ''&&weekq[i].atime8 != ''){
                                    str+='<span>'+weekq[i].atime7+' - '+weekq[i].atime8+'</span>';
                                    tm4 = weekq[i].atime7+' - '+weekq[i].atime8;
                                }
                                if(weekq[i].duration != 0){
                                    str+='<span>'+weekq[i].duration+'</span>';
                                    hor = weekq[i].duration;
                                    miao= weekq[i].durationSeconde;
                                }
                                $('.thursdayId').attr('data-sid',data.thursdayId);
                                var tbs = '<td style="text-align: center;font-size: 9pt">星期四</td>' +
                                    '<td>'+tm1+'</td>' +
                                    '<td>'+tm2+'</td>' +
                                    '<td>'+tm3+'</td>' +
                                    '<td>'+tm4+'</td>' +
                                    '<td class="oshour" data-hour="'+miao+'">'+hor+'</td>' +
                                    '<td>' +
                                    '<a href="javascript:;" style="margin-right: 10px;" class="sets">设置</a>\n' +
                                    '<a href="javascript:;" class="dels">删除</a>\n' +
                                    '</td>'
                                $('.thursdayId').html(tbs);
                            }
                            if(weekq[i].sid == data.fridayId){
                                if(weekq[i].atime1 != ''&&weekq[i].atime2 != ''){
                                    str+='<span>'+weekq[i].atime1+' - '+weekq[i].atime2+'</span>';
                                    tm1=weekq[i].atime1+' - '+weekq[i].atime2;
                                }
                                if(weekq[i].atime3 != ''&&weekq[i].atime4 != ''){
                                    str+='<span>'+weekq[i].atime3+' - '+weekq[i].atime4+'</span>';
                                    tm2=weekq[i].atime3+' - '+weekq[i].atime4;
                                }
                                if(weekq[i].atime5 != ''&&weekq[i].atime6 != ''){
                                    str+='<span>'+weekq[i].atime5+' - '+weekq[i].atime6+'</span>';
                                    tm3=weekq[i].atime5+' - '+weekq[i].atime6;
                                }
                                if(weekq[i].atime7 != ''&&weekq[i].atime8 != ''){
                                    str+='<span>'+weekq[i].atime7+' - '+weekq[i].atime8+'</span>';
                                    tm4 = weekq[i].atime7+' - '+weekq[i].atime8;
                                }
                                if(weekq[i].duration != 0){
                                    str+='<span>'+weekq[i].duration+'</span>';
                                    hor = weekq[i].duration;
                                    miao= weekq[i].durationSeconde;
                                }
                                $('.fridayId').attr('data-sid',data.fridayId);
                                var tbs = '<td style="text-align: center;font-size: 9pt">星期五</td>' +
                                    '<td>'+tm1+'</td>' +
                                    '<td>'+tm2+'</td>' +
                                    '<td>'+tm3+'</td>' +
                                    '<td>'+tm4+'</td>' +
                                    '<td class="oshour" data-hour="'+miao+'">'+hor+'</td>' +
                                    '<td>' +
                                    '<a href="javascript:;" style="margin-right: 10px;" class="sets">设置</a>\n' +
                                    '<a href="javascript:;" class="dels">删除</a>\n' +
                                    '</td>'
                                $('.fridayId').html(tbs);
                            }
                            if(weekq[i].sid == data.saturdayId){
                                if(weekq[i].atime1 != ''&&weekq[i].atime2 != ''){
                                    str+='<span>'+weekq[i].atime1+' - '+weekq[i].atime2+'</span>';
                                    tm1=weekq[i].atime1+' - '+weekq[i].atime2;
                                }
                                if(weekq[i].atime3 != ''&&weekq[i].atime4 != ''){
                                    str+='<span>'+weekq[i].atime3+' - '+weekq[i].atime4+'</span>';
                                    tm2=weekq[i].atime3+' - '+weekq[i].atime4;
                                }
                                if(weekq[i].atime5 != ''&&weekq[i].atime6 != ''){
                                    str+='<span>'+weekq[i].atime5+' - '+weekq[i].atime6+'</span>';
                                    tm3=weekq[i].atime5+' - '+weekq[i].atime6;
                                }
                                if(weekq[i].atime7 != ''&&weekq[i].atime8 != ''){
                                    str+='<span>'+weekq[i].atime7+' - '+weekq[i].atime8+'</span>';
                                    tm4 = weekq[i].atime7+' - '+weekq[i].atime8;
                                }
                                if(weekq[i].duration != 0){
                                    str+='<span>'+weekq[i].duration+'</span>';
                                    hor = weekq[i].duration;
                                    miao= weekq[i].durationSeconde;
                                }
                                $('.saturdayId').attr('data-sid',data.saturdayId);
                                var tbs = '<td style="text-align: center;font-size: 9pt">星期六</td>' +
                                    '<td>'+tm1+'</td>' +
                                    '<td>'+tm2+'</td>' +
                                    '<td>'+tm3+'</td>' +
                                    '<td>'+tm4+'</td>' +
                                    '<td class="oshour" data-hour="'+miao+'">'+hor+'</td>' +
                                    '<td>' +
                                    '<a href="javascript:;" style="margin-right: 10px;" class="sets">设置</a>\n' +
                                    '<a href="javascript:;" class="dels">删除</a>\n' +
                                    '</td>'
                                $('.saturdayId').html(tbs);
                            }
                            if(weekq[i].sid == data.sundayId){
                                if(weekq[i].atime1 != ''&&weekq[i].atime2 != ''){
                                    str+='<span>'+weekq[i].atime1+' - '+weekq[i].atime2+'</span>';
                                    tm1=weekq[i].atime1+' - '+weekq[i].atime2;
                                }
                                if(weekq[i].atime3 != ''&&weekq[i].atime4 != ''){
                                    str+='<span>'+weekq[i].atime3+' - '+weekq[i].atime4+'</span>';
                                    tm2=weekq[i].atime3+' - '+weekq[i].atime4;
                                }
                                if(weekq[i].atime5 != ''&&weekq[i].atime6 != ''){
                                    str+='<span>'+weekq[i].atime5+' - '+weekq[i].atime6+'</span>';
                                    tm3=weekq[i].atime5+' - '+weekq[i].atime6;
                                }
                                if(weekq[i].atime7 != ''&&weekq[i].atime8 != ''){
                                    str+='<span>'+weekq[i].atime7+' - '+weekq[i].atime8+'</span>';
                                    tm4 = weekq[i].atime7+' - '+weekq[i].atime8;
                                }
                                if(weekq[i].duration != 0){
                                    str+='<span>'+weekq[i].duration+'</span>';
                                    hor = weekq[i].duration;
                                    miao= weekq[i].durationSeconde;
                                }
                                $('.sundayId').attr('data-sid',data.sundayId);
                                var tbs = '<td style="text-align: center;font-size: 9pt">星期日</td>' +
                                    '<td>'+tm1+'</td>' +
                                    '<td>'+tm2+'</td>' +
                                    '<td>'+tm3+'</td>' +
                                    '<td>'+tm4+'</td>' +
                                    '<td class="oshour" data-hour="'+miao+'">'+hor+'</td>' +
                                    '<td>' +
                                    '<a href="javascript:;" style="margin-right: 10px;" class="sets">设置</a>\n' +
                                    '<a href="javascript:;" class="dels">删除</a>\n' +
                                    '</td>'
                                $('.sundayId').html(tbs);
                            }

                        }

                        $(".oshour").each(function(){
                            nums += Number($(this).attr('data-hour'))
                        });
                        $('.heji').text(formatSeconds(nums))

                    }

                })
            }
        }
    })


}