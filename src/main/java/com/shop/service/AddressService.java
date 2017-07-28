package com.shop.service;

import com.github.pagehelper.PageInfo;
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

    /**
     *  用户前往地址管理页面前查询出该用户保存的地址
     * @param address 只保存了地址关联的用户主键
     * @param pageNum 查询的页码
     * @param pageSize 每页的条数
     * @return
     */
    PageInfo<Address> selectAllAddress(Address address, Integer pageNum, Integer pageSize);

}
