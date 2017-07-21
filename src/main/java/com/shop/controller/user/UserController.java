package com.shop.controller.user;

import com.shop.been.AjaxResult;
import com.shop.model.User;
import com.shop.model.ValidationCode;
import com.shop.service.UserService;
import com.shop.service.ValidationCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

/**
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/17 21:44
 */
@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private ValidationCodeService validationCodeService;

    /**
     * 前往用户注册页面
     * @return
     */
    @RequestMapping(value = "registerUI")
    public String registerUI() {
        return "/WEB-INF/jsp/user/register";
    }

    /**
     * 前往用户登录页面
     * @return
     */
    @RequestMapping(value = "loginUI")
    public String loginUI() {
        return "/WEB-INF/jsp/user/login";
    }

    /**
     * Ajax方式发送邮箱验证码
     * @param validationCode
     * @param user
     * @param identify
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "emailCode")
    @ResponseBody
    public AjaxResult emailCode(ValidationCode validationCode, User user, Integer identify)throws Exception {
        if (identify != null) {
           String message = userService.selectUser(user,identify);
           if (message != null) {
                return new AjaxResult(false,message);
           }
        }
        validationCodeService.emailCode(validationCode);
        return new AjaxResult(true,"验证码已发送至您的邮箱，请及时查收!");
    }

    /**
     * Ajax方式发送短信验证码
     * @param validationCode
     * @return
     */
    @RequestMapping(value = "phoneNumberCode")
    @ResponseBody
    public AjaxResult phoneNumberCode(ValidationCode validationCode, User user, Integer identify) {
        if (identify != null) {
            String message = userService.selectUser(user,identify);
            if (message != null) {
                return new AjaxResult(false,message);
            }
        }
        String respCode = validationCodeService.phoneNumberCode(validationCode);
        if ("00000".equals(respCode)) { //短信发送成功的话返回的状态码是00000
            return new AjaxResult(true, "验证码已发送至您的手机，请及时查收！");
        } else {
            return new AjaxResult(false, "验证码发送失败，请稍后重试！");
        }
    }

    /**
     * 用户注册
     * @param user
     * @param validationCode
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "register")
    public String register(User user, ValidationCode validationCode, RedirectAttributes redirectAttributes) {
        Integer codeTime = validationCodeService.validationCodeCheck(validationCode);
        String codeMessage = "";
        if (codeTime == null) {
            codeMessage = "您的验证码错误，请重新输入！";
            redirectAttributes.addFlashAttribute("codeMessage",codeMessage);
            redirectAttributes.addFlashAttribute("user",user);
            return "redirect:/registerUI";
        } else if (codeTime == 0) {
            codeMessage = "您的验证码已过期,请重新获取！";
            redirectAttributes.addFlashAttribute("codeMessage",codeMessage);
            redirectAttributes.addFlashAttribute("user",user);
            return "redirect:/registerUI";
        }
        codeMessage = userService.selectUser(user);
        if (codeMessage != null) {
            redirectAttributes.addFlashAttribute("codeMessage",codeMessage);
            redirectAttributes.addFlashAttribute("user",user);
            return "redirect:/registerUI";
        }
        userService.saveUser(user);
        return "redirect:/loginUI";
    }

    /**
     * 用户登录
     * @param user
     * @param redirectAttributes
     * @param session
     * @return
     */
    @RequestMapping(value = "login")
    public String login(User user, RedirectAttributes redirectAttributes, HttpSession session) {
        User loginUser = userService.login(user);
        if (loginUser == null) {
            String message = "帐户名或密码错误，请重新输入！";
            redirectAttributes.addFlashAttribute("message",message);
            redirectAttributes.addFlashAttribute("user",user);
            return "redirect:/loginUI";
        } else {
            session.setAttribute("loginUser",loginUser);
            return "redirect:/";
        }
    }

    /**
     * 找回密码页面
     * @return
     */
    @RequestMapping(value = "forgetPasswordUI")
    public String forgetPasswordUI() {
        return "/WEB-INF/jsp/user/forget_password";
    }

    /**
     * 找回密码时通过AJAX的方式检查验证码
     * @param validationCode
     * @return
     */
    @RequestMapping(value = "checkCode")
    @ResponseBody
    public AjaxResult checkCode(ValidationCode validationCode) {
        Integer codeTime = validationCodeService.validationCodeCheck(validationCode);
        if (codeTime == null) {
            return new AjaxResult(false,"您的验证码错误，请重新输入！");
        } else if (codeTime == 0) {
            return new AjaxResult(false,"您的验证码已过期，请重新获取！");
        }
        return new AjaxResult(true,"验证成功，请重新设置密码！");
    }

    /**
     * 重置密码
     * @param user
     * @return
     */
    @RequestMapping(value = "resetPassword")
    public String resetPassword(User user) {
        userService.resetPassword(user);
        return "redirect:/";
    }

    @RequestMapping(value = "logout")
    public String logout(HttpSession session) {
        session.removeAttribute("loginUser");
        return "redirect:/";
    }
}
