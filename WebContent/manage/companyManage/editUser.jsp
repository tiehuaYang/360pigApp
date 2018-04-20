<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
 <!--LOADING STYLESHEET FOR PAGE-->
<link type="text/css" rel="stylesheet" href="${contextPath}/manage/vendors/jquery-tablesorter/themes/blue/style-custom.css"></head>

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
                        <div class="page-title">员工帐号管理</div>
                    </div>
                    <ol class="breadcrumb page-breadcrumb">
                        <li><i class="fa fa-home"></i>&nbsp;<a href="index.jsp">首页</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li><a href="#">扩展</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
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
                                <li class="active"><a href="#table-sticky-tab" data-toggle="tab">帐号信息</a></li>
                            </ul>
                            <div id="tableadvancedTabContent" class="tab-content">
                                <div id="table-sticky-tab" class="tab-pane fade in active">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <form id="userform" action="${contextPath}/manage/saveUser"  method="post"   class="form-horizontal form-seperated">
                                            <input name="userId" type="hidden"  value="${obj.userVO.userId}"/>
	                                            <div class="form-body">
	                                                <div class="form-group">
	                                                    <label for="loginAcount" class="col-md-3 control-label">登录帐号 <span class='require'>*</span>
	                                                    </label>
	                                                    <div class="col-md-4">
	                                                        <input name="loginAcount" type="text" placeholder="登录帐号" class="form-control" value="${obj.userVO.loginAcount}" <c:if test="${obj.userVO.userId != null}">disabled="disabled"</c:if> />
	                                                        <span class="help-block">帐号保存后无法修改</span>
	                                                    </div>
	                                                </div>
	                                                <c:if test="${obj.userVO.userId == null}">
	                                                <div class="form-group">
	                                                    <label for="password" class="col-md-3 control-label">密码 <span class='require'>*</span></label>
	                                                    <div class="col-md-4">
	                                                        <div class="input-icon right"><i class="glyphicon"></i>
	                                                            <input type="password" id="password" name="password" placeholder="密码" class="form-control" />
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                                <div class="form-group">
	                                                    <label for="passwordConfirm" class="col-md-3 control-label">确认密码 <span class='require'>*</span></label>
	                                                    <div class="col-md-4">
	                                                       <div class="input-icon right"><i class="glyphicon"></i>
	                                                            <input type="password" placeholder="请确认密码" name="passwordConfirm" class="form-control">
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                                </c:if>
	                                                <div class="form-group">
	                                                    <label for="userName" class="col-md-3 control-label">姓名<span class='require'>*</span>
	                                                    </label>
	                                                    <div class="col-md-4">
	                                                        <input name="userName" type="text" placeholder="姓名" class="form-control" value="${obj.userVO.userName}"/>
	                                                    </div>
	                                                </div>
	                                                <div class="form-group">
	                                                    <label for="cellPhone" class="col-md-3 control-label">手机</label>
	                                                    <div class="col-md-4">
	                                                     <div class="input-icon right">
	                                                     	<input name="cellPhone" type="text" placeholder="手机" class="form-control" value="${obj.userVO.cellPhone}"/>
	                                                     </div>
	                                                    </div>
	                                                </div>
	                                                <div class="form-group">
	                                                    <label for="email" class="col-md-3 control-label">邮箱 </label>
	                                                    <div class="col-md-4">
	                                                        <div class="input-icon right">
	                                                            <input type="text" placeholder="请输入邮箱" name="email" class="form-control" value="${obj.userVO.email}">
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                                <div class="form-group">
	                                                    <label for="departure" class="col-md-3 control-label">部门</label>
	                                                    <div class="col-md-4">
	                                                     <div class="input-icon right">
	                                                     	<input name="departure" type="text" placeholder="部门" class="form-control" value="${obj.userVO.departure}"/>
	                                                     </div>
	                                                    </div>
	                                                </div>
	                                                <div class="form-group">
	                                                    <label for="post" class="col-md-3 control-label">职位</label>
	                                                    <div class="col-md-4">
	                                                     <div class="input-icon right">
	                                                     	<input name="post" type="text" placeholder="职位" class="form-control"  value="${obj.userVO.post}"/>
	                                                     </div>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                            <div class="form-actions text-right pal">
	                                                <button type="submit" class="btn btn-primary">保存</button>&nbsp;
	                                                <button type="button" class="btn btn-green" onclick="ev_back()">取消</button>
	                                            </div>
                                            </form>
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
    <script src="${contextPath}/manage/vendors/jquery-validate/jquery.validate.min.js"></script>
    
    <script type="text/javascript">
    activeMenu("companyMenu","companyUL","peopleMenu");
    
        
        var result = "${obj.result}";
        var message = "${obj.msg}";
        if(result=='OK'){
        	toastr['success'](message, "");
            setTimeout(function(){
            	window.location.href = "${contextPath}/manage/showUser";
            },600);
        }
        else if(result=='FAIL'){
        	toastr['error'](message, "");
        }
        
        function ev_back(){
        	window.history.back();
        }
        
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
        

</script>
</body>

</html>