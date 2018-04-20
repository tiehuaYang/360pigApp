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
<style>
.btn-warning {
margin-right:15px;
}
.table>tbody>tr>td {
    vertical-align: middle;
}
.table>tbody>tr>td {
	text-align:left;
	vertical-align: middle;
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
						<li><i class="fa fa-home"></i>&nbsp;<a href="index.jsp">首页</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li><a href="#">企业管理</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">员工管理</li>
					</ol>
					
					<div class="clearfix"></div>
				</div>
				<!--END TITLE & BREADCRUMB PAGE-->
				<!--BEGIN CONTENT-->
				<div class="page-content">
					<div id="table-advanced" class="row">
						<div class="col-lg-12">
							<ul id="tableadvancedTab" class="nav nav-tabs">
								<li
									<c:if test="${empty obj.page  || obj.page == 'stuff'}"> class="active"</c:if>><a
									href="#stuff-tab" data-toggle="tab">&nbsp;员工管理&nbsp;</a></li>
								<li <c:if test="${obj.page == 'auth'}"> class="active"</c:if>><a
									href="#auth-tab" data-toggle="tab">&nbsp;角色权限&nbsp;</a></li>
							</ul>
							<div id="tableadvancedTabContent" class="tab-content">
								<div id="stuff-tab"
									class="tab-pane fade in  <c:if test="${empty obj.page  || obj.page == 'stuff'}"> active</c:if>">
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
															<a href="${contextPath}/manage/editStuff"
																class="btn btn-info btn-xs"><i class="fa fa-plus"></i>&nbsp;新增员工</a>&nbsp;
															<!-- <div class="btn-group">
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
															</div> -->
														</div>
													</div>
												</div>
												<div class="portlet-body">
													<table
														class="table table-hover table-striped table-bordered table-advanced tablesorter tb-sticky-header">
														<thead class="success">
															<tr>
																<th width="3%"><input type="checkbox"
																	class="checkall" /></th>
																<th width="10%" class="tc">员工姓名</th>
																<th width="13%" class="tc">手机</th>
																<th width="13%" class="tc">邮箱</th>
																<th width="10%" class="tc">部门</th>
																<th width="10%" class="tc">职位</th>
																<th width="12%" class="tc">入职时间</th>
																<th width="12%" class="tc">上次登录时间</th>
																<th class="tc">操作</th>
															</tr>
														</thead>
														<tbody>
															<c:forEach var="stuff" items="${obj.stuffList}"
																varStatus="status">
																<tr style="verital-align:middle;text-align:center;">
																	<td style="text-align:center;" class="tc"><input type="checkbox" /></td>
																	<td style="text-align:center;" class="tc">${stuff.userName}</td>
																	<td style="text-align:center;" class="tc">${stuff.cellPhone}</td>
																	<td style="text-align:center;" class="tc">${stuff.email}</td>
																	<td style="text-align:center;" class="tc">${stuff.departure}</td>
																	<td style="text-align:center;" class="tc">${stuff.post}</td>
																	<td style="text-align:center;" class="tc"><i class="fa fa-clock-o"></i>
																		${stuff.employDateStr}</td>
																	<td style="text-align:center;" class="tc"><i class="fa fa-clock-o"></i>
																		${stuff.lastLoginDateStr}</td>
																	<td style="text-align:center;" class="tc">
																		<button type="button" class="btn btn-default btn-xs"
																			onclick="editStuff('${stuff.userId}')">
																			<i class="fa fa-edit"></i>&nbsp; 编辑
																		</button> &nbsp;
																		<button type="button" class="btn btn-danger btn-xs"
																			onclick="delStuff('${stuff.userId}')">
																			<i class="fa fa-trash-o"></i>&nbsp; 删除
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
								<div id="auth-tab"
									class="tab-pane fade in  <c:if test="${obj.page == 'auth'}"> active</c:if>">
									<div class="row">
										<div class="col-lg-12">
											<div class="portlet box">
												<div class="portlet-body">
													<div class="col-lg-12">
														<h4 class="text-blue">角色权限管理</h4>
													</div>
													<br> <br> <br>
													<div class="row">
														<div class="col-md-6">
															<div class="form-group">
																<div class="col-md-1"></div>
																<input name="customName" type="hidden"
																	value="${obj.salesVO.companyName}" />
																<div class="col-md-8">
																	<select id="roleId" name="roleId" class="form-control"
																		onchange="changeRole(this.options[this.options.selectedIndex].value)">
																		<c:forEach var="role" items="${obj.roleList}"
																			varStatus="status">
																			<option value="${role.id}"
																				<c:if test="${empty role.id  || role.id  == obj.roleId }">selected="selected"</c:if>>${role.alias}</option>
																		</c:forEach>
																	</select>
																</div>
															</div>
														</div>
													</div>
													<br>
													<div>
														<div class="col-md-12">
															<div class="form-group">
																<h4 class="box-heading">说明事项：</h4>
																<p>1、修改角色权限后，所有赋予此角色的员工账号对应权限均将修改</p>
																<p>2、系统管理员角色不允许改名，也不允许修改其操作权限</p>
															</div>
														</div>
													</div>
													<br> <br> <br> <br>
													<div class="clearfix"></div>
													<div class="col-lg-12">
														<h4 class="text-blue">角色权限明细</h4>
													</div>
													<br> <br> <br> <br>
													<table class="table table-hover">
														<tbody>
															<c:forEach var="permissionModule" items="${obj.pmList}"
																varStatus="status">
																<tr>
																	<td width="15%"
																		style="text-align: center; vertical-align: middle">
																		<div>
																			<strong class="text-blue">${permissionModule.moduleName}</strong>
																		</div>
																	</td>
																	<td width="80%"><c:forEach var="permission"
																			items="${permissionModule.permissionList}"
																			varStatus="status">
																			<div
																				style="display: inline-block; float: left; width: 150px">
																				<input id="${permission.permissionId}"
																					type="checkbox" class="permission"
																					onclick="modifyPermission(this,'${permission.permissionId}')"
																					<c:if test="${obj.isAdmin == 'Y' && permission.permissionId == '12'}">disabled="disabled"</c:if>
																					<c:if test="${permission.isCheck == 'Y'}">checked</c:if>><label
																					for="">${permission.name}</label>
																			</div>
																		</c:forEach></td>
																	<td></td>
																</tr>
															</c:forEach>
														</tbody>
													</table>
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
				<!--用于分页-->
				<script src="${contextPath}/manage/js/page/bootstrap-paginator.js"></script>
				<script src="${contextPath}/manage/js/page/jquery.pagination.js"></script>

				<script type="text/javascript">
    $(document).ready(function(){
    	activeMenu("companyMenu","companyUL","peopleMenu");
		
		var result = "${obj.result}";
	    var message = "${obj.msg}";
	    if(result=='OK'){
	    	toastr['success'](message, "");
	    }
	    else if(result=='FAIL'){
	    	toastr['error'](message, "");
	    }
        
    });
    
        function editStuff(id){
        	var url = "${contextPath}/manage/editStuff?userId="+id;
        	window.location.href = url;
        }
        
        
   		function modifyPermission(obj,permissionId){
   			var roleId = $("#roleId").val();
   			var isCheck = obj.checked;
           	  var url = "${contextPath}/manage/modifyPermission?roleId="+roleId+"+&permissionId="+permissionId+"&isCheck="+isCheck;
           	    common_ajax(url,function(data){
           	    	if(data.result=='FAIL'){
           	    		toastr['error'](data.msg, "");
           	    	}
           	    	else if(data.result=='OK'){
           	    		toastr['success']("成功修改权限", "");
           	    	}
           	    		
       		  });
           }
        
        function delStuff(id){
        	if(window.confirm("确定要删除这条记录吗？")){
        	  var url = "${contextPath}/manage/delStuff?userId="+id;
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
        
        function changeRole(roleId){
        	var pageSize = $("select[name=pageSize] option:selected" ).val();
        	var currentPage = '${obj.currentPage}';
    	    var url = "${contextPath}/manage/showStuff?page=auth&roleId="+roleId+"&currentPage="+currentPage +"&pageSize=" + pageSize;
    	    window.location.href = url;
    	}
        
        var reload = function(){
        	window.location.reload();
    	};
    	
    	
    	function jumpPage(currentPage){
    		var roleId = $("select[name=roleId] option:selected" ).val();
    		var pageSize = $("select[name=pageSize] option:selected" ).val();
    		var url = "${contextPath}/manage/showStuff?roleId="+roleId+"&currentPage="+currentPage +"&pageSize=" + pageSize;
        	window.location.href = url;
    	}
        

</script>
</body>

</html>