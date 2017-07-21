package com.shop.service;

import com.shop.model.ValidationCode;

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
}
