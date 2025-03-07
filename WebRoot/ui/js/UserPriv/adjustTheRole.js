/**
 * Created by liruixu on 2017/6/16.
 */
var arr=[];

function func_up(){
    if($('option:selected').val()==undefined){
        alert(chooseOne)
        return
    }
    var optionIndex = $('select').get(0).selectedIndex;
    console.log(optionIndex)
    if(optionIndex > 0){
        $('option:selected').insertBefore($('select option:selected').prev('option'));
        arrstr()
    }
}
function func_down() {
    if($('option:selected').val()==undefined){
        alert(chooseOne)
        return
    }
    var optionIndexs = $('select').get(0).selectedIndex;
    var optionLength = $('select')[0].options.length;
    if(optionIndexs ==(optionLength-1)){
        return
    }else {
        $('option:selected').insertAfter($('select option:selected').next('option'));
        arrstr()
    }
}


function arrstr(){
    for(var ix=0;ix<arr.length;ix++){
        $('option').get(ix).setAttribute('no',arr[ix])
    }
}

function mysubmit() {
    var arrays=[];
    $('option').each(function(l,p){
        var objtwo={};
        objtwo.userPriv=$(this).val();
        objtwo.privNo=$(this).attr('no');
        arrays.push(objtwo)
    })
    var objects=String(JSON.stringify(arrays))
    $.post('/userPriv/updNoByPrivId',{'mapList':objects},function (json) {
        if(json.flag){
            $.layerMsg({content:Sort,icon:1},function () {
                // parent.newjump('')
                location.href='roleAuthorization'
            })
        }
    },'json')
}

$(function () {
    $.get('/getAllUserPriv',function (json) {
        if(json.flag) {
            var str = '';

            for (var i = 0; i < json.obj.length;i++){
                str+='<option value="'+json.obj[i].userPriv+'" no="'+json.obj[i].privNo+'">'+json.obj[i].privName+'</option>'
                arr.push(json.obj[i].privNo)
            }
            console.log(arr)
            $('[name="select1"]').html(str)
        }
    },'json')



})