// 引入md5.min.js
var md5Script = document.createElement("script");
md5Script.setAttribute("type", "text/javascript");
md5Script.setAttribute("src", "/lib/md5/md5.min.js");
document.body.insertBefore(md5Script, document.body.lastChild);

var KingDeeConfig = null;
var linkKey = '';
var userKey = '';
var reimburseId
var subpaymentId
var reimburseType

var tipsIndex = null;
$(document).on('click', '.invoices_box', function () {
    var $eles = $(this).find('span');
    var str = '';
    $eles.each(function () {
        var fid = $(this).attr('fid');
        var invoiceNo = $(this).text().replace(/,$/, '');
        str += '<p class="tips_p invoice_item" fid="' + fid + '">' + invoiceNo + '</p>'
    });

    tipsIndex = layer.tips('<div class="tips_module"><div class="tips_content">' + str + '</div></div>', this, {
        tips: [1, '#3595CC'],
        time: 0
    });
    return false
})
$(document).on('mouseleave', '.tips_module', function () {
    layer.close(tipsIndex)
}).on('click', function () {
    layer.close(tipsIndex)
})

// 查看发票
$(document).on('click', '.invoice_item ', function () {
    var serialNo = $(this).attr('fid');
    //兼容其他页面查看发票时获取数据失败
    var reimburseNo = $('input[name="reimburseNo"]', $('#baseForm')).val() || $('input[name="subpaymentNo"]', $('#baseForm')).val()
    try {
        reimburseId = reimburseId || subpaymentId;
        reimburseType = reimburseType || ''
    } catch (e) {
        reimburseId = ''
        reimburseType = ''
    }
    if (!userKey) {
        getUserKey(reimburseId, reimburseNo, reimburseType, function () {
            layer.open({
                type: 2,
                title: '查看发票',
                content: KingDeeConfig.basePath + '/m4-web/fpzs/expense/showInvoice?userKey=' + userKey + '&serialNo=' + serialNo,
                area: ['100%', '100%']
            });
        })
    } else {
        layer.open({
            type: 2,
            title: '查看发票',
            content: KingDeeConfig.basePath + '/m4-web/fpzs/expense/showInvoice?userKey=' + userKey + '&serialNo=' + serialNo,
            area: ['100%', '100%']
        });
    }
    layer.close(tipsIndex)
});

// initKingDee()

/**
 * 初始化金蝶配置，获取linkKey
 */
function initKingDee(userId) {
    // 获取金蝶票据参数配置
    $.get('/kingdeeUtil/getSysConfig',{userId:userId}, function (res) {
        var data = res.data;
        KingDeeConfig = {
            basePath: data.para1,
            env: data.para2,
            client_id: data.para3,
            client_secret: data.para4,
            tin: data.para5, // 企业税号
            ghf_mc: data.para6, // 企业名称
            eid: data.para7, // 接入企业用户ID
            encrypt_key: data.para8,
            ticketParam: data.para9 // 发票验证规则
        }

        getLinkKey(function (res) {
            linkKey = res.data;
        });
    });
}

/**
 * 获取linkKey
 * @param callback
 */
function getLinkKey(callback) {
    var url = KingDeeConfig.basePath + '/m4/fpzs/getLinkKey';
    sendKingDeePost(url, '', function(res){
        if (callback) {
            callback(res);
        }
    })
}

/**
 * 获取userKey
 * @param reimburseId (报销单id)
 * @param reimburseNo (报销单编号)
 * @param reimburseType (报销单类型)
 * @param callback
 */
function getUserKey(reimburseId, reimburseNo, reimburseType, callback) {
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
        billNumber: reimburseNo,
        bxd_key: reimburseId,
        random: randomNum(1, 100),
        ticketParam: KingDeeConfig.ticketParam,
        billType: billType
    })

    var getUserKeyUrl = KingDeeConfig.basePath + '/m4/fpzs/getUserKey';

    sendKingDeePost(getUserKeyUrl, getUserKeyData, function (res) {
        if (res.errcode === '0000') {
            userKey = res.data.userKey;
        } else {
            layer.msg('获取数据失败！', {icon: 2});
        }
        if (callback) {
            callback(res);
        }
    });
}

/**
 * 打开金蝶选择发票界面
 * @param reimburseId (报销单id)
 * @param reimburseNo (报销单编号)
 * @param reimburseType (报销单类型)
 * @param $ele
 */
function openPwyWeb(reimburseId, reimburseNo, reimburseType, $ele, callback) {
    if (!userKey) {
        getUserKey(reimburseId, reimburseNo, reimburseType, function(res) {
            if (res.errcode === '0000') {
                initPwyWebSocket(reimburseId, reimburseNo, reimburseType, $ele, callback)
            }
        })
    } else {
        initPwyWebSocket(reimburseId, reimburseNo, reimburseType, $ele, callback)
    }
}

/**
 * 金蝶选择发票
 * @param reimburseType (报销单编号)
 * @param $ele (点击节点)
 */
function initPwyWebSocket(reimburseId, reimburseNo, reimburseType, $ele, callback) {
    var loadIndex = layer.load()
    var timestamp = new Date().getTime();
    var pwyWebsocketObj = new PwyWebSocket({
        env: KingDeeConfig.env, //正式环境: prod, 测试环境: test
        tin: KingDeeConfig.tin,   ///tin为获取userKey时的税号
        eid: KingDeeConfig.eid,   //eid为获取userKey时的用户eid
        client_id: KingDeeConfig.client_id, // 发票云分配的client_id
        sign: md5(KingDeeConfig.client_id + KingDeeConfig.client_secret + timestamp), // 签名规则：MD5(client_id + client_secret + timestamp)
        timestamp: timestamp,    // 签名时的时间戳
        name: linkKey, // 连接名称，选择发票前获取的linkKey
        sourceType: 'socket', // 默认socekt, 对于不支持socket的端请设置为polling，java端的轮询参考5
        onOpen: function () { // 连接成功的回调
            layer.close(loadIndex)
            layerIndex = layer.open({
                type: 2,
                area: ['800px', '500px'],
                content: KingDeeConfig.basePath + '/m4-web/fpzs/index?userKey=' + userKey + '&linkKey=' + linkKey + '&gridParam=1100&sourceType=socket'
            })
        },
        onMessage: function (msg) {
            console.log(msg);
            var invoiceSerialNos = msg.data.invoiceSerialNos

            if (invoiceSerialNos) {
                var fIds = invoiceSerialNos.split(',');
                var loadIndex = layer.load()
                cacheKingDee(reimburseId, reimburseNo, reimburseType, fIds, function () {
                    getKingDeeFile(invoiceSerialNos, function(res) {
                        console.log(res);
                        var invoiceObj = {}
                        var newList = [];
                        var invoiceEleStr = '';

                        res.data.forEach(function (item, index) {
                            invoiceObj[item.serialNo] = JSON.stringify(item);
                            if ($('.' + item.serialNo).length == 0) {
                                invoiceEleStr += '<span class="invoice_file ' + item.serialNo + '" fid="' + item.serialNo + '">' + (item.invoiceNo || ('发票' + (index + 1))) + ',</span>';
                                newList.push(item);
                            }
                        });
                        var _flag=false
                        newList.forEach(function(index){
                            if (index.totalAmount=='0'){
                                _flag=true
                            }
                        })
                        if(_flag){
                            layer.close(loadIndex);
                            layer.msg('价税合计不能为0！', {icon: 2,time:1000});
                            pwyWebsocketObj.close();
                            pwyWebsocketObj = null;
                            layer.close(layerIndex);
                            return
                        }
                        if ($ele) {
                            $ele.empty();
                            $ele.html(invoiceEleStr);
                        }

                        // 保存金蝶发票数据
                        $.ajax({
                            url: '/plbDeptReimburse/addInvoiceInfo',
                            data: JSON.stringify({invoiceList: invoiceObj}),
                            dataType: 'json',
                            contentType: "application/json;charset=UTF-8",
                            type: 'post',
                            success: function (res) {

                            }
                        });

                        layer.close(loadIndex);
                        layer.msg('发票导入成功！', {icon: 1});
                        // 关闭连接, 接受到消息之后需要先关闭连接，需要再次使用需要重新创建socket对象
                        pwyWebsocketObj.close();
                        pwyWebsocketObj = null;
                        layer.close(layerIndex);

                        if (callback) {
                            callback(newList);
                        }
                    })
                });
            }
        },
        onError: function (errText, errCode) { //失败时的回调
            layer.msg('发票导入失败！', {icon: 2});
        }
    });
}

/**
 * 同步单据与发票关系
 * @param reimburseId 报销单id
 * @param reimburseNo 报销单编号
 * @param reimburseType 报销单类型
 * @param fIds ['流水号'] 发票流水号, 数组格式
 */
function cacheKingDee(reimburseId, reimburseNo, reimburseType, fIds, callback) {
    var timestamp = new Date().getTime();

    var billTypeId = '';
    if (reimburseType == '01' || reimburseType == '02') {
        // 差旅报销单、休假报销单
        billTypeId = 'Tra';
    } else if (reimburseType == '05') {
        // 对公费用报销单
        billTypeId = 'BizOut';
    }

    var cacheData = {
        userKey: userKey,
        eid: KingDeeConfig.eid,
        billTypeId: billTypeId,
        billnumber: reimburseNo,
        bxd_key: reimburseId,
        client_id: KingDeeConfig.client_id,
        tin: KingDeeConfig.tin,
        timestamp: timestamp,
        sign: md5(KingDeeConfig.client_id + KingDeeConfig.client_secret + timestamp),
        data: [{
            entryid: '',
            fid: fIds
        }]
    }

    var url = KingDeeConfig.basePath + '/m4/fpzs/expense/entry/cache';

    sendKingDeePost(url, JSON.stringify(cacheData), function (res) {
        if (callback) {
            callback(res)
        }
    })
}

/**
 * 保存单据
 * @param reimburseId 报销单id
 * @param reimburseNo 报销单编号
 * @param reimburseType 报销单类型
 * @param fIds ['流水号'] 发票流水号, 数组格式
 */
function saveKingDee (reimburseId, reimburseNo, reimburseType, fIds, callback)  {
    var timestamp = new Date().getTime();

    var billTypeId = '';
    if (reimburseType == '01' || reimburseType == '02') {
        // 差旅报销单、休假报销单
        billTypeId = 'Tra';
    } else if (reimburseType == '05') {
        // 对公费用报销单
        billTypeId = 'BizOut';
    }

    var saveData = {
        userKey: userKey,
        eid: KingDeeConfig.eid,
        billTypeId: billTypeId,
        billnumber: reimburseNo,
        bxd_key: reimburseId,
        client_id: KingDeeConfig.client_id,
        tin: KingDeeConfig.tin,
        timestamp: timestamp,
        sign: md5(KingDeeConfig.client_id + KingDeeConfig.client_secret + timestamp),
        data: [{
            entryid: '', // 单据的分录id，如果没有分录功能(可以传空)
            costTypeId: '', // 费用类型id(如获取不到可以为空)
            costTypeName: '', // 费用类型名称（如获取不到可以为空）
            fid: fIds
        }]
    }

    var url = KingDeeConfig.basePath + '/m4/fpzs/expense/entry/save';

    sendKingDeePost(url, JSON.stringify(saveData), function (res) {
        updateKingDee(reimburseId, reimburseNo, reimburseType, function (res) {
            if (callback) {
                callback(res)
            }
        });
    })
}

/**
 * 提交发票
 * @param reimburseId 报销单id
 * @param reimburseNo 报销单编号
 * @param reimburseType 报销单类型
 */
function submitKingDee(reimburseId, reimburseNo, reimburseType, callback) {
    var fIds = []
    $('.invoice_file').each(function(){
        var fId = $(this).attr('fid') || '';
        if (fId) {
            fIds.push(fId);
        }
    });
    if (!userKey) {
        getUserKey(reimburseId, reimburseNo, reimburseType, function(res) {
            if (res.errcode === '0000') {
                saveKingDee(reimburseId, reimburseNo, reimburseType, fIds, function(res) {
                    if (callback) {
                        callback(res)
                    }
                })
            } else {
                if (callback) {
                    callback(false)
                }
            }
        })
    } else {
        saveKingDee(reimburseId, reimburseNo, reimburseType, fIds, function(res) {
            if (callback) {
                callback(res)
            }
        })
    }
}

/**
 * 更新发票状态
 * @param reimburseId 报销单id
 * @param reimburseNo 报销单编号
 * @param reimburseType 报销单类型
 */
function updateKingDee(reimburseId, reimburseNo, reimburseType, callback) {
    var timestamp = new Date().getTime();

    var billTypeId = '';
    if (reimburseType == '01' || reimburseType == '02') {
        // 差旅报销单、休假报销单
        billTypeId = 'Tra';
    } else if (reimburseType == '05') {
        // 对公费用报销单
        billTypeId = 'BizOut';
    }

    var saveData = {
        userKey: userKey,
        timestamp: timestamp,
        tin: KingDeeConfig.tin,
        sign: md5(KingDeeConfig.client_id + KingDeeConfig.client_secret + timestamp),
        client_id: KingDeeConfig.client_id,
        expenseStatus: '30',
        ticketParam: KingDeeConfig.ticketParam,
        billnumber: reimburseNo,
        bxd_key: reimburseId,
        eid: KingDeeConfig.eid,
        billTypeId: billTypeId
    }

    var url = KingDeeConfig.basePath + '/m4/fpzs/expense/invoice/status/update';

    sendKingDeePost(url, JSON.stringify(saveData), function (res) {
        if (callback) {
            callback(res)
        }
    })
}

/**
 * 获取发票详情
 * @param fid 逗号分隔的发票流水号
 * @param callback
 */
function getKingDeeFile(fid, callback) {
    var timestamp = new Date().getTime();
    var queryData = {
        userKey: userKey, //打开首页时获取的userKey（可以为空）
        timestamp: timestamp,
        sign: md5(KingDeeConfig.client_id + KingDeeConfig.client_secret + timestamp),
        client_id: KingDeeConfig.client_id,
        fid: fid
    }

    var url = KingDeeConfig.basePath + '/m4/fpzs/expense/invoice/detail/query';

    sendKingDeePost(url, JSON.stringify(queryData), function (res) {
        if (callback) {
            callback(res)
        }
    })
}

/**
 * 发送金蝶请求(前台跨域，需用后台服务器转发)
 * @param url (金蝶请求地址)
 * @param data (金蝶请求参数)
 * @param callback
 */
function sendKingDeePost(url, data, callback) {
    $.post('/kingdeeUtil/sendPost', {url: url, data: data}, function (res) {
        if (callback) {
            if (res.flag) {
                callback(res.data);
            } else {
                callback(false);
            }
        }
    });
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
 * 生成UUID
 */
function generateUUID() {
    var d = new Date().getTime();
    if (window.performance && typeof window.performance.now === "function") {
        d += performance.now();
    }
    var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
        var r = (d + Math.random() * 16) % 16 | 0;
        d = Math.floor(d / 16);
        return (c == 'x' ? r : (r & 0x3 | 0x8)).toString(16)
    });
    return uuid;
}
/**
 *删除发票分录
 */
 function deleteInvoice(reimburseType,reimburseInfo){
    var timestamp = new Date().getTime();
    var billTypeId = '';
    if (reimburseType == '01' || reimburseType == '03') {
        // 差旅报销单、休假报销单
        billTypeId = 'Tra';
    } else if (reimburseType == '05') {
        // 对公费用报销单
        billTypeId = 'BizOut';
    }
    var getDelData=JSON.stringify({
        userKey:userKey,
        eid:KingDeeConfig.eid,
        billTypeId:billTypeId,
        billnumber:reimburseInfo.reimburseNo,
        branch_id:reimburseInfo.reimburseId,
        bxd_key:reimburseInfo.reimburseId,
        client_id:KingDeeConfig.client_id,
        tin:KingDeeConfig.tin,
        timestamp:timestamp,
        sign: md5(KingDeeConfig.client_id + KingDeeConfig.client_secret + timestamp),
        ticketParam:KingDeeConfig.ticketParam,

    })
    var url = KingDeeConfig.basePath + '/m4/fpzs/expense/invoice/del/entry';
    sendKingDeePost(url,getDelData , function (res) {

    })

}