package com.shop.controller.user;

import com.shop.controller.BaseAdminController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * <p>Title: JsonTest</p>
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/17 21:44
 */
@Controller
public class UserController {

    @RequestMapping(value = "registerUI")
    public String registerUI() {
        return "/WEB-INF/jsp/user/register";
    }

    @RequestMapping(value = "loginUI")
    public String loginUI() {
        return "/WEB-INF/jsp/user/login";
    }
}
