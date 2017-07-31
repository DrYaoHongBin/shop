package com.shop.service.admin;

import com.shop.model.admin.Admin;

import javax.servlet.http.HttpSession;

/**
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/30 5:29
 */
public interface AdminService {

    /**
     * 管理员登录，登录成功返回null，将管理员对象保存进session
     * 失败则返回登录失败信息
     * @param admin
     * @return
     */
    String login(Admin admin, HttpSession session);

    /**
     * 管理员退出登录
     * @param session
     */
    void logout(HttpSession session);
}
