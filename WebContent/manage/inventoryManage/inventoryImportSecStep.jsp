<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>

<link type="text/css" rel="stylesheet"
	href="${contextPath}/manage/vendors/jquery-bootstrap-wizard/custom.css">
<link type="text/css" rel="stylesheet"
	href="${contextPath}/manage/vendors/jquery-steps/css/jquery.steps.css">
<style>
.table th,.table td {
	text-align: center;
	vertical-align: middle !important ；//垂直居中
}

.table>thead>tr>th,.table>tbody>tr>th,.table>tfoot>tr>th,.table>thead>tr>td,.table>tbody>tr>td,.table>tfoot>tr>td
	{
	vertical-align: middle !important ；//垂直居中
}
</style>

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
					<ol class="breadcrumb page-breadcrumb pull-left">
						<li><i class="fa fa-home"></i>&nbsp;<a
							href="${contextPath}/manage/showIndex">首页</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li><a href="#">库存管理</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">库存盘点</li>
					</ol>
<%-- 					<jsp:include page="../common/searchBar.jsp" flush="true">
						<jsp:param name="defaultBtn" value="搜库存" />
						<jsp:param name="placeholder" value="请输入商品名称/编码/关键字" />
						<jsp:param name="searchType" value="4" />
					</jsp:include> --%>
					<div class="clearfix"></div>
				</div>
				<!--END TITLE & BREADCRUMB PAGE-->
				<!--BEGIN 弹出的MODAL框-->
				
				<div id="modNumForm" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" data-dismiss="modal" aria-hidden="true"
									class="close">&times;</button>
								<h4 class="modal-title">调整待定批次号数量</h4>
							</div>
							<form id="modNumsForm" class="form-horizontal" method="POST">
								<div class="modal-body">
									<div class="form">
										<input type="hidden" id="countNum">
										<input type="hidden" id="checkNum">
										<input type="hidden" id="quantityNum">
										<input type="hidden" id="modNumGoodId"> 
										<div class="form-group">
											<div class="col-lg-12">
												<table id="modNumTb" class="table table-hover table-striped table-bordered table-advanced tablesorter">
													<thead>
														<tr>
															<th width="45%">待定批次号序号</th>
															<th width="45%">盘点数量</th>
															<th width="10%">操作</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td>原待定批次号</td>
															<td><input type="text" id="batchIndex1" style="text-align: center" onkeyup="input_checked(this)"></td>
															<td><em class="fa fa-times" style="cursor:pointer" onclick="delTr(1)"></em></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
										<button type="button" class="btn btn-primary" onclick="addTr()">新增待定批次号</button>
										<br />
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-info" onclick="submitTr()">确认</button>
									<button type="button" data-dismiss="modal" class="btn btn-default">关闭</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				
				
				<!--END MODAL CONFIG PORTLET-->

				<div class="page-content">
					<div class="row">
						<div class="col-lg-12">
							<div class="portlet box portlet-green">
								<div class="portlet-body">
									<div id="rootwizard-custom-circle">
										<div class="navbar">
											<div class="navbar-inner">
												<ul>
													<li><a href="#tab1-wizard-custom-circle"
														data-toggle="tab"><i class="fa fa-download"></i>
														<p class="anchor">1. 导入</p>
															<p class="description">根据模版导入库存盘点数据</p></a></li>
													<li><a id="preview" href="#tab2-wizard-custom-circle"
														data-toggle="tab"><i class="fa fa-th-list"></i>
														<p class="anchor">2. 预览</p>
															<p class="description">导入的数据概览</p></a></li>
													<li><a id="finish" href="#tab3-wizard-custom-circle"
														data-toggle="tab"><i class="glyphicon glyphicon-check"></i>
														<p class="anchor">3. 完成导入</p>
															<p class="description">恭喜您！数据已成功导入！</p></a></li>
												</ul>
											</div>
										</div>
										<div id="bar" class="progress active">
											<div class="bar progress-bar progress-bar-primary"></div>
										</div>
										<div class="tab-content">
											<div id="tab1-wizard-custom-circle" class="tab-pane">
												<div class="note note-info">
													<h4 class="box-heading">注意事项</h4>
													<p>1、导入文件仅支持CSV、XLS、XLXS格式，大小不超过2M，数据不超过1万行</p>
													<p>2、导入文件不能包含“合并单元格”，否则无法导入</p>
													<p>3、表格中库存数量以实际库存为准</p>
													<p>4、若没有填写盘点数量，则默认盘点数量与实际数量一致</p>
													<p>5、请不要更改或删除盘点数量以外的数据，以免导入发生错误</p>
												</div>
												<h6 class="mbxl strong">
													<strong>请选择需要导出数据的仓库</strong>
												</h6>
												<div class=" text-right pull-left">
													仓库&nbsp;
													<select id="storeId" name="storeId" class="form-control input-sm input-inline" >
														<c:forEach var="storeVO" items="${obj.storeList}" varStatus="status">
															<option value="${storeVO.storeId}">${storeVO.storeName}</option>
														</c:forEach>
													</select>&nbsp;&nbsp;&nbsp;
													<a href="#" data-toggle="dropdown" class="btn btn-warning btn-xs dropdown-toggle" style="height: 30px; padding: 2px 12px;"onclick="inventoryDownload()"> 
														<i class="fa fa-download"></i>导出成Excel</a>
												</div>
												<br> <br> <br>
												<div class="clearfix"></div>
												<h6 class="mbxl">
													<strong>请选择需要导入的Excel文件</strong>
												</h6>
												<div class="row">
													<form action="${contextPath}/manage/importInventory"
														id="importForm" enctype="multipart/form-data"
														method="post">
														<input type="hidden" name="Inventory" value="inventory.xml">
														<div class="col-md-12">
															<div class="col-md-4" style="margin-left: -15px">
																<div class="input-icon right">
																	<i class="fa fa-folder-open"></i> <input type="file"
																		id="excelfile" name="file" class="form-control">
																</div>
															</div>
															<div class="col-md-3">
																<button type="button" class="btn btn-info"
																	onclick="CheckExcel()">
																	<i class="fa fa-cloud-upload"></i>
																	&nbsp;&nbsp;&nbsp;上传&nbsp;&nbsp;&nbsp;
																</button>
															</div>
														</div>
													</form>
												</div>
												<br /> <br /> <br /> <br />
											</div>
											<div id="tab2-wizard-custom-circle" class="tab-pane">
												<div class="row">
													<div class="col-lg-12">
														<div class="portlet box">
															<div class="portlet-body">
																<form id="finishImportInventory"
																	action="${contextPath}/manage/finishImportInventory"
																	class="form-horizontal" method="POST">
																	<div style="float: right;">
																		<h4 class="text-green">经办人：${sessionScope.USERVO.userName}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;仓库：<input id="storeName" name="storeName" type="hidden" value="${obj.storeName}">${obj.storeName}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h4>
																		<input name="batchNO" type="hidden" value="${obj.batchNO}">
																	</div>
																	<table id="importTable"
																		class="table table-hover table-striped table-bordered table-advanced tablesorter tb-sticky-header">
																		<thead class="default">
																			<tr>
																				<th width="10%">商品编码</th>
																				<th>商品名称</th>
																				<th width="10%">规格</th>
																				<th width="10%">批次号</th>
																				<th width="10%">库存数量</th>
																				<th width="10%" style="text-align: center">盘点数量</th>
																				<th width="10%">盘盈盘亏</th>
																				<th width="10%">成本价&nbsp;&nbsp;<i class="fa fa-question-circle" data-toggle="tooltip" data-placement="bottom" title="盘点出库以及盘点入库已存在的批次号商品不能修改成本价"></i></th>
																				<th width="10%">备注</th>
																				<th width="10%">操作&nbsp;&nbsp;<i class="fa fa-question-circle" data-toggle="tooltip" data-placement="bottom" title="当没有批次号时允许设置多个待定批次号"></i></th>
																			</tr>
																		</thead>
																		<tbody>
																			<c:forEach var="inventoryTempVO" items="${obj.inventoryListTemp}"
																				varStatus="status">
																				<c:if test="${inventoryTempVO.countBatchNumber != inventoryTempVO.checkQuantity}">
																					<tr <c:if test="${inventoryTempVO.batchNumber == null || inventoryTempVO.batchNumber == ''}">id="goodId${inventoryTempVO.goodId}"</c:if>>
																						<input name="quantity" type="hidden" value="${inventoryTempVO.quantity}">
																						<input name="goodId" type="hidden" value="${inventoryTempVO.goodId}">
																						<input name="newBatchNumber" type="hidden" value="${inventoryTempVO.newBatchNumber}">
																						<td>
																							${inventoryTempVO.goodsCode}
																						</td>
																						<td>
																							${inventoryTempVO.goodsName}
																						</td>
																						<td>
																							<c:if test="${inventoryTempVO.specValueString == null || inventoryTempVO.specValueString == ''}">无</c:if>
																							${inventoryTempVO.specValueString}
																						</td>
																						<td>
																							<input name="batchNumber" type="hidden" 
																								value="${inventoryTempVO.batchNumber}"/>
																								<c:if test="${inventoryTempVO.batchNumber == null || inventoryTempVO.batchNumber == ''}">无</c:if>${inventoryTempVO.batchNumber}
																						</td>
																						<td>
																							<input name="countBatchNumber" type="hidden" 
																								value="${inventoryTempVO.countBatchNumber}">${inventoryTempVO.countBatchNumber}
																						</td>
																						<td>
																							<input name="checkQuantity" type="hidden" 
																								value="${inventoryTempVO.checkQuantity}">${inventoryTempVO.checkQuantity}
																						</td>
																						<td>
																							<c:choose>
																								<c:when test="${inventoryTempVO.checkQuantity - inventoryTempVO.countBatchNumber >0}">
																									<font color="green">+${inventoryTempVO.checkQuantity - inventoryTempVO.countBatchNumber}</font>
																								</c:when>
																								<c:otherwise>
																									<font color="red">${inventoryTempVO.checkQuantity - inventoryTempVO.countBatchNumber}</font> 
																								</c:otherwise>
																							</c:choose>
																						</td>
																						<td>
																							<c:choose>
																								<c:when test="${inventoryTempVO.newBatchNumber == false || (inventoryTempVO.checkQuantity - inventoryTempVO.countBatchNumber) < 0}">
																									<input name="price" type="text" value="${inventoryTempVO.batchPrice}" readonly="readonly" style="text-align:center; background-color:#E5E5E5;" >
																								</c:when>
																								<c:otherwise>
																									<input name="price" type="text" value="${inventoryTempVO.batchPrice}" style="text-align:center" onkeyup='input_checked(this)'>
																								</c:otherwise>
																							</c:choose>
																						<td>
																							<input name="remark" type="text">
																						</td>
																						<td>
																							<c:if test="${inventoryTempVO.batchNumber == null || inventoryTempVO.batchNumber == ''}">
																								<button type="button" class="btn btn-success btn-xs" data-toggle="modal" data-target="#modNumForm" onclick="showModNum('${inventoryTempVO.countBatchNumber}','${inventoryTempVO.checkQuantity}','${inventoryTempVO.goodId}','${inventoryTempVO.quantity}')">调整数量</button>
																							</c:if>
																						</td>
																					</tr>
																				</c:if>
																			</c:forEach>
																		</tbody>
																	</table>
																</form>
															</div>
														</div>
													</div>
												</div>
											</div>
											<div id="tab3-wizard-custom-circle" class="tab-pane fadeIn">
												<h3 class="mbxl">恭喜您!</h3>
												<p>本次库存的数据已经成功导入</p>
												<p>请进入库存列表查看最新的库存数据！</p>
												<br> <br> <a type="button"
													href="${contextPath}/manage/ckStorage"
													class="btn btn-default mlm">返回盘点记录列表 <i
													class="fa fa-mail-reply-all mlx"></i>
												</a>
											</div>
											<div class="action text-right">
												<button type="button" name="previous" value="Previous"
													class="btn btn-info button-previous">
													<i class="fa fa-arrow-left mrx"></i>上一步
												</button>
												<button type="button" name="next" value="Next"
													onclick="finishImport()"
													class="btn btn-info button-next mlm">
													确认导入<i class="fa fa-arrow-right mlx"></i>
												</button>
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
			<script
				src="${contextPath}/manage/vendors/jquery-validate/jquery.validate.min.js"></script>
			<script
				src="${contextPath}/manage/vendors/jquery-steps/js/jquery.steps.min.js"></script>
			<script
				src="${contextPath}/manage/vendors/jquery-bootstrap-wizard/jquery.bootstrap.wizard.min.js"></script>

			<script type="text/javascript">
    $(document).ready(function(){
    	activeMenu("inventoryManageMenu","inventoryUL","ckStorage");
    	
        var result = "${obj.result}";
        var message = "${obj.msg}";
        if(result=='OK'){
        	toastr['success'](message, "");
        }
        else if(result=='FAIL'){
        	toastr['error'](message, "");
        }
        
    });
    
	function inventoryDownload(){
		
		var storeId = $("#storeId").val();
		var url = "${contextPath}/manage/inventoryDownload?storeId=" + storeId;
		window.location.href = encodeURI(encodeURI(url));
	}
    
    function CheckExcel() {
    	var mime = document.getElementById('excelfile').value;
      	mime = mime.toLowerCase().substr(mime.lastIndexOf("."));
      	if (!(mime == ".xls")) {
       		alert("请导入正确的EXCEL文件，仅支持xls格式!");
       	return false;
      }
      	document.getElementById("importForm").submit();
     }
    
        var search = function(){
        	window.location.reload();
    	};
    	
    	$(function () {
    	    /************ #rootwizard-custom-circle ***********/
    	    $('#rootwizard-custom-circle').bootstrapWizard({
    	        onTabShow: function(tab, navigation, index) {
    	            var $total = navigation.find('li').length;
    	            var $current = index+1;
    	            var $percent = ($current/$total) * 100;
    	            $('#rootwizard-custom-circle').find('.bar').css({width:$percent+'%'});
    	        },
    	        'onNext': function(tab, navigation, index) {

    	            // select id of current tab content
    	            var $id = tab.find("a").attr("href");
    	            var $approved = 1;
    	            // Check all input validation
    	            	
    	            if ($approved !== 1) return false;
    	        },
    	        'tabClass': 'bwizard-steps-o','nextSelector': '.button-next', 'previousSelector': '.button-previous'
    	    });
    	    
    	    $("#preview").click();

    	});
    	
    	 function finishImport(){
 	    	$.ajax({
		        	  type: 'POST',
		        	  url: '${contextPath}/manage/finishImportInventory',
		        	  data: $('#finishImportInventory').serialize(),
		        	  async: false,  
		              dataType: 'json',
		        	  success: function(result){
		        		  	if(result.result == 'OK'){
		        		  		toastr['success'](data.msg, "");
		   		    	    	$("#finish").click();
		    	        	}else{
		    	        		toastr['error'](data.msg, "");
		   		    	    	$("#preview").click();
		    	        	}
		        	  }
		        });
         }
    	 
  	    function input_checked(obj){
   			obj.value = obj.value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'');
   	    }
   	    
   	    function showModNum(countNum,checkNum,id,quantity){
   	    	$("#countNum").val(countNum);
   	    	$("#checkNum").val(checkNum);
   	    	$("#batchIndex1").val(checkNum);
   	    	$("#modNumGoodId").val(id);
   	    	$("#quantityNum").val(quantity);
   	    }
   	    
   	    function addTr(){
   	    	var i = $("#modNumTb tr").length;
   	    	var newRow = "<tr><td>"+(i-1)+"</td><td><input type='text' id='batchIndex"+i+"' style='text-align: center' onkeyup='input_checked1(this)'/></td><td><em class='fa fa-times' style='cursor:pointer' onclick='delTr("+i+")'></em></td></tr>";
   	    	$("#modNumTb tr:last").after(newRow);
   	    	
   	    }
   	    
   	    function delTr(index){
   	    	var j = $("#modNumTb tr").length - 1;
   	    	if(index != 1){
	   	    	for(var i = index ; i < j ; i++){
	   	    		$("#batchIndex"+i+"").val($("#batchIndex"+(i+1)+"").val());
	   	    	}
	   	    	$("#modNumTb tr:last").remove();
   	    	}else{
   	    		toastr['error']("原待定批次号不能删除！", "");
   	    	}
   	    }
   	    
   	 function input_checked1(obj){
  	   obj.value = obj.value.replace(/[^\d]/g,"");
     }
   	 
   	 function submitTr(){
   		var j = $("#modNumTb tr").length;
   		var checkNum = $("#checkNum").val();
   		var id = $("#modNumGoodId").val();
   		var numArray=new Array()
   		var count = 0;
   		for(var i = 1 ; i < j ; i++){
   			var a = $("#batchIndex"+i+"").val();
   			if(isNaN(a)){
   				toastr['error']("请输入数字！", "");
   				return false;
   			}
   			if(i != 1 && (a == null || a == "" || a == 0)){
				toastr['error']("数量不能为零或者空！", "");
				return false;
			}else if(a == null || a == ""){
				toastr['error']("数量不能为空！", "");
				return false;
			}
   			if(a < 0){
   				toastr['error']("数量不能为负数！", "");
				return false;
   			}
   			count = count + Number(a);
			numArray[i-1] = Number(a);
   		}
   		if(count != checkNum){
   			toastr['error']("各待定批次号盘点数量之和与总盘点数量不相等！", "");
   			return false;
   		}
		if(j != 2){
			insRow($("#modNumGoodId").val(),j-1,numArray);
		}else{
			$(".tr"+id+"").remove();
			$("#goodId"+id+"").find("input").attr("disabled",false);
			$("#goodId"+id+"").find("td").css("background-color","");
		}
		$("#modNumForm").modal('hide');
   	 }
   	 
   	 function insRow(id,length,numArray){
   		$("#goodId"+id+"").find("input").attr("disabled",false);
		$(".tr"+id+"").remove();
		var index = $("#goodId"+id+"").index() - 3;
		var inputStr ="<input name='quantity' type='hidden' value="+$("#quantityNum").val()+"><input name='goodId' type='hidden' value="+id+"><input name='newBatchNumber' type='hidden' value='true'>";
		var tr1 = $("#goodId"+id+" td:eq(0)").html();
		var tr2 = $("#goodId"+id+" td:eq(1)").html();
		var tr3 = $("#goodId"+id+" td:eq(2)").html();
		var tr4 = $("#goodId"+id+" td:eq(3)").html();
		var tr8 = $("#goodId"+id+" td:eq(7)").html();
		var tr9 = $("#goodId"+id+" td:eq(8)").html();
		for(var i = 0 ; i < length ; i++){
			if(i == 0){
				var tr5 = "<input name='countBatchNumber' type='hidden' value='"+$("#countNum").val()+"'>"+$("#countNum").val();
			}else{
				var tr5 = "<input name='countBatchNumber' type='hidden' value='0'>0";
			}
			var tr6 = "<input name='checkQuantity' type='hidden' value='"+numArray[i]+"'>"+numArray[i];
			if(i == 0){
				if(numArray[i] > $("#countNum").val()){
					var tr7 = "+"+(numArray[i]-$("#countNum").val());
					var tr8 = "<input name='price' type='text' value='0' style='text-align:center' onkeyup='input_checked(this)'>"
				}else{
					var tr7 = (numArray[i]-$("#countNum").val());
					var tr8 = "<input name='price' type='text' value='0' readonly='readonly' style='text-align:center; background-color:#E5E5E5'>"
				}
			}else{
				var tr7 = "+"+numArray[i];
				var tr8 = "<input name='price' type='text' value='0' style='text-align:center' onkeyup='input_checked(this)'>"
			}
			$("#goodId"+id+"").after("<tr class='tr"+id+"'>"+inputStr+"<td>"+tr1+"</td><td>"+tr2+"</td><td>"+tr3+"</td><td>"+tr4+"</td><td>"+tr5+"</td><td>"+tr6+"</td><td>"+tr7+"</td><td>"+tr8+"</td><td>"+tr9+"</td><td></td></tr>");
			
		}
		$("#goodId"+id+"").find("td").css("background-color","#E5E5E5");
		$("#goodId"+id+"").find("input").attr("disabled",true);
   	 }
   	    
</script>
</body>

</html>