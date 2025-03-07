package com.xoa.model.fulltext;

import java.util.Map;

public class AttachmentIndexSwitch {
    private String alldocIndexYn;//开关
    private String alldocIndexDotime;
    private String beginTime;//开始时间
    private String endTime; // 结束时间
    private String alldocIndexFileNum; //索引文件个数
    private String alldocIndexFileType;
    private String wordIndex; // word 开关
    private String excleIndex; // excl 开关
    private String pptIndex; // ppt 开关
    private String pdfIndex; // pdf 开关
    private String htmlIndex; // html 开关
    private String txtIndex; // txt 开关
    private  Map<String, Object>  attachAll; // 文件总数
    private Map<String,Object>  attachIndex; // 已索引文件数
    private String percentage; //索引进度
    public String getAlldocIndexYn() {
        return alldocIndexYn;
    }

    public void setAlldocIndexYn(String alldocIndexYn) {
        this.alldocIndexYn = alldocIndexYn;
    }

    public String getAlldocIndexDotime() {
        return alldocIndexDotime;
    }

    public void setAlldocIndexDotime(String alldocIndexDotime) {
        this.alldocIndexDotime = alldocIndexDotime;
    }

    public String getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(String beginTime) {
        this.beginTime = beginTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getAlldocIndexFileNum() {
        return alldocIndexFileNum;
    }

    public void setAlldocIndexFileNum(String alldocIndexFileNum) {
        this.alldocIndexFileNum = alldocIndexFileNum;
    }

    public String getAlldocIndexFileType() {
        return alldocIndexFileType;
    }

    public void setAlldocIndexFileType(String alldocIndexFileType) {
        this.alldocIndexFileType = alldocIndexFileType;
    }

    public String getWordIndex() {
        return wordIndex;
    }

    public void setWordIndex(String wordIndex) {
        this.wordIndex = wordIndex;
    }

    public String getExcleIndex() {
        return excleIndex;
    }

    public void setExcleIndex(String excleIndex) {
        this.excleIndex = excleIndex;
    }

    public String getPptIndex() {
        return pptIndex;
    }

    public void setPptIndex(String pptIndex) {
        this.pptIndex = pptIndex;
    }

    public String getPdfIndex() {
        return pdfIndex;
    }

    public void setPdfIndex(String pdfIndex) {
        this.pdfIndex = pdfIndex;
    }

    public String getHtmlIndex() {
        return htmlIndex;
    }

    public void setHtmlIndex(String htmlIndex) {
        this.htmlIndex = htmlIndex;
    }

    public String getTxtIndex() {
        return txtIndex;
    }

    public void setTxtIndex(String txtIndex) {
        this.txtIndex = txtIndex;
    }

    public String getPercentage() {
        return percentage;
    }

    public void setPercentage(String percentage) {
        this.percentage = percentage;
    }

    public Map<String, Object> getAttachAll() {
        return attachAll;
    }

    public void setAttachAll(Map<String, Object> attachAll) {
        this.attachAll = attachAll;
    }

    public Map<String, Object> getAttachIndex() {
        return attachIndex;
    }

    public void setAttachIndex(Map<String, Object> attachIndex) {
        this.attachIndex = attachIndex;
    }
}
