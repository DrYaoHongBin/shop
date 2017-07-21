package com.shop.service;


import com.shop.model.User;

/**
 * <p>Title: UserService</p>
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/18 20:16
 */
public interface UserService {
    /**
     * 注册时查询用户是否已注册
     * @param user
     * @return
     */
    String selectUser(User user); //查询用户名、邮箱、手机号码是否已被注册

    /**
     * 找回密码时查询用户是否已注册，返回的字符串不同，所以与selectUser(User user)区别开
     * @param user
     * @param identify
     * @return
     */
    String selectUser(User user, Integer identify); //找回密码时查询手机号/邮箱是否已注册

    /**
     * 保存注册的用户
     * @param user
     */
    void saveUser(User user);

    User login(User user);

    void resetPassword(User user);
}
