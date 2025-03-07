function renderAudio(options) {
    let ap = null;
    ap = new APlayer({
        container: options.container || document.getElementById('player'),//播放器容器元素
        mini: options.mini || false,//开启迷你模式
        autoplay: options.autoplay || false,//音频自动播放
        theme:options.theme || '#FADFA3',//主题色
        loop: options.loop ||'all',//音频循环播放, 可选值: 'all', 'one', 'none'
        order: options.order ||'random',//音频循环顺序, 可选值: 'list', 'random'
        preload: options.preload || 'auto',//预加载，可选值: 'none', 'metadata', 'auto'
        volume: options.volume || 0.7,//默认音量，请注意播放器会记忆用户设置，用户手动设置音量后默认音量即失效
        mutex: options.mutex || true,//互斥，阻止多个播放器同时播放，当前播放器播放时暂停其他播放器
        listFolded: options.listFolded || false,//列表默认折叠
        listMaxHeight:options.listMaxHeight || 90,//	列表最大高度
        lrcType: options.lrcType || 3,
        audio: options.audio || {url:options.url}
        /**
         * audio里的对象格式如下
         *    name: 'name1', // name值
         artist: 'artist1',// 作者
         url: 'url1.mp3', // url地址
         cover: 'cover1.jpg',// 封面
         lrc: 'lrc1.lrc',
         theme: '#ebd0c2'//切换到此音频时的主题色，比上面的 theme 优先级高
         *
         */
    });
    return ap
}