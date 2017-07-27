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
    <title>帐户安全</title>
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/theme/icon/favicon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/base.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/member.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/center.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/theme/js/jquery.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/theme/css/address.css">
    <!-- 出生日期选择插件 -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/theme/js/birthday.js"></script>
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
        <a href="${pageContext.request.contextPath}/user/userInformationUI">个人资料</a>
        &gt;
    </div>
</div>

<section id="member">
    <div class="member-center clearfix">
        <div class="member-left fl">
            <div class="member-apart clearfix">
                <div class="fl"><a href="#">
                    <c:if test="${loginUser.image != null}">
                        <img src="/image/${loginUser.image}"/>
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
                <div class="member-heels fl"><h2>个人资料</h2></div>
            </div>
            <div class="public_m1">
                <div class="public_m2">资料管理</div>
                <!--照片和内容-->
                <div class="zp_nrm">
                    <!--left-->
                    <div class="zp_nrm_l">
                        <c:if test="${loginUser.image != null}">
                            <img src="/image/${loginUser.image}"/>
                        </c:if>
                        <c:if test="${loginUser.image == null}">
                            <img src="/image/user/null.jpg"/>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/user/avatarUI">更换头像</a>
                    </div>
                    <!--right-->
                    <form action="${pageContext.request.contextPath}/user/updateUser" method="post" id="information">
                        <div class="zp_nrm_r">
                            <p><em>用户名：</em><i>${loginUser.username}</i></p>
                            <p>
                                <em>性别：</em>
                                <!-- 同一组单选的值要一样-->
                                <input type="radio" name="sex" class="sex_m" value="保密" <c:if test="${loginUser.sex == '保密'}">checked</c:if>><i>保密</i>
                                <input type="radio" name="sex" class="sex_m" value="男"   <c:if test="${loginUser.sex == '男'}">checked</c:if>><i>男</i>
                                <input type="radio" name="sex" class="sex_m" value="女"   <c:if test="${loginUser.sex == '女'}">checked</c:if>><i>女</i>
                            </p>
                            <span class="borth_m">
                                出生日期：
                                <select  id="sel_year" rel="${loginUser.year}" name="year">
                                </select>&nbsp;年&nbsp;
                                <select id="sel_month" rel="${loginUser.month}" name="month">
                                </select>&nbsp;月&nbsp;
                                <select id="sel_day" rel="${loginUser.day}" name="day">
                                </select>&nbsp;日&nbsp;
                            </span>
                            <input type="hidden" name="userId" value="${loginUser.userId}">
                            <a href="#" class="public_m3"  onclick="submit()">保存修改</a>
                        </div>
                    </form>
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
<script type="text/javascript">

    function submit() {
        $("#information").submit();
    }

    $(function () {
        $.ms_DatePicker({
            YearSelector: ".sel_year",
            MonthSelector: ".sel_month",
            DaySelector: ".sel_day"
        });
        $.ms_DatePicker();
    });

</script>
</body>
</html>

