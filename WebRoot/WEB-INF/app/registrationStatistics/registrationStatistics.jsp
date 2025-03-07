<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<html>
<head>
    <title>考勤登记情况统计</title>
    <link rel="stylesheet" type="text/css" href="../css/easyui/easyui.css">
    <link rel="stylesheet" type="text/css" href="../css/easyui/icon.css">
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../js/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/easyui/easyui-lang-zh_CN.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <style>
        .input{
            width:100px;
            text-align: center;
        }
        .left{
            float:left;
        }
        .clearfix:after{
            display: block;
            clear:both;
            height:0;
            content: "";
        }
        .query{
            display: inline-block;
            width:60px;
            height:25px;
            color: #fff;
            background: #3079ed;
            text-align: center;
            font-size: 16px;
            line-height: 25px;
            cursor:pointer;
            position: relative;
            top:2px;
            margin-left:5px;
        }
        .line{
            height: 100%;
            width:1px;
            background: #000;
            float: left;
        }
    </style>

</head>
<body>
    <div class="count clearfix">
        <div class="left" style="width:18%;">
            <ul class="depository">

            </ul>
        </div>
        <div class="line"></div>
        <div class="left" style="width:80%;margin-left:10px;">
            <%--<div class="title">--%>
                <%--<input class="input" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" type="text"><span>至</span>--%>
                <%--<input class="input" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" type="text">--%>
                <%--<button class="query">查询</button>--%>
            <%--</div>--%>
           <table style="margin-top:20px;" id="table">
               <thead>
                    <tr>
                        <th>班级</th>
                        <th>班主任</th>
                        <th>需要考勤次数</th>
                        <th>已考勤次数</th>
                        <th>未考勤次数</th>
                    </tr>
               </thead>
               <tbody>

               </tbody>
           </table>
        </div>
    </div>
</body>
<script type="text/javascript">
    var type=0;
    var pro=0;
    var proId=0;
    $(function(){
        $.ajax({//学级展示
            type: 'post',
            url: "/eduLearnPhase/selEduLearnPhase",
            dataType: 'json',
            success: function (res) {
                var data = res.obj;
                var str = "";
                if (res.flag == true) {
                    if (data != undefined) {
                        for (var i = 0; i < data.length; i++) {
                            str += "<li class='depositoryId' depositoryId='" + data[i].id + "'>" +
                                "<div class='tree-node' node-id='" + data[i].id + "' style='cursor: pointer'>" +
                                "<span class='tree-hit tree-collapsed'></span>" +
                                "<span class='tree-icon tree-folder'></span>" +
                                "<span class='tree-title'>" + data[i].name + "</span>" +
                                "</div>" +
                                "<div style='margin-left: 20px;'>"+
                                "<ul class='proType' style='display: none'>" +
                                "</ul>" +
                                "</div>"+
                                "</li>";
                        }
                    }
                    $('.depository').html(str);
                }
            }
        })
        $(".depository").on('click','.depositoryId',function (e) {//年级展示
            e.stopPropagation();
            var that=$(this);
            if(type==0){
                //第二层
                $.ajax({
                    type:'post',
                    url:"/eduGrade/selectAll",
                    dataType:'json',
                    data:{
                        learnPhaseId:$(this).attr("depositoryId")
                    },
                    success:function(res) {
                        var data = res.obj;
                        var str = "";
                        if (res.flag == true) {
                            for (var i = 0; i < data.length; i++) {
                                str += "<li class='proTypeId'  proTypeId='" + data[i].id + "'>" +
                                    "<div class='tree-node' node-id='" + data[i].id + "' style='cursor: pointer'>" +
                                    "<span class='tree-hit tree-collapsed'></span>" +
                                    "<span class='tree-icon tree-folder'></span>" +
                                    "<span class='tree-title'>" + data[i].aliasName + "</span>" +
                                    "</div>" +
                                    "<div style='margin-left: 20px;'>"+
                                    "<ul class='pro' style='display: none'>" +
                                    "</ul>" +
                                    "</div>"+
                                    "</li>";
                            }
                            that.find('.proType').html(str);
                            that.find(".proType").show();
                            type=1;
                        }
                    }
                })
            }else{
                that.find(".proType").hide();
                type=0;
            }

        })

        $(".depository").on('click','.proTypeId',function (e) {//班级展示
            e.stopPropagation();
            var that=$(this);
            //第三层
            if(pro==0){
                $.ajax({
                    type:'post',
                    url:"/eduClass/selEduClass",
                    dataType:'json',
                    data:{
                        gradeId:that.attr("proTypeId")
                    },
                    success:function(res){
                        var data=res.obj;
                        var str="";
                        if(res.flag==true){
                            if(data!=undefined){
                                for(var i=0;i<data.length;i++){
                                    str+="<li class='proId' classId="+data[i].classId+">" +
                                        "<div class='tree-node'  style='cursor: pointer'>" +
                                        "<span class='tree-hit tree-collapsed'></span>"+
                                        "<span class='tree-icon tree-folder'></span>"+
                                        "<span class='tree-title'>"+data[i].name+"</span>"+
                                        "</div>" +
                                        "</li>";
                                }
                            }
                            that.find('.pro').html(str);
                            that.find(".pro").show();
                            pro=1;
                        }
                    }
                })
            }else{
                that.find(".pro").hide();
                pro=0;
            }
        })

        $(".depository").on('click','.proId',function (e) {//列表

            e.stopPropagation();
            $.ajax({
                url:'/eduAttend/CountAttend',
                type:'post',
                data:{className:$(this).attr('classId')},
                dataType:'json',
                success:function(res){
                    if(res.flag){
                        var data=res.obj;
                        var str='';
                        for(var i=0;i<data.length;i++){
                            str+='<tr>' +
                                    '<td>'+data[i].classCode+'</td>' +
                                    '<td>'+data[i].teacherName+'</td>' +
                                    '<td>'+data[i].needAttend+'</td>' +
                                    '<td>'+data[i].attendNum+'</td>' +
                                    '<td>'+data[i].noAtted+'</td>' +
                                '</tr>'
                        }
                        $('#table tbody').html(str)
                    }
                }
            })
        })

        $('#query').click(function(){
            $.ajax({
                url:'',
                type:'post',
                data:{

                },
                dataType:'json',
                success:function(res){
                    if(res.flag){
                        var data=res.obj;
                        var str='';
                        for(var i=0;i<data.length;i++){
                            str+='<tr>' +
                                '<td></td>' +
                                '<td></td>' +
                                '<td></td>' +
                                '<td></td>' +
                                '<td></td>' +
                                '</tr>'
                        }
                        $('#table tbody').html(str)
                    }
                }
            })
        })

    })
</script>
</html>
