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
    <title>修改手机号码</title>
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
<section id="login-content">
    <div class="login-centre">
        <div class="login-back">
            <div class="H-over">
                <form action="${pageContext.request.contextPath}/user/updateUser" method="post" id="resetPhoneNumber">
                    <div class="login-input" id="emailRegister" style="display: none">
                        <label><i class="heart">*</i>新手机号码：</label>
                        <input type="text" class="list-iphone" id="phoneNumber" name="phoneNumber">
                        <a href="#" class="obtain" onclick="phoneNumberCode()">获取短信验证码</a>
                    </div>
                    <div class="login-input" id="confire">
                        <label><i class="heart">*</i>验证码：</label>
                        <input type="password" class="list-input" id="validationCode" name="validationCode" placeholder="请输入收到的短信验证码">
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
        $("#resetPhoneNumber").validate({
            rules: {
                validationCode: {
                    required: true,
                    isContainBlank:true,
                    maxlength:10,
                },
                phoneNumber: {
                    required: true,
                    isPhoneNumber: true,
                    number: true,
                    maxlength: 11,
                    minlength: 11,
                },
            },
            messages: {
                validationCode: {
                    required: "验证码不可为空",
                    isContainBlank:"验证码不可包含空格",
                    maxlength:"请输入正确的验证码",
                },
                phoneNumber: {
                    required: "手机号不可为空",
                    number: "请填写正确的手机号",
                    maxlength: "请填写正确的手机号",
                    minlength: "请填写正确的手机号",
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

    //验证验证码
    function checkCode() {
        var validationCode = $("#validationCode").val(); //通过id获取
        var phoneNumber = '${loginUser.phoneNumber}';
        $.ajax({
            type:'post',
            url:'${pageContext.request.contextPath }/user/checkCode',
            data:{"validationCode":validationCode, "phoneNumber":phoneNumber},
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
        var phoneNumber = $("#phoneNumber").val()
        $.ajax({
            type:'post',
            url:'${pageContext.request.contextPath }/user/checkCode',
            data:{"validationCode":validationCode, "phoneNumber":phoneNumber},
            success:function(data){//返回json结果
                if (data.success == false) {
                    alert(data.message);
                } else {
                    $("#resetPhoneNumber").submit();
                }
            }
        });
    }

    //获取验证码
    function sendCode() {
        $.ajax({
            type:'post',
            url:'${pageContext.request.contextPath }/user/resetPhoneNumber',
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


