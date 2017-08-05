package com.shop.dao.merchant;

import com.shop.model.merchant.Item;
import com.shop.util.BaseMapper;

import java.util.List;

public interface ItemMapper extends BaseMapper<Item>{

    /**
     * 查询出多个商品，不查询出商品详情
     * @param item
     * @return
     */
    List<Item> selectItem(Item item);

}