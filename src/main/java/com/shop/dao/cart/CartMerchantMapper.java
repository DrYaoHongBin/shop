package com.shop.dao.cart;

import com.shop.model.cart.CartMerchant;
import com.shop.util.BaseMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

public interface CartMerchantMapper extends BaseMapper<CartMerchant> {
    /**
     * 往购物车插入商家，返回的插入后的主键会赋值到实体类中
     * @param cartMerchant
     * @return
     */
    Integer saveCartMerchant(CartMerchant cartMerchant);

    /**
     * 查询用户购物车的商品
     * @param userId
     * @return
     */
    CartMerchant selectCart(Integer userId);
}