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
    <title>商品详情</title>
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/theme/icon/favicon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/base.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/home.css">
    <script src="${pageContext.request.contextPath}/resources/theme/js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/theme/js/index.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/theme/js/js-tab.js"></script>
    <script>
        $(function(){
            $("#pro_detail a").click(function(){
                $("#pro_detail a").removeClass("cur");
                $(this).addClass("cur");
                $("#big_img").attr("src",$(this).attr("simg"));
            });

            $(".attrdiv a").click(function(){
                $(".attrdiv a").removeClass("cur");
                $(this).addClass("cur");
            });

            $('.amount2').click(function(){
                var num_input = $("#subnum");
                var buy_num = (num_input.val()-1)>0?(num_input.val()-1):1;
                num_input.val(buy_num);
            });

            $('.amount1').click(function(){
                var num_input = $("#subnum");
                var buy_num = Number(num_input.val())+1;
                num_input.val(buy_num);
            });

            $("#H-table li").each(function(i){
                $(this).click((function(k){
                    var _index = k;
                    return function(){
                        $(this).addClass("cur").siblings().removeClass("cur");
                        $(".H-over").hide();
                        $(".H-over:eq(" + _index + ")").show();
                    }
                })(i));
            });
            $("#H-table1 li").each(function(i){
                $(this).click((function(k){
                    var _index = k;
                    return function(){
                        $(this).addClass("cur").siblings().removeClass("cur");
                        $(".H-over1").hide();
                        $(".H-over1:eq(" + _index + ")").show();
                    }
                })(i));
            });
        });

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
    <%@include file="top.jsp"%>
    <div class="container clearfix">
        <div class="header-logo fl"><h1><a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/theme/icon/logo.png"></a> </h1></div>
        <div class="head-form fl">
            <form class="clearfix" action="${pageContext.request.contextPath}/selectItemsBySearchName" method="post" id="searchForm">
                <input type="text" class="search-text" id="search" name="search">
                <button class="button" type="submit">搜索</button>
            </form>
            <div class="words-text clearfix">
            </div>
        </div>
        <div class="header-cart fr"><a href="#"><img src="${pageContext.request.contextPath}/resources/theme/icon/car.png"></a> <i class="head-amount">99</i></div>
        <div class="head-mountain"></div>
    </div>
    <div class="yHeader">
        <div class="yNavIndex">
            <div class="pullDown">
                <h2 class="pullDownTitle">全部商品分类</h2>
            </div>
            <ul class="yMenuIndex">
                <li><a href="" target="_blank">服装城</a></li>
                <li><a href="" target="_blank">美妆馆</a></li>
                <li><a href="" target="_blank">美食</a></li>
                <li><a href="" target="_blank">全球购</a></li>
                <li><a href="" target="_blank">闪购</a></li>
                <li><a href="" target="_blank">团购</a></li>
                <li><a href="" target="_blank">拍卖</a></li>
                <li><a href="" target="_blank">金融</a></li>
                <li><a href="" target="_blank">智能</a></li>
            </ul>
        </div>
    </div>
</header>
<!-- header End -->

<!-- 商品详情 begin -->
<section>
    <div class="pc-details" >
        <div class="containers">
            <div class="pc-nav-item"></div>
            <div class="pc-details-l">
                <div class="pc-product clearfix">
                    <div class="pc-product-h">
                        <div class="pc-product-top"><img src="/image/${item.images}" id="big_img" width="418" height="418"></div>
                        <div class="pc-product-bop clearfix" id="pro_detail">
                            <ul>
                                <li><a href="javascript:void(0);" class="cur" simg="/image/${item.images}"><img src="/image/${item.images}" width="58" height="58"></a> </li>
                                <li><a href="javascript:void(0);" simg="/image/${item.images}"><img src="/image/${item.images}" width="58" height="58"></a> </li>
                                <li><a href="javascript:void(0);" simg="/image/${item.images}"><img src="/image/${item.images}" width="58" height="58"></a> </li>
                                <li><a href="javascript:void(0);" simg="/image/${item.images}"><img src="/image/${item.images}" width="58" height="58"></a> </li>
                                <li><a href="javascript:void(0);" simg="/image/${item.images}"><img src="/image/${item.images}" width="58" height="58"></a> </li>
                            </ul>
                        </div>
                    </div>
                    <div class="pc-product-t">
                        <div class="pc-name-info">
                            <h1>${item.itemTitle}</h1>
                            <p class="clearfix pc-rate"><strong>￥${item.price}</strong></p>
                        </div>
                        <div class="pc-dashed clearfix">
                            <span>累计销量：<em class="reds">${item.sales}</em> 件</span>
                        </div>
                        <div class="pc-size">
                            <div class="pc-telling clearfix">
                                <div class="pc-version">数量</div>
                                <div class="pc-adults clearfix">
                                    <div class="pc-adults-p clearfix fl">
                                        <input type="text"   id="itemNumber">
                                        <a href="javascript:void(0);" class="amount1"></a>
                                        <a href="javascript:void(0);" class="amount2"></a>
                                    </div>
                                    <div class="fl pc-letter ">件</div>
                                    <div class="fl pc-stock ">库存<em class="reds" >${item.stock}</em>件</div>
                                </div>
                            </div>
                        </div>
                        <div class="pc-emption">
                            <a href="#" onclick="buy()">立即购买</a>
                            <a href="#" class="join" onclick="addCart()">加入购物车</a>
                        </div>
                    </div>
                    <div class="pc-product-s">
                        <div class="pc-shoplo"></div>
                        <div class="pc-shopti">
                            <h2>${item.merchant.merchantName}</h2>
                        </div>
                            <div class="pc-custom"><a href="#">进入店铺</a> </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="containers clearfix">

            <div class="pc-overall">
                <div class="pc-term clearfix">
                    <div class="H-over1 pc-text-word clearfix">
                        <div class="">
                            ${item.details}
                        </div>
                    </div>
                </div>
            </div>

    </div>
</section>
<!-- 商品详情 End -->
<script type="text/javascript">
    // 商品id
    var itemId;
    // 商品库存
    var stock;
    // 用户购买数量
    var itemNumber;
    // 登录用户id
    var userId = '${loginUser.userId}';

    // 判断用户购买数量是否正确
    function checkNumber() {
        // 获取商品id
        itemId = '${item.itemId}';
        // 获取商品库存
        stock = "${item.stock}";
        // 获取用户购买数量
        itemNumber = $("#itemNumber").val();
        // 判断用户购买数量是否正确
        var rule = /^[1-9][0-9]{0,9}$/;
        if (!(rule.test(itemNumber))) {
            alert("请输入正确的购买数量");
            return false;
        }
        if ((itemNumber - stock) > 0) {
            alert("库存不足，请重新选择");
            return false;
        }
        return true;
    }

    // 购买
    function buy() {
        var flag = checkNumber();
        if (!flag) {
            return false;
        }
        window.location.href = "${pageContext.request.contextPath}/order/saveOrderUI?itemId=" + itemId +
            "&itemNumber=" + itemNumber;
    }

    // 加入购物车
    function addCart() {
        var flag = checkNumber();
        if (!flag) {
            return false;
        }
        saveCart();

    }

    // 异步购物车添加商品
    function saveCart() {
        $.ajax({
            type:'post',
            url:'${pageContext.request.contextPath }/cart/saveCart',
            data:{"itemId":itemId, "userId":userId, "number":itemNumber},
            success:function(data) {//返回json结果
                alert(data.message);
            }
        });
    }
</script>
</body>
</html>