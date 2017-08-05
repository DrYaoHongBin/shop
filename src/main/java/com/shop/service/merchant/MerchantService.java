package com.shop.service.merchant;

import com.shop.been.AjaxResult;
import com.shop.model.merchant.Merchant;

import javax.servlet.http.HttpSession;

/**
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/29 14:20
 */
public interface MerchantService {
    /**
     * 用户注册店铺
     * @param merchant 包含了店铺名
     * @param userId 登录用户的主键作为注册店铺的主键
     * @return 注册是否成功的信息
     */
    AjaxResult saveMerchant(Merchant merchant, Integer userId, HttpSession session);
}
