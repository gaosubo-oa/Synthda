/**
 * 创建作者:   方 堃
 * 创建日期:   9:21 2019/7/20
 * 方法介绍:  layui扩展组件
 * @return
 */
layui.config({
    base: "/lib/layui/layui/lay/mymodules/",
    version: '2.1'
}).extend({
    soulTable: 'soulTable'   //子表组件
    ,eleTree: 'eleTree'     //树组件
    ,treeSelect: 'treeSelect'     //下拉树
    ,dltable:'dltable'
    ,treeTable: 'treeTable' // 树表
    ,dropdown: 'dropdown'
    ,xmSelect:'xm-select' // 下拉多选(包含下拉树，下拉多选，穿梭框等)
    ,citypicker:'city-picker'
});
