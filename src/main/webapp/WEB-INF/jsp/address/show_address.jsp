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
    <title>会员系统地址管理</title>
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
        <a href="${pageContext.request.contextPath}/address/showAddressUI?userId=${loginUser.userId}">地址管理</a>
    </div>
</div>


<!-- 商城快讯 begin -->
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
                <div class="member-heels fl"><h2>地址管理</h2></div>
            </div>
            <div class="member-border">
                <div class="member-newly">
                    <b><a href="${pageContext.request.contextPath}/address/updateAddressUI" >新增收货地址</a></b>
                    您已经创建了<i class="reds">${pageInfo.total}</i>个收货地址了，最多还可创建<i class="reds">${20 - pageInfo.total}</i>个
                </div>
                <div class="member-sites">
                    <c:forEach var="address" items="${pageInfo.list}">
                        <ul>
                            <li class="clearfix">
                                <c:if test="${address.defaultAddress == 1}">
                                    <div class="default fl"><a href="#">默认地址</a> </div>
                                </c:if>
                                <c:if test="${address.defaultAddress != 1}">
                                    <div class="default fl"> </div>
                                </c:if>
                                <div class="user-info1 fl clearfix">
                                    <div class="user-info">
                                        <span class="info1">收货人姓名：</span>
                                        <span class="info2">${address.username}</span>
                                    </div>
                                    <div class="user-info">
                                        <span class="info1">联系方式：</span>
                                        <span class="info2">${address.phone}</span>
                                    </div>
                                    <div class="user-info">
                                        <span class="info1">邮政编码：</span>
                                        <span class="info2">${address.zipCode}</span>
                                    </div>
                                    <div class="user-info">
                                        <span class="info1">所在地区：</span>
                                        <span class="info2">${address.province}${address.city}${address.area}</span>
                                    </div>
                                    <div class="user-info">
                                        <span class="info1">详细地址：</span>
                                        <span class="info2">${address.fullAddress}</span>
                                    </div>
                                </div>
                                <div class="pc-event">
                                    <c:if test="${address.defaultAddress != 1}">
                                        <a href="${pageContext.request.contextPath}/address/updateDefaultAddress?addressId=${address.addressId}">设为默认地址</a>
                                    </c:if>
                                    <c:if test="${address.defaultAddress == 1}">
                                        <a href="#" class="pc-event-d">设为默认地址</a>
                                    </c:if>
                                    <a href="${pageContext.request.contextPath}/address/updateAddressUI?addressId=${address.addressId}">编辑 </a>
                                    <a href="${pageContext.request.contextPath}/address/removeAddress?addressId=${address.addressId}">删除</a>
                                </div>
                            </li>
                        </ul>
                    </c:forEach>
                </div>
                <div class="member-pages clearfix">
                    <div class="fr pc-search-g">
                        <a href="${pageContext.request.contextPath}/address/showAddressUI?userId=${loginUser.userId}&pageNum=${pageInfo.prePage}" class="fl pc-search-f">上一页</a>
                        <a class="current" href="#">${pageInfo.pageNum}</a>
                        <a href="${pageContext.request.contextPath}/address/showAddressUI?userId=${loginUser.userId}&pageNum=${pageInfo.nextPage}" class="pc-search-n" >下一页</a>
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
<script type="text/javascript">
    function skip() {
        // 获取用户输入的页码
        var page = $("#page").val();
        /*
        if (page == "") {
            return false;
        }
        */
        var newUrl = "${pageContext.request.contextPath}/address/showAddressUI?userId=${loginUser.userId}&pageNum=" + page;
        // 获取url
        var url = $("#confire").attr("href",newUrl);
    }
</script>
<c:if test="${message != null}">
    <script type="text/javascript">
        var message = "${message}";
        alert(message);
    </script>
</c:if>
<c:if test="${errors != null}">
    <c:forEach var="e" items="${errors}">
        <script type="text/javascript">
            var errors = '${e.defaultMessage}';
            alert(errors);
        </script>
    </c:forEach>
</c:if>
</body>
</html>