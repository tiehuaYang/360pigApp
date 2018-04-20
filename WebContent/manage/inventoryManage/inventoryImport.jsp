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
<style>
.table th,.table td {
	text-align: center;
	vertical-align: middle !important ；//垂直居中
}

.table>thead>tr>th,.table>tbody>tr>th,.table>tfoot>tr>th,.table>thead>tr>td,.table>tbody>tr>td,.table>tfoot>tr>td
	{
	vertical-align: middle !important ；//垂直居中
}
</style>

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
						<li><a href="#">库存管理</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">库存盘点</li>
					</ol>
<%-- 					<jsp:include page="../common/searchBar.jsp" flush="true">
						<jsp:param name="defaultBtn" value="搜库存" />
						<jsp:param name="placeholder" value="请输入商品名称/编码/关键字" />
						<jsp:param name="searchType" value="4" />
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
														<p class="anchor">1.导入</p>
															<p class="description">根据模版导入库存盘点数据</p></a></li>
													<li><a href="#" data-toggle="tab"><i
															class="fa fa-th-list"></i>
														<p class="anchor">2.预览</p>
															<p class="description">导入的数据概览</p></a></li>
													<li><a href="#tab4-wizard-custom-circle"
														data-toggle="tab"><i class="glyphicon glyphicon-check"></i>
														<p class="anchor">3.完成导入</p>
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
													<p>3、表格中库存数量以实际库存为准</p>
													<p>4、若没有填写盘点数量，则默认盘点数量与实际数量一致</p>
													<p>5、请不要更改或删除盘点数量以外的数据，以免导入发生错误</p>
												</div>
												<h6 class="mbxl strong">
													<strong>请选择需要导出数据的仓库</strong>
												</h6>
												<div class=" text-right pull-left">
													仓库&nbsp;
													<select id="storeId" name="storeId" class="form-control input-sm input-inline" >
														<c:forEach var="storeVO" items="${obj.storeList}" varStatus="status">
															<option value="${storeVO.storeId}">${storeVO.storeName}</option>
														</c:forEach>
													</select>&nbsp;&nbsp;&nbsp;
													<a href="#" data-toggle="dropdown" class="btn btn-warning btn-xs dropdown-toggle" style="height: 30px; padding: 2px 12px;" onclick="inventoryDownload()"> 
														<i class="fa fa-download"></i>导出成Excel</a>
												</div>
												<br> <br> <br>
												<div class="clearfix"></div>
												<h6 class="mbxl">
													<strong>请选择需要导入的Excel文件</strong>
												</h6>
												<div class="row">
													<form action="${contextPath}/manage/importInventory"
														id="importForm" enctype="multipart/form-data"
														method="post">
														<input type="hidden" name="Inventory" value="inventory.xml">
														<div class="col-md-12">
															<div class="col-md-4" style="margin-left: -15px">
																<div class="input-icon right">
																	<i class="fa fa-folder-open"></i> <input type="file"
																		id="excelfile" name="file" class="form-control" style="padding-bottom:30px;">
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
    	activeMenu("inventoryManageMenu","inventoryUL","ckStorage");
    	
        var result = "${obj.result}";
        var message = "${obj.msg}";
        if(result=='OK'){
        	toastr['success'](message, "");
        }
        else if(result=='FAIL'){
        	toastr['error'](message, "");
        }
        
    });
    
    function inventoryDownload(){
		
		var storeId = $("#storeId").val();
		var url = "${contextPath}/manage/inventoryDownload?storeId=" + storeId;
		window.location.href = encodeURI(encodeURI(url));
	}
    
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
    	        'onTabClick': function(tab, navigation, index) {
    	            // select id of current tab content
    	            var $id = tab.find("a").attr("href");
    	            var $approved = 1;
    	            // Check all input validation
    	            
    	            if ($approved !== 1) return false;
    	            // Add class visited to style css
    	            if (tab.attr("class")=="visited"){
    	                tab.removeClass("visited");
    	            } else {
    	                tab.addClass("visited");
    	            }
    	        },
    	        'tabClass': 'bwizard-steps-o','nextSelector': '.button-next', 'previousSelector': '.button-previous'
    	    });
    	});
    	
    	 

</script>
</body>

</html>