<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
<script type="text/javascript"
	src="${contextPath}/manage/js/ckeditor/ckeditor.js"></script>
<link type="text/css" rel="stylesheet"
	href="${contextPath}/manage/vendors/jquery-tablesorter/themes/blue/style-custom.css">
</head>



<style>
.modal-body{
	height: auto !important;
}
.table th,.table td {
	text-align: center;
	vertical-align: middle !important ；//垂直居中
}

.table>thead>tr>th,.table>tbody>tr>th,.table>tfoot>tr>th,.table>thead>tr>td,.table>tbody>tr>td,.table>tfoot>tr>td
	{
	vertical-align: middle !important ；//垂直居中
}
.goods-pic{
	display: inline-block;
    height: 50px;
    width: 50px;
    vertical-align: middle;
    margin-right: 5px;
}
.goods-pic img{
	width: 50px;
}
._goods-list{
	position: absolute;
	left: 0;
    z-index: 1000;
    display: block;
    background: #fff;
    border: 1px solid #33485c;
    max-height: 300px;
    overflow: auto;
    display: none;
}
._goods-list div{
	position: relative;
    cursor: pointer;
    color: #555;
    background: #FFF;
    line-height: 50px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    text-align: left;
}
input[name="goodId"]{
	height: 34px;
	width: 100%;
}
._item:hover{
	background-color: #ddd;
}
._item-clone{
	text-align: left;
	white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    cursor: pointer;
}
.table>tbody>tr>td{
	vertical-align: middle;
}
.show-goods{
	position: absolute;
    right: 0;
    line-height: 34px;
    padding: 0 5px;
}
.show-goods:hover{
	color: #e74c3c;
    cursor: pointer;
}
#goodslist-tbody tr td img{
	height: 40px;
}
.modal-body .search-group{
	padding-bottom: 15px;
	border-bottom: 1px solid #ddd;
}
.modal-body .search-group input{
	width: 400px;
	height: 34px;
	padding: 0 5px;
	margin-top:-3px;
}
.modal-body .search-group button{
	width: 100px;
	height: 34px;
	font-family: 'Microsoft Yahei';
}
#goodslist-tbody input{
	text-align: center;
}
._goods-list .goods-list-load,
.isFoot{
	line-height:50px;
	text-align:center;
	color:#e74c3c;
	opacity: 1;
	transition: opacity 1s;
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
						<li><i class="fa fa-home"></i>&nbsp;<a
							href="${contextPath}/manage/showIndex">首页</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li><a href="#">库存管理</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">新增出库</li>
					</ol>
<%-- 					<jsp:include page="../common/searchBar.jsp" flush="true">
						<jsp:param name="defaultBtn" value="搜库存" />
						<jsp:param name="placeholder" value="请输入物料名称/编码/关键字" />
						<jsp:param name="searchType" value="4" />
					</jsp:include> --%>
					<div class="clearfix"></div>
				</div>
				<!--END TITLE & BREADCRUMB PAGE-->

				<!--BEGIN CONTENT-->

				<div class="page-content">
					<div id="table-advanced" class="row">
						<div class="col-lg-12">
							<ul id="tableadvancedTab" class="nav nav-tabs">
								<li class="active"><a href="#table-sticky-tab" data-toggle="tab">新增出库</a></li>
							</ul>
							<div id="tableadvancedTabContent" class="tab-content">
								<div id="table-sorter-tab" class="tab-pane fade in active">
									<div class="row">
										<div class="col-lg-12">
											<div class="portlet box">
												<div class="portlet-body">
													<form id="newOutStorage" action="${contextPath}/manage/saveOutStorage" class="form-horizontal" method="POST">
														<div class="panel-body pan">
														  <div class="note note-info">
															<h4 class="box-heading">注意事项</h4>
															<p>1、单独填写出库信息仅为特殊情况下的库存调度用途，若属于销售情况请通过<strong class="text-primary">出库审核</strong>进行操作</p>
															<p>2、物料出库属于特殊操作，<strong class="text-primary">一旦确认后将无法撤销!</strong></p>
															</p>
														</div>
															<div class="form-body pal">
																<div class="row">
																	<div class="col-md-5">
																		<div class="form-group ">
																			<label for="单号" class="col-md-2 control-label">单号
																				<span class='require'>*</span>
																			</label>
																			<div class="col-md-9">
																				<input name="billCode" type="text" placeholder="" class="form-control" value="${obj.billCode}" />
																			</div>
																		</div>
																	</div>
																	<div class="col-md-5">
																		<div class="form-group">
																			<label for="出库类型" class="col-md-3 control-label">出库类型<span
																				class='require'>*</span>
																			</label>
																			<div class="col-md-9">
																				<select id="goodId" name="storageType" class="form-control">
																					<option selected="selected" value="物料调配">物料调配</option>
																					<!-- <option value="销售出库">销售出库</option>
																					<option value="采购退货">采购退货</option>
																					<option value="其他出库">其它出库</option> -->
																				</select>
																			</div>
																		</div>
																	</div>
																</div>
																<div class="row">
																	<div class="col-md-5">
																		<div class="form-group">
																			<label class="col-md-2 control-label">出库日期
																			  <span class='require'>*</span>
																			</label>
																			<div class="col-md-9">
																			  <div class="input-icon right">
																			    <i class="fa fa fa-calendar"></i>
																				<input type="text" readonly="readonly" id="createTime" name="createTime" autocomplete="off" placeholder="请选择时间" class="form-control" />
																			  </div>
																			</div>
																		</div>
																	</div>
																	<div class="col-md-5">
																		<div class="form-group">
																			<label for="isList" class="col-md-3 control-label">制表人
																				<span class='require'>*</span>
																			</label>
																			<div class="col-md-9">
																				<input type="text" id="billMaker" name="billMaker" class="form-control" value="${sessionScope.USERVO.userName}"/>
																			</div>
																		</div>
																	</div>
																	
																</div>
																<div class="row">
																    <div class="col-md-5">
																        <div class="form-group">
																            <label for="仓库" class="col-md-2 control-label">仓库<span class='require'>*</span>
																            </label>
																            <div class="col-md-9">
																                <select id="storeId" name="storeId" class="form-control">
																                    <c:forEach var="storeVO" items="${obj.storeList}" varStatus="status">
																                        <option value="${storeVO.storeId}">${storeVO.storeName}</option>
																                    </c:forEach>
																
																                </select>
																            </div>
																        </div>
																    </div>
																    <div class="col-md-5">
																        <div class="form-group">
																            <label for="目标养殖场" class="col-md-3 control-label">目标养殖场<span class='require'>*</span>
																            </label>
																            <div class="col-md-9">
																                <select id="farmId" name="farmId" class="form-control">
																                    <c:forEach var="farmVO" items="${obj.farmList}" varStatus="status">
																                        <option value="${farmVO.farmId}">${farmVO.farmName}</option>
																                    </c:forEach>
																                </select>
																            </div>
																        </div>
																    </div>
																</div>
																<div class="row" style="margin-top:50px;">
																	<div class="col-lg-11">
																		<table
																			class="table table-hover table-striped table-bordered table-advanced tablesorter">
																			<thead>
																				<tr>
																					<th width="30%">物料</th>
																					<th width="10%">出库总数量</th>
																					<th width="10%">出库价格</th>
																					<th width="10%">物料批次号</th>
																					<th width="10%">批次号库存</th>
																					<th width="10%">出库数量</th>
																					<th>备注</th>
																					<th width="10%">操作</th>
																				</tr>
																			</thead>
																			<tbody id="storage_tbody">
																				<tr id="tr_1">
																					<td class="select-goods-area">
																							<div style="position:relative">
																								<input type="text" name="goodId"/>
																								<div class="_goods-list">
																									<div class="_item">
																										<span>暂无数据.</span>
																									</div>
																								</div>
																								<div class="goods-clone"></div>
																								<span class="glyphicon glyphicon-list show-goods"></span>
																							</div>
																						</td>
																					<td><input name="storageNum"
																						onkeyup="input_checked(this)" type="text"
																						placeholder="" class="form-control" value="" /></td>
																					<td><input name="price" type="text"
																						placeholder="" class="form-control" /></td>
																					<td></td>
																					<td></td>
																					<td><input name="" type="text" class="form-control" value="0"/></td>
																					<td><input name="remark" type="text" class="form-control" /></td>
																					<td>
																						<button type="button" class="btn" id="del_tr_1"
																							name="del_tr_1" value="删除" onclick="del_tr(1)"
																							class="col-md-3 control-label">
																							<i class="fa fa-times"></i>&nbsp;&nbsp;删除
																						</button>
																					</td>
																				</tr>
																			</tbody>
																		</table>
																		<div class="col-md-6" style="margin-left:-15px;">
																			<button type="button" class="btn" id="addList"
																				name="addList" class="col-md-3 control-label">
																				<i class="fa fa-plus"></i>&nbsp;&nbsp;添加
																			</button>
																		</div>
																	</div>
																</div>
															</div>
														</div>
														<hr />
														<div class="form-actions text-right pal pull-left">
															<button id="submitBtn" type="button"
																onclick="ev_submit()" class="btn btn-primary start">保存</button>
															&nbsp;
															<button type="button" class="btn btn-green"
																onclick="ev_back()">取消</button>
														</div>
													</form>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!--END CONTENT-->
					<div class="modal fade bs-example-modal-lg" id="chooseGoods" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				  		<div class="modal-dialog modal-lg">
				    		<div class="modal-content">
					      		<div class="modal-header">
					        		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					        		<h4 class="modal-title" id="myModalLabel">选择物料</h4>
					      		</div>
						     	<div class="modal-body" style="overflow: auto;height:700px;">
						     		<div class="search-group">
						     			<input type="text"/>
						     			<button class="search-goods-btn">搜索</button>
						     		</div>
						     		<table class="table">
						     			<thead>
						     				<tr>
						     					<th width="2%"></th>
						     					<th width="10%">略图</th>
						     					<th width="10%">物料编码</th>
						     					<th width="30%">物料名称</th>
												<th width="10%">出库数量</th>
						     				</tr>
						     			</thead>
						     			<tbody id="goodslist-tbody">
						     				
						     			</tbody>
						     		</table>
						      	</div>
						      	<div class="modal-footer">
						      		<div class="pagination-panel" style="float: left;">
										<a id="pageUp" class="btn btn-sm btn-success btn-prev gw-prev">
											<i class="fa fa-angle-left"></i>
										</a>
										<input id="currentPage" type="text" maxlenght="5" value="1"
											class="pagination-panel-input form-control input-mini input-inline input-sm text-center gw-page"/>
										<a id="pageDown" class="btn btn-sm btn-success btn-prev gw-next">
											<i class="fa fa-angle-right"></i>
										</a> 
										<span id="pagination-info">共有  页 | 合计  条记录</span>
									</div>
						       		<button type="button" class="btn btn-primary" id="comfirm-choose-goods">确定</button>
						        	<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						      	</div>
				    		</div>
				  		</div>
					</div>
					<div class="modal fade bs-example-modal-xs" id="changeStore" tabindex="-1" role="dialog">
				  		<div class="modal-dialog modal-xs">
				    		<div class="modal-content">
					      		<div class="modal-header">
					        		<button type="button" class="close" data-dismiss="modal">
						        		<span aria-hidden="true">&times;</span>
						        		<span class="sr-only">Close</span>
					        		</button>
					        		<h4 class="modal-title" id="myModalLabel">确认提示</h4>
					      		</div>
						     	<div class="modal-body">
						     		<span style="font-size: 14px;">点击确定修改出库仓库将会清空此前选择的物料信息</span>
						      	</div>
						      	<div class="modal-footer">
						       		<button type="button" class="btn btn-primary" id="comfirm-change-store">确定</button>
						        	<button type="button" class="btn btn-default" id="cancel-change-store" data-dismiss="modal">取消</button>
						      	</div>
				    		</div>
				  		</div>
					</div>
				</div>
				<!--BEGIN FOOTER-->
				<%@ include file="../include/footer.jsp"%>
				<!--END FOOTER-->
				<!--END PAGE WRAPPER-->

				<!--LOADING SCRIPTS FOR PAGE-->
				<script
					src="${contextPath}/manage/vendors/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
				<script
					src="${contextPath}/manage/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
				<script src="${contextPath}/manage/vendors/moment/moment.js"></script>
				<script
					src="${contextPath}/manage/vendors/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
				<script
					src="${contextPath}/manage/vendors/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
				<script
					src="${contextPath}/manage/vendors/bootstrap-clockface/js/clockface.js"></script>
				<script
					src="${contextPath}/manage/vendors/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
				<script
					src="${contextPath}/manage/vendors/bootstrap-switch/js/bootstrap-switch.min.js"></script>
				<script
					src="${contextPath}/manage/vendors/jquery-maskedinput/jquery-maskedinput.js"></script>
				<script src="${contextPath}/manage/vendors/charCount.js"></script>
				<script src="${contextPath}/manage/js/form-components.js"></script>
				<!--日历控件-->
				<script type="text/javascript"
					src="${contextPath}/manage/js/calendarJs/jedate.js"></script>
				<script src="${contextPath}/manage/js/chooseGoods.js"></script>

				<script type="text/javascript">
    //菜单初始化
    activeMenu("inventoryManageMenu","inventoryUL","outStorage");
    var initTr = null;
    var initStoreId = '';
    var bol1 = true;
    var notReturn = false;
    $(document).ready(function(){
    	initTr = $('#storage_tbody').html();
	}); 
    
    /* window.onload = function(){
    	var a = document.getElementById("mPrice").value;

    	document.getElementById("orderPrice").value = a * 0.9;

    	}; */
    
    var result = "${obj.result}";
    var message = "${obj.msg}";
    if(result=='OK'){
    	toastr['success'](message, "");
        setTimeout(function(){
        	window.location.href = "${contextPath}/manage/outStorage";
        },600);
    }
    else if(result=='FAIL'){
    	toastr['error'](message, "");
    }
        
   function ev_back(){
   	window.history.back();
   }
   
   /* function submit(){
	   document.getElementById("goodsForm").submit();
   } */
   
   //只能输入数字和小数点
   function input_checked(obj){
	   obj.value = obj.value.replace(/[^\d.]/g,"");
   }
   
   function getGoodsSpecInfo(thisTr, goodsId, storeId, orderNum){
	   if(orderNum === undefined){
		   orderNum = 1;
	   }
	   var thisTr1 = thisTr.parentNode.parentNode;
	   var trIdNum = thisTr1.id.split('_');
	   var  thisTds = "<td class='select-goods-area'>"
						+ thisTr.outerHTML
					+ "</td>"
					+ '<td><input id="storageNum" name="storageNum" onkeyup="input_checked(this)" type="text" class="form-control '+thisTr1.id+'sum" onblur="storageNumCheck('+thisTr1.id+')" value="'+orderNum+'"/></td>'
					+ '<td><input id="price" name="price" type="text" class="form-control" /></td>'
					+ '<td></td>'
					+ '<td></td>'
					+ "<td><input name='outStorageNum' class='form-control "+thisTr1.id+"num' value='0' onblur='storageNumCheck("+thisTr1.id+")'/></td>"
					+ "<td><input name='remark' type='text' class='form-control' /></td>"
					+ "<td>"
						+ "<button type='button' class='btn' onclick='del_tr("+ trIdNum[1] +")' class='col-md-3 control-label'><i class='fa fa-times'></i>&nbsp;&nbsp;删除</button>"
					+ "</td>";
	   $.post('${contextPath}/manage/goodsSBCX',{"storeId": storeId, "goodId": goodsId},function(data){
			//初始化点击行
		   if(data.batchNumberlist.length <= 0){
			   //如果选择了没有批次号&库存的物料则提示，只有一个物料的情况下初始化表格
				if($('#storage_tbody .btn').length <= 1) {
					$('#storage_tbody').html(initTr);
					return toastr['warning']('该物料无批次号和库存，请重新选择！', "");
				}
				else {
					$("#" + thisTr1.id).remove();
					$("." + thisTr1.id).remove();
					return toastr['warning']('该物料无批次号和库存，请点击添加后重新选择！', "");
				}
			}
			$("." + thisTr1.id).remove();
			$(thisTr1).html(thisTds);
			$('.goods-clone').unbind('click');
			   $('.goods-clone').bind('click', function() {
				   var txtVal = $(this).find('.goods-info').text();
				   $(this).hide();
				   $(this).parent().find('input[name="goodId"]')[0].value = txtVal;
				   $(this).parent().find('input[name="goodId"]')[0].type = 'text';
				   $(this).parent().find('input[name="goodId"]').focus();
				   $(this).parent().find('.show-goods').show();
			   });
			var tds = $(thisTr1).children();
			for(var i=0; i<data.batchNumberlist.length-1; i++){
				var spec12 = data.batchNumberlist[i+1].batchNumber == ''?'无':data.batchNumberlist[i+1].batchNumber;
				$(thisTr1).after('<tr class="'+thisTr1.id+'">'
									+'<input name="goodId" type="hidden" value="'+goodsId+'"/>'
									+'<td>'
									+spec12
									+'<input name="batchNum" type="hidden" value="'+data.batchNumberlist[i+1].batchNumber+'"/>'
									+'</td>'
									+'<td>'
									+data.batchNumberlist[i+1].count
									+'</td>'
									+'<td>'
										+'<input name="outStorageNum" class="form-control '+thisTr1.id+'num" value="0" onblur="storageNumCheck('+thisTr1.id+')"/>'
									+'</td>'
								+'</tr>');
			}
			$(tds[0]).attr('rowspan', data.batchNumberlist.length);
			$(tds[1]).attr('rowspan', data.batchNumberlist.length, 'class', thisTr1.id+'sum');
			$(tds[2]).attr('rowspan', data.batchNumberlist.length);
			$(tds[3]).html(
				(data.batchNumberlist[0].batchNumber == ''?'无':data.batchNumberlist[0].batchNumber)
				+'<input name="batchNum" type="hidden" value="'+data.batchNumberlist[0].batchNumber+'"/>'	
			);
			$(tds[4]).html(data.batchNumberlist[0].count);
			$(tds[6]).attr('rowspan', data.batchNumberlist.length);
			$(tds[7]).attr('rowspan', data.batchNumberlist.length);
	   });
   }
$(function(){
	   
	   var tds =  '<td><input id="storageNum" name="storageNum" onkeyup="input_checked(this)" type="text" class="form-control" /></td>'
        		+ '<td><input id="price" name="price" type="text" class="form-control" /></td>'
        		+ '<td></td>'
        		+ '<td></td>'
        		+ "<td><input class='form-control' /></td>"
   				+ "<td><input name='remark' type='text' class='form-control' /></td>";
   				
   		var modalTd = "";
   		//物料选定的回调函数
   		var goodsChange = function(obj,num) {
   			var unitName = $(obj).find('.goods-clone div[unitname]').attr('unitname');
   			var numTdInput = $(obj).find('td input[name="storageNum"]');
   			var unitTd = obj.children[2].children[0];
   			unitTd.innerHTML = unitName;
   			numTdInput.val(num?num:1);
   		}
	   _chooseGoods({
		   tbodyId: 'storage_tbody',
		   isNumChange: false,
		   domainUrl: '${QUPLOADIMG}',
		   insertTd: tds,
		   insertModalTd: modalTd,
		   notGetGoodsInfo: true,
		   modalGetUnit: false,
		   goodsChangeHandler: goodsChange,
		   getGoodsSpecInfo: getGoodsSpecInfo,
		   orderNumIn: 1,
	   });
   })
   
    //删除规格
	function del_tr(n, opra){
		var trNumber = $('#storage_tbody .btn').length;
		if(trNumber <= 1 && opra !='canDel') {
			return toastr['error']('至少保留和选择一个物料！', "");
		}
		$("#tr_" + n).remove();
		$(".tr_" + n).remove();
   	}
    
	function ev_submit(){
    	if(ev_check()){
    		$.ajax({
	        	  type: 'POST',
	        	  url: '${contextPath}/manage/saveOutStorage',
	        	  data: $("#newOutStorage").serialize(),
	        	  async: false,  
	              dataType: 'json',
	        	  success: function(result){
	        		  	if(result.result == 'OK'){
	        		  		toastr['success'](result.msg, "");
	                    	setTimeout(function(){
	                    		var url = '${contextPath}/manage/outStorage';
	                        	window.location.href = url;	
	                    	},1000);
	    	        	}else{
	    	        		toastr['error'](result.msg, "");
	    	        	}
	        	  }
  		});
    	}
    }
    
	function ev_check(){
		var bol = true;
    	var createTime = $("#createTime").val();
    	var billCode = $("#billCode").val();
    	
    	var goodId = document.getElementsByName("goodId");//物料ID集合
        var sum = document.getElementsByName("storageNum");//出库总量集合
    	var price = document.getElementsByName("price");//出库价格集合
    	var batchNum = document.getElementsByName("batchNum");//每个批次号集合
    	var outStorage = document.getElementsByName("outStorageNum");//每个批次号出库数量集合
    	
    	var billMaker = $("#billMaker").val();//制表人
    	var storeId=$("#storeId").val();//仓库ID
    	var farmId=$("#farmId").val();//养殖场ID
    	var message="";
    	if(createTime == ""){
    		bol = false;
    		message = "请选择时间！";
    		toastr['error'](message, "");
    		return bol;
    	}
    	if(billMaker == ""){
    		bol = false;
    		message = "请填入制表人！";
    		toastr['error'](message, "");
    		return bol;
    	}
    	if(farmId == null || farmId == ""){
    		bol = false;
    		message = "请选择一个养殖场！";
    		toastr['error'](message, "");
    		return bol;
    	}
	  //处理
	  var goodIdTemp = "";
	  var sumTemp = "";
	  var priceTemp = "";
	  var batchNumTemp = "";
	  var outStorageTemp = "";

	  var newBatchNum = new Array();
	  var newOutStorage = new Array();

	  var finalObj = {};
	  var finalArray = new Array();

	  var index = 0;
	  for(var i=0;i<goodId.length;i++){
		if(goodId[i].value == ""){
  			bol = false;
  			message = "请选择一个物料！";
      		toastr['error'](message, "");
      		return bol;
  		}
		goodIdTemp = goodId[i].value;
		sumTemp = sum[index].value;
		priceTemp = price[index].value;
		batchNumTemp = batchNum[i].value;
		outStorageTemp = outStorage[i].value;

		if(i==0){
			goodIdTemp = goodId[i].value;
			sumTemp = sum[index].value;
			priceTemp = price[index].value;
			batchNumTemp = batchNum[i].value;
			outStorageTemp = outStorage[i].value;

			finalObj.goodId = goodIdTemp;
			finalObj.sum = sumTemp;
			finalObj.price = priceTemp;
			newBatchNum.push(batchNumTemp);
			newOutStorage.push(outStorageTemp);
			
			if(goodId.length == 1){
				finalObj.batchNum = newBatchNum;
				finalObj.outStorage = newOutStorage;
				finalArray[index] = finalObj;
			}
		}else{
			if(goodIdTemp == finalObj.goodId){
				newBatchNum.push(batchNumTemp);
				newOutStorage.push(outStorageTemp);

				if(i==goodId.length-1){
					finalObj.batchNum = newBatchNum;
					finalObj.outStorage = newOutStorage;
					finalArray[index] = finalObj;
				}

			}else if(goodIdTemp != finalObj.goodId && i==goodId.length-1){
				finalObj.batchNum = newBatchNum;
				finalObj.outStorage = newOutStorage;
				finalArray[index] = finalObj;
				
				finalObj = {};
				index++;

				newBatchNum = new Array();
				newOutStorage = new Array();

				finalObj.batchNum = null;
				finalObj.outStorage = null;

				goodIdTemp = goodId[i].value;
				sumTemp = sum[index].value;
				priceTemp = price[index].value;
				batchNumTemp = batchNum[i].value;
				outStorageTemp = outStorage[i].value;

				newBatchNum.push(batchNumTemp);
				newOutStorage.push(outStorageTemp);

				finalObj.goodId = goodIdTemp;
				finalObj.sum = sumTemp;
				finalObj.price = priceTemp;
				
				finalObj.batchNum = newBatchNum;
				finalObj.outStorage = newOutStorage;
				finalArray[index] = finalObj;
			}else{
				finalObj.batchNum = newBatchNum;
				finalObj.outStorage = newOutStorage;
				finalArray[index] = finalObj;
				
				finalObj = {};
				index++;

				newBatchNum = new Array();
				newOutStorage = new Array();

				finalObj.batchNum = null;
				finalObj.outStorage = null;

				goodIdTemp = goodId[i].value;
				sumTemp = sum[index].value;
				priceTemp = price[index].value;
				batchNumTemp = batchNum[i].value;
				outStorageTemp = outStorage[i].value;

				newBatchNum.push(batchNumTemp);
				newOutStorage.push(outStorageTemp);

				finalObj.goodId = goodIdTemp;
				finalObj.sum = sumTemp;
				finalObj.price = priceTemp;


			}
		}
	  }

	  console.log(finalArray);
    	for(var i = 0; i<finalArray.length; i++){
    		
    		if(finalArray[i].sum == ""){
				bol = false;
				message = "请输入数量！";
	    		toastr['error'](message, "");
	    		return bol;
			}
	    	if(finalArray[i].sum == 0){
	    		bol=false;
	    		message="出库数量不能0，请重新输入！";
	    		toastr['error'](message, "");
	    		return bol;
	    	}
	    	for(var j=0,sum1=0;j<finalArray[i].outStorage.length;j++){
	    		sum1 += parseInt(finalArray[i].outStorage[j]);
	    		if(j == finalArray[i].outStorage.length-1 && parseInt(finalArray[i].sum) != sum1){
	    			bol = false;
					message = "出库总数量与出库数量总和不符！";
		    		toastr['error'](message, "");
		    		return bol;
	    		}
	    	}
	    	if(finalArray[i].price == ''){
	    		bol = false;
	    		message = '请输入销售价格！';
	    		toastr['error'](message, "");
	    		return bol;
	    	}
	    	
    		
	    	finalArray[i].storeId = storeId;
    		$.ajax({
	        	  type: 'POST',
	        	  url: '${contextPath}/manage/checkStock',
	        	  data: finalArray[i],
	        	  async: false,  
	              dataType: 'json',
	              traditional: true,
	        	  success: function(result){
	        		  	if(result.result == 'OK'){
	        		  		bol = true;
	        		  		
	    	        	}else{
	    	        		bol=false;
	    	        		message=result.msg;
	    	        		toastr['error'](message, "");
	    	        		j=finalArray[i].outStorage.length;
	    	        	}
	        	  }
    		});
    	}
    	return bol;
    }
	jeDate({
		dateCell:"#createTime",
		format:"YYYY-MM-DD hh:mm:ss",
		isinitVal:false,
		isTime:true, //isClear:false,
		//minDate:"2014-09-19 00:00:00",
		okfun:function(val){
				//alert(val);
		}
	})
	function changeStoreClick() {
		initStoreId = $('#storeId').val();
		$('#storeId').unbind('click');
	}
	$('#storeId').bind('click',changeStoreClick).change(function(){
		$('#changeStore').modal("show");
		//newStoreId = $('#storeId').val();
	});
	$('#comfirm-change-store').live('click', function(){
		$('#storage_tbody').html(initTr);
		$('#changeStore').modal("hide");
		/* setTimeout(function(){
			$('#storeId').val(newStoreId);
		},500); */
		notReturn = true;
	})
	$('#changeStore').on('hidden.bs.modal', function(e){
		if(!notReturn){
			$('#storeId').val(initStoreId);
		}
		$('#storeId').bind('click',changeStoreClick);
		notReturn = false;
	})
   	//检验出库总数
    function storageNumCheck(trId) {
		/* var nums = $('.'+trId.id+'num');
		var sum = $('.'+trId.id+'sum').val();
		for(var i=0, n=0; i<nums.length; i++){
			n += parseFloat(nums[i].value);
		}
		if(n != parseFloat(sum)){
			bol1 = false;
			return toastr['error']('出库数量与总数不符，请重新填写！', "");
		}
		bol1 = true; */
	}

</script>
</body>

</html>