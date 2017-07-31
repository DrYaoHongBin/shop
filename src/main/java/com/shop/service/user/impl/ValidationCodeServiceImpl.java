package com.shop.service.user.impl;

import com.shop.dao.user.UserMapper;
import com.shop.dao.user.ValidationCodeMapper;
import com.shop.model.user.User;
import com.shop.model.user.ValidationCode;
import com.shop.service.user.ValidationCodeService;
import com.shop.util.Mail;
import com.shop.util.MiaoDi;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import javax.servlet.http.HttpSession;
import java.util.Calendar;
import java.util.List;

/**
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/20 13:56
 */
@Service
public class ValidationCodeServiceImpl implements ValidationCodeService {
    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ValidationCodeMapper validationCodeMapper;

    public void emailCode(ValidationCode validationCode) throws Exception {
        // 生成6位数的随机数
        int randomNumber =(int)((Math.random()*9+1)*100000);
        // 向用户发送验证码
        Mail.MailValidationCode(validationCode.getEmail(), randomNumber);
        // 获取当前系统的时间，getInstance()返回值是long型的整数 表示从1790-1-1 00:00:00到当前时间总共经过的时间的毫秒数
        Calendar c = Calendar.getInstance();
        // 设置验证码发送的时间
        long time = c.getTimeInMillis();
        // 设置过期时间为5分钟
        long exptime =(time+1000*300);
        validationCode.setEndTime(exptime);
        validationCode.setValidationCode(randomNumber);
        validationCodeMapper.insert(validationCode);
    }

    public String phoneNumberCode(ValidationCode validationCode) {
        // 生成6位数的随机数
        int randomNumber =(int)((Math.random()*9+1)*100000);
        // 向用户发送验证码
        String respCode = MiaoDi.execute(validationCode.getPhoneNumber(), randomNumber);
        // 获取当前系统的时间，getInstance()返回值是long型的整数 表示从1790-1-1 00:00:00到当前时间总共经过的时间的毫秒数
        Calendar c = Calendar.getInstance();
        // 设置验证码发送的时间
        long time = c.getTimeInMillis();
        // 设置过期时间为5分钟
        long exptime =(time+1000*300);
        validationCode.setEndTime(exptime);
        validationCode.setValidationCode(randomNumber);
        validationCodeMapper.insert(validationCode);
        // 返回发送短信后返回的状态码
        return respCode;
    }

    /**
     * 检查验证码是否过期
     * @param validationCode
     * @return
     */
    public Integer validationCodeCheck(ValidationCode validationCode) {
        // 新建一个对象，用于保存查询的条件
        ValidationCode validation = new ValidationCode();
        validation.setValidationCode(validationCode.getValidationCode());

        // 前台的原因传过来的值有一个为""会影响查询（没有填写传过来的值为""）
        if ("".equals(validationCode.getEmail())) {
            // 用户没有填写邮箱，则按提交的手机号码查询
            validation.setPhoneNumber(validationCode.getPhoneNumber());
        } else {
            // 用户没有填写手机号码，则按提交的邮箱查询
            validation.setEmail(validationCode.getEmail());
        }
        // 通用Mapper的select方法，根据实体类不为空的字段查询
        List<ValidationCode> validationCodes = validationCodeMapper.select(validation);
        if (validationCodes.isEmpty()) { //查询不到验证码
            return null;
        } else {
            ValidationCode code = validationCodes.get(0);
            // 获取从1790-1-1 00:00:00到当前时间的时间
            Calendar c = Calendar.getInstance();
            // 获取从1790-1-1 00:00:00到当前时间总共经过的时间的毫秒数
            long time = c.getTimeInMillis();
            if (time > code.getEndTime()) {
                // 当前系统的时间大于验证码过期的时间
                return 0;
            }
            // 如果验证码通过则删除,防止重复利用
            validationCodeMapper.delete(validation);
            return 1;  // 1无意义，解决无返回值问题
        }
    }

    public String resetPhoneNumber(HttpSession session) {
        User loginUser = (User)session.getAttribute("loginUser");
        ValidationCode validationCode = new ValidationCode();
        // 传入登录用户的手机号码
        validationCode.setPhoneNumber(loginUser.getPhoneNumber());
        try {
           // 根据登录用户的手机号码发送验证码
           String respCode = phoneNumberCode(validationCode);
        }catch (Exception e) {
            e.printStackTrace();
        }
        return "验证码已发送至您的手机，请输入验证码后再修改绑定！";
    }

    public String resetEmail(HttpSession session) {
        User loginUser = (User)session.getAttribute("loginUser");
        ValidationCode validationCode = new ValidationCode();
        // 传入登录用户的邮箱
        validationCode.setEmail(loginUser.getEmail());
        try {
            // 根据登录用户的邮箱发送验证码
            emailCode(validationCode);
        }catch (Exception e) {
            e.printStackTrace();
        }
        return "验证码已发送至您的邮箱，请输入验证码后再修改绑定！";
    }
}
