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
    <title>提交订单</title>
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/theme/icon/favicon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/base.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/home.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/theme/js/jquery.js"></script>
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
        <div class="header-logo fl" style="width:212px;"><h1><a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/theme/icon/logo.png"></a></h1></div>
        <div class="pc-order-titlei fl"><h2>填写订单</h2></div>
        <div class="pc-step-title fl">
            <ul>
                <li class="cur2"><a href="#">1 . 我的购物车</a></li>
                <li class="cur"><a href="#">2 . 填写核对订单</a></li>
                <li><a href="#">3 . 成功提交订单</a></li>
            </ul>
        </div>
    </div>

</header>
<!-- header End -->


<!-- 订单提交成功 begin-->
<section>
    <div class="containers">
        <form action="" method="post" id="order">
            <div class="pc-space">
                <div class="pc-order-title clearfix"><h3 class="fl">收货人信息</h3>
                    <a href="${pageContext.request.contextPath}/address/showAddressUI?userId=${loginUser.userId}" target="_blank" class="fr pc-order-add btn1">管理收货地址</a>
                    <a href="#" class="fr pc-order-add btn1" style="margin-left: 50px" onclick="addressUls()">获取收货地址</a>
                </div>
                <div class="pc-border">
                    <div class="pc-order-text clearfix" id="addresUl">
                            <c:if test="${defaultAddress != null}">
                                <c:forEach var="address" items="${defaultAddress}">
                                    <ul class=" clearfix">
                                        <li>
                                            <div class="fl pc-address">
                                                <span>默认地址</span>
                                                <span><input type="radio" name="addressId" value="${address.addressId}" ></span>
                                                <span>${address.username}</span>
                                                <span>${daddress.phone}</span>
                                                <span>${address.province}${address.city}${address.area}</span>
                                                <span>${address.fullAddress}</span>
                                                <span>${address.zipCode}</span>
                                            </div>
                                        </li>
                                    </ul>
                                </c:forEach>
                            </c:if>
                    </div>
                </div>
            </div>
            <div class="pc-space clearfix">

                    <div class="pc-order-title clearfix"><h3 class="fl">商品信息</h3></div>
                    <div class="pc-border">
                        <div class="pc-order-text clearfix">
                            <div class="pc-wares-t"><h4>商家：  ${orderItem.merchant.merchantName}</h4></div>
                            <div class="clearfix pc-wares-p">
                                <div class="fl pc-wares"><a href="#"><img src="${path.IMAGE_PATH}/${path.FILE_PATH_PRODUCT}/${orderItem.images}" width="82" height="82"></a></div>
                                <div class="fl pc-wares-w" style="margin-left:50px;"> <a href="#">${orderItem.itemTitle}</a></div>
                                <div class="fl pc-wares-s"><span class="reds">￥${orderItem.price}</span></div>
                                <div><input type="text" id="itemNumber" style="width:68px;margin-left:170px;" value="${itemNumber}" onchange="check()" name="itemNumber"></div>
                            </div>
                            <div class="pc-written"><p>订单留言</p><input type="text" style="margin:0 0 0px; height: 30px; width:500px;" name="remark"></div>
                        </div>
                    </div>

            </div>
            <div class="clearfix">
                <div class="fr pc-list-t">
                    <ul>
                        <li><span ><b id="number">${itemNumber}</b> 件商品</span></li>
                    </ul>
                </div>
            </div>
            <div class="pc-space-n"></div>
            <div class="clearfix">
                <div class="fr pc-space-j" id="new">
                    <spna>应付总额：<strong id="total">￥${orderItem.price * itemNumber}</strong></spna>
                    <input type="hidden" name="totalPrice" id="totalPrice" value="${orderItem.price * itemNumber}">
                    <button class="pc-submit" type="submit">提交订单</button>
                </div>
            </div>
        </form>
    </div>
</section>
<!-- 订单提交成功 End-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/theme/js/address.js"></script>
<!--表单验证插件-->
<script src="${pageContext.request.contextPath}/resources/theme/util/jquery.validate.js" type="text/javascript"></script>
<!--导入自定义的验证规则-->
<script src="${pageContext.request.contextPath}/resources/theme/util/validate-methods.js" type="text/javascript"></script>
<script type="text/javascript">

    $(document).ready(function () {
        $("#order").validate({
            rules: {
                addressId: {
                    required: true,
                },
                remark: {
                    maxlength: 200,
                },
            },
            messages: {
                addressId: {
                    required: "请选择地址",
                },
                remark: {
                    maxlength: "备注过长，最多200个字符",
                },
            },
            submitHandler: function(form) {  //验证通过之后回调
                formUpload();
            },
            invalidHandler: function(form, validator) {  //验证不通过之后回调
                return false;
            }
        })
    })
    $(function(){

        $("#sjld").sjld("#shenfen","#chengshi","#quyu");

    });

    // 获取登录用户id
    var userId = '${loginUser.userId}';
    // 获取地址
    function addressUls() {
        $.ajax({
            type:'post',
            url:'${pageContext.request.contextPath }/order/selectAddress',
            data:{"userId":userId},
            success:function(data) {//返回json结果
                $("#addresUl").find("ul").remove();
                $("#addresUl").append(data.message);
            }
        });
    }

    // 根据用户输入的购买数量改变页面数据
    function check() {
        // 获取用户购买数量
        var itemNumber = $("#itemNumber").val();
        // 判断用户购买数量是否正确
        var rule = /^[1-9][0-9]{0,9}$/;
        if (!(rule.test(itemNumber))) {
            alert("请输入正确的购买数量");
            return false;
        }
        // 获取商品价格
        var price = '${orderItem.price}';
        // 计算总价
        var total = price * itemNumber;
        // 改变商品数量
        $("#number").text(itemNumber);
        // 改变商品总价
        $("#totalPrice").val(total);
        total = "￥" + total;
        $("#total").text(total);
    }

    // 异步提交表单
    function formUpload() {
        var form = new FormData(document.getElementById("order"));
        $.ajax({
            type:'post',
            url:'${pageContext.request.contextPath }/order/saveOrder',
            data:form,
            processData:false,
            contentType:false,
            success:function(data){//返回json结果
                if (data.success == false) {
                    alert(data.message);
                }
                if (data.success == true) {
                   alert(data.message);
                   window.location.href="${pageContext.request.contextPath}/";
                }
            }
        });
    }
</script>
</body>
</html>