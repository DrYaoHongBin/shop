package com.shop.service.admin.impl;


import com.shop.dao.admin.AdminMapper;
import com.shop.model.admin.Admin;
import com.shop.service.admin.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;

/**
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/30 5:30
 */
@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    AdminMapper adminMapper;

    public String login(Admin admin, HttpSession session) {
       // 根据传过来的账号和密码查询是否有此管理员
       Admin loginAdmin =  adminMapper.selectOne(admin);
       // 管理员存在，保存进session，返回null
       if (loginAdmin != null) {
           session.setAttribute("loginAdmin", loginAdmin);
           return null;
       } else {
           return "登录失败，请检查账号或密码是否正确";
       }
    }

    public void logout(HttpSession session) {
        session.removeAttribute("loginAdmin");
    }
}
