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
    <title>商品类目</title>
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
                    <li class="active">
                        <a class="" href="${pageContext.request.contextPath}/admin/admin/categoryOneUI">
                            <i class="icon-dashboard"></i>
                            <span>商品类目</span>
                        </a>
                    </li>
                    <li>
                        <a class="" href="${pageContext.request.contextPath}/admin/admin/logout">
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
                                商品二级类目
                                <a href="#myModal-1" data-toggle="modal" class="btn btn-xs btn-warning">
                                    添加新的二级类目
                                </a>
                            </header>
                            <table class="table table-striped table-advance table-hover">
                                <thead>
                                <tr>
                                    <th><i class="icon-bullhorn"></i> 类目id</th>
                                    <th><i class="icon-bookmark"></i>类目内容</th>
                                    <th><i class="icon-reorder"></i>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="categoryTwo" items="${pageInfo.list}">
                                    <tr>
                                        <td>${categoryTwo.categoryTwoId}</td>
                                        <td>${categoryTwo.name}</td>
                                        <td>
                                            <a href="#myModal-1" data-toggle="modal" class="btn btn-primary btn-xs" onclick="update(this)">修改</a>
                                            <a href="${pageContext.request.contextPath}/admin/admin/removeCategoryTwo?categoryTwoId=${categoryTwo.categoryTwoId}&categoryOneId=${categoryOne.categoryOneId}"
                                               onclick="deleteCategory(this)" class="btn btn-danger btn-xs">删除</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <div class="text-right">
                                <ul class="pagination">
                                    <li><a href="${pageContext.request.contextPath}/admin/admin/categoryTwoUI?pageNum=${pageInfo.prePage}&categoryOneId=${categoryOne.categoryOneId}">«</a></li>
                                    <li><a href="#">${pageInfo.pageNum}</a></li>
                                    <li><a href="${pageContext.request.contextPath}/admin/admin/categoryTwoUI?pageNum=${pageInfo.nextPage}&categoryOneId=${categoryOne.categoryOneId}">»</a></li>
                                    &nbsp;
                                    共${pageInfo.pages}页&nbsp;到第 &nbsp;<input type="text" size="5" id="page">  &nbsp;页
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
        <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal-1" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                        <h4 class="modal-title" id="h4">添加新的二级类目</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal" role="form" id="addCategory" method="post">
                            <div class="form-group">
                                <label class="col-lg-2 control-label">新类目</label>
                                <div class="col-lg-10">
                                    <input type="text" class="form-control" id="inputEmail4" placeholder="类目名" name="category">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-offset-2 col-lg-10">
                                    <input type="hidden" id="categoryTwoId" value="">
                                    <button type="submit" class="btn btn-default" >保存</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
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
    <!-- 弹窗插件 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/dialog/css/animate.min.css"/> <!-- 动画效果 -->
    <script src="${pageContext.request.contextPath}/resources/dialog/js/jquery.hDialog.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#addCategory").validate({
                rules: {
                    category: {
                        required: true,
                        maxlength: 10,
                        isContainBlank: true,
                    },
                },
                messages: {
                    category: {
                        required: "类目不可为空",
                        maxlength: "类目名不可超过10位",
                        isContainBlank: "不可含有空格",
                    },
                },
                submitHandler: function(form) {  //验证通过之后回调
                    addCategory();
                },
                invalidHandler: function(form, validator) {  //验证不通过之后回调
                    return false;
                }
            })
        })

        //添加一级目录
        function addCategory() {
            var name = $("#inputEmail4").val(); //通过id获取类目内容
            var categoryOneId = '${categoryOne.categoryOneId}';
            var categoryTwoId = $("#categoryTwoId").val();
            // 隐藏域的值无法设为空，因此通过判断值为""的话将设为null,方便后台区别保存操作和修改操作
            if (categoryTwoId == "") {
                categoryTwoId = null;
            }
            $.ajax({
                type:'post',
                url:'${pageContext.request.contextPath }/admin/admin/saveCategoryTwo',
                //请求是key/value这里不需要指定contentType，因为默认就 是key/value类型
                //contentType:'application/json;charset=utf-8',数据格式是字符串
                data:{"name":name, "categoryOneId":categoryOneId,"categoryTwoId":categoryTwoId},
                success:function(data) {//返回json结果
                    if (data.success == false) {
                        $.tooltip(data.message, 2000);
                    } else {
                        $.tooltip(data.message, 2000, true);
                        setTimeout(function () {
                            window.location.href="${pageContext.request.contextPath}/admin/admin/categoryTwoUI?categoryOneId=${categoryOne.categoryOneId}";
                        },800);
                    }
                }
            });
        }

        function skip() {
            // 获取用户输入的页码
            var page = $("#page").val();
            var newUrl = "${pageContext.request.contextPath}/admin/admin/categoryTwoUI?pageNum=" + page + "&categoryOneId=${categoryOne.categoryOneId}";
            // 获取url
            var url = $("#confire").attr("href",newUrl);
        }

        // 设置模态框内容
        function update(object) {
            // 点击修改后获取父标签td的父标签tr的第1个td标签
            var td1 = $(object).parent().parent().find('td')[0];
            // 获取td标签的值
            var id = td1.innerHTML;
            // 点击修改后获取父标签td的父标签tr的第2个td标签
            var td2 = $(object).parent().parent().find('td')[1];
            // 获取td标签的值
            var name = td2.innerHTML;
            // 将td1的值设置到修改模态框里面的隐藏域
            $("#categoryTwoId").val(id);
            // 将td2的值设置到修改模态框里面
            $("#inputEmail4").val(name);
            $("#h4").html("修改二级目录");
        }

        // 模态框消失，清除隐藏域和标签的内容
        $("#myModal-1").on('hide.bs.modal',function () {
            $("#h4").html("添加新的二级类目");
            $("#categoryTwoId").val(null);
            $("#inputEmail4").val(null);
        })

        function deleteCategory(o) {
            var url = $(o).attr("href");
            // 阻止超链接
            $(o).attr("href", "#");
            $.dialog('confirm','提示','确认要删除吗？',0,function(){
                $.tooltip('执行删除',0,true,function(){
                    $.closeDialog(function(){
                        categoryDelete(o, url);
                    });
                });
            });
        }

        function categoryDelete(o, url) {
            $.ajax({
                type: 'post',
                url: url,
                success: function (data) {//返回json结果
                    $.tooltip("删除成功", 3500, true);
                    setTimeout(function () {
                        window.location.href = "";
                    }, 800)
                }
            });
        }
    </script>
</body>
</html>

