<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String corpId = (String)request.getAttribute("corpId");
    String corpSecret = (String)request.getAttribute("corpSecret");
%>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>制度</title>
    <link rel="stylesheet" href="../../css/email/m/jquery.mobile.css" />
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>

    <link rel="stylesheet" href="../../css/email/m/styles.css" />
    <link rel="stylesheet" href="../../css/email/m/style.css">
    <link rel="stylesheet" href="../../css/email/m/mail.css">
    <script type="text/javascript" src="../../js/notes/jquery-2.1.2.min.js" ></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <%--<script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>--%>
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <script type="text/javascript" src="../../js/diary/m/simbaJs.js" ></script>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/base.js?20190927.1"></script>


    <link rel="stylesheet" href="../../lib/mui/mui/mui.picker.min.css" />
    <script type="text/javascript" src="../../lib/mui/mui/mui.picker.min.js" ></script>
    <style>
        body{
            height: 100%;
            overflow-y: auto;
        }
        .content{
            margin: auto 10px;
        }
        .btn{
            margin-top: 11px;
        }
        .cont span{
            font-size: 15px;
        }
        .cont .item{
            display: inline-block;
            width: 80px;
            text-align: right;
        }
        .cont div{
            box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);
            border-radius: .1rem;
            margin-bottom: 15px;
            border-radius: 5px;
            box-sizing: border-box;
            padding-left: 5px;
        }
        .cont div p{
            height: 32px;
            line-height: 32px;
            color: #333;
        }
        .cabinets div{
            height: 40px;
        }
        .cabinets p{
            line-height: 50px;
            border-bottom:1px solid #ccc;
            color:#333
            /*box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);*/
            /*border-radius: .1rem;*/
            /*margin-bottom: 10px;*/
            /*margin-left: 10px;*/
            /*margin-right: 10px;*/
            /*border-radius: 5px;*/

        }
        .cabinets p img{
            width: 40px;
            vertical-align: middle;
        }
        .cabinets ul{
            box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);
            border-radius: .1rem;
            margin-bottom: 10px;
            margin-left: 3px;
            margin-right: 3px;
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
            cursor: pointer;
            color:#333;
        }
    </style>
</head>
<body>
<div>
    <div class="content">
        <%--制度的查询--%>
        <div>
            <span>制度管理</span>
            <div class="mui-input-row mui-search" style="margin-top: 10px;width: 59%;display: inline-block; vertical-align: middle;">
                <input type="search" class="mui-input-clear search" placeholder="" style="background-color: #fff;border: 1px solid #ccc">
            </div>
            <button type="button" class="mui-btn mui-btn-primary btn more">更多</button>
        </div>
        <%--制度内容--%>
        <div class="cont">

        </div>

        <%--公共文件的查询--%>
        <div style="margin-top: 10px;">
            <span>公共文件柜</span>
            <div class="mui-input-row mui-search" style="margin-top: 10px;width: 54%;display: inline-block; vertical-align: middle;">
                <input type="search" class="mui-input-clear fileSearch" placeholder="" style="background-color: #fff;border: 1px solid #ccc">
            </div>
            <button type="button" class="mui-btn mui-btn-primary btn moreFiles">更多</button>
        </div>
        <div class="cabinets">
            <ul class="file">

            </ul>
        </div>
    </div>
</div>
</body>

</html>
<script>
    // $('.search').change(function(){
    //     console.log($('.search').val())
    // })
    zhidu('')
    <%--制度管理--%>
    function zhidu(instName){
        $.ajax({
            url:'/InstitutionContent/findContentWhere',
            type:'get',
            dataType:'json',
            data:{
                approveStatus:1,
                instStatus:1,
                instType:1,
                limit:10,
                page:1,
                instName:instName,
                keyWords:instName

            },
            success:function(res){
                var str ='';
                var data = res.obj
                if(data !=''){
                    for(var i=0;i<data.length;i++){
                        str +='<div><a href="/KnowledgePortalH5/systemDetails?instId='+data[i].instId+'">\n' +
                            // '                <p>\n' +
                            // '                    <span class="item">制度编号：</span><span>'+empty(data[i].instNumber)+'</span>\n' +
                            // '                </p>\n' +
                            '                <p>\n' +
                            '                    <span class="item">制度名称：</span><span>'+empty(data[i].instName)+'</span>\n' +
                            '                </p>\n' +
                            '                <p>\n' +
                            '                    <span class="item">制度分类：</span><span>'+empty(data[i].institutionSort.sortName)+'</span>\n' +
                            '                </p>\n' +
                            '            </a></div>'
                    }
                    $('.cont').html(str)
                }else{
                    str='<div style="font-size:20px;text-align: center;line-height: 50px">无数据</div>'
                    $('.cont').html(str)
                }
            }
        })
    }
    $(".search").bind("input propertychange", function() {
        zhidu($('.search').val())
    });

    //公共文件柜
    $.ajax({
        url:'/newFileContent/Ph/serachTopTenFile',
        type:'get',
        dataType:'json',
        data:{
            page:1,
            limit:10,
            useFlag:true
        },
        success:function(res){
            var data = res.obj
            var strs = ''
            if(data !=''){
                for(var i=0;i<data.length;i++){
                    if(data[i].attachmentList[0]==undefined){
                        data[i].attachmentList[0]=''
                    }else{
                        strs+='<a href="/KnowledgePortalH5/suitDetails?contentId='+data[i].contentId+'" style="display: block">' +
                            '<p>\n' +
                            '                    <img src="/img/file/m/file.png" alt="" style="">\n' +
                            '                    <span style="font-size: 13px;font-weight: 500;margin-left: 10px;">'+empty(data[i].attachmentList[0].attachName)+'</span>\n' +
                            '                </p></a>'
                    }
                }
                $('.file').html(strs)
            }else{
                strs='<div style="font-size:20px;text-align: center;line-height: 50px">无数据</div>'
                $('.file').html(strs)
            }

        }
    })
    $(".fileSearch").bind("input propertychange", function() {
        wenjiangui($('.fileSearch').val())
    });
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
                                '                </li>'
                        }else{
                            strs+='<li onclick="moreInfo(\''+data[i].contentId+'\');" sortParent = "'+data[i].sortParent+'" sortId = "'+data[i].sortId+'">\n' +
                                '                    <img src="/img/file/m/file.png" alt="" style="">\n' +
                                '                    <span style="font-size: 13px;font-weight: 500;margin-left: 10px;">'+empty(data[i].subject)+'</span>\n' +
                                //   '                    <span class="mui-icon mui-icon-arrowright" style="float: right;margin-top: 14px;"></span>\n' +
                                '                </li>'
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
    //点击文件跳转到更多详情
    function moreInfo(contentId){
        window.location.href="/KnowledgePortalH5/suitDetails?contentId="+contentId;
    }
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
                        strs += '<li>\n' +
                            '                    <img src="/img/file/m/file.png" alt="" style="">\n' +
                            '                    <span onclick="moreInfo(\''+data.file[i].sortId+'\');" style="font-size: 13px;font-weight: 500;margin-left: 10px;">' + empty(data.file[i].attachmentName) + '</span>\n' +
                            // '                    <span class="mui-icon mui-icon-arrowright" style="float: right;margin-top: 14px;"></span>\n' +
                            '                </li>'
                    }
                }
                $('.file').html(strs)
            }
        })
    }

    //制度更多
    $('.more').click(function(){
        window.location.href='/KnowledgePortalH5/moreSystems'
    })
    //公共文件柜更多
    $('.moreFiles').click(function(){
        window.location.href='/KnowledgePortalH5/fileCabinet'
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
