<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.pig.authority.vo.UserVO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<c:set var="userType"
	value="<%= CommonConstants.USER.USER_TYPE_BUSINESS %>"></c:set>
<%
   UserVO user = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
%>
<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
<!--LOADING STYLESHEET FOR PAGE-->
<link type="text/css" rel="stylesheet"
	href="${contextPath}/manage/vendors/jquery-tablesorter/themes/blue/style-custom.css">
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
						<li><i class="fa fa-home"></i>&nbsp;<a href="index.jsp">首页</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li><a href="#">扩展</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">个人资料</li>
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
									data-toggle="tab">帐号信息</a></li>
							</ul>
							<div id="tableadvancedTabContent" class="tab-content">
								<div id="table-sticky-tab" class="tab-pane fade in active">
									<div class="row">
										<div class="col-lg-12">
											<form id="userform" action="${contextPath}/manage/saveStuff"
												class="form-horizontal" method="POST">
												<div class="panel-body pan">
													<input id="userId" name="userId" type="hidden"
														value="${obj.userVO.userId}" />
													<div class="form-body pal">
														<h3>基本信息</h3>
														<hr />
														<div class="wrapper3" style="-moz-column-count:2;-webkit-column-count:2;column-count:2;margin-bottom:20px;
														-moz-column-gap:20px;-webkit-column-count:10px;column-count:20px;">
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label for="loginAcount" class="col-md-3 control-label">登录帐号
																		<span class='require'>*</span>
																	</label>
																	<div class="col-md-9">
																		<input name="loginAcount" type="text"
																			placeholder="登录帐号" class="form-control"
																			value="${obj.userVO.loginAcount}"
																			<c:if test="${obj.isNew != 'Y'}">disabled="disabled"</c:if> />
																		<span class="help-block">帐号保存后无法修改</span>
																	</div>
																</div>
															</div>
														</div>
														<c:if test="${obj.isNew == 'Y'}">
															<div class="row">
																<div class="col-md-6">
																	<div class="form-group">
																		<label for="password" class="col-md-3 control-label">密码
																			<span class='require'>*</span>
																		</label>
																		<div class="col-md-9">
																			<div class="input-icon right">
																				<i class="glyphicon"></i> <input type="password"
																					id="password" name="password" placeholder="密码"
																					class="form-control" />
																			</div>
																		</div>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-6">
																	<div class="form-group">
																		<label for="passwordConfirm"
																			class="col-md-3 control-label">确认密码 <span
																			class='require'>*</span></label>
																		<div class="col-md-9">
																			<div class="input-icon right">
																				<i class="glyphicon"></i> <input type="password"
																					placeholder="请确认密码" name="passwordConfirm"
																					class="form-control">
																			</div>
																		</div>
																	</div>
																</div>
															</div>
														</c:if>
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label for="userName" class="col-md-3 control-label">姓名<span
																		class='require'>*</span></label>
																	<div class="col-md-9">
																	    <div class="input-icon right">
																			<input name="userName" type="text" placeholder="姓名"
																				class="form-control" value="${obj.userVO.userName}" />
																	    </div>
																	</div>
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label for="cellPhone" class="col-md-3 control-label">手机</label>
																	<div class="col-md-9">
																		<div class="input-icon right">
																			<input name="cellPhone" type="text" placeholder="手机"
																				class="form-control" value="${obj.userVO.cellPhone}" />
																		</div>
																	</div>
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label for="email" class="col-md-3 control-label">邮箱
																	</label>
																	<div class="col-md-9">
																		<div class="input-icon right">
																			<input type="text" placeholder="请输入邮箱" name="email"
																				class="form-control" value="${obj.userVO.email}">
																		</div>
																	</div>
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label for="departure" class="col-md-3 control-label">部门</label>
																	<div class="col-md-9">
																		<div class="input-icon right">
																			<input name="departure" type="text" placeholder="部门"
																				class="form-control" value="${obj.userVO.departure}" />
																		</div>
																	</div>
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label for="post" class="col-md-3 control-label">职位</label>
																	<div class="col-md-9">
																		<div class="input-icon right">
																			<input name="post" type="text" placeholder="职位"
																				class="form-control" value="${obj.userVO.post}" />
																		</div>
																	</div>
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label for="post" class="col-md-3 control-label">入职日期</label>
																	<div class="col-md-9">
																		<div class="input-icon right">
																			<input id="employDate" readonly="readonly" name="employDate" type="text"
																				placeholder="入职日期" class="form-control"
																				value="${obj.userVO.employDateStr}" />
																		</div>
																	</div>
																</div>
															</div>
														</div>
														</div>

														<h3>角色权限</h3>
														<table class="table table-hover">
															<tbody>
																<tr>
																	<td width="15%"
																		style="text-align: center; vertical-align: middle">
																		<div>
																			<strong class="text-blue">帐号角色</strong>
																		</div>
																	</td>
																	<td width="80%"><c:forEach var="role"
																			items="${obj.roleList}" varStatus="status">
																			<div
																				style="display: inline-block; float: left; width: 150px">
																				<input type="checkbox" onclick="modifyRole()"
																					name="roleId"
																					<c:if test="${role.isCheck == 'Y'}">checked</c:if>
																					value="${role.id}"><label for="" style="margin-top:8px;margin-left:2px;">${role.alias}</label>
																			</div>
																		</c:forEach></td>
																	<td></td>
																</tr>
															</tbody>
														</table>

														<h3>权限明细</h3>
														<table class="table table-hover">
															<tbody>
																<c:forEach var="permissionModule" items="${obj.pmList}"
																	varStatus="status">
																	<tr>
																		<td width="15%"
																			style="text-align: center; vertical-align: middle;">
																			<div>
																				<strong class="text-blue">${permissionModule.moduleName}</strong>
																			</div>
																		</td>
																		<td width="80%"><c:forEach var="permission"
																				items="${permissionModule.permissionList}"
																				varStatus="status">
																				<div
																					style="display: inline-block; float: left; width: 150px">
																					<input id="${permission.permissionId}"
																						type="checkbox" class="permission"
																						onclick="modifyPermission(this,'${permission.permissionId}')"
																						disabled="disabled"
																						<c:if test="${permission.isCheck == 'Y'}">checked</c:if>><label
																						for="" style="margin-top:8px;margin-left:2px;">${permission.name}</label>
																				</div>
																			</c:forEach></td>
																		<td></td>
																	</tr>
																</c:forEach>
															</tbody>
														</table>

													</div>
												</div>
												<div class="form-actions text-right pal" style="background:#FFF;">
													<button type="submit" class="btn btn-primary">保存</button>
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
		</div>
		<!--BEGIN FOOTER-->
		<%@ include file="../include/footer.jsp"%>
		<!--END FOOTER-->
		<!--END PAGE WRAPPER-->

		<!--LOADING SCRIPTS FOR PAGE-->
		<script
			src="${contextPath}/manage/vendors/jquery-tablesorter/jquery.tablesorter.js"></script>
		<script
			src="${contextPath}/manage/vendors/jquery-validate/jquery.validate.min.js"></script>
<script src="${contextPath}/js/citySelect/jquery.cityselect.js"></script>

		<!--日历控件-->
		<script type="text/javascript"
			src="${contextPath}/js/calendarJs/jedate.js"></script>

		<script type="text/javascript">
    activeMenu("companyMenu","companyUL","peopleMenu");
    
        
        var result = "${obj.result}";
        var message = "${obj.msg}";
        if(result=='OK'){
        	toastr['success'](message, "");
            setTimeout(function(){
            	window.location.href = "${contextPath}/manage/showStuff";
            },600);
        }
        else if(result=='FAIL'){
        	toastr['error'](message, "");
        }
        
        function ev_back(){
        	window.history.back();
        }
        
        jeDate({
    		dateCell:"#employDate",
    		format:"YYYY-MM-DD",
    		isinitVal:false,
    		isTime:true, //isClear:false,
    		//minDate:"2014-09-19 00:00:00",
    		okfun:function(val){
    				//alert(val);
    		}
        })
        
        $(function()
        		{
        		    // Validation
        		    $("#userform").validate(
        		        {
        		            // Rules for form validation
        		            rules:
        		            {
        		            	password:
        		                {
        		                    required: true,
        		                    minlength: 3,
        		                    maxlength: 20
        		                },
        		                passwordConfirm:
        		                {
        		                	required: true,
        		                    minlength: 3,
        		                    maxlength: 20,
        		                    equalTo: '#password'
        		                },
        		                userName:
        		                {
        		                    required: true,
        		                    maxlength: 20
        		                }
        		            },

        		            // Messages for form validation
        		            messages:
        		            {
        		            	password:
        		                {
        		                    required: '请输入密码'
        		                },
        		                passwordConfirm:
        		                {
        		                    required: '请再一次确认您的密码',
        		                    equalTo: '和上一次密码不符，请再次确认密码'
        		                },
        		                userName:
        		                {
        		                	required: '用户姓名不能为空',
        		                	maxlength: '长度不能超过20个字符'
        		                }
        		            },

        		            // Do not change code below
        		            errorPlacement: function(error, element)
        		            {
        		                error.insertAfter(element.parent());
        		            }
        		        });
        		});
        
        
        function modifyRole(){
        	var roleId = new Array();
        	$("input:checkbox[name='roleId']:checked").each(function(index,element){
        		roleId.push($(element).val());
        	}); 
        	var roleIds = JSON.stringify(roleId); 
           	  var url = "${contextPath}/manage/modifyRole?roleIds="+roleIds;
           	    common_ajax(url,function(data){
           	    	if(data.result=='FAIL'){
           	    		toastr['error'](data.msg, "");
           	    	}
           	    	else if(data.result=='OK'){
           	    		$(".permission").attr('checked',false); 
           	    		var pidList =eval(data.pidList);
           	    		$(pidList).each(function(index) {
           	             		$("#"+pidList[index]).attr('checked',true); 
           	    		 });
           	    	}
       		  });
           }

</script>
</body>

</html>