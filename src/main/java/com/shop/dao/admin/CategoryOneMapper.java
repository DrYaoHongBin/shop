package com.shop.dao.admin;

import com.shop.model.admin.CategoryOne;
import com.shop.util.BaseMapper;

import java.util.List;

public interface CategoryOneMapper extends BaseMapper<CategoryOne> {

    /**
     * 查询出所有的一级类目和关联的二级类目
     * @return
     */
    List<CategoryOne> selectAllCategory();

    /**
     * 查询一级或者二级类目名查询出一级类目和关联的二级类目
     * @param categoryName
     * @return
     */
    CategoryOne selectCategoryByName(String categoryName);

}