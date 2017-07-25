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
    <title>修改邮箱</title>
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
        <div><h1><a href="${pageContext.request.contextPath}/user/updateUser"><img src="${pageContext.request.contextPath}/resources/theme/icon/logo.png"></a></h1></div>
    </div>
</header>
<!-- header End -->
<div class="containers">
    <div class="pc-nav-item"><a href="${pageContext.request.contextPath}/">首页</a>
        &gt;
        <a href="${pageContext.request.contextPath}/user/userSafeUI">我的商城</a>
        &gt;
        <a href="${pageContext.request.contextPath}/user/userSafeUI">帐户安全</a>
        &gt;
        <a href="${pageContext.request.contextPath}/user/resetEmailUI">修改邮箱</a>
    </div>
</div>
<section id="login-content">
    <div class="login-centre">
        <div class="login-back">
            <div class="H-over">
                <form action="${pageContext.request.contextPath}/user/updateUser" method="post" id="resetEmail">
                    <div class="login-input" id="emailRegister" style="display: none">
                        <label><i class="heart">*</i>新邮箱：</label>
                        <input type="text" class="list-iphone" id="email" name="email">
                        <a href="#" class="obtain" onclick="emailCode()">获取邮箱验证码</a>
                    </div>
                    <div class="login-input" id="confire">
                        <label><i class="heart">*</i>验证码：</label>
                        <input type="password" class="list-input" id="validationCode" name="validationCode" placeholder="请输入邮箱收到的验证码">
                    </div>
                    <div class="login-button">
                        <a href="#" onclick="checkCode()" id="1" style="display:none;">确认</a>
                        <a href="#" onclick="checkCode2()" id="2" style="display:none;">确认修改</a>
                        <a href="#" onclick="sendCode()" id="3" >获取验证码</a>
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
    $(document).ready(function () {
        $("#resetEmail").validate({
            rules: {
                validationCode: {
                    required: true,
                    isContainBlank:true,
                    maxlength:10,
                },
                email: {
                    required: true,
                    email: true
                },
            },
            messages: {
                validationCode: {
                    required: "验证码不可为空",
                    isContainBlank:"验证码不可包含空格",
                    maxlength:"请输入正确的验证码",
                },
                email: {
                    required: "邮箱不可为空",
                    email: "请填写正确的邮箱"
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
            data:{"email":email},
            success:function(data){//返回json结果
                alert(data.message);
            }

        });
    }

    //验证验证码
    function checkCode() {
        var validationCode = $("#validationCode").val(); //通过id获取
        var email = '${loginUser.email}';
        $.ajax({
            type:'post',
            url:'${pageContext.request.contextPath }/user/checkCode',
            data:{"validationCode":validationCode, "email":email},
            success:function(data){//返回json结果
                if (data.success == false) {
                    alert(data.message);
                } else {
                        $("#emailRegister").show();
                        $("#1").hide();
                        $("#2").show();
                        $("#validationCode").val("");
                  }
            }
        });
    }

    //验证验证码
    function checkCode2() {
        var validationCode = $("#validationCode").val(); //通过id获取
        var email = $("#email").val()
        $.ajax({
            type:'post',
            url:'${pageContext.request.contextPath }/user/checkCode',
            data:{"validationCode":validationCode, "email":email},
            success:function(data){//返回json结果
                if (data.success == false) {
                    alert(data.message);
                } else {
                    $("#resetEmail").submit();
                }
            }
        });
    }

    //获取验证码
    function sendCode() {
        $.ajax({
            type:'post',
            url:'${pageContext.request.contextPath }/user/resetEmail',
            success:function(data){//返回json结果
                $("#3").hide();
                $("#1").show();
                alert(data.message);
            }
        });
    }


</script>
<c:if test="${message != null}">
    <script type="text/javascript">
        var message = "${message}";
        alert(message);
    </script>
</c:if>
</body>
</html>


