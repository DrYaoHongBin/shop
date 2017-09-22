package com.shop.model.cart;

import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "shop_cart_item")
public class CartItem {

    @Id
    private Integer cartItemId;

    private Integer itemId;

    private Integer itemNumber;

    private Integer cartMerchantId;

    public CartItem(Integer cartItemId, Integer itemId, Integer itemNumber, Integer cartMerchantId) {
        this.cartItemId = cartItemId;
        this.itemId = itemId;
        this.itemNumber = itemNumber;
        this.cartMerchantId = cartMerchantId;
    }

    public CartItem() {
        super();
    }

    public Integer getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(Integer cartItemId) {
        this.cartItemId = cartItemId;
    }

    public Integer getItemId() {
        return itemId;
    }

    public void setItemId(Integer itemId) {
        this.itemId = itemId;
    }

    public Integer getItemNumber() {
        return itemNumber;
    }

    public void setItemNumber(Integer itemNumber) {
        this.itemNumber = itemNumber;
    }

    public Integer getCartMerchantId() {
        return cartMerchantId;
    }

    public void setCartMerchantId(Integer cartMerchantId) {
        this.cartMerchantId = cartMerchantId;
    }
}