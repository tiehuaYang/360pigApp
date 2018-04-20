<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>

<link type="text/css" rel="stylesheet"
	href="${contextPath}/manage/vendors/jquery-bootstrap-wizard/custom.css">
<link type="text/css" rel="stylesheet"
	href="${contextPath}/manage/vendors/jquery-steps/css/jquery.steps.css">

</head>

<body class = "${theme }" >
	<div>
		<!--BEGIN BACK TO TOP-->
		<a id="totop" href="#"><i class="fa fa-angle-up"></i></a>
		<!--END BACK TO TOP-->
		<!--BEGIN TOPBAR-->
		<%@ include file="../include/banner.jsp"%>
		<!--END TOPBAR-->
		<div id="wrapper">
			<!--BEGIN SIDEBAR MENU-->
			<%@ include file="../include/menu.jsp"%>
			<!--END SIDEBAR MENU-->
			<!--BEGIN PAGE WRAPPER-->
			<div id="page-wrapper">
				<!--BEGIN TITLE & BREADCRUMB PAGE-->
				<div id="title-breadcrumb-option-demo" class="page-title-breadcrumb">
					<ol class="breadcrumb page-breadcrumb pull-left">
						<li><i class="fa fa-home"></i>&nbsp;<a
							href="${contextPath}/manage/showIndex">首页</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li><a href="#">商品管理</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">商品导入</li>
					</ol>
<%-- 					<jsp:include page="../common/searchBar.jsp" flush="true">
						<jsp:param name="defaultBtn" value="搜订货单" />
						<jsp:param name="placeholder" value="请输入订货单号或客户名称" />
						<jsp:param name="searchType" value="1" />
					</jsp:include> --%>
					<div class="clearfix"></div>
				</div>
				<!--END TITLE & BREADCRUMB PAGE-->
				<!--BEGIN 弹出的MODAL框-->
				<!--END MODAL CONFIG PORTLET-->

				<div class="page-content">
					<div class="row">
						<div class="col-lg-12">
							<div class="portlet box portlet-green">
								<div class="portlet-body">
									<div id="rootwizard-custom-circle">
										<div class="navbar">
											<div class="navbar-inner">
												<ul>
													<li><a href="#tab1-wizard-custom-circle"
														data-toggle="tab"><i class="fa fa-download"></i>
														<p class="anchor">1. 导入</p>
															<p class="description">根据模版导入商品数据</p></a></li>
													
													<li class="visited"><a id="finish" href="#tab3-wizard-custom-circle"
														data-toggle="tab"><i class="glyphicon glyphicon-check"></i>
														<p class="anchor">2. 完成导入</p>
															<p class="description">恭喜您！数据已成功导入！</p></a></li>
												</ul>
											</div>
										</div>
										<div id="bar" class="progress active">
											<div class="bar progress-bar progress-bar-primary"></div>
										</div>
										<div class="tab-content">
											<div id="tab1-wizard-custom-circle" class="tab-pane">
												<div class="note note-info">
													<h4 class="box-heading">注意事项</h4>
													<p>1、导入文件仅支持CSV、XLS、XLXS格式，大小不超过2M，数据不超过1万行</p>
													<p>2、导入文件不能包含“合并单元格”，否则无法导入</p>
													</p>
												</div>
												<h6 class="mbxl strong">
													<strong>请按照数据模板的格式准备导入数据，模板中的表头名称不可更改，表头行不能删除</strong>
												</h6>
												<div class=" text-right pull-left">
													<a type="button" class="btn btn-default"
														href="${contextPath}/download/goodTemplate.xls"
														download="牧管家商品导入模版.xls"> <i class="fa fa-download"></i>
														下载模版
													</a>
												</div>
												<br> <br> <br>
												<div class="clearfix"></div>
												<h6 class="mbxl">
													<strong>请选择需要导入的Excel文件</strong>
												</h6>
												<div class="row">
													<form action="${contextPath}/manage/importGood"
														id="importForm" enctype="multipart/form-data"
														method="post">
														<input type="hidden" name="Good" value="good.xml">
														<div class="col-md-12">
															<div class="col-md-4" style="margin-left: -15px">
																<div class="input-icon right">
																	<i class="fa fa-folder-open"></i> <input type="file"
																		id="excelfile" name="file" class="form-control">
																</div>
															</div>
															<div class="col-md-3">
																<button type="button" class="btn btn-info"
																	onclick="CheckExcel()">
																	<i class="fa fa-cloud-upload"></i>
																	&nbsp;&nbsp;&nbsp;上传&nbsp;&nbsp;&nbsp;
																</button>
															</div>
														</div>
													</form>
												</div>
												<br /> <br /> <br /> <br />
											</div>
											
											<div id="tab3-wizard-custom-circle" class="tab-pane fadeIn">
												<h3 class="mbxl">恭喜您!</h3>
												<p>本次商品的数据已经成功导入</p>
												<p>请进入商品列表查看最新的商品数据！</p>
												<br> <br> <a type="button"
													href="${contextPath}/manage/showGoods"
													class="btn btn-default mlm">返回商品列表 <i
													class="fa fa-mail-reply-all mlx"></i>
												</a>
											</div>
											<div class="action text-right">
												<button type="button" name="finish" value="finish"
													class="btn btn-info button-previous">
													
												</button>
												
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!--END CONTENT-->
			</div>
			<!--BEGIN FOOTER-->
			<%@ include file="../include/footer.jsp"%>
			<!--END FOOTER-->
			<script
				src="${contextPath}/manage/vendors/jquery-validate/jquery.validate.min.js"></script>
			<script
				src="${contextPath}/manage/vendors/jquery-steps/js/jquery.steps.min.js"></script>
			<script
				src="${contextPath}/manage/vendors/jquery-bootstrap-wizard/jquery.bootstrap.wizard.min.js"></script>

			<script type="text/javascript">
    $(document).ready(function(){
    	activeMenu("goodManage","goodUL", "goodMenu");
    	
        var result = "${obj.result}";
        var message = "${obj.msg}";
        if(result=='OK'){
        	toastr['success'](message, "");
        }
        else if(result=='FAIL'){
        	toastr['error'](message, "");
        }
        
    });
    
    function CheckExcel() {
    	var mime = document.getElementById('excelfile').value;
      	mime = mime.toLowerCase().substr(mime.lastIndexOf("."));
      	if (!(mime == ".xls")) {
       		alert("请导入正确的EXCEL文件，仅支持xls格式!");
       	return false;
      }
      	document.getElementById("importForm").submit();
     }
    
        var search = function(){
        	window.location.reload();
    	};
    	
    	$(function () {
    	    /************ #rootwizard-custom-circle ***********/
    	    $('#rootwizard-custom-circle').bootstrapWizard({
    	        onTabShow: function(tab, navigation, index) {
    	            var $total = navigation.find('li').length;
    	            var $current = index+1;
    	            var $percent = ($current/$total) * 100;
    	            $('#rootwizard-custom-circle').find('.bar').css({width:$percent+'%'});
    	        },
    	        'onNext': function(tab, navigation, index) {

    	            // select id of current tab content
    	            var $id = tab.find("a").attr("href");
    	            var $approved = 1;
    	            // Check all input validation
    	            	
    	            if ($approved !== 1) return false;
    	        },
    	        'tabClass': 'bwizard-steps-o','nextSelector': '.button-next', 'previousSelector': '.button-previous'
    	    });
    	    
    	    $("#finish").click();

    	});
    	
    	
    	
    	 

</script>
</body>

</html>