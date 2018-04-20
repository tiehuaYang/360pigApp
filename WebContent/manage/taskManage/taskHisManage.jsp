<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
 <!--LOADING STYLESHEET FOR PAGE-->
<link type="text/css" rel="stylesheet" href="${contextPath}/manage/vendors/jquery-tablesorter/themes/blue/style-custom.css">
<link type="text/css" rel="stylesheet" href="${contextPath}/manage/vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.1.1.min.css">
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
                        <div class="page-title">养殖任务管理</div>
                    </div>
                    <ol class="breadcrumb page-breadcrumb">
                        <li><i class="fa fa-home"></i>&nbsp;<a href="index.jsp">首页</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li><a href="#">养殖任务</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li class="active">养殖任务管理</li>
                    </ol>
                    <div class="clearfix"></div>
                </div>
                <!--END TITLE & BREADCRUMB PAGE-->
                <!--BEGIN CONTENT-->
                <div class="page-content">
                    <div id="table-advanced" class="row">
                        <div class="col-lg-12">
                            <ul id="tableadvancedTab" class="nav nav-tabs">
                                <li class="active"><a href="#table-sticky-tab" data-toggle="tab">任务列表</a></li>
                            </ul>
                            <div id="tableadvancedTabContent" class="tab-content">
                                <div id="table-sorter-tab" class="tab-pane fade in active">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="portlet box">
                                            <!--  查询条件表单    -->
	                                                <div class="col-lg-12">
		                                                <div class="portlet box">
							                                <!-- <div class="portlet-header">
							                                    <div class="caption">查询面板</div>
							                                    <div class="tools"><i class="fa fa-chevron-down"></i>
							                                    </div>
							                                </div> -->
							                                <%-- <div class="portlet-body" style="display: none;">
							                                    <form id="searchForm" action="${contextPath}/manage/showTaskHis" class="horizontal-form" method="POST" >
							                                    <input id="pageSize" name="pageSize" type="hidden" class="form-control" value="${obj.pageSize}" />
							                                    <input id="currentPage" name="currentPage" type="hidden" class="form-control" value="${obj.currentPage}" />
				                                                        <div class="form-body pal">
				                                                            <div class="row">
				                                                                <div class="col-md-6">
				                                                                    <div class="form-group" style="margin-bottom:50px;">
				                                                                        <label for="batchNO" class="col-md-3 control-label" >任务批次号
				                                                                        </label>
				                                                                        <div class="col-md-8">
				                                                                            <input id="batchNO" name="batchNO" type="text" class="form-control" value="${obj.queryMap.batchNO}" />
				                                                                        </div>
				                                                                    </div>
				                                                                </div>
				                                                                <div class="col-md-6">
				                                                                    <div class="form-group" style="margin-bottom:50px;">
				                                                                        <label for="categoryId" class="col-md-3 control-label">品类
				                                                                        </label>
				                                                                        <div class="col-md-8">
				                                                                            <input id="categoryId" name="categoryId" type="hidden" class="form-control" value="${obj.queryMap.categoryId}"/>
	                                                        								<input id="categoryName" name="categoryName" onclick="ev_showCategory();return false;" type="text" placeholder="点击选择品类"  class="form-control" value="${obj.queryMap.categoryName}"/>
				                                                                        </div>
				                                                                    </div>
				                                                                </div>
				                                                                <div class="col-md-6">
				                                                                    <div class="form-group" style="margin-bottom:50px;">
				                                                                        <label for="userName" class="col-md-3 control-label">负责人员
				                                                                        </label>
				                                                                        <div class="col-md-8">
				                                                                            <input id="userId" name="userId" type="hidden" class="form-control" value="${obj.queryMap.userId}"/>
	                                                        								<input id="userName" name="userName" onclick="ev_showUser();return false;" type="text" placeholder="点击选择养户"  class="form-control" value="${obj.queryMap.userName}"/>
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
							                                </div> --%>
							                            </div>
			                                        </div>
				                                <div class="portlet-header">
				                                <%-- <div class="row">
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
                                                	</div>
				                                </div> --%>
				                                <div class="row">
														<div class="col-lg-12" style="margin-left:15px;">
															<form id="Phidden" action="${contextPath }/manage/showTaskHis" method="post">
																<input id="pageSizes" name="pageSize" type="hidden" class="form-control" value="${obj.pageSize}" />
							                                    <input id="currentPages" name="currentPage" type="hidden" class="form-control" value="${obj.currentPage}" />
																<div class="pagination-panel" style="margin-left:-10px;"> 每次浏览&nbsp; 
																	<select name="pageSize" class="form-control input-xsmall input-sm input-inline" onchange="jumpPage('1')">
																		<option value="10" <c:if test="${obj.pageSize == '10' }">selected="selected"</c:if>>10</option>
																		<option value="20" <c:if test="${obj.pageSize == '20' }">selected="selected"</c:if>>20</option>
																		<option value="50" <c:if test="${obj.pageSize == '50' }">selected="selected"</c:if>>50</option>
																		<option value="100" <c:if test="${obj.pageSize == '100' }">selected="selected"</c:if>>100</option>
																	</select>&nbsp;记录 | 共有 ${obj.recordCount } 条记录&nbsp;&nbsp; 
																	
																	<input id="batchNO" name="batchNO" style="width: 120px" type="text" class="form-control input-sm input-inline" placeholder="任务批次号" value="${obj.queryMap.batchNO}" />
																	<input id="categoryId" name="categoryId" style="width: 120px" type="hidden" class="form-control input-sm input-inline" value="${obj.queryMap.categoryId}"/>
	                                                        		<input id="categoryName" name="categoryName" onclick="ev_showCategory();return false;" style="width: 120px" type="text" placeholder="点击选择品类"  class="form-control input-sm input-inline" value="${obj.queryMap.categoryName}"/>
	                                                        		<input id="penId" name="penId" style="width: 120px" type="hidden" class="form-control input-sm input-inline" value="${obj.queryMap.penId}"/>
	                                                        		<input id="penName" name="penName" style="width: 120px" onclick="ev_showPen();return false;" type="text" placeholder="点击选择栋舍"  class="form-control input-sm input-inline" value="${obj.queryMap.penName}"/>
																	<%-- <input id="supplyerName" name="supplyerName" style="width: 120px" type="text"  placeholder="请输入批次号" 
																	    value="${obj.queryMap.supplyerName}" class="form-control input-sm input-inline" />&nbsp;&nbsp;
																	<input id="startDate" name="startDate" autocomplete="off" style="width: 120px" type="text" placeholder="点击选择养户"
																		value="${obj.queryMap.startDate}" class="form-control input-sm input-inline" />
																	<input  id="endDate" name="endDate"  autocomplete="off" style="width: 120px" type="text" placeholder="点击选择品类" 
																		value="${obj.queryMap.endDate}" class="form-control input-sm input-inline" />&nbsp; 
																	<input type="hidden" name="typehidden" value="P" />  --%>
																	<input type="button" class="btn btn-info btn-xs f4" style="height:30px;padding:2px 12px;" onclick="ev_search()" value="查询" autocomplete="off">
																	<input type="button"  class="btn btn-info btn-xs f4" style="height:30px;padding:2px 12px;" value = "清除查询条件" onclick="ev_cancel()"/>
																	<%-- <input type="button" class="btn btn-info btn-xs f4" style="height: 25px; padding: 2px 12px;color:#ffffff;background-color:#f58953;border-color:#f58953;float:right;" 
																		onclick="showSelect('${obj.currentPage}')" value="+ 新增养殖任务" /> --%>
																	<%-- <div class="actions"><a href="${contextPath}/manage/editCategory" class="btn btn-info btn-xs"><i class="fa fa-plus"></i>&nbsp;新增养殖任务</a>&nbsp; --%>
																</div>
															</form>
														</div>
				                                    </div>
				                                </div>
				                                <!-- <div class="divider" style="border:1px solid rgba(0,0,0,.05);margin-top:15px;"></div> -->
				                                <hr class="divider">
                                            	<div class="portlet-body">
		                                            <table class="table table-hover table-striped table-bordered table-advanced tablesorter tb-sticky-header">
		                                                <thead class="success">
		                                                    <tr>
		                                                        <th width="3%">
		                                                            <input type="checkbox" class="checkall" />
		                                                        </th>
		                                                        <th width="12%"><i class="fa fa-search"></i>&nbsp;任务批次号</th>
		                                                        <th width="12%">品类</th>
		                                                        <th width="8%">负责栋舍</th>
		                                                        <th width="8%">进苗数</th>
		                                                        <th width="8%">上市数</th>
		                                                        <th width="8%">成活数</th>
		                                                        <th width="8%">上市重量</th>
		                                                        <th width="8%">成活率</th>
		                                                        <th width="8%">上市率</th>
		                                                        <th width="8%">均重</th>
		                                                        <th width="8%">告警次数</th>
		                                                    </tr>
		                                                </thead>
		                                                <tbody>
		                                                <c:forEach var="task" items="${obj.taskList}" varStatus="status">
		                                                	<tr>
		                                                        <td>
		                                                            <input type="checkbox" />
		                                                        </td>
		                                                        <td>
		                                                        	<a href="#" onclick="showTask('${task.id}')"  title="点击查看详情"><i class="fa fa-search"></i>&nbsp;${task.batchNO} </a>
		                                                        </td>
		                                                        <td>${task.categoryName}</td>
		                                                        <td>${task.farmPenVO.penName}</td>
		                                                        <td>${task.initAmount}</td>
		                                                        <td>${task.marketAmount}</td>
		                                                        <td>${task.acturyAmount}</td>
		                                                        <td>${task.marketWeight}</td>
		                                                        <td>
		                                                        	<c:choose>
		                                                        		<c:when test="${task.acturyAmount != 0}">
		                                                        			<fmt:formatNumber type="number" value="${task.acturyAmount/task.initAmount*100}" maxFractionDigits="2"/> %
		                                                        		</c:when>
		                                                        		<c:otherwise>
		                                                        		0
		                                                        		</c:otherwise>
		                                                        	</c:choose>
		                                                        </td>
		                                                        <td>
		                                                        	<c:choose>
		                                                        		<c:when test="${task.acturyAmount != 0}">
		                                                        			<fmt:formatNumber type="number" value="${task.marketAmount/task.initAmount*100}" maxFractionDigits="2"/> %
		                                                        			</c:when>
		                                                        		<c:otherwise>
		                                                        		0
		                                                        		</c:otherwise>
		                                                        	</c:choose>
		                                                        </td>
		                                                        <td>
		                                                        	<c:choose>
		                                                        		<c:when test="${task.acturyAmount != 0}">
		                                                        			<fmt:formatNumber type="number" value="${task.marketWeight/task.acturyAmount*100}" maxFractionDigits="2"/> %
		                                                        		</c:when>
		                                                        		<c:otherwise>
		                                                        		0
		                                                        		</c:otherwise>
		                                                        	</c:choose>
		                                                        </td>
		                                                        <td>${task.errorCount}</td>
		                                                    </tr>
		                                                </c:forEach>
		                                                </tbody>
		                                            </table>
		                                         
		                                        </div>
		                                         <div class="col-lg-6">
													<div class="pagination-panel" style="margin-left:-7px;">
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
    <script src="${contextPath}/manage/vendors/jquery-tablesorter/jquery.tablesorter.js"></script>
    <script src="${contextPath}/manage/js/table-advanced.js"></script>
    <script src="${contextPath}/manage/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
    <script src="${contextPath}/manage/js/ui-progressbars.js"></script>
    <!--用于分页-->
    <script src="${contextPath}/manage/js/page/bootstrap-paginator.js"></script>
    <script src="${contextPath}/manage/js/page/jquery.pagination.js"></script>
    
    <script type="text/javascript">
    $(document).ready(function(){
		activeMenu("taskManage","taskUL","taskHisMenu");
		
        var result = "${obj.result}";
        var message = "${obj.msg}";
        if(result=='OK'){
        	toastr['success'](message, "");
        }
        else if(result=='FAIL'){
        	toastr['error'](message, "");
        }
        
    });
    
        function showTask(id){
        	var url = "${contextPath}/manage/showHisTaskDetail?id="+id;
        	window.location.href = url;
        }
        
        var search = function(){
        	window.location.reload();
    	};
    	
    	 function ev_showCategory(){
    	       	var url = "${contextPath}/manage/queryCategoryList";
    	    		if(navigator.userAgent.indexOf("Chrome") >0 ){
    	    			var winOption = "height=650px,width=1150px,top=10px,left=200px,resizable=yes,fullscreen=0, location=no";
    	    			var dialog = window.open(url,window, winOption);
    	    		}
    	    		else{
    	    			var args = "dialogWidth=1150px;dialogHeight=650px";
    	    			var dialog = window.showModalDialog(url,null,args);
    	    			$('#categoryId').val(dialog.categoryId);
    	    			$('#categoryName').val(dialog.categoryName);
    	    			
    	    		}
    	       }
    	       
    	       
    	       function ev_showUser(){
    	    	   	var url = "${contextPath}/manage/queryPeopleList";
    	    			if(navigator.userAgent.indexOf("Chrome") >0 ){
    	    				var winOption = "height=580px,width=900px,top=10px,left=100px,resizable=yes,fullscreen=0, location=no";
    	    				var dialog = window.open(url,window, winOption);
    	    			}
    	    			else{
    	    				var args = "dialogWidth=900px;dialogHeight=580px";
    	    				var returnVal = window.showModalDialog(url,null,args);
    	    				document.getElementById("userId").value = returnVal.userId;
    	    				document.getElementById("userName").value = returnVal.userName;
    	    			}
    	    	   }
    	
    	       function ev_showPen() {
    	           var url = "${contextPath}/manage/queryPenList";
    	           if (navigator.userAgent.indexOf("Chrome") > 0) {
    	               var winOption = "height=580px,width=900px,top=10px,left=100px,resizable=yes,fullscreen=0, location=no";
    	               var dialog = window.open(url, window, winOption);
    	           } else {
    	               var args = "dialogWidth=900px;dialogHeight=580px";
    	               var returnVal = window.showModalDialog(url, null, args);
    	               document.getElementById("penId").value = returnVal.penId;
    	               document.getElementById("penName").value = returnVal.penName;
    	           }
    	       }
    	function jumpPage(currentPage){
    		var pageSize = $("select[name=pageSize] option:selected" ).val();
    		$("#pageSizes").val(pageSize);
    		$("#currentPages").val(currentPage);
    		Phidden.submit();
/* 			var pageSize = $( "select[name=pageSize] option:selected").val();
			var batchNO = $("#batchNO").val();
			var categoryId = $("#categoryId").val();
			var categoryName = $("#categoryName").val();
			var userId = $("#userId").val();
			var userName = $("#userName").val();
			var url = "${contextPath}/manage/showTaskHis?currentPage=" + currentPage + "&pageSize=" + pageSize
					+ "&batchNO=" + batchNO + "&categoryId=" + categoryId + "&categoryName=" + categoryName + "&userId=" + userId + "&userName=" + userName;
			window.location.href = url; */
    	}
    	
    	function ev_search(){
     		var pageSize = $("select[name=pageSize] option:selected" ).val();
    		$("#pageSizes").val(pageSize);
    		$("#currentPages").val(1);
    		Phidden.submit();
/*     		currentPage = "1";
			var pageSize = $( "select[name=pageSize] option:selected").val();
			var batchNO = $("#batchNO").val();
			var categoryId = $("#categoryId").val();
			var categoryName = $("#categoryName").val();
			var userId = $("#userId").val();
			var userName = $("#userName").val();
			var url = "${contextPath}/manage/showTaskHis?currentPage=" + currentPage + "&pageSize=" + pageSize
					+ "&batchNO=" + batchNO + "&categoryId=" + categoryId + "&categoryName=" + categoryName + "&userId=" + userId + "&userName=" + userName;
			window.location.href = url; */
    	}
    	
    	function ev_cancel(){
    		$("#batchNO").val("");
    		$("#categoryId").val("");
    		$("#categoryName").val("");
    		$("#penId").val("");
    		$("#penName").val("");
    	}

</script>
</body>

</html>