<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
						<div class="page-title">库存入库列表</div>
					</div>
                    <ol class="breadcrumb page-breadcrumb">
                        <li><i class="fa fa-home"></i>&nbsp;<a href="${contextPath }/manage/showIndex">首页</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li><a href="#">库存管理</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li class="active">入库单列表</li>
                    </ol>
                  <%--   <div class="col-lg-6 pull-right" style="margin-top:8px">
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
                               <input id="caseOfSearch" value="4" />
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
                                <li class="active"><a href="#table-sticky-tab" data-toggle="tab">入库单列表</a></li>
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
	                                                    <div class="actions">
	                                                    <a href="${contextPath}/manage/newInStorages"  class="btn btn-info btn-xs">
	                                                    	<i class="fa fa-plus"></i>&nbsp;新增入库
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
				                                    </div>
                                                	</div>
				                                </div>
                                            	<div class="portlet-body">
		                                            <table class="table table-hover table-striped table-bordered table-advanced tablesorter tb-sticky-header">
		                                                <thead class="success">
		                                                    <tr>
		                                                    	<th width="20%">单号</th>
		                                                        <th width="20%">日期</th>
		                                                        <th width="20%">类型</th>
		                                                       
		                                                        <th width="20%">制单人</th>
		                                                        <th >操作</th>
		                                                    </tr>
		                                                </thead>
		                                                <tbody>
		                                                <c:forEach var="inStoragesVO" items="${obj.inStoragesList}" varStatus="status">
		                                                	<tr>
		                                                        <td>${inStoragesVO.billCode}</td>
		                                                        <td><fmt:formatDate value="${inStoragesVO.createTime}" type="both"/></td>
		                                                        <td>${inStoragesVO.storageType}</td>
		                                                        
		                                                        <td>${inStoragesVO.billMaker}</td>
		                                                         
		                                                        <td> 
		                                                            <button type="button" class="btn btn-default btn-xs"  onclick="showBills('${inStoragesVO.billCode}',1)"><i class="fa fa-edit"></i>&nbsp; 查看明细</button>
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
		activeMenu("stockManage","stockUL","inStorages");
		
        var result = "${obj.result}";
        var message = "${obj.msg}";
        if(result=='OK'){
        	toastr['success'](message, "");
        }
        else if(result=='FAIL'){
        	toastr['error'](message, "");
        }
        
    });
    
    function edit(tdId,val1,val2){
    	//$("#saveBtn").show();
        document.getElementById(tdId).innerHTML = "<input type='text' id='" + tdId.substr(0,8) + "' name='maxQuantity' style='width:100%' value='"+ val1 +"'>";
        document.getElementById(tdId.toUpperCase()).innerHTML = "<input type='text' id='" + tdId.substr(0,16) + "' name='minQuantity' style='width:100%' value='"+ val2 +"'>";
    }
    
    function input_submit(id){
    	    //alert(id);
    		var maxQuantity = document.getElementById(id.substr(0, 8)).value;
    		var minQuantity = document.getElementById(id.substr(0, 16)).value;
    		//alert(maxQuantity);
    			$.post('${contextPath}/manage/saveStock',{"accessoryId":id, "maxQuantity":maxQuantity, "minQuantity":minQuantity},function(data){
        			var result = $.parseJSON(data);
        			if(result.msg == 'OK'){
        				alert('保存成功');
        				document.getElementById(id).innerHTML = "<input type='hidden' id='" + id.substr(0,8) + "' name='maxQuantity' style='width:100%'>" + maxQuantity;
        		        document.getElementById(id.toUpperCase()).innerHTML = "<input type='hidden' id='" + id.substr(0,16) + "' name='minQuantity' style='width:100%'>" + minQuantity;
        		        //$("#saveBtn").hide();
        				return true;
        			}
        			return false;
        		});
    }
        function delAccessory(id){
        	if(window.confirm("确定要删除这条记录吗？")){
        	  var url = "${contextPath}/manage/delAccessory?accessoryId="+id;
        	    common_ajax(url,function(data){
        	    	toastr['success']("删除成功", "");
          	        setTimeout(function(){
          	        	search();
          	        },600);
    		  });
        	}
        }
        function showAccessory(id){
        	var url = "${contextPath}/manage/editAccessory?accessoryId="+id;
        	window.location.href = url;
        }    
        
        function doSearch(caseNum){
        	var caseWord = ["搜商品&nbsp;", "搜订货单&nbsp;", "搜退货单&nbsp;", "搜客户&nbsp;" ,"搜库存&nbsp;"];
        	document.getElementById("searchBtn").innerHTML = caseWord[caseNum] + "<span class='caret'></span>";
        	$("#caseOfSearch").val(caseNum);
        }
    	
    	function showSearch(currentPage){
    		var pageSize = $("select[name=pageSize] option:selected" ).val();
    		var caseOfSearch = $("#caseOfSearch").val();
    		//alert(caseOfSearch);
    		var keyword = $("#keyword").val();
    		var url;
    		if(caseOfSearch == 0 ){//搜商品
    				url = "${contextPath}/manage/showAccessory?currentPage="+currentPage +"&pageSize=" + pageSize + "&keyword=" + keyword;
    		}else if(caseOfSearch == 4){//搜库存
    			url = "${contextPath}/manage/showStock?currentPage="+currentPage +"&pageSize=" + pageSize + "&keyword=" + keyword;
    		}
        	window.location.href = encodeURI(encodeURI(url)); 
    	} 
        
        var search = function(){
        	window.location.reload();
    	};
    	
    	function showBills(billCode, storageKind){
    		var url = "${contextPath}/manage/showBills?billCode="+billCode+"&storageKind="+storageKind;
        	window.location.href = url;
    	}
    	function jumpPage(currentPage){
    		var pageSize = $("select[name=pageSize] option:selected" ).val();
    		var url = "${contextPath}/manage/inStorages?currentPage="+currentPage +"&pageSize=" + pageSize;
        	window.location.href = url;
    	}
        
    	
    	

</script>
</body>

</html>