<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>

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
						<li><i class="fa fa-home"></i>&nbsp;<a href="index.jsp">首页</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li><a href="#">物料管理</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">物料信息编辑</li>
					</ol>

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
											<form id="fileupload"
												action="${contextPath}/manage/saveMaterial"
												class="form-horizontal" method="POST">
												<div class="panel-body pan">
													<input name="materialId" type="hidden" class="form-control"
														value="${obj.materialVO.materialId}" />
													<div class="form-body pal">
														<h3>基本信息</h3>
														<hr />
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label for="物料编号" class="col-md-3 control-label">物料编号
																		<span class='require'>*</span>
																	</label>
																	<div class="col-md-9">
																		<input name="materialCode" type="text" placeholder=""
																			class="form-control"
																			value="${obj.materialVO.materialCode}" />
																	</div>
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label for="物料名称" class="col-md-3 control-label">物料名称
																		<span class='require'>*</span>
																	</label>
																	<div class="col-md-9">
																		<input name="materialName" type="text" placeholder=""
																			class="form-control"
																			value="${obj.materialVO.materialName}" />
																	</div>
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label for="unit" class="col-md-3 control-label">计量单位<span
																		class='require'>*</span>
																	</label>
																	<div class="col-md-9">
																		<input name="unit" type="text" placeholder=""
																			class="form-control" value="${obj.materialVO.unit}" />
																	</div>
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label for="materialSource"
																		class="col-md-3 control-label">物料来源 </label>
																	<div class="col-md-9">
																		<input name="materialSource" type="text"
																			class="form-control"
																			value="${obj.materialVO.materialSource}" />
																	</div>
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label for="remark" class="col-md-3 control-label">备注
																	</label>
																	<div class="col-md-9">
																		<input name="remark" type="text" placeholder=""
																			class="form-control" value="${obj.materialVO.remark}" />
																	</div>
																</div>
															</div>
														</div>
														<h3>物料介绍</h3>
														<hr />
														<div class="row">
															<div class="col-md-11">
																<textarea rows="15" cols="138" id="materialInfo" placeholder="最大支持150个字符"
																	name="materialInfo">${obj.materialVO.materialInfo}</textarea>
																<%-- <textarea class="ckeditor" cols="100" id="goodsInfo" name="goodsInfo" rows="15">${obj.goodVO.goodsInfo}</textarea> --%>
															</div>
														</div>
														<br />
													</div>
												</div>
												<div class="form-actions text-right pal pull-left">
													<button id="submitBtn" type="submit"
														class="btn btn-primary start">保存</button>
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
				<!--END CONTENT-->
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

			<!--用于分页-->
			<script src="${contextPath}/manage/js/page/bootstrap-paginator.js"></script>
			<script src="${contextPath}/manage/js/page/jquery.pagination.js"></script>
			<script type="text/javascript">
    //菜单初始化
  activeMenu("materialManage","materialUL","materialMenu");
    
   
    
  
    
    var result = "${obj.result}";
    var message = "${obj.msg}";
    if(result=='OK'){
    	toastr['success'](message, "");
        setTimeout(function(){
        	window.location.href = "${contextPath}/manage/showMaterial";
        },600);
    }
    else if(result=='FAIL'){
    	toastr['error'](message, "");
    }
        
   function ev_back(){
   	window.history.back();
   }
   
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
			search();
	   }
        
        $(function()
        		{
        		    // Validation
        		    $("#fileupload").validate(
        		        {
        		            // Rules for form validation
        		            rules:
        		            {
        		            	materialCode:
        		                {
        		                    required: true
        		                },
        		                materialName:
        		                {
        		                    required: true,
        		                },
        		                unit:
        		                {
        		                    required: true,
        		                },
        		                materialInfo:
        		                {
        		                	maxlength: 150
        		                }
        		            },

        		            // Messages for form validation
        		            messages:
        		            {
        		            	materialCode:
        		                {
        		                    required: '物料编号不能为空'
        		                },
        		                materialName:
        		                {
        		                	required: '物料名称不能为空'
        		                },
        		                unit:
        		                {
        		                	required: '计量单位不能为空',
        		                },
        		                materialInfo:
        		                {
        		                	maxlength: '物料介绍输入长度最多是150的字符'
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
        
    

</script>
</body>

</html>