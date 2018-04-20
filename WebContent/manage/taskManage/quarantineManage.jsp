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
						<li><a href="#">统计报表</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">检疫明细</li>
					</ol>
<%-- 					<jsp:include page="../common/searchBar.jsp" flush="true">
						<jsp:param name="defaultBtn" value="搜库存" />
						<jsp:param name="placeholder" value="请输入物料名称/编码/关键字" />
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
											<label for="exportKeyword1" class="control-label col-md-3">编码</label>
											<div class="col-md-7">
												<input type="text" id="exportKeyword1" name="exportKeyword1" class="form-control" />
											</div>
										</div>
										<div class="form-group">
											<label for="exportKeyword2" class="control-label col-md-3">物料</label>
											<div class="col-md-7">
												<input type="text" id="exportKeyword2" name="exportKeyword2" class="form-control" />
											</div>
										</div>
										<div class="form-group">
											<label for="exportKeyword3" class="control-label col-md-3">单号</label>
											<div class="col-md-7">
												<input type="text" id="exportKeyword3" name="exportKeyword3" class="form-control" />
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
									data-toggle="tab">检疫明细</a></li>
							</ul>
							<div id="tableadvancedTabContent" class="tab-content">
								<div id="table-sorter-tab" class="tab-pane fade in active">
									<div class="row">
										<div class="col-lg-12">
											<div class="portlet box">
												<div class="portlet-header">
													<div class="row">
														<div class="col-lg-10">
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
																<!-- 筛选：
	                                                            <select name="selectKeyword" class="form-control input-xsmall input-sm input-inline" onchange="">
	                                                            	<option value="" selected="selected" ></option>
	                                                            	<option value="1" >入库</option>
	                                                                <option value="0" >出库</option>
	                                                            </select>&nbsp; -->
																从&nbsp;<input id="startDate" readonly="readonly" type="text" name="startDate" placeholder="请选择日期" value="${obj.startDate}"
																	class="form-control input-sm input-inline" style="width: 120px;" /><img src="images/calendar.png" style="width:15px;height:15px;margin-left:-17px;margin-top:-3px;" />
																至&nbsp;<input id="endDate" readonly="readonly" type="text" name="endDate" placeholder="请选择日期" value="${obj.endDate}"
																	class="form-control input-sm input-inline" style="width: 120px;" /><img src="images/calendar.png" style="width:15px;height:15px;margin-left:-17px;margin-top:-3px;" />
																<input id="quarantineCode" type="text" name="quarantineCode" placeholder="单号" value="${obj.quarantineCode}"
																	class="form-control input-sm input-inline" style="width: 100px;" /> 
																<input type="button" class="btn btn-info btn-xs f4"
																	style="height: 30px; padding: 2px 12px;"
																	onclick="showSelect('${obj.currentPage}')" value="查询" />
															</div>
														</div>
														<div class="actions">
															<a href="${contextPath}/manage/exportQuarantineAll?startDate=${obj.startDate}&quarantineCode=${obj.quarantineCode}&endDate=${obj.endDate}"
																class="btn btn-info btn-xs" style="margin-right:10px;">&nbsp;导出成Excel
															</a>&nbsp; 
															<!-- <div class="btn-group"><a href="#" data-toggle="dropdown" class="btn btn-warning btn-xs dropdown-toggle"><i class="fa fa-wrench"></i>&nbsp;更多操作</a>
				                                            <ul class="dropdown-menu pull-right">
				                                                <li><a href="#">导出成Excel</a>
				                                                </li>
				                                                <li><a href="#">导出成CSV</a>
				                                                </li>
				                                                <li><a href="#">导出成XML</a>
				                                                </li>
				                                                <li class="divider"></li>
				                                                <li><a href="#">打印预览</a>
				                                                </li>
				                                            </ul>
				                                        </div> -->
														</div>
													</div>
												</div>
												<div class="portlet-body">
														<table class="table table-hover table-striped table-bordered table-advanced tablesorter tb-sticky-header">
															 <thead class="success">
															      <tr>
															         <th><input type="checkbox"/></th>
															           <th>养殖场</th>
															           <th>检疫单号</th>
															           <th>检疫日期</th>
															           <th>检疫头数</th>
															           <th>检疫项目</th>
															           <th>检疫方式</th>
															           <th>阳性头数</th>
															           <th>阴性头数</th>
															           <th>疑似头数</th>
															           <th>无效头数</th>
															           <th>检疫员</th>
															       </tr>
															  </thead>
															  <tbody class="twolist">
															     <c:forEach var="quarantineVO" items="${obj.quarantineList}" varStatus="status">
																      <tr>
																         <td><input type="checkbox"/></td>
																         <td>${quarantineVO.farmName}</td>
																         <td>${quarantineVO.quarantineCode}</td>
																         <td><fmt:formatDate value="${quarantineVO.quarantineTime}" pattern="yyyy-MM-dd"/></td>
																         <td>${quarantineVO.quarantineNum}</td>
																         <td>${quarantineVO.quarantineItems}</td>
																         <td>${quarantineVO.quarantineMode}</td>
																         <td>${quarantineVO.positiveQuarantineNum}</td>
																         <td>${quarantineVO.negativeQuarantineNum}</td>
																         <td>${quarantineVO.suspectedQuarantineNum}</td>
																         <td>${quarantineVO.invalidQuarantineNum}</td>
																         <td>${quarantineVO.quarantineOfficer}</td>
																      </tr>
															     </c:forEach>
															  </tbody>
														</table>
												</div>
												<div class="col-lg-6">
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
    	activeMenu("taskSum","taskSumUL","quarantineList");
		
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
		dateCell:"#startDate",
		format:"YYYY-MM-DD",
		isinitVal:false,
		isTime:true, 
		okfun:function(val){
				//alert(val);
		}
	})
	
	jeDate({
			dateCell:"#endDate",
			format:"YYYY-MM-DD",
			isinitVal:false,
			isTime:true, 
			okfun:function(val){
					//alert(val);
		}
	})   
        
        
        var reload = function(){
        	window.location.reload();
    	};
    	
    	
    	function jumpPage(currentPage){
    		var pageSize = $("select[name=pageSize] option:selected" ).val();
    		/* var goodsName = "${obj.goodsName}";
    		var goodsCode = "${obj.goodsCode}";
    		var billCode = "${obj.billCode}"; */
    		var url = "${contextPath}/manage/showQuarantineSum?currentPage=" + currentPage + "&pageSize=" + pageSize
			+ "&startDate=" + startDate+"&quarantineCode="+quarantineCode+"&endDate="+endDate;
        	window.location.href = url;
    	}
    	function showSelect(currentPage) {
			var startDate = $("#startDate").val();
			var quarantineCode=$("#quarantineCode").val();
			var endDate=$("#endDate").val();
			var pageSize = $(
					"select[name=pageSize] option:selected").val();
			var url = "${contextPath}/manage/showQuarantineSum?currentPage=" + currentPage + "&pageSize=" + pageSize
					+ "&startDate=" + startDate+"&quarantineCode="+quarantineCode+"&endDate="+endDate;
			window.location.href = url;
		}
    	
    	/* function orderDownload(){
    		var startDate = $("#exportStartDate").val();
    		var endDate = $("#exportEndDate").val();
    		var goodsCode = $("#exportKeyword1").val();
    		var goodsName = $("#exportKeyword2").val();
    		var billCode = $("#exportKeyword3").val();
    	    var url = "${contextPath}/manage/exportStorageAll?startDate=" + startDate + "&endDate=" + endDate + "&goodsCode=" + goodsCode + "&goodsName=" + goodsName + "&billCode=" + billCode;
    		
    		window.location.href = encodeURI(encodeURI(url));
    	}
    	
    	function showExport(){
    		$("#exportKeyword1").val($("#goodsCode").val());
    		$("#exportKeyword2").val($("#goodsName").val());
    		$("#exportKeyword3").val($("#billCode").val());
    	} */

</script>
</body>

</html>