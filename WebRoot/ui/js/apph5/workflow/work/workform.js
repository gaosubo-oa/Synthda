var beforeToken = '';
var autocodeValue = '';
var countersignature_item = false;
var deleteITEMcountersignature_item = false;//用来判断 删除附件、图片控件时 新会签控件保存时得影响
var dataName = '';
var workForm = {
    inited:false,
    option : {
        formhtmlurl :domain+ '/form/formType',
        formid : 1,
        target:"",
        flowStep:1,//-1预览
        listFp:'',
        listTurnPriv:'',
        pageModel:'',
        flowRun:'',
        eleObject:{},
        formLength:0,
        preView :false,
        ish5:false,
        stepType :'',
        stepValue:'',
        ue:'',
        budgeId:'',
        sql:'',
        sqlList:'',
        inited:"",
        attributesStr:'',
        attributesTitle:'',
        snum:'',
        tip:'该流程超过中小企业免费版表单控件数量限制，请联系管理员！',
        tableName:$.GetRequest().tableName||''
        // footShow:0
    },
    init:function(options,cb){
        var _this = this;
        $.extend( _this.option, options );
        if(_this.option.preView){
            _this.option.resdata.preView = 1;
        }else{
            _this.option.resdata.preView = 0;
        }
        if(_this.option.beforeToken != ''&&_this.option.beforeToken != undefined){
            beforeToken = _this.option.beforeToken;
        }
        _this.option.prcsId = _this.option.resdata.prcsId;
        if(options.flag == '3'){
            return _this.getSearchData(cb);
        }
        _this.buildHTML(cb);
    },
    render:function(){
        this.ReBuild();
        this.MacrosRender();
        this.RadioRender();
        this.AutoCode();
        this.DateRender();
        this.ImgUpload();
        // this.KgSignRender();
        this.FileUpload();
        this.MacrosSignRender();
        this.MacrosSignRender2();
        this.userSelectRender();
        this.deptSelectRender();
        this.SignPluin();
        this.qrcodeRender();
        this.ListRender();
        this.textareaRender();
        this.calculationRender();
        this.readComments();
        this.filter();//表单流程权限控制
        this.TextRender();
        this.afterEvent();
        return   this.option.eleObject;
    },
    afterEvent:function () {
        var that = this;
        var calcItems = that.option.eleObject.find('.CALC');
        if(calcItems.length > 0){
            calcItems.each(function () {
                var clacitem = $(this);
                if(clacitem.attr('disabled') != 'disabled'){
                    var prec = clacitem.attr('prec')||3;
                    var calculationValue = clacitem.attr('formula');
                    if(calculationValue == undefined){
                        var calculationValue = clacitem.val();
                    }
                    var formitems = that.tool.getFormDatasKeyValue();
                    calculationValue = $.transforFormula(calculationValue,formitems);
                    clacitem.val(execC(calculationValue,prec));
                }
            })
        }
    },
    calculationRender:function(){
        var that = this;
        var formitems = {};
        var calcObj = that.option.eleObject.find('.CALC');
        if(calcObj.length > 0){
            formitems = that.tool.getFormDatasKeyValue();
        }
        that.option.eleObject.find('.CALC').each(function () {
            var calculationValue = $(this).attr('formula')||$(this).val();
            var _this = $(this);
            formitems.forEach(function(v,i){
                var calculateFlag = calculateFormitem(calculationValue,v.title);
                if(calculationValue != undefined && calculationValue.indexOf(v.title) > -1 &&calculateFlag){
                    var targetObj = workForm.option.eleObject.find('#'+v.id);
                    if(!targetObj.attr('calcutarget') ||  targetObj.attr('calcutarget') == ''){
                        targetObj.addClass("calculation");
                        targetObj.attr("calcutarget",_this.attr('id'))
                    }else{
                        targetObj.attr("calcutarget", targetObj.attr("calcutarget")+','+_this.attr('id'))
                    }
                }
            });
        });
        that.option.eleObject.on("input propertychange",'.calculation',function () {
            var _this = $(this);
            var targetId = _this.attr('calcutarget');
            targetId = targetId.split(',');

            targetId.forEach(function (item,i) {
                // console.log('target :'+i)
                var targetObj = $('#'+item) ;
                if(targetObj.attr('disabled') == 'disabled'){
                    return false;
                }
                if(targetObj.val()==undefined||targetObj.val()=='undefined'){
                    return false;
                }
                var prec = targetObj.attr('prec')||3;
                var calculationValue = targetObj.attr('formula');
                var formitems = that.tool.getFormDatasKeyValue();
                calculationValue = $.transforFormula(calculationValue,formitems);
                var vv = '';
                if(calculationValue.indexOf('DAY') >-1){
                    vv = execC(calculationValue,2);
                    if(vv.indexOf('.')>-1){
                        var float32nUM = parseFloat(vv.split('.')[1])/100;
                        if(float32nUM < 0.17){
                            vv = vv.split('.')[0];
                        }else if(float32nUM <= 0.5){
                            vv = vv.split('.')[0] + '.5';
                        }else if(float32nUM > 0.5){
                            vv = parseFloat(vv.split('.')[0])+1;
                        }
                    }
                    // vv= Math.floor(vv);

                }else if(calculationValue.indexOf('RMB') > -1){
                    vv = execC(calculationValue.replace('RMB', ''), prec)
                    vv = changeNumMoneyToChinese(vv);
                }else{
                    vv = execC(calculationValue,prec)
                }
                targetObj.val(vv).trigger("propertychange");
            });
        });

    },
    readComments:function () {
        var that = this;
        var readcommentsObj = that.option.eleObject.find('.readcomments');

        readcommentsObj.each(function () {
            var _this = $(this);
            var btnObj = $('<button targetid="'+_this.attr('id')+'" class="position: absolute !important;top:'+(_this.attr('orgheight')-15)+'px; !important">阅文意见</button>')

            var btn = _this.after(btnObj);
            _this.on('click',function () {
                // var targetid = $(this).attr('targetid');
                var targetid = _this.attr('id')
                // console.log($('#'+targetid))
                var valid = $(this).prev().val();
                var disable = $(this).prev().attr('disabled');
                if(disable != 'disabled'){
                    layer.open({
                        type: 1,
                        title: "阅文意见控件",
                        closeBtn: 0, //不显示关闭按钮
                        area: ['60%', '500px'],
                        content: $('#readcommentstpl').html(), //iframe的url，no代表不显示滚动条
                        btn: ['确定', '取消'],//按钮
                        success: function (num,a) {
                            $('.centertion textarea').append(valid);

                            $('.layui-rows ul li').click(function () {
                                $('.centertion textarea').append($(this).text())
                            });
                            $('.layui-rows select').change(function () {
                                var text = $(this).children('option:selected').html();
                                if(text.indexOf('┌') > -1){

                                    text = text.substr(text.lastIndexOf('┌')+1);
                                }
                                if(text.indexOf('├')>-1){
                                    text = text.substr(text.lastIndexOf('├')+1);
                                }else{
                                    text =text.replace('&nbsp;&nbsp;','')
                                }
                                $('.centertion textarea').append(text);
                                if($(this).attr('num') == 1){
                                    var that = $(this);
                                    var val = $(this).children('option:selected').val();
                                    $.ajax({
                                        url: "/user/getAllByDeptId",
                                        type: 'get',
                                        data: {deptId:val},
                                        dataType: 'json',
                                        beforeSend : function(request) {
                                            if(beforeToken != ''){
                                                request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
                                            }
                                        },
                                        success: function (obj) {
                                            var data = obj.obj;

                                            var arr=[];
                                            for(var i=0;i<data.length;i++){
                                                arr.push(data[i].deptName)
                                            }
                                            var str="<option value=''>请选择人员</option>"
                                            var arr2 = $.unique(arr)
                                            for(var j=0;j<arr2.length;j++){
                                                str += '<optgroup label="'+arr2[j]+'"></optgroup>'
                                                $.each(data,function(i,v){
                                                    if(v.deptName == arr2[j]){
                                                        str += '<option value="'+v.userId+'" >&nbsp;&nbsp;'+v.userName+'</option>'
                                                        that.next().append(str)
                                                    }
                                                })
                                            }
                                            that.next().html(str)
                                        },
                                        error: function () {
                                        }
                                    });
                                }
                            })
                        },
                        yes: function (num,a) {
                            var html = a.find('.centertion textarea').val();
                            $('.centertion textarea').eq(0).html('');
                            $('.centertion textarea').eq(1).html('');
                            $('#'+targetid).html(html)
                            layer.closeAll();

                        }

                    });
                }

            })
            btnObj.on('click',function () {
                // var targetid = $(this).attr('targetid');
                var targetid = _this.attr('id')
                // console.log($('#'+targetid))
                var valid = $(this).prev().val();
                var disable = $(this).prev().attr('disabled');
                if(disable != 'disabled'){
                    layer.open({
                        type: 1,
                        title: "阅文意见控件",
                        closeBtn: 0, //不显示关闭按钮
                        area: ['60%', '500px'],
                        content: $('#readcommentstpl').html(), //iframe的url，no代表不显示滚动条
                        btn: ['确定', '取消'],//按钮
                        success: function (num,a) {
                            $('.centertion textarea').append(valid);

                            $('.layui-rows ul li').click(function () {
                                $('.centertion textarea').append($(this).text())
                            });
                            $('.layui-rows select').change(function () {
                                var text = $(this).children('option:selected').html();
                                if(text.indexOf('┌') > -1){

                                    text = text.substr(text.lastIndexOf('┌')+1);
                                }
                                if(text.indexOf('├')>-1){
                                    text = text.substr(text.lastIndexOf('├')+1);
                                }else{
                                    text =text.replace('&nbsp;&nbsp;','')
                                }
                                $('.centertion textarea').append(text);
                                if($(this).attr('num') == 1){
                                    var that = $(this);
                                    var val = $(this).children('option:selected').val();
                                    $.ajax({
                                        url: "/user/getAllByDeptId",
                                        type: 'get',
                                        data: {deptId:val},
                                        dataType: 'json',
                                        beforeSend : function(request) {
                                            if(beforeToken != ''){
                                                request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
                                            }
                                        },
                                        success: function (obj) {
                                            var data = obj.obj;
                                            var arr=[];
                                            for(var i=0;i<data.length;i++){
                                                arr.push(data[i].deptName)
                                            }
                                            var str="<option value=''>请选择人员</option>"
                                            var arr2 = $.unique(arr)
                                            for(var j=0;j<arr2.length;j++){
                                                str += '<optgroup label="'+arr2[j]+'"></optgroup>'
                                                $.each(data,function(i,v){
                                                    if(v.deptName == arr2[j]){
                                                        str += '<option value="'+v.userId+'" >&nbsp;&nbsp;'+v.userName+'</option>'
                                                        that.next().append(str)
                                                    }
                                                })
                                            }
                                            that.next().html(str)
                                        },
                                        error: function () {
                                        }
                                    });
                                }
                            })
                        },
                        yes: function (num,a) {
                            var html = a.find('.centertion textarea').val();
                            $('.centertion textarea').eq(0).html('');
                            $('.centertion textarea').eq(1).html('');
                            $('#'+targetid).html(html)
                            layer.closeAll();

                        }

                    });
                }

            })
        });
    },
    qrcodeRender:function () {
        var that = this;
        var kgsignObj = that.option.eleObject.find('.qrcode');
        kgsignObj.each(function () {
            var _this = $(this);
            var orgtype = _this.attr('orgtype');
            var textStr = ''
            var id = _this.attr('id');

            if(orgtype == 'flowinfo'){
                textStr = (domain+'/workflow/work/workformh5PreView?flowId='+that.option.resdata.flowId+'&prcsId='+that.option.resdata.prcsId+'&flowStep='+that.option.resdata.flowStep+'&runId='+that.option.flowRun.runId)
            }else{
                // textStr = textStr
                textStr = _this.attr('content')
            }
            var objStr = $('<div id="'+id+'" textStr="'+textStr+'" name="'+_this.attr('name')+'" content="'+_this.attr('content')+'"  class="'+_this.attr('class')+'" data-type="qrcode" style="display: inline-block;vertical-align: middle;'+_this.attr('style')+'" title="'+_this.attr('title')+'" orgtype="'+_this.attr('orgtype')+'" orgwidth="'+_this.attr('orgwidth')+'" orgheight="'+_this.attr('orgheight')+'"></div>');
            _this.before(objStr);
            _this.remove();
            if(!that.option.ish5){
                var msg = {"mark":"SID_WORKFLOW","url":textStr}
                $.getScript(domain+'/lib/qrcode.js?20210414')
                    .done(function () {
                        var qrcode = new QRCode(id, {
                            text: JSON.stringify(msg),
                            width: _this.attr('orgwidth'),
                            height: _this.attr('orgheight'),
                            colorDark : '#000000',
                            colorLight : '#ffffff',
                            correctLevel :QRCode.CorrectLevel.H
                        });
                        // qrcode.makeCode
                    })
            }
        });
    },
    KgSignRender:function () {
        var that = this;
        var kgsignObj = that.option.eleObject.find('.kgsign');
        if(kgsignObj.length >0 && typeof Signature != "undefined"){
            kgsignObj.each(function () {
                var _this = $(this);
                var isPc = _this.attr('ispc');
                var isApp = _this.attr('isapp');
                var isSeal = _this.attr('isseal');
                var isHandwriting = _this.attr('ishandwriting');
                var isMoveable = _this.attr('ismoveable')=='1'?true:false;
                var serverConfig = {
                    keysn:'C84CF78C359E757E',
                    delCallBack: delCB,
                    imgtag: 0, //签章类型：0：无; 1:公章; 2:私章; 3:法人章; 4:法人签名; 5:手写签名
                    showSealsDlg: false,
                    password:'123456',
                    moveable: isMoveable,
                    valid : false,    //签章和证书有效期判断， 缺省不做判断
                    icon_move : isMoveable, //移动签章按钮隐藏显示，缺省显示
                    icon_remove : true, //撤销签章按钮隐藏显示，缺省显示
                    icon_sign : true, //数字签名按钮隐藏显示，缺省显示
                    icon_signverify : true, //签名验证按钮隐藏显示，缺省显示
                    icon_sealinfo : true, //签章验证按钮隐藏显示，缺省显示
                    certType : 'server',//设置证书在签章服务器
                    sealType : 'server',//设置印章从签章服务器取
                    serverUrl : 'http://192.168.0.146:8080/iSignatureHTML5',//
                    documentid:that.option.runId,//设置文档ID
                    documentname:that.option.flowRun.runName,//设置文档名称
                    pw_timeout:'s1800', //s：秒；h:小时；d:天
                    scaleImage: 0.9 //签章图片的缩放比例
                }
                var clientConfig = {//初始化属性
                    clientConfig:{//初始化客户端参数
                        'SOFTTYPE':'0'//0为：标准版， 1：网络版
                    },
                    delCallBack: delCB,
                    imgtag: 0, //签章类型：0：无; 1:公章; 2:私章; 3:法人章; 4:法人签名; 5:手写签名
                    valid : false,    //签章和证书有效期判断， 缺省不做判断
                    icon_move : isMoveable, //移动签章按钮隐藏显示，缺省显示
                    icon_remove : true, //撤销签章按钮隐藏显示，缺省显示
                    icon_sign : true, //数字签名按钮隐藏显示，缺省显示
                    icon_signverify : true, //签名验证按钮隐藏显示，缺省显示
                    icon_sealinfo : true, //签章验证按钮隐藏显示，缺省显示
                    certType : 'client',//设置证书在签章服务器
                    sealType : 'client',//设置印章从签章服务器取
                    serverUrl : 'http://192.168.0.146:8080/iSignatureHTML5',//
                    documentid:that.option.runId,//设置文档ID
                    documentname:that.option.flowRun.runName,//设置文档名称
                    pw_timeout:'s1800' //s：秒；h:小时；d:天
                };
                var bottomH5Str = 'bottom: 0px;';
                if(that.option.ish5){
                    bottomH5Str = 'bottom: 0px;';
                    Signature.init(serverConfig);
                }else{
                    Signature.init(clientConfig);
                }
                var divObjWidth =  Number(_this.attr('height'))+25;
                var divObj = $('<div name="'+_this.attr('name')+'" style="text-align: center; position:relative; inline-block;height: '+ divObjWidth +'px;width: '+_this.attr('width')+'px" class="form_item kgsign" data-type="kgsign" title="'+_this.attr('title')+'" gwidth="'+_this.attr('gwidth')+'" gheight="'+_this.attr('gheight')+'"  id="'+_this.attr('id')+'" signattrlist="'+_this.attr('signattrlist')+'"  ismoveable="'+_this.attr('ismoveable')+'" ispc="'+_this.attr('ispc')+'" isapp="'+_this.attr('isapp')+'" isseal="'+_this.attr('isseal')+'" ishandwriting="'+_this.attr('ishandwriting')+'" signlist="'+_this.attr('signlist')+'" ></div>');
                _this.removeAttr('id');
                _this.removeAttr("class");
                divObj.append(_this.prop("outerHTML"));
                if(isSeal == '1'&& isHandwriting == '1'){
                    divObj.append('<button SealType="1" style="width: 60px;'+bottomH5Str+'position: absolute;width: 72px;right: 72px;" >盖章</button><button  style="width: 60px;'+bottomH5Str+'position: absolute;width: 72px;right: 0px;" SealType="2">手写</button>');
                }else if(isSeal == '1'){
                    divObj.attr('SealType','1')
                }else if(isHandwriting == '1'){
                    divObj.attr('SealType','2')
                }
                _this.before(divObj);
                _this.remove();
                var signattrlist = _this.attr('signattrlist').split(",");
                signattrlist.forEach(function (v,i) {
                    var obj = that.option.eleObject.find('#'+v);
                    obj.attr('kg-desc',obj.attr('title'))
                });
                var posid = divObj.attr('id');
                divObj.on('click',function (e) {
                    var SealType = $(e.target).attr('SealType')||$(this).attr('SealType');
                    if(that.option.ish5){
                        if($(this).attr('isapp') != '1'){
                            layer.msg(wu, {time: 5000, icon:0});
                            return false;
                        }
                    }else{
                        if($(this).attr('ispc') != '1'){
                            layer.msg(wuqian, {time: 5000, icon:0});
                            return false;
                        }
                    }
                    if($(this).attr('disabled') !='disabled'){
                        var signatureCreator = Signature.create();
                        if(SealType == '2'){
                            signatureCreator.handWriteDlg({
                                image_height: "4",
                                image_width: "4",
                                onBegin: function() {
                                    //console.log('onbegin');
                                },
                                onEnd: function() {
                                    //console.log('onEnd');
                                }
                            }, function(param){
                                signatureCreator.runHW(param, {
                                    protectedItems:signattrlist,//设置定位页面DOM的id，自动查找ID，自动获取保护DOM的kg-desc属性作为保护项描述，value属性为保护数据。不设置，表示不保护数据，签章永远有效。
                                    position:posid,//设置盖章定位dom的ID，必须设置
                                    okCall: function(fn) {//点击确定后的回调方法，this为签章对象 ,签章数据撤销时，将回调此方法，需要实现签章数据持久化（保存数据到后台数据库）,保存成功后必须回调fn(true/false)渲染签章到页面上
                                        if( $('#'+posid).attr('signatureId')){
                                            $('#'+posid).attr('signatureId',$('#'+posid).attr('signatureId')+','+this.getSignatureid());
                                        }else{
                                            $('#'+posid).attr('signatureId',this.getSignatureid());
                                        }

                                        $('#'+posid).find('img').hide();
                                        fn(true);
                                    },
                                    cancelCall : function() {//点击取消后的回调方法
                                        //console.log(cancel)
                                    }
                                });
                            });
                        }else{
                            signatureCreator.run({
                                protectedItems:signattrlist,//设置定位页面DOM的id，自动查找ID，自动获取保护DOM的kg-desc属性作为保护项描述，value属性为保护数据。不设置，表示不保护数据，签章永远有效。
                                position: posid,//设置盖章定位dom的ID，必须设置
                                okCall: function(fn, image) {//点击确定后的回调方法，this为签章对象 ,签章数据撤销时，将回调此方法，需要实现签章数据持久化（保存数据到后台数据库）,保存成功后必须回调fn(true/false)渲染签章到页面上

                                    var signlist = $('#'+posid).attr('signlist');
                                    if(signlist !=0 && signlist != this.oriSignatureData.seal.signsn){
                                        var layerindex = layer.alert("您签章权限不符，请重新签署！", {
                                            skin: 'layui-layer-molv' //样式类名
                                            ,closeBtn: 0
                                        }, function(){
                                            layer.close(layerindex);
                                        });
                                    }

                                    if( $('#'+posid).attr('signatureId')){
                                        $('#'+posid).attr('signatureId',$('#'+posid).attr('signatureId')+','+this.getSignatureid());
                                    }else{
                                        $('#'+posid).attr('signatureId',this.getSignatureid());
                                    }

                                    $('#'+posid).find('img').hide();

                                    fn(true);
                                },
                                cancelCall : function() {//点击取消后的回调方法
                                    //console.log(cancel)
                                }
                            });
                        }

                    }
                })
            });
        }
    },
    SignPluin:function () {
        // 获取服务器时间
        var serverDate = {
            T: '',
            TS: ''
        }
        $.ajax({
            async: false,
            type: "GET",
            success: function (result, status, xhr) {
                time = new Date(xhr.getResponseHeader("Date"));
                year = time.getFullYear();
                //以下是通过三元运算对日期进行处理,小于10的数在前面加上0
                month = (time.getMonth() + 1) < 10 ? ("0" + (time.getMonth() + 1)) : (time.getMonth() + 1)
                date = time.getDate() < 10 ? ("0" + time.getDate()) : time.getDate();
                hours = time.getHours() < 10 ? ("0" + time.getHours()) : time.getHours();
                minutes = (time.getMinutes() < 10 ? ("0" + time.getMinutes()) : time.getMinutes());
                seconds = (time.getSeconds() < 10 ? ("0" + time.getSeconds()) : time.getSeconds());

                //拼成自己想要的日期格式，2018-01-15 19:05:33
                serverDate.T = year + "-" + month + "-" + date + " " + hours + ":" + minutes + ":" + seconds;
                serverDate.TS = year + "-" + month + "-" + date;
            },
            error: function (a) {

            }
        });
        var that = this;
        var signglobleObjWN = '';
        if(workForm.option.flowProcesses){
            signglobleObjWN = workForm.option.flowProcesses.prcsName;
        }

        signglobleObj = {
            C:'',
            U:workForm.tool.MacrosData.data.sYS_USERNAME || workForm.tool.MacrosData.data.sys_USERNAME ,
            D:workForm.tool.MacrosData.data.sYS_DEPTNAME || workForm.tool.MacrosData.data.sys_DEPTNAME ,
            R:workForm.tool.MacrosData.data.sYS_USERPRIV || workForm.tool.MacrosData.data.sys_USERPRIV ,
            T: serverDate.T || new Date().Format('yyyy-MM-dd hh:mm:ss'),
            TS: serverDate.TS || new Date().Format('yyyy-MM-dd hh:mm:ss'),
            P:'',
            O:'',
            DS:workForm.tool.MacrosData.data.sYS_DEPTNAME_SHORT || workForm.tool.MacrosData.data.sys_DEPTNAME_SHORT,
            WN:signglobleObjWN
        };
        this.option.eleObject.find('.sign').each(function () {
            if($(this).attr('orgtempl')!=undefined){
                var orgtempl =  $(this).attr('orgtempl').replace(/\r?\n/gi, "<br/>").replace(/\ /g, "&nbsp;");
                orgtempl = Mustache.render(orgtempl,signglobleObj)
                orgtempl = orgtempl.replace(signglobleObj.C, "<span class='sign_content'>"+signglobleObj.C+'</span>')
                var height = '';
                if($(this).height()){
                    height = 'min-height: '+ $(this).height() +'px;height: auto;'
                }
                var textArea = $('<div style="word-wrap: break-word;text-align: left;'+$(this).attr('style')+';'+ height +'" templ="'+orgtempl+'" width="" height=""><div id="eiderarea" class="eiderarea">'+orgtempl+'<div></div>');
                $(this).attr('style','width:'+$(this).attr('gwidth')+'px;height:'+$(this).attr('gheight')+'px;'+$(this).attr('style'));
                $(this).bind("input propertychange", function () {
                    var pre = $(this).prev();
                    // var v = Mustache.render(pre.attr('templ').replace('</div>',''),{content:$(this).val()});
                    var templ = pre.attr('templ');
                    if (templ.indexOf('eiderarea') == -1) {
                        templ = templ.replace('</div>','');
                        templ = '<div id="eiderarea" class="eiderarea">'+templ+'</div>';
                        pre.attr('templ', templ);
                    }
                    // var v = Mustache.render(templ,{content:$(this).val()});
                    var v = templ
                    if(v.indexOf('\n')>-1){
                        // v = v.replace('\n','<br/>');
                        v = v.replace(/\n/g,'<br/>')
                    }
                    var $div = $('<div>'+v+'</div>');
                    $div.find('.eiderarea').eq($div.find('.eiderarea').length-1).find('.sign_content').text($(this).val())
                    var flowRunPrcs = workForm.option.flowRunPrcs;
                    var timeStamp = new Date().getTime();
                    $div.find('.eiderarea').last().append('<strong class="remove_sign">x</strong>')
                        .attr('user_id', flowRunPrcs.userId).attr('prcs_id', flowRunPrcs.flowPrcs).attr('time_stamp', timeStamp);

                    pre.attr('tv',$div.html());

                    $div.find('.eiderarea').each(function(index){
                        if ($(this).attr('user_id') == flowRunPrcs.userId && $(this).attr('prcs_id') == flowRunPrcs.flowPrcs && $(this).attr('time_stamp')) {
                            if ($div.find('.eiderarea').length - 1 > index) {
                                $(this).find('.remove_sign').show()
                            }
                        } else {
                            $(this).find('.remove_sign').hide()
                        }
                    });

                    // pre.html('<div id="eiderarea" class="eiderarea">'+v+'</div>')
                    pre.html($div.html())
                });
                $(this).before(textArea);
            }
        });

    },
    ImgUpload:function(){

        var that = this;
        var uploadformObj = '<form id="imgupload" target="uploadiframe" action="/upload?module=workflow" method="post"><input type="file" multiple="multiple" name="file" id="imguploadinput" class="w-icon5" style="display:none;"></form>';
        $('body').append(uploadformObj);
        var imuploadobj = {};
        that.option.eleObject.on('click','.imgupload',function(){
            if($(this).attr('disabled') != 'disabled'){

                imuploadobj = $(this);
                $('#imguploadinput').attr('accept','.png,.jpg,.jpeg,.gif,.bmp').click();
            }
        });
        $('#imguploadinput').on('change', function() {
            if($('#imguploadinput').val() != ''){
                $("#imgupload").ajaxSubmit(function (res) {
                    res = JSON.parse(res);
                    for(var i=0;i<res.obj.length;i++){
                        var thisspan = res.obj[i].attachName;
                        var sys_userId = workForm.tool.MacrosData.data.sYS_USERID|| workForm.tool.MacrosData.data.sys_USERID;
                        var str = '/xs?'+res.obj[i].attUrl+'&userid='+ sys_userId;
                        var strs = str.split('&ATTACHMENT_NAME=')[0];
                        var name = str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[0];
                        var attName = encodeURI(name).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                        var atturl =strs+"&ATTACHMENT_NAME="+attName+"&FILESIZE="+str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[1];

                        var listStr = '<div class="imgfileBox" style="display:  inline-block;position:  relative;padding-left:0px;"><img name="'+imuploadobj.attr('name')+'" src="'+ encodeURI(atturl) +'" style="position:static;width:'+imuploadobj.attr('width')+'px !important;height:'+imuploadobj.attr('height')+'px !important;cursor: pointer;'+imuploadobj.attr('style')+'"  id="'+imuploadobj.attr('name')+'" title="'+res.obj[i].attachName+'" align="absmiddle" style=""  class="imgupload_data"    width="'+imuploadobj.attr('width')+'" height="'+imuploadobj.attr('height')+'"/><span class="uploadImg"title="'+ res.obj[i].attachName +'" style="width:'+imuploadobj.attr('width')+'px;text-align: center;">'+ thisspan +'</span><ul class="hoverbox" flag="true" ><li class="hoverboxLiDownload"><span class="plotting">></span>下载</li><li class="hoverboxLipreview0"><span class="plotting">&gt;</span>预览</li><li class="hoverboxLidelete"><span class="plotting">></span>删除</li></ul></div>';
                        imuploadobj.before(listStr);
                    }
                    $('.imgupload').css('display','inline')
                    $('.imgupload').parent('p').removeAttr("style")
                });
            }
        });
    },
    FileUpload:function(){
        var that = this;

        var flowId = workForm.option.flowRun.flowId;   //获取flowId
        var dataId = ""
        var iconImgType = {
            txt : '/img/icon_file.png',
            jpg : '/img/icon_image.png',
            png : '/img/icon_image.png',
            pdf :  '/img/icon_pdf.png',
            ppt : '/img/icon_ppt.png',
            pptx :  '/img/icon_ppt.png',
            doc : '/img/icon_word.png',
            docx : '/img/icon_word.png',
            xls :  '/img/icon_excel.png',
            xlsx :  '/img/icon_excel.png'
        };
        var uploadformObj1 = '<form id="fileupload" target="uploadiframe" action="/upload?module=workflow" method="post"><input type="file" multiple="multiple" name="file" id="fileuploadinput" class="w-icon5" style="display:none;"></form>';
        $('body').append(uploadformObj1);
        var fileuploadobj = {};

        //附件上传选择从本机上传还是从文件柜上传-------开始
        that.option.eleObject.on("mouseenter mouseleave",'.fileupload',function(event){ // 鼠标移入移出上传附件的方法 显示两个菜单
            var that = this;
            if(event.type == "mouseenter"){
                //菜单所在的容器
                var str = '<div id="selectBox" class="selectBox" flag="true" style="cursor: pointer;display: none;position: absolute;z-index:1001;background-color: #ffffff;border: 1px solid #ccc;border: 1px solid rgba(0,0,0,0.2);border-right-width: 2px;border-bottom-width: 2px;-webkit-border-radius: 6px;-moz-border-radius: 6px;border-radius: 6px;-webkit-box-shadow: 0 5px 10px rgba(0,0,0,0.2);-moz-box-shadow: 0 5px 10px rgba(0,0,0,0.2);box-shadow: 0 5px 10px rgba(0,0,0,0.2);-webkit-background-clip: padding-box;-moz-background-clip: padding;background-clip: padding-box;overflow: hidden;"><span style="display: block;width: 100%;height: 30px;line-height: 30px;padding:0 5px;text-align: left;font-size: 16px;color:#333333" class="sptxt" id="selfCom"   href="javascript:;">从本机上传</span><span style="display: block;width: 100%;height: 30px;line-height: 30px;padding:0 5px;text-align: left;font-size: 16px;color:#333333" class="sptxt" id="fileCom"  >从文件柜上传</span></div>'
                $(that).after(str);
                if ($(that).next('#selectBox').attr('flag') == 'true') {
                    var posit = $(that).position();
                    var h = document.body.clientHeight;
                    $(that).next("#selectBox").css({
                        top: function (index, value) {
                            return (posit.top+50) + "px";
                        },
                        left: function (index, value) {
                            return (posit.left)+"px";
                        }
                    }).show();
                }
            } else if(event.type == "mouseleave"){
                var timer = null;
                timer = setTimeout(function () {
                    if ($(that).next('#selectBox').attr('flag') == 'true'){
                        $(that).next("#selectBox").hide();
                        $(that).next("#selectBox").remove();
                    }else{

                    }
                }, 300)

            }
        })
        // 鼠标移入移出添加的菜单容器上的方法
        that.option.eleObject.on("mouseenter mouseleave",'#selectBox',function(event){
            var that = this;
            if(event.type == "mouseenter"){
                $(that).attr('flag','false');
            } else if(event.type == "mouseleave"){
                $(that).hide();
                $(that).remove();
            }
        })
        // 鼠标移入移出菜单上选中行字体颜色改变方法
        that.option.eleObject.on("mouseenter mouseleave",'#selectBox span',function(event){
            var that = this;
            if(event.type == "mouseenter"){
                $(that).css({"background-color":"#0081c2"});
                $(that).css({"color":"#fff"});
            }else if(event.type == "mouseleave"){
                $(that).css({"background-color":"#fff"})
                $(that).css({"color":"#333333"});
            }
        });
        //从本机上传的点击方法
        that.option.eleObject.on('click','#selfCom',function(){
            dataId = $(this).parent("#selectBox").prev()[0].id;
            var that = $(this).parent("#selectBox").prev();
            var fileSize = that.attr('filesize')
            if(fileSize != undefined){
                $('#fileuploadinput').attr('fileSize',fileSize)
            }
            if(fileSize == ''){
                $('#fileuploadinput').removeAttr('fileSize')
            }
            if(that.attr('disabled') != 'disabled'){
                fileuploadobj = that;
                $('#fileuploadinput').click();
            }else if ($.getQueryString("opflag") == '0' && !$('#foot_rig').is(':hidden') && that.attr('noMainSignerFileYn') == '1') {
                fileuploadobj = that;
                $('#fileuploadinput').click();
            }else{
                if(that.attr('atturl')){
                    window.location.href=".//download?"+that.attr('atturl');
                }
            }
        });
        //从文件柜上传的点击方法
        that.option.eleObject.on('click','#fileCom',function(){
            var that = $(this).parent("#selectBox").prev();
            file_id=that;
            model = 'workflow'
            $.popWindow("/common/selectNewFile?0");

        });
        //双击textarea弹出界面点击方法
        that.option.eleObject.on('dblclick','textarea',function(){
            if($(this).attr('disabled') != 'disabled'){
                val = $(this).val()
                var that = $(this)
                var id = $(this).attr("id");
                flowId = workForm.option.flowRun.flowId,
                    runId=workForm.option.flowRun.runId,
                    reset_id=id;
                $.popWindow("/flowRunPage/workformEcho");
            }
        });
        //双击input弹出界面点击方法
        that.option.eleObject.on('dblclick','input',function(){
            if($(this).attr('disabled') != 'disabled'){
                val = $(this).val()
                var that = $(this)
                var id = $(this).attr("id");
                flowId = workForm.option.flowRun.flowId,
                    runId=workForm.option.flowRun.runId,
                    reset_id=id;
                $.popWindow("/flowRunPage/workformEcho");
            }
        });

        //附件上传选择从本机上传还是从文件柜上传-------结束

        $('#fileuploadinput').on('change', function(){
            var thiss = $(this)
            var sizes = thiss.attr('filesize')
            if(sizes != undefined){
                if (this.files[0].size/ 1024 / 1024  > sizes) {
                    $.layerMsg({content: '附件大小超过允许上传的大小！！', icon: 0}, function () {

                    });
                    return;
                }
            }

            //预算
            if(workForm.option.tableName == 'budget' && dataId == 'DATA_231'){
                $("#fileupload").attr('action','/budgetUpload?module=workflow&flag=1')
            }else if(workForm.option.tableName == 'budget' && dataId == 'DATA_232'){
                $("#fileupload").attr('action','/budgetUpload?module=workflow&flag=2')
            }else{
                $("#fileupload").attr('action','/upload?module=workflow')
            }
            if($('#fileuploadinput').val() != ''){
                $("#fileupload").ajaxSubmit(function (res) {
                    res = JSON.parse(res);
                    // 上传附件，保存会出现两个
                    for(var i=0;i<res.obj.length;i++){
                        var attachName = res.obj[i].attachName;
                        var attachNameArrByc = attachName.split('.');
                        var attrnametype = attachNameArrByc[attachNameArrByc.length-1];
                        var thisspan = res.obj[i].attachName;
                        var fileuploadSRC = iconImgType[attrnametype]||"/img/icon_file.png";
                        attrnametype = attrnametype.toLowerCase();
                        var sys_userid = workForm.tool.MacrosData.data.sYS_USERID || workForm.tool.MacrosData.data.sys_USERID;
                        if(getFileIsOffice(attrnametype)){
                            var listStr = '<div class="imgfileBox" style="position:  relative;"><img atturl="'+res.obj[i].attUrl+'&userid='+ sys_userid +'" name="'+fileuploadobj.attr('name')+'" src="'+fileuploadSRC+'" style="cursor: pointer;margin: 0 5px;'+fileuploadobj.attr('style')+'"  id="'+fileuploadobj.attr('name')+'" align="absmiddle" style=""  class="fileupload_data"    width="'+fileuploadobj.attr('width')+'" height="'+fileuploadobj.attr('height')+'"/><span class="uploadImg" style="width:'+fileuploadobj.attr('width')+'px;text-align: center;">'+ thisspan +'</span><ul class="hoverbox" flag="true" ><li class="hoverboxLiDownload"><span class="plotting">></span>下载</li><li class="hoverboxLiPreview0"><span class="plotting">></span>预览</li><li class="hoverboxLiPreview"><span class="plotting">></span>查阅</li><li class="hoverboxLiEdit"><span class="plotting">&gt;</span>编辑</li><li class="hoverboxLidelete"><span class="plotting">></span>删除</li></ul></div>';
                        }else if( getFileIsPDForTXT(attrnametype) || getFileIsPic(attrnametype) ){
                            var listStr = '<div class="imgfileBox" style="position:  relative;"><img atturl="'+res.obj[i].attUrl+'&userid='+ sys_userid +'" name="'+fileuploadobj.attr('name')+'" src="'+fileuploadSRC+'" style="cursor: pointer;margin: 0 5px;'+fileuploadobj.attr('style')+'"  id="'+fileuploadobj.attr('name')+'" align="absmiddle" style=""  class="fileupload_data"    width="'+fileuploadobj.attr('width')+'" height="'+fileuploadobj.attr('height')+'"/><span class="uploadImg" style="width:'+fileuploadobj.attr('width')+'px;text-align: center;">'+ thisspan +'</span><ul class="hoverbox" flag="true" ><li class="hoverboxLiDownload"><span class="plotting">></span>下载</li><li class="hoverboxLiPreview0"><span class="plotting">></span>预览</li><li class="hoverboxLidelete"><span class="plotting">></span>删除</li></ul></div>';
                        }else{
                            var listStr = '<div class="imgfileBox" style="position:  relative;"><img atturl="'+res.obj[i].attUrl+'&userid='+ sys_userid +'" name="'+fileuploadobj.attr('name')+'" src="'+fileuploadSRC+'" style="cursor: pointer;margin: 0 5px;'+fileuploadobj.attr('style')+'"  id="'+fileuploadobj.attr('name')+'" align="absmiddle" style=""  class="fileupload_data"    width="'+fileuploadobj.attr('width')+'" height="'+fileuploadobj.attr('height')+'"/><span class="uploadImg" style="width:'+fileuploadobj.attr('width')+'px;text-align: center;">'+ thisspan +'</span><ul class="hoverbox" flag="true" ><li class="hoverboxLiDownload"><span class="plotting">></span>下载</li><li class="hoverboxLidelete"><span class="plotting">></span>删除</li></ul></div>';
                        }
                        fileuploadobj.before(listStr);
                    }
                    $('#fileuploadinput').val('');
                });
            }
        });
        that.option.eleObject.on('click','.fileupload_data',function(){
            if(location.href.indexOf('workformPreView?') > -1&&$(this).parents('.imgfileBox').find('.hoverboxLiDownload').attr('style') != 'display: none;'){
                if($(this).attr('atturl')){
                    var str = $(this).attr('atturl');
                    var strs = str.split('&ATTACHMENT_NAME=')[0];
                    var name = str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[0];
                    var attName = encodeURI(name).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                    var atturl =strs+"&ATTACHMENT_NAME="+attName+"&FILESIZE="+str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[1];
                    location.href ='/download?'+encodeURI(atturl);
                }
            }
        });
        that.option.eleObject.on('click','.uploadImg',function(){
            if(location.href.indexOf('workformPreView?') > -1&&$(this).parents('.imgfileBox').length > 0&&$(this).parents('.imgfileBox').find('.hoverboxLiDownload').attr('style') != 'display: none;'){
                if($(this).parents('.imgfileBox').find('.fileupload_data').attr('atturl')){
                    var str =  $(this).parents('.imgfileBox').find('.fileupload_data').attr('atturl');
                    var strs = str.split('&ATTACHMENT_NAME=')[0];
                    var name = str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[0];
                    var attName = encodeURI(name).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                    var atturl =strs+"&ATTACHMENT_NAME="+attName+"&FILESIZE="+str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[1];
                    //window.open('/download?'+encodeURI(atturl));
                    location.href = '/download?'+encodeURI(atturl);
                }
            }
        });
        that.option.eleObject.on("mouseenter mouseleave",'.imgfileBox',function(event){
            var that = this;
            if(location.href.indexOf('workform?') > -1||location.href.indexOf('workformPreView?') > -1||location.href.indexOf('workformedit?') > -1){
                if(event.type == "mouseenter"){
                    if ($(that).find('.hoverbox').attr('flag') == 'true') {
                        $(that).on('mousemove', function (e) {
                            if ($(e.target).hasClass('uploadImg') || $(e.target).hasClass('fileupload_data') || $(e.target).hasClass('imgupload_data')) {
                                var offset = $(that).offset();
                                var pageX = e.pageX;
                                var pageY = e.pageY;
                                $(that).find('.hoverbox').css({
                                    top: function (index, value) {
                                        return pageY - offset.top - 1;
                                    },
                                    left: function (index, value) {
                                        return pageX - offset.left - 1;
                                    }
                                }).show();
                            }
                        })
                    }
                }else if(event.type == "mouseleave"){
                    $(that).off('mousemove');
                    $(that).find('.hoverbox').hide().css({top: 0, left: 0});
                }
            }
        })
        that.option.eleObject.on('click','.hoverboxLiDownload',function(event){
            // 阻止事件冒泡
            if (event.stopPropagation) {
                event.stopPropagation()
            } else if (window.event) {
                window.event.cancelBubble = true
            }
            if(location.href.indexOf('workform?') > -1||location.href.indexOf('workformPreView?') > -1||location.href.indexOf('workformedit?') > -1){
                if($(this).parents('.imgfileBox').find('img').hasClass('imgupload_data')){
                    var str = $(this).parents('.imgfileBox').find('img').attr('src').split('/xs?')[1];
                    //window.open("/download?"+str)
                    location.href="/download?"+str
                }else{
                    var str = $(this).parents('.imgfileBox').find('img').attr('atturl');
                    var strs = str.split('&ATTACHMENT_NAME=')[0];
                    var name = str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[0];
                    var attName = encodeURI(name).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                    var atturl =strs+"&ATTACHMENT_NAME="+attName+"&FILESIZE="+str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[1];

                    if(workForm.option.tableName == 'budget' && dataId == 'DATA_231'){
                        location.href="/budgetDownload?"+encodeURI(atturl);
                    }else if(workForm.option.tableName == 'budget' && dataId == 'DATA_232'){
                        location.href="/budgetDownload?"+encodeURI(atturl);
                    }else{
                        location.href="/download?"+encodeURI(atturl);
                    }
                }

            }
        });
        that.option.eleObject.on('click','.hoverboxLiPreview',function(event){
            // 阻止事件冒泡
            if (event.stopPropagation) {
                event.stopPropagation()
            } else if (window.event) {
                window.event.cancelBubble = true
            }
            if(location.href.indexOf('workform?') > -1||location.href.indexOf('workformPreView?') > -1||location.href.indexOf('workformedit?') > -1){
                if($(this).parents('.imgfileBox').find('img').hasClass('imgupload_data')){
                    var str = $(this).parents('.imgfileBox').find('img').attr('src').split('/xs?')[1];
                }else{
                    var str = $(this).parents('.imgfileBox').find('img').attr('atturl');
                }
                var name = str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[0];
                var attachName = name;
                var fileExtension=attachName.substring(attachName.lastIndexOf(".")+1,attachName.length);//截取附件文件后缀
                pdurl(fileExtension,str);
            }
        });
        that.option.eleObject.on('click','.hoverboxLiPreview0',function(event){
            // 阻止事件冒泡
            if (event.stopPropagation) {
                event.stopPropagation()
            } else if (window.event) {
                window.event.cancelBubble = true
            }
            if(location.href.indexOf('workform?') > -1||location.href.indexOf('workformPreView?') > -1||location.href.indexOf('workformedit?') > -1){
                if($(this).parents('.imgfileBox').find('img').hasClass('imgupload_data')){
                    var str = $(this).parents('.imgfileBox').find('img').attr('src').split('/xs?')[1];
                }else{
                    var str = $(this).parents('.imgfileBox').find('img').attr('atturl');
                }
                var name = str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[0];
                var attachName = name;
                var fileExtension= attachName.substring( attachName.lastIndexOf(".") + 1, attachName.length ).toLowerCase();//截取附件文件后缀
                if(getFileIsPic(fileExtension)){
                    // 处理图片上传控件增加预览点击后的情况
                    $.popWindow("/xs?"+str,PreviewPage,'0','0','1200px','600px');
                }else{
                    preview($(this).parents('.imgfileBox').find('img'), 1);
                }

            }
        });
        that.option.eleObject.on('click', '.imgfileBox', function(event){
            // 阻止事件冒泡
            if (event.stopPropagation) {
                event.stopPropagation()
            } else if (window.event) {
                window.event.cancelBubble = true
            }
            var flag = $(this).find('.hoverbox').attr('flag')
            var block = $(this).find('.hoverboxLiPreview').css('display')
            var isImageUpload = $(this).siblings('.imgupload').length > 0
            if(location.href.indexOf('workformPreView?') > -1||location.href.indexOf('workformedit?') > -1){
                isImageUpload = 1;
            }
            if (isImageUpload && flag && block != 'none') {
                if(location.href.indexOf('workform?') > -1||location.href.indexOf('workformPreView?') > -1||location.href.indexOf('workformedit?') > -1){
                    if($(this).find('img').hasClass('imgupload_data')){
                        var str = $(this).find('img').attr('src').split('/xs?')[1];
                    }else{
                        var str = $(this).find('img').attr('atturl');
                    }
                    var name = str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[0];
                    var attachName = name;
                    var fileExtension=attachName.substring(attachName.lastIndexOf(".")+1,attachName.length);//截取附件文件后缀
                    pdurl(fileExtension,str);
                }
            }
        });
        that.option.eleObject.on('click','.hoverboxLiEdit',function(event){
            // 阻止事件冒泡
            if (event.stopPropagation) {
                event.stopPropagation()
            } else if (window.event) {
                window.event.cancelBubble = true
            }
            if(location.href.indexOf('workform?') > -1||location.href.indexOf('workformPreView?') > -1||location.href.indexOf('workformedit?') > -1){
                var str = $(this).parents('.imgfileBox').find('img').attr('atturl');
                var name = str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[0];
                var attachName = name;
                var fileExtension=attachName.substring(attachName.lastIndexOf(".")+1,attachName.length);//截取附件文件后缀
                var attachmentUrl = str.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME=";
                var url = "/common/webOffice?documentEditPriv=1&ntType=1&emailList=1&print=1&fomat="+ fileExtension +"&"+attachmentUrl;
                $.ajax({
                    url:'/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
                    type:'post',
                    datatype:'json',
                    async:false,
                    success: function (res) {
                        if(res.flag){
                            if(res.object[0].paraValue == 0){
                                //默认加载NTKO插件 进行跳转
                                url = "/common/ntko?documentEditPriv=1&ntType=1&emailList=1&print=1&fomat="+ fileExtension +"&"+attachmentUrl;
                            }else if(res.object[0].paraValue == 2){
                                url = "/wps/info?"+ attachmentUrl +"&permission=write";
                            }else if(res.object[0].paraValue == 3){
                                url = "/common/onlyoffice?"+ attachmentUrl +"&edit=true";
                            }
                        }

                    }
                });
                $.popWindow(url,'<fmt:message code="main.th.PreviewPage" />','0','0','1200px','600px');

            }
        });
        that.option.eleObject.on('click','.hoverboxLidelete',function(event){
            // 阻止事件冒泡
            if (event.stopPropagation) {
                event.stopPropagation()
            } else if (window.event) {
                window.event.cancelBubble = true
            }
            if(location.href.indexOf('workform?') > -1||location.href.indexOf('workformPreView?') > -1||location.href.indexOf('workformedit?') > -1){
                if($(this).parents('.imgfileBox').find('img').hasClass('imgupload_data')){
                    var str = $(this).parents('.imgfileBox').find('img').attr('src').split('/xs?')[1];

                    if(workForm.option.tableName == 'budget' && dataId == 'DATA_231'){
                        var url = "/budgetDelete?"+decodeURI(str);
                    }else if(workForm.option.tableName == 'budget' && dataId == 'DATA_232'){
                        var url = "/budgetDelete?"+decodeURI(str);
                    }else{
                        var url = "/delete?"+decodeURI(str);
                    }
                }else{
                    var str = $(this).parents('.imgfileBox').find('img').attr('atturl');
                    var strs = str.split('&ATTACHMENT_NAME=')[0];
                    var name = str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[0];
                    var attName = encodeURI(name).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                    var atturl =strs+"&ATTACHMENT_NAME="+attName;

                    if(workForm.option.tableName == 'budget' && dataId == 'DATA_231'){
                        var url = "/budgetDelete?"+atturl;
                    }else if(workForm.option.tableName == 'budget' && dataId == 'DATA_232'){
                        var url = "/budgetDelete?"+atturl;
                    }else{
                        var url = "/workflow/work/deletework?runId="+ runId +"&"+encodeURI(atturl);
                    }
                }

                var that = $(this);
                layer.confirm('确定删除吗？', {
                    btn: ['确定','取消'], //按钮
                    title:"删除附件"
                }, function(){
                    //确定删除，调接口
                    $.ajax({
                        type:'get',
                        url:url,
                        dataType:'json',
                        data:{},
                        beforeSend : function(request) {
                            if(beforeToken != ''){
                                request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
                            }
                        },
                        success:function(res){

                            layer.msg('删除成功！', { icon:6});
                            if(that.parents('div').next().attr('width')!=50){
                                if(that.parents('div').next().parent().is('p')){
                                    that.parents('p').css({
                                        'border':'2px dotted #5fa5e7',
                                        'margin':'0 auto',
                                        'height':that.parents('div').next().attr('height'),
                                        'width': that.parents('td').width()-3,
                                        'vertical-align': 'middle',
                                        'display': 'table-cell'
                                    })
                                }else{
                                    that.parents('td').css({
                                        'height':that.parents('div').next().attr('height'),
                                    })
                                }
                                that.parents('.imgfileBox').next().css('display','inherit');
                            }
                            that.parents('.imgfileBox').remove();
                            deleteITEMcountersignature_item = true;
                            $('#saveform').click();

                        }
                    });

                }, function(){
                    layer.closeAll();
                });


            }
        });
    },
    deptSelectRender:function () {
        var that = this;

        // 移动端不进行操作
        var isMobile = (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )||/(Android)/i.test(navigator.userAgent));
        if (!isMobile && location.href.indexOf('/workform?') > -1) {
            that.option.eleObject.find(".deptselect").each(function (index,ele) {
                if (that.option.prcsItem && that.option.prcsItem.indexOf($(ele).attr('title')) > -1) {
                    var isEditDept = $(ele).attr('iseditdept') || '0';
                    // 判断是否开启手动录入外部单位
                    if (isEditDept == '1') {
                        $(ele).after('<a class="edit_outer_dept" href="javascript:;" style="color: #2567d6;text-decoration: none;font-size: 14px;">添加</a>')
                    }
                }
            })
        }

        this.option.eleObject.find('.deptselect').on('click',function () {
            var __this = $(this);
            dept_id = __this.attr('id');
            if(__this.attr('deptselecttype') == 1){
                $.popWindow("/common/selectDept?0");
            }else{
                $.popWindow("/common/selectDept");
            }
        });

        $(document).on('click', '.edit_outer_dept', function(event){
            if (event.stopPropagation) {
                event.stopPropagation();
            } else if (window.event) {
                window.event.cancelBubble = true;
            }

            var $textarea = $(this).prev();
            var deptId = $textarea.attr('deptid') || '';
            var deptName = $textarea.attr('deptname') || '';
            var deptIdArr = deptId.split(',');
            var deptNameArr = deptName.split(',');
            var deptObj = {};
            var length = 0;
            if (deptIdArr.length > 0) {
                deptIdArr.forEach(function(deptId, index){
                    if (deptId != '') {
                        var obj = {deptId: deptId, deptName: deptNameArr[index]}
                        deptObj[index] = obj
                        length++
                    }
                });
            }

            var layerId = layer.open({
                title: '单位-部门录入',
                type: 1,
                area: ['500px', '400px'],
                btn: ['保存', '取消'],
                content: '<div length="'+length+'" class="outer_dept_box">' +
                    '<div style="height: 265px; overflow: hidden"><div style="height: 265px; overflow: auto;"><ul class="outer_dept_list"></ul></div></div>' +
                    '<div style="text-align: center;"><button id="addOuterDept" style="border: none;padding: 5px 15px;background: #2183d0;outline: none;border-radius: 5px;color: #fff;">添加</button></div>' +
                    '</div>',
                success: function(){
                    var str = '';
                    deptIdArr.forEach(function(id, index){
                        if (id == '0') {
                            str += '<li dindex="'+index+'" style="text-align: center;padding: 2px;">部门名：<input class="outer_dept_name" style="width: 230px" type="text" value="'+deptNameArr[index]+'"><a class="del_outer_dept" style="color: red;margin-left: 5px;padding: 5px;cursor: pointer;text-decoration: none;">x</a></li>'
                        }
                    });
                    $('.outer_dept_list').html(str)
                },
                yes: function(){
                    var $li = $('.outer_dept_list').find('li');
                    var deptId = '';
                    var deptName = '';
                    $li.each(function(){
                        var key = $(this).attr('dindex');
                        var value = $(this).find('.outer_dept_name').val().trim()
                        deptObj[key] = {deptId: '0', deptName: value}
                    });

                    for (var key in deptObj) {
                        if (deptObj[key] && deptObj[key]['deptName'] != '') {
                            deptId += deptObj[key]['deptId'] + ',';
                            deptName += deptObj[key]['deptName'] + ',';
                        }
                    }

                    $textarea.attr('deptid', deptId);
                    $textarea.attr('deptname', deptName);
                    $textarea.val(deptName);
                    layer.close(layerId);
                }
            })
        });

        $(document).on('click', '#addOuterDept', function(){
            var index = parseInt($('.outer_dept_box').attr('length') || 0);
            index += 1
            var $li = $('<li dindex="'+index+'" style="text-align: center;padding: 2px;">部门名：<input class="outer_dept_name" type="text" style="width: 230px" value=""><a class="del_outer_dept" style="color: red;margin-left: 5px;padding: 5px;cursor: pointer;text-decoration: none;">x</a></li>');
            $('.outer_dept_list').append($li);
            $li.find('input').focus();
            $('.outer_dept_box').attr('length', index);
        });

        $(document).on('click', '.del_outer_dept', function(){
            $(this).parents('li').find('.outer_dept_name').val('');
            $(this).parents('li').hide();
        });

    },
    userSelectRender:function () {
        var that = this;
        this.option.eleObject.find('.userselect').on('click',function () {
            var __this = $(this);
            user_id = __this.attr('id');
            if(__this.attr('userselecttype') == 1){
                $.popWindow("/common/selectUser?0");
            }else{
                $.popWindow("/common/selectUser");
            }
        });
    },
    MacrosSignRender:function (stepType, stepValue) {
        var that = this
        var type = '';
        var val=""
        if(stepValue==undefined&&stepValue==null){ //如果stepvalue为空的话，就选择默认循环 获取会签意见，如果不为空，就为右侧会签提交刷新
            val = that.option.stepValue
        }else{
            val = stepValue
        }

        if(!that.option.preView ||  that.option.resdata.preView == 1){
            that.option.eleObject.find('.macrossign').each(function () {
                var _this = $(this);

                if(!_this.is("input")){
                    return;
                }
                //判断是否展示会签时间和名字----------开始
                var value;
                if($(this).attr('selectinp')=='1' || !$(this).attr('selectinp')){
                    value = that.tool.getMacrosData($(this).attr("datafld"))() ||'';
                }else{
                    var signtext =  workForm.tool.MacrosData.data.signText || [];
                    var str = '';
                    signtext.forEach(function(v,i){
                        str += (v.content + '</br>');
                    });
                    value = str||'';
                }
                //判断是否展示会签时间和名字开---------结束
                // var value =that.tool.getMacrosData($(this).attr("datafld"))() ||'';
                var divObj = '<span id="'+$(this).attr('name')+'" name="'+$(this).attr('name')+'" title="'+$(this).attr('title')+'" data-type="'+$(this).attr('data-type')+'" style="'+$(this).attr('style')+'overflow: hidden;text-align:left;vertical-align:middle;" datafld="'+$(this).attr('datafld')+'" class="form_item macrossign" stepType = "'+$(this).attr('stepType')+'" stepValue = "'+$(this).attr('stepValue')+'">'+value+'</span>';
                if($(this).attr("datafld") == 'SYS_FLOW_SIGNTEXT'){
                    if($(this).attr('stepType')!=""&&$(this).attr('stepType')!=undefined){
                        if($(this).attr('stepType') == 'PRCS_ID'&&val == $(this).attr('stepValue')){
                            _this.before('<span style="display: inline-block;">'+divObj+'</span>');
                            _this.remove();
                        }else if($(this).attr('stepType') == 'FLOW_PRCS'&&val == $(this).attr('stepValue')){
                            _this.before('<span style="display: inline-block;">'+divObj+'</span>');
                            _this.remove();
                        }else{
                            divObj = ''
                        }
                    }
                } else if ($(this).attr("datafld") == 'SYS_FLOW_CHILDFLOW') {// 子流程宏标记替换
                    var childFlow = '<span id="'+$(this).attr('name')+'" name="'+$(this).attr('name')+'" title="'+$(this).attr('title')+'" data-type="'+$(this).attr('data-type')+'" style="'+$(this).attr('style')+'overflow: hidden;text-align:left;vertical-align:middle;display: inline-block;" datafld="'+$(this).attr('datafld')+'" class="form_item macrossign">'+value+'</span>';
                    _this.replaceWith('<span style="display: inline-block;">'+childFlow+'</span>');
                } else if ($(this).attr("datafld") == 'SYS_FLOW_EXPLAINFILE') {
                    var explainFile = $(this).attr('explainFile');
                    var replaceStr = '';
                    if (explainFile != undefined && explainFile != '' && value.length > 0) {
                        explainFile = parseInt(explainFile);
                        if (!isNaN(explainFile)) {
                            explainFile-=1;
                            if (explainFile>=0 && explainFile<value.length)
                                replaceStr = value[explainFile];
                        }
                    }
                    var explainFile = '<span id="'+$(this).attr('name')+'" name="'+$(this).attr('name')+'" title="'+$(this).attr('title')+'" data-type="'+$(this).attr('data-type')+'" style="'+$(this).attr('style')+'overflow: hidden;text-align:left;vertical-align:middle;display: inline-block;" datafld="'+$(this).attr('datafld')+'" class="form_item macrossign" explainFile="'+explainFile+'">'+replaceStr+'</span>';
                    _this.replaceWith('<span style="display: inline-block;">'+explainFile+'</span>');
                } else if ($(this).attr("datafld") == 'SYS_FLOW_CONNECTFLOW') {
                    var replaceStr = '';
                    if (value.type == 1) {
                        if (location.href.indexOf('/workflow/work/workformPreView?') > -1) {
                            replaceStr = '<span id="' + _this.attr('name') + '" flowtype="1" ispreview="1" name="' + _this.attr('name') + '" title="' + _this.attr('title') + '" data-type="' + _this.attr('data-type') + '" style="' + _this.attr('style') + 'overflow: hidden;text-align:left;vertical-align:middle;" class="form_item macrossign" datafld="' + _this.attr('datafld') + '" stepType = "' + _this.attr('stepType') + '"></span>';
                        } else {
                            replaceStr = '<input type="text" id="' + _this.attr('name') + '" flowtype="1" name="' + _this.attr('name') + '" title="' + _this.attr('title') + '" data-type="' + _this.attr('data-type') + '" style="' + _this.attr('style') + 'overflow: hidden;text-align:left;vertical-align:middle;" class="form_item macrossign" datafld="' + _this.attr('datafld') + '" stepType = "' + _this.attr('stepType') + '" placeholder="请输入未关联流程原因">';
                        }
                    } else {
                        if (location.href.indexOf('/workflow/work/workformPreView?') > -1) {
                            replaceStr = '<span id="' + _this.attr('name') + '" flowtype="2" ispreview="1" name="' + _this.attr('name') + '" title="' + _this.attr('title') + '" data-type="' + _this.attr('data-type') + '" style="' + _this.attr('style') + 'overflow: hidden;text-align:left;vertical-align:middle;" class="form_item macrossign" datafld="' + _this.attr('datafld') + '" stepType = "' + _this.attr('stepType') + '"></span>';
                        } else {
                            replaceStr = '<span id="' + _this.attr('name') + '" flowtype="2" name="' + _this.attr('name') + '" title="' + _this.attr('title') + '" data-type="' + _this.attr('data-type') + '" style="' + _this.attr('style') + 'overflow: hidden;text-align:left;vertical-align:middle;" class="form_item macrossign" datafld="' + _this.attr('datafld') + '" stepType = "' + _this.attr('stepType') + '">'+value.str+'</span>';
                        }
                    }
                    _this.before('<span style="display: inline-block;">' + replaceStr + '</span>');
                    _this.remove();
                } else if ($(this).attr("datafld") == 'SYS_MODULE_PAGE') {
                    var disabled = '1';
                    if (workForm.option.prcsItem) {
                        var prcsArr = workForm.option.prcsItem.split(',')
                        if (prcsArr.indexOf($(this).attr('title')) > -1) {
                            disabled = '';
                        }
                    }
                    // 引入页面
                    var replaceStr = '';
                    if (value) {
                        var iframEle = '<div><iframe src="' + (value + '&disabled=' + disabled) + '" style="width: 100%; height: 800px;"></iframe></div>';
                        replaceStr = '<span id="' + $(this).attr('name') + '" name="' + $(this).attr('name') + '" title="' + $(this).attr('title') + '" data-type="' + $(this).attr('data-type') + '" style="' + $(this).attr('style') + 'overflow: hidden;text-align:left;vertical-align:middle;" datafld="' + _this.attr('datafld') + '" pageUrl="' + value + '" class="form_item macrossign">' + iframEle + '</span>';
                    } else {
                        replaceStr = '<span id="' + $(this).attr('name') + '" name="' + $(this).attr('name') + '" title="' + $(this).attr('title') + '" data-type="' + $(this).attr('data-type') + '" style="' + $(this).attr('style') + 'overflow: hidden;text-align:left;vertical-align:middle;" datafld="' + _this.attr('datafld') + '" pageUrl="" class="form_item macrossign"></span>';
                    }
                    _this.replaceWith(replaceStr);
                }else if($(this).attr("datafld") == 'SYS_FLOW_PUBLICFILE'){
                    var divObj = '<span id="'+$(this).attr('name')+'" name="'+$(this).attr('name')+'" title="'+$(this).attr('title')+'" data-type="'+$(this).attr('data-type')+'" style="'+$(this).attr('style')+'overflow: hidden;text-align:left;vertical-align:middle;" datafld="'+$(this).attr('datafld')+'" class="form_item macrossign" stepType = "'+$(this).attr('stepType')+'" stepValue = "'+$(this).attr('stepValue')+'">#[MACRO_ATTACH]</span>';
                    _this.before('<span style="display: inline-block;">'+divObj+'</span>');
                    _this.remove();
                }else {
                    _this.before('<span style="display: inline-block;">'+divObj+'</span>');
                    _this.remove();
                }

                // if($(this).attr('stepType')!=""&&$(this).attr('stepType')!=undefined){
                //      that.option.stepType = $(this).attr('stepType')
                //  }
                //  if($(this).attr('stepValue') != "" && $(this).attr('stepValue')!=undefined){
                //      that.option.stepValue = $(this).attr('stepValue')
                //  }
                //  _this.before('<div style="display: inline-block;">'+divObj+'</div>');
                //  _this.remove();
            });
        }else{

            // that.option.eleObject.find('.macrossign').each(function () {
            //     var _this = $(this);
            //     var value =that.tool.getMacrosData($(this).attr("datafld"))() ||'';
            //     _this.val(value)
            // });
        }
    },
    //获取宏标记文号计数器保存数据
    saveDate:function(){
        var flowfun = workForm.option.flowRun;
        var fdata={
            flowId:flowfun.flowId,

            runId:flowfun.runId,
            runName:flowfun.runName,
            beginTime:flowfun.beginTime,

        };


        $.ajax({
            type: "post",
            url: "/workFlowCreater/saveFlowAutoNum",
            dataType: 'JSON',
            data: fdata,
            beforeSend : function(request) {
                if(beforeToken != ''){
                    request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
                }
            },
            success: function(res){
                if(res.obj!=undefined){
                    workForm.macrosSymbol(res.obj)
                }

            }
        });

    },
    MacrosSignRender2:function(type,val,target){
        //以下是通达会签意见宏标记兼容
        var that = this
        // var macrosSign = that.option.eleObject[0].innerHTML;
        var arrSign = workForm.option.signText;
        if(arrSign!=undefined&&arrSign.length>0){

            arrSign.forEach(function(v,i){
                var sign = v.match(/#\[MACRO_SIGN(\d*)(\*?)\]\[([\S\s]*?)\]/i);


                var stepType ="";
                var stepValue = ''
                if(sign[2]=='*'){
                    stepType = 'FLOW_PRCS';
                    stepValue = sign[1];
                }else{
                    stepType = 'PRCS_ID';
                    stepValue = sign[1];
                }
                var value = that.MacrosSignList;
                if(that.MacrosSignList != undefined){
                    value = value[stepValue];
                }else{
                    value = '';
                }
                if(val&&(stepValue == val||val.split(',').indexOf(stepValue) > -1)&&type == stepType){
                    var replaceSign = workForm.signCheck(sign[3],value)
                    if(target!=undefined){
                        var str = $(target).html()
                    }else{
                        var str = workForm.option.eleObject[0].innerHTML;
                    }

                    if(replaceSign!=undefined){
                        //兼容通达会签显示[]标签判断
                        if(replaceSign.indexOf('[')>=0||replaceSign.indexOf('[/')>=0){
                            replaceSign=replaceSign.replace(/\[.*?\]/g,'').replace(/\[\/.*?\]/g,'')
                        }
                        replaceSign = "<span  id='sign"+stepValue+"'>"+replaceSign+"</span>"
                    }else{
                        replaceSign = "<span  id='sign"+stepValue+"'></span>";
                    }

                    // console.log(replaceSign)
                    if(target!=undefined&&target!=null){

                        // console.log($(target).find('#sign'+stepValue).html())
                        $(target).find('#sign'+stepValue).html(replaceSign)
                    }else{
                        var signStr = str.replace(sign[0],replaceSign);
                        workForm.option.eleObject[0].innerHTML = signStr;
                    }

                }


            })
        }

        //    以下是除了会签意见的宏标记兼容
        //    流水号
        var flowNum = workForm.option.eleObject[0].innerHTML.match(/#\[MACRO_RUN_ID\]/g);
        if(flowNum != null && flowNum != undefined &&flowNum.length>0){
            if (that.option.runId!=undefined){
                var flowVaule = that.option.runId;
            } else{
                var flowVaule = "";
            }
            var flowStr = workForm.option.eleObject[0].innerHTML.replace(flowNum[0],flowVaule);
            workForm.option.eleObject[0].innerHTML = flowStr;

        }

        //    兼容表单名称
        var formName = workForm.option.eleObject[0].innerHTML.match(/#\[MACRO_FORM\]/g);
        if(formName != null && formName != undefined &&formName.length>0){
            if (that.option.formName!=undefined){
                var flowNameVaule = that.option.formName;
            } else{
                var flowNameVaule = "";
            }
            var flowNameStr = workForm.option.eleObject[0].innerHTML.replace(formName[0],flowNameVaule);
            workForm.option.eleObject[0].innerHTML = flowNameStr;

        }

        //    兼容表单文号
        var formRunName = workForm.option.eleObject[0].innerHTML.match(/#\[MACRO_RUN_NAME\]/g);
        if(formRunName != null && formRunName != undefined &&formRunName.length>0){
            var RunName = that.option.formName||''
            var timeName = that.tool.getMacrosData('SYS_DATE')()||''
            if (RunName!=""&&timeName!=""){
                var flowrunNameVaule = RunName+' '+timeName;
            } else{
                var flowrunNameVaule = "";
            }
            var flowRunNameStr = workForm.option.eleObject[0].innerHTML.replace(formRunName[0],flowrunNameVaule);
            workForm.option.eleObject[0].innerHTML = flowRunNameStr;

        }

        //    兼容表单文号计数器
        var formRunNum = workForm.option.eleObject[0].innerHTML.match(/#\[MACRO_COUNTER\]/g);
        if(formRunNum != null && formRunNum != undefined &&formRunNum.length>0){

            if(workForm.option.prcsId==1&&workForm.option.flowStep==1){
                that.saveDate();
            }

        }

        //    兼容表单日期
        var formtime = workForm.option.eleObject[0].innerHTML.match(/#\[MACRO_TIME\]/g);
        if(formtime != null && formtime != undefined &&formtime.length>0){
            var timeValue = that.tool.getMacrosData('SYS_DATE')()||''
            if (timeValue!=""){
                var flowTimeVaule = timeValue;
            } else{
                var flowTimeVaule = "";
            }
            var flowTimeStr = workForm.option.eleObject[0].innerHTML.replace(formtime[0],'日期:'+flowTimeVaule);
            workForm.option.eleObject[0].innerHTML = flowTimeStr;
        }

    },
    signCheck:function(signArr,value){
        var str = ""
        if(signArr!=""&&value.length>0){
            value.forEach(function(v,i){
                var signText = signArr;

                var date = v.editTime.split(' ')[0];
                var time = v.editTime.split(' ')[1];
                var year = date.split('-')[0];
                var month = date.split('-')[1];
                var day = date.split('-')[2];
                var hour = time.split(':')[0];
                var min = time.split(':')[1];
                var second = time.split(':')[2];

                if(signArr.indexOf('{C}')>=0){
                    signText = signText.replace(/\{C\}/g,v.content)
                }
                if(signArr.indexOf('{Y}')>=0){
                    signText = signText.replace(/\{Y\}/g,year)
                }
                if(signArr.indexOf('{M}')>=0){
                    signText = signText.replace(/\{M\}/g,month)
                }
                if(signArr.indexOf('{D}')>=0){
                    signText = signText.replace(/\{D\}/g,day)
                }
                if(signArr.indexOf('{H}')>=0){
                    signText = signText.replace(/\{H\}/g,hour)
                }
                if(signArr.indexOf('{I}')>=0){
                    signText = signText.replace(/\{I\}/g,min)
                }
                if(signArr.indexOf('{S}')>=0){
                    signText = signText.replace(/\{S\}/g,second)
                }
                if(signArr.indexOf('{U}')>=0){
                    signText = signText.replace(/\{U\}/g,v.userName)
                }
                if(signArr.indexOf('{R}')>=0){
                    signText= signText.replace(/\{R\}/g,v.userPrivName)
                }
                if(signArr.indexOf('{P}')>=0){
                    signText= signText.replace(/\{P\}/g,workForm.option.flowRunPrcs.flowProcess.prcsName)
                }
                if(signArr.indexOf('{SD}')>=0){
                    var deptName = v.deptName||'';
                    signText=signText.replace(/\{SD\}/g,deptName)
                }
                if(signArr.indexOf('{LD}')>=0){
                    var longDeptName = v.longDeptName||'';
                    signText=signText.replace(/\{LD\}/g,longDeptName)
                }
                str += signText +'<br/>'
            })
            return str;

        }
    },

    //兼容通达宏标记文号计数器
    macrosSymbol:function(val){
        var formRunNum = workForm.option.eleObject[0].innerHTML.match(/#\[MACRO_COUNTER\]/g);
        if(formRunNum != null && formRunNum != undefined &&formRunNum.length>0){

            var counter = val
            if (counter!=""){
                var flowrunNumVaule = counter;
            } else{
                var flowrunNumVaule = "";
            }
            var flowRunNumStr = workForm.option.eleObject[0].innerHTML.replace(formRunNum[0],flowrunNumVaule);
            workForm.option.eleObject[0].innerHTML = flowRunNumStr;
        }
    },
    ListRender:function () {
        var that = this;
        this.option.eleObject.find('.listing').each(function (element,index) {

            var _this = $(this);
            var dataId = _this[0].id //获取列表控件的id
            var flowId = workForm.option.flowRun.flowId;   //获取flowId
            workForm.option.attributesStr = dataId
            workForm.option.attributesTitle = _this.attr('lv_title')
            var lv_size = _this.attr('lv_size').split('`');
            var tableWidth = 90;
            var classStr = _this.attr("class");
            lv_size.forEach(function (v,i) {
                if(v){
                    // if(classStr.indexOf('LIST_VIEW') > -1){
                    //     tableWidth = tableWidth+ parseInt(v)*7.2;
                    // }else{
                    //     tableWidth = tableWidth+ parseInt(v);
                    //     tableWidth = tableWidth+ 14;
                    // }
                    tableWidth = tableWidth+ parseInt(v);
                    tableWidth = tableWidth+ 14;
                }
            })
            //预算
            if((workForm.option.tableName == 'budget' && dataId == 'DATA_225') || (workForm.option.tableName == 'budget' && dataId == 'DATA_227')){  //如果是支票
                tableWidth = tableWidth+150
            }
            var tableStr = '<table style="width:'+tableWidth+'px!important;" name="'+_this.attr('name')+'" title="'+_this.attr('title')+'" id="'+_this.attr('name')+'" lv_cal="'+_this.attr('lv_cal')+'" lv_coltype="'+_this.attr('lv_coltype')+'"  lv_sum="'+_this.attr('lv_sum')+'"   lv_colvalue="'+_this.attr('lv_colvalue')+'"  lv_size="'+_this.attr('lv_size')+'"  lv_title="'+_this.attr('lv_title')+'" lv_field="'+_this.attr('lv_field')+'" datafrom="'+_this.attr('datafrom')+'" data-type="listing" class="form_item list list_table table table-hover">';
            var lv_title = _this.attr('lv_title').split('`');
            var lv_field = _this.attr('lv_field').split('`');

            var lv_coltype = _this.attr('lv_coltype').split('`');
            var lv_sum = _this.attr('lv_sum').split('`');
            var lv_defaultVal= [];
            var lv_cal = _this.attr('lv_cal').split('`');
            var lv_colvalue = _this.attr('lv_colvalue').split('`');
            var default_cols = _this.attr('default_cols');
            //预算
            if((workForm.option.tableName == 'budget' && dataId == 'DATA_225') || (workForm.option.tableName == 'budget' && dataId == 'DATA_227')){
                var titleTd = '<th width="45" style="text-align: center">操作</th><th width="45" style="text-align: center">序号</th><th width="100" style="text-align: center">选择</th>'
                var tdSum = '<td class="sumtitle">合计</td><td class="sumtitle"></td><td class="sumtitle"></td>';
                var tdStr = '<td ><button class="add_btn">新增</button></td><td></td><td></td>';
            }else{
                var titleTd = '<th width="45" style="text-align: center">'+function(){
                    if(location.href.indexOf('/workflow/work/workformPreView?') == -1){
                        return '操作';
                    }else{
                        return '';
                    }
                }()+'</th><th width="45" style="text-align: center">序号</th>'
                var tdSum = '<td class="sumtitle">合计</td><td class="sumtitle"></td>';
                var tdStr = '<td ><button class="add_btn">新增</button></td><td></td>';
            }


            var addtr ='<td><a style="margin-left: 10px;" title=del class="delete_row" href="javascript:void(0)"><img src="/img/workflow/delete.png"></a></td>';
            for(var i=0;i<lv_title.length-1;i++){
                // if(classStr.indexOf('LIST_VIEW') > -1){
                //     titleTd+=('<th style="text-align: center" width="'+(parseInt(lv_size[i]*7.2))+'">'+lv_title[i] +'</th>');
                //
                // }else{
                //     titleTd+=('<th style="text-align: center" width="'+function(){
                //         if(lv_size[i]!=0){
                //             return (parseInt(lv_size[i])+14)
                //         }else{
                //             return '1';
                //         }
                //     }()+'">'+lv_title[i] +'</th>');
                //
                // }
                titleTd+=('<th style="text-align: center" width="'+function(){
                    if(lv_size[i]!=0){
                        return (parseInt(lv_size[i])+14)
                    }else{
                        return '1';
                    }
                }()+'">'+lv_title[i] +'</th>');
                tdStr+='<td></td>';
                if(lv_sum[i] == '1'){
                    tdSum+='<td class="total_'+(i+1)+'">0</td>';
                }else{
                    tdSum+='<td></td>';
                }
            }
            tableStr+=('<tr class="listhead">'+titleTd+'</tr>');//title
            //预算
            var default_colsStr = '';
            for(var k=0;k<default_cols;k++){
                var addtr2 = that.tool.renderListDeaultTd(k,lv_cal,lv_coltype,lv_colvalue,lv_size,lv_sum,lv_defaultVal);
                if((workForm.option.tableName == 'budget' && dataId == 'DATA_225') || (workForm.option.tableName == 'budget' && dataId == 'DATA_227')){
                    default_colsStr += ('<tr id="row_'+k+'" class="rows">'+addtr+'<td width="50">'+(k+1)+'</td><td width="100">' +
                        '<span onclick="xmkj($(this),1)" class="addItem" style="display:block;color:#4889f0;font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;cursor:pointer">&nbsp;添加项目 </span>'+
                        '<span onclick="xmxq($(this),1)" style="display:block;color:#4889f0;font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;cursor:pointer">&nbsp;项目详情 </span>'+
                        '</td>'+addtr2+'</tr>');
                }else{
                    default_colsStr += ('<tr id="row_'+k+'" class="rows">'+addtr+'<td width="50">'+(k+1)+'</td>'+addtr2+'</tr>');
                }

            }
            tableStr += default_colsStr;
            tableStr += ('<tr class="listsum">'+tdSum+'</tr>');
            tableStr += ('<tr class="listfoot">'+tdStr+'</tr>');
            tableStr += '</table>';
            _this.before(tableStr);
            _this.prev().on("click",'.delete_row',function () {
                var table = $(this).parents('table');
                if($(this).attr('disabled') != 'disabled'){
                    var $tbody = $(this).parent().parent().parent();
                    $(this).parent().parent().remove();
                    var $tr = $tbody.find('tr');
                    if ($tr.length > 3) {
                        for (var i = 1; i < $tr.length - 2; i++){
                            $($tr[i]).find('td').eq(1).text(i);
                        }
                    }
                    if(table.find('.formula').length != 0){
                        table.find('.formula').eq(0).trigger('propertychange')
                    }else if(table.find('.total').length != 0){
                        for(var i=0;i<table.find('.total').length;i++){
                            table.find('.total').eq(i).trigger('propertychange')
                        }
                    }else{
                        var tableTr = table.attr('lv_sum').split('`');
                        for(var i=0;i<tableTr.length;i++){
                            if(tableTr[i] == 1){
                                table.find('.listsum').find('td').eq(i+2).text('0');
                            }
                        }

                    }
                }
            });
            _this.prev().on("click",'.list_date',function () {
                var _this = $(this);
                var flag = true;
                if(_this.attr('date_format').indexOf(' ')>0){
                    flag = true;
                }else{
                    flag = false;
                }
                laydate({istime: true,format:_this.attr('date_format'),istime:flag});
            });
            _this.prev().on("input propertychange",'.total',function () {
                var sum = 0;
                var sid = $(this).attr('sid');
                var fix = 0;
                $(this).parent().parent().parent().find($('.sum_'+sid)).each(function(){
                    var __this = $(this);
                    var _v = __this.val();
                    if(_v && checkNumber(_v)){
                        if(_v.indexOf('.') > -1){
                            var fixItem = _v.substr(_v.indexOf('.')+1,_v.length).length;
                            if(fixItem > fix){
                                fix = fixItem;
                            }
                        }

                        sum += parseFloat(__this.val());
                    }
                });
                //console.log(fix);
                sum = sum.toFixed(fix);
                $(this).parent().parent().parent().find($('.total_'+sid)).html(sum);
                $('.amount').val(sum);
                //预算
                if($(this).parents('table').attr('name') == 'DATA_227' && workForm.option.tableName == 'budget' ){
                    $('#DATA_204').val(sum);
                    $('.calculation').trigger('propertychange')
                }
            });
            //计算
            function calculate(vv) {
                var _this = vv;
                var sum = 0;
                var sid =_this.attr('sid');

                var targetlvcalls = vv.parent().parent().find('.lv_cal');
                targetlvcalls.each(function(i,v){
                    var formula = $(v).attr('formula');
                    if(formula.indexOf('['+_this.attr('sid')+']') >-1){
                        var targetlvcall = $(v);
                        var lv_caldefaultsizeval = targetlvcall.attr('lv_caldefaultsizeval');
                        var lv_caldefaultsize = targetlvcall.attr('lv_caldefaultsize');
                        var formula = targetlvcall.attr('formula');
                        var fix = 0;
                        var fix_tr = 0;
                        $(this).parents('tr').find('.formula').each(function(){

                            var __this = $(this);
                            var _v = __this.val() || 0;
                            if( _v != 0 && _v.indexOf('%')>-1){
                                _v = toPoint(_v);
                            }
                            if(_v.toString().indexOf('.') > -1){
                                var __v = _v.toString();
                                var fixItem = __v.substr(__v.indexOf('.')+1,__v.length).length;
                                if(fixItem > fix){
                                    fix = fixItem;
                                }
                            }
                            var sid = __this.attr('sid');
                            var oldStr = '['+sid+']';
                            if(checkNumber(_v)){
                                while (formula.indexOf(oldStr) > -1){
                                    formula = formula.replace(oldStr,_v);
                                }
                            }else{
                                while (formula.indexOf(oldStr) > -1){
                                    formula = formula.replace(oldStr,0);
                                }
                            }

                        });
                        $(this).parents('tr').eq(0).find('.formula').each(function(){
                            var __this = $(this);
                            var _v = __this.val() || 0;
                            if( _v != 0 && _v.indexOf('%')>-1){
                                _v = toPoint(_v);
                            }
                            if(_v.toString().indexOf('.') > -1){
                                var __v = _v.toString();
                                var fixItem = __v.substr(__v.indexOf('.')+1,__v.length).length;
                                if(fixItem > fix_tr){
                                    fix_tr = fixItem;
                                }
                            }
                        });
                        try{
                            if(formula.indexOf('[') == -1 && formula.indexOf(']') == -1  ){
                                if(lv_caldefaultsize == 0){
                                    lv_caldefaultsize = fix;
                                }
                                var result =parseFloat(eval(formula)).toFixed(fix_tr);
                                if(isNaN(result) || result.toString() == 'Infinity' || result.toString() == '-Infinity' ){
                                    throw 'error';
                                }
                                targetlvcall.html(result);
                                var targetlvcallClassStr = targetlvcall.attr('class');
                                if(targetlvcallClassStr && targetlvcallClassStr.indexOf('sum') > -1){
                                    var sum = 0;
                                    var sid = targetlvcall.attr('sid');
                                    targetlvcall.parent().parent().find('.sum_'+sid).each(function(){
                                        var __this = $(this);
                                        var _v = __this.html();
                                        if(_v && checkNumber(_v)){
                                            sum += parseFloat(_v);
                                        }
                                    });
                                    sum = sum.toFixed(lv_caldefaultsize);
                                    targetlvcall.parent().parent().find('.total_'+sid).html(sum);
                                    $('.amount').val(sum);
                                    //预算
                                    if(workForm.option.tableName == 'budget'&&_this.parents('table').attr('name') == 'DATA_222'&&sum> parseFloat($('#DATA_246').val())){
                                        $.layerMsg({content:'支出明细不能大于支出金额',icon:6})
                                    }
                                }
                            }else{
                                targetlvcall.html(lv_caldefaultsizeval);
                            }
                        }catch (r){
                            targetlvcall.html(lv_caldefaultsizeval);
                        }
                    }
                });
            }
            _this.prev().on("change",'.formula',function () {
                calculate($(this))
            })
            _this.prev().on("input propertychange",'.formula',function () {
                calculate($(this))
            });
            _this.prev().find('.add_btn').on('click',function () {
                // var a=$('.rows').length;
                var v = $(this).parent().parent().parent().find('tr').length - 3;
//预算
                $(this).parent().parent().prev().before('<tr>'+addtr+'<td>'+(v+1)+'</td>'+function(){
                    if((workForm.option.tableName == 'budget' && dataId == 'DATA_225') || (workForm.option.tableName == 'budget' && dataId == 'DATA_227')){
                        return '<td>'+
                            '<span onclick="xmkj($(this),1)" class="addItem" style="display:block;color:#4889f0;font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;cursor:pointer">&nbsp;添加项目 </span>'+
                            '<span onclick="xmxq($(this),1)" style="display:block;color:#4889f0;font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;cursor:pointer">&nbsp;项目详情 </span>'+
                            '</td>'
                    }else{
                        return ''
                    }
                }()+that.tool.renderListDeaultTd(k,lv_cal,lv_coltype,lv_colvalue,lv_size,lv_sum,lv_defaultVal)+'</tr>');
                k+=1;
            });
            _this.remove();
        });
    },
    textareaRender:function(){
        var that = this;
        // console.log(111)
        this.option.eleObject.find('textarea').each(function (element,index) {
            var _this = $(this)
            var width = _this.attr('orgwidth');
            var height = _this.attr('orgheight');
            if(height == ''||height == 0){
                height = 100;
            }
            if(!that.option.ish5 && _this.attr('rich')!= undefined && _this.attr('rich')==1){ //判断多文本框是否为富文本

                // console.log($(this).prev().attr('id'))
                var container = _this.prev().attr('id')
                that.option.ue = UE.getEditor(container, {
                    toolleipi: true, //是否显示，设计器的 toolbars
                    textarea: 'design_content',
                    //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
                    toolbars: [
                        [
                            'fullscreen', 'source', '|', 'undo', 'redo', '|',
                            'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
                            'rowspacingtop', 'rowspacingbottom', 'lineheight', '|','justifyleft','justifycenter','justifyright','justifyjustify','|','indent','|',
                            'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|'

                        ]
                    ],
                    //focus时自动清空初始化时的内容
                    //autoClearinitialContent:true,
                    //关闭字数统计
                    wordCount: false,
                    enableAutoSave: true,
                    //关闭elementPath
                    elementPathEnabled: false,
                    initialFrameWidth:width,
                    //默认的编辑区域高度
                    initialFrameHeight: height,
                    //编辑器宽度
                    autoClearEmptyNode:true,
                    //                            initialFrameWidth: auto,

                    iframeCssUrl: "/css/ueditor/bootstrap.css" //引入自身 css使编辑器兼容你网站css
                    //更多其他参数，请参考ueditor.config.js中的配置项
                });
                // that.option.ue.addListener('blur',function(editor){
                //     // console.log(that.option.ue.getContent())
                //     var con=that.option.ue.getContent()
                //     _this.val(con)
                //     _this.attr('value',con)
                // });


            }
        })
    },
    filter:function() {
        var that = this;
        var indexsnum = 1;
        if(that.option.flowStep && that.option.flowStep  != -1 && that.option.prcsId){
            that.option.listFp.forEach(function (v,i) {
                //工作流查询 编辑功能 进入工作流编辑页面
                if(location.href.indexOf('/workflow/work/workformedit?') > -1){
                    if(i == that.option.listFp.length - 1){
                        var steptOpt = v;
                        that.tool.requiredItem = v.requiredItem;
                        // console.log(v.requiredItem)
                        that.tool.ajaxHtml('/workflow/work/selectFlowData',{flowId:that.option.flowRun.flowId,runId:that.option.flowRun.runId},function (res) {
                            /********工作流底部转交box*************/

                            /***************************************/
                            /********附件、会签box*************/
                            $('.fujian').siblings('li').hide().parent().css({'width':'68px'});
                            $('#hui').hide();
                            workForm.option.dataName = res.obj;

                            if(res.obj!=undefined){
                                if(res.obj.flow_auto_num!=undefined){
                                    that.macrosSymbol(res.obj.flow_auto_num)
                                }
                            }
                            /***************************************/
                            var dataName = upperJSONKey(res.obj)||'';
                            that.option['snum'] = res.softSerialNo;
                            that.option.eleObject.find('.form_item').each(function(i,v){
                                var _this = $(this);
                                var isHidden = _this.attr("orghidden");
                                if(1 == isHidden ){
                                    _this.hide();
                                }
                                //权限控制(修改为判断是否相同而不是包含 解决名称类似字段无法识别的问题)
                                var stringAuto = {};
                                if(steptOpt.prcsItemAuto!=""&&steptOpt.prcsItemAuto!=undefined){ //判断再不可写字段情况下允许赋值的宏控件
                                    var spAuto= steptOpt.prcsItemAuto.split(',')
                                    spAuto.forEach(function (v,i) {
                                        stringAuto[v] = i;
                                    })
                                }
                                if(_this.attr("data-type") == 'macros'){
                                    if(_this.is('input') && _this.attr('orghidden')!=1 ){
                                        if(_this.attr('datafld')=='SYS_USERNAME'&&_this.attr('orgsignImg')==1){
                                            if(_this.prev('span').find('img').length>0){
                                                _this.prev('span').remove()
                                            }

                                            if(workForm.tool.getMacrosData('SYS_SIGN_IMAGE')()!=''&&workForm.tool.getMacrosData('SYS_SIGN_IMAGE')()!=undefined){
                                                _this.before('<span>'+function(){
                                                    if(workForm.tool.getMacrosData('SYS_SIGN_IMAGE')()){

                                                        return '<img style="width:100px;" src="/xs?'+workForm.tool.getMacrosData('SYS_SIGN_IMAGE')()+'" alt="">'
                                                    }else{
                                                        return ''
                                                    }
                                                }()+'</span>');
                                                _this.attr('signSrc','/xs?'+workForm.tool.getMacrosData('SYS_SIGN_IMAGE')());
                                                _this.hide();
                                            }else{
                                                _this.after('<button class="refresh" type="button" data-type="macros" id="' + _this.attr("id") + '" datafld="' + _this.attr('datafld') + '" title="刷新"><img src="/img/workflow/work/refresh.png" alt="" style="vertical-align: middle;margin-top: -3px;margin-right: 2px;"></button>')
                                            }

                                        }else if(_this.attr('datafld')=='SYS_CODE'){

                                            _this.after('')
                                        }else {
                                            _this.after('<button class="refresh" type="button" data-type="macros" id="' + _this.attr("id") + '" datafld="' + _this.attr('datafld') + '" title="刷新"><img src="/img/workflow/work/refresh.png" alt="" style="vertical-align: middle;margin-top: -3px;margin-right: 2px;"></button>')
                                        }
                                    }
                                }

                                //表单填充数据
                                var dataNameVal = dataName[_this.attr('name')] ||'';
                                if(dataNameVal == ''){
                                    if(_this.attr('data-type') == "macros"){
                                        _this.attr('value',dataNameVal);
                                    }
                                    if (_this.attr('data-type') == 'djsign') {
                                        var id = _this.attr('name');
                                        var sign_check = ',';
                                        var sign_type1 = _this.attr('sign_type').split(',')[0];
                                        var sign_type2 = _this.attr('sign_type').split(',')[1];
                                        if (_this.attr('sign_check')) {
                                            var sign_check = _this.attr('sign_check') + ',';
                                        }
                                        var color = _this.attr('sign_color');

                                        if (id) {
                                            var str1 = '', str2 = '';
                                            if (_this.attr("disabled") == "disabled") {
                                                var str = 'display: none;';
                                            } else {
                                                var str = '';
                                                if (sign_type1 == '0') {
                                                    str1 = "display: none;";
                                                }
                                                if (sign_type2 == '0') {
                                                    str2 = "display: none;";
                                                }
                                            }
                                            if (_this.attr('isMust')) {
                                                var must = "isMust='true'";
                                            } else {
                                                var must = "";
                                            }
                                            if(_this.attr('window_size') != undefined){
                                                var window_size = _this.attr('window_size');
                                            }else{
                                                var window_size = "";
                                            }
                                            if(_this.attr('mobilewinwidth') != undefined&&_this.attr('mobilewinheight') != undefined){
                                                var mobilewinwidth = _this.attr('mobilewinwidth');
                                                var mobilewinheight = _this.attr('mobilewinheight');
                                            }else{
                                                var mobilewinwidth = 0;
                                                var mobilewinheight = 0;
                                            }
                                            _this.before('<div class="websign" mobilewinwidth="'+ mobilewinwidth +'" mobilewinheight="'+ mobilewinheight +'" id="SIGN_POS_' + id + '" sign_check="' + id + ':' + sign_check + '">&nbsp;<input type="button" value="盖章" name="WEBSIGN_' + id + '" class="SmallButtonA" onclick="addSeal($(this));" style="' + str + str1 + '">\
                                                        <input type="button" value="手写" name="WEBSIGN_' + id + '" class="SmallButtonA" window_size="'+ window_size +'" onclick="handWrite($(this));" color="' + color + '" style="' + str + str2 + '">\
                                                        <input type="hidden" name="' + id + '" value="" id="' + id + '" class="form_item" data-type="djsign" title="' + _this.attr('title') + '" ' + must + '>\
                                                        </div>');
                                            _this.remove();
                                        }
                                    }
                                    //移动端手写
                                    if (_this.attr('data-type') == 'writesign') {
                                        // console.log(44)
                                        var id = _this.attr('name');
                                        if (id) {
                                            var str1 = '', str2 = '';
                                            if (_this.attr("disabled") == "disabled") {
                                                var str = 'display: none;';
                                            }
                                            if (_this.attr('isMust')) {
                                                var must = "isMust='true'";
                                            } else {
                                                var must = "";
                                            }
                                            if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent)) {
                                                _this.before('<span class="mobileSign" id="WRITE_SIGN_' + id + '" ><input dataId="' + id + '"  class="signBtn SmallButtonA" onclick="writeSign($(this));" value="手写" type="button"  style="    width: 52px;\n' +
                                                    '    border: none;height: 21px;font-size: 12px;color: #333;' + str + '">\
                                                        <input type="hidden" name="' + id + '" value="" id="' + id + '" class="form_item" data-type="writeSign" title="' + _this.attr('title') + '" ' + must + '>\
                                                        </span>');
                                                _this.remove();
                                            } else {
                                                _this.before('<span class="mobileSign" id="WRITE_SIGN_' + id + '" >\
                                                        <input type="hidden" name="' + id + '" value="" id="' + id + '" class="form_item" data-type="writeSign" title="' + _this.attr('title') + '" ' + must + '>\
                                                        </span>');
                                                _this.remove();
                                            }

                                        }
                                    }

                                }else{
                                    switch (_this.attr('data-type')){
                                        case 'text':
                                            _this.attr('value',dataNameVal);
                                            break;
                                        case 'markformItem':
                                            _this.attr('value',dataNameVal);
                                            break;
                                        case 'textarea':
                                            _this.text(dataNameVal);
                                            // if(!that.option.ish5 && _this.attr('rich')!= undefined&&_this.attr('rich')==1){
                                            //     that.option.ue.ready(function(){
                                            //
                                            //         that.option.ue.setContent(dataNameVal)
                                            //     })
                                            // }
                                            break;
                                        case 'countersignature_item':
                                            countersignature_item = true;
                                            break;
                                        case 'select':
                                            _this.find("option[value='"+dataNameVal+"']").prop("selected","selected").attr("selected","selected").siblings().removeAttr("selected");
                                            break;
                                        case 'radio':
                                            that.option.eleObject.find(":radio[name='"+_this.attr('name')+"'][value='" + dataNameVal + "']").prop("checked", "checked");
                                            that.option.eleObject.find(":radio[name='"+_this.attr('name')+"'][value='" + dataNameVal + "']").attr("checked", "checked");
                                            that.option.eleObject.find(":radio[name='"+_this.attr('name')+"'][value='" + dataNameVal + "']").siblings(":radio[name='"+_this.attr('name')+"']").removeAttr('checked');
                                            break;
                                        case 'checkbox':
                                            if(dataNameVal == '1'||dataNameVal=='on'){
                                                _this.prop("checked",'checked');
                                            }else{
                                                _this.prop("checked",false);
                                            }
                                            break;
                                        case 'fileupload':
                                            if(dataNameVal && dataNameVal.indexOf('*')>-1){
                                                _this.show();
                                                // _this.prev('span').hide();
                                                var download = 'display: block;';
                                                var preview = 'display: block;';
                                                var edit = 'display: block;';
                                                var deletet = 'display: block;';
                                                var flag = true;
                                                dataNameVal.split('*').forEach(function (v,i) {
                                                    if(v&&v.indexOf('&ATTACHMENT_NAME=')>-1){
                                                        v = v.replace(/\%2c/g, ",");
                                                        var fileConfigArr = v.split('&');
                                                        // 增加集体处理附件上传控件已上传附件数据回显时候的url处理
                                                        var FileArr = getFileArrType(fileConfigArr).split('*');
                                                        var nameTitle = FileArr[0] + '.' + FileArr[1];
                                                        var FileArrType = FileArr[1];
                                                        var fileuploadSRC = that.tool.iconImgType[FileArrType]||"/img/icon_file.png";
                                                        var attrnametype = FileArrType;
                                                        attrnametype = attrnametype.toLowerCase();
                                                        if(getFileIsOffice(attrnametype)){
                                                            var imgObj = '<div class="imgfileBox" style="position:  relative;"><img atturl="'+ v +'" name="'+_this.attr('name')+'" src="'+fileuploadSRC+'" style="cursor: pointer;margin: 0 5px;'+_this.attr('style')+'"  id="'+_this.attr('name')+'" align="absmiddle" style=""  class="fileupload_data"    width="'+_this.attr('width')+'" height="'+_this.attr('height')+'"/><span class="uploadImg" style="width:'+_this.attr('width')+'px;text-align: center;">'+ nameTitle +'</span><ul class="hoverbox" flag="'+ flag +'"><li class="hoverboxLiDownload" style="'+ download +'"><span class="plotting">></span>下载</li><li class="hoverboxLiPreview0" style="'+ preview +'"><span class="plotting">></span>预览</li><li class="hoverboxLiPreview" style="'+ preview +'"><span class="plotting">></span>查阅</li><li class="hoverboxLiEdit" style="'+ edit +'"><span class="plotting">&gt;</span>编辑</li><li class="hoverboxLidelete" style="'+ deletet +'"><span class="plotting">></span>删除</li></ul></div>';
                                                        }else if(getFileIsPDForTXT(attrnametype) || getFileIsPic(attrnametype)){
                                                            var imgObj = '<div class="imgfileBox" style="position:  relative;"><img atturl="'+ v +'" name="'+_this.attr('name')+'" src="'+fileuploadSRC+'" style="cursor: pointer;margin: 0 5px;'+_this.attr('style')+'"  id="'+_this.attr('name')+'" align="absmiddle" style=""  class="fileupload_data"    width="'+_this.attr('width')+'" height="'+_this.attr('height')+'"/><span class="uploadImg" style="width:'+_this.attr('width')+'px;text-align: center;">'+ nameTitle +'</span><ul class="hoverbox" flag="'+ flag +'"><li class="hoverboxLiDownload" style="'+ download +'"><span class="plotting">></span>下载</li><li class="hoverboxLiPreview0" style="'+ preview +'"><span class="plotting">></span>预览</li><li class="hoverboxLidelete" style="'+ deletet +'"><span class="plotting">></span>删除</li></ul></div>';
                                                        }else{
                                                            var imgObj = '<div class="imgfileBox" style="position:  relative;"><img atturl="'+ v +'" name="'+_this.attr('name')+'" src="'+fileuploadSRC+'" style="cursor: pointer;margin: 0 5px;'+_this.attr('style')+'"  id="'+_this.attr('name')+'" align="absmiddle" style=""  class="fileupload_data"    width="'+_this.attr('width')+'" height="'+_this.attr('height')+'"/><span class="uploadImg" style="width:'+_this.attr('width')+'px;text-align: center;">'+ nameTitle +'</span><ul class="hoverbox" flag="'+ flag +'"><li class="hoverboxLiDownload" style="'+ download +'"><span class="plotting">></span>下载</li><li class="hoverboxLidelete" style="'+ deletet +'"><span class="plotting">></span>删除</li></ul></div>';
                                                        }
                                                        _this.before(imgObj);
                                                    }
                                                });
                                                if(_this.attr("disabled") == "disabled") {
                                                    _this.hide();
                                                }
                                            }
                                            break;
                                        case 'imgupload':
                                            if(dataNameVal != '' && dataNameVal.indexOf('*')>-1){
                                                var download = 'display: block;';
                                                var preview = 'display: block;';
                                                var deletet = 'display: block;';
                                                var flag = true;
                                                _this.show();
                                                dataNameVal.split('*').forEach(function (v,i) {
                                                    if(v&&v.indexOf('&ATTACHMENT_NAME=')>-1){
                                                        v = v.replace(/\%2c/g, ",");
                                                        var thisspan = v.split('&ATTACHMENT_NAME=')[1].split('&')[0];
                                                        var str = v;
                                                        var strs = str.split('&ATTACHMENT_NAME=')[0];
                                                        var name = str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[0];
                                                        var attName = encodeURI(name).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                                        var atturl =strs+"&ATTACHMENT_NAME="+attName+"&FILESIZE="+str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[1];

                                                        var imgObj = '<div class="imgfileBox" style="display:  inline-block;position:  relative;"><img name="'+_this.attr('name')+'" src="'+encodeURI(atturl)+'" style="cursor: pointer;'+_this.attr('style')+'"  id="'+_this.attr('name')+'" title="'+v.split('&ATTACHMENT_NAME=')[1].split('&')[0]+'" align="absmiddle" style=""  class="imgupload_data"    width="'+_this.attr('width')+'" height="'+_this.attr('height')+'"/><span class="uploadImg" title="'+ v.split('&ATTACHMENT_NAME=')[1].split('&')[0] +'" style="width:'+_this.attr('width')+'px;text-align: center;">'+ thisspan +'</span><ul class="hoverbox" flag="'+ flag +'"><li class="hoverboxLiDownload" style="'+ download +'"><span class="plotting">></span>下载</li><li class="hoverboxLiPreview0"  style="'+ preview +'"><span class="plotting">></span>预览</li><li class="hoverboxLidelete"  style="'+ deletet +'"><span class="plotting">></span>删除</li></ul></div>';
                                                        _this.before(imgObj);
                                                    }
                                                });
                                                if(_this.attr("disabled") == "disabled") {
                                                    _this.hide();
                                                }
                                            }
                                            break;
                                        case 'macros':
                                            if(_this.attr('type') == 'text'){
                                                // console.log(stringAuto[_this.attr("title")])
                                                if(stringAuto[_this.attr("title")] == undefined){ //判断允许在不可写情况下自动赋值的宏控件
                                                    if(_this.attr('datafld')=='SYS_USERNAME'&&_this.attr('orgsignImg')==1){
                                                        if(_this.prev('span').find('img').length > 0){
                                                            _this.prev('span').remove()
                                                        }
                                                        if(dataNameVal&&dataNameVal.indexOf('AID') >= 0){
                                                            _this.before('<span class="signSpan">'+function(){
                                                                if(dataNameVal&&dataNameVal.indexOf('AID')>=0){
                                                                    return '<img style="width:100px;" src="'+dataNameVal+'" alt="">'
                                                                }else{
                                                                    return ''
                                                                }
                                                            }()+'</span>');
                                                            _this.attr('signSrc',dataNameVal)
                                                            _this.hide();
                                                            if(_this.next().hasClass('refresh')){
                                                                _this.next().hide();
                                                            }
                                                        }else{
                                                            if (dataNameVal == '{macros}') {
                                                                var datafld = _this.attr('datafld');
                                                                dataNameVal = ''
                                                            }
                                                            _this.attr('value', dataNameVal);
                                                        }

                                                    }else {
                                                        if (dataNameVal == '{macros}') {
                                                            var datafld = _this.attr('datafld');
                                                            dataNameVal = ''
                                                        }
                                                        if(dataNameVal&&dataNameVal.indexOf('AID') >= 0){
                                                            _this.before('<span class="signSpan">'+function(){
                                                                if(dataNameVal&&dataNameVal.indexOf('AID')>=0){
                                                                    return '<img style="width:100px;" src="'+dataNameVal+'" alt="">'
                                                                }else{
                                                                    return ''
                                                                }
                                                            }()+'</span>');
                                                            _this.attr('signSrc',dataNameVal)
                                                            _this.hide();
                                                            if(_this.next().hasClass('refresh')){
                                                                _this.next().hide();
                                                            }
                                                        }else{
                                                            _this.attr('value', dataNameVal);
                                                        }
                                                    }
                                                }
                                                // console.log(333)
                                            }else{
                                                _this.attr('pval',dataNameVal);
                                                if(dataNameVal && dataNameVal.indexOf('_')>-1){
                                                    _this.val(dataNameVal.split('_')[0]);
                                                }else{
                                                    _this.find("option[value='"+dataNameVal+"']").prop("selected","selected").attr("selected","selected").siblings().removeAttr("selected");

                                                }

                                            }
                                            if(_this.attr('secret') == 1) {
                                                _this.next().hide();
                                            }
                                            break;
                                        case 'calendar':
                                            _this.attr('value',dataNameVal);
                                            break;
                                        case 'kgsign':
                                            _this.attr('value',dataNameVal);
                                            _this.find('img').remove();
                                            break;
                                        case 'macrossign':
                                            // _this.before(dataNameVal);
                                            // _this.remove();
                                            //console.log(1);
                                            break;
                                        case 'sign':
                                            var prev = _this.prev();
                                            var prevtext = dataNameVal+prev.html();
                                            prev.attr('templ',prevtext);
                                            prev.html(prevtext);
                                            break;
                                        case 'userselect':
                                            var valuearr = dataNameVal.split('|');
                                            if(dataNameVal.indexOf('|')>-1){
                                                _this.attr('user_id',valuearr[0]);
                                                _this.attr('username',valuearr[1]);
                                                _this.attr('value',valuearr[1]);
                                            }else{
                                                _this.attr('username',valuearr);
                                                _this.attr('value',valuearr);
                                            }

                                            break;
                                        case 'deptselect':
                                            var valuearr = dataNameVal.split('|');
                                            _this.attr('deptid',valuearr[0]);
                                            _this.attr('deptname',valuearr[1]);
                                            _this.attr('value',valuearr[1]);
                                            break;
                                        case 'autocode':
                                            if(_this.attr('secret') == 1){
                                                _this.next('').hide();
                                            }
                                            _this.attr('value',dataNameVal);
                                            break;
                                        case 'listing':
                                            var vlist = dataNameVal;
                                            if(_this.attr('disabled') == 'disabled'){
                                                workForm.option.footShow = 1;
                                                if(vlist !=""){
                                                    that.tool.buildListPluData(_this,vlist,that);
                                                }
                                                _this.find('input').attr('disabled','disabled');
                                                _this.find('textarea').attr('disabled','disabled');
                                                _this.find('select').attr('disabled','disabled');
                                                _this.find('.delete_row').attr('disabled','disabled');
                                            }else{
                                                workForm.option.footShow = 0;
                                                if(vlist !=""){
                                                    that.tool.buildListPluData(_this,vlist,that);
                                                }
                                            }


                                            break;
                                        case 'readcomments':
                                            _this.html(dataNameVal);
                                            break;
                                        case 'calculation':
                                            _this.attr('value',dataNameVal);
                                            break;
                                        case 'writesign':
                                            //移动端手写
                                            if(_this.attr('data-type') == 'writesign'){
                                                var id = _this.attr('name');
                                                if(id){
                                                    var str1 = '',str2 = '';
                                                    var isNone=''
                                                    if(_this.attr("disabled") == "disabled") {
                                                        var str = 'display: none;';
                                                        isNone = '1';
                                                    }
                                                    if(_this.attr('isMust')){
                                                        var must = "isMust='true'";
                                                    }else{
                                                        var must = "";
                                                    }
                                                    // console.log(( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ))
                                                    //手机端
                                                    if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )||/(Android)/i.test(navigator.userAgent)) {
                                                        if(dataNameVal!=''){
                                                            var imgSrc=dataNameVal.split('|');
                                                            var cImg = '<img style="max-width: 500px;width:90%;height:auto;vertical-align: middle" dataType="'+function(){
                                                                if(imgSrc[1]==workForm.tool.getMacrosData('SYS_USERID')()&&isNone!=1){
                                                                    return '1'
                                                                }else{
                                                                    return '0'
                                                                }
                                                            }()+'" update="'+function(){
                                                                if(imgSrc[1]==workForm.tool.getMacrosData('SYS_USERID')()&&isNone!=1){
                                                                    return '1'
                                                                }else{
                                                                    return '0'
                                                                }
                                                            }()+'" onclick="showImg(this)" class="writeSignImg'+id+'" data-img2blob="'+imgSrc[0]+'" src="'+imgSrc[0]+'"/>'
                                                            if(!matchString($('#module').val(),'10')){
                                                                $(cImg).img2blob({
                                                                    watermark: '试用',
                                                                    fontStyle: '楷体',
                                                                    fontSize: '100', // px
                                                                    fontColor: 'red', // default 'black'
                                                                    fontX: 70, // The x coordinate where to start painting the text
                                                                    fontY: 200
                                                                });
                                                            }
                                                            _this.before('<span class="mobileSign" id="WRITE_SIGN_'+ id +'" >'+cImg+'\
                                                        <input type="hidden" name="'+ id +'" value="'+dataNameVal+'" id="'+ id +'" class="form_item" data-type="writeSign" title="'+ _this.attr('title') +'" "'+ must +'">\
                                                        </span>');

                                                        }else{
                                                            _this.before('<span class="mobileSign" id="WRITE_SIGN_'+ id +'" ><input dataId="'+ id +'"  class="signBtn SmallButtonA" onclick="writeSign($(this));" value="手写" type="button"  style="    width: 52px;\n' +
                                                                '    border: none;height: 21px;font-size: 12px;color: #333;'+ str +'">\
                                                    <input type="hidden" name="'+ id +'" value="'+dataNameVal+'" id="'+ id +'" class="form_item" data-type="writeSign" title="'+ _this.attr('title') +'" "'+ must +'">\
                                                    </span>');
                                                        }


                                                    }else{ //电脑端
                                                        if(dataNameVal!=''){
                                                            var imgSrc=dataNameVal.split('|');

                                                            var cImg = '<img style="max-width: 500px;width:90%;height:auto;vertical-align: middle" onclick="showImgPic(this)" class="writeSignImg'+id+'" data-img2blob="'+imgSrc[0]+'" src="'+imgSrc[0]+'"/>'
                                                            if(!matchString($('#module').val(),'10')){
                                                                $(cImg).img2blob({
                                                                    watermark: '试用',
                                                                    fontStyle: '楷体',
                                                                    fontSize: '100', // px
                                                                    fontColor: 'red', // default 'black'
                                                                    fontX: 70, // The x coordinate where to start painting the text
                                                                    fontY: 200
                                                                });
                                                            }
                                                            _this.before('<span class="mobileSign" id="WRITE_SIGN_'+ id +'" >'+cImg+'\
                                                        <input type="hidden" name="'+ id +'" value="'+dataNameVal+'" id="'+ id +'" class="form_item" data-type="writeSign" title="'+ _this.attr('title') +'" "'+ must +'">\
                                                        </span>');
                                                        }else{
                                                            _this.before('<span class="mobileSign" id="WRITE_SIGN_'+ id +'" >\
                                                    <input type="hidden" name="'+ id +'" value="'+dataNameVal+'" id="'+ id +'" class="form_item" data-type="writeSign" title="'+ _this.attr('title') +'" "'+ must +'">\
                                                    </span>');
                                                        }
                                                    }

                                                    _this.remove();
                                                }
                                            }
                                            break;
                                        case 'djsign':
                                            if(_this.attr('data-type') == 'djsign'){
                                                var id = _this.attr('name');
                                                var sign_check = ',';
                                                var sign_type1 = _this.attr('sign_type').split(',')[0];
                                                var sign_type2 = _this.attr('sign_type').split(',')[1];
                                                if(_this.attr('sign_check')){
                                                    var sign_check = _this.attr('sign_check')+',';
                                                }
                                                var color = _this.attr('sign_color');

                                                if(id){
                                                    var str = '',str1 = '',str2 = '';
                                                    var must = "";

                                                    if(_this.attr('window_size') != undefined){
                                                        var window_size = _this.attr('window_size');
                                                    }else{
                                                        var window_size = "";
                                                    }
                                                    if(_this.attr('mobilewinwidth') != undefined&&_this.attr('mobilewinheight') != undefined){
                                                        var mobilewinwidth = _this.attr('mobilewinwidth');
                                                        var mobilewinheight = _this.attr('mobilewinheight');
                                                    }else{
                                                        var mobilewinwidth = 0;
                                                        var mobilewinheight = 0;
                                                    }
                                                    _this.before('<div class="websign" mobilewinwidth="'+ mobilewinwidth +'" mobilewinheight="'+ mobilewinheight +'" id="SIGN_POS_' + id + '" sign_check="' + id + ':' + sign_check + '">&nbsp;<input type="button" value="盖章" name="WEBSIGN_' + id + '" class="SmallButtonA" onclick="addSeal($(this));" style="' + str + str1 + '">\
                                                        <input type="button" value="手写" name="WEBSIGN_'+ id +'" class="SmallButtonA" window_size="'+ window_size +'" onclick="handWrite($(this));" color="'+ color +'" style="'+ str+str2 +'">\
                                                        <input type="hidden" name="'+ id +'" value="'+ dataNameVal +'" id="'+ id +'" class="form_item" data-type="djsign" title="'+ _this.attr('title') +'" '+ must +'>\
                                                        </div>');
                                                    _this.remove();
                                                }
                                            }

                                            break;
                                        default:
                                    }
                                }
                            });
                            // if(typeof  Signature != 'undefined'){
                            //     var signatureCreator = Signature.create();
                            //     signatureCreator.getSaveSignatures(that.option.flowRun.runId, function(signs){
                            //         var signdata = new Array();
                            //         var jsonList = eval("("+signs+")");
                            //         for(var i=0;i<jsonList.length;i++){
                            //             var map = {};
                            //             map.signatureid = jsonList[i]["signatureId"];
                            //             map.signatureData = jsonList[i]["signature"];
                            //             signdata.push(map);
                            //         }
                            //         Signature.loadSignatures(signdata);
                            //     });
                            // }
                        });

                    }
                }else{
                    //正常流转流程
                    if(v.prcsId == that.option.prcsId){
                        indexsnum++;
                        var steptOpt = v;
                        // console.log(steptOpt)
                        that.tool.requiredItem = v.requiredItem;
                        var queryData = {flowId:that.option.flowRun.flowId,runId:that.option.flowRun.runId}
                        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent)) {
                            queryData.userAgent = 'mobile'
                        }
                        that.tool.ajaxHtml('/workflow/work/selectFlowData',queryData,function (res) {

                            var opflag =  $.getQueryString("opflag") || '';
                            var url = location.href;
                            workForm.option.dataName = res.obj

                            if(res.obj!=undefined){
                                if(res.obj.flow_auto_num!=undefined){
                                    that.macrosSymbol(res.obj.flow_auto_num)
                                }
                            }

                            if(opflag == ''){ // ios新建工作流兼容ios419版本 不传opflag 还有workformh5.jsp存在判断
                                opflag = 1;
                            }
                            if(opflag == 0){
                                $('#foot_rig').hide();
                                $('#foot_rig1').show();
                                if(url.indexOf('workform?') > -1){
                                    $('#level').attr('disabled','disabled');
                                }
                            }
                            if(url.indexOf('workformh5') > -1||url.indexOf('turnh5') > -1||url.indexOf('workformPreView') > -1||url.indexOf('workformh5PreView') > -1){

                            }else{
                                noneperson();
                            }
                            var dataName = upperJSONKey(res.obj)||'';
                            that.option['snum'] = res.softSerialNo;
                            //权限控制(修改为判断是否相同而不是包含 解决名称类似字段无法识别的问题)
                            var string = {};
                            var stringAuto = {};
                            var sp = steptOpt.prcsItem.split(',');
                            if(steptOpt.prcsItemAuto!=""&&steptOpt.prcsItemAuto!=undefined){ //判断再不可写字段情况下允许赋值的宏控件
                                var spAuto= steptOpt.prcsItemAuto.split(',')
                                spAuto.forEach(function (v,i) {
                                    stringAuto[v] = i;
                                })
                            }
                            sp.forEach(function (v,i) {
                                string[v] = i;
                            });
                            /*********************处理多个富文本控件时，无法赋值的问题开始********************************/
                            if(that.option.eleObject.find('.form_item[rich=1]').length != 0&&!that.option.ish5){
                                var $rich = that.option.eleObject.find('.form_item[rich=1]');
                                for(var i=0;i<$rich.length;i++){
                                    var id = $rich.eq(i).attr('id').split('DATA_')[1];
                                    var val = dataName[$rich.eq(i).attr('id')]||'';
                                    var setEnabled = '';
                                    if(string[$rich.eq(i).attr("title")] == undefined){
                                        setEnabled = "UE.getEditor('container"+ id +"').setDisabled('fullscreen')";
                                    }
                                    var script = '';
                                    if(val != ''){
                                        var script = "<script>UE.getEditor('container"+ id +"').ready(function(){\n" +
                                            "                                        var Val = '"+ UEhtmlEscape(val) +"';\n" +
                                            "                                        if(Val.substr(0,1) != '<'){\n" +
                                            "                                            Val = '<p>'+Val+'</p>';\n" +
                                            "                                        }\n" +
                                            "                                        UE.getEditor('container"+ id +"').setContent(Val);\n" +setEnabled+
                                            "\n" +
                                            "                                    });</script>";

                                    }else{
                                        if(setEnabled != ''){
                                            var script = "<script>UE.getEditor('container"+ id +"').ready(function(){\n" +
                                                setEnabled+
                                                "\n" +
                                                "                                    });</script>";
                                        }
                                    }
                                    $('body').append(script);
                                }

                            }
                            /*********************处理多个富文本控件时，无法赋值的问题结束********************************/
                            that.option.eleObject.find('.form_item').each(function(i,v){
                                var _this = $(this);
                                var _hidden = false;
                                var dataType = _this.attr("data-type");
                                var isHidden = _this.attr("orghidden");
                                if(1 == isHidden ){
                                    _hidden = true;
                                    _this.hide();
                                }
                                //判断是否为可写字段，会签控件经办人单独判断是否是可写字段
                                if(string[_this.attr("title")] == undefined || (opflag == 0 && _this.attr("data-type") == 'sign' && _this.attr("write_yn") == '0')){
                                    if(_this.attr("data-type") == 'macros'){
                                        if(_this.attr('type') == 'text'){
                                            if(stringAuto[_this.attr("title")] == undefined){
                                                _this.attr('value','');
                                            }
                                        }else{
                                            _this.attr('value','');
                                        }

                                        // _this.attr('value','');
                                    }else if(_this.attr("data-type") == 'macrossign'){
                                        //_this.html('');
                                    }else if(_this.attr("data-type") == 'sign'){
                                        _this.prev().find('#eiderarea').hide()
                                    }
                                    else if(_this.attr("data-type") == 'fileupload'){
                                        _this.hide();
                                    }else if(_this.attr("data-type") == 'imgupload'){
                                        _this.hide();
                                    }else if(_this.attr("data-type") == 'kgsign'){
                                        _this.find('button').hide();
                                    }else if(_this.attr("data-type") == 'listing'){
                                        _this.find('.listfoot').hide();

                                        _this.find('.delete_row').hide();
                                        _this.find('input').attr('disabled','disabled');
                                        _this.find('textarea').attr('disabled','disabled');
                                        _this.find('select').attr('disabled','disabled');
                                        _this.find('.delete_row').attr('disabled','disabled');
                                    }else if(_this.attr("data-type") == 'deptselect'){
                                        _this.attr('style','cursor: not-allowed !important;background: #eee url(/img/workflow/form/group_select.png) no-repeat right !important;'+_this.attr('style'))
                                    }else if(_this.attr("data-type") == 'userselect'){
                                        _this.attr('style','cursor: not-allowed !important;background: #eee url(/img/workflow/form/user_select.png) no-repeat right !important;'+_this.attr('style'))
                                    }else if(_this.attr("data-type") == 'extdataselect' || _this.attr("data-type") == 'dataselect'){ //数据源是否是可写字段，如果否删除
                                        _this.remove();
                                    }

                                    _this.attr("disabled","disabled");
                                }else{

                                    if(_this.attr("data-type") == 'macros'){

                                        if(_this.is('input') && _this.attr('orghidden')!=1 ){
                                            // _this.attr("disabled","disabled");
                                            if(workForm.option.opFlag == 1){ //判断是否为主办人，如果是的话并且是可写字段后面显示刷新
                                                if(_this.attr('datafld')=='SYS_USERNAME'&&_this.attr('orgsignImg')==1){
                                                    if(_this.prev('span').find('img').length>0){
                                                        _this.prev('span').remove()
                                                    }
                                                    if(workForm.tool.getMacrosData('SYS_SIGN_IMAGE')()!=''&&workForm.tool.getMacrosData('SYS_SIGN_IMAGE')()!=undefined){
                                                        _this.before('<span>'+function(){
                                                            if(workForm.tool.getMacrosData('SYS_SIGN_IMAGE')()){
                                                                return '<img style="width:100px;" src="/xs?'+workForm.tool.getMacrosData('SYS_SIGN_IMAGE')()+'" alt="">'
                                                            }else{
                                                                return ''
                                                            }
                                                        }()+'</span>');
                                                        _this.attr('signSrc','/xs?'+workForm.tool.getMacrosData('SYS_SIGN_IMAGE')());
                                                        _this.hide();
                                                    }else{
                                                        _this.after('<button class="refresh" type="button" data-type="macros" id="' + _this.attr("id") + '" datafld="' + _this.attr('datafld') + '" title="刷新"><img src="/img/workflow/work/refresh.png" alt="" style="vertical-align: middle;margin-top: -3px;margin-right: 2px;"></button>')
                                                    }
                                                }else if(_this.attr('datafld')=='SYS_CODE'){
                                                    let name = _this.attr('name'),
                                                        orgcode = _this.attr('orgcode');
                                                    _this.attr('readonly',true);
                                                    _this.after('<span class="choosespan" onclick="sysCodeChoose($(this))" name="'+ name +'" code="'+ orgcode +'">选择</span>' +
                                                        '<span class="choosespan" onclick="clearCode($(this))" name="'+ name +'" style="padding-left: 2px;margin-left: 0px;">清空</span>')

                                                }else {
                                                    _this.after('<button class="refresh" type="button" data-type="macros" id="' + _this.attr("id") + '" datafld="' + _this.attr('datafld') + '" title="刷新"><img src="/img/workflow/work/refresh.png" alt="" style="vertical-align: middle;margin-top: -3px;margin-right: 2px;"></button>')
                                                }

                                            }
                                        }
                                    }


                                    //数据源如果是外部重新渲染控件
                                    if(_this.attr("data-type") == 'extdataselect'){
                                        //添加样式
                                        _this.addClass('layui-icon layui-icon-face-smile layui-icon layui-icon-add-1');
                                        _this.attr("style","height: auto; width: auto; font-size: 30px; color: #1E9FFF;");

                                        //添加点击事件
                                        var id=_this.attr("id");
                                        var strid=id.replace("DATA_","");
                                        _this.attr("onclick","extdataselect("+strid+")");

                                        //清空内容进行替换
                                        _this.html(''); //内容清空
                                        var str=_this.get(0).outerHTML;
                                        var str2=str.replace("button","i");
                                        _this.replaceWith(str2);
                                    }

                                    //内部数据源添加事件
                                    if(_this.attr("data-type") == 'dataselect'){
                                        var way=_this.attr('way');
                                        if (way!='0'){
                                            _this.css('display','none'); //隐藏控件
                                            var data_table=_this.attr('data_table'); //表名
                                            var data_field=_this.attr('data_field').split(','); //字段
                                            var data_control=_this.attr('data_control').split(','); //关联的控件名
                                            var data_querys=_this.attr('data_querys').split(','); //是否是查询字段
                                            $.ajax({
                                                url: "/TerpServerController/selectapptable",
                                                type: 'get',
                                                data: {dName:"data_"+data_table},
                                                dataType: 'json',
                                                success: function (res) {
                                                    var obj=res.obj;
                                                    //添加select属性
                                                    for(var j=0;j<data_field.length;j++){
                                                        //判断是否是查询字段如果是才可以进行添加select属性
                                                        if (data_querys[j]==='1'){
                                                            var option=' <datalist id="'+data_field[j]+'" >\n';
                                                            for (var i=0;i<obj.length;i++){
                                                                option+='<option style="display: block">'+obj[i][data_field[j]]+'</option>';
                                                            }
                                                            option+='</datalist>';
                                                            var dis=$('input[title="'+data_control[j]+'"]').attr('disabled');
                                                            if(dis!=undefined){
                                                                $('input[title="'+data_control[j]+'"]').append(option); //追加下拉框
                                                                $('input[title="'+data_control[j]+'"]').attr('list',data_field[j]); //添加select属性
                                                            }

                                                        }
                                                    }

                                                },
                                                error: function () {
                                                }
                                            });

                                        }else{
                                            var id=_this.attr("id");
                                            var strid=id.replace("DATA_","");
                                            _this.attr("onclick","dataselect("+strid+")");
                                        }
                                    }

                                    if(checkStrIn(steptOpt.requiredItem,_this.attr("title") )){
                                        _this.attr('ismust',true);
                                    }
                                };
                                //权限控制结束
                                if(checkStrIn(steptOpt.hiddenItem,_this.attr("title"))){
                                    _hidden = true;
                                    _this.attr('hidden',true);
                                    _this.before("*****").attr('secret',1);
                                    _this.hide();
                                    if(_this.next().hasClass('refresh')){
                                        _this.next().hide();
                                    }
                                    if(_this.prev().find('#eiderarea').length != 0){
                                        _this.prev().hide();
                                    }
                                }
                                //表单填充数据
                                var dataNameVal = dataName[_this.attr('name')] ||'';

                                if(that.option.preView){
                                    //查看详情页面控件展示
                                    switch (_this.attr('data-type')){
                                        case 'text':
                                            if(!_hidden){
                                                _this.before('<span class="preview" style="'+ _this.attr('style') +';height:auto">'+dataNameVal+'</span>');
                                            }
                                            _this.attr('value',dataNameVal);
                                            _this.hide();
                                            break;
                                        case 'markformItem':
                                            if(!_hidden){
                                                _this.attr('value',dataNameVal);
                                            }else{
                                                _this.attr('value','hideen');
                                            }
                                            break;
                                        case 'textarea':
                                            if(!_this.hasClass('special_form_item')){
                                                var width = _this.css('width');
                                                var height = _this.css('height');
                                                // console.log(dataNameVal.replace(/<(?:.|\s)*?>/g,''))
                                                if(_this.attr('rich')!=undefined&&_this.attr('rich')==1){
                                                    _this.parent().find('.container').remove();
                                                }
                                                if(!_hidden){
                                                    // dataNameVal = dataNameVal.replace(/\r\n/g, '<br/>').replace(/\n/g, '<br/>').replace(/\s/g, ' ');
                                                    // dataNameVal = dataNameVal.replace(/\r\n/g, '<br/>').replace(/\n/g, '<br/>').replace(/ /g, '&nbsp;');
                                                    _this.before('<div class="preview" style="'+ _this.attr('style') +';border: none;box-shadow: none;width:'+width+';height: auto;min-height: '+ height +'!important;" readonly title="' + dataNameVal.replace(/\n/g, '<br />') + '">'+dataNameVal.replace(/\n/g, '<br />')+'</div>');
                                                }
                                                if(dataNameVal != "" && dataNameVal != undefined){
                                                    _this.prev().show()
                                                    _this.prev().css('display','inline-block')
                                                    _this.hide()
                                                }else{
                                                    _this.next().show()
                                                    _this.hide()
                                                }
                                                _this.text(dataNameVal);

                                                _this.css({
                                                    'border': 'none',
                                                    'background': '#fff',
                                                    // 'overflow': 'hidden',
                                                    'box-shadow':'none'
                                                });
                                                _this.attr('disabled','disabled')
                                            }
                                            break;
                                        case 'countersignature_item':
                                            countersignature_item = true;
                                            break;
                                        case 'select':
                                            _this.find("option[value='"+dataNameVal+"']").attr("selected",true).siblings().attr("selected",false);
                                            _this.find("option[value='"+dataNameVal+"']").prop("selected",true).siblings().prop("selected",false);
                                            if(!_hidden){
                                                var selectVal =  _this.find("option[value='"+dataNameVal+"']").text();
                                                /***************处理当前下拉框是child下拉框控件开始*********************/
                                                if(selectVal.indexOf('|') > -1){
                                                    selectVal = selectVal.split('|')[0]
                                                }
                                                /***************处理child下拉框控件结束*********************/
                                                _this.before('<span class="preview" style="'+ _this.attr('style') +';">'+ selectVal +'</span>');
                                            }
                                            _this.hide();
                                            break;
                                        case 'radio':
                                            if(_this.attr('secret') != 1) {
                                                that.option.eleObject.find(":radio[name='" + _this.attr('name') + "'][value='" + dataNameVal + "']").prop("checked", "checked");
                                                that.option.eleObject.find(":radio[name='" + _this.attr('name') + "'][value='" + dataNameVal + "']").attr("checked", "checked");
                                                that.option.eleObject.find(":radio[name='" + _this.attr('name') + "'][value='" + dataNameVal + "']").siblings(":radio[name='"+_this.attr('name')+"']").removeAttr('checked');
                                                that.option.eleObject.find(":radio[name='" + _this.attr('name') + "']").attr('disabled', "disabled")
                                            }else{
                                                if(_this.next().hasClass('radioBox')){
                                                    _this.next().remove();
                                                }
                                            }
                                            break;
                                        case 'checkbox':
                                            if(dataNameVal == '1'||dataNameVal=='on'){
                                                _this.prop("checked",'checked');
                                            }else{
                                                _this.prop("checked",false);
                                            }
                                            _this.attr("disabled","disabled");
                                            break;
                                        case 'fileupload':
                                            if( _this.attr('secret') == 1) break;
                                            if(dataNameVal && dataNameVal.indexOf('*')>-1){
                                                _this.show();
                                                if($.GetRequest().flowStep != ''&&$.GetRequest().prcsId != ''){
                                                    var strify = that.option.flowProcesses.fileuploadPriv||'';
                                                    var download = 'display: none;';
                                                    var preview = 'display: none;';
                                                    try {
                                                        if(strify != '' && strify != undefined && JSON.parse(strify).length > 0){
                                                            var flag = false;
                                                            for(var i=0;i<JSON.parse(strify).length;i++){
                                                                if(JSON.parse(strify)[i]['FILE_PRIV_'+_this.attr('id')] != undefined){
                                                                    var checkThis = JSON.parse(strify)[i]['FILE_PRIV_'+_this.attr('id')];
                                                                    if(checkThis.indexOf('4') != -1){
                                                                        flag = true;
                                                                        download = 'display: block;'
                                                                    }
                                                                    if(checkThis.indexOf('1') != -1){
                                                                        flag = true;
                                                                        preview = 'display: block;'
                                                                    }
                                                                    break;
                                                                }
                                                            }
                                                        }
                                                    }
                                                    catch(err) {

                                                    }
                                                }else{
                                                    var download = 'display: block;';
                                                    var preview = 'display: block;';
                                                    var flag = true;
                                                }
                                                // _this.prev('span').hide();
                                                dataNameVal.split('*').forEach(function (v,i) {
                                                    if(v&&v.indexOf('&ATTACHMENT_NAME=')>-1){
                                                        v = v.replace(/\%2c/g, ",");
                                                        var fileConfigArr = v.split('&');
                                                        // 增加集体处理附件上传控件已上传附件数据回显时候的url处理
                                                        var FileArr = getFileArrType(fileConfigArr).split('*');
                                                        var nameTitle = FileArr[0] + '.' + FileArr[1];
                                                        var FileArrType = FileArr[1];
                                                        var fileuploadSRC = that.tool.iconImgType[FileArrType]||"/img/icon_file.png";
                                                        FileArrType = FileArrType.toLowerCase();
                                                        if(getFileIsOffice(FileArrType)){
                                                            var imgObj = '<div class="imgfileBox" style="position:  relative;"><img atturl="'+ v +'" name="'+_this.attr('name')+'" src="'+fileuploadSRC+'" style="cursor: pointer;margin: 0 5px;'+_this.attr('style')+'"  id="'+_this.attr('name')+'" align="absmiddle" style=""  class="fileupload_data"    width="'+_this.attr('width')+'" height="'+_this.attr('height')+'"/><span class="uploadImg" style="width:'+_this.attr('width')+'px;text-align: center;">'+ nameTitle +'</span><ul class="hoverbox" flag="'+ flag +'"><li class="hoverboxLiDownload" style="'+ download +'"><span class="plotting">></span>下载</li><li class="hoverboxLiPreview0" style="'+ preview +'"><span class="plotting">></span>预览</li><li class="hoverboxLiPreview" style="'+ preview +'"><span class="plotting">></span>查阅</li></ul></div>';
                                                        }else if(getFileIsPDForTXT(FileArrType) || getFileIsPic(FileArrType)){
                                                            var imgObj = '<div class="imgfileBox" style="position:  relative;"><img atturl="'+ v +'" name="'+_this.attr('name')+'" src="'+fileuploadSRC+'" style="cursor: pointer;margin: 0 5px;'+_this.attr('style')+'"  id="'+_this.attr('name')+'" align="absmiddle" style=""  class="fileupload_data"    width="'+_this.attr('width')+'" height="'+_this.attr('height')+'"/><span class="uploadImg" style="width:'+_this.attr('width')+'px;text-align: center;">'+ nameTitle +'</span><ul class="hoverbox" flag="'+ flag +'"><li class="hoverboxLiDownload" style="'+ download +'"><span class="plotting">></span>下载</li><li class="hoverboxLiPreview0" style="'+ preview +'"><span class="plotting">></span>预览</li</ul></div>';
                                                        }else{
                                                            var imgObj = '<div class="imgfileBox" style="position:  relative;"><img atturl="'+ v +'" name="'+_this.attr('name')+'" src="'+fileuploadSRC+'" style="cursor: pointer;margin: 0 5px;'+_this.attr('style')+'"  id="'+_this.attr('name')+'" align="absmiddle" style=""  class="fileupload_data"    width="'+_this.attr('width')+'" height="'+_this.attr('height')+'"/><span class="uploadImg" style="width:'+_this.attr('width')+'px;text-align: center;">'+ nameTitle +'</span><ul class="hoverbox" flag="'+ flag +'"><li class="hoverboxLiDownload" style="'+ download +'"><span class="plotting">></span>下载</li></div>';
                                                        }
                                                        _this.before(imgObj);
                                                    }
                                                });
                                            }
                                            _this.hide();
                                            break;
                                        case 'imgupload':
                                            if( _this.attr('secret') == 1) break;
                                            if(dataNameVal != '' && dataNameVal.indexOf('*')>-1){
                                                _this.show();
                                                if($.GetRequest().flowStep != ''&&$.GetRequest().prcsId != ''){
                                                    var strify = that.option.flowProcesses.imguploadPriv||'';
                                                    var download = 'display: none;';
                                                    var preview = 'display: none;';
                                                    try {
                                                        if(strify != '' && strify != undefined && JSON.parse(strify).length > 0){
                                                            var flag = false;
                                                            for(var i=0;i<JSON.parse(strify).length;i++){
                                                                if(JSON.parse(strify)[i]['IMG_PRIV_'+_this.attr('id')] != undefined){
                                                                    var checkThis = JSON.parse(strify)[i]['IMG_PRIV_'+_this.attr('id')];
                                                                    if(checkThis.indexOf('3') != -1){
                                                                        flag = true;
                                                                        download = 'display: block;'
                                                                    }
                                                                    if(checkThis.indexOf('1') != -1){
                                                                        flag = true;
                                                                        preview = 'display: block;'
                                                                    }
                                                                    break;
                                                                }
                                                            }
                                                        }
                                                    }
                                                    catch(err) {

                                                    }
                                                }else{
                                                    var download = 'display: block;';
                                                    var preview = 'display: block;';
                                                    var flag = true;
                                                }
                                                // _this.prev('span').hide();
                                                dataNameVal.split('*').forEach(function (v,i) {
                                                    if(v&&v.indexOf('&ATTACHMENT_NAME=')>-1){
                                                        v = v.replace(/\%2c/g, ",");
                                                        var str = v;
                                                        var strs = str.split('&ATTACHMENT_NAME=')[0];
                                                        var name = str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[0];
                                                        var attName = encodeURI(name).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                                        var atturl =strs+"&ATTACHMENT_NAME="+attName+"&FILESIZE="+str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[1];
                                                        var imgObj = '<div class="imgfileBox" style="display:  inline-block;position:  relative;padding-left: 0px"><img name="'+_this.attr('name')+'" src="'+encodeURI(atturl)+'" style="position:static;width:'+_this.attr('width')+'px !important;height:'+_this.attr('height')+'px !important;cursor: pointer;'+_this.attr('style')+'"  id="'+_this.attr('name')+'" title="'+v.split('&ATTACHMENT_NAME=')[1].split('&')[0]+'" align="absmiddle" style=""  class="imgupload_data"    width="'+_this.attr('width')+'" height="'+_this.attr('height')+'"/><ul class="hoverbox" flag="'+ flag +'"><li class="hoverboxLiDownload" style="'+ download +'"><span class="plotting">></span>下载</li><li class="hoverboxLiPreview0" style="'+ preview +'"><span class="plotting">></span>预览</li></ul></div>';
                                                        _this.before(imgObj);
                                                    }
                                                })
                                            }
                                            _this.hide();
                                            break;
                                        case 'macros':
                                            if(_this.attr('type') == 'text' || _this.is('input')){
                                                if (dataNameVal == '{macros}'){
                                                    dataNameVal=''
                                                } else{
                                                    dataNameVal = dataNameVal
                                                }
                                                if(!_hidden){
                                                    if(_this.attr('datafld')=='SYS_USERNAME'&&_this.attr('orgsignImg')==1){
                                                        if(_this.prev('span').find('img').length>0){
                                                            _this.prev('span').remove()
                                                        }
                                                        if(dataNameVal&&dataNameVal.indexOf('AID')>=0){
                                                            _this.before('<span class="signSpan">'+function(){
                                                                if(dataNameVal&&dataNameVal.indexOf('AID')>=0){
                                                                    return '<img style="width:100px;" src="'+dataNameVal+'" alt="">'
                                                                }else{
                                                                    return ''
                                                                }
                                                            }()+'</span>');
                                                            _this.attr('signSrc',dataNameVal)
                                                        }else{
                                                            _this.before('<span class="preview" style="'+ _this.attr('style') +';display: inline-block;height: auto;min-height: '+ _this.css('height') +';">'+dataNameVal+'</span>');
                                                        }

                                                    }else{
                                                        if(dataNameVal&&dataNameVal.indexOf('AID')>=0){
                                                            _this.before('<span class="signSpan">'+function(){
                                                                if(dataNameVal&&dataNameVal.indexOf('AID')>=0){
                                                                    return '<img style="width:100px;" src="'+dataNameVal+'" alt="">'
                                                                }else{
                                                                    return ''
                                                                }
                                                            }()+'</span>');
                                                            _this.attr('signSrc',dataNameVal)
                                                        }else{
                                                            _this.before('<span class="preview" style="'+ _this.attr('style') +';display: inline-block;height: auto;min-height: '+ _this.css('height') +';">'+dataNameVal+'</span>');
                                                        }
                                                    }
                                                }
                                                _this.attr('value',dataNameVal);
                                                if(_this.next().hasClass('refresh')){
                                                    _this.next().hide();
                                                    if(dataNameVal&&dataNameVal.indexOf('AID')>=0){
                                                        _this.next().remove();
                                                    }
                                                }
                                            }else{
                                                if(dataNameVal.indexOf('┌')>-1){
                                                    dataNameVal = dataNameVal.split('┌')[1]
                                                }else if(dataNameVal.indexOf('_├')>-1 ){
                                                    dataNameVal = dataNameVal.split('_├')[1]
                                                }else if(dataNameVal.indexOf('_')>-1){
                                                    dataNameVal = dataNameVal.split('_')[1]
                                                }else{
                                                    dataNameVal = dataNameVal;
                                                }

                                                _this.attr('pval',dataNameVal);
                                                _this.attr('value',dataNameVal);
                                                dataNameVal = dataNameVal.replace(/\r\n/g, '<br/>').replace(/\n/g, '<br/>').replace(/\s/g, ' ');
                                                _this.before('<span class="preview" style="'+ _this.attr('style') +';display: inline-block">'+ dataNameVal+'</span>');
                                            }
                                            if(_this.attr('secret') == 1) {
                                                _this.prev().hide();
                                            }
                                            _this.hide();
                                            break;
                                        case 'calendar':
                                            if(!_hidden){
                                                _this.before('<span class="preview" style="display: inline-block;'+ _this.attr('style') +'">'+dataNameVal+'</span>');
                                            }

                                            _this.attr('value',dataNameVal);
                                            _this.hide();
                                            break;
                                        case 'kgsign':
                                            _this.find('img').remove();
                                            break;
                                        case 'macrossign':
                                            if(!_hidden){
                                                var height = _this.css('height');
                                                if(_this.parent().find('span') != undefined && _this.parent().find('span').html() != ""){
                                                    _this.show().css({'height':'auto','min-height':height+'px'});
                                                }else{
                                                    _this.before('<span class="preview" style="'+ _this.attr('style') +';display: inline-block;height:auto;min-height: '+ height +';">'+dataNameVal+'</span>');
                                                    _this.hide();
                                                }
                                            }
                                            _this.attr('value',dataNameVal);
                                            break;
                                        case 'sign':
                                            _this.prev().hide();
                                            var height = _this.css('height');
                                            if(dataNameVal == ''){
                                                //新增的会签控件功能需要，处理之前的会签数据控件
                                                var flag = _this.attr("flag")||'1';
                                                var userIds = '';
                                                if(flag == 3){
                                                    userIds = _this.attr("userids")||'';
                                                }
                                                $.ajax({
                                                    type: "post",
                                                    url: "/Countersignature/getSignfeedback",
                                                    dataType: 'JSON',
                                                    data: {
                                                        'runId':workForm.option.runId,
                                                        'flag':flag,
                                                        'feedFlag':_this.attr('name').split('DATA_')[1],
                                                        'userIds':userIds
                                                    },
                                                    async:false,
                                                    success: function (json) {
                                                        if(json.obj.length > 0){
                                                            for(var i=0;i<json.obj.length;i++){
                                                                dataNameVal += json.obj[i].content;
                                                            }
                                                        }
                                                    }
                                                })

                                            }
                                            if(!_hidden){
                                                _this.before('<span class="preview" style="'+ _this.attr('style') +';display: inline-block;height: auto;min-height: '+ height +';">'+dataNameVal+'</span>');
                                            }
                                            _this.prev().attr('templ',prevtext);
                                            _this.hide();
                                            _this.siblings('img').remove();
                                            //prev.html(dataNameVal);
                                            break;
                                        case 'autocode':
                                            if(_this.attr('secret') != 1) {
                                                _this.before(dataNameVal);
                                                _this.remove();
                                            }
                                            break;
                                        case 'listing':
                                            var vlist = dataNameVal;
                                            if(vlist!=''){
                                                that.tool.buildListPluData(_this,vlist,that);
                                            }

                                            _this.find('.listfoot').hide();

                                            _this.find('.delete_row').hide();
                                            break;
                                        case 'readcomments':
                                            _this.html(dataNameVal);
                                            break;
                                        case 'userselect':
                                            if(_this.attr('secret') != 1) {
                                                var valuearr = dataNameVal.split('|');
                                                var title = valuearr[0];
                                                var value = valuearr[1];
                                                if(value == undefined){
                                                    value = valuearr;
                                                }
                                                var display = 'display: inline-block;'
                                                if(_this.attr('display')){
                                                    display = 'display: none;'
                                                }
                                                _this.before('<div name="'+_this.attr('name')+'" id="'+_this.attr('id')+'" user_id="'+title+'" value="'+value+'" class="form_item " data-type="userselect" title="'+_this.attr('title')+'"  orgfontsize="'+_this.attr('orgfontsize')+'" orgwidth="'+_this.attr('orgwidth')+'" orgheight="'+_this.attr('orgheight')+'" style="width: '+ _this.css('width') +';background: none!important;height: auto;min-height: 40px;min-height: '+ _this.attr('orgheight') +'px;'+ display +'">'+value+'</div>');
                                                _this.remove();
                                            }
                                            break;
                                        case 'deptselect':
                                            if(_this.attr('secret') != 1) {
                                                var valuearr = dataNameVal.split('|');
                                                var title = valuearr[0];
                                                var value = valuearr[1];
                                                if(value == undefined){
                                                    value = '';
                                                }
                                                var display = 'display: inline-block;'
                                                if(_this.attr('display')){
                                                    display = 'display: none;'
                                                }
                                                _this.before('<div name="'+_this.attr('name')+'" id="'+_this.attr('id')+'" user_id="'+title+'" value="'+value+'" class="form_item " data-type="deptselect" title="'+_this.attr('title')+'"  orgfontsize="'+_this.attr('orgfontsize')+'" orgwidth="'+_this.attr('orgwidth')+'" orgheight="'+_this.attr('orgheight')+'" style="width: '+ _this.css('width') +';background: none!important;height: auto;min-height: 40px;min-height: '+ _this.attr('orgheight') +'px;'+ display +'">'+value+'</div>');
                                                _this.remove();
                                            }
                                            break;
                                        case 'calculation':
                                            if(_this.attr('secret') != 1){
                                                _this.before(dataNameVal);
                                                _this.attr('value',dataNameVal);
                                                _this.hide();
                                            }
                                            break;

                                        case 'djsign':
                                            if(_this.attr('secret') == 1) break;
                                            if(_this.attr('data-type') == 'djsign'){
                                                var id = _this.attr('name');
                                                var sign_check = ',';
                                                var sign_type1 = _this.attr('sign_type').split(',')[0];
                                                var sign_type2 = _this.attr('sign_type').split(',')[1];
                                                if(_this.attr('sign_check')){
                                                    var sign_check = _this.attr('sign_check')+',';
                                                }
                                                var color = _this.attr('sign_color');

                                                if(id){
                                                    var str = "display: none;";
                                                    var str1 = 'display: none;',str2 = 'display: none;';

                                                    if(_this.attr('isMust')){
                                                        var must = "isMust='true'";
                                                    }else{
                                                        var must = "";
                                                    }
                                                    if(_this.attr('window_size') != undefined){
                                                        var window_size = _this.attr('window_size');
                                                    }else{
                                                        var window_size = "";
                                                    }
                                                    if(_this.attr('mobilewinwidth') != undefined&&_this.attr('mobilewinheight') != undefined){
                                                        var mobilewinwidth = _this.attr('mobilewinwidth');
                                                        var mobilewinheight = _this.attr('mobilewinheight');
                                                    }else{
                                                        var mobilewinwidth = 0;
                                                        var mobilewinheight = 0;
                                                    }
                                                    _this.before('<div class="websign" mobilewinwidth="'+ mobilewinwidth +'" mobilewinheight="'+ mobilewinheight +'" id="SIGN_POS_' + id + '" sign_check="' + id + ':' + sign_check + '">&nbsp;<input type="button" value="盖章" name="WEBSIGN_' + id + '" class="SmallButtonA" onclick="addSeal($(this));" style="' + str + str1 + '">\
                                                        <input type="button" value="手写" name="WEBSIGN_'+ id +'" class="SmallButtonA" onclick="handWrite($(this));" window_size="'+ window_size +'" color="'+ color +'" style="display: none;'+ str+str2 +'">\
                                                        <input type="hidden" name="'+ id +'" value="'+ dataNameVal +'" id="'+ id +'" class="form_item" data-type="djsign" title="'+ _this.attr('title') +'" '+ must +'>\
                                                        </div>');
                                                    _this.remove();
                                                }
                                            }

                                            break;
                                        case 'writesign':

                                            //移动端手写
                                            if(_this.attr('data-type') == 'writesign'){

                                                var id = _this.attr('name');
                                                if(id){
                                                    var str1 = '',str2 = '';
                                                    var isNone=''
                                                    if(_this.attr("disabled") == "disabled") {
                                                        var str = 'display: none;';
                                                        isNone = '1';
                                                    }
                                                    if(_this.attr('isMust')){
                                                        var must = "isMust='true'";
                                                    }else{
                                                        var must = "";
                                                    }
                                                    // console.log(( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ))
                                                    //手机端
                                                    if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )||/(Android)/i.test(navigator.userAgent)) {
                                                        if(dataNameVal!=''){
                                                            var imgSrc=dataNameVal.split('|');
                                                            var cImg = '<img style="max-width: 500px;width:90%;height:auto;vertical-align: middle" update="0" class="writeSignImg'+id+'" data-img2blob="'+imgSrc[0]+'" onclick="showImg(this)" src="'+imgSrc[0]+'"/>'
                                                            if(!matchString($('#module').val(),'10')){
                                                                $(cImg).img2blob({
                                                                    watermark: '试用',
                                                                    fontStyle: '楷体',
                                                                    fontSize: '100', // px
                                                                    fontColor: 'red', // default 'black'
                                                                    fontX: 70, // The x coordinate where to start painting the text
                                                                    fontY: 200
                                                                });
                                                            }
                                                            _this.before('<span class="mobileSign" id="WRITE_SIGN_'+ id +'" >'+cImg+'\
                                                        <input type="hidden" name="'+ id +'" value="'+dataNameVal+'" id="'+ id +'" class="form_item" data-type="writeSign" title="'+ _this.attr('title') +'" "'+ must +'">\
                                                        </span>');
                                                        }else{
                                                            _this.before('<span class="mobileSign" id="WRITE_SIGN_'+ id +'" >\
                                                    <input type="hidden" name="'+ id +'" value="'+dataNameVal+'" id="'+ id +'" class="form_item" data-type="writeSign" title="'+ _this.attr('title') +'" "'+ must +'">\
                                                    </span>');
                                                        }


                                                    }else{ //电脑端

                                                        if(dataNameVal!=''){
                                                            var imgSrc=dataNameVal.split('|');
                                                            var cImg = '<img style="max-width: 500px;width:90%;height:auto;vertical-align: middle" update="0" class="writeSignImg'+id+'" data-img2blob="'+imgSrc[0]+'" onclick="showImgPic(this)" src="'+imgSrc[0]+'"/>'
                                                            if(!matchString($('#module').val(),'10')){
                                                                $(cImg).img2blob({
                                                                    watermark: '试用',
                                                                    fontStyle: '楷体',
                                                                    fontSize: '100', // px
                                                                    fontColor: 'red', // default 'black'
                                                                    fontX: 70, // The x coordinate where to start painting the text
                                                                    fontY: 200
                                                                });
                                                            }
                                                            _this.before('<span class="mobileSign" id="WRITE_SIGN_'+ id +'" >'+cImg+'\
                                                        <input type="hidden" name="'+ id +'" value="'+dataNameVal+'" id="'+ id +'" class="form_item" data-type="writeSign" title="'+ _this.attr('title') +'" "'+ must +'">\
                                                        </span>');
                                                        }else{
                                                            _this.before('<span class="mobileSign" id="WRITE_SIGN_'+ id +'" >\
                                                    <input type="hidden" name="'+ id +'" value="'+dataNameVal+'" id="'+ id +'" class="form_item" data-type="writeSign" title="'+ _this.attr('title') +'" "'+ must +'">\
                                                    </span>');
                                                        }
                                                    }

                                                    _this.remove();
                                                }
                                            }
                                            break;
                                        default:
                                        // console.log(i);
                                    }
                                }else{
                                    //办理页面控件展示
                                    if (opflag == 0) {
                                        if (!_this.hasClass('countersignature_item') && !_this.hasClass('sign') && _this.attr('data-type') != 'sign') {
                                            _this.attr('disabled', 'disabled');
                                        }
                                        if (_this.hasClass('fileupload') || _this.hasClass('imgupload')) {
                                            _this.attr('noMainSignerFileYn', steptOpt.noMainSignerFileYn);
                                        }
                                    }
                                    if(dataNameVal == ''&&_this.attr("data-type") == 'sign'){
                                        //新增的会签控件功能需要，处理之前的会签数据控件
                                        var flag = _this.attr("flag")||'1';
                                        var userIds = '';
                                        if(flag == 3){
                                            userIds = _this.attr("userids")||'';
                                        }
                                        $.ajax({
                                            type: "post",
                                            url: "/Countersignature/getSignfeedback",
                                            dataType: 'JSON',
                                            data: {
                                                'runId':workForm.option.runId,
                                                'flag':flag,
                                                'feedFlag':_this.attr('name').split('DATA_')[1],
                                                'userIds':userIds
                                            },
                                            async:false,
                                            success: function (json) {
                                                if(json.obj.length > 0){
                                                    var htmlstr = '';
                                                    for(var i=0;i<json.obj.length;i++){
                                                        htmlstr += json.obj[i].content;
                                                    }
                                                    if (!_this.prop("disabled")) {
                                                        _this.after('<img src="/img/workflow/form/icon_countersign.png" id="signImg" signImg ="1"  style="position: relative;margin-left:-26px;cursor: pointer;" />')
                                                    }

                                                    var prev = _this.prev();
                                                    var prevtext = htmlstr+prev.html();
                                                    prev.attr('templ',prevtext);
                                                    prev.attr('tv',htmlstr);
                                                    var $div = $('<div>'+prevtext+'</div>');
                                                    var flowRunPrcs = workForm.option.flowRunPrcs;
                                                    $div.find('.eiderarea').each(function(index){
                                                        if (!_this.prop("disabled") && $(this).attr('user_id') == flowRunPrcs.userId && $(this).attr('prcs_id') == flowRunPrcs.flowPrcs && $(this).attr('time_stamp')) {
                                                            if ($div.find('.eiderarea').length - 1 > index) {
                                                                $(this).find('.remove_sign').show();
                                                            }
                                                        } else {
                                                            $(this).find('.remove_sign').hide();
                                                        }
                                                    });

                                                    prev.html($div.html());
                                                    if(_this.attr('disabled') == 'disabled'){
                                                        _this.next().attr('id', '');
                                                        if (!(( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent))) {
                                                            _this.hide();
                                                        }
                                                    }
                                                }
                                            }
                                        })

                                    }
                                    if(dataNameVal == '' && steptOpt.prcsItem.indexOf(_this.attr("title")) > -1){
                                        if(_this.attr('secret') != 1) {
                                            if (_this.attr('data-type') == 'djsign') {
                                                var id = _this.attr('name');
                                                var sign_check = ',';
                                                var sign_type1 = _this.attr('sign_type').split(',')[0];
                                                var sign_type2 = _this.attr('sign_type').split(',')[1];
                                                if (_this.attr('sign_check')) {
                                                    var sign_check = _this.attr('sign_check') + ',';
                                                }
                                                var color = _this.attr('sign_color');

                                                if (id) {
                                                    var str1 = '', str2 = '';
                                                    if (_this.attr("disabled") == "disabled") {
                                                        var str = 'display: none;';
                                                    } else {
                                                        var str = '';
                                                        if (sign_type1 == '0') {
                                                            str1 = "display: none;";
                                                        }
                                                        if (sign_type2 == '0') {
                                                            str2 = "display: none;";
                                                        }
                                                    }
                                                    if (_this.attr('isMust')) {
                                                        var must = "isMust='true'";
                                                    } else {
                                                        var must = "";
                                                    }
                                                    if(_this.attr('window_size') != undefined){
                                                        var window_size = _this.attr('window_size');
                                                    }else{
                                                        var window_size = "";
                                                    }
                                                    if(_this.attr('mobilewinwidth') != undefined&&_this.attr('mobilewinheight') != undefined){
                                                        var mobilewinwidth = _this.attr('mobilewinwidth');
                                                        var mobilewinheight = _this.attr('mobilewinheight');
                                                    }else{
                                                        var mobilewinwidth = 0;
                                                        var mobilewinheight = 0;
                                                    }
                                                    _this.before('<div class="websign" mobilewinwidth="'+ mobilewinwidth +'" mobilewinheight="'+ mobilewinheight +'" id="SIGN_POS_' + id + '" sign_check="' + id + ':' + sign_check + '">&nbsp;<input type="button" value="盖章" name="WEBSIGN_' + id + '" class="SmallButtonA" onclick="addSeal($(this));" style="' + str + str1 + '">\
                                                        <input type="button" value="手写" name="WEBSIGN_' + id + '" class="SmallButtonA" window_size="'+ window_size +'" onclick="handWrite($(this));" color="' + color + '" style="' + str + str2 + '">\
                                                        <input type="hidden" name="' + id + '" value="" id="' + id + '" class="form_item" data-type="djsign" title="' + _this.attr('title') + '" ' + must + '>\
                                                        </div>');
                                                    _this.remove();
                                                }
                                            }
                                            //移动端手写
                                            if (_this.attr('data-type') == 'writesign') {
                                                // console.log(44)
                                                var id = _this.attr('name');
                                                if (id) {
                                                    var str1 = '', str2 = '';
                                                    if (_this.attr("disabled") == "disabled") {
                                                        var str = 'display: none;';
                                                    }
                                                    if (_this.attr('isMust')) {
                                                        var must = "isMust='true'";
                                                    } else {
                                                        var must = "";
                                                    }
                                                    if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent)) {
                                                        _this.before('<span class="mobileSign" id="WRITE_SIGN_' + id + '" ><input dataId="' + id + '"  class="signBtn SmallButtonA" onclick="writeSign($(this));" value="手写" type="button"  style="    width: 52px;\n' +
                                                            '    border: none;height: 21px;font-size: 12px;color: #333;' + str + '">\
                                                        <input type="hidden" name="' + id + '" value="" id="' + id + '" class="form_item" data-type="writeSign" title="' + _this.attr('title') + '" ' + must + '>\
                                                        </span>');
                                                        _this.remove();
                                                    } else {

                                                        _this.before('<span class="mobileSign" id="WRITE_SIGN_' + id + '" ><input dataId="' + id + '"  class="signBtn SmallButtonA" onclick="writeSign($(this));"  value="手写" type="button"  style="    width: 52px;\n' +
                                                            '    border: none;height: 21px;font-size: 12px;color: #333;' + str + '">\
                                                        <input type="hidden" name="' + id + '" value="" id="' + id + '" class="form_item" data-type="writeSign" title="' + _this.attr('title') + '" ' + must + '>\
                                                        </span>');
                                                        // _this.before('<span class="mobileSign" id="WRITE_SIGN_' + id + '" >\
                                                        // <input type="button" name="' + id + '" value="" id="' + id + '" class="form_item" data-type="writeSign" title="' + _this.attr('title') + '" ' + must + '>\
                                                        // </span>');
                                                        _this.remove();
                                                    }

                                                }
                                            }
                                            // 处理会签控件
                                            if (_this.attr('data-type') == 'sign'  &&_this.siblings('#signImg').attr('signImg') != "1") {
                                                if (!_this.prop("disabled")) {
                                                    _this.after('<img src="/img/workflow/form/icon_countersign.png" id="signImg" style="position: relative;margin-left:-26px;cursor: pointer;" />')
                                                }
                                            }
                                        }
                                    }else{
                                        switch (_this.attr('data-type')){
                                            case 'text':
                                                _this.attr('value',dataNameVal);

                                                //预算
                                                if(workForm.option.tableName == 'budget'&&_this[0].id == 'DATA_213'){
                                                    workForm.option.budgeId = dataNameVal;
                                                }
                                                break;
                                            case 'markformItem':
                                                _this.attr('value',dataNameVal);
                                                break;
                                            case 'textarea':
                                                if(!_this.hasClass('countersignature_item')){
                                                    _this.text(dataNameVal);
                                                }
                                                // if(!that.option.ish5 &&_this.attr('rich')!= undefined&&_this.attr('rich')==1){
                                                //     var id = 'container'+_this.attr('id').split('DATA_')[1];
                                                //     var ue = UE.getEditor(id);
                                                //     UE.getEditor(id).ready(function(){
                                                //         dataNameVal = dataName['DATA_'+UE.getEditor(id).key.split('container')[1]]||'';
                                                //         if(dataNameVal.substr(0,1) != '<'){
                                                //            dataNameVal = '<p>'+dataNameVal+'</p>';
                                                //         }
                                                //         UE.getEditor(id).setContent(dataNameVal);
                                                //
                                                //     });
                                                // }

                                                break;
                                            case 'countersignature_item':
                                                countersignature_item = true;
                                                break;
                                            case 'select':
                                                _this.find("option[value='"+dataNameVal+"']").prop("selected","selected").attr("selected","selected").siblings().removeAttr("selected");
                                                break;
                                            case 'radio':
                                                if( _this.attr('secret') != 1){
                                                    that.option.eleObject.find(":radio[name='"+_this.attr('name')+"'][value='" + dataNameVal + "']").prop("checked", "checked");
                                                    that.option.eleObject.find(":radio[name='"+_this.attr('name')+"'][value='" + dataNameVal + "']").attr("checked", "checked");
                                                    that.option.eleObject.find(":radio[name='"+_this.attr('name')+"'][value='" + dataNameVal + "']").siblings(":radio[name='"+_this.attr('name')+"']").removeAttr('checked');

                                                }else{
                                                    if(_this.next().hasClass('radioBox')){
                                                        _this.next().remove();
                                                    }
                                                }
                                                break;
                                            case 'checkbox':
                                                if(dataNameVal == '1'||dataNameVal=='on'){
                                                    _this.prop("checked",'checked');
                                                }else{
                                                    _this.prop("checked",false);
                                                }
                                                break;
                                            case 'fileupload':
                                                if( _this.attr('secret') == 1) break;
                                                if(dataNameVal && dataNameVal.indexOf('*')>-1){
                                                    _this.show();
                                                    // _this.prev('span').hide();
                                                    var strify = that.option.flowProcesses.fileuploadPriv||'';
                                                    var download = 'display: none;';
                                                    var preview = 'display: none;';
                                                    var edit = 'display: none;';
                                                    var deletet = 'display: none;';
                                                    try {
                                                        if(strify != '' && strify != undefined && JSON.parse(strify).length > 0){
                                                            var flag = false;
                                                            for(var i=0;i<JSON.parse(strify).length;i++){
                                                                if(JSON.parse(strify)[i]['FILE_PRIV_'+_this.attr('id')] != undefined){
                                                                    var checkThis = JSON.parse(strify)[i]['FILE_PRIV_'+_this.attr('id')];
                                                                    if(checkThis.indexOf('4') != -1){
                                                                        flag = true;
                                                                        download = 'display: block;'
                                                                    }
                                                                    if(checkThis.indexOf('1') != -1){
                                                                        flag = true;
                                                                        preview = 'display: block;'
                                                                    }
                                                                    if(checkThis.indexOf('2') != -1){
                                                                        flag = true;
                                                                        edit = 'display: block;'
                                                                    }
                                                                    if(checkThis.indexOf('3') != -1){
                                                                        flag = true;
                                                                        deletet = 'display: block;'
                                                                    }
                                                                    break;
                                                                }
                                                            }
                                                        }
                                                    }
                                                    catch(err) {

                                                    }
                                                    dataNameVal.split('*').forEach(function (v,i) {
                                                        if(v&&v.indexOf('&ATTACHMENT_NAME=')>-1){
                                                            v = v.replace(/\%2c/g, ",");
                                                            var fileConfigArr = v.split('&');
                                                            // 增加集体处理附件上传控件已上传附件数据回显时候的url处理
                                                            var FileArr = getFileArrType(fileConfigArr).split('*');
                                                            var nameTitle = FileArr[0] + '.' + FileArr[1];
                                                            var FileArrType = FileArr[1];
                                                            var fileuploadSRC = that.tool.iconImgType[FileArrType]||"/img/icon_file.png";
                                                            var attrnametype = FileArrType;
                                                            attrnametype = attrnametype.toLowerCase();
                                                            if(getFileIsOffice(attrnametype)){
                                                                var imgObj = '<div class="imgfileBox" style="position:  relative;"><img atturl="'+ v +'" name="'+_this.attr('name')+'" src="'+fileuploadSRC+'" style="cursor: pointer;margin: 0 5px;'+_this.attr('style')+'"  id="'+_this.attr('name')+'" align="absmiddle" style=""  class="fileupload_data"    width="'+_this.attr('width')+'" height="'+_this.attr('height')+'"/><span class="uploadImg" style="width:'+_this.attr('width')+'px;text-align: center;">'+ nameTitle +'</span><ul class="hoverbox" flag="'+ flag +'"><li class="hoverboxLiDownload" style="'+ download +'"><span class="plotting">></span>下载</li><li class="hoverboxLiPreview0" style="'+ preview +'"><span class="plotting">></span>预览</li><li class="hoverboxLiPreview" style="'+ preview +'"><span class="plotting">></span>查阅</li><li class="hoverboxLiEdit" style="'+ edit +'"><span class="plotting">&gt;</span>编辑</li><li class="hoverboxLidelete" style="'+ deletet +'"><span class="plotting">></span>删除</li></ul></div>';
                                                            }else if(getFileIsPDForTXT(attrnametype) || getFileIsPic(attrnametype)){
                                                                var imgObj = '<div class="imgfileBox" style="position:  relative;"><img atturl="'+ v +'" name="'+_this.attr('name')+'" src="'+fileuploadSRC+'" style="cursor: pointer;margin: 0 5px;'+_this.attr('style')+'"  id="'+_this.attr('name')+'" align="absmiddle" style=""  class="fileupload_data"    width="'+_this.attr('width')+'" height="'+_this.attr('height')+'"/><span class="uploadImg" style="width:'+_this.attr('width')+'px;text-align: center;">'+ nameTitle +'</span><ul class="hoverbox" flag="'+ flag +'"><li class="hoverboxLiDownload" style="'+ download +'"><span class="plotting">></span>下载</li><li class="hoverboxLiPreview0" style="'+ preview +'"><span class="plotting">></span>预览</li><li class="hoverboxLidelete" style="'+ deletet +'"><span class="plotting">></span>删除</li></ul></div>';
                                                            }else{
                                                                var imgObj = '<div class="imgfileBox" style="position:  relative;"><img atturl="'+ v +'" name="'+_this.attr('name')+'" src="'+fileuploadSRC+'" style="cursor: pointer;margin: 0 5px;'+_this.attr('style')+'"  id="'+_this.attr('name')+'" align="absmiddle" style=""  class="fileupload_data"    width="'+_this.attr('width')+'" height="'+_this.attr('height')+'"/><span class="uploadImg" style="width:'+_this.attr('width')+'px;text-align: center;">'+ nameTitle +'</span><ul class="hoverbox" flag="'+ flag +'"><li class="hoverboxLiDownload" style="'+ download +'"><span class="plotting">></span>下载</li><li class="hoverboxLidelete" style="'+ deletet +'"><span class="plotting">></span>删除</li></ul></div>';
                                                            }
                                                            _this.before(imgObj);
                                                        }
                                                    });
                                                    if(_this.attr("disabled") == "disabled") {
                                                        _this.hide();
                                                    }
                                                }
                                                break;
                                            case 'imgupload':
                                                if( _this.attr('secret') == 1) break;
                                                if(dataNameVal != '' && dataNameVal.indexOf('*')>-1){
                                                    var strify = that.option.flowProcesses.imguploadPriv||'';
                                                    var download = 'display: none;';
                                                    var preview = 'display: none;';
                                                    var deletet = 'display: none;';
                                                    try {
                                                        if(strify != '' && strify != undefined && JSON.parse(strify).length > 0){
                                                            var flag = false;
                                                            for(var i=0;i<JSON.parse(strify).length;i++){
                                                                if(JSON.parse(strify)[i]['IMG_PRIV_'+_this.attr('id')] != undefined){
                                                                    var checkThis = JSON.parse(strify)[i]['IMG_PRIV_'+_this.attr('id')];
                                                                    if(checkThis.indexOf('3') != -1){
                                                                        flag = true;
                                                                        download = 'display: block;'
                                                                    }
                                                                    if(checkThis.indexOf('1') != -1){
                                                                        flag = true;
                                                                        preview = 'display: block;'
                                                                    }
                                                                    if(checkThis.indexOf('2') != -1){
                                                                        flag = true;
                                                                        deletet = 'display: block;'
                                                                    }
                                                                    break;
                                                                }
                                                            }
                                                        }
                                                    }
                                                    catch(err) {

                                                    }
                                                    _this.show();
                                                    // _this.prev('span').hide();
                                                    dataNameVal.split('*').forEach(function (v,i) {
                                                        if(v&&v.indexOf('&ATTACHMENT_NAME=')>-1){
                                                            v = v.replace(/\%2c/g, ",");
                                                            var thisspan = v.split('&ATTACHMENT_NAME=')[1].split('&')[0];
                                                            var str = v;
                                                            var strs = str.split('&ATTACHMENT_NAME=')[0];
                                                            var name = str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[0];
                                                            var attName = encodeURI(name).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                                            var atturl =strs+"&ATTACHMENT_NAME="+attName+"&FILESIZE="+str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[1];

                                                            var imgObj = '<div class="imgfileBox" style="display:  inline-block;position:relative;padding-left:0px"><img name="'+_this.attr('name')+'" src="'+encodeURI(atturl)+'" style="position:static;width:'+_this.attr('width')+'px !important;height:'+_this.attr('height')+'px !important;cursor: pointer;'+_this.attr('style')+'"  id="'+_this.attr('name')+'" title="'+v.split('&ATTACHMENT_NAME=')[1].split('&')[0]+'" align="absmiddle" style=""  class="imgupload_data"    width="'+_this.attr('width')+'" height="'+_this.attr('height')+'"/><span class="uploadImg" title="'+ v.split('&ATTACHMENT_NAME=')[1].split('&')[0] +'" style="width:'+_this.attr('width')+'px;text-align: center;">'+ thisspan +'</span><ul class="hoverbox" flag="'+ flag +'"><li class="hoverboxLiDownload" style="'+ download +'"><span class="plotting">></span>下载</li><li class="hoverboxLiPreview0"  style="'+ preview +'"><span class="plotting">></span>预览</li><li class="hoverboxLidelete"  style="'+ deletet +'"><span class="plotting">></span>删除</li></ul></div>';
                                                            _this.before(imgObj);
                                                        }
                                                    });
                                                    if(_this.attr("disabled") == "disabled") {
                                                        _this.hide();
                                                    }
                                                }
                                                break;
                                            case 'macros':
                                                if(_this.attr('type') == 'text' || _this.is('input')){
                                                    if(stringAuto[_this.attr("title")] == undefined){
                                                        if(_this.attr('datafld')=='SYS_USERNAME'&&_this.attr('orgsignImg')==1){
                                                            if(_this.prev('span').find('img').length>0){
                                                                _this.prev('span').remove()
                                                            }
                                                            if(dataNameVal&&dataNameVal.indexOf('AID')>=0){
                                                                _this.before('<span class="signSpan" title="'+_this.attr('title')+'" >'+function(){
                                                                    if(dataNameVal&&dataNameVal.indexOf('AID')>=0){

                                                                        return '<img style="width:100px;" src="'+dataNameVal+'" alt="">'
                                                                    }else{
                                                                        return ''
                                                                    }
                                                                }()+'</span>');
                                                                _this.attr('signSrc',dataNameVal)
                                                                _this.hide();
                                                                if(_this.next().hasClass('refresh')){
                                                                    _this.next().hide();
                                                                }
                                                            }else{
                                                                if (dataNameVal == '{macros}') {
                                                                    var datafld = _this.attr('datafld');
                                                                    dataNameVal = ''
                                                                }
                                                                _this.attr('value', dataNameVal);
                                                            }

                                                        }else {
                                                            if (dataNameVal == '{macros}') {
                                                                var datafld = _this.attr('datafld');
                                                                dataNameVal = ''
                                                            }
                                                            if(dataNameVal&&dataNameVal.indexOf('AID')>=0){
                                                                _this.before('<span class="signSpan" title="'+_this.attr('title')+'" >'+function(){
                                                                    if(dataNameVal&&dataNameVal.indexOf('AID')>=0){

                                                                        return '<img style="width:100px;" src="'+dataNameVal+'" alt="">'
                                                                    }else{
                                                                        return ''
                                                                    }
                                                                }()+'</span>');
                                                                _this.attr('signSrc',dataNameVal)
                                                                _this.hide();
                                                                if(_this.next().hasClass('refresh')){
                                                                    _this.next().hide();
                                                                }
                                                            }else{
                                                                _this.attr('value', dataNameVal);
                                                            }
                                                        }
                                                    }else{
                                                        _this.addClass('prcsItemAuto');
                                                    }

                                                }else{
                                                    _this.attr('pval',dataNameVal);
                                                    if(dataNameVal && dataNameVal.indexOf('_')>-1){
                                                        if(string[_this.attr("title")]==undefined){
                                                            _this.html('<option value="'+dataNameVal.split('_')[0]+'">'+dataNameVal.split('_')[1]+'</option>')
                                                        }
                                                        _this.val(dataNameVal.split('_')[0]);
                                                    }else{
                                                        _this.find("option[value='"+dataNameVal+"']").prop("selected","selected").attr("selected","selected").siblings().removeAttr("selected");

                                                    }

                                                }
                                                if(_this.attr('secret') == 1) {
                                                    _this.next().hide();
                                                }
                                                break;
                                            case 'calendar':
                                                _this.attr('value',dataNameVal);
                                                break;
                                            case 'kgsign':
                                                _this.attr('value',dataNameVal);
                                                _this.find('img').remove();
                                                break;
                                            case 'macrossign':
                                                var height = _this.css('height');
                                                _this.css({'height': 'auto', 'min-height': height});
                                                if (_this.attr('datafld') == 'SYS_FLOW_CONNECTFLOW' && _this.attr('flowtype') == 1) {
                                                    var name = _this.attr('name');
                                                    var dataStr = workForm.option.dataName ? workForm.option.dataName[name] || '' : '';
                                                    if (dataStr.indexOf('<ul>') > -1) {
                                                        dataStr = '';
                                                    }
                                                    if (_this.attr('ispreview') == 1) {
                                                        _this.text(dataStr);
                                                    } else {
                                                        _this.attr('value', dataStr);
                                                    }
                                                }
                                                // _this.before(dataNameVal);
                                                // _this.remove();
                                                //console.log(1);
                                                break;
                                            case 'sign':
                                                if (!_this.prop("disabled")) {
                                                    _this.after('<img src="/img/workflow/form/icon_countersign.png" id="signImg" style="position: relative;margin-left:-26px;cursor: pointer;" />')
                                                }

                                                var prev = _this.prev();
                                                var prevtext = dataNameVal+prev.html();
                                                prev.attr('templ',prevtext);
                                                prev.attr('tv',dataNameVal);
                                                var $div = $('<div>'+prevtext+'</div>');
                                                var flowRunPrcs = workForm.option.flowRunPrcs;
                                                $div.find('.eiderarea').each(function(index){
                                                    if (!_this.prop("disabled") && $(this).attr('user_id') == flowRunPrcs.userId && $(this).attr('prcs_id') == flowRunPrcs.flowPrcs && $(this).attr('time_stamp')) {
                                                        if ($div.find('.eiderarea').length - 1 > index) {
                                                            $(this).find('.remove_sign').show();
                                                        }
                                                    } else {
                                                        $(this).find('.remove_sign').hide();
                                                    }
                                                });

                                                prev.html($div.html());
                                                if(_this.attr('disabled') == 'disabled'){
                                                    _this.next().attr('id', '');
                                                    if (!(( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent))) {
                                                        _this.hide();
                                                    }
                                                }
                                                break;
                                            case 'userselect':
                                                var valuearr = dataNameVal.split('|');
                                                if(dataNameVal.indexOf('|')>-1){
                                                    _this.attr('user_id',valuearr[0]);
                                                    _this.attr('username',valuearr[1]);
                                                    _this.attr('value',valuearr[1]);
                                                }else{
                                                    _this.attr('username',valuearr);
                                                    _this.attr('value',valuearr);

                                                }

                                                break;
                                            case 'deptselect':
                                                var valuearr = dataNameVal.split('|');
                                                _this.attr('deptid',valuearr[0]);
                                                _this.attr('deptname',valuearr[1]);
                                                _this.attr('value',valuearr[1]);
                                                break;
                                            case 'autocode':
                                                if(_this.attr('secret') == 1){
                                                    _this.next('').hide();
                                                }
                                                _this.attr('value',dataNameVal);
                                                break;
                                            case 'listing':
                                                var vlist = dataNameVal;
                                                if(_this.attr('disabled') == 'disabled'){
                                                    workForm.option.footShow = 1;
                                                    if(vlist !=""){
                                                        that.tool.buildListPluData(_this,vlist,that);
                                                    }
                                                    _this.find('input').attr('disabled','disabled');
                                                    _this.find('textarea').attr('disabled','disabled');
                                                    _this.find('select').attr('disabled','disabled');
                                                    _this.find('.delete_row').attr('disabled','disabled');
                                                }else{
                                                    workForm.option.footShow = 0;
                                                    if(vlist !=""){
                                                        that.tool.buildListPluData(_this,vlist,that);
                                                    }
                                                }
                                                break;
                                            case 'readcomments':
                                                _this.html(dataNameVal);
                                                break;
                                            case 'calculation':
                                                _this.attr('value',dataNameVal);
                                                break;
                                            case 'djsign':
                                                if(_this.attr('secret') == 1) break;
                                                if(_this.attr('data-type') == 'djsign'){
                                                    var id = _this.attr('name');
                                                    var sign_check = ',';
                                                    var sign_type1 = _this.attr('sign_type').split(',')[0];
                                                    var sign_type2 = _this.attr('sign_type').split(',')[1];
                                                    if(_this.attr('sign_check')){
                                                        var sign_check = _this.attr('sign_check')+',';
                                                    }
                                                    var color = _this.attr('sign_color');

                                                    if(id){
                                                        var str1 = '',str2 = '';
                                                        if(_this.attr("disabled") == "disabled") {
                                                            var str = "display: none;";
                                                        }else{
                                                            var str = "";
                                                            if(sign_type1 == '0'){
                                                                str1 = "display: none;";
                                                            }
                                                            if(sign_type2 == '0'){
                                                                str2 = "display: none;";
                                                            }
                                                        }
                                                        if(_this.attr('isMust')){
                                                            var must = "isMust='true'";
                                                        }else{
                                                            var must = "";
                                                        }
                                                        if(_this.attr('window_size') != undefined){
                                                            var window_size = _this.attr('window_size');
                                                        }else{
                                                            var window_size = "";
                                                        }
                                                        if(_this.attr('mobilewinwidth') != undefined&&_this.attr('mobilewinheight') != undefined){
                                                            var mobilewinwidth = _this.attr('mobilewinwidth');
                                                            var mobilewinheight = _this.attr('mobilewinheight');
                                                        }else{
                                                            var mobilewinwidth = 0;
                                                            var mobilewinheight = 0;
                                                        }
                                                        _this.before('<div class="websign" mobilewinwidth="'+ mobilewinwidth +'" mobilewinheight="'+ mobilewinheight +'" id="SIGN_POS_' + id + '" sign_check="' + id + ':' + sign_check + '">&nbsp;<input type="button" value="盖章" name="WEBSIGN_' + id + '" class="SmallButtonA" onclick="addSeal($(this));" style="' + str + str1 + '">\
                                                            <input type="button" value="手写" name="WEBSIGN_'+ id +'" class="SmallButtonA" window_size="'+ window_size +'" onclick="handWrite($(this));" color="'+ color +'" style="'+ str+str2 +'">\
                                                            <input type="hidden" name="'+ id +'" value="'+ dataNameVal +'" id="'+ id +'" class="form_item" data-type="djsign" title="'+ _this.attr('title') +'" '+ must +'>\
                                                            </div>');
                                                        _this.remove();
                                                    }
                                                }

                                                break;
                                            case 'writesign':

                                                //移动端手写
                                                if(_this.attr('data-type') == 'writesign'){

                                                    var id = _this.attr('name');
                                                    if(id){
                                                        var str1 = '',str2 = '';
                                                        var isNone=''
                                                        if(_this.attr("disabled") == "disabled") {
                                                            var str = 'display: none;';
                                                            isNone = '1';
                                                        }
                                                        if(_this.attr('isMust')){
                                                            var must = "isMust='true'";
                                                        }else{
                                                            var must = "";
                                                        }
                                                        // console.log(( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ))
                                                        //手机端
                                                        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )||/(Android)/i.test(navigator.userAgent)) {
                                                            if(dataNameVal!=''){
                                                                var imgSrc=dataNameVal.split('|');
                                                                var cImg = '<img style="max-width: 500px;width:90%;height:auto;vertical-align: middle" dataType="'+function(){
                                                                    if(imgSrc[1]==workForm.tool.getMacrosData('SYS_USERID')()&&isNone!=1){
                                                                        return '1'
                                                                    }else{
                                                                        return '0'
                                                                    }
                                                                }()+'" update="'+function(){
                                                                    if(imgSrc[1]==workForm.tool.getMacrosData('SYS_USERID')()&&isNone!=1){
                                                                        return '1'
                                                                    }else{
                                                                        return '0'
                                                                    }
                                                                }()+'" onclick="showImg(this)" class="writeSignImg'+id+'" data-img2blob="'+imgSrc[0]+'" src="'+imgSrc[0]+'"/>'
                                                                if(!matchString($('#module').val(),'10')){
                                                                    $(cImg).img2blob({
                                                                        watermark: '试用',
                                                                        fontStyle: '楷体',
                                                                        fontSize: '100', // px
                                                                        fontColor: 'red', // default 'black'
                                                                        fontX: 70, // The x coordinate where to start painting the text
                                                                        fontY: 200
                                                                    });
                                                                }
                                                                _this.before('<span class="mobileSign" id="WRITE_SIGN_'+ id +'" >'+cImg+'\
                                                        <input type="hidden" name="'+ id +'" value="'+dataNameVal+'" id="'+ id +'" class="form_item" data-type="writeSign" title="'+ _this.attr('title') +'" "'+ must +'">\
                                                        </span>');

                                                            }else{
                                                                _this.before('<span class="mobileSign" id="WRITE_SIGN_'+ id +'" ><input dataId="'+ id +'"  class="signBtn SmallButtonA" onclick="writeSign($(this));" value="手写" type="button"  style="    width: 52px;\n' +
                                                                    '    border: none;height: 21px;font-size: 12px;color: #333;'+ str +'">\
                                                    <input type="hidden" name="'+ id +'" value="'+dataNameVal+'" id="'+ id +'" class="form_item" data-type="writeSign" title="'+ _this.attr('title') +'" "'+ must +'">\
                                                    </span>');
                                                            }


                                                        }else{ //电脑端
                                                            if(dataNameVal!=''){
                                                                var imgSrc=dataNameVal.split('|');

                                                                var cImg = '<img style="max-width: 500px;width:90%;height:auto;vertical-align: middle" onclick="showImg(this)" update="1" class="writeSignImg'+id+'" data-img2blob="'+imgSrc[0]+'" src="'+imgSrc[0]+'"/>'
                                                                if(!matchString($('#module').val(),'10')){
                                                                    $(cImg).img2blob({
                                                                        watermark: '试用',
                                                                        fontStyle: '楷体',
                                                                        fontSize: '100', // px
                                                                        fontColor: 'red', // default 'black'
                                                                        fontX: 70, // The x coordinate where to start painting the text
                                                                        fontY: 200
                                                                    });
                                                                }
                                                                _this.before('<span class="mobileSign" id="WRITE_SIGN_'+ id +'" >'+cImg+'\
                                                        <input type="hidden" name="'+ id +'" value="'+dataNameVal+'" id="'+ id +'" class="form_item" data-type="writeSign" title="'+ _this.attr('title') +'" "'+ must +'">\
                                                        </span>');
                                                            }else{
                                                                _this.before('<span class="mobileSign" id="WRITE_SIGN_'+ id +'" >\
                                                    <input type="hidden" name="'+ id +'" value="'+dataNameVal+'" id="'+ id +'" class="form_item" data-type="writeSign" title="'+ _this.attr('title') +'" "'+ must +'">\
                                                    </span>');
                                                            }
                                                        }

                                                        _this.remove();
                                                    }
                                                }
                                                break;
                                            default:
                                        }
                                    }
                                }
                            });
                            // if(typeof  Signature != 'undefined'){
                            //     var signatureCreator = Signature.create();
                            //     signatureCreator.getSaveSignatures(that.option.flowRun.runId, function(signs){
                            //         var signdata = new Array();
                            //         var jsonList = eval("("+signs+")");
                            //         for(var i=0;i<jsonList.length;i++){
                            //             var map = {};
                            //             map.signatureid = jsonList[i]["signatureId"];
                            //             map.signatureData = jsonList[i]["signature"];
                            //             signdata.push(map);
                            //         }
                            //         Signature.loadSignatures(signdata);
                            //     });
                            // }
                        });
                    }
                    //在流程设计器所有流程步骤中，未找到符合的流程得异常情况兼容，取最后一个流程步骤
                    if(i == that.option.listFp.length-1){
                        if(indexsnum == 1){
                            var steptOpt = v;
                            that.tool.requiredItem = v.requiredItem;
                            that.tool.ajaxHtml('/workflow/work/selectFlowData',{flowId:that.option.flowRun.flowId,runId:that.option.flowRun.runId},function (res) {
                                if(res.flag == false){
                                    // console.log('/workflow/work/selectFlowData 接口未返回表格数据！')
                                }
                                workForm.option.dataName = res.obj;

                                if(res.obj!=undefined){
                                    if(res.obj.flow_auto_num!=undefined){
                                        that.macrosSymbol(res.obj.flow_auto_num)
                                    }
                                }

                                var opflag =  $.getQueryString("opflag") || '';
                                var url = location.href;
                                if(opflag == ''){ // ios新建工作流兼容ios419版本 不传opflag 还有workformh5.jsp存在判断
                                    opflag = 1;
                                }
                                if(opflag == 0){
                                    $('#foot_rig').hide();
                                    $('#foot_rig1').show();
                                    if(url.indexOf('workform?') > -1){
                                        $('#level').attr('disabled','disabled');
                                    }
                                }
                                if(url.indexOf('workformh5') > -1||url.indexOf('turnh5') > -1||url.indexOf('workformPreView') > -1||url.indexOf('workformh5PreView') > -1){

                                }else{
                                    noneperson();
                                }
                                dataName = upperJSONKey(res.obj);
                                that.option['snum'] = res.softSerialNo;
                                that.option.eleObject.find('.form_item').each(function(i,v){
                                    var _this = $(this);
                                    var _hidden = false;
                                    var dataType = _this.attr("data-type");
                                    var isHidden = _this.attr("orghidden");
                                    if(1 == isHidden ){
                                        _this.hide();
                                    }
                                    //权限控制(修改为判断是否相同而不是包含 解决名称类似字段无法识别的问题)
                                    var string = {};
                                    var sp = steptOpt.prcsItem.split(',');
                                    sp.forEach(function (v,i) {
                                        string[v] = i;
                                    })
                                    if(string[_this.attr("title")] == undefined){
                                        if(_this.attr("data-type") == 'macros'){
                                            _this.attr('value','');

                                        }else if(_this.attr("data-type") == 'macrossign'){

                                        }else if(_this.attr("data-type") == 'sign'){
                                            _this.prev().find('#eiderarea').hide()
                                        }
                                        else if(_this.attr("data-type") == 'fileupload'){
                                            _this.hide();
                                        }else if(_this.attr("data-type") == 'imgupload'){
                                            _this.hide();
                                        }else if(_this.attr("data-type") == 'kgsign'){
                                            _this.find('button').hide();
                                        }else if(_this.attr("data-type") == 'listing'){
                                            _this.find('.listfoot').hide();
                                            _this.find('input').attr('disabled','disabled');
                                            _this.find('textarea').attr('disabled','disabled');
                                            _this.find('select').attr('disabled','disabled');
                                            _this.find('.delete_row').attr('disabled','disabled');
                                        }else if(_this.attr("data-type") == 'deptselect'){
                                            _this.attr('style','cursor: not-allowed !important;background: #eee url(/img/workflow/form/group_select.png) no-repeat right !important;'+_this.attr('style'))
                                        }else if(_this.attr("data-type") == 'userselect'){
                                            _this.attr('style','cursor: not-allowed !important;background: #eee url(/img/workflow/form/user_select.png) no-repeat right !important;'+_this.attr('style'))
                                        }
                                        _this.attr("disabled","disabled");
                                    }else{
                                        if(_this.attr("data-type") == 'macros'){
                                            if(_this.is('input')){
                                                _this.attr("disabled","disabled");
                                            }
                                        }
                                        // else if(_this.attr("data-type") == 'fileupload'){
                                        //     _this.before('<span class="'+_this.attr("id")+'event_th_nothing">无</span>');
                                        //     _this.hide();
                                        // }else if(_this.attr("data-type") == 'imgupload'){
                                        //     _this.before('<span class="'+_this.attr("id")+'event_th_nothing"> 无 </span>');
                                        //     _this.hide();
                                        // }
                                        // if(steptOpt.requiredItem.indexOf(_this.attr("title")) != -1){

                                        if(checkStrIn(steptOpt.requiredItem,_this.attr("title") )){
                                            _this.attr('ismust',true);
                                        }
                                    };
                                    //权限控制结束
                                    if(checkStrIn(steptOpt.hiddenItem,_this.attr("title"))){
                                        _hidden = true;
                                        _this.attr('hidden',true);
                                        _this.before("*****").attr('secret',1);
                                        _this.hide();
                                        if(_this.next().hasClass('refresh')){
                                            _this.next().hide();
                                        }
                                        if(_this.prev().find('#eiderarea').length != 0){
                                            _this.prev().hide();
                                        }
                                    }
                                    //表单填充数据
                                    var dataNameVal = dataName[_this.attr('name')] ||'';
                                    if(that.option.preView){

                                        var width = _this.css('width')
                                        switch (_this.attr('data-type')){
                                            case 'text':
                                                if(!_hidden){
                                                    _this.before('<span class="preview" style="'+ _this.attr('style') +';height:auto;display: inline-block">'+dataNameVal+'</span>');
                                                }
                                                _this.attr('value',dataNameVal);
                                                _this.hide();
                                                break;
                                            case 'markformItem':
                                                if(!_hidden){
                                                    _this.attr('value',dataNameVal);
                                                }else{
                                                    _this.attr('value','hideen');
                                                }
                                                break;
                                            case 'textarea':
                                                if(!_this.hasClass('special_form_item')){
                                                    var width = _this.css('width');
                                                    var height = _this.css('height');
                                                    // console.log(dataNameVal.replace(/<(?:.|\s)*?>/g,''))
                                                    if(_this.attr('rich')!=undefined&&_this.attr('rich')==1){
                                                        _this.parent().find('.container').remove();
                                                    }
                                                    if(!_hidden){
                                                        dataNameVal = dataNameVal.replace(/\r\n/g, '<br/>').replace(/\n/g, '<br/>').replace(/\s/g, ' ');
                                                        _this.before('<div class="preview" style="'+ _this.attr('style') +';border: none;box-shadow: none;width:'+width+';height: auto;min-height: '+ height +'!important;" readonly>'+dataNameVal.replace(/\n/g, '<br />')+'</div>');
                                                    }
                                                    if(dataNameVal != "" && dataNameVal != undefined){
                                                        _this.prev().show()
                                                        _this.prev().css('display','inline-block')
                                                        _this.hide()
                                                    }else{
                                                        _this.next().show()
                                                        _this.hide()
                                                    }
                                                    _this.text(dataNameVal);

                                                    _this.css({
                                                        'border': 'none',
                                                        'background': '#fff',
                                                        // 'overflow': 'hidden',
                                                        'box-shadow':'none'
                                                    });
                                                    _this.attr('disabled','disabled')
                                                }
                                                break;
                                            case 'countersignature_item':
                                                if(!_hidden){
                                                    _this.before('<textarea class="preview" style="'+ _this.attr('style') +';border: none;width:'+width+'" readonly>'+dataNameVal.replace(/<(?:.|\s)*?>/g,'')+'</textarea>');
                                                }
                                                _this.text(dataNameVal);
                                                _this.css({
                                                    'border': 'none',
                                                    'background': '#fff',
                                                    'overflow': 'hidden',
                                                    'box-shadow':'none'
                                                });
                                                countersignature_item = true;
                                                break;
                                            case 'select':
                                                _this.find("option[value='"+dataNameVal+"']").attr("selected",true).siblings().attr("selected",false);
                                                _this.find("option[value='"+dataNameVal+"']").prop("selected",true).siblings().prop("selected",false);
                                                if(!_hidden){
                                                    var selectVal =  _this.find("option[value='"+dataNameVal+"']").text();
                                                    /***************处理当前下拉框是child下拉框控件开始*********************/
                                                    if(selectVal.indexOf('|') > -1){
                                                        selectVal = selectVal.split('|')[0]
                                                    }
                                                    /***************处理child下拉框控件结束*********************/
                                                    _this.before('<span class="preview" style="'+ _this.attr('style') +';">'+ selectVal +'</span>');                                                }
                                                _this.hide();
                                                break;
                                            case 'radio':
                                                if( _this.attr('secret') != 1){
                                                    that.option.eleObject.find(":radio[name='"+_this.attr('name')+"'][value='" + dataNameVal + "']").prop("checked", "checked");
                                                    that.option.eleObject.find(":radio[name='"+_this.attr('name')+"'][value='" + dataNameVal + "']").attr("checked", "checked");
                                                    that.option.eleObject.find(":radio[name='"+_this.attr('name')+"'][value='" + dataNameVal + "']").siblings(":radio[name='"+_this.attr('name')+"']").removeAttr('checked');
                                                    that.option.eleObject.find(":radio[name='"+_this.attr('name')+"']").attr('disabled',"disabled")

                                                }else{
                                                    if(_this.next().hasClass('radioBox')){
                                                        _this.next().remove();
                                                    }
                                                }
                                                // console.log('radio not done');
                                                break;
                                            case 'checkbox':
                                                if(dataNameVal == '1'||dataNameVal=='on'){
                                                    _this.prop("checked",'checked');
                                                }else{
                                                    _this.prop("checked",false);
                                                }
                                                _this.attr("disabled","disabled");
                                                break;
                                            case 'fileupload':
                                                if( _this.attr('secret') == 1) break;
                                                if(dataNameVal && dataNameVal.indexOf('*')>-1){
                                                    _this.show();
                                                    if($.GetRequest().flowStep != ''&&$.GetRequest().prcsId != ''){
                                                        var strify = that.option.flowProcesses.fileuploadPriv||'';
                                                        var download = 'display: none;';
                                                        var preview = 'display: none;';
                                                        try {
                                                            if(strify != '' && strify != undefined && JSON.parse(strify).length > 0){
                                                                var flag = false;
                                                                for(var i=0;i<JSON.parse(strify).length;i++){
                                                                    if(JSON.parse(strify)[i]['FILE_PRIV_'+_this.attr('id')] != undefined){
                                                                        var checkThis = JSON.parse(strify)[i]['FILE_PRIV_'+_this.attr('id')];
                                                                        if(checkThis.indexOf('4') != -1){
                                                                            flag = true;
                                                                            download = 'display: block;'
                                                                        }
                                                                        if(checkThis.indexOf('1') != -1){
                                                                            flag = true;
                                                                            preview = 'display: block;'
                                                                        }
                                                                        break;
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        catch(err) {

                                                        }
                                                    }else{
                                                        var download = 'display: block;';
                                                        var preview = 'display: block;';
                                                        var flag = true;
                                                    }
                                                    dataNameVal.split('*').forEach(function (v,i) {
                                                        if(v&&v.indexOf('&ATTACHMENT_NAME=')>-1){
                                                            v = v.replace(/\%2c/g, ",");
                                                            var fileConfigArr = v.split('&');
                                                            // 增加集体处理附件上传控件已上传附件数据回显时候的url处理
                                                            var FileArr = getFileArrType(fileConfigArr).split('*');
                                                            var nameTitle = FileArr[0] + '.' + FileArr[1];
                                                            var FileArrType = FileArr[1];
                                                            var fileuploadSRC = that.tool.iconImgType[FileArrType]||"/img/icon_file.png";
                                                            FileArrType = FileArrType.toLowerCase();
                                                            if(getFileIsOffice(FileArrType)){
                                                                var imgObj = '<div class="imgfileBox" style="position:  relative;"><img atturl="'+ v +'" name="'+_this.attr('name')+'" src="'+fileuploadSRC+'" style="cursor: pointer;margin: 0 5px;'+_this.attr('style')+'"  id="'+_this.attr('name')+'" align="absmiddle" style=""  class="fileupload_data"    width="'+_this.attr('width')+'" height="'+_this.attr('height')+'"/><span class="uploadImg" style="width:'+_this.attr('width')+'px;text-align: center;">'+ nameTitle +'</span><ul class="hoverbox" flag="'+ flag +'"><li class="hoverboxLiDownload" style="'+ download +'"><span class="plotting">></span>下载</li><li class="hoverboxLiPreview0" style="'+ preview +'"><span class="plotting">></span>预览</li><li class="hoverboxLiPreview" style="'+ preview +'"><span class="plotting">></span>查阅</li></ul></div>';
                                                            }else if( getFileIsPDForTXT(FileArrType) || getFileIsPic(FileArrType) ){
                                                                var imgObj = '<div class="imgfileBox" style="position:  relative;"><img atturl="'+ v +'" name="'+_this.attr('name')+'" src="'+fileuploadSRC+'" style="cursor: pointer;margin: 0 5px;'+_this.attr('style')+'"  id="'+_this.attr('name')+'" align="absmiddle" style=""  class="fileupload_data"    width="'+_this.attr('width')+'" height="'+_this.attr('height')+'"/><span class="uploadImg" style="width:'+_this.attr('width')+'px;text-align: center;">'+ nameTitle +'</span><ul class="hoverbox" flag="'+ flag +'"><li class="hoverboxLiDownload" style="'+ download +'"><span class="plotting">></span>下载</li><li class="hoverboxLiPreview0" style="'+ preview +'"><span class="plotting">></span>预览</li></ul></div>';
                                                            }else{
                                                                var imgObj = '<div class="imgfileBox" style="position:  relative;"><img atturl="'+ v +'" name="'+_this.attr('name')+'" src="'+fileuploadSRC+'" style="cursor: pointer;margin: 0 5px;'+_this.attr('style')+'"  id="'+_this.attr('name')+'" align="absmiddle" style=""  class="fileupload_data"    width="'+_this.attr('width')+'" height="'+_this.attr('height')+'"/><span class="uploadImg" style="width:'+_this.attr('width')+'px;text-align: center;">'+ nameTitle +'</span><ul class="hoverbox" flag="'+ flag +'"><li class="hoverboxLiDownload" style="'+ download +'"><span class="plotting">></span>下载</li></div>';
                                                            }
                                                            _this.before(imgObj);
                                                        }
                                                    });
                                                    _this.hide();
                                                }
                                                break;
                                            case 'imgupload':
                                                if( _this.attr('secret') == 1) break;
                                                if(dataNameVal != '' && dataNameVal.indexOf('*')>-1){
                                                    _this.show();
                                                    if($.GetRequest().flowStep != ''&&$.GetRequest().prcsId != ''){
                                                        var strify = that.option.flowProcesses.imguploadPriv||'';
                                                        var download = 'display: none;';
                                                        var preview = 'display: none;';
                                                        try {
                                                            if(strify != '' && strify != undefined && JSON.parse(strify).length > 0){
                                                                var flag = false;
                                                                for(var i=0;i<JSON.parse(strify).length;i++){
                                                                    if(JSON.parse(strify)[i]['IMG_PRIV_'+_this.attr('id')] != undefined){
                                                                        var checkThis = JSON.parse(strify)[i]['IMG_PRIV_'+_this.attr('id')];
                                                                        if(checkThis.indexOf('3') != -1){
                                                                            flag = true;
                                                                            download = 'display: block;'
                                                                        }
                                                                        if(checkThis.indexOf('1') != -1){
                                                                            flag = true;
                                                                            preview = 'display: block;'
                                                                        }
                                                                        break;
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        catch(err) {

                                                        }
                                                    }else{
                                                        var download = 'display: block;';
                                                        var preview = 'display: block;';
                                                        var flag = true;
                                                    }
                                                    // _this.prev('span').hide();
                                                    dataNameVal.split('*').forEach(function (v,i) {
                                                        if(v&&v.indexOf('&ATTACHMENT_NAME=')>-1){
                                                            v = v.replace(/\%2c/g, ",");
                                                            var thisspan = v.split('&ATTACHMENT_NAME=')[1].split('&')[0];
                                                            var str = v;
                                                            var strs = str.split('&ATTACHMENT_NAME=')[0];
                                                            var name = str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[0];
                                                            var attName = encodeURI(name).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                                            var atturl =strs+"&ATTACHMENT_NAME="+attName+"&FILESIZE="+str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[1];
                                                            var imgObj = '<div class="imgfileBox" style="display:  inline-block;position:  relative;"><img name="'+_this.attr('name')+'" src="'+encodeURI(atturl)+'" style="cursor: pointer;'+_this.attr('style')+'"  id="'+_this.attr('name')+'" title="'+v.split('&ATTACHMENT_NAME=')[1].split('&')[0]+'" align="absmiddle" style=""  class="imgupload_data"    width="'+_this.attr('width')+'" height="'+_this.attr('height')+'"/><span class="uploadImg" title="'+ v.split('&ATTACHMENT_NAME=')[1].split('&')[0] +'" style="width:'+_this.attr('width')+'px;text-align: center;">'+ thisspan +'</span><ul class="hoverbox" flag="'+ flag +'"><li class="hoverboxLiDownload" style="'+ download +'"><span class="plotting">></span>下载</li><li class="hoverboxLiPreview0" style="'+ preview +'"><span class="plotting">></span>预览</li></ul></div>';
                                                            _this.before(imgObj);
                                                        }
                                                    })
                                                    _this.hide();
                                                }
                                                break;
                                            case 'macros':
                                                if(dataNameVal == '{macros}'){
                                                    dataNameVal=''
                                                }else{
                                                    dataNameVal = dataNameVal;
                                                }
                                                if(_this.attr('type') == 'text'){
                                                    if(!_hidden){
                                                        if(_this.attr('datafld')=='SYS_USERNAME'&&_this.attr('orgsignImg')==1){
                                                            if(dataNameVal&&dataNameVal.indexOf('AID')>=0){
                                                                _this.before('<span class="signSpan">'+function(){
                                                                    if(dataNameVal&&dataNameVal.indexOf('AID')>=0){
                                                                        return '<img style="width:100px;" src="/xs?'+dataNameVal+'" alt="">'
                                                                    }else{
                                                                        return ''
                                                                    }
                                                                }()+'</span>');
                                                                _this.attr('signSrc',dataNameVal)
                                                                _this.hide();
                                                                if(_this.next().hasClass('refresh')){
                                                                    _this.next().hide();
                                                                }
                                                            }else{
                                                                _this.before('<span class="preview" style="' + _this.attr('style') + ';display: inline-block;">' + dataNameVal + '</span>');
                                                            }

                                                        }else {
                                                            if(dataNameVal&&dataNameVal.indexOf('AID')>=0){
                                                                _this.before('<span class="signSpan">'+function(){
                                                                    if(dataNameVal&&dataNameVal.indexOf('AID')>=0){
                                                                        return '<img style="width:100px;" src="/xs?'+dataNameVal+'" alt="">'
                                                                    }else{
                                                                        return ''
                                                                    }
                                                                }()+'</span>');
                                                                _this.attr('signSrc',dataNameVal)
                                                                _this.hide();
                                                                if(_this.next().hasClass('refresh')){
                                                                    _this.next().hide();
                                                                }
                                                            }else{
                                                                _this.before('<span class="preview" style="' + _this.attr('style') + ';display: inline-block;">' + dataNameVal + '</span>');
                                                            }
                                                        }
                                                    }
                                                    _this.attr('value',dataNameVal);
                                                    _this.hide();
                                                }else{
                                                    _this.attr('pval',dataNameVal);
                                                    _this.val(dataNameVal);
                                                    _this.before('<span class="preview" style="'+ _this.attr('style') +';display: inline-block">'+ dataNameVal+'</span>');
                                                    _this.hide();
                                                }
                                                if(_this.attr('secret') == 1) {
                                                    _this.next().hide();
                                                }
                                                break;
                                            case 'calendar':
                                                if(!_hidden){
                                                    _this.before('<span class="preview" style="'+ _this.attr('style') +';display: inline-block">'+dataNameVal+'</span>');
                                                }

                                                _this.attr('value',dataNameVal);
                                                _this.hide();
                                                break;
                                            case 'kgsign':
                                                _this.find('img').remove();
                                                break;
                                            case 'macrossign':
                                                if(!_hidden){
                                                    _this.before('<span class="preview" style="'+ _this.attr('style') +';display: inline-block">'+dataNameVal+'</span>');
                                                }
                                                _this.remove();
                                                break;
                                            case 'sign':
                                                _this.prev().hide();
                                                // var prevtext = dataNameVal+prev.html();
                                                var height = _this.css('height');
                                                if(!_hidden){
                                                    _this.before('<span class="preview" style="'+ _this.attr('style') +';display: inline-block;height: auto;min-height: '+ height +';">'+dataNameVal+'</span>');
                                                }
                                                _this.prev().attr('templ',prevtext);
                                                _this.hide();
                                                _this.siblings('img').remove();

                                                //prev.html(dataNameVal);
                                                break;
                                            case 'autocode':
                                                if(_this.attr('secret') != 1) {
                                                    _this.before(dataNameVal);
                                                    _this.siblings('.autocodebtn').hide();
                                                    _this.attr('value',dataNameVal);
                                                    _this.hide();
                                                }
                                                break;
                                            case 'listing':
                                                var vlist = dataNameVal;
                                                if(vlist !=""){
                                                    that.tool.buildListPluData(_this,vlist,that);
                                                }
                                                // that.tool.buildListPluData(_this,vlist,that);
                                                _this.find('.listfoot').remove();
                                                break;
                                            case 'readcomments':
                                                _this.html(dataNameVal);
                                                break;
                                            case 'userselect':
                                                var valuearr = dataNameVal.split('|');
                                                var title = valuearr[0];
                                                var value = valuearr[1];
                                                if(value == undefined){
                                                    value = '';
                                                }
                                                var display = 'display: inline-block;'
                                                if(_this.attr('display')){
                                                    display = 'display: none;'
                                                }
                                                _this.before('<div name="'+_this.attr('name')+'" id="'+_this.attr('id')+'" user_id="'+title+'" value="'+value+'" class="form_item " data-type="userselect" title="'+_this.attr('title')+'"  orgfontsize="'+_this.attr('orgfontsize')+'" orgwidth="'+_this.attr('orgwidth')+'" orgheight="'+_this.attr('orgheight')+'" style="width: '+ _this.css('width') +';background: none!important;height: auto;min-height: 40px;min-height: '+ _this.attr('orgheight') +'px;'+ display +'">'+value+'</div>');
                                                _this.remove();
                                                break;
                                            case 'deptselect':
                                                var valuearr = dataNameVal.split('|');
                                                var title = valuearr[0];
                                                var value = valuearr[1];
                                                if(value == undefined){
                                                    value = '';
                                                }
                                                var display = 'display: inline-block;'
                                                if(_this.attr('display')){
                                                    display = 'display: none;'
                                                }
                                                _this.before('<div name="'+_this.attr('name')+'" id="'+_this.attr('id')+'" user_id="'+title+'" value="'+value+'" class="form_item " data-type="deptselect" title="'+_this.attr('title')+'"  orgfontsize="'+_this.attr('orgfontsize')+'" orgwidth="'+_this.attr('orgwidth')+'" orgheight="'+_this.attr('orgheight')+'" style="width: '+ _this.css('width') +';background: none!important;height: auto;min-height: 40px;min-height: '+ _this.attr('orgheight') +'px;'+ display +'">'+value+'</div>');
                                                _this.remove();
                                                break;
                                            case 'writesign':

                                                //移动端手写
                                                if(_this.attr('data-type') == 'writesign'){

                                                    var id = _this.attr('name');
                                                    if(id){
                                                        var str1 = '',str2 = '';
                                                        var isNone=''
                                                        if(_this.attr("disabled") == "disabled") {
                                                            var str = 'display: none;';
                                                            isNone = '1';
                                                        }
                                                        if(_this.attr('isMust')){
                                                            var must = "isMust='true'";
                                                        }else{
                                                            var must = "";
                                                        }
                                                        // console.log(( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ))
                                                        //手机端
                                                        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )||/(Android)/i.test(navigator.userAgent)) {
                                                            if(dataNameVal!=''){
                                                                var imgSrc=dataNameVal.split('|');
                                                                var cImg = '<img style="max-width: 500px;width:90%;height:auto;vertical-align: middle" update="0" class="writeSignImg'+id+'" data-img2blob="'+imgSrc[0]+'" onclick="showImg(this)" src="'+imgSrc[0]+'"/>'
                                                                if(!matchString($('#module').val(),'10')){
                                                                    $(cImg).img2blob({
                                                                        watermark: '试用',
                                                                        fontStyle: '楷体',
                                                                        fontSize: '100', // px
                                                                        fontColor: 'red', // default 'black'
                                                                        fontX: 70, // The x coordinate where to start painting the text
                                                                        fontY: 200
                                                                    });
                                                                }
                                                                _this.before('<span class="mobileSign" id="WRITE_SIGN_'+ id +'" >'+cImg+'\
                                                                <input type="hidden" name="'+ id +'" value="'+dataNameVal+'" id="'+ id +'" class="form_item" data-type="writeSign" title="'+ _this.attr('title') +'" "'+ must +'">\
                                                                </span>');
                                                            }else{
                                                                _this.before('<span class="mobileSign" id="WRITE_SIGN_'+ id +'" >' +
                                                                    ' <input type="hidden" name="'+ id +'" value="'+dataNameVal+'" id="'+ id +'" class="form_item" data-type="writeSign" title="'+ _this.attr('title') +'" "'+ must +'">\
                                                                     </span>');
                                                            }


                                                        }else{ //电脑端

                                                            if(dataNameVal!=''){
                                                                var imgSrc=dataNameVal.split('|');
                                                                var cImg = '<img style="max-width: 500px;width:90%;height:auto;vertical-align: middle" onclick="showImgPic(this)" class="writeSignImg'+id+'" data-img2blob="'+imgSrc[0]+'" src="'+imgSrc[0]+'"/>'
                                                                if(!matchString($('#module').val(),'10')){
                                                                    $(cImg).img2blob({
                                                                        watermark: '试用',
                                                                        fontStyle: '楷体',
                                                                        fontSize: '100', // px
                                                                        fontColor: 'red', // default 'black'
                                                                        fontX: 70, // The x coordinate where to start painting the text
                                                                        fontY: 200
                                                                    });
                                                                }
                                                                _this.before('<span class="mobileSign" id="WRITE_SIGN_'+ id +'" >'+cImg+'\
                                                                <input type="hidden" name="'+ id +'" value="'+dataNameVal+'" id="'+ id +'" class="form_item" data-type="writeSign" title="'+ _this.attr('title') +'" "'+ must +'">\
                                                                </span>');
                                                            }else{
                                                                _this.before('<span class="mobileSign" id="WRITE_SIGN_'+ id +'" >\
                                                                <input type="hidden" name="'+ id +'" value="'+dataNameVal+'" id="'+ id +'" class="form_item" data-type="writeSign" title="'+ _this.attr('title') +'" "'+ must +'">\
                                                                </span>');
                                                            }
                                                        }

                                                        _this.remove();
                                                    }
                                                }
                                                break;
                                            default:
                                            // console.log(i);
                                        }
                                    }else{

                                        if(opflag == 0){
                                            if(!_this.hasClass('countersignature_item')){
                                                _this.attr('disabled','disabled');
                                            }
                                        }

                                        if(dataNameVal == '' && steptOpt.prcsItem.indexOf(_this.attr("title")) > -1){

                                        }else{
                                            switch (_this.attr('data-type')){
                                                case 'text':
                                                    _this.attr('value',dataNameVal);
                                                    break;
                                                case 'markformItem':
                                                    _this.attr('value',dataNameVal);
                                                    break;
                                                case 'textarea':
                                                    _this.text(dataNameVal.replace(/<(?:.|\s)*?>/g,''));
                                                    break;
                                                case 'countersignature_item':
                                                    countersignature_item = true;
                                                    _this.text(dataNameVal.replace(/<(?:.|\s)*?>/g,''));
                                                    break;
                                                case 'select':
                                                    _this.find("option[value='"+dataNameVal+"']").prop("selected","selected").attr("selected","selected").siblings().removeAttr("selected");
                                                    break;
                                                case 'radio':
                                                    if( _this.attr('secret') != 1){
                                                        that.option.eleObject.find(":radio[name='"+_this.attr('name')+"'][value='" + dataNameVal + "']").prop("checked", "checked");
                                                        that.option.eleObject.find(":radio[name='"+_this.attr('name')+"'][value='" + dataNameVal + "']").attr("checked", "checked");
                                                        that.option.eleObject.find(":radio[name='"+_this.attr('name')+"'][value='" + dataNameVal + "']").siblings(":radio[name='"+_this.attr('name')+"']").removeAttr('checked');

                                                    }else{
                                                        if(_this.next().hasClass('radioBox')){
                                                            _this.next().remove();
                                                        }
                                                    }
                                                    break;
                                                case 'checkbox':
                                                    if(dataNameVal == '1'||dataNameVal=='on'){
                                                        _this.prop("checked",'checked');
                                                    }else{
                                                        _this.prop("checked",false);
                                                    }
                                                    break;
                                                case 'fileupload':
                                                    if( _this.attr('secret') == 1) break;
                                                    if(dataNameVal && dataNameVal.indexOf('*')>-1){
                                                        _this.show();
                                                        // _this.prev('span').hide();
                                                        var strify = that.option.flowProcesses.fileuploadPriv||'';
                                                        var download = 'display: none;';
                                                        var preview = 'display: none;';
                                                        var edit = 'display: none;';
                                                        var deletet = 'display: none;';
                                                        try {
                                                            if(strify != '' && strify != undefined && JSON.parse(strify).length > 0){
                                                                var flag = false;
                                                                for(var i=0;i<JSON.parse(strify).length;i++){
                                                                    if(JSON.parse(strify)[i]['FILE_PRIV_'+_this.attr('id')] != undefined){
                                                                        var checkThis = JSON.parse(strify)[i]['FILE_PRIV_'+_this.attr('id')];
                                                                        if(checkThis.indexOf('4') != -1){
                                                                            flag = true;
                                                                            download = 'display: block;'
                                                                        }
                                                                        if(checkThis.indexOf('1') != -1){
                                                                            flag = true;
                                                                            preview = 'display: block;'
                                                                        }
                                                                        if(checkThis.indexOf('2') != -1){
                                                                            flag = true;
                                                                            edit = 'display: block;'
                                                                        }
                                                                        if(checkThis.indexOf('3') != -1){
                                                                            flag = true;
                                                                            deletet = 'display: block;'
                                                                        }
                                                                        break;
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        catch(err) {

                                                        }
                                                        dataNameVal.split('*').forEach(function (v,i) {
                                                            if(v&&v.indexOf('&ATTACHMENT_NAME=')>-1){
                                                                v = v.replace(/\%2c/g, ",");
                                                                var fileConfigArr = v.split('&');
                                                                // 增加集体处理附件上传控件已上传附件数据回显时候的url处理
                                                                var FileArr = getFileArrType(fileConfigArr).split('*');
                                                                var nameTitle = FileArr[0] + '.' + FileArr[1];
                                                                var FileArrType = FileArr[1];
                                                                var fileuploadSRC = that.tool.iconImgType[FileArrType]||"/img/icon_file.png";
                                                                var attrnametype = FileArrType;
                                                                attrnametype = attrnametype.toLowerCase();
                                                                if(getFileIsOffice(attrnametype)){
                                                                    var imgObj = '<div class="imgfileBox" style="position:  relative;"><img atturl="'+ v +'" name="'+_this.attr('name')+'" src="'+fileuploadSRC+'" style="cursor: pointer;margin: 0 5px;'+_this.attr('style')+'"  id="'+_this.attr('name')+'" style=""  class="fileupload_data"    width="'+_this.attr('width')+'" height="'+_this.attr('height')+'"/><span class="uploadImg" style="width:'+_this.attr('width')+'px;text-align: center;">'+ nameTitle +'</span><ul class="hoverbox" flag="'+ flag +'"><li class="hoverboxLiDownload" style="'+ download +'"><span class="plotting">></span>下载</li><li class="hoverboxLiPreview0" style="'+ preview +'"><span class="plotting">></span>预览</li><li class="hoverboxLiPreview" style="'+ preview +'"><span class="plotting">></span>查阅</li><li class="hoverboxLiEdit" style="'+ edit +'"><span class="plotting">&gt;</span>编辑</li><li class="hoverboxLidelete" style="'+ deletet +'"><span class="plotting">></span>删除</li></ul></div>';
                                                                }else if(getFileIsPDForTXT(attrnametype) || getFileIsPic(attrnametype)){
                                                                    var imgObj = '<div class="imgfileBox" style="position:  relative;"><img atturl="'+ v +'" name="'+_this.attr('name')+'" src="'+fileuploadSRC+'" style="cursor: pointer;margin: 0 5px;'+_this.attr('style')+'"  id="'+_this.attr('name')+'" style=""  class="fileupload_data"    width="'+_this.attr('width')+'" height="'+_this.attr('height')+'"/><span class="uploadImg" style="width:'+_this.attr('width')+'px;text-align: center;">'+ nameTitle +'</span><ul class="hoverbox" flag="'+ flag +'"><li class="hoverboxLiDownload" style="'+ download +'"><span class="plotting">></span>下载</li><li class="hoverboxLiPreview0" style="'+ preview +'"><span class="plotting">></span>预览</li><li class="hoverboxLidelete" style="'+ deletet +'"><span class="plotting">></span>删除</li></ul></div>';
                                                                }else{
                                                                    var imgObj = '<div class="imgfileBox" style="position:  relative;"><img atturl="'+ v +'" name="'+_this.attr('name')+'" src="'+fileuploadSRC+'" style="cursor: pointer;margin: 0 5px;'+_this.attr('style')+'"  id="'+_this.attr('name')+'" style=""  class="fileupload_data"    width="'+_this.attr('width')+'" height="'+_this.attr('height')+'"/><span class="uploadImg" style="width:'+_this.attr('width')+'px;text-align: center;">'+ nameTitle +'</span><ul class="hoverbox" flag="'+ flag +'"><li class="hoverboxLiDownload" style="'+ download +'"><span class="plotting">></span>下载</li><li class="hoverboxLidelete" style="'+ deletet +'"><span class="plotting">></span>删除</li></ul></div>';
                                                                }
                                                                _this.before(imgObj);
                                                            }
                                                        });
                                                        if(_this.attr("disabled") == "disabled") {
                                                            _this.hide();
                                                        }
                                                    }
                                                    break;
                                                case 'imgupload':
                                                    if( _this.attr('secret') == 1) break;
                                                    if(dataNameVal != '' && dataNameVal.indexOf('*')>-1){
                                                        var strify = that.option.flowProcesses.imguploadPriv||'';
                                                        var download = 'display: none;';
                                                        var preview = 'display: none;';
                                                        var deletet = 'display: none;';
                                                        try {
                                                            if(strify != '' && strify != undefined && JSON.parse(strify).length > 0){
                                                                var flag = false;
                                                                for(var i=0;i<JSON.parse(strify).length;i++){
                                                                    if(JSON.parse(strify)[i]['IMG_PRIV_'+_this.attr('id')] != undefined){
                                                                        var checkThis = JSON.parse(strify)[i]['IMG_PRIV_'+_this.attr('id')];
                                                                        if(checkThis.indexOf('3') != -1){
                                                                            flag = true;
                                                                            download = 'display: block;'
                                                                        }
                                                                        if(checkThis.indexOf('1') != -1){
                                                                            flag = true;
                                                                            preview = 'display: block;'
                                                                        }
                                                                        if(checkThis.indexOf('2') != -1){
                                                                            flag = true;
                                                                            deletet = 'display: block;'
                                                                        }
                                                                        break;
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        catch(err) {

                                                        }
                                                        _this.show();
                                                        // _this.prev('span').hide();
                                                        dataNameVal.split('*').forEach(function (v,i) {
                                                            if(v&&v.indexOf('&ATTACHMENT_NAME=')>-1){
                                                                v = v.replace(/\%2c/g, ",");
                                                                var thisspan = v.split('&ATTACHMENT_NAME=')[1].split('&')[0];
                                                                var str = v;
                                                                var strs = str.split('&ATTACHMENT_NAME=')[0];
                                                                var name = str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[0];
                                                                var attName = encodeURI(name).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                                                var atturl =strs+"&ATTACHMENT_NAME="+attName+"&FILESIZE="+str.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[1];

                                                                var imgObj = '<div class="imgfileBox" style="display:  inline-block;position:  relative;"><img name="'+_this.attr('name')+'" src="'+encodeURI(atturl)+'" style="cursor: pointer;'+_this.attr('style')+'"  id="'+_this.attr('name')+'" title="'+v.split('&ATTACHMENT_NAME=')[1].split('&')[0]+'" align="absmiddle" style=""  class="imgupload_data"    width="'+_this.attr('width')+'" height="'+_this.attr('height')+'"/><span class="uploadImg" title="'+ v.split('&ATTACHMENT_NAME=')[1].split('&')[0] +'" style="width:'+_this.attr('width')+'px;text-align: center;">'+ thisspan +'</span><ul class="hoverbox" flag="'+ flag +'"><li class="hoverboxLiDownload" style="'+ download +'"><span class="plotting">></span>下载</li><li class="hoverboxLiPreview0"  style="'+ preview +'"><span class="plotting">></span>预览</li><li class="hoverboxLidelete"  style="'+ deletet +'"><span class="plotting">></span>删除</li></ul></div>';
                                                                _this.before(imgObj);
                                                            }
                                                        });
                                                        if(_this.attr("disabled") == "disabled") {
                                                            _this.hide();
                                                        }
                                                    }
                                                    break;
                                                case 'macros':
                                                    if(_this.attr('type') == 'text'){
                                                        if(_this.attr('datafld')=='SYS_USERNAME'&&_this.attr('orgsignImg')==1){
                                                            if(_this.prev('span').find('img').length>0){
                                                                _this.prev('span').remove()
                                                            }
                                                            if(dataNameVal&&dataNameVal.indexOf('AID')>=0){
                                                                _this.before('<span class="signSpan">'+function(){
                                                                    if(dataNameVal&&dataNameVal.indexOf('AID')>=0){
                                                                        return '<img style="width:100px;" src="/xs?'+dataNameVal+'" alt="">'
                                                                    }else{
                                                                        return ''
                                                                    }
                                                                }()+'</span>');
                                                                _this.attr('signSrc',dataNameVal)
                                                                _this.hide();
                                                                if(_this.next().hasClass('refresh')){
                                                                    _this.next().hide();
                                                                }
                                                            }else{
                                                                _this.attr('value', dataNameVal);
                                                            }

                                                        }else {
                                                            _this.attr('value', dataNameVal);
                                                        }
                                                    }else{
                                                        _this.attr('pval',dataNameVal);
                                                        if(dataNameVal && dataNameVal.indexOf('_')>-1){
                                                            _this.val(dataNameVal.split('_')[0]);
                                                        }else{
                                                            _this.find("option[value='"+dataNameVal+"']").prop("selected","selected").attr("selected","selected").siblings().removeAttr("selected");

                                                        }

                                                    }
                                                    if(_this.attr('secret') == 1) {
                                                        _this.next().hide();
                                                    }
                                                    break;
                                                case 'calendar':
                                                    _this.attr('value',dataNameVal);
                                                    break;
                                                case 'kgsign':
                                                    _this.attr('value',dataNameVal);
                                                    _this.find('img').remove();
                                                    break;
                                                case 'macrossign':
                                                    // _this.before(dataNameVal);
                                                    // _this.remove();
                                                    //console.log(1);
                                                    break;
                                                case 'sign':
                                                    var prev = _this.prev();
                                                    var prevtext = dataNameVal+prev.html();
                                                    prev.attr('templ',prevtext);
                                                    prev.html(prevtext);
                                                    break;
                                                case 'userselect':
                                                    var valuearr = dataNameVal.split('|');
                                                    if(dataNameVal.indexOf('|')>-1){

                                                        _this.attr('user_id',valuearr[0]);
                                                        _this.attr('username',valuearr[1]);
                                                        _this.attr('value',valuearr[1]);
                                                    }else{
                                                        _this.attr('username',valuearr);
                                                        _this.attr('value',valuearr);

                                                    }

                                                    break;
                                                case 'deptselect':
                                                    var valuearr = dataNameVal.split('|');
                                                    _this.attr('deptid',valuearr[0]);
                                                    _this.attr('deptname',valuearr[1]);
                                                    _this.attr('value',valuearr[1]);
                                                    break;
                                                case 'autocode':
                                                    if(_this.attr('secret') == 1){
                                                        _this.next('').hide();
                                                    }
                                                    _this.attr('value',dataNameVal);
                                                    break;
                                                case 'listing':
                                                    var vlist = dataNameVal;
                                                    if(vlist !=""){
                                                        that.tool.buildListPluData(_this,vlist,that);
                                                    }
                                                    // that.tool.buildListPluData(_this,vlist,that);
                                                    break;
                                                case 'readcomments':
                                                    _this.html(dataNameVal);
                                                    break;
                                                default:
                                            }
                                        }
                                    }
                                });
                                // if(typeof  Signature != 'undefined'){
                                //     var signatureCreator = Signature.create();
                                //     signatureCreator.getSaveSignatures(that.option.flowRun.runId, function(signs){
                                //         var signdata = new Array();
                                //         var jsonList = eval("("+signs+")");
                                //         for(var i=0;i<jsonList.length;i++){
                                //             var map = {};
                                //             map.signatureid = jsonList[i]["signatureId"];
                                //             map.signatureData = jsonList[i]["signature"];
                                //             signdata.push(map);
                                //         }
                                //         Signature.loadSignatures(signdata);
                                //     });
                                // }
                            });
                        }
                    }
                }
                eval(function(p,a,c,k,e,d){e=function(c){return(c<a?"":e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1;};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p;}('0(1);',2,2,'readynum|that'.split('|'),0,{}))

            });
        }
    },
    RadioRender:function(){
        this.option.eleObject.find('input[data-type="radio"]').each(function(){
            var _this = $(this);
            var name = _this.attr('name');
            var title = _this.attr('title');
            var radio_field = (_this.attr("radio_field") || '').split('`');
            var checked = _this.attr('orgchecked');
            var eleStr = "";
            radio_field.forEach(function(v,i){
                if(v){
                    if(v == checked){
                        eleStr+='<input name="'+name+'" data-type="radio" title="'+title+'" checked="checked" value="'+v+'" type="radio" class="form_item"/><span class="radioBox">'+v+'</span>';
                    }else{
                        eleStr+='<input name="'+name+'" data-type="radio" title="'+title+'"  value="'+v+'" type="radio" class="form_item"/><span class="radioBox">'+v+'</span>';
                    }

                }
            });
            _this.before(eleStr);
            _this.remove();

        });

    },
    ReBuild:function(ele){
        // 重新加载通达老数据
        var that = this;
        var target = {};
        if(ele){
            target = ele;
        }else{
            target = this.option.eleObject;
        }
        target.find('link').each(function () {
            var href = $(this).attr('href');
            // if(href.indexOf('/theme/') > -1){
            //     var link = domain+'/old'+href.substring(22);
            //     $(this).attr('href',domain+'/form'+href.substring(22));
            // }
        });

        target.find("input").each(function(){
            var _this = $(this);
            var cssLink = '';
            if(_this.prop('hidden')){
                _this.attr("orghidden",_this.get(0).getAttribute('hidden'));
                _this.removeAttr("hidden");
            }
            if(_this.attr("class") &&  _this.attr("class").indexOf('AUTO') > -1){
                _this.attr("data-type","macros");
                // console.log(_this.attr('datafld'))
                // _this.after('<button class="refresh" data-type="macros" datafld="'+_this.attr('datafld')+'">刷新</button>')
            }else if(_this.attr("class") &&  _this.attr("class").indexOf('list') > -1){
                _this.attr("data-type","listing");
                _this.addClass('listing');
                var lv_field = _this.attr("lv_field");
                var zhTest =  new RegExp("[\\u4E00-\\u9FFF]+","g");
                if(zhTest.test(lv_field)){
                    var lv_title =  _this.attr("lv_title");
                    _this.attr("lv_title",lv_field);
                    _this.attr("lv_field",lv_title);
                }
            } else if(_this.attr('data-type') == 'calendar'){
                _this.addClass("laydate-icon");
            }else if(_this.attr('data-type') == 'macrossign'){
                _this.addClass("macrossign");
            }else if(_this.attr('data-type') == 'autocode'){
                _this.addClass("autocode");
                var height = _this.attr('orgheight'),
                    width = _this.attr('orgwidth'),
                    fontSize = _this.attr('orgfontsize');
                _this.css('height', height+'px').css('width', width+'px').css('fontSize', fontSize+'px');
            }else if( _this.attr('classname') == 'CALC'){
                _this.attr("data-type","calculation");
                _this.attr("readonly","readonly");
                _this.attr("id",_this.attr('name'));
                _this.attr("formula",_this.val());
            }else if(_this.attr('data-type') == 'calculation'){
                _this.attr("data-type","calculation");
                _this.addClass("CALC");
            }else{
                if(_this.attr("type")){
                    _this.attr("data-type",$(this).attr("type"));
                }else {
                    _this.attr("data-type",'text');
                }
            }
            _this.addClass("form_item");
            _this.attr("id",$(this).attr("name"));
            var style = _this.attr("style");
            if(style && style.indexOf('width') == -1){
                if(style.indexOf('WIDTH')== -1){
                    _this.attr("style",'width:170px;');
                }
            }
        });
        //list
        target.find("img.LIST_VIEW").each(function () {

            var _this = $(this);
            var datafrom = _this.attr('datatype')=='1'?'inData':'outData';
            var listStr = '<input name="'+_this.attr('name')+'" style="'+_this.attr('style')+'"  id="'+_this.attr('name')+'" title="'+_this.attr('title')+'" type="text" class="form_item listing LIST_VIEW" data-type="listing"  datafrom="'+datafrom+'" lv_field="'+_this.attr('lv_field')+'" lv_title="'+_this.attr('lv_title')+'" lv_size="'+_this.attr('lv_size')+'" lv_colvalue="'+_this.attr('lv_colvalue')+'" lv_sum="'+_this.attr('lv_sum')+'" width="'+_this.attr('width')+'" height="'+_this.attr('height')+'" lv_coltype="'+_this.attr('lv_coltype')+'" lv_cal="'+_this.attr('lv_cal')+'"/>';
            _this.before(listStr);
            _this.remove();
        });
        //图片上传兼容
        target.find("img.IMGUPLOAD").each(function () {

            var _this = $(this);
            var srcStr = _this.attr('src');
            if(srcStr.indexOf('static/images/form/pic.png') > -1){
                srcStr = '/img/icon_uploadimg.png';
            }
            var listStr = '<img name="'+_this.attr('name')+'" src="'+srcStr+'" style="width:'+_this.attr('width')+'px !important;height:'+_this.attr('height')+'px !important;cursor: pointer;'+_this.attr('style')+'"  id="'+_this.attr('name')+'" title="'+_this.attr('title')+'" align="absmiddle"   class="form_item imgupload" data-type="imgupload"   width="'+_this.attr('width')+'" height="'+_this.attr('height')+'"/>';
            _this.before(listStr);
            _this.remove();

            // var _this = $(this);
            // var datafrom = _this.attr('datatype')=='1'?'inData':'outData';
            // var listStr = '<img name="'+_this.attr('name')+'" src="'+_this.attr('src')+'" style="cursor: pointer;'+_this.attr('style')+'"  id="'+_this.attr('name')+'" title="'+_this.attr('title')+'" align="absmiddle"   class="form_item imgupload" data-type="imgupload"   width="'+_this.attr('width')+'" height="'+_this.attr('height')+'"/>';
            // _this.before(listStr);
            // _this.remove();
        });
        //附件上传兼容
        target.find("img.FILEUPLOAD").each(function () {
            var _this = $(this);
            var srcStr = _this.attr('src');
            if(srcStr.indexOf('static/images/form/fileupload.png') > -1){
                srcStr = '/img/fileupload.png';
            }
            if(_this.attr('hidden')){
                _this.attr("orghidden",_this.attr('hidden'));
                _this.removeAttr("hidden");
            }
            var listStr = '<img name="'+_this.attr('name')+'" src="'+srcStr+'" style="cursor: pointer;'+ (_this.attr('style') || '')+'"  id="'+_this.attr('name')+'" title="'+_this.attr('title')+'" align="absmiddle"   class="form_item fileupload" data-type="fileupload"   width="'+(_this.attr('width') || '30')+'" height="'+ (_this.attr('height') || '30') +'"/>';
            _this.before(listStr);
            _this.remove();
        });
        target.find('img.DATE').each(function(){
            var _this = $(this);
            var objprev = target.find("input[title='"+_this.attr('value')+"']");
            //console.log(objprev);
            if(_this.attr('hidden')){
                _this.attr("orghidden",_this.attr('hidden'));
                _this.removeAttr("hidden");
            }
            var formatStr = _this.attr('date_format') || '';
            if(formatStr.indexOf(' ') > -1){
                formatStr = formatStr.split(' ')[0].toUpperCase() +' '+ formatStr.split(' ')[1].toLowerCase();
            }else{
                formatStr = formatStr.toUpperCase();
            }
            var inputObj = '<input name="'+objprev.attr('name')+'" title="'+objprev.attr('title')+'" class="form_item laydate-icon" data-type="calendar" id="'+objprev.attr('name')+'" value="'+formatStr+'"  date_format="'+ (formatStr || 'yyyy-MM-dd')+'"/>';
            objprev.remove();
            //console.log(inputObj);
            _this.before(inputObj);
            _this.remove();
        });
        //
        target.find("textarea").each(function(){
            if($(this).attr('hidden')){
                $(this).attr("orghidden",_this.attr('hidden'));
                $(this).removeAttr("hidden");
            }
            if(!$(this).hasClass('special_form_item')){
                $(this).addClass("form_item");
            }

            if($(this).attr('data-type') != "sign" && $(this).attr('data-type') != "userselect" && $(this).attr('data-type') != "deptselect"&&$(this).attr('data-type') != "countersignature_item"&&$(this).attr('data-type') != "macros" ){
                $(this).attr("data-type","textarea");
            }
            $(this).attr("id",$(this).attr("name"));
            if( $(this).attr('hidden')){
                $(this).attr("orghidden",_this.attr('hidden'));
                $(this).removeAttr("hidden");
            }
            //处理多行文本框控件-富文本格式
            var _this = $(this);
            if(_this.attr('rich')!= undefined && _this.attr('rich') == 1){
                if(!_this.attr('id')){
                    _this.attr({
                        'id':_this.attr('name'),
                        'class':'form_item',
                        'data-type':'textarea',

                    })
                }
                var div = '<div id="container'+ _this.attr('name').split('DATA_')[1] +'" class="container"></div>'
                _this.before(div)
                if(location.href.indexOf('/form/designer?') == -1){
                    _this.css('display','none')
                }
            }
        });
        target.find("select").each(function () {
            var _this = $(this);
            $(this).addClass("form_item");
            if(_this.attr('hidden')){
                _this.attr("orghidden",_this.attr('hidden'));
                _this.removeAttr("hidden");
            }
            $(this).attr("data-type","select");
            $(this).attr("id",$(this).attr("name"));
        });
        target.find("img.RADIO").each(function(){
            var _this = $(this);
            if(_this.attr('hidden')){
                _this.attr("orghidden",_this.attr('hidden'));
                _this.removeAttr("hidden");
            }
            var radioStr = ' <input name="'+_this.attr('name')+'" checked="checked" id="'+_this.attr('name')+'" title="'+_this.attr('title')+'" type="radio"  radio_field="'+_this.attr('radio_field')+'" orgchecked="'+_this.attr('radio_checked')+'" classname="radio" class="form_item" data-type="radio" />';
            _this.before(radioStr);
            _this.remove();
        });

        target.find("img.USER").each(function(){
            var _this = $(this);
            var objprev = target.find("input[title='"+_this.attr('value')+"']");
            if(objprev.length>0){
                if(_this.attr('type') == '0'){
                    _this.prev().attr("data-type","userselect");
                    _this.prev().attr("readonly","readonly");
                    _this.prev().attr("style",'width:150px;');
                    var selectImgStr = '<textarea name = "'+objprev.attr('name')+'" id="'+objprev.attr('name')+'" class="form_item userselect" data-type="userselect" title="'+objprev.attr('title')+'" readonly="readonly" orghidden="'+objprev.attr('orghidden')+'" size="'+objprev.attr('size')+'"orgfontsize="" orgwidth="150" orgheight="" style="cursor: pointer;background: #fff url(/img/workflow/form/user_select.png) no-repeat right;height:px;width:150px;font-size:px;">'+objprev.val()+'</textarea>';
                    _this.before(selectImgStr);
                    objprev.remove();
                    _this.remove();
                }else{
                    _this.prev().attr("data-type","deptselect");
                    _this.prev().attr("readonly","readonly");
                    _this.prev().attr("style",'width:150px;');
                    var selectImgStr = '<textarea name = "'+objprev.attr('name')+'" id="'+objprev.attr('name')+'" class="form_item deptselect" data-type="deptselect" title="'+objprev.attr('title')+'" readonly="readonly" orghidden="'+objprev.attr('orghidden')+'" size="'+objprev.attr('size')+'"orgfontsize="" orgwidth="150" orgheight="" style="cursor: pointer;background: #fff url(/img/workflow/form/group_select.png) no-repeat right;height:px;width:150px;font-size:px;">'+objprev.val()+'</textarea>';
                    _this.before(selectImgStr);
                    objprev.remove();
                    _this.remove();
                }

            }else{
                if(_this.attr('type') == '0'||_this.attr('name') == 'OTHER_2'){
                    try{
                        pluginId++;
                        var selectImgStr = '<textarea name = "DATA_'+pluginId+'" id="DATA_'+pluginId+'" class="form_item userselect" data-type="userselect" title="'+_this.attr('value')+'" readonly="readonly"  orgfontsize="" orgwidth="150" orgheight="" style="cursor: pointer;background: #fff url(/img/workflow/form/user_select.png) no-repeat right;height:px;width:150px;font-size:px;"></textarea>';
                        _this.before(selectImgStr);
                        _this.remove();
                    }catch(e){
                        console.log(e.message);
                    }

                }else{
                    try{
                        pluginId++;
                        var selectImgStr = '<textarea name = "DATA_'+pluginId+'" id="DATA_'+pluginId+'" class="form_item deptselect" data-type="deptselect" title="'+_this.attr('value')+'" readonly="readonly"  orgfontsize="" orgwidth="150" orgheight="" style="cursor: pointer;background: #fff url(/img/workflow/form/group_select.png) no-repeat right;height:px;width:150px;font-size:px;"></textarea>';
                        _this.before(selectImgStr);
                        _this.remove();
                    }catch(e){
                        console.log(e.message);
                    }
                }
            }
        });
        target.find("img.DEPT").each(function(){
            var _this = $(this);
            var objprev = target.find("input[title='"+_this.attr('value')+"']");
        });
        target.find("input[data-type=calendar]").each(function(){
            var _this = $(this);
            var formatStr = $(this).val() || '';
            if(formatStr.indexOf(' ') > -1){
                formatStr = formatStr.split(' ')[0].toUpperCase() +' '+ formatStr.split(' ')[1].toLowerCase();
            }else{
                formatStr = formatStr.toUpperCase();
            }
            $(this).val(formatStr).attr({'date_format':formatStr,'value':formatStr});
        });
        // 手写签章控件
        target.find("img.SIGN").each(function () {
            var _this = $(this);
            if(!_this.hasClass('form_item')){
                var srcStr = _this.attr('src');
                if(srcStr.indexOf('static/images/form/websign.png') > -1){
                    srcStr = '/img/form/websign.png';
                }
                var listStr = '<img name="'+_this.attr('name')+'" src="'+srcStr+'" class="form_item SIGN" data-type="djsign" title="'+_this.attr('title')+'" id="'+_this.attr('name')+'" align="absMiddle" border="0" sign_type="'+_this.attr('sign_type')+'" window_size="320,192" mobilewinwidth="0" mobilewinheight="0" value="'+_this.attr('value')+'" sign_color="'+_this.attr('sign_color')+'" classname="SIGN form_item" _src="/static/images/form/websign.png" sign_check="" isseal="'+ _this.attr('sign_type').split(',')[0] +'" ishandwriting="'+ _this.attr('sign_type').split(',')[1] +'" style="width: 18px; height: 18px; cursor: pointer;">'
                _this.before(listStr);
                _this.remove();
            }
        });
    },
    MacrosRender:function(flag,stepType,stepValue){

        var that = this;

        var flagStr = "";
        var sql = workForm.option.sql;
        var sqlList = workForm.option.sqlList;
        function check(name){
            if(name == undefined){
                return ''
            }else{return name}
        }

        that.option.eleObject.find(".AUTO").each(function(index,obj){

            if($(this).attr("orghidden") == 1){
                $(this).attr("hidden","1");
                $(this).hide();
            }
            if($(this).attr("orgsql")!=""&&$(this).attr("orgsql")!=undefined){

                if($(this).attr("orgsql").indexOf('`')>-1){
                    sql += $(this)[0].id+'-'+$(this).attr("orgsql").replace(/`/g,"'")+';'
                }else{
                    sql += $(this)[0].id+'-'+$(this).attr("orgsql")+';'
                }
            }
            if($(this).attr("orgsqlList")!=""&&$(this).attr("orgsqlList")!=undefined){

                if($(this).attr("orgsqlList").indexOf('`')>-1){
                    sqlList += $(this)[0].id+'-'+$(this).attr("orgsqlList").replace(/`/g,"'")+';'
                }else{
                    sqlList += $(this)[0].id+'-'+$(this).attr("orgsqlList")+';'
                }
            }
            if(that.tool.MacrosData.option[$(this).attr("datafld")]){
                flagStr+=($(this).attr("datafld")+',');
            }
        });

        that.option.eleObject.find(".markformItem").each(function(index,obj){
            var idtitle = $(this).attr('name');
            var title = $(this).attr('title');

            var str = '<div id="startone'+ idtitle +'" class="mark block clearfix">' +
                '<input type="hidden" name="'+ idtitle +'" value="-1" id="'+ idtitle +'" class="form_item" data-type="markformItem" title="'+ title +'">\n' +
                '                <div class="star_score"></div>\n' +
                '            </div>';
            $(this).before(str).remove();
        });

        if(that.option.flowStep != -1){
            that.tool.MacrosData.ready(flagStr,function(MacrosData){

                if( !that.option.preView){
                    that.option.eleObject.find(".AUTO").each(function(index,obj){
                        if(that.tool.MacrosData.option[$(this).attr("datafld")]){
                            var selectObj = $('<select id="'+$(this).attr('name')+'" name="'+$(this).attr('name')+'" title="'+$(this).attr('title')+'" data-type="'+$(this).attr('data-type')+'" style="'+$(this).attr('style')+'" datafld="'+$(this).attr('datafld')+'" class="form_item AUTO"></select>');
                            that.tool.getMacrosData($(this).attr("datafld"))(selectObj);
                            $(this).before(selectObj);
                            $(this).remove();
                        }else{
                            if($(this).attr("datafld") == 'SYS_SQL' || $(this).attr("datafld") == 'SYS_LIST_SQL' || $(this).attr("datafld") == 'SYS_CODE'){
                                $(this).attr('value', check(that.tool.getMacrosData($(this).attr("datafld"))($(this).attr("id"))))
                            }else{
                                $(this).attr('value', check(that.tool.getMacrosData($(this).attr("datafld"))()))
                            }

                        }
                    });
                    $(document).on('click','.refresh',function(){
                        var datafld = $(this).attr('datafld');
                        if($(this).attr("datafld") == 'SYS_SQL' || $(this).attr("datafld") == 'SYS_LIST_SQL'){
                            $(this).prev().attr('value', check(that.tool.getMacrosData(datafld)($(this).attr('id'))))
                        }else{
                            $(this).prev().attr('value', check(that.tool.getMacrosData(datafld)()))
                        }
                    })
                }else{
                    that.option.eleObject.find(".AUTO").each(function(index,obj){
                        if(that.tool.MacrosData.option[$(this).attr("datafld")]){
                            var selectObj = $('<select id="'+$(this).attr('name')+'" name="'+$(this).attr('name')+'" title="'+$(this).attr('title')+'" data-type="'+$(this).attr('data-type')+'" style="'+$(this).attr('style')+'" datafld="'+$(this).attr('datafld')+'" class="form_item AUTO"></select>');
                            that.tool.getMacrosData($(this).attr("datafld"))(selectObj);
                            $(this).before(selectObj);
                            $(this).remove();
                        }else{
                            if($(this).attr("datafld") == 'SYS_SQL' || $(this).attr("datafld") == 'SYS_LIST_SQL'){
                                $(this).attr('value', check(that.tool.getMacrosData($(this).attr("datafld"))($(this).attr("id"))))
                            }else{
                                $(this).attr('value', check(that.tool.getMacrosData($(this).attr("datafld"))()))
                            }

                        }
                    });
                }
            },flag,"",stepType,stepValue,sql,sqlList);
        } else{ //预览宏控件回显
            that.tool.MacrosData.ready(flagStr,function(MacrosData){
                if( !that.option.preView){
                    that.option.eleObject.find(".AUTO").each(function(index,obj){
                        if(that.tool.MacrosData.option[$(this).attr("datafld")]){
                            var selectObj = $('<select id="'+$(this).attr('name')+'" name="'+$(this).attr('name')+'" title="'+$(this).attr('title')+'" data-type="'+$(this).attr('data-type')+'" style="'+$(this).attr('style')+'" datafld="'+$(this).attr('datafld')+'" class="form_item AUTO"></select>');
                            that.tool.getMacrosData($(this).attr("datafld"))(selectObj);
                            $(this).before(selectObj);
                            $(this).remove();
                        }else{
                            var val = that.tool.getMacrosData($(this).attr("datafld"))()
                            if($(this).attr("datafld") == 'SYS_SQL' || $(this).attr("datafld") == 'SYS_LIST_SQL'){
                                $(this).attr('value', check(that.tool.getMacrosData($(this).attr("datafld"))($(this).attr("id"))));
                            }else{

                                $(this).attr('value', check(that.tool.getMacrosData($(this).attr("datafld"))()));
                            }
                        }
                    });
                    $(document).on('click','.refresh',function(){
                        var datafld = $(this).attr('datafld');
                        if($(this).attr("datafld") == 'SYS_SQL' || $(this).attr("datafld") == 'SYS_LIST_SQL'){
                            $(this).prev().attr('value', that.tool.getMacrosData(datafld)($(this).attr("id")));
                        }else{
                            $(this).prev().attr('value', that.tool.getMacrosData(datafld)());
                        }

                        // console.log(that.tool.getMacrosData(datafld)())
                    })
                }else{
                    that.option.eleObject.find(".AUTO").each(function(index,obj){
                        if(that.tool.MacrosData.option[$(this).attr("datafld")]){
                            var selectObj = $('<select id="'+$(this).attr('name')+'" name="'+$(this).attr('name')+'" title="'+$(this).attr('title')+'" data-type="'+$(this).attr('data-type')+'" style="'+$(this).attr('style')+'" datafld="'+$(this).attr('datafld')+'" class="form_item AUTO"></select>');
                            that.tool.getMacrosData($(this).attr("datafld"))(selectObj);
                            $(this).before(selectObj);
                            $(this).remove();
                        }else{
                            if($(this).attr("datafld") == 'SYS_SQL' || $(this).attr("datafld") == 'SYS_LIST_SQL'){
                                $(this).attr('value', check(that.tool.getMacrosData($(this).attr("datafld"))($(this).attr("id"))));
                            }else{
                                $(this).attr('value', check(that.tool.getMacrosData($(this).attr("datafld"))()));
                            }

                        }
                    });
                }
            },flag,1,sql,sqlList);

        }

    },
    TextRender: function(){
        var that = this;
        $.ajax({
            url: '/workflow/work/prentAndSonFlow',
            type: 'GET',
            dataType: 'json',
            data: {runId: that.option.flowRun.runId},
            async: false,
            success: function (res) {
                if (res.flag && res.object) {
                    var $formItems = that.option.eleObject.find('.form_item');
                    var mobileStyle = '';
                    if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent)) {
                        $formItems = $('#content').find('.form_item');
                        mobileStyle = 'background-color: transparent;'
                    }
                    $formItems.each(function (index, ele) {
                        var type = $(ele).attr('data-type') || '';
                        if (type === 'text') {
                            var title = $(ele).attr('title') || '';
                            var val = $(ele).val() || '';
                            var styleStr = $(ele).attr('style') || '';
                            var isHidden = $(ele).attr("orghidden");
                            if ((title === '总包部流程编号' || title === '区域总部流程编号') && !!val && isHidden != 1) {
                                var str = '<a class="child_form_parentLink" style="' + styleStr+mobileStyle + 'color: #1687cb;text-decoration: none;display: inline-block !important;" href="javascript:;" flowId=' + res.object.flowId + ' runId=' + res.object.runId + '>' + val + '</a>';
                                $(ele).before(str);
                                $(ele).siblings('.child_form_parentLink').siblings().hide();
                            }
                        }
                    });

                    $(document).on('click', '.child_form_parentLink', function(){
                        var flowId = $(this).attr('flowId');
                        var runId = $(this).attr('runId');

                        if($.getQueryString("type") == 'EWC'){
                            window.location.href = '/workflow/work/workformPreView?flowId=' + flowId + '&flowStep=&prcsId=&runId=' + runId + '&formInfo=formInfo';
                        } else if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                            try{
                                window.webkit.messageHandlers.formInfoUrlLink.postMessage({'url':'/workflow/work/workformh5PreView?flowId=' + flowId + '&flowStep=&prcsId=&runId=' + runId + '&formInfo=formInfo','name':'流程详情'});
                            }
                            catch(err) {
                                formInfoUrlLink('/workflow/work/workformh5PreView?flowId=' + flowId + '&flowStep=&prcsId=&runId=' + runId + '&formInfo=formInfo', '流程详情');
                            }
                        } else if (/(Android)/i.test(navigator.userAgent)) {
                            Android.formInfoUrlLink('/workflow/work/workformh5PreView?flowId=' + flowId + '&flowStep=&prcsId=&runId=' + runId + '&formInfo=formInfo', '流程详情');
                        } else {
                            $.popWindow('/workflow/work/workformPreView?flowId=' + flowId + '&prcsId=&flowStep=&runId=' + runId);
                        }
                    })
                }
            }
        });
    },
    AutoCode:function() {
        var that = this;
        var autoCode = {};
        var flowRun = workForm.option.flowRun;
        var noId = 0;
        $.ajax({
            type: 'GET',
            url: '/document/findByRunId',
            data: {runId: flowRun.runId},
            async: false,
            beforeSend : function(request) {
                if(beforeToken != ''){
                    request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
                }
            },
            success: function(res){
                if (res.flag && res.object && res.object.sysRuleId) {
                    noId = res.object.sysRuleId;
                }
            }
        });
        that.option.eleObject.find(".autocode").each(function (index,ele) {

            var _this = $(this);
            var uuid = _this.attr('datafld');
            var dataNum = _this.attr('name');
            if (noId && index == 0) {
                uuid = noId;
                _this.attr('datafld', noId);
            }

            if (that.option.prcsItem && that.option.prcsItem.indexOf(_this.attr('title')) > -1) {
                // 移动端自动编号控件不进行操作
                if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )||/(Android)/i.test(navigator.userAgent)) {
                    // _this.val('');
                } else {
                    $.get('/document/checkRunId', {runId: flowRun.runId, flowId: flowRun.flowId, dataNum: dataNum}, function(res){
                        if (res.flag && (res.object == 0 || res.object == 1)) {
                            if (res.object == 0) {
                                if (autoCode[uuid]) {
                                    autoCode[uuid]++;
                                } else {
                                    autoCode[uuid] = 1;
                                }
                                $.ajax({
                                    type: "get",
                                    async:false,
                                    url: "/document/updateCount",
                                    dataType: 'JSON',
                                    data:{
                                        id: uuid,
                                        count: autoCode[uuid],
                                        runId: flowRun.runId,
                                        flowId: flowRun.flowId,
                                        dataNum: dataNum
                                    },
                                    beforeSend : function(request) {
                                        if(beforeToken != ''){
                                            request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
                                        }
                                    },
                                    success: function (obj) {
                                        if(obj.flag){
                                            autocodeValue = obj.object.expressionStr;
                                            _this.val(autocodeValue);
                                        }
                                    }
                                });
                            }
                        } else {
                            _this.val('');
                        }
                    });
                }

                _this.attr('uuid', uuid);
                _this.after('<button class="autocodebtn" uuid="'+uuid+'">查看</button>');
            }

        });
        // 查看按钮
        that.option.eleObject.on('click','.autocodebtn',function () {
            var $this = $(this);
            if(!$this.attr('disabled')){
                layer.open({
                    title: false,
                    area: ['700px', '400px'],
                    btn: ['关闭'],
                    content: '<div id="autoCodeModal" style="height: 100%;">' +
                        '<div class="modal_tab" style="height: 100%;position: relative;">' +
                        '  <div class="modal_tab_title">' +
                        '    <button class="layui-btn layui-btn-normal modal_tab_btn">未使用编号</button>' +
                        '    <button class="layui-btn layui-btn-primary modal_tab_btn">已使用编号</button>' +
                        '  </div>' +
                        '  <div class="modal_tab_content" style="position: absolute;top: 38px;left: 0;bottom: 0;padding-top: 5px;width: 100%;">' +
                        '    <div class="modal_tab_item" style="position: relative; height: 100%; overflow: hidden;">' +
                        '       <table style="width: 100%;margin: 0;"><thead><th>编号</th></thead></table>' +
                        '       <div style="position: absolute;top: 25px;bottom: 0;overflow: auto;"><table border="1" style="width: 100%;margin: 0;border: none;text-align: center;"><tbody id="unuse_table"></tbody></table></div>' +
                        '    </div>' +
                        '    <div class="modal_tab_item" style="position: relative; height: 100%; overflow: hidden;display: none;">' +
                        '       <table style="width: 100%;margin: 0;"><thead><th>编号</th><th style="width: 20%">流水号</th><th>工作名称/文号</th></thead></table>' +
                        '       <div style="position: absolute;top: 25px;bottom: 0;overflow: auto;">' +
                        '           <table border="1" style="width: 100%;margin: 0;border: none;text-align: center;">' +
                        '               <tbody id="use_table"></tbody>' +
                        '           </table>' +
                        '       </div>' +
                        '    </div>' +
                        '  </div>' +
                        '</div>' +
                        '</div>',
                    success: function(){
                        $('.modal_tab_btn').on('click', function(){
                            $(this).siblings().removeClass('layui-btn-normal').addClass('layui-btn-primary');
                            $(this).removeClass('layui-btn-primary').addClass('layui-btn-normal');
                            var index = $(this).index();
                            $('.modal_tab_item').css('display', 'none').eq(index).css('display', 'block');
                        });

                        var uuid = $this.attr('uuid');
                        var datas = '';

                        $('.autocode').each(function(){
                            if (uuid == $(this).attr('uuid')) {
                                datas += $(this).attr('id') + ',';
                            }
                        });

                        // 获取未使用文号数据
                        $.get('/document/unUseNo', {id: uuid, datas: datas, flowId: flowRun.flowId}, function(res){
                            if (res.flag) {
                                var str = '';
                                var data = res.object;
                                for(var item in data){
                                    str += '<tr><td>'+data[item]+'</td></tr>'
                                }
                                $('#unuse_table').append(str);
                            }
                        });

                        // 获取已使用文号数据
                        $.get('/document/UseNo', {id: uuid, datas: datas, flowId: flowRun.flowId}, function(res){
                            if (res.flag) {
                                var str = '';
                                var styleStr = 'overflow: hidden;padding: 0 5px;word-break: break-all;white-space: nowrap;text-overflow: ellipsis;';
                                res.object.forEach(function(obj){
                                    obj.forEach(function(item){
                                        str += '<tr><td>'+item['expressionStr']+'</td><td style="width: 20%">'+item['RUN_ID']+'</td><td style="'+styleStr+'" title="'+item['RUN_NAME']+'">'+item['RUN_NAME']+'</td></tr>'
                                    });
                                });
                                $('#use_table').append(str);
                            }
                        });
                    }
                });
            }
        });
    },
    DateRender:function(){
        var that = this;
        this.option.eleObject.find(".laydate-icon").each(function(){
            var _this = $(this);
            var format = _this.attr('date_format');
            if(format.indexOf(' ') > -1){
                format = format.split(' ')[0].toUpperCase() +" "+ format.split(' ')[1].toLowerCase();
            }else{
                format = format.toUpperCase();
            }
            var defauVal = _this.attr('isNow') == '1' ?laydate.now(0, format):'';
            var divObj = '<input readonly="readonly" value="'+defauVal+'" style="cursor: pointer;'+_this.attr('style')+'" name="'+_this.attr('name')+'" title="'+_this.attr('title')+'" class="form_item laydate-icon" data-type="calendar" id="'+_this.attr('name')+'"   date_format="'+format+'"/>';
            _this.before(divObj);
            _this.remove();
        });
        this.option.eleObject.on("click",'.laydate-icon',function(){
            if(!that.option.ish5){
                var __this = $(this);
                var format = $(this).attr("date_format");
                var formatArr = '';
                var flag = true
                if(format.split(' ').length > 1){
                    formatArr = format.split(' ')[0].toUpperCase() + " " +format.split(' ')[1].toLowerCase();
                    flag = true;
                }else{
                    formatArr = format.split(' ')[0].toUpperCase();
                    flag = false;
                }
                laydate({format:formatArr,istime: flag,customize: flag,choose:function () {
                        __this.trigger('propertychange');
                    }});
            }
        });
    },
    buildHTML:function(cb){
        var that = this;
        layer.load();
        // console.log(that.option.formhtmlurl)
        that.tool.ajaxHtml(that.option.formhtmlurl,that.option.resdata,function (res) {
            if(res.flag){
                if(res.object.flowFormType && res.object.flowFormType.printModelShort){
                    var str= res.object.flowFormType.printModelShort;
                    if(str.indexOf('data-type="djsign"') > -1||str.indexOf('class="SIGN"') > -1){
                        var userAgent = navigator.userAgent;
                        if(userAgent.indexOf('QtWebEngine') > -1&&location.href.indexOf('&ie_open=yes') == -1){
                            url += '&ie_open=yes&IE=1';
                            window.open(url);
                            window.close();
                        }
                    }
                }
                var formObj = res.object.flowFormType || res.object;

                if(formObj.printModel != ''){
                    //$(that.option.target).html(formObj.printModel);
                    var formCss = ''
                    var formJs = ''
                    if(that.option.flowStep != -1){
                        //兼容工作流查询编辑
                        if(location.href.indexOf('/workflow/work/workformedit?') > -1){
                            that.option.flowStep = res.object.flowRunPrcs.flowPrcs;
                            that.option.prcsId = res.object.flowRunPrcs.prcsId;
                        }else{
                            if(that.option.flowStep == ''){
                                that.option.flowStep = res.object.flowRunPrcs.prcsId;
                            }
                            if(that.option.prcsId == ''){
                                that.option.prcsId = res.object.flowRunPrcs.flowPrcs;
                            }
                        }
                        that.option.listFp = res.object.listFp;
                        that.option.flowRun = res.object.flowRun;
                        that.option.flowRunPrcs = res.object.flowRunPrcs;
                        that.option.flowFormType = res.object.flowFormType;
                        that.option['runName'] =  res.object.flowRun.runName;
                        that.option['runDate'] =  res.object.flowRun.beginTime;
                        that.option['runId'] =  res.object.flowRun.runId;
                        that.option.prcsUserlist = res.object.prcsUserlist;
                        that.option.prcsDeptlist = res.object.prcsDeptlist;
                        that.option.prcsPrivlist = res.object.prcsPrivlist;
                        that.option['formName'] = res.object.flowFormType.formName;
                        that.option.listTurnPriv = res.object.listTurnPriv;
                        that.option.flowPrcs = res.object.flowRunPrcs.flowPrcs
                        that.option.PRCSID = res.object.flowRunPrcs.prcsId;
                        that.option.opFlag = res.object.flowRunPrcs.opFlag;
                        that.option.prcsItem = res.object.prcsItem;
                        that.option.flowProcesses = res.object.flowProcesses;
                        if(res.object.flowProcesses!=undefined){
                            that.option.prcsItemAuto = res.object.flowProcesses.prcsItemAuto;
                        }

                        if(that.option.flowFormType.css){
                            formCss = that.option.flowFormType.css;
                        }
                        if(that.option.flowFormType.script){
                            formJs = that.option.flowFormType.script;
                        }
                    }else {
                        that.option.preView = true;
                        that.option['formName'] = formObj.formName;
                    }
                    var formjsStr = "";
                    if(formJs.indexOf('<script')> -1){
                        formjsStr = formJs;
                    }else{
                        formjsStr = '<script>'+ formJs +'</script>';
                    }
                    that.option.eleObject = $('<div>'+formObj.printModel+'<style>'+ formCss+'</style>'+ formjsStr +'</div>');
                    that.option.macrossignObj = {};
                    that.option.eleObject.find('.macrossign').each(function(){
                        var _this = $(this);
                        if(that.option.macrossignObj[$(this).attr('name')] == undefined){
                            that.option.macrossignObj[$(this).attr('name')] = false;
                        }
                        if($(this).attr('stepType')!=""&&$(this).attr('stepType')!=undefined){
                            that.option.stepType = $(this).attr('stepType')
                        }
                        if($(this).attr('stepValue') != "" && $(this).attr('stepValue')!=undefined){
                            that.option.stepValue = $(this).attr('stepValue')
                        }
                        that.tool.MacrosData.ready('','',true)
                        that.MacrosSignRender()

                    });
                    //下面是兼容通达会签意见代码
                    var runId = $.GetRequest().runId
                    $.ajax({
                        type: "get",
                        url: "/workflow/work/findworkUpload",
                        dataType: 'JSON',
                        data: {
                            runId:runId
                        },
                        async:false,
                        success: function (obj) {
                            if(obj.flag){
                                var deletebtn = '';
                                let macroAttach = '';
                                obj.obj.forEach(function (v,i) {
                                    var priv = v.aTTACH_PRIV||'';
                                    var attachName = v.attachName||'';
                                    var fileExtension = attachName.substring(attachName.lastIndexOf(".")+1,attachName.length);//截取附件文件后缀
                                    var fileIcon = '';
                                    if(datatyoe[fileExtension] == undefined){ //处理附件图标
                                        fileIcon = 'file';
                                    }else{
                                        fileIcon = datatyoe[fileExtension];
                                    }
                                    var downbtn = '';
                                    var editbtn = '';
                                    var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                    var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                    var attachmentUrl = v.attUrl;
                                    attachmentUrl = attachmentUrl.substring(0,attachmentUrl.lastIndexOf("ATTACHMENT_NAME="))+"ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension; //处理附件名字
                                    if(priv.indexOf(2) > -1&&location.href.indexOf('workformPreView') == -1&&location.href.indexOf('workformh5PreView') == -1){
                                        editbtn = 'display: block;';
                                    }else{
                                        editbtn = 'display: none;';
                                    }
                                    if(priv.indexOf(4) > -1){
                                        downbtn = 'display: block;';
                                    }else{
                                        downbtn = 'display: none;';
                                    }
                                    if(priv.indexOf(3) > -1&&location.href.indexOf('workformPreView') == -1&&location.href.indexOf('workformh5PreView') == -1){
                                        deletebtn = 'display: block;';
                                    }else{
                                        deletebtn = 'display: none;';
                                    }
                                    macroAttach += '<div class="imgfileBox" style="display: inline-block;position: relative;"><img src="/img/attachmentIcon/'+fileIcon+'.png" align="absmiddle" class="fileupload_data" style="width: auto;" atturl="'+ attachmentUrl +'">&nbsp;<span class="uploadImg" style="color: #0088cc;">'+ attachName +'</span>&nbsp;&nbsp;&nbsp;&nbsp;' +
                                        '<ul class="hoverbox" flag="true" style="top: 0px; left: 0px; display: none;">' +
                                        '<li class="hoverboxLiDownload" style="'+ downbtn +'"><span class="plotting">&gt;</span>下载</li>' +
                                        function(){
                                            if( getFileIsOffice(fileExtension) || getFileIsPDForTXT(fileExtension) || getFileIsPic(fileExtension) ){
                                                return '<li class="hoverboxLiPreview0" style="display: block;"><span class="plotting">&gt;</span>预览</li>'
                                            }else{
                                                return ''
                                            }
                                        }()+
                                        function(){
                                            if(getFileIsOffice(fileExtension)){
                                                return '<li class="hoverboxLiPreview" style="display: block;"><span class="plotting">&gt;</span>查阅</li><li class="hoverboxLiEdit" style="'+ editbtn +'"><span class="plotting">&gt;</span>编辑</li>'
                                            }else{
                                                return ''
                                            }
                                        }()+
                                        '<li class="hoverboxLidelete" style="'+ deletebtn +'"><span class="plotting">&gt;</span>删除</li></ul>'+
                                        '</div>'

                                });
                                // 兼容通达宏标记数据-公共附件区上传文件
                                var formFile = that.option.eleObject[0].innerHTML.match(/#\[MACRO_ATTACH\]/g);
                                if(formFile != null && formFile != undefined &&formFile.length>0){
                                    var fileValue = macroAttach||'';
                                    for(let i=0;i<formFile.length;i++){
                                        var flowFileStr = that.option.eleObject[0].innerHTML.replace(formFile[i], '<div macro-id="macro-attach-" style="">'+ fileValue +'</div>');
                                        that.option.eleObject[0].innerHTML = flowFileStr;
                                    }
                                }
                            }
                        }
                    });
                    var macrosSign = that.option.eleObject[0].innerHTML;
                    var arrSign = macrosSign.match(/#\[MACRO_SIGN(\d*)(\*?)\]\[([\S\s]*?)\]/g);
                    if(arrSign!=undefined&&arrSign.length>0){
                        that.option.signText = arrSign;
                        var stepType1 = "";
                        var stepValue1 = '';
                        var stepType = "";
                        var stepValue = '';
                        arrSign.forEach(function(v,i){
                            var sign = v.match(/#\[MACRO_SIGN(\d*)(\*?)\]\[([\S\s]*?)\]/i);
                            if(sign[2]=='*'){
                                stepType = 'FLOW_PRCS';
                                stepValue += sign[1]+',';
                            }else{
                                stepType1 = 'PRCS_ID';
                                stepValue1 += sign[1]+',';
                            }
                        })
                        if(typeof macroSign == "function"){
                            if(stepType != ''){
                                macroSign(stepType,stepValue);
                            }
                            if(stepType1 != ''){
                                macroSign(stepType1,stepValue1);
                            }
                        }
                    }
                    //在workForm中增加个correspondence 用来存储工作流表单title-name之间的对应关系 start
                    var objectTD = {};
                    var objectDT = {};
                    var arr = [];
                    that.option.eleObject.find(".form_item").each(function () {
                        var _this = $(this);
                        var item = {
                            name: _this.attr('name'),
                            title: _this.attr("title"),
                            dataType: _this.attr('data-type')
                        }
                        arr.push(item);
                        objectTD[_this.attr('title')] = _this.attr('name');
                        objectDT[_this.attr('name')] = _this.attr('title');
                    });
                    workForm['correspondence'] = {'arr': arr, 'objectTD': objectTD, 'objectDT': objectDT};
                    //end
                    $(that.option.target).html(that.render());
                    $(that.option.target).find('table').attr('align','center')
                    $(that.option.target).find('table').css('margin','auto auto')
                    layer.closeAll();
                    if(!that.option.ish5){
                        $('body').append('<script src="/js/workflow/plugin/countersignature/main.js"></script>');
                    }

                }else{
                    layer.closeAll();
                    layer.msg(sd, {icon: 6});
                    var noformdata = '<div class="cont_rig" style="text-align: center;margin-top: 200px;"><div class="noData_out"><div class="noDatas_pic"><img style="margin-left: 34px;" src="/img/workflow/img_nomessage_03.png"></div><div style="margin-top: 19px;" class="noDatas">表单内容为空</div></div></div>'
                    $(that.option.target).html(noformdata);
                }
                if(formObj.script){
                    function isInclude(name){
                        var js= /js$/i.test(name);
                        var es=document.getElementsByTagName(js?'script':'link');
                        for(var i=0;i<es.length;i++)
                            if(es[i][js?'src':'href'].indexOf(name)!=-1)return true;
                        return false;
                    }
                    if(!isInclude('/js/workflow/plugin/countersignature/main.js')){
                        $('body').append('<script type="text/javascript" src="/js/workflow/plugin/countersignature/main.js"></script>');
                    }

                }
            }else{
                layer.closeAll();
                layer.msg(failedProcess, {icon: 6 },function () {

                });

            }
            if(cb && that.option.eleObject){
                that.option.eleObject.find('.form_item').each(function () {
                    var _this = $(this);
                    try {
                        if(parseInt(_this.attr('name').split('_')[1]) > that.option.formLength){
                            that.option.formLength =  _this.attr('name').split('_')[1];
                        }
                    }catch (e){
                        // console.log(e);
                    }

                });
                //console.log(that.option.formLength);
                return cb(res,that.option,that.option.eleObject);
            }
            return cb;
        });
        try {
            selectAttachment();
        }catch (e) {
            console.log(e)
        }
    },
    getSearchData:function (cb) {
        var that = this;
        this.tool.ajaxHtml(that.option.formhtmlurl,this.option.resdata,function (data) {
            var formObj = data.object;
            that.option.eleObject = $('<div>'+formObj.printModel+'</div>');
            that.ReBuild();
            var arr = [];
            that.option.eleObject.find(".form_item").each(function () {
                var _this = $(this);
                var item = {
                    name:_this.attr('name'),
                    title:_this.attr("title"),
                    dataType:_this.attr('data-type')
                }
                arr.push(item);
            });
            cb(arr);
        })
    },
    tool:  {
        MacrosData:{
            option:{
                SYS_LIST_DEPT : true,//部门列表
                SYS_LIST_USER : true,//人员列表
                SYS_LIST_PRIV:true,//角色列表
                SYS_LIST_PRIV_ONLY:true,
                SYS_LIST_PRIV_OTHER:true,
                SYS_LIST_PRCSUSER1:true,
                SYS_LIST_PRCSUSER2:true,
                SYS_LIST_MANAGER1:true,
                SYS_LIST_MANAGER2:true,
                SYS_LIST_MANAGER3:true,
                SYS_LIST_SQL:true,
                SYS_LIST_DEPT_PERSON:true
            },
            data:{},
            SYS_LEVEL : function(target) {
                if(workForm.option.flowRun.workLevel == 0){
                    return '普通';
                }else if(workForm.option.flowRun.workLevel == 1){
                    return '紧急';
                }else if(workForm.option.flowRun.workLevel == 2){
                    return '特急';
                }else{
                    return '普通';
                }
            },
            SYS_LIST_PRIV_ONLY : function(target) {
                var optionStr = '<option value="">请选择主角色</option>';
                var sysListPrivOnly =  workForm.tool.MacrosData.data.sYS_LIST_PRIV_ONLY || workForm.tool.MacrosData.data.sys_LIST_PRIV_ONLY;
                sysListPrivOnly.forEach(function (v,i) {
                    optionStr+='<option value="'+v.privNo+'">'+v.privName+'</option>';
                });
                return target.html(optionStr);

            },
            SYS_FLOW_FORMNAME:function () {
                return workForm.option.flowFormType.formName;
                // return "表单名称";
            },
            SYS_FLOW_FLOWNAME:function () {
                return workForm.option.flowRun.runName;
                // return "流程名称";
            },
            SYS_FLOW_STARTTIME:function () {
                // return "流程开始时间";
                return workForm.option.flowRun.beginTime;
            },
            SYS_FLOW_ENDTIME:function () {
                return workForm.option.flowRun.endTime;
                //return "流程结束时间";
            },
            SYS_FLOW_RUNID:function () {
                return workForm.option.flowRun.runId;
                // return "流水号";
            },
            SYS_FLOW_BEGINNAME:function () {
                return workForm.option.flowRun.userName;
                // return "流程发起人姓名";
            },
            SYS_FLOW_BEGINID:function(){
                return workForm.option.flowRun.uid;
                // return "流程发起人id";
            },
            SYS_FLOW_SIGNTEXT:function () {
                var signtext =  workForm.tool.MacrosData.data.signText || [];
                var str = '';
                // signtext.forEach(function(v,i){
                //     str+=(v.content+'&nbsp;('+v.users.userName+')&nbsp;&nbsp;'+v.editTime+'</br>');
                // });
                signtext.forEach(function(v,i){
                    str += (v.users.userName + '：' + function(){
                        if(v.feedType == 0){
                            return '已阅'
                        }else if(v.feedType == 1){
                            return '同意'
                        }else if(v.feedType == 2){
                            return '不同意'
                        }else{
                            return ''
                        }
                    }() + '</br>' + v.content + '&nbsp;&nbsp;&nbsp;&nbsp;' + v.editTime + '</br>');
                });
                return str;
            },
            SYS_FLOW_SIGNTEXT2:function(){
                var signtext =  workForm.tool.MacrosData.data.signText || [];
                return signtext;
            },
            SYS_FLOW_CHILDFLOW:function(){
                // 子流程链接
                var childFlows = workForm.tool.MacrosData.data.sYS_FLOW_CHILDFLOW || workForm.tool.MacrosData.data.sys_FLOW_CHILDFLOW;
                var str = '';
                if (childFlows && childFlows.length > 0) {
                    childFlows.forEach(function(flow){
                        var url = '/workflow/work/workformPreView?flowId='+flow.flowRun.flowId+'&flowStep=&runId='+flow.runId+'&prcsId=';
                        str += '<a href="javascript:;" style="color: #1687cb; text-decoration: none;" class="child_flow" data-url="'+url+'">'+flow.flowRun.runName+'</a><br>'
                    });

                    str = '<div>'+str+'</div>';
                }
                return str;
            },
            SYS_MODULE_PAGE:function(){
                // 引入页面
                var pageUrl = (workForm.tool.MacrosData.data.sYS_MODULE_PAGE || workForm.tool.MacrosData.data.sys_MODULE_PAGE) || '';

                if(pageUrl){
                    if (pageUrl.indexOf('?') > -1) {
                        var urlArr = pageUrl.split('?');
                        var queryArr = urlArr[1].split('?');
                        var hashArr = queryArr[0].split(/\&/);
                        for (var i = 0; i < hashArr.length; i++) {
                            var key = hashArr[i].split('=')[0];
                            if (key == 'businessModule') {
                                workForm.option.businessModule = hashArr[i].split('=')[1];
                                break;
                            }
                        }
                        pageUrl = urlArr[0] + '?' + queryArr.join('&');
                    }
                }
                return pageUrl;
            },
            SYS_FLOW_EXPLAINFILE:function(){
                // 流程说明附件
                var explainFile = workForm.tool.MacrosData.data.sYS_FLOW_EXPLAINFILE || workForm.tool.MacrosData.data.sys_FLOW_EXPLAINFILE;
                var fileArr = [];
                if (explainFile.length > 0) {
                    explainFile.forEach(function(file){
                        var fileExtension=file.attachName.substring(file.attachName.lastIndexOf(".")+1,file.attachName.length);//截取附件文件后缀
                        var attName = encodeURI(file.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                        var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                        var deUrl = file.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+file.size;

                        fileArr.push('<a style="display: inline-block; color: blue;text-decoration: none;" href="/download?' + encodeURI(deUrl) + '">下载</a>')
                    })
                }
                return fileArr;
            },
            SYS_LIST_PRIV_OTHER : function(target) {
                // console.log("SYS_LIST_PRIV_OTHER");
                var optionStr = '<option value="">请选择辅助角色</option>';
                var sysListPrivOther = workForm.tool.MacrosData.data.sYS_LIST_PRIV_OTHER || workForm.tool.MacrosData.data.sys_LIST_PRIV_OTHER;
                sysListPrivOther.forEach(function (v,i) {
                    if(v!=null&&v.privName != ""){
                        optionStr+='<option value="'+v.userPriv+'">'+v.privName+'</option>';
                    }

                });
                return target.html(optionStr);

            },
            SYS_LIST_PRCSUSER1 : function(target) {
                // console.log("SYS_LIST_PRCSUSER1");
                var optionStr = '<option value="">请选择</option>';
                var sysListPrcsuser1 = workForm.tool.MacrosData.data.sYS_LIST_PRCSUSER1 || workForm.tool.MacrosData.data.sys_LIST_PRCSUSER1;
                sysListPrcsuser1.forEach(function (v,i) {
                    if(v != ""){
                        optionStr+='<option value="'+v+'">'+v+'</option>';
                    }
                });
                return target.html(optionStr);
                // return "";
            },
            SYS_LIST_PRCSUSER2 : function(target) {
                // console.log("SYS_LIST_PRCSUSER2");
                var optionStr = '<option value="">请选择</option>';
                var sysListPrcsuser2 = workForm.tool.MacrosData.data.sYS_LIST_PRCSUSER2 || workForm.tool.MacrosData.data.sys_LIST_PRCSUSER2;
                sysListPrcsuser2.forEach(function (v,i) {
                    if(v != ""){
                        optionStr+='<option value="'+v+'">'+v+'</option>';
                    }
                });
                return target.html(optionStr);
            },
            SYS_SIGNTEXT : function (target) {

                return "";
            },
            SYS_LIST_MANAGER1 : function(target) {
                // console.log("SYS_LIST_MANAGER1");
                var optionStr = '<option value="">请选择人员</option>';
                var sysListManager1 = workForm.tool.MacrosData.data.sYS_LIST_MANAGER1 || workForm.tool.MacrosData.data.sys_LIST_MANAGER1;
                sysListManager1.forEach(function (v,i) {
                    optionStr+='<option value="'+v+'">'+v+'</option>';
                });
                return target.html(optionStr);

                // return "";
            },
            SYS_LIST_MANAGER2 : function (target) {
                // console.log("SYS_LIST_MANAGER2");
                var optionStr = '<option value="">请选择人员</option>';
                var sysListManager2 = workForm.tool.MacrosData.data.sYS_LIST_MANAGER2 || workForm.tool.MacrosData.data.sys_LIST_MANAGER2;
                sysListManager2.forEach(function (v,i) {
                    optionStr+='<option value="'+i+'">'+v+'</option>';
                });
                return target.html(optionStr);
            },
            SYS_LIST_MANAGER3 : function (target) {
                // console.log("SYS_LIST_MANAGER3");
                var optionStr = '<option value="">请选择人员</option>';
                var sysListManager3 = workForm.tool.MacrosData.data.sYS_LIST_MANAGER3 || workForm.tool.MacrosData.data.sys_LIST_MANAGER3;
                sysListManager3.forEach(function (v,i) {
                    if(v!=""){
                        optionStr+='<option value="'+i+'">'+v+'</option>';
                    }

                });
                return target.html(optionStr);
            },
            SYS_LIST_SQL : function (target) {
                if(target !=undefined && target !=""){
                    var optionStr = '<option value="">请选择</option>';
                    var id = target.attr('id')
                    var sysListSql  = workForm.tool.MacrosData.data.sYS_LIST_SQL || workForm.tool.MacrosData.data.sys_LIST_SQL;
                    if(sysListSql && sysListSql[id]!=undefined){
                        sysListSql[id].forEach(function (v,i) {


                            if(v!=""){
                                for(var key in v){
                                    // console.log
                                    optionStr+='<option value="'+v[key]+'">'+v[key]+'</option>';
                                    // str += sql[i][key]+','
                                }

                            }

                        });
                        return target.html(optionStr);
                    }else{
                        return ''
                    }

                }

            },
            SYS_LIST_DEPT_PERSON:function(target){
                var optionStr = '<option value="">请选择人员</option>';
                var sysListDeptPerson = workForm.tool.MacrosData.data.sYS_LIST_DEPT_PERSON || workForm.tool.MacrosData.data.sys_LIST_DEPT_PERSON;
                sysListDeptPerson.forEach(function (v,i) {
                    optionStr+='<option value="'+v.userName+'">'+v.userName+'</option>';
                });
                return target.html(optionStr);
            },
            SYS_LIST_DEPT :function(target){
                target.deptSelect();
                return target.deptSelect()//dept List

            },
            SYS_LIST_USER:function(target){
                var optionStr = '<option value="">请选择人员</option>';
                var sysListUser = workForm.tool.MacrosData.data.sYS_LIST_USER || workForm.tool.MacrosData.data.sys_LIST_USER;
                sysListUser.forEach(function (v,i) {
                    optionStr+='<option value="'+v.uid+'">'+v.name+'</option>';
                });
                return target.html(optionStr);
            },
            SYS_LIST_PRIV:function (target) {
                var optionStr = '<option value="">请选择角色</option>';
                var sysListPriv = workForm.tool.MacrosData.data.sYS_LIST_PRIV || workForm.tool.MacrosData.data.sys_LIST_PRIV;
                sysListPriv.forEach(function (v,i) {
                    optionStr+='<option value="'+v.userPriv+'">'+v.privName+'</option>';
                });
                return target.html(optionStr);
            },
            SYS_DATE_CN : function(){
                return new Date().Format("yyyy年MM月dd日");
            },
            SYS_DATE_CN_SHORT3 : function(){
                return new Date().Format("yyyy年");
            },
            SYS_DATE_CN_SHORT4 : function(){
                return new Date().Format("yyyy");
            },
            SYS_DATE_CN_SHORT1 : function(){
                return new Date().Format("yyyy年MM月");
            },
            SYS_DATE_CN_SHORT2 : function(){
                return new Date().Format("MM月dd日");
            },
            SYS_TIME : function(){
                return new Date().Format("hh:mm:ss");
            },
            SYS_DATETIME : function(){
                return new Date().Format("yyyy-MM-dd  hh:mm:ss");
            },
            SYS_DATE_HMS1 : function(){
                return new Date().Format("yyyy-MM-dd  hh:mm:ss");
            },
            SYS_WEEK : function(){
                return "星期"+"日一二三四五六".charAt(new Date().getDay());//星期几
            },
            SYS_USERID : function(){
                // console.log(workForm.tool.MacrosData.data)
                return workForm.tool.MacrosData.data.sYS_USERID || workForm.tool.MacrosData.data.sys_USERID;
            },
            SYS_RUNIDDATE : function(){
                return workForm.tool.MacrosData.data.sYS_RUNIDDATE || workForm.tool.MacrosData.data.sys_RUNIDDATE;
            },
            SYS_USERNAME : function(obj){
                return workForm.tool.MacrosData.data.sYS_USERNAME || workForm.tool.MacrosData.data.sys_USERNAME ;
            },
            SYS_USERPHONE: function(obj) {
                return workForm.tool.MacrosData.data.sYS_USERPHONE || workForm.tool.MacrosData.data.sys_USERPHONE;
            },
            SYS_SIGN_IMAGE:function(){
                var sysSignImage = workForm.tool.MacrosData.data.sYS_SIGN_IMAGE || workForm.tool.MacrosData.data.sys_SIGN_IMAGE;
                if(sysSignImage!=undefined&&sysSignImage.length>0){
                    return encodeURI(sysSignImage[0].attUrl);
                }else{
                    return ''
                }

            },
            SYS_DEPTNAME : function(){
                return workForm.tool.MacrosData.data.sYS_DEPTNAME || workForm.tool.MacrosData.data.sys_DEPTNAME;
            },
            SYS_DEPTNAME_SHORT : function(){
                return workForm.tool.MacrosData.data.sYS_DEPTNAME_SHORT || workForm.tool.MacrosData.data.sys_DEPTNAME_SHORT;
            },
            SYS_USERPRIV : function(){
                return workForm.tool.MacrosData.data.sYS_USERPRIV || workForm.tool.MacrosData.data.sys_USERPRIV ;
            },
            SYS_USERPRIVOTHER : function(){
                return workForm.tool.MacrosData.data.sYS_USERPRIVOTHER || workForm.tool.MacrosData.data.sys_USERPRIVOTHER;
            },
            SYS_USERNAME_DATE : function(){
                var userName = workForm.tool.MacrosData.data.sYS_USERNAME || workForm.tool.MacrosData.data.sys_USERNAME;
                return userName +' '+new Date().Format("yyyy-MM-dd");
            },
            SYS_USERNAME_DATETIME : function(){
                var userName = workForm.tool.MacrosData.data.sYS_USERNAME || workForm.tool.MacrosData.data.sys_USERNAME;
                return userName +' '+new Date().Format("yyyy-MM-dd hh:mm:ss");
            },
            SYS_FORMNAME : function(){
                return  workForm.option.formName;
            },
            SYS_RUNNAME : function(){
                return  workForm.option.runName;
            },
            SYS_RUNDATE : function(){
                var runDate = workForm.option.runDate
                if(runDate != undefined){
                    // console.log(new Date(workForm.option.runDate).Format('yyyy-MM-dd'))
                    return new Date(workForm.option.runDate).Format('yyyy-MM-dd');//开始日期
                }else{
                    return "{macros}"
                }
                // return new Date(workForm.option.runDate).Format('yyyy-MM-dd');//开始日期
            },
            SYS_RUNDATETIME : function(){
                return  workForm.option.runDate;//开始日期+时间
            },
            SYS_RUNID : function(){
                return  workForm.option.runId;//开始日期
            },
            SYS_AUTONUM : function(){
                return workForm.tool.MacrosData.data.sYS_AUTONUM || workForm.tool.MacrosData.data.sys_AUTONUM;
            },
            SYS_AUTONUM_YEAR : function(){
                return workForm.tool.MacrosData.data.sYS_AUTONUM_YEAR || workForm.tool.MacrosData.data.sys_AUTONUM_YEAR  ;
            },
            SYS_AUTONUM_MONTH : function(){
                return workForm.tool.MacrosData.data.sYS_AUTONUM_MONTH || workForm.tool.MacrosData.data.sys_AUTONUM_MONTH ;
            },
            SYS_IP : function(){
                return workForm.tool.MacrosData.data.sYS_IP || workForm.tool.MacrosData.data.sys_IP;
            },
            SYS_MANAGER1 : function(){

                return workForm.tool.MacrosData.data.sYS_MANAGER1 || workForm.tool.MacrosData.data.sys_MANAGER1;
            },
            SYS_MANAGER2 : function(){
                return workForm.tool.MacrosData.data.sYS_MANAGER2 || workForm.tool.MacrosData.data.sys_MANAGER2;
            },
            SYS_MANAGER3 : function(){
                return  workForm.tool.MacrosData.data.sYS_MANAGER3 || workForm.tool.MacrosData.data.sys_MANAGER3;
            },
            SYS_CODE : function(target){
                return '';
            },
            SYS_SQL : function(target){
                if(target != undefined){
                    var sysSql = workForm.tool.MacrosData.data.sYS_SQL || workForm.tool.MacrosData.data.sys_SQL;
                    if(sysSql!=undefined &&sysSql!=""){
                        var sql = sysSql[target];
                        if(sql!=undefined){
                            var str=""
                            for(var i=0;i<sql.length;i++){
                                for(var key in sql[i]){
                                    if(i < sql.length-1){
                                        str += sql[i][key]+',';
                                    }else{
                                        str += sql[i][key];
                                    }
                                }
                            }
                            return str;
                        }
                    }else{
                        return ''
                    }
                }
            },

            SYS_DATE:function(){
                return new Date().Format("yyyy-MM-dd");
            },
            SYS_DATE_HMS1:function(){
                return new Date().Format("yyyy-MM-dd hh:mm:ss");
            },
            SYS_FLOWSTARTTIME:function () {
                return  workForm.option.flowRun.beginTime;
            },
            SYS_FLOWENDTIME:function () {
                return  workForm.option.flowRun.endTime;
            },
            SYS_FLOWNAME:function () {
                return  workForm.option.runName;
            },
            SYS_FLOWRUNID:function () {
                return  workForm.option.runId;
            },
            SYS_FLOWSTARTUSERNAME:function () {
                return  workForm.option.flowRun.userName;
            },
            SYS_FLOWSTARTUSERID:function () {
                return  workForm.option.flowRun.beginUser;
            },
            SYS_FLOWSIGN:function () {
                return huiqian;
            },
            SYS_FLOW_CONNECTFLOW: function(){
                var connectFlowData = workForm.tool.MacrosData.data.sYS_FLOW_CONNECTFLOW || workForm.tool.MacrosData.data.sys_FLOW_CONNECTFLOW || '';
                var obj = {type: 1, str: ''}
                if (connectFlowData) {
                    obj.type = 2;
                    var str = '<ul>' +
                        '<li style="color: #000;"><span>关联流程：</span><a class="open_flow_work" href="javascript:;" runid="'+connectFlowData.runId+'" flowid="'+connectFlowData.flowId+'" style="text-decoration: none; color: #2567d6;">'+connectFlowData.runName+'</a></li>' +
                        '<li style="color: #000;"><span>流转节点：</span><span>'+(connectFlowData.allUserName || '')+'</span></li>' +
                        '<li style="color: #000;"><span>说<span style="display: inline-block;text-indent: 2em;color: #000;">明：</span></span><span>关联流程中已审核通过的领导节点，本流程可跳过</span></li>' +
                        '</ul>';
                    obj.str = str;
                }
                return obj;
            },
            SYS_NEWS: function(){
                var newsData = workForm.tool.MacrosData.data.sYS_NEWS || workForm.tool.MacrosData.data.sys_NEWS ||'';
                var str = '';
                if (newsData) {
                    str = '<a class="edit_news_content" style="color: #2567d6;text-decoration: none;" href="javascript:;" newsid="'+newsData.newsId+'">'+newsData.subject+'</a>'
                }
                return str;
            },
            ready:function(options,cb,flag,val,stepType,stepValue,sql,sqlList){
                // console.log(val)
                var that = this;
                if(val !=undefined||val != null){
                    var prcsId = 1
                    var flowPrcs = 1
                }else{
                    if(workForm.option.flowRunPrcs == undefined){
                        var prcsId=""
                    }else{
                        var prcsId = workForm.option.flowRunPrcs.prcsId;
                    }
                    if(workForm.option.flowRunPrcs == undefined){
                        var flowPrcs=""
                    }else{
                        var flowPrcs = workForm.option.flowRunPrcs.flowPrcs
                    }

                }
                if(workForm.option.flowRun.flowId == undefined){
                    var flowId = ""
                }else{
                    var flowId = workForm.option.flowRun.flowId;
                }

                if(workForm.option.flowRun.runId == undefined){
                    var runId = ""
                }else{
                    var runId = workForm.option.flowRun.runId
                }

                if(stepType == undefined||stepType == null){ // 处理宏标记控件-根据设置的实际步骤和设计步骤号，查找相应步骤会签的功能
                    stepType = workForm.option.stepType;
                    stepValue = workForm.option.stepValue;
                }

                $.ajax({
                    type: "get",
                    async: false,
                    url: "/form/qureyCtrl?controlId=Macro&option="+options+'&flowId='+flowId+'&runId='+runId+'&prcsId='+prcsId+'&flowPrcs='+flowPrcs+'&'+stepType+'='+stepValue+'&sql='+encodeURI(sql)+'&sqlList='+encodeURI(sqlList),
                    dataType: 'JSON',
                    success: function (res) {
                        that["data"] = res.object;
                        if(!flag){
                            cb(that);
                        }
                    }
                })
            }
        },
        getMacrosData:function(flag){
            if(this.MacrosData[flag]){
                return this.MacrosData[flag];
            }else{
                return this.MacrosData['SYS_DATE'];
            }

        },
        getFormDatasKeyValue:function(){
            var radioArr = {};
            var formitems = [];
            var form_item = workForm.option.eleObject.find('.form_item');
            for(var i=0;i<form_item.length;i++){
                var value="";
                var obj = form_item.eq(i);

                var datatype = obj.attr("data-type");
                var key=obj.attr("title");
                if(datatype=="select"){
                    value= obj.val()==0?'':form_item.eq(i).val();
                }else if(datatype=="textarea" || datatype=="text"  || datatype=="countersignature_item"){
                    value=obj.val();
                }else if(datatype=="checkbox"){
                    if(obj.is(':checked')){
                        value = '1';
                    }else{
                        value = '0'
                    }
                }else if(datatype=="macros"){
                    if(obj.attr('type') == "text"){
                        value= obj.val();
                    }else{
                        if(obj.val() > -1){
                            value = obj.val()+'_'+obj.find("option:selected").text();
                        }
                    }
                }else if(datatype == "radio"){
                    var name = obj.attr('name');
                    if(!radioArr[obj.attr('name')]){
                        radioArr[obj.attr('name')] = true;
                        if($("input[name='"+name+"']:checked").length>0){
                            value= $("input[name='"+name+"']:checked").val();
                        }else{
                            value = "";
                        }
                    }else{
                        continue;
                    }
                }else if(datatype == "macrossign") {
                    value = obj.html();
                    var height = obj.css('height');
                    obj.css({'height': 'auto', 'min-height': height + 'px'})

                }else if(datatype == "fileupload"){

                }else if(datatype == "imgupload"){

                }else if(datatype == "sign"){
                    var pre = obj.prev();
                    if(pre.length != 0)
                        // value = Mustache.render(pre.html(),{content:''});
                        $(pre).find('.eiderarea').eq($(pre).find('.eiderarea').length-1).find('.sign_content').text('')
                }else if(datatype == "userselect"){
                    value= (obj.attr('user_id')||'')+'|'+ (obj.attr('username')||'');
                }else if(datatype == "deptselect"){
                    value= (obj.attr('deptid') || '')+'|'+(obj.attr('deptname')||'');
                }else if(datatype == "kgsign"){
                    value = (obj.attr('signatureId') || '');
                }else if(datatype == "listing"){

                }else if(datatype == 'readcomments'){
                    value = obj.val();
                }else if(datatype == 'calculation'){
                    value = obj.val();
                }else{
                    value = obj.val();
                }
                var item = {
                    value:value,
                    id:obj.attr('id'),
                    title:obj.attr('title')
                }
                formitems.push(item);
            };
            return formitems;
        },
        renderListDeaultTd:function(rawIndex,lv_cal,lv_coltype,lv_colvalue,lv_size,lv_sum,lv_defaultVal){
            var flowId = workForm.option.flowRun.flowId;
            var length = lv_cal.length
            var tdStr = '';
            for(var i=0;i<lv_colvalue.length;i++){
                var type = lv_coltype[i];

                if(type){
                    var classStr = 'total ';
                    var datavalue = '';
                    var lv_callIndex = '['+(i+1)+']';
                    var lv_callString = lv_cal.join(',') || '';
                    if(lv_sum && lv_sum[i] == '1'){
                        classStr += ' sum_'+(i+1);
                    }
                    if(lv_callIndex && lv_callString.indexOf(lv_callIndex) > -1){
                        classStr += ' formula';
                        classStr += ' call_'+(i+1);
                    }
                    if(lv_cal && lv_cal[i] != ''){
                        type = 'formula';
                    }
                    // console.log(workForm.option)
                    if(workForm.option.preView && workForm.option.prcsId != undefined){ //判断表单预览情况下和查看详情的区别
                        type = 'preview';
                    }
                    if(lv_defaultVal && lv_defaultVal.length > 0 ){
                        if(lv_coltype[i]=="select"&&lv_defaultVal[i]==""){
                            datavalue=""
                        }else{
                            datavalue = lv_defaultVal[i] || lv_colvalue[i];
                        }

                    }else{
                        if(lv_colvalue[i] && lv_colvalue[i].indexOf('|')>-1){
                            datavalue = lv_colvalue[i].split('|')[1];
                        }
                    }

                    // console.log(type)
                    if(type){
                        switch (type){
                            case 'text':
                                //预算
                                if(workForm.option.tableName == 'budget' && length == 10 && i == 8){ //针对支票领用表单的特殊处理，对于列表控件中最后一个td项目id进行隐藏
                                    tdStr+='<td id="col_'+i+'" listtype="text" ><input sid="'+(i+1)+'" class=" '+classStr+'" type="hidden" value="'+datavalue+'" title="'+datavalue+'"  style="width: '+lv_size[i]+'px"></td>';
                                }else if(workForm.option.tableName == 'budget' && length == 10 && i != 7 && i!= 8){
                                    tdStr+='<td id="col_'+i+'" listtype="text" ><input sid="'+(i+1)+'" class=" '+classStr+'" disabled="disabled" type="text" value="'+datavalue+'" title="'+datavalue+'"  style="width: '+lv_size[i]+'px"></td>';
                                }else{
                                    tdStr+='<td id="col_'+i+'" listtype="text" ><input sid="'+(i+1)+'" class=" '+classStr+'" type="text" value="'+datavalue+'"  title="'+datavalue+'" style="width: '+lv_size[i]+'px"></td>';
                                }
                                break;
                            case 'textarea':
                                tdStr+='<td id="col_'+i+'" listtype="textarea"><textarea  sid="'+(i+1)+'" class=" '+classStr+'"  value="'+ datavalue +'" title="'+datavalue+'"  style="width: '+lv_size[i]+'px">'+datavalue+'</textarea></td>';
                                break;
                            case 'countersignature_item':
                                tdStr+='<td id="col_'+i+'" listtype="textarea"><textarea  sid="'+(i+1)+'" class=" '+classStr+'"  value="'+ datavalue +'" title="'+datavalue+'"  style="width: '+lv_size[i]+'px">'+datavalue+'</textarea></td>';
                                break;
                            case 'select':
                                var optionValue = lv_colvalue[i].split('|')[0].split(',');
                                var optionDefaultSelected = datavalue;
                                var optionValueStr = '';
                                optionValue.forEach(function (v,i) {
                                    if(v == optionDefaultSelected){
                                        optionValueStr += '<option selected value="'+v+'">'+v+'</option>';
                                    }else{
                                        optionValueStr += '<option value="'+v+'">'+v+'</option>';
                                    }
                                });
                                tdStr+='<td id="col_'+i+'" listtype="select" ><select sid="'+(i+1)+'" class=" '+classStr+'" style="width: '+lv_size[i]+'px">'+optionValueStr+'</select></td>';
                                break;
                            case 'radio':
                                var radioStr = lv_colvalue[i];
                                var radioValue = radioStr.split('|')[0].split(',');
                                var radioDefaultSelected =  datavalue;
                                var radioValueStr = '';
                                radioValue.forEach(function (v,index) {
                                    if(v == radioDefaultSelected){
                                        radioValueStr += (v+'<input checked="checked" value="'+v+'" name="r'+rawIndex+'_r'+i+'" id="'+v+'"  type="radio">');
                                    }else{
                                        radioValueStr += (v+'<input value="'+v+'" name="r'+rawIndex+'_r'+i+'" id="'+v+'" type="radio">');
                                    }
                                });
                                tdStr+=('<td id="col_'+i+'" listtype="radio">'+radioValueStr+'</td>');
                                break;
                            case 'checkbox':
                                var checkboxValue = lv_colvalue[i].split('|')[0].split(',');
                                var checkboxDefaultSelected = datavalue.split(',');
                                var checkboxValueStr = '';
                                checkboxValue.forEach(function (v,i) {
                                    if($.inArray(v, checkboxDefaultSelected) > -1){
                                        checkboxValueStr += (v+'<input checked="checked" value="'+v+'" id="'+v+'" name="r'+rawIndex+'_r'+i+'"  type="checkbox">&nbsp;');
                                    }else{
                                        checkboxValueStr += (v+'<input value="'+v+'" id="'+v+'" name="r'+rawIndex+'_r'+i+'"  type="checkbox">&nbsp;');
                                    }
                                });
                                tdStr+=('<td id="col_'+i+'" listtype="checkbox">'+checkboxValueStr+'</td>');
                                break;
                            case 'datetime':
                                // console.log(datavalue);
                                tdStr+='<td id="col_'+i+'" listtype="datetime"><input readonly="readonly" sid="'+(i+1)+'"   class="laydate-icon list_date '+classStr+'" type="text" value="'+datavalue+'"  style="padding: 0px 0px;cursor: pointer;width: '+lv_size[i]+'px" class=""   date_format="YYYY-MM-DD" ></td>';
                                break;
                            case 'dateAndTime':
                                tdStr+='<td id="col_'+i+'" listtype="dateAndTime"><input readonly="readonly" sid="'+(i+1)+'"   class="laydate-icon list_date '+classStr+'" type="text" value="'+datavalue+'"  style="padding: 0px 0px;cursor: pointer;width: '+lv_size[i]+'px" class=""   date_format="YYYY-MM-DD hh:mm:ss" ></td>';
                                break;
                            case 'formula':
                                var lv_calStr = ''
                                var lv_caldefaultSize = 0;
                                if(lv_cal[i].indexOf('|')>-1){
                                    lv_caldefaultSize = lv_cal[i].split('|')[1];
                                    lv_calStr = lv_cal[i].split('|')[0];
                                }else{
                                    lv_calStr = lv_cal[i];
                                }
                                var lv_caldefaultSizeVal = parseFloat(0).toFixed(lv_caldefaultSize);
                                tdStr+='<td listtype="formula"  sid="'+(i+1)+'" class="lv_cal '+classStr+'"  id="col_'+i+'" formula="'+lv_calStr+'" lv_caldefaultSizeVal="'+lv_caldefaultSizeVal+'" lv_caldefaultSize="'+lv_caldefaultSize+'" class="lv_cal ">'+( datavalue || lv_caldefaultSizeVal)+'</td>';
                                break;
                            case 'preview':
                                //预算
                                if(workForm.option.tableName == 'budget' && length == 10 && i == 8) { //针对支票领用表单的特殊处理，对于列表控件中最后一个td项目id进行隐藏
                                    tdStr+='<td id="col_'+i+'" ><input type="text" style="visibility: hidden;width:0px" value="'+datavalue+'"></td>';
                                }else{
                                    datavalue = datavalue.replace(/\r\n/g, '<br/>').replace(/\n/g, '<br/>').replace(/ /g, '&nbsp;');
                                    if(lv_sum[i] == 1){
                                        var num = datavalue;
                                        datavalue *= 1;
                                        if(window.isNaN(datavalue)){
                                            // 判断经过计算转换后是否是NaN，排除是string类型
                                            datavalue = num;
                                        }else{
                                            datavalue = datavalue.toLocaleString();
                                        }
                                    }
                                    tdStr+='<td id="col_'+i+'" ><div style="'+ function(){
                                        if(lv_coltype[i] == 'textarea'){
                                            return 'text-align: left;'
                                        }else{
                                            return ''
                                        }
                                    }() +'">'+datavalue +'</div></span></td>';
                                }

                                break;
                            default:
                                tdStr+='<td id="col_'+i+'" ><input type="text"></td>';
                        }
                    }
                }

            }
            return tdStr;
        },
        buildListPluData:function (tableObj,listdata,obj) {
            var trStr = "";
            var addtr ='<td><a style="" title=del class="delete_row" href="javascript:void(0)"><img src="/img/workflow/delete.png"></a></td>';
            if(listdata.indexOf('|') > -1){
                var lv_sumValue = listdata.split('|')[1].split('`');;
                listdata = listdata.split('|')[0];
            }
            var lv_coltype = tableObj.attr('lv_coltype').split('`');
            var lv_colvalue =  tableObj.attr('lv_colvalue').split('`');
            var lv_size = tableObj.attr('lv_size').split('`');
            var lv_sum = tableObj.attr('lv_sum').split('`');
            var lv_cal = tableObj.attr('lv_cal').split('`');
            var dataId = tableObj[0].id;
            var flowId = workForm.option.flowRun.flowId;
            if(listdata!=""){
                //预算
                listdata.split('\r\n').forEach(function(v,i){
                    if(v){
                        var lv_defaultVal = v.split('`');
                        var tdstr = obj.tool.renderListDeaultTd(i,lv_cal,lv_coltype,lv_colvalue,lv_size,lv_sum,lv_defaultVal);

                        trStr+=('<tr id="row_'+i+'">'+addtr+'<td>'+(i+1)+'</td>'+function(){
                            if((workForm.option.tableName == 'budget' && dataId == 'DATA_225') || (workForm.option.tableName == 'budget' && dataId == 'DATA_227')){
                                return '<td>'+
                                    '<span  onclick="xmkj($(this),1)" class="addItem"  style="display:'+function(){if(workForm.option.resdata.preView==1){return 'none'}else{return 'block'}}()+';color:#4889f0;font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;cursor:pointer">&nbsp;添加项目 </span>'+
                                    '<span  onclick="xmxq($(this),1)"  style="disp lay:block;color:#4889f0;font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;cursor:pointer">&nbsp;项目详情 </span>'+
                                    '</td>'
                            }else{
                                return ''
                            }
                        }()+tdstr+'</tr>');



                    }


                });
            }

            if((workForm.option.tableName == 'budget' && dataId == 'DATA_225') || (workForm.option.tableName == 'budget' && dataId == 'DATA_227')){
                var tdSum = '<td class="sumtitle">合计</td><td class="sumtitle"></td><td class="sumtitle"></td>';
            }else{
                var tdSum = '<td class="sumtitle">合计</td><td class="sumtitle"></td>';
            }

            tableObj.attr('lv_coltype').split('`').forEach(function(v,i){
                if(v){
                    if(lv_sum[i] == '1'){
                        tdSum += '<td class="total_'+(i+1)+'">'+function(){
                            if(lv_sumValue == undefined){
                                return ''
                            }else{
                                var num = lv_sumValue[i] * 1;
                                if(window.isNaN(num)){
                                    // 判断经过计算转换后是否是NaN，排除是string类型
                                    num = lv_sumValue[i];
                                }else{
                                    if(workForm.option.preView){ // 在查看详情页面时，列表控件中的数字项使用千分符
                                        num = num.toLocaleString();
                                    }
                                }
                                return num;
                            }
                        }()+'</td>;'
                    }else{
                        tdSum += '<td></td>';
                    }
                }
            });
            tdSum = '<tr class="listsum">'+tdSum+'</tr>';
            var listheadStr = tableObj.find('.listhead').prop("outerHTML");
            tableObj.find('.listfoot').siblings().remove();
            tableObj.find('.listfoot').before(listheadStr+trStr+tdSum);

            if(workForm.option.tableName == 'budget' && dataId == 'DATA_225' &&  workForm.option.footShow != 1){

                if(listdata == ""||listdata == "``````0``"){
                    var lv_defaultVal = listdata.split('`');
                    var tdstr = obj.tool.renderListDeaultTd(0,lv_cal,lv_coltype,lv_colvalue,lv_size,lv_sum,lv_defaultVal);
                    trStr+=('<tr id="row_0">'+addtr+'<td>'+1+'</td>'+function(){
                        if(workForm.option.tableName == 'budget' && dataId == 'DATA_225'){
                            return '<td>'+
                                '<span  onclick="xmkj($(this),1)" class="addItem"  style="display:'+function(){if(workForm.option.resdata.preView==1){return 'none'}else{return 'block'}}()+';color:#4889f0;font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;cursor:pointer">&nbsp;添加项目 </span>'+
                                '<span  onclick="xmxq($(this),1)"  style="disp lay:block;color:#4889f0;font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;cursor:pointer">&nbsp;项目详情 </span>'+
                                '</td>'
                        }else{
                            return ''
                        }
                    }()+tdstr+'</tr>');
                    // console.log($('#'+dataId))
                    tableObj.find('.listhead').after(trStr)

                    // $('#DATA_227').find('.listhead').after(trStr)
                    $.ajax({
                        url:'/budget/selBudgetItemByIdFlow',
                        data:{budgetId:workForm.option.budgeId,runId:$.GetRequest().runId},
                        dataType:'json',
                        type:'get',
                        beforeSend : function(request) {
                            if(beforeToken != ''){
                                request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
                            }
                        },
                        success:function(res){
                            var data=res.object;
                            if(data != undefined){
                                // console.log($('#DATA_246').val())
                                $('#DATA_225 #row_0').find('td').eq(3).find('input').val(data.lineNo)
                                $('#DATA_225 #row_0').find('td').eq(4).find('input').val(data.budgetItemName)
                                $('#DATA_225 #row_0').find('td').eq(5).find('input').val(data.itemManagerName)
                                $('#DATA_225 #row_0').find('td').eq(6).find('input').val(data.itemMoney)
                                $('#DATA_225 #row_0').find('td').eq(7).find('input').val(data.actualExpenditure)
                                $('#DATA_225 #row_0').find('td').eq(8).find('input').val(data.allAdvance)
                                $('#DATA_225 #row_0').find('td').eq(9).text(data.remainingAmount)
                                $('#DATA_225 #row_0').find('td').eq(10).find('input').val($('#DATA_246').val())
                                $('#DATA_225 #row_0').find('td').eq(11).find('input').val(data.budgetId)
                                $('#DATA_225').find('.sum_8').trigger('propertychange')
                                if(Number($('#DATA_246').val())>Number(data.remainingAmount)){
                                    $.layerMsg({content:'申请金额不能大于可用金额',icon:2,time:6000});
                                }
                            }

                        }
                    })
                }
            }
            if(workForm.option.tableName == 'budget' && dataId == 'DATA_227' &&  workForm.option.footShow != 1){
                if(listdata == ""||listdata == "``````0``"){
                    var dataName = workForm.option.dataName['DATA_225'];
                    if(dataName != "" && dataName != undefined){
                        var trspilt = dataName.split('|')[0];
                        var trs = trspilt.split('\r\n');
                        var sum=0;
                        trs.forEach(function(v,i){
                            var lv_defaultVal = listdata.split('`');
                            lv_colvalue = v.split('`');
                            var tdstr = obj.tool.renderListDeaultTd(i,lv_cal,lv_coltype,lv_colvalue,lv_size,lv_sum,lv_defaultVal);

                            sum+=Number(lv_colvalue[7])
                            trStr+=('<tr id="row_'+i+'">'+addtr+'<td>'+(i+1)+'</td>'+function(){
                                if(workForm.option.tableName == 'budget' && dataId == 'DATA_227'){
                                    return '<td>'+
                                        '<span  onclick="xmkj($(this),1)" class="addItem"  style="display:'+function(){if(workForm.option.resdata.preView==1){return 'none'}else{return 'block'}}()+';color:#4889f0;font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;cursor:pointer">&nbsp;添加项目 </span>'+
                                        '<span  onclick="xmxq($(this),1)"  style="disp lay:block;color:#4889f0;font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;cursor:pointer">&nbsp;项目详情 </span>'+
                                        '</td>'
                                }else{
                                    return ''
                                }
                            }()+tdstr+'</tr>');
                        })
                        tableObj.find('.listhead').after(trStr)


                        if(workForm.option.resdata.preView==1){
                            // console.log(DX(1111))
                            if(sum!=0&&!isNaN(sum)){
                                tableObj.find('.total_8').text(sum.toFixed(2))
                                tableObj.parents('tr').prev().find('#DATA_204').val(sum.toFixed(2))
                                // tableObj.parents('tr').prev().find('#DATA_204').trigger('propertychange')
                                tableObj.parents('tr').prev().find('#DATA_204').prev().text(sum.toFixed(2))
                                tableObj.parents('tr').prev().find('#DATA_229').parent().text(DX(sum))
                            }
                        }
                        if(trStr!=""){
                            var len = tableObj.find('.sum_8').length;
                            for(var j=0;j<len;j++){
                                if(Number(tableObj.find('.sum_8').eq(j).val())>Number(tableObj.find('.sum_8').eq(j).parent().prev().text())){
                                    $.layerMsg({content:'申请金额不能大于可用金额',icon:2})
                                    return ;
                                }
                            }
                        }
                    }
                }
            }
            function DX(n) {
                if (!/^(0|[1-9]\d*)(\.\d+)?$/.test(n))
                    return "数据非法";
                var unit = "千百拾亿千百拾万千百拾元角分", str = "";
                n += "00";
                var p = n.indexOf('.');
                if (p >= 0)
                    n = n.substring(0, p) + n.substr(p+1, 2);
                unit = unit.substr(unit.length - n.length);
                for (var i=0; i < n.length; i++)
                    str += '零壹贰叁肆伍陆柒捌玖'.charAt(n.charAt(i)) + unit.charAt(i);
                return str.replace(/零(千|百|拾|角)/g, "零").replace(/(零)+/g, "零").replace(/零(万|亿|元)/g, "$1").replace(/(亿)万|壹(拾)/g, "$1$2").replace(/^元零?|零分/g, "").replace(/元$/g, "元整");
            }

        },
        iconImgType:{
            txt : '/img/icon_file.png',
            jpg : '/img/icon_image.png',
            png : '/img/icon_image.png',
            pdf :  '/img/icon_pdf.png',
            ppt : '/img/icon_ppt.png',
            pptx :  '/img/icon_ppt.png',
            doc : '/img/icon_word.png',
            docx : '/img/icon_word.png',
            xls :  '/img/icon_excel.png',
            xlsx :  '/img/icon_excel.png'

        },
        popUserSelect:function(target){
            user_id = target;
            $.popWindow(domain+"/common/selectUser");
        },
        ajaxHtml:function (url,data,cb) {

            var that = this;
            $.ajax({
                type: "get",
                url: url,
                async:false,
                dataType: 'JSON',
                data:  data,
                success: function (res) {
                    if(cb){
                        cb(res);
                    }
                },
                error:function(e){
                    // console.log(e);
                }
            });
        },
        Date_format:function(date, format)
        {
            date = date.split(/\D/);
            format = format.split(/[^yMdhHms]+/);
            var real_format = 'y-M-d H:m:s';
            for(var k in format)
            {
                if((/([yMdhHms])+/).test(format[k]))
                {
                    // 兼容两位年份的情况
                    if(format[k]=='y' || format[k]=='yy')
                    {
                        if(78<=date[k] && 99>=date[k])
                        {
                            date[k] = '19' + date[k];
                        }
                        else
                        {
                            date[k] = '20' + date[k];
                        }
                    }
                    real_format = real_format.replace(RegExp.$1, date[k]);
                }
            }
            var date_now = new Date();
            var o =
                {
                    "M+" : date_now.getMonth()+1, //month
                    "d+" : date_now.getDate(),    //day
                    "h+" : '00',   //hour
                    "H+" : '00',   //hour
                    "m+" : '00', //minute
                    "s+" : '00' //second
                    // "q+" : Math.floor((date_now.getMonth()+3)/3),  //quarter
                    // "S" : date_now.getMilliseconds() //millisecond
                };
            if(/(y+)/.test(real_format))
            {
                real_format = real_format.replace(RegExp.$1,(date_now.getFullYear().toString()));
            }
            for(var k in o)
                if(new RegExp("("+ k +")").test(real_format))
                    real_format = real_format.replace(RegExp.$1,RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length));
            return real_format;
        }
    }
}
function delCB(signatureid, signData){
    if(Signature.list != null && Signature.list[signatureid] != null){
        var signatureCreator = Signature.create();
        var position = signData.position
        //console.log(signData.position);
        for(var key in position){
            $('#'+key).find('img').show();
            $('#'+key).find('button').show();
        }
        var a = signatureCreator.removeSignature(signData.documentid, signatureid);
    }
    return true;
}

function upperJSONKey(jsonObj){
    for (var key in jsonObj){
        if(key.indexOf('data') > -1){
            jsonObj[key.toUpperCase()] = jsonObj[key];
            delete(jsonObj[key]);
        }

    }
    return jsonObj;
}
function checkNumber(theObj) {
    var regPos = /^\d+(\.\d+)?$/; //非负浮点数
    var regNeg = /^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$/;
    if(regPos.test(theObj) || regNeg.test(theObj)){
        return true;
    }
    return false;
}

eval(function(p,a,c,k,e,d){e=function(c){return(c<a?"":e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1;};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p;}('m f(a,b){d c=\'\';3(a){g{c=i(a);3(2(c).h()!=\'8\'&&9(c)){c=2(c).4(b)}5 3(a.6("7")>-1||a.6("j")>-1){}5{c=2(0).4(b)}}l(e){c=2(0).4(b)}}k c}',23,23,'||parseFloat|if|toFixed|else|indexOf|RMB|NaN|checkNumber||||var||execC|try|toString|eval|DATE|return|catch|function'.split('|'),0,{}))

eval(function(p,a,c,k,e,d){e=function(c){return(c<a?"":e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1;};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p;}('5 9(0,8){6 4=b;3(0&&0.a(\',\')>-1){6 7=0.f(\',\');7.g(5(2,c){3(2){3(2==8){4=d}}})}e 4}',17,17,'str||v|if|flag|function|var|StrArray|target|checkStrIn|indexOf|false|i|true|return|split|forEach'.split('|'),0,{}))
eval(function(p,a,c,k,e,d){e=function(c){return(c<a?"":e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1;};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p;}('4 5(0){3(0&&0!=2&&0!=\'\'){6{1 9.a(0)}7(8){1\'\'}}}',11,11,'opt|return|null|if|function|ABS|try|catch|e|Math|abs'.split('|'),0,{}))
eval(function(p,a,c,k,e,d){e=function(c){return(c<a?"":e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1;};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p;}('b 8(){6 3=0;5(2.4>0){9.7(2.4);c(6 1=0;1<2.4;1++){5(2[1]){5(2[1]>3){3=2[1]}}}}a 3}',13,13,'|i|arguments|max|length|if|var|log|MAX|console|return|function|for'.split('|'),0,{}))
eval(function(p,a,c,k,e,d){e=function(c){return(c<a?"":e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1;};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p;}('d 9(){5 2=0;a(3.7>0){2=3[0];8(5 4=1;4<3.7;4++){5 6=3[4];6<2?2=6:c}}b 2}',14,14,'||minN|arguments|i|var|cur|length|for|MIN|if|return|null|function'.split('|'),0,{}))
eval(function(p,a,c,k,e,d){e=function(c){return(c<a?"":e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1;};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p;}('9 8(){3 4=0;3 5=0;7(1.6>0){b(3 2=0;2<1.6;2++){5+=1[2]}4=(5/1.6)}a 4}',12,12,'|arguments|i|var|avg|sum|length|if|AVG|function|return|for'.split('|'),0,{}))
eval(function(p,a,c,k,e,d){e=function(c){return(c<a?"":e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1;};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p;}('8 5(1){3(1<=0){2 0}3(1&&!4(1)){2 1/ 7 /6}2 0}',9,9,'|timestamp|return|if|isNaN|DAY|24|3600|function'.split('|'),0,{}))
eval(function(p,a,c,k,e,d){e=function(c){return(c<a?"":e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1;};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p;}('7 4(1){3(1&&!5(1)){2 1/6}2 0}',8,8,'|timestamp|return|if|HOUR|isNaN|3600|function'.split('|'),0,{}))
//eval(function(p,a,c,k,e,d){e=function(c){return(c<a?"":e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1;};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p;}('o h(2){g(2&&!i(2)){1 e=3.7(2/(9*4));1 5=2%(9*4);1 d=3.7(5/(4));1 6=5%(4*n);1 c=3.7(6/(a));1 b=6%(a);1 f=3.p(b);8 e+"m"+d+"j"+c+"k"+f+"l"}8 0}',26,26,'|var|timestamp|Math|3600|leave1|leave2|floor|return|24|60|leave3|minutes|hours|days|seconds|if|DATE|isNaN|小时|分钟|秒|天|1000|function|round'.split('|'),0,{}))
eval(function(p,a,c,k,e,d){e=function(c){return(c<a?"":e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1;};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p;}('m h(2){g(2&&!i(2)){1 e=3.7(2/(9*4));1 5=2%(9*4);1 d=3.7(5/(4));1 6=5%(4);1 c=3.7(6/(a));1 b=6%(a);1 f=3.n(b);8 e+"o"+d+"j"+c+"k"+f+"l"}8 0}',25,25,'|var|timestamp|Math|3600|leave1|leave2|floor|return|24|60|leave3|minutes|hours|days|seconds|if|DATE|isNaN|小时|分钟|秒|function|round|天'.split('|'),0,{}));

//eval(function(p,a,c,k,e,d){e=function(c){return(c<a?"":e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1;};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p;}('I J(6){2 9=e g(\'H\',\'F\',\'G\',\'K\',\'O\',\'P\',\'N\',\'L\',\'M\',\'x\');2 o=e g(\'\',\'z\',\'D\',\'C\');2 s=e g(\'\',\'A\',\'B\',\'y\');2 u=e g(\'E\',\'Y\',\'X\',\'W\');2 b=\'12\';2 f=\'11\';2 r=Z.S;2 8;2 7;2 5=\'\';2 d;3(6==\'\'){c\'\'}6=R(6);3(6>=r){c\'\'}3(6==0){5=9[0]+f+b;c 5}6=6.Q();3(6.V(\'.\')==-1){8=6;7=\'\'}h{d=6.U(\'.\');8=d[0];7=d[1].k(0,4)}3(l(8,10)>0){2 a=0;2 j=8.w;v(2 i=0;i<j;i++){2 n=8.k(i,1);2 p=j-i-1;2 q=p/4;2 m=p%4;3(n==\'0\'){a++}h{3(a>0){5+=9[0]}a=0;5+=9[l(n)]+o[m]}3(m==0&&a<4){5+=s[q]}}5+=f}3(7!=\'\'){2 t=7.w;v(2 i=0;i<t;i++){2 n=7.k(i,1);3(n!=\'0\'){5+=9[T(n)]+u[i]}}}3(5==\'\'){5+=9[0]+f+b}h 3(7==\'\'){5+=b}c 5}',62,65,'||var|if||chineseStr|money|decimalNum|integerNum|cnNums|zeroCount|cnInteger|return|parts|new|cnIntLast|Array|else||IntLen|substr|parseInt|||cnIntRadice|||maxNum|cnIntUnits|decLen|cnDecUnits|for|length|玖|兆|拾|万|亿|仟|佰|角|壹|贰|零|function|RMB|叁|柒|捌|陆|肆|伍|toString|parseFloat|9999|Number|split|indexOf|厘|毫|分|999999999999999||元|整'.split('|'),0,{}))
// eval(function(p,a,c,k,e,d){e=function(c){return(c<a?"":e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1;};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p;}('A z(n){2 a=[\'v\',\'w\'];2 b=[\'3\',\'u\',\'r\',\'t\',\'B\',\'x\',\'y\',\'h\',\'m\',\'o\'];2 5=[[\'e\',\'q\',\'l\'],[\'\',\'k\',\'H\',\'G\']];2 f=n<0?\'J\':\'\';n=7.I(n);2 s=\'\';9(2 i=0;i<a.c;i++){s+=(b[7.8(n*6*7.D(6,i))%6]+a[i]).4(/3./,\'\')}s=s||\'d\';n=7.8(n);9(2 i=0;i<5[0].c&&n>0;i++){2 p=\'\';9(2 j=0;j<5[1].c&&n>0;j++){p=b[n%6]+5[1][j]+p;n=7.8(n/6)}s=p.4(/(3.)*3$/,\'\').4(/^$/,\'3\')+5[0][i]+s}E f+s.4(/(3.)*F/,\'e\').4(/(3.)+/g,\'3\').4(/^d$/,\'C\')}',46,46,'||var|零|replace|unit|10|Math|floor|for|fraction|digit|length|整|元|head||柒|||拾|亿|捌||玖||万|贰||叁|壹|角|分|伍|陆|RMB|function|肆|零元整|pow|return|零元|仟|佰|abs|负'.split('|'),0,{}))
eval(function(p,a,c,k,e,d){e=function(c){return(c<a?"":e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1;};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p;}('w x(n){2 b=[\'v\',\'t\'];2 c=[\'3\',\'u\',\'B\',\'C\',\'A\',\'y\',\'z\',\'q\',\'k\',\'o\'];2 7=[[\'f\',\'m\',\'r\'],[\'\',\'l\',\'I\',\'H\']];2 h=n<0?\'K\':\'\';n=4.J(n);2 s=\'\';d(2 i=0;i<b.a;i++){s+=(c[4.8(4.8(n*9*6*4.E(6,i))%(6*9)/ 9)] + b[i]).5(/3./,\'\')}s=s||\'e\';n=4.8(n);d(2 i=0;i<7[0].a&&n>0;i++){2 p=\'\';d(2 j=0;j<7[1].a&&n>0;j++){p=c[n%6]+7[1][j]+p;n=4.8(n/6)}s=p.5(/(3.)*3$/,\'\').5(/^$/,\'3\')+7[0][i]+s}F h+s.5(/(3.)*G/,\'f\').5(/(3.)+/g,\'3\').5(/^e$/,\'D\')}',47,47,'||var|零|Math|replace|10|unit|floor|1000|length|fraction|digit|for|整|元||head|||捌|拾|万||玖||柒|亿||分|壹|角|function|RMB|伍|陆|肆|贰|叁|零元整|pow|return|零元|仟|佰|abs|欠'.split('|'),0,{}))

eval(function(p,a,c,k,e,d){e=function(c){return(c<a?"":e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1;};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p;}('z 1c(e){2 l=0;2 s=9.8.p||\'\';2 f={};2 d=[];2 h=9.8.j.Q(\'.L\');4(h){h.M(z(i,v){2 w=$(v);2 6=w.J(\'K\');4(6){4(!f[6]){f[6]=1;d.P(6)}}})}4(s&&s.t>5){2 k=9.8.p.N(5,1);4(k==\'X\'){4(d.t>O){2 s=\'<3 b="    g: I;q: B;7: E D;G-A: #C;H-F: R;1a-19: c c c #11;1b: 16;15-18: 17;">\\n\'+\'        <3 o="1f" b="x: a;g: u;q: u;7-y: 1g;7-a: 1d;">\\n\'+\'            <m 1e="/m/V/W.Y">\\n\'+\'        </3>\\n\'+\'        <3 o="r" 6="r" b="x: a;A: #S;T-U: 12;7-y: 13;7-a: 14;g: Z;">\'+9.8.10+\'</3>\\n\'+\'    </3>\';9.8.j=$(s)}}}}',62,79,'||var|div|if||id|margin|option|workForm|left|style|3px|arr||map|width|items||eleObject|||img||class|snum|height|TXT||length|75px||_0|float|top|function|color|150px|357ece|auto|135px|radius|background|border|460px|attr|name|form_item|each|substr|50|push|find|10px|fff|font|size|sys|icon64_info||png|306px|tip|2F5C8F|16pt|49px|20px|text|hidden|center|align|shadow|box|overflow|readynum|30px|src|IMG|37px'.split('|'),0,{}))


function toPoint(percent){
    var str=percent.replace("%","");
    str= str/100;
    return str;
}

$(document).on('click','#signImg',function(){
    signBtn('#' + $(this).siblings('textarea').attr('id'))
})
// 删除会签意见
$(document).on('click', '.remove_sign', function(){
    var $this = $(this);
    $.layerConfirm({title: '确定删除', content: '您确定要删除吗?', icon: 0}, function () {
        var $pre = $this.parent().parent();
        var dataKey = $pre.siblings('textarea').attr('name');
        var timeStamp = $this.parents('.eiderarea').attr('time_stamp') || '';
        $.post('/workflow/work/deleteOpinion', {
            flowId: workForm.option.flowRun.flowId,
            runId: workForm.option.flowRun.runId,
            data: dataKey,
            timeStamp: timeStamp
        }, function (res) {
            layer.closeAll();
            if (res.flag) {
                $.layerMsg({content: '意见删除成功', icon: 1});
                var $templ = $('<div>' + $pre.attr('templ') + '</div>');
                var $tv = $('<div>' + $pre.attr('tv') + '</div>');
                var index = $this.parent().index();
                $templ.find('.eiderarea').eq(index).remove();
                $pre.attr('templ', $templ.html());
                $tv.find('.eiderarea').eq(index).remove();
                $pre.attr('tv', $tv.html());
                $this.parents('.eiderarea').remove();
            } else {
                $.layerMsg({content: '意见删除失败', icon: 2});
            }
        });
    });
});
//监听input，改列表控件的input加上title的属性
$(document).on('change','td[listtype="text"] input[type="text"]',function () {
    var that = this;
    var txt = $(that).val();
    $(that).attr("title",txt)
})
//监听textarea，改列表控件的textarea加上title的属性
$(document).on('change','td[listtype="textarea"] textarea',function () {
    var that = this;
    var txt = $(that).val();
    $(that).attr("title",txt)
})

function initSign(prcsId,flowPrcs,runId,screenType){
    if(screenType == '1'){
        var checkdata = {
            prcsId:flowPrcs,
            signlock:signlock,
            flowPrcs:prcsId,
            runId:runId,
            checkDept: '1'
        }
    }else{
        var checkdata = {
            prcsId:flowPrcs,
            signlock:signlock,
            flowPrcs:prcsId,
            runId:runId,
            checkDept: '0'
        }
    }
    $.ajax({
        type: "post",
        url: "/workflow/work/findworkfeedback",
        dataType: 'JSON',
        data: checkdata,
        success: function (obj) {
            var user = $.cookie('userId')
            //当前登陆人
            var userName = ''
            var userIdlike = ''
            $.ajax({
                url: '/Meetequipment/getuser',
                type: 'get',
                dataType: 'json',
                async:false,
                success: function (res) {
                    userName = res.object.userName
                    userIdlike = res.object.userId
                }
            })
            if(obj.flag){
                if(obj.obj.length!=0){
                    globalData.data = obj.obj;
                    var replyHq = []
                    var hqLi = []
                    for(var a=0;a<obj.obj.length;a++){
                        if(obj.obj[a].replyId == 0 ){
                            //会签意见
                            hqLi.push(obj.obj[a])
                        }else {
                            //回复意见
                            replyHq.push(obj.obj[a])
                        }
                    }
                    //遍历寻找回复的会签
                    for(var b=0;b<hqLi.length;b++){
                        hqLi[b].replyId =[]
                        for(var c=0;c<replyHq.length;c++){
                            if(replyHq[c].replyId == hqLi[b].feedId){
                                hqLi[b].replyId.push(replyHq[c])
                            }
                        }
                    }
                    var str = '';
                    var obj_obj = hqLi

                    hqLi.forEach(function (v,i) {
                        var prcsflow = v.flowPrcs;
                        var avatar = v.users.avatar;
                        if(hqLi[i].feedFlag == 2){
                            var feedFlagstr = '<h1 style="font-weight: 600;color: red;">回退意见：</h1>';
                        }else{
                            var feedFlagstr = '';
                        }
                        if (avatar==0){
                            avatar = 'boy.png'

                        }else if(avatar==1){
                            avatar = 'girl.png'

                        }

                        //前一天
                        var leet = getNextDate(new Date(),-1)
                        //当前
                        var newTime = getNextDate(new Date(),0)

                        if (hqLi[i].feedType == 1){
                            srcImg = '/img/workflow/work/add_work/tongyi2.png'
                            yiyue = '同意'
                            colorHq= '#5FB878'

                        }else if (hqLi[i].feedType == 2){
                            srcImg = '/ui/img/workflow/form/dsAgree.png'
                            yiyue = '不同意'
                            colorHq= 'red'
                        }else {
                            srcImg = '/ui/img/workflow/form/read.png'
                            yiyue = '已阅'
                            colorHq= '#5caeee'
                        }
                        var attachmentList = hqLi[i].list
                        var strfile = ''
                        var openNmu3 = -1
                        var openimg = ''
                        var attachFile = ''
                        var attachFile0 = ''
                        if(attachmentList !=undefined && attachmentList.length>0) {
                            for (var m = 0; m < attachmentList.length; m++) {
                                var fileExtension = attachmentList[m].attachName.substring(attachmentList[m].attachName.lastIndexOf(".") + 1, attachmentList[m].attachName.length);//截取附件文件后缀
                                var attName = encodeURI(attachmentList[m].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                var deUrl = attachmentList[m].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + attachmentList[m].size;
                                var domain = document.location.origin;
                                if (getFileIsPic(fileExtension)) {
                                    openimg += domain + '/xs?' + deUrl + '*'
                                    // strOpenImg ='<img   openNmu = "'+openNmu+'"  class="operation"  src="'+domain+deUrl+'" style="margin-left: 10px;display: none" attrurl="' + deUrl + '" href="javascript:;"></img>';
                                }
                            }
                        }

                        if(attachmentList !=undefined && attachmentList.length>0){
                            for(var j=0;j<attachmentList.length;j++){
                                var fileExtension=attachmentList[j].attachName.substring(attachmentList[j].attachName.lastIndexOf(".")+1,attachmentList[j].attachName.length);//截取附件文件后缀
                                var attName = encodeURI(attachmentList[j].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                var deUrl = attachmentList[j].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+attachmentList[j].size;
                                var imgTu = ''
                                if(getFileIsPic(fileExtension)) {
                                    openNmu3++
                                    imgTu = '<img openimg ="'+openimg+'"  openNmu = "'+openNmu3+'"  class="operation2"  src="'+domain+deUrl+'" style="margin-left: 10px;display: none" attrurl="' + deUrl + '" href="javascript:;"></img>'

                                }else{
                                    imgTu = ''
                                }

                                if(fileExtension == 'aac'){
                                    var domain = document.location.origin;
                                    var attachmentListaudio =domain+'/download?'+ attachmentList[j].attUrl
                                    attachFile0 =
                                        ' <p id="dialogue" style="position:relative;margin-bottom:10px" src="' + attachmentList[j].attUrl + '" idH5="' + attachmentList[j].attachId + '" bofang="1"  onclick="playaudioH5($(this))">' +
                                        '<span id="bofang"><img class="dialogue11" thisH5="' +attachmentList[j].attachId + '"   style="width: 100px;height: 20px;margin-top: 10px" src="/ui/img/workflow/form/mobile/dialogue.png" /></img></span>' +
                                        '<span style="position: absolute;top: 8px;left: 8px"><img class="dialogue22"   style="width: 15px;" src="/ui/img/workflow/form/mobile/voice.png"/></img></span>' +
                                        '<span>' +
                                        ' <span class="box111" style="display: none; position: absolute;top: -5px;left: 21px;   ">\n' +
                                        '        <span class="wifi-symbol" style="display: inline-block;overflow: hidden;position: relative;">\n' +
                                        '            <span style="display: inline-block" class="wifi-circle first"></span>\n' +
                                        '            <span style="display: inline-block" class="wifi-circle second"></span>\n' +
                                        '            <span style="display: inline-block" class="wifi-circle third"></span>\n' +
                                        '        </span>\n' +
                                        '    </span>\n' +
                                        '</span>' +
                                        '</p>'

                                    attachFile ='<audio style="width: 100%;height: 40px;display: none;" class="audio1" id="audio+'+j+'" src="'+attachmentListaudio+'" controls="controls"><source src="'+attachmentListaudio+'" type="audio/mpeg">'+
                                        '</audio>'
                                    // attachFile = '<input type="file" id="file" onchange="onInputFileChange()">\n' +
                                    //     '<audio id="audio_id" controls autoplay loop>Your browser cant support HTML5 Audio</audio>'
                                }else{
                                    strfile += '<div class="fujianBlo" style="position: relative;height:30px;word-break: break-all;margin-bottom: 10px;" class="dech"   attachId="' + attachmentList[j].attachId + '" name="' + attachmentList[j].attachName + '" fileSize="' + attachmentList[j].size + '">' +
                                        '<a  href="/download?'+encodeURI(deUrl)+'" NAME="' + attachmentList[j].attachName + '*" style="text-decoration:none;margin-left:5px;color: #207BD6">' +
                                        '<img  src="/img/attachment_icon.png"/>' + attachmentList[j].attachName + '</a>' +
                                        '<ul class="dech fujianUl" deUrl="' + deUrl+ '" style="    position: absolute; right: 10px;    top: -26px;line-height: 20px;   z-index: 999;    border: 1px solid #e8e8e8;    width: 84px;background: white;display:none;">' +
                                        '<p deUrl="'+deUrl+'" class= "dech lookImg" openNmu="'+openNmu3+'" atturl="' + deUrl + '" onclick="preview($(this),1)">' +
                                        '<a fileExtension="'+fileExtension+'"    href="javascript:;"  style="padding-left: 5px;color: #207BD6">' +
                                        '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
                                        '</p>' +
                                        '<p deUrl="'+deUrl+'" class= "dech lookImg" openNmu="'+openNmu3+'">' +
                                        '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))" deUrl="'+deUrl+'"   href="javascript:;"  style="padding-left: 5px;color: #207BD6">' +
                                        '<img src="/img/attachmentIcon/attachPreview.png" style="padding: 0 5px;">查阅</a>' +
                                        '</p>' +
                                        '<p>' +
                                        '<a style="padding-left: 3px;color: #207BD6" href="/download?'+encodeURI(deUrl)+'" >' +
                                        '<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;color: #207BD6">下载</a>' +
                                        '</p>' +
                                        '<p>' +
                                        '<a style="padding-left: 13px;color: #207BD6" class="deImgs"  deImgsHq = "1"><img  style="    margin-right: 10px;" src="/img/file/icon_deletecha_03.png"/>删除</a>' +
                                        '</p>' +
                                        '</ul>' +
                                        ''+imgTu+''+
                                        '<input type="hidden" class="inHidden" value="' + attachmentList[j].aid + '@' + attachmentList[j].ym + '_' + attachmentList[j].attachId + ',">' +
                                        '</div>';
                                }

                            }
                        }else{
                            strfile='';
                        }

                        if(leet ==hqLi[i].editTime.split(' ')[0]){
                            timeTday = '昨天 '+'<span style="display: inline-block;padding: 0 2px">  </span>'+hqLi[i].editTime.split(' ')[1]
                        }else if(newTime == hqLi[i].editTime.split(' ')[0]){
                            timeTday = '今天 '+'<span style="display: inline-block;padding: 0 2px">  </span>'+hqLi[i].editTime.split(' ')[1]
                        }else {
                            timeTday =hqLi[i].editTime.split(" ")[0] +'<span style="display: inline-block;padding: 0 2px">  </span>'+hqLi[i].editTime.split(" ")[1]
                        }

                        //回复
                        var hqhuifu = ''
                        if(hqLi[i].replyId.length != 0){

                            var replyId = hqLi[i].replyId
                            var timeTday2 = ''
                            for(var d=0;d<replyId.length;d++){
                                var avatar2 = replyId[d].users.avatar;
                                if (avatar2==0){
                                    avatar2 = 'boy.png'
                                }else if(avatar2==1){
                                    avatar2 = 'girl.png'
                                }
                                //回复时间
                                if(leet == replyId[d].editTime.split(' ')[0]){
                                    timeTday2 = '昨天 '+'<span style="display: inline-block;padding: 0 2px">  </span>'+replyId[d].editTime.split(' ')[1]
                                }else if(newTime == replyId[d].editTime.split(' ')[0]){
                                    timeTday2 = '今天 '+'<span style="display: inline-block;padding: 0 2px">  </span>'+replyId[d].editTime.split(' ')[1]
                                }else {
                                    timeTday2 = replyId[d].editTime.split(" ")[0] +'<span style="display: inline-block;padding: 0 2px">  </span>'+replyId[d].editTime.split(" ")[1]
                                }

                                hqhuifu += '<li class="replayHq" style=" border: none;font-size: 13px;margin-bottom:10px;position:relative" id="'+replyId[d].feedId+'" userNameHq = "'+replyId[d].userId+'"> ' +
                                    '<img style="width:28px;    position: absolute;    left: -20px;    border-radius: 50%;" src="/img/user/'+ avatar2 +'">' +
                                    '<p style="font-weight: bold;padding-left: 13px;    color: black;">'+replyId[d].users.userName+'' +
                                    '<span class="del" replayHq = "2" dellength="0" style="position: relative;top:-2px;"><img style="width:16px" src="/img/workflow/work/del2.png" alt=""></span>'+
                                    '</p>' +
                                    '<p style="    margin-left: 13px;    color: #999;">'+replyId[d].users.deptName+
                                    '<span style="margin-left: 10px;">'+'第'+replyId[d].prcsId+'步</span>' +
                                    '<span style="margin-left: 10px;">'+''+replyId[d].prcsName+'</span>' +
                                    '</p>' +
                                    '<p style="margin: 8px;color:black;    padding-left: 6px;">'+replyId[d].content+'</p>' +
                                    '<p style="margin-left: 14px;color:#999;">'+timeTday2+'</p>' +
                                    '</li>'
                            }
                            // $('.hqhuifu').css('border','1px solid #999')
                            $('.hqhuifu').css('margin-bottom','10px')

                        }else{
                            hqhuifu = ''
                            $('.hqhuifu').css('border','none')

                        }
                        //点赞人员
                        var likeIdsName = ''
                        var likeIds = ''
                        if(hqLi[i].likeIdsName != undefined){
                            likeIdsName = hqLi[i].likeIdsName
                            likeIds = hqLi[i].likeIds
                        }

                        var likeArr = likeIdsName.split(',')
                        var likeArrid = likeIds.split(',')
                        var likeBlock = 'block'
                        var likeBlock2 = 'none'
                        var likeText = ''
                        var dznumber = '';
                        if(likeArr.length>0 && likeArr[0] != ''){
                            dznumber = likeArr.length
                            for(var e=0;e<likeArr.length;e++){
                                likeText+='<span style="position: relative;top:2px;font-size:2px"><svg style="width:14px" t="1610006155617" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2619" width="16" height="16"><path d="M884.875894 423.143253 646.970506 423.143253c92.185562-340.464205-63.516616-357.853247-63.516616-357.853247-65.993017 0-52.312436 52.182476-57.3031 60.881602 0 166.502152-176.849824 296.971645-176.849824 296.971645l0 472.171899c0 46.607504 63.516616 63.393819 88.433098 63.393819l357.452111 0c33.641191 0 61.036122-88.224344 61.036122-88.224344 88.434122-300.70569 88.434122-390.177444 88.434122-390.177444C944.657442 418.179195 884.875894 423.143253 884.875894 423.143253L884.875894 423.143253 884.875894 423.143253zM884.875894 423.143253" p-id="2620" fill="#8a8a8a"></path><path d="M251.671415 423.299819 109.214912 423.299819c-29.420053 0-29.873378 28.89612-29.873378 28.89612l29.420053 476.202703c0 30.309306 30.361495 30.309306 30.361495 30.309306L262.420223 958.707948c25.686009 0 25.458835-20.049638 25.458835-20.049638L287.879058 459.411271C287.879058 422.837284 251.671415 423.299819 251.671415 423.299819L251.671415 423.299819 251.671415 423.299819zM251.671415 423.299819" p-id="2621" fill="#8a8a8a"></path></svg></span>'+likeArr[e]
                                if(userIdlike == likeArrid[e]){
                                    likeBlock = 'none'
                                    likeBlock2 = 'block'
                                }else {
                                    likeBlock = 'block'
                                    likeBlock2 = 'none'
                                }
                            }
                        }

                        //选人
                        var toIds = ''
                        var toIdsArr = ''
                        if(hqLi[i].toIds != undefined && hqLi[i].toIds.replace(/\s/g, "") != ''){
                            toIds = hqLi[i].toIdsName
                            toIdsArr = toIds.split(',')
                        }else {
                            toIds = ''
                        }

                        var toIdsText = ''
                        if(toIdsArr.length>0 && toIdsArr[0] != ''){
                            for(var g=0;g<toIdsArr.length;g++){
                                toIdsText+='@'+toIdsArr[g]+'<span style="padding-right:5px"></span>'
                            }

                        }
                        var edidHq = ''
                        if(prcsId == prcsflow && user == hqLi[i].userId){
                            edidHq =  '<span class="edit"><img style="width:18px" src="/img/workflow/work/edit2.png" alt="">' +
                                '</span><span class="del" replayHq = "1" dellength="'+hqLi[i].replyId.length+'"><img style="width:18px" src="/img/workflow/work/del2.png" alt=""></span>'
                        }else{
                            edidHq =  ''
                        }

                        //手写
                        var base64 = ''
                        if(hqLi[i].signData != "[]" && hqLi[i].signData != '') {
                            if(hqLi[i].signData.substring(0,3) == '/xs'){
                                var imgUrl30 = hqLi[i].signData.split(",")
                                var deUrl = ''
                                for (var a = 0; a < imgUrl30.length-1; a++) {
                                    deUrl=imgUrl30[a].split('?')[1]
                                    base64 += '<p class="showDiv"  style="display: inline-block"><img onclick="showImg(this,2)" deUrl="'+deUrl+'" update="2" datatype="1"   showDiv = "1" style="width: 50px;height:50px;margin-right: 10px" src="' + imgUrl30[a] + '" alt=""></p>'
                                }
                            }else{
                                var imgUrl = hqLi[i].signData
                                var imgUrl1 = imgUrl.substr(imgUrl.length-1,2)
                                var imgUrl2 = imgUrl.substring(1,imgUrl.length-1);
                                var imgUrl3 = imgUrl2.split(",")
                                if(imgUrl3.length != 0 && imgUrl3 != undefined){
                                    for(var a=0;a<imgUrl3.length;a++){
                                        base64+=  '<p class="showDiv"  style="    display: inline-block;"><img onclick="showImg(this,2)" deUrl="'+deUrl+'" showDiv = "1" style="width: 50px;height:50px;margin-right: 10px" src="data:image/png;base64,'+imgUrl3[a]+'" alt=""></p>'

                                    }
                                }
                            }
                        }

                        str +=
                            '<li id="'+hqLi[i].feedId+'" flowNum="'+prcsflow+'" flowPrcs="'+hqLi[i].flowPrcs+'" runId="'+hqLi[i].runId+'" userNameHq = "'+hqLi[i].userId+'">' +
                            '<div class="huiqian_touxiang" style="width:30px">' +
                            '<img class="huiqian_logo" style="width: 35px;margin-top: 8px;border-radius: 50%;" src="/img/user/'+ avatar +'">' +
                            '</div>' +
                            '<div class="huiqian_word" style="width: 80%;">'+feedFlagstr+'' +

                            '<div style="    display: flex;">' +
                            '<h1 style="display: inline-block;font-weight: 600;    color: black;">'+hqLi[i].users.userName+'</h1>' +
                            '<div  id="timeStr1">' +
                            '<span style="font-size: 14px;position: relative;top: 8px;left: 10px;color:'+colorHq+'"><img style="width: 15px;margin-right: 4px;" src="'+srcImg+'">'+yiyue+'</span>' +
                            '<span style="position: relative;right: -15px;top:9px;color: #5caeee">'+edidHq+'</span>'+
                            '</div>\n'+
                            '</div>'+
                            '<p style="margin-top:5px;color: #999;font-size: 13px">'+hqLi[i].users.deptName+'' +
                            '<span style="margin-left: 10px;">'+'第'+hqLi[i].prcsId+'步</span>' +
                            '<span style="margin-left: 10px;">'+''+hqLi[i].prcsName+'</span>' +
                            '</p>' +
                            '<div class="area" style="display:none">' +
                            '<textarea name="" id="signTextBj" style="width:80%;height:35px"></textarea></div>' +
                            '<div class="cesdiv"  title="'+hqLi[i].content+'" style="color: black;font-size:13px;    width: auto;">'+hqLi[i].content+'' +
                            '</div>' +
                            '<p style = "font-size:13px"><span style="">'+toIdsText+'</span><p>' +
                            '<p>'+attachFile0+'</p>' +
                            '<p class="datasyuyin">'+attachFile+'</p>' +
                            '<p>'+base64+'</p>' +
                            '<div style="font-size: 12px;margin-bottom: 10px;">' +strfile+'</div>'+
                            '<div class="h2s" style="font-size: 13px;margin-top: 1px;margin-bottom:0;">'+timeTday+
                            '<span style="cursor:pointer;right: 19px;top: -9px;display:'+likeBlock+';" id="'+hqLi[i].feedId+'" display= "none" class="thumbs-up"><svg style="width:16px" t="1609811158657" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2577" width="32" height="32"><path d="M884.875894 423.143253 646.970506 423.143253c92.185562-340.464205-63.516616-357.853247-63.516616-357.853247-65.993017 0-52.312436 52.182476-57.3031 60.881602 0 166.502152-176.849824 296.971645-176.849824 296.971645l0 472.171899c0 46.607504 63.516616 63.393819 88.433098 63.393819l357.452111 0c33.641191 0 61.036122-88.224344 61.036122-88.224344 88.434122-300.70569 88.434122-390.177444 88.434122-390.177444C944.657442 418.179195 884.875894 423.143253 884.875894 423.143253L884.875894 423.143253 884.875894 423.143253zM884.875894 423.143253" p-id="2578" fill="#bfbfbf"></path><path d="M251.671415 423.299819 109.214912 423.299819c-29.420053 0-29.873378 28.89612-29.873378 28.89612l29.420053 476.202703c0 30.309306 30.361495 30.309306 30.361495 30.309306L262.420223 958.707948c25.686009 0 25.458835-20.049638 25.458835-20.049638L287.879058 459.411271C287.879058 422.837284 251.671415 423.299819 251.671415 423.299819L251.671415 423.299819 251.671415 423.299819zM251.671415 423.299819" p-id="2579" fill="#bfbfbf"></path></svg></span>' +
                            '<span style="cursor:pointer;right: 19px;top: -9px;display:'+likeBlock2+';" id="'+hqLi[i].feedId+'" display= "block" class="thumbs-up thumbs-up2"><svg style="width:16px" t="1609834510019" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2675" width="32" height="32"><path d="M884.875894 423.143253 646.970506 423.143253c92.185562-340.464205-63.516616-357.853247-63.516616-357.853247-65.993017 0-52.312436 52.182476-57.3031 60.881602 0 166.502152-176.849824 296.971645-176.849824 296.971645l0 472.171899c0 46.607504 63.516616 63.393819 88.433098 63.393819l357.452111 0c33.641191 0 61.036122-88.224344 61.036122-88.224344 88.434122-300.70569 88.434122-390.177444 88.434122-390.177444C944.657442 418.179195 884.875894 423.143253 884.875894 423.143253L884.875894 423.143253 884.875894 423.143253zM884.875894 423.143253" p-id="2676" fill="#1296db"></path><path d="M251.671415 423.299819 109.214912 423.299819c-29.420053 0-29.873378 28.89612-29.873378 28.89612l29.420053 476.202703c0 30.309306 30.361495 30.309306 30.361495 30.309306L262.420223 958.707948c25.686009 0 25.458835-20.049638 25.458835-20.049638L287.879058 459.411271C287.879058 422.837284 251.671415 423.299819 251.671415 423.299819L251.671415 423.299819 251.671415 423.299819zM251.671415 423.299819" p-id="2677" fill="#1296db"></path></svg></span>'+
                            '<span style="cursor:pointer;right: 47px;top: -6px;" id="'+hqLi[i].feedId+'" class="reply"><svg style="width:14px" t="1609811871802" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="6571" width="32" height="32"><path d="M0 198.777l0 433.692c0 84.328 68.266 152.595 152.595 152.595l228.895 0 8.032 192.753L614.4 785.064l257.003 0c84.328 0 152.595-68.266 152.595-152.595L1023.998 198.777c0-84.328-68.266-152.595-152.595-152.595L152.599 46.182c-84.328 0-152.595 68.266-152.595 152.595L0 198.777zM658.57 439.717c0-40.158 32.125-72.282 72.282-72.282 40.157 0 72.282 32.125 72.282 72.282 0 40.158-32.125 72.282-72.282 72.282C690.694 511.999 658.57 479.874 658.57 439.717L658.57 439.717zM437.708 439.717c0-40.158 32.125-72.282 72.282-72.282s72.282 32.125 72.282 72.282c0 40.158-32.125 72.282-72.282 72.282C469.832 511.999 437.708 479.874 437.708 439.717zM220.864 439.717c0-40.158 32.125-72.282 72.282-72.282s72.282 32.125 72.282 72.282c0 40.158-32.125 72.282-72.282 72.282C252.987 511.999 220.864 479.874 220.864 439.717z" p-id="6572" fill="#bfbfbf"></path></svg></span>' +
                            '<span style="font-size: 12px;" class="dzNmuber" title="'+dznumber+'">'+dznumber+'<span>'+
                            '</div>' +
                            '<p style = "font-size:13px" class="likeDz">'+likeText+'</p>' +
                            '<ul class="hqhuifu" style="margin-bottom:10px;">'+hqhuifu+'</ul>' +
                            '</div>' +
                            '</li>';

                    });
                    $('#signbox').html(str)
                    // $('#signbox').append(strOpenImg)
                    var lengthNum = obj.obj.length-replyHq.length
                    if(lengthNum>0){
                        $('.huiqian').append('<div class="he huiqianhe">'+lengthNum+'</div>');
                    }

                }else{
                    $('#signbox').html('')
                    globalData.data = "";
                    if (feedback == '1') {
                        $('#hui').hide()
                        $('#hqblock').css('display','none')
                        $('#hqblock2').css('display','none')
                    }
                }
            }



            //回复
            $('.reply').click(function(){
                var replyId = $(this).attr('id')
                layer.open({
                    type: 1,
                    title: ['回复', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['440px', '260px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['确定', '取消'],
                    content:'' +
                        ' <textarea style="height: 91%;width: 92%;margin:5px auto" placeholder="请输入回复内容" class="layui-textarea replyIdText"></textarea>' +
                        '',
                    success: function () {
                        $('.replyIdText').focus()
                    },
                    yes:function(index){
                        if($('.replyIdText').val() == ''){
                            $.layerMsg({content:'请输入回复意见',icon:1});
                            layer.closeAll();
                            return false
                        }
                        $.ajax({
                            type: "get",
                            url: "workfeedback",
                            // url:"/workflow/work/insertFRFMobile",
                            dataType: 'JSON',
                            data: {
                                prcsId: globalData.flowRunPrcs.prcsId,
                                flowPrcs: flowPrcs,
                                runId: runId,
                                content: $('.replyIdText').val(),
                                file: '',
                                feedFlag: '0',
                                feedType: '',
                                attachmentId: '',
                                attachmentName: '',
                                replyId:replyId,
                                toIds:'',
                                secretType:'0',
                            },
                            success: function (obj) {
                                $.layerMsg({content:'保存成功',icon:1});
                                layer.closeAll();
                                initSign(prcsId,flowPrcs,runId);
                            }
                        })
                    }
                })
            })

            //点赞
            $('.thumbs-up').click(function(){
                var dzblock = $(this).attr('display')
                var feedId = $(this).attr('id')
                var flag = ''
                if(dzblock == 'none'){
                    $(this).css('display','none')
                    $(this).next().css('display','block')
                    flag =1
                    var userNamelike = '<span style="position: relative;top:2px;font-size:2px"><svg style="width:14px" t="1610006155617" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2619" width="16" height="16"><path d="M884.875894 423.143253 646.970506 423.143253c92.185562-340.464205-63.516616-357.853247-63.516616-357.853247-65.993017 0-52.312436 52.182476-57.3031 60.881602 0 166.502152-176.849824 296.971645-176.849824 296.971645l0 472.171899c0 46.607504 63.516616 63.393819 88.433098 63.393819l357.452111 0c33.641191 0 61.036122-88.224344 61.036122-88.224344 88.434122-300.70569 88.434122-390.177444 88.434122-390.177444C944.657442 418.179195 884.875894 423.143253 884.875894 423.143253L884.875894 423.143253 884.875894 423.143253zM884.875894 423.143253" p-id="2620" fill="#8a8a8a"></path><path d="M251.671415 423.299819 109.214912 423.299819c-29.420053 0-29.873378 28.89612-29.873378 28.89612l29.420053 476.202703c0 30.309306 30.361495 30.309306 30.361495 30.309306L262.420223 958.707948c25.686009 0 25.458835-20.049638 25.458835-20.049638L287.879058 459.411271C287.879058 422.837284 251.671415 423.299819 251.671415 423.299819L251.671415 423.299819 251.671415 423.299819zM251.671415 423.299819" p-id="2621" fill="#8a8a8a"></path></svg></span>'+userName
                    $(this).parent().next().append(userNamelike)
                    var likeN = ''
                    if($(this).parent().find('.dzNmuber').attr('title') == ''){
                        likeN = 0
                    }else{
                        likeN = $(this).parent().find('.dzNmuber').attr('title')
                    }
                    var numbeilike = parseInt(likeN)+1
                    if(numbeilike >0){
                        $(this).parent().find('.dzNmuber').html(numbeilike)
                    }
                }else {
                    $(this).prev().css('display','block')
                    $(this).css('display','none')
                    flag = 0
                    initSign(prcsId,flowPrcs,runId);
                }
                $.ajax({
                    type: "get",
                    url: "/workflow/work/addLike",
                    // url:"/workflow/work/insertFRFMobile",
                    dataType: 'JSON',
                    data: {
                        feedId:feedId,
                        flag:flag
                    },
                    success: function (obj) {
                        // $.layerMsg({content:'操作成功',icon:1});
                    }
                })


            })

            //    附件操作显示
            $(".fujianBlo").mouseover(function() {
                $(this).find('.fujianUl').css('display','block')
                $(this).css('background','#e8e8e8')
            });
            $(".fujianBlo").mouseleave(function() {
                $(this).find('.fujianUl').css('display','none')
                // $(this).css('display','none')
                $(this).css('background','none')
            });
            $('.operation2').prev().find('.lookImg').addClass('operationImg2')

            // $('#audio1').click(function(){
            //     audio.play();
            // })

        }
    });
};
// function onInputFileChange() {
//     var file = document.getElementById('file').files[0];
//     var url = URL.createObjectURL(file);
//     console.log(url);
//     document.getElementById("audio_id").src = url
// }
//与我相关
function aboutMe() {

    $.ajax({
        type: "post",
        url: "/workflow/work/getToIds",
        dataType: 'JSON',
        page: true,
        data:{
            runId:runId
        },
        success: function (obj) {
            var replynone = ''
            var str = ''
            var datas = obj.obj;
            for(var i=0;i<obj.obj.length;i++){

                var avatar = obj.obj[i].users.avatar;
                if (avatar==0){
                    avatar = 'boy.png'
                }else if(avatar==1){
                    avatar = 'girl.png'
                }
                //前一天
                var leet = getNextDate(new Date(),-1)
                //当前
                var newTime = getNextDate(new Date(),0)

                if (obj.obj[i].feedType == 1){
                    srcImg = '/img/workflow/work/add_work/tongyi2.png'
                    yiyue = '同意'
                    colorHq= '#5FB878'
                }else if (obj.obj[i].feedType == 2){
                    srcImg = '/ui/img/workflow/form/dsAgree.png'
                    yiyue = '不同意'
                    colorHq= 'red'
                }else {
                    srcImg = '/ui/img/workflow/form/read.png'
                    yiyue = '已阅'
                    colorHq= '#5caeee'
                }

                var attachmentList = obj.obj[i].list
                var strfile = ''
                var openNmu3 = -1
                var openimg = ''
                var attachFile = ''
                var attachFile0 = ''
                if(attachmentList !=undefined && attachmentList.length>0) {
                    for (var m = 0; m < attachmentList.length; m++) {
                        var fileExtension = attachmentList[m].attachName.substring(attachmentList[m].attachName.lastIndexOf(".") + 1, attachmentList[m].attachName.length);//截取附件文件后缀
                        var attName = encodeURI(attachmentList[m].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                        var deUrl = attachmentList[m].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + attachmentList[m].size;
                        var domain = document.location.origin;
                        if (getFileIsPic(fileExtension)) {
                            openimg += domain + '/xs?' + deUrl + '*'
                            // strOpenImg ='<img   openNmu = "'+openNmu+'"  class="operation"  src="'+domain+deUrl+'" style="margin-left: 10px;display: none" attrurl="' + deUrl + '" href="javascript:;"></img>';
                        }
                    }
                }

                if(attachmentList !=undefined && attachmentList.length>0){
                    for(var j=0;j<attachmentList.length;j++){
                        var fileExtension=attachmentList[j].attachName.substring(attachmentList[j].attachName.lastIndexOf(".")+1,attachmentList[j].attachName.length);//截取附件文件后缀
                        var attName = encodeURI(attachmentList[j].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                        var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                        var deUrl = attachmentList[j].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+attachmentList[j].size;
                        var imgTu = ''
                        if(getFileIsPic(fileExtension)) {
                            openNmu3++
                            imgTu = '<img openimg ="'+openimg+'"  openNmu = "'+openNmu3+'"  class="operation2"  src="'+domain+deUrl+'" style="margin-left: 10px;display: none" attrurl="' + deUrl + '" href="javascript:;"></img>'

                        }else{
                            imgTu = ''
                        }
                        if(fileExtension == 'aac'){
                            var domain = document.location.origin;
                            var attachmentListaudio =domain+'/download?'+ attachmentList[j].attUrl
                            attachFile0 =
                                ' <p id="dialogue" style="position:relative;margin-bottom:10px" src="' + attachmentList[j].attUrl + '" idH5="' + attachmentList[j].attachId + '" bofang="1"  onclick="playaudioH5($(this))">' +
                                '<span id="bofang"><img class="dialogue11" thisH5="' +attachmentList[j].attachId + '"   style="width: 100px;height: 20px;margin-top: 10px" src="/ui/img/workflow/form/mobile/dialogue.png" /></img></span>' +
                                '<span style="position: absolute;top: 8px;left: 8px"><img class="dialogue22"   style="width: 15px;" src="/ui/img/workflow/form/mobile/voice.png"/></img></span>' +
                                '<span>' +
                                ' <span class="box111" style="display: none; position: absolute;top: -5px;left: 21px;   ">\n' +
                                '        <span class="wifi-symbol" style="display: inline-block;overflow: hidden;position: relative;">\n' +
                                '            <span style="display: inline-block" class="wifi-circle first"></span>\n' +
                                '            <span style="display: inline-block" class="wifi-circle second"></span>\n' +
                                '            <span style="display: inline-block" class="wifi-circle third"></span>\n' +
                                '        </span>\n' +
                                '    </span>\n' +
                                '</span>' +
                                '</p>'

                            attachFile ='<audio style="width: 100%;height: 40px;display: none;" class="audio1" id="audio1Y+'+j+'" src="'+attachmentListaudio+'" controls="controls"><source src="'+attachmentListaudio+'" type="audio/mpeg">'+
                                '</audio>'
                        }else{
                            strfile += '<div class="fujianBlo" style="position: relative;height:30px;word-break: break-all;margin-bottom: 10px;" class="dech"   attachId="' + attachmentList[j].attachId + '" name="' + attachmentList[j].attachName + '" fileSize="' + attachmentList[j].size + '">' +
                                '<a  href="/download?'+encodeURI(deUrl)+'" NAME="' + attachmentList[j].attachName + '*" style="text-decoration:none;margin-left:5px;color: #207BD6">' +
                                '<img  src="/img/attachment_icon.png"/>' + attachmentList[j].attachName + '</a>' +
                                '<ul class="dech fujianUl" deUrl="' + deUrl+ '" style="    position: absolute; right: 10px;    top: -26px;line-height: 20px;   z-index: 999;    border: 1px solid #e8e8e8;    width: 84px;background: white;display:none;">' +

                                '<p deUrl="'+deUrl+'" class= "dech lookImg" openNmu="'+openNmu3+'">' +
                                '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))" deUrl="'+deUrl+'"   href="javascript:;"  style="padding-left: 5px;color: #207BD6">' +
                                '<img src="/img/attachmentIcon/attachPreview.png" style="padding: 0 5px;">查阅</a>' +
                                '</p>' +
                                '<p>' +
                                '<a style="padding-left: 3px;color: #207BD6" href="/download?'+encodeURI(deUrl)+'" >' +
                                '<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;color: #207BD6">下载</a>' +
                                '</p>' +
                                '<p>' +
                                '<a style="padding-left: 13px;color: #207BD6" class="deImgs"  deImgsHq = "1"><img  style="    margin-right: 10px;" src="/img/file/icon_deletecha_03.png"/>删除</a>' +
                                '</p>' +
                                '</ul>' +
                                ''+imgTu+''+
                                '<input type="hidden" class="inHidden" value="' + attachmentList[j].aid + '@' + attachmentList[j].ym + '_' + attachmentList[j].attachId + ',"></div>';
                        }

                    }
                }else{
                    strfile='';
                }

                if(leet == obj.obj[i].editTime.split(' ')[0]){
                    timeTday = '昨天 '+'<span style="display: inline-block;padding: 0 2px">  </span>'+obj.obj[i].editTime.split(' ')[1]
                }else if(newTime == obj.obj[i].editTime.split(' ')[0]){
                    timeTday = '今天 '+'<span style="display: inline-block;padding: 0 2px">  </span>'+obj.obj[i].editTime.split(' ')[1]
                }else {
                    timeTday = obj.obj[i].editTime.split(" ")[0] +'<span style="display: inline-block;padding: 0 2px">  </span>'+obj.obj[i].editTime.split(" ")[1]
                }

                //回复
                var hqhuifu = ''
                if(obj.obj[i].reply.length != 0){
                    var replyId = obj.obj[i].reply
                    var timeTday2 = ''
                    for(var d=0;d<replyId.length;d++){
                        //回复时间
                        if(leet == replyId[d].editTime.split(' ')[0]){
                            timeTday2 = '昨天 '+'<span style="display: inline-block;padding: 0 2px">  </span>'+replyId[d].editTime.split(' ')[1]
                        }else if(newTime == replyId[d].editTime.split(' ')[0]){
                            timeTday2 = '今天 '+'<span style="display: inline-block;padding: 0 2px">  </span>'+replyId[d].editTime.split(' ')[1]
                        }else {
                            timeTday2 = replyId[d].editTime.split(" ")[0] +'<span style="display: inline-block;padding: 0 2px">  </span>'+replyId[d].editTime.split(" ")[1]
                        }
                        var avatar2 = replyId[d].users.avatar;
                        if (avatar2==0){
                            avatar2 = 'boy.png'
                        }else if(avatar2==1){
                            avatar2 = 'girl.png'
                        }

                        hqhuifu += '<li class="replayHq" id="'+replyId[d].feedId+'" userNameHq = "'+replyId[d].userId+'" style=" border: none;font-size: 13px;margin-bottom:10px;    position: relative;" >' +
                            '<img style="width:25px;    border-radius: 50%;    position: absolute;        left: -27px;" src="/img/user/'+ avatar2 +'">' +
                            '<p style="font-weight: bold;padding-left: 5px;font-size: 13px;    color: #333;">'+replyId[d].userName+'' +
                            '<span class="del" dellength="0" replayHq="2" style="position: relative;top:-2px;"><img style="width:16px" src="/img/workflow/work/del2.png" alt=""></span>'+
                            '</p>' +
                            '<p style="padding-left: 5px;font-size: 13px;    color: #999;">'+replyId[d].users.deptName+
                            '<span style="margin-left: 10px;">'+'第'+replyId[d].prcsId+'步</span>' +
                            '<span style="margin-left: 10px;">'+replyId[d].prcsName+'</span>' +
                            '</p>' +
                            '<p style="margin: 8px;color:black;font-size:13px">'+replyId[d].content+'</p>' +
                            '<p style="margin-left: 10px;color:#999;font-size: 13px;">'+timeTday2+'</p>' +
                            '</li>'
                    }
                    // $('.hqhuifu').css('border','1px solid #999')
                    $('.hqhuifu').css('margin-bottom','10px')

                }else{
                    hqhuifu = ''
                    $('.hqhuifu').css('border','none')

                }
                //手写
                var base64 = ''
                if(obj.obj[i].signData != "[]" && obj.obj[i].signData != '') {
                    // var imgUrl3 = obj.obj[i].signData.split(",")
                    // var deUrl = ''
                    // for (var a = 0; a < imgUrl3.length-1; a++) {
                    //     deUrl=imgUrl3[a].split('?')[1]
                    //     base64 += '<p class="showDiv"  style="display: inline-block"><img onclick="showImg(this,2)" deUrl="'+deUrl+'" update="2" datatype="1"   showDiv = "1" style="width: 50px;height:50px" src="' + imgUrl3[a] + '" alt=""></p>'
                    // }
                    if(obj.obj[i].signData.substring(0,3) == '/xs'){
                        var imgUrl30 = obj.obj[i].signData.split(",")
                        var deUrl = ''
                        for (var a = 0; a < imgUrl30.length-1; a++) {
                            deUrl=imgUrl30[a].split('?')[1]
                            base64 += '<p class="showDiv"  style="display: inline-block"><img onclick="showImg(this,2)" deUrl="'+deUrl+'" update="2" datatype="1"   showDiv = "1" style="width: 50px;height:50px;margin-right: 10px" src="' + imgUrl30[a] + '" alt=""></p>'
                        }
                    }else{
                        var imgUrl = obj.obj[i].signData
                        var imgUrl1 = imgUrl.substr(imgUrl.length-1,2)
                        var imgUrl2 = imgUrl.substring(1,imgUrl.length-1);
                        var imgUrl3 = imgUrl2.split(",")
                        if(imgUrl3.length != 0 && imgUrl3 != undefined){
                            for(var a=0;a<imgUrl3.length;a++){
                                base64+=  '<p class="showDiv"  style="    display: inline-block;"><img onclick="showImg(this,2)" deUrl="'+deUrl+'" showDiv = "1" style="width: 50px;height:50px;margin-right: 10px" src="data:image/png;base64,'+imgUrl3[a]+'" alt=""></p>'
                            }
                        }
                    }
                }
                str +=
                    '<li style=" margin: 0;   height: auto;width:90%;    margin: 10px auto;display: flex;border:1px solid #cccccc;   " id="'+obj.obj[i].feedId+'"  flowPrcs="'+obj.obj[i].flowPrcs+'" runId="'+obj.obj[i].runId+'" userNameHq = "'+obj.obj[i].userId+'">' +
                    '<div class="huiqian_touxiang1">' +
                    '<img class="huiqian_logo" style="width: 35px;margin-top: 8px;margin-left:10px;border-radius: 50%;" src="/img/user/'+ avatar +'">' +
                    '</div>' +
                    '<div class="huiqian_word" style="width:92%;">' +
                    '<div style="    display: flex;">' +
                    '<div  id="timeStr1">' +
                    '<h1 style="display: inline-block;font-weight: 600;">'+obj.obj[i].users.userName+'</h1>' +
                    '<span style="font-size: 14px;position: relative;top: 0px;left: 10px;color:'+colorHq+'"><img style="width: 15px;margin-right: 4px;" src="'+srcImg+'">'+yiyue+'</span>' +
                    '<span class="del" replayHq="1"  dellength="'+obj.obj[i].reply.length+'" style="margin-left: 12px;position: relative;top: -2px"><img style="width:16px" src="/img/workflow/work/del2.png" alt=""></span>' +
                    '</div>\n'+
                    '</div>'+
                    '<div class="area" style="display:none">' +
                    '<textarea name="" id="signText" style="width:80%;height:35px"></textarea></div>' +
                    '<p style="color: #999;    font-size: 13px;">'+obj.obj[i].users.deptName+
                    '<span style="margin-left: 10px;">'+'第'+obj.obj[i].prcsId+'步</span>' +
                    '<span style="margin-left: 10px;">'+obj.obj[i].prcsName+'</span>' +
                    '</p>' +
                    '<div class="cesdiv"  title="'+obj.obj[i].content+'" style="color: black;font-size:14px">'+obj.obj[i].content+'</div>' +
                    '<p>'+attachFile0+'</p>' +
                    '<p class="datasyuyin">'+attachFile+'</p>' +
                    '<p>'+base64+'</p>' +
                    '<div style="font-size: 12px;margin-bottom: 10px;">' +strfile+'</div>'+
                    '<div class="" style="font-size: 13px;margin-top: 1px;margin-bottom:0;color: #999;">'+timeTday+
                    '</div>' +
                    '<ul class="hqhuifu" style="margin-bottom:10px;    margin-left: 10px;">'+hqhuifu+'</ul>' +
                    '</div>' +
                    '</li>';

            }
            $('.relevant').html(str)
            //    附件操作显示
            $(".fujianBlo").mouseover(function() {
                $(this).find('.fujianUl').css('display','block')
                $(this).css('background','#e8e8e8')
            });
            $(".fujianBlo").mouseleave(function() {
                $(this).find('.fujianUl').css('display','none')
                // $(this).css('display','none')
                $(this).css('background','none')
            });
            $('.operation2').prev().find('.lookImg').addClass('operationImg2')
        }
    })
}

//选择意见
function signBtn(id) {
    layer.open({
        title: ['选择常用意见', 'color: #fff;'],
        area: ['60%', '65%'],
        type: 1,
        btn: ['选择', '取消'],
        btnAlign: 'c',
        content: ['<div id="saveRule" style="height: 100%; position: relative;min-height: 300px;">',
            '<div class="inputlayout" style="width: 100%;margin: 0 auto;">' +
            '<ul class="input_radio_box" style="height: 100%;width: 96%;margin: 0 auto;margin-top: 20px;"></ul>' +
            '</div>',
            '<div style="bottom: 0;left: 0;right: 0;padding: 10px;">' +
            '<hr>' +
            '<p style="font-size: 13px; width: 100px;font-width: 600;">添加常用意见：</p>' +
            '<div style="margin: 10px;"><textarea id="yijian" style="width: 100%;margin: 0;box-sizing: border-box;"></textarea></div>' +
            '<button type="button" style="position: relative; top: auto; right: auto;font-size: 13px; margin: 0;" class="add_fujianss" id="add">添加</button>' +
            '</div>',
            '</div>'].join(''),
        success: function(){
            getFlowOpinion();
        },
        yes: function (index) {
            var opinionContent =$('input[name="flowId"]:checked').val()
            $(id).val(opinionContent);
            var pre = $(id).prev();
            var templ = pre.attr('templ');
            if (templ.indexOf('eiderarea') == -1) {
                templ = templ.replace('</div>','');
                templ = '<div id="eiderarea" class="eiderarea">'+templ+'</div>';
                pre.attr('templ', templ);
            }
            // var v = Mustache.render(templ,{content:opinionContent});
            var v = templ;
            if(v.indexOf('\n')>-1){
                v = v.replace(/\n/g,'<br/>')
            }
            var $div = $('<div>'+v+'</div>');
            $div.find('.eiderarea').eq($div.find('.eiderarea').length-1).find('.sign_content').text(opinionContent)
            var flowRunPrcs = workForm.option.flowRunPrcs;
            var timeStamp = new Date().getTime();
            $div.find('.eiderarea').last().append('<strong class="remove_sign">x</strong>')
                .attr('user_id', flowRunPrcs.userId).attr('prcs_id', flowRunPrcs.flowPrcs).attr('time_stamp', timeStamp);

            pre.attr('tv',$div.html());

            $div.find('.eiderarea').each(function(index){
                if ($(this).attr('user_id') == flowRunPrcs.userId && $(this).attr('prcs_id') == flowRunPrcs.flowPrcs && $(this).attr('time_stamp')) {
                    if ($div.find('.eiderarea').length - 1 > index) {
                        $(this).find('.remove_sign').show()
                    }
                } else {
                    $(this).find('.remove_sign').hide()
                }
            });
            pre.html($div.html());
            layer.close(index);
        }
    });

    //添加意见
    $("#add").click(function(event) {
        var content = $('#yijian').val();

        if (!content) {
            $.layerMsg({content: '意见不能为空!', icon: 0});
            return false;
        }

        $.ajax({
            type: 'post',
            url: '/flowOpinion/insertFlowOpinion',
            dataType: 'json',
            data: {
                opinionContent: content,
                opinionType:1,
            },
            beforeSend : function(request) {
                if(beforeToken != ''){
                    request.setRequestHeader("Authorization", 'Bearer '+beforeToken);
                }
            },
            success: function (res) {
                if (res.flag) {
                    getFlowOpinion();
                    $("#yijian").attr("value","");
                }
            }
        })
    });

    /**
     * 获取常用意见
     */
    function getFlowOpinion() {
        $.get('/flowOpinion/selectFlowOpinion', function (res) {
            var data = res.object;
            $('.input_radio_box').empty();
            if (res.flag) {
                if (res.object.length > 0) {
                    var str = ''
                    for (var i = 0; i < data.length; i++) {
                        str += '<li class="clearfix" opinionId="' + data[i].opinionId + '" style="position: relative;font-size: 13px;line-height: 30px;height: 30px;padding: 0 100px 0 0;border: 1px dashed #ccc;">' +
                            '<span class="drap_li" style="display: inline-block;font-size: 25px;color: #999;width: 40px;height: 100%;text-align: center;cursor: move;border-right: 1px solid #ccc;">☰</span>' +
                            '<span style="display: inline-block;width: 40px;height: 100%;text-align: center;border-right: 1px solid #ccc;vertical-align: top;">' +
                            '<input style="" class="tableDl" data-id="' + data[i].opinionId + '"  type="radio" name="flowId" value="' + data[i].opinionContent + '">' +
                            '</span>' +
                            '<span style="position: absolute;top: 0;left: 82px;right: 102px;padding: 0 5px;overflow: hidden;word-break: break-all;white-space: nowrap;text-overflow: ellipsis;" title="' + data[i].opinionContent + '">' + data[i].opinionContent + '</span>' +
                            '<div style="position: absolute; top: 0; right: 0; width: '+function(){
                                if(data[i].sortNo == 1){
                                    return '214'
                                }else{
                                    return '151'
                                }
                            }()+'px;height: 100%;line-height: 26px;">' +
                            function(){
                                if(data[i].sortNo == 1){
                                    return '<button type="button" class="add_fujianss" opinionId="' + data[i].opinionId + '"  id="delUps" style="background-color: red;border-color: red;position: relative;top: auto;right: auto;margin: 0 3px 0 0;width：60px">取消置顶</button>'
                                }else{
                                    return ''
                                }
                            }()+
                            '<button type="button" class="add_fujianss zhiding" opinionId="' + data[i].opinionId + '"  id="goUp" style="position: relative;top: auto;right: auto;margin: 0 3px 0 0;">置顶</button>' +
                            '<button class="add_fujianss edit_option" opinionId="' + data[i].opinionId + '" createUser="' + data[i].createUser + '" opinionType="' + data[i].opinionType + '" opinionContent="' + data[i].opinionContent + '" style="position: relative;top: auto;right: auto;margin: 0 3px 0 0;display: '+ function(){
                                if(data[i].opinionType == '0'){
                                    return 'none'
                                }else{
                                    return 'inline-block'
                                }
                            }()+';">编辑</button>' +
                            '<button class="add_fujianss del_option" opinionId="' + data[i].opinionId + '" style="position: relative;top: auto;right: auto;margin: 0;background-color: red;border-color: red;display: '+ function(){
                                if(data[i].opinionType == '0'){
                                    return 'none'
                                }else{
                                    return 'inline-block'
                                }
                            }()+';">删除</button>' +
                            '</div>' +
                            '</li>';
                    }
                    $('.input_radio_box').html(str);

                    $('.input_radio_box>li').arrangeable({
                        dragSelector: '.drap_li',
                        afterDragEnd: function (e) { // 拖拽结束调用
                            var dragdistanceyss = $('body').attr('dragdistanceyss');
                            if (dragdistanceyss > 0) {
                                var opinionId1 = $(e).attr('opinionId');
                                var opinionId2 = $(e).prev().attr('opinionId');
                            } else {
                                var opinionId1 = $(e).attr('opinionId');
                                var opinionId2 = $(e).next().attr('opinionId');
                            }
                            $.ajax({
                                type: 'post',
                                url: '/flowOpinion/exchange',
                                data: {
                                    opinionId1: opinionId1,
                                    opinionId2: opinionId2
                                },
                                dataType: 'json',
                                success: function (res) {
                                    getFlowOpinion();
                                }
                            });
                        }
                    });

                    // 编辑意见
                    $('.edit_option').click(function () {
                        var opinionId= $(this).attr('opinionId');
                        var opinionContent = $(this).attr('opinionContent');
                        var createUser = $(this).attr('createUser');
                        var opinionType = $(this).attr('opinionType');
                        layer.open({
                            type: 1,
                            title: ['编辑', 'background-color:#2b7fe0;color:#fff;'],
                            area: ['440px', '260px'],
                            shadeClose: true, //点击遮罩关闭
                            btn: ['确定', '取消'],
                            content: '<textarea style="height: 91%;width: 92%;margin:5px auto" placeholder="请输入意见" class="layui-textarea replyIdText" value="' + opinionContent + '">' + opinionContent + '</textarea>',
                            yes: function (index) {
                                if ($('.replyIdText').val() == '') {
                                    $.layerMsg({content: '请输入意见', icon: 1});
                                    return false;
                                }
                                $.ajax({
                                    type: "post",
                                    url: "/flowOpinion/updateFlowOpinionById",
                                    dataType: 'JSON',
                                    data: {
                                        opinionId: opinionId,
                                        createUser: createUser,
                                        opinionType: opinionType,
                                        opinionContent: $('.replyIdText').val(),
                                    },
                                    success: function (obj) {
                                        if (obj.flag) {
                                            getFlowOpinion();
                                            layer.close(index);
                                        }
                                    }
                                });
                            }
                        });
                    });

                    //删除意见
                    $(".del_option").click(function () {
                        var opinionId = $(this).attr('opinionId');

                        $.layerConfirm({title: '确定删除', content: '您确定要删除吗?', icon: 0}, function () {
                            $.ajax({
                                type: 'post',
                                url: '/flowOpinion/delFlowOpinion',
                                dataType: 'json',
                                data: {
                                    opinionId: opinionId,
                                },
                                beforeSend: function (request) {
                                    if (beforeToken != '') {
                                        request.setRequestHeader("Authorization", 'Bearer ' + beforeToken);
                                    }
                                },
                                success: function (res) {
                                    if (res.flag) {
                                        getFlowOpinion();
                                    } else {
                                        $.layerMsg({content: '删除失败', icon: 2});
                                    }
                                }
                            });
                        });
                    });
                    //置顶
                    $(".zhiding").click(function () {
                        var opinionId = $(this).attr('opinionId');
                        $.ajax({
                            type: 'post',
                            url: '/flowOpinion/top',
                            dataType: 'json',
                            data: {
                                opinionId: opinionId,
                                flag:0,
                            },
                            success: function (res) {
                                getFlowOpinion()
                            }
                        })
                    });
                    //取消置顶
                    $("#delUps").click(function () {
                        var opinionId = $(this).attr('opinionId');
                        $.ajax({
                            type: 'post',
                            url: '/flowOpinion/top',
                            dataType: 'json',
                            data: {
                                opinionId: opinionId,
                                flag:1,
                            },
                            success: function (res) {
                                getFlowOpinion()
                            }
                        })
                    });
                }
            }
        });
    }
}

function hqblock1(){
    $('#hqblock2').css('display','block')
    $('#hqblock').css('display','none')
    $('.signTexthq').focus()
    $('.layui-unselect').val('常用意见')
    //初始化
    $('.hqopinion').find('.yiyue').next().addClass('yiyueCol')
    $('#signText').val(' ')
    $('#photoFile').html(' ')
    $('#photoImg').html(' ')
    $('#staffNameInput').val(' ')
    $('#staffNameInput').attr('user_id',' ')
    $('.yiyue').find('img').attr('src','/img/workflow/work/add_work/yiyue.png')
    $('.yiyue').siblings().find('.tongyi').attr('src','/img/workflow/work/add_work/tongyi1.png')
    $('.yiyue').siblings().find('.butongyi').attr('src','/img/workflow/work/add_work/butongyi1.png')
    $('.yiyue').siblings().find('span').removeClass('yiyueCol')
}
function hqblock2(){
    $('.hqli hqli1').css('height','0')
    $('#xuanren').css('display','none')
    $('.signTexthq').val(' ')
    $('#photoFile').html(' ')
    $('#photoImg').html(' ')
    $('#staffNameInput').val(' ')
    $('#signText').val(' ')
    $('#staffNameInput').attr('user_id',' ')
    $('.hqli1').css('height','inherit')
    $('#hqblock').css('display','flex')
    $('#hqblock2').css('display','none')
}
//后一天parserDate
function getNextDate(date,day) {
    var dd = new Date(date);
    dd.setDate(dd.getDate() + day);
    var y = dd.getFullYear();
    var m = dd.getMonth() + 1 < 10 ? "0" + (dd.getMonth() + 1) : dd.getMonth() + 1;
    var d = dd.getDate() < 10 ? "0" + dd.getDate() : dd.getDate();
    var getNextDate = y + "-" + m + "-" + d;
    return getNextDate
}
//语音播放
function playaudioH5(datas) {
    $(datas).attr('onclick','')
    if( $(datas).find(".box111").css("display") == 'none'){
        $(datas).find(".box111").css('display','block');
        $(datas).find('.dialogue22').css('display','none');
    }else{
        $(datas).find(".box111").css('display','none');
        $(datas).find('.dialogue22').css('display','initial');
    }
    $('.third').css('border','2px solid white')
    var audio0 = $(datas).nextAll('.datasyuyin').find('.audio1').attr('id')
    var audio = document.getElementById(audio0);


    audio.play();
    audio.loop = false;
    audio.addEventListener('ended', function () {
        $(datas).attr('bofang','2')
        dialogue22(datas)
    }, false);
}
//播放动画
function dialogue22(datas) {
    $(datas).attr('onclick','playaudioH5($(this))')
    // if( $(datas).find(".box111").css("display") == 'none'){
    //     $(datas).find(".box111").css('display','block');
    //     $(datas).find('.dialogue22').css('display','none');
    // }else{
    //     $(datas).find(".box111").css('display','none');
    //     $(datas).find('.dialogue22').css('display','initial');
    // }
    $(datas).find(".box111").css('display','none');
    $(datas).find('.dialogue22').css('display','initial');
    return false
}
