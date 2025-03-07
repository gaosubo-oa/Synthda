package com.xoa.model.qiyeWeixin;

public class QiyeWeixinSetting {

    /**
     * 应用url
     */
    private String url;

    /**
     * 应用密钥
     */
    private String secret;

    /**
     * 系统参数名称
     */
    private String paraName;

    /**
     * 应用id
     */
    private String agentId;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getSecret() {
        return secret;
    }

    public void setSecret(String secret) {
        this.secret = secret;
    }

    public String getParaName() {
        return paraName;
    }

    public void setParaName(String paraName) {
        this.paraName = paraName;
    }

    public String getAgentId() {
        return agentId;
    }

    public void setAgentId(String agentId) {
        this.agentId = agentId;
    }
}
