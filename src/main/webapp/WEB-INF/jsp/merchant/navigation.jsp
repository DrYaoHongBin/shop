<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
</head>
<body>
    <!--header start-->
    <header class="header white-bg">
        <div class="sidebar-toggle-box">
            <div data-original-title="Toggle Navigation" data-placement="right" class="icon-reorder tooltips"></div>
        </div>
        <!--logo start-->
        <a href="#" class="logo">店铺管理</a>
        <!--logo end-->
        <div class="top-nav ">
            <!--search & user info start-->
            <ul class="nav pull-right top-menu">
                <li>
                    <input type="text" class="form-control search" placeholder="Search">
                </li>
                <!-- user login dropdown start-->
                <li class="dropdown">
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                        <c:if test="${loginUser.image != null}">
                            <img src="${path.IMAGE_PATH}/${path.FILE_PATH_USER}/${loginUser.image}" width="29" height="29" />
                        </c:if>
                        <c:if test="${loginUser.image == null}">
                            <img src="${path.IMAGE_PATH}/${path.FILE_PATH_USER}/null.jpg" width="29" height="29"/>
                        </c:if>
                        <span class="username">${loginMerchant.merchantName}</span>
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu extended logout">
                        <div class="log-arrow-up"></div>
                        <li><a href="#"><i class=" "></i></a></li>
                        <li><a href="${pageContext.request.contextPath}/user/userSafeUI"><i class=" icon-user"></i>我的商城</a></li>
                        <li><a href="#"><i class=""></i></a></li>
                        <li><a href="${pageContext.request.contextPath}/user/logout"><i class="icon-key"></i>退出登录</a></li>
                    </ul>
                </li>
                <!-- user login dropdown end -->
            </ul>
            <!--search & user info end-->
        </div>
    </header>
</body>
</html>

