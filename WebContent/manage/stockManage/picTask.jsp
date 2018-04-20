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
                                <li class="active"><a href="#table-sticky-tab" data-toggle="tab">任务列表</a></li>
                            </ul>
                            <div id="tableadvancedTabContent" class="tab-content">
                                <div id="table-sorter-tab" class="tab-pane fade in active">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="portlet box">
                                           
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
	                                                   
                                                	</div>
				                                </div>
                                            	<div class="portlet-body">
		                                            <table class="table table-hover table-striped table-bordered table-advanced tablesorter tb-sticky-header">
		                                                <thead class="success">
		                                                    <tr>
		                                                      
		                                                          <th width="5%">选择框</th>
		                      
		                                                        <th width="13%"><i class="fa fa-search"></i>&nbsp;任务批次号</th>
		                                                        <th width="13%">品类</th>
		                                                        <th width="8%">负责人员</th>
		                                                        <th width="10%">开始时间</th>
		                                                        <th width="10%">结束时间</th>
		                                                        <th >目前进度</th>
		                                                        <th width="8%">告警次数</th>
		                                                  
		                                                    </tr>
		                                                </thead>
		                                                <tbody>
		                                                <c:forEach var="task" items="${obj.taskList}" varStatus="status">
		                                                	<tr>
		                                                        <td>
		                                                            <input type="radio" name="tasks"
																	taskId="${task.id}"
																	batchNO="${task.batchNO}"
																  />
		                                                        </td>
		                                                        <td>
		                                                        	<a href="#" onclick="showDetail('${task.id}','${task.finishPercent}')"  title="点击查看详情"><i class="fa fa-search"></i>&nbsp;${task.batchNO} </a>
		                                                        </td>
		                                                        <td>${task.categoryName}</td>
		                                                        <td>${task.userName}</td>
		                                                        <td>${task.startDay}</td>
		                                                        <td>${task.endDay}</td>
		                                                        <td>
					                                               <div id="center-text">
					                                                    <div class="progress">
					                                                        <div role="progressbar" aria-valuetransitiongoal="${task.finishPercent}" class="progress-bar progress-bar-danger two-sec-ease-in-out"></div>
					                                                    </div>
					                                                </div>
		                                                        </td>
		                                                        <td>${task.errorCount}</td>
		                                                       
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
		                                            <c:if test="${obj.pageCount > 1}">
														<div >
													      <ul class="pagination mtm mbm">
													         <c:if test="${obj.currentPage > 1}">
													           <li><a href="#" onclick="jumpPage('${obj.currentPage - 1}')" ><</a></li>
													         </c:if>
															  <c:forEach begin="1" end="${obj.pageCount}" step="1" var="pageNum">
															     <li <c:if test="${obj.currentPage == pageNum}">class="active" </c:if>><a href="#" onclick="jumpPage('${pageNum}')" >${pageNum}</a></li>
															  </c:forEach>
															  <c:if test="${obj.currentPage < obj.pageCount}">
													            <li><a href="#" onclick="jumpPage('${obj.currentPage + 1}')" >></a></li>
													         </c:if>
														   </ul>
														</div>
													</c:if>
													<c:if test="${obj.pageCount <= 1}">
														<div >
													      <ul class="pagination mtm mbm">
														  	<li class="active" ><a href="#" onclick="jumpPage('1')" >1</a></li>
														   </ul>
														</div>
													</c:if>
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

	<%@ include file="../include/footer.jsp"%>
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
					$(document).ready(
							function() {
								var result = "${obj.result}";
								var message = "${obj.msg}";
								if (result == 'OK') {
									toastr['success'](message, "");
								} else if (result == 'FAIL') {
									toastr['error'](message, "");
								}
							});

					function ev_return(id){
						
					
			    		$('input[name="tasks"]').each(function(){
			    			
			    			if( $(this).is(":checked")){
			    			
			    				
			    				if(navigator.userAgent.indexOf("Chrome") >0 ){
			    					
			    					
			    					//打开普通窗口的方式，通过调用父页面定义的js方法将值作为参数传递
			    					window.opener.document.getElementById(id).value=id;
			    					
			    				
			    					window.opener.document.getElementById(id).children[2].innerHTML="<input name='taskId'  type='hidden'  class='form-control' value='"+$(this).attr('taskId')+"' /><input name='batchNO' readonly='readonly' type='text' onclick='ev_showTask(this)' class='form-control' value='"+$(this).attr('batchNO')+"' />";
			    					
			    	    			window.close();
			    	    		}
			    	    		else{
			    	    			var category = new Object();
			    	    			category.taskId=$(this).attr("taskId");
			    	    			category.batchNO = $(this).attr("batchNO");
			    	    		
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