package com.xoa.util.email;

import com.sun.mail.util.MailSSLSocketFactory;
import com.xoa.dao.enclosure.AttachmentMapper;
import com.xoa.dev.crossEmail.model.EmailBodyPlusModel;
import com.xoa.model.email.EmailBodyModel;
import com.xoa.model.email.Webmail;
import com.xoa.model.enclosure.Attachment;
import com.xoa.service.sys.SysTasksService;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;
import sun.misc.BASE64Encoder;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.mail.*;
import javax.mail.internet.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.Security;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;


/**
 * 创建作者:   张勇
 * 创建日期:   2017/6/12 20:08
 * 方法介绍:   外部邮箱发送
 * 参数说明:
 *
 * @return
 */

@Component
@SuppressWarnings("all")
public class EmailUtil {

    @Resource
    private SysTasksService sysTasksService;

    @Resource
    private AttachmentMapper attachmentMapper;

    // 维护一个本类的静态变量
    private static EmailUtil emailUtil;

    // 初始化的时候，将本类中的mailSender赋值给静态的本类变量
    @PostConstruct
    public void init() {
        emailUtil = this;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/6/14 20:15
     * 方法介绍:   session处理
     * 参数说明:
     *
     * @return
     */
    public static Session webEmailLogin(Webmail webmail) {
        String host = webmail.getSmtpServer();
        String port = webmail.getSmtpPort().toString();
        final String username = webmail.getEmailUser();
        final String password = webmail.getEmailPass();
        Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
        final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
        Properties props = System.getProperties();

        props.put("mail.smtp.auth", "true");//接受服务器认证
        props.setProperty("mail.transport.protocol", "smtp");//设置发送协议
        props.setProperty("mail.smtp.host", host);
        props.setProperty("mail.smtp.port", port);
        props.setProperty("mail.smtp.socketFactory.port", port);
        props.setProperty("mail.smtp.socketFactory.fallback", "false");
        props.setProperty("mail.smtp.starttls.enable", "false");

//        判断是否是SSL
        if("1".equals(webmail.getSmtpSsl())){
            props.put("mail.smtp.ssl.enable", "true");
            MailSSLSocketFactory sf = null;
            try {
                sf = new MailSSLSocketFactory();
                sf.setTrustAllHosts(true);
            } catch (GeneralSecurityException e1) {
                e1.printStackTrace();
            }
            props.put("mail.smtp.ssl.socketFactory", sf);
        }else{
            props.put("mail.smtp.ssl.enable", "false");
            if(props.getProperty("mail.smtp.socketFactory.class")!=null){
                props.remove("mail.smtp.socketFactory.class");
            }
        }
        Session session = Session.getInstance(props, new Authenticator() {  //策略模式
            @Override
            protected PasswordAuthentication getPasswordAuthentication() { //返回用户名和密码
                return new PasswordAuthentication(username, password); //设置用户名和密码
            }
        });
        session.setDebug(true);
        return session;
    }


    /**
     * 创建作者:   张勇
     * 创建日期:   2017/6/14 20:15
     * 方法介绍:   发送邮件处理类
     * 参数说明:
     *
     * @return
     */
    public static boolean sendWEmail(Webmail webmail, EmailBodyModel emailBodyModel, String... files) {
        //解决linux 系统附件名 base64加密后过程被截问题
        System.setProperty("mail.mime.splitlongparameters", "false");
        boolean flag = false;
        Session session = webEmailLogin(webmail);
        InputStream in=null;
      //  try {
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(webmail.getEmail()));
            // 发送
            if (!StringUtils.checkNull(emailBodyModel.getToWebmail())) {
                message.addRecipients(Message.RecipientType.TO, InternetAddress.parse(emailBodyModel.getToWebmail()));
            }
//            //密送
            if (!StringUtils.checkNull(emailBodyModel.getSecretToWebmail())) {
                message.addRecipients(Message.RecipientType.BCC, InternetAddress.parse(emailBodyModel.getSecretToWebmail()));
            }
//            //抄送
            if (!StringUtils.checkNull(emailBodyModel.getCopyToWebmail())) {
                message.addRecipients(Message.RecipientType.CC, InternetAddress.parse(emailBodyModel.getCopyToWebmail()));
            }
            message.setSubject(emailBodyModel.getSubject());
            //lr
            String encoding="GBK";
            try {
                Properties properties=new Properties();
                in = EmailUtil.class.getClassLoader().getResourceAsStream("/upload.properties");
                if(in!=null) {
                    properties.load(in);
                    encoding = properties.getProperty("encoding");
                    if(encoding==null||encoding.equals("")||encoding.length()<1){
//                        System.getProperties().list(System.out);
                        encoding = System.getProperty("file.encoding");
                    }
                }else{
                    //lr
//                    System.getProperties().list(System.out);
                    encoding = System.getProperty("file.encoding");
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            int len = files.length;
            if (len > 0) {

                //有附件
                //zzq添加正文内容
//                message.addHeader("charset", "UTF-8");
                message.addHeader("charset", encoding);//1
                Multipart multipart = new MimeMultipart();
                BodyPart contentPart = new MimeBodyPart();
                contentPart.setText(emailBodyModel.getContent());
                //zzq
//                contentPart.setHeader("Content-Type", "text/html; charset=UTF-8");
                contentPart.setHeader("Content-Type", "text/html; charset="+encoding);//2
                multipart.addBodyPart(contentPart);
                //添加附件
                String osName = System.getProperty("os.name");

                // 查询是否加密
                boolean encryption = emailUtil.sysTasksService.isEncryption();
                List<Attachment> attachmentList = new ArrayList<>();
                List<String> aids = new ArrayList<>();
                if (!StringUtils.checkNull(emailBodyModel.getAttachmentId())) {
                    String[] attachmentIds = emailBodyModel.getAttachmentId().split(",");
                    for (String attachmentId : attachmentIds) {
                        aids.add(attachmentId.split("@")[0]);
                    }
                }
                if (!CollectionUtils.isEmpty(aids)) {
                    attachmentList = emailUtil.attachmentMapper.selectByAids(aids.toArray(new String[aids.size()]));
                }

                for (int i = 0; i < files.length; i++) {
                    String file = files[i];
                    Attachment attachment = attachmentList.get(i);
                    file = file.substring(0, file.lastIndexOf(System.getProperty("file.separator")) + 1) + attachment.getAttachId() + "." + attachment.getAttachFile();
                    if (encryption) {
                        file = file.substring(0, file.lastIndexOf(System.getProperty("file.separator")) + 1) + attachment.getAttachId() + "." + attachment.getAttachFile() + ".xoafile";
                    }


                    File usFile = new File(file);
                    MimeBodyPart fileBody = new MimeBodyPart();
                    DataSource source = new FileDataSource(file);
                    fileBody.setDataHandler(new DataHandler(source));
                    //zzq:去掉收件人附件的时间戳数字
                    // 截取第一个点出现的下标位置
                    int point = usFile.getName().indexOf(".") + 1;
                    BASE64Encoder base64Encoder = new BASE64Encoder();
                    String filename = "";
                    filename = "=?" + encoding + "?B?" + base64Encoder.encode(attachment.getAttachName().getBytes(encoding)) + "?=";
                    if (osName.toLowerCase().startsWith("win")) {
                        filename = filename.replace("\r\n", "");
                    } else {
                        filename = filename.replace("\n", "");
                    }
                    fileBody.setFileName(filename);
                    multipart.addBodyPart(fileBody);
                }
                message.setContent(multipart);
                message.setSentDate(new Date());
                //System.out.println("multipart:"+((MimeMultipart) multipart).getBodyPart(0).getFileName());
            } else {
                message.setContent(emailBodyModel.getContent(), "text/html;charset="+encoding);
            }
            Transport.send(message);
            flag = true;
        } catch (MessagingException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        finally {
            try {
                if(in!=null){
                    in.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
       /* } catch (AddressException e) {
            L.e("setFrom 地址错误：" + e);
        } catch (MessagingException e) {
            L.e("setFrom 设置message错误：" + e);
            System.out.println(e+"\n===============================================================");
        }*/
        return flag;
    }

    public static boolean sendWEmail(Webmail webmail, EmailBodyPlusModel emailBodyModel, String... files) {
        boolean flag = false;
        Session session = webEmailLogin(webmail);
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(webmail.getEmail()));
            // 发送
            if (!StringUtils.checkNull(emailBodyModel.getToWebmail())) {
                message.addRecipients(Message.RecipientType.TO, InternetAddress.parse(emailBodyModel.getToWebmail()));
            }
//            //密送
            if (!StringUtils.checkNull(emailBodyModel.getSecretToWebmail())) {
                message.addRecipients(Message.RecipientType.BCC, InternetAddress.parse(emailBodyModel.getSecretToWebmail()));
            }
//            //抄送
            if (!StringUtils.checkNull(emailBodyModel.getCopyToWebmail())) {
                message.addRecipients(Message.RecipientType.CC, InternetAddress.parse(emailBodyModel.getCopyToWebmail()));
            }
            message.setSubject(emailBodyModel.getSubject());

            int len = files.length;
            if (len > 0) {
                //有附件
                message.addHeader("charset", "UTF-8");
                Multipart multipart = new MimeMultipart();
                BodyPart contentPart = new MimeBodyPart();
                contentPart.setText(emailBodyModel.getContent());
                contentPart.setHeader("Content-Type", "text/html; charset=UTF-8");
                multipart.addBodyPart(contentPart);
                for (String file : files) {
                    File usFile = new File(file);
                    MimeBodyPart fileBody = new MimeBodyPart();
                    DataSource source = new FileDataSource(file);
                    fileBody.setDataHandler(new DataHandler(source));
                    sun.misc.BASE64Encoder enc = new sun.misc.BASE64Encoder();
                    fileBody.setFileName("=?GBK?B?"
                            + enc.encode(usFile.getName().getBytes()) + "?=");
                    multipart.addBodyPart(fileBody);
                }
                message.setContent(multipart);
                message.setSentDate(new Date());
            } else {
                message.setContent(emailBodyModel.getContent(), "text/html;charset=utf-8");
            }

            Transport.send(message);
            flag = true;
        } catch (AddressException e) {
            L.e("setFrom 地址错误：" + e);
        } catch (MessagingException e) {
            L.e("setFrom 设置message错误：" + e);
        }
        return flag;
    }
    /**
     * 测试工具
     * @param args
     */
//    public static void main(String[] args){
//        Webmail webmail = new Webmail();
//        webmail.setSmtpServer("mail.jinhuijiu.com");
//        webmail.setSmtpPort(25);
//        webmail.setEmailUser("szq@jinhuijiu.com");
//        webmail.setEmailPass("sun123456");
//        webmail.setEmail("szq@jinhuijiu.com");
//        EmailBodyModel emailBodyModel = new EmailBodyModel();
//        emailBodyModel.setToWebmail("1477716853@qq.com");
//        emailBodyModel.setSubject("测试123131");
//        emailBodyModel.setContent("测试是否可行！");
//        boolean flag = sendWEmail(webmail,emailBodyModel);
//        System.out.println(flag);
//
//    }


}
