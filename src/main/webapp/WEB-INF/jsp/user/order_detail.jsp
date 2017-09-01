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
    <title>订单详情</title>
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/theme/icon/favicon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/base.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/member.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/theme/js/jquery.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/address.css">
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
            <a href="${pageContext.request.contextPath}/order/showOrdersByUserId?userId=${loginUser.userId}">我的订单</a>
            &gt;
            <a href="${pageContext.request.contextPath}/order/orderDetailByUser?orderId=${order.orderId}">订单详情</a>
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
                    <div class="member-heels fl"><h2>订单号：${order.orderNumber}</h2></div>
                    <div class="member-backs fr"><a href="${pageContext.request.contextPath}/order/showOrdersByUserId?userId=${loginUser.userId}">返回订单首页</a></div>
                </div>
                <div class="member-border">
                    <div class="member-order">
                        <dl class="member-custom clearfix ">
                            <dt>订单信息</dt>
                            <dd>订单编号：${order.orderNumber}</dd>
                            <dd>订单金额：￥${order.totalPrice}</dd>
                            <dd>下单时间：${order.createTime}</dd>
                            <dd>备注：${order.remark}</dd>
                        </dl>
                        <dl>
                            <dt>配送信息</dt>
                            <dd class="member-seller"><span>收货地址：${order.address}</span></dd>
                        </dl>
                        <dl>
                            <dt>商品信息</dt>
                            <dd class="member-seller">本订单是由 “${order.merchantName}” 发货并且提高售后服务</dd>
                        </dl>
                    </div>
                    <div class="member-serial">
                        <ul>
                            <li class="clearfix">
                                <div class="No1">商品编号</div>
                                <div class="No2">商品详情</div>
                                <div class="No3">数量</div>
                                <div class="No4">单价</div>
                                <div class="No5">小计</div>
                            </li>
                            <c:forEach items="${order.orderDetails}" var="i">
                            <li class="clearfix">
                                <div class="No1">${i.itemId}</div>
                                <div class="No2"><a href="${pageContext.request.contextPath}/showItem?itemId=${order.item.itemId}">${i.itemName}</a> </div>
                                <div class="No3">${i.itemNumber}</div>
                                <div class="No4">￥${i.itemPrice}</div>
                                <div class="No5">￥${i.itemPrice * i.itemNumber}</div>
                            </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <div class="member-settle clearfix">
                    <div class="fr">
                        <div><span>共需支付：</span><em>￥${order.totalPrice}</em></div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>
