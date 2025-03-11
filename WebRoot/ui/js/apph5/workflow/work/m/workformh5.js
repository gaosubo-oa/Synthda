var userId = '';
$.ajax({
    type: "post",
    url: "/users/getUserTheme",
    dataType: 'json',
    async:false,
    success: function (res) {
        var data = res.object;
        userId = data.userId;
    }
})
var workformh5;
var backoff
//获取国际语言标志
var type = getCookie("language");
var qzhb='';
if (type == 'zh_CN') {
    qzhb = "此步骤为强制合并步骤，尚有步骤未转至此步骤，您不能继续转交下一步！";
} else if (type == 'en_US') {
    qzhb = "This step is a mandatory merge step, and there are still steps that you can't move forward. You can't proceed to the next step!";
} else if (type == 'zh_TW') {
    qzhb = "此步驟為強制合並步驟，尚有步驟未轉至此步驟，您不能繼續轉交下壹步！";
} else {
    qzhb = "此步骤为强制合并步骤，尚有步骤未转至此步骤，您不能继续转交下一步！";
}
var beforeToken = '';
/**********************与移动端交流时间控件调用*****************************************/
var timename = '';
function getWeek(date) {
    var week;
    if(date.getDay() == 0) week = "周日"
    if(date.getDay() == 1) week = "周一"
    if(date.getDay() == 2) week = "周二"
    if(date.getDay() == 3) week = "周三"
    if(date.getDay() == 4) week = "周四"
    if(date.getDay() == 5) week = "周五"
    if(date.getDay() == 6) week = "周六"
    return week;
}
function timeclick(e){
    timename = e.attr('name');
    if(e.attr('dates_format').indexOf('hh:mm:ss') == -1){
        var cs = '0';
    }else{
        var cs = '1';
    }
    if($.getQueryString("type") != 'EWC'){
        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
            try{
                window.webkit.messageHandlers.setSelectTime.postMessage({'num':cs});
            }catch(err){
                setSelectTime(cs);
            }

        } else if (/(Android)/i.test(navigator.userAgent)) {
            Android.setSelectTime(cs);
        }
    }
}
function autoclik(e) {
    var __this = $('#'+e.attr('target'))
    $.ajax({
        type: "post",
        url: "/document/updateCount",
        dataType: 'JSON',
        data:{
            id:__this.attr('uuid')

        },
        beforeSend : function(request) {
            if(beforeToken != ''){
                request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
            }
        },
        success: function (obj) {
            if(obj.flag){
                __this.attr("value",obj.object.expressionStr)
            }
        }
    })
}
function timeclickjs(time){
    $('input[name='+ timename +']').val(time).trigger('propertychange');
}
function calcutargetTime(obj){
    var targetId = obj.attr('calcutarget')||'';
    targetId = targetId.split(',');
    targetId.forEach(function (item,i) {
        var targetObj = $('#'+item) ;
        if(targetObj.attr('disabled') == 'disabled'){
            return false;
        }
        if(targetObj.val()==undefined||targetObj.val()=='undefined'){
            return false;
        }
        var prec = targetObj.attr('prec')||3;
        var calculationValue = targetObj.attr('formula');
        calculationValue = $.transforFormula(calculationValue,workformh5.tool.getFormDatasKeyValue());
        var vv = '';
        if(calculationValue.indexOf('DAY') >-1){
            vv = execC(calculationValue,2);
            if(vv.indexOf('.')>-1){
                var float32nUM = parseFloat(vv.split('.')[1])/100;
                if(float32nUM < 0.17){
                    vv = vv.split('.')[0];
                }else if(float32nUM <= 0.5){
                    vv = vv.split('.')[0] + '.5';
                }else if(float32nUM > 0.5){
                    vv = parseFloat(vv.split('.')[0])+1;
                }
            }
            // vv= Math.floor(vv);

        }else{
            vv = execC(calculationValue,prec)
        }
        targetObj.val(vv).trigger("propertychange");
    });
}
var globalData = {};
var turn = function(){
    //alert("正在加载。。");
}
var opflagturnClick;
function covertToFormData(formdata){
    var data = {};
    if(formdata instanceof Array){
        formdata.forEach(function(v,i){
            data[v.key] =  v.value;
        });
    }
    return data;
}
function covertToPrcsOutSet(data){
    data = data.replace(/or/g,'||')
    data = data.replace(/and/g,'&&')
    return data;
}
function myTrim(x) {
    return x.replace(/^\s+|\s+$/gm,'');
}
function checkTileValue(item_value,rule,item_title){
    var checkpass = 0;
    if(item_value != ''){
        if(typeof item_value == 'string'){
            if(item_value.indexOf('-')>-1||item_value.indexOf(':')>-1){
                var item_value =  item_value
            }else{
                if(item_title != 'shu'){
                    var item_value = parseFloat(item_value)  || item_value ;
                }
            }
        }else{
            var item_value = parseFloat(item_value)  || item_value ;
        }


    }else{
        var item_value =  item_value;
    }
    if(item_title != ''){
        if(typeof item_title =='string'){
            if(item_title.indexOf('-')>-1||item_title.indexOf(':')>-1){
                var item_title = item_title
            }else{
                var item_title =  parseFloat(item_title) || item_title ;
            }
        }else{
            var item_title =  parseFloat(item_title) || item_title ;
        }

    }else{
        var item_title =  item_title;
    }
    var date = /^(\d{4})-(0\d{1}|1[0-2])-(0\d{1}|[12]\d{1}|3[01])$/;
    var time = /^(((?!0000)[0-9]{4}-((0[1-9]|1[0-2])-(0[1-9]|1[0-9]|2[0-8])|(0[13-9]|1[0-2])-(29|30)|(0[13578]|1[02])-31)|([0-9]{2}(0[48]|[2468][048]|[13579][26])|(0[48]|[2468][048]|[13579][26])00)-02-29)) (20|21|22|23|[0-1]?\d):[0-5]?\d:[0-5]?\d$/


    switch (rule) {
        case '=':
            var reDateTime = /^(?:19|20)[0-9][0-9]-(?:(?:0[1-9])|(?:1[0-2]))-(?:(?:[0-2][1-9])|(?:[1-3][0-1])) (?:(?:[0-2][0-3])|(?:[0-1][0-9])):[0-5][0-9]:[0-5][0-9]$/;
            if(item_title == 'shu'&&!isNaN(item_value)){
                if(item_value != ''){
                    checkpass = 1;
                }
            }else if(item_title == 'date'&& /^(\d{4})-(0\d{1}|1[0-2])-(0\d{1}|[12]\d{1}|3[01])$/.test(item_value)){
                checkpass = 1;
            }else if(item_title == 'time'&& !reDateTime.test(item_value)){
                checkpass = 1;
            }else if (item_title == item_value) {
                checkpass = 1;
            }
            break;
        case '!=':
            var reDateTime = /^(?:19|20)[0-9][0-9]-(?:(?:0[1-9])|(?:1[0-2]))-(?:(?:[0-2][1-9])|(?:[1-3][0-1])) (?:(?:[0-2][0-3])|(?:[0-1][0-9])):[0-5][0-9]:[0-5][0-9]$/;
            if(item_title == 'shu'&&isNaN(item_value)){
                if(item_value != ''){
                    checkpass = 1;
                }
            }else if(item_title == 'date'&& !/^(\d{4})-(0\d{1}|1[0-2])-(0\d{1}|[12]\d{1}|3[01])$/.test(item_value)){
                checkpass = 1;
            }else if(item_title == 'time'&& reDateTime.test(item_value)){
                checkpass = 1;
            }else if (item_title != item_value) {
                checkpass = 1;
            }
            break;
        case '<>':
            if(date.test(item_title) && date.test(item_value)){
                if(new Date(item_title.replace(/-/g, "/")).getTime()!=new Date(item_value.replace(/-/g, "/")).getTime()){
                    checkpass = 1;
                }
            }else if(time.test(item_title) && time.test(item_value)){
                if(new Date(item_title.replace(/-/g, "/")).getTime()!=new Date(item_value.replace(/-/g, "/")).getTime()){
                    checkpass = 1;
                }
            }else if (item_title != item_value) {
                checkpass = 1;
            }
            break;
        case '>':
            if(date.test(item_title) && date.test(item_value)){
                if(new Date(item_value.replace(/-/g, "/")).getTime()>new Date(item_title.replace(/-/g, "/")).getTime()){
                    checkpass = 1;
                }
            }else if(time.test(item_title) && time.test(item_value)){
                if(new Date(item_value.replace(/-/g, "/")).getTime()>new Date(item_title.replace(/-/g, "/")).getTime()){
                    checkpass = 1;
                }
            }else if ( item_value >  item_title) {
                checkpass = 1;
            }
            break;
        case '<':
            if(date.test(item_title) && date.test(item_value)){
                if(new Date(item_value.replace(/-/g, "/")).getTime()<new Date(item_title.replace(/-/g, "/")).getTime()){
                    checkpass = 1;
                }
            }else if(time.test(item_title) && time.test(item_value)){
                if(new Date(item_value.replace(/-/g, "/")).getTime()<new Date(item_title.replace(/-/g, "/")).getTime()){
                    checkpass = 1;
                }
            }else if (item_value < item_title) {
                checkpass = 1;
            }
            break;
        case '<=':
            if(date.test(item_title) && date.test(item_value)){
                if(new Date(item_value.replace(/-/g, "/")).getTime()<=new Date(item_title.replace(/-/g, "/")).getTime()){
                    checkpass = 1;
                }
            }else if(time.test(item_title) && time.test(item_value)){
                if(new Date(item_value.replace(/-/g, "/")).getTime()<=new Date(item_title.replace(/-/g, "/")).getTime()){
                    checkpass = 1;
                }
            }else if (item_value <=  item_title) {
                checkpass = 1;
            }
            break;
        case '>=':
            if(date.test(item_title) && date.test(item_value)){
                if(new Date(item_value.replace(/-/g, "/")).getTime()>=new Date(item_title.replace(/-/g, "/")).getTime()){
                    checkpass = 1;
                }
            }else if(time.test(item_title) && time.test(item_value)){
                if(new Date(item_value.replace(/-/g, "/")).getTime()>=new Date(item_title.replace(/-/g, "/")).getTime()){
                    checkpass = 1;
                }
            }else if (item_value >=  item_title) {
                checkpass = 1;
            }
            break;
        case 'include':
            if(item_value==''){
                if(item_title==''){
                    checkpass = 1;
                }
            }else{
                item_value = String(item_value);
                if (item_value.indexOf(item_title) > -1) {
                    checkpass = 1;
                }
            }
            break;
        case 'exclude':
            if(item_value==''){
                if(item_title==''){
                    checkpass = 1;
                }
            }else{
                item_value = String(item_value);
                if(item_value!=''){
                    if (item_value.indexOf(item_title) == -1) {
                        checkpass = 1;
                    }
                }
            }
            break;
    }
    return checkpass;
}
function checkPrcOut(formdata,fromDataReject,cb){
    var msg = globalData.conditionDesc.split('\n')[1];
    var res = {
        flag:true,
        msg:""
    };
    if(msg){
        res.msg = msg;
    }else{
        res.msg =  '不符合条件！'
    }
    var prcsOut = globalData.prcsOut;
    var prcsOutSet = globalData.prcsOutSet;
    var arrtest = [];
    var prcsOutArr = prcsOut.split('\n');
    for(var i=0;i<prcsOutArr.length;i++){
        if(prcsOutArr[i]){
            arrtest.push(prcsOutArr[i])
        }
    }
    if(arrtest.length == 1 && prcsOutSet == ''){
        prcsOutSet='[1]';
    }
    if(prcsOutSet != ""){
        var prcsOutArr = prcsOut.split('\n');
        formdata = covertToFormData(formdata);


        prcsOutArr.forEach(function(v,i){
            if(v){
                var check_pass = 0;
                var titleValue = '';
                var arr_rule = v.split("'");
                var item_title = myTrim(arr_rule[1]);
                var item_con = myTrim(arr_rule[2]);
                var item_value = myTrim(arr_rule[3]);
                //用来处理 特殊情况单选框控件，无法通过id来选择到元素的情况
                var item_pag = $('[Id="'+fromDataReject[item_title]+'"]');
                if(item_pag.length == 0&&$('[name='+ fromDataReject[item_title] +']').eq(0).attr('data-type') == 'radio'){
                    item_pag = $('input[name='+ fromDataReject[item_title] +']:checked');
                }

                if(v.indexOf('[')<=-1){
                    if(item_pag.attr('data-type')=='macros'&&item_pag.attr('datafld')=='SYS_USERNAME'&&item_pag.attr('orgsignImg')==1){
                        if(item_pag.prev().find('img').attr('src')!=undefined&&item_pag.prev().find('img').attr('src')!=''&&item_pag.prev().find('img').attr('src').indexOf('AID')>=0){
                            titleValue = item_pag.prev().find('img').attr('src');
                        }else{
                            titleValue = formdata[fromDataReject[item_title]];
                        }
                    }else{
                        titleValue = formdata[fromDataReject[item_title]];
                        //针对宏主角色列表控件  需要对titleValue进行处理
                        if(item_pag.attr('data-type')=='macros'&&item_pag.attr('datafld')=='SYS_LIST_PRIV_ONLY'){
                            titleValue=item_pag.find('option:selected').text()
                        }
                        //针对宏部门列表控件  需要对titleValue进行处理
                        else if(item_pag.attr('data-type')=='macros'&&item_pag.attr('datafld')=='SYS_LIST_DEPT'){
                            titleValue=item_pag.find('option:selected').attr('deptname')
                        }
                        //针对宏人员列表控件  需要对titleValue进行处理
                        else if(item_pag.attr('data-type')=='macros'&&item_pag.attr('datafld')=='SYS_LIST_USER'){
                            titleValue=item_pag.find('option:selected').text()
                        }
                        //针对宏辅助角色列表控件  需要对titleValue进行处理
                        else if(item_pag.attr('data-type')=='macros'&&item_pag.attr('datafld')=='SYS_LIST_PRIV_OTHER'){
                            titleValue=item_pag.find('option:selected').text()
                        }
                        //针对宏部门主管（上级部门）列表控件  需要对titleValue进行处理
                        else if(item_pag.attr('data-type')=='macros'&&item_pag.attr('datafld')=='SYS_LIST_MANAGER2'){
                            titleValue=item_pag.find('option:selected').text()
                        }
                        //针对宏部门主管（一级部门）列表控件  需要对titleValue进行处理
                        else if(item_pag.attr('data-type')=='macros'&&item_pag.attr('datafld')=='SYS_LIST_MANAGER3'){
                            titleValue=item_pag.find('option:selected').text()
                        }
                        //该判断为部门选择控件 和 用户选择控件时，需对titleValue处理
                        else if(item_pag.attr('data-type') == 'deptselect' || item_pag.attr('data-type') == 'userselect'){
                            if(titleValue&&titleValue.indexOf('|')>-1){
                                titleValue = titleValue.split('|')[1];
                                if(titleValue.substring(titleValue.length-1,titleValue.length) == ','){
                                    titleValue = titleValue.substring(0,titleValue.length-1);
                                }
                            }
                        }
                    }

                }else{
                    if(item_title == '[当前步骤号]' || item_title == '[CUR_PRCS_ID]'){
                        titleValue = globalData.flowRunPrcs.prcsId
                    }else if(item_title == '[当前主办人姓名]' || item_title == '[CUR_USER_NAME]'){
                        titleValue = globalData.userName;
                    }else if(item_title == '[公共附件名称]' || item_title == '[ATTACH_NAME]'){
                        titleValue = '';
                        for(var j=0;j<$('#oneUploadFile .item_wordH1').length;j++){
                            if($('#oneUploadFile .item_wordH1').length ==1){
                                titleValue = GetFileNameNoExt($('#oneUploadFile .item_wordH1').eq(j).attr('title'))
                            }else{
                                titleValue += GetFileNameNoExt($('#oneUploadFile .item_wordH1').eq(j).attr('title')) + ','
                            }
                        }
                    }else if(item_title == '[公共附件个数]' || item_title == '[ATTACH_COUNT]'){
                        titleValue = $('#oneUploadFile .item_wordH1').length;
                    }else if(item_title == '[当前流程设计步骤号]' || item_title == '[CUR_FLOW_PRCS]'){
                        titleValue = globalData.flowRunPrcs.flowPrcs
                    }else if(item_title == '[当前主办人角色]' || item_title == '[CUR_USER_PRIV]'){
                        titleValue = workForm.tool.MacrosData.data.sYS_USERPRIV
                    }else if(item_title == '[当前主办人角色_辅助角色]' || item_title == '[CUR_USER_PRIV_OTHER]'){
                        var thisd = workForm.tool.MacrosData.data.sYS_USERPRIVOTHER;
                        if(thisd.substr(thisd.length-1,thisd.length) == ','){
                            thisd = thisd.substr(0,thisd.length-1);
                        }
                        titleValue = thisd;
                    }else if(item_title == '[当前主办人部门]' || item_title == '[CUR_USER_DEPT]'){
                        titleValue = workForm.tool.getMacrosData('SYS_DEPTNAME_SHORT')()
                    }else if(item_title == '[当前主办人上级部门]' || item_title == '[CUR_USER_DEPT_PARENT]'){
                        titleValue = workForm.tool.getMacrosData('SYS_MANAGER2')()
                    }else if(item_title == '[主办人会签意见]' ||　item_title == '[MAIN_USER_SIGN]'){
                        var data = globalData.sign;
                        titleValue=""
                        if(data!=''&&data!=undefined){
                            for(var j=0;j<data.length;j++){
                                if(data[j].opFlag == 1){
                                    titleValue += data[j].content
                                }
                            }
                        }
                    }else if(item_title == '[经办人会签意见]' || item_title == '[USER_SIGN]'){
                        var data = globalData.sign;
                        titleValue=""
                        if(data!=''&&data!=undefined){
                            for(var j=0;j<data.length;j++){
                                if(data[j].opFlag == 0){
                                    titleValue += data[j].content
                                }
                            }
                        }

                    }
                }
                /*********处理新版会签控件的数据开始**************/
                if(item_pag.length > 0
                    && item_pag.attr('data-type') == 'sign'
                    && titleValue == ''){
                    $.ajax({
                        type: "post",
                        url: "/Countersignature/getSignfeedback",
                        dataType: 'JSON',
                        data: {
                            'runId': workForm.option.runId,
                            'flag': 1,
                            'feedFlag': item_pag.attr('name').split('DATA_')[1],
                            'userIds': ''
                        },
                        async:false,
                        success: function (json) {
                            if(json.obj.length > 0){
                                for(var i=0;i<json.obj.length;i++){
                                    titleValue += json.obj[i].content;
                                }
                            }
                        }
                    })
                }
                /*********处理新版会签控件的数据结束**************/
                // 判断 第二个值是字段还是类型
                if(fromDataReject[item_value]){//如果是字段并且是表单中字段的话
                    item_value = formdata[fromDataReject[item_value]];
                }else{
                    if(item_value.indexOf('[')>-1){ //如果是字段并且不是表单中字段
                        if(item_value == '[当前步骤号]' || item_value == '[CUR_PRCS_ID]'){
                            item_value = globalData.flowRunPrcs.prcsId
                        }else if(item_value == '[当前主办人姓名]' ||item_value == '[CUR_USER_NAME]'){
                            item_value = globalData.userName;
                        }else if(item_title == '[公共附件名称]'　|| item_title == '[ATTACH_NAME]'){
                            item_value = item_value;
                        }else if(item_title == '[公共附件个数]' || item_title == '[ATTACH_COUNT]'){
                            item_value = item_value;
                        }else if(item_value == '[当前流程设计步骤号]' || item_value == '[CUR_FLOW_PRCS]'){
                            item_value = globalData.flowRunPrcs.flowPrcs
                        }else if(item_value == '[当前主办人角色]' || item_value == '[CUR_USER_PRIV]'){
                            item_value = $.cookie('userPrivName')||workForm.tool.MacrosData.data.sYS_USERPRIV;
                        }else if(item_title == '[当前主办人角色_辅助角色]' || item_title == '[CUR_USER_PRIV_OTHER]'){
                            var thisd = workForm.tool.MacrosData.data.sYS_USERPRIVOTHER;
                            if(thisd.substr(thisd.length-1,thisd.length) == ','){
                                thisd = thisd.substr(0,thisd.length-1);
                            }
                            titleValue = thisd;
                        }else if(item_value == '[当前主办人部门]' || item_value == '[CUR_USER_DEPT]'){
                            item_value = workForm.tool.getMacrosData('SYS_DEPTNAME_SHORT')()
                        }else if(item_value == '[当前主办人上级部门]' ||item_value == '[CUR_USER_DEPT_PARENT]'){
                            item_value = workForm.tool.getMacrosData('SYS_MANAGER2')()
                        }else if(item_value == '[主办人会签意见]'　|| item_value == '[MAIN_USER_SIGN]'){
                            var data = globalData.sign;
                            item_value=""
                            for(var j=0;j<data.length;j++){
                                if(data[j].opFlag == 1){
                                    item_value += data[j].content
                                }
                            }
                        }else if(item_value == '[经办人会签意见]' ||item_value == '[USER_SIGN]'){
                            var data = globalData.sign;
                            item_value=""
                            for(var j=0;j<data.length;j++){
                                if(data[j].opFlag == 0){
                                    item_value += data[j].content
                                }
                            }
                        }
                    }else{ //如果是类型值的话
                        if(item_value == '数值'){
                            item_value = 'shu'
                        }else if(item_value == '日期'){
                            item_value = 'date'
                        }else if(item_value == '时间+日期'){
                            item_value = 'time';
                        }else{
                            item_value = item_value;
                        }
                    }
                }
//                           console.log(item_value)
                if(titleValue == undefined){
                    res.msg = '条件设置有误，不存在“'+item_title+'”字段，请联系系统管理员前往流程设计器修改！';
                }else{
                    //该判断为部门选择控件 且 条件为等于 时，调用judgeResult()方法来判断用户选择框和条件设置框字段是否相同（不论排序）
                    if(item_pag.attr('data-type') == 'deptselect'&&item_con=='='  ||  item_pag.attr('data-type') == 'userselect'&&item_con=='=' ){
                        check_pass=judgeResult(titleValue,item_value)
                    }
                    //该判断为部门选择控件 且 条件为不等于 时，调用judgeResult()方法来判断用户选择框和条件设置框字段是否相同（不论排序）
                    else if(item_pag.attr('data-type') == 'deptselect'&&item_con=='!=' || item_pag.attr('data-type') == 'userselect'&&item_con=='!='){
                        check_pass=!judgeResult(titleValue,item_value)
                    }
                    else{
                        check_pass = checkTileValue(titleValue,item_con,item_value);
                    }
                }
                var setitem = (i+1)
                var reg = new RegExp('\\['+setitem+'\\]',"g");//g,表示全部替换。

                prcsOutSet = prcsOutSet.replace(reg,check_pass);
            }
        });
        prcsOutSet = covertToPrcsOutSet(prcsOutSet.toLowerCase());
        if(prcsOutSet.indexOf('（') > -1 ||prcsOutSet.indexOf('）') > -1){
            prcsOutSet = prcsOutSet.replace(/\（/g, "(").replace(/\）/g, ")");
        }
        var result = eval(prcsOutSet);

        if(result == 0){
            res.flag = false;
        }
    }
    if(cb){
        cb(res);
    }
};

//判断部门选择控件 和 用户选择控件 中用户选择字段和条件设置字段是否相同(条件设置为 等于 时)
function judgeResult(titleValue,item_value) {
    var flag = 1
    if(titleValue!==undefined && item_value!==undefined){
        titleValue=titleValue.split(',')
        item_value=item_value.split(',')
    }
    if (titleValue.length !== item_value.length) {
        flag = 0
    } else {
        titleValue.forEach(function (item) {
            if (item_value.indexOf(item) === -1) {
                flag = 0
            }
        })
    }
    return flag;
}
function checkttachPriv(privNum){
    if(attachPriv.indexOf(privNum) > -1){
        return true;
    }
    return false   ;
}
var object = {};
var arrobject = [];
//初始化下拉控件
function initSelect() {
    createSelectArr();
    //初始化下拉菜单
    firstSelectArr.forEach(function(n, i){
        selectChange(n);
    });
}
//selectArr储存所有的下拉菜单
var selectArr = new Array();
//缓存顶级下拉菜单
var firstSelectArr = new Array();
var restoreFlag = false;
function createSelectArr() {
    allSelect = $("select");
    //首次循环，将下拉菜单值保存为全局变量多维数组
    allSelect.each(function(){
        var field_name = $(this).attr("name");

        selectArr[field_name] = new Array();
        $(this).children().each(function(i, e){
            selectArr[field_name][i] = e.value;
        });
    });
    //再次循环，所有的父菜单存到数组中，用于更新状态
    allSelect.each(function(i){
        //赋重写事件
        $(this).change(function(){
            selectChange($(this).attr("name"));
        });
        //判断有子菜单的
        if($(this).attr("child")) {
            var temp = $(this).attr("title");
            if(!$("select[child='"+temp+"']")[0] ) {
                firstSelectArr[i] = jQuery(this).attr("name");
            }
        }
    });
}
//处理关联菜单的子菜单选项,传入：关联菜单
function selectChange(Select) {
    var SelectObj = $("select[name='"+Select+"']");
    var parent_str = "|"+$(SelectObj).val();
    if($(SelectObj).attr("child") != undefined) {
        //子对象
        var childObj = $("select[title='"+$(SelectObj).attr("child")+"']");
        if(childObj.length == 0){return false;}
        //记录原始数据，重写option后用此值恢复
        var childVal = $(childObj).val();
        //先删除所有option
        childObj.children().remove();
        //循环添加option
        selectArr[$(childObj).attr("name")].forEach(function(n, i){
            if(restoreFlag){
                if(parent_str!='|' && n.indexOf(parent_str) != -1)
                {
                    var val_arr = n.split("|");
                    $(childObj).append("<option value='"+n+"'>"+val_arr[0]+"</option>");
                }
            }else{
                var val_arr = n.split("|");
                $(childObj).append("<option value='"+n+"'>"+val_arr[0]+"</option>");
            }
        });
        childObj.val(childVal);
        selectChange($(childObj).attr("name"));
    }
    else {
        return;
    }
}
/************和后台获取附件信息的方法************************/
function getFileInfo(runid,type){
    $.ajax({
        type: "get",
        url: "/workflow/work/findworkUpload",
        dataType: 'JSON',
        data: {
            runId:runid
        },
        beforeSend : function(request) {
            if(beforeToken != ''){
                request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
            }
        },
        success: function (obj) {
            var data = obj.obj;
            var img = '';
            var names = '';
            var editbtn= '';
            let macroAttach = '';
            if(type == '1'){
                $('#basic_infor').find('input[datafld="SYS_FLOW_PUBLICFILE"]').parent().children('.publicFile').remove()
            }
            for(var i=0;i<obj.obj.length;i++){
                var pic_name = obj.obj[i].attachName;
                var index = pic_name .lastIndexOf("\.");
                pic_name = pic_name.substring(index + 1, pic_name .length);
                var http = location.origin;
                var attachmentUrl = obj.obj[i].attUrl;
                if(checkttachPriv(3)){
                    editbtn = ' inline-block;;';
                }else{
                    editbtn = 'none;';
                }
                var fileIcon='';
                if(datatyoe[pic_name] == undefined){ //处理附件图标
                    fileIcon = 'file';
                }else{
                    fileIcon = datatyoe[pic_name];
                }
                macroAttach += '<img src="/img/attachmentIcon/'+fileIcon+'.png" align="absmiddle" style="float: none;width: auto;height: auto;">&nbsp;' +
                    '<a href="javascript:void(0)" onclick="'+ function(){
                        if($.getQueryString("type") == 'EWC'){
                            return 'lookEwx($(this))'
                        }else {
                            return 'anios($(this))'
                        }
                    }()+ '" url="'+ http + '/xs?'+ obj.obj[i].attUrl +'" attUrl="'+ obj.obj[i].attUrl +'" name="'+ obj.obj[i].attachName +'" style="color: #0088cc;">'+ obj.obj[i].attachName +'</a>&nbsp;&nbsp;&nbsp;&nbsp;'

                if(pic_name == "png"||pic_name == "jpeg"||pic_name == "bmp"||pic_name == "jpg"){
                    img += '<a style="display: none" href="/xs?'+ obj.obj[i].attUrl +'" >下载</a><img id="blah" atturl="'+encodeURI(attachmentUrl)+'" src="/xs?'+ obj.obj[i].attUrl +'" onclick="anios($(this))" style="width:50px;height:50px;margin-right: 10px;margin-bottom: 10px;" url="'+ http + '/xs?'+ obj.obj[i].attUrl +'" name="'+ obj.obj[i].attachName +'">'+
                        '<span style="color: red;margin-left:15px;cursor:pointer; display: '+editbtn+'" class="deletefileBtn" atturl="'+encodeURI(attachmentUrl)+'">×删除</span></br>';
                }else{
                    if($.getQueryString("type") == 'EWC'){
                        names += '<p><a style="margin-bottom: 5px;color: #095de0;" atturl="'+encodeURI(attachmentUrl)+'" url="'+encodeURI(attachmentUrl)+'" href="javascript:void(0)" names="'+ obj.obj[i].attachName +'" onclick="lookEwx($(this),0)">'+ obj.obj[i].attachName +'</a></p>'+
                            '<span style="color: red;margin-left:15px;cursor:pointer; display: '+editbtn+'" class="deletefileBtn" atturl="'+encodeURI(attachmentUrl)+'">×删除</span></br>'
                    }else {
                        names += '<p url="'+ http + '/download?'+ obj.obj[i].attUrl +'" atturl="'+encodeURI(attachmentUrl)+'" name="'+ obj.obj[i].attachName +'" onclick="anios($(this))">'+ obj.obj[i].attachName +'' +
                            '</p>'+
                            '<span style="color: red;cursor:pointer; margin-left:15px;display: '+editbtn+'" class="deletefileBtn" atturl="'+encodeURI(attachmentUrl)+'">×删除</span></br>'
                    }
                }

            }
            if(type != '1'){
                $('.photo_box').append(img);
                $('.uploadbox').append(names);
            }
            // 兼容宏标记控件数据-公共附件区上传文件
            var formFile = $('#basic_infor').find('input[datafld="SYS_FLOW_PUBLICFILE"]');
            if(formFile != null && formFile != undefined &&formFile.length>0){
                var fileValue = macroAttach||'';
                for(let i=0;i<formFile.length;i++){
                    $('#basic_infor').find('input[datafld="SYS_FLOW_PUBLICFILE"]').parent().append('<span macro-id="macro-attach-" style="" class="publicFile">'+ fileValue +'</span>')
                }
            }
        }
    });
}
var runid;
$(function () {
    var delForm = ''
    var delFormImg = ''
    layer.load();
    var history = document.referrer;
    var savebtn = false;
    globalData.flowId = $.getQueryString("flowId");
    globalData.flowStep = $.getQueryString("flowStep") || '';
    globalData.prcsId = $.getQueryString("prcsId") || '';
    globalData.runId = $.getQueryString("runId") || '';
    globalData.tableName = $.getQueryString("tableName") || '';
    globalData.tabId =  $.getQueryString("tabId") || '';

    if(window.location.href.indexOf('&runname=') > -1){
        var runnames = window.location.href.split('&runname=')[1].split('&lang=')[0];
        globalData.runname = decodeURIComponent(runnames.replace(/\+/g,'%20'));


    }else{
        globalData.runname = '';
    }
    var gobackIndex = 0;
    workformh5 = {
        /************移动端工作流的初始化方法************************/
        init:function (cb) {
            var _this = this;
            workForm.init({
                formhtmlurl:'/workflow/work/workfastAdd',//URL
                resdata:{
                    flowId:globalData.flowId,
                    runId:globalData.runId=='no'?'':globalData.runId,
                    prcsId:globalData.prcsId,
                    flowStep:globalData.flowStep,
                    tableName:globalData.tableName,
                    tabId:globalData.tabId
                },
                flowStep:globalData.prcsId,//预览
                ish5:true,
                target:'.cont_form',
                beforeToken:beforeToken
            }, function (data,option,target) {
                workForm.inited = true;
                var obj = data.object;
                globalData.flowRun = obj.flowRun;
                globalData.flowFormType = obj.flowFormType;
                globalData.listFp = obj.listFp;
                globalData.flowRunPrcs = obj.flowRunPrcs;
                globalData.option = option;
                globalData.flowTypeModel = obj.flowTypeModel;
                globalData.attachPriv = obj.attachPriv;
                globalData.allowBack = obj.allowBack;
                globalData.flowPrcs = obj.flowRunPrcs.flowPrcs;
                flowPrcs =  data.object.flowRunPrcs.flowPrcs;
                globalData.signlock = obj.signlock;
                globalData.conditionDesc = obj.conditionDesc;
                globalData.prcsOut = obj.prcsOut;
                globalData.flowProcesses = obj.flowProcesses;
                globalData.prcsType = obj.flowProcesses.prcsType;
                globalData.prcsOutSet = obj.prcsOutSet;
                attachPriv = obj.attachPriv;
                globalData.gatherNodePriv = obj.gatherNodePriv;
                feedback = obj.feedback;
                globalData.opflag = obj.flowRunPrcs.opFlag||'';
                globalData.feedback = obj.feedback;
                globalData.checkTurnPriv = obj.checkTurnPriv;

                $('#step').val('第'+globalData.flowStep+'步：'+obj.flowProcesses.prcsName);
                if(feedback == '1'){
                    $('#signText').attr("disabled","disabled").addClass('grey');
                    $('.sign_btn').hide();
                    $('#signSendBtn').hide()
                    $('#signBtn').hide()
                    $('#hqblock').css('display','none')
                    $('#hqblock2').css('display','none')
                }else if(feedback == '-1'){
                    $('#signModule').hide();
                    $('.signBoxApp').hide();
                }
                if(globalData.signlock == 1){
                    $('.gapp_textarea').attr("disabled",true);
                }
                if(checkttachPriv(1)){
                    $('.xzbtn').show();
                }else{
                    $('.xzbtn').hide();
                }
                runid = data.object.flowRun.runId;
                if(globalData.flowStep != '1'&&globalData.opflag == '1'){
                    if(obj.flowRunPrcs.otherUser == undefined||obj.flowRunPrcs.otherUser.trim() == ""){
                        $('#weituo').show();
                    }
                }
                delForm = data.object.flowProcesses.fileuploadPriv
                delFormImg= data.object.flowProcesses.imguploadPriv||'';
                /*********************工作交办按钮显示方法*************************/
                if (globalData.flowProcesses && globalData.flowProcesses.operationButton && globalData.flowProcesses.operationButton.indexOf('8') > -1) {
                    $.ajax({
                        type: 'GET',
                        url: '/operation/selFlowOperationById?opId=8',
                        async: false,
                        success: function(res) {
                            if (res.flag) {
                                $('#assignment').show();
                            }
                        }
                    });
                }

                /*********************交办详情按钮显示方法*************************/
                $.get('/flowAssign/query', {runId: globalData.flowRun.runId}, function(res){
                    if (res.flag) {
                        $('#assignmentDetail').show();
                    }
                });

                /*********************判断是否显示相关流程(父子流程和关联流程)*************************/
                $.get('/workflow/work/prentAndSonFlow', {runId: globalData.flowRun.runId}, function (json) {
                    var parentRunId = '';
                    if (json.flag) {
                        var str2 = '';
                        if (json.object) {
                            parentRunId = json.object.runId;
                            str2 += '<tr><td>父流程</td><td><a flowid="' + json.object.flowId + '" runid="' + json.object.runId + '" href="javascript:;" style="color: blue;" class="open_flow_work">' + json.object.runName + '</a></td></tr>';
                        }
                        if (json.obj.length != 0) {
                            json.obj.forEach(function(item){
                                str2 += '<tr><td>子流程</td><td><a flowid="' + item.flowId + '" runid="' + item.runId + '" href="javascript:;" style="color: blue;" class="open_flow_work">' + item.runName + '</a></td></tr>';
                            })
                        }
                        $('.connect_work_table').append(str2);
                        if (str2 != '') {
                            $('.connect_work').show();
                        }
                    }
                    // 获取关联流程数据
                    $.get('/flowRun/findrelationRunIds', {runId: globalData.flowRun.runId+','+parentRunId}, function (res) {
                        if (res.flag && res.obj.length > 0) {
                            var str = '';
                            res.obj.forEach(function (item) {
                                str += '<tr><td>关联流程</td><td><a flowid="' + item.flowId + '" runid="' + item.runId + '" href="javascript:;" style="color: blue;" class="open_flow_work">' + item.runName + '</a></td></tr>';
                            });
                            $('.connect_work_table').append(str);
                            $('.connect_work').show();
                        }
                    });
                });
                /************回退按钮显示方法************************/
                if(globalData.allowBack != 0){
                    $('#backBtn').show();
                }
                /************删除按钮隐藏方法************************/
                if(globalData.flowStep !=1){
                    $('#deleteBtn').hide();
                }
                if(globalData.prcsId != 0){
                    $('#turnBtn').hide();
                    $('#agreeBtn').show();
                    $('#refuseBtn').show();
                }
                /************调用移动端回退的方法************************/
                $('#agreeBtn').click(function () {
                    $('#agreeBox').show()
                    // _this.saveFlowData(function(res){
                    //     if(res.flag){
                    //
                    //     }else{
                    //         $.layerMsg({content:"保存失败！",icon:2},function(){
                    //             layer.closeAll();
                    //         });
                    //     }
                    //
                    // });
                });
                $('#refuseBtn').click(function () {
                    $('#agreeBox').show()
                    $('.agreeBoxTitle').text('确认拒绝')
                    $('.turnBrn').text('确认拒绝')
                    // _this.saveFlowData(function(res){
                    //     if(res.flag){
                    //
                    //     }else{
                    //         $.layerMsg({content:"保存失败！",icon:2},function(){
                    //             layer.closeAll();
                    //         });
                    //     }
                    //
                    // });
                });

                /************调用移动端查看原始表单的方法************************/
                $('#formInfo').click(function () {
                    gobackIndex = 1;
                    backoff = ''
                    _this.saveFlowData(function(res){
                        if(res.flag){
                            $.layerMsg({content:"保存成功！",icon:1},function(){

                            });
                            formInfo();
                        }else{
                            $.layerMsg({content:"保存失败！",icon:2},function(){

                            });
                        }
                        layer.closeAll();
                    });
                });
                /************和后台获取附件信息的方法************************/
                getFileInfo(runid)



                //会签区li切换
                $(".hqUl li").click(function() {
                    $(this).siblings('li').removeClass('showBorder'); // 删除其他兄弟元素的样式
                    $(this).addClass('showBorder'); // 添加当前元素的样式
                    if($(this).attr('id') == 2){
                        $('.opinion').css('display','block')
                        $('.relevant').css('display','none')
                        $('.hqmiSong').css('display','none')
                    }else if($(this).attr('id') == 3){
                        $('.opinion').css('display','none')
                        $('.relevant').css('display','block')
                        $('.hqmiSong').css('display','none')
                        aboutMe()
                    }else{
                        $('.opinion').css('display','none')
                        $('.relevant').css('display','none')
                        $('.hqmiSong').css('display','block')
                        miSong()
                    }
                });
                //点击头像
                // $('.hqImg .icon1').click(function(){
                //     $(".portrait").toggle();
                //     $('.layui-timeline-content').toggleClass('portrait0');
                //     // $('.portrait').css('display','none')
                //     // $('.layui-timeline-content').css('padding-left','0')
                // })
                /************和后台获取会签信息的方法************************/
                callJS(globalData.flowStep,globalData.signlock,globalData.flowPrcs,runid)

                $("#imgStr").load(location.href + " #imgStr");
                if(globalData.runname != ''){
                    var datarunname = globalData.runname;
                }else{
                    var datarunname = data.object.flowRun.runName;
                }
                $('#flowName').text(datarunname);
                $('#flowBeginUser').text(data.object.flowRun.userName);
                $('#flowBeginTime').text(data.object.flowRun.beginTime);
                $('#flowRunId').text('No.'+data.object.flowRun.runId);
                $('#deleteBtn').attr('tid',globalData.flowRunPrcs.id);
                if(target.prop('outerHTML').indexOf('splitBox') > -1){
                    globalData['split'] = 1;
                }
                _this.buildBody(target);
                _this.buildEvent();
                $('body').append('<script src="/js/workflow/plugin/countersignature/main.js"></script>');
                cb();
                /*************处理radio类型input在disabled下无法修改样式的问题 通过将已选中的radio 去除掉disabled解决 仅限于工作流-办理页面******************/
                var length = $('input[type=radio]').length;
                if(length != 0){
                    for(var i=0;i<length;i++){
                        if($('input[type=radio]').eq(i).attr('checked') == 'checked'){
                            $('input[type=radio]').eq(i).removeAttr('disabled');
                        }
                    }
                }

                if($('select[data-type=select]').length != 0){
                    restoreFlag = true;
                    initSelect();
                    $("option").each(function(index){
                        var text_index=$(this).text().indexOf("|");
                        if(text_index > 0) {
                            $(this).text($(this).text().substring(0,text_index));
                        }
                    });
                }
                /*************处理选日期控件***********************************************************/
                var length = $('input[data-type=calendar]').length;
                if(length != 0&&$.getQueryString("type") == 'EWC'){
                    for(var i=0;i<length;i++){
                        if(!$('input[data-type=calendar]').eq(i).is(':disabled')){
                            if($('input[data-type=calendar]').eq(i).attr('dates_format').indexOf('hh:mm:ss') > -1){
                                new Jdate({
                                    el: '#'+ $('input[data-type=calendar]').eq(i).attr('id'),
                                    format: 'YYYY-MM-DD hh:mm:ss',
                                    beginYear: 1900,
                                    endYear: 2100,
                                    confirm: function(date) {
                                        $(this.config.el).val(date);
                                        calcutargetTime($(this.config.el));
                                    },
                                })
                            }else{
                                new Jdate({
                                    el: '#'+ $('input[data-type=calendar]').eq(i).attr('id'),
                                    format: 'YYYY-MM-DD',
                                    beginYear: 1900,
                                    endYear: 2100,
                                    confirm: function(date) {
                                        $(this.config.el).val(date);
                                        calcutargetTime($(this.config.el));
                                    },
                                })
                            }
                        }
                    }
                }
                for(var i=0;i<length;i++) {
                    if ($('input[data-type=calendar]').eq(i).attr('dates_format').indexOf('hh:mm:ss') == -1) {
                        if (!$('input[data-type=calendar]').eq(i).is(':disabled')) {
                            var timeclass = '';
                            var disabled = '';
                        }else{
                            var timeclass = 'timeSelectGrey';
                            var disabled = 'disabled="disabled"';
                        }
                        $('input[data-type=calendar]').eq(i).after('<select class="timeselect gapp_input '+ timeclass +'" style="width: 50%;" '+ disabled +'><option value=""></option><option value="上午">上午</option><option value="下午">下午</option></select>');
                        var thisval = $('input[data-type=calendar]').eq(i).val();
                        if(thisval.indexOf('上午') > -1 || thisval.indexOf('下午') > -1){
                            $('input[data-type=calendar]').eq(i).val(thisval.split(' ')[0]);
                            $('input[data-type=calendar]').eq(i).next().val(thisval.split(' ')[1]);
                        }
                    }
                }
                $('#content').on("input propertychange",'.timeselect',function () {
                    calcutargetTime($(this).prev())
                });
                if(globalData.split == 1){
                    var firstPrcsItem = globalData.flowProcesses.prcsItem.split(',')[0];
                    if(globalData.flowProcesses.prcsItem.split(',')[0] == '[A@]'){
                        firstPrcsItem = globalData.flowProcesses.prcsItem.split(',')[1];
                    }
                    var firstPrcsItemNum = $('.form_item[title='+ firstPrcsItem +']').parents('tr').prev().find('td').eq(1);
                    firstPrcsItemNum.append('<a name="aa"></a><a href="#aa"></a>');
                    location.href = "#aa";window.location.hash = "#aa";
                }
                /*************声明下评分控件START******************************************************/
                if($('.mark').length != 0){
                    for(var i=0;i<$('.mark').length;i++){
                        var disabled = $('.mark .form_item').eq(i).attr('disabled');
                        var formItemId = $('.mark .form_item').eq(i).attr('name');
                        var value = $('.mark .form_item').eq(i).val();
                        scoreFun($("#startone"+formItemId));
                        if(value != '-1'){
                            $("#startone"+formItemId).find('a').eq(value-1).addClass('clibg');
                        }
                        if(disabled == 'disabled'){
                            $('.mark .form_item').eq(i).parent().find('a').prop("onclick",null).off("click");
                            $('head').append('<style>#startone'+ formItemId +' .star_score a:hover {\n' +
                                '        background: none;\n' +
                                '    }</style>')
                        }
                    }
                }
                /***************判断是否显示添加经办人*****************/
                if(globalData.flowProcesses && globalData.flowProcesses.countersign == 1){
                    if (globalData.flowRunPrcs.opaddUser == undefined || globalData.flowRunPrcs.opaddUser == ''){
                        $('#addSign').show();
                    }else{
                        if (globalData.flowProcesses.countersignAgain == '1'){
                            $('#addSign').show();
                        }
                    }
                }else{
                    if (globalData.flowRunPrcs.opaddUser !=undefined && globalData.flowRunPrcs.opaddUser !='' && globalData.flowProcesses.countersignAgain == '1'){
                        $('#addSign').show();
                    }
                }
                if($('#basic_infor input[data-type="calendar"]').length > 0){
                    setInterval(function(){
                        var prevTime = new Date(new Date().toLocaleDateString()).getTime() - 24*3600000;
                        var thisTime = new Date(new Date().toLocaleDateString()).getTime();
                        var nextTime = new Date(new Date().toLocaleDateString()).getTime() + 24*3600000;
                        $('#basic_infor input[data-type="calendar"]').each(function(index,element){
                            if($(element).attr('dates_format')
                                &&$(element).attr('dates_format').indexOf('YYYY-MM-DD') > -1){
                                var thisValTime = $(element).val();
                                if($(element).attr('dates_format').indexOf('hh:mm:ss') == -1){
                                    thisValTime += ' 00:00:00'
                                }
                                var eleTime = new Date(thisValTime.replace(/-/g,"/")).getTime();
                                var prevClac = prevTime - eleTime;
                                var thisClac = eleTime - thisTime;
                                var nextClac = eleTime - nextTime;
                                if ($(element).parent().find('.calculationSpan').length != 0) {
                                    $(element).parent().find('.calculationSpan').remove();
                                }
                                if(thisClac < 0&&prevClac <= 0&&prevClac > -86400000){
                                    $(element).after('<span class="calculationSpan">昨天</span>')
                                }else if(thisClac >= 0&&thisClac < 86400000){
                                    $(element).after('<span class="calculationSpan">今天</span>')
                                }else if(nextClac >= 0&&nextClac < 86400000) {
                                    $(element).after('<span class="calculationSpan">明天</span>')
                                }else{
                                    var thisWeek = getWeek(new Date($(element).val().replace(/-/g,"/")));
                                    if(thisWeek){
                                        $(element).after('<span class="calculationSpan">'+ thisWeek +'</span>')
                                    }
                                }
                            }
                        })
                    },1000)
                }
                if($('#basic_infor .form_item[data-type="macros"]').length > 0){
                    setInterval(function(){
                        var prevTime = new Date(new Date().toLocaleDateString()).getTime() - 24*3600000;
                        var thisTime = new Date(new Date().toLocaleDateString()).getTime();
                        var nextTime = new Date(new Date().toLocaleDateString()).getTime() + 24*3600000;
                        $('#basic_infor .form_item[datafld="SYS_DATE"]').each(function(index,element){

                            var thisValTime = $(element).val() + '00:00:00';
                            var eleTime = new Date(thisValTime.replace(/-/g,"/")).getTime();
                            var prevClac = prevTime - eleTime;
                            var thisClac = eleTime - thisTime;
                            var nextClac = eleTime - nextTime;
                            if ($(element).parent().find('.calculationSpan').length != 0) {
                                $(element).parent().find('.calculationSpan').remove();
                            }
                            if(thisClac < 0&&prevClac <= 0&&prevClac > -86400000){
                                $(element).after('<span class="calculationSpan macrosSpan">昨天</span>')
                            }else if(thisClac >= 0&&thisClac < 86400000){
                                $(element).after('<span class="calculationSpan macrosSpan">今天</span>')
                            }else if(nextClac >= 0&&nextClac < 86400000) {
                                $(element).after('<span class="calculationSpan macrosSpan">明天</span>')
                            }else{
                                var thisWeek = getWeek(new Date($(element).val().replace(/-/g,"/")));
                                if(thisWeek){
                                    $(element).after('<span class="calculationSpan macrosSpan">'+ thisWeek +'</span>')
                                }
                            }

                        })

                        $('#basic_infor .form_item[datafld="SYS_DATE_CN"]').each(function(index,element){

                            var thisValTime = $(element).val().replace(/[^\d]/g,'/') + '00:00:00';
                            var eleTime = new Date(thisValTime).getTime();
                            var prevClac = prevTime - eleTime;
                            var thisClac = eleTime - thisTime;
                            var nextClac = eleTime - nextTime;
                            if ($(element).parent().find('.calculationSpan').length != 0) {
                                $(element).parent().find('.calculationSpan').remove();
                            }
                            if(thisClac < 0&&prevClac <= 0&&prevClac > -86400000){
                                $(element).after('<span class="calculationSpan macrosSpan">昨天</span>')
                            }else if(thisClac >= 0&&thisClac < 86400000){
                                $(element).after('<span class="calculationSpan macrosSpan">今天</span>')
                            }else if(nextClac >= 0&&nextClac < 86400000) {
                                $(element).after('<span class="calculationSpan macrosSpan">明天</span>')
                            }else{
                                var thisWeek = getWeek(new Date($(element).val().replace(/-/g,"/")));
                                if(thisWeek){
                                    $(element).after('<span class="calculationSpan macrosSpan">'+ thisWeek +'</span>')
                                }
                            }

                        })

                        $('#basic_infor .form_item[datafld="SYS_DATETIME"]').each(function(index,element){

                            var thisValTime = $(element).val();
                            var eleTime = new Date(thisValTime.replace(/-/g,"/")).getTime();
                            var prevClac = prevTime - eleTime;
                            var thisClac = eleTime - thisTime;
                            var nextClac = eleTime - nextTime;
                            if ($(element).parent().find('.calculationSpan').length != 0) {
                                $(element).parent().find('.calculationSpan').remove();
                            }
                            if(thisClac < 0&&prevClac <= 0&&prevClac > -86400000){
                                $(element).after('<span class="calculationSpan macrosSpan">昨天</span>')
                            }else if(thisClac >= 0&&thisClac < 86400000){
                                $(element).after('<span class="calculationSpan macrosSpan">今天</span>')
                            }else if(nextClac >= 0&&nextClac < 86400000) {
                                $(element).after('<span class="calculationSpan macrosSpan">明天</span>')
                            }else{
                                var thisWeek = getWeek(new Date($(element).val().replace(/-/g,"/")));
                                if(thisWeek){
                                    $(element).after('<span class="calculationSpan macrosSpan">'+ thisWeek +'</span>')
                                }
                            }

                        })

                        $('#basic_infor .form_item[datafld="SYS_RUNDATETIME"]').each(function(index,element){

                            var thisValTime = $(element).val();
                            var eleTime = new Date(thisValTime.replace(/-/g,"/")).getTime();
                            var prevClac = prevTime - eleTime;
                            var thisClac = eleTime - thisTime;
                            var nextClac = eleTime - nextTime;
                            if ($(element).parent().find('.calculationSpan').length != 0) {
                                $(element).parent().find('.calculationSpan').remove();
                            }
                            if(thisClac < 0&&prevClac <= 0&&prevClac > -86400000){
                                $(element).after('<span class="calculationSpan macrosSpan">昨天</span>')
                            }else if(thisClac >= 0&&thisClac < 86400000){
                                $(element).after('<span class="calculationSpan macrosSpan">今天</span>')
                            }else if(nextClac >= 0&&nextClac < 86400000) {
                                $(element).after('<span class="calculationSpan macrosSpan">明天</span>')
                            }else{
                                var thisWeek = getWeek(new Date($(element).val().replace(/-/g,"/")));
                                if(thisWeek){
                                    $(element).after('<span class="calculationSpan macrosSpan">'+ thisWeek +'</span>')
                                }
                            }

                        })
                    },1000)
                }
            });

        },
        /************调用工作流转交按钮的方法************************/
        turnH5Btn: function () {
            var _this = this;
            //查看当前流程是否已办结
            $.ajax({
                url: '/workflow/work/selectFind',
                type: 'GET',
                data: {
                    flowId: $.GetRequest().flowId,
                    prcsId: $.GetRequest().flowStep,
                    flowPrcs: $.GetRequest().prcsId,
                    runId: $.GetRequest().runId
                },
                success: function (res) {
                    if (res.flag && res.object == 'err') {
                        layer.msg('当前流程已办结', {time: 2000}, function () {
                            if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                                try{
                                    window.webkit.messageHandlers.finishWork.postMessage({});
                                }catch(err){
                                    finishWork();
                                }
                            } else if (/(Android)/i.test(navigator.userAgent)) {
                                Android.finishWebActivity();
                            } else {
                                var href = location.href.replace('workformh5', 'workformh5PreView');
                                location.href = href;
                            }
                        });
                    } else {
                        if (globalData.checkTurnPriv == 0) {
                            layer.msg('经办人未办理完毕，无法转交');
                            return false;
                        }
                        var feedbackflag = false;
                        var NewuserId = userId;
                        globalData.data.forEach(function(v,i){
                            /*判断当前流程操作人是否在当前步骤做了会签*/
                            if(v.userId == NewuserId&&$.GetRequest().prcsId == v.flowPrcs){
                                feedbackflag = true;
                            }
                        })
                        if(globalData.feedback == '2'){
                            if($('#imgStrss').find('li').length <= 0 &&!feedbackflag){
                                // if($('#signText').val() ==""&&!feedbackflag){
                                $.layerMsg({content:'请提交会签意见',icon:6});
                                return false;
                            }
                        }
                        if (globalData.gatherNodePriv == 1) {
                            layer.msg(qzhb);
                        } else {
                            backoff = ''
                            _this.saveFlowData(function (res) {
                                if (res.flag) {
                                    var content = $('.signBox .gapp_textarea').val();
                                    if (content == "") {
                                        if ($.getQueryString("type") == 'EWC') {
                                            var type = '&type=EWC';
                                        } else {
                                            var type = '';
                                        }
                                        window.location.href = 'turnh5Free?flowId=' + globalData.flowId + '&flowStep=' + globalData.flowStep + '&prcsId=' + globalData.prcsId + '&runId=' + globalData.flowRun.runId + '&tableName=' + globalData.tableName + '&tabId=' + globalData.tabId + type;
                                    } else {
                                        $.ajax({
                                            type: "get",
                                            url: "/workflow/work/workfeedback",
                                            dataType: 'JSON',
                                            data: {
                                                prcsId: globalData.prcsId,
                                                runId: globalData.flowRun.runId,
                                                flowPrcs: globalData.flowPrcs,
                                                content: content,
                                                file: '',
                                                feedFlag: '0'
                                            },
                                            beforeSend: function (request) {
                                                if (beforeToken != '') {
                                                    request.setRequestHeader("Authorization", 'Bearer ' + beforeToken);
                                                }
                                            },
                                            success: function (res) {
                                                $('.signBox .gapp_textarea').val('');
                                            }
                                        })
                                    }
                                    if ($.getQueryString("type") == 'EWC') {
                                        window.location.href = 'turnh5Free?flowId=' + globalData.flowId + '&flowStep=' + globalData.flowStep + '&prcsId=' + globalData.prcsId + '&runId=' + globalData.flowRun.runId + '&tableName=' + globalData.tableName + '&tabId=' + globalData.tabId + '&type=EWC';
                                    } else {
                                        window.location.href = 'turnh5Free?flowId=' + globalData.flowId + '&flowStep=' + globalData.flowStep + '&prcsId=' + globalData.prcsId + '&runId=' + globalData.flowRun.runId + '&tableName=' + globalData.tableName + '&tabId=' + globalData.tabId;
                                        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                                            try{
                                                window.webkit.messageHandlers.rightTitle.postMessage({'title':'转交','name':'321','function':'turn'});
                                            }catch(err){
                                                rightTitle('转交','321','turn');
                                            }
                                        } else if (/(Android)/i.test(navigator.userAgent)) {
                                            //alert(navigator.userAgent);
                                            Android.rightTitle('转交', '123', 'turn');
                                        }
                                    }

                                }
                                layer.closeAll();
                            });
                        }
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        },
        buildEvent:function () {
            /************************子流程点击跳转************************/
            $(document).on('click','.child_flow', function(){
                var url = $(this).data('url');
                if($.getQueryString("type") == 'EWC'){
                    window.location.href = url + '&formInfo=formInfo';
                }else{
                    if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                        try{
                            window.webkit.messageHandlers.formInfoUrlLink.postMessage({'url':url + '&formInfo=formInfo','name':'原始表单'});
                        }
                        catch(err) {
                            formInfoUrlLink(url + '&formInfo=formInfo','原始表单');
                        }
                    } else if (/(Android)/i.test(navigator.userAgent)) {
                        Android.formInfoUrlLink(url+ '&formInfo=formInfo','原始表单');
                    }
                }
            });
            /*************移动端工作流控件排序功能**************************************************/
            $.ajax({
                type: "get",
                url: "/form/getMobileDataSort",
                dataType: 'JSON',
                data: {
                    formId: globalData.flowFormType.formId
                },
                beforeSend : function(request) {
                    if(beforeToken != ''){
                        request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
                    }
                },
                async:false,
                success: function(res) {
                    var formData = workForm.option.dataName || {};
                    var prcsItem = workForm.option.prcsItem + ',' + workForm.option.prcsItemAuto|| '';
                    if(res.flag){
                        var arr = res.obj.split(',');
                        var str = '';
                        var strArr = [];
                        var arrObj = {};
                        arr.forEach(function(v,i){
                            var name = v.split('|')[0] || '';
                            var isShow = v.split('|')[1] == 0 ? false : true;
                            arrObj[name] = isShow;
                            if(name&&name.indexOf('DATA_')>-1){
                                object[name] = true;
                                if($('[name='+ name +']').parents('tr').prop("outerHTML")){
                                    // var dis = $('[name='+ name +']').attr('disabled');
                                    var title = $('[name=' + name + ']').attr('title');
                                    var dataType = $('[name=' + name + ']').attr('data-type');
                                    // 判断是否为可写字段
                                    if (prcsItem.indexOf(title) == -1) { // 不可写
                                        // 判断是否配置app显示
                                        if (!isShow) { // 未配置
                                            if(dataType != 'sign'&&dataType != 'qrcode'){
                                                $('[name=' + name + ']').parents('tr').hide()
                                            }

                                        } else { // 已配置
                                            if(isObjectNull(formData)){
                                                if (!formData[name]) {
                                                    if(dataType != 'sign'&&dataType != 'qrcode'){
                                                        $('[name=' + name + ']').parents('tr').hide()
                                                    }
                                                } else if (dataType == 'checkbox' && formData[name] == '0') {
                                                    if(dataType != 'sign'&&dataType != 'qrcode'){
                                                        $('[name=' + name + ']').parents('tr').hide()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    if(dataType == 'sign'||dataType == 'listing'){
                                        strArr.push($('[name='+ name +']').parents('tr').clone(true));
                                    }else{
                                        strArr.push($('[name='+ name +']').parents('tr'));
                                    }
                                }
                            }
                        });
                        arrobject.forEach(function(v,i){
                            if(v&&v.indexOf('DATA_')>-1){
                                if(!object[v]){
                                    if ($('[name=' + v + ']').parents('tr').prop("outerHTML")) {
                                        // var dis = $('[name=' + v + ']').attr('disabled');
                                        var title = $('[name=' + v + ']').attr('title');
                                        var dataType = $('[name=' + v + ']').attr('data-type');
                                        // 判断是否为可写字段
                                        if (prcsItem.indexOf(title) == -1) { // 不可写
                                            // 判断是否配置app显示
                                            if (!arrObj[v]) { // 未配置
                                                if(dataType != 'sign'&&dataType != 'qrcode'){
                                                    $('[name=' + v + ']').parents('tr').hide()
                                                }
                                            } else { // 已配置
                                                if(isObjectNull(formData)){
                                                    if (!formData[v]) {
                                                        if(dataType != 'sign'&&dataType != 'qrcode'){
                                                            $('[name=' + v + ']').parents('tr').hide()
                                                        }
                                                    } else if (dataType == 'checkbox' && formData[v] == '0') {
                                                        if(dataType != 'sign'&&dataType != 'qrcode'){
                                                            $('[name=' + v + ']').parents('tr').hide()
                                                        }
                                                    }
                                                }

                                            }
                                        }
                                        if(dataType == 'sign'||dataType == 'listing'){
                                            strArr.push($('[name='+ v +']').parents('tr').clone(true));
                                        }else{
                                            strArr.push($('[name='+ v +']').parents('tr'));
                                        }
                                    }
                                }
                            }
                        });
                        $('#content tbody').empty();
                        $('#content tbody').html(strArr);
                    }else{
                        arrobject.forEach(function (v, i) {
                            if (v && v.indexOf('DATA_') > -1) {
                                if ($('[name=' + v + ']').parents('tr').prop("outerHTML")) {
                                    // var dis = $('[name=' + v + ']').attr('disabled');
                                    var title = $('[name=' + v + ']').attr('title');
                                    var dataType = $('[name=' + v + ']').attr('data-type');
                                    // 判断是否为可写字段
                                    if (prcsItem.indexOf(title) == -1) { // 不可写
                                        if(isObjectNull(formData)){
                                            if (!formData[v]) { // 判断内容是否为空，为空不显示
                                                if(dataType != 'sign'&&dataType != 'qrcode'){
                                                    $('[name=' + v + ']').parents('tr').hide()
                                                }
                                            } else if (dataType == 'checkbox' && formData[v] == '0') {
                                                if(dataType != 'sign'&&dataType != 'qrcode'){
                                                    $('[name=' + v + ']').parents('tr').hide()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        });
                    }
                }
            });

            /*************声明下下拉框控件START联动功能*********************************************/
            var _this = this;
            $('#turnBtn').click(function () {
                _this.turnH5Btn();
            });
            $('.deptselecth5').click(function () {
                dept_id = $(this).attr('id');
                layer.open({
                    type: 2,
                    shade:true,
                    area: ['360px', '500px'],
                    content: ['/common/selectDept', 'no']
                });

            });
            $('.userselecth5').click(function () {
                user_id = $(this).attr('id');
                // if($(this).attr('selectId') == '1'){
                //     var num = '?0';
                // }else{
                //     var num = '';
                // }
                layer.open({
                    type: 2,
                    shade:true,
                    area: ['98%', '500px'],
                    content: ['/common/selectUser', 'no']
                });

            });
            //加载列表控件事件
            $('.btn_list').click(function () {
                $('#listcontent').html( $(this).parent().find('table'));
                $('#listcontent').find('table').show();
                var lv_size = $('#listcontent').find('table').attr('lv_size');
                $('#listbox').show();
            });
            //
            $('#list_btn_close').click(function () {
                var tableObj = $('#listcontent').find('table');
                tableObj.hide();
                var id = tableObj.attr('id');
                $('#content #'+id).before( tableObj);
                $('#listbox').hide();
                calcutarget($('.amount'));
            });
            $('#lctbtn').click(function () {
                if($.getQueryString("type") == 'EWC'){
                    window.location.href = "/flowSetting/processDesignToolTwo?flowId="+ globalData.flowId +"&rilwId="+ globalData.runId;
                }else{
                    if(( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                        try{
                            window.webkit.messageHandlers.lookFlowChart.postMessage({'url':"/flowSetting/processDesignToolTwo?flowId="+ globalData.flowId +"&rilwId="+ globalData.runId});
                        }catch(err){
                            lookFlowChart("/flowSetting/processDesignToolTwo?flowId="+ globalData.flowId +"&rilwId="+ globalData.runId);
                        }
                    }else if(/(Android)/i.test(navigator.userAgent)){
                        Android.lookFlowChart("/flowSetting/processDesignToolTwo?flowId="+ globalData.flowId +"&rilwId="+ globalData.runId);
                    }
                }
            });
            /************工作流 保存 按钮 点击方法************************/
            $('#saveBtn').click(function (){
                savebtn = true;
                backoff = ''
                _this.saveFlowData(function(res){
                    if(res.flag){
                        var content = $('.signBox .gapp_textarea').val();
                        if(content != ""){
                            $.ajax({
                                type: "get",
                                url: "/workflow/work/workfeedback",
                                dataType: 'JSON',
                                data: {
                                    prcsId:globalData.prcsId,
                                    runId:globalData.flowRun.runId,
                                    flowPrcs:globalData.flowPrcs,
                                    content:content,
                                    file:'',
                                    feedFlag:'0'
                                },
                                beforeSend : function(request) {
                                    if(beforeToken != ''){
                                        request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
                                    }
                                },
                                success: function(res){

                                }
                            })
                        }
                        $.layerMsg({content:"保存成功！",icon:1},function(){

                        });
                        if($.getQueryString("type") == 'EWC'){
                            window.history.go(-1);
                        }else{
                            /************调用移动端返回工作流列表方法************************/
                            if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                                try{
                                    window.webkit.messageHandlers.finishWork.postMessage({});
                                }catch(err){
                                    finishWork();
                                }
                            } else if (/(Android)/i.test(navigator.userAgent)) {
                                Android.finishWebActivity();
                            }
                        }

                    }else{
                        $.layerMsg({content:"保存失败！",icon:2},function(){

                        });
                    }
                    setTimeout(function () {
                        layer.closeAll();
                    },1000)


                },'noCheck');
            });

            /************会签功能调用办理完毕btn************************/
            $('#opflagturn').click(function(){
                var feedbackflag = false;
                globalData.data.forEach(function(v,i){
                    if(v.userId == userId&&$.GetRequest().prcsId == v.flowPrcs){
                        feedbackflag = true;
                    }
                })

                if(globalData.feedback == '2'){
                    if($('#imgStrss').find('li').length <= 0 &&!feedbackflag){
                        // if($('#signText').val() ==""&&!feedbackflag){
                        $.layerMsg({content:'请提交会签意见',icon:6});
                        return false;
                    }
                }
                var loadingIndex = layer.load();
                //判断会签意见控件是否必填
                var form_item=$('#content .form_item');
                for(var i=0; i<form_item.length;i++){
                    var obj = form_item.eq(i);
                    var datatype = obj.attr("data-type");
                    var ismust = obj.attr('ismust');
                    var isMustValue
                    var isCheck = true;
                    if(datatype == 'sign'){
                        isMustValue = '';
                        // 获取输入框的值
                        var valueSign = obj.val().trim();
                        // 有值跳过
                        if(valueSign){
                            isMustValue = valueSign;
                        }else{ // 无值，需要判断当前用户当前步骤是否填写过意见
                            var pre = obj.prev();
                            var $eiderarea = pre.find('.eiderarea');
                            var flowRunPrcs = workForm.option.flowRunPrcs;
                            $eiderarea.each(function(index, ele){
                                if ($(this).attr('user_id') == flowRunPrcs.userId && $(this).attr('prcs_id') == flowRunPrcs.flowPrcs) {
                                    var content = $(ele).find('.sign_content').text();
                                    // var content = signHtml.match(/>(\S*?)<br>/)[1];
                                    if (content.indexOf('{{content}}') == -1 && content.trim() != '') {
                                        isMustValue += content
                                    }
                                }
                            });
                        }
                    }
                    if(isCheck && ismust == 'true' && isMustValue == ""){          //适用于设置了当前流程必填字段和当前流程转出条件的流程
                        if(gobackIndex != 1){                      //适用于设置了当前流程必填字段和当前流程转出条件的流程，点击回退按钮兼容效果
                            // flag = true;
                            layer.close(loadingIndex);
                            layer.msg('请填写'+obj.attr('title'), {icon: 1});
                            return false;
                        }
                    }
                }
                var flowfun = globalData.flowRun;
                var form_item=$('.special_form_item');
                var sign=$('.sign');
                /********会签控件开始**********/
                if(sign.length != 0){
                    var signdata = [];
                    for(var i=0;i<sign.length;i++){
                        if(!sign.eq(i).attr('disabled')){
                            var pre = sign.eq(i).prev();
                            var realValue = sign.eq(i).val().trim();
                            var baseData = {};
                            var value = '';
                            if (realValue) {
                                value = Mustache.render(pre.find('.eiderarea').eq(pre.find('.eiderarea').length-1).prop("outerHTML"),{content:''});

                                if(workForm.option.dataName[sign.eq(i).attr('name')] == ''){
                                    $.ajax({
                                        type: "get",
                                        url: "workfeedback",
                                        dataType: 'JSON',
                                        data: {
                                            prcsId:globalData.flowRunPrcs.prcsId,
                                            flowPrcs:flowPrcs,
                                            runId:runId,
                                            content:value,
                                            file:'',
                                            feedFlag:sign.eq(i).attr('name').split('DATA_')[1]
                                        },
                                        async:false,
                                        success: function (obj) {
                                            value = '';
                                        }
                                    })
                                }
                            }
                            baseData["key"] = sign.eq(i).attr('name');
                            baseData["value"]=value;
                            signdata.push(baseData);
                        }
                    }
                    if(signdata.length != 0){
                        $.ajax({
                            type: "post",
                            url: "/workflow/work/signControl",
                            dataType: 'JSON',
                            data: {
                                runId:flowfun.runId,
                                flowId:globalData.flowId,
                                signdata:JSON.stringify(signdata)
                            },
                            beforeSend : function(request) {
                                if(beforeToken != ''){
                                    request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
                                }
                            },
                            async:false,
                            success: function(res){}
                        });
                    }
                }
                /********传阅意见控件开始**********/
                if(form_item.length != 0){
                    for(var i=0;i<form_item.length;i++){
                        var obj = form_item.eq(i);
                        var ismust = obj.attr('ismust');
                        var thisdata = obj.attr('name').split('DATA_')[1];
                        if(ismust == 'true'&&$('.csignitem'+thisdata).find('.countersignature_itemhide').length == 0){          //适用于设置了当前流程必填字段和当前流程转出条件的流程
                            layer.close(loadingIndex);
                            $.layerMsg({content: '请签名!', icon: 1});
                            return false;
                        }else{
                            saveCSNtr_item(obj,function(){
                                if(form_item.length-1 == i){
                                    var finishdata={
                                        runId:flowfun.runId,
                                        prcsId : globalData.flowStep,
                                        flowPrcs : globalData.flowPrcs,
                                        flowId:globalData.flowId,
                                        tableName:globalData.tableName,
                                        tabId:globalData.tabId,
                                    };
                                    $.ajax({
                                        type: "post",
                                        url: "/workflow/work/saveHandle",
                                        dataType: 'JSON',
                                        data: finishdata,
                                        beforeSend : function(request) {
                                            if(beforeToken != ''){
                                                request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
                                            }
                                        },
                                        success: function(res){

                                            if(res.flag){
                                                // 保存会签意见
                                                finishdata.content = $('#signText').val();
                                                finishdata.feedFlag = '0';
                                                finishdata.file = '';
                                                // 判断会签意见填写是否为空
                                                // 如果不为空  则保存会签意见
                                                // 如果为空    跳过保存会签意见 提示流程办理完毕保存成功
                                                if(finishdata.content!=''){
                                                    $.ajax({
                                                        type:"get",
                                                        url:"/workflow/work/workfeedback",
                                                        dataType:"json",
                                                        data:finishdata,
                                                        beforeSend : function(request) {
                                                            if(beforeToken != ''){
                                                                request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
                                                            }
                                                        },
                                                        success:function (res) {
                                                            layer.close(loadingIndex);
                                                            if(res.flag){
                                                                $.layerMsg({content:'保存成功！',icon:1},function(){

                                                                });
                                                                if($.getQueryString("type") == 'EWC'){
                                                                    window.history.go(-1);
                                                                }else{
                                                                    /************调用移动端返回工作流列表方法************************/
                                                                    if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                                                                        try{
                                                                            window.webkit.messageHandlers.finishWork.postMessage({});
                                                                        }catch(err){
                                                                            finishWork();
                                                                        }
                                                                    } else if (/(Android)/i.test(navigator.userAgent)) {
                                                                        Android.finishWebActivity();
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    })
                                                }else{
                                                    layer.close(loadingIndex);
                                                    $.layerMsg({content:'保存成功！',icon:1},function(){

                                                    });
                                                    if($.getQueryString("type") == 'EWC'){
                                                        window.history.go(-1);
                                                    }else{
                                                        /************调用移动端返回工作流列表方法************************/
                                                        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                                                            try{
                                                                window.webkit.messageHandlers.finishWork.postMessage({});
                                                            }catch(err){
                                                                finishWork();
                                                            }
                                                        } else if (/(Android)/i.test(navigator.userAgent)) {
                                                            Android.finishWebActivity();
                                                        }
                                                    }

                                                }

                                            }else{
                                                layer.close(loadingIndex);
                                                if(res.msg == '该用户是最后一个无主办人'){
                                                    layer.msg('您是本步骤（无主办人会签）的最后一个办理人，需要进行流程转交，页面自动刷新或者点击确定后，请点击转交按钮，进行转交操作。!', { icon: 0, time: 10000 }, function () {
                                                        location.reload();
                                                    });
                                                }

                                            }
                                        }
                                    });
                                }

                            });
                        }
                    }

                }else{
                    var finishdata={
                        runId:flowfun.runId,
                        prcsId : globalData.flowStep,
                        flowPrcs : globalData.flowPrcs,
                        flowId:globalData.flowId,
                        tableName:globalData.tableName,
                        tabId:globalData.tabId,
                    };
                    $.ajax({
                        type: "post",
                        url: "/workflow/work/saveHandle",
                        dataType: 'JSON',
                        data: finishdata,
                        beforeSend : function(request) {
                            if(beforeToken != ''){
                                request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
                            }
                        },
                        success: function(res){
                            if(res.flag){
                                // 保存会签意见
                                finishdata.content = $('#signText').val();
                                finishdata.feedFlag = '0';
                                finishdata.file = '';
                                // 判断会签意见填写是否为空
                                // 如果不为空  则保存会签意见
                                // 如果为空    跳过保存会签意见 提示流程办理完毕保存成功
                                if(finishdata.content!=''){
                                    $.ajax({
                                        type:"get",
                                        url:"/workflow/work/workfeedback",
                                        dataType:"json",
                                        data:finishdata,
                                        beforeSend : function(request) {
                                            if(beforeToken != ''){
                                                request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
                                            }
                                        },
                                        success:function (res) {
                                            layer.close(loadingIndex);
                                            if(res.flag){
                                                $.layerMsg({content:'保存成功！',icon:1},function(){

                                                });
                                                if($.getQueryString("type") == 'EWC'){
                                                    window.history.go(-1);
                                                }else{
                                                    /************调用移动端返回工作流列表方法************************/
                                                    if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                                                        try{
                                                            window.webkit.messageHandlers.finishWork.postMessage({});
                                                        }catch(err){
                                                            finishWork();
                                                        }
                                                    } else if (/(Android)/i.test(navigator.userAgent)) {
                                                        Android.finishWebActivity();
                                                    }
                                                }
                                            }
                                        }
                                    })
                                }else{
                                    layer.close(loadingIndex);
                                    $.layerMsg({content:'保存成功！',icon:1},function(){

                                    });
                                    if($.getQueryString("type") == 'EWC'){
                                        window.history.go(-1);
                                    }else{
                                        /************调用移动端返回工作流列表方法************************/
                                        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                                            try{
                                                window.webkit.messageHandlers.finishWork.postMessage({});
                                            }catch(err){
                                                finishWork();
                                            }
                                        } else if (/(Android)/i.test(navigator.userAgent)) {
                                            Android.finishWebActivity();
                                        }
                                    }
                                }

                            }else{
                                layer.close(loadingIndex);
                                if(res.msg == '该用户是最后一个无主办人'){
                                    layer.msg('您是本步骤（无主办人会签）的最后一个办理人，需要进行流程转交，页面自动刷新后，请点击转交下一步按钮，进行转交操作!', { icon: 0, time: 5000 }, function () {
                                        location.reload();
                                    });
                                }
                            }
                        }
                    });
                }


            });
            /************工作流 删除 按钮 点击方法************************/
            $('#deleteBtn').click(function () {
                var tid=$(this).attr('tid');
                //删除判断
                layer.confirm('确认删除吗？', {
                    btn: ['确定','返回'] //按钮
                }, function(){
                    //确定删除，调接口
                    $.ajax({
                        url: '/workflow/work/deleteRunPrcs',
                        type: 'get',
                        dataType: 'json',
                        data:{
                            id:tid
                        },
                        beforeSend : function(request) {
                            if(beforeToken != ''){
                                request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
                            }
                        },
                        success: function (obj) {
                            //第三方扩展皮肤
                            layer.msg('删除成功！', { icon:6});
                            if($.getQueryString("type") == 'EWC'){
                                window.history.go(-1);
                            }else{
                                /************调用移动端返回工作流列表方法************************/
                                if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                                    try{
                                        window.webkit.messageHandlers.finishWork.postMessage({});
                                    }catch(err){
                                        finishWork();
                                    }
                                } else if (/(Android)/i.test(navigator.userAgent)) {
                                    Android.finishWebActivity();
                                }
                            }

                        }
                    })
                }, function(){
                    layer.closeAll();
                });
            });

            $('#content').on("input propertychange",'.calculation',function () {
                calcutargetTime($(this))
            });
            function calcutarget(__this) {
                var targetId = __this.attr('calcutarget')||'';
                if (targetId != '') {
                    targetId = targetId.split(',');
                    var formitems = _this.tool.getFormDatasKeyValue();
                    targetId.forEach(function (item,i) {
                        var targetObj = $('#'+item) ;
                        if(targetObj.attr('disabled') == 'disabled'){
                            return false;
                        }
                        var prec = targetObj.attr('prec')||0;
                        var calculationValue = targetObj.attr('formula');

                        formitems.forEach(function(v,i){
                            var calculateFlag = calculateFormitem(calculationValue,v.title);
                            if(calculationValue.indexOf(v.title) > -1&&calculateFlag){
                                if(v.value.indexOf('-')>-1){
                                    var time = v.value.replace(/\-/g,'/');
                                    calculationValue = calculationValue.replace(v.title,parseFloat(new Date(time).getTime()/1000));
                                }else{
                                    if(v.value == ''){
                                        v.value = 0;
                                    }
                                    calculationValue = calculationValue.replace(v.title,v.value);
                                }
                            }
                        });
                        var result = '';
                        try {
                            result = eval(calculationValue);
                            if(parseFloat(result).toString() != 'NaN' && checkNumber(result)){
                                result = parseFloat(result).toFixed(prec);
                            }
                        }catch (e){
                            console.log(e);
                        }
                        targetObj.val(result).trigger('propertychange');
                    });
                }
            }
        },
        /************工作流 保存数据库的方法************************/
        saveFlowData:function (cb,isCheckOpt){
            layer.load();
            markFunc();
            var flowfun = globalData.flowRun;
            var isCheck = true;
            if(isCheckOpt && isCheckOpt=='noCheck'){
                isCheck = false;
            }
            var listing = false;
            var form_item=$('#content .form_item');
            var realData=[];
            var radioArr = {};
            var modifydata =[];
            var flag = false;
            var modifydataObject = {};
            var countersignData = '';
            var thisprcsItem = [],thisprcsItemAuto = [];
            if(globalData.flowProcesses){
                if(globalData.flowProcesses.prcsItem&&globalData.flowProcesses.prcsItem != ''){
                    var thisprcsItem = globalData.flowProcesses.prcsItem.split(',');
                }
                if(globalData.flowProcesses.prcsItemAuto&&globalData.flowProcesses.prcsItemAuto != ''){
                    var thisprcsItemAuto = globalData.flowProcesses.prcsItemAuto.split(',');
                }
            }
            for(var i=0;i<form_item.length;i++){
                var baseData={};
                var value="";
                var obj = form_item.eq(i);
                var datatype = obj.attr("data-type");
                var key=obj.attr("name");
                var ismust = obj.attr('ismust');
                var title = obj.attr('title')||'';
                if(datatype=="select"){
                    if(obj.val() == null){
                        value = '';
                    }else{
                        value= obj.val()==0?'':form_item.eq(i).val();
                    }
                }else if(datatype=="textarea"){
                    if(obj.hasClass('countersignature_item')) {
                        var thisdata = obj.attr('name').split('DATA_')[1];
                        if(ismust == 'true'&&$('.csignitem'+thisdata).find('.countersignature_itemhide').length == 0){          //适用于设置了当前流程必填字段和当前流程转出条件的流程
                            $.layerMsg({content: '请签名!', icon: 1}, function(){
                                layer.closeAll();
                            });
                            return false;
                        }else{
                            saveCSNtr_item(obj);
                        }
                    }
                    value=obj.val();
                }else if(datatype=="text"  ){
                    value=obj.val();
                }else if(datatype=="markformItem"  ){
                    value=obj.val();
                }else if(datatype=="sign"){
                    var valueSign = obj.val().trim();
                    var pre = obj.prev();
                    countersignData += obj.attr('name')+',';
                    var $eiderarea = pre.find('.eiderarea').last();
                    if(valueSign){
                        $eiderarea.find('.remove_sign').css('display','none');
                        value = Mustache.render($eiderarea.prop("outerHTML"),{content:''});
                        if(workForm.option.dataName == undefined
                            ||workForm.option.dataName[obj.attr('name')].replace(/(^\s*)|(\s*$)/g, '') == ''){
                            $.ajax({
                                type: "get",
                                url: "workfeedback",
                                dataType: 'JSON',
                                data: {
                                    prcsId:globalData.prcsId,
                                    flowPrcs:globalData.flowPrcs,
                                    runId:globalData.flowRun.runId,
                                    content:value,
                                    file:'',
                                    feedFlag:obj.attr('name').split('DATA_')[1]
                                },
                                async:false,
                                success: function (obj) {
                                    value = '';
                                }
                            })
                        }
                    }else{
                        value = "";
                    }
                }else if(datatype=="countersignature_item"){
                    var thisdata = obj.attr('name').split('DATA_')[1];
                    if(backoff == ''){
                        if(ismust == 'true'&&$('.csignitem'+thisdata).find('.countersignature_itemhide').length == 0){          //适用于设置了当前流程必填字段和当前流程转出条件的流程
                            $.layerMsg({content: '请签名!', icon: 1});
                            setTimeout(function(){
                                layer.closeAll();
                            },1000)
                            return false;
                        }else{
                            saveCSNtr_item(obj);
                        }
                    }else{
                        saveCSNtr_item(obj);
                    }
                    value=obj.val();
                }else if(datatype == "macrossign"){
                    if (obj.attr('datafld') == 'SYS_FLOW_CONNECTFLOW' && obj.attr('flowtype') == 1){
                        value = obj.val();
                    } else if(obj.attr('datafld') == 'SYS_FLOW_PUBLICFILE'){
                        for(let i=0;i<obj.parent().find('a').length;i++){
                            if(i != obj.parent().find('a').length -1){
                                value += obj.parent().find('a').eq(i).attr('href').split('/download?')[1] + '*';
                            }else{
                                value += obj.parent().find('a').eq(i).attr('href').split('/download?')[1];
                            }
                        }
                    } else {
                        value = obj.html();
                    }

                }else if(datatype=="checkbox"){
                    // value=obj.attr('title');
                    if(obj.is(':checked')){
                        value = '1';
                    }else{
                        value = '0';
                    }
                }else if(datatype=="macros"){
                    if(thisprcsItem.indexOf(title) > -1||thisprcsItemAuto.indexOf(title) > -1){
                        if(obj.attr('type') == "text"){
                            value= obj.val();
                            var datafld = obj.attr('datafld');
                            if(obj.attr('disabled') != 'disabled' || obj.hasClass('prcsItemAuto')){
                                if(obj.attr('datafld')=='SYS_USERNAME'&&obj.attr('orgsignImg')==1){
                                    if(obj.attr('signSrc')!=undefined&&obj.attr('signSrc')!=''&&obj.attr('signSrc').indexOf('AID')>=0){
                                        value = obj.attr('signSrc')
                                    }else{
                                        if(workForm.tool.getMacrosData(datafld)() != "" && (value=="" || value == '{macros}')){
                                            value = workForm.tool.getMacrosData(datafld)();
                                        }
                                    }

                                }else{
                                    if(workForm.tool.getMacrosData(datafld)() != "" && (value=="" || value == '{macros}')){
                                        value = workForm.tool.getMacrosData(datafld)();
                                    }
                                }

                            }else{
                                if(obj.attr('datafld')=='SYS_USERNAME'&&obj.attr('orgsignImg')==1){
                                    if(obj.attr('signSrc')!=undefined&&obj.attr('signSrc')!=''&&obj.attr('signSrc').indexOf('AID')>=0){
                                        value = obj.attr('signSrc')
                                    }else{
                                        if(workForm.tool.getMacrosData(datafld)() != "" && (value=="" || value == '{macros}')){
                                            value = workForm.tool.getMacrosData(datafld)();
                                        }
                                    }

                                }
                            }


                        }else if(obj.attr('type') == "select"){
                            //value = obj.val() == 0?'':form_item.eq(i).val();
                            value = obj.val()+'_'+obj.find("option:selected").text();
                        }else{
                            value = obj.val();
                        }
                    }else{
                        value = '';
                    }
                }else if(datatype == "radio"){
                    var name = obj.attr('name');
                    if(!radioArr[obj.attr('name')]){
                        radioArr[obj.attr('name')] = true;
                        if($("input[name='"+name+"']:checked").length>0){
                            value= $("input[name='"+name+"']:checked").val();
                        }else{
                            value = "";
                        }
                    }else{
                        continue;
                    }
                }else if(datatype == "imgupload"){
                    var name = obj.attr('name');
                    $('img[name='+name+']').each(function(i,v){
                        var url = $(v).attr('src')||'';
                        if(url.indexOf('/img/icon_uploadimg.png') == -1){
                            var str = url;
                            var strs = str.split('&ATTACHMENT_NAME=')[0];
                            var name = str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[0];
                            var attName = decodeURI(name).replace(/\%2b/g, "+").replace(/\%40/g,"@").replace(/\%23/g,"#").replace(/\%26/g,"&").replace(/\%2F/g,"/").replace(/\%3F/g,"?").replace(/\%ef%bf%a5/g,"￥").replace(/\%24/g,"$").replace(/\%ef%bc%81/g,"！").replace(/\%ef%bc%88/g,"（").replace(/\%ef%bc%89/g,"）").replace(/\%e2%80%a6%e2%80%a6/g,"…");
                            var atturl =strs+"&ATTACHMENT_NAME="+attName+"&FILESIZE="+str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[1];
                            if(atturl != undefined && atturl != '' && atturl.indexOf(',') > -1){
                                atturl = atturl.replace(/\,/g, "%2c");
                            }
                            value+= (atturl+'*');
                        }
                    })
                }else if(datatype == "fileupload"){
                    var name = obj.attr('name');
                    $('img[name='+name+']').each(function(i,v){
                        var url = $(v).attr('atturl');
                        var src = $(v).attr('src')||'';
                        if(src.indexOf('/img/fileupload.png') == -1){
                            if(url != undefined && url != '' && url.indexOf(',') > -1){
                                url = url.replace(/\,/g, "%2c");
                            }
                            value+= (url+'*');
                        }
                    })
                }else if(datatype == "kgsign"){
                    value = (obj.attr('signatureId') || '');
                }else if(datatype == "deptselect"){
                    if(obj.attr('deptname')){
                        value= (obj.attr('deptid') || '')+'|'+(obj.attr('deptname')||'');
                    }else{
                        value = obj.attr('deptname')||'';
                    }

                }else if(datatype == "userselect"){
                    if(obj.attr('user_id')){
                        value= (obj.attr('user_id')||'')+'|'+ (obj.attr('username')||'');
                    }else{
                        value = obj.attr('username')|| '';
                    }

                }else if(datatype == "listing"){
                    var vtrStr = [];
                    var vsumStr = [];
                    obj.find('tr').each(function(){
                        if($(this).attr('class') != 'listhead' && $(this).attr('class')!= 'listfoot'){
                            var  listTdObj = $(this).find('td');
                            if($(this).attr('class') == 'listsum'){
                                listTdObj.each(function (i,v) {
                                    var _this = $(v);
                                    if(_this.attr('class')!='sumtitle'){
                                        if(_this.html() !=''&&_this.html() !='0'){
                                            listing = true;
                                        }
                                        vsumStr.push(_this.html());
                                    }
                                });
                            }else{
                                var vtdStr = [];
                                listTdObj.each(function (i,v) {
                                    var _this = $(v);
                                    var listtype = $(v).attr('listtype');
                                    switch (listtype){
                                        case 'text':
                                            if(_this.find('input').val() !=''&&_this.find('input').val() !='0'){
                                                listing = true;
                                            }
                                            vtdStr.push(_this.find('input').val());
                                            break;
                                        case 'textarea':
                                            if(_this.find('textarea').val() !=''&&_this.find('textarea').val() !='0'){
                                                listing = true;
                                            }
                                            vtdStr.push(_this.find('textarea').val());
                                            break;
                                        case 'select':
                                            if(_this.find('select').val() !=''&&_this.find('select').val() !='0'){
                                                listing = true;
                                            }
                                            vtdStr.push(_this.find('select').val());
                                            break;
                                        case 'radio':
                                            var name = _this.find('input').eq(0).attr('name');
                                            if($('input[name="'+name+'"]:checked').val() !=''&&$('input[name="'+name+'"]:checked').val() !='0'){
                                                listing = true;
                                            }
                                            vtdStr.push($('input[name="'+name+'"]:checked').val());
                                            break;
                                        case 'checkbox':
                                            var checkboxStr = [];
                                            _this.find('input:checked').each(function(i,v){
                                                checkboxStr.push($(v).attr('value'));
                                            });
                                            if(checkboxStr.join(',') !=''&&checkboxStr.join(',') !='0'){
                                                listing = true;
                                            }
                                            vtdStr.push(checkboxStr.join(','));
                                            break;
                                        case 'datetime':
                                            if(_this.find('input').val() !=''&&_this.find('input').val() !='0'){
                                                listing = true;
                                            }
                                            vtdStr.push(_this.find('input').val());
                                            break;
                                        case 'dateAndTime':
                                            if(_this.find('input').val() !=''&&_this.find('input').val() !='0'){
                                                listing = true;
                                            }
                                            vtdStr.push(_this.find('input').val());
                                            break;
                                        case 'formula':
                                            if(_this.text() !=''&&_this.text() !='0'){
                                                listing = true;
                                            }
                                            vtdStr.push(_this.text())
                                            break;
                                        default:
                                    }

                                });
                                vtrStr.push(vtdStr.join('`'))
                            }

                        }
                    });
                    value = vtrStr.join('\r\n') +'|'+vsumStr.join('`');

                }else if(datatype == "djsign"){
                    if(obj.val() != ''){
                        if(obj.val().indexOf('DATA_HW:') > -1&&obj.val().indexOf('DATA_SEAL:') > -1){
                            var hw = obj.val().split('DATA_HW:')[1].split('DATA_SEAL:')[0]||'';
                            var seal = obj.val().split('DATA_HW:')[1].split('DATA_SEAL:')[1]||'';
                            if(hw == ''&&obj.parent().siblings('.divDJBox').find('.hwImg').length != 0){
                                parseAppSeal(obj.parent().siblings('.divDJBox').find('.hwImg').attr('atturl'),obj.attr('id'),'hw','special');
                                hw = DATA_HW;
                                DATA_HW = '';
                            }
                            if(seal == ''&&obj.parent().siblings('.divDJBox').find('.sealImg').length != 0){
                                seal = obj.parent().siblings('.divDJBox').find('.sealImg').attr('atturl');
                            }
                            if(seal == 'undefined'){
                                seal = '';
                            }
                            if(hw == 'undefined'){
                                hw = '';
                            }
                            value = 'DATA_HW:'+hw+'DATA_SEAL:'+seal;
                        }else{
                            value = obj.val();
                        }
                    }else{
                        value = WebSign_Submit(obj.attr('name'));
                    }
                }else if(datatype == "calendar"&&obj.attr('dates_format') == 'YYYY-MM-DD'){
                    value = obj.val();
                    if(obj.next().length != 0 &&obj.next().val().indexOf('上午') > -1||obj.next().val().indexOf('下午') > -1){
                        value = value + ' '+ obj.next().val();
                    }
                }else{
                    value = obj.val();
                }
                if(datatype == 'listing'){
                    if(!listing) {
                        value = '';
                    }
                }
                var isMustValue = value;
                // 判断会签意见是否填写
                if(datatype == 'sign'){
                    isMustValue = '';
                    // 获取输入框的值
                    var valueSign = obj.val().trim();

                    // 有值跳过
                    if(valueSign){
                        isMustValue = valueSign;
                    }else{ // 无值，需要判断当前用户当前步骤是否填写过意见
                        var pre = obj.prev();
                        var $eiderarea = pre.find('.eiderarea');
                        var flowRunPrcs = workForm.option.flowRunPrcs;
                        $eiderarea.each(function(index, ele){
                            if ($(this).attr('user_id') == flowRunPrcs.userId && $(this).attr('prcs_id') == flowRunPrcs.flowPrcs) {
                                var content = $(ele).find('.sign_content').text();
                                if (content.indexOf('{{content}}') == -1 && content.trim() != '') {
                                    isMustValue += content
                                }
                            }
                        });
                    }
                }
                //针对复选框控件 value必须等于1或者0 所以需要特殊处理下必填条件下 value的值
                if(datatype=='checkbox'){
                    if(isMustValue=='0'){
                        isMustValue=''
                    }
                }
                //针对宏当前用户辅助角色控件 value在选择时 值为“undefined” 所以需要特殊处理下必填条件下 value的值
                else if(datatype=='macros'&&obj.attr('datafld')=='SYS_USERPRIVOTHER'){
                    if(!isMustValue){
                        isMustValue=''
                    }
                }
                //针对宏部门主管（上级部门）控件 value在选择时 值为“undefined” 所以需要特殊处理下必填条件下 value的值
                else if(datatype=='macros'&&obj.attr('datafld')=='SYS_MANAGER2'){
                    if(!isMustValue){
                        isMustValue=''
                    }
                }
                //针对宏值来自sql查询语句按角色控件 和 宏值来自sql查询语句按角色排序号控件 和 宏值来自sql查询语句按流水号控件 value在选择时 值为“undefined” 所以需要特殊处理下必填条件下 value的值
                else if(datatype=='macros'&&obj.attr('datafld')=='SYS_SQL'){
                    if(!isMustValue){
                        isMustValue=''
                    }
                }
                //针对宏来自SQL查询语句的列表控件 value在选择时 值为“null” 所以需要特殊处理下必填条件下 value的值
                else if(datatype=='macros'&&obj.attr('datafld')=='SYS_LIST_SQL'){
                    if(isMustValue==null){
                        isMustValue = '';
                    }
                }
                if(isCheck && ismust == 'true' && isMustValue == ""){     //适用于设置了当前流程必填字段的流程
                    if(gobackIndex != 1){                 //适用于设置了当前流程必填字段的流程，点击回退按钮兼容效果
                        flag = true;
                        // layer.msg('请填写'+obj.attr('title'));
                        layer.closeAll();
                        $.layerMsg({content: '请填写'+obj.attr('title')});
                        // setTimeout(function(){
                        //     layer.closeAll();
                        // },1000)
                        break;
                    }
                }
                //防止控件取值为null得判断 防止后台无法转交
                if(value == null){
                    value = '';
                }

                baseData["key"]=key;
                baseData["value"]=value;

                realData.push(baseData);
                if(thisprcsItem.indexOf(title) > -1||thisprcsItemAuto.indexOf(title) > -1){
                    modifydata.push(baseData);
                }
                modifydataObject[key] = value;
            }
            if(globalData.runname != ''){
                var datarunname = globalData.runname;
            }else{
                var datarunname = globalData.flowRun.runName;
            }
            /***************特殊的文号表达式功能start************************/
            if(datarunname!=''&&datarunname.indexOf('{FS') > -1&&datarunname.indexOf('FE}|[') > -1){
                var arr = datarunname.match(/\{FS[^\]]+\]/g);
                var sta = datarunname.split(arr[0])[0];
                var end = datarunname.split(arr[arr.length-1])[1];
                var str = '';
                for(var i=0;i<arr.length;i++){
                    if(arr[i].indexOf('['+ globalData.prcsId +']') > -1){
                        var title = arr[i].split('|[')[0].replace(/\{FS/g,'').replace(/\FE}/g,'');
                        if(modifydataObject[globalData.fromDataReject[title]]){
                            str += modifydataObject[globalData.fromDataReject[title]];
                        }
                    }else{
                        str += arr[i];
                    }
                }
                datarunname = sta+str+end;
            }
            /***************特殊的文号表达式功能end************************/
            if(!flag){
                var fdata={
                    flowId:globalData.flowId,
                    formdata:JSON.stringify(realData),
                    runId:globalData.flowRun.runId,
                    runName:datarunname,
                    beginTime:globalData.flowRun.beginTime,
                    beginUser:globalData.flowRun.beginUser,
                    formLength:globalData.option.formLength,
                    prcsId : globalData.flowStep,
                    flowPrcs : globalData.prcsId,
                    modifydata:JSON.stringify(modifydata),
                    fromDataReject:JSON.stringify(globalData.fromDataReject),
                    tableName:globalData.tableName,
                    tabId:globalData.tabId,
                    countersignData:countersignData
                };
                // if(typeof  Signature != 'undefined'){
                //     var list = Signature.list;
                //     var signatureCreator = Signature.create();
                //     var kgsignList=$('#content .kgsign');
                //     kgsignList.each(function(){
                //         //新增签章
                //         var key = $(this).attr('signatureid');
                //         if(list[key]){
                //             signatureCreator.saveSignature(flowfun.runId, key, list[key].getSignatureData());
                //         }
                //     });
                // }

                if(gobackIndex == 1){ //适用于设置了当前流程转出条件的流程，点击回退按钮兼容效果
                    $.ajax({
                        type: "post",
                        url: "/workflow/work/nextwork",
                        dataType: 'JSON',
                        data: fdata,
                        beforeSend : function(request) {
                            if(beforeToken != ''){
                                request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
                            }
                        },
                        success: function(res){
                            $('textarea[data-type=sign]').val('');
                            var data ={};
                            if(cb){
                                if(res.flag){
                                    data.flag = true;
                                }else{
                                    data.flag = false;
                                }
                                data.data = res.obj;
                                cb(data);
                            }
                        }
                    });
                }else{
                    if(savebtn){
                        $.ajax({
                            type: "post",
                            url: "/workflow/work/nextwork",
                            dataType: 'JSON',
                            data: fdata,
                            beforeSend : function(request) {
                                if(beforeToken != ''){
                                    request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
                                }
                            },
                            success: function(res){
                                $('textarea[data-type=sign]').val('');
                                var data ={};
                                savebtn = false;
                                if(cb){
                                    if(res.flag){
                                        data.flag = true;
                                    }else{
                                        data.flag = false;
                                    }
                                    data.data = res.obj;
                                    cb(data);
                                }
                            }
                        });
                    }else{
                        checkPrcOut(JSON.parse(fdata.formdata),JSON.parse(fdata.fromDataReject),function(res){
                            if(res.flag){
                                $.ajax({
                                    type: "post",
                                    url: "/workflow/work/nextwork",
                                    dataType: 'JSON',
                                    data: fdata,
                                    beforeSend : function(request) {
                                        if(beforeToken != ''){
                                            request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
                                        }
                                    },
                                    success: function(res){
                                        $('textarea[data-type=sign]').val('');
                                        var data ={};
                                        if(cb){
                                            if(res.flag){
                                                data.flag = true;
                                            }else{
                                                data.flag = false;
                                            }
                                            data.data = res.obj;
                                            cb(data);
                                        }
                                    }
                                });
                            }else{
                                layer.closeAll();
                                layer.msg(res.msg, {
                                    icon:0,
                                    time: 3000, //20s后自动关闭
                                });

                            }
                        });
                    }

                }
            }
        },
        /************工作流数据录入、判断方法************************/
        buildBody : function(data){
            var _this = (this);
            var target = data;
            var dataList = data.find('.form_item');
            var formScript = data.find('script');
            if(workForm.option.snum){
                var k = workForm.option.snum.substr(5, 1);
                if(dataList.length == 0&& k == 'X'){
                    var s = '<div style="width: 90%;/* height: 150px; *//* margin: 135px auto; */background-color: #357ece;border-radius: 10px;box-shadow: 3px 3px 3px #2F5C8F;overflow: hidden;text-align: center;">\n' +
                        '        \n' +
                        '        <div class="TXT" id="TXT" style="float: left;color: #fff;font-size: 16pt;/* margin-top: 49px; *//* margin-left: 20px; */width: 306px;">该流程超过中小企业免费版表单控件数量限制，请联系管理员！</div>\n' +
                        '    </div>';
                    $('#content').append(s);
                    return false;
                }
            }
            var preObj = '';
            var tableObj = [];
            var idnum = 0;
            var checkidnum=0;
            dataList.each(function(i,v) {
                var __this = $(this);
                var dataType = __this.attr('data-type');
                var title = __this.attr('title');
                var name = __this.attr('name');
                var isMust = __this.attr('isMust');
                object[name] = false;
                arrobject.push(name);
                var isMustText = '';
                if(isMust){
                    isMustText = '<span style="color:red;font-size: 20px;margin-left: 2px">*</span>';
                }

                var eleTrObj = $('<tr><td class="td1"><div>' + title + isMustText + '</div></td><td class="td2"></td></tr>');
                var e = {};
                if(__this.attr('secret') == 1){
                    __this.hide();
                    eleTrObj.find('.td2').append(__this).append('*****');
                }else{
                    switch (dataType) {
                        case 'text':
                            __this.addClass("gapp_input gapp_form");
                            __this.attr("style",'');
                            eleTrObj.find('.td2').append(__this);
                            break;
                        case 'markformItem':
                            eleTrObj.find('.td2').append(__this.parent().prop("outerHTML"));
                            break;
                        case 'calculation':
                            __this.addClass("gapp_input gapp_form");
                            __this.attr("style",'');
                            eleTrObj.find('.td2').append(__this);
                            break;
                        case 'textarea':
                            __this.addClass("gapp_textarea");
                            eleTrObj.find('.td2').append(__this);
                            eleTrObj.find('.td1').find('div').addClass('textareaclass');
                            /*************处理富文本类型的多行文本框**************************/
                            if(__this.attr('rich') == 1){
                                eleTrObj.find('.td2').append('<div class="edui edui'+ __this.attr('name').split('DATA_')[1] +'" style="max-width: 100%;width: '+ __this.css('width') +'; min-height: '+ __this.css('height') +';">'+ UEhtmlEscape(__this.text()) +'</div>');
                            }
                            break;
                        case 'countersignature_item':
                            __this.addClass("gapp_textarea");
                            __this.attr("style",'');
                            eleTrObj.find('.td2').append(__this);
                            eleTrObj.find('.td1').find('div').addClass('textareaclass');
                            break;
                        case 'select':
                            __this.addClass("gapp_select gapp_form");
                            __this.attr("style",'');
                            if(__this.attr('disabled')=='disabled'){
                                __this.css('background','url("/img/workflow/work/workformh5/select.png") no-repeat 95% 12px')
                                __this.css('background-color',' #f8f8f8!important')
                                __this.css('color',' #333!important')
                            }
                            eleTrObj.find('.td2').append(__this);
                            break;
                        case 'radio':
                            var bool=true;
                            for(var i=0;i<tableObj.length;i++){
                                if($(tableObj[i]).find('[name="'+__this.attr('name')+'"]').length!=0){
                                    bool=false;
                                }
                            }
                            if(bool) {
                                var radioObj = $('<span style="position: relative;width: 22px;height: 16px;display: inline-block"></span>');
                                var id = __this.attr('name');
                                __this.attr('id', id + '_' + idnum);
                                $(__this).css({
                                    'position': 'absolute',
                                    'top': '0',
                                    'left': '2px'
                                })
                                radioObj.append(__this)
                                var lable = '<label style="left: 0;top: 0;" class="bgweijinyong" for="' + id + '_' + idnum + '"></label>';
                                if(__this.attr('disabled')=='disabled') {
                                    lable = '<label style="left: 0;top: 0;" class="bgyijingyong" for="' + id + '_' + idnum + '"></label>';
                                }
                                radioObj.append(lable);
                                var special = $('<div></div>');
                                special.append(radioObj);
                                special.append('<span  style="height: 36px;line-height: 36px;display: inline-block;padding-left: 5px;' +
                                    'padding-right: 15px;">' + __this.val() + '</span>');
                                eleTrObj.find('.td2').append(special);
                                // eleTrObj.find('.td2')
                                //     .append('<span  style="line-height: 22px;display: inline-block;padding-left: 5px;' +
                                //         'padding-right: 15px;">' + __this.val() + '</span>')
                                idnum++;
                            }else {
                                eleTrObj=$('');
                                for(var i=0;i<tableObj.length;i++){
                                    if($(tableObj[i]).find('[name="'+__this.attr('name')+'"]').length!=0){
                                        var tableObjParent=$(tableObj[i]).find('[name="'+__this.attr('name')+'"]').parent().parent().parent();
                                        var radioObj = $('<span style="position: relative;width: 22px;height: 16px;display: inline-block"></span>');
                                        var id = __this.attr('name');
                                        __this.attr('id', id + '_' + idnum);
                                        $(__this).css({
                                            'position': 'absolute',
                                            'top': '0',
                                            'left': '2px'
                                        })
                                        radioObj.append(__this)
                                        var lable = '<label style="left: 0;top: 0;" class="bgweijinyong" for="' + id + '_' + idnum + '"></label>';
                                        if(__this.attr('disabled')=='disabled') {
                                            lable = '<label style="left: 0;top: 0;" class="bgyijingyong" for="' + id + '_' + idnum + '"></label>';
                                        }
                                        radioObj.append(lable);
                                        var special = $('<div></div>');
                                        special.append(radioObj);
                                        special.append('<span  style="height: 36px;line-height: 36px;display: inline-block;padding-left: 5px;' +
                                            'padding-right: 15px;">' + __this.val() + '</span>')

                                        tableObjParent.append(special);
                                        // tableObjParent.append('<span  style="line-height: 22px;display: inline-block;padding-left: 5px;' +
                                        //         'padding-right: 15px;">' + __this.val() + '</span>')
                                    }
                                }
                                idnum++;
                            }

                            break;
                        case 'checkbox':
                            var id = __this.attr('name');
                            __this.attr('id',id+'_'+checkidnum);
                            eleTrObj.find('.td2').append(__this);
                            var lable = '<label class="bgweijinyong" style="border-radius: 0px" for="'+ id+'_'+checkidnum +'"></label>';
                            if(__this.attr('disabled')=='disabled'){
                                lable = '<label class="bgyijingyong" style="border-radius: 0px" for="'+ id+'_'+checkidnum +'"></label>';
                            }
                            eleTrObj.find('.td2').append(lable);
                            checkidnum++;
                            break;
                        case 'qrcode':
                            __this.css("float","none");
                            eleTrObj.find('.td2').append(__this);
                            break;
                        case 'kgsign':

                            $(__this.find("img").get(0)).attr("style","cursor: pointer; margin: 0 auto;width:100%;height:100%;")
                            eleTrObj.find('.td2').append(__this);
                            break;
                        case 'macros':
                            if(__this.is('textarea')){
                                __this.val(__this.attr('value'))
                                var macheight =  __this.attr("orgheight")|| 60;
                                __this.attr("style",'height: '+ macheight +'px;');
                            }else{
                                __this.attr("style",'');
                            }
                            if(__this.val() == '{macros}'){
                                __this.val(workForm.tool.getMacrosData(__this.attr('datafld'))());
                            }
                            __this.addClass("gapp_input gapp_form");
                            eleTrObj.find('.td2').html('');
                            if(__this.attr('datafld')=='SYS_USERNAME'&&__this.attr('orgsignImg')==1){
                                if(__this.attr('signSrc')!=""&&__this.attr('signSrc')!=undefined&&__this.attr('signSrc').indexOf('AID')>=0){
                                    var signSpan = '<span><img style="width:100px;height:auto" src="'+__this.attr('signSrc')+'" alt=""></span>';
                                    __this.css('display','none')
                                    eleTrObj.find('.td2').append('<div style="position: relative"></div>');
                                    eleTrObj.find('.td2').find('div').append(signSpan).append(__this);
                                }
                            }else{
                                if(__this.attr('datafld') == "SYS_CODE"){
                                    let button = __this.parent().find('.choosespan');
                                    let buttonHTML = '';
                                    for(let i=0; i<button.length; i++){
                                        buttonHTML += button[i].outerHTML;
                                    }
                                    eleTrObj.find('.td2').append('<div style="position: relative"></div>');
                                    eleTrObj.find('.td2').find('div').append(__this);
                                    eleTrObj.find('.td2').find('div').append(buttonHTML);
                                }else{
                                    eleTrObj.find('.td2').append('<div style="position: relative"></div>');
                                    eleTrObj.find('.td2').find('div').append(__this);
                                }
                            }
                            if(__this.attr('title') == '标题'){
                                var OBj = $('<textarea name="'+ __this.attr('id') +'" /' +
                                    'type="text" value="测试公111111111" class="'+ __this.attr('class') +'" /' +
                                    'data-type="macros" title="标题" id="'+ __this.attr('id') +'" datafld="'+ __this.attr('datafld') +'" /' +
                                    'style="'+ function(){
                                        if(__this.attr('style') == undefined){
                                            return '';
                                        }else{
                                            return __this.attr('style')+';';
                                        }
                                    }() +'color: rgb(17, 17, 17);width: calc(100% - 20px);padding: 10px;">'+ __this.val() +'</textarea>');
                                eleTrObj.find('.td2').html(OBj);
                                var dis = __this.attr('disabled');
                                if(dis == 'disabled'){
                                    OBj.css({
                                        'background-color':'#f8f8f8',
                                        'color':'#000'
                                    })
                                    OBj.attr('disabled','disabled').addClass('grey').parents('tr').find('.td1').addClass('grey1');
                                }else {
                                    OBj.css('color','#111')
                                }
                                OBj.css("height", OBj.scrollHeight + "px");
                            }
                            break;
                        case 'calendar':
                            __this.addClass("gapp_input gapp_date").removeClass('laydate-icon');
                            __this.attr("style",'padding-right: 0px;');
                            __this.attr("dates_format",__this.attr("date_format"));
                            __this.removeAttr("date_format");
                            if($.getQueryString("type") != 'EWC'){
                                __this.attr("onclick","timeclick($(this))");
                            }
                            eleTrObj.find('.td2').append('<div style="position: relative"></div>');
                            eleTrObj.find('.td2').find('div').append(__this);
                            break;
                        case 'imgupload':
                            var flowId = $.GetRequest().flowId;
                            var runId = $.GetRequest().runId;
                            var userAgent = 'mobile'
                            var dataName = workForm.option.dataName||{};
                            data.find('img[name="'+name+'"]').each(function (i,v) {
                                if($(v).attr("src") != undefined&&$(v).attr("src").indexOf('/img/icon_uploadimg.png') == -1){
                                    //表单填充数据
                                    var dataNameVal = dataName[$(v).attr('name')] ||'';
                                    if(dataNameVal && dataNameVal.indexOf('*')>-1){
                                        var strify = delFormImg;
                                        deletet = 'none;'
                                        try {
                                            if(strify != '' && strify != undefined && JSON.parse(strify).length > 0){
                                                var flag = false;
                                                for(var j=0;j<JSON.parse(strify).length;j++){
                                                    if(JSON.parse(strify)[j]['IMG_PRIV_'+$(v).attr('id')] != undefined){
                                                        var checkThis = JSON.parse(strify)[j]['IMG_PRIV_'+$(v).attr('id')];
                                                        if(checkThis.indexOf('3') != -1){
                                                            flag = true;
                                                            deletet = 'inline-block;'
                                                        }
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                        catch(err) {

                                        }
                                    }
                                    $(v).attr('url',$(v).attr('src'));
                                    $(v).attr('src',decodeURI($(v).attr('src')));
                                    $(v).attr('names', getAtturlName($(v).attr('url')));
                                    $(v).attr('onclick','anios1($(this),1)');
                                    if($(v).attr('disabled')!='disabled'){
                                        var thisspan = decodeURI($(v).attr("names"));
                                        thisspan = decodeURI(thisspan).replace(/\%2b/g, "+").replace(/\%40/g,"@").replace(/\%23/g,"#").replace(/\%26/g,"&").replace(/\%2F/g,"/").replace(/\%3F/g,"?").replace(/\%ef%bf%a5/g,"￥").replace(/\%24/g,"$").replace(/\%ef%bc%81/g,"！").replace(/\%ef%bc%88/g,"（").replace(/\%ef%bc%89/g,"）").replace(/\%e2%80%a6%e2%80%a6/g,"…");
                                        var attachname = thisspan;
                                        if(thisspan.split('.')[0].length > 8){
                                            var thisspan = thisspan.split('.')[0].substr(0,8)+'…'+thisspan.split('.')[1];
                                        }
                                        $(v).attr('url',$(v).attr('src').split('&ATTACHMENT_NAME=')[0]+'&ATTACHMENT_NAME='+ attachname + '&FILESIZE=' +$(v).attr('src').split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[1]);
                                        eleTrObj.find('.td2').css({
                                            'padding-top': '5px',
                                            'padding-bottom': '5px'
                                        }).append('<div class="imgfileBox" style="display:  inline-block;position:  relative;float: left;">'+ v.outerHTML +'<span class="uploadImg" onclick="imgupSpanClick($(this))" style="display: inline-block">'+ thisspan +'</span>' +
                                            '<span style="color: red;margin-left:15px;cursor:pointer;    font-size: 12px; display: '+deletet+'" class="hoverboxLidelete" atturl="'+encodeURI($(v).attr('atturl'))+'">×删除</span></br>'  +
                                            '</div>');
                                    }
                                }else{
                                    if($(v).attr('disabled')!='disabled'){
                                        $(v).attr("onclick","phoneimgupload(this)");

                                    }else{
                                        $(v).css('display','none');
                                    }
                                    eleTrObj.find('.td2').append(v);
                                }
                            });
                            break;
                        case 'fileupload':
                            var flowId = $.GetRequest().flowId;
                            var runId = $.GetRequest().runId;
                            var userAgent = 'mobile'
                            var dataName = workForm.option.dataName||{};
                            data.find('img[name="'+name+'"]').each(function (i,v) {
                                //表单填充数据
                                var dataNameVal = dataName[$(v).attr('name')] ||'';
                                if(dataNameVal && dataNameVal.indexOf('*')>-1){
                                    var strify = delForm;
                                    deletet = 'none;'
                                    try {
                                        if(strify != '' && strify != undefined && JSON.parse(strify).length > 0){
                                            var flag = false;
                                            for(var i=0;i<JSON.parse(strify).length;i++){
                                                if(JSON.parse(strify)[i]['FILE_PRIV_'+$(v).attr('id')] != undefined){
                                                    var checkThis = JSON.parse(strify)[i]['FILE_PRIV_'+$(v).attr('id')];
                                                    if(checkThis.indexOf('3') != -1){
                                                        flag = true;
                                                        deletet = 'inline-block;'
                                                    }
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                    catch(err) {

                                    }
                                }
                                if($(v).attr("src") != undefined&&$(v).attr("src").indexOf('/img/fileupload.png') == -1&&$(v).attr("src").indexOf('/img/icon_uploadimg.png') == -1&&$(v).attr('atturl') != undefined){
                                    $(v).attr('url',$(v).attr('atturl'));
                                    $(v).attr('names', getAtturlName($(v).attr('url')));
                                    if($.getQueryString("type") == 'EWC'){
                                        $(v).attr('onclick','lookEwx($(this),0)');
                                    }else {
                                        $(v).attr('onclick','anios1($(this),2)');
                                    }
                                    if($(v).attr('disabled')!='disabled'){
                                        var thisspan = $(v).attr("names");
                                        /* if(thisspan.split('.')[0].length > 8){
                                             var thisspan = thisspan.split('.')[0].substr(0,8)+'…'+thisspan.split('.')[1];
                                         }*/
                                        eleTrObj.find('.td2').css({
                                            'padding-top': '5px',
                                            'padding-bottom': '5px'
                                        }).append('<div class="imgfileBox" style="display:  inline-block;position:  relative;float: left;">'+ v.outerHTML +
                                            '<span class="uploadImg fileupload_data" style="display: inline-block;max-width: 120px;white-space: nowrap;\n' +
                                            '    text-overflow: ellipsis;\n' +
                                            '    overflow: hidden;\n' +
                                            '    line-height: 32px;" onclick="'+ function() {
                                                if($.getQueryString("type") == 'EWC'){
                                                    return 'lookEwx($(this),0)';
                                                }else {
                                                    return 'anios1($(this),2)';
                                                }
                                            }() +'" url="'+$(v).attr('atturl')+'" atturl="'+$(v).attr('atturl')+'" names="'+  getAtturlName($(v).attr('url')) + '" name="'+  getAtturlName($(v).attr('url')) + '">'+ thisspan +'</span>' +
                                            '<span style="color: red;margin-left:15px;cursor:pointer;position: absolute;top: -3px;font-size: 12px; display: '+deletet+'" class="hoverboxLidelete" atturl="'+encodeURI($(v).attr('atturl'))+'">×删除</span></br>'  +
                                            '</div>');
                                    }
                                }else{
                                    if($(v).attr('disabled')!='disabled'){
                                        $(v).attr("onclick","phoneimgupload(this)");

                                    }else {
                                        $(v).css('display','none');
                                    }
                                    eleTrObj.find('.td2').append(v);
                                }
                            });
                            break;
                        case 'sign':
                            __this.addClass("gapp_textarea");
                            __this.attr("style",'');
                            var height = __this.prev().height();
                            if(!height){
                                height = 0;
                            }
                            __this.prev().css({'width':'auto','height':'auto','min-height':height+'px'});
                            eleTrObj.find('.td2').append(__this.prev());
                            eleTrObj.find('.td2').append(__this);
                            if (!$(__this).prop('disabled')) {
                                __this.after('<img src="/img/workflow/form/icon_countersign.png" id="addsignImg" onclick="addsignImg(this)" style="position: absolute;right: 30px;cursor: pointer;bottom: 30px;width: 24px;height: 24px;" />')
                            } else {
                                eleTrObj.find('.td2').find('.eiderarea').last().hide()
                                __this.hide()
                            }
                            eleTrObj.find('.td1').find('div').addClass('textareaclass');
                            break;
                        case 'readcomments':
                            __this.addClass("gapp_textarea");
                            __this.attr("style",'');
                            eleTrObj.find('.td2').append(__this);
                            eleTrObj.find('.td1').find('div').addClass('textareaclass');
                            break;
                        case 'listing':
                            __this.addClass("gapp_textarea");
                            __this.hide();
                            eleTrObj.find('.td2').append(__this);
                            eleTrObj.find('.td2').append('<input id="'+__this.attr('id')+'" class=" gapp_input gapp_form grey" disabled="disabled" "><img class="btn_list" src="/img/workflow/m/list.png" style="position: absolute; top: 50%;width: 25px!important; height: 25px!important;right: 15px;margin-top: -13px!important;">');
                            // eleTrObj.find('.td2').append('<textarea  class="form_item gapp_textarea grey" gwidth="200" gheight="50" style="background-color: rgb(228, 228, 228); color: rgb(0, 0, 0);" disabled="disabled"></textarea>');
                            eleTrObj.find('.td1').find('div').addClass('textareaclass');
                            break;
                        case 'userselect':
                            __this.addClass("gapp_textarea");
                            __this.attr("style",'');
                            var userselectClass = 'form_item  gapp_textarea userselect';
                            if(__this.attr('disabled') != 'disabled'){
                                userselectClass = userselectClass +' userselecth5';
                            }else{
                                userselectClass+=' grey'
                            }

                            var textareaObj = $('<textarea name="'+__this.attr('name')+'" ismust="'+__this.attr('ismust')+'" id="'+__this.attr('id')+'" class="'+userselectClass+'" data-type="userselect" title="'+__this.attr('title')+'" readonly="readonly" orgfontsize="'+__this.attr('orgfontsize')+'" orgwidth="'+__this.attr('orgwidth')+'" orgheight="'+__this.attr('orgheight')+'" user_id="'+ (__this.attr('user_id') || '')+'" username="'+(__this.attr('username') || '')+'" style="'+__this.attr('style')+'"></textarea>');
                            textareaObj.val(__this.attr('username'));
                            eleTrObj.find('.td2').append(textareaObj);

                            eleTrObj.find('.td1').find('div').addClass('textareaclass');
                            break;
                        case 'deptselect':
                            __this.addClass("gapp_textarea");
                            __this.attr("style",'');
                            var userselectClass = 'form_item  gapp_textarea deptselect';
                            if(__this.attr('disabled') != 'disabled'){
                                userselectClass = userselectClass +' deptselecth5';
                            }else{
                                userselectClass+=' grey'
                            }
                            eleTrObj.find('.td2').append('<textarea name="'+__this.attr('name')+'" ismust="'+__this.attr('ismust')+'" id="'+__this.attr('id')+'" class="'+userselectClass+'" data-type="deptselect" title="'+__this.attr('title')+'" readonly="readonly" orgfontsize="'+__this.attr('orgfontsize')+'" orgwidth="'+__this.attr('orgwidth')+'" orgheight="'+__this.attr('orgheight')+'" deptid="'+ (__this.attr('deptid') || '')+'" deptname="'+(__this.attr('value') || '')+'" value="'+(__this.attr('value') || '')+'" style="'+__this.attr('style')+'">'+(__this.attr('value') || '')+'</textarea>');
                            eleTrObj.find('.td1').find('div').addClass('textareaclass');
                            break;
                        case 'autocode':
                            __this.addClass('gapp_input gapp_form');
                            __this.attr("style",'');
                            __this.attr('readonly',"readonly");
                            var targetid =  __this.attr('id');
                            eleTrObj.find('.td2').append(__this);
                            // eleTrObj.find('.td2').append('<span class="autospan" target="'+targetid+'" onclick="autoclik($(this))">赋值</span>');
                            break;
                        case 'macrossign':
                            var datafld = __this.attr('datafld');
                            if(datafld == "SYS_FLOW_SIGNTEXT"){
                                var textvalue = ''
                                if(__this.html().indexOf('{宏标记-会签控件}') == -1){
                                    textvalue = __this.html();
                                }
                                eleTrObj.find('.td2').append('<div class="form_item gapp_textarea grey" name="'+__this.attr('name')+'" id="'+__this.attr('id')+'" data-type="macrossign" title="'+__this.attr('title')+'" datafld="'+__this.attr('datafld')+'"  gwidth="200" gheight="50" style="overflow-x: auto;background:#f8f8f8!important ;color: rgb(0, 0, 0);" disabled="disabled">'+textvalue+'</div>');
                            } else if (datafld == "SYS_FLOW_EXPLAINFILE") {
                                var value = '<span id="'+__this.attr('id')+'" explainFile="'+__this.attr('explainFile')+'" name="'+__this.attr('name')+'" data-type="macrossign" title="'+__this.attr('title')+'" datafld="'+__this.attr('datafld')+'" class="form_item macrossign">'+__this.html()+'</span>';
                                eleTrObj.find('.td2').append(value);
                            } else if (datafld == "SYS_FLOW_CHILDFLOW") {
                                var value = '<span id="'+__this.attr('id')+'" name="'+__this.attr('name')+'" data-type="macrossign" title="'+__this.attr('title')+'" datafld="'+__this.attr('datafld')+'" class="form_item macrossign">'+__this.html()+'</span>';
                                eleTrObj.find('.td2').append(value);
                            } else if (datafld == "SYS_FLOW_CONNECTFLOW") {
                                if (__this.attr('flowtype') == 1) {
                                    __this.attr('style', '');
                                    __this.attr('class', 'form_item macrossign gapp_input gapp_form');
                                }
                                eleTrObj.find('.td2').append(__this);
                            } else if (datafld == "SYS_NEWS") {
                                var value = '<span id="'+__this.attr('id')+'" name="'+__this.attr('name')+'" data-type="macrossign" title="'+__this.attr('title')+'" datafld="'+__this.attr('datafld')+'" class="form_item macrossign">'+__this.html()+'</span>';
                                eleTrObj.find('.td2').append(value);
                            } else if(datafld == "SYS_FLOW_PUBLICFILE"){
                                eleTrObj.find('.td2').append('<input type="hidden" name="'+__this.attr('name')+'" id="'+__this.attr('id')+'" data-type="macrossign" title="'+__this.attr('title')+'" datafld="'+__this.attr('datafld')+'" class="form_item macrossign gapp_input gapp_form grey" disabled="disabled" value="">');
                            }
                            else {
                                eleTrObj.find('.td2').append('<input name="'+__this.attr('name')+'" id="'+__this.attr('id')+'" data-type="macrossign" title="'+__this.attr('title')+'" datafld="'+__this.attr('datafld')+'" class="form_item macrossign gapp_input gapp_form grey" disabled="disabled" value="'+ __this.html() +'">');
                            }
                            break;
                        case 'djsign':
                            eleTrObj.find('.td2').append('<div class="divDJBox"></div>');
                            eleTrObj.find('.td2').append(__this.parent().eq(0));
                            break;
                        case 'writeSign':
                            // eleTrObj.find('.td2').append('<div class="divDJBox"></div>');
                            eleTrObj.find('.td2').append(__this.parent().eq(0));
                            break;
                        case 'extdataselect':
                            var id=__this.eq(0).attr("id").split("_")[1];
                            __this.eq(0).attr("onclick","extdataselectApp(1,"+id+")");
                            eleTrObj.find('.td2').append(__this.eq(0));
                            break;
                        case 'dataselect':
                            var id=__this.eq(0).attr("id").split("_")[1];
                            __this.eq(0).attr("onclick","extdataselectApp(2,"+id+")");
                            eleTrObj.find('.td2').append(__this.eq(0));
                            break;
                        default:
                    }
                }

                var isHidden = $(this).attr("orghidden");
                if(1 == isHidden || 'hidden' == isHidden){
                    $(this).parents('tr').hide();
                }
                // if(__this.attr('hidden') == 'hidden'){
                //     $(this).parent().append('*********');
                // }
                var dis = __this.attr('disabled');
                if(dis == 'disabled'){
                    __this.css({
                        'background-color':'#f8f8f8',
                        'color':'#000'
                    })
                    __this.addClass('grey').parents('tr').find('.td1').addClass('grey1');
                    var _this = $(this);
                    if(__this.attr('data-type') == "calendar"){
                        if(_this.attr('class').indexOf('grey') != -1){
                            _this.removeAttr('onclick');
                        }
                    }else if(__this.attr('data-type') == 'autocode'){
                        _this.next().remove();
                    }

                } else {
                    __this.css('color','#111');
                }

                tableObj.push(eleTrObj);
            });
            $('#content').append(tableObj);
            for(var i=0;i<formScript.length;i++){
                $('body').append(formScript.eq(i));
            }
            $('#content').find('.qrcode').each(function () {
                var _this = $(this);
                var msg = {"mark":"SID_MEETING","url":_this.attr('textstr')};
                var id = _this.attr('id')
                var qrcode = new QRCode(id, {
                    text: JSON.stringify(msg),
                    width: _this.attr('orgwidth'),
                    height: _this.attr('orgheight'),
                    colorDark : '#000000',
                    colorLight : '#ffffff',
                    correctLevel : QRCode.CorrectLevel.H
                });
            });
            // if(typeof  Signature != 'undefined'){
            //     var signatureCreator = Signature.create();
            //     signatureCreator.getSaveSignatures( globalData.flowRun.runId, function(signs){
            //         var signdata = new Array();
            //         var jsonList = eval("("+signs+")");
            //         for(var i=0;i<jsonList.length;i++){
            //             var map = {};
            //             map.signatureid = jsonList[i]["signatureId"];
            //             map.signatureData = jsonList[i]["signature"];
            //             signdata.push(map);
            //         }
            //         console.log(signdata);
            //         Signature.loadSignatures(signdata);
            //     });
            // }
            globalData.fromDataReject = _this.buildFormData();
        },
        buildFormData : function(){
            var arr = {};
            $("#content").find('.form_item').each(function(i,v){
                var _this = $(this);
                arr[_this.attr('title')] = _this.attr('name');
            });
            return arr;
        },
        tool:{
            ajaxHtml:function (url,data,cb) {
                var that = this;
                $.ajax({
                    type: "get",
                    url: url,
                    async:false,
                    dataType: 'JSON',
                    data:  data,
                    beforeSend : function(request) {
                        if(beforeToken != ''){
                            request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
                        }
                    },
                    success: function (res) {
                        if(cb){
                            cb(res);
                        }
                    },
                    error:function(e){

                    }
                });
            },
            getFormDatasKeyValue:function(){
                var radioArr = {};
                var formitems = [];
                var form_item = $('#content').find('.form_item');
                for(var i=0;i<form_item.length;i++){
                    var value="";
                    var obj = form_item.eq(i);

                    var datatype = obj.attr("data-type");
                    var key=obj.attr("title");
                    if(datatype=="select"){
                        value= obj.val()==0?'':form_item.eq(i).val();
                    }else if(datatype=="textarea" || datatype=="text"  ){
                        value=obj.val();
                    }else if(datatype=="checkbox"){
                        if(obj.is(':checked')){
                            value = '1';
                        }else{
                            value = '0'
                        }
                    }else if(datatype=="macros"){
                        if(obj.attr('type') == "text"){
                            if(obj.attr('datafld')=='SYS_USERNAME'&&obj.attr('orgsignImg')==1){
                                if(obj.attr('signSrc')!=undefined&&obj.attr('signSrc')!=''&&obj.attr('signSrc').indexOf('AID')>=0){
                                    value = obj.attr('signSrc')
                                }else{
                                    value= obj.val();
                                }

                            }else{
                                value= obj.val();
                            }

                        }else{
                            if(obj.val() > -1){
                                value = obj.val()+'_'+obj.find("option:selected").text();
                            }
                        }
                    }else if(datatype == "radio"){
                        var name = obj.attr('name');
                        if(!radioArr[obj.attr('name')]){
                            radioArr[obj.attr('name')] = true;
                            if($("input[name='"+name+"']:checked").length>0){
                                value= $("input[name='"+name+"']:checked").val();
                            }else{
                                value = "";
                            }
                        }else{
                            continue;
                        }
                    }else if(datatype == "macrossign"){
                        value= obj.html();

                    }else if(datatype == "fileupload"){

                    }else if(datatype == "imgupload"){

                    }else if(datatype == "sign"){


                    }else if(datatype == "userselect"){
                        if(obj.attr('user_id')){
                            value= (obj.attr('user_id')||'')+'|'+ (obj.attr('username')||'');
                        }else{
                            value = obj.attr('username')||''
                        }

                    }else if(datatype == "deptselect"){
                        value= (obj.attr('deptid') || '')+'|'+(obj.attr('deptname')||'');
                    }else if(datatype == "kgsign"){
                        value = (obj.attr('signatureId') || '');
                    }else if(datatype == "listing"){

                    }else if(datatype == 'readcomments'){
                        value = obj.val();
                    }else if(datatype == 'calendar'&&obj.attr('dates_format') == 'YYYY-MM-DD'){
                        value = obj.val();
                        if(obj.next().val().indexOf('上午') > -1||obj.next().val().indexOf('下午') > -1){
                            value = value + ' '+ obj.next().val();
                        }
                    }else{
                        value = obj.val();
                    }
                    var item = {
                        value:value,
                        id:obj.attr('id'),
                        title:obj.attr('title')
                    }
                    formitems.push(item);
                };
                return formitems;
            }

        }
    }





    $(document).on('click','.deletefileBtn',function(){
        event.preventDefault();
        var _this = $(this);
        var url =  'deletework?runId='+runId+'&'+_this.attr("atturl");
        $.layerConfirm({title:'删除附件',content:'确定删除附件？',icon:0},function(){
            $.get(url,function(data,status){
                if(data.flag){
                    $.layerMsg({content:'删除成功！',icon:1},function(){
                    });
                    $(_this).prev().remove();
                    _this.remove();
                    getFileInfo(runid,1)
                }else{
                    $.layerMsg({content:'删除失败！',icon:2},function(){

                    });
                }
            });
        },function(){

        });

    })
    $(document).on('click','.hoverboxLidelete',function(){
        if(location.href.indexOf('workformh5?') > -1||location.href.indexOf('workformh5PreView?') > -1||location.href.indexOf('workformedit?') > -1){
            if($(this).parents('.imgfileBox').find('img').hasClass('imgupload_data')){
                var str = $(this).parents('.imgfileBox').find('img').attr('src').split('/xs?')[1];

                if(workForm.option.tableName == 'budget' && dataId == 'DATA_231'){
                    var url = "/budgetDelete?"+decodeURI(str);
                }else if(workForm.option.tableName == 'budget' && dataId == 'DATA_232'){
                    var url = "/budgetDelete?"+decodeURI(str);
                }else{
                    var url = "/delete?"+decodeURI(str);
                }
            }else{
                var str = $(this).parents('.imgfileBox').find('img').attr('atturl');
                var strs = str.split('&ATTACHMENT_NAME=')[0];
                var name = str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[0];
                var attName = encodeURI(name).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                var atturl =strs+"&ATTACHMENT_NAME="+attName;

                if(workForm.option.tableName == 'budget' && dataId == 'DATA_231'){
                    var url = "/budgetDelete?"+atturl;
                }else if(workForm.option.tableName == 'budget' && dataId == 'DATA_232'){
                    var url = "/budgetDelete?"+atturl;
                }else{
                    var url = "/workflow/work/deletework?runId="+ runId +"&"+encodeURI(atturl);
                }
            }

            var that = $(this);
            layer.confirm('确定删除吗？', {
                btn: ['确定','取消'], //按钮
                title:"删除附件"
            }, function(){
                //确定删除，调接口
                $.ajax({
                    type:'get',
                    url:url,
                    dataType:'json',
                    data:{},
                    beforeSend : function(request) {
                        if(beforeToken != ''){
                            request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
                        }
                    },
                    success:function(res){

                        layer.msg('删除成功！', { icon:6});
                        if(that.parents('div').next().attr('width')!=50){
                            if(that.parents('div').next().parent().is('p')){
                                that.parents('p').css({
                                    'border':'2px dotted #5fa5e7',
                                    'margin':'0 auto',
                                    'height':that.parents('div').next().attr('height'),
                                    'width': that.parents('td').width()-3,
                                    'vertical-align': 'middle',
                                    'display': 'table-cell'
                                })
                            }else{
                                that.parents('td').css({
                                    'height':that.parents('div').next().attr('height'),
                                })
                            }
                            that.parents('.imgfileBox').next().css('display','inherit');
                        }
                        that.parents('.imgfileBox').remove();
                        deleteITEMcountersignature_item = true
                        // $('#saveBtn').attr('delFile','delFile')
                        // $('#saveBtn').click();

                    }
                });

            }, function(){
                layer.closeAll();
            });


        }

    })

    /************调用工作流初始化方法************************/
    workformh5.init(function(){
        turn = function(){
            workformh5.turnH5Btn();
        },
            /*************和移动端对接右上角会签-办理完毕按钮***************************/
            opflagturnClick = function(){
                $('#opflagturn').trigger('click');
            }
        /**************END****************/
    });

    // 添加经办人
    $('#addSign').click(function () {
        savebtn = true;
        backoff = ''
        workformh5.saveFlowData(function (res) {
            layer.closeAll();
            if (res.flag) {
                var content = $('.signBox .gapp_textarea').val();
                if (content != "") {
                    $.ajax({
                        type: "get",
                        url: "/workflow/work/workfeedback",
                        dataType: 'JSON',
                        data: {
                            prcsId: globalData.prcsId,
                            runId: globalData.flowRun.runId,
                            flowPrcs: globalData.flowPrcs,
                            content: content,
                            file: '',
                            feedFlag: '0'
                        },
                        beforeSend: function (request) {
                            if (beforeToken != '') {
                                request.setRequestHeader("Authorization", 'Bearer ' + beforeToken);
                            }
                        },
                        success: function (res) {

                        }
                    })
                }
                layer.open({
                    type: 1,
                    // offset: '80px',
                    area: ['90%', '50%'],
                    closeBtn: 2,
                    title: '增加经办人',
                    content: '<div class="modal-body">' +
                        '<div>' +
                        '<div style="display: flex;justify-content: space-around;padding: 10px;">' +
                        '<textarea readonly disabled name="sign" id="sign" user_id="" style="width: 80%;height: 80px;"></textarea>' +
                        '<div style="display: flex;flex-direction: column;justify-content: space-evenly;"><a href="javascript:;" class="choose" style="color: #1687cb;padding:0px 10px">选择</a><a href="javascript:;" style="color: #ff5722;padding: 0px 10px;" class="empty">清空</a></div>' +
                        '</div>' +
                        '<div style="margin-top: 20px;border: 1px solid #e1e1e8;border-radius: 6px">' +
                        '<div class="signmsg" style="line-height: 32px;background-color: #f3f3f3;border-bottom:1px solid #e1e1e8;font-weight:bold;padding-left: 10px;">当前办理人信息</div>' +
                        '<div style="padding-left: 10px;color:green;line-height:28px"><span class="signUser"></span></div>' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                    btn: ['确认', '取消'],
                    success: function (layero, index) {
                        $.ajax({
                            url: '/workflow/work/getFlowRunPrecsUser',
                            dataType: 'json',
                            type: 'get',
                            data: {
                                runId: globalData.runId,
                                prcsId: globalData.flowRunPrcs.prcsId,
                                flowPrcs: globalData.prcsId
                            },
                            success: function (res) {
                                if (res.flag) {
                                    if (res.object.length > 0) {
                                        var str = '' + globalData.flowRunPrcs.userName + '，'
                                        for (var i = 0; i < res.object.length; i++) {
                                            str += '<span class="signUsers">' + res.object[i].userName + '，</span>'
                                        }
                                        $('.signUser').html(str)
                                    }
                                }
                            }
                        })

                        // 选择会签人
                        $('.choose').click(function () {
                            user_id = 'sign'
                            selectUsreLayerIndex = layer.open({
                                title: '选择用户',
                                type: 2,
                                content: '/common/selectUser',
                                area: ['100%', '70%']
                            });
                        })

                        // 清空会签人
                        $('.empty').click(function () {
                            $('#sign').val('')
                            $('#sign').attr('user_id', '')
                        })

                    },
                    yes: function (index, layero) {
                        var textVal = $('#sign').val()
                        var str = ""
                        $('.signUsers').each(function (i, v) {
                            if (textVal.indexOf($(this).html().replace('，', '')) > -1) {
                                str += $(this).html()
                            }
                        })
                        if (textVal.indexOf($('.zUser').html()) > -1) {
                            str += $('.zUser').html() + ','
                        }

                        if (!$('#sign').attr('user_id')) {
                            $.layerMsg({content: '请选择经办人', icon: 2})
                            return false;
                        } else {
                            var index = layer.load(1);
                            $.ajax({
                                url: '/workflow/work/addFeedback',
                                data: {
                                    runId: globalData.runId,
                                    flowId: globalData.flowId,
                                    flowPrcs: globalData.prcsId,
                                    prcsId: globalData.flowRunPrcs.prcsId,
                                    runName: globalData.flowRun.runName,
                                    userId: $('#sign').attr('user_id'),
                                    topFlag: globalData.flowRunPrcs.topFlag
                                },
                                success: function (res) {
                                    if (res.flag) {
                                        $.ajax({
                                            url: '/workflow/work/getFlowRunPrecsUser',
                                            dataType: 'json',
                                            type: 'post',
                                            data: {
                                                runId: globalData.runId,
                                                prcsId: globalData.flowRunPrcs.prcsId,
                                                flowPrcs: globalData.prcsId
                                            },
                                            success: function (datas) {
                                                if (datas.flag) {
                                                    $.layerMsg({content: '添加成功', icon: 1})
                                                    layer.closeAll();
                                                    window.location.reload();
                                                }
                                            }
                                        })
                                    } else {
                                        $.layerMsg({content: '添加失败', icon: 2})
                                    }
                                }
                            });
                        }
                    }
                });
            } else {
                $.layerMsg({content: "保存失败！", icon: 2}, function () {

                });
            }
        }, 'noCheck');
    });

    // 显示交办
    $('#assignment').click(function(){
        backoff = ''
        workformh5.saveFlowData(function(res){
            layer.closeAll();
            if (res.flag) {
                if (globalData.feedback == 0) {
                    $('input[name="opinionType"]', $('#assignmentContent')).eq(0).prop("checked", true)
                    $('input[name="opinionType"]', $('#assignmentContent')).eq(1).attr("disabled", false)
                } else if (globalData.feedback == 1) {
                    $('input[name="opinionType"]', $('#assignmentContent')).eq(0).prop("checked", false)
                    $('input[name="opinionType"]', $('#assignmentContent')).eq(1).prop("checked", true)
                }

                $('#assignmentBox').show();
                $('#assignmentBox').siblings().hide();
            } else {
                $.layerMsg({content: '保存失败', icon: 2});
            }
        })
    })


});
//全部意见
function callJS(flowStep,signlock,flowPrcs,runid){
    $('#imgStrss').html(' ')
    $.ajax({
        type: "get",
        url: "/workflow/work/findworkfeedback",
        dataType: 'JSON',
        data: {
            prcsId:flowStep,
            signlock: signlock,
            flowPrcs:flowPrcs,
            runId:runid
        },
        beforeSend : function(request) {
            if(beforeToken != ''){
                request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
            }
        },
        success: function (obj) {

            //当前登陆人
            var userName = ''
            var userIdlike = ''
            $.ajax({
                url: '/Meetequipment/getuser',
                type: 'get',
                dataType: 'json',
                async:false,
                success: function (res) {
                    userName = res.object.userName
                    userIdlike = res.object.userId
                }
            })
            globalData.data = obj.obj;
            // 如果禁止会签，已有会签意见则显示意见隐藏输入框，如果没有会签意见则隐藏会签意见区
            if (feedback == '1') {
                $('#scrollModule').show()
                if (obj.obj.length > 0) {
                    $('#signText').hide()
                } else {
                    $('#signModule').hide()
                }
                $('.blockHq').click(function(){
                    layer.msg("本步骤禁止会签！", {icon: 2});
                    $('#HqEwc2').hide()
                    $('#HqEwc1').show()
                })
            }else if(feedback == '-1'){
                $('#signModule').hide();
                $('.signBoxApp').hide();
            }else{
                //区分企业微信
                if ($.getQueryString("type") == 'EWC') {
                    $('#signModule').hide()
                    $('#HqEwc2').hide()
                    $('.copyText').show()
                    $('#HqEwc1').show()
                } else {
                    $('#signModule').hide()
                    $('#signText').hide()
                    $('#HqEwc1').hide()
                    $('#HqEwc2').hide()
                }
            }
            //会签意见区
            var timeStr = ''
            var timeStr1 = ''
            var listImg = []
            var srcImg = ''
            var timeTday = ''
            var attachFile = ''
            var base64 = ''
            var timeStr2 = ''
            var http = location.origin;
            var isDisplay;
            if ($.getQueryString("type") == 'EWC') {
                isDisplay='inline-block'
            }else{
                isDisplay='none'
            }
            //前一天
            var leet = getNextDate(new Date(),-1)
            //当前
            var newTime = getNextDate(new Date(),0)
            var replyHq = []
            var hqLi = []
            for(var a=0;a<obj.obj.length;a++){
                if(obj.obj[a].replyId == 0 ){
                    //会签意见
                    hqLi.push(obj.obj[a])
                }else {
                    //回复意见
                    replyHq.push(obj.obj[a])
                }
            }
            //遍历寻找回复的会签
            for(var b=0;b<hqLi.length;b++){
                hqLi[b].replyId =[]
                for(var c=0;c<replyHq.length;c++){
                    if(replyHq[c].replyId == hqLi[b].feedId){
                        hqLi[b].replyId.push(replyHq[c])
                    }
                }
            }
            //回复和会签意见分类
            var dataStr = hqLi
            var obj_obj = hqLi
            if(dataStr.length<=0){
                $('.opinion').css('height','60px')
                $('.relevant').css('height','60px')
            }else {
                $('.opinion').css('height','auto')
                $('.relevant').css('height','auto')
            }
            for(var q=0;q<dataStr.length;q++){
                if(dataStr[q].feedFlag == 2){
                    var feedflagstr = '<span style="font-size: 15px;font-weight: bold;color: red;">（回退意见）：</span>';
                }else{
                    var feedflagstr = '：';
                }
                listImg = dataStr[q].list

                var avatar = obj_obj[q].users.avatar;
                if(listImg != undefined && listImg.length != 0) {
                    for (var k = 0; k < listImg.length; k++) {
                        var gs = listImg[k].attachName.split('.')[1];
                        if (gs == 'jpg' || gs == 'png' || gs == 'jpeg' || gs == 'psd' || gs == 'dxf' || gs == 'webp') {
                            timeStr +=
                                '<span class="strImg" style=" margin-right: 10px;margin-top: 10px;display: inline-block">' +
                                '<a style="display: none" href="/xs?' + listImg[k].attUrl + '">下载</a><img id="blah" src="/xs?' + listImg[k].attUrl + '" onclick="anios($(this))" style="width:50px;height:50px;" url="' + http + '/xs?' + listImg[k].attUrl + '" name="' + listImg[k].attachName + '">\n' +
                                '</span>\n'
                        } else if (gs == 'aac') {

                            // for (var k = 0; k < listImg.length; k++) {
                            attachFile =
                                ' <p id="dialogue" style="position:relative" src="' + listImg[k].attUrl + '" idH5="' + listImg[k].attachId + '"  onclick="playaudioH5($(this))">' +
                                '<span id="bofang"><img class="dialogue11" thisH5="' + listImg[k].attachId + '"   style="width: 100px;height: 20px;margin-top: 10px" src="/ui/img/workflow/form/mobile/dialogue.png" /></img></span>' +
                                '<span style="position: absolute;top: 8px;left: 8px"><img class="dialogue22"   style="width: 15px;" src="/ui/img/workflow/form/mobile/voice.png"/></img></span>' +
                                '<span>' +
                                ' <span class="box111" style="display: none; position: absolute;top: -5px;left: 21px;   ">\n' +
                                '        <span class="wifi-symbol" style="display: inline-block;overflow: hidden;position: relative;">\n' +
                                '            <span style="display: inline-block" class="wifi-circle first"></span>\n' +
                                '            <span style="display: inline-block" class="wifi-circle second"></span>\n' +
                                '            <span style="display: inline-block" class="wifi-circle third"></span>\n' +
                                '        </span>\n' +
                                '    </span>\n' +
                                '</span>' +
                                '</p>'
                            // }
                        } else {
                            var fileExtension = listImg[k].attachName.substring(listImg[k].attachName.lastIndexOf(".") + 1, listImg[k].attachName.length);//截取附件文件后缀
                            var attName = encodeURI(listImg[k].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                            var deUrl = listImg[k].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + listImg[k].size;
                            var url = location.protocol +"//"+location.host+"/download?"+deUrl;
                            timeStr2 += '<div style="color: cornflowerblue;display: inline-block;" class="dech" url="'+url+'" deUrl="' + deUrl + '" aid="' + listImg[k].aid + '"  ym="' + listImg[k].ym + '" attachId="' + listImg[k].attachId + '" name="' + listImg[k].attachName + '" fileSize="' + listImg[k].fileSize + '" onclick="overLookFilePc($(this))">' +
                                '<img  src="/img/attachment_icon.png"/>' + listImg[k].attachName + '</a>' +
                                '<input type="hidden" class="inHidden" value="' + listImg[k].aid + '@' + listImg[k].ym + '_' + listImg[k].attachId + ',">' +
                                '<a style="color:#1687cb;margin-left: 20px;display: '+ isDisplay +';" class="deImgs" atturl="' + deUrl + '" ><img  style="margin:0 5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>删除</a>' +
                                '<a fileExtension="'+fileExtension+'" class="operationImg"   onclick="lookEwx($(this))" name="' + listImg[k].attachName + '" atturl="' + deUrl + '" href="javascript:;"  style="padding-left: 5px;display: '+ isDisplay +';">' +
                                '<img src="/img/attachmentIcon/attachPreview.png" style="padding: 0 5px;">查阅</a>' +
                                '</div>';
                        }
                    }
                }
                if(dataStr[q].signData != "[]" && dataStr[q].signData != ''){
                    if(dataStr[q].signData.substring(0,3) == '/xs'){
                        var imgUrl30 = dataStr[q].signData.split(",")
                        var deUrl = ''
                        for (var a = 0; a < imgUrl30.length-1; a++) {
                            deUrl=imgUrl30[a].split('?')[1]
                            base64 += '<p class="showDiv"  style="display: inline-block"><img  deUrl="'+deUrl+'" update="2" datatype="1"   showDiv = "1" style="width: 150px;height:100px" src="' + imgUrl30[a] + '" alt=""></p>'
                        }
                    }else {
                        var imgUrl = dataStr[q].signData
                        var imgUrl1 = imgUrl.substr(imgUrl.length-1,2)
                        var imgUrl2 = imgUrl.substring(1,imgUrl.length-1);
                        var imgUrl3 = imgUrl2.split(",")
                        if(imgUrl3.length != 0 && imgUrl3 != undefined){
                            var base64Datas = ''
                            var base64Data = ''
                            for(var a=0;a<imgUrl3.length;a++){
                                // base64Datas = imgUrl3[a]
                                // base64Data = dataURLtoFile(base64Datas,filename = 'workflow');
                                // console.log(base64Data)
                                base64+=  '<p class="showDiv"  style="display: inline-block"><img showDiv = "1" style="width: 150px;height:100px" src="data:image/png;base64,'+imgUrl3[a]+'" alt=""></p>'
                            }
                        }
                    }

                }
                if (obj_obj[q].feedType == 1){
                    srcImg = '/img/workflow/work/add_work/tongyi2.png'
                    yiyue = '同意'
                    colorHq= '#5FB878'

                }else if (obj_obj[q].feedType == 2){
                    srcImg = '/img/workflow/form/dsAgree.png'
                    yiyue = '不同意'
                    colorHq= 'red'
                }else {
                    srcImg = '/img/workflow/form/read.png'
                    yiyue = '已阅'
                    colorHq= '#5caeee'
                }
                if(leet == obj_obj[q].editTime.split(' ')[0]){
                    timeTday = '昨天 '+'<span style="display: inline-block;padding: 0 2px">  </span>'+obj_obj[q].editTime.split(' ')[1]
                }else if(newTime == obj_obj[q].editTime.split(' ')[0]){
                    timeTday = '今天 '+'<span style="display: inline-block;padding: 0 2px">  </span>'+obj_obj[q].editTime.split(' ')[1]
                }else {
                    timeTday = obj_obj[q].editTime.split(" ")[0] +'<span style="display: inline-block;padding: 0 2px">  </span>'+obj_obj[q].editTime.split(" ")[1]
                }

                //回复
                var hqhuifu = ''
                if(obj_obj[q].replyId.length != 0){
                    var replyId = obj_obj[q].replyId
                    var timeTday2 = ''
                    for(var d=0;d<replyId.length;d++){
                        var avatar2 = replyId[d].users.avatar;
                        if (avatar2==0){
                            avatar2 = 'boy.png'
                        }else if(avatar2==1){
                            avatar2 = 'girl.png'
                        }
                        //回复时间
                        if(leet == replyId[d].editTime.split(' ')[0]){
                            timeTday2 = '昨天 '+'<span style="display: inline-block;padding: 0 2px">  </span>'+replyId[d].editTime.split(' ')[1]
                        }else if(newTime == replyId[d].editTime.split(' ')[0]){
                            timeTday2 = '今天 '+'<span style="display: inline-block;padding: 0 2px">  </span>'+replyId[d].editTime.split(' ')[1]
                        }else {
                            timeTday2 = replyId[d].editTime.split(" ")[0] +'<span style="display: inline-block;padding: 0 2px">  </span>'+replyId[d].editTime.split(" ")[1]
                        }

                        hqhuifu += '<li class="replayHq"   id="'+replyId[d].feedId+'" runId="'+replyId[d].runId+'" userNameHq = "'+replyId[d].userId+'" style=" border: none;font-size: 13px;    padding-top: 0;list-style-type: none;position:relative;">' +
                            '<img style="width:25px;    border-radius: 50%;    position: absolute;        left: -27px;" src="/img/user/'+ avatar2 +'">' +
                            '<p style="font-weight: bold;padding-left: 5px;    color: black;">'+replyId[d].users.userName+'' +
                            '<span class="del" replayHq = "2" style="    position: relative;    left: 10px;top: -2px" dellength="0"><img style="width:16px" src="/img/workflow/work/del2.png" alt=""></span>'+
                            '</p>' +
                            '<p style="    margin-left: 5px;">'+replyId[d].users.deptName+
                            '<span style="margin-left: 10px;">'+'第'+replyId[d].prcsId+'步</span>' +
                            '<span style="margin-left: 10px;">'+''+replyId[d].prcsName+'</span>' +
                            '</p>' +
                            '<p style="margin: 5px;color:black;">'+replyId[d].content+'</p>' +
                            '<p style="margin-left: 4px;color:#999;">'+timeTday2+'</p>' +
                            '</li>'
                    }
                    $('.hqhuifu').css('margin-bottom','10px')

                }else{
                    hqhuifu = ''
                    $('.hqhuifu').css('border','none')

                }

                //点赞人员
                var likeIdsName = ''
                var likeIds = ''
                if(obj_obj[q].likeIdsName != undefined){
                    likeIdsName = obj_obj[q].likeIdsName
                    likeIds = obj_obj[q].likeIds
                }
                var likeArr = likeIdsName.split(',')
                var likeArrid = likeIds.split(',')
                var likeText = ''
                var likeBlock = 'block'
                var likeBlock2 = 'none'
                var dznumber = '';
                if(likeArr.length>0 && likeArr[0] != '') {
                    for (var e = 0; e < likeArr.length; e++) {
                        dznumber = likeArr.length
                        likeText += '<span style="position: relative;top:1px"><svg t="1610006155617" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2619" width="16" height="16"><path d="M884.875894 423.143253 646.970506 423.143253c92.185562-340.464205-63.516616-357.853247-63.516616-357.853247-65.993017 0-52.312436 52.182476-57.3031 60.881602 0 166.502152-176.849824 296.971645-176.849824 296.971645l0 472.171899c0 46.607504 63.516616 63.393819 88.433098 63.393819l357.452111 0c33.641191 0 61.036122-88.224344 61.036122-88.224344 88.434122-300.70569 88.434122-390.177444 88.434122-390.177444C944.657442 418.179195 884.875894 423.143253 884.875894 423.143253L884.875894 423.143253 884.875894 423.143253zM884.875894 423.143253" p-id="2620" fill="#8a8a8a"></path><path d="M251.671415 423.299819 109.214912 423.299819c-29.420053 0-29.873378 28.89612-29.873378 28.89612l29.420053 476.202703c0 30.309306 30.361495 30.309306 30.361495 30.309306L262.420223 958.707948c25.686009 0 25.458835-20.049638 25.458835-20.049638L287.879058 459.411271C287.879058 422.837284 251.671415 423.299819 251.671415 423.299819L251.671415 423.299819 251.671415 423.299819zM251.671415 423.299819" p-id="2621" fill="#8a8a8a"></path></svg></span>' + likeArr[e]
                        if(userIdlike == likeArrid[e]){
                            likeBlock = 'none'
                            likeBlock2 = 'block'
                        }else {
                            likeBlock = 'block'
                            likeBlock2 = 'none'
                        }
                    }
                }
                //选人
                var toIds = ''
                var toIdsArr = ''
                if(obj_obj[q].toIds != undefined && obj_obj[q].toIds != ''){
                    toIds = obj_obj[q].toIdsName
                    toIdsArr  = toIds.split(',')
                }else {
                    toIds = ''
                }
                var toIdsText = ''
                if(toIdsArr.length>0 && toIdsArr[0] != ''){
                    for(var g=0;g<toIdsArr.length;g++){
                        toIdsText+='@'+toIdsArr[g]+'<span style="margin-right:5px"></span>'
                    }
                }
                if (avatar==0){
                    avatar = 'boy.png'
                }else if(avatar==1){
                    avatar = 'girl.png'
                }

                timeStr1 += '  <li class="layui-timeline-item" id="'+obj_obj[q].feedId+'" runId="'+obj_obj[q].runId+'" userNameHq = "'+obj_obj[q].userId+'" style="position: relative;padding-bottom: 0;">\n' +
                    '<i class="layui-icon layui-timeline-axis portrait"><img style="width: 30px;border-radius: 50%;    margin: 0 10px;" src="/img/user/'+ avatar +'"></img></i>\n' +
                    '<p class="quote" style="position: absolute;right: 10px;top:5px;display:none;">' +
                    '<span style="color: #01adff;display: none" class="copyText">引用</span>' +
                    // '<span style="margin-left: 10px;color: #01adff">转发</span>' +
                    '</p>' +
                    '    <div class="layui-timeline-content layui-text" style="margin-left: 15px;">\n' +
                    '<div  id="timeStr1">' +
                    '<span style="margin-bottom: 5px;font-size: 15px;font-weight: bold;color: black">'+obj_obj[q].users.userName+feedflagstr+'</span>' +
                    '<span style="font-size: 14px;"><img style="width: 15px;" src="'+srcImg+'"></img></span>' +
                    '<span style="font-size: 14px;padding: 0 5px;color: '+colorHq+'">'+yiyue+'</span>' +
                    '<span class="del delli" replayHq = "1" dellength="'+obj_obj[q].replyId.length+'" style="margin-left: 5px;position: relative;top: -2px"><img style="width:16px" src="/img/workflow/work/del2.png" alt=""></span>' +
                    '<p style="    color: #999;    font-size: 13px;">'+obj_obj[q].users.deptName+
                    '<span style="margin-left: 10px;">'+'第'+obj_obj[q].prcsId+'步</span>' +
                    '<span style="margin-left: 10px;">'+''+obj_obj[q].prcsName+'</span>' +
                    '</p>' +
                    // '<span style="margin-bottom: 5px;font-size: 14px;">('+obj_obj[q].editTime.split(" ")[0]+'<span style="display: inline-block;padding: 0 2px">  </span> '+obj.obj[q].editTime.split(" ")[1]+')</span>' +
                    '</div>\n'+
                    ' <p style="    color: black;position: relative" class="content">'+obj_obj[q].content+
                    '<span style="">'+toIdsText+'</span>' +
                    '</p>\n' +
                    '<p>'+attachFile+'</p>' +

                    // '<p><video controls autoplay name="media"><source src="//img.tukuppt.com/newpreview_music/08/99/02/5c88d829855a520173.mp3" type="audio/mpeg"></video></p>' +
                    '</p>\n'+
                    ' <p>'+timeStr+'</p>\n' +
                    ' <p >'+base64+'</p>\n' +
                    ' <p>'+timeStr2+'</p>\n' +
                    '<p style="margin-top: 5px;position: relative;    font-size: 13px;    color: #999;">'+timeTday+'' +
                    '<span style="position: absolute;right:72px;top:-7px" id="'+obj_obj[q].feedId+'" class="reply"><svg style="width:18px" t="1609811871802" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="6571" width="32" height="32"><path d="M0 198.777l0 433.692c0 84.328 68.266 152.595 152.595 152.595l228.895 0 8.032 192.753L614.4 785.064l257.003 0c84.328 0 152.595-68.266 152.595-152.595L1023.998 198.777c0-84.328-68.266-152.595-152.595-152.595L152.599 46.182c-84.328 0-152.595 68.266-152.595 152.595L0 198.777zM658.57 439.717c0-40.158 32.125-72.282 72.282-72.282 40.157 0 72.282 32.125 72.282 72.282 0 40.158-32.125 72.282-72.282 72.282C690.694 511.999 658.57 479.874 658.57 439.717L658.57 439.717zM437.708 439.717c0-40.158 32.125-72.282 72.282-72.282s72.282 32.125 72.282 72.282c0 40.158-32.125 72.282-72.282 72.282C469.832 511.999 437.708 479.874 437.708 439.717zM220.864 439.717c0-40.158 32.125-72.282 72.282-72.282s72.282 32.125 72.282 72.282c0 40.158-32.125 72.282-72.282 72.282C252.987 511.999 220.864 479.874 220.864 439.717z" p-id="6572" fill="#bfbfbf"></path></svg></span>' +

                    '<span style="position: absolute;right:42px;top:-11px;display:'+likeBlock+';" id="'+obj_obj[q].feedId+'" display= "none" class="thumbs-up"><svg style="width: 20px" t="1609811158657" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2577" width="32" height="32"><path d="M884.875894 423.143253 646.970506 423.143253c92.185562-340.464205-63.516616-357.853247-63.516616-357.853247-65.993017 0-52.312436 52.182476-57.3031 60.881602 0 166.502152-176.849824 296.971645-176.849824 296.971645l0 472.171899c0 46.607504 63.516616 63.393819 88.433098 63.393819l357.452111 0c33.641191 0 61.036122-88.224344 61.036122-88.224344 88.434122-300.70569 88.434122-390.177444 88.434122-390.177444C944.657442 418.179195 884.875894 423.143253 884.875894 423.143253L884.875894 423.143253 884.875894 423.143253zM884.875894 423.143253" p-id="2578" fill="#bfbfbf"></path><path d="M251.671415 423.299819 109.214912 423.299819c-29.420053 0-29.873378 28.89612-29.873378 28.89612l29.420053 476.202703c0 30.309306 30.361495 30.309306 30.361495 30.309306L262.420223 958.707948c25.686009 0 25.458835-20.049638 25.458835-20.049638L287.879058 459.411271C287.879058 422.837284 251.671415 423.299819 251.671415 423.299819L251.671415 423.299819 251.671415 423.299819zM251.671415 423.299819" p-id="2579" fill="#bfbfbf"></path></svg></span>' +
                    '<span style="position: absolute;right:42px;top:-11px;display:'+likeBlock2+';" id="'+obj_obj[q].feedId+'" display= "block" class="thumbs-up thumbs-up2"><svg style="width: 20px" t="1609834510019" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2675" width="32" height="32"><path d="M884.875894 423.143253 646.970506 423.143253c92.185562-340.464205-63.516616-357.853247-63.516616-357.853247-65.993017 0-52.312436 52.182476-57.3031 60.881602 0 166.502152-176.849824 296.971645-176.849824 296.971645l0 472.171899c0 46.607504 63.516616 63.393819 88.433098 63.393819l357.452111 0c33.641191 0 61.036122-88.224344 61.036122-88.224344 88.434122-300.70569 88.434122-390.177444 88.434122-390.177444C944.657442 418.179195 884.875894 423.143253 884.875894 423.143253L884.875894 423.143253 884.875894 423.143253zM884.875894 423.143253" p-id="2676" fill="#1296db"></path><path d="M251.671415 423.299819 109.214912 423.299819c-29.420053 0-29.873378 28.89612-29.873378 28.89612l29.420053 476.202703c0 30.309306 30.361495 30.309306 30.361495 30.309306L262.420223 958.707948c25.686009 0 25.458835-20.049638 25.458835-20.049638L287.879058 459.411271C287.879058 422.837284 251.671415 423.299819 251.671415 423.299819L251.671415 423.299819 251.671415 423.299819zM251.671415 423.299819" p-id="2677" fill="#1296db"></path></svg></span>'+
                    '<span class="dzNmuber" title="'+dznumber+'">'+dznumber+'<span>'+
                    '</p>'+
                    '<p style = "font-size:13px" class="likeDz">'+likeText+'</p>' +
                    '<ul class="hqhuifu" style="margin-bottom:10px;border: none">'+hqhuifu+'</ul>' +
                    '    </div>\n' +
                    '  </li>\n'

                timeStr = ''
                attachFile = ''
                base64 = ''
                timeStr2 = ''
            }
            $('#imgStrss').prepend(timeStr1)

            $(".layui-timeline-item").mouseover(function(){
                $(this).find('.quote').css("display",'block');
            });
            $(".layui-timeline-item").mouseout(function(){
                $(this).find('.quote').css("display",'none');
            });
            //回复
            $('.reply').click(function(){
                var replyId = $(this).attr('id')
                layer.open({
                    type: 1,
                    title: ['回复', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['300px', '220px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['确定', '取消'],
                    offset:'50px',
                    content:'' +
                        ' <textarea style="height: 91%;width: 92%;margin:5px auto" placeholder="请输入回复内容" class="layui-textarea replyIdText"></textarea>' +
                        '',
                    success: function () {
                        $('.replyIdText').focus()
                    },
                    yes:function(index){
                        if($('.replyIdText').val() == ''){
                            $.layerMsg({content:'请输入回复意见意见',icon:1});
                            layer.closeAll();
                            return false
                        }
                        $.ajax({
                            type: "get",
                            url: "workfeedback",
                            // url:"/workflow/work/insertFRFMobile",
                            dataType: 'JSON',
                            data: {
                                prcsId: globalData.flowRunPrcs.prcsId,
                                flowPrcs: flowPrcs,
                                runId: runId,
                                content: $('.replyIdText').val(),
                                file: '',
                                feedFlag: '0',
                                feedType: '',
                                attachmentId: '',
                                attachmentName: '',
                                replyId:replyId,
                                toIds:''
                            },
                            success: function (obj) {
                                $.layerMsg({content:'保存成功',icon:1});
                                layer.closeAll();

                                // initSign(prcsId,flowPrcs,runId);
                            }
                        })
                        callJS(globalData.flowStep,globalData.signlock,globalData.flowPrcs,runid)
                    }
                })
            })
            // 删除会签意见
            $(document).on('click','.del',function(){
                var replayThis = $(this)
                var id = replayThis.parents('li').attr('id');
                // var prcsId = $(this).parents('li').attr('flowNum');
                // var flowPrcs = $(this).parents('li').attr('flowPrcs');
                var urseNameHq =  $(this).parents('li').attr('usernamehq');
                //当前登陆人
                var userName = ''
                $.ajax({
                    url: '/Meetequipment/getuser',
                    type: 'get',
                    dataType: 'json',
                    async:false,
                    success: function (res) {
                        userName = res.object.userId

                    }
                })
                var dellength = 0
                if(replayThis.attr('replayHq') == "1"){
                    var runId = replayThis.parents('li').attr('runId');
                    dellength =  replayThis.parents('li').find('.replayHq').length
                }else {
                    var runId = replayThis.parents('li .replayHq').attr('runId');
                    dellength = 0
                }

                if(dellength > 0){
                    $.layerMsg({content:"请先删除回复意见！",icon:2},function(){

                    });
                    return false
                }
                if(userName != urseNameHq){
                    $.layerMsg({content:"只能删除自己的意见！",icon:2},function(){

                    });
                    return false
                }
                layer.confirm(' 确定要删除该会签意见吗？', {
                    btn: [' 确定', ' 取消'], //按钮
                    title: " 提示"
                },function(){
                    $.ajax({
                        url:'/form/deleteContent',
                        dataType:'json',
                        type:'get',
                        data:{
                            feedId:id
                        },
                        success:function(res){
                            if(res.flag){
                                if(replayThis.attr('replayHq') == "1"){
                                    var runId = replayThis.parents('li').remove();

                                }else {
                                    var runId = replayThis.parents('li .replayHq').remove();
                                    console.log(replayThis.parents('li').find('.delli').attr('dellength'))
                                }
                                layer.closeAll();
                            }
                        }
                    })
                }, function () {
                    layer.closeAll();
                })
            });
            //点赞
            $('.thumbs-up').click(function(){
                var dzblock = $(this).attr('display')
                var feedId = $(this).attr('id')
                var flag = ''
                if(dzblock == 'none'){
                    $(this).css('display','none')
                    $(this).next().css('display','block')
                    flag =1
                    var userNamelike = '<span style="position: relative;top:2px;font-size:2px"><svg style="width:14px" t="1610006155617" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2619" width="16" height="16"><path d="M884.875894 423.143253 646.970506 423.143253c92.185562-340.464205-63.516616-357.853247-63.516616-357.853247-65.993017 0-52.312436 52.182476-57.3031 60.881602 0 166.502152-176.849824 296.971645-176.849824 296.971645l0 472.171899c0 46.607504 63.516616 63.393819 88.433098 63.393819l357.452111 0c33.641191 0 61.036122-88.224344 61.036122-88.224344 88.434122-300.70569 88.434122-390.177444 88.434122-390.177444C944.657442 418.179195 884.875894 423.143253 884.875894 423.143253L884.875894 423.143253 884.875894 423.143253zM884.875894 423.143253" p-id="2620" fill="#8a8a8a"></path><path d="M251.671415 423.299819 109.214912 423.299819c-29.420053 0-29.873378 28.89612-29.873378 28.89612l29.420053 476.202703c0 30.309306 30.361495 30.309306 30.361495 30.309306L262.420223 958.707948c25.686009 0 25.458835-20.049638 25.458835-20.049638L287.879058 459.411271C287.879058 422.837284 251.671415 423.299819 251.671415 423.299819L251.671415 423.299819 251.671415 423.299819zM251.671415 423.299819" p-id="2621" fill="#8a8a8a"></path></svg></span>'+userName
                    $(this).parent().next().append(userNamelike)
                    var likeN = ''
                    if($(this).parent().find('.dzNmuber').attr('title') == ''){
                        likeN = 0
                    }else{
                        likeN = $(this).parent().find('.dzNmuber').attr('title')
                    }
                    var numbeilike = parseInt(likeN)+1
                    if(numbeilike >0){
                        $(this).parent().find('.dzNmuber').html(numbeilike)
                    }
                }else {
                    $(this).prev().css('display','block')
                    $(this).css('display','none')
                    flag = 0
                    callJS(globalData.flowStep,globalData.signlock,globalData.flowPrcs,runid)
                }
                $.ajax({
                    type: "get",
                    url: "/workflow/work/addLike",
                    // url:"/workflow/work/insertFRFMobile",
                    dataType: 'JSON',
                    data: {
                        feedId:feedId,
                        flag:flag
                    },
                    success: function (obj) {
                        console.log(obj)
                    }
                })

            })
            if ($.getQueryString("type") == 'EWC') {
                $('.copyText').show()
            }
            //点击引用
            $('.copyText').click(function(){
                var text =   $(this).parent().siblings().find('.content').text()
                $('.signTexthq').val(text)
            })
        }
    });
}

//与我相关
function aboutMe() {
    $.ajax({
        type: "post",
        url: "/workflow/work/getToIds",
        dataType: 'JSON',
        page: true,
        data:{
            runId:runId
        },
        success: function (obj) {
            var str = ''
            var listImg = []

            var timeStr = ''
            var timeStr1 = ''
            var srcImg = ''
            var timeTday = ''
            var attachFile = ''
            var base64 = ''
            var timeStr2 = ''
            if(obj.obj.length<=0){
                $('.relevant').css('height','60px')
            }else {
                $('.relevant').css('height','auto')
            }
            for(var i=0;i<obj.obj.length;i++){
                var avatar = obj.obj[i].users.avatar;
                if (avatar==0){
                    avatar = 'boy.png'
                }else if(avatar==1){
                    avatar = 'girl.png'
                }
                listImg = obj.obj[i].list
                if(obj.obj[i].feedFlag == 2){
                    var feedflagstr = '<span style="font-size: 15px;font-weight: bold;color: red;">（回退意见）：</span>';
                }else{
                    var feedflagstr = '：';
                }

                if(listImg != undefined && listImg.length != 0) {
                    for (var k = 0; k < listImg.length; k++) {
                        var gs = listImg[k].attachName.split('.')[1];
                        if (gs == 'jpg' || gs == 'png' || gs == 'jpeg' || gs == 'psd' || gs == 'dxf' || gs == 'webp') {
                            timeStr +=
                                '<span class="strImg" style=" margin-right: 10px;margin-top: 10px;display: inline-block">' +
                                '<a style="display: none" href="/xs?' + listImg[k].attUrl + '">下载</a><img id="blah" src="/xs?' + listImg[k].attUrl + '" onclick="anios($(this))" style="width:50px;height:50px;"  name="' + listImg[k].attachName + '">\n' +
                                '</span>\n'
                        } else if (gs == 'aac') {

                            attachFile =
                                ' <p id="dialogue" style="position:relative;text-align: left;" src="' + listImg[k].attUrl + '" idH5="' + listImg[k].attachId + 's"  onclick="playaudioH5s($(this))">' +
                                '<span id="bofang"><img class="dialogue11" thisH5="' + listImg[k].attachId + 's"   style="width: 100px;height: 20px;margin-top: 10px" src="/ui/img/workflow/form/mobile/dialogue.png" /></img></span>' +
                                '<span style="position: absolute;top: 10px;left: 8px"><img class="dialogue22"   style="width: 15px;" src="/ui/img/workflow/form/mobile/voice.png"/></img></span>' +
                                '<span>' +
                                ' <span class="box111" style="display: none; position: absolute;top: -5px;left: 21px;   ">\n' +
                                '        <span class="wifi-symbol" style="display: inline-block;overflow: hidden;position: relative;">\n' +
                                '            <span style="display: inline-block" class="wifi-circle first"></span>\n' +
                                '            <span style="display: inline-block" class="wifi-circle second"></span>\n' +
                                '            <span style="display: inline-block" class="wifi-circle third"></span>\n' +
                                '        </span>\n' +
                                '    </span>\n' +
                                '</span>' +
                                '</p>'
                            // }
                        } else {
                            var fileExtension = listImg[k].attachName.substring(listImg[k].attachName.lastIndexOf(".") + 1, listImg[k].attachName.length);//截取附件文件后缀
                            var attName = encodeURI(listImg[k].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                            var deUrl = listImg[k].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + listImg[k].size;
                            var url = location.protocol +"//"+location.host+"/download?"+deUrl;
                            timeStr2 += '<div style="color: cornflowerblue" class="dech" url="'+url+'" deUrl="' + deUrl + '" aid="' + listImg[k].aid + '"  ym="' + listImg[k].ym + '" attachId="' + listImg[k].attachId + '" name="' + listImg[k].attachName + '" fileSize="' + listImg[k].fileSize + '" onclick="overLookFilePc($(this))"><img  src="/img/attachment_icon.png"/>' + listImg[k].attachName + '</a><input type="hidden" class="inHidden" value="' + listImg[k].aid + '@' + listImg[k].ym + '_' + listImg[k].attachId + ',"></div>';
                        }
                    }
                }
                if( obj.obj[i].signData != "[]" && obj.obj[i].signData != ''){
                    if(obj.obj[i].signData.substring(0,3) == '/xs'){
                        var imgUrl30 = obj.obj[i].signData.split(",")
                        var deUrl = ''
                        for (var a = 0; a < imgUrl30.length-1; a++) {
                            deUrl=imgUrl30[a].split('?')[1]
                            base64 += '<p class="showDiv"  style="display: inline-block"><img  deUrl="'+deUrl+'" update="2" datatype="1"   showDiv = "1" style="width: 150px;height:100px" src="' + imgUrl30[a] + '" alt=""></p>'
                        }
                    }else{
                        var imgUrl = obj.obj[i].signData
                        var imgUrl1 = imgUrl.substr(imgUrl.length-1,2)
                        var imgUrl2 = imgUrl.substring(1,imgUrl.length-1);
                        var imgUrl3 = imgUrl2.split(",")
                        if(imgUrl3.length != 0 && imgUrl3 != undefined){
                            for(var a=0;a<imgUrl3.length;a++){
                                base64+=  '<p class="showDiv"  style="    display: inline-block;"><img showDiv = "1" style="width: 150px;height:100px;" src="data:image/png;base64,'+imgUrl3[a]+'" alt=""></p>'
                            }
                        }
                    }

                }
                var leet = getNextDate(new Date(),-1)
                //当前
                var newTime = getNextDate(new Date(),0)

                if (obj.obj[i].feedType == 1){
                    srcImg = '/img/workflow/work/add_work/tongyi2.png'
                    yiyue = '同意'
                    colorHq= '#5FB878'

                }else if (obj.obj[i].feedType == 2){
                    srcImg = '/img/workflow/form/dsAgree.png'
                    yiyue = '不同意'
                    colorHq= 'red'
                }else {
                    srcImg = '/img/workflow/form/read.png'
                    yiyue = '已阅'
                    colorHq= '#5caeee'
                }

                if(leet == obj.obj[i].editTime.split(' ')[0]){
                    timeTday = '昨天 '+'<span style="display: inline-block;padding: 0 2px">  </span>'+obj.obj[i].editTime.split(' ')[1]
                }else if(newTime == obj.obj[i].editTime.split(' ')[0]){
                    timeTday = '今天 '+'<span style="display: inline-block;padding: 0 2px">  </span>'+obj.obj[i].editTime.split(' ')[1]
                }else {
                    timeTday = obj.obj[i].editTime.split(" ")[0] +'<span style="display: inline-block;padding: 0 2px">  </span>'+obj.obj[i].editTime.split(" ")[1]
                }

                //判断密送人的是否显示和隐藏
                if(obj.obj[i].secretType == '1'){
                    replynone = 'block'
                }else{
                    replynone = 'none'
                }

                //回复
                var hqhuifu = ''
                if(obj.obj[i].reply.length != 0){

                    var replyId = obj.obj[i].reply
                    var timeTday2 = ''
                    for(var d=0;d<replyId.length;d++){

                        //回复时间
                        if(leet == replyId[d].editTime.split(' ')[0]){
                            timeTday2 = '昨天 '+'<span style="display: inline-block;padding: 0 2px">  </span>'+replyId[d].editTime.split(' ')[1]
                        }else if(newTime == replyId[d].editTime.split(' ')[0]){
                            timeTday2 = '今天 '+'<span style="display: inline-block;padding: 0 2px">  </span>'+replyId[d].editTime.split(' ')[1]
                        }else {
                            timeTday2 = replyId[d].editTime.split(" ")[0] +'<span style="display: inline-block;padding: 0 2px">  </span>'+replyId[d].editTime.split(" ")[1]
                        }
                        var avatar2 = replyId[d].users.avatar;
                        if (avatar2==0){
                            avatar2 = 'boy.png'
                        }else if(avatar2==1){
                            avatar2 = 'girl.png'
                        }

                        hqhuifu += '<li style=" border: none;font-size: 13px;margin-bottom:10px;position: relative;width: 100%" id="'+replyId[d].feedId+'" userNameHq = "'+replyId[d].userId+'">' +
                            '<img style="width:25px;    position: absolute;        left: -27px;border-radius: 50%" src="/img/user/'+ avatar2 +'">' +
                            '<p style="font-weight: bold;padding-left: 5px;font-size: 13px;    color: black;">'+replyId[d].userName+'' +
                            '<span class="del" replayHq = "2"  dellength="0" style="margin-left: 12px;position: relative;top: -2px"><img style="width:16px" src="/img/workflow/work/del2.png" alt=""></span>'+
                            '</p>' +
                            '<p style="padding-left: 5px;font-size: 13px;    margin-top: 5px;    color: #999;">'+replyId[d].users.deptName+
                            '<span style="margin-left: 10px;">'+'第'+replyId[d].prcsId+'步</span>' +
                            '<span style="margin-left: 10px;">'+replyId[d].prcsName+'</span>' +
                            '</p>' +
                            '<p style="margin: 6px;    margin-top: 5px;color:black;font-size: 14px;">'+replyId[d].content+'</p>' +
                            '<p style="margin-left: 7px;color:#999;position: relative">'+timeTday2+
                            '</p>' +
                            '</li>'
                    }
                    $('.hqhuifu').css('margin-bottom','10px')

                }else{
                    hqhuifu = ''
                    $('.hqhuifu').css('border','none')

                }

                str +=
                    '<li style="display: flex" id="'+obj.obj[i].feedId+'"  flowPrcs="'+obj.obj[i].flowPrcs+'" runId="'+obj.obj[i].runId+'" userNameHq = "'+obj.obj[i].userId+'">' +
                    '<div class="">' +
                    '<img class="huiqian_lohuiqian_touxianggo" style="width: 30px;position: relative;left: -5px;top: 0px;border-radius: 50%" src="/img/user/'+ avatar +'">' +
                    '</div>' +

                    '<div class="huiqian_word" style="text-align: left;position: relative;">' +
                    '<div style="    display: flex;">' +
                    '<div  id="timeStr1">' +
                    '<h1 style="display: inline-block;font-weight: bold;font-size: 15px">'+obj.obj[i].users.userName+feedflagstr+'</h1>' +
                    '<span style="font-size: 14px;position: relative;top: 0px;left: 10px;color: '+colorHq+'"><img style="width: 15px;margin-right: 4px;" src="'+srcImg+'">'+yiyue+'</span>' +
                    '<span class="del" replayHq = "1" dellength="'+obj.obj[i].reply.length+'" style="margin-left: 25px;position: relative;top: -2px"><img style="width:16px" src="/img/workflow/work/del2.png" alt=""></span>' +
                    '</div>\n'+
                    '</div>'+
                    '<div class="area" style="display:none">' +
                    '<textarea name="" id="signText" style="width:80%;height:35px"></textarea></div>' +
                    '<p style="    color: #999;font-size: 13px;margin-top: 5px">'+obj.obj[i].users.deptName+
                    '<span style="margin-left: 10px;">'+'第'+obj.obj[i].prcsId+'步</span>' +
                    '<span style="margin-left: 10px;">'+obj.obj[i].prcsName+'</span>' +
                    '</p>' +
                    '<div class="cesdiv"  title="'+obj.obj[i].content+'"  style="color: black;font-size:14px;    text-align: left;margin: 3px 0;margin-bottom: 0;">'+obj.obj[i].content+'</div>' +
                    '<p style="    text-align: initial;">'+attachFile+'</p>' +
                    ' <p style="    text-align: initial;">'+timeStr+'</p>\n' +
                    ' <p style="    text-align: initial;">'+base64+'</p>\n' +
                    ' <p style="    text-align: initial;">'+timeStr2+'</p>\n' +
                    '<div class="" style="font-size: 13px;margin-top: 10px;5rgin-bottom:0;color: #999; text-align: left;">'+timeTday+
                    '</div>' +

                    '<ul class="hqhuifu" style="margin-bottom:10px;    margin-left: 10px;">'+hqhuifu+'</ul>' +
                    '</div>' +
                    '</li>';

                timeStr = ''
                attachFile = ''
                base64 = ''
                timeStr2 = ''

            }
            $('.relevant').html(str)
        }
    })
}


$(document).on('click','.showDiv img',function () {
    var windowW = $(window).width();//获取当前窗口宽度
    var windowH = $(window).height();//获取当前窗口高度
    var realWidth = this.width;//获取图片真实宽度
    var realHeight = this.height;//获取图片真实高度
    var thisa = $(this)
    // $(thisa).viewer();
    openHq(thisa)
})

// !function(i){"function"==typeof define&&define.amd?define("viewer",["jquery"],i):i("object"==typeof exports?require("jquery"):jQuery)}(function(i){"use strict";function t(i){return"string"==typeof i}function e(i){return"number"==typeof i&&!isNaN(i)}function s(i){return"undefined"==typeof i}function n(i,t){var s=[];return e(t)&&s.push(t),s.slice.apply(i,s)}function o(i,t){var e=n(arguments,2);return function(){return i.apply(t,e.concat(n(arguments)))}}function a(i){var t=[],s=i.rotate,n=i.scaleX,o=i.scaleY;return e(s)&&t.push("rotate("+s+"deg)"),e(n)&&e(o)&&t.push("scale("+n+","+o+")"),t.length?t.join(" "):"none"}function h(i){return i.offsetWidth}function r(i){return t(i)?i.replace(/^.*\//,"").replace(/[\?&#].*$/,""):""}function l(i,t){var e;return i.naturalWidth?t(i.naturalWidth,i.naturalHeight):(e=document.createElement("img"),e.onload=function(){t(this.width,this.height)},void(e.src=i.src))}function d(t){var e=t.length,s=0,n=0;return e&&(i.each(t,function(i,t){s+=t.pageX,n+=t.pageY}),s/=e,n/=e),{pageX:s,pageY:n}}function c(i){switch(i){case 2:return x;case 3:return $;case 4:return C}}function u(t,e){this.$element=i(t),this.options=i.extend({},u.DEFAULTS,i.isPlainObject(e)&&e),this.isImg=!1,this.isBuilt=!1,this.isShown=!1,this.isViewed=!1,this.isFulled=!1,this.isPlayed=!1,this.wheeling=!1,this.playing=!1,this.fading=!1,this.tooltiping=!1,this.transitioning=!1,this.action=!1,this.target=!1,this.timeout=!1,this.index=0,this.length=0,this.init()}var m=i(window),v=i(document),f="viewer",g=document.createElement(f),w="viewer-fixed",p="viewer-open",b="viewer-show",y="viewer-hide",x="viewer-hide-xs-down",$="viewer-hide-sm-down",C="viewer-hide-md-down",z="viewer-fade",F="viewer-in",Y="viewer-move",k="viewer-active",I="viewer-invisible",X="viewer-transition",P="viewer-fullscreen",T="viewer-fullscreen-exit",V="viewer-close",E="img",S="mousedown touchstart pointerdown MSPointerDown",D="mousemove touchmove pointermove MSPointerMove",L="mouseup touchend touchcancel pointerup pointercancel MSPointerUp MSPointerCancel",q="wheel mousewheel DOMMouseScroll",R="transitionend",M="load."+f,W="keydown."+f,_="click."+f,j="resize."+f,A="build."+f,B="built."+f,H="show."+f,U="shown."+f,N="hide."+f,O="hidden."+f,Z="view."+f,K="viewed."+f,Q="undefined"!=typeof g.style.transition,G=Math.round,J=Math.sqrt,ii=Math.abs,ti=Math.min,ei=Math.max,si=Number;u.prototype={constructor:u,init:function(){var t=this.options,e=this.$element,s=e.is(E),n=s?e:e.find(E),o=n.length,a=i.proxy(this.ready,this);o&&(i.isFunction(t.build)&&e.one(A,t.build),this.trigger(A).isDefaultPrevented()||(Q||(t.transition=!1),this.isImg=s,this.length=o,this.count=0,this.$images=n,this.$body=i("body"),t.inline?(e.one(B,i.proxy(function(){this.view()},this)),n.each(function(){this.complete?a():i(this).one(M,a)})):e.on(_,i.proxy(this.start,this))))},ready:function(){this.count++,this.count===this.length&&this.build()},build:function(){var t,e,s,n,o,a,h=this.options,r=this.$element;this.isBuilt||(this.$parent=t=r.parent(),this.$viewer=e=i(u.TEMPLATE),this.$canvas=e.find(".viewer-canvas"),this.$footer=e.find(".viewer-footer"),this.$title=s=e.find(".viewer-title"),this.$toolbar=n=e.find(".viewer-toolbar"),this.$navbar=o=e.find(".viewer-navbar"),this.$button=a=e.find(".viewer-button"),this.$tooltip=e.find(".viewer-tooltip"),this.$player=e.find(".viewer-player"),this.$list=e.find(".viewer-list"),s.addClass(h.title?c(h.title):y),n.addClass(h.toolbar?c(h.toolbar):y),n.find("li[class*=zoom]").toggleClass(I,!h.zoomable),n.find("li[class*=flip]").toggleClass(I,!h.scalable),h.rotatable||n.find("li[class*=rotate]").addClass(I).appendTo(n),o.addClass(h.navbar?c(h.navbar):y),h.inline?(a.addClass(P),e.css("z-index",h.zIndexInline),"static"===t.css("position")&&t.css("position","relative")):(a.addClass(V),e.css("z-index",h.zIndex).addClass([w,z,y].join(" "))),r.after(e),h.inline&&(this.render(),this.bind(),this.isShown=!0),this.isBuilt=!0,i.isFunction(h.built)&&r.one(B,h.built),this.trigger(B))},unbuild:function(){var i=this.options,t=this.$element;this.isBuilt&&(i.inline&&t.removeClass(y),this.$viewer.remove())},bind:function(){var t=this.options,e=this.$element;i.isFunction(t.view)&&e.on(Z,t.view),i.isFunction(t.viewed)&&e.on(K,t.viewed),this.$viewer.on(_,i.proxy(this.click,this)).on(q,i.proxy(this.wheel,this)),this.$canvas.on(S,i.proxy(this.mousedown,this)),v.on(D,this._mousemove=o(this.mousemove,this)).on(L,this._mouseup=o(this.mouseup,this)).on(W,this._keydown=o(this.keydown,this)),m.on(j,this._resize=o(this.resize,this))},unbind:function(){var t=this.options,e=this.$element;i.isFunction(t.view)&&e.off(Z,t.view),i.isFunction(t.viewed)&&e.off(K,t.viewed),this.$viewer.off(_,this.click).off(q,this.wheel),this.$canvas.off(S,this.mousedown),v.off(D,this._mousemove).off(L,this._mouseup).off(W,this._keydown),m.off(j,this._resize)},render:function(){this.initContainer(),this.initViewer(),this.initList(),this.renderViewer()},initContainer:function(){this.container={width:m.innerWidth(),height:m.innerHeight()}},initViewer:function(){var t,e=this.options,s=this.$parent;e.inline&&(this.parent=t={width:ei(s.width(),e.minWidth),height:ei(s.height(),e.minHeight)}),(this.isFulled||!t)&&(t=this.container),this.viewer=i.extend({},t)},renderViewer:function(){this.options.inline&&!this.isFulled&&this.$viewer.css(this.viewer)},initList:function(){var e=this.options,s=this.$element,n=this.$list,o=[];this.$images.each(function(s){var n=this.src,a=this.alt||r(n),h=e.url;n&&(t(h)?h=this.getAttribute(h):i.isFunction(h)&&(h=h.call(this,this)),o.push('<li><img src="'+n+'" data-action="view" data-index="'+s+'" data-original-url="'+(h||n)+'" alt="'+a+'"></li>'))}),n.html(o.join("")).find(E).one(M,{filled:!0},i.proxy(this.loadImage,this)),this.$items=n.children(),e.transition&&s.one(K,function(){n.addClass(X)})},renderList:function(i){var t=i||this.index,e=this.$items.eq(t).width(),s=e+1;this.$list.css({width:s*this.length,marginLeft:(this.viewer.width-e)/2-s*t})},resetList:function(){this.$list.empty().removeClass(X).css("margin-left",0)},initImage:function(t){var e=this.options,s=this.$image,n=this.viewer,o=this.$footer.height(),a=n.width,h=ei(n.height-o,o),r=this.image||{};l(s[0],i.proxy(function(s,n){var o,l,d=s/n,c=a,u=h;h*d>a?u=a/d:c=h*d,c=ti(.9*c,s),u=ti(.9*u,n),l={naturalWidth:s,naturalHeight:n,aspectRatio:d,ratio:c/s,width:c,height:u,left:(a-c)/2,top:(h-u)/2},o=i.extend({},l),e.rotatable&&(l.rotate=r.rotate||0,o.rotate=0),e.scalable&&(l.scaleX=r.scaleX||1,l.scaleY=r.scaleY||1,o.scaleX=1,o.scaleY=1),this.image=l,this.initialImage=o,i.isFunction(t)&&t()},this))},renderImage:function(t){var e=this.image,s=this.$image;s.css({width:e.width,height:e.height,marginLeft:e.left,marginTop:e.top,transform:a(e)}),i.isFunction(t)&&(this.transitioning?s.one(R,t):t())},resetImage:function(){this.$image.remove(),this.$image=null},start:function(t){var e=t.target;i(e).is("img")&&(this.target=e,this.show())},click:function(t){var e=i(t.target),s=e.data("action"),n=this.image;switch(s){case"mix":this.isPlayed?this.stop():this.options.inline?this.isFulled?this.exit():this.full():this.hide();break;case"view":this.view(e.data("index"));break;case"zoom-in":this.zoom(.1,!0);break;case"zoom-out":this.zoom(-.1,!0);break;case"one-to-one":this.toggle();break;case"reset":this.reset();break;case"prev":this.prev();break;case"play":this.play();break;case"next":this.next();break;case"rotate-left":this.rotate(-90);break;case"rotate-right":this.rotate(90);break;case"flip-horizontal":this.scaleX(-n.scaleX||-1);break;case"flip-vertical":this.scaleY(-n.scaleY||-1);break;default:this.isPlayed&&this.stop()}},load:function(){var t=this.options,e=this.viewer,s=this.$image;this.timeout&&(clearTimeout(this.timeout),this.timeout=!1),s.removeClass(I).css("cssText","width:0;height:0;margin-left:"+e.width/2+"px;margin-top:"+e.height/2+"px;max-width:none!important;visibility:visible;"),this.initImage(i.proxy(function(){s.toggleClass(X,t.transition).toggleClass(Y,t.movable),this.renderImage(i.proxy(function(){this.isViewed=!0,this.trigger(K)},this))},this))},loadImage:function(t){var e=t.target,s=i(e),n=s.parent(),o=n.width(),a=n.height(),h=t.data&&t.data.filled;l(e,function(i,t){var e=i/t,n=o,r=a;a*e>o?h?n=a*e:r=o/e:h?r=o/e:n=a*e,s.css({width:n,height:r,marginLeft:(o-n)/2,marginTop:(a-r)/2})})},resize:function(){this.initContainer(),this.initViewer(),this.renderViewer(),this.renderList(),this.initImage(i.proxy(function(){this.renderImage()},this)),this.isPlayed&&this.$player.find(E).one(M,i.proxy(this.loadImage,this)).trigger(M)},wheel:function(t){var e=t.originalEvent||t,s=si(this.options.zoomRatio)||.1,n=1;this.isViewed&&(t.preventDefault(),this.wheeling||(this.wheeling=!0,setTimeout(i.proxy(function(){this.wheeling=!1},this),50),e.deltaY?n=e.deltaY>0?1:-1:e.wheelDelta?n=-e.wheelDelta/120:e.detail&&(n=e.detail>0?1:-1),this.zoom(-n*s,!0,t)))},keydown:function(i){var t=this.options,e=i.which;if(this.isFulled&&t.keyboard)switch(e){case 27:this.isPlayed?this.stop():t.inline?this.isFulled&&this.exit():this.hide();break;case 32:this.isPlayed&&this.stop();break;case 37:this.prev();break;case 38:i.preventDefault(),this.zoom(t.zoomRatio,!0);break;case 39:this.next();break;case 40:i.preventDefault(),this.zoom(-t.zoomRatio,!0);break;case 48:case 49:(i.ctrlKey||i.shiftKey)&&(i.preventDefault(),this.toggle())}},mousedown:function(i){var t,e=this.options,s=i.originalEvent,n=s&&s.touches,o=i,a=e.movable?"move":!1;if(this.isViewed){if(n){if(t=n.length,t>1){if(!e.zoomable||2!==t)return;o=n[1],this.startX2=o.pageX,this.startY2=o.pageY,a="zoom"}else this.isSwitchable()&&(a="switch");o=n[0]}a&&(i.preventDefault(),this.action=a,this.startX=o.pageX||s&&s.pageX,this.startY=o.pageY||s&&s.pageY)}},mousemove:function(i){var t,e=this.options,s=this.action,n=this.$image,o=i.originalEvent,a=o&&o.touches,h=i;if(this.isViewed){if(a){if(t=a.length,t>1){if(!e.zoomable||2!==t)return;h=a[1],this.endX2=h.pageX,this.endY2=h.pageY}h=a[0]}s&&(i.preventDefault(),"move"===s&&e.transition&&n.hasClass(X)&&n.removeClass(X),this.endX=h.pageX||o&&o.pageX,this.endY=h.pageY||o&&o.pageY,this.change(i))}},mouseup:function(i){var t=this.action;t&&(i.preventDefault(),"move"===t&&this.options.transition&&this.$image.addClass(X),this.action=!1)},show:function(){var t,e=this.options;e.inline||this.transitioning||(this.isBuilt||this.build(),i.isFunction(e.show)&&this.$element.one(H,e.show),this.trigger(H).isDefaultPrevented()||(this.$body.addClass(p),t=this.$viewer.removeClass(y),this.$element.one(U,i.proxy(function(){this.view(this.target?this.$images.index(this.target):this.index),this.target=!1},this)),e.transition?(this.transitioning=!0,t.addClass(X),h(t[0]),t.one(R,i.proxy(this.shown,this)).addClass(F)):(t.addClass(F),this.shown())))},hide:function(){var t=this.options,e=this.$viewer;t.inline||this.transitioning||!this.isShown||(i.isFunction(t.hide)&&this.$element.one(N,t.hide),this.trigger(N).isDefaultPrevented()||(this.isViewed&&t.transition?(this.transitioning=!0,this.$image.one(R,i.proxy(function(){e.one(R,i.proxy(this.hidden,this)).removeClass(F)},this)),this.zoomTo(0,!1,!1,!0)):(e.removeClass(F),this.hidden())))},view:function(t){var e,s,n,o,a,h=this.$title;t=Number(t)||0,!this.isShown||this.isPlayed||0>t||t>=this.length||this.isViewed&&t===this.index||this.trigger(Z).isDefaultPrevented()||(s=this.$items.eq(t),n=s.find(E),o=n.data("originalUrl"),a=n.attr("alt"),this.$image=e=i('<img src="'+o+'" alt="'+a+'">'),this.isViewed&&this.$items.eq(this.index).removeClass(k),s.addClass(k),this.isViewed=!1,this.index=t,this.image=null,this.$canvas.html(e.addClass(I)),this.renderList(),h.empty(),this.$element.one(K,i.proxy(function(){var i=this.image,t=i.naturalWidth,e=i.naturalHeight;h.html(a+" ("+t+" &times; "+e+")")},this)),e[0].complete?this.load():(e.one(M,i.proxy(this.load,this)),this.timeout&&clearTimeout(this.timeout),this.timeout=setTimeout(i.proxy(function(){e.removeClass(I),this.timeout=!1},this),1e3)))},prev:function(){this.view(ei(this.index-1,0))},next:function(){this.view(ti(this.index+1,this.length-1))},move:function(i,t){var e=this.image;this.moveTo(s(i)?i:e.left+si(i),s(t)?t:e.top+si(t))},moveTo:function(i,t){var n=this.image,o=!1;s(t)&&(t=i),i=si(i),t=si(t),this.isViewed&&!this.isPlayed&&this.options.movable&&(e(i)&&(n.left=i,o=!0),e(t)&&(n.top=t,o=!0),o&&this.renderImage())},zoom:function(i,t,e){var s=this.image;i=si(i),i=0>i?1/(1-i):1+i,this.zoomTo(s.width*i/s.naturalWidth,t,e)},zoomTo:function(i,t,s,n){var o,a,h,r,l,c=this.options,u=.01,m=100,v=this.image,f=v.width,g=v.height;i=ei(0,i),e(i)&&this.isViewed&&!this.isPlayed&&(n||c.zoomable)&&(n||(u=ei(u,c.minZoomRatio),m=ti(m,c.maxZoomRatio),i=ti(ei(i,u),m)),i>.95&&1.05>i&&(i=1),a=v.naturalWidth*i,h=v.naturalHeight*i,s&&(o=s.originalEvent)?(r=this.$viewer.offset(),l=o.touches?d(o.touches):{pageX:s.pageX||o.pageX||0,pageY:s.pageY||o.pageY||0},v.left-=(a-f)*((l.pageX-r.left-v.left)/f),v.top-=(h-g)*((l.pageY-r.top-v.top)/g)):(v.left-=(a-f)/2,v.top-=(h-g)/2),v.width=a,v.height=h,v.ratio=i,this.renderImage(),t&&this.tooltip())},rotate:function(i){this.rotateTo((this.image.rotate||0)+si(i))},rotateTo:function(i){var t=this.image;i=si(i),e(i)&&this.isViewed&&!this.isPlayed&&this.options.rotatable&&(t.rotate=i,this.renderImage())},scale:function(i,t){var n=this.image,o=!1;s(t)&&(t=i),i=si(i),t=si(t),this.isViewed&&!this.isPlayed&&this.options.scalable&&(e(i)&&(n.scaleX=i,o=!0),e(t)&&(n.scaleY=t,o=!0),o&&this.renderImage())},scaleX:function(i){this.scale(i,this.image.scaleY)},scaleY:function(i){this.scale(this.image.scaleX,i)},play:function(){var t,s=this.options,n=this.$player,o=i.proxy(this.loadImage,this),a=[],h=0,r=0;this.isShown&&!this.isPlayed&&(s.fullscreen&&this.requestFullscreen(),this.isPlayed=!0,n.addClass(b),this.$items.each(function(t){var e=i(this),l=e.find(E),d=i('<img src="'+l.data("originalUrl")+'" alt="'+l.attr("alt")+'">');h++,d.addClass(z).toggleClass(X,s.transition),e.hasClass(k)&&(d.addClass(F),r=t),a.push(d),d.one(M,{filled:!1},o),n.append(d)}),e(s.interval)&&s.interval>0&&(t=i.proxy(function(){this.playing=setTimeout(function(){a[r].removeClass(F),r++,r=h>r?r:0,a[r].addClass(F),t()},s.interval)},this),h>1&&t()))},stop:function(){this.isPlayed&&(this.options.fullscreen&&this.exitFullscreen(),this.isPlayed=!1,clearTimeout(this.playing),this.$player.removeClass(b).empty())},full:function(){var t=this.options,e=this.$image,s=this.$list;this.isShown&&!this.isPlayed&&!this.isFulled&&t.inline&&(this.isFulled=!0,this.$body.addClass(p),this.$button.addClass(T),t.transition&&(e.removeClass(X),s.removeClass(X)),this.$viewer.addClass(w).removeAttr("style").css("z-index",t.zIndex),this.initContainer(),this.viewer=i.extend({},this.container),this.renderList(),this.initImage(i.proxy(function(){this.renderImage(function(){t.transition&&setTimeout(function(){e.addClass(X),s.addClass(X)},0)})},this)))},exit:function(){var t=this.options,e=this.$image,s=this.$list;this.isFulled&&(this.isFulled=!1,this.$body.removeClass(p),this.$button.removeClass(T),t.transition&&(e.removeClass(X),s.removeClass(X)),this.$viewer.removeClass(w).css("z-index",t.zIndexInline),this.viewer=i.extend({},this.parent),this.renderViewer(),this.renderList(),this.initImage(i.proxy(function(){this.renderImage(function(){t.transition&&setTimeout(function(){e.addClass(X),s.addClass(X)},0)})},this)))},tooltip:function(){var t=this.options,e=this.$tooltip,s=this.image,n=[b,z,X].join(" ");this.isViewed&&!this.isPlayed&&t.tooltip&&(e.text(G(100*s.ratio)+"%"),this.tooltiping?clearTimeout(this.tooltiping):t.transition?(this.fading&&e.trigger(R),e.addClass(n),h(e[0]),e.addClass(F)):e.addClass(b),this.tooltiping=setTimeout(i.proxy(function(){t.transition?(e.one(R,i.proxy(function(){e.removeClass(n),this.fading=!1},this)).removeClass(F),this.fading=!0):e.removeClass(b),this.tooltiping=!1},this),1e3))},toggle:function(){1===this.image.ratio?this.zoomTo(this.initialImage.ratio,!0):this.zoomTo(1,!0)},reset:function(){this.isViewed&&!this.isPlayed&&(this.image=i.extend({},this.initialImage),this.renderImage())},update:function(){var t,e=this.$element,s=this.$images,n=[];if(this.isImg){if(!e.parent().length)return this.destroy()}else this.$images=s=e.find(E),this.length=s.length;this.isBuilt&&(i.each(this.$items,function(t){var e=i(this).find("img")[0],o=s[t];o?o.src!==e.src&&n.push(t):n.push(t)}),this.$list.width("auto"),this.initList(),this.isShown&&(this.length?this.isViewed&&(t=i.inArray(this.index,n),t>=0?(this.isViewed=!1,this.view(ei(this.index-(t+1),0))):this.$items.eq(this.index).addClass(k)):(this.$image=null,this.isViewed=!1,this.index=0,this.image=null,this.$canvas.empty(),this.$title.empty())))},destroy:function(){var i=this.$element;this.options.inline?this.unbind():(this.isShown&&this.unbind(),i.off(_,this.start)),this.unbuild(),i.removeData(f)},trigger:function(t,e){var s=i.Event(t,e);return this.$element.trigger(s),s},shown:function(){var t=this.options;this.transitioning=!1,this.isFulled=!0,this.isShown=!0,this.isVisible=!0,this.render(),this.bind(),i.isFunction(t.shown)&&this.$element.one(U,t.shown),this.trigger(U)},hidden:function(){var t=this.options;this.transitioning=!1,this.isViewed=!1,this.isFulled=!1,this.isShown=!1,this.isVisible=!1,this.unbind(),this.$body.removeClass(p),this.$viewer.addClass(y),this.resetList(),this.resetImage(),i.isFunction(t.hidden)&&this.$element.one(O,t.hidden),this.trigger(O)},requestFullscreen:function(){var i=document.documentElement;!this.isFulled||document.fullscreenElement||document.mozFullScreenElement||document.webkitFullscreenElement||document.msFullscreenElement||(i.requestFullscreen?i.requestFullscreen():i.msRequestFullscreen?i.msRequestFullscreen():i.mozRequestFullScreen?i.mozRequestFullScreen():i.webkitRequestFullscreen&&i.webkitRequestFullscreen(Element.ALLOW_KEYBOARD_INPUT))},exitFullscreen:function(){this.isFulled&&(document.exitFullscreen?document.exitFullscreen():document.msExitFullscreen?document.msExitFullscreen():document.mozCancelFullScreen?document.mozCancelFullScreen():document.webkitExitFullscreen&&document.webkitExitFullscreen())},change:function(i){var t=this.endX-this.startX,e=this.endY-this.startY;switch(this.action){case"move":this.move(t,e);break;case"zoom":this.zoom(function(i,t,e,s){var n=J(i*i+t*t),o=J(e*e+s*s);return(o-n)/n}(ii(this.startX-this.startX2),ii(this.startY-this.startY2),ii(this.endX-this.endX2),ii(this.endY-this.endY2)),!1,i),this.startX2=this.endX2,this.startY2=this.endY2;break;case"switch":this.action="switched",ii(t)>ii(e)&&(t>1?this.prev():-1>t&&this.next())}this.startX=this.endX,this.startY=this.endY},isSwitchable:function(){var i=this.image,t=this.viewer;return i.left>=0&&i.top>=0&&i.width<=t.width&&i.height<=t.height}},u.DEFAULTS={inline:!1,button:!0,navbar:!0,title:!0,toolbar:!0,tooltip:!0,movable:!0,zoomable:!0,rotatable:!0,scalable:!0,transition:!0,fullscreen:!0,keyboard:!0,interval:5e3,minWidth:200,minHeight:100,zoomRatio:.1,minZoomRatio:.01,maxZoomRatio:100,zIndex:2015,zIndexInline:0,url:"src",build:null,built:null,show:null,shown:null,hide:null,hidden:null,view:null,viewed:null},u.TEMPLATE='<div class="viewer-container"><div class="viewer-canvas"></div><div class="viewer-footer"><div class="viewer-title"></div><ul class="viewer-toolbar"><li class="viewer-zoom-in" data-action="zoom-in"></li><li class="viewer-zoom-out" data-action="zoom-out"></li><li class="viewer-one-to-one" data-action="one-to-one"></li><li class="viewer-reset" data-action="reset"></li><li class="viewer-prev" data-action="prev"></li><li class="viewer-play" data-action="play"></li><li class="viewer-next" data-action="next"></li><li class="viewer-rotate-left" data-action="rotate-left"></li><li class="viewer-rotate-right" data-action="rotate-right"></li><li class="viewer-flip-horizontal" data-action="flip-horizontal"></li><li class="viewer-flip-vertical" data-action="flip-vertical"></li></ul><div class="viewer-navbar"><ul class="viewer-list"></ul></div></div><div class="viewer-tooltip"></div><div class="viewer-button" data-action="mix"></div><div class="viewer-player"></div></div>',u.other=i.fn.viewer,i.fn.viewer=function(e){var o,a=n(arguments,1);return this.each(function(){var s,n=i(this),h=n.data(f);if(!h){if(/destroy|hide|exit|stop|reset/.test(e))return;n.data(f,h=new u(this,e))}t(e)&&i.isFunction(s=h[e])&&(o=s.apply(h,a))}),s(o)?this:o},i.fn.viewer.Constructor=u,i.fn.viewer.setDefaults=u.setDefaults,i.fn.viewer.noConflict=function(){return i.fn.viewer=u.other,this}});

function openHq(datas) {
    var src = datas.attr('src')
    layer.open({
        type: 1,
        title: ['手写签字详情', 'background-color:#2b7fe0;color:#fff;'],
        area: ['340px', '285px'],
        shadeClose: true, //点击遮罩关闭
        btn: ['确定'],
        btnAlign: 'c',
        content:'<p style="width: 95%;margin: 0 auto"><img style="width: 320px;height: 180px" src="'+src+'"></p>' ,
        success: function () {

        },
        yes:function(index){
            layer.closeAll();
        }
    })
}

// 后一天parserDate
function getNextDate(date,day) {
    var dd = new Date(date);
    dd.setDate(dd.getDate() + day);
    var y = dd.getFullYear();
    var m = dd.getMonth() + 1 < 10 ? "0" + (dd.getMonth() + 1) : dd.getMonth() + 1;
    var d = dd.getDate() < 10 ? "0" + dd.getDate() : dd.getDate();
    var getNextDate = y + "-" + m + "-" + d;
    return getNextDate
}
//语音播放
function playaudioH5(datas) {
    // alert('111')
    var url = $(datas).attr('src')
    var idH5 = $(datas).attr('idH5')
    $('.third').css('border','none')
    if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
        try{
            window.webkit.messageHandlers.playaudio.postMessage({'url':url,'idH5':idH5});
        }catch(error){
            playaudio(url);
        }
    } else if (/(Android)/i.test(navigator.userAgent)) {
        Android.playaudio(url,idH5);
    }
    if( $(datas).find(".box111").css("display") == 'none'){
        $(datas).find(".box111").css('display','block');
        $(datas).find('.dialogue22').css('display','none');
    }else{
        $(datas).find(".box111").css('display','none');
        $(datas).find('.dialogue22').css('display','initial');
    }
    $('.third').css('border','2px solid white')
}

//语音播放
function playaudioH5s(datas) {
    // alert('111')
    var url = $(datas).attr('src')
    var idH5 = $(datas).attr('idH5')
    $('.third').css('border','none')
    if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
        try{
            window.webkit.messageHandlers.playaudio.postMessage({'url':url,'idH5':idH5});
        }catch(error){
            playaudio(url);
        }
    } else if (/(Android)/i.test(navigator.userAgent)) {
        Android.playaudio(url,idH5);
    }
    if( $(datas).find(".box111").css("display") == 'none'){
        $(datas).find(".box111").css('display','block');
        $(datas).find('.dialogue22').css('display','none');
    }else{
        $(datas).find(".box111").css('display','none');
        $(datas).find('.dialogue22').css('display','initial');
    }
    $('.third').css('border','2px solid white')
}
//附件预览
function overLookFilePc(datas) {
    var url = $(datas).attr('deurl')
    var url2 = $(datas).attr('url')
    var name = $(datas).attr('name')
    if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
        try{
            window.webkit.messageHandlers.overLookFile.postMessage({'url':url2,'name':name});
        }catch(error){
            playaudio(url,name);
        }
    } else if (/(Android)/i.test(navigator.userAgent)) {
        Android.overLookFile(url2,name);
    }
}
//播放动画
function dialogue22(data) {
    $('.dialogue11').removeClass('donghuaH5')
    $('.donghuaH5').parent().siblings().find(".box111").css('display','block');
    $('.donghuaH5').parent().siblings().find('.dialogue22').css('display','none');
    var datas = data
    // var datas = '1900239639s'
    var dialogueDiv = $('.dialogue11')
    for(var b=0;b<dialogueDiv.length;b++){
        if($('.dialogue11').eq(b).attr('thisH5') == datas){
            $('.dialogue11').eq(b).addClass('donghuaH5')
        }
    }
    if( $('.donghuaH5').parent().siblings().find(".box111").css("display") == 'none'){
        $('.donghuaH5').parent().siblings().find(".box111").css('display','block');
        $('.donghuaH5').parent().siblings().find('.dialogue22').css('display','none');
    }else{
        $('.donghuaH5').parent().siblings().find(".box111").css('display','none');
        $('.donghuaH5').parent().siblings().find('.dialogue22').css('display','initial');
    }
}

// $("#dialogue").bind("click",function(){
//     playaudioH5(datas);
//     dialogue22(data);
// });
