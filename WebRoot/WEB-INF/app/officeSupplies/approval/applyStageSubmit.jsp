<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title><fmt:message code="office.storage.submit"/></title>

    <style>
        *{
            font-family: 微软雅黑;
            font-size: 14px;
        }
        .news{
            cursor: pointer;
        }
        .div_tr input {
            float: none;
            height: 28px;
            border-width: 1px;
            border-style: solid;
            border-color: rgb(153, 153, 153);
            border-image: initial;
        }
        .span_td{
            display: inline-block;
            width: 150px;
            text-align: right;
        }
        .inputlayout>ul ul>li.active {
            background: #4898d5;
            color: #fff;
        }
        .inPole{
            display: inline-block;
        }
        a{
            color: #2e8ded;
        }
        .return {
            border-color: #4898d5;
            background-color: #2e8ded;
            color: #fff;
            width: 70px;
            height: 25px;
            border-radius: 5%;
            margin-left: 10px;
            cursor: pointer;
        }

        .jump-ipt{
            float: left;
            width: 30px;
            height: 30px;
        }
        .M-box3 .active{
            margin: 0px 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            background: #2b7fe0;
            font-size: 12px;
            border: 1px solid #2b7fe0;
            color:#fff;
            text-align:center;
            display: inline-block;
        }
        .submit{
            width: 100px;
            height: 30px;
            line-height: 30px;
            text-align: center;
            cursor: pointer;
            background: #2e8ded;
            color: #ffffff;
            border-radius: 4px;
            margin: 15px auto;
        }
        .M-box3 a{
            margin: 0 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            font-size: 12px;
            display: inline-block;
            text-align:center;
            background: #fff;
            border: 1px solid #ebebeb;
            color: #bdbdbd;
            text-decoration: none;
        }
    </style>
    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/css/office/depository/index.css">
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>

</head>
<body style="background: #fff">
<div class="maintop clearfix" >
    <p style="margin-left: 10px">
        <label><fmt:message code="office.storage.submit"/></label>
    </p>
</div>



<div class="mainBottom" style="margin-top: 10px;">
    <table>
        <thead>
        <tr>
            <%--  <th class="th" style="color: #2F5C8F;" width="5%" align="center">选择</th>--%>
            <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="vote.th.OfficeName" /></th>
            <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="vote.th.Registration" /></th>
            <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="vote.th.NumberApplications" /></th>
            <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="vote.th.OperationDate" /></th>
            <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="event.th.DepartmentApprover" /></th>
            <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="journal.th.Remarks" /></th>
            <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="notice.th.state" /></th>
            <th class="th" style="color: #2F5C8F;" width="20%" align="center"><fmt:message code="menuSSetting.th.menuSetting" /></th><%--操作--%>
        </tr>
        </thead>
        <tbody id="j_tb">
        <tr>

        </tr>
        </tbody>
    </table>
    <div id="dbgz_page" class="M-box3 fr" style="float: right; margin-top: 1%">

    </div>
    <div class="divBtn" style="display: flex">
        <div class="submit"><fmt:message code="diary.th.remand"/></div>
    </div>
</div>
</body>
<script>
    var transId;
    var proId;
    $(function(){
        init();
    })
    //点击复选框
    $("#mainBottom").on('click', '#notice_tr', function () {
        /*    alert('111');*/
        var state = $(this).find('.checkChild').prop("checked");
        if (state == true) {
            $(this).find('.checkChild').prop("checked", true);
            $(this).addClass('bgcolor');
        } else {
            $('#checkedAll').prop("checked", false);
            $(this).find('.checkChild').prop("checked", false);
            $(this).removeClass('bgcolor');
        }
        var child = $(".checkChild");
        for (var i = 0; i < child.length; i++) {
            var childstate = $(child[i]).prop("checked");
            if (state != childstate) {
                return
            }
        }
        $('#notice_tr').prop("checked", state);
    })




    //点击全选
    $('#j_tb').on('click', '#checkedAll', function () {
        /*alert('111');*/
        var state = $(this).prop("checked");
        if (state == true) {
            $(this).prop("checked", true);
            $(".checkChild").prop("checked", true);
            $(this).parents('tr').siblings('#notice_tr').addClass('bgcolor');
        } else {
            $(this).prop("checked", false);
            $(".checkChild").prop("checked", false);
            ;
            $(this).parents('tr').siblings('#notice_tr').removeClass('bgcolor');
        }
    })

    //进行多项删除
    $("#j_tb").on("click",".return",function () {
        var transIds = "";
        $("#j_tb .checkChild:checkbox:checked").each(function () {
            var transId = $(this).attr("conid");
            if(transId!=""){
                transIds += transId+",";
            }
        })
        if (transIds.length<=0) {
            $.layerMsg({content: '<fmt:message code="vote.th.Returned" />', icon: 0});
        } else {
            layer.confirm('<fmt:message code="vote.th.AreReturn" />？', {
                btn: [' <fmt:message  code="global.lang.ok"/>', ' <fmt:message  code="depatement.th.quxiao"/>'], //按钮
                title: " <fmt:message code="vote.th.Restitution" />"
            }, function () {
                //确定删除，调接口
                $.ajax({
                    type: 'post',
                    url: '/officetransHistory/returnObject',
                    dataType: 'json',
                    data: {'transIds': transIds},
                    success: function (json) {
                        if(json.flag){
                            layer.msg('<fmt:message code="vote.th.ReturnSuccess" />', {icon: 6});
                            queryList();
                        }
                    }
                })
            },function (){
                layer.closeAll();
            });
        }
    })


    //初始化列表
    /*function init(){
        $.ajax({
            url: '/officetransHistory/getMyHistroy',
            type: 'get',
            dataType: 'json',
            data:{
                page:1,
                pageSize:10,
                useFlag:true
            },
            success: function (result) {
                var str="";
                var str1="";
                var arr =result.obj;
                for(var i=0;i<arr.length;i++){
                    if(arr[i].transState=="1"){
                       str1='<a href="javascript:;" class="details" onclick="detail('+arr[i].transId+');">'+"<fmt:message code="file.th.detail" />"+'</a>&nbsp'
                    }
                    else{
                        str1='<a href="/officetransHistory/OfficeProductApply?editFlag=1&transId='+arr[i].transId+'" class="details">'+"<fmt:message code="global.lang.edit" />"+'</a>&nbsp'+
                        '<a href="javascript:;" onclick="deleteone('+arr[i].transId+')"><fmt:message code="global.lang.delete" /></a>&nbsp'
                    }
                    // "<td style='width:8%;'align='center';><input class='checkChild'  type='checkbox' conid='" + arr[i].transId + "' name='check' value=''></td>"+
                    str+='<tr>'+
                        '<td>'+arr[i].proName+'</td>';
                    if(arr[i].transFlag==1){
                        str+='<td><fmt:message code="vote.th.user" /></td>';
                    }else if(arr[i].transFlag==2){
                        str+='<td><fmt:message code="vote.th.borrow" /></td>';
                    }
                     str+= '<td>'+arr[i].transQty+'</td>'+
                        '<td>'+arr[i].transDate+'</td>'+
                        '<td>'+arr[i].deptManagerName+'</td>'+
                        '<td>'+arr[i].remark+'</td>';
                    if(arr[i].transState=="01"){
                        str+='<td><fmt:message code="vote.th.ApprovalDepartment" /></td>';
                    }else if(arr[i].transState=="02"){
                        str+='<td><fmt:message code="vote.th.ToAdministrator" /></td>';
                    }else if(arr[i].transState=="1"){
                        str+='<td><fmt:message code="sup.th.Agree" /></td>';
                    }else if(arr[i].transState=="21"){
                        str+='<td><fmt:message code="vote.th.DisapprovaApproval" /></td>';
                    }else if(arr[i].transState=="22"){
                        str+='<td><fmt:message code="vote.th.StorekeeperDismissal" /></td>';
                    }
                    str+='<td>'+str1 +'</td>'+
                        '</tr>';
                }
               /!* var last_str = "<tr class='last_str'><td style='width: 65px;display:block;'><input id='checkedAll' style='margin-left:12px;' class='checkChild' type='checkbox' conid='' name='check' value=''><fmt:message code="notice.th.allchose" /></td>"+
                    "<td class='btnStyle return_btn'><button class='return' id='return_btn'>批量归还</button></td><td class=''></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                 *!/ $('.mainBottom table tbody').html(str);
            }
        })
    }*/

    //列表带分页
    function init() {
        var ajaxPageLe = {
            data: {
                page: 1,//当前处于第几页
                pageSize: 10,//一页显示几条
                useFlag: true
                // computationNumber:null
            },
            page: function () {
                var me = this;
                $.ajax({
                    url: '/officetransHistory/getMyHistroy?reflag='+'save',
                    type: 'get',
                    dataType: 'json',
                    data:me.data,
                    success: function (result) {
                        var str = "";

                        var str1 = "";
                        var arr = result.obj;

                        for (var i = 0; i < arr.length; i++) {
                            transId = arr[i].transId;
                            if (arr[i].transState == "1") {

                                str1 = '<a href="javascript:;" class="details" onclick="detail(' + arr[i].transId + ');">' + "<fmt:message code="file.th.detail" />" + '</a>&nbsp' +
                                    '<a href="javascript:;" class="delete2" onclick="delete2(' + arr[i].transId + ');">'+"<fmt:message code="license.delete"/>"+'</a>'

                            }
                            else {
                                str1 = '<a href="javascript:;" class="details" onclick="detail(' + arr[i].transId + ');">' + "<fmt:message code="file.th.detail" />" + '</a>&nbsp' +
                                    '<a href="javascript:;" class="delete2" onclick="delete2(' + arr[i].transId + ');">'+"<fmt:message code="license.delete"/>"+'</a>'

                            }
                            // "<td style='width:8%;'align='center';><input class='checkChild'  type='checkbox' conid='" + arr[i].transId + "' name='check' value=''></td>"+
                            str += '<tr>' +
                                '<td>'+arr[i].proName+'</td>';
                            if (arr[i].transFlag == 1) {
                                str += '<td><fmt:message code="vote.th.user" /></td>';
                            } else if (arr[i].transFlag == 2) {
                                str += '<td><fmt:message code="vote.th.borrow" /></td>';
                            }
                            str += '<td>' +arr[i].transQty + '</td>' +
                                '<td>' + arr[i].transDate + '</td>' +
                                '<td>' + arr[i].deptManagerName + '</td>' +
                                '<td>' + arr[i].remark + '</td>';
                            if (arr[i].transState == "01") {
                                str += '<td><fmt:message code="vote.th.ApprovalDepartment" /></td>';
                            } else if (arr[i].transState == "02") {
                                str += '<td><fmt:message code="vote.th.ToAdministrator" /></td>';
                            } else if (arr[i].transState == "1") {
                                str += '<td><fmt:message code="sup.th.Agree" /></td>';
                            } else if (arr[i].transState == "21") {
                                str += '<td><fmt:message code="vote.th.DisapprovaApproval" /></td>';
                            } else if (arr[i].transState == "22") {
                                str += '<td><fmt:message code="vote.th.StorekeeperDismissal" /></td>';
                            }
                            str += '<td>' + str1 + '</td>' +
                                '</tr>';
                        }
                        /* var last_str = "<tr class='last_str'><td style='width: 65px;display:block;'><input id='checkedAll' style='margin-left:12px;' class='checkChild' type='checkbox' conid='' name='check' value=''>
                        <%--<fmt:message code="notice.th.allchose" /></td>"+--%>
                    "<td class='btnStyle return_btn'><button class='return' id='return_btn'>批量归还</button></td><td class=''></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                 */
                        $('.mainBottom table tbody').html(str);
                        me.pageTwo(result.totleNum, me.data.pageSize, me.data.page)

                    }
                })

            },
            pageTwo: function (totalData, pageSize, indexs) {
                var mes = this;
                $('#dbgz_page').pagination({
                    totalData: totalData,
                    showData: pageSize,
                    jump: true,
                    coping: true,
                    homePage: '',
                    endPage: '',
                    current: indexs || 1,
                    callback: function (index) {
                        mes.data.page = index.getCurrent();
                        mes.page();
                    }
                });
            }
        }
        ajaxPageLe.page();

    }

    //删除
    function deleteone(id) {
        layer.confirm('<fmt:message code="workflow.th.que" />？', {
            btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'], //按钮
            title: "<fmt:message code="vote.th.DeleteApplication" />"
        }, function () {
            //确定删除，调接口
            $.ajax({
                url: '/officetransHistory/deleteObject',
                type: 'get',
                data:{
                    transId:id
                },
                dataType: 'json',
                success: function (result) {
                    if(result.flag) {
                        $.layerMsg({content: '<fmt:message code="workflow.th.delsucess" />！', icon: 1}, function () {
                            init();
                        });
                    }else{
                        $.layerMsg({content: json.msg+'！', icon: 1}, function () {
                        });
                    }
                }
            })
        }, function () {
            layer.closeAll();
        });
    }

    function updateTransState(id) {
        layer.confirm('<fmt:message code="office.already.it"/>？', {
            btn: ['<fmt:message code="office.yes"/>', '<fmt:message code="office.Not.yet"/>'], //按钮
            title: "<fmt:message code="office.confirmation"/>"
        }, function () {
            //确定已经领取到了，调接口
            $.ajax({
                url: '/officetransHistory/upGrantStatus',
                type: 'get',
                data:{
                    grantStatus:2,
                    transId:id
                },
                dataType: 'json',
                success: function (result) {
                    if(result.flag) {
                        $.layerMsg({content: '<fmt:message code="office.successful"/>！', icon: 1}, function () {
                            init();
                        });
                    }else{
                        $.layerMsg({content: '<fmt:message code="office.administrator"/>！', icon: 1}, function () {
                        });
                    }
                }
            })
        }, function () {
            layer.closeAll();
        });
    }

    //详情展示
    function detail(transId) {
        $.ajax({
            url: '/officetransHistory/getObjectById',
            type: 'get',
            dataType: 'json',
            data: {
                transId:transId,
                reflag:'detailed'
            },
            success: function (obj) {
                $.ajax({
                    type:'get',
                    url:'/officetransHistory/selectDetailed?reflag='+'detailed'+'&transId='+transId,
                    dataType:'json',
                    data:data,
                    success:function (res) {
                        var datas=res.obj;
                        var str='';
                        if(res.flag){
                            if(datas.length > 0){
                                for(var i=0;i<datas.length;i++){
                                    proId=datas[i].proId;
                                    transQty=datas[i].transQty;
                                    str +='<tr class="divTr" data-proId="'+datas[i].proId+'" data-TypeId="'+datas[i].officeProtype+'" data-depositoryId="'+datas[i].depositoryId+'">' +
                                        '<td class="proName">'+datas[i].proName+'</td>' +
                                        '<td class="proStockTd" value="'+datas[i].proStock+'">'+datas[i].proStock+'</td>' +
                                        '<td>￥<span class="unitPrice" value="'+datas[i].proPrice+'">'+datas[i].proPrice+'</span></td>' +
                                        '<td><div class="jia" ></div>' +
                                        '<input disabled="disabled" style= "width: 30px; text-align: center" name="dataNum" class="dataNum" value="'+datas[i].transQty+'">' +
                                        '<td>￥<span class="totalPrice">'+datas[i].totalPrice+'</span></td>' +
                                        '<td><a href="javascript:;" class="delete1" onclick="delete1(' + datas[i].proId + ');">'+"<fmt:message code="license.delete"/>"+'</a></td>' +
                                        '</tr>'
                                }
                            }
                            $('#trList').html(str)
                        }
                    }
                })
                var data = obj.object;
                var str = '';
                layer.open({
                    type: 1,
                    title: ['<fmt:message code="vote.th.DetailsClaim" />', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['960px', '550px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['<fmt:message code="global.lang.close" />'],
                    content: '<div class="table" style="margin-top: 10px"><table style="margin:auto;width:90%">' +
                        '<tr><td width="20%"><span class="span_td"><fmt:message code="sup.th.ApplicationType" />：</span></td><td style="text-align: left;"><span id="transFlag"></span></td><td width="20%"><span class="span_td"><fmt:message code="sup.th.Applicant" />：</span></td><td style="text-align: left;"><span>' + data.borrowerName + '</span></td><tr>' +
                        '<tr><td width="20%"><span class="span_td"><fmt:message code="vote.th.DepartmentStatus" />：</span></td><td style="text-align: left;"><span id="deptApprove"></span></td><td width="20%"><span class="span_td"><fmt:message code="sup.th.ApplicationTime" />：</span></td><td style="text-align: left;"><span>' + data.transDate + '</span></td><tr>' +
                        '   <table  id="pagediv" border="0" style="margin:auto;margin-top:50px;width:90%" style="border-collapse: collapse">\n' +
                        '        <thead>\n' +
                        '            <tr>\n' +
                        '                <th style="height:50px"><fmt:message code="main.th.name"/></th>\n' +
                        '                <th>库存</th>\n' +
                        '                <th>单价</th>\n' +
                        '                <th style="width: 150px;"><fmt:message code="event.th.Number"/></th>\n' +
                        '                <th style="width: 150px;"><fmt:message code="office.Total.price"/></th>\n' +
                        '                <th style="width: 150px;"><fmt:message code="notice.th.operation"/></th>\n' +
                        '            </tr>\n' +
                        '        </thead>\n' +
                        '        <tbody id="trList">\n' +
                        '        </tbody>\n' +
                        '    </table>\n' +
                        '</div>' +
                        '',
                    success: function () {
                        if (data.transFlag == 1) {
                            $("#transFlag").html("<fmt:message code="vote.th.user" />");
                        } else if (data.transFlag == 2) {
                            $("#transFlag").html("<fmt:message code="vote.th.borrow" />");
                        }

                        if (data.transState == "01") {
                            $("#deptApprove").html("<fmt:message code="meet.th.PendingApproval" />");
                        } else if (data.transState == "02" || data.transState == "1") {
                            $("#deptApprove").html("<fmt:message code="vote.th.Approved" />");
                        } else if (data.transState == "21") {
                            $("#deptApprove").html("<fmt:message code="meet.th.unratified" />");
                        }
                    }
                })

            }

        })
    }
    function delete1(id){
        $.ajax({
            type:'get',
            url:'/officetransHistory/deleteCommodity?transId='+transId+'&proId='+id,
            dataType:'json',
            data:{
                flag:1,
                transQty:transQty
            },
            success:function (res) {
                if(res.flag){
                    layer.msg('<fmt:message code="license.delsucess"/>！',{icon:1,time:2000},function () {
                        layer.closeAll();
                        location.reload();
                    })
                }else {
                    layer.msg('<fmt:message code="license.deleSucess"/>！'+res.msg,{icon:5});
                }
            }
        })
    }
    function delete2(id){
        $.ajax({
            type:'post',
            url:'/officetransHistory/deleteByTransId?transId='+transId,
            dataType:'json',
            data:{
                flag:1
            },
            success:function (res) {
                if(res.flag){
                    layer.msg('<fmt:message code="license.delsucess"/>！',{icon:1,time:2000},function () {;
                        location.reload();
                    })
                }else {
                    layer.msg('<fmt:message code="license.deleSucess"/>！'+res.msg,{icon:5});
                }
            }
        })
    }
    $('.submit').on("click",function () {
        if(transId==undefined){
            layer.msg('<fmt:message code="office.failed"/>！',{icon:5});
            return false;
        }
        var arr=[];
        var result = true;
        var result2 = false;
        $('#trList').find('.divTr').each(function (index, elem) {
            var dataNum=$(elem).find('.dataNum').val(); //数量
            var proStockTd=$(elem).find('.proStockTd').html(); //库存
            if(parseInt(dataNum) > parseInt(proStockTd)){
                alert("<fmt:message code="office.submit"/>");
                result = false;
                return false;
            }
            var object={};
            if(dataNum != '0'){
                object.proStock=$(elem).find('.proStockTd').text();
                object.proPrice=$(elem).find('.unitPrice').text();
                object.proName=$(elem).find('.proName').text();
                object.totalPrice=$(elem).find('.totalPrice').text();
                object.proId=$(elem).attr('data-proId');
                object.typeId=$(elem).attr('data-TypeId');
                object.depositoryId=$(elem).attr('data-depositoryId');
                object.transQty=$(elem).find('.dataNum').val();
                arr.push(object);
                result2 = true;
            }
        });
        layer.open({

            type: 1,
            title: ['<fmt:message code="office.submission"/>'],
            area: ['250px', '150px'],
            shadeClose: true, //点击遮罩关闭
            btn: ['<fmt:message code="license.determine"/>', '<fmt:message code="license.cancel"/>'],
            content: '<div style="margin-left: 15px;margin-top: 15px"><fmt:message code="office.sure.submit"/>？</div>',
            yes: function (index) {
                $(".layui-layer-btn0").css("pointer-events","none");
                $.ajax({
                    type:'get',
                    url:'/officetransHistory/selectDetailed?reflag='+'submit'+'&transId='+transId,
                    dataType:'json',
                    data:{
                        jsonStr:JSON.stringify(arr),
                        deptManager:$('#deptUser').attr('user_id'),
                        remark:$('#remark').val(),
                        flag:1
                    },
                    success:function (res) {
                        if(res.flag){
                            layer.msg('<fmt:message code="event.th.SubmitSuccessfully"/>！',{icon:1,time:1000},function () {
                                $(".layui-layer-btn0").css("pointer-events","auto");
                                location.reload();
                            });
                        }else {
                            layer.msg('<fmt:message code="office.Submission.failed"/>！',{icon:5},function (){
                                $(".layui-layer-btn0").css("pointer-events","auto");
                            });
                        }
                    }
                })

            }
        })

        //    点击添加
        $('.addUser').on("click",function () {
            user_id='deptUser';
            $.popWindow("../common/selectUser");
        })
        $('.clearUser').on("click",function () {
            $('#deptUser').attr('username','');
            $('#deptUser').attr('dataid','');
            $('#deptUser').attr('user_id','');
            $('#deptUser').attr('userprivname','');
            $('#deptUser').val('');
        });
    });

</script>
</html>
