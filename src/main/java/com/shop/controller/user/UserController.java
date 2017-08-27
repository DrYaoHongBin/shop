package com.shop.controller.user;

import com.github.pagehelper.PageInfo;
import com.shop.been.AjaxResult;
import com.shop.controller.BaseController;

import com.shop.model.order.Order;
import com.shop.model.user.User;
import com.shop.model.user.ValidationCode;
import com.shop.service.order.OrderService;
import com.shop.service.user.UserService;
import com.shop.service.user.ValidationCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import sun.misc.BASE64Decoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.FileOutputStream;
import java.util.List;
import java.util.Map;

/**
 * <p>Description:用户控制器</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/17 21:44
 */
@Controller
@RequestMapping(value = "user")
public class UserController extends BaseController<User> {

    @Autowired
    private UserService userService;

    @Autowired
    private ValidationCodeService validationCodeService;

    @Autowired
    private OrderService orderService;
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
     * @param identify 用于区别直接修改密码与找回密码再修改操作
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "emailCode")
    @ResponseBody
    public AjaxResult emailCode(ValidationCode validationCode, User user, Integer identify)throws Exception {
        // identify不为空，则表示是找回密码的操作，在发送前需要先判断该邮箱是否已经注册
        if (identify != null) {
           String message = userService.selectUser(user, identify);
           if (message != null) {
                return new AjaxResult(false, message);
           }
        }
        validationCodeService.emailCode(validationCode);
        return new AjaxResult(true, "验证码已发送至您的邮箱，请及时查收!");
    }

    /**
     * Ajax方式发送短信验证码
     * @param validationCode
     * @return
     */
    @RequestMapping(value = "phoneNumberCode")
    @ResponseBody
    public AjaxResult phoneNumberCode(ValidationCode validationCode, User user, Integer identify) {
        // identify不为空，则表示是找回密码的操作，在发送前需要先判断该手机号是否已经注册
        if (identify != null) {
            String message = userService.selectUser(user, identify);
            if (message != null) {
                return new AjaxResult(false, message);
            }
        }
        String respCode = validationCodeService.phoneNumberCode(validationCode);
        // 短信发送成功的话返回的状态码是00000
        if ("00000".equals(respCode)) {
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
        // 检查验证码是否正确或者过期
        Integer codeTime = validationCodeService.validationCodeCheck(validationCode);
        String codeMessage = "";
        if (codeTime == null) {
            codeMessage = "您的验证码错误，请重新输入！";
            redirectAttributes.addFlashAttribute("codeMessage", codeMessage);
            // 用于回显
            redirectAttributes.addFlashAttribute("user", user);
            return "redirect:/user/registerUI";
        } else if (codeTime == 0) {
            codeMessage = "您的验证码已过期,请重新获取！";
            redirectAttributes.addFlashAttribute("codeMessage", codeMessage);
            redirectAttributes.addFlashAttribute("user", user);
            return "redirect:/user/registerUI";
        }
        // 查询用户名/手机号/邮箱是否已经注册，如果都还没注册则返回的值是null
        codeMessage = userService.selectUser(user);
        if (codeMessage != null) {
            redirectAttributes.addFlashAttribute("codeMessage", codeMessage);
            redirectAttributes.addFlashAttribute("user", user);
            return "redirect:/user/registerUI";
        }
        userService.saveUser(user);
        return "redirect:/user/loginUI";
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
        // 判断登录用户是否已经注册店铺，如果已经注册，将merchant属性保存进session
        // 这里可能会出现空指针异常，处理一下
        try {
            if (loginUser.getMerchant() != null) {
                session.setAttribute("loginMerchant", loginUser.getMerchant());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (loginUser == null) {
            String message = "帐户名或密码错误，请重新输入！";
            redirectAttributes.addFlashAttribute("message", message);
            redirectAttributes.addFlashAttribute("user", user);
            return "redirect:/user/loginUI";
        } else {
            session.setAttribute("loginUser", loginUser);
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
        // 检查验证码是否正确或者过期
        Integer codeTime = validationCodeService.validationCodeCheck(validationCode);
        if (codeTime == null) {
            return new AjaxResult(false, "您的验证码错误，请重新输入！");
        } else if (codeTime == 0) {
            return new AjaxResult(false, "您的验证码已过期，请重新获取！");
        }
        return new AjaxResult(true, "验证成功，请重新设置密码！");
    }

    /**
     * 重置密码
     * @param user
     * @return
     */
    @RequestMapping(value = "resetPassword")
    public String resetPassword(User user, RedirectAttributes redirectAttributes, HttpSession session) {
        userService.resetPassword(user);
        redirectAttributes.addFlashAttribute("message", "密码修改成功，请重新登录！");
        if (session.getAttribute("loginUser") != null) {
            session.removeAttribute("loginUser");
        }
        return "redirect:/user/loginUI";
    }

    /**
     * 退出登录
     * @param session
     * @return
     */
    @RequestMapping(value = "logout")
    public String logout(HttpSession session) {
        session.removeAttribute("loginUser");
        return "redirect:/";
    }

    /**
     * 前往帐户安全页面
     * @return
     */
    @RequestMapping(value = "userSafeUI")
    public String userSafeUI() {
        return "/WEB-INF/jsp/user/user_safe";
    }

    /**
     * 前往修改密码页面
     * @return
     */
    @RequestMapping(value = "resetPasswordUI")
    public String resetPasswordUI() {
        return "/WEB-INF/jsp/user/reset_password";
    }

    /**
     * ajax方式在登录用户修改密码前再次确认登录账号的密码
     * @param user
     * @param session
     * @return
     */
    @RequestMapping(value = "checkPassword")
    @ResponseBody
    public AjaxResult checkPassword(User user, HttpSession session) {
        User loginUser = (User)session.getAttribute("loginUser");
        if (loginUser.getPassword().equals(user.getPassword())) {
            return new AjaxResult(true, "");
        } else {
            return new AjaxResult(false, "密码错误，请重新输入");
        }
    }

    /**
     * 前往修改手机号码页面
     * @return
     */
    @RequestMapping(value = "resetPhoneNumberUI")
    public String resetPhoneNumberUI() {
       return "/WEB-INF/jsp/user/reset_telephone";
    }

    /**
     * 前往修改邮箱前页面
     * @return
     */
    @RequestMapping(value = "resetEmailUI")
    public String resetEmailUI() {
        return "/WEB-INF/jsp/user/reset_email";
    }

    /**
     * 修改邮箱页面通过ajax方式获取验证码，用户直接点击获取验证码即可，不用输入邮箱，
     * 所以与上面发送验证码的方法区别开
     * @param session
     * @return
     */
    @RequestMapping(value = "resetEmail")
    @ResponseBody
    public AjaxResult resetEmail(HttpSession session) {
        String message = validationCodeService.resetEmail(session);
        return new AjaxResult(true, message);
    }

    /**
     * 修改手机号码页面通过ajax方式获取验证码，用户直接点击获取验证码即可，不用输入手机号码，
     * 所以与上面发送验证码的方法区别开
     * @param session
     * @return
     */
    @RequestMapping(value = "resetPhoneNumber")
    @ResponseBody
    public AjaxResult resetPhoneNumber(HttpSession session) {
        String message = validationCodeService.resetPhoneNumber(session);
        return new AjaxResult(true, message);
    }

    /**
     * 更新用户信息
     * @param user
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "updateUser")
    public String updateUser(User user, RedirectAttributes redirectAttributes, HttpSession session) {
        String message = userService.updateUser(user);
        if (message != null) {
            redirectAttributes.addFlashAttribute("message", message);
            return "redirect:/user/userSafeUI";
        }
        redirectAttributes.addFlashAttribute("message", "修改成功！");
        // 修改成功，根据隐藏域传过来的id值更新session里面的数据
        userService.updateSession(user.getUserId(), session);
        return "redirect:/user/userSafeUI";
    }

    /**
     * 前往用户个人资料页面
     * @return
     */
    @RequestMapping(value = "userInformationUI")
    public String userInformationUI() {
        return TEMPLATE_PATH + "user_information";
    }

    /**
     * 前往修改头像页面，因为头像上传用到了bootstrap插件，直接引入会导致
     * 个人信息页面布局乱了，所以更改头像另写一个页面
     * @return
     */
    @RequestMapping(value = "avatarUI")
    public String avatarUI() {
        return TEMPLATE_PATH + "avatar";
    }

    /**
     * 保存用户上传的头像,因为需要获取剪切出来的头像，所以把图片转成base64编码
     * @param img base64编码的图片数据
     * @param session 获取登录的用户
     * @param userId 用户id
     * @return
     */
    @RequestMapping(value = "avatarUpload")
    @ResponseBody
    public AjaxResult avatarUpload(String img, HttpSession session, Integer userId) {
       AjaxResult result = userService.avatarUpload(img, session);
       Boolean flag = result.getSuccess();
       if (flag) {
           // 更新完成，将session中的登录用户也更新
           userService.updateSession(userId, session);
           return result;
       } else {
           return result;
       }
    }
}
