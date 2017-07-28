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

    public String saveAddress(Address address) {
        Address condition = new Address();
        condition.setUserId(address.getUserId());
        // 查询出用户已经添加的地址数量(selectCount条件是AND)
        Integer addressNumber = addressMapper.selectCount(condition);
        // 用户添加的地址数大于20则不让添加
        if (addressNumber < 20) {
            addressMapper.insert(address);
            return "添加成功";
        } else {
            return "添加失败，您可保存的地址数已满";
        }
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

    public void updateDefaultAddress(Address address) {
        // 将原来的默认地址的defaultAddress值设为0
        addressMapper.updateDefaultAddress();
        // 根据转过来的地址主键设置defaultAddress值设为1
        address.setDefaultAddress(1);
        addressMapper.updateByPrimaryKeySelective(address);
    }
}
