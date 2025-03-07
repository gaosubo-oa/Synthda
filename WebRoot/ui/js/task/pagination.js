$(document).ready(function () {
    $.fn.pagination = function (pagination) {

        var $this = this

        var defaults = {
            page: 1,
            pageSize: 10,
            totalCount: 0,
            onClick: function(){

            }
        }

        if (pagination) {
            defaults = $.extend({}, defaults, pagination)
        }

        if (defaults.totalCount <= defaults.pageSize){
            return false;
        }

        var $pagination = $('<ul class="pagination pagination-sm"></ul>')
        defaults.page = parseInt(defaults.page)
        var pages = Math.ceil(defaults.totalCount / defaults.pageSize)
        var currentPage = 1

        // 添加页码
        if (pages < 6) {
            for (var i = 1; i <= pages; i++) {
                var item = $('<li><a>' + i + '</a></li>')
                $pagination.append(item)
            }
            currentPage = defaults.page
        } else if (defaults.page < 4) {
            for (var i = 1; i <= 5; i++) {
                var item = $('<li><a>' + i + '</a></li>')
                $pagination.append(item)
            }
            currentPage = defaults.page
        } else if(defaults.page > pages - 2) {
            for (var i = pages - 4; i <= pages; i++) {
                var item = $('<li><a>' + i + '</a></li>')
                $pagination.append(item)
            }
            currentPage = 5 - (pages - defaults.page)
        } else {
            for (var i = defaults.page - 2; i <= defaults.page + 2; i++) {
                var item = $('<li><a>' + i + '</a></li>')
                $pagination.append(item)
            }
            currentPage = 3
        }

        var $paginationItems = $pagination.children()
        // 绑定事件
        $paginationItems.on('click', function (event) {
            defaults.page = parseInt($(this).children().eq(0).text())
            get()
        })
        // 设置当前页码样式
        $paginationItems.eq(currentPage - 1).addClass('active').off()

        var $prev = $('<li><a aria-label="Previous"><span aria-hidden="true">上一页</span></a></li>')
        var $next = $('<li><a aria-label="Next"><span aria-hidden="true">下一页</span></a></li>')
        // 添加上一页，并绑定事件
        if (defaults.page == 1) {
            $prev.addClass('disable')
        } else {
            $prev.on('click', function () {
                defaults.page = parseInt(defaults.page) - 1
                get()
            })
        }
        // 添加下一页，并绑定事件
        if (defaults.page == pages) {
            $next.addClass('disable')
        } else {
            $next.on('click', function () {
                defaults.page = parseInt(defaults.page) + 1
                get()
            })
        }

        $pagination.prepend($prev)
        $pagination.append($next)

        var $totalItem = $('<div class="total-box"><span>共' + pages + '页</span>第<input type="text" value="' + defaults.page + '"/>页<button class="btnpage">跳转</button></div>')
        //监听键盘事件，只能输入数字
        $totalItem.find('input').on('keydown', function (e) {
            var key = window.event ? e.keyCode : e.which

            if (!((key > 95 && key < 106) || (key > 47 && key < 58) || key == 8 || key == 9 || key == 13 || key == 37 || key == 39)) {
                return false
            }
            if (key == 13) {
                defaults.page = parseInt($(this).val())
                get()
            }
        })
        // 监听输入内容，不能超过页数范围
        $totalItem.find('input').on('bind',"input propertychange", function (event) {
            var value = parseInt($(this).val())
            if (value > pages) {
                $(this).val(pages)
            }
            if (value < 1) {
                $(this).val(1)
            }
        });
        // 点击跳转按钮事件
        $totalItem.find('.btnpage').on('click', function () {
            defaults.page = parseInt($totalItem.find('input').val())
            get()
        })

        $this.append($pagination, $totalItem)

        function get() {
            defaults.onClick(defaults.page)
        }

    }
});