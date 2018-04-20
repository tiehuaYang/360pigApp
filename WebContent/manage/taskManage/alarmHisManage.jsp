<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
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
                        <div class="page-title">告警信息管理</div>
                    </div>
                    <ol class="breadcrumb page-breadcrumb">
                        <li><i class="fa fa-home"></i>&nbsp;<a href="index.jsp">首页</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li><a href="#">养殖任务</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li class="active">告警信息管理</li>
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
							                               <%--  <div class="portlet-body" style="display: none;">
							                                    <form id="searchForm" action="${contextPath}/manage/showMsgHis" class="horizontal-form" method="POST" >
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
				                                                                        <label for="categoryName" class="col-md-3 control-label">品类
				                                                                        </label>
				                                                                        <div class="col-md-8">
	                                                        								<input id="categoryName" name="categoryName"  type="text"   class="form-control" value="${obj.queryMap.categoryName}"/>
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
			                                        <!--  查询条件表单   END -->
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
                                                	</div>
				                                </div> --%>
				                                <div class="row">
														<div class="col-lg-12" style="margin-left:15px;">
															<form id="Phidden" action="${contextPath }/manage/showMsgHis" method="post">
																<input id="pageSizes" name="pageSize" type="hidden" class="form-control" value="${obj.pageSize}" />
							                                    <input id="currentPages" name="currentPage" type="hidden" class="form-control" value="${obj.currentPage}" />
																<div class="pagination-panel" style="margin-left:-10px;"> 每次浏览&nbsp; 
																	<select name="pageSize" class="form-control input-xsmall input-sm input-inline" onchange="jumpPage('1')">
																		<option value="10" <c:if test="${obj.pageSize == '10' }">selected="selected"</c:if>>10</option>
																		<option value="20" <c:if test="${obj.pageSize == '20' }">selected="selected"</c:if>>20</option>
																		<option value="50" <c:if test="${obj.pageSize == '50' }">selected="selected"</c:if>>50</option>
																		<option value="100" <c:if test="${obj.pageSize == '100' }">selected="selected"</c:if>>100</option>
																	</select>&nbsp;记录 | 共有 ${obj.recordCount } 条记录&nbsp;&nbsp; 
																	
																	<input id="batchNO" name="batchNO" type="text" style="width: 120px" class="form-control input-sm input-inline" placeholder="任务批次号" value="${obj.queryMap.batchNO}" />
																	<input id="categoryName" name="categoryName"  type="text" style="width: 120px"  class="form-control input-sm input-inline" placeholder="品类" value="${obj.queryMap.categoryName}"/>
																	<input id="userId" name="userId" type="hidden" style="width: 120px" class="form-control input-sm input-inline" value="${obj.queryMap.userId}"/>
	                                                        		<input id="userName" name="userName" style="width: 120px" onclick="ev_showUser();return false;" type="text" placeholder="点击选择养户"  class="form-control input-sm input-inline" value="${obj.queryMap.userName}"/>
																	
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
				                                <hr class="divider">
                                            	<div class="portlet-body">
		                                            <table class="table table-hover table-striped table-bordered table-advanced tablesorter tb-sticky-header">
		                                                <thead class="success">
		                                                    <tr>
		                                                        <th width="10%">任务批次号</th>
		                                                        <th width="10%">品类名称</th>
		                                                        <th width="8%">负责人员</th>
		                                                        <th width="10%">告警日期</th>
		                                                        <th width="10%">完成处理日期</th>
		                                                        <th >告警原因</th>
		                                                    </tr>
		                                                </thead>
		                                                <tbody>
		                                                <c:forEach var="alarmVO" items="${obj.alarmList}" varStatus="status">
		                                                	<tr>
		                                                        <td>${alarmVO.batchNO}</td>
			                                                    <td>${alarmVO.categoryName}</td>
			                                                     <td>${alarmVO.userName}</td>
		                                                        <td>${alarmVO.createDateStr}</td>
		                                                        <td>${alarmVO.finishTimeStr}</td>
		                                                        <td>${alarmVO.remark}</td>
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
    	activeMenu("msgManage","msgUL","MsgHisMenu");
		
        var result = "${obj.result}";
        var message = "${obj.msg}";
        if(result=='OK'){
        	toastr['success'](message, "");
        }
        else if(result=='FAIL'){
        	toastr['error'](message, "");
        }
        
    });
    
        function editTask(id){
        	var url = "${contextPath}/manage/editTask?id="+id;
        	window.location.href = url;
        }
        
        function delTask(id){
        	if(window.confirm("确定要删除这条记录吗？")){
        	  var url = "${contextPath}/manage/delTask?id="+id;
        	    common_ajax(url,function(data){
        		alert("删除成功!");
        		search();
    		  });
        	}
        }
        
        var search = function(){
        	window.location.reload();
    	};
    	
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
    	
    	
    	function jumpPage(currentPage){
     		var pageSize = $("select[name=pageSize] option:selected" ).val();
    		$("#pageSizes").val(pageSize);
    		$("#currentPages").val(currentPage);
    		Phidden.submit();
/* 			var pageSize = $( "select[name=pageSize] option:selected").val();
			var batchNO = $("#batchNO").val();
			var categoryName = $("#categoryName").val();
			var userId = $("#userId").val();
			var userName = $("#userName").val();
			var url = "${contextPath}/manage/showMsgHis?currentPage=" + currentPage + "&pageSize=" + pageSize
					+ "&batchNO=" + batchNO + "&categoryName=" + categoryName + "&userId=" + userId + "&userName=" + userName;
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
			var categoryName = $("#categoryName").val();
			var userId = $("#userId").val();
			var userName = $("#userName").val();
			var url = "${contextPath}/manage/showMsgHis?currentPage=" + currentPage + "&pageSize=" + pageSize
					+ "&batchNO=" + batchNO + "&categoryName=" + categoryName + "&userId=" + userId + "&userName=" + userName;
			window.location.href = url; */
    	}
    	
    	function ev_cancel(){
    		$("#batchNO").val("");
    		$("#categoryName").val("");
    		$("#userId").val("");
    		$("#userName").val("");
    	}
        

</script>
</body>

</html>