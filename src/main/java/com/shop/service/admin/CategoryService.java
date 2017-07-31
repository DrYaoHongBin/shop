package com.shop.service.admin;

import com.github.pagehelper.PageInfo;
import com.shop.been.AjaxResult;
import com.shop.model.admin.CategoryOne;
import com.shop.model.admin.CategoryTwo;

import java.util.List;

/**
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/30 16:02
 */
public interface CategoryService {

    /**
     * 保存/修改一级类目
     * @param categoryOne
     */
    AjaxResult saveCategoryOne(CategoryOne categoryOne);

    /**
     * 保存/修改二级类目
     * @param categoryTwo
     */
    AjaxResult saveCategoryTwo(CategoryTwo categoryTwo);

    /**
     * 删除一级类目，由于设置了级联，所以删除时会把关联的二级类目一起删除
     * @param categoryOne
     */
    void removeCategoryOne(CategoryOne categoryOne);

    /**
     * 删除二级类目
     * @param categoryTwo
     */
    void removeCategoryTwo(CategoryTwo categoryTwo);

    /**
     * 查询出一级类目
     * @param pageNum 查询第几页
     * @param pageSize 每页显示多少条
     * @return
     */
    PageInfo<CategoryOne> selectAllCategoryOne(Integer pageNum, Integer pageSize);

    /**
     * 根据传过来的一级类目id查询出关联的二级类目
     * @param categoryOne
     * @return
     */
    PageInfo<CategoryTwo> selectAllCategoryTwo(CategoryOne categoryOne, Integer pageNum, Integer pageSize);


}
