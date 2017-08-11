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
    <title>免费开店</title>
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
        <a href="${pageContext.request.contextPath}/merchant/merchantIndexUI">进入店铺</a>
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
                <div class="member-heels fl"><h2>免费开店</h2></div>
            </div>
            <div class="member-border">
                <div class="member-caution clearfix">
                    <ul>
                        <li class="clearfix">
                            <div style=" width:133px; height:22px; line-height:22px; float:left; color:#666666; font-size:18px; font-weight:700; text-align:center; margin-top:4px;">店铺名称</div>
                            <form action="" method="post" id="merchant">
                            <div class="login-input list-input">
                                <input type="text" name="merchantName" id="merchantName" placeholder="每个用户只能注册一个店铺，且店铺名注册后不可修改和删除">
                            </div>
                            <div class="login-button"><a href="#" onclick="submit()">免费开店</a></div>
                            </form>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>
<!--表单验证插件-->
<script src="${pageContext.request.contextPath}/resources/theme/util/jquery.validate.js" type="text/javascript"></script>
<!--导入自定义的验证规则-->
<script src="${pageContext.request.contextPath}/resources/theme/util/validate-methods.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#merchant").validate({
            rules: {
                merchantName: {
                    required: true,
                    isContainBlank: true,
                    maxlength: 30,
                },
            },
            messages: {
                merchantName: {
                    required: "店铺名不可为空",
                    isContainBlank: "店铺名不可包含空格",
                    maxlength: "店铺名不可超过30位",
                },
            },
            submitHandler: function(form) {  //验证通过之后回调
                saveMerchant(); // 通过后调用addMerchant()通过ajax注册店铺
            },
            invalidHandler: function(form, validator) {  //验证不通过之后回调
                return false;
            }
        })
    })
    
    // 提交表单
    function submit() {
        $("#merchant").submit();
    }

    // 异步注册店铺
    function saveMerchant() {
        var merchantName = $("#merchantName").val(); // 店铺名
        var userId = "${loginUser.userId}"; // 获取登录用户的主键，作为店铺表的主键
        $.ajax({
            type:'post',
            url:'${pageContext.request.contextPath }/merchant/saveMerchant',
            data:{"merchantName":merchantName, "userId":userId},
            success:function(data){//返回json结果
                if (data.success == false) {
                    alert(data.message);
                } else {
                    alert(data.message);
                    window.location.href="${pageContext.request.contextPath}/merchant/merchantIndexUI";
                }
            }

        });
    }
</script>
</body>
</html>
