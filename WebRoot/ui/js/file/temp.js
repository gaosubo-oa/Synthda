$(function () {
    //获取地址栏参数
    var sortId=$.getQueryString('sortId');
    var used=[];
	var data={};
    var userId={
          user:"",
          dept:"",
          role:"",
          data:{
            userStr:"",
            deptStr:"",
            roleStr:"",
          }
    };
    var newUser={
        user:"",
        dept:"",
        role:"",
        data:{
            userStr:"",
            deptStr:"",
            roleStr:"",
        }
    };
    var manageUser={
        user:"",
        dept:"",
        role:"",
        data:{
            userStr:"",
            deptStr:"",
            roleStr:"",
        }
    };
    var delUser={
        user:"",
        dept:"",
        role:"",
        data:{
            userStr:"",
            deptStr:"",
            roleStr:"",
        }
    };
    var downUser={user:"",
        dept:"",
        role:"",
        data:{
            userStr:"",
            deptStr:"",
            roleStr:"",
        }};
    var shareUser={
        user:"",
        dept:"",
        role:"",
        data:{
            userStr:"",
            deptStr:"",
            roleStr:"",
        }
    };
    var owner={
        user:"",
        dept:"",
        role:"",
        data:{
            userStr:"",
            deptStr:"",
            roleStr:"",
        }
    };
    var signUser={
        user:"",
        dept:"",
        role:"",
        data:{
            userStr:"",
            deptStr:"",
            roleStr:"",
        }
    };
    var review={
        user:"",
        dept:"",
        role:"",
        data:{
            userStr:"",
            deptStr:"",
            roleStr:"",
        }
    };
    var description={};
   //渲染树
    //获取左侧分类
    $('#li_parent').tree({
        url: '../file/getAuthBySortId?sortId='+sortId,
        animate:true,
        lines:false,
        loadFilter: function(rows){
            userId=rows.data.userId;
            newUser=rows.data.newUser;
            manageUser=rows.data.manageUser;
            delUser=rows.data.delUser;
            downUser=rows.data.downUser;
            shareUser=rows.data.shareUser;
            owner=rows.data.owner;
            signUser=rows.data.signUser;
            review=rows.data.review;
            used=rows.used;
            //处理名字
            rows.nowFileSortName;
            $('.divTitle').text(rows.nowFileSortName);
            var span = $('.nav ul li span');
            for(var i=0;i<span.length;i++){
                if($(span[i]).attr('class')=='headli one'){
                    renderShow($('.one').attr("id"));
                };
            }
            return convert(rows.fileSorts);
        },
        onClick:function(node){
            //这里处理点击事件  获取id 重新加载页面即可
            freshData(node.id);

            // getFlowList(node.id);
        },
        onLoadSuccess:function(node,data) {
            $("#li_parent li").find("div[node-id='-1']").addClass("tree-node-selected");   //设置第一个节点高亮
            var n = $("#li_parent").tree("getSelected");
            if(n!=null){
                $("#li_parent").tree("select",n.target);    //相当于默认点击了一下第一个节点，执行onSelect方法
            }
        },
    });
    //处理树结构
    function convert(rows){
        function exists(rows, parentId){
            for(var i=0; i<rows.length; i++){
                if (rows[i].sortId == parentId) return true;
            }
            return false;
        }
        var nodes = [];
        // get the top level nodes
        for(var i=0; i<rows.length; i++){
            var row = rows[i];

            if (!exists(rows, row.sortParent)){
                nodes.push({
                    id:row.sortId,
                    text:row.sortName,
                });
            }
        }
        var toDo = [];
        for(var i=0; i<nodes.length; i++){
            toDo.push(nodes[i]);
        }
        while(toDo.length){
            var node = toDo.shift();	// the parent node
            // get the children nodes
            for(var i=0; i<rows.length; i++){
                var row = rows[i];
                if (row.sortParent == node.id){
                    var child = {id:row.sortId,text:row.sortName};
                    if (node.children){
                        if(node.id!=0){
                            node.state="closed"
                        }
                        node.children.push(child);
                    } else {

                        node.children = [child];
                    }
                    toDo.push(child);
                }
            }
        }
        return nodes;
    }
   //刷新数据
    function freshData(nodeId) {
        sortId=nodeId;
        $.ajax({
            type:'post',
            url:'../file/getAuthBySortId',
            dataType:'json',
            data:{sortId:nodeId},
            success:function(res){
                //重新赋值
                if(res.flag==true){
                    userId=res.data.userId;
                    newUser=res.data.newUser;
                    manageUser=res.data.manageUser;
                    delUser=res.data.delUser;
                    downUser=res.data.downUser;
                    shareUser=res.data.shareUser;
                    owner=res.data.owner;
                    signUser=res.data.signUser;
                    review=res.data.review;
                    used=res.used;
                    //处理名字
                    res.nowFileSortName;
                    $('.divTitle').text(res.nowFileSortName);
                    var span = $('.nav ul li span');
                    for(var i=0;i<span.length;i++){
                        if($(span[i]).attr('class')=='headli one'){
                            renderShow($('.one').attr("id"));
                        };
                    }
                    cleanDate($(".one").attr("id"));
                }else{

                }

            }
        })
    }

	$('.nav ul li').click(function () {
        var numsw=$(this).attr('data-num')
	    if(numsw==0){
            $('.specPermiss').find('img').prop('src','/img/fangwenxian.png')
        }else if(numsw==1){
            $('.specPermiss').find('img').prop('src','/img/xinjianxian.png')
        }else if(numsw==2){
            $('.specPermiss').find('img').prop('src','/img/bianjixian.png')
        }else if(numsw==3){
            $('.specPermiss').find('img').prop('src','/img/shanchuxian.png')
        }else if(numsw==4){
            $('.specPermiss').find('img').prop('src','/img/pinglunxian.png')
        }else if(numsw==5){
            $('.specPermiss').find('img').prop('src','/img/xiazaixian.png')
        }else if(numsw==6){
            $('.specPermiss').find('img').prop('src','/img/qianyuexian.png')
        }else if(numsw==7){
            $('.specPermiss').find('img').prop('src','/img/suoyouzhex.png')
        }else if(numsw==8){
            $('.tabTypeTwo .specPermiss').find('img').prop('src','/img/piliangshes.png')
        }
       var span = $('.nav ul li span');
       for(var i=0;i<span.length;i++){
         	if($(span[i]).attr('class')=='headli one'){
                renderDate($(span[i]).attr("id"));
                renderShow($(this).find('span').attr("id"));
			};
	   }
        $(this).find('.headli').addClass('one').end().siblings().find('.headli').removeClass('one');
		cleanDate($(this).find('span').attr("id"));

	})
    function setData(obj) {
        if(obj.data){
            $('#Senduser').val(obj['data'].userStr);
            $('#SendCompany').val(obj['data'].deptStr);
            $('#SendPriv').val(obj['data'].roleStr);
            $('#Senduser').attr('user_id',obj["user"]);
            $('#SendCompany').attr('deptid',obj["dept"]);
            $('#SendPriv').attr('userpriv',obj["role"]);
        }else{
            $('#Senduser').val("");
            $('#SendCompany').val("");
            $('#SendPriv').val("");
        }
    }
function renderShow(id) {

    if(id=='visit'){
        setData(userId)
    };
    if(id=='add'){
        setData(newUser);

    };
    if(id=='edit'){
        setData(manageUser);

    };
    if(id=='comment'){
        setData(review);

    };
    if(id=='download'){
        setData(downUser);

    };
    if(id=='sign'){
        setData(signUser);

    };
    if(id=='all'){
        setData(owner);

    };
    if(id=='delete'){
        setData(delUser);

    };

}
function cleanDate(id) {
    for(var i=0;i<used.length;i++){
    	if(used[i]==id){
    		return;
		}
	}
    $('#Senduser').val("");
    $('#SendCompany').val("");
    $('#SendPriv').val("");
}
function renderDate(id) {
    if(id=='visit'){
        userId["user"]=$('#Senduser').attr('user_id');
        userId["dept"]=$('#SendCompany').attr('deptid');
        userId["role"]=$('#SendPriv').attr('userpriv');
      var checked=  $('#checks').prop("checked");
      if(checked){
          userId["isExtends"]="1";
      }else{
          userId["isExtends"]="0";
      }

        userId["data"]={
            userStr:$('#Senduser').val(),
            deptStr:$('#SendCompany').val(),
            roleStr:$('#SendPriv').val(),
		}
        data["userId"]=userId;
        used.push('visit');
    };
    if(id=='add'){
        newUser["user"]=$('#Senduser').attr('user_id');
        newUser["dept"]=$('#SendCompany').attr('deptid');
        newUser["role"]=$('#SendPriv').attr('userpriv');
        var checked=  $('#checks').prop("checked");
        if(checked){
            newUser["isExtends"]="1";
        }else{
            newUser["isExtends"]="0";
        }
        newUser["data"]={
            userStr:$('#Senduser').val(),
            deptStr:$('#SendCompany').val(),
            roleStr:$('#SendPriv').val(),
        }
        data["newUser"]=newUser;
        used.push('add');
    };
    if(id=='edit'){
        manageUser["user"]=$('#Senduser').attr('user_id');
        manageUser["dept"]=$('#SendCompany').attr('deptid');
        manageUser["role"]=$('#SendPriv').attr('userpriv');
        var checked=  $('#checks').prop("checked");
        if(checked){
            manageUser["isExtends"]="1";
        }else{
            manageUser["isExtends"]="0";
        }
        manageUser["data"]={
            userStr:$('#Senduser').val(),
            deptStr:$('#SendCompany').val(),
            roleStr:$('#SendPriv').val(),
        }
        data["manageUser"]=manageUser;
        used.push('edit');
    };
    if(id=='delete'){
        delUser["user"]=$('#Senduser').attr('user_id');
        delUser["dept"]=$('#SendCompany').attr('deptid');
        delUser["role"]=$('#SendPriv').attr('userpriv');
        var checked=  $('#checks').prop("checked");
        if(checked){
            delUser["isExtends"]="1";
        }else{
            delUser["isExtends"]="0";
        }
        delUser["data"]={
            userStr:$('#Senduser').val(),
            deptStr:$('#SendCompany').val(),
            roleStr:$('#SendPriv').val(),
        }
        data["delUser"]=delUser;
        used.push('delete');
    };
    if(id=='comment'){
        review["user"]=$('#Senduser').attr('user_id');
        review["dept"]=$('#SendCompany').attr('deptid');
        review["role"]=$('#SendPriv').attr('userpriv');
        var checked=  $('#checks').prop("checked");
        if(checked){
            review["isExtends"]="1";
        }else{
            review["isExtends"]="0";
        }
        review["data"]={
            userStr:$('#Senduser').val(),
            deptStr:$('#SendCompany').val(),
            roleStr:$('#SendPriv').val(),
        }
        data["review"]=review;
        used.push('comment');
    };
    if(id=='download'){
        downUser["user"]=$('#Senduser').attr('user_id');
        downUser["dept"]=$('#SendCompany').attr('deptid');
        downUser["role"]=$('#SendPriv').attr('userpriv');
        var checked=  $('#checks').prop("checked");
        if(checked){
            downUser["isExtends"]="1";
        }else{
            downUser["isExtends"]="0";
        }
        downUser["data"]={
            userStr:$('#Senduser').val(),
            deptStr:$('#SendCompany').val(),
            roleStr:$('#SendPriv').val(),
        }
        data["downUser"]=downUser;
        used.push('download');
    };
    if(id=='sign'){
        signUser["user"]=$('#Senduser').attr('user_id');
        signUser["dept"]=$('#SendCompany').attr('deptid');
        signUser["role"]=$('#SendPriv').attr('userpriv');
        var checked=  $('#checks').prop("checked");
        if(checked){
            signUser["isExtends"]="1";
        }else{
            signUser["isExtends"]="0";
        }
        signUser["data"]={
            userStr:$('#Senduser').val(),
            deptStr:$('#SendCompany').val(),
            roleStr:$('#SendPriv').val(),
        }
        data["signUser"]=signUser;
        used.push('sign');
    };
    if(id=='all'){
        owner["user"]=$('#Senduser').attr('user_id');
        owner["dept"]=$('#SendCompany').attr('deptid');
        owner["role"]=$('#SendPriv').attr('userpriv');
        var checked=  $('#checks').prop("checked");
        if(checked){
            owner["isExtends"]="1";
        }else{
            owner["isExtends"]="0";
        }
        owner["data"]={
            userStr:$('#Senduser').val(),
            deptStr:$('#SendCompany').val(),
            roleStr:$('#SendPriv').val(),
        }
        data["owner"]=owner;
        used.push('all');
    };
}

function batchSettingData(){
    var comdata={
        user:$('#batchSenduser').attr('user_id'),
        dept:$('#batchSendCompany').attr('deptid'),
        role:$('#batchSendPriv').attr('userpriv'),
        data:{
            userStr:$('#batchSenduser').val(),
            deptStr:$('#batchSendCompany').val(),
            roleStr:$('#batchSendPriv').val(),
        }
    }
    if($('input[name="userId"]').prop('checked')){
        data["userId"]=comdata;
    }
    if($('input[name="newUser"]').prop('checked')){
        data["newUser"]=comdata;
    }
    if($('input[name="manageUser"]').prop('checked')){
        data["manageUser"]=comdata;
    }
    if($('input[name="delUser"]').prop('checked')){
        data["delUser"]=comdata;
    }
    if($('input[name="review"]').prop('checked')){
        data["review"]=comdata;
    }
    if($('input[name="downUser"]').prop('checked')){
        data["downUser"]=comdata;
    }
    if($('input[name="signUser"]').prop('checked')){
        data["signUser"]=comdata;
    }
    if($('input[name="owner"]').prop('checked')){
        data["owner"]=comdata;
    }
}

    //批量设置点击事件
	$('#batchSettings').click(function () {
		$('.tabTypeTwo').show();
		$('.tabTypeOne').hide();
	})
	//访问权限点击事件
	$('#visitJurisd').click(function () {
		$('.tabTypeOne').show();
		$('.tabTypeTwo').hide();
		$('.explain').text('');
        $('.explain').text(fangwen);
	})
    $('#addJurisd').click(function () {
        $('.tabTypeOne').show();
        $('.tabTypeTwo').hide();
        $('.explain').text('');
        $('.explain').text(newAdd);
    })
    $('#editJurisd').click(function () {
        $('.tabTypeOne').show();
        $('.tabTypeTwo').hide();
        $('.explain').text('');
        $('.explain').text(editquan);
    })
    $('#deleteJurisd').click(function () {
        $('.tabTypeOne').show();
        $('.tabTypeTwo').hide();
        $('.explain').text('');
        $('.explain').text(delQuan);
    })
    $('#commentJurisd').click(function () {
        $('.tabTypeOne').show();
        $('.tabTypeTwo').hide();
        $('.explain').text('');
        $('.explain').text(ping);
    })
    $('#downloadJurisd').click(function () {
        $('.tabTypeOne').show();
        $('.tabTypeTwo').hide();
        $('.explain').text('');
        $('.explain').text(office);
    })
    $('#signJurisd').click(function () {
        $('.tabTypeOne').show();
        $('.tabTypeTwo').hide();
        $('.explain').text('');
        $('.explain').text(qianYue);
    })
    $('#owner').click(function () {
        $('.tabTypeOne').show();
        $('.tabTypeTwo').hide();
        $('.explain').text('');
        $('.explain').text(dile);
    })



	$('#btnSure').click(function(){
        var span = $('.nav ul li span');
        for(var i=0;i<span.length;i++){
            if($(span[i]).attr('class')=='headli one'){
                renderDate($(span[i]).attr("id"));
            };
        }
        data['sortId']=sortId*1;
       var realData ={
           auth:JSON.stringify(data)
       }
        saveJurisd(realData);
	})
    $('#btnBack').click(function(){
        window.close();
        $('#Senduser').val('');
        $('#SendCompany').val('');
        $('#SendPriv').val('');
    })

    //批量设置确定点击事件
    $('#Btn_sure').click(function(){
        batchSettingData();
        data['sortId']=sortId*1;
        var realData ={
            auth:JSON.stringify(data)
        }
        saveJurisd(realData);
        $('#batchSenduser').val('');
        $('#batchSendCompany').val('');
        $('#batchSendPriv').val('');
        $('.settingOption td input').prop('checked',false);
    })
    //批量设置返回点击事件
    $('#Btn_back').click(function(){
        window.close();
        $('#batchSenduser').val('');
        $('#batchSendCompany').val('');
        $('#batchSendPriv').val('');
        $('.settingOption td input').prop('checked',false);
    })

    //清除部门
    $('.deClearD').click(function(){
        $('#SendCompany').attr('deptid','');
        $('#SendCompany').val('');
        $('#SendCompany').attr('deptno','');
    })
    //清除角色
    $('.deClearP').click(function(){
        $('#SendPriv').attr('userpriv','');
        $('#SendPriv').val('');
    })
    //清除人员
    $('.deClearU').click(function(){
        $('#Senduser').attr('user_id','');
        $('#Senduser').val('');
    })


})
//保存接口
function saveJurisd(data){
    $.ajax({
        type:'post',
        url:'../file/setFileSortAuth',
        dataType:'json',
        data:data,
        success:function(res){
            if(res.flag==true){
                $.layerMsg({content:'保存成功！',icon:1},function(){
                    //window.close();
                });
            }else{
                $.layerMsg({content:'保存失败！',icon:2},function(){
                });
            }

        }
    })
}

