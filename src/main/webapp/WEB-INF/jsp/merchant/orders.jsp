<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Mosaddek">
    <meta name="keyword" content="FlatLab, Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/merchant/img/favicon.html">
    <title>查看订单</title>
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
                            订单目录
                        </header>
                        <table class="table table-striped table-advance table-hover" id="itemTable">
                            <thead>
                            <tr>
                                <th>订单号</th>
                                <th>用户</th>
                                <th>商品|单价|数量 </th>
                                <th>下单时间</th>
                                <th>总价</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <div class="row">
                                <c:forEach var="order" items="${pageInfo.list}">
                                    <tr>
                                        <td>${order.orderNumber}</td>
                                        <td>${order.username}</td>
                                        <td>
                                            <c:forEach var="i" items="${order.orderDetails}">
                                                <a href="${pageContext.request.contextPath}/showItem?itemId=${i.itemId}">${i.itemName}</a> ${i.itemPrice} x${i.itemNumber}
                                            </c:forEach>
                                        </td>
                                        <td>${order.createTime}</td>
                                        <td>${order.totalPrice}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/order/orderDetailByMerchant?orderId=${order.orderId}" class="btn btn-primary btn-xs">查看</a>
                                            <input type="hidden" id="delete" value="${order.orderId}">
                                            <a href="#" class="btn btn-danger btn-xs" onclick="deleteItem(this)">删除</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </div>
                            </tbody>
                        </table>
                        <div class="text-right">
                            <ul class="pagination">
                                <li><a href="${pageContext.request.contextPath}/order/selectOrderByMerchantId?merchantId=${loginMerchant.merchantId}&pageNum=${pageInfo.prePage}" >«</a></li>
                                <li><a href="#" >${pageInfo.pageNum}</a></li>
                                <li><a href="${pageContext.request.contextPath}/order/selectOrderByMerchantId?merchantId=${loginMerchant.merchantId}&pageNum=${pageInfo.nextPage}" >»</a></li>

                                &nbsp;
                                共<a>${pageInfo.pages}</a>页&nbsp;到第 &nbsp;<input type="text" size="5" id="page">  &nbsp;页
                                &nbsp;
                                <a class="confirm" href="#" onclick="skip()" id="confire">确定</a>
                                &nbsp;
                            </ul>
                        </div>
                    </section>



                </div>
            </div>
            <!-- page end-->
        </section>
    </section>
</section>

<!-- js placed at the end of the document so the pages load faster -->
<script src="${pageContext.request.contextPath}/resources/merchant/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/resources/merchant/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/merchant/js/jquery.scrollTo.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/merchant/js/jquery.nicescroll.js" type="text/javascript"></script>
<!--common script for all pages-->
<script src="${pageContext.request.contextPath}/resources/merchant/js/common-scripts.js"></script>
<!--表单验证插件-->
<script src="${pageContext.request.contextPath}/resources/theme/util/jquery.validate.js" type="text/javascript"></script>
<!--导入自定义的验证规则-->
<script src="${pageContext.request.contextPath}/resources/theme/util/validate-methods.js" type="text/javascript"></script>
<script type="text/javascript">

    function deleteItem(object) {
        if (confirm("确定要删除吗？")) {
            // 获取td标签的隐藏域标签
            var a = $(object).parent().find('input')[0];
            // 获取隐藏域的value
            var orderId = a.value;
            $.ajax({
                type:'post',
                url:'${pageContext.request.contextPath }/order/merchantDelete',
                data:{"orderId":orderId},
                success:function(data) {//返回json结果
                    if (data.success == false) {
                        alert(data.message);
                    } else {
                        alert(data.message);
                        // 清除已删除的商品的tr标签
                        $(object).parent().parent().remove();
                    }
                }
            });
        }
    }
    //跳转到指定页面
    function skip() {
        // 获取用户输入的页码
        var page = $("#page").val();
        var newUrl = "${pageContext.request.contextPath}/order/selectOrderByMerchantId?merchantId=${loginMerchant.merchantId}&pageNum=" + page;
        // 获取url
        var url = $("#confire").attr("href",newUrl);
    }


</script>

</body>
</html>

