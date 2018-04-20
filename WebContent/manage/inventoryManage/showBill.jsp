<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
<script type="text/javascript"
	src="${contextPath}/manage/js/ckeditor/ckeditor.js"></script>
<link type="text/css" rel="stylesheet"
	href="${contextPath}/manage/vendors/jquery-tablesorter/themes/blue/style-custom.css">
</head>


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
						<li class="active">
							<c:if test="${obj.billVO.storageKind == 1}">入库单明细</c:if> 
							<c:if test="${obj.billVO.storageKind == 0}">出库单明细</c:if> 
							<c:if test="${obj.billVO.storageKind == 2}">退货入库明细</c:if>
							<c:if test="${obj.billVO.storageKind == 3}">盘点明细</c:if>
						</li>
					</ol>
<%-- 					<jsp:include page="../common/searchBar.jsp" flush="true">
						<jsp:param name="defaultBtn" value="搜库存" />
						<jsp:param name="placeholder" value="请输入物料名称/编码/关键字" />
						<jsp:param name="searchType" value="4" />
					</jsp:include> --%>
					<div class="clearfix"></div>
				</div>
				<!--END TITLE & BREADCRUMB PAGE-->

				<div id="batchForm" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" data-dismiss="modal" aria-hidden="true"
									class="close">&times;</button>
								<h4 class="modal-title">填写批次号</h4>
							</div>
							<form id="batchNumberForm" class="form-horizontal" method="POST">
								<input type="hidden" id="fillGoodId" name="fillGoodId" value="">
								<input type="hidden" id="fillStorageId" name="fillStorageId" value=""> 
								<input type="hidden" id="fillPrice" name="fillPrice" value="">
								<div class="modal-body">
									<div class="form">
										<div class="well well-sm">
											编号 : <font id="fillGoodsCode"></font> 
											<br> <br>
											物料 : <font id="fillGoodsName"></font> 
											<br> <br>
											入库数量 : <font id="fillStorageNum"></font>
										</div>

										<div class="form-group">
											<label for="fillBatchNumber" class="control-label col-md-3">批次号</label>
											<div class="col-md-7">
												<input type="text" id="fillBatchNumber" name="fillBatchNumber" class="form-control" />
											</div>
										</div>
										<br />
									</div>
								</div>
								<div class="modal-footer">
									<button id="addBatchNumber" type="button" class="btn btn-primary">提交</button>
									<button type="button" data-dismiss="modal"
										class="btn btn-default">关闭</button>
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
								<li class="active">
									<a href="#table-sticky-tab" data-toggle="tab">
										<c:if test="${obj.billVO.storageKind == 1}">入库单明细</c:if>
										<c:if test="${obj.billVO.storageKind == 0}">出库单明细</c:if>
										<c:if test="${obj.billVO.storageKind == 2}">退货入库明细</c:if>
										<c:if test="${obj.billVO.storageKind == 3}">盘点明细</c:if>
									</a>
								</li>
							</ul>
							<div id="tableadvancedTabContent" class="tab-content">
								<div id="table-sorter-tab" class="tab-pane fade in active">
									<div class="row">
										<div class="col-lg-12">
											<div class="portlet box">
												<div class="portlet-body">
													<div class="row">
														<div class="col-lg-12">
															<table class="table">
																<thead>
																	<tr>
																		<th width="20%">单号：${obj.billVO.billCode}</th>
																		<th width="20%">
																			<c:if test="${obj.billVO.storageKind == 1}">入库类型:</c:if> 
																			<c:if test="${obj.billVO.storageKind == 0}">出库类型:</c:if>
																			<c:if test="${obj.billVO.storageKind == 2}">类型:</c:if>
																			<c:if test="${obj.billVO.storageKind == 3}">出库/入库类型:</c:if>
																			${obj.billVO.storageType}
																		</th>
																		<th width="20%">
																			<c:if test="${obj.billVO.storageKind == 1}">入库日期:</c:if>
																			<c:if test="${obj.billVO.storageKind == 0}">出库日期:</c:if>
																			<c:if test="${obj.billVO.storageKind == 2}">退货入库日期:</c:if>
																			<c:if test="${obj.billVO.storageKind == 3}">盘点日期:</c:if>
																			<fmt:formatDate value="${obj.billVO.createTime}" type="both" /></th>
																				<th width="20%">
																			<c:if test="${obj.billVO.storageKind == 1}">入库仓库:</c:if>
																			<c:if test="${obj.billVO.storageKind == 0}">出库仓库:</c:if>
																			<c:if test="${obj.billVO.storageKind == 2}">退货入库仓库:</c:if>
																			<c:if test="${obj.billVO.storageKind == 3}">盘点仓库:</c:if>
																			${obj.billVO.storeVO.storeName}</th>
																		<th>制单人：${obj.billVO.billMaker}</th>
																	</tr>
																</thead>
															</table>

															<table class="table table-striped table-bordered table-advanced ">
																<thead>
																	<tr>
																		<th width="10%">编码</th>
																		<th width="12%">物料</th>
																		<c:if test="${obj.billVO.storageKind == 1}">
																			<th width="10%">入库批次号</th>
																		</c:if>
																		<c:if test="${obj.billVO.storageKind == 0}">
																			<th width="10%">出库批次号</th>
																		</c:if>
																		<c:if test="${obj.billVO.storageKind == 2}">
																			<th width="10%">退货入库批次号</th>
																		</c:if>
																		<c:if test="${obj.billVO.storageKind == 3}">
																			<th width="10%">出库/入库批次号</th>
																		</c:if>
																		<th width="10%">
																			<c:if test="${obj.billVO.storageKind == 1}">入库类型</c:if>
																			<c:if test="${obj.billVO.storageKind == 0}">出库类型</c:if>
																			<c:if test="${obj.billVO.storageKind == 2}">类型</c:if>
																			<c:if test="${obj.billVO.storageKind == 3}">出库/入库类型</c:if>
																		</th>
																		<th width="10%">
																			<c:if test="${obj.billVO.storageKind == 1}">入库数量</c:if>
																			<c:if test="${obj.billVO.storageKind == 0}">出库数量</c:if>
																			<c:if test="${obj.billVO.storageKind == 2}">退货入库数量</c:if>
																			<c:if test="${obj.billVO.storageKind == 3}">出库/入库数量</c:if>
																		</th>
																		<th width="8%">计量单位</th>
																		<th width="10%">
																			<c:if test="${obj.billVO.storageKind == 0}">销售单价</c:if>
																			<c:if test="${obj.billVO.storageKind == 1}">入库单价</c:if>
																			<c:if test="${obj.billVO.storageKind == 2}">退货入库单价</c:if>
																			<c:if test="${obj.billVO.storageKind == 3}">出库/入库单价</c:if>
																		</th>
																		<th >
																			备注
																		</th>
																		<c:if test="${obj.billVO.storageKind == 1 || obj.billVO.storageKind == 3}">
																			<th width="8%">操作</th>
																		</c:if>
																	</tr>
																</thead>
																<tbody id="storage_tbody">
																	<c:forEach var="storageVO" items="${obj.storageList}" varStatus="status">
																		<tr id="tr1">
																			<td>${storageVO.goodVO.goodsCode}</td>
																			<td>${storageVO.goodVO.goodsName}
																				<c:if test="${storageVO.goodVO.goodSpecValueVO.size()>0}">
																					<c:set var="spec" value="【"/>
																					【<c:forEach var="goodSpecValueVO" items="${storageVO.goodVO.goodSpecValueVO}"
																						varStatus="status">
																						${goodSpecValueVO.specVO.specName}:${goodSpecValueVO.specValueVO.specValue}
																						<c:set var="spec" value="${spec}${goodSpecValueVO.specVO.specName}:${goodSpecValueVO.specValueVO.specValue}"/>
																					</c:forEach>】
																					<c:set var="spec" value="${spec}】"/>
																				</c:if>
																			</td>
																			<c:if test="${obj.billVO.storageKind == 1}">
																				<td><c:if
																						test="${storageVO.batchNumber == null||storageVO.batchNumber==''}">无</c:if>${storageVO.batchNumber}</td>
																			</c:if>
																			<c:if test="${obj.billVO.storageKind == 0}">
																				<td><c:if
																						test="${storageVO.batchNumber == null||storageVO.batchNumber==''}">无</c:if>${storageVO.batchNumber}</td>
																			</c:if>
																			<c:if test="${obj.billVO.storageKind == 2}">
																				<td><c:if
																						test="${storageVO.batchNumber == null||storageVO.batchNumber==''}">无</c:if>${storageVO.batchNumber}</td>
																			</c:if>
																			<c:if test="${obj.billVO.storageKind == 3}">
																				<td><c:if
																						test="${storageVO.batchNumber == null||storageVO.batchNumber==''}">无</c:if>${storageVO.batchNumber}</td>
																			</c:if>
																			<td>${storageVO.storageType}</td>
																			<td>
																			<c:choose>
																			<c:when test="${storageVO.storageKind == 3}">
																			<font color="red">-${storageVO.storageNum}</font>
																			</c:when>
																			<c:when test="${storageVO.storageKind == 4}">
																			<font color="green">+${storageVO.storageNum}</font>
																			</c:when>
																			<c:otherwise>
																			${storageVO.storageNum}
																			</c:otherwise>
																			</c:choose>
																			</td>
																			<td>${storageVO.goodVO.unitVO.unitName}</td>
																			<td>${storageVO.price}</td>
																			<td>${storageVO.remark}</td>
																			<c:if test="${obj.billVO.storageKind == 1 || obj.billVO.storageKind == 3}">
																				<td>
																					<c:if test="${obj.billVO.storageKind == 1}">
																					   <shiro:hasPermission name="inventorys:revert">  
																						    <button type="button" class="btn btn-danger btn-xs" onclick="revertStorage('${obj.billVO.billId}','${storageVO.storageId}','${obj.billVO.storeId}')">
																								<i class="fa fa-edit"></i>&nbsp; 撤销
																							</button>
																						</shiro:hasPermission> 
																					</c:if>
																					<c:if test="${obj.billVO.storageKind == 3 && (storageVO.batchNumber == null||storageVO.batchNumber=='') && storageVO.storageKind == 4}">
																						<a href="#" class="btn btn-success btn-xs"
																							onclick="fillInBatchNumber('${storageVO.goodId}','${storageVO.storageId}','${storageVO.price}','${storageVO.goodVO.goodsCode}','${storageVO.goodVO.goodsName}${spec}','${storageVO.storageNum}')"
																							data-toggle="modal" data-target="#batchForm">&nbsp;<i class="fa fa-edit"></i>&nbsp; 填写批次号&nbsp;</a><br>
																					</c:if>
																				</td>
																			</c:if>
																		</tr>
																	</c:forEach>
																</tbody>
															</table>
														</div>
													</div>
													<hr />
													<div class="form-actions text-right pal pull-left" style="margin-left:-20px;">
														<button type="button" class="btn btn-green" onclick="ev_back()">返回</button>
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


				<script type="text/javascript">
    //菜单初始化
    if('${obj.billVO.storageKind}' == 1){
    	activeMenu("inventoryManageMenu","inventoryUL","inStorage");
    }else if('${obj.billVO.storageKind}' == 0){
    	activeMenu("inventoryManageMenu","inventoryUL","outStorage");
    }else if('${obj.billVO.storageKind}' == 2){
    	activeMenu("inventoryManageMenu","inventoryUL","reStorage");
    }
    
    
    var result = "${obj.result}";
    var message = "${obj.msg}";
    if(result=='OK'){
    	toastr['success'](message, "");
        setTimeout(function(){
        	window.location.href = "${contextPath}/manage/inStorage";
        },600);
    }
    else if(result=='FAIL'){
    	toastr['error'](message, "");
    }
        
   function ev_back(){
   	window.history.back();
   }
   
   function revertStorage(billId,storageId,storeId){
		var url = "${contextPath}/manage/revertStorage?billId="+billId+"&storageId="+storageId+"&storeId="+storeId;
		common_ajax(url,function(data){
			if(data.msg=="clear"){
				toastr['success']("删除成功!", "");
     	        setTimeout(function(){
     	        	window.location.href = "${contextPath}/manage/inStorage";
     	        },600);
			}else if(data.result=='OK'){
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
   
   	function fillInBatchNumber(goodId,storageId,price,goodsCode,goodsName,storageNum){
   		$("#fillGoodId").val(goodId);
   		$("#fillStorageId").val(storageId);
   		$("#fillPrice").val(price);
   		$("#fillGoodsCode").html(goodsCode);
   		$("#fillGoodsName").html(goodsName);
   		$("#fillStorageNum").html(storageNum);
   	}
   
   	$(function(){
		$("#addBatchNumber").click(function() {
      		var batchNumber = $("#fillBatchNumber").val();

      		if(batchNumber == null || batchNumber == ""){
      			toastr['error']("批次号不能为空", "");
      			return false;
      		}
      	 
           	$.ajax({
               	url : "${contextPath}/manage/addBatchNumber",
               	type: "POST",
               	data:$('#batchNumberForm').serialize(),
               	error: function(request) {
                   	alert("链接异常");
               	},
               	dataType:"json",
               	success: function(data) {
                	if (data.result == 'OK') {
                       	toastr['success'](data.msg, "");
                       	setTimeout(function(){
       	            		location.reload();
       	            	},300);
                	} else {
                  		toastr['error'](data.msg, "");
                   	}
               	}
           	});
           	return false;
       	});
   	});
   	
   	var reload = function(){
		window.location.reload();
	};
	        

</script>
</body>

</html>