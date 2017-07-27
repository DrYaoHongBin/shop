package com.shop.service;

import com.shop.model.Address;

/**
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/27 23:54
 */
public interface AddressService {

    /**
     * 保存地址
     * @param address
     */
    void saveAddress(Address address);

    /**
     * 前往修改地址页面时查询出要修改的地址
     * @param addressId
     * @return
     */
    Address selectAddress(Integer addressId);

    /**
     * 修改地址
     * @param address
     */
    void updateAddress(Address address);

    /**
     * 删除地址
     * @param addressId
     */
    void removeAddress(Integer addressId);

}
