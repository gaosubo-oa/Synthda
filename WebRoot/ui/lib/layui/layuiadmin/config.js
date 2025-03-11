/**

 @Name：layuiAdmin iframe版全局配置
 @Author：贤心
 @Site：http://www.layui.com/admin/
 @License：LPPL（layui付费产品协议）
    
 */
 
layui.define(['laytpl', 'layer', 'element', 'util'], function(exports){
  exports('setter', {
    container: 'LAY_app' //容器ID
    ,base: layui.cache.base //记录静态资源所在路径
    ,views: layui.cache.base + 'tpl/' //动态模板所在目录
    ,entry: 'index' //默认视图文件名
    ,engine: '.html' //视图文件后缀名
    ,pageTabs: true //是否开启页面选项卡功能。iframe版推荐开启
    
    ,name: 'layuiAdmin'
    ,tableName: 'layuiAdmin' //本地存储表名
    ,MOD_NAME: 'admin' //模块事件名
    
    ,debug: true //是否开启调试模式。如开启，接口异常时会抛出异常 URL 等信息

    //自定义请求字段
    ,request: {
      tokenName: false //自动携带 token 的字段名（如：access_token）。可设置 false 不携带。
    }
    
    //自定义响应字段
    ,response: {
      statusName: 'code' //数据状态的字段名称
      ,statusCode: {
        ok: 0 //数据状态一切正常的状态码
        ,logout: 1001 //登录状态失效的状态码
      }
      ,msgName: 'msg' //状态信息的字段名称
      ,dataName: 'data' //数据详情的字段名称
    }
    
    //扩展的第三方模块
    ,extend: [
      'echarts', //echarts 核心包
      'echartsTheme' //echarts 主题
    ]
    
    //主题配置
    ,theme: {
      //内置主题配色方案
      color: [{
        main: '#05294b'
        ,logo: '#042341'
        ,selected: '#05294b'
        ,header: '#05294b'
        ,alias: '海洋头' //海洋头
      },{
        main: '#344058'
        ,logo: '#ea322f'
        ,selected: '#dd2e2c'
        ,header: '#dd2e2c'
        ,alias: '政务红' //政务红
      },{
        logo: '#226A62'
        ,header: '#2F9688'
        ,alias: '墨绿头' //墨绿头
      },{
        header: '#393D49'
        ,alias: '经典黑头' //经典黑头
      },{
        main: '#50314F'
        ,logo: '#50314F'
        ,selected: '#7A4D7B'
        ,header: '#50314F'
        ,alias: '紫红头' //紫红头
      },{
        main: '#28333E'
        ,logo: '#28333E'
        ,selected: '#AA3130'
        ,header: '#AA3130'
        ,alias: '时尚红头' //时尚红头
      },{
        main: '#1E9FFF'
        ,logo: '#0085E8'
        ,selected: '#0085E8'
        ,header: '#1E9FFF'
        ,alias: '海洋风格' //海洋头
      },{
        main: '#dd2e2c'
        ,logo: '#ea322f'
        ,selected: '#ea322f'
        ,header: '#dd2e2c'
        ,alias: '政务风格' //政务红
      },{
        main: '#2F9688',
        logo: '#226A62'
        ,selected: '#226A62'
        ,header: '#2F9688'
        ,alias: '墨绿风格' //墨绿头
      },{
        main: '#344058'
        ,logo: '#1E9FFF'
        ,selected: '#1E9FFF'
        ,header: '#8b8989'
        ,alias: '海洋' //海洋
      },{
        main: '#344058'
        ,logo: '#dd2e2c'
        ,selected: '#dd2e2c'
        ,header: '#8b8989'
        ,alias: '大红' //大红
      },{
        main: '#3A3D49'
        ,logo: '#2F9688'
        ,selected: '#5FB878'
        ,header: '#8b8989'
        ,alias: '墨绿' //墨绿
      },{
        main: '#03152A'
        ,selected: '#3B91FF'
        ,header: '#8b8989'
        ,alias: '藏蓝' //藏蓝
      },{
        main: '#2E241B'
        ,selected: '#A48566'
        ,header: '#8b8989'
        ,alias: '咖啡' //咖啡
      },{
        main: '#50314F'
        ,selected: '#7A4D7B'
        ,header: '#8b8989'
        ,alias: '紫红' //紫红
      },{
        main: '#20222A'
        ,logo: '#F78400'
        ,selected: '#F78400'
        ,header: '#8b8989'
        ,alias: 'red' //橙色
      },{
        main: '#28333E'
        ,logo: '#AA3130'
        ,selected: '#AA3130'
        ,header: '#8b8989'
        ,alias: 'fashion-red' //时尚红
      },{
        main: '#24262F'
        ,logo: '#3A3D49'
        ,selected: '#009688'
        ,header: '#8b8989'
        ,alias: 'classic-black' //经典黑
      }]
      
      //初始的颜色索引，对应上面的配色方案数组索引
      //如果本地已经有主题色记录，则以本地记录为优先，除非请求本地数据（localStorage）
      ,initColorIndex: $.cookie('color')||0
    }
  });
});
