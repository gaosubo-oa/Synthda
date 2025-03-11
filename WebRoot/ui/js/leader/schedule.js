/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var schedule = {
    exportUrl: '',
    init: function() {
        schedule.switchWeek();
        schedule.printUrl = printUrl;
        schedule.exportUrl = exportUrl;
        $("#prevweek").click(function() {
            var weekpre = Number($("#weekhidden").val()) - 1;
            schedule.afterWeekChange(weekpre);
            $("#dropdownwrapper div").css("display", "none");
            $(".currentblock").parent().css("display", "block");
        });
        $("#nextweek").click(function() {
            schedule.nextweek();
        });
        $("#icon-chevron-left").click(function() {
            var block = Number($('#blockhidden').val());
            var prevBlock = block - 1;
            if (block != 1) {
                $('#blockhidden').val(prevBlock);
                $('#blocks' + block).css("display", "none");
                $('#blocks' + prevBlock).css("display", "block");
            }
            return false;
        });
        $("#icon-chevron-right").click(function() {
            var block = Number($('#blockhidden').val());
            var nextBlock = block + 1;
            if (block != 4) {
                $('#blocks' + block).css("display", "none");
                $('#blocks' + nextBlock).css("display", "block");
                $('#blockhidden').val(nextBlock);
            }
            return false;
        });
        $(document).click(function() {
            $(".weekdropdown").css("display", "none");
            $("#weekbtn").css("background", "none");
        });
        $("#weekbtn").click(function(event) {
            event.preventDefault();
            $(".weekdropdown").css("display", "block");
            return false;
        });
        $("#dropdownwrapper a").bind("click", function() {
            var week = $(this).attr("index");
            schedule.afterWeekChange(week);
        });
        $('#btn_print').on("click", function() {
            SelectorWeek.initWeek();
            $('#print_modal').modal('show');
        });
        $('#export').on("click", function() {
            var exportUrl = TUrlManager.parseUrl({'params': {'begindate': $('#begindate').val(), 'enddate': $('#enddate').val()}, 'baseUrl': schedule.exportUrl});
            $('#export').attr({"href": exportUrl});
        });
    },
    nextweek: function() {
        var weeknext = Number($("#weekhidden").val()) + 1;
        schedule.afterWeekChange(weeknext);
        $("#dropdownwrapper div").css("display", "none");
        $(".currentblock").parent().css("display", "block");
    },
    switchWeek: function() {
        var curweek = Number($("#weekhidden").val());
        var block = Math.ceil(curweek / 16);
        $('#blocks' + block).css("display", "block");
        $('#blockhidden').val(block);
        $("#dropdownwrapper a").removeClass("currentblock");
        $("#week" + curweek).addClass("currentblock");
    },
    afterWeekChange: function(week) {
        if (week == 0) {
            week = 52;
            var preopt = $("#years option:selected").prev();
            $("#years option:selected").removeAttr("selected");
            preopt.prop("selected", 'selected');
        }
        if (week == 53) {
            week = 1;
            var nextopt = $("#years option:selected").next();
            $("#years option:selected").removeAttr("selected");
            nextopt.prop("selected", 'selected');
        }
        $("#weekhidden").val(week);
        schedule.switchWeek();

        var year = $("#years").val();
        var date = new Date(year, "0", "1");
        var time = date.getTime();
        time += (week - 1) * 7 * 24 * 3600000;
        date.setTime(time);
        var day = date.getDay();
        var time = date.getTime();
        time += (1 - day) * 24 * 3600000;
        date.setTime(time);
        var currentDay = date.getDay();

        if (currentDay == 0) {
            currentDay = 7
        }
        var mondayTime = date.getTime() - (currentDay - 1) * 24 * 60 * 60 * 1000 - 2 * 24 * 3600000;
        var sundayTime = date.getTime() + (7 - currentDay) * 24 * 60 * 60 * 1000 - 2 * 24 * 3600000;
        var mondayObj = new Date(mondayTime);
        var sundayObj = new Date(sundayTime);
        var mondayYear = mondayObj.getFullYear();
        var mondayMonth = mondayObj.getMonth() + 1;
        var mondayDate = mondayObj.getDate();
        var sundayYear = sundayObj.getFullYear();
        var sundayMonth = sundayObj.getMonth() + 1;
        var sundayDate = sundayObj.getDate();
        var content = '';
        if (mondayYear != sundayYear) {
            content += sundayYear + '年';
        }
        if (mondayMonth != sundayMonth) {
            content += (sundayMonth < 10 ? '0' + sundayMonth : sundayMonth) + '月';
        }
        content += (sundayDate < 10 ? '0' + sundayDate : sundayDate) + '日';
        $("#dropdownwrapper a").removeClass("currentblock");
        $("#week" + week).addClass("currentblock");
        $(".weekcurrent").html("第" + week + "周");
        $('.fc-header-center h2').html(mondayYear + '年' + (mondayMonth < 10 ? '0' + mondayMonth : mondayMonth) + '月' + (mondayDate < 10 ? '0' + mondayDate : mondayDate) + '日' + ' - ' + content);

        var begindate = mondayYear + '-' + mondayMonth + '-' + mondayDate;
        var enddate = sundayYear + '-' + sundayMonth + '-' + sundayDate;
        $('#begindate').val(begindate);
        $('#enddate').val(enddate + ' 23:59:59');
        $.fn.yiiGridView.update('', {
            type: 'GET',
            url: gridUrl,
            data: {
                begindate: begindate,
                enddate: enddate + ' 23:59:59'
            }
        });
    }
};

var SelectorWeek = {
    week: null,
    block: null,
    items: [],
    serial: true,
    init: function(params) {
        if (!$.isEmptyObject(params)) {
            if (params.week) {
                this.week = parseInt(params.week);
            }
        }
        this.initWeek();

        $(".weekselector .prebtn").click(function() {
            var block = Number(SelectorWeek.block);
            var prevBlock = block - 1;
            if (block != 1) {
                $('#ws_blocks' + block).css("display", "none");
                $('#ws_blocks' + prevBlock).css("display", "block");
                SelectorWeek.block = prevBlock;
            }
            return false;
        });

        $(".weekselector .nextbtn").click(function() {
            var block = Number(SelectorWeek.block);
            var nextBlock = block + 1;
            if (block != 4) {
                $('#ws_blocks' + block).css("display", "none");
                $('#ws_blocks' + nextBlock).css("display", "block");
                SelectorWeek.block = nextBlock;
            }
            return false;
        });

        $(".weekselector .weekwrapper a").bind("click", function() {
            var week = $(this).attr("index");
            if ($(this).hasClass('selectedblock')) {
                SelectorWeek.removeItem(week);
            } else {
                SelectorWeek.addItem(week);
//                SelectorWeek.afterWeekChange(week);
            }
        });
    },
    counter: function() {
        var counter = this.items.length;
        if (counter > 0)
            $('#print_modal .counter-text').html('已选择<em style="font-size:20px;color:#f21717"> ' + counter + ' </em>周');
        else
            $('#print_modal .counter-text').html('');
    },
    addItem: function(week) {
        week = parseInt(week);
        if ($.inArray(week, this.items) === -1) {
            $("#ws_week" + week).addClass("selectedblock");
            this.items.push(week);
        }
        this.counter();
    },
    removeItem: function(week) {
        week = parseInt(week);
        var index = $.inArray(week, this.items)
        if (index !== -1) {
            $("#ws_week" + week).removeClass("selectedblock");
            this.items.splice(index, 1);
        }
        this.counter();
    },
    initWeek: function() {
        var block = Math.ceil(this.week / 16);
        this.block = block;
        $('#ws_blocks' + block).css("display", "block");
        $(".weekselector .weekwrapper a").removeClass("selectedblock");
        this.items = [];
        this.addItem(this.week);
    },
    afterWeekChange: function(week) {
        if (week == 0) {
            week = 52;
            var preopt = $("#ws_years option:selected").prev();
            $("#ws_years option:selected").removeAttr("selected");
            preopt.prop("selected", 'selected');
        }
        if (week == 53) {
            week = 1;
            var nextopt = $("#ws_years option:selected").next();
            $("#ws_years option:selected").removeAttr("selected");
            nextopt.prop("selected", 'selected');
        }
    },
    check: function() {
        this.items.sort();

        if (this.items.length === 0) {
            alert('选择周不能为空！');
            return false;
        }

        if (this.serial) {
            for (var i = 1; i < this.items.length; i++) {
                if (this.items[i] - this.items[i - 1] !== 1) {
                    alert('选择周必须是连续的！');
                    return false;
                }
            }
        }

        return true;
    },
    confirm: function() {

        if (!this.check()) {
            return false;
        }

        var weeks = this.items.sort();
        var firstWeek = weeks[0];
        var weekNumber = weeks.length - 1;
        var year = $("#ws_years").val();
        var date = new Date(year, "0", "1");
        var time = date.getTime();

        time += (firstWeek - 1) * 7 * 24 * 3600000;
        date.setTime(time);
        var day = date.getDay();
        var time = date.getTime();
        time += (1 - day) * 24 * 3600000;
        date.setTime(time);
        var currentDay = date.getDay();

        if (currentDay == 0) {
            currentDay = 7
        }
        var mondayTime = date.getTime() - (currentDay - 1) * 24 * 60 * 60 * 1000 - 2 * 24 * 3600000;

        var sundayTime = date.getTime() + (7 - currentDay) * 24 * 60 * 60 * 1000 + weekNumber * 7 * 24 * 3600000 - 2 * 24 * 3600000;
        var mondayObj = new Date(mondayTime);
        var sundayObj = new Date(sundayTime);
        var mondayYear = mondayObj.getFullYear();
        var mondayMonth = mondayObj.getMonth() + 1;
        var mondayDate = mondayObj.getDate();

        var sundayYear = sundayObj.getFullYear();
        var sundayMonth = sundayObj.getMonth() + 1;
        var sundayDate = sundayObj.getDate();

        var begindate = mondayYear + '-' + mondayMonth + '-' + mondayDate;
        var enddate = sundayYear + '-' + sundayMonth + '-' + sundayDate;

        var printUrl = TUrlManager.parseUrl({'params': {'begindate': begindate, 'enddate': enddate + ' 23:59:59'}, 'baseUrl': schedule.printUrl});
        TUtil.openUrl(printUrl);

        $('#print_modal').modal('hide');
    }
}

function commitLeaderActivity(id){

    var id={id:id};
    $.ajax({
        type: "POST",
        url:"/leaderschedule/commitSchedule",
        data:id,// 你的formid
        datatype:"json",
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) {
            var content=data.msg;
            if(data.flag!=false){
                $.notify({
                    message: {
                        text: content
                    },
                    type: (typeof content !== 'undefined') ? 'error' : 'success'
                }).show();
                window.location.reload();
            }
        }
    });
}

var SaveUtil = {
    roomDetail: '',
    init: function() {
        $('#temporary').on('click', function() {
            $("#type").val("temporary");
            SaveUtil.ajaxForm('create-form');
        });
        /*$('#save').on('click', function() {
            $("#type").val("save");
            SaveUtil.ajaxForm('create-form');
        });


        $('#apply').on('click', function() {
            $("#type").val("apply");
            SaveUtil.ajaxForm('create-form');
        });*/

        $('#save').on('click', function() {
            $("#type").val("save");
            var begin_time = new Date(Date.parse($("#Schedule_begin_time").val().replace(/-/g, "/")));
            var end_time=new Date(Date.parse($("#Schedule_end_time").val().replace(/-/g, "/")));

            var para={
                subject:$("#Schedule_subject").val(),
                schedule_type:$("#Schedule_schedule_type").val(),
                undertake:$("#Schedule_undertake_name").val(),
                location:$("#Schedule_location").val(),

                attendee:$("#Schedule_attendee").val(),
                remark:$("#Schedule_remark").val(),
                leader:$("#Schedule_leader_name").val(),
                begin_time:begin_time.getTime(),
                end_time:end_time.getTime(),
                room_id:$("#Schedule_room_id").val()

            };
            $.ajax({
                cache: true,
                type: "POST",
                url:"/leaderschedule/saveSchedule",
                data:para,// 你的formid
                datatype:"json",
                error: function(request) {
                    alert("Connection error");
                },
                success: function(data) {
                    var content=data.msg;
                    if(data.flag!=false){
                        $.notify({
                            message: {
                                text: content
                            },
                            type: (typeof content !== 'undefined') ? 'error' : 'success'
                        }).show();
                        window.location.href='/leaderschedule/index'
                    }
                }
            });
        });




    },
    ajaxForm: function(formId) {
        TUtil.backdrop();
        if (SaveUtil.isObjExists($('#' + formId))) {
            $('#' + formId).ajaxForm({
                complete: function(res) {
                    var data = $.parseJSON(res.responseText);
                    if (typeof data.isRangeTimeBeOccupied != 'undefined' && data.isRangeTimeBeOccupied) {
                        window.confirm('该时间段会议室已经被占用，是否查看详情？', function(ret) {
                            if (ret == true) {
                                TUtil.openUrl(data.showUrl);
                            }
                        });
                    } else {
                        var content = (typeof data.content !== 'undefined') ? data.content : '表单保存成功！';
                        $.notify({
                            message: {
                                text: content
                            },
                            type: (typeof data.content !== 'undefined') ? 'error' : 'success'
                        }).show();
                        if (typeof data.type !== 'undefined' && data.type == 'error') {
                            return false;window.location.href
                        }
                         window.location.href= data.redirectUrl;
                    }
                }
            });
            $('#' + formId).submit();
            return false;
        }
    },
    isObjExists: function(obj) {
        return obj.length > 0;
    }
}