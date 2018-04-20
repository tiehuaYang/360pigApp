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
						<li><i class="fa fa-home"></i>&nbsp;<a
							href="${contextPath}/manage/showIndex">首页</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li><a href="#">库存管理</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">物料库存</li>
					</ol>
<%-- 					<jsp:include page="../common/searchBar.jsp" flush="true">
						<jsp:param name="defaultBtn" value="搜库存" />
						<jsp:param name="placeholder" value="请输入物料名称/编码/关键字" />
						<jsp:param name="searchType" value="5" />
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
											<label for="exportKeyword1" class="control-label col-md-3">物料编码</label>
											<div class="col-md-7">
												<input type="text" id="exportKeyword1" name="exportKeyword1" class="form-control" />
											</div>
										</div>
										<div class="form-group">
											<label for="exportKeyword2" class="control-label col-md-3">物料名称</label>
											<div class="col-md-7">
												<input type="text" id="exportKeyword2" name="exportKeyword2" class="form-control" />
											</div>
										</div>
										<div class="form-group">
											<label for="exportStoreId" class="control-label col-md-3">仓库</label>
											<div class="col-md-7">
												<select id="exportStoreId" name="exportStoreId" class="form-control">
											    	<option value="">全部</option>
													<c:forEach var="storeVO" items="${obj.storeList}" varStatus="status">
												  		<option value="${storeVO.storeId}">${storeVO.storeName}</option>
													</c:forEach>
											  	</select>
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
									data-toggle="tab">库存列表</a></li>
							</ul>
							<div id="tableadvancedTabContent" class="tab-content">
								<div id="table-sorter-tab" class="tab-pane fade in active">
									<div class="row">
										<div class="col-lg-12">
											<div class="portlet box">
												<div class="portlet-header">
													<div class="row" style="margin-top:10px;">
														<div class="col-lg-10">
															<div class="pagination-panel">
																每次浏览&nbsp; 
																<form id="Phidden"
																	action="${contextPath }/manage/salesShowOrder" method="post" style="position:absolute;left:5%;top:-6px;">
																<select name="pageSize"
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
																      仓库&nbsp; 
																<select id="storeId" name="storeId" class="form-control input-sm input-inline" onchange="showSelect('1')" >
															    	<option value="">全部</option>
																	<c:forEach var="storeVO" items="${obj.storeList}" varStatus="status">
																  		<option <c:if test="${obj.storeId == storeVO.storeId}">selected="selected"</c:if> value="${storeVO.storeId}">${storeVO.storeName}</option>
																	</c:forEach>
															  	</select>
																<input id="goodsCode" type="text" name="goodsCode" placeholder="物料编码" value="${obj.goodsCode}"
																	class="form-control input-sm input-inline" style="width: 100px;" /> 
																<input id="goodsName" type="text" name="goodsName" placeholder="物料名称" value="${obj.goodsName}"
																	class="form-control input-sm input-inline" style="width: 100px;" />
																<!-- <input type="button" class="btn btn-info btn-xs" style="height: 30px; padding: 2px 12px;"
																	onclick="showSelect('1')" value="查询" /> -->
																<input type="button" class="btn btn-info btn-xs f4" style="height:30px;padding:2px 12px;" onclick="showSelect('1')" value="查询" autocomplete="off">
																<input type="button" class="btn btn-info btn-xs f4" style="height: 30px; padding: 2px 12px;"
																	onclick="inventoryImport()" value="库存盘点" />
																<input type="button" class="btn btn-info btn-xs f4" style="height: 30px; padding: 2px 12px;"
																	data-toggle="modal" data-target="#exportForm" onclick="showExport()" value="导出成Excel" />
															</form>
															</div>

														</div>
														<div style="float: right;">
															<h4 class="text-green">仓库当前总额：￥${obj.sum}元&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h4>
														</div>
														<%-- <div class="actions">
	                                                    <a href="${contextPath}/manage/editGood"  class="btn btn-info btn-xs">
	                                                    	<i class="fa fa-plus"></i>&nbsp;新增物料
	                                                    </a>&nbsp;
				                                        <div class="btn-group"><a href="#" data-toggle="dropdown" class="btn btn-warning btn-xs dropdown-toggle"><i class="fa fa-wrench"></i>&nbsp;更多操作</a>
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
				                                        </div>
				                                    </div> --%>
													</div>
												</div>
												<div class="portlet-body">
													<table
														class="table table-hover table-striped table-bordered table-advanced tablesorter tb-sticky-header">
														<thead class="success">
															<tr>
																<th width="15%">编码</th>
																<th >物料</th>
																<th width="8%">单位</th>
																<th width="8%">库存上限</th>
																<th width="8%">库存下限</th>
																<th width="8%">库存数量</th>
																<th width="12%">存放仓库</th>
																<th width="8%">操作</th>
															</tr>
														</thead>
														<tbody>
															<c:forEach var="inventoryVO" items="${obj.inventoryList}"
																varStatus="status">
																<%-- <form id="${inventoryVO.goodId.replace('-','')}"> --%>
																<tr>
																	<td>${inventoryVO.goodsCode}</td>
																	<td>${inventoryVO.goodsName}
																	<c:if test="${inventoryVO.specValueString != null}">【${inventoryVO.specValueString}】</c:if>
																	</td>
																	<td>${inventoryVO.goodVO.unitVO.unitName}</td>
																	<td id="max${inventoryVO.goodId}${inventoryVO.storeId }"><input
																		type="hidden" id="maxQuantity${inventoryVO.goodId}${inventoryVO.storeId }"
																		style="width: 100%" name="maxQuantity"
																		value="${inventoryVO.maxQuantity}">${inventoryVO.maxQuantity}</td>
																	<td id="min${inventoryVO.goodId}${inventoryVO.storeId }"><input
																		type="hidden" id="minQuantity${inventoryVO.goodId}${inventoryVO.storeId }"
																		style="width: 100%" name="minQuantity"
																		value="${inventoryVO.minQuantity}">${inventoryVO.minQuantity}</td>
																	<td>${inventoryVO.quantity}</td>
																	<td>${inventoryVO.storeVO.storeName}</td>
																	<td>
																		<button id="editBtn${inventoryVO.goodId}${inventoryVO.storeId }"
																			type="button" class="btn btn-default btn-xs"
																			onclick="edit('${inventoryVO.goodId}','${inventoryVO.storeId }')">
																			<i class="fa fa-edit"></i>&nbsp; 修改
																		</button>
																		<button id="saveBtn${inventoryVO.goodId}${inventoryVO.storeId }"
																			type="button" class="btn btn-danger btn-xs"
																			style="display: none" data-id="${inventoryVO.goodId}"
																			onclick="input_submit('${inventoryVO.goodId}','${inventoryVO.storeId }')">
																			<i class="fa fa-check"></i>&nbsp; 保存
																		</button>
																		<%-- <button id="showBatchNumberBtn${inventoryVO.goodId}"
																			type="button" class="btn btn-default btn-xs"
																			onclick="showBatchNumber('${inventoryVO.goodId}','${inventoryVO.storeId }')">
																			<i class="fa fa-edit"></i>&nbsp; 查询批次号
																		</button> --%>
																	</td>
																</tr>
																<!-- </form> -->
																<%-- <div id="editInventory" class="modal fade">
                												<div class="modal-dialog">
                    												<div class="modal-content">
                        												<div class="modal-header">
                            												<button type="button" data-dismiss="modal" aria-hidden="true" class="close">&times;</button>
                            												<h4 class="modal-title">${inventoryVO.goodsName}--库存设置</h4>
                        												</div>
                        												<form class="form-horizontal" action="${contextPath}/manage/saveType" method="POST" >
                        												<div class="modal-body">
                             												<div class="form">
                                 												<br/>
                                 												<br/>
                                     											<div class="row form-group">
                                         											<label for="库存上限" class="control-label col-md-3" style="margin-left:30px;margin-right:-30px;">库存上限</label>
                                         											<div class="col-md-7">
                                             											<input id="maxQuantity" name="maxQuantity" type="text" class="form-control" />
                                         											</div>
                                     											</div>
                                     											<div class="row form-group">
                                         											<label for="库存下限" class="control-label col-md-3" style="margin-left:30px;margin-right:-30px;">库存下限</label>
                                         											<div class="col-md-7">
                                         												<input id="minQuantity" name="minQuantity" type="text" class="form-control"/>
                                         											</div>
                                     											</div>
                             												</div>
                        												</div>
                        												<br/>
                        												<div class="modal-footer">
                        													<button type="button" class="btn btn-primary" onclick="ev_save();">保存</button>
                            												<button type="button" data-dismiss="modal" class="btn btn-default">关闭</button>
                        												</div>
                        												</form>
                    												</div>
                												</div>
            												</div> --%>
															</c:forEach>
														</tbody>
													</table>
													<div class="col-lg-6" style="margin-left:-22px;">
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
    	activeMenu("inventoryManageMenu","inventoryUL","inventoryList");
		
        var result = "${obj.result}";
        var message = "${obj.msg}";
        //alert(message);
        if(result=='OK'){
        	toastr['success'](message, "");
        }
        else if(result=='FAIL'){
        	toastr['error'](message, "");
        }
        
    });
    
    
    function edit(id,storeId){
    	$("#saveBtn"+id+storeId).show();
    	$("#editBtn"+id+storeId).hide();
    	var maxQuantity = document.getElementById("maxQuantity"+id+storeId).value;
		var minQuantity = document.getElementById("minQuantity"+id+storeId).value;
        document.getElementById("max"+id+storeId).innerHTML = "<input type='text' id='maxQuantity" + id + storeId + "' name='maxQuantity' onkeyup='input_checked(this)' style='width:100%' value='"+ maxQuantity +"'>";
        document.getElementById("min"+id+storeId).innerHTML = "<input type='text' id='minQuantity" + id + storeId + "' name='minQuantity' onkeyup='input_checked(this)' style='width:100%' value='"+ minQuantity +"'>";
    }
    
    function input_submit(id,storeId){
    	    //alert(id);
    		var maxQuantity = document.getElementById("maxQuantity"+id+storeId).value;
    		var minQuantity = document.getElementById("minQuantity"+id+storeId).value;
    		if(parseInt(maxQuantity) < parseInt(minQuantity)){
    			alert("库存上限不能小于库存下限！");
    		}else{
    			$.post('${contextPath}/manage/saveInventory',{"goodId":id, "maxQuantity":maxQuantity, "minQuantity":minQuantity,"storeId":storeId},function(data){
        			if(data.result == 'OK'){ 
        				alert('保存成功');
        				if(maxQuantity != ""){
        					document.getElementById("max"+id+storeId).innerHTML = "<input type='hidden' id='maxQuantity" + id + storeId + "' name='maxQuantity' style='width:100%' value='"+maxQuantity+"'>" + maxQuantity;
        				}else{
        					document.getElementById("max"+id+storeId).innerHTML = "<input type='hidden' id='maxQuantity" + id + storeId + "' name='maxQuantity' style='width:100%' value='"+maxQuantity+"'>" + 0;
        				}
        				if(minQuantity != ""){
        		        	document.getElementById("min"+id+storeId).innerHTML = "<input type='hidden' id='minQuantity" + id + storeId + "' name='minQuantity' style='width:100%' value='"+minQuantity+"'>" + minQuantity;
        				}else{
        					document.getElementById("min"+id+storeId).innerHTML = "<input type='hidden' id='minQuantity" + id + storeId + "' name='minQuantity' style='width:100%' value='"+minQuantity+"'>" + 0;
        				}
        		        $("#saveBtn"+id+storeId).hide();
        		        $("#editBtn"+id+storeId).show();
        				return true;
        			}
        			return false; 
        		});
    		}
    			
    }
        
        var reload = function(){
        	window.location.reload();
    	};
    	
    	//只能输入数字和小数点
    	   function input_checked(obj){
    		   obj.value = obj.value.replace(/\D/g,"");
    	   }
    	
    	   
    	function jumpPage(currentPage){
    		var pageSize = $("select[name=pageSize] option:selected" ).val();
    		var goodsName = "${obj.goodsName}";
    		var goodsCode = "${obj.goodsCode}";
			var storeId="${obj.storeId}";
			var keyword = "${obj.keyword}";
    		var url = "${contextPath}/manage/showInventory?currentPage="+currentPage +"&pageSize=" + pageSize +  "&keyword=" + keyword + "&goodsName=" + goodsName+"&goodsCode="+goodsCode+"&storeId="+storeId;
        	window.location.href = encodeURI(encodeURI(url));
    	}
        
    	function showSelect(currentPage) {
			var goodsName = $("#goodsName").val();
			var goodsCode=$("#goodsCode").val();
			var storeId=$("#storeId").val();
			var pageSize = $(
					"select[name=pageSize] option:selected").val();
			var url = "${contextPath}/manage/showInventory?currentPage="+currentPage +"&pageSize=" + pageSize + "&goodsName=" + goodsName+"&goodsCode="+goodsCode+"&storeId="+storeId;
        	window.location.href = encodeURI(encodeURI(url));
		}
    	
    	function showBatchNumber(goodId,storeId) {
    		$.post('${contextPath}/manage/getBatchNumber',
    				{"goodId":goodId, "storeId":storeId},
    				function(data){if(data.result == 'OK'){ 
    					console.log(data);
    					return true;
    				}
    				return false; 
    		});
    	}
    	
    	function inventoryImport() {
    		var url = "${contextPath}/manage/checkInventory";
    		window.location.href = encodeURI(encodeURI(url));
    	}
    	
    	function orderDownload(){
    		var goodsCode = $("#exportKeyword1").val();
    		var goodsName = $("#exportKeyword2").val();
    		var storeId = $("#exportStoreId").val();
    	    var url = "${contextPath}/manage/exportInventory?goodsCode=" + goodsCode + "&goodsName=" + goodsName + "&storeId=" + storeId;
    		
    		window.location.href = encodeURI(encodeURI(url));
    	}
    	
    	function showExport(){
    		$("#exportKeyword1").val($("#goodsCode").val());
    		$("#exportKeyword2").val($("#goodsName").val());
    		$("#exportStoreId").val($("#storeId").val());
    	}
    	
</script>
</body>

</html>