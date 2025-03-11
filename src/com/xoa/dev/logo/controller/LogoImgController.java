package com.xoa.dev.logo.controller;


import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.enclosure.AttachmentMapper;
import com.xoa.dao.sys.SysInterfaceMapper;
import com.xoa.dao.users.OrgManageMapper;
import com.xoa.model.common.SysPara;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.sys.InterfaceModel;
import com.xoa.service.sys.InterFaceService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.GetAttachmentListUtil;
import com.xoa.util.PinYinUtil;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

@Controller
public class LogoImgController {

    @Autowired
    InterFaceService interFaceService;

    @Autowired
    SysInterfaceMapper sysInterfaceMapper;

    @Autowired
    AttachmentMapper attachmentMapper;

    @Autowired
    OrgManageMapper orgManageMapper;

    @Autowired
    SysParaMapper sysParaMapper;




    @RequestMapping("/LogoImg")
    public void LogoImg(HttpServletRequest request, HttpServletResponse response) {
        List<InterfaceModel> interfaceModelList = this.getInterfaceInfo(request);
        if (interfaceModelList != null && interfaceModelList.size() > 0 &&
                interfaceModelList.get(0).getAttachment2() != null && interfaceModelList.get(0).getAttachment2().size() > 0) {
            InterfaceModel interfaceModel = interfaceModelList.get(0);
            Attachment attachment = interfaceModel.getAttachment2().get(0);
            /*String company = ContextHolder.getConsumerType();
            if (StringUtils.checkNull(company) || "xoanull".equals(company.toLowerCase())) {
                List<OrgManage> org = orgManageMapper.queryId();
                if (org != null && org.size() > 0) {
                    company = "xoa" + org.get(0).getOid().toString().trim();
                }
            }*/
            String company = this.getSqlType(request);
            ContextHolder.setConsumerType(company);
            if (PinYinUtil.checkChinese(attachment.getAttachName())) {
                String path = this.getPath() + System.getProperty("file.separator") + company +
                        System.getProperty("file.separator") + "interface" + System.getProperty("file.separator") + attachment.getYm() + System.getProperty("file.separator") + attachment.getAttachId() + "." + attachment.getAttachName();
                File f = new File(path);
                String newPath = path.replace(attachment.getAttachName().substring(0, attachment.getAttachName().indexOf(".")), "loginLogo");
                f.renameTo(new File(newPath));
                String stem = attachment.getAttachName().substring(0, attachment.getAttachName().indexOf("."));
                String attrul = attachment.getAttUrl().replace(stem, "loginLogo");
                interfaceModelList.get(0).getAttachment2().get(0).setAttUrl(attrul);
                interfaceModel.setAttachmentName2(interfaceModel.getAttachmentName2().replace(stem, "loginLogo"));
                sysInterfaceMapper.updateInterfaceInfo(interfaceModel);
                attachment.setAttachName(attachment.getAttachName().replace(stem, "loginLogo"));
                attachment.setAttachFile(attachment.getAttachName());
                attachmentMapper.updateByPrimaryKeySelective(attachment);
            }
            String path = this.getPath() + System.getProperty("file.separator") + company +
                    System.getProperty("file.separator") + "interface" + System.getProperty("file.separator") + attachment.getYm() + System.getProperty("file.separator") + attachment.getAttachId() + "." + attachment.getAttachName();
            File f = new File(path);
            if (!f.exists()){
               path=request.getSession().getServletContext().getRealPath("/")+"ui/img/replaceImg/theme1/LOGO.png";
            }
            try (FileInputStream inputStream = new FileInputStream(new File(path));
            OutputStream os = response.getOutputStream();){
                byte[] b = new byte[2048];
                int length;
                while ((length = inputStream.read(b)) > 0) {
                    os.write(b, 0, length);
                }
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }

        }
    }

        public String getPath () {
            //读取配置文件
            ResourceBundle rb = ResourceBundle.getBundle("upload");
            String osName = System.getProperty("os.name");
            StringBuffer sb = new StringBuffer();
            if (osName.toLowerCase().startsWith("win")) {
                //sb=sb.append(rb.getString("upload.win"));
                //判断路径是否是相对路径，如果是的话，加上运行的路径
                String uploadPath = rb.getString("upload.win");
                if (uploadPath.indexOf(":") == -1) {
                    //获取运行时的路径
                    String basePath = this.getClass().getClassLoader().getResource(".").getPath() + File.pathSeparator;
                    //获取截取后的路径
                    String str2 = "";
                    if (basePath.indexOf("/xoa") != -1) {
                        //获取字符串的长度
                        int length = basePath.length();
                        //返回指定字符在此字符串中第一次出现处的索引
                        int index = basePath.indexOf("/xoa");
                        //从指定位置开始到指定位置结束截取字符串
                        str2 = basePath.substring(0, index);
                    }
                    sb = sb.append(str2 + "/xoa");
                }
                sb.append(uploadPath);
            } else {
                sb = sb.append(rb.getString("upload.linux"));
            }
            return sb.toString();
        }



    public List<InterfaceModel> getInterfaceInfo(HttpServletRequest request) {
        // 设置默认库
//            String dataSource = null;
//            // 1.先查询主组织即 org_manage 中的 is_org =1 的库 如果存在的话  直接使用该库
//            List<OrgManage> orgManages = orgManageMapper.selOrgManageIsOrg();
//            if(orgManages!=null&&orgManages.size()>0){
//                OrgManage orgManage = orgManages.get(0);
//                if(orgManage!=null){
//                    Integer oid = orgManage.getOid();
//                    dataSource = oid.toString();
//                }
//            }
//            if (StringUtils.checkNull(dataSource)){
//                // 2.如果没有主组织的情况下 默认1001；
//                dataSource = "1001";
//            }
        //默认显示主组织，xoa1000有表则主组织是xoa1000,没有表则为xoa1001；
       String sqlType = this.getSqlType(request);
            ContextHolder.setConsumerType(sqlType);
        List<InterfaceModel> interfaceModelList = sysInterfaceMapper.getInterfaceInfo();
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String theme = SessionUtils.getSessionInfo(request.getSession(), "InterfaceModel", String.class, redisSessionCookie);
        String AttachmentImgUrl = "/img/replaceImg/" + theme + "/LOGOMain.png";
        for (InterfaceModel interfaceModel : interfaceModelList) {
            if (!StringUtils.checkNull(interfaceModel.getAttachmentName()) && !StringUtils.checkNull(interfaceModel.getAttachmentId())) {
                List<Attachment> attachment = GetAttachmentListUtil.returnAttachment(
                        interfaceModel.getAttachmentName(), interfaceModel.getAttachmentId(), sqlType,
                        GetAttachmentListUtil.MODULE_INTERFACE);
                if (attachment != null && attachment.size() > 0) {
                    interfaceModel.setAttachment(attachment);
                    interfaceModel.setJudgeAttachmentUrl("/xs?"+attachment.get(0).getAttUrl().replaceAll("xoanull", sqlType));
                } else {
                    interfaceModel.setJudgeAttachmentUrl(AttachmentImgUrl);
                }
            } else {
                interfaceModel.setJudgeAttachmentUrl(AttachmentImgUrl);
            }
            if (interfaceModel.getAttachmentName2() != null && interfaceModel.getAttachmentId2() != null) {
                interfaceModel.setAttachment2(GetAttachmentListUtil.returnAttachment(
                        interfaceModel.getAttachmentName2(), interfaceModel.getAttachmentId2(), sqlType,
                        GetAttachmentListUtil.MODULE_INTERFACE));
            }
            if (interfaceModel.getAttachmentName3() != null && interfaceModel.getAttachmentId3() != null) {
                interfaceModel.setAttachment3(GetAttachmentListUtil.returnAttachment(
                        interfaceModel.getAttachmentName3(), interfaceModel.getAttachmentId3(), sqlType,
                        GetAttachmentListUtil.MODULE_INTERFACE));
            }
            if (interfaceModel.getAttachmentName4() != null && interfaceModel.getAttachmentId4() != null) {
                interfaceModel.setAttachment4(GetAttachmentListUtil.returnAttachment(
                        interfaceModel.getAttachmentName4(), interfaceModel.getAttachmentId4(), sqlType,
                        GetAttachmentListUtil.MODULE_INTERFACE));
            }

        }

        return interfaceModelList;
    }

    public String getSqlType(HttpServletRequest request){

        SysPara sysParaCloudOa = sysParaMapper.querySysPara("CLOUD_OA");
        if (sysParaCloudOa!=null){
            if ("1".equals(sysParaCloudOa.getParaValue())){
                Integer oid ;
                String serverName = request.getServerName();
                String[] split = serverName.split("\\.");
                if (split[0].length() == 4) {
                    oid = Integer.parseInt(split[0]);
                    return "xoa"+oid;
                }

            }
        }
        return "xoa1001";
    }


}
