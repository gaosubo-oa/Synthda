<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>仓库管理</title>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
<%--    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/laydate.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script language=javascript src='http://api.map.baidu.com/api?v=2.0&ak=7HSdUGqKaz5U0ph0LIQ2Qd4rFmFZA2kY'></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script src="../js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
    <style>
        .bx{
            width: 100%;
            height: 100%;
        }
        .head{
            height:45px;
        }
        .clearfix1 {
            border-bottom: 1px solid #9e9e9e;

            height: 36px;
        }
        .div_Img {
            float: left;
            margin-left: 14px;
        }
        .p1 {
            float: left;
            margin-bottom: 0;
            height: 32px;
            padding-left: 10px;
            font-size: 18px;
            line-height: 32px;

            color: #333;
        }
        .p2 {
            float: right;
            height: 40px;
            margin-top: 8px;
            margin-right: 25px;
        }
        .p2 span {
            font-size: 14px;
            background-color: #2b7fe0;
            padding: 4px 18px;
            border-radius: 3px;
            color: #fff;
            cursor: pointer;
        }
        .newpop .list_group {
            margin: 20px 0;
        }
        .list_group .toryList {
            display: inline-block;
            margin-right: 20px;
            width: 100px;
            height: 26px;
        }
        .list_group .save_w {
            width: 412px;
            height: 28px;
            border-radius: 3px;
        }
        .layui-card{
            width:95%;
            font-size:14px;
            box-shadow: 0px 1px 2px 1px rgba(0,0,0,0.08);
        }
        .layui-card-header{
            border-bottom: 1px solid #eee;
            text-align: right;
        }
        .layui-icon{
            font-size: 23px;
            cursor:pointer;
        }
        .icons{
            vertical-align: middle;
            font-size: 20px;
            display: inline-block;
            margin-top: 10px;
        }
        .searinp{
            height: 35px;
            line-height: 44px;
            width: 150px;
            border-top: none;
            border-left: none;
            border-right: none;
            margin-top: 8px;
        }
        .inpbg{
            border-bottom-color: #2F8AE3;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>

</head>

<body style="height: 100%">
<div class="bx">
    <div class="clearfix1">

        <input type="hidden" value="" id="module">
        <div class="div_Img">
            <img src="/img/xmgl.png" style="vertical-align: middle;" alt="菜单主分类设置">
        </div>
        <p class="p1">仓库管理</p>
        <div class="p2">
            <span class="new"><img style="margin-right: 3px;margin-left: -8px;margin-bottom: -2px;" src="../../img/newxinjian.png" alt="">新建</span>

        </div>
    </div>
    <div class="head w clearfix">
        <ul class="index_head">
            <li data_id="0" data-num="0"><span class="one headli1_1">地图</span><img class="headli1_2" src="../img/twoth.png" alt=""/></li>
            <li data_id="1" data-num="1"><span class="headli1_1">列表</span><img class="headli1_2" src="../img/twoth.png" alt=""/></li>
            <li style="float:right;margin-right: -74px;"><input type="text" placeholder="仓库搜索" class="searinp"><i class="layui-icon layui-icon-search icons"></i></li>
        </ul>
    </div>
    <div class="mainCon">
        <div class="divIframeOne iframeShow" style="width: 100%;height: 100%;display: block;">
            <div id="map" style="width:100%;height:100%"></div>
        </div>
        <div class="divIframeTwo iframeShow" style="width: 100%;height: 100%;display: none;">
            <div id="con" style="width:100%;height:100%">
                <div class="layui-container" style="width:100%">
                    <div class="layui-row list">



                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<script type="text/javascript">
    var searchInp =""
    var map = new BMap.Map("map");
    var point = new BMap.Point(116.404, 39.915);
    map.centerAndZoom(point,8);
    map.enableScrollWheelZoom();    //启用滚轮放大缩小，默认禁用
    map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用
    var localSearch = new BMap.LocalSearch(map);
    localSearch.enableAutoViewport(); //允许自动调节窗体大小
    // 编写自定义函数,创建标注
    function addMarker(point,id,con){
        var marker = new BMap.Marker(point);

        // var label = new BMap.Label(con,{offset:new BMap.Size(20,-10)});
        // marker.setLabel(label);
        map.addOverlay(marker);
    }
    // 百度地图API功能
    function getPoint(address){

        for(var i=0;i<address.length;i++){
            var keyword = address[i].address;
            (function(){
                var id = address[i].id;
                var con = address[i].content;
                localSearch.setSearchCompleteCallback(function (searchResult) {
                    var poi = searchResult.getPoi(0);
                    var point = new BMap.Point(poi.point.lng, poi.point.lat);
                    addMarker(point,id,con);
                });
                localSearch.search(keyword);
            }(address[i]))

        }

    }

    function list(searchInp){
        $.ajax({
            url:'/invWarehouse/selectInvInfo',
            type:'get',
            data:{warehouseName:searchInp},
            dataType:'json',
            success:function(res){
                var str='';
                var address=[];
                for(var i=0;i<res.obj.length;i++){
                    var data={id:res.obj[i].warehouseId,address:res.obj[i].province+res.obj[i].city+res.obj[i].warehouseAdress,content:res.obj[i].warehouseName}
                    address.push(data)
                    str += ' <div class="layui-col-xs6 layui-col-sm6 layui-col-md4">\n' +
                        '                            <div class="layui-card">\n' +
                        '                                <div class="layui-card-header" id="'+res.obj[i].warehouseId+'">\n' +
                        '                                    <i class="layui-icon edit">&#xe642;</i>\n' +
                        '                                    <i class="layui-icon del">&#x1006;</i>\n' +
                        '                                </div>\n' +
                        '                                <div class="layui-card-body">\n' +
                        '                                    <div class="layui-row ">\n' +
                        '                                        <label class="layui-col-xs3 layui-col-sm3 layui-col-md3">仓库编号</label>\n' +
                        '                                        <div class="layui-col-xs3 layui-col-sm3 layui-col-md3">'+empty(res.obj[i].warehouseNo)+'</div>\n' +
                        '                                        <label class="layui-col-xs3 layui-col-sm3 layui-col-md3">仓库名称</label>\n' +
                        '                                        <div class="layui-col-xs3 layui-col-sm3 layui-col-md3">'+empty(res.obj[i].warehouseName)+'</div>\n' +
                        '                                    </div>\n' +
                        '                                    <div class="layui-row ">\n' +
                        '                                        <label class="layui-col-xs3 layui-col-sm3 layui-col-md3">仓库联系人</label>\n' +
                        '                                        <div class="layui-col-xs3 layui-col-sm3 layui-col-md3">'+empty(res.obj[i].warehousePerson)+'</div>\n' +
                        '                                        <label class="layui-col-xs3 layui-col-sm3 layui-col-md3">联系人电话</label>\n' +
                        '                                        <div class="layui-col-xs3 layui-col-sm3 layui-col-md3">'+empty(res.obj[i].warehousePhone)+'</div>\n' +
                        '                                    </div>\n' +
                        '                                    <div class="layui-row ">\n' +
                        '                                        <label class="layui-col-xs3 layui-col-sm3 layui-col-md3">所属省市</label>\n' +
                        '                                        <div class="layui-col-xs9 layui-col-sm9 layui-col-md9">'+empty(res.obj[i].province)+'-'+empty(res.obj[i].city)+'</div>\n' +
                        '                                    </div>\n' +
                        '                                    <div class="layui-row ">\n' +
                        '                                        <label class="layui-col-xs3 layui-col-sm3 layui-col-md3">仓库地址</label>\n' +
                        '                                        <div class="layui-col-xs9 layui-col-sm9 layui-col-md9">'+empty(res.obj[i].warehouseAdress)+'</div>\n' +
                        '                                    </div>\n' +
                        '                                    <div class="layui-row ">\n' +
                        '                                        <label class="layui-col-xs3 layui-col-sm3 layui-col-md3">备注</label>\n' +
                        '                                        <div class="layui-col-xs9 layui-col-sm9 layui-col-md9">'+empty(res.obj[i].warehouseRemarks)+'</div>\n' +
                        '                                    </div>\n' +
                        '                                </div>\n' +
                        '                            </div>\n' +
                        '                        </div>'
                }
                $('.list').html(str)
                getPoint(address);
            }
        })
    }
    list()

    function create(type,id){
        if(type == 0){
            var title = '新建'
        }else{
            var title = '编辑'
        }
        layer.open({
            type : 1,
            title: title,
            area: ['50%','50%'],
            offset:'200px auto',
            // area:['550px','350px'],
            content: '<div class="newpop" style="margin-left: 140px">' +
                '<div class="list_group">' +
                '<label for="sortNum" class="toryList">仓库名称:</label>' +
                '<input type="text" id="warehouseName" class="save_w"></div>' +
                '<div class="list_group"><label for="catalog" class="toryList">仓库联系人:</label>' +
                '<input type="text" id="warehousePerson" class="save_w"></div>' +
                '<div class="list_group"><label for="path" class="toryList">联系人电话:</label>' +
                '<input type="text" id="warehousePhone" class="save_w">' +
                '</div>' +

                '<div class="list_group">' +
                '<label for="defaultSort" class="toryList">所属省市 :</label>' +
                '<select name="province" style="width:200px;border-radius: 3px" id="province" class="province">'+
                '</select>' +
                '<select name="city" style="width:200px;border-radius: 3px;margin-left: 10px" id="city" class="city">' +
                '</select></div>'+
                '<div class="list_group"><label for="maxcap" class="toryList"> 仓库地址:</label>' +
                '<input type="text" id="warehouseAdress" class="save_w" value=""></div>' +
                '<div class="list_group"><label for="maxcap" class="toryList"> 备注:</label>' +
                '<textarea name="warehouseRemarks" id="warehouseRemarks" style="width: 412px;height: 50px;vertical-align: middle;border-radius: 3px" cols="30" rows="10"></textarea></div>' +
                '</div>',

            btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="notice.th.return" />'],
            // scrolling: 'no',
            yes: function () {
                var data = {
                    warehouseName: $('#warehouseName').val(),
                    warehousePerson: $('#warehousePerson').val(),
                    warehousePhone: $('#warehousePhone').val(),
                    province: $('#province').val(),
                    city: $('#city').val(),
                    warehouseAdress: $('#warehouseAdress').val(),
                    warehouseRemarks: $('#warehouseRemarks').val()
                }
                if(type == 0){
                    var url = '/invWarehouse/insertInvHouse'
                }else{
                    var url = '/invWarehouse/updateInvHouse'
                    data.warehouseId = id;
                }
                $.ajax({
                    url: url,
                    type: 'get',
                    dataType: 'json',
                    data: data,
                    success: function (data) {
                        if (data.flag) {
                            layer.msg('保存成功', {icon: 6})
                            window.location.reload();
                            list();
                        }else {
                            $.layerMsg({content:'保存失败',icon:2});
                        }

                    }
                })

            },success:function(){
                var sheng = '<option value="">请选择</option>'
                for(var i=0;i<json.provinces.length;i++){
                    sheng += '<option value="'+json.provinces[i].name+'">'+json.provinces[i].name+'</option>'
                }
                $('#province').html(sheng);
                $('#province').on('change',function(){
                    var prov = $(this).val();
                    var citys = '<option value="">请选择</option>'
                    for(var i=0;i<json.provinces.length;i++){
                        if(json.provinces[i].name == prov){

                            if(json.provinces[i].citys!=""&&json.provinces[i].citys!=undefined){
                                for(var j=0;j<json.provinces[i].citys.length;j++){
                                    citys += '<option value="'+json.provinces[i].citys[j]+'">'+json.provinces[i].citys[j]+'</option>'
                                }
                            }
                        }
                    }
                    $('#city').html(citys);
                })
                if(type == 1){
                    $.ajax({
                        url:'/invWarehouse/selectInvById',
                        data:{warehouseId:id},
                        dataType:'json',
                        type:'get',
                        success:function(res){
                            $('#warehouseName').val(res.object.warehouseName);
                            $('#warehousePerson').val(res.object.warehousePerson),
                                $('#warehousePhone').val(res.object.warehousePhone),
                                $('#province').val(res.object.province),
                                $('#province').trigger('change')
                            $('#city').val(res.object.city),
                                $('#warehouseAdress').val(res.object.warehouseAdress),
                                $('#warehouseRemarks').val(res.object.warehouseRemarks)
                        }
                    })
                }
            }
        })
    }
    $(function(){
        $('.mainCon').height($('.bx').height() - $('.head').height() - 3-$('.clearfix1').height())
    })
        $('.index_head li').on('click',function(){
            var ind=$(this).index();
            $(this).find('span').addClass('one').end().siblings().find('span').removeClass('one');
            $('.mainCon').find('.iframeShow').eq(ind).show().siblings().hide();
        })
        $('.new').on('click',function(){
            create(0)
        })
        $(document).on('click','.edit',function(){
            var id = $(this).parent().attr('id');
            create(1,id)
        })
        $(document).on('click','.del',function(){
            var id = $(this).parent().attr('id');
            layer.confirm('确定删除该条数据吗？', {
                btn: ['确定','取消'], //按钮
                title:"删除",
                offset:'300px'
            }, function(){
                //确定删除，调接口
                $.ajax({
                    type:'post',
                    url:'/invWarehouse/deleteInvById',
                    dataType:'json',
                    data:{
                        warehouseId:id
                    },
                    success:function(res){
                        if(res.flag){
                            layer.msg('删除成功！', { icon:6});
//                        ajaxPage.page();
                            window.location.reload();
                        }else {
                            layer.msg('删除失败！', { icon:5});
                        }

                    }
                })

            }, function(){
                layer.closeAll();
            });
        })


    $('.searinp').on('click',function () {
       $('.searinp').css('border-bottom-color','#2F8AE3')
    })
    $('.icons').on('click',function(){
        map.clearOverlays();
        searchInp = $('.searinp').val()
        list(searchInp)
    })
    //判断返回是否为空
    function empty(esName) {
        if (esName==undefined ||esName==''){
            return ''
        }else{
            return esName
        }
    }
</script>
</body>
</html>
