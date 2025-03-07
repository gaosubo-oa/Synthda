/**
 * @author 戎成路
 * @description 预算管理公共js
 */

// 引入bignumber.js 处理数字运算
var secScript = document.createElement("script");
secScript.setAttribute("type", "text/javascript");
secScript.setAttribute("src", "/js/planbudget/bignumber.min.js");
document.head.insertBefore(secScript, document.head.lastChild);

/**
 * 表格类
 * @type {(function(*=): tableUI)|*}
 */
var TableUI = (function () {
    //静态私有属性方法
    function initCols(colsObj, showFieldsArr) {
        var colsObjCopy = deepClone(colsObj);
        var newCols = [];

        if (showFieldsArr.length > 0) {
            showFieldsArr.forEach(function (item) {
                if (colsObjCopy[item.showFields]) {
                    colsObjCopy[item.showFields]['hide'] = item.isShow;
                    newCols.push(colsObjCopy[item.showFields]);
                    delete colsObjCopy[item.showFields]
                }
            });

            for (var k in colsObjCopy) {
                if (colsObjCopy[k]) {
                    newCols.push(colsObjCopy[k]);
                }
            }
        } else {
            for (var k in colsObjCopy) {
                if (colsObjCopy[k]) {
                    newCols.push(colsObjCopy[k]);
                }
            }
        }

        return newCols;
    }

    /**
     * 构造函数
     * @param tableName (表名)
     * @param colsObj (列表对象)
     * @returns {tableUI} (表格对象)
     */
    function tableUI(tableName) {
        var _this = this;

        // 构造函数安全模式，避免创建时候丢掉new关键字
        if (_this instanceof tableUI) {
            // 共有属性, 方法
            _this.tableName = tableName;
        } else {
            return new tableUI(tableName);
        }
    }

    // 静态共有属性方法
    tableUI.prototype = {
        constructor: tableUI,
        /**
         * 加载列表
         * @param colsObj
         * @param callbalk (回调函数-{
         *     orderbyFields: 排序字段名,
         *     orderbyUpdown: 排序类型,
         *     cols: 列表显示,
         *     onePageRecoeds: 列表分页条数
         * })
         */
        init: function (colsObj, callbalk) {
            var _this = this;

            _this.colsObj = colsObj;
            _this.orderbyFields = '';
            _this.orderbyUpdown = '';
            _this.onePageRecoeds = 10;
            _this.cols = [];

            // 获取表格信息
            $.get('/plbListUi/getUilistByTableName', {tableName: _this.tableName}, function (res) {
                var showFieldsArr = [];
                if (res.flag) {
                    if (!!res.object) {
                        _this.showFields = res.object.showFields || '';
                        _this.orderbyFields = res.object.orderbyFields || '';
                        _this.orderbyUpdown = res.object.orderbyUpdown || '';
                        _this.onePageRecoeds = res.object.onePageRecoeds || 10;
                        showFieldsArr = !!res.object.showFields ? JSON.parse(res.object.showFields) : [];
                    }
                }
                _this.cols = initCols(_this.colsObj, showFieldsArr);
                if (callbalk) {
                    var obj = {
                        orderbyFields: _this.orderbyFields,
                        orderbyUpdown: _this.orderbyUpdown,
                        cols: _this.cols,
                        onePageRecoeds: _this.onePageRecoeds
                    }
                    callbalk(obj);
                }
            })
        },
        /**
         * 更新列表信息
         * @param params {orderbyFields: 排序字段名, orderbyUpdown: 排序类型, showFields: 列表显示, onePageRecoeds: 列表分页条数}
         * @param callback
         */
        update: function (params, callback) {
            var _this = this;
            if (params) {
                params.tableName = _this.tableName;
                $.get('/plbListUi/updateListUi', params, function (res) {
                    if (res.flag) {
                        $.each(params, function (k, o) {
                            _this[k] = o;
                            // 如果修改(列表显示)，则同步更新cols
                            if (k == 'showFields') {
                                var showFieldsArr = !!o ? JSON.parse(o) : [];
                                _this.cols = initCols(_this.colsObj, showFieldsArr);
                            }
                        })
                    }
                    if (callback) {
                        callback(res);
                    }
                })
            }
        },
        /**
         * 拖拽保存信息
         * @param el (拖拽的表格id)
         * @param callback
         */
        dragTable: function (el, callback) {
            var arr = [];
            $('#' + el).next().find('thead th').each(function () {
                if ($(this).attr('data-field') != '0') {
                    var obj = {showFields: $(this).attr('data-field')}
                    if ($(this).hasClass('layui-hide')) {
                        obj.isShow = true;
                    } else {
                        obj.isShow = false;
                    }
                    arr.push(obj);
                }
            })
            var param = {showFields: JSON.stringify(arr)}

            this.update(param, function (res) {
                if (callback) {
                    callback(res);
                }
            })
        },
        /**
         * 重新加载列
         */
        reloadCols: function (colsObj) {
            this.colsObj = colsObj;
            var showFieldsArr = !!this.showFields ? JSON.parse(this.showFields) : [];
            this.cols = initCols(colsObj, showFieldsArr);
        }
    }

    return tableUI;
})();

/**
 * 将字段转换成大写
 * @param field (需要转换的字符串)
 * @returns {string} (转换后的字符串)
 */
function upperFieldMatch(field) {
    // 将字符串分割成相应的字符串数组
    var stringArray = field.split('')
    // 定义新字符串
    var newField = ''
    // 遍历新字符串数组，将找到的大写字母替换成(_加大写字母)，将小写字母替换成大写字母
    for (var i = 0; i < stringArray.length; i++) {
        var str = stringArray[i]
        if (/[A-Z]/.test(str)) {
            newField += '_' + str.toUpperCase();
        } else {
            newField += str.toUpperCase();
        }
    }
    return newField;
}

/**
 * 将毫秒数转为yyyy-MM-dd格式时间
 * @param t
 * @returns {string|*}
 */
function format(t) {
    if (t) {
        return new Date(t).Format("yyyy-MM-dd");
    } else {
        return '';
    }
}

/**
 * 判断是否显示空
 * @param data
 */
function isShowNull(data) {
    if (!!data) {
        return data;
    } else {
        return '';
    }
}

/**
 * 数值转换为千分位用逗号分隔
 */
function numFormat(num) {
    num = parseInt(num)
    var numStr = '';
    if (!isNaN(num)) {
        num = num.toString().split(".");  // 分隔小数点
        var arr = num[0].split("").reverse();  // 转换成字符数组并且倒序排列
        var res = [];
        for (var i = 0, len = arr.length; i < len; i++) {
            if (i % 3 === 0 && i !== 0) {
                res.push(",");   // 添加分隔符
            }
            res.push(arr[i]);
        }
        res.reverse(); // 再次倒序成为正确的顺序
        if (num[1]) {  // 如果有小数的话添加小数部分
            numStr = res.join("").concat("." + num[1]);
        } else {
            numStr = res.join("");
        }
    }
    return numStr;
}

/**
 * 设置本地存储
 * @param key (键)
 * @param value (值)
 * @param salt (前缀)
 */
function setLocalStorage(key, value, salt) {
    localStorage.setItem(salt + key, value);
}

/**
 * 获取本地存储
 * @param key (键)
 * @param salt (前缀)
 * @returns {string | string}
 */
function getLocalStorage(key, salt) {
    var value = localStorage.getItem(salt + key) || '';
    return value;
}

/**
 * 移除本地存储
 * @param key (键)
 * @param salt (前缀)
 */
function removeLocalStorage(key, salt) {
    localStorage.removeItem(salt + key);
}

/**
 * 深拷贝方法
 * @param obj (需要拷贝的对象)
 * @returns {*[]}
 */
function deepClone(obj) {
    var o = obj instanceof Array ? [] : {};
    for (var k in obj) {
        //有bug（属性的值为null时）
        //o[k] = typeof obj[k] === 'object'?deepClone(obj[k]):obj[k];
        if (typeof obj[k] === 'object' && obj[k] != undefined) {
            o[k] = deepClone(obj[k]);
        } else if (typeof obj[k] === 'object' && obj[k] == undefined) {
            o[k] = null;
        } else {
            o[k] = obj[k];
        }
    }
    return o;
}

/**
 * 保留小数点后n位
 * @param num (数字)
 * @param n (小数点后几位，默认两位)
 */
function keepTwoDecimalFull(num, n) {
    var result = parseFloat(num);
    if (isNaN(result)) {
        num = 0;
    }
    if (isNaN(n) || !n || n <= 0) {
        n = 2;
    }
    var count = Math.pow(10, n);
    result = Math.round(num * count) / count;
    var s_x = result.toString();
    var pos_decimal = s_x.indexOf('.');
    if (pos_decimal < 0) {
        pos_decimal = s_x.length;
        s_x += '.';
    }
    while (s_x.length <= pos_decimal + n) {
        s_x += '0';
    }
    return s_x;
}

/**
 * 获取自动排序号接口
 * @param params (参数{sotrNumber: 数据库表名, reimburseType: 报销单类型})
 * @param callback (回调函数)
 */
function getSortNumber(params, callback) {
    $.get('/plbProj/getSortNo', params, function (res) {
        callback(res);
    });
}

/**
 * 获取自动编号接口
 * @param params (参数{autoNumber: 数据库表名, reimburseType: 报销单类型})
 * @param callback (回调函数)
 */
function getAutoNumber(params, callback) {
    $.get('/plbUtil/autoNumber', params, function (res) {
        callback(res);
    });
}

/**
 * 根据节点 ID 查找树结构指定节点
 * @param tree 树数据
 * @param nodeId 节点id
 * @param idName id名称
 * @param children 子节点名称
 * @returns {any|null} 返回节点
 */
function searchTreeNode(tree, nodeId, idName, children) {
    var node = null;
    if (tree && tree.length > 0) {
        for (var i = 0; i < tree.length && !node; i++) {
            if (tree[i][idName] == nodeId) {
                node = tree[i];
                break;
            } else {
                if (tree[i][children] && tree[i][children].length > 0) {
                    node = searchTreeNode(tree[i][children], nodeId, idName, children);
                }
            }
        }
    }
    return node;
}

/**
 * 获取附件dom
 * @param fileList (文件数据)
 * @param isDel(是否可以删除)
 * @returns {string}
 */
function getFileEleStr(fileList, isDel) {
    var fileStr = '';
    if (fileList && fileList.length > 0) {
        var delImg = isDel ? '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' : '';
        for (var i = 0; i < fileList.length; i++) {
            var fileExtension = fileList[i].attachName.substring(fileList[i].attachName.lastIndexOf(".") + 1, fileList[i].attachName.length);//截取附件文件后缀
            var attName = encodeURI(fileList[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
            var deUrl = fileList[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileList[i].size;

            fileStr += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileList[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileList[i].attachName + '</a>' + delImg + '<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))" href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a><a style="padding-left: 5px" href="/download?' + encodeURI(deUrl) + '" ><img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileList[i].aid + '@' + fileList[i].ym + '_' + fileList[i].attachId + ',"></div>';
        }
    }
    return fileStr;
}

var linkKey = '';
var userKey = '';
/**
 * 初始化金蝶发票选择
 * @param KingDeeConfig
 * @param $ele,
 * @param reimburseNo
 */
function initKingDee(KingDeeConfig, $ele, reimburseNo) {
    var pwyWebsocketObj = null
    var layerIndex = null;
    if (!linkKey || !userKey) {
        $.ajax({
            type: 'POST',
            url: KingDeeConfig.basePath + '/m4/fpzs/getLinkKey',
            dataType: 'json',
            success: function (res) {
                linkKey = res.data;
                getUserKey(function (res) {
                    if (res) {
                        userKey = res.userKey;
                        initPwyWebSocket();
                    } else {
                        layer.msg('获取数据失败！', {icon: 2});
                    }
                });
            }
        })
    } else {
        initPwyWebSocket();
    }

    function initPwyWebSocket() {
        var timestamp = new Date().getTime();
        pwyWebsocketObj = new PwyWebSocket({
            env: KingDeeConfig.env, //正式环境: prod, 测试环境: test
            tin: KingDeeConfig.tin,   ///tin为获取userKey时的税号
            eid: KingDeeConfig.eid,   //eid为获取userKey时的用户eid
            client_id: KingDeeConfig.client_id, // 发票云分配的client_id
            sign: md5(KingDeeConfig.client_id + KingDeeConfig.client_secret + timestamp), // 签名规则：MD5(client_id + client_secret + timestamp)
            timestamp: timestamp,    // 签名时的时间戳
            name: linkKey, // 连接名称，选择发票前获取的linkKey
            sourceType: 'socket', // 默认socekt, 对于不支持socket的端请设置为polling，java端的轮询参考5
            onOpen: function () { // 连接成功的回调
                layerIndex = layer.open({
                    type: 2,
                    area: ['80%', '80%'],
                    content: KingDeeConfig.basePath + '/m4-web/fpzs/index?userKey=' + userKey + '&linkKey=' + linkKey + '&gridParam=1111&sourceType=socket'
                })
            },
            onMessage: function (msg) {
                var invoiceList = []
                if (reimburseType == '01' || reimburseType == '02') {
                    // 差旅报销单、休假报销单
                    invoiceList = msg.data.data[0].invoiceData
                } else if (reimburseType == '05') {
                    // 对公费用报销单
                    invoiceList = msg.data.data;
                } else {
                    invoiceList = msg.data.data;
                }
                invoiceList.forEach(function (item) {
                    invoiceObj[item.fid] = item;
                    $ele.append('<a fid="' + item.fid + '">' + item.invoiceNo + ',</a>');
                });

                layer.msg('发票导入成功！', {icon: 1});
                // 关闭连接, 接受到消息之后需要先关闭连接，需要再次使用需要重新创建socket对象
                pwyWebsocketObj.close();
                pwyWebsocketObj = null;
                layer.close(layerIndex);
            },
            onError: function (errText, errCode) { //失败时的回调
                layer.msg('发票导入失败！', {icon: 2});
            }
        });
    }

    function getUserKey(callback) {
        var timestamp = new Date().getTime();
        var billType = '';
        if (reimburseType == '01' || reimburseType == '02') {
            // 差旅报销单、休假报销单
            billType = 'Tra';
        } else if (reimburseType == '05') {
            // 对公费用报销单
            billType = 'BizOut';
        }
        var getUserKeyData = JSON.stringify({
            timestamp: timestamp,
            client_id: KingDeeConfig.client_id,
            tin: KingDeeConfig.tin,
            ghf_mc: KingDeeConfig.ghf_mc,
            eid: KingDeeConfig.eid,
            sign: md5(KingDeeConfig.client_id + KingDeeConfig.client_secret + timestamp),
            billNumber: '',
            bxd_key: reimburseNo,
            random: randomNum(1, 100),
            ticketParam: '1111',
            billType: billType
        })

        var getUserKeyUrl = KingDeeConfig.basePath + '/m4/fpzs/getUserKey';

        $.post('/kingdeeUtil/sendPost', {url: getUserKeyUrl, data: getUserKeyData}, function (res) {
            if (callback) {
                if (res.flag && res.data.errcode === '0000') {
                    callback(res.data.data)
                } else {
                    callback(false)
                }
            }
        })
    }
}

/**
 * 生成[min, max]的随机数
 * @param min (最小值)
 * @param max (最大值)
 */
function randomNum(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min);
}

/**
 * 处理浮点数，并保留指定位数小数(默认两位，不自动补零)
 * @param num
 * @param pointNum
 * @returns {number}
 */
function checkFloatNum(num, pointNum) {
    num = BigNumber(num);

    if (num.isNaN()) {
        return 0;
    } else {
        pointNum = parseInt(pointNum);

        if (isNaN(pointNum)) {
            pointNum = 2;
        }
        return num.decimalPlaces(pointNum).toNumber();
    }
}

//监听键盘事件，只能输入数字
$(document).on('keypress', '.input_floatNum', function (e) {
    var key = window.event ? e.keyCode : e.which;
    if (!((key > 95 && key < 106) || key == 45 || key == 46 || (key > 47 && key < 58) || key == 8 || key == 9 || key == 13 || key == 37 || key == 39)) {
        return false;
    }

    var minusFlag = $(this).attr('minusFlag');
    // 不可以输入负数
    if (minusFlag != '1' && key == 45) {
        return false;
    }

    var pointFlag = $(this).attr('pointFlag');
    // 不可以输入小数
    if (pointFlag != '1' && key == 46) {
        return false;
    }

    var val = $(this).val();
    // 如果已经含有-或. 则不能在输入-和.
    if ((key == 45 && /-/.test(val)) || (key == 46 && /\./.test(val))) {
        return false;
    }
});
// 监听输入内容
$(document).on('input propertychange', '.input_floatNum', function (event) {
    var valStr = $(this).val();
    var minusSign = '';
    var pointStr = '';
    var pointNum = 2;

    // 负号开头
    if (/^-/.test(valStr)) {
        minusSign = '-';
    }
    // 去除-
    valStr = valStr.replace(/-/g, '');

    // 整数部分
    var int = parseInt(valStr);
    // 小数部分
    var float = '';

    // 如果含有小数点
    if (/\./.test(valStr)) {
        pointStr = '.';

        var valArr = valStr.split(/\./);

        int = checkFloatNum(valArr[0]);

        float = valArr[1] ? valArr[1] : '';

        pointNum = checkFloatNum($(this).attr('pointNum')) || 2;

        if (float.length > pointNum) {
            float = float.substring(0, pointNum);
        }
    }

    if (isNaN(int)) {
        int = '';
    }

    var value = int + pointStr + float;

    if (minusSign) {
        value = minusSign + value;
    }

    $(this).val(value);

    var handleCallback = $(this).attr('handleCallback');

    if (handleCallback && typeof window[handleCallback] === 'function') {
        window[handleCallback](checkFloatNum(value, pointNum), this);
    }
});

// 删除附件
$(document).on('click', '.deImgs', function () {
    var _this = this;
    var attUrl = $(this).parents('.dech').attr('deUrl');
    layer.confirm('确定删除该附件吗？', function (index) {
        $.ajax({
            type: 'post',
            url: '/delete?' + attUrl,
            dataType: 'json',
            success: function (res) {
                if (res.flag == true) {
                    layer.msg('删除成功', {icon: 6, time: 1000});
                    $(_this).parent().remove();
                } else {
                    layer.msg('删除失败', {icon: 2, time: 1000});
                }
            }
        })
    });
});

Date.prototype.format = function(format) {
    var date = {
        "M+": this.getMonth() + 1,
        "d+": this.getDate(),
        "h+": this.getHours(),
        "m+": this.getMinutes(),
        "s+": this.getSeconds(),
        "q+": Math.floor((this.getMonth() + 3) / 3),
        "S+": this.getMilliseconds()
    };
    if (/(y+)/i.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
    }
    for (var k in date) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1
                ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
        }
    }
    return format;
}