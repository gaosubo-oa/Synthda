package com.xoa.model.common;

/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/7/4 17:17
 * 类介绍  : SysPara扩展类 需要同时取其中的三个字段
 * 构造参数:
 */
public class SysParaExtend {
    private String topMenuNum;
    private String menuQuickGroup;
    private String menuWinexe;
    private String menuUrl;
    private String menuExpandSingle;

    public String getTopMenuNum() {
        return topMenuNum;
    }

    public void setTopMenuNum(String topMenuNum) {
        this.topMenuNum = topMenuNum;
    }

    public String getMenuQuickGroup() {
        return menuQuickGroup;
    }

    public void setMenuQuickGroup(String menuQuickGroup) {
        this.menuQuickGroup = menuQuickGroup;
    }

    public String getMenuWinexe() {
        return menuWinexe;
    }

    public void setMenuWinexe(String menuWinexe) {
        this.menuWinexe = menuWinexe;
    }

    public String getMenuUrl() {
        return menuUrl;
    }

    public void setMenuUrl(String menuUrl) {
        this.menuUrl = menuUrl;
    }

    public String getMenuExpandSingle() {
        return menuExpandSingle;
    }

    public void setMenuExpandSingle(String menuExpandSingle) {
        this.menuExpandSingle = menuExpandSingle;
    }
}
