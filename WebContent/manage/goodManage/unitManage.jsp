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
						<li><a href="#">物料管理</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">物料计量单位管理</li>
					</ol>
<%-- 					<jsp:include page="../common/searchBar.jsp" flush="true">
						<jsp:param name="defaultBtn" value="搜物料" />
						<jsp:param name="placeholder" value="请输入物料名称/编码/关键字" />
						<jsp:param name="searchType" value="0" />
					</jsp:include> --%>
					<div class="clearfix"></div>
				</div>
				<!--END TITLE & BREADCRUMB PAGE-->
				<!--BEGIN MODAL CONFIG PORTLET-->
				
				<div id="newUnit" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" data-dismiss="modal" aria-hidden="true"
									class="close">&times;</button>
								<h4 class="modal-title">新增计量单位</h4>
							</div>
						
								<div class="modal-body">
									<form id="" class="form-horizontal" method="post" >
										<input name="unitId" type="hidden" />
										<div class="form">
											<div class="form-group">
										        <label for="单位名称" class="control-label col-md-3">单位名称</label>
										        <div class="col-md-7">
										            <input id="unitName" name=unitName type="text" class="form-control" />
										        </div>
										    </div>
										    
										    <div class="form-group">
										        <label for="排序值" class="control-label col-md-3">排序值</label>
										        <div class="col-md-7">
										            <input id="level"  name="level"  type="text" class="form-control" />
										        </div>
										    </div>
										</div>
									</form>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-primary" onclick="ev_save();">保存</button>
									<button type="button" data-dismiss="modal" class="btn btn-default">关闭</button>
								</div>
						</div>
					</div>
				</div>
				
				<div id="editUnitModal" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" data-dismiss="modal" aria-hidden="true"
									class="close">&times;</button>
								<h4 class="modal-title">编辑计量单位</h4>
							</div>
						
								<div class="modal-body">
									<form id="editUnitModalForm" class="form-horizontal" method="post" >
										<input name="unitId" type="hidden" />
										<div class="form">
											<div class="form-group">
										        <label for="单位名称" class="control-label col-md-3">单位名称</label>
										        <div class="col-md-7">
										            <input name="unitName" type="text" class="form-control" />
										        </div>
										    </div>
										    
										    <div class="form-group">
										        <label for="排序值" class="control-label col-md-3">排序值</label>
										        <div class="col-md-7">
										            <input name="level" type="text" class="form-control" />
										        </div>
										    </div>
										</div>
									</form>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-primary" onclick="editUnit();">保存</button>
									<button type="button" data-dismiss="modal" class="btn btn-default">关闭</button>
								</div>
						</div>
					</div>
				</div>
				<!--END MODAL CONFIG PORTLET-->

				<!--BEGIN CONTENT-->
				<div class="page-content">
					<div id="table-advanced" class="row">
						<div class="col-lg-12">
							<ul id="tableadvancedTab" class="nav nav-tabs">
								<li class="active"><a href="#table-sticky-tab"
									data-toggle="tab">任务列表</a></li>
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
														<div class="actions">
															<a href="#" data-hover="tooltip" title="新增单位"  onclick="newUnitModal()" class="btn btn-info btn-xs"><i class="fa fa-plus"></i>&nbsp;新增单位</a>&nbsp;
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
																<th width="35%" style="vertical-align:middle;text-align:center;">计量单位</th>
																<th width="35%" style="vertical-align:middle;text-align:center;">排序值</th>
																<th width="30%" style="vertical-align:middle;text-align:center;">操作</th>
															</tr>
														</thead>
														<tbody>
															<c:forEach var="unitVO" items="${obj.unitList}"
																varStatus="status">
																<tr>
																	<td>${unitVO.unitName}</td>
																	<td>${unitVO.level}</td>
																	<td>
																		<button type="button" class="btn btn-default btn-xs"  onclick="editUnitModal(this,'${unitVO.unitId}')">
																			<i class="fa fa-edit"></i>&nbsp; 编辑
																		</button>
																		<button type="button" class="btn btn-danger btn-xs" onclick="delUnit('${unitVO.unitId}')">
																			<i class="fa fa-trash-o"></i>&nbsp; 删除
																		</button>
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
		activeMenu("orderManageMenu","supplyOrderUL","unitMenu");
		
        var result = "${obj.result}";
        var message = "${obj.msg}";
        if(result=='OK'){
        	toastr['success'](message, "");
        }
        else if(result=='FAIL'){
        	toastr['error'](message, "");
        }
        
    });
    
    function ev_save(){
    	var unitName = $('#unitName').val();
    	var level = $('#level').val();
    	if(unitName.length<=0)
    		toastr['error']("请输入计量单位名称", "");
   		else{
   		 var url = "${contextPath}/manage/saveUnit?unitName="+encodeURI(encodeURI(unitName))+"&level="+level;
 	     common_ajax(url,function(data){
 	    	if(data.result=='OK'){
   	    		toastr['success']("保存成功!", "");
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
        
        function delUnit(id){
        	if(window.confirm("确定要删除这条记录吗？")){
        	  var url = "${contextPath}/manage/delUnit?unitId="+id;
        	    common_ajax(url,function(data){
        	    	if(data.result=='OK'){
           	    		toastr['success']("删除成功!", "");
             	        setTimeout(function(){
             	        	reload();
             	        },2000);
           	    	}
             	   else{
             		  toastr['error'](data.msg, "");
                    }     
    		  });
        	}
        }
        
        function newUnitModal(){
    		$.ajax({
    		    type: 'POST',
    		    url: '${contextPath}/manage/getMaxLevel',
    		    dataType: 'json',
    		    async: false,
    		    success: function(result) {
    		    	if(result.result == "OK"){
    		    		$('#level').val(result.level);
    		    	}
		        	$('#newUnit').modal('show');
    		    }
    		});
        }
        
        function editUnitModal(obj,id){
			var tr = $(obj).parents("tr");
			var td =$(tr).find("td");
			var o = {};
			o.unitId = id;
			o.unitName = $(td[0]).html();
			o.level = $(td[1]).html();
			
        	formInit();
        	$('#editUnitModal').modal('show');
        	
			var input = $("#editUnitModalForm input");
			for(var i=0;i<input.length;i++){
				$(input[i]).val(eval("o."+input[i].name));
			}
        }
        
        function editUnit(){
    		$.ajax({
    		    type: 'POST',
    		    data: $("#editUnitModalForm").serialize(),
    		    url: '${contextPath}/manage/editUnits',
    		    success: function(result) {
    		    	if(result.result == "OK"){
                    	toastr['success'](result.msg, "");
                        setTimeout(function(){
                        	reload();
                        },2000);
    		    	}else{
    		    		toastr['error'](result.msg, "");
    		    	}
    		    },
    		    dataType: 'json',
    		    async: false
    		});
        }
        
    	function formInit(){
			var input = $("#editUnitModalForm input");
			for(var i=0;i<input.length;i++){
				$(input[i]).val();
			}
    	}
        
        var reload = function(){
        	window.location.reload();
    	};
    	
    	
    	function jumpPage(currentPage){
    		var pageSize = $("select[name=pageSize] option:selected" ).val();
    		var url = "${contextPath}/manage/showUnit?currentPage="+currentPage +"&pageSize=" + pageSize;
        	window.location.href = url;
    	}
        

</script>
</body>

</html>