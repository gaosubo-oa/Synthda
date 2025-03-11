//初始化拖拽控件,icon不可拖动
$('#chooses').find('img').attr('draggable','false')

// 判断是不是保存刷新页面
if(sessionStorage.getItem('save')){
    sessionStorage.removeItem('save')
    layer.msg('保存成功', {icon: 6});
}
var mydatas
var tree
var dragDom
var activeCol
var activeIndex
var formList = []
var form
var treeIndex
var xmSelect

var gappId = getQueryString('gappId')
var typeId = getQueryString('typeId')
var tabId
var msg
var listRender = true
let dropFlag = true
let clearFlag = false
let editColObj = {}
let laydate
var chooseCalFlag = false
var tableProgress = {}
var selectId
var selectVal

//查询以前有没有保存过的表单

//获取地址栏参数
function getQueryString(name){
    var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if(r!=null)return  unescape(r[2]); return null;
}
// 存入数据
localStorage.setItem("gappId", JSON.stringify(gappId));
// 根据控件类型生成对应的控件对象
function Store(options){
    this.type = options.type
    this.temObj = template(options.type)
}

var allIndex = layer.load(1, {
    shade: [0.1,'#fff'] //0.1透明度的白色背景
});

//生成控件对象
function template(type){
    var flag = randomWord(false,8,8)
    var height = 0
    $('#show-form .layui-form-item').each(function(item,index,arr){
        height += parseInt($(this).css('height')) -6
    })
    switch(type) {
        case 'C01':  //单行文本
            var obj = {
                /*
                *  @colName         控件名称
                *  @colType         控件类型
                *  @colKtype        控件子类型
                *  @defaultVal      默认值
                *  @scanCheck       扫码选中
                *  @scanOptions     扫码选项
                *  @isCheckhave     校验-不允许重复录入
                *  @inputTips       提示语
                *  @inputDesc       描述
                *  @top             该控件定位的top值
                *  @flag            每个控件的唯一标识
                */
                colName :'单行文本',
                colType:'C01',
                defaultVal:'',
                colKtype:'C0101',
                colKtypeOptions: [
                    {optionName:'短文本',optionValue:'C0101'},
                    {optionName:'长文本',optionValue:'C0102'},
                    {optionName:'邮箱',optionValue:'C0105'},
                    {optionName:'身份证',optionValue:'C0106'},
                    {optionName:'固话/手机',optionValue:'C0107'},
                ],
                scanOptions: [
                    {optionName:'不允许扫码输入',optionValue:'0'},
                    {optionName:'允许扫码输入且不能修改',optionValue:'1'},
                    {optionName:'允许扫码输入且可以修改',optionValue:'2'},
                ],
                inputScan:'0',
                inputTips:'',
                inputDesc:'',
                top:height,
                flag:flag,
            }
            obj.formTem = function(isChild){
                return ' <form class="layui-form" id="control-data">\n' +
                    '       <div class="layui-form-item" id="controlName" >\n' +
                    '           <div>\n' +
                    '               <span>控件名称</span>\n' +
                    '               <span class="control-remarks">单行文本</span>\n' +
                    '           </div>\n' +
                    '           <div>\n' +
                    '               <input type="text" name="colName" lay-verify="title" autocomplete="off" class="layui-input" value="' + this.colName + '" oninput="changeInput(this,'+ isChild +')">\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item">\n' +
                    '           <label class="layui-form-label">默认值</label>\n' +
                    '           <div style="margin-top: 10px">\n' +
                    '               <input type="text" name="defaultVal" lay-verify="title" autocomplete="off" class="layui-input" value="'+ this.defaultVal +'" oninput="changeInput(this,'+ isChild +')">\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item">\n' +
                    '           <label class="layui-form-label">格式</label>\n' +
                    '           <div>\n' +
                    '               <select name="colKtype" lay-filter="colKtype">\n' +
                    createOptions(this.colKtypeOptions,this.colKtype) +
                    '               </select>\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item" id="colTips">\n' +
                    '           <label class="layui-form-label">提示语</label>\n' +
                    '           <div>\n' +
                    '               <input type="text" name="inputTips" lay-verify="title" autocomplete="off" class="layui-input" value="' + this.inputTips + '" oninput="changeInput(this,'+ isChild +')">\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item" id="remarks">\n' +
                    '           <label class="layui-form-label">描述</label>\n' +
                    '           <div>\n' +
                    '               <textarea class="layui-textarea" name="inputDesc" oninput="changeInput(this,'+ isChild +')">' + this.inputDesc + '</textarea>\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height,flag){
                if(this.flag == flag){
                    return '<div class="layui-form-item  input-enter input-active" style="position: absolute; left: 0px; top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) + '</label>\n' +
                        '       <div style="display: block" class="input-text">\n' +
                        '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请输入" class="layui-input">\n' +
                        '       </div>\n' +
                        '       <div class="colDelete" style="display: block"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy" style="display: block"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }else{
                    return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px;top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) + ' </label>\n' +
                        '       <div style="display: block" class="input-text">\n' +
                        '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请输入" class="layui-input">\n' +
                        '       </div>\n' +
                        '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }
            },
            obj.createTemplatec = function(){
                return '<div class="layui-form-item ' + (this.flag ==  (activeCol&&activeCol.temObj.flag)?'input-active':'') + '" data-type="' + this.colType + '" data-flag="' + this.flag + '">\n' +
                    '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) + ' </label>\n' +
                    '       <div style="display: block" class="input-text">\n' +
                    '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请输入" class="layui-input">\n' +
                    '       </div>\n' +
                    '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   </div>'
                }
            obj.template = obj.createTemplate(obj.top,false)
            return obj
            break;
        case 'C02':
            var obj = {
                /*
                *  @colName         控件名称
                *  @colType         控件类型
                *  @row             可见行数
                *  @defaultVal      默认值
                *  @inputTips       提示语
                *  @inputDesc       描述
                *  @top             该控件定位的top值
                *  @flag            每个控件的唯一标识
                */
                colName:'多行文本',
                colType:'C02',
                colStyle:'3',
                defaultVal:'',
                inputTips:'',
                inputDesc:'',
                top:height,
                flag:flag,
            }
            obj.formTem = function(isChild){
                return '<form class="layui-form" id="control-data">\n' +
                    '   <div class="layui-form-item" id="controlName">\n' +
                    '       <div>\n' +
                    '           <span>控件名称</span>\n' +
                    '           <span class="control-remarks">多行文本</span>\n' +
                    '       </div>\n' +
                    '       <div>\n' +
                    '           <input type="text" name="colName" lay-verify="title" autocomplete="off" class="layui-input" value="' + this.colName + '" oninput="changeInput(this,'+ isChild +')">\n' +
                    '       </div>\n' +
                    '   </div>\n' +
                    '   <div class="layui-form-item">\n' +
                    '       <label class="layui-form-label">可见行数</label>\n' +
                    '       <div>\n' +
                    '           <input type="number" name="colStyle" lay-verify="title" autocomplete="off" class="layui-input" value="' + this.colStyle + '" oninput="changeInput(this,'+ isChild +')">\n' +
                    '       </div>\n' +
                    '   </div>\n' +
                    '   <div class="layui-form-item">\n' +
                    '       <label class="layui-form-label">默认值</label>\n' +
                    '       <div style="margin-top: 10px">\n' +
                    '           <input type="text" name="defaultVal" lay-verify="title" autocomplete="off" class="layui-input" value="'+ this.defaultVal +'" oninput="changeInput(this,'+ isChild +')">\n' +
                    '       </div>\n' +
                    '   </div>\n' +
                    '   <div class="layui-form-item" id="colTips">\n' +
                    '       <label class="layui-form-label">提示语</label>\n' +
                    '       <div>\n' +
                    '           <input type="text" name="inputTips" lay-verify="title" autocomplete="off" class="layui-input" value="' + this.inputTips + '" oninput="changeInput(this,'+ isChild +')">\n' +
                    '       </div>\n' +
                    '   </div>\n' +
                    '   <div class="layui-form-item" id="remarks">\n' +
                    '           <label class="layui-form-label">描述</label>\n' +
                    '       <div>\n' +
                    '           <textarea class="layui-textarea" name="inputDesc" oninput="changeInput(this,'+ isChild +')">' + this.inputDesc + '</textarea>\n' +
                    '       </div>\n' +
                    '   </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height,flag) {
                if(this.flag == flag){
                    return '<div class="layui-form-item  input-enter input-active" style="position: absolute; left: 0px;top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) +'</label>\n' +
                        '       <div style="display: block" class="input-text">\n' +
                        '           <textarea placeholder="请输入" readonly class="layui-textarea"></textarea>\n' +
                        '       </div>\n' +
                        '       <div class="colDelete" style="display: block"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy" style="display: block"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }else{
                    return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px;top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) + '</label>\n' +
                        '       <div style="display: block" class="input-text">\n' +
                        '           <textarea placeholder="请输入" readonly class="layui-textarea"></textarea>\n' +
                        '       </div>\n' +
                        '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }
            }
            obj.createTemplatec = function() {
                return '<div class="layui-form-item ' + (this.flag == (activeCol&&activeCol.temObj.flag)?'input-active':'') + '" data-type="' + this.colType + '" data-flag="' + this.flag + '">\n' +
                    '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) + '</label>\n' +
                    '       <div style="display: block" class="input-text">\n' +
                    '           <textarea placeholder="请输入" readonly class="layui-textarea"></textarea>\n' +
                    '       </div>\n' +
                    '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   </div>'
            }
            obj.template = obj.createTemplate(obj.top,false)

            return obj
            break;
        case 'C03':
            var obj = {
                /*
                *  @colName         控件名称
                *  @colType         控件类型
                *  @colKtype        控件子类型
                *  @defaultVal      默认值
                *  @showFormatOptions  显示格式选项    optionName 选项名称      optionValue 选项值
                *  @inputDesc       描述
                */
                colName:'日期',
                colType:'C03',
                defaultVal:'',
                colKtype:'C0301',
                colStyle:'C030101',
                showFormatOptions:[
                    {optionName:'仅日期',optionValue:'C0301'},
                    {optionName:'仅时间',optionValue:'C0302'},
                    {optionName:'日期+时间',optionValue:'C0303'},
                ],
                showFormatCheck:'0',
                inputDesc:'',
                top:height,
                flag:flag,
            }
            obj.formTem = function(isChild){
                return '<form class="layui-form" id="control-data">\n' +
                    '   <div class="layui-form-item" id="controlName">\n' +
                    '       <div>\n' +
                    '           <span>控件名称</span>\n' +
                    '           <span class="control-remarks">日期</span>\n' +
                    '       </div>\n' +
                    '       <div>\n' +
                    '           <input type="text" name="colName" lay-verify="title" autocomplete="off" class="layui-input" value="' + this.colName + '" oninput="changeInput(this,'+ isChild +')">\n' +
                    '       </div>\n' +
                    '   </div>\n' +
                    '   <div class="layui-form-item">\n' +
                    '       <label class="layui-form-label">默认值</label>\n' +
                    '       <div style="margin-top: 10px">\n' +
                    '           <input type="text" name="defaultVal" lay-verify="title" readonly id="defaultDate" autocomplete="off" class="layui-input" value="'+ this.defaultVal +'" oninput="changeInput(this,'+ isChild +')">\n' +
                    '       </div>\n' +
                    '   </div>\n' +
                    '   <div class="layui-form-item" id="remarks">\n' +
                    '           <label class="layui-form-label">显示格式</label>\n' +
                    '       <div>\n' +
                    '           <select name="colKtype" lay-filter="colKtype">\n' +
                    createOptions(this.showFormatOptions,this.colKtype) +
                    '           </select>\n' +
                    '           <select name="colStyle" lay-filter="colStyle">\n' +
                    createDateOptions(this.colKtype,this.colStyle) +
                    '           </select>\n' +
                    '   </div>\n' +
                    '   </div>\n' +
                    '   <div class="layui-form-item" id="remarks">\n' +
                    '           <label class="layui-form-label">描述</label>\n' +
                    '       <div>\n' +
                    '           <textarea class="layui-textarea" name="inputDesc" oninput="changeInput(this,'+ isChild +')">' + this.inputDesc + '</textarea>\n' +
                    '       </div>\n' +
                    '   </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height,flag) {
                if(this.flag == flag){
                    return '<div class="layui-form-item  input-enter input-active" style="position: absolute; left: 0px; top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) + '</label>\n' +
                        '       <div style="display: block" class="input-text">\n' +
                        '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请选择" class="layui-input">' +
                        '       </div>\n' +
                        '       <div class="colDelete" style="display: block"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy" style="display: block"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }else{
                    return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px; top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) + '</label>\n' +
                        '       <div style="display: block" class="input-text">\n' +
                        '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请选择" class="layui-input">' +
                        '       </div>\n' +
                        '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }
            }
            obj.createTemplatec = function() {
                return '<div class="layui-form-item ' + (this.flag == (activeCol&&activeCol.temObj.flag)?'input-active':'') + '" data-type="' + this.colType + '" data-flag="' + this.flag + '">\n' +
                    '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) + '</label>\n' +
                    '       <div style="display: block" class="input-text">\n' +
                    '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请选择" class="layui-input">' +
                    '       </div>\n' +
                    '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   </div>'
            }
            obj.template = obj.createTemplate(obj.top)
            return obj
            break;
        case 'C04':
            var obj = {
                /*
                *  @colName         控件名称
                *  @colType         控件类型
                *  @colStyle        控件格式
                *  @colKtype        控件子类型
                *  @defaultVal      默认值
                *  @colKtypeOptions 显示格式选项    optionName 选项名称      optionValue 选项值
                *  @inputDesc       描述
                */
                colType:'C04',
                colName:'数字',
                defaultVal:'',
                colKtype:'C0401',
                colKtypeOptions:[
                    {optionName:'普通数值',optionValue:'C0401'},
                    {optionName:'带千分位数值',optionValue:'C0402'},
                    {optionName:'百分比',optionValue:'C0403'},
                ],
                colStyle:'C040100',
                inputDesc:'',
                top:height,
                flag:flag,
            }
            obj.formTem = function(isChild){
                return ' <form class="layui-form" id="control-data">\n' +
                    '       <div class="layui-form-item" id="controlName" >\n' +
                    '           <div>\n' +
                    '               <span>控件名称</span>\n' +
                    '               <span class="control-remarks">数字</span>\n' +
                    '           </div>\n' +
                    '           <div>\n' +
                    '               <input type="text" name="colName" lay-verify="title" autocomplete="off" class="layui-input" value="' + this.colName + '" oninput="changeInput(this,'+ isChild +')">\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item">\n' +
                    '           <label class="layui-form-label">默认值</label>\n' +
                    '           <div>\n' +
                    '               <input type="text" name="defaultVal" data-colKtype="' + this.colKtype + '" data-colStyle="' + this.colStyle + '" lay-verify="title" id="defaultNum" autocomplete="off" class="layui-input" value="' + this.defaultVal + '" oninput="changeInput(this,'+ isChild +')">\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item">\n' +
                    '           <label class="layui-form-label">格式</label>\n' +
                    '           <div>\n' +
                    '               <select name="colKtype" lay-filter="colKtype">\n' +
                    createOptions(this.colKtypeOptions,this.colKtype) +
                    '               </select>\n' +
                    '               <select name="colStyle" lay-filter="colStyle">\n' +
                    createNumberOptions(this.colKtype,this.colStyle) +
                    '               </select>\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item" id="remarks">\n' +
                    '           <label class="layui-form-label">描述</label>\n' +
                    '           <div>\n' +
                    '               <textarea class="layui-textarea" oninput="changeInput(this,'+ isChild +')" name="inputDesc">' + this.inputDesc + '</textarea>\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height,flag){
                if(this.flag == flag){
                    return '<div class="layui-form-item  input-enter input-active" style="position: absolute; left: 0px; top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) + '</label>\n' +
                        '       <div style="display: block" class="input-text">\n' +
                        '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请输入" class="layui-input">\n' +
                        '       </div>\n' +
                        '       <div class="colDelete" style="display: block"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy" style="display: block"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }else{
                    return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px;top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) + '</label>\n' +
                        '       <div style="display: block" class="input-text">\n' +
                        '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请输入" class="layui-input">\n' +
                        '       </div>\n' +
                        '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }
            }
            obj.createTemplatec = function(){
                return '<div class="layui-form-item ' + (this.flag == (activeCol&&activeCol.temObj.flag)?'input-active':'') + '" data-type="' + this.colType + '" data-flag="' + this.flag + '">\n' +
                    '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) + '</label>\n' +
                    '       <div style="display: block" class="input-text">\n' +
                    '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请输入" class="layui-input">\n' +
                    '       </div>\n' +
                    '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   </div>'
            }
            obj.template = obj.createTemplate(obj.top)
            return obj
            break;
        case 'C05':
            var obj = {
                /*
                *  @colType         控件类型标记
                *  @colName         控件名称
                *  @selectOption    选项
                *  @inputDesc       描述
                * */
                colType:'C05',
                colName:'单选框',
                selectOption:[
                    {option:'选项1',checked:true,value:1},
                    {option:'选项2',checked:false,value:2},
                    {option:'选项3',checked:false,value:3},
                ],
                inputDesc:'',
                top:height,
                flag:flag,
            }
            obj.formTem = function(isChild){
                return '<form class="layui-form" id="control-data">\n' +
                    '   <div class="layui-form-item" id="controlName">\n' +
                    '       <div>\n' +
                    '           <span>控件名称</span>\n' +
                    '           <span class="control-remarks">单选框</span>\n' +
                    '       </div>\n' +
                    '       <div>\n' +
                    '           <input type="text" name="colName" lay-verify="colName" autocomplete="off" class="layui-input" value="' + this.colName + '" oninput="changeInput(this,'+ isChild +')">\n' +
                    '       </div>\n' +
                    '   </div>\n' +
                    '   <div class="layui-form-item" >\n' +
                    '       <div>\n' +
                    '           <span>选项</span>\n' +
                    '       </div>\n' +
                    '       <div style="padding-bottom: 10px">\n' +
                    JSONRadiosData(this.selectOption,0,isChild) +
                    '       </div>\n' +
                    '       <span style="color: #0aa3e3;cursor:pointer;" onclick="addRadio(' + isChild + ')">添加选项</span>' +
                    '   </div>\n' +
                    '   <div class="layui-form-item" id="remarks">\n' +
                    '           <label class="layui-form-label">描述</label>\n' +
                    '       <div>\n' +
                    '           <textarea class="layui-textarea" name="inputDesc" oninput="changeInput(this,'+ isChild +')">' + this.inputDesc + '</textarea>\n' +
                    '       </div>\n' +
                    '   </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height,flag) {
                if(this.flag == flag){
                    return '<div class="layui-form-item  input-enter input-active" style="position: absolute; left: 0px; top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) + '</label>\n' +
                        '       <div style="display: block" class="input-text radio-line-block">\n' +
                        JSONRadiosData(this.selectOption,1) +
                        '       </div>\n' +
                        '       <div class="colDelete" style="display: block"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy" style="display: block"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }else{
                    return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px;top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) +'</label>\n' +
                        '       <div style="display: block" class="input-text radio-line-block">\n' +
                        JSONRadiosData(this.selectOption,1) +
                        '       </div>\n' +
                        '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }
            }
            obj.createTemplatec = function() {
                return '<div class="layui-form-item ' + (this.flag == (activeCol&&activeCol.temObj.flag)?'input-active':'') + '" style="text-align: left" data-type="' + this.colType + '" data-flag="' + this.flag + '">\n' +
                    '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) +'</label>\n' +
                    '       <div style="display: block" class="input-text radio-line-block">\n' +
                    JSONRadiosData(this.selectOption,1) +
                    '       </div>\n' +
                    '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   </div>'
            }
            obj.template = obj.createTemplate(obj.top)
            return obj
            break;
        case 'C06':
            var obj = {
                /*
                *  @colName         控件名称
                *  @colType         控件类型
                *  @selectOption    选项
                *  @inputDesc       描述
                * */
                colType:'C06',
                colName:'复选框',
                selectOption:[
                    {option:'选项1',checked:true,value:1},
                    {option:'选项2',checked:false,value:2},
                    {option:'选项3',checked:false,value:3},
                ],
                inputDesc:'',
                top:height,
                flag:flag,
            }
            obj.formTem = function(isChild){
                return '<form class="layui-form" id="control-data">\n' +
                    '   <div class="layui-form-item" id="controlName">\n' +
                    '       <div>\n' +
                    '           <span>控件名称</span>\n' +
                    '           <span class="control-remarks">复选框</span>\n' +
                    '       </div>\n' +
                    '       <div>\n' +
                    '           <input type="text" name="colName" autocomplete="off" class="layui-input" value="' + this.colName + '" oninput="changeInput(this,'+ isChild +')">\n' +
                    '       </div>\n' +
                    '   </div>\n' +
                    '   <div class="layui-form-item" >\n' +
                    '       <div>\n' +
                    '           <span>选项</span>\n' +
                    '       </div>\n' +
                    '       <div>\n' +
                    JSONcheckboxData(this.selectOption,0,isChild) +
                    '       </div>\n' +
                    '       <span style="color: #0aa3e3;cursor:pointer;" onclick="addRadio('+ isChild +')">添加选项</span>' +
                    '   </div>\n' +
                    '   <div class="layui-form-item" id="remarks">\n' +
                    '           <label class="layui-form-label">描述</label>\n' +
                    '       <div>\n' +
                    '           <textarea class="layui-textarea" oninput="changeInput(this,'+ isChild +')" name="inputDesc">' + this.inputDesc + '</textarea>\n' +
                    '       </div>\n' +
                    '   </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height,flag) {
                if(this.flag == flag){
                    return '<div class="layui-form-item  input-enter input-active" style="position: absolute; left: 0px; top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) +'</label>\n' +
                        '       <div style="display: block" class="input-text check-line-block">' +
                        JSONcheckboxData(this.selectOption,1) +
                        '       </div>\n' +
                        '       <div class="colDelete" style="display: block"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy" style="display: block"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }else{
                    return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px;top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) +'</label>\n' +
                        '           <div style="display: block" class="input-text check-line-block">' +
                        JSONcheckboxData(this.selectOption,1) +
                        '       </div>\n' +
                        '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }
            }
            obj.createTemplatec = function() {
                return '<div class="layui-form-item ' + (this.flag ==  (activeCol&&activeCol.temObj.flag)?'input-active':'') + '" style="text-align: left" data-type="' + this.colType + '" data-flag="' + this.flag + '">\n' +
                    '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) +'</label>\n' +
                    '           <div style="display: block" class="input-text check-line-block">' +
                    JSONcheckboxData(this.selectOption,1) +
                    '       </div>\n' +
                    '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   </div>'
            }
            obj.template = obj.createTemplate(obj.top)
            return obj
            break;
        case 'C07':
            var obj = {
                /*
                *  @colType         控件类型
                *  @colName         控件名称
                *  @selectOption    选项      radioName 下拉框信息
                *  @inputDesc       描述
                * */
                colType:'C07',
                colName:'下拉框',
                selectOption:[
                    {option:'选项1',checked:true,value:1},
                    {option:'选项2',checked:false,value:2},
                    {option:'选项3',checked:false,value:3},
                ],
                inputDesc:'',
                top:height,
                flag:flag,
            }
            obj.formTem = function(isChild){
                return '<form class="layui-form" id="control-data">\n' +
                    '   <div class="layui-form-item" id="controlName">\n' +
                    '       <div>\n' +
                    '           <span>控件名称</span>\n' +
                    '           <span class="control-remarks">下拉框</span>\n' +
                    '       </div>\n' +
                    '       <div>\n' +
                    '           <input type="text" name="colName" lay-verify="title" autocomplete="off" class="layui-input" value="' + this.colName + '" oninput="changeInput(this,'+ isChild +')">\n' +
                    '       </div>\n' +
                    '   </div>\n' +
                    '   <div class="layui-form-item" >\n' +
                    '       <div>\n' +
                    '           <span>选项</span>\n' +
                    '       </div>\n' +
                    '       <div>\n' +
                    JSONRadiosData(this.selectOption,0,isChild) +
                    '       </div>\n' +
                    '       <span style="color: #0aa3e3;cursor:pointer;" onclick="addRadio('+ isChild +')">添加选项</span>' +
                    '   </div>\n' +
                    '   <div class="layui-form-item" id="remarks">\n' +
                    '           <label class="layui-form-label">描述</label>\n' +
                    '       <div>\n' +
                    '           <textarea class="layui-textarea" oninput="changeInput(this,'+ isChild +')" name="inputDesc">' + this.inputDesc + '</textarea>\n' +
                    '       </div>\n' +
                    '   </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height,flag) {
                if(this.flag == flag){
                    return '<div class="layui-form-item  input-enter input-active" style="position: absolute; left: 0px; top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) + '</label>\n' +
                        '       <div style="display: block" class="input-text check-line-block">' +
                        '<input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请选择" class="layui-input">\n' +
                        '       </div>\n' +
                        '       <div class="colDelete" style="display: block"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy" style="display: block"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }else{
                    return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px;top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) + '</label>\n' +
                        '       <div style="display: block" class="input-text check-line-block">' +
                        '<input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请选择" class="layui-input">\n' +
                        '       </div>\n' +
                        '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }
            }
            obj.createTemplatec = function() {
                return '<div class="layui-form-item ' + (this.flag == (activeCol&&activeCol.temObj.flag)?'input-active':'') + '" data-type="' + this.colType + '" data-flag="' + this.flag + '">\n' +
                    '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) + '</label>\n' +
                    '           <div style="display: block" class="input-text check-line-block">' +
                    '<input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请选择" class="layui-input">\n' +
                    '       </div>\n' +
                    '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   </div>'
            }
            obj.template = obj.createTemplate(obj.top)
            return obj
            break;
        case 'C08':
            var obj = {
                /*
                *  @colType         控件类型标记
                *  @colName         控件名称
                *  @fileSizeOptions 文件限制大小  optionName选项名    optionValue选项值
                *  @colStyle        控件格式
                * */
                colType:'C08',
                colName:'附件',
                fileSizeOptions:[
                    {optionName:'1MB',optionValue:'1'},
                    {optionName:'5MB',optionValue:'5'},
                    {optionName:'10MB',optionValue:'10'},
                    {optionName:'50MB',optionValue:'50'},
                ],
                colStyle:'1',
                top:height,
                flag:flag,
            }
            obj.formTem = function(isChild){
                return '<form class="layui-form" id="control-data">\n' +
                    '   <div class="layui-form-item" id="controlName">\n' +
                    '       <div>\n' +
                    '           <span>控件名称</span>\n' +
                    '           <span class="control-remarks">附件</span>\n' +
                    '       </div>\n' +
                    '       <div>\n' +
                    '           <input type="text" name="colName" lay-verify="title" autocomplete="off" class="layui-input" value="' + this.colName + '" oninput="changeInput(this,'+ isChild +')">\n' +
                    '       </div>\n' +
                    '   </div>\n' +
                    '   <div class="layui-form-item">\n' +
                    '       <div>\n' +
                    '           <span>选项</span>\n' +
                    '       </div>\n' +
                    '       <div>\n' +
                    '           <select name="colStyle" lay-filter="colStyle">\n' +
                    createOptions(this.fileSizeOptions,this.colStyle) +
                    '           </select>\n' +
                    '       </div>\n' +
                    '   </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height,flag) {
                if(this.flag == flag){
                    return '<div class="layui-form-item  input-enter input-active" style="position: absolute; left: 0px; top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                        '       <div style="display: block" class="input-text check-line-block">' +
                        '           <button type="button" class="layui-btn" disabled>\n' +
                        '               <i class="layui-icon">&#xe67c;</i>上传文件\n' +
                        '           </button>\n' +
                        '       </div>\n' +
                        '       <div class="colDelete" style="display: block"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy" style="display: block"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }else{
                    return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px;top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                        '       <div style="display: block" class="input-text check-line-block">' +
                        '           <button type="button" class="layui-btn" disabled>\n' +
                        '               <i class="layui-icon">&#xe67c;</i>上传文件\n' +
                        '           </button>\n' +
                        '       </div>\n' +
                        '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }
            }
            obj.createTemplatec = function() {
                return '<div class="layui-form-item ' + (this.flag == (activeCol&&activeCol.temObj.flag)?'input-active':'') + '" style="text-align: left" data-type="' + this.colType + '" data-flag="' + this.flag + '">\n' +
                    '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                    '       <div style="display: block" class="input-text check-line-block">' +
                    '           <button type="button" class="layui-btn" disabled>\n' +
                    '               <i class="layui-icon">&#xe67c;</i>上传文件\n' +
                    '           </button>\n' +
                    '       </div>\n' +
                    '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   </div>'
            }
            obj.template = obj.createTemplate(obj.top)
            return obj
            break;
        case 'C09':
            var obj = {
                /*
                *  @colType         控件类型
                *  @controlName     控件名称
                * */
                colType:'C09',
                colName:'图片',
                colStyle:[0,0,0,0],
                top:height,
                flag:flag,
            }
            obj.formTem = function(isChild){
                return '<form class="layui-form" id="control-data">\n' +
                    '   <div class="layui-form-item" id="controlName">\n' +
                    '       <div>\n' +
                    '           <span>控件名称</span>\n' +
                    '           <span class="control-remarks">' + this.colName + '</span>\n' +
                    '       </div>\n' +
                    '       <div>\n' +
                    '           <input type="text" name="colName" lay-verify="title" autocomplete="off" class="layui-input" value="' + this.colName + '" oninput="changeInput(this,'+ isChild +')">\n' +
                    '       </div>\n' +
                    '   </div>\n' +
                    // '   <div class="layui-form-item" id="switch">\n' +
                    // '       <div>\n' +
                    // '           <span>选项</span>\n' +
                    // '       </div>\n' +
                    // '       <div>\n' +
                    // pictureCheckbox(this.colStyle) +
                    // '       </div>\n' +
                    // '   </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height,flag) {
                if(this.flag == flag){
                    return '<div class="layui-form-item  input-enter input-active" style="position: absolute; left: 0px; top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                        '       <div style="display: block" class="input-text check-line-block">' +
                        '           <button type="button" class="layui-btn" disabled>\n' +
                        '               <i class="layui-icon">&#xe67c;</i>上传图片\n' +
                        '           </button>\n' +
                        '       </div>\n' +
                        '       <div class="colDelete" style="display: block"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy" style="display: block"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }else{
                    return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px;top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                        '       <div style="display: block" class="input-text check-line-block">' +
                        '           <button type="button" class="layui-btn" disabled>\n' +
                        '               <i class="layui-icon">&#xe67c;</i>上传图片\n' +
                        '           </button>\n' +
                        '       </div>\n' +
                        '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }
            }
            obj.createTemplatec = function(height,flag) {
                return '<div class="layui-form-item ' + (this.flag == (activeCol&&activeCol.temObj.flag)?'input-active':'') + '" style="text-align: left" data-type="' + this.colType + '" data-flag="' + this.flag + '">\n' +
                    '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                    '       <div style="display: block" class="input-text check-line-block">' +
                    '           <button type="button" class="layui-btn" disabled>\n' +
                    '               <i class="layui-icon">&#xe67c;</i>上传图片\n' +
                    '           </button>\n' +
                    '       </div>\n' +
                    '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   </div>'
            }
            obj.template = obj.createTemplate(obj.top)
            return obj
            break;

        case 'S01':
            var obj = {
                /*
                *  @colType         控件类型
                *  @controlName     控件名称
                * */
                colType:'S01',
                colName:'创建人',
                top:height,
                flag:flag,
            }
            obj.formTem = function(isChild){
                return '<form class="layui-form" id="control-data">\n' +
                    // '   <div class="layui-form-item" id="controlName">\n' +
                    // '       <div>\n' +
                    // '           <span>控件名称</span>\n' +
                    // '           <span class="control-remarks">' + this.colName + '</span>\n' +
                    // '       </div>\n' +
                    // '       <div>\n' +
                    // '           <input type="text" name="colName" lay-verify="title" autocomplete="off" class="layui-input" value="' + this.colName + '" oninput="changeInput(this,'+ isChild +')">\n' +
                    // '       </div>\n' +
                    // '   </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height,flag) {
                if(this.flag == flag){
                    return '<div class="layui-form-item  input-enter input-active" style="position: absolute; left: 0px; top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                        '       <div style="display: block;color: #888888;" class="input-text check-line-block">系统自动生成</div>\n' +
                        '       <div class="colDelete" style="display: block"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '   </div>'
                }else{
                    return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px;top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                        '       <div style="display: block;color: #888888" class="input-text check-line-block">系统自动生成</div>\n' +
                        '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '   </div>'
                }
            }
            obj.createTemplatec = function() {
                return '<div class="layui-form-item ' + (this.flag == (activeCol&&activeCol.temObj.flag)?'input-active':'') + '" data-type="' + this.colType + '" data-flag="' + this.flag + '">\n' +
                    '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                    '       <div style="display: block;color: #888888;height: 40px;line-height: 40px" class="input-text check-line-block">系统自动生成</div>\n' +
                    '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   </div>'
            }
            obj.template = obj.createTemplate(obj.top)
            return obj
            break;
        case 'S02':
            var obj = {
                /*
                *  @colType         控件类型
                *  @controlName     控件名称
                * */
                colType:'S02',
                colName:'创建时间',
                top:height,
                flag:flag,
            }
            obj.formTem = function(isChild){
                return '<form class="layui-form" id="control-data">\n' +
                    // '   <div class="layui-form-item" id="controlName">\n' +
                    // '       <div>\n' +
                    // '           <span>控件名称</span>\n' +
                    // '           <span class="control-remarks">' + this.colName + '</span>\n' +
                    // '       </div>\n' +
                    // '       <div>\n' +
                    // '           <input type="text" name="colName" lay-verify="title" autocomplete="off" class="layui-input" value="' + this.colName + '" oninput="changeInput(this,'+ isChild +')">\n' +
                    // '       </div>\n' +
                    // '   </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height,flag) {
                if(this.flag == flag){
                    return '<div class="layui-form-item  input-enter input-active" style="position: absolute; left: 0px; top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                        '       <div style="display: block;color: #888888" class="input-text check-line-block">系统自动生成</div>\n' +
                        '       <div class="colDelete" style="display: block"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '   </div>'
                }else{
                    return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px;top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                        '       <div style="display: block;color: #888888" class="input-text check-line-block">系统自动生成</div>\n' +
                        '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '   </div>'
                }
            }
            obj.createTemplatec = function() {
                return '<div class="layui-form-item ' + (this.flag == (activeCol&&activeCol.temObj.flag)?'input-active':'') + '" data-type="' + this.colType + '" data-flag="' + this.flag + '">\n' +
                    '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                    '       <div style="display: block;color: #888888;height: 40px;line-height: 40px" class="input-text check-line-block">系统自动生成</div>\n' +
                    '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   </div>'
            }
            obj.template = obj.createTemplate(obj.top)
            return obj
            break;
        case 'S03':
            var obj = {
                /*
                *  @colType         控件类型
                *  @controlName     控件名称
                * */
                colType:'S03',
                colName:'修改时间',
                top:height,
                flag:flag,
            }
            obj.formTem = function(isChild){
                return '<form class="layui-form" id="control-data">\n' +
                    // '   <div class="layui-form-item" id="controlName">\n' +
                    // '       <div>\n' +
                    // '           <span>控件名称</span>\n' +
                    // '           <span class="control-remarks">' + this.colName + '</span>\n' +
                    // '       </div>\n' +
                    // '       <div>\n' +
                    // '           <input type="text" name="colName" lay-verify="title" autocomplete="off" class="layui-input" value="' + this.colName + '" oninput="changeInput(this,'+ isChild +')">\n' +
                    // '       </div>\n' +
                    // '   </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height,flag) {
                if(this.flag == flag){
                    return '<div class="layui-form-item  input-enter input-active" style="position: absolute; left: 0px; top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                        '       <div style="display: block;color: #888888" class="input-text check-line-block">系统自动生成</div>\n' +
                        '       <div class="colDelete" style="display: block"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '   </div>'
                }else{
                    return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px;top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                        '       <div style="display: block;color: #888888" class="input-text check-line-block">系统自动生成</div>\n' +
                        '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '   </div>'
                }
            }
            obj.createTemplatec = function() {
                return '<div class="layui-form-item ' + (this.flag == (activeCol&&activeCol.temObj.flag)?'input-active':'') + '" data-type="' + this.colType + '" data-flag="' + this.flag + '">\n' +
                    '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                    '       <div style="display: block;color: #888888;height: 40px;line-height: 40px" class="input-text check-line-block">系统自动生成</div>\n' +
                    '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   </div>'
            }
            obj.template = obj.createTemplate(obj.top)
            return obj
            break;
        case 'S04':
            var obj = {
                /*
                *  @colType         控件类型
                *  @controlName     控件名称
                * */
                colType:'S04',
                colName:'拥有者',
                top:height,
                flag:flag,
            }
            obj.formTem = function(isChild){
                return '<form class="layui-form" id="control-data">\n' +
                    // '   <div class="layui-form-item" id="controlName">\n' +
                    // '       <div>\n' +
                    // '           <span>控件名称</span>\n' +
                    // '           <span class="control-remarks">' + this.colName + '</span>\n' +
                    // '       </div>\n' +
                    // '       <div>\n' +
                    // '           <input type="text" name="colName" lay-verify="title" autocomplete="off" class="layui-input" value="' + this.colName + '" oninput="changeInput(this,'+ isChild +')">\n' +
                    // '       </div>\n' +
                    // '   </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height,flag) {
                if(this.flag == flag){
                    return '<div class="layui-form-item  input-enter input-active" style="position: absolute; left: 0px; top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                        '       <div style="display: block" class="input-text">\n' +
                        '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请选择" class="layui-input">\n' +
                        '       </div>\n' +
                        '       <div class="colDelete" style="display: block"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '   </div>'
                }else{
                    return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px;top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                        '       <div style="display: block" class="input-text">\n' +
                        '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请选择" class="layui-input">\n' +
                        '       </div>\n' +
                        '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '   </div>'
                }
            }
            obj.createTemplatec = function() {
                return '<div class="layui-form-item ' + (this.flag == (activeCol&&activeCol.temObj.flag)?'input-active':'') + '" data-type="' + this.colType + '" data-flag="' + this.flag + '">\n' +
                    '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                    '       <div style="display: block" class="input-text">\n' +
                    '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请选择" class="layui-input">\n' +
                    '       </div>\n' +
                    '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   </div>'
            }
            obj.template = obj.createTemplate(obj.top)
            return obj
            break;
        case 'S05':
            var obj = {
                /*
                *  @colType         控件类型
                *  @controlName     控件名称
                * */
                colType:'S05',
                colName:'所属部门',
                top:height,
                flag:flag,
            }
            obj.formTem = function(isChild){
                return '<form class="layui-form" id="control-data">\n' +
                    // '   <div class="layui-form-item" id="controlName">\n' +
                    // '       <div>\n' +
                    // '           <span>控件名称</span>\n' +
                    // '           <span class="control-remarks">' + this.colName + '</span>\n' +
                    // '       </div>\n' +
                    // '       <div>\n' +
                    // '           <input type="text" name="colName" lay-verify="title" autocomplete="off" class="layui-input" value="' + this.colName + '" oninput="changeInput(this,'+ isChild +')">\n' +
                    // '       </div>\n' +
                    // '   </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height,flag) {
                if(this.flag == flag){
                    return '<div class="layui-form-item  input-enter input-active" style="position: absolute; left: 0px; top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                        '       <div style="display: block" class="input-text">\n' +
                        '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请输入" class="layui-input">\n' +
                        '       </div>\n' +
                        '       <div class="colDelete" style="display: block"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '   </div>'
                }else{
                    return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px;top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                        '       <div style="display: block" class="input-text">\n' +
                        '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请选择" class="layui-input">\n' +
                        '       </div>\n' +
                        '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '   </div>'
                }
            }
            obj.createTemplatec = function(height,flag) {
                return '<div class="layui-form-item ' + (this.flag == (activeCol&&activeCol.temObj.flag)?'input-active':'') + '" data-type="' + this.colType + '" data-flag="' + this.flag + '">\n' +
                    '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                    '       <div style="display: block" class="input-text">\n' +
                    '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请选择" class="layui-input">\n' +
                    '       </div>\n' +
                    '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   </div>'
            }
            obj.template = obj.createTemplate(obj.top)
            return obj
            break;
        case 'S06':
            var obj = {
                /*
                *  @colType         控件类型
                *  @controlName     控件名称
                * */
                colType:'S06',
                colName:'流水号',
                top:height,
                flag:flag,
            }
            obj.formTem = function(isChild){
                return '<form class="layui-form" id="control-data">\n' +
                    '   <div class="layui-form-item" id="controlName">\n' +
                    '       <div>\n' +
                    '           <span>控件名称</span>\n' +
                    '           <span class="control-remarks">' + this.colName + '</span>\n' +
                    '       </div>\n' +
                    '       <div>\n' +
                    '           <input type="text" name="colName" lay-verify="title" autocomplete="off" class="layui-input" value="' + this.colName + '" oninput="changeInput(this,'+ isChild +')">\n' +
                    '       </div>\n' +
                    '   </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height,flag) {
                if(this.flag == flag){
                    return '<div class="layui-form-item  input-enter input-active" style="position: absolute; left: 0px; top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                        '       <div style="display: block" class="input-text">\n' +
                        '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="流水号自动生成，不允许录入" class="layui-input">\n' +
                        '       </div>\n' +
                        '       <div class="colDelete" style="display: block"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '   </div>'
                }else{
                    return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px;top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                        '       <div style="display: block" class="input-text">\n' +
                        '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="流水号自动生成，不允许录入" class="layui-input">\n' +
                        '       </div>\n' +
                        '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '   </div>'
                }
            }
            obj.createTemplatec = function() {
                return '<div class="layui-form-item ' + (this.flag == (activeCol&&activeCol.temObj.flag)?'input-active':'') + '" data-type="' + this.colType + '" data-flag="' + this.flag + '">\n' +
                    '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                    '       <div style="display: block" class="input-text">\n' +
                    '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="流水号自动生成，不允许录入" class="layui-input">\n' +
                    '       </div>\n' +
                    '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   </div>'
            }
            obj.template = obj.createTemplate(obj.top)
            return obj
            break;

        case 'rydanx':
            var obj = {
                /*
                *  @type            控件类型标记
                *  @controlName     控件名称
                *  @controlType     控件类型
                *  @hide            隐藏条件
                *  @defaultValue    默认值
                *  @defaultOption   默认选项    optionName 选项名称      optionValue 选项值
                *  @defaultOptionDetail  默认值配置详情
                *  @formatOptions   格式选项     optionName 选项名称      optionValue 选项值
                *  @defaultFormat   默认格式选项
                *  @scanCode        允许扫码输入
                *  @changeScan      可修改扫码结果
                *  @repeat          校验-不允许重复录入
                *  @tips            提示语
                *  @describe        描述
                *  @top             该控件定位的top值
                *  @flag            每个控件的唯一标识
                */
                type:'rydanx',
                controlName:'人员单选',
                controlType:'人员单选',
                hide:'',
                defaultValue:'0',
                defaultOption:[
                    {optionName:'固定值',optionValue:'0'},
                    {optionName:'数据联动',optionValue:'1'},
                ],
                defaultOptionDetail:'',
                radioList:[
                    {radioName:'允许',checked:false},
                    {radioName:'不允许',checked:true},
                ],
                infoList:[
                    {optionsName:'部门',defaultValue:0,selectOption:[
                            {optionName:'当前表单控件',optionValue:0}
                        ]},
                    {optionsName:'性别',defaultValue:0,selectOption:[
                            {optionName:'当前表单控件',optionValue:0},
                            {optionName:'单行文本',optionValue:1},
                        ]},
                    {optionsName:'邮件',defaultValue:0,selectOption:[
                            {optionName:'当前表单控件',optionValue:0},
                            {optionName:'单行文本',optionValue:1},
                        ]},
                    {optionsName:'手机',defaultValue:0,selectOption:[
                            {optionName:'当前表单控件',optionValue:0},
                            {optionName:'单行文本',optionValue:1},
                        ]},
                ],
                defaultFormat:'0',
                tips:'',
                describe:'',
                top:height,
                flag:flag,
            }
            obj.formTem = function(){
                return ' <form class="layui-form" id="control-data">\n' +
                    '       <div class="layui-form-item" id="controlName" >\n' +
                    '           <div>\n' +
                    '               <span>控件名称</span>\n' +
                    '               <span class="control-remarks">' + this.controlType + '</span>\n' +
                    '           </div>\n' +
                    '           <div>\n' +
                    '               <input type="text" name="title" lay-verify="title" autocomplete="off" class="layui-input">\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item" id="hide">\n' +
                    '           <div>\n' +
                    '               <span>隐藏条件</span>\n' +
                    '               <span class="hide-remarks">当满足以下条件时此控件隐藏</span>\n' +
                    '           </div>\n' +
                    '           <div>\n' +
                    '               <input type="text" name="title" lay-verify="title" autocomplete="off" class="layui-input" readonly value="' + this.hide + '">\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item">\n' +
                    '           <label class="layui-form-label">默认值</label>\n' +
                    '           <div>\n' +
                    '               <select name="group" lay-filter="group">\n' +
                    createOptions(this.defaultOption,this.defaultValue) +
                    '               </select>\n' +
                    '           </div>\n' +
                    '           <div style="margin-top: 10px">\n' +
                    '               <input type="text" name="title" lay-verify="title" autocomplete="off" class="layui-input" readonly value="'+ this.defaultOptionDetail +'">\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item">\n' +
                    '           <label class="layui-form-label" style="width: 100%">仅以下人员可被选择</label>\n' +
                    '           <div>\n' +
                    '               <input type="text" name="title" lay-verify="title" autocomplete="off" class="layui-input" readonly value="' + this.hide + '">\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item" id="infoFill">\n' +
                    '           <label class="layui-form-label" style="width: 100%">人员信息填充</label>\n' +
                    '           <div>\n' +
                    createInfo(this.infoList) +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item">\n' +
                    '           <label class="layui-form-label">校验</label>\n' +
                    '           <div>\n' +
                    createRadios(this.radioList,2) +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item" id="remarks">\n' +
                    '           <label class="layui-form-label">描述</label>\n' +
                    '           <div>\n' +
                    '               <textarea class="layui-textarea">' + this.describe + '</textarea>\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height){
                return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px; top: 0px;top:' + height + 'px" data-flag="' + flag + '">\n' +
                    '       <label class="layui-form-label">' + this.controlType +'</label>\n' +
                    '       <div style="display: block" class="input-text">\n' +
                    '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请输入" class="layui-input">\n' +
                    '       </div>\n' +
                    '   </div>'
            }
            obj.template = obj.createTemplate(obj.top)
            return obj
            break;
        case 'ryduox':
            var obj = {
                /*
                *  @type            控件类型标记
                *  @controlName     控件名称
                *  @controlType     控件类型
                *  @hide            隐藏条件
                *  @defaultValue    默认值
                *  @defaultOption   默认选项    optionName 选项名称      optionValue 选项值
                *  @defaultOptionDetail  默认值配置详情
                *  @formatOptions   格式选项     optionName 选项名称      optionValue 选项值
                *  @defaultFormat   默认格式选项
                *  @scanCode        允许扫码输入
                *  @changeScan      可修改扫码结果
                *  @repeat          校验-不允许重复录入
                *  @tips            提示语
                *  @describe        描述
                *  @top             该控件定位的top值
                *  @flag            每个控件的唯一标识
                */
                type:'ryduox',
                controlName:'人员多选',
                controlType:'人员多选',
                hide:'',
                defaultValue:'0',
                defaultOption:[
                    {optionName:'固定值',optionValue:'0'},
                    {optionName:'数据联动',optionValue:'1'},
                ],
                defaultOptionDetail:'',
                radioList:[
                    {radioName:'允许',checked:false},
                    {radioName:'不允许',checked:true},
                ],
                defaultFormat:'0',
                tips:'',
                describe:'',
                top:height,
                flag:flag,
            }
            obj.formTem = function(){
                return ' <form class="layui-form" id="control-data">\n' +
                    '       <div class="layui-form-item" id="controlName" >\n' +
                    '           <div>\n' +
                    '               <span>控件名称</span>\n' +
                    '               <span class="control-remarks">' + this.controlType + '</span>\n' +
                    '           </div>\n' +
                    '           <div>\n' +
                    '               <input type="text" name="title" lay-verify="title" autocomplete="off" class="layui-input">\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item" id="hide">\n' +
                    '           <div>\n' +
                    '               <span>隐藏条件</span>\n' +
                    '               <span class="hide-remarks">当满足以下条件时此控件隐藏</span>\n' +
                    '           </div>\n' +
                    '           <div>\n' +
                    '               <input type="text" name="title" lay-verify="title" autocomplete="off" class="layui-input" readonly value="' + this.hide + '">\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item">\n' +
                    '           <label class="layui-form-label">默认值</label>\n' +
                    '           <div>\n' +
                    '               <select name="group" lay-filter="group">\n' +
                    createOptions(this.defaultOption,this.defaultValue) +
                    '               </select>\n' +
                    '           </div>\n' +
                    '           <div style="margin-top: 10px">\n' +
                    '               <input type="text" name="title" lay-verify="title" autocomplete="off" class="layui-input" readonly value="'+ this.defaultOptionDetail +'">\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item">\n' +
                    '           <label class="layui-form-label" style="width: 100%">仅以下人员可被选择</label>\n' +
                    '           <div>\n' +
                    '               <input type="text" name="title" lay-verify="title" autocomplete="off" class="layui-input" readonly value="' + this.hide + '">\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item">\n' +
                    '           <label class="layui-form-label">校验</label>\n' +
                    '           <div>\n' +
                    createRadios(this.radioList,2) +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item" id="remarks">\n' +
                    '           <label class="layui-form-label">描述</label>\n' +
                    '           <div>\n' +
                    '               <textarea class="layui-textarea">' + this.describe + '</textarea>\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height){
                return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px; top: 0px;top:' + height + 'px" data-flag="' + flag + '">\n' +
                    '       <label class="layui-form-label">' + this.controlType +'</label>\n' +
                    '       <div style="display: block" class="input-text">\n' +
                    '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请输入" class="layui-input">\n' +
                    '       </div>\n' +
                    '   </div>'
            }
            obj.template = obj.createTemplate(obj.top)
            return obj
            break;
        case 'bmdanx':
            var obj = {
                /*
                *  @type            控件类型标记
                *  @controlName     控件名称
                *  @controlType     控件类型
                *  @hide            隐藏条件
                *  @defaultValue    默认值
                *  @defaultOption   默认选项    optionName 选项名称      optionValue 选项值
                *  @defaultOptionDetail  默认值配置详情
                *  @formatOptions   格式选项     optionName 选项名称      optionValue 选项值
                *  @defaultFormat   默认格式选项
                *  @scanCode        允许扫码输入
                *  @changeScan      可修改扫码结果
                *  @repeat          校验-不允许重复录入
                *  @tips            提示语
                *  @describe        描述
                *  @top             该控件定位的top值
                *  @flag            每个控件的唯一标识
                */
                type:'bmdanx',
                controlName:'部门单选',
                controlType:'部门单选',
                hide:'',
                defaultValue:'0',
                defaultOption:[
                    {optionName:'固定值',optionValue:'0'},
                    {optionName:'数据联动',optionValue:'1'},
                ],
                defaultOptionDetail:'',
                defaultFormat:'0',
                tips:'',
                describe:'',
                top:height,
                flag:flag,
            }
            obj.formTem = function(){
                return ' <form class="layui-form" id="control-data">\n' +
                    '       <div class="layui-form-item" id="controlName" >\n' +
                    '           <div>\n' +
                    '               <span>控件名称</span>\n' +
                    '               <span class="control-remarks">' + this.controlType + '</span>\n' +
                    '           </div>\n' +
                    '           <div>\n' +
                    '               <input type="text" name="title" lay-verify="title" autocomplete="off" class="layui-input" value="' + this.controlName + '">\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item" id="hide">\n' +
                    '           <div>\n' +
                    '               <span>隐藏条件</span>\n' +
                    '               <span class="hide-remarks">当满足以下条件时此控件隐藏</span>\n' +
                    '           </div>\n' +
                    '           <div>\n' +
                    '               <input type="text" name="title" lay-verify="title" autocomplete="off" class="layui-input" readonly value="' + this.hide + '">\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item">\n' +
                    '           <label class="layui-form-label">默认值</label>\n' +
                    '           <div>\n' +
                    '               <select name="group" lay-filter="group">\n' +
                    createOptions(this.defaultOption,this.defaultValue) +
                    '               </select>\n' +
                    '           </div>\n' +
                    '           <div style="margin-top: 10px">\n' +
                    '               <input type="text" name="title" lay-verify="title" autocomplete="off" class="layui-input" readonly value="'+ this.defaultOptionDetail +'">\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item">\n' +
                    '           <label class="layui-form-label" style="width: 100%">仅以下人员可被选择</label>\n' +
                    '           <div>\n' +
                    '               <input type="text" name="title" lay-verify="title" autocomplete="off" class="layui-input" readonly value="' + this.hide + '">\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item" id="remarks">\n' +
                    '           <label class="layui-form-label">描述</label>\n' +
                    '           <div>\n' +
                    '               <textarea class="layui-textarea">' + this.describe + '</textarea>\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height){
                return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px; top: 0px;top:' + height + 'px" data-flag="' + flag + '">\n' +
                    '       <label class="layui-form-label">' + this.controlType +'</label>\n' +
                    '       <div style="display: block" class="input-text">\n' +
                    '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请输入" class="layui-input">\n' +
                    '       </div>\n' +
                    '   </div>'
            }
            obj.template = obj.createTemplate(obj.top)
            return obj
            break;
        case 'bmduox':
            var obj = {
                /*
                *  @type            控件类型标记
                *  @controlName     控件名称
                *  @controlType     控件类型
                *  @hide            隐藏条件
                *  @defaultValue    默认值
                *  @defaultOption   默认选项    optionName 选项名称      optionValue 选项值
                *  @defaultOptionDetail  默认值配置详情
                *  @formatOptions   格式选项     optionName 选项名称      optionValue 选项值
                *  @defaultFormat   默认格式选项
                *  @scanCode        允许扫码输入
                *  @changeScan      可修改扫码结果
                *  @repeat          校验-不允许重复录入
                *  @tips            提示语
                *  @describe        描述
                *  @top             该控件定位的top值
                *  @flag            每个控件的唯一标识
                */
                type:'bmduox',
                controlName:'部门多选',
                controlType:'部门多选',
                hide:'',
                defaultValue:'0',
                defaultOption:[
                    {optionName:'固定值',optionValue:'0'},
                    {optionName:'数据联动',optionValue:'1'},
                ],
                defaultOptionDetail:'',
                defaultFormat:'0',
                tips:'',
                describe:'',
                top:height,
                flag:flag,
            }
            obj.formTem = function(){
                return ' <form class="layui-form" id="control-data">\n' +
                    '       <div class="layui-form-item" id="controlName" >\n' +
                    '           <div>\n' +
                    '               <span>控件名称</span>\n' +
                    '               <span class="control-remarks">' + this.controlType + '</span>\n' +
                    '           </div>\n' +
                    '           <div>\n' +
                    '               <input type="text" name="title" lay-verify="title" autocomplete="off" class="layui-input" value="' + this.controlName + '">\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item" id="hide">\n' +
                    '           <div>\n' +
                    '               <span>隐藏条件</span>\n' +
                    '               <span class="hide-remarks">当满足以下条件时此控件隐藏</span>\n' +
                    '           </div>\n' +
                    '           <div>\n' +
                    '               <input type="text" name="title" lay-verify="title" autocomplete="off" class="layui-input" readonly value="' + this.hide + '">\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item">\n' +
                    '           <label class="layui-form-label">默认值</label>\n' +
                    '           <div>\n' +
                    '               <select name="group" lay-filter="group">\n' +
                    createOptions(this.defaultOption,this.defaultValue) +
                    '               </select>\n' +
                    '           </div>\n' +
                    '           <div style="margin-top: 10px">\n' +
                    '               <input type="text" name="title" lay-verify="title" autocomplete="off" class="layui-input" readonly value="'+ this.defaultOptionDetail +'">\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item">\n' +
                    '           <label class="layui-form-label" style="width: 100%">仅以下人员可被选择</label>\n' +
                    '           <div>\n' +
                    '               <input type="text" name="title" lay-verify="title" autocomplete="off" class="layui-input" readonly value="' + this.hide + '">\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item" id="remarks">\n' +
                    '           <label class="layui-form-label">描述</label>\n' +
                    '           <div>\n' +
                    '               <textarea class="layui-textarea">' + this.describe + '</textarea>\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height){
                return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px; top: 0px;top:' + height + 'px" data-flag="' + flag + '">\n' +
                    '       <label class="layui-form-label">' + this.controlType +'</label>\n' +
                    '       <div style="display: block" class="input-text">\n' +
                    '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请输入" class="layui-input">\n' +
                    '       </div>\n' +
                    '   </div>'
            }
            obj.template = obj.createTemplate(obj.top)
            return obj
            break;

        case 'C16':
            var obj = {
                /*
                *  @colType         控件类型
                *  @colName         控件名称
                * */
                colType:'C16',
                colName:'是/否',
                colStyle:false,
                top:height,
                flag:flag,
            }
            obj.formTem = function(isChild){
                return '<form class="layui-form" id="control-data">\n' +
                    '   <div class="layui-form-item" id="switch">\n' +
                    '       <div>\n' +
                    '           <span>选项</span>\n' +
                    '       </div>\n' +
                    '       <div>\n' +
                    '           <input type="text" name="colName" autocomplete="off" class="layui-input" style="width: 70%;display: inline-block" value="' + this.colName + '" oninput="changeInput(this,'+ isChild +')">\n' +
                    isSwitch(this.colStyle,'<input type="checkbox" value="0" name="switch" lay-skin="switch" lay-filter="switch" checked>','<input type="checkbox" value="0" name="switch" lay-skin="switch" lay-filter="switch">') +
                    '       </div>\n' +
                    '   </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height,flag) {
                if(this.flag == flag){
                    return '<div class="layui-form-item  input-enter input-active" style="position: absolute; left: 0px; top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                        '       <div style="display: block" class="input-text check-line-block">' +
                        isSwitch(this.colStyle,'<input type="checkbox" value="0" name="state" lay-skin="switch" lay-text="开|关" checked disabled>','<input type="checkbox" value="0" name="state" lay-skin="switch" lay-text="开|关" disabled>') +
                        '       </div>\n' +
                        '       <div class="colDelete" style="display: block"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy" style="display: block"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }else{
                    return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px;top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                        '       <div style="display: block" class="input-text check-line-block">' +
                        isSwitch(this.colStyle,'<input type="checkbox" value="0" name="state" lay-skin="switch" lay-text="开|关" checked disabled>','<input type="checkbox" value="0" name="state" lay-skin="switch" lay-text="开|关" disabled>') +
                        '       </div>\n' +
                        '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }
            }
            obj.createTemplatec = function() {
                return '<div class="layui-form-item ' + (this.flag == (activeCol&&activeCol.temObj.flag)?'input-active':'') + '" style="text-align: left" data-type="' + this.colType + '" data-flag="' + this.flag + '">\n' +
                    '       <label class="layui-form-label">' + this.colName +'</label>\n' +
                    '       <div style="display: block"  class="input-text check-line-block">' +
                    isSwitch(this.colStyle,'<input type="checkbox" value="0" name="state" lay-skin="switch" lay-text="开|关" checked disabled>','<input type="checkbox" value="0" name="state" lay-skin="switch" lay-text="开|关" disabled>') +
                    '       </div>\n' +
                    '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   </div>'
            }
            obj.template = obj.createTemplate(obj.top)
            return obj
            break;

        case 'L01':
            var obj = {
                /*
                *  @colType         控件类型
                *  @controlName     控件名称
                * */
                colType:'L01',
                colKtype:'L0101',
                colStyle:{
                    shareRatio:{
                        ratio:'50:50'
                    },
                    oneCol:{},
                    twoCol:{},
                    threeCol:{},
                    fourCol:{},
                },
                top:height,
                flag:flag,
            }
            obj.formTem = function(){
                return '<form class="layui-form" id="control-data">\n' +
                    '   <div class="layui-form-item">\n' +
                    '       <div style="margin-left: 10px">布局</div>' +
                    '       <div style="text-align: center;margin: 10px 0" id="moreChoose">\n' +
                    createMoreBtn(this.colKtype) +
                    '       </div>\n' +
                    '   </div>\n' +
                    '   <div class="layui-form-item">' +
                    '       <div style="margin-left: 10px">占比</div>' +
                    '       <div style="text-align: center;margin: 10px 0" id="moreChoose">' +
                    createMoreProportion(this.colKtype,this.colStyle.shareRatio.ratio) +
                    '       </div>' +
                    '   </div>' +
                    '</form>'
            }
            obj.createTemplate = function(height,flag) {
                if(this.flag == flag){
                    return '<div class="layui-form-item  input-enter input-active" style="position: absolute; left: 0px; top:' + height + 'px;padding: 0 .5%" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        createMoreCol(this.colType,this.colKtype,this.colStyle,this.flag) +
                        '       <div class="colDelete" style="display: block"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy" style="display: block"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }else{
                    return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px;top:' + height + 'px;padding: 0 .5%" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        createMoreCol(this.colType,this.colKtype,this.colStyle,this.flag) +
                        '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }
            }
            obj.template = obj.createTemplate(obj.top)
            return obj
            break;
        case 'L02':
            var obj = {
                /*
                *  @colType         控件类型
                *  @controlName     控件名称
                * */
                colType:'L02',
                colName:'分组控件',
                colStyle:'1',
                top:height,
                flag:flag,
            }
            obj.formTem = function(){
                return '<form class="layui-form" id="control-data">\n' +
                    '   <div class="layui-form-item" id="controlName">\n' +
                    '       <div>\n' +
                    '           <div style="margin:10px 0">分组名称</div>\n' +
                    '           <input type="text" name="colName" autocomplete="off" class="layui-input" style="width: 90%;display: inline-block" value="' + this.colName + '" oninput="changeInput(this)">\n' +
                    '       </div>\n' +
                    '       <div style="margin-top:15px">\n' +
                    '           <div className="layui-form-item">' +
                    '               <label className = "layui-form-label" >名称位置</label>' +
                    '               <div className="layui-input-block">' +
                    dataPlace(this.colStyle) +
                    '               </div>' +
                    '           </div>' +
                    '       </div>\n' +
                    '   </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height,flag) {
                if(this.flag == flag){
                    return '<div class="layui-form-item  input-enter input-active" style="position: absolute; left: 0px; top:' + height + 'px;padding-top: 15px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <div style="position: relative">' +
                        '           <div style="width: calc(100% - 40px);font-size: 16px;font-weight: 700;' + temPlace(this.colStyle) + '">' + this.colName + '</div>' +
                        '           <div class="group-title"><i class="layui-icon layui-icon-down"></i></div>' +
                        '       </div>' +
                        '       <hr/>' +
                        '       <div class="colDelete" style="display: block"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy" style="display: block"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }else{
                    return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px;top:' + height + 'px;padding-top: 15px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <div style="position: relative">' +
                        '           <div style="width: calc(100% - 40px);font-size: 16px;font-weight: 700;' + temPlace(this.colStyle) + '">' + this.colName + '</div>' +
                        '           <div class="group-title"><i class="layui-icon layui-icon-down"></i></div>' +
                        '       </div>' +
                        '       <hr/>' +
                        '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }
            }
            obj.template = obj.createTemplate(obj.top)
            return obj
            break;
        case 'L03':
            var obj = {
                /*
                *  @colType         控件类型
                *  @controlName     控件名称
                * */
                colType:'L03',
                colName:'表单子表',
                colStyle: [],
                top:height,
                flag:flag,
            }
            obj.formTem = function(){
                var da = this.colStyle;
                var tit = this.subDataTitle ? this.subDataTitle : '';
                setTimeout(function(){
                    postrionField()
                    dataSelect(da,tit,this.activeCol.temObj.colName);
                },1000)

                return '<form class="layui-form" id="control-data">\n' +
                    '   <div class="layui-form-item" id="controlName">\n' +
                    '       <div>\n' +
                    '           <div style="margin:10px 0">控件名称</div>\n' +
                    '           <input type="text" name="colName" autocomplete="off" class="layui-input" style="width: 90%;display: inline-block" value="' + this.colName + '" oninput="changeInput(this)">\n' +
                    '       </div>\n' +
                    '       <div>' +
                    '           <div style="margin:10px 0">数据标题</div>\n' +
                    '           <div id="dataTitleSelect" style="width:90%;"></div>' +
                    '       </div>' +
                    '       <div style="margin-top:15px">\n' +
                    '           <div style="margin:10px 0">子表字段</div>\n' +
                    '               <ul id="tableSort">' +
                    createTableFieldSort(this.colStyle) +
                    '               </ul>' +
                    '       </div>\n' +
                    '   </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height,flag) {
                if(this.flag == flag){
                    return '<div class="layui-form-item  input-enter input-active" style="position: absolute; left: 0px; top:' + height + 'px;padding-top: 15px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <div>' + this.colName + '</div>' +
                        '       <div class="table-col" onscroll="tableScroll(this)">' +
                        '           <div class="table-col-item table-col-preset">' +
                        '               <div class="table-title default-checkbox"><input type="checkbox" name="" lay-skin="primary" disabled></div>' +
                        '               <div class="table-content default-checkbox"><input type="checkbox" name="" lay-skin="primary" disabled></div>' +
                        '           </div>' +
                        '           <div  class="table-col-item table-col-preset" style="margin-left: -5px">' +
                        '               <div class="table-title">序号</div>' +
                        '               <div class="table-content">1</div>' +
                        '           </div>' +
                        createTableItem(this) +
                        '           <div class="add-table-item">' +
                        '               <div class="add-table-button" data-add="'+ this.flag +'">点击添加字段</div>' +
                        '           </div>' +
                        '       </div>' +
                        '       <div class="colDelete" style="display: block"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy" style="display: block"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }else{
                    return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px;top:' + height + 'px;padding-top: 15px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <div>' + this.colName + '</div>' +
                        '       <div class="table-col" onscroll="tableScroll(this)">' +
                        '           <div class="table-col-item table-col-preset">' +
                        '               <div class="table-title default-checkbox"><input type="checkbox" name="" lay-skin="primary" disabled></div>' +
                        '               <div class="table-content default-checkbox"><input type="checkbox" name="" lay-skin="primary" disabled></div>' +
                        '           </div>' +
                        '           <div class="table-col-item table-col-preset" style="margin-left: -5px">' +
                        '               <div class="table-title">序号</div>' +
                        '               <div class="table-content">1</div>' +
                        '           </div>' +
                        createTableItem(this) +
                        '           <div class="add-table-item">' +
                        '               <div class="add-table-button" data-add="'+ this.flag +'" >点击添加字段</div>' +
                        '           </div>' +
                        '       </div>' +
                        '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }
            }
            obj.template = obj.createTemplate(obj.top)
            return obj
            break;

        case 'C15':  //单行文本
            var obj = {
                colName :'关联表单',
                colType:'C15',
                colStyle: {gappName:'',gappid:''},
                inputDesc: '',
                top: height,
                flag: flag,
            }
            obj.formTem = function(isChild){
                return ' <form class="layui-form" id="control-data">\n' +
                    '       <div class="layui-form-item" id="controlName" >\n' +
                    '           <div>\n' +
                    '               <span>控件名称</span>\n' +
                    '               <span class="control-remarks">关联表单</span>\n' +
                    '           </div>\n' +
                    '           <div>\n' +
                    '               <input type="text" name="colName" lay-verify="title" autocomplete="off" class="layui-input" value="' + this.colName + '" oninput="changeInput(this,'+ isChild +')">\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item" id="controlName">\n' +
                    '           <div>\n' +
                    '               <span>关联表单</span>\n' +
                    '           </div>\n' +
                    '       <div class="">\n' +
                    '           <div class="layui-unselect layui-form-select treeSelect">\n' +
                    '                <div id="treeclassbox" class="layui-select-title" style="position: relative;">\n' +
                    '                    <input type="text" name="colKtype" lay-filter="colKtype" value="'+ treeClassVal(this.colStyle) +'" id="treeclass" placeholder="请选择需要关联的表单" class="layui-input" style="caret-color: transparent;">\n' +
                    '                    <i class="layui-edge"></i>\n' +
                    '                </div>\n' +
                    '                <div id="meuntree" style="position: absolute;z-index: 30;width: 100%; background: #fff;box-shadow: 0 2px 12px 0 rgb(52 94 184 / 15%);border-radius: 5px;margin: 5px 0px;"></div>'+
                    '            </div>' +
                    '        </div>\n' +
                    '        </div>\n' +
                    '       <div class="layui-form-item" id="remarks">\n' +
                    '           <label class="layui-form-label">描述</label>\n' +
                    '           <div>\n' +
                    '               <textarea class="layui-textarea" name="inputDesc" oninput="changeInput(this,'+ isChild +')">' + this.inputDesc + '</textarea>\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '</form>'
            }
            obj.createTemplate = function(height,flag){
                if(this.flag == flag){
                    return '<div class="layui-form-item  input-enter input-active" style="position: absolute; left: 0px; top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) + '</label>\n' +
                        '       <div style="display: block" class="input-text">\n' +
                        '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请输入" class="layui-input">\n' +
                        '       </div>\n' +
                        '       <div class="colDelete" style="display: block"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy" style="display: block"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }else{
                    return '<div class="layui-form-item  input-enter" style="position: absolute; left: 0px;top:' + height + 'px" data-flag="' + this.flag + '" data-type="' + this.colType + '">\n' +
                        '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) + ' </label>\n' +
                        '       <div style="display: block" class="input-text">\n' +
                        '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请输入" class="layui-input">\n' +
                        '       </div>\n' +
                        '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '       <div class="colCopy"><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                        '   </div>'
                }
            },
                obj.createTemplatec = function(){
                    return '<div class="layui-form-item ' + (this.flag ==  (activeCol&&activeCol.temObj.flag)?'input-active':'') + '" data-type="' + this.colType + '" data-flag="' + this.flag + '">\n' +
                        '       <label class="layui-form-label">' + this.colName + isHasDes(this.inputDesc) + ' </label>\n' +
                        '       <div style="display: block" class="input-text">\n' +
                        '           <input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请输入" class="layui-input">\n' +
                        '       </div>\n' +
                        '       <div class="colDelete"><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                        '   </div>'
                }
            obj.template = obj.createTemplate(obj.top,false)
            return obj
            break;
    }
}
//返回关联表单控件的值
function treeClassVal(colStyle){
    var itemObj;
    if(colStyle == {}){
        console.log(colStyle == {})
    }else if(colStyle.gappName == ""){
        var str = JSON.stringify(colStyle);
        itemObj = JSON.parse(str);
    }else{
        itemObj = JSON.parse(colStyle);
    }
    var gappName = itemObj.gappName;
    if(gappName){
        return gappName;
    }else{
        return '';
    }
}
//生成下拉框选项模板
function createOptions(options,defaultValue){
    var str = ''
    options.forEach(function(item,index,arr){
        if(item.optionValue == defaultValue){
            str += '<option value="'+ item.optionValue +'" selected>'+ item.optionName +'</option>\n'
        }else{
            str += '<option value="'+ item.optionValue +'">'+ item.optionName +'</option>\n'
        }
    })
    return str
}

//生成数字下拉框
function createNumberOptions(colKtype,colStyle){
    var str = ''
    var list
    switch (colKtype){
        case 'C0401':
            list = [
                {options:'整数',value:'C040100'},
                {options:'小数1位',value:'C040101'},
                {options:'小数2位',value:'C040102'},
                {options:'小数3位',value:'C040103'},
                {options:'小数4位',value:'C040104'},
                {options:'小数5位',value:'C040105'},
                {options:'小数6位',value:'C040106'},
            ]
            break;
        case 'C0402':
            list = [
                {options:'带千分位整数',value:'C040200'},
                {options:'带千分位小数1位',value:'C040201'},
                {options:'带千分位小数2位',value:'C040202'},
                {options:'带千分位小数3位',value:'C040203'},
                {options:'带千分位小数4位',value:'C040204'},
                {options:'带千分位小数5位',value:'C040205'},
                {options:'带千分位小数6位',value:'C040206'},
            ]
            break;
        case 'C0403':
            list = [
                {options:'整数百分比',value:'C040300'},
                {options:'小数1位百分比',value:'C040301'},
                {options:'小数2位百分比',value:'C040302'},
                {options:'小数3位百分比',value:'C040303'},
                {options:'小数4位百分比',value:'C040304'},
                {options:'小数5位百分比',value:'C040305'},
                {options:'小数6位百分比',value:'C040305'},
            ]
            break;
    }
    list.forEach(function(item,index,arr){
        if(item.value == colStyle){
            str += '<option value="'+ item.value +'" selected>'+ item.options +'</option>\n'
        }else{
            str += '<option value="'+ item.value +'">'+ item.options +'</option>\n'
        }
    })
    return str
}

//生成日期下拉框
function createDateOptions(colKtype,colStyle){
    var str = ''
    var list
    switch (colKtype){
        case 'C0301':
            list = [
                {options:'yyyy年mm月dd日',value:'C030101'},
                {options:'yyyy年mm月',value:'C030102'},
                {options:'mm月dd日',value:'C030103'},
                {options:'yyyy-mm-dd',value:'C030104'},
                {options:'yyyy-mm',value:'C030105'},
                {options:'mm-dd',value:'C030106'},
                {options:'yyyy年',value:'C030107'},
                {options:'mm月',value:'C030108'},
            ]
            break;
        case 'C0302':
            list = [
                {options:'hh时mm分',value:'C030201'},
                {options:'hh时mm分ss秒',value:'C030202'},
                {options:'hh:mm',value:'C030203'},
                {options:'hh:mm:ss',value:'C030204'},
            ]
            break;
        case 'C0303':
            list = [
                {options:'yyyy年mm月dd日 hh时mm分ss秒',value:'C030301'},
                {options:'yyyy-mm-dd hh-mm-ss',value:'C030302'},
            ]
            break;
    }
    list.forEach(function(item,index,arr){
        if(item.value == colStyle){
            str += '<option value="'+ item.value +'" selected>'+ item.options +'</option>\n'
        }else{
            str += '<option value="'+ item.value +'">'+ item.options +'</option>\n'
        }
    })
    return str
}

//生成单选框
function createRadios(radioList,type){
    var str = ''
    if(type==0){
        radioList.forEach(function(item,index,arr){
            if(item.checked){
                str += '<div class="radioListItem">' +
                    '       <input type="radio" name="radio" lay-verify="title" autocomplete="off" checked>' +
                    '       <input type="text" name="radioMsg" lay-verify="radio" autocomplete="off" class="layui-input" value="' + item.radioName + '">' +
                    '       <i class="layui-icon layui-icon-delete delete" style="font-size: 30px; color: rgb(146,156,175);"></i> ' +
                    '   </div>'
            }else{
                str += '<div class="radioListItem">' +
                    '       <input type="radio" name="radio" lay-verify="title" autocomplete="off">' +
                    '       <input type="text" name="radioMsg" lay-verify="radio" autocomplete="off" class="layui-input" value="' + item.radioName + '">' +
                    '       <i class="layui-icon layui-icon-delete delete" style="font-size: 30px; color: rgb(146,156,175);"></i> ' +
                    '   </div>'
            }
        })
        return str
    }else if(type==1){
        radioList.forEach(function(item,index,arr){
            if(item.checked){
                str += '<div><input type="radio" name="title" lay-verify="title" autocomplete="off" disabled title="' + item.radioName + '" class="layui-input" checked></div>'
            }else{
                str += '<div><input type="radio" name="title" lay-verify="title" autocomplete="off" disabled title="' + item.radioName + '" class="layui-input"></div>'
            }
        })
        return str
    }else if(type == 2){
        radioList.forEach(function(item,index,arr){
            if(item.checked){
                str += '<input type="radio" lay-filter="check" name="check" lay-skin="primary" title="' + item.radioName + '" checked>\n'
            }else{
                str += '<input type="radio" lay-filter="check" name="check" lay-skin="primary"title="' + item.radioName + '">\n'
            }
        })
        return str
    }
}

//单选框控件生成单选框
function JSONRadiosData(list,type,flag){
    var str = ''
    if(type==0){
        list.forEach(function(item,index,arr){
            if (item.checked){
                str += '<div class="radioListItem">' +
                    '       <input type="radio" name="radio" lay-filter="radio" autocomplete="off" checked value="' + item.value + '">' +
                    '       <input type="text" name="radioMsg" lay-filter="radio" autocomplete="off" class="layui-input" value="' + item.option + '" oninput="changeRadio(this,'+ flag +')">' +
                    '       <i class="layui-icon layui-icon-delete delete" style="font-size: 30px; color: rgb(146,156,175);cursor: pointer;" onclick="radioDelete(this,'+ flag +')"></i> ' +
                    '   </div>'
            }else{
                str += '<div class="radioListItem">' +
                    '       <input type="radio" name="radio" lay-filter="radio" autocomplete="off" value="' + item.value + '">' +
                    '       <input type="text" name="radioMsg" lay-filter="radio" autocomplete="off" class="layui-input" value="' + item.option + '" oninput="changeRadio(this,'+ flag +')">' +
                    '       <i class="layui-icon layui-icon-delete delete" style="font-size: 30px; color: rgb(146,156,175);cursor: pointer;" onclick="radioDelete(this,'+ flag +')"></i> ' +
                    '   </div>'
            }
        })
        return str
    }else if(type==1){
        list.forEach(function(item,index,arr){
            if (item.checked){
                str += '<div><input type="radio"  lay-verify="title" autocomplete="off" disabled title="' + item.option + '" class="layui-input" checked></div>'
            }else{
                str += '<div><input type="radio" lay-verify="title" autocomplete="off" disabled title="' + item.option + '" class="layui-input"></div>'
            }
        })
        return str
    }
}

//生成复选框
function JSONcheckboxData(list,type,flag){
    var str = ''
    if(type==0){
        list.forEach(function(item,index,arr){
            if(item.checked){
                str += '<div class="checkListItem">' +
                    '       <input type="checkbox" name="check" lay-filter="checkbox" lay-skin="primary" checked value="' + item.value + '">' +
                    '       <input type="text" name="radioMsg" lay-filter="checkbox" autocomplete="off" class="layui-input" value="' + item.option + '" oninput="changeCheckbox(this,'+ flag +')">' +
                    '       <i class="layui-icon layui-icon-delete delete" style="font-size: 30px; color: rgb(146,156,175);cursor: pointer;" onclick="checkboxDelete(this,'+ flag +')"></i> ' +
                    '   </div>'
            }else{
                str += '<div class="checkListItem">' +
                    '       <input type="checkbox" name="check" lay-filter="checkbox" lay-skin="primary"  value="' + item.value + '">' +
                    '       <input type="text" name="radioMsg" autocomplete="off" class="layui-input" value="' + item.option + '" oninput="changeCheckbox(this,'+ flag +')">' +
                    '       <i class="layui-icon layui-icon-delete delete" style="font-size: 30px; color: rgb(146,156,175);cursor: pointer;" onclick="checkboxDelete(this,'+ flag +')"></i> ' +
                    '   </div>'
            }

        })
        return str
    }else if(type==1){
        list.forEach(function(item,index,arr){
            if (item.checked){
                str += '<div><input type="checkbox" name="check" disabled lay-skin="primary" title="' + item.option + '" checked></div>'
            }else{
                str += '<div><input type="checkbox" name="check" disabled lay-skin="primary" title="' + item.option + '"></div>'
            }
        })
        return str
    }
}

//是否选中
function isCheck(flag,yDOM,nDOM){
    if(flag=="1"){
        return yDOM
    }else{
        return nDOM
    }
}

//开关是否
function isSwitch(flag,yDOM,nDOM){
    if(flag){
        return yDOM
    }else{
        return nDOM
    }
}

//人员单选专用
function createInfo(List){
    var str = ''
    List.forEach(function(item,index,arr){
        str += '<div><span>' + item.optionsName + '</span> <span style="color:#757575"> 的值填充到 </span> <select name="group" lay-filter="group"> ' + createOptions(item.selectOption,item.defaultValue) + ' </select></div>'
    })
    return str
}

//修改控件input属性
function changeInput(dom,flag){
    var topList = []
    if(flag){
        editColObj.temObj[$(dom).attr('name')] = $(dom).val()
    }else{
        activeCol.temObj[$(dom).attr('name')] = $(dom).val()
    }
    var str = ''
    var height = 0
    var heightList = [0]
    $('#show-form>.layui-form-item').each(function(index){
        topList.push(parseInt($(this).css('top')))
        height += parseInt($(this).css('height'))
        heightList.push(parseInt($(this).css('height')))
    })
    topList = quick(topList)
    formList.forEach(function(item,index,arr){
        item.temObj.top = topList[index]
        str += item.temObj.createTemplate(item.temObj.top,activeCol.temObj.flag)
    })
    $('#show-form').html(str)
    form.render()
    showColBtn()
}

//控件属性单选框选项删除
function radioDelete(dom,flag){
    var thisDom = $(dom).parent()
    var inputList = $(dom).parent().parent().find('.radioListItem')
    inputList.each(function(index,item){
        if(thisDom[0] === item){
            if(flag){
                editColObj.temObj.selectOption.splice(index,1)
                colDataRender(true)
            }else{
                activeCol.temObj.selectOption.splice(index,1)
                colDataRender(false)
            }
        }
    })
    colRender()
}

//控件属性复选框选项删除
function checkboxDelete(dom,flag){
    var thisDom = $(dom).parent()
    var inputList = $(dom).parent().parent().find('.checkListItem')
    inputList.each(function(index,item){
        if(thisDom[0] === item){
            if(flag){
                editColObj.temObj.selectOption.splice(index,1)
                colRender()
                colDataRender(true)
            }else{
                activeCol.temObj.selectOption.splice(index,1)
                colRender()
                colDataRender(false)
            }
        }
    })
}

//控件属性单选框选项名更改
function changeRadio(dom,flag){
    var inputList = $(dom).parent().parent().find('.layui-input')
    inputList.each(function(index,item,arr){
        if(flag){
            editColObj.temObj.selectOption[index].option = $(item).val()

        }else{
            activeCol.temObj.selectOption[index].option = $(item).val()
        }
    })
    colRender()
}

//控件属性复选框选项名更改
function changeCheckbox(dom){
    var inputList = $(dom).parent().parent().find('.layui-input')
    inputList.each(function(index,item,arr){
        activeCol.temObj.selectOption[index].option = $(item).val()
    })
    colRender()
}

//控件属性单选框增加选项
function addRadio(flag){
    if(flag){
        var str = '选项' + (editColObj.temObj.selectOption.length + 1)
        var  obj = {
            option:str,
            checked:false,
            value:Number(editColObj.temObj.selectOption[editColObj.temObj.selectOption.length-1].value) + 1
        }
        editColObj.temObj.selectOption.push(obj)
        colDataRender(true)
    }else{
        var str = '选项' + (activeCol.temObj.selectOption.length + 1)
        var  obj = {
            option:str,
            checked:false,
            value:Number(activeCol.temObj.selectOption[activeCol.temObj.selectOption.length-1].value) + 1
        }
        activeCol.temObj.selectOption.push(obj)
        colDataRender(false)
        colRender()
    }
}

//图片控件属性复选框生成
function pictureCheckbox(list){
    var str = ''

    if(list[0] == 0){
        str += '<input type="checkbox" lay-filter="colStyle" name="0" lay-skin="primary" title="允许上传多张照片">'
    }else{
        str += '<input type="checkbox" lay-filter="colStyle" name="0" lay-skin="primary" title="允许上传多张照片" checked>'
    }

    if(list[1] == 0){
        str += '<input type="checkbox" lay-filter="colStyle" name="1" lay-skin="primary" title="允许拍照上传">'
    }else{
        str += '<input type="checkbox" lay-filter="colStyle" name="1" lay-skin="primary" title="允许拍照上传" checked>'
    }

    if(list[1] == 1 && list[2] == 0){
        str += '<input type="checkbox" lay-filter="colStyle" name="2" lay-skin="primary" title="拍照时增加水印">'
    }else if(list[1] ==1 && list[2] == 1){
        str += '<input type="checkbox" lay-filter="colStyle" name="2" lay-skin="primary" title="拍照时增加水印" checked style="display:none">'
    }

    if(list[1] == 1 && list[3] == 0){
        str += '<input type="checkbox" lay-filter="colStyle" name="3" lay-skin="primary" title="自动压缩图片">'
    }else if(list[1] ==1 && list[3] == 1){
        str += '<input type="checkbox" lay-filter="colStyle" name="3" lay-skin="primary" title="自动压缩图片" checked style="display:none">'
    }

    return str
}

//分组标题标题定位
function temPlace(num){
    if(num == '1'){
        return 'text-align:left'
    }else if(num == '2'){
        return 'text-align:center'
    }else if(num == '3'){
        return 'text-align:right'
    }
}

// 分组标题dom生成
function dataPlace(num){
    if(num == '1'){
        return '<input type="radio" lay-filter="radio" name="radio" value="1" title="左" checked><input type="radio" lay-filter="radio" name="radio" value="2" title="中"><input type="radio" lay-filter="radio" name="radio" value="3" title="右">'
    }else if(num == '2'){
        return '<input type="radio" lay-filter="radio" name="radio" value="1" title="左"><input type="radio" lay-filter="radio" name="radio" value="2" title="中" checked><input type="radio" lay-filter="radio" name="radio" value="3" title="右">'

    }else if(num == '3'){
        return '<input type="radio" lay-filter="radio" name="radio" value="1" title="左"><input type="radio" lay-filter="radio" name="radio" value="2" title="中"><input type="radio" lay-filter="radio" name="radio" value="3" title="右" checked>'

    }
}

//一行多列控件模板生成
function createMoreCol(colType,colKtype,colStyle,flag){
    var str = '<div style="padding-top: 10px">'
    var list = colStyle.shareRatio.ratio.split(':')
    switch (colKtype){
        case 'L0101':
            if(Object.keys(colStyle.oneCol).length == 0){
                str += '<div class="no-choose-col-box" style="width: '+ list[0] +'%">' +
                    '<div class="no-choose-col" data-flag="' + flag + '" onclick="addCol(\'' + flag + '\',0,event)" onmousedown="mouseDownBegin()" onmouseup="mouseUpBegin()">点击添加控件</div>' +
                    '</div>'
            }else{
                str += '<div class="no-choose-col-box" style="width: '+ list[0] +'%">' +
                    '<div class="no-choose-col" data-flag="' + flag + '" onclick="addCol(\'' + flag + '\',0,event)" onmousedown="mouseDownBegin()" onmouseup="mouseUpBegin()">' + colStyle.oneCol.createTemplatec() + '</div>' +
                    '</div>'
            }

            if(Object.keys(colStyle.twoCol).length == 0){
                str += '<div class="no-choose-col-box" style="width: '+ list[1] +'%">' +
                    '   <div class="no-choose-col" data-flag="' + flag + '" onclick="addCol(\''+ flag +'\',1,event)" onmousedown="mouseDownBegin()" onmouseup="mouseUpBegin()">点击添加控件</div>' +
                    '</div>'
            }else{
                str += '<div class="no-choose-col-box" style="width: '+ list[1] +'%">' +
                    '<div class="no-choose-col" data-flag="' + flag + '" onclick="addCol(\'' + flag + '\',1,event)" onmousedown="mouseDownBegin()" onmouseup="mouseUpBegin()">' + colStyle.twoCol.createTemplatec() + '</div>' +
                    '</div>'
            }
                break;
        case 'L0102':
            if(Object.keys(colStyle.oneCol).length == 0){
                str += '<div class="no-choose-col-box" style="width: '+ list[0] +'%">' +
                    '<div class="no-choose-col" data-flag="' + flag + '" onclick="addCol(\'' + flag + '\',0,event)" onmousedown="mouseDownBegin()" onmouseup="mouseUpBegin()">点击添加控件</div>' +
                    '</div>'
            }else{
                str += '<div class="no-choose-col-box" style="width: '+ list[0] +'%">' +
                    '<div class="no-choose-col" data-flag="' + flag + '" onclick="addCol(\'' + flag + '\',0,event)" onmousedown="mouseDownBegin()" onmouseup="mouseUpBegin()">' + colStyle.oneCol.createTemplatec() + '</div>' +
                    '</div>'
            }

            if(Object.keys(colStyle.twoCol).length == 0){
                str += '<div class="no-choose-col-box" style="width: '+ list[1] +'%">' +
                    '   <div class="no-choose-col" data-flag="' + flag + '" onclick="addCol(\''+ flag +'\',1,event)" onmousedown="mouseDownBegin()" onmouseup="mouseUpBegin()">点击添加控件</div>' +
                    '</div>'
            }else{
                str += '<div class="no-choose-col-box" style="width: '+ list[1] +'%">' +
                    '<div class="no-choose-col" data-flag="' + flag + '" onclick="addCol(\'' + flag + '\',1,event)" onmousedown="mouseDownBegin()" onmouseup="mouseUpBegin()">' + colStyle.twoCol.createTemplatec() + '</div>' +
                    '</div>'
            }

            if(Object.keys(colStyle.threeCol).length == 0){
                str += '<div class="no-choose-col-box" style="width: '+ list[2] +'%">' +
                    '   <div class="no-choose-col" data-flag="' + flag + '" onclick="addCol(\''+ flag +'\',2,event)" onmousedown="mouseDownBegin()" onmouseup="mouseUpBegin()">点击添加控件</div>' +
                    '</div>'
            }else{
                str += '<div class="no-choose-col-box" style="width: '+ list[2] +'%">' +
                    '<div class="no-choose-col" data-flag="' + flag + '" onclick="addCol(\'' + flag + '\',2,event)" onmousedown="mouseDownBegin()" onmouseup="mouseUpBegin()">' + colStyle.threeCol.createTemplatec() + '</div>' +
                    '</div>'
            }
            break;
        case 'L0103':
            if(Object.keys(colStyle.oneCol).length == 0){
                str += '<div class="no-choose-col-box" style="width: '+ list[0] +'%">' +
                    '<div class="no-choose-col" data-flag="' + flag + '" onclick="addCol(\'' + flag + '\',0,event)" onmousedown="mouseDownBegin()" onmouseup="mouseUpBegin()">点击添加控件</div>' +
                    '</div>'
            }else{
                str += '<div class="no-choose-col-box" style="width: '+ list[0] +'%">' +
                    '<div class="no-choose-col" data-flag="' + flag + '" onclick="addCol(\'' + flag + '\',0,event)" onmousedown="mouseDownBegin()" onmouseup="mouseUpBegin()">' + colStyle.oneCol.createTemplatec() + '</div>' +
                    '</div>'
            }

            if(Object.keys(colStyle.twoCol).length == 0){
                str += '<div class="no-choose-col-box" style="width: '+ list[1] +'%">' +
                    '   <div class="no-choose-col" data-flag="' + flag + '" onclick="addCol(\''+ flag +'\',1,event)" onmousedown="mouseDownBegin()" onmouseup="mouseUpBegin()">点击添加控件</div>' +
                    '</div>'
            }else{
                str += '<div class="no-choose-col-box" style="width: '+ list[1] +'%">' +
                    '<div class="no-choose-col" data-flag="' + flag + '" onclick="addCol(\'' + flag + '\',1,event)" onmousedown="mouseDownBegin()" onmouseup="mouseUpBegin()">' + colStyle.twoCol.createTemplatec() + '</div>' +
                    '</div>'
            }

            if(Object.keys(colStyle.threeCol).length == 0){
                str += '<div class="no-choose-col-box" style="width: '+ list[2] +'%">' +
                    '   <div class="no-choose-col" data-flag="' + flag + '" onclick="addCol(\''+ flag +'\',2,event)" onmousedown="mouseDownBegin()" onmouseup="mouseUpBegin()">点击添加控件</div>' +
                    '</div>'
            }else{
                str += '<div class="no-choose-col-box" style="width: '+ list[2] +'%">' +
                    '<div class="no-choose-col" data-flag="' + flag + '" onclick="addCol(\'' + flag + '\',2,event)" onmousedown="mouseDownBegin()" onmouseup="mouseUpBegin()">' + colStyle.threeCol.createTemplatec() + '</div>' +
                    '</div>'
            }

            if(Object.keys(colStyle.fourCol).length == 0){
                str += '<div class="no-choose-col-box" style="width: '+ list[3] +'%">' +
                    '   <div class="no-choose-col" data-flag="' + flag + '" onclick="addCol(\''+ flag +'\',3,event)" onmousedown="mouseDownBegin()" onmouseup="mouseUpBegin()">点击添加控件</div>' +
                    '</div>'
            }else{
                str += '<div class="no-choose-col-box" style="width: '+ list[3] +'%">' +
                    '<div class="no-choose-col" data-flag="' + flag + '" onclick="addCol(\'' + flag + '\',3,event)" onmousedown="mouseDownBegin()" onmouseup="mouseUpBegin()">' + colStyle.fourCol.createTemplatec() + '</div>' +
                    '</div>'
            }
            break;
    }
    str += '</div>'
    return str
}

//一行多列点击添加控件
function addCol(flag,num,$event){
    if($($event.currentTarget).find('.layui-form-item').length){
        return
    }
    this.chooseCalFlag = true
    var str = ''
    for(var i=0;i<formList.length;i++){
        if(formList[i].temObj.flag == flag){
            switch (num) {
                case 0:
                    if(Object.keys(formList[i].temObj.colStyle.oneCol).length >0){
                        editColObj.temObj = formList[i].temObj.colStyle.oneCol
                        str += editColObj.temObj.formTem()
                    }
                    break;
                case 1:
                    if(Object.keys(formList[i].temObj.colStyle.twoCol).length >0){
                        editColObj.temObj = formList[i].temObj.colStyle.twoCol
                        str += editColObj.temObj.formTem()
                    }
                    break;
                case 2:
                    if(Object.keys(formList[i].temObj.colStyle.threeCol).length >0){
                        editColObj.temObj = formList[i].temObj.colStyle.threeCol
                        str += editColObj.temObj.formTem()
                    }
                    break;
                case 3:
                    if(Object.keys(formList[i].temObj.colStyle.fourCol).length >0){
                        editColObj.temObj = formList[i].temObj.colStyle.fourCol
                        str += editColObj.temObj.formTem()
                    }
                    break;
            }
        }
    }
    //页面层
    var addWindow = layer.open({
        type: 1,
        title:'添加控件',
        area: ['350', '600px'], //宽高
        btn:['确定','取消'],
        move:false,
        content: '<div>' +
            '<div>' +
            '<ul id="addColList">' +
            '<li ><div class="' + ((editColObj.temObj==undefined)?"activeChooseCol":"") + '" data-type="0" data-flag="'+ flag +'" data-num="'+ num +'" onclick="chooseColBtn(this)">空</div></li>' +
            '<li ><div class="' + ((editColObj.temObj)&&(editColObj.temObj.colType=="C01")?"activeChooseCol":"") + '" data-type="C01" data-flag="'+ flag +'" data-num="'+ num +'" onclick="chooseColBtn(this)">单行文本</div></li>' +
            '<li ><div class="' + ((editColObj.temObj)&&(editColObj.temObj.colType=="C02")?"activeChooseCol":"") + '" data-type="C02" data-flag="'+ flag +'" data-num="'+ num +'" onclick="chooseColBtn(this)">多行文本</div></li>' +
            '<li ><div class="' + ((editColObj.temObj)&&(editColObj.temObj.colType=="C03")?"activeChooseCol":"") + '" data-type="C03" data-flag="'+ flag +'" data-num="'+ num +'" onclick="chooseColBtn(this)">日期</div></li>' +
            '<li ><div class="' + ((editColObj.temObj)&&(editColObj.temObj.colType=='C04')?"activeChooseCol":"") + '" data-type="C04" data-flag="'+ flag +'" data-num="'+ num +'" onclick="chooseColBtn(this)">数字</div></li>' +
            '<li ><div class="' + ((editColObj.temObj)&&(editColObj.temObj.colType=='C05')?'activeChooseCol':"") + '" data-type="C05" data-flag="'+ flag +'" data-num="'+ num +'" onclick="chooseColBtn(this)">单选框</div></li>' +
            '<li ><div class="' + ((editColObj.temObj)&&(editColObj.temObj.colType=='C06')?'activeChooseCol':"") + '" data-type="C06" data-flag="'+ flag +'" data-num="'+ num +'" onclick="chooseColBtn(this)">复选框</div></li>' +
            '<li ><div class="' + ((editColObj.temObj)&&(editColObj.temObj.colType=='C07')?'activeChooseCol':"") + '" data-type="C07" data-flag="'+ flag +'" data-num="'+ num +'" onclick="chooseColBtn(this)">下拉框</div></li>' +
            '<li ><div class="' + ((editColObj.temObj)&&(editColObj.temObj.colType=='C16')?'activeChooseCol':"") + '" data-type="C16" data-flag="'+ flag +'" data-num="'+ num +'" onclick="chooseColBtn(this)">是/否</div></li>' +
            '<li ><div class="' + ((editColObj.temObj)&&(editColObj.temObj.colType=='C08')?'activeChooseCol':"") + '" data-type="C08" data-flag="'+ flag +'" data-num="'+ num +'" onclick="chooseColBtn(this)">附件</div></li>' +
            '<li ><div class="' + ((editColObj.temObj)&&(editColObj.temObj.colType=='C09')?'activeChooseCol':"") + '" data-type="C09" data-flag="'+ flag +'" data-num="'+ num +'" onclick="chooseColBtn(this)">图片</div></li>' +
            '<li ><div class="' + ((editColObj.temObj)&&(editColObj.temObj.colType=='S06')?'activeChooseCol':"") + '" data-type="S06" data-flag="'+ flag +'" data-num="'+ num +'" onclick="chooseColBtn(this)">流水号</div></li>' +
            '<li ><div class="' + ((editColObj.temObj)&&(editColObj.temObj.colType=='S01')?'activeChooseCol':"") + '" data-type="S01" data-flag="'+ flag +'" data-num="'+ num +'" onclick="chooseColBtn(this)">创建人</div></li>' +
            '<li ><div class="' + ((editColObj.temObj)&&(editColObj.temObj.colType=='S04')?'activeChooseCol':"") + '" data-type="S04" data-flag="'+ flag +'" data-num="'+ num +'" onclick="chooseColBtn(this)">拥有者</div></li>' +
            '<li ><div class="' + ((editColObj.temObj)&&(editColObj.temObj.colType=='S05')?'activeChooseCol':"") + '" data-type="S05" data-flag="'+ flag +'" data-num="'+ num +'" onclick="chooseColBtn(this)">所属部门</div></li>' +
            '<li ><div class="' + ((editColObj.temObj)&&(editColObj.temObj.colType=='S03')?'activeChooseCol':"") + '" data-type="S02" data-flag="'+ flag +'" data-num="'+ num +'" onclick="chooseColBtn(this)">创建时间</div></li>' +
            '<li ><div class="' + ((editColObj.temObj)&&(editColObj.temObj.colType=='S02')?'activeChooseCol':"") + '" data-type="S03" data-flag="'+ flag +'" data-num="'+ num +'" onclick="chooseColBtn(this)">修改时间</div></li>' +
            '</ul>' +
            '</div>' +
            '</div>',
        success:function(){

        },
        yes:function(){
            if(editColObj.noType){
                for(var i=0;i<formList.length;i++){
                    if(formList[i].temObj.flag == editColObj.flag){
                        switch (editColObj.num) {
                            case "0":
                                formList[i].temObj.colStyle.oneCol = {}
                                break;

                            case "1":
                                formList[i].temObj.colStyle.twoCol = {}
                                break;

                            case "2":
                                if(Object.keys(editColObj.temObj).length > 0){
                                    formList[i].temObj.colStyle.threeCol = {}
                                }
                                break;

                            case "3":
                                if(Object.keys(editColObj.temObj).length > 0){
                                    formList[i].temObj.colStyle.fourCol = {}
                                }
                                break;
                        }
                    }
                }
                editColObj = {}
                layer.close(addWindow)
                colRender()
                reSortForm()
                return
            }
            if(!isHasSystemCol(editColObj.temObj.colType)){
                return layer.msg('该类型控件在表单内唯一，不支持添加多个', {icon: 2});
            }
            for(var i=0;i<formList.length;i++){
                if(formList[i].temObj.flag == editColObj.dataFlag){
                    switch (editColObj.dataNum) {
                        case "0":
                            formList[i].temObj.colStyle.oneCol = editColObj.temObj
                            break;

                        case "1":
                            formList[i].temObj.colStyle.twoCol = editColObj.temObj
                            break;

                        case "2":
                            if(Object.keys(editColObj.temObj).length > 0){
                                formList[i].temObj.colStyle.threeCol = editColObj.temObj
                            }
                            break;

                        case "3":
                            if(Object.keys(editColObj.temObj).length > 0){
                                formList[i].temObj.colStyle.fourCol = editColObj.temObj
                            }
                            break;
                    }
                }
            }
            layer.close(addWindow)
            editColObj = {}
            colRender()
            reSortForm()
        },
        btn2:function(){
            editColObj = {}
        },
    });
}

// 一行多列 选择添加控件
function chooseColBtn(dom){
    $(dom).parent().parent().find('div').removeClass('activeChooseCol')
    $(dom).addClass('activeChooseCol')
    var type = $(dom).attr('data-type')
    var flag = $(dom).attr('data-flag')
    var num = $(dom).attr('data-num')
    if(type == "0"){
        return editColObj={noType:true,num:num,flag:flag}
    }
    editColObj = new Store({
        type:type
    })

    editColObj.dataFlag = flag
    editColObj.dataNum = num
}

function mouseDownBegin(e){
    $('#show-form').gridly('draggable', 'off');
    clearFlag = true
}

function mouseUpBegin(e){
    $('#show-form').gridly('draggable', 'on');
}

window.onmouseup =  function(){
    $('#show-form').gridly('draggable', 'on');
    setTimeout(function(){
        clearFlag = false
    })
}

function changeMoreBtn(obj){
    activeCol.temObj.colKtype = $(obj).attr('data-Ktype')
    colDataRender()
}

//一行多列布局按钮模板
function createMoreBtn(colKtype){
    if(colKtype=='L0101'){
        return '<div class="more-btn more-active" data-Ktype="L0101" onclick="changeMoreBtn(this)">两列</div>' +
            '<div class="more-btn" style="margin: 0 5px" data-Ktype="L0102" onclick="changeMoreBtn(this)">三列</div>' +
            '<div class="more-btn" data-Ktype="L0103" onclick="changeMoreBtn(this)">四列</div>'
    }else if(colKtype == 'L0102'){
        return '<div class="more-btn" data-Ktype="L0101" onclick="changeMoreBtn(this)">两列</div>' +
            '<div class="more-btn more-active" style="margin: 0 5px" data-Ktype="L0102" onclick="changeMoreBtn(this)">三列</div>' +
            '<div class="more-btn" data-Ktype="L0103" onclick="changeMoreBtn(this)">四列</div>'
    }else if(colKtype == 'L0103'){
        return '<div class="more-btn" data-Ktype="L0101" onclick="changeMoreBtn(this)">两列</div>' +
            '<div class="more-btn" style="margin: 0 5px" data-Ktype="L0102" onclick="changeMoreBtn(this)">三列</div>' +
            '<div class="more-btn more-active" data-Ktype="L0103" onclick="changeMoreBtn(this)">四列</div>'
    }
}

//一行多列占比模板
function createMoreProportion(colKtype,radio){
    if(colKtype=='L0101'){
        return '<div class="proportion '+ (radio=="50:50"?"proportion-active":"") +'" data-value="50:50" onclick="chooseRadio(this)">' +
            '<div class="proportion-item" style="width: 50%"><span style="display: inline-block;width: 95%">1/2</span></div>' +
            '<div class="proportion-item" style="width: 50%"><span style="display: inline-block;width: 95%">1/2</span></div>' +
            '</div>' +
            '<div class="proportion '+ (radio=="33.3:66.6"?"proportion-active":"") +'" data-value="33.3:66.6" onclick="chooseRadio(this)">' +
            '<div class="proportion-item" style="width: 33.3%"><span style="display: inline-block;width: 95%">1/3</span></div>' +
            '<div class="proportion-item" style="width: 66.6%"><span style="display: inline-block;width: 95%">2/3</span></div>' +
            '</div>' +
            '<div class="proportion '+ (radio=="66.6:33.3"?"proportion-active":"") +'" data-value="66.6:33.3" onclick="chooseRadio(this)">' +
            '<div class="proportion-item" style="width: 66.6%"><span style="display: inline-block;width: 95%">2/3</span></div>' +
            '<div class="proportion-item" style="width: 33.3%"><span style="display: inline-block;width: 95%">1/3</span></div>' +
            '</div>' +
            '<div class="proportion '+ (radio=="25:75"?"proportion-active":"") +'" data-value="25:75" onclick="chooseRadio(this)">' +
            '<div class="proportion-item" style="width: 25%"><span style="display: inline-block;width: 95%">1/4</span></div>' +
            '<div class="proportion-item" style="width: 75%"><span style="display: inline-block;width: 95%">3/4</span></div>' +
            '</div>' +
            '<div class="proportion '+ (radio=="75:25"?"proportion-active":"") +'" data-value="75:25" onclick="chooseRadio(this)">' +
            '<div class="proportion-item" style="width: 75%"><span style="display: inline-block;width: 95%">3/4</span></div>' +
            '<div class="proportion-item" style="width: 25%"><span style="display: inline-block;width: 95%">1/4</span></div>' +
            '</div>'

    }else if(colKtype == 'L0102'){
        return '<div class="proportion '+ (radio=="33.3:33.3:33.3"?"proportion-active":"") +'" data-value="33.3:33.3:33.3" onclick="chooseRadio(this)">' +
            '<div class="proportion-item" style="width: 33.3%"><span style="display: inline-block;width: 95%">1/3</span></div>' +
            '<div class="proportion-item" style="width: 33.3%"><span style="display: inline-block;width: 95%">1/3</span></div>' +
            '<div class="proportion-item" style="width: 33.3%"><span style="display: inline-block;width: 95%">1/3</span></div>' +
            '</div>' +
            '<div class="proportion '+ (radio=="25:25:50"?"proportion-active":"") +'" data-value="25:25:50" onclick="chooseRadio(this)">' +
            '<div class="proportion-item" style="width: 25%"><span style="display: inline-block;width: 95%">1/4</span></div>' +
            '<div class="proportion-item" style="width: 25%"><span style="display: inline-block;width: 95%">1/4</span></div>' +
            '<div class="proportion-item" style="width: 50%"><span style="display: inline-block;width: 95%">1/2</span></div>' +
            '</div>' +
            '<div class="proportion '+ (radio=="50:25:25"?"proportion-active":"") +'" data-value="50:25:25" onclick="chooseRadio(this)">' +
            '<div class="proportion-item" style="width: 50%"><span style="display: inline-block;width: 95%">1/2</span></div>' +
            '<div class="proportion-item" style="width: 25%"><span style="display: inline-block;width: 95%">1/4</span></div>' +
            '<div class="proportion-item" style="width: 25%"><span style="display: inline-block;width: 95%">1/4</span></div>' +
            '</div>' +
            '<div class="proportion '+ (radio=="25:50:25"?"proportion-active":"") +'" data-value="25:50:25" onclick="chooseRadio(this)">' +
            '<div class="proportion-item" style="width: 25%"><span style="display: inline-block;width: 95%">1/4</span></div>' +
            '<div class="proportion-item" style="width: 50%"><span style="display: inline-block;width: 95%">1/2</span></div>' +
            '<div class="proportion-item" style="width: 25%"><span style="display: inline-block;width: 95%">1/4</span></div>' +
            '</div>'
    }else if(colKtype == 'L0103'){
        return '<div class="proportion '+ (radio=="25:25:25:25"?"proportion-active":"") +'" data-value="25:25:25:25" onclick="chooseRadio(this)">' +
            '<div class="proportion-item" style="width: 25%"><span style="display: inline-block;width: 95%">1/4</span></div>' +
            '<div class="proportion-item" style="width: 25%"><span style="display: inline-block;width: 95%">1/4</span></div>' +
            '<div class="proportion-item" style="width: 25%"><span style="display: inline-block;width: 95%">1/4</span></div>' +
            '<div class="proportion-item" style="width: 25%"><span style="display: inline-block;width: 95%">1/4</span></div>' +
            '</div>'
    }
}

//多行控件修改占比
function chooseRadio(dom){
    this.activeCol.temObj.colStyle.shareRatio.ratio = $(dom).attr('data-value')
    if($(dom).attr('data-value').split(':').length == 2){
        this.activeCol.temObj.colStyle.threeCol = {}
        this.activeCol.temObj.colStyle.fourCol = {}
    }else if($(dom).attr('data-value').split(':').length == 3){
        this.activeCol.temObj.colStyle.fourCol = {}
    }
    colDataRender()
    colRender()
}

// 添加控件 系统控件是否重复
function isHasSystemCol(type){
    if(type == 'S01' || type == 'S02' || type == 'S03' || type == 'S04' || type == 'S05' || type == 'S06'){
        for(var i=0;i<formList.length;i++){
            if(formList[i].temObj.colType == type){
                return false
            }
            if(formList[i].temObj.colType == 'L01'){
                if(formList[i].temObj.colStyle.oneCol.colType == type){
                    return false
                }
                if(formList[i].temObj.colStyle.twoCol.colType == type){
                    return false
                }
                if(formList[i].temObj.colStyle.threeCol.colType == type){
                    return false
                }
                if(formList[i].temObj.colStyle.fourCol.colType == type){
                    return false
                }
            }
        }
    }
    return true
}

function init_auth() {
    console.log("关联表单初始化");
    var d = [];
    $.ajax({
        url: "/gappType/selectAllGappTypes",    //后台数据请求地址
        type: "get",
        async: true,
        success: function (resut) {
            d = resut.obj;
            var formatdata = [];
            for(var i=0;i<d.length;i++){
                // else{//没有子集直接显示
                var tempObject = {};
                tempObject.title = d[i].typeName;
                tempObject.id = d[i].typeId;
                tempObject.checked = false;
                tempObject.disabled = true;
                tempObject.children = getListChildren(d[i].gappChilds);
                if(d[i].childs != undefined){//如果有子集分类
                    tempObject.children = getChildren(d[i].childs);
                }
                formatdata.push(tempObject);
                // }
            }
            function getListChildren(childs){
                var tempArray = [];
                if(childs != undefined){//如果有子集表单
                    for(var h=0; h<childs.length; h++){
                        var tempChild = {};
                        tempChild.title = childs[h].gappName;
                        tempChild.id = childs[h].gappId;
                        tempChild.checked = true;
                        tempObject.gappType = childs[h].gappType;
                        tempArray.push(tempChild);
                    }
                }
                return tempArray;
            }
            function getChildren(childs){
                var tempArray = [];
                if(childs != undefined){//如果有子集
                    for(var h=0; h<childs.length; h++){
                        var tempChild = {};
                        tempChild.title = childs[h].typeName;
                        tempChild.id = childs[h].typeId;
                        tempChild.checked = true;
                        tempChild.disabled = true;
                        tempChild.children = getChildren(childs[h]);//递归调用子集
                        if(childs[h].gappChilds != undefined){//如果有子集表单
                            tempChild.children = getListChildren(childs[h].gappChilds);
                        }
                        tempArray.push(tempChild);
                    }
                }
                return tempArray;
            }
            //转成符合要求的格式
            console.log(formatdata);
            treeIndex = tree.render({
                elem: '#meuntree'
                , data: formatdata
                ,showLine: false
                ,id: 'demoId' //定义索引
                , click: function (obj) {
                    var data = obj.data;  //获取当前点击的节点数据
                    $(obj.elem).css('background','rgb(238,238,238)')
                    //layer.msg('状态：' + obj.state + '<br>节点数据：' + JSON.stringify(data));
                    // var $select = $($(this)[0].elem).parents(".layui-form-select");
                    // $select.removeClass("layui-form-selected").find(".layui-select-title span").html(obj.data.title).end().find("input:hidden[id='treeclass']").val(obj.data.id);

                    selectId = obj.data.id;
                    selectVal = obj.data.title;
                    $("#treeclass").attr('gappId',selectId);
                    $("#treeclass").val(selectVal);
                    $("#meuntree").slideUp(1000);
                }
            });
            $("#meuntree").hide();
            // $("#treeclass").val(selectVal);
            $("#treeclass").attr('gappId',selectId)
            var flags=true
            $("#treeclassbox").click(function (e) {
                if(flags){
                    $("#meuntree").slideDown(400);
                }else{
                    $("#meuntree").slideUp(400);
                }
                flags = !flags;
                return false;
                // event.stopPropagation();
            })
            treeIndex.reload();
            // $('.layui-tree-setHide').click(function (e) {
            //     console.log($(this).hasClass ('layui-tree-spread'))
            //     if($(this).hasClass ('layui-tree-spread')){
            //         $(this).children().find($('.layui-tree-iconArrow').addClass("layui-edge").removeClass("layui-tree-iconArrow"))
            //     }else{
            //         $(this).children().find($('.layui-tree-iconArrow').addClass("layui-tree-iconArrow").removeClass("layui-edge"))
            //     }
            // })
        }
    });
    //return data;
};
layui.use(['element','form','layer','laydate','tree','xmSelect'], function(){
    var $ = layui.jquery
    form = layui.form;
    var element = layui.element;
    var layer = layui.layer;
    laydate = layui.laydate;
    tree = layui.tree;
    xmSelect = layui.xmSelect;
    // $('.layui-form-select dl dt').css({"font-size":"15px","color":"#999"});
    // $(".layui-select-tips").remove();
    $.ajax({
        url:'/gappType/selectAllGappTypes',
        success:function(res){
            mydatas = res.obj
            // console.log(res.obj)
            // console.log(JSON.stringify(res.obj))
        }
    })


    $(".treeSelect").on("click", ".layui-select-title", function (e) {
        $(".layui-form-select").not($(this).parents(".layui-form-select")).removeClass("layui-form-selected");
        $(this).parents(".treeSelect").toggleClass("layui-form-selected");
        layui.stope(e);
    }).on("click", "dl i", function (e) {
        layui.stope(e);
    });
    // $(document).on("click", function (e) {
    //     $(".layui-form-select").removeClass("layui-form-selected");
    // });

    $.ajax({
        url:'/gtable/selectGtableByGappId',
        async:false,
        data:{
            gappId:gappId
        },
        success:function(res){
            layer.close(allIndex)
            msg = res.msg

            //null是没有,ok是有
            if(msg === "null"){
                // 拿到应用名称赋值给表单名称
                $.ajax({
                    url:'/gapp/selectGappByGappId',
                    data:{
                        gappId:gappId
                    },
                    success:function(data){
                        $('#tabName').val(data.object.gappName)
                    }
                })
            }else if(msg === 'ok'){
                tabId = res.object.tabId
                $('#tabName').val(res.object.tabName)
                getNewList()
            }
        }
    })
    //页签切换
    element.on('tab(docDemoTabBrief)', function(data){
        var objList = switchData(formList)
        if(data.index !=0){
            if(!whetherAddCol(formList)){
                layer.confirm('是否保存修改？', {
                    icon:3,
                    btn: ['确定','取消'], //按钮
                    title:'提示信息',
                    cancel:function(){
                        if(data.index === 1){
                            location.href = '/gapp/technological?gappId=' + gappId +'&typeId='+ typeId
                        }else if(data.index === 2){
                            location.href = '/gapp/listDesign?gappId=' + gappId +'&typeId='+ typeId
                        }else if(data.index === 3){
                            location.href = '/gapp/applicationSettings?gappId=' + gappId +'&typeId='+ typeId
                        }
                    }
                }, function(){
                    var index = layer.load(1, {
                        shade: [0.1,'#fff'] //0.1透明度的白色背景
                    });

                    for(var i=0;i<formList.length;i++){
                        if(formList[i].temObj.colName == ''){
                            layer.msg('控件名不可为空', {icon: 2});
                            $('.layui-tab-title').find('li').eq(data.index-1).click()
                            layer.close(index)
                            return

                        }
                    }

                    if(rulesFrom() !== 'true'){
                        layer.msg('控件 "'+ rulesFrom() +'" 重复', {icon: 2});
                        $('.layui-tab-title').find('li').eq(data.index-1).click()
                        layer.close(index)
                        return
                    }

                    if(msg === "null"){
                        //新增表单,返回一个tabId
                        $.ajax({
                            url:'/gtable/insertGtable',
                            data:{
                                gappId:gappId,
                                tabName:$('#tabName').val()
                            },
                            success:function(res){
                                tabId = res.object.tabId
                                typeId = res.object.typeId
                                $.ajax({
                                    url:'/gtablePriv/addGtablePriv',
                                    method:'post',
                                    data:{
                                        tabId:tabId,
                                        typeId:typeId
                                    },
                                    success:function(res){
                                        $.ajax({
                                            url:'/gcolumn/insertAndUpdateGcolumn',
                                            method:'post',
                                            data:{
                                                tabId:tabId,
                                                typeId:typeId,
                                                strJson:JSON.stringify(objList)
                                            },
                                            success:function(res){
                                                layer.close(index)
                                                if(res.msg === 'ok'){
                                                    if(data.index === 1){
                                                        location.href = '/gapp/technological?gappId=' + gappId +'&typeId='+ typeId
                                                    }else if(data.index === 2){
                                                        location.href = '/gapp/listDesign?gappId=' + gappId +'&typeId='+ typeId
                                                    }else if(data.index === 3){
                                                        location.href = '/gapp/applicationSettings?gappId=' + gappId +'&typeId='+ typeId
                                                    }
                                                }else{
                                                    layer.msg('控件保存失败', {icon: 2});
                                                }
                                            }
                                        })
                                    }
                                })

                            }
                        })
                    }else if(msg === "ok"){
                        //更新表单
                        $.ajax({
                            url:'/gtable/updateGtableByTabId',
                            data:{
                                tabId:tabId,
                                tabName:$('#tabName').val()
                            },
                            success:function(res){
                                $.ajax({
                                    url:'/gcolumn/insertAndUpdateGcolumn',
                                    method:'post',
                                    data:{
                                        tabId:tabId,
                                        strJson:JSON.stringify(objList)
                                    },
                                    success:function(res){
                                        layer.close(index)
                                        if(res.msg === 'ok'){
                                            if(data.index === 1){
                                                location.href = '/gapp/technological?gappId=' + gappId +'&typeId='+ typeId
                                            }else if(data.index === 2){
                                                location.href = '/gapp/listDesign?gappId=' + gappId +'&typeId='+ typeId
                                            }else if(data.index === 3){
                                                location.href = '/gapp/applicationSettings?gappId=' + gappId +'&typeId='+ typeId
                                            }
                                        }else{
                                            layer.msg('控件保存失败', {icon: 2});
                                        }
                                    }
                                })
                            }
                        })
                    }
                }, function(){
                    if(data.index === 1){
                        location.href = '/gapp/technological?gappId=' + gappId +'&typeId='+ typeId
                    }else if(data.index === 2){
                        location.href = '/gapp/listDesign?gappId=' + gappId +'&typeId='+ typeId
                    }else if(data.index === 3){
                        location.href = '/gapp/applicationSettings?gappId=' + gappId +'&typeId='+ typeId
                    }
                });
                return
            }
            var index = layer.load(1, {
                shade: [0.1,'#fff'] //0.1透明度的白色背景
            });

            $.ajax({
                url:'/gcolumn/isUpdateGcolumn',
                method:'POST',
                data:{
                    tabId:tabId,
                    strJson:JSON.stringify(objList)
                },
                success:function(res){
                    layer.close(index)
                    if(res.flag){
                        if(data.index === 1){
                            location.href = '/gapp/technological?gappId=' + gappId +'&typeId='+ typeId
                        }else if(data.index === 2){
                            location.href = '/gapp/listDesign?gappId=' + gappId +'&typeId='+ typeId
                        }else if(data.index === 3){
                            location.href = '/gapp/applicationSettings?gappId=' + gappId +'&typeId='+ typeId
                        }
                    }else{
                        layer.confirm('是否保存修改？', {
                            icon:3,
                            btn: ['确定','取消'], //按钮
                            title:'提示信息',
                            cancel:function(){
                                if(data.index === 1){
                                    location.href = '/gapp/technological?gappId=' + gappId +'&typeId='+ typeId
                                }else if(data.index === 2){
                                    location.href = '/gapp/listDesign?gappId=' + gappId +'&typeId='+ typeId
                                }else if(data.index === 3){
                                    location.href = '/gapp/applicationSettings?gappId=' + gappId +'&typeId='+ typeId
                                }
                            }
                        }, function(){
                            var index = layer.load(1, {
                                shade: [0.1,'#fff'] //0.1透明度的白色背景
                            });
                            $.ajax({
                                url:'/gcolumn/insertAndUpdateGcolumn',
                                method:'post',
                                data:{
                                    tabId:tabId,
                                    strJson:JSON.stringify(objList)
                                },
                                success:function(res){
                                    layer.close(index)
                                    if(res.msg === 'ok'){
                                        if(data.index === 1){
                                            location.href = '/gapp/technological?gappId=' + gappId +'&typeId='+ typeId
                                        }else if(data.index === 2){
                                            location.href = '/gapp/listDesign?gappId=' + gappId +'&typeId='+ typeId
                                        }else if(data.index === 3){
                                            location.href = '/gapp/applicationSettings?gappId=' + gappId +'&typeId='+ typeId
                                        }
                                    }else{
                                        layer.msg('控件保存失败', {icon: 2});
                                    }
                                }
                            })
                        }, function(){
                            if(data.index === 1){
                                location.href = '/gapp/technological?gappId=' + gappId +'&typeId='+ typeId
                            }else if(data.index === 2){
                                location.href = '/gapp/listDesign?gappId=' + gappId +'&typeId='+ typeId
                            }else if(data.index === 3){
                                location.href = '/gapp/applicationSettings?gappId=' + gappId +'&typeId='+ typeId
                            }
                        });
                    }
                }
            })
        }
    });

    // 控件点击,得到唯一焦点
    $("#context").on("click",".layui-form-item",function (e) {
        e.stopPropagation()
        var e = e || window.event;
        var target = e.target || e.srcElement;
        //删除控件
        if($(target).hasClass('col-icon-delete')){
            if(activeCol.temObj.colId){
                layer.confirm('是否删除该控件？', {
                    btn: ['确定','取消'] //按钮
                },function(){
                    var layopen = layer.load(1, {
                        shade: [0.1,'#fff'] //0.1透明度的白色背景
                    });
                    $.ajax({
                        url:'/gcolumn/deleteGcolumnByColIdAndTabId',
                        data:{
                            colId:activeCol.temObj.colId,
                            tabId:tabId
                        },
                        success:function(data){
                            layer.close(layopen)
                            if(data.msg == 'ok'){
                                removeCol()
                                layer.msg('删除成功', {icon: 6});
                            }else{
                                layer.msg('删除失败', {icon: 5});
                            }
                        }
                    })
                });
            }else{
                removeCol()
            }


            function removeCol(){
                var index //第几个元素
                var flag = false // 元素需要上移
                var height = 0 // 需要上移的高度
                var activeFlag = activeCol.temObj.flag
                for(var i=0;i<formList.length;i++){
                    if(formList[i].temObj.flag === activeFlag){
                        formList.splice(i,1)
                        index = i
                        flag = true
                        height = $('div[data-flag="' + activeFlag + '"]').css('height')
                    }else if(formList[i].type === 'L01'){
                        if(formList[i].temObj.colStyle.oneCol.flag == activeFlag){
                            formList[i].temObj.colStyle.oneCol = {}
                            index = i
                            flag = false
                            break;
                        }else if(formList[i].temObj.colStyle.twoCol.flag == activeFlag){
                            formList[i].temObj.colStyle.twoCol = {}
                            index = i
                            flag = false
                            break;
                        }else if(formList[i].temObj.colStyle.threeCol.flag == activeFlag){
                            formList[i].temObj.colStyle.threeCol = {}
                            index = i
                            flag = false
                            break;
                        }else if(formList[i].temObj.colStyle.fourCol.flag == activeFlag){
                            formList[i].temObj.colStyle.fourCol = {}
                            index = i
                            flag = false
                            break;
                        }
                    }else if(formList[i].type === 'L03'){
                        for(var j=0;j<formList[i].temObj.colStyle.length;j++){
                            if(formList[i].temObj.colStyle[j].temObj.flag === activeFlag){
                                formList[i].temObj.colStyle.splice(j,1)
                                index = i
                                flag = false
                            }
                        }
                    }
                }
                activeCol = undefined
                reRender(index,flag,height)
                $('.neirong .control-data-box').html('')
                form.render()
                return
            }
        }

        // 复制控件
        if($(target).hasClass('colCopy') || $(target).hasClass('col-icon-copy')){
            var str = ''
            var activeDomHeight = $('.input-active').eq(0).height() + 20
            var activeDomTop = $('.input-active').eq(0).css('top')
            if($(this).attr('data-table')){
                for(var i=0;i<formList.length;i++){
                    if(formList[i].type === 'L03'){
                        for(var j=0;j<formList[i].temObj.colStyle.length;j++){
                            if(formList[i].temObj.colStyle[j].temObj.flag === activeCol.temObj.flag){
                                formList[i].temObj.colStyle.splice(j+1,0,copyCol(activeCol))
                                break
                            }
                        }
                    }
                }
            }else{
                var newObj = copyCol(activeCol)
                newObj.temObj.top = activeDomTop
                formList.splice(activeIndex+1,0,newObj);
                for(var i = 0;i<formList.length;i++){
                    if (i>activeIndex+1){
                        formList[i].temObj.top  = parseInt(formList[i].temObj.top) + activeDomHeight + 'px'
                    }
                }
            }

            formList.forEach(function(item,index,arr){
                str += item.temObj.createTemplate(item.temObj.top,activeCol?activeCol.temObj.flag:'')
            })

            $('#show-form').html(str)
            form.render()
            return
        }

        //清除控件所有选中状态
        $('#show-form').find('.layui-form-item').removeClass('input-active')
        $('#show-form').find('.colDelete').css({display:'none'})
        $('#show-form').find('.colCopy').css({display:'none'})

        //找到当前控件添加活跃状态
        $(this).addClass('input-active')
        $(this).find('>.colDelete').css({display:'block'})
        $(this).find('>.colCopy').css({display:'block'})
        //当前活跃的下标和控件对象
        for(var i=0;i<formList.length;i++){
            if($(this).attr('data-flag') == formList[i].temObj.flag){
                activeIndex = i
                activeCol = formList[i]
                break;
            }else if(formList[i].type == 'L01'){
                if($(this).attr('data-flag') == formList[i].temObj.colStyle.oneCol.flag){
                    activeIndex = undefined
                    activeCol = {temObj:formList[i].temObj.colStyle.oneCol}
                    break;
                }else if($(this).attr('data-flag') == formList[i].temObj.colStyle.twoCol.flag){
                    activeIndex = undefined
                    activeCol = {temObj:formList[i].temObj.colStyle.twoCol}
                    break;

                }else if($(this).attr('data-flag') == formList[i].temObj.colStyle.threeCol.flag){
                    activeIndex = undefined
                    activeCol = {temObj:formList[i].temObj.colStyle.threeCol}
                    break;
                }else if($(this).attr('data-flag') == formList[i].temObj.colStyle.fourCol.flag){
                    activeIndex = undefined
                    activeCol = {temObj:formList[i].temObj.colStyle.fourCol}
                    break;
                }
            }else if(formList[i].type == 'L03'){
                for(var j=0;j<formList[i].temObj.colStyle.length;j++){
                    if($(this).attr('data-flag') == formList[i].temObj.colStyle[j].temObj.flag){
                        activeIndex = undefined
                        activeCol = {temObj:formList[i].temObj.colStyle[j].temObj,type:formList[i].temObj.colStyle[j].type}
                    }
                }
            }
        }

        //渲染控件属性
        $('.neirong .control-data-box').html(activeCol.temObj.formTem(false))
        $('#controlBtn').click()
        //监听控件表单,操作数据
        switch ($(this).attr('data-type')){
            case 'C01':
                form.on('select(colKtype)', function (data) {
                    activeCol.temObj.colKtype = $("select[name=colKtype]").val();
                });
                form.on('select(scanCheck)', function (data) {
                    activeCol.temObj.inputScan = $("select[name=scanCheck]").val();
                });
                // form.on('checkbox(isCheckhave)', function (data) {
                //     activeCol.temObj.isCheckhave = data.elem.checked?'1':'0'
                // });
                break

            case 'C03':
                changeDateType(activeCol)
                form.on('select(colKtype)', function (data) {
                    activeCol.temObj.colKtype = $("select[name=colKtype]").val();
                    activeCol.temObj.defaultVal = ''
                    $('.neirong .control-data-box').html(activeCol.temObj.formTem(false))
                    activeCol.temObj.colStyle = $("select[name=colStyle]").val();
                    changeDateType(activeCol)
                    form.render()
                });
                form.on('select(colStyle)', function (data) {
                    activeCol.temObj.colStyle = $("select[name=colStyle]").val();
                    activeCol.temObj.defaultVal = ''
                    $('.neirong .control-data-box').html(activeCol.temObj.formTem(false))
                    changeDateType(activeCol)
                    form.render()
                });
                break;

            case 'C04':
                function addFocus (){
                    $('#defaultNum').focus(function(e){
                        if($(this).attr('data-colKtype') == 'C0402'){
                            $(this).val(e.currentTarget.value.split(',').join(''))
                        }else if($(this).attr('data-colKtype') == 'C0403'){
                            $(this).val(e.currentTarget.value.split('%').join(''))
                        }
                    })
                }

                function addBlur(){
                    $('#defaultNum').blur(function(e){
                        if($(this).attr('data-colKtype') == 'C0401'){
                            var num = Number($(this).attr('data-colStyle')[$(this).attr('data-colStyle').length-1])
                            if(isNaN(Number($(this).val()))){
                                $(this).val('')
                            }else{
                                $(this).val(Number($(this).val()).toFixed(Number(num)))
                            }
                            activeCol.temObj.defaultVal = $(this).val()
                        }else if($(this).attr('data-colKtype') == 'C0402'){
                            var num = Number($(this).attr('data-colStyle')[$(this).attr('data-colStyle').length-1])
                            if(isNaN(Number($(this).val()))){
                                $(this).val('')
                            }else{

                                $(this).val(numFormat(Number($(this).val()).toFixed(Number(num))))
                            }
                            activeCol.temObj.defaultVal = $(this).val()
                        }else if($(this).attr('data-colKtype') == 'C0403'){
                            var num = Number($(this).attr('data-colStyle')[$(this).attr('data-colStyle').length-1])
                            if(isNaN(Number($(this).val()))){
                                $(this).val('')
                            }else{
                                $(this).val(Number($(this).val()).toFixed(Number(num)) + '%')
                            }
                            activeCol.temObj.defaultVal = $(this).val()
                        }
                    })
                }
                addFocus()
                addBlur()

                form.on('select(colKtype)', function (data) {
                    activeCol.temObj.colKtype = $("select[name=colKtype]").val();
                    activeCol.temObj.defaultVal = ''
                    $('.neirong .control-data-box').html(activeCol.temObj.formTem(false))
                    activeCol.temObj.colStyle = $("select[name=colStyle]").val();
                    form.render()
                    addFocus()
                    addBlur()
                });
                form.on('select(colStyle)', function (data) {
                    activeCol.temObj.colStyle = $("select[name=colStyle]").val();
                    activeCol.temObj.defaultVal = ''
                    $('.neirong .control-data-box').html(activeCol.temObj.formTem(false))
                    form.render()
                    addFocus()
                    addBlur()
                });
                break;

            case 'C05':
                form.on('radio(radio)', function (data) {
                    for(var i=0;i<activeCol.temObj.selectOption.length;i++){
                        activeCol.temObj.selectOption[i].checked = false
                        if(activeCol.temObj.selectOption[i].value == data.value){
                            activeCol.temObj.selectOption[i].checked = true
                        }
                    }
                    colRender()
                });
                break

            case 'C06':
                form.on('checkbox(checkbox)', function (data) {
                    activeCol.temObj.selectOption.forEach(function(item,index,arr){
                        if(item.value + '' == data.value){
                            item.checked = $(data.othis[0]).hasClass('layui-form-checked')
                        }
                    })
                    colRender()
                });
                break

            case 'C07':
                form.on('radio(radio)', function (data) {
                    for(var i=0;i<activeCol.temObj.selectOption.length;i++){
                        activeCol.temObj.selectOption[i].checked = false
                        if(activeCol.temObj.selectOption[i].value == data.value){
                            activeCol.temObj.selectOption[i].checked = true
                        }
                    }
                    colRender()
                });
                break

            case 'C08':
                form.on('select(colStyle)', function (data) {
                    activeCol.temObj.colStyle = data.value
                });
                break

            case 'C09':
                form.on('checkbox(colStyle)', function (data) {
                    var name = Number($(data.othis[0]).prev().eq(0).attr('name'))
                    activeCol.temObj.colStyle[name] = activeCol.temObj.colStyle[name] == 0?1:0
                    colDataRender()
                });
                break

            case 'C15':
                // form.on('select(colKtype)', function (data) {
                //     activeCol.temObj.colStyle = $("select[name=colKtype]").attr('gappid');
                //     form.render()
                // });
                // var itemObj = JSON.parse(activeCol.temObj.colStyle);
                // activeCol.temObj.colStyle.gappid = itemObj.gappid;
                // activeCol.temObj.colStyle.gappName = itemObj.gappName;
                init_auth();

                break

            case 'C16':
                form.on('switch(switch)', function(data){
                    if($(data.othis[0]).hasClass('layui-form-onswitch')){
                        activeCol.temObj.colStyle = true
                    }else{
                        activeCol.temObj.colStyle = false
                    }
                    colRender()
                });

                break

            case 'L01':

                break;
            case 'L02':
                form.on('radio(radio)', function (data) {
                    activeCol.temObj.colStyle = data.value
                    colRender()
                });
                break;
        }

        form.render()
    })

    //保存按钮
    $('#save').click(function(e){
        if(formList.length == 0){
            layer.msg('请添加控件', {icon: 2});
            return
        }

        for(var i=0;i<formList.length;i++){
            if(formList[i].temObj.colName == ''){
                layer.msg('控件名不可为空', {icon: 2});
                return
            }
        }

        if(rulesFrom() !== 'true'){
            layer.msg('控件名称 "'+ rulesFrom() +'" 重复', {icon: 2});
            return
        }

        if(msg === "null"){
            //新增表单,返回一个tabId
            $.ajax({
                url:'/gtable/insertGtable',
                data:{
                    gappId:gappId,
                    typeId:typeId,
                    tabName:$('#tabName').val()
                },
                success:function(res){
                    tabId = res.object.tabId
                    $.ajax({
                        url:'/gtablePriv/addGtablePriv',
                        method:'post',
                        data:{
                            tabId:tabId,
                            typeId:typeId,
                        },
                        success:function(res){
                        }
                    })
                    saveCol()
                }
            })


        }else if(msg === "ok"){
            //更新表单
            $.ajax({
                url:'/gtable/updateGtableByTabId',
                data:{
                    tabId:tabId,
                    tabName:$('#tabName').val()
                },
                success:function(res){
                    saveCol()
                }
            })
        }
    })

    function saveCol(){
        var index = layer.load(1, {
            shade: [0.1,'#fff'] //0.1透明度的白色背景
        });
        var objList = switchData(formList)
        for(var j=0; j<objList.length; j++) {
            if(objList[j].colType == 'L03') {
                var ss = objList[j].subDataTitle;
                var sarr = ss.split(',');
                var srr = []
                for(var k=0; k<sarr.length; k++) {
                    srr.push(sarr[k].split('.')[1])
                }
                objList[j].subDataTitle = srr.join(',')
            }
        }
        // 保存控件
        $.ajax({
            url:'/gcolumn/insertAndUpdateGcolumn',
            method:'post',
            data:{
                tabId:tabId,
                strJson:JSON.stringify(objList)
            },
            success:function(res){
                layer.close(index)
                if(res.msg === 'ok'){
                    sessionStorage.setItem('save','true')
                    location.reload()
                }else{
                    layer.msg('控件保存失败', {icon: 2});
                }
            }
        })
    }

    function switchData(list){
        var objList = []
        list.forEach(function(item,index,arr){
            var obj = {}
            switch(item.type){
                case "C01" :
                    if(item.temObj.colId){
                        obj.colId = item.temObj.colId
                    }
                    if(item.temObj.colDtype){
                        obj.colDtype = item.temObj.colDtype
                    }
                    obj.colKtype = item.temObj.colKtype
                    obj.colName = item.temObj.colName
                    obj.colType = item.temObj.colType
                    obj.defaultVal = item.temObj.defaultVal
                    obj.inputScan = item.temObj.inputScan
                    // obj.isCheckhave = item.temObj.isCheckhave?'0':'1'
                    obj.inputDesc = item.temObj.inputDesc
                    obj.inputTips = item.temObj.inputTips
                    obj.tabId = tabId
                    obj.colNo = index
                    objList.push(obj)
                    break;
                case "C02":
                    if(item.temObj.colId){
                        obj.colId = item.temObj.colId
                    }
                    if(item.temObj.colDtype){
                        obj.colDtype = item.temObj.colDtype
                    }
                    obj.colName = item.temObj.colName
                    obj.colType = item.temObj.colType
                    obj.defaultVal = item.temObj.defaultVal
                    obj.colStyle = item.temObj.colStyle
                    obj.inputDesc = item.temObj.inputDesc
                    obj.inputTips = item.temObj.inputTips
                    obj.tabId = tabId
                    obj.colNo = index
                    objList.push(obj)
                    break;
                case "C03":
                    if(item.temObj.colId){
                        obj.colId = item.temObj.colId
                    }
                    if(item.temObj.colDtype){
                        obj.colDtype = item.temObj.colDtype
                    }
                    obj.colName = item.temObj.colName
                    obj.colKtype = item.temObj.colKtype
                    obj.colType = item.temObj.colType
                    obj.colStyle = item.temObj.colStyle
                    obj.defaultVal = item.temObj.defaultVal
                    obj.inputDesc = item.temObj.inputDesc
                    obj.tabId = tabId
                    obj.colNo = index
                    objList.push(obj)
                    break;
                case "C04":
                    if(item.temObj.colId){
                        obj.colId = item.temObj.colId
                    }
                    if(item.temObj.colDtype){
                        obj.colDtype = item.temObj.colDtype
                    }
                    obj.colKtype = item.temObj.colKtype
                    obj.colStyle = item.temObj.colStyle
                    obj.colName = item.temObj.colName
                    obj.colType = item.temObj.colType
                    obj.defaultVal = item.temObj.defaultVal
                    obj.inputDesc = item.temObj.inputDesc
                    obj.tabId = tabId
                    obj.colNo = index
                    objList.push(obj)
                    break;
                case "C05":
                    if(item.temObj.colId){
                        obj.colId = item.temObj.colId
                    }
                    if(item.temObj.colDtype){
                        obj.colDtype = item.temObj.colDtype
                    }
                    obj.colStyle = {
                        selectOption:[],
                        selectedOption:[]
                    }
                    for(var i=0;i<item.temObj.selectOption.length;i++){
                        obj.colStyle.selectOption.push(item.temObj.selectOption[i].option)
                        if(item.temObj.selectOption[i].checked){
                            obj.colStyle.selectedOption.push(item.temObj.selectOption[i].option)
                        }
                    }
                    obj.colName = item.temObj.colName
                    obj.colType = item.temObj.colType
                    obj.inputDesc = item.temObj.inputDesc
                    obj.tabId = tabId
                    obj.colNo = index
                    objList.push(obj)
                    break;
                case "C06":
                    if(item.temObj.colId){
                        obj.colId = item.temObj.colId
                    }
                    if(item.temObj.colDtype){
                        obj.colDtype = item.temObj.colDtype
                    }
                    obj.colStyle = {
                        selectOption:[],
                        selectedOption:[]
                    }
                    for(var i=0;i<item.temObj.selectOption.length;i++){
                        obj.colStyle.selectOption.push(item.temObj.selectOption[i].option)
                        if(item.temObj.selectOption[i].checked){
                            obj.colStyle.selectedOption.push(item.temObj.selectOption[i].option)
                        }
                    }

                    obj.colName = item.temObj.colName
                    obj.colType = item.temObj.colType
                    obj.inputDesc = item.temObj.inputDesc
                    obj.tabId = tabId
                    obj.colNo = index
                    objList.push(obj)
                    break;
                case "C07":
                    if(item.temObj.colId){
                        obj.colId = item.temObj.colId
                    }
                    if(item.temObj.colDtype){
                        obj.colDtype = item.temObj.colDtype
                    }
                    obj.colStyle = {
                        selectOption:[],
                        selectedOption:[]
                    }
                    for(var i=0;i<item.temObj.selectOption.length;i++){
                        obj.colStyle.selectOption.push(item.temObj.selectOption[i].option)
                        if(item.temObj.selectOption[i].checked){
                            obj.colStyle.selectedOption.push(item.temObj.selectOption[i].option)
                        }
                    }
                    obj.colName = item.temObj.colName
                    obj.colType = item.temObj.colType
                    obj.inputDesc = item.temObj.inputDesc
                    obj.tabId = tabId
                    obj.colNo = index
                    objList.push(obj)
                    break;
                case "C08":
                    if(item.temObj.colId){
                        obj.colId = item.temObj.colId
                    }
                    if(item.temObj.colDtype){
                        obj.colDtype = item.temObj.colDtype
                    }
                    obj.colStyle = item.temObj.colStyle
                    obj.colName = item.temObj.colName
                    obj.colType = item.temObj.colType
                    obj.tabId = tabId
                    obj.colNo = index
                    objList.push(obj)
                    break
                case "C09":
                    if(item.temObj.colId){
                        obj.colId = item.temObj.colId
                    }
                    if(item.temObj.colDtype){
                        obj.colDtype = item.temObj.colDtype
                    }
                    if(item.temObj.colStyle[1] == 0){
                        item.temObj.colStyle[2] = 0
                        item.temObj.colStyle[3] = 0
                    }
                    obj.colStyle = item.temObj.colStyle
                    obj.colName = item.temObj.colName
                    obj.colType = item.temObj.colType
                    obj.tabId = tabId
                    obj.colNo = index
                    objList.push(obj)
                    break
                case "C15" :
                    if(item.temObj.colId){
                        obj.colId = item.temObj.colId
                    }
                    if(item.temObj.colDtype){
                        obj.colDtype = item.temObj.colDtype
                    }
                    obj.colStyle ={};
                    obj.colStyle.gappid=$("#treeclass").attr('gappid')
                    obj.colStyle.gappName=$("#treeclass").val()
                    obj.colName = item.temObj.colName
                    obj.colType = item.temObj.colType
                    obj.inputScan = item.temObj.inputScan
                    obj.inputDesc = item.temObj.inputDesc
                    obj.tabId = tabId
                    obj.colNo = index
                    objList.push(obj)
                    break;
                case "C16":
                    if(item.temObj.colId){
                        obj.colId = item.temObj.colId
                    }
                    if(item.temObj.colDtype){
                        obj.colDtype = item.temObj.colDtype
                    }
                    obj.colType = item.temObj.colType
                    obj.colStyle = item.temObj.colStyle?'1':'0'
                    obj.colName = item.temObj.colName
                    obj.tabId = tabId
                    obj.colNo = index
                    objList.push(obj)
                    break;

                case 'S01':
                    if(item.temObj.colId){
                        obj.colId = item.temObj.colId
                    }
                    if(item.temObj.colDtype){
                        obj.colDtype = item.temObj.colDtype
                    }
                    obj.colName = item.temObj.colName
                    obj.colType = item.temObj.colType
                    obj.tabId = tabId
                    obj.colNo = index
                    objList.push(obj)
                    break;
                case 'S02':
                    if(item.temObj.colId){
                        obj.colId = item.temObj.colId
                    }
                    if(item.temObj.colDtype){
                        obj.colDtype = item.temObj.colDtype
                    }
                    obj.colName = item.temObj.colName
                    obj.colType = item.temObj.colType
                    obj.tabId = tabId
                    obj.colNo = index
                    objList.push(obj)
                    break;
                case 'S03':
                    if(item.temObj.colId){
                        obj.colId = item.temObj.colId
                    }
                    if(item.temObj.colDtype){
                        obj.colDtype = item.temObj.colDtype
                    }
                    obj.colName = item.temObj.colName
                    obj.colType = item.temObj.colType
                    obj.tabId = tabId
                    obj.colNo = index
                    objList.push(obj)
                    break;
                case 'S04':
                    if(item.temObj.colId){
                        obj.colId = item.temObj.colId
                    }
                    if(item.temObj.colDtype){
                        obj.colDtype = item.temObj.colDtype
                    }
                    obj.colName = item.temObj.colName
                    obj.colType = item.temObj.colType
                    obj.tabId = tabId
                    obj.colNo = index
                    objList.push(obj)
                    break;
                case 'S05':
                    if(item.temObj.colId){
                        obj.colId = item.temObj.colId
                    }
                    if(item.temObj.colDtype){
                        obj.colDtype = item.temObj.colDtype
                    }
                    obj.colName = item.temObj.colName
                    obj.colType = item.temObj.colType
                    obj.tabId = tabId
                    obj.colNo = index
                    objList.push(obj)
                    break;
                case 'S06':
                    if(item.temObj.colId){
                        obj.colId = item.temObj.colId
                    }
                    if(item.temObj.colDtype){
                        obj.colDtype = item.temObj.colDtype
                    }
                    obj.colName = item.temObj.colName
                    obj.colType = item.temObj.colType
                    obj.tabId = tabId
                    obj.colNo = index
                    objList.push(obj)
                    break;

                case 'L01':
                    if(item.temObj.colId){
                        obj.colId = item.temObj.colId
                    }
                    if(item.temObj.colDtype){
                        obj.colDtype = item.temObj.colDtype
                    }
                    obj.colType = item.temObj.colType
                    obj.colKtype = item.temObj.colKtype

                    item.temObj.colStyle.oneCol = clearAddData(item.temObj.colStyle.oneCol,0)
                    item.temObj.colStyle.twoCol = clearAddData(item.temObj.colStyle.twoCol,1)
                    item.temObj.colStyle.threeCol = clearAddData(item.temObj.colStyle.threeCol,2)
                    item.temObj.colStyle.fourCol = clearAddData(item.temObj.colStyle.fourCol,3)

                    obj.colStyle = item.temObj.colStyle
                    obj.tabId = tabId
                    obj.colNo = index

                    objList.push(obj)
                    break;
                case 'L02':
                    if(item.temObj.colId){
                        obj.colId = item.temObj.colId
                    }
                    if(item.temObj.colDtype){
                        obj.colDtype = item.temObj.colDtype
                    }
                    obj.colType = item.temObj.colType
                    obj.colName = item.temObj.colName
                    obj.colStyle = item.temObj.colStyle
                    obj.tabId = tabId
                    obj.colNo = index
                    objList.push(obj)
                    break;
                case 'L03':
                    if(item.temObj.colId){
                        obj.colId = item.temObj.colId
                    }
                    if(item.temObj.colDtype){
                        obj.colDtype = item.temObj.colDtype
                    }
                    obj.colType = item.temObj.colType
                    obj.colName = item.temObj.colName
                    obj.colStyle = switchData(item.temObj.colStyle)
                    obj.tabId = tabId
                    obj.colNo = index
                    obj.subDataTitle = item.temObj.subDataTitle
                    objList.push(obj)
                    break
            }
        })
        return objList
    }
});
// 数据下拉
function dataSelect(data,tit,name) {
    console.log(data,tit,name)
    var dataArr = [];
    for(var i=0; i<data.length; i++) {
       var  obj = {};

       if(tit.indexOf(data[i].temObj.colName)>-1){
           obj.selected = true;
       }else{
           obj.selected = false;
       }
       obj.value = data[i].type;
       obj.name = name + '.' + data[i].temObj.colName;
       if(data[i].type != 'C08'&&data[i].type != 'C09'&&data[i].type != 'C15'&&data[i].type != 'L01'&&data[i].type != 'L02'&&data[i].type != 'L03'&&data[i].type != 'L04') {
           dataArr.push(obj)
       }
    }
    var s = [];
    for(var x=0; x<dataArr.length;x++) {
        if(dataArr[x].selected) {
           s.push(1)
        }
    }
    if(s.length > 0) {

    }else{
        if(dataArr.length > 0) {
            dataArr[0].selected = true;
        }
    }
    var demo1 = layui.xmSelect.render({
        el:'#dataTitleSelect',
        autoRow: true,
        data:dataArr,
        on:function(datas) {
            if(datas.arr.length == 0) {
                layui.layer.msg('最后一项不可删除！')
                if(!datas.isAdd){
                    var allItem = datas.change.find(function(item){
                        return item.value === datas.change[0].value;
                    })
                    if(allItem) {
                        return [allItem];
                    }
                }
                return false;
            }else{
                if($('#dataTitleSelect').length > 0) {
                    var str = '';
                    for(var j=0; j<datas.arr.length; j++) {
                        str += datas.arr[j].name + ',';
                    }
                    activeCol.temObj['subDataTitle'] = str;
                    // activeCol.temObj['subDataTitle'] = $('#dataTitleSelect').find('.label-content').attr('title');
                }
            }

        }
    })
}

function whetherAddCol(list){
    for(var i=0;i<list.length;i++){
        if(!list[i].temObj.colId){
            return false
        }else if(list[i].type === 'L01'){
            if(Object.keys(list[i].temObj.colStyle.oneCol).length && list[i].temObj.colStyle.oneCol.colId){
                return false
            }else if(Object.keys(list[i].temObj.colStyle.twoCol).length && list[i].temObj.colStyle.twoCol.colId){
                return false
            }else if(Object.keys(list[i].temObj.colStyle.threeCol).length && list[i].temObj.colStyle.threeCol.colId){
                return false
            }else if(Object.keys(list[i].temObj.colStyle.fourCol).length && list[i].temObj.colStyle.fourCol.colId){
                return false
            }
        }else if(list[i].type === 'L03'){
            var flag = whetherAddCol(list[i].temObj.colStyle)
            if(!flag) return flag
        }
    }
    return true
}

function copyCol(activeCol,isTable){
    var newObj
    switch (activeCol.type){
        case 'C01':
            newObj = new Store({
                type: activeCol.type
            })
            newObj.temObj.colKtype = activeCol.temObj.colKtype
            if(isTable||/_副本$/.test(activeCol.temObj.colName)){
                newObj.temObj.colName = activeCol.temObj.colName
            }else{
                newObj.temObj.colName = activeCol.temObj.colName + '_副本'
            }
            newObj.temObj.colType = activeCol.temObj.colType
            newObj.temObj.defaultVal = activeCol.temObj.defaultVal
            newObj.temObj.inputDesc = activeCol.temObj.inputDesc
            newObj.temObj.inputScan = activeCol.temObj.inputScan
            newObj.temObj.inputTips = activeCol.temObj.inputTips
            // newObj.temObj.isCheckhave = activeCol.temObj.isCheckhave
            break
        case 'C02':
            newObj = new Store({
                type: activeCol.type
            })
            newObj.temObj.colDtype = activeCol.temObj.colDtype
            if(isTable||/_副本$/.test(activeCol.temObj.colName)){
                newObj.temObj.colName = activeCol.temObj.colName
            }else{
                newObj.temObj.colName = activeCol.temObj.colName + '_副本'
            }
            newObj.temObj.colType = activeCol.temObj.colType
            newObj.temObj.defaultVal = activeCol.temObj.defaultVal
            newObj.temObj.inputDesc = activeCol.temObj.inputDesc
            newObj.temObj.colStyle = activeCol.temObj.colStyle
            newObj.temObj.inputTips = activeCol.temObj.inputTips
            break
        case 'C03':
            newObj = new Store({
                type: activeCol.type
            })
            if(isTable||/_副本$/.test(activeCol.temObj.colName)){
                newObj.temObj.colName = activeCol.temObj.colName
            }else{
                newObj.temObj.colName = activeCol.temObj.colName + '_副本'
            }
            newObj.temObj.colType = activeCol.temObj.colType
            newObj.temObj.defaultVal = activeCol.temObj.defaultVal
            newObj.temObj.inputDesc = activeCol.temObj.inputDesc
            break
        case 'C04':
            newObj = new Store({
                type: activeCol.type
            })
            if(isTable||/_副本$/.test(activeCol.temObj.colName)){
                newObj.temObj.colName = activeCol.temObj.colName
            }else{
                newObj.temObj.colName = activeCol.temObj.colName + '_副本'
            }
            newObj.temObj.colStyle = activeCol.temObj.colStyle
            newObj.temObj.colDtype = activeCol.temObj.colDtype
            newObj.temObj.colKtype = activeCol.temObj.colKtype
            newObj.temObj.colType = activeCol.temObj.colType
            newObj.temObj.defaultVal = activeCol.temObj.defaultVal
            newObj.temObj.inputDesc = activeCol.temObj.inputDesc
            break
        case 'C05':
            newObj = new Store({
                type: activeCol.type
            })
            newObj.temObj.colKtype = activeCol.temObj.colKtype
            if(isTable||/_副本$/.test(activeCol.temObj.colName)){
                newObj.temObj.colName = activeCol.temObj.colName
            }else{
                newObj.temObj.colName = activeCol.temObj.colName + '_副本'
            }
            newObj.temObj.selectOption = JSON.parse(JSON.stringify(activeCol.temObj.selectOption))
            newObj.temObj.colType = activeCol.temObj.colType
            newObj.temObj.inputDesc = activeCol.temObj.inputDesc
            break
        case 'C06':
            newObj = new Store({
                type: activeCol.type
            })
            newObj.temObj.colKtype = activeCol.temObj.colKtype
            if(isTable||/_副本$/.test(activeCol.temObj.colName)){
                newObj.temObj.colName = activeCol.temObj.colName
            }else{
                newObj.temObj.colName = activeCol.temObj.colName + '_副本'
            }
            newObj.temObj.selectOption = JSON.parse(JSON.stringify(activeCol.temObj.selectOption))
            newObj.temObj.colType = activeCol.temObj.colType
            newObj.temObj.inputDesc = activeCol.temObj.inputDesc
            break
        case 'C07':
            newObj = new Store({
                type: activeCol.type
            })
            newObj.temObj.colKtype = activeCol.temObj.colKtype
            if(isTable||/_副本$/.test(activeCol.temObj.colName)){
                newObj.temObj.colName = activeCol.temObj.colName
            }else{
                newObj.temObj.colName = activeCol.temObj.colName + '_副本'
            }
            newObj.temObj.selectOption = JSON.parse(JSON.stringify(activeCol.temObj.selectOption))
            newObj.temObj.colType = activeCol.temObj.colType
            newObj.temObj.inputDesc = activeCol.temObj.inputDesc
            break
        case 'C08':
            newObj = new Store({
                type: activeCol.type
            })
            newObj.temObj.colKtype = activeCol.temObj.colKtype
            if(isTable||/_副本$/.test(activeCol.temObj.colName)){
                newObj.temObj.colName = activeCol.temObj.colName
            }else{
                newObj.temObj.colName = activeCol.temObj.colName + '_副本'
            }
            newObj.temObj.colStyle = activeCol.temObj.colStyle
            newObj.temObj.colType = activeCol.temObj.colType
            newObj.temObj.inputDesc = activeCol.temObj.inputDesc
            break;
        case 'C09':
            newObj = new Store({
                type: activeCol.type
            })
            newObj.temObj.colKtype = activeCol.temObj.colKtype
            if(isTable||/_副本$/.test(activeCol.temObj.colName)){
                newObj.temObj.colName = activeCol.temObj.colName
            }else{
                newObj.temObj.colName = activeCol.temObj.colName + '_副本'
            }
            newObj.temObj.colStyle = JSON.parse(JSON.stringify(activeCol.temObj.colStyle))
            newObj.temObj.colType = activeCol.temObj.colType
            newObj.temObj.inputDesc = activeCol.temObj.inputDesc
            break
            break;
        case 'C16':
            newObj = new Store({
                type: activeCol.type
            })
            newObj.temObj.colKtype = activeCol.temObj.colKtype
            if(isTable||/_副本$/.test(activeCol.temObj.colName)){
                newObj.temObj.colName = activeCol.temObj.colName
            }else{
                newObj.temObj.colName = activeCol.temObj.colName + '_副本'
            }
            newObj.temObj.colStyle = activeCol.temObj.colStyle
            newObj.temObj.inputDesc = activeCol.temObj.inputDesc
            break

        case 'L01':
            newObj = new Store({
                type: activeCol.type
            })
            newObj.temObj.colKtype = activeCol.temObj.colKtype

            newObj.temObj.colStyle = {
                shareRatio:{
                    ratio:activeCol.temObj.colStyle.shareRatio.ratio
                },
                oneCol:{},
                twoCol:{},
                threeCol:{},
                fourCol:{},
            }
            break
        case 'L02':
            newObj = new Store({
                type: activeCol.type
            })
            if(isTable||/_副本$/.test(activeCol.temObj.colName)){
                newObj.temObj.colName = activeCol.temObj.colName
            }else{
                newObj.temObj.colName = activeCol.temObj.colName + '_副本'
            }
            newObj.temObj.colStyle = activeCol.temObj.colStyle
            break
        case 'L03':
            newObj = new Store({
                type: activeCol.type
            })
            if(/_副本$/.test(activeCol.temObj.colName)){
                newObj.temObj.colName = activeCol.temObj.colName
            }else{
                newObj.temObj.colName = activeCol.temObj.colName + '_副本'
            }
            for(let i=0;i<activeCol.temObj.colStyle.length;i++){
                newObj.temObj.colStyle.push(copyCol(activeCol.temObj.colStyle[i],true))
            }
            break
    }
    return newObj
}

// 时间控件默认值
function changeDateType(obj){
    switch (obj.temObj.colStyle){
        case 'C030101':
            laydate.render({
                elem: '#defaultDate'
                ,format: 'yyyy年MM月dd日'
                ,value: obj.temObj.defaultVal//默认值昨天
                ,done: function(value){
                    obj.temObj.defaultVal = value
                }
            });
            break;
        case 'C030102':
            laydate.render({
                elem: '#defaultDate'
                ,format: 'yyyy年MM月'
                ,value: obj.temObj.defaultVal//默认值昨天
                ,done: function(value){
                    obj.temObj.defaultVal = value
                }
            });
            break;
        case 'C030103':
            laydate.render({
                elem: '#defaultDate'
                ,format: 'MM月dd日'
                ,value: obj.temObj.defaultVal//默认值昨天
                ,done: function(value){
                    obj.temObj.defaultVal = value
                }
            });
            break;
        case 'C030104':
            laydate.render({
                elem: '#defaultDate'
                ,format: 'yyyy-MM-dd'
                ,value: obj.temObj.defaultVal//默认值昨天
                ,done: function(value){
                    obj.temObj.defaultVal = value
                }
            });
            break;
        case 'C030105':
            laydate.render({
                elem: '#defaultDate'
                ,format: 'yyyy-MM'
                ,type: 'month'
                ,value: obj.temObj.defaultVal
                ,done: function(value){
                    obj.temObj.defaultVal = value
                }
            });
            break;
        case 'C030106':
            laydate.render({
                elem: '#defaultDate'
                ,format: 'MM-dd'
                ,value: obj.temObj.defaultVal//默认值昨天
                ,done: function(value){
                    obj.temObj.defaultVal = value
                }
            });
            break;
        case 'C030107':
            laydate.render({
                elem: '#defaultDate'
                ,format: 'yyyy年'
                ,type: 'year'
                ,value: obj.temObj.defaultVal//默认值昨天
                ,done: function(value){
                    obj.temObj.defaultVal = value
                }
            });
            break;
        case 'C030108':
            laydate.render({
                elem: '#defaultDate'
                ,format: 'MM月'
                ,type: 'month'
                ,value: obj.temObj.defaultVal//默认值昨天
                ,done: function(value){
                    obj.temObj.defaultVal = value
                }
            });
            break;
        case 'C030201':
            laydate.render({
                elem: '#defaultDate'
                ,format: 'H点m分'
                ,type: 'time'
                ,value: obj.temObj.defaultVal//默认值昨天
                ,done: function(value){
                    obj.temObj.defaultVal = value
                }
            });
            break;
        case 'C030202':
            laydate.render({
                elem: '#defaultDate'
                ,format: 'H点m分s秒'
                ,type: 'time'
                ,value: obj.temObj.defaultVal//默认值昨天
                ,done: function(value){
                    obj.temObj.defaultVal = value
                }
            });
            break;
        case 'C030203':
            laydate.render({
                elem: '#defaultDate'
                ,format: 'H:m'
                ,type: 'time'
                ,value: obj.temObj.defaultVal//默认值昨天
                ,done: function(value){
                    obj.temObj.defaultVal = value
                }
            });
            break;
        case 'C030204':
            laydate.render({
                elem: '#defaultDate'
                ,format: 'H:m:s'
                ,type: 'time'
                ,value: obj.temObj.defaultVal//默认值昨天
                ,done: function(value){
                    obj.temObj.defaultVal = value
                }
            });
            break;
        case 'C030301':
            laydate.render({
                elem: '#defaultDate'
                ,format: 'yyyy年M月d日H时m分s秒'
                ,type:'datetime'
                ,value: obj.temObj.defaultVal//默认值昨天
                ,done: function(value){
                    obj.temObj.defaultVal = value
                }
            });
            break;
        case 'C030302':
            laydate.render({
                elem: '#defaultDate'
                ,format: 'yyyy-M-d H:m:s'
                ,type:'datetime'
                ,value: obj.temObj.defaultVal//默认值昨天
                ,done: function(value){
                    obj.temObj.defaultVal = value
                }
            });
            break;
    }
}

// 过滤子控件数据
 function clearAddData(obj,No){
    var newObj = {}
    switch(obj.colType){
        case "C01" :
            if(obj.colId){
                newObj.colId = obj.colId
            }
            if(obj.colDtype){
                newObj.colDtype = obj.colDtype
            }
            newObj.colKtype = obj.colKtype
            newObj.colName = obj.colName
            newObj.colType = obj.colType
            newObj.defaultVal = obj.defaultVal
            newObj.inputScan = obj.inputScan
            // obj.isCheckhave = obj.isCheckhave?'0':'1'
            newObj.inputDesc = obj.inputDesc
            newObj.inputTips = obj.inputTips
            newObj.tabId = tabId
            newObj.colNo = No
            break;
        case "C02":
            if(obj.colId){
                newObj.colId = obj.colId
            }
            if(obj.colDtype){
                newObj.colDtype = obj.colDtype
            }
            newObj.colName = obj.colName
            newObj.colType = obj.colType
            newObj.defaultVal = obj.defaultVal
            newObj.colStyle = obj.colStyle
            newObj.inputDesc = obj.inputDesc
            newObj.inputTips = obj.inputTips
            newObj.tabId = tabId
            newObj.colNo = No
            break;
        case "C03":
            if(obj.colId){
                newObj.colId = obj.colId
            }
            if(obj.colDtype){
                newObj.colDtype = obj.colDtype
            }
            newObj.colName = obj.colName
            newObj.colKtype = obj.colKtype
            newObj.colType = obj.colType
            newObj.colStyle = obj.colStyle
            newObj.defaultVal = obj.defaultVal
            newObj.inputDesc = obj.inputDesc
            newObj.tabId = tabId
            newObj.colNo = No
            break;
        case "C04":
            if(obj.colId){
                newObj.colId = obj.colId
            }
            if(obj.colDtype){
                newObj.colDtype = obj.colDtype
            }
            newObj.colKtype = obj.colKtype
            newObj.colStyle = obj.colStyle
            newObj.colName = obj.colName
            newObj.colType = obj.colType
            newObj.defaultVal = obj.defaultVal
            newObj.inputDesc = obj.inputDesc
            newObj.tabId = tabId
            newObj.colNo = No
            break;
        case "C05":
            if(obj.colId){
                newObj.colId = obj.colId
            }
            if(obj.colDtype){
                newObj.colDtype = obj.colDtype
            }
            newObj.colStyle = {
                selectOption:[],
                selectedOption:[]
            }
            for(var i=0;i<obj.selectOption.length;i++){
                newObj.colStyle.selectOption.push(obj.selectOption[i].option)
                if(obj.selectOption[i].checked){
                    newObj.colStyle.selectedOption.push(obj.selectOption[i].option)
                }
            }
            newObj.colName = obj.colName
            newObj.colType = obj.colType
            newObj.inputDesc = obj.inputDesc
            newObj.tabId = tabId
            newObj.colNo = No
            break;
        case "C06":
            if(newObj.colId){
                newObj.colId = obj.colId
            }
            if(newObj.colDtype){
                newObj.colDtype = obj.colDtype
            }
            newObj.colStyle = {
                selectOption:[],
                selectedOption:[]
            }
            for(var i=0;i<obj.selectOption.length;i++){
                newObj.colStyle.selectOption.push(obj.selectOption[i].option)
                if(obj.selectOption[i].checked){
                    newObj.colStyle.selectedOption.push(obj.selectOption[i].option)
                }
            }

            newObj.colName = obj.colName
            newObj.colType = obj.colType
            newObj.inputDesc = obj.inputDesc
            newObj.tabId = tabId
            newObj.colNo = No
            break;
        case "C07":
            if(obj.colId){
                newObj.colId = obj.colId
            }
            if(obj.colDtype){
                newObj.colDtype = obj.colDtype
            }
            newObj.colStyle = {
                selectOption:[],
                selectedOption:[]
            }
            for(var i=0;i<obj.selectOption.length;i++){
                newObj.colStyle.selectOption.push(obj.selectOption[i].option)
                if(obj.selectOption[i].checked){
                    newObj.colStyle.selectedOption.push(obj.selectOption[i].option)
                }
            }
            newObj.colName = obj.colName
            newObj.colType = obj.colType
            newObj.inputDesc = obj.inputDesc
            newObj.tabId = tabId
            newObj.colNo = No
            break;
        case "C08":
            if(obj.colId){
                newObj.colId = obj.colId
            }
            if(obj.colDtype){
                newObj.colDtype = obj.colDtype
            }
            newObj.colStyle = obj.colStyle
            newObj.colName = obj.colName
            newObj.colType = obj.colType
            newObj.tabId = tabId
            newObj.colNo = No
            break
        case "C09":
            if(obj.colId){
                newObj.colId = obj.colId
            }
            if(newObj.colDtype){
                newObj.colDtype = obj.colDtype
            }
            if(obj.colStyle[1] == 0){
                obj.colStyle[2] = 0
                obj.colStyle[3] = 0
            }
            newObj.colStyle = obj.colStyle
            newObj.colName = obj.colName
            newObj.colType = obj.colType
            newObj.tabId = tabId
            newObj.colNo = No
            break
        case "C16":
            if(obj.colId){
                newObj.colId = obj.colId
            }
            if(obj.colDtype){
                newObj.colDtype = obj.colDtype
            }
            newObj.colType = obj.colType
            newObj.colStyle = obj.colStyle?'1':'0'
            newObj.colName = obj.colName
            newObj.tabId = tabId
            newObj.colNo = No
            break;

        case 'S01':
            if(obj.colId){
                newObj.colId = obj.colId
            }
            if(obj.colDtype){
                newObj.colDtype = obj.colDtype
            }
            newObj.colName = obj.colName
            newObj.colType = obj.colType
            newObj.tabId = tabId
            newObj.colNo = No
            break;
        case 'S02':
            if(obj.colId){
                newObj.colId = obj.colId
            }
            if(obj.colDtype){
                newObj.colDtype = obj.colDtype
            }
            newObj.colName = obj.colName
            newObj.colType = obj.colType
            newObj.tabId = tabId
            newObj.colNo = No
            break;
        case 'S03':
            if(obj.colId){
                newObj.colId = obj.colId
            }
            if(obj.colDtype){
                newObj.colDtype = obj.colDtype
            }
            newObj.colName = obj.colName
            newObj.colType = obj.colType
            newObj.tabId = tabId
            newObj.colNo = No
            break;
        case 'S04':
            if(newObj.colId){
                newObj.colId = obj.colId
            }
            if(newObj.colDtype){
                newObj.colDtype = obj.colDtype
            }
            newObj.colName = obj.colName
            newObj.colType = obj.colType
            newObj.tabId = tabId
            newObj.colNo = No
            break;
        case 'S05':
            if(obj.colId){
                newObj.colId = obj.colId
            }
            if(obj.colDtype){
                newObj.colDtype = obj.colDtype
            }
            newObj.colName = obj.colName
            newObj.colType = obj.colType
            newObj.tabId = tabId
            newObj.colNo = No
            break;
        case 'S06':
            if(obj.colId){
                newObj.colId = obj.colId
            }
            if(obj.colDtype){
                newObj.colDtype = obj.colDtype
            }
            newObj.colName = obj.colName
            newObj.colType = obj.colType
            newObj.tabId = tabId
            newObj.colNo = No
            break;
    }
    return newObj
}

//点击图标添加
$('#chooses').on('click','.icon-add',function(e){
    var type = $(this).parent().parent().attr('data-type')
    var topList = []

    if(!isHasSystemCol(type)){
        return layer.msg('该类型控件在表单内唯一，不支持添加多个', {icon: 2});
    }

    var obj = new Store({
        type:type
    })
    formList.push(obj)
    var str = ''
    var height = 0
    var allHeight = 0
    $('#show-form>.layui-form-item').each(function(index){
        topList.push(parseInt($(this).css('top')))
        height += parseInt($(this).css('height'))
    })
    topList = quick(topList)

    formList.forEach(function(item,index,arr){
        allHeight += item.temObj.top
        if(index == formList.length-1){
            item.temObj.top = height
            str += item.temObj.createTemplate(item.temObj.top,activeCol?activeCol.temObj.flag:'')
        }else{
            item.temObj.top = topList[index]
            str += item.temObj.createTemplate(item.temObj.top,activeCol?activeCol.temObj.flag:'')
        }
    })
    $('#show-form').html(str)
    form.render()
    $('#context').scrollTop(allHeight)
    showColBtn()
    $('#show-form').children('div:last-child').click()
    positionTableProgress()
})

// 点击表单,清除控件焦点
$("#context").on("click",function () {
    if(clearFlag) {return clearFlag=false};
    $(this).find('.layui-form-item').removeClass('input-active')
    activeCol = undefined
    activeIndex = undefined
    $('.control-data-box').html('')
    $('#show-form').find('.colDelete').css({display:'none'})
    $('#show-form').find('.colCopy').css({display:'none'})
})

//鼠标移入控件
$("#context").on("mouseenter",".layui-form-item",function (e) {
    e.preventDefault()
    if($(this).hasClass('input-active')){
        $(this).removeClass('input-enter')
    }else{
        $(this).addClass('input-enter')
    }
})

//切换控件属性
$('#controlBtn').click(function(){
    $(this).css({
        color:'#389cff'
    })
    $(this).next().css({
        color:'#000000'
    })
    $(this).find('div').css({
        width:'100%'
    })
    $(this).next().find('div').css({
        width:'0'
    })
    $('.control-data-box').css({display:'block'})
    $('.form-data-box').css({display:'none'})
})

// 拖拽控件更改鼠标样式
document.getElementById('context').ondragover = function(e){
    e.preventDefault()
    e.dataTransfer.dropEffect = 'default'
}

for(var i=0;i<document.querySelectorAll('.tips').length;i++){
    document.querySelectorAll('.tips')[i].onmouseenter = tipsEnter
    document.querySelectorAll('.tips')[i].onmouseleave = tipsLeave
}

for(var i=0;i<document.querySelectorAll('#chooses li').length;i++){
    document.querySelectorAll('#chooses li')[i].ondragstart = function(e) {
        dragDom = this
    }
}

//拖拽添加控件
document.getElementById('context').ondrop = function(e){
    if(!dropFlag){return};
    var topList = []
    var type = $(dragDom).attr('data-type')

    if(!isHasSystemCol(type)){
        return layer.msg('该类型控件在表单内唯一，不支持添加多个', {icon: 2});
    }

    var obj = new Store({
        type:type
    })
    formList.push(obj)
    var str = ''
    var height = 0
    var allHeight = 0
    $('#show-form>.layui-form-item').each(function(index){
        topList.push(parseInt($(this).css('top')))
        height += parseInt($(this).css('height'))
    })
    topList = quick(topList)

    formList.forEach(function(item,index,arr){
        allHeight += item.temObj.top
        if(index == formList.length-1){
            item.temObj.top = height
            str += item.temObj.createTemplate(item.temObj.top,activeCol?activeCol.temObj.flag:'')
        }else{
            item.temObj.top = topList[index]
            str += item.temObj.createTemplate(item.temObj.top,activeCol?activeCol.temObj.flag:'')
        }
    })
    $('#show-form').html(str)
    form.render()
    $('#context').scrollTop(allHeight)
    showColBtn()
    $('#show-form').children('div:last-child').click()
    positionTableProgress()
}

// 列表鼠标移入显示添加按钮
$('.body li').mouseenter(function(e){
    $(this).find('.add').css({
        opacity:'1'
    })
})

// 列表鼠标离开隐藏添加按钮
$('.body li').mouseleave(function(){
    $(this).find('.add').css({
        opacity:'0'
    })
})

// 鼠标移入添加按钮高亮
$('.add').mouseenter(function (){
    $(this).find('.icon-add').attr('src','/ui/img/gapp/addC.svg')
})

// 鼠标离开添加按钮高亮
$('.add').mouseleave(function (){
    $(this).find('.icon-add').attr('src','/ui/img/gapp/addCA.svg')
})

//查询数据
function getNewList(){
    var index = layer.load(1, {
        shade: [0.1,'#fff'] //0.1透明度的白色背景
    });
    var time = new Date().getTime()
    $.ajax({
        url:'/gcolumn/selectAllByTabId',
        data:{
            tabId:tabId,
            _t:time
        },
        success:function(res1){
            layer.close(index)
            for(var i=0;i<res1.obj.length;i++){
                if(res1.obj[i].colType === 'L03'){
                    res1.obj[i].colStyle = JSON.parse(res1.obj[i].colStyle)
                }
            }

            // 组建数据,创建实例,并渲染控件
            for(var i=0;i<res1.obj.length;i++){
                var obj = fillData(res1.obj[i])
                formList.push(obj)
                var topList = []
                var str = ''
                var height = 0
                $('#show-form>.layui-form-item').each(function(index){
                    topList.push(parseInt($(this).css('top')))
                    height += parseInt($(this).css('height'))
                })
                topList = quick(topList)

                formList.forEach(function(item,index,arr){
                    if(index == formList.length-1){
                        item.temObj.top = height
                        str += item.temObj.createTemplate(item.temObj.top,activeCol?activeCol.temObj.flag:'')
                    }else{
                        item.temObj.top = topList[index]
                        str += item.temObj.createTemplate(item.temObj.top,activeCol?activeCol.temObj.flag:'')
                    }
                })
                $('#show-form').html(str)
                form.render()
            }
        }
    })
}

//补全控件数据
function fillData(colObj){
    var obj = {}
    switch (colObj.colType){
        case 'C01':
            obj = new Store({
                type:colObj.colType
            })
            obj.temObj.colDtype = colObj.colDtype
            obj.temObj.colId = colObj.colId
            obj.temObj.colKtype = colObj.colKtype
            obj.temObj.colName = colObj.colName
            obj.temObj.colType = colObj.colType
            obj.temObj.defaultVal = colObj.defaultVal
            obj.temObj.inputDesc = colObj.inputDesc
            obj.temObj.inputScan = colObj.inputScan
            obj.temObj.inputTips = colObj.inputTips
            // obj.temObj.isCheckhave = colObj.isCheckhave
            obj.temObj.tabId = colObj.tabId
            break
        case 'C02':
            obj = new Store({
                type:colObj.colType
            })
            obj.temObj.colDtype = colObj.colDtype
            obj.temObj.colId = colObj.colId
            obj.temObj.colName = colObj.colName
            obj.temObj.colType = colObj.colType
            obj.temObj.defaultVal = colObj.defaultVal
            obj.temObj.inputDesc = colObj.inputDesc
            obj.temObj.colStyle = colObj.colStyle
            obj.temObj.inputTips = colObj.inputTips
            obj.temObj.tabId = colObj.tabId
            break
        case 'C03':
            obj = new Store({
                type:colObj.colType
            })
            obj.temObj.colDtype = colObj.colDtype
            obj.temObj.colKtype = colObj.colKtype
            obj.temObj.colId = colObj.colId
            obj.temObj.colName = colObj.colName
            obj.temObj.colType = colObj.colType
            obj.temObj.colStyle = colObj.colStyle
            obj.temObj.defaultVal = colObj.defaultVal
            obj.temObj.inputDesc = colObj.inputDesc
            obj.temObj.tabId = colObj.tabId
            break
        case 'C04':
            obj = new Store({
                type:colObj.colType
            })
            obj.temObj.colStyle = colObj.colStyle
            obj.temObj.colDtype = colObj.colDtype
            obj.temObj.colId = colObj.colId
            obj.temObj.colKtype = colObj.colKtype
            obj.temObj.colName = colObj.colName
            obj.temObj.colType = colObj.colType
            obj.temObj.defaultVal = colObj.defaultVal
            obj.temObj.inputDesc = colObj.inputDesc
            obj.temObj.tabId = colObj.tabId
            break
        case 'C05':
            obj = new Store({
                type:colObj.colType
            })
            obj.temObj.colStyle = JSON.parse(colObj.colStyle)
            var list = []
            for(var j=0;j<obj.temObj.colStyle.selectOption.length;j++){
                var itemObj = {
                    option:obj.temObj.colStyle.selectOption[j],
                    checked:false,
                    value:j
                }
                if(itemObj.option == obj.temObj.colStyle.selectedOption[0]){
                    itemObj.checked = true
                }
                list.push(itemObj)
            }
            obj.temObj.selectOption = list
            obj.temObj.colDtype = colObj.colDtype
            obj.temObj.colId = colObj.colId
            obj.temObj.colName = colObj.colName
            obj.temObj.colType = colObj.colType
            obj.temObj.inputDesc = colObj.inputDesc
            obj.temObj.tabId = colObj.tabId
            break
        case 'C06':
            obj = new Store({
                type:colObj.colType
            })
            obj.temObj.colStyle = JSON.parse(colObj.colStyle)
            var list = []
            for(var j=0;j<obj.temObj.colStyle.selectOption.length;j++){
                var itemObj = {
                    option:obj.temObj.colStyle.selectOption[j],
                    checked:false,
                    value:j
                }
                for(var k=0;k<obj.temObj.colStyle.selectedOption.length;k++){
                    if(itemObj.option == obj.temObj.colStyle.selectedOption[k]){
                        itemObj.checked = true
                    }
                }

                list.push(itemObj)
            }
            obj.temObj.selectOption = list
            obj.temObj.colDtype = colObj.colDtype
            obj.temObj.colId = colObj.colId
            obj.temObj.colName = colObj.colName
            obj.temObj.colType = colObj.colType
            obj.temObj.inputDesc = colObj.inputDesc
            obj.temObj.tabId = colObj.tabId
            break
        case 'C07':
            obj = new Store({
                type:colObj.colType
            })
            obj.temObj.colStyle = JSON.parse(colObj.colStyle)
            var list = []
            for(var j=0;j<obj.temObj.colStyle.selectOption.length;j++){
                var itemObj = {
                    option:obj.temObj.colStyle.selectOption[j],
                    checked:false,
                    value:j
                }
                if(itemObj.option == obj.temObj.colStyle.selectedOption[0]){
                    itemObj.checked = true
                }
                list.push(itemObj)
            }
            obj.temObj.selectOption = list
            obj.temObj.colDtype = colObj.colDtype
            obj.temObj.colId = colObj.colId
            obj.temObj.colName = colObj.colName
            obj.temObj.colType = colObj.colType
            obj.temObj.inputDesc = colObj.inputDesc
            obj.temObj.tabId = colObj.tabId
            break
        case 'C08':
            obj = new Store({
                type:colObj.colType
            })
            obj.temObj.colStyle = colObj.colStyle
            obj.temObj.colDtype = colObj.colDtype
            obj.temObj.colId = colObj.colId
            obj.temObj.colName = colObj.colName
            obj.temObj.colType = colObj.colType
            obj.temObj.tabId = colObj.tabId
            break
        case 'C09':
            obj = new Store({
                type:colObj.colType
            })
            obj.temObj.colStyle = JSON.parse(colObj.colStyle)
            obj.temObj.colDtype = colObj.colDtype
            obj.temObj.colId = colObj.colId
            obj.temObj.colName = colObj.colName
            obj.temObj.colType = colObj.colType
            obj.temObj.tabId = colObj.tabId
            break
        case 'C15':
            obj = new Store({
                type:colObj.colType
            })
            obj.temObj.colStyle = colObj.colStyle
            obj.temObj.colId = colObj.colId
            obj.temObj.colKtype = colObj.colKtype
            obj.temObj.colName = colObj.colName
            obj.temObj.colType = colObj.colType
            obj.temObj.inputDesc = colObj.inputDesc
            obj.temObj.inputScan = colObj.inputScan
            obj.temObj.tabId = colObj.tabId
            break
        case 'C16':
            obj = new Store({
                type:colObj.colType
            })
            obj.temObj.colStyle = colObj.colStyle =="1"?true:false
            obj.temObj.colDtype = colObj.colDtype
            obj.temObj.colId = colObj.colId
            obj.temObj.colName = colObj.colName
            obj.temObj.colType = colObj.colType
            obj.temObj.tabId = colObj.tabId
            break

        case 'S01':
            obj = new Store({
                type:colObj.colType
            })
            obj.temObj.colDtype = colObj.colDtype
            obj.temObj.colId = colObj.colId
            obj.temObj.colKtype = colObj.colKtype
            obj.temObj.colName = colObj.colName
            obj.temObj.colType = colObj.colType
            obj.temObj.tabId = colObj.tabId
            break
        case 'S02':
            obj = new Store({
                type:colObj.colType
            })
            obj.temObj.colDtype = colObj.colDtype
            obj.temObj.colId = colObj.colId
            obj.temObj.colKtype = colObj.colKtype
            obj.temObj.colName = colObj.colName
            obj.temObj.colType = colObj.colType
            obj.temObj.tabId = colObj.tabId
            break
        case 'S03':
            obj = new Store({
                type:colObj.colType
            })
            obj.temObj.colDtype = colObj.colDtype
            obj.temObj.colId = colObj.colId
            obj.temObj.colKtype = colObj.colKtype
            obj.temObj.colName = colObj.colName
            obj.temObj.colType = colObj.colType
            obj.temObj.tabId = colObj.tabId
            break
        case 'S04':
            obj = new Store({
                type:colObj.colType
            })
            obj.temObj.colDtype = colObj.colDtype
            obj.temObj.colId = colObj.colId
            obj.temObj.colKtype = colObj.colKtype
            obj.temObj.colName = colObj.colName
            obj.temObj.colType = colObj.colType
            obj.temObj.tabId = colObj.tabId
            break
        case 'S05':
            obj = new Store({
                type:colObj.colType
            })
            obj.temObj.colDtype = colObj.colDtype
            obj.temObj.colId = colObj.colId
            obj.temObj.colKtype = colObj.colKtype
            obj.temObj.colName = colObj.colName
            obj.temObj.colType = colObj.colType
            obj.temObj.tabId = colObj.tabId
            break
        case 'S06':
            obj = new Store({
                type:colObj.colType
            })
            obj.temObj.colDtype = colObj.colDtype
            obj.temObj.colId = colObj.colId
            obj.temObj.colKtype = colObj.colKtype
            obj.temObj.colName = colObj.colName
            obj.temObj.colType = colObj.colType
            obj.temObj.tabId = colObj.tabId
            break

        case 'L01':
            obj = new Store({
                type:colObj.colType
            })
            obj.temObj.colDtype = colObj.colDtype
            obj.temObj.colId = colObj.colId
            obj.temObj.colType = colObj.colType
            obj.temObj.colKtype = colObj.colKtype
            obj.temObj.tabId = colObj.tabId
            obj.temObj.colStyle = colObj.colStyle
            obj.temObj.colStyle = JSON.parse(colObj.colStyle)
            if(Object.keys(obj.temObj.colStyle.oneCol).length>0){
                obj.temObj.colStyle.oneCol = fillData(obj.temObj.colStyle.oneCol).temObj
            }
            if(Object.keys(obj.temObj.colStyle.twoCol).length>0){
                obj.temObj.colStyle.twoCol = fillData(obj.temObj.colStyle.twoCol).temObj
            }
            if(Object.keys(obj.temObj.colStyle.threeCol).length>0){
                obj.temObj.colStyle.threeCol = fillData(obj.temObj.colStyle.threeCol).temObj
            }
            if(Object.keys(obj.temObj.colStyle.fourCol).length>0){
                obj.temObj.colStyle.fourCol = fillData(obj.temObj.colStyle.fourCol).temObj
            }
            break;

        case 'L02':
            obj = new Store({
                type:colObj.colType
            })
            obj.temObj.colId = colObj.colId
            obj.temObj.colDtype = colObj.colDtype
            obj.temObj.colKtype = colObj.colKtype
            obj.temObj.colName = colObj.colName
            obj.temObj.colType = colObj.colType
            obj.temObj.colStyle = colObj.colStyle
            obj.temObj.tabId = colObj.tabId
            break

        case 'L03':
            obj = new Store({
                type:colObj.colType
            })
            obj.temObj.colId = colObj.colId
            obj.temObj.colDtype = colObj.colDtype
            obj.temObj.colName = colObj.colName
            obj.temObj.colType = colObj.colType
            var list = []
            for(var i=0;i<colObj.colStyle.length;i++){
                list.push(fillData(colObj.colStyle[i]))
            }
            obj.temObj.colStyle = list
            obj.temObj.tabId = colObj.tabId
            obj.temObj.subDataTitle = colObj.subDataTitle?colObj.subDataTitle:colObj.colName
            break
    }
    return obj
}

//显示控件操作按钮
function showColBtn(){
    var activeDom = $('#show-form').find('.input-active')
    $(activeDom).find('.colDelete').css({display:'block'})
    $(activeDom).find('.colCopy').css({display:'block'})
}

//拖拽组件设置
var gridly_set = {
    //reordering拖拽前回调函数，reordered拖拽后回调函数
    callbacks:{ reordering: reordering , reordered: reordered },
};

$('#show-form').gridly(gridly_set);

//拖拽前回调
function reordering(e){
    // console.log(e)
}
//拖拽后回调
function reordered(e){
    setTimeout(function(){
        var newObjList = []
        var topObjList = []
        var colList = $('#show-form>.layui-form-item')
        for(var i=0;i<colList.length;i++){
            var obj = {
                top:parseInt($(colList[i]).css('top')),
                flag:$(colList[i]).attr('data-flag')
            }
            topObjList.push(obj)
        }

        var okList = topObjList.sort(compare('top'))
        for(var j=0;j<okList.length;j++){
            for(var k=0;k<formList.length;k++){
                if(formList[k].temObj.flag == okList[j].flag){
                    formList[k].temObj.top = okList[j].top
                    newObjList.push(formList[k])
                }
            }
        }
        formList = newObjList
        colRender()
        positionTableProgress()
    },300)
}

/*
** randomWord 产生任意长度随机字母数字组合
** randomFlag 是否任意长度 min 任意长度最小位[固定位数] max 任意长度最大位
*/
function randomWord(randomFlag, min, max) {
    let str = "",
        range = min,
        arr = [
            'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
            'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
            'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L',
            'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z','0', '1', '2', '3', '4', '5', '6', '7', '8', '9',];

    if (randomFlag) {
        range = Math.round(Math.random() * (max - min)) + min;// 任意长度
    }
    for (let i = 0; i < range; i++) {
        pos = Math.round(Math.random() * (arr.length - 1));
        str += arr[pos];
    }
    return str;
}

//递归排序
function quick(arr){
    if(arr.length<=1){
        return arr
    }
    var centerIndex = parseInt(arr.length / 2)
    var center  = arr.splice(centerIndex,1)[0]
    var left = []
    var right = []
    for(var i=0;i<arr.length;i++){
        if(arr[i]<center){
            left.push(arr[i])
        }else{
            right.push(arr[i])
        }
    }
    return quick(left).concat(center,quick(right))
}

function compare(property){
    return function(a,b){
        var value1 = a[property];
        var value2 = b[property];
        return value1 - value2;
    }
}

//控件排序
function colSort(arr){
    for (var i = 0; i<arr.length; i++) {
        for (var j =0;j<arr.length-i; j++) {
            if(arr[j]>arr[j+1]){
                var temp = arr[j];
                arr[j]=arr[j+1];
                arr[j+1]=temp;
            }
        }
    }
}

//数组相加
function listAdd(arr,index){
    var num = 0
    for (var i =0;i<=index;i++){
        num += arr[i]
    }
    return num
}

//提示层进入
function tipsEnter(e){
    if($(this).attr('data-tips')){
        switch ($(this).attr('data-tips')){
            case 'dataTitle' :
                $('#tips').text('数据标题用于快速辨别一条数据，适用于移动端列表显示，web列表首页标题，关联表单数据显示等场景中')
                break;
            case 'formDynamic' :
                $('#tips').text('未命名的表单开启后可在表单中增加评论功能，让员工讨论分享，发表意见建议等')
                break;
            case 'affairRemind' :
                $('#tips').text('开启后可在表单中增加任务提醒功能，根据需要新建提醒')
                break;
            case 'operationLog' :
                $('#tips').text('开启后可在电脑端表单中查看数据的操作记录')
                break;
            case '' :
                $('#tips').text('开启后可在表单中增加任务提醒功能，根据需要新建提醒')
                break;
        }
    }

    var obj = this.getBoundingClientRect()
    var x = obj.left - parseInt($('#tips').css('width'))/2
    var y = obj.top - parseInt($('#tips').css('height')) -25

    $('#tips').css({
        display:'block',
        top:y,
        left:x
    })
}

//提示层离开
function tipsLeave(e){
    setTimeout(function(){
        $('#tips').css({
            display:'none'
        })
    },100)
}

//重新加载表单
function colRender(){
    var str = ''
    formList.forEach(function(item,index,arr){
        str += item.temObj.createTemplate(item.temObj.top,activeCol?activeCol.temObj.flag:'')
    })
    $('#show-form').html(str)
    form.render()
}

//重新加载控件属性表单
function colDataRender(flag){
    if(flag){
        $('#addColForm').html(editColObj.temObj.formTem())
    }else{
        $('.neirong .control-data-box').html(activeCol.temObj.formTem(false))
    }
    form.render()
}

//描述进入事件
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

//描述离开事件
function colTipsLeave(){
    setTimeout(function(){
        $('#colDes').css({
            display:'none'
        })
    },100)
}

// 是否显示描述
function isHasDes(des){
    if(des){
        return ' <i class="layui-icon layui-icon-tips" data-des="' + des +'" onmouseenter="colTipsEnter(this)" onmouseleave="colTipsLeave(this)"></i>'
    }else{
        return ''
    }
}

// 保存前验证
function rulesFrom(){
    var obj = {}
    for(var i=0;i<formList.length;i++){
        if(formList[i].type=='L01'){
            if(Object.keys(formList[i].temObj.colStyle.oneCol).length>0){
                if(obj[formList[i].temObj.colStyle.oneCol.colName]){
                    obj[formList[i].temObj.colStyle.oneCol.colName]++
                }else{
                    obj[formList[i].temObj.colStyle.oneCol.colName] = 1
                }
            }

            if(Object.keys(formList[i].temObj.colStyle.twoCol).length>0){
                if(obj[formList[i].temObj.colStyle.twoCol.colName]){
                    obj[formList[i].temObj.colStyle.twoCol.colName]++
                }else{
                    obj[formList[i].temObj.colStyle.twoCol.colName] = 1
                }
            }

            if(Object.keys(formList[i].temObj.colStyle.threeCol).length>0){
                if(obj[formList[i].temObj.colStyle.threeCol.colName]){
                    obj[formList[i].temObj.colStyle.threeCol.colName]++
                }else{
                    obj[formList[i].temObj.colStyle.threeCol.colName] = 1
                }
            }

            if(Object.keys(formList[i].temObj.colStyle.fourCol).length>0){
                if(obj[formList[i].temObj.colStyle.fourCol.colName]){
                    obj[formList[i].temObj.colStyle.fourCol.colName]++
                }else{
                    obj[formList[i].temObj.colStyle.fourCol.colName] = 1
                }
            }
        }else if(formList[i].type=='L03'){
            if(obj[formList[i].temObj.colName]){
                obj[formList[i].temObj.colName]++
            }else{
                obj[formList[i].temObj.colName] = 1
            }
            for(var j=0;j<formList[i].temObj.colStyle.length;j++){
                if(obj[formList[i].temObj.colStyle[j].temObj.colName]){
                    obj[formList[i].temObj.colStyle[j].temObj.colName]++
                }else{
                    obj[formList[i].temObj.colStyle[j].temObj.colName] = 1
                }
            }
        }else{
            if(obj[formList[i].temObj.colName]){
                obj[formList[i].temObj.colName]++
            }else{
                obj[formList[i].temObj.colName] = 1
            }
        }
    }
    var strList = []
    for(var j=0;j<Object.keys(obj).length;j++){
        if(obj[Object.keys(obj)[j]]>1) {
            strList.push(Object.keys(obj)[j])
        }
    }
    if(strList.length==0){
        return 'true'
    }else{
        return strList.join(',')
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

// 表单重排
function reSortForm(){
    var allTop = 0
    $('#show-form>.layui-form-item').each(function(index,item){
        formList[index].temObj.top = allTop
        allTop += parseInt($(item).css('height'))
    })
    colRender()
    positionTableProgress()
}

// 表单重新渲染
function reRender(index,flag,height){
    var str = ''
    if(flag){
        for(var i=0;i<formList.length;i++){
            if(i>=index){
                formList[i].temObj.top = formList[i].temObj.top - Number(height.slice(0,-2))
            }
            str += formList[i].temObj.createTemplate(formList[i].temObj.top)
        }
        $('#show-form').html(str)
    }else{
        reSortForm()
    }
    positionTableProgress()
}

// 监听子表控件滚动条
function tableScroll(elem){
    tableProgress[$(elem).parent().attr('data-flag')] = $(elem).scrollLeft()
}

// 表格滚动条重新渲染(点睛之笔)
function positionTableProgress(){
    var keyList = Object.keys(tableProgress)
    for (var i=0;i<keyList.length;i++){
        $("div[data-flag=" + keyList[i] + "]").find('.table-col').scrollLeft(tableProgress[keyList[i]])
    }
}

// 表单子表添加字段
$("#context").on("click",".add-table-button",addTableField)
function addTableField(e){
    // e.stopPropagation()
    var flag = $(this).attr('data-add')
    var addWindow = layer.open({
        type: 1,
        title:'选择子表字段',
        area: ['300px', '550px'], //宽高
        btn:['确定','取消'],
        move:false,
        content: '<div>' +
            '<div>' +
            '<ul id="addColList">' +
            '<li ><div data-type="C01" onclick="chooseFieldBtn(this)">单行文本</div></li>' +
            '<li ><div data-type="C02" onclick="chooseFieldBtn(this)">多行文本</div></li>' +
            '<li ><div data-type="C03" onclick="chooseFieldBtn(this)">日期</div></li>' +
            '<li ><div data-type="C04" onclick="chooseFieldBtn(this)">数字</div></li>' +
            '<li ><div data-type="C05" onclick="chooseFieldBtn(this)">单选框</div></li>' +
            '<li ><div data-type="C06" onclick="chooseFieldBtn(this)">复选框</div></li>' +
            '<li ><div data-type="C07" onclick="chooseFieldBtn(this)">下拉框</div></li>' +
            '<li ><div data-type="C16" onclick="chooseFieldBtn(this)">是/否</div></li>' +
            '<li ><div data-type="C08" onclick="chooseFieldBtn(this)">附件</div></li>' +
            '<li ><div data-type="C09" onclick="chooseFieldBtn(this)">图片</div></li>' +
            '</ul>' +
            '</div>' +
            '</div>',
        yes:function(){
            var activeFieldBtn = $('#addColList').find('.activeChooseCol')
            if(activeFieldBtn.length){
                for(let i=0;i<formList.length;i++){
                    if(formList[i].temObj.flag === flag){
                        formList[i].temObj.colStyle.push(new Store({
                            type: $(activeFieldBtn[0]).attr('data-type')
                        }))
                        break
                    }
                }
                $('.neirong .control-data-box').html(activeCol.temObj.formTem(false))
                reSortForm()
                layer.close(addWindow)

            }else{
                layer.msg('请选择要添加的子表字段', {time: 2000, icon:7});
            }
        },
        btn2:function(){
            layer.close(addWindow)
        },
    });
}

// 表单子表添加字段
function chooseFieldBtn(elem){
    $('#addColList').find('div').removeClass('activeChooseCol')
    $(elem).addClass('activeChooseCol')
}

// 创建表格模板
function createTableItem(tableObj){
    var str = ''
    for(var i=0;i<tableObj.colStyle.length;i++){
        switch (tableObj.colStyle[i].type){
            case 'C01':
                str += '<div class="table-col-item table-col-preset layui-form-item' + ((tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag))?' input-active':'') + '" data-table="true" data-flag="'+ tableObj.colStyle[i].temObj.flag +'" data-type="' + tableObj.colStyle[i].type + '">' +
                    '   <div class="table-title">' + tableObj.colStyle[i].temObj.colName + '</div>' +
                    '   <div class="table-content"><input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请输入" class="layui-input"></div>' +
                    '   <div class="colDelete" ' + (tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag)?'style="display:block"':'') + '><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   <div class="colCopy" ' + (tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag)?'style="display:block"':'') + '><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                    '</div>'
                break;

            case 'C02':
                str += '<div class="table-col-item table-col-preset layui-form-item' + ((tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag))?' input-active':'') + '" data-table="true" data-flag="'+ tableObj.colStyle[i].temObj.flag +'" data-type="' + tableObj.colStyle[i].type + '">' +
                    '<div class="table-title">' + tableObj.colStyle[i].temObj.colName + '</div>' +
                    '<div class="table-content"><textarea placeholder="请输入" readonly class="layui-textarea"></textarea></div>' +
                    '   <div class="colDelete" ' + (tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag)?'style="display:block"':'') + '><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   <div class="colCopy" ' + (tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag)?'style="display:block"':'') + '><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                    '</div>'
                break;

            case 'C03':
                str += '<div class="table-col-item table-col-preset layui-form-item' + ((tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag))?' input-active':'') + '" data-table="true" data-flag="'+ tableObj.colStyle[i].temObj.flag +'" data-type="' + tableObj.colStyle[i].type + '">' +
                    '<div class="table-title">' + tableObj.colStyle[i].temObj.colName + '</div>' +
                    '<div class="table-content"><input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请选择" class="layui-input"/></div>' +
                    '   <div class="colDelete" ' + (tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag)?'style="display:block"':'') + '><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   <div class="colCopy" ' + (tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag)?'style="display:block"':'') + '><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +
                    '</div>'
                break;

            case 'C04':
                str += '<div class="table-col-item table-col-preset layui-form-item' + ((tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag))?' input-active':'') + '" data-table="true" data-flag="'+ tableObj.colStyle[i].temObj.flag +'" data-type="' + tableObj.colStyle[i].type + '">' +
                    '<div class="table-title">' + tableObj.colStyle[i].temObj.colName + '</div>' +
                    '<div class="table-content"><input type="text" name="title" lay-verify="title" readonly autocomplete="off" placeholder="请输入" class="layui-input"/></div>' +
                    '   <div class="colDelete" ' + (tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag)?'style="display:block"':'') + '><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   <div class="colCopy" ' + (tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag)?'style="display:block"':'') + '><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +           '</div>'
                break

            case 'C05':
                str += '<div class="table-col-item table-col-preset layui-form-item' + ((tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag))?' input-active':'') + '" data-table="true" data-flag="'+ tableObj.colStyle[i].temObj.flag +'" data-type="' + tableObj.colStyle[i].type + '">' +
                    '<div class="table-title">' + tableObj.colStyle[i].temObj.colName + '</div>' +
                    '<div class="table-content"><select readonly></select></div>' +
                    '   <div class="colDelete" ' + (tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag)?'style="display:block"':'') + '><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   <div class="colCopy" ' + (tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag)?'style="display:block"':'') + '><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +         '</div>'
                break;
            case 'C06':
                str += '<div class="table-col-item table-col-preset layui-form-item' + ((tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag))?' input-active':'') + '" data-table="true" data-flag="'+ tableObj.colStyle[i].temObj.flag +'" data-type="' + tableObj.colStyle[i].type + '">' +
                    '<div class="table-title">' + tableObj.colStyle[i].temObj.colName + '</div>' +
                    '<div class="table-content"><select readonly></select></div>' +
                    '   <div class="colDelete" ' + (tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag)?'style="display:block"':'') + '><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   <div class="colCopy" ' + (tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag)?'style="display:block"':'') + '><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +          '</div>'
                break;

            case 'C07':
                str += '<div class="table-col-item table-col-preset layui-form-item' + ((tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag))?' input-active':'') + '" data-table="true" data-flag="'+ tableObj.colStyle[i].temObj.flag +'" data-type="' + tableObj.colStyle[i].type + '">' +
                    '<div class="table-title">' + tableObj.colStyle[i].temObj.colName + '</div>' +
                    '<div class="table-content"><select readonly></select></div>' +
                    '   <div class="colDelete" ' + (tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag)?'style="display:block"':'') + '><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   <div class="colCopy" ' + (tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag)?'style="display:block"':'') + '><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +           '</div>'
                break;

            case 'C08':
                str += '<div class="table-col-item table-col-preset layui-form-item' + ((tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag))?' input-active':'') + '" data-table="true" data-flag="'+ tableObj.colStyle[i].temObj.flag +'" data-type="' + tableObj.colStyle[i].type + '">' +
                    '<div class="table-title">' + tableObj.colStyle[i].temObj.colName + '</div>' +
                    '<div class="table-content"><button type="button" class="layui-btn" disabled><i class="layui-icon">&#xe67c;</i>上传文件</button></div>' +
                    '   <div class="colDelete" ' + (tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag)?'style="display:block"':'') + '><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   <div class="colCopy" ' + (tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag)?'style="display:block"':'') + '><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +          '</div>'
                break;

            case 'C09':
                str += '<div class="table-col-item table-col-preset layui-form-item' + ((tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag))?' input-active':'') + '" data-table="true" data-flag="'+ tableObj.colStyle[i].temObj.flag +'" data-type="' + tableObj.colStyle[i].type + '">' +
                    '<div class="table-title">' + tableObj.colStyle[i].temObj.colName + '</div>' +
                    '<div class="table-content"><button type="button" class="layui-btn" disabled><i class="layui-icon">&#xe67c;</i>上传图片</button></div>' +
                    '   <div class="colDelete" ' + (tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag)?'style="display:block"':'') + '><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   <div class="colCopy" ' + (tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag)?'style="display:block"':'') + '><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +        '</div>'
                break;

            case 'C16':
                str += '<div class="table-col-item table-col-preset layui-form-item' + ((tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag))?' input-active':'') + '" data-table="true" data-flag="'+ tableObj.colStyle[i].temObj.flag +'" data-type="' + tableObj.colStyle[i].type + '">' +
                    '<div class="table-title">' + tableObj.colStyle[i].temObj.colName + '</div>' +
                    '<div class="table-content"><input type="checkbox" value="0" name="state" lay-skin="switch" lay-text="开|关" disabled></div>' +
                    '   <div class="colDelete" ' + (tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag)?'style="display:block"':'') + '><i class="layui-icon layui-icon-delete col-icon-delete"></i></div>\n' +
                    '   <div class="colCopy" ' + (tableObj.colStyle[i].temObj.flag===(activeCol&&activeCol.temObj.flag)?'style="display:block"':'') + '><i class="layui-icon layui-icon-list col-icon-copy"></i></div>\n' +    '</div>'
                break;

        }

    }

    setTimeout(function(){
        var hasTextArea = false
        for(var i=0;i<tableObj.colStyle.length;i++){
            if(tableObj.colStyle[i].type === 'C02'){
                hasTextArea = true
                break
            }else{
                hasTextArea = false
            }
        }

        if(hasTextArea){
            $('div[data-flag="'+ tableObj.flag +'"]').find('.table-col').addClass('has-textarea')
        }else{
            $('div[data-flag="'+ tableObj.flag +'"]').find('.table-col').removeClass('has-textarea')
        }
    },0)
    return str
}

function createTableFieldSort(list){
    var str = ''
    for(var i=0;i<list.length;i++){
        str += '<li data-field-flag="' + list[i].temObj.flag + '">' + list[i].temObj.colName + '<img src="/ui/img/gapp/drag.png" /></li>'
    }
    return str
}

// 开启子表字段排序
function postrionField(){
    $("#tableSort").dragsort({
        dragEnd:function(){
            var list = []
            var DOMlist = $('#tableSort').find('li')
            for(var i=0;i < DOMlist.length;i++){
                for(var j=0;j<activeCol.temObj.colStyle.length;j++){
                    if($(DOMlist[i]).attr('data-field-flag') === activeCol.temObj.colStyle[j].temObj.flag){
                        list.push(activeCol.temObj.colStyle[j])
                    }
                }
            }
            activeCol.temObj.colStyle = list
            reSortForm()
        }
    });
}