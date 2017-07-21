package com.shop.util;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.apache.commons.codec.digest.DigestUtils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * <p>Description:秒嘀科技短信发送工具类</p>
 *
 * @Author 姚洪斌
 * @Date 2017/7/20 10:33
 */
public class MiaoDi  {
    /**
     * url前半部分
     */
    private static final String BASE_URL = "https://api.miaodiyun.com/20150822";

    /**
     * 开发者注册后系统自动生成的账号，可在官网登录后查看
     */
    private static final String ACCOUNT_SID = "399fe18d1cb7433eb56b3b9ed8ecfb25";

    /**
     * 开发者注册后系统自动生成的TOKEN，可在官网登录后查看
     */
    private static final String AUTH_TOKEN = "2c199b0fa9c444dc814cc795361dc611";

    /**
     * 响应数据类型, JSON或XML
     */
    private static final String RESP_DATA_TYPE = "json";
    private static String operation = "/industrySMS/sendSMS";
    private static String accountSid = ACCOUNT_SID;
    private static String id = "51268643"; //短信模板id，使用模板，因此不需要设置短信内容，只需要发送验证码变量

    /**
     * 构造通用参数timestamp、sig和respDataType,这3个参数不能少
     *
     * @return
     */
    public static String createCommonParam()
    {
        // 时间戳
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String timestamp = sdf.format(new Date());
        // 签名
        String sig = DigestUtils.md5Hex(ACCOUNT_SID + AUTH_TOKEN + timestamp);
        return "&timestamp=" + timestamp + "&sig=" + sig + "&respDataType=" + RESP_DATA_TYPE;
    }

    /**
     * post请求
     *
     * @param url
     *            功能和操作
     * @param body
     *            要post的数据
     * @return
     * @throws IOException
     */
    public static String post(String url, String body)
    {
        System.out.println("url:" + System.lineSeparator() + url);
        System.out.println("body:" + System.lineSeparator() + body);

        String result = "";
        try
        {
            OutputStreamWriter out = null ;
            BufferedReader in = null;
            URL realUrl = new URL(url);
            URLConnection conn = realUrl.openConnection();

            // 设置连接参数
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setConnectTimeout(5000);
            conn.setReadTimeout(20000);

            // 提交数据
            out = new OutputStreamWriter(conn.getOutputStream(), "UTF-8");
            out.write(body);
            out.flush();

            // 读取返回数据
            in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            String line = "";
            boolean firstLine = true; // 读第一行不加换行符
            while ((line = in.readLine()) != null)
            {
                if (firstLine)
                {
                    firstLine = false;
                } else
                {
                    result += System.lineSeparator();
                }
                result += line;
            }
        } catch (Exception e)
        {
            e.printStackTrace();
        }
        return result;
    }

    /**
     *
     * @param to 接收短信的手机号
     * @param code 发送的验证码
     */
    public static String execute(String to, Integer code) {
        String url = BASE_URL + operation;
        String body = "accountSid=" + accountSid + "&to=" + to + "&templateid=" + id + "&param=" + code
                + createCommonParam();
        // 提交请求
        String result = post(url, body);
        System.out.println("result:" +System.lineSeparator() + result);
        //创建json解析器,需要加入jar包
        JsonParser jsonParser = new JsonParser();
        // 使用解析器解析json数据，返回值是JsonElement，强制转化为其子类JsonObject类型
        JsonObject jsonObject = (JsonObject)jsonParser.parse(result);
        // 使用JsonObject的get(String memeberName)方法返回JsonElement，再使用JsonElement的getAsXXX方法得到真实类型
        String respCode = jsonObject.get("respCode").getAsString(); //如果返回值是00000，则发送成功
        System.out.print(respCode + "--------------");
        return respCode;
    }
}
