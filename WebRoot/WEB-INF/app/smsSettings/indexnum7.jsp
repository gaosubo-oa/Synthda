<%--
  Created by IntelliJ IDEA.
  User: liruixu
  Date: 2017/6/14
  Time: 9:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>模块权限</title>
    <link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>

    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/lib/laydate/laydate.js"></script>
    <%--<script type="text/javascript" src="../../lib/layui-v1.0.9_rls/layui/layui.js"></script>--%>
    <%--<script type="text/javascript" src="js/jquery/jquery.min.js"></script>--%>
    <%--<script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>--%>
    <%--<script type="text/javascript" src="/js/base/base.js"></script>--%>

    <style>
        .navigation .left .news {
            /* font-size: 14px; */
            margin-left: 2px;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            margin-top: -3px;
            margin-right: 40px;
            font-size: 22px;
            color: #333;
        }
    </style>
</head>
<body>

<div class="navigation  clearfix" style="margin-top: -10px;font-size:40px">
    <div class="left">
        <img src="../img/icon_changerole_06.png" alt="">
        <div class="news">模块权限</div>
    </div>
</div>

<table class="tr_td" width="400"    align="center">

    <tbody><tr class="TableHeader" >
        <td align="center"><b>允许手机提醒的模块</b></td>
        <td align="center"></td>
        <td align="center" style=" border-right:1px solid  #ddd"><b>备选模块</b></td>
    </tr>
    <tr class="TableData">
            <td valign="top" style="border: 1px solid #ddd;" align="center">

                    <div class="innerBorder">
                        <div class="innerDiv">
                            <select id="select1" name="select1" multiple="" style="width:200px;height:280px">
                            </select>
                        </div>
                    </div>

            </td>
        <td align="center" style="border: 1px solid #ddd">
            <input type="button" id= "copyLeft" class="SmallInput" style="width: 30px" value="← ">
            <br><br>
            <input type="button" id="copyRight" class="SmallInput" style="width: 30px" value="→  ">
        </td>
        <td valign="top" style="border: 1px solid #ddd;" align="center">

                <div class="innerDiv">
                    <select id="select2" name="select2" multiple="" style="width:200px;height:280px">
                    </select>
                </div>
                </div>


        </td>
    </tr>

    <tr class="TableControl">
        <td align="center" valign="top" colspan="4">
            <input type="button" class="save1" id="okbtn" value="保存">&nbsp;&nbsp;
        </td>
    </tr>

    </tbody>
</table>
<script>

    $(function () {

        $.get('/sms2Priv/selectSmS2Priv',function (json) {
            console.log(json)
            var obj = json.obj;
            var objBeixuan = json.object;
            if(obj){
                var str = '';
                for (var i = 0; i < obj.length;i++){

                    str+='<option value="'+json.obj[i].codeNo+'" >'+json.obj[i].codeName+'</option>'

                }

                $('[name="select1"]').html(str)
            }
            if(objBeixuan){
                var str = '';
                for (var i = 0; i < objBeixuan.length;i++){

                    str+='<option value="'+objBeixuan[i].codeNo+'" >'+objBeixuan[i].codeName+'</option>'

                }

                $('[name="select2"]').html(str)
            }
        },'json')


        $.get('/sms2Priv/selectModule',function (json) {

            if(json.flag) {
                var str = '';
                for (var i = 0; i < json.obj.length;i++){
                        if(json.obj[i].codeNo){

                            str+='<option value="'+json.obj[i].codeNo+'" >'+json.obj[i].codeName+'</option>'

                        }
                }

                $('[name="select2"]').html(str)
            }
        },'json')


        $("#okbtn").click(function () {
            var select1 = document.getElementById('select1');
            var ops = select1.options;
            var str = '';
            for(var i=0; i<ops.length; i++){
                    str+=ops[i].value+",";
                    /*alert(str);//获取value*/

            }
            $.ajax({
                type:'post',
                url: '/sms2Priv/upSms2Priv',
                dataType: 'json',
                data:{
                    typePriv:str
                },
                success: function (data) {
                    if (data.flag) {
                        layer.msg('保存成功', {icon: 6});
                    }
                }
            });

        });
    })

    $(function(){
        //将选中的复制到右侧
        $("#copyRight").click(function(){
            //获取所有选中option
            var $options = $("#select1 option:selected");
            //删除select中选中的option
            var $remove = $options.remove();
            //将选中的option添加到select2中
            $remove.appendTo('#select2');
            $options.each(function(){
                /*alert(this.value);*/
            });
        });

        //将左侧复制到右侧
        $("#copyLeft").click(function(){
            var $optino = $("#select2 option:selected");
            var $remove = $optino.remove();
            $remove.appendTo('#select1');

        });
    });




</script>
</body>
</html>
