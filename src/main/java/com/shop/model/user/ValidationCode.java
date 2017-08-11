package com.shop.model.user;

import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 验证码实体
 */
@Table(name = "validation_code")
public class ValidationCode {

    @Id
    private Integer id;

    /**
     * 验证码对应的手机号码
     */
    private String phoneNumber;

    /**
     * 验证码过期时间
     */
    private Long endTime;

    /**
     * 验证码
     */
    private Integer validationCode;

    /**
     * 验证码对应的邮箱
     */
    private String email;

    public ValidationCode(Integer id, String phoneNumber,  Long endTime, Integer validationCode, String email) {
        this.id = id;
        this.phoneNumber = phoneNumber;
        this.endTime = endTime;
        this.validationCode = validationCode;
        this.email = email;
    }

    @Override
    public String toString() {
        return "ValidationCode{" +
                "id=" + id +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", endTime=" + endTime +
                ", validationCode=" + validationCode +
                ", email='" + email + '\'' +
                '}';
    }

    public ValidationCode() {
        super();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Long getEndTime() {
        return endTime;
    }

    public void setEndTime(Long endTime) {
        this.endTime = endTime;
    }

    public Integer getValidationCode() {
        return validationCode;
    }

    public void setValidationCode(Integer validationCode) {
        this.validationCode = validationCode;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}