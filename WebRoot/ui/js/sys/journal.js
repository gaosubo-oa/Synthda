
$(function(){
    $.ajax({
        type:'get',
        url:'../syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN',
        dataType:'json',
        success:function(res){
            if (res.object!=null&&res.object.length>0&&res.object[0].paraValue==0){
                selectMonth();
                $('#DATA').find('span').addClass('one');
                $('#survey').hide()
                $('#administration').hide()
                $('.journalSurvey').hide();
                $('.yearData').show();
                //年度数据点击事件
                $('#DATA').on("click",function(){
                    $(this).find('span').addClass('one');
                    $(this).siblings().find('span').removeClass('one');
                    $('.yearData').show().siblings().hide();

                    selectMonth();

                });
            }else {
                $('#survey').show();
                $('#administration').show()
                $('.journalSurvey').show();
                journalSurveyShow();
                journalListShow();
                $('#DATA').on("click",function(){
                    $(this).find('span').addClass('one');
                    $(this).siblings().find('span').removeClass('one');
                    $('.yearData').show().siblings().hide();
                    selectMonth();
                });
                //日志概况点击事件
                $('#survey').on("click",function(){
                    $(this).find('span').addClass('one');
                    $(this).siblings().find('span').removeClass('one');
                    $('.journalSurvey').show().siblings().hide();
                    journalSurveyShow();
                });
            }
        }
    })
    //时段统计点击事件
    $('#statistics').on("click",function(){
        $(this).find('span').addClass('one');
        $(this).siblings().find('span').removeClass('one');
        $('.timeInterval').show().siblings().hide();
        periodStatistics();
    });
    //日志管理点击事件
    $('#administration').on("click",function(){
        $('.num').val('');
        $(this).find('span').addClass('one');
        $(this).siblings().find('span').removeClass('one');
        $('.journalQuery').show().siblings().hide();
        allJournalType();
        $('.Query').prop('checked',true);
    });
    //版本升级日志点击事件
    $('#versionlog').on("click",function(){
        $(this).find('span').addClass('one');
        $(this).siblings().find('span').removeClass('one');
        $('.versionlog').show().siblings().hide();
        versionlog()
    });
    //查询结果页返回按钮点击事件
    $('#divBack').on("click",function(){
        $('.num').val('');
        $('.journalQuery').show().siblings().hide();
    });
    //日志查询确定点击事件
    $('.sureBtn').on('click','#Btn',function(){
        var id=$('#senduser').attr('user_id');
        var type=$('#journalType option:checked').val();
        var startTime=$('#start').val();
        var endTime=$('#end').val();
        var ip=$('#IP').val();
        var remark=$('#remarks').val();
        if(!id) {
            id = '';
        }
        //单选框选中事件
        if($('input[name="TYPE"]:checked').val()==1){//选中查询
            $('.queryResult').show().siblings().hide();
            queryShow();
        }else if($('input[name="TYPE"]:checked').val()==2){//选中导出
            //journalExport();
            window.location.href='../sys/exportLogXls?type='+type+'&uid='+id+'&startTime='+startTime+'&endTime='+endTime+'&ip='+ip+'&remark='+remark+'';
        }else{                                          //选中删除
            journalDelete();
        }

    });
    //复选框全选点击事件
    $('#checkedAll').on("click",function(){
        var state =$(this).prop("checked");
        if(state==true){
            $(this).prop("checked",true);
            $(".checkChild").prop("checked",true);
        }else{
            $(this).prop("checked",false);
            $(".checkChild").prop("checked",false);
        }
    });
    //查询列表删除事件
    $('#delete').on("click",function(){
        var fileId='';
        $(".checkChild:checkbox:checked").each(function(){
            fileId+=$(this).attr("logId")+',';
            // fileId.push(conId);
        });
        // alert(fileId);
        deleteAllJournal(fileId);
    });
    //清空系统日志
    $('#emptyBtn').on("click",function(){
        $.ajax({
            type:'post',
            url:'../sys/deleteAllLog',
            dataType:'json',
            success:function(res){
                console.log(res.msg);
            }
        })
    });
    //  版本升级日志
    function versionlog() {
        $.ajax({
            type: 'get',
            url: '/sys/getVersionLogs',
            dataType: 'json',
            success: function (res) {
                if(res.flag == true){
                    var data = res.data;
                    var strr;
                    for(var i=0;i<data.length;i++) {
                        strr +='<tr>'+
                                '<td>'+data[i].name+'</td>'+
                                '<td fileName="'+data[i].name+'">'+
                                '<a id="download" class="versionloga" style="cursor: pointer;">下载</a>'+
                                '</td>'+
                                '</tr>';
                    }
                    $('.tabTwo1 tbody').html(strr);
                }
            }
        })
    }
    //版本升级日志下载
    $("#versionlogat").on("click","#download",function () {
        var fileName = $('#download').parent().attr('fileName')
        window.open("/sys/downloadVersionLog?fileName="+fileName);
    });
    //日志概况显示数据
    function journalSurveyShow(){
        $.ajax({
            type:'get',
            url:'../sys/getLogMessage',
            dataType:'json',
            success:function(rsp){
                var data=rsp.object;
                $('.totalDay').text(data.totalDay);
                $('.totalCount').text(data.totalCount);
                $('.yearCount').text(data.yearCount);
                $('.mouthCount').text(data.mouthCount);
                $('.dayCount').text(data.dayCount);
                $('.averageDayCount').text(data.averageDayCount);
            }
        })
    }
    //判断操作系统类型
    function optionSysType(remark){
        if(remark.indexOf("Win") > -1){
            if(remark.indexOf("Windows NT 5.") > -1){
                operateSys = 'Windows XP'
            }else if (remark.indexOf("Windows NT 6.0") > -1) {
                operateSys = "Windows Vista"
            } else if (remark.indexOf("Windows NT 6.1") > -1) {
                operateSys = "Windows 7"
            } else if (remark.indexOf("Windows NT 6.3") > -1) {
                operateSys = "Windows 8"
            } else if (remark.indexOf("Windows NT 10.") > -1) {
                operateSys = "Windows 10"
            }
        }else if(remark.indexOf("Ipone") > -1){
            operateSys = "ipone"
        }else if(remark.indexOf("Mac") > -1){
            operateSys = "mac"
        }else if(remark.indexOf("Linux") > -1){
            if(remark.indexOf("Android") > -1){
                operateSys = "Android"
            }else {
                operateSys = "Linux"
            }
        }
    }
    //判断浏览器及版本
    function browserType(remark){
        if(remark.indexOf("Trident") > -1){
            browser = 'IE';
            version = remark.substring(remark.indexOf("rv:")+3,remark.lastIndexOf('.'));
            version="IE" + version;
        }else if (remark.indexOf("Firefox/") > -1 && remark.indexOf("Windows NT") > -1) {
            browser = "Firefox";
            version= remark.substring(remark.indexOf("rv:")+3,remark.lastIndexOf('.0) '));
            version="Firefox" + version;
        } else if (remark.indexOf("Windows NT") > -1 && remark.indexOf("Chrome/") > -1) {
            browser = "Chrome";
            version= remark.substring(remark.indexOf("Chrome/")+7,remark.lastIndexOf(' Safari'));
        } else if (remark.indexOf("Windows NT") > -1 && remark.indexOf("Opera/") > -1) {
            browser = "Opera"
        } else if (remark.indexOf("Windows NT") > -1 && remark.indexOf("Safari/") > -1 && remark.indexOf("Chrome/") == -1) {
            browser = "Safari"
        }else{
            browser = "";
            version= '';
        }
    }
    var operateSys;
    var browser;
    var version;
    //日志显示列表
    function journalListShow(){
        $.ajax({
            type:'get',
            url:'../sys/getTenLog',
            dataType:'json',
            success:function(rsp){
                var data=rsp.object;
                var str='';
                for(var i=0;i<data.length;i++){
                    var clientTypeName = '';
                    var clientVersion = '';
                    var sendTime=data[i].time;
                    var typeName = '';
                    var remark = data[i].remark;
                    optionSysType(remark)
                    browserType(remark)
                    if(data[i].clientTypeName != undefined){
                        clientTypeName = data[i].clientTypeName;
                    }
                    if(data[i].clientVersion != undefined){
                        clientVersion = data[i].clientVersion;
                    }
                    if(data[i].typeName != undefined){
                        typeName = data[i].typeName;
                    }
                    str+='<tr class="newData">' +
                        '<td>'+data[i].userName+'</td>' +
                        '<td>'+sendTime+'</td>' +
                        '<td>'+data[i].ip+'</td>' +
                        '<td>'+typeName+'</td>' +
                        '<td title="' +function(){
                            if(data[i].typeName == '登录日志' && data[i].clientTypeName == '网页端'){
                                return '操作系统：' + operateSys + ';   浏览器：' + browser + ';   版本号：' + version
                            }else{
                                return ''
                            }
                        }() +'">'+clientTypeName+'</td>' +
                        '<td>'+clientVersion+'</td>' +
                        // '<td style="width: 150px;" title="'+data[i].remark+'"><div style="width: 150px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;">'+data[i].remark+'</div></td>' +
                        '</tr>'
                }
                $('.newly').after(str);
            }
        })
    }
    //月份显示
    function selectMonth(){
        $('#seleMonth').find('option').remove();
        var data={
            'year':$('#select option:checked').val()
        };
        $.ajax({
            type:'get',
            url:'../sys/getMonth',
            dataType:'json',
            data:data,
            success:function(rsp){
                var str='';
                for(var i=0;i<rsp.object;i++){
                    if(i==rsp.object-1){
                        str+='<option selected="selected" value="' + ( i + 1 )+'">' + ( i + 1 ) + ''+global_lang_month+'</option>';
                    }else {
                        str += '<option value="' + (i + 1) + '">' + (i + 1) + ''+global_lang_month+'</option>';
                    }
                }

                $('#seleMonth').append(str);
                $('.monthSpan').html(rsp.object);
                monthJournal();
            }
        })
    }
    //年份改变事件
    $('#select').on("change",function(){
        selectMonth()
        $('.yearEcharts div span').html($('#select').val());
        $('.yearJournal td').html($('#select').val()+'年度按月访问数据');

    })
    //月份改变事件
    $('#seleMonth').change(function(){
        var opt=$('#seleMonth option:checked').val();
        $('.monthSpan').text(opt);
        monthJournal()
    });
    //日志月度访问数据、日访问数据
    function monthJournal(){
        $('#todyData').children().remove();
        $('#monthData').children().remove();
        $('.monthData').remove();
        $('.dayData').remove();
        var data={
            'year':$('#select option:checked').val(),
            'month':$('#seleMonth option:checked').val()
        };
        $.ajax({
            type:'get',
            url:'../sys/getEachMouthLogData',
            dataType:'json',
            data:data,
            success:function(rsp){
                if(rsp.flag){
                    var data1=rsp.object.monthData;//月度访问数据
                    var data2=rsp.object.dayData;//日访问数据
                    var str='';
                    var str1='';
                    var i=0;
                    for(var j=0;j<data1[i].length;j++){
                        if(data1[i+1][j] == undefined){
                            var a = '';
                        }else{
                            var a = data1[i+1][j];
                        }
                        if(data1[i][j] == undefined){
                            var b = '';
                        }else{
                            var b = data1[i][j];
                        }
                        str+='<tr class="monthData"><td>'+(j+1)+''+global_lang_month+'</td><td>'+ a +'</td><td>'+ b +'</td></tr>';
                    }
                    $('.yearJournal').after(str);
                    for(var n=0;n<data2[i].length;n++){
                        str1+='<tr class="dayData"><td>'+(n+1)+'</td><td>'+data2[i+1][n]+'</td><td>'+data2[i][n]+'</td></tr>';
                    }
                    $('.monthJournal').after(str1);

                    // 基于准备好的dom，初始化echarts实例
                    var myChart = echarts.init(document.getElementById('monthData'));
                    // 指定图表的配置项和数据
                    var option = {
                        tooltip: {},
                        legend: {
                        },
                        xAxis: {
                            data: [month,montha,monthb,monthc,monthd,monthe,monthf,monthj,monthh,monthi,monthk,monthm]
                        },
                        yAxis: {},
                        series: [{
                            name: '访问量',
                            type: 'bar',
                            data: data1[0]
                        }]
                    };
                    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);

                    // 基于准备好的dom，初始化echarts实例
                    var myChart = echarts.init(document.getElementById('todyData'));
                    // 指定图表的配置项和数据
                    var option = {
                        tooltip: {},
                        legend: {
                        },
                        xAxis: {
                            data: ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
                        },
                        yAxis: {},
                        series: [{
                            name: '访问量',
                            type: 'bar',
                            data: data2[0]
                        }]
                    };

                    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);
                }
            }
        })
    }
    //时段统计数据
    function periodStatistics(){

        $('.hourDataTr').remove();
        $('#hourData').children().remove();
        $.ajax({
            type:'get',
            url:'../sys/getHourLog',
            dataType:'json',
            success:function(rsp){
                if(rsp.flag){
                    var data=rsp.obj;
                    var str='';
                    var i=0;
                    for(var j=0;j<data[i].length;j++){
                        str+='<tr class="hourDataTr"><td>'+j+'</td><td>'+data[i+1][j]+'</td><td>'+data[i][j]+'</td></tr>';
                    }
                    $('.period').after(str);

                    // 基于准备好的dom，初始化echarts实例
                    var myChart = echarts.init(document.getElementById('hourData'));
                    // 指定图表的配置项和数据
                    var option = {
                        title: {
                            text: StatisticsTotalAccess,
                            left:'45%',
                            textStyle:{
                                fontSize:14
                            },
                            textAlign:'center'
                        },
                        tooltip: {},
                        legend: {
                        },
                        xAxis: {
                            data: ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23"]
                        },
                        yAxis: {},
                        series: [{
                            name: '访问量',
                            type: 'bar',
                            data: data[0]
                        }]
                    };
                    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);
                }
            }
        })
    }
    //日志类型
    function allJournalType(){
        $.ajax({
            type:'get',
            url:'../sys/getLogType',
            dataType:'json',
            success:function(rsp){
                var data=rsp.obj;
                var str='';
                for(var i=0;i<data.length;i++){
                    str+='<option value="'+data[i].codeNo+'">'+data[i].codeName+'</option>'
                }
                $("#journalType").empty();
                $('#journalType').append(str);
            }
        })
    }
    var operateSys1;
    var browser1;
    var version1;
    //查询日志显示列表
    function queryShow(page){
        $('.AllData').remove();
        var id=$('#senduser').attr('user_id');
        if(!id){
            id='';
        }
        var data={
            'type':$('#journalType option:checked').val(),
            'uid':id,
            'startTime':$('#start').val(),
            'endTime':$('#end').val(),
            'ip':$('#IP').val(),
            'remark':$('#remarks').val()
        };
        if(page!= undefined){
            data.sum = page;
        }
        $.ajax({
            type:'get',
            url:'../sys/logManage',
            dataType:'json',
            data:data,
            success:function(res){
                var data1=res.obj;
                var str='';
                for(var i=0;i<data1.length;i++){
                    var clientTypeName = '';
                    var clientVersion = '';
                    var sendTime=data1[i].time;
                    var typeName = '';
                    var remark = data1[i].remark;
                    // 判断是否有设备类型
                    if(data1[i].clientTypeName != undefined){
                        clientTypeName = data1[i].clientTypeName;
                    }else{
                        // 1：网页端，2：PC客户端，3：IOS端，4：安卓端
                        if(data1[i].clientType!=undefined){
                            switch (data1[i].clientType){
                                case 1:
                                    clientTypeName = "网页端";
                                    break;
                                case 2:
                                    clientTypeName = "PC客户端";
                                    break;
                                case 3:
                                    clientTypeName = "IOS端";
                                    break;
                                case 4:
                                    clientTypeName = "安卓端";
                                    break;
                            }
                        }
                    }
                    if(data1[i].clientVersion != undefined){
                        clientVersion = data1[i].clientVersion;
                    }
                    if(data1[i].typeName != undefined){
                        typeName = data1[i].typeName;
                    }
                    optionSysType(remark)
                    browserType(remark)
                    str+='<tr class="AllData">' +
                        '<td><input logId="'+data1[i].logId+'" class="checkChild" type="checkbox" name="checke" value=""></td>' +
                        '<td>'+data1[i].userName+'</td>' +
                        '<td>'+sendTime+'</td>' +
                        '<td>'+data1[i].ip+'</td>' +
                        '<td>'+data1[i].ipLocation+'</td>' +
                        '<td>'+typeName+'</td>' +
                        '<td style="font-width:150px; \n' +
                        'word-break: break-word;" title="'+ data1[i].remark +'">'+data1[i].remark+'</td>' +
                        '<td title="' +function(){
                            if(data1[i].typeName == '登录日志' && data1[i].clientTypeName == '网页端'){
                                return '操作系统：' + operateSys + ';   浏览器：' + browser + ';   版本号：' + version
                            }else{
                                return ''
                            }
                        }() +'">'+clientTypeName+'</td>' +
                        '<td>'+clientVersion+'</td></tr>';
                }
                $('.queryJournalList').after(str);
                $(".checkChild").on("click",function () {
                    var state=$(this).prop("checked");
                    if(state==true){
                        $(this).prop("checked",true);
                    }else{
                        $('#checkedAll').prop("checked",false);
                        $(this).prop("checked",false);
                    }
                    var child =   $(".checkChild");
                    for(var i=0;i<child.length;i++){
                        var childstate= $(child[i]).prop("checked");
                        if(state!=childstate){
                            return
                        }
                    }
                    $('#checkedAll').prop("checked",state);
                })
            }
        })
    }
    $('#numBtn').on("click",function(){
        var pageSize = $('.num').val();
        queryShow(pageSize)
    })
    //查询数据导出
    /*function journalExport(){
        var id=$('#senduser').attr('dataid');
        if(!id){
            id='';
        }
        var data={
            'type':$('#journalType option:checked').val(),
            'uid':id,
            'startTime':$('#start').val(),
            'endTime':$('#end').val(),
            'ip':$('#IP').val(),
            'remark':$('#remarks').val()
        }
        $.ajax({
            type:'post',
            url:'../../sys/exportLogXls',
            dataType:'json',
            data:data,
            success:function(){
                alert('导出成功');
            }
        })
    }*/
    //查询数据删除
    function journalDelete(){
        var id=$('#senduser').attr('dataid');
        if(!id){
            id='';
        }
        var data={
            'type':$('#journalType option:checked').val(),
            'uid':id,
            'startTime':$('#start').val(),
            'endTime':$('#end').val(),
            'ip':$('#IP').val(),
            'remark':$('#remarks').val()
        };
        var msg=qued;
        if (confirm(msg)==true){
            $.ajax({
                type:'post',
                url:'../sys/deleteSyslog',
                dataType:'json',
                data:data,
                success:function(res){
                    console.log(res.flag);
                }
            });
            return true;
        }else{
            return false;
        }
    }
    //列表删除（可多条）
    function deleteAllJournal(id){
        var msg=qued;
        if (confirm(msg)==true){
            $.ajax({
                type:'post',
                url:'../sys/deleteLogByIds',
                dataType:'json',
                data:{'ids':id},
                success:function(res){
                    console.log(res.json);
                    queryShow();
                }
            });
            return true;
        }else{
            return false;
        }
    }
});
