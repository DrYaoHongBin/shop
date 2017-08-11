package com.shop.model.user;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * 地址实体
 */
@Table(name = "shop_address")
public class Address {

    /**
     * 用户地址主键
     */
    @Id
    private Integer addressId;

    /**
     * 收货人姓名
     */
    private String username;

    /**
     * 收货人联系方式
     */
    private String phone;

    /**
     * 省
     */
    private String province;

    /**
     * 市
     */
    private String city;

    /**
     * 区
     */
    private String area;

    /**
     * 邮政编码
     */
    private String zipCode;

    /**
     * 详细地址
     */
    private String fullAddress;

    /**
     * 关联的用户主键
     */
    private Integer userId;

    /**
     * 该属性值为，则表示该地址为用户设置的默认地址
     */
    private Integer defaultAddress;

    @Transient
    private User user;

    public Address(Integer addressId, String username, String phone, String province, String city, String area, String zipCode, String fullAddress, Integer userId, Integer defaultAddress, User user) {
        this.addressId = addressId;
        this.username = username;
        this.phone = phone;
        this.province = province;
        this.city = city;
        this.area = area;
        this.zipCode = zipCode;
        this.fullAddress = fullAddress;
        this.userId = userId;
        this.defaultAddress = defaultAddress;
        this.user = user;
    }

    @Override
    public String toString() {
        return "Address{" +
                "addressId=" + addressId +
                ", username='" + username + '\'' +
                ", phone='" + phone + '\'' +
                ", province='" + province + '\'' +
                ", city='" + city + '\'' +
                ", area='" + area + '\'' +
                ", zipCode=" + zipCode +
                ", fullAddress='" + fullAddress + '\'' +
                ", userId=" + userId +
                ", defaultAddress=" + defaultAddress +
                ", user=" + user +
                '}';
    }

    public Address() {
        super();
    }

    public Integer getAddressId() {
        return addressId;
    }

    public void setAddressId(Integer addressId) {
        this.addressId = addressId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getFullAddress() {
        return fullAddress;
    }

    public void setFullAddress(String fullAddress) {
        this.fullAddress = fullAddress;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Integer getDefaultAddress() {
        return defaultAddress;
    }

    public void setDefaultAddress(Integer defaultAddress) {
        this.defaultAddress = defaultAddress;
    }
}