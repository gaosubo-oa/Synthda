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
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>分类详情</title>
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
            margin-left: 10px;
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
        }
        .cont div p{
            height: 32px;
            line-height: 32px;
            color: #333;
        }
        .icon{
            float: right;
            font-size: 28px !important;
            color: #ccc;
            line-height: 53px
        }

        .subset span{
            font-size: 15px;
        }
        .subset .item{
            display: inline-block;
            width: 80px;
            text-align: right;
        }
        .subset div{
            box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);
            border-radius: .1rem;
            margin-bottom: 15px;
            border-radius: 5px;
        }
        .subset div p{
            height: 32px;
            line-height: 32px;
            color: #333;
        }
        .over{
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            vertical-align: bottom;
            margin: auto 10px;
        }
    </style>
</head>
<body>
<div>
    <div class="content">
        <%--制度的查询--%>
        <div>
            <span class="mui-icon mui-icon-undo moreFiles"></span>
            <div class="mui-input-row mui-search" style="margin-top: 10px;width: 90%;display: inline-block; vertical-align: middle;">
                <input type="search" class="mui-input-clear search" placeholder="" style="background-color: #fff;border: 1px solid #ccc">
            </div>
            <%--<button type="button" class="mui-btn mui-btn-primary btn moreFiles">返回</button>--%>
        </div>
        <%--制度内容--%>
        <div class="cont">

        </div>
        <%--子集制度内容--%>
        <div class="subset">

        </div>
    </div>
</div>
</body>

</html>
<script>
    fenlei('')
    function fenlei(instName){
        $.ajax({
            url:'/InstitutionSort/findSortFather',
            type:'get',
            dataType:'json',
            data:{
                sortParent:0,
                instName:instName,
                keyWords:instName
            },
            success:function(res){
                var data = res.obj
                var str = ''
                for(var i=0;i<data.length;i++){
                    var flag =''
                    var kuan ='80%'
                    if(data[i].isLeaf==false){
                        flag= "inline-block"
                        kuan="80%"
                    }else{
                        flag = "none"
                        kuan="100%"
                    }

                    str+='<a class="sort" sortId="'+data[i].sortId+'" sortParent = "'+data[i].sortParent+'"  style="display: block"><div style="line-height: 53px">\n' +
                        '                <span class="titleName" style="margin-left: 10px;display: inline-block;width:'+kuan+';">'+data[i].sortName+'</span>' +
                        ' <span class="mui-icon mui-icon-arrowright icon" style="display:'+flag+'"></span>\n' +
                        '            </div><div class="subset'+data[i].sortId+'"></div></a>'
                }
                $('.cont').html(str)
            }
        })
    }
    //搜索
    $(".search").bind("input propertychange", function() {
        var sortParent = $('.sort').attr('sortParent')
        var sort = $('.sort').attr('sortid')
        if(sortParent !=0){
            child(sort,$('.search').val())
        }
        else{
            fenlei($('.search').val())
        }
    });

    $(document).on('click', '.icon', function () {
        var sortParent = $('.sort').attr('sortid')
        child(sortParent,'')
    })

    $(document).on('click','.titleName',function () {
        var sortParent = $(this).parent().parent('.sort').attr('sortId')
        collection(sortParent)
        if($('.subset'+sortParent).css('display')!='none'){
            $('.subset'+sortParent).css('display','none')
        }else{
            $('.subset'+sortParent).css('display','block')
        }
    })

    function collection (sortId) {
        $.ajax({
            url:'/InstitutionContent/findContentWhere',
            type:'get',
            dataType:'json',
            data:{
                sortId:sortId
            },success:function(res){
                var strs ='';
                var data = res.obj
                for(var i=0;i<data.length;i++){
                    strs +='<div><a href="/KnowledgePortalH5/systemDetails?instId='+data[i].instId+'">\n' +
                        // '                <p>\n' +
                        // '                    <span class="item">制度编号：</span><span>'+empty(data[i].instNumber)+'</span>\n' +
                        // '                </p>\n' +
                        '                <p class="over">\n' +
                        '                    <span class="item">制度名称：</span><span>'+empty(data[i].instName)+'</span>\n' +
                        '                </p>\n' +
                        '                <p class="over">\n' +
                        '                    <span class="item">制度分类：</span><span>'+empty(data[i].institutionSort.sortName)+'</span>\n' +
                        '                </p>\n' +
                        '            </a></div>'
                }
                $('.subset'+sortId+'').html(strs)
            }
        })
    }
    //判断子集的方法
    function child (sortParent,keyWords){
        $.ajax({
            url:'/InstitutionSort/findSortFather',
            type:'get',
            dataType:'json',
            data:{
                sortParent:sortParent,
                keyWords:keyWords,
                instName:keyWords
            },
            success:function(res){
                var data = res.obj
                var str = ''
                if(data!=''){
                    for(var i=0;i<data.length;i++){
                        var flag =''
                        if(data[i].isLeaf==false){
                            flag= "inline-block"
                        }else{
                            flag = "none"
                        }
                        str+='<a href="javascript:;" class="sort" sortId="'+data[i].sortId+'" sortParent = "'+data[i].sortParent+'" style="display: block"><div style="line-height: 53px" >\n' +
                            '                <span class="titleName" style="margin-left: 10px;display: inline-block;width: 100%;">'+data[i].sortName+'</span> ' +
                            '<span class="mui-icon mui-icon-arrowright picture icon"  style="display:'+flag+'"></span>\n' +
                            '            </div><div class="subset'+data[i].sortId+'"></div></a>'
                    }
                    $('.cont').html(str)
                }
            }

        })
    }

    //公共文件柜更多
    $('.moreFiles').click(function(){
        if($('.sort').attr('sortParent')==0){
            window.location.href='/KnowledgePortalH5/moreSystems'
        }else{
            window.location.href='/KnowledgePortalH5/classification'
        }

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