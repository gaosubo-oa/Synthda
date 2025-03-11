package com.xoa.model.fullTextSearch;

/**
 * Created by gsb on 2018/3/15.
 */
public class AllTodoListModel {
    private String name;
    private String img;
    private String code;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getCode() {
        return code==null?"0":code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}



