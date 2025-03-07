
/*
var query_1 = document.getElementById('query_1');
var query_2=document.getElementById("query_2");
var query_3=document.getElementById("query_3");
var query_4=document.getElementById("query_4");
var query_5=document.getElementById("query_5");
var query_6=document.getElementById("query_6");
var query_7=document.getElementById("query_7");
var query_8=document.getElementById("query_8");
var query_9=document.getElementById("query_9");
var query_10=document.getElementById("query_10");
var query_11=document.getElementById("query_11");
*/


$(function () {
        $.ajax({
            url:'../sys/showUnitManage',
            type:'get',
            dataType:'json',
            success:function (data) {

                $('#query_1').val(data.object.unitName);
                $('#query_2').val(data.object.telNo);
                $('#query_3').val(data.object.faxNo);
                $('#query_4').val(data.object.postNo);
                $('#query_5').val(data.object.address);
                $('#query_6').val(data.object.url);
                $('#query_7').val(data.object.email);
                $('#query_8').val(data.object.bankName);
                $('#query_9').val(data.object.bankNo);
                $('#query_10').val(data.object.attachmentName);
                $('#query_11').val(data.object.attachmentId);
                $('#units').val(data.object.content);
            }
        })

$('#submit').click(function () {
    $.ajax({
        url:'http://127.0.0.1:8080/sys/updateUnit',
        type:'get',
        dataType:'json',
        data:{
             unitName:$('#query_1').val(),
             telNo:$('#query_2').val(),
             faxNo:$('#query_3').val(),
             postNo:$('#query_4').val(),
             address:$('#query_5').val(),
             url:$('#query_6').val(),
             email:$('#query_7').val(),
             bankName:$('#query_8').val(),
             bankNo:$('#query_9').val(),
             attachmentId:$('#query_10').val(),
             attachmentName:$('#query_11').val()
        },
        success:function (data) {
            console.log(data)
        }
    })


})

})












