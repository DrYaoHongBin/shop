package com.shop.controller;

import com.shop.util.Reflections;

public class BaseAdminController<T> {
    protected Class<T> entityClass = Reflections.getClassGenricType(getClass()); //获取泛型
    String className = entityClass.getName().substring(entityClass.getName().lastIndexOf(".")+1);
    protected String TEMPLATE_NAME=className.substring(0,1).toLowerCase()+className.substring(1);  //类名

    protected String dir = "/WEB-INF/jsp/";  //后台的jsp目录
    protected String TEMPLATE_PATH =dir + TEMPLATE_NAME +"/"; //每个模块的目录
    protected String REDIRECT_URL="redirect:/admin/"+TEMPLATE_NAME+"/";      //重定向
}
