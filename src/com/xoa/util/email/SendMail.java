package com.xoa.util.email;

/**
 * 创建作者:   张勇
 * 创建日期:   2017/6/12 15:51
 * 类介绍  :   发送邮件类
 * 构造参数:
 * 作废 务删
 */
@SuppressWarnings("all")
public class SendMail {


//    public static boolean sendWEmail(Webmail webmail, EmailBodyModel emailBodyModel) {
//        boolean flag = false;
//
//        String host = webmail.getSmtpServer();
//        String port = webmail.getSmtpPort().toString();
//        String from = webmail.getEmail();
//        final String username = webmail.getEmailUser();
//        final String password = webmail.getEmailPass();
//
//        Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
//        final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
//        Properties props = System.getProperties();
//
//       if(port.trim().equals("465") || host.trim().equals("smtp.qq.com")) {
//        props.setProperty("mail.smtp.host", host);
//        props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
//        props.setProperty("mail.smtp.socketFactory.fallback", "false");
//        props.setProperty("mail.smtp.port", port);
//        props.setProperty("mail.smtp.socketFactory.port", port);
//        props.setProperty("mail.smtp.auth", "true");
//    }else{
//        props.setProperty("mail.smtp.auth", "true");//接受服务器认证
//        props.setProperty("mail.transport.protocol", "smtp");//设置发送协议
//        props.setProperty("mail.host", host);//设置要连接的服务器地址，端口默认25
//        props.setProperty("mail.port", "25");
//        props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
//        props.setProperty("mail.smtp.socketFactory.fallback", "false");
//        props.setProperty("mail.smtp.socketFactory.port", "25");
//    }
//
//        Session session = Session.getInstance(props, new Authenticator() {  //策略模式
//            @Override
//            protected PasswordAuthentication getPasswordAuthentication() { //返回用户名和密码
//                return new PasswordAuthentication(username, password); //设置用户名和密码
//            }
//        });
//        session.setDebug(true);
//
//
////        String to = "358214421@qq.com";
////        String cTo = "843209972@qq.com,349101912@qq.com";
////        String bTo = "843209972@qq.com";
//
//
//        try {
//            Message message = new MimeMessage(session);
//            message.setFrom(new InternetAddress(from));
//            // 发送
//            if (!StringUtils.checkNull(emailBodyModel.getToWebmail())) {
//                message.addRecipients(Message.RecipientType.TO, InternetAddress.parse(emailBodyModel.getToWebmail()));
//            }
////            //密送
//            if (!StringUtils.checkNull(emailBodyModel.getSecretToWebmail())) {
//                message.addRecipients(Message.RecipientType.BCC, InternetAddress.parse(emailBodyModel.getSecretToWebmail()));
//            }
////            //抄送
//            if (!StringUtils.checkNull(emailBodyModel.getCopyToWebmail())) {
//                message.addRecipients(Message.RecipientType.CC, InternetAddress.parse(emailBodyModel.getCopyToWebmail()));
//            }
//
//            message.setSubject(emailBodyModel.getSubject());
//            message.setContent(emailBodyModel.getContent(), "text/html;charset=utf-8");
//            String accName = emailBodyModel.getAttachmentName();
//            String accId = emailBodyModel.getAttachmentId();
//            if (!StringUtils.checkNull(accName) && !StringUtils.checkNull(accId)) {
//                Multipart mainPart = new MimeMultipart();
//                String[] accNames = accName.split("\\*");
//                String[] accIds = accId.split(",");
//                for (int i = 0, len = accNames.length; i < len; i++) {
//                    MimeBodyPart mdpFile = new MimeBodyPart();
//                    //需要考虑拼接服务器仓库文件具体地址
//                    FileDataSource filwData = new FileDataSource(accNames[i]);
//                    mdpFile.setDataHandler(new DataHandler(filwData));
//                    String acctNams1 = new String(filwData.getName().getBytes(), "ISO-8859-1");
//                    mdpFile.setFileName(acctNams1);
//                    mainPart.addBodyPart(mdpFile);
//                }
//                message.setContent(mainPart);
//            }
//            Transport.send(message);
//            flag = true;
//        } catch (AddressException e) {
//            L.e("setFrom 地址错误：" + e);
//        } catch (MessagingException e) {
//            L.e("setFrom 设置message错误：" + e);
//        } catch (IOException e) {
//            L.e("setFrom 附件流溢出：" + e);
//        }
//        return flag;
//    }


    public static void main(String[] args) {
//        -621701856
//        System.out.println(DateFormat.getDate(DateFormat.getStrTime(-621701856)));


//        String host = "smtp.qq.com";
//        String port = "465";
//        String from = "wyq843209972@qq.com";
//        String to = "zy6054726@163.com";
//        String cTo = "843209972@qq.com,349101912@qq.com";
//        String bTo = "843209972@qq.com";
//        final String username = "wyq843209972@qq.com";
//        final String password = "wqnwzsaiilxddihd";

//        String host = "smtp.163.com";
//        String port = "465";
//        String from = "zy6054726@163.com";
//        String to = "wyq843209972@qq.com";
//        String cTo = "843209972@qq.com,349101912@qq.com";
//        String bTo = "wyq843209972@qq.com";
//        final String username = "zy6054726@163.com";
//        final String password = "zhangyong138";
//
//        Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
//        final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
//        Properties props = System.getProperties();
//
//        if(host.trim().equals("smtp.qq.com")) {
//            props.setProperty("mail.smtp.host", host);
//            props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
//            props.setProperty("mail.smtp.socketFactory.fallback", "false");
//            props.setProperty("mail.smtp.port", port);
//            props.setProperty("mail.smtp.socketFactory.port", port);
//            props.setProperty("mail.smtp.auth", "true");
//        }else{
//            props.setProperty("mail.smtp.auth", "true");//接受服务器认证
//            props.setProperty("mail.transport.protocol", "smtp");//设置发送协议
//            props.setProperty("mail.host", host);//设置要连接的服务器地址，端口默认25
//            props.setProperty("mail.port", port);
//        }
//
//        Session session = Session.getInstance(props,new Authenticator() {  //策略模式
//            @Override
//            protected PasswordAuthentication getPasswordAuthentication() { //返回用户名和密码
//                return new PasswordAuthentication(username, password); //设置用户名和密码
//            }
//        });
//        session.setDebug(true);
//        try {
//            Message message = new MimeMessage(session);
//            message.setFrom(new InternetAddress(from));
//            // 发送
//            message.addRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
////            //密送
//            message.addRecipients(Message.RecipientType.BCC, InternetAddress.parse(bTo));
//////            //抄送
//            message.addRecipients(Message.RecipientType.CC, InternetAddress.parse(cTo));
//            message.setSubject("QQ主题测试");
//
////            message.setText("内容12465465465");
//            message.setContent("QQ测试秘密和抄送是否可行12312", "text/html;charset=utf-8");
//
//            Multipart mp = new MimeMultipart();
//
////            message.setContent();
//
////            message.set
//
//            Transport.send(message);
//        } catch (AddressException e) {
//            e.printStackTrace();
//            System.out.println("setFrom 地址错误："+e);
//        } catch (MessagingException e) {
//            System.out.println("setFrom 设置message错误："+e);
//            e.printStackTrace();
//        }
//
//        System.out.println("发送完毕！");
    }

}
