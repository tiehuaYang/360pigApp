<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
<!--LOADING STYLESHEET FOR PAGE-->
<link type="text/css" rel="stylesheet"
	href="${contextPath}/manage/vendors/jquery-tablesorter/themes/blue/style-custom.css">
<link type="text/css" rel="stylesheet"
	href="${contextPath}/manage/vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.1.1.min.css">
</head>
<style>
.btn-warning {
margin-right:16px;
}
</style>

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
						<li class="active">盘点记录列表</li>
					</ol>
<%-- 					<jsp:include page="../common/searchBar.jsp" flush="true">
						<jsp:param name="defaultBtn" value="搜库存" />
						<jsp:param name="placeholder" value="请输入商品名称/编码/关键字" />
						<jsp:param name="searchType" value="4" />
					</jsp:include> --%>
					<div class="clearfix"></div>
				</div>
				<!--END TITLE & BREADCRUMB PAGE-->
				
				<div id="exportForm" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" data-dismiss="modal" aria-hidden="true"
									class="close">&times;</button>
								<h4 class="modal-title">选择导出数据的条件</h4>
							</div>
							<form id="exportedForm" class="form-horizontal" method="POST">
								<div class="modal-body">
									<div class="form">
										<div class="form-group">
											<label for="exportStartDate" class="control-label col-md-3">起始日期</label>
											<div class="col-md-7">
												<input type="text" id="exportStartDate" name="exportStartDate" autocomplete="off" placeholder="请选择时间" class="form-control" />
											</div>
										</div>
										<div class="form-group">
											<label for="exportEndDate" class="control-label col-md-3">终止日期</label>
											<div class="col-md-7">
												<input type="text" id="exportEndDate" name="exportEndDate" autocomplete="off" placeholder="请选择时间" class="form-control" />
											</div>
										</div>
										<div class="form-group">
											<label for="exportKeyword1" class="control-label col-md-3">盘点单号</label>
											<div class="col-md-7">
												<input type="text" id="exportKeyword1" name="exportKeyword1" class="form-control" />
											</div>
										</div>
										<br />
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" data-dismiss="modal" class="btn btn-info" onclick="orderDownload()">确认并导出Excel</button>
									<button type="button" data-dismiss="modal" class="btn btn-default">关闭</button>
								</div>
							</form>
						</div>
					</div>
				</div>

				<!--BEGIN CONTENT-->



				<div class="page-content">
					<div id="table-advanced" class="row">
						<div class="col-lg-12">
							<ul id="tableadvancedTab" class="nav nav-tabs">
								<li class="active"><a href="#table-sticky-tab"
									data-toggle="tab">出库单列表</a></li>
							</ul>
							<div id="tableadvancedTabContent" class="tab-content">
								<div id="table-sorter-tab" class="tab-pane fade in active">
									<div class="row">
										<div class="col-lg-12">
											<div class="portlet box">
												<div class="portlet-header">
													<div class="row">
														<div class="col-lg-8">
															<div class="pagination-panel">
																每次浏览&nbsp; <select name="pageSize"
																	class="form-control input-xsmall input-sm input-inline"
																	onchange="jumpPage('1')">
																	<option value="10"
																		<c:if test="${obj.pageSize == '10' }">selected="selected"</c:if>>10</option>
																	<option value="20"
																		<c:if test="${obj.pageSize == '20' }">selected="selected"</c:if>>20</option>
																	<option value="50"
																		<c:if test="${obj.pageSize == '50' }">selected="selected"</c:if>>50</option>
																	<option value="100"
																		<c:if test="${obj.pageSize == '100' }">selected="selected"</c:if>>100</option>
																</select>&nbsp;记录 | 共有 ${obj.recordCount } 条记录&nbsp;&nbsp;&nbsp;
																<input id="billCode" type="text" name="billCode" placeholder="盘点单号" class="form-control input-sm input-inline" style="width: 100px;" value="${obj.billCode}"/> 
																<input type="button" class="btn btn-info btn-xs f4" style="height: 30px; padding: 2px 12px;" onclick="showSelect('${obj.currentPage}')" value="查询" />
															</div>
														</div>
														<div class="actions">
															<a  href="${contextPath}/manage/checkInventory"
																class="btn btn-info btn-xs"> <i class="fa fa-refresh"></i>&nbsp;库存盘点
															</a>&nbsp;
															<div class="btn-group">
																<a href="#" data-toggle="dropdown"
																	class="btn btn-warning btn-xs dropdown-toggle"><i
																	class="fa fa-wrench"></i>&nbsp;更多操作</a>
																<ul class="dropdown-menu pull-right">
																	<li><a href="#" data-toggle="modal" data-target="#exportForm" onclick="showExport()">导出成Excel</a></li>
																	<!-- <li><a href="#">导出成CSV</a></li>
																	<li><a href="#">导出成XML</a></li>
																	<li class="divider"></li>
																	<li><a href="#">打印预览</a></li> -->
																</ul>
															</div>
														</div>
													</div>
												</div>
												<div class="portlet-body">
													<table
														class="table table-hover table-striped table-bordered table-advanced tablesorter tb-sticky-header">
														<thead class="success">
															<tr>
																<th width="20%">单号</th>
																<th width="20%">日期</th>
																<th width="20%">类型</th>
																<th width="20%">制单人</th>
																<th>操作</th>
															</tr>
														</thead>
														<tbody>
															<c:forEach var="ckStorageVO"
																items="${obj.ckStorageList}" varStatus="status">
																<%-- <form id="${inventoryVO.goodId.replace('-','')}"> --%>
																<tr>
																	<td>${ckStorageVO.billCode}</td>
																	<td><fmt:formatDate
																			value="${ckStorageVO.createTime}" type="both" /></td>
																	<td>${ckStorageVO.storageType}</td>
																	<td>${ckStorageVO.billMaker}</td>
																	<td>
																		<button type="button" class="btn btn-default btn-xs"
																			onclick="showBill('${ckStorageVO.billId}')">
																			<i class="fa fa-edit"></i>&nbsp; 查看明细
																		</button>
																	</td>
																</tr>
															</c:forEach>
														</tbody>
													</table>
												</div>
												<div class="col-lg-6" style="margin-left:-7px;">
													<div class="pagination-panel">
														&nbsp; <a href="#"
															onclick="jumpPage('${obj.currentPage - 1}')"
															class="btn btn-sm btn-success btn-prev gw-prev"
															<c:if test="${obj.currentPage == 1}">disabled </c:if>><i
															class="fa fa-angle-left"></i></a>&nbsp; <input
															id="currentPage" type="text" maxlenght="5"
															value="${obj.currentPage}"
															class="pagination-panel-input form-control input-mini input-inline input-sm text-center gw-page"
															onchange="goPage('${obj.currentPage}','${obj.pageCount}')" />&nbsp;
														<a href="#" onclick="jumpPage('${obj.currentPage + 1}')"
															class="btn btn-sm btn-success btn-prev gw-next"
															<c:if test="${obj.currentPage >= obj.pageCount}">disabled </c:if>>
															<i class="fa fa-angle-right"></i>
														</a>&nbsp; 共有 ${obj.pageCount} 页 | 合计 ${obj.recordCount } 条记录
													</div>
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
				<!--END PAGE WRAPPER-->

				<!--LOADING SCRIPTS FOR PAGE-->
				<script
					src="${contextPath}/manage/vendors/jquery-tablesorter/jquery.tablesorter.js"></script>
				<script src="${contextPath}/manage/js/table-advanced.js"></script>
				<script
					src="${contextPath}/manage/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
				<script src="${contextPath}/manage/js/ui-progressbars.js"></script>
				<!--用于分页-->
				<script src="${contextPath}/manage/js/page/bootstrap-paginator.js"></script>
				<script src="${contextPath}/manage/js/page/jquery.pagination.js"></script>
				
				<!--日历控件-->
				<script type="text/javascript" src="${contextPath}/manage/js/calendarJs/jedate.js"></script>

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
    
    jeDate({
		dateCell:"#exportStartDate",
		format:"YYYY-MM-DD",
		isinitVal:false,
		isTime:true, 
		okfun:function(val){
				//alert(val);
		}
	})
	
	jeDate({
			dateCell:"#exportEndDate",
			format:"YYYY-MM-DD",
			isinitVal:false,
			isTime:true, 
			okfun:function(val){
					//alert(val);
		}
	})
    
    function edit(tdId,val1,val2){
    	//$("#saveBtn").show();
        document.getElementById(tdId).innerHTML = "<input type='text' id='" + tdId.substr(0,8) + "' name='maxQuantity' style='width:100%' value='"+ val1 +"'>";
        document.getElementById(tdId.toUpperCase()).innerHTML = "<input type='text' id='" + tdId.substr(0,16) + "' name='minQuantity' style='width:100%' value='"+ val2 +"'>";
    }
    
        function delGood(id){
        	if(window.confirm("确定要删除这条记录吗？")){
        	  var url = "${contextPath}/manage/delGood?goodId="+id;
        	    common_ajax(url,function(data){
        	    	if(data.result=='OK'){
           	    		toastr['success']("删除成功!", "");
             	        setTimeout(function(){
             	        	reload();
             	        },600);
           	    	}
             	   else{
             		  toastr['error'](data.msg, "");
                    }     
    		  });
        	}
        }
        function showGood(id){
        	var url = "${contextPath}/manage/editGood?goodId="+id;
        	window.location.href = url;
        }    
        
        
        var reload = function(){
        	window.location.reload();
    	};
    	
    	function showBill(billId){
    		var url = "${contextPath}/manage/showBill?billId="+billId;
        	window.location.href = url;
    	}
    	
    	function jumpPage(currentPage){
    		var pageSize = $("select[name=pageSize] option:selected" ).val();
    		var keyword = "${obj.keyword}";
    		var billCode = "${obj.billCode}"
    		var url = "${contextPath}/manage/ckStorage?currentPage=" + currentPage + "&pageSize=" + pageSize +  "&keyword=" + keyword +"&billCode=" + billCode;
        	window.location.href = url;
    	}
        
    	function showSelect(currentPage) {
			var billCode = $("#billCode").val();
			var pageSize = $(
					"select[name=pageSize] option:selected").val();
			var url = "${contextPath}/manage/ckStorage?currentPage=" + currentPage + "&pageSize="+ pageSize + "&billCode=" + billCode;
			window.location.href = url;
		}
    	
    	function orderDownload(){
    		var billCode = $("#exportKeyword1").val();
    		var startDate = $("#exportStartDate").val();
    		var endDate = $("#exportEndDate").val();
    	    var url = "${contextPath}/manage/exportCkStorage?billCode=" + billCode + "&startDate=" + startDate + "&endDate=" + endDate;
    		
    		window.location.href = encodeURI(encodeURI(url));
    	}
    	
    	function showExport(){
    		$("#exportKeyword1").val($("#billCode").val());
    	}

</script>
</body>

</html>