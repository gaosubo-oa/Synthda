package com.xoa.util;

import com.xoa.model.enclosure.Attachment;
import com.xoa.model.users.OrgManage;
import com.xoa.service.enclosure.EnclosureService;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.PostConstruct;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Component
public class GetAttachmentListUtil {

    public static final String MODULE_ATTEND = "attend"; //电子邮件
    public static final String MODULE_EMAIL = "email"; //电子邮件

    public static final String MODULE_WORKFLOW = "workflow"; //工作流
    public static final String MODULE_FILE_FOLDER = "file_folder"; //文件柜
    public static final String MODULE_NOTIFY = "notify"; //公告通知
    public static final String MODULE_TASKMANAGE = "taskManage"; //任务督办
    public static final String MODULE_NEWS = "news"; //新闻
    public static final String MODULE_DIARY = "diary"; //工作日志
    public static final String MODULE_BBS = "bbs"; //讨论区
    public static final String MODULE_BOOK = "book"; //图书管理
    public static final String MODULE_CRM = "crm"; //CRM
    public static final String MODULE_DOCUMENT = "document"; //公文管理
    public static final String MODULE_FAX = "fax"; //电子传真
    public static final String MODULE_HR = "hr"; //人力资源
    public static final String MODULE_MEETING = "meeting"; //会议管理
    public static final String MODULE_OFFICE_PRODUCT = "office_product"; //办公用品
    public static final String MODULE_PROJECT = "project"; //项目管理
    public static final String MODULE_REPORTSHOP = "reportshop"; //报表管理
    public static final String MODULE_ROLL_MANAGE = "roll_manage"; //档案管理
    public static final String MODULE_SALE_MANAGE = "sale_manage"; //销售管理
    public static final String MODULE_TRAINING = "training"; //培训管理
    public static final String MODULE_VEHICLE = "vehicle"; //车辆管理
    public static final String MODULE_VOTE = "vote"; //投票
    public static final String MODULE_WORK_PLAN = "work_plan"; //工作计划
    public static final String MODULE_ZHIDAO = "zhidao"; //OA知道
    public static final String MODULE_UNIT = "unit"; //单位管理
    public static final String MODULE_MODEL = "model"; //Word模板
    public static final String MODULE_IM = "im"; //即时通讯
    public static final String MODULE_EXT_DATA = "ext_data"; //数据交互平台
    public static final String MODULE_ASSET = "fixAssets"; //固定资产
    public static final String MODULE_UNKNOWN = "unknown"; //其它
    public static final String MODULE_ADDRESS = "address"; //通讯簿
    public static final String MODULE_VOICEMSG = "voicemsg"; //语音微讯
    public static final String MODULE_PORTAL = "portal"; //门户
    public static final String MODULE_WEIXUNSHARE = "weixunshare"; //微讯分享
    public static final String MODULE_SAFEDOC = "safedoc"; //安全文档中心
    public static final String MODULE_UPLOAD_TEMP = "upload_temp"; //临时文件夹
    public static final String MODULE_ITASK = "itask"; //智协同
    public static final String MODULE_SYS = "sys"; //系统管理
    public static final String MODULE_SUMMARY_MEET = "summary_meet"; //会议纪要
    public static final String MODULE_HRSTAFFCONTRACT = "hr_staffcontract"; //人力资源
    public static final String MODULE_HRSTAFFINFO = "hr_staffinfo"; //人力资源
    public static final String MODULE_SEAL = "seal"; //印章
    public static final String MODULE_INTERFACE = "interface"; //印章
    public static final String WE_CHAT = "wechat"; //印章
    public static final String EMAIL_COUNT = "emailCount"; //邮件统计
    public static final String RMS_FILE = "rmsFile"; //邮件统计
    public static final String MODULE_USERJOB="userjob"; //岗位附件
    public static final String MODULE_USERPOST="userpost"; //职务附件
    public static final String EDU_ATTEND="eduAttend";//学生请假查询
    public static final String EDU_DXFW="edu_dxfw";//校园短信
    public static final String SUPERVISION="supervision";//督办发表反馈
    public static final String SUPERVISE="supervise";//督办
    public static final String TIMELINE="timeline";//督办
    public static final String INCENTIVE="incentive";//奖惩
    public static final String WORKEXPERIENCE="workexperience";//工作经历
    public static final String MODULE_INFORMATION="infomation";//信息报送
    public static final String MODULE_INFORMATION_IMG="infomation_img";//信息报送图片附件
    public static final String USER_IMAGE = "user";
    public static final String CONTRACT="contract"; //合同
    public static final String HEALTHY_INFO="healthyInfo";//学生健康信息
    public static final String MODULE_PZ_RELEASE="pz_release"; //刑满释放
    public static final String MODULE_PZ_DRUG="pz_drug"; //吸毒人员
    public static final String MODULE_PZ_YOUTH="pz_youth"; //重点青少年
    public static final String MODULE_PZ_CORRECTION="pz_correction"; //社区矫正
    public static final String MODULE_PZ_EASY="pz_easy"; //易肇事
    public static final String MODULE_PZ_PETITION="pz_petition"; //重点信访人员
    public static final String MODULE_PZ_PERSONSERVICE="pz_personservice"; //重点信访人员
    public static final String MODULE_grid="grid"; //石原
    public static final String MODULE_PZ_PERSON="pz_person"; //人员
    public static final String MODULE_parameter="parameter"; //石原
    public static final String MODULE_PZ_HOUSESERVICE="pz_house_service"; //邳州出租房
    public static final String MODULE_photo="photo"; //照片
    public static final String MODULE_attachment="attachment"; //附件
    public static final String MODULE_INFO="baosong"; //电子邮件
    public static final String MODULE_PLANCHECK="plancheck";//计划与考核
    public static final String MODULE_FLOW_TYPE_ICON="flow_icon";//流程图标


    @Autowired
    private EnclosureService enclosureService;

    private static GetAttachmentListUtil getAttachmentListUtil;


    @PostConstruct
    public void init() {
        getAttachmentListUtil = this;
        getAttachmentListUtil.enclosureService = this.enclosureService;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-27 下午1:56:05
     * 方法介绍:   返回附件集合
     * 参数说明:   @param attachmentName
     * 参数说明:   @param attachmentId
     * 参数说明:   @return
     *
     * @return List<Attachment>
     */
    public static List<Attachment> returnAttachment(String attachmentName, String attachmentId, String sqlType, String module) {
        List<Attachment> list = new ArrayList<Attachment>();
        if(StringUtils.checkNull(sqlType)){

            HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            sqlType = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
        }
        //查询是否kingbase环境
        String driver = FileUploadUtil.getDriver();
        if("kingbase8".equals(driver) && !sqlType.contains("KB")){
            sqlType = sqlType.replace("xoa","xoaKB");
        }else if("dm".equals(driver) && !sqlType.contains("DM")){

        }
        if (StringUtils.checkNull(attachmentId) && StringUtils.checkNull(attachmentName)) {
            return list;
        } else {
            try {
                if (attachmentId.contains("@")) {
                    String[] attachmentIds = attachmentId.split(",");
                    String[] attachmentNames = attachmentName.split("\\*");
                    int attachmentidLength = attachmentIds.length;
                    for (int i = 0; i < attachmentidLength; i++) {
                        Attachment attachment = getAttachmentListUtil.enclosureService.findByAttachId(Integer.parseInt(attachmentIds[i].substring(0, attachmentIds[i].indexOf("@"))));
                        if (attachment != null) {
                            attachment.setAttUrl("AID=" + attachment.getAid() + "&MODULE=" + module + "&COMPANY=" + sqlType + "&YM=" + attachment.getYm() + "&ATTACHMENT_ID=" + attachment.getAttachId() + "&ATTACHMENT_NAME=" + attachment.getAttachName());
                            StringBuffer id = new StringBuffer();
                            StringBuffer name = new StringBuffer();
                            int aid = attachment.getAid();
                            String attachId = attachment.getAttachId();
                            String ym = attachment.getYm();
                            String attachName = attachment.getAttachName();
                            String all = aid + "@" + ym + "_" + attachId;
                            id.append(all).append(",");
                            name.append(attachName).append("*");
                            attachment.setId(id.toString());
                            attachment.setName(name.toString());
                            list.add(attachment);
                        }

                    }
                } else {

                    String[] attachmentIds = attachmentId.split(",");
                    String[] attachmentNames = attachmentName.split("\\*");
                    int attachmentidLength = attachmentIds.length;
                    for (int i = 0; i < attachmentidLength; i++) {
                /*		Attachment att = new Attachment();
						att.setAttachName(attachmentNames[i]);
						att.setAid(1024);
						att.setYm(attachmentIds[i].substring(0, attachmentIds[i].lastIndexOf("_")));
						att.setAttachId(Integer.valueOf(attachmentIds[i].substring(attachmentIds[i].indexOf("_") + 1, attachmentIds[i].length())));
						att.setAttUrl("AID=" + att.getAid() + "&MODULE=" + module + "&COMPANY=" + sqlType + "&YM=" + att.getYm() + "&ATTACHMENT_ID=" + att.getAttachId() + "&ATTACHMENT_NAME=" + att.getAttachName());
					*/
                       // Attachment attachment = getAttachmentListUtil.enclosureService.findByAttachId(Integer.parseInt(attachmentIds[i].substring(0, attachmentIds[i].indexOf("@"))));
                        Attachment attachment = null;

                        if(attachmentIds[i].split("\\.").length==2){
                            attachmentIds[i] = attachmentIds[i].substring(0,attachmentIds[i].indexOf("."));
                            attachment = getAttachmentListUtil.enclosureService.findByAttachId1(Integer.valueOf(attachmentIds[i].substring(attachmentIds[i].indexOf("_") + 1)));
                        } else {
                            attachment = getAttachmentListUtil.enclosureService.findByAttachId1(Integer.valueOf(attachmentIds[i].substring(attachmentIds[i].indexOf("_") + 1)));
                        }


                        if (attachment != null) {
                            attachment.setAttUrl("AID=" + attachment.getAid() + "&MODULE=" + module + "&COMPANY=" + sqlType + "&YM=" + attachment.getYm() + "&ATTACHMENT_ID=" + attachment.getAttachId() + "&ATTACHMENT_NAME=" + attachment.getAttachName());
                            StringBuffer id = new StringBuffer();
                            StringBuffer name = new StringBuffer();
                            int aid = attachment.getAid();
                            String attachId = attachment.getAttachId();
                            String ym = attachment.getYm();
                            String attachName = attachment.getAttachName();
                            String all = aid + "@" + ym + "_" + attachId;
                            id.append(all).append(",");
                            name.append(attachName).append("*");

                            attachment.setId(id.toString());
                            attachment.setName(name.toString());

                            list.add(attachment);
                        }else{
                            attachment = new Attachment();
                            attachment.setAttachId(attachmentIds[i].split("_")[1]);
                            attachment.setYm(attachmentIds[i].split("_")[0]);
                            attachment.setAttUrl("isOld=1&AID=&MODULE="+module+"&COMPANY="+sqlType+"&YM="+attachmentIds[i].split("_")[0]+"&ATTACHMENT_ID="+attachmentIds[i].split("_")[1]+"&ATTACHMENT_NAME="+attachmentNames[i]);
                            attachment.setName(attachmentNames[i]);
                            attachment.setAttachName(attachmentNames[i]);
                            list.add(attachment);
                        }


                    }

                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            return list;
        }


    }
}
