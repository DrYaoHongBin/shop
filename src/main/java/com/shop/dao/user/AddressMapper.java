package com.shop.dao.user;


import com.shop.model.user.Address;
import com.shop.util.BaseMapper;

public interface AddressMapper extends BaseMapper<Address> {

    /**
     * 设置原来的默认地址的defaultAddress值为null
     */
    void updateDefaultAddress();
}