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

        $(document).ready(function($){

            $(".btn1").click(function(event){
                $(".hint").css({"display":"block"});
                $(".box").css({"display":"block"});
            });

            $(".hint-in3").click(function(event) {
                $(".hint").css({"display":"none"});
                $(".box").css({"display":"none"});
            });

            $(".hint3").click(function(event) {
                $(this).parent().parent().css({"display":"none"});
                $(".box").css({"display":"none"});
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
            <form class="clearfix">
                <input type="text" class="search-text" accesskey="" id="key" autocomplete="off"  placeholder="洗衣机">
                <button class="button" onClick="search('key');return false;">搜索</button>
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
                    <dd><a href="#">我的订单</a></dd>
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
                    您已经创建了<i class="reds">4</i>个收货地址了，最多可创建<i class="reds">20</i>个
                </div>
                <div class="member-sites">
                    <ul>
                        <li class="clearfix">
                            <div class="default fl"><a href="#">默认地址</a> </div>
                            <div class="user-info1 fl clearfix">
                                <div class="user-info">
                                    <span class="info1">收货人：</span>
                                    <span class="info2">张子琪</span>
                                </div>
                                <div class="user-info">
                                    <span class="info1">所在地区：</span>
                                    <span class="info2">北京市海淀区三环到四环之间</span>
                                </div>
                                <div class="user-info">
                                    <span class="info1">地址：</span>
                                    <span class="info2">北京市海淀区中关村南街99号，幸福小区3号楼4门401</span>
                                </div>
                                <div class="user-info">
                                    <span class="info1">手机：</span>
                                    <span class="info2">186****4832</span>
                                </div>
                                <div class="user-info">
                                    <span class="info1">固定电话：</span>
                                    <span class="info2">010-81819191</span>
                                </div>
                                <div class="user-info">
                                    <span class="info1">电子邮箱：</span>
                                    <span class="info2">azneui@sina.com</span>
                                </div>
                            </div>

                            <div class="pc-event">
                                <a href="#" class="pc-event-d">设为默认地址</a>
                                <a href="${pageContext.request.contextPath}/address/updateAddressUI?addressId=6">编辑 </a>
                                <a href="${pageContext.request.contextPath}/address/removeAddress?addressId=6">删除</a>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="member-pages clearfix">
                    <div class="fr pc-search-g">
                        <a href="#" class="fl pc-search-f">上一页</a>
                        <a class="current" href="#">1</a>
                        <a href="javascript:;">2</a>
                        <a href="javascript:;">3</a>
                        <a href="javascript:;">4</a>
                        <a href="javascript:;">5</a>
                        <a href="javascript:;">6</a>
                        <a href="javascript:;">7</a>
                        <span class="pc-search-di">…</span>
                        <a onClick="SEARCH.page(3, true)" href="javascript:;" class="pc-search-n" title="使用方向键右键也可翻到下一页哦！">下一页</a>
                        <span class="pc-search-y">
                        <em>  共20页    到第</em>
                        <input type="text" placeholder="1" class="pc-search-j">
                        <em>页</em>
                        <a class="confirm" href="#">确定</a>
                    </span>

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<c:if test="${message != null}">
    <script type="text/javascript">
        var message = "${message}";
        alert(message);
    </script>
</c:if>
</body>
</html>