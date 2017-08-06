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
    <title>查看商品</title>
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
                <li class="sub-menu active">
                    <a href="javascript:;" class="">
                        <i class="icon-cogs"></i>
                        <span>商品管理</span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub">
                        <li class="active"><a class="" href="${pageContext.request.contextPath}/merchant/showItemsUI?merchantId=${loginMerchant.merchantId}">查看商品</a></li>
                        <li class=""><a class="" href="${pageContext.request.contextPath}/merchant/updateItemsUI">添加商品</a></li>
                    </ul>
                </li>
                <li class="sub-menu">
                    <a href="javascript:;" class="">
                        <i class="icon-tasks"></i>
                        <span>Form Stuff</span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub">
                        <li class=""><a class="" href="form_component.html">Form Components</a></li>
                        <li><a class="" href="form_wizard.html">Form Wizard</a></li>
                        <li><a class="" href="form_validation.html">Form Validation</a></li>
                    </ul>
                </li>
                <li class="sub-menu">
                    <a href="javascript:;" class="">
                        <i class="icon-th"></i>
                        <span>Data Tables</span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub">
                        <li><a class="" href="basic_table.html">Basic Table</a></li>
                        <li><a class="" href="dynamic_table.html">Dynamic Table</a></li>
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
                            商品目录
                        </header>
                        <table class="table table-striped table-advance table-hover" id="itemTable">
                            <thead>
                            <tr>
                                <th>商品图片</th>
                                <th>商品标题</th>
                                <th>一级类目</th>
                                <th>二级类目</th>
                                <th>价格</th>
                                <th>库存</th>
                                <th>销量</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <div class="row">
                                <c:forEach var="item" items="${pageInfo.list}">
                                    <tr>
                                        <td><img src="/image/${item.images}" width="35" height="35"/></td>
                                        <td>${item.itemTitle}</td>
                                        <td>${item.categoryOne}</td>
                                        <td>${item.categoryTwo}</td>
                                        <td>${item.price}</td>
                                        <td>${item.stock}</td>
                                        <td>${item.sales}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/merchant/updateItemsUI?itemId=${item.itemId}" class="btn btn-primary btn-xs">查看</a>
                                            <input type="hidden" id="delete" value="${item.itemId}">
                                            <a href="#" class="btn btn-danger btn-xs" onclick="deleteItem(this)">删除</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </div>
                            </tbody>
                        </table>
                        <div class="text-right">
                            <ul class="pagination">
                                <li><a href="#" onclick="prefPage()">«</a></li>
                                <li><a href="#" id="pageNum">${pageInfo.pageNum}</a></li>
                                <li><a href="#" onclick="nextfPage()">»</a></li>

                                &nbsp;
                                共<a id="pages">${pageInfo.pages}</a>页&nbsp;到第 &nbsp;<input type="text" size="5" id="page">  &nbsp;页
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
            var itemId = a.value;
            $.ajax({
                type:'post',
                url:'${pageContext.request.contextPath }/merchant/deleteItem',
                data:{"itemId":itemId},
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
    // 上一页
    var prePage = '${pageInfo.prePage}';
    // 下一页
    var nextPage = '${pageInfo.nextPage}';
    // 商家id
    var merchantId = '${loginMerchant.merchantId}';

    // 当前项目路径
    var path = '${pageContext.request.contextPath}';

    // 前往前一页
    function prefPage() {
        $.ajax({
            type:'post',
            url:'${pageContext.request.contextPath }/merchant/asyncSelect',
            data:{"merchantId":merchantId, "pageNum":prePage, "path":path},
            success:function(data) {//返回json结果
                // 清除原来的tbody里面的内容
                $("#itemTable tbody").html("");
                // 将字符串拼接到tbody里面
                $("#itemTable tbody").html(data.message);
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
            url:'${pageContext.request.contextPath }/merchant/asyncSelect',
            data:{"merchantId":merchantId, "pageNum":nextPage, "path":path},
            success:function(data) {//返回json结果
                // 清除原来的tbody里面的内容
                $("#itemTable tbody").html("");
                // 将字符串拼接到tbody里面
                $("#itemTable tbody").html(data.message);
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
    //跳转到指定页面
    function skip() {
        // 获取用户输入的页码
        var page = $("#page").val();
        prePage = page;
        this.prefPage();
    }


</script>

</body>
</html>

