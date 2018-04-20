<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
 <!--LOADING STYLESHEET FOR PAGE-->
<link type="text/css" rel="stylesheet" href="${contextPath}/manage/vendors/jquery-tablesorter/themes/blue/style-custom.css"></head>
 <!--LOADING STYLESHEET FOR PAGE-->
 <link type="text/css" rel="stylesheet" href="vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.1.1.min.css">

<script type="text/javascript" src="${contextPath}/manage/js/ckeditor/ckeditor.js"></script>
<style>

/* div,ol,ul,label,a{padding: 0;border: 0;outline: 0;font-size: 80%;} */
#table-sticky-tab p{
	height:17px;
}

.quarantineCase-item{width:50%;float:left;position:relative;padding:15px 10px;}
.quarantineCase-item .state-error + em {position:absolute;left:80px;}
.quarantineCase:after {content:'';display:block;clear:both;}
#quarantineRemark,#immuneRemark {width:87%;height:70px;border:1px solid rgba(0,0,0,.1);}
.border1 {border:1px solid rgba(0,0,0,.1);}
.border2 {border-right:1px solid rgba(0,0,0,.1);}
.quarantineTable {width:83%;margin-left:13%;margin-top:20px;}
.quarantineTable th {text-align:center;}
.quarantineTable tr {height:35px;text-align:center;}
.border1 th,.border2 {color:#000;}
.saveBtn {width:70px;background-color:#52c8f4;border-color:#52c8f4;margin-right:22px;margin-bottom:20px;}
#calendar-plug {position:absolute;left:85%;top:38%}
#quarantineTime,#quarantineNum,#quarantineItems,#quarantineMode,#quarantineOfficer {width:70%;margin-left:25%;margin-top:-22px;} 
#immuneTime,#immuneNum,#immuneProject,#immuneMode,#immuneWorker,#vaccineDose,#vaccineName {width:70%;margin-left:25%;margin-top:-22px;} 
#negativeQuarantineNum {}

td .state-error + em,
.quarantineList td div.state-error {
display:inline-block;
}
.message-list1:after {content:'';display:block;clear:both;overflow:hidden;}
.message-list1 {position:absolute;left:75px;} 
.message-list1 ul li {list-style-type:disc !important;padding:2px;letter-spacing:2px;}

/* #quarantineForm {position:relative;}
.state-error + em {position:absolute;left:15%;margin-top:-2%;} */

.user-detail:after {content:'';display:block;clear:both;overflow:hidden;}
.user-detail li{list-style-type:disc !important;padding:2px;letter-spacing:2px;}
.user-detail {padding-top:15px;}
.bootstrap-select{width:70px !important;}
</style>
 
<body class = "${theme }" >
  <!--BEGIN MODAL CONFIG PORTLET-->
<div id="newUnit" class="modal fade" style="margin-top:3%;">
    <div class="modal-dialog">
	<form id="newUnitForm" class="form" method="post" action="">
	<input id="taskId" name="taskId" type="hidden" value=""/>
	<input id="acturyAmount" name="acturyAmount" type="hidden" value=""/>
	<input id="quarantineId" name="quarantineId" type="hidden" value=""/>
	     <div class="modal-content">
			<div class="modal-header">
				<button type="button" data-dismiss="modal" aria-hidden="true"
					class="close">&times;</button>
				<h4 class="modal-title" style="text-align:center;color:#000;font-size:16px;">检疫登记</h4>
			</div>
			<div class="modal-body">
				<div class="form" id="quarantineForm">
				    
				    <div class="quarantineCase">
					    <div class="quarantineCase-item">
					       <div class="caseLeft">
					            <label for="quarantineTime">检疫日期：</label>
					            <i class="fa fa-calendar" id="calendar-plug"></i>
					            <input id="quarantineTime" name="quarantineTime" type="text"
										class="form-control" readonly="readonly" placeholder="请选择检疫日期"/>
					        </div>
					    </div>
					    <div class="quarantineCase-item">    
					        <div class="caseRight">
					            <label for="quarantineMode">检疫方式：</label>
					            <select id="quarantineMode" name="quarantineMode" type="text"
									class="form-control">
									<option value="">请选择检疫方式</option>
									<option value="ELISA">ELISA</option>
									<option value="病毒中和实验">病毒中和实验</option>
									<option value="PCR">PCR</option>
									<option value="RT-PCR">RT-PCR</option>
									<option value="QPCR">QPCR</option>
								</select>
							</div>
					    </div>
				    </div>
					<div class="quarantineCase">
					    <div class="quarantineCase-item">
					        <div class="caseLeft">
					            <label for="quarantineNum">检疫头数：</label>
					            <input id="quarantineNum" name="quarantineNum" type="text" class="form-control" placeholder="请选择检疫头数"/>
					        </div>
					    </div>
					    <div class="quarantineCase-item">
					        <div class="caseRight">
					            <label for="quarantineOfficer">检疫员：</label>
					            <select id="quarantineOfficer" name="quarantineOfficer" type="text"
										class="form-control">
									<option value="">请选择检疫员</option>
									<c:forEach var="userVO" items="${obj.userList}" varStatus="status">
										<option value="${userVO.userName}">${userVO.userName}</option>
									</c:forEach>
								</select>
					        </div>
					     </div>
				    </div>
				    <div class="quarantineCase" style="width:100%;clear:both;margin-bottom:20px;">  
				        <div class="quarantineCase-item"> 
				        <div class="caseLeft">
				            <label for="quarantineItems">检疫项目：</label>
				            <select id="quarantineItems" name="quarantineItems" type="text"
								class="form-control">
								<option value=""><p>请选择检疫项目</p></option>
								<option value="猪瘟">猪瘟</option>
								<option value="蓝耳病">蓝耳病</option>
								<option value="伪狂犬病">伪狂犬病</option>
								<option value="伪狂犬病(野毒)">伪狂犬病(野毒)</option>
								<option value="口蹄疫">口蹄疫</option>
								<option value="圆环病毒病">圆环病毒病</option>
								<option value="流行性腹泻">流行性腹泻</option>
								<option value="传染性胃肠炎">传染性胃肠炎</option>
							</select>
				        </div>
				        </div>
				    </div>
				    </div>
				    <div class="form-group col-lg-12" style="margin-left:4%;">
						    <label for="remark" class="control-label" style="left:22px;margin-top:-120px;color:#000;">备注：</label>
						    <textarea id="quarantineRemark" name="remark"></textarea>
					</div>
					
					<div class="quarantineList">
					    <!-- <h4 class="listResult" style="color:#000;">检疫结果登记</h4> -->
					    <table class="quarantineTable">
					    <tr class="border1">
						<th class="border2">检疫结果</th>
						<th>检疫头数</th>
						</tr>
						<tr class="border1">
						<td class="border2">阴性</td>
						<td><div><input id="negativeQuarantineNum" name="negativeQuarantineNum" type="text"
								class="form-control" style="height:25px;margin:auto;"placeholder="请选择检疫头数"/></div></td>
						</tr>
						<tr class="border1">
						<td class="border2">阳性</td>
						<td><div><input id="positiveQuarantineNum" name="positiveQuarantineNum" type="text"
								class="form-control" style="height:25px;margin:auto;"placeholder="请选择检疫头数"/></div></td>
						</tr>
						<tr class="border1">
						<td class="border2">疑似</td>
						<td><div><input id="suspectedQuarantineNum" name="suspectedQuarantineNum" type="text"
								class="form-control" style="height:25px;margin:auto;"placeholder="请选择检疫头数"/></div></td>
						</tr>
						<tr class="border1">
						<td class="border2">无效</td>
						<td><div><input id="invalidQuarantineNum" name="invalidQuarantineNum" type="text"
								class="form-control" style="height:25px;margin-right:10px;"placeholder="请选择检疫头数"/></div></td>
						</tr>
						</table>	
					</div>
			</div>
			<div class="modal-footer" style="border:none !important;"> 
			    <button type="submit" class="btn btn-primary saveBtn" id="listMessage">保存</button>
			</div>
		 </div>
	</form>
	</div>
</div>

<!--END MODAL CONFIG PORTLET-->
  <!--BEGIN MODAL CONFIG PORTLET-->
<div id="newImmune" class="modal fade" style="margin-top:7%;">
	<div class="modal-dialog">
	<form id="newImmuneForm" class="form" method="post" action="">
	<input id="immuneTaskId" name="immuneTaskId" type="hidden" value=""/>
	<input id="immuneActuryAmount" name="immuneActuryAmount" type="hidden" value=""/>
	<input id="immuneId" name="immuneId" type="hidden" value=""/>
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" data-dismiss="modal" aria-hidden="true"
					class="close">&times;</button>
				<h4 class="modal-title" style="text-align:center;color:#000;font-size:16px;">免疫登记</h4>
			</div>
				<div class="modal-body">
					<div class="form">
						<br /> <br />
						<div class="quarantineCase" style="padding:10px;margin-top:-40px;">
							<div class="quarantineCase-item">
							<div class="caseLeft">
							<label for="immuneTime">免疫日期：</label>
							<i class="fa fa-calendar" style="position:absolute;right:11%;top:40%;"></i>
								<!--<input id="typeName" name="typeName" type="text"
									class="form-control" style="height:25px;margin-left:-15px;margin-top:-2px;"/> -->
									<input id="immuneTime" readonly="readonly" name="immuneTime" type="text"
																				placeholder="请选择日期" class="form-control"
																				value=""/>
							</div>
							</div>
							<div class="quarantineCase-item">
							<div class="caseRight">
							<label for="immuneNum">免疫头数：</label>
								<input id="immuneNum" name="immuneNum" type="text"
									class="form-control" placeholder="请选择检疫头数"/>
							</div>
							</div>
						</div>
						<br />
						<div class="quarantineCase" style="padding:10px;margin-top:-40px;">
							<div class="quarantineCase-item">
							<div class="caseLeft">
							<label for="immuneMode">免疫方式：</label>
								<select id="immuneMode" name="immuneMode" type="text"
									class="form-control">
									<option value="">请选择免疫方式</option>
									<option value="肌肉注射">肌肉注射</option>
									<option value="皮下注射">皮下注射</option>
									<option value="喷雾">喷雾</option>
									<option value="口服">口服</option>
									<option value="点眼">点眼</option>
									<option value="滴鼻">滴鼻</option>
									<option value="饮水">饮水</option>
									<option value="其他">其他</option>
								</select>
							</div>
							</div>
							
							<div class="quarantineCase-item">
							<div class="caseRight">
							<label for="immuneWorker">免疫员：</label>
								<select id="immuneWorker" name="immuneWorker" type="text"
									class="form-control">
									<option value=""><p>请选择免疫员</p></option>
									<c:forEach var="userVO" items="${obj.userList}" varStatus="status">
										<option value="${userVO.userName}">${userVO.userName}</option>
									</c:forEach>
								</select>
							</div>
							</div>
						</div>
						<br />
						<div class="quarantineCase"  style="padding:10px;margin-top:-40px;">
							<div class="quarantineCase-item">
							<div class="caseLeft">
						    <label for="vaccineDose">免疫剂量：</label>
								<input id="vaccineDose" name="vaccineDose" type="text"
									class="form-control" placeholder="请填写免疫剂量"/>
							</div>
							</div>
							<div class="quarantineCase-item">
							<div class="caseRight">
							<label for="vaccineName">疫苗名称：</label>
								<input id="vaccineName" name="vaccineName" type="text"
									class="form-control" placeholder="请填写疫苗名称"/>
							</div>
							</div>
						</div>
						<br />
						<div class="quarantineCase" style="width:100%;clear:both;padding:10px;">
							<div class="quarantineCase-item" style="margin-top:-35px;">
							<div class="caseLeft">
							<label for="immuneProject">免疫项目：</label>
								<select id="immuneProject" name="immuneProject" type="text"
									class="form-control">
									<option value=""><p>请选择免疫项目</p></option>
									<option value="猪瘟">猪瘟</option>
									<option value="细小">细小</option>
									<option value="转染性萎缩性鼻炎">转染性萎缩性鼻炎</option>
									<option value="伪狂犬病">伪狂犬病</option>
									<option value="流行性腹泻">流行性腹泻</option>
								</select>
							</div>
							</div>
						</div>
						<br/>
						<div class="form-group" style="margin-top:20px;">
						    <label for="immuneRemark" class="control-label col-md-2" style="left:22px;color:#000;">备注：</label>
						    <textarea id="immuneRemark" name="immuneRemark" style="width:80%;height:70px;border:1px solid rgba(0,0,0,.1);margin-left:-10px;"></textarea>
						</div>
					</div>
				</div>
				<div class="modal-footer" style="border:none !important;">
					<button type="submit" class="btn btn-primary f5"
						style="width:70px;background-color:#52c8f4;border-color:#52c8f4;margin-right:30px;margin-bottom:30px;">保存</button>
					<!-- <button type="button" data-dismiss="modal"
						class="btn btn-primary f5" style="background-color:#52c8f4;border-color:#52c8f4;border-radius:50px !important;-webkit-border-radius:50px !important;-moz-border-radius:50px !important;">保存并新增</button> -->
				</div>
		</div>
		</form>
	</div>
</div>
<!--END MODAL CONFIG PORTLET-->
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
                        <div class="page-title">养殖任务管理</div>
                    </div>
                    <ol class="breadcrumb page-breadcrumb">
                        <li><i class="fa fa-home"></i>&nbsp;<a href="index.jsp">首页</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li><a href="#">养殖任务</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li class="active">养殖任务详情 </li>
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
                                <li class="active"><a href="#table-sticky-tab" data-toggle="tab">养殖任务详情</a></li>
                            </ul>
                            <div id="tableadvancedTabContent" class="tab-content">
                                <div id="table-sticky-tab" class="tab-pane fade in active">
                                	<div class="row">
                                                <div class="col-md-4 blog-img">
                                                	<c:if test="${!empty obj.taskVO.picUrl}">
                                                		<img src="${QUPLOADIMG}${obj.taskVO.picUrl}" alt="" class="img-responsive" style="margin:0 auto;max-width: 50%;"/>
                                                	</c:if>
                                                </div>
                                                <div class="col-md-6">
                                                    	<div class="form-group">
	                                                         <label for="inputFirstName" class="col-md-3 control-label"><i class="fa fa-star-o fa-fw"></i>品类名称:</label>
	                                                         <div class="col-md-9">
	                                                             <p>${obj.taskVO.categoryName}</p>
	                                                         </div>
	                                                     </div>
	                                                     <div class="form-group">
	                                                         <label for="inputFirstName" class="col-md-3 control-label"><i class="fa fa-tags fa-fw"></i>任务批次:</label>
	                                                         <div class="col-md-9">
	                                                             <p class="">${obj.taskVO.batchNO}</p>
	                                                         </div>
	                                                     </div>
	                                                     <div class="form-group">
	                                                         <label for="inputFirstName" class="col-md-3 control-label"><i class="fa fa-user fa-fw"></i>负责栋舍:</label>
	                                                         <div class="col-md-9">
	                                                             <p class="">${obj.taskVO.farmPenVO.penName}</p>
	                                                         </div>
	                                                     </div>
	                                                     <div class="form-group">
	                                                         <label class="col-md-3 control-label"><i class="fa fa-calendar fa-fw"></i>开始日期：</label>
	                                                         <div class="col-md-9">
	                                                            
	                                                            <p class=""><fmt:formatDate value="${obj.taskVO.startDay}" pattern="yyyy-MM-dd"/></p>
	                                                         </div>
	                                                     </div>
	                                                     <div class="form-group">
	                                                         <label class="col-md-3 control-label"><i class="fa fa-calendar fa-fw"></i>结束日期：</label>
	                                                         <div class="col-md-9">
	                                                         	<p class=""><fmt:formatDate value="${obj.taskVO.endDay}" pattern="yyyy-MM-dd"/></p>
	                                                         </div>
	                                                     </div>
	                                                     <div class="form-group">
	                                                         <label class="col-md-3 control-label"><i class="fa fa-chain fa-fw"></i>批次数量：</label>
	                                                         <div class="col-md-9">
	                                                         	<p class="">目前${obj.taskVO.acturyAmount}只 &nbsp;(进苗数：${obj.taskVO.initAmount}只)</p>
	                                                         </div>
	                                                     </div>
	                                                     <div class="form-group">
	                                                         <label class="col-md-3 control-label"><i class="fa fa-exclamation-circle fa-fw" style="color: #d9534f;"></i>告警次数：</label>
	                                                         <div class="col-md-9">
	                                                         	<p class="">${obj.taskVO.errorCount}次</p>
	                                                         </div>
	                                                     </div>
	                                                     <div class="form-group">
	                                                         <label class="col-md-3 control-label"><i class="fa fa-signal fa-fw" style="color: #5cb85c;"></i>完成进度：</label>
	                                                         <div class="col-md-6">
	                                                         	<div id="center-text">
					                                                    <div class="progress">
					                                                        <div role="progressbar" aria-valuetransitiongoal="${obj.taskVO.finishPercent}" class="progress-bar progress-bar-danger two-sec-ease-in-out"></div>
					                                                    </div>
					                                                </div>
	                                                         </div>
	                                                     </div>
	                                                     </div>
	                                                     <div class="col-md-2">
		                                                     <div class="form-group">
		                                                         <div class="text-right ">
				                                                <button type="button" class="btn btn-green" onClick="ev_back()">返回</button>
				                                            </div>
			                                            </div>
                                                </div>
                                            </div>
                                	<hr/>
				                    <div class="row">
				                        <div class="col-md-12">
				                            <ul role="tablist" class="nav nav-tabs ul-edit">
				                                <li class="active"><a href="#one-column" role="tab" data-toggle="tab">子任务列表</a></li>
				                                <li><a href="#two-column" role="tab" data-toggle="tab">产物列表</a></li>
				                                <li><a href="#three-column" role="tab" data-toggle="tab">检疫登记</a></li>
				                                <li><a href="#four-column" role="tab" data-toggle="tab">免疫登记</a></li>
				                                <li><a href="#five-column" role="tab" data-toggle="tab">溯源二维码</a></li>
				                            </ul>
				                            <div class="tab-content tab-edit">
				                                <div id="one-column" class="tab-pane  fade in active">
				                                	<c:forEach var="subTaskVO" items="${obj.taskVO.subTaskList}" varStatus="status">
				                                		<div class="message-item 
				                                		<c:choose>
				                                         	<c:when test="${subTaskVO.isReport == 'Y'}">green</c:when>
				                                         	<c:otherwise>red</c:otherwise>
				                                         </c:choose> ">

					                                        <div class="message-item 
				                                		<c:choose>
				                                         	<c:when test="${subTaskVO.isReport == 'Y'}">green</c:when>
				                                         	<c:otherwise>red</c:otherwise>
				                                         </c:choose> " style="margin-left:0px;">
					                                        <div class="message-inner row${status.count }" style="margin-top:20px;height:${subTaskVO.itemList.size()*20+92}px;">
					                                        	<div style="margin-bottom:20px;">${subTaskVO.expectDate}<i class="fa fa-exclamation-circle fa-fw" style="color: #d9534f;margin-left:20px;"></i>出现告警</div>
					                                            
					                                            <%-- <div class="message-head clearfix">
					                                                <div class="avatar pull-left">
					                                                    <a><img src="${contextPath}/images/default_user.jpg" />
					                                                    </a>
					                                                </div>
					                                                <div class="user-detail" style="float:none !important;" id="user-detail">
					                                                	<c:forEach var="subItem" items="${subTaskVO.itemList}" varStatus="status1">
					                                                    	<ul <c:if test='${status1.count != 1}'>style='float:left'</c:if>>
					                                                       		<li><a>${subItem.operateVO.operateName}预计用量：${subItem.expectAmount}  ${subItem.operateVO.spec}</a></li>
					                                                       		<li><a>${subItem.operateVO.operateName}实际用量：<fmt:formatNumber type="number" value="${subItem.reportAmount/obj.taskVO.acturyAmount}" maxFractionDigits="2"/>${subItem.operateVO.spec}</a></li>
					                                                    	</ul>
					                                                    </c:forEach>
					                                                    <ul class="list2">
					                                                       <li><a>出现死淘:${subTaskVO.deadNum}</a></li>
					                                                       <li><a>死淘原因:${subTaskVO.deadReason}</a></li>
					                                                    </ul>
					                                                    <ul class="list3">
					                                                       <li><a>负责人员:${obj.taskVO.userName}</a></li>
					                                                       <li><a>备注：${subTaskVO.remark}</a></li>
					                                                    </ul>
					                                                </div>   
					                                            </div> --%>
					                                            
					                                            <div class="message-head clearfix">
					                                                <div class="avatar pull-left" style="margin-left:10px;">
					                                                    <a><img src="${contextPath}/images/default_user.jpg" />
					                                                    </a>
					                                                </div>
					                                                
					                                                <div class="message-list1">
<%-- 					                                                    <ul <c:if test='${status1.count != 1}'> style='float:left'</c:if>>
					                                                        <c:forEach var="itemList" items="${subTaskVO.itemList}">
					                                                        	<li style="display:inline;"><a>【${itemList.operateVO.operateName}】&nbsp;&nbsp;预计用量：${itemList.expectAmount}  ${itemList.operateVO.spec}</a></li>
					                                                        </c:forEach><br/>
					                                                        
					                                                        <c:forEach var="itemList" items="${subTaskVO.itemList}">
					                                                        	<li style="display:inline;"><a>【${itemList.operateVO.operateName}】&nbsp;&nbsp;实际用量：<fmt:formatNumber type="number" value="${itemList.reportAmount}" maxFractionDigits="2"/>  ${itemList.operateVO.spec}</a></li>
					                                                        </c:forEach>
					                                                    </ul> --%>
					                                                    
					                                                    <ul <c:if test='${status1.count != 1}'> style='float:left'</c:if>>
					                                                        <c:forEach var="itemList" items="${subTaskVO.itemList}">
					                                                        	<li style="display:block;"><a>【${itemList.operateVO.operateName}】(实际用量/预计用量)：(<fmt:formatNumber type="number" value="${itemList.reportAmount}" maxFractionDigits="2"/>/<fmt:formatNumber type="number" value="${itemList.expectAmount}" maxFractionDigits="2"/>)  ${itemList.operateVO.spec}</a></li>
					                                                        </c:forEach><br/>
					                                                    </ul>
					                                                    <ul style="float:left;"> 
					                                                        <li><a>出现死淘:${subTaskVO.deadNum}</a></li>
					                                                        <li><a>死淘原因:${subTaskVO.deadReason}</a></li>
					                                                    </ul>
					                                                    <ul style="float:left;">
					                                                        <li><a>负责栋舍:${obj.taskVO.farmPenVO.penName}</a></li>
					                                                        <li><a>备注：${subTaskVO.remark}</a></li>
					                                                    </ul>
					                                                </div>
					                                                <button  type="button" class="btn btn-primary" style="float:right;" onclick="editOriginsReportModal('row${status.count}')">编辑图文</button>
					                                            </div>
					                                            
					                                            <div class="originsReport" style="display:none">${subTaskVO.originsReportHTML}</div>
					                                            <div class="subTaskId" style="display:none">${subTaskVO.subTaskId}</div>
					                                            <div class="originsReportState" style="display:none">${subTaskVO.originsReportState}</div>
					                                        </div>
					                                      </div>   
					                                    </div>
				                                     </c:forEach>
				                                     <c:if test="${obj.pageCount > 1}">
														<div >
													      <ul class="pagination mtm mbm">
													         <c:if test="${obj.currentPage > 1}">
													           <li><a href="#" onclick="jumpPage('${obj.currentPage - 1}')" ></a></li>
													         </c:if>
															  <c:forEach begin="1" end="${obj.pageCount}" step="1" var="pageNum">
															     <li <c:if test="${obj.currentPage == pageNum}">class="active" </c:if>><a href="#" onclick="jumpPage('${pageNum}')" >${pageNum}</a></li>
															  </c:forEach>
															  <c:if test="${obj.currentPage < obj.pageCount}">
													            <li><a href="#" onclick="jumpPage('${obj.currentPage + 1}')" >></a></li>
													         </c:if>
														   </ul>
														</div>
													</c:if>
													<c:if test="${obj.pageCount <= 1}">
														<div >
													      <ul class="pagination mtm mbm">
														  	<li class="active" ><a href="#" onclick="jumpPage('1')" >1</a></li>
														   </ul>
														</div>
													</c:if>
				                            </div>
				                            
											<div id="two-column" class="tab-pane  fade">

												<div id="one-column" class="tab-pane  fade active in">
				                                	
				                                		<div class="message-item red">
				                                		<c:forEach  var="productVO" items="${obj.productList }" varStatus="status">
					                                        <div class="message-inner">
					                                            <div class="message-head clearfix"> 
					                                                <div class="user-detail">
					                                                    <%-- <ul>
					                                                       <li><a>产物:${productVO.productionVO.productName}</a></li>
					                                                       <li><a>备注：${productVO.remark}</a></li>
					                                                    </ul>
					                                                    <ul class="list4" style="margin-top:-45px;margin-left:10%;">
					                                                       <li><a>数量:${productVO.reportAmount}</a></li>
					                                                       <li style="list-style:none;margin-bottom:20px;"><a></a></li>
					                                                    </ul>
					                                                    <ul class="list5" style="margin-top:-58px;margin-left:20%;">
					                                                       <li><a>提交时间:${productVO.reportDate}</a></li>
					                                                       <li><a></a></li>
					                                                    </ul> --%>
					                                                    
					                                                    <ul style="float:left;">
					                                                       <li><a>产物:${productVO.productionVO.productName}</a></li>
					                                                       <li><a>备注：${productVO.remark}</a></li>
					                                                    </ul>
					                                                    <ul style="float:left;">
					                                                       <li><a>数量:${productVO.reportAmount}</a></li>
					                                                       <li><a></a></li>
					                                                    </ul>
					                                                    <ul style="float:left;">
					                                                       <li><a>提交时间:${productVO.reportDate}</a></li>
					                                                       <li><a></a></li>
					                                                    </ul>
					                                                </div> 
					                                            </div>
					                                            
					                                            <div class="qa-message-content">
					                                            </div>
					                                        </div>
					                                        </c:forEach>
					                                        <!-- <div class="message-item red" style="margin-left:0px;">
					                                        <div class="message-inner" style="margin-top:20px;">
					                                            <div class="message-head clearfix">
					                                                <div class="user-detail">
					                                                    <ul>
					                                                       <li><a>产物:鸡蛋</a></li>
					                                                       <li><a>备注：无备注</a></li>
					                                                    </ul>
					                                                    <ul class="list4">
					                                                       <li><a>数量:1210</a></li>
					                                                       <li style="list-style:none;margin-bottom:30px;"><a></a></li>
					                                                    </ul>
					                                                    <ul class="list5">
					                                                       <li><a>提交时间:20170830</a></li>
					                                                       <li style="list-style:none;margin-bottom:20px;"><a></a></li>
					                                                    </ul>
					                                                </div>
					                                            </div>
					                                            <div class="qa-message-content">	
					                                            </div>
					                                        </div>
					                                      </div>  -->
					                                      <!-- <div class="message-item red" style="margin-left:0px;">
					                                        <div class="message-inner" style="margin-top:20px;">
					                                            <div class="message-head clearfix">
					                                                <div class="user-detail">
					                                                    <ul>
					                                                       <li><a>产物:鸡蛋</a></li>
					                                                       <li><a>备注：无备注</a></li>
					                                                    </ul>
					                                                    <ul class="list4">
					                                                       <li><a>数量:1210</a></li>
					                                                       <li style="list-style:none;margin-bottom:30px;"><a></a></li>
					                                                    </ul>
					                                                    <ul class="list5">
					                                                       <li><a>提交时间:20170830</a></li>
					                                                       <li style="list-style:none;margin-bottom:20px;"><a></a></li>
					                                                    </ul>
					                                                </div>
					                                            </div>
					                                            <div class="qa-message-content">	
					                                            </div>
					                                        </div>
					                                      </div> -->
					                                    </div>
														<div>
													      <ul class="pagination mtm mbm">
														  	<li class="active"><a href="#" onclick="jumpPage('1')">1</a></li>
														   </ul>
														</div>
													
				                            </div>
											</div>
											<div id="three-column" class="tab-pane fade">
												<table class="table table-hover table-striped table-bordered table-advanced tablesorter tb-sticky-header">
		                                                <thead class="success">
		                                                    <tr>
		                                                        <th><input type="checkbox"/></th>
		                                                        <th>检疫单号</th>
		                                                        <th>检疫日期</th>
		                                                        <th>检疫头数</th>
		                                                        <th>检疫项目</th>
		                                                        <th>检疫方式</th>
		                                                        <th>阳性头数</th>
		                                                        <th>阴性头数</th>
		                                                        <th>疑似头数</th>
		                                                        <th>无效头数</th>
		                                                        <th>检疫员</th>
		                                                        <th>操作</th>
		                                                    </tr>
		                                                </thead>
		                                                <tbody class="twolist">
		                                                	<c:forEach var="quarantineVO" items="${obj.taskVO.quarantineList}" varStatus="status">
			                                                    <tr>
			                                                        <td><input type="checkbox"/></td>
			                                                        <td>${quarantineVO.quarantineCode}</td>
			                                                        <td id='quarantineTime${status.count}'><fmt:formatDate value="${quarantineVO.quarantineTime}" pattern="yyyy-MM-dd"/></td>
			                                                        <td>${quarantineVO.quarantineNum}</td>
			                                                        <td>${quarantineVO.quarantineItems}</td>
			                                                        <td>${quarantineVO.quarantineMode}</td>
			                                                        <td>${quarantineVO.positiveQuarantineNum}</td>
			                                                        <td>${quarantineVO.negativeQuarantineNum}</td>
			                                                        <td>${quarantineVO.suspectedQuarantineNum}</td>
			                                                        <td>${quarantineVO.invalidQuarantineNum}</td>
			                                                        <td>${quarantineVO.quarantineOfficer}</td>
			                                                        <td><a href="#" data-toggle="modal" data-target="#newUnit" data-original-title="检疫登记" onclick="transmissionQuarantine('${quarantineVO.taskId}','${quarantineVO.quarantineId}','${status.count}','${quarantineVO.quarantineNum}','${quarantineVO.quarantineItems}','${quarantineVO.quarantineMode}','${quarantineVO.positiveQuarantineNum}','${quarantineVO.negativeQuarantineNum}','${quarantineVO.suspectedQuarantineNum}','${quarantineVO.invalidQuarantineNum}','${quarantineVO.quarantineOfficer}','${quarantineVO.quarantineOfficer}','${obj.taskVO.acturyAmount}','${quarantineVO.remark}')"><strong>编辑</strong></a> <a href="#" onclick="deleteQuarantine('${quarantineVO.quarantineId}')">删除</a></td>
			                                                    </tr>
		                                                    </c:forEach>
		                                                </tbody>
		                                            </table>
											</div>
											<div id="four-column" class="tab-pane  fade">
												<table class="table table-hover table-striped table-bordered table-advanced tablesorter tb-sticky-header">
		                                                <thead class="success">
		                                                    <tr>
		                                                        <th><input type="checkbox"/></th>
		                                                        <th>免疫单号</th>
		                                                        <th>免疫日期</th>
		                                                        <th>免疫头数</th>
		                                                        <th>免疫项目</th>
		                                                        <th>免疫方式</th>
		                                                        <th>疫苗名称</th>
		                                                        <th>免疫剂量</th>
		                                                        <th>检疫员</th>
		                                                        <th>操作</th>
		                                                    </tr>
		                                                </thead>
		                                                <tbody class="twolist">
		                                                	<c:forEach var="immuneVO" items="${obj.taskVO.immuneList}" varStatus="status">
			                                                    <tr>
			                                                        <td><input type="checkbox"/></td>
			                                                        <td>${immuneVO.immuneCode}</td>
			                                                        <td id='immuneTime${status.count}'><fmt:formatDate value="${immuneVO.immuneTime}" pattern="yyyy-MM-dd"/></td>
			                                                        <td>${immuneVO.immuneNum}</td>
			                                                        <td>${immuneVO.immuneProject}</td>
			                                                        <td>${immuneVO.immuneMode}</td>
			                                                        <td>${immuneVO.vaccineName}</td>
			                                                        <td>${immuneVO.vaccineDose}</td>
			                                                        <td>${immuneVO.immuneWorker}</td>
			                                                        <td><a href="#" data-toggle="modal" data-target="#newImmune" data-original-title="检疫登记" onclick="transmissionImmune('${immuneVO.immuneTaskId}','${immuneVO.immuneId}','${status.count}','${immuneVO.immuneNum}','${immuneVO.immuneProject}','${immuneVO.immuneMode}','${immuneVO.vaccineName}','${immuneVO.vaccineDose}','${immuneVO.immuneWorker}','${obj.taskVO.acturyAmount}','${quarantineVO.immuneRemark}')"><strong>编辑</strong></a> <a href="#" onclick="deleteImmune('${immuneVO.immuneId}')">删除</a></td>
			                                                    </tr>
		                                                    </c:forEach>
		                                                </tbody>
		                                            </table>
											</div>
											
											
											<div id="five-column" class="tab-pane  fade">
												内部：<img style="margin-right:50px;" src="${QOQRCODE}${obj.taskVO.inOQRCodePath }"/>
												外部：<img src="${QOQRCODE}${obj.taskVO.outOQRCodePath }"/>
											</div>
				                    </div>
				                </div>
				            </div>
				          </div>
				        </div>
				      </div>


            <!-- 模态框 -->
            <div class="modal fade" id="richTextModal" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
			    <div class="modal-dialog" style="width: 75%;max-width: 1000px;">
			        <div class="modal-content">
			            <div class="modal-header">
			                <h4 class="modal-title" id="myModalLabel">添加图文信息</h4>
			                <div class="subTaskId" style="display:none;"></div>
			            </div>
			            <div class="modal-body">
			            	<div class="" style="min-height: 450px;">
								<textarea class="ckeditor" cols="100" id="richText" name="richText" rows="15"></textarea>
								<script type="text/javascript">
								CKEDITOR.replace( 'richText',
								        {
								             toolbar :
								             [
								                ['Source','Bold','Italic','Underline'],
								                ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
								                ['Link','Unlink'],
								                ['Image'],
								                ['FontSize'],
								                ['TextColor']
								             ],
								            height: 380
								        }
								    );
								</script>
							</div>
			            </div>
			            <div class="modal-footer">
			            	<div style="float:left;'">
			                	开启关闭农户的图文编辑功能
			                	<select id="originsReportState" class="form-control selectpicker"  name="originsReportState"  data-live-search="false" data-size="5" style="width:50px;" onchange="editOriginsReportState(value);">
									<option value="1">开启</option>
									<option value="0">关闭</option>
								</select>
			                </div>
			                <button type="button" class="btn btn-default" onclick="hideModal('#richTextModal')">取消</button>
			                <button type="button" class="btn btn-primary" onclick="getRichTextData()">保存</button>
			            </div>
			        </div><!-- /.modal-content -->
			    </div><!-- /.modal -->
			</div>
		    <div id="richTextView" style="display:none;"></div>

            <!--BEGIN FOOTER-->
              <%@ include file="../include/footer.jsp"%>
              	<!-- 日历控件 -->
				<script type="text/javascript" src="${contextPath}/js/calendarJs/jedate.js"></script>
				<script src="${contextPath}/manage/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
				<script src="${contextPath}/vendors/jquery-validate/jquery.validate.min.js"></script>
				<script src="${contextPath}/manage/js/ui-progressbars.js"></script>
				<link rel="stylesheet" href="${contextPath}/vendors/bootstrap-select/new/bootstrap-select.min.css">
				<script src="${contextPath}/vendors/bootstrap-select/new/bootstrap-select.min.js"></script>
            <!--END FOOTER-->
            <!--END PAGE WRAPPER-->
            

            
    <!--LOADING SCRIPTS FOR PAGE-->
    <script type="text/javascript">
    //菜单初始化
    var type = '${obj.type}';
    if(type == 'his')
    	activeMenu("taskManage","taskUL","taskHisMenu");
    else if(type == 'manage')
    	activeMenu("taskManage","taskUL","taskMenu");
    else
    	activeMenu("taskManage","taskUL","taskPendingMenu");
    
   function ev_back(){
   	window.history.back();
   }
   
   function jumpPage(currentPage){
	   var taskId = '${obj.taskVO.id}';
	   var finishPercent = '${obj.taskVO.finishPercent}';
	   var url ='';
	   if(type == 'manage'){
	       url = "${contextPath}/manage/showTaskDetail?id="+taskId+"&currentPage="+currentPage +"&pageSize=10&finishPercent="+finishPercent+"&type=manage";
	   }else{
		   url = "${contextPath}/manage/showHisTaskDetail?id="+taskId+"&currentPage="+currentPage +"&pageSize=10";
	   }
   	window.location.href = url;
	}
   
   jeDate({
		dateCell:"#quarantineTime",
		format:"YYYY-MM-DD",
		isinitVal:false,
		isTime:true, //isClear:false,
		//minDate:"2014-09-19 00:00:00",
		okfun:function(val){
				//alert(val);
		}
   })
   
      jeDate({
		dateCell:"#immuneTime",
		format:"YYYY-MM-DD",
		isinitVal:false,
		isTime:true, //isClear:false,
		//minDate:"2014-09-19 00:00:00",
		okfun:function(val){
				//alert(val);
		}
   })
   
   $("#newUnitForm").validate(
        {
            // Rules for form validation
            rules:
            {
            	quarantineTime:
                {
                    required: true
                },
                quarantineMode:
                {
                    required: true
                },
                quarantineNum:
                {
                    required:true,
                	digits:true,
                	min:1
                },
                quarantineOfficer:
                {
                    required:true
                },
                quarantineItems:
                {
                	required:true
                },
                negativeQuarantineNum:
                {
                	digits:true
                },
                positiveQuarantineNum:
                {
                	digits:true
                },
                suspectedQuarantineNum:
                {
                	digits:true
                },
                invalidQuarantineNum:
                {
                	digits:true
                }
            },

            // Messages for form validation
            messages:
            {
            	quarantineTime:
                {
                	required: '检疫日期不能为空'
                },
                quarantineMode:
                {
                    required: '检疫方式不能为空'
                },
                quarantineNum:
                {
                    required: '检疫头数不能为空',
                    digits: '检疫头数只能输入数字',
                    min: $.validator.format( "检疫头数不能小于等于零" )
                },
                quarantineOfficer:
                {
                    required: '检疫员不能为空'
                },
                quarantineItems:
                {
                	required: '检疫项目不能为空'
                },
                negativeQuarantineNum:
                {
                	digits: '(阴性)检疫头数只能输入数字'
                },
                positiveQuarantineNum:
                {
                	digits: '(阳性)检疫头数只能输入数字'
                },
                suspectedQuarantineNum:
                {
                	digits: '(疑似)检疫头数只能输入数字'
                },
                invalidQuarantineNum:
                {
                	digits: '(无效)检疫头数只能输入数字'
                }
            },

            // Do not change code below
            errorPlacement: function(error, element)
            {
                error.insertAfter(element.parent());
            },
            submitHandler:function(form){
            	var quarantineNum = $("#quarantineNum").val();
            	var acturyAmount = $("#acturyAmount").val();
            	if(parseInt(quarantineNum) > parseInt(acturyAmount)){
            		toastr['error']("检疫头数不能超过任务的实际养殖数", "");
            		return;
            	}
            	var negativeQuarantineNum = $("#negativeQuarantineNum").val();
            	var positiveQuarantineNum = $("#positiveQuarantineNum").val();
            	var suspectedQuarantineNum = $("#suspectedQuarantineNum").val();
            	var invalidQuarantineNum = $("#invalidQuarantineNum").val();
            	if(parseInt(quarantineNum) != parseInt(negativeQuarantineNum)+parseInt(positiveQuarantineNum)+parseInt(suspectedQuarantineNum)+parseInt(invalidQuarantineNum)){
            		toastr['error']("检疫结果总头数与检疫头数不相等", "");
            		return;
            	}
            	
            	$.ajax({
                    url : "${contextPath}/manage/saveQuarantine",
                    type: "POST",
                    data:$('#newUnitForm').serialize(),
                    error: function(request) {
                   	 toastr['error']("Connection error", "");
                    },
                    dataType:"json",
                    success: function(data) {
	                   	if(data.result=='OK'){
	                  		  toastr['success'](data.msg, "");
	                  	        setTimeout(function(){
	                  	        	window.location.reload();
	                  	        },1000);
	                  	}
	                  	else if(data.result != null && data.result == 'FAIL'){
	                  		toastr['error'](data.msg, "");
	                  	}
                    }
                });
            }
        });
   
   function transmissionQuarantine(taskId,quarantineId,jilvshu,quarantineNum,quarantineItems,quarantineMode,positiveQuarantineNum,negativeQuarantineNum,suspectedQuarantineNum,invalidQuarantineNum,quarantineOfficer,acturyAmount,remark){
   		$("#taskId").val(taskId);
   		$("#quarantineId").val(quarantineId);
   		$("#quarantineTime").val($("#quarantineTime"+jilvshu).html());
   		$("#quarantineNum").val(quarantineNum);
   		$("#quarantineItems").val(quarantineItems);
   		$("#quarantineMode").val(quarantineMode);
   		$("#positiveQuarantineNum").val(positiveQuarantineNum);
   		$("#negativeQuarantineNum").val(negativeQuarantineNum);
   		$("#suspectedQuarantineNum").val(suspectedQuarantineNum);
   		$("#invalidQuarantineNum").val(invalidQuarantineNum);
   		$("#quarantineOfficer").val(quarantineOfficer);
   		$("#acturyAmount").val(acturyAmount);
   		$("#remark").val(remark);
   }
   
   function deleteQuarantine(quarantineId){
	   $.ajax({
           url : "${contextPath}/manage/deleteQuarantine",
           type: "POST",
           data:{"quarantineId":quarantineId},
           error: function(request) {
          	 toastr['error']("Connection error", "");
           },
           dataType:"json",
           success: function(data) {
          	 if(data.result=='OK'){
         		  toastr['success'](data.msg, "");
         	        setTimeout(function(){
         	        	window.location.reload();
         	        },1000);
         	}
         	else if(data.result != null && data.result == 'FAIL'){
         		toastr['error'](data.msg, "");
         	}
           }
       });
   }
   
   function deleteImmune(immuneId){
	   $.ajax({
           url : "${contextPath}/manage/deleteImmune",
           type: "POST",
           data:{"immuneId":immuneId},
           error: function(request) {
          	 toastr['error']("Connection error", "");
           },
           dataType:"json",
           success: function(data) {
          	 if(data.result=='OK'){
         		  toastr['success'](data.msg, "");
         	        setTimeout(function(){
         	        	window.location.reload();
         	        },1000);
         	}
         	else if(data.result != null && data.result == 'FAIL'){
         		toastr['error'](data.msg, ""); 
         	}
           }
       });
   }
   
   function transmissionImmune(immuneTaskId,immuneId,jilvshu,immuneNum,immuneProject,immuneMode,vaccineName,vaccineDose,immuneWorker,immuneActuryAmount,immuneRemark){
  		$("#immuneTaskId").val(immuneTaskId);
  		$("#immuneId").val(immuneId);
  		$("#immuneTime").val($("#immuneTime"+jilvshu).html());
  		$("#immuneNum").val(immuneNum);
  		$("#immuneProject").val(immuneProject);
  		$("#immuneMode").val(immuneMode);
  		$("#vaccineName").val(vaccineName);
  		$("#vaccineDose").val(vaccineDose);
  		$("#immuneWorker").val(immuneWorker);
  		$("#immuneActuryAmount").val(immuneActuryAmount);
  		$("#immuneRemark").val(immuneRemark);
  }
   
   $("#newImmuneForm").validate(
           {
               // Rules for form validation
               rules:
               {
               	immuneTime:
                   {
                       required: true
                   },
                   immuneMode:
                   {
                       required: true
                   },
                   immuneNum:
                   {
                       required:true,
                   	digits:true,
                   	min:1
                   },
                   immuneWorker:
                   {
                       required:true
                   },
                   immuneProject:
                   {
                   	required:true
                   },
                   vaccineName:
                   {
                   	required:true
                   },
                   vaccineDose:
                   {
                   	required:true
                   }
               },

               // Messages for form validation
               messages:
               {
               	immuneTime:
                   {
                   	required: '免疫日期不能为空'
                   },
                   immuneMode:
                   {
                       required: '免疫方式不能为空'
                   },
                   immuneNum:
                   {
                       required: '免疫头数不能为空',
                       digits: '免疫头数只能输入数字',
                       min: $.validator.format( "免疫头数不能小于等于零" )
                   },
                   immuneWorker:
                   {
                       required: '免疫员不能为空'
                   },
                   immuneProject:
                   {
                   	required: '免疫项目不能为空'
                   },
                   vaccineName:
                   {
                   	required: '疫苗名称不能为空'
                   },
                   vaccineDose:
                   {
                   	required: '免疫剂量不能为空'
                   }
               },

               // Do not change code below
               errorPlacement: function(error, element)
               {
                   error.insertAfter(element.parent());
               },
               submitHandler:function(form){
               	var immuneNum = $("#immuneNum").val();
               	var acturyAmount = $("#immuneActuryAmount").val();
               	if(parseInt(immuneNum) > parseInt(acturyAmount)){
               		toastr['error']("免疫头数不能超过任务的实际养殖数", "");
               		return;
               	}
               	
               	$.ajax({
                       url : "${contextPath}/manage/saveimmune",
                       type: "POST",
                       data:$('#newImmuneForm').serialize(),
                       error: function(request) {
                      	 toastr['error']("Connection error", "");
                       },
                       dataType:"json",
                       success: function(data) {
   	                   	if(data.result=='OK'){
   	                  		  toastr['success'](data.msg, "");
   	                  	        setTimeout(function(){
   	                  	       		window.location.reload();
   	                  	        },1000);
   	                  	}
   	                  	else if(data.result != null && data.result == 'FAIL'){
   	                  		toastr['error'](data.msg, "");
   	                  	}
                       }
                   });
               }
           });
   
   /* function submitImmuneSave(){
   	var immuneTime = $("#immuneTime").val();
   	var immuneWorker = $("#immuneWorker").val();
   	var immuneNum = $("#immuneNum").val();
   	var immuneProject = $("#immuneProject").val();
   	var immuneMode = $("#immuneMode").val();
   	var vaccineName = $("#vaccineName").val();
   	var vaccineDose = $("#vaccineDose").val();
   	var immuneActuryAmount = $("#immuneActuryAmount").val();
   	//var immuneRemarks = $("#immuneRemarks").val();
   	
   	if(!immuneTime){
   		toastr['error']("免疫日期不能为空", "");
   		return;
   	}
   	if(!immuneWorker){
   		toastr['error']("免疫员不能为空", "");
   		return;
   	}
   	if(!immuneNum){
   		toastr['error']("免疫头数不能为空", "");
   		return;
   	}
    var reg=/^\d$/;
    var result= reg.test(immuneNum);
    if(immuneNum!==""&&!result){
    	toastr['error']("请输入正确的数量", "");
        return;
    }
   	if(immuneNum > immuneActuryAmount){
   		toastr['error']("免疫头数不能不能大于任务总数", "");
   		return;
   	}
   	if(!immuneProject){
   		toastr['error']("免疫项目不能为空", "");
   		return;
   	}
   	if(!immuneMode){
   		toastr['error']("免疫方式不能为空", "");
   		return;
   	}
   	if(!vaccineName){
   		toastr['error']("疫苗名称不能为空", "");
   		return;
   	}
   	if(!vaccineDose){
   		toastr['error']("免疫剂量不能为空", "");
   		return;
   	}
   	
   	$.ajax({
           url : "${contextPath}/manage/saveImmune",
           type: "POST",
           data:$('#newImmuneForm').serialize(),
           error: function(request) {
          	 toastr['error']("Connection error", "");
           },
           dataType:"json",
           success: function(data) {
          	 if(data.result=='OK'){
         		  toastr['success'](data.msg, "");
         	        setTimeout(function(){
         	        	search();
         	        },1000);
         	}
         	else if(data.result != null && data.result == 'FAIL'){
         		toastr['error'](data.msg, "");
         	}
           }
       });
   } */

   function editOriginsReportModal(row){
	   $('#richTextView').html('');
	   var html = $("."+row+" div[class='originsReport']").html();
	   var subTaskId = $("."+row+" div[class='subTaskId']").html();
	   var originsReportState = $("."+row+" div[class='originsReportState']").html();
	   console.log(originsReportState);
	   //console.log(html);
       CKEDITOR.instances.richText.setData(html);
       $('#richTextModal .subTaskId').html(subTaskId);
       $("#originsReportState").val(originsReportState);
       $('#originsReportState').selectpicker('refresh');
       $('#richTextModal').modal('show');
   }
   
   function hideModal(id) {
		$(id).modal('hide');
	}
   
   function getRichTextData() {
		var richTextData = CKEDITOR.instances.richText.getData();
		var textVal = '';//储存app端需要的值
		textVal = richTextData.replace(/<\/?(br)[^>]*>/gi, '');
		textVal = textVal.replace(/&nbsp;/gi, '\s');
		textVal = textVal.replace(/<\/?[^>]*>/gi, '');
		$('#richTextView').html(richTextData);
		var img = $('#richTextView img');
		for(i=0,imgSrc=[];i<img.length;i++){
			imgSrc.push(img[i].src);
		}
		console.log(richTextData,textVal,imgSrc);
		var subTaskId = $('#richTextModal .subTaskId').html();
		var originsReportState = $('#originsReportState').val();
        $.ajax({
            type: 'POST',
            url: '${contextPath}/manage/editOriginsReport',
            data: {"originsReport":textVal,"originsReportHTML":richTextData,"imgList":imgSrc.join(","),"subTaskId":subTaskId,"originsReportState":originsReportState},
            async: false,
            dataType: 'json',
            success: function(result) {
                if (result.result == 'OK') {
                    toastr['success'](result.msg, "");
                    setTimeout(function() {
                    	window.location.reload();
                    }, 2000);
                } else {
                    toastr['error'](result.msg, "");
                }
            }
        });
		//$('#richTextModal').modal('hide');
	}
   
   //解决模态框中富文本插件弹出框无法聚焦输入的问提
/*    var $modalElement = this.$element;  
   $(document).on('focusin.modal', function (e) {  
       var $parent = $(e.target.parentNode);  
       if ($modalElement[0] !== e.target && !$modalElement.has(e.target).length  
               // add whatever conditions you need here:  
           &&  
           !$parent.hasClass('cke_dialog_ui_input_select') && !$parent.hasClass('cke_dialog_ui_input_text')) {  
           $modalElement.focus()  
       }  
   })  */
</script>
</body>

</html>