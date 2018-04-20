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
<style>
.btn-info {
margin-right:14px;
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
                    <div class="page-header pull-left">
                        <div class="page-title">品类设置</div>
                    </div>
                    <ol class="breadcrumb page-breadcrumb">
                        <li><i class="fa fa-home"></i>&nbsp;<a href="index.jsp">首页</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li><a href="#">品类管理</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li class="active">品类设置</li>
                    </ol>
                    <div class="clearfix"></div>
                </div>
                <!--END TITLE & BREADCRUMB PAGE-->
                <!--BEGIN CONTENT-->
                <div class="page-content">
                    <div id="table-advanced" class="row">
                        <div class="col-lg-12">
                            <ul id="tableadvancedTab" class="nav nav-tabs">
                                <li class="active"><a href="#table-sticky-tab" data-toggle="tab">品类信息</a></li>
                            </ul>
                            <div id="tableadvancedTabContent" class="tab-content">
                                <div id="table-sorter-tab" class="tab-pane fade in active">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="portlet box">
                                            <!--  查询条件表单    -->
	                                                <div class="col-lg-12">
		                                                <div class="portlet box">
							                                
							                            </div>
			                                        </div>
				                                <div class="portlet-header">
				                                <div class="row">
	                                                    <div class="col-lg-12" style="margin-left:15px;">
															<form id="Phidden" action="${contextPath }/manage/queryPigCategory" method="post">
																<input id="pageSizes" name="pageSize" type="hidden" class="form-control" value="${obj.pageSize}" />
							                                    <input id="currentPages" name="currentPage" type="hidden" class="form-control" value="${obj.currentPage}" />
																<div class="pagination-panel" style="margin-left:-10px;"> 每次浏览&nbsp; 
																	<select name="pageSize" class="form-control input-xsmall input-sm input-inline" onchange="jumpPage('1')">
																		<option value="10" <c:if test="${obj.pageSize == '10' }">selected="selected"</c:if>>10</option>
																		<option value="20" <c:if test="${obj.pageSize == '20' }">selected="selected"</c:if>>20</option>
																		<option value="50" <c:if test="${obj.pageSize == '50' }">selected="selected"</c:if>>50</option>
																		<option value="100" <c:if test="${obj.pageSize == '100' }">selected="selected"</c:if>>100</option>
																	</select>&nbsp;记录 | 共有 ${obj.recordCount } 条记录&nbsp;&nbsp; 

																	<input id="categoryName" name="categoryName"  type="text" class="form-control input-sm input-inline" placeholder="品类名称" value="${obj.categoryName}"/>

																	<input type="button" class="btn btn-info btn-xs f4" style="height:30px;padding:2px 12px;" onclick="ev_search()" value="查询" autocomplete="off">
																	<div class="actions"><a href="#" data-toggle="modal" data-target="#newCategoryModal" class="btn btn-info btn-xs"><i class="fa fa-plus"></i>&nbsp;新增品类</a>&nbsp;
																</div>
															</form>
														</div>
	                                                    
				                                    </div>
                                                	</div>
				                                </div>
				                                <hr class="divider">
                                            	<div class="portlet-body">
		                                            <table class="table table-hover table-striped table-bordered table-advanced tablesorter tb-sticky-header">
		                                                <thead class="success">
		                                                    <tr>
		                                                        <th width="3%">
		                                                            <input type="checkbox" class="checkall" />
		                                                        </th>
		                                                        <th width="15%">品类名称</th>
		                                                        <th width="10%">排序值</th>
		                                                        <th width="14%">操作</th>
		                                                    </tr>
		                                                </thead>
		                                                <tbody>
		                                                <c:forEach var="pigCategory" items="${obj.pigCategoryList}" varStatus="status">
		                                                	<tr>
		                                                        <td>
		                                                            <input type="checkbox" />
		                                                        </td>
		                                                        <td>${pigCategory.categoryName}</td>
		                                                        <td>${pigCategory.level}</td>
		                                                        <td>
		                                                            <button type="button" class="btn btn-default btn-xs" onclick="editCategory('${pigCategory.categoryId}')"><i class="fa fa-edit"></i>&nbsp; 编辑</button>
		                                                            <button type="button" class="btn btn-danger btn-xs" onclick="delCategoryModal('${pigCategory.categoryId}')"><i class="fa fa-trash-o"></i>&nbsp; 删除</button>
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
                        </div>
                    </div>
                </div>
                <!--END CONTENT-->
                <div id="newCategoryModal" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" data-dismiss="modal" aria-hidden="true"
									class="close">&times;</button>
								<h4 class="modal-title">新增品类</h4>
							</div>
							<form id="newCategoryModalForm" class="form-horizontal" method="post" >
									<div class="modal-body">
											<div class="form">
												<div class="form-group">
											        <label for="品类名称" class="control-label col-md-3">品类名称</label>
											        <div class="col-md-7">
											            <input name="categoryName" type="text" class="form-control" />
											        </div>
											    </div>
											    
											    <div class="form-group">
											        <label for="排序值" class="control-label col-md-3">排序值</label>
											        <div class="col-md-7">
											            <input name="level"  type="text" class="form-control" />
											        </div>
											    </div>
											</div>
									</div>
									<div class="modal-footer">
										<button type="submit" class="btn btn-primary">保存</button>
										<button type="button" data-dismiss="modal" class="btn btn-default">关闭</button>
									</div>
								</form>
						</div>
					</div>
				</div>
				
				<div id="editCategoryModal" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" data-dismiss="modal" aria-hidden="true"
									class="close">&times;</button>
								<h4 class="modal-title">编辑品类</h4>
							</div>
							<form id="editCategoryModalForm" class="form-horizontal" method="post" >
									<div class="modal-body">
											<input name="categoryId" type="hidden" />
											<div class="form">
												<div class="form-group">
											        <label for="品类名称" class="control-label col-md-3">品类名称</label>
											        <div class="col-md-7">
											            <input name="categoryName" type="text" class="form-control" />
											        </div>
											    </div>
											    
											    <div class="form-group">
											        <label for="排序值" class="control-label col-md-3">排序值</label>
											        <div class="col-md-7">
											            <input name="level" type="text" class="form-control" />
											        </div>
											    </div>
											</div>
									</div>
									<div class="modal-footer">
										<button type="submit" class="btn btn-primary">保存</button>
										<button type="button" data-dismiss="modal" class="btn btn-default">关闭</button>
									</div>
								</form>
						</div>
					</div>
				</div>
				
				<div id="delCategoryModal" class="modal fade" tabindex="-1" role="dialog" labelledby="" aria-hidden="true">
				    <div class="modal-dialog modal-md">
				        <div class="modal-content">
				            <div class="modal-header">
				                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				                <h4>提示</h4>
				            </div>
				            <div class="modal-body add-modal-body">
				                <p class="text-danger" style="font-size:15px;">确定要删除该品类吗？</p>
				                <input type="hidden" name="categoryId"/>
				            </div>
				            <div class="modal-footer">
				                <a class="btn btn-primary"  onclick="delCategoryModalForm()">确定</a>
				                <a class="btn btn-default" data-dismiss="modal">取消</a>
				            </div>
				        </div>
				    </div>
				</div>
                
            </div>
            <!--BEGIN FOOTER-->
            <%@ include file="../include/footer.jsp"%>
            <script src="${contextPath}/vendors/jquery-validate/jquery.validate.min.js"></script>
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
			activeMenu("pigCategoryManageMenu","pigCategoryUL","pigCategoryMenu");
			
	        var result = "${obj.result}";
	        var message = "${obj.msg}";
	        if(result=='OK'){
	        	toastr['success'](message, "");
	        }
	        else if(result=='FAIL'){
	        	toastr['error'](message, "");
	        }
	        
	    });
        
        var search = function(){
        	window.location.reload();
    	};
    	
    	
    	function jumpPage(currentPage){
     		var pageSize = $("select[name=pageSize] option:selected" ).val();
    		$("#pageSizes").val(pageSize);
    		$("#currentPages").val(currentPage);
    		Phidden.submit();
    	}
    	
    	function ev_search(){
     		var pageSize = $("select[name=pageSize] option:selected" ).val();
    		$("#pageSizes").val(pageSize);
    		$("#currentPages").val(1);
    		Phidden.submit();
    	}
    	
    	function ev_cancel(){
    		$("#categoryName").val("");
    	}
    	
    	
        function editCategory(id){
        	$.ajax({
                type: 'POST',
                url: '${contextPath}/manage/fetchCategory',
                data: {categoryId:id},
                async: false,
                dataType: 'json',
                success: function(result) {
                	var input = $("#editCategoryModalForm input");
                	for(var i =0;i<input.length;i++){
                		var temp = eval("result.obj."+$(input[i]).attr("name"));
                		$(input[i]).val(temp);
                	}
                	
                	var select = $("#editCategoryModalForm select");
                	for(var i =0;i<select.length;i++){
                		var temp = eval("result.obj."+$(select[i]).attr("name"));
                		$(select[i]).val(temp);
                		$(select[i]).selectpicker('refresh');
                	}
                }
            });
        	$("#editCategoryModal").modal("show");
        }
    	
    	
    	
    	
    	$(document).ready(function() {
    	    //新增验证
    	    $("#newCategoryModalForm").validate({
    	        rules: {
    	        	categoryName: {
    	                required: true,
    	                maxlength: 30
    	            },
    	            level: {
    	                required: true,
    	                number:true
    	            }
    	        },
    	        messages: {
    	        	categoryName: {
    	                required: '品类名称不能为空',
    	                maxlength: '长度不能超过30个字符'
    	            },
    	            level: {
    	                required: '排序值不能为空',
    	                number: '请输入正确的数字'
    	            }
    	        },
    	        submitHandler: function(form) {
    	            $.ajax({
    	                type: 'POST',
    	                url: '${contextPath}/manage/saveCategory',
    	                data: $('#newCategoryModalForm').serialize(),
    	                async: false,
    	                dataType: 'json',
    	                success: function(result) {
    	                    if (result.result == 'OK') {
    	                        toastr['success'](result.msg, "");
    	                        setTimeout(function() {
    	                            window.location.href = "${contextPath}/manage/queryPigCategory";
    	                        }, 2000);
    	                    } else {
    	                        toastr['error'](result.msg, "");
    	                    }
    	                }
    	            });
    	        }
    	    });



    	    //编辑验证
    	    $("#editCategoryModalForm").validate({
    	        rules: {
    	        	categoryName: {
    	                required: true,
    	                maxlength: 30
    	            },
    	            level: {
    	                required: true,
    	                number:true
    	            }
    	        },
    	        messages: {
    	        	categoryName: {
    	                required: '品类名称不能为空',
    	                maxlength: '长度不能超过30个字符'
    	            },
    	            level: {
    	                required: '排序值不能为空',
    	                number: '请输入正确的数字'
    	            }
    	        },
    	        submitHandler: function(form) {
    	            $.ajax({
    	                type: 'POST',
    	                url: '${contextPath}/manage/saveCategory',
    	                data: $('#editCategoryModalForm').serialize(),
    	                async: false,
    	                dataType: 'json',
    	                success: function(result) {
    	                    if (result.result == 'OK') {
    	                        toastr['success'](result.msg, "");
    	                        setTimeout(function() {
    	                            window.location.href = "${contextPath}/manage/queryPigCategory";
    	                        }, 2000);
    	                    } else {
    	                        toastr['error'](result.msg, "");
    	                    }
    	                }
    	            });
    	        }
    	    });
    	    
    	    
    	});
    	
        function delCategoryModal(id){
        	$("#delCategoryModal input[name=\"categoryId\"]").val(id);
        	$("#delCategoryModal").modal("show");
        }
    	
        function delCategoryModalForm(){
            $.ajax({
                type: 'POST',
                url: '${contextPath}/manage/deleteCategory',
                data: {categoryId:$("#delCategoryModal input[name=\"categoryId\"]").val()},
                async: false,
                dataType: 'json',
                success: function(result) {
                    if (result.result == 'OK') {
                        toastr['success'](result.msg, "");
                        setTimeout(function() {
                        	window.location.href = "${contextPath}/manage/queryPigCategory";
                        }, 2000);
                    } else {
                        toastr['error'](result.msg, "");
                    }
                }
            });
        }
</script>
</body>

</html>