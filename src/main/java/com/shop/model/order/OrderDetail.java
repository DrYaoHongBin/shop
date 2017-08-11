package com.shop.model.order;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * 订单明细实体
 */
@Table(name = "shop_orderdetail")
public class OrderDetail {

    /**
     * 订单明细主键
     */
    @Id
    private Integer detailId;

    /**
     * 商品数量
     */
    private Integer itemNumber;

    /**
     * 商品下单时的名字
     */
    private String itemName;

    /**
     * 商品下单的价格
     */
    private Double itemPrice;

    /**
     * 订单明细对应的商品主键
     */
    private Integer itemId;

    /**
     * 订单明细对应的订单主键
     */
    private Integer orderId;

    /**
     * 商品图片路径
     */
    @Transient
    private String imagePath;

    public OrderDetail(Integer detailId, Integer itemNumber, String itemName, Double itemPrice, Integer itemId, Integer orderId) {
        this.detailId = detailId;
        this.itemNumber = itemNumber;
        this.itemName = itemName;
        this.itemPrice = itemPrice;
        this.itemId = itemId;
        this.orderId = orderId;
    }

    @Override
    public String toString() {
        return "OrderDetail{" +
                "detailId=" + detailId +
                ", itemNumber=" + itemNumber +
                ", itemName='" + itemName + '\'' +
                ", itemPrice=" + itemPrice +
                ", itemId=" + itemId +
                ", orderId=" + orderId +
                '}';
    }

    public OrderDetail() {
        super();
    }

    public Integer getDetailId() {
        return detailId;
    }

    public void setDetailId(Integer detailId) {
        this.detailId = detailId;
    }

    public Integer getItemNumber() {
        return itemNumber;
    }

    public void setItemNumber(Integer itemNumber) {
        this.itemNumber = itemNumber;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public Double getItemPrice() {
        return itemPrice;
    }

    public void setItemPrice(Double itemPrice) {
        this.itemPrice = itemPrice;
    }

    public Integer getItemId() {
        return itemId;
    }

    public void setItemId(Integer itemId) {
        this.itemId = itemId;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
}