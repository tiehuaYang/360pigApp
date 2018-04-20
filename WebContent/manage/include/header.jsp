<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<%@page import="com.pig.common.CommonConstants"%>
<c:set var="theme" value="<%=CommonConstants.THEME%>"></c:set>
<c:set var="QUPLOADIMG" value="<%=CommonConstants.QUPLOADIMG%>"></c:set>
<c:set var="QIMGS" value="<%=CommonConstants.QIMGS%>"></c:set>
<c:set var="QQRCODE" value="<%=CommonConstants.QQRCODE%>"></c:set>
<c:set var="QOQRCODE" value="<%=CommonConstants.QOQRCODE%>"></c:set>
<script type="text/javascript">
    var selfTheme = "${theme}";
</script>
<!DOCTYPE html>
<html>
<head>
    <title>农牧快车管理系统</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="keywords" content="mutoon,牧通,牧通信息科技">
    <meta name="author" content="广州牧通信息科技有限公司">
	<meta name="Copyright" content="广州牧通信息科技有限公司版权所有" />
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="Thu, 19 Nov 1900 08:52:00 GMT">
    <link rel="shortcut icon" href="${contextPath}/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${contextPath}/favicon.ico" type="image/x-icon">
    
    
    <link rel="apple-touch-icon" href="${contextPath}/manage/images/icons/favicon.png">
    <link rel="apple-touch-icon" sizes="72x72" href="${contextPath}/manage/images/icons/favicon-72x72.png">
    <link rel="apple-touch-icon" sizes="114x114" href="${contextPath}/manage/images/icons/favicon-114x114.png">
    <!--Loading bootstrap css-->
    
     <link type="text/css" rel="stylesheet" href="${contextPath}/css/index.css">
    <link type="text/css" rel="stylesheet" href="${contextPath}/manage/vendors/jquery-ui-1.10.4.custom/css/ui-lightness/jquery-ui-1.10.4.custom.min.css">
    <link type="text/css" rel="stylesheet" href="${contextPath}/manage/vendors/font-awesome/css/font-awesome.min.css">
    <link type="text/css" rel="stylesheet" href="${contextPath}/manage/vendors/bootstrap/css/bootstrap.min.css">
    
    <!--Loading style vendors-->
    <link type="text/css" rel="stylesheet" href="${contextPath}/manage/vendors/animate.css/animate.css">
    <link type="text/css" rel="stylesheet" href="${contextPath}/manage/vendors/jquery-pace/pace.css">
    <link type="text/css" rel="stylesheet" href="${contextPath}/manage/vendors/iCheck/skins/all.css">
    <link type="text/css" rel="stylesheet" href="${contextPath}/manage/vendors/jquery-notific8/jquery.notific8.min.css">
    <link type="text/css" rel="stylesheet" href="${contextPath}/manage/vendors/bootstrap-daterangepicker/daterangepicker-bs3.css">
    <!--Loading style-->
    <link type="text/css" rel="stylesheet" href="${contextPath}/css/themes/style1/orange-blue.css" class="default-style">
    <link type="text/css" rel="stylesheet" href="${contextPath}/css/themes/style1/orange-blue.css" id="theme-change" class="style-change color-change">
    <link type="text/css" rel="stylesheet" href="${contextPath}/css/style-responsive.css">
    
    <!--用于提醒-->
    <link type="text/css" rel="stylesheet" href="${contextPath}/manage/vendors/jquery-toastr/toastr.min.css">
    
    <!--用于分页-->
    <link rel="stylesheet" href="${contextPath}/manage/css/page/pagination.css" />
    <link rel="stylesheet" href="${contextPath}/manage/css/global.css">