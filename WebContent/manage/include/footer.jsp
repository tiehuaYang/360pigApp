<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <style>
    .footer2 {
    padding:10px 0;
    width:100%;
    margin-top:-35px;
    position:relative;
    z-index:9999;
    }
    .footer3 {
    text-align:center;
    }
    </style>
    <script src="${contextPath}/manage/js/jquery-1.10.2.min.js"></script>
    <script src="${contextPath}/manage/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="${contextPath}/manage/js/jquery-ui.min.js"></script>
    <!--loading bootstrap js-->
    <script src="${contextPath}/manage/vendors/bootstrap/js/bootstrap.min.js"></script>
    <script src="${contextPath}/manage/js/html5shiv.js"></script>
    <script src="${contextPath}/manage/js/respond.min.js"></script>
    
    <!--用于菜单-->
    <script src="${contextPath}/manage/vendors/metisMenu/jquery.metisMenu.js"></script>
    <script src="${contextPath}/manage/vendors/bootstrap-hover-dropdown/bootstrap-hover-dropdown.js"></script>
    
    <!--用于保存风格-->
    <script src="${contextPath}/manage/vendors/jquery-cookie/jquery.cookie.js"></script>
    
    <!--CORE JAVASCRIPT-->
    <script src="${contextPath}/manage/js/main.js"></script>
    
    <!--用于显示加载情况-->
    <script src="${contextPath}/manage/vendors/jquery-pace/pace.min.js"></script>
    
    <!--用于消息推送 替代alert-->
    <script src="${contextPath}/manage/vendors/jquery-toastr/toastr.min.js"></script>
    
    
<script type="text/javascript">
	$(function() {
		var url = "${contextPath}/manage/updateMessage";
		common_ajax(url,
		function(data) {
			//console.log(data);
		});
		setTimeout(function() {
			$('#wrapper').css('position', 'relative');
		},
		500);
	});
</script>
<script>
    <!-- 侧边栏菜单鼠标点击事件 -->
	$("#side-menu>li>a").mouseover(function() {
		var children = $(this)[0].children;
		for(var i=0;i<children.length;i++){
			var hello = $(children[i]);
			$(children[i]).css("color", "#ffffff");
		}
	});
	$("#side-menu>li>a").click(function() {
		var children = $(this)[0].children;
		for(var i=0;i<children.length;i++){
			var hello = $(children[i]);
			$(children[i]).css("color", "#ffffff");
		}
	});
  	$("#side-menu>li>a").mouseout(function() {
		var children = $(this)[0].children;
		for(var i=0;i<children.length;i++){
			var hello = $(children[i]);
			$(children[i]).css("color", "#939393");
		}
	});  
  	
	/* $("#side-menu>li").mouseover(function() {
		$("#side-menu>li").css("color", "#52c8f4");
		var children = $(this)[0].children;
		for(var i=0;i<children.length;i++){
			var hello = $(children[i]);
			$(children[i]).css("color", "#424242");
		}
	}); */
	$("body").append("<div class='footer2'><div class='footer3'>&copy;Copyright 2014-2015 <strong>Mutoon</strong>, All rights reserved.</div></div>");
	
	/* $(".open").mouseout(function() {
		$(".open").css("background","#52c8f4");
	}); */
</script>
    