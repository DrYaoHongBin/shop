<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Mosaddek">
    <meta name="keyword" content="FlatLab, Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

    <title>订单详情</title>

    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/resources/merchant/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/merchant/css/bootstrap-reset.css" rel="stylesheet">
    <!--external css-->
    <link href="${pageContext.request.contextPath}/resources/merchant/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
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
                <li >
                    <a class="" href="${pageContext.request.contextPath}/merchant/merchantIndexUI">
                        <i class="icon-dashboard"></i>
                        <span>首页</span>
                    </a>
                </li>
                <li class="sub-menu active">
                    <a href="javascript:;" class="">
                        <i class="icon-book"></i>
                        <span>订单管理</span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub">
                        <li class="active"><a  href="${pageContext.request.contextPath}/order/selectOrderByMerchantId?merchantId=${loginMerchant.merchantId}">查看订单</a></li>
                    </ul>
                </li>
                <li class="sub-menu ">
                    <a href="javascript:;" class="">
                        <i class="icon-cogs"></i>
                        <span>商品管理</span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub">
                        <li class=""><a class="" href="${pageContext.request.contextPath}/merchant/showItemsUI?merchantId=${loginMerchant.merchantId}">查看商品</a></li>
                        <li class=""><a class="" href="${pageContext.request.contextPath}/merchant/updateItemsUI">添加商品</a></li>
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
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper">
            <!-- page start-->
            <div class="row">
                <div class="col-lg-12">
                    <section class="panel">
                        <header class="panel-heading">
                           订单详情
                        </header>
                        <div class="panel-body">
                            <form class="form-horizontal" id="default">
                                <fieldset title="Step 3" class="step" id="default-step-2" >
                                    <legend> </legend>
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">订单编号</label>
                                        <div class="col-lg-10">
                                            <p class="form-control-static">${order.orderNumber}</p>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">下单时间</label>
                                        <div class="col-lg-10">
                                            <p class="form-control-static">${order.createTime}</p>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">收货地址</label>
                                        <div class="col-lg-10">
                                            <p class="form-control-static">${order.address}</p>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">商品信息</label>
                                        <div class="col-lg-10">
                                            <c:forEach items="${order.orderDetails}" var="i">
                                                <p class="form-control-static">${i.itemName}
                                                ,单价：${i.itemPrice},数量：${i.itemNumber},小计：${i.itemPrice * i.itemNumber}</p>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">备注</label>
                                        <div class="col-lg-10">
                                            <p class="form-control-static">${order.remark}</p>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">合计</label>
                                        <div class="col-lg-10">
                                            <p class="form-control-static">${order.totalPrice}</p>
                                        </div>
                                    </div>
                                </fieldset>
                            </form>
                        </div>
                    </section>
                </div>
            </div>
            <!-- page end-->
        </section>
    </section>
    <!--main content end-->
</section>

<!-- js placed at the end of the document so the pages load faster -->
<script src="${pageContext.request.contextPath}/resources/merchant/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/resources/merchant/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/merchant/js/jquery.scrollTo.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/merchant/js/jquery.nicescroll.js" type="text/javascript"></script>
<!--common script for all pages-->
<script src="${pageContext.request.contextPath}/resources/merchant/js/common-scripts.js"></script>
<!--script for this page-->
<script src="${pageContext.request.contextPath}/resources/merchant/js/jquery.stepy.js"></script>
</body>
</html>

