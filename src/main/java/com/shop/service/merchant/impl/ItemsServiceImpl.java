package com.shop.service.merchant.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.shop.been.AjaxResult;
import com.shop.been.PageResult;
import com.shop.dao.merchant.ItemMapper;
import com.shop.model.admin.CategoryOne;
import com.shop.model.merchant.Item;
import com.shop.service.merchant.ItemsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.List;
import java.util.UUID;

/**
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/29 14:19
 */
@Service
public class ItemsServiceImpl implements ItemsService {

    @Autowired
    ItemMapper itemMapper;

    public AjaxResult saveItem(Item item, MultipartFile file) {
        try {
            // 上传了新图片
            if (!file.isEmpty()) {
                // 商品图片路径不为空，不是更新操作，删除原来的图片
                if (item.getImages() != null) {
                    // 获取原来的图片名
                    String name = item.getImages().substring(item.getImages().lastIndexOf("/") + 1);
                    String path = "D:\\shopImage\\product\\items\\" + name;
                    File f = new File(path);
                    // 删除图片
                    f.delete();
                }
                // 商品图片原名称
                String fileName = file.getOriginalFilename();
                // 获取商品原图片的后缀
                String suffix = fileName.substring(fileName.lastIndexOf("."));
                // 创建新图片名字
                String newFileName = UUID.randomUUID().toString().replace("-", "") + item.getMerchantId() + suffix;
                if (!file.isEmpty()) {
                    // 上传的本地磁盘路径
                    String path = "D:\\shopImage\\product\\items\\" + newFileName;
                    // 根据位置新建文件
                    File newFile = new File(path);
                    // 复制
                    FileCopyUtils.copy(file.getBytes(), newFile);
                }
                // 将商品图片的部分路径+名字设置到Item对象的属性里面
                item.setImages("product/items/" + newFileName);
            }
            // 如果添加的商品没有二级目录，前台传过来不为空，会影响查询，这里进行判断，如果为""，则设为空
            if ("".equals(item.getCategoryTwo())) {
                item.setCategoryTwo(null);
            }

            // 添加商品操作
            if (item.getItemId() == null) {
                // 设置销量默认值为0
                item.setSales(0);
                // 保存商品
                itemMapper.insert(item);
                return new AjaxResult(true, "商品添加成功");
            } else {
                // 更新商品
                itemMapper.updateByPrimaryKeySelective(item);
                return new AjaxResult(true, "商品信息修改成功");
            }

        } catch (Exception e) {
            e.printStackTrace();
            return new AjaxResult(false, "发生未知错误，请稍后重试");
        }
    }

    public PageInfo<Item> selectItems(Item item) {
        //PageHelper插件分页，会在startPage后面的第一条select查询语句加上limit
        PageHelper.startPage(1, 10);
        // 查询出商品(不包括商品详情)
        List<Item> items = itemMapper.selectItem(item);
        // 对查询出来的结果进行包装
        PageInfo<Item> pageInfo = new PageInfo<Item>(items);
        return pageInfo;
    }

    public Item selectItem(Integer itemId) {
        Item item = new Item();
        item.setItemId(itemId);
        return itemMapper.selectOne(item);
    }

    public AjaxResult deleteItem(Item item) {
        try {
            itemMapper.deleteByPrimaryKey(item);
            return new AjaxResult(true, "删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new AjaxResult(false, "删除失败,请稍后重试");
        }
    }

    public PageResult asyncSelect(Item item, Integer pageNum, Integer pageSize, String path) {
        // 没有页数，默认第一页
        if (pageNum == null) {
            pageNum = 1;
        } else if (pageSize == null) {
            // 没有设置条数，默认每页10条数据
            pageSize = 10;
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Item> items = itemMapper.selectItem(item);
        // 拼接html
        String start = "<div class=\"row\">\n";
        String end = " </div>";
        StringBuffer message = new StringBuffer();
        message.append(start);
        for (Item i : items) {
            // 如果该商品没有二级目录，则设置值为""，防止返回后前台显示null
             if (i.getCategoryTwo() == null) {
                 i.setCategoryTwo("");
             }
            String result = "<tr>\n" +
                                "<td><img src=\"/image/" + i.getImages() + "\" width=\"35\" height=\"35\"/></td>\n" +
                                "<td>" + i.getItemTitle() + "</td>\n" +
                                "<td>" + i.getCategoryOne() + "</td>\n" +
                                "<td>" + i.getCategoryTwo() + "</td>\n" +
                                "<td>" + i.getPrice() + "</td>\n" +
                                "<td>" + i.getStock() + "</td>\n" +
                                "<td>" + i.getSales() + "</td>\n" +
                                "<td>\n" +
                                    "<a href=\"" +path+ "/merchant/updateItemsUI?itemId=" +i.getItemId() + "\" class=\"btn btn-primary btn-xs\">查看</a>\n" +
                                    "<input type=\"hidden\" id=\"delete\" value=\"" + i.getItemId() + "\">\n" +
                                    "<a href=\"#\" class=\"btn btn-danger btn-xs\" onclick=\"deleteItem(this)\">删除</a>\n" +
                                "</td>\n" +
                             "</tr>";
            message.append(result);
        }
        message.append(end);
        // 对查询出来的结果进行包装
        PageInfo<Item> info = new PageInfo<Item>(items);
        // 异步查询结果包装
        PageResult pageResult = new PageResult(message.toString(), info.getPages(), info.getPrePage(),
                info.getNextPage(), info.getPageNum(), info.getSize());
        return pageResult;
    }
}
