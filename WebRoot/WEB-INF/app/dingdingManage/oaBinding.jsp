<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<head>
    <title>钉钉用户绑定OA用户</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1"/>
    <link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../css/enterpriseManage/weixinqy.css">
    <link rel="stylesheet" type="text/css" href="/css/base.css">
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script type="text/javascript" src="/static/js/module.js"></script>

    <script type="text/javascript" src="../../lib/layer/layer.js?20201106"></script>

    <style>
        #userlist .alert{ visibility: hidden; }
        #userlist .alert.active{ visibility: visible; }
        fieldset h5{
            font-size: 13pt;
        }
        #downChild{
            position: fixed;
            top: 46px;
            width: 19.9%;
            float: left;
            height: 100%;
            overflow-y: auto;
            overflow-x: hidden;
            border-right: #ccc 1px solid;
        }
        #downChild .dpetWhole0 .childdept{
            padding-left: 60px!important;
        }
        #downChild .dpetWhole0 ul .childdept{
            padding-left: 80px!important;
        }
        #downChild .dpetWhole0 ul ul li .childdept{
            padding-left: 95px!important;
        }

        #downChild li>span{
            font-size: 12pt;
        }

        .well{
            width: 78%;
            float: right;
        }
        legend h5{
            margin: 10px 0;
            margin-left: 20px;
        }
        .content .well{
            position: fixed;
            top: 46px;
            left: 19.9%;
            float: right;
            height: 100%;
            overflow-y: auto;
            overflow-x: hidden;
        }
    </style>
</head>
<body>
<fieldset>
    <legend><h5>钉钉用户绑定OA用户</h5></legend>
</fieldset>
<div class="content">
    <div id="downChild">
        <div class="pickCompany">
            <div style="padding-left: 16px;" class="childdept" style="vertical-align: middle;width: 15px;margin-right: 10px;margin-left: 13px;margin-bottom: 4px;">

            </div>
        </div>

    </div>
    <div class="well" >
        <div class="userlist-wrapper">
            <div id="pagediv">

            </div>
            <%--<form name="userForm" >--%>
            <%--<input type="hidden" name="username">--%>
            <%--<input type="hidden" name="userid">--%>
            <%--<input type="hidden" id="userId">--%>
            <%--<table  class="table table-striped table-bordered">--%>
            <%--<thead>--%>
            <%--<tr role="row">--%>
            <%--<th class="sorting_disabled" rowspan="1" colspan="1">用户名</th>--%>
            <%--<th class="sorting_disabled" rowspan="1" colspan="1">用户ID</th>--%>
            <%--<th class="sorting_disabled" rowspan="1" colspan="1">状态</th>--%>
            <%--<th class="sorting_disabled" rowspan="1" colspan="1">选项</th>--%>
            <%--<th class="sorting_disabled" rowspan="1" colspan="1">提示</th>--%>
            <%--</tr>--%>
            <%--</thead>--%>
            <%--<tbody id="userlist">--%>

            <%--</tbody>--%>
            <%--</table>--%>
            <%--</form>--%>
        </div>
    </div>
</div>

</body>

<script type="text/javascript" charset="utf-8">
    var pageObj;

    $(function(){
       $('#batchBindBtn').click(function(){
           $.ajax({
               url:'/dingding/batchBind',
               type:'post',
               dataType:'json',
               success:function(res){
                   if(res.flag){
                       layer.msg('批量绑定成功')
                   } else {
                       layer.msg('批量绑定失败')
                   }
               }
           })
       })
    })

    loadSidebar1($('#downChild'),0);

    $(document).delegate('.btnr1','click',function () {
        var userid=$(this).attr('uId');
        var openId=$(this).attr('openid');
        layer.open({
            type: 1,
            title: ['提示','background-color:#2e8ded;color:#fff'],
            content:'<div style="font-size: 18px;text-align: center;padding-top: 60px;">确认解绑！</div>',
            area: ['430px', '250px'],

            btn: ['确定','关闭'],
            yes:function(index){
                $.ajax({
                    url:'/dingding/removeBind',
                    type:'post',
                    data:{
                        'openId':openId,
                        'userId':userid
                    },
                    dataType:'json',
                    success:function(){

                        layer.close(index);
                        pageObj.init();

                    }
                })
            },
            btn1:function(index){
                layer.close(index)
            },
            btnAlign:'c'

        })


    })


    var user_id=null;
    var dingdingId;
    var opid;
    $(document).delegate('.btnr','click',function () {
        opid = $(this).attr('openId');
        $('#userId').removeAttr('userId');
        $('#userId').removeAttr('userName');
        user_id='userId';
        $.popWindow('/common/selectUser?0');
        dingdingId=$('#userId').attr('user_id');
        return dingdingId
    })

    function loadfile() {
        var openId=$('.btnr').attr('openId');
        var userid=$('#userId').attr('userId');
        var usid =$('#userId').attr('user_id');
        $.ajax({
            url:'/dingding/bind',
            type:'post',
            data:{'openId':opid,'userId':usid.slice(0,usid.length-1)},
            dataType:'json',
            success:function(res){
                var msg=res.msg;
                if(res.flag){

                    layer.open({
                        type: 1,
                        title: ['提示','background-color:#2e8ded;color:#fff'],
                        content:'<div style="font-size: 18px;text-align: center;padding-top: 60px;">绑定成功！</div>',
                        area: ['430px', '250px'],

                        btn: ['关闭'],
                        yes:function(index){
                            layer.close(index);
                            pageObj.init();
                        },
                        btnAlign:'c'

                    })

                }else {
                    layer.open({
                        type: 1,
                        title: ['提示','background-color:#2e8ded;color:#fff'],
                        content:'<div class="msg" style="font-size: 18px;text-align: center;padding-top: 60px;"></div>',
                        area: ['430px', '250px'],

                        btn: ['关闭'],
                        yes:function(index){
                            layer.close(index)
                        },
                        btnAlign:'c',
                        success:function(){
                            $('.msg').html(msg)
                        }

                    })

                }

            }
        })
    }

    // 部门树遍历方法
    function loadSidebar1(target,deptId) {
        $.ajax({
            url: '/dingding/getDepartments',
            type: 'get',
            data: {
                id: deptId
            },
            dataType: 'json',
            success: function (data) {
                var strTop = '';
                var str = '';
                if(data.code=='0'){
                    data.data.forEach(function (v, i) {
                        if (v.name) {
                            if(v.id != 1){
                                // 其它部门
                                str += '<li><span data-types="1"  data-numtrue="1" ' +
                                    'onclick= "imgDown_s2(' +v.id + ',this)"  style="height:35px;line-height:35px;padding-left: 30px" deptid="' + v.id + '" class="firsttr childdept">' +
                                    '<span class=""></span>' +
                                    '<img src="/img/sys/dapt_right.png" alt="" style="margin-left: 12px;width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;">' +
                                    '<a href="javascript:void(0)" class="dynatree-title" title="' + v.name + '">' + v.name + '</a>' +
                                    '</span><ul style="display:none;" class="dpetWhole0"></ul></li>';
                            } else{
                                // 顶部部门 第一个部门
                                strTop+= '<li><span data-types="1"  data-numtrue="1" ' +
                                    'onclick= "show_users(' +v.id + ')"  style="height:35px;line-height:35px;padding-left: 8px" deptid="' + v.id + '" class="firsttr childdept">' +
                                    '<span class=""></span>' +
                                    '<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="margin-left: 12px;width: 15px;height: 14px;margin-top: -3px;margin-right: 4px;">' +
                                    '<a href="javascript:void(0)" class="dynatree-title" title="' + v.name + '"（钉钉）>' + v.name + '（钉钉）</a>' +
                                    '</span><ul style="display:none;" class="dpetWhole0"></ul></li>';
                            }
                        }
                    });

                    widthnum++;
                    target.html(strTop);
                    target.html(str);

                    $('#userlist').append('<tr class="ja" ><td colspan="5" style="text-align:center">请选择部门，展示人员数据！</td></tr>');

                }

            }
        })
    }

    function imgDown_s2(deptNum, me) {

        if ($(me).attr('data-types') == undefined) {
            $(me).find('img').attr('src', $(me).find('img').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
            if ($(me).find('img').attr('src') == '/img/sys/dapt_right.png') {
                $(me).find('img').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": ""});
                $(me).find('img').width(8);
                $(me).find('img').height(14);
                $(me).next().hide();
                // $(me).next().html('')
            } else if ($(me).find('img').attr('src') == '/img/sys/dapt_down.png') {
                $(me).find('img').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": "-5px"});
                $(me).find('img').width(14);
                $(me).find('img').height(9);
                $(me).next().show();
            }
        }
        else {
            $(me).find('img').attr('src', $(me).find('img').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
            if ($(me).find('img').attr('src') == '/img/sys/dapt_right.png') {
                $(me).find('img').width(8);
                $(me).find('img').height(14);
            } else if ($(me).find('img').attr('src') == '/img/sys/dapt_down.png') {
                $(me).find('img').width(14);
                $(me).find('img').height(9);
            }
            if ($(me).attr('data-types') == '1') {
                $(me).next().show();
                $(me).attr('data-types', '2')
            } else if ($(me).attr('data-types') == '2') {
                $(me).next().hide();
                $(me).attr('data-types', '1')
            }
        }
        show_users(deptNum);
        loadSidebar1($(me).next(),deptNum);
    }
    function show_users(deptId) {
        var screenwidth = document.documentElement.clientWidth;
        // console.log(screenwidth*0.9)
        if (screenwidth  > 2000) {
            var nums = screenwidth * 0.97;
            var sumwidth = screenwidth * 0.97 + 'px';
        } else {
            var nums = 850;
            var sumwidth = '850px';
        }
        var width1 = nums * 0.050 + 'px';
        var width2 = nums * 0.075 + 'px';
        var width3 = nums * 0.040 + 'px';
        var width4 = nums * 0.060 + 'px';
        //表格数据初始化展示
        pageObj = $.tablePage('#pagediv',sumwidth, [
            {
                width: width1,
                title: '钉钉用户姓名',
                name: 'userName',
            },
            {
                width: width2,
                title: '钉钉用户账号',
                name: 'openId',
            },
            {
                width: width4,
                title: 'OA用户姓名',
                name: 'bindUserName',
            },
            {
                width:width3,
                title:'操作',
            }
        ], function (me) {
//            me.data.pageSize = 10;
            me.data.deptId=deptId,
                me.init('/dingding/selUsersWithBindType',[
                    {
                        name:'编辑',
                        fn:function(obj) {
                            if(obj.ifBind==0){
                                return '<a type="0" href="javascript:;" class="btnr" openId="'+obj.openId+'" >绑定用户</a><input style="display:none" user_id id="userId"/>'
                            }else{
                                return '<a type="1" href="javascript:;" class="btnr1" uId="'+obj.userId+'" openId="'+obj.openId+'" style="color: red">解除绑定</a><input style="display:none" id="userId"/>'
                            }
                        }
                    },
                ])
        })
//        $('#userlist').html("")
//        $.ajax({
//            url:'/ewx/selUsersWithBindType',
//            type:'post',
//            data:{deptId:deptId},
//            dataType:'json',
//            beforeSend: function () {
//                $('#userlist').append('<tr class="ja" ><td colspan="5" style="text-align:center">正在加载，请稍等！</td></tr>');
//            },
//            success:function(res){
//                $('.ja').remove();
//                var str="";
//                var arr=res.data
//                if(res.flag){
//                    for(var i=0;i<arr.length;i++){
//                        str+=
//                            '<tr userid='+arr[i].openId+' class="userid" >' +
//                            '<td>'+arr[i].userName+'</td>' +
//                            '<td>'+arr[i].openId+'</td>' +
//                            '<td>' +
//                            function () {
//                                if(arr[i].ifBind==0){
//                                    return '<span clss="btnl" style="font-weight: bold;color: #fff;background-color: #468847;width: 50px;height: 21px ;display: inline-block;text-align: center;line-height: 21px;border-radius: 5px;">未绑定</span>'
//                                }else{
//                                    return '<span clss="btnl" style="font-weight: bold;color: #fff;background-color: #468847;width: 50px;height: 21px ;display: inline-block;text-align: center;line-height: 21px;border-radius: 5px;">已绑定</span>'
//                                }
//                            }()+
//                            '</td>'+
//                            '<td>' +
//                            function () {
//                                if(arr[i].ifBind==0){
//                                    return '<a type="0" href="javascript:;" class="btnr" openId="'+arr[i].openId+'" style="font-weight: bold;color: #fff;background-color: #d84a38;display: inline-block;width: 74px;height: 23px;text-align: center;line-height: 23px;border-radius: 5px;">绑定</a>'
//                                }else{
//                                    return '<a type="1" href="javascript:;" class="btnr1" uId="'+arr[i].userId+'" openId="'+arr[i].openId+'" style="font-weight: bold;color: #fff;background-color: #d84a38;display: inline-block;width: 74px;height: 23px;text-align: center;line-height: 23px;border-radius: 5px;">解除绑定</a>'
//                                }
//                            }()+
//                            '</td>' +
//                            '<td>'+function () {
//                                if(arr[i].bindUserName!=undefined)
//                                    return '绑定的OA用户为：'+arr[i].bindUserName;
//                                return '';
//                            }()+'</td>' +
//                            '</tr>'
//
//
//                    }
//                    $('#userlist').html(str)
//                }
//            }
//        })
            $('#dbgz_page').css('display','none');
    }
</script>
</html>