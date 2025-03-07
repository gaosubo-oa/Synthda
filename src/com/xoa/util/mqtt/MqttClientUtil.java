package com.xoa.util.mqtt;

import com.xoa.dao.thirdSysConfig.ThirdSysConfigMapper;
import com.xoa.model.thirdSysConfig.ThirdSysConfigWithBLOBs;
import org.eclipse.paho.client.mqttv3.*;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.UUID;

@Component
public class MqttClientUtil {


    @Resource
    ThirdSysConfigMapper thirdSysConfigMapper;
    private int QoS = 0;
    //String clientid = "publish_client";
    //发布 MQTT 消息
    public  void publishSample(String content,String sysName) {
        try {
            ThirdSysConfigWithBLOBs config = thirdSysConfigMapper.selectBySysName(sysName);

            String clientId = UUID.randomUUID().toString().replace("-", "");
            MqttClient client = new MqttClient(config.getPara1(), clientId, new MemoryPersistence());
            // 连接参数
            MqttConnectOptions options = new MqttConnectOptions();
            // 设置用户名和密码
            options.setUserName(config.getPara2());
            options.setPassword(config.getPara3().toCharArray());
            options.setKeepAliveInterval(60);
            options.setConnectionTimeout(60);
            // 连接
            client.connect(options);
            // 创建消息并设置 QoS
            MqttMessage message = new MqttMessage(content.getBytes());
            message.setQos(QoS);
            // 发布消息
            client.publish(config.getPara4(), message);
            // 断开连接
            client.disconnect();
            // 关闭客户端
            client.close();
        } catch (MqttException e) {
            throw new RuntimeException(e);
        }

    }

    //订阅 MQTT 主题
    public void SubscribeSample(String sysName) {
        try {
            ThirdSysConfigWithBLOBs config = thirdSysConfigMapper.selectBySysName(sysName);
            String clientId = UUID.randomUUID().toString().replace("-", "");
            MqttClient client = new MqttClient(config.getPara1(), clientId, new MemoryPersistence());
            // 设置连接参数
            MqttConnectOptions options = new MqttConnectOptions();
            options.setCleanSession(true);
            options.setUserName(config.getPara2());
            options.setPassword(config.getPara3().toCharArray());
            options.setConnectionTimeout(60);
            options.setKeepAliveInterval(60);
            // 设置回调
            client.setCallback(new MqttCallback() {

                public void connectionLost(Throwable cause) {
                    System.out.println("connectionLost: " + cause.getMessage());
                }

                public void messageArrived(String topic, MqttMessage message) {
                    System.out.println("topic: " + topic);
                    System.out.println("Qos: " + message.getQos());
                    System.out.println("message content: " + new String(message.getPayload()));

                }

                public void deliveryComplete(IMqttDeliveryToken token) {
                    System.out.println("deliveryComplete---------" + token.isComplete());
                }

            });
            client.connect(options);
            client.subscribe(config.getPara5(), QoS);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
