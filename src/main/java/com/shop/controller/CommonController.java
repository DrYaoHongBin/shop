package com.shop.controller;

import com.github.pagehelper.PageInfo;
import com.shop.been.PageResult;
import com.shop.model.admin.CategoryOne;
import com.shop.model.merchant.Item;
import com.shop.service.admin.CategoryService;
import com.shop.service.merchant.ItemsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

/**
 *  <p>Description:商品搜索控制器</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/21 9:06
 */
@Controller
public class CommonController {

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ItemsService itemsService;

    /**
     * 前往主页并查询出所有类目
     * @return
     */
    @RequestMapping(value = "/")
    public String index(Model model) {
        model.addAttribute("categoryList", categoryService.selectAllCategory());
        return "/WEB-INF/jsp/new_index";
    }

    /**
     * 根据类目名查询出对应的商品和一、二级类目
     * @param categoryName
     * @param model
     * @return
     */
    @RequestMapping(value = "selectItemsByCategory")
    public String selectItemsByCategory(String categoryName,Model model) {
        // 根据一级或者二级类目查询出一个一级类目和关联的二级类目
        CategoryOne category = categoryService.selectCategoryByName(categoryName);
        // 根据类目名查询出多个商品的部分信息和关联的对象，只返回查询结果第一页12条数据
        PageInfo<Item> pageInfo = itemsService.selectItemsByCategory(categoryName);
        model.addAttribute("category", category);
        model.addAttribute("pageInfo", pageInfo);
        // 将查询条件也保存进request
        model.addAttribute("categoryName", categoryName);
        return "/WEB-INF/jsp/items";
    }

    /**
     * 商品搜索结果异步分页
     * @param search 搜索框内容
     * @param categoryName
     * @param pageNum
     * @param pageSize
     * @param path 项目路径
     * @return
     */
    @RequestMapping("asyncSelectItems")
    @ResponseBody
    public PageResult asyncSelectItems(String categoryName, String search, Integer pageNum, Integer pageSize, String path) {
        return itemsService.asyncSelectItems(categoryName, search, pageNum, pageSize, path);
    }

    /**
     * 根据搜索框内容查询商品
     * @param search
     * @param model
     * @return
     */
    @RequestMapping(value = "selectItemsBySearchName")
    public String selectItemsBySearchName(String search,Model model) {
        PageInfo<Item> pageInfo = itemsService.selectItemsBySearchName(search);
        model.addAttribute("pageInfo", pageInfo);
        // 将查询条件也保存进request
        model.addAttribute("search", search);
        return "/WEB-INF/jsp/items";
    }

    /**
     * 查看商品详情
     * @param itemId
     * @return
     */
    @RequestMapping(value = "showItem")
    public String showItem(Integer itemId, Model model) {
        Item item = itemsService.showItem(itemId);
        model.addAttribute("item", item);
        return "/WEB-INF/jsp/item";
    }

}
