package com.shop.model.merchant;

import org.hibernate.validator.constraints.NotBlank;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.util.List;

/**
 * 商家实体
 */
@Table(name = "shop_merchant")
public class Merchant {

    /**
     * 商家主键，与用户表主键关联
     */
    @Id
    private Integer merchantId;

    /**
     * 店铺名
     */
    @NotBlank(message = "{merchant.merchantName.error}")
    private String merchantName;

    /**
     * 商家对应的所有商品
     */
    @Transient
    private List<Item> items;

    public Merchant(Integer merchantId, String merchantName, List<Item> items) {
        this.merchantId = merchantId;
        this.merchantName = merchantName;
        this.items = items;
    }

    @Override
    public String toString() {
        return "Merchant{" +
                "merchantId=" + merchantId +
                ", merchantName='" + merchantName + '\'' +
                ", itemList=" + items +
                '}';
    }

    public List<Item> getItems() {
        return items;
    }

    public void setItems(List<Item> items) {
        this.items = items;
    }

    public Merchant() {
        super();
    }

    public Integer getMerchantId() {
        return merchantId;
    }

    public void setMerchantId(Integer merchantId) {
        this.merchantId = merchantId;
    }

    public String getMerchantName() {
        return merchantName;
    }

    public void setMerchantName(String merchantName) {
        this.merchantName = merchantName;
    }
}