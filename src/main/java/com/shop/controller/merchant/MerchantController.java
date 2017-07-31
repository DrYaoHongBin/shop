package com.shop.controller.merchant;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/29 14:01
 */
@RequestMapping(value = "merchant")
@Controller
public class MerchantController {

    @RequestMapping(value = "merchantIndexUI")
    public String merchantIndex() {
        return "/WEB-INF/jsp/merchant/merchant_index";
    }

    @RequestMapping(value = "updateProductUI")
    public String updateProductUI() {
        return "/WEB-INF/jsp/merchant/update_product";
    }
}
