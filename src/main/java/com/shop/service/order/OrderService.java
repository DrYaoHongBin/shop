package com.shop.service.order;

import com.github.pagehelper.PageInfo;
import com.shop.been.AjaxResult;
import com.shop.been.PageResult;
import com.shop.model.merchant.Item;
import com.shop.model.order.Order;
import com.shop.model.order.OrderDetail;
import com.shop.model.user.Address;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/8/9 3:29
 */
public interface OrderService {

    /**
     * 前往下单页面，将订单信息保存进session
     * @param item 保存了商品id
     * @param itemNumber 商品数量
     * @param session
     * @return
     */
    void saveOrderUI(Item item, Integer itemNumber, HttpSession session);

    /**
     * 查询出用户的地址
     * @param userId
     * @param pageNum
     * @param pageSize
     * @return
     */
    PageResult selectAddress(Integer userId, Integer pageNum, Integer pageSize);

    /**
     * 保存订单
     * @param address 接收用户收货地址id
     * @param order 接收订单总价，备注
     * @param orderDetail 接收商品数量
     * @param session  从session中取出之前保存的商品信息
     * @return
     */
    AjaxResult svaeOrder(Address address, Order order, OrderDetail orderDetail, HttpSession session);

    /**
     * 用户查看订单
     * @param userId
     * @param pageNum
     * @param pageSize
     * @return
     */
    PageInfo<Order> showOrdersByUserId(Integer userId, Integer pageNum, Integer pageSize);

    /**
     * 用户删除订单
     * @param order
     */
    AjaxResult userDelete(Order order);

    /**
     * 查看订单详情
     * @param orderId
     * @return
     */
    Order orderDetail(Integer orderId);

    /**
     * 商家查看订单
     * @param merchantId
     * @return
     */
    PageInfo<Order> selectOrderByMerchantId(Integer merchantId, Integer pageNum, Integer pageSize);

    /**
     * 商家删除订单
     * @param order
     */
    AjaxResult merchantDelete(Order order);
}
