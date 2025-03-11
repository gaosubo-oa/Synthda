var user_id;
var dept_id;
// 解析表单控件 新增编辑详情页面
function gcolumn_field_tatol(colList,showColIds,flag){
    var str1 = '';
    var str2 = '';
    var str3 = '';
    var colLists = returnObjArr(colList);

    for(var i=0;i<colLists.length;i++){
        (function (i) {
            if(i == 0){
                if(colLists[i][0].colType != 'L02'){
                    str1 = gcolumn_field(colLists[i],flag);
                }else{
                    str1 = gcolumn_field(colLists[i],flag)
                }
            }
            if(i != 0 && i<colLists.length-1){
                str2 += gcolumn_field(colLists[i],flag);
            }
            if(i != 0 && i == colLists.length-1){
                if(colLists[i].length > 1){
                    str3 = gcolumn_field(colLists[i],flag);
                }else{
                    str3 = '';
                }
            }

        })(i)
    }
    if(str3 == ''){
        var str = str1 + str2 ;
    }else{
        var str = str1 + str2 + str3;
    }
    if(flag == 'edit'){
        var formStr = '<div style="margin: 30px auto;" class="formBox">' +
            '       <span class="spanTitle" style="font-size: 16px;font-weight: bold;margin-left: 20px;display: inline-block;width: 97%;border-bottom: 1px solid rgb(224,227,233);height:35px"></span>\n' +
            '<li class="layui-icon layui-icon-edit" style="position: absolute;top: 30px;right: 120px;cursor: pointer;" data-type="1" id="BUT_FORM_EDIT">编辑</li>' +
            '<li class="layui-icon layui-icon-delete" style="position: absolute;top: 30px;right: 40px;cursor: pointer;" id="BUT_FORM_DEL">删除</li>' +
            // '<li class="layui-icon layui-icon-file-b" style="position: absolute;top: 40px;right: 140px;cursor: pointer;" id="BUT_FORM_TEMP">暂存</li>' +
            // '<li class="layui-icon layui-icon-ok" style="position: absolute;top: 40px;right: 20px;cursor: pointer;" id="BUT_FORM_SUBMIT">提交</li>' +
            // '<li class="layui-icon layui-icon-file" style="position: absolute;top: 40px;right: 80px;cursor: pointer;" id="BUT_FORM_SAVE">保存</li>' +
            '       <form id="context_gapp" class="layui-form" action="">\n' +
            str+
            '   </form>' +
            '</div>'
    }else if(flag == 'add'){
        var formStr = '<div style="margin: 30px auto;" class="formBox">' +
            '       <span class="spanTitle" style="font-size: 16px;font-weight: bold;margin-left: 20px;display: none;width: 97%;border-bottom: 1px solid rgb(224,227,233);height:35px"></span>\n' +
            '       <form id="context_gapp" class="layui-form"  action="">\n' +
            str+
            '       </form>' +
            '</div>'
    }
    return formStr
}

function gcolumn_field(colList,flag) {

    var allstr = ''
    if(colList[0].colType != 'L02'){
        var str = ''
        colList.forEach(function(item,index,arr){
            if(item.colType){
                if(Number(item.vm) == 100){
                    var vm = 'calc(100% - 20px)';
                }else{
                    var n = 20*Number(item.vm)/100 + 10
                    var vm = 'calc('+Number(item.vm)+'% - '+n+'px)';
                }
                switch (item.colType){
                    case 'C01':
                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">' + item.colName+ isHasDes(item.inputDesc)+'</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            '                    <input type="text" nam="C01" colKtype="'+ item.colKtype+'" value="'+item.defaultVal+'" placeholder="'+ isHasTips(item.inputTips)+'" id="COL'+ item.colId+'" name="COL'+ item.colId+'" autocomplete="off" class="layui-input bian"></input>' +
                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break

                    case 'C02':
                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">' + item.colName+ isHasDes(item.inputDesc) +'</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            '                    <textarea type="text" rows="'+item.colStyle+'" colKtype="'+ item.colKtype+'" value="'+item.defaultVal+'" placeholder="'+ isHasTips(item.inputTips)+'" id="COL'+ item.colId+'" name="COL'+ item.colId+'" autocomplete="off" class="layui-textarea bian"></textarea>' +
                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break

                    case 'C03':
                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">' + item.colName+ isHasDes(item.inputDesc) + '</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            '                    <input type="text" colStyle="'+item.colStyle+'" placeholder="'+ isHasTips(item.inputTips)+'" readonly colKtype="'+ item.colKtype+'" id="COL'+ item.colId+'" name="COL'+ item.colId+'" autocomplete="off" class="layui-input bian"></input>' +
                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break

                    case 'C04':
                        str +='<div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '   <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '       <p style="font-size: 14px;margin-bottom: 8px;">'+ item.colName + isHasDes(item.inputDesc) +'</p>\n' +
                            '       <div class="layui-input-inline" style="width:100%">\n' +
                            '           <input type="text" num="num" colKtype="'+ item.colKtype+'"  placeholder="'+ isHasTips(item.inputTips)+'" id="COL'+ item.colId+'" name="COL'+ item.colId+'" autocomplete="off" class="layui-input bian">' +
                            '       </div>\n' +
                            '   </div>\n' +
                            '</div>'
                        break

                    case 'C05':
                        var itemObj = JSON.parse(item.colStyle);
                        var radioStr = '';
                        for(var j=0;j<itemObj.selectOption.length;j++){
                            if(itemObj.selectOption[j] == itemObj.selectedOption[0]){
                                radioStr += '<input type="radio" colKtype="'+ item.colKtype+'" title="'+itemObj.selectOption[j]+'" checked="" name="COL'+item.colId+'" autocomplete="off" class="layui-input bian">'
                            }else{
                                radioStr += '<input type="radio" colKtype="'+ item.colKtype+'" title="'+itemObj.selectOption[j]+'"  name="COL'+item.colId+'" autocomplete="off" class="layui-input bian">'
                            }
                        }
                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">'+item.colName+ isHasDes(item.inputDesc)+'</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            radioStr+
                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break

                    case 'C06':
                        var itemObj = JSON.parse(item.colStyle);
                        var cheStr = '';
                        if(flag == 'add'){
                            cheStr = JSONcheckboxData(JSON.parse(item.colStyle).selectOption,JSON.parse(item.colStyle).selectedOption,item)
                        }else{
                            for(var j=0;j<itemObj.selectOption.length;j++){
                                cheStr += '<input type="checkbox" name="COL'+item.colId+'" lay-skin="primary" title="'+itemObj.selectOption[j]+'">'
                            }
                        }
                        str +='<div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '   <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '       <p style="font-size: 16px;margin-bottom: 8px;">'+ item.colName+ isHasDes(item.inputDesc) +'</p>\n' +
                            '       <div class="layui-input-inline" style="width:100%">\n' +
                            cheStr+
                            '       </div>\n' +
                            '   </div>\n' +
                            '</div>'
                        break

                    case 'C07':
                        var itemObj = JSON.parse(item.colStyle);
                        var selectStr = '<option></option>';
                        for(var j=0;j<itemObj.selectOption.length;j++){
                            if(itemObj.selectOption[j] == itemObj.selectedOption[0]){
                                selectStr += '<option selected="selected" value="'+itemObj.selectOption[j]+'">'+itemObj.selectOption[j]+'</option>'
                            }else{
                                selectStr += '<option value="'+itemObj.selectOption[j]+'">'+itemObj.selectOption[j]+'</option>'
                            }
                        }

                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">'+item.colName+ isHasDes(item.inputDesc)+'</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            '<select name="COL'+item.colId+'">' +
                            selectStr+
                            '</select>'+

                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break

                    case 'C08':
                        str+='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline">\n' +
                            '                   <p>'+item.colName+ isHasDes(item.inputDesc)+'</p>\n' +
                            '                  <div class="layui-input-block" style="padding-top: 9px;margin: 0">\n' +
                            '                    <div id="COL'+item.colId+'s">' +
                            '                        <input id="COL'+item.colId+'_id" type="hidden" name="attachmentId">' +
                            '                        <input id="COL'+item.colId+'_name" type="hidden" name="attachmentName"></div>' +
                            '                    <div id="COL'+item.colId+'">\n' +
                            '                    </div>\n' +
                            '                    <a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                            '                        <img src="../img/mg11.png" alt="">\n' +
                            '                        <span>添加附件</span>\n' +
                            '                        <input type="file" name="file" id="COL'+item.colId+'0" data-url="/upload?module=gapp">\n' +
                            '                    </a>\n' +
                            '                   </div>' +
                            '               </div>\n'+
                            '</div>'
                        break

                    case 'C09':
                        str+='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline">\n' +
                            '                   <p>'+item.colName+ isHasDes(item.inputDesc)+'</p>\n' +
                            '                  <div class="layui-input-block" style="padding-top: 9px;margin: 0">\n' +
                            '                    <div id="COL'+item.colId+'s">' +
                            '                        <input id="COL'+item.colId+'_id" type="hidden" name="attachmentId">' +
                            '                        <input id="COL'+item.colId+'_name" type="hidden" name="attachmentName"></div>' +
                            '                    <div id="COL'+item.colId+'">\n' +
                            '                    </div>\n' +
                            '                    <a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                            '                        <img src="../img/mg11.png" alt="">\n' +
                            '                        <span>添加图片</span>\n' +
                            '                        <input type="file" name="file" id="COL'+item.colId+'0" data-url="/upload?module=gapp">\n' +
                            '                    </a>\n' +
                            '                   </div>' +
                            '               </div>\n'+
                            '</div>'
                        break

                    case 'C15':
                        var itemObj = JSON.parse(item.colStyle);
                        var itemObjGappid = itemObj.gappid;
                        var itemObjGappName = itemObj.gappName;
                        var selectStr = '<option value="">请选择</option>';
                        $.ajax({
                            url:'/gtable/selectGappID',
                            async:false,
                            data:{gappid:itemObjGappid},
                            success:function (res) {
                                var param = res.obj
                                if(res.flag && param){
                                    for(var i=0;i<param.length;i++){
                                        selectStr += '<option value="'+ param[i] +'">'+ param[i] +'</option>'
                                    }
                                }
                            }
                        })

                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">'+item.colName+ isHasDes(item.inputDesc)+'</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            '<select name="COL'+item.colId+'">' +
                            selectStr+
                            '</select>'+

                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break

                    case 'C16':
                        str +='<div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '   <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '       <p style="font-size: 16px;margin-bottom: 8px;">'+ item.colName+ isHasDes(item.inputDesc)+'</p>\n' +
                            '       <div class="layui-input-inline" style="width:100%">\n' +
                            isSwitch(item.colStyle,'<input type="checkbox" value="1" name="COL'+ item.colId +'" lay-skin="switch" lay-text="是|否" checked>','<input type="checkbox" value="0" name="COL'+ item.colId +'" lay-skin="switch" lay-text="是|否">') +
                            '       </div>\n' +
                            '   </div>\n' +
                            '</div>'
                        break
                    case 'S01':
                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">创建人</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            '                    <input type="text" readonly placeholder="" id="CREATE_USER_ID" name="CREATE_USER_ID" autocomplete="off" class="layui-input bian"></input>' +
                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break;
                    case 'S02':
                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">创建时间</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            '                    <input type="text" readonly placeholder="" id="CREATE_TIME" name="CREATE_TIME" autocomplete="off" class="layui-input bian"></input>' +
                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break;
                    case 'S03':
                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">修改时间</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            '                    <input type="text" readonly placeholder="" id="UPDATE_TIME" name="UPDATE_TIME" autocomplete="off" class="layui-input bian"></input>' +
                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break;
                    case 'S04':
                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">拥有者</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            '                   <button type="button" onclick="selectUser($(this))" class="layui-btn" style="margin-bottom: 5px">请选择</button>' +
                            '                    <textarea rows="3" type="text" readonly placeholder="请选择" id="OWNER_USER_ID" name="OWNER_USER_ID" autocomplete="off" class="layui-textarea bian"></textarea>' +
                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break;
                    case 'S05':
                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">所属部门</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            '                   <button type="button" onclick="selectUser($(this))" class="layui-btn" style="margin-bottom: 5px">请选择</button>' +
                            '                    <textarea rows="3" type="text" readonly placeholder="请选择" id="DEPT_ID" name="DEPT_ID" autocomplete="off" class="layui-textarea bian"></textarea>' +
                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break;
                    case 'S06':
                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">' + item.colName + '</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            '                    <input type="text" readonly placeholder="" id="DATA_ID" name="DATA_ID" autocomplete="off" class="layui-input bian"></input>' +
                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break;
                    case 'L03':
                        str += '<div class="layui-form-item  input-enter input-active childTable" style="position: relative; left: 0px;padding-top: 15px;overflow-x: auto;" data-flag="" data-type="' + item.colType + '" data-id="COL' + item.colId + '">\n' +
                        '       <div style="margin-left: 10px;position:relative;z-index:0;">' +
                        '            <div>' + item.colName + '</div>' +
                        '            <hr style="background: #e6e6e6;width: 99%;"/>' +
                        '            <button id="col-addnew" class="col-addnew layui-btn layui-btn" type="button">新增</button>\n' +
                        '            <button id="col-delete" class="col-delete layui-btn layui-btn layui-btn-danger" type="button">删除</button>\n' +
                        '        </div>' +
                        '       <div id="table-cols" class="table-col">' +
                            '<table class="layui-hide" id="COL'+item.colId+'"></table>' +
                        // '           <div id="colCheckBox" class="table-col-item table-col-preset">' +
                        // '               <div class="table-title default-checkbox"><input id="allInputUpdate" lay-filter="allInputUpdate" type="checkbox" name="layColCheck" lay-skin="primary" ></div>' +
                        // '               <div class="table-content default-checkbox"><input type="checkbox" name="layColCheck" lay-skin="primary" class="checkInfoInSlot" name="checkInfoInSlot" lay-filter ="inputCheckOne"></div>' +
                        // '           </div>' +
                        // '           <div id="" class="table-col-item table-col-preset orderCol" style="margin-left: -5px">' +
                        // '               <div class="table-title">序号</div>' +
                        // '               <div class="table-content">1</div>' +
                        // '           </div>' +
                        // createTableItem(item) +
                        '       </div>' +
                        '   </div>'
                        break;
                }
            }else{
                if(Number(item.vm) == 100){
                    var vm = 'calc(100% - 20px)';
                }else{
                    var n = 20*Number(item.vm)/100 + 10
                    var vm = 'calc('+Number(item.vm)+'% - '+n+'px)';
                }
                str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                    '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '               </div>\n' +
                    '           </div>'
            }

        });
        allstr = str;
    }else{
        var str = '';
        var itemOne = colList[0];
        colList.shift();
        colList.forEach(function(item,index,arr){
            if(item.colType){
                if(Number(item.vm) == 100){
                    var vm = 'calc(100% - 20px)';
                }else{
                    var n = 20*Number(item.vm)/100 + 10
                    var vm = 'calc('+Number(item.vm)+'% - '+n+'px)';
                }
                switch (item.colType){
                    case 'C01':
                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">' + item.colName+ isHasDes(item.inputDesc)+'</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            '                    <input type="text" nam="C01" colKtype="'+ item.colKtype+'" value="'+item.defaultVal+'" placeholder="'+ isHasTips(item.inputTips)+'" id="COL'+ item.colId+'" name="COL'+ item.colId+'" autocomplete="off" class="layui-input bian"></input>' +
                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break

                    case 'C02':
                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">' + item.colName+ isHasDes(item.inputDesc) +'</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            '                    <textarea type="text" rows="'+item.colStyle+'" colKtype="'+ item.colKtype+'" value="'+item.defaultVal+'" placeholder="'+ isHasTips(item.inputTips)+'" id="COL'+ item.colId+'" name="COL'+ item.colId+'" autocomplete="off" class="layui-textarea bian"></textarea>' +
                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break

                    case 'C03':
                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">' + item.colName+ isHasDes(item.inputDesc) + '</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            '                    <input type="text" colStyle="'+item.colStyle+'" placeholder="'+ isHasTips(item.inputTips)+'" readonly colKtype="'+ item.colKtype+'" id="COL'+ item.colId+'" name="COL'+ item.colId+'" autocomplete="off" class="layui-input bian"></input>' +
                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break

                    case 'C04':
                        str +='<div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '   <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '       <p style="font-size: 14px;margin-bottom: 8px;">'+ item.colName + isHasDes(item.inputDesc) +'</p>\n' +
                            '       <div class="layui-input-inline" style="width:100%">\n' +
                            '           <input type="text" num="num" colKtype="'+ item.colKtype+'"  placeholder="'+ isHasTips(item.inputTips)+'" id="COL'+ item.colId+'" name="COL'+ item.colId+'" autocomplete="off" class="layui-input bian">' +
                            '       </div>\n' +
                            '   </div>\n' +
                            '</div>'
                        break

                    case 'C05':
                        var itemObj = JSON.parse(item.colStyle);
                        var radioStr = '';
                        for(var j=0;j<itemObj.selectOption.length;j++){
                            if(itemObj.selectOption[j] == itemObj.selectedOption[0]){
                                radioStr += '<input type="radio" colKtype="'+ item.colKtype+'" title="'+itemObj.selectOption[j]+'" checked="" name="COL'+item.colId+'" autocomplete="off" class="layui-input bian">'
                            }else{
                                radioStr += '<input type="radio" colKtype="'+ item.colKtype+'" title="'+itemObj.selectOption[j]+'"  name="COL'+item.colId+'" autocomplete="off" class="layui-input bian">'
                            }
                        }
                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">'+item.colName+ isHasDes(item.inputDesc)+'</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            radioStr+
                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break

                    case 'C06':
                        var itemObj = JSON.parse(item.colStyle);
                        var cheStr = '';
                        if(flag == 'add'){
                            cheStr = JSONcheckboxData(JSON.parse(item.colStyle).selectOption,JSON.parse(item.colStyle).selectedOption,item)
                        }else{
                            for(var j=0;j<itemObj.selectOption.length;j++){
                                cheStr += '<input type="checkbox" name="COL'+item.colId+'" lay-skin="primary" title="'+itemObj.selectOption[j]+'">'
                            }
                        }
                        str +='<div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '   <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '       <p style="font-size: 16px;margin-bottom: 8px;">'+ item.colName+ isHasDes(item.inputDesc) +'</p>\n' +
                            '       <div class="layui-input-inline" style="width:100%">\n' +
                            cheStr+
                            '       </div>\n' +
                            '   </div>\n' +
                            '</div>'
                        break

                    case 'C07':
                        var itemObj = JSON.parse(item.colStyle);
                        var selectStr = '<option></option>';
                        for(var j=0;j<itemObj.selectOption.length;j++){
                            if(itemObj.selectOption[j] == itemObj.selectedOption[0]){
                                selectStr += '<option selected="selected" value="'+itemObj.selectOption[j]+'">'+itemObj.selectOption[j]+'</option>'
                            }else{
                                selectStr += '<option value="'+itemObj.selectOption[j]+'">'+itemObj.selectOption[j]+'</option>'
                            }
                        }

                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">'+item.colName+ isHasDes(item.inputDesc)+'</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            '<select name="COL'+item.colId+'">' +
                            selectStr+
                            '</select>'+

                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break

                    case 'C08':
                        str+='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline">\n' +
                            '                   <p>'+item.colName+ isHasDes(item.inputDesc)+'</p>\n' +
                            '                  <div class="layui-input-block" style="padding-top: 9px;margin: 0">\n' +
                            '                    <div id="COL'+item.colId+'s">' +
                            '                        <input id="COL'+item.colId+'_id" type="hidden" name="attachmentId">' +
                            '                        <input id="COL'+item.colId+'_name" type="hidden" name="attachmentName"></div>' +
                            '                    <div id="COL'+item.colId+'">\n' +
                            '                    </div>\n' +
                            '                    <a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                            '                        <img src="../img/mg11.png" alt="">\n' +
                            '                        <span>添加附件</span>\n' +
                            '                        <input type="file" name="file" id="COL'+item.colId+'0" data-url="/upload?module=gapp">\n' +
                            '                    </a>\n' +
                            '                   </div>' +
                            '               </div>\n'+
                            '</div>'
                        break

                    case 'C09':
                        str+='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline">\n' +
                            '                   <p>'+item.colName+ isHasDes(item.inputDesc)+'</p>\n' +
                            '                  <div class="layui-input-block" style="padding-top: 9px;margin: 0">\n' +
                            '                    <div id="COL'+item.colId+'s">' +
                            '                        <input id="COL'+item.colId+'_id" type="hidden" name="attachmentId">' +
                            '                        <input id="COL'+item.colId+'_name" type="hidden" name="attachmentName"></div>' +
                            '                    <div id="COL'+item.colId+'">\n' +
                            '                    </div>\n' +
                            '                    <a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                            '                        <img src="../img/mg11.png" alt="">\n' +
                            '                        <span>添加图片</span>\n' +
                            '                        <input type="file" name="file" id="COL'+item.colId+'0" data-url="/upload?module=gapp">\n' +
                            '                    </a>\n' +
                            '                   </div>' +
                            '               </div>\n'+
                            '</div>'
                        break

                    case 'C16':
                        str +='<div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '   <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '       <p style="font-size: 16px;margin-bottom: 8px;">'+ item.colName+ isHasDes(item.inputDesc)+'</p>\n' +
                            '       <div class="layui-input-inline" style="width:100%">\n' +
                            isSwitch(item.colStyle,'<input type="checkbox" value="1" name="COL'+ item.colId +'" lay-skin="switch" lay-text="是|否" checked>','<input type="checkbox" value="0" name="COL'+ item.colId +'" lay-skin="switch" lay-text="是|否">') +
                            '       </div>\n' +
                            '   </div>\n' +
                            '</div>'
                        break
                    case 'S01':
                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">创建人</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            '                    <input type="text" readonly placeholder="" id="CREATE_USER_ID" name="CREATE_USER_ID" autocomplete="off" class="layui-input bian"></input>' +
                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break;
                    case 'S02':
                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">创建时间</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            '                    <input type="text" readonly placeholder="" id="CREATE_TIME" name="CREATE_TIME" autocomplete="off" class="layui-input bian"></input>' +
                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break;
                    case 'S03':
                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">修改时间</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            '                    <input type="text" readonly placeholder="" id="UPDATE_TIME" name="UPDATE_TIME" autocomplete="off" class="layui-input bian"></input>' +
                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break;
                    case 'S04':
                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">拥有者</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            '                   <button type="button" onclick="selectUser($(this))" class="layui-btn" style="margin-bottom: 5px">请选择</button>' +
                            '                    <textarea rows="3" type="text" readonly placeholder="请选择" id="OWNER_USER_ID" name="OWNER_USER_ID" autocomplete="off" class="layui-textarea bian"></textarea>' +
                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break;
                    case 'S05':
                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">所属部门</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            '                    <textarea rows="3" type="text" readonly placeholder="请选择" id="DEPT_ID" name="DEPT_ID" onclick="selectDept($(this))" autocomplete="off" class="layui-textarea bian"></textarea>' +
                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break;
                    case 'S06':
                        str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                            '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                            '                   <p style="font-size: 14px;margin-bottom: 8px;">流水号</p>\n' +
                            '                   <div class="layui-input-inline" style="width:100%">\n' +
                            '                    <input type="text" readonly placeholder="" id="DATA_ID" name="DATA_ID" autocomplete="off" class="layui-input bian"></input>' +
                            '                   </div>\n' +
                            '               </div>\n' +
                            '           </div>'
                        break;
                    case 'L03':
                        str += '<div class="layui-form-item  input-enter input-active childTable" style="position: relative; left: 0px;padding-top: 15px;overflow-x: auto;" data-flag="" data-type="' + item.colType + '" data-id="COL' + item.colId + '">\n' +
                            '       <div style="margin-left: 10px;position:relative;z-index:0;">' +
                            '            <div>' + item.colName + '</div>' +
                            '            <hr style="background: #e6e6e6;width: 99%;"/>' +
                            '            <button id="col-addnew" class="col-addnew layui-btn layui-btn" type="button">新增</button>\n' +
                            '            <button id="col-delete" class="col-delete layui-btn layui-btn layui-btn-danger" type="button">删除</button>\n' +
                            '        </div>' +
                            '       <div id="table-cols" class="table-col">' +
                            '<table class="layui-hide" id="COL'+item.colId+'"></table>' +
                            // '           <div id="colCheckBox" class="table-col-item table-col-preset">' +
                            // '               <div class="table-title default-checkbox"><input id="allInputUpdate" lay-filter="allInputUpdate" type="checkbox" name="layColCheck" lay-skin="primary" ></div>' +
                            // '               <div class="table-content default-checkbox"><input type="checkbox" name="layColCheck" lay-skin="primary" class="checkInfoInSlot" name="checkInfoInSlot" lay-filter ="inputCheckOne"></div>' +
                            // '           </div>' +
                            // '           <div id="" class="table-col-item table-col-preset orderCol" style="margin-left: -5px">' +
                            // '               <div class="table-title">序号</div>' +
                            // '               <div class="table-content">1</div>' +
                            // '           </div>' +
                            // createTableItem(item) +
                            '       </div>' +
                            '   </div>'
                        break;
                }
            }else{
                if(Number(item.vm) == 100){
                    var vm = 'calc(100% - 20px)';
                }else{
                    var n = 20*Number(item.vm)/100 + 10;
                    var vm = 'calc('+Number(item.vm)+'% - '+n+'px)';
                }
                str +='           <div class="layui-form-item" style="width: '+vm+';margin-left: 10px;display: inline-block">\n' +
                    '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '               </div>\n' +
                    '           </div>'
            }

        });
        if(itemOne.colStyle == '1'){
            allstr = '<div class="layui-collapse" lay-accordion><div class="layui-colla-item">\n' +
                '    <h2 class="layui-colla-title" style="font-size: 16px;font-weight: 700;text-align: left!important;padding: 0 40px;!important">'+itemOne.colName+'</h2>\n' +
                '    <div class="layui-colla-content layui-show">'+str+'</div>\n' +
                '  </div></div>'
        }else if(itemOne.colStyle == '2'){
            allstr = '<div class="layui-collapse" lay-accordion><div class="layui-colla-item">\n' +
                '    <h2 class="layui-colla-title" style="font-size: 16px;font-weight: 700;text-align: center!important;padding: 0 40px;!important">'+itemOne.colName+'</h2>\n' +
                '    <div class="layui-colla-content layui-show">'+str+'</div>\n' +
                '  </div></div>'
        }else if(itemOne.colStyle == '3'){
            allstr = '<div class="layui-collapse" lay-accordion><div class="layui-colla-item">\n' +
                '    <h2 class="layui-colla-title" style="font-size: 16px;font-weight: 700;text-align: right!important;padding: 0 40px;!important">'+itemOne.colName+'</h2>\n' +
                '    <div class="layui-colla-content layui-show">'+str+'</div>\n' +
                '  </div></div>'
        }
    }
    return allstr
}

// 创建表单子表模板
function createTableItem(tableObj){
    layui.use(['form', 'table', 'element', 'laydate', 'xmSelect', 'layedit', 'eleTree', 'upload'], function () {
        var table = layui.table
        var tabId = '#COL' + tableObj.colId;
        var tableObjcolStyle = JSON.parse(tableObj.colStyle);
        var column = [[
            {
                type: 'checkbox',
                // hide: res.object.glist.batchOperate == '1' ? false : true
            },
            {type: 'numbers', title: '序号', width: 60},
            {
                field: 'TITLES',
                title: '数据标题',
                event: 'TITLES',
                templet: function (d) {
                    //渲染数据标题
                    let dArr = Object.keys(d)
                    if (d.TITLES === undefined) {
                        // var titlesArr = []
                        // $.ajax({
                        //     url: '/gtable/selectByTabId',
                        //     type: 'get',
                        //     async: false,
                        //     data: {
                        //         gappId: obj.object.gappId
                        //     },
                        //     dataType: 'json',
                        //     success: function (res) {
                        //         console.log('res', res)
                        //         let dataTitles = res.obj
                        //         dataTitles.forEach(function (value, index) {
                        //             var newColId = ''
                        //             if (value.colId === 'OWNER_USER_ID') {
                        //                 newColId = 'OWNER_USER_NAME'
                        //             } else if (value.colId === 'CREATE_USER_ID') {
                        //                 newColId = 'CREATE_USER'
                        //             } else if (value.colId === 'UPDATE_TIME' || value.colId === 'DATA_ID') {
                        //                 newColId = value.colId
                        //             } else {
                        //                 newColId = 'COL' + value.colId
                        //             }
                        //             dArr.forEach(function (item, idx) {
                        //                 if (newColId === item) {
                        //                     if (d.UPDATE_TIME === 'undefined') {
                        //                         return
                        //                     } else {
                        //                         d.UPDATE_TIME = String(d.UPDATE_TIME);
                        //                         if (d.UPDATE_TIME.indexOf(':') === -1) {
                        //                             d.UPDATE_TIME = parseInt(d.UPDATE_TIME)
                        //                             d.UPDATE_TIME = new Date(d.UPDATE_TIME).Format("yyyy-MM-dd hh:mm:ss");
                        //                         }
                        //                     }
                        //                     titlesArr.push(d[newColId])//
                        //                 }
                        //             })
                        //         })
                        //     }
                        // })
                        // return d.TITLES = titlesArr.join(' ');
                    }
                }
            }
        ]];
        for(var i=0; i<tableObjcolStyle.length; i++) {
            var obj = {};
            obj.title = tableObjcolStyle[i].colName
            obj.field = tableObjcolStyle[i].colId
            column[0].push(obj);
        }
        layui.table.render({
            elem:tabId
            , page: false
            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                , layEvent: 'LAYTABLE_TIPS'
                , icon: 'layui-icon-tips'
            }]
            , title: '用户数据表'
            ,data:[]
            , cols: column
            , done: function (res) {
                if (res.data.length > 0) {
                    $('.layui-table-header').eq(0).css('overflow', 'hidden');
                } else {
                    $('.layui-table-header').eq(0).css('overflow', 'auto');
                }
            }
            , limit: 10000
        })
    })
    var str = ''
    var tableObjcolStyle = JSON.parse(tableObj.colStyle);
    for(var i=0;i<tableObjcolStyle.length;i++){
        switch (tableObjcolStyle[i].colType){
            case 'C01':
                str += '<div class="table-col-item  layui-form-item'  + '" data-table="true" data-flag="' + tableObjcolStyle[i].colId + '" data-type="' + tableObjcolStyle[i].colType + '">' +
                    '   <div class="table-title">' + tableObjcolStyle[i].colName + '</div>' +
                    '   <div class="table-content"><input type="text" lay-verify="title" autocomplete="off" placeholder="请输入" class="layui-input" id="COL'+ tableObjcolStyle[i].colId+'" name="COL'+ tableObjcolStyle[i].colId+'"></div>' +
                    '</div>'
                break;

            case 'C02':
                str += '<div class="table-col-item  layui-form-item' + '" data-table="true" data-flag="' + tableObjcolStyle[i].colId + '" data-type="' + tableObjcolStyle[i].colType + '">' +
                    '<div class="table-title">' + tableObjcolStyle[i].colName + '</div>' +
                    '<div class="table-content"><textarea placeholder="请输入"  class="layui-textarea" style="resize: none!important;height:100%!important;min-height: 0px!important;" rows="'+tableObjcolStyle[i].colStyle+'" colKtype="'+ tableObjcolStyle[i].colKtype+'" value="'+tableObjcolStyle[i].defaultVal+'" placeholder="'+ isHasTips(tableObjcolStyle[i].inputTips)+'" id="COL'+ tableObjcolStyle[i].colId+'" name="COL'+ tableObjcolStyle[i].colId+'"></textarea></div>' +
                    '</div>'
                break;

            case 'C03':
                str += '<div class="table-col-item  layui-form-item' + '" data-table="true" data-flag="' + tableObjcolStyle[i].colId + '" data-type="' + tableObjcolStyle[i].colType + '">' +
                    '<div class="table-title">' + tableObjcolStyle[i].colName + '</div>' +
                    '<div class="table-content dateTm"><input type="text" lay-verify="title" readonly   autocomplete="off" placeholder="请选择" colKtype="'+tableObjcolStyle[i].colKtype+'" colStyle="'+tableObjcolStyle[i].colStyle+'" class="layui-input" id="COL'+ tableObjcolStyle[i].colId+'" name="COL'+ tableObjcolStyle[i].colId+'"/></div>' +
                    '</div>'
                break;

            case 'C04':
                str += '<div class="table-col-item  layui-form-item'+ '" data-table="true" data-flag="' + tableObjcolStyle[i].colId + '" data-type="' + tableObjcolStyle[i].colType + '">' +
                    '<div class="table-title">' + tableObjcolStyle[i].colName + '</div>' +
                    '<div class="table-content"><input type="text" lay-verify="title" autocomplete="off" placeholder="请输入" class="layui-input" id="COL'+ tableObjcolStyle[i].colId+'" name="COL'+ tableObjcolStyle[i].colId+'"/></div>' +          '</div>'
                break

            case 'C05':
                var itemObj = JSON.parse(tableObjcolStyle[i].colStyle);
                var radioStr = '';
                for(var j=0;j<itemObj.selectOption.length;j++){
                    if(itemObj.selectOption[j] == itemObj.selectedOption[0]){
                        radioStr += '<input type="radio" colKtype="'+ tableObjcolStyle[i].colKtype+'" title="'+itemObj.selectOption[j]+'" checked="" name="COL'+tableObjcolStyle[i].colId+'" autocomplete="off" class="layui-input bian">'
                    }else{
                        radioStr += '<input type="radio" colKtype="'+ tableObjcolStyle[i].colKtype+'" title="'+itemObj.selectOption[j]+'"  name="COL'+tableObjcolStyle[i].colId+'" autocomplete="off" class="layui-input bian">'
                    }
                }
                str += '<div class="table-col-item  layui-form-item' + '" data-table="true" data-flag="' + tableObjcolStyle[i].colId + '" data-type="' + tableObjcolStyle[i].colType + '">' +
                    '<div class="table-title">' + tableObjcolStyle[i].colName + '</div>' +
                    '<div class="table-content radioItem">' +
                    '<div class="layui-input-inline" name="COL'+tableObjcolStyle[i].colId+'" style="width:100%">' +
                                               radioStr+
                    '</div>' +
                    '</div>' +         '</div>'
                break;
            case 'C06':
                var itemObj = JSON.parse(tableObjcolStyle[i].colStyle);
                var cheStr = '';
                for(var j=0;j<itemObj.selectOption.length;j++){
                    cheStr += '<input type="checkbox" name="COL'+tableObjcolStyle[i].colId+'" lay-skin="primary" title="'+itemObj.selectOption[j]+'">'
                }
                str += '<div class="table-col-item  layui-form-item' + '" data-table="true" data-flag="' + tableObjcolStyle[i].colId + '" data-type="' + tableObjcolStyle[i].colType + '">' +
                    '<div class="table-title">' + tableObjcolStyle[i].colName + '</div>' +
                    '<div class="table-content">' +
                    '<div class="layui-input-inline" name="COL'+tableObjcolStyle[i].colId+'" style="width:100%">' +
                    cheStr+
                        '</div>' +
                    '</div>' +'</div>'
                break;

            case 'C07':
                var itemObj = JSON.parse(tableObjcolStyle[i].colStyle);
                var selectStr = '<option></option>';
                for(var j=0;j<itemObj.selectOption.length;j++){
                    if(itemObj.selectOption[j] == itemObj.selectedOption[0]){
                        selectStr += '<option selected="selected" value="'+itemObj.selectOption[j]+'">'+itemObj.selectOption[j]+'</option>'
                    }else{
                        selectStr += '<option value="'+itemObj.selectOption[j]+'">'+itemObj.selectOption[j]+'</option>'
                    }
                }
                str += '<div class="table-col-item  layui-form-item'+ '" data-table="true" data-flag="' + tableObjcolStyle[i].colId + '" data-type="' + tableObjcolStyle[i].colType + '">' +
                    '<div class="table-title">' + tableObjcolStyle[i].colName + '</div>' +
                    '<div class="table-content"><select name="COL'+tableObjcolStyle[i].colId+'">'+selectStr+'</select></div>' +           '</div>'
                break;

            case 'C08':
                str += '<div class="table-col-item  layui-form-item' + '" data-table="true" data-flag="' + tableObjcolStyle[i].colId + '" data-type="' + tableObjcolStyle[i].colType + '">' +
                    '<div class="table-title">' + tableObjcolStyle[i].colName + '</div>' +
                    '<div class="table-content fileItem">' +
                    '           <div class="" style="width:100%;height: 100%;margin: 0;border: none;display: inline-block">\n' +
                    '               <div class="layui-inline" style="width:100%;height: 100%;">\n' +
                    '                  <div class="layui-input-block" style="margin: 0">\n' +
                    '                    <div id="COL'+tableObjcolStyle[i].colId+'" class="files">' +
                    '                        <input id="COL'+tableObjcolStyle[i].colId+'_idc" type="hidden" name="attachmentId">' +
                    '                        <input id="COL'+tableObjcolStyle[i].colId+'_namec" type="hidden" name="attachmentName"></div>' +
                    '                    <div id="COL'+tableObjcolStyle[i].colId+'b" class="fileBoxs" style="float: left;max-width:700px;overflow:hidden;text-overflow:ellipsis;white-space: nowrap;">\n' +
                    '                    </div>\n' +
                    '                    <a href="javascript:;" class="openFile" style="margin-left:10px;float: left;position:relative">\n' +
                    '                        <img src="../img/mg11.png" alt="">\n' +
                    '                        <span>添加附件</span>\n' +
                    '                        <input type="file" style="height: 100%;" class="upfiles" name="file" id="COL'+tableObjcolStyle[i].colId+'c0" data-url="/upload?module=gapp">\n' +
                    '                    </a>\n' +
                    '                   </div>' +
                    '               </div>\n'+
                    '</div>'+
                    '</div>' +'</div>'
                break;

            case 'C09':
                str += '<div class="table-col-item  layui-form-item'+ '" data-table="true" data-flag="' + tableObjcolStyle[i].colId + '" data-type="' + tableObjcolStyle[i].colType + '">' +
                    '<div class="table-title">' + tableObjcolStyle[i].colName + '</div>' +
                    '<div class="table-content picItem">' +
                    '           <div class="" style="width:100%;height: 100%;margin: 0;border: none;display: inline-block">\n' +
                    '               <div class="layui-inline" style="width:100%;height: 100%;">\n' +
                    '                  <div class="layui-input-block" style="margin: 0">\n' +
                    '                    <div id="COL'+tableObjcolStyle[i].colId+'" class="pics">' +
                    '                        <input id="COL'+tableObjcolStyle[i].colId+'_idc" type="hidden" name="attachmentId">' +
                    '                        <input id="COL'+tableObjcolStyle[i].colId+'_namec" type="hidden" name="attachmentName"></div>' +
                    '                    <div id="COL'+tableObjcolStyle[i].colId+'b" class="picBoxs"  style="float: left;max-width:700px;overflow:hidden;text-overflow:ellipsis;white-space: nowrap;">\n' +
                    '                    </div>\n' +
                    '                    <a href="javascript:;" class="openFile" style="margin-left:10px;float: left;position:relative">\n' +
                    '                        <img src="../img/mg11.png" alt="">\n' +
                    '                        <span>添加图片</span>\n' +
                    '                        <input type="file" name="file" style="height: 100%;" class="uppics" id="COL'+tableObjcolStyle[i].colId+'c0" data-url="/upload?module=gapp">\n' +
                    '                    </a>\n' +
                    '                   </div>' +
                    '               </div>\n'+
                    '</div>' +
                    '</div>' +'</div>'
                break;

            case 'C16':
                str += '<div class="table-col-item  layui-form-item' + '" data-table="true" data-flag="' + tableObjcolStyle[i].colId + '" data-type="' + tableObjcolStyle[i].colType + '">' +
                    '<div class="table-title">' + tableObjcolStyle[i].colName + '</div>' +
                    '<div class="table-content"><input type="checkbox" value="0" name="COL'+ tableObjcolStyle[i].colId +'" lay-skin="switch" lay-text="是|否"></div>' + '</div>'
                break;

        }

    }
    //是否有多行文本
    setTimeout(function(){
        var hasTextArea = false
        for(var i=0;i<tableObjcolStyle.length;i++){
            if(tableObjcolStyle[i].colType === 'C02'){
                hasTextArea = true
                break
            }else{
                hasTextArea = false
            }
            if(hasTextArea){
                $('div[data-flag="'+ tableObjcolStyle[i].colId +'"]').parent().addClass('has-textarea')
            }else{
                $('div[data-flag="'+ tableObjcolStyle[i].colId +'"]').parent().removeClass('has-textarea')
            }
        }
    },0)
    // return str
}


//表单子表新增数据
var lineArr = [];
$(document).on('click','.col-addnew',function () {
    var tableid = $(this).parents('.childTable').find('table').attr('id');
    var arrs = moreData($(this).parents('.childTable').find('table').next().find('.layui-table-body'));
    var a = layui.table.cache[tableid];
    for(var j=0; j<arrs.length; j++) {
        arrs[j]['TITLES'] = a[j].TITLES;
        (function (j){
            for(var item in arrs[j]) {
                if(item.indexOf('_NAME') > -1) {
                    var obs = [];
                    var id = item.split('_NAME')[0];
                    for(var x=0; x<$('div[name="'+id+'"]').eq(j).next().find('.itemVal').length; x++) {
                        var st = $('div[name="'+id+'"]').eq(j).next().find('.itemVal').eq(x).attr('value');
                        obs.push(JSON.parse(st))
                    }
                    arrs[j][item.split('_NAME')[0]+'_ATTACHMENTLIST'] = obs
                }
            }
        })(j)

    }
    var obj = JSON.parse(JSON.stringify(arrs[0]));
    for(var item in obj) {
        obj[item] = ''
    }
    arrs.push(obj);
    for(var i=0; i<arrs.length;i++) {
        (function (i){
            arrs[i].LAY_TABLE_INDEX = i;
            arrs[i].sort = i;
        })(i)
    }
    layui.table.reload(tableid,{
        data:arrs
    })
})
//表单子表删除数据
$(document).on('click','.col-delete',function () {
    var tableid = $(this).parents('.childTable').find('table').attr('id');
    var b = layui.table.checkStatus(tableid).data;
    var arrs = moreData($(this).parents('.childTable').find('table').next().find('.layui-table-body'));
    var a = layui.table.cache[tableid];
    for(var j=0; j<arrs.length; j++) {
        arrs[j]['TITLES'] = a[j].TITLES;
        (function (j){
            for(var item in arrs[j]) {
                if(item.indexOf('_NAME') > -1) {
                    var obs = [];
                    var id = item.split('_NAME')[0];
                    for(var x=0; x<$('div[name="'+id+'"]').eq(j).next().find('.itemVal').length; x++) {
                        var st = $('div[name="'+id+'"]').eq(j).next().find('.itemVal').eq(x).attr('value');
                        obs.push(JSON.parse(st))
                    }
                    arrs[j][item.split('_NAME')[0]+'_ATTACHMENTLIST'] = obs
                }
            }
        })(j)
        arrs[j].LAY_TABLE_INDEX = j;
        arrs[j].sort = j;
    }
    if(b.length == 0){
        layui.layer.msg('请勾选要删除的数据',{icon:5})
    }else{
        var data = array_diff(arrs,b);
        for(var i=0; i<data.length;i++) {
            (function (i){
                data[i].LAY_TABLE_INDEX = i;
                data[i].sort = i;
            })(i)
        }
        layui.table.reload(tableid,{
            data:data
        })
    }
});
function array_diff(a, b) {
    for (var i = 0; i < b.length; i++) {
        for (var j = 0; j < a.length; j++) {
            if (a[j].sort == b[i].sort) {
                a.splice(j, 1);
                j = j - 1;
            }
        }
    }
    return a;
}
// 查询条件
function gcolumn_field_search(data,selColIds){
    var str = ''
    for(var i=0;i<data.length;i++){
        if(data[i].colType == 'C01'){
            str +='<li style="width: 33%">\n' +
                '                <div class="layui-form-item" >\n' +
                '                    <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                '                        <label class="layui-form-label" style="font-size: 14px;width: 30%">'+data[i].colName+'</label>\n' +
                '                        <div class="layui-input-inline" style="width:56%">\n' +
                '<input type="text" colKtype="'+data[i].colKtype+'" placeholder="请输入" id="COL'+data[i].colId+'_CH" name="COL'+data[i].colId+'_CH" onblur="serchFun($(this))" autocomplete="off" class="layui-input bian">'+
                '                        </div>\n' +
                '                    </div>\n' +
                '                </div> \n' +
                '            </li>'
        }else if(data[i].colType == 'C02'){
            str +='<li style="width: 33%">\n' +
                '                <div class="layui-form-item" >\n' +
                '                    <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                '                        <label class="layui-form-label" style="font-size: 14px;width: 30%">'+data[i].colName+'</label>\n' +
                '                        <div class="layui-input-inline" style="width:56%">\n' +
                '<input type="text" colKtype="'+data[i].colKtype+'" placeholder="请输入" id="COL'+data[i].colId+'_CH" name="COL'+data[i].colId+'_CH" onblur="serchFun($(this))" autocomplete="off" class="layui-input bian">'+
                '                        </div>\n' +
                '                    </div>\n' +
                '                </div> \n' +
                '            </li>'
        }else if(data[i].colType == 'C03'){
            str +='<li style="width: 33%">\n' +
                '                <div class="layui-form-item" >\n' +
                '                    <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                '                        <label class="layui-form-label" style="font-size: 14px;width: 30%">'+data[i].colName+'</label>\n' +
                '                        <div class="layui-input-inline" style="width:56%">\n' +
                '<input type="text" readonly colKtype="'+data[i].colKtype+'" placeholder="请输入" id="COL'+data[i].colId+'_CH" name="COL'+data[i].colId+'_CH" autocomplete="off" class="layui-input bian">'+
                '                        </div>\n' +
                '                    </div>\n' +
                '                </div> \n' +
                '            </li>'
        }else if(data[i].colType == 'C04'){
            str +='<li style="width: 33%">\n' +
                '                <div class="layui-form-item" >\n' +
                '                    <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                '                        <label class="layui-form-label" style="font-size: 14px;width: 30%">'+data[i].colName+'</label>\n' +
                '                        <div class="layui-input-inline" style="width:56%">\n' +
                '<input type="text" colKtype="'+data[i].colKtype+'" placeholder="请输入" id="COL'+data[i].colId+'_CH" name="COL'+data[i].colId+'_CH" onblur="serchFun($(this))" autocomplete="off" class="layui-input bian">'+
                '                        </div>\n' +
                '                    </div>\n' +
                '                </div> \n' +
                '            </li>'
        }else if(data[i].colType == 'C05'){
            var itemObj = JSON.parse(data[i].colStyle);
            var radioStr = '';
            for(var j=0;j<itemObj.selectOption.length;j++){
                if(j == 0){
                    radioStr += '<input type="radio" title="'+itemObj.selectOption[j]+'" checked="" name="COL'+data[i].colId+'_CH" autocomplete="off" class="layui-input bian">'
                }else{
                    radioStr += '<input type="radio" title="'+itemObj.selectOption[j]+'"  name="COL'+data[i].colId+'_CH" autocomplete="off" class="layui-input bian">'
                }
            }
            str +='<li style="width: 33%">\n' +
                '                <div class="layui-form-item" >\n' +
                '                    <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                '                        <label class="layui-form-label" style="font-size: 14px;width: 30%">'+data[i].colName+'</label>\n' +
                '                        <div class="layui-input-inline" style="width:56%">\n' +
                '<div id="COL'+data[i].colId+'_CH" colStyle="'+data[i].colStyle+'" class=""></div>'+
                '                        </div>\n' +
                '                    </div>\n' +
                '                </div> \n' +
                '            </li>'
        }else if(data[i].colType == 'C06'){
            str +='<li style="width: 33%">\n' +
                '                <div class="layui-form-item" >\n' +
                '                    <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                '                        <label class="layui-form-label" style="font-size: 14px;width: 30%">'+data[i].colName+'</label>\n' +
                '                        <div class="layui-input-inline" style="width:56%">\n' +
                '<div id="COL'+data[i].colId+'_CH" colStyle="'+data[i].colStyle+'" class=""></div>'+
                '                        </div>\n' +
                '                    </div>\n' +
                '                </div> \n' +
                '            </li>'

        }else if(data[i].colType == 'C07'){
            var itemObj = JSON.parse(data[i].colStyle);
            var selectStr = '<option></option>';
            for(var j=0;j<itemObj.selectOption.length;j++){
                selectStr += '<option value="'+itemObj.selectOption[j]+'">'+itemObj.selectOption[j]+'</option>'
                // if(itemObj.selectOption[j] == itemObj.selectedOption[0]){
                //     selectStr += '<option value="'+itemObj.selectOption[j]+'" selected="" >'+itemObj.selectOption[j]+'<option>'
                // }else{
                //     selectStr += '<option value="'+itemObj.selectOption[j]+'">'+itemObj.selectOption[j]+'<option>'
                // }
            }
            str +='<li style="width: 33%">\n' +
                '                <div class="layui-form-item" >\n' +
                '                    <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                '                        <label class="layui-form-label" style="font-size: 14px;width: 30%">'+data[i].colName+'</label>\n' +
                '                        <div class="layui-input-inline" style="width:56%">\n' +
                '<select lay-filter="COL'+data[i].colId+'_CH" name="COL'+data[i].colId+'_CH">' +
                selectStr+
                '</select>'+
                '                        </div>\n' +
                '                    </div>\n' +
                '                </div> \n' +
                '            </li>'
        }else if(data[i].colType == 'C15'){
            str +='<li style="width: 33%">\n' +
                '                <div class="layui-form-item" >\n' +
                '                    <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                '                        <label class="layui-form-label" style="font-size: 14px;width: 30%">'+data[i].colName+'</label>\n' +
                '                        <div class="layui-input-inline" style="width:56%">\n' +
                // '<input type="radio" lay-filter="COL'+data[i].colId+'_CH" name="COL'+data[i].colId+'_CH" value="1" title="开" checked="">'+
                // '<input type="radio" lay-filter="COL'+data[i].colId+'_CH" name="COL'+data[i].colId+'_CH" value="0" title="关">' +
                '<input type="text" colKtype="'+data[i].colKtype+'" placeholder="请输入" id="COL'+data[i].colId+'_CH" name="COL'+data[i].colId+'_CH" onblur="serchFun($(this))" autocomplete="off" class="layui-input bian">'+
                '                        </div>\n' +
                '                    </div>\n' +
                '                </div> \n' +
                '            </li>'
        }else if(data[i].colType == 'C16'){
            str +='<li style="width: 33%">\n' +
                '                <div class="layui-form-item" >\n' +
                '                    <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                '                        <label class="layui-form-label" style="font-size: 14px;width: 30%">'+data[i].colName+'</label>\n' +
                '                        <div class="layui-input-inline" style="width:56%">\n' +
                // '<input type="radio" lay-filter="COL'+data[i].colId+'_CH" name="COL'+data[i].colId+'_CH" value="1" title="开" checked="">'+
                // '<input type="radio" lay-filter="COL'+data[i].colId+'_CH" name="COL'+data[i].colId+'_CH" value="0" title="关">' +
                '<input type="text" colKtype="'+data[i].colKtype+'" placeholder="请输入" id="COL'+data[i].colId+'_CH" name="COL'+data[i].colId+'_CH" onblur="serchFun($(this))" autocomplete="off" class="layui-input bian">'+
                '                        </div>\n' +
                '                    </div>\n' +
                '                </div> \n' +
                '            </li>'
        }else if(data[i].colId == 'CREATE_USER_ID'){
            str +='<li style="width: 33%">\n' +
                '                <div class="layui-form-item" >\n' +
                '                    <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                '                        <label class="layui-form-label" style="font-size: 14px;width: 30%">' + data[i].colName + '</label>\n' +
                '                        <div class="layui-input-inline" style="width:56%">\n' +
                '                    <input type="text" onblur="serchFun($(this))"  placeholder="" id="CREATE_USER_ID_CH" name="CREATE_USER_ID_CH" autocomplete="off" class="layui-input bian"></input>' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                </div> \n' +
                '            </li>'
        }else if(data[i].colId == 'CREATE_TIME'){
            str +='<li style="width: 33%">\n' +
                '                <div class="layui-form-item" >\n' +
                '                    <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                '                        <label class="layui-form-label" style="font-size: 14px;width: 30%">' + data[i].colName + '</label>\n' +
                '                        <div class="layui-input-inline" style="width:56%">\n' +
                '                        <input type="text" class="layui-input" id="CREATE_TIME_CH" name="CREATE_TIME_CH">' +
                // '                    <input type="text" onblur="serchFun($(this))" placeholder="" id="CREATE_TIME_CH" name="CREATE_TIME_CH" autocomplete="off" class="layui-input bian"></input>' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                </div> \n' +
                '            </li>'
        }else if(data[i].colId == 'UPDATE_TIME'){
            str +='<li style="width: 33%">\n' +
                '                <div class="layui-form-item" >\n' +
                '                    <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                '                        <label class="layui-form-label" style="font-size: 14px;width: 30%">' + data[i].colName + '</label>\n' +
                '                        <div class="layui-input-inline" style="width:56%">\n' +
                '                        <input type="text" class="layui-input" id="UPDATE_TIME_CH" name="UPDATE_TIME_CH">' +
                // '                    <input type="text" onblur="serchFun($(this))" id="UPDATE_TIME_CH" name="UPDATE_TIME_CH" autocomplete="off" class="layui-input bian"></input>' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                </div> \n' +
                '            </li>'
        }else if(data[i].colId == 'OWNER_USER_ID'){
            str +='<li style="width: 33%">\n' +
                '                <div class="layui-form-item" >\n' +
                '                    <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                '                        <label class="layui-form-label" style="font-size: 14px;width: 30%">' + data[i].colName + '</label>\n' +
                '                        <div class="layui-input-inline" style="width:56%">\n' +
                '                    <input type="text" onblur="serchFun($(this))" id="OWNER_USER_ID_CH" name="OWNER_USER_ID_CH" autocomplete="off" class="layui-input bian"></input>' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                </div> \n' +
                '            </li>'
        }else if(data[i].colId == 'DEPT_ID'){
            str +='<li style="width: 33%">\n' +
                '                <div class="layui-form-item" >\n' +
                '                    <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                '                        <label class="layui-form-label" style="font-size: 14px;width: 30%">' + data[i].colName + '</label>\n' +
                '                        <div class="layui-input-inline" style="width:56%">\n' +
                '                    <input type="text" onblur="serchFun($(this))" id="DEPT_IDCH_CH" name="DEPT_ID_CH" autocomplete="off" class="layui-input bian"></input>' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                </div> \n' +
                '            </li>'
        }else if(data[i].colId == 'DATA_ID'){
            str +='<li style="width: 33%">\n' +
                '                <div class="layui-form-item" >\n' +
                '                    <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                '                        <label class="layui-form-label" style="font-size: 14px;width: 30%">' + data[i].colName + '</label>\n' +
                '                        <div class="layui-input-inline" style="width:56%">\n' +
                '                    <input type="text" onblur="serchFun($(this))" placeholder="请选择" id="RUN_ID_CH" name="RUN_ID_CH" autocomplete="off" class="layui-input bian"></input>' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                </div> \n' +
                '            </li>'
        }
    }
    // if(selColIds.indexOf('s012e5b167d991444c5883d7af2530285de') > -1){
    //     str +='<li style="width: 33%">\n' +
    //         '                <div class="layui-form-item" >\n' +
    //         '                    <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
    //         '                        <label class="layui-form-label" style="font-size: 14px;width: 30%">创建人</label>\n' +
    //         '                        <div class="layui-input-inline" style="width:56%">\n' +
    //         '                    <input type="text" onblur="serchFun($(this))"  placeholder="" id="CREATE_USER_ID_CH" name="CREATE_USER_ID_CH" autocomplete="off" class="layui-input bian"></input>' +
    //         '                        </div>\n' +
    //         '                    </div>\n' +
    //         '                </div> \n' +
    //         '            </li>'
    // }
    // if(selColIds.indexOf('s022e5b167d991444c5883d7af2530285de') > -1){
    //     str +='<li style="width: 33%">\n' +
    //         '                <div class="layui-form-item" >\n' +
    //         '                    <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
    //         '                        <label class="layui-form-label" style="font-size: 14px;width: 30%">创建时间</label>\n' +
    //         '                        <div class="layui-input-inline" style="width:56%">\n' +
    //         '                    <input type="text" onblur="serchFun($(this))" placeholder="" id="CREATE_TIME_CH" name="CREATE_TIME_CH" autocomplete="off" class="layui-input bian"></input>' +
    //         '                        </div>\n' +
    //         '                    </div>\n' +
    //         '                </div> \n' +
    //         '            </li>'
    // }
    // if(selColIds.indexOf('s052e5b167d991444c5883d7af2530285de') > -1){
    //     str +='<li style="width: 33%">\n' +
    //         '                <div class="layui-form-item" >\n' +
    //         '                    <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
    //         '                        <label class="layui-form-label" style="font-size: 14px;width: 30%">所属部门</label>\n' +
    //         '                        <div class="layui-input-inline" style="width:56%">\n' +
    //         '                    <input type="text" onblur="serchFun($(this))" placeholder="请选择" id="DEPT_IDCH_CH" name="DEPT_ID_CH" autocomplete="off" class="layui-input bian"></input>' +
    //         '                        </div>\n' +
    //         '                    </div>\n' +
    //         '                </div> \n' +
    //         '            </li>'
    // }
    // if(selColIds.indexOf('s042e5b167d991444c5883d7af2530285de') > -1){
    //     str +='<li style="width: 33%">\n' +
    //         '                <div class="layui-form-item" >\n' +
    //         '                    <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
    //         '                        <label class="layui-form-label" style="font-size: 14px;width: 30%">拥有者</label>\n' +
    //         '                        <div class="layui-input-inline" style="width:56%">\n' +
    //         '                    <input type="text" onblur="serchFun($(this))" placeholder="请选择" id="OWNER_USER_ID_CH" name="OWNER_USER_ID_CH" autocomplete="off" class="layui-input bian"></input>' +
    //         '                        </div>\n' +
    //         '                    </div>\n' +
    //         '                </div> \n' +
    //         '            </li>'
    // }
    // if(selColIds.indexOf('s032e5b167d991444c5883d7af2530285de') > -1){
    //     str +='<li style="width: 33%">\n' +
    //         '                <div class="layui-form-item" >\n' +
    //         '                    <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
    //         '                        <label class="layui-form-label" style="font-size: 14px;width: 30%">修改时间</label>\n' +
    //         '                        <div class="layui-input-inline" style="width:56%">\n' +
    //         '                    <input type="text" onblur="serchFun($(this))" placeholder="请选择" id="UPDATE_TIME_CH" name="UPDATE_TIME_CH" autocomplete="off" class="layui-input bian"></input>' +
    //         '                        </div>\n' +
    //         '                    </div>\n' +
    //         '                </div> \n' +
    //         '            </li>'
    // }
    // if(selColIds.indexOf('s062e5b167d991444c5883d7af2530285de') > -1){
    //     str +='<li style="width: 33%">\n' +
    //         '                <div class="layui-form-item" >\n' +
    //         '                    <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
    //         '                        <label class="layui-form-label" style="font-size: 14px;width: 30%">流水号</label>\n' +
    //         '                        <div class="layui-input-inline" style="width:56%">\n' +
    //         '                    <input type="text" onblur="serchFun($(this))" placeholder="请选择" id="RUN_ID_CH" name="RUN_ID_CH" autocomplete="off" class="layui-input bian"></input>' +
    //         '                        </div>\n' +
    //         '                    </div>\n' +
    //         '                </div> \n' +
    //         '            </li>'
    // }
    return str;
}
// 返回查询条件下复选框和单选框
function returnSf(data){
    for(var i=0;i<data.length;i++){
        (function (i) {
            if(data[i].colType == 'C05' || data[i].colType == 'C06'){
                var ids = 'COL'+data[i].colId;
                var itemObj = JSON.parse(data[i].colStyle);
                var selectArr = [];
                for(var j=0;j<itemObj.selectOption.length;j++){
                    var obj = {};
                    obj.name = itemObj.selectOption[j];
                    obj.value = itemObj.selectOption[j] + j;
                    selectArr.push(obj)
                }
                layui.xmSelect.render({
                    el: "#COL"+data[i].colId + '_CH',
                    toolbar:{
                        show: true,
                    },
                    filterable: true,
                    height: '500px',
                    data: [
                        {name: data[i].colName, children: selectArr}
                    ],
                    on: function(data){
                        var xval = ''
                        for(var x=0;x<data.arr.length;x++){
                            xval += data.arr[x].name + ','
                        }
                        var obj1 = returnSerData();
                        obj1[ids] = xval
                        serchAjax(obj1)
                    }
                })
            }
            if(data[i].colType == 'C03'){
                if(data[i].colKtype == 'C0301'){
                    var ids = 'COL'+data[i].colId;
                    var obj = {}
                    obj.id = '#COL'+data[i].colId+'_CH'
                    obj.type = data[i].colStyle
                    if(data[i].colStyle == 'C030101'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            // ,type: dateArr[i].type
                            ,format: 'yyyy年MM月dd日'
                            ,done: function(value, date, endDate){
                                var obj1 = returnSerData();
                                obj1[ids] = value
                                serchAjax(obj1)
                            }
                        });
                    }else if(data[i].colStyle == 'C030102'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'month'
                            ,format: 'yyyy年MM月'
                            ,done: function(value, date, endDate){
                                var obj1 = returnSerData();
                                obj1[ids] = value
                                serchAjax(obj1)
                            }
                        });
                    }else if(data[i].colStyle == 'C030103'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            // ,type: dateArr[i].type
                            ,format: 'MM月dd日'
                            ,done: function(value, date, endDate){
                                var obj1 = returnSerData();
                                obj1[ids] = value
                                serchAjax(obj1)
                            }
                        });
                    }else if(data[i].colStyle == 'C030104'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            // ,type: dateArr[i].type
                            ,format: 'yyyy-MM-dd'
                            ,done: function(value, date, endDate){
                                var obj1 = returnSerData();
                                obj1[ids] = value
                                serchAjax(obj1)
                            }
                        });
                    }else if(data[i].colStyle == 'C030105'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'month'
                            ,format: 'yyyy-MM'
                            ,done: function(value, date, endDate){
                                var obj1 = returnSerData();
                                obj1[ids] = value
                                serchAjax(obj1)
                            }
                        });
                    }else if(data[i].colStyle == 'C030106'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            // ,type: 'month'
                            ,format: 'MM-dd'
                            ,done: function(value, date, endDate){
                                var obj1 = returnSerData();
                                obj1[ids] = value
                                serchAjax(obj1)
                            }
                        });
                    }else if(data[i].colStyle == 'C030107'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'year'
                            ,format: 'yyyy年'
                            ,done: function(value, date, endDate){
                                var obj1 = returnSerData();
                                obj1[ids] = value
                                serchAjax(obj1)
                            }
                        });
                    }else if(data[i].colStyle == 'C030108'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'month'
                            ,format: 'M月'
                            ,done: function(value, date, endDate){
                                var obj1 = returnSerData();
                                obj1[ids] = value
                                serchAjax(obj1)
                            }
                        });
                    }
                    // type.push(obj)

                }else if(data[i].colKtype == 'C0302'){
                    var ids = 'COL'+data[i].colId;
                    var obj = {}
                    obj.id = '#COL'+data[i].colId+'_CH'
                    obj.type = data[i].colStyle
                    if(data[i].colStyle == 'C030201'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'time'
                            ,format: 'HH时mm分'
                            ,done: function(value, date, endDate){
                                var obj1 = returnSerData();
                                obj1[ids] = value
                                serchAjax(obj1)
                            }
                        });
                    }else if(data[i].colStyle == 'C030202'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'time'
                            ,format: 'HH时mm分ss秒'
                            ,done: function(value, date, endDate){
                                var obj1 = returnSerData();
                                obj1[ids] = value
                                serchAjax(obj1)
                            }
                        });
                    }else if(data[i].colStyle == 'C030203'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'time'
                            ,format: 'HH:mm'
                            ,done: function(value, date, endDate){
                                var obj1 = returnSerData();
                                obj1[ids] = value
                                serchAjax(obj1)
                            }
                        });
                    }else if(data[i].colStyle == 'C030204'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'time'
                            ,format: 'HH:mm:ss'
                            ,done: function(value, date, endDate){
                                var obj1 = returnSerData();
                                obj1[ids] = value
                                serchAjax(obj1)
                            }
                        });
                    }
                    // type.push(obj)
                }else if(data[i].colKtype == 'C0303'){
                    var ids = 'COL'+data[i].colId;
                    var obj = {}
                    obj.id = '#COL'+data[i].colId+'_CH'
                    obj.type = data[i].colStyle
                    if(data[i].colStyle == 'C030301'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'datetime'
                            ,format: 'yyyy年M月d日 H时m分s秒'
                            ,done: function(value, date, endDate){
                                var obj1 = returnSerData();
                                obj1[ids] = value
                                serchAjax(obj1)
                            }
                        });
                    }else if(data[i].colStyle == 'C030302'){
                        layui.laydate.render({
                            elem: obj.id
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'datetime'
                            ,done: function(value, date, endDate){
                                var obj1 = returnSerData();
                                obj1[ids] = value
                                serchAjax(obj1)
                            }
                            // ,format: 'yyyy-M-d H:m:s'
                        });
                    }
                    // type.push(obj)
                }
            }
            if(data[i].colType == 'C04'){
                if(data[i].colKtype == 'C0401'){
                    var num = Number(data[i].colStyle[data[i].colStyle.length-1])
                    $('.formBox #COL'+data[i].colId+'_CH').blur(function(e){
                        if(isNaN(Number($(this).val()))){
                            $(this).val('')
                        }else{
                            $(this).val(Number($(this).val()).toFixed(num))
                        }
                    })
                }else if(data[i].colKtype == 'C0402'){
                    var num = Number(data[i].colStyle[data[i].colStyle.length-1])
                    $('.formBox #COL'+data[i].colId+'_CH').focus(function(e){
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
                    $('.formBox #COL'+data[i].colId+'_CH').focus(function(e){
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
            }
            var $slelen = $('.tops').find('select');
            for(var s=0;s<$slelen.length;s++){
                var fil = $slelen.eq(s).attr('lay-filter');
                layui.form.on('select('+fil+')', function(data){
                    var obj = returnSerData();
                    serchAjax(obj)
                });
            }
            // var $ralen = $('.tops').find('input[type="radio"]');
            // for(var s=0;s<$ralen.length;s++){
            //     var fil = $ralen.eq(s).attr('lay-filter');
            //     layui.form.on('radio('+fil+')', function(data){
            //         var obj = returnSerData();
            //         serchAjax(obj)
            //     });
            // }
        })(i)
    }
}
// 提示tips
function isHasDes(des){
    if(des){
        return ' <i class="layui-icon layui-icon-tips" data-des="' + des +'" onmouseenter="colTipsEnter(this)" onmouseleave="colTipsLeave(this)"></i>'
    }else{
        return ''
    }
}
function isHasTips(tips) {
    if(tips){
        return tips;
    }else{
        return '';
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
function JSONcheckboxData(list,checkedList,data){
    var checkedStr = ''
    list.forEach(function(item,index,arr){
        if (checkedList.indexOf(item) != -1){
            checkedStr += '<input type="checkbox" name="COL'+ data.colId +'" lay-skin="primary" title="' + item + '" checked>'
        }else{
            checkedStr += '<input type="checkbox" name="COL'+ data.colId +'" lay-skin="primary" title="' + item + '">'
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


// 返回控件
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
                    $('.formBox #COL'+data[i].colId).attr('data-length',num)
                    $('.formBox #COL'+data[i].colId).blur(function(e){
                        if(isNaN(Number($(this).val()))){
                            $(this).val('')
                        }else{
                            $(this).val(Number($(this).val()).toFixed(Number($(this).attr('data-length'))))
                        }
                    })
                    $('.formBox #COL'+data[i].colId)[0].oninput = function(e){
                        if(isNaN(e.target.value)){
                            layui.layer.tips('请确认数字格式是否正确？',e.target,{tips:1,time:1000})
                        }
                    }
                }else if(data[i].colKtype == 'C0402'){
                    var num = Number(data[i].colStyle[data[i].colStyle.length-1])
                    $('.formBox #COL'+data[i].colId).attr('data-length',num)
                    $('.formBox #COL'+data[i].colId).focus(function(e){
                        $(this).val(e.currentTarget.value.split(',').join(''))
                    })

                    $('.formBox #COL'+data[i].colId).blur(function(e){
                        if(isNaN(Number($(this).val()))){
                            $(this).val('')
                        }else{
                            $(this).val(numFormat(Number($(this).val()).toFixed(Number($(this).attr('data-length')))))
                        }
                    })
                    $('.formBox #COL'+data[i].colId)[0].oninput = function(e){
                        if(isNaN(e.target.value)){
                            layui.layer.tips('请确认数字格式是否正确？',e.target,{tips:1,time:1000})
                        }
                    }
                }else if(data[i].colKtype == 'C0403'){
                    var num = Number(data[i].colStyle[data[i].colStyle.length-1])
                    $('.formBox #COL'+data[i].colId).attr('data-length',num)
                    $('.formBox #COL'+data[i].colId).focus(function(e){
                        $(this).val(e.currentTarget.value.split('%').join(''))
                    })
                    $('.formBox #COL'+data[i].colId).blur(function(e){
                        if(isNaN(Number($(this).val()))){
                            $(this).val('')
                        }else{
                            $(this).val(Number($(this).val()).toFixed(Number($(this).attr('data-length'))) + '%')
                        }
                    })
                    $('.formBox #COL'+data[i].colId)[0].oninput = function(e){
                        if(isNaN(e.target.value)){
                            layui.layer.tips('请确认数字格式是否正确？',e.target,{tips:1,time:1000})
                        }
                    }
                }
                break;
            // case 'S04':
            //     var id = 'COL'+data[i].colId;
            //     $('.formBox #COL'+data[i].colId).click(function(e){
            //         user_id = id;
            //         $.popWindow("../common/selectUser");
            //     })
            //     break;
            // case 'S05':
            //     var id = 'COL'+data[i].colId;
            //     $('.formBox #COL'+data[i].colId).click(function(e){
            //         dept_id = id;
            //         $.popWindow("/common/selectDept");
            //     })
            //     break;

        }
    }
}
// 返回控件
function childReturnDates(data,ele) {
    for(var i=0;i<data.length;i++){
        switch (data[i].colType) {
            case 'C03':
                if(data[i].colKtype == 'C0301'){
                    var obj = {}
                    obj.id = '#'+ele.eq(i).attr('id')
                    obj.type = data[i].colStyle
                    if(data[i].colStyle == 'C030101'){
                        layui.laydate.render({
                            elem: '#'+ele.eq(i).attr('id')
                            ,trigger: 'click'//呼出事件改成click
                            // ,type: dateArr[i].type
                            ,format: 'yyyy年MM月dd日'
                        });
                        layui.form.render();
                    }else if(data[i].colStyle == 'C030102'){
                        layui.laydate.render({
                            elem: '#'+ele.eq(i).attr('id')
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'month'
                            ,format: 'yyyy年MM月'
                        });
                        layui.form.render();
                    }else if(data[i].colStyle == 'C030103'){
                        layui.laydate.render({
                            elem: '#'+ele.eq(i).attr('id')
                            ,trigger: 'click'//呼出事件改成click
                            // ,type: dateArr[i].type
                            ,format: 'MM月dd日'
                        });
                    }else if(data[i].colStyle == 'C030104'){
                        layui.laydate.render({
                            elem: '#'+ele.eq(i).attr('id')
                            ,trigger: 'click'//呼出事件改成click
                            // ,type: dateArr[i].type
                            ,format: 'yyyy-MM-dd'
                        });
                    }else if(data[i].colStyle == 'C030105'){
                        layui.laydate.render({
                            elem: '#'+ele.eq(i).attr('id')
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'month'
                            ,format: 'yyyy-MM'
                        });
                        layui.form.render();
                    }else if(data[i].colStyle == 'C030106'){
                        layui.laydate.render({
                            elem: '#'+ele.eq(i).attr('id')
                            ,trigger: 'click'//呼出事件改成click
                            // ,type: 'month'
                            ,format: 'MM-dd'
                        });
                        layui.form.render();
                    }else if(data[i].colStyle == 'C030107'){
                        layui.laydate.render({
                            elem: '#'+ele.eq(i).attr('id')
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'year'
                            ,format: 'yyyy年'
                        });
                        layui.form.render();
                    }else if(data[i].colStyle == 'C030108'){
                        layui.laydate.render({
                            elem: '#'+ele.eq(i).attr('id')
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'month'
                            ,format: 'M月'
                        });
                        layui.form.render();
                    }
                    // type.push(obj)

                }else if(data[i].colKtype == 'C0302'){
                    var obj = {}
                    obj.id = '#'+ele.eq(i).attr('id')
                    obj.type = data[i].colStyle
                    if(data[i].colStyle == 'C030201'){
                        layui.laydate.render({
                            elem: '#'+ele.eq(i).attr('id')
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'time'
                            ,format: 'HH时mm分'
                        });
                        layui.form.render();
                    }else if(data[i].colStyle == 'C030202'){
                        layui.laydate.render({
                            elem: '#'+ele.eq(i).attr('id')
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'time'
                            ,format: 'HH时mm分ss秒'
                        });
                        layui.form.render();
                    }else if(data[i].colStyle == 'C030203'){
                        layui.laydate.render({
                            elem: '#'+ele.eq(i).attr('id')
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'time'
                            ,format: 'HH:mm'
                        });
                        layui.form.render();
                    }else if(data[i].colStyle == 'C030204'){
                        layui.laydate.render({
                            elem: '#'+ele.eq(i).attr('id')
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'time'
                            ,format: 'HH:mm:ss'
                        });
                        layui.form.render();
                    }
                    // type.push(obj)
                }else if(data[i].colKtype == 'C0303'){
                    var obj = {}
                    obj.id = '#'+ele.eq(i).attr('id')
                    obj.type = data[i].colStyle
                    if(data[i].colStyle == 'C030301'){
                        layui.laydate.render({
                            elem: '#'+ele.eq(i).attr('id')
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'datetime'
                            ,format: 'yyyy年M月d日 H时m分s秒'
                        });
                        layui.form.render();
                    }else if(data[i].colStyle == 'C030302'){
                        layui.laydate.render({
                            elem: '#'+ele.eq(i).attr('id')
                            ,trigger: 'click'//呼出事件改成click
                            ,type: 'datetime'
                            // ,format: 'yyyy-M-d H:m:s'
                        });
                        layui.form.render();
                    }
                    // type.push(obj)
                }
                break

            case 'C04':
                if(data[i].colKtype == 'C0401'){
                    var num = Number(data[i].colStyle[data[i].colStyle.length-1])
                    ele.eq(i).attr('data-length',num)
                    ele.eq(i).blur(function(e){
                        if(isNaN(Number($(this).val()))){
                            $(this).val('')
                        }else{
                            $(this).val(Number($(this).val()).toFixed(Number($(this).attr('data-length'))))
                        }
                    })
                    ele.eq(i)[0].oninput = function(e){
                        if(isNaN(e.target.value)){
                            layui.layer.tips('请确认数字格式是否正确？',e.target,{tips:1,time:1000})
                        }
                    }
                }else if(data[i].colKtype == 'C0402'){
                    var num = Number(data[i].colStyle[data[i].colStyle.length-1])
                    ele.eq(i).attr('data-length',num)
                    ele.eq(i).focus(function(e){
                        $(this).val(e.currentTarget.value.split(',').join(''))
                    })

                    ele.eq(i).blur(function(e){
                        if(isNaN(Number($(this).val()))){
                            $(this).val('')
                        }else{
                            $(this).val(numFormat(Number($(this).val()).toFixed(Number($(this).attr('data-length')))))
                        }
                    })
                    ele.eq(i)[0].oninput = function(e){
                        if(isNaN(e.target.value)){
                            layui.layer.tips('请确认数字格式是否正确？',e.target,{tips:1,time:1000})
                        }
                    }
                }else if(data[i].colKtype == 'C0403'){
                    var num = Number(data[i].colStyle[data[i].colStyle.length-1])
                    ele.eq(i).attr('data-length',num)
                    ele.eq(i).focus(function(e){
                        $(this).val(e.currentTarget.value.split('%').join(''))
                    })
                    ele.eq(i).blur(function(e){
                        if(isNaN(Number($(this).val()))){
                            $(this).val('')
                        }else{
                            $(this).val(Number($(this).val()).toFixed(Number($(this).attr('data-length'))) + '%')
                        }
                    })
                    ele.eq(i)[0].oninput = function(e){
                        if(isNaN(e.target.value)){
                            layui.layer.tips('请确认数字格式是否正确？',e.target,{tips:1,time:1000})
                        }
                    }
                }
                break;
            // case 'S04':
            //     var id = 'COL'+data[i].colId;
            //     $('.formBox #COL'+data[i].colId).click(function(e){
            //         user_id = id;
            //         $.popWindow("../common/selectUser");
            //     })
            //     break;
            // case 'S05':
            //     var id = 'COL'+data[i].colId;
            //     $('.formBox #COL'+data[i].colId).click(function(e){
            //         dept_id = id;
            //         $.popWindow("/common/selectDept");
            //     })
            //     break;

        }
    }
}
//部门
function selectDept(e){
    var did = e.attr('id');
    dept_id = did;
    $.popWindow("/common/selectDept");
}
//用户
function selectUser(e){
    var uid = $(e[0]).next().attr('id');
    user_id = uid;
    $.popWindow("../common/selectUser");
}
// 编辑回显
function echoFun(data) {
    for(var item in data){
        if($('.formBox input[type="text"][name="'+item+'"]').length>0){
            if($('.formBox input[type="text"][num="num"][name="'+item+'"]').length>0){
                $('.formBox input[type="text"][num="num"][name="'+item+'"]').val(getNowNum(data[item],$('.formBox input[type="text"][num="num"][name="'+item+'"]').attr('colKtype')));
            }else{
                if($('.formBox input[type="text"][name="'+item+'"]').attr('colstyle') != undefined && $('.formBox input[type="text"][name="'+item+'"]').attr('colstyle').indexOf('C03') > -1){
                    $('.formBox input[type="text"][name="'+item+'"]').val(getNowFormatDate(data[item],$('.formBox input[type="text"][name="'+item+'"]').attr('colstyle')));
                }else{
                    if(item == 'CREATE_TIME' || item == 'UPDATE_TIME'){
                        if(data[item] != '' && data[item] != null && data[item] != undefined){
                            if(typeof(data[item])=='string'){
                                if(data[item].indexOf(':') > -1){
                                    var oldTime = (new Date(data[item])).getTime();
                                    var curTime = new Date(oldTime).Format("yyyy-MM-dd hh:mm:ss");
                                    $('.formBox input[type="text"][name="'+item+'"]').val(curTime);
                                }
                            }else{
                                var curTime = new Date(data[item]).Format("yyyy-MM-dd hh:mm:ss");
                                $('.formBox input[type="text"][name="'+item+'"]').val(curTime);
                            }
                        }else{
                            $('.formBox input[type="text"][name="'+item+'"]').val(data[item]);
                        }
                    }else if(item == 'CREATE_USER_ID'){
                        if(data['CREATE_USER'] != '' && data['CREATE_USER'] != undefined){
                            $('.formBox input[type="text"][name="'+item+'"]').attr('data-id',data[item]);
                            $('.formBox input[type="text"][name="'+item+'"]').val(data['CREATE_USER']);
                        }else{
                            $('.formBox input[type="text"][name="'+item+'"]').attr('data-id','');
                            $('.formBox input[type="text"][name="'+item+'"]').val('');
                        }
                    }else{
                        $('.formBox input[type="text"][name="'+item+'"]').val(data[item]);
                    }
                }
            }
        }
        if($('.formBox textarea[name="'+item+'"]').length>0){
            if(item == 'OWNER_USER_ID'){
                $('.formBox textarea[name="'+item+'"]').attr('user_id',data[item]);
                if(data['OWNER_USER_NAME'] != '' && data['OWNER_USER_NAME'] != undefined){
                    $('.formBox textarea[name="'+item+'"]').val(data['OWNER_USER_NAME'])
                }else{
                    $('.formBox textarea[name="'+item+'"]').val('')
                }
            }else if(item == 'DEPT_ID'){
                $('.formBox textarea[name="'+item+'"]').attr('deptid',data[item])
                if(data['DEPT_NAME'] != '' && data['DEPT_NAME'] != undefined){
                    $('.formBox textarea[name="'+item+'"]').val(data['DEPT_NAME'])
                }else{
                    $('.formBox textarea[name="'+item+'"]').val('')
                }
            }else{
                $('.formBox textarea[name="'+item+'"]').val(data[item]);
            }
        }
        if($('.formBox input[type="radio"][name="'+item+'"]').length>0){
            for(var j=0;j<$('.formBox input[type="radio"][name="'+item+'"]').length;j++){
                if($('.formBox input[type="radio"][name="'+item+'"]').eq(j).attr('title') == data[item]){
                    $('.formBox input[type="radio"][name="'+item+'"]').eq(j).prop('checked',true);
                    layui.form.render();
                }
            };
        }
        if($('.formBox input[type="checkbox"][lay-skin="primary"][name="'+item+'"]').length>0){
            if(data[item] != '' && data[item] != undefined){
                var arr = data[item].split(',');
                for(var j=0;j<arr.length;j++){
                    (function (j) {
                        if(arr[j] != ''){
                            for(var ch=0;ch<$('.formBox input[type="checkbox"][lay-skin="primary"][name="'+item+'"]').length;ch++){
                                if($('.formBox input[type="checkbox"][lay-skin="primary"][name="'+item+'"]').eq(ch).attr('title') == arr[j]){
                                    $('.formBox input[type="checkbox"][lay-skin="primary"][name="'+item+'"]').eq(ch).prop('checked',true);
                                    layui.form.render();
                                }
                            }
                        }
                    })(j)
                };
            }
        }
        if($('.formBox input[type="checkbox"][lay-skin="switch"][name="'+item+'"]').length>0){
            if(data[item] != '' && data[item] != undefined){
                var arr = data[item].split(',');
                for(var j=0;j<arr.length;j++){
                    if(arr[j] != ''){
                        if(arr[j] == '是'){
                            $('.formBox input[type="checkbox"][lay-skin="switch"][name="'+item+'"]').eq(j).prop('checked',true);
                            layui.form.render();
                        }else {
                            $('.formBox input[type="checkbox"][lay-skin="switch"][name="'+item+'"]').eq(j).prop('checked',false);
                            layui.form.render();
                        }
                    }
                };
            }
        }
        if($('.formBox select[name="'+item+'"]').length>0){
            $('.formBox select[name="'+item+'"]').find('option[value="'+data[item]+'"]').prop('selected', 'ture');
            layui.form.render('select');
        }
        if(item.indexOf('_ATTACHMENTLIST')>-1){
            var fileArr = data[item];
            var str = '';
            for (var i = 0; i < fileArr.length; i++) {
                var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
                var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

                /*str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';*/
                str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
                    '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px;display: none;"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                    '<a class="download" style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
            }
            $('#'+item.split('_ATTACHMENTLIST')[0]).append(str);
        }

    }
    $('.formBox #UPDATE_TIME').val(new Date().Format("yyyy-MM-dd hh:mm:ss"))
    $('.formBox').find('input[type="text"]').css('background-color','#d2d2d2')
    $('.formBox').find('textarea').css('background-color','#d2d2d2')
    for(var i=0;i<$('.formBox').find('input').length;i++){
        $('.formBox').find('input').eq(i).prop('disabled',true);
        layui.form.render();
    }
    for(var i=0;i<$('.formBox').find('textarea').length;i++){
        $('.formBox').find('textarea').eq(i).prop('disabled',true);
        layui.form.render();
    }
    for(var i=0;i<$('.formBox').find('select').length;i++){
        $('.formBox').find('select').eq(i).attr("disabled","disabled");
        layui.form.render('select');
    }

    for(var i=0;i<$('.formBox .layui-form-item').length;i++){
        if($('.formBox .layui-form-item').eq(i).find('.openFile').length>0){
            $('.formBox .layui-form-item').eq(i).find('.openFile').hide();
            $('.formBox .layui-form-item').eq(i).find('.deImgs').hide();
        }else{
            if($('.formBox .layui-form-item').eq(i).attr('class').indexOf('childTable') > -1) {

            }else{
                $('.formBox .layui-form-item').eq(i).prop('disabled','disabled');
                $('.formBox .layui-form-item').eq(i).addClass('disable');
            }
        }
    }
}
// 返回附件控件
function returnFile(data) {
    var type = [];

    for(var i=0;i<data.length;i++){
        if(data[i].colType == 'C08'){
            var obj = {}
            obj.id = 'COL'+data[i].colId
            obj.ids = 'COL'+data[i].colId +'s'
            type.push(obj)

        }
        if(data[i].colType == 'C09'){
            var obj = {}
            obj.id = 'COL'+data[i].colId
            obj.ids = 'COL'+data[i].colId +'s'
            type.push(obj)
        }

    }
    return type
}
// 判断输入框的格式
$(document).on('input','.formBox input[nam="C01"]',function(){
    var that = $('.formBox input[nam="C01"]');
    for(var i=0;i<that.length;i++){
        if($(that[i]).attr('colKtype') == 'C0105'){

            if(/^[a-zA-Z0-9_\-]{2,}@[a-zA-Z0-9_\-]{2,}(\.[a-zA-Z0-9_\-]+){1,2}$/.test($(that[i]).val())){

            }else{
                layui.layer.tips('请输入正确的邮箱!',$(that[i]),{tips:1,time:500})
            }
        }else if($(that[i]).attr('colKtype') == 'C0106'){
            if(/^[1-9]{1}[0-9]{14}$|^[1-9]{1}[0-9]{16}([0-9]|[xX])$/.test($(that[i]).val())){

            }else{
                layui.layer.tips('请输入正确的身份证号!',$(that[i]),{tips:1,time:500})
            }
        }else if($(that[i]).attr('colKtype') == 'C0107'){
            if(/^1[3456789]\d{9}$/.test($(that[i]).val())){

            }else{
                layui.layer.tips('请输入正确的手机号!',$(that[i]),{tips:1,time:500})
            }
        }
    }


})
// 回显数字
function getNowNum(data,type){
    var str = '';
    if(data != '' && data != undefined){
        if(type == 'C0401'){
            str = data;
        }else if(type == 'C0402'){
            str = numFormat(Number(data))
        }else if(type == 'C0403'){
            str = data + '%'
        }
    }else{
        str = ''
    }
    return str;
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
//查询操作
function serchFun(e){
    var obj = returnSerData();
    serchAjax(obj);

}
function serchAjax(obj) {
    for(var item in obj){
        if(obj[item] ==  '' || obj[item] ==  undefined){
            delete obj[item];
        }
    }
    layui.table.reload('test',{
        where:{
            strJson:JSON.stringify(obj)
        }
    })
}
// 返回查询数据
function returnSerData(){
    var $inp = $('.tops').find('input[type="text"]');
    var $sle = $('.tops').find('select');
    var $xml = $('.tops').find('.scroll');
    var $ralen = $('.formBox input[type="radio"]');
    var obj = {};
    for(var i=0;i<$inp.length;i++){
        if($inp.eq(i).attr('id') != '' && $inp.eq(i).attr('id') != undefined){
            if($inp.eq(i).attr('id').indexOf('_CH') > -1){
                obj[$inp.eq(i).attr('id').split('_CH')[0]] = $inp.eq(i).val();
            }
        }
    }
    for(var i=0;i<$sle.length;i++){
        obj[$sle.eq(i).attr('name').split('_CH')[0]] = $sle.eq(i).next('.layui-form-select').find('dl dd.layui-this').attr('lay-value');
    }
    for(var i=0;i<$xml.length;i++){
        obj[$xml.eq(i).parents('.layui-input-inline').children().attr('id').split('_CH')[0]] = $xml.eq(i).find('.label-content').attr('title');
    }
    for(var i=0;i<$ralen.length;i++){
        if($ralen.eq(i).next('.layui-form-radioed').length > 0){
            obj[$ralen.eq(i).attr('name')] = $ralen.eq(i).attr('title')
        }
    }
    return obj;
}
// 编辑
$(document).on('click','#BUT_FORM_EDIT',function () {
    var type = $('#BUT_FORM_EDIT').attr('data-type');
    if(type == '1'){
        for(var i=0;i<$('.formBox').find('input').length;i++){
            $('.formBox').find('input').eq(i).prop('disabled',false);
            layui.form.render();
        }
        for(var i=0;i<$('.formBox').find('textarea').length;i++){
            $('.formBox').find('textarea').eq(i).prop('disabled',false);
            layui.form.render();
        }
        for(var i=0;i<$('.formBox').find('select').length;i++){
            $('.formBox').find('select').eq(i).removeAttr("disabled");
            layui.form.render('select');
        }
        for(var i=0;i<$('.formBox .layui-form-item').length;i++){
            if($('.formBox .layui-form-item').eq(i).find('.openFile').length>0){
                $('.formBox .layui-form-item').eq(i).find('.openFile').show();
                $('.formBox .layui-form-item').eq(i).find('.deImgs').show();
            }else{
                $('.formBox .layui-form-item').eq(i).prop('disabled',false);
                $('.formBox .layui-form-item').eq(i).removeClass('disable');
            }
        }

        $('.formBox').find('input[type="text"]').css('background-color','#fff')
        $('.formBox').find('textarea').css('background-color','#fff')
        $('#BUT_FORM_EDIT').html('详情')
        $('.layui-layer-btn0').show();
        $('#BUT_FORM_EDIT').css('color','rgb(16,127,255)')
        $('#BUT_FORM_EDIT').attr('data-type','0')
    }else{
        $('.formBox').find('input[type="text"]').css('background-color','#d2d2d2')
        $('.formBox').find('textarea').css('background-color','#d2d2d2')
        $('#BUT_FORM_EDIT').html('编辑')
        $('.layui-layer-btn0').hide();
        $('#BUT_FORM_EDIT').css('color','#000')
        $('#BUT_FORM_EDIT').attr('data-type','1')
        for(var i=0;i<$('.formBox').find('input').length;i++){
            $('.formBox').find('input').eq(i).prop('disabled',true);
            layui.form.render();
        }
        for(var i=0;i<$('.formBox').find('textarea').length;i++){
            $('.formBox').find('textarea').eq(i).prop('disabled',true);
            layui.form.render();
        }
        for(var i=0;i<$('.formBox').find('select').length;i++){
            $('.formBox').find('select').eq(i).attr("disabled","disabled");
            layui.form.render('select');
        }
        for(var i=0;i<$('.formBox .layui-form-item').length;i++){
            if($('.formBox .layui-form-item').eq(i).find('.openFile').length>0){
                $('.formBox .layui-form-item').eq(i).find('.openFile').hide();
                $('.formBox .layui-form-item').eq(i).find('.deImgs').hide();
            }else{
                $('.formBox .layui-form-item').eq(i).prop('disabled','disabled');
                $('.formBox .layui-form-item').eq(i).addClass('disable');
            }
        }
        // var obj = getData()
        // $.ajax({
        //     url:'/gdata/updateByDataId',
        //     type:'get',
        //     data:{
        //         dataId:DATA_ID,
        //         tabId:tabId,
        //         strJson:JSON.stringify(obj)
        //     },
        //     dataType:'json',
        //     success:function(obj){
        //         if(obj.flag){
        //             layui.layer.msg('修改成功!',{icon:1})
        //             // layer.closeAll();
        //             layui.table.reload('test');
        //         }
        //     }
        // })
    }

})
// 删除
$(document).on('click','#BUT_FORM_DEL',function () {
    layer.confirm('确定删除数据吗？', {
        btn: ['确定','取消'], //按钮
        title:"删除"
    }, function(){
        //确定删除，调接口
        $.ajax({
            url:'/gdata/deleteByDataId',
            type:'get',
            data:{
                tabId:tabId,
                dataId:DATA_ID
            },
            dataType:'json',
            success:function(obj){
                if(obj.flag){
                    layer.msg('删除成功!')
                    layer.closeAll();
                    layui.table.reload('test');
                }
            }
        })

    }, function(){
        layer.closeAll();
    });
})

var timer=null;
var gs
function fileuploadFns(formId,element) {
    // $('#uploadinputimg').fileupload({
    var progressIN;
    $(formId).fileupload({
        dataType:'json',
        start: function (e) {
            var i = 0;
            progressIN = setInterval(function(){
                i = i + 1;
                $('#progress .bar').css(
                    'width',
                    i *10+ '%'
                );
                $('.barText').html(i * 10 + '%');
                if(i == 9){
                    clearInterval(progressIN);
                }
            }, 1500)

        },
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progress .bar').css(
                'width',
                progress + '%'
            );
            $('.barText').html(progress + '%');
            if(progress >= 100){  //判断滚动条到100%清除定时器
                timer=setTimeout(function () {
                    $('#progress .bar').css(
                        'width',
                        0 + '%'
                    );
                    $('.barText').html('');
                },2000);

            }
        },
        done: function (e, data) {
            var ele = $(e.target).parents('a.openFile').prev();
            if(data.result.obj!=undefined){
                if(data.result.obj != ''){
                    var data = data.result.obj;
                    var str = '';
                    var str1 = '';
                    for (var i = 0; i < data.length; i++) {
                        var gs = data[i].attachName.split('.')[1];
                        if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){ //后缀为这些的禁止上传
                            str += '';
                            layer.alert('jsp、css、js、html、java文件禁止上传!',{},function(){
                                layer.closeAll();
                            });
                        }else if(gs == 'jpg'|| gs == 'png'|| gs == 'gif'|| gs == 'jpeg'|| gs == 'svg'|| gs == 'swf' ){
                            var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
                            var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                            var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                            var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;

                            str += '<div class="dech" NAME1="' + data[i].attachName + '" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'"   NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px;display: none;"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a><a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><a style="display: none;" fileExtension="'+fileExtension+'" onclick="transfers($(this))"  attrurl="' + deUrl.substring(0,deUrl.lastIndexOf("&"))  + '" href="javascript:;" style="padding-left: 5px;display: none;"  ><img src="/img/attachmentIcon/tran.png"  style="padding: 0 5px;">转存</a><input type="hidden" class="inHidden" size="'+ data[i].size +'" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                        }
                        /* else if(data[i].attachName.indexOf('+')!=-1){
                                 alert("你上传的"+data[i].attachName+"文件有特殊字符'+',文件名中不可存在特殊字符,请重新上传");

                         }*/
                        else{
                            var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
                            var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                            var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                            var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;

                            str += '<div class="dech" NAME1="' + data[i].attachName + '" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'"   NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px;display: none;"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a><a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><a class="operation" href="javascript:;" onclick="editAttachment($(this))" class="editFile" style="margin-left: 10px;display: none;" attrurl="' + deUrl + '"><img src="/img/attachmentIcon/icon_edit.png" style="margin-right: 5px;" alt="">编辑</a><a style="display: none;" fileExtension="'+fileExtension+'" onclick="transfers($(this))"  attrurl="' + deUrl.substring(0,deUrl.lastIndexOf("&"))  + '" href="javascript:;" style="padding-left: 5px"  ><img src="/img/attachmentIcon/tran.png"  style="padding: 0 5px;">转存</a><input type="hidden" class="inHidden" size="'+ data[i].size +'" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                        }
                        $('#uploadinputimg').attr('filename',data[i].attachName)
                    }
                    str+='<input type="hidden" class="itemVal" value='+JSON.stringify(data[0]).replace(/\s*/g,"")+'></input>'
                    element.append(str);
                }else{
                    layer.alert('添加附件大小不能为空!',{},function(){
                        layer.closeAll();
                    });
                }
            }else {
                if(data.result.datas != ''){
                    var data = data.result.datas;
                    var str = '';
                    var str1 = '';
                    for (var i = 0; i < data.length; i++) {
                        gs = data[i].attachName.split('.')[1];
                        if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){ //后缀为这些的禁止上传
                            str += '';
                            layer.alert('jsp、css、js、html、java文件禁止上传!',{},function(){
                                layer.closeAll();
                            });
                        }
                        /* else if(data[i].attachName.indexOf('+')!=-1){
                             alert("你上传的"+data[i].attachName+"文件有特殊字符'+',文件名中不可存在特殊字符,请重新上传");
                         }*/
                        else{
                            var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
                            var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                            var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                            var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;

                            str += '<div class="dech" NAME1="' + data[i].attachName + '" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'"  NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px;display: none;"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a><a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><a class="operation" href="javascript:;" onclick="editAttachment($(this))" class="editFile" style="margin-left: 10px;display: none;" attrurl="' + deUrl + '"><img src="/img/attachmentIcon/icon_edit.png" style="margin-right: 5px;" alt="">编辑</a><a style="display: none;" fileExtension="'+fileExtension+'" onclick="transfers($(this))"  attrurl="' + deUrl.substring(0,deUrl.lastIndexOf("&"))  + '" href="javascript:;" style="padding-left: 5px;display: none;"  ><img src="/img/attachmentIcon/tran.png"  style="padding: 0 5px;">转存</a><input type="hidden" class="inHidden" size="'+ data[i].size +'" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                        }
                        $('#uploadinputimg').attr('filename',data[i].attachName)
                    }
                    // $('.Attachment td').eq(1).append(str);
                    str+='<input type="hidden" class="itemVal" value='+JSON.stringify(data[0]).replace(/\s*/g,"")+'></input>'
                    element.append(str);
                }else{
                    layer.alert('添加附件大小不能为空!',{},function(){
                        layer.closeAll();
                    });
                }
            }

        }
    });
}

//附件删除
$(document).on('click','.deImgs',function(){
    var data=$(this).parents('.dech').attr('deUrl');
    var dome=$(this).parents('.dech');
    deleteChatment(data,dome);
})
//删除附件
function deleteChatment(data,element){
    var layopen1 = layui.layer.confirm('确定删除吗？', {
        btn: ['确定','取消'], //按钮
        title:"删除附件"
    }, function(){
        //确定删除，调接口
        $.ajax({
            type:'post',
            url:'/delete',
            dataType:'json',
            data:data,
            success:function(res){
                if(res.flag == true){
                    layui.layer.msg('删除成功', { icon:6, time: 2000 }, function(){
                        if(layOpenFlag){
                            layui.layer.closeAll();
                        }
                    });
                    element.remove();
                }else{
                    layui.layer.msg('删除失败', { icon:6});
                }
            }
        });

    }, function(){
        layui.layer.close(layopen1);
    });
}


//获取当前时间，格式YYYY-MM-DD
function getNowFormatDate(time,type) {
    var str = ''
    if(time != '' && time != null && time != undefined && time != 'undefined' && time != 'null'){
        if(type == 'C030302'){
            var date = new Date(time);
            var N = date.getFullYear(); //年
            var Y = (date.getMonth() + 1) < 10 ? '0' + (date.getMonth() + 1): date.getMonth() + 1 ;//月
            var Y0 = date.getMonth() + 1
            var R = date.getDate() < 10 ? '0' + date.getDate() : date.getDate();//日
            var H = date.getHours() < 10 ? '0' + date.getHours() : date.getHours(); //时
            var F = date.getMinutes() < 10 ? '0' + date.getMinutes() : date.getMinutes(); //分
            var M = date.getSeconds() < 10 ? '0' + date.getSeconds(): date.getSeconds(); //秒
            str = N + '-' + Y + '-' + R + ' ' + H + ':' + F + ':' + M;
        }else{
            str = time;
        }
    }else{
        str = ''
    }
    return str;
}
// 获取附件
function getFile(data,id,title) {
    $.ajax({
        url:'/gdata/selectByDataId',
        type:'get',
        data:{
            tabId:tabId,
            dataId:data.DATA_ID
        },
        dataType:'json',
        success:function(obj){
            if(obj.flag){
                for(var item in obj.object){
                    if(item.indexOf(id) > -1){
                        var attachmentArr = obj.object[item.split('_NAME')[0] + '_ATTACHMENTLIST'];
                        var str = attachView(attachmentArr,'',3,'','','',attachmentArr,'files');
                        layui.layer.open({
                            type: 1,
                            area: ['531px', '372px'], //宽高
                            title: title,
                            maxmin: true,
                            btn: ['确定'], //可以无限个按钮
                            content: '<div id="fileBoxs" style="background-color: #fff;margin: 0;" method="post" class="layui-form">\n' +
                           str +
                            '    </div>',
                            success: function () {


                            },
                            yes: function (index) {

                            }
                        });
                    }
                }
            }
        }
    })
}
var officeArr=['word','WORD','doc','DOC','docx','DOCX','xlsx','XLSX','xls','XLS','txt','TXT','png','PNG','jpg','JPG','pdf','PDF','ppt','PPT','pptx','PPTX'];
officeArr = officeArr.toString();
var attachViewType= '';
var strOfficeApps = '';
var documentPreviewOpen = 0;
function attachView(attachmentArr,attachmentBox,styleType,editJurisdiction,downJurisdiction,deleteJurisdiction,arr1,wenjiangui) {
    //attachmentArr：附件集合；attachmentBox：承载附件显示的div的ID；styleType：附件显示样式；editJurisdiction：编辑权限；downJurisdiction下载权限；deleteJurisdiction：删除权限
    var attachmentName='',previewBtn='',consuilBtn='',editBtn='',downBtn='',deleteBtn='',floatDiv='',TransferBtn='';
    //attachmentName：附件名称显示；previewBtn:：预览按钮；consuilBtn：查阅按钮；editBtn：编辑按钮；downBtn：下载按钮；deleteBtn：删除按钮；TransferBtn:转存按钮
    var str='';
    var openimg = ''
    var picNum = 0;
    var picNumWen = 0;
    if(wenjiangui == 'files'){
        var attachmentUrl;
        for(var j=0;j<arr1.length;j++){
            if(arr1[j] != undefined){
                attachmentUrl =arr1[j].attUrl; //获取附件地址
            }else{
                attachmentUrl = '';
            }
            var fileExtension=('?'+attachmentUrl).substring(('?'+attachmentUrl).lastIndexOf(".")+1,('?'+attachmentUrl).length);//截取附件文件后缀
            var domain = document.location.origin;
            if(fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg') {
                openimg+= domain+'/xs?'+attachmentUrl+'*'
            }
        }
    }else {
        for(var j=0;j<attachmentArr.length;j++){
            var attachmentUrl =attachmentArr[j].attUrl; //获取附件地址
            var fileExtension=('?'+attachmentUrl).substring(('?'+attachmentUrl).lastIndexOf(".")+1,('?'+attachmentUrl).length);//截取附件文件后缀
            var domain = document.location.origin;
            if(fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg') {
                openimg+= domain+'/xs?'+attachmentUrl+'*'
            }
        }
    }

    // openNmu = 0

    for(var i=0;i<attachmentArr.length;i++){ //循环附件集合
        var attachmentUrl =attachmentArr[i].attUrl; //获取附件地址
        var fileExtension=('?'+attachmentUrl).substring(('?'+attachmentUrl).lastIndexOf(".")+1,('?'+attachmentUrl).length);//截取附件文件后缀
        var attName = encodeURI(attachmentArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
        attachmentUrl = attachmentUrl.substring(0,attachmentUrl.lastIndexOf("ATTACHMENT_NAME="))+"ATTACHMENT_NAME="+attName; //处理附件名字
        var fileIcon='';
        if(datatyoe[fileExtension] == undefined){ //处理附件图标
            fileIcon='file';
        }else{
            fileIcon=datatyoe[fileExtension];
        }
        var size = attachmentArr[i].size == ''?'': '('+attachmentArr[i].size+')';
        attachmentName ='<a class="file_a"><img class="img_" src="/img/attachmentIcon/'+fileIcon+'.png" style="vertical-align: middle;"/><span style="margin-left: 10px">' + attachmentArr[i].attachName + '</span><span style="margin-left: 5px;">'+size+'</span></a>';
        // if(editJurisdiction == '1'){ //判断编辑权限
        //     if(fileExtension == 'doc' || fileExtension == 'DOC'|| fileExtension == 'docx' || fileExtension == 'DOCX'|| fileExtension == 'xls' || fileExtension == 'XLS'|| fileExtension == 'xlsx' || fileExtension == 'XLSX'|| fileExtension == 'ppt' || fileExtension == 'PPT'|| fileExtension == 'pptx'|| fileExtension == 'PPTX'){
        //         editBtn='<a class="operation" href="javascript:;" onclick="editAttachment($(this),'+downJurisdiction+')" class="editFile" style="margin-left: 10px;" attrurl="' + attachmentUrl + '"><img src="/img/attachmentIcon/icon_edit.png" style="margin-right: 5px;" alt="">编辑</a>';
        //     }else{
        //         editBtn='';
        //     }
        // }else{
        //     editBtn='';
        // }

        downBtn='<a class="operation download" style="margin-left: 10px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>';



        if(officeArr.indexOf(fileExtension) > -1){ //判断是否为可读文件
            previewBtn='';
            // if(fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg') {
            //     openimg+= domain+'/xs?'+attachmentUrl+'*'
            // }
            if(attachViewType != '0'&&documentPreviewOpen != 0){
                previewBtn='<a class="operation" onclick="preview($(this))" href="javascript:;" attrurl="' + encodeURI(attachmentUrl) +'" style="margin-left: 10px"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">预览</a>';
            }
            if(fileExtension == 'pdf' || fileExtension == 'PDF'  || fileExtension == 'txt'|| fileExtension == 'TXT'){ //判断是否需要查阅
                previewBtn='';
                consuilBtn='<a class="operation" onclick="consult($(this))" style="margin-left: 10px" attrurl="' + attachmentUrl + '" href="javascript:;"><img src="/img/attachmentIcon/attachPreview.png" style="margin-right: 5px;" alt="">预览</a>';
            }else{
                consuilBtn='<a class="operation" onclick="consult($(this))" style="margin-left: 10px" attrurl="' + attachmentUrl + '" href="javascript:;"><img src="/img/attachmentIcon/attachPreview.png" style="margin-right: 5px;" alt="">查阅</a>';
            }
            if(fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg'|| fileExtension == 'JPG'){
                previewBtn='';
                var domain = document.location.origin;

                if(wenjiangui == 'files'){
                    picNums = picNumWen
                    picNumWen++
                }else {
                    var picNums = picNum;
                    picNum = picNum+1;
                }
                consuilBtn='<a class="operation operationImg"  style="margin-left: 10px" attrurl="' + attachmentUrl + '" href="javascript:;"><img src="/img/attachmentIcon/attachPreview.png" style="margin-right: 5px;" alt="">预览</a>'+
                    '<img openimg="'+openimg+'"  openNmu = "'+picNums+'"  class="operation"  src="'+domain+attachmentUrl+'" style="margin-left: 10px;display: none" attrurl="' + attachmentUrl + '" href="javascript:;"></img>';
                // openNmu++
            }

            if(styleType == '3'){ //previewBtn + consuilBtn +  attachmentName + previewBtn + consuilBtn +
                str+='<div class="divShow" style="position: relative;"><a href="javascript:;" class="fujian" style="display:block;word-break: break-all;color: #54b6fe;" title="'+attachmentArr[i].attachName+'&nbsp;&nbsp;&nbsp;'+attachmentArr[i].size+'"><img style="margin-right:5px;" src="/img/attachmentIcon/'+fileIcon+'.png"/>'+attachmentArr[i].attachName+'<span style="margin-left: 5px;">('+attachmentArr[i].size +')</span></a>' +
                    '<div class="operationDiv" style="display:none;">'+ downBtn +'</div>' +
                    '</div>';
            }else{
                str+='<div class="font_" style="display: block">' + downBtn + '</div>';
            }
        }else{
            if(styleType == '3'){
                str+='<div class="divShow" style="position: relative;">' +
                    '<a href="javascript:;" class="fujian" style="display:block;word-break: break-all;color: #54b6fe;" title="'+attachmentArr[i].attachName+'&nbsp;&nbsp;&nbsp;'+attachmentArr[i].size+'">' +
                    '<img style="margin-right:5px;" src="../img/attachmentIcon/'+fileIcon+'.png"/>'+attachmentArr[i].attachName+
                    '<span style="margin-left: 5px;">('+attachmentArr[i].size +')</span>' +
                    '</a>' +
                    '<div class="operationDiv" style="display:none;">'+ downBtn +'</div>' +
                    '</div>';
            }else{
                str+='<div class="font_" style="display: block">' + attachmentName + downBtn + '</div>';
            }
        }
    }
    if(styleType == '1'){ //判断样式
        attachmentBox.html(str);
    }else if(styleType == '2'){
        attachmentBox.html('<div class="font_"  style="display: block"><span class="attachTxt" style="float: left;">附件文件：</span><div style="float: left;">'+str+'</div></div>')
    }else{
        return str;
    }
}

// 鼠标移入移出附件
$(document).on('mouseover','#fileBoxs .divShow',function () {
    $(this).find('.operationDiv').show();
})
$(document).on('mouseout','#fileBoxs .divShow',function () {
    $(this).find('.operationDiv').hide();
})
// 按钮权限
function btnPrivFun(object,type) {
    if(type == 'list'){
        if(object.listButtonPriv.indexOf('BUT_LIST_ADD')>-1){
            $('#BUT_LIST_ADD').show();
        }else{
            $('#BUT_LIST_ADD').hide();
        }
        if(object.listButtonPriv.indexOf('BUT_LIST_DEL')>-1){
            $('#BUT_LIST_DEL').show();
        }else{
            $('#BUT_LIST_DEL').hide();
        }
        if(object.listButtonPriv.indexOf('BUT_LIST_IN')>-1){
            $('#BUT_LIST_IN').show();
        }else{
            $('#BUT_LIST_IN').hide();
        }
        if(object.listButtonPriv.indexOf('BUT_LIST_OUT')>-1){
            $('#BUT_LIST_OUT').show();
        }else{
            $('#BUT_LIST_OUT').hide();
        }
    }
    if(type == 'form'){
        if(object.tabButtonPriv.indexOf('BUT_FORM_DEL')>-1){
            $('#BUT_FORM_DEL').show();
        }else{
            $('#BUT_FORM_DEL').hide();
        }
        if(object.tabButtonPriv.indexOf('BUT_FORM_EDIT')>-1){
            $('#BUT_FORM_EDIT').show();
            if(object.tabButtonPriv.indexOf('BUT_FORM_DEL')>-1){
                $('#BUT_FORM_EDIT').css('right','120px');
            }else{
                $('#BUT_FORM_EDIT').css('right','40px');
            }
        }else{
            $('#BUT_FORM_EDIT').hide();

        }
        if(object.tabButtonPriv.indexOf('BUT_FORM_TEMP')>-1){
            $('.layui-layer-btn1').hide();
        }else{
            $('.layui-layer-btn1').hide();
        }
        if(object.tabButtonPriv.indexOf('BUT_FORM_SUBMIT')>-1){
            $('.layui-layer-btn3').hide();
        }else{
            $('.layui-layer-btn3').hide();
        }
        if(object.tabButtonPriv.indexOf('BUT_FORM_SAVE')>-1){
            if($('#BUT_FORM_EDIT').text() !="编辑"){
                $('.layui-layer-btn0').show();
            }else{
                $('.layui-layer-btn0').hide();
            }
        }else{
            $('.layui-layer-btn0').hide();
        }
    }

}
//同步
function toAjaxTT(url,data) {
    var result;
    $.ajax({
        url:url,
        data:data,
        type: 'post',
        async:false,
        dataType: 'json',
        success: function (res){
            result=res;
        }
    });
    return result;
}
function toAjaxTG(url,data) {
    var result;
    $.ajax({
        url:url,
        data:data,
        type: 'get',
        async:false,
        dataType: 'json',
        success: function (res){
            result=res;
        }
    });
    return result;
}
// 数组对象分割
function returnObjArr(data) {
    var dataArr = [];
    if(data.length>0){
        var eqArr = getEQ(data);
        if(eqArr.length > 0){
            if(Number(eqArr[0]) > 0){
                var arr = [];
                for(var i=0;i<data.length;i++){
                    if(i < Number(eqArr[0])){
                        arr.push(data[i]);
                    }
                }
                dataArr.push(arr);
            }
            for(var j=0;j<eqArr.length-1;j++){
                (function (j) {
                    var arr = [];
                    dataArr.push(data.slice(Number(eqArr[j]),Number(eqArr[j+1])))
                })(j)
            }
            if(Number(eqArr[eqArr.length-1]) || Number(eqArr[eqArr.length-1]) == 0){
                var arr = [];
                for(var i=0;i<data.length;i++){
                    if(i >= Number(eqArr[eqArr.length-1])){
                        arr.push(data[i]);
                    }
                }
                dataArr.push(arr);
            }
        }else{
            var arr = [];
            for(var i=0;i<data.length;i++){
                arr.push(data[i]);
            }
            dataArr.push(arr);
        }
    }
    return dataArr;
}
// 获取分组控件的下标
function getEQ(data) {
    var eqArr = [];
    if(data.length>0){
        for(var i=0;i<data.length;i++){
            (function (i) {
                if(data[i].colType == 'L02'){
                    eqArr.push(i)
                }
            })(i)
        }
    }
    return eqArr;
}
// 获取所有组件
function getAllColumns(data) {
    var allArr = []
    if(data.length > 0){
        for(var i=0;i<data.length;i++){
            (function (i) {
                if(data[i].colType == 'L01'){
                    if(data[i].colKtype == 'L0101'){
                        var itemObj = JSON.parse(data[i].colStyle);
                        var robj = getRatio(itemObj.shareRatio.ratio,data[i].colKtype)
                        if(itemObj.oneCol){
                            itemObj.oneCol.vm = robj.L;
                            allArr.push(itemObj.oneCol)
                        }
                        if(itemObj.twoCol){
                            itemObj.twoCol.vm = robj.R;
                            allArr.push(itemObj.twoCol)
                        }

                    }else if(data[i].colKtype == 'L0102'){
                        var itemObj = JSON.parse(data[i].colStyle);
                        var robj = getRatio(itemObj.shareRatio.ratio,data[i].colKtype)
                        if(itemObj.oneCol){
                            itemObj.oneCol.vm = robj.L;
                            allArr.push(itemObj.oneCol)
                        }
                        if(itemObj.twoCol){
                            itemObj.twoCol.vm = robj.C;
                            allArr.push(itemObj.twoCol)
                        }
                        if(itemObj.threeCol){
                            itemObj.threeCol.vm = robj.R;
                            allArr.push(itemObj.threeCol)
                        }
                    }else if(data[i].colKtype == 'L0103'){
                        var itemObj = JSON.parse(data[i].colStyle);
                        var robj = getRatio(itemObj.shareRatio.ratio,data[i].colKtype)
                        if(itemObj.oneCol){
                            itemObj.oneCol.vm = robj.L;
                            allArr.push(itemObj.oneCol)
                        }
                        if(itemObj.twoCol){
                            itemObj.twoCol.vm = robj.LC;
                            allArr.push(itemObj.twoCol)
                        }
                        if(itemObj.threeCol){
                            itemObj.threeCol.vm = robj.RC;
                            allArr.push(itemObj.threeCol)
                        }
                        if(itemObj.fourCol){
                            itemObj.fourCol.vm = robj.R;
                            allArr.push(itemObj.fourCol)
                        }
                    }
                }else{
                    data[i].vm = '100';
                    allArr.push(data[i])
                }
            })(i)
        }
    }
    return allArr;
}
function getRatio(obj,type) {
    if(type == 'L0101'){
        var robj = {};
        if(obj == '50:50'){
            robj.L = '50';
            robj.R = '50';
        }else if(obj == '33.3:66.6'){
            robj.L = '33.3';
            robj.R = '66.6';
        }if(obj == '66.6:33.3'){
            robj.L = '66.6';
            robj.R = '33.3';
        }if(obj == '25:75'){
            robj.L = '25';
            robj.R = '75';
        }if(obj == '75:25'){
            robj.L = '75';
            robj.R = '25';
        }
    }else if(type == 'L0102'){
        var robj = {};
        if(obj == '33.3:33.3:33.3'){
            robj.L = '33.3';
            robj.C = '33.3';
            robj.R = '33.3';
        }else if(obj == '25:25:50'){
            robj.L = '25';
            robj.C = '25';
            robj.R = '50';
        }if(obj == '50:25:25'){
            robj.L = '50';
            robj.C = '25';
            robj.R = '25';
        }if(obj == '25:50:25'){
            robj.L = '25';
            robj.C = '50';
            robj.R = '25';
        }
    }else if(type == 'L0103'){
        var robj = {};
        if(obj == '25:25:25:25'){
            robj.L = '25';
            robj.LC = '25';
            robj.RC = '25';
            robj.R = '25';
        }
    }
    return robj;
}