<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" import="com.pig.common.CommonConstants" %>
<%-- <c:set var="enterpriseLevel" value="<%= CommonConstants.USER.USER_LEVEL_ENTERPRISE %>"></c:set> --%>
<style>
/* #main { */
    /* margin-top:3%; */
}
/* #guide {
  font-size:14px;
  color:#FFFFFF;
}
#main {
    margin-top:3%;
}
#wrapper2 {
	position: relative;
    z-index: 1002;
    top:0;
    bottom: 0;
    left: 0;
    right: 0;
    margin: auto;
    width: 80%;
    height: 90%;
}
.leadPic {
    width:100%;
    height:100%;
} 
.btnclick {
	width:115px;
	height:35px;
	background-color:#6da2df;
	border:none;
	border-radius:20px;
	-webkit-border-radius:20px;
	-moz-border-radius:20px;
	position:absolute;
	right:9%;
	bottom:10%;
	cursor:pointer;
	color:#FFFFFF;
}  
.btnclick:visited,.btnclick:active {border:none !important;}
@media screen and (max-width:1367px) {
    #main {
        margin-top:10%;
    }
    .leadPic {
        width:100%;
        height:80%;
    }
}
.black_overlay {
    display: none;
    position: fixed;
    top: 0%;
    left: 0%;
    width: 100%;
    height:100%;
    background-color: black;
    z-index:1001;
    -moz-opacity: 0.8;
    background:rgba(0,0,0,.8);
    filter: alpha(opacity=88);
} */
#topbar .navbar-top-links li > a:hover, #topbar .navbar-top-links li > a:focus {
    background: #52c8f4 !important;
}
#leadBtn {border-radius:20px;-webkit-border-radius:20px;-moz-border-radius:20px;-o-border-radius:20px;}
@media screen and (min-width:1366px) {
    #leadBtn {position:absolute;right:14%;bottom:11%;}
}   
@media screen and (max-width:1367px) {
    #leadBtn {position:absolute;right:14%;bottom:9%;}
}   
</style>
  

    <div id="header-topbar-option-demo" class="page-header-topbar">
      <nav id="topbar" role="navigation" style="margin-bottom: 0; z-index: 2;" class="navbar navbar-default navbar-static-top">
        <div class="navbar-header">
          <button type="button" data-toggle="collapse" data-target=".sidebar-collapse" class="navbar-toggle"><span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
          </button><a id="logo" href="${contextPath}/manage/showIndex" class="navbar-brand"><span class="fa fa-rocket"></span> <span class="logo-text"></span><span style="display: none" class="logo-text-icon"></span></a> 
        </div>
        <div class="topbar-main">
          <a id="menu-toggle" href="#" class="hidden-xs"><i class="fa fa-bars"></i></a>
          <!--  
              <form id="topbar-search" action="#" method="GET" class="hidden-xs">
                  <div class="input-group">
                      <input type="text" placeholder="Search..." class="form-control" />
                      <span class="input-group-btn"><a href="javascript:;" class="btn submit"><i class="fa fa-search"></i></a></span>
                  </div>
              </form>
              -->
              <ul class="nav navbar navbar-top-links navbar-right mbn">
             <%-- <c:if test="${sessionScope.USERVO.level == 'ENTERPRISE'}"> --%> 	 
              		<%-- <li class="dropdown"><a data-hover="dropdown" href="#" class="dropdown-toggle"><i class="fa fa-bell fa-fw"></i><span class="badge badge-green">${sessionScope.ALARMCOUNT}</span></a> --%>
<%--               		<li class="dropdown"><a data-hover="dropdown" href="#" class="dropdown-toggle"><i class="fa fa-bell fa-fw"></i><c:if test="${sessionScope.ALARMCOUNT>0}"><span class="badge badge-green">${sessionScope.ALARMCOUNT}</span></c:if></a>
                      <ul class="dropdown-menu dropdown-messages">
                          <li>
                              <p>您有${sessionScope.ALARMCOUNT}条新的通知</p>
                          </li>
                          <li>
                              <div class="dropdown-slimscroll">
                                  <ul>
                                      <c:forEach var="alarmVO" items="${sessionScope.ALARMLIST}" varStatus="status">
		                              	<li>
		                              		<a href="${contextPath}/manage/showMsgList" target="_blank">
		                              		<span class="label label-blue"><i class="fa fa-exclamation-triangle"></i></span>
		                              		<span class="text-muted small">${alarmVO.categoryName}(${alarmVO.batchNO})产生告警</span>
		                              		<span class="pull-right text-muted small">${alarmVO.createDateStr}</span></a>
                                     	</li>
		                              </c:forEach>
                                  </ul>
                              </div>
                          </li>
                          <li class="last"><a href="${contextPath}/manage/showMsgList" class="text-right">查看所有告警</a>
                          </li>
                      </ul>
                  </li> --%>
                  <%-- </c:if> --%> 
                  <!-- 
                  <li class="dropdown"><a data-hover="dropdown" href="#" class="dropdown-toggle"><i class="fa fa-tasks fa-fw"></i><span class="badge badge-yellow">8</span></a>
                      <ul class="dropdown-menu dropdown-tasks">
                          <li>
                              <p>You have 14 pending tasks</p>
                          </li>
                          <li>
                              <div class="dropdown-slimscroll">
                                  <ul>
                                      <li><a href="page-blog-item.html" target="_blank"><span class="task-item">Fix the HTML code<small class="pull-right text-muted">40%</small></span><div class="progress progress-sm"><div role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%;" class="progress-bar progress-bar-orange"><span class="sr-only">40% Complete (success)</span></div></div></a>
                                      </li>
                                      <li>
                                          <a href="page-blog-item.html" target="_blank"> <span class="task-item">Make a wordpress theme<small class="pull-right text-muted">60%</small></span>
                                              <div class="progress progress-sm">
                                                  <div role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;" class="progress-bar progress-bar-blue"><span class="sr-only">60% Complete (success)</span>
                                                  </div>
                                              </div>
                                          </a>
                                      </li>
                                      <li>
                                          <a href="page-blog-item.html" target="_blank"> <span class="task-item">Convert PSD to HTML<small class="pull-right text-muted">55%</small></span>
                                              <div class="progress progress-sm">
                                                  <div role="progressbar" aria-valuenow="55" aria-valuemin="0" aria-valuemax="100" style="width: 55%;" class="progress-bar progress-bar-green"><span class="sr-only">55% Complete (success)</span>
                                                  </div>
                                              </div>
                                          </a>
                                      </li>
                                      <li>
                                          <a href="page-blog-item.html" target="_blank"> <span class="task-item">Convert HTML to Wordpress<small class="pull-right text-muted">78%</small></span>
                                              <div class="progress progress-sm">
                                                  <div role="progressbar" aria-valuenow="78" aria-valuemin="0" aria-valuemax="100" style="width: 78%;" class="progress-bar progress-bar-yellow"><span class="sr-only">78% Complete (success)</span>
                                                  </div>
                                              </div>
                                          </a>
                                      </li>
                                  </ul>
                              </div>
                          </li>
                          <li class="last"><a href="${contextPath}/manage/showTask" target="_blank">查看所有任务</a>
                          </li>
                      </ul>
                  </li>
              	 -->
               <!-- <a href = "javascript:void(0)" onclick = "document.getElementById('wrapper2');document.getElementById('fade').style.display='block'"><li id="guide">养殖指南</li></a> -->
<!--                <a href="javascript:void(0)" title="养殖指南" data-toggle="modal" data-target="#Breed_Guide">
               <li id="guide" style="font-size:14px;color:#FFF;">养殖指南</li></a>&nbsp; -->
               <li class="dropdown topbar-user">
                      <a data-hover="dropdown" href="#" class="dropdown-toggle">
                      	<c:choose>
		              	 	<c:when test="${!empty sessionScope.USERVO.companyProfile.pictureVO.uploadUrl}">
		              	 		<img src="${QUPLOADIMG}${sessionScope.USERVO.companyProfile.pictureVO.uploadUrl}" alt="" class="img-responsive img-circle" />
		              	 	</c:when>
		              	 	<c:otherwise>
		              	 			<img src="${contextPath}/images/default_user.jpg" alt="" class="img-responsive img-circle" />
		              	 	</c:otherwise>
		              	 </c:choose>
                      	&nbsp;<span class="hidden-xs">${sessionScope.USERVO.userName}</span>&nbsp;<span class="caret"></span>
                      </a>
                      <ul class="dropdown-menu dropdown-user pull-right">
                          <li>
                          	<a href="myProfile.jsp"><i class="fa fa-user"></i>个人资料</a>
                          </li>
                          <!-- 
                          <li><a href="page-calendar.html"><i class="fa fa-calendar"></i>My Calendar</a>
                          </li>
                          <li><a href="email-inbox.html"><i class="fa fa-envelope"></i>My Inbox<span class="badge badge-danger">3</span></a>
                          </li>
                          <li><a href="#"><i class="fa fa-tasks"></i>My Tasks<span class="badge badge-success">7</span></a>
                          </li>
                          <li class="divider"></li>
                          
                          <li><a href="extra-lock-screen.html"><i class="fa fa-lock"></i>Lock Screen</a>
                          </li>
                          -->
                         
<li>
							<a href="${contextPath}/user/logout"><i class="fa fa-key"></i>注销</a>
						</li>                      </ul>
                  </li> 
                  <!-- <li class="dropdown hidden-xs">
                      <a id="theme-setting" href="javascript:;" data-hover="dropdown" data-step="1" data-intro="&lt;b&gt;Header&lt;/b&gt;, &lt;b&gt;sidebar&lt;/b&gt;, &lt;b&gt;border style&lt;/b&gt; and &lt;b&gt;color&lt;/b&gt;, all of them can change for you to create the best" data-position="left" class="dropdown-toggle"><i class="fa fa-cogs"></i></a>
                      <ul class="dropdown-menu dropdown-theme-setting pull-right">
                          <li>
                          	  <br>
                              <h4 class="mtn">请选择主题颜色</h4>
                              <br>
                              <ul id="list-color" class="list-unstyled list-inline">
                                  <li data-color="green-dark" data-hover="tooltip" title="Green - Dark" class="green-dark"></li>
                                  <li data-color="red-dark" data-hover="tooltip" title="Red - Dark" class="red-dark"></li>
                                  <li data-color="pink-dark" data-hover="tooltip" title="Pink - Dark" class="pink-dark"></li>
                                  <li data-color="blue-dark" data-hover="tooltip" title="Blue - Dark" class="blue-dark"></li>
                                  <li data-color="yellow-dark" data-hover="tooltip" title="Yellow - Dark" class="yellow-dark"></li>
                                  <li data-color="green-grey" data-hover="tooltip" title="Green - Grey" class="green-grey"></li>
                                  <li data-color="red-grey" data-hover="tooltip" title="Red - Grey" class="red-grey"></li>
                                  <li data-color="pink-grey" data-hover="tooltip" title="Pink - Grey" class="pink-grey"></li>
                                  <li data-color="blue-grey" data-hover="tooltip" title="Blue - Grey" class="blue-grey"></li>
                                  <li data-color="yellow-grey" data-hover="tooltip" title="Yellow - Grey" class="yellow-grey"></li>
                                  <li data-color="yellow-green" data-hover="tooltip" title="Yellow - Green" class="yellow-green"></li>
                                  <li data-color="orange-grey" data-hover="tooltip" title="Orange - Grey" class="orange-grey"></li>
                                  <li data-color="pink-blue" data-hover="tooltip" title="Pink - Blue" class="pink-blue"></li>
                                  <li data-color="pink-violet" data-hover="tooltip" title="Pink - Violet" class="pink-violet active"></li>
                                  <li data-color="orange-violet" data-hover="tooltip" title="Orange - Violet" class="orange-violet"></li>
                                  <li data-color="pink-green" data-hover="tooltip" title="Pink - Green" class="pink-green"></li>
                                  <li data-color="pink-brown" data-hover="tooltip" title="Pink - Brown" class="pink-brown"></li>
                                  <li data-color="orange-blue" data-hover="tooltip" title="Orange - Blue" class="orange-blue"></li>
                                  <li data-color="yellow-blue" data-hover="tooltip" title="Yellow - Blue" class="yellow-blue"></li>
                                  <li data-color="green-blue" data-hover="tooltip" title="Green - Blue" class="green-blue"></li>
                              </ul>
                          <li>
							<h4 class="mtn">菜单主题</h4> <br> <select id="list-menu"
							class="form-control">
								<option value="sidebar-icons">大图标</option>
								<option value="sidebar-default">树形</option>
						</select>
                          </li>
                      </ul>
                  </li> -->
              </ul>
          </div>
      </nav>
  </div>
  <!-- <div id="fade" class="black_overlay">
  <div id="main">
	 <div id="wrapper2">
	    <a class="closebtn"></a>
		<img class="leadPic" src="images/handle.png" />
	    <input class="reat" type="checkbox" name="vehicle" value="Bike" />
	    <p class="tip">不再提醒</p>
	    <button class="btnclick" type="button" href = "javascript:void(0)" onclick = "document.getElementById('wrapper2').style.display='none';document.getElementById('fade').style.display='none'">进入使用</button>
	 </div>
  </div>
  </div>
 -->  
 
  <div id="Breed_Guide" class="modal fade">
        <img class="leadPic" src="images/handle.png" style="width:90%;height:95%;margin-left:5%;margin-top:2%;position:relative;"/>
        <button type="button" id="leadBtn" class="btn btn-primary">进入使用</button>
  </div>
  <script>
  /* $('.leadBtn').click(function(){
	  $('#Breed_Guide').modal("hide");
  }) */
  
  var aB = document.getElementById("leadBtn");
  var iD = document.getElementById("Breed_Guide");
  aB.onclick = function() {
	  $('#Breed_Guide').modal("hide");
  }
  //模态框显示时隐藏，隐藏时显示
  function show_Hidden(obj) {
	  if(obj.style.display=="block") {
		  obj.style.display='none';
	  } else {
		  obj.style.display='block';
	  }
  }
  
/*   window.onload = function() {
	  var olink = document.getElementById("guide");
	  var odiv = document.getElementById("Breed_Guide");
	  olink.onclick = function() {
		  show_Hidden(odiv);
		  return false;
	  }
	  
	  if (localStorage.pagecount == 1)
	  {
		  $('#Breed_Guide').hide();
	  }
	  else
	  { 
		 $('#Breed_Guide').show(); //最外层div
	  } 
	  $('.leadPic').on('click',function() {
		  localStorage.pagecount = 1;
	  });
  } */

  </script>
  
