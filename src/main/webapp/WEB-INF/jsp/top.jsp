<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
</head>
<body>
<div class="BHeader">
    <div class="yNavIndex">
        <ul class="BHeaderl">
            <c:if test="${loginUser == null}">
                <li><a href="${pageContext.request.contextPath}/user/loginUI" style="color:#ea4949;">请登录</a> </li>
                <li class="headerul">|</li>
                <li><a href="${pageContext.request.contextPath}/user/registerUI">免费注册</a> </li>
            </c:if>
            <c:if test="${loginUser != null}">
                <li><a href="#" style="float:left;">Hi,${loginUser.username}</a></li>
                <li class="headerul">|</li>
                <li><a href="${pageContext.request.contextPath}/user/logout" style="float:left;">退出</a> </li>
            </c:if>
            <li class="headerul">|</li>
            <li><a href="my-d.html">订单查询</a> </li>
            <li class="headerul">|</li>
            <li><a href="my-s.html">我的收藏</a> </li>
            <li class="headerul">|</li>
            <li id="pc-nav" class="menu"><a href="${pageContext.request.contextPath}/user/userSafeUI" class="tit">我的商城</a>
                <div class="subnav">
                    <a href="my-d.html">我的订单</a>
                    <a href="my-s.html">我的收藏</a>
                    <a href="${pageContext.request.contextPath}/user/userInformationUI">个人资料</a>
                    <a href="${pageContext.request.contextPath}/user/userSafeUI">账户安全</a>
                    <a href="my-add.html">地址管理</a>
                </div>
            </li>
        </ul>
    </div>
</div>
</body>
</html>
