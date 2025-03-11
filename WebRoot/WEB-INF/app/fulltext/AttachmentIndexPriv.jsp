<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<html style="overflow-y: scroll">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>全文索引模块</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.config.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js?20201221.1" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js?20201221.1" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <script type="text/javascript" src="/js/echarts.min.js"></script>
</head>
<style>
body {
    background-color: #fff;
}
    #box .layui-from {
        width: 100%;
    }
    .layui-table-page>div{
        float: right;
    }
    .layui-table-body{overflow-x: hidden;}
    #box .layui-table {
        width: 90%;
        margin: 0 auto;
    }

    .asd {
        font-weight: bold;
        font-size: 18px;
        margin-left: 30px;
    }

    .zxc {
        font-weight: bold;
        font-size: 18px;
        margin-left: 30px;
    }

    .evaluation span {
        font-weight: bold;
        font-size: 18px;
        margin-left: 55px;
    }

    #box button {
        right: -14px;
        z-index: 999;
        top:77px
    }
    #btn{
        margin-right: 35px;
        position: absolute;
        right: 30px;
        z-index: 999;
        top:77px
    }
    #from {
        width: 100%;
        margin: 0 auto;
        padding-top: 20px;
    }

    #from .new {
        font-weight: bold;
        font-size: 18px;
        margin-left: 30px;
    }

    .people {
        width: 100%;
        overflow: hidden;
        margin-bottom: 15px;
    }

    .people1 {
        width: 44%;
        float: left;
        overflow: hidden;
    }

    .people2 {
        float: right;
        overflow: hidden;
        margin-right: 61px;
    }

    .tbtn {
        text-align: center;
    }
    .layui-form-checkbox i{
        border-left: 1px solid #d2d2d2!important;
    }
    /*.layui-form-item .layui-form-checkbox{*/
    /*    width: 220px!important;*/
    /*}*/
    .layui-form-checkbox{
        display: inline-block!important;
    }
    .tbtn button {
        margin-bottom: 20px;
        width: 100px;
    }

    .annex {
        font-size: 14px;
        margin-left: 30px;
    }

    #test3 {
        margin-left: 68px;
    }

    .layui-form-label {
        width: 100%;
        margin-top: 20px;
    }

    .layui-table-view .layui-form-checkbox[lay-skin=primary] i {
        margin-top: 5px;
    }

    .layui-form {
        margin-left: 10px;
        margin-top: 20px;
        display: block;
        margin-right: 10px;
    }

    .layui-table-cell laytable-cell-1-0-5 {
        width: 268px;
    }

    /*.layui-table-page{*/
    /*    width: 1054px;*/
    /*}*/
    .layui-laypage-btn{
        display: none;
    }
    .layui-box layui-laypage layui-laypage-default{
        margin-left: 1060px;
    }
    .thHeight1 td {
        height: 80px;
    }

    .thHeight2 td {
        height: 120px;
        letter-spacing: 7px;
    }

    a {
        cursor: hand;
    }

    .evaluation {
        width: 800px;
        padding-top: 10px;
    }

    tr {
        text-align: center;
    }

    td {
        text-align: center;
    }

    #asd {
        width: 10px;
    }

    .layui-table td, .layui-table th {
        padding: 10px 9px;
    }

    .layui-form-checkbox {
        display: none;
    }

    .layui-table-view .layui-table td, .layui-table-view .layui-table th {
        text-align: center;
    }

    .layui-table-tool {
        display: none;
    }
    /*.layui-unselect{*/
    /*    width: 300px;*/
    /*}*/
    .layui-input{
        width: 300px;
    }
    .box1 {
        overflow: hidden;
        margin-left: 55px;
        margin-bottom: 50px;
    }

    .top1 {
        width: 199px;
        height: 39px;
        background-color: rgb(204 204 204);
        display: block;
        font-weight: bold;
        font-size: 18px;
        float: left;
        text-align: center;
        line-height: 39px;
        border: 1px solid rgba(121, 121, 121, 1);
    }

    .top2 {
        width: 228px;
        height: 39px;
        background-color: rgba(121, 121, 121, 1);
        display: block;
        font-weight: bold;
        font-size: 18px;
        float: left;
        text-align: center;
        line-height: 39px;
    }

    #meeting {
        width: 84px;
    }

    #textarea {
        width: 73%;
        height: 100px;
    }

    #party {
        float: right;
        position: absolute;
        left: 1000px;
        top: 75px;
    }

    #year {
        float: right;
        position: absolute;
        left: 1320px;
        top: 75px;
    }
    .layui-tab-content{
        margin-top: 20px;
    }
    .laytable-cell-1-0-6{
        maxWidth: 220px;

    }
    .layui-tab-title li{
        font-size: 20px!important;
    }
    .niuma{
        width: 1000px;
        position: relative;
    }
    .layui-form-radio{
        width: 50px!important;
    }
    .layui-input-block{
        margin-left: 0px!important;
        margin-top: 30px;
    }
    .layui-nav {
        background-color: #fff;
        color: #000;
        border-right: 1px solid #ccc;
    }
   .layui-nav-itemed>a {
       text-align: left !important;
    color: #000 !important;
}
.layui-nav-itemed>a:hover {
    color: #fff !important;
}
    .active {
        background-color: #c7e1ff;
        color: #fff;
    }
.layui-nav-tree .layui-nav-item a:hover {
    background-color: #c7e1ff;
}
</style>
<body>
<div id="box" style="display: block">

    <div class="box2">
    </div>
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <ul class="layui-tab-title">
            <li class="layui-this" id="shan1" style="font-size: 18px">全文检索设置</li>
            <li id="shan2"  style="font-size: 18px">全局检索权限设置 </li>
        </ul>

        <div class="layui-tab-content">

            <div class="layui-tab-item layui-show ">

                <div style="float: left;">
                    <span class="zxc">参数设置</span>
                </div>
                <div style="float: right;margin-right: 50px">
                    <button type="button" class="layui-btn" id="save" lay-event="search">保存参数设置</button>
                    <button class="layui-btn aginBtn">重新索引无效文件</button>
                </div>
                <form class="layui-form" lay-filter="test1" action="">
                    <div>
                            <div style="display: flex;width: 100%">
                                <div style="width: 20%;text-align: right"><label class="layui-form-label" style="float: right;">开启文件索引</label></div>
                                <div style="width: 70%;">
                                    <div class="layui-input-block" style=" margin-top: 20px!important;" >
                                        <input type="radio" name="alldocIndexYn" value="1" title="是">
                                        <input type="radio" name="alldocIndexYn" value="0" title="否" >
                                    </div>
                                </div>
                            </div>
<%--                        <div style="display: flex;width: 100%">--%>
<%--                            <div style="width: 20%;text-align: right"><label class="layui-form-label" style="float: right;">文件索引生成时间</label></div>--%>
<%--                            <div style="width: 70%;display: flex">--%>
<%--                                <div class="layui-input-inline">--%>
<%--                                    <input  style="width: 300px;margin-top: 20px" id="beginTime" placeholder="请选择生成时间" onclick="laydate({istime: true, format: 'hh:mm:ss'})" name="beginTime" class="layui-input" type="text">--%>
<%--                                </div>--%>
<%--                                &nbsp<p style="margin-top: 27px">—</p>&nbsp--%>
<%--                                <div class="layui-input-inline">--%>
<%--                                    <input  style="width: 300px;margin-top: 20px" id="endTime" placeholder="请选择结束时间" onclick="laydate({istime: true, format: 'hh:mm:ss'})" name="endTime" class="layui-input" type="text">--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
                        <div style="display: flex;width: 100%">
                            <div style="width: 20%;text-align: right"><label class="layui-form-label" style="float: right;">每次生成索引的文件个数</label></div>
                            <div style="width: 70%">
                                <div class="layui-input-inline">
                                    <input  style="width: 300px;margin-top: 20px" id="alldocIndexFileNum" name="alldocIndexFileNum" class="layui-input" type="text">
                                </div>
                            </div>
                        </div>

                        <div  style="display: flex;width: 100%">
                            <div style="width: 20%;text-align: right">
                                <label class="layui-form-label" style="float: right;">索引文件类型</label>
                            </div>
                            <div style="width: 70%">
                                <div class="layui-form-item" lay-filter="alldocIndexFileType" >
                                    <div class="layui-input-block">
                                        <input type="checkbox" name="wordIndex" title="Word文件(doc,docx)"  />
                                        <input type="checkbox" name="excleIndex" title="Excel文件(xls,xlsx)"  />
                                        <input type="checkbox" name="pptIndex" title="Powerpoint(ppt,pptx)"  />
                                        <input type="checkbox" name="pdfIndex" title="pdf文件" />
                                        <input type="checkbox" name="htmlIndex" title="HTML文件(html)"  />
                                        <input type="checkbox" name="txtIndex" title="TXT文件(txt)"  />
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </form>
                <div class="zxc">
                    <span>文件索引生成进度条</span>
                </div>
                <form class="layui-form" action="">
                    <div>
                        <div style="display: flex;width: 100%">
                            <div style="width: 20%;text-align: right"><label class="layui-form-label" style="float: right;">文件总数</label></div>
                            <div style="width: 70%">
                                <div class="layui-input-block">
                                    <p id="attachAll"></p>
                                </div>
                            </div>
                        </div>
                        <div style="display: flex;width: 100%">
                            <div style="width: 20%;text-align: right"><label class="layui-form-label" style="float: right;">已索引文件数</label></div>
                            <div style="width: 70%">
                                <div class="layui-input-block">
                                    <p id="attachIndex"></p>
                                </div>
                            </div>
                        </div>
                        <div style="display: flex;width: 100%">
                            <div style="width: 20%;text-align: right"><label class="layui-form-label" style="float: right;">进度条</label></div>
                            <div style="width: 300px;    margin-top: 20px;">
                                    <div style="display: flex">
                                        <p id="percentage" style="width: 150px;text-align: center"></p>
                                        <p id="percentage0" style="width: 150px;text-align: center"></p>
                                    </div>
                                    <div style="width: 300px;border: 1px solid #59bdf0;
    border-radius: 15px;
    border-color: gray;margin-top: -1px"><div id="percentage1" style="height: 9px;background-color: #0088cc;border-radius: 15px;"></div></div>
                            </div>
                        </div>
                    </div></form>

<%--                统计图--%>
                 <div style="display: flex;justify-content: space-around;margin-top: 20px">
                     <div id="ehart-round" style="width: 600px;height: 600px;">

                     </div>
                     <div id="ehart-pie" style="width: 600px;height: 500px;">
                     </div>
                 </div>


            </div>



            <div class="layui-tab-item two">
                <div style="display: flex">
                    <span class="asd">全文检索模块</span>
                    <span class="asd" style="margin-left: 20%"><span id="title">电子邮件</span>全局检索权限</span>
                </div>

                <div style="display: flex;height: 100%">
                <div id="left" style="margin-top: 20px;height: 80%;width: 20%;overflow-y: scroll;">
                    <ul id="lefton" class="layui-nav layui-nav-tree layui-inline" style="margin-right: 10px;margin-left: 26px">

                    </ul>
                </div>
                <div id="right" style="width: 80%;height: 80%">
                    <iframe src="/attachPriv/AttachmentIndexIframe" id="iframeEmailList" frameborder="0" style="width: 100%;height: 100%;min-width: 918px;"></iframe>
                </div>
                </div>

            </div>
        </div>
    </div>

</div>


</table>
</body>
<script>
$(".aginBtn").click(function() {
    layer.confirm("是否重新索引无效文件",{icon:0},function(index) {
        $.ajax({
            url:"/attachPriv/resetting",
            success:function(res){
                if(res.flag) {
                    layer.msg("索引成功",{icon:1})
                }else {
                    layer.msg("索引失败",{icon:2})
                }
                layer.close(index)
            }
        })
    })

})
$("#lefton").on("click",'li',function() {
    $(this).siblings().removeClass("active")
    $(this).addClass("active");
})
    function onclick1(i,dom){
        $('#iframeEmailList').attr('src', '/attachPriv/AttachmentIndexIframe?x='+i);
    }
    layui.use(['form', 'table', 'element', 'layedit','eleTree'], function () {
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var layedit = layui.layedit
        var eleTree = layui.eleTree;
        form.render();
        form.on('checkbox(alldocIndexFileType)', function(data){
            if (data.elem.checked){
                splitday.push(data.value);
            }else {
                deleteItem(data.value,splitday);
            }
        });
        $.ajax({
            url:'/attachPriv/selectAttach',
            type:'post',
            dataType:'json',
            data:{
            },
            success:function(res){
                console.log(res,'res')
                //索引的文件
                var totalIndex =  res.object.attachIndex.indexCount;
                var totalAll =  res.object.attachAll.allcount;
                var unSy = totalAll - totalIndex;
                var attachIndex =  res.object.attachIndex;
                let obj2 = Object.entries(attachIndex).filter(function(it) {return it[0] != "indexCount"});
                obj2 = obj2.map(function(it) {
                    return {
                        name:it[0],
                        value:it[1]
                    }
                })
                const obj = [
                    {
                        name:"已索引",
                        value: totalIndex,
                    },
                    {
                        name: "未索引",
                        value: unSy,
                    }
                ]
                renderEahcrt(obj,document.getElementById("ehart-round"))
                renderEchartTwo(obj2,document.getElementById("ehart-pie"))
                $("input[name='alldocIndexYn']").each(function () {
                    var str = $(this).val();
                    if (str == res.object.alldocIndexYn) {
                        $(this).attr("checked", true);
                    }
                });
                if(res.object.wordIndex==1){
                    $("input[name='wordIndex']").attr("checked", true);
                }
                if(res.object.excleIndex==1){
                    $("input[name='excleIndex']").attr("checked", true);
                }
                if(res.object.pptIndex==1){
                    $("input[name='pptIndex']").attr("checked", true);
                }
                if(res.object.pdfIndex==1){
                    $("input[name='pdfIndex']").attr("checked", true);
                }
                if(res.object.htmlIndex==1){
                    $("input[name='htmlIndex']").attr("checked", true);
                }if(res.object.txtIndex==1){
                    $("input[name='txtIndex']").attr("checked", true);
                }
                $('#beginTime').val(res.object.beginTime);
                $('#endTime').val(res.object.endTime);
                $('#alldocIndexFileNum').val(res.object.alldocIndexFileNum);
                $('#attachAll').text(res.object.attachAll.allcount);
                $('#attachIndex').text(res.object.attachIndex.indexCount);
                var percentage=res.object.percentage
                var percentage2=percentage+'%'
                $('#percentage').text(percentage2);

                if(percentage!=0){
                    var percentage0=100-percentage
                    $('#percentage0').text(percentage0+'%');
                }

                $('#percentage1').css('width',percentage+'%');
                form.render()
            }
        })
        function renderEahcrt(data,dom,radius,minAngle) {
            data = data.filter(function(it) {
                return it.name != "indexCount"
            })
            var myChart = echarts.init(dom);
            myChart.showLoading();
            var option = {
                title: {
                    text: '所有文件索引生成进度',
                    left:"center",
                    top:50,
                    textStyle:{
                        color:"green"
                    }
                },
                color:['green','red'],
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    marginRight: '10px',
                },
                series: [
                    {
                        name: '文件类型',
                        type: 'pie',
                        minAngle:(minAngle || ""),
                        radius: (radius || '50%'),
                        data:data,
                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };
            myChart.setOption(option)
            myChart.hideLoading();
        }
        function renderEchartTwo(data,dom) {
            var names = data.map(function(it) {
                return it.name
            })
            var values = data.map(function(it) {
                return it.value
            })
            console.log(names)
            console.log(values)
            var myChart = echarts.init(dom);
            myChart.showLoading();
            option = {
                title: {
                    text: '各应用模块文件索引生成进度',
                    left:"center",
                    textStyle: {
                        color:"green"
                    }
                },
                tooltip: {
                    trigger: "axis"
                },
                xAxis: {
                    type: 'category',
                    data: names,
                    axisLabel: {
                        interval:0
                    }
                },
                color:['green'],
                yAxis: {
                    type: 'value'
                },
                series: [
                    {
                        name:"检索文件",
                        data: values,
                        type: 'bar',
                        showBackground: true,
                        backgroundStyle: {
                            color: 'rgba(180, 180, 180, 0.2)'
                        }
                    }
                ]
            };
            myChart.setOption(option)
            myChart.hideLoading();
        }
        var str=''
        $.ajax({
            url: '/attachPriv/selectAll',
            type: 'post',
            dataType: 'json',
            data: {},
            success: function (res) {
                for (i = 0; i < res.obj.length; i++) {
                    str += ' <li class="layui-nav-item layui-nav-itemed selLi">\n' +
                        '                        <a class="tex" onclick="onclick1('+res.obj[i].moduleId+')" value="'+res.obj[i].moduleId+'" style="text-align: center;height: 50px;" href="javascript:;">'+res.obj[i].moduleName+'</a>\n' +
                        '                        </li>'

                }
                $("#lefton").append(str);
                $('.tex[value='+ res.obj[0].moduleId +']').click();
            }
        })

$('#lefton').on('click','li',function() {
    $('#title').text($(this).find('a').text())
})
        var wordIndex
        var pdfIndex
        var excleIndex
        var pptIndex
        var htmlIndex
        var txtIndex
        $('#save').click(function () {
            var alldocIndexYn=$('input[name="alldocIndexYn"]:checked').val()
            if($('input[name="wordIndex"]').is(':checked')==true){
                wordIndex=1
            }else{
                wordIndex=0
            }
            if($('input[name="pdfIndex"]').is(':checked')==true){
                pdfIndex=1
            }else{
                 pdfIndex=0
            }
            if($('input[name="excleIndex"]').is(':checked')==true){
                 excleIndex=1
            }else{
                excleIndex=0
            }
            if($('input[name="pptIndex"]').is(':checked')==true){
                 pptIndex=1
            }else{
                 pptIndex=0
            }
            if($('input[name="htmlIndex"]').is(':checked')==true){
                 htmlIndex=1
            }else{
                 htmlIndex=0
            }
            if($('input[name="txtIndex"]').is(':checked')==true){
                 txtIndex=1
            }else{
                 txtIndex=0
            }
            var beginTime=$("#beginTime").val()
            var endTime=$("#endTime").val()
            var alldocIndexFileNum=$("#alldocIndexFileNum").val()

            $.ajax({
                url:'/attachPriv/AttachUpdate',
                type:'post',
                dataType:'json',
                data:{
                    wordIndex:wordIndex,
                    excleIndex:excleIndex,
                    pptIndex:pptIndex,
                    pdfIndex:pdfIndex,
                    htmlIndex:htmlIndex,
                    txtIndex:txtIndex,
                    alldocIndexYn:alldocIndexYn,
                    // beginTime:beginTime,
                    // endTime:endTime,
                    alldocIndexFileNum:alldocIndexFileNum
                },
                success:function(res){
                    if(res.flag){
                        layer.msg('保存成功！', {icon: 1,time:1000}, function () {
                      location.reload();
                        })
                    }else{
                        layer.msg('保存失败！', {icon: 0,time:1000}, function () {

                        })
                    }
                }
            })
        })
        table.on('tool(test1)', function (obj) {
            data = obj.data;
            var data = obj.data;
            var dataObj = obj.data;
            var layEvent = obj.event;


        });
    });
</script>
</html>

