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
											<form id="fileupload" action="${contextPath}/manage/saveGoodSpec"
												class="form-horizontal" method="POST" >
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
																			class="form-control" value="${obj.goodVO.goodsName}"  readonly="readonly" />
																	</div>
																</div>
															</div>
															<div class="col-md-6">
																<div class="form-group">
																	<label for="type" class="col-md-3 control-label">物料类别<span class='require'>*</span></label>
																	<div class="col-md-9">
																		<select id="goodsType" name="goodsType" class="form-control"  disabled="disabled">
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
																	<label for="unit" class="col-md-3 control-label">计量单位<span class='require'>*</span><input name ="unitRelevanceStr" type="hidden" value='${obj.unitRelevanceStr }'  /></label>
																	<div class="col-md-9">
																		<select id="unit" name="unit" class="form-control" disabled="disabled">
																			<c:forEach var="unitVO" items="${obj.unitList}" varStatus="status">
																				<option <c:if test="${obj.goodVO.unit == unitVO.unitId}">selected="selected"</c:if>
																					value="${unitVO.unitId}"> <c:choose><c:when test = "${obj.unitRelevanceStr != null }">${obj.unitRelevanceStr }</c:when><c:otherwise>${unitVO.unitName}</c:otherwise></c:choose>  </option>
																			</c:forEach>
																		</select>
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
														<div class="row" >
															<div class="col-md-6" style="display:none;">
																<div class="form-group">
																	<label for="isList" class="col-md-3 control-label">是否上架<span class='require'>*</span></label>
																	<div class="col-md-9">
																		<select id="isList" name="isList" class="form-control">
																			<option value="Y">是</option>
																			<option selected="selected"  value="N">否</option>
																		</select>
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
														<h3 style="padding: 10px;font-size: 18px;">兽药通所属字段</h3>
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

														<div class="spec-listintable">
															<table class="table table-striped table-bordered">
																<thead class="spec-thead" style="background-color: #f8f8f8">
																	<tr>
																		<td>序号</td>
																		<td>略图</td>
																		<c:choose>
																			<c:when test="${obj.specList.size() > 0}">
																					<c:forEach var="specList" items="${obj.specList}"  varStatus="status">
																						<td class="thead-spec1">${specList }<input type="hidden"  name="specName" value="${specList }"/></td>
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
																	<c:choose>
																			<c:when test="${obj.list.size() > 0}">
																					<c:forEach var="list" items="${obj.list}"  varStatus="status">
																						<tr>
																							<td><input type="hidden" name="uuid" value="${list.uuid }"><input type="hidden" name="specNum" value="${list.num }"><span>${list.num }</span></td>
																							<td class="df-img"><img src="images/spec.png"/><div class="hidden-area"><input type="hidden" name="imgBig" value=""><input type="hidden" name="imgSmall" value=""></div></td>
																							<c:if test="${list.specOne != null && list.specOne != '' }"><td><input type="hidden" name="specOne" value="${list.specOne }">${list.specOne }</td></c:if>
																							<c:if test="${list.specTwo != null && list.specTwo != '' }"><td><input type="hidden" name="specTwo" value="${list.specTwo }">${list.specTwo }</td></c:if>
																							<c:if test="${list.specThree != null && list.specThree != '' }"><td><input type="hidden" name="specThree" value="${list.specThree }">${list.specThree }</td></c:if>
																							<td><input type="text"  name="goodsCode"  value="${list.goodsCode }"/></td>
																							<td><input type="text" name="goodsBarCode" value="${list.goodsBarCode }"></td>
																							<td class="del-btn">删除</td>
																						</tr>
																					</c:forEach>
																			</c:when>
																			<c:otherwise>
																				<tr></tr>
																			</c:otherwise>
																	</c:choose>
																</tbody>
																
																
															</table>
														</div>
														
														
														<h3>物料信息</h3>
														<hr />
														<div class="row">
															<div class="col-md-11">
																<%-- <textarea rows="15" cols="138" id="goodsInfo"
																	name="goodsInfo">${obj.goodVO.goodsInfo}</textarea>
																<textarea class="ckeditor" cols="100" id="goodsInfo" name="goodsInfo" rows="15">${obj.goodVO.goodsInfo}</textarea> --%>
																<textarea class="ckeditor" cols="100" id="goodsInfo" name="goodsInfo" rows="15">${obj.goodVO.goodsInfo}</textarea>
																<script type="text/javascript">
																CKEDITOR.replace( 'goodsInfo',
																        {
																             toolbar :
																             [
																                ['Source','Bold','Italic','Underline'],
																                ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
																                [ 'Link','Unlink'],
																                ['Image'],
																                ['FontSize'],
																                ['TextColor'],
																             ],
																             allowedContent: true
																        }
																    );

																</script>
															</div>
														</div>
														<br />

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
																					<label for="成本价" class="col-md-1 control-label">成本价
																					</label>
																					<div class="col-md-2">
																						<input id="cPrice" name="cPrice" type="text" placeholder="0.00" class="form-control" value="${obj.goodVO.cPriceStr}" />
																					</div>
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

												</div>
												<div class="text-right pal pull-left">
													<button  type="button" class="btn btn-primary start" onclick="subForm()">保存</button>
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
        	
        	var targetImgSrc2 = '${obj.goodVO.coverUrlOriginal}'; //上传的截图的初始化路径
	        
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
        	//勾选设置规格改变
        	//添加规格点击事件
        	
        	//初始化编辑页图片
        	
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
        	
        	//显示裁剪图片模态框
        	var targetImg, jcrop_api;
        	function showImgModal(){
	        	$('.df-img img').click(function() {
	        		$('#_targetImg').removeAttr('id');//保证只有一个隐藏原图、小图链接的表单隐藏域id
	        		targetImg = this;
	        		targetImg.nextSibling.id = '_targetImg';
	        		targetInput = this.parentNode.parentNode.firstElementChild.firstElementChild;
	        		console.log(this);
	        		$('#_goodsuuid').val(targetInput.value);
	        		
	        		$('#width').val(0);  //初始化 裁剪区域的宽  
	                $('#height').val(0); //初始化裁剪区域的高  
	                $('#x').val(0);  //初始化裁剪区域左上角顶点相对于图片左上角顶点的x坐标  
	                $('#y').val(0);  //初始化裁剪区域顶点的y坐标
	                
	        		$('#uploadImgModal').modal();
	        		jcrop_api&&jcrop_api.animateTo([0,0,200,200]);
	            	if('${obj.goodVO.coverUrlOriginal}'!=''){
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

     	
        function subForm() {
        	for(instance in CKEDITOR.instances){
        		CKEDITOR.instances[instance].updateElement();
        	}
            $.ajax({
                type: 'POST',
                url: '${contextPath}/manage/saveGoodSpec',
                data: $('#fileupload').serialize(),
                dataType: 'json',
                success: function(result) {
                    if (result.result == 'OK') {
                        toastr['success'](result.msg, "");
                        setTimeout(function() {
                            window.location.href = "${contextPath}/manage/showGoods";
                        },600);
                    } else {
                    	toastr['error'](result.msg, "");
    	        		var goodsCode = $("#fileupload input[name=goodsCode]");
    	        		for(var i=0;i<goodsCode.length;i++){
    	        			if($(goodsCode[i]).val() == result.code){
    	        				$(goodsCode[i]).focus();
    	        				break;
    	        			}
    	        		}
                    }
                }
            });
        }
</script>
</body>

</html>