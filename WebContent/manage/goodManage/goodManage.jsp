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
<style>
.btn-warning {
margin-right:17px;
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
						<li><a href="#">物料管理</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">物料列表</li>
					</ol>
<%--  					<jsp:include page="../common/searchBar.jsp" flush="true">
						<jsp:param name="defaultBtn" value="搜物料" />
						<jsp:param name="placeholder" value="请输入物料名称/编码/关键字" />
						<jsp:param name="searchType" value="0" />
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
											<label for="exportGoodsType" class="control-label col-md-3">物料类别</label>
											<div class="col-md-7">
												 <select id="exportGoodsType" name="exportGoodsType" class="form-control" >
											    	<option value="">全部</option>
													<c:forEach var="goodsTypeVO" items="${obj.typeList}" varStatus="status">
												  		<option value="${goodsTypeVO.typeId}">${goodsTypeVO.typeName}</option>
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
								<li class="active"><a href="#table-sticky-tab" data-toggle="tab">物料列表</a></li>
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
																每次浏览&nbsp; 
															<form id="Phidden"
																	action="${contextPath }/manage/salesShowOrder" method="post" style="position:absolute;left:5%;top:-6px;">
															  <select name="pageSize" class="form-control input-xsmall input-sm input-inline" onchange="jumpPage('1')">
															    <option value="10" <c:if test="${obj.pageSize == '10' }">selected="selected"</c:if>>10</option>
																<option value="20" <c:if test="${obj.pageSize == '20' }">selected="selected"</c:if>>20</option>
																<option value="50" <c:if test="${obj.pageSize == '50' }">selected="selected"</c:if>>50</option>
																<option value="100" <c:if test="${obj.pageSize == '100' }">selected="selected"</c:if>>100</option>
															  </select>&nbsp;记录 | 共有 ${obj.recordCount } 条记录&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
															      物料类别&nbsp; 
															  <select id="goodsType" name="goodsType" class="form-control input-sm input-inline" onchange="showSelect('${obj.currentPage}')" >
															    <option value="">全部</option>
																<c:forEach var="goodsTypeVO" items="${obj.typeList}" varStatus="status">
																  <option <c:if test="${obj.goodsType == goodsTypeVO.typeId}">selected="selected"</c:if> value="${goodsTypeVO.typeId}">${goodsTypeVO.typeName}</option>
																</c:forEach>
															  </select>
																<input id="goodsCode" type="text" name="goodsCode" placeholder="物料编码" class="form-control input-sm input-inline" style="width: 100px;" value="${obj.goodsCode}" />
																<input id="goodsName" type="text" name="goodsName" placeholder="物料名称" class="form-control input-sm input-inline" style="width: 100px;"  value="${obj.goodsName}"/> 
																<%-- <input id="goodsType" type="text" name="goodsType" placeholder="类别" class="form-control input-sm input-inline" style="width: 100px;"  value="${obj.goodsType}"/> --%> 
																<input type="button" class="btn btn-info btn-xs f4" style="height: 30px; padding: 2px 12px;" onclick="showSelect('${obj.currentPage}')" value="查询" />
                                                               </form>
															</div>
														</div>
														<div class="actions">
															<shiro:hasPermission name="good:edit">
															 <a href="${contextPath}/manage/editGood" class="btn btn-info btn-xs"> <i class="fa fa-plus"></i>&nbsp;新增物料</a>&nbsp;
															</shiro:hasPermission>
															<div class="btn-group">
																<a href="#" data-toggle="dropdown" class="btn btn-warning btn-xs dropdown-toggle">
																  <i class="fa fa-wrench"></i>&nbsp;更多操作</a>
																<ul class="dropdown-menu pull-right">
																  <shiro:hasPermission name="good:import">
																    <li><a href="${contextPath}/manage/showGoodImport"><i class="fa fa-download"></i>&nbsp;导入物料</a></li>
																  </shiro:hasPermission>
																  <shiro:hasPermission name="good:export">
																    <li><a href="#" data-toggle="modal" data-target="#exportForm" onclick="showExport()">导出成Excel</a></li>
																  </shiro:hasPermission>
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
																<th width="12%">物料编码</th>
																<th >物料名称</th>
																<th width="8%">类别</th>
																<th width="8%">单位</th>
																<th width="10%">市场价</th>
																<shiro:hasPermission name="good:checkCost">  
																	<th width="10%">成本价</th>
																</shiro:hasPermission> 
																<th width="8%">是否上架</th>
																<th width="18%">操作</th>
															</tr>
														</thead>
														<tbody>
															<c:forEach var="goodVO" items="${obj.goodList}"
																varStatus="status">
																<tr>
																	<td>${goodVO.goodsCode}</td>
																	<td>${goodVO.goodsName}
																	<c:if test="${goodVO.specValueString != null}">【${goodVO.specValueString}】</c:if>
																	</td>
																	<td>${goodVO.typeVO.typeName}</td>
																	<td>${goodVO.unitVO.unitName}</td>
																	<td class="text-right">${goodVO.mPrice}</td>
																	<shiro:hasPermission name="good:checkCost">  
																		<td class="text-right">${goodVO.cPrice}</td>
																	</shiro:hasPermission> 
																	<td><c:choose>
																			<c:when test="${goodVO.isList == 'Y'}">是</c:when>
																			<c:otherwise>否</c:otherwise>
																		</c:choose></td>
																	<td>
																	  <shiro:hasPermission name="good:edit">
																		<button type="button" class="btn btn-success btn-xs" onclick="showGoodInfo('${goodVO.goodId}')">
																			<i class="fa fa-bar-chart-o"></i>&nbsp;详情
																		</button>
																	  </shiro:hasPermission>
																	  <shiro:hasPermission name="good:edit">
																		<button type="button" class="btn btn-default btn-xs" onclick="showGood('${goodVO.goodId}')">
																			<i class="fa fa-edit"></i>&nbsp;编辑
																		</button>
																	  </shiro:hasPermission>
																	  <shiro:hasPermission name="good:delete">
																		<button type="button" class="btn btn-danger btn-xs" onclick="delGood('${goodVO.goodId}')">
																			<i class="fa fa-trash-o"></i>&nbsp;删除
																		</button>
																	  </shiro:hasPermission>
																	</td>
																</tr>
															</c:forEach>
														</tbody>
													</table>
												</div>
												<div class="col-lg-6" style="margin-left:-7px;">
													<div class="pagination-panel"> &nbsp;
														<a href="#" onclick="jumpPage('${obj.currentPage - 1}')" class="btn btn-sm btn-success btn-prev gw-prev"
															<c:if test="${obj.currentPage == 1}">disabled </c:if>><i class="fa fa-angle-left"></i>
														</a>&nbsp;
														<input id="currentPage" type="text" maxlenght="5" value="${obj.currentPage}"
															class="pagination-panel-input form-control input-mini input-inline input-sm text-center gw-page"
															onchange="goPage('${obj.currentPage}','${obj.pageCount}')" />&nbsp;
														<a href="#" onclick="jumpPage('${obj.currentPage + 1}')" class="btn btn-sm btn-success btn-prev gw-next"
															<c:if test="${obj.currentPage >= obj.pageCount}">disabled </c:if>><i class="fa fa-angle-right"></i>
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
					
				<div class="modal fade"   id="goodsDelModal"  tabindex="-1" role="dialog" labelledby="" aria-hidden="true">
			    	<div class="modal-dialog modal-md">
			    		<div class="modal-content">
			    			<div class="modal-header">
			    				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			    				<h4 class="modal-title" id="gridSystemModalLabel">警告</h4>
			    			</div>
			    			<div class="modal-body">
			    				<p class="text-danger" style="font-size:20px;">确定要删除吗？</p>
			    				<br/>
			    				<form action="${contextPath}/manage/delGood" class="form-horizontal" method="post" name="menu_del">
			    					<input type="hidden" name="goodId"/>
								</form>
			    			</div>
			    			<div class="modal-footer">
			    				<button type="button" class="btn btn-danger" onclick="delGoods();">&nbsp; &nbsp;确&nbsp;定&nbsp;&nbsp;</button>
								<button type="button" class="btn btn-danger" data-dismiss="modal" style="margin-left: 20px">&nbsp;&nbsp;取&nbsp;消&nbsp;&nbsp;</button>
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
		activeMenu("orderManageMenu","supplyOrderUL","goodMenu");
		
        var result = "${obj.result}";
        var message = "${obj.msg}";
        if(result=='OK'){
        	toastr['success'](message, "");
        }
        else if(result=='FAIL'){
        	toastr['error'](message, "");
        }
    });
    
        
        function delGood(id){
    		$("#goodsDelModal input").val(id);
    		$("#goodsDelModal").modal();
        }
        
        function delGoods(id){
    		$.post('${contextPath}/manage/delGood',{goodId:$("#goodsDelModal input").val()},function(data){
    			if(data.result=='OK'){
       	    		toastr['success']("删除成功!", "");
         	        setTimeout(function(){
         	        	window.location.reload();
         	        },600);
    			}else{
    				toastr['error'](data.msg, "");
    			}
    		},'json');
        }
        
        function showGood(id){
        	var url = "${contextPath}/manage/editGood?goodId="+id;
        	window.location.href = url;
        }    
        
        function showGoodInfo(id){
        	var url = "${contextPath}/manage/showGoodInfo?goodId="+id;
        	window.location.href = url;
        }    
    
        var reload = function(){
        	window.location.reload();
    	};
    	
    	function jumpPage(currentPage){
    		var pageSize = $("select[name=pageSize] option:selected" ).val();
    		var keyword = "${obj.keyword}";
    		var goodsName = "${obj.goodsName}";
			var goodsCode = "${obj.goodsCode}";
			var goodsType = "${obj.goodsType}";
			var pageSize = $( "select[name=pageSize] option:selected").val();
			var url = "${contextPath}/manage/showGoods?currentPage="+ currentPage+ "&pageSize="+ pageSize
					+ "&goodsName=" + goodsName+"&goodsCode="+goodsCode+"&goodsType="+goodsType;
			window.location.href = encodeURI(encodeURI(url));
    	}
    	function showSelect(currentPage) {
    		currentPage = "1";
			var goodsName = $("#goodsName").val();
			var goodsCode=$("#goodsCode").val();
			var goodsType=$("#goodsType").val();
			var pageSize = $( "select[name=pageSize] option:selected").val();
			var url = "${contextPath}/manage/showGoods?currentPage=" + currentPage + "&pageSize=" + pageSize
					+ "&goodsName=" + goodsName+"&goodsCode="+goodsCode+"&goodsType="+goodsType;
			window.location.href = encodeURI(encodeURI(url));
		}
    	 function orderDownload(){
    			var goodsCode = $("#exportKeyword1").val();
    			var goodsName = $("#exportKeyword2").val();
    			var goodsType = $("#exportGoodsType").val();
    		    var url = "${contextPath}/manage/exportGoods?goodsCode=" + goodsCode + "&goodsName=" + goodsName + "&goodsType=" + goodsType ;
    			
    			window.location.href = encodeURI(encodeURI(url));
    		}
    	 
    	 function showExport(){
    			$("#exportKeyword1").val($("#goodsCode").val());
    			$("#exportKeyword2").val($("#goodsName").val());
    			$("#exportGoodsType").val($("#goodsType").val());
    		}

</script>
</body>

</html>