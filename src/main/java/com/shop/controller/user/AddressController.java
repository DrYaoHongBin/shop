package com.shop.controller.user;

import com.github.pagehelper.PageInfo;
import com.shop.controller.BaseController;
import com.shop.model.user.Address;
import com.shop.model.user.User;
import com.shop.service.user.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

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
    private AddressService addressService;

    /**
     * 前往用户管理地址页面并查询出用户保存的地址
     * @param address
     * @return
     */
    @RequestMapping(value = "showAddressUI")
    public String showAddressUI(Address address, Integer pageNum, Integer pageSize, Model model, HttpSession session) {
        User loginUser = (User)session.getAttribute("loginUser");
        if (address.getUserId() == null) {
            address.setUserId(loginUser.getUserId());
        }
        PageInfo<Address> addressPageInfo = addressService.selectAllAddress(address, pageNum, pageSize);
        // 将查询结果放到request域中（包含了分页信息）
        model.addAttribute("pageInfo", addressPageInfo);
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
    public String saveAddress(@Validated Address address, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            List<ObjectError> errors = bindingResult.getAllErrors();
            redirectAttributes.addFlashAttribute("errors", errors);
            return REDIRECT_URL + "showAddressUI";
        }
        String message = addressService.saveAddress(address);
        redirectAttributes.addFlashAttribute("message",message);
        return REDIRECT_URL + "showAddressUI";
    }

    /**
     * 修改地址
     * @param address
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "updateAddress")
    public String updateAddress(@Validated Address address,BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            List<ObjectError> errors = bindingResult.getAllErrors();
            redirectAttributes.addFlashAttribute("errors", errors);
            return REDIRECT_URL + "showAddressUI";
        }
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

    /**
     * 用户设置默认地址
     * @param address 只包含了要设置为默认地址的地址主键
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "updateDefaultAddress")
    public String updateDefaultAddress(Address address, RedirectAttributes redirectAttributes) {
        addressService.updateDefaultAddress(address);
        redirectAttributes.addFlashAttribute("message","设置成功");
        return REDIRECT_URL + "showAddressUI";
    }
}
