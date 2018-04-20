<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.pig.common.CommonConstants"%>
<%@page import="com.pig.authority.vo.UserVO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<%
   UserVO user = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
%>
<!DOCTYPE html>
<html>
<%@include file="include/header.jsp"%>
<style>
	.circle-box{width: 120px;height: 120px;margin: 0 auto;border-radius: 50%;border: 1px solid #ccc;overflow: hidden; padding: 5px;border: 5px solid #fff; box-shadow: 0 2px 3px rgba(0, 0, 0, 0.25); position: relative;}
	.my-img-circle{height: 110px;min-width: 120px;position: absolute;top: 0;left: -40%;}
	.header-picture{width: 120px;height: 120px;border-radius: 50%;margin: -10px 0 0 -10px;background:url(${contextPath}/images/default_user.jpg) center center;background-size:120px;}
	.header-picture.up{background:url(${QUPLOADIMG}${sessionScope.USERVO.companyProfile.pictureVO.uploadUrl}) center center;background-size:cover;}
</style>
</head>

<body class = "${theme }" >
	<div>
		<!--BEGIN BACK TO TOP-->
		<a id="totop" href="#"><i class="fa fa-angle-up"></i></a>
		<!--END BACK TO TOP-->
		<!--BEGIN TOPBAR-->
		<%@ include file="include/banner.jsp"%>
		<!--END TOPBAR-->
		<div id="wrapper">
			<!--BEGIN SIDEBAR MENU-->
			<%@ include file="include/menu.jsp"%>
			<!--END SIDEBAR MENU-->
			<!--BEGIN PAGE WRAPPER-->
			<div id="page-wrapper">
				<!--BEGIN TITLE & BREADCRUMB PAGE-->
				<div id="title-breadcrumb-option-demo" class="page-title-breadcrumb">
					<ol class="breadcrumb page-breadcrumb pull-left">
						<li><i class="fa fa-home"></i>&nbsp;<a href="index.jsp">首页</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li><a href="#">扩展</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">资料信息</li>
					</ol>
					<div class="clearfix"></div>
				</div>
				<!--END TITLE & BREADCRUMB PAGE-->
				<!--BEGIN CONTENT-->
				<div class="page-content">
					<div id="page-user-profile" class="row">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-3">
									<div class="form-group">
										<div class="circle-box mbl">
											<c:choose>
												<c:when
													test="${!empty sessionScope.USERVO.companyProfile.pictureVO.uploadUrl}">
													<%-- <img
														src="${contextPath}${sessionScope.USERVO.companyProfile.pictureVO.uploadUrl}"
														class="my-img-circle" /> --%>
													<div class="header-picture up"></div>
												</c:when>
												<c:otherwise>
													<%-- <img src="${contextPath}/images/default_user.jpg" class="my-img-circle" /> --%>
													<div class="header-picture"></div>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									<table class="table table-striped table-hover">
										<tbody>
											<tr>
												<td width="30%">企业名称</td>
												<td>${sessionScope.USERVO.companyProfile.companyName}</td>
											</tr>
											<tr>
												<td width="30%">企业邮箱</td>
												<td>${sessionScope.USERVO.companyProfile.contactEmail}</td>
											</tr>
											<tr>
												<td width="30%">地址</td>
												<td>${sessionScope.USERVO.companyProfile.province}省${sessionScope.USERVO.companyProfile.city}市${sessionScope.USERVO.companyProfile.address}</td>
											</tr>
<%-- 											<tr>
												<td width="30%">帐号类别</td>
												<td><c:choose>
														<c:when
															test="${sessionScope.USERVO.companyProfile.userType == 'SALES'}">
	                                                 		 经销商帐号
	                                                 	</c:when>
														<c:when
															test="${sessionScope.USERVO.companyProfile.userType == 'SUPPLY'}">
	                                                 		供应商帐号
	                                                 	</c:when>
													</c:choose></td>
											</tr> --%>
											<tr>
												<td width="30%">状态</td>
												<td><c:choose>
														<c:when test="${sessionScope.USERVO.isvalid == 'Y'}">
															<span class="label label-success">正常</span>
														</c:when>
														<c:when test="${sessionScope.USERVO.isvalid == 'N'}">
															<span class="label label-danger">冻结</span>
														</c:when>
													</c:choose></td>
											</tr>
											<tr>
												<td width="30%">入职时间</td>
												<td>${sessionScope.USERVO.employDateStr}</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="col-md-9">
									<ul class="nav nav-tabs ul-edit responsive">
										<li class="active"><a href="#tab-edit" data-toggle="tab"><i
												class="fa fa-edit"></i>&nbsp;编辑资料</a></li>
										<!-- 
                                        <li><a href="#tab-messages" data-toggle="tab"><i class="fa fa-envelope-o"></i>&nbsp;站内信</a></li>
                                         -->
									</ul>
									<div id="generalTabContent" class="tab-content">
										<!--BEGIN EDIT PROFIIE-->
										<div id="tab-edit" class="tab-pane fade in active">
											<div class="row">
												<div class="col-md-9">
													<div class="tab-content">
														<div id="tab-profile-setting"
															class="tab-pane fade in active">
															<form id="profileForm"
																action="${contextPath}/manage/changeProfile"
																class="form-horizontal" method="post"
																enctype="multipart/form-data">
																<input type="hidden" name="companyId"
																	value="${sessionScope.USERVO.companyProfile.companyId}" />
																<input type="hidden" name="userType"
																	value="${sessionScope.USERVO.companyProfile.userType}" />
																<input type="hidden" name="companyCode"
																	value="${sessionScope.USERVO.companyProfile.companyCode}" />
																<div class="form-group">
																	<label class="col-sm-3 control-label">企业名称</label>
																	<div class="col-sm-9 controls">
																		<div class="row">
																			<div class="col-xs-9">
																				<input type="text" name="companyName"
																					placeholder="请输入用户名称" class="form-control"
																					value="${sessionScope.USERVO.companyProfile.companyName}" />
																			</div>
																		</div>
																	</div>
																</div>
																<div class="form-group">
																	<label class="col-sm-3 control-label">企业头像</label>
																	<div class="col-sm-9 controls">
																		<c:if
																			test="${!empty sessionScope.USERVO.companyProfile.pictureVO}">
																			<img
																				src="${QUPLOADIMG}${sessionScope.USERVO.companyProfile.pictureVO.uploadUrl}"
																				style="width: 80px !important;" />
																		</c:if>
																		<input name="file" type="file" class="btn btn-default"
																			style="display: inline" />
																		<p class="help-block">
																			<span class="label label-info">Tips:</span>若需要更换Logo直接上传新照片保存即可
																		</p>
																	</div>
																</div>
																<div class="form-group">
																	<label class="col-sm-3 control-label">企业地址</label>
																	<div id="city_1" style="margin-bottom: 15px"
																		class="row">
																		<div class="col-xs-3">
																			<label style="display: block" class="select">
																				<select name="province" class="form-control prov"></select>
																			</label>
																		</div>
																		<div class="col-xs-3">
																			<label style="display: block" class="select">
																				<select name="city" class="form-control city"
																				disabled="disabled"></select>
																			</label>
																		</div>
																	</div>
																	<div class="form-group">
																		<label class="col-sm-3 control-label"></label>
																		<div class="col-sm-7 controls">
																			<input type="text" name="address" placeholder="请输入地址"
																				class="form-control" style="margin-left: 7px;"
																				value="${sessionScope.USERVO.companyProfile.address}" />
																		</div>
																	</div>
																</div>
																<div class="form-group">
																	<label class="col-sm-3 control-label">电话</label>
																	<div class="col-sm-9 controls">
																		<div class="row">
																			<div class="col-xs-9">
																				<input type="text" name="phone"
																					placeholder="请输入企业电话" class="form-control"
																					value="${sessionScope.USERVO.companyProfile.phone}" />
																			</div>
																		</div>
																	</div>
																</div>
																<div class="form-group">
																	<label class="col-sm-3 control-label">企业传真</label>
																	<div class="col-sm-9 controls">
																		<div class="row">
																			<div class="col-xs-9">
																				<input type="text" name="tax" placeholder="请输入企业传真"
																					class="form-control"
																					value="${sessionScope.USERVO.companyProfile.tax}" />
																			</div>
																		</div>
																	</div>
																</div>
																<div class="form-group">
																	<label class="col-sm-3 control-label">邮编</label>
																	<div class="col-sm-9 controls">
																		<div class="row">
																			<div class="col-xs-9">
																				<input type="text" name="zipCode"
																					placeholder="请输入邮编" class="form-control"
																					value="${sessionScope.USERVO.companyProfile.zipCode}" />
																			</div>
																		</div>
																	</div>
																</div>
																<div class="form-group">
																	<label class="col-sm-3 control-label">联系人</label>
																	<div class="col-sm-9 controls">
																		<div class="row">
																			<div class="col-xs-9">
																				<input type="text" name="contactName"
																					placeholder="请输入联系人名称" class="form-control"
																					value="${sessionScope.USERVO.companyProfile.contactName}" />
																			</div>
																		</div>
																	</div>
																</div>
																<div class="form-group">
																	<label class="col-sm-3 control-label">联系人邮箱</label>
																	<div class="col-sm-9 controls">
																		<div class="row">
																			<div class="col-xs-9">
																				<input type="text" name="contactEmail"
																					placeholder="请输入联系人邮箱" class="form-control"
																					value="${sessionScope.USERVO.companyProfile.contactEmail}" />
																			</div>
																		</div>
																	</div>
																</div>
																<div class="form-group">
																	<label class="col-sm-3 control-label">联系人电话</label>
																	<div class="col-sm-9 controls">
																		<div class="row">
																			<div class="col-xs-9">
																				<input type="text" name="contactPhone"
																					placeholder="请输入联系人电话" class="form-control"
																					value="${sessionScope.USERVO.companyProfile.contactPhone}" />
																			</div>
																		</div>
																	</div>
																</div>

																<div class="form-group">
																	<label class="col-sm-3 control-label">联系人职位</label>
																	<div class="col-sm-9 controls">
																		<div class="row">
																			<div class="col-xs-9">
																				<input type="text" name="contactPost"
																					placeholder="请输入联系人职位" class="form-control"
																					value="${sessionScope.USERVO.companyProfile.contactPost}" />
																			</div>
																		</div>
																	</div>
																</div>
																<div class="form-group">
																	<label class="col-sm-3 control-label">联系人QQ</label>
																	<div class="col-sm-9 controls">
																		<div class="row">
																			<div class="col-xs-9">
																				<input type="text" name="contactQQ"
																					placeholder="请输入联系方式" class="form-control"
																					value="${sessionScope.USERVO.companyProfile.contactQQ}" />
																			</div>
																		</div>
																	</div>
																</div>
																<div class="form-group">
																	<label class="col-sm-3 control-label">企业主页</label>
																	<div class="col-sm-9 controls">
																		<div class="row">
																			<div class="col-xs-9">
																				<input type="text" name="mainPage"
																					placeholder="请输入企业主页" class="form-control"
																					value="${sessionScope.USERVO.companyProfile.mainPage}" />
																			</div>
																		</div>
																	</div>
																</div>
																<div class="form-group">
																	<label class="col-sm-3 control-label">企业介绍</label>
																	<div class="col-sm-9 controls">
																		<textarea rows="10" cols="50" name="remark">${sessionScope.USERVO.companyProfile.remark}</textarea>
																	</div>
																</div>
																<div class="form-group mbn">
																	<label class="col-sm-3 control-label"></label>
																	<div class="col-sm-9 controls">
																		<button type="submit" class="btn btn-success">
																			<i class="fa fa-save"></i>&nbsp; 保存
																		</button>
																		&nbsp; &nbsp;<a href="#" class="btn btn-default">取消</a>
																	</div>
																</div>
															</form>
														</div>
														<div id="tab-account-setting" class="tab-pane fade">
															<form id="accountForm"
																action="${contextPath}/manage/changeUserInfo"
																class="form-horizontal" method="post">
																<div class="form-body">
																	<div class="form-group">
																		<label class="col-sm-3 control-label">姓名<font
																			class="text-red">*</font></label>
																		<div class="col-sm-9 controls">
																			<div class="row">
																				<div class="col-xs-9">
																					<input type="text" class="form-control"
																						name="userName" placeholder="请输入您的姓名"
																						value="${sessionScope.USERVO.userName}" />
																				</div>
																			</div>
																		</div>
																	</div>
																	<div class="form-group">
																		<label class="col-sm-3 control-label">手机<font
																			class="text-red">*</font></label>
																		<div class="col-sm-9 controls">
																			<div class="row">
																				<div class="col-xs-9">
																					<input type="text" class="form-control"
																						name="cellPhone" placeholder="请输入手机"
																						value="${sessionScope.USERVO.cellPhone}" />
																				</div>
																			</div>
																		</div>
																	</div>
																	<div class="form-group">
																		<label class="col-sm-3 control-label">邮箱</label>
																		<div class="col-sm-9 controls">
																			<div class="row">
																				<div class="col-xs-9">
																					<input type="text" class="form-control"
																						placeholder="请输入邮箱" name="email"
																						value="${sessionScope.USERVO.email}" />
																				</div>
																			</div>
																		</div>
																	</div>
																	<div class="form-group">
																		<label class="col-sm-3 control-label">部门</label>
																		<div class="col-sm-9 controls">
																			<div class="row">
																				<div class="col-xs-9">
																					<input type="text" name="departure"
																						placeholder="请输入部门"
																						value="${sessionScope.USERVO.departure}"
																						class="form-control" />
																				</div>
																			</div>
																		</div>
																	</div>
																	<div class="form-group">
																		<label class="col-sm-3 control-label">职位</label>
																		<div class="col-sm-9 controls">
																			<div class="row">
																				<div class="col-xs-9">
																					<input type="text" name="post" placeholder="请输入职位"
																						value="${sessionScope.USERVO.post}"
																						class="form-control" />
																				</div>
																			</div>
																		</div>
																	</div>
																	<div class="form-group mbn">
																		<label class="col-sm-3 control-label"></label>
																		<div class="col-sm-9 controls">
																			<button type="submit" class="btn btn-success">
																				<i class="fa fa-save"></i>&nbsp; 保存
																			</button>
																			&nbsp; &nbsp;<a href="#" class="btn btn-default">取消</a>
																		</div>
																	</div>
																</div>
															</form>
														</div>
														<div id="tab-password-setting" class="tab-pane fade">
															<form id="pswForm" action="#" class="form-horizontal">
																<div class="form-body">
																	<div class="form-group">
																		<label class="col-sm-3 control-label">登录帐号</label>
																		<div class="col-sm-9 controls">
																			<div class="row">
																				<div class="col-xs-9">
																					<input type="text" class="form-control"
																						value="${sessionScope.USERVO.loginAcount}"
																						disabled="disabled" />
																				</div>
																			</div>
																		</div>
																	</div>
																	<div class="form-group">
																		<label class="col-sm-3 control-label">旧密码</label>
																		<div class="col-sm-9 controls">
																			<div class="row">
																				<div class="col-xs-9">
																					<input type="password" id="oldpasswd"
																						name="oldpasswd" placeholder=""
																						class="form-control" />
																				</div>
																			</div>
																		</div>
																	</div>
																	<div class="form-group">
																		<label class="col-sm-3 control-label">新密码</label>
																		<div class="col-sm-9 controls">
																			<div class="row">
																				<div class="col-xs-9">
																					<input type="password" id="newpasswd"
																						name="newpasswd" placeholder=""
																						class="form-control" />
																				</div>
																			</div>
																		</div>
																	</div>
																	<div class="form-group">
																		<label class="col-sm-3 control-label">再次确认新密码</label>
																		<div class="col-sm-9 controls">
																			<div class="row">
																				<div class="col-xs-9">
																					<input type="password" id="newpasswd2"
																						name="newpasswd2" placeholder=""
																						class="form-control" />
																				</div>
																			</div>
																		</div>
																	</div>
																	<div class="form-group mbn">
																		<label class="col-sm-3 control-label"></label>
																		<div class="col-sm-9 controls">
																			<button type="button" class="btn btn-success"
																				onclick="changePasswd()">
																				<i class="fa fa-save"></i>&nbsp; 保存
																			</button>
																			&nbsp; &nbsp;<a href="#" class="btn btn-default">取消</a>
																		</div>
																	</div>
																</div>
															</form>
														</div>
													</div>
												</div>
												<div class="col-md-3">
													<ul class="nav nav-pills nav-stacked">
														<li class="active"><a href="#tab-profile-setting"
															data-toggle="tab"><i class="fa fa-folder-open"></i>&nbsp;企业资料</a></li>
														<li><a href="#tab-account-setting" data-toggle="tab"><i
																class="fa fa-file-text-o"></i>&nbsp;个人资料</a></li>
														<li><a href="#tab-password-setting" data-toggle="tab"><i
																class="fa fa-cogs"></i>&nbsp;修改密码</a></li>
													</ul>
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
			<%@ include file="include/footer.jsp"%>
			<!--END FOOTER-->


			<!--LOADING SCRIPTS FOR PAGE-->
			<script
				src="${contextPath}/manage/vendors/jquery-validate/jquery.validate.min.js"></script>
			<script
				src="${contextPath}/manage/js/citySelect/jquery.cityselect.js"></script>

			<script type="text/javascript">
      var prov = '${sessionScope.USERVO.companyProfile.province}';
      var city = '${sessionScope.USERVO.companyProfile.city}';
        $("#city_1").citySelect({
        	prov:prov, city:city});

        
        var message = "${obj.msg}";
        if(message=='保存成功'){
        	toastr['success'](message, "");
        }
        else if(message != null && message.length > 0){
        	toastr['error'](message, "");
        }
        
	function changePasswd() {
		var oldpasswd = $("#oldpasswd").val();
		var newpasswd = $("#newpasswd").val();
		var newpasswd2 = $("#newpasswd2").val();
		if(newpasswd != newpasswd2){
			$("#passwdconfirmspan").show();
			$("#passwdconfirmspan").addClass("warning");
		}else{
			jQuery.post("${contextPath}/manage/changePasswd",{"oldpasswd":oldpasswd,"newpasswd":newpasswd,"newpasswd2":newpasswd2}, function(data) {
				if("OK"==data){
					alert("修改成功！");
				}else{
					alert("操作失败，请检查你的输入是否正确。");
				}
			});
		}
	}
	

	$(function()
	{
		
		activeMenu("enterpriseManage","enterpriseUL","enterpriseMenu");
		
	    // Validation
	    $("#profileForm").validate(
	        {
	            // Rules for form validation
	            rules:
	            {
	            	userName:
	                {
	                    required: true,
	                    maxlength: 60
	                },
	                email:
	                {
	                    required: true,
	                    email: true
	                }
	            },

	            // Messages for form validation
	            messages:
	            {
	                userName:
	                {
	                	required: '用户名称不能为空',
	                	maxlength: '长度不能超过50个字符'
	                },
	                email:
	                {
	                    required: '企业邮箱不可为空',
	                    email: '请输入有效的邮箱地址'
	                }
	            },

	            // Do not change code below
	            errorPlacement: function(error, element)
	            {
	                error.insertAfter(element.parent());
	            }
	        });
	    
	    
	    $("#pswForm").validate(
		        {
		            // Rules for form validation
		            rules:
		            {
		                oldpasswd:
		                {
		                    required: true,
		                    maxlength: 20
		                },
		                newpasswd:
		                {
		                    required: true,
		                    minlength: 6,
		                    maxlength: 20,
		                },
		                newpasswd2:
		                {
		                    required: true,
		                    equalTo: '#newpasswd'
		                }
		            },

		            // Messages for form validation
		            messages:
		            {
		                oldpasswd:
		                {
		                    required: '请输入旧密码',
		                    maxlength:'密码长度不超过20'
		                },
		                newpasswd:
		                {
		                    required: '请输入旧密码',
		                    minlength:'请输入最少6位数的密码',
		                    maxlength:'密码长度不超过20'
		                },
		                newpasswd2:
		                {
		                    required: '请再一次确认您的密码',
		                    equalTo: '和新密码不符，请再次确认密码'
		                }
		            },

		            // Do not change code below
		            errorPlacement: function(error, element)
		            {
		                error.insertAfter(element.parent());
		            }
		        });
	});
			
	

</script>
</body>

</html>