package com.shop.dao.merchant;

import com.shop.model.merchant.Item;
import com.shop.util.BaseMapper;

import java.util.List;

public interface ItemMapper extends BaseMapper<Item>{

    /**
     * 商家商品管理页面，查询出多个商品，不查询出商品详情
     * @param item
     * @return
     */
    List<Item> selectItem(Item item);

    /**
     * 根据类目名查询出多个商品部分信息和关联的商家
     * @param categoryName 类目名
     * @return
     */
    List<Item> selectItemsByCategory(String categoryName);

    /**
     * 根据搜索框内容搜索商品
     * @param search
     * @return
     */
    List<Item> selectItemsBySearchName(String search);

    /**
     * 查看商品详情
     */
    Item showItem(Integer itemId);

    /**
     * 订单页面,根据商品id查询出商品id,标题，价格和关联的商家
     * @param itemId
     * @return
     */
    Item selectOrderItem(Integer itemId);

    /**
     * 查询出要导出的商品部分数据
     * @param merchantId
     * @return
     */
    List<Item> exportExcel(Integer merchantId);
}