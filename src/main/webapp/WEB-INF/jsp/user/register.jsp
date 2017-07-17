<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="Generator" content="EditPlus®">
    <meta name="Author" content="">
    <meta name="Keywords" content="">
    <meta name="Description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE">
    <meta name="renderer" content="webkit">
    <title>用户注册</title>
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/theme/icon/favicon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/base.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/login.css">
    <script src="${pageContext.request.contextPath}/resources/theme/js/jquery-3.1.1.min.js"></script>
</head>
<body>
<!--- header begin-->
<header id="pc-header">
    <div class="login-header" style="padding-bottom:0">
        <div><h1><a href="index.html"><img src="${pageContext.request.contextPath}/resources/theme/icon/logo.png"></a></h1></div>
    </div>
</header>
<!-- header End -->
<section id="login-content">
    <div class="login-centre">
        <div class="login-switch clearfix">
            <p class="fr">我已经注册，现在就 <a href="${pageContext.request.contextPath}/loginUI">登录</a></p>
        </div>
        <div class="login-back">
            <div class="H-over">
                <form>
                    <div class="login-input">
                        <label><i class="heart">*</i>用户名：</label>
                        <input type="text" class="list-input1" id="username" name="info[username]" placeholder="">
                    </div>
                    <div class="login-input">
                        <label><i class="heart">*</i>请设置密码：</label>
                        <input type="text" class="list-input" id="password" name="info[password]" placeholder="">
                    </div>
                    <div class="login-input">
                        <label><i class="heart">*</i>请确认密码：</label>
                        <input type="text" class="list-input" id="password1" name="info[password]" placeholder="">
                    </div>
                    <div class="login-input" id="phoneRegister">
                        <label><i class="heart">*</i>手机号：</label>
                        <input type="text" class="list-iphone" id="iphone" name="info[password]" placeholder="">
                        <a href="#" class="obtain">获取短信验证码</a>
                    </div>
                    <div class="login-input" id="emailRegister" style="display: none">
                        <label><i class="heart">*</i>邮箱：</label>
                        <input type="text" class="list-iphone" id="email" name="info[password]" placeholder="">
                        <a href="#" class="obtain">获取邮箱验证码</a>
                    </div>
                    <div class="login-input">
                        <label><i class="heart">*</i>验证码：</label>
                        <input type="text" class="list-notes" id="message" name="info[password]" placeholder="">
                    </div>
                    <div class="item-ifo" id="p1" >
                        <label for="protocol"><a id="protocol" class="blue" href="#" onclick="emailRegister()">没有手机号？改用邮箱注册</a></label>
                        <span class="clr"></span>
                    </div>
                    <div class="item-ifo" id="p2" style="display: none">
                        <label for="protocol2"><a id="protocol2" class="blue" href="#" onclick="phoneRegister()">没有邮箱？改用手机号注册</a></label>
                        <span class="clr"></span>
                    </div>
                    <div class="login-button">
                        <a href="#">立即注册</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<!--- footer begin-->
<footer id="footer">
    <div class="containers">
        <div class="w" style="padding-top:30px">
            <div id="footer-2013">
                <div class="links">
                    <a href="">关于我们</a>
                    |
                    <a href="">联系我们</a>
                    |
                    <a href="">人才招聘</a>
                    |
                    <a href="">商家入驻</a>
                    |
                    <a href="">广告服务</a>
                    |
                    <a href="">手机京东</a>
                    |
                    <a href="">友情链接</a>
                    |
                    <a href="">销售联盟</a>
                    |
                    <a href="">English site</a>
                </div>
                <div style="padding-left:10px">
                    <p style="padding-top:10px; padding-bottom:10px; color:#999">网络文化经营许可证：浙网文[2013]0268-027号| 增值电信业务经营许可证：浙B2-20080224-1</p>
                    <p style="padding-bottom:10px; color:#999">信息网络传播视听节目许可证：1109364号 | 互联网违法和不良信息举报电话:0571-81683755</p>
                </div>
            </div>
        </div>

    </div>
</footer>
<!-- footer End -->
<script type="text/javascript">

    function emailRegister() {
        $("#phoneRegister").hide();
        $("#emailRegister").show();
        $("#p1").hide();
        $("#p2").show();
    }
    function phoneRegister() {
        $("#phoneRegister").show();
        $("#emailRegister").hide();
        $("#p1").show();
        $("#p2").hide();
    }
</script>
</body>
</html>
