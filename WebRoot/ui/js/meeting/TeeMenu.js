/**
 * 
 * 这个是浮动 div 用jquery 写的 支持扩展 author:zhp
 */
( function($) {
	var panel;
	var focus = false;
	var yScrollLength = 0;
	var xScrollLength = 0;
	/**
	 * 处理滚动条Y轴长度-----扩展 ---syl
	 */
	$(window).scroll(
			function getPageScroll() {
				if (self.pageYOffset) {
					yScrollLength = self.pageYOffset;
					XScrollLength = self.pageXOffset;

				} else if (document.documentElement
						&& document.documentElement.scrollTop) {
					yScrollLength = document.documentElement.scrollTop;
					xScrollLength = document.documentElement.scrollLeft;
				} else if (document.body) {
					yScrollLength = document.body.scrollTop;
					xScrollLength = document.body.scrollLeft;
				}
				var arrayPageScroll = new Array(xScrollLength, yScrollLength);
				return arrayPageScroll;
			});

	$.fn.TeeMenu = function(options) {
		if(this.length==0){
			return;
		}
		var settings = $.extend( {

		}, options || {});

		// 初始化變數
		var menuData = settings.menuData || {};// menu数据
		var eventName = settings.eventName || "mouseover";// 默认鼠标位置是从
															// mouseover 或者
															// click
		var eventPosition = settings.eventPosition || false;// 是否从事件中获取div位置
		var appendDiv = settings.appendDiv || 'body';// 默认加到 body中 处理滚动条问题
		var _top = settings.top || 0;//
		var _left = settings.left || 0;//

		//初始化加入面板
		if (!panel) {
			panel = $(document.createElement("div"));
			panel.addClass("attach_div").css( {
				zIndex : 999999888,
				position : 'absolute',
				fontSize:'12px'
			}).bind("click", function() {
				panel.hide();
			}).mouseover( function() {
				focus = true;
				showMenuHandler();
			}).mouseout(function(){
				focus = false;
			});
			$(appendDiv).append(panel);
			setTimeHandler();
		}
		
		var domOffset = $(this).offset();
		var leftLength = domOffset.left;
		var topLength = domOffset.top;
		if (isBrowserVersonTop()) { //判断是否需要处理兼容模式
			leftLength = leftLength + xScrollLength;
			topLength = topLength + yScrollLength;
		}
		var domHeight = $(this).outerHeight();
		var domWidth = $(this).outerWidth();

		var showLeft = leftLength + domWidth;

		var showheight = topLength + domHeight;
		
		var target = $(this);
		target.mouseout(function(){
			focus = false;
		}).mouseover(function(event){
			focus = true;
			showMenuHandler();
			if (eventPosition){
				var mp = mousePosition(event);
				panel.css( {
					left : mp.x + 5 + "px",
					top : mp.y + 5 + "px"
				});
			}else{
				panel.css( {
					left : target.offset().left + "px",
					top : target.offset().top+target.outerHeight() + "px"
				});
			}
			
			panel.html("");
			/**
			 * 加载子元素
			 */
			$.each(menuData, function(i, row) {
				var action = row.action;
				var extData = row.extData;
				$("<a href='javascript:void(0)' style='font-size:12px'>" + row.name + "</a>").bind("click", function() {
					action.apply(null, extData);
				}).appendTo(panel);
			});
			
			if(menuData.length==0){
				panel.hide();
				panel.css({border:"1px"});
			}
			
		});

	}

	/***
	 *判断浏览器， IE兼容模式 ---syl
	 */
	function isBrowserVersonTop() {
		if ($.browser.msie && document.documentElement.scrollTop == 0) {
			return true;
		}
		return false;
	}
	;

	function setTimeHandler() {
		setInterval( function() {
			if(!focus){
				panel.hide();
			}
		}, 300);
	}

	function showMenuHandler() {
		panel.show();
	}

	function mousePosition(ev) {
		if (!ev)
			ev = window.event;
		if (ev.pageX || ev.pageY) {
			return {
				x : ev.pageX,
				y : ev.pageY
			};
		}
		return {
			x : ev.clientX + document.documentElement.scrollLeft
					- document.body.clientLeft,
			y : ev.clientY + document.documentElement.scrollTop
					- document.body.clientTop
		};
	}
	//自訂function 結束
	
	var menuUl = undefined;
	//menus = [{name:'',action:function,extData:[]}]
	//opts = {top:x,left:x,width:x,height:x}
	$.TeeMenu=function(menus,opts){
		if(!menuUl){
			menuUl = $("<ul class='dropdown-menu' align='center' role='menu' style='min-width:100px;z-index:100000000000'></ul>");
			$("body").append(menuUl);
			menuUl.hide();
		}
		menuUl.css({position:'absolute',left:opts.left,top:opts.top,height:"auto",width:opts.width});
		
		menuUl.html("");
		for(var i=0;i<menus.length;i++){
			var li = $("<li style='cursor:pointer'><a>"+menus[i].name+"</a></li>");
			var menu = menus[i];
			li.data("data",menu);
			li.click(function(){
				var menu = $(this).data("data");
				menu.action.apply(null,menu.extData);
			});
			menuUl.append(li);
		}
		menuUl.show();
	}
	
	$(document).click(function(){
		if(menuUl){
			menuUl.hide();
		}
	});
})(jQuery)