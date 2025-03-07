function workFormPrintView(){
    if (printTable) {
        printTable()
    }
    window.focus();
    try{
        document.getElementById("WebBrowser").ExecWB(7,1);
        window.close()
    }catch(e){
        $.layerMsg({content: e.description, icon: 0}, function () {

        });
        $.layerMsg({content: '如不能打印预览，请调整安全级别！具体方法如下：根据当前页面所属安全区域，自定义安全设置，找到设置项“对未标记为可安全执行的脚本的Activex控件进行初始化并执行脚本”，将其设置为“提示”即可。', icon: 0}, function () {

        });
    }
}

function workFormPrint() {
    if (printTable) {
        printTable()
    }
    window.focus();
    window.print();
    window.close();
}

$(function (){
    if (!!window.ActiveXObject || "ActiveXObject" in window)  {
        $('head').append('<style>@media print { body {width: 2000px;zoom: 0.54;} * {font-size: 20px !important;}}</style>');
    } else {
        $('head').append('<style>@media print { body {width: 2000px;zoom: 0.5;} * {font-size: 20px !important;}}</style>');
    }

    if(location.href.indexOf('&printview=1') > -1){
        $('#save').hide()
        setTimeout(workFormPrintView, 1500);
    }

    if(location.href.indexOf('&print=1') > -1){
        $('#save').hide()
        setTimeout(workFormPrint, 1500);
    }
})