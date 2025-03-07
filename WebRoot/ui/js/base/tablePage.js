/**
 * Created by 骆鹏 on 2017/11/14.
 */
// document.write("<script src='/js/common/language.js'><\/script>");
/**
 * zlj
 * js多语言引入文件
 * @param name
 * @returns {null}
 */

function getCookie(name)
{
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
    if(arr=document.cookie.match(reg))
        return unescape(arr[2]);
    else
        return null;
}

function check(name){
    if(name==undefined){
        return ''
    }else{
        return name;
    }
}

var oHead = document.getElementsByTagName('HEAD').item(0);

var oScript= document.createElement("script");
var type = getCookie("language");
oScript.type = "text/javascript";

if(type){
    oScript.src="/js/Internationalization/"+type+".js";
}else{
    oScript.src="/js/Internationalization/zh_CN.js";
}
oHead.appendChild( oScript);

// jQuery.getScript("/js/common/language.js")
//     .done(function() {
//获取国际语言标志
var type = getCookie("language");

var no_Data="";
if (type == 'zh_CN') {
    no_Data='暂无数据';
} else if (type == 'en_US') {
    no_Data='No data';
} else if (type == 'zh_TW') {
    no_Data='暫無數據';
} else {
    no_Data='暂无数据';
}
$.extend({
    tablePage: function (receptacleUrl,containerWidth, configuration,fun) {
        //第一个参数放三个属性第一个容器id名字
        //第二个参数是array，数组里单个是object,放表单title和宽度，和后台对相应字段名,selectFun参数是需要特殊处理时的方法 如{title:'',width:数字,name:'',selectFun}
        return new TablePages(receptacleUrl,containerWidth, configuration,fun);
    }
});
function TablePages(receptacleUrl,containerWidth,configuration,fun) {

    this.Table=$('<div><div class="pagediv" style="margin: 0 auto;width: 97%;">' +
        '<div class="page-top-outer-layer" style="width: '+containerWidth+'">\
                <div class="page-top-inner-layer">\
                    <table style="width: '+containerWidth+'" border="0" cellpadding="0" cellspacing="0">\
                        <thead>\
                            <tr>\
                            </tr>\
                        </thead>\
                    </table>\
                </div>\
             </div>\
             <div class="page-bottom-outer-layer" style="width:'+(parseInt(containerWidth))+'px">\
                   <div class="page-bottom-inner-layer" style=" ">\
                       <table border="0" cellpadding="0" cellspacing="0" style="width: '+containerWidth+'">\
                            <tbody id="pageTbody">\
                            </tbody>\
                            <tfoot id="operation">\
                            </tfoot>\
                       </table>\
                    </div>\
              </div>\
              <div id="dbgz_page" class="fr">\
                    </div>\
        </div></div>');
    this.configuration=configuration;
    var theadTrstr='';
    var TablePagesme=this;
    for(var i=0;i<this.configuration.length;i++){
        theadTrstr+='<th style="'+function () {
            if(TablePagesme.configuration[i].width!=undefined){
                return  'width:'+TablePagesme.configuration[i].width
            } else {
                return ''
            }
        }()+'">'+TablePagesme.configuration[i].title+'</th>';
    }

    $(this.Table).find('.page-top-inner-layer').find('tr').html(theadTrstr);
    $(receptacleUrl).html(this.Table);

    var winHeight = 0;
    if (window.innerHeight)
        winHeight = window.innerHeight;
    else if ((document.body) && (document.body.clientHeight))
        winHeight = document.body.clientHeight;
    if (document.documentElement && document.documentElement.clientHeight)
        winHeight = document.documentElement.clientHeight;
    $('.page-bottom-inner-layer').height(winHeight-$('.pagediv').offset().top-$('.page-top-outer-layer').height()-38-40)
    $('.page-bottom-inner-layer').width($('.pagediv').width())
    $('.page-bottom-inner-layer').css({'overflow-x':'hidden'})
    addEventHandler(window,'resize',function () {
        var winHeight = 0;
        if (window.innerHeight)
            winHeight = window.innerHeight;
        else if ((document.body) && (document.body.clientHeight))
            winHeight = document.body.clientHeight;
        if (document.documentElement && document.documentElement.clientHeight)
            winHeight = document.documentElement.clientHeight;
        $('.page-bottom-inner-layer').height(winHeight-$('.pagediv').offset().top-$('.page-top-outer-layer').height()-38-40)
        $('.page-bottom-inner-layer').width($('.pagediv').width())
        $('.page-bottom-inner-layer').css({'overflow-x':'hidden'})
        $('.pagediv').scrollLeft(0)

    })
    var scrollNum=0;
    $('.pagediv').on('scroll', function () {
        if($(this).scrollLeft()>scrollNum){
            if($('.page-bottom-inner-layer').width()<parseInt(containerWidth)){

                $('.page-bottom-inner-layer').width($('.pagediv').width()+$(this).scrollLeft())
            }
            scrollNum=$(this).scrollLeft();
        }else{
            if($('.page-bottom-inner-layer').width()>$('.pagediv').width()){
                $('.page-bottom-inner-layer').width(
                    $('.page-bottom-inner-layer').width()-(scrollNum-$(this).scrollLeft()))
            }

            scrollNum=$(this).scrollLeft();
        }

    })
    this.data = {//分页参数
        page: 1,//当前处于第几页
        pageSize: 5,//一页显示几条
        useFlag: true
    };
    this.pageurl = null;
    this.pageTwo = function (totalData, pageSize, indexs, fn) {
        var mes = this;
        layui.use('laypage', function(){
            var laypage = layui.laypage;

            //执行一个laypage实例
            laypage.render({
                elem: 'dbgz_page' //注意，这里的 test1 是 ID，不用加 # 号
                ,count: totalData //数据总数，从服务端得到
                ,limit: pageSize
                ,limits: [5, 10, 15, 20, 25, 30, 40, 50, 60, 70, 80, 90, 100]
                ,layout: ['prev', 'page', 'next', 'skip', 'count', 'limit']
                ,theme: '#2b7fe0'
                ,jump: function(obj, first){
                    //obj包含了当前分页的所有参数
                    mes.data.page = obj.curr;
                    if(mes.data.pageSize != obj.limit){
                        try{
                            var userId = $.cookie('userId');
                            $.get('/userModulePage/save', {
                                userId: userId,
                                moduleTable: moduleTable,
                                pages: obj.limit
                            }, function(json){
                                if(!json.flag){
                                    console.log(userIds + '在moduleTable的page保存失败！')
                                }
                            })
                        } catch(e){
                            console.log(e + '【该模块未设置具体moduleTable值，无法保存这个用户选择的分页数据展示数！】')
                        }
                    }
                    mes.data.pageSize = obj.limit;
                    //首次不执行
                    if(!first){
                        var url,type;
                        mes.init(url, type, fn, 1);
                    }
                }
            });
        });
        // $('#dbgz_page').pagination({
        //     totalData: totalData,
        //     showData: pageSize,
        //     jump: true,
        //     coping: true,
        //     // homePage:'',
        //     // endPage: '',
        //     homePage: '首页',
        //     endPage: '末页',
        //     prevContent: '上一页',
        //     nextContent: '下一页',
        //     current:indexs||1,
        //     callback: function (index) {
        //         mes.data.page = index.getCurrent();
        //         if(fn != undefined){
        //             var url,type;
        //             mes.init(url,type,fn);
        //         }else{
        //             mes.init();
        //         }
        //     }
        // });
    };
    this.arrs = null;
    this.init = function (url, operation, fn, jump) {//第二个参数放操作项array类型，例如 [编辑，修改]
        var argumentsAll=arguments;
        $('#pageTbody').empty()
        var indexPage = layer.load(1);
        var me=this;
        if(url!=undefined){
            me.pageurl=url;
        }
        if(operation!=undefined) {
            me.operation = operation;
        }

        $.get(me.pageurl,me.data,function (json) {
            var str='';
            me.arrs=null;
            var arr=[];
            if(json.datas!=undefined){
                me.arrs=json.datas;
                arr=json.datas;
            }else if(json.data!=undefined){
                me.arrs=json.data;
                arr=json.data;
            }else if(json.object!=undefined){
                me.arrs=json.object;
                arr=json.object;
            }else{
                if(json.obj){
                    me.arrs=json.obj;
                    arr=json.obj;
                }
            };
            var tbodyStr='';
            for(var i=0;i<arr.length;i++){
                str=$('<tr></tr>');
                for(var m=0;m<me.configuration.length;m++){
                    if(m==me.configuration.length-1){
                        var operationArrstr='';
                        if(me.operation!=undefined) {
                            for (var n = 0; n < me.operation.length; n++) {
                                var operationAndA=$('<span style="margin-right: 10px;display: inline-block;cursor: pointer" class="editAndDelete' + n + '">' + me.operation[n].name + '</span>')
                                $(operationAndA).attr('data-i',i)

                                if(typeof me.operation[n].fn=='function'){
                                    if(me.operation[n].fn(arr[i])==2){//不显示
                                        operationArrstr+='';
                                    }else if(me.operation[n].fn(arr[i])==1){
                                        operationArrstr += operationAndA.get(0).outerHTML;
                                    }else if(typeof me.operation[n].fn(arr[i])=='string'){
                                        operationArrstr+='<span style="margin-right: 10px;display: inline-block;cursor: pointer" data-i="'+i+'" class="editAndDelete' + n + '">' + me.operation[n].fn(arr[i]) + '</span>'
                                    }
                                }else {
                                    operationArrstr += operationAndA.get(0).outerHTML;
                                }
                            }
                            $(str).append('<td style="width: '+me.configuration[m].width+'">' + operationArrstr + '</td>')
                        }else {
                            if(typeof me.configuration[m].selectFun=='function'){
                                $(str).append('<td style="width: '+me.configuration[m].width+'">'+ me.configuration[m].selectFun(arr[i][me.configuration[m].name],arr[i])+'</td>')

                            }else {
                                $(str).append('<td style="width: '+me.configuration[m].width+'">'+check(arr[i][me.configuration[m].name])+'</td>')
                            }
                        }

                    }else {
                        if(typeof me.configuration[m].selectFun=='function'){
                            $(str).append('<td style="width: '+me.configuration[m].width+'">'+ me.configuration[m].selectFun(arr[i][me.configuration[m].name],arr[i],i)+'</td>')

                        }else {
                            $(str).append('<td style="width: '+me.configuration[m].width+'">'+check(arr[i][me.configuration[m].name])+'</td>')
                        }

                    }

                }
                tbodyStr+=str[0].outerHTML;
            }

            $('#pageTbody').html(tbodyStr)
            if(tbodyStr==''){
                tbodyStr = '<li class="no_notice" style="background:#fff;text-align: center;padding: 27px 0px;' +
                    'border: 1px solid #c0c0c0;border-top: none;width:'+($('.page-top-outer-layer').width()-1)+'px">' +
                    '<img style="margin-bottom: 20px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;font-size: 16px">'+no_Data+'</h2>' +
                    '</li>';
                $('#pageTbody').html(tbodyStr)
            }


            layer.close(indexPage);
            if(!jump&&json.flag){
                if(fn != undefined){
                    me.pageTwo(json.total||json.totleNum,me.data.pageSize,me.data.page,fn);
                }else{
                    me.pageTwo(json.total||json.totleNum,me.data.pageSize,me.data.page);
                }
            }
            if(typeof argumentsAll[argumentsAll.length-1]=='function'){
                argumentsAll[argumentsAll.length-1](json)
            }
        },'json')
    }
    if(typeof fun=='function'){
        fun(this)
    }
}

// })
// .fail(function() {
//     alert('language.js文件引入错误')
// });





//绑定事件
document.write("<script src='/lib/layer/layer.js?20201106'><\/script>");
document.write("<script src='/lib/pagination/js/jquery.pagination.min.js'><\/script>");
document.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"/lib/layui/layui/css/layui.css?20220512.1\">\n");
try{
    console.log(layui)
}catch(e){
    document.write("<script src='/lib/layui/layui-v2.6.8/layui/layui.js?20220728.1'><\/script>");
}
//绑定事件
if (!Function.prototype.bind) {
    Function.prototype.bind = function (oThis) {
        if (typeof this !== "function") {
            throw new TypeError("Function.prototype.bind - what is trying to be bound is not callable");
        }
        var aArgs = Array.prototype.slice.call(arguments, 1),
            fToBind = this,
            fNOP = function () {},
            fBound = function () {
                return fToBind.apply(this instanceof fNOP && oThis
                    ? this
                    : oThis,
                    aArgs.concat(Array.prototype.slice.call(arguments)));
            };
        fNOP.prototype = this.prototype;
        fBound.prototype = new fNOP();
        return fBound;
    };
}


function addEventHandler(target,type,fn){
    if(target.addEventListener){
        target.addEventListener(type,fn,false);
    }else{
        target.attachEvent("on"+type,fn,false);
    }
}



