<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>公共文件柜</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <link href="/lib/mui/mui/mui.css" rel="stylesheet" />
    <link rel="stylesheet" href="../css/file/m/detailed.css" />
    <script src="/lib/mui/mui/mui.min.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.1"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script type="text/javascript">
        mui.init();
    </script>
    <style>
        .mui-search input[type='search']{
            margin: 5px 10px 0px 6px;
            width: 97%;
            background-color: #ffffff;
        }
        .mui-search .mui-placeholder{
            line-height: 43px;
        }
        .mui-icon-search{
            position: absolute;
            left: 20px;
            top: 12px;
        }
        .mui-active::before{
            position: absolute;
            left: 20px;
            top: 26px;
        }
        .main{
            margin-top: 10px;
        }
    </style>
</head>

<body>
<%--<header class="mui-bar mui-bar-nav" id="header">--%>
<%--    <a class="mui-action-back mui-icon mui-icon-arrowleft mui-pull-left" style="color:#333;"></a>--%>
<%--    <h1 class="mui-title" id="title1">个人文件柜</h1>--%>
<%--    <a href="#picture" class="mui-icon mui-icon-plusempty mui-pull-right" style="color:#333;"></a>--%>
<%--</header>--%>
<div class="mui-input-row mui-search">
    <input id="searchLog" type="search" class="mui-input-clear" placeholder="请输入关键字智能搜索">
</div>
<div class="main">
    <div id="item1" class="mui-control-content mui-active">
        <div id="scroll">
            <div class="mui-scroll" id="show_ul">
                <ul class='mui-table-view' id='show_li'>
                </ul>
            </div>
        </div>
    </div>
</div>
<!--新建目录-->
<div id="modal1" class="mui-modal">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-close mui-pull-left" href="#modal1" style="color:#333;"></a>
        <h1 class="mui-title">新建目录</h1>
        <a class="mui-btn-link mui-pull-right" onclick="save()" style="color:#333;">保存</a>
    </header>
    <div class="mui-content" style="height: 100%;">
        <div class="mui-input-group">
            <div class="mui-input-row">
                <label>文件夹名：</label>
                <input type="text" id="file_name" placeholder="请输入文件夹名">
            </div>
            <div class="mui-input-row">
                <label>排序号：</label>
                <input type="text" id="num" class="mui-input-clear" placeholder="请输入序号">
            </div>
        </div>
    </div>
</div>

<!--新建文件-->
<div id="modal2" class="mui-modal">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-close mui-pull-left" href="#modal2"></a>
        <h1 class="mui-title">新建文件</h1>
        <a class="mui-btn mui-btn-blue mui-btn-link mui-pull-right" id="save" onclick="save_file()">保存</a>
    </header>
    <div class="mui-content" style="height: 100%;">
        <%--<form action="http://app.oaoa.pro/app/knowledge_center/a/add.php" method="post" enctype="multipart/form-data" id="form1">--%>
        <input type="hidden" name="flag" value="2"/>
        <div class="mui-input-row">
            <label>文件名：</label>
            <input name="mtitle" type="text" id="file_name2" placeholder="请输入文件名">
        </div>

        <div class="mui-input-row">
            <label>序列号：</label>
            <input name="cno" type="text" id="num2" class="mui-input-clear" placeholder="请输入序列号">
        </div>

        <div class="mui-input-row">
            <label>说明：</label>
            <input name="file_desc" type="text" id="text_file" class="mui-input-clear" placeholder="请输入说明">
        </div>

        <div class="mui-input-row">
            <label>文件内容：</label>
            <textarea name="message" id="textarea" rows="5" placeholder="文件内容"></textarea>
        </div>
        <br/>
        <div class="mui-input-row" style="position:relative">
            <label>附件：</label>
            <button type="button" id="add_button">添加附件</button>
            <form id="uploadimgform" target="uploadiframe" action="/upload?module=file_folder" enctype="multipart/form-data" method="post">
                <input type="file" name="file" id="uploadinputimg"  style="position: absolute;top:0px;opacity: 0;width: 88px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)"  class="w-icon5">
                <%--<a href="javascript:;" id="uploadimg"><img style="margin-right:5px;" src="../img/icon_uplod.png">附件上传</a>--%>
            </form>
        </div>
        <ul id="file_mess" style="padding: 5px 15px;display: inline-block;">
            <%--<p id="empty" style="font-size:12px;color:#C6C6C6;">无上传文件</p>--%>
        </ul>
        <%--</form>--%>
    </div>
</div>


<!--选择新建方式-->
<div id="picture" class="mui-popover mui-popover-action mui-popover-bottom">
    <ul class="mui-table-view">
        <li class="mui-table-view-cell">
            <a href="#modal1">新建目录</a>
        </li>
        <li class="mui-table-view-cell">
            <a href="#modal2">新建文件</a>
        </li>
    </ul>
    <ul class="mui-table-view">
        <li class="mui-table-view-cell">
            <a href="#picture"><b>取消</b></a>
        </li>
    </ul>
</div>
<script>
    var sortId = GetRequest()['sortId'] == undefined ? "" : GetRequest()['sortId'];
    if (sortId == ""){
        sortId = 0;
    }
    mui.ajax('/newFilePub/getAndoridAllPrivateFile', {
        data:{
            sortId:sortId,
            useFlag:true,
            page:1
        },
        dataType: 'json', //服务器返回json格式数据
        type: 'post', //HTTP请求类型
        success: function(data) {
            if (data.object.folder != null && data.object.folder.length > 0){
                successData(data.object.folder);
                var f_str =  str2;
                mui('#show_li')[0].insertAdjacentHTML('beforeend', f_str);
            } else {
                var arr=data.object.folder.concat(data.object.file)
                successData(arr);
                var f_str = str2;
                mui('#show_li')[0].insertAdjacentHTML('beforeend', f_str);
            }
        },
        error: function(xhr, type, errorThrown) {
            //异常处理；
            console.log(type);
        }
    });
    mui('#picture').on('tap','a',function(){
        mui('#picture').popover('hide');
    });
    function successData(data){
        var str = "";
        if(data.length == 0){
            str='<div style="font-size: .4rem;text-align: center;height: .7rem;line-height: .7rem;margin-top: .1rem;">暂无数据！</div>'
        }
        for(var i = 0; i < data.length; i++) {
           /* var img_url="";
            if(data[i].fileType == "folder") {
                var name = data[i].sortName;
                var id = data[i].sortId;
                var onclick = "get(this)";
                img_url = '/img/file/m/personal.png';
                var dataType = 1
            } else if(data[i].fileType == "file") {
                var name = data[i].subject;
                img_url = '/img/file/m/file.png';
                var id = data[i].contentId;
                var onclick = "file_content(this)";
                var dataType = 2
            };*/
            var name = data[i].sortName;
            var id = data[i].sortId;
            var onclick = "get(this)";
            var img_url = '/img/file/m/personal.png';
            var dataType = 1
            if(data[i].fileType == "file") {
                var name = data[i].subject;
                img_url = '/img/file/m/file.png';
                var id = data[i].contentId;
                var onclick = "file_content(this)";
                var dataType = 2
            }
            str += "<li id='" + id + "'   class='mui-table-view-cell catalog' onclick='" + onclick + "'><div class='mui-slider-right mui-disabled' onclick='del(this,event)' data-did='"+id+"'  data-type='"+dataType+"'><span class='mui-btn mui-btn-red'>删除</span></div><div class='mui-slider-handle'><img src='" + img_url + "' class='mui-pull-left' style='width: 45px'/><span class='mui-navigate-right' style='margin-left: 40px'>" + name + "</span></div></li>";
        }
        return str2=str;

    };
    //获取点击目录的参数，进行查询，清空页面，从新写入数据
    function get(self){
        var nid = self.getAttribute("id");
        window.location.href = '/newFileContent/getFileContent?sortId=' + nid;
        // jQuery('#show_li').html("");
        // mui.ajax('/newFilePub/getAndoridAllPrivateFile',{
        //     data:{
        //         sortId:nid,
        //         useFlag:true,
        //         page:1
        //     },
        //     dataType:'json',//服务器返回json格式数据
        //     type:'get',//HTTP请求类型
        //     success:function(data){
        //         var arr=data.object.folder.concat(data.object.file)
        //         successData(arr);
        //         var f_str = str2;
        //         mui('#show_li')[0].insertAdjacentHTML('beforeend', f_str);
        //     },
        //     error:function(xhr,type,errorThrown){
        //         //异常处理；
        //         console.log(type);
        //     }
        // });
    }


    //删除操作 e参数为禁止冒泡时间
    function del(file_move,e){
        if(e!=undefined){
            e.stopPropagation();
        }
        var btnArray = ['确认','取消'];
        var elem = file_move;
        var li = elem.parentNode;
        mui.confirm('确认要删除吗？','提示',btnArray,function(f){
            if(f.index == 0){
                var id= elem.getAttribute('data-did');
                var type= elem.getAttribute('data-type');
                if(type == 1){
                    var url = '/newFilePri/delPriSort'
                    var send_data = {
                        sortId:id
                    }
                }else if(type == 2){
                    var url = '/newFileContent/batchDeleteConId'
                    var fileId=[id]
                    var send_data = {
                        fileId:fileId
                    }
                }
                // console.log(send_data)
                mui.ajax(url,{
                    data:send_data,
                    dataType:'json',//服务器返回json格式数据
                    type:'post',//HTTP请求类型
                    success:function(data){
                        if(data.flag){
                            mui.toast("删除成功");
                            li.parentNode.removeChild(li);
                        }else {
                            mui.toast("删除失败");
                        }
                    },
                    error:function(xhr,type,errorThrown){
                        //异常处理；
                        console.log(type);
                    }
                });
            }else{}
        });
    }

    //点击文件跳转，展示文件详细内容
    function file_content(self){
        var cid = self.getAttribute("id");
        mui.openWindow({
            url:'/newFileContent/getFileDetail?id='+cid+'&dataType='+$.GetRequest().dataType,
            id:'/newFileContent/getFileDetail',
        });
    }

    //新建目录
    function save(){
        var sortParent = sortId;
        var file_name = document.getElementById('file_name').value;
        var num = document.getElementById('num').value;
        var send_data = {
            sortType:4,
            sortName:file_name,
            sortNo:num,
            sortParent:sortParent
        }
        mui.ajax('/file/add',{
            data:send_data,
            dataType:'json',//服务器返回json格式数据
            type:'get',//HTTP请求类型
            timeout:10000,//超时时间设置为10秒；
            success:function(data){
//					if(data.state == "ok"){
                mui.toast("新增目录成功");
                history.go(-1);
                location.reload();
//					}else{
//						mui.toast("新增目录失败");
//					}
            },
            error:function(xhr,type,errorThrown){
                //异常处理；
                console.log(type);
            }
        });
    }
    //点击保存 提交数据
    function save_file(){
        var sortId = sortId;
        var send_pid = sortId;
        var title = document.getElementById('file_name2').value;
        var num2 = document.getElementById('num2').value;
        var text_file = document.getElementById('text_file').value;
        var textarea = document.getElementById('textarea').value;


        var aId='';
        var uId='';
        for(var i=0;i<$('.inHidden').length;i++){
            aId += $('.dech .inHidden').eq(i).val();
        }
        for(var i=0;i<$('.dech  .inHidden').length;i++){
            uId += $('.dech').eq(i).find('a').attr('NAME');
        }
        mui.ajax('/file/saveContent',{
            data:{
                sortId:sortId,   //目录id
                subject:title,
                content:textarea,
                attachmentId:aId, //附件id串
                attachmentName:uId,//附件名称串
                contentNo:num2
            },
            dataType:'json',//服务器返回json格式数据
            type:'post',//HTTP请求类型
            beforeSend: function() {
                mui('#save').button('loading');
            },
            complete: function() {
                mui('#save').button('reset');
            },
            success:function(data){
                if(data.flag){
                    var btnArray = ['确认'];
                    mui.confirm('保存成功', ' ', btnArray, function(e) {
                        location.reload()
                    })
                }
                // mui.toast("正在上传文件请稍等");
//					var qid = data.cid;
//                 createUpload(qid);
            },
            error:function(e){
                mui.alert(JSON.stringify(e));
            }
        });
    }


    //添加附件
    $('#add_button').on('click', function(){
        // document.addEventListener('plusready', appendByGallery);
    })
    fileuploadFn('#uploadinputimg',$('#file_mess'));
    //附件删除
    $('#file_mess').on('click','.deImgs',function(e){
        e.stopPropagation();
        var data=$(this).parents('.dech').attr('deUrl');
        var dome=$(this).parents('.dech');
        deleteChatment(data,dome);
    })
    function deleteChatment(data,element){
        var btnArray = ['确认'];
        mui.confirm('确认要删除吗?', ' ', btnArray, function(e) {
            $.ajax({
                type:'get',
                url:'../delete',
                dataType:'json',
                data:data,
                success:function(res){

                    if(res.flag == true){

//                                     var file = $('[name="file"]')
//                                     file.after(file.clone().val(""));
//                                     file.remove();
                        element.remove();
                    }else{

                    }
                }
            });
        })


    }


    var files = [];

    function appendByGallery(){

        var task = plus.uploader.createUpload( "/newFileContent/fileBoxUpload",
            { method:"POST",blocksize:204800,priority:100 },
            function ( t, status ) {
                // 上传完成
                console.log(t);
                if ( status == 200 ) {
                    alert( "Upload success: " + t.url );
                } else {
                    alert( "Upload failed: " + status );
                }
            }
        );
        task.addFile('images/touxiang2x.png', {key:"file"} );
        task.start();
        // plus.gallery.pick(function(p){
        //     // 添加文件
        //     var index=1;
        //     var p=p;
        //     var fe=document.getElementById("file_mess");
        //     var li=document.createElement("li");
        //     var n=p.substr(p.lastIndexOf('/')+1);
        //     li.innerText=n;
        //     fe.appendChild(li);
        //     files.push({name:"uploadkey"+index,path:p});
        //     index++;
        //     empty.style.display="none";
        // });
    }



    function createUpload(mid) {
        var server='http://app.oaoa.pro/app/knowledge_center/a/add.php?cid='+mid+'&flag=2';
        //var wt=plus.nativeUI.showWaiting();
        var task=plus.uploader.createUpload(server,
            {method:"POST"},
            function(t,status){ //上传完成
                if(status==200){
                    mui.toast("新增成功");

                    //location.reload();
                }else{
                    mui.toast("新增失败");
                    location.reload();
                }
            }
        );
        for(var i=0;i<files.length;i++){
            var f=files[i];
            task.addFile(f.path,{key:f.name});
            task.start();
        }

    }

    //用于监听input的值变化（input的值产生变化才会触发事件）
    (function ($) {
        $.fn.watch = function (callback) {
            return this.each(function () {
                //缓存以前的值
                $.data(this, 'originVal', $(this).val());

                //event
                $(this).on('keyup paste', function () {
                    var originVal = $.data(this, 'originVal');
                    var currentVal = $(this).val();

                    if (originVal !== currentVal) {
                        $.data(this, 'originVal', $(this).val());
                        callback(currentVal);
                    }
                });
            });
        }
    })(jQuery);
    //监听搜索
    $('#searchLog').watch(function(value) {
        jQuery('#show_li').html("");
        mui.ajax('/newFileContent/Ph/serachAll',{
            data:{
                serachType:2,
                subject:value,
            },
            dataType:'json',//服务器返回json格式数据
            type:'get',//HTTP请求类型
            success:function(data){
                successData(data);
                var f_str = str2;
                mui('#show_li')[0].insertAdjacentHTML('beforeend', f_str);
            },
            error:function(xhr,type,errorThrown){
                //异常处理；
                console.log(type);
            }
        });
    });

    function GetRequest() {
        var url = location.search; //获取url中"?"符后的字串
        var theRequest = new Object();
        if (url.indexOf("?") != -1) {
            var str = url.substr(1);
            strs = str.split("&");
            for(var i = 0; i < strs.length; i ++) {
                theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]);
            }
        }
        return theRequest;
    }

    jQuery(document).ready(function () {
        if (sortId == 0){
            if (window.history && window.history.pushState) {
                $(window).on('popstate', function () {
                    /// 当点击浏览器的 后退和前进按钮 时才会被触发，
                    window.history.pushState('forward', null, '');
                    window.history.forward(1);
                });
            }
            //IE
            window.history.pushState('forward', null, '');  //在IE中必须得有这两行
            window.history.forward(1);
        }
    });

</script>
</body>
</html>