package com.shop.dao;

import com.shop.model.Address;
import com.shop.util.BaseMapper;

public interface AddressMapper extends BaseMapper<Address> {

    /**
     * 设置原来的默认地址的defaultAddress值为null
     */
    void updateDefaultAddress();
}