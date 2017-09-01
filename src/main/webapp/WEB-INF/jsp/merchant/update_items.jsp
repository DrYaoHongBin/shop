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
    <title>商品管理</title>
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/resources/merchant/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/merchant/css/bootstrap-reset.css" rel="stylesheet">
    <!--external css-->
    <link href="${pageContext.request.contextPath}/resources/merchant/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/merchant/assets/bootstrap-datepicker/css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/merchant/assets/bootstrap-colorpicker/css/colorpicker.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/merchant/assets/bootstrap-daterangepicker/daterangepicker.css" />
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/resources/merchant/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/merchant/css/style-responsive.css" rel="stylesheet" />
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 tooltipss and media queries -->
    <!--[if lt IE 9]>
    <script src="${pageContext.request.contextPath}/resources/merchant/js/html5shiv.js"></script>
    <script src="${pageContext.request.contextPath}/resources/merchant/js/respond.min.js"></script>
    <![endif]-->
    <!-- 图片上传 -->
    <link href="${pageContext.request.contextPath}/resources/image/css/common.css" type="text/css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/image/css/index.css" type="text/css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/resources/image/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/resources/image/js/imgUp.js"></script>
    <!-- ueditor -->
    <script src="${pageContext.request.contextPath}/resources/ueditor/ueditor.config.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/ueditor/ueditor.all.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/ueditor/ueditor.parse.js" type="text/javascript"></script>
    <!--配置语言类型-->
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resources/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript">
        window.UEDITOR_HOME_URL = "${pageContext.request.contextPath}/resources/ueditor/";
        // 实例化ueditor编辑器
        var ue = UE.getEditor('ueditor', {
            initialFrameHeight: 360, //编辑框高度
        });
        ue.ready(function () {
            ue.setContent('${item.details}');
        })
        UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
        UE.Editor.prototype.getActionUrl = function(action) {
            if (action == 'uploadimage' ) {
                return '${pageContext.request.contextPath}/merchant/uploadImage';
            } else {
                return this._bkGetActionUrl.call(this, action);
            }
        }
    </script>

</head>
<body>
    <section id="container" class="">
        <%@include file="navigation.jsp"%>
        <!--sidebar start-->
        <aside>
            <div id="sidebar"  class="nav-collapse ">
                <!-- sidebar menu start-->
                <ul class="sidebar-menu">
                    <li >
                        <a class="" href="${pageContext.request.contextPath}/merchant/merchantIndexUI">
                            <i class="icon-dashboard"></i>
                            <span>首页</span>
                        </a>
                    </li>
                    <li class="sub-menu">
                        <a href="javascript:;" class="">
                            <i class="icon-book"></i>
                            <span>订单管理</span>
                            <span class="arrow"></span>
                        </a>
                        <ul class="sub">
                            <li><a class="" href="${pageContext.request.contextPath}/order/selectOrderByMerchantId?merchantId=${loginMerchant.merchantId}">查看订单</a></li>
                        </ul>
                    </li>
                    <li class="sub-menu active">
                        <a href="javascript:;" class="">
                            <i class="icon-cogs"></i>
                            <span>商品管理</span>
                            <span class="arrow"></span>
                        </a>
                        <c:if test="${item == null}">
                        <ul class="sub">
                            <li><a class="" href="${pageContext.request.contextPath}/merchant/showItemsUI?merchantId=${loginMerchant.merchantId}">查看商品</a></li>
                            <li class="active"><a class="" href="${pageContext.request.contextPath}/merchant/updateItemsUI">添加商品</a></li>
                        </ul>
                        </c:if>
                        <c:if test="${item != null}">
                            <ul class="sub">
                                <li class="active"><a class="" href="${pageContext.request.contextPath}/merchant/showItemsUI?merchantId=${loginMerchant.merchantId}">查看商品</a></li>
                                <li><a class="" href="${pageContext.request.contextPath}/merchant/updateItemsUI">添加商品</a></li>
                            </ul>
                        </c:if>
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
                <div class="row">
                    <div class="col-lg-3"></div>
                    <div class="col-lg-6">
                        <section class="panel">
                            <header class="panel-heading">
                                添加商品
                            </header>
                            <div class="panel-body">
                                <form class="form-horizontal" role="form" id="add" action="${pageContext.request.contextPath }/merchant/saveItem" method="post" enctype="multipart/form-data">
                                    <div class="form-group">
                                        <label for="itemTitle" class="col-lg-2 control-label">商品标题</label>
                                        <div class="col-lg-10">
                                            <input type="text" class="form-control" id="itemTitle" name="itemTitle" placeholder="" value="${item.itemTitle}">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="itemTitle" class="col-lg-2 control-label">商品类目</label>
                                        <div class="col-lg-5">
                                            <select class="form-control m-bot15" id="categorySelect" name="categorySelect" required onchange="category()">
                                                <option value="">请先选择一级类目</option>
                                                <c:forEach var="categoryOne" items="${categoryOnes}">
                                                    <option value="${categoryOne.categoryOneId}">${categoryOne.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <input type="hidden" id="categoryOne" name="categoryOne">
                                        <div class="col-lg-5">
                                            <select class="form-control m-bot15" id="categoryTwo" name="categoryTwo" >
                                                <option value="">请选择二级类目</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="price" class="col-lg-2 control-label">价格</label>
                                        <div class="col-lg-10">
                                            <input type="text" class="form-control" id="price" name="price" placeholder="" value="${item.price}">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="stock" class="col-lg-2 control-label">库存</label>
                                        <div class="col-lg-10">
                                            <input type="text" class="form-control" id="stock" name="stock" placeholder="" value="${item.stock}">
                                        </div>
                                    </div>
                                    <c:if test="${item != null}">
                                        <div class="form-group">
                                            <label for="stock" class="col-lg-2 control-label"></label>
                                            <div class="col-lg-10">
                                                <img src="${path.IMAGE_PATH}/${path.FILE_PATH_PRODUCT}/${item.images}" width="70" height="100">
                                            </div>
                                        </div>
                                    </c:if>
                                    <div class="form-group">
                                        <label for="stock" class="col-lg-2 control-label">商品图片</label>
                                        <div class="col-lg-10">
                                            <input type="file" name="file" id="file"  onchange="imageCheck(this)"  accept="image/jpeg,image/x-png,image/gif">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                    <!-- 加载编辑器的容器 -->
                                    <script id="ueditor" name="details" type="text/plain"  ></script>
                                    </div>
                                    <input type="hidden" name="merchantId" value="${loginMerchant.merchantId}">
                                    <input type="hidden" name="itemId" value="${item.itemId}">
                                    <input type="hidden" name="images" value="${item.images}">
                                        <div class="form-group">
                                        <div class="col-lg-offset-5 col-lg-10">
                                            <button type="submit" class="btn btn-danger">保存</button>
                                            <button type="reset" class="btn btn-danger" id="reset">重置</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </section>
                    </div>
                    <div class="col-lg-3"></div>
                </div>
            </section>
        </section>
        <!--main content end-->
    </section>

<!-- js placed at the end of the document so the pages load faster -->
<script src="${pageContext.request.contextPath}/resources/merchant/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/resources/merchant/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/merchant/js/jquery.scrollTo.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/merchant/js/jquery.nicescroll.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/merchant/js/jquery-ui-1.9.2.custom.min.js"></script>
<!--custom switch-->
<script src="${pageContext.request.contextPath}/resources/merchant/js/bootstrap-switch.js"></script>
<!--custom tagsinput-->
<script src="${pageContext.request.contextPath}/resources/merchant/js/jquery.tagsinput.js"></script>
<!--custom checkbox & radio-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/merchant/js/ga.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/merchant/assets/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/merchant/assets/bootstrap-daterangepicker/date.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/merchant/assets/bootstrap-daterangepicker/daterangepicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/merchant/assets/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/merchant/assets/ckeditor/ckeditor.js"></script>
<!--common script for all pages-->
<script src="${pageContext.request.contextPath}/resources/merchant/js/common-scripts.js"></script>
<!--script for this page-->
<script src="${pageContext.request.contextPath}/resources/merchant/js/form-component.js"></script>
<!--表单验证插件-->
<script src="${pageContext.request.contextPath}/resources/theme/util/jquery.validate.js" type="text/javascript"></script>
<!--导入自定义的验证规则-->
<script src="${pageContext.request.contextPath}/resources/theme/util/validate-methods.js" type="text/javascript"></script>
<!-- 弹窗插件 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/dialog/css/animate.min.css"/> <!-- 动画效果 -->
<script src="${pageContext.request.contextPath}/resources/dialog/js/jquery.hDialog.min.js"></script>
<script type="text/javascript">

    // 验证添加商品表单
    $(document).ready(function () {
        $("#add").validate({
            rules: {
                itemTitle: {
                    required: true,
                    maxlength: 35,
                },
                categorySelect: {
                    required: true,
                },
                price: {
                    required: true,
                    isPrice: true,
                },
                stock: {
                    required: true,
                    isStock: true,
                },
            },
            messages: {
                itemTitle: {
                    required: "商品标题不可为空",
                    maxlength: "标题不可超过35个字符",
                },
                categorySelect: {
                    required: "请选择一级类目",
                },
                price: {
                    required: "请填写价格",
                },
                stock: {
                    required: "请填写商品库存",
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

    // 异步获取二级类目
    function category() {
        // 先清空二级已加载的二级目录
        $("#categoryTwo").empty();
        // 在加上多删的option
        $("#categoryTwo").append('<option value="">请选择二级类目</option>');
        // 获取一级类目选中的项
        var option = $("#categorySelect option:selected");
        // 获取项中的值
        var categoryOneId = option.val();
        // 如果value值不为"",则ajax获取二级类目
        if (categoryOneId != "") {
            // 将option的文本值设置到隐藏域，传到后台
            $("#categoryOne").val(option.text());
            // 根据一级类目的id查询出对应的二级类目
            $.ajax({
                type:'post',
                url:'${pageContext.request.contextPath }/merchant/selectCategoryTwo',
                data:{"categoryOneId":categoryOneId},
                success:function(data){//返回json结果
                    // 遍历json数据，将值加到二级类目下拉框
                    $(data).each(function (index,category) {
                        $("#categoryTwo").append('<option value="' + category.name +'">' + category.name + '</option>');
                    })
                }

            });
        }
    }

    //获取项目路径，供js文件中使用
    function getRootPath() {
        var pathName = window.location.pathname.substring(1);
        var webName = pathName == '' ? '' : pathName.substring(0, pathName.indexOf('/'));
        return window.location.protocol + '//' + window.location.host + '/' + webName + '/';
    }

    // 验证上传图片
    var imageCheck = function(o) {
        if (o.files.length <= 0) return;    //点击取消时，直接退出
        var f = o.files[0];
        //检查类型、大小等信息，出错则退出，文件不会上传
        if (f.type != 'image/jpeg' || f.size > 2000*1024) {
            o.value = '';                   //保证重复选择某个文件时触发 onchange 事件
            $.tooltip('图片大小最大为2M', 2000);
            return;
        }
    }
    
    function formUpload() {
        var form = new FormData(document.getElementById("add"));
        $.ajax({
            type:'post',
            url:'${pageContext.request.contextPath }/merchant/saveItem',
            data:form,
            processData:false,
            contentType:false,
            success:function(data){//返回json结果
                if (data.success == true) {
                    $.tooltip(data.message, 3500, true);
                    // 添加成功，请空表单,商品详情清除不了
                    $("#reset").click();
                }
                if (data.success == false) {
                    $.tooltip(data.message, 3000);
                }
            }
        });
    }
</script>
</body>
</html>

