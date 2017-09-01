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
    <meta content="歪秀购物, 购物, 大家电, 手机" name="keywords">
    <meta content="歪秀购物，购物商城。" name="description">
    <title>帐户安全</title>
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/theme/icon/favicon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/base.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/member.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/address.css">
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
            <a href="${pageContext.request.contextPath}/user/userSafeUI">帐户安全</a>
        </div>
    </div>

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
                    <div class="member-heels fl"><h2>账户安全</h2></div>
                </div>
                <div class="member-border">
                    <div class="member-caution clearfix">
                        <ul>
                            <li class="clearfix">
                                <div class="warn1"></div>
                                <div class="warn2">登录密码</div>
                                <div class="warn3">互联网账号存在被盗风险，建议您定期更改密码以保护账户安全。</div>
                                <div class="warn4"><a href="${pageContext.request.contextPath}/user/resetPasswordUI">修改</a> </div>
                            </li>
                            <c:if test="${loginUser.phoneNumber != null}">
                                <li class="clearfix">
                                    <div class="warn1"></div>
                                    <div class="warn2">手机验证</div>
                                    <div class="warn3">您验证的手机： <i class="reds">${loginUser.phoneNumber}</i>   若已丢失或停用，请立即更换，<i class="reds">避免账户被盗</i></div>
                                    <div class="warn4"><a href="${pageContext.request.contextPath}/user/resetPhoneNumberUI">修改</a> </div>
                                </li>
                            </c:if>
                            <c:if test="${loginUser.email != null}">
                                <li class="clearfix">
                                    <div class="warn1"></div>
                                    <div class="warn2">邮箱验证</div>
                                    <div class="warn3">您验证的邮箱： <i class="reds">${loginUser.email}</i>   若已丢失或停用，请立即更换，<i class="reds">避免账户被盗</i></div>
                                    <div class="warn4"><a href="${pageContext.request.contextPath}/user/resetEmailUI">修改</a> </div>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
<!-- 弹窗插件 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/dialog/css/animate.min.css"/> <!-- 动画效果 -->
<script src="${pageContext.request.contextPath}/resources/dialog/js/jquery.hDialog.min.js"></script>
<c:if test="${message != null}">
    <script type="text/javascript">
        var message = "${message}";
        $.tooltip(message, 4500, true);
    </script>
</c:if>
</html>
