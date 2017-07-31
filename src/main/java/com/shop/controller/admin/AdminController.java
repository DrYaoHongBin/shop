package com.shop.controller.admin;

import com.github.pagehelper.PageInfo;
import com.shop.been.AjaxResult;
import com.shop.controller.BaseController;

import com.shop.model.admin.Admin;
import com.shop.model.admin.CategoryOne;
import com.shop.model.admin.CategoryTwo;
import com.shop.service.admin.AdminService;
import com.shop.service.admin.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

/**
 * <p>Description:商城管理员控制器</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/30 5:15
 */
@RequestMapping(value = "admin/admin")
@Controller
public class AdminController extends BaseController<Admin> {

    @Autowired
    AdminService adminService;

    @Autowired
    CategoryService categoryService;

    /**
     * 前往商城管理员登录页面
     * @return
     */
    @RequestMapping(value = "loginUI")
    public String loginUI() {
        return TEMPLATE_PATH + "admin_login";
    }

    /**
     * 管理员登录
     * @param admin 保存了管理员的账号和密码
     * @param session 登录成功的话将管理员对象保存进session
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "login")
    public String login(Admin admin, HttpSession session, RedirectAttributes redirectAttributes) {
        String message = adminService.login(admin, session);
        // 没有返回错误信息，则表示登录成功
        if (message == null) {
            return REDIRECT_URL + "admin/categoryOneUI";
        } else {
            redirectAttributes.addFlashAttribute("message",message);
            // 登录失败，返回登录页面
            return REDIRECT_URL + "admin/loginUI";
        }
    }

    /**
     * 管理员退出登录
     * @param session
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        adminService.logout(session);
        redirectAttributes.addFlashAttribute("message", "注销成功");
        // 注销成功，前往登录页面
        return REDIRECT_URL + "admin/loginUI";
    }

    /**
     * 前往一级商品类目页面,并查询出商品的一级类目
     * @return
     */
    @RequestMapping(value = "categoryOneUI")
    public String categoryUI(Integer pageNum, Integer pageSize, Model model) {
        PageInfo<CategoryOne> pageInfo = categoryService.selectAllCategoryOne(pageNum, pageSize);
        model.addAttribute("pageInfo", pageInfo);
        return TEMPLATE_PATH + "category_one";
    }

    /**
     * 添加一级类目
     * @param categoryOne
     * @return
     */
    @RequestMapping(value = "saveCategoryOne")
    @ResponseBody
    public AjaxResult saveCategoryOne(CategoryOne categoryOne) {
        AjaxResult ajaxResult = categoryService.saveCategoryOne(categoryOne);
        return ajaxResult;
    }

    /**
     * 估计一级类目的主键删除一级类目，设置了级联，关联的二级目录也删除
     * @param categoryOne
     * @return
     */
    @RequestMapping(value = "removeCategoryOne")
    public String removeCategoryOne(CategoryOne categoryOne) {
        categoryService.removeCategoryOne(categoryOne);
        return REDIRECT_URL + "admin/categoryOneUI";
    }

    /**
     * 前往二级类目页面
     * @param categoryOne 二级类目关联的一级类目主键，根据该键查询
     * @param pageNum
     * @param pageSize
     * @param model
     * @return
     */
    @RequestMapping(value = "categoryTwoUI")
    public String categoryTwoUI(CategoryOne categoryOne, Integer pageNum, Integer pageSize, Model model) {
        PageInfo<CategoryTwo> pageInfo = categoryService.selectAllCategoryTwo(categoryOne, pageNum ,pageSize);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute(categoryOne);
        return TEMPLATE_PATH + "category_two";
    }

    /**
     * 添加二级类目
     * @param categoryTwo
     * @return
     */
    @RequestMapping(value = "saveCategoryTwo")
    @ResponseBody
    public AjaxResult saveCategoryTwo(CategoryTwo categoryTwo) {
        AjaxResult ajaxResult = categoryService.saveCategoryTwo(categoryTwo);
        return ajaxResult;
    }

    /**
     * 删除二级类目页面
     * @param categoryTwo
     * @param redirectAttributes 重定向时带参数
     * @return
     */
    @RequestMapping(value = "removeCategoryTwo")
    public String removeCategoryTwo(CategoryTwo categoryTwo, RedirectAttributes redirectAttributes) {
        categoryService.removeCategoryTwo(categoryTwo);
        // 重定向到二级类目，传查询条件
        //使用RedirectAttributes的addFlashAttribute重定向传不了参数，拼接url才传得了参数
        redirectAttributes.addAttribute("categoryOneId", categoryTwo.getCategoryOneId());
        return REDIRECT_URL + "admin/categoryTwoUI";
    }




}
