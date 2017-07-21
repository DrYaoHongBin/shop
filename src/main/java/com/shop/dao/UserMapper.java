package com.shop.dao;


import com.shop.model.User;
import com.shop.util.BaseMapper;

import java.util.List;

public interface UserMapper extends BaseMapper<User> {
    List<User> selectUser(User user);
    void resetPassword(User user);

    /**
     * 用户可通过输入用户名/手机号码/邮箱三种方式登录
     * @param user
     * @return
     */
    List<User> login(User user);
}