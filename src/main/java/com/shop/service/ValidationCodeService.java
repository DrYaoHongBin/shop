package com.shop.service;

import com.shop.model.ValidationCode;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/20 13:56
 */
public interface ValidationCodeService {
    /**
     * 发送邮箱验证码
     * @param validationCode
     * @throws Exception
     */
    void emailCode(ValidationCode validationCode) throws Exception;

    /**
     * 发送短信验证码（用的是秒嘀的短信发送）
     * @param validationCode
     * @return
     */
    String phoneNumberCode(ValidationCode validationCode);

    /**
     * 检查验证码是否过期
     * @param validationCode
     * @return
     */
    Integer validationCodeCheck(ValidationCode validationCode);

    /**
     * 在修改手机号码页面发送验证码，跟上面发送验证码的方法逻辑不同，所以重新写一个
     */
    String resetPhoneNumber(HttpSession session);

    /**
     * 在修改邮箱页面发送验证码，跟上面发送验证码的方法逻辑不同，所以重新写一个
     */
    String resetEmail(HttpSession session);
}
