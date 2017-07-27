package com.shop.controller.user;

import com.shop.controller.BaseController;
import com.shop.model.Address;
import com.shop.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/27 2:40
 */
@RequestMapping(value = "address")
@Controller
public class AddressController extends BaseController<Address> {

    @Autowired
    AddressService addressService;

    /**
     * 前往地址管理页面
     * @return
     */
    @RequestMapping(value = "showAddressUI")
    public String orderAddressUI() {
        return TEMPLATE_PATH + "show_address";
    }

    /**
     * 前往地址更新页面
     * @return
     */
    @RequestMapping(value = "updateAddressUI")
    public String updateAddressUI(Model model, Integer addressId) {
        if (addressId != null) {
            Address address = addressService.selectAddress(addressId);
            model.addAttribute("address", address);
        }
        return TEMPLATE_PATH + "update_address";
    }

    /**
     * 添加新地址
     * @param address
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "saveAddress")
    public String saveAddress(Address address, RedirectAttributes redirectAttributes) {
        addressService.saveAddress(address);
        redirectAttributes.addFlashAttribute("message","添加成功");
        return REDIRECT_URL + "showAddressUI";
    }

    /**
     * 修改地址
     * @param address
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "updateAddress")
    public String updateAddress(Address address, RedirectAttributes redirectAttributes) {
        addressService.updateAddress(address);
        redirectAttributes.addFlashAttribute("message","修改成功");
        return REDIRECT_URL + "showAddressUI";
    }

    /**
     * 删除地址
     * @param addressId 被删除地址的主键
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "removeAddress")
    public String removeAddress(Integer addressId, RedirectAttributes redirectAttributes) {
        addressService.removeAddress(addressId);
        redirectAttributes.addFlashAttribute("message","删除成功");
        return REDIRECT_URL + "showAddressUI";
    }
}
