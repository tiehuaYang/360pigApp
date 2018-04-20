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
						<div class="page-title">库存管理</div>
					</div>
                    <ol class="breadcrumb page-breadcrumb">
                        <li><i class="fa fa-home"></i>&nbsp;<a href="${contextPath }/manage/showIndex">首页</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li><a href="#">库存管理</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li class="active">物料库存</li>
                    </ol>
                <%--     <div class="col-lg-6 pull-right" style="margin-top:8px">
                    	<div class="input-group input-group-sm mbs" >
                        	<span class="input-group-btn">
                        		<button id="searchBtn" type="button" data-toggle="dropdown" class="btn btn-default dropdown-toggle">搜库存&nbsp;
                        			<span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu">
                                	<li value="0" onclick="doSearch(0)"><a href="#">&nbsp;搜商品</a></li>
                                	<li value="1" onclick="doSearch(1)"><a href="#">&nbsp;搜订货单</a></li>
                                    <li value="2" onclick="doSearch(2)"><a href="#">&nbsp;搜退货单</a></li>
                                    <li value="3" onclick="doSearch(3)"><a href="#">&nbsp;搜客户</a></li>
                                    <li value="4" onclick="doSearch(4)"><a href="#">&nbsp;搜库存</a></li>
                               </ul>
                               <input id="caseOfSearch" value="4" type="hidden"/>
                           </span>
                           <input id="keyword" value="${obj.keyword}" type="text" placeholder="请输入商品名称/编码/规格/关键字/条形码" class="form-control" /><span class="input-group-btn"><button type="button" onclick="showSearch('${obj.currentPage}')" class="btn btn-success dropdown-toggle"><i  class="fa fa-search"></i></button></span>
                       </div>
                   </div> --%>
                   <div class="clearfix"></div>
                </div>
                <!--END TITLE & BREADCRUMB PAGE-->
                
                <!--BEGIN CONTENT-->
                
                
                
                <div class="page-content">
                    <div id="table-advanced" class="row">
                        <div class="col-lg-12">
                            <ul id="tableadvancedTab" class="nav nav-tabs">
                                <li class="active"><a href="#table-sticky-tab" data-toggle="tab">库存列表</a></li>
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
	                                                    <div class="actions" >
	                                                      		<h4 class="text-green" >仓库当前总额：￥${obj.sum}元&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h4>
	                                                    </div>
	<%--                                                   <a href="${contextPath}/manage/editGood"  class="btn btn-info btn-xs">
	                                                    	<i class="fa fa-plus"></i>&nbsp;新增商品
	                                                    </a>&nbsp;
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
				                                     --%>
                                                	</div>
				                                </div>
                                            	<div class="portlet-body">
		                                            <table class="table table-hover table-striped table-bordered table-advanced tablesorter tb-sticky-header">
		                                                <thead class="success">
		                                                    <tr>
		                                                    	<th width="15%">编码</th>
		                                                        <th width="15%">物料</th>
		                                                        
		                                                        
		                                                        <th width="15%">库存上限</th>
		                                                        <th width="15%">库存下限</th>
		                                                        <th width="15%">库存数量</th>
		                                                        <th width="15%">操作</th>
		                                                    </tr>
		                                                </thead>
		                                                <tbody>
		                                                <c:forEach var="stockVO" items="${obj.stockList}" varStatus="status">
		                                                	<%-- <form id="${inventoryVO.goodId.replace('-','')}"> --%>
		                                                	<tr>
		                                                       <td>${stockVO.materialCode}</td>
		                                                        <td>${stockVO.materialName}</td>
		                                                      
		                                                      
		                                                        <td id="max${stockVO.materialId}"><input type="hidden" id="maxQuantity${stockVO.materialId}" style="width:100%" name="maxQuantity" value="${stockVO.maxQuantity}">${stockVO.maxQuantity}</td>
		                                                        <td id="min${stockVO.materialId}"><input type="hidden" id="minQuantity${stockVO.materialId}" style="width:100%" name="minQuantity" value="${stockVO.minQuantity}">${stockVO.minQuantity}</td>
		                                                        <td>${stockVO.quantity}</td>
		                                                        <td> 
		                                                            <button type="button" id="editBtn${stockVO.materialId}" class="btn btn-default btn-xs"  onclick="edit('${stockVO.materialId}')"><i class="fa fa-edit"></i>&nbsp; 修改</button>
		                                                            <button type="button" id="saveBtn${stockVO.materialId}" style="display: none" class="btn btn-danger btn-xs" data-id = "${stockVO.materialId}" onclick="input_submit('${stockVO.materialId}')"><i class="fa fa-check"></i>&nbsp; 保存</button>
		                                                        </td>
		                                                    </tr>
		                                                    <!-- </form> -->
		                                                    <%-- <div id="editInventory" class="modal fade">
                												<div class="modal-dialog">
                    												<div class="modal-content">
                        												<div class="modal-header">
                            												<button type="button" data-dismiss="modal" aria-hidden="true" class="close">&times;</button>
                            												<h4 class="modal-title">${inventoryVO.goodsName}--库存设置</h4>
                        												</div>
                        												<form class="form-horizontal" action="${contextPath}/manage/saveType" method="POST" >
                        												<div class="modal-body">
                             												<div class="form">
                                 												<br/>
                                 												<br/>
                                     											<div class="row form-group">
                                         											<label for="库存上限" class="control-label col-md-3" style="margin-left:30px;margin-right:-30px;">库存上限</label>
                                         											<div class="col-md-7">
                                             											<input id="maxQuantity" name="maxQuantity" type="text" class="form-control" />
                                         											</div>
                                     											</div>
                                     											<div class="row form-group">
                                         											<label for="库存下限" class="control-label col-md-3" style="margin-left:30px;margin-right:-30px;">库存下限</label>
                                         											<div class="col-md-7">
                                         												<input id="minQuantity" name="minQuantity" type="text" class="form-control"/>
                                         											</div>
                                     											</div>
                             												</div>
                        												</div>
                        												<br/>
                        												<div class="modal-footer">
                        													<button type="button" class="btn btn-primary" onclick="ev_save();">保存</button>
                            												<button type="button" data-dismiss="modal" class="btn btn-default">关闭</button>
                        												</div>
                        												</form>
                    												</div>
                												</div>
            												</div> --%>
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
		activeMenu("stockManage","stockUL","stockList");
		
        var result = "${obj.result}";
        var message = "${obj.msg}";
        //alert(message);
        if(result=='OK'){
        	toastr['success'](message, "");
        }
        else if(result=='FAIL'){
        	toastr['error'](message, "");
        }
        
    });
    
    function edit(id){
    	$("#saveBtn"+id).show();
    	$("#editBtn"+id).hide();
    	var maxQuantity = document.getElementById("maxQuantity"+id).value;
		var minQuantity = document.getElementById("minQuantity"+id).value;
        document.getElementById("max"+id).innerHTML = "<input type='text' id='maxQuantity" + id + "' name='maxQuantity' onkeyup='input_checked(this)' style='width:100%' value='"+ maxQuantity +"'>";
        document.getElementById("min"+id).innerHTML = "<input type='text' id='minQuantity" + id + "' name='minQuantity' onkeyup='input_checked(this)' style='width:100%' value='"+ minQuantity +"'>";
    }
    
    function input_submit(id){
    	    //alert(id);
    		var maxQuantity = document.getElementById("maxQuantity"+id).value;
    		var minQuantity = document.getElementById("minQuantity"+id).value;
    		if(parseInt(maxQuantity) < parseInt(minQuantity)){
    			alert("库存上限不能小于库存下限！");
    		}else{
    			$.post('${contextPath}/manage/saveStock',{"materialId":id, "maxQuantity":maxQuantity, "minQuantity":minQuantity},function(data){
        			if(data.result == 'OK'){ 
        				alert('保存成功');
        				if(maxQuantity != ""){
        					document.getElementById("max"+id).innerHTML = "<input type='hidden' id='maxQuantity" + id + "' name='maxQuantity' style='width:100%' value='"+maxQuantity+"'>" + maxQuantity;
        				}else{
        					document.getElementById("max"+id).innerHTML = "<input type='hidden' id='maxQuantity" + id + "' name='maxQuantity' style='width:100%' value='"+maxQuantity+"'>" + 0;
        				}
        				if(minQuantity != ""){
        		        	document.getElementById("min"+id).innerHTML = "<input type='hidden' id='minQuantity" + id + "' name='minQuantity' style='width:100%' value='"+minQuantity+"'>" + minQuantity;
        				}else{
        					document.getElementById("min"+id).innerHTML = "<input type='hidden' id='minQuantity" + id + "' name='minQuantity' style='width:100%' value='"+minQuantity+"'>" + 0;
        				}
        		        $("#saveBtn"+id).hide();
        		        $("#editBtn"+id).show();
        				return true;
        			}
        			return false; 
        		});
    		}
    			
    }
     
      
        
        
        var search = function(){
        	window.location.reload();
    	};
    	
    	
    	
    	
    	
    	//只能输入数字和小数点
    	   function input_checked(obj){
    		   obj.value = obj.value.replace(/[^\d.]/g,"");
    	   }
    	
    	   
    	function jumpPage(currentPage){
    		var pageSize = $("select[name=pageSize] option:selected" ).val();
    		var keyword = "${obj.keyword}";
    		var url = "${contextPath}/manage/showStock?currentPage="+currentPage +"&pageSize=" + pageSize + "&keyword=" + keyword;
        	window.location.href = encodeURI(encodeURI(url));
    	}
        
    	
    	

</script>
</body>

</html>