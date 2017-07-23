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
    <title>找回密码</title>
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
                <form action="${pageContext.request.contextPath}/user/resetPassword" method="post" id="forgetPassword">
                    <div class="login-input" id="phoneRegister">
                        <label><i class="heart">*</i>手机号：</label>
                        <input type="text" class="list-iphone" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}" placeholder="请输入您注册的手机号">
                        <a href="#" class="obtain" onclick="phoneNumberCode()">获取短信验证码</a>
                    </div>
                    <div class="login-input" id="emailRegister" style="display: none">
                        <label><i class="heart">*</i>邮箱：</label>
                        <input type="text" class="list-iphone" id="email" name="email" value="${user.email}" placeholder="请输入您注册的邮箱">
                        <a href="#" class="obtain" onclick="emailCode()">获取邮箱验证码</a>
                    </div>
                    <div class="login-input" id="code">
                        <label><i class="heart">*</i>验证码：</label>
                        <input type="text" class="list-notes" id="validationCode" name="validationCode" >
                    </div>
                    <div class="item-ifo" id="p1" >
                        <label for="protocol"><a id="protocol" class="blue" href="#" onclick="emailRegister()">没有手机号？改用邮箱找回</a></label>
                        <span class="clr"></span>
                    </div>
                    <div class="item-ifo" id="p2" style="display: none">
                        <label for="protocol2"><a id="protocol2" class="blue" href="#" onclick="phoneRegister()">没有邮箱？改用手机号找回</a></label>
                        <span class="clr"></span>
                    </div>
                    <div style="display: none" id="newPassword">
                        <div class="login-input">
                            <label><i class="heart">*</i>请设置新密码：</label>
                            <input type="password" class="list-input" id="password" name="password" value="${user.password}">
                        </div>
                        <div class="login-input">
                            <label><i class="heart">*</i>请确认新密码：</label>
                            <input type="password" class="list-input" id="passwordConfirm" name="passwordConfirm" value="${user.password}">
                        </div>
                    </div>
                    <div class="login-button">
                        <a href="#" onclick="checkCode()" id="1">重置密码</a>
                        <a href="#" onclick="submit()" id="2" style="display:none;">重置密码</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>
<!--表单验证插件-->
<script src="${pageContext.request.contextPath}/resources/theme/util/jquery.validate.js" type="text/javascript"></script>
<!--导入自定义的验证规则-->
<script src="${pageContext.request.contextPath}/resources/theme/util/validate-methods.js" type="text/javascript"></script>
<script type="text/javascript">

    function emailRegister() {
        $("#phoneNumber").val(""); //清除文本框内容
        $("#phoneRegister").hide();
        $("#emailRegister").show();
        $("#p1").hide();
        $("#p2").show();
    }
    function phoneRegister() {
        $("#email").val("")
        $("#emailRegister").hide();
        $("#phoneRegister").show();
        $("#p1").show();
        $("#p2").hide();
    }

    //验证码通过后将其他标签都隐藏掉
    function codeSuccess() {
        $("#phoneRegister").hide();
        $("#emailRegister").hide();
        $("#p1").hide();
        $("#p2").hide();
        $("#code").hide();
        $("#1").hide();
        $("#2").show();
    }

    function submit() {
        $("#forgetPassword").submit();
    }

    $(document).ready(function () {
        $("#forgetPassword").validate({
            rules: {
                phoneNumber: {
                    required: true,
                    isPhoneNumber: true,
                    number: true,
                    maxlength: 11,
                    minlength: 11,
                },
                validationCode: {
                    required: true,
                    number: true,
                    maxlength: 6,
                    minlength: 6,
                },
                email: {
                    required: true,
                    email: true
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
            },
            messages: {
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
                password: {
                    required: "密码不可为空",
                    isContainBlank: "密码不可包含空格",
                    maxlength: "密码不可超过20位",
                    minlength: "密码不可少于5位"
                },
                passwordConfirm: {
                    equalTo: "两次密码输入不一致"
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

    //获取邮箱验证码
    function emailCode() {
        var email = $("#email").val(); //通过id获取
        $.ajax({
            type:'post',
            url:'${pageContext.request.contextPath }/user/emailCode',
            data:{"email":email, "identify":0},
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
            data:{"phoneNumber":phoneNumber, "identify":0},
            success:function(data){//返回json结果
                alert(data.message);
            }

        });
    }

    //验证验证码
    function checkCode() {
        var validationCode = $("#validationCode").val(); //通过id获取
        var email = $("#email").val();
        var phoneNumber = $("#phoneNumber").val();
        $.ajax({
            type:'post',
            url:'${pageContext.request.contextPath }/user/checkCode',
            data:{"validationCode":validationCode, "email":email, "phoneNumber":phoneNumber},
            success:function(data){//返回json结果
                if (data.success == false) {
                    alert(data.message);
                } else {
                    alert(data.message);
                    codeSuccess();
                    $("#newPassword").css({"display":"block"})
                }
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
</body>
</html>
