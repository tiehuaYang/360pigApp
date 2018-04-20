<%@page import="com.pig.common.CommonUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
<script type="text/javascript"
	src="${contextPath}/manage/js/ckeditor/ckeditor.js"></script>
<!--LOADING STYLESHEET FOR PAGE-->
<link type="text/css" rel="stylesheet"
	href="${contextPath}/manage/vendors/jquery-tablesorter/themes/blue/style-custom.css">
</head>
<!--LOADING STYLESHEET FOR PAGE-->
<link type="text/css" rel="stylesheet"
	href="vendors/jquery-file-upload/css/jquery.fileupload.css">
<link type="text/css" rel="stylesheet"
	href="vendors/jquery-file-upload/css/jquery.fileupload-ui.css">
<link type="text/css" rel="stylesheet"
	href="vendors/jquery-file-upload/css/blueimp-gallery.min.css">
<link type="text/css" rel="stylesheet"
	href="vendors/selectize/selectize.css">
<link type="text/css" rel="stylesheet"
	href="vendors/jquery-file-upload/css/jquery.Jcrop.min.css">
<style>
.table th,.table td {
	text-align: center;
	vertical-align: middle !important ；//垂直居中
}

.table>thead>tr>th,.table>tbody>tr>th,.table>tfoot>tr>th,.table>thead>tr>td,.table>tbody>tr>td,.table>tfoot>tr>td
	{
	vertical-align: middle !important ；//垂直居中
}
.set-spec{
	background-color: #ddd;
	line-height: 50px;
	padding-left: 20px;
}
.spec-select{
	background-color: #f8f8f8;
	display: none;
}
.spec-select .spec-select-item{
	line-height: 40px;
	padding: 15px 20px;
}
.spec-select-item>div>input,
#new-spec>div>input{
	border:none;
	background-color: #f8f8f8 !important;
}
.spec-select-item>div{
	margin-top: 20px;
}
.spec-select-item>div:after{
	content:'';
	display: block;
	clear: both;
}
.spec-select-item>div>input{
	float: left;
	width: 12%;
	height: 36px;
	border-bottom: 1px dashed #d0d0d0;
	margin-right: 3%;
}
.spec-select-item>div .selectize-item{
	float: left;
	width: 85%;
}
.add-spec-select{
	color: #5cb85c;
	padding: 10px 20px;
	cursor: pointer;
	position: relative;
	top: -10px;
}
.spec-listintable{
	margin-top: 40px;
}
.spec-listintable tr input{
	width: 100%;
	padding: 0 10px;
}
.del-btn{
	color: blue;
	cursor: pointer;
}
.selectize-item{
	position: relative;
}
.del-set{
	position: absolute;
	height: 36px;
	line-height: 36px;
	z-index: 1000;
	top: 0;
	right: 0;
	font-size: 30px;
	padding: 0 10px;
	cursor: pointer;
	display: none;
}
.del-set:hover{
	color: #e74c3c;
}
.spec-listintable td input{
	height: 34px;
}
.check-font{
	color: #d9534f;
}
.df-img{
	padding: 0;
}
.df-img img{
	width: 50px;
	cursor: pointer;
}
.df-img img:hover{
	opacity: .6;
	border: 1px solid #33485c;
}
.table tbody tr td{
	vertical-align: middle;
}
#oldImg{
	float: left;
	width: 520px;
	height: 520px;
	padding: 10px;
	margin-left: 43px;
	border: 1px solid gray; 
	overflow: hidden;
}
.inputFile{
	width: 100px;
	height: 35px;
	background-color: #55b555;
	overflow: hidden;
	position: relative;
	color: #fff;
	line-height: 35px;
	text-align: center;
	margin-bottom: 20px;
	cursor: pointer;
}
.inputFile:hover{
	background-color: #8bc34a;
}
.inputFile input{
	position: absolute;
	top: 0;
	opacity: 0;
}
.preview-content{
	float: left;
	height: 520px;
	margin-left: 50px;
    padding: 0 10px;
}
.preview{
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
						<li><a href="#">物料管理</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">物料信息编辑</li>
					</ol>
<%-- 					<jsp:include page="../common/searchBar.jsp" flush="true">
						<jsp:param name="defaultBtn" value="搜物料" />
						<jsp:param name="placeholder" value="请输入物料名称/编码/关键字" />
						<jsp:param name="searchType" value="0" />
					</jsp:include> --%>
					<div class="clearfix"></div>
				</div>
				<!--END TITLE & BREADCRUMB PAGE-->
				<!--BEGIN CONTENT-->
				<div class="page-content">
					<div id="table-advanced" class="row">
						<!-- 
                        <div class="col-lg-12">
                            <div class="note note-info">
                                <h4 class="box-heading">Responsive tab</h4>
                                <p>Please resize browser to see tab version on Tablet & Mobile</p>
                            </div>
                        </div>
                         -->

						<div class="col-lg-12">
							<ul id="tableadvancedTab" class="nav nav-tabs ul-edit ">
								<li class="active"><a href="#table-sticky-tab"
									data-toggle="tab">物料信息</a></li>
							</ul>
							<div id="tableadvancedTabContent" class="tab-content">
								<div id="table-sticky-tab" class="tab-pane fade in active">
									<div class="row">
										<div class="col-lg-12">
											<form id="fileupload" action="${contextPath}/manage/saveGood"
												class="form-horizontal" method="POST" onsubmit="return checkForm()">
												<div class="panel-body pan">
													<input name="goodId" type="hidden" class="form-control" value="${obj.goodVO.goodId}" />
													<div class="form-body pal">
														<h3>基本信息</h3>
														<hr />
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label for="物料名称" class="col-md-3 control-label">物料名称<span class='require'>*</span></label>
																	<div class="col-md-9">
																		<input name="baseGoodsName" type="hidden" placeholder=""
																			class="form-control" value="${obj.goodVO.goodsName}"  />
																		<input name="goodsName" type="text" placeholder=""
																			class="form-control" value="${obj.goodVO.goodsName}"  />
																	</div>
																</div>
															</div>
															<div class="col-md-6">
																<div class="form-group">
																	<label for="type" class="col-md-3 control-label">物料类别<span class='require'>*</span></label>
																	<div class="col-md-9">
																		<select id="goodsType" name="goodsType" class="form-control">
																			<c:forEach var="goodsTypeVO" items="${obj.typeList}"
																				varStatus="status">
																				<option
																					<c:if test="${obj.goodVO.goodsType == goodsTypeVO.typeId}">selected="selected"</c:if>
																					
																					value="${goodsTypeVO.typeId}">${goodsTypeVO.typeName}</option>
																			</c:forEach>
																		</select>
																	</div>
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label for="unit" class="col-md-3 control-label">计量单位<span class='require'>*</span><input id = "finalUnit" name ="finalUnit" type="hidden" value='${obj.finalUnit }'  /></label>
																	<div id="unitRow" class="col-md-9">
																	
																		<c:choose>
																			<c:when test="${obj.unitRelevanceStr.length() >0 }">
																				<div class="row">
																					<div class="col-md-8">
																						<input type = "text"  value="${obj.unitRelevanceStr }"  class="form-control" readonly="readonly"   onclick="editMulUnitModal();"/>
																					</div>
																					<div class="col-md-4" style="position:relative;">
																						<input id="unitCheckBox" name="unitCheckBox" type="checkbox"  <c:if test="${obj.unitRelevanceStr.length() >0 }">checked="checked"</c:if> <c:if test="${obj.unitRelevanceStr.length() >0 }">onclick="cancelMulUnitModal()"</c:if>  <c:if test="${obj.unitRelevanceStr.length() <=0 }">onclick="addMulUnitModal()"</c:if>   style="margin-top:10px;margin-left:20px;" />
																						<span style ="font-size:12px;display:inline;">启用多单位</span>
																						<div style="width: 81px;position:absolute;top:9px;right:35px;bottom:3px;left:35px;cursor:pointer;" <c:if test="${obj.unitRelevanceStr.length() >0 }">onclick="cancelMulUnitModal()"</c:if>  <c:if test="${obj.unitRelevanceStr.length() <=0 }">onclick="addMulUnitModal()"</c:if> ></div>
																					</div>
																				</div>
																			</c:when>
																			
																			<c:otherwise>
																				<div class="row">
																					<div class="col-md-8">
																						<select name="unit" class="form-control">
																							<c:forEach var="unitVO" items="${obj.unitList}" varStatus="status">
																								<option <c:if test="${obj.goodVO.unit == unitVO.unitId}">selected="selected"</c:if>
																									value="${unitVO.unitId}">${unitVO.unitName}</option>
																							</c:forEach>
																						</select>
																					</div>
																					<div class="col-md-4" style="position:relative;">
																						<input id="unitCheckBox" name="unitCheckBox"  type="checkbox"  <c:if test="${obj.unitRelevanceStr.length() >0 }">checked="checked"</c:if><c:if test="${obj.unitRelevanceStr.length() >0 }">onclick="cancelMulUnitModal()"</c:if>   <c:if test="${obj.unitRelevanceStr.length() <=0 }">onclick="addMulUnitModal()"</c:if>   style="margin-top:10px;margin-left:20px;" />
																						<span style = "font-size:12px;display:inline">启用多单位</span>
																						<div style="width: 81px;position:absolute;top:9px;right:35px;bottom:3px;left:35px;cursor:pointer;"  <c:if test="${obj.unitRelevanceStr.length() >0 }">onclick="cancelMulUnitModal()"</c:if>   <c:if test="${obj.unitRelevanceStr.length() <=0 }">onclick="addMulUnitModal()"</c:if>  ></div>
																					</div>
																				</div>
																			</c:otherwise>
																		</c:choose>																	

																	</div>
																</div>
															</div>
															<div class="col-md-6">
																<div class="form-group">
																	<label for="排序值" class="col-md-3 control-label">排序值</label>
																	<div class="col-md-9">
																		<input name="goodsOrder" type="text" value="${obj.goodVO.goodsOrder}"
																			placeholder="排序值越大物料排列越靠前" class="form-control" />
																	</div>
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-md-6" style="display:none;">
																<div class="form-group">
																	<label for="isList" class="col-md-3 control-label">是否上架<span class='require'>*</span></label>
																	<div class="col-md-9">
																		<c:choose>
																			<c:when test="${obj.isNewGood == 0 }">
																				<select id="isList" name="isList" class="form-control">
																					<option  value="Y">是</option>
																					<option  value="N" selected="selected">否</option>
																				</select>
																			</c:when>
																			<c:otherwise>
																				<select id="isList" name="isList" class="form-control">
																					<option <c:if test="${obj.goodVO.isList == 'Y'}">selected="selected"</c:if> value="Y">是</option>
																					<option <c:if test="${obj.goodVO.isList == 'N'}">selected="selected"</c:if> value="N">否</option>
																				</select>
																			</c:otherwise>
																		</c:choose>

																	</div>
																</div>
															</div>

															<div class="col-md-6">
																<div class="form-group">
																	<label for="生产商名称" class="col-md-3 control-label">生产商名称</label>
																	<div class="col-md-9">
																		<input name="manufacturer" type="text" placeholder="" class="form-control" value="${obj.goodVO.manufacturer}" />
																	</div>
																</div>
															</div>
															
															<div class="col-md-6">
																<div class="form-group">
																	<label for="搜索关键字" class="col-md-3 control-label">搜索关键字</label>
																	<div class="col-md-9">
																		<input name="keywords" type="text" value="${obj.goodVO.keywords}" 
																		placeholder="(长度<20,用空格分隔)" class="form-control" />
																	</div>
																</div>
															</div>
														</div>
														<div class="row">

															<div class="col-md-6">
																<div class="form-group">
																	<label for="isExt" class="col-md-3 control-label">是否属于兽药通<span class='require'>*</span></label>
																	<div class="col-md-9">
																		<select id="isExt" name="isExt" class="form-control" onchange="xs_sytzd()">
																			<option <c:if test="${obj.goodVO.isExt == 'N'}">selected="selected"</c:if> value="N">否</option>
																			<option <c:if test="${obj.goodVO.isExt == 'Y'}">selected="selected"</c:if> value="Y">是</option>
																		</select>
																	</div>
																</div>
															</div>
														</div>
<%-- 														<div class="row">
															<%@ include file="../common/tag.jsp"%>
														</div> --%>
														<div id='sytzd' style="margin-left:-16px;width:1172px;height:300px;
															<c:choose>
																<c:when test="${obj.goodVO.isExt == 'Y'}">display:block;</c:when>
																<c:otherwise>display:none;</c:otherwise>
															</c:choose>
														">
														<h3 style="padding: 10px;font-size: 20px;">兽药通所属字段</h3>
														<hr />
														<div class="col-md-12 row">
															<div class="col-md-6">
																<div class="form-group">
																	<label for="genericName" class="col-md-3 control-label">通用名</label>
																	<div class="col-md-9">
																		<input name="genericName" type="text" placeholder="" class="form-control" value="${obj.goodVO.goodExtVO.genericName}" />
																	</div>
																</div>
															</div>
															<div class="col-md-6">
																<div class="form-group">
																	<label for="bigClass" class="col-md-3 control-label">大类</label>
																	<div class="col-md-9">
																		<input name="bigClass" type="text" placeholder="" class="form-control" value="${obj.goodVO.goodExtVO.bigClass}" />
																	</div>
																</div>
															</div>
														</div>
														<div class="col-md-12 row">
															<div class="col-md-6">
																<div class="form-group">
																	<label for="dosageForm" class="col-md-3 control-label">剂型</label>
																	<div class="col-md-9">
																		<input name="dosageForm" type="text" placeholder="" class="form-control" value="${obj.goodVO.goodExtVO.dosageForm}" />
																	</div>
																</div>
															</div>
															<div class="col-md-6">
																<div class="form-group">
																	<label for="approvalNumber" class="col-md-3 control-label">批准文号</label>
																	<div class="col-md-9">
																		<input name="approvalNumber" type="text" placeholder="" class="form-control" value="${obj.goodVO.goodExtVO.approvalNumber}" />
																	</div>
																</div>
															</div>
														</div>
														<div class="col-md-12 row">
															<div class="col-md-6">
																<div class="form-group">
																	<label for="qualityStandard" class="col-md-3 control-label">质量标准</label>
																	<div class="col-md-9">
																		<input name="qualityStandard" type="text" placeholder="" class="form-control" value="${obj.goodVO.goodExtVO.qualityStandard}" />
																	</div>
																</div>
															</div>
															<div class="col-md-6">
																<div class="form-group">
																	<label for="GMPCertificateNumber" class="col-md-3 control-label">GMP证书号</label>
																	<div class="col-md-9">
																		<input name="GMPCertificateNumber" type="text" placeholder="" class="form-control" value="${obj.goodVO.goodExtVO.GMPCertificateNumber}" />
																	</div>
																</div>
															</div>
														</div>
														<div class="col-md-12 row">
															<div class="col-md-6">
																<div class="form-group">
																	<label for="manufacturerExt" class="col-md-3 control-label">生产厂家</label>
																	<div class="col-md-9">
																		<input name="manufacturerExt" type="text" placeholder="" class="form-control" value="${obj.goodVO.goodExtVO.manufacturerExt}" />
																	</div>
																</div>
															</div>
															<div class="col-md-6">
																<div class="form-group">
																	<label for="producingArea" class="col-md-3 control-label">产地</label>
																	<div class="col-md-9">
																		<input name="producingArea" type="text" placeholder="" class="form-control" value="${obj.goodVO.goodExtVO.producingArea}" />
																	</div>
																</div>
															</div>
														</div>
														</div>
														<!-- 
                                                            <c:if test="${obj.goodVO.goodsName == '' || obj.goodVO.goodsName == null || obj.goodVO.goodsName.isEmpty()}">
                                                            <div class="row">
                                                                    <div class="col-md-8">
                                                                        <label for="物料规格" class="col-md-3 control-label"><input name="isAddSpec" id="isAddSpec" type="checkbox" />设置物料多规格
                                                                        </label>
                                                                    </div>
                                                                    <br/><hr/>
                                                            </div>
                                                            </c:if>
                                                             -->
														<div id="spec" name="spec"></div>
														<div id="addBtn" name="addBtn" class="row" style="display: none">
															<div class="col-md-6">
																<button type="button" class="btn" id="add_spec" name="add_spec" value="添加规格" class="col-md-3 control-label">添加规格</button>
															</div>
														</div>

														<c:if test="${obj.goodVO.goodsName==null}">
															<div class="set-spec">
																<input type="checkbox" id="checkbox"><label for="checkbox" style="cursor: pointer">设置物料多规格</label>
															</div>
														</c:if>

														<div class="spec-select">
															<div class="spec-select-item"></div>
															<span class="add-spec-select"><i class="glyphicon glyphicon-plus"></i> 添加规格</span>
														</div>
														<div class="spec-listintable">
															<table class="table table-striped table-bordered">
																<thead class="spec-thead" style="background-color: #f8f8f8">
																	<tr>
																		<td>序号</td>
																		<td>略图</td>
																		<c:choose>
																			<c:when test="${obj.goodVO.goodSpecValueVO.size() > 0}">
																					<c:forEach var="goodSpecValueVO" items="${obj.goodVO.goodSpecValueVO}"  varStatus="status">
																						<td class="thead-spec1">${goodSpecValueVO.specVO.specName }</td>
																					</c:forEach>
																			</c:when>
																			<c:otherwise>
																				<td class="thead-spec1">规格</td>
																			</c:otherwise>
																		</c:choose>
																		<td>物料编码</td>
																		<td>条形码</td>
																		<td>操作</td>
																	</tr>
																</thead>
																<tbody class="spec-tbody">
																	<tr>
																		<td><input type="hidden" name="uuid" value=""><input type="hidden" name="specNum" value="1"><span>1</span></td>
																		<td class="df-img"><img src="images/spec.png"/><div class="hidden-area"><input type="hidden" name="imgBig" value=""><input type="hidden" name="imgSmall" value=""></div></td>
																		<c:choose>
																			<c:when test="${obj.goodVO.goodSpecValueVO.size() > 0}">
																					<c:forEach var="goodSpecValueVO" items="${obj.goodVO.goodSpecValueVO}"  varStatus="status">
																						<td class="tbody-spec1">${goodSpecValueVO.specValueVO.specValue }</td>
																					</c:forEach>
																			</c:when>
																			<c:otherwise>
																				<td class="tbody-spec1">无</td>
																			</c:otherwise>
																		</c:choose>
																		<td>
																			<input type="text"  name="goodsCode" style="text-align:center;" />
																			<input type="hidden"  name="baseGoodsCode"  value="${obj.goodVO.goodsCode}"  />
																		</td>
																		<td><input type="text" name="goodsBarCode" style="text-align:center;"></td>
																		<td class="del-btn">删除</td>
																	</tr>
																</tbody>
															</table>
														</div>
														<h3>物料信息</h3>
														<hr />
														<div class="row">
															<div class="col-md-11">
<!-- 																<textarea rows="15" cols="138" id="goodsInfo" -->
<%-- 																	name="goodsInfo">${obj.goodVO.goodsInfo}</textarea> --%>
																<textarea class="ckeditor" cols="100" id="goodsInfo" name="goodsInfo" rows="15">${obj.goodVO.goodsInfo}</textarea>
																<script type="text/javascript">
																CKEDITOR.replace( 'goodsInfo',
																        {
																             toolbar :
																             [
																                ['Source','Bold','Italic','Underline'],
																                ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
																                ['Link','Unlink'],
																                ['Image'],
																                ['FontSize'],
																                ['TextColor']
																             ],
																             allowedContent: true
																        }
																    );

																</script>
															</div>
														</div>
														<br/><br/>

														<div style="overflow: hidden;" class="portlet-body">
															<div class="portlet-scroll">
																<table role="presentation" class="table table-striped">
																	<tbody class="files">
																		<c:forEach var="pictureVO" items="${obj.pictureList}"
																			varStatus="status">
																			<tr class="template-download">
																				<td><span> <a
																						href="${QUPLOADIMG}${pictureVO.uploadUrl}"
																						title="${pictureVO.picName}"
																						download="${pictureVO.picName}" data-gallery><img
																							style="width: 120px; height: 120px"
																							src="${QUPLOADIMG}${pictureVO.uploadUrl}"></a>
																				</span></td>
																				<td>
																					<p class="name">
																						<span>${pictureVO.picName}</span>
																					</p>
																				</td>
																				<td><span class="size">${pictureVO.picSize}</span>
																				</td>
																				<td>
																					<button class="btn btn-danger"
																						onclick="ev_deletePic('${pictureVO.id}','${obj.goodsVO.goodId}');return false;">
																						<i class="glyphicon glyphicon-trash"></i> <span>删除</span>
																					</button>
																				</td>
																			</tr>
																		</c:forEach>
																	</tbody>
																</table>
																<%@include file="../common/upload.jsp"%>
																<div class="uploadAlbum"></div>
															</div>
														</div>

														<h3 style="display:none;">价格设置</h3>
														<hr />
														<div class="row" style="display:none;">
															<div class="col-lg-11">
																<table class="table table-hover table-striped table-bordered table-advanced tablesorter">
																	<thead>
																		<tr>
																			<th colspan="5">
																				<div class="form-group">
																					<label for="订货价" class="col-md-1 control-label">订货价</label>
																					<div class="col-md-2">
																						<input id="mPrice" name="mPrice" type="text" placeholder="0.00" class="form-control" value="${obj.goodVO.mPriceStr}" />
																					</div>
																					<label for="成本价" class="col-md-1 control-label">参考成本价
																					</label>
																					<div class="col-md-2">
																						<input id="cPrice" name="cPrice" type="text" placeholder="0.00" class="form-control" value="${obj.goodVO.cPriceStr}" />
																					</div>
																					<label class="col-md-1 control-label">
																					</label>
																					<shiro:hasPermission name="good:checkCost">
																						<button type="button" class="btn btn-primary col-md-2" data-toggle="modal" data-target="#batchNumForm">查看批次号及其价格</button>
																					</shiro:hasPermission>
																					<!-- 
					                                                                        <div class="col-md-2">
					                                                                        	<input type="checkbox" value="${obj.goodVO.isSpecPrice}" onclick="this.value=this.checked?1:0" name="isSpecPrice" class="checkall" />按客户单独定价
					                                                                        </div>
					                                                                         -->
																				</div>
																			</th>
																		</tr>
																		<tr>
																			<th>客户级别</th>
																			<th width="15%">默认折扣</th>
																			<th width="10%">允许订货</th>
																			<th width="15%">订货价</th>
																			<th width="15%">起订量</th>
																		</tr>
																	</thead>
																	<tbody>
																		<c:forEach var="levelVO" items="${obj.levelList}"
																			varStatus="status">
																			<input name="customLevel_Id" type="hidden"
																				class="form-control" value="${levelVO.levelId}" />
																			<tr>
																				<td>${levelVO.levelName}</td>
																				<td class="discounttd">${levelVO.discount}%</td>
																				<c:choose>
																					<c:when test="${!obj.goods_LevelList.isEmpty()}">
																						<c:forEach var="goods_LevelVO"
																							items="${obj.goods_LevelList}" varStatus="status">
																							<c:if
																								test="${levelVO.levelId == goods_LevelVO.customLevelId}">
																								<td>
																									<!-- <input id="isOrdered" name="isOrdered" type="checkbox" value="是" checked onchange="this.value=this.checked?是:否" /> -->
																									<select name="isOrdered">
																										<%-- <option value="${goods_LevelVO.isOrdered}">${goods_LevelVO.isOrdered}</option> --%>
																										<%-- <c:if test="${goods_LevelVO.isOrdered != '是'}"> --%>
																										<option
																											<c:if test="${goods_LevelVO.isOrdered == 'Y'}">selected="selected"</c:if>
																											value="Y">是</option>
																										<%-- </c:if> --%>
																										<%-- <c:if test="${goods_LevelVO.isOrdered != '否'}"> --%>
																										<option
																											<c:if test="${goods_LevelVO.isOrdered == 'N'}">selected="selected"</c:if>
																											value="N">否</option>
																										<%-- </c:if> --%>
																								</select>
																								</td>
																								<td>
																									<div class="form-group">
																										<div class="col-md-12">
																											<input name="orderPrice" type="text"
																												placeholder="0.00" class="form-control"
																												value="${goods_LevelVO.orderPrice}" /> <input
																												name="goods_LevelId" type="hidden"
																												class="form-control"
																												value="${goods_LevelVO.goods_LevelId}" />
																										</div>
																									</div>
																								</td>
																								<td>
																									<div class="form-group">
																										<div class="col-md-12">
																											<input name="minNum" type="text"
																												placeholder="0" class="form-control"
																												value="${goods_LevelVO.minNum}" />
																										</div>
																									</div>
																								</td>
																							</c:if>
																						</c:forEach>
																					</c:when>
																					<c:otherwise>
																						<td><select name="isOrdered">
																								<option value="Y">是</option>
																								<option value="N">否</option>
																						</select></td>
																						<td>
																							<div class="form-group">
																								<div class="col-md-12">
																									<input name="orderPrice" type="text"
																										placeholder="0.00" class="form-control" /> <input
																										name="goods_LevelId" type="hidden"
																										class="form-control" />
																								</div>
																							</div>
																						</td>
																						<td>
																							<div class="form-group">
																								<div class="col-md-12">
																									<input name="minNum" type="text"
																										placeholder="0" class="form-control" />
																								</div>
																							</div>
																						</td>
																					</c:otherwise>
																				</c:choose>
																			</tr>
																		</c:forEach>
																	</tbody>
																</table>
															</div>
														</div>
													</div>
													<c:if test="${obj.goodVO.goodsName!=null}">
													<div style="padding: 20px 20px;">
														<input id="editAll" type="checkbox" name="editAllGoods" value="${obj.goodVO.goodsName}"><label for="editAll" style="margin: 0 10px;">修改所有同名物料设置</label>
													</div>
													</c:if>
												</div>
												<div class="text-right pal pull-left" style="margin-top:-20px;">
													<button id="submitBtn" type="button" class="btn btn-primary start">保存</button>
													&nbsp;
													<button type="button" class="btn btn-green" onclick="ev_back()">取消</button>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!--END CONTENT-->
				<!--MODAL FADE-->
				<div class="modal fade" id="delSpecModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				        <h4 class="modal-title" id="myModalLabel">确认提示</h4>
				      </div>
				      <div class="modal-body">
				        	<span class="check-font"><i class="glyphicon glyphicon-remove"></i>至少保留一条物料数据</span>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
				      </div>
				    </div>
				  </div>
				</div>
				<div class="modal fade" id="delSpecSetModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				        <h4 class="modal-title" id="myModalLabel">确认提示</h4>
				      </div>
				      <div class="modal-body">
				        	<span class="check-font"><i class="glyphicon glyphicon-remove"></i>规格启用时，至少保留一个规格</span>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
				      </div>
				    </div>
				  </div>
				</div>
				<div class="modal fade" id="SpecSetModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				        <h4 class="modal-title" id="myModalLabel">确认提示</h4>
				      </div>
				      <div class="modal-body">
				        	<span class="check-font"><i class="glyphicon glyphicon-remove"></i>规格启用时，规格名称与规格值都不能为空</span>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
				      </div>
				    </div>
				  </div>
				</div>
				<div class="modal fade bs-example-modal-lg" id="uploadImgModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				  <div class="modal-dialog modal-lg">
				    <div class="modal-content">
				    <form id="upload-pic-form">
					      <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					        <h4 class="modal-title" id="myModalLabel">上传图片</h4>
					      </div>
					      <div class="modal-body" style="overflow: hidden;">
					      	<div>
					        	<div id="oldImg"><img id="target"></div>
					        	<div class="preview-content">
						        	<div class="inputFile">
						        		<span>上传图片</span>
							        	<input id="inputFile" name="coverUrl" type="file" accept="image/*">
						        	</div>
						        	<div class="preview" style="width:200px;height:200px;overflow:hidden; border:1px solid gray;">  
									   <img id="preview" width="200px" height="200px" />  
									</div>
					        	</div>
					        	<input type="hidden" name="x" id="x"/>  
							    <input type="hidden" name="y" id="y"/>  
							    <input type="hidden" name="width" id="width"/>  
							    <input type="hidden" name="height" id="height"/> 
							    <input type="hidden" name="uuid" id="_goodsuuid"/> 
					      	</div>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-primary pic-comfirm">确定</button>
					        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					      </div>
				      </form>
				    </div>
				  </div>
				</div>
				<div class="modal fade" id="comfirmImg" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				        <h4 class="modal-title" id="myModalLabel">确认提示</h4>
				      </div>
				      <div class="modal-body" style="text-align:center;">
				        	<span>是否将此图片应用于其他新建物料？</span>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-primary pic-comfirm-all">确定</button>
					    <button type="button" class="btn btn-default pic-cancel-all" data-dismiss="modal">取消</button>
				      </div>
				    </div>
				  </div>
				</div>
			</div>
			
			<div id="batchNumForm" class="modal fade" >
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" data-dismiss="modal" aria-hidden="true"
									class="close">&times;</button>
								<h4 class="modal-title">查看批次号及其价格</h4>
							</div>
							<form id="batchNumberForm" class="form-horizontal" method="POST">
								<div class="modal-body">
									<div class="form">
										<div class="form-group">
												<div class="col-lg-12">
													<table class="table table-hover table-striped table-bordered table-advanced tablesorter">
														<thead>
															<tr>
																<th width="10%">批次号</th>
																<th width="10%">价格</th>
																<th width="10%">操作</th>
															</tr>
														</thead>
														<tbody>
															<c:forEach var="batchNumberVO" items="${obj.goodVO.batchNumberList}" varStatus="status">
																<input name="batchNumberId" type="hidden" class="form-control" value="${batchNumberVO.batchNumberId}" />
																<tr>
																	<td>${batchNumberVO.batchNumber}</td>
																	<td id="batch${batchNumberVO.batchNumberId}">
																		<input type="hidden" id="batchPrice${batchNumberVO.batchNumberId}"
																			style="width: 100%" name="batchNumber"
																			value="${batchNumberVO.batchPrice}">
																		${batchNumberVO.batchPrice}
																		</td>
																	<td>
																		<shiro:hasPermission name="good:editCost">
																			<button id="editBtn${batchNumberVO.batchNumberId}"
																				type="button" class="btn btn-default btn-xs"
																				onclick="edit('${batchNumberVO.batchNumberId}')">
																				<i class="fa fa-edit"></i>&nbsp; 修改
																			</button>
																		</shiro:hasPermission>
																		<button id="saveBtn${batchNumberVO.batchNumberId}"
																			type="button" class="btn btn-danger btn-xs"
																			style="display: none" data-id="${batchNumberVO.batchNumberId}"
																			onclick="input_submit('${batchNumberVO.batchNumberId}')">
																			<i class="fa fa-check"></i>&nbsp; 保存
																		</button>
																		<button id="cancelBtn${batchNumberVO.batchNumberId}"
																			type="button" class="btn btn-default btn-xs"
																			style="display: none" onclick="cancel('${batchNumberVO.batchNumberId}')">
																			<i class="fa fa-times"></i>&nbsp; 取消
																		</button>
																		<input id="Orig${batchNumberVO.batchNumberId}" type="hidden" value="">
																	</td>
																</tr>
															</c:forEach>
														</tbody>
													</table>
												</div>
											</div>
										<br />
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" data-dismiss="modal" class="btn btn-default">关闭</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				
			<!-- 单位相关 -->
			<div class="modal fade"   id="addMulUnitModal"  tabindex="-1" role="dialog" labelledby="" aria-hidden="true">
		    	<div class="modal-dialog modal-md">
		    		<div class="modal-content">
		    			<div class="modal-header">
		    				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		    				<h4 class="modal-title" id="gridSystemModalLabel">多单位设置</h4>
		    			</div>
		    			<div class="modal-body">
		    				<div class="row" id="addRowOne">
		    						<div class="col-md-2"  style = "margin-top:10px;text-align:right;"><span class='require'>*</span>最小单位</div>
		    						<div class="col-md-10">
										<select name="unitFirst" class="form-control">
										    <c:forEach var="unitVO" items="${obj.unitList}"  varStatus="status">
										        <option <c:if test="${obj.goodVO.unit == unitVO.unitId}">selected="selected"</c:if> value="${unitVO.unitId}">${unitVO.unitName}</option>
										    </c:forEach>
										</select>
		    						</div>
		    				</div><br/>
		    				<div class="row"  id="addRowTwo">
		    						<div class="col-md-2" style = "margin-top:10px;text-align:right;"><span class='require'>*</span>副单位1</div>
		    						<div class="col-md-5">
		    							<span style="padding: 0 10px;">1</span>
			    						<select name="unitSecond" class="form-control" style="width: 80%;display: inline;">
			    							<option checked="checked"  value = "">请选择</option>
				    						<c:forEach var="unitVO" items="${obj.unitList}" varStatus="status">
				    							<option value="${unitVO.unitId}">${unitVO.unitName}</option>
				    						</c:forEach>
			    						</select>
		    						</div>
		    						<div class="col-md-5">
		    							<span style="width:5%;padding: 0 10px;">=</span>
		    							<input type="text" name ="count" class="form-control" style="width: 45%;display: inline;" placeholder="换算比例">&nbsp;&nbsp;
		    							<span style="width:50%;" class="changeUnit">件</span>
		    						</div>
		    				</div><br/>
		    				<div class="row" id="addRowThree">
		    						<div class="col-md-2" style = "margin-top:10px;text-align:right;">副单位2</div>
		    						<div class="col-md-5">
		    							<span style="padding: 0 10px;">1</span>
			    						<select name="unitThird" class="form-control" style="width: 80%;display: inline;">
			    							<option checked="checked"  value = "">请选择</option>
				    						<c:forEach var="unitVO" items="${obj.unitList}" varStatus="status">
				    							<option value="${unitVO.unitId}">${unitVO.unitName}</option>
				    						</c:forEach>
			    						</select>
		    						</div>
		    						<div class="col-md-5">
		    						<span style="width:5%;padding: 0 10px;">=</span>
		    						<input type="text" name ="count" class="form-control" style="width: 45%;display: inline;" placeholder="换算比例">&nbsp;&nbsp;
		    						<span style="width:50%;" class="changeUnit">件</span>
		    						</div>
		    				</div><br/>
		    				<div class="row"  id="addRowFour">
		    						<div class="col-md-2" style = "margin-top:10px;text-align:right;"><span class='require'>*</span>可订货单位</div>
		    						<div class="col-md-10">
		    							<div class="addRowFourUnitRelevance"  style="margin-top:5px;font-size:17px;">
										        <span><input data-index="1" type="checkbox"  checked="checked"  value="${obj.goodVO.unitVO.unitName }" /><span>${obj.goodVO.unitVO.unitName }</span>&nbsp;&nbsp;&nbsp;</span>
		    							</div>
		    						</div>
		    				</div>
		    			</div>
		    			<div class="modal-footer">
		    				<button type="button" class="btn btn-danger" onclick="addMulUnit();">&nbsp; &nbsp;确&nbsp;定&nbsp;&nbsp;</button>
							<button type="button" class="btn btn-default" data-dismiss="modal" style="margin-left: 20px">&nbsp;&nbsp;取&nbsp;消&nbsp;&nbsp;</button>
		    			</div>
		    		</div>
		    	</div>
		    </div>
		    
		    <div class="modal fade"   id="editMulUnitModal"  tabindex="-1" role="dialog" labelledby="" aria-hidden="true">
		    	<div class="modal-dialog modal-md">
		    		<div class="modal-content">
		    			<div class="modal-header">
		    				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		    				<h4 class="modal-title" id="gridSystemModalLabel">多单位设置</h4>
		    			</div>
		    			<div class="modal-body">
		    				<div class="row" id="editRowOne">
		    						<div class="col-md-2"  style = "margin-top:10px;text-align:right;"><span class='require'>*</span>最小单位</div>
		    						<div class="col-md-10">
										<select name="unitFirst" class="form-control">
										    <c:forEach var="unitVO" items="${obj.unitList}"  varStatus="status">
										        <option <c:if test="${obj.unitRelevance0.unitId == unitVO.unitId}">selected="selected"</c:if>  value="${unitVO.unitId}" >${unitVO.unitName} </option>
										    </c:forEach>
										</select>
		    						</div>
		    				</div><br/>
		    				<div class="row" id="editRowTwo">
		    						<div class="col-md-2" style = "margin-top:10px;text-align:right;"><span class='require'>*</span>副单位1</div>
		    						<div class="col-md-5"><span style="padding: 0 10px;">1</span>
		    							<select name="unitSecond" class="form-control" style="width: 80%;display: inline;">
		    							<!-- <option checked="checked"  value = "">请选择</option> -->
			    							<c:forEach var="unitVO" items="${obj.unitList}" varStatus="status">
			    								<option <c:if test="${obj.unitRelevance1.unitId == unitVO.unitId}">selected="selected"</c:if> value="${unitVO.unitId}">${unitVO.unitName}</option>
			    							</c:forEach>
		    							</select>
		    						</div>
		    						<div class="col-md-5">
			    						<span style="width:5%;padding: 0 10px;">=</span>
			    						<input type="text" name ="count" class="form-control" style="width: 45%;display: inline;" placeholder="换算比例" value="${obj.unitRelevance1.count }">&nbsp;&nbsp;
			    						<span style="width:50%;" class="changeUnit">${obj.goodVO.unitVO.unitName }</span>
		    						</div>
		    				</div><br/>
		    				<div class="row" id="editRowThree">
		    						<div class="col-md-2" style = "margin-top:10px;text-align:right;">副单位2</div>
		    						<div class="col-md-5">
		    							<span style="padding: 0 10px;">1</span>
			    						<select name="unitThird" class="form-control" style="width: 80%;display: inline;">
			    							<option checked="checked"  value = "">请选择</option>
				    						<c:forEach var="unitVO" items="${obj.unitList}" varStatus="status">
				    							<option <c:if test="${obj.unitRelevance2.unitId == unitVO.unitId}">selected="selected"</c:if> value="${unitVO.unitId}">${unitVO.unitName}</option>
				    						</c:forEach>
			    						</select>
		    						</div>
		    						<div class="col-md-5">
			    						<span style="width:5%;padding: 0 10px;">=</span>
			    						<input type="text" name ="count" class="form-control" style="width: 45%;display: inline;" placeholder="换算比例" value="${obj.unitRelevance2.count }" >&nbsp;&nbsp;
			    						<span style="width:50%;" class="changeUnit">${obj.goodVO.unitVO.unitName }</span>
		    						</div>
		    				</div><br/>
		    				<div class="row" id="editRowFour">
		    						<div class="col-md-2" style = "margin-top:10px;text-align:right;"><span class='require'>*</span>可订货单位</div>
		    						<div class="col-md-10">
		    							<div class="editRowFourUnitRelevance" style="margin-top:5px;font-size:17px;">
		    								<c:forEach var="unitRelevance" items="${obj.unitRelevanceList}" varStatus="status">
										        <span><input <c:if test = "${unitRelevance.state == 1 }">checked="checked"</c:if> type="checkbox"  value="${unitRelevance.unitName }"/><span>${unitRelevance.unitName }</span>&nbsp;&nbsp;&nbsp;</span>
										    </c:forEach>
		    							</div>
		    						</div>
		    				</div>
		    			</div>
		    			<div class="modal-footer">
		    				<button type="button" class="btn btn-danger" onclick="editMulUnit();">&nbsp; &nbsp;确&nbsp;定&nbsp;&nbsp;</button>
							<button type="button" class="btn btn-default" data-dismiss="modal" style="margin-left: 20px">&nbsp;&nbsp;取&nbsp;消&nbsp;&nbsp;</button>
		    			</div>
		    		</div>
		    	</div>
		    </div>
			
			<div class="modal fade"   id="cancelMulUnitModal"  tabindex="-1" role="dialog" labelledby="" aria-hidden="true">
		    	<div class="modal-dialog modal-md">
		    		<div class="modal-content">
		    			<div class="modal-header">
		    				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		    				<h4 class="modal-title" id="gridSystemModalLabel">警告</h4>
		    			</div>
		    			<div class="modal-body">
		    				<p class="text-danger" style="font-size:18px;">确定取消多单位？</p>
		    				<br/>
		    			</div>
		    			<div class="modal-footer">
		    				<button type="button" class="btn btn-danger" onclick="cancelMulUnit();">&nbsp; &nbsp;确&nbsp;定&nbsp;&nbsp;</button>
							<button type="button" class="btn btn-default" data-dismiss="modal" style="margin-left: 20px">&nbsp;&nbsp;取&nbsp;消&nbsp;&nbsp;</button>
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
				src="${contextPath}/manage/vendors/jquery-validate/jquery.validate.min.js"></script>
			<script src="${contextPath}/manage/vendors/iCheck/icheck.min.js"></script>
			<script src="${contextPath}/manage/vendors/iCheck/custom.min.js"></script>

			<script
				src="${contextPath}/manage/vendors/jquery-tablesorter/jquery.tablesorter.js"></script>
			<script
				src="${contextPath}/manage/vendors/jquery-validate/jquery.validate.min.js"></script>

			<script
				src="${contextPath}/manage/vendors/jquery-file-upload/js/vendor/jquery.ui.widget.js"></script>
			<script
				src="${contextPath}/manage/vendors/jquery-file-upload/js/vendor/tmpl.min.js"></script>
			<script
				src="${contextPath}/manage/vendors/jquery-file-upload/js/vendor/load-image.min.js"></script>
			<script
				src="${contextPath}/manage/vendors/jquery-file-upload/js/vendor/canvas-to-blob.min.js"></script>
			<script
				src="${contextPath}/manage/vendors/jquery-file-upload/js/vendor/jquery.blueimp-gallery.min.js"></script>
			<script
				src="${contextPath}/manage/vendors/jquery-file-upload/js/jquery.iframe-transport.js"></script>
			<script
				src="${contextPath}/manage/vendors/jquery-file-upload/js/jquery.fileupload.js"></script>
			<script
				src="${contextPath}/manage/vendors/jquery-file-upload/js/jquery.fileupload-process.js"></script>
			<script
				src="${contextPath}/manage/vendors/jquery-file-upload/js/jquery.fileupload-image.js"></script>
			<script
				src="${contextPath}/manage/vendors/jquery-file-upload/js/jquery.fileupload-audio.js"></script>
			<script
				src="${contextPath}/manage/vendors/jquery-file-upload/js/jquery.fileupload-video.js"></script>
			<script
				src="${contextPath}/manage/vendors/jquery-file-upload/js/jquery.fileupload-validate.js"></script>
			<script
				src="${contextPath}/manage/vendors/jquery-file-upload/js/jquery.fileupload-ui.js"></script>
			<script
				src="${contextPath}/manage/vendors/jquery-file-upload/js/cors/jquery.xdr-transport.js"></script>
			<script
				src="${contextPath}/manage/vendors/selectize/selectize.min.js"></script>
			<script
				src="${contextPath}/manage/vendors/jquery-file-upload/js/jquery.Jcrop.min.js"></script>
			<script type="text/javascript">
    //菜单初始化
    activeMenu("orderManageMenu","supplyOrderUL", "goodMenu");
    
    $(document).ready(function(){
    	//物料标签
/* 		var tag = document.getElementById("tag").value;
		for(var n = 1; n <= 3; n++){
			var btn = document.getElementById("btn"+n).value;
    		var index = tag.match(btn); 
			if(index){
    			document.getElementById("btn" + n).className="btnx btnx-default";
    		}
		} */
		//打开编辑页面时价格联动
			var mPrice = parseInt(document.getElementById("mPrice").value);
		   	$('input[name=orderPrice]').each(function(){
		   		var discount = parseInt($(this).parents('td').siblings('.discounttd').text());
		   		$(this).val(discount*mPrice/100);
		   	});
		   	
		    var isExt1 = "${obj.goodVO.isExt == 'Y'}";
		    if(isExt1=="false"){
		 	   $("#sytzd").hide();
		    }
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
        	window.location.href = "${contextPath}/manage/showGoods";
        },600);
    }
    else if(result=='FAIL'){
    	toastr['error'](message, "");
    }
        
   function ev_back(){
   	window.history.back();
   }
   
   function xs_sytzd(){
	   var isExt = $("#isExt").val();
	   switch(isExt){
		  case "Y":
		   //alert("one");
		   $("#sytzd").show();
		   break;
		  case "N":
		   $("#sytzd").hide();
		   break;
		 }
   }
   

   
   var specNum = 1;
   //物料规格逻辑
   $(function(){
		   $("#isAddSpec").change(function() {
		        //取消选中，删除所有
		        if (document.getElementById("isAddSpec").checked == false){
		        	//alert("unchecked");
		        	$("#isWithSpec").val("否");
		            $("#specDiv").remove();
		            specNum = 1;
		            $("#addBtn").hide();
                }
		        //选中，添加一项
		        else {
		        	//alert("checked");
		        	$("#isWithSpec").val("是");
		        	var  spec = "<div id='spec_1' class='row' >"
		        					+"<div class='col-md-2'>"
		        						+"<input name='specName[]' type='text' placeholder='规格1' class='form-control' />"
		        					+"</div>"
		        					+"<div class='col-md-6'>"
		        					+"<input name='specValue[]' type='text' placeholder='' class='form-control' />"
		        					+"</div>"
		        					+"<button type='button' class='btn' id='del_spec_1' name='add_spec_1' value='删除' onclick='del_spec(1)' class='col-md-3 control-label'>删除</button>"
		        					+"<hr/>"
		        				+"</div>";
		        	var specDiv = "<div id='specDiv' name='specDiv'></div>";
		        	$("#spec").append(specDiv);
		        	$("#specDiv").append(spec);
		            $("#addBtn").show();
		        }
		    });
		   //规格追加
		   $("#add_spec").click(function(){
			   specNum++;
			   var ran = Math.floor(Math.random()*1000);
			   var  spec = "<div id='spec_" + ran + "' class='row' >"
			   				   +"<div class='col-md-2'>"
			   				   	   +"<input name='specName[]' type='text' placeholder='规格"+ specNum + "' class='form-control' />"
			   				   +"</div>"
			   				   +"<div class='col-md-6'>"
			   				       +"<input name='specValue[]' type='text' placeholder='' class='form-control' />"
			   				   +"</div>"
			   				   +"<button type='button' class='btn' id='del_spec_" + specNum + "' name='add_spec_" + specNum + "' value='删除' onclick='del_spec(" + ran + ")' class='col-md-3 control-label'>删除</button>"
			   				   +"<hr/>"
			   			   +"</div>";
			   $("#specDiv").append(spec);
			   if (specNum >= 3){
				   $("#addBtn").hide();
			   } 
		   });
		   
		   //价格联动
		   $("#mPrice").change(function(){
			   var mPrice = parseInt(document.getElementById("mPrice").value);
		   	   $('input[name=orderPrice]').each(function(){
		   		   var discount = parseInt($(this).parents('td').siblings('.discounttd').text());
		   		   $(this).val(discount*mPrice/100);
		   	   });
		   });
		   
		   //是否允许订货
		   $("input[name='isOrdered']").each(function(){
			   
		   });
	}); 
    //删除规格
	function del_spec(n){
		$("#spec_" + n).remove();
		specNum--;
		if(specNum <= 3){
			$("#addBtn").show();
		}
   	}
    //删除图片
	function ev_deletePic(id,goodId){
    	if(window.confirm("确定要删除这张图片吗？")){
      	  var url = "${contextPath}/manage/delPicture?pictureId="+id+"&billId="+goodId;
      	    common_ajax(url,function(data){
      	    	if(data.result=='OK'){
       	    		toastr['success']("删除成功!", "");
         	        setTimeout(function(){
         	        	reload();
         	        },600);
       	    	}
         	   else{
         		  toastr['error'](data.msg, "");
                }     
  		  });
      	}
    }
   
   /* var specNum = 1;
   function addSpec(specNum){
	   var spec = "<div id='spec_" + specNum + "' name='spec_"+ specNum + "' class='row' ><div class='col-md-2'><input name='spec" + n + "' type='text' placeholder='规格"+ specNum + "' class='form-control' /></div><div class='col-md-6'><input name='' type='text' placeholder='' class='form-control' /></div></div>";
	   specNum++;
	   document.getElementById("spec").innerHTML += spec;
   } */
   
   function ev_showUser(){
	   	var url = "${contextPath}/manage/queryUserForTask";
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
			
			reload();
			
	   }
   
   var reload = function(){
   	window.location.reload();
	};
        
        $(function()
        		{
        	
        		    // Validation
        		    $("#fileupload").validate(
        		        {
        		            // Rules for form validation
        		            rules:
        		            {
        		            	goodsName:
        		                {
        		                    required: true
        		                },
        		                goodsType:
        		                {
        		                    required: true,
        		                },
        		                unit:
        		                {
        		                    required: true,
        		                },
        		                isList:
        		                {
        		                    required:  true
        		                }
        		            },

        		            // Messages for form validation
        		            messages:
        		            {
        		            	goodsName:
        		                {
        		                    required: '物料名称不能为空'
        		                },
        		                goodsType:
        		                {
        		                	required: '物料类别不能为空'
        		                },
        		                unit:
        		                {
        		                	required: '计量单位不能为空',
        		                },
        		                isList:
        		                {
        		                    required: '是否上架不能为空'
        		                }
        		            },

        		            // Do not change code below
        		            errorPlacement: function(error, element)
        		            {
        		                error.insertAfter(element.parent());
        		            }
        		        });
        		    
        		  //BEGIN CHECKBOX & RADIO
        	        $('input[type="radio"]').iCheck({
        	            radioClass: 'iradio_square-red',
        	        	  radioClass : 'iradio_square-red', 
        	        	  increaseArea : '15%' 
        	        });
        	        
        	        $('input[name="isRequired"]').each(function(){
      	        		 $(this).on('ifClicked', function(event){ //ifCreated 事件应该在插件初始化之前绑定 
      	        			$(this).iCheck('check');
      	        		}); 
      	        	  });
        	        
        	        
        	        
        	        
        	        $('input[name="isAlert"]').each(function(){
   	        		 $(this).on('ifClicked', function(event){ //ifCreated 事件应该在插件初始化之前绑定 
   	        			$(this).iCheck('check');
   	        		 	if($('#isAlertY').is(":checked")){
   	        		 		$('#alertRange').show();
   	        		 	}
   	        		 	else{
   	        		 		$('#alertRange').hide();
   	        		 	}
   	        		}); 
   	        	  });
        	       
        		});
        
        $(function () {

        	var uploader = $("#fileupload");
        	$('#fileupload').fileupload({
                disableImageResize: false,
                // Uncomment the following to send cross-domain cookies:
                //xhrFields: {withCredentials: true},
                url: '${contextPath}/manage/saveCatePictureNew',
                done: function (e, data) {
            		if(data.result.result=="OK"){
                		$(".uploadAlbum").append("<input type='hidden' name='uploadAlbum' value=' "+ data.result.resultList+" '/>");
        	            toastr['success'](data.result.msg, "");
            		}else{
            			toastr['error'](data.result.msg, "");
            		}
        	    }
            });
        	
        	uploader.fileupload({
        		url: '${contextPath}/manage/saveCatePictureNew',
        	    dataType: 'json',
        	    autoUpload: false,
        	    disableImageResize: /Android(?!.*Chrome)|Opera/
                    .test(window.navigator.userAgent),
        	    acceptFileTypes:  /(\.|\/)(gif|jpe?g|png)$/i,
        	    maxFileSize: 5000000
        	    
        	});
        	uploader.find("input:file").removeAttr('disabled');

        });
        //设置多规格
        $(function () {
        	//规格输入发生改变
        	var item1 = [''], item2 = [], item3 = [];
        	var hasSpec2 = false, hasSpec3 = false;
        	var _num = 1;
        	var _data = new Date();
        	var _initGoodsCode = parseInt(''+_data.getFullYear()+(_data.getMonth()+1)+_data.getDate()+'0'+_data.getHours());
        	//ipnut name:
        	var SPEC1 = 'specOne';
        	var SPEC2 = 'specTwo';
        	var SPEC3 = 'specThree';
        	var GOODSCODE = 'goodsCode';
        	var BARCODE = 'goodsBarCode';
        	var $select1 = null;
        	var $select2 = null;
        	var $select3 = null;
        	var preDelSpecSet = [];
        	var uuid = [];
        	
        	var targetImgSrc2 = '${obj.goodVO.coverUrlOriginal}'; //上传的截图的初始化路径；
        	
        	function getGoodsCode() {
		        $.ajax({
		        	  type: 'POST',
		        	  url: '${contextPath}/manage/getGoodsCode',
		        	  success: function(result){
				    	if(result.result == 'OK') {
				    		_initGoodsCode = result.goodsCode;
				    	}
				      },
		        	  dataType: 'json',
		        	  async: false
		        });
        	}
        	getGoodsCode();
	        function getUUID() {
		        $.ajax({
		        	  type: 'POST',
		        	  url: '${contextPath}/manage/getGoodsUUID',
		        	  success: function(result){
				    	if(result.result == 'OK') {
				    		uuid.push(result.goodsUUID);
				    	}
				      },
		        	  dataType: 'json',
		        	  async: false
		        });
	        }
	        getUUID();
        	function bindSelectize(id) {
        		var _id = '#input-tags'+id;
        		var $select = $(_id).selectize({
            	    delimiter: ',',
            	    plugins: ['remove_button'],
            	    persist: false,
            	    create: function(input) {
            	        return {
            	            value: input,
            	            text: input
            	        }
            	    },
            	    onChange: eventHandler('item'+id)
            	});
        		
        		switch(id){
        			case 1:
        				$select1 = $select;
        				break;
        			case 2:
        				$select2 = $select;
        				break;
        			case 3:
        				$select3 = $select;
        				break;
        		}
        	}
        	
        	function goodsCodeBlur() {
        		var oldVal;
        		$('input[name="goodsCode"]').focus(function() {
        			oldVal = this.value;
        		});
        		$('input[name="goodsCode"]').blur(function() {
        			if(!this.value){
        				this.value = oldVal;
        				toastr['warning']("物料编码不能为空!", "");
        			}
        		});
        	}
        	goodsCodeBlur();
        	
        	var eventHandler = function(name) {
        	    return function() {
        	        if(name == 'item1') {
        	        	$('.del-set')[0].style.display = 'block';
        	        	item1 = arguments[0].split(',');
        	        }
        	        else if(name == 'item2') {
        	        	$('.del-set')[1].style.display = 'block';
        	        	item2 = arguments[0].split(',');
        	        }
        	        else{
        	        	$('.del-set')[2].style.display = 'block';
        	        	item3 = arguments[0].split(',');
        	        }
        	        initGoodsCode = _initGoodsCode;
        	        for(var i=0,html='',num=1;i<item1.length;i++){
        	        	if(item2.length!=0&&item2[0]!='') {
	        	        	for(var j=0;j<item2.length;j++){
	        	        		if(item3.length!=0&&item3[0]!='') {
		        	        		for(var k=0;k<item3.length;k++){
		        	        			if(!uuid[num-1]) {
		        	        				getUUID();
		        	        			}
		                	        	html += '<tr><td><input type="hidden" name="uuid" value="'+uuid[num-1]+'"><input type="hidden" name="specNum" value="'+(num)+'"><span>'+(num++)+'</span></td><td class="df-img"><img src="images/spec.png"/><div class="hidden-area"><input type="hidden" name="imgBig" value=""><input type="hidden" name="imgSmall" value=""></div></td><td class="tbody-spec1"><input type="hidden" name="'+SPEC1+'" value="'+item1[i]+'">'+item1[i]+'</td><td class="tbody-spec2"><input type="hidden" name="'+SPEC2+'" value="'+item2[j]+'">'+item2[j]+'</td><td><input type="hidden" name="'+SPEC3+'" value="'+item3[k]+'">'+item3[k]+'</td><td><input type="text" name="'+GOODSCODE+'" value="'+(initGoodsCode++)+'"></td><td><input type="text" name="'+BARCODE+'"></td><td class="del-btn">删除</td></tr>';
		            	        		$('.spec-tbody').html(html);
		                	        }
	        	        		}
	        	        		else{
	        	        			if(!uuid[num-1]) {
	        	        				getUUID();
	        	        			}
	        	        			html += '<tr><td><input type="hidden" name="uuid" value="'+uuid[num-1]+'"><input type="hidden" name="specNum" value="'+(num)+'"><span>'+(num++)+'</span></td><td class="df-img"><img src="images/spec.png"/><div class="hidden-area"><input type="hidden" name="imgBig" value=""><input type="hidden" name="imgSmall" value=""></div></td><td class="tbody-spec1"><input type="hidden" name="'+SPEC1+'" value="'+item1[i]+'">'+item1[i]+'</td><td class="tbody-spec2"><input type="hidden" name="'+SPEC2+'" value="'+item2[j]+'">'+item2[j]+'</td>'+(hasSpec3?'<td class="tbody-spec3"></td>':'')+'<td><input type="text" name="'+GOODSCODE+'" value="'+(initGoodsCode++)+'"></td><td><input type="text" name="'+BARCODE+'"></td><td class="del-btn">删除</td></tr>';
	            	        		$('.spec-tbody').html(html);
	        	        		}
	            	        }
        	        	}
        	        	else{
        	        		if(item3.length!=0&&item3[0]!='') {
	        	        		for(var k=0;k<item3.length;k++){
	        	        			if(!uuid[num-1]) {
	        	        				getUUID();
	        	        			}
	                	        	html += '<tr><td><input type="hidden" name="uuid" value="'+uuid[num-1]+'"><input type="hidden" name="specNum" value="'+(num)+'"><span>'+(num++)+'</span></td><td class="df-img"><img src="images/spec.png"/><div class="hidden-area"><input type="hidden" name="imgBig" value=""><input type="hidden" name="imgSmall" value=""></div></td><td class="tbody-spec1"><input type="hidden" name="'+SPEC1+'" value="'+item1[i]+'">'+item1[i]+'</td><td class="tbody-spec2"></td><td><input type="hidden" name="'+SPEC3+'" value="'+item3[k]+'">'+item3[k]+'</td><td><input type="text" name="'+GOODSCODE+'" value="'+(initGoodsCode++)+'"></td><td><input type="text" name="'+BARCODE+'"></td><td class="del-btn">删除</td></tr>';
	            	        		$('.spec-tbody').html(html);
	                	        }
        	        		}
        	        		else{
        	        			if(!uuid[num-1]) {
        	        				getUUID();
        	        			}
	        	        		html += '<tr><td><input type="hidden" name="uuid" value="'+uuid[num-1]+'"><input type="hidden" name="specNum" value="'+(num)+'"><span>'+(num++)+'</span></td><td class="df-img"><img src="images/spec.png"/><div class="hidden-area"><input type="hidden" name="imgBig" value=""><input type="hidden" name="imgSmall" value=""></div></td><td class="tbody-spec1"><input type="hidden" name="'+SPEC1+'" value="'+item1[i]+'">'+item1[i]+'</td>'+(hasSpec2?'<td class="tbody-spec2"></td>':'')+(hasSpec3?'<td class="tbody-spec3"></td>':'')+'<td><input type="text" name="'+GOODSCODE+'" value="'+(initGoodsCode++)+'"></td><td><input type="text" name="'+BARCODE+'"></td><td class="del-btn">删除</td></tr>';
	        	        		$('.spec-tbody').html(html);
        	        		}
        	        	}
        	        }
        	        delTableSpec();//为新生成的del-btn绑定删除点击事件以及处理
        	        showImgModal();
        	        goodsCodeBlur();
        	    };  
        	}; 
        	//勾选设置规格改变
        	$('.set-spec').change(function(){
				if($('.set-spec input').is(':checked')){
					$('.spec-select-item').append('<div><input type="text" value="规格1" name="specName" id="spec1"><div class="selectize-item"><input type="text" name="specValue" id="input-tags1"/><span class="del-set">×</span></div></div>')
					$('#spec1').attr('autofocus','autofocus');
					$('.spec-select').css('display','block');
					$('.spec-tbody tr .tbody-spec1').text(' ');
					$('.spec-listintable thead tr .thead-spec1').text('规格1');
					//设置规格名称
		        	$('#spec1').bind('input propertychange', function() {
		        		$('.spec-listintable thead tr .thead-spec1').text($('#spec1').val());
		        	});
					delSpecInput();
					bindSelectize(1);//初始化一个Selectize.js对象
				}
				else{
					_num = 1;
					$select1[0].selectize.clear();
					if($select2 !=null)$select2[0].selectize.clear();
					if($select3 !=null&&$select3[0])$select3[0].selectize.clear();
					hasSpec2 = false;hasSpec3 = false;
					$('.spec-select-item').empty();
					$('.add-spec-select').css('display','block');
					$('.spec-select').css('display','none');
					$('.spec-thead').html('<tr><td>序号</td><td>略图</td><td class="thead-spec1">规格</td><td>物料编码</td><td>条形码</td><td>操作</td></tr>');
					$('.spec-tbody').html('<tr><td><input type="hidden" name="uuid" value=""><span>1</span></td><td class="df-img"><img src="images/spec.png"/><div class="hidden-area"><input type="hidden" name="imgBig" value=""><input type="hidden" name="imgSmall" value=""></div></td><td class="tbody-spec1">无</td><td><input type="text" name="goodsCode" value="'+(_initGoodsCode)+'"></td><td><input name="goodsBarCode" type="text"></td><td class="del-btn">删除</td></tr>');
					preDelSpecSet = [];
					delTableSpec();
					goodsCodeBlur();
					showImgModal();
				}
				$('.spec-tbody input[name="uuid"]').val(uuid[0]);
        	});
        	
        	//添加规格点击事件
        	$('.add-spec-select').click(function() {
        		//添加规格
        		_num++;
        		//上一个删除的规格，存在则优先添加
        		if(preDelSpecSet.length!=0){
        			preDelSpecSet.sort();
	        		switch(preDelSpecSet[0]){
	        		case 'input-tags1':
	        			_num = 1;
	        			break;
	        		case 'input-tags2':
	        			_num = 2;
	        			break;
	        		case 'input-tags3':
	        			_num = 3;
	        			break;
	        		}
	        		preDelSpecSet.shift();
        		}
        		
        		var item = '<div><input type="text" value="'+'规格'+_num+'" name="specName" id="spec'+_num+'"><div class="selectize-item"><input type="text" name="specValue" id="input-tags'+_num+'"/><span class="del-set">×</span></div></div>';
        		$('.spec-select-item').append(item);
        		delSpecInput();
        		if($('.del-set').length >= 3) {
        			$('.add-spec-select').css('display','none');
        			if(item3.length>0) {
        				$('.del-set').attr('style','display:block');
        			}
        		}
        		
				//添加新规格的同时指定输入改变事件以便修改规格名称与表头规格名称实时绑定
				$('#spec1').bind('input propertychange', function() {
		        		$('.spec-listintable thead tr .thead-spec1').text($('#spec1').val());
		        	});
            	$('#spec2').bind('input propertychange', function() { 
            		$('.spec-listintable thead tr .thead-spec2').text($('#spec2').val());
            	});
            	$('#spec3').bind('input propertychange', function() {
            		$('.spec-listintable thead tr .thead-spec3').text($('#spec3').val());
            	});
            	bindSelectize(_num);//实例化一个Selectize.js对象
        		//添加表格内规格表头
        		if(_num == 2) {
        			hasSpec2 = true;
	        		$('.spec-listintable thead tr .thead-spec1').after('<td class="thead-spec2">'+'规格'+_num+'</td>');
	        		$('.spec-listintable tbody tr .tbody-spec1').after('<td class="tbody-spec2"> </td>');
        		}
        		else if(_num == 1){
        			$('.spec-listintable thead tr td:nth-child(2)').after('<td class="thead-spec1">'+'规格'+_num+'</td>');
	        		$('.spec-listintable tbody tr td:nth-child(2)').after('<td class="tbody-spec1"> </td>');
        		}
        		else{
        			hasSpec3 = true;
        			$('.spec-listintable thead tr .thead-spec2').after('<td class="thead-spec3">'+'规格'+_num+'</td>');
	        		$('.spec-listintable tbody tr .tbody-spec2').after('<td class="tbody-spec3"> </td>');
        		}
        	});
        	
        	//规格列表初始化
        	$('.spec-tbody input[name="uuid"]').val(uuid[0]);
        	if('${obj.goodVO.goodsCode}'!='') { 
	        	$('.spec-tbody input[name="goodsCode"]').val('${obj.goodVO.goodsCode}');
	        	$('.spec-tbody input[name="goodsBarCode"]').val('${obj.goodVO.goodsBarCode}');
        	}
        	else{
	        	$('.spec-tbody input[name="goodsCode"]').val(_initGoodsCode);
        	}
        	//初始化编辑页图片
        	if('${obj.goodVO.coverUrl}'!=''){
        		$('.df-img img')[0].src = '${QUPLOADIMG}'+'${obj.goodVO.coverUrl}';
        		$('input[name="imgSmall"]').val('${obj.goodVO.coverUrl}');
        		$('input[name="imgBig"]').val(targetImgSrc2);
        	}
        	
        	//删除列表规格
        	delTableSpec();
        	function delTableSpec() {
	        	$('.del-btn').click(function(e) {
	        		var delArr = $('.del-btn');
	                var delNum = 0;
	        		for(var i=0;i<delArr.length;i++) {
	        			delArr[i].innerHTML == '删除'?delNum++:'';
	        		}
	        		if(delNum <=1&&this.innerHTML=='删除')return $('#delSpecModal').modal();
	        		this.innerHTML = this.innerHTML=='删除'?'恢复':'删除';
	        		this.parentNode.className = this.innerHTML=='删除'?'enabled':'disabled';
	        		for(var i=0;i<$('.disabled input').length;i++) {
	        			$('.disabled input')[i].disabled = 'disabled';
	        		}
	        		for(var i=0;i<$('.enabled input').length;i++) {
	        			$('.enabled input')[i].disabled = false;
	        		}
	        	});
        	}
        	
        	//删除设置规格表单
        	function delSpecInput() {
        		$('.del-set').click(function(e) {
        			var parent = e.target.parentNode.parentNode;
        			var id = e.target.parentNode.firstElementChild.id;
        			var delBtnNum = $('.del-set').length;
        			if(parent === null){return}
        			if( delBtnNum == 1) {
        				return $('#delSpecSetModal').modal();
        			}
        			
        			switch(id){
        			case 'input-tags1':
        				$select1[0].selectize.clear();
        				$('.add-spec-select').css('display','block');
        				$('.thead-spec1').remove();
        				$('.tbody-spec1').remove();
        				break;
        			case 'input-tags2':
        				$select2[0].selectize.clear();
        				hasSpec2 = false;
        				$('.add-spec-select').css('display','block');
        				$('.thead-spec2').remove();
        				$('.tbody-spec2').remove();
        				break;
        			case 'input-tags3':
        				$select3[0].selectize.clear();
        				hasSpec3 = false;
        				$('.add-spec-select').css('display','block');
        				$('.thead-spec3').remove();
        				$('.tbody-spec3').remove();
        				break;
        			}
        			preDelSpecSet.push(id);
        			parent.innerHTML = '';
        		});
        	}
        	//显示裁剪图片模态框
        	var targetImg, jcrop_api;
        	function showImgModal(){
	        	$('.df-img img').click(function() {
	        		$('#_targetImg').removeAttr('id');//保证只有一个隐藏原图、小图链接的表单隐藏域id
	        		targetImg = this;
	        		targetImg.nextSibling.id = '_targetImg';
	        		targetInput = this.parentNode.parentNode.firstElementChild.firstElementChild;
	        		$('#_goodsuuid').val(targetInput.value);
	        		
	        		$('#width').val(0);  //初始化 裁剪区域的宽  
	                $('#height').val(0); //初始化裁剪区域的高  
	                $('#x').val(0);  //初始化裁剪区域左上角顶点相对于图片左上角顶点的x坐标  
	                $('#y').val(0);  //初始化裁剪区域顶点的y坐标
	                
	        		$('#uploadImgModal').modal();
	        		jcrop_api&&jcrop_api.animateTo([0,0,200,200]);
	            	if(targetImgSrc2!=''){
	            		$('#oldImg').html('<img id="target">');
	            		$('#target')[0].src = '${QUPLOADIMG}'+targetImgSrc2;
	            		$('#preview').attr('src', '${QUPLOADIMG}'+targetImgSrc2);
	            		document.getElementById("upload-pic-form").reset();
	            		jcropFunc();
	            	}
	        	});
        	}
        	showImgModal();
        	
        	function jcropFunc() {
        		var boundx, boundy;  
		        //使原图具有裁剪功能  
		        $('#target').Jcrop({  
		            onChange: updatePreview,  
		            onSelect: updatePreview,  
		            aspectRatio: 1,
		            boxWidth: 500,
		        	boxHeight: 500,
		        },function(){  
		              
		            var bounds = this.getBounds();  
		            boundx = bounds[0];  
		            boundy = bounds[1];  
		              
		            jcrop_api = this;  
		        });
		        jcrop_api&& jcrop_api.animateTo([0,0,200,200]);
		        //裁剪过程中，每改变裁剪大小执行该函数 
		        function updatePreview(c){  
		            if (parseInt(c.w) > 0){    
		                $('#preview').css({  
		                    width: Math.round(200 / c.w * boundx) + 'px',//200 为预览div的宽和高
		                    height: Math.round(200 / c.h * boundy) + 'px',  
		                    marginLeft: '-' + Math.round(200 / c.w * c.x) + 'px',  
		                    marginTop: '-' + Math.round(200 / c.h * c.y) + 'px'  
		                });  
		                $('#width').val(c.w);  //c.w 裁剪区域的宽  
		                $('#height').val(c.h); //c.h 裁剪区域的高  
		                $('#x').val(c.x);  //c.x 裁剪区域左上角顶点相对于图片左上角顶点的x坐标  
		                $('#y').val(c.y);  //c.y 裁剪区域顶点的y坐标
		            }  
		        };
        	}
        	
        	$('#inputFile').on('change',function() {
	        	if (this.files&&this.files[0]) {  
        		 	var reader = new FileReader();
        		 	reader.readAsDataURL(this.files[0]);
        		 	reader.onload = function(evt){
        		 		targetImgSrc = evt.target.result;
        		 		$('#oldImg').html('<img id="target" src="' + evt.target.result + '" />');
        		 		$('#preview').attr('src',evt.target.result);
        		 		jcropFunc();
        			}
	        	}
        	});
        	
        	$('.pic-comfirm').click(function() {
        		var formData = new FormData($('#upload-pic-form')[0]);
        		console.log('formData',formData);
        		if(!$('#upload-pic-form input[name="coverUrl"]').val() && targetImgSrc2==''){
        			return toastr['error']("请上传图片!", "")
        		}
        		if(targetImgSrc2!='') {
        			formData.append('oldImgSrc',targetImgSrc2);
        		}
        		$.ajax({
		        	  type: 'POST',
		        	  url: '${contextPath}/manage/saveGoodsPic',
		        	  data: formData,
		        	  async: false,  
		              cache: false,  
		              contentType: false,  
		              processData: false,
		              dataType: 'json',
		        	  success: function(result){
				    	if(result.result == 'OK') {
				    		var imgSmall = result.imgSmall;
				    		var imgBig = result.imgBig;
				    		var hiddenType = '<input type="hidden" name="imgBig" value="'+imgBig+'"><input type="hidden" name="imgSmall" value="'+imgSmall+'">';
				    		targetImgSrc2 = result.imgBig;
				    		$('#uploadImgModal').modal('hide');
				    		targetImg.src = '${QUPLOADIMG}'+imgSmall;
				    		$('#_targetImg').html(hiddenType);
			    			$('#_targetImg').removeAttr('id');
				    		if($('.del-btn').length>1) {
				    			$('#comfirmImg').modal();
				    			$('.pic-comfirm-all').click(function() {
				    				$('.df-img img').attr('src','${QUPLOADIMG}'+imgSmall);
				    				$('.hidden-area').html(hiddenType);
				    				$('#comfirmImg').modal('hide');
				    				$('#_targetImg').removeAttr('id');
				    			});
				    		}
				    	}else{
				    		return toastr['error'](result.msg, "");
				    	}
				      },
				      error: function(data) {
	                      
	                  }
		        });
        	});
        	
        });
        	//作最后验证
        	function checkSpec() {
        		var isFlag = false;
	        	if($('.set-spec input').is(':checked')){
	        		for(var i=0;i<$('input[name="specName"').length;i++) {
	        			console.log($('input[name="specName"')[i].value);
	        			if($('input[name="specName"')[i].value==''){
	        				$('#SpecSetModal').modal();
	        				isFlag = false;
	        				return isFlag;
	        			}else{
	        				isFlag = true;
	        			}
	        			if(!$('input[name="specValue"')[i].value){
	        				$('#SpecSetModal').modal();
	        				isFlag = false;
	        				return isFlag;
	        			}else{
	        				isFlag = true;
	        			}
	        		}
	        	}
	        	else{
	        		isFlag = true;
	        	}
	        	return isFlag;
        	}

        	function checkGoodsName(){
        		var goodsName = $("#fileupload input[name = goodsName]");
        		var isFlag = false;
    	    	$.ajax({
		        	  type: 'POST',
		        	  url: '${contextPath}/manage/checkGoodsName',
		        	  data: {"goodsName":goodsName.val()},
		        	  async: false,  
		              dataType: 'json',
		        	  success: function(result){
		        		  	if(result.result == 'OK'){
		    	        		toastr['error'](result.msg, "");
		    	        		goodsName.focus();
		    	        		isFlag = false;
		    	        	}else{
		    	        		isFlag = true;
		    	        	}
		        	  }
		        });
    	    	return isFlag;
        	}
        	
        	
        	function checkGoodsCodeSave(){
        		var isFlag = false;
    	    	$.ajax({
		        	  type: 'POST',
		        	  url: '${contextPath}/manage/checkGoodsCodeSave',
		        	  data: $('#fileupload').serialize(),
		        	  async: false,  
		              dataType: 'json',
		        	  success: function(result){
		        		  	if(result.result == 'OK'){
		    	        		toastr['error'](result.msg, "");
		    	        		var goodsCode = $("#fileupload input[name=goodsCode]");
		    	        		for(var i=0;i<goodsCode.length;i++){
		    	        			if($(goodsCode[i]).val() == result.code){
		    	        				$(goodsCode[i]).focus();
		    	        				break;
		    	        			}
		    	        		}
		    	        		isFlag = false;
		    	        	}else{
		    	        		isFlag = true;
		    	        	}
		        	  }
		        });
    	    	return isFlag;
        	}
        	
        	function checkGoodsCodeUpd(){
        		var goodsCode = $("#fileupload input[name = goodsCode]");
        		var isFlag = false;
    	    	$.ajax({
		        	  type: 'POST',
		        	  url: '${contextPath}/manage/checkGoodsCodeUpd',
		        	  data: {"goodsCode":goodsCode.val()},
		        	  async: false,  
		              dataType: 'json',
		        	  success: function(result){
		        		  	if(result.result == 'OK'){
		    	        		toastr['error'](result.msg, "");
		    	        		goodsCode.focus();
		    	        		isFlag = false;
		    	        	}else{
		    	        		isFlag = true;
		    	        	}
		        	  }
		        });
    	    	return isFlag;
        	}
        	
        	function checkForm(){
        		var goodId = $("#fileupload input[name = goodId]").val();
        		var goodsName = $("#fileupload input[name = goodsName]").val();
        		var baseGoodsName = $("#fileupload input[name = baseGoodsName]").val();
        		var goodsCode = $("#fileupload input[name = goodsCode]").val();
        		var baseGoodsCode = $("#fileupload input[name = baseGoodsCode]").val();
        		var isFlag = false;
    			$.ajax({
		        	  type: 'POST',
		        	  url: '${contextPath}/manage/checkSaveOrUpdate',
		        	  data: {"goodId":goodId},
		        	  async: false,  
		              dataType: 'json',
		        	  success: function(result){
		        		  if(result.result == 'save'){
		    	        		if(checkSpec()&&checkGoodsName()&&checkGoodsCodeSave()){
		    	        			isFlag = true;
		    	        		}
		    	        	}else{
		    	        		if(checkSpec()){
		    	        			if(goodsName == baseGoodsName){
		    	        				isFlag = true;
		    	        				if(goodsCode == baseGoodsCode){
			    	        				isFlag = true;
			    	        			}else{
			    	        				isFlag = checkGoodsCodeUpd();
			    	        			}
		    	        			}else{
		    	        				isFlag = checkGoodsName();
		    	        			}
		    	        		}
		    	        	}
		        	  }
		        });
    	        return isFlag;
        	}
        	
        	$("#submitBtn").click(function() {
        		if($("#fileupload input[name = goodsName]").val() != null && $("#fileupload input[name = goodsName]").val() != ""){
	        	    if (checkForm()) {
	        	    	for (instance in CKEDITOR.instances) {
	        	    	    CKEDITOR.instances[instance].updateElement();
	        	    	}
	        	        $.ajax({
	        	            type: 'POST',
	        	            url: '${contextPath}/manage/saveGood',
	        	            data: $('#fileupload').serialize(),
	        	            async: false,
	        	            dataType: 'json',
	        	            success: function(result) {
	        	                if (result.result == 'OK') {
	        	                	toastr['success'](result.msg, "");
	        	                    setTimeout(function(){
	        	                    	window.location.href = "${contextPath}/manage/showGoods";
	        	                    },2000);
	        	                } else {
	        	                	toastr['error'](result.msg, "");
	        	                }
	        	            }
	        	        });
	        	    }
        		}
        	    else{
        			toastr['error']("请输入商品名称", "");
        		}
        	});
        	
        	function edit(id){
            	$("#saveBtn"+id).show();
            	$("#cancelBtn"+id).show();
            	$("#editBtn"+id).hide();
            	var batchPrice = document.getElementById("batchPrice"+id).value;
                document.getElementById("batch"+id).innerHTML = "<input type='text' id='batchPrice" + id + "' name='batchPrice' onkeyup='input_checked(this)' style='width:100%; text-align:center' value='"+ batchPrice +"'><input type='hidden' id='orig" + id + "' ' value='"+ batchPrice +"'>";
            }
            
            function input_submit(id){
           	    //alert(id);
           		var batchPrice = document.getElementById("batchPrice"+id).value;
           		if(batchPrice != null && batchPrice != ""){
           			if(!isNaN(batchPrice)){
        	  			$.post('${contextPath}/manage/saveBatchPrice',{"batchNumberId":id, "batchPrice":batchPrice},function(data){
        	      			if(data.result == 'OK'){
        	      		      	toastr['success'](data.msg, "");
        	   					document.getElementById("batch"+id).innerHTML = "<input type='hidden' id='batchPrice" + id + "' name='batchPrice' style='width:100%' value='"+batchPrice+"'>" + batchPrice;
        	      		        $("#saveBtn"+id).hide();
        	      		      	$("#cancelBtn"+id).hide();
        	      		        $("#editBtn"+id).show();
        	      				return true;
        	      			}else if(data.result == 'FAIL'){
        	      	        	toastr['error'](data.msg, "");
        	      			return false;
        	      	        }
        	      		});
           			}else{
           				toastr['error']('只能填写数字', "");
           	   			return false;
           			}
           		}else{
           			toastr['error']('价格不能为空', "");
           			return false;
           		}
            }
            
            function cancel(id){
            	$("#saveBtn"+id).hide();
            	$("#editBtn"+id).show();
            	$("#cancelBtn"+id).hide();
            	var batchPrice = document.getElementById("orig"+id).value;
            	document.getElementById("batch"+id).innerHTML = "<input type='hidden' id='batchPrice" + id + "' name='batchPrice' style='width:100%' value='"+batchPrice+"'>" + batchPrice;
            }
            
            function input_checked(obj){
        	   obj.value = obj.value.replace(/[^\d.]/g,"");
            }
            
</script>

<script type="text/javascript">
	//StringBuffer
	function StringBuffer(){ 
		this.content = new Array; 
	} 
	StringBuffer.prototype.append = function( str ){ 
		this.content.push( str ); 
	} 
	StringBuffer.prototype.toString = function(){ 
		return this.content.join(""); 
	}
	
	function getFormJson(form) {
		var o = {};
		var a = $(form).serializeArray();
		$.each(a,
		function() {
			if (o[this.name] !== undefined) {
				if (!o[this.name].push) {
					o[this.name] = [o[this.name]];
				}
				o[this.name].push(this.value || '');
			} else {
				o[this.name] = this.value || '';
			}
		});
		return o;
	}
	
	//Map
	function Map() {
	    this.arr = new Array();
	    var struct = function(key, value) {
	        this.key = key;
	        this.value = value;
	    };
	    this.put = function(key, value) {
	        for (var i = 0; i < this.arr.length; i++) {
	            if (this.arr[i].key === key) {
	                this.arr[i].value = value;
	                return;
	            }
	        }
	        this.arr[this.arr.length] = new struct(key, value);
	    };
	    this.get = function(key) {
	        for (var i = 0; i < this.arr.length; i++) {
	            if (this.arr[i].key === key) {
	                return this.arr[i].value;
	            }
	        }
	        return null;
	    };
	    this.values = function() {
	        var value = []
	        for (var i = 0; i < this.arr.length; i++) {
	            value.push(this.arr[i].value);
	        }
	        return value.join(",");
	    };
	    this.remove = function(key) {
	        var v;
	        for (var i = 0; i < this.arr.length; i++) {
	            v = this.arr.pop();
	            if (v.key === key) {
	                continue;
	            }
	            this.arr.unshift(v);
	        }
	    };
	    this.size = function() {
	        return this.arr.length;
	    };
	    this.isEmpty = function() {
	        return this.arr.length <= 0;
	    };
	}
</script>

<script>
	function addMulUnitModal(){
		//格式化
		var input = $("#addMulUnitModal input[type=\"text\"]");
		for(var i=0;i<input.length;i++){
			initInput(input[i]);
		}
		var selects = $("#addMulUnitModal select");
		var unitId = "";
		var unitName = "";
		var select = $("#unitRow select").select()[0];
		for(var i=0;i<select.length;i++){
			if($(select[i])[0].selected){
				unitId=$(select[i])[0].value;
				unitName=$(select[i])[0].text;
				break;
			}
		}
		for(var i=0;i<selects.length;i++){
			if(i==0){
				$(selects[i]).val(unitId);		
			}else{
				initSelect(selects[i]);
			}
		}

		$("#addRowOne select").val(unitId);
		
		$("#addRowTwo .changeUnit").html(unitName);
		$("#addRowThree .changeUnit").html(unitName);
		$("#addRowFour").html("<div class=\"col-md-2\" style = \"margin-top:10px;text-align:right;\"><span class='require'>*</span>可订货单位</div><div class=\"col-md-10\">	<div class=\"addRowFourUnitRelevance\"  style=\"margin-top:5px;font-size:17px;\"><span><input data-index=\"1\" type=\"checkbox\"  checked=\"checked\"  value=\""+unitName+"\" /><span>"+unitName+"</span>&nbsp;&nbsp;&nbsp;</span></div></div>");
		$("#addMulUnitModal").modal("show");
	}
	
	function addMulUnit(){
		var obj = {};
		var addRowOne = $("#addRowOne .form-control");
		var addRowTwo = $("#addRowTwo .form-control");
		var addRowThree = $("#addRowThree .form-control");
		var addRowFour = $("#addRowFour .addRowFourUnitRelevance input");
		
		obj.RowSelect1=$(addRowOne).val();
		obj.RowCount1="1";
		
		if($(addRowTwo[0]).val()!=null&&$(addRowTwo[0]).val()!=""){
			obj.RowSelect2=$(addRowTwo[0]).val();
		}
		if($(addRowTwo[0]).val()!=null&&$(addRowTwo[0]).val()!=""&&$(addRowTwo[1]).val()!=null&&$(addRowTwo[1]).val()!=""){
			obj.RowCount2=$(addRowTwo[1]).val();
		}
		
		if($(addRowThree[0]).val()!=null&&$(addRowThree[0]).val()!=""){
			obj.RowSelect3=$(addRowThree[0]).val();
		}
		if($(addRowThree[0]).val()!=null&&$(addRowThree[0]).val()!=""&&$(addRowThree[1]).val()!=null&&$(addRowThree[1]).val()!=""){
			obj.RowCount3=$(addRowThree[1]).val();
		}
		
		obj.RowValue1=$(addRowFour[0]).val();
		
		if($(addRowFour[1]).val()!=null&&$(addRowFour[1]).val()!=""){
			obj.RowValue2=$(addRowFour[1]).val();
		}
		
		if($(addRowFour[2]).val()!=null&&$(addRowFour[2]).val()!=""){
			obj.RowValue3=$(addRowFour[2]).val();
		}
		
		
		obj.RowChecked1=$(addRowFour[0])[0].checked;
		//obj.RowChecked2=$(editRowFour[1])[0].checked;
		
		if($(addRowFour[1])[0]!=null){
			obj.RowChecked2=$(addRowFour[1])[0].checked;
		}
		
		if($(addRowFour[2])[0]!=null){
			obj.RowChecked3=$(addRowFour[2])[0].checked;
		}
		
		
		//非空验证
		if($(addRowTwo[0]).val()==null||$(addRowTwo[0]).val()==""){
			toastr['error']("【副单位1】未选择合适的单位！", "");
			return;
		}
		
		if($(addRowTwo[0]).val()!=null && $(addRowTwo[1]).val()==""){
			toastr['error']("【副单位1】未填写换算比例！", "");
			return;
		}else{
			var reg = /^[1-9]\d*$/;
			if(!reg.test($(addRowTwo[1]).val())){
				toastr['error']("【副单位1】的换算比例必须为正整数！", "");
				return;
			}
		}
		
		
		if($(addRowThree[0]).val()!=null){
			if($(addRowThree[0]).val()!="" && $(addRowThree[1]).val()==""){
				toastr['error']("【副单位2】未填写换算比例！", "");
				return;
			}else if($(addRowThree[0]).val()!="" && $(addRowThree[1]).val()!=""){
				var reg = /^[1-9]\d*$/;
				if(!reg.test($(addRowThree[1]).val())){
					toastr['error']("【副单位2】的换算比例必须为正整数！", "");
					return;
				}
			}
			
			if($(addRowThree[0]).val()=="" && $(addRowThree[1]).val()!=""){
				toastr['error']("【副单位2】未选择合适的单位！", "");
				return;
			}	
		}
		
		//大小判断
		if(parseInt(obj.RowCount2)<=parseInt(obj.RowCount1)){
			toastr['error']("【副单位1】换算比例必须大于1", "");
			return;
		}
		if(obj.RowCount3 !=null){
			if(parseInt(obj.RowCount3)<=parseInt(obj.RowCount2)){
				toastr['error']("【副单位2】换算比例必须大于【副单位1】换算比例", "");
				return;
			}
		}
		
		//至少勾选一个
		var isFlag = false;
		for(var i=0;i<3;i++){
			var tempCheck = eval("obj.RowChecked"+(i+1));
			if(tempCheck){
				isFlag = true;
				break;
			}
		}
		if(!isFlag){
			toastr['error']("可订货单位不能为空", "");
			return;
		}
		
		var str = new StringBuffer();
		str.append(obj.RowValue1+ " / ");
		str.append(obj.RowValue2+ "（" +obj.RowCount2+obj.RowValue1 + "）" + " / ");
		if(obj.RowSelect3 != undefined){
			str.append(obj.RowValue3+ "（" +obj.RowCount3+obj.RowValue1 + "）" + " / ");	
		}
		$("#unitRow").html("<div class=\"row\"><div class=\"col-md-8 state-success\"><input type=\"text\" value=\" "+str.toString().substring(0,str.toString().length-2)+" \" class=\"form-control valid\" readonly=\"readonly\" onclick=\"editMulUnitModal();\" autocomplete=\"off\"></div><div class=\"col-md-4\" style=\"position:relative;\"><input id=\"unitCheckBox\" name=\"unitCheckBox\" type=\"checkbox\" checked=\"checked\" onclick=\"cancelMulUnitModal()\" style=\"margin-top:10px;margin-left:20px;\" autocomplete=\"off\"><span style=\"font-size:12px;\">启用多单位</span><div style=\"width: 81px;position:absolute;top:9px;right:35px;bottom:3px;left:35px;cursor:pointer;\" onclick=\"cancelMulUnitModal()\"></div></div></div>");
		
		$("#finalUnit").val(JSON.stringify(obj));
		
		$("#addMulUnitModal").modal("hide");
	}
	
	
	function initInput(obj){
		$(obj).val("");
	}
	
	function initSelect(obj){
		$(obj).val("");
	}
	
	function initCheckbox(obj){
		$(obj).val("");
	}
	
	function editMulUnitModal(){
		var finalUnitIsNull = $("#finalUnit").val();
		if(finalUnitIsNull.length>0){ //设置过多单位
			var obj = JSON.parse(finalUnitIsNull);
			$("#editRowOne select[name='unitFirst']").val(obj.RowSelect1);
			$("#editRowTwo select[name='unitSecond']").val(obj.RowSelect2);
			$("#editRowTwo input[name='count']").val(obj.RowCount2);
			if(obj.RowSelect3 != undefined){
				$("#editRowThree select[name='unitThird']").val(obj.RowSelect3);
				$("#editRowThree input[name='count']").val(obj.RowCount3);	
			}else{
				$("#editRowThree select[name='unitThird']").val("");
				$("#editRowThree input[name='count']").val("");	
			}

			var editRowFourValueList = [];
			
			for(var i=1;i<=3;i++){
				var tempUnit = eval("obj.RowValue"+i);
				var tempUnitIsFlag = eval("obj.RowChecked"+i);
				if(tempUnit != undefined){
					var tempObj = {};
					tempObj.unitName=tempUnit;
					tempObj.state=tempUnitIsFlag;
					editRowFourValueList.push(tempObj);
				}
			}
			
 			var sb = new StringBuffer();
			for(var i=0;i<editRowFourValueList.length;i++){
				if(editRowFourValueList[i].state){
					sb.append("<span><input checked=\"checked\" type=\"checkbox\"  value=\""+editRowFourValueList[i].unitName+"\"/><span>"+editRowFourValueList[i].unitName+"</span>&nbsp;&nbsp;&nbsp;</span>");
				}else{
					sb.append("<span><input type=\"checkbox\"  value=\""+editRowFourValueList[i].unitName+"\"/><span>"+editRowFourValueList[i].unitName+"</span>&nbsp;&nbsp;&nbsp;</span>");
				}
			}
			
			$("#editRowFour .editRowFourUnitRelevance").html(sb.toString()); 
		}else{
			var unitRelevanceListJson = '${obj.unitRelevanceListJson}';
			var obj = JSON.parse(unitRelevanceListJson);
			$("#editRowOne select[name='unitFirst']").val(obj[0].unitId);
			
			$("#editRowTwo select[name='unitSecond']").val(obj[1].unitId);
			$("#editRowTwo input[name='count']").val(obj[1].count);
			
			if(obj[2] != undefined){
				$("#editRowThree select[name='unitThird']").val(obj[2].unitId);
				$("#editRowThree input[name='count']").val(obj[2].count);	
			}else{
				$("#editRowThree select[name='unitThird']").val("");
				$("#editRowThree input[name='count']").val("");	
			}
			
			var sb = new StringBuffer();
			for(var i=0;i<obj.length;i++){
				if(obj[i].state==1){
					sb.append("<span><input checked=\"checked\" type=\"checkbox\"  value=\""+obj[i].unitName+"\"/><span>"+obj[i].unitName+"</span>&nbsp;&nbsp;&nbsp;</span>");
				}else{
					sb.append("<span><input type=\"checkbox\"  value=\""+obj[i].unitName+"\"/><span>"+obj[i].unitName+"</span>&nbsp;&nbsp;&nbsp;</span>");
				}			
			}
			$("#editRowFour .editRowFourUnitRelevance").html(sb.toString());
		}
		$("#editRowTwo .changeUnit").html(obj.RowValue1);
		$("#editRowThree .changeUnit").html(obj.RowValue1);
		$("#editMulUnitModal").modal("show");
	}
	
	function editMulUnit(){
		var obj = {};
		var editRowOne = $("#editRowOne .form-control");
		var editRowTwo = $("#editRowTwo .form-control");
		var editRowThree = $("#editRowThree .form-control");
		var editRowFour = $("#editRowFour .editRowFourUnitRelevance input");
		
		obj.RowSelect1=$(editRowOne).val();
		obj.RowCount1="1";
		
		obj.RowSelect2=$(editRowTwo[0]).val();
		obj.RowCount2=$(editRowTwo[1]).val();
		
		if($(editRowThree[0]).val()!=null&&$(editRowThree[0]).val()!=""){
			obj.RowSelect3=$(editRowThree[0]).val();
		}
		if($(editRowThree[0]).val()!=null&&$(editRowThree[0]).val()!=""&&$(editRowThree[1]).val()!=null&&$(editRowThree[1]).val()!=""){
			obj.RowCount3=$(editRowThree[1]).val();
		}
		
		obj.RowValue1=$(editRowFour[0]).val();
		obj.RowValue2=$(editRowFour[1]).val();
		
		if($(editRowFour[2]).val()!=null&&$(editRowFour[2]).val()!=""){
			obj.RowValue3=$(editRowFour[2]).val();
		}
		
		obj.RowChecked1=$(editRowFour[0])[0].checked;
		obj.RowChecked2=$(editRowFour[1])[0].checked;
		
		if($(editRowFour[2])[0]!=null){
			obj.RowChecked3=$(editRowFour[2])[0].checked;
		}
		
		if($(editRowTwo[0]).val()!=null && $(editRowTwo[1]).val()==""){
			toastr['error']("【副单位1】未填写换算比例！", "");
			return;
		}else{
			var reg = /^[1-9]\d*$/;
			if(!reg.test($(editRowTwo[1]).val())){
				toastr['error']("【副单位1】的换算比例必须为正整数！", "");
				return;
			}
		}
		
		//星期五
		if($(editRowThree[0]).val()!=null){
			if($(editRowThree[0]).val()!="" && $(editRowThree[1]).val()==""){
				toastr['error']("【副单位2】未填写换算比例！", "");
				return;
			}else if($(editRowThree[0]).val()!="" && $(editRowThree[1]).val()!=""){
				var reg = /^[1-9]\d*$/;
				if(!reg.test($(editRowThree[1]).val())){
					toastr['error']("【副单位2】的换算比例必须为正整数！", "");
					return;
				}
			}
			
			if($(editRowThree[0]).val()=="" && $(editRowThree[1]).val()!=""){
				toastr['error']("【副单位2】未选择合适的单位！", "");
				return;
			}	
		}
		
		//大小判断
		if(parseInt(obj.RowCount2)<=parseInt(obj.RowCount1)){
			toastr['error']("【副单位1】换算比例必须大于1", "");
			return;
		}
		if(obj.RowCount3 !=null){
			if(parseInt(obj.RowCount3)<=parseInt(obj.RowCount2)){
				toastr['error']("【副单位2】换算比例必须大于【副单位1】换算比例", "");
				return;
			}
		}
		
		var isFlag = false;
		for(var i=0;i<3;i++){
			var tempCheck = eval("obj.RowChecked"+(i+1));
			if(tempCheck){
				isFlag = true;
				break;
			}
		}
		if(!isFlag){
			toastr['error']("可订货单位不能为空", "");
			return;
		}
		
		var str = new StringBuffer();
		str.append(obj.RowValue1+ " / ");
		str.append(obj.RowValue2+ "（" +obj.RowCount2+obj.RowValue1 + "）" + " / ");
		if(obj.RowSelect3 != undefined){
			str.append(obj.RowValue3+ "（" +obj.RowCount3+obj.RowValue1 + "）" + " / ");	
		}
		$("#unitRow").html("<div class=\"row\"><div class=\"col-md-8 state-success\"><input type=\"text\" value=\" "+str.toString().substring(0,str.toString().length-2)+" \" class=\"form-control valid\" readonly=\"readonly\" onclick=\"editMulUnitModal();\" autocomplete=\"off\"></div><div class=\"col-md-4\" style=\"position:relative;\"><input id=\"unitCheckBox\" name=\"unitCheckBox\" type=\"checkbox\" checked=\"checked\" onclick=\"cancelMulUnitModal()\" style=\"margin-top:10px;margin-left:20px;\" autocomplete=\"off\"><span style=\"font-size:12px;\">启用多单位</span><div style=\"width: 81px;position:absolute;top:9px;right:35px;bottom:3px;left:35px;cursor:pointer;\" onclick=\"cancelMulUnitModal()\"></div></div></div>");
		
		$("#finalUnit").val(JSON.stringify(obj));
		
		$("#editMulUnitModal").modal("hide");
	}
	
	function cancelMulUnitModal(){
		$("#cancelMulUnitModal").modal("show");
	}
	
	function cancelMulUnit(){
		$("#cancelMulUnitModal").modal("hide");
		var sb = new StringBuffer();
		sb.append("<div class=\"row\"><div class=\"col-md-8 state-success\"><select name=\"unit\" class=\"form-control valid\">");
		
		var unitList = '${obj.unitListStr}';  //这里必须用单引号引住，因为返回的是json字符串里面包含双引号，会冲突
		var unit = "${obj.goodVO.unit}";
		var unitListObj = JSON.parse(unitList);
		for(var i=0;i<unitListObj.length;i++){
			if(unitListObj[i].unitId == unit){
				sb.append("<option selected=\"selected\" value=\""+unitListObj[i].unitId+"\">"+unitListObj[i].unitName+"</option>");
			}else{
				sb.append("<option value=\""+unitListObj[i].unitId+"\">"+unitListObj[i].unitName+"</option>");
			}
		}
		sb.append("</select></div><div class=\"col-md-4\"><input id=\"unitCheckBox\" name=\"unitCheckBox\" type=\"checkbox\" onclick=\"addMulUnitModal()\" style=\"margin-top:10px;margin-left:20px;\" autocomplete=\"off\"><span style=\"font-size:12px;\">启用多单位</span><div style=\"width: 81px;position:absolute;top:9px;right:35px;bottom:3px;left:35px;cursor:pointer;\" onclick=\"addMulUnitModal()\"></div></div></div>");
		$("#unitRow").html(sb.toString());
		$("#finalUnit").val("");
	}
</script>

<!-- edit first select listen -->
<script type="text/javascript">
	var firstSelectOld = "";
	var fitstOptionOld = "";
	$("#editRowOne").on("focus","select[name='unitFirst']",function(){
		firstSelectOld = $("#editRowOne select[name='unitFirst'").val();
		fitstOptionOld = $("#editRowOne select[name='unitFirst'] option[value='"+firstSelectOld+"'] ").text();
	});
	
	
	$("#editRowOne select[name='unitFirst']").on('change',function(){
		var check = $("#editRowFour input[type='checkbox'");
		var firstSelect = $("#editRowOne select[name='unitFirst'").val();
		var fitstOption = $("#editRowOne select[name='unitFirst'] option[value='"+firstSelect+"'] ").text();
		$(check[0]).next().html(fitstOption);
		
		var secondSelect = $("#editRowTwo select[name='unitSecond']").val();
		if(firstSelect == secondSelect){
			toastr['error']("与【副单位1】重复！", "");
			var firstSelect = $("#editRowOne select[name='unitFirst'").val(firstSelectOld);
			$(check[0]).next().html(fitstOptionOld);
			$("#editRowTwo .changeUnit").html(fitstOptionOld);
			$("#editRowThree .changeUnit").html(fitstOptionOld);
			return;
		}
		
		var thirdSelect = $("#editRowThree select[name='unitThird']").val();
		if(firstSelect == thirdSelect){
			toastr['error']("与【副单位2】重复！", "");
			var firstSelect = $("#editRowOne select[name='unitFirst'").val(firstSelectOld);
			$(check[0]).next().html(fitstOptionOld);
			$("#editRowTwo .changeUnit").html(fitstOptionOld);
			$("#editRowThree .changeUnit").html(fitstOptionOld);
			return;
		}

		$($(check[0])[0]).val(fitstOption);
		
		firstSelectOld = firstSelect;
		fitstOptionOld = fitstOption;
		$("#editRowTwo .changeUnit").html(fitstOption);
		$("#editRowThree .changeUnit").html(fitstOption);
	});
	
</script>

<!-- edit second select listen -->
<script type="text/javascript">

	var secondSelectOld = "";
	var secondOptionOld = "";
	$("#editRowTwo").on("focus","select[name='unitSecond']",function(){
		secondSelectOld = $("#editRowTwo select[name='unitSecond'").val();
		secondOptionOld = $("#editRowTwo select[name='unitSecond'] option[value='"+secondSelectOld+"'] ").text();
	});
	
 	$("#editRowTwo select[name='unitSecond']").on('change',function(){
		var check = $("#editRowFour input[type='checkbox'");
		var secondSelect = $("#editRowTwo select[name='unitSecond'").val();
		var secondOption = $("#editRowTwo select[name='unitSecond'] option[value='"+secondSelect+"'] ").text();
		$(check[1]).val(secondSelect);
		$(check[1]).next().html(secondOption);
		
		var firstSelect = $("#editRowOne select[name='unitFirst']").val();
		if(secondSelect == firstSelect){
			toastr['error']("与【最小单位】重复！", "");
			var secondSelect = $("#editRowTwo select[name='unitSecond'").val(secondSelectOld);
			$(check[1]).val(secondOptionOld);
			$(check[1]).next().html(secondOptionOld);
			return;
		}
		
		var thirdSelect = $("#editRowThree select[name='unitThird']").val();
		if(secondSelect == thirdSelect){
			toastr['error']("与【副单位2】重复！", "");
			var secondSelect = $("#editRowTwo select[name='unitSecond'").val(secondSelectOld);
			$(check[1]).val(secondOptionOld);
			$(check[1]).next().html(secondOptionOld);
			return;
		}

		secondSelectOld = secondSelect;
		secondOptionOld = secondOption;
		
		$(check[1]).val(secondOption);
		$(check[1]).next().html(secondOption);
	}); 
	
</script>

<!-- edit third select listen -->
<script type="text/javascript">

	var thirdSelectOld = "";
	var thirdOptionOld = "";
	$("#editRowThree").on("focus","select[name='unitThird']",function(){
		thirdSelectOld = $("#editRowThree select[name='unitThird'").val();
		thirdOptionOld = $("#editRowThree select[name='unitThird'] option[value='"+thirdSelectOld+"'] ").text();
	});
	
 	$("#editRowThree select[name='unitThird']").on('change',function(){
		var check = $("#editRowFour input[type='checkbox'");
		var thirdSelect = $("#editRowThree select[name='unitThird'").val();
		var thirdOption = $("#editRowThree select[name='unitThird'] option[value='"+thirdSelect+"'] ").text();
		
		if(thirdSelect == ""){
			var checkBoxList = $("#editRowFour .editRowFourUnitRelevance");
			checkBoxList[0].removeChild(checkBoxList[0].children[2]);
			thirdSelectOld = thirdSelect;
			thirdOptionOld = thirdOption;
			return;
		}
		
		var firstSelect = $("#editRowOne select[name='unitFirst']").val();
		if(thirdSelect == firstSelect){
			toastr['error']("与【最小单位】重复！", "");
			var thirdSelect = $("#editRowThree select[name='unitThird'").val(thirdSelectOld);
			if(checkState == undefined){
				//$("#editRowFour .editRowFourUnitRelevance").append("<input checked=\"checked\" type=\"checkbox\"  value=\""+thirdOption+"\"/><span>"+thirdOption+"</span>&nbsp;&nbsp;&nbsp;");
			}else{
				$(check[2]).val(thirdOptionOld);
				$(check[2]).next().html(thirdOptionOld);
			}
			return;
		}
		
		var secondSelect = $("#editRowTwo select[name='unitSecond']").val();
		if(thirdSelect == secondSelect){
			toastr['error']("与【副单位1】重复！", "");
			var thirdSelect = $("#editRowThree select[name='unitThird'").val(thirdSelectOld);
			if(checkState == undefined){
				//$("#editRowFour .editRowFourUnitRelevance").append("<input checked=\"checked\" type=\"checkbox\"  value=\""+thirdOption+"\"/><span>"+thirdOption+"</span>&nbsp;&nbsp;&nbsp;");
			}else{
				$(check[2]).val(thirdOptionOld);
				$(check[2]).next().html(thirdOptionOld);
			}
			return;
		}
		var checkState = check[2];
		if(checkState == undefined){
			$("#editRowFour .editRowFourUnitRelevance").append("<span><input checked=\"checked\" type=\"checkbox\"  value=\""+thirdOption+"\"/><span>"+thirdOption+"</span>&nbsp;&nbsp;&nbsp;</span>");
		}else{
			$(check[2]).val(thirdOption);
			$(check[2]).next().html(thirdOption);
		}

		thirdSelectOld = thirdSelect;
		thirdOptionOld = thirdOption;
	}); 
	
</script>







<!-- 添加多单位模态框监听 -->







<!-- add first select listen -->
<script type="text/javascript">
	var addFirstSelectOld = "";
	var addFirstOptionOld = "";
	$("#addRowOne").on("focus","select[name='unitFirst']",function(){
		addFirstSelectOld = $("#addRowOne select[name='unitFirst'").val();
		addFirstOptionOld = $("#addRowOne select[name='unitFirst'] option[value='"+addFirstSelectOld+"'] ").text();
	});
	
	
	$("#addRowOne select[name='unitFirst']").on('change',function(){
		var check = $("#addRowFour input[type='checkbox'");
		var firstSelect = $("#addRowOne select[name='unitFirst'").val();
		var fitstOption = $("#addRowOne select[name='unitFirst'] option[value='"+firstSelect+"'] ").text();
		$(check[0]).next().html(fitstOption);
		
		var secondSelect = $("#addRowTwo select[name='unitSecond']").val();
		if(firstSelect == secondSelect){
			toastr['error']("与【副单位1】重复！", "");
			var firstSelect = $("#addRowOne select[name='unitFirst'").val(addFirstSelectOld);
			$(check[0]).next().html(addFirstOptionOld);
			$("#addRowTwo .changeUnit").html(addFirstOptionOld);
			$("#addRowThree .changeUnit").html(addFirstOptionOld);
			return;
		}
		
		var thirdSelect = $("#addRowThree select[name='unitThird']").val();
		if(firstSelect == thirdSelect){
			toastr['error']("与【副单位2】重复！", "");
			var firstSelect = $("#addRowOne select[name='unitFirst'").val(addFirstSelectOld);
			$(check[0]).next().html(addFirstOptionOld);
			$("#addRowTwo .changeUnit").html(addFirstOptionOld);
			$("#addRowThree .changeUnit").html(addFirstOptionOld);
			return;
		}

		$($(check[0])[0]).val(fitstOption);
		
		addFirstSelectOld = firstSelect;
		addFirstOptionOld = fitstOption;
		$("#addRowTwo .changeUnit").html(fitstOption);
		$("#addRowThree .changeUnit").html(fitstOption);
	});
	
</script>

<!-- add second select listen -->
<script type="text/javascript">

	var addSecondSelectOld = "";
	var addSecondOptionOld = "";
	$("#addRowTwo").on("focus","select[name='unitSecond']",function(){
		addSecondSelectOld = $("#addRowTwo select[name='unitSecond'").val();
		addSecondOptionOld = $("#addRowTwo select[name='unitSecond'] option[value='"+addSecondSelectOld+"'] ").text();
	});
	
 	$("#addRowTwo select[name='unitSecond']").on('change',function(){
		var check = $("#addRowFour input[type='checkbox'");
		var secondSelect = $("#addRowTwo select[name='unitSecond'").val();
		var secondOption = $("#addRowTwo select[name='unitSecond'] option[value='"+secondSelect+"'] ").text();
		
		var isHas2 = false;
		var isHas2Obj;
		for(var i=0;i<3;i++){
			if($(check[i]).data("index")==2){
				isHas2 = true;
				isHas2Obj = $(check[i]);
				break;
			}
		}
		
		if(secondSelect == ""){
			var checkBoxList = $("#addRowFour .addRowFourUnitRelevance");
			var child = checkBoxList[0].children;
			for(var i=0;i<child.length;i++){
				 var tempInput = $(child[i]).find("input");
				 if(tempInput.data("index")==2){
					 checkBoxList[0].removeChild($(tempInput).parent()[0]);
				 }
			}
			addSecondSelectOld = secondSelect;
			addSecondOptionOld = secondOption;
			return;
		}
		
		if(!isHas2){
			$("#addRowFour .addRowFourUnitRelevance").append("<span><input data-index=\"2\" checked=\"checked\" type=\"checkbox\"  value=\""+secondOption+"\"/><span>"+secondOption+"</span>&nbsp;&nbsp;&nbsp;</span>");
		}else{
			$(isHas2Obj).val(secondOption);
			$(isHas2Obj).next().html(secondOption);
		}
		
		var firstSelect = $("#addRowOne select[name='unitFirst']").val();
		if(secondSelect == firstSelect){
			toastr['error']("与【最小单位】重复！", "");
			var secondSelect = $("#addRowTwo select[name='unitSecond'").val(addSecondSelectOld);
			check = $("#addRowFour input[type='checkbox'");
			for(var i=0;i<3;i++){
				if($(check[i]).data("index")==2){
					isHas2 = true;
					isHas2Obj = $(check[i]);
					break;
				}
			}
			if(addSecondSelectOld==""){
				var checkBoxList = $("#addRowFour .addRowFourUnitRelevance");
				var child = checkBoxList[0].children;
				for(var i=0;i<child.length;i++){
					 var tempInput = $(child[i]).find("input");
					 if(tempInput.data("index")==2){
						 checkBoxList[0].removeChild($(tempInput).parent()[0]);
					 }
				}
			}else{
				$(isHas2Obj).val(addSecondOptionOld);
				$(isHas2Obj).next().html(addSecondOptionOld);
			}
			return;
		}
		
		var thirdSelect = $("#addRowThree select[name='unitThird']").val();
		if(secondSelect == thirdSelect){
			toastr['error']("与【副单位2】重复！", "");
			var secondSelect = $("#addRowTwo select[name='unitSecond'").val(addSecondSelectOld);
			check = $("#addRowFour input[type='checkbox'");
			for(var i=0;i<3;i++){
				if($(check[i]).data("index")==2){
					isHas2 = true;
					isHas2Obj = $(check[i]);
					break;
				}
			}
			if(addSecondSelectOld==""){
				var checkBoxList = $("#addRowFour .addRowFourUnitRelevance");
				var child = checkBoxList[0].children;
				for(var i=0;i<child.length;i++){
					 var tempInput = $(child[i]).find("input");
					 if(tempInput.data("index")==2){
						 checkBoxList[0].removeChild($(tempInput).parent()[0]);
					 }
				}
			}else{
				$(isHas2Obj).val(addSecondOptionOld);
				$(isHas2Obj).next().html(addSecondOptionOld);
			}
			return;
		}
		
		
		addSecondSelectOld = secondSelect;
		addSecondOptionOld = secondOption;
		
		//checkbox排序
		var checkSort = $("#addRowFour .addRowFourUnitRelevance")[0].children;
		var sortStr = new StringBuffer();
		var sortMap = new Map();
		var index = 0;
		for(var i=0;i<checkSort.length;i++){
			var value = $(checkSort[i]).context.outerHTML;
			var key = $(checkSort[i]).find("input").data("index");
			sortMap.put(key,value);
			if(key>index){
				index = key;
			}
		}
		for(var i=1;i<=index;i++){
			if(sortMap.get(i)!=null){
				sortStr.append(sortMap.get(i));
			}
		}
		$("#addRowFour .addRowFourUnitRelevance").html(sortStr.toString());
	}); 
	
</script>

<!-- add third select listen -->
<script type="text/javascript">

	var addThirdSelectOld = "";
	var addThirdOptionOld = "";
	$("#addRowThree").on("focus","select[name='unitThird']",function(){
		addThirdSelectOld = $("#addRowThree select[name='unitThird'").val();
		addThirdOptionOld = $("#addRowThree select[name='unitThird'] option[value='"+addThirdSelectOld+"'] ").text();
	});
	
 	$("#addRowThree select[name='unitThird']").on('change',function(){
		var check = $("#addRowFour input[type='checkbox'");
		var thirdSelect = $("#addRowThree select[name='unitThird'").val();
		var thirdOption = $("#addRowThree select[name='unitThird'] option[value='"+thirdSelect+"'] ").text();

		
		var isHas3 = false;
		var isHas3Obj;
		for(var i=0;i<3;i++){
			if($(check[i]).data("index")==3){
				isHas3 = true;
				isHas3Obj = $(check[i]);
				break;
			}
		}
		
		if(thirdSelect == ""){
			var checkBoxList = $("#addRowFour .addRowFourUnitRelevance");
			var child = checkBoxList[0].children;
			for(var i=0;i<child.length;i++){
				 var tempInput = $(child[i]).find("input");
				 if(tempInput.data("index")==3){
					 checkBoxList[0].removeChild($(tempInput).parent()[0]);
				 }
			}
			addThirdSelectOld = thirdSelect;
			addThirdOptionOld = thirdOption;
			return;
		}
		
		if(!isHas3){
			$("#addRowFour .addRowFourUnitRelevance").append("<span><input data-index=\"3\" checked=\"checked\" type=\"checkbox\"  value=\""+thirdOption+"\"/><span>"+thirdOption+"</span>&nbsp;&nbsp;&nbsp;</span>");
		}else{
			$(isHas3Obj).val(thirdOption);
			$(isHas3Obj).next().html(thirdOption);
		}
		
		var firstSelect = $("#addRowOne select[name='unitFirst']").val();
		if(thirdSelect == firstSelect){
			toastr['error']("与【最小单位】重复！", "");
			var thirdSelect = $("#addRowThree select[name='unitThird'").val(addThirdSelectOld);
			check = $("#addRowFour input[type='checkbox'");
			for (var i = 0; i < 3; i++) {
			    if ($(check[i]).data("index") == 3) {
			        isHas3 = true;
			        isHas3Obj = $(check[i]);
			        break;
			    }
			}
			if (addThirdSelectOld == "") {
			    var checkBoxList = $("#addRowFour .addRowFourUnitRelevance");
			    var child = checkBoxList[0].children;
			    for (var i = 0; i < child.length; i++) {
			        var tempInput = $(child[i]).find("input");
			        if (tempInput.data("index") == 3) {
			            checkBoxList[0].removeChild($(tempInput).parent()[0]);
			        }
			    }
			} else {
			    $(isHas3Obj).val(addThirdOptionOld);
			    $(isHas3Obj).next().html(addThirdOptionOld);
			}
			return;
		}
		
		var secondSelect = $("#addRowTwo select[name='unitSecond']").val();
		if(thirdSelect == secondSelect){
			toastr['error']("与【副单位1】重复！", "");
			var thirdSelect = $("#addRowThree select[name='unitThird'").val(addThirdSelectOld);
			check = $("#addRowFour input[type='checkbox'");
			for (var i = 0; i < 3; i++) {
			    if ($(check[i]).data("index") == 3) {
			        isHas3 = true;
			        isHas3Obj = $(check[i]);
			        break;
			    }
			}
			if (addThirdSelectOld == "") {
			    var checkBoxList = $("#addRowFour .addRowFourUnitRelevance");
			    var child = checkBoxList[0].children;
			    for (var i = 0; i < child.length; i++) {
			        var tempInput = $(child[i]).find("input");
			        if (tempInput.data("index") == 3) {
			            checkBoxList[0].removeChild($(tempInput).parent()[0]);
			        }
			    }
			} else {
			    $(isHas3Obj).val(addThirdOptionOld);
			    $(isHas3Obj).next().html(addThirdOptionOld);
			}
			return;
		}
		
		addThirdSelectOld = thirdSelect;
		addThirdOptionOld = thirdOption;
		
		//checkbox排序
		var checkSort = $("#addRowFour .addRowFourUnitRelevance")[0].children;
		var sortStr = new StringBuffer();
		var sortMap = new Map();
		var index = 0;
		for(var i=0;i<checkSort.length;i++){
			var value = $(checkSort[i]).context.outerHTML;
			var key = $(checkSort[i]).find("input").data("index");
			sortMap.put(key,value);
			if(key>index){
				index = key;
			}
		}
		for(var i=1;i<=index;i++){
			if(sortMap.get(i)!=null){
				sortStr.append(sortMap.get(i));
			}
		}
		$("#addRowFour .addRowFourUnitRelevance").html(sortStr.toString());
	}); 
	
</script>
</body>

</html>