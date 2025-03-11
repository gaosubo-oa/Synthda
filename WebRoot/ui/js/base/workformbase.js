//获取国际语言标志
var type = getCookie("language");
var zj='';
var TDataSelectionCtrl_Name = '';
var selectfind = false;
if (type == 'zh_CN') {
    zj = "转交";
} else if (type == 'en_US') {
    zj = "Transfer";
} else if (type == 'zh_TW') {
    zj = "轉交";
} else {
    zj = "转交";
}
function noneperson(fn){//无主办会签问题 解决 访问workfastadd接口 获取当前流程是否是无主办会签类型
    //查看当前流程是否已办结, 已办结跳转至详情页面
    if(workForm.option.ish5){
        // 只有移动端办理页面才执行
        $.ajax({
            url: '/workflow/work/selectFind',
            type: 'GET',
            data: {
                flowId: $.getQueryString("flowId"),
                prcsId: $.getQueryString("flowStep"),
                flowPrcs: $.getQueryString("prcsId"),
                runId: $.getQueryString("runId")
            },
            async:false,
            success: function (res) {
                if (res.flag && res.object == 'err') {
                    selectfind = true;
                    $('body').show();
                    $('.head_top').css('visibility','hidden');
                    $('#basic_infor').css('visibility','hidden');
                    $('#HqEwc1').css('visibility','hidden');
                    // layer.msg('当前流程已办结，即将前往详情页面', { time: 3000 }, function () {
                    //     var href = location.href.replace('workformh5', 'workformh5PreView');
                    //     location.href = href;
                    // });
                    $('.layLoad').show();
                    setTimeout(function(){
                        var href = location.href.replace('workformh5', 'workformh5PreView');
                        location.href = href;
                    }, 3000)
                }
            },
            error: function (err) {
                console.log(err);
            }
        })
    }
    if(!selectfind){
        $.extend({
            getQueryString: function (name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
                var r = window.location.search.substr(1).match(reg);
                if (r != null) return unescape(r[2]);
                return null;
            }
        });
        var opflag =  $.getQueryString("opflag") || 1;
        if(opflag == 0){
            var flowId = $.getQueryString("flowId");
            var flowStep = $.getQueryString("flowStep") || '';
            var prcsId = $.getQueryString("prcsId") || '';
            var runId = $.getQueryString("runId") || '';
            var tableName = $.getQueryString("tableName") || '';
            var tabId =  $.getQueryString("tabId") || '';
            // var href = url.split('opflag=')[0] + 'opflag=1' + url.split('opflag=')[1].substring(1);
            // window.location.href = href;
            $.ajax({
                url: '/workflow/work/workfastAdd',//URL
                data: {
                    flowId: flowId,
                    runId: runId,
                    prcsId: prcsId,
                    flowStep: flowStep,
                    tableName:tableName,
                    tabId:tabId
                },
                type: 'get',
                datatype: 'json',
                async: false,
                success: function (json) {
                    var data = json.object.flowRunPrcs;
                    var url = location.href;
                    opflag = data.opFlag;
                    if(data.opFlag == 1){
                        //全局变量无主办会签或者先接受者主办情况下，当前用户已经要变为主办人，g_form_view-edit
                        g_form_view = 'edit';

                        if(url.indexOf('workformh5') > -1 && $.getQueryString("type") != 'EWC'){
                            if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                                try{
                                    window.webkit.messageHandlers.rightTitle.postMessage({'title': zj, 'name': '321', 'function': 'turn'});
                                }catch(err){
                                    rightTitle(zj, '321', 'turn');
                                }
                            } else if (/(Android)/i.test(navigator.userAgent)) {
                                Android.rightTitle(zj, '321', 'turn');
                            }
                        }else{
                            $('#foot_rig').show();
                            $('#foot_rig1').hide();
                        }
                    }else{
                        if(url.indexOf('workformh5') > -1){
                            $('.type_done').hide();
                            $('#lctbtn').show();
                            $('#opflagturn').show();
                            $('#formInfo').show();
                            if($.getQueryString("type") != 'EWC'){
                                if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                                    try{
                                        window.webkit.messageHandlers.rightTitle.postMessage({'title': '办理完毕',
                                            'name': '123', 'function': 'opflagturnClick'});
                                    }catch(err){
                                        rightTitle('办理完毕', '123', 'opflagturnClick');
                                    }
                                } else if (/(Android)/i.test(navigator.userAgent)) {
                                    Android.rightTitle('办理完毕', '123', 'opflagturnClick');
                                }
                            }else{
                                // 企业微信端会签操作框底部操作框显示办理完毕按钮
                                $('#boxopflagturn').show();
                                $('#opflagturn').hide();
                            }
                        }
                    }
                    $('body').show();
                    if(fn != undefined){
                        fn();
                    }
                }
            });


        }else{
            $('body').show();
            if(fn != undefined){
                fn();
            }
        }

        return opflag;
    }

}

function TDataSelectionCtrl(e){//处理了数据源控件 按钮点击功能
    TDataSelectionCtrl_Name = e.attr('name');
    var data_control = e.attr("DATA_CONTROL");
    var item_str = '';
    if(data_control){
        item_str = [];
        for(var i=0;i<data_control.split('`').length;i++){
            if(data_control.split('`')[i] != ''){
                item_str.push(workForm.correspondence.objectTD[data_control.split('`')[i]]);
            }
        }
        item_str = item_str.join(',');
    }
    var url = "/form/dataPicker?item_str="+item_str;
    // var URL = "dataSrc=" + dataSrc + "&dataField=" + dataField + "&dataFieldName=" + dataFieldName + "&item_str=" + item_str + "&type=" + type + "&objName=" + obj.name + "&dataQuery=" + dataQuery;
    //"item_str=DATA_114,DATA_115,DATA_146,DATA_291,DATA_273,DATA_287,DATA_143,DATA_293,DATA_297,DATA_298,DATA_294,DATA_299,DATA_295,DATA_304,&type=undefined&objName=DATA_300&dataQuery=1`1`0`0`0`0`0`0`0`0`0`0`0`"
    $.popWindow(url,'数据源选人控件','20','150','1200px','600px');
}

// 匹配附件上传控件已上传附件数据回显时候的文件类型，默认是图片类型
function getFileArrType(arr) {
    for(var i = 0;i<arr.length;i++){
        if(arr[i].indexOf('ATTACHMENT_NAME=') > -1){
            var nAt= GetFileNameNoExt(arr[i].split('ATTACHMENT_NAME=')[1]) + '*' +UrlGetRequest(arr[i])||"/img/icon_file.png"
            return nAt
        }
    }
    return "/img/icon_file.png"
}

// 匹配工作流附件上传控件上传的文件ATTACHMENT_NAME的值
function getAtturlName(atturl){
    if(atturl.split('&ATTACHMENT_NAME=')[1].indexOf('&FILESIZE=') > -1){
        return atturl.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[0]||''
    }else{
        return atturl.split('&ATTACHMENT_NAME=')[1];
    }
}
/********转换富文本编译器保存的html文本****************/
function UEhtmlEscape(s) {
    return s.replace(/'/g, '&#039;')
        .replace(/"/g, '&quot;')
        .replace(/\n/g, '<br />');
}
/****************结束*******************************/
function changeNumMoneyToChinese(money) {
    var cnNums = new Array("零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖"); //汉字的数字
    var cnIntRadice = new Array("", "拾", "佰", "仟"); //基本单位
    var cnIntUnits = new Array("", "万", "亿", "兆"); //对应整数部分扩展单位
    var cnDecUnits = new Array("角", "分", "毫", "厘"); //对应小数部分单位
    var cnInteger = "整"; //整数金额时后面跟的字符
    var cnIntLast = "元"; //整型完以后的单位
    var maxNum = 999999999999999.9999; //最大处理的数字
    var IntegerNum; //金额整数部分
    var DecimalNum; //金额小数部分
    var ChineseStr = ""; //输出的中文金额字符串
    var parts; //分离金额后用的数组，预定义
    var Symbol="";//正负值标记
    if (money == "") {
        return "";
    }

    money = parseFloat(money);
    if (money >= maxNum) {
        alert('超出最大处理数字');
        return "";
    }
    if (money == 0) {
        ChineseStr = cnNums[0] + cnIntLast + cnInteger;
        return ChineseStr;
    }
    if(money<0)
    {
        money=-money;
        Symbol="负 ";
    }
    money = money.toString(); //转换为字符串
    if (money.indexOf(".") == -1) {
        IntegerNum = money;
        DecimalNum = '';
    } else {
        parts = money.split(".");
        IntegerNum = parts[0];
        DecimalNum = parts[1].substr(0, 4);
    }
    if (parseInt(IntegerNum, 10) > 0) { //获取整型部分转换
        var zeroCount = 0;
        var IntLen = IntegerNum.length;
        for (var i = 0; i < IntLen; i++) {
            var n = IntegerNum.substr(i, 1);
            var p = IntLen - i - 1;
            var q = p / 4;
            var m = p % 4;
            if (n == "0") {
                zeroCount++;
            }
            else {
                if (zeroCount > 0) {
                    ChineseStr += cnNums[0];
                }
                zeroCount = 0; //归零
                ChineseStr += cnNums[parseInt(n)] + cnIntRadice[m];
            }
            if (m == 0 && zeroCount < 4) {
                ChineseStr += cnIntUnits[q];
            }
        }
        ChineseStr += cnIntLast;
        //整型部分处理完毕
    }
    if (DecimalNum != '') { //小数部分
        var decLen = DecimalNum.length;
        for (var i = 0; i < decLen; i++) {
            var n = DecimalNum.substr(i, 1);
            if (n != '0') {
                ChineseStr += cnNums[Number(n)] + cnDecUnits[i];
            }
        }
    }
    if (ChineseStr == '') {
        ChineseStr += cnNums[0] + cnIntLast + cnInteger;
    } else if (DecimalNum == '') {
        ChineseStr += cnInteger;
    }
    ChineseStr = Symbol +ChineseStr;

    return ChineseStr;
}

/*********处理计算控件DAY、RMB、MOD、THS计算公式的函数*****************/
function specialCalFor(calculationValue, prec){
    var vv = '';
    if(calculationValue.indexOf('--') > -1){
        // 处理计算公式里面有负数并且存在-负数的情况，不处理会导致计算逻辑受到影响
        calculationValue = calculationValue.replace(/\--/g, "+");
    }
    if(calculationValue.indexOf('+-') > -1){
        // 处理计算公式里面有负数并且存在+负数的情况
        calculationValue = calculationValue.replace(/\+-/g, "-");
    }
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

    }else if(calculationValue.indexOf('RMB') > -1){
        vv = execC(calculationValue.replace('RMB', ''), prec)
        vv = changeNumMoneyToChinese(vv);
    }else if(calculationValue.indexOf('MOD') > -1){
        vv = calculationValue.replace('MOD', '');
        var prev = vv.split(',')[0].split('(')[2];
        var next = vv.split(',')[1].split(')')[0];
        vv = parseFloat(prev) % parseFloat(next);
    }else if(calculationValue.indexOf('THS') > -1){
        vv = calculationValue.replace('THS', '');
        vv = execC(vv, prec).replace(/(\d{1,3})(?=(\d{3})+(?:$|\.))/g, '$1,');
    }else{
        vv = execC(calculationValue, prec)
    }
    if(vv != vv){
        vv = execC('0', prec);
    }
    return vv
}
/*********移动端分组组容器收起、展开*****************/
function toggleExtension(el){
    //拿到容器
    var container = $(el).parents('.mbui_cells_group').prev();
    //拿到地址
    var src = el.src;

    if(/xiala/.test(src)){
        $(el).parents('.thead').next().find('tr').show()
        el.src = "/img/workflow/form/mobile/shouqi.png";
    } else {
        $(el).parents('.thead').next().find('tr').hide()
        el.src = "/img/workflow/form/mobile/xiala.png";
    }

}
// 含有列表控件的计算公式计算逻辑
function getListCalcValue(calculationValue, _thisName){
    // 计算公式中含有获取列表控件第几列合计值的情况
    try {
        var returnStr = '';
        var splitArr = calculationValue.split('LIST('+ _thisName +',');
        if(splitArr.length == 1){
            // 计算公式含有其他控件值改变的情况，将_thisName重新赋值列表控件的名称
            _thisName = calculationValue.split('LIST(')[1].split(',')[0];
            splitArr = calculationValue.split('LIST('+ _thisName +',');
        }
        returnStr += splitArr[0];
        for(var i = 1; i < splitArr.length; i++){
            var thisNum = splitArr[i].split(')')[0];
            if($('table[title='+ _thisName +']').find('.total_'+ thisNum).length == 0){
                // 计算公式包含列表控件的列未设置合计
                var tableNum = 0;
                for(var h = 1; h < $('table[title='+ _thisName +'] tr').length - 2 ; h++){
                    var thisElement = $('table[title='+ _thisName +'] tr').eq(h).find('td').eq(parseFloat(thisNum) + 1);
                    if(thisElement.find('input').length > 0){
                        // 判断这一列是否是input类型
                        tableNum += parseFloat(thisElement.find('input').val());
                    }else if(thisElement.find('textarea').length > 0){
                        // 判断这一列是否是textarea类型
                        tableNum += parseFloat(thisElement.find('textarea').val());
                    }else{
                        tableNum += parseFloat(thisElement.text());
                    }
                }
                returnStr += tableNum;
            }else{
                if($('table[title='+ _thisName +']').find('.total_'+ thisNum).text() != ''){
                    returnStr += $('table[title='+ _thisName +']').find('.total_'+ thisNum).text();
                }else{
                    returnStr += 0;
                }
            }

            for(var j = 1; j < splitArr[i].split(')').length; j++){
                if(j == splitArr[i].split(')').length - 1){
                    returnStr += splitArr[i].split(')')[j]
                }else{
                    returnStr += splitArr[i].split(')')[j] + ')'
                }
            }
        }
        calculationValue = returnStr;
        if(calculationValue.indexOf('LIST(') > -1){
            _thisName = calculationValue.split('LIST(')[1].split(')')[0];
            calculationValue = getListCalcValue(calculationValue, _thisName)
        }
    }catch(e){
        console.log(e)
    }
    return calculationValue;
}