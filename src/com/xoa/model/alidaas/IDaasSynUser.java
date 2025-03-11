package com.xoa.model.alidaas;

import java.util.List;
import java.util.Map;

public class IDaasSynUser {

    private String userName;
    private String id;
    private String displayName;
    private List<IDaasSynUserMap> emails;
    private List<IDaasSynUserMap> phoneNumbers;
    private String externalId;
    private List<IDaasSynUserMap> belongs;
    private Boolean locked;
    private Map<String, Object> extendField;
    private Boolean admin;
    private String masterSalt;
    private Boolean originalPass;
    private String password;
    private String pushIntention;
    private String masterSecret;

    public String getUserName() { return userName; }

    public void setUserName(String userName) { this.userName = userName; }

    public String getId() { return id; }

    public void setId(String id) { this.id = id; }

    public String getDisplayName() { return displayName; }

    public void setDisplayName(String displayName) { this.displayName = displayName; }

    public List<IDaasSynUserMap> getEmails() { return emails; }

    public void setEmails(List<IDaasSynUserMap> emails) { this.emails = emails; }

    public List<IDaasSynUserMap> getPhoneNumbers() { return phoneNumbers; }

    public void setPhoneNumbers(List<IDaasSynUserMap> phoneNumbers) { this.phoneNumbers = phoneNumbers; }

    public String getExternalId() { return externalId; }

    public void setExternalId(String externalId) { this.externalId = externalId; }

    public List<IDaasSynUserMap> getBelongs() { return belongs; }

    public void setBelongs(List<IDaasSynUserMap> belongs) { this.belongs = belongs; }

    public Boolean getLocked() { return locked; }

    public void setLocked(Boolean locked) { this.locked = locked; }

    public Map<String, Object> getExtendField() { return extendField; }

    public void setExtendField(Map<String, Object> extendField) { this.extendField = extendField; }

    public Boolean getAdmin() { return admin; }

    public void setAdmin(Boolean admin) { this.admin = admin; }

    public String getMasterSalt() { return masterSalt; }

    public void setMasterSalt(String masterSalt) { this.masterSalt = masterSalt; }

    public Boolean getOriginalPass() { return originalPass; }

    public void setOriginalPass(Boolean originalPass) { this.originalPass = originalPass; }

    public String getPassword() { return password; }

    public void setPassword(String password) { this.password = password; }

    public String getPushIntention() { return pushIntention; }

    public void setPushIntention(String pushIntention) { this.pushIntention = pushIntention; }

    public String getMasterSecret() { return masterSecret; }

    public void setMasterSecret(String masterSecret) { this.masterSecret = masterSecret; }
}
