/**
 * Created by 骆鹏 on 2018/1/8.
 */
function departmentAjax(callback){
    $.ajax({
        url:'../../department/getAlldept',
        type:'get',
        dataType:'json',
        success:function(obj){
            var data=obj.obj;
            var  departmentData= digui(data,0);
            callback(departmentData);
        }
    });
}
function queryTime(){
    function p(s) {
        return s < 10 ? '0' + s: s;
    }
    var myDate = new Date();
    //获取当前年
    var year=myDate.getFullYear();
    //获取当前月
    var month=myDate.getMonth()+1;
    //获取当前日
    var date=myDate.getDate();
    var h=myDate.getHours();       //获取当前小时数(0-23)
    var m=myDate.getMinutes();     //获取当前分钟数(0-59)
    var s=myDate.getSeconds();
    var now=year+'-'+p(month)+"-"+p(date)+" "+p(h)+':'+p(m)+":"+p(s);
    // var now=year+'-'+p(month)+"-"+p(date);
    return now;
}

//获得本周的开始日期
function getWeekStartDate() {
    var weekStartDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek);
    return formatDate(weekStartDate);
}

//获得本周的结束日期
function getWeekEndDate() {
    var weekEndDate = new Date(nowYear, nowMonth, nowDay + (6 - nowDayOfWeek));
    return formatDate(weekEndDate);
}

//获得本月的开始日期
function getMonthStartDate(){
    var monthStartDate = new Date(nowYear, nowMonth, 1);
    return formatDate(monthStartDate);
}

//获得本月的结束日期
function getMonthEndDate(){
    var monthEndDate = new Date(nowYear, nowMonth, getMonthDays(nowMonth));
    return formatDate(monthEndDate);
}
function digui(datas,departId) {
    var data=new Array();
    for(var i=0;i<datas.length;i++){
        if(datas[i].deptParent==departId){
            datas[i]["childs"]=digui(datas,datas[i].deptId);
            data.push(datas[i]);
        }
    }
    return data;
}
//格式化日期：yyyy-MM-dd
function formatDate(date) {
    var myyear = date.getFullYear();
    var mymonth = date.getMonth()+1;
    var myweekday = date.getDate();

    if(mymonth < 10){
        mymonth = "0" + mymonth;
    }
    if(myweekday < 10){
        myweekday = "0" + myweekday;
    }
    return (myyear+"-"+mymonth + "-" + myweekday);
}
//获得某月的天数
function getMonthDays(myMonth){
    var monthStartDate = new Date(nowYear, myMonth, 1);
    var monthEndDate = new Date(nowYear, myMonth + 1, 1);
    var days = (monthEndDate - monthStartDate)/(1000 * 60 * 60 * 24);
    return days;
}
//获得本季度的开始月份
function getQuarterStartMonth(){
    var quarterStartMonth = 0;
    if(nowMonth<3){
        quarterStartMonth = 0;
    }
    if(2<nowMonth && nowMonth<6){
        quarterStartMonth = 3;
    }
    if(5<nowMonth && nowMonth<9){
        quarterStartMonth = 6;
    }
    if(nowMonth>8){
        quarterStartMonth = 9;
    }
    return quarterStartMonth;
}
var now = new Date(); //当前日期
var nowDayOfWeek = now.getDay(); //今天本周的第几天
var nowDay = now.getDate(); //当前日
var nowMonth = now.getMonth(); //当前月
var nowYear = now.getYear(); //当前年
nowYear += (nowYear < 2000) ? 1900 : 0; //
$(function () {
    var opt_li_dep='<option value="0"  class="levelleft0">'+workflow_th_allpart+'</option><option value="01"  class="levelleft0" id="choose_more">'+hr_th_MultipleDepartments+'</option>';
    departmentAjax(function (departmentData) {
        opt_li_dep=  departmentChild(departmentData,opt_li_dep,0,-1);
        $('#dept_id').html(opt_li_dep);
    });
    var pageObj=$.tablePage('#pagediv','100%',[
        {
            width:'30%',
            title:xuhao,
            name:'',
            selectFun:function (n,obj,i) {
                return (i+1)
            }
        },
        {
            width:'40%',
            title:userManagement_th_department,
            name:'deptName'
        },
        {
            width:'30%',
            title:notice_th_PublicationQuantity,
            name:'count'
        },

    ],function (me) {
        me.data.fromDept=$('[name="type"]').val();
        me.data.beginTime=$('[name="beginTime"]').val();
        me.data.endTime=$('[name="endTime"]').val();

        //1显示  // 2不显示  //不写fn这个属性就是全显示
        me.init("/notice/getNotifyGroupFromDept")
    })

    $('.btnarrs').on('click',function () {
        var type=$(this).attr('data-type');
        switch(Number(type)) {
            case 1:
                pageObj.data.fromDept=$('[name="type"]').val();
                pageObj.data.beginTime=$('[name="beginTime"]').val();
                pageObj.data.endTime=$('[name="endTime"]').val();
                pageObj.data.sendTime='';
                pageObj.init()
                break;
            case 2:
                window.location.href= '/notice/outputNotify?fromDept='+$('[name="type"]').val()+'&beginTime='+$('[name="beginTime"]').val()+'&endTime='+$('[name="endTime"]').val()+'&step=1';
            break;
            case 3:
                pageObj.data.fromDept=$('[name="type"]').val();
                pageObj.data.beginTime='';
                pageObj.data.endTime='';
                pageObj.data.sendTime=queryTime()
                pageObj.init()
                break;
            case 4:
                pageObj.data.fromDept=$('[name="type"]').val();
                pageObj.data.beginTime=getWeekStartDate();
                pageObj.data.endTime=getWeekEndDate();
                pageObj.data.sendTime='';
                pageObj.init()
                break;
            case 5:
                pageObj.data.fromDept=$('[name="type"]').val();
                pageObj.data.beginTime=getMonthStartDate();
                pageObj.data.endTime=getMonthEndDate();
                pageObj.data.sendTime='';
                pageObj.init()
                break;
            case 6:
                var myDate = new Date();
                //获取当前年
                var year=myDate.getFullYear();
                pageObj.data.fromDept=$('[name="type"]').val();
                pageObj.data.beginTime=year + "-01-01";
                pageObj.data.endTime=year + "-12-31";
                pageObj.data.sendTime='';
                pageObj.init()
                break;

        }
    })


})