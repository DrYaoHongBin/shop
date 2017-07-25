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
    <title>修改密码</title>
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/theme/icon/favicon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/base.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/login.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/home.css">
    <script src="${pageContext.request.contextPath}/resources/theme/js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript">
        (function(a){
            a.fn.hoverClass=function(b){
                var a=this;
                a.each(function(c){
                    a.eq(c).hover(function(){
                        $(this).addClass(b)
                    },function(){
                        $(this).removeClass(b)
                    })
                });
                return a
            };
        })(jQuery);

        $(function(){
            $("#pc-nav").hoverClass("current");
        });
    </script>
</head>
<body>
<!--- header begin-->
<header id="pc-header">
    <%@include file="../top.jsp"%>
    <div class="login-header" style="padding-bottom:0">
        <div><h1><a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/theme/icon/logo.png"></a></h1></div>
    </div>
</header>
<div class="containers">
    <div class="pc-nav-item"><a href="${pageContext.request.contextPath}/">首页</a>
        &gt;
        <a href="${pageContext.request.contextPath}/user/userSafeUI">我的商城</a>
        &gt;
        <a href="${pageContext.request.contextPath}/user/userSafeUI">帐户安全</a>
        &gt;
        <a href="${pageContext.request.contextPath}/user/resetPasswordUI">修改密码</a>
    </div>
</div>
<!-- header End -->
<section id="login-content">
    <div class="login-centre">
        <div class="login-back">
            <div class="H-over">
                <form action="${pageContext.request.contextPath}/user/resetPassword" method="post" id="resetPassword">
                    <div class="login-input" id="confire">
                        <label><i class="heart">*</i>登录密码：</label>
                        <input type="password" class="list-input" id="password2" name="password2" placeholder="请输入登录帐号的密码">
                    </div>
                    <div class="item-ifo" id="p1" >
                        <label for="protocol"><a id="protocol" class="blue" href="${pageContext.request.contextPath}/user/forgetPasswordUI">忘记密码？</a></label>
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
                        <a href="#" onclick="checkPassword()" id="1">重置密码</a>
                        <a href="#" onclick="submit()" id="2" style="display:none;">确认</a>
                    </div>
                    <input type="hidden" name="userId" value="${loginUser.userId}">
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

    function submit() {
        $("#resetPassword").submit();
    }

    $(document).ready(function () {
        $("#resetPassword").validate({
            rules: {
                password2: {
                    required: true,
                    isContainBlank: true,
                    maxlength: 20,
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
                password2: {
                    required: "密码不可为空",
                    isContainBlank: "密码不可包含空格",
                    maxlength: "密码不可超过20位",
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

    function checkPassword() {
        var password = $("#password2").val(); //通过id获取
        $.ajax({
            type:'post',
            url:'${pageContext.request.contextPath }/user/checkPassword',
            data:{"password":password},
            success:function(data){//返回json结果
                if (data.success == true) {
                    $("#confire").hide();
                    $("#p1").hide();
                    $("#newPassword").show();
                    $("#1").hide();
                    $("#2").show();
                } else {
                    alert(data.message);
                }
            }

        });
    }
</script>
</body>
</html>

