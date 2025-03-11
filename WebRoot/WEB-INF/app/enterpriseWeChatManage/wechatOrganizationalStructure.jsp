<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<head>
    <head>
        <title>组织架构管理</title>
        <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    </head>
    <link rel="stylesheet" type="text/css" href="../../css/common/style.css" />
    <link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../css/enterpriseManage/weixinqy.css">
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script src="../../js/base/base.js"></script>
    <link rel="stylesheet" type="text/css" href="../../css/common/ui.dynatree.css">
    <script type="text/javascript" src="../../js/js_lang.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>


    <style>
        .tl{
            text-align: left;
            height: 27px;
            border-radius: 3px;
            border: 1px solid #cecbcb;
            padding-left: 10px;
        }
        .tr{
            text-align:right;
            width: 70px;
            display: inline-block;
            font-weight: bold;
            margin-right: 15px;
            line-height: 40px;
        }
    </style>
<body>
<div>
    <div class="sync-item">
        <button id="delet" class="btn btn-small btn-primary" type="button">删除选中部门</button>
        <button id="edit" class="btn btn-small btn-primary" type="button">编辑选中部门</button>
    </div>
    <div class="sync-tree sync-user-tree">
        <div id="userTree">
            <div class="cont_left" id="cont_left">
                <ul>
                    <li class="liDown dept_li" id="dept_lis"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_sectorList.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="部门列表"><fmt:message code="depatement.th.depa" /></li>
                    <li class="pick" style="display: block;">
                        <div class="pickCompany"><span style="height:35px;line-height:35px;" class="childdept"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 10px;margin-left: 13px;margin-bottom: 4px;"><a href="javascript:void(0)" class="dynatree-title" title=""></a></span></div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var department=''
    var name1;
    var id1;

    function inputcheck(name,val) {
        if(val==undefined){
            return;
        }
        $('[name="'+name+'"]').val(val)
    }

        $('li').on('click','input[name="department"]',function(){
            department=$(this).attr('name')
             name1=$(this).siblings().children()[2].title
            id1=$(this).next('span').attr('deptid')
            return name1
            return department
            return id1
        })
        $('#edit').click(function(){
            if(department=='department'){
                $.ajax({
                    url:'/enterpriseWeChatManage/enterpriseWeChatDepSettingMenu',
                    type:'get',
                    dataType:'json',
                    success:function(res){
                        var app="";
                        for(var i=0;i<res.data.length;i++){
                            var deptNum = "";
//                            for(var j = 0; j < res.data[i].parentid; j ++){
//                                deptNum += '\┋ '
//                            }
                             app+='<option value ="" id='+res.data[i].id+'>'+ deptNum +'| - '+res.data[i].name+'</option>'
                            $('#append').html(app)
                        }
                    }
                })
                layer.open({
                    type: 1,
                    title: ['编辑部门','background-color:#2e8ded;color:#fff'],
                    content:'<form style="text-align: center;padding-top: 40px;"><label><span class="tr">部门ID</span><input type="input" name="departmentId" disabled="disabled"  class="tl"></label><label><span class="tr">部门名称</span><input type="input" name="departmentName" class="tl"></label><span class="tr">父级部门</span>' +
                    '<select id="append">'+
                    '</select></form>',
                    area: ['80%', '80%'],

                    btn: ['确认','关闭'],
                    yes:function(index){
                        var id2=$('#append option:selected').attr('id')
                        var departmentName=$('input[name=departmentName]').val();
                        $.ajax({
                            url:'/enterpriseWeChatManage/enterpriseWeChatDepSettingEdit',
                            type:'post',
                            data:{
                                'name':departmentName,
                                'parentid':id2,
                                'id':id1
                            },
                            dataType:'json',
                            success:function(res){
                                layer.msg(res.msg, {icon: 1})
                                if(res.flag){
                                    layer.close(index);
                                    setTimeout("window.location.reload();",2000);
                                }

//

                            }
                        })
                    },
                    btn1:function(index){
                        layer.close(index)
                    },
                    btnAlign:'c',

                })
                inputcheck('departmentName',name1)
                inputcheck('departmentId',id1)
            }else {
                layer.msg("请选择部门！", {icon: 1})
            }

        });

$('#delet').click(function(){
    if(department=='department'){
        layer.open({
            type: 1,
            title: ['提示','background-color:#2e8ded;color:#fff'],
            content:'<div style="font-size: 18px;text-align: center;padding-top: 60px;">确认删除'+name1+'吗！</div>',
            area: ['430px', '250px'],

            btn: ['确认','关闭'],
            yes:function(index){
                $.ajax({
                    url:'/enterpriseWeChatManage/enterpriseWeChatDepSettingDelete',
                    type:'post',
                    data:{
                        'deptId':id1,
                    },
                    dataType:'json',
                    success:function(indexs){
                        layer.close(index);
                        layer.msg(indexs.msg, {icon: 1})
                        if(indexs.flag){
                            setTimeout("window.location.reload();",2000);
                        }
                    }
                })
            },
            btn1:function(index){
                layer.close(index)
            },
            btnAlign:'c',

        })
    }else {
        layer.msg("请选择部门！", {icon: 1})
    }

});
    loadSidebar1($('.pick'),1)
    function loadSidebar1(target,deptId,fn) {

        $.ajax({
            url: '/enterpriseWeChatManage/enterpriseWeChatDepSettingGet',
            type: 'get',
            data: {
                deptId: deptId
            },
            dataType: 'json',
            success: function (data) {
                $(target).empty();
                var str = '';
                if(data.errmsg=='ok'){
                    data.department.forEach(function (v, i) {
//                        if (v.deptName) {
                            str += '<li>' +
                                '<input type="radio" name="department" style="position: relative;bottom: 2px;">'+
                                '<span  data-numtrue="1" ' +
                                'onclick= "imgDown1(' +v.id + ',this)"   data-numString="1"  style="height:35px;line-height:35px;padding-left: 14px" deptid="' + v.id + '" class="childdept" clickType="0"><span class=""></span>' +
//                                '<input type="checkbox" style="position: relative;bottom: 2px;right: 4px;">'+
                                '<img src="/img/sys/dapt_right.png" alt="" class="imgleft" style="width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;"><a href="javascript:void(0)" class="dynatree-title" title="' + v.name + '">' + v.name + '</a></span><ul style="display:none;" class="dpetWhole0"></ul></li>';
//                        }
                    })
                }


//                console.log("str="+str);

                target.append(str);

            }
        })
    }

    function imgDown1(deptNum, me) {
        ajaxdata1(deptNum, me);
        if ($(me).attr('data-types') == undefined) {
            $(me).find('img').attr('src', $(me).find('img').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
            if ($(me).find('img').attr('src') == '/img/sys/dapt_right.png') {
                $(me).find('img').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": ""});
                $(me).find('img').width(8);
                $(me).find('img').height(14);
                $(me).next().hide();
                $(me).next().html('')
            } else if ($(me).find('img').attr('src') == '/img/sys/dapt_down.png') {
                $(me).find('img').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": "-5px"});
                $(me).find('img').width(14);
                $(me).find('img').height(9);
                $(me).next().show();
                $(me).next().html('')

            }
        }
        else {
            $(me).find('img').attr('src', $(me).find('img').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
            if ($(me).find('img').attr('src') == '/img/sys/dapt_right.png') {
                $(me).find('img').width(8);
                $(me).find('img').height(14);
            } else if ($(me).find('img').attr('src') == '/img/sys/dapt_down.png') {
                $(me).find('img').width(14);
                $(me).find('img').height(9);
            }
            if ($(me).attr('data-types') == '1') {
                $(me).next().show();
                $(me).attr('data-types', '2')
            } else if ($(me).attr('data-types') == '2') {
                $(me).next().hide();
                $(me).attr('data-types', '1')
            }

        }

//        if ($(me).attr('data-numstring') == 1) {
//            if (boolTwo) {
//                if ($(me).next().css('display') == 'none') {
//                    return;
//                }
//                $.loadrole($(me).next(), deptNum, $(me).attr('data-numtrue'));
//            } else {
        //$.loadSidebar($(me).next(), deptNum)
//            }
//        }
//        if($(me).next().html()=='') {
//            if (boolTwo) {
//                $.loadrole($(me).next(), deptNum, $(me).attr('data-numtrue'), function () {
//                    if (departments) {
//                        $.loadSidebar($(me).next(), deptNum)
//                    }
//                })
//            }
//
//        }
//        if ($(me).attr('data-numstring') == 2) {
//            if (numstring) {
//                $.loadSidebar($(me).next(), deptNum)
//            }
//        }

    }

    function ajaxdata1(id,me){

        $.ajax({
            url: '/enterpriseWeChatManage/enterpriseWeChatDepSettingGet',
            type: 'get',
            data: {
                deptId: id
            },
            dataType: 'json',
            success: function (data) {
                var v = data.department;
                var str1 = '';
                for(var i = 1; i <v.length; i ++) {
                    str1 += '<li>' +
                        '<input type="radio" name="department" style="position: relative;bottom: 2px;">'+
                        '<span  data-numtrue="1" ' +
                        'onclick= "imgDown1(' +v[i].id + ',this)"   data-numString="1"  style="height:35px;line-height:35px;padding-left: 14px" deptid="' + v[i].id + '" class="childdept" ><span class=""></span>' +
                        '<img src="/img/sys/dapt_right.png" alt="" class="imgleft" style="width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;"><a href="javascript:void(0)" class="dynatree-title" title="' + v[i].name + '">' + v[i].name + '</a></span><ul style="display:none;" class="dpetWhole"></ul></li>';
                }

//                data.department.forEach(function (v, i) {
////                    if (v.deptName) {
//                        str1 += '<li>' +
//                            '<input type="radio" name="department" style="position: relative;bottom: 2px;">'+
//                            '<span  data-numtrue="1" ' +
//                            'onclick= "imgDown1(' +v.id + ',this)"   data-numString="1"  style="height:35px;line-height:35px;padding-left: 14px" deptid="' + v.id + '" class="childdept" ><span class=""></span>' +
//                            '<img src="/img/sys/dapt_right.png" alt="" class="imgleft" style="width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;"><a href="javascript:void(0)" class="dynatree-title" title="' + v.name + '">' + v.name + '</a></span><ul style="display:none;" class="dpetWhole"></ul></li>';
////                    }
//                })

                $(me).next().append(str1);

            }
        })

    }

    //限制排序号只能输入三位有效数字
    var text = document.getElementById("deptNo_");
    text.onkeyup = function(){
        this.value=this.value.replace(/\D/g,'');
        if(text.value.length>3){
            text.value = deptNoShow;
        }
    }
</script>
</body>
</html>