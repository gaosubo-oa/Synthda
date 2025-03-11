<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>资源管理-用户权限-角色权限-设置管理员</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <script src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <style>
        #trans{
            text-align: center;
            margin: 15px 0;
        }
    </style>
</head>
<body>

<div class="demo-transfer layui-form" style="display: none;">
    <div class="layui-form-item" style="margin-top: 20px;">
        <label class="layui-form-label">搜索框：</label>
        <div class="layui-input-inline">
            <select name="city" lay-verify="required"  lay-filter="cityfilter">
                <option value=""></option>
                <option value="DEPT_ID">按部门选择人员</option>
                <option value="USER_PRIV">按角色选择人员</option>
            </select>
        </div>
        <div class="layui-input-inline" name="unamesearch" style="display: none">
            <input type="text" name="uname" required lay-verify="required" placeholder="请输入名称" autocomplete="off" class="layui-input" >
        </div>
        <button type="button" name="searchsubmit" class="layui-btn layui-btn-sm" style="margin-top: 5px;" lay-demotransferactive="reload">搜索</button>
    </div>
</div>
<%--穿梭框--%>
<div id="trans" class="demo-transfer"></div>
<div class="layui-btn-container">
    <button type="button" style="display: none;" id="btn1" class="layui-btn" lay-demotransferactive="getData">获取右侧数据</button>
</div>

</body>
<script>
    // 获取地址栏参数值
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }
    var type = getQueryString("type");
    var id = getQueryString("id");
    var LeftData=[]; //左侧数据
    var data;
    var $,transfer,util,form;
    var url,table1,table2;

    //通用接口ajax,同步ajax
    function baseAjax(url,data) {
        var rews;
        $.ajax({
            url:url,
            type:'post',
            data:data,
            dataType: 'json',
            async:false,
            success:function (res) {
                rews=res
            }
        })
        return rews;
    }

    //指定某个元素数组删除
    function deleteItem (item, list) {
        // 先遍历list里面的每一个元素，对比item与每个元素的id是否相等，再利用splice的方法删除
        for (var key in list) {
            if (list[key].value === item) {
                list.splice(key, 1)
            }
        }
    }

    // 父调用子页面的方法
    function getStr(){
        $("#btn1").click();
    }

    function reloaddata(){
        var select=$('select[name="city"]').val();
        var input=$('input[name="uname"]').val();
        var param=param={
            sourceid:id,
            type:type
        };

        if (select!=undefined && select!=''){
            if (input!=undefined && input!=''){
                if (select==='username'){
                    param={
                        sourceid:id,
                        type:type,
                        username:input
                    }
                }
            }else if (select==='DEPT_ID'){
                param={
                    sourceid:id,
                    type:type,
                    deptid:'deptid'
                }
            }else if (select==='USER_PRIV'){
                param={
                    sourceid:id,
                    type:type,
                    userPriv:'userPriv'
                }
            }
        }
        var res=baseAjax('/source/findCandidate',param);
        if (res.length>0){
            data=res;
            var arr = [];
            for(var i=0;i<data.length;i++){
                if(data[i].state===0){ //右侧
                    arr.push(data[i].id);
                }else if(data[i].state===1){ //左侧
                    var obj= new Object();
                    obj['value']=data[i].id;
                    obj['title']=data[i].name;
                    LeftData.push(obj);
                }
            }

            //实例重载
            transfer.reload('getdata', {
                title: [table1,table2]
                ,data:data
                ,value: arr
                ,showSearch: false
                ,parseData: function(res){
                    return {
                        "value": res.id //数据值
                        ,"title": res.name //数据标题
                        ,"disabled": res.disabled  //是否禁用
                        ,"checked": res.checked //是否选中
                    }
                }
            })
        }

    }


    layui.config({
        base: '/lib/layui/layui/lay/modules/'
    }).use(['transfer','util','form'], function(){
         $ = layui.$
            ,transfer = layui.transfer
            ,util = layui.util
            ,form = layui.form


        if (type==='1' || type==='3'){
            //备选人员
            url='/source/findCandidate';
            table1='已选人员';
            table2='备选人员';
            $('.layui-form').attr("style","display: block");
            if (type==='1'){
                var stropen='<option value="username">按搜索人名选择人员</option>';
                $('select[name="city"]').append(stropen);
            }else {
                $('option[value="username"]').remove();
            }
            form.render('select'); //刷新select选择框渲染
        }else if (type==='2'){
            //备选角色
            url='/source/findAlternative';
            table1='已选角色';
            table2='备选角色';
        }

        //走端口拿到需要的数据 传递给下面render的穿梭框
        $.ajax({
            type: "get",
            url: url,
            data:{sourceid:id,type:type},
            dataType: "json",
            success: function (res) {
                 data = res;
                // 已经选中的每一项的id 放到数组中 ；区分左表还是右表
                var arr = [];
                for(var i=0;i<data.length;i++){
                    if(data[i].state===0){ //右侧
                        arr.push(data[i].id);
                    }else if(data[i].state===1){ //左侧
                        var obj= new Object();
                        obj['value']=data[i].id;
                        obj['title']=data[i].name;
                        LeftData.push(obj);
                    }
                }
                //渲染
                transfer.render({
                    elem: '#trans'
                    ,data:data //穿梭框需要的数据
                    ,title: [table1, table2] //穿梭框的标题
                    ,showSearch: false  //是否显示搜索框
                    ,width:300
                    ,height:380
                    ,value:arr  //已经选中，放在穿梭框的右边
                    ,id:'getdata'
                    ,parseData: function(res){
                        return {
                            "value": res.id //数据值
                            ,"title": res.name //数据标题
                            ,"disabled": res.disabled  //是否禁用
                            ,"checked": res.checked //是否选中
                        }
                    }
                    ,onchange: function(obj, index){
                        /* var arr = ['左边', '右边'];

                         layer.alert('来自 <strong>'+ arr[index] + '</strong> 的数据：'+ JSON.stringify(obj)); //获得被穿梭时的数据*/
                        for (var i=0; i<obj.length;i++){
                            if (index===0){
                                deleteItem(obj[i].value,LeftData); //移除
                            }else if(index===1){
                                LeftData.push(obj[i]); //添加数组
                            }
                        }
                    }
                });
            }
        });

        // 点击获取数据事件
        util.event('lay-demoTransferActive', {
            getData: function (othis) {
                //获取右侧数据
                var getData = transfer.getData('getdata');
                //LeftData左侧数据
                parent.getChildData(LeftData,type,id);
            }
            ,reload: function () {
                //重载穿梭；点击搜索按钮
                reloaddata();
            }
        })

        //监听搜索框事件
        form.on('select(cityfilter)', function(data){
           /* console.log(data.elem); //得到select原始DOM对象
            console.log(data.value); //得到被选中的值
            console.log(data.othis); //得到美化后的DOM对象*/
           if(data.value==='username'){
                $('div[name="unamesearch"]').attr("style","display: block");
                $('input[name="uname"]').val("");
           }else {
               $('div[name="unamesearch"]').attr("style","display: none");
           }
        });
    });

</script>
</body>


</html>
