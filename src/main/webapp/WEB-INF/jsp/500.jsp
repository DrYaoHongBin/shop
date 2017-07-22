<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>500</title>
    <%@include file="error.jsp"%>
</head>
<body>
<div class="bg">
    <div class="cont">
        <div class="c1"><img src="${pageContext.request.contextPath}/resources/404/01.png" class="img1" /></div>
        <h2>哎呀…您访问的页面不存在</h2>
        <div class="c2"><a href="#" class="re" onclick="returnPage()">返回</a><a href="${pageContext.request.contextPath}/" class="home">返回首页</a></div>
    </div>
</div>
</body>
<script type="text/javascript">
    function returnPage() {
        window.history.go(-1);
    }
</script>
</html>