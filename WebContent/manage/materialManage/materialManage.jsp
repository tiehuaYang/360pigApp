<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
						<li><i class="fa fa-home"></i>&nbsp;<a href="index.jsp">首页</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li><a href="#">物料管理</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">物料列表</li>
					</ol>

					<div class="clearfix"></div>
				</div>
				<!--END TITLE & BREADCRUMB PAGE-->

				<!--BEGIN CONTENT-->
				<div class="page-content">
					<div id="table-advanced" class="row">
						<div class="col-lg-12">
							<ul id="tableadvancedTab" class="nav nav-tabs">
								<li class="active"><a href="#table-sticky-tab"
									data-toggle="tab">物料列表</a></li>
							</ul>
							<div id="tableadvancedTabContent" class="tab-content">
								<div id="table-sorter-tab" class="tab-pane fade in active">
									<div class="row">
										<div class="col-lg-12">
											<div class="portlet box">
												<div class="portlet-header">
													<div class="row">
														<div class="col-lg-6">
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
																</select>&nbsp;记录 | 共有 ${obj.recordCount } 条记录 <input
																	id="materialName" type="text" name="materialName"
																	placeholder="物料名称"
																	class="form-control input-sm input-inline"
																	style="width: 100px;" value="${obj.materialName }" /> <input type="button"
																	class="btn btn-info btn-xs"
																	style="height: 30px; padding: 2px 12px;"
																	onclick="showSelect('${obj.currentPage}')" value="查询" />
															</div>
														</div>
														<div class="actions">
															<a href="${contextPath}/manage/editMaterial"
																class="btn btn-info btn-xs"> <i class="fa fa-plus"></i>&nbsp;新增物料
															</a>&nbsp;
															<div class="btn-group">
																<a href="#" data-toggle="dropdown"
																	class="btn btn-warning btn-xs dropdown-toggle"><i
																	class="fa fa-wrench"></i>&nbsp;更多操作</a>
																<ul class="dropdown-menu pull-right">
																	<li><a href="#">导出成Excel</a></li>
																	<li><a href="#">导出成CSV</a></li>
																	<li><a href="#">导出成XML</a></li>
																	<li class="divider"></li>
																	<li><a href="#">打印预览</a></li>
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
																<th width="10%">物料编号</th>

																<th width="10%">物料名称</th>
																<th width="10%">单位</th>
																<th width="10%">物料来源</th>
																<th width="10%">物料信息</th>
																<th width="10%">备注</th>
																<th width="10%">操作</th>
															</tr>
														</thead>
														<tbody>
															<c:forEach var="materialVO" items="${obj.materialList}"
																varStatus="status">
															
																<tr>

																	<td>${materialVO.materialCode }</td>

																	<td>${materialVO.materialName}</td>
																	<td>${materialVO.unit}</td>
																	<td>${materialVO.materialSource}</td>
																	<td>${materialVO.materialInfo}</td>
																	<td>${materialVO.remark}</td>


																	<td>
																		<button type="button" class="btn btn-default btn-xs"
																			onclick="showMaterial('${materialVO.materialId}')">
																			<i class="fa fa-edit"></i>&nbsp;编辑
																		</button>
																		<button type="button" class="btn btn-danger btn-xs"
																			onclick="delMaterial('${materialVO.materialId}')">
																			<i class="fa fa-trash-o"></i>&nbsp;删除
																		</button>
																	</td>
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

				<script type="text/javascript">
    $(document).ready(function(){
		activeMenu("materialManage","materialUL","materialMenu");
		
        var result = "${obj.result}";
        var message = "${obj.msg}";
        if(result=='OK'){
        	toastr['success'](message, "");
        }
        else if(result=='FAIL'){
        	toastr['error'](message, "");
        }
        
    });
    
        
        function delMaterial(id){
        	if(window.confirm("确定要删除这条记录吗？")){
        	  var url = "${contextPath}/manage/delMaterial?materialId="+id;
        	    common_ajax(url,function(data){
        	    	toastr['success']("删除成功", "");
          	        setTimeout(function(){
          	        	search();
          	        },600);
    		  });
        	}
        }
        function showMaterial(id){
        	var url = "${contextPath}/manage/editMaterial?materialId="+id;
        	window.location.href = url;
        }    
        
        
        var search = function(){
        	window.location.reload();
    	};
    	
    	/* function doSearch(caseNum){
        	var caseWord = ["搜商品&nbsp;", "搜订货单&nbsp;", "搜退货单&nbsp;", "搜客户&nbsp;" ,"搜库存&nbsp;"];
        	document.getElementById("searchBtn").innerHTML = caseWord[caseNum] + "<span class='caret'></span>";
        	$("#caseOfSearch").val(caseNum);
        }
    	
    	function showSearch(currentPage){
    		var pageSize = $("select[name=pageSize] option:selected" ).val();
    		var caseOfSearch = $("#caseOfSearch").val();
    		//alert(caseOfSearch);
    		var keyword = $("#keyword").val();
    		var url = "";
    		if(caseOfSearch == 0 ){
    			url = "${contextPath}/manage/showGoods?currentPage="+currentPage +"&pageSize=" + pageSize + "&keyword=" + keyword;
    		}else if(caseOfSearch == 4){
    			url = "${contextPath}/manage/showInventory?currentPage="+currentPage +"&pageSize=" + pageSize + "&keyword=" + keyword;
    		}
        	window.location.href = encodeURI(encodeURI(url)); 
    	}  */
    	
    	function jumpPage(currentPage){
    		var pageSize = $("select[name=pageSize] option:selected" ).val();
    		var materialName = $("#materialName").val();
    		var keyword = "${obj.keyword}";
    		//alert(keyword);
    		var url = "${contextPath}/manage/showMaterial?currentPage="+currentPage +"&pageSize=" + pageSize+ "&materialName=" + materialName;
        	window.location.href = encodeURI(encodeURI(url));
    	}
    	function showSelect() {
    		var currentPage=1;
			var materialName = $("#materialName").val();
			var pageSize = $(
					"select[name=pageSize] option:selected").val();
			var url = "${contextPath}/manage/showMaterial?currentPage="
					+ currentPage
					+ "&pageSize="
					+ pageSize
					+ "&materialName=" + materialName;
			window.location.href =encodeURI(encodeURI(url));
		}

</script>
</body>

</html>