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
    <title>歪秀购物</title>
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
    <%@include file="top.jsp"%>
    <div class="container clearfix">
        <div class="header-logo fl"><h1><a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/theme/icon/logo.png"></a> </h1></div>
        <div class="head-form fl">
            <form class="clearfix" action="${pageContext.request.contextPath}/selectItemsBySearchName" method="post" id="searchForm">
                <input type="text" class="search-text" id="search" name="search" value="${search}">
                <input type="hidden" class="search-text" id="search2" value="${search}">
                <button class="button" type="submit">搜索</button>
            </form>
            <form action="${pageContext.request.contextPath}/selectItemsByCategory" method="post" id="category">
                <input type="hidden" id="categoryName" name="categoryName" value="${categoryName}">
            </form>
        </div>
        <div class="header-cart fr"><a href="#"><img src="${pageContext.request.contextPath}/resources/theme/icon/car.png"></a> <i class="head-amount">99</i></div>
        <div class="head-mountain"></div>
    </div>
    <div class="yHeader">
    </div>
</header>
<!-- header End -->

<div class="containers clearfix">

        <div class="pc-term">
            <dl class="pc-term-dl clearfix">
                <dt><a href="#" onclick="select(this)">${category.name}:</a></dt>
                <c:forEach var="c" items="${category.categoryTwoList}">
                    <dd><a href="#" onclick="select(this)">${c.name}</a></dd>
                </c:forEach>
            </dl>
        </div>

        <div class="time-border-list pc-search-list clearfix">
            <ul class="clearfix" id="itemUl">
                <c:forEach var="item" items="${pageInfo.list}">
                <li>
                    <a href="${pageContext.request.contextPath}/showItem?itemId=${item.itemId}"><img src="/image/${item.images}" width="213" height="213"></a>
                    <p class="head-name"><a href="${pageContext.request.contextPath}/showItem?itemId=${item.itemId}">${item.itemTitle}</a> </p>
                    <br>
                    <p><span class="price">￥${item.price}</span><span class="fr">${item.sales}人购买</span></p>
                    <p><a href="${pageContext.request.contextPath}/${item.merchant.merchantId}"><span class="fl">${item.merchant.merchantName}</span></a></p>
                </li>
                </c:forEach>
            </ul>
            <div class="clearfix">
                <div class="fr">
                       &nbsp;
                                共<a id="pages">${pageInfo.pages}</a>页&nbsp;到第 &nbsp;<input type="text" size="5" id="page">  &nbsp;页
                                &nbsp;
                                <a class="confirm" href="#" onclick="skip()" id="confire">确定</a>
                                &nbsp;

                </div>
                <div class="fr pc-search-g">
                    <a class="fl pc-search-f" href="#" onclick="prefPage()">上一页</a>
                    <a href="#" class="current" id="pageNum">${pageInfo.pageNum}</a>
                    <a title="使用方向键右键也可翻到下一页哦！" class="pc-search-n" href="#" onclick="nextfPage()">下一页</a>
                </div>
            </div>
         </div>
</div>

<%@include file="footer.jsp"%>
<script type="text/javascript">banner()</script>
</body>
<script type="text/javascript">

    // 上一页
    var prePage = '${pageInfo.prePage}';
    // 下一页
    var nextPage = '${pageInfo.nextPage}';

    // 获取查询的类目名
    var categoryName = $("#categoryName").val();

    //获取搜索框内容
    var search = $("#search2").val();

    // 当前项目路径
    var path = '${pageContext.request.contextPath}';

    //跳转到指定页面
    function skip() {
        // 获取用户输入的页码
        var page = $("#page").val();
        prePage = page;
        this.prefPage();
    }

    // 前往前一页
    function prefPage() {
        $.ajax({
            type:'post',
            url:'${pageContext.request.contextPath }/asyncSelectItems',
            data:{"categoryName":categoryName, "pageNum":prePage, "path":path, "search":search},
            success:function(data) {//返回json结果
                $("#itemUl").empty().append(data.message);
                // 更改上一页和下一页
                prePage = data.prePage;
                nextPage = data.nextPage;
                // 设置当前页数
                $("#pageNum").text(data.pageNum);
                // 总页数
                $("#pages").text(data.pages);
        }
        });
    }

    //前往后一页
    function nextfPage() {
        $.ajax({
            type:'post',
            url:'${pageContext.request.contextPath }/asyncSelectItems',
            data:{"categoryName":categoryName, "pageNum":nextPage, "path":path, "search":search},
            success:function(data) {//返回json结果
                $("#itemUl").empty().append(data.message);
                // 更改上一页和下一页
                prePage = data.prePage;
                nextPage = data.nextPage;
                // 设置当前页数
                $("#pageNum").text(data.pageNum);
                // 总页数
                $("#pages").text(data.pages);
            }
        });
    }

    function select(o) {
        // 获取要查询的类目
        var condition = o.text;
        condition = condition.replace(":","");
        // 将值设置到category表单的隐藏域
        $("#categoryName").val(condition);
        // 提交表单
        $("#category").submit();
        return false;
    }
</script>
</body>
</html>