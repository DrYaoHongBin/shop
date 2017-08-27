package com.shop.dao.jedis;

/**
 * <p>Description:Jedis操作接口</p>
 *
 * @Author 姚洪斌
 * @Date 2017/8/27 16:21
 */
public interface JedisDao {

    /**
     * redis String型数据赋值
     * @param key 键名
     * @param keyValue 键值
     * @return
     */
    String set(String key, String keyValue);

    /**
     *redis 获取String型数据
     * @param key  键名
     * @return
     */
    String get(String key);

    /**
     * 删除 redis String型数据
     * @param key  键名
     * @return
     */
    Long del(String key);

    /**
     * redis hash型数据赋值
     * @param hKey  键名
     * @param key 键中的字段
     * @param keyValue  字段值
     * @return
     */
    Long hset(String hKey, String key, String keyValue);

    /**
     * 获取 redis hash型数据
     * @param hKey  键名
     * @param key  键中的字段
     * @return
     */
    String hget(String hKey, String key);

    /**
     * 删除键中的一个字段
     * @param hKey  键名
     * @param key 键中的字段
     * @return
     */
    Long hdel(String hKey, String key);
}
