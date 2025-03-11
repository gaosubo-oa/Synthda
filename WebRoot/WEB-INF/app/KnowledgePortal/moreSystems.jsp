<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
	String corpId = (String) request.getAttribute("corpId");
	String corpSecret = (String) request.getAttribute("corpSecret");
%>
<!DOCTYPE html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<title>公司制度</title>
    
	<link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>
    <link rel="stylesheet" href="../../lib/mui/mui/mui.picker.min.css"/>
	
	<script type="text/javascript" src="../../js/notes/jquery-2.1.2.min.js"></script>
	<script type="text/javascript" src="../../js/base/base.js"></script>
	<script type="text/javascript" src="../../lib/mui/mui/mui.min.js"></script>
	<script type="text/javascript" src="../../lib/mui/mui/mui.picker.min.js"></script>
    
	<style>
		body {
			height: 100%;
			overflow-y: auto;
		}
        
        .mui-content {
            background-color: #fff;
        }
		
		.content {
			padding: 0 10px;
            border-bottom: 1px solid rgba(206, 194, 194, 0.85);
		}
		
		.cont span {
			font-size: 15px;
		}
		
		.cont .item {
			display: inline-block;
			width: 50px;
			text-align: right;
		}
		
		.cont div {
			box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);
			border-radius: .1rem;
			margin-bottom: 15px;
			border-radius: 5px;
		}
		
		.cont div p {
			height: 32px;
			line-height: 32px;
			color: #333;
		}
		
		.over {
			overflow: hidden;
			white-space: nowrap;
			text-overflow: ellipsis;
			vertical-align: bottom;
			margin: auto 10px;
		}
	</style>
</head>
<body>
    <input type="hidden" id="sortId" value="">
    <input type="hidden" id="sortType" value="">
	<div class="mui-content">
		<div class="content">
            <%--制度的查询--%>
            <div>
                <div class="mui-input-row mui-search" style="margin-top: 10px;width: 88%;display: inline-block; vertical-align: middle;">
                    <input type="search" class="mui-input-clear search" placeholder="" style="background-color: #fff;border: 1px solid #ccc">
                </div>
                <span class="mui-icon mui-icon-more fenlei" style="font-size: 31px"></span>
            </div>
            <div id="pullrefresh" class="mui-content mui-scroll-wrapper" style="height: calc(100% - 60px);margin-top: 60px;">
                <div class="mui-scroll">
                    <!--数据列表-->
                    <div class="cont">
                    
                    </div>
                </div>
            </div>
        </div>
	</div>
</body>

</html>
<script>
    // 当前页数
    var currentPage = 1;
    // 每页显示数量
    var PAGESIZE = 15;
    
    <%--制度管理--%>
    zhidu()
   
    var app = mui.init({
        pullRefresh: {
            container: '#pullrefresh',
            up: {
                contentdown : "上拉显示更多",
                contentrefresh: '正在加载...',
                contentnomore: '没有更多数据了',
                callback: pullupRefresh
            }
        }
    });
    
    function pullupRefresh () {
        var _this = this;
        $.ajax({
            url: '/InstitutionContent/findContentBySortIds',
            type: 'get',
            dataType: 'json',
            data: {
                page: ++currentPage,
                limit: PAGESIZE,
                approveStatus: 1,
                instStatus: 1,
                instType: 1,
                order: 3,
                // instId: '',
                instName: $('.search').val(),
                keyWords: $('.search').val() || '',
                sortId: $('#sortId').val() || '',
                sortType: $('#sortType').val() || '',
                useFlag: true
            },
            success: function (res) {
                var str = '';
                var data = res.obj;
                if (data != '') {
                    for (var i = 0; i < data.length; i++) {
                        str += '<div><a class="link_item" style="display: block;" href="javaScript:;" url="/KnowledgePortalH5/systemDetails?instId=' + data[i].instId + '">\n' +
                            '                <p class="over">\n' +
                            '                    <span class="item">名称：</span><span>' + empty(data[i].instName) + '</span>\n' +
                            '                </p>\n' +
                            '                <p class="over">\n' +
                            '                    <span class="item">分类：</span><span>' + empty(data[i].institutionSort.sortName) + '</span>\n' +
                            '                </p>\n' +
                            '            </a></div>'
                    }
                    $('.cont').append(str);
                    
                    _this.endPullupToRefresh(!(res.totleNum > (currentPage * PAGESIZE)));
                    
                } else {
                    // 禁止下拉
                    _this.endPullupToRefresh(true);
                }
                //显示底部提示文字信息  
                var bottomElem = document.querySelector('.mui-pull-bottom-pocket');
                if (!bottomElem.classList.contains('mui-visibility')) {
                    bottomElem.classList.add('mui-visibility');
                }
            }
        });
    }

    function zhidu(instName, sortType, sortId) {
        var loadingIndex = layer.load(2);
        currentPage = 1;
        $.ajax({
            url: '/InstitutionContent/findContentBySortIds',
            type: 'get',
            dataType: 'json',
            data: {
                page: 1,
                limit: PAGESIZE,
                approveStatus: 1,
                instStatus: 1,
                instType: 1,
                order: 3,
                instName: instName || '',
                keyWords: instName || '',
                sortId: sortId || '',
                sortType: sortType || '',
                useFlag: true,
                _: new Date().getTime()
            },
            success: function (res) {
                layer.close(loadingIndex);
                mui('.mui-scroll-wrapper').scroll().scrollTo(0,0,0);
                var str = '';
                var data = res.obj;
                if (data != '') {
                    for (var i = 0; i < data.length; i++) {
                        str += '<div><a class="link_item" style="display: block;" href="javaScript:;" url="/KnowledgePortalH5/systemDetails?instId=' + data[i].instId + '">\n' +
                            // '                <p>\n' +
                            // '                    <span class="item">制度编号：</span><span>'+empty(data[i].instNumber)+'</span>\n' +
                            // '                </p>\n' +
                            '                <p class="over">\n' +
                            '                    <span class="item">名称：</span><span>' + empty(data[i].instName) + '</span>\n' +
                            '                </p>\n' +
                            '                <p class="over">\n' +
                            '                    <span class="item">分类：</span><span>' + empty(data[i].institutionSort.sortName) + '</span>\n' +
                            '                </p>\n' +
                            '            </a></div>'
                    }
                    $('.cont').html(str);
                    
                    if (res.totleNum > 15) {
                        // 启用下拉
                        mui('#pullrefresh').pullRefresh().enablePullupToRefresh();
                        //显示底部提示文字信息  
                        var bottomElem = document.querySelector('.mui-pull-bottom-pocket');
                        if (!bottomElem.classList.contains('mui-visibility')) {
                            bottomElem.classList.add('mui-visibility');
                            bottomElem.classList.remove('mui-hidden');
                            $('.mui-pull-caption').text('上拉显示更多');
                        }
                    } else {
                        // 禁止下拉
                        mui('#pullrefresh').pullRefresh().disablePullupToRefresh();
                        if ($('.mui-scroll').height() > $('.mui-scroll-wrapper').height()) {
                            //显示底部提示文字信息  
                            var bottomElem = document.querySelector('.mui-pull-bottom-pocket');
                            if (!bottomElem.classList.contains('mui-visibility')) {
                                bottomElem.classList.add('mui-visibility');
                                bottomElem.classList.remove('mui-hidden');
                                $('.mui-pull-caption').text('没有更多数据了');
                            }
                        }
                    }
                    
                } else {
                    str = '<div style="font-size:20px;text-align: center;line-height: 50px">无数据</div>';
                    $('.cont').html(str);
                    // 禁止下拉
                    mui('#pullrefresh').pullRefresh().disablePullupToRefresh();
                }
            }
        });
    }

    
    var timer = null;
    //搜索
    $(".search").bind("input propertychange", function () {
        clearTimeout(timer);
        timer = null;
        timer = setTimeout(function(){
             zhidu($('.search').val(), $('#sortType').val(), $('#sortId').val());
        }, 300);
    });

    var picker = new mui.PopPicker({layer: 2, buttons: ['取消', '确定']});

    // 更多
    $('.fenlei').click(function () {
        // window.location.href='/KnowledgePortalH5/classification'
        picker.show(function (selectItems) {
            $('#sortType').val(selectItems[0].value || '');
            $('#sortId').val(selectItems[1].value || '');
            zhidu($('.search').val(), selectItems[0].value, selectItems[1].value);
        });
    });
    
    // 获取分类
    $.get('/code/getCode?parentNo=INSTITUTION_SORT_LEVEL', function (res) {
        var typeArr = [];
        if (res.flag && res.obj.length > 0) {
            res.obj.forEach(function(code){
                var obj = {value: code.codeNo, text: code.codeName}
    
                $.ajax({
                    type: 'GET',
                    url: '/InstitutionSort/getByType',
                    data: {sortType: code.codeNo},
                    async: false,
                    success: function(json) {
                        if (json.flag && json.obj.length > 0) {
                            obj.children = [];
                            json.obj.forEach(function(sort){
                               var sortObj = {value: sort.sortId, text: sort.sortName}
                               obj.children.push(sortObj);
                            });
                        }
                    }
                });
                
                typeArr.push(obj);
            });
        }
        picker.setData(typeArr);
    });

    mui("#pullrefresh").on('tap', '.link_item', function () {
        $('#sortId').val('');
        $('#sortType').val('');
        var url = $(this).attr('url');
        location.href = url;
    });
    
    //判断返回是否为空
    function empty(esName) {
        if (esName == undefined || esName == '') {
            return ''
        } else {
            return esName
        }
    }

</script>