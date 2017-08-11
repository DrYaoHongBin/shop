package com.shop.service.order.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.shop.been.AjaxResult;
import com.shop.been.PageResult;
import com.shop.dao.merchant.ItemMapper;
import com.shop.dao.order.OrderDetailMapper;
import com.shop.dao.order.OrderMapper;
import com.shop.dao.user.AddressMapper;
import com.shop.dao.user.UserMapper;
import com.shop.model.merchant.Item;
import com.shop.model.order.Order;
import com.shop.model.order.OrderDetail;
import com.shop.model.user.Address;
import com.shop.model.user.User;
import com.shop.service.order.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/8/9 3:29
 */
@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private OrderDetailMapper orderDetailMapper;

    @Autowired
    private ItemMapper itemMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private AddressMapper addressMapper;

    public void saveOrderUI(Item item, Integer itemNumber, HttpSession session) {
        // 获取商品的标题，价格，id和关联的商家
        Item orderItem = itemMapper.selectOrderItem(item.getItemId());
        // 获取登录用户
        User loginUser = (User) session.getAttribute("loginUser");
        // 查询出默认地址
        // 设置条件
        Address condition = new Address();
        condition.setDefaultAddress(1);
        condition.setUserId(loginUser.getUserId());
        List<Address> address = addressMapper.select(condition);
        session.setAttribute("orderItem", orderItem);
        session.setAttribute("defaultAddress", address);
        session.setAttribute("itemNumber", itemNumber);
    }

    public PageResult selectAddress(Integer userId,Integer pageNum, Integer pageSize) {
        // 没有页数，默认第一页
        if (pageNum == null) {
            pageNum = 1;
        }
        if (pageSize == null) {
            // 没有设置条数，默认每页20条数据
            pageSize = 20;
        }
        PageHelper.startPage(pageNum, pageSize);
        User user = userMapper.selectAddress(userId);
        StringBuffer message = new StringBuffer();
        for (Address address: user.getAddresses()) {
            String result = "<ul class=\" clearfix\">\n" +
                                "<li>\n" +
                                "<div class=\"fl pc-address\">\n" +
                                "<span><input type=\"radio\" name=\"addressId\" value=\"" + address.getAddressId() + "\" ></span>" +
                                "<span>" + address.getUsername() + "</span>\n" +
                                "<span>" + address.getPhone() + "</span>\n" +
                                "<span>" + address.getProvince() + address.getCity() + address.getArea() + "</span>\n" +
                                "<span>" + address.getFullAddress() + "</span>\n" +
                                "<span>" + address.getZipCode() + "</span>\n" +
                                "</div>\n" +
                                "</li>\n" +
                            "</ul>";
            message.append(result);
        }
        // 对查询出来的结果进行包装
        PageInfo<Address> info = new PageInfo<Address>(user.getAddresses());
        // 异步查询结果包装
        PageResult pageResult = new PageResult(message.toString(), info.getPages(), info.getPrePage(),
                info.getNextPage(), info.getPageNum(), info.getSize());
        return pageResult;
    }

    public AjaxResult svaeOrder(Address address, Order order, OrderDetail orderDetail, HttpSession session) {
        try {
            // 从session中取出商品信息
            Item orderItem = (Item) session.getAttribute("orderItem");
            // 根据商品id查询出最新的商品信息
            Item item = itemMapper.selectOne(orderItem);
            // 从session中取出用户
            User loginUser = (User) session.getAttribute("loginUser");
            // 如果用户购买数量大于库存，则购买失败
            if (orderDetail.getItemNumber() > item.getStock()) {
                return new AjaxResult(false, "购买失败，库存不足");
            }
            // 创建订单号
            // 取系统当前时间作为订单号变量前半部分，精确到毫秒
            Long orderNumber = Long.parseLong(new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()));
            order.setOrderNumber(orderNumber.toString());
            // 订单创建时间
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String s = sdf.format(new Date());
            order.setCreateTime(s);
            // 设置订单是否删除的标识
            order.setUserDelete(0);
            order.setMerchantDelete(0);
            // 设置关联的商家和用户id
            order.setMerchantId(orderItem.getMerchantId());
            order.setUserId(loginUser.getUserId());
            // 查询出地址
            address = addressMapper.selectByPrimaryKey(address);
            // 保存地址
            order.setAddress(address.getProvince() + address.getCity() + address.getArea() + address.getFullAddress() +
                    "," + address.getZipCode() + "," + address.getPhone());
            // 保存订单
            orderMapper.saveOrder(order);
            // 商品库存减少
            item.setStock(item.getStock() - orderDetail.getItemNumber());
            // 销量增加
            item.setSales(item.getSales() + orderDetail.getItemNumber());
            itemMapper.updateByPrimaryKey(item);
            // 设置订单详情关联的订单id和关联的商品主键
            orderDetail.setOrderId(order.getOrderId());
            orderDetail.setItemId(orderItem.getItemId());
            // 设置商品原标题，价格
            orderDetail.setItemName(item.getItemTitle());
            orderDetail.setItemPrice(item.getPrice());
            // 保存订单详情
            orderDetailMapper.insert(orderDetail);
        } catch (Exception e) {
            e.printStackTrace();
            return new AjaxResult(false,"订单创建失败，请稍后重试");
        }
        // 添加成功，删除session中的数据
        session.removeAttribute("orderItem");
        session.removeAttribute("defaultAddress");
        session.removeAttribute("itemNumber");
        return new AjaxResult(true, "下单成功");
    }

    public PageInfo<Order> showOrdersByUserId(Integer userId, Integer pageNum, Integer pageSize) {
        // 没有指定页数默认查询第一页
        if (pageNum == null) {
            pageNum = 1;
        }
        // 没有指定每页的条数默认每页5条
        if (pageSize == null) {
            pageSize = 5;
        }
        //PageHelper插件分页，会在startPage后面的第一条select查询语句加上limit
        PageHelper.startPage(pageNum, pageSize);
        // address只保存了关联的用户主键，根据该主键查询出该用户保存的多个订单
        List<Order> orders = orderMapper.showOrdersByUserId(userId);
        // 用PageInfo对结果进行包装
        PageInfo<Order> pageInfo = new PageInfo<Order>(orders);
        // PageInfo中的list属性是查询出来的结果集
        return pageInfo;
    }

    public AjaxResult userDelete(Order order) {
        try {
            // userDelete值为1时表示用户已删除订单
            order.setUserDelete(1);
            orderMapper.updateByPrimaryKeySelective(order);
        } catch (Exception e) {
            e.printStackTrace();
            return new AjaxResult(false, "删除失败，请稍后重试");
        }
        return new AjaxResult(true,"删除成功");
    }

    public Order orderDetail(Integer orderId) {
        return orderMapper.orderDetail(orderId);
    }

    public PageInfo<Order> selectOrderByMerchantId(Integer merchantId, Integer pageNum, Integer pageSize) {
        // 没有指定页数默认查询第一页
        if (pageNum == null) {
            pageNum = 1;
        }
        // 没有指定每页的条数默认每页5条
        if (pageSize == null) {
            pageSize = 5;
        }
        //PageHelper插件分页，会在startPage后面的第一条select查询语句加上limit
        PageHelper.startPage(pageNum, pageSize);
        // address只保存了关联的用户主键，根据该主键查询出该用户保存的多个订单
        List<Order> orders = orderMapper.selectOrderByMerchantId(merchantId);
        // 用PageInfo对结果进行包装
        PageInfo<Order> pageInfo = new PageInfo<Order>(orders);
        // PageInfo中的list属性是查询出来的结果集
        return pageInfo;
    }

    public AjaxResult merchantDelete(Order order) {
        try {
            // userDelete值为1时表示用户已删除订单
            order.setMerchantDelete(1);
            orderMapper.updateByPrimaryKeySelective(order);
        } catch (Exception e) {
            e.printStackTrace();
            return new AjaxResult(false, "删除失败，请稍后重试");
        }
        return new AjaxResult(true,"删除成功");
    }
}
