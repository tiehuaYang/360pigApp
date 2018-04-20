<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
    <title>牧通进销存管理平台</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="keywords" content="牧通信息科技">
    <meta name="author" content="广州牧通信息科技有限公司">
	<meta name="Copyright" content="广州牧通信息科技有限公司版权所有" />
    <meta http-equiv="cache-control" content="no-cache">
    <link rel="shortcut icon" href="${contextPath}/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${contextPath}/favicon.ico" type="image/x-icon">
    
    <!--Loading bootstrap css-->
    <link type="text/css" rel="stylesheet" href="${contextPath}/vendors/font-awesome/css/font-awesome.min.css">
    <link type="text/css" rel="stylesheet" href="${contextPath}/vendors/bootstrap/css/bootstrap.min.css">
    <!--Loading style vendors-->
    <link type="text/css" rel="stylesheet" href="${contextPath}/vendors/animate.css/animate.css">
    <link type="text/css" rel="stylesheet" href="${contextPath}/vendors/iCheck/skins/all.css">
    <!--Loading style-->
    <link type="text/css" rel="stylesheet" href="${contextPath}/css/themes/style1/pink-blue.css" class="default-style">
    <link type="text/css" rel="stylesheet" href="${contextPath}/css/themes/style1/pink-blue.css" id="theme-change" class="style-change color-change">
    <link type="text/css" rel="stylesheet" href="${contextPath}/css/style-responsive.css">
    
    <!--用于提醒-->
    <link type="text/css" rel="stylesheet" href="${contextPath}/vendors/jquery-toastr/toastr.min.css">
    <link rel="shortcut icon" href="${contextPath}/favicon.ico">
    
    <style type="text/css">
    	@CHARSET "UTF-8";
		* {font-family: '微软雅黑';font-size: 12px;}
		body {padding: 0;margin: 0;}
    </style>
    
</head>

<body id="signup-page">
    <div class="page-form">
        <form id="signup-form" action="" class="form" method="post">
            <div class="header-content">
                <h1>注册会员</h1>
            </div>
            <div class="body-content">
                <div class="form-group">
                    <div class="input-icon right"><i class="fa fa-globe"></i>
                        <input type="text" placeholder="企业名称(必填)" name="companyName" class="form-control" value="${obj.companyProfile.companyName}">
                    </div>
                </div>
               
                <label class="radio-inline">请输入地址：</label>
                <div id="city_1" style="margin-bottom: 15px" class="row">
                    <div class="col-lg-6">
                        <label style="display: block" class="select">
                        <select  name="province" class="form-control prov"></select>
                    </label>
                    </div>
                    <div class="col-lg-6">
                        <label style="display: block" class="select">
                        <select name="city" class="form-control city" disabled="disabled"></select>
                    </label>
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-icon right"><i class="fa fa-map-marker"></i>
                        <input type="text" placeholder="地址" name="address" class="form-control"  value="${obj.companyProfile.address}">
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-icon right"><i class="fa fa-envelope"></i>
                        <input type="email" placeholder="企业邮箱" name="contactEmail" class="form-control"  value="${obj.companyProfile.contactEmail}">
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-icon right"><i class="fa fa-user"></i>
                        <input type="text" placeholder="联系人名称(必填)" name="contactName" class="form-control"  value="${obj.companyProfile.contactName}">
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-icon right"><i class="fa fa-phone"></i>
                        <input type="text" placeholder="联系电话(必填)" name="contactPhone" class="form-control"  value="${obj.companyProfile.contactPhone}">
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-icon right"><i class="fa fa-keyboard-o"></i>
                        <input id="loginAcount" type="text" placeholder="登录帐号" name="loginAcount"  value="${obj.loginAcount}" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-icon right"><i class="fa fa-key"></i>
                        <input id="password" type="password" placeholder="密码" name="password" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-icon right"><i class="fa fa-key"></i>
                        <input type="password" placeholder="请确认密码" name="passwordConfirm" class="form-control">
                    </div>
                </div>
                <hr>
                <div class="form-group">
                    <div class="checkbox-list">
                        <label>
                            <input id="terms" type="checkbox" name="terms">
                            &nbsp;我已经看过并同意<a href="#" data-hover="tooltip" title="Setting" data-toggle="modal" data-target="#services">《服务使用协议》</a>
                        </label>
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
                        	<button type="button" data-dismiss="modal" class="btn btn-primary" onclick="checkTerms();">我已知晓</button>
                        </div>
                    </div>
                </div>
            </div>
            <!--END MODAL CONFIG PORTLET-->
                <hr>
                <div class="form-group mbn">
                	<a href="${contextPath}/login" class="btn btn-warning"><i class="fa fa-chevron-circle-left"></i><strong>&nbsp;返回</strong></a>
                    <button type="submit" class="btn btn-info pull-right "><strong>提交</strong> &nbsp;
                        <i class="fa fa-chevron-circle-right"></i>
                    </button>
                </div>
            </div>
        </form>
    </div>

    <script src="${contextPath}/js/jquery-1.10.2.min.js"></script>
    <script src="${contextPath}/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="${contextPath}/js/jquery-ui.js"></script>
    <!--loading bootstrap js-->
    <script src="${contextPath}/vendors/bootstrap/js/bootstrap.min.js"></script>
    <script src="${contextPath}/vendors/bootstrap-hover-dropdown/bootstrap-hover-dropdown.js"></script>
    <script src="${contextPath}/vendors/jquery-validate/jquery.validate.min.js"></script>
    <script src="${contextPath}/js/html5shiv.js"></script>
    <script src="${contextPath}/js/respond.min.js"></script>
    <script src="${contextPath}/vendors/iCheck/icheck.min.js"></script>
    <script src="${contextPath}/vendors/iCheck/custom.min.js"></script>
   
    <script src="${contextPath}/js/citySelect/jquery.cityselect.js"></script>
    <!--用于消息推送 替代alert-->
    <script src="${contextPath}/vendors/jquery-toastr/toastr.min.js"></script>
    <script>
    $(function(){
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
        $('input[type="radio"]').iCheck({
            radioClass: 'icheckbox_minimal-blue',
            increaseArea: '20%' // optional
        });
        //END CHECKBOX & RADIO
        
        
$(function()
{
	jQuery.validator.addMethod("isMobile", function(value, element) {    
	      var length = value.length;    
	      return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(value));    
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
                	email:true,
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
                	required: '企业名称不能为空',
                	maxlength: '长度不能超过20个字符'
                },
                userType:
                {
                    required: '企业类别不能为空'
                },
                contactName:
                {
                    required: '联系人不能为空'
                },
                contactPhone:
                {
                    required: '联系方式不能为空',
                    isMobile: '请填写正确的手机号码'
                },
                contactEmail:
                {
                	email:'请输入正确的邮箱地址'
                },
                password:
                {
                    required: '请输入密码',
                    minlength:'请输入最少6位数的密码',
                    maxlength:'密码长度不超过20',
                },
                passwordConfirm:
                {
                    required: '请再一次确认您的密码',
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
            submitHandler: function(form) {
                $.ajax({
                    url: "${contextPath}/register",
                    type: "POST",
                    data: $('#signup-form').serialize(),
                    error: function(request) {
                        toastr['error']("Connection error", "");
                    },
                    dataType: "json",
                    success: function(data) {
                        if (data.result == 'OK') {
                            toastr['success']("注册成功!", "");
                        } else if (data.result != null && data.result == 'FAIL') {
                            toastr['error'](data.msg, "");
                        }
                    }
                });
            }
        });
});
		
    </script>
</body>

</html>