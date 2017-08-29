<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Mosaddek">
    <meta name="keyword" content="FlatLab, Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
    <link rel="shortcut icon" href="img/favicon.html">

    <title>店铺管理</title>

    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/resources/merchant/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/merchant/css/bootstrap-reset.css" rel="stylesheet">
    <!--external css-->
    <link href="${pageContext.request.contextPath}/resources/merchant/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/merchant/assets/jquery-easy-pie-chart/jquery.easy-pie-chart.css" rel="stylesheet" type="text/css" media="screen"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/merchant/css/owl.carousel.css" type="text/css">
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/resources/merchant/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/merchant/css/style-responsive.css" rel="stylesheet" />

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 tooltipss and media queries -->
    <!--[if lt IE 9]>
    <script src="${pageContext.request.contextPath}/resources/merchant/js/html5shiv.js"></script>
    <script src="${pageContext.request.contextPath}/resources/merchant/js/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<section id="container" class="">
  <%@include file="navigation.jsp"%>
    <!--sidebar start-->
    <aside>
        <div id="sidebar"  class="nav-collapse ">
            <!-- sidebar menu start-->
            <ul class="sidebar-menu">
                <li class="active">
                    <a class="" href="${pageContext.request.contextPath}/merchant/merchantIndexUI">
                        <i class="icon-dashboard"></i>
                        <span>首页</span>
                    </a>
                </li>
                <li class="sub-menu">
                    <a href="javascript:;" class="">
                        <i class="icon-book"></i>
                        <span>订单管理</span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub">
                        <li><a class="" href="${pageContext.request.contextPath}/order/selectOrderByMerchantId?merchantId=${loginMerchant.merchantId}">查看订单</a></li>
                    </ul>
                </li>
                <li class="sub-menu">
                    <a href="javascript:;" class="">
                        <i class="icon-cogs"></i>
                        <span>商品管理</span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub">
                        <li><a class="" href="${pageContext.request.contextPath}/merchant/showItemsUI?merchantId=${loginMerchant.merchantId}">查看商品</a></li>
                        <li><a class="" href="${pageContext.request.contextPath}/merchant/updateItemsUI">添加商品</a></li>
                    </ul>
                </li>
                <li>
                    <a class="" href="${pageContext.request.contextPath}/user/logout">
                        <i class="icon-user"></i>
                        <span>注销</span>
                    </a>
                </li>
            </ul>
            <!-- sidebar menu end-->
        </div>
    </aside>
    <!--sidebar end-->
</section>

<!-- js placed at the end of the document so the pages load faster -->
<script src="${pageContext.request.contextPath}/resources/merchant/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/resources/merchant/js/jquery-1.8.3.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/merchant/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/merchant/js/jquery.scrollTo.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/merchant/js/jquery.nicescroll.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/merchant/js/jquery.sparkline.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/merchant/assets/jquery-easy-pie-chart/jquery.easy-pie-chart.js"></script>
<script src="${pageContext.request.contextPath}/resources/merchant/js/owl.carousel.js" ></script>
<script src="${pageContext.request.contextPath}/resources/merchant/js/jquery.customSelect.min.js" ></script>

<!--common script for all pages-->
<script src="${pageContext.request.contextPath}/resources/merchant/js/common-scripts.js"></script>

<!--script for this page-->
<script src="${pageContext.request.contextPath}/resources/merchant/js/sparkline-chart.js"></script>
<script src="${pageContext.request.contextPath}/resources/merchant/js/easy-pie-chart.js"></script>

<script>

    //owl carousel

    $(document).ready(function() {
        $("#owl-demo").owlCarousel({
            navigation : true,
            slideSpeed : 300,
            paginationSpeed : 400,
            singleItem : true

        });
    });

    //custom select box

    $(function(){
        $('select.styled').customSelect();
    });
</script>
    <c:if test="${message != null}">
    <script type="text/javascript">
    var codeMessage = "${message}";
    alert(codeMessage);
</script>
</c:if>


</body>
</html>
