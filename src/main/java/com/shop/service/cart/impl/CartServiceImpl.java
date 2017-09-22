package com.shop.service.cart.impl;

import com.shop.been.AjaxResult;
import com.shop.dao.cart.CartItemMapper;
import com.shop.dao.cart.CartMerchantMapper;
import com.shop.model.cart.CartItem;
import com.shop.model.cart.CartMerchant;
import com.shop.service.cart.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/9/5 10:59
 */
@Service
public class CartServiceImpl implements CartService {

    @Autowired
    CartMerchantMapper cartMerchantMapper;

    @Autowired
    CartItemMapper cartItemMapper;

    public AjaxResult saveCart(CartMerchant cartMerchant, CartItem cartItem) {
        try {
            // 根据商家id和用户id查询用户购物车是否已包含该商家的商品
            CartMerchant selectResult = cartMerchantMapper.selectOne(cartMerchant);
            // 如果查询为空，先往购物车商家表添加商家
            if (selectResult == null) {
                cartMerchantMapper.saveCartMerchant(cartMerchant);
            } else  {
                // 如果不为空，将查询出来的购物车商家对象的id赋值给传参
                cartMerchant.setCartMerchantId(selectResult.getCartMerchantId());
            }
            // 如果查询不为空，将购物车商家对象的id赋值给购物车商品对象
            cartItem.setCartMerchantId(cartMerchant.getCartMerchantId());
            // 根据购物车商品对象的商品id和关联的购物车商家表id查询购物车是否已添加该商品
            CartItem condition = new CartItem();
            condition.setItemId(cartItem.getItemId());
            condition.setCartMerchantId(cartItem.getCartMerchantId());
            // 查询的结果
            CartItem conditionResult = cartItemMapper.selectOne(condition);
            // 如果不为空，直接更新商品的数量即可
            if (conditionResult != null) {
                // 修改商品数量
                conditionResult.setItemNumber(conditionResult.getItemNumber() + cartItem.getItemNumber());
                cartItemMapper.updateByPrimaryKey(conditionResult);
            } else {
                // 如果为空，直接保存
                cartItemMapper.insert(cartItem);
            }
            return new AjaxResult(true, "添加成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new AjaxResult(false, "添加失败，请稍后重试");
        }
    }

    public CartMerchant selectCart(Integer userId) {
        return cartMerchantMapper.selectCart(userId);
    }
}
