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
    <title>我的订单</title>
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
    </div>
</div>


<!-- 商城快讯 begin -->
<section id="member">
    <div class="member-center clearfix">
        <div class="member-left fl">
            <div class="member-apart clearfix">
                <div class="fl">
                    <c:if test="${loginUser.image != null}">
                        <img src="/image/${loginUser.image}" />
                    </c:if>
                    <c:if test="${loginUser.image == null}">
                        <img src="/image/user/null.jpg"/>
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
                <div class="member-heels fl"><h2>我的订单</h2></div>
            </div>
            <div class="member-border">
                <div class="member-return H-over">
                    <div class="member-cancel clearfix">
                        <span class="be1">订单信息</span>
                        <span class="be2">订单金额</span>
                        <span class="be2">订单时间</span>
                        <span class="be2">订单详情</span>
                        <span class="be2">订单操作</span>
                    </div>
                    <div class="member-sheet clearfix">
                        <c:forEach var="order" items="${pageInfo.list}">
                            <li>
                                <div class="member-minute clearfix">
                                    <span>${order.createTime}</span>
                                    <span>订单号：<em>${order.orderNumber}</em></span>
                                    <span><a href="#">${order.merchantName}</a></span>
                                </div>
                                <div class="member-circle clearfix" >
                                    <div class="ci1">
                                        <div class="ci7 clearfix">
                                            <c:forEach var="i" items="${order.orderDetails}">
                                            <span class="gr1"><a href="#"><img src="/image/${i.imagePath}" width="60" height="60" title="" about=""></a></span>
                                            <span class="gr2"><a href="${pageContext.request.contextPath}/showItem?itemId=${i.itemId}">${i.itemName}</a></span>
                                            <span class="gr3">x${i.itemNumber}</span>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="ci3"><b>￥${order.totalPrice}</b></div>
                                    <div class="ci4"><p>${order.createTime}</p></div>
                                    <div class="ci5"><p><a href="${pageContext.request.contextPath}/order/orderDetailByUser?orderId=${order.orderId}">订单详情</a></p></div>
                                    <div class="ci5 ci8"><p><a href="${pageContext.request.contextPath}/order/userDelete?orderId=${order.orderId}" onclick="UserDelete(this)" id="delete">删除</a></p></div>
                                </div>
                            </li>
                        </ul>
                        </c:forEach>
                    </div>
                </div>
                <div class="clearfix" style="padding:30px 20px;">
                    <div class="fr pc-search-g">
                        <a href="${pageContext.request.contextPath}/order/showOrdersByUserId?userId=${loginUser.userId}&pageNum=${pageInfo.prePage}" class="fl pc-search-f">上一页</a>
                        <a class="current" href="#">${pageInfo.pageNum}</a>
                        <a href="${pageContext.request.contextPath}/order/showOrdersByUserId?userId=${loginUser.userId}&pageNum=${pageInfo.nextPage}" class="pc-search-n" >下一页</a>
                        <span class="pc-search-y">
                        <em>  共${pageInfo.pages}页    到第</em>
                        <input type="text"  class="pc-search-j" id="page">
                        <em>页</em>
                        <a class="confirm" href="#" onclick="skip()" id="confire">确定</a>
                    </span>

                    </div>
                </div>

            </div>
        </div>
    </div>
</section>
<!-- 商城快讯 End -->
<script type="text/javascript">
    function skip() {
        // 获取用户输入的页码
        var page = $("#page").val();
        var newUrl = "${pageContext.request.contextPath}/order/showOrdersByUserId?userId=${loginUser.userId}&pageNum=" + page;
        // 获取url
        var url = $("#confire").attr("href",newUrl);
    }

    function UserDelete(o) {
        var url = $(o).attr("href");
        // 阻止超链接
        $(o).attr("href", "#");
            $.ajax({
                type: 'post',
                url: url,
                success: function (data) {//返回json结果
                    if (data.success == true) {
                        alert(data.message);
                        window.location.href = "";
                    }
                    if (data.success == false) {
                        alert(data.message);
                    }
                }
            });
    }


</script>
</body>
</html>