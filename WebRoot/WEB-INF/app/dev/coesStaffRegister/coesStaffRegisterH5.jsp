<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>人员登记</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/email/fileuploadPlus.js?20230529"></script>
    <script src="/js/base/vconsole.min.js"></script>
    <style>
        .ztree *{
            font-size: 11pt!important;
        }
        #questionTree li{
            border-bottom:1px solid #ddd;
            line-height: 40px;
            padding-left: 10px;
            cursor:pointer;
            border-radius: 3px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }
        .item1{
            margin-left: 5%;
            font-size: 18px;
            color: black;
            /*font-weight: bold;*/
        }
        .item2{
            width: 90%;
            margin: 10px auto;
        }
        .item2 label{
            display: block;
        }
        .required{
            color: #CE5841;
            margin-left: 1%;
            font-size: 13px;
        }
        .itemTotal{
            margin: 13px 0px;
        }
        .layui-input{
            /*width: 90%;*/
            /*margin: 2px auto;*/
            height: 45px;
            border-radius: 10px;
            line-height: 45px;
            font-size: 17px;
        }
        .upload{
            text-align: center;
            color: #1E9FFF;
        }
        .layui-input[fieldtype='2']{
            text-align: center;
        }
        .fieldDesc{
            font-size: 13px;
            color: #292929;
            margin: 5px 0px;
            margin-left: 5%;
        }
        .fieldName{
            color: red;
        }
        .layui-form-radio>i{
            font-size: 18px;
        }
        .layui-btn+.layui-btn{
            margin: 0px;
        }
        input[disabled], select[disabled], textarea[disabled], select[readonly], textarea[readonly] {
            cursor: not-allowed;
            background-color: #eeeeee!important;
        }
        .layui-bg-gray {
            background-color: #b5b2b2!important;
        }
        .layui-table-tool{
            display: none;
        }
        .openFile input[type=file]{
            position: absolute;
            top: 27px;
            width: 100%;
            height: 18px;
            z-index: 99;
            opacity: 0;
        }
        .item{
            margin-top: 30px;
        }
        .prompt{
            color: #505050;
            font-size: 16px;
        }
        .layui-form-radio {
            line-height: 29px;
            margin: 0px;
            cursor: pointer;
            font-size: 0;
        }
        .layui-layer-dialog .layui-layer-content {
            position: relative;
            padding: 20px;
            line-height: 24px;
            word-break: break-all;
            overflow: hidden;
            font-size: 20px;
            overflow-x: hidden;
            overflow-y: auto;
            color: red;
        }
    </style>
    <link rel="stylesheet" href="/lib/zTree_v3/css/zTreeStyle/zTreeStyle.css"/>
    <script type="text/javascript" src="/lib/zTree_v3/js/jquery.ztree.all.min.js"></script>
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>
    <link rel="stylesheet" href="../../lib/mui/mui/mui.picker.min.css" />
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <script type="text/javascript" src="../../lib/mui/mui/mui.picker.min.js" ></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <style>
        input[type=button], input[type=submit] {
            font-size: 17px;
            font-weight: 400;
            line-height: 1.42;
            position: relative;
            display: inline-block;
            margin-bottom: 0;
            padding: 6px 12px;
            cursor: pointer;
            -webkit-transition: all;
            transition: all;
            -webkit-transition-timing-function: linear;
            transition-timing-function: linear;
            -webkit-transition-duration: .2s;
            transition-duration: .2s;
            text-align: center;
            vertical-align: top;
            white-space: nowrap;
            color: #1E9FFF;
            border: 1px solid #ccc;
            border-radius: 3px;
            border-top-left-radius: 3px;
            border-top-right-radius: 3px;
            border-bottom-right-radius: 3px;
            border-bottom-left-radius: 3px;
            background-color: #fff;
            background-clip: padding-box;
        }
        .hidden {
            display: none;
        }
    </style>
<%--        <link rel="stylesheet" href="/duplopages/manage/standard/form/css/treeselect.css"/>--%>
</head>
<body>
<div style="margin-top: 20px;position: relative;" class="head">
    <img src="../../img/addcodemain.png" style="position: absolute;left: 22px;top:4px "><span style="margin-left: 49px;font-size: 20px;">人员登记</span>
</div>
<div class="" id="report1">
    <div class="itemTotal">
        <div class="item">
            <div class="item1">
                <span class="num">1.姓名</span>
            </div>
            <div class="item2">
                <input  type="text" name="name" id="name" required  lay-verify="required"   autocomplete="on" class="layui-input jinyong ismust" value="" title="姓名" >
            </div>
        </div>
        <div class="item">
            <div class="item1">
                <span class="num">2.请填写手机号<span class="fieldName">（必填）</span></span>
            </div>
            <div class="item2">
                <input  type="text" name="mobbleNo" id="mobbleNo"  required  lay-verify="required"   autocomplete="on" class="layui-input jinyong ismust" value="" placeholder="示例格式：13688888888" title="手机号">
            </div>
        </div>
        <div class="item">
            <div class="item1">
                <span class="num">3.请填写身份证号<span class="fieldName">（必填）</span></span>
            </div>
            <div class="item2">
                <input  type="text" name="idNumber" id="idNumber" required  lay-verify="required"   autocomplete="on" class="layui-input jinyong ismust" value="" placeholder="请填写身份证号" title="身份证号">
            </div>
        </div>
        <button type="button" class="layui-btn layui-btn-normal continue" style="width: 80%; margin-left: 10%;font-size: 18px">继续填写</button>
        <div class="leave hidden">
            <div class="item">
                <div class="item1">
                    <span class="num">4.离船地点<span class="fieldName">（必填）</span></span>
                </div>
                <div class="item2">
                    <input  type="text" name="ashoreAddress" id="ashoreAddress" required  lay-verify="required"   autocomplete="off" class="layui-input jinyong ismust" value="" title="离船地点">
                </div>
            </div>
            <div class="item">
                <div class="item1">
                    <span class="num">5.离船时间<span class="fieldName">（必填）</span></span>
                </div>
                <div class="item2">
                    <div name="ashoreTime" required  lay-verify="required" style="line-height: 38px;"  id="ashoreTime" autocomplete="off" class="layui-input jinyong" value="" onclick="timeClick()"></div>
                </div>
            </div>
            <button type="button" class="layui-btn layui-btn-normal leaveBtn" style="width: 80%; margin-left: 10%;font-size: 18px">确认离船</button>
        </div>
 <div class="loginInfo hidden">
     <div class="item">
         <div class="item1">
             <span class="num">4.单位<span class="fieldName">（必填）</span></span>
         </div>
         <div class="item2">
             <select name="company" id="company" required lay-verify="required" style="font-size: 16px;" autocomplete="off" title="单位" >
                 <option value="局机关">局机关</option>
                 <option value="救捞工程船队">救捞工程船队</option>
                 <option value="救捞拖轮船队">救捞拖轮船队</option>
                 <option value="三用船队">三用船队</option>
                 <option value="中国海洋工程有限公司">中国海洋工程有限公司</option>
                 <option value="研发中心">研发中心</option>
                 <option value="制造基地">制造基地</option>
                 <option value="保障中心">保障中心</option>
                 <option value="外部单位">外部单位</option>
             </select>
         </div>
     </div>
     <div class="item">
         <div class="item1">
             <span class="num">5.岗位职务</span>
         </div>
         <div class="item2">
             <input  type="text" name="post" id="post" required  lay-verify="required"   autocomplete="off" class="layui-input jinyong" value="">
         </div>
     </div>
     <div class="item">
         <div class="item1">
             <span class="num">6.人员类型<span class="fieldName">（必填）</span></span>
         </div>
         <div class="item2">
             <select name="personnelType" id="personnelType" required lay-verify="required" style="font-size: 16px;" autocomplete="off" title="人员类型" >
                 <option value="1">乘客</option>
                 <option value="2">船员</option>
                 <option value="3">工程人员</option>
             </select>
         </div>
     </div>
     <div class="item">
         <div class="item1">
             <span class="num">7.房间号</span>
         </div>
         <div class="item2">
             <input  type="text" name="roomNum" id="roomNum" required  lay-verify="required"  autocomplete="off" class="layui-input jinyong ismust" value="" >
         </div>
     </div>
     <div class="item">
         <div class="item1">
             <span class="num">8.登船时间</span><span class="fieldName">（必填）</span>
         </div>
         <div class="item2">
             <div name="registerTime" required style="line-height: 38px;"  lay-verify="required"  id="registerTime" autocomplete="off" class="layui-input jinyong" value="" onclick="timeClick()"></div>
         </div>
     </div>
     <div class="item">
         <div class="item1">
             <span class="num">9.登船地点</span><span class="fieldName">（必填）</span>
         </div>
         <div class="item2">
             <input  type="text" name="registerPlace" id="registerPlace"  required  lay-verify="required"   autocomplete="off" class="layui-input jinyong" value="">
         </div>
     </div>
     <div class="item">
         <div class="item1">
             <span class="num">10.船名/项目</span>
         </div>
         <div class="item2">
             <input  type="text" name="ShipName" required  id="ShipName" lay-verify="required"  disabled autocomplete="off" class="layui-input" value="">
         </div>
     </div>
     <button type="button" class="layui-btn layui-btn-normal submit" style="width: 80%; margin-left: 10%;font-size: 18px">确认登船</button>
 </div>
 </div>

</div>
<script>
//时间戳转变日期格式 年-月-日 时-分-秒
var date = new Date();//时间戳为10位需*1000，时间戳为13位的话不需乘1000
var Y = date.getFullYear() + '-';
var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
var D = (date.getDate() < 10 ? '0'+date.getDate() : date.getDate()) + ' ';
var h = (date.getHours() < 10 ? '0'+date.getHours() : date.getHours()) + ':';
var m = (date.getMinutes() < 10 ? '0'+date.getMinutes() : date.getMinutes()) + ':';
var s = (date.getSeconds() < 10 ? '0'+date.getSeconds() : date.getSeconds());
var timeNow = Y+M+D+h+m+s;
    //生成时间
var timeSave = null;
function timeClick(){
    var picker = new mui.DtPicker({
        type: "datetime",//设置日历初始视图模式
        // beginDate: new Date(year, month, day),//设置开始日期
        // endDate: new Date(2222, 04, 25),//设置结束日期
        labels: ['年', '月', '日', '时', '分'],//设置默认标签区域提示语
    })
    picker.show(function(rs) {
        //rs.text.split(' ')[0]只获取年。下标改成1，只获取月，以此类推
        //rs.text.split(' ')[0]只获取年。下标改成1，只获取月，以此类推
        var a1 = Date.parse(rs.text);
        var a2 = Date.parse(new Date());
        if(a1 > a2) {
            layer.msg('选择时间不可以大于当前时间',{icon:2})
            return
        }
        $("#registerTime").text(rs.text);
        if(timeSave) {
            var a3 = Date.parse(timeSave);
            var a4 = Date.parse(rs.text);
            if(a3 > a4) {
                layer.msg('离船时间不能小于登船时间',{icon: 2})
                return;
            }else {
                $("#ashoreTime").text(rs.text);
                timeSave = null;
            }
        }

        picker.dispose();  //释放组件资源，释放后将将不能再操作组件.所以每次用完便立即调用 dispose 进行释放，下次用时再创建新实例
    })
    $('.mui-btn').html('取消');
    $('.mui-btn-blue').html('确定');
}
    // 获取地址栏参数值
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  decodeURI(r[2]); return null;
    }
var codeNo = getQueryString('codeNo')
    //继续填写
    $('.continue').click(function() {
        var name = $('#name').val();
        if(!name) {
            layer.msg('请输入姓名', {icon: 2});
            return false
        }
        //验证手机号码
        // // var p = /^[\d]{11}$/;
        // var mobbleNo = $('#mobbleNo').val();

        var mobbleNo = $('#mobbleNo').val();
        if(!mobbleNo) {
            layer.msg('请输入手机号', {icon: 2});
            return false
        }
        var idNumber = $('#idNumber').val();
        if(!idNumber) {
            layer.msg('请输入身份证',{icon:2})
            return
        }
        $.ajax({
            url:"/coesStaffRegister/selectNumber",
            dataType:'json',
            data: {
                idNumber:idNumber,
                mobilNo:mobbleNo
            },
            success:function(res) {
                if(res.flag){
                    if(res.obj.length === 0 || res.obj[0]['ashoreAddress'] != '') {
                        $('.continue').addClass('hidden')
                        $('.loginInfo').removeClass('hidden');

                        if(res.obj.length > 0) {
                            var data = res.obj[0]
                            $('.loginInfo input[name=post]').val(data.post);
                            $('.loginInfo input[name=roomNum]').val(data.roomNumber);
                        }
                        $.ajax({
                            type: 'get',
                            url: '/coesStaffRegister/selVLName',
                            dataType: 'json',
                            data: {
                                visitLocation: codeNo,
                            },
                            success: function (json) {
                                if(json.flag){
                                    $('#ShipName').val(json.msg)
                                }
                            }
                        });
                    }else {
                        timeSave = res.obj[0].boardTime;
                        $('.continue').addClass('hidden')
                        $('.leave').removeClass('hidden')
                    }
                }
            }
        })
    })



        //离船提交
        $('.leaveBtn').click(function() {
            var name = $('#name').val();
            if(!name) {
                layer.msg('请输入姓名',{icon: 2});
                return
            }
            var mobilNo = $('#mobbleNo').val();
            if(!mobilNo) {
                layer.msg('请输入手机号',{icon:2});
                return
            }
            var idNumber = $('#idNumber').val();
            if(!idNumber) {
                layer.msg('请输入身份证号码',{icon:2});
                return
            }
            var ashoreAddress = $('.leave #ashoreAddress').val();
            var ashoreTime = $('.leave #ashoreTime').text();
            if(!ashoreAddress) {
                layer.msg('请输入离船地点', {icon: 0});
                return
            }
            if(!ashoreTime) {
                layer.msg('请输入离船时间', {icon: 0});
                return
            }
            layer.confirm('确认提交吗',function(index) {
                $('.layui-layer-btn0').prop('disabled',true)
                $.ajax({
                    url:"/coesStaffRegister/ashoreStaffRegister",
                    dataType:"json",
                    data: {
                        name,
                        mobilNo,
                        idNumber,
                        ashoreAddress,
                        ashoreTime
                    },
                    success:function(res) {
                        if(res.flag) {
                            layer.msg('离船成功',{icon:1},function() {
                                location.reload();
                            });

                        }else {
                            layer.msg(res.msg,{icon:2})
                        }
                    }
                })
            })
        })

        //登船提交
        $('.submit').on('click',function(){
            var name = $('#name').val();
            if(!name) {
                layer.msg('请输入姓名',{icon:2})
                return
            }
            var mobilNo = $('#mobbleNo').val();
            if(!mobilNo) {
                layer.msg('请输入手机号',{icon:2})
                return
            }
            var idNumber = $('#idNumber').val();
            if(!idNumber) {
                layer.msg('请输入身份证号码',{icon:2})
                return
            }
            var company = $('.loginInfo select[name=company]').val();
            if(!company) {
                layer.msg('请输入单位', {icon: 0});
                return
            }
            var post =  $('.loginInfo #post').val();
            var staffType = $('.loginInfo #personnelType option:selected').text()
            if(!staffType) {
                layer.msg('请选择人员类型', {icon: 0});
                return
            }
            var roomNumber = $('.loginInfo input[name=roomNum]').val();
            var boatName = $('.loginInfo #ShipName').val();
            var boardTime = $('.loginInfo #registerTime').text();
            if(!boardTime) {
                    layer.msg('请选择登船时间', {icon: 0});
                    return
            }
            var boardAddress = $('.loginInfo #registerPlace').val();
            if(!boardAddress) {
                    layer.msg('请选择登船地点', {icon: 0});
                    return
            }
            layer.confirm('确定要提交吗？', function(index){
                $('.layui-layer-btn0').prop('disabled',true)
                $.ajax({
                    url: '/coesStaffRegister/boardStaffRegister',
                    dataType:"json",
                    data: {
                        boardTime: boardTime,
                        name: name,
                        company: company,
                        post: post,
                        mobilNo: mobilNo,
                        idNumber: idNumber,
                        boardAddress:boardAddress,
                        staffType:staffType,
                        roomNumber:roomNumber,
                        // boardScanTime:timeNow,
                        boatName: boatName
                    },
                    success: function (res) {
                        if(res.flag && res.status) {
                            layer.msg('登船成功',{icon:1},function() {
                                location.reload();
                            });
                        }else if(!res.flag && !res.status) {
                            layer.msg(res.msg + ',请核对信息',{icon: 2})
                        }
                    }
                });
            });
        })

</script>
</body>
</html>
