
$(function () {
    var dataBlor=false;
    //获取地址栏参数
    var sortId=$.getQueryString('sortId');
    var datasnum = $.getQueryString('datasnum')||'';

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

    $('#isExtends').on("click",function () {
        var states=$(this).prop('checked');
        if(states == true){
            $('#isExtends').prop('checked',true);
            $('#isExtends').val('1');
        }else{
            $('#isExtends').prop('checked',false);
            $('#isExtends').val('');
        }
    })

    $('#li_parent').tree({
        url: '/newFilePub/getPrivBySortId?sortId='+sortId+'&isChild=0',
        animate:true,
        loadFilter: function(rows){
            userId=rows.object.userId;
            newUser=rows.object.newUser;
            manageUser=rows.object.manageUser;
            delUser=rows.object.delUser;
            downUser=rows.object.downUser;
            shareUser=rows.object.shareUser;
            owner=rows.object.owner;
            signUser=rows.object.signUser;
            review=rows.object.review;
            used=rows.object.useds;
            $('.divTitle').text(rows.object.sortName);
            var span = $('.nav ul li span');
            for(var i=0;i<span.length;i++){
                if($(span[i]).attr('class')=='headli one'){
                    renderShow($('.one').attr("id"));
                };
            }
            var arr = convert(rows.datas);
            return arr;
        },
        onClick:function(node){
            freshData(node.id);
            $(this).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
            node.state = node.state === 'closed' ? 'open' : 'closed';
        },
        onBeforeExpand:function(node,param){
            $('#li_parent').tree('options').url = '/newFilePub/getPrivBySortId?sortId='+node.id+'&isChild=1';// change the url
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
        data.forEach(function(v,i){
            if(v.sortName){
                var node = new TreeNode(v.sortId,v.sortName,"closed")
                arr.push(node);
            }
        });
        return arr;
    }
   //刷新数据
    function freshData(nodeId) {
        sortId=nodeId;
        $.ajax({
            type:'post',
            url:'/newFilePub/getPrivBySortId',
            dataType:'json',
            data:{
                sortId:nodeId,
                isChild:1
            },
            success:function(res){
                console.log(res,'res')
                //重新赋值
                if(res.flag==true){
                    userId=res.object.userId;
                    newUser=res.object.newUser;
                    manageUser=res.object.manageUser;
                    delUser=res.object.delUser;
                    downUser=res.object.downUser;
                    shareUser=res.object.shareUser;
                    owner=res.object.owner;
                    signUser=res.object.signUser;
                    review=res.object.review;
                    used=res.object.useds;
                    //处理名字
                    res.nowFileSortName;
                    $('.divTitle').text(res.object.sortName);
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

	$('.nav ul li').on("click",function () {
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
    if(datasnum !== ''){
        $('.index_head li').eq(datasnum).click();
    }
    function setData(obj) {
        console.log(obj)
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
        if($('#isExtends').val() == '1'){
            userId["isExtends"]="1";
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
        if($('#isExtends').val() == '1'){
            newUser["isExtends"]="1";
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
        if($('#isExtends').val() == '1'){
            manageUser["isExtends"]="1";
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
        if($('#isExtends').val() == '1'){
            delUser["isExtends"]="1";
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
        if($('#isExtends').val() == '1'){
            review["isExtends"]="1";
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
        if($('#isExtends').val() == '1'){
            downUser["isExtends"]="1";
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
        if($('#isExtends').val() == '1'){
            signUser["isExtends"]="1";
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
        if($('#isExtends').val() == '1'){
            owner["isExtends"]="1";
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
        isExtends:"1",
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
	$('#batchSettings').on("click",function () {
		$('.tabTypeTwo').show();
		$('.tabTypeOne').hide();
	})
	//访问权限点击事件
	$('#visitJurisd').on("click",function () {
		$('.tabTypeOne').show();
		$('.tabTypeTwo').hide();
		$('.explain').text('');
        $('.explain').text(fangwen);


	})
    $('#addJurisd').on("click",function () {
        $('.tabTypeOne').show();
        $('.tabTypeTwo').hide();
        $('.explain').text('');
        $('.explain').text(newAdd);


    })
    $('#editJurisd').on("click",function () {
        $('.tabTypeOne').show();
        $('.tabTypeTwo').hide();
        $('.explain').text('');
        $('.explain').text(editquan);


    })
    $('#deleteJurisd').on("click",function () {
        $('.tabTypeOne').show();
        $('.tabTypeTwo').hide();
        $('.explain').text('');
        $('.explain').text(file_th_onlyAdminCanDelete);


    })
    $('#commentJurisd').on("click",function () {
        $('.tabTypeOne').show();
        $('.tabTypeTwo').hide();
        $('.explain').text('');
        $('.explain').text(ping);


    })
    $('#downloadJurisd').on("click",function () {
        $('.tabTypeOne').show();
        $('.tabTypeTwo').hide();
        $('.explain').text('');
        $('.explain').text(office);


    })
    $('#signJurisd').on("click",function () {
        $('.tabTypeOne').show();
        $('.tabTypeTwo').hide();
        $('.explain').text('');
        $('.explain').text(qianYue);


    })
    $('#owner').on("click",function () {
        $('.tabTypeOne').show();
        $('.tabTypeTwo').hide();
        $('.explain').text('');
        $('.explain').text(dile);

        // $('#SendCompany').attr('deptid','');
        // $('#SendCompany').val('');
        // $('#SendCompany').attr('deptno','');
        // $('#SendCompany').attr('deptname','');
        //
        // $('#SendPriv').attr('userpriv','');
        // $('#SendPriv').attr('privid','');
        // $('#SendPriv').val('');
        //
        // $('#Senduser').attr('user_id','');
        // $('#Senduser').attr('username','');
        // $('#Senduser').attr('dataid','');
        // $('#Senduser').attr('userprivname','');
        // $('#Senduser').val('');

    })




	$('#btnSure').on("click",function(){

        var span = $('.nav ul li span');
        var datasnums = $('.index_head .one').parent().attr('data-num');
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
           // var url = window.location.href;
           // if(datasnums == ''){
           //     location.href=url+"&datasnum="+datasnum;
           // }else{
           //     location.href=url.split('&datasnum=')[0]+"&datasnum="+datasnums;
           // }


	})
    $('#btnBack').on("click",function(){
        window.close();
        $('#Senduser').val('');
        $('#SendCompany').val('');
        $('#SendPriv').val('');
    })

    //批量设置确定点击事件
    $('#Btn_sure').on("click",function(){
        batchSettingData();
        data['sortId']=sortId*1;
        var realData ={
            auth:JSON.stringify(data)
        }
        saveBath(realData);
        $('#batchSenduser').val('');
        $('#batchSendCompany').val('');
        $('#batchSendPriv').val('');
        $('.settingOption td input').prop('checked',false);
        if(datasnum == ''){
            location.reload();
        }else{
            var url = window.location.href;
            location.href = url.split('&datasnum=')[0];
        }
    })
    //批量设置返回点击事件
    $('#Btn_back').on("click",function(){
        window.close();
        $('#batchSenduser').val('');
        $('#batchSendCompany').val('');
        $('#batchSendPriv').val('');
        $('.settingOption td input').prop('checked',false);
    })

    //清除部门
    $('.deClearD').on("click",function(){
        $('#SendCompany').attr('deptid','');
        $('#SendCompany').val('');
        $('#SendCompany').attr('deptno','');
        $('#SendCompany').attr('deptname','');
    })
    //清除角色
    $('.deClearP').on("click",function(){
        $('#SendPriv').attr('userpriv','');
        $('#SendPriv').attr('privid','');
        $('#SendPriv').val('');
    })
    //清除人员
    $('.deClearU').on("click",function(){
        $('#Senduser').attr('user_id','');
        $('#Senduser').attr('username','');
        $('#Senduser').attr('dataid','');
        $('#Senduser').attr('userprivname','');
        $('#Senduser').val('');
    })

    $('.deClearDept').on("click",function () {
        $('#batchSendCompany').attr('deptname','');
        $('#batchSendCompany').attr('deptid','');
        $('#batchSendCompany').val('');
    })
    $('.deClearPriv').on("click",function () {
        $('#batchSendPriv').attr('userpriv','');
        $('#batchSendPriv').attr('privid','');
        $('#batchSendPriv').val('');
    })
    $('.deClearUser').on("click",function () {
        $('#batchSenduser').attr('user_id','');
        $('#batchSenduser').attr('username','');
        $('#batchSenduser').attr('dataid','');
        $('#batchSenduser').attr('userprivname','');
        $('#batchSenduser').val('');
    })


})
//保存接口
function saveJurisd(data){
    $.ajax({
        type:'post',
        url:'/newFilePub/setFileSortAuth',
        dataType:'json',
        async:true,
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
//批量设置保存接口
function saveBath(data){
    $.ajax({
        type:'post',
        url:'/newFilePub/setAllFileSortAuth',
        dataType:'json',
        async:false,
        data:data,
        success:function(res){
            console.log(res)
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
