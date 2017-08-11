package com.shop.controller.order;

import com.github.pagehelper.PageInfo;
import com.shop.been.AjaxResult;
import com.shop.been.PageResult;
import com.shop.controller.BaseController;
import com.shop.model.merchant.Item;
import com.shop.model.order.Order;
import com.shop.model.order.OrderDetail;
import com.shop.model.user.Address;
import com.shop.service.merchant.ItemsService;
import com.shop.service.order.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

/**
 * <p>Description:订单控制器</p>
 *
 * @Author 姚洪斌
 * @Date 2017/8/9 3:30
 */
@RequestMapping(value = "order")
@Controller
public class OrderController extends BaseController<Order> {

    @Autowired
    private OrderService orderService;

    /**
     * 前往下单页面，将订单信息保存进session
     * @param item 保存了商品id
     * @param itemNumber 商品数量
     * @param session
     * @param model
     * @return
     */
    @RequestMapping(value = "saveOrderUI")
    public String saveOrderUI(Item item, Integer itemNumber, HttpSession session, Model model) {
        // 查询出用户的商品信息和地址，并放入session域中
        orderService.saveOrderUI(item, itemNumber, session);
        return TEMPLATE_PATH + "order";
    }

    @RequestMapping(value = "selectAddress")
    @ResponseBody
    public PageResult selectAddress(Integer userId, Integer pageNum, Integer pageSize) {
        return orderService.selectAddress(userId, pageNum, pageSize);
    }

    /**
     * 异步保存订单
     * @param address 接收用户收货地址id
     * @param order 接收订单总价，备注
     * @param orderDetail 接收商品数量
     * @param session  从session中取出之前保存的商品信息
     * @return
     */
    @RequestMapping(value = "saveOrder")
    @ResponseBody
    public AjaxResult saveOrder(Address address, Order order, OrderDetail orderDetail, HttpSession session) {
       return orderService.svaeOrder(address, order, orderDetail, session);
    }

    /**
     * 用户查看订单
     * @param userId
     * @param pageNum
     * @param pageSize
     * @param model
     * @return
     */
    @RequestMapping(value = "showOrdersByUserId")
    public String showOrdersByUserId(Integer userId, Integer pageNum, Integer pageSize, Model model) {
        // 根据用户id搜索出对应的订单
        PageInfo<Order> pageInfo = orderService.showOrdersByUserId(userId, pageNum, pageSize);
        model.addAttribute("pageInfo", pageInfo);
        return  "/WEB-INF/jsp/user/orders";
    }

    /**
     * 用户删除订单
     * @param order
     * @return
     */
    @RequestMapping(value = "userDelete")
    @ResponseBody
    public AjaxResult userDelete(Order order) {
        return orderService.userDelete(order);
    }

    /**
     * 用户查看订单详情
     * @param order
     * @param model
     * @return
     */
    @RequestMapping(value = "orderDetailByUser")
    public String OrderDetailByUser(Order order, Model model) {
        Order newOrder = orderService.orderDetail(order.getOrderId());
        model.addAttribute("order", newOrder);
        return "/WEB-INF/jsp/user/order_detail";
    }

    /**
     * 商家查看订单
     * @param merchantId
     * @param pageNum
     * @param pageSize
     * @param model
     * @return
     */
    @RequestMapping(value = "selectOrderByMerchantId")
    public String selectOrderByMerchantId(Integer merchantId, Integer pageNum, Integer pageSize, Model model) {
        // 根据商家id搜索出对应的订单
        PageInfo<Order> pageInfo = orderService.selectOrderByMerchantId(merchantId, pageNum, pageSize);
        model.addAttribute("pageInfo", pageInfo);
        return  "/WEB-INF/jsp/merchant/orders";
    }

    /**
     * 商家删除订单
     * @param order
     * @return
     */
    @RequestMapping(value = "merchantDelete")
    @ResponseBody
    public AjaxResult merchantDelete(Order order) {
        return orderService.merchantDelete(order);
    }

    /**
     * 商家查看订单详情
     * @param order
     * @param model
     * @return
     */
    @RequestMapping(value = "orderDetailByMerchant")
    public String OrderDetailByMerchant(Order order, Model model) {
        Order newOrder = orderService.orderDetail(order.getOrderId());
        model.addAttribute("order", newOrder);
        return "/WEB-INF/jsp/merchant/order_detail";
    }
}
