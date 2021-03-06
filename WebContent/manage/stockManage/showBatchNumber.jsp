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
</head>

<body class = "${theme }" >

	<!--END TITLE & BREADCRUMB PAGE-->
	<!--BEGIN CONTENT-->
	<div class="page-content">
		<div id="table-advanced" class="row">
			<div class="col-lg-12">
				<ul id="tableadvancedTab" class="nav nav-tabs">
					<li class="active"><a href="#table-sticky-tab"
						data-toggle="tab">&nbsp;批次号列表&nbsp;</a></li>
					
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
													</select>&nbsp;记录 | 共有 ${obj.recordCount } 条记录 
												</div>
											</div>

										</div>
									</div>

									<div class="portlet-body">
										
										<form method="get">
											<table
												class="table table-hover table-striped table-bordered table-advanced tablesorter tb-sticky-header">
												<thead class="success">
													<tr>
														<th width="5%">选择框</th>
														<th width="10%">批次号</th>
													

													</tr>
												</thead>
												<tbody>
													
													<c:forEach var="batchNumberVO" items="${obj.batchNumberList}"
														varStatus="status">
														
															<tr>
																<td>
																<input type="radio" name="batchs"
																  batchNumber="${batchNumberVO.batchNumber}" price="${batchNumberVO.batchPrice}"/></td>
																<td>${batchNumberVO.batchNumber}</td>
															



															</tr>
														
													</c:forEach>
												</tbody>
											</table>
											<div class="col-lg-6 pull-right">
												<button type="button" name="确定" class="btn btn-primary"
													onclick="ev_return('${obj.id}')">
													&nbsp;&nbsp;确定&nbsp;&nbsp;</button>
												&nbsp;&nbsp;
												<button type="button" name="取消" data-dismiss="modal"
													class="btn btn-default" onclick=window.close()>
													&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
											</div>
										</form>
									</div>
									<div class="col-lg-6">
										<div class="pagination-panel">
											&nbsp; <a href="#"
												onclick="jumpPage('${obj.currentPage - 1}')"
												class="btn btn-sm btn-success btn-prev gw-prev"
												<c:if test="${obj.currentPage == 1}">disabled </c:if>><i
												class="fa fa-angle-left"></i></a>&nbsp; <input id="currentPage"
												type="text" maxlenght="5" value="${obj.currentPage}"
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
 <script src="${contextPath}/manage/js/jquery-2.1.1.js"></script>
    <script src="${contextPath}/manage/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="${contextPath}/manage/js/jquery-ui.min.js"></script>
	<!--LOADING SCRIPTS FOR PAGE-->
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
								

								var result = "${obj.result}";
								var message = "${obj.msg}";
								if (result == 'OK') {
									toastr['success'](message, "");
								} else if (result == 'FAIL') {
									toastr['error'](message, "");
								}

							});

					function ev_return(id){
						
					
			    		$('input[name="batchs"]').each(function(){
			    			
			    			if( $(this).is(":checked")){
			    			
			    				
			    				if(navigator.userAgent.indexOf("Chrome") >0 ){
			    					
			    					
			    					//打开普通窗口的方式，通过调用父页面定义的js方法将值作为参数传递
			    					window.opener.document.getElementById(id).value=id;
			    					
			    					window.opener.document.getElementById(id).children[1].innerHTML="<div style='display:inline'><input id='batchNumber' name='batchNumber'  type='text'  class='form-control' value='"+$(this).attr('batchNumber')+"' style='float:left;display:inline;width:65%'/></div><a href='#' style='float:left;margin-top:6px' onclick='ev_batchs(this);'>&nbsp;&nbsp;<i class='fa fa-share-square-o'></i>从历史中选取</a>";
			    					
			    					window.opener.document.getElementById(id).children[3].innerHTML="<input type='text' value='"+$(this).attr('price')+"' class='form-control' disabled/><input id='price' name='price' type='hidden' value='"+$(this).attr('price')+"' class='form-control'/>";
			    	    			//window.opener.document.getElementById("storageNums").value=$(this).attr("storageNums");
									
									/*window.opener.document.getElementById("unitName").value=$(this).attr("unitName");
									window.opener.document.getElementById("mPrice").value=$(this).attr("mPrice"); */
			    	    			window.close();
			    	    		}
			    	    		else{
			    	    			var category = new Object();
			    	    			category.supplyId=$(this).attr("supplyId");
			    	    			
									
			    	    			//模态窗口的方式，给模态窗口返回父页面 赋值，父页面接收
			    	    			window.returnValue = category;
			    	    			window.close();
			    	    		}
			    			}
				         });
			    	}
			    	
					var search = function() {
						window.location.reload();
					};

					
				
			      
					
					function jumpPage(currentPage) {
						
						var pageSize = $("select[name=pageSize] option:selected").val();
						var url = "${contextPath}/manage/showPicGoodList?currentPage="+ currentPage + "&pageSize=" + pageSize;
						window.location.href = encodeURI(encodeURI(url));
					}
					function showSelect(currentPage) {
						var goodsName = $("#goodsName").val();
						var companyName=$("#companyName").val();
					
						var pageSize = $(
								"select[name=pageSize] option:selected").val();
						var url = "${contextPath}/manage/searchPicGoods?currentPage="
								+ currentPage
								+ "&pageSize="
								+ pageSize
								+ "&companyName="+companyName+"&goodsName=" + goodsName;
						window.location.href = encodeURI(encodeURI(url));
					}
</script>
</body>

</html>