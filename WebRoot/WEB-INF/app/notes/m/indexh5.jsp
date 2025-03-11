<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <meta charset="UTF-8">
    <title><fmt:message code="url.th.Note" /></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>
    <link rel="stylesheet" href="../css/notes/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/notes/base.css">
    <link rel="stylesheet" type="text/css" href="../css/notes/note.css">
    <script type="text/javascript" src="../js/notes/jquery-2.1.2.min.js"></script>
    <script type="text/javascript" src="../js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="../js/notes/base.js"></script>
    <script type="text/javascript" src="../js/notes/note.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <style type="text/css">

        .content{    width: 100%;margin: 20px auto;position: absolute;top: 44px;right: 0;bottom: 10px;overflow: auto;}
        .dingbu{height :45px;border-bottom: 1px solid #999;}
        .dingbu .headImg {
            float: left;
            width: 23px;
            height: 100%;
            margin-left: 30px;
        }
        html,body{
            overflow:hidden;
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
        .btn_sps{
            color: rgb(255, 255, 255);
            font-size: 14px;
            line-height: 28px;
            background: url(../../img/file/cabinet01.png) no-repeat;
        }
        .jzgd{
            margin: 0px 0px 0px;
        }
        .yuan{
            float: none!important;
            display: inline-block!important;
        }
        .content{
            text-align: left;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <script  type="text/javascript">

        //初始化显示页面

        function clicked(){
            layer.msg('<fmt:message code="global.lang.doing" />', {icon: 6});
        }

        function onl_d(){
            var data = {
                page:1,
                pageSize:15,
                useFlag:true
            }
            $.ajax({
                'url':'/Notes/selectNotes',
                'type':'get',
                'dataType':'json',
                'data':data,
                success:function(rsp){
                    if(rsp.obj.length != 0){
                        var length=rsp.obj.length;
                        var divstr='';
                        for(var i=0;i<length;i++){
                            var color=rsp.obj[i].color;
                            var colorol;
                            if(color==0){colorol="#c8abad"};
                            if(color==1){colorol="#b2f2b4"};
                            if(color==2){colorol="#b2dffe"};
                            if(color==3){colorol="#f9f293"};
                            if(color==4){colorol="#d7dcdc"};
                            if(color==5){colorol="#f57474"};
                            var content=rsp.obj[i].content;
                            var uid=rsp.obj[i].uid;
                            var noteId = rsp.obj[i].noteId;
                            var timeStamp=rsp.obj[i].editTime;
                            var time = new Date(timeStamp * 1000);
                            var year=time.getFullYear();//年
                            var month=time.getMonth()+1;//月
                            var date=time.getDate();//日
                            var hour=time.getHours(); //时
                            var minu=time.getMinutes(); //分
                            var conds=time.getSeconds(); //秒
                            var new_months;
                            var new_dates;
                            var new_hours;
                            var new_minus;
                            var new_condss;
                            if(month<10){
                                new_months="0"+month
                            }else{
                                new_months=month;
                            }
                            if(date<10){
                                new_dates="0"+date
                            }else{
                                new_dates=date;
                            }
                            if(minu<10){
                                new_minus="0"+minu
                            }else{
                                new_minus=minu;
                            }
                            if(hour<10){
                                new_hours="0"+hour;
                            }else{
                                new_hours=hour;
                            }
                            if(conds<10){
                                new_condss="0"+conds;
                            }else{
                                new_condss=conds;
                            }
                            var str_time=year+"-"+new_months+"-"+new_dates;
                            var str_hour=new_hours+":"+new_minus+":"+new_condss;
                            var new_time = str_time+'       '+str_hour;


                            divstr +="<div class='yuan yuan"+noteId+"' style='margin:10px 12px;height:200px;width:200px;left:8px;background-color:"+colorol+";float:left'>" +
                                "<div style='background-color: #000;width: 100%;height: 44px;position: absolute;top: 0;left: 0;opacity: 0.3;border-top-left-radius: 15px;border-top-right-radius: 15px;'>" +
                                "</div>" +
                                "<p style='position: relative;margin-top: 22px;left: 28px'>" +
                                "<span class='title_time'>"+new_time+"</span>" +
                                "<span class='title_hms'style='display: none'>"+str_hour+"</span></p>" +
                                "<textarea style='padding: 16px 6px;background-color:"+colorol+";margin-top: 12px;margin-left: 12px;' class='contents' style='width:90%;margin:0 auto'>"+content+"</textarea>" +
                                "<span class='span_bj' onclick='redact(this)' ><img src='../img/notes/gos_xxx.png' class='span_remove' onclick='removes(this)' ></span></div>"
                        }

                        $(".content").html(divstr);

                        gon_hover();
                    }else{
                        $('.tishi').css("display","block");
                    }



                }
            });
        }


        var colorb;
        $(document).ready(function(){
            $('.bs-example-modal-sm').on('show.bs.modal', function () {
                var arr = ["c8abad","b2f2b4","b2dffe","f9f293","d7dcdc","f57474"];
                var index = Math.floor((Math.random()*arr.length));
                $(".new_con").css("background-color","#"+arr[index]+"");
                $(".new_con").find(".new_content").css("background-color","#"+arr[index]+"");

                $(".new_content").val("");
                $(".new_con").show();
                $(".btn_1").show();
                $(".btn_9").hide();

                setTimeout(function(){
                    $(".new_content").focus();
                },1000);
            });//莫泰对话框弹出
            $('.bs-example-modal-sm').on('hidde.bs.modal', function () {

                //alert(1);
            });//莫泰对话框关闭

            $("#but_ns").click(function(){
                $('.bs-example-modal-sm').modal('show');
            });//点击新建调用模态太对话框

            $(".modal_cols").click(function(){
                colorb=$(this).css("background-color");
                $(".new_con").css("background-color",colorb);
                $(".new_con").find(".new_content").css("background-color",colorb);
            });//换色

        });
        var contents;
        var bian_sum;
        var coslppt
        function redact(bb){//获取noteId  即 bian_sum
            $('.bs-example-modal-sm').modal('show');
            contents=$(bb).parent().children(".contents").val();
            var bian=$(bb).parent().attr("class");//获取class名称标识
            coslppt=$(bb).parent().css("background-color");//获取颜色值
            $(".new_con").css("background-color",coslppt);
            $(".new_con").find(".new_content").css("background-color",coslppt);
            bian_sum=bian.substr(9,bian.length-9);
            $(".new_content").val(contents);
            $(".btn_9").show();
            $(".btn_1").hide();
        }
        //添加 修改便签
        function new_btns(ss){
            if(ss==1){
                $('.bs-example-modal-sm').modal('hide');
            }
            if(ss==0){
                if($(".new_content").val()==""){
                    layer.msg('<fmt:message code="event.th.ContentCannotEmpty" />', { icon:2});
                }else{
                    var new_conte=$(".new_content").val();
                    var colss=$(".new_con").css("background-color");

                    var colps=$(".new_con").css("background-color");
                    var colpsp=colps.colorHex();
                    var colpsps=colpsp.substr(1,7);
                    var sumbs;
                    if(colpsps=="c8abad"){sumbs=0}
                    if(colpsps=="b2f2b4"){sumbs=1}
                    if(colpsps=="b2dffe"){sumbs=2}
                    if(colpsps=="f9f293"){sumbs=3}
                    if(colpsps=="d7dcdc"){sumbs=4}
                    if(colpsps=="f57474"){sumbs=5}
                    $('.bs-example-modal-sm').modal('hide');
                    var data={
                        content:new_conte,
                        color:sumbs
                    }
                    $.ajax({
                        'url':'/Notes/insertNotes',
                        'type':'post',
                        'dataType':'json',
                        'data':data,
                        success:function(reg){
                            $('.tishi').css("display","none");
                            addNew();
                        }
                    })
                }
            }
            if(ss==9){ //修改便签
                var timeStamp = (new Date()).valueOf();
                var time = new Date(timeStamp);
                var year=time.getFullYear();//年
                var month=time.getMonth()+1;//月
                var date=time.getDate();//日
                var hour=time.getHours(); //时
                var minu=time.getMinutes(); //分
                var conds=time.getSeconds(); //秒
                var new_months;
                var new_dates;
                var new_hours;
                var new_minus;
                var new_condss;
                if(month<10){
                    new_months="0"+month
                }else{
                    new_months=month;
                }
                if(date<10){
                    new_dates="0"+date
                }else{
                    new_dates=date;
                }
                if(minu<10){
                    new_minus="0"+minu
                }else{
                    new_minus=minu;
                }
                if(hour<10){
                    new_hours="0"+hour;
                }else{
                    new_hours=hour;
                }
                if(conds<10){
                    new_condss="0"+conds;
                }else{
                    new_condss=conds;
                }
                var str_time=year+"-"+new_months+"-"+new_dates;
                var str_hour=new_hours+":"+new_minus+":"+new_condss;
                var new_time= str_time+'     '+str_hour;
                var colsr=$(".new_con").css("background-color")
                var con_ppt=$(".new_content").val();
                var colhp=colsr.colorHex();
                var colpsps=colhp.substr(1,7);
                var sumbs;
                if(colpsps=="c8abad"){sumbs=0}
                if(colpsps=="b2f2b4"){sumbs=1}
                if(colpsps=="b2dffe"){sumbs=2}
                if(colpsps=="f9f293"){sumbs=3}
                if(colpsps=="d7dcdc"){sumbs=4}
                if(colpsps=="f57474"){sumbs=5}
                var data={
                    'noteId':bian_sum,
                    'content':con_ppt,
                    'color':sumbs,

                }
                $.ajax({
                    'url':'/Notes/updateByPrimaryKey',
                    'type':'post',
                    'dataType':'json',
                    'data':data,
                    success:function(reg){
                        var conlm=$(".new_content").val();
                        $(".yuan"+bian_sum).css("background-color",colsr);
                        $(".yuan"+bian_sum).find(".contents").css("background-color",colsr);
                        $(".yuan"+bian_sum).find(".contents").val(conlm);
                        $(".yuan"+bian_sum).find(".title_time").html(new_time);
                        $(".yuan"+bian_sum).find(".title_hms").html(str_hour);
                        $('.bs-example-modal-sm').modal('hide');


                    }
                })
            }
        }
        function addNew(){
            $.ajax({
                'url':'/Notes/selectNewNote',
                'type':'get',
                'dataType':'json',
                success:function(rsp){
                    var divstr='';
                    var color=rsp.object.color;
                    var colorol;
                    if(color==0){colorol="#c8abad"};
                    if(color==1){colorol="#b2f2b4"};
                    if(color==2){colorol="#b2dffe"};
                    if(color==3){colorol="#f9f293"};
                    if(color==4){colorol="#d7dcdc"};
                    if(color==5){colorol="#f57474"};
                    var content=rsp.object.content;
                    var uid=rsp.object.uid;
                    var noteId = rsp.object.noteId;
                    var timeStamp=rsp.object.editTime;
                    var time = new Date(timeStamp * 1000);
                    var year=time.getFullYear();//年
                    var month=time.getMonth()+1;//月
                    var date=time.getDate();//日
                    var hour=time.getHours(); //时
                    var minu=time.getMinutes(); //分
                    var conds=time.getSeconds(); //秒
                    var new_months;
                    var new_dates;
                    var new_hours;
                    var new_minus;
                    var new_condss;
                    if(month<10){
                        new_months="0"+month
                    }else{
                        new_months=month;
                    }
                    if(date<10){
                        new_dates="0"+date
                    }else{
                        new_dates=date;
                    }
                    if(minu<10){
                        new_minus="0"+minu
                    }else{
                        new_minus=minu;
                    }
                    if(hour<10){
                        new_hours="0"+hour;
                    }else{
                        new_hours=hour;
                    }
                    if(conds<10){
                        new_condss="0"+conds;
                    }else{
                        new_condss=conds;
                    }
                    var str_time=year+"-"+new_months+"-"+new_dates;
                    var str_hour=new_hours+":"+new_minus+":"+new_condss;
                    var new_time = str_time+'     '+str_hour;
                    divstr +="<div class='yuan yuan"+noteId+"' style='margin:10px 10px;height:200px;left:8px;width:200px;background-color:"+colorol+";float:left'>" +
                        "<div style='background-color: #000;width: 100%;height: 44px;position: absolute;top: 0;left: 0;opacity: 0.3;border-top-left-radius: 15px;border-top-right-radius: 15px;'>" +
                        "</div>" +
                        "<p style='position: relative;margin-top: 22px;left: 28px'>" +
                        "<span class='title_time'>"+new_time+"</span>" +
                        "<span  class='title_hms'style='display:none;'>"+str_hour+"</span></p>" +
                        "<textarea style='background-color:"+colorol+";margin-top: 12px;margin-left: 12px;' class='contents' style='width:90%;margin:0 auto'>"+content+"</textarea>" +
                        "<span class='span_bj' onclick='redact(this)' ><img src='../img/notes/gos_xxx.png' class='span_remove' onclick='removes(this)' ></span></div>"
                    if($(".content").html()==""){
                        $(".content").append(divstr);

                    }else{
                        $(".content").children().eq(0).before(divstr);
                    }
                    gon_hover()

                }
            });

        }
        //删除便签
        function removes(bxo){
            var remclass=$(bxo).parent().parent().attr("class");
            var remsum=remclass.substr(9,remclass.length-9);
            var data={'noteId':remsum}
            layer.confirm('<fmt:message code="sup.th.Delete" />？', {
                btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'] //按钮
            }, function(){
                //确定删除，调接口
                $.ajax({
                    'url':'/Notes/deleteByPrimaryKey',
                    'type':'post',
                    'dataType':'json',
                    'data':data,
                    success:function(reg){
                        $(bxo).parent().parent().remove();
                        layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});

                    }
                })
            }, function(){
                layer.closeAll();

            });
//            var a=confirm( "确定要删除么？");
//            if(a==true){
//                $.ajax({
//                    'url':'/Notes/deleteByPrimaryKey',
//                    'type':'post',
//                    'dataType':'json',
//                    'data':data,
//                    success:function(reg){
//                        $(bxo).parent().parent().remove();
//
//                    }
//                })
//
//            }
            var th = window.event || arguments.callee.caller.arguments[0];
            if (th) {
                th.stopPropagation();
            } else {
                th.cancelBubble = true;
            }
            return false;

        }


    </script>
</head>
<body onload="onl_d()">

<div class="dingbu">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/bianqian.png" >
    </div>
    <div class="divTitle">
        <fmt:message code="url.th.Note" />
    </div>
</div>
<div class="content">
    <div class="tishi" style="height: 100%;text-align: center;border: none;display: none">
        <div style="width:100%;padding-top:15%;"><img style="margin-top: 2%;text-align: center;" src="/img/noData.png" alt=""></div>
        <h2 style="margin: auto;text-align: center;font-size: 20px;font-weight: normal;"><fmt:message code="doc.th.NoData" /></h2>
    </div>
</div>
<br>
<%--<p class="jzgd" style="cursor:pointer">加载更多</p>--%>
<!-- Small modal -->
<%--<div  id="but_ns" class=" btn_sps b_but b_new" style="top: 8px;" >--%>
<%--<span style="margin-left: 30px;">新建</span>--%>
<%--</div>--%>
<button style="top: 6px;width: 100px;" id="but_ns" class=" btn_sps b_but b_new"><img style="margin-right: 3px" src="../../img/mywork/newbuildworjk.png" alt=""><fmt:message code="adding.th.note" /></button>

<div class="modal fade bs-example-modal-sm modal_bbb" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-sm">
        <div class="modal_cols" style="background-color:#c8abad"></div>
        <div class="modal_cols" style="background-color:#b2f2b4"></div>
        <div class="modal_cols" style="background-color:#b2dffe"></div>
        <div class="modal_cols" style="background-color:#f9f293"></div>
        <div class="modal_cols" style="background-color:#d7dcdc"></div>
        <div class="modal_cols" style="background-color:#f57474"></div>
    </div>

    <div class="new_con">
        <div class='bianqian' style='background-color: #000;width: 100%;height: 57px;position: absolute;top: 0;left: 0;opacity: 0.3;border-top-left-radius: 5px;border-top-right-radius: 5px;'></div>
        <textarea   class='new_content'></textarea>
        <div class="new_butt">
            <img src="../img/notes/gos_bc.png" title="保存" class="btn_1" onclick="new_btns(0)">
            <img src="../img/notes/gos_bc.png" title="保存" class="btn_9" onclick="new_btns(9)">
            <img src="../img/notes/gos_xxx.png" title="关闭" class="btn_2" onclick="new_btns(1)">
        </div>
    </div>
</div>
</div>

</body>
</html>
