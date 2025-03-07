<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>蓝信OA</title>
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <link href="../../css/H5/default.css" rel="stylesheet"/>
    <style>
        .nav{
            font-size: 0.28rem;
            color: #666;
            margin: 0 0.2rem;
            line-height: 0.8rem;
            padding-left: 0.18rem;
            position: relative;
        }
        .chunk{
            width: 4px;
            height: 13px;
            background:#7caeff;
            display: inline-block;
            position: relative;
            top: 2px;
            right: 9px;
        }
        .usernav {
            font-size: 0.24rem;
            display: flex;
            /*align-items: center;*/
            background-color: #fff;
            text-align: center;
            flex-wrap: wrap;
        }
        .usernav img{
            width: 0.9rem;
            height: 0.9rem;
            margin:0 auto;
        }
        .usernav div{
            padding-top: 0.15rem;
            color: #666;
        }
        input{
            width: 88%;
            border:1px solid #ccc;
            padding-left: .05rem;
            height: .5rem;
            margin: .1rem 0;
            border-radius: 3px;

        }
        .usernav a{
            width: 25%;
            position: relative;
            margin: .2rem 0;
        }

        .nav:after {
            position: absolute;
            top: 40px;
            right: 0;
            left: 0;
            height: 1px;
            content: '';
            -webkit-transform: scaleY(.5);
            transform: scaleY(.5);
            background-color: #c8c7cc;
        }
        /*.sub-nav{*/
        /*box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);*/
        /*border-radius: .1rem;*/
        /*background-color: #fff;*/
        /*margin: .25rem .2rem;*/
        /*padding: .1rem 0;*/
        /*}*/
        /*.nav{*/
        /*font-size: 0.28rem;*/
        /*color: #1e90ff;*/
        /*line-height: 0.62rem;*/
        /*padding-left: 0.5rem;*/
        /*position: relative;*/
        /*background-color: #f0f1f3;*/
        /*bottom: 5px;*/
        /*border-radius: 5px 5px 0px 0px;*/
        /*box-shadow: 0px 1px 3px #aeaeae;*/
        /*}*/
        /*body{*/
        /*background-color: #91b1da;*/
        /*}*/
    </style>
    <script type="text/javascript">
        var fs = document.documentElement.clientWidth / 750  * 100;
        document.querySelector("html").style.fontSize = fs + "px";
    </script>
</head>
<body>
<div class="mui-content" style="background: #ffffff;">
    <section class="usernav">

    </section>
</div>
</body>
<script>
    //封装的方法
    $.extend({
        getQueryString:function(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]);
            return null;
        }
    });
    function strToJson(str){
        var json = (new Function("return " + str))();
        return json;
    }
    $(function(){
        var menuId = $.getQueryString("menuId");
        $.ajax({
            method:'get',
            url:'/showSubclassesMenu',
            data:{
                menuId:menuId
            },
            dataType:'json',
            success:function(res){
                res=strToJson(res)
                console.log(res)
                if(res.flag){
                    var str='';
                    $.each(res.obj,function(index,item){
//                        str+='<div>'+
//                            '<p class="nav"><span class="chunk"></span>'+item.name+'</p>'+
//                            '<div>'+
//                            '<section class="usernav">';
//                            var b
//                            if(item.name1==undefined){
//                                b= ''
//                            }else {
//                                var a=item.name1
//                                b = a.replace(/\s/g,'');
//                            }
//                            str+=
//                                '<a id="'+item.id+'" fId="'+item.fId+'" url="/'+item.url+'" class="alerts">'+
//                                '<img src="../../img/menu/'+b+'.png"/>'+
//                                '<div>'+item.name+'</div>'+
//                                '</a>'
//
//                        str += '</section>'+
//                            '</div>'+
//                            '</div>';


                        var b
                        if(item.name1==undefined){
                            b= ''
                        }else {
                            var a=item.name1
                            b = a.replace(/\s/g,'');
                        }
                        str+=
                            '<a id="'+item.id+'" fId="'+item.fId+'" url="/'+item.url+'" class="alerts">'+
                            '<img src="../../img/menu/'+b+'.png"/>'+
                            '<div>'+item.name+'</div>'+
                            '</a>'

                    })
                    $('.usernav').html(str)
                }
            }
        })


        $('.mui-content').on('click','a',function(){
            var child=$(this).attr('child')
            var menuId=$(this).attr('id')
            if(child==0){
                var url=$(this).attr('url')
                $(this).attr('href',url)
            }
            if(child==1){
                window.location.href='/m/gettwoMenu?menuId='+menuId
            }
        })
    })
</script>
</html>