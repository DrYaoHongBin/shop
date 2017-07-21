package com.shop.util;


import tk.mybatis.mapper.common.Mapper;
import tk.mybatis.mapper.common.MySqlMapper;

//通用mapper接口，该接口不能被扫描到
public interface BaseMapper<T> extends Mapper<T> {


}
