<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2020/7/3
  Time: 20:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String corpId = (String)request.getAttribute("corpId");
    String corpSecret = (String)request.getAttribute("corpSecret");
%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>公共文件柜</title>
    <link rel="stylesheet" href="../../css/email/m/jquery.mobile.css" />
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>

    <link rel="stylesheet" href="../../css/email/m/styles.css" />
    <link rel="stylesheet" href="../../css/email/m/mail.css">
    <script type="text/javascript" src="../../js/notes/jquery-2.1.2.min.js" ></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <script type="text/javascript" src="../../js/diary/m/simbaJs.js" ></script>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" href="../../lib/mui/mui/mui.picker.min.css" />
    <script type="text/javascript" src="../../lib/mui/mui/mui.picker.min.js"></script>
    <style>
        *{
            margin: 0;
            padding: 0;
        }
        body{
            height: 100%;
            overflow-y: auto;
        }
        .content{
            height: 60px;
            /*background-color: #6ba1df;*/
            margin-bottom: 10px;
        }
        .cabinets div{
            height: 40px;
        }
        .cabinets p{
            line-height: 50px;
            color:#333
            /*box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);*/
            /*border-radius: .1rem;*/
            /*margin-bottom: 10px;*/
            /*margin-left: 10px;*/
            /*margin-right: 10px;*/
            /*border-radius: 5px;*/
        }
        .cabinets p img{
            margin-left: 5px;
            width: 30px;
            vertical-align: middle;
        }
        .cabinets ul{
            box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);
            border-radius: .1rem;
            margin-bottom: 10px;
            margin-left: 10px;
            margin-right: 10px;
            border-radius: 5px;
        }
        .cabinets ul li{
            height: 44px;
            line-height: 44px;
            border-bottom:1px solid #ccc;
            /*box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);*/
            /*border-radius: .1rem;*/
            /*margin-bottom: 10px;*/
            /*margin-left: 10px;*/
            /*margin-right: 10px;*/
            /*border-radius: 5px;*/
        }
        .cabinets ul li img{
            margin-left: 5px;
            width: 30px;
            vertical-align: middle;
        }
        .cabinets a{
            border-bottom:1px solid #ccc;
            cursor: pointer;
            color:#333
        }
        .iconone{
            padding-left:10px;
            line-height: 60px;
        }
        .mui-search .mui-placeholder .mui-icon {
            color: #333;
            margin-top: 9px;
        }

        .cabinets1{
            width: 30px;
            height: 30px;
            margin: 0 auto;
            border-radius: 50%;
            border: 3px solid #BEBEBE;
            border-left: 3px solid #fff;
            animation: load 1s linear infinite;
            -moz-animation:load 1s linear infinite;
            -webkit-animation: load 1s linear infinite;
            -o-animation:load 1s linear infinite;
        }
        @-webkit-keyframes load
        {
            from{-webkit-transform:rotate(0deg);}
            to{-webkit-transform:rotate(360deg);}
        }
        @-moz-keyframes load
        {
            from{-moz-transform:rotate(0deg);}
            to{-moz-transform:rotate(360deg);}
        }
        @-o-keyframes load
        {
            from{-o-transform:rotate(0deg);}
            to{-o-transform:rotate(360deg);}
        }
    </style>
</head>
<body>
    <div class="content">
        <span class="mui-icon mui-icon-undo icontwo" style="margin-left: 15px;display: none"></span>
<%--        <lable style="padding-left: 10px">公共文件柜</lable>--%>
        <div class="mui-input-row mui-search" id="search" style="margin-top: 10px;margin-left: 30px;width: 75%;display: inline-block; vertical-align: middle;">
            <input type="search" class="mui-input-clear search" placeholder="" style="background-color: #fff;border: 1px solid #ccc">
        </div>
        <span class="mui-icon mui-icon-more iconone"></span>
    </div>

    <div class="cabinets">
        <div class="cabinets1" style="height: 30px; margin-top: 200px"></div>
        <ul class="file">
        </ul>
    </div>
</body>
</html>
<script>
var userSordId=["diyiceng",'dierceng'];
var flagsBB=1;
var flags;

    mui('.content').on('tap','.iconone',function(){
        $(".icontwo").show();
        $('#search').css({'margin-left':'10px','width':'73%'});
        flagsBB=0;
        //alert(1)
        //获取所有父级文件夹
        $.ajax({
            url:'/newFilePub/getNewAllPrivateFile?sortId=0',
            type:'get',
            dataType:'json',
            success:function(res){
                var data = res.datas
                //console.log(data)
                var strs = ''
                for(var i=0;i<data.length;i++){
                    if(data[i].sortName==undefined){
                        data[i].sortName=''
                    }else{
                        //console.log(data[i].sortName)
                        strs+='<li class="sort" onclick="getChild(\''+data[i].sortId+'\');" sortParent = "'+data[i].sortParent+'">\n' +
                            '                    <img src="/img/file/m/Group.png" alt="" style="">\n' +
                            '                    <span style="font-size: 13px;font-weight: 500;margin-left: 10px;">'+empty(data[i].sortName)+'</span>\n' +
                            '                    <span class="mui-icon mui-icon-arrowright" style="float: right;margin-top: 14px;"></span>\n' +
                            '                </li>'
                    }
                }
                $('.file').html(strs)
            }
        })

    })

    //获取父级文件夹下的子级文件夹或文件
    function getChild(sortId){
        userSordId.push(sortId)
        $.ajax({
                //url:'/newFilePub/getNewAllPrivateFile',
                url:'/newFilePub/getAndoridAllPrivateFile',
                type:'get',
                dataType:'json',
                data:{
                    sortId: sortId,
                    //sortType:5
                },
                success:function(res){
                    var data = res.object
                    //console.log(data.folder[0].sortName)
                    var strs = ''

                    if(data.folder.length > 0){
                        for(var i=0;i<data.folder.length;i++){
                            if(data.folder[i].sortName==undefined){
                                data.folder[i].sortName=''
                            }else{
                                //console.log(data.folder[i].sortName)
                                strs+='<li onclick="getChild(\''+data.folder[i].sortId+'\');">\n' +
                                    '                    <img src="/img/file/m/Group.png" alt="" style="">\n' +
                                    '                    <span style="font-size: 13px;font-weight: 500;margin-left: 10px;">'+empty(data.folder[i].sortName)+'</span>\n' +
                                    '                    <span class="mui-icon mui-icon-arrowright" style="float: right;margin-top: 14px;"></span>\n' +
                                    '                </li>'
                            }

                        }

                    }
                    if(data.file.length>0){
                        for(var i=0;i<data.file.length;i++) {
                            //console.log(data.file[i].sortId)
                            strs += '<li ><p style="overflow: hidden; white-space: nowrap;text-overflow: ellipsis;width: 330px;">\n' +
                                '                    <img src="/img/file/m/file.png" alt="" style="">\n' +
                                '                    <span onclick="moreInfo(\''+data.file[i].contentId+'\');" style="font-size: 13px;font-weight: 500;margin-left: 10px;">' + empty(data.file[i].attachmentName) + '</span>\n' +
                                // '                    <span class="mui-icon mui-icon-arrowright" style="float: right;margin-top: 14px;"></span>\n' +
                                '            </P>    </li>'
                        }
                    }
                    $('.file').html(strs)
                }
            })
    }

    //点击文件跳转到更多详情
    function moreInfo(contentId){
        window.location.href="/KnowledgePortalH5/suitDetails?contentId="+contentId;
    }

    //公共文件柜所有文件列表
    $.ajax({
        url:'/newFileContent/Ph/serachTopTenFile?serachType=2',
        type:'get',
        dataType:'json',
        beforeSend:function(){
            $(".cabinets1").show()
            // var string = ''
            // //显示效果
            // string+='<div class="loading">\n' +
            //     '    </div>'
            // $('.cabinets1').html(string)
        },
        // complete:function(){
        //     //效果自己可以关闭
        // },
        success:function(res){
            $('.cabinets1').hide()
            var data = res.obj
            var strs = ''
            for(var i=0;i<data.length;i++){
                if(data[i].attachmentList[0]==undefined){
                    data[i].attachmentList[0]=''
                }else{
                    strs+='<a href="/KnowledgePortalH5/suitDetails?contentId='+data[i].contentId+'" style="display: block;"><p style="overflow: hidden; white-space: nowrap;text-overflow: ellipsis;width: 330px;">\n' +
                        '                    <img src="/img/file/m/file.png" alt="" style="">\n' +
                        '                    <span class="limit" style="font-size: 13px;font-weight: 500;margin-left: 10px; ">'+empty(data[i].attachmentList[0].attachName)+ '</span>\n' +
                        '                </p></a>'
                }
                // function () {
                //     var limit = data[i].attachmentList[0].attachName;
                //     if (limit.length > 40) {
                //         //截取固定长度
                //         var allAttrCut = limit.substring(0, 40);
                //         //为隐藏<span>标签赋值--全部
                //         $(".limit").text(allAttrCut);
                //     } else {
                //         $(".limit").text(allAttrCut);
                //     }
                //     // if (limit == ''){
                //     //
                //     // }
                // }()+
            }

            $('.file').html(strs)
        }
    })

    //点击左箭头返回上级
    mui('.content').on('tap','.icontwo',function(){
            //window.location.href='/KnowledgePortalH5/system'
        var canshu;
        if(userSordId[userSordId.length-2]=="dierceng"){
            userSordId= userSordId.slice(0, -1);
            //获取父级文件夹
            $.ajax({
                url:'/newFilePub/getNewAllPrivateFile?sortId=0',
                //url:'/newFileContent/Ph/serachTopTenFile',
                type:'get',
                dataType:'json',
                success:function(res){
                    var data = res.datas
                    //console.log(data)
                    var strs = ''
                    for(var i=0;i<data.length;i++){
                        if(data[i].sortName==undefined){
                            data[i].sortName=''
                        }else{
                            //console.log(data[i].sortName)
                            strs+='<li>\n' +
                                '                    <img src="/img/file/m/Group.png" alt="" style="">\n' +
                                '                    <span style="font-size: 13px;font-weight: 500;margin-left: 10px;">'+empty(data[i].sortName)+'</span>\n' +
                                '                    <span class="mui-icon mui-icon-arrowright" onclick="getChild(\''+data[i].sortId+'\');" style="float: right;margin-top: 14px;"></span>\n' +
                                '                </li>'
                        }
                    }
                    $('.file').html(strs)
                    $(".icontwo").show();
                    $('#search').css({'margin-left':'10px','width':'73%'});
                }
            })
        }else if(userSordId[userSordId.length-2]=="diyiceng"){
            $.ajax({
                url:'/newFileContent/Ph/serachTopTenFile?serachType=2',
                type:'get',
                dataType:'json',
                success:function(res){
                    var data = res.obj
                    var strs = ''
                    for(var i=0;i<data.length;i++){
                        if(data[i].attachmentList[0]==undefined){
                            data[i].attachmentList[0]=''
                        }else{
                            strs+='<a href="/KnowledgePortalH5/suitDetails?sortId='+data[i].sortId+'" style="display: block"><p style="overflow: hidden; white-space: nowrap;text-overflow: ellipsis;width: 330px;">\n' +
                                '                    <img src="/img/file/m/file.png" alt="" style="">\n' +
                                '                    <span style="font-size: 13px;font-weight: 500;margin-left: 10px;">'+empty(data[i].attachmentList[0].attachName)+'</span>\n' +
                                '                </p></a>'
                        }
                    }
                    $('.file').html(strs)
                    $(".icontwo").hide();
                    $('#search').css({'margin-left':'30px','width':'75%'});
                }
            })
        }else{
            canshu= userSordId[userSordId.length-2];
            userSordId= userSordId.slice(0, -1);
            $.ajax({
                //url:'/newFilePub/getNewAllPrivateFile',
                url:'/newFilePub/getAndoridAllPrivateFile',
                type:'get',
                dataType:'json',
                data:{
                    sortId: canshu,
                    //sortType:5
                },
                success:function(res){
                    var data = res.object
                    //console.log(data.folder[0].sortName)
                    var strs = ''

                    if(data.folder.length>0){
                        for(var i=0;i<data.folder.length;i++){
                            if(data.folder[i].sortName==undefined){
                                data.folder[i].sortName=''
                            }else{
                                //console.log(data.folder[i].sortName)
                                strs+='<li>\n' +
                                    '                    <img src="/img/file/m/Group.png" alt="" style="">\n' +
                                    '                    <span onclick="getChild(\''+data.folder[i].sortId+'\');" style="font-size: 13px;font-weight: 500;margin-left: 10px;">'+empty(data.folder[i].sortName)+'</span>\n' +
                                    '                    <span class="mui-icon mui-icon-arrowright" style="float: right;margin-top: 14px;"></span>\n' +
                                    '                </li>'
                            }

                        }
                    }
                    if(data.file.length>0){
                        for(var i=0;i<data.file.length;i++) {
                            //console.log(data.file[i].sortId)
                            strs += '<li><p style="overflow: hidden; white-space: nowrap;text-overflow: ellipsis;width: 330px;">\n' +
                                '                    <img src="/img/file/m/file.png" alt="" style="">\n' +
                                '                    <span onclick="moreInfo(\''+data.file[i].contentId+'\');" style="font-size: 13px;font-weight: 500;margin-left: 10px;">' + empty(data.file[i].attachmentName) + '</span>\n' +
                                // '                    <span class="mui-icon mui-icon-arrowright" style="float: right;margin-top: 14px;"></span>\n' +
                                '            </p>    </li>'
                        }
                    }
                    $('.file').html(strs)
                    $(".icontwo").show();
                    $('#search').css({'margin-left':'10px','width':'73%'});
                }
            })
        }

    })

    // 搜索
    //wenjiangui('')
    function wenjiangui(subject){
        $.ajax({
            url:'/newFileContent/Ph/serachAll',
            type:'get',
            dataType:'json',
            data:{
                // approveStatus:1,
                // instStatus:1,
                // instType:1,
                // limit:10,
                // page:1,
                // sortName:sortName,
                subject:subject,
                serachType:2
            },
            success:function(res){
                var strs ='';
                var data = res;
                if(data !=''){
                    for(var i=0;i<data.length;i++){
                        if(data[i].showPriv == false){
                            strs+='<li onclick="getChild(\''+data[i].sortId+'\');" sortParent = "'+data[i].sortParent+'" sortId = "'+data[i].sortId+'">\n' +
                                '                    <img src="/img/file/m/Group.png" alt="" style="">\n' +
                                '                    <span style="font-size: 13px;font-weight: 500;margin-left: 10px;">'+empty(data[i].sortName)+'</span>\n' +
                                '                    <span class="mui-icon mui-icon-arrowright" style="float: right;margin-top: 14px;"></span>\n' +
                                '         </li>'
                        }else{
                            strs+='<li onclick="moreInfo(\''+data[i].contentId+'\');" sortParent = "'+data[i].sortParent+'" sortId = "'+data[i].sortId+'"><p style="overflow: hidden; white-space: nowrap;text-overflow: ellipsis;width: 330px;">\n' +
                                '                    <img src="/img/file/m/file.png" alt="" style="">\n' +
                                '                    <span style="font-size: 13px;font-weight: 500;margin-left: 10px;">'+empty(data[i].subject)+'</span>\n' +
                                //   '                    <span class="mui-icon mui-icon-arrowright" style="float: right;margin-top: 14px;"></span>\n' +
                                '         </p>       </li>'
                        }
                    }
                    $('.file').html(strs)
                }else{
                    strs='<div style="font-size:20px;text-align: center;line-height: 50px">无数据</div>'
                    $('.file').html(strs)
                }
            }
        })
    }
    //搜索
    $(".search").bind("input propertychange", function() {
        wenjiangui($('.search').val())
        // var sortParent = $('.sort').attr('sortParent')
        // var sort = $('.sort').attr('sortid')
        // if(sortParent !=0){
        //     getChild(sort,$('.search').val())
        // }
        // else{
        //     wenjiangui($('.search').val())
        // }
    });
    //清除
    mui(".mui-input-clear")[0].addEventListener('focus', function(){
        mui(".mui-icon-clear")[0].addEventListener('tap',function(){
            //alert(1111)
            $.ajax({
            url:'/newFileContent/Ph/serachTopTenFile?serachType=2',
            type:'get',
            dataType:'json',
            beforeSend:function(){
                $(".cabinets1").show()
                $(".file").hide();
            },
            // complete:function(){
            //     //效果自己可以关闭
            // },
            success:function(res){
                //alert(11111111)
                $('.cabinets1').hide()
                var data = res.obj
                var strs = ''
                for(var i=0;i<data.length;i++){
                    if(data[i].attachmentList[0]==undefined){
                        data[i].attachmentList[0]=''
                    }else{
                        strs+='<a href="/KnowledgePortalH5/suitDetails?sortId='+data[i].sortId+'" style="display: block"><p style="overflow: hidden; white-space: nowrap;text-overflow: ellipsis;width: 330px;">\n' +
                            '                    <img src="/img/file/m/file.png" alt="" style="">\n' +
                            '                    <span style="font-size: 13px;font-weight: 500;margin-left: 10px;">'+empty(data[i].attachmentList[0].attachName)+'</span>\n' +
                            '                </p></a>'
                    }
                }
                $('.file').html(strs)
                $(".file").show();
            }
        })
        });
    })
    //判断返回是否为空
    function empty(esName) {
        if (esName==undefined ||esName==''){
            return ''
        }else{
            return esName
        }
    }
</script>