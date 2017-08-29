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
    <title>地址更新</title>
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/theme/icon/favicon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/base.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/member.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/address.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/theme/js/jquery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/theme/js/pcasunzip.js"></script>
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
    <div class="container clearfix">
        <div class="header-logo fl"><h1><a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/theme/icon/logo.png"></a> </h1></div>
        <div class="member-title fl"><h2></h2></div>
        <div class="head-form fl">
            <form class="clearfix" action="${pageContext.request.contextPath}/selectItemsBySearchName" method="post" id="searchForm">
                <input type="text" class="search-text" id="search" name="search">
                <button class="button" type="submit">搜索</button>
            </form>
        </div>
        <div class="header-cart fr"><a href="#"><img src="${pageContext.request.contextPath}/resources/theme/icon/car.png"></a> <i class="head-amount">99</i></div>
    </div>
</header>
<!-- header End -->

<div class="containers">
    <div class="pc-nav-item">
        <a href="${pageContext.request.contextPath}/">首页</a>
        &gt;
        <a href="${pageContext.request.contextPath}/user/userSafeUI">我的商城</a>
        &gt;
        <a href="${pageContext.request.contextPath}/address/showAddressUI">地址管理</a>
    </div>
</div>


<!-- 商城快讯 begin -->
<section id="member">
    <div class="member-center clearfix">
        <div class="member-left fl">
            <div class="member-apart clearfix">
                <div class="fl">
                    <c:if test="${loginUser.image != null}">
                        <img src="${path.IMAGE_PATH}/${path.FILE_PATH_USER}/${loginUser.image}" />
                    </c:if>
                    <c:if test="${loginUser.image == null}">
                        <img src="${path.IMAGE_PATH}/${path.FILE_PATH_USER}/null.jpg"/>
                    </c:if>
                </div>
                <div class="fl">
                    <p>用户名：</p>
                    <p>${loginUser.username}</p>
                </div>
            </div>
            <div class="member-lists">
                <dl>
                    <dt>我的商城</dt>
                    <dd><a href="${pageContext.request.contextPath}/order/showOrdersByUserId?userId=${loginUser.userId}">我的订单</a></dd>
                    <dd><a href="#">我的收藏</a></dd>
                    <dd><a href="${pageContext.request.contextPath}/user/userInformationUI">个人资料</a></dd>
                    <dd><a href="${pageContext.request.contextPath}/user/userSafeUI">账户安全</a></dd>
                    <dd><a href="${pageContext.request.contextPath}/address/showAddressUI?userId=${loginUser.userId}">地址管理</a></dd>
                </dl>
            </div>
        </div>
        <div class="member-right fr">
            <div class="member-head">
                <div class="member-heels fl"><h2>地址管理</h2></div>
            </div>
            <div class="member-border">

                <div class="H-over">
                    <c:if test="${address.addressId == null}">
                        <form action="${pageContext.request.contextPath}/address/saveAddress" method="post" id="address">
                    </c:if>
                    <c:if test="${address.addressId != null}">
                        <form action="${pageContext.request.contextPath}/address/updateAddress" method="post" id="address">
                    </c:if>
                    <div class="login-input">
                        <label><i class="heart">*</i>收货人姓名</label>
                        <input type="text" class="list-input" id="username" name="username" value="${address.username}">
                    </div>
                    <div class="login-input">
                        <label><i class="heart">*</i>联系方式：</label>
                        <input type="text" class="list-input" id="phone" name="phone" placeholder="固定电话需要加上区号" value="${address.phone}">
                    </div>
                    <div class="login-input">
                        <label><i class="heart">*</i>邮政编码：</label>
                        <input type="text" class="list-notes" id="zipCode" name="zipCode" placeholder="如您不清楚邮政编码，请填写000000" value="${address.zipCode}" >
                    </div>
                    <div class="login-input">
                        <div class="center">
                            <select name="province" id="province" class="list-select" required></select>
                            <select name="city" id="city" class="list-select" required></select>
                            <select name="area" id="area" class="list-select" required></select><br>
                        </div>
                    </div>
                    <div class="login-input">
                        <label><i class="heart">*</i>详细地址：</label>
                        <textarea  id="fullAddress" name="fullAddress" rows="5" cols="51" class="boxes" >${address.fullAddress}</textarea>
                    </div>
                    <div class="login-button">
                        <a href="#" onclick="submit()">保存</a>
                    </div>
                    <input type="hidden" name="userId" value="${loginUser.userId}">
                    <input type="hidden" name="addressId" value="${address.addressId}">
                </form>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- (三级联动)传默认地址 -->
    <c:if test="${address.province != null}">
    <script language="javascript" defer>
        new PCAS("province","city","area","${address.province}","${address.city}","${address.area}");
    </script>
    </c:if>
    <c:if test="${address.province == null}">
    <script language="javascript" defer>
        new PCAS("province","city","area"," "," "," ");
    </script>
    </c:if>

<!--表单验证插件-->
<script src="${pageContext.request.contextPath}/resources/theme/util/jquery.validate.js" type="text/javascript"></script>
<!--导入自定义的验证规则-->
<script src="${pageContext.request.contextPath}/resources/theme/util/validate-methods.js" type="text/javascript"></script>
<script type="text/javascript">

    //注册按钮修改为input样式会变，所以通过js来提交表单
    function submit() {
        $("#address").submit();
    }

    $(document).ready(function () {
        $("#address").validate({
            rules: {
                username: {
                    required: true,
                    maxlength: 20,
                },
                phone: {
                    required: true,
                    number: true,
                    isPhone: true,
                },
                zipCode: {
                    required: true,
                    isZipCode: true,
                },
                area: {
                    isArea: true,
                },
                fullAddress: {
                    required: true,
                    minlength: 5,
                }
            },
            messages: {
                username: {
                    required: "收货人姓名不可为空",
                    maxlength: "不可超过20位",
                },
                province: {
                    required: "请选择省份",
                },
                city: {
                    required: "请选择城市",
                },
                area: {
                    required: "请选择地区",
                },
                phone: {
                    required: "联系方式不可为空",
                    number: "请填写正确的联系方式",
                },
                zipCode: {
                    required: "邮政编码不可为空",
                },
                fullAddress: {
                    required: "请填写详细地址",
                    minlength: "详细地址不可过短",
                }
            },
            submitHandler: function(form) {  //验证通过之后回调
                form.submit(); //提交表单，如果不写，即便通过表单也不会自动提交
            },
            invalidHandler: function(form, validator) {  //验证不通过之后回调
                return false;
            }
        })
    })
</script>
</body>
</html>