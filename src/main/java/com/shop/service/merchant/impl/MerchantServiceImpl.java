package com.shop.service.merchant.impl;

import com.shop.been.AjaxResult;
import com.shop.dao.merchant.MerchantMapper;
import com.shop.model.merchant.Merchant;
import com.shop.service.merchant.MerchantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;

/**
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/29 14:20
 */
@Service
public class MerchantServiceImpl implements MerchantService {

    @Autowired
    private MerchantMapper merchantMapper;

    public AjaxResult saveMerchant(Merchant merchant, Integer userId, HttpSession session) {
        // 查询店铺名是否已被注册
        Merchant condition = merchantMapper.selectOne(merchant);
        // 如果已被注册，返回错误信息
        if (condition != null) {
            return new AjaxResult(false,  "该店铺名已被注册，请重新注册");
        } else {
            // 不为空，设置注册店铺的主键为登录用户的主键
            merchant.setMerchantId(userId);
            merchantMapper.insert(merchant);
            // 店铺注册成功，将该店铺保存进session
            session.setAttribute("loginMerchant", merchant);
            return new AjaxResult(true, "注册成功");
        }
    }
}
