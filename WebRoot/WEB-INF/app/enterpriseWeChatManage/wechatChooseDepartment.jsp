<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<head>
    <title>数据导入 - 组织架构初始化</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <!--[if lte IE 8]>
    <![endif]-->

    <script type="text/javascript" >
        var MYOA_JS_SERVER = "";
        var MYOA_STATIC_SERVER = "";
    </script>
</head>
<link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../../css/enterpriseManage/weixinqy.css">
<script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="../../lib/layer/layer.js?20201106"></script>
<body>
<div>
    <fieldset>
        <legend><h5>数据导入 - 组织架构初始化</h5></legend>
    </fieldset>

    <div class="func-item">
        <button id="btn-init" class="btn btn-small btn-primary" data-module="list"><i class="icon-home icon-white"></i>一键初始化</button>
    </div>

    <div id="mod-list" class="mod-func well" style="display:block;">
        <iframe id="dept-iframe" class="iframes" src="/enterpriseWeChatManage/getWechatDataImport" frameborder="0"></iframe>
    </div>
</div>
</body>

<script type="text/javascript">
    $(function(){
        $(".func-item button").on("click", function(){
            $(".func-item button").removeClass("btn-primary");
            $(".func-item button i").removeClass("icon-white");
            $(".mod-func").hide();
            var module = $(this).attr("data-module");
            $(this).addClass("btn-primary");
            $(this).find("i").addClass("icon-white");
            $("#mod-" + module).show();
        });

        $("#btn-init").click(function(){
            var pd=$('#iframe', window.parent.document).attr('v-s')
            if(pd!=2){
                layer.open({
                    type: 1,
                    title: ['提示','background-color:#2e8ded;color:#fff'],
                    content:'<div style="font-size: 18px;text-align: center;padding-top: 60px;">请填写企业微信开发凭证,保存并测试链接！</div>',
                    area: ['430px', '250px'],

                    btn: ['关闭'],
                    yes:function(index){
                        layer.close(index)
                    },
                    btnAlign:'c',

                })


                return
            }
            var me=$(this);
            $("#dept-iframe").contents().find("#btn-sync-dept").click();
            me.off().html('正在初始化请等待');
            $.ajax({
                url:'/enterpriseWeChatManage/enterpriseWeChatDeptSynchro',
                type:'post',
                dataType:'json',
                success:function(res){
                    if(res.flag){
                        layer.open({
                            type: 1,
                            title: ['提示','background-color:#2e8ded;color:#fff'],
                            content:'<div style="font-size: 18px;text-align: center;padding-top: 60px;">初始化成功！</div>',
                            area: ['430px', '250px'],

                            btn: ['关闭'],
                            yes:function(index){
                                layer.close(index)
                            },
                            btnAlign:'c',

                        })
                        me.off().html('<i class="icon-refresh icon-white"></i>一键初始化');
                    }else {
                        layer.open({
                            type: 1,
                            title: ['提示','background-color:#2e8ded;color:#fff'],
                            content:'<div style="font-size: 18px;text-align: left;padding: 60px 50px 0 50px;">'+res.msg+'</div>',
                            area: ['430px', '250px'],

                            btn: ['关闭'],
                            yes:function(index){
                                layer.close(index)
                            },
                            btnAlign:'c',

                        })
                        me.off().html('<i class="icon-refresh icon-white"></i>一键初始化');
                    }
                }
            })
        });

        function getCookie(name){
            var strcookie = document.cookie;//获取cookie字符串
            var arrcookie = strcookie.split("; ");//分割
        //遍历匹配
            for ( var i = 0; i < arrcookie.length; i++) {
                var arr = arrcookie[i].split("=");
                if (arr[0] == name){
                    return arr[1];
                }
            }
            return "";
        }


    });
</script>

</html>