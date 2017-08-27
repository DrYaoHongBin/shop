package com.shop.dao.jedis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

/**
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/8/27 16:39
 */
public class JedisDaoImpl implements JedisDao {

    @Autowired
    private JedisPool jedisPool;

    public String set(String key, String keyValue) {
        // 从Jedis连接池中获取连接
        Jedis jedis = jedisPool.getResource();
        String result = jedis.set(key, keyValue);
        return result;
    }

    public String get(String key) {
        // 从Jedis连接池中获取连接
        Jedis jedis = jedisPool.getResource();
        String result = jedis.get(key);
        return result;
    }

    public Long del(String key) {
        // 从Jedis连接池中获取连接
        Jedis jedis = jedisPool.getResource();
        Long result = jedis.del(key);
        return result;
    }

    public Long hset(String hKey, String key, String keyValue) {
        // 从Jedis连接池中获取连接
        Jedis jedis = jedisPool.getResource();
        Long result = jedis.hset(hKey, key, keyValue);
        return result;
    }

    public String hget(String hKey, String key) {
        // 从Jedis连接池中获取连接
        Jedis jedis = jedisPool.getResource();
        String result =jedis.hget(hKey, key);
        return result;
    }

    public Long hdel(String hKey, String key) {
        // 从Jedis连接池中获取连接
        Jedis jedis = jedisPool.getResource();
        Long result = jedis.hdel(hKey, key);
        return result;
    }
}
