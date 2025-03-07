package com.xoa.util.redis;

import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

import java.util.ResourceBundle;

/**
 * Created by Administrator on 2018/5/10.
 */
public class JedisPoolWriper {
    /** Redis连接池对象 */
    private JedisPool jedisPool;

    private static JedisPoolWriper instance;

    public JedisPoolWriper() {
        try {
            ResourceBundle rb = ResourceBundle.getBundle("redis");
            final JedisPoolConfig poolConfig = new JedisPoolConfig();
            poolConfig.setMaxTotal(Integer.parseInt(rb.getString("redis.pool.maxActive")));
            poolConfig.setMaxIdle(Integer.parseInt(rb.getString("redis.pool.maxIdle")));
            poolConfig.setMaxWaitMillis(Integer.parseInt(rb.getString("redis.maxWaitMillis")));
            poolConfig.setTestOnBorrow(Boolean.parseBoolean(rb.getString("redis.pool.testOnBorrow")));
            jedisPool = new JedisPool(poolConfig, rb.getString("redis.pool.host"), Integer.parseInt(rb.getString("redis.pool.port")),Integer.parseInt(rb.getString("redis.pool.timeout")),rb.getString("redis.pool.password"));
            //System.out.println("Redis 服务初始化完成");
        } catch (Exception e) {
            //System.out.println("Redis 服务初始化失败");
            e.printStackTrace();
        }
    }

    public static JedisPoolWriper getInstance() {
        if (instance == null) {
            synchronized (JedisPoolWriper.class){
                if(instance == null){
                    instance = new JedisPoolWriper();
                }
            }
        }
        return instance;
    }

    /**
     * 获取Redis连接池对象
     * @return
     */
    public JedisPool getJedisPool() {
        return jedisPool;
    }

    /**
     * 注入Redis连接池对象
     * @param jedisPool
     */
    public void setJedisPool(JedisPool jedisPool) {
        this.jedisPool = jedisPool;
    }

}
