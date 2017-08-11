package com.shop.controller.merchant;

import com.github.pagehelper.PageInfo;
import com.shop.been.AjaxResult;
import com.shop.been.PageResult;
import com.shop.controller.BaseController;
import com.shop.model.admin.CategoryOne;
import com.shop.model.admin.CategoryTwo;
import com.shop.model.merchant.Item;
import com.shop.model.merchant.Merchant;
import com.shop.service.admin.CategoryService;
import com.shop.service.merchant.ItemsService;
import com.shop.service.merchant.MerchantService;
import org.aspectj.weaver.loadtime.Aj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * <p>Description:商家控制器</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/29 14:01
 */
@RequestMapping(value = "merchant")
@Controller
public class MerchantController extends BaseController<Merchant>{

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private MerchantService merchantService;

    @Autowired
    private ItemsService itemsService;

    /**
     * ajax方式用户注册店铺
     * @param merchant 包含店铺名
     * @param userId 登录用户的主键作为注册店铺的主键
     * @return
     */
    @RequestMapping(value = "saveMerchant")
    @ResponseBody
    public AjaxResult saveMerchant(Merchant merchant, Integer userId, HttpSession session) {
        return merchantService.saveMerchant(merchant, userId, session);
    }

    @RequestMapping(value = "merchantIndexUI")
    public String merchantIndex() {
        return "/WEB-INF/jsp/merchant/merchant_index";
    }

    /**
     * 前往添加商品页面，并查询出网站已有的一级类目
     * @param model
     * @return
     */
    @RequestMapping(value = "updateItemsUI")
    public String updateProductUI(Model model, Integer itemId) {
        // 查询出一级类目供添加商品时选择
        List<CategoryOne> categoryOnes = categoryService.selectAllCategoryOne();
        model.addAttribute("categoryOnes", categoryOnes);
        if (itemId != null) {
            // 商品id不为空，查询出商品
            Item newItem = itemsService.selectItem(itemId);
            model.addAttribute("item", newItem);
        }
        return TEMPLATE_PATH + "update_items";
    }

    /**
     * ajax请求获取一级类目id对应的二级类目id
     * @param categoryOne
     * @return
     */
    @RequestMapping(value = "selectCategoryTwo")
    @ResponseBody
    public List<CategoryTwo> selectCategoryTwo(CategoryOne categoryOne) {
        return categoryService.selectAllCategoryTwo(categoryOne);
    }

    /**
     * ueditor编辑区域上传图片
     * @param upImage
     * @param request
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "uploadImage")
    @ResponseBody
    public Map<String,String> uploadImage(@RequestParam(name = "upImage") CommonsMultipartFile upImage,
                                          HttpServletRequest request) throws IOException {
        // 图片原名称
        String fileName = upImage.getOriginalFilename();
        // 获取源图片的后缀
        String suffix = fileName.substring(fileName.lastIndexOf("."));
        // 创建新图片名字
        String newFileName = UUID.randomUUID().toString().replace("-", "") + suffix;
        if (!upImage.isEmpty()) {
            // 上传的本地磁盘路径
            String path = "D:\\shopImage\\product\\details\\" + newFileName;
            // 根据位置新建文件
            File newFile = new File(path);
            // 复制
            FileCopyUtils.copy(upImage.getBytes(), newFile);
        }
        // 返回结果信息(UEditor需要)
        Map<String,String> map = new HashMap<String,String >();
        // 上传是否成功，SUCCESS一定要大写
        map.put("state", "SUCCESS");
        // 现在的图片名称
        map.put("title", newFileName);
        // 图片类型 .+后缀名
        map.put("type", suffix);
        // ueditor读取图片路径(ueditor根据虚拟路径访问图片)
        map.put("url", "http://localhost:8080/image/product/details/" + newFileName);
        // 图片大小（字节数）
        map.put("size", upImage.getSize()+"");
        return map;
    }

    /**
     * ajax方式添加商品
     * @param item
     * @param file 商品图片
     * @return
     */
    @RequestMapping(value = "saveItem")
    @ResponseBody
    public AjaxResult saveItem(Item item, MultipartFile file) {
        return itemsService.saveItem(item, file);
    }

    /**
     * 前往查看商品页面，并查询出第一页，一页20条数据
     * @param model
     * @param item
     * @return
     */
    @RequestMapping(value = "showItemsUI")
    public String showItemsUI(Model model, Item item) {
        PageInfo<Item> pageInfo = itemsService.selectItems(item);
        model.addAttribute(pageInfo);
        return TEMPLATE_PATH + "show_items";
    }

    /**
     * 异步删除商品
     * @param item
     * @return
     */
    @RequestMapping(value = "deleteItem")
    @ResponseBody
    public AjaxResult deleteItem(Item item) {
        return itemsService.deleteItem(item);
    }

    /**
     * 查看商品页面异步分页
     * @param item
     * @param pageNum
     * @param pageSize
     * @param path  当前项目路径
     * @return
     */
    @RequestMapping(value = "asyncSelect")
    @ResponseBody
    public PageResult asyncSelect(Item item, Integer pageNum, Integer pageSize, String path) {
        return itemsService.asyncSelect(item, pageNum, pageSize, path);
    }

    /**
     * 到出商品目录excel表
     * @param merchantId
     * @param response
     */
    @RequestMapping(value = "exportExcel")
    public void exportExcel(Integer merchantId, HttpServletResponse response) {
        itemsService.exportExcel(merchantId, response);
    }

    /**
     * 导入excel表
     * @param file
     * @param redirectAttributes
     * @param session
     * @return
     */
    @RequestMapping(value = "inputExcel")
    public String inputExcel(MultipartFile file, RedirectAttributes redirectAttributes, HttpSession session) {
        String message = itemsService.inputExcel(file, session);
        redirectAttributes.addFlashAttribute("message", message);
        return "redirect:/merchant/merchantIndexUI";
    }






}
