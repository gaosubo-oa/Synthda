package com.xoa.model.equipment;

public class LimsEquipReparlogFileWithBLOBs extends LimsEquipReparlogFile {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_reparlog_file.ATTACHMENT_NAME
     *
     * @mbggenerated
     */
    private String attachmentName;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_reparlog_file.ATTACHMENT_ID
     *
     * @mbggenerated
     */
    private String attachmentId;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_reparlog_file.ATTACHMENT_NAME
     *
     * @return the value of lims_equip_reparlog_file.ATTACHMENT_NAME
     *
     * @mbggenerated
     */
    public String getAttachmentName() {
        return attachmentName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_reparlog_file.ATTACHMENT_NAME
     *
     * @param attachmentName the value for lims_equip_reparlog_file.ATTACHMENT_NAME
     *
     * @mbggenerated
     */
    public void setAttachmentName(String attachmentName) {
        this.attachmentName = attachmentName == null ? null : attachmentName.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_reparlog_file.ATTACHMENT_ID
     *
     * @return the value of lims_equip_reparlog_file.ATTACHMENT_ID
     *
     * @mbggenerated
     */
    public String getAttachmentId() {
        return attachmentId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_reparlog_file.ATTACHMENT_ID
     *
     * @param attachmentId the value for lims_equip_reparlog_file.ATTACHMENT_ID
     *
     * @mbggenerated
     */
    public void setAttachmentId(String attachmentId) {
        this.attachmentId = attachmentId == null ? null : attachmentId.trim();
    }
}