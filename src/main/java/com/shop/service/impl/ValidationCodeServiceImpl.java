package com.shop.service.impl;

import com.shop.dao.UserMapper;
import com.shop.dao.ValidationCodeMapper;
import com.shop.model.ValidationCode;
import com.shop.service.ValidationCodeService;
import com.shop.util.Mail;
import com.shop.util.MiaoDi;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
        int randomNumber =(int)((Math.random()*9+1)*100000); //生成6位数的随机数
        Mail.MailValidationCode(validationCode.getEmail(),randomNumber); //向用户发送验证码
        Calendar c = Calendar.getInstance(); //获取当前系统的时间
        //getInstance()返回值是long型的整数 表示从1790-1-1 00:00:00到当前时间总共经过的时间的毫秒数
        long time = c.getTimeInMillis();  //设置验证码发送的时间
        long exptime =(time+1000*300);   //设置过期时间为5分钟
        validationCode.setEndTime(exptime);
        validationCode.setValidationCode(randomNumber);
        validationCodeMapper.insert(validationCode);
    }

    public String phoneNumberCode(ValidationCode validationCode) {
        int randomNumber =(int)((Math.random()*9+1)*100000);
        String respCode = MiaoDi.execute(validationCode.getPhoneNumber(),randomNumber); //向用户发送验证码
        Calendar c = Calendar.getInstance();
        long time = c.getTimeInMillis();
        long exptime =(time+1000*300);
        validationCode.setEndTime(exptime);
        validationCode.setValidationCode(randomNumber);
        validationCodeMapper.insert(validationCode);
        return respCode;
    }

    /**
     * 检查验证码是否过期
     * @param validationCode
     * @return
     */
    public Integer validationCodeCheck(ValidationCode validationCode) {
        //通用Mapper的select方法，根据实体类不为空的字段查询
        ValidationCode validation = new ValidationCode();
        validation.setValidationCode(validationCode.getValidationCode());
        if ("".equals(validationCode.getEmail())) {    //前台的原因传过来的值有一个为""会影响查询（没有填写传过来的值为""）
            validation.setPhoneNumber(validationCode.getPhoneNumber()); //用户没有填写邮箱，则按提交的手机号码查询
        } else {
            validation.setEmail(validationCode.getEmail());
        }
        List<ValidationCode> validationCodes = validationCodeMapper.select(validation);
        if (validationCodes.isEmpty()) { //查询不到验证码
            return null;
        } else {
            ValidationCode code = validationCodes.get(0);
            Calendar c = Calendar.getInstance();
            long time = c.getTimeInMillis();
            if (time > code.getEndTime()) { //当前系统的时间大于验证码过期的时间
                return 0;
            }
            return 1;  //1无意义，解决无返回值问题
        }
    }
}
