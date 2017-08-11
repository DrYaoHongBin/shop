package com.shop.dao.order;

import com.shop.model.order.Order;
import com.shop.util.BaseMapper;

import java.util.List;

public interface OrderMapper extends BaseMapper<Order>{

    /**
     * 插入订单，会将插入后的id赋值到order
     * @param order
     * @return
     */
    Integer saveOrder(Order order);

    /**
     * 搜索出用户未删除的订单
     * @param userId
     * @return
     */
    List<Order> showOrdersByUserId(Integer userId);

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
    List<Order> selectOrderByMerchantId(Integer merchantId);

}