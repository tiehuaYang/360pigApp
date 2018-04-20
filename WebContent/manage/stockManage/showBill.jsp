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
	src="${contextPath}/vendors/ckeditor/ckeditor.js"></script>
<link type="text/css" rel="stylesheet"
	href="${contextPath}/manage/vendors/jquery-tablesorter/themes/blue/style-custom.css">
</head>



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
							href="${contextPath }/manage/showIndex">首页</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li><a href="#">库存管理</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active"><c:if
								test="${obj.billVO.storageKind == 1}">入库单明细</c:if> <c:if
								test="${obj.billVO.storageKind == 0}">出库单明细</c:if></li>
					</ol>
					<!--  <div class="col-lg-6 pull-right" style="margin-top:8px">
                    	<div class="input-group input-group-sm mbs" >
                        	<span class="input-group-btn">
                        		<button type="button" data-toggle="dropdown" class="btn btn-default dropdown-toggle">搜商品&nbsp;
                        			<span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu">
                                	<li><a href="#">&nbsp;搜订货单</a></li>
                                    <li><a href="#">&nbsp;搜退货单</a></li>
                                    <li><a href="#">&nbsp;搜客户</a></li>
                                    <li><a href="#">&nbsp;搜库存</a></li>
                               </ul>
                           </span>
                           <input type="text" placeholder="请输入商品名称/编码/规格/关键字/条形码" class="form-control" /><span class="input-group-btn"><button type="button" data-toggle="dropdown" class="btn btn-success dropdown-toggle"><i class="fa fa-search"></i></button></span>
                       </div>
                   </div>  -->
					<div class="clearfix"></div>
				</div>
				<!--END TITLE & BREADCRUMB PAGE-->

				<!--BEGIN CONTENT-->



				<div class="page-content">
					<div id="table-advanced" class="row">
						<div class="col-lg-12">
							<ul id="tableadvancedTab" class="nav nav-tabs">
								<li class="active"><a href="#table-sticky-tab"
									data-toggle="tab"> <c:if
											test="${obj.billsVO.storageKind == 1}">入库单明细</c:if> <c:if
											test="${obj.billsVO.storageKind == 0}">出库单明细</c:if>
								</a></li>

							</ul>

							<div id="tableadvancedTabContent" class="tab-content">
								<div id="table-sorter-tab" class="tab-pane fade in active">
									<div class="row">

										<div class="col-lg-12">
											<div class="portlet box">
												<div class="portlet-header">
												
													<div class="row">
														<div class="col-lg-11">
															<table class="table">
																<thead>
																	<tr>
																		<th width="25%">单号：${obj.billsVO.billCode}</th>
																		<th width="25%"><c:if
																				test="${obj.billsVO.storageKind == 1}">入库类型:</c:if>
																			<c:if test="${obj.billsVO.storageKind == 0}">出库类型:</c:if>
																			${obj.billsVO.storageType}</th>
																		<th width="25%"><c:if
																				test="${obj.billsVO.storageKind == 1}">入库日期:</c:if>
																			<c:if test="${obj.billsVO.storageKind == 0}">出库日期:</c:if>
																			<fmt:formatDate value="${obj.billsVO.createTime}"
																				type="both" /></th>
																		<th>制单人：${obj.billsVO.billMaker}</th>
																		
																	</tr>
																</thead>
															</table>

															<table
																class="table table-striped table-bordered table-advanced ">
																<thead>
																	<tr>
																		<th width="15%">编码</th>
																		<th width="20%">物料</th>
																		<th width="15%"><c:if
																				test="${obj.billsVO.storageKind == 1}">入库类型</c:if> <c:if
																				test="${obj.billsVO.storageKind == 0}">出库类型</c:if></th>
																		<th width="15%"><c:if
																				test="${obj.billsVO.storageKind == 1}">入库数量</c:if> <c:if
																				test="${obj.billsVO.storageKind == 0}">出库数量</c:if></th>
																		<c:if
																				test="${obj.billsVO.storageKind == 1}"><th>价格</th></c:if>
																					<c:if
																				test="${obj.billsVO.storageKind == 0}"><th>任务批次号</th></c:if>
																		<th>备注</th>
																	</tr>
																</thead>
																<tbody id="storage_tbody">
																	<c:forEach var="storagesVO" items="${obj.storagesList}"
																		varStatus="status">
																		<tr id="tr1">
																			<%-- <c:forEach var="goodVO" items="${obj.goodList}" varStatus="status">
							                                                    		<c:if test="${goodVO.goodId == storageVO.goodId}"> --%>
																			<td>${storagesVO.materialVO.materialCode}</td>
																			<td>${storagesVO.materialVO.materialName}</td>
																			<td>${storagesVO.storageType}</td>
																			<td>${storagesVO.storageNum}</td>
																			<c:if
																				test="${obj.billsVO.storageKind == 1}"><td>${storagesVO.price}</td></c:if>
																				<c:if
																				test="${obj.billsVO.storageKind == 0}"><td>${storagesVO.batchNumber}</td></c:if>
																			<td>${storagesVO.remark}</td>
																			<%-- </c:if>
							                                                    	</c:forEach> --%>
																		</tr>
																	</c:forEach>
																</tbody>
															</table>
														</div>
													</div>
													<hr />
													<div class="form-actions text-right pal pull-left">
														<button type="button" class="btn btn-green"
															onclick="ev_back()">返回</button>
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
				<script src="${contextPath}/manage/js/jquery-1.10.2.min.js"></script>
				<script src="${contextPath}/manage/js/jquery-migrate-1.2.1.min.js"></script>
				<script src="${contextPath}/manage/js/jquery-ui.js"></script>
				<!--loading bootstrap js-->
				<script
					src="${contextPath}/manage/vendors/bootstrap/js/bootstrap.min.js"></script>
				<script
					src="${contextPath}/manage/vendors/bootstrap-hover-dropdown/bootstrap-hover-dropdown.js"></script>
				<script src="${contextPath}/manage/js/html5shiv.js"></script>
				<script src="${contextPath}/manage/js/respond.min.js"></script>
				<script
					src="${contextPath}/manage/vendors/metisMenu/jquery.metisMenu.js"></script>
				<script
					src="${contextPath}/manage/vendors/slimScroll/jquery.slimscroll.js"></script>
				<script
					src="${contextPath}/manage/vendors/jquery-cookie/jquery.cookie.js"></script>
				<script src="${contextPath}/manage/vendors/iCheck/icheck.min.js"></script>
				<script src="${contextPath}/manage/vendors/iCheck/custom.min.js"></script>
				<script
					src="${contextPath}/manage/vendors/jquery-notific8/jquery.notific8.min.js"></script>
				<script
					src="${contextPath}/manage/vendors/jquery-highcharts/highcharts.js"></script>
				<script src="${contextPath}/manage/js/jquery.menu.js"></script>
				<script src="${contextPath}/manage/vendors/jquery-pace/pace.min.js"></script>
				<script src="${contextPath}/manage/vendors/holder/holder.js"></script>
				<script
					src="${contextPath}/manage/vendors/responsive-tabs/responsive-tabs.js"></script>
				<script
					src="${contextPath}/manage/vendors/jquery-news-ticker/jquery.newsTicker.min.js"></script>
				<script src="${contextPath}/manage/vendors/moment/moment.js"></script>
				<script
					src="${contextPath}/manage/vendors/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
				<script
					src="${contextPath}/manage/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
				<!--CORE JAVASCRIPT-->
				<script src="${contextPath}/manage/js/main.js"></script>
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

				<script type="text/javascript">
					//菜单初始化

					if ('${obj.billsVO.storageKind}' == 1) {
						activeMenu("stockManage", "stockUL", "inStorages");
					} else if ('${obj.billsVO.storageKind}' == 0) {
						activeMenu("stockManage", "stockUL", "outStorages");
					}

					$(document).ready(function() {
					});

					/* window.onload = function(){
						var a = document.getElementById("mPrice").value;

						document.getElementById("orderPrice").value = a * 0.9;

						}; */

					var result = "${obj.result}";
					var message = "${obj.msg}";
					if (result == 'OK') {
						toastr['success'](message, "");
						setTimeout(
								function() {
									window.location.href = "${contextPath}/manage/inStorages";
								}, 600);
					} else if (result == 'FAIL') {
						toastr['error'](message, "");
					}

					function ev_back() {
						window.history.back();
					}

					/* function submit(){
					   document.getElementById("goodsForm").submit();
					} */

					function ev_showCategory() {
						var url = "${contextPath}/manage/queryCategoryForTask";
						if (navigator.userAgent.indexOf("Chrome") > 0) {
							var winOption = "height=650px,width=1150px,top=10px,left=200px,resizable=yes,fullscreen=0, location=no";
							var dialog = window.open(url, window, winOption);
						} else {
							var args = "dialogWidth=1150px;dialogHeight=650px";
							var dialog = window
									.showModalDialog(url, null, args);
							$('#categoryId').val(dialog.categoryId);
							$('#categoryName').val(dialog.categoryName);
							$('#breedDays').val(dialog.breedDaysTotal);
							$('#breedDaysTotal').val(dialog.breedDaysTotal);

						}

						search();

					}

					$(function() {
						$("#addList")
								.click(
										function() {
											var ran = Math
													.floor(Math.random() * 1000);
											var tr = "<tr id='tr" + ran + "'>"
													+ "<td>"
													+ "<select id='materialId' name='materialId' class='form-control'>"
													+ "<option value=''></option>"
													+ "<c:forEach var='accessoryList' items='${obj.materialList}' varStatus='status'>"
													+ "<option value='${accessoryList.materialId}'>${accessoryList.materialName}</option>"
													+ "</c:forEach>"
													+ "</select>"
													+ "</td>"
													+ "<td>"
													+ "<input  name='storageNum' type='text' placeholder='' class='form-control' value=''/>"
													+ "</td>"
													+ "<td>"
													+ "<input name='remark' type='text' placeholder='' class='form-control' />"
													+ "</td>"
													+ "<td>"
													+ "<button class='btn' onclick='del_tr("
													+ ran
													+ ")' class='col-md-3 control-label'><i class='fa fa-times'></i>&nbsp;&nbsp;删除</button>"
													+ "</td>" + "</tr>";
											$("#storage_tbody").append(tr);
										});

						//价格联动
						$("#mPrice")
								.change(
										function() {
											var mPrice = parseInt(document
													.getElementById("mPrice").value);
											$('input[name=orderPrice]')
													.each(
															function() {
																var discount = parseInt($(
																		this)
																		.parents(
																				'td')
																		.siblings(
																				'.discounttd')
																		.text());
																$(this)
																		.val(
																				discount
																						* mPrice
																						/ 100);
															});
										});

						//是否允许订货
						$("input[name='isOrdered']").each(function() {

						});
					});
					//删除规格
					function del_tr(n) {
						$("#tr" + n).remove();
					}
					//删除图片
					function ev_deletePic(id, accessoryId) {
						if (window.confirm("确定要删除这张图片吗？")) {
							var url = "${contextPath}/manage/delPicture?pictureId="
									+ id + "&billId=" + goodId;
							common_ajax(url, function(data) {
								toastr['success']("删除成功", "");
								setTimeout(function() {
									location.reload();
								}, 300);
							});
						}
					}

					/* var specNum = 1;
					function addSpec(specNum){
					   var spec = "<div id='spec_" + specNum + "' name='spec_"+ specNum + "' class='row' ><div class='col-md-2'><input name='spec" + n + "' type='text' placeholder='规格"+ specNum + "' class='form-control' /></div><div class='col-md-6'><input name='' type='text' placeholder='' class='form-control' /></div></div>";
					   specNum++;
					   document.getElementById("spec").innerHTML += spec;
					} */

					function ev_showUser() {
						var url = "${contextPath}/manage/queryUserForTask";
						if (navigator.userAgent.indexOf("Chrome") > 0) {
							var winOption = "height=580px,width=900px,top=10px,left=100px,resizable=yes,fullscreen=0, location=no";
							var dialog = window.open(url, window, winOption);
						} else {
							var args = "dialogWidth=900px;dialogHeight=580px";
							var returnVal = window.showModalDialog(url, null,
									args);
							document.getElementById("userId").value = returnVal.userId;
							document.getElementById("userName").value = returnVal.userName;
						}

						search();

					}

					$(function() {

						//BEGIN CHECKBOX & RADIO
						$('input[type="radio"]').iCheck({
							radioClass : 'iradio_square-red',
							radioClass : 'iradio_square-red',
							increaseArea : '15%'
						});

						$('input[name="isRequired"]').each(function() {
							$(this).on('ifClicked', function(event) { //ifCreated 事件应该在插件初始化之前绑定 
								$(this).iCheck('check');
							});
						});

						$('input[name="isAlert"]').each(function() {
							$(this).on('ifClicked', function(event) { //ifCreated 事件应该在插件初始化之前绑定 
								$(this).iCheck('check');
								if ($('#isAlertY').is(":checked")) {
									$('#alertRange').show();
								} else {
									$('#alertRange').hide();
								}
							});
						});

					});
					function printOutStorage(id) {
						var url = "${contextPath}/manage/printOutStorage?billCode="
								+ id;
						window.location.href = url;
					}
				</script>
</body>

</html>