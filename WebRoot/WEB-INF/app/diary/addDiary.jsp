<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<!--[if IE 6 ]>
<html class="ie6 lte_ie6 lte_ie7 lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 6 ]>
<html class="lte_ie6 lte_ie7 lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 7 ]>
<html class="lte_ie7 lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 8 ]>
<html class="lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 9 ]>
<html class="lte_ie9"> <![endif]-->
<!--[if (gte IE 10)|!(IE)]><!-->
<html><!--<![endif]-->
<head>
    <title>æ°å»ºæ¥å¿</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="css/style.css"/>
    <!--[if lte IE 8]>
    <script type="text/javascript" src="js/ccorrect_btn.js"></script>
    <![endif]-->

    <script type="text/javascript">
        var MYOA_JS_SERVER = "";
        var MYOA_STATIC_SERVER = "";
    </script>

</head>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="css/diary_new.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.tag.css">
<script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
<script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
<script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
<script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
<script src="js/module.js"></script>
<script src="js/mouse_mon.js"></script>
<script type="text/javascript" src="js/js_lang.js"></script>
<script type="text/javascript" src="js/utility.js"></script>
<script type="text/javascript" src="js/attach.js"></script>
<script src="js/wdatepicker.js"></script>
<script language="javascript" src="js/tabopt.js"></script>
<!-- æ·»å word start-->
<script type="text/javascript" charset="utf-8" src="word/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="word/ueditor.all.min.js"></script>
<!--å»ºè®®æå¨å å¨è¯­è¨ï¼é¿åå¨ieä¸ææ¶å ä¸ºå è½½è¯­è¨å¤±è´¥å¯¼è´ç¼è¾å¨å è½½å¤±è´¥-->
<!--è¿éå è½½çè¯­è¨æä»¶ä¼è¦çä½ å¨éç½®é¡¹ç®éæ·»å çè¯­è¨ç±»åï¼æ¯å¦ä½ å¨éç½®é¡¹ç®ééç½®çæ¯è±æï¼è¿éå è½½çä¸­æï¼é£æåå°±æ¯ä¸­æ-->
<script type="text/javascript" charset="utf-8" src="word/lang/zh-cn/zh-cn.js"></script>
<script src="../../js/jquery/jquery.form.min.js" type="text/javascript" charset="utf-8"></script>
<script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
<!--  æ·»å word end-->
<script Language="JavaScript">

    $(function(){
        var str="";
        $.ajax({
            url: "/code/GetDropDownBox",
            type:'get',
            dataType:"JSON",
            data : {"CodeNos":"DIARY_TYPE"},
            success:function(data){
                for (var proId in data){
                    for(var i=0;i<data[proId].length;i++){
                        str+='<option value="'+data[proId][i].codeNo+'">'+data[proId][i].codeName+'</option>'
                    }
                }
                $('#diary_type').append(str);
            }


        })


    })






    confirmSaveBeforeCloseTab("", "", "");
    var upload_limit = 1, limit_type = "php,php3,php4,php5,";

    setInterval(div_change, 500);
    function div_change() {
        var i_div_left = document.getElementById("div_left").scrollHeight - 20;
        document.getElementById("div_right").style.height = i_div_left + "px";
    }

    function CheckForm(s_start, s_end, LAST_DATE) {
        var s_form_time = document.form1.dia_date.value;

        if (s_form_time <= LAST_DATE) {
            alert("æå¡«çæ¥å¿æ¥æå¨éå®èå´åï¼");
            return (false);
        }
        else if (s_start == "" && s_end != "" && s_form_time <= s_end) {
            alert("æå¡«çæ¥å¿æ¥æå¨éå®èå´åï¼");
            return (false);
        }
        else if (s_start != "" && s_end == "" && s_form_time >= s_start) {
            alert("æå¡«çæ¥å¿æ¥æå¨éå®èå´åï¼");
            return (false);
        }
        else if (s_start != "" && s_end != "" && s_form_time <= s_end && s_form_time >= s_start) {
            alert("æå¡«çæ¥å¿æ¥æå¨éå®èå´åï¼");
            return (false);
        }
        if (checkEditorDirty('CONTENT') == "") {
            alert("æ¥å¿åå®¹ä¸è½ä¸ºç©ºï¼");
            return (false);
        }
        document.form1.OP.value = "1";
        document.getElementById("submit_btn").disabled = "true";
        return (true);
    }

    function InsertImage(src) {
        AddImage2Editor('CONTENT', src);
    }
    function upload_attach() {
        if (CheckForm('', '', '')) {
            document.form1.OP.value = "0";
            document.form1.submit();
        }
    }

    function mysubmit() {
        if (CheckForm('', '', '')) {
            document.form1.submit();
            document.form1.thesubmit.disabled = true;
        }
    }

    function check_unload() {
        if (mouse_is_out && checkEditorDirty('CONTENT')) {
            return 'åå®¹æ²¡æä¿å­ï¼ç¡®å®ä¸ä¿å­éåºåï¼';
        }
    }

    function change_share(a) {
        if (a == 2) {
            var obj = document.getElementById("dia_share");
            obj.style.display = 'none';
        }
        else {
            var obj = document.getElementById("dia_share");
            obj.style.display = '';
        }
    }

    function link_data() {
        var cur_date = document.form1.dia_date.value;

        _get('get_linkdata.php?CUR_DATE=' + cur_date, '', function (req) {
            if (req.status == 200) {
                if (req.responseText.length > 26) {
                    setEditorHtml('CONTENT', req.responseText);
                }
                else {
                    alert("ææ ç¸å³æ°æ®");
                    setEditorHtml('CONTENT', '');
                }
            }
            else {
                setEditorHtml('CONTENT', '');
            }
        });
    }

    function ChangeTitle() {
        var s_datetime = document.form1.dia_date.value;

        var a_weekday = ["æææ¥", "ææä¸", "ææäº", "ææä¸", "ææå", "ææäº", "ææå­"];
        var date_new = new Date(Date.parse(s_datetime.replace(/\-/g, "/")));
        document.form1.subject.value = s_datetime + " " + a_weekday[date_new.getDay()] + " " + "æ¥å¿";
    }

    function share() {
        var obj = document.getElementById("share");
        if (obj.style.display == 'none') {
            obj.style.display = '';
        }
        else {
            obj.style.display = 'none';
        }
    }

    function go_back() {
        if (checkEditorDirty('CONTENT')) {
            msg = 'åå®¹æ²¡æä¿å­ï¼ç¡®å®ä¸ä¿å­éåºåï¼';
            if (window.confirm(msg)) {
                location = '../index.php';
            }
        }
        else {
            location = '../index.php';
        }
    }
    function myload() {
        var content = window.external.OA_SMS("", "", "FW_CONTENT");
        setEditorHtml('CONTENT', content);
        //CKEDITOR.instances['TD_HTML_EDITOR_CONTENT'].setData(content);
    }

</script>


<body>
<div class="wrapper">
    <form enctype="multipart/form-data" action="submit.php" method="post" name="form1" class="form-horizontal"
          onSubmit="return CheckForm('','','');">
        <div class="row">
            <div class="span9">
                <dl id="div_left" class="diary-new-list">
                    <ul class="diary-header">
                        <li class="diary-header-item">
                            <h2 class="diary-header-title">æ°å»ºæ¥å¿</h2>
                            <a class="diary-auto" title=å³èå¬åéç¥ãæ°é»ãé®ä»¶ãå·¥ä½æµãæ¥ç¨ãä»»å¡ç¸å³æ¨¡åæ°æ® href="#" onClick="link_data()">å¿«éçææ¥å¿</a>
                        </li>
                    </ul>

                    <div class="control-group">
                        <!-- Text input-->
                        <label class="control-label" for="input01">æ é¢ï¼</label>

                        <div class="controls" align='left'>
                            <input type="text" name="subject" class="input-xxlarge" style="width:646px"
                                   value="2017-04-13 ææå æ¥å¿">
                        </div>
                    </div>

                    <div class="control-group" style="text-align:left">
                        <!-- Textarea -->
                        <div>

                            <label style="margin-left: 13px;">åå®¹ï¼</label>
                            <div id="editor" type="text/plain" style="height:300px"></div>
                        </div>
                    </div>

                    <div class="control-group">
                        <!-- Label -->
                        <label class="control-label">éä»¶ï¼</label>

                        <div class="controls" style="padding-top: 5px;width: 660px;">
                            <script>ShowAddFile();</script>
                            <script>ShowAddImage();</script>
                            <script>$("ATTACHMENT_upload_div").innerHTML = '<a href="javascript:upload_attach();">ä¸ä¼ éä»¶</a>'</script>
                            <input type="hidden" name="attachment_id_old" value>
                            <input type="hidden" name="attachment_name_old" value>
                        </div>
                    </div>

                    <div align="right" style="width:720px;">
                        <input type="hidden" name="OP" value="1">
                        <input type="hidden" name="FROM" value="">
                        <button type="submit" class="btn btn-primary" id="submit_btn">ä¿å­</button>
                        <button type="button" class="btn" onClick="go_back();">è¿å</button>
                    </div>
                </dl>
            </div>

            <div class="span3">
                <dl id="div_right" class="diary-info-list">
                    <div class="row-fluid" style="text-align:left;margin-top:15px;">
                        <input type="text" name="dia_date" class="input-medium" value="2017-04-13"
                               onClick="WdatePicker();ChangeTitle()">
                    </div>

                    <hr class="diary-hr">

                    <div>
                        <select class="input-medium" id="diary_type" name="dia_type" onChange="change_share(this.value)">
                         <%--   <option value="1">å·¥ä½æ¥å¿</option>
                            <option value="2">ä¸ªäººæ¥å¿</option>--%>
                        </select>
                    </div>

                    <hr class="diary-hr">

                    <div class="control-group" id="dia_share">

                        <label class="control-label" for="share_type" style="*+width:60px">å±äº« <input id="share_type"
                                                                                                     type="checkbox"
                                                                                                     name="share_type"
                                                                                                     value="1"
                                                                                                     onClick="share()"
                                                                                                     style="*+margin-top:-5px"/></label>

                        <div id="share" style="display:none">
                            <!-- Textarea -->
                            <div class="textarea">
                                <input type="hidden" name="to_id" value="">
                                <textarea class="SmallStatic" name="to_name"
                                          style="margin: 0px; width: 185px; height: 50px; " readonly> </textarea>

                                <div align="right" style="margin-top:5px;">
                                    <a href="#" class="orgAdd" onClick="SelectUser('1', '2', 'to_id', 'to_name')">æ·»å </a>
                                    <a href="#" class="orgClear" onClick="ClearUser('to_id', 'to_name')">æ¸ç©º</a>
                                </div>
                            </div>

                            <label class="sms-remind-label" for="share_init">
                                <input type="checkbox" name="share_init" value="1"/>è®¾ç½®ä¸ºé»è®¤å±äº«èå´ </label>
                            <label class='sms-remind-label'><input type="checkbox" name="SMS_REMIND" id="SMS_REMIND"
                                                                   checked>åéäºå¡æéæ¶æ¯</label><label
                                class='sms-remind-label'><input type="checkbox" name="SNS_REMIND" id="SNS_REMIND"
                                                                checked>åäº«å°ä¼ä¸ç¤¾åº</label></div>
                    </div>
                </dl>
            </div>
        </div>
    </form>

</div>

<script src="js/word.js"></script>

</body>