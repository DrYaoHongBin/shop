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
    <title>歪秀购物</title>
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/theme/icon/favicon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/base.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/home.css">
    <script src="${pageContext.request.contextPath}/resources/theme/js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/theme/js/jquery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/theme/js/index.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/theme/js/js-tab.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/theme/js/MSClass.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/theme/js/jcarousellite.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/theme/js/top.js"></script>
    <script type="text/javascript">

    </script>
</head>
<body>
<!--- header begin-->
<header id="pc-header">
    <%@include file="top.jsp"%>
    <div class="container clearfix">
        <div class="header-logo fl"><h1><a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/theme/icon/logo.png"></a> </h1></div>
        <div class="head-form fl">
            <form class="clearfix" action="${pageContext.request.contextPath}/selectItemsBySearchName" method="post" id="searchForm">
                <input type="text" class="search-text" id="search" name="search">
                <button class="button" type="submit">搜索</button>
            </form>
            <form action="${pageContext.request.contextPath}/selectItemsByCategory" method="post" id="category" target="_blank">
                <input type="hidden" id="categoryName" name="categoryName">
            </form>
            <div class="words-text clearfix">

            </div>
        </div>
        <div class="header-cart fr"><a href="#"><img src="${pageContext.request.contextPath}/resources/theme/icon/car.png"></a> <i class="head-amount">999</i></div>
        <div class="head-mountain"></div>
    </div>
    <div class="yHeader">
        <div class="yNavIndex">
            <div class="pullDown">
                <h2 class="pullDownTitle">
                    全部商品分类
                </h2>
                <ul class="pullDownList">
                    <c:forEach var="category" items="${categoryList}" varStatus="status" step="3">
                            <li class="menulihover">
                                <i class="listi1"></i>
                                <c:forEach var="category" items="${categoryList}"  begin="${status.index}" end="${status.index + 2}">
                                    &nbsp;&nbsp;<a href="#" onclick="select(this)">${category.name}</a>&nbsp;&nbsp;&nbsp;&nbsp;
                                </c:forEach>
                                <span></span>
                            </li>
                    </c:forEach>
                </ul>
                <div class="yMenuListCon">
                    <c:forEach var="category" items="${categoryList}" varStatus="status" step="3">
                    <div class="yMenuListConin">
                        <div class="yMenuLCinLisi fl">
                            <ul>
                                <c:forEach var="category" items="${categoryList}"  begin="${status.index}" end="${status.index + 2}">
                                    <li><a href="#" onclick="select(this)">${category.name}<i class="fr">></i></a></li>
                                </c:forEach>
                            </ul>
                        </div>
                        <div class="yMenuLCinList fl">
                        <c:forEach var="categoryTwo" items="${categoryList}" begin="${status.index}" end="${status.index + 2}">
                            <c:if test="${categoryTwo.categoryTwoList != null}">
                                <p></p>
                            </c:if>
                                <p>
                                <c:forEach var="c" items="${categoryTwo.categoryTwoList}">
                                    <a href="#" class="ecolor610" onclick="select(this)">${c.name}</a>
                                </c:forEach>
                                </p>
                         </c:forEach>
                        </div>
                    </div>
                    </c:forEach>
                </div>
            </div>
            <ul class="yMenuIndex">
                <li><a href="#" >服装城</a></li>
                <li><a href="#">美妆馆</a></li>
                <li><a href="#" >美食</a></li>
                <li><a href="#">全球购</a></li>
                <li><a href="#" >闪购</a></li>
                <li><a href="#">团购</a></li>
                <li><a href="#" >拍卖</a></li>
                <li><a href="#">金融</a></li>
                <li><a href="#" >智能</a></li>
            </ul>
        </div>
    </div>
</header>
<!-- header End -->

<!--- banner begin-->
<section id="pc-banner">
    <div class="yBanner">
        <div class="banner" id="banner" >
            <a href="javascript:;" class="d1" style="background:url(${pageContext.request.contextPath}/resources/theme/img/ad/banner1.jpg) center no-repeat;background-color: #f01a38; padding-left:180px;"></a>
            <a href="javascript:;" class="d1" style="background:url(${pageContext.request.contextPath}/resources/theme/img/ad/banner2.jpg) center no-repeat;background-color: #a96ae3; padding-left:180px;"></a>
            <a href="javascript:;" class="d1" style="background:url(${pageContext.request.contextPath}/resources/theme/img/ad/banner3.jpg) center no-repeat;background-color: #081f3c; padding-left:180px;"></a>
            <a href="javascript:;" class="d1" style="background:url(${pageContext.request.contextPath}/resources/theme/img/ad/banner4.jpg) center no-repeat;background-color: #4684ff; padding-left:180px;"></a>
            <a href="javascript:;" class="d1" style="background:url(${pageContext.request.contextPath}/resources/theme/img/ad/banner5.jpg) center no-repeat;background-color: #a89d9f; padding-left:180px;"></a>
            <div class="d2" id="banner_id">
                <ul>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                </ul>
            </div>
        </div>
        <div style="text-align:center;clear:both"></div>
    </div>
</section>
<!-- banner End -->
<!--- advert begin-->
<section id="pc-advert">
    <div class="container-c clearfix">
        <a href="#" ><img src="${pageContext.request.contextPath}/resources/theme/img/pd/pd1.png"></a>
        <a href="#"><img src="${pageContext.request.contextPath}/resources/theme/img/pd/pd2.png"></a>
        <a href="#"><img src="${pageContext.request.contextPath}/resources/theme/img/pd/pd3.png"></a>
        <a href="#"><img src="${pageContext.request.contextPath}/resources/theme/img/pd/pd4.png"></a>
    </div>
</section>
<!-- advert End -->
<!-- 商城资讯 begin -->
<section id="pc-information">
    <div class="containers">
        <div class="pc-info-mess  clearfix" style="position: relative;">
            <div id="MarqueeDiv" class="MarqueeDiv">
            </div>
        </div>
    </div>
</section>
<!-- 商城资讯 End -->
<script type="text/javascript">banner()</script>
</body>
<!--表单验证插件-->
<script src="${pageContext.request.contextPath}/resources/theme/util/jquery.validate.js" type="text/javascript"></script>
<!--导入自定义的验证规则-->
<script src="${pageContext.request.contextPath}/resources/theme/util/validate-methods.js" type="text/javascript"></script>
<script type="text/javascript">

    // 验证搜索框
    $("#searchForm").validate({
        rules: {
            search: {
                required: true,
                isContainBlank: true,
                maxlength: 35,
            },
        },
        messages: {
            search: {
                required: "搜索内容不可为空",
                isContainBlank: "搜索内容不可包含空格",
                maxlength: "搜索内容最多35位",
            },
        },
        submitHandler: function(form) {  //验证通过之后回调
            form.submit();
        },
        invalidHandler: function(form, validator) {  //验证不通过之后回调
            return false;
        }
    })

    function select(o) {
        // 获取要查询的类目
        var condition = o.text;
        // 如果获取的a标签文本含有>，则去除
        condition = condition.replace(">","");
        // 将值设置到category表单的隐藏域
        $("#categoryName").val(condition);
        // 提交表单
        $("#category").submit();
        return false;
    }
</script>
</html>
