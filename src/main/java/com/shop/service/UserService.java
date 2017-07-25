package com.shop.service;


import com.shop.been.AjaxResult;
import com.shop.model.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

    /**
     * 修改密码
     * @param user
     */
    void resetPassword(User user);

    /**
     * 更新用户信息
     * @param user
     */
    String updateUser(User user);

    /**
     * 在更新完登录用户的数据后把session中的loginUser的数据也更新
     * @param userId
     */
    void updateSession(Integer userId, HttpSession session);

    /**
     * 保存用户上传的头像
     * @param img base64编码的图片数据
     * @param session 获取登录的用户
     * @return 上传的结果
     */
    AjaxResult avatarUpload(String img, HttpSession session);
}
