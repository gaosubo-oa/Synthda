function returnColDom(colList){
    console.log(colList)
    var str = ''
    colList.forEach(function(item,index,arr){
        switch (item.colType){
            case 'C01':
                str +='           <div class="layui-form-item" style="width: 95%;margin-left: 20px;display: inline-block">\n' +
                    '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '                   <p style="font-size: 14px;margin-bottom: 8px;">' + item.colName+ isHasDes(item.inputDesc) +'</p>\n' +
                    '                   <div class="layui-input-inline" style="width:90%">\n' +
                    '                    <textarea type="text" colKtype="'+ item.colKtype+'" placeholder="'+ item.defaultVal+'" id="COL'+ item.colId+'" name="COL'+ item.colId+'" autocomplete="off" class="layui-input bian"></textarea>' +
                    '                   </div>\n' +
                    '               </div>\n' +
                    '           </div>'
                break

            case 'C02':
                str +='           <div class="layui-form-item" style="width: 95%;margin-left: 20px;display: inline-block">\n' +
                    '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '                   <p style="font-size: 14px;margin-bottom: 8px;">' + item.colName+ isHasDes(item.inputDesc) +'</p>\n' +
                    '                   <div class="layui-input-inline" style="width:90%">\n' +
                    '                    <textarea type="text" colKtype="'+ item.colKtype+'" placeholder="'+ item.defaultVal+'" id="COL'+ item.colId+'" name="COL'+ item.colId+'" autocomplete="off" class="layui-input bian"></textarea>' +
                    '                   </div>\n' +
                    '               </div>\n' +
                    '           </div>'
                break

            case 'C03':
                str +='           <div class="layui-form-item" style="width: 95%;margin-left: 20px;display: inline-block">\n' +
                    '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '                   <p style="font-size: 14px;margin-bottom: 8px;">' + item.colName+ isHasDes(item.inputDesc) + '</p>\n' +
                    '                   <div class="layui-input-inline" style="width:90%">\n' +
                    '                    <input type="text" colStyle="'+item.colStyle+'" readonly colKtype="'+ item.colKtype+'" placeholder="'+ item.defaultVal+'" id="COL'+ item.colId+'" name="COL'+ item.colId+'" autocomplete="off" class="layui-input bian"></input>' +
                    '                   </div>\n' +
                    '               </div>\n' +
                    '           </div>'
                break

            case 'C04':
                str +='<div class="layui-form-item" style="width: 95%;margin-left: 20px;display: inline-block">\n' +
                    '   <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '       <p style="font-size: 14px;margin-bottom: 8px;">'+ item.colName + isHasDes(item.inputDesc) +'</p>\n' +
                    '       <div class="layui-input-inline" style="width:90%">\n' +
                    '           <input type="text" colKtype="'+ item.colKtype+'" id="COL'+ item.colId+'" name="COL'+ item.colId+'" autocomplete="off" class="layui-input bian">' +
                    '       </div>\n' +
                    '   </div>\n' +
                    '</div>'
                break

            case 'C05':

                break

            case 'C06':
                str +='<div class="layui-form-item" style="width: 95%;margin-left: 20px;display: inline-block">\n' +
                    '   <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '       <p style="font-size: 16px;margin-bottom: 8px;">'+ item.colName+ isHasDes(item.inputDesc) +'</p>\n' +
                    '       <div class="layui-input-inline" style="width:90%">\n' +
                        JSONcheckboxData(JSON.parse(item.colStyle).selectOption,JSON.parse(item.colStyle).selectedOption) +
                    '       </div>\n' +
                    '   </div>\n' +
                    '</div>'
                break

            case 'C07':

                break

            case 'C08':

                break

            case 'C09':

                break

            case 'C16':
                str +='<div class="layui-form-item" style="width: 95%;margin-left: 20px;display: inline-block">\n' +
                    '   <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '       <p style="font-size: 16px;margin-bottom: 8px;">'+ item.colName+'</p>\n' +
                    '       <div class="layui-input-inline" style="width:90%">\n' +
                    isSwitch(item.colStyle,'<input type="checkbox" value="1" name="state" lay-skin="switch" lay-text="开|关" checked>','<input type="checkbox" value="0" name="state" lay-skin="switch" lay-text="开|关">') +
                    '       </div>\n' +
                    '   </div>\n' +
                    '</div>'
                break
        }
    })

    var formStr = '<div style="margin: 30px auto;" class="formBox">' +
        '       <span style="font-size: 16px;font-weight: bold;margin-left: 20px;display: inline-block;width: 96%;border-bottom: 1px solid rgb(224,227,233);height:35px">基本信息</span>\n' +
        '       <form class="layui-form"  action="">\n' +
        str+
        '       </form>' +
        '</div>'
    return formStr
}

// 提示tips
function isHasDes(des){
    if(des){
        return ' <i class="layui-icon layui-icon-tips" data-des="' + des +'" onmouseenter="colTipsEnter(this)" onmouseleave="colTipsLeave(this)"></i>'
    }else{
        return ''
    }
}

// 描述进入
function colTipsEnter(dom){
    var des = $(dom).attr('data-des')
    var obj = dom.getBoundingClientRect()
    $('#colDes').text(des)
    var x = obj.left - parseInt($('#colDes').css('width'))/2
    var y = obj.top - parseInt($('#colDes').css('height')) -25
    $('#colDes').css({
        display:'block',
        top:y,
        left:x
    })
}

// 描述离开
function colTipsLeave(){
    setTimeout(function(){
        $('#colDes').css({
            display:'none'
        })
    },100)
}

//生成复选框
function JSONcheckboxData(list,checkedList){
    var checkedStr = ''
    list.forEach(function(item,index,arr){
        if (checkedList.indexOf(item) != -1){
            checkedStr += '<input type="checkbox" name="check" lay-skin="primary" title="' + item + '" checked>'
        }else{
            checkedStr += '<input type="checkbox" name="check" lay-skin="primary" title="' + item + '">'
        }
    })
    return checkedStr
}

//开关是否
function isSwitch(flag,yDOM,nDOM){
    if(flag=='1'){
        return yDOM
    }else{
        return nDOM
    }
}


// 返回日期控件
function returnDates(data) {
    for(var i=0;i<data.length;i++){
        switch (data[i].colType) {
            case 'C03':
                if(data[i].colKtype == 'C0301'){
                    var obj = {}
                    obj.id = '#COL'+data[i].colId
                    obj.type = data[i].colStyle
                    if(data[i].colStyle == 'C030101'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            // ,type: dateArr[i].type
                            ,format: 'yyyy年MM月dd日'
                        });
                    }else if(data[i].colStyle == 'C030102'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'month'
                            ,format: 'yyyy年MM月'
                        });
                    }else if(data[i].colStyle == 'C030103'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            // ,type: dateArr[i].type
                            ,format: 'MM月dd日'
                        });
                    }else if(data[i].colStyle == 'C030104'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            // ,type: dateArr[i].type
                            ,format: 'yyyy-MM-dd'
                        });
                    }else if(data[i].colStyle == 'C030105'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'month'
                            ,format: 'yyyy-MM'
                        });
                    }else if(data[i].colStyle == 'C030106'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            // ,type: 'month'
                            ,format: 'MM-dd'
                        });
                    }else if(data[i].colStyle == 'C030107'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'year'
                            ,format: 'yyyy年'
                        });
                    }else if(data[i].colStyle == 'C030108'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'month'
                            ,format: 'M月'
                        });
                    }
                    // type.push(obj)

                }else if(data[i].colKtype == 'C0302'){
                    var obj = {}
                    obj.id = '#COL'+data[i].colId
                    obj.type = data[i].colStyle
                    if(data[i].colStyle == 'C030201'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'time'
                            ,format: 'HH时mm分'
                        });
                    }else if(data[i].colStyle == 'C030202'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'time'
                            ,format: 'HH时mm分ss秒'
                        });
                    }else if(data[i].colStyle == 'C030203'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'time'
                            ,format: 'HH:mm'
                        });
                    }else if(data[i].colStyle == 'C030204'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'time'
                            ,format: 'HH:mm:ss'
                        });
                    }
                    // type.push(obj)
                }else if(data[i].colKtype == 'C0303'){
                    var obj = {}
                    obj.id = '#COL'+data[i].colId
                    obj.type = data[i].colStyle
                    if(data[i].colStyle == 'C030301'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'datetime'
                            ,format: 'yyyy年M月d日 H时m分s秒'
                        });
                    }else if(data[i].colStyle == 'C030302'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'datetime'
                            // ,format: 'yyyy-M-d H:m:s'
                        });
                    }
                    // type.push(obj)
                }
                break

            case 'C04':
                if(data[i].colKtype == 'C0401'){
                    var num = Number(data[i].colStyle[data[i].colStyle.length-1])
                    $('.formBox #COL'+data[i].colId).blur(function(e){
                        if(isNaN(Number($(this).val()))){
                            $(this).val('')
                        }else{
                            $(this).val(Number($(this).val()).toFixed(num))
                        }
                    })
                }else if(data[i].colKtype == 'C0402'){
                    var num = Number(data[i].colStyle[data[i].colStyle.length-1])
                    $('.formBox #COL'+data[i].colId).focus(function(e){
                        $(this).val(e.currentTarget.value.split(',').join(''))
                    })

                    $('.formBox #COL'+data[i].colId).blur(function(e){
                        if(isNaN(Number($(this).val()))){
                            $(this).val('')
                        }else{
                            $(this).val(numFormat(Number($(this).val()).toFixed(num)))
                        }
                    })
                }else if(data[i].colKtype == 'C0403'){
                    var num = Number(data[i].colStyle[data[i].colStyle.length-1])
                    $('.formBox #COL'+data[i].colId).focus(function(e){
                        $(this).val(e.currentTarget.value.split('%').join(''))
                    })
                    $('.formBox #COL'+data[i].colId).blur(function(e){
                        if(isNaN(Number($(this).val()))){
                            $(this).val('')
                        }else{
                            $(this).val(Number($(this).val()).toFixed(num) + '%')
                        }
                    })
                }
                break;

        }
    }
}

// 添加千分符
function numFormat(num){
    num=num.toString().split(".");  // 分隔小数点
    var arr=num[0].split("").reverse();  // 转换成字符数组并且倒序排列
    var res=[];
    for(var i=0,len=arr.length;i<len;i++){
        if(i%3===0&&i!==0){
            res.push(",");   // 添加分隔符
        }
        res.push(arr[i]);
    }
    res.reverse(); // 再次倒序成为正确的顺序
    if(num[1]){  // 如果有小数的话添加小数部分
        res=res.join("").concat("."+num[1]);
    }else{
        res=res.join("");
    }
    return res;
}