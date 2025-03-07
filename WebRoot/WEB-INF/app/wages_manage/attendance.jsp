<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2021/12/11
  Time: 10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script src="/ui/js/qrcode.min.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.config.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>

</head>
<style>
    .select{
        background-color: #FBD4B4;

    }
</style>
<body>
<div style="margin: 43px auto;">
    <form class="layui-form" action="">
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">1</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects1" value="1" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">2</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects2" value="2" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">3</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects3" value="3" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">4</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects4" value="4" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">5</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects5" value="5" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">6</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects6" value="6" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">7</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects7" value="7" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">8</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects8" value="8" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">9</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects9" value="9" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">10</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects10" value="10" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                    <label class="layui-form-label form_label">11</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects11" value="11" type="button">排布选择</button>
                    </div>
                   </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">12</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects12" value="12" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">13</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects13" value="13" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">14</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects14" value="14" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">15</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects15" value="15" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">16</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects16" value="16" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">17</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects17" value="17" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">18</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects18" value="18" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">19</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects19" value="19" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">20</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects20" value="20" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">21</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects21" value="21" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">22</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects22" value="22" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">23</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects23" value="23" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">24</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects24" value="24" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">25</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects25" value="25" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">26</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects26" value="26" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">27</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects27" value="27" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">28</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects28" value="28" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">29</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects29" value="29" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">30</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" name="selects30" value="30" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        <div class="layui-col-xs3" style="padding: 0 5px;">
                <div class="layui-form-item">
                        <label class="layui-form-label form_label">31</label>
                <div class="layui-btn-container">
                       <button class="layui-btn layui-btn-primary selects" lay-filter="filter" name="selects31" value="31" type="button">排布选择</button>
                    </div>
                    </div>
            </div>
        </form>
    </div>
</body>
<script>
    var objs;
    function childs(obj){
        objs = obj.data
        $.ajax({
            type: 'post',
            url: '/AttendanceType/selectAllAttendanceDate',
            dataType: 'json',
            data: {
                attendTypeId: objs.attendTypeId,
            },
            success: function (json) {
                var data = json.obj[0].jobObject
                if (data != undefined){
                    delete data.attendJobId
                    delete data.attendTypeId
                    for(var i=1;i<=31;i++){
                        if(data['salaryPost'+i] != 0){
                            $("button[name='selects"+i+"']").attr('class','layui-btn layui-btn-primary selects select')
                            $("button[name='selects"+i+"']").attr('flag','true')
                        }else{
                            $("button[name='selects"+i+"']").attr('class','layui-btn layui-btn-primary selects')
                            $("button[name='selects"+i+"']").attr('flag','false')
                        }
                    }
                }else{
                    for(var i=1;i<=31;i++){
                        $("button[name='selects"+i+"']").attr('flag','false')
                    }

                }

            }
        })
    }

$('.selects').click(function(res){
        var currentTD = $(this);
        var flag = currentTD.attr('flag')
    if(flag == 'true'){
        flag = false
    }else if(flag == 'false'){
        flag = true
    }
        var arrangement = currentTD.attr('value')
        $.ajax({
            type: 'post',
            url: '/AttendanceType/updateDateArrangement',
            dataType: 'json',
            data: {
                attendTypeId: objs.attendTypeId,
                day: arrangement,
                flag: flag
            },
            success: function (json) {
                window.location.replace('/wages/attendance')

            }
        })

})
</script>
</html>
