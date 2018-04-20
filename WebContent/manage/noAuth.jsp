<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<%@include file="include/header.jsp"%>

<body id="error-page" class="animated bounceInLeft  ${theme }">
	<div id="error-page-content">
		<h1>401!</h1>
		<h4>您并没有操作这个功能的权限!</h4>
		<p>请联系贵司平台管理员，并申请开放相应的权限.</p>
		<p>若仍然无法解决这个问题，请联系我们的客服：020 - 38888888</p>
		<br>
		<br>
		<p>
			<a href='${contextPath}/manage/showIndex'><strong>返回主页</strong></a>
			并尝试操作其他功能
		</p>
	</div>
	<script src="js/jquery-1.9.1.js"></script>
	<script src="js/jquery-migrate-1.2.1.min.js"></script>
	<script src="js/jquery-ui.js"></script>
	<!--loading bootstrap js-->
	<script src="vendors/bootstrap/js/bootstrap.min.js"></script>
	<script src="vendors/bootstrap-hover-dropdown.js"></script>
	<script src="js/html5shiv.js"></script>
	<script src="js/respond.min.js"></script>
</body>

</html>

