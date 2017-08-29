package com.shop.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * <p>Description:properties文件获取工具类</p>
 *
 * @Author 姚洪斌
 * @Date 2017/8/29 9:35
 */
public class PropertiesUtil {

    private static Properties properties;

    /**
     * 在静态代码块调用静态方法并保存在静态属性中供其他程序调用
     */
    static {
        loadProperties();
    }

    private static void loadProperties() {
        InputStream inputStream = null;
        try {
            // 通过类加载器获取properties文件流
            inputStream = PropertiesUtil.class.getClassLoader().getResourceAsStream("path.properties");
            System.out.println(inputStream);
            properties.load(inputStream);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                // 关闭输入流
                inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String [] args) {
        System.out.print(properties);
    }
}
