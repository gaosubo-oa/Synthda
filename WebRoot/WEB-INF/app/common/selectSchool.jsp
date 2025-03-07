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
    <title><fmt:message code="common.th.SeleDepart" /></title><%--选择部门--%>
    <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/common/style.css" />
    <link rel="stylesheet" type="text/css" href="../css/common/select.css" />
    <!-- 	<link rel="stylesheet" type="text/css" href="../css/common/ui.dynatree.css"> -->
    <link rel="stylesheet" type="text/css" href="../css/common/org_select.css">
    <link rel="stylesheet" type="text/css" href="../lib/easyui/themes/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/easyui/themes/icon.css"/>
    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>
    <script src="/js/base/base.js"></script>
    <script type="text/javascript" src="../lib/easyui/jquery.easyui.min.js" ></script>
    <script type="text/javascript" src="../lib/easyui/tree.js" ></script>

</head>
<style>
    #dept_menu{
        overflow-x: auto;
    }
    .left_choose ul li div,.left_choose ul li h1,.left_choose ul img{
        float:left;
    }
    .left_choose ul img{
    <!-- margin-top:8px; -->
    }
    .left_choose ul li{
        width:80%;
        height:20px;
    <!-- background:red; -->
        margin-top:10px;
    }
    .mar{
        margin-left:10%;
    }
    .name li{
        list-style-type:none;
    }
    .choose{
        background:#D6E4EF !important;
    }
    #block-right-all-dept{
        display: none!important;
    }
</style>
<body>
<!-- //开始 -->
<!-- //头部 -->

<div id="north">
    <div id="navMenu" style="width:auto;">
        <a href="#" title='<fmt:message code="common.th.selPerson" />' class="tab_btn"  block="selected" hidefocus="hidefocus"><span><fmt:message code="common.th.selected" /></span></a><%--已选人员  已选--%>
        <a href="#" title='<fmt:message code="common.th.selByDepart" />' block="dept" hidefocus="hidefocus" class=" tab_btn active"><span><fmt:message code="userManagement.th.department" /></span></a><%--按部门选择   部门--%>

        <a href="#" block="query" class="tab_btn" hidefocus="hidefocus" style="display:none;"><span><fmt:message code="workflow.th.sousuo" /></span></a><%--搜索--%>
    </div>
    <div id="navRight" style="float:right;">
        <div class="search">
            <div class="search-body">
                <div class="search-input"><input notlogin_flag="" id="keyword" type="text" value=""></div>
                <div id="search_clear" class="search-clear" style="display:none;"></div>
            </div>
        </div>
    </div>
</div>

<!-- //内容 -->
<div>
    <div class="main-block" id="deptBox" style="display:block;">
        <div class="left moduleContainer" id="dept_menu">
            <div class="tree">
                <div class="pickCompany">
                    <span  class="childdept" style="display: none;">
                        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 5px;margin-left: 5px;margin-bottom: 4px;">
                        <a href="javascript:void(0)" class="dynatree-title" onclick="initTree();"  id="companyName" title=""></a>
                    </span>
                </div>
                <ul class="dynatree-container dynatree-no-connector" style="margin-left: 10px;" id="deptOrg">
                </ul>
            </div>

        </div>
        <div class="right" id="dept_item">
            <div class="block-right" id="dept_item_2">
                <!-- 部门名 -->
                <div class="block-right-header" title="" id="block-right-header"></div>
                <div id="block-right-all-dept" style="display: none" class="block-right-remove">
                    <span class="name" style="display: block">全部部门</span>
                </div>
                <div id="block-right-add" class="block-right-add"><fmt:message code="meet.th.addAll" /></div><%--全部添加--%>
                <div id="block-right-remove" class="block-right-remove"><fmt:message code="meet.th.DeleteAll" /></div><%--全部删除--%>

                <div class="userItem">

                </div>
            </div>
        </div>
    </div>
    <!-- 已选 -->
    <div class="main-block" id="selectedDox" >
        <div class="left moduleContainer" id="dept_menu">
            <div class="tree">
                <ul class="dynatree-container dynatree-no-connector" id="deptOrg">
                </ul>
            </div>

        </div>
        <div class="right" id="dept_item">
            <div class="block-right" id="dept_item_2">
                <!-- 部门名 -->

                <div id="block-right-remove" class="block-right-remove"><fmt:message code="meet.th.DeleteAll" /></div><%--全部删除--%>

                <div class="userItem">

                </div>
            </div>
        </div>
    </div>


</div>
<!-- //结束 -->
<div id="south">
    <input type="button" class="BigButtonA" value='<fmt:message code="global.lang.ok" />' onclick="close_window();">&nbsp;&nbsp;<%--确定--%>
</div>
</body>
<script>
    var urlType=location.href.split('?')[1];
    function close_window(){
        var itemsArr = $('#selectedDox .userItem .block-right-item');
        var itemnum=location.href.split('?')[1]
        if(itemnum==0){
            if(itemsArr.length>1){
                layer.msg('<fmt:message code="common.th.onlyChooseOne" />', {icon: 5});
                <%--alert('<fmt:message code="common.th.onlyChooseOne" />')/*只能选择一个*/--%>
                return
            }

        }



        var selectItemsId = '';
        var selectItemsName = '';
        var selectdeptNo = '';
        var selectschoolNum=""
        for(var i=0;i<itemsArr.length;i++){
            var obj = itemsArr.eq(i);
            selectItemsId+=(obj.attr("deptId")+',');
            selectItemsName+=(obj.attr("deptName")+',');
            selectdeptNo+=(obj.attr("deptNo")+',');
            selectschoolNum += (obj.attr("schoolNum"))
        };
        //alert(selectItemsId);
        if($('#block-right-all-dept').hasClass('active')){
            selectItemsName='全部部门';
            selectItemsId='ALL_DEPT';
            selectdeptNo='';
        }
        parent.opener.document.getElementById(parent.opener.dept_id).value=selectschoolNum;
//        parent.opener.document.getElementById(parent.opener.dept_id).value=selectItemsName;
        parent.opener.document.getElementById(parent.opener.dept_id).setAttribute('deptname',selectItemsName);
        console.log(selectschoolNum)
        parent.opener.document.getElementById(parent.opener.dept_id).setAttribute('deptId',selectItemsId);
        parent.opener.document.getElementById(parent.opener.dept_id).setAttribute('deptNo',selectdeptNo);
        if(typeof parent.opener.cbCallBack=='function'){
            parent.opener.cbCallBack(selectItemsId)
        }
        window.close();
    }
    var initTree ;
    var dep_id=parent.opener.document.getElementById(parent.opener.dept_id).getAttribute('deptId');
    var deptname=parent.opener.document.getElementById(parent.opener.dept_id).getAttribute('deptname');
    var deptno=parent.opener.document.getElementById(parent.opener.dept_id).getAttribute('deptno');
    var schoolNum=parent.opener.document.getElementById(parent.opener.dept_id).value
    $(function(){

        buildDefaultItem();
        var numIndex = 0;
        function buildDefaultItem(){
            var arr = ''
            if(dep_id && deptname && deptno){
                dep_id = dep_id.split(',');
                deptname =deptname.split(',');
                deptno =deptno.split(',');
                schoolNum=schoolNum.split(',')

                for(var i=0;i<dep_id.length;i++){
                    if(dep_id[i]) {
                        arr+='<div class="block-right-item active" deptNo="'+deptno[i]+'" deptName="'+deptname[i]+'" schoolNum="'+schoolNum[i]+'"  id="'+dep_id[i]+'" deptId="'+dep_id[i]+'" title="'+deptname[i]+'"><span class="name">'+deptname[i]+'<span class="schoolNum" style="padding-left: 10px;">'+schoolNum[i]+'</span><span class="status"></span></span></div>';
                    }
                }
                $('#selectedDox .userItem').append(arr);
            }
        };




        $('#block-right-all-dept').click(function () {
            if($(this).hasClass('active')){
                $(this).removeClass('active')
            }else {
                $(this).addClass('active')
            }

            $('#block-right-remove').trigger('click')
        })

        var globalIndex = 0;
        initTree = function(){
            $('#block-right-header').show()
            $('#block-right-add').show()
            $('#block-right-all-dept').show()
            $('#block-right-remove').show()
            $('#deptOrg').tree({
                url: '../department/getChDeptfq?deptId=0',
                animate:true,
                loadFilter: function(node){
                    var arr = convert(node.obj);
                    return arr;
                },
                onClick:function(node){
                    build(node.id);
                    $(this).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
                    node.state = node.state === 'closed' ? 'open' : 'closed';
                },
                onBeforeExpand:function(node,param){
                    $('#deptOrg').tree('options').url = "../department/getChDeptfq?deptId=" + node.id;// change the url
                }

            });
        };
        $.ajax({
            url:'../sys/showUnitManage',
            type:'get',
            dataType:'json',
            success:function(obj){
                $('#companyName').html(obj.object.unitName);
                $('.childdept').show();
                initTree();
            }
        });


        function TreeNode(id,text,state,children){
            this.id = id;
            this.text = text;
            this.state = state;
            this.children = children;
        }
        function convert(data){
            var arr = [];
            var tr = '';
            data.forEach(function(v,i){
                if(v.deptId){
                    var node = new TreeNode(v.deptId,v.deptName,"closed")
                    arr.push(node);
                    tr+='<div class="block-right-item '+function () {
                        if(dep_id) {
                            var user_idArr;
                            if(Array.isArray(dep_id)){
                                user_idArr= dep_id;
                            }else {
                                user_idArr= dep_id.split(',');
                            }

                            var bool = false;
                            for (var i = 0; i < user_idArr.length; i++) {
                                if (v.deptId == user_idArr[i]) {
                                    bool = true;
                                    break;
                                }
                            }
                            if (bool) {
                                return 'active';
                            }else {
                                return ''
                            }
                        }else {
                            return ''
                        }
                    }()+'" deptNo="'+v.deptNo+'" deptName="'+v.deptName+'" schoolNum="'+v.deptCode+'" id="'+v.deptId+'"  deptId="'+v.deptId+'" title="'+v.deptName+'"><span class="name" >'+v.deptName+'<span class="schoolNum" style="padding-left: 10px;">'+v.deptCode+'</span><span class="status"></span></span></div>';

                }
            });
            $('#deptBox .userItem').html(tr);
            return arr;
        }
        //组织
        $('.tab_btn').click(function(){
            var type = $(this).attr('block');
            $(this).addClass("active").siblings().removeClass('active');
            switch(type){
                case "selected":
                    $('#selectedDox').show().siblings().hide();
                    break;
                case "dept":
                    $('#deptBox').show().siblings().hide();
                    break;
                case "priv":

                    break;
                case "group":

                    break;
                case "query":

                    break;
            }
        });
        function build(id){
            $.ajax({
                url:'../department/getChDept?deptId='+id,
                type:'get',
                dataType:'json',
                success:function(obj){
                    if(obj.flag){
                        var data = obj.obj;
                        var tr = '';
                        var num=0;
                        $('#block-right-header').show()
                        $('#block-right-add').show()
                        $('#block-right-remove').show()
                        $('#block-right-all-dept').hide()
                        data.forEach(function(v,i){
                            if(v.deptId){

                                tr+='<div class="block-right-item '+function () {
                                    if(dep_id) {
                                        var user_idArr;
                                        if(Array.isArray(dep_id)){
                                            user_idArr= dep_id;
                                        }else {
                                            user_idArr= dep_id.split(',');
                                        }

                                        var bool = false;
                                        for (var i = 0; i < user_idArr.length; i++) {
                                            if (v.deptId == user_idArr[i]) {
                                                bool = true;
                                                break;
                                            }
                                        }
                                        if (bool) {
                                            return 'active';
                                        }else {
                                            return ''
                                        }
                                    }else {
                                        return ''
                                    }
                                }()+'" deptNo="'+v.deptNo+'" deptName="'+v.deptName+'" id="'+v.deptId+'" schoolNum="'+v.deptCode+'" deptId="'+v.deptId+'" title="'+v.deptName+'"><span class="name">'+v.deptName+'<span class="schoolNum" style="padding-left: 10px;">'+v.deptCode+'</span><span class="status"></span></span></div>';
                            }else {
                                num++;
                            }
                        });
                        if(data.length==num){
                            $('#block-right-header').hide()
                            $('#block-right-add').hide()
                            $('#block-right-all-dept').hide()
                            $('#block-right-remove').hide()
                            tr='<div style="width: 230px;height: 200px;margin: 20px auto;text-align: center">' +
                                '<img src="/img/common/dianjikong.png" style="margin-top: 20px;" alt="">\
                                <span style="width: 100%;display: inline-block;margin-top: 10px;\
                            font-size: 15px;\
                            font-weight: bold;">本部门下暂无下级部门</span>' +
                                '</div>'
                        }




                        $('#deptBox .userItem').html(tr);

                    }
                }
            });
        }
        $('#dept_item').on("click",".block-right-item",function(){
            var that = $(this);
            $('#block-right-all-dept').removeClass('active')
            if(that.attr('class').indexOf('active') > 0){
                that.removeClass("active");
                if( $('#selectedDox .userItem #'+that.attr('deptId')).length > 0){

                    $('#selectedDox .userItem #'+that.attr('deptId')).remove();
                }
            }else{
                var schoolNum=that.find('.schoolNum').html();
                if(schoolNum == ''){
                    alert('请到部门管理中设置编码');
                }else {

                    var divObj = $(that.prop("outerHTML"));
                    divObj.addClass("active");
                    that.addClass("active");




                    if( $('#selectedDox .userItem #'+that.attr('deptId')).length < 1){
                        $('#selectedDox .userItem').append(divObj);
                    }
                    if(urlType==0){
                        that.siblings('div').removeClass('active')
                        $('#selectedDox .userItem').empty()
                        $('#selectedDox .userItem').append(divObj);
                    }
                }


            }

        });

        $('#selectedDox #block-right-remove').on('click',function () {
            $('#selectedDox .userItem .block-right-item').each(function() {
                if( $('#deptBox .userItem #'+$(this).attr('deptid')).length > 0){
                    $('#deptBox .userItem #'+$(this).attr('deptid')).removeClass('active');
                }
            });
            $('#selectedDox .userItem .block-right-item').remove();
        });

        $('#selectedDox .userItem ').on('click','.block-right-item',function () {
            $('#deptBox .userItem #'+$(this).attr('deptid')).removeClass('active');
            $(this).remove();
        });

        $('#deptBox #block-right-add').on('click',function () {
            $('#block-right-all-dept').removeClass('active')
            $('#deptBox .userItem .block-right-item').addClass('active');
            var str  = '';
            $('#deptBox .userItem .active').each(function (i,v) {
                if( $('#selectedDox .userItem #'+$(this).attr('deptid')).length < 1){
                    str += $(this).prop("outerHTML");
                }
            });
            $('#selectedDox .userItem').append(str);
        });

        $('#deptBox #block-right-remove').on('click',function () {
            $('#deptBox .userItem .active').each(function (i,v) {

                if( $('#selectedDox .userItem #'+$(this).attr('deptid')).length > 0){

                    $('#selectedDox .userItem #'+$(this).attr('deptid')).remove();
                }
            });
            $('#deptBox .userItem .block-right-item').removeClass('active');
        });

        $('.tree .dynatree-container').on('click','.childdept',function(){
            var  that = $(this);
            getChDept(that.next(),that.attr('deptid'));
            var title=that.find('a').text();
            $('.block-right-header').html(title);
        });

        $('.block-right').on('mouseover','div',function(){
            $(this).addClass('hover');
        });
        $('.block-right').on('mouseout','div',function(){
            $(this).removeClass('hover');
        });

        //搜索
        $('#keyword').bind('input propertychange', function() {
            var text = encodeURI($(this).val());
            if(text!= ''){
                throttle(autodivheights,text);
            }else{
                $('#deptBox .userItem').html('');
            }
        });

    });

    function throttle(method,text) {
        clearTimeout(method.tId);
        method.tId=setTimeout(function(){
            method.call(method,text);
        },500);
    }
    function autodivheights(text) {
        $.ajax({
            type: "get",
            url: "../department/selByLikeDeptName?deptName=" + text,
            dataType: 'JSON',
            success: function (res) {
                if(res.flag){
                    var data = res.obj;
                    var tr = '';
                    $('#block-right-header').show()
                    $('#block-right-add').show()
                    $('#block-right-remove').show()
                    $('#block-right-all-dept').hide()
                    data.forEach(function(v,i){
                        if(v.deptId){
                            tr+='<div class="block-right-item '+function () {
                                if(dep_id) {
                                    var user_idArr;
                                    if(Array.isArray(dep_id)){
                                        user_idArr= dep_id;
                                    }else {
                                        user_idArr= dep_id.split(',');
                                    }

                                    var bool = false;
                                    for (var i = 0; i < user_idArr.length; i++) {
                                        if (v.deptId == user_idArr[i]) {
                                            bool = true;
                                            break;
                                        }
                                    }
                                    if (bool) {
                                        return 'active';
                                    }else {
                                        return ''
                                    }
                                }else {
                                    return ''
                                }
                            }()+'" deptNo="'+v.deptNo+'" deptName="'+v.deptName+'" id="'+v.deptId+'" deptId="'+v.deptId+'" schoolNum="'+v.deptCode+'" title="'+v.deptName+'"><span class="name">'+v.deptName+'<span class="schoolNum" style="padding-left: 10px;">'+v.deptCode+'</span><span class="status"></span></span></div>';
                        }
                    });
                    if(data.length==0){
                        $('#block-right-header').hide()
                        $('#block-right-add').hide()
                        $('#block-right-all-dept').hide()
                        $('#block-right-remove').hide()
                        tr='<div style="width: 230px;height: 200px;margin: 20px auto;text-align: center">' +
                            '<img src="/img/common/sousuokong.png" style="margin-top: 20px;" alt="">\
                            <span style="width: 100%;display: inline-block;margin-top: 10px;\
                        font-size: 15px;\
                        font-weight: bold;">暂无搜索部门</span>' +
                            '</div>'
                    }


                    $('#deptBox .userItem').html(tr);
                }
            }
        });
    }
</script>
</html>
