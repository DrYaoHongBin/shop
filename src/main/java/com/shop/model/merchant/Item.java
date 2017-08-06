package com.shop.model.merchant;

import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "shop_item")
public class Item {

    /**
     * 商品主键
     */
    @Id
    private Integer itemId;

    /**
     * 商品标题
     */
    private String itemTitle;

    /**
     * 商品对应的一级类目
     */
    private String categoryOne;

    /**
     * 商品对应的二级类目
     */
    private String categoryTwo;

    /**
     * 商品价格
     */
    private Double price;

    /**
     * 商品库存
     */
    private Integer stock;

    /**
     * 商品图片部分路径+名字
     */
    private String images;

    /**
     * 商品关联的商家id
     */
    private Integer merchantId;

    /**
     * 商品详情
     */
    private String details;

    /**
     * 商品销量
     */
    private Integer sales;

    public Item(Integer itemId, String itemTitle, String categoryOne, String categoryTwo, Double price, Integer stock, String images, Integer merchantId, String details, Integer sales) {
        this.itemId = itemId;
        this.itemTitle = itemTitle;
        this.categoryOne = categoryOne;
        this.categoryTwo = categoryTwo;
        this.price = price;
        this.stock = stock;
        this.images = images;
        this.merchantId = merchantId;
        this.details = details;
        this.sales = sales;
    }

    @Override
    public String toString() {
        return "Item{" +
                "itemId=" + itemId +
                ", itemTitle='" + itemTitle + '\'' +
                ", categoryOne='" + categoryOne + '\'' +
                ", categoryTwo='" + categoryTwo + '\'' +
                ", price=" + price +
                ", stock=" + stock +
                ", images='" + images + '\'' +
                ", merchantId=" + merchantId +
                ", details='" + details + '\'' +
                ", sales=" + sales +
                '}';
    }

    public Item() {
        super();
    }

    public Integer getSales() {
        return sales;
    }

    public void setSales(Integer sales) {
        this.sales = sales;
    }

    public Integer getItemId() {
        return itemId;
    }

    public void setItemId(Integer itemsId) {
        this.itemId = itemsId;
    }

    public String getItemTitle() {
        return itemTitle;
    }

    public void setItemTitle(String itemTitle) {
        this.itemTitle = itemTitle;
    }

    public String getCategoryOne() {
        return categoryOne;
    }

    public void setCategoryOne(String categoryOne) {
        this.categoryOne = categoryOne;
    }

    public String getCategoryTwo() {
        return categoryTwo;
    }

    public void setCategoryTwo(String categoryTwo) {
        this.categoryTwo = categoryTwo;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getStock() {
        return stock;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public Integer getMerchantId() {
        return merchantId;
    }

    public void setMerchantId(Integer merchantId) {
        this.merchantId = merchantId;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }
}