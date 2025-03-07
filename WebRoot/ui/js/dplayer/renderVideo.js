let dp = null;//用来保存视频的实例
function renderVideo(options) {
    //如果dp有值则直接return，防止重复生成视频
    if(dp) {
        return
    }
    //每次自动生成一个div用来放视频元素
    const dplayer = document.createElement('div');
    dplayer.id = 'dplayer';
    document.body.appendChild(dplayer)
    options.container = dplayer;
    //如果没有设置宽高的话，那么分别默认为500、300
    options.width = options.width || 500;
    options.height = options.height || 300;
    // 设置元素的样式
    options.container.style.position = "fixed";
    // 如果没有配置position那么默认为center
    options.position = options.position?options.position:'center';
    // 根据配置的位置的值设置options的坐标
    if(options.position === 'left') {
        options.container.style.left = "0px";
        options.container.style.top = "0px";
    }
    if(options.position === 'center') {
        options.container.style.left = "50%";
        options.container.style.top = "50%";
        options.container.style.marginLeft = -(options.width / 2)+'px';
        options.container.style.marginTop = -(options.height / 2)+'px';
    }
    if(options.position === 'right') {
        options.container.style.right = "0px";
        options.container.style.top = "0px";
    }
    // 如果坐标传递的是一个数组，那么根据数组设置坐标
    if(typeof options.position === 'object') {
        // 如果配置的是一个空数组,那么默认为center
        if(options.position.length === 0) {
            options.container.style.left = "50%";
            options.container.style.top = "50%";
            options.container.style.marginLeft = -(options.width / 2)+'px';
            options.container.style.marginTop = -(options.height / 2)+'px';
        }
        //如果数组里面只有一项，那么设置为left的值
        if(options.position.length === 1) {
            options.container.style.left = options.position[0] + 'px';
            options.container.style.top = '0px';
        }else {
            //进入此判断说明数组里面有多个值，第一项设置为left值，第二项设置为top值
            options.container.style.left = options.position[0] + 'px';
            options.container.style.top =  options.position[1] + 'px';
        }
    }
    options.container.style.width = options.width + 'px'; // 设置视频的宽度
    options.container.style.height = options.height + 'px';// 设置视频的高度
    dp = new DPlayer({
        container: options.container,// 生成视频的元素
        autoplay: options.autoplay || false,// 是否自动播放
        loop: options.loop || false,// 是否循环播放
        theme:options.theme || "#b7daff",// 主题色
        hotkey:options.hotkey||true,// 是否显示控件
        volume: options.volume||0.7,// 默认音量
        logo:options.logo || "",//是否配置logo图片
        video:{
            url:options.url|| "",//视频的路径
            pic:options.pic || "",//视频的封面
            thumbnails:options.thumbnails|| "",//配置视频缩略图
        }
    })
    // 生成关闭按钮
    const div = document.createElement('div');
    div.innerText = "x";
    div.title="关闭";
    div.className = "close-audio-btn";
    div.style.position = 'absolute';
    div.style.right = '0px';
    div.style.top = '0px';
    div.style.width = '30px';
    div.style.height = '30px';
    div.style.textAlign = 'center';
    div.style.lineHeight = '30px';
    div.style.color = '#fff';
    div.style.fontSize = '18px';
    div.style.padding = '1px';
    div.style.cursor = 'pointer';
    options.container.onmouseover = function() {
        div.style.display = 'block'
    }
    options.container.onmouseleave = function() {
        div.style.display = 'none';
    }
    div.onclick = function() {
        //如果dp没有值，说明没有视频元素，直接返回
        if(!dp) {
            return
        }
        //调用销毁视频元素的函数，销毁以后把元素从页面移除，并且dp复制为null
        dp.destroy();
        options.container.remove();
        dp = null;

    }
    options.container.appendChild(div)
}