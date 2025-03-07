<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>资产盘点</title>
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
    <%--    <script type="text/javascript" src="/js/email/fileuploadPlus.js?20201216"></script>--%>
    <%--    <script src="/js/base/vconsole.min.js"></script>--%>
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
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <script type="text/javascript" src="../../lib/mui/mui/mui.picker.min.js" ></script>
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
    </style>
    <%--    <link rel="stylesheet" href="/duplopages/manage/standard/form/css/treeselect.css"/>--%>
</head>
<body>
<div style="margin-top: 20px;position: relative;" class="head">
    <img src="../../img/addcodemain.png" style="position: absolute;left: 22px;top:4px "><span style="margin-left: 49px;font-size: 20px;">资产盘点</span>
</div>
<div class="" id="report1">
    <div class="itemTotal">
        <div class="item">
            <div class="item1">
                <span class="num">1.盘点名称<span class="fieldName">（必填）</span></span>
            </div>
            <div class="item2">
                <input  type="text" name="name" id="name" required  lay-verify="required"   autocomplete="off" class="layui-input jinyong ismust" value="" title="第3项">
            </div>
        </div>
        <div class="item">
            <div class="item1">
                <span class="num">2.所属分类</span>
            </div>
            <div class="item2">
                <input  type="text" name="address" required  id="address" lay-verify="required"  disabled autocomplete="off" class="layui-input" value="">
            </div>
        </div>
        <div class="item">
            <div class="item1">
                <span class="num">2.当前领用用户<span class="fieldName">（必填）</span></span>
            </div>
            <div class="item2">
                <input  type="text" name="registerTime" id="registerTime"  required  lay-verify="required"  disabled autocomplete="off" class="layui-input" value="">
            </div>
        </div>

        <div class="item">
            <div class="item1">
                <span class="num">4.管理员<span class="fieldName">（必填）</span></span>
            </div>
            <div class="item2">
                <input  type="text" name="name" id="name" required  lay-verify="required"   autocomplete="off" class="layui-input jinyong ismust" value="" title="第3项">
            </div>
        </div>
        <div class="item">
            <div class="item1">
                <span class="num">5.资产登记时间<span class="fieldName">（必填）</span></span>
            </div>
            <div class="item2">
                <div name="visitTime" required  lay-verify="required"  id="planTime" autocomplete="off" class="layui-input jinyong" value="" onclick="timeClick()"></div>
            </div>
        </div>
        <div class="item">
            <div class="item1">
                <span class="num">至<span class="fieldName">（必填）</span></span>
            </div>
            <div class="item2">
                <div name="visitTime" required  lay-verify="required"  id="planTime" autocomplete="off" class="layui-input jinyong" value="" onclick="timeClick()"></div>
            </div>
        </div>
        <button type="button" class="layui-btn layui-btn-normal submit" style="width: 80%; margin-left: 10%;font-size: 18px">提交</button>
    </div>
</div>
<script>
    // var vConsole = new VConsole();
    //时间戳转变日期格式 年-月-日 时-分-秒
    var date = new Date();//时间戳为10位需*1000，时间戳为13位的话不需乘1000
    var Y = date.getFullYear() + '-';
    var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
    var D = (date.getDate() < 10 ? '0'+date.getDate() : date.getDate()) + ' ';
    var h = (date.getHours() < 10 ? '0'+date.getHours() : date.getHours()) + ':';
    var m = (date.getMinutes() < 10 ? '0'+date.getMinutes() : date.getMinutes()) + ':';
    var s = (date.getSeconds() < 10 ? '0'+date.getSeconds() : date.getSeconds());
    var timeNow = Y+M+D+h+m+s;
    $('#registerTime').val(timeNow)
    // 获取地址栏参数值
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  decodeURI(r[2]); return null;
    }
    // /getAllFixAssetsTypes  /Antiepidemic/selVLName
    var codeNo = getQueryString('codeNo')
    $.ajax({
        type: 'get',
        url: '/eduFixAssets/getAllFixAssetsTypes',
        dataType: 'json',
        data: {
            typeId: codeNo,
        },
        success: function (json) {
            if(json.flag){
                $('#address').val(json.msg)
            }else{
                $.layerMsg({content:json.msg,icon:1});
            }
        }
    });
    function timeClick(){
        var picker = new mui.DtPicker({
            type: "datetime",//设置日历初始视图模式
            // beginDate: new Date(year, month, day),//设置开始日期
            // endDate: new Date(2222, 04, 25),//设置结束日期
            labels: ['年', '月', '日', '时', '分'],//设置默认标签区域提示语
        })
        picker.show(function(rs) {
            $("#planTime").html(rs.text);  //rs.text.split(' ')[0]只获取年。下标改成1，只获取月，以此类推
            picker.dispose();  //释放组件资源，释放后将将不能再操作组件.所以每次用完便立即调用 dispose 进行释放，下次用时再创建新实例
        })
        $('.mui-btn').html('取消');
        $('.mui-btn-blue').html('确定');
    }


    function uploadFile(formId,element){
        $(formId).fileupload({
            dataType:'json',
            done: function (e, data) {
                if(data.result.obj!=undefined){
                    if(data.result.obj != ''){
                        var data = data.result.obj;
                        element.nextAll().css("display","inline-block")
                        element.css({"width":"50%","display":"inline","color":"black"});
                        element.val(data[0].attachName);
                        element.attr('disabled',true);
                        element.attr('fileid',data[0].attachId);
                    }else{
                        layer.alert('添加附件大小不能为空!',{},function(){
                            layer.closeAll();
                        });
                    }
                }else {
                    if(data.result.datas != ''){
                        var data = data.result.obj;
                        element.nextAll().css({"width":"23%","display":"inline-block"})
                        element.css({"width":"50%","display":"inline","color":"black"});
                        element.val(data[0].attachName);
                        element.attr('disabled',true);
                        element.attr('fileid',data[0].attachId);
                    }else{
                        layer.alert('添加附件大小不能为空!',{},function(){
                            layer.closeAll();
                        });
                    }
                }

            }
        });

    }

    layui.use(['table','layer','form','laydate'], function(){
        var layer = layui.layer;
        var laydate=layui.laydate
        table = layui.table;
        form = layui.form;
        // laydate.render({
        //     elem: '#planTime'
        //     ,type: 'datetime'
        // });
        //查看防疫承诺书
        $('.look').on('click',function(){
            layer.open({
                type: 1,
                title: '防疫隔离承诺书',
                // shadeClose: true,
                btn:['确定'],
                shade: 0.5,
                maxmin: true, //开启最大化最小化按钮
                area: ['90%', '90%'],
                content:' <div class="layui-form commitLetter" >' +
                    '<p style="text-align: center;font-size: 20px;color: black;margin-top: 20px;">防疫隔离承诺书</p>' +
                    '<p style="font-size: 15px;margin-top: 15px">交通运输部上海打捞局：</p>' +
                    '<p style="font-size: 15px;text-indent: 2em;margin-top: 10px">针对新型冠状病毒肺炎疫情防控相关事项，承诺如下：</p>' +
                    '<p style="font-size: 15px;text-indent: 2em;margin-top: 10px">1.本人及共同生活家属上船前14天内未与来自或途径中高风险地区人员接触；</p>' +
                    '<p style="font-size: 15px;text-indent: 2em;margin-top: 10px">2.本人及共同生活家属上船前14天非来自或途径中高风险区，未到过确诊病例所处位置活动；</p>' +
                    '<p style="font-size: 15px;text-indent: 2em;margin-top: 10px">3.上船前，如本人来自非中高风险区和非本土病例报告所在市（区），已按照上海打捞局要求在指定地点实施7天隔离观察，并至少2次核酸检测，结果均为阴性。</p>' +
                    '<p style="font-size: 15px;text-indent: 2em;margin-top: 10px">4.上船前，本人已提供上海48小时内核酸检测报告（阴性）、健康码（绿色）、通信行程卡（绿色）、同行密接人员自查（安全）、14天详细行程记录和新冠疫苗有效接种记录，方可登船。</p>' +
                    '<p style="font-size: 15px;text-indent: 2em;margin-top: 10px">5.承诺情况属实、如有虚假或违反新型冠状病毒肺炎疫情防控要求将按相关规定或国家法律法规接受相应处理。</p>' +
                    '<p style="font-size: 15px;margin-top: 10px;margin-left: 50%;">承诺人：</p>' +
                    '<p style="font-size: 15px;margin-top: 10px;margin-left: 62%;display: inline-block;">'+ date.getFullYear() +'年</P>' +
                    '<p style="display: inline-block;">' + date.getMonth() + '月</p>'+  '<P style="display: inline-block;">'+ date.getDate() + '日</P>' +
                    '</div>',
                success:function(){

                },
                yes:function(index){
                    layer.close(index);
                },
            });
        })
        //提交
        $('.submit').on('click',function(){
            //必填项提示
            for(var i=0; i<$('.ismust').length; i++){
                if ($('.ismust').eq(i).val() == '' || $('.ismust').eq(i).val() == '上传文件') {
                    layer.msg($('.ismust').eq(i).attr('title') + '为必填项！', {icon: 2});
                    $('.layui-layer-dialog .layui-layer-content').css('font-size','20px')
                    return false
                }
            }
            if($('input[type="radio"]:checked').val() == '' || $('input[type="radio"]:checked').val() == undefined){
                layer.msg('第16项为必填项！', {icon: 0});
                $('.layui-layer-dialog .layui-layer-content').css('font-size','20px')
                return false
            }
            var attachmentIdHealth = $('#healthNum').attr('fileid');
            var attachmentNameHealth = $('#healthNum').val();
            var attachmentIdTravel = $('#travelNum').attr('fileid');
            var attachmentNameTravel = $('#travelNum').val();
            var attachmentIdVaccination = $('#vaccination').attr('fileid');
            var attachmentNameVaccination = $('#vaccination').val();
            var attachmentIdTouch = $('#touch').attr('fileid');
            var attachmentNameTouch = $('#touch').val();
            var attachmentIdNuclein = $('#nuclein').attr('fileid');
            var attachmentNameNuclein = $('#nuclein').val();

            var registerTime = $('#registerTime').val();
            var name = $('#name').val();
            var company = $('#company').val();
            var post = $('#post').val();
            var mobbleNo = $('#mobbleNo').val();
            var idNumber = $('#idNumber').val();
            var address = $('#address').val();
            var visitTime = $('#planTime').val();
            var lsolation = $('#lsolation').val();
            var trip = $('#trip').val();
            var promiseState = $('input[type="radio"]:checked').val();

            //验证手机号码
            var p = /^[\d]{11}$/; // 正则 表示 开头为数字 要11位 结尾
            if(!p.test(mobbleNo)) { // 检测值input的值是否由数字组合并要11位 如果不是则提示
                layer.msg('请输入11位数字的手机号码', {icon: 0});
                $('.layui-layer-dialog .layui-layer-content').css('font-size','20px')
                return false
            }
            if(idNumber.length != 18) {
                layer.msg('请输入18位身份证号', {icon: 0});
                $('.layui-layer-dialog .layui-layer-content').css('font-size','20px')
                return false
            }
            layer.confirm('确定要提交吗？', function(index){
                $.ajax({
                    type: 'get',
                    url: '/Antiepidemic/insert',
                    dataType: 'json',
                    data: {
                        registerTime: registerTime,
                        name: name,
                        company: company,
                        post: post,
                        mobbleNo: mobbleNo,
                        idNumber: idNumber,
                        address: address,
                        visitTime: visitTime,
                        lsolation: lsolation,
                        trip: trip,
                        promiseState: promiseState,
                        attachmentIdHealth: attachmentIdHealth,
                        attachmentNameHealth: attachmentNameHealth,
                        attachmentIdTravel: attachmentIdTravel,
                        attachmentNameTravel: attachmentNameTravel,
                        attachmentIdVaccination: attachmentIdVaccination,
                        attachmentNameVaccination: attachmentNameVaccination,
                        attachmentIdTouch: attachmentIdTouch,
                        attachmentNameTouch: attachmentNameTouch,
                        visitLocation: codeNo,
                        attachmentIdNuclein: attachmentIdNuclein,
                        attachmentNameNuclein: attachmentNameNuclein,
                    },
                    success: function (json) {
                        if(json.flag){
                            $('.jinyong').attr('disabled',true)
                            $('.submit').attr('disabled',true)
                            $('.submit').css('background-color','#a09d9d')
                            $.layerMsg({content:'提交成功！',icon:1});
                        }else{
                            $.layerMsg({content:json.msg,icon:1});
                        }
                    }
                });
            });

        })
    })

</script>
</body>
</html>
