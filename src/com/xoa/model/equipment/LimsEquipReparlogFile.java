package com.xoa.model.equipment;

import java.util.Date;

public class LimsEquipReparlogFile {

    public String getAttachmentName() {
        return attachmentName;
    }

    public void setAttachmentName(String attachmentName) {
        this.attachmentName = attachmentName;
    }

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_reparlog_file.FILE_ID
     *
     * @mbggenerated
     */
    private String attachmentName;

    private Integer fileId;

    public String getAttachmentId() {
        return attachmentId;
    }

    public void setAttachmentId(String attachmentId) {
        this.attachmentId = attachmentId;
    }

    private String attachmentId;
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_reparlog_file.REPALOG_ID
     *
     * @mbggenerated
     */
    private Integer repalogId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_reparlog_file.UPDATE_USER
     *
     * @mbggenerated
     */
    private String updateUser;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_reparlog_file.UPDATE_NAME
     *
     * @mbggenerated
     */
    private Date updateName;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_reparlog_file.FILE_TYPE
     *
     * @mbggenerated
     */
    private String fileType;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_reparlog_file.FILE_ID
     *
     * @return the value of lims_equip_reparlog_file.FILE_ID
     *
     * @mbggenerated
     */
    public Integer getFileId() {
        return fileId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_reparlog_file.FILE_ID
     *
     * @param fileId the value for lims_equip_reparlog_file.FILE_ID
     *
     * @mbggenerated
     */
    public void setFileId(Integer fileId) {
        this.fileId = fileId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_reparlog_file.REPALOG_ID
     *
     * @return the value of lims_equip_reparlog_file.REPALOG_ID
     *
     * @mbggenerated
     */
    public Integer getRepalogId() {
        return repalogId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_reparlog_file.REPALOG_ID
     *
     * @param repalogId the value for lims_equip_reparlog_file.REPALOG_ID
     *
     * @mbggenerated
     */
    public void setRepalogId(Integer repalogId) {
        this.repalogId = repalogId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_reparlog_file.UPDATE_USER
     *
     * @return the value of lims_equip_reparlog_file.UPDATE_USER
     *
     * @mbggenerated
     */
    public String getUpdateUser() {
        return updateUser;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_reparlog_file.UPDATE_USER
     *
     * @param updateUser the value for lims_equip_reparlog_file.UPDATE_USER
     *
     * @mbggenerated
     */
    public void setUpdateUser(String updateUser) {
        this.updateUser = updateUser == null ? null : updateUser.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_reparlog_file.UPDATE_NAME
     *
     * @return the value of lims_equip_reparlog_file.UPDATE_NAME
     *
     * @mbggenerated
     */
    public Date getUpdateName() {
        return updateName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_reparlog_file.UPDATE_NAME
     *
     * @param updateName the value for lims_equip_reparlog_file.UPDATE_NAME
     *
     * @mbggenerated
     */
    public void setUpdateName(Date updateName) {
        this.updateName = updateName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_reparlog_file.FILE_TYPE
     *
     * @return the value of lims_equip_reparlog_file.FILE_TYPE
     *
     * @mbggenerated
     */
    public String getFileType() {
        return fileType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_reparlog_file.FILE_TYPE
     *
     * @param fileType the value for lims_equip_reparlog_file.FILE_TYPE
     *
     * @mbggenerated
     */
    public void setFileType(String fileType) {
        this.fileType = fileType == null ? null : fileType.trim();
    }
}