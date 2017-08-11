package com.shop.service.merchant.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.shop.been.AjaxResult;
import com.shop.been.PageResult;
import com.shop.dao.merchant.ItemMapper;
import com.shop.model.admin.CategoryOne;
import com.shop.model.merchant.Item;
import com.shop.model.merchant.Merchant;
import com.shop.service.merchant.ItemsService;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.Cell;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.ArrayList;
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
    private ItemMapper itemMapper;

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
        }
        if (pageSize == null) {
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

    public PageInfo<Item> selectItemsByCategory(String categoryName) {
        // 一开始前往搜索商品结果页面只展示第一页12条数据
        PageHelper.startPage(1, 12);
        List<Item> items = itemMapper.selectItemsByCategory(categoryName);
        PageInfo<Item> pageInfo = new PageInfo<Item>(items);
        return pageInfo;
    }

    public PageResult asyncSelectItems(String categoryName, String search, Integer pageNum, Integer pageSize, String path) {
        // 没有页数，默认第一页
        if (pageNum == null) {
            pageNum = 1;
        }
        if (pageSize == null) {
            // 没有设置条数，默认每页10条数据
            pageSize = 12;
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Item> items = null;
        // 如果categoryName和search哪一个值不为""则是当前用户的查询条件
        if ("".equals(categoryName)) {
            items = itemMapper.selectItemsBySearchName(search);
        } else {
            items = itemMapper.selectItemsByCategory(categoryName);
        }
        // 拼接html
        StringBuffer message = new StringBuffer();
        for (Item i: items) {
            String result = "<li>\n" +
                                "<a href=\"" + path + "/showItem?itemId=" + i.getItemId() +"\"><img src=\"/image/" + i.getImages() + "\" width=\"213\" height=\"213\"></a>\n" +
                                "<p class=\"head-name\"><a href=\"" + path + "/showItem?itemId=" + i.getItemId() + "\">" + i.getItemTitle() + "</a> </p>\n" +
                                "<br>\n" +
                                "<p><span class=\"price\">￥" + i.getPrice() + "</span><span class=\"fr\">" + i.getSales() +"人购买</span></p>\n" +
                                "<p><a href=\"" + path + "/" + i.getMerchantId() + "\"><span class=\"fl\">" + i.getMerchant().getMerchantName() + "</span></a></p>\n" +
                            "</li>";
            message.append(result);
        }
        // 对查询出来的结果进行包装
        PageInfo<Item> info = new PageInfo<Item>(items);
        // 异步查询结果包装
        PageResult pageResult = new PageResult(message.toString(), info.getPages(), info.getPrePage(),
                info.getNextPage(), info.getPageNum(), info.getSize());
        return pageResult;

    }

    public PageInfo<Item> selectItemsBySearchName(String search) {
        // 一开始前往搜索商品结果页面只展示第一页12条数据
        PageHelper.startPage(1, 12);
        List<Item> items = itemMapper.selectItemsBySearchName(search);
        PageInfo<Item> pageInfo = new PageInfo<Item>(items);
        return pageInfo;
    }

    public Item showItem(Integer itemId) {
        return itemMapper.showItem(itemId);
    }

    public void exportExcel(Integer merchantId, HttpServletResponse response) {
        try {
            // 根据商家id查询出所有的商品
            List<Item> items = itemMapper.exportExcel(merchantId);
            // 构造workbook对象(excel文件)
            HSSFWorkbook hssfWorkbook = new HSSFWorkbook();
            // 构造工作薄对象
            HSSFSheet sheet = hssfWorkbook.createSheet("商品目录");
            // 添加表头行
            HSSFRow hssfRow = sheet.createRow(0);
            // 设置单元格格式居中
            HSSFCellStyle cellStyle = hssfWorkbook.createCellStyle();
            cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
            // 添加表头内容
            HSSFCell headCell = hssfRow.createCell(0);
            headCell.setCellValue("商品标题");
            headCell.setCellStyle(cellStyle);

            headCell = hssfRow.createCell(1);
            headCell.setCellValue("一级类目");
            headCell.setCellStyle(cellStyle);

            headCell = hssfRow.createCell(2);
            headCell.setCellValue("二级类目");
            headCell.setCellStyle(cellStyle);

            headCell = hssfRow.createCell(3);
            headCell.setCellValue("价格");
            headCell.setCellStyle(cellStyle);

            headCell = hssfRow.createCell(4);
            headCell.setCellValue("销量");
            headCell.setCellStyle(cellStyle);

            headCell = hssfRow.createCell(5);
            headCell.setCellValue("库存");
            headCell.setCellStyle(cellStyle);
            // 将商品内容写入excel表
            for (int i = 0; i < items.size(); i++) {
                // 获取商品对象
                Item item = items.get(i);
                // 创建行
                hssfRow = sheet.createRow(i + 1);
                // 创建单元格并设置值
                HSSFCell cell = hssfRow.createCell(0);
                cell.setCellValue(item.getItemTitle());
                cell.setCellStyle(cellStyle);

                cell = hssfRow.createCell(1);
                cell.setCellValue(item.getCategoryOne());
                cell.setCellStyle(cellStyle);

                cell = hssfRow.createCell(2);
                cell.setCellValue(item.getCategoryTwo());
                cell.setCellStyle(cellStyle);

                cell = hssfRow.createCell(3);
                cell.setCellValue(item.getPrice());
                cell.setCellStyle(cellStyle);

                 cell = hssfRow.createCell(4);
                cell.setCellValue(item.getSales());
                cell.setCellStyle(cellStyle);

                cell = hssfRow.createCell(5);
                cell.setCellValue(item.getStock());
                cell.setCellStyle(cellStyle);
            }
            String fileName = "商品目录";
            ByteArrayOutputStream os = new ByteArrayOutputStream();
            hssfWorkbook.write(os);
            byte[] content = os.toByteArray();
            InputStream is = new ByteArrayInputStream(content);
            // 设置response参数，可以打开下载页面
            response.setContentType("application/vnd.ms-excel;charset=utf-8");
            response.setHeader("Content-Disposition", "attachment;filename="
                    + new String((fileName + ".xls").getBytes(), "iso-8859-1"));
            ServletOutputStream out = response.getOutputStream();
            BufferedInputStream bis = null;
            BufferedOutputStream bos = null;
            bis = new BufferedInputStream(is);
            bos = new BufferedOutputStream(out);
            byte[] buff = new byte[2048];
            int bytesRead;
            // Simple read/write loop.
            while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
                bos.write(buff, 0, bytesRead);
            }
            if (bis != null) {
                bis.close();
            }
            if (bos != null) {
                bos.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String inputExcel(MultipartFile file, HttpSession session) {
        List<Item> items = new ArrayList<Item>();
        Merchant merchant = (Merchant)session.getAttribute("loginMerchant");
        Integer merchantId = merchant.getMerchantId();
        // 构造workbook对象(excel文件)
        HSSFWorkbook hssfWorkbook = null;
        try {
            // Excel表转为输入流
            InputStream inputStream = file.getInputStream();
            // 读取Excel文件
            hssfWorkbook = new HSSFWorkbook(inputStream);
            inputStream.close();
            //  遍历工作表
            for (int numSheet = 0; numSheet < hssfWorkbook.getNumberOfSheets(); numSheet++) {
                HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(numSheet);
                // 遍历行
                for (int rowNum = 1; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
                    HSSFRow hssfRow = hssfSheet.getRow(rowNum);
                    if (hssfRow == null) {
                        continue;
                    }
                    // 将单元格中的内容存入集合
                    // 导入的excel表数据顺序为 商品标题，一级类目，二级类目，商品价格，商品库存
                    Item item = new Item();
                    item.setMerchantId(merchantId);
                    // 设置Cell的类型，然后就可以把纯数字作为String类型读进来了
                    hssfRow.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
                    HSSFCell cell = hssfRow.getCell(0);
                    item.setItemTitle(cell.getStringCellValue());
                    hssfRow.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
                    cell = hssfRow.getCell(1);
                    item.setCategoryOne(cell.getStringCellValue());
                    hssfRow.getCell(2).setCellType(Cell.CELL_TYPE_STRING);
                    cell = hssfRow.getCell(2);
                    item.setCategoryTwo(cell.getStringCellValue());
                    hssfRow.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
                    cell = hssfRow.getCell(3);
                    item.setPrice(Double.parseDouble(cell.getStringCellValue()));
                    hssfRow.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
                    cell = hssfRow.getCell(4);
                    item.setStock(Integer.parseInt(cell.getStringCellValue()));
                    items.add(item);
                }
            }
            // 保存数据进数据库
            for(Item item: items) {
                itemMapper.insertSelective(item);
            }
            return "导入成功";
        } catch (Exception e) {
            e.printStackTrace();
            return "导入失败,导入的excel表数据顺序为 商品标题，一级类目，二级类目，商品价格，商品库存,";
        }
    }
}
