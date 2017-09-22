package com.shop.model.cart;

import com.shop.model.merchant.Merchant;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.util.List;

@Table(name = "shop_cart_merchant")
public class CartMerchant {

    @Id
    private Integer cartMerchantId;

    private Integer merchantId;

    private Integer userId;

    @Transient
    private List<Merchant> merchants;

    public CartMerchant(Integer cartMerchantId, Integer merchantId, Integer userId) {
        this.cartMerchantId = cartMerchantId;
        this.merchantId = merchantId;
        this.userId = userId;
    }

    public CartMerchant() {
        super();
    }

    public Integer getCartMerchantId() {
        return cartMerchantId;
    }

    public void setCartMerchantId(Integer cartMerchantId) {
        this.cartMerchantId = cartMerchantId;
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

    public void setMerchants(List<Merchant> merchants) {
        this.merchants = merchants;
    }

    public List<Merchant> getMerchants() {
        return merchants;
    }
}