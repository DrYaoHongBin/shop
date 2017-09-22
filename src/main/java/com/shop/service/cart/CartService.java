package com.shop.service.cart;

import com.shop.been.AjaxResult;
import com.shop.model.cart.CartItem;
import com.shop.model.cart.CartMerchant;
import com.shop.model.user.User;

import java.util.List;

/**
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/9/5 10:58
 */
public interface CartService {

    /**
     * 异步添加商品进购物车
     * @param cartMerchant 保存商品对应商家，用户id
     * @param cartItem 保存商品id和商品数量
     * @return
     */
    AjaxResult saveCart(CartMerchant cartMerchant, CartItem cartItem);

    /**
     * 查询购物车
     * @param userId
     * @return
     */
    CartMerchant selectCart(Integer userId);
}
