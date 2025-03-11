/**
 * 此js文件用来集成效能监察模块通用的js方法以简化jsp页面
 */
// 动态加载工作名称/文号下拉框
$(function () {
    $.ajax({
        type: 'get',
        url: '/FlowRunFu/selectImportantFlowType',
        success: function (res) {
            var str = '';
            if (res.flag) {
                $.each(res.obj, function (index, item) {
                    str += '<option value="' + item.flowId + '">' + item.flowName + '</option>'
                });
                $('#selectFlowType').append(str);
            }
        }
    });
});

// 去掉字符串末尾的逗号
function trimComma(str) {
    var c = str.charAt(str.length - 1);
    if (c === ',') {
        return str.substring(0, str.length - 1);
    }
    return str;
}