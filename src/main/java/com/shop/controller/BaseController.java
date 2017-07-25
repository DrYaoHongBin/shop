package com.shop.controller;

import com.shop.util.Reflections;

/**
 * Controller执行完毕后返回的视图前缀
 * @param <T>
 */
public class BaseController <T>{
    // 获取泛型
    protected Class<T> entityClass = Reflections.getClassGenricType(getClass());
    String className = entityClass.getName().substring(entityClass.getName().lastIndexOf(".")+1);
    // 类名
    protected String TEMPLATE_NAME=className.substring(0,1).toLowerCase()+className.substring(1);
    // 后台的jsp目录
    protected String dir = "/WEB-INF/jsp/";
    // 每个模块的目录
    protected String TEMPLATE_PATH =dir + TEMPLATE_NAME +"/";
    // 重定向
    protected String REDIRECT_URL="redirect:/"+TEMPLATE_NAME+"/";
}
