<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2022/10/17
  Time: 11:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css"/>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <script type="text/javascript"  src="/js/common/language.js"></script>
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/gapp/jquerygridly.js"></script>
    <script type="text/javascript"  src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript"  src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script src="/js/base/base.js"></script>
    <style>
        html,body {
            width: 100%;
            height: 100%;
            background-color: #fff;
        }
        .container {
            width: 100%;
            margin: 30px 0;
        }
        .item {
            width: 70%;
            height: 82px;
            margin: 0 auto;
            line-height: 82px;
        }
        .title {
            width: 20%;
            display: inline-block;
            margin-right: 20px;
            vertical-align: top;
            white-space: nowrap;
            overflow:hidden;
            text-overflow:ellipsis;
        }
        .footer {
            text-align: center;
        }
        .footer button{
            width: 100px;
        }
        a {
            text-decoration: none;
            color: #000;
        }
        a:hover {
            color: orange;
        }
        textarea {
            background-color: #ebebeb!important;
        }
    </style>
</head>
<body>
<div class="warp">
    <div style="
    height: 20px;
    line-height: 10px;
    font-size: 22px;
    color: #494d59;">
        <img src="/ui/img/zkim/category.png">
        人员登记权限</div>
    <div class="container">

    </div>
    <div class="footer" style="margin-top: 30px;">
        <button id="saveBtn" class="layui-btn layui-btn-normal">保存</button>
    </div>
</div>
<script>
<%--    获取随机id--%>
function getNo() {
    return Date.now().toString().substr(9,12) + Math.random().toString(16).substr(10,12)
}
    $.ajax({
        url:"/coesStaffPriv/allpriv",
        type:'get',
        data:{
            ifs:false
        },
        dataType:"json",
        success:function(res) {
            if(res.flag) {
                var data = res.obj;
                for(var i = 0; i < data.length; i++) {
                    var div = $('<div>').addClass('item').css('margin','20px auto');
                    div.html('<div spid='+data[i].spId+' spno='+data[i].spNo+' class="title">'+data[i].spName+'</div>'+
                            ' <textarea id="user'+getNo()+'" class="theControlData" readonly="readonly" style="width: 60%;" rows="5"></textarea>'+
                            '<a href="javascript:;" class="addControls" style="margin: 0 5px;" id="userAdd'+getNo()+'" data-type="user">添加</a>'+
                            '<a href="javascript:;" class="cleardate">清空</a>'
                    )
                    $('.container').append(div);
                }
                $('.footer').css('display','block')
                $.ajax({
                    url:"/coesStaffPriv/allpriv",
                    data: {
                        ifs:true
                    },
                    dataType:"json",
                    success:function(res) {
                        if(res.flag) {
                            var data = res.obj;
                            var texts = $('textarea');
                            for(var i = 0; i<data.length; i++) {
                                $(texts[i]).val((data[i].userName?data[i].userName:"")).attr('username',data[i].userName).attr('user_id',data[i].spPrivUsers)

                            }
                        }
                    }
                })
            }else {
                layer.msg('数据加载失败',{icon:2})
                return
            }
        }
    })
    var user_id;
    //添加事件
    $('.container').on('click','.addControls',function() {
        user_id = $(this).siblings('textarea').prop('id');
        $.ajax({
            url:'/imfriends/getIsFriends',
            type:'get',
            dataType:'json',
            success:function(obj){
                if(obj.object == 1){
                    $.popWindow("/common/selectUserIMAddGroup");
                }else{
                    $.popWindow("/common/selectUser");
                }
            },
            error:function(res){
                $.popWindow("/common/selectUser");
            }
        })
    })
//清空事件
$('.container').on('click','.cleardate',function() {
    $(this).siblings('textarea').val('');
    $(this).siblings('textarea').attr('user_id','');
    $(this).siblings('textarea').attr('dataid','');
    $(this).siblings('textarea').attr('username','');

    $(this).siblings('textarea').attr('deptid','');
    $(this).siblings('textarea').attr('deptname','');

    $(this).siblings('textarea').attr('privid','');
    $(this).siblings('textarea').attr('userpriv','');
    $(this).siblings('textarea').attr('userprivname','');

})
//    保存事件
    $('#saveBtn').click(function() {
        var dataInfo = [];
        var items = $('.container .item');
        if(items.length <= 0) {
            layer.msg('数据加载中',{icon:2});
            return
        }
        for(var i = 0; i < items.length; i++) {
            dataInfo.push({
                SpId:$(items[i]).find('.title').attr('spid'),
                SpNo:$(items[i]).find('.title').attr('spno'),
                SpName:$(items[i]).find('.title').text(),
                SpPrivUsers:($(items[i]).find('textarea').attr('user_id') || "")
            })
        }
        $.ajax({
            url:"/coesStaffPriv/updataPriv",
            type:"post",
            data:JSON.stringify(dataInfo),
            contentType:'application/json',
            dataType:"json",
            success:function(res) {
                if(res.flag) {
                    layer.msg('保存成功',{icon:1},function() {
                    })

                }else {
                    layer.msg('保存失败',{icon:2})
                    return
                }
            }
        })
    })
</script>
</body>
</html>
