<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<head>
    <title>OA用户绑定</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../css/enterpriseManage/weixinqy.css">
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>

    <%--<script type="text/javascript" src="/static/js/module.js"></script>--%>
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.8/css/jquery.dataTables.min.css"/>
    <script type="text/javascript" src="//cdn.datatables.net/1.10.8/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="../../lib/layer/layer.js?20201106"></script>

    <style>
        #userlist .alert{ visibility: hidden; }
        #userlist .alert.active{ visibility: visible; }
        .btnr{
            color: #fff;background-color: #d84a38;display: inline-block;width: 74px;height: 23px;text-align: center;line-height: 23px;border-radius: 5px;
        }
        legend h5{
            margin-left: 20px;
        }
    </style>
</head>
<body>
<fieldset>
    <legend><h5>企业微信账号绑定到OA用户</h5></legend>
</fieldset>
<div class="well">
    <div class="userlist-wrapper">
        <form name="userForm" >
            <input type="hidden" name="username">
            <input type="hidden" name="userid">
            <input type="hidden" id="userId">
            <table  class="table table-striped table-bordered">
                <thead>
                <tr role="row">
                    <th class="sorting_disabled" rowspan="1" colspan="1">用户名</th>
                    <th class="sorting_disabled" rowspan="1" colspan="1">用户ID</th>
                    <th class="sorting_disabled" rowspan="1" colspan="1">状态</th>
                    <th class="sorting_disabled" rowspan="1" colspan="1">选项</th>
                    <th class="sorting_disabled" rowspan="1" colspan="1">提示</th>
                </tr>
                </thead>
                <tbody id="userlist">

                </tbody>
            </table>
        </form>
    </div>
</div>
</body>

<script type="text/javascript" charset="utf-8">
    $.ajax({
        url:'/enterpriseWeChatManage/getEnterpriseWeChatUserList',
        type:'post',
        dataType:'json',
        beforeSend: function () {
            $('#userlist').append('<tr class="ja"><td colspan="5">正在加载，请稍等！</td></tr>');
        },
        success:function(res){
            $('.ja').remove();
            var str="";
            var arr=res.data
            if(res.flag){
                for(var i=0;i<arr.length;i++){
                    str+=
                            '<tr userid='+arr[i].userid+' class="userid">' +
                                '<td>'+arr[i].name+'</td>' +
                                '<td>'+arr[i].userid+'</td>' +
                                '<td>' +
                            function () {
                                if(arr[i].bind==false){
                                    return '<span clss="btnl" style="font-weight: bold;color: #fff;background-color: #468847;width: 50px;height: 21px ;display: inline-block;text-align: center;line-height: 21px;border-radius: 5px;">未绑定</span>'
                                }else{
                                    return '<span clss="btnl" style="font-weight: bold;color: #fff;background-color: #468847;width: 50px;height: 21px ;display: inline-block;text-align: center;line-height: 21px;border-radius: 5px;">已绑定</span>'
                                }
                            }()+
                                '</td>'+
                                '<td>' +
                        function () {
                            if(arr[i].bind==false){
                                return '<a type="0" href="javascript:;" class="btnr" style="font-weight: bold;color: #fff;background-color: #d84a38;display: inline-block;width: 74px;height: 23px;text-align: center;line-height: 23px;border-radius: 5px;">绑定</a>'
                            }else{
                                return '<a type="1"  href="javascript:;" class="btnr1" style="font-weight: bold;color: #fff;background-color: #d84a38;display: inline-block;width: 74px;height: 23px;text-align: center;line-height: 23px;border-radius: 5px;">解除绑定</a>'
                            }
                        }()+
                        '</td>' +
                                '<td></td>' +
                            '</tr>'


                }
                $('#userlist').append(str)
            }
        }
    })
    $(document).delegate('.btnr1','click',function () {
        var types=$(this).attr('type');
        var userid=$(this).parent().parent().attr('userid')
        layer.open({
            type: 1,
            title: ['提示','background-color:#2e8ded;color:#fff'],
            content:'<div style="font-size: 18px;text-align: center;padding-top: 60px;">确认解绑！</div>',
            area: ['430px', '250px'],

            btn: ['确定','关闭'],
            yes:function(index){
                $.ajax({
                    url:'/enterpriseWeChatManage/bindEnterpriseWeChatAndOA',
                    type:'post',
                    data:{
                        'type':types,
                        'dingdingId':userid
                    },
                    dataType:'json',
                    success:function(){

                        layer.close(index);
                        window.location.reload();

                    }
                })
            },
            btn1:function(index){
                layer.close(index)
            },
            btnAlign:'c',

        })


    })


    var user_id=null;
    var dingdingId
    $(document).delegate('.btnr','click',function () {

        user_id='userId';
        $.popWindow('/common/selectUser?0')
        dingdingId=$(this).parent().parent().attr('userid')
        return dingdingId
    })

    function loadfile() {
        var types=$('.btnr').attr('type');
        var uid=$('#userId').attr('dataid');
        $.ajax({
            url:'/enterpriseWeChatManage/bindEnterpriseWeChatAndOA',
            type:'post',
            data:{'type':types,'dingdingId':dingdingId,'uid':uid},
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
                            layer.close(index)
                            window.location.reload();
                        },
                        btnAlign:'c',

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
</script>
</html>