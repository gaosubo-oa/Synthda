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
<base href="/">

<title>My JSP 'fileContent.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <link rel="stylesheet" type="text/css" href="lib/laydate.css"/>
	<link rel="stylesheet" type="text/css" href="css/cabinet.css?20201106.1">

    <script type="text/javascript" src="js/easyui/jquery.min.js"></script>
    <script src="js/jquery/jquery-1.9.1.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <script src="lib/laydate/laydate.js" type="text/javascript" charset="utf-8"></script>
<style>
input {border: none;outline: none;display: inline-block;background: #fff;}
input:hover {background: #eaf2ff;padding: 5px;}
.ss{margin-top:6px;position: relative;}
.ss a{font-size: 14px;display: block;font-family: 微软雅黑;letter-spacing: 1px;position: absolute;left: 25px;top: 1px;color: #fff;}
.one{width:90px;height: 28px;background: url("../img/file/cabinet01.png") no-repeat;}
.one a{height: 28px;  line-height: 28px;}
.two{width:90px;height: 28px;background: url("../img/file/cabinet02.png") no-repeat;}
.two a{height: 28px;  line-height: 28px;}
.three{width: 70px;height: 28px;background: url("../img/file/cabinet03.png") no-repeat;}
.three a{height: 28px;  line-height: 26px;color:#000;left:30px;}
.four{width: 90px;height: 28px;background: url("../img/file/cabinet04.png") no-repeat;}
.four a{height: 28px;  line-height: 26px;color:#000;}
#file_Tachr tr td:last-of-type a{display:block;width:40px;height:22px;background: url("../img/file/cabinet08.png") no-repeat;text-align:center;line-height:22px;}
.boto{margin-top: 8px;}
.boto a{display:inline-block;width: 56px;height:24px;position: relative;}
.boto a span{position:absolute;display:block;height:24px;top:0px;left:22px;line-height:24px;text-align: center;letter-spacing: 2px;}
.boto a.ONE{background: url("../img/file/cabinet07.png") no-repeat;}
.boto a.TWO{background: url("../img/file/cabinet09.png") no-repeat;}
.boto a.THREE{background: url("../img/file/cabinet10.png") no-repeat;}
.boto a.FOURs{background: url("../img/file/cabinet12.png") no-repeat;}
.boto a.FIVE{background: url("../img/file/cabinet11.png") no-repeat;}
.boto a.SIX{background: url("../img/file/icon_paste.png") no-repeat;}
.TITLE{margin-left: 10px;color: #2B7FE0;}

</style>
<script type="text/javascript">
    var user_id='userDuser';
$(function(){
    /* $("#contentAdd").attr("href","${pageContext.request.contextPath }/file/contentAdd?sortId="+${sortId}); */

    init();

    function init(){
        $.ajax({
            type:'post',
            url:'/file/catalog',
            dataType:'json',
            data:{'sortId':${sortId},'sortType':${sortType},'postType':${postType}},
            success:function(data){
                var files='';
                for(var i=0;i<data.length;i++){
                    if(data[i].fileType=="file"){
                        if(data[i].attachmentName!=''){

                            files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"'><td><input class=\"checkChild\" type=\"checkbox\" conId='"+data[i].contentId+"' name=\"check\" value=\"\" > <a class='TITLE' href=\"${pageContext.request.contextPath }/file/catContent?contentId="+data[i].contentId+"\">"+data[i].subject+ "  </a></td>  <td><a href='javascript:;' style='color:#000;'><img style='width:18px;' src=\"img/file/cabinet@.png\" alt=\"\"/>"+data[i].attachmentName+ "</a></td> <td> "+data[i].sendTime+ "  </td><td> "+data[i].contentNo+ "  </td><td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit" /></a></td></tr>"
                        }else{
                            files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"'><td><input class=\"checkChild\" type=\"checkbox\" conId='"+data[i].contentId+"' name=\"check\" value=\"\" > <a class='TITLE' href=\"${pageContext.request.contextPath }/file/catContent?contentId="+data[i].contentId+"\">"+data[i].subject+ "  </a></td>  <td><a href='javascript:;'></a></td> <td> "+data[i].sendTime+ "  </td><td> "+data[i].contentNo+ "  </td><td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit" /></a></td></tr>"
                        }
                    }
                }
                $("#file_Tachr").html(files);
                $(".contentTr").click(function () {
                    var state=$(this).find('.checkChild').prop("checked");
                    if(state==true){
                        $(this).find('.checkChild').prop("checked",true);
                        $(this).addClass('bgcolor');
                    }else{
                        $('#checkedAll').prop("checked",false);
                        $(this).find('.checkChild').prop("checked",false);
                        $(this).removeClass('bgcolor');
                    }
                    var child =   $(".checkChild");
                    for(var i=0;i<child.length;i++){
                        var childstate= $(child[i]).prop("checked");
                        if(state!=childstate){
                            return
                        }
                    }
                    $('#checkedAll').prop("checked",state);
                })


            }
        });
    }

    $('#checkedAll').click(function(){
        var state =$(this).prop("checked");

        if(state==true){
            $(this).prop("checked",true);
            $(".checkChild").prop("checked",true);
            $(".contentTr").addClass('bgcolor');
        }else{
            $(this).prop("checked",false);
            $(".checkChild").prop("checked",false);;
            $('.contentTr').removeClass('bgcolor');
        }
    })


    $('.FOURs').click(function(){
        var TYPE=$('.w .trBtn').attr('TYPE');
        var id=$('.w .trBtn').attr('sortId');
        var fileId=[];
        $(".checkChild:checkbox:checked").each(function(){
           var conId=$(this).attr("conId")
            fileId.push(conId);
        })

           var msg='<fmt:message code="global.lang.sure" />';
           if (confirm(msg)==true){
                 $.ajax({
                     type:'post',
                     url:'${pageContext.request.contextPath }/file/batchDeleteConId',
                     dataType:'json',
                     data:{'fileId':fileId},
                     success:function(){
                     location.reload();
                     }
                 });
               return true;
           }else{
               return false;
           }
    })

    $('.w').on('click','.editBtn',function(){
        //var TYPE=$('.w .trBtn').attr('TYPE');
        //var id=$('.w .trBtn').attr('sortId');
        //var idT=$('.w .trBtn').attr('contentId');
        var idT=$(this).parents('tr').attr('contentId');
        $.popWindow('/file/contentAdd?contentId='+idT,'<fmt:message code="global.lang.edit" />','0','0','1500px','800px');
    })



    //弹出一个页面层
    $('.SEARCH').on('click', function(event){
        event.stopPropagation();
        var sortId=$('.contentTr').attr('sortId');

        layer.open({
            type: 1,
            title:['<fmt:message code="global.lang.query" />', 'background-color:#2b7fe0;color:#fff;'],
            area: ['600px', '360px'],
            shadeClose: true, //点击遮罩关闭
            btn: ['<fmt:message code="global.lang.query" />', '<fmt:message code="global.lang.close" />'],
            content: '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 100%;">' +
                '<tr><td><fmt:message code="file.th.TitleContainsText" />：</td><td><input type="text" style="width: 180px;" name="subjectName" class="inputTd" value="" /></td></tr>'+
                '<tr><td><fmt:message code="file.th.Sort" />：</td><td><input type="text" style="width: 180px;" name="contentNo" class="inputTd" value="" /></td></tr>'+
                '<tr><td><fmt:message code="file.th.builder" />：</td><td><div class="inPole"><textarea name="txt" id="userDuser" user_id="id" value="admin" disabled style="min-width: 300px;min-height:50px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add" /></a></span></div></td></tr>'+
                '<tr><td><fmt:message code="file.th.Keywords1" />：</td><td><input type="text" style="width: 180px;" name="contentValue1" class="inputTd" value="" /></td></tr>'+
                '<tr><td><fmt:message code="file.th.keyword2" />：</td><td><input type="text" style="width: 180px;" name="contentValue2" class="inputTd" value="" /></td></tr>'+
                '<tr><td><fmt:message code="file.th.keyword3" />：</td><td><input type="text" style="width: 180px;" name="contentValue3" class="inputTd" value="" /></td></tr>'+
                '<tr><td><fmt:message code="file.th.text" />：</td><td><input type="text" style="width: 180px;" name="atiachmentDesc" class="inputTd" value="" /></td></tr>'+
                '<tr><td><fmt:message code="file.th.fileName" />：</td><td><input type="text" style="width: 180px;" name="atiachmentName" class="inputTd" value="" /></td></tr>'+
                '<tr><td><fmt:message code="file.th.containsText" />：</td><td><input type="text" style="width: 180px;" name="atiachmentCont" class="inputTd" value="" /><span style="margin-left: 10px;"><fmt:message code="file.th.Only" /></span></td></tr>'+
                '<tr><td><fmt:message code="global.lang.date" />：</td><td><input type="text" style="width: 180px;" name="crStartDate" id="start" class="inputTd" value="" onclick="laydate(start)" /><fmt:message code="global.lang.to" /><input type="text" style="width: 180px;" name="crEndDate" id="end" class="inputTd" value="" onclick="laydate(end)" /></td></tr>'+
            '</table>',
            yes:function(index){
                var userId=$('#userDuser').attr('user_id');
                if(userId=='id'){
                    userId='';
                }
                var data={
                    'sortId':sortId,
                    'pageNo':0,
                    'pageSize':10,
                    'subjectName':$('input[name="subjectName"]').val(),
                    'contentNo':$('input[name="contentNo"]').val(),
                    'creater':userId,
                    'contentValue1':$('input[name="contentValue1"]').val(),
                    'contentValue2':$('input[name="contentValue2"]').val(),
                    'contentValue3':$('input[name="contentValue3"]').val(),
                    'atiachmentDesc':$('input[name="atiachmentDesc"]').val(),
                    'atiachmentName':$('input[name="atiachmentName"]').val(),
                    'atiachmentCont':$('input[name="atiachmentCont"]').val(),
                    'crStartDate':$('input[name="crStartDate"]').val(),
                    'crEndDate':$('input[name="crEndDate"]').val(),
                }
                $.ajax({
                    type:'post',
                    url:'../file/queryBySearchValue',
                    dataType:'json',
                    data:data,
                    success:function(res){
                        var data1=res.datas;
                        var str='';
                        for(var i=0;i<data1.length;i++){
                            if(data1[i].attachmentName!=''){
                                str+="  <tr class='contentTrs' sortId='"+data1[i].sortId+"' contentId='"+data1[i].contentId+"'><td><input class='checkChildren' type='checkbox' conId='"+data1[i].contentId+"' name='check' value='' > <a class='TITLE' style='color:#000;' href='javascript:;'>"+data1[i].subject+ "  </a></td>  <td><img style='width:18px;' src=\"img/file/cabinet@.png\" alt=\"\"/>"+data1[i].attachmentName+"</td> <td> "+data1[i].sendTime+ "  </td><td> "+data1[i].contentNo+ "  </td><td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit" /></a></td></tr>"
                            }else{
                                str+="  <tr class='contentTrs' sortId='"+data1[i].sortId+"' contentId='"+data1[i].contentId+"'><td><input class='checkChildren' type='checkbox' conId='"+data1[i].contentId+"' name='check' value='' > <a class='TITLE' style='color:#000;' href='javascript:;'>"+data1[i].subject+ "  </a></td>  <td></td> <td> "+data1[i].sendTime+ "  </td><td> "+data1[i].contentNo+ "  </td><td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit" /></a></td></tr>"
                            }

                        }
                        $('#file_Tachrs').append(str);

                    }
                })
                layer.close(index);
                $('.mainContent').hide();
                $('.details').show();
            },
        });

        $('#selectUser').click(function(){
            user_id='userDuser';
            $.popWindow("../common/selectUser");
        })

    });

    //数据列表返回点击事件
    $('.backBtn').click(function(){
        $('.contentTrs').remove();
        $('.mainContent').show();
        $('.details').hide();
    })

    /*//复制点击事件
    $('#copy').click(function(){
        $('#paste').show();
         contentId=$('.bgcolor').attr('contentid');
    })
    //粘贴点击事件
    $('#paste').click(function(){
        copyData(contentid)
    })*/


    /*function copyData(id){
        $.ajax({
            type:'post',
            url:'../file/copyAndParse',
            dataType:'json',
            data:{'witchSortId':${sortId},'copyId':id},
            success:function(res){
                if(res.flag==true){
                    init();
                    if(contentId){
                        $('#paste').show();
                    }
                }else{
                    alert('粘贴失败');
                }
            }
        })
    }*/

});
    //时间控件调用
    var start = {
        format: 'YYYY/MM/DD hh:mm:ss',
        /* min: laydate.now(), //设定最小日期为当前日期*/
        /* max: '2099-06-16 23:59:59', //最大日期*/
        istime: true,
        istoday: false,
        choose: function(datas){
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas //将结束日的初始值设定为开始日
        }
    };
    var end = {
        format: 'YYYY/MM/DD hh:mm:ss',
        /*min: laydate.now(),*/
        /*max: '2099-06-16 23:59:59',*/
        istime: true,
        istoday: false,
        choose: function(datas){
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };

    /*function copyData(id){
        $.ajax({
            type:'post',
            url:'../file/copyAndParse',
            dataType:'json',
            data:{'witchSortId':${sortId},'copyId':id},
            success:function(res){
                if(res.flag==true){
                    init();
                }else{
                    alert('粘贴失败');
                }
            }
        })
    }*/
        //正在开发中
        function clicked(){
            layer.msg('<fmt:message code="global.lang.doing" />', {icon: 6});
        }
	</script>
    <style>

    </style>
</head>

<body style="background-color: #EBEBEB">
<div class="mainContent" style="display:block;">
    <div class="head w clearfix">
        <div class="ss one"> <a id="contentAdd" href="${pageContext.request.contextPath }/file/contentAdd?sortId=${sortId}&text=${text}"><fmt:message code="file.th.newfile" /></a></div>
        <div id="batch" class="ss two"> <a href="javascript:;" onclick="clicked()"><fmt:message code="notice.th.up" /></a></div>
        <div id="SEARCH" class="ss three"> <a  class="SEARCH" href="javascript:;"><fmt:message code="global.lang.query" /></a></div>
        <div id="overall" class="ss four"> <a href="javascript:;" onclick="clicked()"><fmt:message code="Email.th.global" /></a></div>
    </div>
    <!--middle部分开始-->
    <div class="w">
        <div class="wrap">
            <table class="w">
                <thead>
                <tr>
                    <td class="th"><fmt:message code="file.th.name"/></td>
                    <td class="th"><fmt:message code="email.th.file"/></td>
                    <td class="th" style="position: relative">
                        <fmt:message code="notice.th.PostedTime"/>
                        <img style="position: absolute;margin-left:9px;cursor: pointer;" src="img/file/cabinet05.png" alt=""/>
                        <img style="position: absolute;margin-top:10px;margin-left:9px;cursor: pointer;"
                             src="img/file/cabinet06.png " alt=""/>
                    </td>
                    <td class="th" style="position: relative">
                        <fmt:message code="file.th.Sort"/>
                        <img style="position: absolute;margin-left:9px;cursor: pointer;" src="img/file/cabinet05.png" alt=""/>
                        <img style="position: absolute;margin-top:10px;margin-left:9px;cursor: pointer;"
                             src="img/file/cabinet06.png " alt=""/>
                    </td>
                    <td class="th"><fmt:message code="notice.th.operation"/></td>
                </tr>
                </thead>
                <tbody id="file_Tachr">
                </tbody>
            </table>
        </div>
    </div>
        <!--bottom 部分开始-->
    <div class="bottom w">
        <div class="checkALL">
            <input id="checkedAll" type="checkbox" name="" value="" >
            <label for="checkedAll"><fmt:message code="notice.th.allchose"/></label>
        </div>
        <div class="boto" onclick="clicked()">
            <a class="ONE" href="javascript:;"><span><fmt:message code="file.th.SignReading" /></span></a>
        </div>
        <div class="boto" id="copy" onclick="clicked()">
            <a class="TWO" href="javascript:;"><span><fmt:message code="file.th.copy" /></span></a>
        </div>
        <div class="boto" onclick="clicked()">
            <a class="THREE" href="javascript:;"><span><fmt:message code="file.th.cut" /></span></a>
        </div>
        <div class="boto" id="paste" style="display: none;">
            <a class="SIX" href="javascript:;"><span><fmt:message code="fille.th.paste" /></span></a>
        </div>
        <div class="boto">
            <a class="FOURs" href="javascript:;"><span><fmt:message code="global.lang.delete" /></span></a>
        </div>
        <div class="boto" onclick="clicked()">
            <a class="FIVE" href="javascript:;"><span><fmt:message code="file.th.download" /></span></a>
        </div>

    </div>
</div>
<div class="details" style="display:none;">
    <div class="w">
        <div class="wrap">
            <table class="w">
                <thead>
                <tr>
                    <td class="th"><fmt:message code="file.th.name"/></td>
                    <td class="th"><fmt:message code="email.th.file"/></td>
                    <td class="th" style="position: relative">
                        <fmt:message code="notice.th.PostedTime"/>
                        <img style="position: absolute;margin-left:9px;cursor: pointer;" src="img/file/cabinet05.png" alt=""/>
                        <img style="position: absolute;margin-top:10px;margin-left:9px;cursor: pointer;"
                             src="img/file/cabinet06.png " alt=""/>
                    </td>
                    <td class="th" style="position: relative">
                        <fmt:message code="file.th.Sort"/>
                        <img style="position: absolute;margin-left:9px;cursor: pointer;" src="img/file/cabinet05.png" alt=""/>
                        <img style="position: absolute;margin-top:10px;margin-left:9px;cursor: pointer;"
                             src="img/file/cabinet06.png " alt=""/>
                    </td>
                    <td class="th"><fmt:message code="notice.th.operation"/></td>
                </tr>
                </thead>
                <tbody id="file_Tachrs">
                </tbody>
            </table>
        </div>
    </div>
    <div class="bottom w">
        <div class="checkALL">
            <input id="checkedAlls" type="checkbox" name="" value="" >
            <label for="checkedAlls"><fmt:message code="notice.th.allchose"/></label>
        </div>
        <div class="boto" onclick="clicked()">
            <a class="ONE" href="javascript:;"><span><fmt:message code="file.th.SignReading" /></span></a>
        </div>
        <div class="boto" onclick="clicked()">
            <a class="FIVE" href="javascript:;"><span><fmt:message code="file.th.download" /></span></a>
        </div>

    </div>
    <div class="button">
        <div class="backBtn"><fmt:message code="notice.th.return" /></div>
    </div>
</div>
<%--${pageContext.request.contextPath }/file/temp--%>
<!--bottom 部分结束-->
</body>
</html>
