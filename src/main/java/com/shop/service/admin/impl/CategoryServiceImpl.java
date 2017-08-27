package com.shop.service.admin.impl;

import com.alibaba.druid.support.json.JSONUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.shop.been.AjaxResult;
import com.shop.dao.admin.CategoryOneMapper;
import com.shop.dao.admin.CategoryTwoMapper;
import com.shop.dao.jedis.JedisDao;
import com.shop.model.admin.CategoryOne;
import com.shop.model.admin.CategoryTwo;
import com.shop.service.admin.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/30 16:03
 */
@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryOneMapper categoryOneMapper;

    @Autowired
    private CategoryTwoMapper categoryTwoMapper;

    @Autowired
    private JedisDao jedisDao;

    public AjaxResult saveCategoryOne(CategoryOne categoryOne) {
        // 查询类目是否已经添加
        CategoryOne newCategoryOne = categoryOneMapper.selectOne(categoryOne);
        // 如果为空，则允许添加
        if (newCategoryOne == null) {
            // id为空表示添加操作
            if (categoryOne.getCategoryOneId() == null) {
                categoryOneMapper.insert(categoryOne);
                // 商品类目改变，删除redis中的缓存
                jedisDao.del("category");
                return new AjaxResult(true, "添加成功");
            } else {
                // id不为空表示修改操作;
                categoryOneMapper.updateByPrimaryKey(categoryOne);
                // 商品类目改变，删除redis中的缓存
                jedisDao.del("category");
                return new AjaxResult(true, "修改成功");
            }
        } else {
            return new AjaxResult(false, "添加失败，该类目已存在");
        }
    }

    public AjaxResult saveCategoryTwo(CategoryTwo categoryTwo) {
        // 设置查询条件
        CategoryTwo condition = new CategoryTwo();
        condition.setName(categoryTwo.getName());
        // 查询类目是否已添加
        CategoryTwo newCategoryTwo = categoryTwoMapper.selectOne(condition);
        // 如果查询结果为空，才允许添加
        if (newCategoryTwo == null) {
            // id为空。表示添加操作
            if (categoryTwo.getCategoryTwoId() == null) {
                categoryTwoMapper.insert(categoryTwo);
                // 商品类目改变，删除redis中的缓存
                jedisDao.del("category");
                return new AjaxResult(true, "添加成功");
            } else {
                // 不为空，表示修改操作
                categoryTwoMapper.updateByPrimaryKey(categoryTwo);
                // 商品类目改变，删除redis中的缓存
                jedisDao.del("category");
                return new AjaxResult(true, "修改成功");
            }
        } else {
            return new AjaxResult(false, "添加失败，该类目已存在");
        }
    }

    public void removeCategoryOne(CategoryOne categoryOne) {
        // 根据主键删除
        categoryOneMapper.deleteByPrimaryKey(categoryOne);
        // 商品类目改变，删除redis中的缓存
        jedisDao.del("category");
    }

    public void removeCategoryTwo(CategoryTwo categoryTwo) {
        categoryTwoMapper.deleteByPrimaryKey(categoryTwo);
        // 商品类目改变，删除redis中的缓存
        jedisDao.del("category");
    }

    public PageInfo<CategoryOne> selectCategoryOne(Integer pageNum, Integer pageSize) {
        // 没有指定页数默认查询第一页
        if (pageNum == null) {
            pageNum = 1;
        }
        // 没有指定每页的条数默认每页10条
        if (pageSize == null) {
            pageSize = 10;
        }
        //PageHelper插件分页，会在startPage后面的第一条select查询语句加上limit
        PageHelper.startPage(pageNum, pageSize);
        // 查询出一级类目
        List<CategoryOne> categoryOneList = categoryOneMapper.selectAll();
        // 对查询出来的结果进行包装
        PageInfo<CategoryOne> pageInfo = new PageInfo<CategoryOne>(categoryOneList);
        return pageInfo;
    }

    public PageInfo<CategoryTwo> selectCategoryTwo(CategoryOne categoryOne, Integer pageNum, Integer pageSize) {
        // 没有指定页数默认查询第一页
        if (pageNum == null) {
            pageNum = 1;
        }
        // 没有指定每页的条数默认每页10条
        if (pageSize == null) {
            pageSize = 10;
        }
        //PageHelper插件分页，会在startPage后面的第一条select查询语句加上limit
        PageHelper.startPage(pageNum, pageSize);
        // 设置查询条件
        CategoryTwo condition = new CategoryTwo();
        condition.setCategoryOneId(categoryOne.getCategoryOneId());
        // 查询出对应的二级类目
        List<CategoryTwo> categoryTwoList = categoryTwoMapper.select(condition);
        // 对查询出来的结果进行包装
        PageInfo<CategoryTwo> pageInfo = new PageInfo<CategoryTwo>(categoryTwoList);
        return pageInfo;
    }

    public List<CategoryOne> selectAllCategoryOne() {
        return categoryOneMapper.selectAll();
    }

    public List<CategoryTwo> selectAllCategoryTwo(CategoryOne categoryOne) {
        // 设置查询条件
        CategoryTwo condition = new CategoryTwo();
        condition.setCategoryOneId(categoryOne.getCategoryOneId());
        return categoryTwoMapper.select(condition);
    }

    public List<CategoryOne> selectAllCategory() {
        // json转换
        Gson gson = new Gson();
        // 要返回的商品类目集合
        List<CategoryOne> categoryOnes;
        // 从redis中获取商品类目
        try {
            String keyValue = jedisDao.get("category");
            // 如果keyValue不为空，则将字符串转为List集合
            if (keyValue != null) {
                // TypeToken是gson提供的数据类型转换器，可以支持各种数据集合类型转换。
                categoryOnes = gson.fromJson(keyValue, new TypeToken<List<CategoryOne>>(){}.getType());
                return categoryOnes;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // redis中没有缓存商品类目，则从数据库中查找
        categoryOnes = categoryOneMapper.selectAllCategory();

        // 将查询出来的所有商品类目信息保存进redis缓存
        try {
            // 将List集合转成字符串
            String keyValue = gson.toJson(categoryOnes);
            // 将结果保存进redis
            jedisDao.set("category", keyValue);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categoryOnes;
    }

    public CategoryOne selectCategoryByName(String categoryName) {
        return categoryOneMapper.selectCategoryByName(categoryName);
    }
}
