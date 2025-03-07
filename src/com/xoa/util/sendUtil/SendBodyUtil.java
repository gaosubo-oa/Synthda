package com.xoa.util.sendUtil;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Component;

@Component
public class SendBodyUtil {
    @Autowired
    ThreadPoolTaskExecutor threadPoolTaskExecutor;

    public void sendSms(final StringBuffer mobileString, final StringBuffer contextString, final String protocol, final String host, final String port,
                        final String username, final String pwd, final String content_field,
                        final String code, final String mobile, final String time_content, final String sign, final String signValue, final String SIGN_POSITION,
                        final String extend_1, final String extend_2, final String extend_3, final String extend_4, final String extend_5,
                        final String startTime) {
        threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                try {

                    send.doPost(mobileString, contextString, protocol, host, port,
                            username, pwd, content_field,
                            code, mobile, time_content, sign, signValue, SIGN_POSITION,
                            extend_1, extend_2, extend_3, extend_4, extend_5,
                            startTime);
                } catch (Exception e) {
                    e.printStackTrace();
                }

            }
        });
    }
}
