package com.shop.service.merchant;

import com.github.pagehelper.PageInfo;
import com.shop.been.AjaxResult;
import com.shop.been.PageResult;
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
     * 添加和修改商品
     * @param item 商品的具体信息
     * @param file 商品图片
     * @return 添加是否成功的信息
     */
    AjaxResult saveItem(Item item, MultipartFile file);

    /**
     * 前往查看商品页面，查询出商家对应的商品
     * 默认查询第1页，1页20条数据
     * @param item 包含了商品对应的商家主键
     * @return
     */
    PageInfo<Item> selectItems(Item item);

    /**
     * 根据id查询一个商品全部信息
     * @param itemId
     * @return
     */
    Item selectItem(Integer itemId);

    /**
     * 异步根据商品id删除商品
     * @param item
     * @return
     */
    AjaxResult deleteItem(Item item);

    /**
     *分页
     * @param item 包含了商家id
     * @param pageNum 页码
     * @param pageSize 每页条数
     * @param path 项目路径
     * @return
     */
    PageResult asyncSelect(Item item, Integer pageNum, Integer pageSize, String path);
}
