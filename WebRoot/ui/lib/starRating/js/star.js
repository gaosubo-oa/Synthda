/* 
* @Author: anchen
* @Date:   2018-03-22 18:59:48
* @Last Modified by:   anchen
* @Last Modified time: 2018-03-22 19:02:23
*/

//构造一个匿名函数，返回的结果赋予给rating
   var rating = (function(){

       //模式
       var pattern = {
          entire:function(){ //整颗星
            return 1;
          },
          half:function(){  //半颗星
            return 2;
          }
       };
       //评分
       var Rating = function(el,options){
           this.$el = $(el);
           this.opts = $.extend({}, defaults, options);  
           if(!pattern[this.opts.modus]){//如果传入的方法错误，则默认点亮整颗星
             this.opts.modus = 'entire'
           }
           this.ratio = pattern[this.opts.modus]();  //正确则选择的点亮模式 
           this.opts.total *= this.ratio;
           this.opts.num *= this.ratio;
           this.itemWidth = 20/this.ratio; //每颗星星宽度(自行设置)
           this.displyWidht = this.itemWidth*this.opts.num; //点亮展示层的宽度
       };
       //默认参数
       defaults = {
          modus:'entire',//默认点亮模式
          total:5, //星星个数
          num:2, //默认点亮个数
          readOnly:false,//是否只读
          select:function(){}, //鼠标滑过的事件
          chosen:function(){}//鼠标点击的事件
       };

       //初始化方法
       Rating.prototype.init = function(){
          this.buildHTML(); //动态创建HTML
          this.setCSS();//设置属性CSS
          if(!this.opts.readOnly){ //判断是否是只读，如果不是
              this.bindEvent()//鼠标绑定事件
          }         
       };   

       Rating.prototype.buildHTML = function(){
          var starHtml = '';
          starHtml += '<div class="rating-disply"></div><ul class="rating-mask">';
          for(var i = 0; i < this.opts.total; i++){
             starHtml += '<li class="rating-item"></li>';
          }
             starHtml += '</ul>';
             this.$el.html(starHtml);
       };
       Rating.prototype.setCSS = function(){
             this.$el.width(this.opts.total * this.itemWidth);//父容器总宽度
             this.$display = this.$el.find('.rating-disply');
             this.$display.width(this.displyWidht);//展示层宽度
             this.$el.find('.rating-item').width(this.itemWidth);//每颗星星宽度
       };
       Rating.prototype.bindEvent = function(){
             var self = this;
             self.$el.on('mouseover','.rating-item',function(){
                var count = $(this).index() + 1;//当前点亮个数
                self.$display.width(count * self.itemWidth);
                (typeof self.opts.select === 'function') && self.opts.select.call(this,count,self.opts.total);
                self.$el.trigger('select',[count,self.opts.total]); 
             }).on('click','.rating-item',function(){
                var count = $(this).index() + 1;
                self.displyWidht = count * self.itemWidth;
                (typeof self.opts.chosen === 'function') && self.opts.chosen.call(this,count,self.opts.total);
                self.$el.trigger('chosen',[count,self.opts.total]); 
             }).on('mouseout',function(){
                self.$display.width(self.displyWidht);
             });
       };

       Rating.prototype.unbindEvent = function(){ //解绑定事件
             this.$el.off();
       }


      //初始化函数
      var init = function(el,option){//实例化Rating函数，执行init方法
          //new Rating(el,option).init();
          var $el = $(el),
              rating = $el.data('rating'); 
          if(!rating){
              $el.data('rating',(rating = new Rating(el,typeof option === 'object' && option)));
               rating.init();
          }
          if(typeof option === 'string') rating[option]();
              
      };

      //封装jq插件
      $.fn.extend({ //插件名star
          star:function(option){
            return this.each(function() {
               init(this,option)
            });
          }
      });
      
      
     //返回一个对象，对象执行init方法
     return {
        init:init
     }

   })();
