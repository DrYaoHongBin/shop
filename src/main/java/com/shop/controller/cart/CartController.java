package com.shop.controller.cart;
import com.shop.been.AjaxResult;
import com.shop.model.cart.CartItem;
import com.shop.model.cart.CartMerchant;
import com.shop.model.merchant.Item;
import com.shop.model.merchant.Merchant;
import com.shop.service.cart.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;


/**
 * <p>Description:购物车控制器</p>
 *
 * @Author 姚洪斌
 * @Date 2017/8/22 9:31
 */
@RequestMapping(value = "cart")
@Controller
public class CartController  {

    @Autowired
    private CartService cartService;

    /**
     * 前往购物车页面
     * @return
     */
    @RequestMapping(value = "cartUI")
    public String cartUI(Model model, Integer userId) {
        // 查询出购物车内的商品
        CartMerchant cartMerchants = cartService.selectCart(userId);
        System.out.println(cartMerchants.getMerchants().size());
        model.addAttribute("cartMerchants", cartMerchants);
        return "/WEB-INF/jsp/cart/cart";
    }

    @RequestMapping(value = "saveCart")
    @ResponseBody
    public AjaxResult saveCart(CartMerchant cartMerchant, CartItem cartItem) {
        return cartService.saveCart(cartMerchant, cartItem);
    }

}
