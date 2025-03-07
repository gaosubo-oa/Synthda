<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"  content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <script type="text/javascript" src="../js/xoajq/xoajq1.11.1.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/js/base/base.js?20191202.1"></script>
    <script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>

    <title></title>
    <style>
        *{
            padding: 0;
            margin: 0;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }
        span{
            font-size:14px;
            color: #666666;
        }
        ul, ol ,li{
            list-style: none;
        }
        body{
            background-color: #f3f6f9;
        }
        #body{
            min-width:980px;
            height:100%;
        }
        .table{
            width: 990px;
            margin: 0 auto;
            margin-top: 30px;
            border-collapse: collapse;
            text-align: center;

        }
        td{
            padding: 15px 0px;
            border: 1px solid #cacaca;
            letter-spacing: 1px;
        }
        thead td{
            font-weight:600;
            font-size:16px;
            color: #333333;
        }
        .tbody{
            background-color: #fff;
        }
        .tbody td{
            color: #444;
            font-size:15px;
        }
        .edit_closeBox{
            display: inline-block;
            float: left;
            width: 48px;
            position: relative;
            cursor: pointer;
        }
        .box_img{
            position: absolute;
            left: 0px;
            top: 3px;
        }
        .spans{
            float: right;
        }
        .spans:hover{
            color: #008ae7;
        }
        .left_box{
            margin-left: 18px;
            margin-right: 32px;
        }
        .soso{
            padding: 15px 10px;
        }
        .jsonstring{
            display: none;
        }
        .dingbu {
            width: 100%;
            height: 45px;
            border-bottom: 1px solid #999;
        }
        .dingbu .headImg {
            float: left;
            width: 23px;
            height: 100%;
            margin-left: 30px;
        }
        .headImg img {
            width: 23px;
            height: 23px;
            margin-top: 11px;
            vertical-align: middle;
            border: 0;
        }
        .dingbu .divTitle {
            float: left;
            height: 45px;
            line-height: 45px;
            font-size: 22px;
            margin-left: 10px;
            color: rgb(73, 77, 89);
        }
        .btn_sps {
            cursor: pointer;
            background: #2F8AE3;
            border-radius: 3px;
            border: 1px solid #59bdf0;
            color: rgb(255, 255, 255);
            font-size: 14px;
            line-height: 28px;
            position: absolute;
            right: 20px;
        }
        .btn_sps img {
            width: auto \9;
            height: auto;
            max-width: 100%;
            vertical-align: middle;
            border: 0;
        }
        .blue_text {
            font-size: 14px;
            color: #2a588c;
            font-weight: bold;
        }
        .newNews tr td {
            border: 1px solid #c0c0c0;
        }
        .release1 {
            background-color: #e7e7e7;
        }
        .td_title1 {
            display: inline-block;
            float: left;
            border: 1px solid #d9d9d9;
            width: 400px;
            height: 100px;
            color: #000;
            padding: 5px;
            text-align: left;
        }
        textarea {
            font-size: 12px;
            margin: 0;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }
        .td_title2 {
            display: inline-block;
            float: left;
            width: 5px;
            height: 5px;
            margin-left: 10px;
            margin-top: 10px;
        }
        .release3 {
            display: inline-block;
            float: left;
            font-size: 14px;
            color: #207bd6;
            margin-left: 10px;
            margin-top: 10px;
            cursor: pointer;
        }
        .release4 {
            margin-top: 10px;
            margin-left: 10px;
            display: inline-block;
            float: left;
        }
        .empty {
            font-size: 14px;
            color: #207bd6;
            cursor: pointer;
        }
        table {
            width: 990px;
            margin: 0 auto;
            margin-top: 30px;
            border-collapse: collapse;
            border-spacing: 0;
        }
        .newNews tr td {
            border: 1px solid #c0c0c0;
            height: 35px;
            padding: 10px;
        }
        .td_w {
            width: 15%;
        }
        #fjmc{
            width:250px;
            height: 25px;
            text-indent: 5px;
            border: 1px solid #d9d9d9;
        }
        .new_but {
            background: #2F8AE3
        }
        .new_but[disabled="disabled"]{
            background: #c2c8ce;
        }
        .close_but{
            background: red;
        }
        button{
            width: 85px;
            height: 30px;
            line-height: 30px;
            border-radius: 4px;
            cursor: pointer;
            border: none;
            padding: 0;
            margin: 0;
            outline-style: none;
            font-size: 12pt;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }
        .px,.gg,.jj,.qz{
            display: none;
        }
        #pxh {
            width: 100px;
            height: 25px;
            text-indent: 5px;
            border: 1px solid #d9d9d9;
        }
        .clickRoomName{
            cursor: pointer;
        }
        .clickRoomName:hover{
            color: #2b7fe0;
        }
    </style>
</head>
<body>
<div id="body" style="padding-bottom: 40px;">
    <div class="dingbu">
        <div class="headImg">
            <img src="/img/commonTheme/theme6/bianqian.png">
        </div>
        <div class="divTitle">
            管理群组
        </div>
    </div>
    <button style="top: 6px;width: 100px;" id="but_ns" class=" btn_sps b_but b_new"><img style="margin-right: 3px" src="../../img/mywork/newbuildworjk.png" alt="">新建群组</button>
    <table class="table" style="display: none">
        <thead style="background-color: #ebf1f6">
            <td style="width: 190px;">讨论群组名称</td>
            <td style="width: 280px;">讨论群组成员</td>
            <td style="width: 150px;">创建人</td>
            <td style="width: 190px;">创建时间</td>
            <td style="width: 181px;">操作</td>
        </thead>
        <tbody class="tbody">
        <tr>
            <td>设计讨论组</td>
            <td class="soso">王德亮，李青，梁红，李立峰</td>
            <td>王德亮</td>
            <td>2017-09-22</td>
            <td>
                <div class="edit_closeBox left_box">
                    <img src="../img/spirit/managegroup_edit.png" alt="" class="box_img">
                    <span class="spans">编辑</span>
                </div>
                <div class="edit_closeBox">
                    <img src="../img/spirit/managegroup_close.png" alt="" class="box_img">
                    <span class="spans">解散</span>
                </div>
            </td>
        </tr>

        <tr>
            <td>设计讨论组</td>
            <td class="soso">王德亮，李青，梁红，李立峰，王德亮，李青，梁红，李立峰，王德亮，李青，梁红，李立峰</td>
            <td>王德亮</td>
            <td>2017-09-22</td>
            <td>
                <div class="edit_closeBox left_box">
                    <img src="../img/spirit/managegroup_edit.png" alt="" class="box_img">
                    <span class="spans">编辑</span>
                </div>
                <div class="edit_closeBox">
                    <img src="../img/spirit/managegroup_close.png" alt="" class="box_img">
                    <span class="spans">解散</span>
                </div>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<div id="body1" style="display: none">
    <div class="dingbu">
        <div class="headImg">
            <img src="/img/commonTheme/theme6/bianqian.png">
        </div>
        <div class="divTitle">
            新建群组
        </div>
    </div>
    <div class="newNews">
        <table>
            <tr class="px">
                <td class="blue_text">  排序号：</td>
                <td>
                    <input type="text" name="unitName" class="inputTd" value="" id="pxh" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();">
                </td>
            </tr>
            <tr>
                <td class="blue_text">  群组名称：</td>
                <td>
                    <input type="text" name="unitName" class="inputTd" value="" id="fjmc" placeholder="请输入群名称">
                </td>
            </tr>
            <tr class="gg">
                <td class="blue_text">  群组公告：</td>
                <td>
                    <textarea class=" td_title1" id="qzgg" dataid="" resize="auto"></textarea>
                </td>
            </tr>
            <tr class="jj">
                <td class="blue_text">  群组简介：</td>
                <td>
                    <textarea class=" td_title1" id="qzjj" dataid="" resize="auto"></textarea>
                </td>
            </tr>
            <tr class="qz">
                <td class="blue_text">  群主：</td>
                <td>
                    <textarea readonly="readonly" class="td_title1  release1" id="qz" dataid="" resize="auto" style="height: 27px;line-height: 27px;"></textarea>
                    <img class="td_title2 release2" id="ip" src="../img/mg2.png" alt="">
                    <div class="release3" id="qz_dept_add">添加</div>
                    <div class="release4 empty" onclick="empty('qz')">清空</div>

                </td>
            </tr>
            <tr>
                <td class="blue_text">  群组成员：</td>
                <td>
                    <textarea readonly="readonly" class="td_title1  release1" id="qzcy" dataid="" resize="auto"></textarea>
                    <input type="hidden" id="qzcyHidden">
                    <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt="">
                    <div class="release3" id="dept_add">添加</div>
                    <div class="release4 empty" onclick="empty('qzcy')">清空</div>

                </td>
            </tr>
            <tr>
                <td colspan="2" style="height: 30px;position: relative;">
                    <div class="hide" style="display: none"></div>
                    <button type="button" class="new_but" id="new" style="position: absolute;top: 11px;left: 50%;margin-left: -90px;color: #fff;">确定</button>
                    <button type="button" class="close_but" id="close" style="position: absolute;top: 11px;left: 50%;margin-left: 60px;color: #fff;">取消</button>
                </td>
            </tr>
        </table>
    </div>
</div>
<script>
    var freeCompanyFlag = false;
    var add = $.GetRequest().add|| '';
    var index = 0;
    if(add !=''){
        $('title').html('新建群组');
    }else{
        $('title').html('管理群组');
    }
    function doQtPer(e){
        var url = e;
        new QWebChannel(qt.webChannelTransport, function(channel) {
            var content = channel.objects.interface;
            content.xoa_sms(url,"","SEND_MSG");
        });
    }

    function getLocalTime(e) {
        var now = new Date();
        now.setTime(e * 1000);
        return now.toLocaleDateString();
    }
    function edit(e){
        if(freeCompanyFlag){
            layer.msg('中小企业版免费版不支持群聊', {icon: 2});
            return;
        }
        index = 1;
        var rid = e.attr('rid');

        $.ajax({
            url:'/im/getSingleRoom',
            type:'get',
            dataType:'json',
            data:{
                room_id:rid
            },
            success:function(obj){
                $('#body').hide();
                $('#body1').show();
//                $('.release3').hide();
//                $('.release4').hide();
                $('#body1 .divTitle').html('编辑群组');
                $('.px').show();
                $('.gg').show();
                $('.jj').show();
                $('.qz').show();

                $('#pxh').val(obj.roomNo).attr('room_id',rid);
                $('#fjmc').val(obj.rname);
                $('#qzgg').val(obj.roomRemark);
                $('#qzjj').val(obj.roomIntroduce);
                $('#qzcy').val(obj.rmemberUidName+',').attr({
                    'dataid':obj.rmember_uid,
                    'user_id':obj.rmember_userId
                });
                $('#qzcyHidden').val(obj.rmember_uid).attr('uname',obj.rmemberUidName);
                $('#qz').val(obj.rsetUidName).attr({
                    'dataid':obj.rset_uid,
                    'user_id':obj.rsetUserId
                });
            }
        })
    }
    function closes(e){
        var btid = e.attr('btid');
        var _this = e;
        var rname = e.parents('tr').find('.clickRoomName').text();
        $.ajax({
            url:'/im/getOutPerson',
            type:'get',
            dataType:'json',
            data:{
                flag:11,
                room_id:btid,
                opt:2
            },
            success:function(data){
                var obj = {};
                obj['dismissRoom'] = 1;
                obj['room_id'] = btid;
                obj['rname'] = rname;
                var e = JSON.stringify(obj);

                // doQtPer(e);
                _this.find('spans').html('恢复');
                window.location.reload()

            }
        })
    }
    function reply(e){
        var _this = e
        var btid = e.attr('btid');
        var rname = e.parents('tr').find('.clickRoomName').text();
        $.ajax({
            url:'/im/roomRever',
            type:'get',
            dataType:'json',
            data:{
                room_id:btid,
            },
            success:function(data){
                console.log(data)
                var obj = {};
                obj['recoverRoom'] = 1;
                obj['room_id'] = btid;
                obj['rname'] = rname;
                var e = JSON.stringify(obj);

                // doQtPer(e);

                _this.find('spans').html('解散');
                window.location.reload()
            }
        })
    }

    function clickRoomNameWeb(e){
        var btid = e.attr('btid');
        var rname = e.text();
        var obj = {};
        obj['clickRoomNameWeb'] = 1;
        obj['room_id'] = btid;
        obj['rname'] = rname;
        var e = JSON.stringify(obj);
        doQtPer(e);
    }

    function empty(id){
        $("#"+id).val("").attr({
            'dataid':'',
            'username':'',
            'user_id':'',
            'userprivname':'',
        });
    };

    $(function(){
        // 查询是否是免费版本
        $.ajax({
            url: '/sys/getSysMessage',
            type: 'get',
            dataType: 'json',
            data: {},
            success: function (data) {
                if(data.flag){
                    if(data.object.freeCompany==0||data.object.freeCompany=="0"){
                        freeCompanyFlag = true;
                    }
                }
            }
        });

        layer.load();
        $.ajax({
            url:'/user/userCookie',
            type:'get',
            dataType:'json',
            data:{},
            success:function(data){
                // console.log(data);
                var uid = data.object.uid;
                $.ajax({
                    url:'/im/getAllRoomPc',
                    type:'get',
                    dataType:'json',
                    data:{
                        uid:uid
                    },
                    success:function(data){
                        if(add !=''){
                            $('#but_ns').click();
                            $('#close').hide();
                        }else{
                        }

                        var str = '';
                        for(var i=0;i<data.length;i++){
                            var stime = getLocalTime(data[i].rtime);
                            var str_json = JSON.stringify(data[i]);
                            var spans = '',clickfuc='';
                            str +=  '<tr>'+
                                '<td><div class="clickRoomName" onclick="clickRoomNameWeb($(this))" btID="'+data[i].btID+'">'+data[i].rname+'</div></td>'+
                                '<td class="soso">'+data[i].rmemberUidName+'</td>'+
                                '<td>'+data[i].rsetUidName+'</td>'+
                                '<td>'+stime+'</td>'+
                                '<td>'+
                                '<div class="edit_closeBox left_box" onclick="edit($(this))" rid="'+ data[i].btID +'">'+
                                '<img src="../img/spirit/managegroup_edit.png" alt="" class="box_img">'+
                                '<span class="spans">编辑</span>'+function(){
                                    if(data[i].roomStatus == 0){
                                        spans =  '解散';
                                        clickfuc = 'closes';
                                        return '';
                                    }else{
                                        spans =  '恢复';
                                        clickfuc = 'reply';
                                        return '';
                                    }
                                }()+'</div>'+
                                '<div class="edit_closeBox" onclick="'+ clickfuc +'($(this))" btID="'+data[i].btID+'">'+
                                '<img src="../img/spirit/managegroup_close.png" alt="" class="box_img">'+
                                '<span class="spans">'+ spans +'</span>'+
                                '<div class="jsonstring">'+ str_json +'</div>'+
                                '</div>'+
                                '</td>'+
                                '</tr>'
                        }
                        $('.tbody').html(str);
                        layer.closeAll();
                        $('.table').show();
                    }

                })
            }

        });

        $('#but_ns').click(function(){
            index = 0;
            $('#body').hide();
            $('#body1').show();
            var inputtwo = document.getElementById('fjmc');
            inputtwo.focus()
            $('.release3').show();
            $('.release4').show();
            $('#body1 .divTitle').html('新建群组');
        });

        $("#dept_add").on("click",function(){
            user_id = "qzcy";
			$.ajax({
				url:'/imfriends/getIsFriends',
				type:'get',
				dataType:'json',
				data:{},
				success:function(obj){
                    if(obj.object == 1){
                        $.popWindow("../common/selectUserIMAddGroup");
                    }else{
                        $.popWindow("../common/selectUser");
                    }
				},
                error:function(res){
                    $.popWindow("../common/selectUser");
                }
			})
        });
        $("#qz_dept_add").on("click",function(){
            user_id = "qz";
            $.ajax({
                url:'/imfriends/getIsFriends',
                type:'get',
                dataType:'json',
                data:{},
                success:function(obj){
                    if(obj.object == 1){
                        $.popWindow("../common/selectUserIMAddGroup?0");
                    }else{
                        $.popWindow("../common/selectUser?0");
                    }
                },
                error:function(res){
                    $.popWindow("../common/selectUser?0");
                }
            })
        });

        $('#close').click(function(){
            $('#body').show();
            $('#body1').hide();
            $('.px').hide();
            $('.gg').hide();
            $('.jj').hide();
            $('.qz').hide();
            $('#pxh').val('');
            $('#fjmc').val('');
            $('#qzgg').val('');
            $('#qzjj').val('');
            $('#qzcy').val('').attr('dataid','').attr('username','').attr('user_id','').attr('userprivname','');
        });

        $('#new').click(function(){
            if(freeCompanyFlag){
                layer.msg('中小企业版免费版不支持群聊', {icon: 2});
                return;
            }
            if($('#qzcy').attr('dataid') !=''){
                if(index == 0){
                    $(this).attr('disabled','disabled');
                    var data = {};
                    data['qname'] = $('#fjmc').val();
                    data['quid'] = $('#qzcy').attr('dataid');
                    data['quname'] = $('#qzcy').attr('username');
                    var e = JSON.stringify(data);
                    $('#new').attr('disabled','disabled');
                    doQtPer(e,1);
                }else if(index == 1){
                    var groupPermissionType = $('#qz').attr('dataid');
                    var groupPermissionTypeName = $('#qz').attr('username');
                    if(groupPermissionType&&groupPermissionType != ''){
                        if(groupPermissionType.indexOf(',') > -1){
                            groupPermissionType = $('#qz').attr('dataid').split(',')[0];
                            groupPermissionTypeName = $('#qz').attr('username').split(',')[0];
                        }
                        var roomNo = $('#pxh').val();
                        var room_id = $('#pxh').attr('room_id');
                        var room_name = $('#fjmc').val();
                        var roomRemark = $('#qzgg').val();
                        var roomIntroduce = $('#qzjj').val();
                        var quidchange = $('#qzcy').attr('dataid');
                        var qunamechange = $('#qzcy').val();
                        if(!matchString(quidchange,groupPermissionType)){
                            quidchange = quidchange + groupPermissionType +',';
                            qunamechange = qunamechange + groupPermissionTypeName +',';
                        }
                        var quid = $('#qzcyHidden').val();
                        var qname = $('#qzcyHidden').attr('uname');
                        var add = [];
                        var deletethis =[];
                        var addname = [];
                        var deletethisname = [];
                        for(var j=0;j<quid.split(',').length;j++){
                            var quidIndex = quid.split(',')[j];
                            var qunameIndex = qname.split(',')[j];
                            if(quidIndex!=''){
                                for(var i=0;i<quidchange.split(',').length;i++){
                                    var quidchangeIndex = quidchange.split(',')[i];
                                    if(quidIndex == quidchangeIndex){
                                        break;
                                    }else{
                                        if(i == quidchange.split(',').length-1){
                                            deletethis.push(quidIndex);
                                            deletethisname.push(qunameIndex);
                                        }
                                    }
                                }
                            }

                        }
                        for(var i=0;i<quidchange.split(',').length;i++){
                            var quidchangeIndex = quidchange.split(',')[i];
                            var qunamechangeIndex = qunamechange.split(',')[i];
                            if(quidchangeIndex != ''){
                                for(var j=0;j<quid.split(',').length;j++){
                                    var quidIndex = quid.split(',')[j];
                                    if(quidIndex == quidchangeIndex){
                                        break;
                                    }else{
                                        if(j == quid.split(',').length-1){
                                            add.push(quidchangeIndex);
                                            addname.push(qunamechangeIndex);
                                        }
                                    }
                                }
                            }
                        }
                        if(add.join(',') !=''){
                            var quadd = add.join(',')+',';
                            var quaddname = addname.join(',')+',';
                        }else{
                            var quadd = add.join(',');
                            var quaddname = addname.join(',');
                        }
                        if(deletethis.join(',') !=''){
                            var qudelete = deletethis.join(',')+',';
                            var qudeletename = deletethisname.join(',')+',';
                        }else{
                            var qudelete = deletethis.join(',');
                            var qudeletename = deletethisname.join(',');
                        }
                        $('#new').attr('disabled','disabled');
                        $.ajax({
                            url:'/im/updateRoom',
                            type:'get',
                            dataType:'json',
                            data:{
                                flag:1,
                                orderId:roomNo,
                                notice:roomRemark,
                                introduce:roomIntroduce,
                                name:room_name,
                                roomOf:room_id,
                                members:quidchange,
                                rsetUid:groupPermissionType
                            },
                            success:function(obj){
                                if(obj.flag){
                                    var data = {};
                                    data['qname'] = room_name;
                                    data['quadd'] = quadd;
                                    data['quaddname'] = quaddname;
                                    data['qudelete'] = qudelete;
                                    data['qudeletename'] = qudeletename;
                                    data['quid'] = quid+',';
                                    data['room_id'] = room_id;

                                    var e = JSON.stringify(data);
                                    doQtPer(e);
                                    location.reload();
                                }else{
                                    layer.msg('编辑群组保存失败!', {icon: 2});
                                }
                                $('#new').removeAttr('disabled');
                            }
                        })
                    }else{
                        layer.msg('群主不能为空!', {icon: 2});
                    }
                }
            }else{
                layer.msg('群组成员不能为空!', {icon: 2});
            }
        })
    })

</script>
</body>
</html>