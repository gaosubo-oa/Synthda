<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>分支机构用户管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/css/sys/userManagement.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base.css"/>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>
        .boto a{

        }
        .colorRed td{
            color: red!important;
        }
        .colorddd td{
            color: #999!important;
        }
        .content .left .collect .liUp:first-of-type{
            border-top:none!important;
        }
        #btn{
            line-height: 28px;
        }
        /*table  tr td{*/
        /*    text-align: center;*/
        /*}*/
        #btn {
            line-height: 28px;
            float: right;
            margin-right: 12px;
            margin-top:4px;
            margin-left:0px;
            border:none;
        }
        body{
            background-color: #f5f7f8;
        }
        .content .left{
            /*overflow-x:auto;*/
        }
        #downChild .dpetWhole0 .childdept{
            padding-left: 60px!important;
        }
        #downChild .dpetWhole0 ul .childdept{
            padding-left: 80px!important;
        }
        #downChild .dpetWhole0 ul ul li .childdept{
            padding-left: 95px!important;
        }
        .tab table{
            white-space: nowrap;
            word-break: keep-all;
        }
        .content .headDiv{
            background-color: #f5f7f8;
        }

        td{
            font-size: 11pt;
        }
        #downChild li{
            width: 1000px;
        }
        .content .left .collect .divUP{
            overflow: auto;
        }		
	.content .left .collect .spanUP{			
    	    font-size: 14px;		
	}		
	#downChild li{            
	    width: 1000px;        
	}		
	#downChild li>span{			
	    font-size: 14px;		
	}		
	.pickCompany a {    
	    font-size: 14px;
	}
	.childdept {    
	    min-height: 36px;    
	    height: auto;    
	    line-height: 36px;
	}		
	/*定义滚动条宽高及背景，宽高分别对应横竖滚动条的尺寸*/
	::-webkit-scrollbar{	
	    width: 8px;	
	    height: 6px;	
	    background-color: #f5f5f5;
	}
	/*定义滚动条的轨道，内阴影及圆角*/
	::-webkit-scrollbar-track{	
	    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);	
	    border-radius: 10px;	
	    background-color: #f5f5f5;
	}
	/*定义滑块，内阴影及圆角*/
	::-webkit-scrollbar-thumb{	
	    /*width: 10px;*/	
	    height: 20px;	
	    border-radius: 10px;	
	    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);	
	    background-color: #555;
	}
	::-webkit-scrollbar{	    
	    width: 5px;	
	}
        .select{
            background:#c5e9fb;

        }
        .select>span>a{
            color:#fff!important;
        }

        .dept_order_box th{
            padding: 10px;
            font-size: 11pt;
        }
        .dept_order_box td {
            padding: 5px;
        }
        .dept_order_box table input {
            width: 40px;
            height: 20px;
        }
        .dept_order_box table select {
            height: 20px;
            padding: 2px;
            box-sizing: content-box;
        }
        .table input,td{
            padding: 0px;
        }
    </style>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/js/base/base.js?20210423.1" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
</head>
<body>
<div class="content clearfix">
    <input type="hidden" name="hiddenDept">
    <div class="headDiv">
        <div class="div_Img">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_userManagement1.png" style="vertical-align: middle;" alt="用户管理-管理范围（全体）">
        </div>
        <div class="divP"><fmt:message code="userManagement.th.UserManagement" /></div>
    </div>
    <div class="left">
        <div class="collect">
            <div id="incum" class="divUP">
                <span class="spanUP liUp AUP"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_inservicsPersonnel.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="在职人员"><fmt:message code="userManagement.th.In-servicePersonnel" /></span>
                <div id="downChild" style="min-height: 400px">
                    <div class="pickCompany"><div style="padding-left: 16px;" class="childdept"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 10px;margin-left: 13px;margin-bottom: 4px;"><a href="javascript:void(0)" class="dynatree-title" title=""></a></div></div>

                </div>
            </div>
            <%--未分配部门人员--%>
<%--            <div><span class="spanUP liUp noDept"  deptid="0"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_demission.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="未分配部门人员">未分配部门人员</span></div>--%>
<%--            <div><span class="spanUP liUp employee"  deptid="0"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_demission.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="离职人员/外部人员"><fmt:message code="userManagement.th.Outgoing" /></span></div>--%>
<%--            <div><span class="spanUP liUp newUsers"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_newUser.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="最近新增用户"><fmt:message code="userManagement.th.RecentlyAdded" /></span></div>--%>
            <div><span class="spanUP liUp queryExport"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_userQuery.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="用户查询或导出"><fmt:message code="userManagement.th.UserQuery" /></span></div>
            <div><span class="spanUP liUp import"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_userImport.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="用户导入"><fmt:message code="userManagement.th.Userimport" /></span></div>
<%--            <div><span class="spanUP liUp editUserBatch"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_batchUserSettings.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="批量用户个性设置"><fmt:message code="userManagement.th.Batch" /></span></div>--%>
<%--            <div><span class="spanUP liUp setAuxiliaryRole"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_demission.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="辅助角色批量设置">辅助角色批量设置</span></div>--%>
            <%--<div><span class="spanUP liUp proceed"><img src="../img/sys/icon_remindEmptyPassword.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="提醒空密码用户"><fmt:message code="userManagement.th.Reminding" /></span></div>--%>
            <%--<div><span class="spanUP liUp proceed"><img src="../img/sys/icon_exportRtxFormat.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="导出RTX格式"><fmt:message code="userManagement.th.ExportRTXformat" /></span></div>--%>
            <%--<div><span class="spanUP liUp proceed"><img src="../img/sys/icon_signOut.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="退出用户客户端登录"><fmt:message code="userManagement.th.Exitlogin" /></span></div>--%>
        </div>
    </div>
    <div class="right">
        <div class="header">
            <img src="/img/commonTheme/theme6/batchSetDept.png" style="margin-left: 11px;"/>
            <span class="USER" style="font-size: 20px;font-weight: 700;">用户查询</span><span class="post newDept"></span>
            <%--<select  name="" id="noDept" style="float: right;margin-top: 7px;margin-right: 24%;display: none">
                <option value=""><fmt:message code="userManagement.th.AllUser" /></option>
                <option value="0"><fmt:message code="userManagement.th.AllowIogonUser" /></option>
                <option value="1"><fmt:message code="userManagement.th.NoIogonUser" /></option>
            </select>--%>
            <input type="button" class="new_liucheng" name="btn" id="reload" style="right: 150px;top: 50px;height: 33px;line-height: 28px;" value="刷新">
            <input type="button" class="new_liucheng" name="btn" id="btn" value="<fmt:message code="userManagement.th.NewUser" />" /><span class="newroletwo"><input type="hidden"></span>
            <span style="margin-left: 10px;">共有<span style="color: #ff0000;margin: 0 5px;" class="totalNum"></span>条记录</span>
        </div>
        <div class="title">
            <span class="USER"><fmt:message code="main.usermanage" /></span><span class="post currentDept"></span>
            <select name="allUser" id="allSelUser">
                <option value=""><fmt:message code="userManagement.th.AllUser" /></option>
                <option value="0"><fmt:message code="userManagement.th.AllowIogonUser" /></option>
                <option value="1"><fmt:message code="userManagement.th.NoIogonUser" /></option>
            </select>
            <span class="explain"><fmt:message code="userManagement.th.Explanation" /></span>
        </div>
        <div class="tab">
            <table cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
                <tr class='tr_befor'>
                    <th width="4%">

                    </th>
                    <th width="8%"><fmt:message code="userName" /></th>
                    <th width="8%"><fmt:message code="userManagement.th.Realname" /></th>
                    <th width="8%"><fmt:message code="userManagement.th.department" /></th>
                    <th width="8%"><fmt:message code="userManagement.th.Scheduling" /></th>
                    <th width="14%"><fmt:message code="userManagement.th.role" /></th>
                    <th width="8%"><fmt:message code="userManagement.th.ManagementScope" /></th>
                    <th width="18%"><fmt:message code="userManagement.th.LastAccess" /></th>
                    <th width="8%"><fmt:message code="userInfor.th.OnlineDuration" /></th>
                    <th width="16%"><fmt:message code="notice.th.operation" /></th>
                </tr>

            </table>
        </div>
        <div class="bottom w clearfix">
            <div class="checkALL">
                <input id="checkedAll" type="checkbox" name="" value="" >
                <label for="checkedAll" style="font-size: 14px;"><fmt:message code="notice.th.allchose" /></label>
            </div>
            <div class="boto">
                <a class="ONE" href="javascript:void(0)"><span><fmt:message code="global.lang.delete" /></span></a>
            </div>
            <div class="boto">
                <a class="TWO" href="javascript:void(0)"><span><fmt:message code="userManagement.th.Emptylong" /></span></a>
            </div>
            <div class="boto">
                <a class="THREE" href="javascript:void(0)"><span>批量修改密码</span></a>
            </div>
            <div class="boto">
                <a class="FOUR" href="javascript:void(0)"><span><fmt:message code="userManangement.th.Nologin" /></span></a>
            </div>
<%--            <div class="boto">--%>
<%--                <a class="FIVE" href="javascript:void(0)"><span><fmt:message code="userManagement.th.Remind" /></span></a>--%>
<%--            </div>--%>
            <div class="boto">
                <a class="SEVEN" href="javascript:void(0)"><span>允许登录</span></a>
            </div>
            <div class="boto">
                <a class="SIX" href="javascript:void(0)"><span><fmt:message code="userManagement.th.BatchExchangeDepartment" /></span></a>
            </div>

        </div>
    </div>
    <div class="rightMain clearfix">
        <iframe src="/user/goQueryExportUsers?type=1" frameborder="0">

        </iframe>
    </div>
</div>
<script type="text/javascript">
    var paraValues = "";
    var USER_DEPT_ORDER = false;
    // 判断是否开启用户部门排序功能
    $.get('/department/order', function(res){
        if (res.flag) {
            USER_DEPT_ORDER = res.code == 1
        }
    });

    $('.left').height($(document).height()-46)
    var userstr;
    var user_id;
    var numdept;
    var searchData ={};
    var uidArray = new Array();
    var a;
    var b=0;
    var dimission = 0;
    $('#reload').on("click",function(){
        var deptIdRun = $('.newroletwo').children('input').val();
        $('#allSelUser').val('')
        if(deptIdRun != ''){
            deptById({deptId:deptIdRun},$('.tr_befor'),function(){
                $.layerMsg({content: '刷新成功', icon: 1});
            });
            // $('.newroletwo').children('input').val('');
        }else {
            $('.newUsers').click();
        }
    });
    function deptById(data,element){
        $('.tab').find('.userData').remove();
        $('.content .right').css("display","block");
        $('.content .rightMain').css("display","none");
        $.ajax({
            url:'/user/queryExportUsers',
            type:'get',
            dataType:'json',
            data:data,
            success:function(rsp){
                var data1=rsp.obj;
                $('.totalNum').html(rsp.obj.length);
                var str='';
                for(var i=0;i<data1.length;i++){
                    var colorNum='';
                    var lastVisitTime='';
                    if(data1[i].password=='') {
                        colorNum = 'colorRed'
                    }
                    if(data1[i].notLogin==1){
                        colorNum='colorddd'
                    }
                    if(data1[i].lastVisitTime!=undefined){
                        lastVisitTime=data1[i].lastVisitTime
                    }

                    str += '<tr class="userData '+colorNum+'" uId="' + data1[i].uid + '">' +
                        '<td>'+function(){if(data1[i].byname=="admin"){
                            return ''
                        }else{
                            return '<input type="checkbox" class="checkChild" name="checkbox" value=""  style="width:13px;height:13px;" />'
                        }}()+'</td>' +
                        '<td userid="'+data1[i].uid+'">' + data1[i].byname + '</td>' +
                        '<td>' + data1[i].userName + '</td>' +
                        '<td data-deptid="'+data1[i].deptId+'">' + data1[i].deptName + '</td>' +
                        '<td>' + function () {
                            switch (data1[i].dutyType) {
                                case 1:
                                    return '<fmt:message code="sys.th.RegularClass" />';
                                    break;
                                case 2:
                                    return '<fmt:message code="sys.th.Whole-day" />';
                                    break;
                                case 99:
                                    return '<fmt:message code="sys.th.ShiftSystem" />';
                                    break;
                            }

                        }() + '</td>' +
                        '<td>' + data1[i].userPrivName + '</td>' +
                        '<td>' +function () {
                            if(data1[i].postPriv==undefined){
                                return '';
                            }
                            switch (parseInt(data1[i].postPriv)) {
                                case 1:
                                    return '<fmt:message code="url.th.all" />';
                                    break
                                case 2:
                                    return '<fmt:message code="sys.th.DesignatedDepartment" />';
                                    break
                                case 0:
                                    return '<fmt:message code="sys.th.ThisDepartment" />';
                                    break
                            }

                        }()  + '</td>' +
                        '<td>' + lastVisitTime + '</td>' +
                        '<td>' + data1[i].idleTime + '</td>' +
                        '<td>'+function(){
                            if(data1[i].byname==''){
                                return '';
                            }else{
                                var str = '<a href="javascript:void(0)" onclick="clickrenwu('+data1[i].uid+',this)" style="margin-right: 5px;"><fmt:message code="global.lang.edit" /></a>'

                                if (USER_DEPT_ORDER) {
                                    str += '<a href="javascript:;" userid="'+data1[i].userId+'" name="'+data1[i].userName+'" onclick="userDeptOrder(this)">部门排序</a>'
                                }
                                return str
                            }
                        }()+'</td>' +
                        '</tr>';  //<a href="javascript:;">
                    <%--<fmt:message code="userManagement.th.MenuAauthority" />--%>
                    //</a>:菜单权限查看
                    $("#checkedAll").removeAttr("checked")
                }

                element.after(str);
                $('.userData').on("click",function(){
                    var inCh=$(this).find('.checkChild').prop('checked');
                    if(inCh == true){
                        $(this).find('.checkChild').prop('checked',true);
                        $(this).addClass('bgColor');
                    }else{
                        $('#checkedAll').prop('checked',false);
                        $(this).find('.checkChild').prop('checked',false);
                        $(this).removeClass('bgColor');
                    }
                    var child = $(".checkChild");
                    for(var i=0;i<child.length;i++){
                        var childstate= $(child[i]).prop("checked");
                        if(inCh!=childstate){
                            return
                        }
                    }
                    $('#checkedAll').prop("checked",inCh);
                })
            }
        })
    }
    function ajaxdata (deptId,me) {
        $('.header').children('.USER').text($(me).children('a').text());
        $('.newroletwo').children('span').text($(me).children('a').text());
        $('.newroletwo').children('input').val($(me).attr('deptid'));
        $('.childdept').parents('li').removeClass('select')
        // $(me).addClass('select').parent().siblings().find('span').removeClass('select').end().parents('ul').parents('li').removeclass('select')
        if($(me).parent().find('ul li').length<=0){
            $(me).parent().addClass('select').siblings().removeClass('select').find('li').removeClass('select').end().parent().find('ul').css('background','#fff')

        }else{
            $(me).parents('li').removeClass('select').end().parent().addClass('select').siblings().removeClass('select').find('li').removeClass('select').end().parent().find('ul').css('background','#fff')
        }
        searchData = {};
        searchData.deptIds = deptId+",";
        if($('#allSelUser').val()!=undefined &&$('#allSelUser').val()!=''){
            searchData.notLogin = $('#allSelUser').val();
        }
        if(deptId==0||deptId=='0'){
            searchData.deptIds = "";
            searchData.notLogin = $('#allSelUser').val();
            searchData.deptId = 0;
        }
        $('#reload').show();
        deptById(searchData,$('.tr_befor'))
    }

    function imgDown1(id,me){
        $(me).next().show();
        $(me).attr('data-types', '2')
        $(me).find('#image').attr('src', $(me).find('#image').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
        if ($(me).find('#image').attr('src') == '/img/sys/dapt_right.png') {
            $(me).find('#image').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": ""});
            $(me).find('#image').width(8);
            $(me).find('#image').height(14);
            $(me).next().hide();
            // $(me).next().html('')
        } else if ($(me).find('#image').attr('src') == '/img/sys/dapt_down.png') {
            $(me).find('#image').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": "-5px"});
            $(me).find('#image').width(14);
            $(me).find('#image').height(9);
            $(me).next().show();
        }
        this.ajaxdata(id,me);
        $('#btn').attr('data_id',id);
    }

    function clickrenwu(deptId,me) {
        userstr=$(me).text();
        window.open('/addUsers?'+deptId+'&classifyOrg=1','<fmt:message code="sys.th.EditUser" />');
    }

    $(function () {
        $.ajax({
            url:'/sys/showUnitManage',
            type:'get',
            dataType:"JSON",
            data : '',
            success:function(obj){
                var data = obj.object.unitName;
                $('#downChild .pickCompany .dynatree-title').text(data).attr('title',data);

            },
            error:function(e){
            }
        });

        $('.rightMain ').height($(document).height()-46);

        $('#btn').on("click",function(){
            var deptId=$(this).attr('data_id');
            $.ajax({
                url:"/user/checkUserCount",
                type:"get",
                success:function (res) {
                    if(res.flag){
                        numdept=$('.newroletwo').find('input').val();
                        window.open('/addUsers?isAdd=0&deptId='+deptId+'&classifyOrg=1','<fmt:message code="userManagement.th.NewUser" />');
                    }else{
                        layer.msg(res.msg, {icon: 2});
                    }
                },
                dataType:"json"
            });

        });

        $('#allSelUser ').on('change',function () {

            var deptId= 0 ;
            var deptIdDom = $('.collect .add_back').attr('deptid');
            if(deptIdDom!=undefined&&deptIdDom!=''&&deptIdDom!='undefined'){
                deptId = deptIdDom;
            }

            searchData.notLogin = $(this).val();
            if(searchData.deptIds==undefined){
                searchData.deptIds = deptId;
            }

            if($(this).val()==''){
                delete searchData.notLogin;
            }
            $('#reload').show();
            deptById(searchData,$('.tr_befor'))

        });

//        init()
//        getChDept($('#ULDown'),30);
        $('.AUP').on("click",function(){
            //$('#ulList').slideToggle();
            if($('#downChild').css('display')=='block'){
                $(this).addClass('liUp').removeClass('liDown');
                $('#downChild').slideUp();
            }else{
                $(this).addClass('liDown').removeClass('liUp');
                $('#downChild').slideDown();
            }
        });
        $('.proceed').on("click",function () {
            $.layerMsg({content:'<fmt:message code="lang.th.Upcoming" />',icon:6})
        });
        $('.employee').on("click",function () {
            $('#reload').show();
            $('.header').children('.USER').text('离职人员/外部人员');
            var data={
                'deptId':0,
                'notLogin':$('#allSelUser').val()
            };
            if($('#allSelUser').val()==undefined || $('#allSelUser').val()==''){
                searchData.notLogin =null;
            }
            deptById(data,$('.tr_befor'));
        });

        // 查询新增用户
        $('.newUsers').on("click",function(){
            $('.tab').find('.userData').remove();
            $('.content .right').css("display","block");
            $('.content .rightMain').css("display","none");
            $('.header').children('.USER').text('最近新增用户');
            $('#reload').show();
            $.ajax({
                url:'/hierarchicalGlobal/getGlobalPerson',
                type:'get',
                dataType:'json',
                success:function(rsp){
                    var data1=rsp.obj;
                    $('.totalNum').html(rsp.obj.length);
                    var str='';
                    for(var i=0;i<data1.length;i++){
                        var colorNum='';
                        var lastVisitTime=''
                        if(data1[i].password=='') {
                            colorNum = 'colorRed'
                        }
                        if(data1[i].notLogin==1){
                            colorNum='colorddd'
                        }
                        if(data1[i].lastVisitTime!=undefined){
                            lastVisitTime=data1[i].lastVisitTime
                        }

                        str += '<tr class="userData '+colorNum+'" uId="' + data1[i].uid + '">' +
                            '<td>'+function(){
                                if(data1[i].byname=='admin'){
                                    return ''
                                }else{
                                    return '<input type="checkbox" class="checkChild" name="checkbox" value="" style="width:13px;height:13px;" />'
                                }
                            }()+'</td>' +
                            '<td>' + data1[i].byname + '</td>' +
                            '<td>' + data1[i].userName + '</td>' +
                            '<td data-deptid="'+data1[i].deptId+'">' + data1[i].deptName + '</td>' +
                            '<td>' + function () {
                                switch (data1[i].dutyType) {
                                    case 1:
                                        return '<fmt:message code="sys.th.RegularClass" />';
                                        break
                                    case 2:
                                        return '<fmt:message code="sys.th.Whole-day" />';
                                        break
                                    case 99:
                                        return '<fmt:message code="sys.th.ShiftSystem" />';
                                        break
                                }

                            }() + '</td>' +
                            '<td>' + data1[i].userPrivName + '</td>' +
                            '<td>' +function () {
                                switch (parseInt(data1[i].postPriv)) {
                                    case 1:
                                        return '<fmt:message code="url.th.all" />';
                                        break
                                    case 2:
                                        return '<fmt:message code="sys.th.DesignatedDepartment" />';
                                        break
                                    case 0:
                                        return '<fmt:message code="sys.th.ThisDepartment" />';
                                        break
                                }

                            }()  + '</td>' +
                            '<td>' + lastVisitTime + '</td>' +
                            '<td>' + data1[i].idleTime + '</td>' +
                            '<td>'+function(){
                                if(data1[i].byname==''){
                                    return ''
                                }else{
                                    return '<a href="javascript:void(0)" onclick="clickrenwu('+data1[i].uid+',this)" style="margin-right: 5px;"><fmt:message code="global.lang.edit" /></a>'
                                }
                            }()+'</td>' +
                            '</tr>';  //<a href="javascript:;">
                        <%--<fmt:message code="userManagement.th.MenuAauthority" />--%>
                        //</a>:菜单权限查看

                    }

                    $('.tr_befor').after(str);
                    $('.userData').on("click",function(){
                        var inCh=$(this).find('.checkChild').prop('checked');
                        if(inCh == true){
                            $(this).find('.checkChild').prop('checked',true);
                            $(this).addClass('bgColor');
                        }else{
                            $('#checkedAll').prop('checked',false);
                            $(this).find('.checkChild').prop('checked',false);
                            $(this).removeClass('bgColor');
                        }
                        var child = $(".checkChild");
                        for(var i=0;i<child.length;i++){
                            var childstate= $(child[i]).prop("checked");
                            if(inCh!=childstate){
                                return
                            }
                        }
                        $('#checkedAll').prop("checked",inCh);
                    })
                }
            })
        })
        //未分配部门人员
        $('.noDept').on("click",function () {
            $('.content .right').css("display","none");
            $('.rightMain').css("display","block");
            $('.rightMain iframe').attr("src","/sys/noDeptPeople");
        })
        // 查询和导出
        $('.queryExport').on("click",function () {
            $('.content .right').css("display","none");
            $('.rightMain').css("display","block");
            $('.rightMain iframe').attr("src","/user/goQueryExportUsers?type=1");
        });
        // 导入
        $('.import').on("click",function () {
            $('.content .right').css("display","none");
            $('.rightMain').css("display","block");
            $('.rightMain iframe').attr("src","/user/goImportUsers");
        });
        // 批量设置
        $('.editUserBatch').on("click",function () {
            $('.content .right').css("display","none");
            $('.rightMain').css("display","block");
            $('.rightMain iframe').attr("src","/user/goEditUserBatch");
        });
        // 批量设置辅助角色
        $('.setAuxiliaryRole').on("click",function(){
            $('.content .right').css("display","none");
            $('.rightMain').css("display","block");
            $('.rightMain iframe').attr("src","/hierarchical/userPriv/batchSetAuxiliaryRole");
        })

        //全选点击事件
        $('#checkedAll').on("click",function(){
            var state =$(this).prop("checked");
            if(state==true){
                $(this).prop("checked",true);
                $(".checkChild").prop("checked",true);
                $(".userData").addClass('bgcolor');
            }else{
                $(this).prop("checked",false);
                $(".checkChild").prop("checked",false);
                $('.userData').removeClass('bgcolor');
            }
        })

        //删除人员按钮
        $('.ONE').on("click",function(){
            // 判断是否只允许系统管理员删除用户
            $.ajax({
                type:'get',
                url:'/syspara/selectByParaName',
                dataType:'json',
                data:{
                    paraName:'PRIV1_DELETE_USER'
                },
                success:function (res) {
                    if(res.flag){
                        if(res.object==1){
                            if($('.tab table input[type="checkbox"]:checked').length==0){
                                $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:1})
                                return
                            }
                            $.ajax({
                                type:'get',
                                url:'/user/userCookie',
                                dataType:'json',
                                success:function (res) {
                                    if(res.object.role.userPriv==1){
                                        buttonInterface('../user/deleteUser','<fmt:message code="sys.th.MakeSureDelete" />？');
                                    }else {
                                        $.layerMsg({content:'您不是系统管理员，不能删除用户',icon:2})
                                    }
                                }
                            })

                        }else{
                            if($('.tab table input[type="checkbox"]:checked').length==0){
                                $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:1})
                                return
                            }
                            buttonInterface('../user/deleteUser','<fmt:message code="sys.th.MakeSureDelete" />？');
                        }

                    }
                }
            })
        })
        //清空在线时长按钮
        $('.TWO').on("click",function(){
            if($('.tab table input[type="checkbox"]:checked').length==0){
                $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:1})
                return
            }
            buttonInterface('/user/clearOnLine','<fmt:message code="sys.th.MakeSureEmpty" />？');
        })
        //清空密码按钮
        $('.THREE').on("click",function(){
            <%--if($('.tab table input[type="checkbox"]:checked').length==0){--%>
            <%--    $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:1})--%>
            <%--    return--%>
            <%--}--%>
            if(b==0){
                $('.tab table tbody [type="checkbox"]:checked').each(function(){
                    uidArray+=$(this).parent().parent().attr('uid')+',';
                    a = uidArray.split(',')
                    b++

                })
            }else{
                uidArray = new Array()
                $('.tab table tbody [type="checkbox"]:checked').each(function(){
                    uidArray+=$(this).parent().parent().attr('uid')+',';
                    a = uidArray.split(',')
                    b++
                })
            }
            console.log(a)

            if($('.tab table input[type="checkbox"]:checked').length==0){
                $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:1})
            }else{
                layer.open({
                    type: 1,
                    title:['批量修改密码'],
                    area: ['640px', '350px'], //宽高
                    content: '        <div class="title" style="margin-top:10px;margin-left:10px">\n' +
                        '            <img src="/img/modifypassword.png" alt="修改OA账户">\n' +
                        '            <span><fmt:message code="url.th.ModifyOA" /></span>\n' +
                        '        </div>\n' +
                        '        <div class="main" style="margin-top:35px;padding-left:80px">\n' +
                        '            <table class="table" cellspacing="0" cellpadding="0" style="border-collapse:collapse;background-color: #fff">\n' +
                        '                <tr class="w" style="border:0">\n' +
                        '                    <td class="red_text" style="text-align:center"><fmt:message code="url.th.newPW" />:</td>\n' +
                        '                    <td>\n' +
                        '                        <input type="password" style="width:50%" id="password" class="pw"/><%--<fmt:message code="url.th.numbers" />--%>\n' +
                        '                    </td>\n' +
                        '                </tr>\n' +
                        '          <tr style="border:0">\n' +
                        '          <td class="red_text" style="text-align:center"><fmt:message code="url.th.Confirm" />:</td>\n' +
                        '  <td style="display:inline-block;margin-top:20px;width:100%">\n' +
                        '  <input type="password" style="width:50%" id="repassword" class="pw"    onkeyup="validatePwdStrong(this.value);"/>\n' +
                        '      <span class="passWordRuleSpan"></span><span>位，必须同时包含字母和数字</span><%--<fmt:message code="url.th.numbers" />--%>\n' +
                        '  <div class="clearfix" style="    width: 217px;height: 10px;border: 1px solid #ccc;margin-top: 5px; margin-bottom:10px;border-radius: 4px;" id="main">\n' +
                        '      <span class="fl" style="display:inline-block;position: relative;top:-6px;width: 67px;height:10px;border-right: 1px solid #ccc" id="low"></span>\n' +
                        '      <span class="fl" style="display:inline-block;width: 67px;position: relative;top:-6px;height:10px;border-right: 1px solid #ccc" id="medium"></span>\n' +
                        '      <span class="fl" style="display:inline-block;position: relative;top:-6px;width: 68px;height:10px;" id="height"></span>\n' +
                        '      </div>\n' +
                        '      </td>\n' +
                        '      </tr>\n' +
                        '           <tr style="border:0">\n' +
                        '           <td colspan="2">\n' +
                        '       <div class="btn" style="text-align:center;margin-top:30px;margin-right:40px">\n' +
                        '       <input id="submit" style="width:80px;cursor: pointer" type="button" class="inpuBtn backOkBtn"  value="<fmt:message code="global.lang.save" />">\n' +
                        '       </div>\n' +
                        '       </td>\n' +
                        '       </tr>\n' +
                        '            </table>\n' +
                        '        </div>',
                    success:function(){

                    }
                });
            }


            $(function(){
                // 查询密码限制长度
                var passWordMin=6,passWordMax=20;
                $.ajax({
                    url:"/user/getPwRule",
                    type:"get",
                    dataType: 'json',
                    success:function (res) {
                        if(res.flag){
                            var obj = res.object;
                            passWordMin = obj.secPassMin;
                            passWordMax = obj.secPassMax;
                            start = passWordMin
                            end = passWordMax
                            $('.passWordRuleSpan').html(passWordMin+"-"+passWordMax);
                        }
                    }
                });

                $.ajax({
                    url:'/sysTasks/selectAll',
                    dataType:'json',
                    type:'get',
                    success:function (res) {
                        var data = res.obj;
                        for(var i=0;i<data.length;i++){
                            if(data[i].paraName=='SEC_PASS_SAFE'){
                                if(data[i].paraValue == 0){
                                    flag = 0
                                    $('.passWordRuleSpan').next().html('位')
                                }else if(data[i].paraValue == 1){
                                    flag = 1
                                    $('.passWordRuleSpan').next().html('位，必须同时包含字母和数字')
                                }else if(data[i].paraValue == 2){
                                    flag = 2
                                    $('.passWordRuleSpan').next().html('位，必须同时包含字母和数字和字符')
                                }else if(data[i].paraValue == 3){
                                    flag = 3
                                    $('.passWordRuleSpan').next().html('位，必须同时包含大写字母和小写字母和数字')
                                }else if(data[i].paraValue == 4){
                                    flag = 4
                                    $('.passWordRuleSpan').next().html('位，必须同时包含大写字母和小写字母和数字和特殊字符')
                                }
                            }
                        }
                        $('.right').show();
                    }
                })

                $.ajax({
                    type: "get",
                    url: "/getUsersByuserId",
                    dataType: 'json',
                    success: function (obj) {
                        if(obj.flag){

                            $('#username').val(obj.object.byname);
                            $('#username').attr({
                                'userId':obj.object.userId,
                                'uid':obj.object.uid
                            })
                            var timeStamp=obj.object.lastPassTime;
                            if(timeStamp!=undefined) {
                                var time = new Date(timeStamp);
                                var year = time.getFullYear();//年
                                var month = time.getMonth() + 1;//月
                                var date = time.getDate();//日
                                var hour = time.getHours(); //时
                                var minu = time.getMinutes(); //分
                                var conds = time.getSeconds(); //秒
                                var new_months;
                                var new_dates;
                                var new_hours;
                                var new_minus;
                                var new_condss;
                                if (month < 10) {
                                    new_months = "0" + month
                                } else {
                                    new_months = month;
                                }
                                if (date < 10) {
                                    new_dates = "0" + date
                                } else {
                                    new_dates = date;
                                }
                                if (minu < 10) {
                                    new_minus = "0" + minu
                                } else {
                                    new_minus = minu;
                                }
                                if (hour < 10) {
                                    new_hours = "0" + hour;
                                } else {
                                    new_hours = hour;
                                }
                                if (conds < 10) {
                                    new_condss = "0" + conds;
                                } else {
                                    new_condss = conds;
                                }
                                var str_time = year + "-" + new_months + "-" + new_dates + " " + new_hours + ":" + new_minus + ":" + new_condss;

                                $('#lastEditTime').html(str_time);
                            }else {
                                $('#lastEditTime').html("");
                            }
                        }
                    },
                });

                //初始化修改登录日志列表显示
                logListShow();
            })

            function logListShow(){
                $.ajax({
                    type: "post",
                    url: "/sys/getModifyPwdLog",
                    dataType: 'json',
                    success:function(data){
                        var obj=data.obj;
                        if(data.flag&&obj.length>0){
                            var str="";
                            for(var i=0;i<obj.length;i++){
                                str+='<tr><td>'+obj[i].userName+'</td><td>'+obj[i].time+'</td><td>'+obj[i].ip+'</td><td>'+obj[i].typeName+'</td><td>'+obj[i].remark+'</td></tr>';
                            }
                            $('.modifyPwdLogList').html(str.toString());
                            $('#lastEditTime').html(obj[0].time);
                        }
                    }
                })
            }

            <%--buttonInterface('/user/clearPassword','<fmt:message code="sys.th.VerifyPassword" />？');--%>
        })
        //禁止登录按钮
        $('.FOUR').on("click",function(){
            if($('.tab table input[type="checkbox"]:checked').length==0){
                $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:1})
                return
            }
            buttonInterface('/user/setNotLogin','<fmt:message code="sys.th.MakeSure" />？');
        })
        // 提醒空密码用户按钮
        $('.FIVE').on("click",function(){
            $.layerMsg({content:'<fmt:message code="lang.th.Upcoming" />',icon:1})
            return
        })
        // 批量修改部门按钮
        $('.SIX').on("click",function(){
            if($('.tab table input[type="checkbox"]:checked').length==0){
                $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:1})
                return
            }
            layer.open({
                title:'<fmt:message code="sys.th.BatchModification" />',
                content:'<div>' +
                '<table>' +
                '<tr><td style="border-right: 1px solid #ddd"><fmt:message code="main.usermanage" />:</td><td><textarea style="margin-right: 10px;" name="" id="textareaopen"></textarea><a href="javascript:void(0)" class="addopens"><fmt:message code="global.lang.add" /></a></td></tr>' +
                '<tr><td style="border-right: 1px solid #ddd"><fmt:message code="sys.th.NewSector" />:</td><td><select style="width: 139px;margin-left: -28px;" name="" id="newselectrrole"></select></td></tr>' +
                '<tr><td style="border-right: 1px solid #ddd"><fmt:message code="sys.th.ReminderDepartment" />:</td><td><label style="margin-right: 10px;"><input name="checktit" type="checkbox"><fmt:message code="notice.th.remindermessage" /></label>' +
                '<label><input name="checktit" type="checkbox"><fmt:message code="sys.th.SendReminderMessage" /></label></td></tr></table></div>',
                area:['500px','300px'],
                btn:['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'],
                yes:function (index) {

                    var obj={
                        'deptId':$('#newselectrrole').val(),
                        'uids':$('#textareaopen').attr('user_id')

                    }
                    $.post('/user/editUsersDeptId',obj,function (json) {
                        if(json.flag){
                            $.layerMsg({content:'<fmt:message code="sys.th.SwapComplete" />',icon:1},function () {
                                location.reload()
                            })
                        }
                    },'json')
                },
                success:function () {
                    $('#newselectrrole').deptSelect(function (me) {//me是传过来的this，newselectrrole
                        $.get('/department/selectUnallocated', function(res){
                            $('#newselectrrole').val($('.tab table tbody [type="checkbox"]:checked').parent().parent().find('td').eq(3).attr('data-deptid'))
                            if (res.flag && res.msg != 'false'){
                                $(me).append('<option value="'+res.object.deptId+'">'+res.object.deptName+'</option>')
                            }
                            $(me).append('<option value="0"><fmt:message code="userManagement.th.Outgoing" /></option>')
                        })
                    })
                    var strcheck='',struserId='';
                    $('.tab table tbody [type="checkbox"]:checked').each(function(){
                        strcheck+=$(this).parent().parent().find('td').eq(2).text()+',';
                        struserId+=$(this).parent().parent().find('td').eq(1).attr('userid')+',';
                    })
                    $('#textareaopen').val(strcheck)
                    $('#textareaopen').attr('user_id',struserId)
                    $('.addopens').on("click",function(){
                        user_id=$(this).prev().prop('id')
                        $.popWindow("/common/selectUser");
                    })
                }
            })

        })

        //允许登录按钮
        $('.SEVEN').on("click",function(){
            if($('.tab table input[type="checkbox"]:checked').length==0){
                $.layerMsg({content:'请选择允许登录的人员',icon:2})
                return
            }
            buttonInterface('/user/setAllowLogin','是否允许选中的人员登录？');
        })
        //人员列表展示


        //列表功能按钮
        function buttonInterface(URL,txt){
            var deptid=$('.collect .add_back').attr('deptid');
            var val=$('#allSelUser option:checked').val();

            var string='';
            $('.tab table input[type="checkbox"]:checked').each(function(i,n){
                string+=$(this).parent().parent().attr('uId')+',';
            })
//           var str=string.split("").join(",");
            var msg=txt;

            $.layerConfirm({title:msg,content:msg,icon:0},function(){
                $.ajax({
                    type:'post',
                    url:URL,
                    dataType:'json',
                    data:{'uids':string},
                    success:function(res){
//                        deptById(data,$('.tr_befor'));
                        if($('#allSelUser').val()!=undefined &&$('#allSelUser').val()!=''){
                            searchData.notLogin = $('#allSelUser').val();
                        }
                        $('#reload').show();
                        $('.totalNum').html(rsp.obj.length);
                        $("#checkedAll").removeAttr("checked")
                        deptById(searchData,$('.tr_befor'))
                        /*location.reload()*/
                    }
                })
            })

        }

        buildDeptTree();
        function buildDeptTree(){
            $.ajax({
                url: '/hierarchical/getClassifyOrgByAdmin',
                type: 'get',
                dataType: "JSON",
                data: '',
                success: function (obj) {
                    var treeStr = buildChild(obj.obj);
                    
                    $('#downChild').append(treeStr);
                }
            })
        }
        //判断是否开启分支机构
        $.ajax({
            url:"/syspara/queryOrgScope",
            dataType: 'json',
            success:function(res) {
                paraValues = res.object.paraValue;
            }
        })
        function buildChild(data){
            var str = '';
            data.forEach(function(v,i){
                if(v.child && v.child.length>0){
                    str+= '<li><span data-numtrue="1" onclick="imgDown1('+v.deptId+',this)" data-numstring="1" style="height:35px;line-height:35px;padding-left:43px" deptid="'+v.deptId+'" class="childdept"><span class=""></span><img id="image" src="/img/sys/dapt_right.png" alt="" class="imgleft" style="width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;"><a href="javascript:void(0)" class="dynatree-title" title="'+v.deptName+'">'+v.deptName+'</a>' +
                        function () {
                            if (paraValues == '1'&&v.classifyOrg == '1') {
                                return '<img  style="width: 25px" src="/img/common/branch.png"alt="分支机构"title="分支机构">'
                            } else {
                                return "";
                            }
                        }()+
                        '</span><ul style="display:none;" class="dpetWhole0">'+buildChild(v.child)+'</ul></li>';
                }else{
                    str+= '<li><span data-numtrue="1" onclick="imgDown1('+v.deptId+',this)" data-numstring="1" style="height:35px;line-height:35px;padding-left: 43px" deptid="'+v.deptId+'" class="childdept"><span class=""></span><img id="image" src="/img/sys/dapt_right.png" alt="" class="imgleft" style="width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;"><a href="javascript:void(0)" class="dynatree-title" title="'+v.deptName+'">'+v.deptName+'</a>' +
                        function () {
                            if (paraValues == '1'&&v.classifyOrg == '1') {
                                return '<img  style="width: 25px" src="/img/common/branch.png"alt="分支机构"title="分支机构">'
                            } else {
                                return "";
                            }
                        }()+
                        '</span><ul style="display:none;" class="dpetWhole0"></ul></li>';
                }
            });
            return str;
        }

    })
    function userDeptOrder(ele){
        var loadIndex = layer.load(2);
        var userId = $(ele).attr('userid');
        var layerIndex = layer.open({
            title: $(ele).attr('name')+'的部门排序',
            type: 1,
            area: ['600px', '500px'],
            btn: ['确认', '取消'],
            content: '<div class="dept_order_box" style="padding: 8px"><table><thead><tr><th>部门</th><th>排序</th><th>职务</th></tr></thead><tbody id="deptOrderTable"></tbody></table></div>',
            success: function (){
                var option = '<option value="0">请选择</option>'
                $.ajax({
                    url: '/duties/selectUserPostList',
                    type: 'GET',
                    async:false,
                    success: function(res){
                        if (res.flag && res.obj.length > 0) {
                            res.obj.forEach(function(post){
                                option += '<option value="'+post.postId+'">'+post.postName+'</option>'
                            })
                        }
                    }
                });

                $.get('/department/deptOrder', {userId: userId}, function(res){
                    if (res.object.length > 0) {
                        res.object.forEach(function(order){
                            $str = $('<tr orderId="'+order.orderId+'" deptId="'+order.deptId+'" userId="'+userId+'"><td>'+order.deptName+'</td><td><input class="layui-input order_no" type="text" value="'+order.orderNo+'"></td><td><select>'+option+'<select></td></tr>')
                            $str.find('select').val(order.postId)
                            $('#deptOrderTable').append($str)
                        })
                    }
                });
                layer.close(loadIndex)
            },
            yes: function(){
                var userDeptOrders = []
                var $tr = $('#deptOrderTable tr')
                $tr.each(function(){
                    var orderId = parseInt($(this).attr('orderId'))
                    var deptId = parseInt($(this).attr('deptId'))
                    var userId = $(this).attr('userId')
                    var orderNo = parseInt($(this).find('input').val().trim() || 0)
                    var postId = parseInt($(this).find('select').val() || 0)
                    var item = {orderId: orderId, deptId: deptId, userId: userId, orderNo: orderNo, postId: postId}
                    userDeptOrders.push(item)
                })
                $.ajax({
                    url: '/department/updeptOrder',
                    type: 'post',
                    data: {userDeptOrders: JSON.stringify(userDeptOrders)},
                    success: function(res){
                        if (res.flag) {
                            layer.msg('保存成功')
                            layer.close(layerIndex)
                        } else {
                            layer.msg('保存失败')
                        }
                    }
                })
            }
        })
    }
    function Evaluate(word) {
        var low =/^[0-9]*$/;
        var mid=/^[A-Za-z0-9]+$/
        var big=/[0-9a-zA-Z\._\$%&\*\!]/
        if(low.exec(word)){
            return 1;
        }else if(mid.exec(word)){
            return 2;
        }else if(big.exec(word)){
            return 3;
        }else {
            return 1;
        }
    }
    function colorInit() {
        $('#low').css("backgroundColor","#fff")
        $('#medium').css("backgroundColor","#fff")
        $('#height').css("backgroundColor","#fff")

    }
    function validatePwdStrong(value) {
        if (Evaluate(value) == 1) {
            colorInit();
            $('#low').css("backgroundColor","red")
            $('#medium').css("backgroundColor","#fff")
            $('#height').css("backgroundColor","#fff")

        }
        else if (Evaluate(value) == 2) {
            colorInit();
            $('#low').css("backgroundColor","#dfff36")
            $('#medium').css("backgroundColor","#dfff36")
            $('#height').css("backgroundColor","#fff")

        }
        else if (Evaluate(value) == 3) {
            colorInit();
            $('#low').css("backgroundColor","#2dff44")
            $('#medium').css("backgroundColor","#2dff44")
            $('#height').css("backgroundColor","#2dff44")
            $('#height').css("width","70")

        }
    }
    $('body').on('click','#submit',function(){
        var repassword = $('#repassword').val();
        var password = $('#password').val();
        var oldpassword = $('#password').val()
        var reg =/^[0-9]*$/; //数字
        var reg1=/^(?![^a-zA-Z]+$)(?!\D+$).{1,}$/  //字母和数字
        var reg2 = /^.*(?=.{1,})(?=.*\d)(?=.*[A-Za-z])(?=.*[,.:;!@#$%^&*? ]).*$/; //字母、数字、特殊字符
        var reg3 = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{1,}$/  //大写字母、小写字母、数字
        var reg4 = /^.*(?=.{1,})(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[,.:;!@#$%^&*? ]).*$/;  //大写字母、小写字母、数字、特殊字符
        if(password ==''){
            $.layerMsg({content:'<fmt:message code="url.th.PasswordNotEmpty" />！',icon:1},function(){
                return false;
            });
        } else if(repassword == '' ){
            $.layerMsg({content:'<fmt:message code="url.th.VerifynotEmpty" />！',icon:1},function(){
                return false;
            });
        }else if(oldpassword == ''){
            $.layerMsg({content:'<fmt:message code="url.th.TheOldNotEmpty" />！',icon:1},function(){
                return false;
            });
        }else if(repassword == password){
            if(flag == 0){
                if(repassword.toString().length < start){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位',icon:6,time:3000})
                    return false;
                }else if(repassword.toString().length > end){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位',icon:6,time:3000})
                    return false;
                }
            }if(flag == 1 ){
                if(!reg1.test(repassword)){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字',icon:6,time:3000})
                    return false;
                }else if(repassword.toString().length < start){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字',icon:6,time:3000})
                    return false;
                }else if(repassword.toString().length > end){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字',icon:6,time:3000})
                    return false;
                }
            }else if(flag == 2 ){
                if(!reg2.test(repassword)){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字 和 特殊字符',icon:6,time:3000})
                    return false;
                }else if(repassword.toString().length < start){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字 和 特殊字符',icon:6,time:3000})
                    return false;
                }else if(repassword.toString().length > end){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字 和 特殊字符',icon:6,time:3000})
                    return false;
                }
            }else if(flag == 3 ){
                if(!reg3.test(repassword)){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字',icon:6,time:3000})
                    return false;
                }else if(repassword.toString().length < start){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字',icon:6,time:3000})
                    return false;
                }else if(repassword.toString().length > end){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字',icon:6,time:3000})
                    return false;
                }
            }else if(flag == 4 ){
                if(!reg4.test(repassword)){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符',icon:6,time:3000})
                    return false;
                }else if(repassword.toString().length < start){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符',icon:6,time:3000})
                    return false;
                }else if(repassword.toString().length > end){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符',icon:6,time:3000})
                    return false;
                }
            }
            $.ajax({
                type: "post",
                url: "/user/batchUpdatePassWordByUidArray",
                dataType: 'json',
                data: {
                    password:$('#repassword').val(),
                    uidArray:a,
                },
                success: function (obj) {
                    if(obj.flag){
                        layer.closeAll()
                        layer.msg('修改成功')

                    }else{
                        $.layerMsg({content:'<fmt:message code="url.th.PasswordModificationFailed" />！',icon:2},function(){
                        });
                    }
                }
            });
        }else{
            $.layerMsg({content:'<fmt:message code="url.th.TwoPassword" />！',icon:0},function(){
                location.reload();
            });
        }

    });

</script>
</body>
</html>
