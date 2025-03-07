package com.xoa.util.email;

import javax.mail.*;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

/**
 * 创建作者:   张勇
 * 创建日期:   2017/6/14 16:36
 * 类介绍  :   获取外部邮件内容方法
 * 构造参数:
 */
public class RevEmailUtil {


    public static class getMailInfo extends Thread {
        Message message[] = null;
        EmailUtils re = null;

        public getMailInfo(Message message[]) {
            this.message = message;
        }

        /**
         * 创建作者:   张勇
         * 创建日期:   2017/6/14 19:48
         * 方法介绍:  外部邮件收件线程执行方法
         * 参数说明:
         * @return
         */
        @Override
        public void run() {
            // TODO Auto-generated method stub
            super.run();
            if (null != message) {
                for (int i = 0; i < message.length; i++) {
                    try {
                        re = new EmailUtils((MimeMessage) message[i]);
//                        System.out.println("邮件　" + i + "　主题:　" + re.getSubject());
//                        System.out.println("邮件　" + i + "　是否需要回复:　" + re.getReplySign());
//                        System.out.println("邮件　" + i + "　是否已读:　" + re.isNew());
//                        System.out.println("邮件　" + i + "　是否包含附件:　" + re.isContainAttach((Part) message[i]));
//                        System.out.println("邮件　" + i + "　发送时间:　" + re.getSentDate());
//                        System.out.println("邮件　" + i + "　发送人地址:　" + re.getFrom());
//                        System.out.println("邮件　" + i + "　收信人地址:　" + re.getMailAddress("to"));
//                        System.out.println("邮件　" + i + "　抄送:　" + re.getMailAddress("cc"));
//                        System.out.println("邮件　" + i + "　暗抄:　" + re.getMailAddress("bcc"));
                        re.setDateFormat("yyyy年MM月dd日");
//                        System.out.println("邮件　" + i + "　发送时间:　" + re.getSentDate());
//                        System.out.println("邮件　" + i + "　邮件ID:　" + re.getMessageId());
                        re.getMailContent((Part) message[i]);
//                        System.out.println("邮件　" + i + "　正文内容:　\r\n" + re.getBodyText());
//                        System.out.println("邮件　　主题:　" + re.getSubject());
//                        System.out.println("邮件　　是否需要回复:　" + re.getReplySign());
//                        System.out.println("邮件　" + i + "　是否已读:　" + re.isNew());
//                        System.out.println("邮件　" + i + "　是否包含附件:　" + re.isContainAttach((Part) message[i]));
//                        System.out.println("邮件　　发送时间:　" + re.getSentDate());
//                        System.out.println("邮件　　发送人地址:　" + re.getFrom().getClass().getName());
//                        System.out.println("邮件　" + i + "　收信人地址:　" + re.getMailAddress("to"));
//                        System.out.println("邮件　" + i + "　抄送:　" + re.getMailAddress("cc"));
//                        System.out.println("邮件　" + i + "　暗抄:　" + re.getMailAddress("bcc"));
                        re.setDateFormat("yyyy年MM月dd日");
//                        System.out.println("邮件　" + i + "　发送时间:　" + re.getSentDate());
//                        System.out.println("邮件　　邮件ID:　" +  re.getMessageId());
//                        re.getMailContent((Part) message[i]);
//                        System.out.println("邮件　　正文内容:　\r\n" + re.getBodyText());

                    } catch (MessagingException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    } catch (Exception e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/6/14 19:48
     * 方法介绍:   接收文件测试方法
     * 参数说明:
     * @return
     */
    public static void main(String[] args) {
        try {
//            String host = "pop.qq.com";
//            String username = "wyq843209972@qq.com";
//            String password = "wqnwzsaiilxddihd";
            String host = "pop.163.com";
            String username = "zy6054726@163.com";
            String password = "zhangyong138";

            Properties props = new Properties();

            Properties p = new Properties();
            if(host.equals("pop.qq.com")) {
                p.setProperty("mail.pop3.host", "pop.qq.com"); // 按需要更改
                p.setProperty("mail.pop3.port", "995");
                // SSL安全连接参数
                p.setProperty("mail.pop3.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
                p.setProperty("mail.pop3.socketFactory.fallback", "true");
                p.setProperty("mail.pop3.socketFactory.port", "995");
            }else{
                p.setProperty("mail.pop3.host", "pop.163.com"); // 按需要更改
                p.setProperty("mail.pop3.port", "995");
//                 SSL安全连接参数
                p.setProperty("mail.pop3.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
                p.setProperty("mail.pop3.socketFactory.fallback", "false");
                p.setProperty("mail.pop3.socketFactory.port", "995");
            }
            Session session = Session.getDefaultInstance(p, null);
            session.setDebug(true);
            Store store = session.getStore("pop3");
            store.connect(host, username, password);

            Folder folder = store.getFolder("INBOX");
            folder.open(Folder.READ_ONLY);//只读
//            folder.open(Folder.READ_WRITE);//表示可以修改并读取邮件夹中的邮件
            Message message[] = folder.getMessages();
//            System.out.println("邮件数量:　" + message.length);
            new RevEmailUtil.getMailInfo(message).start();
        } catch (NoSuchProviderException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (MessagingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }


}
