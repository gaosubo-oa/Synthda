package com.xoa.model.knowledge;

import com.xoa.util.common.DataTree;

public class ClumnTree extends DataTree {
    private boolean isSysCode;
    private String codeNo;

    public boolean isSysCode() {
        return isSysCode;
    }

    public void setSysCode(boolean sysCode) {
        isSysCode = sysCode;
    }

    public String getCodeNo() {
        return codeNo;
    }

    public void setCodeNo(String codeNo) {
        this.codeNo = codeNo;
    }
}
