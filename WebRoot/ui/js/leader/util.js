/**
 *
 * 常用工具类
 */
var TUtil = {
    trim: function (str) {
        var trimRegex = /(?:^[ \t\n\r]+)|(?:[ \t\n\r]+$)/g;
        return str.replace(trimRegex, '');
    },
    openUrl: function (url, type, name, width, height, left, top) {
        var availWidth = screen.availWidth - 25;
        var availHeight = screen.availHeight - 70;
        var myWidth = width ? width : availWidth;
        var myHeight = height ? height : availHeight;
        var myLeft = left ? left : (availWidth - myWidth) / 2;
        var myTop = top ? left : (availHeight - myHeight) / 2;
        if (!name)
            name = "";
        if (this.isIE() && type == 'modal')
            var returnValue = window.showModalDialog(url, window, "edge:raised;scroll:1;status:0;help:0;resizable:1;dialogWidth:" + myWidth + "px;dialogHeight:" + myHeight + "px;dialogTop:" + myTop + "px;dialogLeft:" + myLeft + "px", true);
        else {
            opened = window.open(url, name, 'height=' + myHeight + ',width=' + myWidth + ',status=1,toolbar=no,menubar=no,location=no,scrollbars=yes,modal=yes,dependent=yes,dialog=yes,minimizable=no,top=' + myTop + ',left=' + myLeft + ',resizable=yes', true);
            opened.focus();
        }
        if (returnValue == undefined) {
            returnValue = window.returnValue;
        }
        return returnValue;
    },
    winClose: function () {
        if (typeof (window.external.OA_SMS) != "undefined") {
            window.external.OA_SMS('', '', 'CLOSE_WINDOW');
        } else {
            window.close();
        }
    },
    winConfirmClose: function () {
        if (window._originalConfirm("是否确认关闭？")) {
            if (typeof (window.external.OA_SMS) != "undefined") {
                window.external.OA_SMS('', '', 'CLOSE_WINDOW');
            } else {
                window.close();
            }
        }
    },
    isUndefined: function (variable) {
        return typeof variable === 'undefined' ? true : false;
    },
    nl2br: function (str, is_xhtml) {
        var breakTag = (is_xhtml || typeof is_xhtml === 'undefined') ? '<br />' : '<br>';
        return (str + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, "$1" + breakTag + "$2");
    },
    sprintf: function () {
        var arg = arguments,
            str = arg[0] || '',
            i, n;
        for (i = 1, n = arg.length; i < n; i++) {
            str = str.replace(/%s/, arg[i]);
        }
        return str;
    },

    browserVersion: function () {
        var Sys = {};
        var ua = navigator.userAgent.toLowerCase();
        var s;
        (s = ua.match(/rv:([\d.]+)\) like gecko/)) ? Sys.ie = s[1] :
            (s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[1] :
                (s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] :
                    (s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] :
                        (s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] :
                            (s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0;

        return Sys;
    },

    isIE: function () {
        var obj = this.browserVersion();
        if (obj.ie)
            return true;
        else
            return false;
    },
    ie8FixIcon: function () {
        var head = document.getElementsByTagName('head')[0], style = document.createElement('style');
        style.type = 'text/css';
        style.styleSheet.cssText = ':before,:after{content:"" !important';
        head.appendChild(style);
        setTimeout(function () {
            head.removeChild(style);
        }, 0);
    },
    getOfficeVersion: function () {
        try {
            word = new ActiveXObject("Word.application");
        } catch (e) {
            return false;
        }
        if (word.Version === "11.0") {
            version = "office2003";
        }
        else if (word.Version === "12.0") {
            version = "office2007";
        }
        else if (word.Version === "14.0") {
            version = "office2010";
        }
        word.Application.Quit();
        return version;
    },
    backdrop: function () {
        this.$backdrop = $('<div class="modal-backdrop fade"></div>').appendTo(document.body);
        this.$backdrop.addClass('in');
        this.$backdrop_loading = $('<img style="position:absolute; top:40%; left:50%; z-index:1060;" src="/img/leader/images/loading.gif" />').appendTo(document.body);
    },
    removeBackdrop: function() {
        this.$backdrop && this.$backdrop.remove();
        this.$backdrop = null;
        this.$backdrop_loading && this.$backdrop_loading.remove();
        this.$backdrop_loading = null;
    },
    focus: function (el) {
        var canFocus = !el.disabled &&
            el.style.display != 'none' &&
            el.style.visibility != 'hidden';
        if (canFocus) el.focus();
        return canFocus;
    }

};

/**
 *
 * CKeditor工具类
 */
var TCKEditorHelper = {
    getInstance: function (id) {
        if (TUtil.isUndefined(id))
            return null;
        else
            return eval("CKEDITOR.instances." + id);
    },
    insertImage: function (id, src) {
        var editor = this.getInstance(id);
        if (editor)
            editor.insertHtml('<img src="' + src + '">');
    },
    getEditorText: function (id) {
        var editor = this.getInstance(id);
        if (editor) {
            var element = CKEDITOR.dom.element.createFromHtml('<div>' + editor.getData() + '</div>');
            return element.getText();
        }
    },
    getEditorHtml: function (id) {
        var editor = this.getInstance(id);
        if (editor) {
            return editor.getData();
        }
    },
    setEditorHtml: function (id, html) {
        var editor = this.getInstance(id);
        if (editor) {
            editor.setData(html);
        }
    }
};


/**
 *
 * URL管理器
 */
var TUrlManager = {
    settings: {
        'baseUrl': window.location.href,
        'params': {},
        'rewrite': true
    },
    parse: function () {
        var self = this;
        var url = this.settings.baseUrl;
        $.each(this.settings.params, function (k, v) {
            if (self.settings.rewrite === true) {
                var exp = new RegExp('/' + k + '/\\w*');
                if (exp.test(url)) {
                    url = url.replace(exp, '/' + k + '/' + v);
                } else {
                    url += '?' + k + '=' + v;
                }
            } else {
                var exp = new RegExp('&' + k + '=' + '\\w*');
                if (exp.test(url)) {
                    url = url.replace(exp, '&' + k + '=' + v);
                } else {
                    url += '&' + k + '=' + v;
                }
            }
        });
        return url;
    },
    parseUrl: function (options) {
        if (typeof options === 'object') {
            if (options.params)
                this.settings = $.extend(this.settings, options || {});
            else
                this.settings.params = options;
        }
        return this.parse();
    }
};

var TTreeUtil = {
    contextMenu: function (contextMenuId, callback, event, treeId, treeNode) {
        event.preventDefault();
        if (!treeNode) {
            return false;
        }
        $.fn.zTree.getZTreeObj(treeId).selectNode(treeNode);
        var contextMenu = $('#' + contextMenuId);
        contextMenu.find(".dropdown-menu").show();
        var x = event.clientX;
        var y = event.clientY;
        if (contextMenu.parents('div').hasClass('content')) {
            x = x - parseInt(contextMenu.parents('div[class="content"]').css('marginLeft'));
        }
        contextMenu.css({"top": y + "px", "left": x + "px", "visibility": "visible"});
        if ($(window).height() - event.clientY < contextMenu.find(".dropdown-menu").outerHeight()) {
            contextMenu.addClass('dropup');
        } else {
            contextMenu.removeClass('dropup');
        }

        if (typeof callback === 'function') {
            callback(event, treeId, treeNode);
        }

    }
};

var TDate = {
    getDate: function () {
        var d = new Date();
        if (d) {
            return d.toLocaleDateString(); // 获取日期
        }
    }
};

var TImg = {
    autoResizeImage: function (maxWidth, maxHeight, objImg) {
        var hRatio;
        var wRatio;
        var Ratio = 1;
        var w = objImg.width;
        var h = objImg.height;
        wRatio = maxWidth / w;
        hRatio = maxHeight / h;
        if (maxWidth == 0 && maxHeight == 0) {
            Ratio = 1;
        } else if (maxWidth == 0) { //
            if (hRatio < 1)
                Ratio = hRatio;
        } else if (maxHeight == 0) {
            if (wRatio < 1)
                Ratio = wRatio;
        } else if (wRatio < 1 || hRatio < 1) {
            Ratio = (wRatio <= hRatio ? wRatio : hRatio);
        }
        if (Ratio < 1) {
            w = w * Ratio;
            h = h * Ratio;
        }
        objImg.height = h;
        objImg.width = w;
    }
};
//计算类
var TCalculate = {
    GETVAL: function (val) {
        var obj = $("#" + val);
        if (obj.length == 0)
            return 0;
        if (obj.attr("type") && obj.attr("type") == "listview") {
            return $("#" + val);
        }
        var vVal = obj.val();
        //判断是否为时间
        if (vVal.indexOf("-") > 0) {
            //eval("date_flag_"+flag+"=1");
            vVal = vVal.replace(/\-/g, "/");
            var d = new Date(vVal);
            return d.getTime() / 1000;
        } else if (vVal.indexOf("%") > 0) { //处理%
            vVal = parseFloat(vVal) / 100;
        } else if (vVal.indexOf(" ") >= 0) {
            vVal = vVal.replace(/\s+/g, "/");
        } else if (TCalculate.isThs(vVal)) {
            vVal = TCalculate.calcThsRev(vVal);
        } else if (vVal == "" || isNaN(vVal)) {
            vVal = 0;
        }
        return parseFloat(vVal);
    },
    MAX: function () {
        if (arguments.length == 0)
            return;
        var max_num = arguments[0];
        for (var i = 0; i < arguments.length; i++)
            max_num = Math.max(max_num, arguments[i]);
        return parseFloat(max_num);
    },
    MIN: function () {
        if (arguments.length == 0)
            return;
        var min_num = arguments[0];
        for (var i = 0; i < arguments.length; i++)
            min_num = Math.min(min_num, arguments[i]);
        return parseFloat(min_num);
    },
    ABS: function (val) {
        return Math.abs(parseFloat(val));
    },
    MOD: function () {
        if (arguments.length == 0)
            return;
        var first_num = arguments[0];
        var second_num = arguments[1];
        var result = first_num % second_num;
        result = isNaN(result) ? "" : parseFloat(result);
        return result;
    },
    AVG: function () {
        if (arguments.length == 0)
            return;
        var sum = 0;
        for (var i = 0; i < arguments.length; i++) {
            sum += parseFloat(arguments[i]);
        }
        return parseFloat(sum / arguments.length);
    },
    RMB: function (currencyDigits) {
// Constants:
        var MAXIMUM_NUMBER = 99999999999.99;
        // Predefine the radix characters and currency symbols for output:
        var CN_ZERO = "零";
        var CN_ONE = "壹";
        var CN_TWO = "贰";
        var CN_THREE = "叁";
        var CN_FOUR = "肆";
        var CN_FIVE = "伍";
        var CN_SIX = "陆";
        var CN_SEVEN = "柒";
        var CN_EIGHT = "捌";
        var CN_NINE = "玖";
        var CN_TEN = "拾";
        var CN_HUNDRED = "佰";
        var CN_THOUSAND = "仟";
        var CN_TEN_THOUSAND = "万";
        var CN_HUNDRED_MILLION = "亿";
        var CN_DOLLAR = "元";
        var CN_TEN_CENT = "角";
        var CN_CENT = "分";
        var CN_INTEGER = "整";

        // Variables:
        var integral; // Represent integral part of digit number.
        var decimal; // Represent decimal part of digit number.
        var outputCharacters; // The output result.
        var parts;
        var digits, radices, bigRadices, decimals;
        var zeroCount;
        var i, p, d;
        var quotient, modulus;

        // Validate input string:
        currencyDigits = currencyDigits.toString();
        if (currencyDigits == "") {
            return "";
        }
        if (currencyDigits.match(/[^,.\d]/) != null) {
            return "";
        }
        if ((currencyDigits).match(/^((\d{1,3}(,\d{3})*(.((\d{3},)*\d{1,3}))?)|(\d+(.\d+)?))$/) == null) {
            return "";
        }

        // Normalize the format of input digits:
        currencyDigits = currencyDigits.replace(/,/g, ""); // Remove comma delimiters.
        currencyDigits = currencyDigits.replace(/^0+/, ""); // Trim zeros at the beginning.
        // Assert the number is not greater than the maximum number.
        if (Number(currencyDigits) > MAXIMUM_NUMBER) {
            return "";
        }

        // Process the coversion from currency digits to characters:
        // Separate integral and decimal parts before processing coversion:
        parts = currencyDigits.split(".");
        if (parts.length > 1) {
            integral = parts[0];
            decimal = parts[1];
            // Cut down redundant decimal digits that are after the second.
            decimal = decimal.substr(0, 2);
        }
        else {
            integral = parts[0];
            decimal = "";
        }
        // Prepare the characters corresponding to the digits:
        digits = new Array(CN_ZERO, CN_ONE, CN_TWO, CN_THREE, CN_FOUR, CN_FIVE, CN_SIX, CN_SEVEN, CN_EIGHT, CN_NINE);
        radices = new Array("", CN_TEN, CN_HUNDRED, CN_THOUSAND);
        bigRadices = new Array("", CN_TEN_THOUSAND, CN_HUNDRED_MILLION);
        decimals = new Array(CN_TEN_CENT, CN_CENT);
        // Start processing:
        outputCharacters = "";
        // Process integral part if it is larger than 0:
        if (Number(integral) > 0) {
            zeroCount = 0;
            for (i = 0; i < integral.length; i++) {
                p = integral.length - i - 1;
                d = integral.substr(i, 1);
                quotient = p / 4;
                modulus = p % 4;
                if (d == "0") {
                    zeroCount++;
                }
                else {
                    if (zeroCount > 0) {
                        outputCharacters += digits[0];
                    }
                    zeroCount = 0;
                    outputCharacters += digits[Number(d)] + radices[modulus];
                }
                if (modulus == 0 && zeroCount < 4) {
                    outputCharacters += bigRadices[quotient];
                }
            }
            outputCharacters += CN_DOLLAR;
        }
        // Process decimal part if there is:
        if (decimal != "") {
            for (i = 0; i < decimal.length; i++) {
                d = decimal.substr(i, 1);
                if (d != "0") {
                    outputCharacters += digits[Number(d)] + decimals[i];
                }
            }
        }
        // Confirm and return the final output string:
        if (outputCharacters == "") {
            outputCharacters = CN_ZERO + CN_DOLLAR;
        }
        if (decimal == "") {
            outputCharacters += CN_INTEGER;
        }
        //outputCharacters = CN_SYMBOL + outputCharacters;
        return outputCharacters;
    },
    DAY: function (val) {
        return val == 0 ? 0 : Math.floor(val / 86400);
    },
    HOUR: function (val) {
        return val == 0 ? 0 : Math.floor(val / 3600);
    },
    DATE: function (val) {
        return (val >= 0) ? Math.floor(val / 86400) + '天' + Math.floor((val % 86400) / 3600) + '小时' + Math.floor((val % 3600) / 60) + '分' + Math.floor(val % 60) + '秒' : '日期格式无效';//'日期格式无效'
    },
    LIST: function (olist, col) {
        if (!olist)
            return 0;
        if (!col)
            return 0;

        //col--;
        var output = 0;
        var lv_tb_id = olist.attr("id");
        var row_length = olist.find("tbody tr").length;
        if ($('#total_' + lv_tb_id).length > 0)
            row_length--;

        for (i = 1; i < row_length; i++) {
            for (j = 0; j < olist.find("tbody tr:eq(" + i + ")").find("td").length - 1; j++) {
                if (j == col) {
                    var child_ojb = olist.find("tbody tr:eq(" + i + ")").find("td:eq(" + j + ")").find("input");
                    var olist_val = child_ojb.val();
                    olist_val = (typeof olist_val == "undefined" || olist_val == "" || olist_val.replace(/\s/g, '') == "") ? 0 : olist_val;
                    olist_val = (isNaN(olist_val)) ? NaN : olist_val;
                    if (child_ojb)
                        output += parseFloat(olist_val);
                    else
                        output += parseFloat(olist.find("tbody tr:eq(" + i + ")").find("td:eq(" + j + ")").text());
                }
            }
        }
        return parseFloat(output);
    },
    THS: function (val) {
        if (isNaN(val)) {
            return 0;
        }
        var re = /\d{1,3}(?=(\d{3})+$)/g;
        var n = val.toString().replace(/^(\d+)((\.\d+)?)$/, function (s, s1, s2) {
            return s1.replace(re, "$&,") + s2;
        });
        return n;
    },
    calcThsRev: function (val) {
        if (typeof val == "string") {
            return val.replace(/,/gi, '');
        } else {
            return false;
        }
    },
    isThs: function (val) {
        if (isNaN(val) && !isNaN(TCalculate.calcThsRev(val))) {
            return true;
        }
        return false;
    }
};