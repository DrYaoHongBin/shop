package com.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @Author 姚洪斌
 * @Date 2017/7/21 9:06
 */
@Controller
public class CommonController {
    @RequestMapping(value = "/")
    public String index() {
        return "redirect:/index.jsp";
    }

}
