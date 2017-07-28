package com.shop.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.shop.dao.AddressMapper;
import com.shop.model.Address;
import com.shop.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/27 23:55
 */
@Service
public class AddressServiceImpl implements AddressService {

    @Autowired
    AddressMapper addressMapper;

    public void saveAddress(Address address) {
        addressMapper.insert(address);
    }

    public Address selectAddress(Integer addressId) {
        // 根据主键查询出地址
        return addressMapper.selectByPrimaryKey(addressId);
    }

    public void updateAddress(Address address) {
        // 根据主键更新不为null的数据
        addressMapper.updateByPrimaryKeySelective(address);
    }

    public void removeAddress(Integer addressId) {
        // 根据主键删除
        addressMapper.deleteByPrimaryKey(addressId);
    }

    public PageInfo<Address> selectAllAddress(Address address, Integer pageNum, Integer pageSize) {
        if (pageNum == null) {
            pageNum = 1;
        }
        if (pageSize == null) {
            pageSize = 3;
        }
        //PageHelper插件分页，会在startPage后面的第一条select查询语句加上limit
        PageHelper.startPage(pageNum, pageSize);
        // address只保存了关联的用户主键，根据该主键查询出该用户保存的多个地址
        List<Address> addressList = addressMapper.select(address);
        // 用PageInfo对结果进行包装
        PageInfo<Address> pageInfo = new PageInfo<Address>(addressList);
        // PageInfo中的list属性将是结果集
        return pageInfo;
    }
}
