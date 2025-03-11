/**
 * Created by FK on 2018/7/30.
 */

// select回显
function echosel(n,v) { //n：标签name名称 v：option的val值
    if(arguments.length==2){ var b=$("select[name="+n+"]").find("option");if(b.length!=0&&b!=undefined){for (var k = 0; k < b.length; k++) {if ($(b[k]).val() == v){$(b[k]).attr("selected", "selected");break;}}}};
}

//填充select
function fillsel(n,o,v,m,p) { //n：select标签name名称 o：列表集合 v：option的val值 m：option的显示名称 p：默认false 传true不显示请选择
    if(arguments.length==4||arguments.length==5){p=p||false;var l=new Array();if(!p){l.push("<option value=''>请选择</option>");};if(o.length!=0&&o!=undefined){for(var i=0;i<o.length;i++){l.push("<option value=\""+o[i][v]+"\">"+o[i][m]+"</option>");}};$("select[name="+n+"]").html(l.join(""));}
}

//验证必填字段是否为空
function testval(c,d) { //c：需要验证的class名称 d：验证需要提示的属性名称 通过返回true 失败返回false
    if(arguments.length==2){
    var s = '.'+c
    var a=$(s);
    for(var i=0; i< a.length; i++){
        if(a[i].value==""){
            var tmp=$(a[i]).attr(d)|| '';
            $.layerMsg({content:tmp+"不能为空",icon: 2}, function(){
            });
            return false;
        };
    };
    if(i == a.length){
        return true;
    }
    }
}

//只能输入数字方法
function enterumbers(n) { //n：需要验证的对象（this即可）
    var text3 = document.getElementById(n);
    text3.onkeyup = function(){
        this.value=this.value.replace(/\D/g,'');
    }
}