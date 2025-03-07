package com.xoa.util.quartz.config;

import org.quartz.Scheduler;
import org.quartz.ee.servlet.QuartzInitializerListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;

import java.io.IOException;
import java.util.Properties;

/**
 * Created by 刘建 on 2020/7/9 15:55
 * Quartz 配置文件
 */

@Configuration
public class QuartzConfig {

    @Autowired
    private JobFactory jobFactory;

    /**
     * 调度类FactoyBean
     * @return
     * @throws IOException
     */
    @Bean("sechduerFactory")
    public SchedulerFactoryBean schedulerFactoryBean() throws IOException{
        SchedulerFactoryBean schedulerFactoryBean = new SchedulerFactoryBean();
        //设置调度类quartz属性
        schedulerFactoryBean.setQuartzProperties(quartzProperties());
        //设置jobFactory
        schedulerFactoryBean.setJobFactory(jobFactory);
        return schedulerFactoryBean;
    }

    /**
     * 解析quartz.properties文件，填充属性
     * @return
     * @throws IOException
     */
    @Bean
    public Properties quartzProperties() throws IOException{
        PropertiesFactoryBean propertiesFactoryBean = new PropertiesFactoryBean();
//		propertiesFactoryBean.setLocation(new ClassPathResource("/quartz.properties"));
        propertiesFactoryBean.afterPropertiesSet();
        return propertiesFactoryBean.getObject();
    }

    /**
     * quartz初始化监听器
     * @return
     */
    @Bean
    public QuartzInitializerListener initializerListener(){
        return new QuartzInitializerListener();
    }

    /**
     * 根据调度类工厂bean获取调度
     * @return
     * @throws IOException
     */
    @Bean("scheduler")
    public Scheduler scheduler() throws IOException{
        return schedulerFactoryBean().getScheduler();
    }
}
