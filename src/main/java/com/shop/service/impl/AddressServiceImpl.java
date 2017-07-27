package com.shop.service.impl;

import com.shop.dao.AddressMapper;
import com.shop.model.Address;
import com.shop.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
        return addressMapper.selectByPrimaryKey(addressId);
    }

    public void updateAddress(Address address) {
        addressMapper.updateByPrimaryKeySelective(address);
    }

    public void removeAddress(Integer addressId) {
        addressMapper.deleteByPrimaryKey(addressId);
    }
}
