package com.shop.util;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

/**
 * <p>Title: Mail</p>
 * <p>Description:向用户邮箱发送验证码</p>
 *
 * @Author 姚洪斌
 * @Date 2017/6/27 20:13
 */
public class Mail {

    /**
     *
     * @param userMail 注册用户的邮箱
     * @param code  生成的随机数验证码
     * @throws Exception
     */
    public static void MailValidationCode (String userMail, int code) throws  Exception {
        // 创建Properties 类用于记录邮箱的一些属性,加上final是为了让匿名对象能调用
         final  Properties props = new Properties();
        // 表示SMTP发送邮件，必须进行身份验证
        props.put("mail.smtp.auth", "true");
        //此处填写SMTP服务器
        props.put("mail.smtp.host", "smtp.qq.com");
        //端口号，QQ邮箱给出了两个端口，但是另一个我一直使用不了，所以就给出这一个587
        props.put("mail.smtp.port", "587");
        // 此处填写你的账号
        props.put("mail.user", "1642873013@qq.com");
        // 此处的密码是16位STMP口令
        props.put("mail.password", "**********");

        // 构建授权信息，用于进行SMTP进行身份验证
        Authenticator authenticator = new Authenticator() {

            protected PasswordAuthentication getPasswordAuthentication(){
            // 用户名、密码
            String userName = props.getProperty("mail.user");
            String password = props.getProperty("mail.password");
            return new PasswordAuthentication(userName, password);
            }
        };
        // 使用环境属性和授权信息，创建邮件会话,Session类是mail包的
        Session mailSession = Session.getInstance(props, authenticator);

        // 创建邮件消息
        //Message对象将存储我们实际发送的电子邮件信息
        MimeMessage message = new MimeMessage(mailSession);

        //设置发件人
        InternetAddress form = new InternetAddress(props.getProperty("mail.user"));

        message.setFrom(form);

        // 设置收件人的邮箱
        InternetAddress to = new InternetAddress(userMail);
        message.setRecipient(Message.RecipientType.TO, to);

        // 设置邮件标题
        message.setSubject("【歪歪购物】");

        // 设置邮件的内容体
        message.setContent("您的验证码为"+code+"，请于5分钟内正确输入，如非本人操作，请忽略此邮件。", "text/html;charset=UTF-8");

        // 最后发送邮件
        Transport.send(message);
    }
}
