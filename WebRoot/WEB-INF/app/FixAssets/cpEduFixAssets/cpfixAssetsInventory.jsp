<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>资产盘点</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script src="../js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
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


    .mbox {
        padding: 8px;
    }

    .items {
        background-color: #f2f2f2;
        text-align: center;
        height: 30px;
        line-height: 30px;
    }

    .layui-form-item {
        margin-bottom: 5px;
    }

    .inpWhit {
        width: 300px;
    }

    /*下拉按钮*/
    .dropbtn {
        text-align: left;
        background-color: #009688;
        color: white;
        font-size: 12px;
        border: none;
        cursor: pointer;
        height: 30px;
        width: 90px;
    }

    /* 容器 <div> - 需要定位下拉内容 */
    .dropdown {
        position: relative;
        display: inline-block;
    }

    /* 下拉内容 (默认隐藏) */
    .dropdown-content {
        margin-left: 0px;
        display: none;
        position: absolute;
        top: 32px;
        background-color: #fff;
        min-width: 115px;
        text-align: center;
        line-height: 36px;
        padding-top: 10px;
        box-shadow: 0px 8px 12px 0px rgba(0, 0, 0, 0.2);
        z-index: 999999999;
    }

    .licon {
        display: inline-block;
        width: 0;
        height: 0;
        border-style: dashed;
        border-color: transparent;
        position: absolute;
        right: 6px;
        top: 52%;
        margin-top: -3px;
        cursor: pointer;
        border-width: 6px;
        border-top-color: #fff;
        border-top-style: solid;
        transition: all .3s;
        -webkit-transition: all .3s;
    }

    * {
        font-family: "Microsoft Yahei" !important;
    }

    b {
        color: red;
    }

    /* 下拉菜单的链接 */
    .dropdown-content a {
        color: black;
        /*padding: 12px 16px;*/
        text-decoration: none;
        display: block;
    }

    /*!* 在鼠标移上去后显示下拉菜单 *!*/
    .icon-on {
        margin-top: -9px;
        -webkit-transform: rotate(180deg);
        transform: rotate(180deg);
    }

    .layui-table {
        width: 100% !important;
    }
    .bg{
        background: #f2f2f2;
    }

    nav div{
        float: left !important;
        margin: 15px;
    }
    nav{
        height: 50px;
        border-bottom: 1px solid #cfdbe2;
        background-color: #fafbfc;
        border-radius: 0;
    }
    .time{
        width: 90px;
        margin-left: 0px;
        display: inline;
    }
    .input{
        margin-left: 130px;
    }



</style>
<body>

<div class="mbox">
    <form class="layui-form">
        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
            <ul class="layui-tab-title">
                <li class="layui-this" value="0">资产盘点</li>
                <%--<button type="button" class="layui-btn layui-btn-primary" style="margin-top:-5px ">全部</button>--%>
<%--                <button type="button" class="layui-btn  layui-btn-sm add" style="float: right;margin-right: 30px">--%>
<%--                    <i class="layui-icon">&#xe608;</i> 新建--%>
<%--                </button>--%>
<%--                <button type="button" style="margin-left: 10px;vertical-align: top;" class="layui-btn layui-btn-normal layui-btn-radius divbox layui-btn-sm creatCode">生成二维码</button>--%>
<%--           --%>

            </ul>

        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">所属分类</label>
            <div class="layui-input-inline">
                <select id="visitLocation" name="visitLocation" class="visitLocation" lay-verify="visitLocation" lay-filter="visitLocation">
                    <option value="">请选择</option>
                </select>
            </div>
            <button type="button" class="layui-btn  layui-btn-sm add" style="float: right;margin-right: 30px">
                <i class="layui-icon">&#xe608;</i> 新建
            </button>
            <button type="button" class="layui-btn layui-btn-normal divbox creatCode layui-btn-sm" style="margin-left: 10px; vertical-align: top;">生成二维码</button>
        </div>
        <div>
            <div style="margin-top: -10px">
                <table id="demo1" lay-filter="test1"></table>
            </div>
        </div>
    </form>
    <%--添加内容--%>
</div>
<div>
    <table id="demo" lay-filter="test" ></table>
</div>
</div>

<script type="text/html" id="barDemo" class="see_class">
    <a  class="layui-btn layui-btn-xs" id="qingDan" lay-event="edit" >清单</a>
</script>
<script type="text/javascript">
    var inventoryId ;  //表格的id
    layui.use(['table', 'form', 'laydate','element'], function () {
        var table = layui.table;
        var form = layui.form
        var laydate = layui.laydate
        var element = layui.element

        $.ajax({
            url: '/eduFixAssets/getAllFixAssetsType',
            type: 'get',
            dataType: 'json',
            success: function (res) {
                var data=res.object;
                var str="";
                for(var i=0;i<data.length;i++){
                    str+='<option value="'+data[i].typeId+'">'+data[i].typeName+'</option>';
                }
                $('select[name="visitLocation"]').append(str);
                form.render();

            }
        });
        laydate.render({
            elem: '#outTime' //指定元素
        });
        //第一个实例
        var internalTable = table.render({
            elem: '#demo'
            , url: '/eduFixAssets/fixAssetsGetInventory' //数据接口
            , page: true //开启分页
            , id: 'tableOne'
            // , toolbar: '#toolbarDemo'
            , defaultToolbar: ['filter', 'print', 'exports', {
                title: '提示' //标题
                , layEvent: 'LAYTABLE_TIPS' //事件名，用于 toolbar 事件中使用
                , icon: 'layui-icon-tips' //图标类名
            }]
            , cols: [[ //表头
                {field: 'inventoryName',align: 'center', title: '盘点名称'}
                , {field: 'operator',align: 'center', title: '盘点操作人'}
                , {field: 'inventoryTime',align: 'center', title: '盘点生成时间'}
                , {title: '详情', align: 'center', toolbar: '#barDemo'}
            ]],
            response: {
                statusName: 'flag',  //规定数据状态的字段名称，默认：code
                statusCode: true,   //规定成功的状态码，默认：0
                dataName: 'object',    //规定数据列表的字段名称，默认：data
                countName: 'totleNum'
            }
        });


        // //监听行单击事件
        // table.on('row(test)', function(obj){
        //     inventoryId = obj.data.inventoryId  //获取当前行的id
        // });


        //监听工具条
        table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            inventoryId = data.inventoryId   //获取当前行的id
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
            if (layEvent === 'edit') { //详情
                //do something
                // edit(data);
                window.open("/eduFixAssets/cpfixAssetsInventoryList?inventoryId="+data.inventoryId)
            } else if (layEvent === 'LAYTABLE_TIPS') {
                layer.alert('Hi，头部工具栏扩展的右侧图标。');
            }
        });


        layui.use(['layer'], function () {
            var layer = layui.layer
        });

        //预览等弹出框  $('.creatCode').on("click",function ()
        $('.creatCode').on("click",function () {

            if ($("#visitLocation").val()==''||$("#visitLocation").val()==undefined){
                layer.msg('请选择所属分类！',{icon:0});
                return false;
            }

            var codeNo1 = $("#visitLocation").val()
            var address1= $("#visitLocation").find("option:selected").text()
            var address2=decodeURI(address1);
            layer.open({
                type: 1,
                title:"生成二维码",
                area:['100%','100%'],
                offset:"0px",
                content: '<div id="code">\n' +
                    '        <center> <div id="qrcode"  style="margin-top: 100px"></div></center>\n' +
                    '    </div><center><strong><p style="margin-top: 30px;font-size: 30px">'+address2+'</p></strong></center>'+
                    '    <center><p style="margin-top: 30px;font-size: 16px;color:red;">请使用APP扫描二维码</p></center>',
                btn:['<i class="layui-icon" style="margin-right: 10px;">&#xe609</i>下载图片','打印','取消'],
                btn1:function(index) {
                    var img = $('#qrcode img');
                    var url = img[0].src;
                    var a = document.createElement('a');          // 创建一个a节点插入的document
                    var event = new MouseEvent('click')           // 模拟鼠标click点击事件
                    a.download = '二维码'                      // 设置a节点的download属性值
                    a.href = url;                                 // 将图片的src赋值给a节点的href
                    a.dispatchEvent(event)
                },
                btn2:function() {
                    window.print();
                }
            })
            const url = location.origin + '/eduFixAssets/cpfixAssetsInventoryH5?codeNo='+codeNo1;
            console.log(url)
            new QRCode(document.getElementById("qrcode"),{
                text:location.origin + '/eduFixAssets/cpfixAssetsInventoryH5?codeNo='+codeNo1,
                width: 300,
                height: 300
            })
        });


        //新增
        $('.add').on("click",function () {
            layer.open({
                type: 1 //Page层类型
                , area: ['600px', '470px']
                , title: '新建盘点'
                // , maxmin: true //允许全屏最小化
                , content: '<div class="layui-form">' +
                    '<div style="display: flex;margin-top:15px">' +
                    '  <div class="layui-form-item" style="width: 300px">\n' +
                    '    <label class="layui-form-label">盘点名称：</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" id="inventoryName" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '  </div>' +
                    ' <div class="layui-form-item" style="margin-top: 10px">' +
                    '  <label class="layui-form-label">所属分类：</label>' +
                    '<div class="layui-input-inline">' +
                    ' <select id="assetsType" lay-verify="required" lay-search="">' +
                    ' <option value="">请选择资产类别</option>' +
                    '  </select>' +
                    ' </div>' +
                    ' </div>' +
                    ' <div class="layui-form-item" style="margin-top:15px;" >' +
                    '  <label class="layui-form-label">当前领用用户：</label>' +
                    '<div class="layui-input-inline">' +
                    '<textarea  id="applyUser" style="min-height: 40px;width: 190px" user_id=" "   lay-verify="required" placeholder="请选择当前领用用户" class=" textarea exchange_user" disabled></textarea>' +
                    ' </div>' +
                    '<span  id="exchangeUserIds" class="add" style="color: blue;cursor:pointer">添加</span><br>\n' +
                    '<span  id="clearSendusers" class="add" style="color: red;cursor:pointer">清空</span  >' +
                    ' </div>' +
                    ' <div class="layui-form-item" style="margin-top: 10px">' +
                    '  <label class="layui-form-label">管理员：</label>' +
                    '<div class="layui-input-inline">' +
                    '<textarea  id="operator" style="min-height: 40px;width: 190px" user_id=" "   lay-verify="required" placeholder="请选择管理员" class=" textarea exchange_user" disabled></textarea>' +
                    ' </div>' +
                    '<span    id="exchangeUserId" class="add" style="color: blue;cursor:pointer">添加</span  ><br>\n' +
                    '<span   id="clearSenduser" class="add" style="color: red;cursor:pointer">清空</span  >' +
                    ' </div>' +
                    ' <div style="margin-top: 10px">' +
                    '  <label class="layui-form-label">登记时间：</label>' +
                    '   <div class="layui-input-inline">' +
                    '  <input type="text" class="layui-input" id="startAt" style="display: inline-block;width: 190px;"><span style="margin-left: 3px;margin-right: 3px">至</span><input type="text" class="layui-input" id="endAt" style="display: inline-block;width: 190px;">' +
                    '  </div>' +
                    '  </div>' +
                    '   <div class="layui-input-block" style="margin-left:37px">\n' +
                    '  </div>' +
                    '<div class="layui-input-block" style="margin-left:32px;width: 500px;">\n' +
                    '    </div>' +
                    '</div>'
                , btn: ['提交', '返回'],
                success: function (res) {
                    form.render()
                    laydate.render({
                        elem: '#startAt'
                        ,type: 'datetime'
                        ,trigger:'click'
                    })
                    laydate.render({
                        elem: '#endAt'
                        ,type: 'datetime'
                        ,trigger:'click'
                    });
                    $.ajax({
                        url: '/eduFixAssets/getAllFixAssetsType',
                        type: 'get',
                        dataType: 'json',
                        success: function (res) {
                            var data=res.object;
                            var str="";
                            for(var i=0;i<data.length;i++){
                                str+='<option value="'+data[i].typeId+'">'+data[i].typeName+'</option>';
                            }
                            $("#assetsType").append(str);
                            form.render();

                        }
                    });


                    $("#exchangeUserId").on("click",function(){//选管理员人员控件
                        user_id='operator';
                        $.popWindow("../common/selectUserIMAddGroup?0");
                    });
                    $('#clearSenduser').on("click",function(){
                        $('#operator').get(0).setAttribute('user_id', '');
                        $('#operator').val('');
                    });

                    $("#exchangeUserIds").on("click",function(){//选当前领用人员控件
                        user_id='applyUser';
                        $.popWindow("../common/selectUserIMAddGroup?0");
                    });
                    $('#clearSendusers').on("click",function(){
                        $('#applyUser').get(0).setAttribute('user_id', '');
                        $('#applyUser').val('');
                    });

                }

                , yes: function (index) {
                    var inventoryName = document.getElementById("inventoryName").value
                    var assetsType = document.getElementById("assetsType").value
                    var endAt = document.getElementById("endAt").value
                    var startAt = document.getElementById("startAt").value
                    var operator = document.getElementById("operator").value
                    var applyUser = $('#applyUser').get(0).getAttribute('user_id')
                    var operator = $('#operator').get(0).getAttribute('user_id')
                    if(inventoryName == ''){
                        $.layerMsg({content: '盘点名称不能为空！', icon: 2})
                        return false;
                    }else if(assetsType == ''){
                        $.layerMsg({content: '请选择所属分类！', icon: 2})
                        return false;
                    }else if(applyUser == ' '){
                        $.layerMsg({content: '请选择当前领用用户！', icon: 2})
                        return false;
                    }else if(operator == ' '){
                        $.layerMsg({content: '请选择管理员！', icon: 2})
                        return false;
                    }else if(startAt == ''){
                        $.layerMsg({content: '请选择开始时间！', icon: 2})
                        return false;
                    }else if(endAt == ''){
                        $.layerMsg({content: '请选择结束时间！', icon: 2})
                        return false;
                    }else {
                        $.ajax({
                            type: 'post',
                            url: '/eduFixAssets/fixAssetsInventory',
                            dataType: 'json',
                            data: {
                                inventoryName: inventoryName,
                                assetsType: assetsType,
                                operator: operator,
                                endAt: endAt,
                                startAt: startAt,
                                operator: operator,
                                applyUser: applyUser,

                            },
                            success: function (obj) {
                                if (obj.flag == true) {
                                    $.layerMsg({content: '新建成功！', icon: 1})
                                    internalTable.reload();
                                    layer.close(index);
                                    // window.location.reload()

                                } else {
                                    $.layerMsg({content: '新建失败！', icon: 2})
                                    return false;
                                    layer.close(index);
                                }
                                // window.location.reload()
                            }
                        })
                    }
                }
            });
        })


    });




</script>
</body>
</html>



