<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.pig.authority.vo.UserVO"%>
<%@page import="com.pig.common.CommonConstants"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<title>农牧快车管理系统</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="author" content="广州牧通信息科技有限公司" />
<meta name="Copyright" content="广州牧通信息科技有限公司版权所有" />
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="Thu, 19 Nov 1900 08:52:00 GMT">
<!--Loading bootstrap css-->
<link type="text/css" rel="stylesheet"
	href="${contextPath}/vendors/font-awesome/css/font-awesome.min.css">
<link type="text/css" rel="stylesheet"
	href="${contextPath}/vendors/bootstrap/css/bootstrap.min.css">
<!--Loading style vendors-->
<link type="text/css" rel="stylesheet"
	href="${contextPath}/vendors/animate.css/animate.css">
<link type="text/css" rel="stylesheet"
	href="${contextPath}/vendors/iCheck/skins/all.css">
<!--Loading style-->
<link type="text/css" rel="stylesheet"
	href="${contextPath}/css/themes/style1/pink-blue.css"
	class="default-style">
<link type="text/css" rel="stylesheet" href="${contextPath}/css/themes/style1/pink-blue.css" id="theme-change"
	class="style-change color-change">
<link type="text/css" rel="stylesheet" href="${contextPath}/css/style-responsive.css">
<link type="text/css" rel="stylesheet" href="${contextPath}/vendors/jquery-toastr/toastr.min.css">
<link href="${contextPath}/css/animate.min.css" rel="stylesheet">
<link rel="shortcut icon" href="${contextPath}/favicon.ico">

<style>
	body{padding:0; margin: 0;overflow:hidden;background:#A7E2FC;}
	#signin-page{height: auto;}
	.login-card-box{position: absolute;top: 10%;bottom: 10%;left: 15%;right: 15%;
	background:url(${contextPath}/images/login-2-bg.png) no-repeat;
	background-size: 100% 100%;transition:background 1s;}
	.register-content{background:url(${contextPath}/images/login-2-bg.png) no-repeat;background-size: 100% 100%;}
	.passwordMiss-content{background:url(${contextPath}/images/login-2-bg.png) no-repeat;background-size: 100% 100%;}
	.downLoadApp-content{background:url(${contextPath}/images/appQrcode.png) no-repeat;background-size: 100% 100%;}
	.page-form-v2{position: absolute;right: 12%;top: 28%;width: 27%;height:45%}
	#loginForm,.login-form-body,#signup-form,.register-form-body{height: 100%;}
	.login-input-group{height:20%;border-bottom:1px solid #e5e5e5;background-color:transparent;}
	.h100p{height:100%;}
	#loginForm input{border:none;background:rgba(0,0,0,0)}
	#signup-form input{border:none;background:rgba(0,0,0,0)}
	#captcha_img{width:40%;border:1px solid #e5e5e5;position:absolute;height: 80%;top: 10%;right: 10px;}
	.register-btn,.lose-password{float:left;width:50%;font-size:14px;color:#808080;cursor:pointer;}
	.lose-password{text-align:right;}
	#login{display: block;margin: 25px auto 0 auto; width: 60%;height: 67%;border-radius: 25px !important;background: #6ed7cd;border-color: #6ed7cd;}
	.input-icon i.my-icon{margin: 0;height: 100%;width: 30px;}
	.my-icon.my-icon-user{background:url(${contextPath}/images/my_icon_user.png) 5px 50% no-repeat;}
	.my-icon.my-icon-key{background:url(${contextPath}/images/my_icon_key.png) 5px 50% no-repeat;}
	.my-icon.my-icon-pwd{background:url(${contextPath}/images/my_icon_pwd.png) 5px 50% no-repeat;}
	.my-icon.register-item1{background:url(${contextPath}/images/register-item1.png) 5px 50% no-repeat;}
	.my-icon.register-item2{background:url(${contextPath}/images/register-item2.png) 5px 50% no-repeat;}
	.my-icon.register-item3{background:url(${contextPath}/images/register-item3.png) 5px 50% no-repeat;}
	.my-icon.register-item4{background:url(${contextPath}/images/register-item4.png) 5px 50% no-repeat;}
	.my-icon.register-item5{background:url(${contextPath}/images/register-item5.png) 5px 50% no-repeat;}
	.my-icon.register-item6{background:url(${contextPath}/images/register-item6.png) 5px 50% no-repeat;}
	.my-icon.register-item7{background:url(${contextPath}/images/register-item7.png) 5px 50% no-repeat;}
	.tabs-btn-area{position: absolute;right: 12%;top: 8%;}
	.tabs-login{margin-right: 16px;cursor: pointer;color:#80cbc4;font-size: 16px;}
	.tabs-download{cursor: pointer;color:#80cbc4;font-size: 16px;}
	.tabs-btn-area a.active{border-bottom: 2px solid #ff9b7b;}
	a.tabs-login:hover,a.tabs-download:hover{color:#80cbc4}
	
	.login-content{z-index:-1;}
	.register-content{z-index:-2;}
	.passwordMiss-content{z-index:-2;}
	.downLoadApp-content{z-index:-2;}
	.zIndex0{z-index:0;}
	.zIndex-1{z-index:-1;}
	.page-form-register{top:13%;height:90%;}
	.page-form-passwordMiss{top:13%;height:90%;}
	.register-input-group{height:8%;border-bottom:1px solid #e5e5e5;position:relative;}
	.register-content label{margin:0}
	.passwordMiss-content label{margin:0}
	.register-btn-area .btn{background:#6ed7cd;border-radius: 25px !important;width: 80px;color:#fff;}
	.state-error + em{position: absolute;right: 17px;top: 25%;}
	.radio .state-error + em{position: absolute;left: 23px;top:65%;}
	.state-error input{border:none;background:rgba(0,0,0,0) !important;}
	.state-success .form-control{border-color: rgba(0,0,0,0) !important;}
	.state-success input,.state-success select{background: rgba(0,0,0,0) !important;}
	.haServicesView{background:url(${contextPath}/images/servicesViewBg.png) no-repeat;background-size: 100% 100%;}
	
	
    .registerWrite,.passwordMiss,.setupNew {position:relative;top:2%;width:100%;height:60%;background-color:transparent;margin:15% 5%;box-shadow:0px 15px 8px rgba(135,206,250,.3);-webkit-box-shadow:0px 15px 8px rgba(135,206,250,.3);
    -moz-box-shadow:0px 15px 8px rgba(135,206,250,.3);-o-box-shadow:0px 15px 8px rgba(135,206,250,.3);border-radius:10px;-webkit-border-radius:10px;-moz-border-radius:10px;-o-border-radius:10px;}
    .inputText1 {position:absolute;top:20%;left:0;}
    .inputText3 {position:absolute;top:34%;margin-left:10%;}
    .inputText4 {position:absolute;top:47%;margin-left:10%;}
    .writeNumber {border:none;margin-left:75%;margin-top:-3px;background-color:transparent;font-size:14px;}
    .EX {position:absolute;left:40%;font-weight:800;border-right:1px solid rgba(0,0,0,.3);padding-right:15px;}
    .ml {position:absolute;left:20%;}
    .mz {position:absolute;left:-5px;}
    .inputText2 {position:absolute;top:59%;left:11%;}
    .importCode {border:none;font-size:14px;}
    .nextStep,.nextStep2 {width:50%;height:35px;background-color:#62dccd;color:#fff;border:none;border-radius:20px;text-align:center;padding-top:8px;
    position:absolute;top:80%;left:25%;}
    .obtainCode {cursor:pointer;background-color:#62dccd;border-radius:2px;-webkit-border-radius:2px;-moz-border-radius:2px;-o-border-radius:2px;text-align:center;color:#fff;padding:5px;}
    .obtainCode:hover {color:#fff;}
    @media screen and (max-width:1367px) {
    .inputText1 {position:absolute;left:-4%;}
    #inputText2 {position:absolute;top:57%;}
    #inputText1 {position:absolute;left:-4%;top:23%;}
    #nextStep2 {position:absolute;left:25%;top:70%;}
    .foget-pw2 {position:absolute;top:2%;left:30% !important;}
    }
    .obtainCode[disabled="disabled"]{
	background:#eee;
	cursor: not-allowed;
	color: #424242;
	width:60%;
    }
    
    .newPassword {width:100%;}
    .pw1 {position:absolute;top:30%;left:20%;}
    .pw2 {position:absolute;top:45%;left:17%;margin-top:10px;}
    .newPasswordTxt,.confirmPasswordTxt {border-top:none;border-left:none;border-right:none;}
    .sumbitValidate {width:80px;heigth:25px;background-color:#52c8f4;}
    .SubmitValidation {width:50%;height:35px;background-color:#62dccd;color:#fff;border:none;border-radius:20px;text-align:center;padding-top:8px;
    position:absolute;top:70%;left:25%;}
    @media screen and (max-width:1367px) {.pw2 {position:absolute;top:45%;left:20%;margin-top:10px;}}
    .tip1,.tip2 {position:absolute;right:0;top:0;}
    .set-password,.sure-password {border:none;}
</style>
</head>

<body id="signin-page">
	<div class="login-card-box login-content zIndex0">
		<div class="tabs-btn-area">
<!-- 			<a class="tabs-login active" onclick="isInPage('.login-content')">登录</a>
			<a class="tabs-download" onclick="downloadApp()">客户端下载</a> -->
		</div>
		<div class="page-form-v2">
			<form id="loginForm"<%--  action="${contextPath}/user/login" --%> class="form">
				<div id="loginTip" style="position: absolute;top: -21px;right: 10px;color: #e74c3c;"></div>
				<div class="body-content login-form-body">
					<div class="login-input-group">
						<div class="input-icon left h100p">
							<i class="my-icon my-icon-user"></i> <input type="text" placeholder="请输入用户名"
								name="username" class="form-control h100p">
						</div>
					</div>
					<div class="login-input-group">
						<div class="input-icon left h100p">
							<i class="my-icon my-icon-pwd"></i> <input type="password"
								placeholder="请输入密码" name="password" class="form-control h100p">
						</div>
					</div>
					<div class="login-input-group">
						<div class="input-icon left h100p" style="padding: 0;padding-right: 40%;position:relative;">
							<i class="my-icon my-icon-key"></i>
							<input type="text" placeholder="请输入验证码" name="captcha"
							class="form-control col-md-7 h100p">
							<img id="captcha_img" onclick="next_captcha();return false;" src="${base}/captcha/next"/>
						</div>
					</div>
					<p style="margin:0;overflow:hidden;margin-top:15px;">
						<!-- <span class="register-btn" onclick="registerPage()">注册</span>
						<span class="lose-password" onclick="forgetPassword()">忘记密码？</span> -->
					</p>
					<div style="height:20%;">
						<button id="login" type="button" class="btn btn-success">登 录 </button>
					</div>
					<div class="clearfix"></div>
			
					<c:if test="${obj == 'ERROR'}">
						<div class="alert" style="width:250px;margin-top:10px;">登录失败，请输入正确的帐号密码</div>
					</c:if>
					</div>
				</form>
		</div>
	</div>
	<!-- 注册提示页面 -->
	<%-- <div class="login-card-box login-content">
		<div class="tabs-btn-area">
			<a class="tabs-login active" onclick="isInPage('.login-content')">登录</a>
			<a class="tabs-download" onclick="downloadApp()">客户端下载</a>
		</div>
		<div class="page-form-v2">
		    <div class="registerTip" style="width:400px;height:400px;background-color:#fff;border-radius:30px;box-shadow:0px 15px 8px rgba(135,206,250,.3);">
				<form id="loginForm" action="${contextPath}/user/login" class="form">
					<button id="register" type="submit" class="btn btn-defult k1" onclick="registerPage()" style="width:170px;height:45px;margin-left:30%;margin-top:25%;background-color:#6ed7cd !important;color:#fff !important;border-radius:80px !important;letter-spacing:1px;">注册一个新企业</button>
					<button id="login" type="submit" class="btn btn-defult k2" onclick="loginPage()" style="width:300px;height:45px;margin:30px auto;background-color:transparent !important;color:#80cbc4 !important;border-radius:80px !important;letter-spacing:1px;">管理员已经创建了我的企业，去登录</button>
					<p style="margin-top:25%;"><a style="color:#80cbc4 !important;text-decoration:underline;margin-left:50%;cursor:pointer;" class="returnLogin" onclick="loginPage()">返回</a></p>
				</form>
			</div>
		</div>
	</div> --%>
	
	<div class="login-card-box register-content">
		<div class="tabs-btn-area">
			<a class="tabs-login active" onclick="loginPage()">登录</a>
			<a class="tabs-download" onclick="downloadApp()">客户端下载</a>
		</div>
		<div class="page-form-v2 page-form-register">
			<!--注册页面|| -->
			<div class="registerWrite" style="display:none;">
			   <form>
			        <div id="signupTips" style="font-size:14px;color:red;position:absolute;right:0;"></div>
			        <div class="inputText1">
			            <div class="input-icon left h100p"><i class="my-icon my-icon-user ml"></i>
			            <span class="EX">+86</span><input class="writeNumber" type="text" name="accPhone" placeholder="请输入手机号" style="padding-left:0px !important;" />
			            </div>
			        </div>
			        <hr style="width:80%;position:absolute;top:22%;left:10%;"/>
			        
			        <div class="inputText3">
			            <label>设置密码：</label>
			            <input class="set-password" type="password" name="set-password" />
			        </div>
			        <hr style="width:80%;position:absolute;top:35%;left:10%;"/>
			        <div class="inputText4">
			            <label>确认密码：</label>
			            <input class="sure-password" type="password" name="sure-password" />
			        </div>
			        <hr style="width:80%;position:absolute;top:48%;left:10%;"/>
			        
			        <div class="inputText2">
			            <div class="input-icon left h100p"><i class="my-icon my-icon-pwd mz"></i>
			            <input class="importCode" type="text" name="captcha" placeholder="请输入验证码" style="margin-left:-10px;" />
			            </div>
			            
			        </div>
			        <a class="obtainCode" onclick="getVerificationCode()" style="width:30%;position:absolute;right:10%;top:57%;">获取验证码</a>
			        <hr style="width:80%;position:absolute;top:61%;left:10%;"/>
			        
			        <div class="form-group" style="position:absolute;top:70%;left:10%;">
	                    <div class="radio">
	                        <label>
	                            <input id="terms" type="checkbox" name="terms">
	                            &nbsp;我已经看过并同意<a href="#" data-hover="tooltip" title="Setting" data-toggle="modal" data-target="#services" style="color:#e74c3c">《 服务使用协议 》</a>
	                        </label>
	                    </div>
	                </div>
			        <a style="cursor:pointer;"><div class="nextStep" onclick="nextStep()"><strong>下一步</strong></div></a> 
			        <!-- <p style="position:absolute;bottom:9px;width: 100%;left: 0;text-align: center;">
	            		<a class="swiper-login-prev1" style="color:#81D5FA;text-decoration: underline;cursor: pointer;">返回</a>
	            	</p> -->
			   </form>
			</div>
			
	        <form id="signup-form" class="form user-infos" method="post" action="" style="display:none;">
	            <div class="body-content register-form-body">
	                <h2>完善企业信息</h2>
	                <div class="register-input-group">
	                    <div class="input-icon left h100p">
	                    	<i class="my-icon register-item1"></i>
	                        <input type="text" placeholder="公司名称" name="companyName" class="form-control h100p" value="${obj.companyProfile.companyName}">
	                    	<!-- <span class="_required">*</span>
	                    	<span class="glyphicon glyphicon-ok-sign tips-icon"></span> -->
	                    </div>
	                    
	                </div>
	                <div class="register-input-group">
		                <div class="input-icon left h100p">
		                	<i class="my-icon register-item2"></i>
			                <div id="city_1" style="padding-left:30px;display:flex;align-items:center;height:100%;" class="row">
			                    <div class="col-lg-6" style="padding:0 0 0 15px;">
			                        <label style="display: block" class="select">
			                        <select name="province" class="form-control prov"></select>
			                    </label>
			                    </div>
			                    <div class="col-lg-6">
			                        <label style="display: block" class="select">
			                        <select name="city" class="form-control city" disabled="disabled"></select>
			                    </label>
			                    </div>
			                </div>
		                </div>
	                </div>
	                <div class="register-input-group">
	                    <div class="input-icon left h100p">
	                    	<i class="my-icon register-item2"></i>
	                        <input type="text" placeholder="地址" name="address" class="form-control h100p"  value="${obj.companyProfile.address}">
	                    </div>
	                </div>
	                <div class="register-input-group">
	                    <div class="input-icon left h100p">
	                    	<i class="my-icon register-item3"></i>
	                        <input type="email" placeholder="企业邮箱" name="contactEmail" class="form-control h100p"  value="${obj.companyProfile.contactEmail}">
	                    </div>
	                </div>
	                <div class="register-input-group">
	                    <div class="input-icon left h100p">
	                    	<i class="my-icon register-item4"></i>
	                        <input type="text" placeholder="联系人名称" name="contactName" class="form-control h100p"  value="${obj.companyProfile.contactName}">
	                    </div>
	                </div>
	                <div class="register-input-group">
	                    <div class="input-icon left h100p">
	                    	<i class="my-icon register-item5"></i>
	                        <input type="text" placeholder="联系电话" name="contactPhone" class="form-control h100p"  value="${obj.companyProfile.contactPhone}">
	                    </div>
	                </div>
	                <%-- <div class="register-input-group">
	                    <div class="input-icon left h100p">
	                    	<i class="my-icon register-item4"></i>
	                        <input id="loginAcount" type="text" placeholder="登录帐号" name="loginAcount"  value="${obj.loginAcount}" class="form-control h100p">
	                    </div>
	                </div>
	                <div class="register-input-group">
	                    <div class="input-icon left h100p">
	                    	<i class="my-icon register-item6"></i>
	                        <input id="password" type="password" placeholder="密码" name="password" class="form-control h100p">
	                    </div>
	                </div>
	                <div class="register-input-group">
	                    <div class="input-icon left h100p">
	                    	<i class="my-icon register-item7"></i>
	                        <input type="password" placeholder="确认密码" name="passwordConfirm" class="form-control h100p">
	                    </div>
	                </div> --%>
	                <div class="form-group">
	                    <div class="radio" style="margin-top: 3%;">
	                        <label>
	                            <input id="terms" type="checkbox" name="terms">
	                            &nbsp;我已经看过并同意<a onclick="servicesView()" data-hover="tooltip" title="Setting" data-toggle="modal" data-target="#services" style="color:#e74c3c">《 服务使用协议 》</a>
	                        </label>
	                    </div>
	                </div>
	            <!--END MODAL CONFIG PORTLET-->
	                <div class="form-group mbn register-btn-area">
	                	<a class="btn swiper-login-prev" onclick="loginPage()">返回</a>
	                    <button id="register" type="submit" class="btn pull-right">注册</button>
	                </div>
	            </div>
	        </form>
  		</div>
	</div>
	
	<div class="login-card-box passwordMiss-content">
		<div class="tabs-btn-area">
			<a class="tabs-login active" onclick="loginPage()">登录</a>
			<a class="tabs-download" onclick="downloadApp()">客户端下载</a>
		</div>
		<div class="page-form-v2 page-form-passwordMiss">
			<!-- 忘记密码 -->
			<div class="passwordMiss" style="display:none;"> 
			    <form>
			        <h3 class="foget-pw2" style="position:absolute;top:2%;left:38%;">忘记密码</h3>
			        <div id="signupTips2" style="font-size:14px;color:red;position:absolute;right:0;"></div>
			        <div class="inputText1" id="inputText1" style="margin-top:15% !important;">
			            <div class="input-icon left h100p"><i class="my-icon my-icon-user ml"></i>
			            <span class="EX">+86</span><input class="writeNumber" type="text" name="accPhone2" placeholder="请输入手机号" style="padding-left:0px !important;" />
			            </div>
			        </div>
			        <hr style="width:80%;position:absolute;top:35%;left:10%;"/>
			        <div class="inputText2" id="inputText2" style="margin-top:-13%;">
			            <div class="input-icon left h100p"><i class="my-icon my-icon-pwd mz"></i>
			            <input class="importCode" type="text" name="captcha2" placeholder="请输入验证码" style="margin-left:-10px;" />
			            </div>
			            
			        </div>
			        <a class="obtainCode" onclick="getVerificationCode2()" style="width:30%;position:absolute;right:10%;top:46%;">获取验证码</a>
			        <hr style="width:80%;position:absolute;top:50%;left:10%;"/>
			        <a style="cursor:pointer;"><div class="nextStep2" id="nextStep2" onclick="nextStep2()" style="margin-top:-10%;"><strong>下一步</strong></div></a>
			        <!-- <p style="position:absolute;bottom:35px;width:100%;left:0;text-align: center;">
	            		<a class="swiper-login-prev2" onclick="backToLogin()" style="color:#81D5FA;text-decoration: underline;cursor: pointer;">返回</a>
	            	</p> -->
			   </form>
			</div>
			
			<!-- 设置新密码 -->
			<div class="setupNew" style="display:none;">
			    <form>
			        <div class="newPassword">
			            <div class="pw1"><span>新密码：</span><input class="newPasswordTxt" type="password" name="password" required="true" /></div><br />
			            <div class="pw2"><span>确认密码：</span><input class="confirmPasswordTxt" type="password" name="repassword" required="true" onblur="checkpas();"/></div><br />
			            <span class="tip1" style="font-size:12px;color:red;">密码长度必须为6-20位</span>
			            <span class="tip2" style="font-size:12px;color: red;">两次输入的密码不一致</span>
			            <a style="cursor:pointer;"><div class="SubmitValidation" onclick="SubmitValidation()"><strong>提交验证</strong></div></a>
			        </div>
			        <div class="confirmPassword"></div>
			    </form>
			</div>
  		</div>
	</div>
	
	
	<div class="login-card-box downLoadApp-content">
		<div class="tabs-btn-area">
			<a class="tabs-login" onclick="loginPage()">登录</a>
			<a class="tabs-download active" onclick="isInPage('.downLoadApp-content')">客户端下载</a>
		</div>
	</div>
	
	<!--BEGIN MODAL CONFIG PORTLET-->
    <div id="services" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" data-dismiss="modal" aria-hidden="true" class="close">&times;</button>
                    <h4 class="modal-title">服务使用协议</h4>
                </div>
                <div class="modal-body">
                    <p>用户在使用软件服务过程中，必须遵循以下原则：</p>
					<p>1、 不得违反中华人民共和国法律法规及相关国际条约或规则；</p>
					<p>2 、不得违反与网络服务、软件服务有关的网络协议、规定、程序及行业规则；
					<p>3 、不得违反法律法规、社会主义制度、国家利益、公民合法权益、公共秩序、社会道德风尚和信息真实性等“七条底线”要求；</p>
					<p>4 、不得进行任何可能对互联网或移动网正常运转造成不利影响的行为；</p>
					<p>5 、不得上传、展示或传播任何不实虚假、冒充性的、骚扰性的、中伤性的、攻击性的、辱骂性的、恐吓性的、种族歧视性的、诽谤诋毁、泄露隐私、成人情色、恶意抄袭的或其他任何非法的信息资料；</p>
					<p>6 、不得以任何方式侵犯其他任何人依法享有的专利权、著作权、商标权等知识产权，或姓名权、名称权、名誉权、荣誉权、肖像权、隐私权等人身权益，或其他任何合法权益；</p>
					<p>7、 不得以任何形式侵犯潜动公司的权利和/或利益或作出任何不利于潜动或软件公司的行为；</p>
					<p>8、 不得从事其他任何影响软件平台正常运营、破坏软件平台经营模式或其他有害软件平台生态的行为。</p>
					<p>9、不得为其他任何非法目的而使用软件服务。</p>
                </div>
                <div class="modal-footer center">
                    <button type="button" data-dismiss="modal" class="btn btn-primary" onclick="checkTerms();"
                    style="background-color: #81D5FA;border-color: #81D5FA;">我已知晓</button>
                </div>
           </div>
        </div>
    </div>
	
	
	<script src="${contextPath}/js/jquery-1.10.2.min.js"></script>
	<script src="${contextPath}/js/jquery-migrate-1.2.1.min.js"></script>
	<script src="${contextPath}/js/jquery-ui.min.js"></script>
	<!--loading bootstrap js-->
	<script src="${contextPath}/vendors/bootstrap/js/bootstrap.min.js"></script>
	<script src="${contextPath}/vendors/bootstrap-hover-dropdown/bootstrap-hover-dropdown.js"></script>
	<script src="${contextPath}/vendors/jquery-validate/jquery.validate.min.js"></script>
	<script src="${contextPath}/vendors/jquery-toastr/toastr.min.js"></script>
	<script src="${contextPath}/js/html5shiv.js"></script>
	<script src="${contextPath}/js/respond.min.js"></script>
	<script src="${contextPath}/vendors/iCheck/icheck.min.js"></script>
	<script src="${contextPath}/vendors/iCheck/custom.min.js"></script>
	<script src="${contextPath}/js/citySelect/jquery.cityselect.js"></script>

	<script>
        //BEGIN CHECKBOX & RADIO
        var secs = 60,getingVerificationCode = true;
        var signupLastSendData = {};
        $('input[type="checkbox"]').iCheck({
            checkboxClass: 'icheckbox_minimal-grey',
            increaseArea: '20%' // optional
        });
        $('input[type="radio"]').iCheck({
            radioClass: 'iradio_minimal-grey',
            increaseArea: '20%' // optional
        });
        //END CHECKBOX & RADIO
        
         function next_captcha() {
			$("#captcha_img").attr("src", "${contextPath}/captcha/next?_=" + new Date().getTime()); 
		 }
        
         $(function() {
             $("#login").click(function() {
            	 var userName = $('#loginForm input[name="username"]').val(),
	            	 passWord = $('#loginForm input[name="password"]').val(),
	            	 captcha = $('#loginForm input[name="captcha"]').val();
            	 if(userName == '') return $('#loginTip').html('请输入用户名');
            	 if(passWord == '') return $('#loginTip').html('请输入密码');
            	 if(captcha == '') return $('#loginTip').html('请输入验证码');
                 $.ajax({
                     url : "${contextPath}/user/login",
                     type: "POST",
                     data:$('#loginForm').serialize(),
                     error: function(request) {
                         alert("Connection error");
                     },
                     dataType:"json",
                     success: function(data) {
                         if (data && data.ok) {
                        	 if(data.root){
                        		var url = "${contextPath}/register.jsp";  
 	                         	window.location.href = url; 
                        	 }else{
	                            var url = "${contextPath}/manage/showIndex";  
	                         	window.location.href = url;
	                         	localStorage.loginUserName = userName;
	                         	localStorage.loginPassWord = passWord;
                        	 }
                         } else {
                        	 $('#loginTip').html(data.msg);
                         }
                     }
                 });
                 return false;
             });
            
         });
         $('input[name]').focus(function(){
        	 $('#loginTip').html('');
         });
         
         function downloadApp() {
        	 $('.zIndex-1').removeClass('zIndex-1');
        	 $('.zIndex0').addClass('zIndex-1');
        	 $('.zIndex0').removeClass('animated rollIn zIndex0');
        	 $('.downLoadApp-content').addClass('animated rollIn zIndex0');
        	 $('.register-content').removeClass('haServicesView');
        	 /* $('#signup-form').fadeOut('1000',function(){
        		 $('.registerWrite').fadeIn();
        	 });
        	 $('.setupNew').fadeOut('1000',function(){
        		 $('.passwordMiss').fadeIn();
        	 }); */
         }
         function loginPage() {
        	 $('.zIndex-1').removeClass('zIndex-1');
        	 $('.zIndex0').addClass('zIndex-1');
        	 $('.zIndex0').removeClass('animated rollIn zIndex0');
        	 $('.login-content').addClass('animated rollIn zIndex0');
        	 setTimeout(function(){
        	 	$('.login-content').removeClass('rollIn');
        	 }, 1000);
        	 $('.register-content').removeClass('haServicesView');
        	 
        	 /* $('#signup-form').fadeOut('1000',function(){
        		 $('.registerWrite').fadeIn();
        	 });
        	 $('.setupNew').fadeOut('1000',function(){
        		 $('.passwordMiss').fadeIn();
        	 }); */
             $('.login-content').show();
         }
         function isInPage(target) {
        	$(target).addClass('animated pulse');
        	setTimeout(function(){
       	        $(target).removeClass('pulse');
       	    }, 1000);
         }
         function registerPage() {
        	 $('.zIndex-1').removeClass('zIndex-1');
        	 $('.zIndex0').addClass('zIndex-1');
        	 $('.zIndex0').removeClass('animated rollIn zIndex0');
        	 $('.register-content').addClass('animated rollIn zIndex0');
        	 $('#signup-form').hide();
        	 $('.registerWrite').show();
        	 $('.registerTip').show();
         }
          
         function forgetPassword() {
        	 $('.zIndex-1').removeClass('zIndex-1');
        	 $('.zIndex0').addClass('zIndex-1');
        	 $('.zIndex0').removeClass('animated rollIn zIndex0');
        	 $('.passwordMiss-content').addClass('animated rollIn zIndex0');
        	 $('.setupNew').hide();
        	 $('.passwordMiss').show();
         } 
         function nextStep2() {
        	 /* $('.passwordMiss').fadeOut('fast',function() {
        		$(".setupNew").fadeIn(); 
        	 }); */
        	 
        	 var vCode = $('.passwordMiss input[name="captcha2"]').val();
         	 var phone = $('.passwordMiss input[name="accPhone2"]').val();
         	 var type = "forget";
         	 
         	 if(!/^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(17[0-9]{1}))+\d{8})$/.test(phone)){
        		 return $('#signupTips2').html('请输入正确的手机号');
        	 }
         	 if(!vCode || vCode == ''){
        		 return $('#signupTips2').html('请输入验证码');
        	 }
        	 else if(vCode.length<6){
        		 return $('#signupTips2').html('验证码输入错误');
        	 }
         	 $.ajax({
                 url : "${contextPath}/registerVCode",
                 type: "POST",
                 data: {vCode: vCode, phoneNum: phone,type:type},
                 error: function(request) {
                     alert("Connection error");
                 },
                 dataType:"json",
                 success: function(data) {
                	 if(data.result == 'FAIL'){
                		 return $('#signupTips2').html('验证码输入错误');
                	 }
                	 if(data.result == 'OK'){
                		 signupLastSendData.loginAcountForget = phone;
    	            	 $('.passwordMiss').fadeOut('fast',function(){
    	            		 $('.setupNew').fadeIn();
    	            	 });
                	 }
                 }
         	 });
         }
         
         function servicesView() {
        	 $('.register-content').addClass('haServicesView');
         }
         
         function nextStep() {
        	 
        	 var vCode = $('.registerWrite input[name="captcha"]').val();
         	 var phone = $('.registerWrite input[name="accPhone"]').val();
         	 var vpassword = $('.registerWrite input[name="set-password"]').val();
        	 var vpasswordConfirm = $('.registerWrite input[name="sure-password"]').val();
        	 var checkbox = $('#terms').attr('checked');
         	 
         	 if(!/^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(17[0-9]{1}))+\d{8})$/.test(phone)){
        		 return $('#signupTips').html('请输入正确的手机号');
        	 }
         	 if(!vpassword || vpassword == ''){
        		 return $('#signupTips').html('请设置密码');
        	 }
        	 if(vpassword.length<6 || vpassword.length>20){
        		 return $('#signupTips').html('密码长度为6~20之间');
        	 }
        	 if(vpassword != vpasswordConfirm){
        		 return $('#signupTips').html('两次输入密码不一致');
        	 }
         	 if(!vCode || vCode == ''){
        		 return $('#signupTips').html('请输入验证码');
        	 }
        	 else if(vCode.length<6){
        		 return $('#signupTips').html('验证码输入错误');
        	 }
         	 if(checkbox != 'checked'){
        		 return $('#signupTips').html('请阅读并同意服务协议');
        	 }
         	 $.ajax({
                 url : "${contextPath}/registerVCode",
                 type: "POST",
                 data: {vCode: vCode, phoneNum: phone,type: 'register'},
                 error: function(request) {
                     alert("Connection error");
                 },
                 dataType:"json",
                 success: function(data) {
                	 if(data.result == 'FAIL'){
                		 return $('#signupTips').html(data.msg);
                	 }
                	 if(data.result == 'OK'){
                		 signupLastSendData.loginAcount = phone;
                 		 signupLastSendData.password = vpassword;
                 		 $('.registerWrite').fadeOut('fast',function(){
    	            		 $('.page-form').addClass('page-form-info');
    	                     $('#signup-form h1').html('完善企业信息');
    	                     $('input[name="contactPhone"]').val(phone);
    	            		 $('.user-infos').fadeIn();
    	            	 });
                	 }
                 }
         	 });	 
         }
         
         
         function getVerificationCode() {
        	 var phone = $('.registerWrite input[name="accPhone"]').val();
        	 var type = "register";
        	 if(!/^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(17[0-9]{1}))+\d{8})$/.test(phone)){
        		 return $('#signupTips').html('请输入正确的手机号');
        	 }
        	 if(getingVerificationCode) {
        		 if(secs == 60) countBackwards();
        		 $.ajax ({
        			 url : "${contextPath}/registerVerificationCode",
        			 type:"POST",
        			 data:{phoneNum:phone,type:type},
        			 error: function(request) {
                         alert("Connection error");
                     },
                     dataType:"json",
                     success: function(data) {
                         if(data.result == "FAIL"){
                         	$('#signupTips').html(data.msg);
                     		secs = 0;
                         }
                         if(data.result == "OK"){
                         	beginCountBack = true;
                         }
                     }
        		 });
        	 }
         }
         function getVerificationCode2() {
        	 var phone = $('.passwordMiss input[name="accPhone2"]').val();
        	 var type = "forget";
        	 if(!/^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(17[0-9]{1}))+\d{8})$/.test(phone)){
        		 return $('#signupTips2').html('请输入正确的手机号');
        	 }
        	 if(getingVerificationCode) {
        		 if(secs == 60) countBackwards();
        		 $.ajax ({
        			 url : "${contextPath}/registerVerificationCode",
        			 type:"POST",
        			 data:{phoneNum:phone,type:type},
        			 error: function(request) {
                         alert("Connection error");
                     },
                     dataType:"json",
                     success: function(data) {
                         console.log(data);
                     }
        		 });
        	 }
         }
         
         
         function countBackwards() {
        	 secs--; 
        	 $('.obtainCode').html(secs+'秒后重新获取');
        	 $('.obtainCode').attr('disabled','disabled');
        	 getingVerificationCode = false;
        	 if(secs>0) {
        		 setTimeout(countBackwards,1000);
        	 }
        	 else {
        		 $('.obtainCode').html('获取验证码');
        		 $('.obtainCode').removeAttr('disabled');
        		 getingVerificationCode = true;
        		 secs = 60;
        	 }
         }
         $('.registerWrite input').on('focus',function(){
         	$('#signupTips').html('');
         });
         $('.passwordMiss input').on('focus',function(){
         	$('#signupTips2').html('');
         });
         
         $(".tip1").hide();
         $(".tip2").hide();
         /* function checkpas1() {
        	 var pas1 = $('.newPasswordTxt').val();
        	 var pas2 = $('.confirmPasswordTxt').val();
        	 if(pas1!=pas2 && pas2 != "") {
        		 $(".tip2").show(); 
        	 }
        	 else if(pas1.length<6 && pas1.length>12) {
        		 $(".tip1").show();
        		 $(".tip2").hide();
        	 }
        	 else {
        		 $(".tip2").hide(); 
        	 }
         } */
         function checkpas() {
        	 var pas1 = $('.newPasswordTxt').val();
        	 var pas2 = $('.confirmPasswordTxt').val();
        	 if(pas1 == '' || pas1.length<6 || pas1.length>20 ){
        		 $(".tip1").show();
        		 $(".tip2").hide();
        		 return;
        	 }
        	 if(pas1!=pas2) {
        		 $(".tip2").show();
        		 $(".tip1").hide();  /*tip1提示长度不对，tip2提示两次输入密码不一致 */
        	 }
        	 else {
        		 $(".tip2").hide();
        		 $(".tip1").hide();
        	 }
          }
         function SubmitValidation() {
        	 var pas3 = $('.newPasswordTxt').val();
        	 var pas4 = $('.confirmPasswordTxt').val();
        	 if(pas3!=pas4) {
        		 return $('.tip2').html('两次输入密码不一致！');
        	 }
        	 $.ajax({
                 url : "${contextPath}/forgetPasswd",
                 type: "POST",
                 data: {phoneNum: signupLastSendData.loginAcountForget,newpasswd: pas3},
                 error: function(request) {
                     alert("Connection error");
                 },
                 dataType:"json",
                 success: function(data) {
                     if(data.result == "FAIL"){
                     	$('#forgetTips').html(data.msg);
                 		secs = 0;
                     }
                     if(data.result == "OK"){
                     	$('#forgetTips').html(data.msg);
                     	toastr['success'](data.msg, "");
                     	loginPage();//切换到登录。
                     	setTimeout(function(){
                     		$('.signup-phone-number').show();
                     		$('.set-new-password').hide();
                     	},800);
                     }
                 }
             });
         }
    </script>
    <script>
    $(function(){
    	var ceshi = "${obj.userId}";
    	console.log(ceshi)
    	
    	if(ceshi != null){
    		
    	}
    	var result = "${obj.result}";
    	var message = "${obj.msg}";
    	if(result=='OK'){
    		  toastr['success']("注册成功!", "");
    	        setTimeout(function(){
    	        	window.location.href="${contextPath}/manage/showIndex";
    	        },1200);
    	}
    	else if(result != null && result == 'FAIL'){
    		toastr['error'](message, "");
    	}
    	
    	
    	var prov = '${obj.userVO.companyProfile.province}';
        var city = '${obj.userVO.companyProfile.city}';
          $("#city_1").citySelect({
          	prov:prov, city:city});
    });
    
    function checkTerms(){
    	$("#terms").iCheck('check');
    	$("input[name='type']").iCheck('check');
    }
    
    //BEGIN CHECKBOX & RADIO
    $('input[type="checkbox"]').iCheck({
        checkboxClass: 'icheckbox_minimal-blue',
        increaseArea: '50%' // optional
    });
        
        
$(function()
{
	jQuery.validator.addMethod("isMobile", function(value, element) {    
	      var length = value.length;    
	      return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(17[0-9]{1}))+\d{8})$/.test(value));    
	    }, "请正确填写您的手机号码。");
	
    // Validation
    $("#signup-form").validate(
        {
            // Rules for form validation
            rules:
            {
            	companyName:
                {
                    required: true,
                    maxlength: 60
                },
                userType:
                {
                    required: true
                },
                contactName:
                {
                    required:true,
                },
                contactPhone:
                {
                    required:true,
                    isMobile:true
                },
                contactEmail:
                {
                	email:false,
                },
                loginAcount:
                {
                    required: true,
                    minlength: 6,
                    maxlength: 20
                },
                password:
                {
                    required: true,
                    minlength: 6,
                    maxlength: 20
                },
                passwordConfirm:
                {
                    required: true,
                    minlength: 6,
                    maxlength: 20,
                    equalTo: '#password'
                },
                terms:
                {
                    required: true
                }
            },

            // Messages for form validation
            messages:
            {
            	companyName:
                {
                	required: '公司名称不能为空',
                	maxlength: '长度不能超过20个字符'
                },
                userType:
                {
                    required: '企业类别不能为空'
                },
                contactName:
                {
                    required: '联系人名称不能为空'
                },
                contactPhone:
                {
                    required: '联系电话不能为空',
                    isMobile: '请填写正确的电话号码'
                },
                contactEmail:
                {
                	email:'请输入正确的邮箱地址'
                },
                loginAcount:
                {
                    required: '登录账号不能为空',
                    minlength:'请输入最少6位数的账号',
                    maxlength:'账号长度不允许超过20',
                },
                password:
                {
                    required: '密码不能为空',
                    minlength:'请输入最少6位数的密码',
                    maxlength:'密码长度不超过20',
                },
                passwordConfirm:
                {
                    required: '请再一次输入您的密码',
                    minlength:'请输入最少6位数的密码',
                    maxlength:'密码长度不超过20',
                    equalTo: '和上一次密码不符，请再次确认密码'
                },
                terms:
                {
                    required: '申请注册前先阅读并同意《服务使用协议》'
                }
            },

            // Do not change code below
            errorPlacement: function(error, element)
            {
                error.insertAfter(element.parent());
            },
            submitHandler:function(form){
            	$.ajax({
                    url : "${contextPath}/register",
                    type: "POST",
                    data:$('#signup-form').serialize(),
                    error: function(request) {
                   	 toastr['error']("Connection error", "");
                    },
                    dataType:"json",
                    success: function(data) {
                   	 if(data.result=='OK'){
                  		  toastr['success']("注册成功! 正在自动登录...", "");
                  	        setTimeout(function(){
                  	        	window.location.href="${contextPath}/manage/showIndex";
                  	        },1200);
                  	}
                  	else if(data.result != null && data.result == 'FAIL'){
                  		toastr['error'](data.msg, "");
                  	}
                    }
                });
            }
        });
    
    if(localStorage.loginUserName)$('#loginForm input[name="username"]').val(localStorage.loginUserName+" ");
    setTimeout(function(){
    	if(localStorage.loginUserName)$('#loginForm input[name="username"]').val(localStorage.loginUserName);
    },100);
    
    if(localStorage.loginPassWord)$('#loginForm input[name="password"]').val(localStorage.loginPassWord);
}); 
    
		
    </script>
</body>
</html>