<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
        <div><h1><a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/theme/icon/logo.png"></a></h1></div>
    </div>
</header>
<!-- header End -->
<section id="login-content">
    <div class="login-centre">
        <div class="login-switch clearfix">
            <p class="fr">我已经注册，现在就 <a href="${pageContext.request.contextPath}/user/loginUI">登录</a></p>
        </div>
        <div class="login-back">
            <div class="H-over">
                <form action="${pageContext.request.contextPath}/user/register" method="post" id="register">
                    <div class="login-input">
                        <label><i class="heart">*</i>用户名：</label>
                        <input type="text" class="list-input1" id="username" name="username" value="${user.username}">
                    </div>
                    <div class="login-input">
                        <label><i class="heart">*</i>请设置密码：</label>
                        <input type="password" class="list-input" id="password" name="password" value="${user.password}">
                    </div>
                    <div class="login-input">
                        <label><i class="heart">*</i>请确认密码：</label>
                        <input type="password" class="list-input" id="passwordConfirm" name="passwordConfirm" value="${user.password}">
                    </div>
                    <div class="login-input" id="phoneRegister">
                        <label><i class="heart">*</i>手机号：</label>
                        <input type="text" class="list-iphone" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}" >
                        <a href="#" class="obtain" onclick="phoneNumberCode()">获取短信验证码</a>
                    </div>
                    <div class="login-input" id="emailRegister" style="display: none">
                        <label><i class="heart">*</i>邮箱：</label>
                        <input type="text" class="list-iphone" id="email" name="email" value="${user.email}">
                        <a href="#" class="obtain" onclick="emailCode()">获取邮箱验证码</a>
                    </div>
                    <div class="login-input">
                        <label><i class="heart">*</i>验证码：</label>
                        <input type="text" class="list-notes" id="validationCode" name="validationCode" >
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
                        <a href="#" onclick="submit()">立即注册</a>
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
<!--表单验证插件-->
<script src="${pageContext.request.contextPath}/resources/theme/util/jquery.validate.js" type="text/javascript"></script>
<!--导入自定义的验证规则-->
<script src="${pageContext.request.contextPath}/resources/theme/util/validate-methods.js" type="text/javascript"></script>
<script type="text/javascript">

    function emailRegister() {
        $("#phoneNumber").val(null); //清除文本框内容
        $("#phoneRegister").hide();
        $("#emailRegister").show();
        $("#p1").hide();
        $("#p2").show();
    }
    function phoneRegister() {
        $("#email").val(null)
        $("#emailRegister").hide();
        $("#phoneRegister").show();
        $("#p1").show();
        $("#p2").hide();
    }
    
    //表单数据校验
    $(document).ready(function () {
        $("#register").validate({
            rules: {
                username: {
                    required: true,
                    isContainBlank: true,
                    maxlength: 20,
                    minlength: 5
                },
                password: {
                    required: true,
                    isContainBlank: true,
                    maxlength: 20,
                    minlength: 5,
                },
                passwordConfirm: {
                    equalTo: '#password'
                },
                phoneNumber: {
                    required: true,
                    isPhoneNumber: true,
                    number: true,
                    maxlength: 11,
                    minlength: 11,
                },
                email: {
                    required: true,
                    email: true
                },
                validationCode: {
                    required: true,
                    number: true,
                    maxlength: 6,
                    minlength: 6,
                }
            },
            messages: {
                username: {
                    required: "用户名不可为空",
                    isContainBlank: "用户名不可包含空格",
                    maxlength: "用户名不可超过20位",
                    minlength: "用户名不可少于5位"
                },
                password: {
                    required: "密码不可为空",
                    isContainBlank: "密码不可包含空格",
                    maxlength: "密码不可超过20位",
                    minlength: "密码不可少于5位"
                },
                passwordConfirm: {
                    equalTo: "两次密码输入不一致"
                },
                phoneNumber: {
                    required: "手机号不可为空",
                    number: "请填写正确的手机号",
                    maxlength: "请填写正确的手机号",
                    minlength: "请填写正确的手机号",
                },
                email: {
                    required: "邮箱不可为空",
                    email: "请填写正确的邮箱"
                },
                validationCode: {
                    required: "请填写验证码",
                    number: "请填写合法的验证码",
                    maxlength: "请填写合法的验证码",
                    minlength: "请填写合法的验证码",
                },
            },
            submitHandler: function(form) {  //验证通过之后回调
                form.submit(); //提交表单，如果不写，即便通过表单也不会自动提交
            },
            invalidHandler: function(form, validator) {  //验证不通过之后回调
                return false;
            }
        })
    })

    //注册按钮修改为input样式会变，所以通过js来提交表单
    function submit() {
        $("#register").submit();
    }

    //获取邮箱验证码
    function emailCode() {
        var email = $("#email").val(); //通过id获取
        $.ajax({
            type:'post',
            url:'${pageContext.request.contextPath }/user/emailCode',
            //请求是key/value这里不需要指定contentType，因为默认就 是key/value类型
            //contentType:'application/json;charset=utf-8',数据格式是字符串
            data:{"email":email},
            success:function(data){//返回json结果
                alert(data.message);
            }

        });
    }

    //获取短信验证码
    function phoneNumberCode() {
        var phoneNumber = $("#phoneNumber").val(); //通过id获取
        $.ajax({
            type:'post',
            url:'${pageContext.request.contextPath }/user/phoneNumberCode',
            data:{"phoneNumber":phoneNumber},
            success:function(data){//返回json结果
                alert(data.message);
            }

        });
    }
</script>
<c:if test="${codeMessage != null}">
    <script type="text/javascript">
        var codeMessage = "${codeMessage}";
        alert(codeMessage);
    </script>
</c:if>
<c:if test="${errors != null}">
    <c:forEach var="e" items="${errors}">
        <script type="text/javascript">
        var errors = '${e.defaultMessage}';
        alert(errors);
        </script>
    </c:forEach>
</c:if>
</body>
</html>
