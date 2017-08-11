package com.shop.model.user;

import com.shop.model.merchant.Merchant;
import org.hibernate.validator.constraints.Email;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.util.List;

/**
 * 用户实体
 */
@Table(name = "shop_user")
public class User {
    /**
     * 用户主键
     */
    @Id
    private Integer userId;

    /**
     * 用户名
     */
    private String username;

    /**
     * 用户密码
     */
    private String password;

    /**
     * 用户注册邮箱
     */
    @Email
    private String email;

    /**
     * 用户注册手机号码
     */
    private String phoneNumber;

    /**
     * 出生日期：年
     */
    private String year;

    /**
     * 月
     */
    private String month;

    /**
     * 日
     */
    private String day;

    /**
     * 用户性别
     */
    private String sex;

    /**
     * 用户头像保存的部分路径+名字
     */
    private String image;

    /**
     * 用户对应的商家
     */
    @Transient
    private Merchant merchant;

    /**
     * 用户对应的所有地址
     */
    @Transient
    private List<Address> addresses;

    public User(Integer userId, String username, String password, String email, String phoneNumber, String year, String month, String day, String sex, String image, Merchant merchant, List<Address> addresses) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.year = year;
        this.month = month;
        this.day = day;
        this.sex = sex;
        this.image = image;
        this.merchant = merchant;
        this.addresses = addresses;
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", year='" + year + '\'' +
                ", month='" + month + '\'' +
                ", day='" + day + '\'' +
                ", sex='" + sex + '\'' +
                ", image='" + image + '\'' +
                ", merchant=" + merchant +
                ", addresses=" + addresses +
                '}';
    }

    public User() {
        super();
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public List<Address> getAddresses() {
        return addresses;
    }

    public void setAddresses(List<Address> addresses) {
        this.addresses = addresses;
    }

    public Merchant getMerchant() {
        return merchant;
    }

    public void setMerchant(Merchant merchant) {
        this.merchant = merchant;
    }
}