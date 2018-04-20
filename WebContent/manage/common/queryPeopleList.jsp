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
    <!--END SIDEBAR MENU-->
    <!--BEGIN PAGE WRAPPER-->
            <div class="page-content">
                    <div id="table-advanced" class="row">
                        <div class="col-lg-12">
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
		                                                        <th width="3%">
		                                                            <input type="checkbox" class="checkall" />
		                                                        </th>
		                                                        <th>姓名</th>
		                                                        <th width="15%">职位</th>
		                                                        <th width="15%">部门</th>
		                                                        <th width="18%">手机</th>
		                                                        <th width="18%">邮箱</th>
		                                                    </tr>
		                                                </thead>
		                                                <tbody>
		                                                <c:forEach var="user" items="${obj.userList}" varStatus="status">
		                                                	<tr>
		                                                        <td>
		                                                            <input type="radio" name="userRadio" userId="${user.userId}" userName="${user.userName}"/>
		                                                        </td>
		                                                        <td>${user.userName}</td>
		                                                        <td>${user.post}</td>
		                                                        <td>${user.departure}</td>
		                                                        <td>${user.cellPhone}</td>
		                                                        <td>${user.email}</td>
		                                                    </tr>
		                                                </c:forEach>
		                                                </tbody>
		                                            </table>
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
		                                        <div class="form-actions text-right pal">
	                                                <button type="button" class="btn btn-primary" onclick="ev_return()">确定选择</button>&nbsp;
	                                                <button type="button" class="btn btn-green" onclick="ev_back()">取消</button>
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
    </div>
<!--LOADING SCRIPTS FOR PAGE-->
    <script src="${contextPath}/manage/js/jquery-1.10.2.min.js"></script>
    <script src="${contextPath}/manage/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="${contextPath}/manage/js/jquery-ui.min.js"></script>
    <!--loading bootstrap js-->
    <script src="${contextPath}/manage/vendors/bootstrap/js/bootstrap.min.js"></script>
    <script src="${contextPath}/manage/js/html5shiv.js"></script>
    <script src="${contextPath}/manage/js/respond.min.js"></script>
    
    <!--LOADING SCRIPTS FOR PAGE-->
    <script src="${contextPath}/manage/vendors/jquery-tablesorter/jquery.tablesorter.js"></script>
    <script src="${contextPath}/manage/js/table-advanced.js"></script>
    <!--用于分页-->
    <script src="${contextPath}/manage/js/page/bootstrap-paginator.js"></script>
    <script src="${contextPath}/manage/js/page/jquery.pagination.js"></script>
    
        <script src="${contextPath}/manage/vendors/iCheck/icheck.min.js"></script>
    <script src="${contextPath}/manage/vendors/iCheck/custom.min.js"></script>
    
    <script type="text/javascript">

    $(function()
    		{
				   
    				$('input').iCheck({
    					checkboxClass: 'icheckbox_minimal-green',
    					radioClass: 'icheckbox_minimal-green',
				    	  increaseArea : '50%' 
				    });
    
    
    		});
        
        var ev_back = function(){
        	window.close();
    	};
    	
    	
    	
    	function ev_return(){
    		$('input[name="userRadio"]').each(function(){
    			if( $(this).is(":checked")){
    				if(navigator.userAgent.indexOf("Chrome") >0 ){
    					//打开普通窗口的方式，通过调用父页面定义的js方法将值作为参数传递
    	    			window.opener.document.getElementById("userId").value=$(this).attr("userId");
    	    			window.opener.document.getElementById("userName").value=$(this).attr("userName");
    	    			window.close();
    	    		}
    	    		else{
    	    			var user = new Object();
    	    			user.userId = $(this).attr("userId");
    	    			user.userName = $(this).attr("userName");
    	    			//模态窗口的方式，给模态窗口返回父页面 赋值，父页面接收
    	    			window.returnValue = user;
    	    			window.close();
    	    		}
    			}
	         });
    	}
    	
    	function jumpPage(currentPage){
    		var pageSize = $("select[name=pageSize] option:selected" ).val();
    		var url = "${contextPath}/manage/queryPeopleList?currentPage="+currentPage +"&pageSize=" + pageSize;
        	window.location.href = url;
    	}
        

</script>
</body>

</html>