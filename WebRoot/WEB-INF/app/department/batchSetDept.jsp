<%--
  Created by IntelliJ IDEA.
  User: liruixu
  Date: 2017/6/14
  Time: 11:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title><fmt:message code="depatement.th.Sectorbatch" /></title><%--部门批量设置--%>
    <meta http-equiv="X-UA-Compatible" content="IE=8" >
    <link rel="stylesheet" href="/css/dept/userGroup.css">
    <link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">
    <style>
        table{
            table-layout: fixed;
        }
        .controls ul li{
            float: left;
            border:1px solid #ddd;
            border-radius: 4px;
            position: relative;
            padding:5px 10px;
            margin:2px 5px;
        }
        .controls ul li span{
            position: absolute;
            top: -4px;
            right: 2px;
            font-size: 14px;
            color: #999;
            cursor: pointer;
        }
        .clearfix:after{
            clear: both;
            display: block;
            content: '';
        }
        #add_baocun {
            display: inline-block;
            width: 90px;
            height: 36px;
            margin-right: 40px;
            margin-top: 10px;
            margin-bottom: 20px;
            background: url(../../img/save.png) no-repeat;
            cursor: pointer;
            font-size: 16px;
            line-height: 36px;
        }
        #add_baocun span{
            display: inline-block;
            line-height: 32px;
            margin-left: 25px;
        }
        .clearfix{

        }
        thead td{
            font-size: 15px;
            color: #2F5C8F;
            font-weight: bold;
        }
        b{
            font-size:14px;
        }
        .tr_td tr:nth-child(odd) {
            background-color: #fff;
        }
        .bodycolor {
            BACKGROUND: #f9f9f9;
        }
        li b{
            font-size:12px;
            font-weight: 500;
        }
        #add_baocun span{
            color: #333;
        }
    </style>
    <script type="text/javascript" src="../js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
</head>
<body class="bodycolor" style="padding-bottom: 50px;">
<div id="showUserGroup">
        <div class="navigation  clearfix">
          <div class="left">
             <img src="/img/commonTheme/${sessionScope.InterfaceModel}/batchSetDept.png" alt="">
             <div class="news newtwo"><fmt:message code="depatement.th.Sectorbatch" /></div><%--部门批量设置--%>
              <div id="Confidential" style="display: inline-block"></div>
         </div>
        </div>

        <div id="showdiv" style="text-align: center">

         <table class="tr_td tr_tds"  style="border-collapse: collapse;border-top: 1px solid #c0c0c0;border-left: 1px solid #c0c0c0;" border="1" width="70%" align="center">
              <thead>
               <tr class="TableHeader">
                  <td nowrap="" width="30%" align="center"><fmt:message code="hr.th.department" /></td><%--部门--%>
                  <td nowrap="" width="70%" align="center"><fmt:message code="common.th.supervisorSetting" /></td><%--主管设置--%>
                </tr>
                </thead>
               <tbody>

               </tbody>
        </table>

    </div>
</div>
<div style="text-align: center">
    <a href="javascript:void (0)" class="baocun" id="add_baocun">
       <span> <fmt:message code="global.lang.save" /></span>
    </a><%--保存--%>
</div>
</body>
<script>
    var user_id='';
    var me=null;
    function loadfile() {
        var str=''
        var arrartwos=$(me).val().split(',')
        var arrthree=$(me).attr('dataid').split(',')
        for(var i=0;i<arrartwos.length;i++) {
            if(i<arrartwos.length-1) {
                    str += '<li data-num="'+arrthree[i]+'"><b>' + arrartwos[i] + '</b><span>x</span></li>'
            }
        }

        $(me).parent().siblings('.controls').find('ul').html(str)
    }
    function departmentChildtwo(datas,opt_li,level){
        for(var i=0;i<datas.length;i++){
            var String="";
            var space=""
            for(var j=0;j<level;j++){
                space+="&nbsp;&nbsp;&nbsp;&nbsp;";
            }
            /* console.log("kongge"+space+"kongge")*/

                String=space+"├";


                opt_li+=' <tr class="TableData" border="1" data-id="'+datas[i].deptId+'">\
                    <td class="TableData" >\
                <p style="width: 200px;font-size: 14px;font-weight: bold;line-height: 14px;\
            color: #000;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">'+String+datas[i].deptName+'</p>\
            </td>\
            <td align="left" class="lefttd">\
                <div id="dept" class="control-group">\
                <div class="pullright" style="float: right">\
                <button type="button" id="dept-plull-'+datas[i].deptNo+'" user_id="'+datas[i].manager+'" value="'+datas[i].managerStr+'" class="btn btn-mini btn-xuanzwe btn-top" title="<fmt:message code="global.lang.select" />"><fmt:message code="global.lang.select" /></button>\
                <button type="button" class="btn btn-mini btn-qingchu" title="<fmt:message code="notice.th.delete1" />"><fmt:message code="notice.th.delete1" /></button>\
                </div>\
                <label class="control-label"><b><fmt:message code="departement.th.Departmenthead" /></b></label>\
                <div class="controls"  style=" margin-top: 15px;margin-bottom: 15px;display: block;">\
                <ul class="clearfix">'+function () {<!--选择 选择  清除  清除 部门主管-->
                       var arrstwo=datas[i].managerStr.split(',');
                       var stringstwo='';
                       var numstwo=datas[i].manager.split(',');
                       for(var l=0;l<arrstwo.length;l++){
                           if(l<arrstwo.length-1) {
                               stringstwo += '<li data-num="' + numstwo[l] + '"><b>' + arrstwo[l] + '</b><span>x</span></li>'
                           }
                       }
                       return stringstwo;
                    }()+'</ul>\
                </div>\
                </div>\
                </div>\
                <div id="dept" class="control-group">\
                <div class="pullright" style="float: right">\
                <button type="button" id="dept-plus-'+datas[i].deptNo+'" user_id="'+datas[i].assistantId+'" value="'+datas[i].assistantStr+'"  class="btn btn-mini  btn-xuanzwe btn-buttom" title="<fmt:message code="global.lang.select" />"><fmt:message code="global.lang.select" /></button>\
                <button type="button"class="btn btn-mini btn-qingchu" title="<fmt:message code="notice.th.delete1" />"><fmt:message code="notice.th.delete1" /></button>\
                </div>\
                <label class="control-label" ><b><fmt:message code="departement.th.Departmentalassistant" /></b></label>\
                <div class="controls"  style=" margin-top: 15px;margin-bottom: 15px;display: block;">\
                <ul class="clearfix">'+function () {/*选择 选择 清除 清除 部门助理*/
                        var arrsthree=datas[i].assistantStr.split(',');
                        var stringsthree='';
                        var numsthree=datas[i].assistantId.split(',');
                        for(var p=0;p<arrsthree.length;p++){
                            if(p<arrsthree.length-1) {
                                stringsthree += '<li data-num="' + numsthree[p] + '"><b>' + arrsthree[p] + '</b><span>x</span></li>'
                            }
                        }
                        return stringsthree;
                    }()+'</ul>\
                </div>\
                </div>\
                </div>\
                </td>\
                </tr>'
            /*	console.log(datas[i].childs);*/
            if(datas[i].childs!=undefined){
//                opt_li += arguments.callee(datas[i].childs,opt_li,level+1);

                opt_li = departmentChildtwo(datas[i].childs,opt_li,level+1);
            }
        }
        return opt_li;
    }




    function ajaxgetAllDepartment() {
        $.get('/department/getAllDepartment', function (data) {
            if (data.flag) {
                var arrsrTwo=digui(data.obj,0);
                var streingt = ''
                var strss=departmentChildtwo(arrsrTwo,streingt,0)


                $('.tr_tds tbody').html(strss)

            }
        }, 'json')
    }
    //循环显示数据
    $(function () {
        ajaxgetAllDepartment()
        $('.tr_td').on('click','.btn-xuanzwe',function () {
            user_id=$(this).prop('id');
//            user_id=$(this).prop('user_id');
            me=this;
            $.popWindow("../common/selectUser");
        })
        $('.tr_td').on('click','.btn-qingchu',function () {
            $(this).prev().val('')
            $(this).prev().attr('dataid','')
            $(this).prev().attr('user_id','')
            $(this).parent().siblings('.controls').find('.clearfix').html('')
        })
        $('.baocun').on("click",function () {
            var arr=[];
            $('.tr_td tbody tr').each(function (i,n) {
                var obj={};
                obj.deptId=$(this).attr('data-id');
                obj.manager=$(this).find('.btn-top').attr('user_id')||''
                obj.assistantId=$(this).find('.btn-buttom').attr('user_id')||''
                arr.push(obj)
            })
            var str=JSON.stringify(arr)
            $.post('/department/batchUpdateDeptById',{'departments':str}, function (data) {
                if (data.flag) {
//                    var arrsrTwo=digui(data.obj,0);
//                    console.log(arrsrTwo)
//                    var streingt = ''
//                    var strss=departmentChildtwo(arrsrTwo,streingt,0)
//                    $('.tr_tds tbody').html(strss)
//                    ajaxgetAllDepartment()
                    alert('<fmt:message code="diary.th.modify" />！')/*保存成功*/
                }
            }, 'json')
        })
        $('.tr_td').on('click','.controls ul li span',function () {
            var str=$(this).parent().find('b').text();
            var num=$(this).parent().attr('data-num')
            var arrays=$(this).parent().parent().parent().siblings('.pullright').find('.btn-xuanzwe').val().split(',');
            for(var i=0;i<arrays.length;i++){
                if(str==arrays[i]){
                    arrays.splice(i,1)
                }
            }
            $(this).parent().parent().parent().siblings('.pullright').find('.btn-xuanzwe').val(arrays.join(','))
            var arraystwo=$(this).parent().parent().parent().siblings('.pullright').find('.btn-xuanzwe').attr('dataid').split(',');
            for(var i=0;i<arraystwo.length;i++){
                if(num==arraystwo[i]){
                    arraystwo.splice(i,1)
                }
            }
            var arraystwo=$(this).parent().parent().parent().siblings('.pullright').find('.btn-xuanzwe').attr('dataid',arraystwo.join(','))

            $(this).parent().remove()
        })
    })
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
                var data=res.object[0]
                if (data.paraValue!=0){
                    $('#Confidential').append('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </span>')
                }
        }
    })
</script>
</html>
