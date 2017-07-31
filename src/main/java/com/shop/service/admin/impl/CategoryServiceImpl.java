package com.shop.service.admin.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.shop.been.AjaxResult;
import com.shop.dao.admin.CategoryOneMapper;
import com.shop.dao.admin.CategoryTwoMapper;
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
    CategoryOneMapper categoryOneMapper;

    @Autowired
    CategoryTwoMapper categoryTwoMapper;

    public AjaxResult saveCategoryOne(CategoryOne categoryOne) {
        // 查询类目是否已经添加
        CategoryOne newCategoryOne = categoryOneMapper.selectOne(categoryOne);
        // 如果为空，则允许添加
        if (newCategoryOne == null) {
            // id为空表示添加操作
            if (categoryOne.getCategoryOneId() == null) {
                categoryOneMapper.insert(categoryOne);
                return new AjaxResult(true, "添加成功");
            } else {
                // id不为空表示修改操作;
                categoryOneMapper.updateByPrimaryKey(categoryOne);
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
                return new AjaxResult(true, "添加成功");
            } else {
                // 不为空，表示修改操作
                categoryTwoMapper.updateByPrimaryKey(categoryTwo);
                return new AjaxResult(true, "修改成功");
            }
        } else {
            return new AjaxResult(false, "添加失败，该类目已存在");
        }
    }

    public void removeCategoryOne(CategoryOne categoryOne) {
        // 根据主键删除
        categoryOneMapper.deleteByPrimaryKey(categoryOne);
    }

    public void removeCategoryTwo(CategoryTwo categoryTwo) {
        categoryTwoMapper.deleteByPrimaryKey(categoryTwo);
    }

    public PageInfo<CategoryOne> selectAllCategoryOne(Integer pageNum, Integer pageSize) {
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

    public PageInfo<CategoryTwo> selectAllCategoryTwo(CategoryOne categoryOne, Integer pageNum, Integer pageSize) {
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
}
