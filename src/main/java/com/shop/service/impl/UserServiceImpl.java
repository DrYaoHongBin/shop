package com.shop.service.impl;

import com.shop.dao.UserMapper;
import com.shop.model.User;
import com.shop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * <p>Title: UserServiceImpl</p>
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/18 20:17
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserMapper userMapper;

    public String selectUser(User user) {
        List<User> userList = userMapper.selectUser(user);
        for (User newUser : userList ) {
            if (newUser != null) {
                if (user.getUsername().equals(newUser.getUsername())) {
                    return "用户名已被注册，请重新注册!";
                }
                if ("".equals(user.getEmail())) {  //表示用户是用手机号码注册的
                    if (user.getPhoneNumber().equals(newUser.getPhoneNumber())) {
                        return "该手机号已被注册，请重新注册！";
                    }
                } else {
                    if (user.getEmail().equals(newUser.getEmail())) {
                        return "该邮箱已被注册，请重新注册！";
                    }
                }
            }
        }
        return null;
    }

    public String selectUser(User user, Integer identify) {
        if (identify == 0) {   //identify==0则表示是用户找回密码操作，需要判断手机号/邮箱是否注册
            User newUser = new User();
            List<User> newUserLsit = null;
            if (user.getPhoneNumber() == null) {
                newUser.setEmail(user.getEmail());
                newUserLsit = userMapper.selectUser(newUser);
                if (newUserLsit.isEmpty()) {
                    return "该邮箱尚未注册！";
                }
            } else {
                newUser.setPhoneNumber(user.getPhoneNumber());
                newUserLsit = userMapper.selectUser(newUser);
                if (newUserLsit.isEmpty()) {
                    return "该手机号码尚未注册！";
                }
            }
        }
        return null;
    }

    public void saveUser(User user) {
        userMapper.insert(user);
    }

    public User login(User user) {
       List<User> loginUser =  userMapper.login(user);
       if (loginUser.isEmpty()) {
           return null;
       } else {
           return loginUser.get(0);
       }
    }

    public void resetPassword(User user) {
        User newUser = new User();
        newUser.setPassword(user.getPassword());
        if ("".equals(user.getPhoneNumber())) {
            newUser.setEmail(user.getEmail());
        } else {
            newUser.setPhoneNumber(user.getPhoneNumber());
        }
        userMapper.resetPassword(newUser);
    }


}
