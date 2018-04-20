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
	href="${contextPath}/manage/css/style2.css">
<style>
.table th,.table td {
	text-align: center;
	vertical-align: middle !important ；//垂直居中
}

.table>thead>tr>th,.table>tbody>tr>th,.table>tfoot>tr>th,.table>thead>tr>td,.table>tbody>tr>td,.table>tfoot>tr>td
	{
	vertical-align: middle !important ；//垂直居中
}
.goodselect{
	cursor: pointer;
}
.bigimg{
	max-height: 480px;
}
.modal-md {
    width: 900px;
}
#goodAddSpecTableUp{
	width: 100%;height: auto;
}
#goodAddSpecTableUp tr td{
	text-align: center;height: 30px;line-height: 30px;padding-top: 11px;
}
#goodAddSpecTableUp tr td em{
    font-size: 20px;cursor: pointer;width: 100%;height: 33px;line-height: 33px;
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
						<li><i class="fa fa-home"></i>&nbsp;<a href="index.jsp">首页</a>&nbsp;&nbsp;<i
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
							<div class="detailtop">
								<div class="imgleft left-topcon">
									<div style="height:480px;position:relative">
									<c:choose>
										<c:when test="${obj.pictureList.size() > 0}">
											<c:forEach var="pictureVO" items="${obj.pictureList}"
													varStatus="status" begin="0" end="0">
														<img class="bigimg"  src="${QUPLOADIMG}${pictureVO.uploadUrl}" />
											</c:forEach>
										</c:when>
										<c:otherwise>
											<img class="bigimg"  src="${contextPath}/manage/images/picList-default.jpg" />
										</c:otherwise>
									</c:choose>
										<span style="height:100%;display:inline-block;vertical-align:middle;"></span>
									</div>
									<div class="littleimgs">
										<ul class="littleimgul">
											<c:choose>
												<c:when test="${obj.pictureList.size() > 0}">
													<c:forEach var="pictureVO" items="${obj.pictureList}"
														varStatus="status">
														<li class="littleimg">
															<img src="${QUPLOADIMG}${pictureVO.uploadUrl}" />
														</li>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<li class="littleimg">
														<img src="${contextPath}/manage/images/picList-default.jpg" />
													</li>
												</c:otherwise>
											</c:choose>
										</ul>
									</div>
									<div class='imgturnleft fa fa-angle-left'></div>
									<div class="imgturnright fa fa-angle-right" style="margin-bottom:3px;"></div>
								</div>

								<div class="detailright topcon">
									<div class="goodname">${obj.goodVO.goodsName}</div>
									<div class="goodcatos" style="padding-left:0;">
										<div class="goodcato">分类：${obj.goodVO.typeVO.typeName}</div>
										<div class="goodcato">编码：${obj.goodVO.goodsCode}</div>
										<div class="goodcato">条形码：${obj.goodVO.goodsBarCode}</div>
									</div>
									<div class="good-price">
									
										<c:choose>
											<c:when test="${obj.goodVO.state == '0' }">
													<div class="goodprice">
														市场价格：<em>￥${obj.goodVO.mPrice}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</em><shiro:hasPermission name="good:checkCost">参考成本价：<em>￥${obj.goodVO.cPrice}</em>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-primary btn-md" data-toggle="modal" data-target="#batchNumForm" style="display:none;">查看批次号及其价格</button></shiro:hasPermission>
													</div>
													<hr style="display:none;"/>
													<div class="row" style="display:none;">
														<div class="col-lg-11">
															<table class="table table-hover table-striped table-bordered table-advanced tablesorter">
																<thead>
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
																			<c:forEach var="goods_LevelVO"
																				items="${obj.goods_LevelList}" varStatus="status">
																				<c:if
																					test="${levelVO.levelId == goods_LevelVO.customLevelId}">
																					<td>
																						<c:choose>
																							<c:when test="${goods_LevelVO.isOrdered == 'Y'}">
																								<label>是</label>
																							</c:when>
																							<c:otherwise>
																								<label>否</label>
																							</c:otherwise>
																						</c:choose>
																					</td>
																					<td>
																						<div class="form-group">
																							<div class="col-md-12">
																								<label>${goods_LevelVO.orderPrice}</label>
																							</div>
																						</div>
																					</td>
																					<td>
																						<div class="form-group">
																							<div class="col-md-12">
																								<label>${goods_LevelVO.minNum}</label>
																							</div>
																						</div>
																					</td>
																				</c:if>
																			</c:forEach>
																		</tr>
																	</c:forEach>
																</tbody>
															</table>
														</div>
													</div>
											</c:when>
											<c:otherwise>
												<span style="color:red ;font-size:16px;">无此规格物料！</span>
											</c:otherwise>
										</c:choose>
										
									</div>
									
									
									<c:forEach var="specVOList" items="${obj.specVOList}" varStatus="status">
										<div class="goodmaterials goodselects">
											选择${specVOList.specName }：
											<input name="specNames" type="hidden" value="${specVOList.specId}">
											<c:forEach var="specValueVOList" items="${obj.specValueVOList}" varStatus="status">
												<c:if test="${specVOList.specId==specValueVOList.specId }">
													<div class="goodselect <c:forEach var="goodSpecValueVO" items="${obj.goodVO.goodSpecValueVO}" varStatus="status"><c:if test="${ goodSpecValueVO.specValueVO.specValueId==specValueVOList.specValueId}">goodselected</c:if></c:forEach>	"<c:forEach var="goodSpecValueVO" items="${obj.goodVO.goodSpecValueVO}" varStatus="status"><c:if test="${ goodSpecValueVO.specValueVO.specValueId==specValueVOList.specValueId}">style="border: 2px solid rgb(3, 184, 204);"</c:if></c:forEach>>
														<b></b>${specValueVOList.specValue}
													</div>
													<input name="${specValueVOList.specValue }" type="hidden" value="${specValueVOList.specValueId}">
												</c:if>
											</c:forEach>
										</div>
									</c:forEach>
									
									<%-- 库存：<c:choose><c:when test="${obj.goodVO.inventoryVO.quantity!=null}">${obj.goodVO.inventoryVO.quantity}</c:when><c:otherwise>0</c:otherwise></c:choose> --%>
									<div class="goodmeature goodcatos">计量单位：${obj.goodVO.unitVO.unitName}</div>
									
									<c:if test = "${obj.unitRelevanceStr.length()>0 }">
										<div class="goodmeature goodcatos">副单位：${obj.unitRelevanceStr}</div>
									</c:if>
									
									<div class="goodtags goodcatos" style="display:none;">
										物料标签：
										<c:choose>
											<c:when test="${obj.tags != null}">
												<c:forEach var="tag" items="${obj.tags}" varStatus="status">
													<em><c:out value="${tag}"></c:out></em>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<span>无</span>
											</c:otherwise>
										</c:choose>

									</div>
									<div class="goodInventory goodcatos">
										<span>仓库/库存：</span><br/>
										<c:forEach var="inventory" items="${obj.inventory }" varStatus="status">
											<span>${inventory.storeName }<c:if test="${inventory.storeIsDefault == 'Y' }">(默认仓库)</c:if>&nbsp;&nbsp;:&nbsp;</span>
											<span>${inventory.quantity }</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</c:forEach>
									</div>
									<br/>
									<c:if test="${obj.goodVO.state == '0' }">
										<br/>
										<div class="goodfunction">
											<c:if test="${obj.specVOListSize >0 }"><button type="button" class="btn btn-primary btn-md" onclick="addGoodById('${obj.goodVO.goodId}');"><em class="fa fa-plus"></em>&nbsp;&nbsp;新增规格</button></c:if>
											<button type="button" class="btn btn-primary btn-md" onclick="updGoodById('${obj.goodVO.goodId}');"><em class="fa fa-pencil"></em>&nbsp;&nbsp;修改</button>
											<button type="button" class="btn btn-primary btn-md" onclick="delGoodById('${obj.goodVO.goodId}');"><em class="fa fa-times"></em>&nbsp;&nbsp;删除</button>
										</div>
									</c:if>
									<br/>
									
								</div>
							</div>
							<div class="detailbottom">
								<div class="bottomtabs">
									<div class="bottomtab tabselect">物料介绍</div>
									<div class="bottomtab">物料附件</div>
								</div>
								<div class="bottomdivs">
									<div class="bottomdiv">
										<div class="goodcatos">
											<pre style="line-height:2">${obj.goodVO.goodsInfo}</pre>
										</div>
									</div>
									<div class="bottomdiv" style="display: none;">暂无附件</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!--END CONTENT-->
				
				<div class="modal fade bs-example-modal-md"   id="goodAddSpecModal"  tabindex="-1" role="dialog" labelledby="" aria-hidden="true">
			    	<div class="modal-dialog modal-md">
			    		<div class="modal-content" >
				    		<form id="creadGoodsBySpec" action="${contextPath}/manage/addGoodsSpec" class="form-horizontal" method="POST" >
				    			<input type="hidden"  name="goodId"  value="${obj.goodVO.goodId }">
				    			<div class="modal-header">
				    				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				    				<label  class="modal-title"  style = "font-size:16px;">新增规格</label >
				    			</div>
				    			
				    			<div class="modal-body">
					    				<div class="row">
											<div class="col-lg-12 specTable"></div>
										</div>
				    			</div>
				    			
				    			<div class="modal-footer">
				    				<button type="button" class="btn btn-primary"  onclick="checkForm()">&nbsp; &nbsp;新增并填写物料&nbsp;&nbsp;</button>
									<button type="button" class="btn btn-default" data-dismiss="modal" style="margin-left: 20px">&nbsp;&nbsp;取&nbsp;消&nbsp;&nbsp;</button>
				    			</div>
				    		</form>
			    		</div>
			    	</div>
			    </div>
				
			</div>
			
			<div class="modal fade"   id="goodsDelModal"  tabindex="-1" role="dialog" labelledby="" aria-hidden="true">
		    	<div class="modal-dialog modal-xs">
		    		<div class="modal-content">
		    			<div class="modal-header">
		    				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		    				<h4 class="modal-title" id="gridSystemModalLabel">警告</h4>
		    			</div>
		    			<div class="modal-body">
		    				<p class="text-danger" style="font-size:20px;">确定要删除吗？</p>
		    				<br/>
		    				<form action="${contextPath}/manage/delGood" class="form-horizontal" method="post" name="menu_del">
		    					<input type="hidden" name="goodId"/>
							</form>
		    			</div>
		    			<div class="modal-footer">
		    				<button type="button" class="btn btn-danger" onclick="delGoodByIds();">&nbsp; &nbsp;确&nbsp;定&nbsp;&nbsp;</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal" style="margin-left: 20px">&nbsp;&nbsp;取&nbsp;消&nbsp;&nbsp;</button>
		    			</div>
		    		</div>
		    	</div>
		    </div>
			    
			<div id="batchNumForm" class="modal fade">
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
			<script src="${contextPath}/manage/js/file-upload.js"></script>
			<script src="${contextPath}/manage/js/style2.js"></script>

<script type="text/javascript">
	//菜单初始化
	activeMenu("orderManageMenu","supplyOrderUL", "goodMenu");

	turnImgBtn();

	var result = "${obj.result}";
	var message = "${obj.msg}";
	if (result == 'OK') {
		toastr['success'](message, "");
		setTimeout(function() {
			window.location.href = "${contextPath}/manage/showGoods";
		},
		600);
	} else if (result == 'FAIL') {
		toastr['error'](message, "");
	}

	function ev_back() {
		window.history.back();
	}

	$(function() {
		$('.goodselect').bind('click',
		function() {
			var hidInput = $('.goodselects').find('.goodselected').next();
			var specName = $('.goodselects>input[name="specNames"]');
			var hidInputVal = [];
			var specNameVal = [];
			for (var i = 0; i < hidInput.length; i++) {
				hidInputVal.push(hidInput[i].value);
				specNameVal.push(specName[i].value);
			}
			var data = {
				spec: specNameVal.join(','),
				specValue: hidInputVal.join(',')
			}
			console.log(data);
			$.post('${contextPath}/manage/getGoodIdInGoodInfo', data,
			function(result) {
				if (result == null || result == '') {
					toastr['warning']("无该类型的物料！", "");
				} else {
					window.location.href = "${contextPath}/manage/showGoodInfo?goodId=" + result;
				}
			},
			'json');
		});
	});

	function delGoodById(id) {
		$("#goodsDelModal input").val(id);
		$("#goodsDelModal").modal();
	}
	
	function delGoodByIds(id) {
		$.post('${contextPath}/manage/delGood',{goodId:$("#goodsDelModal input").val()},function(data){
			if(data.result=='OK'){
   	    		toastr['success']("删除成功!", "");
     	        setTimeout(function(){
     	        	window.location.href = "${contextPath}/manage/showGoods";
     	        },600);
			}else{
				toastr['error'](data.msg, "");
			}
		},'json');
	}

	function updGoodById(id) {
		var url = "${contextPath}/manage/editGood?goodId=" + id;
		window.location.href = url;
	}

	var num = 1;
	//后台
	var specName = null;
	var goodsCode = null;
	var goodsList = null;
	function addGoodById(id) {
		//前台
		var modalTable = $("#goodAddSpecModal .specTable");
		var t = new StringBuffer();
		var ts = new StringBuffer();
		num = 1;
		
        $.ajax({
      	  type: 'POST',
      	  url: '${contextPath}/manage/getGoodsInfoByName',
      	  data:{goodId:id},
      	  success: function(result){
		    	if(result.result == 'OK') {
		    		specName = result.specVOList;
		    		goodsCode = result.goodsCode;
		    		goodsList = result.goods;
		    	}
		      },
      	  dataType: 'json',
      	  async: false
      });
		
        //上方table
		t.append('<table id="goodAddSpecTableUp" class="table table-hover table-striped table-bordered table-advanced tablesorter">');
		//thead
		t.append('<thead><tr>');
		t.append('<th></th>');
		for(var i=1;i<=specName.length;i++){
			t.append('<th>'+specName[i-1].specName+'<input type="hidden" name="specName" value='+specName[i-1].specName+' /></th>');
		}
		t.append('<th>物料编码</th>');
		t.append('<th>条形码</th>');
		t.append('<th>操作</th>');
		t.append('</tr></thead>');
		
		//tbody
		t.append('<tbody>');
		t.append('<tr>');
		t.append('<td>'+num+'</td>');
		for(var i=1;i<=specName.length;i++){
			t.append('<td><input type="text" class="form-control" name = spec'+i+'></td>');
		}
		t.append('<td><input type="text" class="form-control" name = "goodsCode" value='+goodsCode+'></td>');
		t.append('<td><input type="text" class="form-control" name = "goodsBarCode" ></td>');
		t.append('<td><em class="fa fa-times" onclick="delSpec(this)"></em></td>');
		t.append('</tr>');
		t.append('</tbody>');
		
		t.append('</table>');
		t.append('<button type="button" class="btn btn-primary btn-md" onclick="createSpec();"><em class="fa fa-plus"></em>&nbsp;&nbsp;添加规格</button>');
		t.append('<div style="height:50px;"></div>');

		
		//下方table
		t.append('<table id="goodAddSpecTableDown" class="table table-hover table-striped table-bordered table-advanced tablesorter">');
		//thead
		t.append('<thead><tr>');
		t.append('<th></th>');
		for(var i=1;i<=specName.length;i++){
			t.append('<th>'+specName[i-1].specName+'</th>');
		}
		t.append('<th>物料编码</th>');
		t.append('<th>条形码</th>');
		t.append('</tr></thead>');
		
		//tbody
		t.append('<tbody>');
		
		var nums = 1;
		for(var i=1;i<=goodsList.length;i++){
			t.append('<tr>');
			t.append('<td>'+nums+'</td>');
			/* t.append('<td><label>'+i+'</label></td>');
			t.append('<td><label>'+i+'</label></td>'); */
			for(var j=1;j<=goodsList[i-1].goodSpecValueVO.length;j++){
				t.append('<td><label>'+goodsList[i-1].goodSpecValueVO[j-1].specValueVO.specValue+'</label></td>');
			}
			t.append('<td><label>'+goodsList[i-1].goodsCode+'</label></td>');
			t.append('<td><label>'+goodsList[i-1].goodsBarCode+'</label></td>');
			t.append('</tr>');
			nums++;
		}

		t.append('</tbody>');
		
		t.append('</table>');
		
		modalTable.html(t.toString());
		$("#goodAddSpecModal").modal();
	}
	
	function createSpec(){
		num++;
		var goodAddSpecTableUp = $("#goodAddSpecModal .specTable #goodAddSpecTableUp tbody");
		var t = new StringBuffer();
		
		t.append('<tr>');
		t.append('<td>'+num+'</td>');
		for(var i=1;i<=specName.length;i++){
			t.append('<td><input type="text" class="form-control" name = spec'+i+'></td>');
		}
		t.append('<td><input type="text" class="form-control" name = "goodsCode" value='+getGoodsCode()+'></td>');
		t.append('<td><input type="text" class="form-control" name = "goodsBarCode" ></td>');
		t.append('<td><em class="fa fa-times" onclick="delSpec(this)"></em></td>');
		t.append('</tr>');
		
		goodAddSpecTableUp.append(t.toString());
	}
	
	function delSpec(obj){
		var length = $(obj).parent().parent().parent().find("tr").length;
		if(length<=1){
			toastr['error']("至少保留一种规格！", "");
		}else{
			$(obj).parent().parent().remove();
		}
	}
	
	
	function checkForm(){
		var checkNullObj = checkNull();
		var checkNullObjs = checkNulls();
		if(!checkNullObj.isFlag || !checkNullObjs.isFlag){
			toastr['error']("物料规格值和物料编码都不能为空！", "");
		}else{
			$.ajax({
			    type: 'POST',
			    url: '${contextPath}/manage/checkGoodsSpec',
			    data:$('#creadGoodsBySpec').serialize(),	
			    success: function(result) {
			        if (result.result == 'CAN') {
						$('#creadGoodsBySpec').submit();
			        }else{
			        	toastr['error'](result.msg, "");
			        }
			    },
			    dataType: 'json',
			    async:false
			});
		}
	}
	
	function checkNull(){
		var obj = {};
		var isFlag = true;
		var form = getFormJson("#creadGoodsBySpec");
		for(var i=1;i<=specName.length;i++){
			var temp = eval("form.spec"+i);
			if(temp.length>0){
				for(var j=1;j<=temp.length;j++){
					if(temp[j-1] == null || temp[j-1] == ''){
						isFlag = false;
						break;
					}
				}
			}else{
				if(temp == null || temp == ''){
					isFlag = false;
					break;
				}else{
					isFlag = true;
				}
			}
		}
		obj.isFlag = isFlag;
		return obj;
	}
	
	function checkNulls(){
		var obj = {};
		var isFlag = true;
		var form = getFormJson("#creadGoodsBySpec");
		var temp = form.goodsCode;
		if(num == 1){
			if(temp == null || temp == ''){
				isFlag = false;
			}
		}else{
			for(var i=1;i<=temp.length;i++){
				if(temp[i-1] == null || temp[i-1] == ''){
					isFlag = false;
					break;
				}
			}
		}
		obj.isFlag = isFlag;
		return obj;
	}
		
	function getGoodsCode(){
		var goodsCode = '';
		$.ajax({
		    type: 'POST',
		    url: '${contextPath}/manage/getGoodsCode',
		    success: function(result) {
		        if (result.result == 'OK') {
		            goodsCode = result.goodsCode;
		        }
		    },
		    dataType: 'json',
		    async: false
		});
		return goodsCode;
	}
</script>

<script type="text/javascript">
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
</body>

</html>