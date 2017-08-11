package com.shop.model.order;

import com.shop.model.merchant.Item;
import com.shop.model.user.User;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.util.Date;
import java.util.List;

/**
 * 订单实体
 */
@Table(name = "shop_order")
public class Order {

    /**
     * 订单主键
     */
    @Id
    private Integer orderId;

    /**
     * 订单号
     */
    private String orderNumber;

    /**
     * 用户下单时间
     */
    private String createTime;

    /**
     * 订单对应的商家主键
     */
    private Integer merchantId;

    /**
     * 订单对应的用户主键
     */
    private Integer userId;

    /**
     * 订单总价
     */
    private Double totalPrice;

    /**
     * 订单地址
     */
    private String address;

    /**
     * 标识用户是否删除了订单。默认值为0，当值为1则表示用户已删除订单
     */
    private Integer userDelete;

    /**
     * 标识商家是否删除了订单。默认值为0，当值为1则表示商家已删除订单
     */
    private Integer merchantDelete;

    /**
     * 订单备注
     */
    private String remark;

    /**
     * 订单对应的订单明细
     */
    @Transient
    private List<OrderDetail> orderDetails;

    /**
     * 商家名
     */
    @Transient
    private String merchantName;

    /**
     * 下单用户名
     */
    @Transient
    private String username;

    /**
     * 商品
     */
    @Transient
    private Item item;

    public Order() {
        super();
    }

    public Order(Integer orderId, String orderNumber, String createTime, Integer merchantId, Integer userId, Double totalPrice, String address, Integer userDelete, Integer merchantDelete, String remark, List<OrderDetail> orderDetails, String merchantName, String username, Item item) {
        this.orderId = orderId;
        this.orderNumber = orderNumber;
        this.createTime = createTime;
        this.merchantId = merchantId;
        this.userId = userId;
        this.totalPrice = totalPrice;
        this.address = address;
        this.userDelete = userDelete;
        this.merchantDelete = merchantDelete;
        this.remark = remark;
        this.orderDetails = orderDetails;
        this.merchantName = merchantName;
        this.username = username;
        this.item = item;
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", orderNumber='" + orderNumber + '\'' +
                ", createTime='" + createTime + '\'' +
                ", merchantId=" + merchantId +
                ", userId=" + userId +
                ", totalPrice=" + totalPrice +
                ", address='" + address + '\'' +
                ", userDelete=" + userDelete +
                ", merchantDelete=" + merchantDelete +
                ", remark='" + remark + '\'' +
                ", orderDetails=" + orderDetails +
                ", merchantName='" + merchantName + '\'' +
                ", username='" + username + '\'' +
                ", item=" + item +
                '}';
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public List<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public Integer getMerchantId() {
        return merchantId;
    }

    public void setMerchantId(Integer merchantId) {
        this.merchantId = merchantId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getUserDelete() {
        return userDelete;
    }

    public void setUserDelete(Integer userDelete) {
        this.userDelete = userDelete;
    }

    public Integer getMerchantDelete() {
        return merchantDelete;
    }

    public void setMerchantDelete(Integer merchantDelete) {
        this.merchantDelete = merchantDelete;
    }

    public String getMerchantName() {
        return merchantName;
    }

    public void setMerchantName(String merchantName) {
        this.merchantName = merchantName;
    }

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}