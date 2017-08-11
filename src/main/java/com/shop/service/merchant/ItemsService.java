package com.shop.service.merchant;

import com.github.pagehelper.PageInfo;
import com.shop.been.AjaxResult;
import com.shop.been.PageResult;
import com.shop.model.admin.CategoryOne;
import com.shop.model.merchant.Item;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/29 14:18
 */
public interface ItemsService {

    /**
     * 商家商品管理页面，添加和修改商品
     * @param item 商品的具体信息
     * @param file 商品图片
     * @return 添加是否成功的信息
     */
    AjaxResult saveItem(Item item, MultipartFile file);

    /**
     * 前往查看商品页面，查询出商家对应的商品
     * 默认查询第1页，1页20条数据，其他数据通过异步分页返回
     * @param item 包含了商品对应的商家主键
     * @return
     */
    PageInfo<Item> selectItems(Item item);

    /**
     * 商家商品管理页面，根据id查询一个商品全部信息
     * @param itemId
     * @return
     */
    Item selectItem(Integer itemId);

    /**
     * 商家商品管理页面，异步根据商品id删除商品
     * @param item
     * @return
     */
    AjaxResult deleteItem(Item item);

    /**
     * 商家后台查看商品分页
     * @param item 包含了商家id
     * @param pageNum 页码
     * @param pageSize 每页条数
     * @param path 项目路径
     * @return
     */
    PageResult asyncSelect(Item item, Integer pageNum, Integer pageSize, String path);

    /**
     * 从这里开始后面的方法都是用户商品搜索与查看功能的
     */

    /**
     * 前往商品搜索结果查看页面
     * 根据类目名查询出多个商品的部分信息和关联的商家（返回查询结果第一页12条数据，其他数据通过异步分页返回）
     * @param categoryName
     * @return
     */
    PageInfo<Item> selectItemsByCategory(String categoryName);

    /**
     * 商品搜索结果异步分页
     * @param search 搜索框内容
     * @param categoryName 根据类目名搜索
     * @param pageNum 页码
     * @param pageSize 每页条数
     * @param path 项目路径
     * @return 异步分页结果的封装
     */
    PageResult asyncSelectItems(String categoryName, String search, Integer pageNum, Integer pageSize, String path);

    /**
     * 前往商品搜索结果页面，根据搜索框搜索
     * @param search
     * @return
     */
    PageInfo<Item> selectItemsBySearchName(String search);

    /**
     * 查询出商品详情
     * @param itemId
     * @return
     */
    Item showItem(Integer itemId);


}
