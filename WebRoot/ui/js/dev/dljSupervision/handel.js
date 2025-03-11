/**
 * Created by gaosubo-sheji on 2017/8/2.
 */
$(function () {
    //所属分类
    $.fn.typeDljSelect = function (args) {
        var _this = $(this);
        $.ajax({
            url: "/dljSupervisionType/getSupNameSelect",
            type: 'get',
            data: {},
            dataType: 'json',
            async:false,
            success: function (obj) {
                var data = obj.obj;
                typementData = typeDigui(data, 0);
                var str = typetmentChild(typementData, '<option value="-1">' + select_the_category + '</option>', 0, -1);
                _this.html(str);

                if (args != undefined) {
                    args(_this)
                }
            },
            error: function () {

            }
        });
    };
    //获取地址栏参数
    var sId = $.getQueryString('sid');//主键自增id
    var TYPE = $.getQueryString('type');//0点击办理，1点击查看
    var status = $.getQueryString('status');//督办状态，0未发布，1待签收，2正常办理中，3逾期办理中，4已暂停，5正常已办结，6逾期已办结
    var paId = $.getQueryString('paId');//父级任务id
    var bodyId = $.getQueryString('bodyId');//不知道是啥
    // console.log(sId,TYPE,status,paId,bodyId)
    var data;
    if (bodyId != undefined) {
        data = {
            sid: sId,
            bodyId: bodyId
        }
    } else {
        data = {
            sid: sId
        }
    }
    detailsInit(data)
    if (TYPE == '0') { //督办管理-办理

    } else if (TYPE == '1') {//督办任务-处理中-办理

    } else if (TYPE == '2') {//督办任务-查看

    }
    //?????????这是啥
    if (paId == 0) {
        $('.newAdd').hide();
    } else {
        $('.newAdd').show();
    }

//


    function detailsInit(data) {
        $.ajax({
            type: 'get',
            url: '/dljSupervision/getSupAssistDetail',
            dataType: 'json',
            data: data,
            success: function (res) {
                var data = res.object;
                if (data.targetScore == undefined) {
                    $('#viewTargetScore').attr('targetScore', data.targetScore)
                    // console.log(data);
                }
                if (status != '5' && status != '6' && status != '4') {
                    $('.operationBtn').show();
                    if (data.count0 == 1 && data.status != '3') {
                        $('.throung').show();  //办结
                        $('.suspend').show();  //暂停
                    }
                    if (data.count2 == 1) {
                        $('.throung').show();  //办结
                        $('.suspend').show();  //暂停
                    }

                    //改为所有人都可以反馈
                    $('.feedback').show(); //反馈
                    /*if(data.count0 == 1 || data.count2 == 1 || data.count1 == 1){
                        $('.feedback').show(); //反馈
                    }*/

                    if (data.count2 == 1 || data.count3 == 1 || data.count0 == 1) {
                        $('.reminders').show();  //催办
                    }

                    if (data.count2 == 1) {
                        $('.newAdd').show();  //子任务

                    }
                } else if (status == 4 && data.count0 == 1) {
                    $('.replayD').show();
                }
                if (TYPE == 0) {
                    $('.operationBtn').show();
                } else {
                    $('.operationBtn').hide();
                }

                $('.supName').text('');
                $('.manageUser').text('');
                $('.userName').text('');
                $('.leaderName').text('');
                $('.baginTime').text('');
                $('.endTime').text('');
                $('.workState').text('');
                $('.addUser').text('');
                $('.workTask').text('');
                $('.targetScore').text('');
                $('.superior').text('');
                $('.attment').text('');
                $('#suspend').attr('count', '');
                $('#comEnd').attr('count', '')

                $('.supName').text(data.supName);
                $('.manageUser').text(data.userName);
                $('.userName').text(data.managerName);
                $('.leaderName').text(data.userPrivName);
                $('.baginTime').text(data.beginTime);
                $('.endTime').text(data.endTime);
                $('.workState').text(data.content);
                $('.addUser').text(data.createrId);
                $('.workTask').text(data.content);
                $('.targetScore').text(data.targetScore);
                var str = '';
                if(data.guideGoalBack != undefined){
                    str = '<div class="layui-progress" style="width: 10%">\n' +
                        '  <div class="layui-progress-bar layui-bg-red layui-bg-blue" lay-percent="' + data.guideGoalBack.progressRate + '%" style="width: ' + data.guideGoalBack.progressRate + '%;position:relative" ></div><span style="position:absolute;right:-38px;top:-17px">'+data.guideGoalBack.progressRate+'%</span>\n' +
                        '</div>'
                }else{
                    str = '<div class="layui-progress" style="width: 10%">\n' +
                        '  <div class="layui-progress-bar layui-bg-red layui-bg-blue" lay-percent="0%" style="width:0%;position:relative" ></div><span style="position:absolute;right:-38px;top:-17px">0%</span>\n' +
                        '</div>'
                }

                $('.progressRate').html(str);
                $('#suspend').attr('count', data.count2);
                $('#comEnd').attr('count', data.count2)
                var str = '';
                if (data.attachmentList.length > 0) {
                    for (var i = 0; i < data.attachmentList.length; i++) {
                        str += '<div><a href="/download?' + encodeURI(data.attachmentList[i].attUrl) + '">' + data.attachmentList[i].attachName + '</a></div>'
                    }
                    $('.attment').html(str);
                }
                $.ajax({
                    type: 'get',
                    url: '/dljSupApply/getSupApplyByStatus',
                    dataType: 'json',
                    data: {supId: sId, type: 3},
                    success: function (res) {
                        var obj = res.obj
                        if (!obj) {
                            return false
                        }
                        for (var i = 0; i < obj.length; i++) {
                            if (obj[i].status != 2) {
                                $('.throung').hide();
                                $('.suspend').hide();
                            }
                            // else if(obj[i].status == "2"){
                            //     $('.throung').show();
                            // }
                        }
                    }
                })
                $.ajax({
                    type: 'get',
                    url: '/dljSupApply/getSupApplyByStatus',
                    dataType: 'json',
                    data: {supId: sId, type: 1},
                    success: function (res) {
                        var obj = res.obj
                        if (!obj) {
                            return false
                        }
                        for (var i = 0; i < obj.length; i++) {
                            if (obj[i].status == "0") {
                                $('.suspend').hide();
                                $('.throung').hide();
                            }
                            // else if(obj[i].status == "2"){
                            //     $('.throung').show();
                            // }
                        }
                    }
                })
                /*$('.superior').text();
                $('.attment').text();*/
            }
        })
    }
})
