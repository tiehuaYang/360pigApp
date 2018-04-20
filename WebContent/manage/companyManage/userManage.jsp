<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
 <!--LOADING STYLESHEET FOR PAGE-->
<link type="text/css" rel="stylesheet" href="${contextPath}/manage/vendors/jquery-tablesorter/themes/blue/style-custom.css">
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
                    <div class="page-header pull-left">
                        <div class="page-title">员工帐号管理</div>
                    </div>
                    <ol class="breadcrumb page-breadcrumb">
                        <li><i class="fa fa-home"></i>&nbsp;<a href="index.jsp">首页</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li><a href="#">扩展</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li class="active">个人资料</li>
                    </ol>
                    <div class="clearfix"></div>
                </div>
                <!--END TITLE & BREADCRUMB PAGE-->
                <!--BEGIN CONTENT-->
                <div class="page-content">
                    <div id="table-advanced" class="row">
                        <div class="col-lg-12">
                            <ul id="tableadvancedTab" class="nav nav-tabs">
                                <li class="active"><a href="#table-sticky-tab" data-toggle="tab">&nbsp;员工列表&nbsp;</a></li>
                            </ul>
                            <div id="tableadvancedTabContent" class="tab-content">
                                <div id="table-sorter-tab" class="tab-pane fade in active">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="portlet box">
                                            <!--  查询条件表单    -->
	                                                <div class="col-lg-12">
		                                                <div class="portlet box">
							                                <div class="portlet-header">
							                                    <div class="caption">查询面板</div>
							                                    <div class="tools"><i class="fa fa-chevron-down"></i>
							                                    </div>
							                                </div>
							                                <div class="portlet-body" style="display: none;">
							                                    <form id="searchForm" action="${contextPath}/manage/showUser" class="horizontal-form" method="POST" >
							                                    <input id="pageSize" name="pageSize" type="hidden" class="form-control" value="${obj.pageSize}" />
							                                    <input id="currentPage" name="currentPage" type="hidden" class="form-control" value="${obj.currentPage}" />
				                                                        <div class="form-body pal">
				                                                            <div class="row">
				                                                                <div class="col-md-6">
				                                                                    <div class="form-group" style="margin-bottom:50px;">
				                                                                        <label for="acount" class="col-md-3 control-label" >用户名
				                                                                        </label>
				                                                                        <div class="col-md-8">
				                                                                            <input id="acount" name="acount" type="text" class="form-control" value="${obj.queryMap.acount}" />
				                                                                        </div>
				                                                                    </div>
				                                                                </div>
				                                                                <div class="col-md-6">
				                                                                    <div class="form-group" style="margin-bottom:50px;">
				                                                                        <label for="userName" class="col-md-3 control-label">姓名
				                                                                        </label>
				                                                                        <div class="col-md-8">
				                                                                            <input id="userName" name="userName" type="text" class="form-control" value="${obj.queryMap.userName}"/>
				                                                                        </div>
				                                                                    </div>
				                                                                </div>
				                                                                <div class="col-md-6">
				                                                                    <div class="form-group" style="margin-bottom:50px;">
				                                                                        <label for="dep" class="col-md-3 control-label">部门
				                                                                        </label>
				                                                                        <div class="col-md-8">
				                                                                            <input id="dep" name="dep" type="text" class="form-control" value="${obj.queryMap.dep}"/>
				                                                                        </div>
				                                                                    </div>
				                                                                </div>
				                                                                <div class="col-md-6">
				                                                                    <div class="form-group" style="margin-bottom:50px;">
				                                                                        <label for="cellPhone" class="col-md-3 control-label">手机
				                                                                        </label>
				                                                                        <div class="col-md-8">
	                                                        								<input id="cellPhone" name="cellPhone"  type="text"   class="form-control" value="${obj.queryMap.cellPhone}"/>
				                                                                        </div>
				                                                                    </div>
				                                                                </div>
				                                                                <div class="col-md-12">
				                                                                	<div class="col-md-9">
							                                                        </div>
				                                                                	<div class="col-md-3">
							                                                            <input id="search" type="button" class="btn btn-primary" value = "查询" onclick="ev_search()"/>&nbsp;
							                                                            <input type="button" class="btn btn-green" value = "清除查询条件" onclick="ev_cancel()"/>
							                                                        </div>
				                                                                </div>
				                                                            </div>
				                                                        </div>
				                                                 </form>
							                                </div>
							                            </div>
			                                        </div>
				                                <div class="portlet-header">
				                                <div class="row">
	                                                    <div class="col-lg-6">
	                                                        <div class="pagination-panel">每次浏览&nbsp;
	                                                            <select name="pageSize" class="form-control input-xsmall input-sm input-inline" onchange="jumpPage('1')">
	                                                            	<option value="10" <c:if test="${obj.pageSize == '10' }">selected="selected"</c:if> >10</option>
	                                                                <option value="20" <c:if test="${obj.pageSize == '20' }">selected="selected"</c:if> >20</option>
	                                                                <option value="50"<c:if test="${obj.pageSize == '50' }">selected="selected"</c:if> >50</option>
	                                                                <option value="100"<c:if test="${obj.pageSize == '100' }">selected="selected"</c:if> >100</option>
	                                                            </select>&nbsp;记录 | 共有 ${obj.recordCount } 条记录
	                                                        </div>
	                                                    </div>
	                                                    <div class="actions"><a href="${contextPath}/manage/editUser" class="btn btn-info btn-xs"><i class="fa fa-plus"></i>&nbsp;新增帐号</a>&nbsp;
				                                        <!-- 
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
				                                         -->
				                                    </div>
                                                	</div>
				                                </div>
				                                <div class="portlet-body">
		                                            <table class="table table-hover table-striped table-bordered table-advanced tablesorter tb-sticky-header">
		                                                <thead class="success">
		                                                    <tr>
		                                                        <th width="3%">
		                                                            <input type="checkbox" class="checkall" />
		                                                        </th>
		                                                        <th width="15%">用户名</th>
		                                                        <th>姓名</th>
		                                                        <th width="8%">是否管理员</th>
		                                                        <th width="10%">职位</th>
		                                                        <th width="10%">部门</th>
		                                                        <th width="12%">手机</th>
		                                                        <th width="12%">邮箱</th>
		                                                        <th width="14%">操作</th>
		                                                    </tr>
		                                                </thead>
		                                                <tbody>
		                                                <c:forEach var="user" items="${obj.userList}" varStatus="status">
		                                                	<tr>
		                                                        <td>
		                                                            <input type="checkbox" />
		                                                        </td>
		                                                        <td>${user.loginAcount}</td>
		                                                        <td>${user.userName}</td>
		                                                        <td>
																	<c:choose>
																		<c:when test="${user.level == 'ENTERPRISE'}">是</c:when>
																		<c:otherwise>否</c:otherwise>
																	</c:choose>
																</td>
		                                                        <td>${user.post}</td>
		                                                        <td>${user.departure}</td>
		                                                        <td>${user.cellPhone}</td>
		                                                        <td>${user.email}</td>
		                                                        <td>
		                                                            <button type="button" class="btn btn-default btn-xs" onclick="editUser('${user.userId}')"><i class="fa fa-edit"></i>&nbsp; 编辑</button>
		                                                            <button type="button" class="btn btn-danger btn-xs" onclick="delUser('${user.userId}')"><i class="fa fa-trash-o"></i>&nbsp; 删除</button>
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
    <script src="${contextPath}/manage/vendors/jquery-tablesorter/jquery.tablesorter.js"></script>
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
    
        function editUser(id){
        	var url = "${contextPath}/manage/editUser?userId="+id;
        	window.location.href = url;
        }
        
        function delUser(id){
        	if(window.confirm("确定要删除这条记录吗？")){
        	  var url = "${contextPath}/manage/delUser?userId="+id;
        	    common_ajax(url,function(data){
        		alert("删除成功!");
        		search();
    		  });
        	}
        }
        
        var search = function(){
        	window.location.reload();
    	};
    	
    	
    	function jumpPage(currentPage){
    		var pageSize = $("select[name=pageSize] option:selected" ).val();
    		$("#pageSize").val(pageSize);
    		$("#currentPage").val(currentPage);
    		searchForm.submit();
    	}
    	
    	function ev_search(){
    		var pageSize = $("select[name=pageSize] option:selected" ).val();
    		$("#pageSize").val(pageSize);
    		$("#currentPage").val(1);
    		searchForm.submit();
    	}
    	
    	function ev_cancel(){
    		$("#acount").val("");
    		$("#userName").val("");
    		$("#dep").val("");
    		$("#cellPhone").val("");
    		
    	}
        

</script>
</body>

</html>